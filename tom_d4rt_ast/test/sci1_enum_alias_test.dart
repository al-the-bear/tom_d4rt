// SCI1: a bridged alias whose target is an ENUM.
//
// `typedef MaterialState = WidgetState;` — the generator emits it in
// `classAliases()`, and `Environment.defineBridgeAlias` looked the target up
// among bridged CLASSES only, so the alias was never defined. The script-level
// case lives in the reference twin, which can parse source; this tree checks
// the registry the module loader calls.
//
// Twin of `tom_d4rt/test/sci1_enum_alias_test.dart`.
import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

enum _Phase { idle, pressed, selected }

void main() {
  group('SCI1: an alias of a bridged enum', () {
    test('SCI1-2: the alias is the enum itself, not a copy [2026-10-01]', () {
      final env = Environment();
      env.defineBridgedEnum(
        BridgedEnumDefinition<_Phase>(
          name: 'Phase',
          values: _Phase.values,
        ).buildBridgedEnum(),
      );
      env.defineBridgeAlias('OldPhase', 'Phase');
      expect(identical(env.get('OldPhase'), env.get('Phase')), isTrue);
    });

    test('SCI1-3: an alias defined in an inner scope reaches an enum the '
        'enclosing scope holds, as the class path does [2026-10-01]', () {
      final outer = Environment();
      outer.defineBridgedEnum(
        BridgedEnumDefinition<_Phase>(
          name: 'Phase',
          values: _Phase.values,
        ).buildBridgedEnum(),
      );
      final inner = Environment(enclosing: outer);
      inner.defineBridgeAlias('OldPhase', 'Phase');
      expect(inner.get('OldPhase'), isA<BridgedEnum>());
      expect(() => outer.get('OldPhase'), throwsA(anything));
    });
  });
}
