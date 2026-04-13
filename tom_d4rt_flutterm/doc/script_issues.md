# Script Issues

batch: 0

- No non-immediate batch-0 script issues remained after immediate fixes.
- Immediate batch-0 script fixes were applied and validated for:
  - cupertino/controls_test.dart
  - cupertino/form_test.dart
  - cupertino/textfield_test.dart
  - rendering/viewport_test.dart

batch: 1

- No non-immediate batch-1 script issues remained after immediate fixes.
- Immediate batch-1 script fixes were applied and validated for:
  - animation/reverse_tween_test.dart
  - cupertino/cupertino_desktop_text_selection_controls_test.dart
  - cupertino/cupertino_focus_halo_test.dart
  - cupertino/cupertino_text_selection_handle_controls_test.dart

batch: 2

- No non-immediate batch-2 script issues remained after immediate fixes.
- Immediate batch-2 script fixes were applied and validated for:
  - cupertino/inherited_cupertino_theme_test.dart
  - cupertino/overlay_visibility_mode_test.dart
  - dart_ui/blur_style_test.dart
  - dart_ui/color_space_test.dart
  - dart_ui/key_event_type_test.dart
- Notes:
  - `color_space_test.dart` and `key_event_type_test.dart` were stabilized with script-level mitigations while related interpreter/bridge follow-up analysis was documented in `interpreter_issues.md` and `generator_issues.md`.

batch: 3

- No non-immediate batch-3 script issues remained after immediate fixes.
- Immediate batch-3 script fixes were applied and validated for:
  - dart_ui/placeholder_alignment_test.dart
  - dart_ui/system_color_palette_test.dart
  - dart_ui/vertex_mode_test.dart
  - foundation/object_created_test.dart
  - foundation/object_disposed_test.dart
- Notes:
  - `system_color_palette_test.dart` was stabilized with unsupported-platform fallback rendering while interpreter platform capability follow-up was documented in `interpreter_issues.md`.
  - `vertex_mode_test.dart`, `object_created_test.dart`, and `object_disposed_test.dart` include script-level mitigations with bridge follow-up items documented in `generator_issues.md`.

batch: 4

- No non-immediate batch-4 script issues remained after immediate fixes.
- Immediate batch-4 script/harness fixes were applied and validated for:
  - foundation/object_event_test.dart
  - foundation/target_platform_test.dart
  - gestures/class_test.dart
  - test/hardly_relevant_classes_2_test.dart (setUpAll log-only indexing mitigation)
  - material/bottom_navigation_bar_type_test.dart
- Notes:
  - `object_event_test.dart` and `bottom_navigation_bar_type_test.dart` were stabilized with script-level mitigations while related bridge follow-up analysis was documented in `generator_issues.md`.

batch: 5

- No non-immediate batch-5 script issues remained after immediate fixes.
- Immediate batch-5 script fixes were applied and validated for:
  - material/button_bar_layout_behavior_test.dart
  - material/button_bar_theme_test.dart
  - material/button_text_theme_test.dart
  - material/collapse_mode_test.dart
  - material/drawer_controller_state_test.dart
- Notes:
  - `collapse_mode_test.dart` and `drawer_controller_state_test.dart` were direct script-level contract/layout fixes.
  - `button_bar_layout_behavior_test.dart`, `button_bar_theme_test.dart`, and `button_text_theme_test.dart` are stabilized script-side while deeper interpreter/bridge follow-up is documented in `interpreter_issues.md` and `generator_issues.md`.

batch: 6

- No non-immediate batch-6 script issues remained after immediate fixes.
- Immediate batch-6 script fixes were applied and validated for:
  - material/dropdown_menu_close_behavior_test.dart
  - material/end_drawer_button_test.dart
  - material/gapped_range_slider_track_shape_test.dart
  - material/gapped_slider_track_shape_test.dart
  - material/hour_format_test.dart
- Notes:
  - `end_drawer_button_test.dart` and `gapped_slider_track_shape_test.dart` were direct script-level layout/theme-contract stabilizations.
  - `dropdown_menu_close_behavior_test.dart`, `gapped_range_slider_track_shape_test.dart`, and `hour_format_test.dart` are stabilized script-side while deeper interpreter follow-up is documented in `interpreter_issues.md`.

batch: 7

- No non-immediate batch-7 script issues remained after immediate fixes.
- Immediate batch-7 script fixes were applied and validated for:
  - material/list_tile_title_alignment_test.dart
  - material/material_banner_closed_reason_test.dart
  - material/menu_accelerator_callback_binding_test.dart
  - material/navigation_destination_label_behavior_test.dart
  - material/navigation_drawer_theme_test.dart
- Notes:
  - `list_tile_title_alignment_test.dart`, `menu_accelerator_callback_binding_test.dart`, and `navigation_drawer_theme_test.dart` were direct script-level layout/constraint stabilizations.
  - `material_banner_closed_reason_test.dart` and `navigation_destination_label_behavior_test.dart` are stabilized script-side while deeper interpreter follow-up is documented in `interpreter_issues.md`.

batch: 8

- No non-immediate batch-8 script issues remained after immediate fixes.
- Immediate batch-8 script fixes were applied and validated for:
  - material/navigation_rail_label_type_test.dart
  - material/paginated_data_table_state_test.dart
  - material/popup_menu_position_test.dart
  - material/progress_indicator_test.dart
  - material/refresh_progress_indicator_test.dart
- Notes:
  - `paginated_data_table_state_test.dart`, `progress_indicator_test.dart`, and `refresh_progress_indicator_test.dart` were direct script-level layout/value-contract stabilizations.
  - `navigation_rail_label_type_test.dart` and `popup_menu_position_test.dart` are stabilized script-side while deeper interpreter/generator follow-up is documented in `interpreter_issues.md` and `generator_issues.md`.

batch: 9

- No non-immediate batch-9 script issues remained after immediate fixes.
- Immediate batch-9 script fixes were applied and validated for:
  - material/theme_extension_test.dart
  - material/theme_mode_test.dart
  - material/thumb_test.dart
  - material/time_of_day_format_test.dart
  - material/time_picker_entry_mode_test.dart
- Notes:
  - `theme_mode_test.dart`, `thumb_test.dart`, and `time_picker_entry_mode_test.dart` were direct script-level layout-bounding stabilizations.
  - `theme_extension_test.dart` is stabilized script-side while deeper bridge-generator follow-up is documented in `generator_issues.md`.
  - Complex script deep analysis (issue-index: 48, `time_of_day_format_test.dart`):
    - The prior script produced a high-volume cascade of infinite-size errors (47) across multiple render layers, indicating broad unbounded composition rather than a single widget misuse.
    - Repeated failure signatures across adjacent time-related scripts suggest a shared scaffold pattern with missing size constraints in interactive sections.
    - Immediate mitigation moved the scenario to a bounded `ListView`-based summary flow, eliminating framework errors, but long-term script quality should enforce reusable bounded-layout helpers for material time demos.

batch: 10

- No non-immediate batch-10 script issues remained after immediate fixes.
- Immediate batch-10 script fixes were applied and validated for:
  - material/toggle_buttons_theme_data_test.dart
  - material/toggle_buttons_theme_test.dart
  - material/tooltip_state_test.dart
  - painting/axis_direction_test.dart
  - painting/axis_test.dart
- Notes:
  - `tooltip_state_test.dart` and `axis_test.dart` were direct script-level constructor/layout contract stabilizations.
  - `toggle_buttons_theme_data_test.dart`, `toggle_buttons_theme_test.dart`, and `axis_direction_test.dart` are stabilized script-side while deeper bridge/interpreter follow-up is documented in `generator_issues.md` and `interpreter_issues.md`.

batch: 11

- No non-immediate batch-11 script issues remained after immediate fixes.
- Immediate batch-11 script/harness fixes were applied and validated for:
  - test/hardly_relevant_classes_3_test.dart (setUpAll log-only indexing mitigation)
  - rendering/floating_header_snap_configuration_test.dart
  - rendering/hit_test_behavior_test.dart
  - rendering/over_scroll_header_stretch_configuration_test.dart
  - rendering/pipeline_manifold_test.dart
