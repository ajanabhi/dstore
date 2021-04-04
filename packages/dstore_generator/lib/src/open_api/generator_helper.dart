import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:open_api_forked/v3.dart';
import 'package:yaml/yaml.dart';

String createOpenApi(
    {required ClassElement element, required BuildStep buildStep}) {
  final opneApi = _getOpenApiAnnotation(element);
  final file = opneApi.file;
  final doc = getDocumentFromFile(file);
  print(doc);
  return """""";
}

APIDocument getDocumentFromFile(String file) {
  final content = File(file).readAsStringSync();
  Map<String, dynamic> map;
  if (file.endsWith(".json")) {
    map = jsonDecode(content) as Map<String, dynamic>;
  } else {
    final v = (loadYaml(content) as YamlMap).value;
    print(v.runtimeType);
    final dynamic yaml = loadYaml(content);
    map = jsonDecode(jsonEncode(yaml)) as Map<String, dynamic>;
    // map = map.cast<String,dya>()
    // map = (loadYaml(content) as YamlMap)
    //         .nodes
    //         .map((dynamic key, value) => MapEntry(key.toString(), value))
    //     as Map<String, dynamic>;
  }
  return APIDocument.fromMap(
      Map<String, dynamic>.from(map.cast<String, dynamic>()));
}

OpenApi _getOpenApiAnnotation(ClassElement element) {
  final a = element.annotationFromType(OpenApi)!;
  final dt = a.computeConstantValue();
  if (dt == null) {
    throw ArgumentError(
        "Looks like you passed invalid values to OpenApi annotation");
  }
  final file = dt.getField("file")!.toStringValue()!;
  return OpenApi(file);
}
