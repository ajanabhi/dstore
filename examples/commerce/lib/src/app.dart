import 'package:commerce/src/routes/routes.gr.dart';
import 'package:commerce/src/store/app_state.dart';
import 'package:commerce/src/store/pstates/auth.dart';
import 'package:commerce/src/store/selectors/auth_selectors.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: SelectorListener<AppState, Auth>(
          selector: AuthSelectors.auth,
          listener: (context, auth) {
            if (auth.loggedout) {
              // redirect to login screen
            }
            print("auth changed $auth");
          },
          onInitState: (context, state) {
            context.dispatch(
                AuthActions.user(stream: FirebaseAuth.instance.userChanges()));
          },
          child: MaterialApp.router(
            routeInformationParser: _appRouter.defaultRouteParser(),
            routerDelegate: _appRouter.delegate(),
          )),
    );
  }
}
