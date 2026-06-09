// D4rt micro-benchmark: deep recursive function calls.
//
// Naive recursive Fibonacci generates an exponential number of interpreted
// function calls, each requiring a fresh environment frame and argument
// binding. This is the canonical stress test for call-overhead and frame
// setup/teardown in the interpreter.
const int kIterations = 24; // fib(kIterations)

int fib(int n) {
  if (n < 2) return n;
  return fib(n - 1) + fib(n - 2);
}

int compute() {
  return fib(kIterations);
}

void main() {
  compute();
}
