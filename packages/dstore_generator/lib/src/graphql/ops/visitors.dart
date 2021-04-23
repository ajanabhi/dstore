import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/constants.dart';

class DSLFieldsVisitor extends SimpleAstVisitor<Object> {
  final ops = <String>[];
  @override
  dynamic visitFieldDeclaration(FieldDeclaration node) {
    final field = node.fields.variables.first;
    final name = field.name;
    if (field.initializer == null) {
      throw ArgumentError.value(
          "You should provide inititalizer for  field $name");
    }
    final body = field.initializer!.toSource();
    final visitor = DSLVisitor();
    field.initializer!.visitChildren(visitor);
    logger.shout("Query is ${visitor.temp}");
    print("DSL body $body");
    if (body.startsWith("Query(")) {
      // final
      final props = body.replaceFirst("Query()", "");
    }
  }
}

class DSLVisitor extends RecursiveAstVisitor<Object> {
  var temp = "";
  final _propsForType = <String>[];
  @override
  Object? visitPropertyAccess(PropertyAccess node) {
    print("Peroperty access $node");
    var name = node.propertyName.name;
    if (name == "d__typename") {
      name = "__typename";
    }
    _propsForType.add(name);
    temp += "$name\n";
    return super.visitPropertyAccess(node);
  }

  @override
  Object? visitMethodInvocation(MethodInvocation node) {
    print("Method invocation enter $node ${node.methodName}");
    var methodName = node.methodName.name;
    final nodeString = node.toString();
    _propsForType.clear();
    if (methodName == "Query") {
      temp += "query hello { \n";
    } else if (nodeString.startsWith("..")) {
      final s = nodeString.substring(2);
      var bracket = "";
      if (s.split(".").first.endsWith("()")) {
        bracket = "{ ";
      }
      if (methodName.startsWith("unionfrag_")) {
        methodName = "... on ${methodName.replaceFirst("unionfrag_", "")}";
      }
      temp += "$methodName $bracket \n";
    }
    super.visitMethodInvocation(node);
    print("method invcation leave $node");
    if (_propsForType.isNotEmpty) {
      temp += "}\n";
    }
  }

  @override
  Object? visitPrefixedIdentifier(PrefixedIdentifier node) {
    print("Prefix Identifier $node");
    return super.visitPrefixedIdentifier(node);
  }

  @override
  Object? visitSimpleIdentifier(SimpleIdentifier node) {
    return super.visitSimpleIdentifier(node);
  }
}
