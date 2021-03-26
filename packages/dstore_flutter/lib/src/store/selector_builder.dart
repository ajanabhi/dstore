import 'package:dstore/dstore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dstore_flutter/src/store/store_provider.dart';

typedef SelectorBuilderFn<I> = Widget Function(BuildContext context, I state);

class SelectorBuilder<S extends AppStateI<S>, I> extends StatefulWidget {
  final Selector<S, I> selector;
  final UnSubscribeOptions? options;
  final SelectorBuilderFn<I> builder;
  final void Function(BuildContext context, I state)? onInitState;
  final void Function(BuildContext context, I state)? onInitialBuild;
  final void Function(BuildContext context, I state)? onDispose;
  final void Function(BuildContext context, I prevState, I newState)?
      onStateChange;

  const SelectorBuilder(
      {Key? key,
      required this.selector,
      required this.builder,
      this.onInitState,
      this.onInitialBuild,
      this.onDispose,
      this.onStateChange,
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
  Store<S, dynamic>? storeRef;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final store = context.storeTyped<S>();
    if (storeRef != store) {
      if (storeRef != null) {
        _unSubscribe(widget.options);
      }
      _lsitener = () {
        final prevState = _state;
        _state = widget.selector.fn(store.state);
        widget.onStateChange?.call(context, prevState, _state);
        setState(() {});
      };
      _state = widget.selector.fn(store.state);
      _unsubFn = store.subscribeSelector(widget.selector, _lsitener!);
      if (storeRef == null) {
        storeRef = store;
        widget.onInitState?.call(context, _state);
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          widget.onInitialBuild?.call(context, _state);
        });
      } else {
        storeRef = store;
      }
    }
  }

  @override
  void didUpdateWidget(covariant SelectorBuilder<S, I> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selector != widget.selector) {
      _unSubscribe(oldWidget.options);
      final store = context.storeTyped<S>();
      _unsubFn = store.subscribeSelector(widget.selector, _lsitener!);
      _state = widget.selector.fn(store.state);
    }
  }

  void _unSubscribe(UnSubscribeOptions? options) {
    _unsubFn(options);
  }

  @override
  void dispose() async {
    widget.onDispose?.call(context, _state);
    _unSubscribe(widget.options);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _state);
  }
}

void hello() {
  if (kDebugMode) {}
}
