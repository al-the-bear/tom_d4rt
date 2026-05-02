# Suspicious Tests

Test scripts under `tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/` that contain at least one of the words `harness`, `intentionally`, or `ui output` (case-insensitive). These are flagged as suspicious because they may rely on test-harness scaffolding, intentionally bypass behaviour, or assert against UI-output dumps rather than real widget state — so a green pass does not necessarily prove the script is exercising what its name suggests.

**Total flagged scripts:** 259

Each entry has three tracking checkboxes:

- `checked` — the script has been inspected for suspicious patterns
- `is ok` — inspection concluded the script is fine as-is
- `fixed` — the script (or its harness) was modified to remove the suspicious pattern

---

## Batch 1

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/cupertino/cupertino_desktop_text_selection_controls_test.dart` — only 105 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/cupertino/cupertino_focus_halo_test.dart` — only 120 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/cupertino/cupertino_text_selection_handle_controls_test.dart` — only 140 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/cupertino/form_test.dart` — only 319 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/cupertino/inherited_cupertino_theme_test.dart` — only 138 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/cupertino/overlay_visibility_mode_test.dart` — 631 lines, but enum used only for `print()` and static label rows; never wired into a real `CupertinoTextField` to demonstrate visual behaviour
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/cupertino/textfield_test.dart` — 563 lines; constructs `CupertinoTextField` instances in locals to read properties, but `build()` returns a `CupertinoApp` whose body is just a `Text` summary saying "harness preview uses a stable non-editable summary surface" — the fields are never displayed
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/dart_ui/path_metrics_test.dart`
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/dart_ui/system_color_palette_test.dart` — 859 lines, but `build()` unconditionally takes the "fallback" branch ("SystemColor API unsupported in this runtime; rendering fallback summary."); the `_buildPalettePreview` / `_buildW3CSystemColorsCard` helpers are defined but never invoked, so the live `ui.SystemColorPalette` is never displayed
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/foundation/target_platform_test.dart` — only 59 lines (<400)

## Batch 2

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/bottom_navigation_bar_type_test.dart` — only 51 lines (<400); self-described "Harness-safe summary demo"; renders just one `BottomNavigationBar` with `.fixed`, doesn't show the visual difference between the enum values
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/button_bar_layout_behavior_test.dart` — only 43 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/button_bar_theme_test.dart` — only 30 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/button_text_theme_test.dart` — only 34 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/collapse_mode_test.dart` — only 34 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/drawer_controller_state_test.dart` — only 34 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/dropdown_menu_close_behavior_test.dart` — only 42 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/end_drawer_button_test.dart` — only 38 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/gapped_range_slider_track_shape_test.dart` — only 49 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/gapped_slider_track_shape_test.dart` — only 39 lines (<400)

## Batch 3

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/hour_format_test.dart` — only 38 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/list_tile_title_alignment_test.dart` — only 37 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/material_banner_closed_reason_test.dart` — only 41 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/menu_accelerator_callback_binding_test.dart` — only 40 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/navigation_destination_label_behavior_test.dart` — only 50 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/navigation_drawer_theme_test.dart` — only 45 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/navigation_rail_label_type_test.dart` — only 57 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/paginated_data_table_state_test.dart` — only 52 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/popup_menu_position_test.dart` — only 25 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/progress_indicator_test.dart` — only 33 lines (<400)

## Batch 4

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/material/range_slider_track_shape_test.dart`
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/refresh_progress_indicator_test.dart` — only 31 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/tabs_test.dart` — only 56 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/themadata_test.dart` — only 56 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/theme_extension_test.dart` — only 34 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/theme_mode_test.dart` — only 36 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/thumb_test.dart` — only 35 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/time_of_day_format_test.dart` — only 29 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/time_picker_entry_mode_test.dart` — only 33 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/toggle_buttons_theme_data_test.dart` — only 38 lines (<400)

## Batch 5

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/toggle_buttons_theme_test.dart` — only 27 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/material/tooltip_state_test.dart` — only 19 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/painting/axis_direction_test.dart` — only 29 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/painting/axis_test.dart` — only 43 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/proxies/customclipper_proxy_test.dart` — only 68 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/proxies/custompaint_proxy_test.dart` — only 68 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/proxies/flowdelegate_proxy_test.dart` — only 68 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/proxies/multichildlayout_proxy_test.dart` — only 68 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/proxies/singlechildlayout_proxy_test.dart` — only 68 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/const_test.dart` — 1098 lines and the visual demo is real (9 sections of real widgets in a `SingleChildScrollView`), but the filename does not correspond to any class — `const` is a Dart keyword, not a class — so criterion 1 ("really using the classes the test file name describes") cannot be satisfied; this file is misfiled in the rendering test corpus

## Batch 6

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/floating_header_snap_configuration_test.dart` — only 26 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/hit_test_behavior_test.dart` — only 29 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/over_scroll_header_stretch_configuration_test.dart` — only 35 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/pipeline_manifold_test.dart` — only 26 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/placeholder_span_index_semantics_tag_test.dart` — only 26 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/platform_view_hit_test_behavior_test.dart`
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/platform_view_render_box_test.dart` — only 26 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/relayout_when_system_fonts_change_mixin_test.dart`
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_abstract_viewport_test.dart` — only 43 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_aligning_shifted_box_test.dart`

## Batch 7

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_android_view_test.dart` — only 30 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_animated_opacity_mixin_test.dart` — only 26 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_animated_size_state_test.dart` — only 30 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_animated_size_test.dart`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_annotated_region_test.dart`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_app_kit_view_test.dart`
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_clip_r_superellipse_test.dart` — only 26 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_constrained_overflow_box_test.dart`
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_editable_painter_test.dart` — only 30 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_exclude_semantics_test.dart`

## Batch 8

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_fractionally_sized_overflow_box_test.dart`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_indexed_stack_test.dart`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_mouse_region_test.dart`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_shrink_wrapping_viewport_test.dart`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_sized_overflow_box_test.dart`
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_sliver_box_child_manager_test.dart` — only 33 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_sliver_constrained_cross_axis_test.dart`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_sliver_cross_axis_group_test.dart`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_sliver_fill_remaining_and_overscroll_test.dart`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_sliver_fill_remaining_with_scrollable_test.dart`

