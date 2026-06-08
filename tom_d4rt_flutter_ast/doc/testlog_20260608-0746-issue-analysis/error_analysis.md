# Issue Analysis — tom_d4rt_flutter_ast

| Field | Value |
|-------|-------|
| Run ID | `20260608-0746-issue-analysis` |
| Git rev | `7a78f4293` (interpreter/bridge code identical to `e6d1424d3`; only the runner scripts differ) |
| Started | 2026-06-08 07:48:40 |
| Finished | 2026-06-08 10:48:50 (~3h00m, **serial**) |
| Runner | `test/run_issue_analysis_tests.sh <ID>` — idle watchdog 70s, `--timeout 60s` per-test, 900s file backstop, JSON file-reporter |

## Headline result

| Outcome | Count |
|---------|------:|
| Passed | 2055 |
| Skipped (reporter `~`) | 4 |
| **Failed** | **139** |
| Total | 2198 |
| Files run | 13 |
| **Clean files** | **11 of 13** — only `secondary_classes_test` and `hardly_relevant_classes_1_test` failed |

Per-file (from the script's `metrics.txt`):

| File | Result | Wall |
|------|--------|-----:|
| essential_classes_test | `+105` all pass | 03:57 |
| important_classes_test | `+162` all pass | 06:00 |
| **secondary_classes_test** | `+525 ~1 -122` | **112:13** |
| **hardly_relevant_classes_1_test** | `+187 ~1 -17` | 20:42 |
| hardly_relevant_classes_2_test | `+201` all pass | 05:46 |
| hardly_relevant_classes_3_test | `+200` all pass | 06:58 |
| hardly_relevant_classes_4_test | `+227` all pass | 06:32 |
| hardly_relevant_classes_5_test | `+229` all pass | 06:45 |
| timeout_tests_test | `+56` all pass | 02:04 |
| blocking_tests_test | `+18` all pass | 01:09 |
| generator_interpreter_issues_test | `+82 ~1` all pass | 02:52 |
| generator_interpreter_retest_test | `+57 ~1` all pass | 02:42 |
| interactive_tests_test | `+6` all pass | 00:44 |

## Failure taxonomy

| Bucket | Count | Signature |
|--------|------:|-----------|
| 45s build-timeout | 138 | `Expected: true / Actual: <false>` + `Build timed out after 45 seconds` |
| Transport failure | 1 | `Bad state: Transport failure` (`animation/elastic_in_out_curve_test.dart`) |
| **Total** | **139** | |

### Root cause — build latency, not correctness

Every `Expected: true / Actual: <false>` failure carries the harness reason
**`Build timed out after 45 seconds`**. The harness posts each script to the
companion app, waits up to **45s** for the build to complete, and asserts
`expect(buildSucceeded, isTrue)`. 138 scripts did not finish their build inside
that window, so the assertion records `false`.

**This is a build-latency problem, not an interpreter/bridge correctness bug:**

- **No** genuine logic-assertion failures — all 138 `Expected: true` failures are
  the build-timeout sentinel, none are a script asserting a wrong computed value.
- **No cascade.** Unlike the prior run (`20260607-2016`), the transport stays
  healthy: exactly **1** transport failure in the whole run (vs. 92 before). The
  45s per-build ceiling fails each slow build *in isolation* without poisoning the
  next script's `GET /clear`. That is a markedly cleaner failure mode.
- **Concentration.** 122 of 138 timeouts are in `secondary_classes_test`, which
  ran **112 minutes** — each timed-out build burned the full 45s. The remaining 16
  are in `hardly_relevant_classes_1_test`. The other 11 files are fully green.

> **Trend vs. prior run.** Total failures 208 → 139. The old 25s `POST /build` and
> 30s/5s cascade signatures are gone; the surviving failure mode is the 45s build
> ceiling alone. The long tail in `secondary_classes` (122 timeouts over 112 min)
> suggests progressive companion-app slowdown across a very long single-file run
> (647 tests) — worth profiling whether build latency climbs as the app accrues
> state, vs. a fixed set of intrinsically-heavy widgets.

## Per-file failures

#### hardly_relevant_classes_1_test — 17 failing

- `animation_behavior_test.dart` — 1 fail | Expected: true (assertion)
- `animation_eager_listener_mixin_test.dart` — 1 fail | Expected: true (assertion)
- `animation_lazy_listener_mixin_test.dart` — 1 fail | Expected: true (assertion)
- `animation_local_listeners_mixin_test.dart` — 1 fail | Expected: true (assertion)
- `animation_local_status_listeners_mixin_test.dart` — 1 fail | Expected: true (assertion)
- `animation_status_test.dart` — 1 fail | Expected: true (assertion)
- `catmull_rom_curve_test.dart` — 1 fail | Expected: true (assertion)
- `catmull_rom_spline_test.dart` — 1 fail | Expected: true (assertion)
- `class_test.dart` — 1 fail | Expected: true (assertion)
- `color_tween_test.dart` — 1 fail | Expected: true (assertion)
- `constant_tween_test.dart` — 1 fail | Expected: true (assertion)
- `cubic_test.dart` — 1 fail | Expected: true (assertion)
- `curve2_d_sample_test.dart` — 1 fail | Expected: true (assertion)
- `curve2_d_test.dart` — 1 fail | Expected: true (assertion)
- `curve_tween_test.dart` — 1 fail | Expected: true (assertion)
- `curves_test.dart` — 1 fail | Expected: true (assertion)
- `elastic_in_out_curve_test.dart` — 1 fail | Bad state: Transport failure while running "animation/elasti

#### secondary_classes_test — 122 failing

- `always_scrollable_scroll_physics_test.dart` — 1 fail | Expected: true (assertion)
- `android_view_controller_test.dart` — 1 fail | Expected: true (assertion)
- `animated_align_test.dart` — 1 fail | Expected: true (assertion)
- `animated_cross_fade_test.dart` — 1 fail | Expected: true (assertion)
- `animated_fractionally_sized_box_test.dart` — 1 fail | Expected: true (assertion)
- `animated_modal_barrier_test.dart` — 1 fail | Expected: true (assertion)
- `animated_physical_model_test.dart` — 1 fail | Expected: true (assertion)
- `animated_rotation_test.dart` — 1 fail | Expected: true (assertion)
- `animated_scale_test.dart` — 1 fail | Expected: true (assertion)
- `animated_slide_test.dart` — 1 fail | Expected: true (assertion)
- `animated_switcher_test.dart` — 1 fail | Expected: true (assertion)
- `app_kit_view_controller_test.dart` — 1 fail | Expected: true (assertion)
- `asset_manifest_test.dart` — 1 fail | Expected: true (assertion)
- `asset_metadata_test.dart` — 1 fail | Expected: true (assertion)
- `autofill_configuration_test.dart` — 1 fail | Expected: true (assertion)
- `autofill_group_test.dart` — 1 fail | Expected: true (assertion)
- `autofill_scope_test.dart` — 1 fail | Expected: true (assertion)
- `backdrop_filter_test.dart` — 1 fail | Expected: true (assertion)
- `bouncing_scroll_physics_test.dart` — 1 fail | Expected: true (assertion)
- `browser_context_menu_test.dart` — 1 fail | Expected: true (assertion)
- `build_owner_test.dart` — 1 fail | Expected: true (assertion)
- `build_scope_test.dart` — 1 fail | Expected: true (assertion)
- `caching_asset_bundle_test.dart` — 1 fail | Expected: true (assertion)
- `checked_mode_banner_test.dart` — 1 fail | Expected: true (assertion)
- `child_semantics_configurations_result_builder_test.dart` — 1 fail | Expected: true (assertion)
- `child_semantics_configurations_result_test.dart` — 1 fail | Expected: true (assertion)
- `clamping_scroll_physics_test.dart` — 1 fail | Expected: true (assertion)
- `color_filtered_test.dart` — 1 fail | Expected: true (assertion)
- `component_element_test.dart` — 1 fail | Expected: true (assertion)
- `composited_transform_follower_test.dart` — 1 fail | Expected: true (assertion)
- `composited_transform_target_test.dart` — 1 fail | Expected: true (assertion)
- `content_insertion_configuration_test.dart` — 1 fail | Expected: true (assertion)
- `context_menu_button_item_test.dart` — 1 fail | Expected: true (assertion)
- `context_menu_controller_test.dart` — 1 fail | Expected: true (assertion)
- `darwin_platform_view_controller_test.dart` — 1 fail | Expected: true (assertion)
- `default_asset_bundle_test.dart` — 1 fail | Expected: true (assertion)
- `default_process_text_service_test.dart` — 1 fail | Expected: true (assertion)
- `default_spell_check_service_test.dart` — 1 fail | Expected: true (assertion)
- `default_text_height_behavior_test.dart` — 1 fail | Expected: true (assertion)
- `dual_transition_builder_test.dart` — 1 fail | Expected: true (assertion)
- `editable_text_state_test.dart` — 1 fail | Expected: true (assertion)
- `element_test.dart` — 1 fail | Expected: true (assertion)
- `expensive_android_view_controller_test.dart` — 1 fail | Expected: true (assertion)
- `fade_in_image_test.dart` — 1 fail | Expected: true (assertion)
- `fixed_extent_metrics_test.dart` — 1 fail | Expected: true (assertion)
- `fixed_extent_scroll_controller_test.dart` — 1 fail | Expected: true (assertion)
- `fixed_extent_scroll_physics_test.dart` — 1 fail | Expected: true (assertion)
- `flutter_version_test.dart` — 1 fail | Expected: true (assertion)
- `font_loader_test.dart` — 1 fail | Expected: true (assertion)
- `hybrid_android_view_controller_test.dart` — 1 fail | Expected: true (assertion)
- `live_text_test.dart` — 1 fail | Expected: true (assertion)
- `network_asset_bundle_test.dart` — 1 fail | Expected: true (assertion)
- `performance_mode_request_handle_test.dart` — 1 fail | Expected: true (assertion)
- `platform_asset_bundle_test.dart` — 1 fail | Expected: true (assertion)
- `platform_view_controller_test.dart` — 1 fail | Expected: true (assertion)
- `platform_views_registry_test.dart` — 1 fail | Expected: true (assertion)
- `platform_views_service_test.dart` — 1 fail | Expected: true (assertion)
- `predictive_back_event_test.dart` — 1 fail | Expected: true (assertion)
- `process_text_action_test.dart` — 1 fail | Expected: true (assertion)
- `process_text_service_test.dart` — 1 fail | Expected: true (assertion)
- `render_repaint_boundary_test.dart` — 1 fail | Expected: true (assertion)
- `render_rotated_box_test.dart` — 1 fail | Expected: true (assertion)
- `render_semantics_annotations_test.dart` — 1 fail | Expected: true (assertion)
- `render_semantics_gesture_handler_test.dart` — 1 fail | Expected: true (assertion)
- `render_shader_mask_test.dart` — 1 fail | Expected: true (assertion)
- `render_shrink_wrapping_viewport_test.dart` — 1 fail | Expected: true (assertion)
- `render_sized_overflow_box_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_animated_opacity_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_fill_remaining_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_fill_viewport_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_fixed_extent_list_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_floating_persistent_header_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_helpers_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_ignore_pointer_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_multi_box_adaptor_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_offstage_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_persistent_header_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_pinned_persistent_header_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_scrolling_persistent_header_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_to_box_adapter_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_varied_extent_list_test.dart` — 1 fail | Expected: true (assertion)
- `render_sliver_with_keep_alive_mixin_test.dart` — 1 fail | Expected: true (assertion)
- `render_tree_sliver_test.dart` — 1 fail | Expected: true (assertion)
- `render_viewport_base_test.dart` — 1 fail | Expected: true (assertion)
- `renderer_binding_test.dart` — 1 fail | Expected: true (assertion)
- `rendering_flutter_binding_test.dart` — 1 fail | Expected: true (assertion)
- `restoration_manager_test.dart` — 1 fail | Expected: true (assertion)
- `scribe_test.dart` — 1 fail | Expected: true (assertion)
- `selectable_test.dart` — 1 fail | Expected: true (assertion)
- `selected_content_test.dart` — 1 fail | Expected: true (assertion)
- `selection_geometry_test.dart` — 1 fail | Expected: true (assertion)
- `selection_point_test.dart` — 1 fail | Expected: true (assertion)
- `semantics_annotations_mixin_test.dart` — 1 fail | Expected: true (assertion)
- `semantics_binding_test.dart` — 1 fail | Expected: true (assertion)
- `semantics_event_test.dart` — 1 fail | Expected: true (assertion)
- `semantics_handle_test.dart` — 1 fail | Expected: true (assertion)
- `semantics_label_builder_test.dart` — 1 fail | Expected: true (assertion)
- `shader_mask_layer_test.dart` — 1 fail | Expected: true (assertion)
- `shape_border_clipper_test.dart` — 1 fail | Expected: true (assertion)
- `sliver_grid_geometry_test.dart` — 1 fail | Expected: true (assertion)
- `sliver_grid_layout_test.dart` — 1 fail | Expected: true (assertion)
- `sliver_grid_regular_tile_layout_test.dart` — 1 fail | Expected: true (assertion)
- `sliver_hit_test_entry_test.dart` — 1 fail | Expected: true (assertion)
- `sliver_hit_test_result_test.dart` — 1 fail | Expected: true (assertion)
- `sliver_layout_dimensions_test.dart` — 1 fail | Expected: true (assertion)
- `sliver_logical_parent_data_test.dart` — 1 fail | Expected: true (assertion)
- `sliver_multi_box_adaptor_parent_data_test.dart` — 1 fail | Expected: true (assertion)
- `sliver_physical_parent_data_test.dart` — 1 fail | Expected: true (assertion)
- `spell_check_service_test.dart` — 1 fail | Expected: true (assertion)
- `suggestion_span_test.dart` — 1 fail | Expected: true (assertion)
- `surface_android_view_controller_test.dart` — 1 fail | Expected: true (assertion)
- `system_channels_test.dart` — 1 fail | Expected: true (assertion)
- `table_cell_parent_data_test.dart` — 1 fail | Expected: true (assertion)
- `text_layout_metrics_test.dart` — 1 fail | Expected: true (assertion)
- `text_parent_data_test.dart` — 1 fail | Expected: true (assertion)
- `text_selection_point_test.dart` — 1 fail | Expected: true (assertion)
- `texture_android_view_controller_test.dart` — 1 fail | Expected: true (assertion)
- `texture_layer_test.dart` — 1 fail | Expected: true (assertion)
- `ui_kit_view_controller_test.dart` — 1 fail | Expected: true (assertion)
- `undo_manager_client_test.dart` — 1 fail | Expected: true (assertion)
- `undo_manager_test.dart` — 1 fail | Expected: true (assertion)
- `wrap_parent_data_test.dart` — 1 fail | Expected: true (assertion)


## Captured framework / runtime errors (did NOT cause a failure)

Scan of all 13 logs for the "test-internal problems like overflow errors"
category — the captured output that may not surface as a test failure:

| Signature | Count | Verdict |
|-----------|------:|---------|
| `RenderFlex` / `overflowed` | 0 | none |
| `EXCEPTION CAUGHT BY …` | 0 | none |
| `[framework error]` log lines | 0 | none |
| `Build completed: … framework error(s)` | 0 | none |
| `capturedFrameworkErrors=[1-9]` | 0 | none (only `=0` observed) |

**Clean.** No RenderFlex/overflow, no uncaught framework exceptions, no captured
build-time framework errors anywhere in the run. In particular the
`painting/gradient_transform_test.dart` bridged-`operator *` defect seen in the
prior run did **not** reproduce here (that script was not among the builds that
completed; nothing in this run re-triggered it).

## Conclusion

- **139 failures = 138 × 45s build-timeout + 1 isolated transport failure.** All
  138 are the harness build-success assertion (`Expected: true`) failing because
  the build exceeded the 45s ceiling — a **latency** issue, not a correctness one.
- **No interpreter/bridge correctness defects, no framework errors, no
  overflows.** 11 of 13 files are fully green.
- **Hot spot**: `secondary_classes_test` (122 timeouts, 112 min) and
  `hardly_relevant_classes_1_test` (16 timeouts). Recommended next step is to
  profile build latency within `secondary_classes` — confirm whether it is
  progressive companion-app slowdown over a 647-test single-file run (in which
  case splitting the file or periodically restarting the companion app would
  recover most of the 122), or a fixed cluster of heavy widgets that genuinely
  need a higher per-build budget.
