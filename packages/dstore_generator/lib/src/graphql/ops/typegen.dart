import 'package:collection/collection.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/constants.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:gql/ast.dart';
import 'package:gql/schema.dart';

enum GListType { strict, nonstrict }

class GField {
  final String name;
  final String? jsonKey;
  final bool optional;
  final List<GListType> listType;
  final String? type;
  final List<GField> fields;
  // final List<String> enumValues;
  final List<GFragment> fragments;
  final String? defaultValue;
  final bool isUnion;

  GField(
      {required this.name,
      required this.optional,
      required this.listType,
      this.type,
      this.isUnion = false,
      this.jsonKey,
      this.defaultValue,
      this.fragments = const [],
      this.fields = const []});

  @override
  String toString() {
    return 'GField(name: $name, jsonKey: $jsonKey, optional: $optional, listType: $listType, type: $type, fields: $fields, framents: $fragments, defaultValue: $defaultValue)';
  }
}

class Stack<T> {
  List<T> list = [];
  T Function()? initializer;

  Stack([this.initializer]);

  void stack([T? value]) {
    if (value == null && initializer != null) {
      list.add(initializer!());
    } else if (value != null) {
      list.add(value);
    }
  }

  T get current {
    if (list.isEmpty) {
      throw Exception("No Elements Stack Error");
    }
    return list[list.length - 1];
  }

  T consume() {
    final c = current;
    list.removeLast();
    return c;
  }

  bool get isEmpty {
    return list.isEmpty;
  }
}

class GFragment {
  final bool isUnionCondition;
  final String? typeNode;
  final List<GField> fields;
  final List<GFragment> fragments;
  final String? on;

  GFragment(
      {required this.isUnionCondition,
      this.typeNode,
      this.on,
      this.fields = const [],
      this.fragments = const []});

  @override
  String toString() {
    return 'GFragment(isUnionCondition: $isUnionCondition, typeNode: $typeNode, fields: $fields, fragments: $fragments)';
  }
}

class FieldTypeElement {
  final List<GField> fields = [];
  final List<GFragment> typeFragments = [];
}

class FieldMetadata {
  final TypeDefinition fieldType;
  final List<GListType> listType;
  final bool strict;

  FieldMetadata(
      {required this.fieldType, required this.listType, required this.strict});

  @override
  String toString() =>
      'FieldMetadata(fieldType: $fieldType, listType: $listType, strict: $strict)';
}

class TypeNodeMeta {
  final String fieldType;
  final List<GListType> listType;
  final bool strict;

  TypeNodeMeta(
      {required this.fieldType, required this.listType, required this.strict});

  @override
  String toString() =>
      'FieldMetadata(fieldType: $fieldType, listType: $listType, strict: $strict)';
}

class ToplevelFragment {
  final bool isUnion;
  final List<GField> fields;
  final List<GFragment> fragments;
  final String on;

  ToplevelFragment(this.fields, this.fragments, this.isUnion, this.on);

  @override
  String toString() =>
      'ToplevelFragment(isUnion: $isUnion, fields: $fields, fragments: $fragments on: $on)';
}

class DuplicateOperationVisitor extends RecursiveVisitor {
  final DocumentNode documentNOde;
  final GraphQLSchema schema;
  bool isMultipleOpsExist = false;
  int _ops = 0;
  late final OperationType? opType;
  DuplicateOperationVisitor(this.documentNOde, this.schema);

  @override
  void visitOperationDefinitionNode(OperationDefinitionNode node) {
    logger.shout("Dups visitOperationDefinitionNode ${node.type}");
    _ops += 1;
    opType = node.type;
    if (_ops > 1) {
      isMultipleOpsExist = true;
      return;
    }
    super.visitOperationDefinitionNode(node);
  }
}

