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

typedef BeforeLeaveFn = bool Function(AppStateI);

enum HistoryUpdate { push, replace }

abstract class NavStateI<M> extends PStateModel<M> {
  Page? page;
  List<Page> buildPages() => [];
  Action notFoundAction(Uri uri);
  Action fallBackNestedStackNonInitializationAction(NavStateI navState);
  String? _dontTouchMeUrl;
  BeforeLeaveFn? beforeLeave;
  Action? redirectToAction;
  Action?
      originAction; // let say user entered protected route ,then he will be redirected to login page ,after that instead of going to home page lets redirect to origin url
  NavOptions? navOptions;
  bool blockSameUrl = false;

  String? get dontTouchMeUrl => _dontTouchMeUrl;
  set dontTouchMeUrl(String? value) {
    _dontTouchMeUrl = value;
  }

  List<NestedNavStateI> getNestedNavs() => [];

  History? _dontTouchMeHistory;
  History get dontTouchMeHistory => _dontTouchMeHistory!;
  set dontTouchMeHistory(History? history) {
    _dontTouchMeHistory = history;
  }

  late final Map<String, UrlToAction> dontTouchMeStaticMeta;
  late final Map<String, UrlToAction> dontTouchMeDynamicMeta;

  @override
  Map<String, dynamic> toMap() => throw UnimplementedError();
  @override
  M copyWithMap(Map<String, dynamic> map) => throw UnimplementedError();
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

  String dontTouchMeTypeName = "";

  Action? initialStateAction;
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
