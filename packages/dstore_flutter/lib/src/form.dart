import 'package:flutter/material.dart';
import 'package:dstore/dstore.dart' as ds;
import 'package:dstore_flutter/flutter_dstore.dart';

class DForm extends InheritedWidget {
  final ds.FormField ff;
  final _FormState _formState = _FormState();
  DForm({Key? key, required this.ff, required Widget child})
      : super(key: key, child: child);

  static DForm of(BuildContext context) {
    final dform = context.dependOnInheritedWidgetOfExactType<DForm>()!;
    if (dform._formState.ops == null) {
      final d = context.dispatch as ds.Dispatch;
      dform._formState.ops = ds.FormUtils.getFormOps(dform.ff, d);
    }
    return dform;
  }

  ds.FormOps get ops => _formState.ops!;

  ds.FromFieldPropInfo getInfo(String key) {
    final value = ff.value.toMap();
    final dynamic kv = value[key];
    if (kv == null) {
      throw ArgumentError.value("$key not found in this from ${value}");
    }
    final validator = ff.validators[key];
    final error = ff.errors[key];
    final touched = ff.touched[key] ?? false;
    return ds.FromFieldPropInfo(
        name: key,
        value: kv,
        validator: validator,
        error: error,
        setValue: (dynamic value) =>
            ops.setFieldValue(ds.FormSetFieldValue(key: key, value: value)),
        setError: (String? error) =>
            ops.setFieldError(ds.FormSetFieldError(key: key, value: error)),
        setTouched: (bool validate) => ops.setFieldTouched(
            ds.FormSetFieldTouched(key: key, validate: validate)),
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
  ds.FormOps? ops;
}

class DTextField extends StatefulWidget {
  final String name;

  const DTextField({Key? key, required this.name}) : super(key: key);
  @override
  _DTextFieldState createState() => _DTextFieldState();
}

class _DTextFieldState extends State<DTextField> {
  @override
  Widget build(BuildContext context) {
    final dform = DForm.of(context);
    final pinfo = dform.getInfo(widget.name);
    return Text("");
  }
}
