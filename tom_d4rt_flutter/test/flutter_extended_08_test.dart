/// Auto-split extended bridge tests (file 08).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_08_test.dart';

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
  // PAINTING PACKAGE (32 files)
  // ============================================================
  group('painting/', () {
    test('accumulator_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/accumulator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('asset_bundle_image_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/asset_bundle_image_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('asset_bundle_image_provider_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/asset_bundle_image_provider_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('axis_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/axis_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('axis_test.dart', () async {
      final result = await SendTestRunner.send('painting/axis_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('border_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/border_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_fit_test.dart', () async {
      final result = await SendTestRunner.send('painting/box_fit_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_shape_test.dart', () async {
      final result = await SendTestRunner.send('painting/box_shape_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('painting/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/clip_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/color_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fitted_sizes_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/fitted_sizes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_logo_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/flutter_logo_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_repeat_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_repeat_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_size_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_size_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_stream_completer_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_completer_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inline_span_semantics_information_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/inline_span_semantics_information_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inline_span_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/inline_span_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrix_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/matrix_utils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_frame_image_stream_completer_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/multi_frame_image_stream_completer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('network_image_load_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/network_image_load_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('one_frame_image_stream_completer_test.dart', () async {
      // 1944 TODO C.75 (2026-05-31): historical 20260523-1056 §1.5/E23
      // (ast) + §2.D contention (test) cold-start-contention wrapper
      // REMOVED. Script runs in ~1.6 s under normal load
      // (httpMs=1569, sourceChars=36482 — 36 KB / 1206-line script).
      final result = await SendTestRunner.send(
        'painting/one_frame_image_stream_completer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('painting_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/painting_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_comparison_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/render_comparison_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('resize_image_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/resize_image_policy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shader_warm_up_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/shader_warm_up_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_overflow_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_overflow_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_width_basis_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_width_basis_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transform_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/transform_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('vertical_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/vertical_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('web_html_element_strategy_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/web_html_element_strategy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('web_image_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/web_image_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // PHYSICS PACKAGE (3 files)
  // ============================================================
  group('physics/', () {
    test('bounded_friction_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/bounded_friction_simulation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('physics/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('spring_type_test.dart', () async {
      final result = await SendTestRunner.send('physics/spring_type_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
