import 'package:dstore/dstore.dart';
import 'package:flutter/material.dart';
import 'package:dstore_flutter/src/store/store_provider.dart';

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
