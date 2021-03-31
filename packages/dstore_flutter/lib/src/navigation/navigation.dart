import 'package:dstore/dstore.dart';
import 'package:flutter/material.dart' hide Action;
import "configuration/confiure_native.dart"
    if (dart.library.html) "configuration/configure_web.dart";

abstract class NavStateI<M> extends PStateModel<M> {
  List<Page> buildPages();
  String? _url;
  String? get dontTouchMeUrl => _url;
  set dontTouchUrl(String value) {
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

typedef UrlToAction = Action<dynamic> Function(Uri);

abstract class NestedNavStateI {}

void configureNav() {
  configurePlatForm();
}
