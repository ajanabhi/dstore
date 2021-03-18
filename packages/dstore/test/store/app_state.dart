import 'package:dstore/dstore.dart';
import 'package:dstore/src/store.dart';

import '../store_tester.dart';
import 'pstates/sample.dart';

part "app_state.dstore.dart";

@AppStateAnnotation()
class AppState with _$AppState implements AppStateI {
  late final Sample sample;
}

final testStore = StoreTester(Store(
    meta: createAppStateMeta(sample: SampleMeta),
    stateCreator: () => AppState()));
