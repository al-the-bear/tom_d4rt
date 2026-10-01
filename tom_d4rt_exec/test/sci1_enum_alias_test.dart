// SCI1: a bridged alias whose target is an ENUM.
//
// `typedef MaterialState = WidgetState;` — Flutter's deprecated name for an
// enum. The generator emits it in `classAliases()` like every other typedef
// alias, and `Environment.defineBridgeAlias` looked the target up among bridged
// CLASSES only, so it logged "target class not found" and defined nothing.
// `MaterialState` was therefore undefined in every run; scripts that named it
// passed only while that line went unevaluated. scg6's static name pass refuses
// a program that names an undefined identifier before `main`, which is how the
// pre-publish base corpus found it (material/datatable_test.dart).
//
// Twin of `tom_d4rt_ast/test/sci1_enum_alias_test.dart`.
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

enum _Phase { idle, pressed, selected }

const _library = 'package:sci1/phase.dart';

D4rt _interpreter() {
  final d4rt = D4rt();
  d4rt.registerBridgedEnum(
    BridgedEnumDefinition<_Phase>(name: 'Phase', values: _Phase.values),
    _library,
  );
  d4rt.registerClassAlias('OldPhase', 'Phase', _library);
  return d4rt;
}

void main() {
  group('SCI1: an alias of a bridged enum', () {
    test('SCI1-1: the alias names the enum in a script, as a value and as a '
        'type argument [2026-10-01]', () {
      final result = _interpreter().execute(
        source:
            '''
import '$_library';

bool main() {
  final Set<OldPhase> states = {OldPhase.selected};
  return states.contains(Phase.selected);
}
''',
      );
      expect(result, isTrue);
    });

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
