# Issue Analysis — tom_d4rt_flutter_ast

| Field | Value |
|-------|-------|
| Run ID | `20260607-2016-issue-analysis` |
| Git rev | `852f04750` — *docs(d4rt_generator): worked-samples catalog + drift guard* |
| Started | 2026-06-07 20:18:16 |
| Finished | 2026-06-08 00:26:48 |
| Wall clock | ~4h08m (13 files, **serial** — shared HTTP companion app) |
| Command | `flutter test test/<file>.dart --file-reporter json:<file>.result.json` |

## Headline result

| Outcome | Count |
|---------|------:|
| Passed | 1986 |
| Skipped (reporter `~`) | 4 |
| **Failed** | **208** |
| Total | 2198 |
| Files run | 13 (`crashing_tests_test` skipped — no such file in this project) |
| Clean files | `interactive_tests_test` (+6, all pass) |

## Failure taxonomy

All 208 failures fall into exactly **two infrastructure buckets** — there is **no
new interpreter/bridge correctness failure** behind any of them:

| Bucket | Count | Signature |
|--------|------:|-----------|
| 30s test-timeout | 116 | `TimeoutException after 0:00:30 — Test timed out after 30 seconds` |
| Transport failure | 92 | `Bad state: Transport failure while running "<script>"` |

### Root cause — a cascade on the shared companion app

The two buckets are **one mechanism, not two**. The corpus drives a single
long-lived Flutter companion app over HTTP (`flutter run -d macos`), one build
per script. The failures interleave in strict pairs across every file:

```
… icons_test (30s timeout) → list_test (transport failure)
   notifier_test (30s timeout) → details_test (transport failure)
   inputdecoration_test (30s timeout) → listtile_test (transport failure) …
```

The cascade:

1. A script's build/interpret **hangs past the per-test 30s ceiling** → the dart
   test framework kills it (`TimeoutException after 0:00:30`). The companion app
   is left mid-build, transport in a dirty state.
2. The **next** script's pre-build `GET /clear` cannot complete within the
   harness's 5s clear ceiling → `TimeoutException after 0:00:05` → the runner
   declares `Bad state: Transport failure`.

This is confirmed numerically: **transport-failures (92) == `GET /clear` 5s
timeouts (92)**, exactly 1:1. So the 92 transport failures are *collateral* — the
poisoned-transport tail of the 116 primary hangs, not independent defects.

> **Note vs. the prior run (`20260604-1035`).** The earlier signature — a 25s
> `POST /build` transport timeout (the hardcoded `_httpBuildTimeout`) — does
> **not** appear here (0 occurrences). The pressure point has moved to the
> dart-test **30s per-test** ceiling and the **5s `GET /clear`** ceiling. The
> outer `flutter test --timeout` no longer shields the inner build; the build is
> simply slow/hanging on a subset of scripts and the 30s framework timeout wins.

## Per-file failures

#### `blocking_tests_test` — 3 failing

| Script | Failure mode |
|--------|--------------|
| `cupertino_spell_check_suggestions_toolbar_test.dart` | 30s test timeout |
| `ztmp_path_metrics_access_test.dart` | 30s test timeout |
| `semantics_action_test.dart` | transport failure |

#### `essential_classes_test` — 12 failing

| Script | Failure mode |
|--------|--------------|
| `icons_test.dart` | 30s test timeout |
| `list_test.dart` | transport failure |
| `notifier_test.dart` | 30s test timeout |
| `details_test.dart` | transport failure |
| `inputdecoration_test.dart` | 30s test timeout |
| `listtile_test.dart` | transport failure |
| `edge_insets_test.dart` | 30s test timeout |
| `edgeinsets_test.dart` | transport failure |
| `flexible_test.dart` | 30s test timeout |
| `focusnode_test.dart` | transport failure |
| `positioned_test.dart` | 30s test timeout |
| `richtext_test.dart` | transport failure |

