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
    // D7 — SlottedContainerRenderObjectMixin cluster. Option (1) of
    // C1 (slot-mixin proxy variant) closed the createRenderObject
    // assertion in all 3 scripts; element_test fully clean. The two
    // multi_child_* scripts have residual layout cascades that this
    // round investigates.
    'widgets/slotted_render_object_element_test.dart',
    'widgets/slotted_multi_child_render_object_widget_mixin_test.dart',
    'widgets/slotted_multi_child_render_object_widget_test.dart',
  ]) {
    test(script, () async {
      final result = await SendTestRunner.send(script);
      print('STATUS: ${result.success}');
      print('FRAMEWORK_ERRORS: ${result.frameworkErrors}');
      print('OUTPUT_COUNT: ${result.output.length}');
    });
  }
}
