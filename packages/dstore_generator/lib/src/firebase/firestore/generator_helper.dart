import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/constants.dart';
import 'package:dstore_generator/src/firebase/firestore/ops/visitors.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

Future<String> generateFireStoreSchema(
    {required ClassElement element, required BuildStep buildStep}) async {
  var collectionModels = "";
  var collectionDsl = "";
  var collectionsRefs = "";
  var nestedObjects = "";
  element.fields.forEach((f) {
    final name = f.name.toLowerCase();
    if (name == "collections") {
      final ce = f.type.element as ClassElement;
      collectionModels = getModelsFromCollections(element: ce);
      collectionDsl = getDslFromCollections(element: ce);
      collectionsRefs = getDefaultCollectionRefs(element: ce);
    }
    if (name == "nestedObjects") {
      final ce = f.type.element as ClassElement;
      nestedObjects = getNestedObjects(element: ce);
    }
  });

  return """
    $collectionModels
    $collectionDsl 
    $collectionsRefs
    $nestedObjects
  """;
}

String getNestedObjects({required ClassElement element}) {
  return element.allSupertypes.where((e) => !e.isDartCoreObject).map((e) {
    final element = e.element;
    final className = element.name;
    final fields = ModelUtils.convertFieldElementsToFields(element.fields);
    var updateClass = "";
    if (!fields.every((f) => f.type.endsWith("?"))) {
      final updateFields = fields
          .map((f) => f.copyWith(type: f.type.addQuestionMarkAtEnd))
          .toList();
      updateClass = ModelUtils.createDefaultDartUpdateModelFromFeilds(
          fields: updateFields, className: className, isJsonSerializable: true);
    }

    return """
     ${ModelUtils.createDefaultDartModelFromFeilds(fields: fields, className: className, isJsonSerializable: true)}
     ${updateClass}
     """;
  }).join("\n");
}

String getDefaultCollectionRefs({required ClassElement element}) {
  final colRefs =
      element.allSupertypes.where((e) => !e.isDartCoreObject).map((e) {
    final element = e.element;
    final annot = element.annotationFromType(collection);
    if (annot == null) {
      throw ArgumentError.value(
          "All collection classes should add @collection annotation, there is no collection annotion for class ${element.name}");
    }
    final ca = getCollectionAnnotation(annot);
    final cname = ca.name;
    final cMethod = ca.sub ? "collectionGroup" : "collection";
    return """static final ${ca.name} = 
     FirebaseFireStore.instance.$cMethod('$cname').${getWithConverter(element.name)};
     """;
  }).join("\n");
  return """
     class CollectionRefs {
       $colRefs
     }
    """;
}

String getModelsFromCollections({required ClassElement element}) {
  return element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) => convertCollectionModelToDartModel(element: e.element))
      .join("\n");
}

String convertCollectionModelToDartModel({required ClassElement element}) {
  final className = element.name;
  final regularFields = <Field>[];
  final updateFields = <Field>[];
  element.fields
      .where((f) =>
          f.type.element?.annotationFromType(collection) ==
          null) // subcollections are shallow
      .forEach((f) {
    final name = f.name;
    final type = f.type;
    var typeStr = type.toString();
    final annotations = <String>[];
    final updateAnnotations = <String>[];
    if (typeStr.startsWith("FireStoreRef")) {
      if (!typeStr.startsWith("FireStoreRef<")) {
        throw ArgumentError.value(
            "FireStoreRef field ${name} should provide generic type of collection");
      }
      final cType =
          typeStr.substring(typeStr.indexOf("<") + 1).replaceAll(">", "");
      if (cType == "dynamic") {
        throw ArgumentError.value(
            "FireStoreRef fields should provide generic type of collection class not dynamic");
      }
      var op = "";
      var optional = "";
      if (typeStr.endsWith("?")) {
        op = "?";
        optional = "Optional";
      }
      final refName = "${cType}Reference";
      typeStr = "$refName$op";
      annotations.add(
          "@JsonKey(fromJson: ${refName}.fromJson${optional} ,toJson: ${refName}.toJson$optional)");
      updateAnnotations.add(
          "@JsonKey(fromJson: ${refName}.fromJsonOptional ,toJson: ${refName}.toJsonOptional)");
    }
    final rf = Field(
        name: name,
        type: typeStr,
        isOptional: typeStr.endsWith("?"),
        annotations: annotations);
    regularFields.add(rf);
    updateFields.add(rf.copyWith(
        type: rf.type.addQuestionMarkAtEnd,
        isOptional: true,
        annotations: updateAnnotations));
  });
  var updateClass = "";
  if (!regularFields.every((f) => f.type.endsWith("?"))) {
    final updateClassName = className + "Update";

    updateClass = ModelUtils.createDefaultDartUpdateModelFromFeilds(
        fields: updateFields,
        className: updateClassName,
        isJsonSerializable: true);
  }

  return """
   ${_createReferenceClass(className)}
  ${updateClass} 
  ${ModelUtils.createDefaultDartModelFromFeilds(fields: regularFields, className: className, isJsonSerializable: true)} 
  
  """;
}

String _createReferenceClass(String name) {
  final refName = "${name}Reference";
  return """
    class $refName {
      
       final DocumentReference docRef;
       $refName(this.docRef);

    static $refName fromJson(dynamic docRef) =>
      $refName(docRef as DocumentReference);

     static dynamic toJson($refName mref) => mref.docRef;
  
     static $refName? fromJsonOptional(dynamic? docRef) =>
       docRef != null ? $refName(docRef as DocumentReference) : null;

     static dynamic toJsonOptional($refName? mref) => mref?.docRef;
  
      Future<$name?> get([GetOptions? options]) async {
        final snapshot = await docRef.get(options);
        var data = snapshot.data();
        if(data != null) {
          return $name.fromJson(data as Map<String,dynamic>); 
        } 
      }
    }
  """;
}