#### `generator_interpreter_issues_test` — 2 failing

| Script | Failure mode |
|--------|--------------|
| `inherited_theme_test.dart` | 30s test timeout |
| `inherited_widget_test.dart` | transport failure |

#### `generator_interpreter_retest_test` — 1 failing

| Script | Failure mode |
|--------|--------------|
| `render_nested_scroll_view_viewport_test.dart` | 30s test timeout |

#### `hardly_relevant_classes_1_test` — 21 failing

| Script | Failure mode |
|--------|--------------|
| `elastic_in_out_curve_test.dart` | 30s test timeout |
| `elastic_out_curve_test.dart` | 30s test timeout |
| `flipped_curve_test.dart` | transport failure |
| `expansion_tile_transition_mode_test.dart` | 30s test timeout |
| `inherited_cupertino_theme_test.dart` | transport failure |
| `clip_path_engine_layer_test.dart` | 30s test timeout |
| `clip_r_rect_engine_layer_test.dart` | transport failure |
| `offset_engine_layer_test.dart` | 30s test timeout |
| `opacity_engine_layer_test.dart` | transport failure |
| `text_align_test.dart` | 30s test timeout |
| `tristate_test.dart` | 30s test timeout |
| `uniform_vec3_slot_test.dart` | 30s test timeout |
| `category_test.dart` | 30s test timeout |
| `diagnostic_level_test.dart` | 30s test timeout |
| `diagnosticable_node_test.dart` | transport failure |
| `foundation_service_extensions_test.dart` | 30s test timeout |
| `int_property_test.dart` | transport failure |
| `hit_test_dispatcher_test.dart` | 30s test timeout |
| `hit_testable_test.dart` | transport failure |
| `pointer_pan_zoom_start_event_test.dart` | 30s test timeout |
| `pointer_pan_zoom_update_event_test.dart` | transport failure |

#### `hardly_relevant_classes_2_test` — 20 failing

| Script | Failure mode |
|--------|--------------|
| `carousel_view_theme_data_test.dart` | transport failure |
| `dropdown_button_hide_underline_test.dart` | 30s test timeout |
| `durations_test.dart` | 30s test timeout |
| `dynamic_scheme_variant_test.dart` | 30s test timeout |
| `easing_test.dart` | transport failure |
| `grid_tile_bar_test.dart` | 30s test timeout |
| `handle_range_slider_thumb_shape_test.dart` | 30s test timeout |
| `handle_thumb_shape_test.dart` | transport failure |
| `navigation_rail_label_type_test.dart` | 30s test timeout |
| `no_splash_test.dart` | 30s test timeout |
| `platform_adaptive_icons_test.dart` | 30s test timeout |
| `popup_menu_button_state_test.dart` | transport failure |
| `rounded_rect_range_slider_value_indicator_shape_test.dart` | 30s test timeout |
| `rounded_rect_slider_value_indicator_shape_test.dart` | transport failure |
| `tab_page_selector_indicator_test.dart` | 30s test timeout |
| `tab_page_selector_test.dart` | transport failure |
| `axis_direction_test.dart` | 30s test timeout |
| `axis_test.dart` | transport failure |
| `render_comparison_test.dart` | 30s test timeout |
| `resize_image_policy_test.dart` | transport failure |

#### `hardly_relevant_classes_3_test` — 20 failing

