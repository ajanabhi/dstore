import 'package:dstore/dstore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:meta/meta.dart";

part "auth.ps.dstore.dart";

@PState()
class _Auth {
  User? user;

  // void test() {
  //   this.user = null;
  //   FirebaseAuth.instance.
  // }
}
