import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
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
  String value;
  bool isOptional;
  FormalParameter param;
  Field(
      {@required this.name,
      @required this.type,
      @required this.value,
      @required this.param,
      this.isOptional = false}) {}

  @override
  String toString() {
    return "Field(Name : ${name} Type : ${type} Value : ${value})";
  }
}

List<Field> convertParamsToFields(FormalParameterList parameters) {
  return parameters.parameters.map((param) {
    final name = param.identifier.toString();
    String type = null;
    String value = null;
    if (param is SimpleFormalParameter) {
      type = param.type?.toString() ?? "dynamic";
    }
    if (param is DefaultFormalParameter) {
      value = param.defaultValue?.toString();
      final t = (param.parameter as SimpleFormalParameter).type;
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
