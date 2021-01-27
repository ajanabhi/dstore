import 'dart:convert';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';

AstNode getAstNodeFromElement(Element element) {
  AnalysisSession session = element.session;
  ParsedLibraryResult parsedLibResult =
      session.getParsedLibraryByElement(element.library);
  ElementDeclarationResult elDeclarationResult =
      parsedLibResult.getElementDeclaration(element);
  return elDeclarationResult.node;
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

String getFinalFieldsFromFieldsList(List<Field> fields,
    {bool addLateModifier = false, bool addOverrideAnnotation = false}) {
  return fields.map((f) {
    final type =
        f.isOptional && !f.type.endsWith("?") ? "${f.type}?" : "${f.type}";
    return """
     ${addOverrideAnnotation ? "@override" : ""}
     ${addLateModifier ? "late" : ""} final $type ${f.name};
    """;
  }).join("\n ");
}

String createConstructorFromFieldsList(String name, List<Field> fields,
    {bool assignDefaults = false}) {
  final cf = fields.map((f) {
    return "${!f.isOptional ? "required" : ""} this.${f.name} ${assignDefaults && f.value != null ? "= ${f.value}" : ""}";
  }).join(", ");
  return "const ${name}({$cf});";
}

String createCopyWithFromFieldsList(String name, List<Field> fields,
    {bool emptyConstructor = false}) {
  final params = fields
      .map((f) =>
          "${(f.type.endsWith("?") || f.isOptional) ? "Nullable<${f.type.replaceFirst("?", "")}>?" : "${f.type}?"} ${f.name}")
      .join(", ");
  var cons = "";
  if (emptyConstructor) {
    final cfields = fields
        .map((f) =>
            "..${f.name} = ${(f.type.endsWith("?") || f.isOptional) ? "${f.name} != null ? ${f.name}.value : this.${f.name}" : "${f.name} ?? this.${f.name}"} }")
        .join("");
    cons = "${name}()$cfields;";
  } else {
    final cfields = fields
        .map((f) =>
            "${f.name} : ${(f.type.endsWith("?") || f.isOptional) ? "${f.name} != null ? ${f.name}.value : this.${f.name}" : "${f.name} ?? this.${f.name}"}")
        .join(", ");
    cons = "${name}($cfields);";
  }
  return """$name copyWith({$params}) => $cons""";
}

String createCopyWithMapFromFieldsList(String name, List<Field> fields,
    {bool emptyConstructor = false}) {
  var cons = "";
  if (emptyConstructor) {
    final cfields = fields
        .map((f) => "..${f.name} = map[\"${f.name}\"] ?? this.${f.name}")
        .join("");
    cons = "${name}()$cfields;";
  } else {
    final cfields = fields
        .map((f) => "${f.name} : map[\"${f.name}\"] ?? this.${f.name}")
        .join(", ");
    cons = "${name}($cfields);";
  }
  return """
  @override
  $name copyWithMap(Map<String,dynamic> map) => $cons
  """;
}

String createToMapFromFieldsList(List<Field> fields) {
  return """Map<String,dynamic> toMap() => {${fields.map((f) => """ "${f.name}" : this.${f.name} """).join(", ")}};""";
}

String createToStringFromFieldsList(String name, List<Field> fields) {
  return """
  @override
  String toString() => "${name}(${fields.map((f) => "${f.name}: this.${f.name}").join(", ")})";
   """;
}

String createToJson(String name) {
  return "Map<String,dynamic> toJson() => _\$${name}ToJson(this);";
}

String createFromJson(String name) {
  return "factory ${name}.fromJson(Map<String,dynamic> json) => _\$${name}FromJson(json)";
}

String createEqualsFromFieldsList(String name, List<Field> fields) {
  return """
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is $name && ${fields.map((f) => "o.${f.name} == ${f.name}").join(" && ")};
    }
  """;
}

String createHashcodeFromFieldsList(List<Field> fields) {
  return """
    @override 
    int get hashCode => ${fields.map((f) => "${f.name}.hashCode").join(" ^ ")};
  """;
}
