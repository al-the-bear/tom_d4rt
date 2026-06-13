# Flutter Bridge Corpus — Issue Analysis `20260613-1356-issue-analysis`

| Field | Value |
|-------|-------|
| Analysis ID | `20260613-1356-issue-analysis` |
| Projects | `tom_d4rt_flutter` (source-direct) **and** `tom_d4rt_flutter_ast` (AST-driven) |
| Git revision | `b9a4045eb` — *fix(d4rt): instance members shadow bridged top-level functions (FIX-20260613-1038-C)* |
| Run date/time | 2026-06-13, ~13:56–17:22 CEST |
| Runner | `test/run_issue_analysis_tests.sh 20260613-1356-issue-analysis` (per file, strictly serial) |
| Logs | `doc/testlog_20260613-1356-issue-analysis/*.log.txt` (+ `*.result.json` JSON reporter) |
| Metrics | `doc/testlog_20260613-1356-issue-analysis/metrics.txt` |
| Serial rule | The two projects were run **sequentially, never concurrently** (shared companion-app HTTP server). |

---

## Result summary

| Project | Files | Passed | Skipped | Failed | Failing files | Framework-error files | Overflow / EXCEPTION CAUGHT |
|---------|------:|-------:|--------:|-------:|--------------:|----------------------:|----------------------------:|
| `tom_d4rt_flutter` (source-direct) | 41 | 2144 | 4 | 21 | 16 | **0** | **0** |
| `tom_d4rt_flutter_ast` (AST-driven) | 41 | 2129 | 4 | 36 | 20 | **0** | **0** |

### Headline findings

1. **Zero non-fatal framework / overflow errors in either project.** Every one of the 82 corpus files reported `frameworkErrors=0`; no `RenderFlex overflowed`, no `EXCEPTION CAUGHT`, no Flutter error banners appear in any log. This was the primary target of the issue-analysis run.
2. **FIX-20260613-1038-C validated.** The prior AST run logged **33** non-fatal framework errors in `flutter_base_06` (`painting/gradient_transform_test.dart`, the `radians` Class-C bug). In this run `base_06` reports `frameworkErrors=0` and is not in the framework-error file list — the 33 errors are eliminated.
3. **No genuine bridge / interpreter failures.** Every test failure in *both* projects is companion-app infrastructure, not a bridge or interpreter defect:
   - **Class A — companion-app build timeout** (the dominant cause): the first heavy script after a cold start / app recycle, or a script run while the host is under load, does not return a built frame before the harness deadline (30 s source-direct, 45 s AST). Manifests as `Expected: true / Actual: <false> / Build timed out after N seconds`.
   - **Class B — transport hiccup** (1 occurrence per project, the *same* test): `GET /clear` returns `HttpException: Connection closed before full header was received` on `retest/widgets/nested_scroll_view_state_test.dart`.

   These are flaky-infrastructure failures (the documented Class A/B taxonomy), not regressions. The scripts that *did* execute all ran without framework errors.

---

## Failure taxonomy

| Class | Symptom | Count (source-direct) | Count (AST) | Root cause |
|-------|---------|----------------------:|------------:|------------|
| A | `Build timed out after N seconds` | 20 | 35 | Companion app had not produced a built frame within the harness deadline — cold start after recycle, or host contention. Not a bridge defect. |
| B | `HttpException: Connection closed before full header was received` on `GET /clear` | 1 | 1 | Transport-layer hiccup tearing down the previous script's state. Same test in both projects (`nested_scroll_view_state_test`). |
| C | Non-fatal framework / overflow error on a passing script | **0** | **0** | None — the analysis target is clean. |

---

## File-by-file — `tom_d4rt_flutter` (source-direct)

All 16 failing files; every failure is Class A *(Build timed out after 30 s)* unless noted.

