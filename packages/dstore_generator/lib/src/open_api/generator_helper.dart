import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/open_api/open_api_schema_utils.dart';
import 'package:dstore_generator/src/open_api/types.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:open_api_schema/v3.dart';

const APPLICATION_JSON = "application/json";
const APPLICATION_OCTET_STREAM = "application/octet-stream";

Future<String> createOpenApi(
    {required ClassElement element, required BuildStep buildStep}) async {
  final openAPi = element.openAPiAnnotation;
  final schema = await OpenApiSchemaUtils.getOpenApiSchema(openAPi);
  schema.components?.schemas?.forEach((key, value) {
    if (value.schema != null) {
      final vSchema = value.schema!;
      if (vSchema.type == "object") {
        _createDartModelFromSchemaObject(value.schema!, key);
      }
    }
  });
  final url = _getUrl(schema);
  final pathTypes = _convertPaths(schema: schema, url: url);

  return """
    ${types.join("\n")}
    ${pathTypes}
  """;
}

String _getUrl(OpenApiSchema schema) {
  if (schema.servers == null || schema.servers!.isEmpty) {
    return "";
  }
  return schema.servers!.first.url;
}

String _createTypeFromMap(Map<String, String> meta, String name) {
  final fields = ModelUtils.processFields(
      meta.entries.map((e) {
        final name = e.key;
        final type = e.value;
        return Field(name: name, type: type, isOptional: type.endsWith("?"));
      }).toList(),
      addJsonKey: true);
  final type = ModelUtils.createDefaultDartModelFromFeilds(
      fields: fields,
      className: name,
      isJsonSerializable: true,
      addStaticSerializeDeserialize: true);
  types.add(type);
  return name;
}

String _convertPaths({required OpenApiSchema schema, required String url}) {
  final pathTypes = <String>[];
  schema.paths.entries.forEach((e) {
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
        final type = _getTypeName(sor: p.schema!, objectName: objectName);
        if (p.o_in == "query") {
          queryParamsAndTypes[p.name] = type;
        } else if (p.o_in == "path") {
          pathParamsAndTypes[p.name] = type;
        }
      });
      String? queryParamsType;
      String? pathParamsType;
      if (pathParamsAndTypes.isNotEmpty) {
        final pathParams = _getParamsInPath(path).toSet();
        final typesList = pathParamsAndTypes.keys.toSet();
        if (pathParams.length != typesList.length ||
            !pathParams.containsAll(typesList)) {
          throw ArgumentError.value(
              "Path $path has pathParams $pathParams , but you didnt specified all pathParams in types ($pathParamsAndTypes)");
        }
        pathParamsType = "${oid}PathParams";
        _createTypeFromMap(pathParamsAndTypes, pathParamsType);
      }
      if (queryParamsAndTypes.isNotEmpty) {
        queryParamsType = "${oid}QueryParams";
        _createTypeFromMap(queryParamsAndTypes, queryParamsType);
      }
      final params = <String>[
        'method = "$method"',
        'url = "$url"',
      ];
      final it = _getInputTypeFromReqoRRef(
          schema: schema, ror: op.requestBody, name: "${oid}RequestBody");
      if (it != null) {
        params.add('inputDeserializer: ${it.serializer}');
        params.add('inputSerializer: ${it.deserializer}');
      }

      final ot = _getResponseType(
          schema: schema, responses: op.responses, name: "${oid}Response");
      params.add("responseType: ${ot.responseType} ");
      params.add("responseSerializer: ${ot.serializer}");
      params.add("responseDeserializer: ${ot.deserializer}");
      params.add("errorDeserializer: ${ot.errorDeserializer}");

      if (queryParamsType != null) {
        params.add('queryParamsType: "${queryParamsType}"');
      }

      if (pathParamsType != null) {
        params.add('pathParamsType: "${pathParamsType}"');
      }

      if (pathParamsType != null) {}

      final dapi = """
       @HttpRequest( ${params.join(", ")} )
       class $oid = HttpField<QP, I, R, E>;
      
      """;
      pathTypes.add(dapi);
    });
  });

  return """
   ${pathTypes.join("\n")}
  """;
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
  type = _getTypeName(sor: c.value.schema, objectName: name);
  // } else {
  //   for (final c in rb.content.entries) {

  //   }
  // }

  final serializerName = "${name}Serializer";
  final deserializerName = "${name}Deserializer";
  ;
  if (type == "String") {
    types.add(" $type $serializerName($type input) => input;");
    types.add("$type $deserializerName(dynamic input) => input as $type;");
  } else {
    types.add("""
      dynamic $serializerName($type input) => input.toJson();
    """);
    types.add("""
      $type $deserializerName(dynamic input) => ${type}.fromJson(input);
    """);
  }
  return InputType(
      type: type,
      required: false,
      contentType: contentType,
      serializer: serializerName,
      deserializer: deserializerName);
}

