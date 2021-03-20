import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/errors.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

class AppStateGenerator extends GeneratorForAnnotation<AppStateAnnotation> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    try {
      if (!(element is ClassElement)) {
        throw NotAllowedError("AppStateAnnotation can only be used on classes");
      }
      if (element.constructors.length != 1 ||
          !element.constructors.first.isDefaultConstructor) {
        throw NotAllowedError("only default constructor is allowed");
      }
      final classElement = element;
      final name = classElement.name;
      final fields = classElement.fields;
      // print("fields2 ${fields.map((e) => e.type.element!.displayName)}");
      final copyWithMapBody = fields
          .map((f) => "..${f.name} = map[\"${f.name}\"] ?? this.${f.name}")
          .join("\n");

      final copyWithMap =
          "${name} copyWithMap(Map<String,dynamic> map) => ${name}()${copyWithMapBody};";

      final toMap =
          """Map<String,PStateModel> toMap() => {${fields.map((f) => """ "${f.name}" : this.${f.name} """).join(", ")}};""";

      final fieldGetters =
          fields.map((f) => "${f.type} get ${f.name};").join("\n");

      final createMeta = """
       Map<String,PStateMeta> create${name}Meta() {
          return {${fields.map((f) => """ "${f.name}" : ${f.type}Meta """).join(", ")}};
       }
    """;
      return """
      mixin _\$${name} {
        ${fieldGetters}
        ${copyWithMap}
        ${toMap}
      }
     ${createMeta}
    """;
    } catch (e, st) {
      logger.error("Error generating AppState for ${element.name}", e, st);
      rethrow;
    }
  }
}
