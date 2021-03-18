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
import "dart:convert";

String generatePStateForClassElement(ClassElement element) {
  final typeParamsWithBounds =
      element.typeParameters.map((e) => e.toString()).join(",");
  final typeParams = element.typeParameters.map((e) => e.name).join(",");
  final modelName = element.name.substring(1);
  final pstate = element.getPState();
  final isPerssit = isPersitable(pstate);
  final visitor = PStateAstVisitor(
      element: element,
      isPersitable: isPerssit,
      historyEnabled: pstate.enableHistory,
      historyLimit: pstate.historyLimit);
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

  final type = _getTypeName(element);
  final actionsInfo = _getActionsInfo(
    element: element,
    visitor: visitor,
    modelName: modelName,
    enableHistory: pstate.enableHistory,
    type: type,
  );
  final actionsmeta =
      _getActionsmeta(visitor.methods, actionsInfo.specialActions);
  final actions = actionsInfo.actions;
  final pstateMeta = _getPStateMeta(
      modelName: modelName,
      fields: fields,
      methods: methods,
      actionsMeta: actionsmeta,
      httpMeta: actionsInfo.httpMeta,
      type: type,
      isPersiable: isPerssit,
      historyLimit: pstate.historyLimit,
      enableHistory: pstate.enableHistory);

  final annotations = <String>[];
  if (isPerssit) {
    annotations.add("@JsonSerializable()");
  }
  final result = """
       ${_createPStateModel(fields: fields, name: modelName, annotations: annotations, typaParamsWithBounds: typeParamsWithBounds, typeParams: typeParams, enableHistory: pstate.enableHistory)}
       ${actions}
        ${pstateMeta}
    """;
  return result;
}

Map<String, List<String>> _getActionsmeta(
    List<PStateMethod> methods, List<String> specialActions) {
  final map = <String, List<String>>{};
  map.addEntries(methods.map(
      (e) => MapEntry(e.name, e.keysModified.map((e) => e.name).toList())));
  map.addEntries(specialActions.map((e) => MapEntry(e, [e])));
  return map;
}

String _getTypeName(ClassElement element) {
  var path = element.source.fullName.replaceAll(".dart", "");
  if (path.contains("/src/")) {
    path = path.substring(path.indexOf("/src/") + 4);
  } else if (path.contains("/lib/")) {
    path = path.substring(path.indexOf("/lib/") + 4);
  }
  return "$path/${element.name.substring(1)}";
}

String _getPStateMeta(
    {required String modelName,
    required List<Field> fields,
    required String type,
    required bool enableHistory,
    required Map<String, List<String>> actionsMeta,
    required bool isPersiable,
    required int? historyLimit,
    required String httpMeta,
    required List<PStateMethod> methods}) {
  final syncReducerFunctionStr =
      _createReducerFunctionSync(methods.where((m) => !m.isAsync), modelName);
  final asyncReducerFubctionStr =
      _createReducerFunctionAsync(methods.where((m) => m.isAsync), modelName);
  print(fields);

  var defaultState =
      "${modelName}(${fields.map((f) => "${f.name}:${f.type.startsWith("FormField") ? _addActionNameAndGroupNameToFormField(value: f.value!, actionName: f.name, type: modelName) : f.value}").join(", ")})";
  var defaultStateFn = "$modelName ${modelName}_DS() => $defaultState;";
  final params = <String>["type : \"$type\""];
  if (syncReducerFunctionStr.isNotEmpty) {
    params.add("reducer: ${modelName}_SyncReducer");
  }
  if (asyncReducerFubctionStr.isNotEmpty) {
    params.add("aReducer: ${modelName}_AsyncReducer");
  }
  params.add("ds: ${modelName}_DS");
  if (httpMeta.isNotEmpty) {
    params.add("httpMetaMap: $httpMeta");
  }
  if (isPersiable) {
    final smParams = <String>[];
    smParams.add("serializer: _\$${modelName}ToJson");
    smParams.add("deserializer: _\$${modelName}FromJson");
    params.add(
        "sm: PStateStorageMeta<$modelName,Map<String,dynamic>>(${smParams.join(", ")})");
  }
  if (enableHistory) {
    params.add("enableHistory: true");
    params.add("actionsMeta: ${jsonEncode(actionsMeta)}");
    defaultStateFn = """
      $modelName ${modelName}_DS() {
        final state = $defaultState;
        state.internalPSHistory = PStateHistory<$modelName>($historyLimit);
        return history;
      }
    """;
  }

  return """
       $syncReducerFunctionStr
       $asyncReducerFubctionStr
       
       $defaultStateFn

       final ${modelName}Meta = PStateMeta<${modelName}>(${params.join(", ")});
    """;
}

