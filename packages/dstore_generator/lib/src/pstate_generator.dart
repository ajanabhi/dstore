import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import 'package:dstore/dstore.dart';
import 'package:dstore_generator/src/utils.dart';

class PStateGenerator extends GeneratorForAnnotation<PState> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (!(element is ClassElement)) {
      throw Exception("Reducer should be applied on class only");
    }
    final classElement = element as ClassElement;
    print(
        "(((((((((((((((((************)))))))))${classElement.location} ${classElement.source.uri} fn ${classElement.source.fullName}");
    final className = element.name;
    if (!className.startsWith("_")) {
      throw Exception("PState class should start with _");
    }
    final modelName = className.substring(1);
    final visitor = ReducerAstVisitor();
    final astNode = getAstNodeFromElement(classElement);
    astNode.visitChildren(visitor);
    final fields = visitor.fields;
    final methods = visitor.methods;
    fields.addAll(methods.where((m) => m.isAsync).map((m) => Field(
        name: m.name,
        type: "AsyncActionField",
        value: "AsyncActionField()",
        param: null)));
    // fields.forEach((element) {
    //   //  if(element.name)
    //   if (element.name == "todos") {
    //     print("++++++ Todos : ${element.param.runtimeType}");
    //   }
    // });
    // classElement.fields.forEach((element) {
    //   if (element.name == "todos") {
    //     print(
    //         "++++++ Todos2 : ${element.type.runtimeType} meta ${element.type.element.metadata[0].element.runtimeType}");
    //     final ce = element.type.element.metadata[0].computeConstantValue();
    //     // print(
    //     //     "cv :  field ${ce.getField("responseType").toFunctionValue()} ${ce.getField("responseType").getField("JSON")} ");
    //     // print(
    //     //     "dr : ${ce.getField("deserializeResponseFn").toFunctionValue().name}");
    //     final v = HttpResponseType.values.singleWhere((v) =>
    //         ce.getField("responseType").getField(v.toString().split('.')[1]) !=
    //         null);
    //     print("CV value :$v");
    //     final InterfaceType t = element.type;
    //     print(
    //         "supeclass ${t.allSupertypes} ${isSubTypeof(element.type, "HttpField")} ");
    //   }
    // });
    final syncReducerFunctionStr =
        _createReducerFunctionSync(methods.where((m) => !m.isAsync), modelName);
    final asyncReducerFubctionStr =
        _createReducerFunctionAsync(methods.where((m) => m.isAsync), modelName);
    print(fields);
    final defaultState =
        "${modelName}(${fields.map((f) => "${f.name}:${f.value}").join(", ")})";
    final groupName = element.source
        .fullName; //TODO get fullnamefrom path fn /dstore_example/lib/src/reducers/sample.dart
    final reducerGroup = """
       final ${modelName}Meta = PStateMeta<${modelName}>(group:"${groupName}",
        reducer: ${syncReducerFunctionStr},
        aReducer: ${asyncReducerFubctionStr},
        ds: () => ${defaultState});
    """;
    // final httpFields = _getHttpFields(classElement.fields);
    final actions = _generateActionsCreators(
        methods: visitor.methods,
        modelName: modelName,
        group: groupName,
        httpFields: []);

    final result = """
       // class Name : ${element.name}

       ${_createPStateModel(fields, modelName)}
       ${actions}
        ${reducerGroup}
    """;
    // print("********************* PState: $result");
    return result;
  }
}

const STATE_VARIABLE = "_DStoreState";

const ACTION_VARIABLE = "_DstoreAction";

const PAYLOAD_VARIBALE = "_DstoreActionPayload";

const DSTORE_PREFIX = "_DStore_";

