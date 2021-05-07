import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      appBar: AppBar(
        title: Text("Hello FS"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hello FireStore"),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    print("Hello");
                    final ref = FirebaseFirestore.instance
                        .collection("attendees")
                        .doc("jUlqrzD1QtfHFDtVuc2KFgQhS0a2");
                    final collRef =
                        FirebaseFirestore.instance.collection("refs");
                    await collRef
                        .doc("ref3")
                        .set(<String, dynamic>{"name": "ref3", "a3": ref});
                    final data = await collRef.doc("ref3").get();
                    print("done ${data.data()} ${data.id}");
                  } catch (e) {
                    print("Error $e");
                  }
                },
                child: Text("Get It"))
          ],
        ),
      ),
    );
  }

  void addData(CollectionReference collRef) async {
    await collRef
        .doc("roomA")
        .collection("messages")
        .doc("m1")
        .set(<String, dynamic>{"name": "n1"});
  }
}
