import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// SCC28 mirror coverage for `tom_d4rt_ast`.
///
/// Unit-level rather than script-level, for the same reason as the SC5 and
/// SCB10 mirror suites: `tom_d4rt_exec` — the only runner that could execute a
/// script against *this* tree — resolves `tom_d4rt_ast` from pub.dev rather
/// than by path, so it cannot see unpublished local edits. The behavioural
/// cases live in `tom_d4rt/test/scc28_typed_undefined_member_test.dart`, whose
/// F-SCC28-1 source scan covers *both* trees and is the primary guard.
///
/// What is worth pinning here is the half the scan cannot see: the scan proves
/// no site reads a message, but not that the replacement signal survives being
/// re-wrapped. Five sites in this file's sibling visitor add context to a
/// member-lookup failure on the way out. Before SCC28 they preserved the signal
/// by accident — they concatenated the original message, so an outer
/// `contains(...)` matched straight through the wrap. If
/// [rewrapPreservingMemberSignal] ever stops carrying the type, that accident is
/// not there to fall back on and extension-method resolution silently stops one
/// frame out, which is precisely the regression SCC28 exists to prevent.
void main() {
  group('SCC28/AST: member absence is a type, and it survives re-wrapping', () {
    test('F-SCC28-AST-1: the typed signal subtypes RuntimeD4rtException so the '
        'existing handlers still catch it [2026-09-05]', () {
      final e = UndefinedMemberD4rtException(
        "Undefined property 'foo' on Bar.",
        memberName: 'foo',
      );
      expect(e, isA<RuntimeD4rtException>());
      expect(e, isA<D4rtException>());
      expect(e.memberName, 'foo');
      // `toString()` is inherited, so diagnostics are unchanged to the byte.
      expect(e.toString(), "Runtime Error: Undefined property 'foo' on Bar.");
    });

    test('F-SCC28-AST-2: re-wrapping preserves the signal and the inner '
        'member name [2026-09-05]', () {
      final inner = UndefinedMemberD4rtException(
        "Undefined property 'foo' on Bar.",
        memberName: 'foo',
      );
      final wrapped = rewrapPreservingMemberSignal(
        inner,
        "${inner.message} (accessing property via SPropertyAccess 'foo')",
      );
      expect(wrapped, isA<UndefinedMemberD4rtException>());
      // The *inner* name is carried over, not the wrapping site's own. The
      // failure being described is still the inner one — which is what the
      // concatenated substring used to say too.
      expect((wrapped as UndefinedMemberD4rtException).memberName, 'foo');
      expect(wrapped.message, contains('accessing property via'));
    });

    test('F-SCC28-AST-3: re-wrapping a non-member failure does NOT invent the '
        'signal [2026-09-05]', () {
      // The other direction matters just as much. Tagging an ordinary runtime
      // failure as "member absent" would send it down the extension-lookup
      // branch, where a same-named extension member would answer in place of an
      // error the script needed to see.
      final wrapped = rewrapPreservingMemberSignal(
        RuntimeD4rtException('division by zero'),
        'division by zero (accessing property via SPropertyAccess \'x\')',
      );
      expect(wrapped, isA<RuntimeD4rtException>());
      expect(wrapped, isNot(isA<UndefinedMemberD4rtException>()));
    });
  });
}
