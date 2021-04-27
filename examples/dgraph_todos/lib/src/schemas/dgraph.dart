import 'package:dstore/dstore.dart';

@GraphqlSchema(
  path: ".2",
  database: GraphqlDatabase.dgraph,
)
class LearnSchema {
  late Objects objects;
  late List<String> o1;
}

abstract class Node {
  late ID id;
}

abstract class Task implements Node {
  late String text;
  late bool completed;
}

abstract class Objects implements Task {}
