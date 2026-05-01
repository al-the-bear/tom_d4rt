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

**Status: FIXED (2026-05-01).** All 6 scripts now pass; gii went from
`+73 ~2 -8` to `+80 ~2 -1` (one remaining failure is the unrelated
Cluster C `_AnchorDelegate` issue).

Affected suite: `gii` (6). Same scripts emit FEs in `secondary` without failing.

| Script | Error |
|--------|-------|
| `widgets/layout_builder_adv_test.dart` | `Cannot access property 'height' on target of type null` |
| `rendering/relayout_when_system_fonts_change_mixin_test.dart` | `Undefined variable: constraints` |
| `rendering/render_absorb_pointer_test.dart` | `Cannot invoke method 'constrainWidth' on null` |
| `rendering/render_aligning_shifted_box_test.dart` | `Cannot access property 'smallest' on null` |
| `rendering/render_box_container_defaults_mixin_test.dart` | `Cannot access property 'width' on null` |
| `widgets/parent_data_widget_test.dart` | `Cannot access property 'height' on null` |

**Root cause:** Two distinct sub-clusters with overlapping symptoms:

1. **Sub-cluster 1 — bridged-mixin getter type-check failure on
   `constraints`** (4 of 6 scripts: `relayout_when_system_fonts_change_mixin`,
   `render_absorb_pointer`, `render_aligning_shifted_box`,
   `render_box_container_defaults_mixin`). The bridged-mixin
   adapter rejected the proxy because the proxy class did not
   actually mix-in the mixin (proxies are pre-built with a fixed
   mixin whitelist). The dispatch then fell to the RC-9 callback
   no-op which returns `null`. **Fix:** tolerant fall-through on
   `ArgumentD4rtException` in `Instance.get` — when a bridged-mixin
   getter rejects the proxy target, walk up to the bridged-super
   chain (e.g. `RenderBox`) which accepts the cast.

2. **Sub-cluster 2 — bridged-super method dispatch missed
   `nativeProxy`** (`layout_builder_adv`, `parent_data_widget`).
   `_InterpretedMultiChildLayoutDelegate` is a hand-written proxy
   `extends MultiChildLayoutDelegate` set as `instance.nativeProxy`.
   `Instance.get`'s bridged-super dispatch condition required
   `bridgedSuperObject != null || nativeStateProxy != null` — it
   excluded `nativeProxy`, so `layoutChild()` fell through to the
   RC-9 callback no-op returning `null`. The script then accessed
   `headerSize.height` on null and crashed. **Fix:** mirror
   `tom_d4rt_ast`'s pattern — `nativeTarget = bridgedSuperObject ??
   nativeProxy`, `getterTarget = nativeTarget ?? nativeStateProxy`.

**Files changed:**

- `tom_ai/d4rt/tom_d4rt/lib/src/runtime_types.dart` — both
  sub-cluster fixes (mirroring `tom_d4rt_ast` patterns).
- `tom_ai/d4rt/tom_d4rt_ast/lib/src/runtime/runtime_types.dart` —
  sub-cluster 1 tolerant fall-through (sub-cluster 2 was already
  correct in this side).

**Regression check (after fix):**

| Suite | Before | After | Δ |
|-------|--------|-------|---|
| `gii` | +73 ~2 -8 | +80 ~2 -1 | +7 / −7 |
| `essential` | +108/0/0 | +108/0/0 | ✅ |
| `important` | +164/0/0 | +164/0/0 | ✅ |
| `secondary` | +653 ~1 | +653 ~1 | ✅ |

---

### Cluster C — Missing required named argument in `_AnchorDelegate` (1 test failure)

**Status: FIXED (2026-05-01).** gii went from `+80 ~2 -1` to `+81 ~2 -0`.

Affected suite: `gii` (1). Same script emits FE in `secondary` and `timeout`.

| Script | Error |
|--------|-------|
| `rendering/render_custom_single_child_layout_box_test.dart` | `Error during constructor execution for class '_AnchorDelegate': Missing required named argument for 'config'` |

**Root cause:** Super-formal forwards (Bug-96) were not merged into
the explicit super-call argument list when the super constructor
was an *interpreted* class. The script:

```dart
abstract class _BaseDelegate extends SingleChildLayoutDelegate {
  _BaseDelegate({required this.config, required this.modeName});
  final _DelegateConfig config;
}

