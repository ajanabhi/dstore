import 'package:dstore/dstore.dart' as dstore;
import 'package:flutter/material.dart';

class StoreProvider<S extends dstore.AppStateI<S>> extends InheritedWidget {
  final dstore.Store<S, dynamic> _store;

  const StoreProvider({
    Key? key,
    required dstore.Store<S, dynamic> store,
    required Widget child,
  })   : _store = store,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(StoreProvider<S> oldWidget) {
    return oldWidget._store != this._store;
  }

  static dstore.Store<S, dynamic> of<S extends dstore.AppStateI<S>>(
          BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StoreProvider<S>>()!._store;
}

extension DStoreContextExtensionMethods on BuildContext {
  dstore.Store<S, dynamic> store<S extends dstore.AppStateI<S>>() =>
      StoreProvider.of<S>(this);
  dynamic dispatch<S extends dstore.AppStateI<S>>(dstore.Action action) =>
      this.store<S>().dispatch(action);
}

typedef SelectorBuilderFn<I> = Widget Function(BuildContext context, I state);

class SelectorBuilder<S, I, AS extends dstore.AppStateI<AS>>
    extends StatefulWidget {
  final dstore.Selector<S, I> selector;
  final dstore.UnSubscribeOptions? options;
  final SelectorBuilderFn<I> builder;

  const SelectorBuilder(
      {Key? key, required this.selector, required this.builder, this.options})
      : super(key: key);

  @override
  _SelectorBuilderState createState() => _SelectorBuilderState<AS>();
}

class _SelectorBuilderState<AS extends dstore.AppStateI<AS>>
    extends State<SelectorBuilder> {
  late dstore.SelectorUnSubscribeFn _unsubFn;
  dynamic _state;
  void Function()? _lsitener;
  @override
  void initState() {
    super.initState();
    final store = context.store<AS>();
    _lsitener = () {
      _state = widget.selector.fn(store.state);
      setState(
          () {}); // we will call listener only when selectors deps changed, do we need another _state == prev_state check here ?
    };
    _state = widget.selector.fn(store.state);
    _unsubFn = store.subscribeSelector(widget.selector, _lsitener!);
  }

  @override
  void didUpdateWidget(covariant SelectorBuilder<AS, dynamic, AS> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selector != widget.selector) {
      _unSubscribe(oldWidget.options);
      final store = context.store<AS>();
      _unsubFn = store.subscribeSelector(widget.selector, _lsitener!);
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
