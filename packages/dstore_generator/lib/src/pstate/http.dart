import 'package:analyzer/dart/element/element.dart';
import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/pstate/types.dart';
import 'package:dstore_generator/src/utils/utils.dart';
import 'package:source_gen/source_gen.dart';

List<HttpFieldInfo> getHttpFields(List<FieldElement> fields) {
  final result = <HttpFieldInfo>[];
  fields.forEach((f) {
    final hf = _getHttpFieldInfo(f);
    if (hf != null) {
      result.add(hf);
    }
  });
  return result;
}

HttpFieldInfo? _getHttpFieldInfo(FieldElement element) {
  final type = element.type;

  final ht = AstUtils.isSubTypeof(type, "HttpField");
  if (ht == null) {
    return null;
  }
  if (ht.typeArguments.length != 4) {
    throw ArgumentError.value(
        "You should specify all 4 generic types of HttpField");
  }
  String? queryParamsType = replaceEndStar(
      ht.typeArguments[0].getDisplayString(withNullability: true));
  print("queryParamsType $queryParamsType");
  if (queryParamsType == "Null") {
    queryParamsType = null;
  }
  String? inputType = replaceEndStar(
      ht.typeArguments[1].getDisplayString(withNullability: true));
  if (inputType == "Null") {
    inputType = null;
  }
  final responseType = replaceEndStar(
      ht.typeArguments[2].getDisplayString(withNullability: true));
  final errorType = replaceEndStar(
      ht.typeArguments[3].getDisplayString(withNullability: true));
  final anot = type.element?.annotationFromType(HttpRequest);
  if (anot == null) {
    throw ArgumentError.value(
        "You should anotate type ${type} with HttpRequest");
  }
  final reader = ConstantReader(anot.computeConstantValue());
  final url = reader.read("url").stringValue;
  final method = reader.read("method").stringValue;
  late HttpResponseType responseTypeEnum;
  final responseTypeField = reader.read("responseType");
  if (responseTypeField != null && !responseTypeField.isNull) {
    responseTypeEnum = responseTypeField.enumValue(HttpResponseType.values)!;
  } else {
    if (responseType == "String") {
      responseTypeEnum = HttpResponseType.STRING;
    } else if (responseType != "Null") {
      responseTypeEnum = HttpResponseType.JSON;
    }
  }

  HttpInputType inputTypeEnum;
  final inputTypeField = reader.read("inputType") as ConstantReader?;
  print("_getHttpFields inputTypeField $inputTypeField");
  if (inputTypeField != null && !inputTypeField.isNull) {
    inputTypeEnum = inputTypeField.enumValue(HttpInputType.values)!;
  } else {
    if (inputType == "String") {
      inputTypeEnum = HttpInputType.TEXT;
    } else {
      inputTypeEnum = HttpInputType.JSON;
    }
  }
  print("_getHttpFields input done");
  var responseDeserializer = "(resp) => resp";
  final responseDeserializerField = reader.read("responseDeserializer");
  if (responseDeserializerField != null && !responseDeserializerField.isNull) {
    responseDeserializer =
        responseDeserializerField.objectValue.toFunctionValue()!.name;
  }
  print("_getHttpFields responseDeserializer done");
  var errorDeserializer = "(err) => err";
  final errorDeserializerField = reader.read("errorDeserializer");
  if (errorDeserializerField != null && !errorDeserializerField.isNull) {
    errorDeserializer =
        errorDeserializerField.objectValue.toFunctionValue()!.name;
  }
  print("_getHttpFields responseDeserializer done");
  final graphqlQuery = reader.read("graphqlQuery")?.stringValue;
  String? inputSerializer;
  final inputSerializerField = reader.read("inputSerializer");
  if (inputSerializerField != null && !inputSerializerField.isNull) {
    inputSerializer = inputSerializerField.objectValue.toFunctionValue()!.name;
  }

  final reqExtAnnot = element.annotationFromType(HttpRequestExtension);

  String? transformer;
  if (reqExtAnnot != null) {
    final reqE = reqExtAnnot.computeConstantValue();
    final tf = reqE?.getField("transformer");
    if (tf != null) {
      transformer = tf.toFunctionValue()!.name;
    }
  }

  return HttpFieldInfo(
      name: element.name,
      url: url,
      method: method,
      inputTypeEnum: inputTypeEnum,
      responseTypeEnum: responseTypeEnum,
      inputType: inputType,
      responseDeserializer: responseDeserializer,
      errorDeserializer: errorDeserializer,
      queryParamsType: queryParamsType,
      inputSerializer: inputSerializer,
      responseType: responseType,
      transformer: transformer,
      graphqlQuery: graphqlQuery);
}
