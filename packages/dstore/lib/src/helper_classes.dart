import 'package:dstore/dstore.dart';

class Optional<T> {
  final T? value;
  const Optional(this.value);
}

const optionalDefault = Optional(null);
