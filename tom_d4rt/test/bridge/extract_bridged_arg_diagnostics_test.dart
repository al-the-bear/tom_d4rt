/// Tests for the enriched missing-relaxer/proxy error message
/// (request g). When [D4.extractBridgedArg] cannot resolve an argument it now
/// throws an [ArgumentD4rtException] whose message names the base type, the
/// unmatched type-argument, the registration state (is a relaxer / proxy /
/// generic-constructor factory registered for the base but not this arg?), and
/// the concrete remedy (`additionalRelaxerTypes:` / `registerGenericTypeWrapper`).
///
/// Mirrors the analyzer-free twin — see
/// `tom_d4rt_ast/test/runtime/extract_bridged_arg_diagnostics_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A unique, never-registered target type — exercises the "nothing is
/// registered for this base" branch.
class _UnregThing {}

/// A unique generic target whose base name we register a (non-matching)
/// relaxer for — exercises the "registered for base, but this arg didn't
/// match" branch.
class _RegBox<T> {
  const _RegBox();
}

void main() {
  group('D4.extractBridgedArg enriched diagnostics', () {
    test('legacy "Invalid parameter" prefix is preserved', () {
      expect(
        () => D4.extractBridgedArg<_UnregThing>(42, 'thing'),
        throwsA(
          isA<ArgumentD4rtException>().having(
            (e) => e.toString(),
            'message',
            contains('Invalid parameter "thing": expected'),
          ),
        ),
      );
    });

    test('unregistered base: reports base type, no-registration, remedy', () {
      String? message;
      try {
        D4.extractBridgedArg<_UnregThing>(42, 'thing');
        fail('expected ArgumentD4rtException');
      } on ArgumentD4rtException catch (e) {
        message = e.toString();
      }

      expect(message, contains('base type: _UnregThing'));
      // Nothing is registered for this base.
      expect(message, contains('no relaxer'));
      expect(message, contains('"_UnregThing"'));
      // The remedy names both the config and the runtime registration path.
      expect(message, contains('additionalRelaxerTypes:'));
      expect(message, contains('registerGenericTypeWrapper'));
    });

    test(
        'registered base, unmatched type-argument: reports registration state '
        'and the unmatched arg', () {
      // Register a relaxer for the base name that never resolves anything, so
      // resolution still misses but the base *is* registered.
      D4.registerGenericTypeWrapper('_RegBox', (value, innerType) => null);

      String? message;
      try {
        D4.extractBridgedArg<_RegBox<int>>('not a box', 'box');
        fail('expected ArgumentD4rtException');
      } on ArgumentD4rtException catch (e) {
        message = e.toString();
      }

      expect(message, contains('base type: _RegBox'));
      expect(message, contains('unmatched type-argument: int'));
      // Registration state names the relaxer registered for the base.
      expect(message, contains('a relaxer is registered for "_RegBox"'));
      expect(message, contains('did not match'));
      // Remedy points at the specific parameterized type.
      expect(message, contains('_RegBox<int>'));
    });
  });
}
