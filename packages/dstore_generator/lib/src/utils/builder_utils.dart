import 'package:dstore_annotation/dstore_annotation.dart';
import 'package:dstore_generator/src/utils/utils.dart';

abstract class DBuilderOptions {
  static late PStateGeneratorBuildOptions psBuilderOptions;
}

enum PersistMode { ExplicitPersist, ExplicitNoPersist }

class PStateGeneratorBuildOptions {
  final PersistMode? persistMode;

  PStateGeneratorBuildOptions({this.persistMode});

  static void fromOptions(Map<String, dynamic> config) {
    try {
      PersistMode? persistMode;
      final pms = config["persistMode"];
      if (pms != null) {
        if (pms != "ExplicitPersist" && pms != "ExplicitNoPersist") {
          throw ArgumentError.value(
              "You should provide persistMode one of two options ExplicitPersist or ExplicitNoPersist");
        }
        persistMode = convertStringToEnum(pms, PersistMode.values);
      }
      final options = PStateGeneratorBuildOptions(persistMode: persistMode);
      DBuilderOptions.psBuilderOptions = options;
    } catch (e, st) {
      logger.error("Error parsing dstore_generator:ps builder options", e, st);
      rethrow;
    }
  }
}
