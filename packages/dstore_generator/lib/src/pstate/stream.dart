import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dstore_generator/src/pstate/types.dart';

List<StreamFieldInfo> getStreamFields(List<FieldElement> fields) {
  final result = <StreamFieldInfo>[];
  fields.forEach((element) {
    final sfi = _getStreamFieldInfoForElement(element);
    if (sfi != null) {
      result.add(sfi);
    }
  });
  return result;
}

StreamFieldInfo? _getStreamFieldInfoForElement(FieldElement element) {
  final type = element.type;
  if (type.toString().startsWith("StreamField") && type is InterfaceType) {
    if (type.typeArguments.length != 1) {
      throw ArgumentError.value(
          "You should provide Stream response type as StreamField typeArg");
    }
    final dataTYpe = type.typeArguments.first.toString();
    return StreamFieldInfo(outputType: dataTYpe, name: element.name);
  }
  return null;
}

String convertStreamFieldInfoToAction(
    {required StreamFieldInfo sfi, required String type}) {
  final name = sfi.name;
  return """
   static Action $name({required Stream<${sfi.outputType}> stream }) {
     return Action(name:"$name",type:"$type",stream:stream);
   }
  """;
}
