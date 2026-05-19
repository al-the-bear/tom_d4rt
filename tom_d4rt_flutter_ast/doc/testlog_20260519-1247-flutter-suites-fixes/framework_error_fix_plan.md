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

24. `gestures/pointer_exit_event_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/RenderFlex — overflow 4707 px bottom)* — **P1+P2**.

25. `gestures/pointer_move_event_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

26. `gestures/pointer_pan_zoom_start_event_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

27. `gestures/pointer_scroll_event_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

28. `gestures/positioned_gesture_details_test.dart` *(secondary_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

29. `gestures/serial_tap_down_details_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 3195 px bottom)* — **P1+P2**.

30. `gestures/serial_tap_up_details_test.dart` *(secondary_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

31. `gestures/tap_drag_start_details_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 8.0 px bottom)* — **P2**.

32. `gestures/tap_drag_update_details_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 16 px right)* — **P3**.

33. `gestures/tap_move_details_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

34. `gestures/velocity_estimate_test.dart` *(hardly_relevant_classes_1_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

35. `gestures/velocity_test.dart` *(important_classes_test, 1/1, B-layout/BoxConstraints — infinite height)* — **P1**.

### Cluster D — `material/` (items 36–55)

36. `material/animatedicon_test.dart` *(important_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

37. `material/bottom_navigation_bar_landscape_layout_test.dart` *(hardly_relevant_classes_2_test, 1/1, "B-bridge" tagged but emitted error is RenderFlex overflow 0.601 px right)* — **P3**. The 1449 audit tagged this row B-bridge, but the actual remaining banner is a sub-pixel overflow; widen the parent or wrap in horizontal scroll.

38. `material/carousel_controller_test.dart` *(hardly_relevant_classes_2_test, 1/1, B-layout/RenderFlex — overflow 0.487 px right)* — **P3**.

39. `material/chip_attributes_test.dart` *(secondary_classes_test, 1/1, I-unhandled — "Cannot invoke method 'withValues' on null.")* — **P7**. Null-guard the `Color.withValues(...)` call (or use `?.withValues(...)`).

40. `material/desktop_text_selection_toolbar_button_test.dart` *(secondary_classes_test, 1/1, B-layout/BoxConstraints — infinite width)* — **P1**.

41. `material/dialog_bottom_sheet_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 22 px bottom)* — **P2**.

42. `material/divider_listtile_test.dart` *(secondary_classes_test, 1/1, B-layout/RenderFlex — overflow 4.0 px bottom)* — **P2**.

43. `material/expansion_stepper_test.dart` *(secondary_classes_test, 1/1, B-layout — "RenderFlex children have non-zero flex but incoming height constraints …")* — **P12**. Either drop the inner `Expanded` or bound the outer column.

44. `material/fade_forwards_page_transitions_builder_test.dart` *(hardly_relevant_classes_2_test, 1/1, B-layout — "RenderFlex children have non-zero flex but incoming width constraints …")* — **P12** (horizontal axis).

45. `material/floatingactionbutton_test.dart` *(essential_classes_test, 1/1, B-layout/RenderFlex — overflow 41 px right)* — **P3**.

46. `material/licensepage_test.dart` *(important_classes_test, 1/1, B-layout/RenderFlex — overflow 26 px bottom)* — **P2**.

47. `material/material_type_test.dart` *(secondary_classes_test, 1/1, B-bridge — uniform-colors)* — **P5(a)**.

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
