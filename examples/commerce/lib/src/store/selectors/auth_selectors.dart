import 'package:commerce/src/store/app_state.dart';
import 'package:commerce/src/store/pstates/auth.dart';
import 'package:dstore/dstore.dart';

part "auth_selectors.dstore.dart";

@Selectors()
// ignore: unused_element
class _AuthSelectors {
  static Auth auth(AppState state) => state.auth;
}
