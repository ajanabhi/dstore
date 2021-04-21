import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dstore_generator/src/errors.dart';

class DSLVisitor extends SimpleAstVisitor<Object> {
  @override
  dynamic visitFieldDeclaration(FieldDeclaration node) {
    final field = node.fields.variables.first;
    final name = field.name;
    if (field.initializer == null) {
      throw ArgumentError.value(
          "You should provide inititalizer for  field $name");
    }
    final body = field.initializer!.toSource();
    print("DSL body $body");
  }
}
