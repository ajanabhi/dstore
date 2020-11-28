abstract class DModel {
  dynamic copyWith();
}

abstract class DModel2 {
  dynamic copyWith2();
}

class DModel1 implements DModel, DModel2 {
  dynamic copyWith() => 3;

  @override
  copyWith2() {
    // TODO: implement copyWith2
    throw UnimplementedError();
  }
}

final DModel d = DModel1();
