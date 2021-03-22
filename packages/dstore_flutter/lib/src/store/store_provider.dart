import 'package:dstore/dstore.dart';
import 'package:flutter/material.dart' hide Action;

class StoreProvider<S extends AppStateI<S>> extends InheritedWidget {
  final Store<S, dynamic> _store;

  const StoreProvider({
    Key? key,
    required Store<S, dynamic> store,
    required Widget child,
  })   : _store = store,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(StoreProvider<S> oldWidget) {
    return oldWidget._store != this._store;
  }

  static Store<S, dynamic> of<S extends AppStateI<S>>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StoreProvider<S>>()!._store;
}

extension DStoreContextExtensionMethods on BuildContext {
  Store<S, dynamic> store<S extends AppStateI<S>>() =>
      StoreProvider.of<S>(this);
  dynamic dispatch<S extends AppStateI<S>>(Action<dynamic> action) =>
      this.store<S>().dispatch(action);
}
