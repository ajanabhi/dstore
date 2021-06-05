import 'package:dstore/dstore.dart';
import 'package:dstore_test_suite/src/store/app_state.dart';
import 'package:dstore_test_suite/src/store/pstates/selectors/simple_flutter_selectors.dart';
import 'package:dstore_test_suite/src/store/pstates/selectors/simple_selector_ps.dart';
import 'package:dstore_test_suite/src/store/pstates/simple_form_ps.dart';
part 'app_selectors.dstore.dart';

final s = "";

@Selectors()
class $_AppSelectors {
  static SimpleSelectorPS simpleSelector(AppState state) =>
      state.simpleSelectorPS;

  static SimpleFlutterSelectors simpleFlutterSelector(AppState state) =>
      state.simpleFlutterSelector;

  static SimpleFormPS simpleForm(AppState state) => state.simpleFormPS;
}
