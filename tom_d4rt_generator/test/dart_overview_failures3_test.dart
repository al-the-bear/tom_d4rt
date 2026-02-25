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
///
/// Note: Isolate support has limitations (Lim-3). Isolate.run() works but
/// uses Future.microtask internally - no true parallelism. The isolate demo
/// is excluded from D4rt tests. See: doc/d4rt_limitations.md and
/// dart_overview/lib/async/isolates/run_isolates_no_d4rt.dart

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
  });
}

/// Helper function to execute D4rt code
Object? _execute(String source) {
  final d4rt = D4rt()..setDebug(false);
  return d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': source},
  );
}
