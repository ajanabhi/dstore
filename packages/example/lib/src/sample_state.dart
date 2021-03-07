import "package:dstore/dstore.dart";
import 'package:dstore_example/src/pstates/sample.dart';
import 'package:dstore_example/src/pstates/sample2.dart';
import 'package:meta/meta.dart';
part 'sample_state.dstore.dart';

@AppStateAnnotation()
class AppState with _$AppState implements AppStateI {
  late final Sample sample;
  late final Sample2 sample2;
}