- Notes:
  - `floating_header_snap_configuration_test.dart` and `pipeline_manifold_test.dart` were direct script-level layout/state-initialization stabilizations.
  - `hit_test_behavior_test.dart` and `over_scroll_header_stretch_configuration_test.dart` are stabilized script-side while deeper interpreter/bridge follow-up is documented in `interpreter_issues.md` and `generator_issues.md`.

batch: 12

- No non-immediate batch-12 script issues remained after immediate fixes.
- Immediate batch-12 script fixes were applied and validated for:
  - rendering/placeholder_span_index_semantics_tag_test.dart
  - rendering/platform_view_render_box_test.dart
  - rendering/render_abstract_viewport_test.dart
  - rendering/render_android_view_test.dart
  - rendering/render_animated_opacity_mixin_test.dart
- Notes:
  - `placeholder_span_index_semantics_tag_test.dart`, `platform_view_render_box_test.dart`, `render_abstract_viewport_test.dart`, and `render_animated_opacity_mixin_test.dart` were direct script-level state/layout stabilizations.
  - `render_android_view_test.dart` is stabilized script-side while deeper interpreter follow-up is documented in `interpreter_issues.md`.

batch: 13

- No non-immediate batch-13 script issues remained after immediate fixes.
- Immediate batch-13 script fixes were applied and validated for:
  - rendering/render_animated_size_state_test.dart
  - rendering/render_clip_r_superellipse_test.dart
  - rendering/render_editable_painter_test.dart
  - rendering/render_sliver_box_child_manager_test.dart
  - rendering/render_sliver_floating_pinned_persistent_header_test.dart
- Notes:
  - `render_clip_r_superellipse_test.dart`, `render_editable_painter_test.dart`, and `render_sliver_floating_pinned_persistent_header_test.dart` were direct script-level null-contract/layout/state-context stabilizations.
  - `render_animated_size_state_test.dart` and `render_sliver_box_child_manager_test.dart` are stabilized script-side while deeper bridge-generator follow-up is documented in `generator_issues.md`.

batch: 14

- No non-immediate batch-14 script issues remained after immediate fixes.
- Immediate batch-14 script/harness fixes were applied and validated for:
  - rendering/render_ui_kit_view_test.dart
  - services/message_codec_test.dart
  - services/method_codec_test.dart
  - services/raw_key_up_event_test.dart
  - test/hardly_relevant_classes_4_test.dart (setUpAll log-only indexing mitigation)
- Notes:
  - `render_ui_kit_view_test.dart` and `raw_key_up_event_test.dart` were direct script-level state-context/layout-bounding stabilizations.
  - `test/hardly_relevant_classes_4_test.dart` now uses `SendTestRunner.setUp(regenerateBridges: false)` to keep setup telemetry from being indexed as runtime issues.
  - `message_codec_test.dart` and `method_codec_test.dart` are stabilized script-side while deeper bridge-generator follow-up is documented in `generator_issues.md`.
  - Complex script deep analysis (issue-index: 70, `render_ui_kit_view_test.dart`):
    - The runtime warning originated from implicit `widget` lookup on a state path that is not guaranteed to expose `State.widget` semantics in interpreted execution.
    - This failure pattern matches prior state-context defects where script code couples runtime behavior to framework-owned state properties instead of explicit data plumbing.
    - Immediate mitigation moved the scenario to deterministic local configuration values, but long-term script quality should enforce explicit context/data passing patterns for stateful deep demos.

batch: 15

- No non-immediate batch-15 script issues remained after immediate fixes.
- Immediate batch-15 script fixes were applied and validated for:
  - widgets/action_listener_test.dart
  - widgets/align_transition_test.dart
  - widgets/android_view_surface_test.dart
  - widgets/animated_positioned_directional_test.dart
  - widgets/app_kit_view_test.dart
- Notes:
  - `action_listener_test.dart` and `align_transition_test.dart` were direct script-level state-initialization stabilizations.
  - `android_view_surface_test.dart` and `app_kit_view_test.dart` are stabilized script-side while deeper bridge-generator follow-up is documented in `generator_issues.md`.
  - Complex script deep analysis (issue-index: 78, `animated_positioned_directional_test.dart`):
    - The warning originated from implicit `context` property access on a state object path that is not guaranteed to provide `BuildContext` in interpreted member lookup.
    - This reflects a recurring script-state coupling pattern where context-dependent values are retrieved indirectly from framework state instead of being passed explicitly.
    - Immediate mitigation replaced the scenario with deterministic explicit state descriptors; long-term script quality should enforce explicit context injection and avoid framework-private state/property assumptions.

batch: 16

- No non-immediate batch-16 script issues remained after immediate fixes.
- Immediate batch-16 script fixes were applied and validated for:
  - widgets/autocomplete_highlighted_option_test.dart
  - widgets/autofill_group_state_test.dart
  - widgets/automatic_keep_alive_client_mixin_test.dart
  - widgets/back_button_listener_test.dart
  - widgets/backdrop_group_test.dart
- Notes:
  - `automatic_keep_alive_client_mixin_test.dart` was a direct script-level layout-bounding stabilization (removing cascading infinite-size errors).
  - `back_button_listener_test.dart` is stabilized script-side while deeper generic-constructor factory follow-up is documented in `generator_issues.md`.
  - Complex script deep analysis (issue-index: 80, 81, 84):
    - These failures share the same state-context coupling pattern: script logic attempts to read framework-owned members (`widget`, `setState`) through object paths that are not guaranteed to expose `State` lifecycle members in interpreted execution.
    - The repeated pattern across autocomplete, autofill, and backdrop flows indicates a reusable script design risk rather than isolated logic mistakes.
    - Immediate mitigation moved each scenario to explicit deterministic data rendering; long-term script quality should enforce explicit callback/data injection patterns and avoid relying on implicit framework state-member lookup.

batch: 17

- No non-immediate batch-17 script issues remained after immediate fixes.
- Immediate batch-17 script fixes were applied and validated for:
  - widgets/border_tween_test.dart
  - widgets/box_scroll_view_test.dart
  - widgets/clip_r_superellipse_test.dart
  - widgets/constrained_layout_builder_test.dart
  - widgets/constraints_transform_box_test.dart
- Notes:
  - `border_tween_test.dart`, `clip_r_superellipse_test.dart`, `constrained_layout_builder_test.dart`, and `constraints_transform_box_test.dart` were direct script-level contract/layout/state-initialization stabilizations.
  - `box_scroll_view_test.dart` is stabilized script-side while deeper widget-coercion bridge follow-up is documented in `generator_issues.md`.

batch: 18

- No non-immediate batch-18 script issues remained after immediate fixes.
- Immediate batch-18 script fixes were applied and validated for:
  - widgets/context_action_test.dart
  - widgets/default_selection_style_test.dart
  - widgets/default_text_editing_shortcuts_test.dart
  - widgets/default_text_style_transition_test.dart
  - widgets/draggable_scrollable_actuator_test.dart
- Notes:
  - `default_text_style_transition_test.dart` was a direct script-level state-initialization stabilization.
  - `context_action_test.dart` and `default_text_editing_shortcuts_test.dart` are stabilized script-side while deeper typed-map coercion follow-up is documented in `generator_issues.md`.
  - `default_selection_style_test.dart` is stabilized script-side while deeper widget-coercion bridge follow-up is documented in `generator_issues.md`.
  - Complex script deep analysis (issue-index: 91, 94):
    - These scenarios repeatedly relied on implicit `widget`/state-member access across nested scene states, which is not guaranteed to resolve under interpreted object access semantics.
    - The repeated failures indicate a script architecture pattern where framework lifecycle members are accessed indirectly rather than by explicit constructor fields/callback wiring.
    - Immediate mitigation moved flows to explicit deterministic data rendering; long-term script quality should enforce explicit state/data injection and avoid framework-private/member lookup assumptions in deep demos.

batch: 19

- No non-immediate batch-19 script issues remained after immediate fixes.
- Immediate batch-19 script fixes were applied and validated for:
  - widgets/expansible_test.dart
  - widgets/flex_test.dart
  - widgets/fractional_translation_test.dart
  - widgets/hero_controller_scope_test.dart
  - widgets/hero_controller_test.dart