class OperationVisitor extends RecursiveVisitor {
  final DocumentNode documentNode;
  final GraphQLSchema schema;
  final GraphqlApi api;
  OperationVisitor(
      {required this.documentNode, required this.api, required this.schema}) {
    documentNode.definitions.forEach((def) {
      if (def is FragmentDefinitionNode) {
        _fragmentMap[def.name.value] = def;
      }
    });
  }
  final _resultFieldElementStack =
      Stack<FieldTypeElement>(() => FieldTypeElement());
  final _parentTypeStack = Stack<TypeDefinition>();
  final _variableFields = <GField>[];
  final _fragmentMap = <String, FragmentDefinitionNode>{};
  final fragmentFieldsMap = <String, ToplevelFragment>{};
  late List<GField> fields;
  late final List<GFragment> fragments;
  late final List<GField> variables;
  late final OperationType opType;
  @override
  void visitOperationDefinitionNode(OperationDefinitionNode node) {
    print("visiting operation ${node.type}");
    if (node.type == OperationType.query) {
      opType = OperationType.query;
      _parentTypeStack.stack(schema.query);
      _resultFieldElementStack.stack();
    } else if (node.type == OperationType.mutation) {
      opType = OperationType.mutation;
      _parentTypeStack.stack(schema.mutation);
      _resultFieldElementStack.stack();
    } else if (node.type == OperationType.subscription) {
      opType = OperationType.subscription;
      _parentTypeStack.stack(schema.subscription);
      _resultFieldElementStack.stack();
    }
    super.visitOperationDefinitionNode(node);
    final fe = _resultFieldElementStack.consume();
    if (fe.fields.isEmpty && fe.typeFragments.isEmpty) {
      throw Exception("You should select fields for query ${node.name.value}");
    }
    fields = fe.fields;
    fragments = fe.typeFragments;
    variables = _variableFields;
    _parentTypeStack.consume();
  }

  @override
  void visitFragmentDefinitionNode(FragmentDefinitionNode node) {
    print("visitFragmentDefinitionNode Enter ${node.name.value}");
    final onName = node.typeCondition.on.name.value;
    final t = schema.getType(onName);
    _parentTypeStack.stack(t);
    _resultFieldElementStack.stack();
    super.visitFragmentDefinitionNode(node);
    print("visitFragmentDefinitionNode Leave ${node.name.value}");
    final fe = _resultFieldElementStack.consume();
    fragmentFieldsMap[node.name.value] = ToplevelFragment(
        fe.fields, fe.typeFragments, t is UnionTypeDefinition, onName);
    _parentTypeStack.consume();
  }

  @override
  void visitVariableDefinitionNode(VariableDefinitionNode node) {
    super.visitVariableDefinitionNode(node);
    print(
        "variable definition leave ${node.variable.name.value} ${node.defaultValue.value} ${node.type}");
    final variableName = node.variable.name.value.substring(1);
    final defaultValue = node.defaultValue.value
        ?.toString(); //TODO handle array object default variables
    final tm = _getTypeNodeMeta(node.type);
    final td = schema.getType(tm.fieldType);
    print("td: $td ${tm.fieldType}");
    if (!(td is ScalarTypeDefinition) && !(td is InputObjectTypeDefinition)) {
      throw Exception(
          "Variable types hsould be scalar or input object type definition, ${tm.fieldType} is not a scalar or input object");
    }
    var type = tm.fieldType;
    if (td is ScalarTypeDefinition) {
      type = _getScalarType(td);
    }
    _variableFields.add(GField(
      name: variableName,
      defaultValue: defaultValue,
      type: type,
      listType: tm.listType,
      optional: !tm.strict,
    ));
  }

  @override
  void visitFragmentSpreadNode(FragmentSpreadNode node) {
    print("visitFragmentSpreadNode Enter ${node.name.value}");
    super.visitFragmentSpreadNode(node);
    print("visitFragmentSpreadNode Leave ${node.name.value}");
    final name = node.name.value;
    final fragmentDefNode = _fragmentMap[name];
    if (fragmentDefNode == null) {
      throw Exception(
          "Fragment ${name} is not defined, defined fragments are ${_fragmentMap.keys} ");
    }
    final isUnionCondition = _isConcreteTypeOfParentUnionType(
      fragmentDefNode.typeCondition,
      _parentTypeStack.current,
    );
    _resultFieldElementStack.current.typeFragments.add(GFragment(
        isUnionCondition: isUnionCondition, typeNode: node.name.value));
  }

