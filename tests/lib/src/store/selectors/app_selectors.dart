import 'package:dstore/dstore.dart';
import 'package:dstore_test_suite/src/store/app_state.dart';
import 'package:dstore_test_suite/src/store/pstates/simple_ps.dart';
part 'app_selectors.dstore.dart';

@Selectors()
class $_AppSelectors {
  static Simple simple(AppState state) => state.simple;
}
