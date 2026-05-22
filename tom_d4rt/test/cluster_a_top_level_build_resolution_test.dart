/// Regression test for Cluster A (`Undefined variable: build`) —
/// confirms the d4rt interpreter resolves a top-level `build` function
/// correctly from a variety of invocation sites.
///
/// Context: the 24 SendTestRunner deep-demo scripts that produced
/// `Undefined variable: build` did so because the scripts had no
/// top-level `build` function (they used `void main() => runApp(...)`
/// instead). Once the scripts were rewritten to expose
/// `dynamic build(BuildContext context) => ...`, they passed without
/// any interpreter change. These tests lock that contract in: top-level
/// function lookup must keep working from
///   (a) a direct top-level call from `main`,
///   (b) inside a closure passed to another function,
///   (c) a closure used as a default-callback argument, and
///   (d) the exact runApp-style entry-point shape used by
///       SendTestRunner (calling a top-level `build(ctx)`).
///
/// If any of these regresses, the suite will fail with
/// `Undefined variable: build` (or similar lookup error), reproducing
/// the original Cluster A symptom in a pure-Dart fixture.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('Cluster A — top-level function resolution from closure', () {
    test('top-level fn called directly from main', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
int build(int x) => x * 2;

main() => build(21);
''');
      expect(result, 42);
    });

    test('top-level fn called from a closure passed to another fn', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
int build(int x) => x + 1;

int run(int Function() body) => body();

main() => run(() => build(41));
''');
      expect(result, 42);
    });

    test('top-level fn called from a default-callback closure argument', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
int build(int x) => x * 3;

int apply({required int Function(int) cb, required int seed}) => cb(seed);

main() => apply(cb: (n) => build(n), seed: 14);
''');
      expect(result, 42);
    });

    test('runApp-style entry point: top-level build(ctx) invoked by harness', () {
      // Mirrors SendTestRunner.send: the harness builds a synthetic
      // `BuildContext` and calls the script's top-level `build(ctx)`
      // function. Here the "harness" is a separate top-level fn
      // (`runHarness`) that locates and invokes `build`.
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
class FakeContext {
  final int seed;
  const FakeContext(this.seed);
}

dynamic build(FakeContext ctx) => ctx.seed * 6;

int runHarness(int seed) {
  final ctx = FakeContext(seed);
  return build(ctx) as int;
}

main() => runHarness(7);
''');
      expect(result, 42);
    });

    test('top-level fn shadowed by local var inside closure does not poison '
        'sibling closures', () {
      // Sanity check: a local that happens to be named `build` inside one
      // closure must not be visible to a sibling closure that calls the
      // top-level `build`. (This is plain Dart scoping; the test makes
      // sure d4rt honours it.)
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
int build(int x) => x + 10;

int twoClosures() {
  final shadow = () {
    final build = 100; // local shadow only in this closure
    return build;
  };
  final clean = () => build(32);
  return shadow() + clean();
}

main() => twoClosures();
''');
      // shadow() == 100, clean() == build(32) == 42, total == 142.
      expect(result, 142);
    });
  });
}
