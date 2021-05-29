import 'dart:convert';
import 'dart:io';

import 'package:open_api_schema/v3.dart';

abstract class ContentTypes {
  static const appJson = "application/json";
  static const textHtml = "text/html";
  static const appOctetStream = "application/octet-stream";
}

final defaultResponse = ResponseOrReference(Response(content: {
  "${ContentTypes.textHtml}":
      MediaType(schema: SchemaOrReference(Schema(type: "string")))
}));

final stringSchema = SchemaOrReference(Schema(type: "string"));
final listString =
    SchemaOrReference(Schema(type: "array", items: stringSchema));
final stringBinarySchema =
    SchemaOrReference(Schema(type: "string", format: "binary"));
final intSchmea = SchemaOrReference(Schema(type: "integer"));

void generateSpec() {
  final spec = OpenApiSchema(
      info: Info(title: "", version: ""),
      servers: [Server(url: "http://localhost:8080")],
      openapi: "3.0.0",
      paths: {
        "/": PathItem(
            get: Operation(operationId: "helloPing", responses: {
          "200": ResponseOrReference(Response(
            content: {
              "${ContentTypes.textHtml}":
                  MediaType(schema: SchemaOrReference(Schema(type: "string")))
            },
          )),
          "default": defaultResponse
        })),
        "/json": PathItem(
            get: Operation(operationId: "helloJson", responses: {
          "200": ResponseOrReference(Response(
            content: {
              "${ContentTypes.appJson}": MediaType(
                  schema: SchemaOrReference(Schema(
                      type: "object",
                      required: ["name", "count"],
                      properties: {"name": stringSchema, "count": intSchmea})))
            },
          )),
          "default": defaultResponse
        })),
        "/octet": PathItem(
            get: Operation(operationId: "HelloOctet", responses: {
          "200": ResponseOrReference(Response(
            content: {
              "${ContentTypes.appOctetStream}":
                  MediaType(schema: stringBinarySchema)
            },
          )),
          "default": defaultResponse
        })),
        "/optimistic-fail": PathItem(
            get: Operation(operationId: "OptimisticFail", responses: {
          "200": ResponseOrReference(Response(
            content: {
              "${ContentTypes.textHtml}": MediaType(schema: stringSchema)
            },
          )),
          "default": defaultResponse
        })),
        "/pagination/{page}": PathItem(
            get: Operation(operationId: "Pagination", parameters: [
          ParamOrRef(Parameter(name: "page", o_in: "path", schema: intSchmea))
        ], responses: {
          "200": ResponseOrReference(Response(
            content: {
              "${ContentTypes.appJson}": MediaType(
                  schema: SchemaOrReference(Schema(type: "object", required: [
                "list",
              ], properties: {
                "list": listString,
                "nextPage": intSchmea
              })))
            },
          )),
          "default": defaultResponse
        }))
      });

  File("./spec.json").writeAsStringSync(jsonEncode(spec.toJson()));
  print("successfully generated spec");
}
