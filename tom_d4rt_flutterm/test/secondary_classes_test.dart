/// Tests for secondary Flutter bridge classes (batches 1-3).
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
/// Total: 121 test scripts (~757 classes)
///   Batch 1: 38 scripts (~186 classes)
///   Batch 2: 29 scripts (~148 classes) — widgets + material
///   Batch 3: 22 scripts (~178 classes) — cupertino, rendering, gestures,
///            services, dart:ui, semantics, painting, material
///   Batch 4: 16 scripts (~120 classes) — widgets, material, cupertino, rendering
///   Batch 5: 16 scripts (~125 classes) — widgets, material, cupertino, rendering,
///            services, dart:ui
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
      final result = await SendTestRunner.send(
        'material/data_table_test.dart',
      );
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
      final result = await SendTestRunner.send(
        'services/key_events_test.dart',
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
      final result = await SendTestRunner.send(
        'widgets/form_field_test.dart',
      );
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
  });
}
