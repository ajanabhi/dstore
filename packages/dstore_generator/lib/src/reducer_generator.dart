import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dstore/dstore.dart';

class ReducerGenerator extends GeneratorForAnnotation<Reducer> {
  AstNode getAstNodeFromElement(Element element) {
    AnalysisSession session = element.session;
    ParsedLibraryResult parsedLibResult =
        session.getParsedLibraryByElement(element.library);
    ElementDeclarationResult elDeclarationResult =
        parsedLibResult.getElementDeclaration(element);
    return elDeclarationResult.node;
  }

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (!(element is ClassElement)) {
      throw Exception("Reducer should be applied on class only");
    }
    element = element as ClassElement;
    final className = element.name;
    if (!className.startsWith("_") || !className.endsWith("Reducer")) {
      throw Exception(
          "Reducer class should start with an underscore and end with Reducer example : _MyReducer");
    }
    final modelName = className.replaceFirst("Reducer", "").substring(1);
    final visitor = ReducerAstVisitor();
    final astNode = getAstNodeFromElement(element);
    astNode.visitChildren(visitor);
    var methods = "";
    visitor.methods.forEach((key, value) {
      methods += "$key : ${value.toString()}";
    });
    print(visitor.fields);

    return """
       // class Name : ${element.name}

       ${_createReducerModel(visitor.fields, modelName)}

       // Methods : $methods;
    """;
  }
}

const STATE_VARIABLE = "_DStoreState";

const DSTORE_PREFIX = "_DStore";

class ReducerAstVisitor extends SimpleAstVisitor {
  List<Field> fields = [];
  List<Method> methods = [];

  @override
  visitMethodDeclaration(MethodDeclaration node) {
    final body = node.body;
    if (body is EmptyFunctionBody) {
      throw Exception("method should contain mutation to fields");
    }
    final name = node.name.toString();
    final params = node.parameters.parameters
        .map((p) => Field(
            name: p.identifier.toString(),
            type: p.runtimeType.toString(),
            value: null))
        .toList();
    if (body is ExpressionFunctionBody) {
      final e = body.expression;
      if (e is AssignmentExpression) {
        if (!_isThisPropertyAccessExpression(e.leftHandSide)) {
          throw Exception(
              "Singleline body should assigment expression of class variable with this. prefix");
        }
      } else {
        throw Exception(
            "Singleline body should assigment expression of class variable with this.prefix");
      }
    } else if (body is BlockFunctionBody) {}
    if (node.body is BlockFunctionBody) {
      final ex = node.body as BlockFunctionBody;
      ex.block.statements.forEach((element) {
        print(
            "************** Check ${element.toString()} ${element is ExpressionStatement}");
        if (element is ExpressionStatement) {
          final exp = element.expression;
          print("isAssignable ${exp.runtimeType}");
          if (exp is AssignmentExpression) {
            print("Hello ${exp.leftHandSide.runtimeType}");
            if (exp.leftHandSide is SimpleIdentifier) {
              final idn = exp.leftHandSide as SimpleIdentifier;
              print(
                  "Identifie: ${idn.inSetterContext()} ${idn.isQualified} ${idn.precedence} ${idn.parent} ${idn.inDeclarationContext()}");
            }
          }
        }
      });
    }
    return super.visitMethodDeclaration(node);
  }

  @override
  visitFieldDeclaration(FieldDeclaration node) {
    final type = node.fields.type;
    if (type == null) {
      throw Exception("Should provide type annotation for fields");
    }
    node.fields.variables.forEach((v) {
      final name = v.name.toString();
      final value = v.initializer;
      if (value == null) {
        throw Exception("Should provide initital value for fields");
      }
      fields.add(
          Field(name: name, type: type.toString(), value: value.toString()));
    });
    print(
        "declared element : ${node.fields.type} node : ${node.fields.variables[0]}");
    return super.visitFieldDeclaration(node);
  }
}

class Field {
  String name;
  String type;
  String value;

  Field({@required this.name, @required this.type, @required this.value}) {}

  @override
  String toString() {
    return "Field(Name : ${name} Type : ${type} Value : ${value})";
  }
}

class Method {
  final String name;
  final List<Field> params;
  final String body;

  Method(this.name, this.params, this.body);
}

String _createReducerModel(List<Field> fields, String name) {
  final mFields = fields.map((f) => "final ${f.type} ${f.name};").join("\n");
  final cFields = fields.map((f) => "@required this.${f.name}").join(", ");
  final constructor = "${name}({${cFields}});";
  final copyWithParams = fields.map((f) => "${f.type} ${f.name}").join(", ");
  final copyWithBody =
      fields.map((f) => "${f.name} : ${f.name} ?? this.${f.name}").join(", ");
  final copyWith =
      "${name} copyWith({${copyWithParams}}) => ${name}(${copyWithBody});";
  final copyWithMapBody = fields
      .map((f) => "${f.name} : map[\"${f.name}\"] ?? this.${f.name}")
      .join(", ");
  final copyWithMap =
      "${name} copyWithMap(Map<String,dynamic> map) => ${name}(${copyWithMapBody});";
  final result = """
      
      @immutable
      class ${name} {
        ${mFields}

        ${constructor}

        ${copyWith}

        ${copyWithMap}
      }
   """;
  return result;
}

bool _isThisPropertyAccessExpression(Expression exp) {
  if (exp is PropertyAccess) {
    final a = exp.toString().split(".");
    return a.length == 2 && a[0] == "this";
  } else {
    return false;
  }
}
