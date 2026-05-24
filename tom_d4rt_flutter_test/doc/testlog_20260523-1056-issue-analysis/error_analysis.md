# Test Run Issue Analysis — 20260523-1056-issue-analysis

**Run ID:** `20260523-1056-issue-analysis`
**Date:** 2026-05-23 10:59 → 2026-05-23 13:28 (local, CEST; flutter_test
finished first)
**Scope:** All 14 flutter test files in `tom_d4rt_flutter_test`.
**Git revision:** `ee10ed726300cf119ac76d3b730979251470293c (main)`
**Host:** macOS (Darwin)

The full cross-project analysis (covering both flutter projects + the five
non-flutter `dart test` suites) lives in the matching folder for
`tom_d4rt_flutter_ast`:

> **Primary document:**
> `../../../tom_d4rt_flutter_ast/doc/testlog_20260523-1056-issue-analysis/error_analysis.md`

This file is a short delta against that primary, listing only what is
specific to `tom_d4rt_flutter_test`.

**Raw artefacts:**

- `tom_d4rt_flutter_test/doc/testlog_20260523-1056-issue-analysis/*.{result.json,log.txt}`
- `_driver.log` — sequential per-file run log (wall = 8914 s; ran in
  parallel with the `tom_d4rt_flutter_ast` driver)
- `_aggregate.json` — per-file aggregated counts + scripts with framework
  errors

---

## Headline numbers

| metric | value | Δ vs 20260522-1328 baseline |
|---|---:|---:|
| passed   | 2112 | −38 |
| failed   |    6 | −32 |
| errored  |   72 | +71 |
| skipped  |    9 |  −1 |
| scripts with frameworkErrors | 31 | n/a (baseline counted differently) |
| total frameworkErrors events |  38 | substantially down from prior |

The −32 failures reflect the previous campaign's wins (Clusters A 24
scripts + B/E/F/G 6 scripts + the bridged-mixin Cluster J carry-over). The
+71 errored is **almost entirely contention** from running the two flutter
drivers in parallel against the same host — see §S of the primary doc.

---

## Real assertion failures in tom_d4rt_flutter_test (6 entries)

| # | suite | script | inner error | shared with ast? |
|---|---|---|---|---|
| F1 | gen_interp_retest | `retest/dart_ui/system_color_palette_test.dart` | *SystemColor not supported on the current platform.* | yes |
| F2 | gen_interp_retest | `retest/material/button_bar_layout_behavior_test.dart` | `Undefined variable: ButtonBar` (Flutter 3.x deprecation) | yes |
| F3 | essential | `material/materialapp_test.dart` | `MaterialApp.router(routeInformationParser:)` rejects `_SimpleRouteParser` — Cluster B unwrap not back-ported | test-only |
| F4 | important | `widgets/decoratedbox_test.dart` | `DecoratedBox(decoration: DiagonalStripesDecoration)` — Cluster B | test-only |
| F5 | gen_interp_retest | `retest/widgets/app_kit_view_test.dart` | `AppKitView.gestureRecognizers: Set<Factory<…>>` coercion — Cluster B | test-only |
| F6 | gen_interp_retest | `retest/widgets/back_button_listener_test.dart` | `RenderFlex overflowed by 70 px on the bottom` classified as a fail by flutter_test's strict success-check | test-only |

F3/F4/F5/F6 are the four-script delta over flutter_ast and indicate the
**Cluster B `InterpretedInstance` unwrap shipped for the AST runner has
not been ported to the source-based runner**, plus a runner-semantics
divergence on framework errors (F6).

F1 and F2 are real failures that **also affect flutter_ast** — see the
primary doc.

---

## Errored tests in tom_d4rt_flutter_test (72 entries)

