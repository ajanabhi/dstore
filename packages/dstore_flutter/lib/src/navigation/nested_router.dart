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

  const NestedRouter({
    Key? key,
    required this.selector,
    this.options,
  }) : super(key: key);
  @override
  _NestedRouterState<AS, S> createState() => _NestedRouterState();
}

class _NestedRouterState<AS extends AppStateI<AS>,
    S extends NestedNavStateI<dynamic>> extends State<NestedRouter<AS, S>> {
  late History history;
  late NestedNavHistory nestedHistory;
  late NestedNavStateI navState;
  late Dispatch _dispatch;
  late final GlobalKey<NavigatorState> navigatorKey;
  bool setStateOnupdate = false;
  @override
  void initState() {
    super.initState();
    navigatorKey = GlobalKey();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        state.mounted = true;
        context.dispatch(state.dontTouchMe.initialSetup!);
        final typeName = state.dontTouchMe.typeName;
        state.dontTouchMe.hisotry = history;
        history.nestedNavsHistory[typeName] =
            NestedNavHistory(history: history);
        nestedHistory = history.nestedNavsHistory[typeName]!;
        if (state.page != null) {
          nestedHistory.historyMode = HistoryMode.tabs;
        } else {
          nestedHistory.historyMode = HistoryMode.stack;
        }
        final nestedOrigin = history.nestedNavOrigins[typeName];
        nestedHistory.originAction = nestedOrigin;
        nestedHistory.historyMode = state.dontTouchMe.historyMode;
        history.nestedNavOrigins.remove(typeName);
        history.currentActiveNestedNav = typeName;
        navState = state;
        history.currentNavKey = navigatorKey;
        print("nestedOrigin  ${nestedHistory.originAction}");
        if (nestedHistory.originAction != null) {
          final a = nestedHistory.originAction!;
          nestedHistory.originAction = null;
          scheduleMicrotask(() => _dispatch(a));
        }
      },
      shouldRebuild: (context, prevState, newState) {
        newState.dontTouchMe.hisotry = history;
        navState = newState;
        navState.mounted = true;
        nestedHistory.nestedInitialStateAction =
            newState.meta.initialStateAction;
        print("Newstate of nestedrouter $newState");
        if (newState.meta.redirectToAction != null) {
          print("Nested Router in redirect");
          final meta = newState.meta;
          final action = meta.redirectToAction!;
          meta.redirectToAction = null;
          history.originAction = meta.originAction;
          meta.originAction = null;
          scheduleMicrotask(() => _dispatch(action));
          return false;
        } else if (history.originAction != null) {
          print("Nested Router origin");
          final a = history.originAction!;
          history.originAction = null;
          scheduleMicrotask(() => _dispatch(a));
          return false;
        } else if (nestedHistory.originAction != null) {
          print("Nested Router in nestedOrigin");
          final a = nestedHistory.originAction!;
          nestedHistory.originAction = null;
          scheduleMicrotask(() => _dispatch(a));
          return false;
        } else {
          print("nestedrouter in update");
          _updateUrl();
          history.currentActiveNestedNav = newState.dontTouchMe.typeName;
          return true;
        }
      },
      onDispose: (context, state) {
        print("Disposing nested nav $state");
        final typeName = state.dontTouchMe.typeName;
        history.nestedNavsHistory.remove(typeName);
        history.currentNavKey = null;
        state.mounted = false;
      },
      builder: (context, state) {
        print("before build pages");
        print(
          "building nested nav $state pages ${state.buildPages()}",
        );
        print("after buildapges");
        final pages = state.page != null ? [state.page!] : state.buildPages();

        return Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, dynamic result) {
            if (route.didPop(result)) {
              print("On Pop nested");
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
    print('url chnaged ${history.urlChangedInSystem}');
    if (history.urlChangedInSystem) {
      history.urlChangedInSystem = false;
    } else {
      if (navState.dontTouchMe.url != null) {
        final url = navState.dontTouchMe.url!;
        // print("pushing url ${navState.dontTouchMeUrl}");
        if (navState.meta.navOptions?.historyUpdate == HistoryUpdate.replace) {
          nestedHistory.replace(url);
        } else {
          nestedHistory.push(url);
        }
        navState.meta.navOptions = null;
      }
    }
  }
}
