// D4rt micro-benchmark: instance method dispatch on interpreted classes.
//
// Exercises InterpretedInstance creation, field access, and (non-virtual)
// instance method resolution + invocation. This isolates the per-call
// overhead of interpreted method dispatch and environment frame setup.
const int kIterations = 20000;

class Accumulator {
  int total = 0;
  int count = 0;

  void add(int v) {
    total = total + v;
    count = count + 1;
  }

  int average() {
    if (count == 0) return 0;
    return total ~/ count;
  }
}

int compute() {
  final acc = Accumulator();
  for (var i = 0; i < kIterations; i++) {
    acc.add(i % 31);
    if (i % 8 == 0) {
      acc.add(acc.average());
    }
  }
  return acc.total + acc.count;
}

void main() {
  compute();
}
