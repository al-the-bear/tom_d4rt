/// RCC7: d4rt enum bridging for `Map<String, Enum>` arguments and
/// native-stored enum round-trips.
///
/// Two gaps surfaced while writing bridge-reachability tests for the Tom Core
/// kernel bridges (`TomResourceRoleRegistry`):
///
///  (a) A script-supplied `Map` whose VALUES are bridged enums could not be
///      coerced to a native `Map<String, Enum>`: `coerceMap`'s value path
///      unwrapped `BridgedInstance` but not `BridgedEnumValue`, so the closing
///      cast threw `type BridgedEnumValue is not a subtype of type Enum`.
///      The single-value `register(role, enum)` scalar path already unwrapped
///      correctly — only Map/List element enums were affected.
///
///  (b) An enum passed script->native, stored in native static state, then
///      returned to the script was not re-wrapped as its `BridgedEnumValue`,
///      so `==` against the enum literal was unreliable (callers had to compare
///      `.name`). `wrapNativeReturnValue` now re-wraps native `Enum` values.
///
/// These mirror the real registry shape: a `registerAll(Map<String, Auth>)`
/// static method plus a `stateFor(role)` that returns the stored enum.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

// Native enum bridged into the interpreter (mirrors TomAuthState). The custom
// `label` getter is bridged, so it is only reachable on a BridgedEnumValue —
// invoking it on a raw native enum leaked by a return path fails. This makes
// gap (b) observable independently of `==` (which cross-boundary equality on
// BridgedEnumValue already tolerates).
enum _Auth {
  none('No access'),
  read('Read only'),
  full('Full access');

  const _Auth(this.label);
  final String label;
}

// Native registry holding a Map<String, _Auth> in static state (mirrors
// TomResourceRoleRegistry). `registerAll` is the Map-valued entry point;
// `stateFor` returns the stored enum through a second native indirection.
class _AuthRegistry {
  static final Map<String, _Auth> _roles = <String, _Auth>{};

  static void register(String role, _Auth state) => _roles[role] = state;

  static void registerAll(Map<String, _Auth> mapping) => _roles.addAll(mapping);

  static _Auth? stateFor(String role) => _roles[role];

  // Second indirection: a static getter that surfaces stored state. Enum
  // returns through a static getter route via `wrapNativeReturnValue`, which is
  // where gap (b) lived — the native enum was wrapped as a generic
  // BridgedInstance instead of its BridgedEnumValue, breaking `==`.
  static _Auth? get ownerState => _roles['owner'];

  static void reset() => _roles.clear();
}

void main() {
  late D4rt interpreter;

  setUp(() {
    _AuthRegistry.reset();
    interpreter = D4rt();

    interpreter.registerBridgedEnum(
      BridgedEnumDefinition<_Auth>(
        name: 'Auth',
        values: _Auth.values,
        getters: {'label': (visitor, target) => (target as _Auth).label},
      ),
      'package:test/auth.dart',
    );

    final registry = BridgedClass(
      nativeType: _AuthRegistry,
      name: 'AuthRegistry',
      staticMethods: {
        'register': (visitor, positional, named, typeArgs) {
          final role = D4.getRequiredArg<String>(
            positional,
            0,
            'role',
            'register',
          );
          final state = D4.getRequiredArg<_Auth>(
            positional,
            1,
            'state',
            'register',
          );
          _AuthRegistry.register(role, state);
          return null;
        },
        // Mirrors the generated bridge: `coerceMap<String, _Auth>` is the exact
        // call that threw on BridgedEnumValue map values before the RCC7 fix.
        'registerAll': (visitor, positional, named, typeArgs) {
          final mapping = D4.coerceMap<String, _Auth>(positional[0], 'mapping');
          _AuthRegistry.registerAll(mapping);
          return null;
        },
        'stateFor': (visitor, positional, named, typeArgs) {
          final role = D4.getRequiredArg<String>(
            positional,
            0,
            'role',
            'stateFor',
          );
          return _AuthRegistry.stateFor(role);
        },
      },
      staticGetters: {'ownerState': (visitor) => _AuthRegistry.ownerState},
    );
    interpreter.registerBridgedClass(registry, 'package:test/auth.dart');
  });

  group('RCC7 (a): Map<String, Enum> argument coercion', () {
    test('registerAll converts a script Map of bridged-enum values', () {
      final result = interpreter.execute(
        source: '''
        import 'package:test/auth.dart';
        main() {
          AuthRegistry.registerAll({'owner': Auth.full, 'guest': Auth.none});
          return AuthRegistry.stateFor('owner').name;
        }
      ''',
      );
      expect(result, equals('full'));
      // The native map really received native enum values.
      expect(_AuthRegistry.stateFor('owner'), _Auth.full);
      expect(_AuthRegistry.stateFor('guest'), _Auth.none);
    });

    test('registerAll and single register agree on the native value', () {
      interpreter.execute(
        source: '''
        import 'package:test/auth.dart';
        main() {
          AuthRegistry.register('a', Auth.read);
          AuthRegistry.registerAll({'b': Auth.read});
        }
      ''',
      );
      expect(_AuthRegistry.stateFor('a'), _AuthRegistry.stateFor('b'));
    });
  });

  group('RCC7 (b): native-stored enum round-trip', () {
    test(
      'stored-then-returned enum (static method) equals the enum literal',
      () {
        final result = interpreter.execute(
          source: '''
        import 'package:test/auth.dart';
        main() {
          AuthRegistry.register('owner', Auth.full);
          var s = AuthRegistry.stateFor('owner');
          return s == Auth.full;
        }
      ''',
        );
        expect(result, isTrue);
      },
    );

    // Static getters return through `wrapNativeReturnValue`; this is the path
    // that wrapped the native enum as a generic BridgedInstance before the
    // RCC7 fix, so `== Auth.full` was false and callers fell back to `.name`.
    test(
      'stored-then-returned enum (static getter) equals the enum literal',
      () {
        final result = interpreter.execute(
          source: '''
        import 'package:test/auth.dart';
        main() {
          AuthRegistry.register('owner', Auth.full);
          return AuthRegistry.ownerState == Auth.full;
        }
      ''',
        );
        expect(result, isTrue);
      },
    );

    test('round-tripped enum (static getter) is distinguishable from other '
        'constants', () {
      final result = interpreter.execute(
        source: '''
        import 'package:test/auth.dart';
        main() {
          AuthRegistry.registerAll({'owner': Auth.full});
          var s = AuthRegistry.ownerState;
          return [s == Auth.full, s == Auth.none, s != Auth.read];
        }
      ''',
      );
      expect(result, equals([true, false, true]));
    });

    // A bridged custom getter is only resolvable on a BridgedEnumValue. If the
    // static-getter return leaks a raw native enum (gap b), `.label` throws.
    test('bridged custom getter resolves on a returned enum', () {
      final result = interpreter.execute(
        source: '''
        import 'package:test/auth.dart';
        main() {
          AuthRegistry.register('owner', Auth.full);
          return AuthRegistry.ownerState.label;
        }
      ''',
      );
      expect(result, equals('Full access'));
    });
  });
}
