import 'dart:convert';
export "model_utils.dart";
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dstore/dstore.dart';
import 'package:meta/meta.dart';

AstNode getAstNodeFromElement(Element element) {
  AnalysisSession session = element.session;
  ParsedLibraryResult parsedLibResult =
      session.getParsedLibraryByElement(element.library);
  ElementDeclarationResult elDeclarationResult =
      parsedLibResult.getElementDeclaration(element);
  return elDeclarationResult.node;
}

Future<AstNode> getResolvedAstNodeFromElement(Element element) async {
  AnalysisSession session = element.session;

  final s = await session.getResolvedLibraryByElement(element.library);
  final s2 = s.getElementDeclaration(element);

  return s2.node;
}

class Field {
  String name;
  String type;
  String? value;
  bool isOptional;
  FormalParameter? param;
  Field(
      {required this.name,
      required this.type,
      this.value,
      this.param,
      this.isOptional = false});

  @override
  String toString() {
    return "Field(Name : ${name} Type : ${type} Value : ${value})";
  }

  Field copyWith({
    String? name,
    String? type,
    String? value,
    bool? isOptional,
    FormalParameter? param,
  }) {
    return Field(
      name: name ?? this.name,
      type: type ?? this.type,
      value: value ?? this.value,
      isOptional: isOptional ?? this.isOptional,
      param: param ?? this.param,
    );
  }
}

List<Field> convertParamsToFields(FormalParameterList parameters) {
  return parameters.parameters.map((param) {
    final name = param.identifier.toString();
    late String type;
    String? value;
    if (param is SimpleFormalParameter) {
      type = param.type?.toString() ?? "dynamic";
    }
    if (param is DefaultFormalParameter) {
      value = param.defaultValue?.toString();
      final t =
          (param.parameter as SimpleFormalParameter).type as TypeAnnotation?;
      type = t?.toString() ?? "dynamic";
    }
    return Field(
        name: name,
        type: type,
        value: value,
        isOptional: param.isOptional,
        param: param);
  }).toList();
}

List<Field> convertParamElementsToFields(List<ParameterElement> params) {
  return params.map((param) {
    final name = param.name;
    final type = param.type != null
        ? param.type.getDisplayString(withNullability: true)
        : "dynamic";
    return Field(
      name: name,
      type: type,
      value: param.defaultValueCode,
      isOptional: param.isOptional,
    );
  }).toList();
}

InterfaceType? isSubTypeof(DartType sourceType, String superType) {
  InterfaceType? result;
  if (sourceType is InterfaceType) {
    for (final t in sourceType.allSupertypes) {
      var name = t.getDisplayString(withNullability: false);
      if (name.contains("<")) {
        name = name.substring(0, name.indexOf("<"));
      }
      if (name == superType) {
        result = t;
        break;
      }
    }
  }
  return result;
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
