typedef PStatePersitMigratorFn = Map<String, dynamic> Function(
    String oldVersion, Map<String, dynamic> data);

class PState {
  final bool? persist;
  final bool enableHistory;
  final int? historyLimit;
  final bool? nav;
  final bool? navBlockSameUrl;
  final List<String>? nonConstClassesWithDefaultValues;
  final PStatePersitMigratorFn? persitMigrator;
  final String? interMigratorName;
  const PState(
      {this.persist,
      this.enableHistory = false,
      this.navBlockSameUrl,
      this.historyLimit,
      this.persitMigrator,
      this.interMigratorName,
      this.nonConstClassesWithDefaultValues,
      this.nav});
}

class RegularMethod {
  const RegularMethod();
}

class ExcludeThisKeyWhilePersit {
  const ExcludeThisKeyWhilePersit();
}

const excludeThisKeyWhilePersist = ExcludeThisKeyWhilePersit();
