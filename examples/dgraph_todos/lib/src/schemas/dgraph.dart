import 'package:dstore/dstore.dart';

@GraphqlSchema(
  path: ".2",
  database: GraphqlDatabase.dgraph,
)
class LearnSchema {
  late Objects objects;
}

class Task {
  late ID id;
  late String text;
  late bool completed;
}

class Objects with Task {}
