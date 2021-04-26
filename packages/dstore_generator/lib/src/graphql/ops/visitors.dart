import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dstore_generator/src/graphql/graphql_ast_utils.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:tuple/tuple.dart';

class DSLFieldsVisitor extends SimpleAstVisitor<Object> {
  final ops = <String>[];
  final String className;
  final String apiUrl;

  DSLFieldsVisitor({required this.className, required this.apiUrl});
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
      final visitor =
          DSLVisitor(opName: "${className}_${name}", apiUrl: apiUrl);
      field.initializer!.visitChildren(visitor);
      final op = "${visitor.query}\n }";
      ops.add(op);
      logger.shout("Query is $op");
    }
  }
}

class DSLVisitor extends RecursiveAstVisitor<Object> {
  var query = "";
  final String opName;
  final String apiUrl;
  final _propsForType = <String>[];

  DSLVisitor({required this.opName, required this.apiUrl});

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
    var isObject = false;

    if (methodName == "Query" ||
        methodName == "Mutation" ||
        methodName == "Subscription") {
      var argsList = node.argumentList.arguments;
      final args = argsList.isNotEmpty ? "(${argsList.first})" : "";
      query += "${methodName.toLowerCase()} $opName$args { \n";
    } else if (nodeString.startsWith("..")) {
      var bracket = "";
      var alias = "";
      var directive = "";
      var args = "";
      final argsList = node.argumentList.arguments;
      print("Arg First1 ${argsList.firstOrNull.runtimeType}");
      print("Args List $argsList");
      Tuple3<String?, String?, String?>? tuple;
      var objSpread = "";
      if (argsList.isNotEmpty &&
          (argsList.first is CascadeExpression ||
              argsList.first is MethodInvocation)) {
        _propsForType.clear(); // its object field
        isObject = true;
        print("Arg First ${argsList.first.runtimeType}");
        bracket = "{ ";
        if (argsList.first is MethodInvocation) {
          // object invoked with no specific fields selected so lets query all fields
          final objectName = argsList.first.toString().replaceAll("()", "");
          objSpread = GraphqlAstUtils.getObjectQuery(
              objectName: objectName, apiUrl: apiUrl);
        }
        if (argsList.length > 1) {
          tuple = _getAliasArgsAndDirective(argsList.sublist(1));
        }
      } else {
        // scalar field
        if (argsList.isNotEmpty) {
          tuple = _getAliasArgsAndDirective(argsList);
        }
      }
      print("Tuple $tuple");
      if (tuple != null) {
        final item1 = tuple.item1;
        if (item1 != null) {
          alias = "$item1: ";
        }
        final item2 = tuple.item2;
        if (item2 != null) {
          args = "($item2)";
        }
        final item3 = tuple.item3;
        if (item3 != null) {
          directive = item3;
        }
      }
      if (methodName.startsWith("unionfrag_")) {
        methodName = "... on ${methodName.replaceFirst("unionfrag_", "")}";
        objSpread = "__typename";
      }
      if (methodName.startsWith("interfacefrag_")) {
        methodName = "... on ${methodName.replaceFirst("interfacefrag_", "")}";
        objSpread = "__typename";
      }
      query += "$alias $methodName$args $directive $bracket \n $objSpread";
    } else if (nodeString.endsWith("()")) {
      // object constructor
      _propsForType.clear();
    }
    super.visitMethodInvocation(node);
    print("method invcation leave $node");
    if (isObject) {
      query += " }\n";
    }
  }

  Tuple3<String?, String?, String?> _getAliasArgsAndDirective(
      List<Expression> argsList) {
    String? alias;
    String? args;
    String? directive;
    argsList.forEach((e) {
      if (e is NamedExpression) {
        final name = e.name.label.name;
        var value = e.expression.toString();
        value = value.substring(1, value.length - 1);
        if (name == "alias") {
          alias = value;
        } else if (name == "directive") {
          directive = value;
        } else {
          if (args == null) {
            args = "$name: $value";
          } else {
            args = "$args,$name: $value";
          }
        }
      }
    });

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