- Notes:
  - All five batch-19 failures belong to the same script-level state-context defect family (implicit `widget` property access on interpreted scene-state paths).
  - Complex script deep analysis (issue-index: 95, 96, 97, 98, 99):
    - The repeated undefined-property warnings across five independent demos indicate a common architecture pattern: scene logic depends on framework lifecycle members through indirect object paths.
    - Under interpreted execution, those paths do not guarantee `State.widget` availability, producing warning-only failures that can mask real behavioral regressions.
    - Immediate mitigation converted each demo to explicit deterministic state/data rendering; long-term script quality should enforce explicit field/callback wiring and prohibit implicit `widget` property lookup in deep-demo scene modules.

batch: 20

- No non-immediate batch-20 script issues remained after immediate fixes.
- Immediate batch-20 script fixes were applied and validated for:
  - widgets/icon_data_test.dart
  - widgets/icon_theme_data_test.dart
  - widgets/ignore_baseline_test.dart
  - widgets/image_icon_test.dart
  - widgets/img_element_platform_view_test.dart
- Notes:
  - `icon_data_test.dart`, `icon_theme_data_test.dart`, `ignore_baseline_test.dart`, and `img_element_platform_view_test.dart` were direct script-level state-context stabilizations by removing implicit `widget` member lookup paths.
  - `image_icon_test.dart` was a direct script-level state-initialization stabilization by removing the late-initialized async field access pattern (`_bundleFuture`) from the interpreted execution path.
  - Complex script deep analysis (issue-index: 100, 101, 102, 103, 104):
    - Four of the five failures are the same recurring scene-state architecture defect: indirect access to framework-owned lifecycle members (`State.widget`) through interpreted object paths that do not guarantee those members.
    - The remaining failure (`image_icon_test.dart`) is an ordering defect where a late variable was read before initialization under interpreted timing, indicating async/lifecycle setup coupling that is too brittle for harness execution.
    - Immediate mitigation converted all five demos to deterministic explicit-data summary flows; long-term script quality should enforce explicit configuration injection for scenes and a strict "initialize before read" rule for async state in deep-demo scripts.

batch: 21

- No non-immediate batch-21 script issues remained after immediate fixes.
- Immediate batch-21 script fixes were applied and validated for:
  - widgets/keep_alive_handle_test.dart
  - widgets/keyboard_listener_test.dart
  - widgets/layout_id_test.dart
  - widgets/live_text_input_status_test.dart
  - widgets/lock_state_test.dart
- Notes:
  - `keep_alive_handle_test.dart` was a direct script-level finite-constraints stabilization; unbounded flex/viewport composition was replaced by bounded list rendering to eliminate cascading `RenderBox was not laid out` failures.
  - `keyboard_listener_test.dart` and `layout_id_test.dart` were direct script-level state-context stabilizations by removing implicit `widget` member lookup paths.
  - `live_text_input_status_test.dart` and `lock_state_test.dart` were stabilized script-side with deterministic null-safe flows; deeper interpreter follow-up for nullable `withValues` receiver invocation is documented in `interpreter_issues.md`.
  - Complex script deep analysis (issue-index: 105, 106, 107):
    - These failures combine two recurring script architecture defects: unbounded layout composition in demo scaffolds and implicit lifecycle member (`widget`) lookups in scene-state modules.
    - Both defect classes are warning-heavy in harness execution and can hide behavior regressions because tests may still report pass unless explicit guards are present.
    - Immediate mitigation moved all three scripts to explicit, bounded, deterministic rendering paths; long-term script quality should enforce finite-layout helpers and explicit scene configuration injection as mandatory deep-demo patterns.

batch: 22

- No non-immediate batch-22 script issues remained after immediate fixes.
- Immediate batch-22 script fixes were applied and validated for:
  - widgets/logical_key_set_test.dart
  - widgets/lookup_boundary_test.dart
  - widgets/matrix_transition_test.dart
  - widgets/meta_data_test.dart
  - widgets/modal_barrier_test.dart
- Notes:
  - `logical_key_set_test.dart` was a direct script-level finite-constraints and semantics stabilization; unbounded layout chains were replaced with bounded list/container rendering to remove infinite-size and non-finite semantics rect failures.
  - `lookup_boundary_test.dart`, `matrix_transition_test.dart`, `meta_data_test.dart`, and `modal_barrier_test.dart` were direct script-level state-context stabilizations by removing implicit `widget` member lookup paths.
  - Complex script deep analysis (issue-index: 110, 111, 112, 113, 114):
    - Batch-22 combines two known deep-demo architecture defects: missing finite layout constraints in composition-heavy scenes and reliance on implicit framework lifecycle members (`State.widget`) on interpreted paths.
    - The layout defect (index 110) propagates across render and semantics layers, producing high-noise warning cascades while tests may still report pass; this makes regression detection fragile without explicit guardrails.
    - Immediate mitigation moved all five scripts to deterministic bounded flows; long-term script quality should enforce reusable finite-layout scaffolds and explicit scene configuration injection as baseline standards for deep-demo scripts.

batch: 23

- No non-immediate batch-23 script issues remained after immediate fixes.
- Immediate batch-23 script fixes were applied and validated for:
  - widgets/navigator_pop_handler_test.dart
  - widgets/nested_scroll_view_state_test.dart
  - widgets/nested_scroll_view_viewport_test.dart
  - widgets/next_focus_intent_test.dart
  - widgets/notifiable_element_mixin_test.dart
- Notes:
  - `navigator_pop_handler_test.dart` and `nested_scroll_view_viewport_test.dart` were direct script-level state-context stabilizations by removing implicit `widget` member lookup paths.
  - `notifiable_element_mixin_test.dart` was a direct script-level finite-constraints stabilization to eliminate repeated infinite-size layout diagnostics.
  - `nested_scroll_view_state_test.dart` and `next_focus_intent_test.dart` were stabilized script-side, while deeper bridge-generator follow-up (typed-list coercion and static intent typing) is documented in `generator_issues.md`.
  - Complex script deep analysis (issue-index: 115, 117, 119):
    - These issues continue the recurring deep-demo architecture risks: implicit framework lifecycle member access in scene states and missing finite layout constraints in composition-heavy sections.
    - Both classes generate warning-heavy outputs that can mask regressions because harness runs may still report pass unless explicit checks are enforced.
    - Immediate mitigation converted affected scripts to deterministic explicit-data and bounded-layout flows; long-term script quality should enforce explicit scene wiring and reusable finite-layout scaffolds as mandatory defaults.

batch: 24

- No non-immediate batch-24 script issues remained after immediate fixes.
- Immediate batch-24 script fixes were applied and validated for:
  - widgets/object_key_test.dart
  - widgets/orientation_builder_test.dart
  - widgets/overlay_child_location_test.dart
  - widgets/overlay_state_test.dart
- Notes:
  - `orientation_builder_test.dart` and `overlay_state_test.dart` were direct script-level state-context stabilizations by removing implicit `widget` member lookup paths.
  - `overlay_child_location_test.dart` was a direct script-level finite-constraints stabilization to eliminate the recorded horizontal overflow warning.
  - `object_key_test.dart` was stabilized script-side while deeper bridge default-constructor follow-up is documented in `generator_issues.md`.
  - Issue-index 124 (`setUpAll` in `test/hardly_relevant_classes_5_test.dart`) is informational harness output with no functional defect and no required code change.
  - Complex script deep analysis (issue-index: 121, 122, 123):
    - Batch-24 combines two recurring deep-demo script risks: implicit lifecycle member access (`widget`) in scene-state modules and tight-width layout composition that can overflow under constrained viewport widths.
    - Both defect classes can be warning-only in harness runs, so immediate script stabilization should remain paired with explicit warning-aware validation.
    - Immediate mitigation moved all affected scripts to deterministic explicit-data and bounded-layout flows; long-term script quality should enforce explicit scene wiring and finite-layout scaffolds as baseline defaults.

batch: 25

