import 'package:dstore/dstore.dart';
import 'package:dstore_flutter/dstore_flutter.dart';
import 'package:dstore_flutter/src/navigation/history/history_nonweb.dart'
    if (dart.library.html) 'package:dstore_flutter/src/navigation/history/history_web.dart';
import 'package:flutter/material.dart' hide Action;

typedef UriListener = void Function(Uri uri);

abstract class History {
  abstract bool blockSameUrl;
  VoidCallback listen(UriListener listener);
  bool urlChangedInSystem = false;
  void push(String url);
  void replace(String url);
  void goBack();
  String? get backUrl;
  bool get canGoBack;
  void go(int number);
  void setInitialUrl(String url);
  void informUrlListeners([String? url]);
  String url = "";
  VoidCallback listenUrl(UriListener uriListener);
  Action? originAction;
  String? currentActiveNestedNav;

  late Action Function(NavStateI navState)
      fallBackNestedStackNonInitializationAction;

  final nestedNavsHistory = <String, NestedNavHistory>{};

  final nestedNavOrigins = <String, Action?>{};
  final nestedNavMeta = <String, Action>{};
}

class NestedNavHistory {
  final History history;
  final List<String> _source = [];
  Action? nestedInitialStateAction;
  Action? originAction;

  NestedNavHistory({required this.history});
  void push(String url) {
    _source.add(url);
    history.informUrlListeners(url);
  }

  void replace(String url) {
    if (_source.isNotEmpty) {
      _source.removeLast();
    }
    _source.add(url);
    history.url = url;
    history.informUrlListeners(url);
  }

  String? goBack() {
    if (canGoBack) {
      _source.removeLast();
      String? url;
      if (_source.isNotEmpty) {
        url = _source.last;
        return url;
      }
      history.informUrlListeners(url);
    }
  }

  bool get canGoBack => _source.isNotEmpty;
}

History createHistory() => HistoryImpl();
