/// Dart Overview Failures Round 3 - Tests for remaining interpreter bugs
///
/// These tests isolate failures found in the dart_overview example after
/// fixing G-DOV and G-DOV2 bugs. Each test targets a specific interpreter
/// feature that is not working correctly.
///
/// ## Test Index
///
/// | Test ID  | Category         | Description                                       |
/// |----------|------------------|---------------------------------------------------|
/// | G-DOV3-1 | extension_types  | Extension type getter access                      |
/// | G-DOV3-2 | isolates         | Isolate.run with closure (unsendable state)       |

import 'package:test/test.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

void main() {
  group('Dart Overview Failures Round 3', () {
    // =========================================================================
    // 1. EXTENSION TYPES (Dart 3.3+) - Getter Access
    // =========================================================================
    // Error: Function 'isValid' takes no arguments, but arguments were provided.
    // File: extensions/basics/run_basics.dart:121
    //
    // Extension types are a Dart 3.3 feature. D4rt parses them but doesn't
    // correctly handle getter access - it treats getters as function calls.
    test('G-DOV3-1: Extension type getter access [2026-02-10] (FAIL)', () {
      const source = '''
extension type UserId(int value) {
  bool get isValid => value > 0;
}

void main() {
  var userId = UserId(123);
  print('UserId: \${userId.value}');
  print('UserId.isValid: \${userId.isValid}');
}
''';
      expect(() => _execute(source), returnsNormally);
    });

    // =========================================================================
    // 2. ISOLATE.RUN WITH CLOSURE
    // =========================================================================
    // Error: Illegal argument in isolate message: object is unsendable
    // File: async/isolates/run_isolates.dart:17-24
    //
    // Isolate.run() cannot pass closures that capture the InterpreterVisitor
    // because it contains unsendable objects like _AsyncCompleter. The closure
    // passed to Isolate.run captures too much interpreter state.
    test('G-DOV3-2: Isolate.run with closure [2026-02-10] (FAIL)', () async {
      const source = '''
import 'dart:isolate';

Future<int> main() async {
  var result = await Isolate.run(() {
    var sum = 0;
    for (var i = 1; i <= 100; i++) {
      sum += i;
    }
    return sum;
  });
  return result;
}
''';
      final result = _execute(source, grantIsolate: true);
      if (result is Future) {
        final resolved = await result;
        expect(resolved, equals(5050)); // Sum of 1..100
      } else {
        expect(result, equals(5050));
      }
    });
  });
}

/// Helper function to execute D4rt code
Object? _execute(String source, {bool grantIsolate = false}) {
  final d4rt = D4rt()..setDebug(false);
  if (grantIsolate) {
    d4rt.grant(IsolatePermission.any);
  }
  return d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': source},
  );
}
