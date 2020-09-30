import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dstore/dstore.dart';

class ReducerGenerator extends GeneratorForAnnotation<Reducer> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    // TODO: implement generateForAnnotatedElement
    return "//Todo";
  }
}