## Batch 9

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_sliver_floating_pinned_persistent_header_test.dart` — only 34 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/render_ui_kit_view_test.dart` — only 47 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/selected_content_range_test.dart` — 1669 lines; data-only class never directly instantiated, but exercised indirectly through real `SelectionArea` widgets (lines 834, 1317, 1395, 1433) which create `SelectedContentRange` internally and surface its effect visually
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/sliver_grid_geometry_test.dart` — 1972 lines; constructs `SliverGridGeometry` live in `build()` (lines 256, 269), prints derived values, drives multi-section visual demos with realistic grid layouts
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/rendering/sliver_paint_order_test.dart` — 1059 lines, but every `SliverPaintOrder.*` reference lives inside string code snippets (lines 415, 506, 778, 863); the enum is never used as live code. Visual overlap is faked with abstract `Stack`+`Positioned` scenario boxes rather than actual slivers exercising paint order, so the class itself is never demonstrated
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/repro_fa5/canary_must_fail.dart` — only 23 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/repro_fa5/inherited_widget_exact_type.dart` — only 77 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/repro_fa6/canary_must_fail.dart` — only 23 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/retest/material/theme_extension_test.dart` — 1390 lines; defines four real `ThemeExtension` subclasses (`BrandTokens`, `StatusTokens`, `ScaleTokens`, `BadgeTokens`), registers them in `Theme.extensions` (line 561), drives a themed UI that visibly consumes the tokens
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/retest/rendering/render_android_view_test.dart` — 1617 lines; uses live `AndroidView` (line 788) which produces `RenderAndroidView` on Android, plus a clearly-labelled simulator fallback panel for non-Android, with comprehensive controls and visual scenarios

## Batch 10

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/retest/widgets/android_view_surface_test.dart` — 1864 lines; live `AndroidViewSurface(...)` (line 1671) wired with a real `AndroidViewController` and a simulation-fallback path for non-Android platforms
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/retest/widgets/app_kit_view_test.dart` — 2067 lines; live `AppKitView(...)` rendered at line 1815
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/retest/widgets/back_button_listener_test.dart` — 2055 lines; multiple live `BackButtonListener(...)` instances (lines 666, 943, 963) including nested zones to demonstrate callback ordering
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/retest/widgets/default_selection_style_test.dart` — 1176 lines; live `DefaultSelectionStyle(...)` widgets (lines 473, 483, 493, 602) plus `.merge(...)` and `.of(context)` calls driving real selection-style themed UI
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/retest/widgets/default_text_editing_shortcuts_test.dart` — 1108 lines; live `DefaultTextEditingShortcuts(...)` wrappers (lines 517, 586, 702, 819) wrapping real `TextField` widgets that exercise the platform shortcut map
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/semantics/semantics_handle_test.dart` — 2310 lines, but every `SemanticsHandle` / `ensureSemantics()` reference is inside string code-snippets or explanatory text; the class is never instantiated, `SemanticsBinding.instance.ensureSemantics()` is never called, and no `Semantics(...)` widgets are present, so the class is neither used directly nor exercised indirectly
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/services/message_codec_test.dart` — only 41 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/services/method_codec_test.dart` — only 35 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/services/raw_key_up_event_test.dart` — only 38 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/services/smart_quotes_type_test.dart` — 952 lines, but `SmartQuotesType.*` is only referenced in descriptive text and tag chips; no `TextField` or `EditableText` is rendered anywhere, and no `smartQuotesType:` parameter is ever set, so the enum's visual effect (curly-quote substitution) is never demonstrated

## Batch 11

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/services/spell_check_service_test.dart` — 960 lines, but `SpellCheckService` only appears in descriptive text and `dataRow` chips; no class extends/implements it, no `TextField` is rendered, and `spellCheckConfiguration:` is never set, so the service's behavior is never exercised
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/abstract_layout_builder_test.dart` — 2076 lines; the abstract pattern is exercised through multiple live concrete builders (`LayoutBuilder` at lines 443/734/1237/1252/1259/1510 and `SliverLayoutBuilder` at line 1021) driving real constraint-aware rendering
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/action_listener_test.dart` — only 30 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/align_transition_test.dart` — only 37 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/android_overscroll_indicator_test.dart` — 1717 lines; the `AndroidOverscrollIndicator` enum is consumed live (line 164) to swap between real `StretchingOverscrollIndicator` and `GlowingOverscrollIndicator` widgets, demonstrating the visual difference
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/android_view_surface_test.dart` — only 35 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/android_view_test.dart` — 1886 lines; live `AndroidView(...)` at line 1715 in a real platform-view host setup
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/animated_positioned_directional_test.dart` — only 30 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/app_kit_view_test.dart` — only 35 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/autocomplete_highlighted_option_test.dart` — only 32 lines (<400)

## Batch 12

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/autofill_group_state_test.dart` — only 26 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/automatic_keep_alive_client_mixin_test.dart` — only 33 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/back_button_listener_test.dart` — only 32 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/backdrop_group_test.dart` — only 30 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/border_tween_test.dart` — only 40 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/box_scroll_view_test.dart` — only 33 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/center_test.dart` — 1831 lines; multiple live `Center(...)` widgets across many sections demonstrating real centering behavior in varied parents
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/checked_mode_banner_test.dart` — 2013 lines; live `CheckedModeBanner(child: ...)` (lines 1160, 1167 invoked from line 629 via `_wrapMaybeBanner`) plus a live raw `Banner(...)` (line 754) for side-by-side comparison
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/clip_r_superellipse_test.dart` — only 37 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/constrained_layout_builder_test.dart` — only 33 lines (<400)

## Batch 13

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/constraints_transform_box_test.dart` — only 36 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/context_action_test.dart` — only 30 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/default_selection_style_test.dart` — only 32 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/default_text_editing_shortcuts_test.dart` — only 30 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/default_text_height_behavior_test.dart` — 1024 lines; live `DefaultTextHeightBehavior(...)` (line 571) wrapping content, plus multiple live `TextHeightBehavior(...)` constructions (lines 438, 449, 483, 494, 528, 539, 690) feeding real text rendering
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/default_text_style_transition_test.dart` — only 38 lines (<400)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/dismiss_intent_test.dart` — 1297 lines, but `DismissIntent()` only appears inside string code snippets; no live `Shortcuts`/`Actions` widget binds it, so the intent is never dispatched in the running UI
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/do_nothing_action_test.dart` — 1189 lines, but every `DoNothingAction()` reference is inside string snippets/comments; no live `Actions`/`Shortcuts` widget registers it, so the action is never invoked at runtime
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/do_nothing_and_stop_propagation_intent_test.dart` — 1260 lines, but every `DoNothingAndStopPropagationIntent` reference is inside string snippets/comments; no live `Shortcuts`/`Actions` wiring exercises the intent
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/drag_target_details_test.dart` — 1022 lines, but every `DragTarget<T>(...)` reference is inside string code snippets; no live `DragTarget` widget is rendered, so `DragTargetDetails` is never produced or inspected in the running UI

