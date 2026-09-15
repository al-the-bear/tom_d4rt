/// SCD136 / GEN-125 — an interpreted closure must satisfy a parameter whose
/// declared type is a bridged FUNCTION TYPEDEF.
///
/// A function typedef has no bridgeable class, so the module loader registers
/// it as a `BridgedClass` carrying `Function` as its native type and the
/// *typedef's* name:
///
/// ```dart
/// BridgedClass(nativeType: Function, name: typedef.name)   // module_loader
/// ```
///
/// `FunctionRuntimeType.isSubtypeOf` — the type an interpreted closure resolves
/// to — ended by identifying `Function` **by name**. The bridged typedef's name
/// is `VoidCallback`, which is the one property of that bridge deliberately NOT
/// `Function`, so the test missed and the closure was declared not-a-function:
///
/// ```
/// type 'dynamic Function()'        is not a subtype of type 'VoidCallback?' of 'onPressed'
/// type 'dynamic Function(dynamic)' is not a subtype of type 'ValueChanged'  of 'onChanged'
/// ```
///
/// The rule was always wrong; nothing consulted it for arguments until
/// `_checkArgumentType` began routing declared parameter types through
/// `isSubtypeOf`. Note that check already tries to stay out of callbacks' way —
/// it skips structural annotations (`int Function(String)`) and exempts a
/// declared `Function` by name. A bridged typedef defeats both: it is a
/// structural type wearing a nominal name.
///
/// Blast radius, which is the reason this is not a four-line curiosity: every
/// Flutter callback (`VoidCallback`, `ValueChanged`, `ValueSetter`,
/// `GestureTapCallback`, …) on every widget, wherever a declared parameter type
/// is checked. Nothing about the script narrows it.
///
/// **Deliberately arity-blind.** The rule accepts any callable for any typedef,
/// exactly as the `'Function'` name branch it subsumes already did. A
/// structural check would need the typedef's signature, and `nativeType:
/// Function` is all that survives generation — making the bridge carry the
/// signature is a generator change, tracked as scd137. Until then the posture
/// is the documented one: be permissive rather than reject working callbacks.
/// F-SCD136-6 pins that this is a decision and not an oversight.
///
/// Twin of `tom_d4rt_ast/test/scd136_closure_vs_bridged_typedef_test.dart`,
/// plus the script-level checks this line can run and the AST line cannot.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const _fixtureUri = 'package:fixture/fixture.dart';

/// A native class, to prove the new rule does not accept a closure for
/// *any* bridge — only for one whose native type really is `Function`.
class Text {
  const Text(this.data);
  final String data;
}

/// What an interpreted closure's runtime type looks like: `dynamic Function()`.
FunctionRuntimeType _closureType({int positional = 0}) => FunctionRuntimeType(
  returnType: const NamedRuntimeType('dynamic'),
  positionalParameterTypes: List<RuntimeType>.filled(
    positional,
    const NamedRuntimeType('dynamic'),
  ),
);

/// A function typedef as the module loader registers it.
BridgedClass _bridgedTypedef(String name) =>
    BridgedClass(nativeType: Function, name: name);

D4rt _interpreterWithTypedefs() {
  final d4rt = D4rt();
  for (final name in ['VoidCallback', 'ValueChanged']) {
    d4rt.registerBridgedClass(_bridgedTypedef(name), _fixtureUri);
  }
  d4rt.registerBridgedClass(
    BridgedClass(nativeType: Text, name: 'Text'),
    _fixtureUri,
  );
  return d4rt;
}

void main() {
  group('SCD136: a closure against a bridged function typedef', () {
    test('F-SCD136-1: a closure type is a subtype of a bridged typedef, whose '
        'name is the typedef and whose native type is Function', () {
      expect(
        _closureType().isSubtypeOf(_bridgedTypedef('VoidCallback')),
        isTrue,
        reason:
            'the bridge is identified by its NAME, which is `VoidCallback` '
            'by design. Identify it by its native type instead — that is '
            'what actually says "this is a function".',
      );
      expect(
        _closureType(
          positional: 1,
        ).isSubtypeOf(_bridgedTypedef('ValueChanged')),
        isTrue,
      );
    });

    test(
      'F-SCD136-2: a bridge whose native type is NOT Function still rejects a '
      'closure',
      () {
        // The control that separates this fix from "accept everything". If it
        // ever passes, the rule has stopped discriminating and every declared
        // parameter type accepts a closure.
        expect(
          _closureType().isSubtypeOf(
            BridgedClass(nativeType: Text, name: 'Text'),
          ),
          isFalse,
          reason:
              'a closure is not a Text. The native-type check must be an '
              'equality against `Function`, not a fallback that returns true.',
        );
      },
    );

    test('F-SCD136-3: the rule subsumes the name test — `dart:core`\'s own '
        '`Function` bridge still matches', () {
      // `Function` is registered with `nativeType: Function` too, so the
      // name branch it replaces is redundant rather than merely bypassed.
      expect(_closureType().isSubtypeOf(_bridgedTypedef('Function')), isTrue);
      // And the purely nominal path still works for a RuntimeType that is
      // not a BridgedClass at all.
      expect(
        _closureType().isSubtypeOf(
          FunctionRuntimeType(returnType: const NamedRuntimeType('dynamic')),
        ),
        isTrue,
      );
    });

    test('F-SCD136-4: SCRIPT level — a closure passed to a parameter declared '
        '`VoidCallback?` is accepted and invoked', () {
      // The level that matters. A registration-level assertion only asks
      // what `isSubtypeOf` decides about operands the test supplied itself;
      // this runs a real script through a real declared-parameter check,
      // which is the consumer that made GEN-125 visible at all.
      final result = _interpreterWithTypedefs().execute(
        source:
            '''
            import '$_fixtureUri';

            String press(VoidCallback? onPressed) {
              onPressed!();
              return 'pressed';
            }

            main() => press(() {});
          ''',
      );

      expect(result, 'pressed');
    });

    test('F-SCD136-5: SCRIPT level — a one-argument closure passed to a '
        '`ValueChanged` parameter is accepted and receives its argument', () {
      final result = _interpreterWithTypedefs().execute(
        source:
            '''
            import '$_fixtureUri';

            int change(ValueChanged onChanged) {
              onChanged(41);
              return seen;
            }

            int seen = 0;

            main() => change((v) { seen = v + 1; });
          ''',
      );

      expect(
        result,
        42,
        reason:
            'the closure must not merely be accepted — it must be the thing '
            'that runs, with its argument intact',
      );
    });

    test(
      'F-SCD136-6: the rule is arity-blind, and that is a decision (scd137)',
      () {
        // Recorded as a test rather than only as a comment, because the next
        // person to read `isSubtypeOf` will wonder whether the missing arity
        // check is a bug. It is not: the bridge carries `nativeType: Function`
        // and nothing else, so there is no signature to check against. The
        // `'Function'` name branch this replaces was equally arity-blind, so
        // the fix does not widen what is accepted for typedefs that already
        // matched — it only stops rejecting the ones that never could.
        //
        // When scd137 makes the bridge carry the signature, this expectation
        // is the one that should flip, deliberately and with its own entry.
        expect(
          _closureType(
            positional: 3,
          ).isSubtypeOf(_bridgedTypedef('VoidCallback')),
          isTrue,
          reason:
              'a three-argument closure is accepted for a zero-argument '
              'typedef. If this now fails, scd137 has landed and this test '
              'should be rewritten to assert the stricter rule rather than '
              'deleted.',
        );
      },
    );
  });
}
