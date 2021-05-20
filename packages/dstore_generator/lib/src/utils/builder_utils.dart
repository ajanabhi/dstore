import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';

abstract class DBuilderOptions {
  static late PStateGeneratorBuildOptions psBuilderOptions;
}

enum PersistMode { ExplicitPersist, ExplicitDontPersist }

class PStateGeneratorBuildOptions {
  final PersistMode? persistMode;
  final List<String> nonConstClassesWithDefaultValues;

  PStateGeneratorBuildOptions(
      {this.persistMode, required this.nonConstClassesWithDefaultValues});

  @override
  String toString() => "PStateGeneratorBuildOptions(persitMode: $persistMode)";

  static void fromOptions(Map<String, dynamic> config) {
    try {
      PersistMode? persistMode;
      final pms = config["persistMode"] as String?;
      if (pms != null) {
        if (pms != "ExplicitPersist" && pms != "ExplicitDontPersist") {
          throw ArgumentError.value(
              "You should provide persistMode one of two options ExplicitPersist or ExplicitNoPersist");
        }
        persistMode = convertStringToEnum(pms, PersistMode.values);
      }
      final nonConstClassesWithDefaultValues =
          (config["nonConstClassesWithDefaultValues"] as List<dynamic>?)
                  ?.map((dynamic e) => e as String)
                  .toList() ??
              ["DateTime", "FormField"];
      final options = PStateGeneratorBuildOptions(
          persistMode: persistMode,
          nonConstClassesWithDefaultValues: nonConstClassesWithDefaultValues);
      logger.shout("PS Builder options $options");
      DBuilderOptions.psBuilderOptions = options;
    } catch (e, st) {
      logger.error("Error parsing dstore_generator:ps builder options", e, st);
      rethrow;
    }
  }
}
