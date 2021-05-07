import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

Future<String> generateFireStoreSchema(
    {required ClassElement element, required BuildStep buildStep}) async {
  var collectionModels = "";
  var collectionDsl = "";
  element.fields.forEach((f) {
    final name = f.name.toLowerCase();
    if (name == "collections") {
      collectionModels =
          getModelsFromCollections(element: f.type.element as ClassElement);
      collectionDsl =
          getDslFromCollections(element: f.type.element as ClassElement);
    }
  });

  return """
    $collectionModels
    $collectionDsl 
  """;
}

String getModelsFromCollections({required ClassElement element}) {
  return element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) => convertCollectionModelToDartModel(element: e.element))
      .join("\n");
}

String convertCollectionModelToDartModel({required ClassElement element}) {
  final fields = element.fields
      .where((f) =>
          f.type.element?.annotationFromType(collection) ==
          null) // subcollections are shallow
      .map((f) {
    final name = f.name;
    var type = f.type.toString();
    final annotations = <String>[];
    if (type.startsWith("FireStoreRef")) {
      type = "DocumentReference";
      annotations.add("@DocumentReferenceConverter()");
    }
    return Field(
        name: name,
        type: type,
        isOptional: type.endsWith("?"),
        annotations: annotations);
  }).toList();
  return ModelUtils.createDefaultDartModelFromFeilds(
      fields: fields, className: element.name, isJsonSerializable: true);
}

String getDslFromCollections({required ClassElement element}) {
  final queryItems = <String>[];
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
    queryItems.add("${name}Query $name() { throw Error();}");
  });
  return """
   
   class FireStoreQuery {
     ${queryItems.join("\n")}
   }

   ${types.join("\n")}
  
  """;
}

collection getCollectionAnnotation(ElementAnnotation annot) {
  final reader = ConstantReader(annot.computeConstantValue());
  final name = reader.peek("name")?.stringValue;
  return collection(name: name!);
}

String convertCollectionModelToDartDSLQuery(
    {required ClassElement element, required String name}) {
  // final name = element.name;
  final genericQueryFields = <String>[];

  genericQueryFields.add("void limit(int limit) {}");
  genericQueryFields.add("void limitToLast(int limit) {}");
  genericQueryFields
      .add("void orderBy(Object field,{bool descending = false}) {}");
  genericQueryFields.add("""
      void where(
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
      ) {}
      """);

  final fields = element.fields.map((f) {
    final name = f.name;
    final type = f.type;
    final typeStr = type.toString();
    final sca = f.type.element?.annotationFromType(collection);
    if (sca != null) {
      // sub collection field
      final sce = f.type.element!;
      final scec = getCollectionAnnotation(sca);
      final name2 = "${scec.name}_${sce.name}";
      return """
        $name2 ${name}_subcoll() {
          throw Error();
        }
      """;
    } else if (type.isDartCoreList) {
      //
      return """
        void where_$name({ Object? arrayContains,
    List<Object?>? arrayContainsAny,}) {}
      """;
    } else if (type.isDartCoreMap) {
    } else if (type.isDartCoreBool) {
      return """
       void where_$name(
          $type? isEqualTo,
    $type? isNotEqualTo,
    $type? whereIn,
    $type? whereNotIn,
       ) {

       }
      void orderBy_$name({bool descending = false}) {

      }
      """;
    } else if (type.isDartCoreDouble ||
        type.isDartCoreInt ||
        type.isDartCoreNum ||
        type.isDartCoreString) {
      return """
       
       void where_$name(
          $type? isEqualTo,
    $type? isNotEqualTo,
    $type? isLessThan,
    $type? isLessThanOrEqualTo,
    $type? isGreaterThan,
    $type? isGreaterThanOrEqualTo,
    $type? whereIn,
    $type? whereNotIn,
       ) {

       }
      void orderBy_$name({bool descending = false}) {

      }
      """;
    } else {}
    final annotations = <String>[];
    if (typeStr.startsWith("DocumentReference")) {
      annotations.add("@DocumentReferenceConverter()");
    }
    return "";
  });

  return """
   
   class ${name}Query {
      ${genericQueryFields.join("\n")}
      ${fields.join("\n")}
   }
  
  """;
}
