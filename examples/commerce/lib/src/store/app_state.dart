import 'package:commerce/src/store/pstates/auth.dart';
import 'package:dstore/dstore.dart';

part "app_state.dstore.dart";

@AppStateAnnotation()
class AppState extends AppStateI<AppState> with _$AppState {
  late final Auth auth;
}

final store = Store<AppState, dynamic>(
    meta: createAppStateMeta(),
    stateCreator: () => AppState(),
    middlewares: [loggingMiddleware, streamMiddleware]);
