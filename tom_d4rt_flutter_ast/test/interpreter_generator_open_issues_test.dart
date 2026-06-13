/// Interpreter & Generator — Verified Open Issues reproduction suite.
///
/// Each test here drives a reproduction script that demonstrates an OPEN issue
/// documented in `doc/interpreter_generator_open_issues.md`. **These tests are
/// expected to FAIL** — they reproduce known-open interpreter (B.x) and
/// generator (C.x) defects, plus the unfixable limitations (A.x). When an issue
/// is fixed, its test here should flip from red to green; that is the signal the
/// fix landed.
///
/// **2026-06-04 verification:** running this corpus against both runtimes
/// (source-direct `tom_d4rt` and AST `tom_d4rt_ast`) showed 11 entries no longer
/// reproduce — A.8, B.2, B.3, B.4, B.6, B.7, B.8, B.10, C.2 (fully) and the
/// `semanticsBuilder`/`EagerGestureRecognizer.new` sub-parts of C.5/C.6. Their
/// tests below now PASS and serve as forward regression guards; the doc moved
/// them to §1 (verified FIXED). The still-red reproductions are A.2, A.3, A.4,
/// A.5, B.1, B.5, B.9, C.1. A.6/A.7 reproduce but are non-fatal, so they are
/// `skip:` (not assertable as a build failure).
///
/// Reproduction scripts live in the shared corpus under
/// `tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/open_issues/`
/// so both the AST and source-direct suites run identical scripts.
///
/// A handful of issues cannot be reproduced as a deterministic single-build
/// test (non-deterministic transport/cold-start flakiness, latent leaks,
/// interactive input starvation, or generator-internal defaults that need a
/// specific bridged constructor/parameter to trigger). Those are recorded as
/// `skip:` entries with the reason, so this file documents every open issue.
@TestOn('vm')
// Per-test timeout pinned to the uniform 60 s used corpus-wide (matches the
// runner scripts' `--timeout 60s`). 60 s sits above the runner's 55 s inner
// `_httpBuildTimeout` and the 45 s app build budget (45 < 55 < 60) so the
// inner budgets always govern: a cold-start first interpret (issue B.11) is
// bounded by the 55 s HTTP timeout before this 60 s test timeout fires,
// surfacing the runner's own clear error rather than a generic timeout.
@Timeout(Duration(seconds: 60))
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

/// Helper: a test truly passes only when the build succeeded AND no framework
/// errors were captured. For the reproductions below this is expected to be
/// false (the issue is reproduced), so these tests fail until the issue is
/// fixed.
void expectSuccess(SendResult result) {
  final errors = result.frameworkErrors.isNotEmpty
      ? result.frameworkErrors.join('; ')
      : null;
  final reason = result.error ?? errors;
  expect(result.success && !result.hasFrameworkErrors, isTrue, reason: reason);
}

