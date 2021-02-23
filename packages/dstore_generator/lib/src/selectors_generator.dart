import 'dart:convert';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:dstore/dstore.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

class SelectorsGenerator extends GeneratorForAnnotation<Selectors> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (!(element is ClassElement)) {
      throw Exception("Selectors should be applied on class only");
    }
    final className = element.name;

    if (!className.startsWith("_")) {
      throw Exception("Selectors functions class should start with _");
    }
    final modelName = className.substring(1);
    final visitor = SelectorsVisitor(modelName);
    final astNode = await getResolvedAstNodeFromElement(element);
    astNode.visitChildren(visitor);

    return """
       // Selector
       class ${modelName} {
         ${visitor.selectors.join("\n")}
       }
    """;
  }
}

class SelectorsVisitor extends SimpleAstVisitor {
  final String modelName;
  final selectors = <String>[];

  SelectorsVisitor(this.modelName);

  @override
  dynamic visitMethodDeclaration(MethodDeclaration node) {
    final fields = convertParamsToFields(node.parameters);
    if (fields.isEmpty || fields.length > 1) {
      throw Exception(
          "Selector functions should be only one param with app state");
    }
    final field = fields.first;
    var name = node.name.toString();
    if (node.returnType == null) {
      throw Exception("You sould annontate return type of method ${name} ");
    }
    final rType = node.returnType.toString();
    final sType = field.type;
    final bvs = SelectorBodyVisitor(field.param!.identifier);
    node.body.visitChildren(bvs);
    print("%%%%% deps : ${bvs.depsList}");
    final depsMap = _convertDepsListToDeps(bvs.depsList)
        .map((key, value) => MapEntry(key, value.toList()));
    final webSocketFieldDepsMap = Map.fromEntries(
        (_convertDepsListToWebSocketFields(bvs.depsList)
            .map((key, value) => MapEntry(key, value.toList()))
            .entries
            .where((e) => e.value.isNotEmpty)));
    final wsDeps = webSocketFieldDepsMap.isEmpty
        ? ""
        : ",wsDeps: ${jsonEncode(webSocketFieldDepsMap)}";

    final streamFieldsMap = Map.fromEntries(
        _convertDepsListToStreamFields(bvs.depsList)
            .map((key, value) => MapEntry(key, value.toList()))
            .entries
            .where((e) => e.value.isNotEmpty));
    final sfDeps = streamFieldsMap.isEmpty
        ? ""
        : ", sfDeps: ${jsonEncode(streamFieldsMap)}";
    final result =
        """static final ${name} = Selector<${sType},${rType}>(fn:_${modelName}.${name},deps:${jsonEncode(depsMap)}$wsDeps ${sfDeps});""";
    print("Resuult :${result}");
    selectors.add(result);
    //  node.body.visitChildren(visitor)
    return super.visitMethodDeclaration(node);
  }

  Map<String, Set<String>> _convertDepsListToDeps(
      List<List<MapEntry<String, DartType>>> depsList) {
    print("depsList $depsList");
    final result = <String, Set<String>>{};
    depsList.map((e) => e.map((e) => e.key).toList()).forEach((dl) {
      final key = dl[0];
      final prop = dl.length > 1 ? dl[1] : null;
      final existingValue = result[key];
      if (existingValue != null) {
        if (prop == null) {
          // meaning selector depends on whole reducer
          result[key] = {};
        } else if (existingValue.isNotEmpty) {
          existingValue.add(prop);
          result[key] = existingValue;
        }
      } else {
        result[key] = prop == null ? {} : {prop};
      }
    });
    return result;
  }

  Map<String, Set<String>> _convertDepsListToWebSocketFields(
      List<List<MapEntry<String, DartType>>> depsList) {
    final result = <String, Set<String>>{};
    depsList.forEach((dl) {
      final entry1 = dl[0];
      final key = entry1.key;
      final entry2 = dl.length > 1 ? dl[1] : null;
      final existingValue = result[key];
      if (existingValue != null) {
        if (entry2 == null) {
          existingValue.addAll(_getWebSocketFieldsForType(entry1.value));
        } else if (_isWebSocketFieldType(entry2.value)) {
          existingValue.add(entry2.key);
        }
        result[key] = existingValue;
      } else {
        if (entry2 == null) {
          result[key] = _getWebSocketFieldsForType(entry1.value);
        } else {
          result[key] = _isWebSocketFieldType(entry2.value) ? {entry2.key} : {};
        }
      }
    });

    return result;
  }

