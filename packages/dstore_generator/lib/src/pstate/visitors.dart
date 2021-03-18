import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/errors.dart';
import 'package:dstore_generator/src/pstate/constants.dart';
import 'package:dstore_generator/src/pstate/types.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:tuple/tuple.dart';

class PStateAstVisitor extends SimpleAstVisitor<dynamic> {
  List<Field> fields = [];
  List<PStateMethod> methods = [];
  final bool isPersitable;
  final ClassElement element;
  final bool historyEnabled;
  final int? historyLimit;

  PStateAstVisitor(
      {required this.element,
      required this.isPersitable,
      this.historyLimit,
      required this.historyEnabled});

  @override
  dynamic visitMethodDeclaration(MethodDeclaration node) {
    final body = node.body;
    if (body is EmptyFunctionBody) {
      throw Exception("method should contain mutation to fields");
    }
    if (node.body.isAsynchronous &&
        node.returnType?.toString() != "Future<void>") {
      throw InvalidSignatureError(
          "You should annotate method  '${node.name.name}' return type with Future<void>  ");
    } else if (!node.body.isAsynchronous &&
        node.returnType?.toString() != "void") {
      throw InvalidSignatureError(
          "You should annotate method  '${node.name.name}' return type with void  ");
    }

    final name = node.name.toString();
    final params = AstUtils.convertParamsToFields(node.parameters);

    final paramsStr = _convertMethodParamsToString(params);
    var mbody = "";
    final keys = <String>[];
    if (body is ExpressionFunctionBody) {
      final e = body.expression;
      if (e is AssignmentExpression) {
        if (!_isThisPropertyAccessExpression(e.leftHandSide)) {
          throw Exception(
              "Singleline body should be assigment expression of class variable with this. prefix");
        }
        final pa = e.leftHandSide as PropertyAccess;
        keys.add(pa.propertyName.name);
        final fname = pa.toString().split(".")[1];
        mbody = """
           ${paramsStr}
           return ${STATE_VARIABLE}.copyWith(${fname}:${e.rightHandSide.toString().replaceAll("this.", "${STATE_VARIABLE}.")});
        """;
      } else {
        throw Exception(
            "Singleline body should assigment expression of class variable with this.prefix");
      }
    } else if (body is BlockFunctionBody) {
      final msr = processMethodStatements(
          body.block.statements, historyEnabled, historyLimit);
      final statements = msr.item1;
      keys.addAll(msr.item2);
      mbody = """
           ${paramsStr}
           ${statements}
           """;
    }
    // if (node.body is BlockFunctionBody) {
    //   final ex = node.body as BlockFunctionBody;
    //   ex.block.statements.forEach((statement) {
    //     print(
    //         "************** Check ${statement.toString()} ${statement.runtimeType}");
    //     // if(statement is TryStatement) {
    //     //    statement.
    //     // }
    //     if (statement is ForStatement) {
    //       print(
    //           "forstatement lp ${statement.forLoopParts} body ${statement.body.runtimeType}");
    //     }
    //   });
    // }
    methods.add(PStateMethod(
        isAsync: node.body.isAsynchronous,
        name: name,
        params: params,
        keysModified: keys
            .map((e) => fields.singleWhere((element) => element.name == e))
            .toList(),
        body: mbody));
    return super.visitMethodDeclaration(node);
  }

  @override
  dynamic visitFieldDeclaration(FieldDeclaration node) {
    final typeA = node.fields.type;
    if (typeA == null) {
      throw Exception("Should provide type annotation for fields");
    }
    final type = typeA.toString();
    node.fields.variables.forEach((v) {
      final name = v.name.toString();
      final valueE = v.initializer;
      if (!type.endsWith("?") && valueE == null) {
        throw ArgumentError.value("Should provide initital value for fields");
      }
      final value = valueE.toString();
      final fe = element.fields.singleWhere((f) => f.name == name);
      logger.shout(
          "Variable Annotations $fe ${fe.metadata} element ${v.declaredElement}");
      // final value = type.endsWith("?") ? "null" : valueE.toString();
      var annotations = fe.metadata.map((e) => e.toSource()).toList();
      final noPersitAnnot = fe.annotationFromType(ExcludeThisKeyWhilePersit);
      if (isPersitable && noPersitAnnot != null) {
        if (fe.hasJsonKey) {
          annotations = fe.mergeJsonKeyAndReturnAnnotations(
              <String, dynamic>{"ignore": true});
        } else {
          annotations.add("@JsonKey(ignore: true)");
        }
      }
      fields.add(Field(
          name: name, annotations: annotations, type: type, value: value));
    });
    print(
        "declared element : ${node.fields.type} node : ${node.fields.variables[0]}");
    return super.visitFieldDeclaration(node);
  }
}

