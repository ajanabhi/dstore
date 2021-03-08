import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/pstate/pstate_generator.dart';
import 'package:dstore_generator/src/pstate/types.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import './utils.dart';
import "package:collection/collection.dart";

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

  static List<Field> convertParamElementsToFields(List<ParameterElement> params,
      {bool dim = false}) {
    return params.map((param) {
      final name = param.name;
      final type = param.type != null
          ? param.type.getDisplayString(withNullability: true)
          : "dynamic";
      var defaultValue = param.defaultValue;
      var annotations = param.metadata.map((e) => e.toSource()).toList();
      var isOptional = param.isOptional;
      if (dim) {
        if (param.isOptional && !type.endsWith("?")) {
          defaultValue = param.defaultValue;
          if (defaultValue == null) {
            throw ArgumentError.value(
                "Should provide Default for field ${name} using @Default annotation in DImmutable models");
          }
          isOptional = false;
          if (param.hasJsonKey) {
            final jsonKeyAnnot = param.annotationFromType(JsonKey);
            if (!jsonKeyAnnot!.toSource().contains("defaultValue")) {
              // jsonKey doesnt have defaultValue but Default is specified as Default annotation so lets merge
              annotations = param
                  .addDefaultValueToJsonKeyAndReturnAnnotations(defaultValue);
              logger.shout(
                  "Default value $defaultValue annotationation $annotations");
            }
          } else {
            annotations.add("@JsonKey(defaultValue : $defaultValue)");
          }
        }
      }

      return Field(
        name: name,
        type: type,
        annotations: annotations,
        value: defaultValue,
        isOptional: isOptional,
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

abstract class AnnotationUtils {
  static bool hasJsonKey(Element element) =>
      TypeChecker.fromRuntime(JsonKey).hasAnnotationOf(element);

  static String? defaultValue(Element element) {
    final annot = element.annotationFromType(Default);
    if (annot == null) {
      return null;
    }
    final s = annot.toSource().trim();
    return s.substring(s.indexOf("(") + 1, s.length - 1);
  }

  static List<String> addDefaultValueToJsonKeyAndReturnAnnotations(
      Element element, Object? value) {
    final tc = TypeChecker.fromRuntime(JsonKey);
    return element.metadata.map((e) {
      final type = e.type;
      if (type != null && tc.isAssignableFromType(type)) {
        var source = e.toSource().trim();
        if (source.endsWith(")")) {
          source = source.substring(0, source.length - 1);
        } else if (source.endsWith(",)")) {
          source = source.substring(0, source.length - 2);
        }

        return "${source},defaultValue : $value)";
      }
      return e.toSource();
    }).toList();
  }
}

extension ElementExt on Element {
  ElementAnnotation? annotationFromType(Type type) {
    final tc = TypeChecker.fromRuntime(type);
    return metadata.singleWhereOrNull((e) {
      final v = e.computeConstantValue();
      return v != null && v.type != null && tc.isAssignableFromType(v.type);
    });
  }
}

extension ElementAnnotationExt on ElementAnnotation {
  DartType? get type {
    final v = computeConstantValue();
    return v?.type;
  }
}

extension ParameterElementExt on ParameterElement {
  bool get hasJsonKey => AnnotationUtils.hasJsonKey(this);
  String? get defaultValue => AnnotationUtils.defaultValue(this);

  List<String> addDefaultValueToJsonKeyAndReturnAnnotations(Object? value) =>
      AnnotationUtils.addDefaultValueToJsonKeyAndReturnAnnotations(this, value);
}

extension ConstReadExt on ConstantReader {
  T? enumValue<T>(List<T> values) {
    return values
        .singleWhereOrNull((e) => read(e.toString().split(".")[1]) != null);
  }
}

extension FieldElementExt on FieldElement {
  bool get hasJsonKey => AnnotationUtils.hasJsonKey(this);

  List<String> addDefaultValueToJsonKeyAndReturnAnnotations(Object? value) =>
      AnnotationUtils.addDefaultValueToJsonKeyAndReturnAnnotations(this, value);
}
