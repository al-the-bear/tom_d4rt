// D4rt micro-benchmark: List operations & higher-order iteration.
//
// Exercises bridged List construction, `add`, indexed access, and the
// closure-taking methods (`map`, `where`, `fold`). This stresses the
// bridge dispatch path (native List methods) plus interpreted-closure
// invocation from inside native iteration.
const int kIterations = 2000;

int compute() {
  var checksum = 0;
  for (var i = 0; i < kIterations; i++) {
    final xs = <int>[];
    for (var j = 0; j < 32; j++) {
      xs.add(j + i);
    }
    final doubled = xs.map((v) => v * 2).where((v) => v % 3 != 0).toList();
    final sum = doubled.fold<int>(0, (a, b) => a + b);
    checksum = (checksum + sum + doubled.length) & 0x7fffffff;
  }
  return checksum;
}

void main() {
  compute();
}
