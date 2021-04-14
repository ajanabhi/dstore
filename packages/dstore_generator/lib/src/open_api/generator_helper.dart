import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/open_api/types.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:open_api_schema/v3.dart';
import 'package:tuple/tuple.dart';
import 'package:yaml/yaml.dart';

const APPLICATION_JSON = "application/json";
const APPLICATION_OCTET_STREAM = "application/octet-stream";

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
      final pathParamsAndTypes = <String, String>{};
      final queryParamsAndTypes = <String, String>{};
      op.parameters?.forEach((por) {
        final p = _getParameterFromParamOrRef(schema, por);
        final objectName = "${oid}_${p.name.cpatialize}";
        final type = _getTypeName(p.schema!, objectName);
        if (p.o_in == "query") {
          queryParamsAndTypes[p.name] = type;
        } else if (p.o_in == "path") {
          pathParamsAndTypes[p.name] = type;
        }
      });
      if (pathParamsAndTypes.isNotEmpty) {
        final pathParams = _getParamsInPath(path).toSet();
        final typesList = pathParamsAndTypes.keys.toSet();
        if (pathParams.length != typesList.length ||
            !pathParams.containsAll(typesList)) {
          throw ArgumentError.value(
              "Path $path has pathParams $pathParams , but you didnt specified all pathParams in types ($pathParamsAndTypes)");
        }
      }
      final it = _getInputTypeFromReqoRRef(
          schema: schema, ror: op.requestBody, name: "${oid}RequestBody");
      final ot = _getResponseType(
          schema: schema, responses: op.responses, name: "${oid}Response");
    });
  });

  return """""";
}

InputType? _getInputTypeFromReqoRRef(
    {required OpenApiSchema schema,
    required RequestBodyOrReference? ror,
    required String name}) {
  if (ror == null) {
    return null;
  }
  RequestBody getRequestBody(RequestBodyOrReference ror) {
    if (ror.ref != null) {
      final refName =
          ror.ref!.$ref.replaceFirst("#/components/requestBodies/", "");
      final ror2 = schema.components?.requestBodies?[refName];
      if (ror2 == null) {
        throw ArgumentError.value(
            "You used requestbody ref $refName but you didn't specified in components.requestBodies");
      }
      return getRequestBody(ror2);
    } else {
      return ror.req!;
    }
  }

  final rb = getRequestBody(ror);
  String contentType;
  String type;
  if (rb.content.isEmpty) {
    throw ArgumentError.value(
        "You should provide content type and mediatype in requestBody content $name");
  }
  //TODO handle mutiple content types in requestbody!
  // if (rb.content.length == 1) {
  final c = rb.content.entries.first;
  contentType = c.key;
  type = _getTypeName(c.value.schema, name);
  // } else {
  //   for (final c in rb.content.entries) {

  //   }
  // }
  String serializer;
  String deserializer;
  if (type == "String") {
    serializer = """
      $type ${name}Serializer($type input) => input;
    """;
    deserializer = """
      $type ${name}Deserializer(dynamic input) => input as $type;
    """;
  } else {
    serializer = """
      dynamic ${name}Serializer($type input) => input.toJson();
    """;
    deserializer = """
      $type ${name}Deserializer(dynamic input) => ${type}.fromJson(input);
    """;
  }
  return InputType(
      type: type,
      required: false,
      contentType: contentType,
      serializer: serializer,
      deserializer: deserializer);
}