## Batch 14

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/fade_in_image_test.dart` — 2432 lines; multiple live `FadeInImage(...)` widgets (lines 742, 753, 765, 777) rendering real placeholder→target transitions
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/hero_controller_scope_test.dart` — 2456 lines, but every `HeroControllerScope(...)` reference lives inside `_CodeBlock` string literals; no live `HeroControllerScope` widget, no live `Hero` or `Navigator.push` to demonstrate the visual impact
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/html_element_view_test.dart` — 1589 lines; live `HtmlElementView.fromTagName(...)` at line 1328 instantiates the web platform-view widget
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/icon_data_test.dart` — 2566 lines; live `IconData(...)` constructions (lines 1345, 1461, 2367) feed real `Icon(...)` widgets that render the glyphs on screen
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/icon_theme_data_test.dart` — 2449 lines; live `IconTheme(data: const IconThemeData(...))` (lines 333, 431) wrapping real `Icon(...)` widgets to demonstrate themed colors/sizes
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/ignore_baseline_test.dart` — 2876 lines; live `IgnoreBaseline(child: ...)` widgets (lines 428, 986, 1106) wrapping real icons to show the baseline-skip effect
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/image_filtered_test.dart` — 2489 lines; multiple live `ImageFiltered(...)` widgets (lines 508, 785, 986, 1240, 1458) with real `imageFilter` arguments demonstrating blur and matrix filters
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/image_icon_test.dart` — 1888 lines; live `ImageIcon(...)` widgets (lines 220, 411) rendering real `MemoryImage` providers as themed icons
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/img_element_platform_view_test.dart` — 3510 lines, but every `ImgElementPlatformView(...)` reference is inside string snippets (lines 969, 2687, 2707); the platform-view widget is never instantiated, so the class itself is never exercised
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/i_o_s_system_context_menu_item_copy_test.dart` — 664 lines, but every `IOSSystemContextMenuItemCopy` and `contextMenuBuilder:` reference lives inside string code-snippets; no live `TextField`/`EditableText` is rendered with a context menu builder, so the item is never produced or shown

## Batch 15

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/i_o_s_system_context_menu_item_cut_test.dart` — 663 lines, but every `IOSSystemContextMenuItemCut` and `contextMenuBuilder:` reference lives inside string snippets; no live `TextField`/`EditableText` is rendered with a context menu builder, so the item is never produced or shown
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/keep_alive_handle_test.dart` — 3082 lines, but every `KeepAliveHandle()` reference lives inside string snippets; no class actually mixes in `AutomaticKeepAliveClientMixin`, no `KeepAliveNotification` is dispatched, and the live `TabBarView` (line 93) does not exercise keep-alive state preservation, so the class's visual impact is never demonstrated
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/localizations_resolver_test.dart` — 1101 lines; live `Localizations.of<MaterialLocalizations>(context, ...)` and `Localizations.of<WidgetsLocalizations>(context, ...)` calls (lines 213, 214) read real resolved localizations and surface them in the UI
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/lookup_boundary_test.dart` — 2338 lines; live `LookupBoundary(child: ...)` widgets (lines 462, 1099, 1298) plus a live `LookupBoundary.dependOnInheritedWidgetOfExactType<MediaQuery>(...)` call (line 506) demonstrating real lookup-blocking behavior
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/modal_barrier_test.dart` — 2149 lines; multiple live `ModalBarrier(...)` widgets (lines 309, 443, 665) rendering real dismissible barriers
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/navigation_toolbar_test.dart` — 1719 lines; multiple live `NavigationToolbar(...)` widgets (lines 510, 784, 944, 1109, 1136) laying out real leading/middle/trailing slots
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/navigatorstate_test.dart` — only 45 lines (<400)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/orientation_builder_test.dart` — 2648 lines; live `OrientationBuilder(...)` widgets (lines 438, 603, 804) building real responsive layouts based on orientation
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/overflow_bar_test.dart` — 1894 lines; multiple live `OverflowBar(...)` widgets (lines 529, 806, 1036, 1263, 1536) demonstrating horizontal/vertical overflow behavior
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/overflow_box_test.dart` — 2017 lines; multiple live `OverflowBox(...)` widgets (lines 521, 854, 1091, 1253, 1609) demonstrating real over-constrained child layouts

## Batch 16

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/page_storage_bucket_test.dart` — 2285 lines; live `PageStorageBucket()` instantiations (lines 340, 482, 671) plus live `writeState()`/`readState()` calls (lines 908–918) persisting and restoring real form values
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/page_storage_test.dart` — 2252 lines; live `PageStorage(bucket:..., child:...)` widgets (lines 506, 781) plus live `PageStorage.of(...).writeState`/`readState` calls (lines 791, 799)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/performance_overlay_test.dart` — 2425 lines; multiple live `PerformanceOverlay(...)` widgets (lines 324, 1094, 1563) rendering real overlay strips with configurable `optionsMask`
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/regular_window_controller_mac_o_s_test.dart` — 3172 lines, but every `RegularWindowControllerMacOS` reference lives inside `_CodeSnippet(code: '''...''')` triple-quoted strings; the controller is never instantiated, so the class behavior is never exercised
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/regular_window_controller_test.dart` — 3039 lines, but every `RegularWindowController(...)` reference lives inside string code-snippets (e.g. lines 466, 2391); the controller is never instantiated live, so its window operations are never exercised
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/regular_window_test.dart` — 3015 lines, but every `RegularWindow(...)` reference (lines 718, 740, 1477, 2194, 2219, 2225) lives inside `_CodeBlock`/`_CodeSnippet` triple-quoted strings; no live `RegularWindow` widget is rendered
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/render_abstract_layout_builder_mixin_test.dart` — 2219 lines; the abstract mixin is exercised through multiple live concrete consumers — `LayoutBuilder(...)` (lines 834, 975, 1619, 1661, 1710) and `SliverLayoutBuilder(...)` (line 1097) — driving real constraint-aware rendering
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/render_nested_scroll_view_viewport_test.dart` — 2387 lines; live `NestedScrollView(...)` at line 351 producing the real `RenderNestedScrollViewViewport` render object that the file documents
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/render_tap_region_surface_test.dart` — 1967 lines; live `TapRegionSurface(child: ...)` at line 297 produces the real `RenderTapRegionSurface` render object
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/replace_text_intent_test.dart` — 2534 lines; live `TextField(...)` widgets (lines 518, 685, 1417) plus a live `Actions.invoke(...)` dispatch (line 1438) actually firing `ReplaceTextIntent` against the editing controller

