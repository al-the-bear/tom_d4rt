/// Tests for D4 bridge helper functions.
///
/// These tests verify the D4 static helper class correctly handles:
/// - Int to double promotion (nullable and non-nullable)
/// - List/Map/Set coercion with type promotion
/// - BridgedInstance unwrapping
///
/// Related issues:
/// - "Invalid parameter elevation: expected double?, got int"
/// - Type coercion for widget parameters
import 'package:test/test.dart';
import 'package:tom_d4rt/src/generator/d4.dart';

void main() {
  group('D4.extractBridgedArg - Int to Double Promotion', () {
    test(
      'D4-PROM-01: extractBridgedArg<double> accepts int. [2026-02-28] (PASS)',
      () {
        // Non-nullable double should accept int
        final result = D4.extractBridgedArg<double>(42, 'value');
        expect(result, equals(42.0));
        expect(result, isA<double>());
      },
    );

    test(
      'D4-PROM-02: extractBridgedArg<double> accepts double. [2026-02-28] (PASS)',
      () {
        final result = D4.extractBridgedArg<double>(3.14, 'value');
        expect(result, equals(3.14));
      },
    );

    test(
      'D4-PROM-03: extractBridgedArg<double?> accepts int. [2026-02-28] (PASS)',
      () {
        // BUG: This currently throws "expected double?, got int"
        // The fix should handle nullable types in int→double promotion
        final result = D4.extractBridgedArg<double?>(42, 'elevation');
        expect(result, equals(42.0));
        expect(result, isA<double>());
      },
    );

    test(
      'D4-PROM-04: extractBridgedArg<double?> accepts double. [2026-02-28] (PASS)',
      () {
        final result = D4.extractBridgedArg<double?>(3.14, 'value');
        expect(result, equals(3.14));
      },
    );

    test(
      'D4-PROM-05: extractBridgedArg<double?> with null returns null. [2026-02-28] (PASS)',
      () {
        // extractBridgedArg with nullable type and null value
        // actually returns null, which is valid for nullable types
        final result = D4.extractBridgedArg<double?>(null, 'value');
        expect(result, isNull);
      },
    );

    test(
      'D4-PROM-06: extractBridgedArgOrNull<double> accepts int. [2026-02-28] (PASS)',
      () {
        // extractBridgedArgOrNull calls extractBridgedArg<T> which has T=double
        // So this should work because T == double
        final result = D4.extractBridgedArgOrNull<double>(42, 'value');
        expect(result, equals(42.0));
        expect(result, isA<double>());
      },
    );

    test(
      'D4-PROM-07: extractBridgedArgOrNull<double> returns null for null. [2026-02-28] (PASS)',
      () {
        final result = D4.extractBridgedArgOrNull<double>(null, 'value');
        expect(result, isNull);
      },
    );
  });

  group('D4.extractBridgedArg - Num Type Handling', () {
    test(
      'D4-NUM-01: extractBridgedArg<num> accepts int. [2026-02-28] (PASS)',
      () {
        final result = D4.extractBridgedArg<num>(42, 'value');
        expect(result, equals(42));
        expect(result, isA<num>());
      },
    );

    test(
      'D4-NUM-02: extractBridgedArg<num> accepts double. [2026-02-28] (PASS)',
      () {
        final result = D4.extractBridgedArg<num>(3.14, 'value');
        expect(result, equals(3.14));
        expect(result, isA<num>());
      },
    );

    test(
      'D4-NUM-03: extractBridgedArg<num?> accepts int. [2026-02-28] (PASS)',
      () {
        // Similar bug to double? - nullable num may not work
        final result = D4.extractBridgedArg<num?>(42, 'value');
        expect(result, equals(42));
      },
    );
  });

  group('D4.getOptionalNamedArg - Nullable Double', () {
    test(
      'D4-OPT-01: getOptionalNamedArg<double?> with int value. [2026-02-28] (PASS)',
      () {
        // This is the actual pattern used in generated bridge code:
        // final elevation = D4.getOptionalNamedArg<double?>(named, 'elevation');
        //
        // When called with named = {'elevation': 4} (int), it should
        // return 4.0 (double)
        final named = <String, Object?>{'elevation': 4};
        final result = D4.getOptionalNamedArg<double?>(named, 'elevation');
        expect(result, equals(4.0));
        expect(result, isA<double>());
      },
    );

    test(
      'D4-OPT-02: getOptionalNamedArg<double?> with double value. [2026-02-28] (PASS)',
      () {
        final named = <String, Object?>{'elevation': 4.0};
        final result = D4.getOptionalNamedArg<double?>(named, 'elevation');
        expect(result, equals(4.0));
      },
    );

    test(
      'D4-OPT-03: getOptionalNamedArg<double?> with null. [2026-02-28] (PASS)',
      () {
        final named = <String, Object?>{'elevation': null};
        final result = D4.getOptionalNamedArg<double?>(named, 'elevation');
        expect(result, isNull);
      },
    );

    test(
      'D4-OPT-04: getOptionalNamedArg<double?> missing key. [2026-02-28] (PASS)',
      () {
        final named = <String, Object?>{};
        final result = D4.getOptionalNamedArg<double?>(named, 'elevation');
        expect(result, isNull);
      },
    );
  });

  group('D4.getRequiredArg - Positional Double', () {
    test(
      'D4-REQ-01: getRequiredArg<double> with int value. [2026-02-28] (PASS)',
      () {
        // Required positional double should accept int
        final positional = <Object?>[4];
        final result =
            D4.getRequiredArg<double>(positional, 0, 'size', 'SizedWidget');
        expect(result, equals(4.0));
        expect(result, isA<double>());
      },
    );

    test(
      'D4-REQ-02: getRequiredArg<double> with double value. [2026-02-28] (PASS)',
      () {
        final positional = <Object?>[4.0];
        final result =
            D4.getRequiredArg<double>(positional, 0, 'size', 'SizedWidget');
        expect(result, equals(4.0));
      },
    );
  });

  group('D4.getRequiredNamedArg - Named Double', () {
    test(
      'D4-REQN-01: getRequiredNamedArg<double> with int value. [2026-02-28] (PASS)',
      () {
        final named = <String, Object?>{'size': 100};
        final result =
            D4.getRequiredNamedArg<double>(named, 'size', 'SizedWidget');
        expect(result, equals(100.0));
        expect(result, isA<double>());
      },
    );
  });

  group('D4.coerceList - Double Lists', () {
    test(
      'D4-LIST-01: coerceList<double> with int list. [2026-02-28] (PASS)',
      () {
        // List<int> should be coercible to List<double>
        final list = <Object?>[1, 2, 3];
        final result = D4.coerceList<double>(list, 'values');
        expect(result, equals([1.0, 2.0, 3.0]));
        expect(result, isA<List<double>>());
      },
    );

    test(
      'D4-LIST-02: coerceList<double> with double list. [2026-02-28] (PASS)',
      () {
        final list = <double>[1.0, 2.0, 3.0];
        final result = D4.coerceList<double>(list, 'values');
        expect(result, equals([1.0, 2.0, 3.0]));
      },
    );

    test(
      'D4-LIST-03: coerceList<double> with mixed int/double list. [2026-02-28] (PASS)',
      () {
        // Common case: list literals may have mixed int/double
        final list = <Object?>[1, 2.5, 3];
        final result = D4.coerceList<double>(list, 'values');
        expect(result, equals([1.0, 2.5, 3.0]));
      },
    );
  });

  group('BridgedInstance Unwrapping with Type Promotion', () {
    // Tests for when values come wrapped in BridgedInstance

    test(
      'D4-WRAP-01: extractBridgedArg unwraps BridgedInstance<int> to double. [2026-02-28] (FAIL)',
      () {
        // When D4rt wraps an int in BridgedInstance, extracting as double should work
        // This is a theoretical test - would need a mock BridgedInstance
        expect(true, isTrue); // Placeholder for actual BridgedInstance test
      },
      skip: 'Needs BridgedInstance mock for proper testing',
    );
  });
}

