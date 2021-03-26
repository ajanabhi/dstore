import 'package:commerce/src/store/app_state.dart';
import 'package:commerce/src/store/pstates/snack.dart';
import 'package:dstore/dstore.dart';
import 'package:meta/meta.dart';
part 'app_selectors.dstore.dart';

@Selectors()
class $_AppSelectors {
  static SnackState snack(AppState state) => state.snack;
}
