# Error Analysis — tom_d4rt_flutter_ast (AST-driven interpreter)

**Run ID:** `20260608-2157-issue-analysis`
**Corpus:** 41 split files (`flutter_base_01..17`, `flutter_extended_01..24`)
**App build budget:** 45 s (server) · 55 s (client) · 60 s (flutter per-test)
**Bridge regen:** skipped (`D4RT_SKIP_BRIDGE_REGEN=1`)

## Headline

| Metric | Value |
| --- | --- |
| Passed | **2148** |
| Failed | **17** |
| Skipped | 4 |
| Build-timeout / wedge **recoveries** | **17** (`[recycle] ready`) |
| Cascades (multi-test wedge chains) | **0** |
| Non-failing framework errors | 33 (1 file) |

**All 17 failures are timeout / performance-related — there are no logic
or correctness regressions in the interpreter.** Every wedge self-recovered:
the failed test's app process was SIGKILLed eagerly and a fresh app booted
before the next test, so no failure cascaded into the following tests.

## Failure breakdown by cause

| Cause | Count | Mechanism |
| --- | --- | --- |
| Server build-timeout (45 s) | 12 | `_d4rt.build()` exceeds the app's 45 s budget → HTTP 400 "Build timed out" → app event loop wedged → recycled before next test |
| Client `TimeoutException` (55 s) | 4 | HTTP request to `/build` exceeds the client's 55 s ceiling |
| `/clear` HttpException | 1 | "Connection closed before full header was received" on the `/clear` roundtrip (wedged app) |

## File-by-file failures

| File | Failing script(s) | Cause |
| --- | --- | --- |
| base_06 | `material/buttonstyle_popup_test.dart` | build-timeout (45 s) |
| base_08 | `dart_ui/accessibility_features_test.dart` | build-timeout |
| base_11 | `material/snack_bar_action_test.dart` | build-timeout |
| base_12 | `rendering/keep_alive_parent_data_mixin_test.dart`, `rendering/render_editable_test.dart` | build-timeout (×2) |
| base_13 | `rendering/render_semantics_annotations_test.dart`, `rendering/render_shader_mask_test.dart` | build-timeout (×2) |
| base_15 | `widgets/animated_align_test.dart` | build-timeout |
| base_16 | `widgets/restorable_date_time_test.dart` | build-timeout |
| extended_02 | `dart_ui/backdrop_filter_engine_layer_test.dart` | build-timeout |
| extended_21 | `widgets/selection_overlay_test.dart`, `retest/widgets/lock_state_test.dart` | build-timeout (×2); `animation_max_test.dart` → client 55 s timeout |
| extended_22 | `widgets/autofill_group_test.dart`, `widgets/magnifier_decoration_test.dart` | client 55 s timeout (×2) |
| extended_23 | `material/toggle_buttons_theme_data_test.dart` (client 55 s), `widgets/nested_scroll_view_state_test.dart` (`/clear` HttpException + clear_failed) | mixed timeout |

## Non-failing framework errors

| File | Script | Errors |
| --- | --- | --- |
| base_06 | `painting/gradient_transform_test.dart` | 33 framework errors (test still passed) |

No `RenderFlex` overflows were recorded.

## Timeout-recovery validation

The wedge-recovery fix landed this run (commits `9b38d766a`, `149a578c1`,
`179dee28e`) behaved exactly as designed:

- A script that exhausts the 45 s build budget returns HTTP 400 / "Build
  timed out"; the runner detects the signal, **eagerly SIGKILLs the wedged
  app** (cheap, < 1 s), sets `_appNeedsRecycle`, and **defers the ~20 s reboot
  to the next test** so the failing test stays inside its 60 s budget.
- The next `send()` recycles (kill → wait port free → boot → `/clear`
  roundtrip verify) before building anything → that test and all subsequent
  tests in the file pass.
- Net effect: **17 wedges, 17 recoveries, 0 cascades** (vs the previous
  10-minute single-wedge cascade).

The same handling covers `/clear` and `/build` transport timeouts (kill
before diagnostics so `/logs` can't hang).
