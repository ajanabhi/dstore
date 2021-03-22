import 'package:dstore_flutter/src/form/dform.dart';
import 'package:flutter/material.dart';
import 'package:dstore_flutter/src/store/store_provider.dart';

class DTextField extends StatefulWidget {
  final dynamic name;
  final String Function(dynamic value)? toText;
  final dynamic Function(String value)? fromText;

  const DTextField({Key? key, required this.name, this.toText, this.fromText})
      : super(key: key);
  @override
  _DTextFieldState createState() => _DTextFieldState();
}

class _DTextFieldState extends State<DTextField> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dform = DForm.of(context);
    final pinfo = dform.getInfo(widget.name);
    return Text("");
  }

  @override
  void didUpdateWidget(covariant DTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {}
  }
}