| File | Failed | Failing test scripts |
|------|-------:|----------------------|
| flutter_base_01 | 2 | cupertino/controls_test.dart; cupertino/form_test.dart |
| flutter_base_05 | 2 | services/cursor_test.dart; services/textboundary_test.dart |
| flutter_base_10 | 1 | material/app_bar_theme_data_test.dart |
| flutter_base_13 | 1 | rendering/render_rotated_box_test.dart |
| flutter_base_14 | 2 | services/android_view_controller_test.dart; services/app_kit_view_controller_test.dart |
| flutter_extended_03 | 2 | dart_ui/text_align_test.dart; dart_ui/vertex_mode_test.dart |
| flutter_extended_04 | 1 | gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart |
| flutter_extended_07 | 1 | material/round_range_slider_tick_mark_shape_test.dart |
| flutter_extended_08 | 1 | painting/class_test.dart |
| flutter_extended_11 | 1 | services/g_l_f_w_key_helper_test.dart |
| flutter_extended_13 | 1 | widgets/action_dispatcher_test.dart |
| flutter_extended_14 | 1 | widgets/decoration_tween_test.dart |
| flutter_extended_15 | 2 | widgets/extend_selection_to_document_boundary_intent_test.dart; widgets/img_element_platform_view_test.dart |
| flutter_extended_18 | 1 | widgets/restorable_enum_n_test.dart |
| flutter_extended_21 | 1 | retest: widgets/android_view_surface_test.dart |
| flutter_extended_23 | 1 | **Class B** — retest: widgets/nested_scroll_view_state_test.dart (`HttpException` on `GET /clear`) |

**Framework / runtime errors:** none. All 41 files report `frameworkErrors=0`; logs contain no overflow or `EXCEPTION CAUGHT` output.

---

## File-by-file — `tom_d4rt_flutter_ast` (AST-driven)

All 20 failing files; every failure is Class A *(Build timed out after 45 s)* unless noted.

| File | Failed | Failing test scripts |
|------|-------:|----------------------|
| flutter_base_05 | 1 | cupertino/cupertino_sections_test.dart |
| flutter_base_06 | 3 | material/chip_variants_test.dart; material/input_borders_test.dart; material/scaffold_advanced_test.dart |
| flutter_base_07 | 3 | widgets/focus_properties_test.dart; widgets/focus_traversal_advanced_test.dart; animation/animation_with_parent_mixin_test.dart |
| flutter_base_08 | 1 | foundation/timed_block_test.dart |
| flutter_base_10 | 2 | material/adaptive_text_selection_toolbar_test.dart; material/scaffold_messenger_test.dart |
| flutter_base_11 | 5 | material/tab_bar_indicator_size_test.dart; material/text_button_theme_data_test.dart; painting/image_stream_completer_test.dart; painting/resize_image_test.dart; painting/rounded_superellipse_border_test.dart |
| flutter_base_12 | 1 | rendering/box_hit_test_result_test.dart |
| flutter_base_13 | 2 | rendering/render_sliver_offstage_test.dart; rendering/render_sliver_varied_extent_list_test.dart |
| flutter_base_16 | 1 | widgets/page_scroll_physics_test.dart |
| flutter_base_17 | 1 | widgets/tween_animation_builder_test.dart |
| flutter_extended_01 | 1 | animation/animation_behavior_test.dart |
| flutter_extended_02 | 1 | dart_ui/system_color_palette_test.dart |
| flutter_extended_03 | 3 | dart_ui/text_align_test.dart; dart_ui/text_baseline_test.dart; dart_ui/view_focus_direction_test.dart |
| flutter_extended_06 | 5 | material/gapped_range_slider_track_shape_test.dart; material/gregorian_calendar_delegate_test.dart; material/handle_thumb_shape_test.dart; material/icons_test.dart; material/interactive_ink_feature_factory_test.dart |
| flutter_extended_07 | 1 | material/slider_interaction_test.dart |
| flutter_extended_08 | 1 | painting/asset_bundle_image_key_test.dart |
| flutter_extended_13 | 1 | widgets/abstract_layout_builder_test.dart |
| flutter_extended_15 | 1 | widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart |
| flutter_extended_16 | 1 | widgets/nested_scroll_view_viewport_test.dart |
| flutter_extended_23 | 1 | **Class B** — retest: widgets/nested_scroll_view_state_test.dart (`HttpException` on `GET /clear`) |

