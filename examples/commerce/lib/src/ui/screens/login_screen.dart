import 'package:commerce/src/store/app_state.dart';
import 'package:commerce/src/store/models/forms.dart';
import 'package:commerce/src/store/pstates/login_screen_state.dart';
import 'package:commerce/src/store/selectors/login_screen/login_screen_selectors.dart';
import 'package:commerce/src/ui/utils/styles.dart';
import 'package:dstore_flutter/flutter_dstore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(context.storeTyped<AppState>().state.auth.user);
    return SelectorBuilder<AppState, LoginScreenState>(
        selector: LoginScreenSelectors.state,
        builder: (context, state) {
          print("Login State $state");
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
                    child: DForm(
                        ff: state.loginForm,
                        child: Column(
                          children: [
                            DTextField(
                              name: LoginFormKey.phonenUmber,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                helperText: "Enter Mobile NUmber2",
                              ),
                            )
                          ],
                        )),
                  ),
                ))
              ],
            ),
          );
        });
  }
}
