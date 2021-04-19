import 'package:dstore/dstore.dart';

import 'package:json_annotation/json_annotation.dart';
part "api.api.dstore.dart";

@GraphqlApi(apiUrl: "https://proud-dew.ap-south-1.aws.cloud.dgraph.io/graphql")
class TodoAPi {}
