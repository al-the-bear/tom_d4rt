/// Generates incremental identifiers per element prefix.
class IdGenerator {
  final Map<String, int> _counters = {};

  String nextId(String prefix) {
    final count = (_counters[prefix] ?? 0) + 1;
    _counters[prefix] = count;
    return '${prefix}_$count';
  }
}