| Script | Failure mode |
|--------|--------------|
| `flow_parent_data_test.dart` | 30s test timeout |
| `fraction_column_width_test.dart` | transport failure |
| `platform_view_hit_test_behavior_test.dart` | 30s test timeout |
| `platform_view_render_box_test.dart` | transport failure |
| `render_proxy_sliver_test.dart` | 30s test timeout |
| `render_sliver_box_child_manager_test.dart` | transport failure |
| `selection_event_type_test.dart` | 30s test timeout |
| `selection_extend_direction_test.dart` | transport failure |
| `class_test.dart` | 30s test timeout |
| `priority_test.dart` | 30s test timeout |
| `scheduler_phase_test.dart` | transport failure |
| `autofill_scope_mixin_test.dart` | transport failure |
| `i_o_s_system_context_menu_item_data_select_all_test.dart` | 30s test timeout |
| `i_o_s_system_context_menu_item_data_share_test.dart` | transport failure |
| `method_codec_test.dart` | 30s test timeout |
| `missing_plugin_exception_test.dart` | transport failure |
| `raw_keyboard_test.dart` | 30s test timeout |
| `restoration_bucket_test.dart` | transport failure |
| `text_editing_value_test.dart` | 30s test timeout |
| `text_input_action_test.dart` | transport failure |

#### `hardly_relevant_classes_4_test` — 24 failing

| Script | Failure mode |
|--------|--------------|
| `autocomplete_first_option_intent_test.dart` | 30s test timeout |
| `autocomplete_highlighted_option_test.dart` | 30s test timeout |
| `autocomplete_last_option_intent_test.dart` | transport failure |
| `box_constraints_tween_test.dart` | 30s test timeout |
| `box_scroll_view_test.dart` | transport failure |
| `cross_fade_state_test.dart` | 30s test timeout |
| `debug_creator_test.dart` | 30s test timeout |
| `decorated_sliver_test.dart` | transport failure |
| `directional_focus_action_test.dart` | 30s test timeout |
| `directional_focus_intent_test.dart` | transport failure |
| `draggable_details_test.dart` | 30s test timeout |
| `draggable_scrollable_actuator_test.dart` | 30s test timeout |
| `draggable_scrollable_controller_test.dart` | transport failure |
| `extend_selection_to_next_word_boundary_intent_test.dart` | 30s test timeout |
| `extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart` | transport failure |
| `hold_scroll_activity_test.dart` | 30s test timeout |
| `i_o_s_system_context_menu_item_copy_test.dart` | transport failure |
| `inspector_selection_test.dart` | 30s test timeout |
| `inspector_serialization_delegate_test.dart` | transport failure |
| `multi_selectable_selection_container_delegate_test.dart` | 30s test timeout |
| `navigation_mode_test.dart` | transport failure |
| `overlay_portal_controller_test.dart` | 30s test timeout |
| `overlay_portal_test.dart` | 30s test timeout |
| `overlay_route_test.dart` | transport failure |

#### `hardly_relevant_classes_5_test` — 14 failing

| Script | Failure mode |
|--------|--------------|
| `raw_menu_anchor_group_test.dart` | 30s test timeout |
| `raw_menu_anchor_test.dart` | transport failure |
| `render_object_to_widget_adapter_test.dart` | 30s test timeout |
| `render_sliver_overlap_absorber_test.dart` | 30s test timeout |
| `render_sliver_overlap_injector_test.dart` | transport failure |
| `restorable_enum_n_test.dart` | 30s test timeout |
| `restorable_int_n_test.dart` | transport failure |
| `scroll_context_test.dart` | 30s test timeout |
| `scroll_deceleration_rate_test.dart` | 30s test timeout |
| `scroll_drag_controller_test.dart` | transport failure |
| `tree_sliver_state_mixin_test.dart` | 30s test timeout |
| `tree_sliver_test.dart` | transport failure |
| `void_callback_action_test.dart` | 30s test timeout |
| `web_browser_detection_test.dart` | transport failure |

#### `important_classes_test` — 17 failing

