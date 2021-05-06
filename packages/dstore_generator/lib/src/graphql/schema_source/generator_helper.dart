import 'dart:io';
import 'dart:math';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/graphql/schema_source/dgraph/dgraph.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

final lambdaFields = <String>[];
Future<String> generateSchema(
    {required ClassElement element, required BuildStep buildStep}) async {
  final schemaMeta = _getGraphqlSchema(element);
  var objects = "";
  var interfaces = "";
  var enums = "";
  var inputs = "";
  var unions = "";
  final comments = schemaMeta.comments;

  element.fields.forEach((fe) {
    logger.shout(
        "name ${fe.name} type ${fe.type} ${fe.type.runtimeType} type element  : ${fe.type.element} eleemnttype ${fe.type.element.runtimeType}");
    final name = fe.name.toLowerCase();
    if (name == "objects") {
      objects = getObjects(element: element, schema: schemaMeta);
    }
    if (name == "interfaces") {
      interfaces = getInterfaces(element: element, schema: schemaMeta);
    }
    if (name == "inputs") {
      inputs = getInputs(element: element, schema: schemaMeta);
    }

    if (name == "unions") {
      inputs = getUnions(element: element, schema: schemaMeta);
    }

    if (name == "enums") {
      enums = getEnums(element: element, schema: schemaMeta);
    }
  });

  final schema = """
   
   $enums 

   $interfaces

   $objects
   
   $unions

   $inputs

   $comments
  
  """
      .trim();

  _saveSchemaToFile(schemaMeta, schema);
  if (schemaMeta.uploadSchema) {
    await _uploadSchema(schemaMeta, schema);
  }
  var lambdas = "";
  if (lambdaFields.isNotEmpty) {
    lambdas = _createLambdasObject(element.name);
  }

  return """
   $lambdas
  """;
}

String _createLambdasObject(String name) {
  final params = lambdaFields
      .map((f) => "required ResolverEntryFn ${f.replaceFirst('.', '_')}")
      .join(", ");
  final objectSetters = lambdaFields
      .map((f) =>
          "setProperty(obj,'$f',allowInterop(${f.replaceFirst('.', '_')}));")
      .join("\n");
  return """
   dynamic ${name}LambdasSetup({$params}) {
     final obj = newObject();
     $objectSetters
     addGraphQLResolvers(obj);
   }
  """;
}

void _saveSchemaToFile(GraphqlSchemaSource meta, String schema) {
  final file = File(meta.path);
  file.createSync(recursive: true);
  file.writeAsStringSync(schema);
}

Future<void> _uploadSchema(GraphqlSchemaSource meta, String schema) async {
  final uploadDetails = meta.schemaUplodDetails;
  if (uploadDetails == null) {
    throw ArgumentError.value(
        "You should provide schemaUplodDetails while defining graphqlschema if you want to upload");
  }
  if (meta.database == GraphqlDatabase.dgraph) {
    await validateAndUploadDGraphSchema(meta: meta, schema: schema);
  }
}

String getObjects(
    {required ClassElement element, required GraphqlSchemaSource schema}) {
  return element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) =>
          convertDartInterfaceTypeToObject(it: e, database: schema.database))
      .join("\n");
}

String getUnions(
    {required ClassElement element, required GraphqlSchemaSource schema}) {
  return element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) =>
          convertDartInterfaceTypeToUnions(it: e, database: schema.database))
      .join("\n");
}

String getEnums(
    {required ClassElement element, required GraphqlSchemaSource schema}) {
  return element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) =>
          convertDartInterfaceTypeToEnum(it: e, database: schema.database))
      .join("\n");
}

String getInterfaces(
    {required ClassElement element, required GraphqlSchemaSource schema}) {
  return element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) =>
          convertDartInterfaceTypeToInterface(it: e, database: schema.database))
      .join("\n");
}

String getInputs(
    {required ClassElement element, required GraphqlSchemaSource schema}) {
  return element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) =>
          convertDartInterfaceTypeToInput(it: e, database: schema.database))
      .join("\n");
}

String convertDartInterfaceTypeToObject(
    {required InterfaceType it, required GraphqlDatabase database}) {
  final element = it.element;
  final name = element.name;

  final interfaces = element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) => e.element.name)
      .join(", ");
  final impl = interfaces.isEmpty ? "" : "implements $interfaces";
  var interfacesFields = "";

  final directives =
      getAnnotationForObject(element: element, database: database);

  return """
   type $name $impl $directives {
    ${getFieldsFromClassElement(element: element, database: database)}
    $interfacesFields
   }
  """;
}

String convertDartInterfaceTypeToUnions(
    {required InterfaceType it, required GraphqlDatabase database}) {
  final element = it.element;
  final name = element.name;

  final objects = element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) => e.element.name)
      .join(" | ");

  final directives =
      getAnnotationForUnion(element: element, database: database);

  return """
   union $name = $objects $directives
  """;
}

