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
  // _resolveDiscriminators(schema);
  schema.components?.schemas?.forEach((key, value) {
    if (value.schema != null && value.schema!.type == "object") {
      _createDartModelFromSchemaObject(value.schema!, key);
    }
  });
  final url = _getUrl(schema);

  return """""";
}

String _getUrl(OpenApiSchema schema) {
  if (schema.servers == null || schema.servers!.isEmpty) {
    return "";
  }
  return schema.servers!.first.url;
}

String _convertPaths(OpenApiSchema schema) {
  schema.paths.entries.map((e) {
    final path = e.key;
    final ops = <String>{};
    final methodAndOp = <String, Operation>{};
    if (e.value.get != null) {
      methodAndOp["GET"] = e.value.get!;
    } else if (e.value.post != null) {
      methodAndOp["POST"] = e.value.post!;
    } else if (e.value.delete != null) {
      methodAndOp["DELETE"] = e.value.delete!;
    } else if (e.value.put != null) {
      methodAndOp["PUT"] = e.value.put!;
    } else if (e.value.patch != null) {
      methodAndOp["PATCH"] = e.value.post!;
    }
    methodAndOp.forEach((method, op) {
      if (op.operationId == null) {
        throw ArgumentError.value(
            "operationId for path $path and method $method should not be null ");
      }
      final oid = op.operationId!;
      if (ops.contains(oid)) {
        throw ArgumentError.value(
            "operationId $oid is already used, please use unique values for operation Ids");
      }
      ops.add(oid);
    });
  });

  return """""";
}

List<String> _getParamsInPath(String path) {
  final result = <String>[];
  final regEx = RegExp(r"\{(\w+)}");
  final matches = regEx.allMatches(path);
  matches.forEach((m) {
    final f = m.group(1);
    if (f != null) {
      result.add(f);
    }
  });
  return result;
}

final types = <String>[];

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

String _getTypeName(SchemaOrReference sor, String objectName) {
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
    case "string":
    case "byte":
    case "binary":
    case "date-time":
    case "dateTime":
    case "password":
      return "String$nullable"; //TODO enums schema.enum
    case "boolean":
      return "bool$nullable";
    case "array":
      if (schema.items != null) {
        return "List<${_getTypeName(schema.items!, objectName)}>$nullable";
      } else {
        throw ArgumentError.value(
            "All array schema types should have items field");
      }

    case "object":
      if (schema.oneOf != null ||
          schema.anyOf != null ||
          schema.allOf != null) {
        return "dynamic/*  ${_getCombinedTypes(schema)} */";
      }
      _createDartModelFromSchemaObject(schema, objectName);
      return "$objectName$nullable";
    default:
      return "dynamic";
  }
}

String _getCombinedTypes(Schema schema) {
  if (schema.allOf != null) {
    return "allof ${schema.allOf!.map((e) => _getTypeName(e, "")).join(", ")}";
  }
  if (schema.anyOf != null) {
    return "anyOf ${schema.anyOf!.map((e) => _getTypeName(e, "")).join(", ")}";
  }
  if (schema.oneOf != null) {
    return "oneOf ${schema.oneOf!.map((e) => _getTypeName(e, "")).join(", ")}";
  }
  return "";
}

void _createDartModelFromSchemaObject(Schema schema, String name) {
  if (schema.type != "object") {
    throw ArgumentError.value("You should provide schema of type object");
  }
  final fields = schema.properties?.entries.map((e) {
        final fn = e.key;
        var type = _getTypeName(e.value, "${name}_${fn.cpatialize}");
        final isRequired = schema.required?.contains(fn) ?? false;
        if (!isRequired) {
          type = "$type?";
        }
        return Field(name: fn, type: type, isOptional: !isRequired);
      }).toList() ??
      [];

  final result = ModelUtils.createDefaultDartModelFromFeilds(
      fields: fields, className: name, isJsonSerializable: true);
  types.add(result);
}
