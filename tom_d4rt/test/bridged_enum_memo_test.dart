/// Tests for memoized enum construction (import-optimization plan step #4).
/// `BridgedEnumDefinition.buildBridgedEnum()` builds a [BridgedEnum] once and
/// caches it, so the (non-trivial) build runs at most once per process instead
/// of twice per `execute()`.
///
/// Twin of `tom_d4rt_ast/test/bridged_enum_memo_test.dart`.
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A trivial native enum used as a bridge target.
enum _Color { red, green, blue }

void main() {
  group('IMP-OPT-4: memoized buildBridgedEnum', () {
    test('IMP-OPT-4a: second build returns the cached instance', () {
      final def = BridgedEnumDefinition<_Color>(
        name: 'Color',
        values: _Color.values,
      );

      final first = def.buildBridgedEnum();
      final second = def.buildBridgedEnum();
      final third = def.buildBridgedEnum();

      expect(identical(first, second), isTrue,
          reason: '2nd build serves the memoized enum');
      expect(identical(second, third), isTrue,
          reason: '3rd build serves the same memoized enum');
    });

    test('IMP-OPT-4b: cached enum preserves its values and adapters', () {
      var getterCalls = 0;
      final def = BridgedEnumDefinition<_Color>(
        name: 'Color',
        values: _Color.values,
        getters: {
          'isRed': (visitor, target) {
            getterCalls++;
            return (target as _Color) == _Color.red;
          },
        },
      );

      final built = def.buildBridgedEnum();
      expect(built.name, 'Color');
      expect(built.values.keys, containsAll(<String>['red', 'green', 'blue']));
      expect(built.getters.containsKey('isRed'), isTrue);

      // The cached instance is the very same object on re-build.
      expect(identical(def.buildBridgedEnum(), built), isTrue);
      // Adapter wiring survives caching.
      final result = built.getters['isRed']!(null, _Color.red);
      expect(result, isTrue);
      expect(getterCalls, 1);
    });

    test('IMP-OPT-4c: separate definitions build independent enums', () {
      final defA = BridgedEnumDefinition<_Color>(
        name: 'Color',
        values: _Color.values,
      );
      final defB = BridgedEnumDefinition<_Color>(
        name: 'Color',
        values: _Color.values,
      );

      expect(identical(defA.buildBridgedEnum(), defB.buildBridgedEnum()),
          isFalse,
          reason: 'memo is per-definition, not global');
    });
  });
}
