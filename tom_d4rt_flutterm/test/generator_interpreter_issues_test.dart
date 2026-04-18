/// Generator/Interpreter Issues — Section 2 tests NOT modified.
///
/// This test file runs the EXISTING tests that require generator or
/// interpreter fixes before they can pass. These tests are expected to FAIL
/// until the underlying generator/interpreter issues are fixed.
///
/// These tests are not modified — they run from their original location.
///
/// Total: 83 tests (80 bridge generator + 3 interpreter)
@TestOn('vm')
library;

import 'dart:io' show Platform;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

/// Helper to check that a test truly passes (success AND no framework errors).
void expectSuccess(SendResult result) {
  final errors = result.frameworkErrors.isNotEmpty
      ? result.frameworkErrors.join('; ')
      : null;
  final reason = result.error ?? errors;
  expect(result.success && !result.hasFrameworkErrors, isTrue, reason: reason);
}

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp();
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Section 2 - Bridge Generator Issues (80)', () {
    // 1. widgets/render_object_to_widget_adapter_test.dart (idx 139)
    test('widgets/render_object_to_widget_adapter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_to_widget_adapter_test.dart',
      );
      expectSuccess(result);
    });

    // 2. widgets/render_tree_root_element_test.dart (idx 142)
    test('widgets/render_tree_root_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_tree_root_element_test.dart',
      );
      expectSuccess(result);
    });

    // 3. widgets/restorable_enum_n_test.dart (idx 152)
    test('widgets/restorable_enum_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_enum_n_test.dart',
      );
      expectSuccess(result);
    });

    // 4. widgets/route_information_test.dart (idx 162)
    test('widgets/route_information_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_information_test.dart',
      );
      expectSuccess(result);
    });

    // 5. widgets/route_pop_disposition_test.dart (idx 163)
    test('widgets/route_pop_disposition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_pop_disposition_test.dart',
      );
      expectSuccess(result);
    });

    // 6. widgets/router_config_test.dart (idx 165)
    test('widgets/router_config_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/router_config_test.dart',
      );
      expectSuccess(result);
    });

    // 7. widgets/scroll_activity_test.dart (idx 167)
    test('widgets/scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_activity_test.dart',
      );
      expectSuccess(result);
    });

    // 8. widgets/scroll_position_alignment_policy_test.dart (idx 178)
    test('widgets/scroll_position_alignment_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_position_alignment_policy_test.dart',
      );
      expectSuccess(result);
    });

    // 9. widgets/scroll_view_keyboard_dismiss_behavior_test.dart (idx 183)
    test('widgets/scroll_view_keyboard_dismiss_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_view_keyboard_dismiss_behavior_test.dart',
      );
      expectSuccess(result);
    });

    // 10. widgets/select_action_test.dart (idx 188)
    test('widgets/select_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/select_action_test.dart',
      );
      expectSuccess(result);
    });

    // 11. widgets/shortcut_registry_entry_test.dart (idx 198)
    test('widgets/shortcut_registry_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_registry_entry_test.dart',
      );
      expectSuccess(result);
    });

    // 12. widgets/shortcut_serialization_test.dart (idx 199)
    test('widgets/shortcut_serialization_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_serialization_test.dart',
      );
      expectSuccess(result);
    });

    // 13. widgets/single_activator_test.dart (idx 200)
    test('widgets/single_activator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_activator_test.dart',
      );
      expectSuccess(result);
    });

    // 14. widgets/toolbar_items_parent_data_test.dart (idx 217)
    test('widgets/toolbar_items_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toolbar_items_parent_data_test.dart',
      );
      expectSuccess(result);
    });

    // 15. widgets/toolbar_options_test.dart (idx 218)
    test('widgets/toolbar_options_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toolbar_options_test.dart',
      );
      expectSuccess(result);
    });

    // 16. widgets/tooltip_position_context_test.dart (idx 219)
    test('widgets/tooltip_position_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_position_context_test.dart',
      );
      expectSuccess(result);
    });

    // 17. widgets/tooltip_window_controller_delegate_test.dart (idx 220)
    test('widgets/tooltip_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_controller_delegate_test.dart',
      );
      expectSuccess(result);
    });

    // 18. widgets/tooltip_window_controller_test.dart (idx 221)
    test('widgets/tooltip_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_controller_test.dart',
      );
      expectSuccess(result);
    });

    // 19. widgets/transition_delegate_test.dart (idx 223)
    test('widgets/transition_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transition_delegate_test.dart',
      );
      expectSuccess(result);
    });

    // 20. widgets/traversal_direction_test.dart (idx 225)
    test('widgets/traversal_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/traversal_direction_test.dart',
      );
      expectSuccess(result);
    });

    // 21. widgets/traversal_edge_behavior_test.dart (idx 226)
    test('widgets/traversal_edge_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/traversal_edge_behavior_test.dart',
      );
      expectSuccess(result);
    });

    // 22. widgets/window_positioner_anchor_test.dart (idx 258)
    test('widgets/window_positioner_anchor_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_positioner_anchor_test.dart',
      );
      expectSuccess(result);
    });

    // 23. widgets/window_positioner_constraint_adjustment_test.dart (idx 259)
    test('widgets/window_positioner_constraint_adjustment_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_positioner_constraint_adjustment_test.dart',
      );
      expectSuccess(result);
    });

    // 24. widgets/window_positioner_test.dart (idx 260)
    test('widgets/window_positioner_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_positioner_test.dart',
      );
      expectSuccess(result);
    });

    // 25. widgets/window_scope_test.dart (idx 261)
    test('widgets/window_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_scope_test.dart',
      );
      expectSuccess(result);
    });

    // 26. widgets/windowing_owner_linux_test.dart (idx 262)
    test('widgets/windowing_owner_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_linux_test.dart',
      );
      expectSuccess(result);
    });

    // 27. widgets/windowing_owner_mac_o_s_test.dart (idx 263)
    test('widgets/windowing_owner_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_mac_o_s_test.dart',
      );
      expectSuccess(result);
    });

    // 28. widgets/windowing_owner_test.dart (idx 264)
    test('widgets/windowing_owner_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_test.dart',
      );
      expectSuccess(result);
    });

    // 29. widgets/slidetransition_test.dart (idx 267)
    test('widgets/slidetransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slidetransition_test.dart',
      );
      expectSuccess(result);
    });

    // 30. widgets/nestedscrollview_test.dart (idx 269)
    test('widgets/nestedscrollview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/nestedscrollview_test.dart',
      );
      expectSuccess(result);
    });

    // 31. animation/tweensequence_test.dart (idx 278)
    test('animation/tweensequence_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/tweensequence_test.dart',
      );
      expectSuccess(result);
    });

    // 32. services/codecs_test.dart (idx 279)
    test('services/codecs_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/codecs_test.dart',
      );
      expectSuccess(result);
    });

    // 33. services/channels_test.dart (idx 280)
    test('services/channels_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/channels_test.dart',
      );
      expectSuccess(result);
    });

    // 34. semantics/semantics_config_test.dart (idx 290)
    test('semantics/semantics_config_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_config_test.dart',
      );
      expectSuccess(result);
    });

    // 35. widgets/layout_builder_adv_test.dart (idx 292)
    test('widgets/layout_builder_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/layout_builder_adv_test.dart',
      );
      expectSuccess(result);
    });

    // 36. material/scaffold_messenger_test.dart (idx 303)
    test('material/scaffold_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_messenger_test.dart',
      );
      expectSuccess(result);
    });

    // 37. rendering/box_hit_test_result_test.dart (idx 309)
    test('rendering/box_hit_test_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/box_hit_test_result_test.dart',
      );
      expectSuccess(result);
    });

    // 38. rendering/custom_painter_semantics_test.dart (idx 310)
    test('rendering/custom_painter_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/custom_painter_semantics_test.dart',
      );
      expectSuccess(result);
    });

    // 39. rendering/relayout_when_system_fonts_change_mixin_test.dart (idx 312)
    test('rendering/relayout_when_system_fonts_change_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/relayout_when_system_fonts_change_mixin_test.dart',
      );
      expectSuccess(result);
    });

    // 40. rendering/render_absorb_pointer_test.dart (idx 313)
    test('rendering/render_absorb_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_absorb_pointer_test.dart',
      );
      expectSuccess(result);
    });

    // 41. rendering/render_aligning_shifted_box_test.dart (idx 314)
    test('rendering/render_aligning_shifted_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_aligning_shifted_box_test.dart',
      );
      expectSuccess(result);
    });

    // 42. rendering/render_box_container_defaults_mixin_test.dart (idx 317)
    test('rendering/render_box_container_defaults_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_box_container_defaults_mixin_test.dart',
      );
      expectSuccess(result);
    }, skip: 'moved to timeout_tests_test.dart');

    // 43. rendering/render_custom_multi_child_layout_box_test.dart (idx 318)
    test('rendering/render_custom_multi_child_layout_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_multi_child_layout_box_test.dart',
      );
      expectSuccess(result);
    }, skip: 'moved to timeout_tests_test.dart');

    // 44. rendering/render_custom_paint_test.dart (idx 319)
    test('rendering/render_custom_paint_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_paint_test.dart',
      );
      expectSuccess(result);
    }, skip: 'moved to timeout_tests_test.dart');

    // 45. rendering/render_custom_single_child_layout_box_test.dart (idx 320)
    test('rendering/render_custom_single_child_layout_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_custom_single_child_layout_box_test.dart',
      );
      expectSuccess(result);
    }, skip: 'moved to timeout_tests_test.dart');

    // 46. rendering/render_physical_shape_test.dart (idx 323)
    test('rendering/render_physical_shape_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_physical_shape_test.dart',
      );
      expectSuccess(result);
    }, skip: 'moved to timeout_tests_test.dart');

    // 47. rendering/render_shrink_wrapping_viewport_test.dart (idx 325)
    test('rendering/render_shrink_wrapping_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_shrink_wrapping_viewport_test.dart',
      );
      expectSuccess(result);
    });

    // 48. widgets/android_view_test.dart (idx 329)
    test('widgets/android_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/android_view_test.dart',
      );
      expectSuccess(result);
    }, skip: !Platform.isAndroid
        ? 'AndroidView only renders on Android'
        : null);

    // 49. widgets/animated_cross_fade_test.dart (idx 330)
    test('widgets/animated_cross_fade_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_cross_fade_test.dart',
      );
      expectSuccess(result);
    });

    // 50. widgets/animated_switcher_test.dart (idx 332)
    test('widgets/animated_switcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_switcher_test.dart',
      );
      expectSuccess(result);
    });

    // 51. widgets/autofill_group_test.dart (idx 333)
    test('widgets/autofill_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_group_test.dart',
      );
      expectSuccess(result);
    });

    // 52. widgets/backdrop_filter_test.dart (idx 334)
    test('widgets/backdrop_filter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/backdrop_filter_test.dart',
      );
      expectSuccess(result);
    });

    // 53. widgets/composited_transform_follower_test.dart (idx 336)
    test('widgets/composited_transform_follower_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/composited_transform_follower_test.dart',
      );
      expectSuccess(result);
    });

    // 54. widgets/fixed_extent_metrics_test.dart (idx 340)
    test('widgets/fixed_extent_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_extent_metrics_test.dart',
      );
      expectSuccess(result);
    });

    // 55. widgets/glowing_overscroll_indicator_test.dart (idx 341)
    test('widgets/glowing_overscroll_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/glowing_overscroll_indicator_test.dart',
      );
      expectSuccess(result);
    });

    // 56. widgets/html_element_view_test.dart (idx 342)
    test('widgets/html_element_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/html_element_view_test.dart',
      );
      expectSuccess(result);
    });

    // 57. widgets/image_filtered_test.dart (idx 343)
    test('widgets/image_filtered_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/image_filtered_test.dart',
      );
      expectSuccess(result);
    });

    // 58. widgets/indexed_stack_test.dart (idx 344)
    test('widgets/indexed_stack_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/indexed_stack_test.dart',
      );
      expectSuccess(result);
    });

    // 59. widgets/inherited_theme_test.dart (idx 346)
    test('widgets/inherited_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_theme_test.dart',
      );
      expectSuccess(result);
    });

    // 60. widgets/inherited_widget_test.dart (idx 347)
    test('widgets/inherited_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_widget_test.dart',
      );
      expectSuccess(result);
    });

    // 61. widgets/list_wheel_scroll_view_test.dart (idx 348)
    test('widgets/list_wheel_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_scroll_view_test.dart',
      );
      expectSuccess(result);
    });

    // 62. widgets/list_wheel_viewport_test.dart (idx 349)
    test('widgets/list_wheel_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_viewport_test.dart',
      );
      expectSuccess(result);
    });

    // 63. widgets/magnifier_decoration_test.dart (idx 350)
    test('widgets/magnifier_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/magnifier_decoration_test.dart',
      );
      expectSuccess(result);
    });

    // 64. widgets/navigation_toolbar_test.dart (idx 351)
    test('widgets/navigation_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigation_toolbar_test.dart',
      );
      expectSuccess(result);
    });

    // 65. widgets/overflow_bar_test.dart (idx 352)
    test('widgets/overflow_bar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overflow_bar_test.dart',
      );
      expectSuccess(result);
    });

    // 66. widgets/overflow_box_test.dart (idx 353)
    test('widgets/overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overflow_box_test.dart',
      );
      expectSuccess(result);
    });

    // 67. widgets/page_storage_bucket_test.dart (idx 354)
    test('widgets/page_storage_bucket_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_storage_bucket_test.dart',
      );
      expectSuccess(result);
    });

    // 68. widgets/page_storage_test.dart (idx 355)
    test('widgets/page_storage_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_storage_test.dart',
      );
      expectSuccess(result);
    });

    // 69. widgets/parent_data_widget_test.dart (idx 356)
    test('widgets/parent_data_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/parent_data_widget_test.dart',
      );
      expectSuccess(result);
    });

    // 70. widgets/physical_model_test.dart (idx 358)
    test('widgets/physical_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/physical_model_test.dart',
      );
      expectSuccess(result);
    });

    // 71. widgets/render_object_element_test.dart (idx 359)
    test('widgets/render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_element_test.dart',
      );
      expectSuccess(result);
    });

    // 72. widgets/render_object_widget_test.dart (idx 360)
    test('widgets/render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_widget_test.dart',
      );
      expectSuccess(result);
    });

    // 73. widgets/restorable_enum_test.dart (idx 364)
    test('widgets/restorable_enum_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_enum_test.dart',
      );
      expectSuccess(result);
    });

    // 74. widgets/restorable_text_editing_controller_test.dart (idx 368)
    test('widgets/restorable_text_editing_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_text_editing_controller_test.dart',
      );
      expectSuccess(result);
    });

    // 75. widgets/root_widget_test.dart (idx 372)
    test('widgets/root_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_widget_test.dart',
      );
      expectSuccess(result);
    });

    // 76. widgets/shader_mask_test.dart (idx 375)
    test('widgets/shader_mask_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shader_mask_test.dart',
      );
      expectSuccess(result);
    });

    // 77. widgets/single_child_render_object_element_test.dart (idx 376)
    test('widgets/single_child_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_child_render_object_element_test.dart',
      );
      expectSuccess(result);
    });

    // 78. widgets/single_child_render_object_widget_test.dart (idx 377)
    test('widgets/single_child_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_child_render_object_widget_test.dart',
      );
      expectSuccess(result);
    });

    // 79. widgets/stateful_element_test.dart (idx 380)
    test('widgets/stateful_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stateful_element_test.dart',
      );
      expectSuccess(result);
    });

    // 80. widgets/stateless_element_test.dart (idx 381)
    test('widgets/stateless_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stateless_element_test.dart',
      );
      expectSuccess(result);
    }, skip: 'moved to timeout_tests_test.dart');
  });

  group('Section 2 - Interpreter Issues (3)', () {
    // 1. widgets/scrollbar_orientation_test.dart (idx 186)
    test('widgets/scrollbar_orientation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollbar_orientation_test.dart',
      );
      expectSuccess(result);
    }, skip: 'moved to timeout_tests_test.dart');

    // 2. widgets/sliver_animated_list_state_test.dart (idx 203)
    test('widgets/sliver_animated_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_list_state_test.dart',
      );
      expectSuccess(result);
    }, skip: 'moved to timeout_tests_test.dart');

    // 3. widgets/sliver_child_builder_delegate_test.dart (idx 204)
    test('widgets/sliver_child_builder_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_child_builder_delegate_test.dart',
      );
      expectSuccess(result);
    }, skip: 'moved to timeout_tests_test.dart');
  });
}
