import 'package:dstore_flutter/src/navigation/history/history.dart';
import "dart:html";

class HistoryImpl extends History {
  dynamic Function(Event)? _listener;
  @override
  VoidCallback listen(HistoryListener listener) {
    _listener = (Event event) {
      urlChangedInSystem = true;
      listener(Uri.parse(window.location.href));
    };
    window.addEventListener("popstate", _listener);
    return () {
      window.removeEventListener("popstate", _listener);
    };
  }

  @override
  void push(String url) {
    window.history.pushState(null, "", url);
  }

  @override
  void replace(String url) {
    window.history.replaceState(null, "", url);
  }
}
