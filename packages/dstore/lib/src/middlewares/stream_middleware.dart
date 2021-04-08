import 'package:dstore/src/action.dart';
import 'package:dstore/src/errors.dart';
import 'package:dstore/src/store.dart';
import 'package:dstore/src/stream.dart';
import 'package:dstore/src/types.dart';

dynamic streamMiddleware<S extends AppStateI<S>>(
    Store<S> store, Dispatch next, Action<dynamic> action) async {
  if (action.isProcessed || action.stream == null) {
    next(action);
  } else {
    final field = store.getFieldFromAction(action) as StreamField;
    if (field.listening) {
      //  already listening
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true, type: ActionInternalType.FIELD, data: field)));
    } else {
      final stream = action.stream!.stream;
      final cancelOnError = action.stream!.cancelOnError;
      final sub = stream.listen(
          (dynamic event) {
            final field = store.getFieldFromAction(action) as StreamField;
            store.dispatch(action.copyWith(
                internal: ActionInternal(
              processed: true,
              data: field.copyWith(
                  data: event, firstEventArrived: true, error: null),
              type: ActionInternalType.FIELD,
            )));
          },
          cancelOnError: cancelOnError,
          onError: (dynamic e) {
            final field = store.getFieldFromAction(action) as StreamField;
            store.dispatch(action.copyWith(
                internal: ActionInternal(
              processed: true,
              data: field.copyWith(
                  error: Optional<dynamic>(e),
                  completed: cancelOnError ? true : false),
              type: ActionInternalType.FIELD,
            )));
          },
          onDone: () {
            final field = store.getFieldFromAction(action) as StreamField;
            store.dispatch(action.copyWith(
                internal: ActionInternal(
              processed: true,
              data: field.copyWith(listening: false, completed: true),
              type: ActionInternalType.FIELD,
            )));
          });
      store.dispatch(action.copyWith(
          internal: ActionInternal(
              processed: true,
              type: ActionInternalType.FIELD,
              data:
                  field.copyWith(internalSubscription: sub, listening: true))));
    }
  }
}
