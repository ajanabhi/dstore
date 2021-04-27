import 'package:dstore/dstore.dart';

@GraphqlSchema(
  path: ".",
  database: GraphqlDatabase.dgraph,
)
class LearnSchema {}
