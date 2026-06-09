// D4rt micro-benchmark: string interpolation & concatenation.
//
// Exercises StringInterpolation node evaluation, implicit toString on
// mixed operands and string `+`. String building is a common real-world
// hot path and stresses the interpreter's literal/interpolation handling
// plus the bridged String methods.
const int kIterations = 20000;

int compute() {
  var total = 0;
  for (var i = 0; i < kIterations; i++) {
    final s = 'item-$i:${i * 2}/${i % 7}';
    final t = s + '|' + (i.isEven ? 'even' : 'odd');
    total = total + t.length;
  }
  return total;
}

void main() {
  compute();
}