  @override
  void visitInlineFragmentNode(InlineFragmentNode node) {
    print("InLineFragment Enter ${node} ");
    if (node.typeCondition != null) {
      final name = node.typeCondition.on.name.value;
      final type = schema.getType(name) as TypeDefinition?;
      if (type == null) {
        throw Exception("can not find type ${name}");
      }
      print("Union TYpe $type name ${node.typeCondition.on.name.value}");
      _parentTypeStack.stack(type);
      _resultFieldElementStack.stack();
    }
    super.visitInlineFragmentNode(node);
    print("InLineFragment Leave $node");
    if (node.typeCondition != null) {
      _parentTypeStack.consume();
      final fe = _resultFieldElementStack.consume();
      if (fe.fields.isEmpty && fe.typeFragments.isEmpty) {
        throw Exception(
            " You should select fields on inline fragment ${node.typeCondition.on.name.value}");
      }
      final isUnionCondition = _isConcreteTypeOfParentUnionType(
          node.typeCondition, _parentTypeStack.current);
      _resultFieldElementStack.current.typeFragments.add(GFragment(
          isUnionCondition: isUnionCondition,
          fields: fe.fields,
          on: node.typeCondition.on.name.value,
          fragments: fe.typeFragments));
    }
  }

  @override
  void visitFieldNode(FieldNode node) {
    // Enter
    print("field enter ${node.name.value}");
    late FieldMetadata fm;
    final fieldName = node.name.value;
    if (fieldName != "__typename") {
      final f = (_parentTypeStack.current as TypeDefinitionWithFieldSet)
          .getField(node.name.value);
      fm = _getFieldMetadataFromFieldTypeInstance(f.type);
      print("field meta $fm");
      if (fm.fieldType is ObjectTypeDefinition ||
          fm.fieldType is InterfaceTypeDefinition ||
          fm.fieldType is UnionTypeDefinition) {
        _parentTypeStack.stack(fm.fieldType);
        _resultFieldElementStack.stack();
      }
      // NamedType
      print("field type ${f.runtimeType} Type  ${f.type.runtimeType} ");
    }

    super.visitFieldNode(node);
    // Leave
    print("Field leave ${fieldName}");
    if (fieldName == "__typename") {
      print("typename found");
      _resultFieldElementStack.current.fields.add(GField(
        name: "G__typeName",
        optional: false,
        type: "String",
        listType: [],
        fields: [],
        jsonKey: "__typename",
      ));
    } else {
      final fieldType = fm.fieldType;
      String? type;
      var fields = <GField>[];
      var fragments = <GFragment>[];
      if (fieldType is ScalarTypeDefinition) {
        type = _getScalarType(fieldType);
      } else if (fieldType is EnumTypeDefinition) {
        // enumValues = fieldType.values.map((e) => e.name).toList();
        type = fieldType.name;
      } else if (fieldType is InterfaceTypeDefinition ||
          fieldType is ObjectTypeDefinition ||
          fieldType is UnionTypeDefinition) {
        // fields =
        final fe = _resultFieldElementStack.consume();
        if (fe.fields.isEmpty && fe.typeFragments.isEmpty) {
          throw Exception("You should select fields for field ${fieldName}");
        }
        fields = fe.fields;
        fragments = fe.typeFragments;
        _parentTypeStack.consume();
      }
      var name = node.alias?.value ?? fieldName;
      String? jsonKey;
      var isUnion = false;
      if (fieldType is UnionTypeDefinition) {
        isUnion = true;
      }
      if (DART_RESERVED_KEYWORDS.contains(name) || name.startsWith("_")) {
        name = "g$name";
        jsonKey = name;
      }
      _resultFieldElementStack.current.fields.add(GField(
          name: name,
          listType: fm.listType,
          type: type,
          isUnion: isUnion,
          jsonKey: jsonKey,
          optional: !fm.strict,
          fields: fields,
          fragments: fragments));
      print("field leave ${node.name.value} $fm");
    }
  }

