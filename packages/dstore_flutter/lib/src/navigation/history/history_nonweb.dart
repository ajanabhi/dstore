import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:flutter/material.dart';

class HistoryImpl extends History {
  final _source = <String>[];
  UriListener? _globalListerner;
  UriListener get g_listener => _globalListerner!;
  List<UriListener> _urlListeners = [];

  @override
  VoidCallback listen(UriListener listener) {
    _globalListerner = (Uri uri) {
      listener(uri);
      informUrlListeners();
    };
    return () {};
  }

  @override
  void push(String url) {
    _source.add(url);
    this.url = url;
    informUrlListeners();
  }

  @override
  void replace(String url) {
    if (_source.isNotEmpty) {
      _source.removeLast();
      _source.add(url);
      informUrlListeners();
    }
  }

  @override
  void goBack() {
    if (canGoBack) {
      _source.removeLast();
      final url = _source.last;
      this.url = url;
      g_listener(Uri.parse(url));
    }
  }

  @override
  void go(int number) {
    //TODO
    throw UnimplementedError();
  }

  @override
  void setInitialUrl(String url) {
    _source.add(url);
    this.url = url;
  }

  // @override
  // String get url => _source.isNotEmpty ? _source.last : "";

  @override
  bool blockSameUrl = false;

  @override
  VoidCallback listenUrl(UriListener uriListener) {
    _urlListeners.add(uriListener);
    return () {
      _urlListeners = _urlListeners.where((l) => l != uriListener).toList();
    };
  }

  @override
  bool get canGoBack {
    return _source.length > 1;
  }

  @override
  void informUrlListeners([String? pUrl]) {
    print("informing url slisterners pUrl $pUrl");
    _urlListeners.forEach((ul) {
      print("listerner $ul");
      ul(Uri.parse(pUrl ?? url));
    });
  }

  @override
  String? get backUrl => canGoBack ? _source[_source.length - 2] : null;
}
