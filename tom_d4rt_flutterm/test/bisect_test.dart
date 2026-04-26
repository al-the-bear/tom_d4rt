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

  test('widgets/slotted_multi_child_render_object_widget_test.dart (C4)',
      () async {
    final result = await SendTestRunner.send(
        'widgets/slotted_multi_child_render_object_widget_test.dart');
    print('STATUS: ${result.success}');
    print('FRAMEWORK_ERRORS: ${result.frameworkErrors}');
    print('OUTPUT_COUNT: ${result.output.length}');
    final fwErrors =
        result.output.where((s) => s.contains('Runtime Error')).take(5);
    for (final e in fwErrors) {
      print('FW: $e');
    }
  });

  test('widgets/slotted_multi_child_render_object_widget_mixin_test.dart (C4)',
      () async {
    final result = await SendTestRunner.send(
        'widgets/slotted_multi_child_render_object_widget_mixin_test.dart');
    print('STATUS: ${result.success}');
    print('FRAMEWORK_ERRORS: ${result.frameworkErrors}');
    print('OUTPUT_COUNT: ${result.output.length}');
    final fwErrors =
        result.output.where((s) => s.contains('Runtime Error')).take(5);
    for (final e in fwErrors) {
      print('FW: $e');
    }
  });
}
