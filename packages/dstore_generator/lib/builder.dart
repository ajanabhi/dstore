import 'package:build/build.dart';
import 'package:dstore_generator/src/appstate/app_state_generator.dart';
import 'package:dstore_generator/src/denum/denum_generator.dart';
import 'package:dstore_generator/src/dunion/union_generator.dart';
import 'package:dstore_generator/src/form/form_model_generator.dart';
import 'package:dstore_generator/src/graphql/graphql_ops_generator.dart';
import 'package:dstore_generator/src/graphql/schema_generator.dart';
import 'package:dstore_generator/src/dimmutable/immutable_generator.dart';
import 'package:dstore_generator/src/pstate/nav/nav.dart';
import 'package:dstore_generator/src/pstate/pstate_generator.dart';
import 'package:dstore_generator/src/pstate_nav/pstate_navgenerator.dart';
import 'package:dstore_generator/src/selectors/selectors_generator.dart';
import 'package:dstore_generator/src/utils/builder_utils.dart';
import 'package:source_gen/source_gen.dart';

var lDebugMode = true;

/// Builds generators for `build_runner` to run
Builder dstorePSGen(BuilderOptions options) {
  print("************************* options ${options.config}");
  PStateGeneratorBuildOptions.fromOptions(options.config);
  return PartBuilder(
    [PStateGenerator(), PStaeNavGenrator()],
    '.ps.dstore.dart',
  );
}

Builder dstoreGqlGen(BuilderOptions options) {
  print("************************* options ${options.config}");

  return PartBuilder(
    [GraphlSchemaGenerator(), GraphqlOpsGenerator()],
    '.gql.dstore.dart',
  );
}

Builder dstoreGen(BuilderOptions options) {
  return PartBuilder(
      [
        FormModelGenerator(),
        UnionGenerator(),
        AppStateGenerator(),
        SelectorsGenerator(),
        DEnumGenerator(),
        DImmutableGenerator(),
      ],
      '.dstore.dart',
      header: '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies
    ''');
}
