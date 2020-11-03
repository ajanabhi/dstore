import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore/dstore.dart';
import 'package:dstore_generator/src/utils.dart';
import 'package:source_gen/source_gen.dart';

class SelectorsGenerator extends GeneratorForAnnotation<Selectors> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (!(element is ClassElement)) {
      throw Exception("Selectors should be applied on class only");
    }
    element = element as ClassElement;

    final className = element.name;

    final modelName = className.replaceFirst("Reducer", "").substring(1);
    final visitor = SelectorsVisitor();
    final astNode = getAstNodeFromElement(element);
    astNode.visitChildren(visitor);

    return """
       // Selector
    """;
  }
}

class SelectorsVisitor extends SimpleAstVisitor {
  final selectors = <_SelectorMeta>[];

  @override
  visitMethodDeclaration(MethodDeclaration node) {
    final fields = convertParamsToFields(node.parameters);
    if (fields.isEmpty || fields.length > 1) {
      throw Exception(
          "Selector functions should be only one param with app state");
    }
    final field = fields.first;
    var name = node.name.toString();
    if (!name.startsWith("_")) {
      throw Exception("Selector function should start with _");
    }
    name = name.substring(1);
    final bvs = SelectorBodyVisitor(field.param.identifier);
    node.body.visitChildren(bvs);
    final t = node.returnType;
    print("%%%%% deps : ${bvs.deps}");
    print("*******YYYYYY**** ${t}  ${t.type} ");
    //  node.body.visitChildren(visitor)
    return super.visitMethodDeclaration(node);
  }
}

class SelectorBodyVisitor extends RecursiveAstVisitor {
  final Identifier identifier;

  final List<List<String>> deps = [];

  SelectorBodyVisitor(this.identifier);
  List<String> getListOfPropAccess(PropertyAccess node) {
    List<String> result = [];
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
  visitPropertyAccess(PropertyAccess node) {
    print("***&&& propsAccess  ${node}");
    final list = getListOfPropAccess(node);
    final sa = node.toString().split(".").toList();
    if (sa.length - 1 == list.length) {
      // property access of state identifier
      deps.add(list.reversed.toList().take(2).toList());
    }
    print("Property access list ++++=== ++++++ ${list}");
    // return super.visitPropertyAccess(node);
  }

  @override
  visitPrefixedIdentifier(PrefixedIdentifier node) {
    print(
        "**##### IdenAccess  ${node} id:  ${node.identifier} prefix : ${node.prefix} mid :${identifier.toString()}");
    if (node.prefix.toString() == identifier.toString()) {
      deps.add([node.identifier.toString()]);
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
