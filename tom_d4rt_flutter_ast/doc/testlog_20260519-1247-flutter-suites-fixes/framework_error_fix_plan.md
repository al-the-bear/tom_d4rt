# Framework-error fix plan — `20260519-1247-flutter-suites-fixes`

Script-by-script plan to fix every Flutter framework-error banner
still emitted by the D4rt scripts in the Step-11 baseline. The
139 banners emitted per project (AST 139, test 139, 278 in total)
break down across **138 distinct scripts** because one script
(`rendering/render_constraints_transform_box_test.dart`) is
driven by two host suites.

The plan **rewrites the scripts** — per the user's directive,
banner-zero must be reached by changing the scripts themselves,
not by tightening the `SendTestRunner` banner filter or by
chasing additional bridge fixes.

| Field | Value |
| --- | --- |
| Baseline | `testlog_20260519-1247-flutter-suites-fixes/` (both projects) |
| Scripts root | `tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/` |
| Script reuse | Both projects share the same script tree via `SendTestRunner.scriptsPath` — fixing a script fixes both projects simultaneously. |
| Total banners (AST) | 139 |
| Total banners (test) | 139 |
| Distinct scripts | 138 |
| Items in this plan | 138 (numbered 1–138) |
| Driver for verification | `flutter test test/<suite>.dart` serial only (never parallel) |

## How to process this plan

1. Pick the next unchecked item (lowest number).
2. Open the referenced script under
   `tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/<path>`.
3. Apply the prescribed fix pattern (P1..P14) — concrete edits
   described below in the **Fix patterns** section.
4. Re-run the script in isolation through `SendTestRunner`
   (rule (a): script-only changes need only the script's host
   suite re-checked locally; rule (b): if you changed shared
   helpers, run essential + important + secondary + the host
   hr/secondary suite serially).
5. Verify the script's banner is gone from the host suite's
   `<suite>.log.txt` and that the suite still passes.
6. Tick the item.
7. Commit when a cluster of related fixes is complete (don't
   commit per-item; bundle 10–25 items per commit).

## Acceptance criteria for this fix plan

- **Banners go to zero** in both project log sets (the original
  Step-11 stretch goal that was deferred as "partial — would
  require significant test-script edits").
- **No regression** in pass/fail/error/skip counts (currently
  2199/2189/0/0/10 on both projects). The 10 `skip: true`
  entries are intentional and stay.

## Verification protocol per cluster

Use the cluster boundaries marked in the numbered list (every
~20 items) as commit boundaries. After applying a cluster of
script fixes:

```bash
# AST project
cd tom_d4rt_flutter_ast
flutter test test/essential_classes_test.dart \
  test/important_classes_test.dart \
  test/secondary_classes_test.dart   # essential+important+secondary sweep
# Optional: re-run only the affected hr/host suite as well

# Same for test project
cd ../tom_d4rt_flutter_test
flutter test test/essential_classes_test.dart \
  test/important_classes_test.dart \
  test/secondary_classes_test.dart
```

Never run multiple `flutter test` invocations concurrently
within the same package — shared HTTP-server corruption is
documented in the quest rules.

---

## Fix patterns (referenced by each numbered item)

These are the reusable recipes. Each numbered script item
points at one or more patterns plus any script-specific notes.

### P1 — Bound the test viewport (B-layout / BoxConstraints / infinite-size / NaN)

Most scripts construct a widget tree and ask the framework to
lay it out without any bounded ancestor. The fix is to wrap
the root widget in a finite-sized box.

```dart
// BEFORE
final widget = Column(children: [...]);

// AFTER
final widget = MediaQuery(
  data: const MediaQueryData(size: Size(800, 600)),
  child: Directionality(
    textDirection: TextDirection.ltr,
    child: Center(
      child: SizedBox(
        width: 800,
        height: 600,
        child: Column(children: [...]),
      ),
    ),
  ),
);
```

If the script already has a `MaterialApp`, place the
`SizedBox(width: 800, height: 600, child: ...)` as the `home`
or as the inner child of the `Scaffold.body`. The 800×600
extent matches Flutter's default test viewport.

### P2 — Bound a vertical RenderFlex (overflow on bottom)

```dart
// BEFORE
Column(children: [child1, child2, child3, ...])

// AFTER (when the test verifies layout / overflow tolerance):
SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: Column(children: [child1, child2, child3, ...]),
)

// OR (when one child is the "growable" one):
Column(children: [
  child1,
  Expanded(child: child2),  // makes child2 shrink to fit
  child3,
])
```

Combine with **P1** for the outer extent.

### P3 — Bound a horizontal RenderFlex (overflow on right)

Same as **P2** but `Axis.horizontal` / wrap the offending
child in `Flexible(...)` or `Expanded(...)` in the horizontal
axis.

### P4 — Bound a Stack ("A Stack requires bounded constraints")

```dart
// BEFORE
Stack(children: [...])

// AFTER
SizedBox(
  width: 400,
  height: 400,
  child: Stack(children: [...]),
)
```

Alternatively give the Stack `fit: StackFit.expand` inside a
bounded parent (P1).

### P5 — Avoid the non-uniform-Border bridge defect (B-bridge BorderRadius)

The bridge throws when a `Border` with side-specific colors
is combined with a `borderRadius`. Two acceptable rewrites,
pick whichever preserves test intent:

```dart
// (a) Use a uniform Border for the visual rendering case:
Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.black, width: 1),
    borderRadius: BorderRadius.circular(4),
  ),
)

// (b) When the test specifically verifies the assertion, wrap
//     in try/catch and assert the framework error inside the
//     script — turning the framework banner into a captured,
//     expected error:
try {
  paintBorder(canvas, rect,
      border: Border(top: BorderSide(color: Colors.red),
                     bottom: BorderSide(color: Colors.green)),
      borderRadius: BorderRadius.circular(4));
  testFailed = true;  // we expected a throw
} on FlutterError catch (e) {
  expect(e.message, contains('uniform colors'));
}
```

Always prefer (a) when the test isn't specifically about the
mixed-color assertion.

### P6 — Correctly typed `Gradient.linear` constructor args (B-bridge gradient)

```dart
// BEFORE — wrong-typed args trip the bridged constructor:
Gradient.linear([0.0, 0.0], [1.0, 1.0], [0xFFFF0000, 0xFF00FF00]);

// AFTER — Offset and List<Color>:
Gradient.linear(
  const Offset(0, 0),
  const Offset(1, 1),
  const [Color(0xFFFF0000), Color(0xFF00FF00)],
);
```

If the test needs stops, pass `List<double>` of the right
length (same count as colors).

### P7 — Null-guard before invoking method on possibly-null target (I-unhandled)

```dart
// BEFORE
target.getChildren();

// AFTER
if (target != null) {
  target.getChildren();
}
// OR
target?.getChildren();
```

For the absorbed-extent injector case (`SliverOverlapInjector
has found no absorbed extent to inject`), make sure the test
constructs the absorber **above** the injector in the slivers
list and threads the same `SliverOverlapAbsorberHandle`
through both.

### P8 — Normalize / clamp BoxConstraints (B-layout — non-normalized)

```dart
// BEFORE
BoxConstraints(minWidth: 700, maxWidth: 350)  // NOT NORMALIZED

// AFTER
BoxConstraints(minWidth: 350, maxWidth: 700)
```

If the test specifically tries to feed non-normalized
constraints (to verify error handling), wrap the call in
`try/catch` (P5 style) and capture the assertion.

### P9 — Set required textBaseline

```dart
// BEFORE
Row(crossAxisAlignment: CrossAxisAlignment.baseline, children: [...])

// AFTER
Row(
  crossAxisAlignment: CrossAxisAlignment.baseline,
  textBaseline: TextBaseline.alphabetic,
  children: [...],
)
```

### P10 — Bound a viewport (GridView / ListView / Scrollable)

```dart
// BEFORE
GridView.count(crossAxisCount: 2, children: [...])

// AFTER — give the viewport a bounded height (vertical case):
SizedBox(
  height: 400,
  child: GridView.count(crossAxisCount: 2, children: [...]),
)
```

Same pattern for `ListView`, `CustomScrollView`, etc. Combine
with **P1** if the script root is also unbounded.

### P11 — Correct ParentDataWidget placement

`Positioned` must be a direct child of `Stack`. `Flexible` /
`Expanded` must be a direct child of `Row` / `Column` /
`Flex`. Move the widget under the right parent or remove the
ParentData wrapper if not needed.

### P12 — RenderFlex with flex children but unbounded constraints

```dart
// BEFORE — Column inside another unbounded scrollable:
Column(children: [Expanded(child: ...)])

// AFTER — either drop the Expanded:
Column(children: [SizedBox(height: 200, child: ...)])
// or wrap the outer Flex in a bounded box (P1).
```

### P13 — Fix non-normalized custom constraints

See **P8**. If the test deliberately exercises invalid
constraints, capture the assertion (P5 style).

### P14 — Bounded `Table` arguments / `table_border` assertion

When the script builds a `Table`, ensure `defaultColumnWidth`,
`columnWidths`, and (if used) `border: TableBorder.all(...)`
have valid parameters. The `table_border.dart` assertion
typically fires on a missing `width` or invalid `borderSide`.

---

## Numbered fix list (138 items)

Format per item:

> `N. <path>` *(host suite[s], banners AST/test, tag)* — Pattern
> reference + one-line note.

Where two patterns apply, both are listed (e.g. `P1+P2`).

### Cluster A — `animation/`, `cupertino/`, `dart_ui/` (items 1–10)

1. ~~`animation/cubic_test.dart`~~ *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — "BoxConstraints forces an infinite height.")* — **deferred to U14** (2026-05-19). Four script-level workarounds attempted (P1 `SizedBox(800)`, `Center(heightFactor:1.0)`, `Row > Flexible > Column` sidestep, `Expanded → SizedBox(60)` inside the two `GridView.count` cells) — all reverted because the banner persists in every variant. The assertion fires on a synthetic `RenderConstrainedBox` inside a Material widget the script does not own, so no script-level rewrite is possible. Banner is non-fatal (`status=success, frameworkErrors=1`; test passes throughout). See `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` § U14 for the full investigation. **No script change committed.**

