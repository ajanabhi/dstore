class PState {
  final bool? persist;
  final bool enableHistory;
  final int? historyLimit;
  final bool? nav;
  const PState(
      {this.persist, this.enableHistory = false, this.historyLimit, this.nav});
}

class ExcludeThisKeyWhilePersit {
  const ExcludeThisKeyWhilePersit();
}

const excludeThisKeyWhilePersist = ExcludeThisKeyWhilePersit();
