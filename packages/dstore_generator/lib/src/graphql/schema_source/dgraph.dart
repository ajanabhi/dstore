import 'dart:convert';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:dstore_dgraph/dgraph.dart';

String getDGraphFieldAnnotations({required FieldElement element}) {
  final annotations = <String>[];
  final hasI = getHasInverseDirective(element);
  if (hasI != null) {
    annotations.add("hasInverse(field: ${hasI.field})");
  }
  final searchD = getSearchDirective(element);
  if (searchD != null) {
    final by = searchD.by != null
        ? "(by: [${searchD.by!.map((e) => e.toString().split(".").last).join(", ")}])"
        : "";
    annotations.add("search$by");
  }
  final dgraphD = getDGraphDirective(element);
  if (dgraphD != null) {
    final params = <String>[];
    if (dgraphD.type != null) {
      params.add("type: \"${dgraphD.type}\"");
    }
    if (dgraphD.pred != null) {
      params.add("pred: \"${dgraphD.pred}\"");
    }
    annotations.add("@dgraph(${params.join(", ")})");
  }
  final idD = getIdDirective(element);
  if (idD != null) {
    annotations.add("@id");
  }
  final customD = getCustomDirective(element);
  if (customD != null) {
    final params = <String>[];
    if (customD.dql != null) {
      params.add("dql: ${customD.dql}");
    }
    if (customD.http != null) {
      final http = customD.http!;
      final cParams = <String>[];
      cParams.add("url: \"${http.url}\"");
      cParams.add("method: ${http.method.toString().split(".").last}");
      if (http.introspectionHeaders != null) {
        cParams.add(
            "introspectionHeaders: ${jsonEncode(http.introspectionHeaders)}");
      }
      if (http.secretHeaders != null) {
        cParams.add("secretHeaders: ${jsonEncode(http.secretHeaders)}");
      }
      if (http.forwardHeaders != null) {
        cParams.add("forwardHeaders: ${jsonEncode(http.forwardHeaders)}");
      }
      if (http.graphql != null) {
        cParams.add("graphql: \"\"\"${http.graphql}\"\"\"");
      }

      if (http.skipIntrospection != null) {
        cParams.add("skipIntrospection: ${http.skipIntrospection}");
      }

      if (http.mode != null) {
        cParams.add("mode: ${http.mode.toString().split(".").last}");
      }

      params.add("http: {${cParams.join(", ")}}");
    }
    annotations.add("@custom(${params.join(", ")})");
  }
  return annotations.join(" ");
}

hasInverse? getHasInverseDirective(Element element) {
  final annot = element.annotationFromType(hasInverse)?.computeConstantValue();
  if (annot != null) {
    final field = annot.getField("field")?.toStringValue();
    return hasInverse(field!);
  }
}

search? getSearchDirective(Element element) {
  final annot = element.annotationFromType(search)?.computeConstantValue();
  if (annot != null) {
    final field = annot
        .getField("by")
        ?.toListValue()
        ?.map((e) => e.getEnumValue(DgraphIndex.values)!)
        .toList();
    return search(field);
  }
}

dgraph? getDGraphDirective(Element element) {
  final annot = element.annotationFromType(dgraph)?.computeConstantValue();
  if (annot != null) {
    final type = annot.getField("type")?.toStringValue();
    final pred = annot.getField("pred")?.toStringValue();
    return dgraph(type: type, pred: pred);
  }
}

id? getIdDirective(Element element) {
  final annot = element.annotationFromType(id)?.computeConstantValue();
  if (annot != null) {
    return id();
  }
}

custom? getCustomDirective(Element element) {
  final annot = element.annotationFromType(id)?.computeConstantValue();
  if (annot != null) {
    final http = getCustomHttp(annot.getField("http"));
    final dql = annot.getField("dql")?.toStringValue();
    return custom(http: http, dql: dql);
  }
}

cascade? getCascadeDirective(Element element) {
  final annot = element.annotationFromType(cascade)?.computeConstantValue();
  if (annot != null) {
    final fields = annot
        .getField("fields")
        ?.toListValue()
        ?.map((e) => e.toStringValue()!)
        .toList();
    return cascade(fields);
  }
}

lambda? getLambdaDirective(Element element) {
  final annot = element.annotationFromType(cascade)?.computeConstantValue();
  if (annot != null) {
    return lambda();
  }
}

CustomHTTP? getCustomHttp(DartObject? obj) {
  if (obj != null) {
    final url = obj.getField("url")?.toStringValue();
    final method = obj.getEnumField("method", HTTPMethod.values);
    final mode = obj.getEnumField("mode", Mode.values);
    final body = obj.getField("body")?.toStringValue();
    final graphql = obj.getField("graphql")?.toStringValue();
    final skipIntrospection = obj.getField("skipIntrospection")?.toBoolValue();
    final forwardHeaders = obj
        .getField("forwardHeaders")
        ?.toListValue()
        ?.map((e) => e.toStringValue()!)
        .toList();

    final introspectionHeaders = obj
        .getField("introspectionHeaders")
        ?.toListValue()
        ?.map((e) => e.toStringValue()!)
        .toList();
    return CustomHTTP(
        url: url!,
        method: method!,
        mode: mode,
        body: body,
        graphql: graphql,
        forwardHeaders: forwardHeaders,
        skipIntrospection: skipIntrospection,
        introspectionHeaders: introspectionHeaders);
  }
}
