import 'package:dstore_generator/src/utils/utils.dart';

abstract class ModelUtils {
  static String getFinalFieldsFromFieldsList(List<Field> fields,
      {bool addLateModifier = false, bool addOverrideAnnotation = false}) {
    return fields.map((f) {
      final type =
          f.isOptional && !f.type.endsWith("?") ? "${f.type}?" : "${f.type}";
      return """
     ${addOverrideAnnotation ? "@override" : ""}
     ${f.annotations != null ? f.annotations!.join("\n") : ""}
     ${addLateModifier ? "late" : ""} final $type ${f.name};
    """;
    }).join("\n ");
  }

  static String createConstructorFromFieldsList(String name, List<Field> fields,
      {bool assignDefaults = true}) {
    final cf = fields.map((f) {
      return "${(!f.isOptional && f.value == null) ? "required" : ""} this.${f.name} ${assignDefaults && f.value != null ? "= ${AstUtils.addConstToDefaultValue(f.value!)}" : ""}";
    }).join(", ");
    return "const ${name}({$cf});";
  }

  static String createHashcodeFromFieldsList(List<Field> fields) {
    return """
    @override 
    int get hashCode => ${fields.map((f) => "${f.name}.hashCode").join(" ^ ")};
  """;
  }

  static String createCopyWithClasses(
      {required String name,
      required List<Field> fields,
      required String typeParamsWithBounds,
      required String typeParams}) {
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
    final typwd =
        typeParamsWithBounds.isEmpty ? "" : "${typeParamsWithBounds},";
    final tpp = typeParams.isEmpty ? "" : "${typeParams},";
    final tppA = typeParams.isEmpty ? "" : "<${typeParams}>";

    return """
   abstract class $aName<${typwd}O> {
     factory $aName($name$tppA value, O Function($name$tppA) then) = $aImplName<${tpp}O>;
     O call({$callParams});
   }
   class $aImplName<${typwd}O> implements $aName<${tpp}O> {
     final $name${tppA} _value;
     final O Function($name${tppA}) _then;
     $aImplName(this._value,this._then);

     @override
     O call({$callImplParams}) {
        return _then(_value.copyWith($copyWithParams));
     }
   }

   abstract class $aName2<${typwd}O> implements ${aName}<${tpp}O> {
     factory $aName2($name${tppA} value, O Function($name${tppA}) then) = $aImplName2<${tpp}O>;
     O call({$callParams});
   }

   class $aImplName2<${typwd}O> extends ${aImplName}<${tpp}O>  implements $aName2<${tpp}O> {
     
    $aImplName2($name${tppA} _value,O Function($name${tppA}) _then): super(_value,(v) => _then(v));

     @override
     $name${tppA} get _value => super._value;

     @override
     O call({$callImplParams}) {
        return _then($name($copyWithParams));
     }
   }
  """;
  }

  static String getCopyWithField(String name,
      {bool override = false,
      String typeParams = "",
      bool addJsonKey = false}) {
    final tpp = typeParams.isEmpty ? "" : "${typeParams},";
    final tppA = typeParams.isEmpty ? "" : "<${typeParams}>";
    return """
  ${override ? "@override" : ""}
  ${addJsonKey ? "@JsonKey(ignore: true)" : ""} 
  _\$${name}CopyWith<$tpp$name$tppA> get copyWith => __\$${name}CopyWithImpl<$tpp$name$tppA>(this,IdentityFn);
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
          .map((f) =>
              "..${f.name} = map.containsKey(\"${f.name}\") ? map[\"${f.name}\"] : this.${f.name}")
          .join("");
      cons = "${name}()$cfields;";
    } else {
      final cfields = fields
          .map((f) =>
              "${f.name} : map.containsKey(\"${f.name}\") ? map[\"${f.name}\"] : this.${f.name}")
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

  static String createToJson([String? name]) {
    return name == null
        ? "Map<String,dynamic> toJson();"
        : "Map<String,dynamic> toJson() => _\$${name}ToJson(this);";
  }

  static String createFromJson(String name) {
    return "factory ${name}.fromJson(Map<String,dynamic> json) => _\$${name}FromJson(json);";
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