ActionsInfo _getActionsInfo(
    {required ClassElement element,
    required PStateAstVisitor visitor,
    required String modelName,
    required bool enableHistory,
    required String type}) {
  final specialActions = <String>[];
  final httpFields = getHttpFields(element.fields);
  specialActions.addAll(httpFields.map((e) => e.name));
  final streamFields = getStreamFields(element.fields);
  specialActions.addAll(streamFields.map((e) => e.name));
  final websocketFields = getWebSocketFields(element.fields);
  specialActions.addAll(websocketFields.map((e) => e.name));
  final formFields = visitor.fields
      .where((f) => f.type.toString().startsWith("FormField"))
      .toList();
  final actions = _generateActionsCreators(
      methods: visitor.methods,
      modelName: modelName,
      type: type,
      streamFields: streamFields,
      websocketFields: websocketFields,
      formFields: formFields,
      httpFields: httpFields);
  var httpMeta = httpFields.map((h) {
    final key = h.name;
    final params = <String>[];
    if (h.inputSerializer != null) {
      params.add("inputSerializer: ${h.inputSerializer}");
    }
    if (h.inputDeserializer != null) {
      params.add("inputDeserializer: ${h.inputDeserializer}");
    }
    if (h.responseSerializer != null) {
      params.add("responseSerializer: ${h.responseSerializer}");
    }
    params.add("responseDeserializer: ${h.responseDeserializer}");
    final value = "HttpMeta(${params.join(", ")})";

    return """ "$key" : $value """;
  }).join(", ");
  if (httpMeta.isNotEmpty) {
    httpMeta = "{$httpMeta}";
  }

  return ActionsInfo(
      actions: actions, httpMeta: httpMeta, specialActions: specialActions);
}

extension PStateExtension on ClassElement {
  PState getPState() {
    final annot = annotationFromType(PState)!;
    final reader = ConstantReader(annot.computeConstantValue());
    final persit = reader.peek("persit")?.boolValue;
    final enableHistory = reader.peek("enableHistory")?.boolValue;
    final historyLimit = reader.peek("historyLimit")?.intValue;
    return PState(
        persist: persit,
        enableHistory: enableHistory ?? false,
        historyLimit: historyLimit);
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
  final mockModels = <String>[];
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
    final mockName = getMockModelName(modelName: modelName, name: m.name);
    mockModels.add(_createMockModel(name: mockName, fields: m.keysModified));
    paramsList.add("$mockName? mock");
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
         return Action(name:"${m.name}",type:"${type}" ${payload},mock:mock,isAsync: ${m.isAsync}${m.isAsync ? ", debounce: debounce" : ""});
      }
    """;
  }).join("\n");
  final httpActions = httpFields
      .map((hf) => convertHttpFieldInfoToAction(
          hf: hf, type: type, modelName: modelName))
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
     return Action(name:"$ff.name}",type:"${type}",form:req);
   }
   """;
  }).join("\n");

  return """
      ${mockModels.join("\n")}

     abstract class ${modelName}Actions {
         ${methodActions}
         ${httpActions}
         ${formActions}
         ${streamActions}
         ${websocketActions}
     }
  """;
}

String getMockModelName({required String modelName, required String name}) {
  return "$modelName${name.cpatialize}Mock";
}

String _createMockModel({required String name, required List<Field> fields}) {
  final finalFields = fields.map((e) {
    final type = e.type.endsWith("?") ? "Optional<${e.type}>" : "${e.type}?";
    return "final $type ${e.name};";
  }).join("\n ");
  final ctorParams = fields.map((e) {
    return e.type.endsWith("?")
        ? "this.${e.name} = optionalDefault"
        : "this.${e.name}";
  }).join(", ");
  final toMapStatements = fields.map((e) {
    if (e.type.endsWith("?")) {
      return """
        if(${e.name} != optionalDefault) {
          map["${e.name}"] = ${e.name}.value;
        }
      """;
    } else {
      return """
        if(${e.name} != null) {
          map["${e.name}"] = ${e.name};
        }      
      """;
    }
  }).join("\n");
  return """
    class $name implements ToMap {
     
     $finalFields

     const ${name}({$ctorParams});

     Map<String,dynamic> toMap() {
       final map = <String,dynamic>{};
        $toMapStatements
       return map;
     }
    }
  
  """;
}

String _createPStateModel(
    {required List<Field> fields,
    required String name,
    required List<String> annotations,
    required String typeParams,
    required bool enableHistory,
    required String typaParamsWithBounds}) {
  final isJson = annotations.singleWhereOrNull(
          (element) => element.startsWith("@JsonSerializable")) !=
      null;
  final historyField = enableHistory
      ? """
      set internalPSHistory(PStateHistory<$name> value) {
        _psHistory = value;
      }
     """
      : "";
  final mixins = <String>[];
  if (enableHistory) {
    mixins.add("PStateHistoryMixin<$name>");
  }
  final m = mixins.isNotEmpty ? "with ${mixins.join(", ")}" : "";

  final result = """
      
      @immutable
      ${annotations.join("\n")}
      class ${name} implements PStateModel<$name> $m {
        $historyField
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
