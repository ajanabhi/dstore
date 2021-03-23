import 'package:commerce/src/store/app_state.dart';
import 'package:dstore_flutter/flutter_dstore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(context.storeTyped<AppState>().state.auth.user);
    return Scaffold(
      body: Center(
        child: Text("Login Screen"),
      ),
    );
  }
}
