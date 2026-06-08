/// Auto-split extended bridge tests (file 01).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
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
  // ANIMATION PACKAGE (31 files)
  // ============================================================
  group('animation/', () {
    test('animation_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_eager_listener_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_eager_listener_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_lazy_listener_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_lazy_listener_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_local_listeners_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_local_listeners_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_local_status_listeners_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_local_status_listeners_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('catmull_rom_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/catmull_rom_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('catmull_rom_spline_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/catmull_rom_spline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('animation/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/color_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('constant_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/constant_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cubic_test.dart', () async {
      final result = await SendTestRunner.send('animation/cubic_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('curve2_d_sample_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/curve2_d_sample_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('curve2_d_test.dart', () async {
      final result = await SendTestRunner.send('animation/curve2_d_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('curve_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/curve_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('curves_test.dart', () async {
      final result = await SendTestRunner.send('animation/curves_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('elastic_in_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/elastic_in_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('elastic_in_out_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/elastic_in_out_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('elastic_out_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/elastic_out_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flipped_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/flipped_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('int_tween_test.dart', () async {
      final result = await SendTestRunner.send('animation/int_tween_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('interval_test.dart', () async {
      final result = await SendTestRunner.send('animation/interval_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('parametric_curve_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/parametric_curve_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rect_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/rect_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reverse_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/reverse_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('saw_tooth_test.dart', () async {
      final result = await SendTestRunner.send('animation/saw_tooth_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('size_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/size_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('split_test.dart', () async {
      final result = await SendTestRunner.send('animation/split_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('step_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/step_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('three_point_cubic_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/three_point_cubic_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('threshold_test.dart', () async {
      final result = await SendTestRunner.send('animation/threshold_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // CUPERTINO PACKAGE (15 files)
  // ============================================================
  group('cupertino/', () {
    test('class_test.dart', () async {
      // 1944 TODO C.55 (2026-05-31): historical 20260523-1056 §1.4/E10
      // (ast) + §2.D contention (test) cold-start-contention wrapper
      // REMOVED. Script runs in ~3.5 s under normal load
      // (httpMs=3485, sourceChars=70095 — 70 KB / 1723-line script).
      final result = await SendTestRunner.send('cupertino/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_button_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_button_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_desktop_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_desktop_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_expansion_tile_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_expansion_tile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_focus_halo_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_focus_halo_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_linear_activity_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_linear_activity_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_list_section_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_list_section_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_list_tile_chevron_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_list_tile_chevron_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_text_selection_handle_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_text_selection_handle_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_thumb_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_thumb_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expansion_tile_transition_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/expansion_tile_transition_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_cupertino_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/inherited_cupertino_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_bar_bottom_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/navigation_bar_bottom_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_visibility_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/overlay_visibility_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_cupertino_tab_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/restorable_cupertino_tab_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