const String _kTestFileName = 'interpreter_generator_open_issues_test.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(suite: _kTestFileName);
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('A — unfixable limitations (reproduced)', () {
    test('A.1 — test-app HTTP transport wedge cascade', () async {},
        skip: 'A.1 is a non-deterministic transport/harness cascade (shared '
            'HTTP server stalls after long uptime). It cannot be reproduced as '
            'a single deterministic build; each script is clean in isolation '
            '(frameworkErrors=0). Lives below the interpreter, in test infra.');

    test('A.2 — generic type-argument erasure (whereType<T>)', () async {
      final result = await SendTestRunner.send(
        'open_issues/a2_generic_typearg_erasure_test.dart',
      );
      expectSuccess(result);
    });

    test('A.3 — runtime mixin application impossible', () async {
      final result = await SendTestRunner.send(
        'open_issues/a3_runtime_mixin_application_test.dart',
      );
      expectSuccess(result);
    });

    test('A.4 — vector_math_64 types unreachable', () async {
      final result = await SendTestRunner.send(
        'open_issues/a4_vector_math_64_unreachable_test.dart',
      );
      expectSuccess(result);
    });

    test('A.5 — @Deprecated SDK symbols absent', () async {
      final result = await SendTestRunner.send(
        'open_issues/a5_deprecated_symbol_absent_test.dart',
      );
      expectSuccess(result);
    });

    test('A.6 — MemoryImage(Uint8List) PNG codec rejection', () async {},
        skip: 'A.6 reproduces the codec failure (broken-image glyph renders), '
            'but per the doc the framework banner is suppressed '
            '(main.dart:364 ignored-pattern) so the build reports '
            'frameworkErrors=0 / status=success. The limitation is real but '
            'NOT assertable as a build failure through the HTTP harness. '
            'Repro script: open_issues/a6_memory_image_png_codec_test.dart.');

    test('A.7 — empty Text(\'\') NaN layout assertion', () async {},
        skip: 'A.7 is non-fatal by design (the doc states "tests pass"): the '
            'NaN layout banner is cosmetic and does not fail the build, so it '
            'is not assertable as a build failure. Repro script: '
            'open_issues/a7_empty_text_nan_layout_test.dart.');

    test('A.8 — private SDK view types unreachable', () async {
      final result = await SendTestRunner.send(
        'open_issues/a8_private_view_type_unreachable_test.dart',
      );
      expectSuccess(result);
    });
  });

  group('B — interpreter-fixable issues (reproduced)', () {
    test('B.1 — redirecting factory not implemented', () async {
      final result = await SendTestRunner.send(
        'open_issues/b1_redirecting_factory_test.dart',
      );
      expectSuccess(result);
    });

    test('B.2 — C-style for(;;) shares one loop variable across closures',
        () async {
      final result = await SendTestRunner.send(
        'open_issues/b2_cstyle_for_closure_capture_test.dart',
      );
      expectSuccess(result);
    });

    test('B.3 — runtimeType.toString() on interpreted classes', () async {
      final result = await SendTestRunner.send(
        'open_issues/b3_runtimetype_tostring_test.dart',
      );
      expectSuccess(result);
    });

    test('B.4 — const-shaped constructor bypasses static-method registration',
        () async {
      final result = await SendTestRunner.send(
        'open_issues/b4_const_stream_empty_static_bypass_test.dart',
      );
      expectSuccess(result);
    });

    test('B.5 — bridge-wrapped exceptions escape typed catch', () async {
      final result = await SendTestRunner.send(
        'open_issues/b5_bridge_wrapped_exception_typed_catch_test.dart',
      );
      expectSuccess(result);
    });

    test('B.6 — switch over a BridgedEnum falls through to null', () async {
      final result = await SendTestRunner.send(
        'open_issues/b6_switch_over_bridged_enum_test.dart',
      );
      expectSuccess(result);
    });

    test('B.7 — _ConstMap missing from Map bridge nativeNames', () async {
      final result = await SendTestRunner.send(
        'open_issues/b7_const_map_native_name_test.dart',
      );
      expectSuccess(result);
    });

    test('B.8 — spurious ! null-check error on nullable static getters',
        () async {
      final result = await SendTestRunner.send(
        'open_issues/b8_null_assert_on_static_getter_test.dart',
      );
      expectSuccess(result);
    });

    test('B.9 — static-field write from sibling static method not persisting',
        () async {
      final result = await SendTestRunner.send(
        'open_issues/b9_static_field_write_sibling_method_test.dart',
      );
      expectSuccess(result);
    });

    test('B.10 — private class with parameterized unnamed constructor',
        () async {
      final result = await SendTestRunner.send(
        'open_issues/b10_private_class_parameterized_ctor_test.dart',
      );
      expectSuccess(result);
    });

    test('B.11 — cold-start flakiness (no parser warmup)', () async {},
        skip: 'B.11 is non-deterministic cold-start flakiness under host load; '
            'it cannot be reproduced as a deterministic single-build failure. '
            'Fix is an interpreter warmup pass.');

    test('B.12 — framework state accumulates; reset API is a no-op', () async {},
        skip: 'B.12 manifests only as cross-/build state accumulation over many '
            'cycles; no single build reproduces it deterministically. Fix is to '
            'clear the native accumulator.');

    test('B.13 — interpreted-element dependents leak on /clear (latent)',
        () async {},
        skip: 'B.13 is latent — the one reproducing script was rewritten and '
            'there is currently no observable single-build failure. Kept on the '
            'radar.');

    test('B.14 — interpreter starves embedder input/frame pump', () async {},
        skip: 'B.14 (cooperative yielding) only manifests with live keyboard '
            'input during long synchronous interpreted runs; it cannot be '
            'reproduced through the build-only HTTP harness. Fix is a resumable '
            'visitor.');
  });

  group('C — generator-fixable issues (reproduced)', () {
    test('C.1 — Curve subclass: no auto-synthesized interface proxy (U3)',
        () async {
      final result = await SendTestRunner.send(
        'open_issues/c1_curve_subclass_proxy_test.dart',
      );
      expectSuccess(result);
    });

    test('C.1 — NotchedShape subclass: no interface proxy (U5)', () async {
      final result = await SendTestRunner.send(
        'open_issues/c1_notched_shape_subclass_proxy_test.dart',
      );
      expectSuccess(result);
    });

    test('C.2 — proxies emitted with <dynamic> type args (LeafRenderObjectWidget)',
        () async {
      final result = await SendTestRunner.send(
        'open_issues/c2_typed_proxy_emission_test.dart',
      );
      expectSuccess(result);
    });

    test('C.3 — non-wrappable arithmetic defaults on positional native ctors',
        () async {},
        skip: 'C.3 (U2) needs a specific bridged constructor whose positional '
            'default is an operator expression (e.g. math.pi * 2). Isolating '
            'the exact throwing constructor requires generator-internal '
            'inspection; not reproduced as a standalone script yet.');

    test('C.4 — getNamedArgWithDefault collapses explicit null vs absent',
        () async {},
        skip: 'C.4 (G1) needs a bridged ctor with a nullable param that has a '
            'non-null default, and the bug is only observable by introspecting '
            'the resulting object property — not assertable through the '
            'build-only harness. Not reproduced as a standalone script yet.');

    test('C.5 — nullable callback param coercion (semanticsBuilder)', () async {
      final result = await SendTestRunner.send(
        'open_issues/c5_nullable_callback_param_coercion_test.dart',
      );
      expectSuccess(result);
    });

    test('C.6 — missing static constructor tearoff (EagerGestureRecognizer.new)',
        () async {
      final result = await SendTestRunner.send(
        'open_issues/c6_eager_gesture_recognizer_tearoff_test.dart',
      );
      expectSuccess(result);
    });
  });
}
