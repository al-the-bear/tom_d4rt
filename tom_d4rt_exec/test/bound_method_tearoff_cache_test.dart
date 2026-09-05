/// S2 (perf, particle-field freeze §"Remaining work" step 2): a bare method
/// tear-off (`obj.method` without an immediate call) is memoised per
/// `(instance, unbound method)` pair instead of re-minting a fresh bound
/// `InterpretedFunction` on every property access. On a hot per-frame rebuild
/// path that re-mints hundreds of redundant closures, this removes the
/// dominant old-gen garbage source behind the freeze.
///
/// These tests pin the *observable* contract the cache must preserve:
///   - the cached tear-off is still callable and produces the right result;
///   - tear-offs see *live* instance state (no stale captured fields);
///   - Dart tear-off equality holds — `obj.method == obj.method` is true,
///     and distinct instances yield distinct tear-offs;
///   - superclass- and mixin-resolved methods tear off identically;
///   - repeated tear-offs of the same method on the same instance allocate the
///     bound closure only once (the actual perf guarantee, asserted through the
///     [D4rtDiag.closureAllocs] window counter measured from the harness).
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('bound method tear-off cache', () {
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
  // The tear-off was taken BEFORE the mutation; it must still see the new
  // value because it is bound to the instance, not a copy of its fields.
  return fn() + 1;
}
''',
      );
      expect(result, 42);
    });

    test('tear-off is identical for the same instance and method', () {
      final d4rt = D4rt();
      // The cache returns the SAME bound-closure object on repeated access —
      // `identical` is the precise discriminator (pre-cache each access minted
      // a distinct object, so this was false).
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
  // Each instance owns its own cache, so the bound closures are distinct.
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
      // Measure the closure-allocation delta the tear-off LOOP contributes,
      // isolating it from the fixed setup cost (class wiring, `main`, the first
      // legitimate bind). With the cache the loop adds zero closures regardless
      // of iteration count; pre-cache each iteration minted a fresh closure.
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
  var fn = w.step; // first (and only) legitimate bind for this instance
  for (int i = 0; i < $n; i = i + 1) {
    fn = w.step; // must hit the cache
  }
  return fn();
}
''',
        );
        return D4rtDiag.closureAllocs;
      }

      final fewIterations = closuresForLoop(0);
      final manyIterations = closuresForLoop(500);
      // 500 extra tear-offs of an already-bound method add no closures.
      expect(manyIterations, fewIterations);
    });
  });
}