String _generateActionsCreators({
  @required List<ReducerMethod> methods,
  List<_HttpFieldInfo> httpFields = const [],
  @required String modelName,
  @required String group,
}) {
  final methodActions = methods.map((m) {
    final params = m.params.map((p) {
      if (!p.isOptional) {
        return "@required ${p.type} ${p.name}";
      } else {
        final defaultValue = p.value != null ? "= ${p.value}" : "";
        return "${p.type} ${p.name} ${defaultValue} ";
      }
    }).join(", ");

    var payload = m.params.length > 0
        ? "{ " +
            m.params.map((p) => """ "${p.name}":${p.name} """).join(",") +
            "}"
        : "";
    if (payload.isNotEmpty) {
      payload = ", payload: ${payload}";
    }
    return """
      static ${m.name}(${params.isEmpty ? "" : "{$params}"})  {
         return Action(name:"${m.name}",group:"${group}" ${payload},isAsync: ${m.isAsync});
      }
    """;
  }).join("\n");
  final httpActions = httpFields.map((hf) {
    final params = <String>[];
    final payloadFields = <String>[];
    if (hf.queryParamsType != null) {
      params.add("@required ${hf.queryParamsType} queryParams");
      payloadFields.add(
          "queryParams: ${hf.queryParamsType.startsWith("Map<") ? "queryParams" : "queryParams.toMap()"}");
    }
    if (hf.inputType != null) {
      params.add("@required ${hf.inputType} input");
      payloadFields.add("input:input");
    }
    params.add("bool abortable = false");
    payloadFields.add("abortable: abortable");
    params.add("bool offline = false");
    payloadFields.add("offline: offline");
    params.add("Map<String,dynamic> headers");
    payloadFields.add("headers:headers");
    params.add("${hf.responseType} optimisticReposne");
    payloadFields.add("optimistic:optiistic");
    payloadFields.add("""url:"${hf.url}" """);
    payloadFields.add("""method: "${hf.method}" """);
    payloadFields.add("isGraphql:${hf.isGraphql}");
    payloadFields.add("inputType:${hf.inputTypeEnum}");
    payloadFields.add("responseType:${hf.responseTypeEnum}");
    payloadFields.add("responseDeserializer:${hf.responseDeserializer}");
    payloadFields.add("errorDeserializer:${hf.errorDeserializer}");

    return """
      static ${hf.name}({${params.join(", ")}}) {
        return Action(name:"${hf.name}",group:"${group}",http:HttpPayload(${payloadFields.join(", ")}))
      }
    """;
  }).join("\n");
  return """
     abstract class ${modelName}Actions {
         ${methodActions}
         ${httpActions}
     }
  """;
}

List<_HttpFieldInfo> _getHttpFields(List<FieldElement> fields) {
  final result = <_HttpFieldInfo>[];
  fields.forEach((f) {
    final ht = isSubTypeof(f.type, "HttpField");
    if (ht != null) {
      if (ht.typeArguments.length != 4) {
        throw Exception("You should specify all 4 generic types of HttpField");
      }
      String queryParamsType =
          ht.typeArguments[0].getDisplayString(withNullability: false);
      if (queryParamsType == "Null") {
        queryParamsType = null;
      }
      String inputType =
          ht.typeArguments[1].getDisplayString(withNullability: false);
      if (inputType == "Null") {
        inputType = null;
      }
      final responseType =
          ht.typeArguments[2].getDisplayString(withNullability: false);
      final errorType =
          ht.typeArguments[3].getDisplayString(withNullability: false);
      // f.type.element.metadata
      if (f.type.element.metadata.isEmpty) {
        throw Exception("You should annonate type with HttpRequest annonation");
      }
      final req = f.type.element.metadata[0].computeConstantValue();
      final url = req.getField("url").toStringValue();
      final method = req.getField("method").toStringValue();
      HttpResponseType responseTypeEnum = null;
      final responseTypeField = req.getField("responseType");
      if (responseTypeField != null) {
        responseTypeEnum = HttpResponseType.values.singleWhere((v) =>
            responseTypeField.getField(v.toString().split('.')[1]) != null);
      } else {
        if (responseType == "String") {
          responseTypeEnum = HttpResponseType.STRING;
        } else if (responseType != "Null") {
          responseTypeEnum = HttpResponseType.JSON;
        }
      }
      HttpInputType inputTypeEnum = null;
      final inputTypeField = req.getField("inputType");
      if (inputTypeField != null) {
        inputTypeEnum = HttpInputType.values.singleWhere(
            (v) => inputTypeField.getField(v.toString().split('.')[1]) != null);
      } else {
        if (inputType == "String") {
          inputTypeEnum = HttpInputType.TEXT;
        } else {
          inputTypeEnum = HttpInputType.JSON;
        }
      }
      String responseDeserializer = "(resp) => resp";
      final responseDeserializerField = req.getField("responseDeserializer");
      if (responseDeserializerField != null) {
        responseDeserializer = responseDeserializerField.toFunctionValue().name;
      }
      String errorDeserializer = "(err) => err";
      final errorDeserializerField = req.getField("errorDeserializer");
      if (errorDeserializerField != null) {
        errorDeserializer = errorDeserializerField.toFunctionValue().name;
      }
      final isGraphql = req.getField("isGraphql")?.toBoolValue() ?? false;
      final hfi = _HttpFieldInfo(
          name: f.name,
          url: url,
          method: method,
          inputTypeEnum: inputTypeEnum,
          responseTypeEnum: responseTypeEnum,
          inputType: inputType,
          responseDeserializer: responseDeserializer,
          errorDeserializer: errorDeserializer,
          queryParamsType: queryParamsType,
          responseType: responseType,
          isGraphql: isGraphql);
      result.add(hfi);
    }
  });
  return result;
}

