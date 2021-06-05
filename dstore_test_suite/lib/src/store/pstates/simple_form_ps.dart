import 'package:dstore/dstore.dart';
part 'simple_form_ps.ps.dstore.dart';
part "simple_form_ps.dstore.dart";

@PState()
class $_SimpleFormPS {
  FormField<SimpleForm> simpleForm =
      FormField<SimpleForm>(value: SimpleForm(), validators: {});
}

@FormModel()
class $_SimpleForm {
  String name = "name";
}
