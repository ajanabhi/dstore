import 'package:dstore/dstore.dart';
import 'package:flutter/material.dart' hide FormField;
import 'package:dstore_flutter/src/store/store_provider.dart';

class DForm<F extends FormFieldObject<F>> extends InheritedWidget {
  final FormField<dynamic, F> ff;
  final _FormState _formState = _FormState();
  DForm({Key? key, required this.ff, required Widget child})
      : super(key: key, child: child);

  static DForm of(BuildContext context) {
    final dform = context.dependOnInheritedWidgetOfExactType<DForm>()!;
    if (dform._formState.ops == null) {
      final d = context.dispatch as Dispatch;
      dform._formState.ops = FormUtils.getFormOps(dform.ff, d);
    }
    return dform;
  }

  FormOps get ops => _formState.ops!;

  FromFieldPropInfo getInfo(dynamic key) {
    final value = ff.value.toMap();
    final dynamic kv = value[key];
    if (kv == null) {
      throw ArgumentError.value("$key not found in this from ${value}");
    }
    final validator = ff.validators[key];
    final error = ff.errors[key];
    final touched = ff.touched[key] ?? false;
    final name = key.value as String;
    return FromFieldPropInfo(
        name: key,
        value: kv,
        validator: validator,
        error: error,
        setValue: (dynamic value) =>
            ops.setFieldValue(FormSetFieldValue(key: name, value: value)),
        setError: (String? error) =>
            ops.setFieldError(FormSetFieldError(key: name, value: error)),
        setTouched: (bool validate) => ops.setFieldTouched(
            FormSetFieldTouched(key: name, validate: validate)),
        touched: touched);
  }

  @override
  bool updateShouldNotify(DForm oldWidget) {
    final result = oldWidget.ff != this.ff;
    if (result) {
      this._formState.ops = null;
    }
    return result;
  }
}

class _FormState {
  FormOps? ops;
}
