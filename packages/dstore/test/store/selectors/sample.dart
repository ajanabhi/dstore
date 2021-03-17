import 'package:dstore/dstore.dart';

import '../app_state.dart';

part "sample.dstore.dart";

@Selectors()
abstract class _SampleSelectors {
  static String sampleName(AppState state) {
    return state.sample.name;
  }
}
