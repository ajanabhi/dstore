import 'package:commerce/src/store/app_state.dart';
import 'package:commerce/src/store/pstates/login_screen_state.dart';
import 'package:dstore/dstore.dart';
part 'login_screen_selectors.dstore.dart';

@Selectors()
class $_LoginScreenSelectors {
  static LoginScreenState state(AppState state) {
    return state.loginScreen;
  }
}