class _HttpFieldInfo {
  final String name;
  final String url;
  final String inputType;
  final HttpInputType inputTypeEnum;
  final HttpResponseType responseTypeEnum;
  final String responseDeserializer;
  final String errorDeserializer;
  final String method;
  final String queryParamsType;
  final bool isGraphql;
  final String responseType;

  _HttpFieldInfo({
    this.name,
    this.url,
    this.inputType,
    this.inputTypeEnum,
    this.responseType,
    this.responseTypeEnum,
    this.responseDeserializer,
    this.errorDeserializer,
    this.method,
    this.queryParamsType,
    this.isGraphql,
  });
}

class ReducerAstVisitor extends SimpleAstVisitor {
  List<Field> fields = [];
  List<ReducerMethod> methods = [];

  @override
  visitMethodDeclaration(MethodDeclaration node) {
    final body = node.body;
    if (body is EmptyFunctionBody) {
      throw Exception("method should contain mutation to fields");
    }
    final name = node.name.toString();
    final params = convertParamsToFields(node.parameters);

    final paramsStr = _convertMethodParamsToString(params);
    var mbody = "";
    if (body is ExpressionFunctionBody) {
      final e = body.expression;
      if (e is AssignmentExpression) {
        if (!_isThisPropertyAccessExpression(e.leftHandSide)) {
          throw Exception(
              "Singleline body should assigment expression of class variable with this. prefix");
        }
        final pa = e.leftHandSide as PropertyAccess;
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
      final s = processMethodStatements(body.block.statements);
      mbody = """
           ${paramsStr}
           ${s}
           """;
    }
    if (node.body is BlockFunctionBody) {
      final ex = node.body as BlockFunctionBody;
      ex.block.statements.forEach((statement) {
        print(
            "************** Check ${statement.toString()} ${statement.runtimeType}");
        if (statement is ExpressionStatement) {
          final exp = statement.expression;
          print("isAssignable ${exp.runtimeType}");
          if (exp is AssignmentExpression) {
            print("Hello ${exp.leftHandSide.runtimeType}");
            if (exp.leftHandSide is SimpleIdentifier) {
              final idn = exp.leftHandSide as SimpleIdentifier;
              print(
                  "Identifie: ${idn.inSetterContext()} ${idn.isQualified} ${idn.precedence} ${idn.parent} ${idn.inDeclarationContext()}");
            }
          }
          if (exp is MethodInvocation) {
            print(
                "**MMMMMM*** ${exp.argumentList.arguments} Type:  ${exp.argumentList.arguments[0].runtimeType} ");
          }
        }
        if (statement is IfStatement) {
          print("****IFIF***** ${statement.thenStatement.runtimeType}");
        }
      });
    }
    methods.add(ReducerMethod(
        isAsync: node.body.isAsynchronous,
        name: name,
        params: params,
        body: mbody));
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

class ReducerMethod {
  final String name;
  final List<Field> params;
  final String body;
  final bool isAsync;

  ReducerMethod(
      {@required this.isAsync,
      @required this.name,
      @required this.params,
      @required this.body});
}

enum MethodStatementKind {
  GeneralStatement,
  IfStatement,
  IfElseStatement,
  ForeachStatement,
  MutationStatement,
}

abstract class StatementResult {
  MethodStatementKind get kind;
}

class GeneralStatementResult extends StatementResult {
  Statement statment;
  GeneralStatementResult({
    @required this.statment,
  });
  @override
  MethodStatementKind get kind => MethodStatementKind.GeneralStatement;
}

class MutationStatementResult extends StatementResult {
  final String key;
  final String code;

  MutationStatementResult({@required this.key, @required this.code});
  @override
  MethodStatementKind get kind => MethodStatementKind.MutationStatement;
}

class ForEachStatementResult extends StatementResult {
  final ExpressionStatement statement;
  final List<StatementResult> statementResults;

  ForEachStatementResult(
      {@required this.statement, @required this.statementResults});

  @override
  MethodStatementKind get kind => MethodStatementKind.ForeachStatement;
}

class IfStatementResult extends StatementResult {
  final IfStatement statement;
  final List<StatementResult> statementResults;

  IfStatementResult(
      {@required this.statement, @required this.statementResults});
  @override
  MethodStatementKind get kind => MethodStatementKind.IfStatement;
}

class IfElseStatementResult extends StatementResult {
  final IfStatement statement;
  final List<StatementResult> ifStatementResults;
  final List<StatementResult> elseStatementResults;

  IfElseStatementResult(
      {@required this.statement,
      @required this.ifStatementResults,
      @required this.elseStatementResults});
  @override
  MethodStatementKind get kind => MethodStatementKind.IfElseStatement;
}

String _convertMethodParamsToString(List<Field> params) {
  if (params.isEmpty) return "";
  final p = params
      .map((p) =>
          "final ${p.name} = ${PAYLOAD_VARIBALE}[\"${p.name}\"] as ${p.type};")
      .join("\n");
  return """
      final ${PAYLOAD_VARIBALE} = ${ACTION_VARIABLE}.payload;
      ${p}
  """;
}

String _createPStateModel(List<Field> fields, String name) {
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

  final toMap =
      """Map<String,dynamic> toMap() => {${fields.map((f) => """ "${f.name}" : this.${f.name} """).join(", ")}};""";
  final result = """
      
      @immutable
      class ${name} implements PStateModel {
        ${mFields}

        ${constructor}

        ${copyWith}

        ${copyWithMap}

        ${toMap}
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

class ProcessStatementOptions {
  final bool isReturnSupported;

  const ProcessStatementOptions({this.isReturnSupported = false});
}

bool isMutationStatement(Statement statement) {
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

bool isForEachStatement(Statement statement) {
  var result = false;
  if (statement is ExpressionStatement) {
    final exp = statement.expression;
    if (exp is MethodInvocation) {
      result = exp.methodName == "forEach";
    }
  }
  return result;
}

ForEachStatementResult processForEachStatement(Statement statement) {
  List<StatementResult> statementResults = [];
  final exp = statement as ExpressionStatement;
  final mi = exp.expression as MethodInvocation;
  final fExp = mi.argumentList.arguments[0] as FunctionExpression;
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
  List<StatementResult> statementResults = [];
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
  List<StatementResult> ifStatementResults = [];
  if (thenStatement is ExpressionStatement) {
    ifStatementResults = processStatements([thenStatement]);
  }
  if (thenStatement is Block) {
    ifStatementResults = processStatements(thenStatement.statements);
  }
  List<StatementResult> elseStatementResults = [];
  final elseStatement = (statement as IfStatement).elseStatement;
  if (elseStatement is Block) {
    elseStatementResults = processStatements(elseStatement.statements, options);
  } else if (elseStatement is IfStatement &&
      elseStatement.elseStatement == null) {
    elseStatementResults = [processIfOnlyStatement(elseStatement, options)];
  } else if (elseStatement is IfStatement) {
    elseStatementResults = [processIfElseStatement(elseStatement, options)];
  } else {
    elseStatementResults = processStatements([elseStatement], options);
  }
  return IfElseStatementResult(
      statement: statement,
      ifStatementResults: ifStatementResults,
      elseStatementResults: elseStatementResults);
}

List<StatementResult> processStatements(List<AstNode> statements,
    [ProcessStatementOptions options = const ProcessStatementOptions()]) {
  return statements.map((statement) {
    StatementResult result = null;
    if (isMutationStatement(statement)) {
      final exp = ((statement as ExpressionStatement).expression
          as AssignmentExpression);
      final key = exp.leftHandSide.toString().split(".")[1];
      final code =
          """${DSTORE_PREFIX}${key} ${exp.operator} ${exp.rightHandSide.toString().replaceAll("this.", "${STATE_VARIABLE}.")};""";
      result = MutationStatementResult(key: key, code: code);
    } else if (isForEachStatement(statement)) {
      result = processForEachStatement(statement);
    } else if (statement is IfStatement && statement.elseStatement == null) {
      // ifonly statement
      result = processIfOnlyStatement(statement, options);
    } else if (statement is IfStatement) {
      // if else
      result = processIfElseStatement(statement, options);
    } else if (statement is ReturnStatement && !options.isReturnSupported) {
      throw Exception("Return statement is not supported use if else");
    } else {
      result = GeneralStatementResult(statment: statement);
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
        "else ${convertIfStatementResultToString(iesr.elseStatementResults[0], keys)}";
  } else if (elseS is IfStatement) {
    else_str =
        "else ${convertIfElseStatementResultToString(iesr.elseStatementResults[0], keys)}";
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
  final params = fExp.parameters.parameters.map((p) => p.toString()).join(",");
  final call = "${mi.target}.${mi.methodName}";
  final body =
      convertStatementResultsToString(fesr.statementResults, keys).join("\n");
  return """${call}((${params}) => {
     ${body}
  }) """;
}

List<String> convertStatementResultsToString(
    List<StatementResult> statmentResults, Iterable<String> keys) {
  List<String> result = [];
  statmentResults.forEach((sr) {
    if (sr.kind == MethodStatementKind.MutationStatement) {
      final msr = sr as MutationStatementResult;
      result.add(msr.code);
    } else if (sr.kind == MethodStatementKind.IfStatement) {
      final isr = sr as IfStatementResult;
      result.add(convertIfStatementResultToString(isr, keys));
    } else if (sr.kind == MethodStatementKind.IfElseStatement) {
      final iesr = sr as IfElseStatementResult;
      result.add(convertIfElseStatementResultToString(iesr, keys));
    } else if (sr.kind == MethodStatementKind.ForeachStatement) {
      final fesr = sr as ForEachStatementResult;
      result.add(converForEachStatementResultToString(fesr, keys));
    } else if (sr.kind == MethodStatementKind.GeneralStatement) {
      final gsr = sr as GeneralStatementResult;
      result.add(replaceThisWithState(gsr.statment, keys));
    }
  });
  return result;
}

String processMethodStatements(List<Statement> statements) {
  final statementResults = processStatements(statements);
  print("statementResults ${statementResults}");
  List<MutationStatementResult> getMutationOnlyStatementResults(
      List<StatementResult> statementResults) {
    final List<MutationStatementResult> result = [];
    statementResults.forEach((sr) {
      if (sr.kind == MethodStatementKind.MutationStatement) {
        result.add(sr);
      } else if (sr.kind == MethodStatementKind.ForeachStatement) {
        final fs = sr as ForEachStatementResult;
        result.addAll(getMutationOnlyStatementResults(fs.statementResults));
      } else if (sr.kind == MethodStatementKind.IfElseStatement) {
        final ies = sr as IfElseStatementResult;
        result.addAll(getMutationOnlyStatementResults(ies.ifStatementResults));
        result
            .addAll(getMutationOnlyStatementResults(ies.elseStatementResults));
      } else if (sr.kind == MethodStatementKind.IfStatement) {
        result.addAll(getMutationOnlyStatementResults(
            (sr as IfStatementResult).statementResults));
      }
    });
    return result;
  }

  final mutationStatements = getMutationOnlyStatementResults(statementResults);
  if (mutationStatements.length == 0) {
    throw Exception(
        "There hsould be atleast one assignemtn operation for class fields");
  }
  final keys = mutationStatements.map((e) => e.key).toSet();
  final statementsStr =
      convertStatementResultsToString(statementResults, keys).join("\n");
  return """
    ${keys.map((k) => "var ${DSTORE_PREFIX}${k} = ${STATE_VARIABLE}.${k};").join("\n")}
    ${statementsStr}
    return ${STATE_VARIABLE}.copyWith(${keys.map((k) => "${k} : ${DSTORE_PREFIX}${k}").join(",")});
  """;
}

String _createReducerFunctionSync(
  Iterable<ReducerMethod> methods,
  String modelName,
) {
  final cases = methods.map((m) => """
     case "${m.name}": {
       ${m.body}
     }
  """).join("\n");
  return """ 
    (${modelName} ${STATE_VARIABLE},Action ${ACTION_VARIABLE}) {
      final name = ${ACTION_VARIABLE}.name;
      switch(name) {
        ${cases}
       default: {
        return ${STATE_VARIABLE};
       }
      }
    }
  """;
}

String _createReducerFunctionAsync(
  Iterable<ReducerMethod> methods,
  String modelName,
) {
  final cases = methods.map((m) => """
     case "${m.name}": {
       ${m.body}
     }
  """).join("\n");
  return """ 
    (${modelName} ${STATE_VARIABLE},Action ${ACTION_VARIABLE}) async {
      final name = ${ACTION_VARIABLE}.name;
      switch(name) {
        ${cases}
       default: {
        return ${STATE_VARIABLE};
       }
      }
    }
  """;
}
