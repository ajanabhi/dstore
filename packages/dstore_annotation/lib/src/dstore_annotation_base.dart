import "package:collection/collection.dart";

class Selectors {
  const Selectors();
}

class AppStateAnnotation {
  const AppStateAnnotation();
}

class DImmutable {
  const DImmutable();
}

const dimmutable = DImmutable();

class PersistKey {
  final bool ignore;
  const PersistKey({this.ignore = false});
}

class Default {
  const Default(dynamic value);
}

class DEnum {
  const DEnum();
}

class FormModel {
  const FormModel();
}

class Validator {
  final Function fn;
  const Validator(this.fn);
}

class DUnion {
  const DUnion();
}
