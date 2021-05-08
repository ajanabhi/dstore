import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_generator/src/utils/utils.dart';

abstract class ModelUtils {
  static String getFinalFieldsFromFieldsList(List<Field> fields,
      {bool addLateModifier = false, bool addOverrideAnnotation = false}) {
    return fields.map((f) {
      final type = f.isOptional && !f.type.endsWith("?") && f.value == null
          ? "${f.type}?"
          : "${f.type}";
      return """
     ${addOverrideAnnotation ? "@override" : ""}
     ${f.annotations.join("\n")}
     ${addLateModifier ? "late" : ""} final $type ${f.name};
    """;
    }).join("\n ");
  }

  static List<Field> convertParameterElementsToFields(
      List<ParameterElement> pe) {
    return pe.map((p) {
      final name = p.name;
      final type = p.type.toString();
      return Field(name: name, type: type, isOptional: type.endsWith("?"));
    }).toList();
  }

  static List<Field> processFields(List<Field> fields,
      {bool addJsonKey = false}) {
    return fields.map((f) {
      var name = f.name;
      var annotations = [...f.annotations];
      if (addJsonKey) {
        name = name.addDName;
        if (name != f.name) {
          if (f.annotations
              .where((element) => element.startsWith("@JsonKey"))
              .isNotEmpty) {
            annotations = annotations.map((e) {
              if (e.startsWith("@JsonKey(")) {
                if (e.contains("name:")) {
                  return e;
                } else {
                  return "@JsonKey(name: $name,${e.substring("@JsonKey(".length)}";
                }
              } else {
                return e;
              }
            }).toList();
          } else {
            annotations.add("@JsonKey(name: '${f.name}')");
          }
        }
      }
      return f.copyWith(
          type: _getFinalTypeOfField(f),
          name: name,
          annotations: annotations,
          isOptional: f.isOptional ? f.isOptional : f.type.endsWith("?"));
    }).toList();
  }

  static String _getFinalTypeOfField(Field f) {
    return (!f.type.endsWith("?") && f.isOptional) ? "${f.type}?" : f.type;
  }

  static String createConstructorFromFieldsList(String name, List<Field> fields,
      {bool assignDefaults = true, bool addConst = true}) {
    final cf = fields.map((f) {
      return "${(!f.isOptional && f.value == null) ? "required" : ""} this.${f.name} ${assignDefaults && f.value != null ? "= ${AstUtils.addConstToDefaultValue(f.value!)}" : ""}";
    }).join(", ");
    return "${addConst ? "const" : ""} ${name}({$cf});";
  }

  static String createHashcodeFromFieldsList(List<Field> fields) {
    return """
    @override 
    int get hashCode => ${fields.map((f) => "${f.name}.hashCode").join(" ^ ")};
  """;
  }

  static List<Field> convertFieldElementsToFields(List<FieldElement> fields) {
    return fields.map((f) {
      final name = f.name;
      final type = f.type.toString();
      final isOptional = type.endsWith("?");
      return Field(name: name, type: type, isOptional: isOptional);
    }).toList();
  }

  static List<Field> convertMethodElementsToFields(List<MethodElement> fields) {
    return fields.map((f) {
      final name = f.name;
      final type = f.returnType.toString();
      final isOptional = type.endsWith("?");
      return Field(name: name, type: type, isOptional: isOptional);
    }).toList();
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
              "..${f.name} = map.containsKey(\"${f.name}\") ? map[\"${f.name}\"] as ${f.type}  : this.${f.name}")
          .join("");
      cons = "${name}()$cfields;";
    } else {
      final cfields = fields
          .map((f) =>
              "${f.name} : map.containsKey(\"${f.name}\") ? map[\"${f.name}\"] as ${f.type} : this.${f.name}")
          .join(", ");
      cons = "${name}($cfields);";
    }
    return """
  @override
  $name copyWithMap(Map<String,dynamic> map) => $cons
  """;
  }

  static String createToMapFromFieldsList(List<Field> fields) {
    return """Map<String,dynamic> toMap() => <String,dynamic>{${fields.map((f) => """ "${f.name}" : this.${f.name} """).join(", ")}};""";
  }

  static String createToStringFromFieldsList(String name, List<Field> fields) {
    return """
  @override
  String toString() => "${name}(${fields.map((f) => "${f.name.replaceAll("\$", "\\\$")}: \${this.${f.name}}").join(", ")})";
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

  static String createDefaultDartModelFromFeilds(
      {required List<Field> fields,
      required String className,
      String annotations = "",
      bool isJsonSerializable = false,
      bool addOverrideAnnotation = false}) {
    if (annotations.isEmpty && isJsonSerializable) {
      annotations = "@JsonSerializable()";
    }
    return """
   $annotations 
   class $className {
         
     ${ModelUtils.getFinalFieldsFromFieldsList(fields, addOverrideAnnotation: addOverrideAnnotation)}
     
     ${ModelUtils.getCopyWithField(className, addJsonKey: isJsonSerializable, typeParams: "")}
      
     ${ModelUtils.createConstructorFromFieldsList(className, fields)}
     
      ${isJsonSerializable ? ModelUtils.createFromJson(className) : ""}

      ${isJsonSerializable ? ModelUtils.createToJson(className) : ""}

     ${ModelUtils.createEqualsFromFieldsList(className, fields)}

     ${ModelUtils.createHashcodeFromFieldsList(fields)}

     ${createToStringFromFieldsList(className, fields)}
    }

    ${ModelUtils.createCopyWithClasses(name: className, fields: fields, typeParamsWithBounds: "", typeParams: "")}
    """;
  }

  static String createDefaultDartUpdateModelFromFeilds(
      {required List<Field> fields,
      required String className,
      String annotations = "",
      bool isJsonSerializable = false,
      bool addOverrideAnnotation = false}) {
    if (annotations.isEmpty && isJsonSerializable) {
      annotations = "@JsonSerializable(createFactory: false)";
    }
    return """
   $annotations 
   class $className {
         
     ${ModelUtils.getFinalFieldsFromFieldsList(fields, addOverrideAnnotation: addOverrideAnnotation)}
     
     ${ModelUtils.createConstructorFromFieldsList(className, fields)}

     ${isJsonSerializable ? ModelUtils.createToJson(className) : ""}
    }
    """;
  }

  static String convertFieldsToJSFields(List<Field> fields) {
    return fields.where((f) => f.name == f.name.addDName).map((f) {
      final type = f.type.startsWith("List<")
          ? "List<dynamic>${f.isOptional ? "?" : ""}"
          : f.type;
      final getter = "external ${type} get ${f.name};";
      final setter = "external  set ${f.name}(${f.type} value);";
      return """
        $getter
        $setter
      """;
    }).join("\n");
  }

  static String getExtensionJSFields(List<Field> fields) {
    final fieldsJS = <String>[];
    fields.forEach((f) {
      final name = f.name;
      final type = f.type;
      final dNmae = f.name.addDName;
      final isAlaised = name != dNmae;
      final isList = type.startsWith("?");
      var getter = "";
      var setter = "";
      if (isAlaised && isList) {
        final op = type.endsWith("?") ? "?" : "";
        getter = """ 
         $type get $dNmae {
          final lits = getProperty(this,'$name') as List<dynamic>$op;
          return list$op.map(l => l as $type).toList();
         }
        """;
        setter =
            " set $dNmae($type value) => setProperty(this,'$name',value); ";
      } else if (isAlaised) {
        getter = """ 
         $type get $dNmae => getProperty(this,'$name');
        """;
        setter =
            " set $dNmae($type value) => setProperty(this,'$name',value); ";
      } else if (isList) {
        getter = """ 
         $type get $dNmae {
          final lits = getProperty(this,'$name') as List<dynamic>;
          return list.map(l => l as $type).toList();
         }
        """;
        setter =
            " set $dNmae($type value) => setProperty(this,'$name',value); ";
      }
      if (getter.isNotEmpty) {
        fieldsJS.add("""
          $getter
          $setter
         """);
      }
    });

    return fieldsJS.join("\n");
  }

  static String getPrivateJSFields(List<Field> fields) {
    return "";
  }

  static String createJSConstructor(List<Field> fields, String name) {
    final params = fields.map((f) {
      final req = f.type.endsWith("?") ? "" : "required";
      return "$req ${f.type} ${f.name}";
    });
    return """
       external factory $name({${params.join(", ")}});
     """;
  }

  static String createDefaultDartJSModelFromFeilds({
    required List<Field> fields,
    required String className,
  }) {
    final privateFields = getPrivateJSFields(fields);

    final privateClass = privateFields.isEmpty
        ? ""
        : """
     @JS()
     @anonymous
     abstract class _$className {
       $privateFields
     }
    
    """;

    var ctor = "";
    if (fields.where((f) => f.name == f.name.addDName).length ==
        fields.length) {
      ctor = createJSConstructor(fields, className);
    }
    var extensionCtor = "";
    if (ctor.isEmpty) {
      // aliased feilds lets add extension constructor for aliased
      final ctorFields =
          fields.where((f) => f.name == f.name.addDName).toList();
      ctor = createJSConstructor(ctorFields, className);
      final eParams = fields.where((f) => f.name != f.name.addDName).map((f) {
        final req = f.type.endsWith("?") ? "" : "required";
        return "$req ${f.type} ${f.name}";
      });
      final eFields = fields.where((f) => f.name != f.name.addDName).map((f) {
        return "setProperty(obj,'${f.name.removeDName}',${f.name});";
      }).join("\n");
      extensionCtor = """
        $className addExtraFeilds({${eParams.join(", ")}}) {
           final obj = this;
           $eFields  
           return obj;
        }
      """;
    }
    final extensionFields = getExtensionJSFields(fields);
    final extensionClass =
        (extensionCtor.isNotEmpty || extensionFields.isNotEmpty)
            ? """
          extension ${className}Ext on $className {
              $extensionCtor
              $extensionFields
           }
        """
            : "";
    return """
   @JS()
   @anonymous
   abstract class $className {
      ${convertFieldsToJSFields(fields)}
      $ctor 
    }

    $privateClass
  
    $extensionClass

    """;
  }
}
