import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:dstore_generator/src/pstate/generator.dart';
import 'package:dstore_generator/src/pstate/types.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';

class PStateGenerator extends GeneratorForAnnotation<PState> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    try {
      if (!(element is ClassElement)) {
        throw ArgumentError.value("PState should be applied on class only");
      }
      final className = element.name;
      if (!className.startsWith("\$")) {
        throw ArgumentError.value("PState class should start with \$");
      }
      return generatePStateForClassElement(element);
    } catch (e, st) {
      logger.error("Error in generate PState for ${element.name}", e, st);
      rethrow;
    }
  }
}
