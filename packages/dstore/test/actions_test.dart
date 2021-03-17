import 'package:test/test.dart';

import 'store/app_state.dart';
import 'store/pstates/sample.dart';

void main() {
  group("Sync Actions", () {
    final store = testStore.store;
    String _getName() => store.state.sample.name;
    final newName = "there you go";
    test('Should Change Name', () {
      expect(_getName(), "hello");
      store.dispatch(SampleActions.changeName(newName: newName));
      expect(_getName(), newName);
    });

    test("should change Age", () {
      int _getAge() => store.state.sample.age;
      expect(_getAge(), 0);
      store.dispatch(SampleActions.changeAge(newAge: 2));
      expect(_getAge(), 2);
      expect(_getName(), newName);
    });
  });
}
