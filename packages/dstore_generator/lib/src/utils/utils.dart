export "model_utils.dart";
export "ast_utils.dart";
export "logger.dart";
export "builder_utils.dart";
export "package:collection/collection.dart";
import 'package:analyzer/dart/ast/ast.dart';
import "package:collection/collection.dart";

class Field {
  String name;
  String type;
  String? value;
  List<String>? annotations;
  bool isOptional;
  FormalParameter? param;
  bool isNamed;
  Field(
      {required this.name,
      required this.type,
      this.value,
      this.annotations,
      this.isNamed = false,
      this.param,
      this.isOptional = false});

  @override
  String toString() {
    return "Field(Name : ${name} Type : ${type} Value : ${value} isOptional : $isOptional annotations : $annotations isNamed: $isNamed)";
  }

  Field copyWith({
    String? name,
    String? type,
    String? value,
    List<String>? annotations,
    bool? isOptional,
    bool? isNamed,
    FormalParameter? param,
  }) {
    return Field(
        name: name ?? this.name,
        type: type ?? this.type,
        value: value ?? this.value,
        annotations: annotations ?? this.annotations,
        isOptional: isOptional ?? this.isOptional,
        param: param ?? this.param,
        isNamed: isNamed ?? this.isNamed);
  }
}

String replaceEndStar(String input) {
  var result = input;
  if (input.endsWith("*")) {
    result = input.substring(0, input.length - 1);
  }
  return result;
}

String _getFinalTypeOfField(Field f) {
  return (!f.type.endsWith("?") && f.isOptional) ? "${f.type}?" : f.type;
}

List<Field> processFields(List<Field> fields) {
  return fields
      .map((f) => f.copyWith(
          type: _getFinalTypeOfField(f),
          isOptional: f.isOptional ? f.isOptional : f.type.endsWith("?")))
      .toList();
}

String convertEnumToString(Object enumEntry) {
  final description = enumEntry.toString();
  final indexOfDot = description.indexOf('.');
  assert(
    indexOfDot != -1 && indexOfDot < description.length - 1,
    'The provided object "$enumEntry" is not an enum.',
  );
  return description.substring(indexOfDot + 1);
}

String? convertEnumOrNullToString(Object? enumEntry) {
  if (enumEntry == null) {
    return null;
  }
  final description = enumEntry.toString();
  final indexOfDot = description.indexOf('.');
  assert(
    indexOfDot != -1 && indexOfDot < description.length - 1,
    'The provided object "$enumEntry" is not an enum.',
  );
  return description.substring(indexOfDot + 1);
}

E? convertStringToEnum<E>(String s, List<E> values) {
  return values.firstWhereOrNull((v) => v.toString().split('.')[1] == s);
}

extension StringExt on String {
  String get cpatialize => "${substring(0, 1).toUpperCase()}${substring(1)}";
}

extension IterableMapIndex<T> on Iterable<T> {
  Iterable<E> mapIndexed<E>(E Function(int index, T t) f) {
    return Iterable.generate(
        this.length, (index) => f(index, elementAt(index)));
  }
}
