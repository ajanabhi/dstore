import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scaffold_generator/generator.dart';
import './js_libs/js_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum TemplatesEnum { basic }

enum CICDEnum { github, circleci }

class _HomePageState extends State<HomePage> {
  TemplatesEnum? template = TemplatesEnum.basic;
  CICDEnum? cicd = CICDEnum.github;
  String error = "";
  String succes = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DStore Scaffold Generator"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Choose Template Type",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...TemplatesEnum.values
                  .map((e) => Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Radio<TemplatesEnum>(
                                value: e,
                                groupValue: template,
                                onChanged: (value) {
                                  setState(() {
                                    template = value;
                                    succes = "";
                                    error = "";
                                  });
                                }),
                          ),
                          Text("${describeEnum(e).capitalize}")
                        ],
                      ))
                  .toList()
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Choose CI CD Type",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...CICDEnum.values
                  .map((e) => Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Radio<CICDEnum>(
                                value: e,
                                groupValue: cicd,
                                onChanged: (value) {
                                  setState(() {
                                    cicd = value;
                                  });
                                }),
                          ),
                          Text("${describeEnum(e).capitalize}")
                        ],
                      ))
                  .toList()
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(25)),
                    onPressed: () async {
                      try {
                        final dirHandle = await window.showDirectoryPicker();
                        await Generator.generateTemplate(
                            dirHandle, template!, cicd!);
                        setState(() {
                          succes =
                              "Successfully saved template to your choosen directory:  ${dirHandle.name}";
                        });
                      } catch (e, st) {
                        print(st);
                        setState(() {
                          error = e.toString();
                        });
                      }
                    },
                    child: Text("Generate Template"))
              ],
            ),
          ),
          Text(
            error,
            style: TextStyle(fontSize: 20, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          Text(
            succes,
            style: TextStyle(fontSize: 20, color: Colors.green),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

extension StringExt on String {
  String get capitalize {
    final value = this;
    return "${value.substring(0, 1).toUpperCase()}${value.substring(1)}";
  }
}
