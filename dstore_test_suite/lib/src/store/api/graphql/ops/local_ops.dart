import 'package:dstore/dstore.dart';
import 'package:dstore_test_suite/src/store/api/graphql/local.dart';
part "local_ops.api.dstore.dart";
part "local_ops.g.dart";

@GraphqlOps(localAPi)
abstract class LocalOps {
  static final ping = Query()..ping();
  static final users = Query()..users(Person());
}
