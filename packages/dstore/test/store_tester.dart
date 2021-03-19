import 'dart:async';

import 'package:dstore/src/action.dart';
import 'package:dstore/src/http.dart';
import 'package:dstore/src/pstate.dart';
import 'package:dstore/src/store.dart';
import 'package:dstore/src/types.dart';
import 'package:dstore/src/stream.dart';
import 'package:test/test.dart';

extension on Map<dynamic, dynamic> {
  bool identicalMembers(Map<dynamic, dynamic> other) {
    return this.entries.every((me) => identical(me.value, other[me.key]));
  }
}

class StoreTester<S extends AppStateI<S>> {
  final Store<S, dynamic> store;

  StoreTester(this.store);

  void testAction<M extends ToMap>(Action<M> action, M result) {
    final before = store.getPStateModelFromAction(action);
    store.dispatch(action);
    final after = store.getPStateModelFromAction(action);
    expect(identical(before, after), false);
    final mockMap = result.toMap();
    if (mockMap.isEmpty) {
      expect(before, after);
    } else {
      final afterMap = after.toMap();
      final beforeMap = before.toMap();
      mockMap.forEach((key, dynamic value) {
        expect(value, afterMap[key]);
        beforeMap.remove(key);
      });
      expect(beforeMap.identicalMembers(afterMap), true);
    }
  }

  Future<void> testAsyncAction<M extends ToMap>(Action<M> action, M result,
      {Duration? timeout, int interval = 4}) async {
    assert(action.isAsync == true);
    final before = store.getPStateModelFromAction(action);
    store.dispatch(action);
    if (action.isAsync) {
      await waitForAction(action, timeout: timeout, interval: interval);
    }
    final after = store.getPStateModelFromAction(action);
    expect(identical(before, after), false);
    final mockMap = result.toMap();
    if (mockMap.isEmpty) {
      expect(before, after);
    } else {
      final afterMap = after.toMap();
      final beforeMap = before.toMap();
      mockMap.forEach((key, dynamic value) {
        expect(value, afterMap[key]);
        beforeMap.remove(key);
      });
      if (action.isAsync) {
        beforeMap.remove(action.name);
      }
      expect(beforeMap.identicalMembers(afterMap), true);
    }
  }

  Future<void> testStreamAction<M extends Iterable<dynamic>>(
      Action<M> action, M result) async {
    assert(action.stream != null);
    final before = store.getPStateModelFromAction(action);
    store.dispatch(action);
    final resultA = await _waitForStreamAction(action);
    print("resultA $resultA");
    expect(resultA, result);
    final after = store.getPStateModelFromAction(action);
    expect(identical(before, after), false);
    final afterMap = after.toMap();
    final beforeMap = before.toMap();
    beforeMap.remove(action.name);
    if (action.isAsync) {
      beforeMap.remove(action.name);
    }
    expect(beforeMap.identicalMembers(afterMap), true);
  }

  Future<void> waitForAction(Action<dynamic> action,
      {Duration? timeout, int interval = 4}) {
    return _createWaitFuture(action, interval, timeout: timeout);
  }

  Future<void> _createWaitFuture(
    Action<dynamic> action,
    int interval, {
    Duration? timeout,
  }) async {
    final c = Completer<void>();

    var done = false;
    Timer? timeoutTimer;
    final periodicTimer =
        Timer.periodic(Duration(milliseconds: interval), (timer) {
      final dynamic field = store.getFieldFromAction(action);
      if (field is AsyncActionField) {
        // print("its async");
        done = field.completed;
      }
      if (field is HttpField) {
        done = field.completed;
      }
      // print("checking for done : $done");
      if (done) {
        print("adync done");
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

  Future<List<dynamic>> _waitForStreamAction(
    Action action, {
    int interval = 4,
    Duration? timeout,
  }) async {
    final c = Completer<List<dynamic>>();
    final items = <dynamic>[];
    var done = false;
    Timer? timeoutTimer;
    final periodicTimer =
        Timer.periodic(Duration(milliseconds: interval), (timer) {
      final field = store.getFieldFromAction(action) as StreamField;
      print(field);
      if (field.data != null) {
        items.add(field.data);
      }
      done = field.completed;
      if (done) {
        field.internalSubscription?.cancel();
        timer.cancel();
        timeoutTimer?.cancel();
        c.complete(items);
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