2. ~~`cupertino/cupertino_nav_segmented_test.dart`~~ *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 2.0 px right)* — **deferred to U15** (2026-05-19). Four script-level workarounds attempted (P3: three independent `Row → Wrap` conversions on the hero chips Row in `_buildHero`, the boxed-default label Row in `_buildBoxedDefault`, and the sliding-default label Row in `_buildSlidingDefault`; plus P1: shrinking `CupertinoNavigationBar.middle`'s `SizedBox(width: 220.0) → 180.0`) — all reverted because the banner persists at 2 in every variant. The two `RenderFlex` overflows fire on internal `Row`s synthesised by a bridged Cupertino widget the script does not own (CupertinoNavigationBar internals, sliding-segmented-control thumb track, or CupertinoButton content row), so no script-level rewrite is possible. Banner is non-fatal (`status=success, frameworkErrors=2`; both tests "All tests passed!" throughout). See `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` § U15 for the full investigation. **No script change committed.**

3. ~~`cupertino/cupertino_page_test.dart`~~ *(secondary_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **FIXED** (2026-05-19, P1). The "infinite height" assertion fired on `_anatomyDiagram`: a top-level `Row(crossAxisAlignment: CrossAxisAlignment.stretch)` whose first child is a `SizedBox(width: 110, child: Column(... Expanded(child: _anatomyBox('B')) ...))`. Under the outer `SingleChildScrollView`, the Row received an unbounded `maxHeight` and propagated it to the inner `Expanded`'s `RenderConstrainedBox`. Fix: wrapped `_anatomyDiagram`'s root `Container` in `SizedBox(height: 200)` so the stretch row has a finite vertical extent to distribute. Verified: `secondary_classes_test` with `--plain-name 'cupertino_page_test.dart'` reports `frameworkErrors=0 status=success` (was 1). Test passes; rule (a) — script-only change, single-script retest sufficient.

4. ~~`cupertino/cupertino_scroll_behavior_test.dart`~~ *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 4.0 px bottom)* — **FIXED** (2026-05-19, P2). The two identical 4.0 px bottom overflows came from `_AnatomyArrowDown` (used twice in `_ClassAnatomySection` at lines 319 and 331, both with `height: 30`). The widget is `SizedBox(height: 30) > Center > Column[Container(width:2, height:height-10=20), Icon(CupertinoIcons.chevron_down, size:14)]` — the Column lays out to 20 + 14 = 34 px inside a 30 px SizedBox → 4.0 px overflow, hit twice → 2 banners. Fix: at the widget level, reduced the connector line in `_AnatomyArrowDown` from `height - 10` to `height - 16` so the Column (`(height-16) + 14 = height - 2`) fits within `SizedBox(height: height)` with slack. Verified: `secondary_classes_test` with `--plain-name 'cupertino_scroll_behavior_test.dart'` reports `frameworkErrors=0 status=success` (was 2). Test passes; rule (a) — script-only change, single-script retest sufficient. Log: `ztmp/fix_plan_step4/ast_cupertino_scroll_behavior.log.txt`.

5. ~~`cupertino/restorable_cupertino_tab_controller_test.dart`~~ *(hardly_relevant_classes_1_test, 1/1, B-layout/RenderFlex — "Offset argument contained a NaN value.")* — **FIXED** (2026-05-19, script-side workaround for U16). The original P1+P2 hypothesis ("unbounded `TabBarView`") was incorrect — the script contains no `TabBarView` widget at all. Bisection through the 11-section deep-demo page (top-half / bottom-half / single-section / single-widget) localised the offender to the `_CodeBlock` widget inside `_buildCodeSnippetSection`. Further bisection to a minimal `Column[Text(lines[i].text)]` body confirmed the trigger: **`Text('')` (empty-string `Text` widget) triggers a NaN `Offset` assertion in `dart:ui/painting.dart` line 41 through the bridged Flutter paragraph painter**. The source listing fed to `_CodeBlock` contained six `_CodeLine(0, '')` entries representing visually-blank lines; each rendered as an empty `Text`. Fix: in `_CodeBlock.build`, guard the composed `Text` argument with `composed.isEmpty ? ' ' : composed` so the painter always receives at least one glyph run. The visual result is identical (a blank line in a monospaced code block, padded by the surrounding `Padding(vertical: 1.0)`). Verified single-script retest: `frameworkErrors=0 status=success` (was 1). Underlying bridge bug documented as **U16** in `interpreter_unfixable.md`. Log: `ztmp/fix_plan_step5/ast_restorable_tab_controller_after.log.txt`. Rule (a) — script-only change, single-script retest sufficient.

6. ~~`cupertino/route_test.dart`~~ *(essential_classes_test, 1/1, B-bridge — "A borderRadius can only be given on borders with uniform colors.")* — **FIXED** (2026-05-19, P5(a)). Six `BoxDecoration` sites combined a non-uniform `Border` (either `Border(left: ...)` for an accent left-stripe, or four explicit sides with differing colours / widths) with a `borderRadius` — Flutter's `BoxDecoration._debugAssertValid` rejects the combination with `A borderRadius can only be given on borders with uniform colors.` The script renders each site multiple times in a deck/grid, so the 6 site declarations produced 9 framework-error banners. Fix: at every offending site replaced the non-uniform `Border` with a uniform `Border.all(color: <accent>, width: <fitted>)` — the accent-colour visual association is preserved, rounded corners are preserved, and the per-side stripe / thicker-top effect is folded into a uniform thicker outline (with width doubled on `fullscreen` rows in `_routeKindTile` so the visual emphasis still carries). Sites fixed: lines 89, 158, 579, 868, 1457, 1761. Verified single-script retest: `frameworkErrors=0 status=success` (was 9). Log: `ztmp/fix_plan_step6/ast_route_after.log.txt`. Rule (a) — script-only change, single-script retest sufficient.

7. ~~`dart_ui/shader_mask_engine_layer_test.dart`~~ *(hardly_relevant_classes_1_test, 1/1, B-bridge — "Runtime Error: Native error during bridged constructor 'linear'")* — **FIXED** (2026-05-19, script-side, P6 corrected). The original P6 hypothesis ("pass `Offset` not `List<double>`") was incorrect — every call site already passed proper `Offset` arguments. The real diagnostic from the captured banners was: `Gradient.linear|radial|sweep requires colors.length == 2 when colorStops is null (got colors.length=N)`. Native Flutter's `ui.Gradient.linear/radial/sweep` requires `colorStops` to be supplied whenever `colors.length != 2`; the bridged constructors enforce the same precondition. Four call sites in the script passed `null` as the stops argument together with multi-colour palettes (rainbow×7, sunset+endpoints×6, rainbow-loop×8, oceanic×4), producing 36 framework-error banners (each call site is repeated per BlendMode tile in the deck). Fix: at each site replace `null` with `List<double>.generate(colors.length, (i) => i / (colors.length - 1))` — evenly-spaced stops covering `[0.0, 1.0]`, which reproduces the implicit even spacing native Flutter would have applied for two-colour gradients. Sites fixed: lines 346 (rainbow linear), 393 (sunset radial), 440 (rainbow sweep), 997 (palette linear in `_blendModeShowcase`). Verified single-script retest: `frameworkErrors=0 status=success` (was 36). Log: `ztmp/fix_plan_step7/ast_shader_mask_after.log.txt`. Rule (a) — script-only change, single-script retest sufficient.

8. ~~`dart_ui/uniform_float_slot_test.dart`~~ *(hardly_relevant_classes_1_test, 1/1, B-layout/RenderFlex — overflow 2491 px bottom)* — **FIXED** (2026-05-19, P1+P2). The script renders nine deep-demo sections in a top-level `Column` that totalled ~3091 logical pixels on the 800×600 test viewport (600 + 2491 overflow). Fix: wrap the section `Column` in a `SingleChildScrollView` so the full content lays out within a bounded, scrollable child — overflow goes away and the visual top-of-page is unchanged. Single site (the top-level `build()` return). Verified single-script retest: `frameworkErrors=0 status=success` (was 1). Log: `ztmp/fix_plan_step8/ast_uniform_float_after.log.txt`. Rule (a) — script-only change, single-script retest sufficient.

9. ~~`dart_ui/uniform_vec2_slot_test.dart`~~ *(hardly_relevant_classes_1_test, 1/1, B-layout — "Offset argument contained a NaN value.")* — **FIXED** (2026-05-19, script-side workaround for U16). The original P1 hypothesis ("bound the viewport") was incorrect — the script already wraps its content in a `SingleChildScrollView`, so layout is bounded. The actual trigger is **U16 again**: Section 7 (`_buildSection7FragCodePanel`) renders a simulated `.frag` listing as a sequence of `(text, tag)` token spans. Three lines representing visually-blank rows used `<String>['', 'plain']` — i.e. `Text('')` once mapped through `_buildFragLine`. Empty `Text` trips `dart:ui/painting.dart:41` NaN-Offset assertion in the bridged paragraph painter. Fix: in `_buildFragLine`, guard the span text with `rawText.isEmpty ? ' ' : rawText` so the painter always receives at least one glyph run. Visual result is identical — three blank rows in the monospaced code panel, padded by the surrounding `Padding(vertical: 1.0)`. Verified single-script retest: `frameworkErrors=0 status=success` (was 1). Log: `ztmp/fix_plan_step9/ast_uniform_vec2_after.log.txt`. Underlying bridge bug already documented as **U16** in `interpreter_unfixable.md`. Rule (a) — script-only change, single-script retest sufficient.

10. ~~`dart_ui/uniform_vec3_slot_test.dart`~~ *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **FIXED** (2026-05-19, script-side, P1 refined). The script is already wrapped in `Scaffold > SafeArea > SingleChildScrollView` (vertical), so the demo viewport is bounded horizontally but unbounded vertically — that's the standard scroll pattern. The actual trigger is **`Row(crossAxisAlignment: CrossAxisAlignment.stretch)`** used inside that unbounded-height scrollable: the Row inherits `maxHeight=infinity`, then `stretch` forces each child to size to that infinite height → `RenderConstrainedBox` raises "BoxConstraints forces an infinite height." Bisection localised the failure to `VUseCaseGrid` (section 05); grep then surfaced the same pattern in `VCaveatsGrid` (section 09). Fix: wrap every stretch-Row in an `IntrinsicHeight` so the row first resolves the tallest child, then stretches the remaining children to match — preserves the equal-height card layout exactly. Four Rows fixed (two in `VUseCaseGrid`, two in `VCaveatsGrid`). The root `VGuideRoot` Column also uses `CrossAxisAlignment.stretch` but cross-axis there is *width*, which is bounded by the scroll viewport — that one is intentional and was left alone. Verified single-script retest: `frameworkErrors=0 status=success` (was 1). Log: `ztmp/fix_plan_step10/ast_uniform_vec3_after.log.txt`. Rule (a) — script-only change, single-script retest sufficient.

### Cluster B — `foundation/` (items 11–20)

11. ~~`foundation/abstract_node_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.~~ **FIXED.** Same pattern as item 10: the script already had `Scaffold > SingleChildScrollView > Column(crossAxisAlignment: stretch)`, so P1 (bound viewport) was not the right fix. The actual trigger was a single `Row(crossAxisAlignment: CrossAxisAlignment.stretch)` at the `_PitfallRow` builder (line 2150) inside the unbounded-height scrollable — `Expanded` + stretch propagated infinite height to the `_CodeBlock` children. Fix: wrapped that one Row in `IntrinsicHeight` so it sizes to its tallest intrinsic child. The eight other `CrossAxisAlignment.stretch` usages are all on `Column`s (horizontal stretch — harmless). Verified `frameworkErrors=1→0`.

12. ~~`foundation/caching_iterable_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.~~ **FIXED.** All three banners came from one `_detailBlock(...)` helper called three times, which combined `Border(left: width 4, top/right/bottom: alpha 0.18) + borderRadius` (the bridge's non-uniform-Border defect). Replaced the structure with a `ClipRRect > IntrinsicHeight > Row` where the left accent is a 4-px sibling `Container` and the content card now uses uniform `Border.all(alpha: 0.18)` — preserves the visual accent stripe and the rounded corners. Verified `frameworkErrors=3→0`.

13. ~~`foundation/diagnosticable_node_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.~~ **FIXED.** All nine banners came from the `_LevelRow` helper instantiated nine times — same `Border(left: width 6, top/right/bottom: alpha 0.18) + borderRadius` pattern as item 12. Re-expressed the left-accent stripe as a sibling 6-px `Container` inside `ClipRRect > IntrinsicHeight > Row`; the content card uses uniform `Border.all`. Verified the other single-side `Border(left: ...)` in `_FooterRef` (line 2302) does NOT trip the bridge (defaulted `BorderSide.none` is treated as uniform). Verified `frameworkErrors=9→0`.

14. ~~`foundation/diagnosticable_tree_node_test.dart` *(hardly_relevant_classes_1_test, 1/1, I-unhandled — "Cannot invoke method 'getChildren' on null.")* — **P7**. Null-guard the recursive `getChildren()` call (the root has no parent in the test tree).~~ **FIXED.** The two errors ("getChildren on null" + "name on null") originated in `_NodeCard.build` / `_PropPill.build` / `_flattenJson`, which all assumed `DiagnosticsNode` parameters were non-null. The bridged `DiagnosticsNode.getChildren()` / `.getProperties()` calls (and even the root `toDiagnosticsNode(...)`) can surface `null` values in the interpreter despite the non-nullable static type. Fix: (i) re-typed each `node`/`n` parameter as `DiagnosticsNode?`, (ii) early-return `SizedBox.shrink()` / a placeholder JSON line on `null`, (iii) filtered nulls out of `getChildren()` / `getProperties()` results. Verified `frameworkErrors=2→0`.

15. ~~`foundation/diagnosticable_tree_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.~~ **FIXED.** Same pattern as items 10/11/15: script root was already `Scaffold > SingleChildScrollView > Column(stretch)`, so P1 wasn't relevant. Two `Row(crossAxisAlignment: stretch)` sites inside the unbounded scrollable (DevTools tree+details panes at line 2044, pitfall Avoid/Prefer at line 3237) propagated infinite height to their Expanded children. Fix: wrapped both Rows in `IntrinsicHeight`. The third stretch alignment at the top-level Column is harmless (horizontal stretch). Verified `frameworkErrors=1→0`.

16. ~~`foundation/error_spacer_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/infinite-size — Offset NaN)* — **P1**.~~ **FIXED.** P1 was misdiagnosed — root layout is already `Scaffold > SingleChildScrollView > Column(stretch)`. Actual cause is U16 (empty-string Text triggers NaN-Offset in bridged painter): `_propertyChip('name', '${spacer.name}', ...)` renders `Text('')` because `ErrorSpacer.name == ''` by design. Fix: defensively substitute empty `name`/`value` strings with a single space inside `_propertyChip`. Verified `frameworkErrors=1→0`.

17. ~~`foundation/object_event_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.~~ **FIXED.** P1 was misdiagnosed — root is already `Scaffold > SingleChildScrollView > Column(stretch)`. Real cause: five `Row(crossAxisAlignment: stretch)` sites inside the unbounded scrollable propagated infinite height to their `Expanded` children — `_buildFieldAnatomy` (line 962), two inspector mapping cards (lines 1281, 1320), the recipe matrix pair-loop (line 1806), and the pitfall pair-loop (line 2143). Fix: wrapped each `Row` in `IntrinsicHeight` so the stretch resolves to the tallest intrinsic child. Verified `frameworkErrors=1→0`.

18. ~~`foundation/observer_list_test.dart` *(secondary_classes_test, 1/1, B-layout — `SemanticsNode#... invisible`)* — **P1**. Bound the rendered surface; the zero-rect semantics node is a side-effect of an empty viewport.~~ **FIXED.** The script had two nested `SingleChildScrollView`s on the same (vertical) axis: an outer one in `Scaffold.body`, and an inner one inside `_PrivatePage`. The outer scroll-view gave its child unbounded height; the inner scroll-view then had no bounded vertical space to size against, so the page collapsed to a zero-area surface and Flutter raised `SemanticsNode#... invisible Rect.fromLTRB(0,0,0,0)`. Fix: dropped the outer `SingleChildScrollView` in `Scaffold.body` (the inner one in `_PrivatePage` already provides the scroll). Verified `frameworkErrors=1→0`.

19. ~~`foundation/string_property_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/infinite-size — Offset NaN)* — **P1**.~~ **FIXED.** P1 was misdiagnosed — root is already `Scaffold > SafeArea > SingleChildScrollView > Column(stretch)`. Actual cause is U16: the inspector pane (`_buildInspectorRow`) and tree mock (`_buildTreeRow`) render `Text(_escape(_safeToString(property)))` and `Text(_escape(_safeValueToString(property)))` from `StringProperty` cases that include `defaultValue` matches (e.g. `StringProperty('mode', 'auto', defaultValue: 'auto')`). For such properties the bridged `toString()` / `valueToString()` collapse to `''`, and `Text('')` trips the NaN-Offset assertion at `dart:ui/painting.dart:41`. Fix: added a `_nonEmpty(...)` helper that substitutes a single space for empty strings and wrapped the three dynamic Text inputs (tree row + the two inspector-row cells). Verified `frameworkErrors=1→0`.

20. ~~`foundation/unicode_test.dart` *(secondary_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.~~ **FIXED.** P1 was misdiagnosed — root is already `Scaffold > SingleChildScrollView > Column(stretch)`. Actual cause: two `Row(crossAxisAlignment: stretch)` sites inside the unbounded scrollable — `_beforeAfter` (per-constant card before/after panels) and `_scenarioRow` (scenarios section before/after panels) — propagated infinite height to their `Expanded` children. Fix: wrapped both Rows in `IntrinsicHeight` so each row sizes to its tallest intrinsic child. Verified `frameworkErrors=1→0`.

### Cluster C — `gestures/` (items 21–34)

21. ~~`gestures/hit_testable_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.~~ **FIXED.** Canonical P5(a) pattern: `_zStackEntry` (called 4× in the z-stack panel) used `Border(left: 4, top/right/bottom: 1) + borderRadius: 8`, which the bridged painter rejects as non-uniform with a rounded radius. Fix: render the card as `ClipRRect > IntrinsicHeight > Row` with the left accent as a sibling `Container(width: 4)` and a uniform `Border.all` on the body Container. Verified `frameworkErrors=4→0`.

22. ~~`gestures/horizontal_multi_drag_gesture_recognizer_test.dart` *(secondary_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.~~ **FIXED.** P1 was misdiagnosed — root is already `Scaffold > SafeArea > SingleChildScrollView > Column(stretch)`. Actual cause: the `cmpRow` helper inside `_buildComparisonTable` returned `Row(crossAxisAlignment: stretch)` directly, propagating infinite height to its `Expanded` cell children inside the unbounded scrollable. Fix: wrapped that single Row in `IntrinsicHeight`. Verified `frameworkErrors=1→0`.

23. ~~`gestures/one_sequence_gesture_recognizer_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.~~ **FIXED.** Canonical P5(a) pattern: the pitfall-cards loop (6 entries) built each card with `Border(left: 4 solid, top/right/bottom: 1 translucent) + borderRadius: 10`, which the bridged painter rejects on a rounded shape. Fix: render each card via `ClipRRect > IntrinsicHeight > Row` with left accent as a sibling `Container(width: 4)` and a uniform `Border.all(color: color.withValues(alpha: 0.3))` on the body. Verified `frameworkErrors=6→0`.

24. ~~`gestures/pointer_exit_event_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/RenderFlex — overflow 4707 px bottom)* — **P1+P2**.~~ **FIXED.** The root was a bare `Container > Column` with 10 demo sections — no `Scaffold`, no `SingleChildScrollView` — so the column overflowed the viewport by 4707 px on the bottom. Fix: wrapped the root in `Scaffold > SafeArea > SingleChildScrollView` so the column scrolls in an unbounded vertical viewport. Verified `frameworkErrors=1→0`.

25. ~~`gestures/pointer_move_event_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.~~ **FIXED.** Two cooperating causes: (1) root was a bare `Container > Column` of 13 demo sections — no `Scaffold`, no `SingleChildScrollView`; (2) the `_buildFieldGrid` helper built pair rows with `Row(crossAxisAlignment: stretch)` containing `Expanded(_fieldCard(...))`. Fix: wrapped the root in `Scaffold > SafeArea > SingleChildScrollView` and wrapped the field-grid pair-Row in `IntrinsicHeight`. Verified `frameworkErrors=1→0`.

26. ~~`gestures/pointer_pan_zoom_start_event_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.~~ **FIXED.** Two cooperating causes. (1) Five `Row(crossAxisAlignment: stretch)` sites — pair-rows in `FieldGrid`/`ReadoutGrid`/`UseCaseGrid`, the columns row in `CompareTable`, and the sidebar+content row in `TakeawayFooter` — sat inside the unbounded `SingleChildScrollView` and received infinite cross-axis constraints; wrapped each in `IntrinsicHeight`. (2) After the layout fix, 5 `B-bridge — uniform-colors` errors surfaced from `CaveatRow`, which built each of 5 caveat rows with `Border(left: 4 solid, top/right/bottom: 1 thin) + borderRadius: 14`; replaced with canonical P5(a) pattern (`ClipRRect > IntrinsicHeight > Row` with left accent as a sibling `Container(width: 4)` and uniform `Border.all` on the body). Verified `frameworkErrors=5→0`.

27. ~~`gestures/pointer_scroll_event_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.~~ **FIXED.** Four `Row(crossAxisAlignment: stretch)` sites — the `_FieldCard` pair grid (section 03), the magnitude-matrix row builder (section 05), the `_EdgeCaseCard` pair grid (section 09), and `_ComparisonTable` row cells (section 07) — sat inside the unbounded `SingleChildScrollView` root and received infinite cross-axis constraints. Wrapped each in `IntrinsicHeight`. Verified `frameworkErrors=1→0`.

28. ~~`gestures/positioned_gesture_details_test.dart` *(secondary_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.~~ **FIXED.** Two cooperating causes. (1) Four `Row(crossAxisAlignment: stretch)` sites — the 4×3 details-card gallery, the trajectory pair-cards grid, the velocity codeBlock + sample-card row, and the recipe GestureDetector sandbox + codeBlock row — sat inside the unbounded `SingleChildScrollView` root and received infinite cross-axis constraints; wrapped each in `IntrinsicHeight`. (2) After the layout fix, a `RenderFlex overflowed by 13 pixels on the right` surfaced from `kindChip` (section 4 / PointerDeviceKind panel): the chip's inner `Row(Icon, gap, Text('PointerDeviceKind.${label}'))` placed an unflexed monospace 12pt Text in a 220-px chip whose longest label `PointerDeviceKind.invertedStylus` (32 chars) overflowed the 200-px inner card width. Wrapped the Text in an `Expanded` so it soft-wraps to the available width. Verified `frameworkErrors=1→0`.

29. ~~`gestures/serial_tap_down_details_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 3195 px bottom)* — **P1+P2**.~~ **FIXED.** Root was a bare `Container > Column(mainAxisSize: min, stretch)` of eight demo sections — no `Scaffold`, no `SingleChildScrollView`. Inside the test app's finite vertical container the unbounded Column overflowed the bottom by 3195 px. Wrapped the root in `Scaffold > SafeArea > SingleChildScrollView` (canonical P1 pattern). No stretch-Rows inside the scrollable, so no follow-up P1 inner wrap was needed. Verified `frameworkErrors=1→0`.

30. ~~`gestures/serial_tap_up_details_test.dart` *(secondary_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.~~ **FIXED.** The `editorMockRows` loop (count=1..5 cards) built each card with a non-uniform `Border(left: color/4, top/right/bottom: slateSoft/1)` combined with `borderRadius: 8` — Flutter's "borderRadius can only be given on borders with uniform colors" assertion fired once per card for 5 framework errors. Refactored to canonical P5(a): uniform `Border.all(slateSoft, 1)` + `clipBehavior: Clip.antiAlias` on the outer Container, with the coloured left accent supplied as a sibling `Container(width: 4)` inside an `IntrinsicHeight > Row`. Verified `frameworkErrors=5→0`.

31. ~~`gestures/tap_drag_start_details_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 8.0 px bottom)* — **P2**.~~ **FIXED.** Section 10 (`_buildTapCountChart`) wrapped its bar Row in `SizedBox(height: 140)`, but each inner Column was: count text (~14) + spacing (2) + bar up to 104 + spacing (4) + 2-line label like `'tap=1\n(char)'` (~24 px at fontSize 9.5 × height 1.2) ≈ 148 px → 8 px bottom overflow. Bumped the slot to `height: 160` (the minimal fix). Script-only change; verified single-script retest with `frameworkErrors=0`.

32. ~~`gestures/tap_drag_update_details_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 16 px right)* — **P3**.~~ **FIXED.** Localised by section-binary-search (sections 7-12 disabled → still overflow; 4-6 alone → overflow; 4 alone → clean; 4+5 → clean; 4+5+6 → overflow) → `tapCountSection`. Root cause was `tapVignetteCard` width 290 (inner 258 after 16+16 padding) holding a Row of `dotRow` (24 px per dot × count) + 22-px arrow Icon + 4-px gap + a monospace pill `drag · update · update · …`. With count=3 the sum hit ~274 px → 16 px right overflow. Wrapped the trailing pill `Container` in `Flexible` so it shrinks (and the text wraps inside) when the dot row grows. Script-only change; verified single-script retest with `frameworkErrors=0`.

33. ~~`gestures/tap_move_details_test.dart`~~ *(hardly_relevant_classes_1_test, 1/1, B-bridge — uniform-colors)* — **FIXED** (2026-05-19, P5(a)). The 6 framework errors came from the `slopRows` loop (6 iterations over `simulatedMoves`), where each card combined a non-uniform `Border(left: 4px accent, top/right/bottom: 1px slateSoft)` with `borderRadius: BorderRadius.circular(10.0)` — Flutter rejects this at paint time. Canonical P5(a) fix applied at lines 597-705: outer Container keeps uniform `Border.all(slateSoft, 1.0)` + rounded corners + `clipBehavior: Clip.antiAlias`; the left accent strip becomes a sibling `Container(width: 4)` inside `IntrinsicHeight > Row(crossAxisAlignment: stretch)`. Visually identical to original. Verified: `hardly_relevant_classes_1_test` with `--plain-name 'tap_move_details_test.dart'` reports `frameworkErrors=0 status=success` (was 6). Rule (a) — script-only change, single-script retest sufficient. Log: `ztmp/item33_run1.log`.

34. ~~`gestures/velocity_estimate_test.dart`~~ *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **FIXED** (2026-05-19, P1 + P5(a) follow-up). Section binary-search localised the failure to `_VelocityVsEstimateSection`: its `LayoutBuilder` returned `Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Expanded(left), SizedBox, Expanded(right)])` inside `SingleChildScrollView > Column(stretch)`. The scroll view's infinite vertical max constraint propagated through the stretching Row to each Expanded child's inner Container `RenderConstrainedBox.layout()`, throwing "BoxConstraints forces an infinite height". Wrapping the Row in `IntrinsicHeight` bounded the height to the taller panel's intrinsic height and cleared the P1 error. Doing so revealed 5 previously-masked P5(a) errors from `_Callout` (rendered 5× in `_LimitationsSection`), which combined non-uniform `Border(left: 4px tone, top/right/bottom: tone.withValues(alpha:0.25))` with `borderRadius`. Applied canonical P5(a) fix: outer Container with uniform `Border.all(tone.withValues(alpha:0.25))` + rounded corners + `clipBehavior: Clip.antiAlias`; left accent strip as sibling `Container(width: 4)` inside `IntrinsicHeight > Row(stretch)`. Visually identical. Verified: `hardly_relevant_classes_1_test` with `--plain-name 'velocity_estimate_test.dart'` reports `frameworkErrors=0 status=success` (was 1, jumped to 5 after the P1 fix exposed the masked errors). Rule (a) — script-only change, single-script retest sufficient. Log: `ztmp/item34_run2.log`.

35. ~~`gestures/velocity_test.dart`~~ *(important_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **FIXED** (2026-05-19, P1 + U16 follow-up). Layered script-only fix. **P1 first:** `_SectionCard` chrome rendered every section as `Row(crossAxisAlignment: stretch, [Container(width:6 strip), Expanded(content)])` inside `SingleChildScrollView > Column(stretch)`, so the scroll view's infinite vertical max propagated through the stretching Row to the strip Container's `RenderConstrainedBox.layout()` — the original baseline banner. Wrapped the chrome Row in `IntrinsicHeight` (line 297) so the strip stretches to the content column's intrinsic height. Same shape repeated in `_GalleryGrid` (gallery-card pair rows), wrapped with `IntrinsicHeight` (line 1087) for consistency. **U16 follow-up:** the P1 fix exposed an empty-`Text` intrinsic-height edge case in `_EqualitySection` — its code-block Column contained `_CodeLine('')` as a blank-line separator (`Text('')` under `Padding`). Under the new `IntrinsicHeight` ancestor, the bridged empty-paragraph metric path reported an unbounded intrinsic height, which surfaced as `BoxConstraints forces an infinite height` on a downstream `RenderFlex.layout()` (same root cause as U16's NaN-Offset banner, different surface shape; documented as the "variant banner under `IntrinsicHeight`" in U16). Localised by section-binary-search (sections 1-7 → 0 err; +`_EqualitySection` → 1 err) and then probe-narrowed to the Container-of-`_CodeLine`s, then to the single `_CodeLine('')` row. Replaced the blank `_CodeLine('')` with `SizedBox(height: 14)` — preserves the vertical gap and keeps the (composed) `Text` calls non-empty. Verified: `important_classes_test` with `--plain-name 'gestures/ velocity_test.dart'` reports `frameworkErrors=0 status=success` (was 1). Rule (a) — script-only change, single-script retest sufficient. U16's affected-scripts table updated. Logs: `ztmp/item35_final.log`.

### Cluster D — `material/` (items 36–55)

36. ~~`material/animatedicon_test.dart`~~ *(important_classes_test, 1/1, B-bridge — uniform-colors)* — **FIXED** (2026-05-19, P5(a)). The 6 framework errors mapped 1:1 to the 6 calls of `_pitfallTile` in section 8 (`buildPitfallsSection`), where each tile combined a non-uniform `Border(left: 4px tint, right/top/bottom: tint.withValues(alpha: 0.3))` with `borderRadius: BorderRadius.circular(12)` — Flutter rejects the combination at paint time with "A borderRadius can only be given on borders with uniform colors." Canonical P5(a) fix applied at the `_pitfallTile` helper: outer Container keeps uniform `Border.all(tint.withValues(alpha: 0.3))` + rounded corners + `clipBehavior: Clip.antiAlias`; the 4-px coloured accent strip becomes a sibling `Container(width: 4)` inside `IntrinsicHeight > Row(crossAxisAlignment: stretch)`. Visually identical to original. Verified: `important_classes_test` with `--plain-name 'animatedicon_test.dart'` reports `frameworkErrors=0 status=success` (was 6). Rule (a) — script-only change, single-script retest sufficient. Log: `ztmp/item36_run1.log`.

37. ~~`material/bottom_navigation_bar_landscape_layout_test.dart`~~ *(hardly_relevant_classes_2_test, 1/1, "B-bridge" tagged but emitted error is RenderFlex overflow 0.601 px right)* — **FIXED** (2026-05-19, P3 + P5(a)). Baseline was actually 4 framework errors, not 1: (i) 1× P5(a) non-uniform `Border(left: 6px cerulean, others: 1px driftwoodDark)` + `borderRadius` in `_buildClosingEssay` → refactored to uniform `Border.all` + `clipBehavior: Clip.antiAlias` + 6-px cerulean strip Container inside `IntrinsicHeight > Row(crossAxisAlignment: stretch)`. (ii) 2× 0.601 px right-overflows from `_mockNavBar(layout: 'linear', items: 5)` whose 5 horizontal tiles have natural width ~241 vs container 240 — widened the linear bar to 252 in `_buildThreePierAnatomy` (section 3) and via a `layoutKey == 'linear' ? 252 : 240` ternary in `_buildLayoutDeepDive` example bars (section 6). (iii) 1× 11 px right-overflow in `_buildItemCountGrid` (section 7) for the same linear-5 case inside 230 px cells — widened both header and body cells from 250 → 280 and the inner bar from 230 → 250. All three fixes are localized D4RT-SCRIPT-WORKAROUNDs commented in source. The grid sits inside `SingleChildScrollView(scrollDirection: Axis.horizontal)` so wider cells don't break the viewport. Rule (a) — script-only change, single-script retest sufficient. Verified `frameworkErrors=0 status=success` (was 4). Log: `ztmp/item37_final3.log`.

38. ~~`material/carousel_controller_test.dart`~~ *(hardly_relevant_classes_2_test, 1/1, B-layout/RenderFlex — overflow 0.487 px right)* — **FIXED** (2026-05-19, P3). Baseline was 2 framework errors (0.487 px and 2.2 px right overflows), both in section 1 `_buildTitleBanner > _buildPaletteStrip > _buildSwatch`. The 12 palette swatch tiles are `Container(width: 116, padding: H8 V6)` whose 100-px inner space holds a `Row(mainAxisSize: min, [Container(18), SizedBox(6), Text(name)])`. Longer palette names ("CarnivalNight", "CarnivalCream", "CarnivalCoral", etc.) render at ~13 chars × 6.5 px ≈ 85 px which makes the Row's natural width exceed 100. Two of the names tip over by sub-pixel / few-pixel amounts → 0.487 and 2.2 px right overflows. Fix: dropped `MainAxisSize.min`, wrapped the Text in `Expanded(child: Text(..., overflow: TextOverflow.ellipsis))` so the label adapts to the remaining ~76 px and truncates with ellipsis when needed. Visually still a swatch + label pair; long names are clipped instead of overflowing. Rule (a) — script-only change, single-script retest sufficient. Verified `frameworkErrors=0 status=success` (was 2). Log: `ztmp/item38_final.log`.

39. ~~`material/chip_attributes_test.dart`~~ *(secondary_classes_test, 1/1, I-unhandled — "Cannot invoke method 'withValues' on null.")* — **FIXED** (2026-05-19, P7 + P1). Baseline was 6 framework errors, not 1: (i) 5× "Cannot invoke method 'withValues' on null" inside `_PrivateStateColorChain > _PrivateStateBox` (section 6). Root cause is a d4rt interpreter quirk — `static const List<List<dynamic>> _states` with `s[1] as Color` / `s[2] as Color` casts returned null at runtime; the casts succeed under analyzer Dart but the dynamic-list path strips the const Color references. Replaced with a typed `_StateRow(label, bg, fg, set)` value class and a local `List<_StateRow>` so the colours are read via named fields, no dynamic casts. (ii) 1× P1 "BoxConstraints forces an infinite height" in `_PrivateAttributeGallery.build` — a `Row(crossAxisAlignment: stretch)` inside a `SingleChildScrollView > Column` infinite-height context. Wrapped each row in `IntrinsicHeight` so the stretch children get a bounded vertical extent. Both fixes are localized D4RT-SCRIPT-WORKAROUNDs commented in source. Rule (a) — script-only change, single-script retest sufficient. Verified `frameworkErrors=0 status=success` (was 6). Log: `ztmp/item39_run2.log`.

40. ~~`material/desktop_text_selection_toolbar_button_test.dart`~~ *(secondary_classes_test, 1/1, B-layout/BoxConstraints — infinite width)* — **FIXED** (2026-05-19, P1). Root cause: `DesktopTextSelectionToolbarButton` internally wraps its TextButton in `SizedBox(width: double.infinity)` so it stretches inside a real toolbar. The mock placed these buttons inside `Row(mainAxisSize: MainAxisSize.min, children: [...])` (via `buildToolbarSurface`); Row's first layout pass for `MainAxisSize.min` hands each child unbounded width, so the inner double-infinity SizedBox trips "BoxConstraints forces an infinite width". Section binary search localized it to `buildClassicToolbarMock` (section 3); the same helper is also used by sections 4 (extended), 5 (themed), 7 (RTL), 9 (comparison) and Flutter only reports the first identical error so a single helper-level fix covers all of them. Fix: wrap each child in `IntrinsicWidth` so the Row queries the inner TextButton's intrinsic (finite, label-driven) width before laying out, giving the `SizedBox(width: infinity)` a bounded constraint to clamp against. Localised D4RT-SCRIPT-WORKAROUND comment in `buildToolbarSurface`. Rule (a) — script-only change, single-script retest sufficient. Verified `frameworkErrors=0 status=success` (was 1). Log: `ztmp/item40_run1.log`.

41. ~~`material/dialog_bottom_sheet_test.dart`~~ *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 22 px bottom)* — **FIXED** (2026-05-19, P2 + P3). Baseline was 6 framework errors, not 1: (i) 3× 22 px bottom overflow from `_galleryDialog` (section 5 AlertDialog gallery) — the icon-bearing alert dialogs (destructive / info / error / success) plus the multi-option SimpleDialogs render ~302 px tall but the stage Container clamped them to 280 px. Bumped the stage height to 320 px. (ii) 3× right overflow (20 / 14 / 11 px) from the four SimpleDialog widgets in section 6 — their `SimpleDialogOption(child: Row(Icon|CircleAvatar + SizedBox + Text))` natural width exceeded the 240-px stage. Widened all four SimpleDialog `SizedBox(width:)` wrappers from 240 → 280 px so the option rows fit without overflow. Section binary search localised errors to sections 5 and 6 only; the rest of the script is untouched. Both fixes are localised D4RT-SCRIPT-WORKAROUNDs commented in source. Rule (a) — script-only change, single-script retest sufficient. Verified `frameworkErrors=0 status=success` (was 6). Log: `ztmp/item41_run1.log`.

