import 'package:dstore/dstore.dart';
import 'package:dstore_test_suite/src/store/api/graphql/local.dart';
part "local_ops.api.dstore.dart";
part "local_ops.g.dart";

final s = "23";

@GraphqlOps(localAPi)
abstract class LocalGraphqlOps {
  static final ping = Query()..ping();
  static final users = Query()..users(Person());
  static final chnageNameWithVariables = Mutation("\$name: String!")
    ..changeName(name: "\$name");
  static final errorQ = Query()..errorQ();
}