  FieldMetadata _getFieldMetadataFromFieldTypeInstance(GraphQLType type,
      {List<GListType> list = const []}) {
    print("ftinput ${type.runtimeType} ${type} ${type.baseTypeName} $list");
    final listm = List<GListType>.from(list);
    if (type is ListType) {
      if (type.isNonNull) {
        listm.add(GListType.strict);
      } else {
        listm.add(GListType.nonstrict);
      }
      type = type.type;
    }
    if (type is NamedType) {
      var strict = false;
      if (type.isNonNull) {
        strict = true;
      }
      var ftd = type.type as TypeDefinition?;
      ftd ??= ScalarTypeDefinition(
          ScalarTypeDefinitionNode(name: NameNode(value: type.baseTypeName)));
      return FieldMetadata(fieldType: ftd, listType: listm, strict: strict);
    } else {
      return _getFieldMetadataFromFieldTypeInstance(type, list: listm);
    }
  }

  TypeNodeMeta _getTypeNodeMeta(TypeNode type,
      {List<GListType> list = const []}) {
    print("ftinput ${type.runtimeType} ${type}  $list");
    final listm = List<GListType>.from(list);
    if (type is ListTypeNode) {
      if (type.isNonNull) {
        listm.add(GListType.strict);
      } else {
        listm.add(GListType.nonstrict);
      }
      type = type.type;
    }
    if (type is NamedTypeNode) {
      var strict = false;
      if (type.isNonNull) {
        strict = true;
      }
      var ftd = type.name.value;
      return TypeNodeMeta(fieldType: ftd, listType: listm, strict: strict);
    } else {
      return _getTypeNodeMeta(type, list: listm);
    }
  }

  bool _isConcreteTypeOfParentUnionType(
      TypeConditionNode node, TypeDefinition parentType) {
    if (parentType is UnionTypeDefinition) {
      return parentType.types
          .where((t) => t.name == node.on.name.value)
          .isNotEmpty;
    } else {
      return false;
    }
  }

  String _getScalarType(ScalarTypeDefinition typeDef,
      {Map<String, String>? scalarMap}) {
    return getScalarTypeFromString(typeDef.name, scalarMap: scalarMap);
  }
}

String getScalarTypeFromString(String input, {Map<String, String>? scalarMap}) {
  switch (input) {
    case "String":
    case "ID":
      return "String";
    case "Float":
      return "double";
    case "Boolean":
      return "bool";
    case "Int":
      return "int";
    default:
      return scalarMap?[input] ?? "dynamic";
  }
}

class FieldG {
  final String name;
  final String type;
  final String? jsonKey;
  final GType? gType;

  FieldG(
      {required this.name,
      required this.type,
      required this.jsonKey,
      this.gType});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FieldG && o.name == name && o.jsonKey == jsonKey;
  }

  @override
  int get hashCode => name.hashCode ^ jsonKey.hashCode;

  @override
  String toString() {
    return "Field(name: ${name}, type: ${type}, jsonKey: ${jsonKey} , gType: ${gType})";
  }
}

class GType {
  final Set<FieldG> fields;
  final String name;
  final List<GType> unions;
  final Set<String> baseTypes;
  GType(
      {required this.fields,
      required this.name,
      this.unions = const [],
      this.baseTypes = const {}});

  @override
  String toString() {
    return "GType(fields: ${fields}, name: ${name}, unions : ${unions} baseTypes : $baseTypes);";
  }
}

