import 'dart:convert';
export "model_utils.dart";
export "ast_utils.dart";
export "logger.dart";
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dstore/dstore.dart';
import 'package:meta/meta.dart';

class Field {
  String name;
  String type;
  String? value;
  List<String>? annotations;
  bool isOptional;
  FormalParameter? param;
  Field(
      {required this.name,
      required this.type,
      this.value,
      this.annotations,
      this.param,
      this.isOptional = false});

  @override
  String toString() {
    return "Field(Name : ${name} Type : ${type} Value : ${value} isOptional : $isOptional annotations : $annotations)";
  }

  Field copyWith({
    String? name,
    String? type,
    String? value,
    List<String>? annotations,
    bool? isOptional,
    FormalParameter? param,
  }) {
    return Field(
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
      annotations: annotations ?? this.annotations,
      isOptional: isOptional ?? this.isOptional,
      param: param ?? this.param,
    );
  }
}

String replaceEndStar(String input) {
  var result = input;
  if (input.endsWith("*")) {
    result = input.substring(0, input.length - 1);
  }
  return result;
}

String _getFinalTypeOfField(Field f) {
  return (!f.type.endsWith("?") && f.isOptional) ? "${f.type}?" : f.type;
}

List<Field> processFields(List<Field> fields) {
  return fields
      .map((f) => f.copyWith(
          type: _getFinalTypeOfField(f),
          isOptional: f.isOptional ? f.isOptional : f.type.endsWith("?")))
      .toList();
}

enum PersistMode { ExplicitPersist, ExplicitNoPersist }

abstract class Globals {
  static var psBuilderOptions = PStateGeneratorBuildOptions();
}

class PStateGeneratorBuildOptions {
  final PersistMode? persistMode;

  PStateGeneratorBuildOptions({this.persistMode});

  static void fromOptions(Map<String, dynamic> config) {
    PersistMode? persistMode;
    // final pms = config["persistMode"];
    // if (pms != null) {
    //   if (pms != "ExplicitPersist" && pms != "ExplicitNoPersist") {
    //     throw Exception(
    //         "You should provide persistMode one of two options ExplicitPersist or ExplicitNoPersist");
    //   }
    //   persistMode = convertStringToEnum(pms, PersistMode.values);
    // }
    final options = PStateGeneratorBuildOptions(persistMode: persistMode);
    Globals.psBuilderOptions = options;
  }
}
