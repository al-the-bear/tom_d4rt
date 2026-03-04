/// Tests for secondary Flutter bridge classes.
///
/// These tests use the SendTestRunner to send D4rt scripts to the test app
/// and verify they execute correctly. Each test corresponds to a script
/// in the send_ast_via_http_scripts directory.
///
/// Prerequisites:
/// 1. Start the test app: cd test/tom_d4rt_flutterm_app && flutter run
/// 2. Run tests: flutter test test/secondary_classes_test.dart
///
/// Tests are organized by Flutter package and test the bridged classes
/// listed in testplan_secondary.md.
///
/// Total: 654 test entries (145 batch scripts + 509 individual class scripts)
///   Batch 1-9: 145 scripts (~950 classes, multi-class per file)
///   Individual: 509 scripts (1 class per file, secondary priority)
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
        reason:
            'Test app must be running. '
            'Start it with: cd test/tom_d4rt_flutterm_app && flutter run',
      );
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
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 6-9 ---
    test('animation_misc_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_misc_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
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
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 3 ---
    test('cupertino_nav_segmented_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_nav_segmented_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_form_scroll_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_form_scroll_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_controls_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_controls_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_picker_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_picker_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_theming_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_theming_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_sections_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_sections_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 4 ---
    test('cupertino_refresh_mag_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_refresh_mag_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 5 ---
    test('cupertino_tabbar_scaffold_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_tabbar_scaffold_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_page_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_page_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_colors_system_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_colors_system_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 6-9 ---
    test('cupertino_misc_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_misc_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // DART:UI PACKAGE TESTS (3 files)
  // ============================================================
  group('dart_ui/', () {
    // --- Batch 1 ---
    test('enums_ui_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/enums_ui_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 3 ---
    test('dart_ui_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_ui_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dart_ui_paint_canvas_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_ui_paint_canvas_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 5 ---
    test('dart_ui_image_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_ui_image_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 6-9 ---
    test('dart_ui_misc_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/dart_ui_misc_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
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
      expect(result.success, isTrue, reason: result.error);
    });

    test('observer_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/observer_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('synchronousfuture_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/synchronousfuture_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('targetplatform_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/targetplatform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 6-9 ---
    test('foundation_misc_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/foundation_misc_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
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
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 3 ---
    test('velocity_drag_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/velocity_drag_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_force_test.dart', () async {
      final result = await SendTestRunner.send('gestures/tap_force_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 6-9 ---
    test('gesture_callbacks_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_callbacks_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_callbacks_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/gesture_callbacks_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
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
      expect(result.success, isTrue, reason: result.error);
    });

    test('chip_variants_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/chip_variants_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('datetime_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/datetime_utils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fablocation_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fablocation_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('texttheme_test.dart', () async {
      final result = await SendTestRunner.send('material/texttheme_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 2 ---
    test('input_borders_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_borders_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('button_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tab_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/popup_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_datepicker_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/autocomplete_datepicker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_scheme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/color_scheme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('divider_listtile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/divider_listtile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('progress_sheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/progress_sheet_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_feedback_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tooltip_feedback_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expansion_stepper_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/expansion_stepper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 3 ---
    test('nav_badge_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/nav_badge_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('search_filled_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/search_filled_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('themes_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/themes_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 4 ---
    test('data_table_test.dart', () async {
      final result = await SendTestRunner.send('material/data_table_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('toggle_segmented_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/toggle_segmented_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reorderable_material_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/reorderable_material_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('search_anchor_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/search_anchor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_internals_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_internals_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fab_location_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fab_location_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 5 ---
    test('bottom_app_bar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_app_bar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dropdown_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdown_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_field_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_field_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('card_ink_splash_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/card_ink_splash_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_bottom_sheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_bottom_sheet_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 6-9 ---
    test('scaffold_fab_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_fab_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('button_styles_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_styles_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autocomplete_chips_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/autocomplete_chips_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
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
      expect(result.success, isTrue, reason: result.error);
    });

    test('gradient_transform_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/gradient_transform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_cache_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_cache_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('imagestream_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/imagestream_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrixutils_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/matrixutils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notched_shapes_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/notched_shapes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 3 ---
    test('advanced_decorations_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/advanced_decorations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 6-9 ---
    test('image_stream_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_stream_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
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
      expect(result.success, isTrue, reason: result.error);
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
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 3 ---
    test('render_box_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_box_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('layer_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/layer_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_composite_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_composite_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 4 ---
    test('render_objects_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_objects_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 5 ---
    test('render_sliver_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 6-9 ---
    test('render_mixins_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_mixins_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_layers_pipeline_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_layers_pipeline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
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
      expect(result.success, isTrue, reason: result.error);
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
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 3 ---
    test('semantics_events_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_events_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_config_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_config_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
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
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_value_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_value_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 3 ---
    test('services_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/services_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_channels_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_channels_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 5 ---
    test('key_events_test.dart', () async {
      final result = await SendTestRunner.send('services/key_events_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 6-9 ---
    test('restoration_platform_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/restoration_platform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_events_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_events_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // WIDGETS PACKAGE TESTS (41 files)
  // ============================================================
  group('widgets/', () {
    // --- Batch 1 ---
    test('defaulttextstyle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/defaulttextstyle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_properties_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_properties_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyedsubtree_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keyedsubtree_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('physicalmodel_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/physicalmodel_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('placeholder_test.dart', () async {
      final result = await SendTestRunner.send('widgets/placeholder_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('preferredsize_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/preferredsize_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_values_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_values_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollbar_layout_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollbar_layout_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollphysics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollphysics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shaderfilter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shaderfilter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcuts_actions_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcuts_actions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_delegates_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_delegates_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('textspan_test.dart', () async {
      final result = await SendTestRunner.send('widgets/textspan_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 2 ---
    test('scroll_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('display_feature_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/display_feature_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restoration_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restoration_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_history_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/undo_history_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('actions_intents_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/actions_intents_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_widgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_widgets_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('context_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_magnifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_magnifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notification_locale_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notification_locale_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_traversal_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_traversal_advanced_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_widgets_test.dart', () async {
      final result = await SendTestRunner.send('widgets/raw_widgets_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('editable_text_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 4 ---
    test('scroll_notifications_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_notifications_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_model_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_wrap_flow_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/table_wrap_flow_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_portal_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_portal_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_detector_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesture_detector_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('media_query_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/media_query_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_observer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_observer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('interactive_viewer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/interactive_viewer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 5 ---
    test('animated_widgets_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_widgets_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('form_field_test.dart', () async {
      final result = await SendTestRunner.send('widgets/form_field_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('layout_builder_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/layout_builder_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_view_tabview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_view_tabview_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('draggable_sheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_sheet_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 6-9 ---
    test('element_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/element_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_widgets_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_widgets_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_widgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_widgets_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_position_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_position_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_controllers_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_controllers_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_types_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_editing_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restoration_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restoration_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcuts_actions_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcuts_actions_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_context_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_context_adv_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SECONDARY CLASSES - INDIVIDUAL SCRIPTS (509 files)
  // ============================================================

  // --- ANIMATION INDIVIDUAL SCRIPTS (4 files) ---
  group('animation/ individual', () {
    test('animation_max_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_max_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_mean_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_mean_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_min_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_min_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_with_parent_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_with_parent_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // --- CUPERTINO INDIVIDUAL SCRIPTS (9 files) ---
  group('cupertino/ individual', () {
    test('cupertino_page_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_page_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_picker_default_selection_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_picker_default_selection_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_scroll_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_scroll_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_sheet_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_sheet_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_sheet_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_sheet_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_spell_check_suggestions_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_spell_check_suggestions_toolbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_text_magnifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_text_magnifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('obstructing_preferred_size_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/obstructing_preferred_size_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // --- DART:UI INDIVIDUAL SCRIPTS (35 files) ---
  group('dart_ui/ individual', () {
    test('accessibility_features_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/accessibility_features_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('brightness_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/brightness_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('display_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/display_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/flutter_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('frame_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/frame_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('frame_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/frame_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('frame_timing_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/frame_timing_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesture_settings_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/gesture_settings_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_descriptor_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/image_descriptor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('immutable_buffer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/immutable_buffer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/key_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('locale_string_attribute_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/locale_string_attribute_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('offset_base_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/offset_base_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('path_metric_iterator_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/path_metric_iterator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('path_metric_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/path_metric_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('path_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/path_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_dispatcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/platform_dispatcher_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_data_packet_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pointer_data_packet_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pointer_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/pointer_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('r_superellipse_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/r_superellipse_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scene_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/scene_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scene_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/scene_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_action_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_action_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_flag_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_flag_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_flags_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_flags_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_update_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_update_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_update_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/semantics_update_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('spell_out_string_attribute_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/spell_out_string_attribute_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('string_attribute_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/string_attribute_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_color_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/system_color_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('target_image_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/target_image_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_constraints_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/view_constraints_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_focus_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/view_focus_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // --- FOUNDATION INDIVIDUAL SCRIPTS (13 files) ---
  group('foundation/ individual', () {
    test('aggregated_timed_block_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/aggregated_timed_block_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('aggregated_timings_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/aggregated_timings_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('bit_field_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/bit_field_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_timeline_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/flutter_timeline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('partial_stack_frame_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/partial_stack_frame_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('persistent_hash_map_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/persistent_hash_map_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('read_buffer_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/read_buffer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('repetitive_stack_frame_filter_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/repetitive_stack_frame_filter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stack_filter_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/stack_filter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stack_frame_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/stack_frame_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('timed_block_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/timed_block_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('unicode_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/unicode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('write_buffer_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/write_buffer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // --- GESTURES INDIVIDUAL SCRIPTS (25 files) ---
  group('gestures/ individual', () {
    test('base_tap_and_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/base_tap_and_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delayed_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/delayed_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('device_gesture_settings_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/device_gesture_settings_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('drag_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/drag_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('eager_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/eager_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('horizontal_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/horizontal_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('immediate_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/immediate_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('long_press_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/long_press_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_drag_pointer_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multi_drag_pointer_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/multi_tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('positioned_gesture_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/positioned_gesture_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_cancel_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_cancel_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('serial_tap_up_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/serial_tap_up_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_and_horizontal_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_and_horizontal_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_and_pan_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_and_pan_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_down_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_down_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_end_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_end_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_start_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_start_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_up_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_up_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_drag_update_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/tap_drag_update_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('vertical_multi_drag_gesture_recognizer_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/vertical_multi_drag_gesture_recognizer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // --- MATERIAL INDIVIDUAL SCRIPTS (74 files) ---
  group('material/ individual', () {
    test('adaptive_text_selection_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/adaptive_text_selection_toolbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_bar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/app_bar_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('base_range_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/base_range_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('base_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/base_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('bottom_app_bar_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottom_app_bar_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('button_style_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/button_style_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('calendar_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/calendar_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('card_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/card_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('checkbox_list_tile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/checkbox_list_tile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('checkmarkable_chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/checkmarkable_chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('chip_animation_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/chip_animation_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('colors_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/colors_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('controls_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/controls_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('data_table_source_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/data_table_source_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('data_table_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/data_table_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('data_table_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/data_table_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('date_range_picker_dialog_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/date_range_picker_dialog_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('date_time_range_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/date_time_range_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('date_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/date_utils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_material_localizations_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/default_material_localizations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('deletable_chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/deletable_chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('desktop_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/desktop_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('desktop_text_selection_toolbar_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/desktop_text_selection_toolbar_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('desktop_text_selection_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/desktop_text_selection_toolbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('disabled_chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/disabled_chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('filled_button_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/filled_button_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_action_button_animator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/floating_action_button_animator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_action_button_location_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/floating_action_button_location_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_button_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/icon_button_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('input_decoration_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_decoration_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_localizations_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_localizations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_drawer_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_drawer_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('outlined_button_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/outlined_button_theme_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('radio_list_tile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/radio_list_tile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_labels_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_labels_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_slider_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_slider_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_slider_thumb_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_slider_thumb_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_slider_tick_mark_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_slider_tick_mark_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_slider_value_indicator_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_slider_value_indicator_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_values_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/range_values_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_material_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/raw_material_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rectangular_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rectangular_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('round_slider_overlay_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/round_slider_overlay_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('round_slider_thumb_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/round_slider_thumb_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('round_slider_tick_mark_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/round_slider_tick_mark_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rounded_rect_slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rounded_rect_slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_feature_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_feature_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_messenger_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_messenger_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_chip_attributes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/selectable_chip_attributes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slider_component_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/slider_component_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slider_tick_mark_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/slider_tick_mark_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slider_track_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/slider_track_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

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
      final result = await SendTestRunner.send(
        'material/typography_test.dart',
      );
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
      final result = await SendTestRunner.send(
        'painting/box_border_test.dart',
      );
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

    test('decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/decoration_test.dart',
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
      final result = await SendTestRunner.send(
        'painting/gradient_test.dart',
      );
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
      final result = await SendTestRunner.send(
        'painting/image_info_test.dart',
      );
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

  // --- RENDERING INDIVIDUAL SCRIPTS (107 files) ---
  group('rendering/ individual', () {
    test('box_hit_test_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/box_hit_test_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_hit_test_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/box_hit_test_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_path_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/clip_path_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clip_r_superellipse_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/clip_r_superellipse_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_filter_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/color_filter_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('constraints_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/constraints_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('container_box_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/container_box_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('container_render_object_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/container_render_object_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('custom_painter_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/custom_painter_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('debug_overflow_indicator_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/debug_overflow_indicator_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('follower_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/follower_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keep_alive_parent_data_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/keep_alive_parent_data_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('layer_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/layer_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('layer_link_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/layer_link_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('leader_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/leader_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_body_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/list_body_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/list_wheel_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mouse_tracker_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/mouse_tracker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('performance_overlay_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/performance_overlay_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('picture_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/picture_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/platform_view_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('relayout_when_system_fonts_change_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/relayout_when_system_fonts_change_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_absorb_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_absorb_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_aligning_shifted_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_aligning_shifted_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_animated_opacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_opacity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_animated_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_annotated_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_annotated_region_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_backdrop_filter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_backdrop_filter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_baseline_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_baseline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_block_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_block_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_box_container_defaults_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_box_container_defaults_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_constrained_overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_constrained_overflow_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_constraints_transform_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_constraints_transform_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_custom_multi_child_layout_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_multi_child_layout_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_custom_paint_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_paint_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_custom_single_child_layout_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_single_child_layout_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_editable_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_editable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_error_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_error_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_exclude_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_exclude_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_follower_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_follower_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_fractional_translation_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_fractional_translation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_fractionally_sized_overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_fractionally_sized_overflow_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_ignore_baseline_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_ignore_baseline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_ignore_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_ignore_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_indexed_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_indexed_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_indexed_stack_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_indexed_stack_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_leader_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_leader_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_list_wheel_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_list_wheel_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_merge_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_merge_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_meta_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_meta_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_mouse_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_mouse_region_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_with_child_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_object_with_child_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_offstage_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_offstage_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_physical_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_physical_model_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_physical_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_physical_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_pointer_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_pointer_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_proxy_box_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_proxy_box_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_proxy_box_with_hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_proxy_box_with_hit_test_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_repaint_boundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_repaint_boundary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_rotated_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_rotated_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_semantics_annotations_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_semantics_annotations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_semantics_gesture_handler_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_semantics_gesture_handler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_shader_mask_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_shader_mask_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_shrink_wrapping_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_shrink_wrapping_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sized_overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sized_overflow_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_animated_opacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_animated_opacity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fill_remaining_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fill_remaining_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fill_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fill_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fixed_extent_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fixed_extent_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_floating_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_floating_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_helpers_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_helpers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_ignore_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_ignore_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_multi_box_adaptor_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_multi_box_adaptor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_offstage_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_offstage_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_pinned_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_pinned_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_scrolling_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_scrolling_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_to_box_adapter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_to_box_adapter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_varied_extent_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_varied_extent_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_with_keep_alive_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_with_keep_alive_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_tree_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_tree_sliver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_viewport_base_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_viewport_base_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('renderer_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderer_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering_flutter_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/rendering_flutter_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selectable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selected_content_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selected_content_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_geometry_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_geometry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_point_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_point_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_registrar_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_registrar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_annotations_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/semantics_annotations_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shader_mask_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/shader_mask_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shape_border_clipper_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/shape_border_clipper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_grid_geometry_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_grid_geometry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_grid_layout_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_grid_layout_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_grid_regular_tile_layout_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_grid_regular_tile_layout_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_hit_test_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_hit_test_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_hit_test_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_hit_test_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_layout_dimensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_layout_dimensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_logical_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_logical_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_multi_box_adaptor_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_multi_box_adaptor_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_physical_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_physical_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_cell_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/table_cell_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/text_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_point_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/text_selection_point_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('texture_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/texture_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('wrap_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/wrap_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // --- SCHEDULER INDIVIDUAL SCRIPTS (1 files) ---
  group('scheduler/ individual', () {
    test('performance_mode_request_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/performance_mode_request_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // --- SEMANTICS INDIVIDUAL SCRIPTS (6 files) ---
  group('semantics/ individual', () {
    test('child_semantics_configurations_result_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/child_semantics_configurations_result_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('child_semantics_configurations_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/child_semantics_configurations_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_label_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_label_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // --- SERVICES INDIVIDUAL SCRIPTS (35 files) ---
  group('services/ individual', () {
    test('android_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_kit_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/app_kit_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('asset_manifest_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/asset_manifest_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('asset_metadata_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/asset_metadata_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('browser_context_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/browser_context_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('caching_asset_bundle_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/caching_asset_bundle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('darwin_platform_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/darwin_platform_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_process_text_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/default_process_text_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_spell_check_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/default_spell_check_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expensive_android_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/expensive_android_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_version_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/flutter_version_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('font_loader_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/font_loader_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hybrid_android_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/hybrid_android_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('live_text_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/live_text_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('network_asset_bundle_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/network_asset_bundle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_asset_bundle_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_asset_bundle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_views_registry_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_views_registry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_views_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_views_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('predictive_back_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/predictive_back_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('process_text_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/process_text_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('process_text_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/process_text_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restoration_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/restoration_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scribe_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/scribe_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('spell_check_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/spell_check_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('suggestion_span_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/suggestion_span_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('surface_android_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/surface_android_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_channels_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_channels_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_layout_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_layout_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('texture_android_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/texture_android_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ui_kit_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/ui_kit_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_manager_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/undo_manager_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/undo_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

  // --- WIDGETS INDIVIDUAL SCRIPTS (172 files) ---
  group('widgets/ individual', () {
    test('always_scrollable_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/always_scrollable_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('android_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/android_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_align_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_align_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_cross_fade_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_cross_fade_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_fractionally_sized_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_fractionally_sized_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_modal_barrier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_modal_barrier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_physical_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_physical_model_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_rotation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_rotation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_scale_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_scale_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_slide_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_slide_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animated_switcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_switcher_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('backdrop_filter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/backdrop_filter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('bouncing_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/bouncing_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('build_owner_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/build_owner_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('build_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/build_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('checked_mode_banner_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/checked_mode_banner_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('clamping_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/clamping_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('color_filtered_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/color_filtered_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('component_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/component_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('composited_transform_follower_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/composited_transform_follower_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('composited_transform_target_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/composited_transform_target_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('content_insertion_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/content_insertion_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('context_menu_button_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_menu_button_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('context_menu_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_menu_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_asset_bundle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_asset_bundle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_text_height_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/default_text_height_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directionality_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/directionality_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('display_feature_sub_screen_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/display_feature_sub_screen_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dual_transition_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/dual_transition_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('editable_text_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fade_in_image_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fade_in_image_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fixed_extent_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_extent_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fixed_extent_scroll_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_extent_scroll_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fixed_extent_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_extent_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('glowing_overscroll_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/glowing_overscroll_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('html_element_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/html_element_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_filtered_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/image_filtered_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('implicitly_animated_widget_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/implicitly_animated_widget_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('implicitly_animated_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/implicitly_animated_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('indexed_stack_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/indexed_stack_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_theme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('inherited_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('leaf_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/leaf_render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('leaf_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/leaf_render_object_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_child_builder_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_builder_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_child_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_child_list_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_list_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_child_looping_list_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_child_looping_list_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_scroll_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('magnifier_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/magnifier_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('magnifier_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/magnifier_decoration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('magnifier_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/magnifier_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_child_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/multi_child_render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_child_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/multi_child_render_object_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigation_toolbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('never_scrollable_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/never_scrollable_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overflow_bar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overflow_bar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overflow_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_storage_bucket_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_storage_bucket_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_storage_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_storage_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_storage_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_storage_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('parent_data_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/parent_data_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('parent_data_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/parent_data_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('performance_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/performance_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('physical_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/physical_model_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('physical_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/physical_shape_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pinned_header_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/pinned_header_sliver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_bar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_bar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_item_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_item_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_provided_menu_item_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_provided_menu_item_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_link_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_view_link_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_view_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pop_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/pop_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('positioned_directional_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/positioned_directional_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('primary_scroll_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/primary_scroll_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('proxy_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/proxy_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('proxy_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/proxy_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('radio_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/radio_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('range_maintaining_scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/range_maintaining_scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_magnifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_magnifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_bool_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_bool_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_date_time_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_date_time_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_double_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_double_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_enum_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_enum_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_int_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_int_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_string_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_string_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_text_editing_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_text_editing_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_value_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_value_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restoration_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restoration_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_restoration_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_restoration_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_physics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_physics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_position_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_position_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollable_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollable_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollable_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selectable_region_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_container_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_container_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shader_mask_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shader_mask_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shared_app_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shared_app_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shrink_wrapping_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shrink_wrapping_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('single_child_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_child_render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('single_child_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_child_render_object_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('single_ticker_provider_state_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_ticker_provider_state_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_grid_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_grid_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_opacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_opacity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_constrained_cross_axis_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_constrained_cross_axis_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_cross_axis_expanded_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_cross_axis_expanded_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_cross_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_cross_axis_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_floating_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_floating_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_ignore_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_ignore_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_layout_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_layout_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_main_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_main_axis_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_offstage_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_offstage_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_prototype_extent_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_prototype_extent_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_reorderable_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_reorderable_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_resizing_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_resizing_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_safe_area_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_safe_area_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_visibility_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_visibility_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('spacer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/spacer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('spell_check_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/spell_check_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stateful_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stateful_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stateless_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stateless_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stretching_overscroll_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stretching_overscroll_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_cell_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/table_cell_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_row_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/table_row_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_region_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tap_region_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tap_region_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_field_tap_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_field_tap_region_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_magnifier_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_magnifier_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_gesture_detector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_gesture_detector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_toolbar_anchors_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_toolbar_anchors_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ticker_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ticker_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ticker_provider_state_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ticker_provider_state_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('title_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/title_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_trigger_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_trigger_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tween_animation_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tween_animation_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ui_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ui_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_history_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/undo_history_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_anchor_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/view_anchor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_collection_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/view_collection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_inspector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_inspector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_app_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_app_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_binding_observer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_binding_observer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_flutter_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_flutter_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('will_pop_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/will_pop_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

  });

}
