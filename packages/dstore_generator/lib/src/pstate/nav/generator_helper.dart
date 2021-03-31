import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_generator/src/errors.dart';
import 'package:dstore_generator/src/pstate/visitors.dart';
import 'package:dstore_generator/src/utils/utils.dart';

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
