/// Mirror of
/// `tom_d4rt/test/cluster_a_top_level_build_resolution_test.dart` for the
/// analyzer-free `tom_d4rt_exec` runner (Cluster A regression — see that
/// file for the rationale).
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Future<Object?> _run(String source) async {
  final d4rt = D4rt();
  final bundle = await d4rt.createBundleFromSource(source);
  return d4rt.executeBundle(bundle);
}

void main() {
  group('Cluster A — top-level function resolution from closure (exec)', () {
    test('top-level fn called directly from main', () async {
      final result = await _run('''
int build(int x) => x * 2;

main() => build(21);
''');
      expect(result, 42);
    });

    test('top-level fn called from a closure passed to another fn', () async {
      final result = await _run('''
int build(int x) => x + 1;

int run(int Function() body) => body();

main() => run(() => build(41));
''');
      expect(result, 42);
    });

    test(
      'top-level fn called from a default-callback closure argument',
      () async {
        final result = await _run('''
int build(int x) => x * 3;

int apply({required int Function(int) cb, required int seed}) => cb(seed);

main() => apply(cb: (n) => build(n), seed: 14);
''');
        expect(result, 42);
      },
    );

    test(
      'runApp-style entry point: top-level build(ctx) invoked by harness',
      () async {
        final result = await _run('''
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
      },
    );

    test('top-level fn shadowed by local var inside closure does not poison '
        'sibling closures', () async {
      final result = await _run('''
int build(int x) => x + 10;

int twoClosures() {
  final shadow = () {
    final build = 100;
    return build;
  };
  final clean = () => build(32);
  return shadow() + clean();
}

main() => twoClosures();
''');
      expect(result, 142);
    });
  });
}
