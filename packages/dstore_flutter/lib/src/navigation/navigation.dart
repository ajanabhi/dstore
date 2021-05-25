import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:flutter/material.dart' hide Action;

import "configuration/confiure_native.dart"
    if (dart.library.html) "configuration/configure_web.dart";
export "router_deleagte.dart";
export "route_information_parser.dart";
export "nested_router.dart";
export "middleware.dart";
export "url_builder.dart";

typedef BeforeLeaveFn<S> = BeforeLeaveResult Function(AppStateI appState);

class BeforeLeaveResult {
  final bool allowToLeave;
  final WidgetBuilder? dialogBuilder;

  BeforeLeaveResult({required this.allowToLeave, this.dialogBuilder});
}

enum HistoryUpdate { push, replace }

enum HistoryMode { tabs, stack }

class NavConfigMeta {
  BeforeLeaveFn? beforeLeave;
  Action? redirectToAction;
  Action?
      originAction; // let say user entered protected route ,then he will be redirected to login page ,after that instead of going to home page lets redirect to origin url
  NavOptions? navOptions;
  // Action? initialStateAction; // only for nested navs
  bool blockSameUrl;
  NavConfigMeta({
    this.beforeLeave,
    this.redirectToAction,
    this.originAction,
    this.navOptions,
    this.blockSameUrl = false,
  });

  @override
  String toString() {
    return 'NavConfigMeta(beforeLeave: $beforeLeave, redirectToAction: $redirectToAction, originAction: $originAction, navOptions: $navOptions, )';
  }
}

class NavStateDontTouchMe {
  String? url;
  late final Map<String, UrlToAction> staticMeta;
  late final Map<String, UrlToAction> dynamicMeta;
  late History hisotry;
  String typeName = ""; // empty in main navigation
  Action? initialSetup; // not null for all nested navs
  late HistoryMode historyMode;
  String? rootUrl;
  bool isDirty = false;
  final List<String?> previousStackedUrls =
      []; // only for   nestednav with stack history mode

  @override
  String toString() {
    return 'NavStateDontTouchMe(url: $url, staticMeta: $staticMeta, dynamicMeta: $dynamicMeta, hisotry: $hisotry, typeName: $typeName, initialSetup: $initialSetup, historyMode: $historyMode, rootUrl: $rootUrl, isDirty: $isDirty)';
  }
}

abstract class NavStateI<M> extends PStateModel<M> {
  Page? page;
  List<Page> buildPages() => [];
  Action notFoundAction(Uri uri);
  Action fallBackNestedStackNonInitializationAction(NavStateI navState);

  NavConfigMeta meta = NavConfigMeta();
  NavStateDontTouchMe dontTouchMe = NavStateDontTouchMe();
  List<NestedNavStateMeta> getNestedNavs() => [];

  @override
  Map<String, dynamic> toMap() => throw UnimplementedError();
  @override
  M copyWithMap(Map<String, dynamic> map) => throw UnimplementedError();
}

class NestedNavStateMeta {
  final NestedNavStateI state;
  final Action rootAction;

  NestedNavStateMeta({required this.state, required this.rootAction});
}

class RouteInput {
  final Map<String, dynamic>? params;
  final Map<String, dynamic>? queryParams;

  RouteInput({this.params, this.queryParams});
}

typedef UrlToAction = dynamic Function(Uri, Dispatch);

abstract class NestedNavStateI<M> extends NavStateI<M> {
  @override
  Action notFoundAction(Uri uri) {
    throw UnimplementedError();
  }

  @override
  Action fallBackNestedStackNonInitializationAction(NavStateI navState) {
    throw UnimplementedError();
  }

  void initialSetup();

  bool mounted = false;
}

void configureNav() {
  configurePlatForm();
}

class NavOptions<E> {
  final HistoryUpdate? historyUpdate;
  final bool reload;
  final E?
      extraOptions; // use this to pass extra options to navigation action , remember you should handle null case , because when user entered via url extraOptions will be null

  NavOptions({this.historyUpdate, this.reload = false, this.extraOptions});
}
