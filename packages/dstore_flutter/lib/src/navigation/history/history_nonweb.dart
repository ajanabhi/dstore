import 'package:dstore_flutter/src/navigation/history/history.dart';
import 'package:flutter/material.dart';

class HistoryImpl extends History {
  @override
  VoidCallback listen(HistoryListener listener) {
    //noop
    return () {};
  }

  @override
  void push(String url) {
    // TODO: implement push
  }

  @override
  void replace(String url) {
    // TODO: implement replace
  }
}
