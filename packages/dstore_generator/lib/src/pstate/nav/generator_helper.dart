import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_generator/src/errors.dart';
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

  final visitor = PStateAstVisitor(
      element: element,
      isPersitable: false,
      historyEnabled: false,
      isNav: true);
  final astNode = await AstUtils.getAstNodeFromElement(element, buildStep);
  astNode.visitChildren(visitor);
  return "";
}

Tuple2<String, String>? getUrlFromMethod(
    MethodDeclaration md, List<Field> mparams) {
  final urlInput = md.metadata
      .map((e) => e.toSource())
      .where((e) => e.startsWith("Url("))
      .map((e) => e.substring(e.indexOf("(") + 2, e.length - 2))
      .firstOrNull;
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
      return Tuple2(urlInput, finalUrl);
    }
  }
}
