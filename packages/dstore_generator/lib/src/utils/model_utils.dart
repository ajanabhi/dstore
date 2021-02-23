import 'package:dstore_generator/src/utils/utils.dart';

abstract class ModelUtils {
  static String getFinalFieldsFromFieldsList(List<Field> fields,
      {bool addLateModifier = false, bool addOverrideAnnotation = false}) {
    return fields.map((f) {
      final type =
          f.isOptional && !f.type.endsWith("?") ? "${f.type}?" : "${f.type}";
      return """
     ${addOverrideAnnotation ? "@override" : ""}
     ${addLateModifier ? "late" : ""} final $type ${f.name};
    """;
    }).join("\n ");
  }

  static String createConstructorFromFieldsList(String name, List<Field> fields,
      {bool assignDefaults = false}) {
    final cf = fields.map((f) {
      return "${!f.isOptional ? "required" : ""} this.${f.name} ${assignDefaults && f.value != null ? "= ${f.value}" : ""}";
    }).join(", ");
    return "const ${name}({$cf});";
  }

  static String createHashcodeFromFieldsList(List<Field> fields) {
    return """
    @override 
    int get hashCode => ${fields.map((f) => "${f.name}.hashCode").join(" ^ ")};
  """;
  }

  static String createCopyWithClasses(String name, List<Field> fields) {
    final callParams = fields.map((f) => "${f.type} ${f.name}").join(", ");
    final callImplParams =
        fields.map((f) => "Object? ${f.name} = dimmutable").join(", ");
    final copyWithParams = fields
        .map((f) =>
            "${f.name} : ${f.name} == dimmutable ? _value.${f.name} : ${f.name} as ${f.type}")
        .join(", ");
    final aName = "\$${name}CopyWith";
    final aImplName = "_${aName}Impl";
    final aName2 = "_$aName";
    final aImplName2 = "_${aName2}Impl";

    return """
   abstract class $aName<O> {
     factory $aName($name value, O Function($name) then) = $aImplName<O>;
     O call({$callParams});
   }
   class $aImplName<O> implements $aName<O> {
     final $name _value;
     final O Function($name) _then;
     $aImplName(this._value,this._then);

     @override
     O call({$callImplParams}) {
        return _then(_value.copyWith($copyWithParams));
     }
   }

   abstract class $aName2<O> implements ${aName}<O> {
     factory $aName2($name value, O Function($name) then) = $aImplName2<O>;
     O call({$callParams});
   }

   class $aImplName2<O> extends ${aImplName}<O>  implements $aName2<O> {
     
    $aImplName2($name _value,O Function($name) _then): super(_value,(v) => _then(v));

     @override
     $name get _value => super._value;

     @override
     O call({$callImplParams}) {
        return _then($name($copyWithParams));
     }
   }
  """;
  }

  static String getCopyWithField(String name, {bool override = false}) {
    return """
  ${override ? "@override" : ""}
  @JsonKey(ignore: true)
  _\$${name}CopyWith<$name> get copyWith => __\$${name}CopyWithImpl<$name>(this,IdentityFn);
  """;
  }

  static String createCopyWithFromFieldsList(String name, List<Field> fields,
      {bool emptyConstructor = false}) {
    final params = fields
        .map((f) =>
            "${(f.type.endsWith("?") || f.isOptional) ? "Nullable<${f.type.replaceFirst("?", "")}>?" : "${f.type}?"} ${f.name}")
        .join(", ");
    var cons = "";
    if (emptyConstructor) {
      final cfields = fields
          .map((f) =>
              "..${f.name} = ${(f.type.endsWith("?") || f.isOptional) ? "${f.name} != null ? ${f.name}.value : this.${f.name}" : "${f.name} ?? this.${f.name}"} }")
          .join("");
      cons = "${name}()$cfields;";
    } else {
      final cfields = fields
          .map((f) =>
              "${f.name} : ${(f.type.endsWith("?") || f.isOptional) ? "${f.name} != null ? ${f.name}.value : this.${f.name}" : "${f.name} ?? this.${f.name}"}")
          .join(", ");
      cons = "${name}($cfields);";
    }
    return """$name copyWith({$params}) => $cons""";
  }

  static String createCopyWithMapFromFieldsList(String name, List<Field> fields,
      {bool emptyConstructor = false}) {
    var cons = "";
    if (emptyConstructor) {
      final cfields = fields
          .map((f) => "..${f.name} = map[\"${f.name}\"] ?? this.${f.name}")
          .join("");
      cons = "${name}()$cfields;";
    } else {
      final cfields = fields
          .map((f) => "${f.name} : map[\"${f.name}\"] ?? this.${f.name}")
          .join(", ");
      cons = "${name}($cfields);";
    }
    return """
  @override
  $name copyWithMap(Map<String,dynamic> map) => $cons
  """;
  }

  static String createToMapFromFieldsList(List<Field> fields) {
    return """Map<String,dynamic> toMap() => {${fields.map((f) => """ "${f.name}" : this.${f.name} """).join(", ")}};""";
  }

  static String createToStringFromFieldsList(String name, List<Field> fields) {
    return """
  @override
  String toString() => "${name}(${fields.map((f) => "${f.name}: \${this.${f.name}}").join(", ")})";
   """;
  }

  static String createToJson(String name) {
    return "Map<String,dynamic> toJson() => _\$${name}ToJson(this);";
  }

  static String createFromJson(String name) {
    return "factory ${name}.fromJson(Map<String,dynamic> json) => _\$${name}FromJson(json)";
  }

  static String createEqualsFromFieldsList(String name, List<Field> fields) {
    return """
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is $name && ${fields.map((f) => "o.${f.name} == ${f.name}").join(" && ")};
    }
  """;
  }
}
