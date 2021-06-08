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
  String projectName = "";
  bool isIos = true;
  bool isAndroid = true;
  bool isWeb = true;
  bool isLinux = false;
  bool isWindows = false;
  bool isMacOs = false;

  bool githubTestWorkFlow = true;
  bool githubDeployToGithubPagesWorkflow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DStore Scaffold Generator"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  projectName = value;
                  error = "";
                });
              },
              decoration: InputDecoration(labelText: "Project Name"),
            ),
          ),
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
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(children: [
                  Checkbox(
                      value: isIos,
                      onChanged: (value) {
                        setState(() {
                          isIos = value ?? false;
                        });
                      }),
                  Text("iOS")
                ]),
                Row(children: [
                  Checkbox(
                      value: isAndroid,
                      onChanged: (value) {
                        setState(() {
                          isAndroid = value ?? false;
                        });
                      }),
                  Text("Android")
                ]),
                Row(children: [
                  Checkbox(
                      value: isWeb,
                      onChanged: (value) {
                        setState(() {
                          isWeb = value ?? false;
                        });
                      }),
                  Text("Web")
                ]),
                Row(children: [
                  Checkbox(
                      value: isLinux,
                      onChanged: (value) {
                        setState(() {
                          isLinux = value ?? false;
                        });
                      }),
                  Text("Linux")
                ]),
                Row(children: [
                  Checkbox(
                      value: isMacOs,
                      onChanged: (value) {
                        setState(() {
                          isMacOs = value ?? false;
                        });
                      }),
                  Text("MacOS")
                ]),
                Row(children: [
                  Checkbox(
                      value: isWindows,
                      onChanged: (value) {
                        setState(() {
                          isWindows = value ?? false;
                        });
                      }),
                  Text("Windows")
                ])
              ])),
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
          if (cicd == CICDEnum.github)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(children: [
                  Checkbox(
                      value: githubTestWorkFlow,
                      onChanged: (value) {
                        setState(() {
                          githubTestWorkFlow = value ?? false;
                        });
                      }),
                  Text("Test Workflow")
                ]),
                Row(children: [
                  Checkbox(
                      value: githubDeployToGithubPagesWorkflow,
                      onChanged: (value) {
                        setState(() {
                          githubDeployToGithubPagesWorkflow = value ?? false;
                        });
                      }),
                  Text("Deploy Web To GithubPages Workflow")
                ]),
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
                      if (projectName.trim().isEmpty) {
                        setState(() {
                          error = "Project Name should not be empty";
                        });
                      } else {
                        try {
                          final dirHandle = await window.showDirectoryPicker();

                          await Generator.generateTemplate(
                              dirHandle: dirHandle,
                              template: template!,
                              cicd: cicd!,
                              name: projectName,
                              platformsSelected: getPlatforms(),
                              githubWorkFlows: getGithubWorkFlows());
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

  List<String> getPlatforms() {
    final result = <String>[];
    if (isIos) {
      result.add("ios");
    }
    if (isAndroid) {
      result.add("android");
    }
    if (isWeb) {
      result.add("web");
    }
    if (isMacOs) {
      result.add("macos");
    }
    if (isLinux) {
      result.add("linux");
    }
    if (isAndroid) {
      result.add("windows");
    }
    return result;
  }

  List<String> getGithubWorkFlows() {
    final result = <String>[];
    if (githubTestWorkFlow) {
      result.add("test");
    }
    if (githubDeployToGithubPagesWorkflow) {
      result.add("ghpages");
    }
    return result;
  }
}

extension StringExt on String {
  String get capitalize {
    final value = this;
    return "${value.substring(0, 1).toUpperCase()}${value.substring(1)}";
  }
}
