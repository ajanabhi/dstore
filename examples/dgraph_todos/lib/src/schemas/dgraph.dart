import 'package:dstore/dstore.dart';

@GraphqlSchema(
  path: ".2",
  database: GraphqlDatabase.dgraph,
)
class LearnSchema {
  late Objects objects;
}

abstract class Node {
  late ID id;
}

class Task implements Node {
  // late ID id;
  late String text;
  late bool completed;

  @override
  late ID id;
}

class Objects with Task {}