## Batch 17

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/request_focus_action_test.dart` — 2454 lines; live `Actions(actions: {RequestFocusIntent: RequestFocusAction()})` widgets (lines 392, 1484) plus a live `Shortcuts(...)`+`Actions(...)` pair (lines 639–643) wiring real focus dispatching
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_bool_n_test.dart` — 2444 lines; live `RestorableBoolN(null)` instance (line 4) plus a `State` mixing in `RestorationMixin` and registering it via `registerForRestoration`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_bool_test.dart` — 1576 lines; live `State with RestorationMixin` (line 88) owns multiple `RestorableBool(...)` fields (lines 97, 107–110) registered for real restoration
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_date_time_test.dart` — 1534 lines; live `State with RestorationMixin` (line 166) owns multiple live `RestorableDateTime(...)` fields (lines 177, 181, 185)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_double_n_test.dart` — 1977 lines; live `State with RestorationMixin` (line 57) owns multiple live `RestorableDoubleN(...)` fields (lines 64, 67, 72–76)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_double_test.dart` — 1619 lines; live `State with RestorationMixin` (line 73) owns multiple live `RestorableDouble(...)` fields (lines 78, 82, 89)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_int_test.dart` — 1446 lines; live `State with RestorationMixin` (line 57) owns multiple live `RestorableInt(...)` fields (lines 61–65)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_listenable_test.dart` — 1232 lines; multiple live `RestorableTextEditingController()` instances (lines 124, 126, ...) — the canonical concrete subclass of the abstract `RestorableListenable<T>` — registered through `RestorationMixin`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_num_n_test.dart` — 1734 lines; live `State with RestorationMixin` (line 208) owns a live `RestorableNumN<num?>(...)` field (line 213) alongside sibling restorables, all registered for restoration
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_num_test.dart` — 1637 lines; live `State with RestorationMixin` (line 194) owns a live `RestorableNum<num>(1)` field (line 199) registered for restoration

## Batch 18

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_property_test.dart` — 1334 lines; two live concrete subclasses `class _RestorableColor extends RestorableProperty<Color>` (line 62) and `class _RestorableStringList extends RestorableProperty<List<String>>` (line 128) wired into a `with RestorationMixin` State (line 232) via `registerForRestoration` (lines 277–281)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_route_future_test.dart` — 2030 lines; live `RestorableRouteFuture<String>(...)` instances (lines 136, 146, 156) registered through `with RestorationMixin` State (line 115)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_string_n_test.dart` — 1391 lines; live `with RestorationMixin` State (line 76) owns multiple `RestorableStringN(null)` fields (lines 86–89) registered for restoration
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restorable_value_test.dart` — 1394 lines; live concrete subclasses `class _RestorableDuration extends RestorableValue<Duration>` (line 129) and `class _RestorableOffset extends RestorableValue<Offset>` (line 164) used as fields and registered for restoration
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/restoration_mixin_test.dart` — 1687 lines; live `with RestorationMixin<BoardGameSessionDemo>` State (line 111) with multiple `registerForRestoration` calls (lines 147–153) covering the full mixin lifecycle
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/root_element_mixin_test.dart` — 1408 lines; the abstract `RootElementMixin` is exercised indirectly through live `WidgetsBinding.instance.rootElement` access (line 130) — the standard Flutter way to reach the mixin's public surface
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/root_element_test.dart` — 1448 lines; live `WidgetsBinding.instance.rootElement` access (lines 326, 398) demonstrating the framework-internal `RootElement` indirectly (only public way to obtain one)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/root_render_object_element_test.dart` — 1714 lines; live `WidgetsBinding.instance.rootElement` access (line 134) — the framework-internal `RootRenderObjectElement` is reached the same way as the other Root* family members
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/route_information_reporting_type_test.dart` — 1958 lines; live enum usage `RouteInformationReportingType.navigate` (line 168) and `RouteInformationReportingType _mode = ...` fields driving the demo state (lines 177, 201, 238, 245)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/route_transition_record_test.dart` — 1925 lines; the file explicitly bypasses the real `RouteTransitionRecord` (it is abstract) and demos a hand-rolled `_FakeRouteTransitionRecord` instead — every reference to the real class lives only in comments or in the `_buildCustomDelegateSnippet()` triple-quoted string (line 1808). Fails criterion 1 (does not really use the class the file name describes)

## Batch 19

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_action_test.dart` — 1864 lines; live `class _LoggingScrollAction extends ScrollAction` (line 1816) wired into an `Actions` widget mapping `ScrollIntent` → `_LoggingScrollAction(...)` (lines 444, 859)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scrollbar_painter_test.dart` — 2350 lines; multiple live `ScrollbarPainter(...)` instances (lines 297, 479, 486, 494, ...) driving real `CustomPaint`s and a real ScrollController-driven ListView
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_context_test.dart` — 2045 lines; `ScrollContext` is the abstract interface `ScrollableState` implements (cannot construct directly) — demoed indirectly through multiple live `ScrollController()` + `.position` accesses (lines 465, 484, 793–795, ...) on real Scrollables
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_controllers_types_test.dart` — 2285 lines; live `ScrollController()` (line 381), `TrackingScrollController()` (line 615), and `PrimaryScrollController(...)` (line 920) all driving real scroll views
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_deceleration_rate_test.dart` — 2375 lines; live `ScrollDecelerationRate.normal` (line 512) and `ScrollDecelerationRate.fast` (line 523) fed into `BouncingScrollPhysics(decelerationRate: ...)` driving side-by-side scrollables
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_drag_controller_test.dart` — 2600 lines; `ScrollDragController` is package-private (cannot construct directly) — demoed indirectly via a real Scrollable wrapped in a live `NotificationListener<ScrollNotification>` (line 1164) that observes the controller's effects
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_end_notification_test.dart` — 2303 lines; live `n is ScrollEndNotification` type-check (line 163) and `_captureEnd(ScrollEndNotification n)` handler (line 169) inside a `NotificationListener` wrapping real scroll views
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_increment_type_test.dart` — 2287 lines; every reference to `ScrollIncrementType` is in comments, string literals (`'ScrollIncrementType.line'`, etc.), or private identifier names (`_ScrollIncrementTypeCatalog`) — the enum is **never** used in live Dart code (no `ScrollIntent(type: ScrollIncrementType.line, ...)` and no `ScrollIncrementDetails` consumer). Fails criterion 1
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_intent_test.dart` — 2007 lines; live `ScrollIntent(direction: d, type: t)` (line 141) dispatched via `Actions.maybeInvoke<ScrollIntent>` (line 142) and bound through `Actions { ScrollIntent: ScrollAction() }` (line 884)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_metrics_notification_test.dart` — 2310 lines; live `NotificationListener<ScrollMetricsNotification>(...)` (line 854) with `bool _onMetrics(ScrollMetricsNotification n)` handler (line 299) wrapping real scrollables that emit metrics changes

