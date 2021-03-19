import 'package:dstore/dstore.dart';
import 'package:dstore/src/middlewares.dart';
import 'package:dstore/src/store.dart';

import '../store_tester.dart';
import 'pstates/sample.dart';

part "app_state.dstore.dart";

@AppStateAnnotation()
class AppState with _$AppState implements AppStateI<AppState> {
  late final Sample sample;
}

final storeTester = StoreTester(Store<AppState, dynamic>(
    meta: createAppStateMeta(sample: SampleMeta),
    middlewares: [streamMiddleware],
    stateCreator: () => AppState()));
