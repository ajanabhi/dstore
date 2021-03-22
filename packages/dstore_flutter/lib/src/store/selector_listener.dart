import 'package:dstore/dstore.dart';
import 'package:flutter/material.dart';
import 'package:dstore_flutter/src/store/store_provider.dart';

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
