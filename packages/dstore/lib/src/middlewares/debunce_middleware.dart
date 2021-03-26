import 'dart:async';

import 'package:dstore/src/action.dart';
import 'package:dstore/src/store.dart';

dynamic debounceMiddleware<S extends AppStateI<S>>(
    Store<S> store, Dispatch next, Action<dynamic> action) async {
  if (action.isProcessed || action.debounce == null) {
    next(action);
  } else {
    final duration = action.debounce!;
    final id = action.id;
    if (duration == Duration.zero) {
      // if duration is zero then execute immediatley
      store.internalDebounceTimers[id]?.cancel();
      store.internalDebounceTimers.remove(id);
      next(action);
    } else {
      store.internalDebounceTimers[id]?.cancel();
      store.internalDebounceTimers[id] = Timer(duration, () {
        store.internalDebounceTimers[id]?.cancel();
        store.internalDebounceTimers.remove(id);
        next(action);
      });
    }
  }
}
