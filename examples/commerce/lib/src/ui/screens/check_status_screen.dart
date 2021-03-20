import 'package:flutter/material.dart';

class CheckStatusScreen extends StatefulWidget {
  final bool checkForAccountStatusOnly;

  const CheckStatusScreen({Key? key, this.checkForAccountStatusOnly = false})
      : super(key: key);
  @override
  _CheckStatusScreenState createState() => _CheckStatusScreenState();
}

class _CheckStatusScreenState extends State<CheckStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
