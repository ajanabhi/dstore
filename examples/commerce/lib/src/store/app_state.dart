import 'package:commerce/src/store/pstates/auth.dart';
import 'package:commerce/src/store/pstates/login_screen_state.dart';
import 'package:dstore/dstore.dart';

part "app_state.dstore.dart";

@AppStateAnnotation()
class AppState extends AppStateI<AppState> with _$AppState {
  late final Auth auth;
  late final LoginScreenState loginScreen;
}

final store = Store<AppState, dynamic>(
    meta: createAppStateMeta(),
    stateCreator: () => AppState(),
    middlewares: [loggingMiddleware, formMiddleware, streamMiddleware]);
