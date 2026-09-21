// SCE87/AST — what this tree does when nothing has sandboxed it.
//
// The reference twin reaches its permission table through a nullable handle
// and returns when it is absent (`if (d4rt == null) return;`), which reads as
// a sandbox failing open — and this tree, which has no such handle and always
// calls `checkPermission`, reads as the corrected version.
//
// IT IS NOT THE CORRECTED VERSION. `NoOpModuleContext.checkPermission`
// returns `true` when no `PermissionChecker` was wired, under its own comment
// "be permissive (allow all)". So a bridge driven directly here grants exactly
// as the reference's early return does; the trees agree on the un-sandboxed
// mode and differ only in WHERE it is expressed — the reference in each gate,
// this tree in its module context.
//
// THAT MATTERS BECAUSE THIS IS THE TREE A FLUTTER APP SHIPS. If the two ever
// stop agreeing here, the question is which way: making this one deny would
// change what every embedder without a checker sees, and making the reference
// deny would break the mode its five gate comments describe. Both halves are
// pinned so the answer is a measurement rather than a reading.
//
// The behaviour twin is
// `tom_d4rt/test/stdlib/io/sce87_permission_gate_null_handle_test.dart`,
// which drives real scripts — this tree has no parser, so the question is put
// to the context directly.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  group('SCE87/AST: the permission default with no checker wired', () {
    test('F-SCE87-AST-1: a context with no checker grants [2026-09-21] '
        '(PASS)', () {
      // The state a bridge driven outside a sandbox sees. Every capability the
      // sandbox gates is asked, because "permissive" has to mean all of them
      // or the trees agree only by accident.
      final context = NoOpModuleContext(globalEnvironment: Environment());
      for (final type in const [
        'dangerous',
        'process',
        'filesystem',
        'network',
        'certificate',
      ]) {
        expect(
          context.checkPermission({'type': type}),
          isTrue,
          reason:
              'A context with no checker refused "$type". That is a change of '
              'default for every embedder that never wired one, and it makes '
              'this tree deny where the reference grants.',
        );
      }
    });

    test('F-SCE87-AST-2: a context WITH a checker defers to it [2026-09-21] '
        '(PASS)', () {
      // The control, and the half that makes the default meaningful: the
      // permissiveness must come from the absence of a checker, not from the
      // context ignoring one. A `checkPermission` hardcoded to true would
      // satisfy AST-1 on its own.
      final asked = <Object?>[];
      final context = NoOpModuleContext(
        globalEnvironment: Environment(),
        permissionChecker: (operation) {
          asked.add(operation);
          return false;
        },
      );
      expect(context.checkPermission({'type': 'dangerous'}), isFalse);
      expect(asked, hasLength(1));
    });
  });
}
