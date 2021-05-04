import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dio/dio.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:dstore_dgraph/dgraph.dart';

String getDGraphFieldAnnotations({required FieldElement element}) {
  final annotations = <String>[];
  final hasI = getHasInverseDirective(element);
  if (hasI != null) {
    annotations.add(hasI.toString());
  }
  final searchD = getSearchDirective(element);
  if (searchD != null) {
    annotations.add(searchD.toString());
  }
  final dgraphD = getDGraphDirective(element);
  if (dgraphD != null) {
    annotations.add(dgraphD.toString());
  }
  final idD = getIdDirective(element);
  if (idD != null) {
    annotations.add(idD.toString());
  }
  final customD = getCustomDirective(element);
  if (customD != null) {
    annotations.add(customD.toString());
  }
  final lambdaD = getLambdaDirective(element);
  if (lambdaD != null) {
    annotations.add(lambdaD.toString());
  }
  return annotations.join(" ");
}

String getDGraphObjectAnnotations({required ClassElement element}) {
  final annotations = <String>[];
  final remoteD = getRemoteDirective(element);
  if (remoteD != null) {
    annotations.add(remoteD.toString());
  }
  final dgraphD = getDGraphDirective(element);
  if (dgraphD != null) {
    annotations.add(dgraphD.toString());
  }
  final withSubscriptionD = getWithSubscriptionDirective(element);
  if (withSubscriptionD != null) {
    annotations.add(withSubscriptionD.toString());
  }
  final secretD = getSecretDirective(element);
  if (secretD != null) {
    annotations.add(secretD.toString());
  }
  final authD = getAuthDirective(element);
  if (authD != null) {
    annotations.add(authD.toString());
  }
  final generateD = getGenerateDirective(element);
  if (generateD != null) {
    annotations.add(generateD.toString());
  }
  return annotations.join(" ");
}

String getDGraphInterfaceAnnotations({required ClassElement element}) {
  final annotations = <String>[];
  final remoteD = getRemoteDirective(element);
  if (remoteD != null) {
    annotations.add(remoteD.toString());
  }
  final dgraphD = getDGraphDirective(element);
  if (dgraphD != null) {
    annotations.add(dgraphD.toString());
  }

  final withSubscriptionD = getWithSubscriptionDirective(element);
  if (withSubscriptionD != null) {
    annotations.add(withSubscriptionD.toString());
  }

  final secretD = getSecretDirective(element);
  if (secretD != null) {
    annotations.add(secretD.toString());
  }

  final generateD = getGenerateDirective(element);
  if (generateD != null) {
    annotations.add(generateD.toString());
  }

  return annotations.join(" ");
}

String getDGraphInputAnnotations({required ClassElement element}) {
  final annotations = <String>[];
  final remoteD = getRemoteDirective(element);
  if (remoteD != null) {
    annotations.add(remoteD.toString());
  }
  return annotations.join(" ");
}

String getDGraphEnumAnnotations({required ClassElement element}) {
  final annotations = <String>[];
  final remoteD = getRemoteDirective(element);
  if (remoteD != null) {
    annotations.add(remoteD.toString());
  }
  return annotations.join(" ");
}

String getDGraphUnionAnnotations({required ClassElement element}) {
  final annotations = <String>[];
  final remoteD = getRemoteDirective(element);
  if (remoteD != null) {
    annotations.add(remoteD.toString());
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

withSubscription? getWithSubscriptionDirective(Element element) {
  final annot =
      element.annotationFromType(withSubscription)?.computeConstantValue();
  if (annot != null) {
    return withSubscription();
  }
}

secret? getSecretDirective(Element element) {
  final annot = element.annotationFromType(secret)?.computeConstantValue();
  if (annot != null) {
    final field = annot.getField("field")?.toStringValue();
    final pred = annot.getField("pred")?.toStringValue();

    return secret(field: field!, pred: pred);
  }
}

auth? getAuthDirective(Element element) {
  final annot = element.annotationFromType(auth)?.computeConstantValue();
  if (annot != null) {
    final query = getAuthRuleFromObject(annot.getField("query"));
    final add = getAuthRuleFromObject(annot.getField("add"));
    final update = getAuthRuleFromObject(annot.getField("update"));
    final delete = getAuthRuleFromObject(annot.getField("delete"));
    return auth(query: query, add: add, update: update, delete: delete);
  }
}

GenerateQueryParams? getGenerateQueryParamsFromDartObject(DartObject? obj) {
  if (obj != null) {
    final get = obj.getField("get")?.toBoolValue();
    final query = obj.getField("query")?.toBoolValue();
    final password = obj.getField("password")?.toBoolValue();
    final aggregate = obj.getField("aggregate")?.toBoolValue();
    return GenerateQueryParams(
        get: get, query: query, password: password, aggregate: aggregate);
  }
}

GenerateMutationParams? getGenerateMutationParamsFromDartObject(
    DartObject? obj) {
  if (obj != null) {
    final add = obj.getField("add")?.toBoolValue();
    final update = obj.getField("update")?.toBoolValue();
    final delete = obj.getField("delete")?.toBoolValue();
    return GenerateMutationParams(add: add, update: update, delete: delete);
  }
}

generate? getGenerateDirective(Element element) {
  final annot = element.annotationFromType(auth)?.computeConstantValue();
  if (annot != null) {
    final query = getGenerateQueryParamsFromDartObject(annot.getField("query"));
    final mutation =
        getGenerateMutationParamsFromDartObject(annot.getField("mutation"));
    final subscription = annot.getField("subscription")?.toBoolValue();
    return generate(
        query: query, mutation: mutation, subscription: subscription);
  }
}

AuthRule? getAuthRuleFromObject(DartObject? obj) {
  if (obj != null) {
    final rule = obj.getField("rule")?.toStringValue();
    final not = getAuthRuleFromObject(obj.getField("not"));
    final and = obj
        .getField("and")
        ?.toListValue()
        ?.map((e) => getAuthRuleFromObject(e)!)
        .toList();
    final or = obj
        .getField("or")
        ?.toListValue()
        ?.map((e) => getAuthRuleFromObject(e)!)
        .toList();
    return AuthRule(rule: rule, not: not, and: and, or: or);
  }
}

remote? getRemoteDirective(Element element) {
  final annot = element.annotationFromType(auth)?.computeConstantValue();
  if (annot != null) {
    return remote();
  }
}

Future<void> validateAndUploadDGraphSchema(
    {required GraphqlSchemaSource meta, required String schema}) async {
  final dio = Dio();
  final ud = meta.schemaUplodDetails!;
  final url = ud.url;
  final headers = ud.headers;
  final validateUrl = "$url/validate";
  try {
    final resp = await dio.post<String>(validateUrl,
        options: Options(headers: headers), data: schema);
    print("Validate Resp $resp");
  } catch (e) {
    rethrow;
  }
}