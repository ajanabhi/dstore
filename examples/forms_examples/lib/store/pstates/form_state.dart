import 'package:dstore/dstore.dart';
import 'package:meta/meta.dart';
part 'form_state.ps.dstore.dart';
part "form_state.dstore.dart";

@PState()
class $_FormState {
  FormField<SimpleForm> simpleForm =
      FormField(value: SimpleForm(), validators: {});
}

@FormModel()
class $_SimpleForm {
  String name = "initialName";
}
