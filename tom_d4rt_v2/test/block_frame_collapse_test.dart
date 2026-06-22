/// S4 (perf, particle-field freeze §"Remaining work" step 1): a `Block` that
/// introduces no name bindings of its own runs its statements directly in the
/// enclosing `Environment` instead of allocating a fresh child frame. This
/// halves `Environment` allocation in the hot path (e.g. a Flutter `build`
/// body re-run every frame, whose outermost block usually declares nothing
/// before delegating to nested builders).
///
/// These tests pin the *observable* contract the collapse must preserve:
///   - writes inside a collapsed block hit the enclosing frame (no shadow);
///   - a closure created inside a collapsed block captures the enclosing
///     binding, so later mutation is visible through it;
///   - sibling blocks that DO declare a local still get isolated frames
///     (shadowing is not leaked across the collapse);
///   - labelled break/continue still flow correctly through collapsed blocks;
///   - the slot fast-path (depth-0 [StaticCoord]) still resolves when the
///     *declaring* block is nested inside a collapsed parent block.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_v2/d4rt.dart';

void main() {
  group('block frame collapse (no-binding blocks)', () {
    test('a bare nested block reassigns the enclosing variable', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
main() {
  int x = 1;
  {
    // no declarations here -> frame collapsed; assignment must hit `x`
    x = x + 41;
  }
  return x;
}
''');
      expect(result, 42);
    });

    test('closure made in a collapsed block captures the outer binding', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
main() {
  int counter = 0;
  late void Function() bump;
  {
    // collapsed block: the closure must close over the SAME `counter`
    bump = () { counter = counter + 1; };
  }
  bump();
  bump();
  bump();
  return counter;
}
''');
      expect(result, 3);
    });

    test('sibling block that declares a local does not leak its shadow', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
main() {
  int x = 10;
  {
    int x = 99; // declaring block keeps its own frame
    x = x + 1;  // mutates the inner x only
  }
  {
    x = x + 5; // collapsed block: mutates the OUTER x
  }
  return x;
}
''');
      // inner shadow (99->100) is discarded; outer x: 10 -> 15
      expect(result, 15);
    });

    test('deeply nested no-binding blocks still reach the outer variable', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
main() {
  int total = 0;
  {
    {
      {
        total = total + 7;
      }
    }
  }
  return total;
}
''');
      expect(result, 7);
    });

    test('labelled break flows through a collapsed block', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
main() {
  int hits = 0;
  outer:
  for (int i = 0; i < 5; i = i + 1) {
    {
      // collapsed block wrapping the break
      hits = hits + 1;
      if (i == 2) break outer;
    }
  }
  return hits;
}
''');
      // i = 0,1,2 -> 3 hits then break
      expect(result, 3);
    });

    test('continue flows through a collapsed block', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
main() {
  int sum = 0;
  for (int i = 0; i < 5; i = i + 1) {
    {
      if (i == 2) continue;
      sum = sum + i;
    }
  }
  return sum;
}
''');
      // 0 + 1 + 3 + 4 = 8 (i == 2 skipped)
      expect(result, 8);
    });

    test('slot read resolves when the declaring block is nested in a '
        'collapsed parent', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
main() {
  int acc = 0;
  {
    // collapsed parent (no own declarations)
    {
      int local = 21; // declaring block: keeps its frame + slot
      acc = local + local; // depth-0 slot read of `local`
    }
  }
  return acc;
}
''');
      expect(result, 42);
    });

    test('a local function declaration keeps its block frame', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
main() {
  int call() {
    int helper() => 21; // function decl -> block keeps frame
    return helper() + helper();
  }
  return call();
}
''');
      expect(result, 42);
    });

    test('pattern declaration inside a block keeps its frame', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
main() {
  int sum = 0;
  {
    var (a, b) = (3, 4); // pattern decl -> block keeps frame
    sum = a + b;
  }
  return sum;
}
''');
      expect(result, 7);
    });

    test('repeated execution of a hot collapsed block stays correct', () {
      final d4rt = D4rt();
      // Exercises the per-node cache: the same Block node is visited many
      // times; the collapse decision must be stable and correct each time.
      final result = d4rt.execute(source: '''
int accumulate(int n) {
  int acc = 0;
  for (int i = 0; i < n; i = i + 1) {
    {
      acc = acc + i;
    }
  }
  return acc;
}

main() {
  int last = 0;
  for (int r = 0; r < 100; r = r + 1) {
    last = accumulate(10);
  }
  return last;
}
''');
      // sum 0..9 = 45
      expect(result, 45);
    });
  });
}
