import 'dart:async';

import 'package:dstore/src/action.dart';
import 'package:dstore/src/http.dart';
import 'package:dstore/src/pstate.dart';
import 'package:dstore/src/store.dart';
import 'package:test/test.dart';

extension on Map {
  bool identicalMembers(Map other) {
    return this.entries.every((me) => identical(me.value, other[me.key]));
  }
}

class StoreTester<S extends AppStateI> {
  final Store<S, dynamic> store;

  StoreTester(this.store);

  Future<void> testAction<M extends ToMap>(Action<M> action, M result) async {
    final before = store.getPStateModelFromAction(action);
    store.dispatch(action);
    if (action.isAsync || action.http != null) {
      await waitForAction(action);
    }
    final after = store.getPStateModelFromAction(action);
    expect(identical(before, after), false);
    final mockMap = result.toMap();
    if (mockMap.isEmpty) {
      expect(before, after);
    } else {
      final afterMap = after.toMap();
      final beforeMap = before.toMap();
      mockMap.forEach((key, value) {
        expect(value, afterMap[key]);
        beforeMap.remove(key);
      });
      expect(beforeMap.identicalMembers(afterMap), true);
    }
  }

  Future<void> waitForAction(Action action,
      {Duration? timeout, int interval = 4}) {
    return _createWaitFuture(action, interval, timeout: timeout);
  }

  Future<void> _createWaitFuture(
    Action action,
    int interval, {
    Duration? timeout,
  }) async {
    final c = Completer<void>();

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
