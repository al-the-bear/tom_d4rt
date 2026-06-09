// D4rt micro-benchmark: Map operations.
//
// Exercises bridged Map construction, `[]=`, `[]`, `containsKey`,
// `putIfAbsent` and entry iteration. Maps drive the bridged-operator and
// bridged-method dispatch paths with hashing on the native side.
const int kIterations = 2000;

int compute() {
  var checksum = 0;
  for (var i = 0; i < kIterations; i++) {
    final m = <String, int>{};
    for (var j = 0; j < 24; j++) {
      final k = 'k${j % 8}';
      m[k] = (m[k] ?? 0) + j + i;
    }
    var local = 0;
    for (final e in m.entries) {
      local = local + e.key.length + e.value;
    }
    checksum = (checksum + local + m.length) & 0x7fffffff;
  }
  return checksum;
}

void main() {
  compute();
}
