import 'dart:async';

import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:flutter/material.dart';
import "./navigation_provider.dart";

class NestedRouter<AS extends AppStateI<AS>, S extends NestedNavStateI<dynamic>>
    extends StatefulWidget {
  final Selector<AS, S> selector;

  const NestedRouter({Key? key, required this.selector}) : super(key: key);
  @override
  _NestedRouterState<AS, S> createState() => _NestedRouterState();
}

class _NestedRouterState<AS extends AppStateI<AS>,
    S extends NestedNavStateI<dynamic>> extends State<NestedRouter<AS, S>> {
  late History history;
  late NestedNavStateI navState;
  late Dispatch _dispatch;
  late final Key navigatorKey;
  @override
  void initState() {
    super.initState();
    navigatorKey = ValueKey(widget.selector.hashCode);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    history = context.dnavigation.history;
  }

  @override
  Widget build(BuildContext context) {
    _dispatch = context.dispatch;
    return SelectorBuilder<AS, S>(
      selector: widget.selector,
      onInitState: (context, state) {
        navState = state;
      },
      shouldRebuild: (context, prevState, newState) {
        navState = newState;
        if (newState.redirectToAction != null) {
          final action = newState.redirectToAction!;
          newState.redirectToAction = null;
          scheduleMicrotask(() => _dispatch(action));
          return false;
        } else {
          _updateUrl();
          return true;
        }
      },
      builder: (context, state) {
        print("before build pages");
        print(
          "building nested nav $state pages ${state.buildPages()}",
        );
        print("after buildapges");
        return Navigator(
          key: navigatorKey,
          pages: state.buildPages(),
          onPopPage: (route, dynamic result) {
            print("On Pop nested");
            return true;
          },
        );
      },
    );
  }

  void _updateUrl() {
    if (history.urlChangedInSystem) {
      history.urlChangedInSystem = false;
    } else {
      if (navState.dontTouchMeUrl != null) {
        final url = navState.dontTouchMeUrl!;
        // print("pusing url ${navState.dontTouchMeUrl}");
        if (navState.navOptions?.historyUpdate == HistoryUpdate.replace) {
          history.replace(url);
        } else {
          history.push(url);
        }
        navState.navOptions = null;
      }
    }
  }
}
