import 'package:commerce/src/store/pstates/auth.dart';
import 'package:commerce/src/store/pstates/login_screen_state.dart';
import 'package:dstore/dstore.dart';

part "app_state.dstore.dart";

@AppStateAnnotation()
void $_AppState(Auth auth, LoginScreenState loginScreen) {}

final store = createStore(
    middlewares: [loggingMiddleware, formMiddleware, streamMiddleware]);
