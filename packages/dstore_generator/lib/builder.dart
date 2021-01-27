import 'package:build/build.dart';
import 'package:dstore_generator/src/app_state_generator.dart';
import 'package:dstore_generator/src/immutable_generator.dart';
import 'package:dstore_generator/src/pstate_generator.dart';
import 'package:dstore_generator/src/selectors_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Builds generators for `build_runner` to run
Builder dstoreGen(BuilderOptions options) {
  print("************************* options ${options.config}");

  return PartBuilder(
      [
        PStateGenerator(),
        SelectorsGenerator(),
        AppStateGenerator(),
        DImmutableGenerator()
      ],
      '.dstore.dart',
      header: '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies
    ''');
}
