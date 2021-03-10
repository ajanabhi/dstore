import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/pstate/constants.dart';
import 'package:dstore_generator/src/pstate/http.dart';
import 'package:dstore_generator/src/pstate/persitance.dart';
import 'package:dstore_generator/src/pstate/stream.dart';
import 'package:dstore_generator/src/pstate/types.dart';
import 'package:dstore_generator/src/pstate/visitors.dart';
import 'package:dstore_generator/src/pstate/websocket.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

String generatePStateForClassElement(ClassElement element) {
  final typeParamsWithBounds =
      element.typeParameters.map((e) => e.toString()).join(",");
  final typeParams = element.typeParameters.map((e) => e.name).join(",");
  final modelName = element.name.substring(1);
  final pstate = element.getPState();
  final isPerssit = isPersitable(pstate);
  final visitor = PStateAstVisitor(element, isPerssit);
  final astNode = AstUtils.getAstNodeFromElement(element);
  astNode.visitChildren(visitor);
  var fields = visitor.fields;
  final methods = visitor.methods;
  fields.addAll(methods.where((m) => m.isAsync).map((m) => Field(
      name: m.name,
      type: "AsyncActionField",
      value: "AsyncActionField()",
      param: null)));
  fields = processFields(fields);
  final actions =
      _getActions(element: element, visitor: visitor, modelName: modelName);
  final pstateMeta = _getPStateMeta(
      modelName: modelName,
      fields: fields,
      methods: methods,
      isPersiable: isPerssit);

  final annotations = <String>[];
  if (isPerssit) {
    annotations.add("@JsonSerializable()");
  }
  final result = """
       ${_createPStateModel(fields: fields, name: modelName, annotations: annotations, typaParamsWithBounds: typeParamsWithBounds, typeParams: typeParams)}
       ${actions}
        ${pstateMeta}
    """;
  return result;
}

String _getPStateMeta(
    {required String modelName,
    required List<Field> fields,
    required bool isPersiable,
    required List<PStateMethod> methods}) {
  final syncReducerFunctionStr =
      _createReducerFunctionSync(methods.where((m) => !m.isAsync), modelName);
  final asyncReducerFubctionStr =
      _createReducerFunctionAsync(methods.where((m) => m.isAsync), modelName);
  print(fields);

  final defaultState =
      "${modelName}(${fields.map((f) => "${f.name}:${f.type.startsWith("FormField") ? _addActionNameAndGroupNameToFormField(value: f.value!, actionName: f.name, type: modelName) : f.value}").join(", ")})";

  final params = <String>["type : $modelName"];
  if (syncReducerFunctionStr.isNotEmpty) {
    params.add("reducer: ${modelName}_SyncReducer");
  }
  if (asyncReducerFubctionStr.isNotEmpty) {
    params.add("aReducer: ${modelName}_AsyncReducer");
  }
  params.add("ds: ${modelName}_DS");

  if (isPersiable) {
    final smParams = <String>[];
    smParams.add("serializer: _\$${modelName}ToJson");
    smParams.add("deserializer: _\$${modelName}FromJson");
    params.add("sm: PStorageMeta<$modelName>(${smParams.join(", ")})");
  }

  return """
       $syncReducerFunctionStr
       $asyncReducerFubctionStr
       $modelName ${modelName}_DS() => $defaultState;
       
       const ${modelName}Meta = PStateMeta<${modelName}>(${params.join(", ")});
    """;
}

String _getActions(
    {required ClassElement element,
    required PStateAstVisitor visitor,
    required String modelName}) {
  final httpFields = getHttpFields(element.fields);
  final streamFields = getStreamFields(element.fields);
  final websocketFields = getWebSocketFields(element.fields);
  final formFields = visitor.fields
      .where((f) => f.type.toString().startsWith("FomField"))
      .toList();
  return _generateActionsCreators(
      methods: visitor.methods,
      modelName: modelName,
      type: modelName,
      streamFields: streamFields,
      websocketFields: websocketFields,
      formFields: formFields,
      httpFields: httpFields);
}

extension PStateExtension on ClassElement {
  PState getPState() {
    final annot = annotationFromType(PState)!;
    final reader = ConstantReader(annot.computeConstantValue());
    final persit = reader.peek("persit")?.boolValue;
    return PState(persist: persit);
  }
}

String _addActionNameAndGroupNameToFormField(
    {required String value, required String actionName, required String type}) {
  return "${value.substring(0, value.lastIndexOf(")"))},internalAName: \"$actionName\",internalAType:$type)";
}

String _generateActionsCreators({
  required List<PStateMethod> methods,
  List<HttpFieldInfo> httpFields = const [],
  List<StreamFieldInfo> streamFields = const [],
  List<WebSocketFieldInfo> websocketFields = const [],
  Iterable<Field> formFields = const [],
  required String modelName,
  required String type,
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
         return Action(name:"${m.name}",type:${type} ${payload},isAsync: ${m.isAsync}${m.isAsync ? ", debounce: debounce" : ""});
      }
    """;
  }).join("\n");
  final httpActions = httpFields
      .map((hf) => convertHttpFieldInfoToAction(hf: hf, type: type))
      .join("\n");

  final streamActions = streamFields
      .map((e) => convertStreamFieldInfoToAction(sfi: e, type: type))
      .join("\n");

  final websocketActions = websocketFields
      .map((e) => convertWebSocketFieldInfoToAction(wsi: e, type: type))
      .join("\n");

  final formActions = formFields.map((ff) {
    return """
   static ${ff.name}(FormReq req) {
     return Action(name:"$ff.name}",type:${type},form:req);
   }
   """;
  }).join("\n");

  return """
     abstract class ${modelName}Actions {
         ${methodActions}
         ${httpActions}
         ${formActions}
         ${streamActions}
         ${websocketActions}
     }
  """;
}

String _createPStateModel(
    {required List<Field> fields,
    required String name,
    required List<String> annotations,
    required String typeParams,
    required String typaParamsWithBounds}) {
  final isJson = annotations.singleWhereOrNull(
          (element) => element.startsWith("@JsonSerializable")) !=
      null;
  final result = """
      
      @immutable
      ${annotations.join("\n")}
      class ${name} implements PStateModel {
        ${ModelUtils.getFinalFieldsFromFieldsList(fields)}
        ${ModelUtils.getCopyWithField(name)}
        ${ModelUtils.createConstructorFromFieldsList(name, fields)}

        ${ModelUtils.createCopyWithMapFromFieldsList(name, fields)}

        ${ModelUtils.createToMapFromFieldsList(fields)}
        
        ${ModelUtils.createEqualsFromFieldsList(name, fields)}

        ${ModelUtils.createHashcodeFromFieldsList(fields)}

        ${ModelUtils.createToStringFromFieldsList(name, fields)}

        ${isJson ? ModelUtils.createFromJson(name) : ""}

        ${isJson ? ModelUtils.createToJson(name) : ""}
      }

      ${ModelUtils.createCopyWithClasses(name: name, typeParams: typeParams, typeParamsWithBounds: typaParamsWithBounds, fields: fields)}
   """;
  return result;
}

String _createReducerFunctionSync(
  Iterable<PStateMethod> methods,
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
  Iterable<PStateMethod> methods,
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