## Batch 20

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_position_types_test.dart` — 2628 lines; live `ScrollController()`, `FixedExtentScrollController(...)`, and `PageController` controllers attached to real scroll views, with `_plainController.position`, `_pageController.position`, `_wheelController.position` (lines 103, 121, 147) inspecting each `ScrollPosition` subtype's `runtimeType`
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_position_with_single_context_test.dart` — 2002 lines; live `ScrollController` (line 81) attached to a real scrollable, with `final ScrollPosition pos = _controller.position` (lines 114, 161) and live `_controller.position.hold(...)`, `.jumpTo(...)`, `.minScrollExtent`/`.maxScrollExtent` calls (lines 135–149, 177)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_start_notification_test.dart` — 2131 lines; live `n is ScrollStartNotification` type-check (line 460) inside a `NotificationListener` and a `_handleStart(ScrollStartNotification n, ...)` consumer (line 193) attached to real scroll views
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_to_document_boundary_intent_test.dart` — 2175 lines; live `ScrollToDocumentBoundaryIntent(forward: forward)` (line 218) dispatched via `Actions.maybeInvoke<ScrollToDocumentBoundaryIntent>` (line 216) and a const instance at line 714
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/scroll_view_test.dart` — 2298 lines; live concrete subclasses of `ScrollView` — `ListView` (line 128), `GridView`, `CustomScrollView`, `PageView` — each rendered with its own controller (lines 138–150)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/selectable_region_selection_status_test.dart` — 1471 lines; every `SelectableRegionSelectionStatus` reference is in a comment, a string literal (`'SelectableRegionSelectionStatus.${def['name']}'`), or in a code-snippet string. The enum is **never** used in live Dart — no `switch` on its values, no field of that type, no live `case SelectableRegionSelectionStatus.selecting`. The wrapping `SelectionArea` only forwards `onSelectionChanged` callbacks; it never branches on the status enum. Fails criterion 1
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/selectable_region_state_test.dart` — 2257 lines; live `SelectableRegion(...)` (lines 615, 1613) wired through `GlobalKey<SelectableRegionState>` (line 144) with live `.currentState?.selectAll(SelectionChangedCause.toolbar)` (lines 195, 241, 246) and `.currentState?.clearSelection()` (lines 200, 250, 254)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/select_all_text_intent_test.dart` — 1951 lines; live `const SelectAllTextIntent(SelectionChangedCause.keyboard)` (lines 283, 412) bound through Shortcuts and dispatched via `Actions.maybeInvoke<SelectAllTextIntent>` (lines 370, 479) and `Actions.invoke<SelectAllTextIntent>` (line 572)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/select_intent_test.dart` — 2412 lines; live `class _CallbackSelectIntentAction extends Action<SelectIntent>` (line 928) bound in a real `Actions` widget, with `Actions.maybeInvoke<SelectIntent>(..., const SelectIntent())` (lines 881–883) firing on user input
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/selection_container_delegate_test.dart` — 2151 lines; `SelectionContainerDelegate` is abstract and the only built-in concrete (`MultiSelectableSelectionContainerDelegate`) is private — demoed indirectly via the canonical public API `const SelectionContainer.disabled(...)` (line 867) toggling selection behaviour on a live paragraph

## Batch 21

- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/selection_details_test.dart` — 2945 lines; the file's own header (lines 6, 10, 549) acknowledges that `class SelectionDetails` does not exist in this Flutter version and pivots to demoing `SelectedContent` + `SelectionGeometry` instead. Even the substitute is only consumed via `dynamic content` parameters in the live callbacks (lines 175, 195) — there is no live typed `SelectedContent` reference in code, only string-literal mentions. Fails criterion 1 (the class the file name describes is never used)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/semantics_gesture_delegate_test.dart` — 2263 lines; live `class _AnnouncingGestureDelegate extends SemanticsGestureDelegate` (line 118) constructed live (line 1329) alongside three live `RawGestureDetector` widgets (lines 1059, 1207, 1362) with real gesture recognition. The documented GEN-095 limitation (lines 1365–1370) prevents binding the interpreted subclass to the `semantics:` slot, but the subject class is still subclassed and instantiated in live code
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/shortcut_activator_test.dart` — 2710 lines; live `SingleActivator(...)` (line 374), `CharacterActivator('?')` (line 379), and `LogicalKeySet(...)` (line 380) — all three public concrete subclasses of the abstract `ShortcutActivator` — bound through real Shortcuts widgets
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/shortcut_manager_test.dart` — 2035 lines; live `class _LoggingShortcutManager extends ShortcutManager` (line 153) instantiated as `_manager` (line 620) and passed to `Shortcuts(manager: _manager, ...)` to drive a real demo
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/shortcut_map_property_test.dart` — 1987 lines; live `final ShortcutMapProperty prop = ShortcutMapProperty(...)` (line 484) rendered into a live diagnostics panel
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/single_ticker_provider_state_mixin_test.dart` — 2639 lines; multiple live State classes `with SingleTickerProviderStateMixin` (lines 309, 714, 961, 1279, 1852) each owning a live `AnimationController(vsync: this, ...)` driving real animations
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/size_changed_layout_notification_test.dart` — 1850 lines; live `NotificationListener<SizeChangedLayoutNotification>(...)` (line 456) wrapping a live `SizeChangedLayoutNotifier(...)` (line 483) with a real `bool _handleNotification(SizeChangedLayoutNotification notification)` consumer (line 421)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/sliver_animated_grid_state_test.dart` — 2265 lines; live `GlobalKey<SliverAnimatedGridState>` (line 97) attached to a live `SliverAnimatedGrid(...)` sliver (line 379) and exercised through `_gridKey.currentState?.insertItem/removeItem/insertAllItems/removeAllItems` (lines 199, 222, 250, 279, 303, 320)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/sliver_child_delegate_test.dart` — 1920 lines; live `SliverChildBuilderDelegate(...)` (line 579) and `SliverChildListDelegate(...)` (line 781) — the two public concrete subclasses of the abstract `SliverChildDelegate` — both rendering real sliver children
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/sliverlist_test.dart` — 2704 lines; live `SliverList.builder(...)` (line 961) and `SliverList.separated(...)` (line 1315) inside real `CustomScrollView`s with `SliverAppBar.large` and other slivers

