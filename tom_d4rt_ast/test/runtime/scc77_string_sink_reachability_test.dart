import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`
// — see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

/// SCC77 mirror coverage for `tom_d4rt_ast` — `StringSink` is reachable from
/// every stdlib value that implements it.
///
/// The script-level twin is
/// `tom_d4rt/test/stdlib/core/scc77_string_sink_reachability_test.dart`. This
/// tree has no parser, and `tom_d4rt_exec` — the only runner that could execute
/// a script against it — resolves `tom_d4rt_ast` from pub.dev, so registration
/// level is what this tree can measure.
///
/// It is also the right level for what SCC77 turned out to be about. The fix is
/// entirely in the supertype REGISTRY: `StringBuffer -> StringSink` in
/// `core_hierarchy.dart` and `IOSink -> StreamSink, StringSink` in
/// `io_hierarchy.dart`. `isSubtypeOf` reads that registry directly, so asserting
/// on it measures exactly the thing the edges changed — a script would only be
/// observing the same lookup one layer further out.
///
/// BEFORE THIS FILE THIS TREE HAD NO COVERAGE OF ANY OF IT. The edges were
/// mirrored across correctly, and nothing here would have noticed if they had
/// not been.
///
/// NOTE ON THE STATIC REGISTRY: `BridgedClass.registerSupertypes` writes to a
/// process-wide map with no reset hook, so these assertions are order-
/// independent by construction (registration is idempotent and additive) but
/// cannot assert an edge is ABSENT unless nothing in the process registers it.
/// Only positives are pinned here.
void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    Stdlib(env).register(); // core + async + typed_data
    ConvertStdlib.register(env);
    IoStdlib.register(env);
  });

  BridgedClass bridge(String name) {
    final found = env.findBridgedClassByName(name);
    expect(found, isNotNull, reason: '$name must be a registered bridge');
    return found!;
  }

  /// What a script's `x is StringSink` ultimately asks.
  bool isSub(String sub, String superName, {Object? value}) =>
      bridge(sub).isSubtypeOf(bridge(superName), value: value);

  group('SCC77: the StringSink edges', () {
    test('F-SCC77-AST-1: StringBuffer is a StringSink [2026-09-06]', () {
      expect(isSub('StringBuffer', 'StringSink'), isTrue);
    });

    test('F-SCC77-AST-2: IOSink is a StringSink, and a StreamSink '
        '[2026-09-06]', () {
      expect(isSub('IOSink', 'StringSink'), isTrue);
      expect(isSub('IOSink', 'StreamSink'), isTrue);
    });

    test('F-SCC77-AST-3: Stdout reaches StringSink through IOSink '
        '[2026-09-06]', () {
      // Two hops, and the point of declaring each edge once rather than
      // spelling the closure out: `Stdout -> IOSink -> StringSink`.
      expect(isSub('Stdout', 'StringSink'), isTrue);
    });

    test('F-SCC77-AST-4: ClosableStringSink is a StringSink [2026-09-06]', () {
      // The one a script obtains that is neither a StringBuffer nor an IOSink,
      // via `StringConversionSink.asStringSink()`.
      expect(isSub('ClosableStringSink', 'StringSink'), isTrue);
    });
  });

  group('SCC77: what the edges do NOT do', () {
    test('F-SCC77-AST-5: nothing resolves TO the StringSink bridge '
        '[2026-09-06]', () {
      // SCC77 predicted the edges would let member lookup fall through to the
      // `StringSink` bridge. They do not, and this pins why: every implementor
      // the stdlib can hand a script has a more specific bridge, and that is
      // what claims the value. So the `StringSink` bridge is a type-test and
      // interface target, never a resolution target — which is why its member
      // list is guarded at registration level (`string_sink_collision_test`,
      // and `member_coverage_baseline_test` F-SCC74-2 in the analyzer tree)
      // rather than by any script.
      final probes = <String, Object>{
        'StringBuffer': StringBuffer('x'),
        'Stdout': stdout,
        'ClosableStringSink': StringConversionSink.withCallback(
          (_) {},
        ).asStringSink(),
      };
      for (final probe in probes.entries) {
        final claimed = env.toBridgedInstance(probe.value)?.bridgedClass.name;
        expect(
          claimed,
          isNot(equals('StringSink')),
          reason:
              '${probe.key} resolved to StringSink. If that is now intended, '
              'the member list of the StringSink bridge became script-visible '
              'and needs script-level coverage to match.',
        );
        expect(claimed, equals(probe.key));
      }
    });

    test('F-SCC77-AST-6: StringBuffer declares a superset of StringSink\'s '
        'members [2026-09-06]', () {
      // This assertion is how SCC77 learned that `StringSink` declared
      // `hashCode` in `methods` as well as `getters` — `methods` wins in
      // `BridgedInstance.get`, so the getter was dead. Removed; the comparison
      // below is over both maps, so a member moving between them is not a
      // failure but a member existing only on `StringSink` is.
      // The measured reason there is nothing to fall through FOR. If this ever
      // fails, a `StringBuffer` has started needing the `StringSink` bridge for
      // a member and the fall-through prediction becomes live after all.
      // Methods AND getters: a script asking for a member does not care which
      // map answers, and `StringSink` legitimately splits `toString` (method)
      // from `hashCode` / `runtimeType` (getters).
      final buffer = {
        ...bridge('StringBuffer').methods.keys,
        ...bridge('StringBuffer').getters.keys,
      };
      final sink = {
        ...bridge('StringSink').methods.keys,
        ...bridge('StringSink').getters.keys,
      };
      expect(
        sink.difference(buffer),
        isEmpty,
        reason:
            'StringSink declares members StringBuffer does not, so a script '
            'would now depend on the supertype edge for member lookup and not '
            'only for type tests.',
      );
    });
  });
}
