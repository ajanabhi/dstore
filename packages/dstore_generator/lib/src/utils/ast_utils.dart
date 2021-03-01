import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import './utils.dart';
import "package:collection/collection.dart";

extension AstCollectionExt<T> on List<T> {
  Annotation? annotation(String name) {
    final list = this as List<Annotation>;
    return list
        .singleWhereOrNull((element) => element.toString().startsWith(name));
  }
}

abstract class AstUtils {
  static AstNode getAstNodeFromElement(Element element) {
    final session = element.session!;
    final parsedLibResult = session.getParsedLibraryByElement(element.library!);
    final elDeclarationResult = parsedLibResult.getElementDeclaration(element)!;
    return elDeclarationResult.node;
  }

  static Future<AstNode> getResolvedAstNodeFromElement(Element element) async {
    final session = element.session!;
    final s = await session.getResolvedLibraryByElement(element.library!);
    final s2 = s.getElementDeclaration(element)!;

    return s2.node;
  }

  static List<Field> convertParamsToFields(FormalParameterList? parameters,
      {bool isDImmutable = false}) {
    if (parameters == null) {
      return [];
    }
    return parameters.parameters.map((param) {
      final name = param.identifier.toString();
      var isOptional = param.isOptional;
      late String type;
      String? value;
      if (param is SimpleFormalParameter) {
        print("simpleformal");
        type = param.type?.toString() ?? "dynamic";
      }
      final annotations = param.metadata.map((e) => e.toString()).toList();
      if (param is DefaultFormalParameter) {
        print("defaultformal");
        value = param.defaultValue?.toString();
        final t = (param.parameter as SimpleFormalParameter).type;
        type = t?.toString() ?? "dynamic";
        if (isDImmutable && param.isOptional && !type.endsWith("?")) {
          final dAnno = param.metadata.annotation("@Default")?.toString();
          logger.warning(param.metadata.map((e) => e.toString()).toString());
          if (dAnno == null) {
            throw Exception(
                "Should provide Default for field ${name} using @Default annotation in DImmutable models");
          }
          value =
              dAnno.substring(dAnno.indexOf("(") + 1, dAnno.lastIndexOf(")"));
          isOptional = false;
          annotations.add("@JsonKey(defaultValue : $value)");
        }
      }
      return Field(
          name: name,
          type: type,
          value: value,
          annotations: annotations,
          isOptional: isOptional,
          param: param);
    }).toList();
  }

  static List<Field> convertParamElementsToFields(
      List<ParameterElement> params) {
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

  static InterfaceType? isSubTypeof(DartType sourceType, String superType) {
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
}
