import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_generator/src/errors.dart';
import 'package:dstore_generator/src/pstate/generator_helper.dart';
import 'package:dstore_generator/src/pstate/types.dart';
import 'package:dstore_generator/src/pstate/visitors.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:tuple/tuple.dart';

Future<String> generatePStateNavForClassElement(
    ClassElement element, BuildStep buildStep) async {
  if (!_isNavPState(element)) {
    throw InvalidSignatureError(
        "PState ${element.name} should extend NavStateI / NavStateStackI / NestedNavStateI / NestedNavStateStackI");
  }

  final typeParamsTuple =
      AstUtils.getTypeParamsAndBounds(element.typeParameters);
  final typeParamsWithBounds = typeParamsTuple.item2;
  final typeParams = typeParamsTuple.item1;
  final name = element.name.substring(2);

  final visitor = PStateAstVisitor(
      element: element,
      isPersitable: false,
      historyEnabled: false,
      isNav: true);
  final astNode = await AstUtils.getAstNodeFromElement(element, buildStep);
  astNode.visitChildren(visitor);
  final methods = visitor.methods.where((m) => m.name != "buildPages").toList();
  var fields = visitor.fields;
  fields.addAll(methods.where((m) => m.isAsync).map((m) => Field(
      name: m.name,
      type: "AsyncActionField",
      value: "AsyncActionField()",
      param: null)));
  fields = ModelUtils.processFields(fields);
  final psDeps = visitor.psDeps;

  final buildPages =
      visitor.methods.where((m) => m.name == "buildPages").firstOrNull?.body;
  final typePath = getFullTypeName(element);
  final typeVariable = "_${name}_FullPath";
  final pStateMeta = getPStateMeta(
      modelName: name,
      fields: fields,
      psDeps: psDeps,
      type: typeVariable,
      enableHistory: false,
      actionsMeta: {},
      isNav: true,
      isPersiable: false,
      historyLimit: null,
      navStaticMeta: _getNavStaticMeta(methods: methods, modelName: name),
      navDynamicMeta: _getNavDynamicMeta(methods: methods, modelName: name),
      httpMeta: "",
      methods: methods);
  return """
    
    ${_createPStateNavModel(fields: fields, psDeps: psDeps, name: name, annotations: [], buildPages: buildPages ?? "", typeParams: typeParams, enableHistory: false, typaParamsWithBounds: typeParamsWithBounds)}
    const $typeVariable = "$typePath";
    $pStateMeta
    ${_createActions(modelName: name, type: typeVariable, methods: methods)}
  """;
}

bool _isNavPState(ClassElement element) {
  final isNavInterfaceImplemented =
      AstUtils.isSubTypeof(element.thisType, "NavStateI");

  final isNestedNavInterfaceImplemented =
      AstUtils.isSubTypeof(element.thisType, "NestedNavStateI");

  return isNavInterfaceImplemented != null ||
      isNestedNavInterfaceImplemented != null;
}

String _getNavStaticMeta(
    {required List<PStateMethod> methods, required String modelName}) {
  final m =
      methods.where((m) => m.url != null && !m.url!.contains(":")).map((e) {
    final name = e.params
        .singleWhereOrNull((p) => p.type.startsWith("Map<String,String>"))
        ?.name;

    final params = name != null ? "$name : uri.queryParameters" : "";
    return "'${e.url}' : (Uri uri,Dispatch dispatch) { return dispatch(${modelName}Actions.${e.name}($params));}";
  }).join(", ");
  return "{$m}";
}

String _getNavDynamicMeta(
    {required List<PStateMethod> methods, required String modelName}) {
  final m =
      methods.where((m) => m.url != null && m.url!.contains(":")).map((e) {
    final parameters = <String>[];
    pathToRegExp('${e.url}', parameters: parameters);
    final params = <String>[];
    e.params.forEach((p) {
      final name = p.name;
      if (parameters.contains(p)) {
        // path param
        if (p.type == "num") {
          params.add("$name: num.parse(params['$name']) ");
        } else if (p.type == "int") {
          params.add("$name: int.parse(params['$name']) ");
        } else if (p.type == "double") {
          params.add("$name: double.parse(params['$name']) ");
        } else if (p.type == "String") {
          params.add("$name : params['$name']");
        } else {
          throw InvalidSignatureError(
              "in method '${e.name} , path param '${name}' type can be one of String/int/double/num , but you specified ${p.type}");
        }
      } else if (p.type.startsWith("Map<String,String>")) {
        // query params
        params.add("$name: uri.queryParameters");
      }
    });
    return """'${e.url}' : 
    (Uri uri,Dispatch dispatch) { 
      final path = uri.path;
      final parameters = <String>[];
      final regExp = pathToRegExp('${e.url}', parameters: parameters);
      final match = regExp.matchAsPrefix(path);
      final params = extract(parameters, match);
      return dispatch(${modelName}Actions.${e.name}(${params.join(", ")}));
    }""";
  }).join(", ");
  return "{$m}";
}

