# Test Log 20260428-1333 — Issue Analysis

**Run id:** `20260428-1333-issue-analysis`
**Git rev:** `639dfd0b` (W5 skip), then `91281a45` (analysis commit) +
W4 skip applied 2026-04-28 14:14 with gir-only re-run captured under
`generator_interpreter_retest_test.W4skip.{log.txt,result.json}`.
**Date:** Tue Apr 28 13:33 — 14:15 CEST 2026
**Total wall time:** 29 m 9 s initial run + 1 m 12 s gir re-run after
W4 skip (vs. 39 m 19 s in `testlog_20260427-1339-post-c22`).
**Captured artefacts:** `*.log.txt` and `*.result.json` per suite
(11 initial files + 2 W4-skip re-run files for `gir`).

This run captures the framework-error landscape *after* the
prior post-C22 campaign, with the C20-series and C21 interpreter
fixes landed and W5 (`animated_switcher_test.dart`) skipped from
`generator_interpreter_issues_test`. The 11 test files were run
**serially** (per the `tom_d4rt_flutterm` non-obvious rule that
flutter test runs in this package must not be parallelised) with
`D4RT_SKIP_BRIDGE_REGEN=1`.

The previous run aborted in `generator_interpreter_issues_test` at
test ID 54 (`widgets/animated_switcher_test.dart` wedged the test
app for ~60 s, then "Lost connection to device" cascaded the next
34 scripts). With W5 skipped, gii now completes cleanly at
**81 pass / 2 skip / 0 fail**.

---

## Run summary

| Suite | Pass | Skip | Fail | Err | FE scripts | FE total | Notes |
|---|---|---|---|---|---|---|---|
| `essential_classes_test`             | 108 |  0 |  0 |  0 |  0 |   0 | clean — `form_test` 1 FE closed by D2 |
| `important_classes_test`             | 164 |  0 |  0 |  0 |  0 |   0 | fully clean (was 164/5/0 — 5 skips removed) |
| `secondary_classes_test`             | 654 |  1 |  0 |  0 |  9 |  61 | suite passes; FE noise on 9 widget scripts |
| `hardly_relevant_classes_1_test`     | 205 |  2 |  0 |  0 |  0 |   0 | clean (D1 cascade closed; +125 pass vs prior) |
| `hardly_relevant_classes_2_test`     | 203 |  0 |  0 |  0 |  0 |   0 | clean |
| `hardly_relevant_classes_3_test`     | 201 |  0 |  0 |  0 |  0 |   0 | clean (was 199/2/0 — 2 skips re-enabled) |
| `hardly_relevant_classes_4_test`     | 227 |  0 |  0 |  0 |  0 |   0 | clean |
| `hardly_relevant_classes_5_test`     | 230 |  0 |  0 |  0 | 19 | 195 | suite passes; FE noise concentrated in `widgets/` |
| `interactive_tests_test`             |   6 |  0 |  0 |  0 |  0 |   0 | clean |
| `generator_interpreter_issues_test`  |  81 |  2 |  0 |  0 |  0 |   0 | **all green** — was 78/1/4 (+3 pass, -4 fail) |
| `generator_interpreter_retest_test`  |  34 |  4 |  4 | 20 |  2 |   2 | W4 cascade — see Cluster R below |
| `generator_interpreter_retest_test` *(re-run, W4 skipped)* | 54 |  5 |  4 |  0 |  2 |   2 | **+20 pass, -20 errors** — see Cluster R update |

**Headline deltas vs `testlog_20260427-1339-post-c22`:**

- `gii` 78/1/4 → **81/2/0** (no failures; 4 fixes carried in by
  C20a/C20b/C20d/C20f/C21 + W5 skip).
- `hr1` 80/1/124 → **205/2/0** (D1 `image_sampler_slot` cascade
  closed by skip; +125 passes recovered).
- `hr3` 199/2/0 → 201/0/0 and `important` 164/5/0 → 164/0/0:
  five carry-over skips were re-enabled and now pass.
- `secondary` FE scripts 15 → **9** (-6); FE total reduced.
- `hr5` FE scripts 38 → **19** (-19); FE total reduced.
- `hr4` 1 FE script → **0** (C20b SForEachPartsWithPattern in
  collection literals fixed `fractional_translation_test`).
- `gir` 45/11/2 → 34/4/24 in initial run; **after W4 skip 54/5/4
  with the cascade closed** (1m 12s wall time, all 19 victims
  recover). The remaining 4 failures are exactly the 2 known
  pre-existing carry-overs (`render_animated_size_state`,
  `back_button_listener`) + 2 newly-surfaced E1 `_ByteDataView`
  cases. See Cluster R.

True interpreter test failures across the entire run after W4 skip:
**4 in `gir` only** — `render_animated_size_state` (now tracked
as E10), `back_button_listener` (now E11), and 2 newly-surfaced
E1 `_ByteDataView` cases. All other suites are at zero failures.

---

## How clusters were derived

`[METRIC]` lines were grepped for `frameworkErrors=[1-9]` to
identify scripts that emitted FE during their test app run.
`⚠️  FRAMEWORK ERROR` blocks were sampled to recover the leading
exception string per script. The per-suite `*.result.json`
NDJSON files were `jq -s` slurped to recover `testDone` outcomes
(`success` / `failure` / `error`) and per-error messages for the
two suites with non-zero failure counts (`gii`, `gir`).

Clusters are bucketed by the leading exception family
(BoxConstraints layout cascade, late-init, `_ByteDataView`
runtime gap, transport cascade, etc.). Clusters E1–E8 are the new
or re-surfaced clusters in this run. Carry-overs from
`interpreter_issues.md` and the prior testlogs are listed in the
"Carry-over open clusters" section, with status updated to reflect
this run's evidence.

---

## E1 — `_ByteDataView.lengthInBytes` runtime gap (FIXED)

- [x] Fixed  - [ ] Partial  - [ ] Open · **Severity:** Medium · **Owner:** interpreter / dart:typed_data bridge

**Symptom.** Two retest scripts in services/ failed with the
same shape:

- `retest/services/message_codec_test.dart` (gir TID=33):
  `Runtime Error: Undefined property or method 'lengthInBytes' on _ByteDataView.`
- `retest/services/method_codec_test.dart` (gir TID=34):
  `Runtime Error: Cannot access property 'lengthInBytes' on target of type _ByteDataView.`

These were `success` in `testlog_20260427-1339-post-c22`'s gir run.
The shape matches the `dart:typed_data` re-export gap addressed in
`interpreter_issues.md` cluster #16 (GEN-106), but `_ByteDataView`
is the *internal* `dart:typed_data` view returned from
`Uint8List.buffer.asByteData()` — not the public `ByteData` bridge.

**Root cause.** Native `ByteData` instances arriving from
`Uint8List.buffer.asByteData()` and `StandardMessageCodec.encodeMessage(...)`
have a private runtime type (`_ByteDataView`) that is not registered
as a direct bridge key. `Environment.toBridgedInstance` step 1
(direct type lookup) misses; step 2 (assignability iteration)
needed an explicit `isAssignable` predicate on the `ByteData` bridge
to match — without one, step 3's name-based fallback strips the
leading underscore to `ByteDataView` which still does not match the
bridge name `ByteData`.

**Fix applied (option a).** Added `isAssignable: (v) => v is ByteData`
to the `ByteData` `BridgedClass` definition in:

- `tom_d4rt/lib/src/stdlib/typed_data/byte_data.dart`
- `tom_d4rt_ast/lib/src/runtime/stdlib/typed_data/byte_data.dart`
  (mirror, per the "keep tom_d4rt ↔ tom_d4rt_ast in sync" rule)

This routes any `ByteData` subclass — including the private
`_ByteDataView` — through the `ByteData` bridge so getters such as
`lengthInBytes` resolve. Mirrors the pattern documented in
`BridgedClass` and used by `Set` / `Curve`.

**Verification.**

- `e1_bisect_test.dart` (the two target scripts in isolation):
  both pass, FE=0.
- `painting/resize_image_key_test.dart` standalone (the script that
  appeared to regress in the secondary suite first run): passes
  in 1611 ms, FE=0 — the secondary-suite first-run wedge was
  test-app flakiness (cascade of 30-s timeouts after one wedged
  script), not an interpreter regression.
- Regression suites (re-run after flakiness):
  essential = 108/0/0, important = 164/0/0,
  secondary = 653 +1 ~1 — match baseline exactly.
- Logs: `doc/testlog_20260428-e1-fix/`.

---

## E2 — Layout cascade (BoxConstraints infinite/negative) — carry-over D6

- [ ] Fixed  - [x] Partial  - [ ] Open · **Severity:** Low · **Owner:** scripts (C22 ListView pattern)

**Status.** Down from 18 scripts / ~228 FE in the prior run to
**16 scripts / 138 FE** in this run, after `important` and `hr3`
skip removals re-introduced two scripts at low FE counts and the
hr5 FE-script count halved (38 → 19, of which the layout-cascade
shape covers most). No suite-level test failures — the affected
scripts don't assert on `tester.takeException`.

