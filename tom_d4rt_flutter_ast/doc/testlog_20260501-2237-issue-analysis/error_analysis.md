# Test Log 20260501-2237-issue-analysis — tom_d4rt_flutter_ast

**Package:** `tom_d4rt_flutter_ast` (analyzer-free AST runtime via `FlutterD4rt`)
**Run id:** `20260501-2237-issue-analysis`
**Git rev:** `b4655940` (post E1→E5 walkthrough closure on `main`)
**Date:** captured 2026-05-01 22:38 → 23:48 CEST (≈ 1 h 10 m wall-time)
**Interpreter:** `tom_d4rt_ast` (AST-driven), port 4248
**Script corpus:** Shared with `tom_d4rt_flutter_test` —
`send_ast_via_http_scripts/` plus retest/gii harnesses.

All 14 suites were run **serially** (shared HTTP test app on port 4248).

## Headline

**0 failures, 0 errors across 2189 tests in 14 suites.** Compared to the
April baselines (`testlog_20260430-1925-issue-analysis/summary.md` for
flutter_ast: 1 696 pass / 13 fail) every previously failing script now
passes. The Cluster A/B/C/D/E fixes that landed between Apr 30 and the
E1→E5 walkthrough have stabilised the AST runtime to functional parity
with the source-based `tom_d4rt` runtime.

The single remaining `⚠️ FRAMEWORK ERROR` on the AST side is a **network
flake** (HTTP 400 from `picsum.photos`), not an interpreter regression —
see *Open issues* below.

## Cross-project comparison

| Suite | flutter_ast (this run) | flutter_test (this run) | Δ |
|---|---|---|---|
| essential | 108/0/0 | 108/0/0 | identical |
| important | 164/0/0 | 164/0/0 | identical |
| secondary | 653/1/0 | 653/1/0 | identical |
| hr1       | 203/2/0 (1 FE) | 203/2/0 | flutter_ast +1 FE (network) |
| hr2       | 203/0/0 | 203/0/0 | identical |
| hr3       | 201/0/0 | 201/0/0 | identical |
| hr4       | 227/0/0 | 227/0/0 (2 FE) | flutter_test +2 FE (RenderFlex overflow) |
| hr5       | 230/0/0 | 230/0/0 (1 FE) | flutter_test +1 FE (interpreter `&&`) |
| crashing  | 4/0/0   | 4/0/0   | identical |
| timeout   | 51/0/0  | 51/0/0  | identical |
| blocking  | 5/0/0   | 5/0/0   | identical |
| gii       | 81/2/0  | 81/2/0  | identical |
| retest    | 53/5/0  | 53/5/0  | identical |
| interactive | 6/0/0 | 6/0/0   | identical |
| **total** | **2189 / 10 / 0** | **2189 / 10 / 0** | **fully aligned** |

The two runtimes now produce identical pass/skip/fail counts across all
suites. Only the FE noise differs in distribution.

## Open issues (FE only — no test failures)

| # | Project | Suite | Script | FE | Class | Disposition |
|---|---|---|---|---|---|---|
| F1 | flutter_ast | hr1 | `dart_ui/blur_style_test.dart` | 1 | Network flake | External — `picsum.photos` returned HTTP 400 |
| F2 | flutter_test | hr4 | `widgets/callback_shortcuts_test.dart` | 1 | RenderFlex overflow (63 px) | Test-script layout |
| F3 | flutter_test | hr4 | `widgets/child_back_button_dispatcher_test.dart` | 1 | RenderFlex overflow (21 px) | Test-script layout |
| F4 | flutter_test | hr5 | `widgets/snapshot_mode_test.dart` | 1 | Interpreter — `&&` operand null | Real runtime bug |

Only **F4** is a true interpreter concern; F1 is external; F2/F3 are the
same class as the Cluster-D `back_button_listener` fix
(SingleChildScrollView wrap on the offending Column).

---

## Run summary

| Suite | Pass | Skip | Fail | FE scripts | FE total | JSON | Notes |
|---|---|---|---|---|---|---|---|
| `essential_classes_test` |  108 |   0 |   0 |   0 |    0 | ✓ | clean |
| `important_classes_test` |  164 |   0 |   0 |   0 |    0 | ✓ | clean |
| `secondary_classes_test` |  653 |   1 |   0 |   0 |    0 | ✓ | clean |
| `hardly_relevant_classes_1_test` |  203 |   2 |   0 |   1 |    1 | ✓ | FE-only noise on 1 script(s) |
| `hardly_relevant_classes_2_test` |  203 |   0 |   0 |   0 |    0 | ✓ | clean |
| `hardly_relevant_classes_3_test` |  201 |   0 |   0 |   0 |    0 | ✓ | clean |
| `hardly_relevant_classes_4_test` |  227 |   0 |   0 |   0 |    0 | ✓ | clean |
| `hardly_relevant_classes_5_test` |  230 |   0 |   0 |   0 |    0 | ✓ | clean |
| `crashing_tests_test` |    4 |   0 |   0 |   0 |    0 | ✓ | clean |
| `timeout_tests_test` |   51 |   0 |   0 |   0 |    0 | ✓ | clean |
| `blocking_tests_test` |    5 |   0 |   0 |   0 |    0 | ✓ | clean |
| `generator_interpreter_issues_test` |   81 |   2 |   0 |   0 |    0 | ✓ | clean |
| `generator_interpreter_retest_test` |   53 |   5 |   0 |   0 |    0 | ✓ | clean |
| `interactive_tests_test` |    6 |   0 |   0 |   0 |    0 | ✓ | clean |

**Totals:** 2189 pass / 10 skip / 0 fail — 1 FE script(s), 1 FE event(s).

---

## Per-suite details

### `essential_classes_test` — 108/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `important_classes_test` — 164/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `secondary_classes_test` — 653/1/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `hardly_relevant_classes_1_test` — 203/2/0 + 1 FE script(s) (1 event(s))

#### Framework-error scripts (test status `success` despite FE)

| Script | FE count | METRIC status |
|---|---:|---|
| `dart_ui/blur_style_test.dart` | 1 | success |

##### FE messages

- **`dart_ui/blur_style_test.dart`** (1 error(s)):

  ```text
  HTTP request failed, statusCode: 400, https://picsum.photos/800/400?blur=0
  ```

### `hardly_relevant_classes_2_test` — 203/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `hardly_relevant_classes_3_test` — 201/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `hardly_relevant_classes_4_test` — 227/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

### `hardly_relevant_classes_5_test` — 230/0/0 + 0 FE script(s) (0 event(s))

Result: **clean** — no failures, no framework errors.

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
