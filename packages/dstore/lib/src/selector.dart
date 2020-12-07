class Selector<S, R> {
  final R Function(S s) fn;
  final Map<String, List<String>> deps;

  const Selector({required this.fn, required this.deps});
}
