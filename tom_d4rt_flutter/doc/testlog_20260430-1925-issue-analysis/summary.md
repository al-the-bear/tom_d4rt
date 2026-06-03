# Test Log — tom_d4rt_flutter_test

**Date:** 2026-04-30  
**Time started:** ~19:10  
**Interpreter:** Source-based (`tom_d4rt` v1.x via `SourceFlutterD4rt`, port 4248)  
**Script corpus:** Shared with `tom_d4rt_flutter_ast` — `send_ast_via_http_scripts/`

## Overview

This is the first full run of the new parallel test suites in `tom_d4rt_flutter_test`.
The suites mirror those in `tom_d4rt_flutter_ast` (AST-based, port 4247) and test
the same scripts against the **source-based** `tom_d4rt` interpreter.

---

## Suite Results

| Suite | Passed | Skipped | Failed | Total | Duration | Status |
|-------|--------|---------|--------|-------|----------|--------|
| essential_classes | 108 | 0 | 0 | 108 | 2:48 | ✅ ALL PASS |
| important_classes | 163 | 0 | 1 | 164 | 3:36 | ⚠️ 1 failure |
| secondary_classes | 161 | 0 | 39 | 200+ | 80+ min (PARTIAL) | ⚠️ PARTIAL (stopped) |
| blocking_tests (W1-W5) | 5 | 0 | 0 | 5 | 0:39 | ✅ ALL PASS |
| crashing_tests | 4 | 0 | 0 | 4 | 0:17 | ✅ ALL PASS |
| interactive_tests | 6 | 0 | 0 | 6 | 0:27 | ✅ ALL PASS |
| generator_interpreter_issues | 60 | 2 | 21 | 83 | 2:34 | ⚠️ expected failures |
| generator_interpreter_retest | 37 | 5 | 16 | 58 | 1:46 | ⚠️ expected failures |
| hardly_relevant_classes 1–5 | — | — | — | 1322 | not run | — |
| timeout_tests | — | — | — | 51 | not run | — |

**Note:** `secondary_classes_test` was stopped after 80 min due to excessive 30-second
timeouts (individual scripts that hang). The 161 scripts that completed all passed;
39 entries failed (33 timeouts + 6 build errors). This matches the pattern seen in the
AST package. The `hardly_relevant_classes` and `timeout_tests` suites were not run in
this session due to time constraints.

---

## Suite Details

### essential_classes_test — ✅ 108/108 PASS

All 108 tests pass. The essential bridge corpus is fully functional in the source-based
interpreter.

---

### important_classes_test — ⚠️ 163/164 (1 failure)

**Failure:**
```
dart_ui/paragraph_test.dart
Runtime Error: Cannot access property 'runtimeType' on target of type _NativeParagraph.

Stack trace:
  #0  InterpreterVisitor.visitPrefixedIdentifier (interpreter_visitor.dart:1214:7)
```

**Root cause:** `.runtimeType` is accessed via string interpolation on a `_NativeParagraph`
object (returned by `ui.ParagraphBuilder.build()`). Native/bridged instances cannot
expose `.runtimeType` through the interpreter's property lookup. This is a known
limitation (also fails in the AST package under the same conditions).

**All other 163 tests pass**, including:
- Material batch 1 (7) + batch 2 (8) + batch 3 (22): ✅
- Widgets batch 1 (23) + batch 2 (21) + batch 3 (20): ✅
- Cupertino (10): ✅
- Painting (8): ✅
- Animation (5): ✅
- Physics (1): ✅
- Foundation (3): ✅
- dart_ui (5/6 — paragraph fails): ⚠️
- Gestures (2): ✅
- Services (8): ✅
- Semantics (1): ✅
- Scheduler (1): ✅
- Rendering (11): ✅
- Proxies (5): ✅

---

### secondary_classes_test — ⚠️ PARTIAL (stopped after 80 min)

