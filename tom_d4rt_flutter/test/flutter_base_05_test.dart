/// Auto-split base bridge tests (file 05).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_05_test.dart';

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
  // DART:UI PACKAGE TESTS (6 files)
  // ============================================================
  group('dart_ui/', () {
    test('paragraph_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/paragraph_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('text_data_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/text_data_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('filters_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/filters_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('font_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/font_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('vertices_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/vertices_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('picture_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/picture_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // GESTURES PACKAGE TESTS (2 files)
  // ============================================================
  group('gestures/', () {
    test('recognizers_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/recognizers_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('velocity_test.dart', () async {
      final result = await SendTestRunner.send('gestures/velocity_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // SERVICES PACKAGE TESTS (8 files)
  // ============================================================
  group('services/', () {
    test('codecs_test.dart', () async {
      final result = await SendTestRunner.send('services/codecs_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('channels_test.dart', () async {
      final result = await SendTestRunner.send('services/channels_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('keyboard_test.dart', () async {
      final result = await SendTestRunner.send('services/keyboard_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('cursor_test.dart', () async {
      final result = await SendTestRunner.send('services/cursor_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('textboundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/textboundary_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('spellcheck_test.dart', () async {
      final result = await SendTestRunner.send('services/spellcheck_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('platform_test.dart', () async {
      final result = await SendTestRunner.send('services/platform_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('asset_test.dart', () async {
      final result = await SendTestRunner.send('services/asset_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // SEMANTICS PACKAGE TESTS (1 file)
  // ============================================================
  group('semantics/', () {
    test('semantics_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // SCHEDULER PACKAGE TESTS (1 file)
  // ============================================================
  group('scheduler/', () {
    test('tickerfuture_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/tickerfuture_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // RENDERING PACKAGE TESTS (10 files)
  // ============================================================
  group('rendering/', () {
    test('renderobjects_basic_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_basic_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('renderobjects_clip_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_clip_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('renderobjects_layout_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_layout_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('renderobjects_sizing_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_sizing_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('renderobjects_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_sliver_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('renderobjects_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('canvas_test.dart', () async {
      final result = await SendTestRunner.send('rendering/canvas_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('layers_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/layers_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_delegates_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_delegates_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('parentdata_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/parentdata_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gradient_rendering_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/gradient_rendering_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // PROXY CLASS TESTS (5 files) — Phase 4: GEN-083
  // ============================================================
  group('proxies/', () {
    test('custompaint_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/custompaint_proxy_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('customclipper_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/customclipper_proxy_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('flowdelegate_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/flowdelegate_proxy_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('multichildlayout_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/multichildlayout_proxy_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('singlechildlayout_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/singlechildlayout_proxy_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // ANIMATION PACKAGE TESTS (1 file)
  // ============================================================
  group('animation/', () {
    test('animation_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_status_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 6-9 ---
    test('animation_misc_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_misc_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // CUPERTINO PACKAGE TESTS (7 files)
  // ============================================================
  group('cupertino/', () {
    // --- Batch 1 ---
    test('cupertino_secondary_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_secondary_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 3 ---
    test('cupertino_nav_segmented_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_nav_segmented_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_form_scroll_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_form_scroll_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_controls_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_controls_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_picker_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_picker_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_theming_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_theming_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_sections_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_sections_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 4 ---
    test('cupertino_refresh_mag_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_refresh_mag_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 5 ---
    test('cupertino_tabbar_scaffold_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_tabbar_scaffold_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_page_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_page_route_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_colors_system_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_colors_system_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 6-9 ---
    test('cupertino_misc_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_misc_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // DART:UI PACKAGE TESTS (3 files)
  // ============================================================
  group('dart_ui/', () {
    // --- Batch 1 ---
    test('enums_ui_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/enums_ui_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 3 ---
    test('dart_ui_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_ui_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dart_ui_paint_canvas_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_ui_paint_canvas_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 5 ---
    test('dart_ui_image_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_ui_image_codec_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 6-9 ---
    test('dart_ui_misc_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_ui_misc_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // FOUNDATION PACKAGE TESTS (4 files)
  // ============================================================
  group('foundation/', () {
    test('buffers_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/buffers_misc_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('observer_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/observer_list_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('synchronousfuture_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/synchronousfuture_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('targetplatform_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/targetplatform_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 6-9 ---
    test('foundation_misc_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/foundation_misc_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // GESTURES PACKAGE TESTS (3 files)
  // ============================================================
  group('gestures/', () {
    // --- Batch 1 ---
    test('scale_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/scale_details_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 3 ---
    test('velocity_drag_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/velocity_drag_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tap_force_test.dart', () async {
      final result = await SendTestRunner.send('gestures/tap_force_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 6-9 ---
    test('gesture_callbacks_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_callbacks_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gesture_callbacks_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_callbacks_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
