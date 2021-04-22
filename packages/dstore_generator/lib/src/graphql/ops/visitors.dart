import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dstore_generator/src/errors.dart';

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
    field.initializer!.toString();
    print("DSL body $body");
    if (body.startsWith("Query(")) {
      // final
      final props = body.replaceFirst("Query()", "");
    }
  }
}

class DSLVisitor extends RecursiveAstVisitor<Object> {
  @override
  Object? visitPropertyAccess(PropertyAccess node) {
    print("Peroperty access $node");
    return super.visitPropertyAccess(node);
  }

  @override
  Object? visitMethodInvocation(MethodInvocation node) {
    print("Method invocation $node");
    return super.visitMethodInvocation(node);
  }

  @override
  Object? visitPrefixedIdentifier(PrefixedIdentifier node) {
    print("Prefix Identifier $node");
    return super.visitPrefixedIdentifier(node);
  }

  @override
  Object? visitSimpleIdentifier(SimpleIdentifier node) {
    print("SimpleIdentifier $node");
    return super.visitSimpleIdentifier(node);
  }
}
