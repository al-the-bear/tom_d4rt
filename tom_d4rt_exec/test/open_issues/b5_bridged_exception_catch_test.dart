/// Repro + regression for OPEN B.5 — bridge-wrapped native exceptions must stay
/// catchable by typed `on` and bare `catch` clauses (U13, U24).
///
/// Historic failure: when a bridged adapter (instance method, static method,
/// static getter) throws a *native* exception (e.g. a `PlatformException`),
/// the interpreter wrapped it in a `RuntimeError`, discarding the original
/// type. Interpreted code that did `on PlatformException catch (e)` never
/// matched (U13). For some throwing bridged static getters the wrapped error
/// escaped even an untyped `catch` (U24).
///
/// The fix preserves the original native exception object through the wrap so
/// `on <NativeType>` / bare `catch` dispatch matches the real type. This is the
/// analyzer-based VM interpreter; mirrors the analyzer-free twin in
/// `tom_d4rt_exec/test/open_issues/b5_bridged_exception_catch_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// A native exception type, registered as a bridged class, that interpreted
/// code can name in an `on NativeFault` clause.
class NativeFault implements Exception {
  final String reason;
  NativeFault(this.reason);
  @override
  String toString() => 'NativeFault: $reason';
}

/// A native object whose bridged surface throws [NativeFault] from an instance
/// method, a static method, and a static getter.
class Thrower {
  Thrower();
  String boom() => throw NativeFault('instance method');
  static String boomStatic() => throw NativeFault('static method');
  static String get boomGetter => throw NativeFault('static getter');
}

D4rt _interpreterWithThrower() {
  final interpreter = D4rt();

  final faultClass = BridgedClass(
    nativeType: NativeFault,
    name: 'NativeFault',
    constructors: {
      '': (visitor, positionalArgs, namedArgs) =>
          NativeFault(positionalArgs.isNotEmpty ? '${positionalArgs[0]}' : ''),
    },
    getters: {'reason': (visitor, target) => (target as NativeFault).reason},
  );
  interpreter.registerBridgedClass(faultClass, 'package:test/fault.dart');

  final throwerClass = BridgedClass(
    nativeType: Thrower,
    name: 'Thrower',
    constructors: {'': (visitor, positionalArgs, namedArgs) => Thrower()},
    methods: {
      'boom': (visitor, target, positionalArgs, namedArgs, typeArgs) =>
          (target as Thrower).boom(),
    },
    staticMethods: {
      'boomStatic': (visitor, positionalArgs, namedArgs, typeArgs) =>
          Thrower.boomStatic(),
    },
    staticGetters: {'boomGetter': (visitor) => Thrower.boomGetter},
  );
  interpreter.registerBridgedClass(throwerClass, 'package:test/thrower.dart');

  return interpreter;
}

void main() {
  group('OPEN B.5 — bridge-wrapped exceptions stay catchable (VM)', () {
    test(
      'U13: `on NativeFault` matches a native throw from a bridged method',
      () async {
        final result = await _interpreterWithThrower().execute(
          source: '''
import 'package:test/fault.dart';
import 'package:test/thrower.dart';
String main() {
  try {
    Thrower().boom();
    return 'no-throw';
  } on NativeFault catch (e) {
    return 'typed:\${e.reason}';
  } catch (e) {
    return 'bare:\$e';
  }
}
''',
        );
        expect(result, 'typed:instance method');
      },
    );

    test('U13: `on NativeFault` matches a native throw from a bridged static '
        'method', () async {
      final result = await _interpreterWithThrower().execute(
        source: '''
import 'package:test/fault.dart';
import 'package:test/thrower.dart';
String main() {
  try {
    Thrower.boomStatic();
    return 'no-throw';
  } on NativeFault catch (e) {
    return 'typed:\${e.reason}';
  } catch (e) {
    return 'bare:\$e';
  }
}
''',
      );
      expect(result, 'typed:static method');
    });

    test(
      'U24: a throwing bridged static getter is caught by a bare `catch`',
      () async {
        final result = await _interpreterWithThrower().execute(
          source: '''
import 'package:test/fault.dart';
import 'package:test/thrower.dart';
String main() {
  try {
    final v = Thrower.boomGetter;
    return 'no-throw:\$v';
  } catch (e) {
    return 'caught';
  }
}
''',
        );
        expect(result, 'caught');
      },
    );

    test(
      'U24: a throwing bridged static getter matches a typed `on` clause',
      () async {
        final result = await _interpreterWithThrower().execute(
          source: '''
import 'package:test/fault.dart';
import 'package:test/thrower.dart';
String main() {
  try {
    final v = Thrower.boomGetter;
    return 'no-throw:\$v';
  } on NativeFault catch (e) {
    return 'typed:\${e.reason}';
  }
}
''',
        );
        expect(result, 'typed:static getter');
      },
    );
  });
}
