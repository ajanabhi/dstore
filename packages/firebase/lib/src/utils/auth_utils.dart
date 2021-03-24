abstract class AuthUtils {
  String name = "";
  Stream<void> hello() async* {
    yield this.name = "hello";
  }
}
