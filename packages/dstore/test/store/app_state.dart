import 'package:dstore/dstore.dart';
import 'package:dstore/src/middlewares/stream_middleware.dart';
import 'package:dstore/src/store.dart';

import '../store_tester.dart';
import 'pstates/sample.dart';
import 'pstates/sample2/sample2.dart';

part "app_state.dstore.dart";

@AppStateAnnotation()
void $_AppState(Sample sample, Sample2 sample2) {}

final storeTester = StoreTester(createStore(
  middlewares: [streamMiddleware],
));
