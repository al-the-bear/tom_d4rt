# Tom D4rt Flutterm — Test Failures

Generated: 2026-04-04

## Log Files

- **Full JSON log**: `doc/test_results_json.log` (5062 lines)
- **Categorized results**: `doc/test_results_categorized.txt` (1421 lines)

## Summary

| Category | Count | Description |
|----------|-------|-------------|
| Passed | 1626 | — |
| Skipped | 9 | — |
| RUNTIME_ERROR | 123 | Mixins, undefined vars — needs per-test analysis |
| ASSERTION_FAIL | 194 | Runtime errors in test scripts |
| SOCKET_EXCEPTION | 62 | Cascade from HTTP server crash (transient) |
| PARSE_ERROR | 5 | _SUnknownNode cast errors |
| IMPORT_ERROR | 4 | Unresolved imports |
| OTHER | 1 | HTTP connection closed |
| **Total failures** | **389** | |

## RUNTIME_ERROR (123 failures)

| File | Failure Type | Fixed |
|------|-------------|-------|
| dart_ui/clip_rect_engine_layer_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/image_filter_engine_layer_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/image_sampler_slot_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/individual_image_descriptor_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/individual_immutable_buffer_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/individual_key_data_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/individual_locale_string_attribute_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/individual_path_metric_iterator_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/individual_path_metrics_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/individual_platform_dispatcher_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/isolate_name_server_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/key_event_device_type_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/key_event_type_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/picture_rasterization_exception_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/plugin_utilities_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| dart_ui/singleton_flutter_window_test.dart | undefined var: window | yes |
| foundation/diagnosticable_tree_mixin_test.dart | mixin: DiagnosticableTreeMixin | yes |
| foundation/factory_test.dart | Bridged class 'Factory' has no instance method named 'constructor'. Error during | yes |
| material/button_bar_test.dart | undefined var: ButtonBar | yes |
| material/button_bar_theme_data_test.dart | undefined var: ButtonBarThemeData | yes |
| material/button_bar_theme_test.dart | undefined var: ButtonBarThemeData | yes |
| material/individual_scaffold_messenger_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| material/no_splash_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| material/popup_menu_entry_test.dart | undefined var: build | yes |
| material/popup_menu_item_test.dart | undefined var: build | yes |
| material/predictive_back_fullscreen_page_transitions_builder_test.dart | undefined var: build | yes |
| material/scrollbar_theme_data_test.dart | undefined var: build | yes |
| material/search_controller_test.dart | undefined var: build | yes |
| material/search_delegate_test.dart | undefined var: build | yes |
| rendering/individual_container_render_object_mixin_test.dart | mixin: ContainerRenderObjectMixin | yes |
| rendering/over_scroll_header_stretch_configuration_test.dart | undefined var: build | yes |
| rendering/render_sliver_box_child_manager_test.dart | mixin: AutomaticKeepAliveClientMixin | yes |
| services/codecs_test.dart | undefined var: Uint8List | yes |
| services/key_data_transit_mode_test.dart | undefined var: KeyDataTransitMode | yes |
| services/key_helper_test.dart | undefined var: KeyHelper | yes |
| services/key_message_test.dart | undefined var: KeyMessage | yes |
| services/keyboard_side_test.dart | undefined var: KeyboardSide | yes |
| services/modifier_key_test.dart | undefined var: ModifierKey | yes |
| services/raw_key_event_data_android_test.dart | undefined var: RawKeyEventDataAndroid | yes |
| services/raw_key_event_data_fuchsia_test.dart | undefined var: RawKeyEventDataFuchsia | yes |
| services/raw_key_event_data_ios_test.dart | undefined var: RawKeyEventDataIos | yes |
| services/raw_key_event_data_linux_test.dart | undefined var: RawKeyEventDataLinux | yes |
| services/raw_key_event_data_web_test.dart | undefined var: RawKeyEventDataWeb | yes |
| services/raw_key_event_data_windows_test.dart | undefined var: RawKeyEventDataWindows | yes |
| services/raw_keyboard_test.dart | undefined var: RawKeyboard | yes |
| widgets/align_transition_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/back_button_listener_test.dart | mixin: ChangeNotifier | yes |
| widgets/clip_r_superellipse_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/default_text_style_transition_test.dart | mixin: TickerProviderStateMixin | yes |
| widgets/fractional_translation_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/icon_theme_data_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/individual_animated_modal_barrier_test.dart | mixin: TickerProviderStateMixin | yes |
| widgets/individual_color_filtered_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/individual_dual_transition_builder_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/individual_image_filtered_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/individual_performance_overlay_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/individual_render_object_element_test.dart | undefined var: build | yes |
| widgets/individual_render_object_widget_test.dart | undefined var: build | yes |
| widgets/individual_restorable_bool_test.dart | undefined var: build | yes |
| widgets/individual_scroll_physics_test.dart | undefined var: build | yes |
| widgets/individual_scroll_position_test.dart | undefined var: build | yes |
| widgets/individual_scrollable_state_test.dart | undefined var: build | yes |
| widgets/individual_shader_mask_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/individual_single_child_render_object_element_test.dart | undefined var: build | yes |
| widgets/individual_single_child_render_object_widget_test.dart | undefined var: build | yes |
| widgets/individual_single_ticker_provider_state_mixin_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/individual_ticker_provider_state_mixin_test.dart | mixin: TickerProviderStateMixin | yes |
| widgets/matrix_transition_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/nested_scroll_view_viewport_test.dart | mixin: SingleTickerProviderStateMixin | yes |
| widgets/regular_window_controller_mac_o_s_test.dart | undefined var: build | yes |
| widgets/regular_window_controller_test.dart | undefined var: build | yes |
| widgets/regular_window_controller_win32_test.dart | undefined var: build | yes |
| widgets/regular_window_test.dart | undefined var: build | yes |
| widgets/relative_rect_tween_test.dart | undefined var: build | yes |
| widgets/render_abstract_layout_builder_mixin_test.dart | undefined var: build | yes |
| widgets/render_object_to_widget_adapter_test.dart | undefined var: build | yes |
| widgets/render_tap_region_surface_test.dart | undefined var: build | yes |
| widgets/render_tap_region_test.dart | undefined var: build | yes |
| widgets/render_two_dimensional_viewport_test.dart | undefined var: build | yes |
| widgets/render_web_image_test.dart | undefined var: build | yes |
| widgets/reorderable_list_state_test.dart | undefined var: build | yes |
| widgets/repeat_mode_test.dart | undefined var: build | yes |
| widgets/replace_text_intent_test.dart | undefined var: build | yes |
| widgets/request_focus_action_test.dart | undefined var: build | yes |
| widgets/request_focus_intent_test.dart | undefined var: build | yes |
| widgets/restorable_bool_n_test.dart | undefined var: build | yes |
| widgets/route_aware_test.dart | mixin: RouteAware | yes |
| widgets/router_config_test.dart | mixin: ChangeNotifier | yes |
| widgets/scroll_notification_observer_state_test.dart | undefined var: build | yes |
| widgets/scroll_position_alignment_policy_test.dart | undefined var: build | yes |
| widgets/scroll_position_with_single_context_test.dart | undefined var: build | yes |
| widgets/scroll_start_notification_test.dart | undefined var: build | yes |
| widgets/scroll_to_document_boundary_intent_test.dart | undefined var: build | yes |
| widgets/scroll_update_notification_test.dart | undefined var: build | yes |
| widgets/scroll_view_keyboard_dismiss_behavior_test.dart | undefined var: build | yes |
| widgets/scrollable_details_test.dart | undefined var: build | yes |
| widgets/scrollbar_orientation_test.dart | undefined var: build | yes |
| widgets/select_action_test.dart | undefined var: build | yes |
| widgets/select_all_text_intent_test.dart | undefined var: build | yes |
| widgets/select_intent_test.dart | undefined var: build | yes |
| widgets/selectable_region_state_test.dart | undefined var: build | yes |
| widgets/selection_container_delegate_test.dart | undefined var: build | yes |
| widgets/selection_details_test.dart | undefined var: build | yes |
| widgets/semantics_gesture_delegate_test.dart | undefined var: build | yes |
| widgets/shortcut_activator_test.dart | undefined var: build | yes |
| widgets/shortcut_manager_test.dart | undefined var: build | yes |
| widgets/shortcut_map_property_test.dart | undefined var: build | yes |
| widgets/shortcut_registry_entry_test.dart | undefined var: build | yes |
| widgets/shortcut_serialization_test.dart | undefined var: build | yes |
| widgets/single_activator_test.dart | undefined var: build | yes |
| widgets/size_changed_layout_notification_test.dart | undefined var: build | yes |
| widgets/sliver_animated_grid_state_test.dart | undefined var: build | yes |
| widgets/sliver_animated_list_state_test.dart | undefined var: build | yes |
| widgets/sliver_child_builder_delegate_test.dart | undefined var: build | yes |
| widgets/sliver_child_delegate_test.dart | undefined var: build | yes |
| widgets/sliver_child_list_delegate_test.dart | undefined var: build | yes |
| widgets/sliver_multi_box_adaptor_element_test.dart | undefined var: build | yes |
| widgets/sliver_multi_box_adaptor_widget_test.dart | undefined var: build | yes |
| widgets/sliver_persistent_header_delegate_test.dart | undefined var: build | yes |
| widgets/sliver_reorderable_list_state_test.dart | undefined var: build | yes |
| widgets/slotted_container_render_object_mixin_test.dart | undefined var: build | yes |
| widgets/slotted_multi_child_render_object_widget_mixin_test.dart | undefined var: build | yes |
| widgets/toolbar_options_test.dart | undefined var: ToolbarOptions | yes |

