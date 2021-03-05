import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';

class PStateGenerator extends GeneratorForAnnotation<PState> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (!(element is ClassElement)) {
      throw Exception("Reducer should be applied on class only");
    }
    final classElement = element;
    print(
        "(((((((((((((((((************)))))))))${classElement.location} ${classElement.source.uri} fn ${classElement.source.fullName}");
    final className = element.name;
    if (!className.startsWith("\$")) {
      throw ArgumentError.value("PState class should start with \$");
    }
    final typeParamsWithBounds =
        element.typeParameters.map((e) => e.toString()).join(",");
    final typeParams = element.typeParameters.map((e) => e.name).join(",");
    // final persist = _getPersistValue(element);
    final modelName = className.substring(1);
    final visitor = ReducerAstVisitor();
    final astNode = AstUtils.getAstNodeFromElement(classElement);
    astNode.visitChildren(visitor);
    var fields = visitor.fields;
    final methods = visitor.methods;
    fields.addAll(methods.where((m) => m.isAsync).map((m) => Field(
        name: m.name,
        type: "AsyncActionField",
        value: "AsyncActionField()",
        param: null)));
    fields = processFields(fields);
    final syncReducerFunctionStr =
        _createReducerFunctionSync(methods.where((m) => !m.isAsync), modelName);
    final asyncReducerFubctionStr =
        _createReducerFunctionAsync(methods.where((m) => m.isAsync), modelName);
    print(fields);
    final group = "${element.source.fullName}_${className}".hashCode;
    final defaultState =
        "${modelName}(${fields.map((f) => "${f.name}:${f.type.startsWith("FormField") ? _addActionNameAndGroupNameToFormField(value: f.value!, actionName: f.name, group: group) : f.value}").join(", ")})";
    final reducerGroup = """
       $syncReducerFunctionStr
       $asyncReducerFubctionStr
       $modelName ${modelName}_DS() => $defaultState;
       
       const ${modelName}Meta = PStateMeta<${modelName}>(group:${group},
        reducer: ${syncReducerFunctionStr.isNotEmpty ? "${modelName}_SyncReducer" : "null"} ,
        aReducer: ${asyncReducerFubctionStr.isNotEmpty ? "${modelName}_AsyncReducer" : "null"} ,
        ds: ${modelName}_DS);
    """;
    final httpFields = _getHttpFields(classElement.fields);
    print("httpFields $httpFields");
    final formFields = fields.where((f) => f.type.startsWith("FomField"));
    final actions = _generateActionsCreators(
        methods: visitor.methods,
        modelName: modelName,
        group: group,
        formFields: formFields,
        httpFields: httpFields);

    final result = """
       // class Name : ${element.name}

       ${_createPStateModel(fields: fields, name: modelName, typaParamsWithBounds: typeParamsWithBounds, typeParams: typeParams)}
       ${actions}
        ${reducerGroup}
    """;
    // print("********************* PState: $result");
    return result;
  }
}

bool _getPersistValue(ClassElement element) {
  final annot = element.metadata
      .firstWhere((element) => element.toString().startsWith("PState"))
      .computeConstantValue()!;
  final persistMode = DBuilderOptions.psBuilderOptions.persistMode;
  var persist = annot.getField("persist")?.toBoolValue();
  if (persistMode == null && persist != null) {
    throw Exception(
        "You should provider pesistMode option in build.yaml for dstore|ps builder");
  }
  if (persistMode == null) {
    return false;
  }
  switch (persistMode) {
    case PersistMode.ExplicitPersist:
      persist = persist == true;
      break;
    case PersistMode.ExplicitNoPersist:
      persist = persist != false;
      break;
  }
  return persist;
}

String _addActionNameAndGroupNameToFormField(
    {required String value, required String actionName, required int group}) {
  return "${value.substring(0, value.lastIndexOf(")"))},internalAName: \"$actionName\",internalAGroup:$group)";
}

const STATE_VARIABLE = "_DStoreState";

const ACTION_VARIABLE = "_DstoreAction";

const PAYLOAD_VARIBALE = "_DstoreActionPayload";

const DSTORE_PREFIX = "_DStore_";

