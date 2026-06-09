// D4rt micro-benchmark: virtual dispatch across a class hierarchy.
//
// Exercises dynamic method resolution through inheritance/override chains
// (base class + subclasses), which forces the interpreter's method-lookup
// walk up the superclass chain on every call. Complements
// bench_method_dispatch (flat, single class) by adding override resolution.
const int kIterations = 20000;

abstract class Shape {
  int sides();
  int score(int seed) => sides() * 3 + seed % sides();
}

class Triangle extends Shape {
  @override
  int sides() => 3;
}

class Square extends Shape {
  @override
  int sides() => 4;
  @override
  int score(int seed) => super.score(seed) + 1;
}

class Hexagon extends Shape {
  @override
  int sides() => 6;
}

int compute() {
  final shapes = <Shape>[Triangle(), Square(), Hexagon()];
  var checksum = 0;
  for (var i = 0; i < kIterations; i++) {
    final s = shapes[i % 3];
    checksum = (checksum + s.score(i)) & 0x7fffffff;
  }
  return checksum;
}

void main() {
  compute();
}
