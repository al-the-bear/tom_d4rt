/// Auto-split base bridge tests (file 11).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_11_test.dart';

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

  // --- MATERIAL INDIVIDUAL SCRIPTS (74 files) ---
  group('material/ individual', () {
    test('snack_bar_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/snack_bar_action_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('snack_bar_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/snack_bar_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('snack_bar_closed_reason_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/snack_bar_closed_reason_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('spell_check_suggestions_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/spell_check_suggestions_toolbar_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('stepper_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/stepper_type_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('switch_list_tile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/switch_list_tile_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tab_bar_indicator_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_bar_indicator_size_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tab_bar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_bar_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_button_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_button_theme_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_selection_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_selection_toolbar_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_selection_toolbar_text_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_selection_toolbar_text_button_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tooltip_visibility_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tooltip_visibility_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('typography_test.dart', () async {
      final result = await SendTestRunner.send('material/typography_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('visual_density_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/visual_density_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // --- PAINTING INDIVIDUAL SCRIPTS (26 files) ---
  group('painting/ individual', () {
    test('automatic_notched_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/automatic_notched_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('border_directional_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/border_directional_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('box_border_test.dart', () async {
      final result = await SendTestRunner.send('painting/box_border_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('box_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/box_painter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('decoration_image_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/decoration_image_painter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('flutter_logo_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/flutter_logo_decoration_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gradient_test.dart', () async {
      final result = await SendTestRunner.send('painting/gradient_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('image_cache_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_cache_status_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_chunk_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_chunk_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_info_test.dart', () async {
      final result = await SendTestRunner.send('painting/image_info_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('image_stream_completer_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_completer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_stream_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_listener_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_stream_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('linear_border_edge_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/linear_border_edge_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('linear_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/linear_border_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('notched_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/notched_shape_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('outlined_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/outlined_border_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('placeholder_dimensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/placeholder_dimensions_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('placeholder_span_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/placeholder_span_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('resize_image_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/resize_image_key_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('resize_image_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/resize_image_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('rounded_superellipse_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/rounded_superellipse_border_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('shape_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/shape_border_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('star_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/star_border_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('word_boundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/word_boundary_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // --- PHYSICS INDIVIDUAL SCRIPTS (2 files) ---
  group('physics/ individual', () {
    test('clamped_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/clamped_simulation_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gravity_simulation_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/gravity_simulation_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