## ASSERTION_FAIL (194 failures)

| File | Failure Type | Fixed |
|------|-------------|-------|
| animation/catmull_rom_curve_test.dart | assertion failure in constructor | yes |
| animation/catmull_rom_spline_test.dart | assertion failure in constructor | yes |
| animation/curve2_d_sample_test.dart | assertion failure in constructor | yes |
| animation/curve2_d_test.dart | assertion failure in constructor | yes |
| animation/curve_tween_test.dart | Native error during bridged method call 'reduce' on Iterable: type 'NativeFuncti | yes |
| animation/elastic_in_out_curve_test.dart | Native error during bridged method call 'reduce' on Iterable: type 'NativeFuncti | yes |
| animation/elastic_out_curve_test.dart | Native error during bridged method call 'reduce' on Iterable: type 'NativeFuncti | yes |
| animation/flipped_curve_test.dart | Native error during bridged method call 'reduce' on Iterable: type 'NativeFuncti | yes |
| animation/reverse_tween_test.dart | null check failed | yes |
| animation/tweensequence_test.dart | null check failed | yes |
| dart_ui/color_space_test.dart | Unsupported target for indexing: null | yes |
| dart_ui/display_feature_state_test.dart | enum hashCode: DisplayFeatureState | yes |
| dart_ui/display_feature_type_test.dart | enum hashCode: DisplayFeatureType | yes |
| dart_ui/filter_quality_test.dart | enum hashCode: FilterQuality | yes |
| dart_ui/font_style_test.dart | enum hashCode: FontStyle | yes |
| dart_ui/image_byte_format_test.dart | undefined: name on bridged instance of 'Image' | yes |
| dart_ui/individual_ztmp_path_metrics_access_test.dart | Expected: true | yes |
| dart_ui/painting_style_test.dart | undefined: toString on StrokeCap | yes |
| dart_ui/path_fill_type_test.dart | undefined: name on bridged instance of 'Path' | yes |
| dart_ui/path_operation_test.dart | undefined: name on bridged instance of 'Path' | yes |
| dart_ui/placeholder_alignment_test.dart | undefined: name on bridged instance of 'Placeholder' | yes |
| dart_ui/semantics_hit_test_behavior_test.dart | enum hashCode: SemanticsHitTestBehavior | yes |
| dart_ui/semantics_input_type_test.dart | enum hashCode: SemanticsInputType | yes |
| dart_ui/semantics_role_test.dart | enum hashCode: SemanticsRole | yes |
| dart_ui/semantics_validation_result_test.dart | enum hashCode: SemanticsValidationResult | yes |
| dart_ui/stroke_join_test.dart | enum hashCode: StrokeJoin | yes |
| dart_ui/system_color_palette_test.dart | Expected: true | yes |
| dart_ui/target_pixel_format_test.dart | enum hashCode: TargetPixelFormat | yes |
| dart_ui/text_affinity_test.dart | undefined: name on bridged instance of 'Text' | yes |
| dart_ui/text_align_test.dart | enum hashCode: TextAlign | yes |
| dart_ui/text_baseline_test.dart | undefined: name on bridged instance of 'Text' | yes |
| dart_ui/text_decoration_style_test.dart | undefined: name on bridged instance of 'TextDecoration' | yes |
| dart_ui/text_direction_test.dart | enum hashCode: TextDirection | yes |
| dart_ui/tile_mode_test.dart | enum hashCode: TileMode | yes |
| dart_ui/view_focus_direction_test.dart | undefined: name on bridged instance of 'View' | yes |
| dart_ui/view_focus_state_test.dart | undefined: name on bridged instance of 'View' | yes |
| foundation/diagnostics_stack_trace_test.dart | Native error during default bridged constructor for 'DiagnosticsStackTrace': Arg | yes |
| foundation/object_created_test.dart | not callable: Object | yes |
| foundation/object_disposed_test.dart | not callable: Object | yes |
| foundation/object_event_test.dart | not callable: Object | yes |
| gestures/flutter_error_details_for_pointer_event_dispatcher_test.dart | Native error during default bridged constructor for 'FlutterErrorDetailsForPoint | yes |
| gestures/tap_move_details_test.dart | assertion failure in constructor | |
| material/bottom_navigation_bar_type_test.dart | Expected: true | |
| material/collapse_mode_test.dart | null check failed | |
| material/floating_label_behavior_test.dart | null check failed | |
| material/individual_text_button_theme_data_test.dart | no constructor: _ThemeRecipe | |
| material/individual_text_selection_toolbar_test.dart | no constructor: _ScenarioCard | |
| material/individual_text_selection_toolbar_text_button_test.dart | no constructor: _ButtonFamily | |
| material/material_scroll_behavior_test.dart | undefined: map on _ConstSet<PointerDeviceKind> | |
| painting/enums_painting_test.dart | undefined: name on bridged instance of 'Image' | |
| painting/individual_decoration_image_painter_test.dart | Native error during default bridged constructor for 'Text': Argument Error: Inva | |
| rendering/annotation_entry_test.dart | A value of type '_InteractiveAnnotationDemo' can't be returned from the function | |
| rendering/annotation_result_test.dart | A value of type '_MultipleEntriesWidget' can't be returned from the function '_b | |
| rendering/cache_extent_style_test.dart | A value of type '_InteractiveComparisonWidget' can't be returned from the functi | |
| rendering/cross_axis_alignment_test.dart | undefined: toString on CrossAxisAlignment | |
| rendering/decoration_position_test.dart | undefined: name on bridged instance of 'Decoration' | |
| rendering/flex_fit_test.dart | undefined: name on bridged instance of 'Flex' | |
| rendering/hit_test_behavior_test.dart | Cannot invoke method 'withAlpha' on null. Use '?.' for null-aware method invocat | |
| rendering/individual_box_hit_test_entry_test.dart | A value of type '_InteractiveHitTestArea' can't be returned from the function '_ | |
| rendering/individual_box_hit_test_result_test.dart | Expected: true | |
| rendering/individual_clip_r_superellipse_layer_test.dart | A value of type '_CornerComparisonWidget' can't be returned from the function '_ | |
| rendering/individual_container_box_parent_data_test.dart | A value of type '_InteractiveOffsetWidget' can't be returned from the function ' | |
| rendering/individual_platform_view_layer_test.dart | Expected: true | |
| rendering/individual_relayout_when_system_fonts_change_mixin_test.dart | no constructor: _Profile | |
| rendering/individual_render_absorb_pointer_test.dart | no constructor: _Profile | |
| rendering/individual_render_aligning_shifted_box_test.dart | no constructor: _ThemePreset | |
| rendering/individual_render_animated_opacity_test.dart | no constructor: _ThemeTrack | |
| rendering/individual_render_animated_size_test.dart | no constructor: _ThemePreset | |
| rendering/individual_render_annotated_region_test.dart | no constructor: _ThemePreset | |
| rendering/individual_render_backdrop_filter_test.dart | no constructor: _ThemePreset | |
| rendering/individual_render_baseline_test.dart | no constructor: _ThemePreset | |
| rendering/individual_render_block_semantics_test.dart | no constructor: _ThemePreset | |
| rendering/individual_render_box_container_defaults_mixin_test.dart | no constructor: _ThemeProfile | |
| rendering/individual_render_constrained_overflow_box_test.dart | no constructor: _ThemePreset | |
| rendering/individual_render_custom_multi_child_layout_box_test.dart | no constructor: _ThemePreset | |
| rendering/individual_render_custom_paint_test.dart | no constructor: _PaintThemePreset | |
| rendering/individual_render_custom_single_child_layout_box_test.dart | no constructor: _ThemePreset | |
| rendering/individual_render_physical_model_test.dart | no constructor: _ThemePreset | |
| rendering/individual_render_physical_shape_test.dart | no constructor: _ThemeProfile | |
| rendering/individual_render_pointer_listener_test.dart | no constructor: _ThemePreset | |
| rendering/individual_render_proxy_box_mixin_test.dart | no constructor: _ThemePack | |
| rendering/individual_render_proxy_box_with_hit_test_behavior_test.dart | no constructor: _ThemeProfile | |
| rendering/individual_render_repaint_boundary_test.dart | no constructor: _ThemePalette | |
| rendering/individual_render_rotated_box_test.dart | no constructor: _ThemePack | |
| rendering/individual_render_semantics_annotations_test.dart | Expected: true | |
| rendering/individual_render_semantics_gesture_handler_test.dart | Expected: true | |
| rendering/individual_render_shader_mask_test.dart | Expected: true | |
| rendering/individual_render_shrink_wrapping_viewport_test.dart | Expected: true | |
| rendering/individual_render_sized_overflow_box_test.dart | Expected: true | |
| rendering/individual_render_sliver_animated_opacity_test.dart | Expected: true | |
| rendering/individual_render_sliver_fill_viewport_test.dart | Expected: true | |
| rendering/individual_render_sliver_fixed_extent_list_test.dart | Expected: true | |
| rendering/overflow_box_fit_test.dart | 'build' function accepts at most 0 positional argument(s), but 1 were provided. | |
| rendering/pipeline_manifold_test.dart | Expected: true | |
| rendering/placeholder_span_index_semantics_tag_test.dart | Expected: true | |
| rendering/platform_view_hit_test_behavior_test.dart | Expected: true | |
| rendering/platform_view_render_box_test.dart | no constructor: _FaqItem | |
| rendering/render_abstract_viewport_test.dart | no constructor: _Profile | |
| rendering/render_android_view_test.dart | no constructor: _ThemePreset | |
| rendering/render_animated_opacity_mixin_test.dart | no constructor: _ThemePreset | |
| rendering/render_animated_size_state_test.dart | no constructor: _ThemePreset | |
| rendering/render_app_kit_view_test.dart | no constructor: _ThemePreset | |
| rendering/render_clip_r_superellipse_test.dart | no constructor: _ThemeProfile | |
| rendering/render_darwin_platform_view_test.dart | no constructor: _ThemePreset | |
| rendering/render_decorated_sliver_test.dart | no constructor: _ThemePreset | |
| rendering/render_inline_children_container_defaults_test.dart | assertion failure in constructor | |
| rendering/render_pointer_test.dart | no constructor: _ThemeModel | |
| rendering/render_proxy_sliver_test.dart | Expected: true | |
| rendering/render_sliver_constrained_cross_axis_test.dart | Expected: true | |
| rendering/render_sliver_cross_axis_group_test.dart | Expected: true | |
| rendering/render_sliver_edge_insets_padding_test.dart | Expected: true | |
| rendering/render_sliver_fill_remaining_and_overscroll_test.dart | Expected: true | |
| rendering/render_sliver_fill_remaining_with_scrollable_test.dart | Expected: true | |
| rendering/render_sliver_fixed_extent_box_adaptor_test.dart | Expected: true | |
| rendering/render_sliver_floating_pinned_persistent_header_test.dart | Expected: true | |
| rendering/render_ui_kit_view_test.dart | Expected: true | |
| semantics/semantics_config_test.dart | Expected: true | |
| services/channels_test.dart | Native error during bridged method call 'setMessageHandler' on BasicMessageChann | |
| services/message_codec_test.dart | undefined: lengthInBytes on _ByteDataView | |
| services/method_codec_test.dart | Cannot access property 'lengthInBytes' on target of type _ByteDataView. | |
| widgets/abstract_layout_builder_test.dart | Expected: true | |
| widgets/action_listener_test.dart | Expected: true | |
| widgets/android_overscroll_indicator_test.dart | Expected: true | |
| widgets/android_view_surface_test.dart | Expected: true | |
| widgets/app_kit_view_test.dart | Expected: true | |
| widgets/autocomplete_highlighted_option_test.dart | Expected: true | |
| widgets/autofill_group_state_test.dart | Expected: true | |
| widgets/backdrop_group_test.dart | Expected: true | |
| widgets/batch_3_actions_test.dart | Expected: true | |
| widgets/bottom_navigation_bar_item_test.dart | Expected: true | |
| widgets/box_scroll_view_test.dart | Expected: true | |
| widgets/callback_shortcuts_test.dart | Expected: true | |
| widgets/center_test.dart | Expected: true | |
| widgets/child_back_button_dispatcher_test.dart | Expected: true | |
| widgets/context_action_test.dart | Native error during default bridged constructor for 'Actions': Argument Error: I | |
| widgets/default_selection_style_test.dart | Expected: true | |
| widgets/default_text_editing_shortcuts_test.dart | Expected: true | |
| widgets/device_orientation_builder_test.dart | Expected: true | |
| widgets/dismissible_test.dart | Expected: true | |
| widgets/draggable_scrollable_actuator_test.dart | Expected: true | |
| widgets/expansible_test.dart | Expected: true | |
| widgets/flex_test.dart | Expected: true | |
| widgets/gesture_detector_adv_test.dart | Expected: true | |
| widgets/hero_controller_scope_test.dart | Expected: true | |
| widgets/hero_controller_test.dart | Expected: true | |
| widgets/icon_data_test.dart | Expected: true | |
| widgets/ignore_baseline_test.dart | Expected: true | |
| widgets/image_icon_test.dart | Expected: true | |
| widgets/img_element_platform_view_test.dart | Expected: true | |
| widgets/individual_android_view_test.dart | Expected: true | |
| widgets/individual_autofill_group_test.dart | Expected: true | |
| widgets/individual_checked_mode_banner_test.dart | Expected: true | |
| widgets/individual_composited_transform_follower_test.dart | Expected: true | |
| widgets/individual_default_asset_bundle_test.dart | Expected: true | |
| widgets/individual_default_text_height_behavior_test.dart | Expected: true | |
| widgets/individual_directionality_test.dart | Expected: true | |
| widgets/individual_display_feature_sub_screen_test.dart | Expected: true | |
| widgets/individual_fade_in_image_test.dart | Expected: true | |
| widgets/individual_glowing_overscroll_indicator_test.dart | Expected: true | |
| widgets/individual_html_element_view_test.dart | Expected: true | |
| widgets/individual_indexed_stack_test.dart | Expected: true | |
| widgets/individual_inherited_notifier_test.dart | Expected: true | |
| widgets/individual_inherited_theme_test.dart | Expected: true | |
| widgets/individual_inherited_widget_test.dart | Expected: true | |
| widgets/individual_list_wheel_scroll_view_test.dart | Expected: true | |
| widgets/individual_list_wheel_viewport_test.dart | Expected: true | |
| widgets/individual_magnifier_decoration_test.dart | Expected: true | |
| widgets/individual_navigation_toolbar_test.dart | Expected: true | |
| widgets/individual_overflow_bar_test.dart | Expected: true | |
| widgets/individual_overflow_box_test.dart | Expected: true | |
| widgets/individual_page_storage_bucket_test.dart | Expected: true | |
| widgets/individual_page_storage_test.dart | Expected: true | |
| widgets/inspector_button_variant_test.dart | enum hashCode: InspectorButtonVariant | |
| widgets/keyboard_listener_test.dart | Expected: true | |
| widgets/layout_id_test.dart | Expected: true | |
| widgets/live_text_input_status_test.dart | enum hashCode: LiveTextInputStatus | |
| widgets/lock_state_test.dart | enum hashCode: LockState | |
| widgets/logical_key_set_test.dart | undefined: length on _HashSet<LogicalKeyboardKey> | |
| widgets/lookup_boundary_test.dart | Expected: true | |
| widgets/meta_data_test.dart | Expected: true | |
| widgets/modal_barrier_test.dart | Expected: true | |
| widgets/navigation_mode_test.dart | enum hashCode: NavigationMode | |
| widgets/navigator_pop_handler_test.dart | Expected: true | |
| widgets/orientation_builder_test.dart | Expected: true | |
| widgets/overlay_state_test.dart | Expected: true | |
| widgets/raw_menu_overlay_info_test.dart | not callable: Object | |
| widgets/stream_builder_base_test.dart | Error during constructor execution for class 'CountStreamBuilder': Bridged super | |
| widgets/two_dimensional_child_list_delegate_test.dart | Native error during default bridged constructor for 'TwoDimensionalChildListDele | |
| widgets/void_callback_intent_test.dart | undefined: runtimeType on () => void | |
| widgets/widget_state_color_test.dart | undefined: contains on _ConstSet<WidgetState> | |
| widgets/widget_state_mapper_test.dart | Undefined enum value 'any' on bridged enum 'WidgetState'. (in Map literal) | |
| widgets/widget_state_property_all_test.dart | Error in generic constructor factory for 'WidgetStatePropertyAll': type 'Null' i | |
| widgets/widget_state_test.dart | Error executing bridged method "isSatisfiedBy" on WidgetState.hovered: type '_Se | |
| widgets/widget_states_constraint_test.dart | Error executing bridged method "isSatisfiedBy" on WidgetState.hovered: type '_Se | |

