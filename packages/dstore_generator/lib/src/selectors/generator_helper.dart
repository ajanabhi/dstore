import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_generator/src/selectors/types.dart';
import 'package:dstore_generator/src/selectors/vistors.dart';
import 'package:dstore_generator/src/utils/utils.dart';

final selectorDepsCache = <int, Map<String, SelectorDeps>>{};

SelectorDeps? getSelectorCachedDeps(Element element, String name) {
  final code = "${element.source?.fullName}${element.name}".hashCode;
  return selectorDepsCache[code]?[name];
}

void addSelectorCacheDeps(Element element, String name, SelectorDeps sdeps) {
  final code = "${element.source?.fullName}${element.name}".hashCode;
  final existinValue = selectorDepsCache[code];
  if (existinValue == null) {
    selectorDepsCache[code] = {name: sdeps};
  } else {
    existinValue[name] = sdeps;
  }
}

Future<String> generateSelectors(
    {required String modelName, required ClassElement element}) async {
  final visitor = SelectorsVisitor(modelName, element);
  final astNode = await AstUtils.getResolvedAstNodeFromElement(element);

  astNode.visitChildren(visitor);

  return """
       // Selector
       class ${modelName} {
         ${visitor.selectors.join("\n")}
       }
    """;
}
