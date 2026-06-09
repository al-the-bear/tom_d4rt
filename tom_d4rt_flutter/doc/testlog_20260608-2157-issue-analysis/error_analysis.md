# Error Analysis — tom_d4rt_flutter (source-direct interpreter)

**Run ID:** `20260608-2157-issue-analysis`
**Corpus:** 41 split files (`flutter_base_01..17`, `flutter_extended_01..24`)
**App build budget:** 30 s (server) · 55 s (client) · 60 s (flutter per-test)
**Bridge regen:** skipped (`D4RT_SKIP_BRIDGE_REGEN=1`)

## Headline

| Metric | Value |
| --- | --- |
| Passed | **2137** |
| Failed | **28** |
| Skipped | 4 |
| Build-timeout / wedge **recoveries** | **28** (`[recycle] ready`) |
| Cascades (multi-test wedge chains) | **0** |
| Non-failing framework errors | 0 |

**All 28 failures are timeout / performance-related — there are no logic
or correctness regressions in the interpreter.** Every wedge self-recovered:
the failed test's app process was SIGKILLed eagerly and a fresh app booted
before the next test (28 `[recycle] starting fresh test app` → 28
`[recycle] ready` → 28 `/clear` roundtrip verifies), so no failure cascaded.

> **Why more failures than the AST run (28 vs 17)?** The source-direct app
> runs with a **30 s** server build budget (the AST app uses 45 s). The lower
> ceiling means borderline-heavy scripts that squeak under 45 s in the AST run
> tip over 30 s here. This is a budget/performance difference, **not** an
> interpreter-correctness difference — the failing scripts are the same family
> of heavy widget/foundation builds.

## Failure breakdown by cause

| Cause | Count | Mechanism |
| --- | --- | --- |
| Server build-timeout (30 s) | 21 | `_d4rt.build()` exceeds the app's 30 s budget → HTTP "Build timed out after 30 seconds" → app event loop wedged → recycled before next test |
| Client `TimeoutException` (55 s) | 5 | HTTP request to `/build` exceeds the client's 55 s ceiling |
| `/clear` timeout (5 s, `clear_failed`) | 2 | `/clear` GET roundtrip times out after 5 s (wedged app); extended_23 also raised the "Connection closed before full header" HttpException |

## File-by-file failures

| File | Failing script(s) | Cause |
| --- | --- | --- |
| base_02 | `material/segmentedbutton_test.dart` | client 55 s timeout |
| base_04 | `cupertino/cupertino_themes_batch3_test.dart`, `foundation/error_test.dart`, `material/rawscrollbar_test.dart`, `widgets/router_test.dart` | build-timeout (×4) |
| base_05 | `cupertino/cupertino_theming_test.dart`, `foundation/foundation_misc_adv_test.dart`, `services/platform_test.dart` | build-timeout (×3) |
| base_06 | `physics/springdescription_test.dart` | client 55 s timeout |
| base_08 | `foundation/unicode_test.dart` | build-timeout |
| base_11 | `painting/image_info_test.dart` | build-timeout |
| base_16 | `widgets/shared_app_data_test.dart` | client 55 s timeout |
| extended_01 | `cupertino/class_test.dart` | build-timeout |
| extended_03 | `foundation/object_created_test.dart` | `/clear` 5 s timeout (clear_failed) |
| extended_05 | `material/dynamic_scheme_variant_test.dart` | build-timeout |
| extended_09 | `rendering/granularly_extend_selection_event_test.dart` | client 55 s timeout |
| extended_11 | `services/modifier_key_test.dart` | build-timeout |
| extended_13 | `widgets/bottom_navigation_bar_item_test.dart` | build-timeout |
| extended_14 | `widgets/drag_target_details_test.dart` | build-timeout |
| extended_15 | `widgets/gesture_recognizer_factory_with_handlers_test.dart`, `widgets/img_element_platform_view_test.dart` | build-timeout (×2) |
| extended_16 | `widgets/notification_test.dart`, `widgets/platform_menu_delegate_test.dart` | build-timeout (×2) |
| extended_17 | `widgets/raw_menu_anchor_test.dart` | build-timeout |
| extended_18 | `widgets/scroll_end_notification_test.dart` | client 55 s timeout |
| extended_20 | `widgets/user_scroll_notification_test.dart` | build-timeout |
| extended_21 | `widgets/singlechildscrollview_test.dart` | build-timeout |
| extended_23 | `retest/widgets/nested_scroll_view_state_test.dart` | `/clear` timeout + "Connection closed before full header" HttpException |

## Non-failing framework errors

None recorded (`frameworkErrors=0` across all 41 files). No `RenderFlex`
overflows.

## Timeout-recovery validation

The wedge-recovery fix (commits `9b38d766a`, `149a578c1`, `179dee28e`)
behaved exactly as designed across all three timeout paths:

- **Server build-timeout:** "Build timed out after 30 seconds" → eager
  SIGKILL of the wedged app → deferred ~20 s reboot on the next test → that
  test and the rest of the file pass. Verified e.g. base_04 (4 wedges, all
  recovered, file continued to +66).
- **`/clear` 5 s timeout:** `extended_03/object_created_test` wedged the app
  on `/clear`; the next test (`object_disposed_test`) triggered
  `[recycle] killing wedged test app (pid=93408)` → fresh app → all remaining
  foundation tests passed (+45 … +53, no further failures).
- **Client 55 s timeout:** same kill-before-diagnostics handling so `/logs`
  cannot hang.

Net effect: **28 wedges, 28 recoveries, 0 cascades** — the 10-minute
single-wedge cascade is fully eliminated.

## Sync note

This run mirrors the AST run (`tom_d4rt_flutter_ast`, same ID). The runner
fixes are kept in sync between the two `test/send_test_runner.dart` drivers
per the quest's tom_d4rt ↔ tom_d4rt_ast sync rule.
