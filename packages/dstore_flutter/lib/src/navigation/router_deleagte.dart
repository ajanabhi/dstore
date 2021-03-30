import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DRouterDelegate<S extends AppStateI<S>> extends RouterDelegate<dynamic>
    with ChangeNotifier {
  final Selector<S, NavigationI> selector;

  DRouterDelegate({required this.selector});

  @override
  Widget build(BuildContext context) {
    return SelectorBuilder<S, NavigationI>(
      selector: selector,
      builder: (context, state) {
        return Navigator(
          pages: state.buildPages(),
          onPopPage: (route, dynamic result) {
            print("on Pop Page");
            return false;
          },
        );
      },
    );
  }

  @override
  Future<bool> popRoute() {
    print("On Prop Route");
    return SynchronousFuture(true);
  }

  @override
  Future<void> setNewRoutePath(dynamic configuration) async {
    print("Set new Route Path");
    // do nothing
  }
}
