// D4rt micro-benchmark: switch expressions, records & pattern matching.
//
// Exercises switch-expression evaluation, record construction/destructuring
// and relational/constant patterns — the newer language features that have
// dedicated (and historically slower) interpreter visitor paths.
const int kIterations = 20000;

String classify(int n) {
  return switch (n % 6) {
    0 => 'zero',
    1 || 2 => 'low',
    3 => 'mid',
    final v when v > 4 => 'high',
    _ => 'other',
  };
}

int compute() {
  var checksum = 0;
  for (var i = 0; i < kIterations; i++) {
    final (a, b) = (i % 5, i % 7);
    final label = classify(i);
    final score = switch ((a, b)) {
      (0, _) => 1,
      (_, 0) => 2,
      (final x, final y) when x == y => 3,
      _ => 0,
    };
    checksum = (checksum + label.length + score) & 0x7fffffff;
  }
  return checksum;
}

void main() {
  compute();
}