String _createPStateNavModel(
    {required List<Field> fields,
    required List<Field> psDeps,
    required String name,
    required List<String> annotations,
    required String buildPages,
    required String typeParams,
    required bool enableHistory,
    required String typaParamsWithBounds}) {
  final psFeilds = psDeps
      .map((e) =>
          " ${e.type} get ${e.name} => dont_touch_me_store.state.${e.name} as ${e.type};")
      .join("\n");
  final mixins = <String>["PStateStoreDepsMixin"];

  final result = """
      
      ${annotations.join("\n")}
      class ${name} extends NavStateI<$name> with ${mixins.join(", ")} {
  
        ${ModelUtils.getFinalFieldsFromFieldsList(fields)}
        $psFeilds
        $buildPages
        ${ModelUtils.getCopyWithField(name)}
        ${ModelUtils.createConstructorFromFieldsList(name, fields, addConst: false)}

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

String _createActions(
    {required String modelName,
    required String type,
    required List<PStateMethod> methods}) {
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
    final params = paramsList.join(", ");

    var payload = m.params.isNotEmpty
        ? "<String,dynamic>{ " +
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
  return """
    
    abstract class ${modelName}Actions {
      $methodActions
    }
  
  """;
}

Tuple2<String, String>? getUrlFromMethod(
    MethodDeclaration md, List<Field> mparams) {
  final urlInput = md.metadata
      .map((e) => e.toSource())
      .where((e) => e.startsWith("@Url("))
      .map((e) => e.substring(e.indexOf("(") + 2, e.length - 2))
      .firstOrNull;
  logger.shout("Url Input $urlInput");
  var errorMessage = "";
  if (urlInput != null) {
    var finalUrl = urlInput;
    if (urlInput.contains(":")) {
      // dynamic url
      final parameters = <String>[];
      pathToRegExp(urlInput, parameters: parameters);
      final mp = mparams.map((e) => e.name).toSet();
      if (!mp.containsAll(parameters)) {
        throw InvalidSignatureError(
            "you defined dynamic url $urlInput with params $parameters but they are not defined in method ${md.name} params");
      }
      finalUrl = parse(urlInput)
          .map((e) =>
              e is PathToken ? e.value : "\$${(e as ParameterToken).name}")
          .join("");
      if (mparams.length != parameters.length) {
        errorMessage =
            "apart from path params  $parameters action method ${md.name} can have only two extra params at most, param1 of type Map<String,String> that is to specify query params, param2 of type HistoryUpdate? to indicate history whether to push or replace url in history";
        finalUrl =
            _validateQueryParamsAndHistoryUpdateAndUpdateUrlWithQueryParams(
                params: mparams, message: errorMessage, url: finalUrl);
      }
    } else {
      // static url
      errorMessage =
          "static url action method ${md.name} should have only two params at most, param1 of type Map<String,String> that is to specify query params, param2 of type HistoryUpdate? to indicate history whether to push or replace url in history";
      finalUrl =
          _validateQueryParamsAndHistoryUpdateAndUpdateUrlWithQueryParams(
              params: mparams, message: errorMessage, url: urlInput);
    }
    return Tuple2(urlInput, finalUrl);
  }
}

String _validateQueryParamsAndHistoryUpdateAndUpdateUrlWithQueryParams(
    {required List<Field> params,
    required String message,
    required String url}) {
  final qp = "Map<String,String>";
  final hu = "HistoryUpdate?";
  var result = url;
  bool isAllowedType(String type) => type.startsWith(qp) || type.startsWith(hu);
  if (params.length > 2) {
    throw InvalidSignatureError(message);
  }
  if (params.length == 2) {
    final fp = params.first;
    final sp = params.last;
    if (!isAllowedType(fp.type) || !isAllowedType(sp.type)) {
      throw InvalidSignatureError(message);
    }
    var name = "";
    if (fp.type.startsWith(qp)) {
      name = fp.name;
    }
    if (sp.type.startsWith(hu)) {
      name = sp.name;
    }
    result = "$url?\${Uri(queryParameters: \${${name}})}";
  }
  if (params.length == 1) {
    final p = params.first;
    if (!isAllowedType(p.type)) {
      throw InvalidSignatureError(message);
    }
    if (p.type.startsWith(qp)) {
      result = "$url?\${Uri(queryParameters: \${${p.name}})}";
    }
  }

  return result;
}

// String _convertMapToQueryParams(Map<String,String> map) {
//   Uri(queryParameters: )
// }
