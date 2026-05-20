# Short Tests Verification — Round 2

109 scripts in `test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/`,
taken from the 300 currently smallest by file size and then filtered to
exclude both `repro*` scripts and any script with more than 500 lines.
Ordered by file size (bytes ascending). Generated 2026-05-20 against
git revision `43947032` (after Cluster I closure on 2026-05-20).

> The earlier `short_tests_verification.md` list (600 entries) has gone stale:
> many small scripts grew substantially between the original generation and
> 2026-05-20 (e.g. `widgets/form_test.dart` went from 7,872 B / rank 600 to
> 68,662 B / rank 1,561). The dataset below is a fresh size-sorted slice
> of the current 2,061 scripts under `send_ast_via_http_scripts/`, after
> the two filters above, with all checkboxes reset for the next verification
> pass.
>
> Filter rationale:
> - **`repro*`** — `repro_fa*/*.dart` scripts are minimal reproduction stubs,
>   not real coverage tests; verifying them yields no signal on the bridge
>   or interpreter.
> - **lines > 500** — long scripts inflate review time without proportional
>   verification value; they are deferred to a separate longer-script pass.
>
> Of the 300 smallest by bytes, 9 were `repro*` and 182 had > 500 lines
> (small bytes with many short single-declaration lines is the common
> shape — e.g. enum-coverage tests with one `print(EnumX.value);` per line),
> leaving 109 entries. Byte range: 3,819 → 23,711 B. Line range: ~116 → 499.

Columns: **idx** | **file** | **bytes** | **lines** | **checked** | **is ok** | **fixed**

