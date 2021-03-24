import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/src/form/dform.dart';
import 'package:flutter/material.dart';

class DTextField<FieldKey> extends StatefulWidget {
  final FieldKey name;
  final String Function(dynamic value)? toText;
  final dynamic Function(String value)? fromText;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;

  const DTextField(
      {Key? key,
      required this.name,
      this.decoration,
      this.toText,
      this.keyboardType,
      this.fromText})
      : super(key: key);
  @override
  _DTextFieldState<FieldKey> createState() => _DTextFieldState<FieldKey>();
}

class _DTextFieldState<FieldKey> extends State<DTextField<FieldKey>> {
  TextField? _w;
  FromFieldPropInfo? _info;
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dform = DForm.of(context);
    final key = FormUtils.getNameFromKey(widget.name);
    _info ??= dform.getInfo(key);
    if (dform.ff.internalKeysChanged != null &&
        dform.ff.internalKeysChanged!.contains(key)) {
      _info = dform.getInfo(key);
      _setText();
      _w = _getWidget();
    } else {
      _setText();
      _w ??= _getWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _w!;
  }

  void _setText() {
    final text = widget.toText != null
        ? widget.toText!(_info?.value)
        : "${_info!.value}";
    _controller.text = text;
  }

  TextField _getWidget() {
    return TextField(
      controller: _controller,
      onChanged: _handleOnChange,
      keyboardType: widget.keyboardType,
      decoration: widget.decoration != null
          ? widget.decoration!.copyWith(errorText: _info!.error)
          : InputDecoration(errorText: _info!.error),
    );
  }

  void _handleOnChange(String value) {
    final dynamic fv =
        widget.fromText != null ? widget.fromText!(value) : value;
    _info!.setValue(fv);
  }

  @override
  void didUpdateWidget(covariant DTextField<FieldKey> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {
      throw NotSUpportedError(
          "You can not change name of textfield in runtime");
    }
  }
}