Tuple3<String, String, String> _getResponseType(
    {required OpenApiSchema schema,
    required Map<String, ResponseOrReference> responses,
    required String name}) {
  Response getResponseFromResponseOrRef(ResponseOrReference ror) {
    if (ror.ref != null) {
      final refname = ror.ref!.$ref.replaceFirst("#/components/responses/", "");
      final ror2 = schema.components?.responses?[refname];
      if (ror2 == null) {
        throw ArgumentError.value(
            "Response ref $refname not found in schema.components.responses");
      }
      return getResponseFromResponseOrRef(ror2);
    } else {
      return ror.resp!;
    }
  }

  String getTypeFromResponse(Response resp, String objName) {
    if (resp.content == null) {
      return "Null";
    }
    final content = resp.content!;
    if (content.isEmpty) {
      throw ArgumentError.value(
          "You should provide content type and mediatype in requestBody content $name");
    }
    final r1 = content.entries.first.value.schema;
    return _getTypeName(r1, name);
  }

  String getTypeFromMultipleResponses(
      List<MapEntry<String, ResponseOrReference>> list, String name) {
    final acceesors = <String>[];
    final serializeCases = <String>[];
    final deserializeCases = <String>[];
    var serializeDefaultCase = "";
    var deserializeDefaultCase = "";
    final ctors = <String>[];
    list.forEach((e) {
      final resp = getResponseFromResponseOrRef(e.value);
      final type = getTypeFromResponse(resp, "${name}_${e.key}");
      final status = e.key;
      ctors.add("""
       factory $name.$status($type value):_value:value;
      """);
      final accessor = """
          $type? get $status => _value is $type ? _value as $type : null;
        """;
      acceesors.add(accessor);
      var serializeCase = "";
      //serialize
      if (type == "String") {
        if (status == "default") {
          serializeDefaultCase = """
           default:
             return input.toString(); 
          """;
        } else {
          serializeCase = """
          case $status:
            return input.toString();
        """;
        }
      } else {
        // assume its json
        if (status == "default") {
          serializeDefaultCase = """
           default:
             return input.toJson(); 
          """;
        } else {
          serializeCase = """
          case $status:
            return input.toJson();
        """;
        }
      }
      var deserializeCase = "";
      if (type == "String") {
        if (status == "default") {
          deserializeDefaultCase = """
           default:
             return $name(input.toString()); 
          """;
        } else {
          deserializeCase = """
          case $status:
            return $name(input.toString());
        """;
        }
      } else {
        // assume its json!

        if (status == "default") {
          deserializeDefaultCase = """
           default:
             return $name(${name}_${status}.fromJson(input)); 
          """;
        } else {
          deserializeCase = """
          case $status:
            return $name(${name}_${status}.fromJson(input));
        """;
        }
      }
      serializeCases.add(serializeCase);
      deserializeCases.add(deserializeCase);
    });

    final toJson = """
    
     static dynamic toJson(int status,$name input) {
       switch(status){
         ${serializeCases.join("\n")}
         ${serializeDefaultCase}
       }
     }
    """;

    final fromJson = """
     static $name fromJson(int status,dynamic input) {
         switch(status){
         ${deserializeCases.join("\n")}
         ${deserializeDefaultCase}
       }
     }
   """;

    final typeImpl = """
     
     class $name {
       final dynamic _value;
       ${ctors.join("\n")}
      
       ${acceesors.join("\n")}
       
       $toJson

       $fromJson
       
     }
    
    """;
    types.add(typeImpl);
    return name;
  }

  final success =
      responses.entries.where((e) => e.key.startsWith("2")).toList();
  if (success.isEmpty) {
    throw ArgumentError.value(
        "You should provide atleast one successull response");
  }
  String responseSuccessType;
  if (success.length == 1) {
    final s1 = success.first.value;
    final resp = getResponseFromResponseOrRef(s1);
    responseSuccessType = getTypeFromResponse(resp, name);
  } else {
    responseSuccessType = getTypeFromMultipleResponses(success, name);
  }
  String responseErrorType;
  final erros = responses.entries
      .where((e) =>
          e.key.startsWith("4") || e.key.startsWith("5") || e.key == "default")
      .toList();

  return Tuple3("", "", "");
}

Parameter _getParameterFromParamOrRef(OpenApiSchema schema, ParamOrRef por) {
  if (por.param != null) {
    return por.param!;
  }
  final ref = por.ref!.$ref;
  final refName = _getRef(ref);
  final por2 = schema.components?.parameters?[refName];
  if (por2 == null) {
    throw ArgumentError.value(
        "Parameter ref $ref is not defined in schmea.components.parameters");
  }
  return _getParameterFromParamOrRef(schema, por2);
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
