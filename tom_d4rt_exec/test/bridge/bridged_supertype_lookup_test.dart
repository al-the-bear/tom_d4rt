/// Tests for bridged supertype lookup.
///
/// When a bridged static getter returns a native object of a private subclass,
/// the interpreter should be able to find methods on the public base class bridge.
///
/// Example: `Curves.linear` returns a `_Linear` instance (private class).
/// When calling `.transform(0.5)` on it, the interpreter should find the
/// `transform` method on the `Curve` base class bridge.
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

// =============================================================================
// Test fixtures - simulate Flutter's Curve/Curves pattern
// =============================================================================

/// Base class with the method we want to call.
abstract class Curve {
  const Curve();

  /// Transform a value between 0.0 and 1.0.
  double transform(double t);
}

/// Private implementation - NOT bridged.
class _Linear extends Curve {
  const _Linear();

  @override
  double transform(double t) => t;
}

/// Another private implementation - NOT bridged.
class _DecelerateCurve extends Curve {
  const _DecelerateCurve();

  @override
  double transform(double t) => 1.0 - (1.0 - t) * (1.0 - t);
}

/// Factory class with static getters returning private implementations.
abstract class Curves {
  Curves._(); // Private constructor

  static const Curve linear = _Linear();
  static const Curve decelerate = _DecelerateCurve();
}

// =============================================================================
// Bridge definitions
// =============================================================================

BridgedClass _createCurveBridge() {
  return BridgedClass(
    nativeType: Curve,
    name: 'Curve',
    isAssignable: (v) => v is Curve,
    methods: {
      'transform': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Curve>(target, 'Curve');
        D4.requireMinArgs(positional, 1, 'transform');
        final value = D4.getRequiredArg<double>(positional, 0, 't', 'transform');
        return t.transform(value);
      },
    },
    methodSignatures: {
      'transform': 'double transform(double t)',
    },
  );
}

BridgedClass _createCurvesBridge() {
  return BridgedClass(
    nativeType: Curves,
    name: 'Curves',
    staticGetters: {
      'linear': (visitor) => Curves.linear,
      'decelerate': (visitor) => Curves.decelerate,
    },
    staticGetterSignatures: {
      'linear': 'Curve get linear',
      'decelerate': 'Curve get decelerate',
    },
  );
}

// =============================================================================
// Tests
// =============================================================================

void main() {
  group('Bridged Supertype Lookup', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt();
      d4rt.registerBridgedClass(_createCurveBridge(), 'package:test/curves.dart');
      d4rt.registerBridgedClass(_createCurvesBridge(), 'package:test/curves.dart');
    });

    test(
      'B-SUP-01: Curves.linear returns a value. [2026-03-01] (PASS)',
      () {
        final result = d4rt.execute(source: '''
          import 'package:test/curves.dart';
          
          main() {
            final curve = Curves.linear;
            return curve;
          }
        ''');
        expect(result, isNotNull);
        // The result should be some kind of Curve instance
        expect(result, isA<Curve>());
      },
    );

    test(
      'B-SUP-02: Can call transform() on Curves.linear result. [2026-03-01] (FAIL)',
      () {
        // This is the key test - calling a method on a private subclass instance
        // should work by finding the method on the public base class bridge.
        final result = d4rt.execute(source: '''
          import 'package:test/curves.dart';
          
          main() {
            final curve = Curves.linear;
            final transformed = curve.transform(0.5);
            return transformed;
          }
        ''');
        expect(result, equals(0.5)); // _Linear.transform(t) => t
      },
    );

    test(
      'B-SUP-03: Can call transform() on Curves.decelerate result. [2026-03-01] (FAIL)',
      () {
        final result = d4rt.execute(source: '''
          import 'package:test/curves.dart';
          
          main() {
            final curve = Curves.decelerate;
            final transformed = curve.transform(0.5);
            return transformed;
          }
        ''');
        // _DecelerateCurve.transform(0.5) = 1.0 - (1.0 - 0.5)^2 = 1.0 - 0.25 = 0.75
        expect(result, equals(0.75));
      },
    );

    test(
      'B-SUP-04: Multiple transform calls work correctly. [2026-03-01] (FAIL)',
      () {
        final result = d4rt.execute(source: '''
          import 'package:test/curves.dart';
          
          main() {
            final linear = Curves.linear;
            final decelerate = Curves.decelerate;
            
            final r1 = linear.transform(0.0);
            final r2 = linear.transform(1.0);
            final r3 = decelerate.transform(0.0);
            final r4 = decelerate.transform(1.0);
            
            return [r1, r2, r3, r4];
          }
        ''');
        expect(result, equals([0.0, 1.0, 0.0, 1.0]));
      },
    );

    test(
      'B-SUP-05: Curve variable can be reassigned. [2026-03-01] (FAIL)',
      () {
        final result = d4rt.execute(source: '''
          import 'package:test/curves.dart';
          
          main() {
            var curve = Curves.linear;
            final r1 = curve.transform(0.5);
            
            curve = Curves.decelerate;
            final r2 = curve.transform(0.5);
            
            return [r1, r2];
          }
        ''');
        expect(result, equals([0.5, 0.75]));
      },
    );
  });
}
