import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_generator/src/pstate/constants.dart';
import 'package:dstore_generator/src/pstate/http.dart';
import 'package:dstore_generator/src/pstate/types.dart';
import 'package:dstore_generator/src/pstate/visitors.dart';
import 'package:dstore_generator/src/utils/utils.dart';

String generatePStateForClassElement(ClassElement element) {
  final typeParamsWithBounds =
      element.typeParameters.map((e) => e.toString()).join(",");
  final typeParams = element.typeParameters.map((e) => e.name).join(",");
  // final persist = _getPersistValue(element);
  final modelName = element.name.substring(1);
  final visitor = PStateAstVisitor();
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
  final syncReducerFunctionStr =
      _createReducerFunctionSync(methods.where((m) => !m.isAsync), modelName);
  final asyncReducerFubctionStr =
      _createReducerFunctionAsync(methods.where((m) => m.isAsync), modelName);
  print(fields);
  final defaultState =
      "${modelName}(${fields.map((f) => "${f.name}:${f.type.startsWith("FormField") ? _addActionNameAndGroupNameToFormField(value: f.value!, actionName: f.name, type: modelName) : f.value}").join(", ")})";
  final reducerGroup = """
       $syncReducerFunctionStr
       $asyncReducerFubctionStr
       $modelName ${modelName}_DS() => $defaultState;
       
       const ${modelName}Meta = PStateMeta<${modelName}>(type:$modelName,
        reducer: ${syncReducerFunctionStr.isNotEmpty ? "${modelName}_SyncReducer" : "null"} ,
        aReducer: ${asyncReducerFubctionStr.isNotEmpty ? "${modelName}_AsyncReducer" : "null"} ,
        ds: ${modelName}_DS);
    """;
  final httpFields = getHttpFields(element.fields);
  print("httpFields $httpFields");
  final formFields = fields.where((f) => f.type.startsWith("FomField"));
  final actions = _generateActionsCreators(
      methods: visitor.methods,
      modelName: modelName,
      type: modelName,
      formFields: formFields,
      httpFields: httpFields);

  final result = """
       // class Name : ${element.name}

       ${_createPStateModel(fields: fields, name: modelName, typaParamsWithBounds: typeParamsWithBounds, typeParams: typeParams)}
       ${actions}
        ${reducerGroup}
    """;
  return result;
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
    {required String value, required String actionName, required String type}) {
  return "${value.substring(0, value.lastIndexOf(")"))},internalAName: \"$actionName\",internalAType:$type)";
}

String _generateActionsCreators({
  required List<PStateMethod> methods,
  List<HttpFieldInfo> httpFields = const [],
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
        return Action(name:"${hf.name}",type:${type},http:HttpPayload(${payloadFields.join(", ")}),debounce:debounce);
      }
    """;
  }).join("\n");

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
     }
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
