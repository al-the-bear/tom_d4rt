/// Auto-split extended bridge tests (file 02).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_02_test.dart';

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

  // ============================================================
  // DART:UI PACKAGE (76 files)
  // ============================================================
  group('dart_ui/', () {
    test('app_exit_response_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/app_exit_response_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_exit_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/app_exit_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_lifecycle_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/app_lifecycle_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('backdrop_filter_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/backdrop_filter_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('blend_mode_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/blend_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('blur_style_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/blur_style_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_height_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/box_height_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_width_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/box_width_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('callback_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/callback_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('channel_buffers_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/channel_buffers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('checked_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/checked_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      // 1944 TODO C.47 (2026-05-31): historical 20260523-1056 §1.4/E11
      // cold-start-contention wrapper REMOVED. Despite being 3275
      // lines / 109 KB / 1.3 MB bundle, this script only does class
      // definitions / sample setup (light runtime work) and builds
      // in ~2.1 s under normal load (httpMs=2141,
      // bundleJsonBytes=1312534).
      final result = await SendTestRunner.send('dart_ui/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_op_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/clip_op_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_path_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/clip_path_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_r_rect_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/clip_r_rect_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_r_superellipse_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/clip_r_superellipse_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_rect_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/clip_rect_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/clip_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_filter_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/color_filter_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_space_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/color_space_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_performance_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_performance_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_plugin_registrant_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_plugin_registrant_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('display_feature_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/display_feature_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('display_feature_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/display_feature_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('filter_quality_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/filter_quality_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('font_style_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/font_style_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('fragment_program_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/fragment_program_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fragment_shader_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/fragment_shader_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('frame_phase_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/frame_phase_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_byte_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/image_byte_format_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_filter_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/image_filter_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_sampler_slot_test.dart', () async {
      // 1944 TODO C.48 (2026-05-31): historical 20260525 §6.1/D1
      // "wedge" (originally diagnosed from 20260427 Linux baseline,
      // later identified as §U25-family cold-start-cascade
      // misattribution) wrapper REMOVED. Script bundles to 448 KB
      // AST and runs in ~2.0 s under normal load (httpMs=2015,
      // bundleJsonBytes=448705).
      final result = await SendTestRunner.send(
        'dart_ui/image_sampler_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'isolate_name_server_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'dart_ui/isolate_name_server_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
      // IsolateNameServer requires real Dart isolate infrastructure
      // (Isolate.spawn, cross-isolate SendPort/ReceivePort, port registration).
      // The d4rt interpreter does not support real isolate execution — only
      // limited async/await simulation — so this API is unavailable.
      skip:
          'IsolateNameServer is not supported by the d4rt interpreter '
          '(requires real Dart isolate infrastructure)',
    );

    test('key_event_device_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/key_event_device_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/key_event_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('offset_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/offset_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('opacity_engine_layer_test.dart', () async {
      // 1944 TODO C.49 (2026-05-31): historical 20260523-1056 §1.4/E12
      // (= §S/S2 wedge-candidate cluster) cold-start-contention
      // wrapper REMOVED. Script runs in ~4.4 s under normal load
      // (httpMs=4404, bundleJsonBytes=465112 — 465 KB bundle).
      // Slower than typical but well within 30s default headroom.
      final result = await SendTestRunner.send(
        'dart_ui/opacity_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/painting_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('path_fill_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/path_fill_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('path_operation_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/path_operation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('picture_rasterization_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/picture_rasterization_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pixel_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pixel_format_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('placeholder_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/placeholder_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('plugin_utilities_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/plugin_utilities_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('point_mode_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/point_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_change_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pointer_change_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_device_kind_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pointer_device_kind_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_signal_kind_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pointer_signal_kind_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_isolate_token_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/root_isolate_token_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_hit_test_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_input_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_input_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_role_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_role_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_validation_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_validation_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shader_mask_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/shader_mask_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('singleton_flutter_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/singleton_flutter_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stroke_cap_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/stroke_cap_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('stroke_join_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/stroke_join_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_color_palette_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/system_color_palette_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('target_pixel_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/target_pixel_format_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
