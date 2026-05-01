# Test Log 20260501-2237-issue-analysis — tom_d4rt_flutter_test

**Package:** `tom_d4rt_flutter_test` (source-based interpreter via `SourceFlutterD4rt`)
**Run id:** `20260501-2237-issue-analysis`
**Git rev:** `b4655940` (post E1→E5 walkthrough closure on `main`)
**Date:** captured 2026-05-01 23:47 → 2026-05-02 00:50 CEST (≈ 1 h 03 m wall-time)
**Interpreter:** `tom_d4rt` (source-based), `SourceFlutterD4rt`, port 4248
**Script corpus:** Shared with `tom_d4rt_flutter_ast` —
`send_ast_via_http_scripts/` plus retest/gii harnesses.

All 14 suites were run **serially** (shared HTTP test app on port 4248).

## Headline

**0 failures, 0 errors across 2189 tests in 14 suites.** Compared to
`testlog_20260501-0823-issue-analysis/error_analysis.md` (the May 1
morning baseline at 1 696 pass / 13 fail before Cluster D + E landed)
every previously failing script now passes. The 13 historic failures
(name-conflict ×2, GEN-094 ×2, super-formal forwards, retest E1–E5,
gii FE5 etc.) are all closed.

Three `⚠️ FRAMEWORK ERROR` events remain — none of them turns the
owning test red, but two are layout overflows in test scripts (same
class as the Cluster-D back_button_listener fix) and one is a real
interpreter bug. See *Open issues* below.

## Delta vs the May 1 morning baseline (`testlog_20260501-0823-issue-analysis`)

| Suite | 0823 | 2237 | Δ |
|---|---|---|---|
| essential | 108/0/0 | 108/0/0 | identical |
| important | 164/0/0 | 164/0/0 | identical |
| secondary | 653/1/0 (8 FE / 21 events) | **653/1/0 (0 FE)** | **−8 FE scripts** ✅ |
| hr1 | 203/2/0 | 203/2/0 | identical |
| hr2 | 202/0/1 | **203/0/0** | **+1 pass, −1 fail** (Cluster A) ✅ |
| hr3 | 201/0/0 | 201/0/0 | identical |
| hr4 | 227/0/0 | 227/0/0 (2 FE) | identical-pass; new FE noise classified below |
| hr5 | 229/0/1 | **230/0/0 (1 FE)** | **+1 pass, −1 fail** (Cluster A) ✅ |
| crashing | 4/0/0 | 4/0/0 | identical |
| timeout | 51/0/0 (2 FE / 4 events) | **51/0/0 (0 FE)** | **−2 FE scripts** ✅ |
| blocking | 5/0/0 | 5/0/0 | identical |
| gii | 73/2/8 (7 FE / 21 events) | **81/2/0 (0 FE)** | **+8 pass, −8 fail, −7 FE scripts** ✅ |
| retest | 50/5/3 (2 FE / 2 events) | **53/5/0 (0 FE)** | **+3 pass, −3 fail, −2 FE scripts** ✅ |
| interactive | 6/0/0 | 6/0/0 | identical |
| **total** | **2 176 / 10 / 13 (19 FE / 48 events)** | **2 189 / 10 / 0 (3 FE / 3 events)** | **+13 pass, −13 fail, −16 FE scripts, −45 FE events** ✅ |

The post-E walkthrough state on `main` resolves every previously open
test failure in this corpus.

## Cross-project comparison

The companion analysis for `tom_d4rt_flutter_ast` is at
`tom_d4rt_flutter_ast/doc/testlog_20260501-2237-issue-analysis/error_analysis.md`.
Both runtimes now produce identical pass/skip/fail counts across all
14 suites (2 189 / 10 / 0 each); only the FE-event distribution differs:

