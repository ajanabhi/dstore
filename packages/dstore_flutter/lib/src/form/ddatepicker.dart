import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DDatePicker<FieldKey> extends StatefulWidget {
  final FieldKey name;

  // default radio widget properties
  final MouseCursor? mouseCursor;
  final bool toggleable;
  final Color? activeColor;
  final MaterialStateProperty<Color?>? fillColor;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final Color? focusColor;
  final Color? hoverColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final FocusNode? focusNode;
  final bool autofocus;
  // defaul radio props end

  const DDatePicker({
    Key? key,
    required this.name,
    this.mouseCursor,
    this.toggleable = false,
    this.activeColor,
    this.fillColor,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);
  @override
  _DDatePickerState<FieldKey> createState() => _DDatePickerState<FieldKey>();
}

class _DDatePickerState<FieldKey> extends State<DDatePicker<FieldKey>> {
  Widget? _w;
  FromFieldPropInfo? _info;
  FromFieldPropInfo get info => _info!;
  late final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      if (!DStoreUtils.isEnum(widget.name)) {
        throw ArgumentError.value("${widget.name} should be an enum ");
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final key = FormUtils.getNameFromKey(widget.name);
    final dform = DForm.of(context);
    _info ??= dform.getInfo(key);
    final internalKeysChanged = dform.ff.internalKeysChanged;
    if (internalKeysChanged != null &&
        (internalKeysChanged.contains(key) ||
            internalKeysChanged.isEmpty /*in reset case we get empty list */)) {
      _info = dform.getInfo(key);
      _setText();
      _w = _getWidget();
    } else {
      _setText();
      _w ??= _getWidget();
    }
  }

  Widget _getWidget() {
    final dynamic formValue = info.value;
    if (!(formValue is DateTime)) {
      throw ArgumentError.value("${widget.key} should be a DateTime type");
    }
    return TextField(
      decoration: InputDecoration(prefixIcon: Icon(Icons.calendar_today)),
      onTap: () {
        _displayDatePicker(formValue);
      },
      controller: _controller,
      readOnly: true,
    );
  }

  void _setText() {
    _controller.text = "${info.value}";
  }

  void _displayDatePicker(DateTime value) async {
    final selectedData = await showDatePicker(
        context: context,
        initialDate: value,
        firstDate: DateTime(2021),
        lastDate: DateTime(2022));
    if (selectedData != null) {
      info.setValue(selectedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _w!;
  }

  @override
  void didUpdateWidget(covariant DDatePicker<FieldKey> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {
      throw NotSUpportedError(
          "You can not change name of textfield in runtime");
    }
  }
}
