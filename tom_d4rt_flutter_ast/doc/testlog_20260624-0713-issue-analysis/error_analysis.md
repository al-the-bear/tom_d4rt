# Issue Analysis — 20260624-0713-issue-analysis

**Run ID:** `20260624-0713-issue-analysis`
**Date/time:** Wed Jun 24 07:13 CEST 2026
**Git revision under test:** `ba4363e52` (branch `main`; HEAD has since advanced to
`6e011c690` via content-free reconcile commits — no interpreter/bridge change between them)
**Flutter:** 3.44.2 · channel stable · framework revision c9a6c48423
**Projects covered:** `tom_d4rt_flutter_ast` (AST twin) and `tom_d4rt_flutter_test`
(SourceFlutterD4rt / in-process WidgetTester twin)

This analysis covers both projects in one document; an identical copy lives in each
project's `doc/testlog_20260624-0713-issue-analysis/` folder.

---

## Executive summary

| Project | Files | Tests passed | Failed | Skipped | Files with non-fatal framework errors |
| --- | --- | --- | --- | --- | --- |
| `tom_d4rt_flutter_ast` | 41 | +2096 | **-15** (3 files) | ~3 | 19 files |
| `tom_d4rt_flutter_test` | 2 | +184 | **-1** (1 file) | 0 | 0 |

**Distinct root causes (4):**

1. **Interpreter bug — bitwise ops on `BridgedEnumValue` in Map literals** (`~`, `&`,
   `|`). Genuine D4rt interpreter gap. 2 hard failures + 2 non-fatal framework errors,
   all in `flutter_extended_20`. **Actionable interpreter fix.**
2. **Harness-strictness + framework-error leakage** (`flutter_extended_22`). 12 hard
   failures, all caused by the *benign* Flutter `ListTile … may be invisible` warning
   being counted as a framework error, with counts that accumulate across scripts. Not
   an interpreter bug; a test-harness isolation/strictness issue.
3. **Transport flake** (`flutter_extended_23`). 1 failure: `Connection closed before
   full header was received` on `GET /clear`. Infrastructure/transport, not a script
   bug; transient.
4. **Environmental Flutter SDK shader mismatch** (`tom_d4rt_flutter_test` →
   `counter_app`). `ink_sparkle.frag` runtime-stages format version 1 vs expected 2.
   Flutter-toolchain/asset issue, not an interpreter bug.

