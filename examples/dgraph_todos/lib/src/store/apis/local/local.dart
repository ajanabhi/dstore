import 'package:dstore/dstore.dart';
import "package:json_annotation/json_annotation.dart";
part "local.api.dstore.dart";
part "local.g.dart";

const api = GraphqlApi(apiUrl: "http://localhost:4000/", schemaPath: "s");

@api
class MyApi {}
