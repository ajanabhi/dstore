import 'package:dstore_flutter/src/navigation/history/history.dart';
import "dart:html";

class HistoryImpl extends History {
  dynamic Function(Event)? _listener;
  List<UriListener> _urlListeners = [];
  final _source = <String>[];
  //  window.performance.navigation.type =  window.performance.navigation.TYPE_BACK_FORWARD (2)
  @override
  VoidCallback listen(UriListener listener) {
    _listener = (Event event) {
      urlChangedInSystem = true;
      final url = window.location.href;
      listener(Uri.parse(url));
      informUrlListeners();
    };
    window.addEventListener("popstate", _listener);
    return () {
      window.removeEventListener("popstate", _listener);
    };
  }

  @override
  void push(String url) {
    _source.add(url);
    window.history.pushState(null, "", url);
  }

  @override
  void replace(String url) {
    if (_source.isNotEmpty) {
      _source.removeLast();
      _source.add(url);
    }
    window.history.replaceState(null, "", url);
  }

  @override
  void goBack({String? burl, bool reloadBack = false}) {
    if (canGoBack) {
      _source.removeLast();
    }
    window.history.back();
  }

  @override
  void go(int number) {
    window.history.go(number);
  }

  @override
  void setInitialUrl(String url) {}

  @override
  String get url => window.location.href;

  @override
  bool blockSameUrl = false;

  @override
  VoidCallback listenUrl(UriListener urlListener) {
    _urlListeners.add(urlListener);
    return () {
      _urlListeners = _urlListeners.where((l) => l != urlListener).toList();
    };
  }

  @override
  bool get canGoBack {
    return window.history.length > 1;
  }

  @override
  String? get backUrl => throw UnimplementedError();

  @override
  void informUrlListeners([String? pUrl]) {
    _urlListeners.forEach((ul) {
      ul(Uri.parse(pUrl ?? url));
    });
  }

  @override
  // TODO: implement currentUrl
  String? get currentUrl => throw UnimplementedError();
}
