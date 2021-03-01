import 'package:test/test.dart';

import 'source/models.dart';

void main() {
  group("DImmutable", () {
    test(
        "should generate immutable class for abstract class with @DImmutableAnnotation",
        () {
      final h = Hello(name2: "dude");
      expect(h.name2, "dude");
    });
  });
}
