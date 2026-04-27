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
    'widgets/sliver_multi_box_adaptor_element_test.dart',
    'widgets/slotted_multi_child_render_object_widget_test.dart',
    'widgets/update_selection_intent_test.dart',
    'widgets/weak_map_test.dart',
  ]) {
    test('$script (C11)', () async {
      final result = await SendTestRunner.send(script);
      print('STATUS: ${result.success}');
      print('FRAMEWORK_ERRORS: ${result.frameworkErrors}');
      print('OUTPUT_COUNT: ${result.output.length}');
    });
  }
}