- No non-immediate batch-25 script issues remained after immediate fixes.
- Immediate batch-25 script fixes were applied and validated for:
  - widgets/raw_dialog_route_test.dart
  - widgets/raw_keyboard_listener_test.dart
  - widgets/raw_menu_overlay_info_test.dart
  - widgets/raw_radio_test.dart
  - widgets/redo_text_intent_test.dart
- Notes:
  - Batch-25 failures were bridge-dominated (constructor factory typing, symbol registration/default constructor support, widget coercion) rather than standalone script architecture defects.
  - Scripts were stabilized to deterministic harness-safe flows to unblock test execution while deeper bridge remediation is tracked in `generator_issues.md`.
  - Complex script deep analysis (issue-index: 125, 126, 127, 128, 129):
    - Script-level failures were secondary manifestations of bridge boundary contract gaps and not independent deep-demo state/layout design defects.
    - Immediate script mitigation is intentionally tactical; long-term correctness requires bridge-level hardening for generic constructors, symbol exposure, default constructor fallback, and interpreted-widget coercion.

batch: 26

- No non-immediate batch-26 script issues remained after immediate fixes.
- Immediate batch-26 script fixes were applied and validated for:
  - widgets/regular_window_controller_delegate_test.dart
  - widgets/regular_window_controller_linux_test.dart
  - widgets/regular_window_controller_mac_o_s_test.dart
  - widgets/regular_window_controller_test.dart
  - widgets/regular_window_controller_win32_test.dart
- Notes:
  - Batch-26 issues are bridge-dominated widget-coercion defects and not standalone script architecture defects.
  - Scripts were stabilized to deterministic native-widget flows to unblock execution, while deeper bridge coercion remediation is documented in `generator_issues.md`.
  - Complex script deep analysis (issue-index: 130, 131, 132, 133, 134):
    - All five failures share one hierarchy-level coercion gap (`RegularWindowController*` interpreted instance not normalized to `Widget`).
    - Script-level mitigation is tactical only; durable resolution should be delivered centrally in bridge coercion registration/normalization.

batch: 27

- One non-immediate batch-27 issue remained after immediate fixes and was routed for deep bridge analysis (issue-index: 139).
- Immediate batch-27 script fixes were applied and validated for:
  - widgets/regular_window_test.dart
  - widgets/relative_positioned_transition_test.dart
  - widgets/render_abstract_layout_builder_mixin_test.dart
  - widgets/render_nested_scroll_view_viewport_test.dart
- Routed non-immediate item:
  - widgets/render_object_to_widget_adapter_test.dart (issue-index: 139) was not modified because `immediate fix possible` is `no`; full deep analysis is documented in `generator_issues.md`.
- Notes:
  - `relative_positioned_transition_test.dart` was a direct script-level finite-constraint/overflow stabilization.
  - Other immediate fixes in this batch were tactical script stabilizations for bridge-coercion/log paths while durable remediation remains bridge-level.

batch: 28

- One non-immediate batch-28 issue remained after immediate fixes and was routed for deep bridge analysis (issue-index: 142).
- Immediate batch-28 script fixes were applied and validated for:
  - widgets/render_tap_region_surface_test.dart
  - widgets/render_tap_region_test.dart
  - widgets/render_two_dimensional_viewport_test.dart
  - widgets/render_web_image_test.dart
- Routed non-immediate item:
  - widgets/render_tree_root_element_test.dart (issue-index: 142) was not modified because `immediate fix possible` is `no`; full deep analysis is documented in `generator_issues.md`.
- Notes:
  - `render_tap_region_test.dart`, `render_two_dimensional_viewport_test.dart`, and `render_web_image_test.dart` were direct script-level state-context stabilizations removing recurring `_tabController` late-initialization paths.
  - `render_tap_region_surface_test.dart` was stabilized script-side while durable widget-coercion remediation remains bridge-level and is documented in `generator_issues.md`.
  - Complex script deep analysis (issue-index: 141, 143, 144):
    - Three scripts shared the same deep-visual template defect: late `_tabController` access before guaranteed initialization in interpreted execution.
    - This recurring pattern is architecture-level script coupling to lifecycle timing, not isolated per-script logic drift.
    - Immediate mitigation replaced affected flows with deterministic explicit-data rendering; long-term script quality should avoid template-level late lifecycle dependencies in interpreted demo paths.

batch: 29

- No non-immediate batch-29 script issues remained after immediate fixes.
- Immediate batch-29 script fixes were applied and validated for:
  - widgets/repeat_mode_test.dart
  - widgets/replace_text_intent_test.dart
  - widgets/request_focus_action_test.dart
  - widgets/request_focus_intent_test.dart
  - widgets/restorable_bool_n_test.dart
- Notes:
  - `repeat_mode_test.dart`, `request_focus_intent_test.dart`, and `restorable_bool_n_test.dart` were direct script-level state-context stabilizations removing the recurring `_tabController` late-initialization path.
  - `replace_text_intent_test.dart` and `request_focus_action_test.dart` were stabilized script-side while deeper bridge-widget-coercion follow-up is documented in `generator_issues.md`.
  - Complex script deep analysis (issue-index: 145, 148, 149):
    - Batch-29 continues the same deep-visual template defect seen in batch-28: lifecycle-dependent late `_tabController` usage without guaranteed initialization in interpreted execution.
    - The repeated pattern across three scripts indicates a reusable template architecture issue rather than isolated script logic mistakes.
    - Immediate mitigation replaced affected scripts with deterministic explicit-data flows; long-term script quality should enforce template rules that avoid late lifecycle fields for interpreted deep demos.

batch: 30

- No non-immediate batch-30 script issues remained after immediate fixes.
- Immediate batch-30 script fixes were applied and validated for:
  - widgets/restorable_date_time_n_test.dart
  - widgets/restorable_double_n_test.dart
  - widgets/restorable_int_n_test.dart
  - widgets/restorable_listenable_test.dart
- Routed non-immediate item:
  - widgets/restorable_enum_n_test.dart (issue-index: 152) was not modified because `immediate fix possible` is `no`; full deep analysis is documented in `generator_issues.md`.
- Notes:
  - All immediate batch-30 script fixes were direct script-level state-context stabilizations removing the recurring `_tabController` late-initialization path.
  - Complex script deep analysis (issue-index: 150, 151, 153, 154):
    - Batch-30 continues the same deep-visual template defect seen in batches 28-29: lifecycle-dependent late `_tabController` usage without guaranteed initialization in interpreted execution.
    - The repeated pattern across four scripts confirms a template-level architecture issue, not isolated per-script defects.
    - Immediate mitigation replaced affected scripts with deterministic explicit-data flows; long-term script quality should enforce template rules that avoid late lifecycle fields for interpreted deep demos.

batch: 31

- No non-immediate batch-31 script issues remained after immediate fixes.
- Immediate batch-31 script fixes were applied and validated for:
  - widgets/restorable_num_n_test.dart
  - widgets/restorable_num_test.dart
  - widgets/restorable_route_future_test.dart
  - widgets/restorable_string_n_test.dart
  - widgets/root_element_mixin_test.dart
- Notes:
  - All batch-31 issues were direct script-level state-context stabilizations removing the recurring `_tabController` late-initialization path.
  - Complex script deep analysis (issue-index: 155, 156, 157, 158, 159):
    - Batch-31 continues the same deep-visual template defect seen in batches 28-30: lifecycle-dependent late `_tabController` usage without guaranteed initialization in interpreted execution.
    - The repeated pattern across all five scripts confirms a template-level architecture issue rather than isolated per-script defects.
    - Immediate mitigation replaced affected scripts with deterministic explicit-data flows; long-term script quality should enforce template rules that avoid late lifecycle fields for interpreted deep demos.

batch: 32

- No non-immediate batch-32 script issues remained after immediate fixes.
- Immediate batch-32 script fixes were applied and validated for:
  - widgets/root_render_object_element_test.dart
  - widgets/route_information_reporting_type_test.dart
  - widgets/route_transition_record_test.dart