The secondary suite has 654 test entries. After 80 minutes, only ~200 entries
completed. The remaining are blocked by 30-second timeouts (individual widget scripts
that hang the test app's /build handler).

**Partial results (of ~200 run):**
- 161 passed
- 33 timed out (TimeoutException after 30s)
- 6 build errors (dart_ui: advanced, misc_adv, accessibility_features, display,
  flutter_view, gesture_settings)
- Frameworks errors: sliver_types, sliver_advanced, table_wrap_flow, layout_builder_adv

The timeout/error pattern mirrors the AST package. This suite requires the structural
test-app watchdog or timeout-handling improvements before it can complete in one run.

---

### blocking_tests_test (W1-W5) — ✅ 5/5 PASS

All 5 formerly-wedging scripts pass when run in isolation:
- W1: context_action_test.dart ✅
- W2: default_text_editing_shortcuts_test.dart ✅
- W3: live_text_input_status_test.dart ✅
- W4: lock_state_test.dart ✅
- W5: animated_switcher_test.dart ✅

---

### crashing_tests_test — ✅ 4/4 PASS

All 3 scripts that previously crashed the test app pass in isolation:
- widgets/directionality_test.dart ✅
- widgets/extend_selection_to_line_break_intent_test.dart ✅
- widgets/display_feature_sub_screen_test.dart ✅
(Plus app health check: 4 total)

---

### interactive_tests_test — ✅ 6/6 PASS

All interaction-based tests pass:
- showDialog + OK button tap ✅
- showBottomSheet + Share tap ✅
- showMenu + Option A tap ✅
- dismiss modal via barrier tap ✅
- showDatePicker + Cancel ✅
- showTimePicker + Cancel ✅

---

### generator_interpreter_issues_test — ⚠️ 60/83 (21 fail, 2 skip)

**Context:** These tests are **known failures** — scripts that require generator or
interpreter fixes before they can pass. Failures are expected here.

Skipped (2): android_view_test.dart (non-Android), animated_switcher_test.dart (W5 skip)

Failures (21) — all BUILD ERRORs (pre-existing generator/interpreter issues):
- widgets/render_object_to_widget_adapter_test.dart
- widgets/render_tree_root_element_test.dart
- widgets/restorable_enum_n_test.dart
- widgets/route_information_test.dart
- widgets/route_pop_disposition_test.dart
- widgets/scroll_position_alignment_policy_test.dart
- widgets/scroll_view_keyboard_dismiss_behavior_test.dart
- widgets/select_action_test.dart
- material/scaffold_messenger_test.dart
- rendering/box_hit_test_result_test.dart
- widgets/restorable_enum_test.dart
- widgets/restorable_text_editing_controller_test.dart
(+9 more)

Passing (60): The remaining 60 scripts from the GII corpus now pass in the source
interpreter, demonstrating that most GII cluster fixes have been successfully applied.

---

### generator_interpreter_retest_test — ⚠️ 37/58 (16 fail, 5 skip)

**Context:** These are original (un-workarounded) script versions that are expected
to fail until underlying generator/interpreter issues are fixed.

Skipped (5): W1 (context_action), W2 (default_text_editing_shortcuts), W3
(live_text_input_status), W4 (lock_state), and one platform-specific test.

Failures (16) — all BUILD ERRORs:
- retest/material/bottom_navigation_bar_type_test.dart
- retest/material/button_bar_theme_test.dart
- retest/rendering/over_scroll_header_stretch_configuration_test.dart
- retest/widgets/redo_text_intent_test.dart
- retest/widgets/regular_window_controller_{delegate,linux,mac_o_s,test,win32}_test.dart
- retest/widgets/regular_window_test.dart
- retest/widgets/render_abstract_layout_builder_mixin_test.dart
- retest/widgets/render_tap_region_surface_test.dart
- retest/widgets/replace_text_intent_test.dart
- retest/widgets/request_focus_action_test.dart

Passing (37): 37 of the retest-corpus scripts now pass in the unworkarounded form,
indicating the underlying issues were fixed by previous cluster fixes.

---

## Key Findings vs. AST Package

| Area | Source (tom_d4rt) | AST (tom_d4rt_ast) | Match |
|------|-------------------|---------------------|-------|
| essential_classes | 108/108 | 108/108 | ✅ |
| important_classes | 163/164 | 163/164 | ✅ (same paragraph failure) |
| blocking_tests W1-W5 | 5/5 | 5/5 | ✅ |
| crashing_tests | 4/4 | 4/4 | ✅ |
| interactive_tests | 6/6 | 6/6 | ✅ |

The source-based interpreter (`tom_d4rt`) performs equivalently to the AST-based
interpreter (`tom_d4rt_ast`) on all completed suites. The single failure
(`dart_ui/paragraph_test.dart` — runtimeType on _NativeParagraph) is pre-existing
in both packages.

---

## Remaining Work

1. **secondary_classes**: Needs test-app watchdog / timeout handling before full run
   is practical. 654 tests, many 30-second timeouts. Partial results: 161 pass, 6 error.
2. **hardly_relevant_classes 1–5**: ~1322 tests total, not run this session.
3. **timeout_tests**: 51 known-slow tests, not run this session.
4. **dart_ui/paragraph_test**: Fix `.runtimeType` access on bridged native objects
   (affects both packages equally).
5. **GII failures (21)** and **retest failures (16)**: These are pre-existing issues
   tracked in `interpreter_issues.md`.
