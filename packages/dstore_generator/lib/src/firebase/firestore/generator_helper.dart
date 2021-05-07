import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';

Future<String> generateFireStoreSchema(
    {required ClassElement element, required BuildStep buildStep}) async {
  var collectionModels = "";
  element.fields.forEach((f) {
    final name = f.name.toLowerCase();
    if (name == "collections") {
      collectionModels =
          getModelsFromCollections(element: f.type.element as ClassElement);
    }
  });

  return """
  
  """;
}

String getModelsFromCollections({required ClassElement element}) {
  return element.allSupertypes
      .where((e) => !e.isDartCoreObject)
      .map((e) => convertCollectionModelToDartModel(element: e.element))
      .join("\n");
}

String convertCollectionModelToDartModel({required ClassElement element}) {
  final fields = element.fields
      .where((f) =>
          f.type.element?.annotationFromType(collection) ==
          null) // subcollection are shallow
      .map((f) {
    final name = f.name;
    final type = f.type.toString();
    final annotations = <String>[];
    if (type.startsWith("DocumentReference<")) {
      annotations.add(value)
    }
    final isCollectionNestedObj =
        f.type.element?.annotationFromType(collectionNestedObject);
  });
  return "";
}

String getDslFromCollections({required ClassElement element}) {
  return "";
}
