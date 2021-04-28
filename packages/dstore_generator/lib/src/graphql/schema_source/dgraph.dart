import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:dstore_dgraph/dgraph.dart';

String getDGraphFieldAnnotations({required FieldElement fe}) {
  return "";
}

hasInverse? getHasInverse(Element element) {
  final annot = element.annotationFromType(hasInverse)?.computeConstantValue();
  if (annot != null) {
    final field = annot.getField("field")?.toStringValue();
    return hasInverse(field!);
  }
}

search? getSearch(Element element) {
  final annot = element.annotationFromType(search)?.computeConstantValue();
  if (annot != null) {
    final field = annot.getField("by")?.toListValue();
  }
}