String _convertMethodParamsToString(List<Field> params) {
  if (params.isEmpty) return "";
  final p = params
      .map((p) =>
          "final ${p.name} = ${PAYLOAD_VARIBALE}[\"${p.name}\"] as ${p.type};")
      .join("\n");
  return """
      final ${PAYLOAD_VARIBALE} = ${ACTION_VARIABLE}.payload!;
      ${p}
  """;
}

bool _isThisPropertyAccessExpression(Expression exp) {
  if (exp is PropertyAccess) {
    final a = exp.toString().split(".");
    return a.length == 2 && a[0] == "this";
  } else {
    return false;
  }
}

class ProcessStatementOptions {
  final bool isReturnSupported;

  const ProcessStatementOptions({this.isReturnSupported = false});
}

bool isMutationStatement(AstNode statement) {
  var result = false;
  //  print("*** is")
  if (statement is ExpressionStatement) {
    final exp = statement.expression;
    if (exp is AssignmentExpression) {
      result = _isThisPropertyAccessExpression(exp.leftHandSide);
    }
  }
  return result;
}

bool isForEachStatement(AstNode statement) {
  var result = false;
  if (statement is ExpressionStatement) {
    final exp = statement.expression;
    if (exp is MethodInvocation) {
      result = exp.methodName.toString() == "forEach";
    }
  }
  return result;
}

ForEachStatementResult processForEachStatement(Statement statement) {
  var statementResults = <StatementResult>[];
  final exp = statement as ExpressionStatement;
  final mi = exp.expression as MethodInvocation;
  final fExp = mi.argumentList.arguments[0] as FunctionExpression?;
  if (fExp == null) {
    throw Exception("You should provide argument to forEach");
  }
  final body = fExp.body;
  if (body is ExpressionFunctionBody) {
    statementResults = processStatements([body.expression]);
  } else if (body is BlockFunctionBody) {
    statementResults = processStatements(body.block.statements);
  }
  return ForEachStatementResult(
      statement: statement, statementResults: statementResults);
}

IfStatementResult processIfOnlyStatement(
    Statement statement, ProcessStatementOptions options) {
  final thenStatement = (statement as IfStatement).thenStatement;
  var statementResults = <StatementResult>[];
  if (thenStatement is ExpressionStatement) {
    statementResults = processStatements([thenStatement], options);
  }
  if (thenStatement is Block) {
    statementResults = processStatements(thenStatement.statements, options);
  }
  return IfStatementResult(
      statement: statement, statementResults: statementResults);
}

IfElseStatementResult processIfElseStatement(
    Statement statement, ProcessStatementOptions options) {
  final thenStatement = (statement as IfStatement).thenStatement;
  var ifStatementResults = <StatementResult>[];
  if (thenStatement is ExpressionStatement) {
    ifStatementResults = processStatements([thenStatement]);
  }
  if (thenStatement is Block) {
    ifStatementResults = processStatements(thenStatement.statements);
  }
  var elseStatementResults = <StatementResult>[];
  final elseStatement = statement.elseStatement;
  if (elseStatement is Block) {
    elseStatementResults = processStatements(elseStatement.statements, options);
  } else if (elseStatement is IfStatement &&
      elseStatement.elseStatement == null) {
    elseStatementResults = [processIfOnlyStatement(elseStatement, options)];
  } else if (elseStatement is IfStatement) {
    elseStatementResults = [processIfElseStatement(elseStatement, options)];
  } else {
    elseStatementResults = processStatements([elseStatement!], options);
  }
  return IfElseStatementResult(
      statement: statement,
      ifStatementResults: ifStatementResults,
      elseStatementResults: elseStatementResults);
}

TryStatementResult processTryStatement(
    TryStatement statement, ProcessStatementOptions options) {
  print("Processing try statement $statement");
  final tryStatementResults =
      processStatements(statement.body.statements, options);
  final catchStatementResults = statement.catchClauses
      .map((cc) => processStatements(cc.body.statements, options))
      .toList();
  print("catch done");
  final List<StatementResult> finalStatementResults =
      statement.finallyBlock == null
          ? []
          : processStatements(statement.finallyBlock!.statements, options);
  return TryStatementResult(
      statement: statement,
      tryStatementResults: tryStatementResults,
      catchStatementResults: catchStatementResults,
      finalStatementResults: finalStatementResults);
}

ForStatementResult processForStatement(
    ForStatement statement, ProcessStatementOptions options) {
  late List<StatementResult> statementResults;
  final body = statement.body;
  if (body is Block) {
    statementResults = processStatements(body.statements, options);
  } else {
    statementResults = processStatements([body], options);
  }
  return ForStatementResult(
      statement: statement, statementResults: statementResults);
}