42. ~~`material/divider_listtile_test.dart`~~ *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 4.0 px bottom)* — **FIXED** (2026-05-19, P2). Baseline was 4 framework errors, not 1: 4× "RenderFlex overflowed by 4.0 pixels on the bottom". Section binary search localised all 4 to `_IndentRulerSection > _RulerStrip` (around line 888). Diagnosis: `Container(height: 28)` hosted 16 tick Columns, but the 4 *major* tick Columns (i=0, 5, 10, 15) stack `SizedBox(4) + Container(height: 12) + SizedBox(2) + Text(fontSize: 9)` whose natural line height is ~14 px, totalling ~32 px — 4 px taller than the strip. Fix: bumped `_RulerStrip` Container height from 28 → 34, giving the major-tick Column a small breathing margin. Localised D4RT-SCRIPT-WORKAROUND comment `#42, P2` in source. Rule (a) — script-only change, single-script retest sufficient. Verified `frameworkErrors=0 status=success` (was 4). Log: `ztmp/item42_run1.log`.

43. ~~`material/expansion_stepper_test.dart`~~ *(secondary_classes_test, 1/1, B-layout — "RenderFlex children have non-zero flex but incoming height constraints …")* — **FIXED** (2026-05-19, P12). Root cause: the horizontal-variant Stepper in `_StepperShowcaseSection.build` (at the bottom of the section, around line 1024). Flutter's `Stepper(type: StepperType.horizontal)` internally lays out as `Column(children: [headerRow, Expanded(child: …content)])`. The Stepper sat inside an outer `SingleChildScrollView > Column` (the page scroll body), so its incoming vertical constraint was unbounded — the inner Expanded then tripped "RenderFlex children have non-zero flex but incoming height constraints are unbounded". Fix: wrap the horizontal Stepper in `SizedBox(height: 220)` so the inner Expanded gets a bounded constraint (header ≈80 px + shrunk-to-empty content + breathing margin). The vertical Stepper above does not have this issue because it expands its body column naturally without an internal `Expanded`. Localised D4RT-SCRIPT-WORKAROUND comment `#43, P12` in source. Rule (a) — script-only change, single-script retest sufficient. Verified `frameworkErrors=0 status=success` (was 1). Log: `ztmp/item43_run1.log`.