String _generateActionsCreators({
  required List<ReducerMethod> methods,
  List<_HttpFieldInfo> httpFields = const [],
  Iterable<Field> formFields = const [],
  required String modelName,
  required int group,
}) {
  final methodActions = methods.map((m) {
    final paramsList = m.params.map((p) {
      if (!p.isOptional) {
        return "required ${p.type} ${p.name}";
      } else {
        final defaultValue = p.value != null ? "= ${p.value}" : "";
        return "${p.type} ${p.name} ${defaultValue} ";
      }
    }).toList();
    if (m.isAsync) {
      paramsList.add("Duration? debounce");
    }
    final params = paramsList.join(", ");

    var payload = m.params.isNotEmpty
        ? "{ " +
            m.params.map((p) => """ "${p.name}":${p.name} """).join(",") +
            "}"
        : "";
    if (payload.isNotEmpty) {
      payload = ", payload: ${payload}";
    }
    return """
      static Action ${m.name}(${params.isEmpty ? "" : "{$params}"})  {
         return Action(name:"${m.name}",group:${group} ${payload},isAsync: ${m.isAsync}${m.isAsync ? ", debounce: debounce" : ""});
      }
    """;
  }).join("\n");
  final httpActions = httpFields.map((hf) {
    final params = <String>[];
    final payloadFields = <String>[];
    if (hf.queryParamsType != null) {
      params.add("required ${hf.queryParamsType} queryParams");
      payloadFields.add(
          "queryParams: ${hf.queryParamsType!.startsWith("Map<") ? "queryParams" : "queryParams.toMap()"}");
    }
    if (hf.inputType != null) {
      if (hf.inputType!.startsWith("GraphqlRequestInput")) {
        final it = hf.inputType!;
        final query = hf.graphqlQuery!;
        final variableType = it.contains("<")
            ? it.substring(it.indexOf("<"), it.indexOf(">"))
            : null;
        if (variableType != null) {
          params.add("required ${variableType} variables");
          payloadFields.add("input: GraphqlRequestInput(\"$query\",variables)");
        } else {
          payloadFields.add("input: GraphqlRequestInput(\"$query\",null)");
        }
      } else {
        params.add("required ${hf.inputType} input");
        payloadFields.add("input:input");
      }
    }
    params.add("bool abortable = false");
    payloadFields.add("abortable: abortable");
    params.add("Map<String,dynamic>? headers");
    payloadFields.add("headers:headers");
    params.add("${hf.responseType} optimisticResponse");
    payloadFields.add("optimisticResponse:optimisticResponse");
    payloadFields.add("""url:"${hf.url}" """);
    payloadFields.add("""method: "${hf.method}" """);
    // payloadFields.add("isGraphql:${hf.isGraphql}");
    payloadFields.add("inputType:${hf.inputTypeEnum}");
    payloadFields.add("responseType:${hf.responseTypeEnum}");
    // payloadFields.add("responseDeserializer:${hf.responseDeserializer}");
    // payloadFields.add("errorDeserializer:${hf.errorDeserializer}");

    params.add("Duration? debounce");
    return """
      static ${hf.name}({${params.join(", ")}}) {
        return Action(name:"${hf.name}",group:${group},http:HttpPayload(${payloadFields.join(", ")}),debounce:debounce);
      }
    """;
  }).join("\n");

  final formActions = formFields.map((ff) {
    return """
   static ${ff.name}(FormReq req) {
     return Action(name:"$ff.name}",group:${group},form:req);
   }
   """;
  }).join("\n");

  return """
     abstract class ${modelName}Actions {
         ${methodActions}
         ${httpActions}
         ${formActions}
     }
  """;
}

