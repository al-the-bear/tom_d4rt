// Tests that the hand-written D4UserBridge overrides actually drive script
// behaviour. Each test interprets a small D4rt program against the generated
// bridges (which the generator wove the overrides into) and asserts on the
// returned value — so a regression in any override, or in the generator's
// weaving of overrides, fails here.

import 'package:d4rt_userbridges_sample/dartscript.b.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:test/test.dart';

const _import =
    "import 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart';";

/// Interpret [body] as the contents of `main()` and return its value.
Object? run(String body) {
  final d4rt = D4rt();
  UserBridgesSampleBridges.register(d4rt);
  return d4rt.execute(source: '''
$_import
Object? main(List<String> args) {
$body
}
''', positionalArgs: const [<String>[]]);
}

void main() {
  group('Money operator overrides', () {
    test('operator+ adds amounts', () {
      expect(run('return (Money(1000) + Money(250)).cents;'), 1250);
    });

    test('operator- subtracts amounts (binary)', () {
      expect(run('return (Money(1000) - Money(250)).cents;'), 750);
    });

    test('operator- negates amount (unary)', () {
      expect(run('return (-Money(1000)).cents;'), -1000);
    });

    test('operator* scales amount', () {
      expect(run('return (Money(1000) * 3).cents;'), 3000);
    });
  });

  group('Money method override', () {
    test('format() uses accounting parentheses for negatives', () {
      expect(run("return Money(-500).format();"), '(USD 5.00)');
    });

    test('format() leaves positives unparenthesised', () {
      expect(run("return Money(999).format();"), 'USD 9.99');
    });

    test('generated members coexist with overrides', () {
      // majorUnits/isNegative are auto-generated, format() is overridden.
      expect(run('return Money(2550).majorUnits;'), 25.5);
      expect(run('return Money(-1).isNegative;'), true);
    });
  });

  group('Grid composite index operators', () {
    test('operator[]= then operator[] round-trips a [row, col] key', () {
      expect(run('''
final g = Grid(2, 2);
g[[1, 1]] = 42;
return g[[1, 1]];
'''), 42);
    });

    test('generated sum getter reflects user-bridge writes', () {
      expect(run('''
final g = Grid(2, 2);
g[[0, 0]] = 1;
g[[0, 1]] = 2;
g[[1, 0]] = 3;
g[[1, 1]] = 4;
return g.sum;
'''), 10);
    });
  });

  group('Box generic index operators', () {
    test('stores and reads any element type', () {
      expect(run('''
final b = Box(2);
b[0] = 'hello';
return b[0];
'''), 'hello');
    });

    test('generated isEmpty tracks user-bridge writes', () {
      expect(run('''
final b = Box(1);
final before = b.isEmpty;
b[0] = 1;
return [before, b.isEmpty];
'''), [true, false]);
    });
  });

  group('Globals user bridge', () {
    test('global variable overrides apply', () {
      expect(run('return appName;'), 'ScriptLedger');
      expect(run('return maxItems;'), 100);
    });

    test('global getter override applies', () {
      expect(run('return currentTime.year;'), 2026);
    });

    test('global function overrides apply', () {
      expect(run("return describe('x');"), 'script: x');
      expect(run('return taxCents(1000);'), 100); // 10% default
      expect(run('return taxCents(1000, rate: 0.2);'), 200);
    });
  });
}