## Batch 22

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/sliver_multi_box_adaptor_element_test.dart` — 2154 lines; the Element is framework-internal (cannot construct directly) — demoed indirectly via live `SliverList.builder(...)` (line 1488) and `SliverGrid(...)` (line 1631) inside real `CustomScrollView`s; the framework creates a `SliverMultiBoxAdaptorElement` for each at runtime
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/sliver_multi_box_adaptor_widget_test.dart` — 2378 lines; the abstract `SliverMultiBoxAdaptorWidget` is demoed via its public concrete subclasses, all live: `SliverGrid(...)` (line 1061), `SliverFixedExtentList(...)` (line 1138), `SliverPrototypeExtentList(...)` (line 1247)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/sliver_reorderable_list_state_test.dart` — 2566 lines; live `SliverReorderableList(...)` (lines 676, 783) wired through `GlobalKey<SliverReorderableListState>` (line 423) with live `SliverReorderableListState? state = _primaryListKey.currentState` (line 559) for imperative drag-and-drop control
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/slotted_container_render_object_mixin_test.dart` — 2198 lines; live `class _ScromRender extends RenderBox with SlottedContainerRenderObjectMixin<_ScromSlot, RenderBox>` (line 127) implementing the mixin's contract on a real RenderObject
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/slotted_multi_child_render_object_widget_mixin_test.dart` — 2419 lines; live `class _SmcrowmBindingWidget extends SlottedMultiChildRenderObjectWidget<_BindingSlot, RenderBox>` (line 905) — the public class has `with SlottedMultiChildRenderObjectWidgetMixin<...>` baked in, and the live subclass overrides the full mixin contract (`slots`, `childForSlot`, `createRenderObject`, `updateRenderObject`)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/slotted_multi_child_render_object_widget_test.dart` — 2324 lines; live `class _SmcrowDashboardWidget extends SlottedMultiChildRenderObjectWidget<_SmcrowDashboardSlot, RenderBox>` (line 163) paired with a live `RenderBox with SlottedContainerRenderObjectMixin<...>` render-object (line 238)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/slotted_render_object_element_test.dart` — 2751 lines; the framework-only `SlottedRenderObjectElement` is demoed indirectly via live `extends SlottedMultiChildRenderObjectWidget<_SroeSlotId, RenderBox>` (line 1073) — the framework instantiates a `SlottedRenderObjectElement` for each rendered widget at runtime
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/snapshot_mode_test.dart` — 2613 lines; every `SnapshotMode` reference is in a comment, an `identifier: 'SnapshotMode.permissive'` string, or a string-literal description. The enum is **never** used in live Dart as `SnapshotMode.permissive/normal/forced`, no live `SnapshotWidget(mode: ...)` is constructed, and the comment at line 1269 explicitly states "We visually *represent* the snapshot. The real SnapshotWidget would". Fails criterion 1
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/spell_check_configuration_test.dart` — 3116 lines; multiple live `const SpellCheckConfiguration(...)` instances (lines 840, 845, 857, 2521) wired into real text widgets via `spellCheckConfiguration: ...` (lines 1089, 2468)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/static_selection_container_delegate_test.dart` — 2162 lines; live `_delegate = StaticSelectionContainerDelegate()` (lines 899, 1251) passed as `delegate:` to live `SelectionContainer(delegate: _delegate, ...)` (lines 940, 1300, 1360)

## Batch 23

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/text_magnifier_configuration_test.dart` — 2242 lines; multiple live `TextMagnifierConfiguration(...)` instances (lines 254, 258, 263, 268, 286) wired into real text fields via `magnifierConfiguration: cfg` (lines 710, 1235)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/text_selection_controls_test.dart` — 2465 lines; live `class _TscFoundryTextSelectionControls extends TextSelectionControls` (line 359) plus the built-in `materialTextSelectionControls` and `cupertinoTextSelectionControls` all bound via `selectionControls:` to live text widgets (lines 1098, 1105, 1112, 1196, 1619)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/text_selection_gesture_detector_builder_delegate_test.dart` — 2175 lines; live `class _TsgdbdBridgeDelegate implements TextSelectionGestureDetectorBuilderDelegate` (line 654) wired into a real `TextSelectionGestureDetectorBuilder(delegate: _delegate)` (line 734)
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/tooltip_window_controller_delegate_test.dart` — 573 lines (smallest of the batch); `TooltipWindowControllerDelegate` is **never** used in code — it appears only in the wrapper class name `_TooltipWindowControllerDelegateDemo` (line 12) and in the AppBar title text `'TooltipWindowControllerDelegate'` (line 44). The whole demo is a generic TabBar with text descriptions about what such a delegate would do. Fails criterion 1
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/tooltip_window_test.dart` — 3381 lines; `TooltipWindow` is `@internal` and cannot be instantiated directly — demoed indirectly via live `Tooltip(...)` widgets (lines 989, 1375), which the framework backs with a `TooltipWindow` at runtime
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/transpose_characters_intent_test.dart` — 2060 lines; live `const TransposeCharactersIntent()` (line 1284) dispatched via `Actions.maybeInvoke<TransposeCharactersIntent>` (line 1282) and registered through a live `CallbackAction<TransposeCharactersIntent>(...)` (line 944)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/tree_sliver_state_mixin_test.dart` — 2639 lines; the private `_TreeSliverState<T>` (which mixes in `TreeSliverStateMixin<T>`) is reached via live `TreeSliver<_TsmNavEntry>(...)` slivers (lines 912, 934, 999, 1020) controlled by live `TreeSliverController()` instances (lines 602, 603), with `expandAll()`/`collapseAll()`/`toggleNode()` (lines 671, 687, 711) forwarding to the mixin's contract methods
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/two_dimensional_child_builder_delegate_test.dart` — 2246 lines; multiple live `TwoDimensionalChildBuilderDelegate(...)` instances (lines 535, 852, 1310, 1582) plumbed through a live `class _TwoDBuildGridView extends TwoDimensionalScrollView` (line 2026) + `class _TwoDBuildGridViewport extends TwoDimensionalViewport` (line 2066) + `RenderTwoDimensionalViewport` (line 2126) — full real 2D scroll machinery
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/two_dimensional_child_delegate_test.dart` — 2432 lines; three live concrete subclasses `_TwoDDelChessboardDelegate extends TwoDimensionalChildDelegate` (line 846), `_TwoDDelGoBoardDelegate` (line 961), `_TwoDDelDriftDelegate` (line 1305) — each instantiated and their `delegate.build(context, vicinity)` invoked live (line 692) with visual cell rendering (chess pieces, go board, drift cells). Caveat: cells are driven through a hand-rolled mini-viewport rather than through `TwoDimensionalScrollView`, but the abstract delegate contract is genuinely exercised live
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/two_dimensional_child_list_delegate_test.dart` — 2252 lines; multiple live `TwoDimensionalChildListDelegate(...)` instances (lines 800, 1374, 1610) plumbed through a live `class _TwoDListTableView extends TwoDimensionalScrollView` (line 2071) + `class _TwoDListTableViewport extends TwoDimensionalViewport` (line 2108) + `class _TwoDListTableRender extends RenderTwoDimensionalViewport` (line 2160)

