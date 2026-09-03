import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

dynamic execute(String source, {List<Object?>? args}) {
  final d4rt = D4rt()..setDebug(false);
  return d4rt.execute(
      library: 'package:test/main.dart',
      positionalArgs: args,
      sources: {'package:test/main.dart': source});
}

void main() {
  group('Operator Improvements', () {
    test('I-EXPR-36: Generic constraints validation works. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class NumericContainer<T extends num> {
          T value;
          NumericContainer(this.value);
        }
        
        main() {
          try {
            var container = NumericContainer<String>("invalid");
            return "ERROR: Should have failed";
          } catch (e) {
            return "SUCCESS: Constraint validation works";
          }
        }
      ''';

      final result = execute(code);
      expect(result, contains("SUCCESS"));
    });

    test('I-EXPR-37: Compound assignment operators work for bitwise operations. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          int a = 15;  // 1111 in binary
          int b = 7;   // 0111 in binary
          
          a &= b;      // Should be 7 (0111)
          print("a &= b: \$a");
          
          a = 15;
          a |= 8;      // Should be 15 (1111)
          print("a |= 8: \$a");
          
          a = 15;
          a ^= 8;      // Should be 7 (0111)
          print("a ^= 8: \$a");
          
          a = 8;
          a <<= 2;     // Should be 32
          print("a <<= 2: \$a");
          
          a = 32;
          a >>= 2;     // Should be 8
          print("a >>= 2: \$a");
          
          a = -8;
          a >>>= 2;    // Unsigned right shift
          print("a >>>= 2: \$a");
          
          return "Bitwise compound assignments work";
        }
      ''';

      final result = execute(code);
      expect(result, equals("Bitwise compound assignments work"));
    });

    test('I-EXPR-38: New typed data types work. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        import 'dart:typed_data';
        
        main() {
          // Test Int16List
          var int16list = Int16List(3);
          int16list[0] = 1000;
          int16list[1] = -2000;
          int16list[2] = 3000;
          
          print("Int16List: \${int16list[0]}, \${int16list[1]}, \${int16list[2]}");
          
          // Test Float32List
          var float32list = Float32List(2);
          float32list[0] = 3.14;
          float32list[1] = -2.71;
          
          print("Float32List: \${float32list[0]}, \${float32list[1]}");
          
          return "New typed data types work";
        }
      ''';

      final result = execute(code);
      expect(result, equals("New typed data types work"));
    });

    test('I-EXPR-35: Complex operations with improved features. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        import 'dart:typed_data';
        
        class DataProcessor<T extends num> {
          List<T> data;
          DataProcessor(this.data);
          
          T process(T value) {
            return value;
          }
        }
        
        main() {
          // Test generics with valid types
          var intProcessor = DataProcessor<int>([1, 2, 3]);
          var doubleProcessor = DataProcessor<double>([1.1, 2.2, 3.3]);
          
          // Test typed data with compound assignments
          var buffer = Uint8List(4);
          buffer[0] = 10;
          buffer[0] += 5;  // Should be 15
          
          print("Buffer[0] after compound assignment: \${buffer[0]}");
          
          // Test bitwise operations
          int flags = 0;
          flags |= 1;    // Set bit 0
          flags |= 4;    // Set bit 2
          flags &= ~2;   // Clear bit 1 (if it was set)
          
          print("Flags after bitwise operations: \$flags");
          
          return "Complex operations successful";
        }
      ''';

      final result = execute(code);
      expect(result, equals("Complex operations successful"));
    });
  });

  // FOUND BY SCC10, and not where it was looking. The stdlib member-diff oracle
  // reports a `missingOperators` column, but diverts operators out of the
  // candidate list BEFORE the phase-2 interpreter verification that every other
  // column goes through — so the column had never been checked against the
  // interpreter and was assumed to be noise. Probing it found `bool` listed
  // alongside obvious false positives like `int <` and `String +`, and `bool`
  // turned out to be real: `&`, `|` and `^` were unimplemented for booleans
  // while the same three worked for `int` (see 'Bitwise operators' above).
  //
  // These are not exotic. `a & b` is the non-short-circuiting sibling of
  // `a && b`, which is exactly what you want when both operands have side
  // effects that must both happen — the one case `&&` cannot express.
  group('bool bitwise operators', () {
    test('F-SCC10-13: & is logical AND over booleans [2026-09-04]', () {
      final result = execute('''
        main() {
          return [true & true, true & false, false & true, false & false];
        }
      ''');
      // The full truth table, not a spot value: an implementation that returned
      // the left operand would pass `true & true` and `false & false`.
      expect(result, equals([true, false, false, false]));
    });

    test('F-SCC10-14: | is logical OR over booleans [2026-09-04]', () {
      final result = execute('''
        main() {
          return [true | true, true | false, false | true, false | false];
        }
      ''');
      expect(result, equals([true, true, true, false]));
    });

    test('F-SCC10-15: ^ is logical XOR over booleans [2026-09-04]', () {
      final result = execute('''
        main() {
          return [true ^ true, true ^ false, false ^ true, false ^ false];
        }
      ''');
      // XOR is the one of the three that cannot be mistaken for AND or OR on any
      // row, so it is the case that proves the three are separately implemented.
      expect(result, equals([false, true, true, false]));
    });

    test('F-SCC10-16: & and | do NOT short-circuit [2026-09-04]', () {
      // This is the entire reason these operators exist rather than being
      // spelled `&&` / `||`. An implementation that forwarded to the logical
      // operators would pass every truth-table case above and fail here.
      final result = execute('''
        main() {
          var calls = 0;
          bool sideEffect(bool value) { calls++; return value; }
          final a = false & sideEffect(true);
          final afterAnd = calls;
          final b = true | sideEffect(false);
          return [a, afterAnd, b, calls];
        }
      ''');
      expect(result, equals([false, 1, true, 2]),
          reason: 'the right operand must be evaluated even when the left '
              'already determines the result');
    });

    test('F-SCC10-17: the compound forms &= |= ^= assign [2026-09-04]', () {
      final result = execute('''
        main() {
          bool a = true;  a &= false;
          bool b = false; b |= true;
          bool c = true;  c ^= true;
          return [a, b, c];
        }
      ''');
      // These failed with a different error than the binary forms
      // ("Compound assignment operator AMPERSAND_EQ" vs "Unsupported binary
      // operator AMPERSAND"), so they are a separate code path and need their
      // own case rather than being assumed to follow.
      expect(result, equals([false, true, false]));
    });

    test('F-SCC10-18: a non-bool operand is still rejected [2026-09-04]', () {
      // The fix must not widen into "anything goes". `true & 1` is a type error
      // in Dart and has to stay one here, or a script that passes under d4rt
      // stops being compilable Dart.
      expect(
        () => execute('main() { return true & 1; }'),
        throwsA(anything),
        reason: 'mixing bool and int operands is not valid Dart',
      );
    });
  });
}
