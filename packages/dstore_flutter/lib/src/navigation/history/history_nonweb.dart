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
    _source.removeLast();
    return _source.last;
  }

  @override
  String go(int number) {}
}
