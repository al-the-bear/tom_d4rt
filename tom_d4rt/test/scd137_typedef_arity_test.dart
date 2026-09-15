/// SCD137 — a bridged function typedef can carry its positional ARITY, so a
/// callback that provably cannot be invoked is refused at the binding rather
/// than at the call.
///
/// scd136 made a bridged typedef accept any callable, arity-blind, because
/// `BridgedClass(nativeType: Function, name: typedef.name)` is all that
/// survived generation — the typedef's signature was discarded, so there was
/// nothing to check a closure's shape against. `VoidCallback` and
/// `ValueChanged` were indistinguishable.
///
/// The generator always had the data (`_typedefExpansions` holds
/// `'void Function(double)'`); it threw it away at emission. It now emits the
/// positional arity alongside the name, and `FunctionRuntimeType.isSubtypeOf`
/// uses it.
///
/// ## What this rule deliberately does NOT do
///
/// The prize here is a BETTER ERROR, not a caught bug: a zero-argument closure
/// passed where `ValueChanged` is required fails either way — at the binding
/// with this rule, at the call without it. So the cost of a false rejection is
/// far higher than the benefit, because a wrongly-refused callback breaks code
/// that works today, across every Flutter widget. Three restrictions follow,
/// and each is a test below:
///
///   * **Arity only. Return types are never checked.** An interpreted closure
///     always resolves to `dynamic Function(...)`, and `dynamic` is assignable
///     to every callback return type. Checking returns would reject working
///     callbacks wholesale.
///   * **Only the typedef's REQUIRED positional count is checked.** That is
///     the one invocation shape the typedef guarantees; anything beyond it is
///     a possibility, not a promise, and rejecting on a possibility is how a
///     working callback gets refused.
///   * **No arity, no opinion.** A bridge registered without arity behaves
///     exactly as scd136 left it. Every `.b.dart` in the wild is in that
///     state, so this change is INERT until the generator and the interpreter
///     have both shipped — which is the property that makes it safe to land
///     ahead of them.
///
/// Twin of `tom_d4rt_ast/test/runtime/scd137_typedef_arity_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const _fixtureUri = 'package:fixture/fixture.dart';

/// A closure's runtime type: `dynamic Function(<required>, [<optional>])`.
FunctionRuntimeType _closure({int required = 0, int optional = 0}) =>
    FunctionRuntimeType(
      returnType: const NamedRuntimeType('dynamic'),
      positionalParameterTypes: List<RuntimeType>.filled(
        required,
        const NamedRuntimeType('dynamic'),
      ),
      optionalPositionalParameterTypes: List<RuntimeType>.filled(
        optional,
        const NamedRuntimeType('dynamic'),
      ),
    );

/// A function typedef as the module loader registers it once the generator
/// carries the arity through.
BridgedClass _typedef(String name, {int? required, int? max}) => BridgedClass(
  nativeType: Function,
  name: name,
  typedefRequiredPositional: required,
  typedefMaxPositional: max,
);