| # | File | Bytes | Lines | Checked | Is ok | Fixed |
|--:|------|------:|------:|:-------:|:-----:|:-----:|
|   1 | `foundation/text_tree_configuration_test.dart` | 3,819 | 116 | (x) | (x) | (x) |
|   2 | `widgets/animatedgrid_test.dart` | 3,860 | 125 | (x) | (x) | (x) |
|   3 | `widgets/animation_test.dart` | 7,881 | 212 | (x) | (x) | (x) |
|   4 | `material/bottomappbar_test.dart` | 8,019 | 279 | (x) | (x) | (x) |
|   5 | `widgets/pageview_test.dart` | 8,052 | 294 | (x) | (x) | (x) |
|   6 | `widgets/cliprrect_test.dart` | 8,091 | 294 | (x) | (x) | (x) |
|   7 | `widgets/interactiveviewer_test.dart` | 8,145 | 264 | (x) | (x) | (x) |
|   8 | `gestures/recognizers_test.dart` | 8,210 | 232 | (x) | (x) | (x) |
|   9 | `services/codecs_test.dart` | 8,229 | 225 | (x) | (x) | (x) |
|  10 | `material/buttons_test.dart` | 8,248 | 295 | (x) | (x) | (x) |
|  11 | `material/materialapp_test.dart` | 8,281 | 238 | (x) | (x) | (x) |
|  12 | `cupertino/tab_test.dart` | 8,303 | 265 | (x) | (x) | (x) |
|  13 | `foundation/key_test.dart` | 8,315 | 246 | (x) | (x) | (x) |
|  14 | `cupertino/button_test.dart` | 8,353 | 272 | (x) | (x) | (x) |
|  15 | `widgets/navigator_test.dart` | 8,358 | 238 | (x) | (x) | (x) |
|  16 | `material/picker_themes_test.dart` | 8,609 | 217 | (x) | (x) | (x) |
|  17 | `rendering/debug_overflow_indicator_mixin_test.dart` | 8,610 | 251 | (x) | (x) | (x) |
|  18 | `material/component_themes_test.dart` | 8,612 | 231 | (x) | (x) | (x) |
|  19 | `material/bottomnavigationbar_test.dart` | 8,726 | 263 | (x) | (x) | (x) |
|  20 | `widgets/transform_test.dart` | 8,726 | 316 | (x) | (x) | (x) |
|  21 | `dart_ui/primitives_test.dart` | 8,744 | 245 | (x) | (x) | (x) |
|  22 | `widgets/customscrollview_test.dart` | 8,780 | 303 | (x) | (x) | (x) |
|  23 | `material/widgetstate_test.dart` | 8,813 | 207 | (x) | (x) | (x) |
|  24 | `widgets/wrap_test.dart` | 8,839 | 311 | (x) | (x) | (x) |
|  25 | `animation/alwaysstoppedanimation_test.dart` | 8,931 | 279 | (x) | (x) | (x) |
|  26 | `material/dropdownform_test.dart` | 8,937 | 282 | (x) | (x) | (x) |
|  27 | `dart_ui/clip_r_rect_engine_layer_test.dart` | 8,984 | 307 | (x) | (x) | (x) |
|  28 | `material/icontheme_test.dart` | 9,053 | 288 | (x) | (x) | (x) |
|  29 | `material/formcontrols_test.dart` | 9,119 | 349 | (x) | (x) | (x) |
|  30 | `cupertino/cupertino_themes_batch2_test.dart` | 9,219 | 265 | (x) | (x) | (x) |
|  31 | `material/stepper_test.dart` | 9,271 | 332 | (x) | (x) | (x) |
|  32 | `widgets/decoratedbox_test.dart` | 9,275 | 323 | (x) | (x) | (x) |
|  33 | `widgets/absorbpointer_test.dart` | 9,319 | 323 | (x) | (x) | (x) |
|  34 | `material/mergeable_test.dart` | 9,365 | 320 | (x) | (x) | (x) |
|  35 | `material/togglebuttons_test.dart` | 9,421 | 300 | (x) | (x) | (x) |
|  36 | `material/material_widget_test.dart` | 9,468 | 360 | (x) | (x) | (x) |
|  37 | `cupertino/datepicker_modes_test.dart` | 9,471 | 259 | ( ) | ( ) | ( ) |
|  38 | `widgets/table_test.dart` | 9,515 | 290 | ( ) | ( ) | ( ) |
|  39 | `cupertino/cupertino_themes_batch3_test.dart` | 9,516 | 261 | ( ) | ( ) | ( ) |
|  40 | `dart_ui/callback_handle_test.dart` | 9,650 | 339 | ( ) | ( ) | ( ) |
|  41 | `material/input_themes_test.dart` | 9,671 | 249 | ( ) | ( ) | ( ) |
|  42 | `widgets/statefulwidget_test.dart` | 9,762 | 318 | ( ) | ( ) | ( ) |
|  43 | `retest/widgets/render_nested_scroll_view_viewport_test.dart` | 10,006 | 238 | ( ) | ( ) | ( ) |
|  44 | `painting/border_test.dart` | 10,103 | 314 | ( ) | ( ) | ( ) |
|  45 | `animation/animatable_test.dart` | 10,116 | 321 | ( ) | ( ) | ( ) |
|  46 | `widgets/constrainedbox_test.dart` | 10,145 | 312 | ( ) | ( ) | ( ) |
|  47 | `painting/edgeinsets_test.dart` | 10,437 | 315 | ( ) | ( ) | ( ) |
|  48 | `material/divider_test.dart` | 10,668 | 346 | ( ) | ( ) | ( ) |
|  49 | `widgets/render_object_to_widget_element_test.dart` | 10,711 | 243 | ( ) | ( ) | ( ) |
|  50 | `cupertino/cupertino_themes_batch1_test.dart` | 10,915 | 275 | ( ) | ( ) | ( ) |
|  51 | `animation/compoundanimation_test.dart` | 11,072 | 325 | ( ) | ( ) | ( ) |
|  52 | `widgets/draggable_test.dart` | 11,084 | 387 | ( ) | ( ) | ( ) |
|  53 | `animation/tweensequence_test.dart` | 11,260 | 378 | ( ) | ( ) | ( ) |
|  54 | `material/nav_destinations_test.dart` | 11,303 | 365 | ( ) | ( ) | ( ) |
|  55 | `rendering/textpainter_test.dart` | 11,531 | 364 | ( ) | ( ) | ( ) |
|  56 | `foundation/notifier_test.dart` | 11,764 | 346 | ( ) | ( ) | ( ) |
|  57 | `widgets/render_tree_root_element_test.dart` | 11,889 | 286 | ( ) | ( ) | ( ) |
|  58 | `material/dropdown_test.dart` | 12,129 | 384 | ( ) | ( ) | ( ) |
|  59 | `material/sliverappbar_test.dart` | 12,484 | 383 | ( ) | ( ) | ( ) |
|  60 | `material/misc_themes_test.dart` | 12,585 | 323 | ( ) | ( ) | ( ) |
|  61 | `material/progress_test.dart` | 12,661 | 375 | ( ) | ( ) | ( ) |
|  62 | `cupertino/cupertino_themes_batch4_test.dart` | 12,695 | 317 | ( ) | ( ) | ( ) |
|  63 | `material/buttonstyle_test.dart` | 12,934 | 399 | ( ) | ( ) | ( ) |
|  64 | `physics/simulations_test.dart` | 12,997 | 386 | ( ) | ( ) | ( ) |
|  65 | `rendering/boxconstraints_test.dart` | 13,319 | 399 | ( ) | ( ) | ( ) |
|  66 | `material/inputdecoration_test.dart` | 13,381 | 408 | ( ) | ( ) | ( ) |
|  67 | `material/dialog_test.dart` | 13,458 | 449 | ( ) | ( ) | ( ) |
|  68 | `material/materialcolor_test.dart` | 13,729 | 386 | ( ) | ( ) | ( ) |
|  69 | `scheduler/ticker_test.dart` | 13,816 | 396 | ( ) | ( ) | ( ) |
|  70 | `material/tooltip_badge_test.dart` | 13,826 | 500 | ( ) | ( ) | ( ) |
|  71 | `dart_ui/app_exit_type_test.dart` | 13,867 | 447 | ( ) | ( ) | ( ) |
|  72 | `material/search_test.dart` | 13,895 | 477 | ( ) | ( ) | ( ) |
|  73 | `cupertino/dialog_test.dart` | 13,922 | 387 | ( ) | ( ) | ( ) |
|  74 | `material/scrollbar_test.dart` | 13,959 | 467 | ( ) | ( ) | ( ) |
|  75 | `rendering/render_fractional_translation_test.dart` | 13,969 | 411 | ( ) | ( ) | ( ) |
|  76 | `cupertino/picker_test.dart` | 14,197 | 415 | ( ) | ( ) | ( ) |
|  77 | `material/theme_test.dart` | 14,548 | 466 | ( ) | ( ) | ( ) |
|  78 | `animation/curve_test.dart` | 14,586 | 399 | ( ) | ( ) | ( ) |
|  79 | `widgets/traversal_edge_behavior_test.dart` | 14,755 | 484 | ( ) | ( ) | ( ) |
|  80 | `rendering/render_fractionally_sized_overflow_box_test.dart` | 14,849 | 421 | ( ) | ( ) | ( ) |
|  81 | `dart_ui/app_exit_response_test.dart` | 15,441 | 403 | ( ) | ( ) | ( ) |
|  82 | `painting/gradient_shadow_test.dart` | 15,469 | 493 | ( ) | ( ) | ( ) |
|  83 | `painting/textstyle_test.dart` | 15,636 | 481 | ( ) | ( ) | ( ) |
|  84 | `dart_ui/backdrop_filter_engine_layer_test.dart` | 15,867 | 471 | ( ) | ( ) | ( ) |
|  85 | `dart_ui/accessibility_features_test.dart` | 16,408 | 434 | ( ) | ( ) | ( ) |
|  86 | `animation/tween_test.dart` | 16,456 | 456 | ( ) | ( ) | ( ) |
|  87 | `cupertino/scaffold_test.dart` | 17,047 | 487 | ( ) | ( ) | ( ) |
|  88 | `dart_ui/app_lifecycle_state_test.dart` | 17,400 | 490 | ( ) | ( ) | ( ) |
|  89 | `gestures/details_test.dart` | 17,409 | 490 | ( ) | ( ) | ( ) |
|  90 | `dart_ui/blur_style_test.dart` | 17,414 | 497 | ( ) | ( ) | ( ) |
|  91 | `rendering/render_exclude_semantics_test.dart` | 17,555 | 472 | ( ) | ( ) | ( ) |
|  92 | `dart_ui/channel_buffers_test.dart` | 17,810 | 409 | ( ) | ( ) | ( ) |
|  93 | `dart_ui/blend_mode_test.dart` | 17,962 | 439 | ( ) | ( ) | ( ) |
|  94 | `dart_ui/box_width_style_test.dart` | 18,873 | 423 | ( ) | ( ) | ( ) |
|  95 | `material/dynamic_scheme_variant_test.dart` | 18,923 | 363 | ( ) | ( ) | ( ) |
|  96 | `cupertino/theme_test.dart` | 19,140 | 478 | ( ) | ( ) | ( ) |
|  97 | `dart_ui/class_test.dart` | 19,285 | 472 | ( ) | ( ) | ( ) |
|  98 | `cupertino/icons_test.dart` | 19,796 | 378 | ( ) | ( ) | ( ) |
|  99 | `gestures/class_test.dart` | 20,014 | 448 | ( ) | ( ) | ( ) |
| 100 | `material/material_tap_target_size_test.dart` | 20,036 | 399 | ( ) | ( ) | ( ) |
| 101 | `gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart` | 20,156 | 430 | ( ) | ( ) | ( ) |
| 102 | `retest/material/button_bar_layout_behavior_test.dart` | 21,530 | 468 | ( ) | ( ) | ( ) |
| 103 | `material/checkbox_list_tile_test.dart` | 21,583 | 438 | ( ) | ( ) | ( ) |
| 104 | `retest/material/dropdown_menu_close_behavior_test.dart` | 21,738 | 457 | ( ) | ( ) | ( ) |
| 105 | `retest/material/button_text_theme_test.dart` | 21,835 | 496 | ( ) | ( ) | ( ) |
| 106 | `retest/material/material_banner_closed_reason_test.dart` | 22,177 | 444 | ( ) | ( ) | ( ) |
| 107 | `retest/material/navigation_destination_label_behavior_test.dart` | 23,039 | 455 | ( ) | ( ) | ( ) |
| 108 | `material/drawer_button_test.dart` | 23,527 | 485 | ( ) | ( ) | ( ) |
| 109 | `material/script_category_test.dart` | 23,711 | 499 | ( ) | ( ) | ( ) |
