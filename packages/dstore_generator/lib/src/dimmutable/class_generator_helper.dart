import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/dimmutable/vistors.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';

Future<String> generateDImmutableFromClass(
    {required ClassElement element, required BuildStep buildStep}) async {
  final dim = element.getDImmutableAnnotation();
  final tuple = AstUtils.getTypeParamsAndBounds(element.typeParameters);
  final typeParamsWithBounds = tuple.item2;
  final typeParams = tuple.item1;
  logger.shout("typeParams : $typeParamsWithBounds fields ${element.fields}");
  final visitor = DImmutableClassVisitor();
  final ast = await AstUtils.getAstNodeFromElement(element, buildStep);
  ast.visitChildren(visitor);
  final fields = ModelUtils.processFields(visitor.fields);
  final methods = visitor.methods.join("\n");
  final name = element.name.substring(2);
  print("Params : $fields");
  final isJosnSerializable = dim.isJsonSerializable;
  final result = """
      ${ModelUtils.createDefaultDartModelFromFeilds(fields: fields, methods: methods, className: name, typeParams: typeParams, typeParamsWithBounds: typeParamsWithBounds, isJsonSerializable: isJosnSerializable)}
    """;
  return result;
}

extension DImmutableEllementExt on Element {
  DImmutable getDImmutableAnnotation() {
    final annot = this.annotationFromType(DImmutable);
    if (annot == null) {
      throw ArgumentError.value(
          "Element ${this.name} is not anotated with @DImmutable");
    }
    final reader = ConstantReader(annot.computeConstantValue());
    final isJsonSerializable = reader.read("isJsonSerializable").boolValue;
    return DImmutable(isJsonSerializable: isJsonSerializable);
  }
}
