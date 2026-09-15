import 'package:test/test.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`
// — see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged, and these two
// transitively provide `Environment` too, so the public barrel is not imported
// here (it would be flagged unnecessary).
import 'package:tom_d4rt_ast/src/runtime/stdlib/async.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

import '../bridge_reachability.dart';

/// SCD187 coverage for `tom_d4rt_ast` — `HttpClientResponse.transform` resolves
/// to the inherited `Stream` adapter rather than to a local stub.
///
/// WHAT WAS WRONG. The `HttpClientResponse` bridge carried a local `transform`
/// whose whole body threw `transform not yet implemented in interpreted
/// environment`, under the comment "Implementation for transform would be
/// complex, placeholder". There was nothing to implement: an
/// `HttpClientResponse` IS a `Stream<List<int>>`, and the `Stream` bridge's
/// `transform` already coerces the transformer and delegates. Deleting the
/// local adapter is the fix, and it is SCC51's shape one library over — a leaf
/// redeclaring a member its supertype supplies, and supplying a worse one.
///
/// WHY THIS FILE ASSERTS RESOLUTION RATHER THAN BEHAVIOUR. A round trip is what
/// the reference tree's twin drives, and it cannot be driven here: `tom_d4rt_exec`
/// is the only runner that could execute a script against *this* tree and it
/// resolves `tom_d4rt_ast` from pub.dev, so it cannot see unpublished edits
/// (DGUC6). What IS measurable here is the thing the fix actually changed —
/// which adapter the name reaches — and that is measured through the
/// reachability helper rather than by indexing one bridge's member map, per
/// SCD151.
///
/// ABLATED BY RESTORING THE STUB: 2 of the 4 cases go red, and WHICH two is
/// the useful part. F-SCD187-AST-1 keeps passing, because a stub is reachable
/// too — presence was never the question, which is why AST-2 asserts IDENTITY
/// with `Stream`'s adapter rather than mere resolution. AST-4 keeps passing
/// because `HttpServer` never had the stub, which is the same fact stated as a
/// control.
///
/// The behaviour twin lives in
/// `tom_d4rt/test/stdlib/io/scd187_http_response_transform_test.dart`.
void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    // dart:async first: the io bridges lean on its stream types.
    AsyncStdlib.register(env);
    IoStdlib.register(env);
  });

  group('SCD187: HttpClientResponse.transform resolves upward', () {
    test('F-SCD187-AST-1: `transform` is reachable from HttpClientResponse '
        '[2026-09-15] (PASS)', () {
      // Anti-vacuity first, and it is the substance here rather than a
      // formality: the fix DELETED an adapter, so the risk is that the name
      // now resolves to nothing at all. Reachability is what distinguishes
      // "inherited correctly" from "gone".
      expect(
        findReachableMethod(env, 'HttpClientResponse', 'transform'),
        isNotNull,
        reason:
            'Deleting the local stub must leave the inherited Stream adapter '
            'reachable, not leave the member unresolvable.',
      );
    });

    test('F-SCD187-AST-2: it is the SAME adapter Stream supplies '
        '[2026-09-15] (PASS)', () {
      // The assertion that would have failed before the deletion, and the one
      // that fails again if a local adapter comes back. Identity rather than
      // mere presence: a re-added local copy would also be "reachable".
      final fromResponse = findReachableMethod(
        env,
        'HttpClientResponse',
        'transform',
      );
      final fromStream = findReachableMethod(env, 'Stream', 'transform');
      expect(fromStream, isNotNull, reason: 'Stream must supply transform');
      expect(
        identical(fromResponse, fromStream),
        isTrue,
        reason:
            'HttpClientResponse.transform must BE Stream.transform. A distinct '
            'adapter here is a shadow, which is what reported "not yet '
            'implemented in interpreted environment" for as long as it '
            'existed.',
      );
    });

    test('F-SCD187-AST-3: the bridge still declares its own `listen` '
        '[2026-09-15] (PASS)', () {
      // The control, and the reason the fix is a deletion rather than a rule.
      // Not every locally declared Stream member is a mistake: `listen` is
      // genuinely re-registered here, routed through `bridgedStreamListen`,
      // and must stay. LAYOUT is the subject, so this reads the declaring
      // bridge's own map deliberately — SCD151's stated exception.
      final bridge = env.findBridgedClassByName('HttpClientResponse');
      expect(bridge, isNotNull);
      expect(bridge!.methods.keys, contains('listen'));
      expect(bridge.methods.keys, isNot(contains('transform')));
    });

    test('F-SCD187-AST-4: the sibling that always worked is unchanged '
        '[2026-09-15] (PASS)', () {
      // `HttpServer.transform` worked throughout, for exactly the reason this
      // one now does — no local adapter shadows the inherited one. Pinning it
      // beside the repair says the two classes reach the same place, which is
      // what "the message was wider than the defect" means concretely.
      expect(
        identical(
          findReachableMethod(env, 'HttpServer', 'transform'),
          findReachableMethod(env, 'Stream', 'transform'),
        ),
        isTrue,
      );
    });
  });
}
