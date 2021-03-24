import 'package:commerce/src/store/app_state.dart';
import 'package:commerce/src/store/models/forms.dart';
import 'package:commerce/src/store/selectors/login_screen/login_screen_selectors.dart';
import 'package:commerce/src/ui/utils/styles.dart';
import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/flutter_dstore.dart';
import 'package:flutter/material.dart' hide FormField;

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Material(
          elevation: 5,
          child: Container(
            height: 250,
            width: width,
            decoration: BoxDecoration(
              gradient: Styles.appBackGradient,
            ),
          ),
        ),
        SafeArea(
            child: Card(
          margin: EdgeInsets.only(top: 50, right: 16, left: 16),
          child: Container(
            margin: const EdgeInsets.all(16),
            child:
                SelectorBuilder<AppState, FormField<LoginFormKey, LoginForm>>(
                    selector: LoginScreenSelectors.loginForm,
                    options: UnSubscribeOptions(resetToDefault: true),
                    builder: (context, state) {
                      return DForm(
                          ff: state,
                          child: Column(
                            children: [
                              DTextField(
                                name: LoginFormKey.phonenUmber,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  helperText: "Enter Mobile NUmber2",
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                  onPressed: state.isValid ? () {} : null,
                                  child: Text("Continue"))
                            ],
                          ));
                    }),
          ),
        ))
      ],
    ));
  }
}
