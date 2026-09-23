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
      SendTestRunner.expectSuccess(result);
    });

    test('asset_bundle_image_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/asset_bundle_image_key_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('asset_bundle_image_provider_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/asset_bundle_image_provider_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('axis_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/axis_direction_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('axis_test.dart', () async {
      final result = await SendTestRunner.send('painting/axis_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('border_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/border_style_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('box_fit_test.dart', () async {
      final result = await SendTestRunner.send('painting/box_fit_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('box_shape_test.dart', () async {
      final result = await SendTestRunner.send('painting/box_shape_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('painting/class_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('clip_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/clip_context_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('color_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/color_property_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fitted_sizes_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/fitted_sizes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('flutter_logo_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/flutter_logo_style_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_repeat_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_repeat_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_size_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_size_info_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_stream_completer_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_completer_handle_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inline_span_semantics_information_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/inline_span_semantics_information_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inline_span_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/inline_span_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('matrix_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/matrix_utils_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('multi_frame_image_stream_completer_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/multi_frame_image_stream_completer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('network_image_load_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/network_image_load_exception_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('one_frame_image_stream_completer_test.dart', () async {
      // 1944 TODO C.69 (2026-05-31): historical 20260523-1056 §1.5/E23
      // cold-start-contention wrapper REMOVED. Script runs in ~1.5 s
      // under normal load (httpMs=1488, bundleJsonBytes=406020 —
      // 406 KB bundle / 36 KB / 1206-line script).
      final result = await SendTestRunner.send(
        'painting/one_frame_image_stream_completer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('painting_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/painting_binding_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_comparison_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/render_comparison_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('resize_image_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/resize_image_policy_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('shader_warm_up_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/shader_warm_up_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_overflow_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_overflow_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_width_basis_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_width_basis_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('transform_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/transform_property_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('vertical_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/vertical_direction_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('web_html_element_strategy_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/web_html_element_strategy_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('web_image_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/web_image_info_test.dart',
      );
      SendTestRunner.expectSuccess(result);
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
      SendTestRunner.expectSuccess(result);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('physics/class_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('spring_type_test.dart', () async {
      final result = await SendTestRunner.send('physics/spring_type_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });
}
