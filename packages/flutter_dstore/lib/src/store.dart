import 'package:dstore/dstore.dart' as dstore;
import 'package:flutter/material.dart';

class StoreProvider<S extends dstore.AppStateI> extends InheritedWidget {
  final dstore.Store<S> _store;

  const StoreProvider({
    Key? key,
    required dstore.Store<S> store,
    required Widget child,
  })   : _store = store,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(StoreProvider<S> oldWidget) {
    return oldWidget._store != this._store;
  }

  static dstore.Store<S> of<S extends dstore.AppStateI>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StoreProvider<S>>()!._store;
}

extension DStoreContextExtensionMethods on BuildContext {
  dstore.Store<S> store<S extends dstore.AppStateI>() =>
      StoreProvider.of<S>(this);
  dynamic dispatch(dstore.Action action) => this.store().dispatch(action);
}

typedef SelectorBuilderFn<I> = Widget Function(BuildContext context, I state);

class SelectorBuilder<S, I> extends StatefulWidget {
  final dstore.Selector<S, I> selector;
  final dstore.UnSubscribeOptions? options;
  final SelectorBuilderFn<I> builder;

  const SelectorBuilder(
      {Key? key, required this.selector, required this.builder, this.options})
      : super(key: key);

  @override
  _SelectorBuilderState createState() => _SelectorBuilderState();
}

class _SelectorBuilderState extends State<SelectorBuilder> {
  late dstore.SelectorUnSubscribeFn _unsubFn;
  dynamic _state;
  dynamic _lsitener;
  @override
  void initState() {
    super.initState();
    final store = context.store();
    _lsitener = () {
      _state = widget.selector.fn(store.state);
      setState(() {});
    };
    _state = widget.selector.fn(store.state);
    _unsubFn = store.subscribeSelector(widget.selector, _lsitener);
  }

  @override
  void didUpdateWidget(
      covariant SelectorBuilder<dstore.AppStateI, dynamic> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selector != widget.selector) {
      _unSubscribe(oldWidget.options);
      final store = context.store();
      _unsubFn = store.subscribeSelector(widget.selector, _lsitener);
      _state = widget.selector.fn(store.state);
    }
  }

  void _unSubscribe(dstore.UnSubscribeOptions? options) {
    _unsubFn(options);
  }

  @override
  void dispose() {
    _unSubscribe(widget.options);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _state);
  }
}
