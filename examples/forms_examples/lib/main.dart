// @dart=2.9
import 'package:flutter/material.dart';

void main() {
  runApp(FormsExample());
}

class FormsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Flutter Forms"),
          TextField(
            decoration: InputDecoration(helperText: "In"),
          )
        ],
      ),
    );
  }
}