class _AnchorDelegate extends _BaseDelegate {
  _AnchorDelegate({required super.config}) : super(modeName: 'anchor');
}
```

When `_AnchorDelegate(config: ...)` ran, the super-formal `super.config`
was correctly collected into `superNamedForwards`, but the explicit
`super(modeName: 'anchor')` only forwarded `modeName` to
`_BaseDelegate`'s constructor — `config` was dropped, so
`_BaseDelegate`'s required `config` parameter was missing.

The bug existed in both `tom_d4rt` and `tom_d4rt_ast` `callable.dart`
in the `dartSuperClass != null` branch of `SuperConstructorInvocation`
handling. The bridged-super branch (line 782 in tom_d4rt) and the
implicit-super-call branch (line 952) were already correctly
merging the forwards; only the explicit-Dart-super branch was
missing the merge.

**Fix:** in both interpreters, prepend `superPositionalForwards`
to the explicit positional args and merge `superNamedForwards`
into the explicit named args (`putIfAbsent` so explicit values
win over forwards if both are supplied — though in valid Dart
they cannot overlap by name).

**Files changed:**

- `tom_ai/d4rt/tom_d4rt/lib/src/callable.dart` — explicit-super
  Dart branch now merges forwards.
- `tom_ai/d4rt/tom_d4rt_ast/lib/src/runtime/callable.dart` —
  same fix mirrored.

**Regression check (after fix):**

| Suite | Before (post-Cluster-B) | After | Δ |
|-------|------------------------|-------|---|
| `gii` | +80 ~2 -1 | +81 ~2 -0 | +1 / −1 |
| `essential` | 108/0/0 | 108/0/0 | ✅ |
| `important` | 164/0/0 | 164/0/0 | ✅ |
| `secondary` | 653 ~1 | 653 ~1 | ✅ |

---

### Cluster D — Retest-specific failures (2 test failures) — ✅ FIXED

Affected suite: `retest` (2).

| Script | Error | Status |
|--------|-------|--------|
| `retest/dart_ui/key_event_type_test.dart` | `Undefined property or method 'label' on bridged instance of 'Key'` | ✅ Fixed |
| `retest/widgets/back_button_listener_test.dart` | `A RenderFlex overflowed by 10.0 pixels on the bottom` (FE causes expectSuccess to fail) | ✅ Fixed |

**`key_event_type_test` — Root cause:** Not a missing bridge getter. The bridges in
`dart_ui_bridges.b.dart` already register `KeyEventType.label` and
`KeyEventDeviceType.label` correctly. The actual bug was in
`Environment.getBridgedEnumValue` / `findBridgedEnumForValue`: when a script does
`import 'dart:ui' as ui`, the `dart:ui` bridges (including its `BridgedEnum`
registrations) are stored in a per-prefix sibling environment under
`_prefixedImports['ui']`, **not** on the `_enclosing` chain. The visitor's
Cluster-26 fallback (in `visitPropertyAccess` / `visitPrefixedIdentifier`) calls
`getBridgedEnumValue` which walks `_bridgedEnums.values` then recurses to
`_enclosing` only — it never visited `_prefixedImports`. As a result, when
`ui.KeyEventType.down` was wrapped by the G-DCLI-05 prefix-match as
`BridgedInstance(bridgedClass=Key)`, the fallback couldn't recover the proper
`BridgedEnumValue` and the throw fired with the misleading
`'on bridged instance of Key'` message.

**Fix:** Updated `Environment.getBridgedEnumValue` and
`Environment.findBridgedEnumForValue` to also walk `_prefixedImports.values`
before recursing to `_enclosing`. Also added an early-return guard
`if (value is! Enum) return null;` to both methods — `runtime_types.dart`
calls `getBridgedEnumValue` for any non-null bridged-super getter result
(e.g. `BuildContext` returned from `Element.context`); without the guard the
new prefix-import walk could traverse cycles in the import graph and trigger
a Stack Overflow for non-enum values (caught the regression on
`widgets/inherited_theme_test.dart` / `inherited_widget_test.dart` and the
three rendering tests in gii). Also adjusted the four visitor fallback sites
to call `environment.getBridgedEnumValue(enumObj)` first (with
`globalEnvironment` as a fallback) so the lookup starts from the active scope
chain. Mirrored across:

- `tom_d4rt/lib/src/environment.dart` — early-return guard + prefix-import walk
- `tom_d4rt/lib/src/interpreter_visitor.dart` (lines ~1001 and ~4126) — use
  `environment` first, then `globalEnvironment`
- `tom_d4rt_ast/lib/src/runtime/environment.dart` — early-return guard +
  prefix-import walk
- `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` (lines ~1157 and
  ~4787) — use `environment` first, then `globalEnvironment`

**`back_button_listener_test` — Root cause:** Test-script-only layout overflow
(10 px on the bottom) inside `_InterceptionStudio.build()`'s outer
`Padding > Column`. At 1280×720 the column's children (header section + 3 panels
+ back-button-listener row + cheat-sheet panel) demanded slightly more vertical
space than the available stage budget after header + toolbar + footer.

**Fix:** Wrapped the outer `Column` of `_InterceptionStudio.build()` in a
`SingleChildScrollView` so the body can exceed the stage budget without
producing a `RenderFlex` overflow. Test-script-only change (regression rule a:
no regression-suite run required for the layout fix; the interpreter fix above
does require regression coverage which has been run).

**Regression check (post-fix, both interpreter + script changes — logs in
`testlog_20260501-cluster-d/`):**

| Suite | Before (Cluster C) | After Cluster D | Δ |
|-------|-------------------|-----------------|---|
| `gii` | 81/2/0 | 81/2/0 | ✅ no change |
| `retest` | 51/5/2 (post Cluster A) | **53/5/0** | +2 pass, −2 fail (Cluster D scripts) |
| `essential` | 108/0/0 | 108/0/0 | ✅ no change |
| `important` | 164/0/0 | 164/0/0 | ✅ no change |
| `secondary` | 653/1/0 | 653/1/0 | ✅ no change |

The first run of `gii` initially regressed by 5 tests (3 rendering + 2
`InheritedWidget`-style scripts) due to a Stack-Overflow caused by the new
prefix-import recursion in `getBridgedEnumValue` being invoked for non-enum
values from `runtime_types.dart` (bridged-super getter results). The
early-return guard `if (value is! Enum) return null;` was added to both
`getBridgedEnumValue` and `findBridgedEnumForValue` in both interpreters; this
restored gii to 81/2/0 and is reflected in the fix description above.

---

## Framework errors (FE) — non-fatal noise

Scripts that produce `⚠️  FRAMEWORK ERROR` output but still **pass** the test
(status=success):

| Script | Suites where FE appears | Total FE | Status (post-fix) |
|--------|------------------------|----------|-------------------|
| `rendering/render_box_container_defaults_mixin_test.dart` | secondary, timeout | 3+3=6 | ✅ FE cleared (Cluster B fix) |
| `rendering/render_absorb_pointer_test.dart` | secondary | 5 | ✅ FE cleared (Cluster B fix) |
| `rendering/relayout_when_system_fonts_change_mixin_test.dart` | secondary | 4 | ✅ FE cleared (Cluster B fix) |
| `rendering/render_aligning_shifted_box_test.dart` | secondary | 3 | ✅ FE cleared (Cluster B fix) |
| `widgets/layout_builder_adv_test.dart` | secondary | 2 | ✅ FE cleared (Cluster B fix) |
| `widgets/parent_data_widget_test.dart` | secondary | 2 | (covered by Cluster B fix) |
| `rendering/render_custom_single_child_layout_box_test.dart` | secondary, timeout | 1+1=2 | (covered by Cluster C fix) |
| `retest/widgets/back_button_listener_test.dart` | timeout, retest | 1+1=2 | (covered by Cluster D fix) |
| `widgets/restorable_value_test.dart` | secondary | 1 | open |

The `relayout_when_system_fonts_change_mixin`, `render_absorb_pointer`,
`render_aligning_shifted_box`, `render_box_container_defaults_mixin`, and
`parent_data_widget` FEs are all the same Cluster B null-constraints issue — the
scripts build a widget (status=success) but some render path emits a runtime error
during paint/layout.

`restorable_value_test.dart`: `Cannot access property 'inMilliseconds' on null` —
isolated to secondary, 1 FE, test still passes.

---

### Cluster E — FE5 verification + Cluster-D follow-up Stack Overflow — ✅ FIXED

**Status: FIXED (2026-05-01).** The first 5 FE-emitting scripts in the table
above (`render_box_container_defaults_mixin`, `render_absorb_pointer`,
`relayout_when_system_fonts_change_mixin`, `render_aligning_shifted_box`,
`layout_builder_adv`) were re-run individually after the Cluster B/C/D fixes had
landed and **all five now report `frameworkErrors=0`**. The 17 FE emissions they
were responsible for in the original 0823 secondary run are gone — the
runtime_types.dart fixes for sub-cluster-1 (bridged-mixin getter fall-through to
bridged-super) and sub-cluster-2 (bridged-super dispatch consulting `nativeProxy`)
removed the null-constraints crash both at the gii test-failure call sites *and*
along the paint/layout call sites that were producing the FE noise in secondary.

**Follow-up regression discovered: `dart_ui/pointer_data_test.dart` Stack Overflow.**
The Cluster D fix (prefix-import walk in `Environment.getBridgedEnumValue` /
`findBridgedEnumForValue`) introduced a new infinite-recursion path on this script,
which heavily exercises bridged enum lookup via `switch (ui.PointerChange value)`
and `switch (ui.PointerDeviceKind value)`. The early-return guard
`if (value is! Enum) return null;` from Cluster D protects against non-enum
probes from `runtime_types.dart`, but for *enum* values the new prefix-import
walk could traverse cycles in the env graph: `shallowCopyFiltered`
(used by `module_loader.dart` when defining a prefixed import) preserves both
`_enclosing` and the source env's `_prefixedImports` map, so a prefixed env's
`_enclosing` chain can lead back into an env that already contains it via
`_prefixedImports`. With many enum lookups happening per frame during switch
evaluation, this exploded into Stack Overflow.

**Fix:** Added a `Set<Environment> visited` cycle-breaker to both
`getBridgedEnumValue` and `findBridgedEnumForValue`. Each public entry point now
seeds a fresh visited set and delegates to a private `_*Impl` that bails out
when it re-enters an env already on the path. The lookup completes in linear
time across the unique reachable envs.

**Files changed:**

- `tom_d4rt/lib/src/environment.dart` — split `getBridgedEnumValue` /
  `findBridgedEnumForValue` into public entry + private `_*Impl` with visited set.
- `tom_d4rt_ast/lib/src/runtime/environment.dart` — same fix mirrored.

**Verification (logs in `testlog_20260501-fe5/`):**

| Script | Before fix | After fix |
|--------|-----------|-----------|
| `widgets/layout_builder_adv_test.dart` | FE=2 (orig 0823) | **FE=0** ✅ |
| `rendering/relayout_when_system_fonts_change_mixin_test.dart` | FE=4 (orig 0823) | **FE=0** ✅ |
| `rendering/render_absorb_pointer_test.dart` | FE=5 (orig 0823) | **FE=0** ✅ |
| `rendering/render_aligning_shifted_box_test.dart` | FE=3 (orig 0823) | **FE=0** ✅ |
| `rendering/render_box_container_defaults_mixin_test.dart` | FE=3 (orig 0823) | **FE=0** ✅ |
| `dart_ui/pointer_data_test.dart` | FE=1 Stack Overflow (post Cluster D) | **FE=0** ✅ |

**Regression check (post-fix):**

| Suite | Before (Cluster D) | After Cluster E | Δ |
|-------|-------------------|-----------------|---|
| `gii` | 81/2/0 | **81/2/0** | ✅ no change |
| `retest` | 53/5/0 | **53/5/0** | ✅ no change |
| `essential` | 108/0/0 | **108/0/0** | ✅ no change |
| `important` | 164/0/0 | **164/0/0** | ✅ no change |
| `secondary` | 653/1/0 (1 FE: pointer_data Stack Overflow) | **653/1/0 (0 FE)** | ✅ FE cleared |

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
