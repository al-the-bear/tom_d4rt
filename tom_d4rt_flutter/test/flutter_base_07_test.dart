/// Auto-split base bridge tests (file 07).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_07_test.dart';

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
  // WIDGETS PACKAGE TESTS (41 files)
  // ============================================================
  group('widgets/', () {
    // --- Batch 1 ---
    test('defaulttextstyle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/defaulttextstyle_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('focus_properties_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_properties_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('keyedsubtree_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keyedsubtree_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('physicalmodel_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/physicalmodel_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('placeholder_test.dart', () async {
      final result = await SendTestRunner.send('widgets/placeholder_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('preferredsize_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/preferredsize_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('restorable_values_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_values_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scrollbar_layout_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollbar_layout_misc_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scrollphysics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollphysics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('shaderfilter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shaderfilter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('shortcuts_actions_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcuts_actions_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_delegates_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_delegates_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('textspan_test.dart', () async {
      final result = await SendTestRunner.send('widgets/textspan_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 2 ---
    test('scroll_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scroll_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_metrics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('display_feature_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/display_feature_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('restoration_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restoration_scope_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('undo_history_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/undo_history_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('actions_intents_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/actions_intents_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_selection_widgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_widgets_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autofill_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_context_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('context_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_menu_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_magnifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_magnifier_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('notification_locale_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notification_locale_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('focus_traversal_advanced_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_traversal_advanced_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('raw_widgets_test.dart', () async {
      final result = await SendTestRunner.send('widgets/raw_widgets_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('editable_text_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/editable_text_misc_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 4 ---
    test('scroll_notifications_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_notifications_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('inherited_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_model_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('table_wrap_flow_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/table_wrap_flow_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('overlay_portal_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_portal_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gesture_detector_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesture_detector_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('media_query_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/media_query_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('route_observer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_observer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('interactive_viewer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/interactive_viewer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 5 ---
    test('animated_widgets_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_widgets_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('form_field_test.dart', () async {
      final result = await SendTestRunner.send('widgets/form_field_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('layout_builder_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/layout_builder_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('page_view_tabview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_view_tabview_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('draggable_sheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggable_sheet_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 6-9 ---
    test('element_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/element_types_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_object_widgets_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_widgets_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('platform_menu_widgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_widgets_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scroll_position_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_position_types_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scroll_controllers_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_controllers_types_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selection_types_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_types_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_editing_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_editing_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('restoration_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restoration_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('shortcuts_actions_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcuts_actions_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('autofill_context_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_context_adv_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // SECONDARY CLASSES - INDIVIDUAL SCRIPTS (509 files)
  // ============================================================

  // --- ANIMATION INDIVIDUAL SCRIPTS (4 files) ---
  group('animation/ individual', () {
    test('animation_mean_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_mean_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animation_min_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_min_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animation_with_parent_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_with_parent_mixin_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // --- CUPERTINO INDIVIDUAL SCRIPTS (9 files) ---
  group('cupertino/ individual', () {
    test('cupertino_page_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_page_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_picker_default_selection_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_picker_default_selection_overlay_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_scroll_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_scroll_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_sheet_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_sheet_route_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_sheet_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_sheet_transition_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_text_selection_controls_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('obstructing_preferred_size_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/obstructing_preferred_size_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
