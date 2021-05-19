import 'dart:async';

import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:flutter/material.dart' hide Action;
import "./navigation_provider.dart";

class NestedRouter<AS extends AppStateI<AS>, S extends NestedNavStateI<dynamic>>
    extends StatefulWidget {
  final Selector<AS, S> selector;
  final UnSubscribeOptions? options;
  final Action? inititalStateAction;

  const NestedRouter(
      {Key? key,
      required this.selector,
      this.options,
      this.inititalStateAction})
      : super(key: key);
  @override
  _NestedRouterState<AS, S> createState() => _NestedRouterState();
}

class _NestedRouterState<AS extends AppStateI<AS>,
    S extends NestedNavStateI<dynamic>> extends State<NestedRouter<AS, S>> {
  late History history;
  late NestedNavHistory nestedHistory;
  late NestedNavStateI navState;
  late Dispatch _dispatch;
  late final Key navigatorKey;
  bool setStateOnupdate = false;
  @override
  void initState() {
    super.initState();
    navigatorKey = ValueKey(widget.selector.hashCode);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.inititalStateAction != null) {
      context.dispatch(widget.inititalStateAction!);
    }
    history = context.dnavigation.dotTouchmeHistory;
  }

  @override
  Widget build(BuildContext context) {
    _dispatch = context.dispatch;
    var ssonup = false;
    if (setStateOnupdate) {
      ssonup = true;
      setStateOnupdate = false;
    }
    return SelectorBuilder<AS, S>(
      selector: widget.selector,
      options: widget.options,
      setStateOnUpdate: ssonup,
      onInitState: (context, state) {
        print("NestedNav Init State");
        final typeName = state.dontTouchMeTypeName;
        state.dontTouchMeHistory = history;
        history.nestedNavsHistory[typeName] =
            NestedNavHistory(history: history);
        nestedHistory = history.nestedNavsHistory[typeName]!;
        history.currentActiveNestedNav = typeName;
        navState = state;
      },
      shouldRebuild: (context, prevState, newState) {
        newState.dontTouchMeHistory = history;
        navState = newState;
        nestedHistory.nestedInitialStateAction = newState.initialStateAction;
        print("Newstate of nestedrouter $newState");
        if (newState.redirectToAction != null) {
          final action = newState.redirectToAction!;
          newState.redirectToAction = null;
          history.originAction = newState.originAction;
          newState.originAction = null;
          scheduleMicrotask(() => _dispatch(action));
          return false;
        } else if (history.originAction != null) {
          final a = history.originAction!;
          history.originAction = null;
          scheduleMicrotask(() => _dispatch(a));
          return false;
        } else {
          _updateUrl();
          history.currentActiveNestedNav = newState.dontTouchMeTypeName;
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
          // key: navigatorKey,
          pages: state.buildPages(),
          onPopPage: (route, dynamic result) {
            if (route.didPop(result)) {
              print("On Pop nested");
              if (state.initialStateAction != null) {
                final a = state.initialStateAction!;
                state.initialStateAction = null;
                nestedHistory.nestedInitialStateAction = null;
                print("start silent action");
                context.dispatch(a);
                print("done silent action");
                setStateOnupdate = true;
              }
              nestedHistory.goBack();
              return true;
            } else {
              print("Nested pop fail");
              return false;
            }
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
        // print("pushing url ${navState.dontTouchMeUrl}");
        if (navState.navOptions?.historyUpdate == HistoryUpdate.replace) {
          nestedHistory.replace(url);
        } else {
          nestedHistory.push(url);
        }
        navState.navOptions = null;
      }
    }
  }
}
