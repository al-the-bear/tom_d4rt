// D4rt micro-benchmark: closure creation, capture and invocation.
//
// Exercises FunctionExpression evaluation, captured-variable environments
// and repeated InterpretedFunction invocation. Closures are central to the
// interpreter's environment model, so this surfaces the cost of creating
// and entering closure scopes.
const int kIterations = 20000;

Function makeAdder(int base) {
  var calls = 0;
  return (int v) {
    calls = calls + 1;
    return base + v + calls;
  };
}

int compute() {
  var checksum = 0;
  final adder = makeAdder(10);
  for (var i = 0; i < kIterations; i++) {
    // Fresh closure each iteration to also measure creation cost.
    final f = (int v) => v * 2 + i;
    checksum = (checksum + (adder(i) as int) + (f(i) as int)) & 0x7fffffff;
  }
  return checksum;
}

void main() {
  compute();
}
