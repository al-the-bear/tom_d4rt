/// Guard for OPEN B.13 / §U30 — interpreted-element dependent registrations
/// leaking across `/clear` (the `InheritedElement.updateDependencies`
/// "check that it really is our descendant" assertion cascade).
///
/// §U30 is FULLY CLOSED (2026-05-30, commit `da4b3234`): the historical
/// reproducer (`render_constraints_transform_box_test` → `/clear` →
/// `render_custom_multi_child_layout_box_test`) was rewritten so the cascade
/// is no longer reproducible, and the `'check that it really is our
/// descendant'` entry was **removed** from the test app's `ignoredPatterns`.
/// That removal is the active guard: if a future script re-introduces the
/// leak, the assertion is NOT silenced — it surfaces in `_frameworkErrors`
/// and the flutter suite fails (the signal the suppression used to hide).
///
/// This test pins that guard. It fails if anyone re-adds the suppression as an
/// active `ignoredPatterns` entry (an actual string literal on a non-comment
/// line), which would silently re-hide a returning §U30 cascade. The deep fix
/// (track interpreted-element lifecycles and unregister from native
/// InheritedElement dependent sets on deactivate) stays deferred until the
/// cascade resurfaces — see `interpreter_unfixable.md` §U30 and OPEN B.13.
///
/// It is a pure source-level check (no test-app spawn, no HTTP server), so it
/// is exempt from the serial `flutter test` constraint and runs instantly.
/// Mirrors `tom_d4rt_flutter_ast/test/b13_inherited_dependent_leak_test.dart`.
@TestOn('vm')
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The exact comment-internal phrase Flutter emits inside the
/// `InheritedElement.updateDependencies` descendant-check assertion. It is the
/// string the §U30 suppression matched on; robust against Flutter line-number
/// drift because it is the assertion's own comment text.
const String _descendantAssertionPhrase =
    'check that it really is our descendant';

/// Path (relative to the package root, which is `flutter test`'s cwd) to the
/// test app whose `_handleFlutterError` owns the `ignoredPatterns` list.
const String _testAppMainPath =
    'test/tom_d4rt_flutter_test_app/lib/main.dart';

void main() {
  group('OPEN B.13 / §U30 — descendant-check suppression stays removed', () {
    test('test-app main.dart exists', () {
      expect(
        File(_testAppMainPath).existsSync(),
        isTrue,
        reason: 'guard cannot run without the test-app source at '
            '$_testAppMainPath',
      );
    });

    test(
        'the §U30 descendant-check phrase appears only in comments, never as '
        'an active ignoredPatterns entry', () {
      final lines = File(_testAppMainPath).readAsLinesSync();
      final offending = <int>[];
      for (var i = 0; i < lines.length; i++) {
        final line = lines[i];
        if (!line.contains(_descendantAssertionPhrase)) continue;
        // An occurrence is allowed ONLY inside a line comment (the rationale
        // block documenting the removal). Any non-comment occurrence means the
        // suppression was re-introduced as a live `ignoredPatterns` string.
        if (!line.trimLeft().startsWith('//')) {
          offending.add(i + 1);
        }
      }
      expect(
        offending,
        isEmpty,
        reason: 'The §U30 suppression must stay removed. A non-comment '
            'occurrence of "$_descendantAssertionPhrase" at line(s) '
            '$offending would silently re-hide a returning InheritedElement '
            'dependent-leak cascade. If the leak genuinely resurfaces, fix it '
            '(track interpreted-element lifecycles / unregister dependents on '
            'deactivate) — do not re-add the suppression. See '
            'interpreter_unfixable.md §U30 and OPEN B.13.',
      );
    });
  });
}