String getDslFromCollections({required ClassElement element}) {
  final queryItems = <String>[];
  final groupedQueryItems = <String>[];
  final types = <String>[];
  final mutationItems = <String>[];
  element.allSupertypes.where((e) => !e.isDartCoreObject).forEach((e) {
    final element = e.element;
    final annot = element.annotationFromType(collection);
    if (annot == null) {
      throw ArgumentError.value(
          "You should add collection annotation for a class ${element.name}");
    }
    final ca = getCollectionAnnotation(annot);
    final name = "${ca.name}_${element.name}";
    types.add(
        convertCollectionModelToDartDSLQuery(element: element, name: name));
    final qfn = "static ${name}Query $name() { throw Error();}";
    if (ca.sub) {
      groupedQueryItems.add(qfn);
    } else {
      queryItems.add(qfn);
    }
  });
  return """
   
   abstract class FireStoreQuery {
     ${queryItems.join("\n")}
   }
   
   abstract class FireStoreGroupQuery {
     ${groupedQueryItems.join("\n")}
   }

   ${types.join("\n")}
  
  """;
}

collection getCollectionAnnotation(ElementAnnotation annot) {
  final reader = ConstantReader(annot.computeConstantValue());
  final name = reader.peek("name")?.stringValue;
  final sub = reader.peek("sub")?.boolValue ?? false;
  return collection(name: name!, sub: sub);
}

String convertCollectionModelToDartDSLQuery(
    {required ClassElement element, required String name}) {
  final genericQueryFields = <String>[];
  final queryClassName = "${name}Query";

  genericQueryFields
      .add("$queryClassName limit(int limit) { $CompileTimeError }");
  genericQueryFields
      .add("$queryClassName limitToLast(int limit) { $CompileTimeError}");
  genericQueryFields.add(
      "$queryClassName orderBy(Object field,{bool descending = false}) { $CompileTimeError}");
  genericQueryFields.add("""
      $queryClassName where(
          Object field, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,}
      ) { $CompileTimeError}
      """);

  genericQueryFields.add(
      "$queryClassName endAtDocument(DocumentSnapshot documentSnapshot) { $CompileTimeError }");

  genericQueryFields.add(
      "$queryClassName startAtDocument(DocumentSnapshot documentSnapshot) {  $CompileTimeError }");
  genericQueryFields.add(
      "$queryClassName startAfterDocument(DocumentSnapshot documentSnapshot) {  $CompileTimeError }");

  genericQueryFields.add(
      "$queryClassName startAfter(List<Object?> values) { $CompileTimeError }");
  genericQueryFields
      .add("$queryClassName endAt(List<Object?> values) { $CompileTimeError }");
  genericQueryFields.add(
      "$queryClassName endBefore(List<Object?> values) { $CompileTimeError }");
  final subCollectionFields = <FieldElement>[];
  final fields = element.fields.map((f) {
    final name = f.name;
    final type = f.type;
    final typeStr = type.toString();
    final sca = f.type.element?.annotationFromType(collection);

    if (sca != null) {
      // sub collection field
      subCollectionFields.add(f);
      return "";
    } else if (type.isDartCoreList) {
      //
      return """
        $queryClassName where_$name({ Object? arrayContains,
    List<Object?>? arrayContainsAny,}) { $CompileTimeError }
      """;
    } else if (type.isDartCoreMap) {
    } else if (type.isDartCoreBool) {
      return """
       $queryClassName where_$name(
          $type? isEqualTo,
    $type? isNotEqualTo,
    $type? whereIn,
    $type? whereNotIn,
       ) {
$CompileTimeError
       }
      $queryClassName orderBy_$name({bool descending = false}) {
    $CompileTimeError
      }
      """;
    } else if (type.isDartCoreDouble ||
        type.isDartCoreInt ||
        type.isDartCoreNum ||
        type.isDartCoreString) {
      return """
       
       $queryClassName where_$name(
          $type? isEqualTo,
    $type? isNotEqualTo,
    $type? isLessThan,
    $type? isLessThanOrEqualTo,
    $type? isGreaterThan,
    $type? isGreaterThanOrEqualTo,
    $type? whereIn,
    $type? whereNotIn,
       ) {
$CompileTimeError
       }
      $queryClassName orderBy_$name({bool descending = false}) {
$CompileTimeError
      }
      """;
    } else {}
    final annotations = <String>[];
    if (typeStr.startsWith("DocumentReference")) {
      annotations.add("@DocumentReferenceConverter()");
    }
    return "";
  }).toList();
  var docClass = "";
  var pDocField = "";
  print("subCollection Fields $subCollectionFields");
  if (subCollectionFields.isNotEmpty) {
    final docName = "${name}QueryDoc";
    final docFields = subCollectionFields.map((f) {
      final annot = f.type.element?.annotationFromType(collection);
      final col = getCollectionAnnotation(annot!);
      final name = "${col.name}_${f.type}";
      return "${name}Query ${f.name}_${f.type}subcol() { $CompileTimeError }";
    }).join("\n");
    docClass = """
      class $docName {
        $docFields
      }
    """;
    pDocField = "$docName doc(String id) { throw Error();}";
  }

  return """
   
   class $queryClassName {
      ${genericQueryFields.join("\n")}
      ${fields.join("\n")}
      $pDocField
   }
  
   $docClass
  """;
}
