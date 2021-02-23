import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore/dstore.dart';
import 'package:dstore_generator/src/utils/utils.dart';
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
    final fields = processFields(convertParamElementsToFields(ctor.parameters));
    final name = element.name;
    print("Params : $fields");
    return """
      ${_createMixin(name, fields)}

      ${_createClass(name, fields)}

      ${ModelUtils.createCopyWithClasses(name, fields)}
    """;
  }
}

String _createMixin(String name, List<Field> fields) {
  // final params = fields
  //     .map((f) =>
  //         "${(f.type.endsWith("?") || f.isOptional) ? "Nullable<${f.type.replaceFirst("?", "")}>?" : "${f.type}?"} ${f.name}")
  //     .join(", ");
  return """
   mixin _\$$name {

    ${fields.map((f) => "${f.isOptional && !f.type.endsWith("?") ? "${f.type}?" : f.type} get ${f.name};").join("\n")}
    
    @JsonKey(ignore: true)
    \$${name}CopyWith<${name}> get copyWith;
   
   }
  """;
}

String _createClass(String name, List<Field> fields) {
  final className = "_$name";
  return """
   class $className implements $name {
     
     ${ModelUtils.getFinalFieldsFromFieldsList(fields, addOverrideAnnotation: true)}
     
     ${ModelUtils.getCopyWithField(name)}
      
     ${ModelUtils.createConstructorFromFieldsList(className, fields)}
     
     ${ModelUtils.createEqualsFromFieldsList(className, fields)}

     ${ModelUtils.createHashcodeFromFieldsList(fields)}

     ${ModelUtils.createToStringFromFieldsList(name, fields)}
   }
  
  """;
}
