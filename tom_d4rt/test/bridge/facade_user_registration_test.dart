/// Tests for the public user-registration API.
///
/// The [D4rt] facade exposes thin delegates onto the static [D4] sinks —
/// `registerRelaxerFactory`, `registerInterfaceProxy`, `registerGeneric
/// Constructor` — so embedders can register relaxers / proxies / generic
/// constructors for their own types (typically inside a `registerExtensions`
/// body) without touching the generator. The facade write is observable
/// through the static D4 surface, and a relaxer registered for a *non-generic*
/// user type is now resolved by [D4.extractBridgedArg] via the pre-throw
/// last-resort lookup (the gap the inlined `<…>`-gated relaxer path skips).
///
/// Mirrors the analyzer-free twin — see
/// `tom_d4rt_ast/test/runtime/facade_user_registration_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A unique non-generic target type with a registered relaxer — exercises the
/// pre-throw non-generic lookup the inlined relaxer path skips.
class _Widgetish {
  const _Widgetish();
}

/// A unique, never-registered type — exercises the unrelated-miss-still-throws
/// path.
class _NeverRegistered {}

void main() {
  group('D4rt user-registration facade', () {
    test('registerInterfaceProxy delegates to the D4 proxy sink', () {
      final runner = D4rt();
      expect(D4.hasInterfaceProxy('_FacadeProxyType'), isFalse);

      runner.registerInterfaceProxy(
        '_FacadeProxyType',
        (visitor, instance) => null,
      );

      expect(D4.hasInterfaceProxy('_FacadeProxyType'), isTrue);
    });

    test('registerGenericConstructor delegates to the D4 ctor sink', () {
      final runner = D4rt();
      expect(D4.findGenericConstructor('_FacadeCtorA', ''), isNull);

      runner.registerGenericConstructor(
        '_FacadeCtorA',
        '',
        (visitor, positional, named, typeArgs) => 'one',
      );

      expect(D4.findGenericConstructor('_FacadeCtorA', ''), isNotNull);
    });

    test('registerGenericConstructor engages the new-first chaining sink', () {
      final runner = D4rt();
      // Untyped params coerce to GenericConstructorFactory via the call's
      // context type; a declared local function gives a stable tear-off
      // identity for the chaining/idempotency assertions below.
      Object? f1(visitor, positional, named, typeArgs) => 'one';
      runner.registerGenericConstructor('_FacadeCtorB', '', f1);
      expect(
        identical(D4.findGenericConstructor('_FacadeCtorB', ''), f1),
        isTrue,
        reason: 'first registration stores the factory directly',
      );

      // A distinct second factory must wrap the existing one into a new
      // chained closure (the new-first dispatch machinery), not plainly
      // overwrite it.
      Object? f2(visitor, positional, named, typeArgs) => 'two';
      runner.registerGenericConstructor('_FacadeCtorB', '', f2);
      final chained = D4.findGenericConstructor('_FacadeCtorB', '');
      expect(identical(chained, f1), isFalse);
      expect(identical(chained, f2), isFalse);

      // Idempotent: re-registering the same factory identity is a no-op — it
      // does not re-chain.
      runner.registerGenericConstructor('_FacadeCtorB', '', f2);
      expect(
        identical(D4.findGenericConstructor('_FacadeCtorB', ''), chained),
        isTrue,
        reason: 'same-identity re-registration does not re-chain',
      );
    });

    test(
      'registerRelaxerFactory resolves a non-generic user type via '
      'extractBridgedArg (pre-throw lookup)',
      () {
        final runner = D4rt();
        runner.registerRelaxerFactory('_Widgetish', (value, innerType) {
          if (value == 'make-widget') return const _Widgetish();
          return null;
        });

        final resolved = D4.extractBridgedArg<_Widgetish>('make-widget', 'w');
        expect(resolved, isA<_Widgetish>());
      },
    );

    test('unrelated unregistered miss still throws the enriched message', () {
      String? message;
      try {
        D4.extractBridgedArg<_NeverRegistered>(42, 'x');
        fail('expected ArgumentD4rtException');
      } on ArgumentD4rtException catch (e) {
        message = e.toString();
      }

      expect(message, contains('base type: _NeverRegistered'));
      expect(message, contains('no relaxer'));
    });
  });
}
