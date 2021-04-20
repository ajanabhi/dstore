import 'package:analyzer/dart/ast/ast.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';

class ActionsInfo {
  final String actions;
  final String httpMeta;
  final List<String> specialActions;

  ActionsInfo(
      {required this.actions,
      required this.httpMeta,
      required this.specialActions});
}

class HttpFieldInfo {
  final String name;
  final String fieldType;
  final String url;
  final String? headers;
  final String? inputType;
  final HttpInputType inputTypeEnum;
  final HttpResponseType responseTypeEnum;
  final String responseDeserializer;
  final String? inputSerializer;
  final String? responseSerializer;
  final String? inputDeserializer;
  final String? transformer;
  final String errorDeserializer;
  final String method;
  final String? queryParamsType;
  final String? graphqlQuery;
  final String responseType;

  HttpFieldInfo({
    required this.name,
    required this.url,
    this.headers,
    required this.fieldType,
    this.inputType,
    required this.inputTypeEnum,
    required this.responseType,
    required this.responseTypeEnum,
    required this.responseDeserializer,
    required this.errorDeserializer,
    this.responseSerializer,
    this.inputDeserializer,
    required this.method,
    this.inputSerializer,
    this.transformer,
    required this.queryParamsType,
    this.graphqlQuery,
  });
}

class WebSocketFieldInfo {
  final String url;
  final String name;
  final String? graphqlQuery;
  final String? inputSerializer;
  final String? responseDeserializer;
  final String? transformer;
  final String inputType;

  WebSocketFieldInfo(
      {required this.url,
      required this.name,
      this.graphqlQuery,
      this.transformer,
      required this.inputType,
      this.inputSerializer,
      this.responseDeserializer});
}

class StreamFieldInfo {
  final String outputType;
  final String name;

  StreamFieldInfo({required this.name, required this.outputType});
}

class PStateMethod {
  final String name;
  final List<Field> params;
  final String body;
  final bool isAsync;
  final String? url;
  final List<Field> keysModified;

  PStateMethod(
      {required this.isAsync,
      required this.name,
      required this.params,
      this.url,
      required this.keysModified,
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