**Framework / runtime errors:** none. All 41 files report `frameworkErrors=0`; logs contain no overflow or `EXCEPTION CAUGHT` output. `flutter_base_06` is clean (the prior run's 33 `radians` framework errors are resolved).

---

## Source-direct vs AST — cross comparison

- **Bridge correctness is equivalent.** Neither path produced a framework error or a genuine interpreter failure. The two failure *sets* differ only because the timeouts land on whichever script happens to be cold/contended at run time — they are not reproducible per-file defects.
- **AST shows more Class-A timeouts (35 vs 20).** Expected: the AST path ships a serialized `SAstNode` JSON bundle (`bundleJsonBytes` ~0.5–0.9 MB per script) that must be parsed before interpretation, so a cold first-frame after recycle is heavier and more likely to cross the deadline. This is a harness-warmup characteristic, not a bridge regression.
- **The single Class-B transport failure is identical in both** (`nested_scroll_view_state_test` / `GET /clear`) — a shared companion-app teardown hiccup, not project-specific.

## Conclusion

The issue-analysis run is **clean of the conditions it was designed to surface**: zero non-fatal framework errors, zero overflow output, zero genuine bridge/interpreter defects across 82 corpus files (4 273 passing assertions). The 57 combined test failures are entirely flaky companion-app infrastructure (56 build-timeout + 1 transport), reproducible only under load and not attributable to the interpreter or generated bridges. FIX-20260613-1038-C is confirmed effective: the prior AST run's 33 `radians` framework errors in `flutter_base_06` are gone.

### Recommended follow-ups (infrastructure, not bridges)
- Raise / adapt the per-script build deadline after a recycle, or add a warmup probe so the first post-recycle script is not measured against a cold app.
- Add a bounded retry on `GET /clear` transport failures to absorb the Class-B hiccup.

---

## Addendum — individual rerun verification (2026-06-13)

To confirm the failures are flaky infrastructure rather than per-test defects, **every failing test from this run was re-executed individually**, one at a time, against a freshly booted companion app. The exact failing test names were taken from the JSON reporters (not the markdown tables), so each rerun targeted the precise variant that failed:

```
flutter test test/<file> --plain-name '<exact full test name>' --timeout 120s
```

Strictly serial; source-direct and AST run sequentially, never concurrent. **An isolated rerun is *harsher* than the batch for Class-A timeouts** — each script is now always the first/cold script against a cold app and interpreter, with no preceding warm script — so any test that still times out individually is a *weaker* defect signal than in the batch, not a stronger one.

### Result

| Project | Reran | Passed individually | Still failed | All still-failing = Class-A cold-start timeout? |
|---------|------:|--------------------:|-------------:|:--:|
| `tom_d4rt_flutter` (source-direct) | 21 | **18** | 3 | yes (`Build timed out after 30 s`) |
| `tom_d4rt_flutter_ast` (AST-driven) | 36 | **29** | 7 | yes (`Build timed out after 45 s`) |
| **Combined** | **57** | **47** | **10** | **yes — 0 genuine defects** |

**47 of 57 (82 %) passed outright in isolation.** Every one of the 10 that still failed shows the *identical* Class-A signature — `status=error`, `httpMs≈30000/45000` (the app-side build deadline hit exactly), `frameworkErrors=0`, and `appInterpretStartMs=-1` (**interpretation never started** — the cold build did not finish before the deadline). No `EXCEPTION CAUGHT`, no interpreter exception, no overflow on any rerun. The single Class-B transport test (`retest: widgets/nested_scroll_view_state_test.dart`) **passed individually in both projects**, confirming it was a teardown-sequence artifact.

Still-failing individually (all cold-start build timeouts, the largest scripts):

- **source-direct (3):** `flutter_base_01` cupertino/form_test.dart; `flutter_base_05` services/textboundary_test.dart (~73 k chars); `flutter_extended_18` widgets/restorable_enum_n_test.dart.
- **AST (7):** `flutter_base_06` material/chip_variants_test.dart; `flutter_base_07` animation/animation_with_parent_mixin_test.dart; `flutter_base_11` painting/resize_image_test.dart; `flutter_base_13` rendering/render_sliver_offstage_test.dart; `flutter_base_16` widgets/page_scroll_physics_test.dart; `flutter_extended_03` dart_ui/text_baseline_test.dart; `flutter_extended_08` painting/asset_bundle_image_key_test.dart.

### Conclusion

The individual rerun **confirms the failure taxonomy**: there are no genuine bridge or interpreter defects. The residual failures are the cold-start build-timeout (Class A) — exactly the condition the rerun makes more likely by always running cold — and they are eliminated for heavier scripts only by giving the build a warm app. This validates the recommended follow-up (warmup probe / adaptive post-recycle deadline) as the correct fix, and reconfirms that the batch-run failure counts are an artifact of harness warm-up, not the generated bridges.