## Batch 24

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/two_dimensional_child_manager_test.dart` — 2236 lines; `TwoDimensionalChildManager` is the abstract interface implemented by the Element of `TwoDimensionalViewport` (cannot be instantiated directly), so the harness builds the full surrounding stack live: `class _TwoDMgrCountingDelegate extends TwoDimensionalChildBuilderDelegate` (line 225), `class _TwoDMgrRenderWarehouseViewport extends RenderTwoDimensionalViewport` (line 404), `class _TwoDMgrWarehouseViewport extends TwoDimensionalViewport` (line 516), `class _TwoDMgrWarehouseScrollView extends TwoDimensionalScrollView` (line 577) — the manager is exercised indirectly through real `buildOrObtainChildFor` calls during layout, with the SKU-grid output painted on screen
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/two_dimensional_scrollable_state_test.dart` — 3255 lines; live `GlobalKey<TwoDimensionalScrollableState>` (lines 452–453) attached to a real `TwoDimensionalScrollable`, used to drive `verticalScrollable` / `horizontalScrollable` `animateTo` / `jumpTo` from cartographer/compass-rose UI; multiple `CustomPainter` overlays render the 2D grid, compass and tour path
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/two_dimensional_viewport_parent_data_test.dart` — 2436 lines; `TwoDimensionalViewportParentData` is the `ParentData` payload `RenderTwoDimensionalViewport` attaches to its children — the harness mirrors that contract with `_TwoDVpPdParentData` carrying the same `layoutOffset` / `vicinity` / `paintOffset` / `isVisible` fields and runs `setupParentData`/`layoutChildSequence` live; visual anatomy + bullet cards plus the working 30-child viewport demonstrate the parent-data semantics
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/undo_history_controller_test.dart` — 2682 lines; multiple live `UndoHistoryController()` instances (lines 862, 1193, 1198, …) attached to real `UndoHistory<T>` widgets and `TextField`s, with `controller.canUndo` / `canRedo` / `onUndo` / `onRedo` driving a hand-painted "history ribbon" (`CustomPainter`) and autopilot panel
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/undo_history_state_test.dart` — 2957 lines; `UndoHistoryState<T>` is `@visibleForTesting` and only reachable through the widget — the harness instantiates `UndoHistory<TextEditingValue>` (line 1343), `UndoHistory<Color>` (line 1706) and `UndoHistory<String>` (lines 2316, 2327) live, each backed by a real `UndoHistoryController`, so the State's throttling/push/undo/redo logic is exercised end-to-end in the rendered scenarios
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/undo_history_value_test.dart` — 2053 lines; 23 direct `UndoHistoryValue(canUndo: ..., canRedo: ...)` constructions plus equality and `UndoHistoryValue.empty` checks (lines 460–461, 753) wired into real `UndoHistoryController` listeners; `CustomPainter` widgets visualise the canUndo/canRedo state space
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/undo_text_intent_test.dart` — 1803 lines; live `UndoTextIntent(widget.pickedCause)` (line 943) dispatched via `Actions.maybeInvoke` with multiple live `Field A` / `Field B` `TextField`s; `CallbackAction<UndoTextIntent>` overrides intercept and report the intent into the visible log panel
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/unfocus_disposition_test.dart` — 2246 lines; 27 code-level uses of the `UnfocusDisposition` enum (line 96 onwards) bound to real `FocusNode.unfocus(disposition: ...)` calls inside a stage-spotlight UI with multiple focus scopes and `CustomPainter` highlight overlays
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/unmanaged_restoration_scope_test.dart` — 1142 lines; `UnmanagedRestorationScope` is **never** constructed in code (zero `UnmanagedRestorationScope(...)` invocations) — all 22 mentions are inside title/body strings of `conceptItems` cards (lines 19, 47), AppBar text (line 953), info paragraphs and table rows. The class under study is described but never exercised. Also the only entry-point is a single top-level `build(BuildContext)` returning a `Scaffold` (no `MaterialApp`, no nested widgets/states) backed by 18 `print()` calls and four narrative card lists. Fails criterion 1 (and partially criterion 3)
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/update_selection_intent_test.dart` — 1835 lines; live `UpdateSelectionIntent(value, target, cause)` constructions (line 532) dispatched via the Actions/Intents pipeline and overridden through custom `Action<UpdateSelectionIntent>` subclasses; petri-dish-themed `CustomPainter` and seven scenario panels render the selection mutations on real `TextField`s

