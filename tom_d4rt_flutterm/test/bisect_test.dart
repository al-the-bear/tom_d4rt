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
    // Deprecated API tests (secondary_classes_test.dart)
    'material/button_types_test.dart',        // ButtonBar deprecated
    'material/toggle_segmented_test.dart',    // ButtonBar deprecated
    'material/button_styles_misc_test.dart',  // ButtonBarThemeData deprecated
    'widgets/platform_menu_widgets_test.dart', // RawKeyboardListener deprecated
    // Interactive dialog tests (plain send, no interaction)
    'material/showdialog_test.dart',
    'material/showbottomsheet_test.dart',
    'material/showmenu_test.dart',
    'material/showdatepicker_test.dart',
    'material/showtimepicker_test.dart',
  ]) {
    test(script, () async {
      final result = await SendTestRunner.send(script);
      print('STATUS: ${result.success}');
      print('FRAMEWORK_ERRORS: ${result.frameworkErrors}');
      print('OUTPUT_COUNT: ${result.output.length}');
    });
  }
}
