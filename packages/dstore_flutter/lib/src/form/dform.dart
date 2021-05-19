import 'package:dstore/dstore.dart';
import 'package:flutter/material.dart' hide FormField;
import 'package:dstore_flutter/src/store/store_provider.dart';

class DForm extends InheritedWidget {
  final FormField<FormFieldObject> ff;
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

  FromFieldPropInfo getInfo(String key) {
    final value = ff.value.toMap();
    final dynamic kv = value[key.toString().split(".").last];
    if (kv == null) {
      throw ArgumentError.value("$key not found in this from ${value}");
    }
    final validator = ff.validators[key];
    final error = ff.errors[key];
    final touched = ff.touched[key] ?? false;
    return FromFieldPropInfo(
        name: key,
        value: kv,
        validator: validator,
        error: error,
        setValue: (dynamic value, {bool? validate}) => ops.setFieldValue(
            FormSetFieldValue(key: key, value: value, validate: validate)),
        setError: (String? error) =>
            ops.setFieldError(FormSetFieldError(key: key, value: error)),
        setTouched: (bool validate) => ops
            .setFieldTouched(FormSetFieldTouched(key: key, validate: validate)),
        touched: touched);
  }

  void validate() {
    _formState.ops!.validateForm(FormValidate());
  }

  @override
  bool updateShouldNotify(DForm oldWidget) {
    final off = oldWidget.ff;
    if (off.internalAName != ff.internalAName ||
        off.internalAType != ff.internalAType) {
      this._formState.ops = null;
    }
    return oldWidget.ff != this.ff;
  }
}

class _FormState {
  FormOps? ops;
}