44. ~~`material/fade_forwards_page_transitions_builder_test.dart`~~ *(hardly_relevant_classes_2_test, 1/1, B-layout — "RenderFlex children have non-zero flex but incoming width constraints …")* — **FIXED** (2026-05-19, P12 + P2 follow-up cluster). Root cause (P12): `_frameCard` returned a `Container` with no explicit width whose inner header `Row(_tValuePill, SizedBox(8), Expanded(Text(caption)))` lives inside a horizontal `SingleChildScrollView` (Act 4 strip at line ~1114 and Act 6 row at line ~1756, plus all five strips in Act 5 — total 33 frame cards). The horizontal scroll gives the outer Container loose unbounded width; the inner Row's `Expanded` then trips "RenderFlex children have non-zero flex but incoming width constraints are unbounded". The frozen page mocks (`_pageLogin`, `_pageDashboard`, `_pageSettings`) are all 220 px wide; fix: gave `_frameCard` an explicit `width: 236` (220 page + 16 padding) so the header Row has a finite width. Follow-up (P2): the original P12 assertion aborted layout further down the tree, masking 27× "RenderFlex overflowed by 3.6 pixels on the bottom" coming from the inner Columns of all three 360-px-tall page mocks. The Column content stack just narrowly exceeded the 336 px inner content area (12 px padding both sides), with the Spacer in Login/Settings forced to 0 px and Dashboard's fixed stack overshooting by ~3.6 px. Fix: bumped all three page heights `360 → 380` *and* bumped each of the five freezers (`_frozenFadeForwards`, `_frozenFadeUpwards`, `_frozenZoom`, `_frozenOpenUpwards`, `_frozenCupertino`) `SizedBox(height: 360 → 380)` — without bumping the freezers, the SizedBox would tightly clamp the new 380-tall page mock back to 360 and the overflow would persist. Localised D4RT-SCRIPT-WORKAROUND comments `#44, P12` (on `_frameCard`) and `#44, P2 follow-up` (on the three pages and the freezer prologue) in source. Rule (a) — script-only changes, single-script retest sufficient. Verified `frameworkErrors=0 status=success` (was 1 + 27 hidden). Logs: `ztmp/item44_baseline.log` (1 error), `ztmp/item44_run1.log` (27 follow-up overflows after P12 fix), `ztmp/item44_run2.log` (0 errors after follow-up fix).

