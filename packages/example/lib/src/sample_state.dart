import "package:dstore/dstore.dart";
import 'package:dstore_example/src/pstates/sample.dart';
import 'package:meta/meta.dart';
part 'sample_state.dstore.dart';

@AppStateAnnotation()
class AppState with _$AppState implements AppStateI {
  final Sample sample;

  AppState({this.sample});
}
