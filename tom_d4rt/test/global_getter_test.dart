/// Tests for global getter lazy evaluation support.
library;

/// These tests verify that:
/// - GlobalGetter values are lazily evaluated at access time
/// - Regular global variables are evaluated at registration time
/// - Changes to underlying values are reflected in getter results
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('GlobalGetter Wrapper', () {
    test('GlobalGetter can wrap a function [2026-02-10 06:37]', () {
      var callCount = 0;
      final getter = GlobalGetter(() {
        callCount++;
        return 'value';
      });

      expect(callCount, equals(0), reason: 'Function not called until invoked');
      expect(getter(), equals('value'));
      expect(callCount, equals(1));
    });

    test('GlobalGetter evaluates each time it is called [2026-02-10 06:37]', () {
      var counter = 0;
      final getter = GlobalGetter(() => ++counter);

      expect(getter(), equals(1));
      expect(getter(), equals(2));
      expect(getter(), equals(3));
    });

    test('GlobalGetter can return null [2026-02-10 06:37]', () {
      final getter = GlobalGetter(() => null);
      expect(getter(), isNull);
    });
  });

  group('Environment GlobalGetter Unwrapping', () {
    late Environment environment;

    setUp(() {
      environment = Environment();
    });

    test('Environment.get unwraps GlobalGetter automatically [2026-02-10 06:37]', () {
      var evaluationCount = 0;
      environment.define('lazyValue', GlobalGetter(() {
        evaluationCount++;
        return 'computed';
      }));

      // First access should evaluate the getter
      expect(environment.get('lazyValue'), equals('computed'));
      expect(evaluationCount, equals(1));

      // Second access should evaluate again (not cached)
      expect(environment.get('lazyValue'), equals('computed'));
      expect(evaluationCount, equals(2));
    });

    test('Regular values are returned directly without wrapping [2026-02-10 06:37]', () {
      environment.define('regularValue', 42);
      expect(environment.get('regularValue'), equals(42));
    });

    test('GlobalGetter reflects changes in underlying value [2026-02-10 06:37]', () {
      var mutableValue = 'initial';
      environment.define('dynamicValue', GlobalGetter(() => mutableValue));

      expect(environment.get('dynamicValue'), equals('initial'));

      mutableValue = 'changed';
      expect(environment.get('dynamicValue'), equals('changed'));

      mutableValue = 'final';
      expect(environment.get('dynamicValue'), equals('final'));
    });
  });

  group('D4rt registerGlobalGetter', () {
    late D4rt interpreter;
    // Test library path for registering globals
    const testLib = 'package:test_lib/test_lib.dart';

    setUp(() {
      interpreter = D4rt();
    });

    test('registerGlobalGetter makes getter accessible via import [2026-02-10 06:37]', () {
      var counter = 0;
      interpreter.registerGlobalGetter('counter', () => ++counter, testLib);

      final result1 = interpreter.execute(source: '''
        import '$testLib';
        main() {
          return counter;
        }
      ''');
      expect(result1, equals(1));

      final result2 = interpreter.execute(source: '''
        import '$testLib';
        main() {
          return counter;
        }
      ''');
      expect(result2, equals(2));
    });

    test('registerGlobalGetter evaluates lazily not at registration [2026-02-10 06:37]', () {
      String? lateInitValue;
      interpreter.registerGlobalGetter('lateValue', () => lateInitValue, testLib);

      // At registration time, lateInitValue is null
      // The getter should return null when accessed now
      var result = interpreter.execute(source: '''
        import '$testLib';
        main() {
          return lateValue;
        }
      ''');
      expect(result, isNull);

      // Now set the value
      lateInitValue = 'initialized';

      // Access again - should see the new value
      result = interpreter.execute(source: '''
        import '$testLib';
        main() {
          return lateValue;
        }
      ''');
      expect(result, equals('initialized'));
    });

    test('registerGlobalVariable vs registerGlobalGetter difference [2026-02-10 06:37]', () {
      var mutableSource = 'initial';

      // Regular variable captures value at registration time
      interpreter.registerGlobalVariable('capturedValue', mutableSource, testLib);

      // Getter evaluates at access time
      interpreter.registerGlobalGetter('liveValue', () => mutableSource, testLib);

      // Both should return 'initial' initially
      var result = interpreter.execute(source: '''
        import '$testLib';
        main() {
          return [capturedValue, liveValue];
        }
      ''');
      expect(result, equals(['initial', 'initial']));

      // Change the source
      mutableSource = 'changed';

      // capturedValue should still be 'initial' (captured at registration)
      // liveValue should be 'changed' (evaluated at access)
      result = interpreter.execute(source: '''
        import '$testLib';
        main() {
          return [capturedValue, liveValue];
        }
      ''');
      expect(result, equals(['initial', 'changed']));
    });

    test('getter returning object instance works correctly [2026-02-10 06:37]', () {
      final instanceHolder = _InstanceHolder();
      interpreter.registerGlobalGetter('instance', () => instanceHolder.instance, testLib);

      // Initially instance is null
      var result = interpreter.execute(source: '''
        import '$testLib';
        main() {
          return instance;
        }
      ''');
      expect(result, isNull);

      // Create the instance
      instanceHolder.initialize();

      // Now should return the instance
      result = interpreter.execute(source: '''
        import '$testLib';
        main() {
          return instance;
        }
      ''');
      expect(result, isA<_TestInstance>());
    });
  });

  group('D4rt eval with GlobalGetter', () {
    late D4rt interpreter;
    const testLib = 'package:test_lib/test_lib.dart';

    setUp(() {
      interpreter = D4rt();
    });

    test('eval can access global getters via import [2026-02-10 06:37]', () {
      var timestamp = DateTime(2024, 1, 1);
      interpreter.registerGlobalGetter('currentTime', () => timestamp, testLib);

      // First execute imports the library, making the global available
      interpreter.execute(source: '''
        import '$testLib';
        main() {}
      ''');

      final result = interpreter.eval('currentTime');
      expect(result, equals(DateTime(2024, 1, 1)));

      // Update timestamp
      timestamp = DateTime(2025, 6, 15);
      final result2 = interpreter.eval('currentTime');
      expect(result2, equals(DateTime(2025, 6, 15)));
    });
  });
}

/// Helper class for testing late initialization patterns.
class _InstanceHolder {
  _TestInstance? instance;

  void initialize() {
    instance = _TestInstance();
  }
}

/// Simple test instance class.
class _TestInstance {
  final String id = 'test-instance';
}