FieldG convertGraphqlFieldToField(
    GField gf, String prefix, Map<String, ToplevelFragment> fragmentFieldsMap) {
  if (gf.isUnion) {
    // union type
    final type = "${prefix}_${gf.name}";
    List<GFragment> frags;
    if (gf.fragments.length == 1) {
      // toplevel union fragment spread
      final typeNode = gf.fragments.first.typeNode!;
      final tf = fragmentFieldsMap[typeNode]!;
      frags = tf.fragments;
    } else {
      frags = gf.fragments;
    }
    final unions = frags.map((f) {
      final fields = getFieldsFromFragment([f], fragmentFieldsMap, prefix);
      fields.add(FieldG(
        name: "G__typeName",
        type: "String",
        jsonKey: "__typename",
      ));
      String on;
      if (f.typeNode != null) {
        final tl = fragmentFieldsMap[f.typeNode]!;
        on = tl.on;
      } else {
        on = f.on!;
      }
      final name = "${type}_${on}";
      return GType(fields: fields, name: name, baseTypes: {type});
    }).toList();
    return FieldG(
        name: gf.name,
        jsonKey: gf.jsonKey,
        type: getDType(gf, type),
        gType: GType(name: type, fields: {}, unions: unions));
  } else if (gf.fields.isNotEmpty || gf.fragments.isNotEmpty) {
    // object or interface
    final type = "${prefix}_${gf.name}";
    final gt = getGType(gf.fields, gf.fragments, type, fragmentFieldsMap);

    return FieldG(
        name: gf.name,
        jsonKey: gf.jsonKey,
        type: getDType(gf, type),
        gType: gt);
  } else {
    return FieldG(
        name: gf.name, jsonKey: gf.jsonKey, type: getDType(gf, gf.type!));
  }
}

GType getGType(List<GField> fields, List<GFragment> fragments, String prefix,
    Map<String, ToplevelFragment> fragmentFieldsMap) {
  final fFields = <FieldG>{};

  fFields.addAll(fields
      .map((gf) => convertGraphqlFieldToField(gf, prefix, fragmentFieldsMap)));
  fFields.addAll(getFieldsFromFragment(fragments, fragmentFieldsMap, prefix));

  return GType(fields: fFields, name: prefix);
}

Set<FieldG> getFieldsFromFragment(List<GFragment> fragments,
    Map<String, ToplevelFragment> fragmentFieldsMap, String prefix) {
  final fragFields = <FieldG>{};
  fragments.forEach((frag) {
    var fields = frag.fields;
    var frags = frag.fragments;
    if (frag.typeNode != null) {
      final tf = fragmentFieldsMap[frag.typeNode]!;
      fields = tf.fields;
      frags = tf.fragments;
    }
    fragFields.addAll(fields.map(
        (gf) => convertGraphqlFieldToField(gf, prefix, fragmentFieldsMap)));
    fragFields.addAll(getFieldsFromFragment(frags, fragmentFieldsMap, prefix));
  });
  return fragFields;
}

String getDType(GField gf, String type) {
  String getListType(List<GListType> list, String type) {
    final lt = list.first;
    final ltt = lt == GListType.nonstrict ? "List<$type>?" : "List<$type>";
    if (list.length == 1) {
      return ltt;
    } else {
      return getListType(list.sublist(1), ltt);
    }
  }

  final t = gf.optional ? "$type?" : type;
  if (gf.listType.isNotEmpty) {
    return getListType(gf.listType, t);
  } else {
    return t;
  }
}

String getTypes(OperationVisitor visitor, String name) {
  final list = <GType>[];
  final fragmentMap = visitor.fragmentFieldsMap;

  final gt =
      getGType(visitor.fields, visitor.fragments, "${name}Data", fragmentMap);
  list.add(gt);
  list.addAll(getAllGTypes(gt.fields));
  print(gt);

  final response = list.map((e) => convertGTypeToString(e)).join("\n");
  final variables = visitor.variables.isEmpty
      ? ""
      : createVariableType(visitor.variables, "${name}Variables");
  return """
    $response
    $variables
  """;
}

Field converGFieldToField(GField field) {
  final name = field.name;
  final type = getDType(field, field.type!);
  return Field(name: name, type: type, isOptional: field.optional);
}

