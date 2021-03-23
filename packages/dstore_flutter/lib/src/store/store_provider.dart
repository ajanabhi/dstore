import 'package:dstore/dstore.dart';
import 'package:flutter/material.dart' hide Action;

class StoreProvider extends InheritedWidget {
  final Store<AppStateI<dynamic>, dynamic> _store;

  const StoreProvider({
    Key? key,
    required Store<AppStateI<dynamic>, dynamic> store,
    required Widget child,
  })   : _store = store,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(StoreProvider oldWidget) {
    return oldWidget._store != this._store;
  }

  static Store<AppStateI<dynamic>, dynamic> of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StoreProvider>()!._store;
}

extension DStoreContextExtensionMethods on BuildContext {
  Store<AppStateI<dynamic>, dynamic> get store => StoreProvider.of(this);
  dynamic dispatch(Action<dynamic> action) => store.dispatch(action);
  Store<S, dynamic> storeTyped<S extends AppStateI<S>>() =>
      store as Store<S, dynamic>;
}