- `flutter_ast` has **1 FE** (network flake on `dart_ui/blur_style_test.dart`)
- `flutter_test` has **3 FE** (this run's three open items below)

This means the AST-driven runtime is now feature-parity with the
source-based one for the entire flutter-material corpus — which closes
the headline goal of the analyzer-free split tracked in the d4rt quest.

## Open issues (FE only — no test failures)

| # | Suite | Script | FE | Class | Recommended action |
|---|---|---|---|---|---|
| F2 | hr4 | `widgets/callback_shortcuts_test.dart` | 1 | RenderFlex overflow (63 px on bottom) | Test-script: wrap the offending `Column` in `SingleChildScrollView` (Cluster-D pattern) |
| F3 | hr4 | `widgets/child_back_button_dispatcher_test.dart` | 1 | RenderFlex overflow (21 px on bottom) | Same — test-script `SingleChildScrollView` wrap |
| F4 | hr5 | `widgets/snapshot_mode_test.dart` | 1 | Interpreter — `Runtime Error: Right operand of '&&' must be bool, got null` | **Real bug.** Triggers when the right operand of `&&` evaluates to `null` (likely a bridged getter returning `null` instead of `false`). Needs investigation in `interpreter_visitor.dart` `visitBinaryExpression` `&&` branch — currently throws on `null` operand instead of treating it per Dart's strict-bool rule. Mirror the fix in `tom_d4rt_ast`. |

F4 is the only candidate for an interpreter follow-up cluster (call it
Cluster G when picked up). F2/F3 are owned by the test-script layout
adjustments.

---

## Run summary

| Suite | Pass | Skip | Fail | FE scripts | FE total | JSON | Notes |
|---|---|---|---|---|---|---|---|
| `essential_classes_test` |  108 |   0 |   0 |   0 |    0 | ✓ | clean |
| `important_classes_test` |  164 |   0 |   0 |   0 |    0 | ✓ | clean |
| `secondary_classes_test` |  653 |   1 |   0 |   0 |    0 | ✓ | clean |
| `hardly_relevant_classes_1_test` |  203 |   2 |   0 |   0 |    0 | ✓ | clean |
| `hardly_relevant_classes_2_test` |  203 |   0 |   0 |   0 |    0 | ✓ | clean |
| `hardly_relevant_classes_3_test` |  201 |   0 |   0 |   0 |    0 | ✓ | clean |
| `hardly_relevant_classes_4_test` |  227 |   0 |   0 |   2 |    2 | ✓ | FE-only noise on 2 script(s) |
| `hardly_relevant_classes_5_test` |  230 |   0 |   0 |   1 |    1 | ✓ | FE-only noise on 1 script(s) |
| `crashing_tests_test` |    4 |   0 |   0 |   0 |    0 | ✓ | clean |
| `timeout_tests_test` |   51 |   0 |   0 |   0 |    0 | ✓ | clean |
| `blocking_tests_test` |    5 |   0 |   0 |   0 |    0 | ✓ | clean |
| `generator_interpreter_issues_test` |   81 |   2 |   0 |   0 |    0 | ✓ | clean |
| `generator_interpreter_retest_test` |   53 |   5 |   0 |   0 |    0 | ✓ | clean |
| `interactive_tests_test` |    6 |   0 |   0 |   0 |    0 | ✓ | clean |

**Totals:** 2189 pass / 10 skip / 0 fail — 3 FE script(s), 3 FE event(s).

---

## Per-suite details

### `essential_classes_test` — 108/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `important_classes_test` — 164/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `secondary_classes_test` — 653/1/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `hardly_relevant_classes_1_test` — 203/2/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `hardly_relevant_classes_2_test` — 203/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `hardly_relevant_classes_3_test` — 201/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `hardly_relevant_classes_4_test` — 227/0/0 + 2 FE script(s) (2 event(s))

#### Framework-error scripts (test status `success` despite FE)

| Script | FE count | METRIC status |
|---|---:|---|
| `widgets/callback_shortcuts_test.dart` | 1 | success |
| `widgets/child_back_button_dispatcher_test.dart` | 1 | success |

##### FE messages

- **`widgets/callback_shortcuts_test.dart`** (1 error(s)):

  ```text
  A RenderFlex overflowed by 63 pixels on the bottom.
  ```

- **`widgets/child_back_button_dispatcher_test.dart`** (1 error(s)):

  ```text
  A RenderFlex overflowed by 21 pixels on the bottom.
  ```

### `hardly_relevant_classes_5_test` — 230/0/0 + 1 FE script(s) (1 event(s))

#### Framework-error scripts (test status `success` despite FE)

| Script | FE count | METRIC status |
|---|---:|---|
| `widgets/snapshot_mode_test.dart` | 1 | success |

##### FE messages

- **`widgets/snapshot_mode_test.dart`** (1 error(s)):

  ```text
  Runtime Error: Right operand of '&&' must be bool, got null.
  ```

### `crashing_tests_test` — 4/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `timeout_tests_test` — 51/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `blocking_tests_test` — 5/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `generator_interpreter_issues_test` — 81/2/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `generator_interpreter_retest_test` — 53/5/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `interactive_tests_test` — 6/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.
