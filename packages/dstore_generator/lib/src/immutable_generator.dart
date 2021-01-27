import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore/dstore.dart';
import 'package:dstore_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

class DImmutableGenerator extends GeneratorForAnnotation<DImmutable> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (!(element is ClassElement) || !element.isAbstract) {
      throw Exception("DImmutable should only be used on immutable classes");
    }
    print("ctors ${element.constructors.length}");
    if (element.constructors.length != 1 ||
        !element.constructors.first.isFactory) {
      throw Exception(
          "DImmutable class should contain only single factory constructor");
    }
    final ctor = element.constructors.first;
    if (!ctor.parameters.every((p) => p.isNamed)) {
      throw Exception(
          "DImmutable constructor should contain only named params");
    }
    final fields = convertParamElementsToFields(ctor.parameters);
    final name = element.name;
    print("Params : $fields");
    return """
      ${_createMixin(name, fields)}

      ${_createClass(name, fields)}
    """;
  }
}

String _createMixin(String name, List<Field> fields) {
  final params = fields
      .map((f) =>
          "${(f.type.endsWith("?") || f.isOptional) ? "Nullable<${f.type.replaceFirst("?", "")}>?" : "${f.type}?"} ${f.name}")
      .join(", ");
  return """
   mixin _\$$name {

    ${fields.map((f) => "${f.type} get ${f.name};").join("\n")}
    
    $name copyWith({$params});
   }
  """;
}

String _createClass(String name, List<Field> fields) {
  final className = "_$name";
  return """
   class $className implements $name {
     
     ${getFinalFieldsFromFieldsList(fields, addOverrideAnnotation: true)}

     ${createConstructorFromFieldsList(className, fields)}
     
     @override
     ${createCopyWithFromFieldsList(className, fields)}
     
     ${createEqualsFromFieldsList(className, fields)}

     ${createHashcodeFromFieldsList(fields)}

     ${createToStringFromFieldsList(name, fields)}
   }
  
  """;
}
