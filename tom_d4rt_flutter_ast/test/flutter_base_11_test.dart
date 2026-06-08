/// Auto-split base bridge tests (file 11).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
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

  // --- MATERIAL INDIVIDUAL SCRIPTS (74 files) ---
  group('material/ individual', () {
    test('snack_bar_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/snack_bar_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snack_bar_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/snack_bar_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snack_bar_closed_reason_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/snack_bar_closed_reason_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('spell_check_suggestions_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/spell_check_suggestions_toolbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stepper_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/stepper_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('switch_list_tile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/switch_list_tile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tab_bar_indicator_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_bar_indicator_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tab_bar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_bar_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_button_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_button_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_selection_toolbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_toolbar_text_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_selection_toolbar_text_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_visibility_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tooltip_visibility_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('typography_test.dart', () async {
      final result = await SendTestRunner.send('material/typography_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('visual_density_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/visual_density_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // --- PAINTING INDIVIDUAL SCRIPTS (26 files) ---
  group('painting/ individual', () {
    test('automatic_notched_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/automatic_notched_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('border_directional_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/border_directional_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_border_test.dart', () async {
      final result = await SendTestRunner.send('painting/box_border_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/box_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('decoration_image_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/decoration_image_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_logo_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/flutter_logo_decoration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gradient_test.dart', () async {
      final result = await SendTestRunner.send('painting/gradient_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_cache_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_cache_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_chunk_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_chunk_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_info_test.dart', () async {
      final result = await SendTestRunner.send('painting/image_info_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_stream_completer_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_completer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_stream_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_stream_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('linear_border_edge_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/linear_border_edge_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('linear_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/linear_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notched_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/notched_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('outlined_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/outlined_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('placeholder_dimensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/placeholder_dimensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('placeholder_span_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/placeholder_span_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('resize_image_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/resize_image_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('resize_image_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/resize_image_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rounded_superellipse_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/rounded_superellipse_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shape_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/shape_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('star_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/star_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('word_boundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/word_boundary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // --- PHYSICS INDIVIDUAL SCRIPTS (2 files) ---
  group('physics/ individual', () {
    test('clamped_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/clamped_simulation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gravity_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/gravity_simulation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
