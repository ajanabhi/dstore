import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/src/form/dform.dart';
import 'package:flutter/material.dart';

class DFormField<FieldKey, F extends FormFieldObject<F>>
    extends StatefulWidget {
  final FieldKey name;
  final Widget Function(FromFieldPropInfo) builder;

  const DFormField({
    Key? key,
    required this.name,
    required this.builder,
  }) : super(key: key);
  @override
  _DFormFieldState<FieldKey, F> createState() =>
      _DFormFieldState<FieldKey, F>();
}

class _DFormFieldState<FieldKey, F extends FormFieldObject<F>>
    extends State<DFormField<FieldKey, F>> {
  Widget? _w;
  FromFieldPropInfo? _info;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dform = DForm.of<FieldKey, F>(context);
    _info ??= dform.getInfo(widget.name);
    if (dform.ff.internalKeysChanged != null &&
        dform.ff.internalKeysChanged!.contains(widget.name)) {
      _info = dform.getInfo(widget.name);
      _w = widget.builder(_info!);
    } else {
      _w ??= widget.builder(_info!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _w!;
  }

  @override
  void didUpdateWidget(covariant DFormField<FieldKey, F> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {
      throw NotSUpportedError(
          "You can not change name of textfield in runtime");
    }
  }
}
