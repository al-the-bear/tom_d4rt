// D4rt micro-benchmark: try/catch/throw control flow.
//
// Exercises the interpreter's exception machinery: try-block setup, throw
// propagation through interpreted frames and catch-clause matching. Throwing
// is implemented with native Dart exceptions inside the interpreter, so this
// measures that round-trip cost.
const int kIterations = 10000;

int risky(int n) {
  if (n % 4 == 0) {
    throw FormatException('divisible-by-four: $n');
  }
  return n * 2;
}

int compute() {
  var checksum = 0;
  for (var i = 0; i < kIterations; i++) {
    try {
      checksum = (checksum + risky(i)) & 0x7fffffff;
    } on FormatException catch (_) {
      checksum = (checksum + 1) & 0x7fffffff;
    } catch (e) {
      checksum = (checksum + 2) & 0x7fffffff;
    }
  }
  return checksum;
}

void main() {
  compute();
}
