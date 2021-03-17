import 'dart:async';

import 'package:dstore/src/action.dart';
import 'package:dstore/src/http.dart';
import 'package:dstore/src/pstate.dart';
import 'package:dstore/src/store.dart';

class StoreTester<S extends AppStateI> {
  final Store<S> store;

  StoreTester(this.store);

  Future<void> waitForAction(Action action,
      {Duration? timeout, int interval = 4}) {
    return _createWaitFuture(action, interval, timeout: timeout);
  }

  Future<void> _createWaitFuture(
    Action action,
    int interval, {
    Duration? timeout,
  }) async {
    final c = Completer();

    var done = false;
    Timer? timeoutTimer;
    final periodicTimer =
        Timer.periodic(Duration(milliseconds: interval), (timer) {
      final field = store.getFieldFromAction(action);
      if (field is AsyncActionField) {
        print("its async");
        print(field);
        done = field.completed;
      }
      if (field is HttpField) {
        done = field.completed;
      }
      print("checking for done : $done");
      if (done) {
        timer.cancel();
        timeoutTimer?.cancel();
        c.complete(null);
      }
    });
    if (timeout != null) {
      timeoutTimer = Timer(timeout, () {
        periodicTimer.cancel();
        c.completeError(
            TimeoutException("$action exceed specified timeout $timeout"));
      });
    }
    return c.future;
  }
}