## Batch 25

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/user_scroll_notification_test.dart` — 2467 lines; three live `NotificationListener<UserScrollNotification>` (lines 595, 827, 877) wrapping real scrollables, with handlers `_onPrimaryUserScroll(UserScrollNotification n)` (line 224), `_onDashUserScroll` (line 249), `_onPinnedUserScroll` (line 274) consuming the notification fields
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/viewport_element_mixin_test.dart` — 2581 lines; `ViewportElementMixin` is an internal Flutter framework mixin on `Element` (cannot be applied in user code without rebuilding the viewport's element type) — demoed indirectly via live `NotificationListener<ScrollNotification>` (line 169) wrapping real `CustomScrollView` instances and reading `notification.depth` (lines 131–135) which the mixin bumps on each viewport crossing; visual `CustomPainter` triad diagram + nested-scrollables side-by-side panels show the depth-incrementing effect
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/viewport_notification_mixin_test.dart` — 2269 lines; `ViewportNotificationMixin` is mixed into `Notification` types by the framework (cannot be constructed directly in user code) — demoed indirectly via live `NotificationListener<ScrollNotification>` (lines 1494, 1588) reading `notification.depth` (line 1477) on real `ScrollStartNotification` / `ScrollUpdateNotification` / `OverscrollNotification` (lines 1429–1465); a depth-readout AppBar and ticker-driven `CustomPainter` signal tower visualise the depth threshold filter
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/void_callback_intent_test.dart` — 2532 lines; live `VoidCallbackIntent(callback)` constructions (lines 869, 1845, 2069, 2076, 2083) dispatched via `Actions.maybeInvoke` and bound through `Shortcuts`/`Actions` widgets so each press fires a visible side-effect on the rendered scenarios
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/web_browser_detection_test.dart` — 3745 lines; `WebBrowserDetection.isSafari` is **never** read live — the live state on line 1177 is hardcoded as `final bool isSafariLive = false;`. All 13 mentions of `WebBrowserDetection.isSafari` (lines 1208, 2493, 3151, 3165, 3186, 3202, 3215, 3229, 3241, 3256) are inside multi-line code-source strings shown to the user as snippets. The class under study is described and code-snippet-quoted but never actually invoked — the demo could substitute any other class name and behave identically. Fails criterion 1
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widget_inspector_service_extensions_test.dart` — 2895 lines; `WidgetInspectorServiceExtensions` is **never** accessed live — every one of the 6 mentions of `WidgetInspectorServiceExtensions.<member>` (lines 1188, 1216, 1223, 2385, 2416, 2420) is inside a code-source string literal printed to the user as documentation. Zero `WidgetInspectorServiceExtensions.values` reads, zero `.name` access at runtime, no `registerServiceExtension(name: WidgetInspectorServiceExtensions.x.name, …)` invocation outside string snippets. Fails criterion 1
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widget_inspector_service_test.dart` — 3423 lines; live `final svc = WidgetInspectorService.instance;` (line 819) followed by real interaction with the singleton; multiple `CustomPainter` panels and live scenarios bound to the actual service object
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widget_inspector_test.dart` — 3199 lines; live `WidgetInspector(...)` constructor used to wrap a subtree (line 1312); five `CustomPainter` overlays demonstrate the inspector's visual selection/highlight semantics
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widgets_binding_observer_test.dart` — 3668 lines; live `class _WboHomeState extends State<_WboHome> with WidgetsBindingObserver` (line 175) — the mixin's lifecycle / metrics / locale / app-state callbacks each light up a row of LED widgets in the rendered scaffold
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widgets_binding_test.dart` — 3390 lines; 30 real `WidgetsBinding.instance.xxx` invocations covering `addObserver` (line 170), `addPersistentFrameCallback` (177), `addPostFrameCallback` (188, 288, 354), `removeObserver` (202), `scheduleFrame` (307) and more, all wired into a live demo with six `CustomPainter` overlays showing frame ticks, observer signals and post-frame callbacks

## Batch 26

- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widget_state_border_side_test.dart` — 2175 lines; multiple live `WidgetStateBorderSide.resolveWith(...)` (lines 749, 956, 1118, 1412) and `WidgetStateBorderSide.fromMap(<WidgetStatesConstraint, BorderSide?>{...})` (lines 942, 1282) wired into real bordered chip / button / card widgets so the resolved side is visible per state
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widget_state_color_test.dart` — 2887 lines; live `WidgetStateColor get liveSkin => WidgetStateColor.resolveWith(...)` (line 262) and `WidgetStateColor.fromMap(...)` (line 294) bound to interactive widgets that change colour with hover / focus / pressed states
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widget_state_mouse_cursor_test.dart` — 2934 lines; live `WidgetStateMouseCursor.resolveWith(...)` (line 385), `.fromMap(...)` (line 409) and `.clickable.resolve(states)` / `.textable.resolve(states)` (lines 423, 427) wired into real `MouseRegion`s with cursor changes visible on hover
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widget_state_outlined_border_test.dart` — 3114 lines; multiple live `WidgetStateOutlinedBorder.fromMap(...)` instances (lines 1505, 1918, 2074) wired into real shaped widgets that swap their outline shape per state
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widget_states_constraint_test.dart` — 3149 lines; two live concrete subclasses `class _WsctEven implements WidgetStatesConstraint` (line 140) and `class _WsctAtLeast implements WidgetStatesConstraint` (line 152), each with its `isSatisfiedBy(Set<WidgetState> states)` exercised against real interactive widgets; combined with `WidgetState`'s built-in `WidgetStatesConstraint` operators in the resolver maps
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widget_state_text_style_test.dart` — 3161 lines; live `WidgetStateTextStyle.resolveWith(...)` (lines 265, 1620) and `.fromMap(...)` (lines 324, 1847) bound to real Chip / button / card / label widgets so the rendered text style changes per state
- [x] checked / [x] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/widget_test.dart` — 3150 lines; `Widget` is the abstract base class — exercised through 11+ `class _Wgm... extends StatelessWidget` subclasses plus a live `Switch(value: _useKeys, onChanged: …)` (line 1701) that toggles between keyed and unkeyed children of a reorderable row; with keys on, counters follow items; with keys off, counters stay at positions — a working live demonstration of `Widget.canUpdate` identity (key + runtimeType) on screen
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/windowing_owner_mac_o_s_test.dart` — 929 lines; `WindowingOwnerMacOS` is **never** invoked. Only 2 mentions of the class name in the entire file, both inside string literals (line 101 AppBar title `'WindowingOwnerMacOS Deep Demo'`, line 109 description text). The demo builds locally-defined fictional widgets `_MacHero`, `_MacControlDeck`, `_MacWindowPreview`, `_MacCapabilityBoard`, `_MacLifecycleFlow`, `_MacRecipePanel` (lines 80, 121, 240, 320, 385, 465) and a `_MacWindowStyle` enum that have no connection to the real Flutter `WindowingOwnerMacOS` class — they visualise generic Mac window chrome (title bar, traffic lights, full-size content) decoupled from the windowing-owner machinery. Fails criterion 1
- [x] checked / [ ] is ok / [ ] fixed — `send_ast_via_http_scripts/widgets/windowing_owner_win32_test.dart` — 2994 lines; `WindowingOwnerWin32` is **never** invoked — the apparent class definition at lines 1372–1400 (`class WindowingOwnerWin32 extends WindowingOwner { … }`) is **inside** a `static const String _classDecl = '''…'''` triple-quoted string on line 1369 used as documentation for the `_Wow32Section2Anatomy` panel. All other 19 mentions are in titles, narrative text, log messages, and code-block snippets. The class is `@internal` and not exported through `package:flutter/widgets.dart` (line 1416 confirms this), so user code cannot instantiate it; the file consists of eight narrative sections with `_Wow32*Painter` `CustomPainter` diagrams illustrating the Win32 windowing pipeline rather than exercising any live `WindowingOwner` instance. Fails criterion 1