String createVariableType(List<GField> gFields, String name) {
  final fields = gFields.map(converGFieldToField).toList();

  return ModelUtils.createDefaultDartModelFromFeilds(
      fields: fields, className: name, isJsonSerializable: true);
}

List<GType> getAllGTypes(Set<FieldG> fields) {
  final result = <GType>[];
  fields.forEach((f) {
    if (f.gType != null) {
      final gType = f.gType!;
      result.add(gType);
      result.addAll(gType.unions);
      result.addAll(getAllGTypes(gType.fields));
    }
  });
  return result;
}

String convertGTypeToString(GType gtype) {
  final name = gtype.name;
  if (gtype.unions.isNotEmpty) {
    final ctors = <String>[];
    final getters = <String>[];
    final fromJson = <String>[];
    gtype.unions.forEach((e) {
      final un = e.name;
      final tn = un.substring(e.name.lastIndexOf("_") + 1);
      ctors.add("${name}.${tn}(${un} value):_value:value;");
      getters.add("$un get ${tn} => _value is $un ? _value as $un : null;");
      fromJson.add("""if(json["__typename"] == \"$tn\") {
          return $name.$tn(${un}.fromJson(json));
        }""");
    });
    return """
    // this is a union type, check subclasses of this type for conecret types
      class $name {
        dnamic _value;
         ${ctors.join("\n")}
         ${getters.join("\n")}
        
        static $name fromJson(Map<String,dynamic> json){
           ${fromJson.join("\n")}
          throw ArgumentError.value(
          json,
           'json',
           'Cannot convert the provided data.',
           );
        }

        Map<String,dynamic> toJson() => _value.toJson();
      }
    """;
  }
  final specialConverters = <String>[];

  final fields = gtype.fields.map((f) {
    final annotations = <String>[];
    final jkFields = <String>[];
    if (f.jsonKey != null) {
      jkFields.add("name:\"${f.jsonKey}\"");
    }
    // if (f.gType != null && f.gType!.unions.isNotEmpty) {
    //   // union field we need special getter
    //   final mn = "_${f.name}FromJson";
    //   jkFields.add("fromJson: $mn");
    //   specialConverters.add(getUnionConverterForField(f));
    // }

    if (jkFields.isNotEmpty) {
      annotations.add("@JsonKey(${jkFields.join(",")})");
    }

    return Field(name: f.name, type: f.type, annotations: annotations);
  }).toList();
  return ModelUtils.createDefaultDartModelFromFeilds(
      fields: fields, className: name, isJsonSerializable: true);
}

String getUnionConverterForField(FieldG f) {
  final mn = "_${f.name}FromJson";

  final isOptional = f.type.endsWith("?");

  final opCond = isOptional
      ? """
    if(json == null) {
      return null;
    }
  """
      : "";

  String conv;
  if (f.type.startsWith("List<")) {
    final isOptional2 = f.type.endsWith("?>") || f.type.endsWith("?>?");
    final opCond2 = isOptional2
        ? """
    if(o == null) {
      return null;
    }
  """
        : "";
    final u = f.gType!.unions.map((ut) {
      final tn = ut.name.substring(ut.name.lastIndexOf("_") + 1);
      return """
         $opCond2
        if(o["__typename"] == \"$tn\") {
          return ${ut.name}.fromJson(o);
        }
      """;
    }).join("\n");
    conv = """
     if(json is List) {
       return json.map((o)  {
          $u
       }).toList as ${f.type};
     }
     
    """;
  } else {
    final u = f.gType!.unions.map((ut) {
      final tn = ut.name.substring(ut.name.lastIndexOf("_") + 1);
      return """
        if(json["__typename"] == \"$tn\") {
          return ${ut.name}.fromJson(json);
        }
      """;
    }).join("\n");
    conv = """
     if(json is Map<String,dynamic>) {
        $u;
     }
    """;
  }

  return """
   static ${f.type} $mn(Object${opCond.isEmpty ? "" : "?"} json) {
     ${opCond}

     ${conv}

    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );

   }
  """;
}
