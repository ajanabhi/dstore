import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore/dstore.dart';
import 'package:source_gen/source_gen.dart';

class AppStateGenerator extends GeneratorForAnnotation<AppStateAnnotation> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (!(element is ClassElement)) {
      throw Exception("AppStateAnnotation can only be used on classes");
    }
    final classElement = element as ClassElement;
    final name = classElement.name;
    final fields = classElement.fields;
    final copyWithMapBody = fields
        .map((f) => "${f.name} : map[\"${f.name}\"] ?? this.${f.name}")
        .join(", ");

    final copyWithMap =
        "${name} copyWithMap(Map<String,dynamic> map) => ${name}(${copyWithMapBody});";

    final toMap =
        """Map<String,dynamic> toMap() => {${fields.map((f) => """ "${f.name}" : this.${f.name} """).join(", ")}};""";

    final getFields =
        """List<String> getFields() => const [${fields.map((f) => """ "${f.name}" """).join(", ")}];""";
    final fieldGetters =
        fields.map((f) => "${f.type} get ${f.name};").join("\n");
    return """
      mixin _\$${name} {
        ${fieldGetters}
        ${copyWithMap}
        ${toMap}
        ${getFields}
      }
    
    """;
  }
}
