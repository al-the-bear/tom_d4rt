/// Mirror of `tom_d4rt/test/bound_method_tearoff_cache_test.dart` for the
/// analyzer-free interpreter (`tom_d4rt_ast` driven through `tom_d4rt_exec`,
/// which parses source via the analyzer + AST generator and hands the mirror
/// `SAstNode` tree to the interpreter).
///
/// S2 (perf, particle-field freeze §"Remaining work" step 2): a bare method
/// tear-off (`obj.method` without an immediate call) is memoised per
/// `(instance, unbound method)` pair instead of re-minting a fresh bound
/// `InterpretedFunction` on every property access. These tests pin the
/// observable contract: the tear-off stays callable and sees live state, the
/// same instance/method yields an identical object, distinct instances yield
/// distinct objects, super/mixin methods tear off identically, and repeated
/// tear-offs allocate the bound closure only once.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('bound method tear-off cache [ast]', () {
    test('a cached tear-off is still callable and correct', () {
      final d4rt = D4rt();
      final result = d4rt.execute(
        source: '''
class Greeter {
  String hello() => 'hi';
}
main() {
  final g = Greeter();
  final fn = g.hello;
  return fn();
}
''',
      );
      expect(result, 'hi');
    });

    test('tear-off observes live instance state, not a stale snapshot', () {
      final d4rt = D4rt();
      final result = d4rt.execute(
        source: '''
class Counter {
  int value = 0;
  int read() => value;
}
main() {
  final c = Counter();
  final fn = c.read;
  c.value = 41;
  return fn() + 1;
}
''',
      );
      expect(result, 42);
    });

    test('tear-off is identical for the same instance and method', () {
      final d4rt = D4rt();
      final result = d4rt.execute(
        source: '''
class A {
  void m() {}
}
main() {
  final a = A();
  return identical(a.m, a.m);
}
''',
      );
      expect(result, isTrue);
    });

    test('distinct instances yield distinct tear-off objects', () {
      final d4rt = D4rt();
      final result = d4rt.execute(
        source: '''
class A {
  void m() {}
}
main() {
  final a = A();
  final b = A();
  return identical(a.m, b.m);
}
''',
      );
      expect(result, isFalse);
    });

    test('superclass-resolved method tears off identically', () {
      final d4rt = D4rt();
      final result = d4rt.execute(
        source: '''
class Base {
  int base() => 7;
}
class Derived extends Base {}
main() {
  final d = Derived();
  final same = identical(d.base, d.base);
  return same && d.base() == 7;
}
''',
      );
      expect(result, isTrue);
    });

    test('mixin-resolved method tears off identically', () {
      final d4rt = D4rt();
      final result = d4rt.execute(
        source: '''
mixin M {
  int fromMixin() => 5;
}
class C with M {}
main() {
  final c = C();
  final same = identical(c.fromMixin, c.fromMixin);
  return same && c.fromMixin() == 5;
}
''',
      );
      expect(result, isTrue);
    });

    test('repeated tear-offs of one method allocate the closure only once', () {
      int closuresForLoop(int n) {
        final d4rt = D4rt();
        D4rtDiag.reset();
        d4rt.execute(
          source:
              '''
class Worker {
  int step() => 1;
}
main() {
  final w = Worker();
  var fn = w.step;
  for (int i = 0; i < $n; i = i + 1) {
    fn = w.step;
  }
  return fn();
}
''',
        );
        return D4rtDiag.closureAllocs;
      }

      final fewIterations = closuresForLoop(0);
      final manyIterations = closuresForLoop(500);
      expect(manyIterations, fewIterations);
    });
  });
}