- Routed non-immediate items:
  - widgets/route_information_test.dart (issue-index: 162) was not modified because `immediate fix possible` is `no`; full deep analysis is documented in `generator_issues.md`.
  - widgets/route_pop_disposition_test.dart (issue-index: 163) was not modified because `immediate fix possible` is `no`; full deep analysis is documented in `generator_issues.md`.
- Notes:
  - All immediate batch-32 script fixes were direct script-level state-context stabilizations removing recurring late-initialization paths (`_tabs` variant and same template family as `_tabController`).
  - Complex script deep analysis (issue-index: 160, 161, 164):
    - Batch-32 continues the deep-visual template defect pattern from batches 28-31, with late lifecycle field access before guaranteed initialization.
    - The `_tabs` variant confirms the issue is template-architecture driven and not tied to one specific field name.
    - Immediate mitigation replaced affected scripts with deterministic explicit-data flows; long-term script quality should enforce template rules that avoid late lifecycle fields for interpreted deep demos.

batch: 33

- No non-immediate batch-33 script issues remained after immediate fixes.
- Immediate batch-33 script fixes were applied and validated for:
  - widgets/scroll_activity_delegate_test.dart
  - widgets/scroll_context_test.dart
  - widgets/scroll_deceleration_rate_test.dart
- Routed non-immediate items:
  - widgets/router_config_test.dart (issue-index: 165) was not modified because `immediate fix possible` is `no`; full deep analysis is documented in `generator_issues.md`.
  - widgets/scroll_activity_test.dart (issue-index: 167) was not modified because `immediate fix possible` is `no`; full deep analysis is documented in `generator_issues.md`.
- Notes:
  - All immediate batch-33 script fixes were direct script-level state-context stabilizations removing recurring late-initialization paths (`_tabs` variant).
  - Complex script deep analysis (issue-index: 166, 168, 169):
    - Batch-33 continues the late-init deep-visual template defect pattern seen in batches 28-32.
    - The repeated `_tabs` variant confirms the defect is template-architecture driven and independent of a single field identifier.
    - Immediate mitigation replaced affected scripts with deterministic explicit-data flows; long-term script quality should enforce template rules that avoid late lifecycle fields for interpreted deep demos.

batch: 34

- No non-immediate batch-34 script issues remained after immediate fixes.
- Immediate batch-34 script fixes were applied and validated for:
  - widgets/scroll_drag_controller_test.dart
  - widgets/scroll_end_notification_test.dart
  - widgets/scroll_hold_controller_test.dart
  - widgets/scroll_increment_details_test.dart
  - widgets/scroll_increment_type_test.dart
- Routed non-immediate items:
  - None.
- Notes:
  - All batch-34 issues were direct script-level state-context stabilizations removing the recurring `_tabs` late-initialization path.
  - Complex script deep analysis (issue-index: 170, 171, 172, 173, 174):
    - Batch-34 continues the late-init deep-visual template defect pattern seen in batches 28-33.
    - The repeated `_tabs` variant confirms the defect is template-architecture driven and independent of a single field identifier.
    - Immediate mitigation replaced affected scripts with deterministic explicit-data flows; long-term script quality should enforce template rules that avoid late lifecycle fields for interpreted deep demos.

batch: 35

- Immediate batch-35 script fixes were applied and validated for:
  - widgets/scroll_metrics_notification_test.dart
  - widgets/scroll_notification_observer_test.dart
  - widgets/scroll_position_with_single_context_test.dart
- Routed non-immediate items:
  - widgets/scroll_notification_observer_state_test.dart (issue-index: 176) was not modified because `immediate fix possible` is `no`; deep analysis below captures the recurring late-init template failure observed in targeted reruns.
  - widgets/scroll_position_alignment_policy_test.dart (issue-index: 178) was not modified because `immediate fix possible` is `no`; full bridge-coercion analysis is documented in `generator_issues.md`.
