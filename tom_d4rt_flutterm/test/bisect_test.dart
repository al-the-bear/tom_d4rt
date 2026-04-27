/// Bisect test harness
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

  for (final script in <String>[
    // C4 / D5 carryover — PreferredSizeWidget interface proxy +
    // single-arg Widget coercion through static bridged methods.
    'widgets/widgets_binding_observer_test.dart',
    'widgets/sliver_multi_box_adaptor_widget_test.dart',
    'widgets/snapshot_mode_test.dart',
    'widgets/undo_text_intent_test.dart',
    'widgets/viewport_element_mixin_test.dart',
    'widgets/viewport_notification_mixin_test.dart',
    'widgets/widget_inspector_service_test.dart',
    'widgets/widgets_binding_test.dart',
  ]) {
    test(script, () async {
      final result = await SendTestRunner.send(script);
      print('STATUS: ${result.success}');
      print('FRAMEWORK_ERRORS: ${result.frameworkErrors}');
      print('OUTPUT_COUNT: ${result.output.length}');
    });
  }
}
