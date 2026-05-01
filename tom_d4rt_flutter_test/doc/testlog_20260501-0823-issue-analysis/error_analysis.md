# Test Log 20260501-0823 — Issue Analysis

**Package:** `tom_d4rt_flutter_test` (source-based interpreter via `SourceFlutterD4rt`)
**Run id:** `20260501-0823-issue-analysis`
**Git rev:** `b1e52974` (fix: reversed subtype check, proxy visitor, GEN-100c prefix types)
**Date:** Thu May 1 — run captured 08:23 → 15:34 CEST 2026
**Total wall time:** ≈ 7 h 11 m (14 suites, fully serial)
**Interpreter:** `tom_d4rt` (source-based), `SourceFlutterD4rt`, port 4248
**Script corpus:** Shared with `tom_d4rt_flutter_ast` — `send_ast_via_http_scripts/`

This run captures the state **after** three interpreter fixes landed in `b1e52974`:
1. **Reversed subtype check** (`visitReturnStatement`) — `valueRuntimeType.isSubtypeOf(declaredType)`
   was inverted; now correct.
2. **Visitor passthrough** in `SourceFlutterD4rt.build` / `execute` — `D4.unwrapAs<T>` now
   receives `visitor: _interpreter.visitor` so InterpretedInstance proxy resolution works
   after `execute()` returns.
3. **GEN-100c: import-prefixed type annotations** — `_resolveTypeAnnotationWithEnvironment`
   and `visitInstanceCreationExpression` now handle `ui.PointerData`, `prefix.ClassName()`
   correctly by prepending the import prefix to the type-lookup key.

All 14 suites were run **serially** with `D4RT_SKIP_BRIDGE_REGEN=1`.

---

## Run summary

| Suite | Pass | Skip | Fail | FE scripts | FE total | Notes |
|---|---|---|---|---|---|---|
| `essential_classes_test`             | 108 |  0 |  0 |  0 |   0 | clean |
| `important_classes_test`             | 164 |  0 |  0 |  0 |   0 | clean — paragraph.runtimeType fixed ✓ |
| `secondary_classes_test`             | 653 |  1 |  0 |  8 |  21 | passes; FE noise on 8 rendering/widget scripts |
| `hardly_relevant_classes_1_test`     | 203 |  2 |  0 |  0 |   0 | clean |
| `hardly_relevant_classes_2_test`     | 202 |  0 |  1 |  0 |   0 | 1 name-conflict failure |
| `hardly_relevant_classes_3_test`     | 201 |  0 |  0 |  0 |   0 | clean |
| `hardly_relevant_classes_4_test`     | 227 |  0 |  0 |  0 |   0 | clean |
| `hardly_relevant_classes_5_test`     | 229 |  0 |  1 |  0 |   0 | 1 name-conflict failure |
| `generator_interpreter_issues_test`  |  73 |  2 |  8 |  7 |  21 | 8 open failures (see clusters) |
| `generator_interpreter_retest_test`  |  50 |  5 |  3 |  2 |   2 | 3 failures (see clusters) |
| `crashing_tests_test`                |   4 |  0 |  0 |  0 |   0 | clean |
| `timeout_tests_test`                 |  51 |  0 |  0 |  2 |   4 | clean |
| `blocking_tests_test`                |   5 |  0 |  0 |  0 |   0 | clean |
| `interactive_tests_test`             |   6 |  0 |  0 |  0 |   0 | clean |

**True test failures across all suites: 13** (0 cascade, all distinct scripts).

---

## Delta vs April 30 baseline (`testlog_20260430-1925-issue-analysis/summary.md`)

| Suite | Apr 30 | May 1 | Delta |
|---|---|---|---|
| `important_classes_test`            | 163/0/1 | **164/0/0** | +1 pass (paragraph.runtimeType) |
| `generator_interpreter_issues_test` | 60/2/21 | **73/2/8**  | +13 pass, -13 fail |
| `generator_interpreter_retest_test` | 37/5/16 | **50/5/3**  | +13 pass, -13 fail |
| `secondary_classes_test`            | partial / crashed | **653/1/0** | fully working |
| `hr1–hr5, blocking, crashing, etc.` | not run | all pass/clean | first full run |

