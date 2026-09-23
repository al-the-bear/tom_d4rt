/// Auto-split base bridge tests (file 08).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_08_test.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(suite: _kTestFileName);
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Test App Health', () {
    test('app is running', () async {
      final isRunning = await SendTestRunner.isAppRunning();
      expect(
        isRunning,
        isTrue,
        reason: 'Test app should be running (managed by setUpAll).',
      );
    });
  });

  // --- DART:UI INDIVIDUAL SCRIPTS (35 files) ---
  group('dart_ui/ individual', () {
    test('accessibility_features_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/accessibility_features_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('brightness_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/brightness_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('codec_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/codec_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('display_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/display_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('flutter_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/flutter_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('frame_data_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/frame_data_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('frame_info_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/frame_info_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('frame_timing_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/frame_timing_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gesture_settings_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/gesture_settings_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_descriptor_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/image_descriptor_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('immutable_buffer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/immutable_buffer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('key_data_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/key_data_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('locale_string_attribute_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/locale_string_attribute_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('offset_base_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/offset_base_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('path_metric_iterator_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/path_metric_iterator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('path_metric_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/path_metric_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('path_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/path_metrics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('platform_dispatcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/platform_dispatcher_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('pointer_data_packet_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pointer_data_packet_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('pointer_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pointer_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('r_superellipse_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/r_superellipse_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scene_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/scene_builder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scene_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/scene_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('semantics_action_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_action_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('semantics_flag_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_flag_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('semantics_flags_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_flags_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('semantics_update_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_update_builder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('semantics_update_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_update_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('spell_out_string_attribute_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/spell_out_string_attribute_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('string_attribute_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/string_attribute_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('system_color_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/system_color_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('target_image_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/target_image_size_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('view_constraints_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/view_constraints_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('view_focus_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/view_focus_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // --- FOUNDATION INDIVIDUAL SCRIPTS (13 files) ---
  group('foundation/ individual', () {
    test('aggregated_timed_block_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/aggregated_timed_block_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('aggregated_timings_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/aggregated_timings_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('bit_field_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/bit_field_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('flutter_timeline_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/flutter_timeline_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('partial_stack_frame_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/partial_stack_frame_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('persistent_hash_map_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/persistent_hash_map_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('read_buffer_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/read_buffer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('repetitive_stack_frame_filter_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/repetitive_stack_frame_filter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('stack_filter_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/stack_filter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('stack_frame_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/stack_frame_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('timed_block_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/timed_block_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('unicode_test.dart', () async {
      final result = await SendTestRunner.send('foundation/unicode_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('write_buffer_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/write_buffer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
