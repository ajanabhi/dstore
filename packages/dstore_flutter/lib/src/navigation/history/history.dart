import 'package:dstore_flutter/src/navigation/history/history_nonweb.dart'
    if (dart.library.html) 'package:dstore_flutter/src/navigation/history/history_web.dart';
import 'package:flutter/material.dart';

typedef HistoryListener = void Function(Uri uri);

abstract class History {
  VoidCallback listen(HistoryListener listener);
  bool urlChangedInSystem = false;
  void push(String url);
  void replace(String url);
  String goBack();
  String go(int number);
  void setInitialUrl(String url);
  String get url;
}

History createHistory() => HistoryImpl();