List<StatementResult> processStatements(List<AstNode> statements,
    [ProcessStatementOptions options = const ProcessStatementOptions()]) {
  return statements.map((statement) {
    late StatementResult result;
    if (isMutationStatement(statement)) {
      final exp = ((statement as ExpressionStatement).expression
          as AssignmentExpression);
      final key = exp.leftHandSide.toString().split(".")[1];
      final code =
          """${DSTORE_PREFIX}${key} ${exp.operator} ${exp.rightHandSide.toString().replaceAll("this.", "${STATE_VARIABLE}.")};""";
      result = MutationStatementResult(key: key, code: code);
    } else if (isForEachStatement(statement)) {
      result = processForEachStatement(statement as Statement);
    } else if (statement is IfStatement && statement.elseStatement == null) {
      // ifonly statement
      result = processIfOnlyStatement(statement, options);
    } else if (statement is IfStatement) {
      // if else
      result = processIfElseStatement(statement, options);
    } else if (statement is TryStatement) {
      result = processTryStatement(statement, options);
    } else if (statement is ForStatement) {
      result = processForStatement(statement, options);
    } else if (statement is ReturnStatement && !options.isReturnSupported) {
      throw Exception("Return statement is not supported use if else");
    } else {
      result = GeneralStatementResult(statment: statement as Statement);
    }
    return result;
  }).toList();
}

String replaceThisWithStateText(String input, Iterable<String> keys) {
  var result = input;
  keys.forEach((key) {
    result = result.replaceAll("this.${key}", "${DSTORE_PREFIX}${key}");
  });
  result = result.replaceAll("this.", "${STATE_VARIABLE}.");
  return result;
}

String replaceThisWithState(AstNode node, Iterable<String> keys) {
  return replaceThisWithStateText(node.toString(), keys);
}

String convertIfStatementResultToString(
    IfStatementResult statementResult, Iterable<String> keys) {
  final condition =
      replaceThisWithState(statementResult.statement.condition, keys);
  return """
       if(${condition}) {
         ${convertStatementResultsToString(statementResult.statementResults, keys).join("\n")}
       }
   """;
}

String convertIfElseStatementResultToString(
    IfElseStatementResult iesr, Iterable<String> keys) {
  final ies = iesr.statement;
  final ifCond = replaceThisWithState(ies.condition, keys);
  final ifBody =
      convertStatementResultsToString(iesr.ifStatementResults, keys).join("\n");
  final elseS = ies.elseStatement;
  var else_str = "";
  if (elseS is Block || elseS is ExpressionStatement) {
    else_str = """else {
         ${convertStatementResultsToString(iesr.elseStatementResults, keys).join("\n")}
       }""";
  } else if (elseS is IfStatement && elseS.elseStatement == null) {
    else_str =
        "else ${convertIfStatementResultToString(iesr.elseStatementResults[0] as IfStatementResult, keys)}";
  } else if (elseS is IfStatement) {
    else_str =
        "else ${convertIfElseStatementResultToString(iesr.elseStatementResults[0] as IfElseStatementResult, keys)}";
  }

  return """
    if(${ifCond}) {
      ${ifBody}
    } ${else_str}
  """;
}

String converForEachStatementResultToString(
    ForEachStatementResult fesr, Iterable<String> keys) {
  final mi = fesr.statement.expression as MethodInvocation;

  final fExp = mi.argumentList.arguments[0] as FunctionExpression;
  final params = fExp.parameters!.parameters.map((p) => p.toString()).join(",");
  final call = "${mi.target}.${mi.methodName}";
  final body =
      convertStatementResultsToString(fesr.statementResults, keys).join("\n");
  return """${call}((${params}) => {
     ${body}
  }) """;
}

String convertTryStatementResultToString(
    TryStatementResult tsr, Iterable<String> keys) {
  final tb =
      convertStatementResultsToString(tsr.tryStatementResults, keys).join("\n");
  print("tb $tb");
  final cb = tsr.statement.catchClauses.asMap().entries.map((me) {
    final i = me.key;
    final c = me.value;
    final cb =
        convertStatementResultsToString(tsr.catchStatementResults[i], keys)
            .join("\n");
    print(
        "cblock $c ck ${c.catchKeyword} cp ${c.exceptionParameter} sp ${c.stackTraceParameter} ");
    final onException =
        c.exceptionType != null ? "on ${c.exceptionType} " : " ";
    final catchClause = c.catchKeyword != null
        ? "catch(${c.exceptionParameter}${c.stackTraceParameter != null ? ", ${c.stackTraceParameter}" : ""})"
        : "";
    return """${onException} ${catchClause} {
        ${cb}
      }""";
  }).join("\n");
  final fb = tsr.finalStatementResults.isNotEmpty
      ? """ finally {
        ${convertStatementResultsToString(tsr.finalStatementResults, keys).join("\n")}
      }
        """
      : "";
  return """
       try {
          ${tb}
       } ${cb}
        ${fb}
      """;
}

