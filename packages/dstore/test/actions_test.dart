import 'package:test/test.dart';

import 'store/app_state.dart';
import 'store/pstates/sample.dart';

void main() {
  group("Sync Actions", () {
    test('Should Change Name', () {
      final newName = "there you go";
      storeTester.testAction(SampleActions.changeName(newName: newName),
          SampleChangeNameMock(name: newName));
    });

    test("should change Age", () {
      storeTester.testAction(
          SampleActions.changeAge(newAge: 2), SampleChangeAgeMock(age: 2));
    });

    test("should add item to list", () {
      storeTester.testAction(SampleActions.addToList(item: "hello"),
          SampleAddToListMock(list: ["hello"]));
    });
  });

  group("Async Actions", () {
    test("should set dark mode", () async {
      await storeTester.testAsyncAction(SampleActions.changeTheme(value: true),
          SampleChangeThemeMock(isDark: true));
    });
  });
}
