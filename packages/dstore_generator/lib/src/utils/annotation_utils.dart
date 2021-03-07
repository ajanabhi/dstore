import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import "package:collection/collection.dart";

abstract class AnnotationUtils {
  static bool hasJsonKey(Element element) =>
      TypeChecker.fromRuntime(JsonKey).hasAnnotationOf(element);

  static String? defaultValue(Element element) {
    final tc = TypeChecker.fromRuntime(Default);
    final annot =
        element.metadata.singleWhereOrNull((e) => tc.isExactly(e.element));
    if (annot == null) {
      return null;
    }
    final s = annot.toSource().trim();
    return s.substring(s.indexOf("("), s.length - 1);
  }
}

extension ParameterElementExt on ParameterElement {
  bool get hasJsonKey => AnnotationUtils.hasJsonKey(this);
  String? get defaultValue => AnnotationUtils.defaultValue(this);
}

extension FieldElementExt on FieldElement {
  bool get hasJsonKey => AnnotationUtils.hasJsonKey(this);
}
