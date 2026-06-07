/// Premise lock-in for OPEN C.4 (G1): `D4.getNamedArgWithDefault<T>` must
/// distinguish an *absent* named argument (→ apply the bridge default) from an
/// *explicit null* (→ keep null when T is nullable). A prior version guarded on
/// `!containsKey(p) || named[p] == null`, conflating the two and overwriting an
/// explicit null with the default. These tests fail first if that regression
/// returns.
///
/// Mirrors the matching `GNAD-*` group in
/// `tom_d4rt/test/bridge/d4_helpers_test.dart` (twins kept in lockstep).
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  group('D4.getNamedArgWithDefault - absent vs explicit-null (OPEN C.4 / G1)',
      () {
    test(
      'GNAD-01: absent arg returns the default. [2026-06-07] (PASS)',
      () {
        final result = D4.getNamedArgWithDefault<int>({}, 'count', 7);
        expect(result, equals(7));
      },
    );

    test(
      'GNAD-02: explicit null on nullable T is preserved (not defaulted). '
      '[2026-06-07] (PASS)',
      () {
        final result = D4.getNamedArgWithDefault<int?>(
          {'count': null},
          'count',
          7,
        );
        expect(result, isNull,
            reason:
                'Explicit null must survive; gating on containsKey only.');
      },
    );

    test(
      'GNAD-03: explicit null on non-nullable T falls back to the default. '
      '[2026-06-07] (PASS)',
      () {
        final result = D4.getNamedArgWithDefault<int>(
          {'count': null},
          'count',
          7,
        );
        expect(result, equals(7));
      },
    );

    test(
      'GNAD-04: present non-null value is returned unchanged. '
      '[2026-06-07] (PASS)',
      () {
        final result = D4.getNamedArgWithDefault<int>(
          {'count': 3},
          'count',
          7,
        );
        expect(result, equals(3));
      },
    );

    test(
      'GNAD-05: explicit null on nullable String? is preserved. '
      '[2026-06-07] (PASS)',
      () {
        final result = D4.getNamedArgWithDefault<String?>(
          {'label': null},
          'label',
          'fallback',
        );
        expect(result, isNull);
      },
    );
  });
}
