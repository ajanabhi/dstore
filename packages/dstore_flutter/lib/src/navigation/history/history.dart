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
  void goBack({String? burl, bool reloadBack = false});
  String? get backUrl;
  String? get currentUrl;
  bool get canGoBack;
  void go(int number);
  void setInitialUrl(String url);
  void informUrlListeners([String? url]);
  String url = "";
  VoidCallback listenUrl(UriListener uriListener);
  Action? originAction;
  String? currentActiveNestedNav;
  late HistoryMode historyMode;
  GlobalKey<NavigatorState>? currentNavKey;
  BeforeLeaveFn? beforeLeave;

  late Action Function(NavStateI navState)
      fallBackNestedStackNonInitializationAction;

  final nestedNavsHistory = <String, NestedNavHistory>{};

  final nestedNavOrigins = <String, Action?>{};
  final nestedNavMeta = <String, Action>{};
}

class NestedNavHistory {
  final History history;
  late String rootUrl;
  final List<String> source = [];
  Action? nestedInitialStateAction;
  Action? originAction;
  late HistoryMode historyMode;
  String? parentStackTypeName;
  GlobalKey<NavigatorState>? parentNavKey;
  final nestedNavMeta = <String, Action>{};

  NestedNavHistory({required this.history});
  void push(String url) {
    source.add(url);
    history.url = url;
    history.informUrlListeners(url);
  }

  void replace(String url) {
    if (source.isNotEmpty) {
      source.removeLast();
    }
    source.add(url);
    history.url = url;
    history.informUrlListeners(url);
  }

  void goBack() {
    if (canGoBack) {
      source.removeLast();
      String? url;
      if (source.isNotEmpty) {
        url = source.last;
        history.url = url;
      } else {
        history.url = rootUrl;
      }
      history.goBack(burl: history.url, reloadBack: true);
    } else {
      history.url = rootUrl;
      history.goBack(burl: history.url, reloadBack: true);
    }
  }

  String? get backUrl =>
      (canGoBack && source.length > 1) ? source[source.length - 2] : null;

  bool get canGoBack => source.isNotEmpty;

  @override
  String toString() {
    return 'NestedNavHistory(history: $history, Source : $source,nestedInitialStateAction: $nestedInitialStateAction, originAction: $originAction, historyMode: $historyMode, parentStackTypeName: $parentStackTypeName, parentNavKey: $parentNavKey)';
  }
}

History createHistory() => HistoryImpl();