- **65** are *test-only*: TimeoutException 30s or transport-failure 25s
  patterns scattered across suites that ran during the contention window
  (10:59 – ~13:00 while two desktop apps + five dart VMs were warm at
  once). Examples:
  `essential cupertino/picker_test.dart`,
  `essential material/buttonstyle_test.dart`,
  `essential material/stepper_test.dart`,
  `essential widgets/changenotifier_test.dart`,
  `important painting/decoration_test.dart`,
  `important painting/colors_test.dart`,
  `important painting/matrix_test.dart`,
  `important painting/text_painting_test.dart`,
  `important animation/animationstyle_test.dart`,
  and 56 more, identical in shape.
- **7** are *shared with the ast project* — these are the wedge candidates
  documented as Cluster S in the primary doc (S1–S6). They are the only
  errored entries worth investigating before a serial re-run.

The list of shared §S entries (for convenience):

| # | script | suites | status |
|---|---|---|---|
| S1 | `rendering/render_custom_paint_test.dart` | secondary, timeout | **FIXED** (entry #E1 in primary doc — cold-start contention, not a wedge; per-script HTTP timeout raised 25 s → 50 s in both projects) |
| S2 | `dart_ui/opacity_engine_layer_test.dart` | hardly_1 | **FIXED** (entry #E12 in primary doc — cold-start contention, not a wedge; per-script HTTP timeout raised 25 s → 50 s in both projects) |
| S3 | `rendering/render_app_kit_view_test.dart` | hardly_3 | open |
| S4 | `widgets/tree_sliver_state_mixin_test.dart` | hardly_5 | open |
| S5 | `retest/widgets/app_kit_view_test.dart` | timeout (+ retest as F5) | open |
| S6 | `retest/rendering/render_animated_size_state_test.dart` | retest | open |

---

## Framework errors in tom_d4rt_flutter_test (31 scripts, 38 events)

Same set as flutter_ast (22 scripts) plus 8 test-only scripts:
`essential:widgets/center_test.dart`,
`secondary:widgets/checked_mode_banner_test.dart`,
`hardly_3:services/raw_keyboard_test.dart`,
`hardly_4:widgets/callback_shortcuts_test.dart` (2),
`hardly_4:widgets/child_back_button_dispatcher_test.dart` (2),
`hardly_5:widgets/scroll_notification_observer_state_test.dart`,
`timeout:retest/widgets/back_button_listener_test.dart`,
`gen_interp_retest:retest/widgets/{app_kit_view,back_button_listener}_test.dart`.

Highest single-script counts (same in both projects):
`cupertino/theme_test.dart` 5 events, `gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart`
3 events. All entries are RenderFlex bottom-overflows (56 px / 23 px / 70 px) or
right-overflows (2 px) — same H1 family the previous run substantially
reduced (border_test 34→0, dialog 8→0, themes_batch2 8→0, callback_handle
6→0, etc).

---

## Skipped tests in tom_d4rt_flutter_test (9, identical to flutter_ast)

Same 9 entries (K1–K9 in the primary doc):
`widgets/android_view_test.dart` (×2 platform-gated),
`dart_ui/image_sampler_slot_test.dart` (D1),
`dart_ui/isolate_name_server_test.dart` (interpreter limit),
`widgets/animated_switcher_test.dart` (W5),
`retest/widgets/{context_action,default_text_editing_shortcuts,live_text_input_status,lock_state}_test.dart`
(W1–W4 known wedges).

---

## Numbered fix-todo list

Lives in the primary doc — every entry there (1–23) applies to both
projects unless the entry explicitly says "test-only" / "ast-only".
Cross-project mapping:

- Todos #1, #2–7 (Cluster S) — apply to both
- Todos #8, #9, #10, #11 (Cluster B back-port) — **test-only**
- Todo #12 (Cluster N ButtonBar) — both
- Todo #13 (Cluster O SystemColor) — both
- Todos #14–19 (Cluster H framework errors) — both (with #19 being the
  test-only single-event delta)
- Todo #20 (Cluster I interactive) — both
- Todo #21 (P intentional SHOULD FAIL) — n/a here (non-flutter)
- Todo #22 (Q macOS DCli) — n/a here (non-flutter)
- Todo #23 (R verification) — both
