/// Fa2 isolation harness — minimal reproducers for the state-field
/// ScrollController null-check pattern. See
/// `doc/testlog_20260428-1333-issue-analysis/error_analysis.md` (Fa2).
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

  for (final script in const <String>[
    'repro_fa2/state_field_controller_min.dart',
    'repro_fa2/state_field_controller_local.dart',
    'repro_fa2/state_field_controller_two_lanes.dart',
    'repro_fa2/state_field_controller_sliver.dart',
    'repro_fa2/state_field_controller_full.dart',
    'repro_fa2/scrolling_pill.dart',
    'repro_fa2/scroll_decel_minus_telemetry.dart',
    'repro_fa2/ternary_position_maxscroll.dart',
  ]) {
    test('[fa2] $script', () async {
      final result = await SendTestRunner.send(script);
      print(
        'FA2 STATUS: ${result.success}  FE: ${result.frameworkErrors.length}  SCRIPT: $script',
      );
      for (final err in result.frameworkErrors) {
        print('  ERR: $err');
      }
    });
  }
}