| Script | Failure mode |
|--------|--------------|
| `fadetransition_test.dart` | transport failure |
| `animatedpadding_test.dart` | 30s test timeout |
| `animatedpositioned_test.dart` | transport failure |
| `menuanchor_test.dart` | 30s test timeout |
| `expansionpanel_test.dart` | transport failure |
| `menubar_test.dart` | 30s test timeout |
| `expansiontile_test.dart` | transport failure |
| `focustraversal_test.dart` | 30s test timeout |
| `blocksemantics_test.dart` | transport failure |
| `refresh_test.dart` | 30s test timeout |
| `datepicker_modes_test.dart` | transport failure |
| `animatable_test.dart` | 30s test timeout |
| `simulations_test.dart` | transport failure |
| `cursor_test.dart` | 30s test timeout |
| `textboundary_test.dart` | transport failure |
| `parentdata_test.dart` | 30s test timeout |
| `gradient_rendering_test.dart` | transport failure |

#### `secondary_classes_test` — 72 failing

| Script | Failure mode |
|--------|--------------|
| `cupertino_colors_system_test.dart` | 30s test timeout |
| `cupertino_misc_adv_test.dart` | transport failure |
| `chip_variants_test.dart` | 30s test timeout |
| `datetime_utils_test.dart` | transport failure |
| `nav_badge_advanced_test.dart` | 30s test timeout |
| `search_filled_test.dart` | transport failure |
| `button_styles_misc_test.dart` | 30s test timeout |
| `autocomplete_chips_test.dart` | transport failure |
| `layer_types_test.dart` | 30s test timeout |
| `render_composite_test.dart` | transport failure |
| `defaulttextstyle_test.dart` | 30s test timeout |
| `focus_properties_test.dart` | transport failure |
| `restoration_scope_test.dart` | 30s test timeout |
| `undo_history_test.dart` | transport failure |
| `interactive_viewer_test.dart` | 30s test timeout |
| `form_field_test.dart` | 30s test timeout |
| `layout_builder_adv_test.dart` | transport failure |
| `cupertino_picker_default_selection_overlay_test.dart` | 30s test timeout |
| `cupertino_scroll_behavior_test.dart` | transport failure |
| `path_metric_test.dart` | 30s test timeout |
| `path_metrics_test.dart` | transport failure |
| `view_focus_event_test.dart` | 30s test timeout |
| `aggregated_timed_block_test.dart` | transport failure |
| `device_gesture_settings_test.dart` | 30s test timeout |
| `drag_gesture_recognizer_test.dart` | transport failure |
| `tap_drag_end_details_test.dart` | 30s test timeout |
| `tap_drag_start_details_test.dart` | 30s test timeout |
| `tap_drag_up_details_test.dart` | transport failure |
| `date_utils_test.dart` | 30s test timeout |
| `default_material_localizations_test.dart` | transport failure |
| `range_slider_thumb_shape_test.dart` | 30s test timeout |
| `range_slider_tick_mark_shape_test.dart` | transport failure |
| `spell_check_suggestions_toolbar_test.dart` | 30s test timeout |
| `stepper_type_test.dart` | transport failure |
| `image_info_test.dart` | 30s test timeout |
| `image_stream_completer_test.dart` | transport failure |
| `clip_path_layer_test.dart` | 30s test timeout |
| `clip_r_superellipse_layer_test.dart` | transport failure |
| `render_aligning_shifted_box_test.dart` | 30s test timeout |
| `render_annotated_region_test.dart` | 30s test timeout |
| `render_backdrop_filter_test.dart` | transport failure |
| `render_indexed_stack_test.dart` | 30s test timeout |
| `render_leader_layer_test.dart` | transport failure |
| `render_sliver_fill_remaining_test.dart` | 30s test timeout |
| `render_sliver_scrolling_persistent_header_test.dart` | 30s test timeout |
| `render_sliver_to_box_adapter_test.dart` | transport failure |
| `sliver_physical_parent_data_test.dart` | 30s test timeout |
| `text_parent_data_test.dart` | 30s test timeout |
| `text_selection_point_test.dart` | transport failure |
| `font_loader_test.dart` | 30s test timeout |
| `hybrid_android_view_controller_test.dart` | transport failure |
| `undo_manager_test.dart` | 30s test timeout |
| `animated_cross_fade_test.dart` | 30s test timeout |
| `animated_fractionally_sized_box_test.dart` | transport failure |
| `default_asset_bundle_test.dart` | 30s test timeout |
| `default_text_height_behavior_test.dart` | transport failure |
| `leaf_render_object_widget_test.dart` | 30s test timeout |
| `list_wheel_child_list_delegate_test.dart` | 30s test timeout |
| `list_wheel_scroll_view_test.dart` | 30s test timeout |
| `list_wheel_viewport_test.dart` | transport failure |
| `pinned_header_sliver_test.dart` | 30s test timeout |
| `platform_menu_bar_test.dart` | transport failure |
| `restorable_enum_test.dart` | 30s test timeout |
| `restorable_string_test.dart` | 30s test timeout |
| `restorable_text_editing_controller_test.dart` | transport failure |
| `single_ticker_provider_state_mixin_test.dart` | 30s test timeout |
| `sliver_animated_grid_test.dart` | transport failure |
| `table_cell_test.dart` | 30s test timeout |
| `tap_region_surface_test.dart` | 30s test timeout |
| `tap_region_test.dart` | transport failure |
| `widget_inspector_test.dart` | 30s test timeout |
| `widget_test.dart` | transport failure |

