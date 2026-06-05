/// Integration test for the P&R#1 usage log (sub-step c): drive a real script
/// through [D4rt.execute] with logging enabled and assert the instrumentation
/// fires and the end-of-run summary reflects it.
///
/// This exercises the `ctor` instrumentation site in the interpreter's
/// generic-constructor path (RC-2): when `Box<int>(...)` resolves to a
/// registered [D4.registerGenericConstructor] factory and the factory returns
/// a native object, the interpreter records a `ctor|Box|...` hit.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A native generic class whose construction goes through the generic
/// constructor factory path.
class _UsageBox<T> {
  _UsageBox(this.value);
  final T value;
}

void main() {
  group('D4rt.execute with usage logging enabled', () {
    setUp(() {
      D4.usageLogEnabled = true;
      D4.resetUsageLog();
    });
    tearDown(() {
      D4.usageLogEnabled = false;
      D4.resetUsageLog();
    });

    test('generic-constructor construction records a ctor hit', () {
      final interpreter = D4rt();

      final boxDefinition = BridgedClass(
        nativeType: _UsageBox,
        name: 'Box',
        constructors: {
          // Plain (non-generic) fallback constructor.
          '': (InterpreterVisitor visitor, List<Object?> positionalArgs,
                  Map<String, Object?> namedArgs) =>
              _UsageBox<Object?>(positionalArgs.isEmpty ? null : positionalArgs[0]),
        },
        getters: {
          'value': (InterpreterVisitor? visitor, Object target) =>
              (target as _UsageBox).value,
        },
      );
      interpreter.registerBridgedClass(
          boxDefinition, 'package:test/usage_box.dart');

      // RC-2: register the generic constructor factory the interpreter
      // consults when the construction carries type arguments.
      D4.registerGenericConstructor(
        'Box',
        '',
        (visitor, positionalArgs, namedArgs, typeArgs) =>
            _UsageBox<Object?>(positionalArgs.isEmpty ? null : positionalArgs[0]),
      );

      const source = '''
        import 'package:test/usage_box.dart';
        int main() {
          final b = Box<int>(42);
          return b.value as int;
        }
      ''';

      final result = interpreter.execute(source: source);
      expect(result, 42);

      // The ctor instrumentation must have recorded a hit for the Box ctor.
      expect(D4.usageHitCount, greaterThan(0));
      final ctorKeys =
          D4.usageHits.keys.where((k) => k.startsWith('ctor|Box|'));
      expect(ctorKeys, isNotEmpty,
          reason: 'expected a ctor|Box|… hit, got ${D4.usageHits.keys}');

      // The end-of-run summary reflects the recorded hit.
      final summary = D4.usageLogSummary();
      expect(summary, contains('=== D4 relaxer/proxy/ctor usage log ==='));
      expect(summary, contains('ctor|Box|'));
    });
  });
}