List<_HttpFieldInfo> _getHttpFields(List<FieldElement> fields) {
  final result = <_HttpFieldInfo>[];
  fields.forEach((f) {
    final ht = AstUtils.isSubTypeof(f.type, "HttpField");
    print("ht $ht");
    if (ht != null) {
      if (ht.typeArguments.length != 4) {
        throw Exception("You should specify all 4 generic types of HttpField");
      }
      String? queryParamsType = replaceEndStar(
          ht.typeArguments[0].getDisplayString(withNullability: true));
      print("queryParamsType $queryParamsType");
      if (queryParamsType == "Null") {
        queryParamsType = null;
      }
      String? inputType = replaceEndStar(
          ht.typeArguments[1].getDisplayString(withNullability: true));
      if (inputType == "Null") {
        inputType = null;
      }
      final responseType = replaceEndStar(
          ht.typeArguments[2].getDisplayString(withNullability: true));
      final errorType = replaceEndStar(
          ht.typeArguments[3].getDisplayString(withNullability: true));
      // f.type.element.metadata
      print("_getHttpFields ${f.type.element}");
      if (f.type.element!.metadata.isEmpty) {
        throw Exception("You should annonate type with HttpRequest annonation");
      }
      final req = f.type.element!.metadata[0].computeConstantValue()!;
      final url = req.getField("url")!.toStringValue();
      final method = req.getField("method")!.toStringValue();
      late HttpResponseType responseTypeEnum;
      final responseTypeField = req.getField("responseType");
      if (responseTypeField != null && !responseTypeField.isNull) {
        responseTypeEnum = HttpResponseType.values.singleWhere((v) =>
            responseTypeField.getField(v.toString().split('.')[1]) != null);
      } else {
        if (responseType == "String") {
          responseTypeEnum = HttpResponseType.STRING;
        } else if (responseType != "Null") {
          responseTypeEnum = HttpResponseType.JSON;
        }
      }
      print("_getHttpFields response done");
      HttpInputType inputTypeEnum;
      final inputTypeField = req.getField("inputType");
      print("_getHttpFields inputTypeField $inputTypeField");
      if (inputTypeField != null && !inputTypeField.isNull) {
        inputTypeEnum = HttpInputType.values.singleWhere(
            (v) => inputTypeField.getField(v.toString().split('.')[1]) != null);
      } else {
        if (inputType == "String") {
          inputTypeEnum = HttpInputType.TEXT;
        } else {
          inputTypeEnum = HttpInputType.JSON;
        }
      }
      print("_getHttpFields input done");
      var responseDeserializer = "(resp) => resp";
      final responseDeserializerField = req.getField("responseDeserializer");
      if (responseDeserializerField != null &&
          !responseDeserializerField.isNull) {
        responseDeserializer =
            responseDeserializerField.toFunctionValue()!.name;
      }
      print("_getHttpFields responseDeserializer done");
      var errorDeserializer = "(err) => err";
      final errorDeserializerField = req.getField("errorDeserializer");
      if (errorDeserializerField != null && !errorDeserializerField.isNull) {
        errorDeserializer = errorDeserializerField.toFunctionValue()!.name;
      }
      print("_getHttpFields responseDeserializer done");
      final graphqlQuery = req.getField("graphqlQuery")?.toStringValue();
      String? inputSerializer;
      final inputSerializerField = req.getField("inputSerializer");
      if (inputSerializerField != null && !inputSerializerField.isNull) {
        inputSerializer = inputSerializerField.toFunctionValue()!.name;
      }

      final reqEA = f.metadata
          .where((a) => a.element!.name!.startsWith("HttpRequestExtension"));
      String? transformer;
      if (reqEA.isNotEmpty) {
        final reqE = f.metadata.first.computeConstantValue()!;
        final tf = reqE.getField("transformer");
        if (tf != null) {
          transformer = tf.toFunctionValue()!.name;
        }
      }

      final hfi = _HttpFieldInfo(
          name: f.name,
          url: url!,
          method: method!,
          inputTypeEnum: inputTypeEnum,
          responseTypeEnum: responseTypeEnum,
          inputType: inputType,
          responseDeserializer: responseDeserializer,
          errorDeserializer: errorDeserializer,
          queryParamsType: queryParamsType,
          inputSerializer: inputSerializer,
          responseType: responseType,
          transformer: transformer,
          graphqlQuery: graphqlQuery);
      result.add(hfi);
    }
  });
  return result;
}

class _HttpFieldInfo {
  final String name;
  final String url;
  final String? inputType;
  final HttpInputType inputTypeEnum;
  final HttpResponseType responseTypeEnum;
  final String responseDeserializer;
  final String? inputSerializer;
  final String? transformer;
  final String errorDeserializer;
  final String method;
  final String? queryParamsType;
  final String? graphqlQuery;
  final String responseType;

  _HttpFieldInfo({
    required this.name,
    required this.url,
    required this.inputType,
    required this.inputTypeEnum,
    required this.responseType,
    required this.responseTypeEnum,
    required this.responseDeserializer,
    required this.errorDeserializer,
    required this.method,
    this.inputSerializer,
    this.transformer,
    required this.queryParamsType,
    this.graphqlQuery,
  });
}

class ReducerAstVisitor extends SimpleAstVisitor {
  List<Field> fields = [];
  List<ReducerMethod> methods = [];

