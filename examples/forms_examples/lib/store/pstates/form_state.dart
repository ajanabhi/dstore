import 'package:dstore/dstore.dart';
import 'package:meta/meta.dart';
part 'form_state.ps.dstore.dart';
part "form_state.dstore.dart";

@PState()
class $_FormState {
  FormField<SimpleForm> simpleForm =
      FormField(value: SimpleForm(), validators: {});
}

enum REnum { one, two, three }

@FormModel()
class $_SimpleForm {
  String name = "initialName";
  REnum? r;
}