String convertDartInterfaceTypeToEnum(
    {required InterfaceType it, required GraphqlDatabase database}) {
  final element = it.element;
  final name = element.name;
  final members = element.fields.map((e) => e.name).join("\n");
  final directives = getAnnotationForEnum(element: element, database: database);
  return """
   enum $name $directives {
     $members
   }
  """;
}

String convertDartInterfaceTypeToInput(
    {required InterfaceType it, required GraphqlDatabase database}) {
  final element = it.element;
  final name = element.name;
  final directives =
      getAnnotationForInput(element: element, database: database);
  return """
   input $name $directives  {
    ${getFieldsFromClassElement(element: it.element, database: database)}
   }
  """;
}

String convertDartInterfaceTypeToInterface(
    {required InterfaceType it, required GraphqlDatabase database}) {
  final element = it.element;
  final name = element.name;

  var interfacesFields = "";
  final directives =
      getAnnotationForInterface(element: element, database: database);
  return """
   interface $name  $directives {
    ${getFieldsFromClassElement(element: it.element, database: database)}
    $interfacesFields
   }
  """;
}

String getFieldsFromClassElement(
    {required ClassElement element, required GraphqlDatabase database}) {
  return element.fields.map((e) {
    final type = getGraphqlType(e.type);
    final name = e.name;
    final directives = getAnnotationsForField(fe: e, database: database);
    if (database == GraphqlDatabase.dgraph) {
      if (directives.contains("@lambda")) {
        lambdaFields.add("${element.name}_${name}");
      }
    }
    return "$name: $type $directives";
  }).join("\n");
}

String getAnnotationsForField(
    {required FieldElement fe, required GraphqlDatabase database}) {
  if (database == GraphqlDatabase.dgraph) {
    return getDGraphFieldAnnotations(element: fe);
  }
  return "";
}

String getAnnotationForObject(
    {required ClassElement element, required GraphqlDatabase database}) {
  if (database == GraphqlDatabase.dgraph) {
    return getDGraphObjectAnnotations(element: element);
  }
  return "";
}

String getAnnotationForInterface(
    {required ClassElement element, required GraphqlDatabase database}) {
  if (database == GraphqlDatabase.dgraph) {
    return getDGraphInterfaceAnnotations(element: element);
  }
  return "";
}

String getAnnotationForUnion(
    {required ClassElement element, required GraphqlDatabase database}) {
  if (database == GraphqlDatabase.dgraph) {
    return getDGraphUnionAnnotations(element: element);
  }
  return "";
}

String getAnnotationForInput(
    {required ClassElement element, required GraphqlDatabase database}) {
  if (database == GraphqlDatabase.dgraph) {
    return getDGraphInputAnnotations(element: element);
  }
  return "";
}

String getAnnotationForEnum(
    {required ClassElement element, required GraphqlDatabase database}) {
  if (database == GraphqlDatabase.dgraph) {
    return getDGraphEnumAnnotations(element: element);
  }
  return "";
}

String getGraphqlType(DartType type) {
  final req =
      type.getDisplayString(withNullability: true).endsWith("?") ? "" : "!";
  if (type.isDartCoreList) {
    return "[${getGraphqlType((type as InterfaceType).typeArguments.first)}]$req";
  } else if (type.isDartCoreInt) {
    return "Int$req";
  } else if (type.isDartCoreBool) {
    return "Boolean$req";
  } else if (type.isDartCoreDouble) {
    return "Float$req";
  } else if (type.isDartCoreNum) {
    return "Float$req";
  } else {
    return "${type.getDisplayString(withNullability: false)}$req";
  }
}

GraphqlSchemaSource _getGraphqlSchema(ClassElement element) {
  final annot = element.annotationFromType(GraphqlSchemaSource)!;
  final reader = ConstantReader(annot.computeConstantValue());
  final path = reader.peek("path")!.stringValue;
  final lambdaSourceFile = reader.peek("lambdaSourceFile")?.stringValue;
  print("database ${reader.peek("database")}");
  final database = reader.getEnumField("database", GraphqlDatabase.values)!;
  final uploadSchema = reader.peek("uploadSchema")?.boolValue ?? false;
  final uploadLambda = reader.peek("uploadLambda")?.boolValue ?? false;
  final comments = reader.peek("comments")?.stringValue ?? "";
  final schemaUplodDetailsObj = reader.peek("schemaUplodDetails");
  SchemaUploadRequest? schemaUplodDetails;
  if (schemaUplodDetailsObj != null) {
    final url = schemaUplodDetailsObj.peek("url")?.stringValue;
    final headers = schemaUplodDetailsObj.getStringMapForField("headers");
    schemaUplodDetails = SchemaUploadRequest(url: url!, headers: headers);
  }
  return GraphqlSchemaSource(
      path: path,
      database: database,
      uploadSchema: uploadSchema,
      uploadLambda: uploadLambda,
      lambdaSourceFile: lambdaSourceFile,
      schemaUplodDetails: schemaUplodDetails,
      comments: comments);
}
