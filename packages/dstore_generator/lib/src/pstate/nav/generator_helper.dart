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
  final isNavInterfaceImplemented =
      AstUtils.isSubTypeof(element.thisType, "NavStateI");
  if (isNavInterfaceImplemented == null) {
    throw InvalidSignatureError(
        "NavState ${element.name} should implement NavigationI interface");
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
  fields = processFields(fields);
  final psDeps = visitor.psDeps;

  final buildPages =
      visitor.methods.where((m) => m.name == "buildPages").first.body;
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
      httpMeta: "",
      methods: methods);
  return """
    
    ${_createPStateNavModel(fields: fields, psDeps: psDeps, name: name, annotations: [], buildPages: buildPages, typeParams: typeParams, enableHistory: false, typaParamsWithBounds: typeParamsWithBounds)}
    const $typeVariable = "$typePath";
    $pStateMeta
    ${_createActions(modelName: name, type: typeVariable, methods: methods)}
  """;
}

String _getNavStaticMeta(
    {required List<PStateMethod> methods, required String modelName}) {
  final m =
      methods.where((m) => m.url != null && !m.url!.contains(":")).map((e) {
    return "'${e.url}' : (Uri uri) { return state.dontTouchMeStore.dispatch(${modelName}Actions.${e.name}());}";
  }).join(", ");
  return "{$m}";
}

String _getStaticUrlMeta(
    {required List<PStateMethod> methods, required String modelName}) {
  final items = methods
      .where((element) => element.url != null && !element.url!.contains(":"))
      .map((e) {
    final Uri uri;

    final fn = """
         (Uri uri) {
           retutn ${modelName}Action.${e.name}();
         }
        """;
    return '"${e.url}":';
  }).join(",");
  return "{$items}";
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
  if (urlInput != null) {
    var finalUrl = urlInput;
    if (urlInput.contains(":")) {
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
    }
    return Tuple2(urlInput, finalUrl);
  }
}
