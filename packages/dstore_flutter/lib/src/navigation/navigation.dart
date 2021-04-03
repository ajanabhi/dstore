import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:flutter/material.dart' hide Action;
import "configuration/confiure_native.dart"
    if (dart.library.html) "configuration/configure_web.dart";
export "router_deleagte.dart";

abstract class NavStateI<M> extends PStateModel<M> {
  List<Page> buildPages();
  String? _url;
  Action? redirectToAction;
  HistoryUpdate? historyUpdate;
  String? get dontTouchMeUrl => _url;
  set dontTouchMeUrl(String? value) {
    _url = value;
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

abstract class NestedNavStateI {}

void configureNav() {
  configurePlatForm();
}
