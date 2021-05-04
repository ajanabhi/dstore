import 'dart:io';

import 'package:dstore/dstore.dart';

@GraphqlSchema(
    path: "./schemas/sources/dgraph_learn.graphql",
    database: GraphqlDatabase.dgraph,
    schemaUplodDetails: SchemaUploadRequest(
        url: "https://proud-dew.ap-south-1.aws.cloud.dgraph.io/admin/schema"))
class LearnSchema {
  late Objects objects;
  late List<String> o1;
  late Enum1 e2;
}

enum Enum1 { h }

abstract class Node {
  late ID id;
}

abstract class Task implements Node {
  late String text;
  late bool completed;
}

abstract class Objects implements Task {}
