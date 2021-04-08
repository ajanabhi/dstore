import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:open_api_schema/v3.dart';
import 'package:yaml/yaml.dart';

String createOpenApi(
    {required ClassElement element, required BuildStep buildStep}) {
  final opneApi = _getOpenApiAnnotation(element);
  final file = opneApi.file;
  final schema = getSchemaFromFile(file);
  logger.shout("Schema Bro");
  print(schema);
  _resolveDiscriminators(schema);
  return """""";
}

OpenApiSchema getSchemaFromFile(String file) {
  final content = File(file).readAsStringSync();
  Map<String, dynamic> map;
  if (file.endsWith(".json")) {
    map = jsonDecode(content) as Map<String, dynamic>;
  } else {
    final v = (loadYaml(content) as YamlMap).value;
    print(v.runtimeType);
    final dynamic yaml = loadYaml(content);
    String yamlStr;
    try {
      yamlStr = jsonEncode(yaml);
    } catch (e) {
      throw Exception(
          "there is problem in reading yaml file using yaml package, please provide you open api spec as json file. you can convert your yaml file to json using services like https://onlineyamltools.com/convert-yaml-to-json ");
    }
    map = jsonDecode(yamlStr) as Map<String, dynamic>;
  }
  return OpenApiSchema.fromJson(map);
}

OpenApi _getOpenApiAnnotation(ClassElement element) {
  final a = element.annotationFromType(OpenApi)!;
  final dt = a.computeConstantValue();
  if (dt == null) {
    throw ArgumentError(
        "Looks like you passed invalid values to OpenApi annotation");
  }
  final file = dt.getField("file")!.toStringValue()!;
  return OpenApi(file);
}

void _resolveDiscriminators(OpenApiSchema spec) {
  if (spec.components?.schemas != null) {
    final validRefPath = "#/components/schemas/";
    spec.components!.schemas!.forEach((key, value) {
      if (value.ref != null ||
          value.schema!.discriminator == null ||
          value.schema!.discriminator?.mapping == null) {
        return;
      }
      final discriminator = value.schema!.discriminator!;
      discriminator.mapping!.forEach((key, ref) {
        if (!ref.startsWith(validRefPath)) {
          throw ArgumentError.value(
              "Discriminator mapping outside of '${validRefPath}' is not supported");
        }
        // TODO capture this name
      });
    });
  }
}

String _getRef(String $ref) {
  final schema = $ref.replaceAndReturn("#/components/schemas/");
  if (schema != null) {
    return schema.cpatialize;
  }
  final response = $ref.replaceAndReturn("#/components/responses/");
  if (response != null) {
    return response.cpatialize + "Response";
  }

  final param = $ref.replaceAndReturn("#/components/parameters/");
  if (param != null) {
    return param.cpatialize + "Paramemter";
  }
  final reqBody = $ref.replaceAndReturn("#/components/requestBodies/");
  if (reqBody != null) {
    return reqBody.cpatialize + "RequestBody";
  }

  throw ArgumentError.value(
      "This library only resolve \$ref that are include into '#components/*' for now");
}

String _getTypeName(SchemaOrReference sor) {
  if (sor.ref != null) {
    return _getRef(sor.ref!.$ref);
  }
  final schema = sor.schema!;
  final isOptional = schema.nullable;
  final nullable = isOptional ? "?" : "";
  switch (schema.type) {
    case "int32":
    case "int64":
    case "integer":
    case "long":
      return "int$nullable";
    case "number":
      return "num$nullable";
    case "float":
    case "double":
      return "double$nullable";
    default:
      return "dynamic";
  }
}