## SOCKET_EXCEPTION (62 failures)

| File | Failure Type | Fixed |
|------|-------------|-------|
| material/shape_border_tween_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/show_value_indicator_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/simple_dialog_option_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/slider_interaction_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/snack_bar_theme_data_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/spell_check_suggestions_toolbar_layout_delegate_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/standard_fab_location_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/step_style_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/stretch_mode_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/tab_alignment_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/tab_indicator_animation_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/tab_page_selector_indicator_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/tab_page_selector_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/table_row_ink_well_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/tappable_chip_attributes_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/text_magnifier_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/theme_data_tween_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/theme_extension_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/theme_mode_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/thumb_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/time_of_day_format_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/time_picker_entry_mode_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/toggle_buttons_theme_data_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/toggle_buttons_theme_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/tooltip_state_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/underline_tab_indicator_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/vertical_divider_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| material/widget_state_input_border_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/accumulator_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/asset_bundle_image_key_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/axis_direction_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/axis_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/border_style_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/box_fit_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/box_shape_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/class_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/clip_context_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/color_property_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/fitted_sizes_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/flutter_logo_style_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/image_repeat_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/image_size_info_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/image_stream_completer_handle_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/inline_span_semantics_information_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/inline_span_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/matrix_utils_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/multi_frame_image_stream_completer_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/network_image_load_exception_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/one_frame_image_stream_completer_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/painting_binding_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/render_comparison_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/resize_image_policy_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/shader_warm_up_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/text_overflow_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/text_width_basis_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/transform_property_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/vertical_direction_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/web_html_element_strategy_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| painting/web_image_info_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| physics/bounded_friction_simulation_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| physics/class_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |
| physics/spring_type_test.dart | SocketException: Connection refused (OS Error: Connection refused, errno = 111), | |