  @override
  dynamic visitMethodDeclaration(MethodDeclaration node) {
    final body = node.body;
    if (body is EmptyFunctionBody) {
      throw Exception("method should contain mutation to fields");
    }
    final name = node.name.toString();
    final params = AstUtils.convertParamsToFields(node.parameters);

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
        // if(statement is TryStatement) {
        //    statement.
        // }
        if (statement is ForStatement) {
          print(
              "forstatement lp ${statement.forLoopParts} body ${statement.body.runtimeType}");
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
  dynamic visitFieldDeclaration(FieldDeclaration node) {
    final typeA = node.fields.type as TypeAnnotation?;
    if (typeA == null) {
      throw Exception("Should provide type annotation for fields");
    }
    final type = typeA.toString();
    node.fields.variables.forEach((v) {
      final name = v.name.toString();
      final valueE = v.initializer as Expression?;
      if (!type.endsWith("?") && valueE == null) {
        throw Exception("Should provide initital value for fields");
      }
      // final value = type.endsWith("?") ? "null" : valueE.toString();
      fields.add(Field(name: name, type: type, value: valueE.toString()));
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
      {required this.isAsync,
      required this.name,
      required this.params,
      required this.body});
}

enum MethodStatementKind {
  GeneralStatement,
  IfStatement,
  IfElseStatement,
  ForeachStatement,
  TryStatement,
  MutationStatement,
  ForLoopStatement
}

abstract class StatementResult {
  MethodStatementKind get kind;
}

class GeneralStatementResult extends StatementResult {
  Statement statment;
  GeneralStatementResult({
    required this.statment,
  });
  @override
  MethodStatementKind get kind => MethodStatementKind.GeneralStatement;
}

class MutationStatementResult extends StatementResult {
  final String key;
  final String code;

  MutationStatementResult({required this.key, required this.code});
  @override
  MethodStatementKind get kind => MethodStatementKind.MutationStatement;
}

class ForEachStatementResult extends StatementResult {
  final ExpressionStatement statement;
  final List<StatementResult> statementResults;

  ForEachStatementResult(
      {required this.statement, required this.statementResults});

  @override
  MethodStatementKind get kind => MethodStatementKind.ForeachStatement;
}

class IfStatementResult extends StatementResult {
  final IfStatement statement;
  final List<StatementResult> statementResults;

  IfStatementResult({required this.statement, required this.statementResults});
  @override
  MethodStatementKind get kind => MethodStatementKind.IfStatement;
}

class IfElseStatementResult extends StatementResult {
  final IfStatement statement;
  final List<StatementResult> ifStatementResults;
  final List<StatementResult> elseStatementResults;

  IfElseStatementResult(
      {required this.statement,
      required this.ifStatementResults,
      required this.elseStatementResults});
  @override
  MethodStatementKind get kind => MethodStatementKind.IfElseStatement;
}

class TryStatementResult extends StatementResult {
  final TryStatement statement;
  final List<StatementResult> tryStatementResults;
  final List<List<StatementResult>> catchStatementResults;
  final List<StatementResult> finalStatementResults;

  TryStatementResult(
      {required this.statement,
      required this.tryStatementResults,
      required this.catchStatementResults,
      required this.finalStatementResults});
  @override
  MethodStatementKind get kind => MethodStatementKind.TryStatement;
}

class ForStatementResult extends StatementResult {
  final ForStatement statement;
  final List<StatementResult> statementResults;

  ForStatementResult({required this.statement, required this.statementResults});
  @override
  MethodStatementKind get kind => MethodStatementKind.ForLoopStatement;
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

String _createPStateModel(
    {required List<Field> fields,
    required String name,
    required String typeParams,
    required String typaParamsWithBounds}) {
  final result = """
      
      @immutable
      class ${name} implements PStateModel {
        ${ModelUtils.getFinalFieldsFromFieldsList(fields)}
        ${ModelUtils.getCopyWithField(name)}
        ${ModelUtils.createConstructorFromFieldsList(name, fields)}

        ${ModelUtils.createCopyWithMapFromFieldsList(name, fields)}

        ${ModelUtils.createToMapFromFieldsList(fields)}
        
        ${ModelUtils.createEqualsFromFieldsList(name, fields)}

        ${ModelUtils.createHashcodeFromFieldsList(fields)}

        ${ModelUtils.createToStringFromFieldsList(name, fields)}
      }

      ${ModelUtils.createCopyWithClasses(name: name, typeParams: typeParams, typeParamsWithBounds: typaParamsWithBounds, fields: fields)}
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

String processMethodStatements(List<Statement> statements) {
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
        "There hsould be atleast one assignemtn operation for class fields");
  }
  final keys = mutationStatements.map((e) => e.key).toSet();
  final statementsStr =
      convertStatementResultsToString(statementResults, keys).join("\n");
  print("hellokeys $keys");
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
  if (methods.isEmpty) {
    return "";
  }
  final cases = methods.map((m) => """
     case "${m.name}": {
       ${m.body}
     }
  """).join("\n");
  return """ 
   dynamic ${modelName}_SyncReducer(dynamic ${STATE_VARIABLE},Action ${ACTION_VARIABLE}) {
      ${STATE_VARIABLE} = ${STATE_VARIABLE} as ${modelName};
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
  if (methods.isEmpty) {
    return "";
  }
  final cases = methods.map((m) => """
     case "${m.name}": {
       ${m.body}
     }
  """).join("\n");
  return """ 
   Future<dynamic> ${modelName}_AsyncReducer(dynamic ${STATE_VARIABLE},Action ${ACTION_VARIABLE}) async {
      ${STATE_VARIABLE} = ${STATE_VARIABLE} as ${modelName};
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