String convertForStatementResultToString(
    ForStatementResult fsr, Iterable<String> keys) {
  final flp = replaceThisWithState(fsr.statement.forLoopParts, keys);
  return """
    for(${flp}) {
      ${convertStatementResultsToString(fsr.statementResults, keys).join("\n")}
    }
  """;
}

List<String> convertStatementResultsToString(
    List<StatementResult> statmentResults, Iterable<String> keys) {
  final result = <String>[];
  statmentResults.forEach((sr) {
    switch (sr.kind) {
      case MethodStatementKind.GeneralStatement:
        final gsr = sr as GeneralStatementResult;
        result.add(replaceThisWithState(gsr.statment, keys));
        break;
      case MethodStatementKind.IfStatement:
        final isr = sr as IfStatementResult;
        result.add(convertIfStatementResultToString(isr, keys));
        break;
      case MethodStatementKind.IfElseStatement:
        final iesr = sr as IfElseStatementResult;
        result.add(convertIfElseStatementResultToString(iesr, keys));
        break;
      case MethodStatementKind.ForeachStatement:
        final fesr = sr as ForEachStatementResult;
        result.add(converForEachStatementResultToString(fesr, keys));
        break;
      case MethodStatementKind.TryStatement:
        final tsr = sr as TryStatementResult;
        result.add(convertTryStatementResultToString(tsr, keys));
        break;
      case MethodStatementKind.MutationStatement:
        final msr = sr as MutationStatementResult;
        result.add(msr.code);
        break;
      case MethodStatementKind.ForLoopStatement:
        final fsr = sr as ForStatementResult;
        result.add(convertForStatementResultToString(fsr, keys));
        break;
    }
  });
  return result;
}

Tuple2<String, Set<String>> processMethodStatements(
    List<Statement> statements, bool historyEnabled, int? limit) {
  final statementResults = processStatements(statements);
  print("statementResults ${statementResults}");
  List<MutationStatementResult> getMutationOnlyStatementResults(
      List<StatementResult> statementResults) {
    final result = <MutationStatementResult>[];
    statementResults.forEach((sr) {
      switch (sr.kind) {
        case MethodStatementKind.GeneralStatement:
          break;
        case MethodStatementKind.IfStatement:
          result.addAll(getMutationOnlyStatementResults(
              (sr as IfStatementResult).statementResults));
          break;
        case MethodStatementKind.IfElseStatement:
          final ies = sr as IfElseStatementResult;
          result
              .addAll(getMutationOnlyStatementResults(ies.ifStatementResults));
          result.addAll(
              getMutationOnlyStatementResults(ies.elseStatementResults));
          break;
        case MethodStatementKind.ForeachStatement:
          final fs = sr as ForEachStatementResult;
          result.addAll(getMutationOnlyStatementResults(fs.statementResults));
          break;
        case MethodStatementKind.TryStatement:
          final tsr = sr as TryStatementResult;
          result
              .addAll(getMutationOnlyStatementResults(tsr.tryStatementResults));
          tsr.catchStatementResults.forEach((csr) {
            result.addAll(getMutationOnlyStatementResults(csr));
          });

          result.addAll(
              getMutationOnlyStatementResults(tsr.finalStatementResults));
          break;
        case MethodStatementKind.MutationStatement:
          result.add(sr as MutationStatementResult);
          break;
        case MethodStatementKind.ForLoopStatement:
          final fsr = sr as ForStatementResult;
          result.addAll(getMutationOnlyStatementResults(fsr.statementResults));
          break;
      }
    });
    return result;
  }

  final mutationStatements = getMutationOnlyStatementResults(statementResults);
  if (mutationStatements.isEmpty) {
    throw Exception(
        "There should be atleast one assignemtn operation for class fields");
  }
  final keys = mutationStatements.map((e) => e.key).toSet();
  final statementsStr =
      convertStatementResultsToString(statementResults, keys).join("\n");
  print("hellokeys $keys");
  final stataments = """
    ${keys.map((k) => "var ${DSTORE_PREFIX}${k} = ${STATE_VARIABLE}.${k};").join("\n")}
    ${statementsStr}
    ${historyEnabled ? """
    final newState = ${STATE_VARIABLE}.copyWith(${keys.map((k) => "${k} : ${DSTORE_PREFIX}${k}").join(",")});
    newState.internalPSHistory = STATE_VARIABLE.internalPSHistory;
    return newState;
    """ : "return ${STATE_VARIABLE}.copyWith(${keys.map((k) => "${k} : ${DSTORE_PREFIX}${k}").join(",")});"}
    
  """;
  return Tuple2(stataments, keys);
}