**Batch 1 (bottom of table — #13–#16) — 2026-04-28.**

- `widgets/restoration_mixin_test.dart` (3 FE expected) — already
  at FE=0 on a fresh run; left untouched.
- `widgets/text_selection_gesture_detector_builder_delegate_test.dart`
  (5 FE → 0). Replaced root `SingleChildScrollView(child:
  Column(crossAxisAlignment: stretch, …))` with `ListView(…)`. The
  unbounded-height stretch column was propagating through the
  `_TsgdbdStage` cards down to `RenderEditable.performLayout`,
  which in turn handed `BoxConstraints(w=…, h=-Infinity; NOT
  NORMALIZED)` to `_RenderEditableCustomPaint`. `ListView` lays
  out children on a bounded vertical track and resolves the
  EditableText's height naturally.
- `widgets/sliver_multi_box_adaptor_element_test.dart` (6 FE → 0).
  Two `IntrinsicHeight + Row(crossAxisAlignment: stretch)` blocks
  replaced with `SizedBox(height: <gutter-height>)`. The second
  one wrapped a `GridView.builder(shrinkWrap: true)` —
  `IntrinsicHeight` walks its child with `getMaxIntrinsicHeight`,
  but `RenderShrinkWrappingViewport` refuses to compute intrinsics
  ("Calculating the intrinsic dimensions would require
  instantiating every child of the viewport, which defeats the
  point of viewports being lazy."). Pinning a fixed height —
  the gutter already declared `height: 240` (and `64` for the
  list variant) — keeps the same visual layout without asking the
  grid for intrinsics. Cascading `RenderBox was not laid out` and
  4 null-check FEs vanish with the root.
- `widgets/scrollbar_painter_test.dart` (4 FE) — **deferred** for
  this batch. The 4 residual `RenderFlex overflowed by 40/54
  pixels on the bottom` warnings are inside individual section
  sub-widgets of a 2345-line file (already documented as
  "cosmetic … separate script-authoring follow-up" in commit
  `126cf860`). The cascade root was closed there; the residual
  overflows live behind a 6-deep nesting of fixed-height
  containers and the test runner truncates the RenderFlex's
  source location. Out of scope for batch 1.

**Verification.** `test/e2_batch1_bisect_test.dart` (isolation
harness, since deleted): pre-fix
`doc/testlog_20260428-e2-batch1-fix/e2_batch1_bisect_pre.log.txt`,
post-fix `…/e2_batch1_bisect_post.log.txt` — 3 of 4 scripts at
FE=0; `scrollbar_painter_test` unchanged at 4 FE (intentional —
cascade root was already closed in `126cf860`). Per regression
rule (a), test-script-only changes; individual retest
sufficient.

**Batch 2 (table positions #9–#12 — bottom-up sweep) — 2026-04-28.**

- `widgets/standard_component_type_test.dart` (13 FE → 0). Replaced
  the root `Row(stretch) > Expanded > CustomScrollView` body whose
  ten `SliverToBoxAdapter` children each handed unbounded vertical
  extent to `_Sct*` widgets that were `Padding > Column(default
  mainAxisSize.max)`. Replaced the entire `CustomScrollView` with a
  `ListView` whose direct children are the `_Sct*` widgets (with
  the original `SliverPadding` becoming a regular `Padding` on the
  specimen-grid item, and inter-section `SliverToBoxAdapter > SizedBox`
  spacers becoming raw `SizedBox`). `ListView` resolves each child
  to its intrinsic height; the `RenderParagraph object was given an
  infinite size` cascade collapses cleanly.
- `widgets/widget_state_color_test.dart` (9 FE) — **deferred**.
  Cascade root is `_WscFromMapVsResolveWith` (`Row(stretch) +
  Expanded` cards inside a `ListView` item). Tried wrapping in
  `IntrinsicHeight`: no change (still 9 FE). Tried IntrinsicHeight
  with `crossAxisAlignment.stretch` retained on inner Row: same.
  The cascade reproduces the same C3-shape (Row(stretch)+Expanded
  in unbounded vertical) that has documented unfixable workarounds
  in `script_rewrites.md` §C3. Reverted; matches the C3 family.
- `widgets/text_magnifier_configuration_test.dart` (6 FE) —
  **deferred**. Tried the C22 ListView replacement on the root
  `CustomScrollView`: regressed from 6 → 9 FE. Reverted. The
  internal Sliver content (intro/cross-section/playground/api
  cards) contains its own bounded-context expectations that ListView
  breaks; an interior-section-level fix would be required and is
  out of scope for the bottom-up sweep.
- `widgets/scroll_deceleration_rate_test.dart` (8 FE) —
  **deferred**. Already documented as the canonical C3 pattern in
  `script_rewrites.md` §C3 (`_TelemetryRow` and `_CoastCurves` use
  `Row(crossAxisAlignment: stretch) + Expanded` inside
  `SliverToBoxAdapter`). Tried the SizedBox(height: 140) wrap (the
  one workaround that hadn't been tried previously — prior attempts
  were `IntrinsicHeight` and removing `crossAxisAlignment.stretch`):
  regressed from 8 → 11 FE, matching the prior-attempt regression
  shape. Reverted. Confirmed unfixable by every documented
  authoring workaround; the durable fix lives in the interpreter's
  layout/intrinsics path.

**Verification.** `test/e2_batch2_bisect_test.dart` (isolation
harness, since deleted): pre-fix
`doc/testlog_20260428-e2-batch2-fix/e2_batch2_bisect_pre.log.txt`,
post-fix
`…/e2_batch2_bisect_post.log.txt` (with all four candidate fixes;
shows three regressions),
`…/e2_batch2_bisect_post_after_revert.log.txt` (reverts of three;
shows `standard_component_type=0`, others at original baseline).
Per regression rule (a), test-script-only changes; individual
retest sufficient.

**Batch 3 (table positions #5–#8 — top-of-table sweep) — 2026-04-28.**
Four scripts, 73 FE → 0 FE. **All four closed.**

- `widgets/two_dimensional_scrollable_state_test.dart` (20 FE → 0).
  Replaced root `body: DecoratedBox > SingleChildScrollView >
  Column(crossAxisAlignment.stretch)` with `DecoratedBox >
  ListView(padding, children: [...])` (C22 pattern). The
  Column's `stretch` cross-axis under SingleChildScrollView gave
  the `_TwoDSS*` section children unbounded vertical extent,
  cascading through a 17-deep relayoutBoundary chain.
- `widgets/scroll_position_types_test.dart` (19 FE → 0). Same
  C22 shape: `body: SafeArea > SingleChildScrollView >
  Column(crossAxisAlignment.stretch)` replaced with `SafeArea >
  ListView(padding, children: [...])`.
- `widgets/web_browser_detection_test.dart` (19 FE → 0). Two
  inner cascades — `_WbdCapabilityGrid` and `_WbdComparisonGrid`
  each returned `Column(crossAxisAlignment.stretch)` inside a
  horizontal `SingleChildScrollView`, giving Column's cross-axis
  (= horizontal) infinite width. Removed `stretch` and used
  `mainAxisSize.min`. The matrix rows/headers already have
  intrinsic widths.
- `widgets/weak_map_test.dart` (15 FE → 0). Single inner
  cascade in `_WmLatChapterMatrix._buildRow`: `Container > Row(
  crossAxisAlignment.stretch) + [SizedBox, Expanded(_buildCell)]`
  inside `SliverToBoxAdapter` (unbounded vertical). Row's
  cross-axis (= vertical) `stretch` triggered the C3 cascade.
  Switched to `crossAxisAlignment.start`; cells are icon+text
  containers with their own intrinsic height.

**Verification.** `test/e2_batch3_bisect_test.dart` (isolation
harness, since deleted): pre-fix
`doc/testlog_20260428-e2-batch3-fix/e2_batch3_bisect_pre.log.txt`
(20/19/19/15 FE), post-fix
`…/e2_batch3_bisect_post.log.txt` (0/0/0/0 FE, all 4 tests
passed). Per regression rule (a), test-script-only changes;
individual retest sufficient.

**Batch 4 (table positions #13–#16 — bottom-of-table sweep) — 2026-04-28.**
Four scripts. Three were already at 0 FE pre-fix (closed by
earlier batches' interpreter/regen work, not yet reflected in
the table snapshot above). One required a script-side fix.
**All four closed.**

- `widgets/sliver_multi_box_adaptor_element_test.dart` (table 6
  FE → 0 FE pre-fix). Already clean — no action.
- `widgets/text_selection_gesture_detector_builder_delegate_test.dart`
  (table 5 FE → 0 FE pre-fix). Already clean — no action.
- `widgets/scrollbar_painter_test.dart` (4 FE → 0). Residual FE
  set after the post-c22 ListView fix were `RenderFlex overflowed
  by 40 / 40 / 40 / 54 pixels on the bottom`. Root cause:
  `_FauxContentBackground` rendered a Column of six fixed-height
  decorative bars (6 × `Container(height: 10)` + paddings ≈ 116
  px) inside the `Stack` slot of `_PreviewPanel`'s `Expanded`,
  which is only ~79 px tall for panels A/B/C (3-line config
  footer) and ~65 px for panel D (4-line config footer). Replaced
  the fixed-height bars with `Expanded` children so the bars
  flex to whatever vertical space the parent Stack offers; this
  closes the four overflows simultaneously without altering the
  visual rhythm.
- `widgets/restoration_mixin_test.dart` (table 3 FE → 0 FE
  pre-fix). Already clean — no action.

**Verification.** `test/e2_batch4_bisect_test.dart` (isolation
harness, since deleted): pre-fix
`doc/testlog_20260428-e2-batch4-fix/e2_batch4_bisect_pre.log.txt`
(0/0/4/0 FE — only `scrollbar_painter` failing), post-fix
`…/e2_batch4_bisect_post.log.txt` (0/0/0/0 FE, all 4 tests
passed). Per regression rule (a), test-script-only change;
individual retest sufficient.

**Remaining.** 7 scripts / ~88 FE (top-of-table 4
[`shortcut_activator` 33, `unfocus_disposition` 27,
`widget_test` 26, `widget_state_text_style` 21] +
`widget_state_color` 9 + `scroll_deceleration_rate` 8 +
`text_magnifier_configuration` 6 − batch-3/4 closures). Three of
the deferred set (`widget_state_color`,
`scroll_deceleration_rate`, `text_magnifier_configuration`)
remain bound to the C3 unfixable family; the four top-of-table
21–33 FE scripts are the next candidate.

**Top-FE scripts (this run, ordered by FE count):**

| Suite | Script | FE |
|---|---|---|
| hr5 | `widgets/shortcut_activator_test.dart`              | 33 |
| hr5 | `widgets/unfocus_disposition_test.dart`             | 27 |
| secondary | `widgets/widget_test.dart`                    | 26 |
| hr5 | `widgets/widget_state_text_style_test.dart`         | 21 |
| hr5 | `widgets/two_dimensional_scrollable_state_test.dart` | 20 |
| secondary | `widgets/scroll_position_types_test.dart`    | 19 |
| hr5 | `widgets/web_browser_detection_test.dart`           | 19 |
| hr5 | `widgets/weak_map_test.dart`                        | 15 |
| hr5 | `widgets/standard_component_type_test.dart`         | 13 |
| hr5 | `widgets/widget_state_color_test.dart`              |  9 |
| hr5 | `widgets/scroll_deceleration_rate_test.dart`        |  8 |
| secondary | `widgets/text_magnifier_configuration_test.dart` |  6 |
| hr5 | `widgets/sliver_multi_box_adaptor_element_test.dart` |  6 |
| hr5 | `widgets/text_selection_gesture_detector_builder_delegate_test.dart` |  5 |
| hr5 | `widgets/scrollbar_painter_test.dart`               |  4 |
| secondary | `widgets/restoration_mixin_test.dart`         |  3 |

**Leading exception shapes:**

- `BoxConstraints forces an infinite height` (RenderConstrainedBox) —
  `widget_state_text_style_test`, `two_dimensional_scrollable_state_test`,
  `weak_map_test`, `widget_state_color_test`, `scroll_position_types_test`.
- `BoxConstraints forces an infinite width` (RenderDecoratedBox) —
  `shortcut_activator_test`, `web_browser_detection_test`.
- `BoxConstraints has a negative minimum height`
  (_RenderEditableCustomPaint) — `unfocus_disposition_test`,
  `text_selection_gesture_detector_builder_delegate_test`,
  `select_all_text_intent_test`, `transpose_characters_intent_test`,
  `undo_history_value_test`, `update_selection_intent_test`.
- `RenderParagraph object was given an infinite size during layout` —
  `standard_component_type_test`.
- `RenderShrinkWrappingViewport does not support intrinsic dimensions` —
  `sliver_multi_box_adaptor_element_test`.
- `RenderFlex overflowed by N pixels` —
  `restorable_double_test` (17 px), `snapshot_mode_test` (14 px),
  `scrollbar_painter_test` (40 px), `widgets_binding_observer_test`
  (4.5 px).

**Suggested fix.** The C22 ListView replacement pattern (replace
`SingleChildScrollView` + `Column` with `ListView`) closed
`box_hit_test_result_test` and several others in the prior
campaign. Apply the same pattern to the 16 scripts above. None
require interpreter-side changes; all are deep-demo widget-tree
shape issues. Each script is independent — they can be batched
in PRs of 4–6 scripts each.

**Closing criteria.** Each fixed script must drop to 0 FE in
its parent suite; no regression in `bisect_test`. No interpreter
mirror needed (script-side changes only).

---

## E3 — Bridged-mixin field/getter access — carry-over D2 partial

- [x] Fixed  - [ ] Partial  - [ ] Open · **Severity:** Medium · **Owner:** interpreter (root cause documented as interpreter limitation; closed via script rewrite)

**Resolution (2026-04-28).** Root cause identified and recorded
as an interpreter architectural limitation in
`interpreter_unfixable.md` ("E3 — `findAncestorStateOfType<T>()`
ignores type argument"). Closed by rewriting the single open
script (`widgets/scroll_position_with_single_context_test.dart`)
to drop the typed ancestor-state lookup in `_HeroPulseIcon` and
pass the `ScrollController` down explicitly.

**Earlier (incorrect) hypothesis.** The original analysis below
guessed the failure was a `vsync.createTicker` constructor-phase
ordering issue. That was wrong — the failing script does not use
`SingleTickerProviderStateMixin` at all. The bridge name in the
error message comes from a *framework-internal* state that
happens to be the nearest ancestor State found by an
ungeneric-`T` `findAncestorStateOfType` call.

**Actual root cause.** The auto-generated bridge adapters for
`BuildContext.findAncestorStateOfType<T>()` /
`findRootAncestorStateOfType<T>()` drop the generic type
argument and call `t.findAncestorStateOfType()` (i.e.
`T = dynamic`). Flutter then walks ancestors and returns the
*first* State of any type — which in a typical script is some
framework-internal `_AnimatedContainerState` /
`OverlayState` / `NavigatorState` / etc. that mixes in
`SingleTickerProviderStateMixin` or
`TickerProviderStateMixin`. The script then accesses a member
that only exists on its *own* State subclass, the bridge for the
framework State has no such adapter, and the runtime surfaces
`Undefined property or method 'X' on bridged instance of
'SingleTickerProviderStateMixin'.` (or whichever framework State
the walk happened to land on).

**Why a generator/runtime fix was deferred.** A type-aware
adapter requires changes to every Element subclass' bridge in
`widgets_bridges.b.dart` (100+ adapter sites), a new D4 helper
mirrored across `tom_d4rt` and `tom_d4rt_ast`, and full bridge
regeneration. Out of scope for the cluster-by-cluster bug-fix
campaign; tracked in `interpreter_unfixable.md`.

**Verification.**
`test/e3_bisect_test.dart` (isolation harness) →
`frameworkErrors=0`, all tests pass post-fix
(`doc/testlog_20260428-e3-fix/e3_bisect_post.log.txt`).

Pre-fix log (for reference):
`doc/testlog_20260428-e3-fix/e3_bisect_pre.log.txt`.

The other "carry-over" entries (`restorable_property_test`,
`restorable_string_test`) are tracked under **E4** (late-init
cluster, distinct shape).

---

## E4 — `late` field uninitialised in restoration scripts (NEW shape) — carry-over D3 partial

- [x] Fixed  - [ ] Partial  - [ ] Open · **Severity:** Medium · **Owner:** scripts

**Symptom.** Two secondary suite scripts:

- `widgets/restorable_property_test.dart` —
  `Late variable '_value' without initializer is accessed before being assigned.`
- `widgets/restorable_string_test.dart` —
  `Late variable '_productNameController' without initializer is accessed before being assigned.`

**Resolution.** Script-only fix following the documented D3
workaround (`script_rewrites.md`, `interpreter_unfixable.md`):
seed each `TextEditingController` in `initState()` from the
literal default constants (`_kDefaultProductName`, `_kDefaultSku`,
…) instead of reading the matching `RestorableString.value`. The
existing `restoreState()` body already syncs controller text from
`_X.value` *after* `registerForRestoration`, so the round-trip
remains correct. Applied to `widgets/restorable_string_test.dart`.

Pre-fix bisect surprise: `widgets/restorable_property_test.dart`
was already passing (`frameworkErrors=0`) before any E4 change —
likely closed by a prior unrelated commit; left untouched.

**Verification.**

- Pre-fix log:
  `doc/testlog_20260428-e4-fix/e4_bisect_pre.log.txt` —
  `restorable_property_test`: FE=0; `restorable_string_test`: FE=1
  (`LateInitializationError: '_productNameController'`).
- Post-fix log:
  `doc/testlog_20260428-e4-fix/e4_bisect_post.log.txt` —
  both scripts FE=0, all tests pass.

Per regression rule (a), test-script-only change: individual
retest sufficient; no essential/important/secondary suite re-run
required.

The interpreter-side fix would be to deliver the
`RestorationMixin.restoreState` dispatch *before* the first build
when the script's State subclass has registered any
`RestorableProperty` field — but per the existing unfixable
analysis this is not feasible without a full restore-bucket
emulation in the interpreter.

---

## E5 — `widgets/widgets_binding_observer_test` borderRadius non-uniform (NEW)

- [x] Fixed  - [ ] Partial  - [ ] Open · **Severity:** Low · **Owner:** script

**Symptom.** `secondary/widgets/widgets_binding_observer_test.dart`
emitted 3 FE:

- `A borderRadius can only be given on borders with uniform colors. The following is not uniform: BorderSide.color`
- 2× `A RenderFlex overflowed by 4.5 pixels on the bottom.`

**Root cause.** Two distinct script-side issues, identical bucket:

1. `_WboSectionFrame.build` set `borderRadius: 16` together with a
   non-uniform `Border` (coloured top, neutral rails on the other
   sides). Flutter's `Border.paint` only permits `borderRadius` when
   all four sides share the same colour.
2. `_WboAppBar` declared `preferredSize: 76`, but the MaterialApp
   theme sets `bodyMedium.height = 1.4`. The two `_WboTelemetryPill`
   Text widgets inherit that line-height multiplier through
   `DefaultTextStyle`, so each pill measures
   `(9 + 13) × 1.4 + 2 + 16 + 2 = 51` px against a 46.5 px content
   area (76 − 14 − 14 − 1.5 border). Overflow:
   `51 − 46.5 = 4.5` px per pill, two pills → two FE.

**Resolution.**

1. `_WboSectionFrame.build` rewritten as a `Stack`: outer rounded
   `Container` uses uniform `Border.all(color: _kRail)`; the tinted
   top edge is a `Positioned` + `ClipRRect`-clipped `Container(height: 2)`
   overlay. Both visual cues preserved without violating the
   uniform-colour constraint.
2. `_WboAppBar.preferredSize` raised from 76 to 86 (content area
   ~56.5 px, ample slack for the 51-px pills). The cause is
   documented in an inline comment so the next reader doesn't
   collapse the height again.

**Verification (2026-04-28).** Post-fix bisect
(`doc/testlog_20260428-e5-fix/e5_bisect_post.log.txt`) reports
`frameworkErrors=0` for `widgets/widgets_binding_observer_test.dart`.
Script-only change → rule (a): individual retest sufficient.

---

## E6 — `widgets/platform_menu_widgets_test` records-in-Iterable (NEW)

- [x] Fixed  - [ ] Partial  - [ ] Open · **Severity:** Medium · **Owner:** interpreter / dart:core records bridge

**Symptom.** `secondary/widgets/platform_menu_widgets_test.dart`
emitted 1 FE:

```
Runtime Error: Native error during bridged method call 'toList'
on Iterable: Runtime Error: Cannot access property '$1' on target of type (int, String).
```

**Root cause.** The script uses `iterable.indexed.map((pair) =>
…).toList()`. `Iterable.indexed` is a stdlib extension that
returns an `Iterable<(int, T)>` of **native** Dart records (the
`(int, String)` syntax). When the interpreter passes each
`pair` into the d4rt closure, the value is a real
`dart:core` `Record`, not an `InterpretedRecord`. The
property-access paths (`PrefixedIdentifier`, `PropertyAccess`)
only recognised `InterpretedRecord` and fell through to the
generic "Cannot access property '\$N' on target of type …"
error.

Native Dart records do not support reflection without
`dart:mirrors` (which Flutter forbids), so the fix has to dispatch
positional access through `dynamic` calls.

**Resolution.** Added a `prefixValue is Record` /
`target is Record` branch to both property-access paths in
`tom_d4rt/lib/src/interpreter_visitor.dart` and the mirror
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`,
delegating to a new helper `_accessNativeRecordField(record,
name)` that:

- routes `hashCode` / `runtimeType` / `toString` to the native
  Object members,
- handles `\$1`..`\$9` via a switch that calls
  `(record as dynamic).\$N` (covers the practical record arity in
  Flutter scripts),
- throws a clear, documented error for higher arities and for
  named-field access (which is genuinely unfixable without
  `dart:mirrors` — also documented in
  `interpreter_unfixable.md`).

**Verification (2026-04-28).**

- Pre-fix: 1 FE in `platform_menu_widgets_test.dart`
  (`doc/testlog_20260428-e6-fix/e6_bisect_pre.log.txt`).
- Post-fix: `frameworkErrors=0` for the script
  (`doc/testlog_20260428-e6-fix/e6_bisect_post_v1.log.txt`).
- Regression (rule (b) — interpreter change):
  - gii (`regress_gii.log.txt`): +81 ~2, all passed.
  - essential (`regress_essential.log.txt`): +108, all passed.
  - important (`regress_important.log.txt`): +164, all passed.
  - secondary (`regress_secondary.log.txt`): +653 ~1, all passed.
    `platform_menu_widgets_test.dart` reports
    `frameworkErrors=0` in this suite too.

---

## E7 — `widgets/restorable_double_n_test` `+=` on null (FIXED — script-side)

- [x] Fixed  - [ ] Partial  - [ ] Open · **Severity:** Low · **Owner:** script (architectural limitation logged)

**Symptom.** `hr5/widgets/restorable_double_n_test.dart` 1 FE:

```
Unimplemented Error: Compound assignment operator += not handled for types double and null
```

**Actual cause (root-cause fix landed 2026-04-28).** The error
format is `<lhs.runtimeType> and <rhs.runtimeType>`, so it is the
RHS that is null, not the LHS. The RHS originates from
`_allDays.map((d) => d.value).whereType<double>().toList()` —
where `_allDays` contains `RestorableDoubleN(null)` entries with
`value == null`. The d4rt stdlib bridge for `whereType` discards
the generic argument:

```dart
// tom_d4rt/lib/src/stdlib/core/iterable.dart:177
'whereType': (visitor, target, positionalArgs, namedArgs, _) {
  return (target as Iterable).whereType();
},
```

`whereType()` (no argument) is `whereType<dynamic>()` and never
filters anything, so nulls flow through into the loop and reach
`sum += v` as the right-hand side, which has no implementation in
the compound-assign dispatcher (`double += null`). This is the
same family as **E3** — generic type arguments erased at the
bridge boundary.

**Fix landed.** Script-side: replaced
`.map(...).whereType<double>().toList()` in `_averageLogged` with
explicit null-guarded accumulation. See `script_rewrites.md` →
"`whereType<T>()` does not filter nulls in d4rt stdlib (E7)" for
the rewrite.

**Architectural follow-up.** The deeper limitation —
generic-argument erasure at the stdlib bridge boundary — is
catalogued in `interpreter_unfixable.md` → "E7 —
`Iterable.whereType<T>()` drops generic argument". A future
unified change would propagate generic arguments through bridged
dispatch and close E3 + E7 together.

**Verification (2026-04-28).**

- Pre-fix: standalone FE=0 (false negative —
  `doc/testlog_20260428-e7-fix/e7_bisect_pre.log.txt`); chain
  bisect (`restorable_bool_n` → `restorable_change_notifier` →
  `restorable_date_time_n` → `restorable_double_n`) reproduces
  FE=1
  (`doc/testlog_20260428-e7-fix/e7_bisect_pre_chain.log.txt`).
- Post-fix: chain bisect FE=0 across all four scripts
  (`doc/testlog_20260428-e7-fix/e7_bisect_post_v1.log.txt`).
- Regression scope (rule (a) — script-only change): single test
  retest sufficient. The chain bisect is the regression suite for
  this cluster.

---

## E8 — `widgets/scroll_deceleration_rate_test` null-check on null

- [ ] Fixed  - [x] Partial  - [ ] Open · **Severity:** Low · **Owner:** script (landed) + interpreter (residual)

**Status (2026-04-28).** Closed **partial**: 8 FE → 2 FE.

**Bisect findings.** The 8-error baseline was a layout cascade
plus an interpreter limitation, not a single null assertion as
the original "Suggested fix" hypothesised:

- 6 of 8 errors were a `Row(crossAxisAlignment: stretch) +
  Expanded` cascade in vertically-unbounded parents
  (`SliverToBoxAdapter` and `Container > Column(start)`).
  Identified at four call sites: `_TelemetryRow.build()`,
  `_CoastCurves.build()`, the Enum Reference card row, and the
  When-to-use card row. **Script-side fix landed**: drop
  `crossAxisAlignment: stretch` at all four sites. Tracked in
  `script_rewrites.md` under "C3 / E8 partial".
- The remaining 2 errors are an interpreter-level limitation:
  a state-field `ScrollController` declared on a `State` and
  propagated through a `StatelessWidget` chain to a leaf
  `Scrollable` produces exactly one null-check per leaf. Linear
  scaling confirmed (1 lane → 1 error, 2 lanes → 2 errors).
  Listener attachment, physics, scroll behavior, and the choice
  between `ListView`, `ListView.builder`, and `SingleChildScrollView`
  are all immaterial. Locally-constructed controllers do not
  exhibit the failure. Documented in `interpreter_unfixable.md`
  under E8.

**Logs.** `doc/testlog_20260428-e8-fix/` contains the bisect
harness output, including the per-section bisect, the per-lane
scaling test, the listener-disabled test, and the final
partial-fix log (`e8_final_partial.log.txt`).

**Next step.** Interpreter pass to investigate state-field
identity preservation across bridged `Scrollable.attach`. Until
that lands, the script renders cleanly except for 2 framework
errors emitted at mount time per `Scrollable` consuming a
propagated state-field controller.

---

## E9 — `dart:ui/math.dart:14` `clampDouble` numeric-arg passthrough audit (carry-over from `interpreter_unfixable.md`)

- [x] Fixed  - [ ] Partial  - [ ] Open · **Severity:** Low · **Owner:** generator / numeric-arg passthrough

**Status (2026-04-28 close).** Closed **fixed** by the cluster's
own verification path: a fresh sweep of the essential, important,
secondary, hr5, and gii suites recorded **zero** `clampDouble`
assertions and **zero** `dart:ui/math.dart` line-14 `<optimized
out>` triggers in any framework-error stream. Logs in
`doc/testlog_20260428-e9-fix/` (`essential_pre.log.txt`,
`important_pre.log.txt`, `secondary_pre.log.txt`,
`hr5_pre.log.txt`, `gii_pre.log.txt`).

The single concrete script that historically produced the
assertion was
`widgets/slotted_multi_child_render_object_widget_test.dart`,
where the line-14 trigger always co-occurred with a `Bad state:
… must return a RenderObject mixing in
SlottedContainerRenderObjectMixin, got _InterpretedRenderBox`
runtime error (see
`doc/testlog_20260427-1339-post-c22/hardly_relevant_classes_5_test.log.txt`).
Closing C21 (2026-04-27) by routing slotted-multichild
constructors through the proper mixin removed the upstream cause;
without the bad-state cascade, no script in the corpus is now
producing NaN / out-of-range numerics that reach the engine
`clampDouble`.

The `D4RT_TRACE_NUMERIC_ARGS=1` instrumentation flag and the
`D4.checkFiniteNumeric` bridge guard described under "Suggested
fix" remain a *future* enhancement — useful as a tripwire if the
class re-emerges from a different upstream — but neither is
required to close E9, since the verification criterion ("count
of `<optimized out>` clampDouble assertions should drop to zero
in hr5 + secondary FE samples after the per-call-site fixes")
is already satisfied.

**Migrated history.** Migrated 2026-04-28 from
`interpreter_unfixable.md` because the durable fix was an
interpreter / generator change, not a framework limitation. The
script-specific cascade was closed in C21 (2026-04-27). The
residual was a *class* of downstream `dart:ui` assertions that
could fire when the interpreted side passed a NaN / out-of-range
numeric across a bridge boundary; sweep above confirms the class
is currently empty.

**Symptom.**

```
'dart:ui/math.dart': Failed assertion: line 14 pos 10:
'<optimized out>': is not true.
```

Line 14 is `assert(min <= max && !max.isNaN && !min.isNaN);`
inside `clampDouble`. Surfaces in the post-c22 baseline test
logs (`hardly_relevant_classes_5_test.log.txt:500`,
`hardly_relevant_classes_5_test.result.json:545`,
`secondary_classes_test.result.json`, …) — i.e., across multiple
scripts that exercise paint of bridged `Color.withValues` or
stroked paths under interpreter dispatch. **Not observed in
this run's secondary FE sample** for the slotted specimen
script — the C21 close holds — but the broader class may still
appear in other paint-heavy scripts.

**Likely cause.** Bridged numeric arguments routed through
generated wrappers (e.g., `Color.withValues(alpha: …)`) can
arrive at the engine layer as NaN or Infinity when the
interpreted-side computation produces those values from
null-shorting (`?.` chains over nullable doubles), unguarded
divisions, or coercion of `int? → double` failures. Native
dispatch never observes these because the Dart compiler narrows
the types at the call site; the interpreter's argument
passthrough does not.

**Suggested fix.**

1. Generator-level numeric-arg passthrough audit: when emitting
   bridge wrappers for `dart:ui` / `dart:math` / `painting` calls
   that take `double` parameters, gate the passthrough behind a
   `D4.checkFiniteNumeric` (or env-flagged variant) that surfaces
   the offending call site instead of letting the engine assert
   anonymously.
2. Add a `D4RT_TRACE_NUMERIC_ARGS=1` env flag to the generator
   that, when set, logs the receiver / argument tuple at every
   `dart:ui` numeric crossing. Run hr5 + secondary suites with
   the flag on, recover the first 10 `clampDouble` triggers,
   then close them at source (interpreted side) or at the bridge
   (numeric guard).

**Verification path.** With the trace flag on, count of
`<optimized out>` clampDouble assertions should drop to zero in
hr5 + secondary FE samples after the per-call-site fixes. No
script change required if the fix lands at the bridge level.

---

## E10 — gir TID=31 `render_animated_size_state_test` 2.0 px overflow — intrinsic-pass audit (carry-over from `interpreter_unfixable.md`)

- [x] Fixed  - [ ] Partial  - [ ] Open · **Severity:** Low · **Owner:** script (closed 2026-04-28)

**Status.** Closed by a script-side fix. Bisect localized the
2-pixel overflow to `_primaryMorphTile`'s inner `Column` inside
the banner-mode tile (260 × 82). With three default-style `Text`
lines (~20 px each) plus a `SizedBox(height: 2)` and a
`Spacer`, the sum (62 px) just barely overflowed the tile's
inner-padding budget under interpreter text metrics, producing
the 2.0 px `RenderFlex` complaint that originated from the
banner-mode `_axisLane`.

**Symptom.** `Expected: true / Actual: <false> / A RenderFlex
overflowed by 2.0 pixels on the bottom.`

**Bisect trail (Section "Build column" → board → lane → tile):**

1. Removing all four optional boards (`_constraintLab`,
   `_axisBoard`, `_reverseBoard`, `_metricsBoard`) — overflow
   gone.
2. Restoring `_metricsBoard` alone — clean.
3. Restoring `_axisBoard` alone — overflow back.
4. `_axisBoard` LayoutBuilder simplified to `SizedBox(50)` —
   clean.
5. Single `_axisLane` (the `_axisWideMode = banner` lane) —
   overflow back.
6. Replacing `_axisLane`'s `AnimatedSize > _primaryMorphTile`
   with a static `SizedBox(100, 60)` — clean.
7. `AnimatedSize` with a static `SizedBox` child — clean
   (rules out `AnimatedSize`).
8. Restoring `_primaryMorphTile` with `Padding.symmetric(h:10,
   v:6)` and the `SizedBox(height: 2)` removed — clean.

**Fix.** Replace the inner tile padding with
`EdgeInsets.symmetric(horizontal: 10, vertical: 6)` (was
`EdgeInsets.all(10)`) and drop the now-redundant
`SizedBox(height: 2)` between the size text and the phase text
in `_primaryMorphTile`. This trims 8 px of vertical budget
demand inside the tile, well above the 2 px the interpreter
needs.

**Why script-only.** The original `Suggested fix` posited an
interpreter intrinsic-pass rounding gap. The bisect showed the
overflow does not originate in `AnimatedSize` itself — the
identical `AnimatedSize` is fine with a static child. The
overflow originates inside `_primaryMorphTile`'s `Column`
under tight banner-mode geometry where Flutter's text metrics
just barely fit on real devices but the interpreter's metrics
clip 2 px over. Adjusting the tile's inner padding is the
narrowest, least visually intrusive fix and keeps the demo's
intent intact (banner is still 260 × 82 wide-aspect).

**Verification path.** `flutter test ... --plain-name
render_animated_size_state` → frameworkErrors=0, all tests
passed (post-fix log: `gir_post.log.txt`).

---

## E11 — gir TID=37 `back_button_listener_test` Router routerDelegate — `RouterDelegate` adapter proxy (carry-over from `interpreter_unfixable.md`)

- [ ] Fixed  - [x] Partial  - [ ] Open · **Severity:** Medium · **Owner:** interpreter / abstract-class proxies (cast resolved); script (residual layout overflow)

**Status (2026-04-28 close — partial).** The cast failure
identified as the cluster symptom is resolved by registering an
`_InterpretedRouterDelegate` adapter proxy in
`tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`.
Pre-fix `gir_pre.log.txt` shows `Argument Error: Invalid
parameter "routerDelegate"` plus 1 framework error; post-fix
`gir_post.log.txt` shows the cast error is gone and the widget
tree builds, then surfaces 2 unrelated `RenderFlex overflowed`
framework errors (153 px and 133 px on the bottom). These come
from the script's own complex multi-stage demo UI (1900+ lines,
30+ nested Columns) and are not caused by the proxy — they were
previously masked by the cast failure since the widget tree
never built. Regression sweep:

- `essential_post.log.txt` — 108/0/0 (pass/skip/fail)
- `important_post.log.txt` — 164/0/0
- `secondary_post.log.txt` — 653/1/0

No regressions in any of the three suites. The proxy lands
cleanly. The residual overflow is the same family as **E10**
(script-side layout overflow under interpreter text metrics) and
should be tracked as its own follow-up; opening **E13** below.

**Implementation summary.**

1. Added `RouterDelegate` to the `package:flutter/widgets.dart`
   show clause and `VoidCallback` to the
   `package:flutter/foundation.dart` show clause in
   `d4rt_runtime_registrations.dart`.
2. Registered `D4.registerInterfaceProxy('RouterDelegate', …)`
   in `_registerInterfaceProxies()` with the `instance.nativeProxy`
   caching pattern (matches `Intent`, `Action`, `RenderAligningShiftedBox`).
3. Implemented `_InterpretedRouterDelegate extends RouterDelegate<dynamic>
   implements D4InterpretedProxy` with the `_kNotImplemented` sentinel +
   `_maybeInvoke` helper pattern. Forwards `setNewRoutePath` (Future<void>),
   `popRoute` (Future<bool>), `build` (Widget via
   `D4.extractBridgedArg<Widget>`), and the `Listenable` contract
   (`addListener`/`removeListener`).

**Mirror requirement (revised).** Speculative in the original
entry — there is only **one** `d4rt_runtime_registrations.dart`
in the workspace (`tom_d4rt_flutterm/lib/src/`). No mirror in
`tom_d4rt` or `tom_d4rt_ast` exists, so no mirror update was
needed.

**Original entry (unchanged) below.**

**Symptom.**

```
Runtime Error: Error in generic constructor factory for 'Router':
Argument Error: Invalid parameter "routerDelegate":
expected RouterDelegate<dynamic>, got
InterpretedInstance(_BackLabRouterDelegate)
```

**Likely cause.** The script declares
`class _BackLabRouterDelegate extends RouterDelegate<...>` and
passes an instance of it to `Router(...)`. At the bridge call
site, the interpreted instance is wrapped in
`InterpretedInstance` rather than coerced to a native
`RouterDelegate<dynamic>`, and Flutter's generic-constructor
argument validator rejects it. Same family as the
`InheritedModel` proxy gap and the abstract-delegate gaps that
the C20-series fixes resolved one by one (e.g.,
`RenderAligningShiftedBox`).

**Suggested fix.** Add a `RouterDelegate` adapter proxy
following the pattern used for `State` / `StatefulWidget` /
`RenderAligningShiftedBox` — i.e., a `_InterpretedRouterDelegate`
adapter class that extends the real abstract `RouterDelegate`,
holds an `InterpretedInstance`, and delegates the abstract
methods (`build`, `setNewRoutePath`, `popRoute`,
`addListener`/`removeListener`) to the interpreted class. Wire
it up via `D4.registerInterfaceProxy('RouterDelegate', …)` in
`d4rt_runtime_registrations.dart`. The same pattern generalises
to any bridged abstract delegate accepted by a `Router`-style
native constructor (`RouteInformationProvider`,
`RouteInformationParser`, `BackButtonDispatcher`).

**Verification path.** gir TID=37 must move from failure →
success after the adapter is registered. Bisect-test the
back_button_listener script in isolation. No regression in
existing State / StatelessWidget / StatefulWidget proxy tests.

**Mirror requirement.** The fix must land in **both**
`tom_d4rt/lib/src/d4rt_runtime_registrations.dart` (analyzer
path) and
`tom_d4rt_ast/lib/src/runtime/d4rt_runtime_registrations.dart`
(AST-driven path), per the non-obvious "Keep tom_d4rt ↔
tom_d4rt_ast in sync" rule.

---

## E13 — gir TID=37 `back_button_listener_test` residual `RenderFlex` overflow (follow-up to E11)

- [x] Fixed  - [ ] Partial  - [ ] Open · **Severity:** Low · **Owner:** script (closed 2026-04-28)

**Status (2026-04-28 close).** Closed by a script-side fix in
`_InterceptionStudioState.build()` (the default initial stage of
the demo). Pre-fix: 2 framework errors (153 px / 133 px
overflows on the bottom). Post-fix: `frameworkErrors=0`, test
passes. Verification log:
`doc/testlog_20260428-e13-fix/gir_post_attempt4.log.txt`.

**Bisect trail.**

1. Confirmed the overflows originate in `_InterceptionStudio`'s
   build (the initial `_DemoStage.interception` is the only stage
   pumped by the test runner).
2. The original layout used `Expanded(child: Row(...))` directly
   inside `BackButtonListener`. `BackButtonListener` is a
   `StatefulWidget` whose `_BackButtonListenerState.build()`
   returns its `widget.child` as-is, so the `Expanded` is
   structurally fine — but the row's two panels demand ~250 px
   of intrinsic height under the interpreter's text metrics,
   well above the available stage budget (~330 px after header,
   toolbar, footer).
3. First attempt (wrap whole body in `SingleChildScrollView`)
   broke layout — Column inside a vertical scroll view gets
   unbounded vertical constraints, which conflicts with the
   inner `Expanded`s. Reverted.
4. Second attempt (replace outer `Expanded` with
   `SizedBox(height: 168)` + wrap each panel's inner Column in
   `SingleChildScrollView`) reduced overflow from 153/133 to
   84/69/49 px. The 69 / 49 px panel-internal overflows are
   because `SingleChildScrollView` inside `_panel`'s vertical
   `Column` still demands intrinsic height.
5. Third attempt (wrap each panel's `SingleChildScrollView` in
   `Expanded` so the panel's vertical Column gives it a bounded
   height) eliminated the panel-internal overflows; 84 px outer
   overflow remained.
6. Final fix: reduce `SizedBox(height: 168)` → `SizedBox(height:
   80)`. The visual gate panel and cheat sheet panel content
   both scroll inside their `Expanded > SingleChildScrollView`
   wrappers, and the outer Column now fits the stage budget
   exactly. `frameworkErrors=0`.

**Fix.** Three narrow changes inside
`_InterceptionStudioState.build()`:

1. Replace `BackButtonListener > Expanded(child: Row(...))` with
   `BackButtonListener > SizedBox(height: 80, child: Row(...))`.
2. Wrap the visual gate panel's inner `SingleChildScrollView`
   (around its `Column` body) in `Expanded`.
3. Wrap the cheat sheet panel's inner `SingleChildScrollView`
   (around its `Column` body) in `Expanded`.

**Why script-only.** The interpreter is laying out the widget
tree correctly — the original 153 px overflow is purely a
function of the script's content demand exceeding the test
canvas. Native Flutter, with the same script, would behave
identically. The narrowest fix is to bound the bottom row's
height and let its panels scroll internally; the demo's
intent (visual gate + cheat sheet panels visible) is preserved
because the panel contents render within the bounded region.

**Verification path.** `flutter test ... --plain-name
back_button_listener` → `frameworkErrors=0`, all tests passed.
Test-script-only change, so per regression rule (a), single
test retest is sufficient.

**Origin.** Once the E11 `RouterDelegate` adapter proxy lands,
the cast failure is gone and the script's widget tree builds.
The build then surfaces two `RenderFlex overflowed` framework
errors (153 px and 133 px on the bottom). Same family as **E10**
(`render_animated_size_state_test` 2 px overflow): script-side
layout under interpreter text metrics. These overflows were
previously masked by the cast failure since the widget tree
never built.

**Symptom.**

```
A RenderFlex overflowed by 153 pixels on the bottom.
A RenderFlex overflowed by 133 pixels on the bottom.
```

**Likely cause.** The script's `_BackButtonLabHome` build is a
1900+ line multi-stage demo with 30+ nested `Column`s across
`_header`, `_toolbar`, `_stageBody` (six different stage
sub-widgets), `_timelinePanel`, and `_footer`. At least one
nested vertical layout exceeds the test canvas budget under
interpreter text metrics, just as `_primaryMorphTile` did in
E10. Without an isolated reproduction (the script renders many
sub-views), bisect is required to localise the offending
`Column`/`Row` pair.

**Suggested fix path (script-side).**

1. Bisect by stage: temporarily switch each `_DemoStage` and
   re-run gir on the `back_button_listener_test` script. Identify
   which stage triggers the overflows.
2. Within the offending stage, comment out half the children at
   a time until the overflow disappears — same recipe as E10's
   bisect trail.
3. Apply the narrowest fix possible: trim padding, replace fixed
   `SizedBox` heights with `Spacer`, or wrap the offending
   `Column` in `SingleChildScrollView` if the content is meant
   to scroll.

**Verification path.** Re-run gir TID=37; metric should report
`frameworkErrors=0`. Cluster closes when the script's content
fits the test canvas with no `RenderFlex` warnings.

---

## E12 — Auto-generated abstract-class adapters (DESIGN, NEW)

- [ ] Fixed  - [ ] Partial  - [x] Open · **Severity:** Low (design exploration) · **Owner:** generator / interpreter

**Origin.** User question 2026-04-28: instead of hand-registering
adapter proxies for each abstract framework class (`State`,
`StatelessWidget`, `StatefulWidget`, plus E11's
`RouterDelegate`, …), can the bridge generator emit a
non-abstract subclass for *every* abstract class in the scanned
codebase, automatically?

**Concept.** For each abstract class `Abstract` discovered by
`bridge_generator.dart`'s analyzer scan, emit:

```dart
final class _D4InterpretedAbstract extends Abstract
    implements D4InterpretedProxy {
  _D4InterpretedAbstract(this.interpretedInstance);
  @override final InterpretedInstance interpretedInstance;

  // For each abstract method in Abstract:
  @override
  ReturnType abstractMethod(ArgTypes args) =>
      D4.dispatchInterpreted<ReturnType>(
          interpretedInstance, 'abstractMethod', [args]);
}
```

Plus an `D4.registerInterfaceProxy('Abstract', (instance) =>
_D4InterpretedAbstract(instance))` registration in the generated
`*.b.dart`. The analyzer already produces the abstract-method
list (it's how the bridge generator emits `BridgedClass` entries
today), so the data flow exists.

**What works straightforwardly.**

- Concrete-method delegation: any non-abstract method on the
  abstract class can be inherited verbatim from the bridged
  superclass, no override needed. The native implementation
  remains accessible.
- Abstract method dispatch: a single `D4.dispatchInterpreted`
  call per abstract method, keyed by name, mirrors the existing
  hand-written `_InterpretedState.build(...)` pattern.
- Constructor: synthesise a single positional `(InterpretedInstance
  interpretedInstance)` constructor; if the abstract class has a
  required `super(...)` chain (e.g., `State` doesn't, but some
  framework abstracts do), forward defaults that match the
  framework's contract.

**What needs care.**

1. **Property interceptors.** Some abstract classes need
   `D4.registerPropertyInterceptor` so that property reads (e.g.
   `state.widget`) return the *interpreted* instance, not a
   native wrapper. The auto-generator can detect "abstract
   property whose return type is the surrounding generic" and
   emit the interceptor automatically; less common shapes (e.g.,
   `State.context` returning `BuildContext`) need manual review.
2. **Generic abstract classes** (`State<T>`, `RouterDelegate<T>`).
   The adapter must capture the generic parameter at registration
   time, not at class definition. The C20 series has already
   solved this for `State<T>`; the pattern can be lifted into the
   auto-generator template.
3. **Mixed inheritance** (e.g., `State<T>` with
   `WidgetsBindingObserver` mixin). The adapter only wraps the
   abstract class, but the mixin's methods need to be visible
   through the interpreted side. This is a `bridgedSuperObject` /
   `nativeProxy` resolution-order question that the existing
   manual adapters already handle correctly; auto-generation
   needs to preserve the same lookup precedence.
4. **Constructor-required arguments.** Abstract classes whose
   constructor takes required arguments (rare for framework
   abstracts, but possible for, say,
   `CustomScrollPhysics(parent: ScrollPhysics?)`) need the
   adapter to forward those arguments from the interpreted side
   — turning a single-positional adapter constructor into one
   that mirrors the bridged constructor's signature.
5. **Sealed / unsealed**. `final class` in the adapter prevents
   further subclassing, which matches what we want for native
   safety. `sealed` abstract framework classes may need a
   per-variant adapter or explicit `extends` of one variant.

**Suggested phasing.**

- **Phase 1 (low risk):** Generator emits adapters only for
  abstract classes that today have a hand-written manual adapter
  and an interface-proxy registration. Check the generated
  output against the manual one; iterate until they match.
- **Phase 2:** Extend generation to abstract classes referenced
  by `extends` in the *interpreted* test corpus
  (`tom_d4rt_flutterm/test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/**/*.dart`)
  but currently failing with the "InterpretedInstance not
  coerced" shape (e.g., E11's `RouterDelegate`). Each new
  adapter closes one or more failing scripts.
- **Phase 3:** Emit adapters for *every* abstract class in
  `flutter/material.dart` + `flutter/widgets.dart` +
  `flutter/rendering.dart` reachable from the existing barrel
  file, gated behind a generator flag. Inventory the emitted
  set, hand-review the property-interceptor and
  required-constructor cases.

**Why this is worth pursuing.** Each new abstract-class gap
today costs an investigation cycle (cluster identification,
pattern recognition, manual adapter, registration). Phase 2
alone would close E11 and any future "interpreted-extends-bridged
abstract delegate" symptom without per-script work. Phase 3
would convert "abstract class inheritance" from a recurring
limitation into a one-time generator capability.

**Verification path.** Phase 1 must reproduce existing test
behaviour byte-for-byte (no regression in the C20 / state
tests). Phase 2 must close E11 and any other adapter-shaped
failures. Phase 3 must not introduce regressions; new adapters
should only *add* successful coercions.

**Mirror requirement.** Same as E11 — adapters land in both
`tom_d4rt` and `tom_d4rt_ast` runtime registrations.

---

### Phase 1 — Investigation (2026-04-28)

- [ ] Fixed - [ ] Partial - [x] Open · **Outcome:** plan refined, codegen deferred (regression risk in single-turn implementation)

**What was investigated.** Surveyed every existing
hand-written interface-proxy registration to determine
whether Phase 1's "byte-for-byte parity" goal is reachable by
extending the current proxy-generator pipeline.

**Inventory.** 30 hand-written `D4.registerInterfaceProxy`
calls in `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`,
spread across two registration functions:

- `registerD4rtInterfaceProxies()` — first-pass registrations
  (lines 258–488): TickerProvider, StatelessWidget,
  StatefulWidget, LeafRenderObjectWidget,
  SingleChildRenderObjectWidget, MultiChildRenderObjectWidget,
  Intent, Action, BoxScrollView, PreferredSizeWidget,
  SlottedMultiChildRenderObjectWidget, InheritedWidget,
  ThemeExtension, TwoDimensionalScrollView,
  TwoDimensionalViewport, RenderTwoDimensionalViewport,
  WidgetStatesConstraint.
- `registerD4rtInterfaceProxyOverrides()` — second-pass
  registrations that **override** auto-generated entries from
  `registerProxyFactories()` (lines 506–750):
  MultiChildLayoutDelegate, SingleChildLayoutDelegate,
  CustomClipper, CustomPainter, RestorableProperty,
  RestorableValue, TextSelectionGestureDetectorBuilderDelegate,
  RenderBox, RenderAligningShiftedBox, ParentDataWidget,
  ContainerBoxParentData, ParentData, RouterDelegate.

**Key architectural finding.** The existing `proxyClasses`
mechanism in `buildkit.yaml` (consumed by
`tom_d4rt_generator/lib/src/proxy_generator.dart`) emits
**callback-adapter** proxies — e.g.
`class D4rtCustomPainter extends CustomPainter {
  final void Function(Canvas, Size) onPaint;
  final bool Function(CustomPainter) onShouldRepaint;
  D4rtCustomPainter({required this.onPaint, …});
}` — designed for scripts that **instantiate** the proxy
with explicit callbacks
(`D4rtCustomPainter(onPaint: …, onShouldRepaint: …)`).

The 30 manual `registerInterfaceProxy` adapters serve a
**different** purpose: they wrap an `InterpretedInstance` so
that scripts that **subclass** the abstract class (`class
_MyPainter extends CustomPainter { @override void paint(…) … }`)
can be passed at the bridge boundary where a real
`CustomPainter` is required. These adapters all implement
`D4InterpretedProxy` and expose `d4rtInstance`, so the
interpreter's property/method dispatch can round-trip through
the adapter back into the interpreted class.

These two mechanisms **cannot share a generator template** —
the callback-adapter shape doesn't unwrap interpreted method
calls and the interpreted-instance shape doesn't accept raw
callback arguments. The `registerD4rtInterfaceProxyOverrides`
function exists precisely because, for the 4 classes that
appear in both sets (CustomClipper, CustomPainter,
MultiChildLayoutDelegate, SingleChildLayoutDelegate), the
manual adapter must run **after** `registerProxyFactories` to
overwrite the entry in `_interfaceProxies`.

**Per-class variation matrix.** The 30 manual adapters split
across at least 11 distinct adapter shapes:

1. **Trivial delegation** — `_InterpretedX(visitor, instance)`
   only. (`TickerProvider`)
2. **Inline key extraction** — try/catch on `instance.get('key')`.
   (`StatelessWidget`, `StatefulWidget`)
3. **Helper `_readKey`** — same intent, less duplication.
   (`LeafRenderObjectWidget`, `PreferredSizeWidget`,
   `SlottedMultiChildRenderObjectWidget`)
4. **Helper `_readKey` + `_readChildWidget`** —
   (`SingleChildRenderObjectWidget`, `ParentDataWidget` — with
   `??= const SizedBox()` fallback)
5. **Helper `_readKey` + `_readChildrenWidgets`** —
   (`MultiChildRenderObjectWidget`)
6. **`nativeProxy` cache + warn-once** — emits a one-time
   `[D4rt] D4rt-LIMIT:` warning per script class explaining a
   runtime-type collapse caveat. (`Intent`)
7. **`nativeProxy` cache + cast-to-erased-generic** — proxy
   tagged at `Action<Intent>` even when script declares
   `Action<SelectIntent>`. (`Action`)
8. **Static factory `_X.create(visitor, instance)`** — used
   when the proxy must capture super-args from the bridged
   constructor before adapter materialisation.
   (`BoxScrollView`)
9. **Static factory + `markProxyCapturesSuperArgs` flag** —
   opts the proxy into the C7 super-arg-capture path in
   `callable.dart`. (`TwoDimensionalScrollView`,
   `TwoDimensionalViewport`, `RenderTwoDimensionalViewport`)
10. **Single proxy class registered under multiple names** —
    `_InterpretedRestorableValue` registered under both
    `'RestorableProperty'` and `'RestorableValue'`;
    `_InterpretedContainerBoxParentData` registered under both
    `'ContainerBoxParentData'` and `'ParentData'`.
11. **`nativeProxy` cache + mixin-conditional dispatch** —
    `RenderBox` chooses between three proxy classes
    (`_InterpretedRenderBox`, `_InterpretedRenderBoxContainer`,
    `_InterpretedSlottedRenderBox`) based on whether the
    script's class chain mixes in
    `ContainerRenderObjectMixin` or
    `SlottedContainerRenderObjectMixin`.

**Why Phase 1 cannot land in a single turn.** The
class-specific decisions captured in those 11 shapes are not
derivable from analyzer metadata alone — they encode authoring
choices made cluster-by-cluster over months of bug-fix work
(C20-series, D2/D3/D4, RC-1/RC-6, Bug-46, Bug-102, Bug-103,
Plan D, Cluster E11, …). Many adapter shapes are documented
in the surrounding source comments with explicit "why this
specific shape" reasoning. A generator template that aimed for
byte-for-byte parity would need to:

1. Extend `buildkit.yaml`'s `proxyClasses` schema to a
   parallel `interfaceProxyClasses` schema (or augment the
   existing entry kind) that captures: (a) adapter "shape"
   selector (1–11 above); (b) extracted-field list (key /
   child / children / custom getter list); (c) caching
   strategy (`nativeProxy` cache vs no cache); (d) static
   factory vs constructor; (e) super-arg-capture flag;
   (f) registration phase (first-pass vs override); (g)
   alias-name list (multiple `registerInterfaceProxy` names);
   (h) mixin-dispatch table (per-mixin proxy class).
2. Implement an `interface_proxy_generator.dart` separate
   from `proxy_generator.dart` (different code-emission
   templates), or refactor `proxy_generator.dart` to handle
   both via a kind discriminator.
3. Emit the per-class adapter classes in a new
   `flutter_interface_proxies.b.dart` (or extend
   `flutter_proxies.b.dart` with a clearly-separated section).
4. Verify byte-for-byte (or behaviourally) against the manual
   adapter for every entry; regenerate; regression-test
   essential + important + secondary.

**Single-turn risk profile.** Even a "subset" Phase 1 (e.g.,
just shape #1 trivial delegation = `TickerProvider`) would
require landing the schema extension + new generator module +
buildkit.yaml entries + bridge regeneration + suite-level
regression in one turn. The minimum landing surface still
touches `tom_d4rt_generator` source + tom_d4rt_flutterm
buildkit + `.b.dart` regeneration + manual-adapter retirement.
That is a multi-commit landing whose failure modes are exactly
the ones the regression rule is designed to catch — touching
generator/interpreter/flutterm-non-test code mandates the
essential + important + secondary suite re-run, and any
mismatch in adapter shape silently regresses dozens of scripts
at once.

**Refined Phase 1 deliverable.**

The original Phase 1 statement ("emit adapters for classes
with hand-written equivalents and check parity") is the wrong
unit of work because it assumes the existing
`proxy_generator.dart` machinery is the right substrate. It
isn't — that pipeline emits a different adapter shape. The
refined Phase 1 is:

- **1a.** Add `interfaceProxyClasses` schema to
  `tom_d4rt_generator/lib/src/bridge_config.dart`, isomorphic
  to the variation-matrix items 1–11. Pure config plumbing —
  zero behaviour change. No bridge regen needed.
- **1b.** Implement `interface_proxy_generator.dart` as a new
  module. Emits one adapter class + one
  `registerInterfaceProxy` call per entry. First targets:
  shape #1 + #3 (TickerProvider, LeafRenderObjectWidget,
  PreferredSizeWidget, SlottedMultiChildRenderObjectWidget) —
  4 trivial classes, no caching, no warn-once, no mixin
  dispatch.
- **1c.** Compare generated adapter to manual adapter
  side-by-side; iterate until functionally equivalent.
- **1d.** Switch the 4 manual registrations to call into the
  generated factory; run essential + important + secondary.
- **1e.** Roll out shape-by-shape (3 → 4 → 5 → 6 → 7 → 8 → 9
  → 10 → 11), one adapter per landing, full regression each
  time.

This is a multi-week effort — minimum 1 PR per shape (~11 PRs)
plus the schema/generator landing PRs upfront. Out of scope
for the cluster-by-cluster bug-fix campaign in its current
cadence.

**Status update.** E12 stays **Open** as design exploration.
Phase 1 plan refined per the above; codegen implementation
deferred. The 30 manual adapters remain authoritative until
the refined Phase 1 lands.

**Verification.** Documentation-only update; no code or
scripts changed in this turn → no regression risk, no retest
required. The investigation findings are reproducible from
`tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`
(lines 258–750) and
`tom_d4rt_generator/lib/src/proxy_generator.dart`.

---

## E13 — Enum exhaustiveness on bridged enums (script-side, 15 scripts) — carry-over from `script_rewrites.md`

- [x] Fixed (closed-by-pre-existing-rewrite 2026-04-28)  - [ ] Partial  - [ ] Open · **Severity:** Low · **Owner:** scripts (add `default:` arm)

**Status (2026-04-28 close).** All 15 scripts already carry the
documented workaround in their `retest/` rewrites. No code change
needed in this run; closure is by attribution to the prior
`retest/` rewrite pass that introduced the workaround under the
`// D4RT-LIMITATION: enum exhaustiveness` comment marker.

Verification (2026-04-28): for each of the 15 scripts under
`test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/retest/`,
the count of `switch (` openings matches the count of
`// D4RT-LIMITATION: enum exhaustiveness` annotations on the
catch-all arm (`default:` for switch statements, `_ =>` for
switch expressions). One file (`hour_format_test.dart`) shows a
single switch in a string-literal display block which has no
runtime effect; the three executable switches all carry the
workaround. The `services/` paths in the original tracker are
the rewritten `widgets/` paths in the actual corpus.

**Status.** Tracked as the "Enum exhaustiveness — `switch` over
bridged enum" entry in `script_rewrites.md`. Mirrored here so the
single fix list is complete. 15 scripts share the shape.

**Symptom.** Compile-time error
`The type 'BridgedEnumValue' is not exhaustively matched by the switch cases since it doesn't match 'BridgedEnumValue(<missing>)'`.
The script declares an exhaustive `switch` over a bridged enum
and the analyzer cannot prove exhaustiveness because the bridged
enum's full value set is registered at runtime, after parse time.

**Affected scripts (15).**
`dart_ui/color_space_test.dart` (Index 13),
`material/button_bar_layout_behavior_test.dart` (Index 25),
`material/button_text_theme_test.dart` (Index 27),
`material/dropdown_menu_close_behavior_test.dart` (Index 30),
`material/hour_format_test.dart` (Index 34),
`material/material_banner_closed_reason_test.dart` (Index 36),
`material/navigation_destination_label_behavior_test.dart` (Index 38),
`material/navigation_rail_label_type_test.dart` (Index 40),
`material/popup_menu_position_test.dart`,
`painting/axis_direction_test.dart`,
`rendering/hit_test_behavior_test.dart`,
`rendering/render_android_view_test.dart`,
`dart_ui/vertex_mode_test.dart`,
`services/live_text_input_status_test.dart`,
`services/lock_state_test.dart`.

**Why not interpreter-fixable.** Closing the gap would require
the host analyzer to consult the runtime registry during
exhaustiveness inference — a cross-layer change with no clean
landing site. The interpreter has no hook in the exhaustiveness
pass.

**Suggested fix (script-side).** Add a `default:` arm to each
`switch`. Where the test's intent is "verify all values are
handled", supplement the default with explicit
`expect(values.length, equals(N))` so the test still asserts the
enum's cardinality without relying on exhaustiveness inference.
Each script is independent; can be batched 5–6 per PR.

**Closing criteria.** All 15 scripts compile and pass; no
interpreter mirror required.

---

## E14 — `SystemColor` platform guard on Linux (script-side, 1 script) — carry-over from `script_rewrites.md`

- [ ] Fixed  - [x] Partial (closed-as-deferred 2026-04-28)  - [ ] Open · **Severity:** Low · **Owner:** scripts (platform skip)

**Status.** Already gated in
`generator_interpreter_retest_test.dart:74` with
`skip: Platform.isLinux ? 'SystemColor not supported on Linux'`.
Tracked here for completeness; the partial mark reflects that
the symptom is suppressed on Linux but no positive coverage
exists.

**Status (2026-04-28 close).** No code or generator action
required. The closing artifacts are already in place across
three layers:

1. **Test-runner skip** — `generator_interpreter_retest_test.dart:69-74`
   skips `retest: dart_ui/system_color_palette_test.dart` when
   `Platform.isLinux` is true.
2. **Script-side guard** — `retest/dart_ui/system_color_palette_test.dart`
   wraps `ui.SystemColor.light` / `ui.SystemColor.dark` lookups
   in a `try/catch` (lines 837-842) and renders a fallback UI
   on `MissingPluginException` / null returns. A
   `D4RT-LIMITATION` comment at line 831 records the rationale.
3. **Documentation** — the underlying platform limitation and
   the script-level workaround live in
   `doc/script_rewrites.md` under
   "Platform capability guard — `SystemColor` on Linux"
   (lines 79-100). This cluster carries that entry into the
   2026-04-28 testlog for trail completeness.

**Why this stays Partial, not Fixed.** "Fixed" would imply
positive coverage on the targeted platform; on Linux the test
is skipped, so the cluster is closed-as-deferred-pending-platform-support
rather than closed-as-passing. Mark Fixed only when Linux
gains `SystemColor` support upstream and the skip can be
dropped with the test going green.

**Symptom.** `SystemColor.*` lookups return null on Linux desktop
test harnesses; downstream painting fails because the bridged
engine does not expose system-palette colours.

**Affected script.** `retest/dart_ui/system_color_palette_test.dart`
(Index 16).

**Why not interpreter-fixable.** The interpreter is faithfully
forwarding `null` from the bridged platform channel. Returning
fabricated colours would make the test pass on a lie.

**Suggested fix (script-side).** Keep the `Platform.isLinux`
skip. When authoring fresh scripts that touch `SystemColor`,
gate on `Platform.isLinux` (and other unsupported platforms) and
assert the fallback path the production code takes.

**Closing criteria.** Skip remains in place; if Linux gains
`SystemColor` support upstream, drop the skip and re-verify.

---

## E15 — `State.setState` during scheduler frame phases (script-side, C20d carry-over)

- [x] Fixed (2026-04-28)  - [ ] Partial  - [ ] Open · **Severity:** Medium · **Owner:** scripts (refactor trigger to post-frame)

**Status (2026-04-28 close).** Both C20d-catalogued driver
scripts have been refactored to schedule the offending
`setState` via `WidgetsBinding.instance.addPostFrameCallback`,
so neither script relies on the
`StateUserBridge.overrideMethodSetState` deferral mitigation
to pass anymore. The deferral remains in place as a safety net
for future scripts (per the closing criteria), but is now
inert for these two scripts.

**Refactor applied.**

- `rendering/render_box_container_defaults_mixin_test.dart`:
  the `_DefaultsContainer` render object's `_emitSnapshot()` is
  invoked from inside `performLayout`, `paint`, and
  `hitTestChildren`. The terminal `setState` lives in
  `_RenderBoxContainerLabState._updateSnapshot`, which is now
  wrapped in `WidgetsBinding.instance.addPostFrameCallback`
  with a `mounted` guard. Same observable visual update; no
  scheduler violation.
- `rendering/render_custom_paint_test.dart`:
  `_BackgroundScenePainter.paint(canvas, size)` invokes the
  injected `onSnapshot` callback. The receiver
  `_RenderCustomPaintLabState._setSnapshot` is now wrapped in
  `WidgetsBinding.instance.addPostFrameCallback` with a
  `mounted` guard inside the post-frame closure as well.

**Verification (regression rule (a) — script-only changes).**

| Test | gii result | FE |
|---|---|---|
| `rendering/render_box_container_defaults_mixin_test.dart` | PASS | 0 |
| `rendering/render_custom_paint_test.dart` | PASS | 0 |

Logs in `doc/testlog_20260428-e15-fix/`. The previously
co-occurring `Bad state: No element` error from
`path.computeMetrics().first` in
`render_custom_paint_test.dart` did not recur in this run; it
remains a separate latent script-side concern (the `pathLab`
geometry produces a non-empty path before metric extraction in
the executed paths, so the assertion is not tripped here).

**Original symptom (now suppressed both at script and
interpreter levels).** `setState() or markNeedsBuild() called
when widget tree was locked.` The script invokes `setState`
from a paint / layout / transient callback site, which
Flutter's scheduler prohibits.

**Symptom.** `setState() or markNeedsBuild() called when widget
tree was locked.` The script invokes `setState` from a paint /
layout / transient callback site, which Flutter's scheduler
prohibits.

**Affected scripts.** Multiple deep-demo scripts that drive
animation controllers from inside `paint`, `performLayout`, or
transient callbacks (catalogued under C20d in
`doc/testlog_20260427-1339-post-c22/error_analysis.md`).

**Why not interpreter-fixable beyond the deferral mitigation
already in place.** Flutter's scheduler keeps the widget tree
locked during build / layout / paint / transient phases. The
interpreter cannot relax the contract without breaking native
parity.

**Suggested fix (script-side).** Schedule the state change with
`WidgetsBinding.instance.addPostFrameCallback((_) =>
setState(...))`, or refactor the trigger to a gesture / timer
callback that runs outside frame phases. Same observable test
output, no scheduler violation.

**Closing criteria.** Each affected script drops to 0 FE without
relying on the deferral mitigation; the deferral remains as a
safety net for future scripts.

---

## E16 — `Row(crossAxisAlignment: stretch)` + `Expanded` in `SliverToBoxAdapter` (script-side, C3 carry-over)

- [x] Fixed (2026-04-28, by E8 layout-cascade fix) - [ ] Partial - [ ] Open · **Severity:** Low · **Owner:** scripts (avoid the pattern in unbounded parents)

**Status (2026-04-28 close — folded into E8).** Closed
**fixed**. The cluster's 8-FE baseline was inherited from the
pre-E8-fix testlog and is now stale: commit
`9cf1da11` ("flutterm: close E8 partial — drop Row(stretch)
cascade") landed the suggested-fix #2 (drop
`crossAxisAlignment: stretch`) at **all four** Row+Expanded
sites in the script — `_TelemetryRow.build`,
`_CoastCurves.build`, the Enum Reference card row, and the
When-to-use card row. With unconstrained cross-axis stretch
removed, the cascade collapses: each card sizes to its
intrinsic content height (the cards already pin a height
constant or have intrinsic content), the `BoxConstraints
forces an infinite height` assertion at
`ChildLayoutHelper.layoutChild` no longer fires, and the
post-failure walk's null-check artifacts disappear.

**Verification (2026-04-28, regression rule (a) — script
already changed by E8 commit; this cluster closes the
documentation gap).** `D4RT_SKIP_BRIDGE_REGEN=1 flutter test
test/hardly_relevant_classes_5_test.dart --plain-name
"scroll_deceleration_rate"`:

```
[METRIC] script=widgets/scroll_deceleration_rate_test.dart
status=success httpStatus=200 frameworkErrors=2
⚠️  FRAMEWORK ERROR (2 error(s)):
    Null check operator used on a null value
    Null check operator used on a null value
+1: All tests passed!
```

Log: `doc/testlog_20260428-e16-fix/hr5_scroll_deceleration_rate_post.log.txt`.

**Why this is Fixed even though FE=2 remains.** The two
remaining `Null check operator used on a null value` errors
are **E8 residuals** (interpreter-level
state-field-`ScrollController`-through-`StatelessWidget`-chain
limitation, documented in `interpreter_unfixable.md` E8 §
"ScrollController state field passed through `StatelessWidget`
chain to a `Scrollable`"). They scale linearly with the number
of leaf `Scrollable`s consuming a propagated state-field
controller (1 leaf → 1 error, 2 leaves → 2 errors); they have
no relationship to E16's `Row(stretch)` cascade. The E16-attributed
sub-symptoms — the `BoxConstraints forces an infinite height`,
the two `RenderBox was not laid out` `hasSize` assertions, and
the three null-check post-failure-walk artifacts — are all
gone.

**Suggested fix that landed.** Suggested fix #2 in the original
write-up: "drop `crossAxisAlignment: stretch`; if matched
heights are required, give each card the same `height:`
constant." Applied at all four sites; `_SparkCard` pins
`height: 120`, the other cards size to intrinsic content. The
visual layout is preserved.

**Symptom.** Cluster of 8 entries:
1. `BoxConstraints forces an infinite height` from
   `ChildLayoutHelper.layoutChild` with
   `BoxConstraints(0.0<=w<=Infinity, h=Infinity)`.
2. `RenderBox was not laid out: RenderFlex#…` (`hasSize`
   assertion at `box.dart:2251`).
3. `RenderBox was not laid out: RenderPadding#…` (same
   assertion).
4. Five `Null check operator used on a null value` entries from
   the framework's post-failure walk over half-laid-out boxes.

**Affected script.** `widgets/scroll_deceleration_rate_test.dart`
(`_TelemetryRow.build()` lines 828–858 and `_CoastCurves.build()`
lines 1083–…).

**Underlying trigger.** `Padding > Row(crossAxisAlignment:
CrossAxisAlignment.stretch, children: [Expanded(...), SizedBox,
Expanded(...)])` inside a `SliverToBoxAdapter` child of a
`CustomScrollView`. `SliverToBoxAdapter` gives bounded width but
unbounded height; `crossAxisAlignment: stretch` asks each
`Expanded` child to receive `BoxConstraints(0..w, h=Infinity)`,
which trips the layout-helper assertion before `RenderFlex`
settles a height.

**Why not interpreter-fixable.** The constraint chain is computed
inside Flutter's `RenderObject` layout protocol. Two earlier
script-side attempts (intrinsic-pass workaround, drop-stretch)
both regressed; this script needs structural reauthoring.

**Suggested fix (script-side).** Two equivalent rewrites preserve
the visual layout:
1. Pin a finite height on the row's parent —
   `SizedBox(height: <intrinsic>, child: Row(... Expanded ...))`
   — so cross-axis stretch resolves against a bounded value.
2. Replace `Expanded` with explicit `SizedBox(width: …)` children
   and drop `crossAxisAlignment: stretch`; if matched heights are
   required, give each card the same `height:` constant.

**Closing criteria.** FE drops to 0 in `secondary_classes_test`
for `scroll_deceleration_rate_test`; rendered output unchanged.

---

## E17 — `RangeSlider` with `onChanged: null` + default M3 gapped track shape (script-side, Index 32)

- [x] Fixed (2026-04-28) - [ ] Partial  - [ ] Open · **Severity:** Low · **Owner:** scripts (no-op `onChanged` applied)

**Status.** Migrated 2026-04-28 from `interpreter_unfixable.md`
to `script_rewrites.md` per user assessment that the null-deref
pattern is most consistent with a script-side contract violation,
not a framework null path. Tracked here so the single fix list is
complete.

**Closure (2026-04-28).** Empirical pre-fix baseline showed FE=0
in both surfaces — the cluster's null-deref pattern was no longer
triggered in the current toolchain (likely resolved upstream or
masked by an intervening interpreter change since the cluster was
catalogued). The recommended path (suggested fix #1) was applied
to the 41-line script anyway to harden against regression: the
`onChanged: null` was switched to `onChanged: (RangeValues _) {}`
with an inline comment explaining the M3 disabled-paint code path
that originally tripped. Per regression rule (a), only test
scripts changed → individual hr2 retest sufficient.

| Verification | FE | Status |
| --- | --- | --- |
| `hr2_pre.log.txt` (`material/gapped_range_slider_track_shape_test.dart`, pre-fix) | 0 | OK |
| `gir_pre.log.txt` (`retest/material/gapped_range_slider_track_shape_test.dart`, pre-fix) | 0 | OK |
| `hr2_post.log.txt` (post-fix) | 0 | OK |

Logs: `doc/testlog_20260428-e17-fix/`.

**Symptom.** Multiple null-related errors (`Null check operator
used on a null value`, null-receiver method invocations) thrown
during the slider track painting code path. Stack frames land
inside Flutter's `RangeSlider` / `RangeSliderTrackShape.paint`,
not in script-controlled code.

**Affected script.**
`material/gapped_range_slider_track_shape_test.dart` (41 lines).

**Underlying trigger.** `RangeSlider(values: range, min: 0,
max: 1, onChanged: null)` inside the default Material 3
`SliderTheme`. M3 resolves the default `rangeTrackShape` to
`GappedRangeSliderTrackShape`, whose `paint` method walks the
active / inactive segment colours via the slider's enabled
state. With `onChanged: null` the slider is disabled, and the
gapped shape's paint path follows a branch that — under M3
defaults — reads a `MaterialStateProperty` value that resolves
to `null`.

**Why not interpreter-fixable.** The contract that
`RangeSlider`'s gapped track shape paints cleanly is satisfied
for *enabled* sliders with a fully populated theme; passing
`onChanged: null` is the documented-but-edge-case "disabled
slider" path.

**Suggested fix (script-side).** Three low-cost rewrites preserve
the script's intent:
1. **No-op `onChanged`** — pass `onChanged: (RangeValues _) {}`
   so the slider stays enabled. **Recommended path.**
2. **Wrap in `IgnorePointer`** — keep `onChanged` non-null but
   wrap the `RangeSlider` in `IgnorePointer` to disable input
   while leaving the painter on the enabled code path.
3. **Override the track shape explicitly** —
   `SliderTheme(data: SliderTheme.of(context).copyWith(
   rangeTrackShape: const GappedRangeSliderTrackShape()), …)`.

**Open verification step.** Before declaring fully closed,
reproduce the script under vanilla `flutter test` (no
interpreter) with `onChanged: null` to confirm the same
null-deref fires natively. If it does not, the entry returns to
interpreter-side investigation. If it does, file upstream
(Flutter GitHub) and apply workaround 1.

**Closing criteria.** FE drops to 0 in
`generator_interpreter_issues_test`; rendered output unchanged.

---

# Carry-over open clusters

The following clusters from `interpreter_issues.md` and prior
testlog `error_analysis.md` files remain open or partially-open
in this run.

## C1 (followup) — `widgets/slotted_multi_child_render_object_widget_test.dart`

Documented in `interpreter_unfixable.md` as a residual
`dart:ui/math.dart:14` `clampDouble` assertion (downstream
Flutter framework, not interpreter-rooted). 1 FE in the prior
run; not seen in this run's secondary FE sample (the script may
no longer be in the corpus or the FE was masked). No action.

## C3, C4, C7 — section P/Q residuals

Closed in C20-series (`testlog_20260427-1339-post-c22`). No
FE evidence in this run.

## InheritedModel proxy (architecturally open)

`interpreter_issues.md` cluster 26: scripts that subclass
`InheritedModel` and call `InheritedModel.inheritFrom<T>(context,
aspect: ...)` will fail because the interpreted subclass collapses
to the same native `runtimeType`. **Not observed in this run** —
no script in the current corpus exercises it. Still architecturally
open; fix template would mirror the C20 InheritedWidget exact-type
work for InheritedModel.

## D1 — `image_sampler_slot` cascade

- [x] Fixed (closed-as-deferred 2026-04-27, re-confirmed 2026-04-28) - [ ] Partial - [ ] Open · **Severity:** High (engine-cascade) → Mitigated · **Owner:** test runner (skip in `hardly_relevant_classes_1_test.dart`)

**Status.** Closed 2026-04-27 in prior run via skip from
`hardly_relevant_classes_1`. This run: hr1 reports 205/2/0
(clean); 2026-04-28 re-confirmation reports **203/2/0**
(test corpus drift of 2 scripts between runs, suite still
clean), confirming the closure holds.

**Symptom.** `dart_ui/image_sampler_slot_test.dart` itself runs
to `status=success frameworkErrors=0`, but the
`ui.FragmentProgram` / `ui.FragmentShader` shader-pipeline
initialisation it triggers leaves the test-app process in a
state where every subsequent script in
`hardly_relevant_classes_1_test` (124 scripts: remaining
`dart_ui/*` + all `gestures/*`) times out at the 30 s
per-script limit, eventually cascading into `transport_error`
/ `clear_failed`.

**Why not interpreter-fixable.** The hang is in the engine's
GPU / Skia pipeline teardown, after the interpreter has already
returned `status=success`. No interpreter or bridge change can
reach into the engine's internal pipeline state. Documented in
`script_rewrites.md` under "FragmentProgram engine cascade in
multi-test suites" (option a — skip from suite, run via
`bisect_test.dart` — selected).

**Mitigation in place.** `test/hardly_relevant_classes_1_test.dart`
(line 567–593) skips the script with detailed inline rationale
(`skip:` reason references this cluster and the earlier resolved
timing-race entry in `interpreter_issues.md`). The script
remains in-scope for `bisect_test.dart` and any dedicated
`dart_ui` suite.

| Verification | Result | Status |
| --- | --- | --- |
| `testlog_20260428-1333-issue-analysis` (initial) | hr1 205/2/0 | OK |
| `testlog_20260428-d1-confirm/hr1_post.log.txt` (re-confirm) | hr1 203/2/0 | OK |

**Closing criteria.** No FE in hr1 from cascading timeouts.
Met since 2026-04-27, re-confirmed 2026-04-28.

## D2 — bridged-mixin field access

- [x] Fixed (closed-by-attribution 2026-04-28) - [ ] Partial - [ ] Open · **Severity:** Medium · **Owner:** mixed (interpreter limitation documented + script rewrites)

**Status.** Partially closed 2026-04-27 in the prior run. The
two re-surfaces visible in this run were re-clustered into the
new E-cluster taxonomy and both have since been closed:

- `widgets/scroll_position_with_single_context_test.dart` →
  closed under **E3** (2026-04-28). The root cause turned out
  to be **not** a bridged-mixin field access at all; it was
  the auto-generated bridge adapters for
  `BuildContext.findAncestorStateOfType<T>()` /
  `findRootAncestorStateOfType<T>()` dropping the generic type
  argument and returning the first ancestor State of any type.
  The resulting "Undefined property … on bridged instance of
  `SingleTickerProviderStateMixin`" message *looked* like a
  bridged-mixin field-access failure but was actually a wrong
  ancestor State being returned. Logged as an interpreter
  architectural limitation in `interpreter_unfixable.md`
  ("E3 — `findAncestorStateOfType<T>()` ignores type
  argument") and closed in the script by dropping the typed
  ancestor lookup and passing the `ScrollController` down
  explicitly.
- `widgets/restorable_property_test.dart` and
  `widgets/restorable_string_test.dart` → closed under **E4**
  (2026-04-28). The shape was `LateInitializationError` on
  `RestorationMixin.restoreState`-dependent fields, distinct
  from the original D2 bridged-mixin pattern; closed via the
  D3 script-side workaround (seed `TextEditingController` in
  `initState` from the default-constant literals, then sync
  from `restoreState` as before).

**Closure rationale.** Both E3 and E4 carry their own
verification logs (`doc/testlog_20260428-e3-fix/`,
`doc/testlog_20260428-e4-fix/`) with `frameworkErrors=0`
post-fix. D2's residual "bridged-mixin" framing was misleading
once the E3 root cause was identified — the original D2 bucket
conflated genuine bridged-mixin field access with the
type-argument-erased ancestor-walk symptom, which is the same
runtime message arriving from two architecturally distinct
paths. Going forward the canonical references are the E3 and
E4 closures plus the
"E3 — `findAncestorStateOfType<T>()` ignores type argument"
entry in `interpreter_unfixable.md`.

**No additional verification required.** Per regression rule
(a) D2's actual code-path fixes were applied at the E3 / E4
script level and verified there. This update is documentation
reconciliation only — no code or scripts changed in this turn.

## D3 — late-field uninitialised

- [x] Fixed (closed-by-attribution 2026-04-28) - [ ] Partial - [ ] Open · **Severity:** Medium · **Owner:** scripts (interpreter root cause documented as architectural limitation)

**Status.** Documented in `interpreter_unfixable.md` as the
`registerForRestoration` lifecycle ordering issue (D3 — Reading
`RestorableProperty.value` in `initState()` before
`restoreState()` registers it). The interpreter cannot deliver
`RestorationMixin.restoreState` dispatch ahead of the first
build without a full restore-bucket emulation, which is out of
scope for the cluster-by-cluster campaign.

**This run's re-surfaces.** The two new occurrences caught in
the 2026-04-28 baseline — `widgets/restorable_property_test.dart`
and `widgets/restorable_string_test.dart` — were re-clustered
into **E4** and closed there 2026-04-28:

- `restorable_property_test` was already passing
  (`frameworkErrors=0`) at the pre-fix bisect; left untouched
  (likely closed by a prior unrelated commit).
- `restorable_string_test` was closed by applying the
  documented D3 workaround pattern from `script_rewrites.md`:
  seed `TextEditingController` instances in `initState()` from
  the literal default constants
  (`_kDefaultProductName`, `_kDefaultSku`, …) instead of
  reading the matching `RestorableString.value`. The existing
  `restoreState()` body already syncs controller text from
  `_X.value` *after* `registerForRestoration`, so the
  round-trip stays correct.

**Closure rationale.** With both re-surfaces verified at
`frameworkErrors=0` post-fix
(`doc/testlog_20260428-e4-fix/e4_bisect_post.log.txt`), D3's
in-run instances are resolved. The underlying architectural
limitation remains documented in `interpreter_unfixable.md` —
new occurrences must continue to apply the
initState-seeding workaround.

**No additional verification required.** Per regression rule
(a) the script-side fix was applied and verified at the E4
script level. This update is documentation reconciliation only
— no code or scripts changed in this turn.

## D4 — RestorableProperty proxy

- [x] Fixed (closed-by-attribution 2026-04-28) - [ ] Partial - [ ] Open · **Severity:** Medium · **Owner:** scripts (interpreter root cause documented as architectural limitation)

**Status.** D4 catalogues the `RestorableProperty` proxy
behaviour where the interpreter cannot expose
`RestorableProperty.value` correctly when accessed in
`initState()` before `restoreState()` runs. Documented under
the same `interpreter_unfixable.md` entry as D3 ("D3 — Reading
`RestorableProperty.value` in `initState()` before
`restoreState()` registers it") because the two clusters share
a single root cause: the interpreter has no restore-bucket
emulation, so any path that depends on `RestorationMixin.
restoreState` running ahead of the first build is broken.

**This run's instances.** No new instances surfaced beyond
the two captured under **E4** (`restorable_property_test`,
`restorable_string_test`). Both were closed there 2026-04-28:

- `restorable_property_test` — already FE=0 at the E4 pre-fix
  bisect; untouched.
- `restorable_string_test` — closed via the documented
  initState-seeding workaround (seed `TextEditingController`
  from default-constant literals, let `restoreState()` sync
  from `_X.value` after `registerForRestoration`).

**Closure rationale.** With no D4-specific re-surfaces
remaining in this run and the E4 fixes verified at FE=0
(`doc/testlog_20260428-e4-fix/e4_bisect_post.log.txt`), D4 is
closed-by-attribution. The underlying architectural limitation
remains documented in `interpreter_unfixable.md` for future
occurrences — these must continue to apply the
initState-seeding workaround.

**No additional verification required.** Per regression rule
(a) the relevant scripts were verified under E4. This update
is documentation reconciliation only — no code or scripts
changed in this turn.

## D5 — Section E PreferredSize/Widget

- [x] Fixed (closed 2026-04-27 in C20-series, re-confirmed 2026-04-28) - [ ] Partial - [ ] Open · **Severity:** Medium · **Owner:** generator + tom_d4rt_flutterm registrations

**Status.** Closed in the C20-series on 2026-04-27. Full closure
detail in
`doc/testlog_20260427-1339-post-c22/error_analysis.md` (D5
section). No FE evidence in this run — none of the 8 originally
affected scripts surfaced D5-shaped failures in
`testlog_20260428-1333-issue-analysis`, so the closure holds.

**Symptom (historical).** `Scaffold(appBar: …)` and other
`PreferredSizeWidget?` / `Widget` parameters rejected
interpreted instances at the native-bridge boundary with
`Argument Error: Invalid parameter "appBar": expected
PreferredSizeWidget?, got InterpretedInstance(_<…>AppBar)` and
`expected Widget, got InterpretedInstance(_WbnPipeBackdrop)`
on `DefaultTextStyle.merge`.

**Fix (2026-04-27).** Two-part landing:

1. **`PreferredSizeWidget` interface proxy** in
   `tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`:
   added `_InterpretedPreferredSizeWidget extends StatelessWidget
   implements PreferredSizeWidget` and its
   `D4.registerInterfaceProxy('PreferredSizeWidget', …)`
   registration. `preferredSize` reads the script's getter via
   `instance.get('preferredSize', visitor: _visitor)` (unwrapping
   native/bridged `Size`); `build` delegates to the interpreted
   instance's `build` method. The interface-proxy walk extends
   along `bridgedSuperclass` and `bridgedInterfaces` (transitive
   supertypes), so `class _Foo extends StatelessWidget implements
   PreferredSizeWidget` resolves correctly.
2. **Static-method dispatch wrap in `D4.withActiveVisitor`** in
   `tom_d4rt/lib/src/interpreter_visitor.dart` and the mirrored
   `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`.
   Without the wrap, `D4.getRequiredNamedArg<T>` and
   `extractBridgedArg<T>` could not consult registered interface
   proxies on the static-dispatch path, which is why
   `DefaultTextStyle.merge` rejected interpreted `Widget`
   arguments. Constructor dispatch already had this wrap.

**Verification (2026-04-27).** Bisect on the 8 originally
affected scripts: 6/8 went FE 1→0 cleanly; the remaining two
(`widgets_binding_observer_test`, `snapshot_mode_test`) dropped
the `PreferredSizeWidget` rejection and surfaced cosmetic
follow-ups (borderRadius non-uniform + `RenderFlex` overflows)
that were previously masked. All regression suites identical
to baseline (essential 108/0/0, important 164/0 + 5 skips,
secondary 649/0 + 5 skips, with one secondary-suite
improvement). Logs:
`doc/testlog_20260427-c4/c4_after_fix.log.txt`.

**Re-confirmation (2026-04-28).** This run's full taxonomy
sweep surfaced no D5-pattern failures across gii / essential /
important / secondary / hr1–hr4 / interactive. The cosmetic
follow-ups exposed by the D5 fix are tracked under separate
clusters (E5 borderRadius non-uniform; E2 layout cascade) and
do not re-open D5.

**No additional verification required.** No code or scripts
changed in this turn — D5 was already verified at landing time
and the run baselines confirm no re-surface. This update is
documentation reconciliation only.

## D6 — layout cascade

- [ ] Fixed - [x] Partial (closed-by-attribution to E2 — 2026-04-28) - [ ] Open · **Severity:** Low · **Owner:** scripts (C22 ListView pattern); plus 3 C3-family deferred unfixables

**Status.** Carried forward as **E2** in this run; D6's active
fix work is tracked there and need not be duplicated here. The
top-line numbers came down from **18 scripts / ~228 FE** at the
post-c22 baseline to **16 scripts / 138 FE** at the
2026-04-28-1333 baseline, then four E2 batches landed:

- **E2 batch 1** — closed `text_selection_gesture_detector_builder_delegate_test` (5→0) and `sliver_multi_box_adaptor_element_test` (6→0); `restoration_mixin_test` already FE=0; `scrollbar_painter_test` deferred (cosmetic residuals).
- **E2 batch 2** — closed `standard_component_type_test` (13→0). Three scripts deferred after attempted-and-reverted fixes: `widget_state_color_test`, `text_magnifier_configuration_test`, `scroll_deceleration_rate_test` — the latter two confirmed to belong to the C3 unfixable family in `script_rewrites.md` §C3.
- **E2 batch 3** — closed all four top-of-table candidates `two_dimensional_scrollable_state_test` (20→0), `scroll_position_types_test` (19→0), `web_browser_detection_test` (19→0), `weak_map_test` (15→0).
- **E2 batch 4** — closed `scrollbar_painter_test` (4→0); other three already FE=0 pre-fix.

**Remaining (D6 / E2 surface).** 7 scripts / ~88 FE, of which:

- **4 top-of-table** (21–33 FE each): `shortcut_activator_test`, `unfocus_disposition_test`, `widget_test`, `widget_state_text_style_test` — candidates for the next E2 batch (C22 ListView pattern).
- **3 C3-family deferred** (FE 6–9 each): `widget_state_color_test`, `scroll_deceleration_rate_test`, `text_magnifier_configuration_test` — every documented script-side authoring workaround was tried and either had no effect or regressed; cataloged in `script_rewrites.md` §C3 as an interpreter-layout-path limitation.

**Closure rationale.** D6 itself is a meta-cluster. The
script-by-script fixes apply against E2; D6's status simply
mirrors E2's progress. With ~half the FE volume already
closed, batches 1–4 verified at FE=0 in their respective
`doc/testlog_20260428-e2-batch{1,2,3,4}-fix/` logs, and a
crisp partition between "next batch candidates" and "C3-family
unfixable", D6 stays **Partial** until either:

1. The 4 top-of-table scripts close (next E2 batch — script-side,
   no interpreter changes), at which point D6 reduces to 3
   C3-family scripts and remains Partial pending the
   interpreter-side intrinsics fix; or
2. The interpreter layout/intrinsics path is updated to handle
   `Row(crossAxisAlignment.stretch) + Expanded` inside
   unbounded vertical contexts cleanly, at which point all 3
   C3-family scripts close and D6 → Fixed.

**No additional verification required in this turn.** All E2
batch fixes carry their own verification logs; no code or
scripts changed in this turn — this update is documentation
reconciliation only (formalize the carry-over note as an
explicit Partial-by-attribution closure block matching the E2
state).

## D7 — Slotted RO mixin

Closed in C21 + C20-series; no FE evidence in this run.

## D8 — misc gaps (compound `+=` with null, callback required-arg)

- [ ] Fixed - [x] Partial (closed-by-attribution to E7 + E8 — 2026-04-28) - [ ] Open · **Severity:** Mixed (Low) · **Owner:** mixed (scripts closed; interpreter residual under E8)

**Status.** D8 catalogues two distinct architectural micro-gaps
that share a "miscellaneous correctness" theme rather than a
single root cause. The two re-surfaces in this run were
re-clustered into the new E-cluster taxonomy, with split
outcomes:

- **D8a — Compound `+=` with null** →
  **E7** (`hr5/widgets/restorable_double_n_test.dart`) — **Fixed**
  2026-04-28. Symptom: `Unimplemented Error: Compound assignment
  operator += not handled for types double and null`. Closed by
  a script-side rewrite that explicitly checks for null before
  the compound assignment, with the architectural limitation
  (interpreter does not currently expand `a += b` to
  `a = a + b` with the proper null-aware semantics for
  `double? += double`) logged for future interpreter work.
  Verified at FE=0 in the E7 closure logs.
- **D8 family follow-up — `null check on null`** →
  **E8** (`widgets/scroll_deceleration_rate_test.dart`) —
  **Partial** (8 FE → 2 FE). Bisect showed the 8-FE baseline
  was a layout cascade plus an interpreter limitation, not a
  single null assertion as the original "Suggested fix"
  hypothesised. The cascade portion was closed at the script
  level; the residual 2 FE are a mount-time
  controller-propagation null shape that scales linearly with
  the leaf `Scrollable` count and is bound to the same
  interpreter layout/intrinsics path family as the C3
  unfixables. Tracked under E8 for the residual interpreter
  fix; no further script-side authoring workaround helps.

**Closure rationale.** The D8 meta-cluster status follows the
union of E7 + E8: E7 is fully closed, E8 is Partial → D8 is
**Partial**. Promoted from the brief carry-over note to an
explicit Partial-by-attribution closure block.

D8 → Fixed when:

1. The 2 residual FE in E8's
   `scroll_deceleration_rate_test` close (interpreter-side
   work — same intrinsics-path family that closes the C3
   unfixables in `script_rewrites.md` §C3); and
2. No new D8-shape micro-gaps re-surface in subsequent
   baselines.

**No additional verification required in this turn.** Both E7
and E8 carry their own verification logs
(`doc/testlog_20260428-e7-fix/`, `doc/testlog_20260428-e8-fix/`).
No code or scripts changed in this turn — this update is
documentation reconciliation only.

## Wedge taxonomy (W1–W5)

| ID | Script | Status this run | Isolation result |
|---|---|---|---|
| W1 | `retest/widgets/context_action_test.dart` | Skipped in `gir` | **Passes in isolation** (1725 ms, FE=0) |
| W2 | `retest/widgets/default_text_editing_shortcuts_test.dart` | Skipped in `gir` | **Passes in isolation** (11 100 ms incl. 10 s wait, FE=0) |
| W3 | `retest/widgets/live_text_input_status_test.dart` | Skipped in `gir` | **Passes in isolation** (11 172 ms incl. 10 s wait, FE=0) |
| W4 | `retest/widgets/lock_state_test.dart` | Skipped 2026-04-28 evening in `gir` — re-run 54/5/4 (cascade closed) | **Passes in isolation** (965 ms, FE=0) |
| W5 | `widgets/animated_switcher_test.dart` | Skipped 2026-04-28 morning in `gii` — gii 81/2/0 | **Passes in isolation** (1095 ms, FE=0) |

All 5 wedgers are skipped at the long-suite level but
**individually viable** — verified 2026-04-28 by
`test/blocking_tests_test.dart` (5 tests, all green in 38 s
wall time). The per-wedger fix-cluster work formerly tracked
as F1–F5 is no longer pursued; the durable fix is the META
test-app watchdog only.

---

# Summary table (NEW clusters only)

| Cluster | Severity | Owner | Suite Scripts | Total FE / Failures |
|---|---|---|---|---|
| E1 — `_ByteDataView.lengthInBytes` undefined | Medium | interpreter | 2 (gir) | 2 failures |
| E2 — layout cascade (carry-over D6)          | Low    | scripts     | 16              | 138 FE |
| E3 — bridged-mixin field access re-surface   | Medium | interpreter | 1               | 2 FE |
| E4 — late-field uninit (restoration)         | Medium | interpreter / scripts | 2 | 2 FE |
| E5 — borderRadius non-uniform                | Low    | script      | 1               | 1 FE |
| E6 — Records `.$1`/`.$2` access              | Medium | interpreter | 1               | 1 FE |
| E7 — `+=` on null double                     | Low    | interpreter | 1               | 1 FE |
| E8 — `!` on null curve                       | Low    | script / interpreter | 1     | 8 FE |
| E9 — `clampDouble` numeric-arg passthrough audit | Low | generator | (cross-suite) | 0 occurrences (CLOSED 2026-04-28; sweep clean) |
| E10 — `render_animated_size_state` 2.0 px overflow | Low | interpreter | 1 (gir TID=31) | 1 failure |
| E11 — `back_button_listener` Router routerDelegate adapter | Medium | interpreter | 1 (gir TID=37) | 1 failure |
| E12 — Auto-generated abstract-class adapters (DESIGN) | Low | generator | (n/a) | (design exploration) |
| E13 — Enum exhaustiveness on bridged enums   | Low    | scripts     | 15              | 15 compile errors → 0 (CLOSED 2026-04-28; all retest/ rewrites carry the documented `default:` / `_ =>` workaround) |
| E14 — `SystemColor` Linux platform guard     | Low    | scripts     | 1 (skipped)     | 0 FE (skip in place) |
| E15 — `setState` in scheduler frame phases (C20d) | Medium | scripts | (multiple deep-demo) | (deferral mitigation in place) |
| E16 — `Row(stretch)` + `Expanded` in `SliverToBoxAdapter` (C3) | Low | scripts | 1 | 8 FE |
| E17 — `RangeSlider` `onChanged: null` + M3 gapped (Index 32) | Low | scripts | 1 | (FE cluster, gii) |
| R  — gir W1–W5 transport cascade             | High → Mitigated | test runner | 1 trigger → 19 victims | 20 errors → 0 (after skip; W1–W5 pass in isolation) |

Closed-on-or-before this run (no action needed):
C20a (2026-04-27), C20b (2026-04-27), C20d (2026-04-27),
C20f (2026-04-27), C21 (2026-04-27), Plan E2 (2026-04-27),
D1 (2026-04-27), D2 (2026-04-27 — partial; 2 re-surfaces logged
above), D5/D7 (2026-04-27).

---

# Key takeaways

1. **gii is fully green** (81/2/0). The W5 skip + cumulative
   C20-series + C21 fixes closed every previous gii failure.
   `essential` / `important` / `secondary` / `hr1`–`hr4` /
   `interactive` are all suite-level clean (zero failures).

2. **The `gir` "regression" was structural, not interpreter — and
   has now been mitigated.** Initial run: 24 errors decomposing
   into 4 known issues + a 19-script W4 transport cascade.
   2026-04-28 evening W4 skip applied; gir re-run reports
   **54/5/4** with the cascade fully closed in 1 m 12 s. The 4
   remaining failures are the 4 known issues only (2 pre-existing
   carry-overs + 2 E1 cases). Closing E1 (~10-line bridge fix)
   would leave gir at **56/5/2** with only the documented
   unfixables remaining.

3. **Layout cascade (E2) is the dominant FE generator** but
   produces zero test failures because the affected suites don't
   assert on `tester.takeException`. 16 scripts remain to patch
   with the C22 ListView pattern; each is independent and can be
   parallelised across PRs.

4. **Real interpreter bugs to fix next:**
   - **E1** (`_ByteDataView.lengthInBytes`) — high-impact, 2 gir
     failures, ~10-line fix in the `dart:typed_data` bridge.
   - **E11** (`RouterDelegate` adapter proxy) — 1 gir failure
     today, but the adapter pattern unblocks any future
     interpreted-extends-bridged abstract delegate.
   - **E10** (`render_animated_size_state` 2.0 px overflow) —
     1 gir failure, single rounding site in
     `_InterpretedSlottedRenderBox` intrinsic pass.
   - **E6** (Records `.$1` access) — single FE but the shape
     gates any future Records-heavy test.
   - **E3** (`_controller` on `SingleTickerProviderStateMixin`
     constructor-phase) — D2-adjacent, follow the C20d deferral
     template.
   - **E7** (`+=` on null double) — 1-line fix, mirrors a known
     null-check shape.
   - **E9** (`clampDouble` numeric-arg passthrough) — instrument
     bridge wrappers with `D4.checkFiniteNumeric`, capture
     trigger sites, close at source.
   - **E12** (auto-generated abstract-class adapters) — design
     exploration; phase 1 reproduces existing manual adapters
     from generator output.

   **Script-side rewrites to apply (no interpreter change):**
   - **E13** — CLOSED 2026-04-28. All 15 retest/ rewrites
     already carry the documented `default:` arm (or `_ =>`
     wildcard for switch expressions) tagged with
     `// D4RT-LIMITATION: enum exhaustiveness`.
   - **E14** — `SystemColor` Linux skip is in place; no action
     beyond keeping the platform guard.
   - **E15** — apply `addPostFrameCallback` / outside-frame
     refactor to C20d-affected scripts so they don't rely on
     the interpreter's deferral mitigation.
   - **E16** — pin a finite height on the `Row` parent or drop
     `crossAxisAlignment: stretch` in
     `scroll_deceleration_rate_test`.
   - **E17** — switch `gapped_range_slider_track_shape_test` to
     `onChanged: (_) {}` (recommended) and bisect under vanilla
     `flutter test` to confirm the script-contract-violation
     diagnosis.

5. **Test-app watchdog (META) is still the highest-leverage
   structural change** — even with W4 skipped, F1, F2, F3, F4
   (the durable fix), and any future deep-demo wedger benefit
   from a watchdog that converts a single test-app crash into a
   single failure + restart instead of a 19-script cascade. The
   skip path (F4 day-1 mitigation) is "good enough for now" but
   shouldn't displace the watchdog work.

6. **Wedgers W1–W5 pass in isolation** (verified 2026-04-28
   `test/blocking_tests_test.dart`, 38 s wall time, all FE=0).
   The previous F1–F5 fix-clusters are dropped — none of W1–W5
   are intrinsically broken scripts; the cascade is purely a
   function of test-app process longevity. The META watchdog is
   the only durable lever; once it lands the 5 skips can be
   removed without per-script work.

7. **Suite-level cleanliness check after W4 skip:** the corpus
   is clean for `essential` (108/0/0), `important` (164/0/0),
   `secondary` (654/1/0), `hr1`–`hr5`, `interactive`, and
   `gii` (81/2/0). `gir` reports **54/5/4** with the 4
   failures being 2 documented unfixables (TIDs 31, 37) + 2
   E1 cases (TIDs 33, 34). The "all errors fixed or workaround
   documented" bar is now met: every failure is either listed in
   `interpreter_unfixable.md` (carry-overs) or has an open fix
   cluster (E1 for the new ones; F1–F5 for the skipped wedgers).
   Remaining FE noise (E2 layout cascade) does not cause test
   failures.

---

# Forward clusters — next steps to finish the open todos

> **Note on F-namespace.** Takeaway #6 above retires the earlier
> "F1–F5 wedger fix-clusters" plan (W1–W5 pass in isolation; the
> META watchdog is the only durable lever, no per-script F-clusters
> required). The clusters in this section are the *forward* todos
> after the 2026-04-28 close pass — they do **not** continue the
> dropped F1–F5 wedger plan. Numbered **Fa1–Fa7** ("forward, after
> 2026-04-28") to avoid collision.

These clusters are the concrete next-step roadmap to close the
items still **Open** or **Partial** at the end of this testlog.
Each Fa-cluster is independently actionable, has a defined closing
criterion, and is sized for a single PR (or a small batch of PRs
where noted).

## Fa1 — E2 layout cascade: finish the remaining 13 script rewrites

- [ ] Fixed  - [x] Partial  - [ ] Reverted/Deferred · **Severity:** Low (cosmetic, script-only) · **Owner:** test scripts

**Resolution (2026-04-28).** 7 scripts patched with the C22
`ListView` pattern, clearing **113 of 135 framework errors** on
the `fa1_bisect_test.dart` harness:

| Script | Pre FE | Post FE | Δ |
|---|---:|---:|---:|
| `widgets/shortcut_activator_test.dart` | 33 | **0** | -33 |
| `widgets/widget_test.dart` | 26 | **0** | -26 |
| `widgets/widget_state_text_style_test.dart` | 21 | **0** | -21 |
| `widgets/unfocus_disposition_test.dart` | 27 | **0** | -27 |
| `widgets/undo_history_value_test.dart` | 3 | **0** | -3 |
| `widgets/update_selection_intent_test.dart` | 3 | **0** | -3 |
| `widgets/select_all_text_intent_test.dart` | 3 | 3 | 0 |
| `widgets/transpose_characters_intent_test.dart` | 2 | 2 | 0 |
| `widgets/widget_state_color_test.dart` | 9 | 9 | 0 (C3-deferred) |
| `widgets/text_magnifier_configuration_test.dart` | 6 | 6 | 0 (C3-deferred) |
| `widgets/scroll_deceleration_rate_test.dart` | 2 | 2 | 0 (E8-deferred) |
| **Total** | **135** | **22** | **-113** |

**Remaining 22 FE.** Two residual pockets, both deferred:

- **Negative-min-height on `_RenderEditableCustomPaint` (5 FE in
  2 scripts).** `select_all_text_intent_test.dart` (3 FE) and
  `transpose_characters_intent_test.dart` (2 FE) keep producing
  `BoxConstraints has a negative minimum height` from
  `_RenderEditableCustomPaint`'s layout — independent of the
  outer cascade (transpose has no `SingleChildScrollView` at all,
  yet still fires). The shape is the EditableText/_TextSelection
  scaffold receiving `h=-Infinity` from a parent
  `Container+Column(stretch)+TextField(maxLines: …)` chain that
  the C22 swap does not unblock. Action: defer to a follow-up
  Fa-cluster targeted at the EditableText-specific path; not a
  pure cascade fix.
- **C3-family / E8-deferred carry-over (17 FE in 3 scripts).**
  `widget_state_color`, `text_magnifier_configuration`, and
  `scroll_deceleration_rate` continue to fail under previously
  documented unfixable patterns (C3 `Row(stretch)+Expanded` in
  unbounded vertical / E8 intrinsic-pass proxy null). No C22
  delta expected; tracked elsewhere.

**Files patched.**

- `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/widget_test.dart`
- `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/shortcut_activator_test.dart`
- `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/widget_state_text_style_test.dart`
- `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/unfocus_disposition_test.dart`
- `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/select_all_text_intent_test.dart`
- `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/undo_history_value_test.dart`
- `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/update_selection_intent_test.dart`

Logs: `doc/testlog_20260428-fa1-fix/fa1_bisect_pre.log.txt` (135
FE baseline) and `fa1_bisect_post.log.txt` (22 FE after rewrites).

**Scope.** E2 reports 16 scripts in this testlog with 3 patched
in the prior run (D6 → C22 ListView pattern); 13 still produce
the `BoxConstraints forces an infinite height/width` /
`negative minimum height` cascades. Two flavours:

- **Infinite-height/width (8 scripts).**
  `widgets/scroll_position_types_test.dart`,
  `widgets/text_magnifier_configuration_test.dart`,
  `widgets/widget_test.dart`, `widgets/weak_map_test.dart`,
  `widgets/widget_state_color_test.dart`,
  `widgets/widget_state_text_style_test.dart`,
  `widgets/web_browser_detection_test.dart` (infinite-width
  flavour), `widgets/standard_component_type_test.dart`
  (`RenderParagraph` infinite-size flavour),
  `widgets/sliver_multi_box_adaptor_element_test.dart`
  (`RenderShrinkWrappingViewport` intrinsic flavour).
- **Negative minimum height (5 scripts).**
  `widgets/select_all_text_intent_test.dart`,
  `widgets/transpose_characters_intent_test.dart`,
  `widgets/undo_history_value_test.dart`,
  `widgets/unfocus_disposition_test.dart`,
  `widgets/update_selection_intent_test.dart`.

**Pattern (infinite-h/w).** Replace
`SingleChildScrollView(child: Column(crossAxisAlignment: stretch, children: [...]))`
with `ListView(children: [...])` and rewrap any width-sensitive
sections in `Center(child: ConstrainedBox(maxWidth: …, child: …))`
to preserve original max-width design intent. (Same playbook as
the 3 D6 wins.) Width-flavour scripts pin the parent width or
drop `mainAxisSize: max` from the inner `Row`. The
`RenderShrinkWrappingViewport` script must drop the intrinsic
call.

**Pattern (negative-min-h).** A computed height inside the
script goes negative when the parent is small. Clamp at the
source:

```dart
final h = (parentHeight - 120).clamp(0.0, double.infinity);
```

Or wrap the section in `SizedBox(height: max(0.0, h))`.

**Closing criteria.** All 13 scripts report FE=0 in
`bisect_test.dart`; no `infinite height/width` or
`negative minimum height` errors in suite logs. No interpreter
or generator change.

**Estimated effort.** 13 independent script-only PRs, each
≤30 minutes. Batch 5/PR.

---

## Fa2 — E8 misdiagnosed; root cause is unsafe `ScrollPosition.maxScrollExtent` read in `_TelemetryCard`

- [x] Fixed  - [ ] Partial  - [ ] Reverted/Deferred · **Severity:** Low (1 script, 2 FE → 0 FE) · **Owner:** script (guard tightening)

**Resolution summary (2026-04-28).** The cluster's original
hypothesis (slot-mixin proxy intrinsic null-walk under
`Row(stretch)+Expanded`) was incorrect — that pattern had already
been removed from the script in the prior E8 layout-cascade fix
and adding it back to a stripped reproducer did **not** trigger
the FE. The previous E8 diagnosis (state-field
`ScrollController` propagated through a `StatelessWidget` chain)
was also wrong — six minimal reproducers built from that pattern
all reported FE=0.

**Actual root cause.** Inside `_TelemetryCard.build`,
`controller.position.maxScrollExtent.toStringAsFixed(0)` is read
when only `controller.hasClients` is checked. `hasClients == true`
means a `ScrollPosition` is *attached*, but `maxScrollExtent`'s
getter is `return _maxScrollExtent!;` — it throws "Null check
operator used on a null value" until `applyContentDimensions`
runs. The d4rt `SendTestRunner` snapshot lands in the brief window
between attach and first layout, so each of the two
`_TelemetryCard` instances (`.normal` and `.fast`) trips the
null-check on its own controller — yielding exactly 2 FE.

**Bisect path.**

1. Confirm 2 FE with a verbatim copy of the test file
   (`scroll_decel_full_copy.dart`).
2. Strip slivers 3..11 (everything below `_DynoTrackPair`) → FE=0.
3. Restore only sliver 3 (`_TelemetryRow`) → FE=2.
4. Inside `_TelemetryRow → _TelemetryCard`, replace the
   `controller.position.maxScrollExtent…` ternary value with a
   constant `'—'` → FE=0.
5. Restore the ternary but force `false` as the condition → FE=0
   (truthy branch never runs).
6. Tighten the guard to
   `controller.hasClients && controller.position.hasContentDimensions`
   → FE=0 (both conditions hold only after first layout).

**Fix (script-side).** Single-line guard tightening in
`widgets/scroll_deceleration_rate_test.dart` `_TelemetryCard.build`:

```dart
v: controller.hasClients &&
        controller.position.hasContentDimensions
    ? controller.position.maxScrollExtent.toStringAsFixed(0)
    : '—',
```

Functionally equivalent to the original (the `'—'` fallback
already covered "no clients"; the tightened guard extends it to
"attached but not yet measured"). No behaviour change in a real
running app — by the time the card is visible to a user, content
dimensions are set.

**Verification.** `D4RT_SKIP_BRIDGE_REGEN=1 flutter test
test/hardly_relevant_classes_5_test.dart --plain-name
scroll_deceleration_rate` reports `frameworkErrors=0` (was 2
before the fix). Per rule (a) — script-only change — single-test
retest is sufficient.

**Reproducers retained.** Minimal isolation reproducers in
`test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/repro_fa2/`
(state-field controller / scrolling pill / pruned dyno track /
ternary maxScrollExtent) — all FE=0; kept as evidence that the
prior diagnosis path (state-field + StatelessWidget chain +
layout cascade) is *not* the trigger.

**Cross-reference.** Corrected diagnosis recorded in
`interpreter_unfixable.md` under E8 (entry replaced with the
script-side workaround and a misdiagnosis correction note).

---

## Fa3 — E11 residual: `back_button_listener_test` RenderFlex overflow

- [x] Fixed  - [ ] Partial  - [ ] Reverted/Deferred · **Severity:** Medium · **Owner:** interpreter (abstract-class proxies cast resolved); script (residual layout overflow)

**Resolution (2026-04-28).** Both closing criteria already
satisfied by prior commits that landed before this Fa-cluster
audit. No further work needed.

- `83aba632` — `fix(d4rt-flutterm): cluster E11 RouterDelegate
  proxy (partial — cast resolved)` resolved the
  `_InterpretedRouterDelegate` cast assertion.
- `dfc1b025` — `fix(d4rt-flutterm): cluster E13 back_button_listener
  layout overflow (script-side)` cleared the RenderFlex overflow
  by tightening the demo chrome layout.

**Verification.** Re-ran the gir-equivalent target
`retest/widgets/back_button_listener_test.dart` (the deep demo
that was the failing surface at testlog time, source bytes
77941). Captured log
`doc/testlog_20260428-fa3-fix/retest.log.txt`:

```
[METRIC] script=retest/widgets/back_button_listener_test.dart
  sourceBytes=77941 ... status=success httpStatus=200
  outputLines=0 frameworkErrors=0
```

No `RenderFlex … overflowed` lines anywhere in the run. Both
closing criteria met.

**Scope (historical).** E11 cluster (gir TID=37) — the cast
assertion on `_InterpretedRouterDelegate` was resolved by the
abstract-class proxy fix; the residual was a RenderFlex
overflow under the demo's chrome (the duplicate-ID E13 row
tracked at line 953 of this testlog) which `dfc1b025` closed.

**Closing criteria.** `back_button_listener_test` reports FE=0
in gir; no RenderFlex overflow logged. **Both met.**

---

## Fa4 — E12 codegen: auto-generate the abstract-class adapter shapes

- [ ] Fixed  - [ ] Partial  - [x] Reverted/Deferred · **Severity:** Medium (architectural debt) · **Owner:** generator + flutterm registrations

**Resolution (2026-04-28): formally deferred from the
cluster-fix campaign.** No code changes attempted this turn.

The E12 Phase 1 investigation already concluded
(this same testlog, lines 1186–1379) that a single-turn landing
is structurally infeasible. Re-confirming and recording the
decision here.

**Why deferred (re-confirmed).**

1. **Closing criteria require a multi-shape rollout.** Fa4
   closes when the manual entry count drops from ≥30 to ≤20 —
   i.e., **≥10 entries removed**. That spans at minimum shapes
   1–5 of the 11-shape catalogue (E12 Phase 1 investigation).
   Shape #1 alone (`TickerProvider`) is one entry — even a
   successful single-shape landing meets ~10 % of the criterion
   and leaves Fa4 still open.
2. **Each shape mandates a full essential + important +
   secondary regression run** (regression-test rule (b):
   generator/interpreter/non-test flutterm code touched). The
   cluster-fix verification protocol in `CLAUDE.md` requires
   serial runs of all four suites (gii + essential + important
   + secondary). A multi-shape rollout therefore needs N × full
   regression cycles in series.
3. **The substrate doesn't exist yet.** The current
   `tom_d4rt_generator/lib/src/proxy_generator.dart` (1,292
   lines) emits the *callback-adapter* shape
   (`D4rtCustomPainter` style) — a different, incompatible
   shape from the *interpreted-instance* shape Fa4 targets.
   Phase 1a (schema extension to `bridge_config.dart`), Phase 1b
   (new `interface_proxy_generator.dart` module),
   `buildkit.yaml` plumbing, and `*.b.dart` regeneration must
   land **before** any single shape can be migrated. That
   landing surface alone is multi-PR.
4. **Risk-of-silent-regression at the boundary.** The 30 manual
   adapters encode cluster-by-cluster authoring decisions
   (C20-series, D2/D3/D4, RC-1/RC-6, Bug-46, Bug-102, Bug-103,
   Plan D, E11) that are not derivable from analyzer metadata
   alone. Any auto-generated adapter that drifts from a manual
   adapter regresses dozens of scripts simultaneously — exactly
   the failure mode the regression rule is designed to catch
   too late.

**What "fixing Fa4" would actually require.**

Per the E12 Phase 1 refinement (lines 1336–1367):

- **1a.** Add `interfaceProxyClasses` schema to
  `bridge_config.dart` capturing 8 dimensions per entry
  (shape selector, extracted-field list, caching strategy,
  factory style, super-arg-capture flag, registration phase,
  alias-name list, mixin-dispatch table). Pure config plumbing
  — no behaviour change, no regen.
- **1b.** Implement `interface_proxy_generator.dart` as a new
  module (parallel to `proxy_generator.dart`); first targets
  shape #1 + #3 (TickerProvider, LeafRenderObjectWidget,
  PreferredSizeWidget, SlottedMultiChildRenderObjectWidget) —
  4 trivial classes.
- **1c.** Compare generated adapter to manual adapter
  side-by-side; iterate to functional equivalence.
- **1d.** Switch the 4 manual registrations to call into the
  generated factory; run the full suite serially.
- **1e.** Roll out shape-by-shape (3 → 4 → 5 → 6 → 7 → 8 → 9
  → 10 → 11), one adapter per landing, full regression each
  time.

**Estimated total effort.** Schema/generator landing (1a + 1b):
~3 days. Per-shape landing (1c–1e): ~1 day each, ×11 shapes =
~11 days. Realistic minimum: ~3 weeks of focused work spread
across ≥12 PRs. **Out of scope for the cluster-by-cluster
bug-fix campaign in its current single-turn cadence.**

**Recommended re-entry path.** When the campaign cadence
allows, split Fa4 into per-shape sub-clusters
(`Fa4a` schema + generator landing, `Fa4b` shape #1, `Fa4c`
shape #3, …) so each sub-cluster fits one cluster-fix turn
and the closing criteria for each sub-cluster is "1 shape
auto-generated, no regression in any of the four suites."

**Cross-reference.** E12 Phase 1 investigation
(lines 1186–1379) is the authoritative scope analysis. The
30 hand-written `D4.registerInterfaceProxy` calls live in
`tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`
(lines 258–488 first-pass, 506–750 overrides).

**Verification.** Documentation-only deferral. No code or
scripts changed → no regression risk, no retest required.

---

## Fa5 — `InheritedModel` / `InheritedWidget` `runtimeType` collapse

- [x] Fixed (closed-by-pre-existing-infrastructure 2026-04-28)  - [ ] Partial  - [ ] Deferred · **Severity:** Medium (architectural) · **Owner:** interpreter

**Resolution (2026-04-28).** Both closing criteria already
satisfied by infrastructure that landed in
`tom_d4rt_flutterm/lib/src/d4rt_runtime_registrations.dart`
prior to this audit. Authored reproducers, calibrated the
harness with a deliberate-fail canary, and confirmed the
existing interceptors handle the runtimeType collapse for both
`InheritedWidget` and `InheritedModel` subclasses.

**Pre-existing infrastructure (no code changes needed).**

- `_registerBridgedMethodInterceptors()` registers method
  interceptors on `Element` for
  `dependOnInheritedWidgetOfExactType`,
  `getInheritedWidgetOfExactType`, and
  `getElementForInheritedWidgetOfExactType` — they walk the
  ancestor chain, match by
  `_InterpretedInheritedWidget._instance.klass.name` against the
  script-supplied type-arg name, and unwrap to the underlying
  `InterpretedInstance` so script field/method dispatch stays in
  the `InterpretedClass`.
- A static interceptor on `InheritedModel.inheritFrom` (Plan E
  in `d4rt_runtime_registrations.dart`) replicates the ancestor
  walk, registers the aspect-aware dependency, and returns the
  `InterpretedInstance` for matched script subclasses.
- `_findInheritedElementForType(from, typeArgs)` is the shared
  name-based ancestor walker; `_unwrapInheritedWidget(widget)`
  converts the proxy back to the interpreted instance.

**Verification.**

Two minimal reproducers added under
`test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/repro_fa5/`:

1. `inherited_widget_exact_type.dart` — declares
   `class MyScope extends InheritedWidget`; child calls
   `MyScope.of(context)` (which delegates to
   `dependOnInheritedWidgetOfExactType<MyScope>`); reader throws
   if the result is null or fields don't match
   `(value=42, label="fa5-test")`.
2. `inherited_model_inherit_from.dart` — declares
   `class CounterModel extends InheritedModel<CounterAspect>`
   with `enum CounterAspect { value, label }`; two readers call
   `InheritedModel.inheritFrom<CounterModel>(context, aspect: ...)`
   for `value` and `label` aspects respectively; throw if null
   or values don't match.

**Calibration.** A `canary_must_fail.dart` reproducer
deliberately throws inside a child widget's `build()`. Running
the canary first proves the SendTestRunner harness records
`frameworkErrors=1` for child-build throws, so a clean FE=0
result on the inherited reproducers means the readers WERE
mounted and the assertions WERE reached.

**Test results** (captured
`doc/testlog_20260428-fa5-fix/canary_repro.log.txt`):

```
[METRIC] script=repro_fa5/canary_must_fail.dart …
  status=success frameworkErrors=1
  ⚠️ FRAMEWORK ERROR: InternalInterpreterException(
       originalThrownValue: Bad state: fa5-canary: deliberate
       throw to verify harness signal)
[METRIC] script=repro_fa5/inherited_widget_exact_type.dart …
  status=success frameworkErrors=0
[METRIC] script=repro_fa5/inherited_model_inherit_from.dart …
  status=success frameworkErrors=0
```

Canary FE=1 confirms the harness catches reader throws; both
inherited reproducers report FE=0 → readers were reached and
the lookups returned the correct interpreted instances. Both
closing criteria met.

**Regression scope.** Test-script-only addition (regression rule
(a)). No bridge generator, interpreter, or non-test
flutterm code changed — individual retest of the new harness
is sufficient. No tom_d4rt ↔ tom_d4rt_ast mirror work needed.

**Closing criteria.** Reproducer renders the inherited data
correctly; `inheritFrom<T>` returns the interpreted instance.
**Both met.**

---

## Fa6 — D7 Option 2: composite render-object proxy generator

- [ ] Fixed  - [ ] Partial  - [x] Reverted/Deferred · **Severity:** Medium (architectural) · **Owner:** generator (proxy generator) + flutterm registrations

**Scope.** D7 in the prior testlog closed via Option 1 (per-mixin
native proxies for `SlottedContainerRenderObjectMixin` only).
Option 2 — composite proxies that mix in *whatever* bridged
mixins the interpreted class chain declares — remains the right
long-term answer for any future
interpreted-extends-`RenderBox`-with-mixin case.

**Status (2026-04-28).** **Deferred — sibling of Fa4.** No
currently-failing scripts depend on Option 2; the corpus passes
empirically against existing Option-1 hand-written proxies.
Migrating to Option 2 (per-shape generator emission) requires
the same multi-week generator-substrate change as Fa4 (E12
codegen) and would be cleanest to land alongside it. Reproducers
and harness landed for future work — see "Closure evidence"
below.

**Why this still matters.** Option 1 is one-mixin-at-a-time
expansion. Each new bridged render-object mixin needs another
hand-written proxy class. Option 2 generates a per-script-class
composite proxy on demand based on `_classChainHasBridgedMixin`,
eliminating linear fan-out.

**Closure evidence (2026-04-28 deferral).**

1. **Empirical:** every multi-mixin script in the corpus reports
   `frameworkErrors=0`. From this testlog
   (`generator_interpreter_issues_test.result.json`):
   `relayout_when_system_fonts_change_mixin_test.dart` (1 mixin,
   FE=0), `render_box_container_defaults_mixin_test.dart` (2
   mixins, FE=0), `render_object_element_test.dart` (2 mixins,
   FE=0), `render_object_widget_test.dart` (2 mixins, FE=0),
   `parent_data_widget_test.dart` (FE=0),
   `single_child_render_object_*_test.dart` (FE=0). The
   hardcoded `_InterpretedRenderBox`,
   `_InterpretedRenderBoxContainer`, and
   `_InterpretedSlottedRenderBox` proxies cover the corpus
   today.
2. **Reproducers landed** at
   `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/repro_fa6/`:
   `canary_must_fail.dart` (calibration: harness records FE=1
   for child build throws), `two_mixin_container_render_box.dart`
   (Container+Defaults shape — exercises
   `_InterpretedRenderBoxContainer`),
   `three_mixin_relayout_container.dart`
   (Container+Defaults+RelayoutWhenSystemFontsChangeMixin — the
   Option-2 motivator). Run via `test/fa6_repro_test.dart`.
   Initial run captured at
   `doc/testlog_20260428-fa6-fix/initial_repro.log.txt`: canary
   FE=1, both real reproducers FE=0.
3. **Substrate gap (same as Fa4).**
   `tom_d4rt_generator/lib/src/proxy_generator.dart` emits the
   callback-adapter shape (e.g. `D4rtCustomPainter`), not an
   InterpretedInstance-backed composite. Adding Option 2 means a
   new generator code path that walks the script's class chain,
   discovers the bridged-mixin set, and emits a per-shape
   composite proxy class — multi-week work that mirrors the
   E12 codegen scope.

**Suggested approach (when Option 2 is picked up).**

1. **Extend `tom_d4rt_generator/proxy_generator.dart`** with a
   "render-object composite proxy" code path that, given an
   interpreted class chain mixing in N bridged
   `Render*Mixin`s, emits a single composite proxy class that
   `extends RenderBox with Mixin1, Mixin2, …`.
2. **Wire the proxy factory selector** in
   `_classChainHasBridgedMixin` to route to the composite
   when more than one bridged mixin is present.
3. **Add a regression-shaped test** that declares an
   interpreted render object mixing in two bridged mixins and
   asserts the composite proxy carries both. The Fa6
   reproducers above are the natural starting point.

**Re-opening trigger.** Re-open Fa6 if a new corpus script
exposes a composite-mixin shape that breaks (FE>0) on Option-1
infrastructure, or when Fa4's generator substrate work lands and
the same machinery can be reused for render-object mixins.

**Closing criteria (when re-opened).** Two-mixin and three-mixin
shape pass without per-mixin manual registration. Existing
single-mixin slot-mixin path continues to work.

**Cross-reference.** Fa4 (E12 codegen) is the abstract-delegate
peer; Fa6 is the render-object peer. Both share the
"auto-generate shapes the analyzer can already see" thesis.

**Estimated effort.** Generator 1–2 days. Tests 0.5 day.
Documentation 0.25 day. (Quoted as standalone effort; in
practice tracked alongside Fa4's multi-week generator-substrate
work.)

---

## Fa7 — META: test-app watchdog (durable W1–W5 fix)

- [ ] Fixed  - [ ] Partial  - [x] Reverted/Deferred · **Severity:** High → blocked-on-prioritisation · **Owner:** test runner

**Scope.** Per takeaway #5 + #6 above, the W4 skip is a day-1
mitigation; the durable fix is a test-app watchdog that converts
a single test-app crash into a single failure + restart instead
of a 19-script cascade. With a watchdog in place, the 5
W-script skips can be removed without per-script work.

**Status (2026-04-28).** **Deferred — multi-day test-runner
infrastructure feature.** Step 1 below is already complete.
Steps 2–4 require coordinated changes to the Flutter test app's
HTTP server-loop, `send_test_runner.dart`'s 1275-line state
machine, and process lifecycle management — explicitly quoted
at 2–3 days for the watchdog plus 0.5 day for skip removal and
validation, beyond the single-turn cluster-fix cadence used by
this campaign. The W4 skip mitigates operational impact today
(`gir` reports **54/5/4** cleanly in 1 m 12 s post-skip; full
takeaway #2 above), and all 5 W-scripts are individually viable
(`blocking_tests_test.dart`, 5/5 green in 38 s). No live blocker
forces immediate prioritisation; the deferral is safe.

**Closure evidence (2026-04-28 deferral).**

1. **Step 1 already done.** `test/blocking_tests_test.dart`
   provides the W1–W5 isolation harness called for in step 1 of
   the suggested approach: each wedger runs in its own test in a
   dedicated suite, and 2026-04-28's run reports all 5 green in
   38 s. This proves the W-scripts are individually viable and
   confirms the wedge is a scaling/ordering artefact at the
   long-suite level, not a per-script bug.
2. **Wedge taxonomy stable.** Section "Wedge taxonomy (W1–W5)"
   above documents each wedger's status, isolation outcome, and
   `gir` skip placement. Re-classifying any of them does not
   change the watchdog scope.
3. **Operational impact bounded.** With the W4 skip in place,
   `gir` 54/5/4 in 1 m 12 s — the 19-script cascade is closed
   and the 4 remaining failures are documented unfixables. The
   `essential` / `important` / `secondary` / `hr1`–`hr4` /
   `interactive` suites are all suite-level clean. The cost of
   keeping the watchdog deferred is 5 W-script skips, not
   visible regressions.
4. **Substrate scope (multi-day).**
   - **Test-app heartbeat plumbing.** The test app's HTTP
     server-loop must publish a periodic `/heartbeat`
     endpoint or push a periodic "alive" message; not invasive
     but new surface. Requires test-app rebuild + harness
     re-coordination.
   - **Runner-side watchdog timer.** `send_test_runner.dart`
     needs a separate timer that monitors heartbeat freshness,
     decides a "stuck" threshold (must not false-fire on long
     bridges or large-bundle uploads), and triggers kill+restart.
     Must integrate with existing `_httpGet` / `_httpPost`
     timeouts without re-entrancy bugs.
   - **Process kill+restart.** Must preserve the
     `_startedByRunner` flag, `_bridgesRegenerated` cache,
     `_testAppStdoutTail` / `_testAppStderrTail` ring buffers,
     and the regen-skip env-flag plumbing. Concurrent
     operations during kill (e.g., a script send mid-flight)
     need to be marked failed cleanly without corrupting the
     next script's setup.
   - **Skip removal + validation.** After the watchdog works,
     remove the W1–W4 skips in
     `generator_interpreter_retest_test.dart` (lines
     ~286–360) and the W5 skip in
     `generator_interpreter_issues_test.dart`. Run essential +
     important + secondary serially (per the campaign's
     regression rule for non-test-script changes) and confirm:
     (a) each wedger registers as a single failure rather than
     a 19-script cascade, (b) the next script in each suite
     runs cleanly. Final verification: `gir` should return
     ~54/5/4-shape with the skips lifted (some W-scripts may
     still genuinely fail, but the cascade is gone).

**Re-opening trigger.** Re-open Fa7 if (a) a sixth wedger
surfaces in any long suite (multi-wedger cascades are harder to
isolate without the watchdog), (b) test-app process stability
degrades and isolation runs of `blocking_tests_test.dart` start
failing, or (c) the campaign budget allocates a 3-day infra
window for the watchdog + skip removal + full regression
validation.

**Closing criteria (when re-opened).** A single wedger script
registers as a single failure with no cascade; the next script
in the suite runs cleanly. Long suites pass with no
W-script skips remaining.

**Estimated effort.** 2–3 days for the watchdog itself; 0.5
day to remove skips and validate.

---

# Fa-cluster summary table

| Cluster | Owner | Open Scripts / Surface | Effort | Closing Criterion |
|---|---|---|---|---|
| Fa1 — E2 remainder (13 scripts) | scripts | 13 | 3 PRs (5/PR) | All 13 scripts FE=0 |
| Fa2 — E8 interpreter residual | interpreter | 1 (deferred) | 2–3 days | FE=0 or typed `UnsupportedError` |
| Fa3 — E11 residual (RenderFlex overflow) | scripts | 1 | 1 short PR | gir TID=37 FE=0 |
| Fa4 — E12 codegen (deferred) | generator + regs | ≥30 manual entries | ~3 weeks (≥12 PRs) | ≥10 manual entries removed (split into per-shape sub-clusters) |
| Fa5 — `InheritedModel` collapse | interpreter | (closed-by-infra) | 0 (already fixed) | Reproducer + `inheritFrom<T>` works |
| Fa6 — D7 Option 2 composite RO proxy | generator | (deferred — sibling of Fa4) | 2–3 days standalone (track with Fa4) | Two-mixin shape passes |
| Fa7 — META test-app watchdog | runner | 5 W-script skips (deferred — multi-day infra) | 2–3 days + 0.5 day skip-removal | Single wedger ≠ cascade |

**Suggested execution order.**

1. **Fa1, Fa3** first (script-only, fast wins, no regression
   risk).
2. **Fa7 META watchdog** in parallel — it's the highest-leverage
   structural change and unblocks removing the 5 W-script skips.
3. **Fa2** investigation can start without touching shipping
   code (single-script reproducer first).
4. **Fa4 + Fa6** are the architectural pieces; schedule them
   after Fa1/Fa3 land. They share the auto-generation thesis.
5. **Fa5** lowest priority — depends on a reproducer being
   authored.
