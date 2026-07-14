/// RCC7 (a) on the analyzer-free runtime: `D4.coerceMap` must unwrap bridged
/// enum values so a script-supplied `Map<String, Enum>` converts to a native
/// `Map<String, Enum>`.
///
/// The generated bridge for a `registerAll(Map<String, Auth> mapping)` static
/// method calls `D4.coerceMap<String, Auth>(positional[0], 'mapping')`. Before
/// the RCC7 fix, `_coerceMapValue` unwrapped `BridgedInstance` but not
/// `BridgedEnumValue`, so the closing `unwrapped as V` cast threw
/// `type BridgedEnumValue is not a subtype of type Enum in type cast`.
/// The scalar path (`extractBridgedArg`) already unwrapped correctly — only
/// Map/List element enums were affected. `_coerceMapKey` was already correct,
/// so enum KEYS are covered too.
///
/// tom_d4rt_ast has no source parser (it runs pre-built AST bundles), so this
/// exercises the fixed helper directly. The source-level behavioral twin lives
/// in `tom_d4rt/test/bridge/enum_map_arg_and_roundtrip_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

// Native enum mirroring TomAuthState — the real registry value type RCC7 fixes.
enum _Auth { none, read, full }

/// Wraps a native [_Auth] value in its [BridgedEnumValue], exactly as the
/// interpreter would when the script writes `Auth.full`.
BridgedEnumValue _bridged(_Auth value) {
  final built = BridgedEnumDefinition<_Auth>(
    name: 'Auth',
    values: _Auth.values,
  ).buildBridgedEnum();
  return built.values[value.name]!;
}

void main() {
  group('RCC7 (a): coerceMap unwraps bridged enum values', () {
    test('Map<String, Enum> value coercion returns native enums', () {
      final script = <Object?, Object?>{
        'owner': _bridged(_Auth.full),
        'guest': _bridged(_Auth.none),
      };

      final native = D4.coerceMap<String, _Auth>(script, 'mapping');

      expect(native, isA<Map<String, _Auth>>());
      expect(native['owner'], _Auth.full);
      expect(native['guest'], _Auth.none);
    });

    test('Map<Enum, V> key coercion returns native enum keys', () {
      final script = <Object?, Object?>{
        _bridged(_Auth.read): 'reader',
        _bridged(_Auth.full): 'admin',
      };

      final native = D4.coerceMap<_Auth, String>(script, 'roles');

      expect(native, isA<Map<_Auth, String>>());
      expect(native[_Auth.read], 'reader');
      expect(native[_Auth.full], 'admin');
    });

    test('a raw native-enum map is returned unchanged', () {
      final alreadyNative = <String, _Auth>{'owner': _Auth.full};

      final native = D4.coerceMap<String, _Auth>(alreadyNative, 'mapping');

      expect(identical(native, alreadyNative), isTrue);
    });
  });
}