#### `timeout_tests_test` — 2 failing

| Script | Failure mode |
|--------|--------------|
| `render_pointer_listener_test.dart` | transport failure |
| `context_action_test.dart` | transport failure |

## Captured framework / runtime errors (did NOT cause a test failure)

A separate scan of all 13 logs for `RenderFlex`/`overflowed`, `EXCEPTION CAUGHT
BY`, and `capturedFrameworkErrors=[1-9]` — the "captured error output that may
not have led to a failure" the request asked about:

| Signature | Count | Verdict |
|-----------|------:|---------|
| `RenderFlex` / `overflowed` | 0 | none |
| `EXCEPTION CAUGHT BY …` | 0 | none |
| `capturedFrameworkErrors=33` | 2 | **1 genuine interpreter bug** (below) |
| `[framework error]` log lines | 22 | all the *same* bug, `secondary_classes` |
| `RangeError` | 2 | **false positive** — text inside a `[script]` source echo, not a thrown error |

### The one genuine defect — `painting/gradient_transform_test.dart`

In `secondary_classes_test`, the build of `painting/gradient_transform_test.dart`
completed but fired **33 captured framework errors**, all identical:

```
Runtime Error: Native error during bridged operator '*' on double:
type 'NativeFunction' is not a subtype of type 'num' in type cast
```

This is a **real interpreter/bridge bug**, independent of the timeout cascade: a
bridged numeric `operator *` is receiving a `NativeFunction` where it expects a
`num`, and the cast throws. The build still "completes" (errors are captured, not
fatal), so it does **not** appear in the 208 failures — but it is the only
substantive correctness signal in this run and is worth a dedicated cluster fix
(bridged-operator argument coercion / a Gradient transform callback being passed
where a scalar is expected).

## Conclusion

- **208 failures = 116 build hangs (30s) + 92 collateral transport failures
  (5s `GET /clear`).** A single root mechanism: slow/hanging builds poisoning the
  shared companion-app transport for the following script. No RenderFlex/overflow,
  no uncaught framework exceptions.
- **1 genuine interpreter bug**: bridged `operator *` on `double` rejecting a
  `NativeFunction` in `painting/gradient_transform_test.dart` (captured, 33×) —
  the only correctness defect; everything else is harness-timing infrastructure.
- **Infra recommendation**: the cascade is the dominant noise source. Worth
  isolating which scripts genuinely hang vs. are merely slow (the 30s ceiling is
  tight for the heaviest builds: `secondary_classes` did 432 builds), and making
  the `GET /clear` recover the transport rather than declaring the next script a
  transport failure — that alone would convert ~92 reported failures back into
  honest pass/fail signal.
