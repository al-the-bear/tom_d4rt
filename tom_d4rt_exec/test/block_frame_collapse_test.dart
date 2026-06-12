/// Mirror of `tom_d4rt/test/block_frame_collapse_test.dart` for the
/// analyzer-free interpreter (`tom_d4rt_ast` driven through `tom_d4rt_exec`,
/// which parses source via the analyzer + AST generator and hands the mirror
/// `SAstNode` tree to the interpreter).
///
/// S4 (perf, particle-field freeze §"Remaining work" step 1): a `Block` that
/// introduces no name bindings runs its statements directly in the enclosing
/// `Environment` instead of allocating a fresh child frame. These tests pin
/// the observable contract the collapse must preserve — writes hit the
/// enclosing frame, closures capture the enclosing binding, declaring blocks
/// stay isolated, labelled break/continue still flow, and the slot fast-path
/// resolves when the declaring block is nested in a collapsed parent.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('block frame collapse (no-binding blocks) [ast]', () {
    test('a bare nested block reassigns the enclosing variable', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
main() {
  int x = 1;
  {
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
    int x = 99;
    x = x + 1;
  }
  {
    x = x + 5;
  }
  return x;
}
''');
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
      hits = hits + 1;
      if (i == 2) break outer;
    }
  }
  return hits;
}
''');
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
      expect(result, 8);
    });

    test('slot read resolves when the declaring block is nested in a '
        'collapsed parent', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: '''
main() {
  int acc = 0;
  {
    {
      int local = 21;
      acc = local + local;
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
    int helper() => 21;
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
    var (a, b) = (3, 4);
    sum = a + b;
  }
  return sum;
}
''');
      expect(result, 7);
    });

    test('repeated execution of a hot collapsed block stays correct', () {
      final d4rt = D4rt();
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
      expect(result, 45);
    });
  });
}