OutputType _getResponseType(
    {required OpenApiSchema schema,
    required Map<String, ResponseOrReference> responses,
    required String name}) {
  var responseType = "";
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
    if (responseType.isEmpty) {
      final key = content.entries.first.key;
      if (key.startsWith("application/json")) {
        responseType = HttpResponseType.JSON.toString();
      } else if (key.startsWith("text/plain")) {
        responseType = HttpResponseType.STRING.toString();
      } else {
        responseType = HttpResponseType.JSON.toString();
      }
    }
    final r1 = content.entries.first.value.schema;
    return _getTypeName(sor: r1, objectName: name);
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
    
     static dynamic toJsonStatic(int status,$name input) {
       switch(status){
         ${serializeCases.join("\n")}
         ${serializeDefaultCase}
       }
     }
    """;

    final fromJson = """
     static $name fromJsonStatic(int status,dynamic input) {
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
  String successType;
  final successName = "${name}_Success";
  var serializerName = "";
  var deserializerName = "";
  if (success.length == 1) {
    final s1 = success.first.value;
    final resp = getResponseFromResponseOrRef(s1);
    successType = getTypeFromResponse(resp, successName);
  } else {
    successType = getTypeFromMultipleResponses(success, successName);
  }
  String errorType;
  final errorName = "${name}_Error";
  final errors = responses.entries
      .where((e) =>
          e.key.startsWith("4") || e.key.startsWith("5") || e.key == "default")
      .toList();
  if (errors.isEmpty) {
    throw ArgumentError.value(
        "You should provide atleast one error response / default");
  }

  if (errors.length == 1) {
    final s1 = errors.first.value;
    final resp = getResponseFromResponseOrRef(s1);
    errorType = getTypeFromResponse(resp, errorName);
  } else {
    errorType = getTypeFromMultipleResponses(errors, errorName);
  }
  String serializer;
  String deserializer;
  if (successType == "String") {
    serializerName = "${successName}Serializer";
    serializer = """
      String $serializerName(int status,String input) => input;
    """;
    deserializerName = "${successName}Deserializer";
    deserializer = """
      String $deserializerName(int status,dynamic input) => input.toString(); 
    """;
  } else {
    serializerName = "${successName}.toJsonStatic";
    deserializerName = "${successName}.fromJsonStatic";
    serializer = "";
    deserializer = "";
  }

  String errorSerializer;
  String errorDeserializer;

  if (errorType == "String") {
    errorSerializer = "${errorName}Serializer";
    types.add("""
    String $errorSerializer(int status,String input) => input;
    """);
    errorDeserializer = "${errorName}Deserializer";
    types.add("""
     String $errorDeserializer(int status,dynamic input) => input.toString(); 
    """);
  } else {
    errorSerializer = "${errorName}.toJson";
    errorDeserializer = "${errorName}.fromJson";
  }
  return OutputType(
      successType: successType,
      errorType: errorType,
      serializer: serializer,
      deserializer: deserializer,
      responseType: responseType,
      errorSerializer: errorSerializer,
      errorDeserializer: errorDeserializer);
}

Parameter _getParameterFromParamOrRef(OpenApiSchema schema, ParamOrRef por) {
  if (por.param != null) {
    return por.param!;
  }
  final ref = por.ref!.$ref;
  final refName = _getRefRawName(ref);
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
final scalarasAndArraysMap = <String, String>{};

void clearOpenApiGlobals() {
  types.clear();
  scalarasAndArraysMap.clear();
}

extension OPenAPiAnnoExtonElement on Element {
  OpenApi get openAPiAnnotation {
    final a = this.annotationFromType(OpenApi)!;
    final dt = a.computeConstantValue();
    if (dt == null) {
      throw ArgumentError(
          "Looks like you passed invalid values to OpenApi annotation, all values should be const");
    }
    final file = dt.getField("file")?.toStringValue()!;
    final httpObj = dt.getField("http");
    if (file == null && httpObj == null) {
      throw ArgumentError.value("You should  ");
    }
    final http = getOpenAPiHttpConfig(httpObj);

    return OpenApi(file: file, http: http);
  }
}

OpenApiHttpConfig? getOpenAPiHttpConfig(DartObject? obj) {
  if (obj != null && !obj.isNull) {
    final url = obj.getField("url")?.toStringValue();
    final headers = obj.getStringMapForField("headers");
    final saveOnlineSpecToFile =
        obj.getField("saveOnlineSpecToFile")?.toStringValue();
    return OpenApiHttpConfig(
        url: url!,
        headers: headers,
        saveOnlineSpecToFile: saveOnlineSpecToFile);
  }
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

String _getRefRawName(String $ref) {
  final schema = $ref.replaceAndReturn("#/components/schemas/");
  if (schema != null) {
    return schema;
  }
  final response = $ref.replaceAndReturn("#/components/responses/");
  if (response != null) {
    return response;
  }

  final param = $ref.replaceAndReturn("#/components/parameters/");
  if (param != null) {
    return param;
  }
  final reqBody = $ref.replaceAndReturn("#/components/requestBodies/");
  if (reqBody != null) {
    return reqBody;
  }

  throw ArgumentError.value(
      "This library only resolve \$ref that are include into '#components/*' for now");
}

String _getTypeName(
    {required SchemaOrReference sor, required String objectName}) {
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
      return "String$nullable";
    case "boolean":
      return "bool$nullable";
    case "array":
      if (schema.items != null) {
        return "List<${_getTypeName(sor: schema.items!, objectName: objectName)}>$nullable";
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
    return "allof ${schema.allOf!.map((e) => _getTypeName(sor: e, objectName: "")).join(", ")}";
  }
  if (schema.anyOf != null) {
    return "anyOf ${schema.anyOf!.map((e) => _getTypeName(sor: e, objectName: "")).join(", ")}";
  }
  if (schema.oneOf != null) {
    return "oneOf ${schema.oneOf!.map((e) => _getTypeName(sor: e, objectName: "")).join(", ")}";
  }
  return "";
}

void _createDartModelFromSchemaObject(Schema schema, String name) {
  if (schema.type != "object") {
    throw ArgumentError.value("You should provide schema of type object");
  }
  final fields = schema.properties?.entries.map((e) {
        final fn = e.key;
        var type =
            _getTypeName(sor: e.value, objectName: "${name}_${fn.cpatialize}");
        final isRequired = schema.required?.contains(fn) ?? false;
        if (!isRequired) {
          type = "$type?";
        }
        return Field(name: fn, type: type, isOptional: !isRequired);
      }).toList() ??
      [];

  final result = ModelUtils.createDefaultDartModelFromFeilds(
      fields: fields,
      className: name,
      isJsonSerializable: true,
      addStaticSerializeDeserialize: true);
  types.add(result);
}
