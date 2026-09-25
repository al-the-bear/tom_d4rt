/// SCE179 — the interpreter/native boundary is stated at the value-level
/// entry, in the analyzer-free tree's LIVE registry.
///
/// `tom_d4rt/test/scd147_interpreter_owned_boundary_test.dart` carries the
/// reference cases; this is the same group against this tree's environment,
/// whose `_toBridgedClassForValue` is kept code-identical by the mirror guards.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  late Environment env;

  setUpAll(() {
    final runner = D4rtRunner()..warmup();
    final bundle = AstBundle(
      entryPointUri: 'package:t/main.dart',
      modules: {
        'package:t/main.dart': SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            SFunctionDeclaration(
              offset: 1,
              length: 4,
              name: SSimpleIdentifier(offset: 2, length: 4, name: 'main'),
              functionExpression: SFunctionExpression(
                offset: 3,
                length: 1,
                parameters: SFormalParameterList(offset: 4, length: 1),
                body: SExpressionFunctionBody(
                  offset: 5,
                  length: 1,
                  expression: SIntegerLiteral(offset: 6, length: 1, value: 1),
                ),
              ),
            ),
          ],
        ),
      },
    );
    runner.executeBundleAs<Object?>(bundle, name: 'main');
    env = runner.visitor!.globalEnvironment;
  });

  group('SCE179: the boundary is stated at the value-level entry', () {
    // `_isInterpreterOwned` is now asked once, at `_toBridgedClassForValue`,
    // which both `toBridgedInstance` and `getRuntimeType` go through. These
    // cases prove the boundary there no longer depends on SCD132: they SUPPLY
    // the corroboration SCD132 demands — a bridge that declares the name — and
    // the value paths must refuse anyway. The `Type` API cannot refuse (it is
    // given a `Type`, not a value), and F-SCE179-1 records that it does not.
    Environment child() => Environment(enclosing: env);
    final owned = <Object Function()>[
      () => TypeParameter('T'),
      () => const NamedRuntimeType('X'),
    ];

    test('F-SCE179-1: a bridge that DECLARES an interpreter-owned name still '
        'cannot claim its values [2026-09-25]', () {
      final e = child()
        ..defineBridge(
          BridgedClass(
            nativeType: Object,
            name: 'Type',
            nativeNames: const ['TypeParameter', 'NamedRuntimeType'],
          ),
          sourceUri: 'package:probe/type.dart',
        );
      for (final make in owned) {
        final value = make();
        expect(
          e.toBridgedClass(value.runtimeType).name,
          'Type',
          reason:
              'the Type-keyed API follows the declaration — it cannot '
              'see ownership, which is why the value entry exists',
        );
        expect(
          () => e.toBridgedInstance(value),
          throwsA(isA<RuntimeD4rtException>()),
          reason:
              '${value.runtimeType} is the interpreter'
              's own value',
        );
        expect(
          e.getRuntimeType(value),
          isNull,
          reason: '${value.runtimeType} must not be typed as a native bridge',
        );
      }
    });

    test('F-SCE179-2: an exact nativeType registration is still honoured — '
        'that is a declaration, not a guess [2026-09-25]', () {
      final e = child()
        ..defineBridge(
          BridgedClass(nativeType: TypeParameter, name: 'TypeParameterBridge'),
          sourceUri: 'package:probe/tp.dart',
        );
      expect(
        e.toBridgedInstance(TypeParameter('T'))!.bridgedClass.name,
        'TypeParameterBridge',
      );
    });

    test('F-SCE179-3 (control): a native private SDK type still reaches its '
        'bridge by suffix through the same entry [2026-09-25]', () {
      final iterator = <int>{1}.iterator;
      expect(
        child().toBridgedInstance(iterator)!.bridgedClass.name,
        'Iterator',
      );
    });
  });
}
