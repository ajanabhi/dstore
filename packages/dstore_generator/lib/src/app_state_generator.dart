import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore/dstore.dart';
import 'package:source_gen/source_gen.dart';

class AppStateGenerator extends GeneratorForAnnotation<AppStateAnnotation> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (!(element is ClassElement)) {
      throw Exception("AppStateAnnotation can only be used on classes");
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
        fields.map((f) => "PStateModel get ${f.name};").join("\n");

    final createMeta = """
       Map<String,PStateMeta> create${name}Meta({${fields.map((f) => "required PStateMeta ${f.name}").join(", ")}}) {
          return {${fields.map((f) => """ "${f.name}" : ${f.name} """).join(", ")}};
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
  }
}
