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

typedef SelectorBuilderFn<I> = Widget Function(BuildContext context, I state);

class SelectorBuilder<S extends AppStateI<S>, I> extends StatefulWidget {
  final Selector<S, I> selector;
  final UnSubscribeOptions? options;
  final SelectorBuilderFn<I> builder;
  final void Function(BuildContext context)? onInitState;

  const SelectorBuilder(
      {Key? key,
      required this.selector,
      required this.builder,
      this.onInitState,
      this.options})
      : super(key: key);

  @override
  _SelectorBuilderState<S, I> createState() => _SelectorBuilderState<S, I>();
}

class _SelectorBuilderState<S extends AppStateI<S>, I>
    extends State<SelectorBuilder<S, I>> {
  late SelectorUnSubscribeFn _unsubFn;
  late I _state;
  void Function()? _lsitener;
  @override
  void initState() {
    super.initState();
    final store = context.store<S>();
    _lsitener = () {
      _state = widget.selector.fn(store.state);
      setState(
          () {}); // we will call listener only when selectors deps changed, do we need another _state == prev_state check here ?
    };
    _state = widget.selector.fn(store.state);
    _unsubFn = store.subscribeSelector(widget.selector, _lsitener!);
    widget.onInitState?.call(context);
  }

  @override
  void didUpdateWidget(covariant SelectorBuilder<S, I> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selector != widget.selector) {
      _unSubscribe(oldWidget.options);
      final store = context.store<S>();
      _unsubFn = store.subscribeSelector(widget.selector, _lsitener!);
      _state = widget.selector.fn(store.state);
    }
  }

  void _unSubscribe(UnSubscribeOptions? options) {
    _unsubFn(options);
  }

  @override
  void dispose() async {
    _unSubscribe(widget.options);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _state);
  }
}

class SelectorListener<S extends AppStateI<S>, I> extends StatefulWidget {
  final Selector<S, I> selector;
  final UnSubscribeOptions? options;
  final void Function(BuildContext, I) listener;
  final Widget? child;
  final void Function(BuildContext context)? onInitState;

  const SelectorListener(
      {Key? key,
      required this.selector,
      required this.listener,
      this.child,
      this.onInitState,
      this.options})
      : super(key: key);

  @override
  _SelectorListenerState<S, I> createState() => _SelectorListenerState<S, I>();
}

class _SelectorListenerState<S extends AppStateI<S>, I>
    extends State<SelectorListener<S, I>> {
  late SelectorUnSubscribeFn _unsubFn;
  late I _state;
  void Function()? _lsitener;
  @override
  void initState() {
    super.initState();
    final store = context.store<S>();
    _lsitener = () {
      _state = widget.selector.fn(store.state);
      widget.listener(context, _state);
    };
    _state = widget.selector.fn(store.state);
    _unsubFn = store.subscribeSelector(widget.selector, _lsitener!);
    widget.onInitState?.call(context);
  }

  @override
  void didUpdateWidget(covariant SelectorListener<S, I> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selector != widget.selector) {
      _unSubscribe(oldWidget.options);
      final store = context.store<S>();
      _unsubFn = store.subscribeSelector(widget.selector, _lsitener!);
      _state = widget.selector.fn(store.state);
    }
  }

  void _unSubscribe(UnSubscribeOptions? options) {
    _unsubFn(options);
  }

  @override
  void dispose() async {
    _unSubscribe(widget.options);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child == null ? SizedBox.shrink() : widget.child!;
  }
}
