import 'dart:async';

import 'package:test/test.dart';
import 'package:async/async.dart';

import 'store/app_state.dart';
import 'store/pstates/sample.dart';

void main() {
  group("Sync Actions", () {
    test('Should Change Name', () {
      final newName = "there you go";
      storeTester.testAction(SampleActions.changeName(newName: newName),
          SampleChangeNameResult(name: newName));
    });

    test("should change Age", () {
      storeTester.testAction(
          SampleActions.changeAge(newAge: 2), SampleChangeAgeResult(age: 2));
    });

    test("should add item to list", () {
      storeTester.testAction(SampleActions.addToList(item: "hello"),
          SampleAddToListResult(list: ["hello"]));
    });
  });

  group("Async Actions", () {
    test("should set dark mode", () async {
      await storeTester.testAsyncAction(SampleActions.changeTheme(value: true),
          SampleChangeThemeResult(isDark: true));
    });
  });

  group("Sytream Action", () {
    test('should read stream values', () async {
      await storeTester.testStreamAction(
          SampleActions.intStream(stream: Stream.fromIterable([1, 2])), [1, 2]);
    });
  });
}

Stream<int> genNumbers() async* {
  for (var i = 1; i < 4; i++) {
    yield i;
  }
}

class NumberGenerator {
  final StreamController<int> _controller = StreamController();

  Stream<int> get stream => _controller.stream;

  void add(int i) => _controller.sink.add(i);

  void close() => _controller.sink.close();
}
