import 'package:dstore/dstore.dart';

import 'package:json_annotation/json_annotation.dart';
part "api.api.dstore.dart";
part "api.g.dart";

const s = "22";

@GraphqlApi(apiUrl: "https://proud-dew.ap-south-1.aws.cloud.dgraph.io/graphql")
class TodoAPi {}