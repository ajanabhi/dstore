import 'package:dstore_generator/src/graphql/globals.dart';
import 'package:gql/ast.dart';
import 'package:gql/schema.dart';
import 'package:meta/meta.dart';

enum GListType { none, strict, nonstrict }

class GField {
  final String name;
  final String? jsonKey;
  final bool optional;
  final List<GListType> listType;
  final String? type;
  final List<GField> fields;
  // final List<String> enumValues;
  final List<GFragment> framents;
  final String? defaultValue;

  GField(
      {required this.name,
      required this.optional,
      required this.listType,
      this.type,
      this.jsonKey,
      this.defaultValue,
      this.framents = const [],
      this.fields = const []});
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

  GFragment(
      {required this.isUnionCondition,
      this.typeNode,
      this.fields = const [],
      this.fragments = const []});
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
  final List<GField> fields;
  final List<GFragment> fragments;

  ToplevelFragment(this.fields, this.fragments);
}

class OperationVisitor extends RecursiveVisitor {
  final DocumentNode documentNode;
  final GraphQLSchema schema;
  OperationVisitor({required this.documentNode, required this.schema}) {
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
  @override
  void visitOperationDefinitionNode(OperationDefinitionNode node) {
    if (node.type == OperationType.query) {
      _parentTypeStack.stack(schema.query);
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
    final t = schema.getType(node.typeCondition.on.name.value);
    _parentTypeStack.stack(t);
    _resultFieldElementStack.stack();
    super.visitFragmentDefinitionNode(node);
    print("visitFragmentDefinitionNode Leave ${node.name.value}");
    final fe = _resultFieldElementStack.consume();
    fragmentFieldsMap[node.name.value] =
        ToplevelFragment(fe.fields, fe.typeFragments);
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
    if (fieldName == "__typename") {
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
          fieldType is ObjectTypeDefinition) {
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
      if (reserved.contains(name) || name.startsWith("_")) {
        name = "g$name";
      }
      _resultFieldElementStack.current.fields.add(GField(
          name: name,
          listType: fm.listType,
          type: type,
          jsonKey: name.substring(1),
          optional: !fm.strict,
          fields: fields,
          framents: fragments));
    }
    print("field leave ${node.name.value} $fm");
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
      {bool customScalar = false}) {
    switch (typeDef.name) {
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
        return customScalar ? typeDef.name : "dynamic";
    }
  }
}
