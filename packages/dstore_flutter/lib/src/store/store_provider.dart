import 'package:dstore/dstore.dart';
import 'package:flutter/material.dart' hide Action;

class StoreProvider extends StatefulWidget {
  final Store<AppStateI<dynamic>, dynamic> store;
  final Widget? loadingPlaceHolder;
  final Widget child;

  const StoreProvider(
      {Key? key,
      required this.store,
      this.loadingPlaceHolder,
      required this.child})
      : super(key: key);
  @override
  _StoreProviderState createState() => _StoreProviderState();
}

class _StoreProviderState extends State<StoreProvider> {
  @override
  void initState() {
    super.initState();
    if (!widget.store.isReady) {
      widget.store.listenForReadyState(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.store.isReady
        ? _StoreProviderInherited(
            store: widget.store,
            child: widget.child,
          )
        : widget.loadingPlaceHolder ??
            Center(
              child: Text("Preparing App Please wait"),
            );
  }

  @override
  void dispose() {
    widget.store.cleanup();
    super.dispose();
  }
}

class _StoreProviderInherited extends InheritedWidget {
  final Store<AppStateI<dynamic>, dynamic> _store;

  const _StoreProviderInherited({
    Key? key,
    required Store<AppStateI<dynamic>, dynamic> store,
    required Widget child,
  })   : _store = store,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_StoreProviderInherited oldWidget) {
    return oldWidget._store != this._store;
  }

  static Store<AppStateI<dynamic>, dynamic> of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_StoreProviderInherited>()!
      ._store;
}

extension DStoreContextExtensionMethods on BuildContext {
  Store<AppStateI<dynamic>, dynamic> get store =>
      _StoreProviderInherited.of(this);
  dynamic dispatch(Action<dynamic> action) => store.dispatch(action);
  Store<S, dynamic> storeTyped<S extends AppStateI<S>>() =>
      store as Store<S, dynamic>;
}