## PARSE_ERROR (5 failures)

| File | Failure Type | Fixed |
|------|-------------|-------|
| dart_ui/point_mode_test.dart | type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast | |
| rendering/child_layout_helper_test.dart | type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast | |
| services/mouse_cursor_manager_test.dart | type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast | |
| widgets/icon_data_property_test.dart | type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast | |
| widgets/individual_implicitly_animated_widget_test.dart | type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast | |

## IMPORT_ERROR (4 failures)

| File | Failure Type | Fixed |
|------|-------------|-------|
| material/list_tile_style_test.dart | Bad state: Cannot resolve import "package:flutter_test/flutter_test.dart" from m | |
| painting/asset_bundle_image_provider_test.dart | Bad state: Script not found: /srv/repos/al_the_bear/inhouse/second_wind/enterpri | |
| rendering/class_test.dart | Bad state: Cannot resolve import "package:flutter_test/flutter_test.dart" from m | |
| rendering/diagnostics_debug_creator_test.dart | Bad state: Cannot resolve import "package:flutter_test/flutter_test.dart" from m | |

## OTHER (1 failures)

| File | Failure Type | Fixed |
|------|-------------|-------|
| material/selection_area_test.dart | HttpException: Connection closed before full header was received, uri = http://l | |

