/// Auto-split base bridge tests (file 06).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_06_test.dart';

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
  // MATERIAL PACKAGE TESTS (22 files)
  // ============================================================
  group('material/', () {
    // --- Batch 1 ---
    test('buttonstyle_popup_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/buttonstyle_popup_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('chip_variants_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/chip_variants_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('datetime_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/datetime_utils_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fablocation_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fablocation_messenger_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('texttheme_test.dart', () async {
      final result = await SendTestRunner.send('material/texttheme_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 2 ---
    test('input_borders_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_borders_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('button_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_types_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scaffold_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tab_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_indicator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('popup_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autocomplete_datepicker_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/autocomplete_datepicker_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/chip_attributes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('color_scheme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/color_scheme_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('divider_listtile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/divider_listtile_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('menu_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('progress_sheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/progress_sheet_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tooltip_feedback_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tooltip_feedback_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('expansion_stepper_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/expansion_stepper_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 3 ---
    test('nav_badge_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/nav_badge_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('search_filled_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/search_filled_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('themes_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/themes_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 4 ---
    test('data_table_test.dart', () async {
      final result = await SendTestRunner.send('material/data_table_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('toggle_segmented_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/toggle_segmented_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('reorderable_material_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/reorderable_material_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('search_anchor_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/search_anchor_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scaffold_internals_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_internals_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('fab_location_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_location_types_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 5 ---
    test('bottom_app_bar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_app_bar_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dropdown_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_field_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_field_theme_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('card_ink_splash_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/card_ink_splash_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_bottom_sheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_bottom_sheet_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 6-9 ---
    test('scaffold_fab_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_fab_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('button_styles_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_styles_misc_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autocomplete_chips_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/autocomplete_chips_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // PAINTING PACKAGE TESTS (7 files)
  // ============================================================
  group('painting/', () {
    // --- Batch 1 ---
    test('enums_painting_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/enums_painting_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gradient_transform_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/gradient_transform_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('image_cache_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_cache_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('imagestream_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/imagestream_misc_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('matrixutils_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/matrixutils_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('notched_shapes_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/notched_shapes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 3 ---
    test('advanced_decorations_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/advanced_decorations_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 6-9 ---
    test('image_stream_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // PHYSICS PACKAGE TESTS (1 file)
  // ============================================================
  group('physics/', () {
    test('springdescription_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/springdescription_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // RENDERING PACKAGE TESTS (5 files)
  // ============================================================
  group('rendering/', () {
    // --- Batch 1 ---
    test('hittest_pipeline_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/hittest_pipeline_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 3 ---
    test('render_box_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_box_types_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_pointer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('layer_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/layer_types_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_composite_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_composite_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 4 ---
    test('render_objects_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_objects_misc_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 5 ---
    test('render_sliver_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_types_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 6-9 ---
    test('render_mixins_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_mixins_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_layers_pipeline_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_layers_pipeline_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // SCHEDULER PACKAGE TESTS (1 file)
  // ============================================================
  group('scheduler/', () {
    test('scheduler_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/scheduler_misc_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // SEMANTICS PACKAGE TESTS (3 files)
  // ============================================================
  group('semantics/', () {
    // --- Batch 1 ---
    test('semantics_properties_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_properties_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 3 ---
    test('semantics_events_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_events_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('semantics_config_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_config_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // SERVICES PACKAGE TESTS (4 files)
  // ============================================================
  group('services/', () {
    // --- Batch 1 ---
    test('system_chrome_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_chrome_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_editing_value_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_value_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 3 ---
    test('services_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/services_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('platform_channels_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_channels_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 5 ---
    test('key_events_test.dart', () async {
      final result = await SendTestRunner.send('services/key_events_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 6-9 ---
    test('restoration_platform_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/restoration_platform_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('key_events_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_events_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
