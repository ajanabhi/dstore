import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:flutter/material.dart' hide Action;
import "configuration/confiure_native.dart"
    if (dart.library.html) "configuration/configure_web.dart";
export "router_deleagte.dart";
export "route_information_parser.dart";

typedef BeforeLeaveFn = bool Function(AppStateI);

enum HistoryUpdate { push, replace }

abstract class NavStateI<M> extends PStateModel<M> {
  Page? page;
  List<Page> buildPages() => [];
  String? _dontTouchMeUrl;
  BeforeLeaveFn? beforeLeave;
  Action? redirectToAction;
  NavOptions? navOptions;
  String? get dontTouchMeUrl => _dontTouchMeUrl;
  set dontTouchMeUrl(String? value) {
    _dontTouchMeUrl = value;
  }

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

abstract class NestedNavStateI extends NavStateI<dynamic> {}

void configureNav() {
  configurePlatForm();
}

class NavOptions {
  final HistoryUpdate? historyUpdate;
  final bool reload;

  NavOptions({this.historyUpdate, this.reload = false});
}
