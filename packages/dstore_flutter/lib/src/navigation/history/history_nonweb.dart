import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:flutter/material.dart';

class HistoryImpl extends History {
  final _source = <String>[];
  @override
  VoidCallback listen(HistoryListener listener) {
    //noop
    return () {};
  }

  @override
  void push(String url) {
    _source.add(url);
  }

  @override
  void replace(String url) {
    _source.removeLast();
    _source.add(url);
  }

  @override
  String goBack() {
    if (_source.length > 1) {
      // final url = _source.last;
      _source.removeLast();
      return _source.last;
    }
    return "";
  }

  @override
  String go(int number) {
    //
    //
    return "";
  }

  @override
  void setInitialUrl(String url) {
    _source.add(url);
  }

  @override
  String get url => _source.last;

  @override
  bool blockSameUrl = false;
}