45. ~~`material/floatingactionbutton_test.dart`~~ *(essential_classes_test, 1/1, B-layout/RenderFlex — overflow 41 px right)* — **FIXED** (2026-05-19, P3). Top-level binary search localised the single overflow to `_buildSectionEdgeCases` (Section 11, line ~1487). Edge bisection inside that section was non-obvious: the most suspicious-looking culprit (Edge 3, `FloatingActionButton.extended` with a deliberately overlong "Initialize the deep-space probe with full systems calibration" label) was a red herring — wrapping it in a horizontal `SingleChildScrollView` did not silence the error, shortening the label did not silence the error, and probing with Edge 3 entirely commented out still produced the same 41 px overflow. Probing with Edge 1 commented out instead yielded `frameworkErrors=0`, proving Edge 1 was the source. Root cause: the original demo placed `Row(mainAxisSize.min, [SizedBox(10), CircleAvatar(r:12), SizedBox(8), Text('Profile' bold), SizedBox(12)])` (natural width ~100 px) directly as the `child` of a regular `FloatingActionButton`, but a regular FAB hard-codes `BoxConstraints.tightFor(width: 56, height: 56)` and force-clamps the child to 56 px. Fix: switched Edge 1 from regular FAB to `FloatingActionButton.extended` with the avatar as `icon` and 'Profile' as `label`, which is the widget actually designed for "avatar + inline label" composite content and sizes its pill to the natural icon+label width. Edge 3 restored to its original long label (it's not the source of any overflow; FAB.extended evidently elides or wraps oversized labels gracefully in this layout context). Localised D4RT-SCRIPT-WORKAROUND comment `#45, P3` on Edge 1 in source. Rule (a) — script-only change, single-script retest sufficient. Verified `frameworkErrors=0 status=success` (was 1). Logs: `ztmp/item45_baseline.log` through `ztmp/item45_probeG.log` (bisect trail), `ztmp/item45_verify.log` (final 0 errors).

46. ~~`material/licensepage_test.dart`~~ *(important_classes_test, 1/1, B-layout/RenderFlex — overflow 26 px bottom)* — **FIXED** (2026-05-19, P2). Baseline was 4 framework errors, not 1: 4× bottom-overflow assertions at 26, 64, 90, 42 px (one per `_fieldCard` variant — Flutter only deduplicates *identical* messages, and these all have different pixel counts). Section binary search localised all four to the `fieldShowcase` Container (line 339), which contains four `_fieldCard` calls each rendering a different `LicensePage` configuration: Name Only, Versioned, With Icon (FlutterLogo size 48 in 8 px padding — the tallest), and Legalese. Root cause: `_fieldCard` clamped the embedded `LicensePage` into a `SizedBox(height: 240)`, but the LicensePage's internal master/body layout exceeds 240 px in all four configurations (the FlutterLogo variant is widest off, at 90 px). Fix: bumped the SizedBox clamp in `_fieldCard` from 240 → 340 (the largest overflow + small breathing margin) so every variant lays out inside the card. Localised D4RT-SCRIPT-WORKAROUND comment `#46, P2` on the `_fieldCard` SizedBox. Rule (a) — script-only change, single-script retest sufficient. Verified `frameworkErrors=0 status=success` (was 4). Logs: `ztmp/item46_baseline.log` (4 errors), `ztmp/item46_probeA..D.log` (bisect trail), `ztmp/item46_verify.log` (0 errors).

47. ~~`material/material_type_test.dart`~~ *(secondary_classes_test, 1/1, B-bridge — uniform-colors)* — **FIXED** (2026-05-19, P5(a) + P1 follow-up). Baseline was 6 framework errors: 6× "A borderRadius can only be given on borders with uniform colors." Two helper functions used `Border()` with asymmetric sides (different colors and/or widths per side) combined with `borderRadius`, which Flutter forbids: `_sectionTitle` (line 1222 — left-only chunky accent bar, ~5 call sites) and `_buildPitfall` (line 1837 — thick accent left + pale red on top/right/bottom). Refactor: both helpers now use a uniform outer rounded frame plus a `ClipRRect`-wrapped Row whose first child is a width-N accent Container acting as the visual left bar. Follow-up (P1): the new `Row(crossAxisAlignment.stretch)` initially tripped "BoxConstraints forces an infinite height" because the children were asked to stretch in an unbounded vertical context — wrapped the Row in `IntrinsicHeight` so the stretch resolves against the children's intrinsic height. Localised D4RT-SCRIPT-WORKAROUND comments `#47, P5(a)` on both helpers. Rule (a) — script-only changes, single-script retest sufficient. Verified `frameworkErrors=0 status=success` (was 6, briefly 1 infinite-height before IntrinsicHeight wrap). Logs: `ztmp/item47_baseline.log` (6 errors), `ztmp/item47_verify.log` (1 infinite-height follow-up), `ztmp/item47_verify2.log` (0 errors).

48. `material/menu_advanced_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 18 px right)* — **P3**.

49. `material/pageroute_test.dart` *(important_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

50. `material/scaffold_advanced_test.dart` *(secondary_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

51. `material/scaffold_fab_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 82 px bottom)* — **P2**.

