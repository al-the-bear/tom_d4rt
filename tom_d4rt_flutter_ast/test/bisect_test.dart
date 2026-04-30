/// Bisect test harness — probe which "clean failure" test crashes the app.
///
/// The 3 previously-suspected tests all pass FE=0 in isolation.
/// The cascade in the full retest suite started after context_action_test
/// failed — check whether any of the clean-failure tests (back_button,
/// box_scroll, context_action) leave the app dead for the canary.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp();
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  // ── Probe A: back_button_listener_test (Router generic factory error) ────
  test('[probeA] back_button_listener_test.dart', () async {
    final result = await SendTestRunner.send(
      'retest/widgets/back_button_listener_test.dart',
    );
    print('STATUS: ${result.success}  FE: ${result.frameworkErrors}');
  });

  test('[canary after A] render_darwin_platform_view_test.dart', () async {
    final result = await SendTestRunner.send(
      'rendering/render_darwin_platform_view_test.dart',
    );
    print('CANARY-A STATUS: ${result.success}  FE: ${result.frameworkErrors}');
    expect(result.success, isTrue, reason: 'canary-A failed — probe-A crashed the app');
  });

  // ── Probe B: box_scroll_view_test (SizedBox child error) ─────────────────
  test('[probeB] box_scroll_view_test.dart', () async {
    final result = await SendTestRunner.send(
      'retest/widgets/box_scroll_view_test.dart',
    );
    print('STATUS: ${result.success}  FE: ${result.frameworkErrors}');
  });

  test('[canary after B] render_darwin_platform_view_test.dart', () async {
    final result = await SendTestRunner.send(
      'rendering/render_darwin_platform_view_test.dart',
    );
    print('CANARY-B STATUS: ${result.success}  FE: ${result.frameworkErrors}');
    expect(result.success, isTrue, reason: 'canary-B failed — probe-B crashed the app');
  });

  // ── Probe C: context_action_test (Actions Map<Type,Action<Intent>> error) ─
  test('[probeC] context_action_test.dart', () async {
    final result = await SendTestRunner.send(
      'retest/widgets/context_action_test.dart',
    );
    print('STATUS: ${result.success}  FE: ${result.frameworkErrors}');
  });

  test('[canary after C] render_darwin_platform_view_test.dart', () async {
    final result = await SendTestRunner.send(
      'rendering/render_darwin_platform_view_test.dart',
    );
    print('CANARY-C STATUS: ${result.success}  FE: ${result.frameworkErrors}');
    expect(result.success, isTrue, reason: 'canary-C failed — probe-C crashed the app');
  });
}
