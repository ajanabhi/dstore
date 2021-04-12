import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/errors.dart';
import 'package:dstore_generator/src/open_api/generator_helper.dart';
import 'package:dstore_generator/src/utils/logger.dart';
import 'package:source_gen/source_gen.dart';

class OpenApiGenerator extends GeneratorForAnnotation<OpenApi> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    try {
      if (!(element is ClassElement)) {
        throw NotAllowedError("OpenAPi Annotation can only be used on classes");
      }

      return createOpenApi(element: element, buildStep: buildStep);
    } catch (e, st) {
      logger.error("Error generating AppState for ${element.name}", e, st);
      rethrow;
    }
  }
}