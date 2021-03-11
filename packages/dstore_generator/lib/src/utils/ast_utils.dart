import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
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

  static String addConstToDefaultValue(String value) {
    return !value.trimLeft().startsWith("const") &&
            (value.contains("(") || value.contains("[") || value.contains("{"))
        ? "const $value"
        : value;
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
              annotations = param.mergeJsonKeyAndReturnAnnotations(
                  {"defaultValue": defaultValue});
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
    final v = s.substring(s.indexOf("(") + 1, s.length - 1);
    return AstUtils.addConstToDefaultValue(v);
  }

  static List<String> mergeJsonKeyAndReturnAnnotations(
      Element element, Map<String, dynamic> newFields) {
    final tc = TypeChecker.fromRuntime(JsonKey);
    return element.metadata.map((e) {
      final type = e.type;
      if (type != null && tc.isAssignableFromType(type)) {
        final o = e.computeConstantValue();
        final key = getJsonKeyFromDartObject(o!);
        return key.copyWithMap(newFields).toSource();
      }
      return e.toSource();
    }).toList();
  }

  static JsonKey getJsonKeyFromDartObject(DartObject o) {
    final reader = ConstantReader(o);
    dynamic defaultValue;
    final defaultValueField = reader.peek("defaultValue");
    if (defaultValueField != null) {
      defaultValue = defaultValueField.literalValue;
    }

    dynamic disallowNullValue;
    final disallowNullValueField = reader.peek("disallowNullValue");
    if (disallowNullValueField != null) {
      disallowNullValue = disallowNullValueField.literalValue;
    }

    dynamic fromJson;
    final fromJsonField = reader.peek("fromJson");
    if (fromJsonField != null) {
      fromJson = fromJsonField.literalValue;
    }

    dynamic ignore;
    final ignoreField = reader.peek("ignore");
    if (ignoreField != null) {
      ignore = ignoreField.literalValue;
    }

    dynamic includeIfNull;
    final includeIfNullField = reader.peek("includeIfNull");
    if (includeIfNullField != null) {
      includeIfNull = includeIfNullField.literalValue;
    }

    dynamic name;
    final nameField = reader.peek("name");
    if (nameField != null) {
      name = nameField.literalValue;
    }

    dynamic required;
    final requiredField = reader.peek("required");
    if (requiredField != null) {
      required = requiredField.literalValue;
    }

    dynamic toJson;
    final toJsonField = reader.peek("toJson");
    if (toJsonField != null) {
      toJson = toJsonField.literalValue;
    }

    dynamic unknownEnumValue;
    final unknownEnumValueField = reader.peek("unknownEnumValue");
    if (unknownEnumValueField != null) {
      unknownEnumValue = unknownEnumValueField.literalValue;
    }

    return JsonKey(
        defaultValue: defaultValue,
        disallowNullValue: disallowNullValue,
        fromJson: fromJson,
        ignore: ignore,
        includeIfNull: includeIfNull,
        name: name,
        required: required,
        toJson: toJson,
        unknownEnumValue: unknownEnumValue);
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

extension VariableDeclarationExt on VariableDeclaration {
  Annotation? annotationFromType(Type type) {
    final tc = TypeChecker.fromRuntime(type);
    return this.metadata.singleWhereOrNull((e) {
      final v = e.elementAnnotation?.computeConstantValue();
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

extension JsonKeyExt on JsonKey {
  JsonKey copyWithMap(Map<String, dynamic> map) {
    return JsonKey(
        defaultValue: map.containsKey("defaultValue")
            ? map["defaultValue"]
            : defaultValue,
        disallowNullValue: map.containsKey("disallowNullValue")
            ? map["disallowNullValue"]
            : disallowNullValue,
        fromJson: map.containsKey("fromJson") ? map["fromJson"] : fromJson,
        ignore: map.containsKey("ignore") ? map["ignore"] : ignore,
        includeIfNull: map.containsKey("includeIfNull")
            ? map["includeIfNull"]
            : includeIfNull,
        name: map.containsKey("name") ? map["name"] : name,
        required: map.containsKey("required") ? map["required"] : required,
        toJson: map.containsKey("toJson") ? map["toJson"] : toJson,
        unknownEnumValue: map.containsKey("unknownEnumValue")
            ? map["unknownEnumValue"]
            : unknownEnumValue);
  }

  String toSource() =>
      "@JsonKey(defaultValue : $defaultValue, disallowNullValue : $disallowNullValue, fromJson : $fromJson, ignore : $ignore, includeIfNull : $includeIfNull, name : $name, required : $required, toJson : $toJson, unknownEnumValue : $unknownEnumValue)";
}

extension ParameterElementExt on ParameterElement {
  bool get hasJsonKey => AnnotationUtils.hasJsonKey(this);
  String? get defaultValue => AnnotationUtils.defaultValue(this);

  List<String> mergeJsonKeyAndReturnAnnotations(
          Map<String, dynamic> newFields) =>
      AnnotationUtils.mergeJsonKeyAndReturnAnnotations(this, newFields);
}

extension ConstReadExt on ConstantReader {
  T? enumValue<T>(List<T> values) {
    return values
        .singleWhereOrNull((e) => read(e.toString().split(".")[1]) != null);
  }
}

extension FieldElementExt on FieldElement {
  bool get hasJsonKey => AnnotationUtils.hasJsonKey(this);

  List<String> mergeJsonKeyAndReturnAnnotations(
          Map<String, dynamic> newFields) =>
      AnnotationUtils.mergeJsonKeyAndReturnAnnotations(this, newFields);
}