  Map<String, Set<String>> _convertDepsListToStreamFields(
      List<List<MapEntry<String, DartType>>> depsList) {
    final result = <String, Set<String>>{};
    depsList.forEach((dl) {
      final entry1 = dl[0];
      final key = entry1.key;
      final entry2 = dl.length > 1 ? dl[1] : null;
      final existingValue = result[key];
      if (existingValue != null) {
        if (entry2 == null) {
          existingValue.addAll(_getStreamFieldsForType(entry1.value));
        } else if (_isStreamFieldType(entry2.value)) {
          existingValue.add(entry2.key);
        }
        result[key] = existingValue;
      } else {
        if (entry2 == null) {
          result[key] = _getStreamFieldsForType(entry1.value);
        } else {
          result[key] = _isStreamFieldType(entry2.value) ? {entry2.key} : {};
        }
      }
    });

    return result;
  }

  Set<String> _getStreamFieldsForType(DartType type) {
    print(
        "Getting _getStreamFieldsForType2 for ${type.toString()} ${type.element.runtimeType}");
    final element = type.element;
    if (!(element is ClassElement)) {
      return {};
    }
    print("fields${element.fields}");
    return element.fields
        .where((f) => _isStreamFieldType(f.type))
        .map((e) => e.name)
        .toSet();
  }

  bool _isStreamFieldType(DartType type) =>
      type.toString().startsWith("StreamField<");

  Set<String> _getWebSocketFieldsForType(DartType type) {
    print(
        "Getting WebSocketFields2 for ${type.toString()} ${type.element.runtimeType}");
    final element = type.element;
    if (!(element is ClassElement)) {
      return {};
    }
    print("fields${element.fields}");
    return element.fields
        .where((f) => _isWebSocketFieldType(f.type))
        .map((e) => e.name)
        .toSet();
  }

  bool _isWebSocketFieldType(DartType type) {
    print("_isWebSocketFieldType $type ${type.element.runtimeType}");
    final element = type.element;
    if (!(element is ClassElement)) {
      return false;
    }
    print(element.allSupertypes);
    return element.allSupertypes.any((st) => st
        .getDisplayString(withNullability: true)
        .startsWith("WebSocketField<"));
  }
}

class SelectorBodyVisitor extends RecursiveAstVisitor {
  final Identifier identifier;

  final List<List<MapEntry<String, DartType>>> depsList = [];

  SelectorBodyVisitor(this.identifier);
  List<MapEntry<String, DartType>> getPropNamesAndTheirTypes(
      PropertyAccess node) {
    final result = <MapEntry<String, DartType>>[];
    final prop = node.propertyName.toString();
    print(
        "IdentifierElement4 ${node.staticType} ${node.propertyName.staticElement}");
    if (prop == "wm") {
      final isCe = node.staticType.element is ClassElement;
      print("wm $isCe");
      if (isCe) {
        print((node.staticType.element as ClassElement)
            .allSupertypes
            .map((e) => e.getDisplayString(withNullability: true))
            .join(", "));
      }
    }
    result.add(MapEntry(prop, node.staticType));
    final target = node.target;
    print("target type ${target.runtimeType}");
    if (target is PropertyAccess) {
      result.addAll(getPropNamesAndTheirTypes(target));
    } else if (target is PrefixedIdentifier) {
      if (target.prefix.toString() == identifier.toString()) {
        print(
            "IdentifierElement3 ${target.identifier.toString()} ${target.staticElement} ${target.staticType}  ${target.identifier.staticType}");
        result.add(MapEntry(
            target.identifier.toString(), target.identifier.staticType));
      } else {
        print("target is not identifier ${target.runtimeType} ${target}");
      }
    }
    return result;
  }

  @override
  dynamic visitPropertyAccess(PropertyAccess node) {
    print("***&&& propsAccess  ${node}");
    final list = getPropNamesAndTheirTypes(node);
    final sa = node.toString().split(".").toList();
    if (sa.length - 1 == list.length) {
      // property access of state identifier
      depsList.add(list.reversed.take(2).toList());
    }
    print("Property access list ++++=== ++++++ ${list}");
    // return super.visitPropertyAccess(node);
  }

  @override
  dynamic visitPrefixedIdentifier(PrefixedIdentifier node) {
    print(
        "**##### IdenAccess  ${node} id:  ${node.identifier} prefix : ${node.prefix} mid :${identifier.toString()}");
    if (node.prefix.toString() == identifier.toString()) {
      print(
          "IdentifierElement1 ${node.identifier.staticElement} ${node.identifier.staticType}");

      depsList.add(
          [MapEntry(node.identifier.toString(), node.identifier.staticType)]);
    } else {
      print("identifier is not equal ${node.prefix == identifier}");
    }
    // return super.visitPrefixedIdentifier(node);
  }
}

class _SelectorMeta {
  final Field stateField;
  final String name;
  final String code;

  _SelectorMeta(this.stateField, this.name, this.code);
}