- Deep analysis (non-immediate script issue-index: 176):
  - Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/scroll_notification_observer_state_test.dart`
  - Symptom: targeted rerun reports `Undefined variable: _tabCtrl` with `LateInitializationError` (`frameworkErrors=1`).
  - Pattern: same lifecycle-dependent state-context defect family seen across batches 28-35 (`_tabController` -> `_tabs` -> `_tabCtrl` variable-name variants) where late fields are read before guaranteed initialization in interpreted execution.
  - Scope: although batch metadata classifies this index as non-immediate, the observed runtime signature is script-template-state driven rather than interpreter-core.
- Notes:
  - Batch-35 immediate scripts were stabilized via deterministic explicit-data flows to remove lifecycle-dependent late tab-controller fields.
  - Complex script deep-analysis pattern (issue-index: 175, 177, 179 immediate; 176 non-immediate):
    - The `_tabCtrl` variant is a naming variation of the same longstanding template defect family.
    - Continued prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 36

- Immediate batch-36 script fixes were applied and validated for:
  - widgets/scroll_start_notification_test.dart
  - widgets/scroll_to_document_boundary_intent_test.dart
  - widgets/scroll_update_notification_test.dart
  - widgets/scroll_view_test.dart
- Routed non-immediate items:
  - widgets/scroll_view_keyboard_dismiss_behavior_test.dart (issue-index: 183) was not modified because `immediate fix possible` is `no`; full bridge-coercion deep analysis is documented in `generator_issues.md`.
- Notes:
  - Immediate batch-36 fixes removed recurring `_tabCtrl` late-initialization paths by switching to deterministic explicit-data flows.
  - Complex script deep-analysis pattern (issue-index: 180, 181, 182, 184 immediate):
    - Batch-36 continues the lifecycle-dependent late-controller template defect family seen across batches 28-35.
    - The `_tabCtrl` variant remains a naming variation of the same architecture-level template issue.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 37

- Immediate batch-37 script fixes were applied and validated for:
  - widgets/scrollable_details_test.dart
  - widgets/scrollbar_painter_test.dart
  - widgets/select_all_text_intent_test.dart
- Routed non-immediate items:
  - widgets/scrollbar_orientation_test.dart (issue-index: 186) was not modified because `immediate fix possible` is `no`; full interpreter-level deep analysis is documented in `interpreter_issues.md`.
  - widgets/select_action_test.dart (issue-index: 188) was not modified because `immediate fix possible` is `no`; full bridge-generator deep analysis is documented in `generator_issues.md`.
- Notes:
  - Immediate batch-37 fixes removed recurring `_tabCtrl` late-initialization paths via deterministic explicit-data script flows.
  - Complex script deep-analysis pattern (issue-index: 185, 187, 189 immediate):
    - Batch-37 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-36.
    - The `_tabCtrl` variant remains a naming variation of the same architecture-level template issue.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 38

- No non-immediate batch-38 script issues remained after immediate fixes.
- Immediate batch-38 script fixes were applied and validated for:
  - widgets/select_intent_test.dart
  - widgets/selectable_region_state_test.dart
  - widgets/selection_container_delegate_test.dart
  - widgets/selection_details_test.dart
  - widgets/semantics_gesture_delegate_test.dart
- Routed non-immediate items:
  - None.
- Notes:
  - Immediate batch-38 fixes removed recurring `_tabCtrl` late-initialization paths via deterministic explicit-data script flows.
  - Complex script deep-analysis pattern (issue-index: 190, 191, 192, 193, 194 immediate):
    - Batch-38 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-37.
    - The `_tabCtrl` variant remains a naming variation of the same architecture-level template issue.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 39

- Immediate batch-39 script fixes were applied and validated for:
  - widgets/shortcut_activator_test.dart
  - widgets/shortcut_manager_test.dart
  - widgets/shortcut_map_property_test.dart
- Routed non-immediate items:
  - widgets/shortcut_registry_entry_test.dart (issue-index: 198) was not modified because `immediate fix possible` is `no`; full bridge-generator deep analysis is documented in `generator_issues.md`.
  - widgets/shortcut_serialization_test.dart (issue-index: 199) was not modified because `immediate fix possible` is `no`; full bridge-generator deep analysis is documented in `generator_issues.md`.
- Notes:
  - Batch-39 immediate fixes removed recurring late-initialization template defects (`_tabCtrl` and `_loggingManager`) by replacing lifecycle-dependent state templates with deterministic explicit-data script flows.
  - Complex script deep-analysis pattern (issue-index: 195, 196, 197 immediate):
    - Batch-39 extends the same architecture-level template defect family seen across prior batches, with `_loggingManager` as a new variable-name variant of uninitialized late state fields.
    - Long-term prevention requires template rules that avoid late lifecycle controller/manager fields in interpreted deep-demo scripts.

batch: 40

- Immediate batch-40 script fixes were applied and validated for:
  - widgets/size_changed_layout_notification_test.dart
  - widgets/sliver_animated_grid_state_test.dart
- Routed non-immediate items:
  - widgets/single_activator_test.dart (issue-index: 200) was not modified because `immediate fix possible` is `no`; full bridge-generator deep analysis is documented in `generator_issues.md`.
  - widgets/sliver_animated_list_state_test.dart (issue-index: 203) was not modified because `immediate fix possible` is `no`; full interpreter-level deep analysis is documented in `interpreter_issues.md`.
  - widgets/sliver_child_builder_delegate_test.dart (issue-index: 204) was not modified because `immediate fix possible` is `no`; full interpreter/bridge-level deep analysis is documented in `interpreter_issues.md`.
- Notes:
  - Immediate batch-40 fixes removed recurring `_tabs` late-initialization template defects by replacing lifecycle-dependent tab-controller scripts with deterministic explicit-data flows.
  - Non-immediate behavior note:
    - issue-index 204 currently reproduces as `Map.contains` bridge/member failure, which diverges from the original batch annotation (`setState` accessor). The rerun-observed failure is documented in interpreter deep analysis for durable remediation planning.

batch: 41

- No non-immediate batch-41 script issues remained after immediate fixes.
- Immediate batch-41 script fixes were applied and validated for:
  - widgets/sliver_child_delegate_test.dart
  - widgets/sliver_multi_box_adaptor_element_test.dart
  - widgets/sliver_multi_box_adaptor_widget_test.dart
  - widgets/sliver_reorderable_list_state_test.dart
  - widgets/slotted_container_render_object_mixin_test.dart
- Notes:
  - All batch-41 issues were direct script-level state-context stabilizations removing the recurring `_tabs` late-initialization path.
  - Complex script deep-analysis pattern (issue-index: 205, 206, 207, 208, 209):
    - Batch-41 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-40.
    - The `_tabs` variant remains a naming variation of the same architecture-level template issue.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 42

- No non-immediate batch-42 script issues remained after immediate fixes.
- Immediate batch-42 script fixes were applied and validated for:
  - widgets/slotted_multi_child_render_object_widget_mixin_test.dart
  - widgets/slotted_multi_child_render_object_widget_test.dart
  - widgets/slotted_render_object_element_test.dart
  - widgets/snapshot_mode_test.dart
  - widgets/standard_component_type_test.dart
- Notes:
  - All batch-42 issues were direct script-level state-context stabilizations removing the recurring `_tabs` late-initialization path.
  - Complex script deep-analysis pattern (issue-index: 210, 211, 212, 213, 214):
    - Batch-42 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-41.
    - The `_tabs` variant remains a naming variation of the same architecture-level template issue.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 43

- No non-immediate batch-43 script issues remained after immediate fixes.
- Immediate batch-43 script fixes were applied and validated for:
  - widgets/static_selection_container_delegate_test.dart
  - widgets/text_selection_gesture_detector_builder_delegate_test.dart
- Notes:
  - Both batch-43 immediate-fix issues were direct script-level state-context stabilizations removing the recurring `_tabs` late-initialization path.
  - Complex script deep-analysis pattern (issue-index: 215, 216):
    - Batch-43 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-42.
    - The `_tabs` variant remains a naming variation of the same architecture-level template issue.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.
  - Three additional batch-43 entries (issue-index: 217, 218, 219) were BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT failures; documented in `generator_issues.md`.

batch: 44

- No non-immediate batch-44 script issues remained after immediate fixes.
- Immediate batch-44 script fixes were applied and validated for:
  - widgets/tooltip_window_test.dart
  - widgets/transpose_characters_intent_test.dart
- Notes:
  - Both batch-44 immediate-fix issues were direct script-level state-context stabilizations removing the recurring `_tabController` late-initialization path.
  - Complex script deep-analysis pattern (issue-index: 222, 224):
    - Batch-44 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-43.
    - The `_tabController` variant is the original naming from batches 28-31, now recurring.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.
  - Two batch-44 entries (issue-index: 220, 221) were BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT failures; documented in `generator_issues.md`.
  - One batch-44 entry (issue-index: 223) was a combined BRIDGE-MISSING-STATE-WIDGET-ACCESSOR + BRIDGE-WIDGET-COERCION issue; documented in `generator_issues.md`.

batch: 45

- No non-immediate batch-45 script issues remained after immediate fixes.
- Immediate batch-45 script fixes were applied and validated for:
  - widgets/tree_sliver_state_mixin_test.dart
  - widgets/two_dimensional_child_builder_delegate_test.dart
  - widgets/two_dimensional_child_delegate_test.dart
- Notes:
  - All three batch-45 immediate-fix issues were direct script-level state-context stabilizations removing the recurring late-initialization path (two `_tabController`, one `_tabs`).
  - Complex script deep-analysis pattern (issue-index: 227, 228, 229):
    - Batch-45 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-44.
    - Mixed variable names (`_tabController` and `_tabs`) confirm a naming variation of the same architecture-level template issue.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.
  - Two batch-45 entries (issue-index: 225, 226) were BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT failures; documented in `generator_issues.md`.

batch: 46

- No non-immediate batch-46 script issues remained after immediate fixes.
- Immediate batch-46 script fixes were applied and validated for:
  - widgets/two_dimensional_child_list_delegate_test.dart
  - widgets/two_dimensional_child_manager_test.dart
  - widgets/two_dimensional_scrollable_state_test.dart
  - widgets/two_dimensional_viewport_parent_data_test.dart
  - widgets/undo_history_state_test.dart
- Notes:
  - All five batch-46 issues were direct script-level state-context stabilizations removing the recurring late-initialization path (four `_tabs`, one `_tabController`).
  - Complex script deep-analysis pattern (issue-index: 230, 231, 232, 233, 234):
    - Batch-46 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-45.
    - Mixed variable names (`_tabController` and `_tabs`) confirm a naming variation of the same architecture-level template issue.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 47

- No non-immediate batch-47 script issues remained after immediate fixes.
- Immediate batch-47 script fixes were applied and validated for:
  - widgets/undo_history_value_test.dart
  - widgets/undo_text_intent_test.dart
  - widgets/unfocus_disposition_test.dart
  - widgets/update_selection_intent_test.dart
  - widgets/user_scroll_notification_test.dart
- Notes:
  - All five batch-47 issues were direct script-level state-context stabilizations removing the recurring `_tabs` late-initialization path.
  - Complex script deep-analysis pattern (issue-index: 235, 236, 237, 238, 239):
    - Batch-47 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-46.
    - All five used the `_tabs` variant.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 48

- No non-immediate batch-48 script issues remained after immediate fixes.
- Immediate batch-48 script fixes were applied and validated for:
  - widgets/viewport_element_mixin_test.dart
  - widgets/viewport_notification_mixin_test.dart
  - widgets/void_callback_action_test.dart
  - widgets/void_callback_intent_test.dart
  - widgets/weak_map_test.dart
- Notes:
  - All five batch-48 issues were direct script-level state-context stabilizations removing the recurring `_tabs` late-initialization path.
  - Complex script deep-analysis pattern (issue-index: 240, 241, 242, 243, 244):
    - Batch-48 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-47.
    - All five used the `_tabs` variant.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 49

- No non-immediate batch-49 script issues remained after immediate fixes.
- Immediate batch-49 script fixes were applied and validated for:
  - widgets/web_browser_detection_test.dart
  - widgets/widget_inspector_service_extensions_test.dart
  - widgets/widget_inspector_service_test.dart
  - widgets/widget_order_traversal_policy_test.dart
  - widgets/widget_state_border_side_test.dart
- Notes:
  - All five batch-49 issues were direct script-level state-context stabilizations removing the recurring `_tabs` late-initialization path.
  - Complex script deep-analysis pattern (issue-index: 245, 246, 247, 248, 249):
    - Batch-49 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-48.
    - All five used the `_tabs` variant.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 50

- No non-immediate batch-50 script issues remained after immediate fixes.
- Immediate batch-50 script fixes were applied and validated for:
  - widgets/widget_state_color_test.dart
  - widgets/widget_state_mapper_test.dart
  - widgets/widget_state_mouse_cursor_test.dart
  - widgets/widget_state_outlined_border_test.dart
  - widgets/widget_state_property_all_test.dart
- Notes:
  - All five batch-50 issues were direct script-level state-context stabilizations removing the recurring `_tabs` late-initialization path.
  - Complex script deep-analysis pattern (issue-index: 250, 251, 252, 253, 254):
    - Batch-50 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-49.
    - All five used the `_tabs` variant.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 51

- No non-immediate batch-51 script issues remained after immediate fixes.
- Immediate batch-51 script fixes were applied and validated for:
  - widgets/widget_state_test.dart
  - widgets/widget_state_text_style_test.dart
  - widgets/widget_states_constraint_test.dart
- Notes:
  - Three of five batch-51 issues were direct script-level state-context stabilizations removing the recurring `_tabs` late-initialization path.
  - Two batch-51 entries (issue-index: 258, 259) were BRIDGE-GENERIC-TYPE-COERCION failures; documented in `generator_issues.md`.
  - Complex script deep-analysis pattern (issue-index: 255, 256, 257):
    - Batch-51 continues the same lifecycle-dependent late-controller template defect family seen across batches 28-50.
    - All three used the `_tabs` variant.
    - Long-term prevention requires template rules that avoid late lifecycle controller fields in interpreted deep-demo scripts.

batch: 52

- No immediate batch-52 script fixes were needed.
- All five batch-52 entries were bridge-level issues documented in `generator_issues.md`:
  - Four BRIDGE-GENERIC-TYPE-COERCION and one BRIDGE-WIDGET-COERCION.

batch: 53

- Immediate batch-53 script fixes were applied and validated for:
  - widgets/windowing_owner_win32_test.dart (issue-index 265, `_tabs` late-init)
  - widgets/sliverlist_test.dart (issue-index 268, GlobalKey lifecycle / duplicate key)
- Non-immediate batch-53 entries documented elsewhere:
  - issue-index 266: `(setUpAll)` — TEST-HARNESS-INFO, no action needed.
  - issue-index 267: `widgets/slidetransition_test.dart` — BRIDGE-MISSING-METHOD-DISPATCH, documented in `generator_issues.md`.
  - issue-index 269: `widgets/nestedscrollview_test.dart` — BRIDGE-WIDGET-LIST-COERCION, documented in `generator_issues.md`.

batch: 54

- Immediate batch-54 script fixes were applied and validated for:
  - material/refreshindicator_test.dart (issue-index 270, layout constraint cascade)
  - material/timeofday_test.dart (issue-index 271, layout constraint / transform)
- Non-immediate batch-54 entries:
  - issue-index 272-274: Three intentional interactive skips (showdialog, showbottomsheet, showmenu) — no fix needed.

batch: 55

- Immediate batch-55 script fixes were applied and validated for:
  - widgets/actions_test.dart (issue-index 277, `_dispatcher` late-init variant)
- Non-immediate batch-55 entries:
  - issue-index 275-276: Two intentional interactive skips (showdatepicker, showtimepicker) — no fix needed.
  - issue-index 278: `animation/tweensequence_test.dart` — BRIDGE-GENERIC-CONSTRUCTOR-NULL-HANDLING, documented in `generator_issues.md`.
  - issue-index 279: `services/codecs_test.dart` — BRIDGE-SDK-SYMBOL-RESOLUTION, documented in `generator_issues.md`.

batch: 56

- Immediate batch-56 script fixes were applied and validated for:
  - cupertino/cupertino_secondary_test.dart (issue-index 282, layout constraint)
  - cupertino/cupertino_form_scroll_test.dart (issue-index 283, layout constraint)
  - cupertino/cupertino_controls_advanced_test.dart (issue-index 284, layout constraint)
- Non-immediate batch-56 entries:
  - issue-index 280: `services/channels_test.dart` — BRIDGE-CALLBACK-TYPE-COERCION, documented in `generator_issues.md`.
  - issue-index 281: `(setUpAll)` — TEST-HARNESS-INFO, no action needed.

batch: 57

- Immediate batch-57 script fixes were applied and validated for:
  - cupertino/cupertino_sections_test.dart (issue-index 285, layout constraint)
  - cupertino/cupertino_tabbar_scaffold_test.dart (issue-index 286, layout constraint)
  - material/button_types_test.dart (issue-index 287, deprecated ButtonBar API)
  - material/toggle_segmented_test.dart (issue-index 288, deprecated ButtonBar API)
  - material/button_styles_misc_test.dart (issue-index 289, deprecated ButtonBarThemeData API)

batch: 58

- Immediate batch-58 script fixes were applied and validated for:
  - widgets/gesture_detector_adv_test.dart (issue-index 291, state-context `widget` undefined)
  - widgets/platform_menu_widgets_test.dart (issue-index 293, deprecated RawKeyboardListener API)
  - widgets/scroll_position_types_test.dart (issue-index 294, layout constraint unbounded flex)
- Non-immediate batch-58 entries:
  - issue-index 290: `semantics/semantics_config_test.dart` — BRIDGE-CALLBACK-TYPE-COERCION, documented in `generator_issues.md`.
  - issue-index 292: `widgets/layout_builder_adv_test.dart` — mixed BRIDGE-MISSING-METHOD-DISPATCH + layout, documented in `generator_issues.md`.

batch: 59

- Immediate batch-59 script fixes were applied and validated for:
  - widgets/scroll_controllers_types_test.dart (issue-index 295, layout constraint)
  - cupertino/cupertino_text_selection_controls_test.dart (issue-index 296, layout constraint)
  - dart_ui/ztmp_path_metrics_access_test.dart (issue-index 297, assertion precondition)
  - dart_ui/scene_test.dart (issue-index 298, math contract assertion)
  - dart_ui/semantics_action_event_test.dart (issue-index 299, overflow)

batch: 60

- Immediate batch-60 script fixes were applied and validated for:
  - dart_ui/string_attribute_test.dart (issue-index 300, overflow)
  - dart_ui/target_image_size_test.dart (issue-index 301, overflow)
  - gestures/vertical_multi_drag_gesture_recognizer_test.dart (issue-index 302, state-context `widget` undefined)
  - material/text_button_theme_data_test.dart (issue-index 304, null receiver)
- Non-immediate batch-60 entries:
  - issue-index 303: `material/scaffold_messenger_test.dart` — BRIDGE-WIDGET-COERCION, documented in `generator_issues.md`.

batch: 61

- Immediate batch-61 script fixes were applied and validated for:
  - material/text_selection_toolbar_test.dart (issue-index 305, layout constraint infinite-size)
  - material/text_selection_toolbar_text_button_test.dart (issue-index 306, layout constraint infinite-size)
  - painting/decoration_image_painter_test.dart (issue-index 307, constructor arg null→Text)
  - painting/image_info_test.dart (issue-index 308, overflow)
- Non-immediate batch-61 entries:
  - issue-index 309: `rendering/box_hit_test_result_test.dart` — BRIDGE-WIDGET-COERCION, documented in `generator_issues.md`.

batch: 62

- Immediate batch-62 script fixes were applied and validated for:
  - rendering/platform_view_layer_test.dart (issue-index 311, overflow)
- Non-immediate batch-62 entries:
  - issue-index 310: mixed BRIDGE-CALLBACK-TYPE-COERCION + overflow, documented in `generator_issues.md`.
  - issue-index 312-313: BRIDGE-WIDGET-COERCION (`Positioned.fill` child), documented in `generator_issues.md`.
  - issue-index 314: BRIDGE-MISSING-MEMBER (`String.characters`), documented in `generator_issues.md`.

batch: 63

- Immediate batch-63 script fixes were applied and validated for:
  - rendering/render_animated_opacity_test.dart (issue-index 315, state-context `_controller` late-init)
  - rendering/render_block_semantics_test.dart (issue-index 316, overflow)
- Non-immediate batch-63 entries:
  - issue-index 317: BRIDGE-WIDGET-COERCION, documented in `generator_issues.md`.
  - issue-index 318: BRIDGE-DELEGATE-TYPE-COERCION, documented in `generator_issues.md`.
  - issue-index 319: mixed BRIDGE-MIXIN-TARGET-COERCION + assertion, documented in `generator_issues.md`.

batch: 64

- Immediate batch-64 script fixes were applied and validated for:
  - rendering/render_editable_test.dart (issue-index 321, layout constraint negative min-height)
  - rendering/render_ignore_pointer_test.dart (issue-index 322, overflow)
  - rendering/render_shader_mask_test.dart (issue-index 324, index out of range)
- Non-immediate batch-64 entries:
  - issue-index 320: BRIDGE-DELEGATE-TYPE-COERCION, documented in `generator_issues.md`.
  - issue-index 323: BRIDGE-CLIPPER-TYPE-COERCION, documented in `generator_issues.md`.

batch: 65

- Immediate batch-65 script fixes were applied and validated for:
  - rendering/render_sliver_pinned_persistent_header_test.dart (issue-index 326, overflow)
  - rendering/sliver_hit_test_result_test.dart (issue-index 327, overflow multi-axis)
  - rendering/sliver_layout_dimensions_test.dart (issue-index 328, overflow)
- Non-immediate batch-65 entries:
  - issue-index 325: BRIDGE-SUPER-CONSTRUCTOR-RESOLUTION, documented in `generator_issues.md`.
  - issue-index 329: BRIDGE-STATIC-MEMBER-EXPOSURE, documented in `generator_issues.md`.

batch: 66

- Immediate batch-66 script fixes were applied and validated for:
  - widgets/animated_fractionally_sized_box_test.dart (issue-index 331, overflow)
- Non-immediate batch-66 entries:
  - issue-index 330, 332, 334: BRIDGE-MISSING-INSTANCE-METHOD (`whereType`), documented in `generator_issues.md`.
  - issue-index 333: BRIDGE-STATE-PROPERTY-EXPOSURE, documented in `generator_issues.md`.

batch: 67

- Immediate batch-67 script fixes were applied and validated for:
  - widgets/color_filtered_test.dart (issue-index 335, layout constraints unbounded flex)
  - widgets/default_asset_bundle_test.dart (issue-index 337, state-context `_oceanBundle` late-init)
  - widgets/dual_transition_builder_test.dart (issue-index 338, state-context multiple controllers late-init)
  - widgets/fade_in_image_test.dart (issue-index 339, state-context `_imagesFuture` late-init)
- Non-immediate batch-67 entries:
  - issue-index 336: BRIDGE-STATE-PROPERTY-EXPOSURE, documented in `generator_issues.md`.

batch: 68

- No immediate batch-68 script fixes were needed.
- All five batch-68 entries were bridge-level issues documented in `generator_issues.md`:
  - issue-index 340: BRIDGE-TYPE-CAST-FAILURE
  - issue-index 341: mixed BRIDGE-OPERATOR-COERCION + STATE-PROPERTY + WIDGET-COERCION
  - issue-index 342-344: BRIDGE-STATE-PROPERTY-EXPOSURE

batch: 69

- Immediate batch-69 script fixes were applied and validated for:
  - widgets/inherited_notifier_test.dart (issue-index 345, state-context `_hub` late-init)
- Non-immediate batch-69 entries:
  - issue-index 346-347: BRIDGE-WIDGET-COERCION (`Directionality.child`), documented in `generator_issues.md`.
  - issue-index 348-349: BRIDGE-STATE-PROPERTY-EXPOSURE, documented in `generator_issues.md`.

batch: 70

- No immediate batch-70 script fixes were needed.
- All five batch-70 entries were BRIDGE-STATE-PROPERTY-EXPOSURE issues (indices 350-354), documented in `generator_issues.md`.

batch: 71

- Immediate batch-71 script fixes were applied and validated for:
  - widgets/performance_overlay_test.dart (issue-index 357, state-init `_controller` + massive overflow)
- Non-immediate batch-71 entries:
  - issue-index 355: BRIDGE-STATE-PROPERTY-EXPOSURE, documented in `generator_issues.md`.
  - issue-index 356: mixed BRIDGE-MISSING-METHOD-DISPATCH + layout, documented in `generator_issues.md`.
  - issue-index 358: BRIDGE-MISSING-INSTANCE-METHOD (`whereType`), documented in `generator_issues.md`.
  - issue-index 359: BRIDGE-WIDGET-COERCION, documented in `generator_issues.md`.

batch: 72

- Immediate batch-72 script fixes were applied and validated for:
  - widgets/restorable_bool_test.dart (issue-index 361, `_tabController` late-init)
  - widgets/restorable_date_time_test.dart (issue-index 362, `_tabController` late-init)
  - widgets/restorable_double_test.dart (issue-index 363, `_tabController` late-init)
- Non-immediate batch-72 entries:
  - issue-index 360: BRIDGE-WIDGET-COERCION (`Center.child`), documented in `generator_issues.md`.
  - issue-index 364: BRIDGE-WIDGET-COERCION (restorable enum), documented in `generator_issues.md`.

batch: 73

- Immediate batch-73 script fixes were applied and validated for:
  - widgets/restorable_int_test.dart (issue-index 365, `_tabController` late-init)
  - widgets/restorable_property_test.dart (issue-index 366, `_tabController` late-init)
  - widgets/restorable_string_test.dart (issue-index 367, `_tabController` late-init)
  - widgets/restorable_value_test.dart (issue-index 369, `_tabController` late-init)
- Non-immediate batch-73 entries:
  - issue-index 368: BRIDGE-WIDGET-COERCION (restorable text editing), documented in `generator_issues.md`.

batch: 74

- Immediate batch-74 script fixes were applied and validated for:
  - widgets/restoration_mixin_test.dart (issue-index 370, restoration lifecycle registration order)
  - widgets/root_element_test.dart (issue-index 371, `_tabController` late-init)
  - widgets/scroll_action_test.dart (issue-index 373, `_tabs` late-init)
  - widgets/scroll_intent_test.dart (issue-index 374, `_tabs` late-init)
- Non-immediate batch-74 entries:
  - issue-index 372: BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT (`_AttachStep`), documented in `generator_issues.md`.

batch: 75

- Immediate batch-75 script fixes were applied and validated for:
  - widgets/single_ticker_provider_state_mixin_test.dart (issue-index 378, `_controller` + layout)
  - widgets/spell_check_configuration_test.dart (issue-index 379, `_tabs` late-init)
- Non-immediate batch-75 entries:
  - issue-index 375: BRIDGE-MISSING-INSTANCE-METHOD (`whereType`), documented in `generator_issues.md`.
  - issue-index 376-377: BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT, documented in `generator_issues.md`.

batch: 76

- Immediate batch-76 script fixes were applied and validated for:
  - widgets/text_magnifier_configuration_test.dart (issue-index 382, `_tabs` late-init)
  - widgets/text_selection_controls_test.dart (issue-index 383, `_tabs` late-init)
  - widgets/undo_history_controller_test.dart (issue-index 384, `_tabs` late-init)
- Non-immediate batch-76 entries:
  - issue-index 380-381: BRIDGE-STATE-PROPERTY-EXPOSURE, documented in `generator_issues.md`.

batch: 77

- Immediate batch-77 script fixes were applied and validated for:
  - widgets/widget_inspector_test.dart (issue-index 385, `_tabs` late-init)
  - widgets/widget_test.dart (issue-index 386, `_tabs` late-init)
  - widgets/widgets_binding_observer_test.dart (issue-index 387, `_tabs` late-init)
  - widgets/widgets_binding_test.dart (issue-index 388, `_tabs` late-init)
- Notes: Batch 77 is the FINAL batch. All 389 issues (indices 0-388) have been processed.
