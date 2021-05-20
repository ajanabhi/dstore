class PState {
  final bool? persist;
  final bool enableHistory;
  final int? historyLimit;
  final bool? nav;
  final bool? navBlockSameUrl;
  final List<String>? nonConstClassesWithDefaultValues;
  const PState(
      {this.persist,
      this.enableHistory = false,
      this.navBlockSameUrl,
      this.historyLimit,
      this.nonConstClassesWithDefaultValues,
      this.nav});
}

class ExcludeThisKeyWhilePersit {
  const ExcludeThisKeyWhilePersit();
}

const excludeThisKeyWhilePersist = ExcludeThisKeyWhilePersit();
