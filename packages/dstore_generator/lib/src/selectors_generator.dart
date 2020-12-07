import 'dart:convert';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore/dstore.dart';
import 'package:dstore_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

class SelectorsGenerator extends GeneratorForAnnotation<Selectors> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (!(element is ClassElement)) {
      throw Exception("Selectors should be applied on class only");
    }
    final className = element.name;

    if (!className.startsWith("_")) {
      throw Exception("Selectors functions class should start with _");
    }
    final modelName = className.substring(1);
    final visitor = SelectorsVisitor(modelName);
    final astNode = getAstNodeFromElement(element);
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
    final result =
        """static final ${name} = Selector<${sType},${rType}>(fn:_${modelName}.${name},deps:${jsonEncode(depsMap)});""";
    print("Resuult :${result}");
    selectors.add(result);
    //  node.body.visitChildren(visitor)
    return super.visitMethodDeclaration(node);
  }

  Map<String, Set<String>> _convertDepsListToDeps(List<List<String>> depsList) {
    final result = <String, Set<String>>{};
    depsList.forEach((dl) {
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
}

class SelectorBodyVisitor extends RecursiveAstVisitor {
  final Identifier identifier;

  final List<List<String>> depsList = [];

  SelectorBodyVisitor(this.identifier);
  List<String> getListOfPropAccess(PropertyAccess node) {
    final result = <String>[];
    final prop = node.propertyName.toString();
    result.add(prop);
    final target = node.target;
    print("target type ${target.runtimeType}");
    if (target is PropertyAccess) {
      result.addAll(getListOfPropAccess(target));
    } else if (target is PrefixedIdentifier) {
      if (target.prefix.toString() == identifier.toString()) {
        result.add(target.identifier.toString());
      } else {
        print("target is not identifier ${target.runtimeType} ${target}");
      }
    }
    return result;
  }

  @override
  dynamic visitPropertyAccess(PropertyAccess node) {
    print("***&&& propsAccess  ${node}");
    final list = getListOfPropAccess(node);
    final sa = node.toString().split(".").toList();
    if (sa.length - 1 == list.length) {
      // property access of state identifier
      depsList.add(list.reversed.toList().take(2).toList());
    }
    print("Property access list ++++=== ++++++ ${list}");
    // return super.visitPropertyAccess(node);
  }

  @override
  dynamic visitPrefixedIdentifier(PrefixedIdentifier node) {
    print(
        "**##### IdenAccess  ${node} id:  ${node.identifier} prefix : ${node.prefix} mid :${identifier.toString()}");
    if (node.prefix.toString() == identifier.toString()) {
      depsList.add([node.identifier.toString()]);
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
