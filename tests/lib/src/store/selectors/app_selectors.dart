import 'package:dstore/dstore.dart';
import 'package:dstore_test_suite/src/store/pstates/simple_ps.dart';
import 'package:dstore_test_suite/tests.dart';
part 'app_selectors.dstore.dart';

@Selectors()
class $_AppSelectors {
  static Simple simple(AppState state) => state.simple;
}
