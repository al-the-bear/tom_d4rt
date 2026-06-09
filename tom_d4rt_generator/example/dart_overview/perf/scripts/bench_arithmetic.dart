// D4rt micro-benchmark: arithmetic & binary-operator evaluation.
//
// Exercises BinaryExpression evaluation, int/double promotion, local
// variable read/write and the for-loop driver in the interpreter. No
// allocation, no method dispatch — this is the purest "hot expression
// loop" workload, so it isolates the cost of expression evaluation and
// environment variable lookup.
//
// `kIterations` is rewritten by the perf harness to scale the work.
// `compute()` returns a checksum the harness verifies for stability.
const int kIterations = 50000;

int compute() {
  var acc = 0;
  var x = 7;
  var y = 3;
  for (var i = 0; i < kIterations; i++) {
    acc = acc + (x * y) - (i ~/ 4) + (i % 5);
    x = (x + 1) & 0x3ff;
    y = (y * 2 + 1) % 97;
    acc = acc ^ (i << 1);
  }
  return acc;
}

void main() {
  compute();
}