void main() {
  group('SCD137: a bridged typedef checks positional arity', () {
    test(
      'F-SCD137-1: a matching closure is accepted — 1-arg against ValueChanged',
      () {
        expect(
          _closure(
            required: 1,
          ).isSubtypeOf(_typedef('ValueChanged', required: 1, max: 1)),
          isTrue,
        );
        expect(
          _closure().isSubtypeOf(_typedef('VoidCallback', required: 0, max: 0)),
          isTrue,
        );
      },
    );

    test(
      'F-SCD137-2: a closure that cannot be invoked is refused — this is the '
      'whole point of carrying the signature',
      () {
        // `onChanged(value)` would throw at the call. Refusing at the binding
        // names the parameter and the typedef instead.
        expect(
          _closure().isSubtypeOf(_typedef('ValueChanged', required: 1, max: 1)),
          isFalse,
          reason: 'a zero-argument closure cannot serve a ValueChanged',
        );
        expect(
          _closure(
            required: 2,
          ).isSubtypeOf(_typedef('VoidCallback', required: 0, max: 0)),
          isFalse,
          reason: 'a two-argument closure cannot serve a VoidCallback',
        );
      },
    );

    test('F-SCD137-3: optional positionals count toward what a closure can '
        'accept', () {
      // `(a, [b]) {}` handles both `f(1)` and `f(1, 2)`, so it serves a
      // one-argument typedef. Counting only REQUIRED params here would
      // refuse a callback that works, which is the failure mode this whole
      // file is shaped around.
      expect(
        _closure(
          required: 1,
          optional: 1,
        ).isSubtypeOf(_typedef('ValueChanged', required: 1, max: 1)),
        isTrue,
      );
      // `([a]) {}` handles `f()` too.
      expect(
        _closure(
          optional: 1,
        ).isSubtypeOf(_typedef('VoidCallback', required: 0, max: 0)),
        isTrue,
      );
    });

    test('F-SCD137-4: only the typedef\'s REQUIRED count is checked, never its '
        'maximum', () {
      // A typedef declaring `void Function(int, [int])` guarantees one
      // argument and permits two. A one-argument closure is refused by a
      // max-based rule and accepted by a required-based one — and the
      // required-based one is right, because rejecting on a possibility is
      // how a working callback gets refused.
      expect(
        _closure(
          required: 1,
        ).isSubtypeOf(_typedef('MaybeTwo', required: 1, max: 2)),
        isTrue,
      );
    });

    test('F-SCD137-5: no arity, no opinion — an un-annotated bridge behaves '
        'exactly as scd136 left it', () {
      // Every `.b.dart` generated before this change is in this state, which
      // is what makes the interpreter side safe to land before the generator
      // ships. If this ever fails, the change has stopped being inert and
      // every existing bridge package is affected at once.
      final blind = _typedef('ValueChanged');
      expect(_closure().isSubtypeOf(blind), isTrue);
      expect(_closure(required: 3).isSubtypeOf(blind), isTrue);
    });

    test('F-SCD137-6: return types are never consulted', () {
      // An interpreted closure always returns `dynamic`. A typedef returning
      // `void`, `String` or anything else must still accept it — checking
      // returns would reject working callbacks wholesale.
      final returnsString = FunctionRuntimeType(
        returnType: const NamedRuntimeType('String'),
      );
      expect(
        returnsString.isSubtypeOf(
          _typedef('VoidCallback', required: 0, max: 0),
        ),
        isTrue,
      );
    });

    test('F-SCD137-7: a bridge that is not a Function is still refused', () {
      // The scd136 control, restated: arity must not become a back door that
      // makes any annotated bridge accept a closure.
      expect(
        _closure().isSubtypeOf(
          BridgedClass(
            nativeType: String,
            name: 'Text',
            typedefRequiredPositional: 0,
            typedefMaxPositional: 0,
          ),
        ),
        isFalse,
      );
    });

    test('F-SCD137-8: SCRIPT level — a mis-shaped callback is refused at the '
        'binding, naming the parameter', () {
      final d4rt = D4rt();
      d4rt.registerBridgedClass(
        _typedef('ValueChanged', required: 1, max: 1),
        _fixtureUri,
      );

      expect(
        () => d4rt.execute(
          source:
              '''
              import '$_fixtureUri';
              int change(ValueChanged onChanged) => 1;
              main() => change(() {});
            ''',
        ),
        throwsA(
          predicate(
            (e) => e.toString().contains('ValueChanged'),
            'names the typedef the callback failed to satisfy',
          ),
        ),
        reason:
            'without the arity the closure binds and `onChanged(v)` throws '
            'later, at the call, with a message that names neither the '
            'parameter nor the typedef',
      );
    });

    test(
      'F-SCD137-9: SCRIPT level — a correctly shaped callback still binds and '
      'runs',
      () {
        // The regression this rule is most likely to cause, asserted directly.
        final d4rt = D4rt();
        d4rt.registerBridgedClass(
          _typedef('ValueChanged', required: 1, max: 1),
          _fixtureUri,
        );

        final result = d4rt.execute(
          source:
              '''
            import '$_fixtureUri';
            int seen = 0;
            int change(ValueChanged onChanged) {
              onChanged(41);
              return seen;
            }
            main() => change((v) { seen = v + 1; });
          ''',
        );

        expect(result, 42);
      },
    );
  });
}
