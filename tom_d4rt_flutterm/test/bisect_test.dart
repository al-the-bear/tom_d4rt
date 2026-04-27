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
    'rendering/relayout_when_system_fonts_change_mixin_test.dart',
    'rendering/render_absorb_pointer_test.dart',
    'retest/painting/axis_direction_test.dart',
    'widgets/scroll_position_with_single_context_test.dart',
    'widgets/shortcut_map_property_test.dart',
    'widgets/single_ticker_provider_state_mixin_test.dart',
    'widgets/undo_history_state_test.dart',
  ]) {
    test('$script (C9)', () async {
      final result = await SendTestRunner.send(script);
      print('STATUS: ${result.success}');
      print('FRAMEWORK_ERRORS: ${result.frameworkErrors}');
      print('OUTPUT_COUNT: ${result.output.length}');
    });
  }
}