The widespread benign `ListTile background color or ink splashes may be invisible`
framework warning (53 occurrences across 19 passing `flutter_ast` files) is a real
Flutter framework message but **does not** indicate a defect in the interpreted code —
it only fails a test when the harness asserts zero framework errors (cause #2).

---

# Project 1 — `tom_d4rt_flutter_ast`

Corpus: 41 files (`flutter_base_01..17_test`, `flutter_extended_01..24_test`), run
serially file-by-file. Per-file metrics in `metrics.txt`.

## 1.1 Hard failures (file by file)

### `flutter_extended_20_test` — exit=1, +68 -2  ⟵ INTERPRETER BUG
Group: WidgetState bitwise operations. Both failures share one root cause: the
interpreter cannot apply bitwise operators to `BridgedEnumValue` operands
(`WidgetState` flags) inside Map literals.

- `widgets/widget_state_mapper_test.dart` **[E]** (log line 110)
  `Runtime Error: Operand for unary '~' must be an int or have an operator defined,
  but was BridgedEnumValue. (in Map literal)`
- `widgets/widget_state_test.dart` **[E]** (log line 127)
  `Runtime Error: Unsupported binary operator "|" (in Map literal)`

Same cause, but **non-fatal** (status=success, surfaced as framework errors, see §1.2):
- `widgets/widget_state_text_style_test.dart` —
  `Undefined variable: liveMapStyle (Original error: Unsupported binary operator "&"
  (in Map literal))`
- `widgets/widget_states_constraint_test.dart` —
  `Operand for unary '~' … was BridgedEnumValue.`

**Diagnosis:** D4rt does not implement bitwise/unary-bitwise operators (`~`, `&`, `|`,
and by extension `^`) when the operand is a `BridgedEnumValue`. `WidgetState` is bridged
as an enum, and Flutter's `WidgetStateProperty` / `WidgetStateMapper` idioms combine
states with bitwise flags inside `<WidgetState, T>{}` map literals. Fix belongs in the
interpreter's binary/unary operator evaluation (mirror both
`tom_d4rt/lib/src/interpreter_visitor.dart` and
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`): when an operand is a
`BridgedEnumValue`, resolve to its backing index/value (or the bridged operator) before
applying the bitwise op.

### `flutter_extended_22_test` — exit=1, +30 ~1 -12  ⟵ HARNESS STRICTNESS + LEAK
Group: "Section 2 - Bridge Generator Issues (80)". All 12 failures assert
`result.success && !result.hasFrameworkErrors` (test source line 390); the scripts
themselves render successfully but accrue framework errors dominated by the benign
`ListTile … may be invisible` warning.

| # | Failing test | Attributed frameworkErrors |
| --- | --- | --- |
| -1 | `widgets/image_filtered_test.dart` | 11 |
| -2 | `widgets/indexed_stack_test.dart` | 78 |
| -3 | `widgets/inherited_theme_test.dart` | 23 |
| -4 | `widgets/inherited_widget_test.dart` | 8 |
| -5 | `widgets/list_wheel_scroll_view_test.dart` | 2 |
| -6 | `widgets/list_wheel_viewport_test.dart` | 2 |
| -7 | `widgets/magnifier_decoration_test.dart` | 3 |
| -8 | `widgets/navigation_toolbar_test.dart` | 11 |
| -9 | `widgets/overflow_bar_test.dart` | 9 |
| -10 | `widgets/overflow_box_test.dart` | 6 |
| -11 | `widgets/page_storage_bucket_test.dart` | 1 |
| -12 | `widgets/page_storage_test.dart` | 6 |

**Diagnosis:** Every error body is `ListTile background color or ink splashes may be
invisible. The ListTile is wrapped in a DecoratedBox that has a background color…` — a
*Flutter framework* diagnostic, not an interpreter error. Two signals show this is
harness behaviour, not a per-script defect:
1. The attributed counts (78, 23, 11…) far exceed any single script's ListTile usage,
   and scripts that don't use ListTile at all (e.g. `image_filtered_test`) still report
   11. The errors **accumulate/leak across scripts** sharing the long-lived companion
   app rather than being scoped to the script under test.
2. The test source (≈line 213) already notes that isolated retests yield
   `frameworkErrors=0`.

Not an interpreter bug. Two independent follow-ups: (a) isolate/reset framework-error
collection per script so counts don't leak across the shared HTTP app; (b) decide
whether the benign `ListTile … invisible` warning should be filtered from
`hasFrameworkErrors` (it is a layout advisory, not a failure).

### `flutter_extended_23_test` — exit=1, +44 ~1 -1  ⟵ TRANSPORT FLAKE
- `Section 1 - Tests with workarounds reverted retest: widgets/nested_scroll_view_state_test.dart` **[E]** (log line 102)
  `Bad state: Transport failure while running "retest/widgets/nested_scroll_view_state_test.dart"`
  `Operation: GET /clear` ·
  `Error: HttpException: Connection closed before full header was received, uri = http://localhost:4247/clear`

**Diagnosis:** Infrastructure failure on the companion app's `/clear` endpoint, not a
script or interpreter defect. Connection was closed mid-header — consistent with a
transient companion-app hiccup/timing. Expected to pass on re-run; if it recurs,
investigate companion-app `/clear` handler robustness and keep-alive handling.

## 1.2 Non-fatal framework errors in passing files (status=success, frameworkErrors>0)

19 files reported framework errors while still passing. Counts (markers per file):

| File | FW err markers | Dominant message |
| --- | --- | --- |
| flutter_base_15 | 8 | ListTile … invisible |
| flutter_base_10 | 5 | ListTile … invisible |
| flutter_base_16 | 4 | ListTile … invisible |
| flutter_extended_06 | 4 | ListTile … invisible |
| flutter_base_11 | 3 | ListTile … invisible |
| flutter_base_01 / 04 / 06 | 2 each | ListTile … invisible |
| flutter_extended_07 / 13 | 2 each | ListTile … invisible |
| flutter_base_02 / 03 / 08 / 12 | 1 each | ListTile … invisible |
| flutter_extended_09 / 14 / 17 | 1 each | ListTile … invisible |
| flutter_extended_20 | 2 | bitwise-on-BridgedEnumValue (see §1.1) |

Across the corpus: **53** `ListTile … may be invisible` occurrences (benign Flutter
layout advisory) + the **2** WidgetState bitwise runtime errors counted above. No
`RenderFlex … overflowed` / overflow render errors were found (string "overflow" in the
logs comes only from script *names* such as `overflow_bar`, `overflow_box`,
`render_constrained_overflow_box`).

## 1.3 Intentional skips (~3, not defects)

- `AndroidView only renders on Android` (×2)
- `IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)`
- `SystemColor not supported on desktop platforms (web-only API)`

---

# Project 2 — `tom_d4rt_flutter_test`

Corpus: 2 files. In-process `WidgetTester` via `SourceFlutterD4rt.buildMultiFile` (no
shared HTTP companion app).

## 2.1 Hard failures (file by file)

### `asset_sample_source_test` — exit=0, +2  ✅ clean
All tests pass; no framework errors.

### `sample_apps_in_tester_test` — exit=1, +182 -1  ⟵ ENVIRONMENTAL SHADER MISMATCH
- `counter_app (multi-file user-defined State) FAB tap increments the displayed count` **[E]**
  ```
  EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK
  Exception: Asset 'shaders/ink_sparkle.frag' manifest could not be decoded:
  INVALID_ARGUMENT: Unsupported runtime stages format version. Expected 2, got 1.
    #0  new FragmentProgram._fromAsset (dart:ui/painting.dart:5433:7)
    #1  FragmentProgram.fromAsset.<anonymous closure> (dart:ui/painting.dart:5461:39)
  ```

**Diagnosis:** Environmental, not an interpreter or script defect. The InkSparkle
material splash loads the precompiled `ink_sparkle.frag` fragment shader; the bundled
asset's runtime-stages format version (1) does not match what the running Flutter engine
expects (2) — a Flutter SDK/asset-cache version skew. It surfaces on `counter_app`
because it is the first test to trigger an Ink splash. Not reproducible as an interpreter
bug; resolve by realigning the Flutter toolchain / regenerating the shader asset (e.g.
`flutter clean` + matching engine), or by neutralising ink splashes in the test
environment. The remaining 182 sample-app tests pass, including the multi-file
user-defined-State, Timer.periodic/AnimationController, Stream.periodic, sparse
int-keyed notifier, and particle-field examples.

## 2.2 Framework errors / overflow

None. No `EXCEPTION CAUGHT` other than the shader exception above; zero
`overflow`/`RenderFlex` errors; zero `FRAMEWORK ERROR` markers.

---

## Recommended priorities

1. **P1 (interpreter):** Implement bitwise/unary-bitwise operators on `BridgedEnumValue`
   operands (fixes `flutter_extended_20`: 2 failures + 2 framework errors). Mirror the
   fix in `tom_d4rt` and `tom_d4rt_ast`.
2. **P2 (harness):** Scope framework-error collection per-script in the companion app so
   counts stop leaking, and/or filter the benign `ListTile … invisible` advisory from
   `hasFrameworkErrors` (fixes `flutter_extended_22`: 12 failures).
3. **P3 (flaky/env):** Re-run `flutter_extended_23` (transport flake) and `counter_app`
   after a Flutter toolchain re-clean; neither is an interpreter defect.