52. `material/scaffold_test.dart` *(essential_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

53. `material/showbottomsheet_test.dart` *(interactive_tests_test, 1/1, B-layout/RenderFlex — overflow 20 px bottom)* — **P2**.

54. `material/showtimepicker_test.dart` *(interactive_tests_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

55. `material/snack_bar_behavior_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 56 px bottom)* — **P2**.

### Cluster E — `painting/` (items 56–67)

56. `painting/accumulator_test.dart` *(hardly_relevant_classes_2_test, 1/1, B-layout/infinite-size — Offset NaN)* — **P1**.

57. `painting/advanced_decorations_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 17 px right)* — **P3**.

58. `painting/border_directional_test.dart` *(secondary_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**. Note: this script genuinely tests directional borders — prefer P5(b) (capture-and-assert) to preserve test intent.

59. `painting/border_radius_test.dart` *(essential_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(b)**. This test is *about* `BorderRadius`; the rewrite must keep the assertion behaviour — wrap the offending construction in try/catch and assert the FlutterError.

60. `painting/box_border_test.dart` *(secondary_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(b)**. Same reasoning as item 59.

61. `painting/box_decoration_test.dart` *(essential_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(b)**.

62. `painting/image_cache_test.dart` *(secondary_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

63. `painting/image_providers_test.dart` *(important_classes_test, 1/1, B-layout — "RenderFlex children have non-zero flex but incoming width constraints …")* — **P12**.

64. `painting/image_size_info_test.dart` *(hardly_relevant_classes_2_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

65. `painting/inline_span_semantics_information_test.dart` *(hardly_relevant_classes_2_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

66. `painting/matrix_utils_test.dart` *(hardly_relevant_classes_2_test, 1/1, B-layout/RenderFlex — overflow 4211 px bottom)* — **P1+P2**.

67. `painting/shape_border_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 1863 px bottom)* — **P1+P2**.

68. `painting/star_border_test.dart` *(secondary_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

### Cluster F — `rendering/` (items 69–77)

69. `rendering/clear_selection_event_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

70. `rendering/layers_data_test.dart` *(important_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

71. `rendering/render_constraints_transform_box_test.dart` *(secondary_classes_test + timeout_tests_test, 2/2, B-layout — `BoxConstraints(699.6<=w<=349.8, h=182.0; NOT NORMALIZED)`)* — **P8**. The test deliberately feeds non-normalized constraints; either pre-normalize before passing to the box, or wrap in try/catch (P5(b) style) and assert the captured assertion. Because two host suites drive the same script, fixing it removes **two** banners (one in each host).

72. `rendering/render_follower_layer_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 64 px bottom)* — **P1+P2**.

73. `rendering/render_mixins_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 6.8 px right)* — **P3**.

74. `rendering/rendering_service_extensions_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-layout/RenderFlex — overflow 11 px bottom)* — **P2**.

75. `rendering/renderobjects_layout_test.dart` *(important_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

76. `rendering/renderobjects_sizing_test.dart` *(important_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

77. `rendering/scroll_direction_test.dart` *(hardly_relevant_classes_3_test, 1/1, "B-bridge" tag but emitted error is RenderFlex overflow 15 px right)* — **P3**. Like item 37, the 1449 B-bridge tag was for an already-fixed shape; the remaining banner is layout.

78. `rendering/select_paragraph_selection_event_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

79. `rendering/selection_status_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

80. `rendering/sliver_delegates_test.dart` *(important_classes_test, 1/1, B-layout/RenderFlex — overflow 1.00 px bottom)* — **P2**.

### Cluster G — `semantics/` (items 81–86)

81. `semantics/accessibility_focus_block_type_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

82. `semantics/announce_semantics_event_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

83. `semantics/attributed_string_property_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

84. `semantics/focus_semantic_event_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

85. `semantics/semantics_event_test.dart` *(secondary_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

86. `semantics/tooltip_semantics_event_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

### Cluster H — `services/` (items 87–101)

87. `services/autofill_configuration_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow Infinity px bottom)* — **P1+P12**. The infinity-px overflow indicates a flex child inside an unbounded vertical viewport — bound the parent and remove the Expanded.

88. `services/flutter_version_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 7661 px bottom)* — **P1+P2**.

89. `services/i_o_s_system_context_menu_item_data_share_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

90. `services/key_up_event_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

91. `services/network_asset_bundle_test.dart` *(secondary_classes_test, 1/1, B-layout — Offset NaN)* — **P1**.

92. `services/platform_exception_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

93. `services/platform_test.dart` *(important_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

94. `services/raw_key_event_data_android_test.dart` *(hardly_relevant_classes_3_test, 1/1, "B-bridge" tag but emitted error is RenderFlex overflow 2.0 px bottom)* — **P2**. As with items 37/77, treat as layout fix.

95. `services/raw_key_event_data_linux_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

96. `services/raw_key_event_data_windows_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

97. `services/raw_key_event_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-layout/RenderFlex — overflow 2378 px bottom)* — **P1+P2**.

98. `services/raw_keyboard_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

99. `services/text_editing_delta_non_text_update_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-layout/infinite-size — "Rect argument contained a NaN value.")* — **P1**.

100. `services/text_selection_test.dart` *(hardly_relevant_classes_3_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

### Cluster I — `widgets/` (items 101–138)

101. `widgets/animatedbuilder_test.dart` *(important_classes_test, 1/1, B-layout/RenderFlex — overflow 2402 px bottom)* — **P1+P2**.

102. `widgets/animatedlist_test.dart` *(important_classes_test, 1/1, I-unhandled but layout origin — "BoxConstraints forces an infinite height.")* — **P1**. The interpreter Runtime Error is downstream of the layout assertion — fix the layout and the I-unhandled disappears.

103. `widgets/appbar_test.dart` *(essential_classes_test, 1/1, B-layout/RenderFlex — overflow 33 px bottom)* — **P2**.

104. `widgets/clipping_test.dart` *(important_classes_test, 1/1, B-layout/RenderFlex — overflow 8431 px bottom)* — **P1+P2**.

105. `widgets/defaulttextstyle_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 7550 px bottom)* — **P1+P2**.

106. `widgets/draggablescrollablesheet_test.dart` *(important_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

107. `widgets/editable_text_misc_test.dart` *(secondary_classes_test, 1/1, B-layout — `Failed assertion … table_border.dart`)* — **P14**. Inspect the `Table` construction and provide valid `TableBorder` parameters.

108. `widgets/expanded_test.dart` *(essential_classes_test, 1/1, B-layout/RenderFlex — overflow 8.0 px bottom)* — **P2**.

109. `widgets/flexible_test.dart` *(essential_classes_test, 1/1, B-layout/RenderFlex — overflow 20 px right)* — **P3**.

110. `widgets/focusnode_test.dart` *(essential_classes_test, 1/1, B-layout/RenderFlex — overflow 0.661 px right)* — **P3**.

111. `widgets/formstate_test.dart` *(important_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

112. `widgets/gridview_test.dart` *(essential_classes_test, 1/1, I-unhandled — "Vertical viewport was given unbounded height.")* — **P10**. Wrap the `GridView` in a `SizedBox(height: 400, ...)`.

113. `widgets/hero_test.dart` *(important_classes_test, 1/1, B-layout/RenderFlex — overflow 7.3 px bottom)* — **P2**.

114. `widgets/heromode_test.dart` *(important_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

115. `widgets/icon_test.dart` *(essential_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

116. `widgets/inherited_model_test.dart` *(secondary_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

117. `widgets/inkwell_test.dart` *(essential_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

118. `widgets/keepalive_test.dart` *(important_classes_test, 1/1, B-layout — "Incorrect use of ParentDataWidget.")* — **P11**. Move the misplaced ParentDataWidget under its required parent.

119. `widgets/listbody_test.dart` *(important_classes_test, 1/1, B-layout — "RenderFlex children have non-zero flex but incoming width constraints …")* — **P12** (horizontal axis).

120. `widgets/listener_test.dart` *(important_classes_test, 1/1, B-layout/RenderFlex — overflow 8331 px bottom)* — **P1+P2**.

121. `widgets/menu_serializable_shortcut_test.dart` *(hardly_relevant_classes_4_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

122. `widgets/notification_locale_test.dart` *(secondary_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

123. `widgets/page_view_tabview_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 14 px bottom)* — **P2**.

124. `widgets/placeholder_test.dart` *(secondary_classes_test, 1/1, B-layout — "BoxConstraints has a negative minimum height.")* — **P8/P13**. The script feeds an invalid constraint; clamp to `>= 0` or capture the assertion via P5(b).

125. `widgets/render_sliver_overlap_absorber_test.dart` *(hardly_relevant_classes_5_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

126. `widgets/render_sliver_overlap_injector_test.dart` *(hardly_relevant_classes_5_test, 1/1, I-unhandled — "SliverOverlapInjector has found no absorbed extent to inject.")* — **P7**. Add a `SliverOverlapAbsorber` upstream of the injector in the slivers list and thread its `handle` into the injector.

127. `widgets/router_test.dart` *(important_classes_test, 1/1, B-layout/RenderFlex — overflow 22 px bottom)* — **P2**.

128. `widgets/row_test.dart` *(essential_classes_test, 1/1, B-layout/RenderFlex — overflow 6.0 px right)* — **P3**.

129. `widgets/scaffold_test.dart` *(essential_classes_test, 1/1, B-layout/RenderFlex — overflow 50 px bottom)* — **P2**.

130. `widgets/scaffoldstate_test.dart` *(important_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

131. `widgets/scroll_behavior_test.dart` *(secondary_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

132. `widgets/scrollbar_layout_misc_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 32 px bottom)* — **P2**.

133. `widgets/sizing_test.dart` *(important_classes_test, 1/1, B-layout/RenderFlex — overflow 3525 px bottom)* — **P1+P2**.

134. `widgets/stack_test.dart` *(essential_classes_test, 1/1, B-layout/Stack — "A Stack requires bounded constraints from its parent.")* — **P4**.

135. `widgets/table_wrap_flow_test.dart` *(secondary_classes_test, 1/1, B-layout — "An explicit textBaseline is required when using baseline alignment.")* — **P9**.

136. `widgets/text_selection_toolbar_layout_delegate_test.dart` *(hardly_relevant_classes_5_test, 1/1, B-layout/RenderFlex — overflow 8799 px bottom)* — **P1+P2**.

137. `widgets/transform_full_test.dart` *(important_classes_test, 1/1, B-layout/RenderFlex — overflow 2.0 px right)* — **P3**.

138. `widgets/valuelistenablebuilder_test.dart` *(important_classes_test, 1/1, B-layout/RenderFlex — overflow 10044 px bottom)* — **P1+P2**.

---

## Per-tag totals (for tracking)

| Tag                          | Distinct scripts | Items |
|------------------------------|-----------------:|-------|
| B-bridge (uniform-colors)    | 32               | items 6, 12, 13, 21, 23, 30, 33, 36, 47, 50, 54, 58–62, 68, 69, 78, 79, 81–84, 86, 90, 92, 95, 98, 111, 116, 117, 121 |
| B-bridge (gradient.linear)   | 1                | 7 |
| B-bridge tag → layout fix    | 4                | 37, 77, 94 (plus item 60 emits a uniform-colors banner — single P5 fix) |
| B-layout/RenderFlex          | 45               | 2, 4, 8, 24, 29, 31, 32, 37, 38, 41, 42, 45, 46, 48, 51, 53, 55, 57, 66, 67, 72, 73, 74, 77, 80, 87, 88, 94, 97, 101, 103, 104, 105, 108, 109, 110, 113, 120, 123, 127, 128, 129, 132, 133, 136, 137, 138 |
| B-layout/BoxConstraints      | 34               | 1, 3, 5 (mixed), 9–11, 15, 17, 19, 20, 22, 25–28, 34, 35, 40, 49, 52, 56, 64, 65, 70, 75, 76, 85, 89, 91, 93, 96, 99, 100, 102, 106, 114, 115, 122, 125, 130, 131 |
| B-layout/Stack               | 1                | 134 |
| B-layout (other)             | ~7               | 18, 39 (I-unhandled), 43, 44, 63, 71, 87, 107, 118, 119, 124, 135 |
| I-unhandled                  | 5                | 14, 39, 102, 112, 126 |

*(Approximate — exact membership follows the numbered list above. Some items combine two patterns.)*

## Recommended commit cadence

| Batch | Items | Theme | Suggested commit message |
| --- | --- | --- | --- |
| Batch 1 | 1–10 | animation, cupertino, dart_ui | `fix(scripts): banner-zero — animation/cupertino/dart_ui` |
| Batch 2 | 11–20 | foundation | `fix(scripts): banner-zero — foundation` |
| Batch 3 | 21–35 | gestures | `fix(scripts): banner-zero — gestures` |
| Batch 4 | 36–55 | material | `fix(scripts): banner-zero — material` |
| Batch 5 | 56–68 | painting | `fix(scripts): banner-zero — painting` |
| Batch 6 | 69–80 | rendering | `fix(scripts): banner-zero — rendering` |
| Batch 7 | 81–86 | semantics | `fix(scripts): banner-zero — semantics` |
| Batch 8 | 87–100 | services | `fix(scripts): banner-zero — services` |
| Batch 9 | 101–138 | widgets | `fix(scripts): banner-zero — widgets (final batch)` |

After each batch, run the regression sweep described above
(`essential + important + secondary` serially, both projects).
Once every batch is green and the suite logs no longer contain
any `═════════════` banner blocks, re-run the full 14-suite
matrix to produce a new `testlog_<id>-banner-zero/` baseline
and close this plan with a `**Closed YYYY-MM-DD by commit
<sha>.**` footer.

## Out-of-scope clarifications

- **No interpreter or bridge changes** in this plan. If a script
  rewrite reveals a genuine new bridge/interpreter defect, log it
  in `interpreter_unfixable.md` (if it cannot be fixed by a script
  edit) or in a fresh `error_analysis.md` for a separate cluster.
- **No `SendTestRunner` banner-filter changes** in this plan.
  The user's directive is to fix the scripts.
- **The 10 `skip: true` entries in `_failures.md` stay skipped.**
  This plan only addresses banner emissions; the skip set is
  unrelated.
