import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:tuple/tuple.dart';

class DSLFieldsVisitor extends SimpleAstVisitor<Object> {
  final ops = <String>[];
  final String className;

  DSLFieldsVisitor({required this.className});
  @override
  dynamic visitFieldDeclaration(FieldDeclaration node) {
    final field = node.fields.variables.first;
    final name = field.name.name;
    if (field.initializer == null) {
      throw ArgumentError.value(
          "You should provide inititalizer for  field $name");
    }
    final op = field.initializer!.toSource();
    if (op.startsWith("Query(") ||
        op.startsWith("Mutation(") ||
        op.startsWith("Subscription(")) {
      final visitor = DSLVisitor("${className}_${name}");
      field.initializer!.visitChildren(visitor);
      ops.add(visitor.query);
      logger.shout("Query is ${visitor.query}");
    }
  }
}

class DSLVisitor extends RecursiveAstVisitor<Object> {
  var query = "";
  final String opName;
  final _propsForType = <String>[];

  DSLVisitor(this.opName);

  @override
  Object? visitPropertyAccess(PropertyAccess node) {
    print("Peroperty access $node");
    var name = node.propertyName.name;
    if (name == "d__typename") {
      name = "__typename";
    }
    _propsForType.add(name);
    query += "$name\n";
    return super.visitPropertyAccess(node);
  }

  @override
  Object? visitMethodInvocation(MethodInvocation node) {
    print("Method invocation enter $node ${node.methodName}");
    var methodName = node.methodName.name;
    final nodeString = node.toString();
    var isOp = false;
    if (methodName == "Query" ||
        methodName == "Mutation" ||
        methodName == "Subscription") {
      isOp = true;
      var argsList = node.argumentList.arguments;
      final args = argsList.isNotEmpty ? "(${argsList.first})" : "";
      query += "${methodName.toLowerCase()} $opName$args { \n";
    } else if (nodeString.startsWith("..")) {
      final s = nodeString.substring(2);
      var bracket = "";
      var alias = "";
      var directive = "";
      var args = "";
      if (node.argumentList.arguments.isNotEmpty &&
          s.split(".").first.endsWith("()")) {
        _propsForType.clear(); // its object field
        bracket = "{ ";
      } else {
        // scalar field

      }
      if (methodName.startsWith("unionfrag_")) {
        methodName = "... on ${methodName.replaceFirst("unionfrag_", "")}";
      }
      query += "$alias $methodName$args $directive $bracket \n";
    } else if (nodeString.endsWith("()")) {
      // object constructor
      _propsForType.clear();
    }
    super.visitMethodInvocation(node);
    print("method invcation leave $node");
    if (isOp || _propsForType.isNotEmpty) {
      query += " }\n";
    }
  }

  Tuple3<String?, String?, String?> _getAliasArgsAndDirective(
      List<Expression> argsList) {
    String? alias;
    String? args;
    String? directive;
    if (argsList.isNotEmpty) {}

    return Tuple3(alias, args, directive);
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