Fixes in `b1e52974` account for all +27 recovered passes.

---

## Failure clusters

### Cluster A — Name conflict (2 scripts, 4 test failures) — **FIXED**

Affected suites: `gii` (1), `retest` (1), `hr2` (1), `hr5` (1).

| Script | Error | Suite | Status |
|--------|-------|-------|--------|
| `widgets/restorable_enum_n_test.dart` | `Name conflict: 'Locale' (bridged class) is already defined` | gii, hr5 | ✅ pass |
| `material/button_bar_theme_data_test.dart` | `Name conflict: 'ButtonBarTheme' (bridged class) is already defined` | hr2 | ✅ pass |
| `retest/material/button_bar_theme_test.dart` | `Name conflict: 'ButtonBarTheme' (bridged class) is already defined` | retest | ✅ pass |

**Actual root cause:** The two scripts each declare a *local* type that shadows
a bridged class from the imported library:

- `restorable_enum_n_test.dart` declares `enum Locale { en, es, fr, de, ja, zh }`
  at top level while also importing `package:flutter/material.dart` (which
  re-exports `dart:ui`'s bridged `Locale` class).
- `button_bar_theme_data_test.dart` and `retest/.../button_bar_theme_test.dart`
  declare a local `class ButtonBarTheme extends StatelessWidget { ... }` (shim
  for the deprecated bridged widget) while also importing
  `package:flutter/material.dart` (which still re-exports the deprecated
  bridged `ButtonBarTheme` class).

Local declarations land in `_values` via `DeclarationVisitor.visitEnumDeclaration`
/ `visitClassDeclaration` (`environment.define(...)`). When the script's import
directives are processed afterwards, `Environment.importEnvironment` walks the
imported bridged-class registry and finds the slot already occupied — so it
threw `Name conflict in environment: Symbol '<X>' (bridged class) is already
defined.` This is **not** Dart-correct: per Dart import semantics, an unprefixed
local declaration must always shadow an imported name with the same identifier.

**Fix applied:**
`tom_d4rt/lib/src/environment.dart` (lines 934–941) and the mirror
`tom_d4rt_ast/lib/src/runtime/environment.dart` (lines 997–1006): when an
imported `BridgedClass` (or `BridgedEnum`) finds the target name already taken
by a local `_values` / `_bridgedEnums` / `_prefixedImports` entry, the import is
silently skipped (instead of throwing) — local wins, matching Dart import
semantics. Type-based bridge lookups continue to work via
`_bridgedClassesLookupByType` which is populated independently.

**Verification:**
- Isolated re-runs of all 4 affected tests: ✅ pass
  (`cluster_a_fix/{restorable_enum_n_isolated,button_bar_theme_data_hr2_isolated,button_bar_theme_retest_isolated,restorable_enum_n_hr5_isolated}.log.txt`)
- Affected suite re-runs (logs in `cluster_a_fix/`):
  - `gii`: 73/2/8 → **74/2/7** (+1 pass, -1 fail)
  - `retest`: 50/5/3 → **51/5/2** (+1 pass, -1 fail)
  - `hr2`: 202/0/1 → **203/0/0** ✅
  - `hr5`: 229/0/1 → **230/0/0** ✅
- Regression suites (per rule (b) — interpreter changed):
  - `essential_classes_test`: **108/0/0** (unchanged)
  - `important_classes_test`: **164/0/0** (unchanged)
  - `secondary_classes_test`: **653/1/0** (unchanged)

**Status: fixed.** No follow-up issues observed; both interpreter copies
(`tom_d4rt`, `tom_d4rt_ast`) updated.

---

### Cluster B — Null constraints in interpreted RenderBox subclasses (6 test failures)

Affected suite: `gii` (6). Same scripts emit FEs in `secondary` without failing.

| Script | Error |
|--------|-------|
| `widgets/layout_builder_adv_test.dart` | `Cannot access property 'height' on target of type null` |
| `rendering/relayout_when_system_fonts_change_mixin_test.dart` | `Undefined variable: constraints` |
| `rendering/render_absorb_pointer_test.dart` | `Cannot invoke method 'constrainWidth' on null` |
| `rendering/render_aligning_shifted_box_test.dart` | `Cannot access property 'smallest' on null` |
| `rendering/render_box_container_defaults_mixin_test.dart` | `Cannot access property 'width' on null` |
| `widgets/parent_data_widget_test.dart` | `Cannot access property 'height' on null` |

**Root cause:** Script-defined `RenderBox` subclasses access `this.constraints` or
properties derived from it (`.width`, `.height`, `.smallest`, etc.) inside
`performLayout()`. In the interpreter, `constraints` is a bridged getter on the native
`RenderBox`; when the mixin chain or dispatch misroutes the call, the getter returns
`null` instead of a `BoxConstraints` object.

The same scripts pass in `secondary_classes_test` (where the interpreter runs in a
slightly different calling context) but fail in `gii` where the test expectation checks
the rendered output directly. In `secondary` they show up as FE noise:
- `widgets/layout_builder_adv_test.dart`: 2 FE
- `rendering/relayout_when_system_fonts_change_mixin_test.dart`: 4 FE
- `rendering/render_absorb_pointer_test.dart`: 5 FE
- `rendering/render_aligning_shifted_box_test.dart`: 3 FE
- `rendering/render_box_container_defaults_mixin_test.dart`: 3 FE
- `widgets/parent_data_widget_test.dart`: 2 FE

**Pre-existing** cluster. Fix: ensure mixin getter dispatch for `constraints` in
interpreted `RenderBox` subclasses resolves to the bridged native getter.

---

### Cluster C — Missing required named argument in `_AnchorDelegate` (1 test failure)

Affected suite: `gii` (1). Same script emits FE in `secondary` and `timeout`.

| Script | Error |
|--------|-------|
| `rendering/render_custom_single_child_layout_box_test.dart` | `Error during constructor execution for class '_AnchorDelegate': Missing required named argument for 'config'` |

**Root cause:** The script defines `_AnchorDelegate` with a required named parameter
`config`. The interpreter calls the constructor from somewhere without passing `config`.
This is either a missing named-constructor disambiguation or a required-parameter
validation gap in the interpreter.

**Pre-existing** cluster. 1 FE in `secondary`, 1 FE in `timeout`.

---

### Cluster D — Retest-specific failures (2 test failures)

Affected suite: `retest` (2).

| Script | Error |
|--------|-------|
| `retest/dart_ui/key_event_type_test.dart` | `Undefined property or method 'label' on bridged instance of 'Key'` |
| `retest/widgets/back_button_listener_test.dart` | `A RenderFlex overflowed by 10.0 pixels on the bottom` (FE causes expectSuccess to fail) |

**`key_event_type_test`:** `Key` (from `dart:ui`) is bridged but the `label` property
is not exposed in the bridge. Pre-existing; needs a `label` getter added to the `Key`
bridge.

**`back_button_listener_test`:** A layout overflow (RenderFlex +10 px) causes a
framework error that the test's `expectSuccess()` detects as failure. The overflow is
a scripted layout issue (fixed height container too small on the test device). The
`back_button_listener` script was also in the known-failures list of the April 30 run.

---

## Framework errors (FE) — non-fatal noise

Scripts that produce `⚠️  FRAMEWORK ERROR` output but still **pass** the test
(status=success):

| Script | Suites where FE appears | Total FE |
|--------|------------------------|----------|
| `rendering/render_box_container_defaults_mixin_test.dart` | secondary, timeout | 3+3=6 |
| `rendering/render_absorb_pointer_test.dart` | secondary | 5 |
| `rendering/relayout_when_system_fonts_change_mixin_test.dart` | secondary | 4 |
| `rendering/render_aligning_shifted_box_test.dart` | secondary | 3 |
| `widgets/layout_builder_adv_test.dart` | secondary | 2 |
| `widgets/parent_data_widget_test.dart` | secondary | 2 |
| `rendering/render_custom_single_child_layout_box_test.dart` | secondary, timeout | 1+1=2 |
| `retest/widgets/back_button_listener_test.dart` | timeout, retest | 1+1=2 |
| `widgets/restorable_value_test.dart` | secondary | 1 |

The `relayout_when_system_fonts_change_mixin`, `render_absorb_pointer`,
`render_aligning_shifted_box`, `render_box_container_defaults_mixin`, and
`parent_data_widget` FEs are all the same Cluster B null-constraints issue — the
scripts build a widget (status=success) but some render path emits a runtime error
during paint/layout.

`restorable_value_test.dart`: `Cannot access property 'inMilliseconds' on null` —
isolated to secondary, 1 FE, test still passes.

---

## Comparison with `tom_d4rt_flutter_ast` (May 1 run)

| Suite | Source (tom_d4rt) | AST (tom_d4rt_ast) | Match |
|-------|-------------------|--------------------|-------|
| `essential_classes_test`  | 108/0/0 | 108/0/0 | ✅ |
| `important_classes_test`  | 164/0/0 | 164/0/0 | ✅ |
| `secondary_classes_test`  | 653/1/0 | 654/1/0 | ✅ (1 test diff — corpus variants) |
| `hr1`                     | 203/2/0 | 205/2/0 | ✅ (2 test diff — corpus variants) |
| `hr2`                     | 202/0/1 | 203/0/0 | ⚠️ hr2 name-conflict unique to source |
| `hr3`                     | 201/0/0 | 201/0/0 | ✅ |
| `hr4`                     | 227/0/0 | 227/0/0 | ✅ |
| `hr5`                     | 229/0/1 | 230/0/0 | ⚠️ hr5 Locale-conflict unique to source |
| `gii`                     |  73/2/8 |  81/2/0 | ⚠️ 8 source-only failures (Cluster B/C) |
| `retest`                  |  50/5/3 |  54/5/4 | ✅ (similar; source has fewer pre-existing) |
| `crashing_tests`          |   4/0/0 |   4/0/0 | ✅ |
| `timeout_tests`           |  51/0/0 |  51/0/0 | ✅ |
| `blocking_tests`          |   5/0/0 |   5/0/0 | ✅ |
| `interactive_tests`       |   6/0/0 |   6/0/0 | ✅ |

**Key divergences** (source vs AST):
- **Cluster A name conflicts (hr2, hr5)** appear in source but not AST — the AST-based
  interpreter resolves the conflict differently (likely because bridge registration is
  handled differently in the AST runner's `finalizeBridges` path).
- **Cluster B/C (gii, 8 failures)** appear in source but not AST — these are interpreting
  script-defined RenderBox subclasses with mixin dispatch; the AST path may handle
  mixin getter resolution differently.
- **retest 3 vs 4** — AST has 4 retest failures, source has 3; the difference is one
  pre-existing failure present in AST but already fixed in source (`render_animated_size`
  or similar).

---

## Open issues (actionable)

| ID | Cluster | Script(s) | Error | Priority |
|----|---------|-----------|-------|----------|
| ~~E1~~ | ~~A~~ | restorable_enum_n, button_bar_theme(_data) | ~~Name conflict on re-import~~ — **fixed** (importEnvironment now skips imports shadowed by local declarations) | — |
| E2 | B | layout_builder_adv, render_absorb_pointer, etc. (6 scripts) | Null constraints in interpreted RenderBox | Medium |
| E3 | C | render_custom_single_child_layout_box | Missing named arg `config` in `_AnchorDelegate` | Low |
| E4 | D | key_event_type | `Key.label` not in bridge | Low |
| E5 | D | back_button_listener | RenderFlex overflow 10px → expectSuccess fail | Low |

Total open: **5 distinct issues** covering 13 test failures and ≈21 FE emissions.