// =============================================================================
// BUG ANALYSIS DOCUMENTATION
// =============================================================================
//
// The bug reproduction code:
//
// In flutter bridges, generated code looks like:
//   final elevation = D4.getOptionalNamedArg<double?>(named, 'elevation');
//
// Where named = {'elevation': 4}  (int from D4rt literal)
//
// The call chain is:
// 1. getOptionalNamedArg<double?>(named, 'elevation')
// 2. → extractBridgedArg<double?>(named['elevation'], 'elevation')
// 3. → extractBridgedArg checks: T == double && unwrapped is int
// 4. → T is double?, not double, so check FAILS
// 5. → Error: "Invalid parameter elevation: expected double?, got int"
//
// FIX NEEDED in d4.dart:
//
// Current code (line ~150):
//   if (T == double && unwrapped is int) {
//     return unwrapped.toDouble() as T;
//   }
//
// Should be:
//   // Check for both double and double?
//   if (_isDoubleType<T>() && unwrapped is int) {
//     return unwrapped.toDouble() as T;
//   }
//
// Where _isDoubleType<T>() returns true for both double and double?
// Implementation options:
//   1. Use T.toString() check: T.toString() == 'double' || T.toString() == 'double?'
//   2. Use null type check: T == double || <T>[] is List<double?>
//   3. Use extension type pattern
// =============================================================================
