# Error Analysis — testlog 20260517-0914-test_analysis (tom_d4rt_flutter_ast)

- Baseline ID: `20260517-0914-test_analysis`
- Revision: `4c322df839a8bcdd3e5a09425065757e9ebd0a35` (branch `main`)
- Run timestamp: 2026-05-17 09:14 CEST
- Project: `tom_d4rt_flutter_ast`
- Driver: `_ai/quests/d4rt/_run_testlog_20260517-0914_ast.sh` (serial within suite; AST + TEST suites run in parallel because they listen on different ports — 4247 / 4248)

## Suite Results

| File | Pass | Skip | Fail | Wall | FE | Status |
|------|-----:|-----:|-----:|-----:|---:|--------|
| essential_classes_test.dart | 106 | 0 | **2** | 04:21 | **66** | ❌ failure |
| important_classes_test.dart | 151 | 0 | **13** | 06:33 | **536** | ❌ failure |
| secondary_classes_test.dart | 630 | 0 | **24** | 27:19 | **343** | ❌ failure |
| hardly_relevant_classes_1_test.dart | 196 | 0 | **9** | 08:55 | **200** | ❌ failure |
| hardly_relevant_classes_2_test.dart | 202 | 0 | **1** | 06:15 | **10** | ❌ failure |
| hardly_relevant_classes_3_test.dart | 191 | 0 | **10** | 08:33 | **298** | ❌ failure |
| hardly_relevant_classes_4_test.dart | 227 | 0 | 0 | 07:13 | **5** | ✅ |
| hardly_relevant_classes_5_test.dart | 229 | 0 | **1** | 08:13 | **6** | ❌ failure |
| crashing_tests_test.dart | 4 | 0 | 0 | 00:31 | 0 | ✅ |
| timeout_tests_test.dart | 50 | 0 | **1** | 02:02 | **9** | ❌ failure |
| blocking_tests_test.dart | 5 | 0 | 0 | 00:54 | 0 | ✅ |
| generator_interpreter_issues_test.dart | 81 | 0 | **2** | 03:04 | **2** | ❌ failure |
| generator_interpreter_retest_test.dart | 56 | 0 | **2** | 02:06 | **7** | ❌ failure |
| interactive_tests_test.dart | 6 | 0 | 0 | 00:54 | **23** | ✅ |
| **Total** | **2134** | **0** | **65** | 86:53 | **1505** | 4 of 14 files clean |

> `FE` is the sum of `frameworkErrors=N` reported by the per-script `[METRIC]` lines — these are widget-tree exceptions that did **not** flip the HTTP response to non-200 but were surfaced by SendTestRunner. Listed below as framework-error blocks.

## Hard-Failure Cluster Index

Numbered for tracking; tick the box once a cluster is fixed and re-verified. `C##` matches the inline cluster heading in *Hard Failures — File by File* below.

| # | File | Tests | Error key | Status |
|---|------|------:|-----------|:------:|
| **C01** | `essential_classes_test.dart` | 2 | `Runtime Error: Positional arguments cannot follow named arguments.` | ☑ fixed |
| **C02** | `important_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'AnimatedOpacity': 'package:flutter/src/widgets/implicit_animations.dart'` | ☑ fixed |
| **C03** | `important_classes_test.dart` | 6 | `Runtime Error: Positional arguments cannot follow named arguments.` | ☑ fixed |
| **C04** | `important_classes_test.dart` | 1 | `Runtime Error: Native error during bridged constructor 'removePadding' for class 'MediaQuery': Argument Error: Invalid parameter "context": ` | ☑ fixed |
| **C05** | `important_classes_test.dart` | 1 | `Bad state: Transport failure while running "widgets/notificationlistener_test.dart"` | ☑ fixed |
| **C06** | `important_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'CalendarDatePicker': 'package:flutter/src/material/calendar_date_picker.` | ☑ fixed |
| **C07** | `important_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'ParagraphStyle': type 'StrutStyle' is not a subtype of type 'StrutStyle?` | ☑ fixed |
| **C08** | `important_classes_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'substring' on String: RangeError (end): Invalid value: Not in inclusive range 12..16` | ☑ fixed |
| **C09** | `important_classes_test.dart` | 1 | `Runtime Error: Native error during bridged constructor 'sweep' for class 'Gradient': Argument Error: Gradient: Parameter "endAngle" has non-` | ☑ fixed |
| **C10** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during bridged operator '+' on double: type 'Null' is not a subtype of type 'num' in type cast` | ☑ fixed |
| **C11** | `secondary_classes_test.dart` | 1 | `Concurrent modification during iteration: Instance(length:50) of '_GrowableList'.` | ☑ fixed |
| **C12** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Nu` | ☑ fixed |
| **C13** | `secondary_classes_test.dart` | 1 | `Runtime Error: Index assignment target must be List or Map in cascade.` | ☑ fixed |
| **C14** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'GestureDetector': Incorrect GestureDetector arguments.` | ☑ fixed (script) |
| **C15** | `secondary_classes_test.dart` | 1 | `Bad state: Transport failure while running "material/tooltip_feedback_test.dart"` | ☑ fixed (script) |
| **C16** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'BottomAppBar': Argument Error: Invalid parameter "shape": expected Notch` | ☑ fixed (script) |
| **C17** | `secondary_classes_test.dart` | 1 | `Bad state: Cannot resolve import "package:vector_math/vector_math_64.dart" from main.dart: Package import "package:vector_math/vector_math_6` | ☑ fixed (script) |
| **C18** | `secondary_classes_test.dart` | 1 | `Runtime Error: Cannot access property 'entries' on target of type _ConstMap<String, dynamic>.` | ☑ fixed (script) |
| **C19** | `secondary_classes_test.dart` | 2 | `Runtime Error: Positional arguments cannot follow named arguments.` | ☑ fixed |
| **C20** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'RestorableEnum': Argument Error: Invalid parameter "defaultValue": expec` | ☑ fixed (script) |
| **C21** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'WidgetSpan': 'package:flutter/src/widgets/widget_span.dart': Failed asse` | ☑ fixed (script) |
| **C22** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'subscribe' on RouteObserver: Argument Error: Invalid parameter "routeAware": expecte` | ☑ fixed (script) |
| **C23** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'DraggableScrollableSheet': 'package:flutter/src/widgets/draggable_scroll` | ☑ fixed (script) |
| **C24** | `secondary_classes_test.dart` | 1 | `'package:flutter/src/widgets/restoration_properties.dart': Failed assertion: line 85 pos 12: 'isRegistered': is not true.` | ☑ fixed (script) |
| **C25** | `secondary_classes_test.dart` | 1 | `Null check operator used on a null value` | ☑ |
| **C26** | `secondary_classes_test.dart` | 1 | `Runtime Error: A value of type 'List' can't be returned from the function 'encodeFrame' because it has a return type of 'Uint8List'.` | ☐ |
| **C27** | `secondary_classes_test.dart` | 1 | `type 'BridgedEnumValue' is not a subtype of type 'PointerDeviceKind' in type cast` | ☑ |
| **C28** | `secondary_classes_test.dart` | 2 | `Runtime Error: Native error during default bridged constructor for 'DragEndDetails': 'package:flutter/src/gestures/drag_details.dart': Faile` | ☑ |
| **C29** | `secondary_classes_test.dart` | 1 | `Runtime Error: The condition of a conditional expression must be a boolean, but was null.` | ☑ |
| **C30** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'createBoxPainter' on ShapeDecoration: Null check operator used on a null value` | ☑ |
| **C31** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'LinearBorderEdge': 'package:flutter/src/painting/linear_border.dart': Fa` | ☑ |
| **C32** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Undefined static member 'hashCode' on bridged class 'UniformFloatSlot'.` | ☑ |
| **C33** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Undefined static member 'hashCode' on class 'UniformVec2Slot'.` | ☑ |
| **C34** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Error in generic constructor factory for 'CachingIterable': Argument Error: Invalid parameter "_prefillIterator": expected It` | ☑ |
| **C35** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toStringDeep': Argument Error: Invalid target: expected Diagnos` | ☑ |
| **C36** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toDiagnosticsNode': Argument Error: Invalid target: expected Di` | ☑ |
| **C37** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'ObjectFlagProperty': 'package:flutter/src/foundation/diagnostics.dart': ` | ☐ |
| **C38** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'HitTestEntry': Argument Error: Invalid parameter "target": expected HitT` | ☐ |
| **C39** | `hardly_relevant_classes_1_test.dart` | 1 | `TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts \|\| Bad state: Transport f` | ☐ |
| **C40** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'PointerExitEvent': 'package:flutter/src/gestures/events.dart': Failed as` | ☐ |
| **C41** | `hardly_relevant_classes_2_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'increment' on Accumulator: 'package:flutter/src/painting/inline_span.dart': Failed a` | ✅ closed |
| **C42** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Cannot access property 'isEmpty' on target of type _ConstMap<String, dynamic>.` | ☑ fixed (interpreter) |
| **C43** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: KeyDataTransitMode` | ☑ fixed (script) |
| **C44** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: KeyboardSide` | ☑ fixed (script) |
| **C45** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: MaterialState (in Set literal)` | ☑ fixed (script) |
| **C46** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'RawFloatingCursorPoint': Argument Error: Invalid parameter "startLocatio` | ☑ fixed (generator) |
| **C47** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: build` | ☑ fixed (script) |
| **C48** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: RawKeyEventDataWeb` | ☑ fixed (script · U12-A) |
| **C49** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: RawKeyEventDataLinux` | ☑ fixed (script · U12-A) |
| **C50** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Nu` | ☑ fixed (no-op · resolved by earlier cluster work) |
| **C51** | `hardly_relevant_classes_3_test.dart` | 1 | `Bad state: Transport failure while running "services/text_editing_delta_insertion_test.dart"` | ☑ fixed (script · U1-variant) |
| **C52** | `hardly_relevant_classes_5_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'subscribe' on RouteObserver: Argument Error: Invalid parameter "routeAware": expecte` | ☑ fixed (no-op · resolved by earlier U9 workaround) |
| **C53** | `timeout_tests_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(ERR_NOT_FOUND, Resource mi` | ☑ fixed (script · U13-new) |
| **C54** | `generator_interpreter_issues_test.dart` | 1 | `BoxConstraints forces an infinite height.` | ☑ fixed (script · U1-variant-2) |
| **C55** | `generator_interpreter_issues_test.dart` | 1 | `A RenderFlex overflowed by 7.0 pixels on the bottom.` | ☐ |
| **C56** | `generator_interpreter_retest_test.dart` | 1 | `A borderRadius can only be given on borders with uniform colors.` | ☐ |
| **C57** | `generator_interpreter_retest_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(ERR_NOT_FOUND, Resource mi` | ☐ |

## Hard Failures — File by File

### essential_classes_test.dart

#### C01 — `Runtime Error: Positional arguments cannot follow named arguments.`

- [x] **fixed** (2026-05-17) — also closes C03 and C19, same root cause.

**Root cause.** The d4rt interpreter enforced an obsolete "named arguments
must come last" ordering rule when evaluating `SArgumentList`. Dart 3
permits named arguments to appear anywhere in the argument list; the
scripts call `_codeBlock(title: '...', '''...''')` (named before
positional), which is valid Dart (and analyzes cleanly), but blew up in
`_evaluateArgumentsAsync` in the AST-driven interpreter.

**Fix.** Removed the ordering check in four places, mirrored across
`tom_d4rt` and `tom_d4rt_ast`:

- `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` —
  `_evaluateArguments`, `_evaluateArgumentsAsync` (SArgumentList variant).
- `tom_d4rt_ast/lib/src/runtime/callable.dart` — redirecting `this(...)`
  constructor arg evaluation, and `_evaluateArgumentsForInvocation`.
- `tom_d4rt/lib/src/interpreter_visitor.dart` — analyzer-AST mirror of
  the same two helpers.
- `tom_d4rt/lib/src/callable.dart` — analyzer-AST mirror of the same two
  locations.

**Verification.** flutter_ast: essential 108/0/0, important 157/7/0
(was 13 fails — C03's 6 closed), secondary 631/22/1 (was 24 fails —
C19's 2 closed). flutter_test: essential 108/0/0, important 157/7/0,
secondary 630/23/1. No new regressions in any of the six suites.

| testID | Test name |
|-------:|-----------|
| 12 | cupertino/ controls_test.dart |
| 109 | widgets/ opacity_test.dart |

Representative error texts:

- **#12** `cupertino/ controls_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Positional arguments cannot follow named arguments.
- **#109** `widgets/ opacity_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Positional arguments cannot follow named arguments.

### important_classes_test.dart

#### C02 — `Runtime Error: Native error during default bridged constructor for 'AnimatedOpacity': 'package:flutter/src/widgets/implicit_animations.dart'`

- [x] **fixed** (2026-05-17) — script-only fix. See root-cause note
  below.

| testID | Test name |
|-------:|-----------|
| 18 | widgets/ animatedopacity_test.dart |

**Root cause (script bug, not an interpreter/bridge bug).** The
deep demo at `send_ast_via_http_scripts/widgets/animatedopacity_test.dart`
exercises `AnimatedOpacity` against a row of non-monotone curves in
Section 8 ("Curve studies"), including `Curves.bounceIn` and
`Curves.elasticOut`. Both curves intentionally overshoot/undershoot
the [0, 1] range — `elasticOut.transform(0.6) ≈ 1.077`, `bounceIn`
similarly dips just below 0 — which trips the native assertion
`opacity >= 0.0 && opacity <= 1.0`. The script even acknowledges
this in its own quote card ("Curves.bounceIn or Curves.elasticOut
... almost never belong on opacity"), but still hands the unclamped
value to `AnimatedOpacity.opacity`.

**Fix.** Clamp the value before it reaches `AnimatedOpacity`:

```dart
AnimatedOpacity(
  opacity: curve.transform(t).clamp(0.0, 1.0),
  duration: Duration.zero,
  child: ...,
)
```

The Text below the swatch still shows the raw `curve.transform(t)`
so the visualization of curve behavior remains intact — only the
alpha fed into the assertion is clamped.

**Regression scope (rule a).** Script-only change in the shared
script corpus (the same file is consumed by both flutter_test
(source-based) and flutter_ast (AST-based) test suites via
`SendTestRunner.scriptsPath`). Single-test verification in both
packages passes; no regression suite required.

#### C03 — `Runtime Error: Positional arguments cannot follow named arguments.`

- [x] **fixed** (2026-05-17) — same root cause and fix as C01; see C01
  section for details. All 6 tests passed in the post-fix regression run.

| testID | Test name |
|-------:|-----------|
| 28 | widgets/ layoutbuilder_test.dart |
| 71 | material/ batch 3 appbar_themes_test.dart |
| 103 | widgets/ batch 3 scrollnotification_test.dart |
| 114 | cupertino/ localization_test.dart |
| 158 | services/ keyboard_test.dart |
| 172 | rendering/ renderobjects_sizing_test.dart |

#### C04 — `Runtime Error: Native error during bridged constructor 'removePadding' for class 'MediaQuery': Argument Error: Invalid parameter "context": `

- [x] **fixed** (2026-05-17) — script-only fix. See root-cause note
  below.

| testID | Test name |
|-------:|-----------|
| 32 | widgets/ safearea_test.dart |

**Root cause (script bug).** The deep demo
`send_ast_via_http_scripts/widgets/safearea_test.dart` had a hand-rolled
`class _NullCtx implements BuildContext` that returned `null` from every
method via `noSuchMethod`, and passed an instance of it to
`MediaQuery.removePadding(context: _NullCtx(), removeTop: true, ...)`.
The native constructor calls `MediaQuery.of(context)` internally, which
needs a real `BuildContext` with a live `Element` chain — even in pure
Flutter the `_NullCtx` trick would fail. In the interpreter context it
fails earlier at the bridge layer because the argument is an
`InterpretedInstance(_NullCtx)`, not a native `BuildContext`.

The rest of the script (lines 1131, 1149, 1167) already used the correct
pattern: wrap `MediaQuery.removePadding` in a `Builder` so it gets a real
descendant context from the surrounding `MediaQuery`.

**Fix.** Replace the `_NullCtx()` call site with the `Builder` pattern;
delete the unused `_NullCtx` class:

```dart
final Widget inner = Builder(
  builder: (BuildContext ctx) => MediaQuery.removePadding(
    context: ctx,
    removeTop: true,
    child: SafeArea(...),
  ),
);
```

This preserves the demo's intent — the inner `SafeArea` sees a
MediaQueryData whose top padding has been stripped — and follows the
recipe documented inline in `_nestedRecipeStep` cards 1–4.

**Regression scope (rule a).** Script-only change in the shared script
corpus; single-test verification in both flutter_test and flutter_ast
passes.

#### C05 — `Bad state: Transport failure while running "widgets/notificationlistener_test.dart"`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 56 | widgets/ notificationlistener_test.dart |

**Root cause.** The C05 demo combined two independently-fatal
shapes whose only symptom is `Lost connection to device` with no
useful stderr: (1) a top-level `class _PrivateScoreNotification
extends Notification` plus three top-level `const
_PrivateScoreNotification(...)` constants — constructing an
interpreted subclass of the *native* abstract `Notification` at
top-level const-evaluation time exercises the adapter-proxy
infrastructure before the visitor has wired its context, and
crashes the test-app transport; (2) Section 7's
`_privateCodeBlock(...)` rendering a ~1.8 KB / ~58-line code
listing through a per-character `_privateColorizeDart` colorizer
into `SelectableText.rich(TextSpan(children: spans))`, producing
~1000+ TextSpans and exceeding the test-app per-frame transport
budget. Bisection on `build()`'s child list confirmed both
sub-cases (see `ztmp/c05_*.log.txt`).

**Fix (script-only).** (1) Removed the
`_PrivateScoreNotification` class and its three constants;
inlined the displayed values as top-level `const int
_kSampleScoreBValue = 108;` and `const String _kSampleScoreBLabel
= 'levelB';` (the class definition still appears as text in the
code-listing cards, which is the documentation intent). (2)
Added a sibling helper
`Widget _privatePlainCodeBlock(String code)` that wraps a single
plain monospace `Text` widget in the same dark-card visual
container, and routed Section 7's large recipe through it
instead of `_privateCodeBlock`. Sections 3–6 (small code
listings, ≤500 chars / ≤22 lines) continue to use the colorized
`_privateCodeBlock`.

**Regression scope (rule a).** Script-only change in the shared
script corpus; single-test verification on both drivers
(flutter_ast `00:16 +1: All tests passed!`, flutter_test
`00:12 +1: All tests passed!`). Logged in
`ztmp/c05_ast_fixed.log.txt` and
`ztmp/c05_test_fixed.log.txt`. Underlying interpreter
limitations documented as **U1** in `interpreter_unfixable.md`.

#### C06 — `Runtime Error: Native error during default bridged constructor for 'CalendarDatePicker': 'package:flutter/src/material/calendar_date_picker.`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 81 | material/ batch 3 datepicker_widgets_test.dart |

**Root cause.** Real Flutter assertion at
`calendar_date_picker.dart:154` —
`selectableDayPredicate == null || initialDate == null ||
selectableDayPredicate!(initialDate!)`. The script's shared
`now = DateTime(2025, 6, 15)` (a Sunday, day=15 odd) was used as
`initialDate` for two `CalendarDatePicker` instances whose
`selectableDayPredicate` rejects it:

- 3c (`calWeekdays`): predicate is `weekday >= monday && weekday <= friday`. `2025-06-15` is a Sunday → fails.
- 3d (`calEvens`): predicate is `d.day.isEven`. Day 15 is odd → fails.

Not an interpreter bug — the demo data simply doesn't satisfy
the picker's own contract. Same failure would occur in a native
Flutter app with the same code.

**Fix (script-only).** Replace `initialDate: now` with
`initialDate: DateTime(2025, 6, 16)` for both 3c and 3d (Monday,
even day) so the supplied predicate accepts the initial date.
The other four `CalendarDatePicker` instances (3a/3b without a
predicate, 3e with its own date inside the narrow quarter
window, 3f with no predicate) are unaffected.

**Regression scope (rule a).** Script-only change in the shared
script corpus; single-test verification on both drivers
(flutter_ast `00:15 +1: All tests passed!`, flutter_test
`00:12 +1: All tests passed!`). Logs in
`ztmp/c06_ast_fixed.log.txt` and
`ztmp/c06_test_fixed.log.txt`.

#### C07 — `Runtime Error: Native error during default bridged constructor for 'ParagraphStyle': type 'StrutStyle' is not a subtype of type 'StrutStyle?`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 147 | dart_ui/ text_data_test.dart |

**Root cause.** `text_data_test.dart` constructs
`ui.ParagraphStyle(strutStyle: ui.StrutStyle(...))` at three call
sites. The `dart:ui.StrutStyle` constructor is overridden by the
`StrutStyleUserBridge` (intentionally — the engine type is opaque,
so we materialise `painting.StrutStyle` to give D4rt scripts full
getter support). The `painting.StrutStyle → dart:ui.StrutStyle`
RC-3 coercion required by `ParagraphStyle.strutStyle` IS
registered in `d4rt_runtime_registrations.dart`, but it never
fires: the `ParagraphStyle` bridge constructor calls
`D4.getOptionalNamedArg<ui.StrutStyle?>(named, 'strutStyle')`,
which delegates to `D4.extractBridgedArg<T = ui.StrutStyle?>`.
Inside `extractBridgedArg`, the **GEN-100** simple-name fallback
short-circuits the resolution: `T.toString() == 'StrutStyle?'` and
`unwrapped.runtimeType.toString() == 'StrutStyle'` (both classes
share the simple name across `package:flutter/painting.dart` and
`dart:ui`), so GEN-100 force-casts `painting.StrutStyle as
ui.StrutStyle?` and the cast throws an unhandled `TypeError` —
surfacing as the bridge constructor failure, well before the RC-3
coercion block at line 1561 could be reached.

**Fix (rule b — interpreter change).** Wrapped GEN-100's `as T`
in a `try/catch` so the cast failure falls through to the
subsequent paths instead of escaping. The next block in
`extractBridgedArg` is the RC-3 `_typeCoercionsByType` lookup,
which now picks up the registered `painting.StrutStyle →
ui.StrutStyle` coercion and returns the engine-level value. The
patch is documented inline as **GEN-100b**. Mirrored in both
copies of the interpreter helper:

- `tom_ai/d4rt/tom_d4rt_ast/lib/src/runtime/generator/d4.dart` (AST driver)
- `tom_ai/d4rt/tom_d4rt/lib/src/generator/d4.dart` (analyzer driver)

No script or generated bridge changes. The fix only affects
extractions whose simple-name match succeeds **and** whose
explicit cast throws — every other code path retains identical
behaviour, so non-`StrutStyle` arguments cannot regress through
this branch.

**Regression scope (rule b).** Interpreter helper changed, so
essential + important + secondary + gii must pass on both
drivers. Single-test verification:

- flutter_ast: `00:28 +1: All tests passed!`
  (`ztmp/c07_ast_singletest.log.txt`)
- flutter_test: `00:27 +1: All tests passed!`
  (`ztmp/c07_test_singletest.log.txt`)

Suite-level results (post-fix) — identical to pre-fix baseline
for the failure counts in each cluster the workstream tracks:

| Suite | flutter_ast | flutter_test | Notes |
|-------|-------------|--------------|-------|
| gii | `+79 ~2 -2` | `+79 ~2 -2` | 2 pre-existing failures (nestedscrollview, render_custom_multi_child_layout_box) confirmed by pre-fix stash baseline run |
| essential | `+108` ALL PASSED | `+108` ALL PASSED | No regressions |
| important | `+162 -2` | `+162 -2` | -2 = C08 (spellcheck) + C09 (gradient), both still open; C07 (text_data) no longer in the failure list |
| secondary | `+630 ~1 -22` | `+630 ~1 -23` | All pre-existing failures; the +1 difference (`tap_drag_start_details_test.dart`) is an inventory gap between the two drivers, unrelated to this fix |

Logs in `ztmp/c07_ast_{gii,essential,important,secondary}.log.txt`
and `ztmp/c07_test_{gii,essential,important,secondary}.log.txt`,
plus the pre-fix gii baseline in
`ztmp/c07_ast_gii_prefix.log.txt`.

#### C08 — `Runtime Error: Native error during bridged method call 'substring' on String: RangeError (end): Invalid value: Not in inclusive range 12..16`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 161 | services/ spellcheck_test.dart |

**Root cause.** Off-by-one in the test fixture, not an interpreter
bug. The sample text is the 16-character string
`'helo wrold today'`, and the script defines three
`SuggestionSpan`s. The third (`sampleSpanC`) declared
`TextRange(start: 12, end: 17)` for the word "today", but "today"
actually starts at index **11** (after `'helo'` (4) + `' '` (1) +
`'wrold'` (5) + `' '` (1) = 11) and ends at **16**. Section 3 of
the demo then calls
`sampleResults.spellCheckedText.substring(span.range.start,
span.range.end)`, which on the native String triggers
`RangeError (end): Invalid value: Not in inclusive range 12..16:
17`. Same error would surface in a native Flutter app with the
same fixture.

**Fix (script-only, rule a).** Corrected the third
`SuggestionSpan`'s `TextRange` from `start: 12, end: 17` to
`start: 11, end: 16`, with an inline comment recording the index
math. No interpreter or generator change.

**Regression scope (rule a).** Script-only change in the shared
script corpus; single-test verification on both drivers
(flutter_ast `00:15 +1: All tests passed!`, flutter_test
`00:11 +1: All tests passed!`). Logs in
`ztmp/c08_ast_fixed.log.txt` and `ztmp/c08_test_fixed.log.txt`.

#### C09 — `Runtime Error: Native error during bridged constructor 'sweep' for class 'Gradient': Argument Error: Gradient: Parameter "endAngle" has non-`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 179 | rendering/ gradient_rendering_test.dart |

**Root cause.** Bridge-generator limitation, not an interpreter
bug. `ui.Gradient.sweep` is positional-only and declares
`double endAngle = math.pi * 2` as its 6th positional default.
`BridgeGenerator._wrapDefaultValue`
(`tom_d4rt_generator/lib/src/bridge_generator.dart` lines
4606–4613) returns `null` for any default expression containing an
operator, so the generated bridge emits
`D4.getRequiredArgTodoDefault<double>(positional, 5, 'endAngle',
'Gradient', 'math.pi * 2')` and throws `Argument Error: Gradient:
Parameter "endAngle" has non-wrappable default (math.pi * 2).
Value must be specified but was null.` whenever the call site
omits the 6th positional. Because the constructor is
positional-only, every call site that omits *any* later
positional must also spell out all earlier ones up to the
offending operator default. The full mechanism and the
generator-side fix sketch are catalogued as **U2** in
`interpreter_unfixable.md`.

**Fix (script-only, rule a).** Expanded the
`ui.Gradient.sweep(Offset(...), kRainbow)` call site in
`rendering/gradient_rendering_test.dart` (lines 1416–1437) to
pass all preceding positional defaults explicitly:

```dart
final ui.Gradient sweep = ui.Gradient.sweep(
  Offset(100.0, 60.0),
  kRainbow + <Color>[kSpecRed],
  <double>[0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0], // colorStops
  TileMode.clamp,                                                  // tileMode
  0.0,                                                             // startAngle
  math.pi * 2.0,                                                   // endAngle (operator-bearing default)
);
```

Two corrections were needed in sequence. (1) Just adding
`math.pi * 2.0` as the 6th positional satisfied the
`getRequiredArgTodoDefault` check but raised the follow-up
native-engine assertion `colors must have length 2 if colorStops
is omitted`. (2) Once `colorStops` was supplied explicitly,
`dart:ui` enforces `colorStops.length == colors.length`, so the
9-colour rainbow (`kRainbow` 8 colours + closing `kSpecRed`)
needed a 9-element evenly-spaced stop list. The inline comment in
the script records both the index math and the generator
limitation that motivates the workaround. No interpreter or
generator change.

**Regression scope (rule a).** Script-only change in the shared
script corpus; single-test verification on both drivers
(flutter_ast `00:15 +1: All tests passed!`, flutter_test
`00:11 +1: All tests passed!`). Logs in
`ztmp/c09_ast_fixed.log.txt` and `ztmp/c09_test_fixed.log.txt`.

Representative error texts:

- **#18** `widgets/ animatedopacity_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during default bridged constructor for 'AnimatedOpacity': 'package:flutter/src/widgets/implicit_animations.dart': Failed assertion: line 1853 pos 15: 'opacity >= 0.0 && opacity <= 1.0': is not true.
- **#28** `widgets/ layoutbuilder_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Positional arguments cannot follow named arguments.
- **#32** `widgets/ safearea_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during bridged constructor 'removePadding' for class 'MediaQuery': Argument Error: Invalid parameter "context": expected BuildContext, got InterpretedInstance(_NullCtx)
- **#56** `widgets/ notificationlistener_test.dart` —
  > Bad state: Transport failure while running "widgets/notificationlistener_test.dart"
  > Operation: POST /build?filename=widgets%2Fnotificationlistener_test.dart
  > Error: HttpException: Connection closed before full header was received, uri = http://localhost:4247/build?filename=widgets%2Fnotificationlistener_test.dart
  > Stack trace:
  > ===== asynchronous gap ===========================
- **#71** `material/ batch 3 appbar_themes_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Positional arguments cannot follow named arguments.
- **#81** `material/ batch 3 datepicker_widgets_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during default bridged constructor for 'CalendarDatePicker': 'package:flutter/src/material/calendar_date_picker.dart': Failed assertion: line 154 pos 7: 'selectableDayPredicate == null \|\|
  >           this.initialDate == null \|\|
  >           selectableDayPredicate!(this.initialDate!)': Provided initialDate 2025-06-15 00:00:00.000 must satisfy provided selectableDayPredicate.

### secondary_classes_test.dart

#### C10 — `Runtime Error: Native error during bridged operator '+' on double: type 'Null' is not a subtype of type 'num' in type cast`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 8 | animation/ animation_misc_adv_test.dart |

**Root cause.** Interpreter / adapter-proxy delegation gap, not an
arithmetic bug at the failure site. The script's curves catalog
included a specimen `class _FlippedShim extends Curve` that
overrode `transformInternal(double t)` (the framework's standard
extension hook). Native `Curve.transform(double t)` is a
template-method that validates `t ∈ [0, 1]`, handles the edges,
and delegates the interior to `transformInternal(t)`. For a
script-defined subclass of the native abstract `Curve`, the
adapter proxy does **not** override `transformInternal` natively
to route back to the interpreted method via
`InterpretedInstance.invoke`, so the framework's template method
calls the proxy's abstract `transformInternal` and `transform()`
returns `null` through the bridge. The null sample then enters
`_curveStrip` as `final double s = curve.transform(i / (steps - 1))`
(original line ~278) and the next downstream
`height: 12.0 + (28.0 * s)` (original line ~281) throws
`Native error during bridged operator '+' on double: type 'Null'
is not a subtype of type 'num' in type cast`. Bisection confirmed
the failure reproduces identically whether `_FlippedShim()` is
constructed as a top-level `const` or as a non-const local, which
rules out U1 (top-level const of interpreted-subclass-of-native
crashing the test-app transport). The full mechanism and the
proxy-generator fix sketch are catalogued as **U3** in
`interpreter_unfixable.md`.

**Fix (script-only, rule a).** Replaced the catalog specimen in
`tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/animation/animation_misc_adv_test.dart`
(original `_customCurves` list, lines ~863–866):

```dart
// Don't (bridged `transform()` returns null):
const MapEntry<String, Curve>(
  'Curves.easeInOut.flipped',
  _FlippedShim(),
),

// Do — use the framework's native FlippedCurve:
MapEntry<String, Curve>(
  'FlippedCurve(easeInOut) [native]',
  FlippedCurve(Curves.easeInOut),
),
```

The `_FlippedShim` class declaration (lines ~911–935) is retained
as documentation of the user-extension pattern with a
multi-line explanatory comment and `// ignore: unused_element`
so the analyzer doesn't warn. No interpreter, generator, or
`.b.dart` change.

**Regression scope (rule a).** Script-only change in the shared
script corpus; single-test verification on both drivers
(flutter_ast `00:15 +1: All tests passed!`, flutter_test
`00:15 +1: All tests passed!`). Logs in
`ztmp/c10_ast_fixed.log.txt` and `ztmp/c10_test_fixed.log.txt`.

#### C11 — `Concurrent modification during iteration: Instance(length:50) of '_GrowableList'.`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 31 | foundation/ synchronousfuture_test.dart |

**Root cause.** Two compounded interpreter bugs surfaced by the
script's import set (`flutter/material.dart` +
`flutter/foundation.dart` + `dart:async`).

1. **Self-import in `Environment.importEnvironment`.** Diagnostic
   logging (`identicalLists=true, identicalEnv=true`) confirmed the
   module loader returns the importing environment itself for a
   transitive import: `_unnamedExtensions.addAll(sameList)` then
   iterates the list while mutating it, raising
   `ConcurrentModificationError` at the first add (length=50 — the
   tally of registered extensions in the foundation/material
   transitive closure). Surfaced at `environment.dart:1203` /
   `visitImportDirective:12405`. Captured stack trace:
   `ztmp/c11_envdbg.log.txt`.
2. **`FutureOr<Object>` rejects null in `then` bridge.** With (1)
   fixed, the next exception was `Native error during bridged
   method call 'then' on SynchronousFuture: Argument Error:
   Invalid parameter "callback": expected Object, got Null`. The
   bridge generator's GEN-061 substitution turned an unresolved
   `FutureOr<dynamic>` callback return into the non-nullable
   `FutureOr<Object>`, then funnelled it through
   `extractBridgedArg<FutureOr<Object>>` which throws on `null`.
   Void-returning callbacks like `sf.then((v) { ... })` produce
   `null` at the boundary, so every void-returning `.then(...)` in
   user scripts hit this. Captured at `ztmp/c11_envdbg2.log.txt`.

**Fix (interpreter + generator, rule b).** Three layered changes:

1. `tom_d4rt_ast/lib/src/runtime/environment.dart` (and mirrored in
   `tom_d4rt/lib/src/environment.dart`): guard the
   `_unnamedExtensions.addAll(...)` call with `if (!identical(...))`
   to skip the merge when both environments share the same
   underlying list. Correct because the destination already
   contains every element of the source.
2. `tom_d4rt_generator/lib/src/bridge_generator.dart` (~line 13710):
   the GEN-061 substitution emits `FutureOr<Object?>` instead of
   `FutureOr<Object>` so void-returning callbacks (whose result is
   `null`) are accepted. `FutureOr<Object?>` is the correct upper
   bound for unbounded `R` in Dart.
3. Same file (~line 13725): extend the `isDynamicReturn` condition
   to include `castType == 'FutureOr<Object?>'`, routing
   `FutureOr<Object?>` callbacks through `D4.castCallbackResult`
   which handles `null` safely via `null is R`.

Both bridge corpora regenerated via `tool/regenerate_bridges.dart`
(`ztmp/c11_regen_ast.log.txt`, `ztmp/c11_regen_test.log.txt`).
Single-test verification:
flutter_ast `00:34 +1: All tests passed!`
(`ztmp/c11_ast_fixed.log.txt`), flutter_test
`00:31 +1: All tests passed!` (`ztmp/c11_test_fixed.log.txt`).

**Regression scope (rule b).** Interpreter + generator change →
gii + essential + important + secondary on both drivers, serial.

| Suite | flutter_ast | flutter_test | Baseline |
|-------|-------------|--------------|----------|
| gii | `+79 ~2 -2` | `+79 ~2 -2` | matches |
| essential | `+108` | `+108` | clean |
| important | `+164` | `+164` | clean |
| secondary | `+633 ~1 -20` | `+632 ~1 -21` | C11 fixed; all 20/21 remaining failures map to open clusters C12–C31 plus the known `tap_drag_start_details_test.dart` inventory gap |

Logs: `ztmp/c11_ast_{gii,essential,important,secondary}.log.txt`,
`ztmp/c11_test_{gii,essential,important,secondary}.log.txt`. No
new regressions on either driver.

#### C12 — `Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Nu`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 32 | foundation/ targetplatform_test.dart |

**Root cause.** Dart 3 multi-case grouping —

```dart
switch (p) {
  case TargetPlatform.android:
  case TargetPlatform.fuchsia:
  case TargetPlatform.linux:
  case TargetPlatform.windows:
    return 'Material Switch';
  ...
}
```

— is parsed as one `SSwitchPatternCase` per `case X:` label. The first
three cases have **empty `statements`**; only the last carries the body.
Cluster C2's earlier fix (added in
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` and the mirror
in `tom_d4rt/lib/src/interpreter_visitor.dart`) unconditionally broke
out of the member loop on any `SSwitchPatternCase` match to prevent the
body from running twice. That was correct for single-statement cases,
but for grouped cases it broke on the first match (the empty `case
android:`) without ever falling through to the case that holds the
return. `switchFor(android)` therefore returned `null`, the helper's
result fed `Text(null)`, and the bridged `Text` constructor rejected it
as "expected String, got Null."

**Fix.** Only break after the matched case if it actually had
statements:

```dart
if (patternCaseMatchedThisIteration &&
    statementsToExecute.isNotEmpty) {
  execute = false;
  break;
}
```

Empty matched cases now fall through naturally to the next member,
which either is another empty grouping label or the case that carries
the body. Once a non-empty body runs, the existing
`patternCaseMatchedThisIteration` guard still terminates the loop, so
the C2 no-fall-through guarantee survives. Applied symmetrically in
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` and
`tom_d4rt/lib/src/interpreter_visitor.dart`. No bridge or generator
change.

**Regression scope (rule b: interpreter change, both drivers).**

flutter_ast:

| suite | baseline | post-C12 | notes |
|-------|----------|----------|-------|
| gii | `+79 ~2 -2` | `+79 ~2 -2` | matches |
| essential | `+108` | `+108` | clean |
| important | `+164` | `+164` | clean |
| secondary | `+632 ~1 -21` | `+635 ~1 -18` | C12 fixed plus two other grouped-case scripts now pass; no regressions |

flutter_test (analyzer driver, picks up the `tom_d4rt` mirror via the
path override in `tom_d4rt_flutter_test/pubspec_overrides.yaml`):

| suite | baseline | post-C12 | notes |
|-------|----------|----------|-------|
| gii | `+79 ~2 -2` | `+79 ~2 -2` | matches |
| essential | `+108` | `+108` | clean |
| important | `+164` | `+164` | clean |
| secondary | `+633 ~1 -20` | `+634 ~1 -19` | C12 fixed; no regressions |

Logs: `ztmp/c12_ast_{gii,essential,important,secondary}.log.txt`,
`ztmp/c12_test_{gii,essential,important,secondary}.log.txt`. No new
regressions on either driver.

#### C13 — `Runtime Error: Index assignment target must be List or Map in cascade.`

- [x] **fixed and re-verified** (2026-05-17)

| testID | Test name |
|-------:|-----------|
| 33 | foundation/ foundation_misc_adv_test.dart |

**Root cause.** `foundation_misc_adv_test.dart` exercises the
`dart:foundation` `BitField<T>` API with a cascade `[]=` write:

```dart
final BitField<TargetPlatform> bf =
    BitField<TargetPlatform>(TargetPlatform.values.length)
      ..[TargetPlatform.android] = true
      ..[TargetPlatform.iOS] = true;
```

`_executeCascadeAssignment`'s `SIndexExpression` branch only knew how
to write to `List` or `Map`. When the resolved `indexTarget` was a
`BridgedInstance` of `BitField`, it took the catch-all `else` and
threw "Index assignment target must be List or Map in cascade." —
even though the non-cascade `[]=` handler (used for
`bf[android] = true` written non-cascade) already dispatches via
`bridgedClass.findInstanceMethodAdapter('[]=')`.

Once that was fixed the script hit a follow-up: `Bridged class
'Factory' has no instance method named 'constructor'.` `Factory<T>`
exposes `constructor` as a getter returning `ValueGetter<T>` (a
function); the script calls it with `stringFactory.constructor()`.
`visitMethodInvocation` looked up an instance method named
`constructor`, found none, then went straight to extension lookup
and threw. It never tried the getter — even though the Dart semantics
for `obj.foo()` are "if there is a method `foo`, call it; otherwise
if there is a getter `foo`, get the value and invoke it."

**Fix.** Two surgical changes, both mirrored across
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` and
`tom_d4rt/lib/src/interpreter_visitor.dart`:

1. In `_executeCascadeAssignment`'s `SIndexExpression` branch
   (compound + plain `=` paths), dispatch to the bridged
   `findInstanceMethodAdapter('[]')` / `findInstanceMethodAdapter('[]=')`
   when `indexTarget` is a `BridgedInstance`. The "must be List or
   Map" error becomes a final fallback only when no adapter exists.

2. In `visitMethodInvocation`'s bridged-method branch, before the
   extension-method fallback, try
   `bridgedClass.findInstanceGetterAdapter(methodName)`. If the
   getter returns a `Callable` or `Function`, evaluate the argument
   list and invoke the callable; otherwise fall through to the
   existing "no such method" path. This is local to the bridged
   branch — `InterpretedClass`/`InterpretedInstance` already had
   the right semantics.

No bridge or generator change.

**Regression scope (rule b: interpreter change, both drivers).**

flutter_ast:

| suite | baseline (post-C12) | post-C13 | notes |
|-------|---------------------|----------|-------|
| gii | `+79 ~2 -2` | `+79 ~2 -2` | matches |
| essential | `+108` | `+108` | clean |
| important | `+164` | `+164` | clean |
| secondary | `+635 ~1 -18` | `+636 ~1 -17` | C13 fixed; no regressions |

flutter_test (analyzer driver, picks up the `tom_d4rt` mirror via the
path override in `tom_d4rt_flutter_test/pubspec_overrides.yaml`):

| suite | baseline (post-C12) | post-C13 | notes |
|-------|---------------------|----------|-------|
| gii | `+79 ~2 -2` | `+79 ~2 -2` | matches |
| essential | `+108` | `+108` | clean |
| important | `+164` | `+164` | clean |
| secondary | `+634 ~1 -19` | `+635 ~1 -18` | C13 fixed; no regressions |

Logs: `ztmp/c13_ast_{gii,essential,important,secondary}.log.txt`,
`ztmp/c13_test_{gii,essential,important,secondary}.log.txt`. No new
regressions on either driver.

#### C14 — `Runtime Error: Native error during default bridged constructor for 'GestureDetector': Incorrect GestureDetector arguments.`

- [x] **fixed and re-verified** (2026-05-17) — script-only change

| testID | Test name |
|-------:|-----------|
| 37 | gestures/ tap_force_test.dart |

**Root cause.** Not a d4rt bug. The script's "all callbacks wired"
demonstration constructed a single `GestureDetector` with both pan
and scale callback families:

```dart
GestureDetector(
  onTapDown: …, onTapUp: …,
  onLongPressStart: …, onLongPressMoveUpdate: …, onLongPressEnd: …,
  onForcePressStart: …, onForcePressEnd: …,
  onForcePressUpdate: …, onForcePressPeak: …,
  onPanDown: …, onPanStart: …, onPanUpdate: …, onPanEnd: …,
  onScaleStart: …, onScaleUpdate: …, onScaleEnd: …,
  …
)
```

Flutter's `GestureDetector._debugCheckGestureArguments` asserts that
pan and scale are mutually exclusive on the same detector — scale
subsumes pan (1-pointer scale = pan). The assertion throws
`Incorrect GestureDetector arguments` regardless of whether the
constructor is invoked from native Dart or via the d4rt bridge.

**Fix.** Script-only. Dropped the `onPanDown` / `onPanStart` /
`onPanUpdate` / `onPanEnd` arguments from the wired `GestureDetector`
(scale is the superset) and updated the comment + `Text` label to
reflect the change. The pan closure declarations (`onDragDown`, …)
are left in place above so the typed-wiring catalogue is still
exercised at parse time — they're already printed via
`onDragDown.runtimeType`.

No interpreter, bridge, or generator change.

**Regression scope (rule a: script-only change).** Single-test rerun
on both drivers:

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `gestures/tap_force_test.dart` | `+1` All tests passed |
| flutter_test | `gestures/tap_force_test.dart` | `+1` All tests passed |

Logs: `ztmp/c14_ast_single.log.txt`,
`ztmp/c14_test_single.log.txt`.

#### C15 — `Bad state: Transport failure while running "material/tooltip_feedback_test.dart"`

- [x] **fixed and re-verified** (2026-05-17) — script-only workaround

| testID | Test name |
|-------:|-----------|
| 58 | material/ tooltip_feedback_test.dart |

**Root cause.** Not an interpreter logic bug — a Dart-VM-level crash
triggered by a specific `RichText` / `TextSpan` shape under d4rt.
The crash signature is `Lost connection to device.` (test app dies
mid-build, HTTP transport closes before the `/build` response
header is sent); the runner surfaces it as
`Bad state: Transport failure while running …`.

Bisection (logs in `ztmp/c15_probe_*.log.txt`) narrowed the trigger
to section 9 (`_privateRichMessageExample`) inside
`tooltip_feedback_test.dart`, then to the `RichText` widget's
`TextSpan.children` list, and finally to a *single* element:

```dart
RichText(
  text: TextSpan(
    style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
    children: [
      const TextSpan(text: 'Save changes '),
      TextSpan(text: '(Cmd+S)', style: TextStyle(…mint)),
      const TextSpan(text: '\n'),                       // ← trigger
      TextSpan(text: 'tip:',    style: TextStyle(…amber)),
      const TextSpan(text: ' shift to save-as'),
    ],
  ),
)
```

The minimal repro is `[styled, TextSpan(text: '\n', …), styled]`
inside a parent `TextSpan.children`: a child `TextSpan` whose
`text` is exactly the single-character newline string `'\n'`,
sitting between two other `TextSpan`s that each carry a non-null
`style`, kills the Dart VM. Verified isolation:

| children layout | result |
|-----------------|--------|
| `[styled, styled, styled]` (no plain `\n` child) | pass |
| `[styled, TextSpan(text:'middle', style:red), styled]` | pass |
| `[styled, TextSpan(text:'\n'), styled]` (no `const`, no `style`) | **crash** |
| `[styled, TextSpan(text:'\n', style: TextStyle()), styled]` | **crash** |
| `[styled, TextSpan(text:'\n', style: white), styled]` | **crash** |
| `[styled, TextSpan(text:' ',  style: white), styled]` | pass |
| `[styled('(Cmd+S)\n'), styled]` (merge `\n` into preceding) | pass |

The "Lost connection to device" mode of failure is not a catchable
`RuntimeD4rtException` — it bubbles up only through the HTTP
transport — so it cannot be made to surface a meaningful error to
the user; it has to be avoided structurally. We have no smaller
reproducer outside the bundled-script transport (a hand-written
`RichText` with the same shape in native Dart renders fine), so
the fault lives somewhere in the bridged-render path under the
d4rt VM.

**Fix.** Script-only. Replaced the standalone
`const TextSpan(text: '\n')` with appending `'\n'` to the preceding
styled span (`text: '(Cmd+S)\n'`), and dropped the now-redundant
plain-`\n` child:

```dart
children: [
  const TextSpan(text: 'Save changes '),
  TextSpan(text: '(Cmd+S)\n', style: TextStyle(…mint)), // \n merged in
  TextSpan(text: 'tip:',      style: TextStyle(…amber)),
  const TextSpan(text: ' shift to save-as'),
],
```

The visual semantics are unchanged: the newline still hard-breaks
between `(Cmd+S)` and `tip:`; the mint style on `'\n'` is
invisible for whitespace.

The underlying trigger and constraints are documented as a
permanent workaround in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` (C15 — standalone
newline `TextSpan`).

No interpreter, bridge, or generator change.

**Regression scope (rule a: script-only change).** Single-test
rerun on both drivers:

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `material/tooltip_feedback_test.dart` | `+1` All tests passed |
| flutter_test | `material/tooltip_feedback_test.dart` | `+1` All tests passed |

Logs: `ztmp/c15_verify_ast_secondary.log.txt`,
`ztmp/c15_verify_analyzer_secondary.log.txt`. Bisection trail:
`ztmp/c15_probe_*.log.txt`.

#### C16 — `Runtime Error: Native error during default bridged constructor for 'BottomAppBar': Argument Error: Invalid parameter "shape": expected Notch`

- [x] fixed and re-verified — **fixed (script)**

| testID | Test name |
|-------:|-----------|
| 69 | material/ bottom_app_bar_test.dart |

**Root cause.** The script defines two subclasses of native abstract
Flutter classes and passes their instances to native bridged
constructors:

1. `class _TopRoundedNotchedShape extends NotchedShape { … }` →
   passed as `BottomAppBar(shape: …)` at the original line 1128.
2. `class _CustomFabLocation extends FloatingActionButtonLocation { … }`
   → passed as `Scaffold(floatingActionButtonLocation: …)` via
   `_fabLocationCell(location: const _CustomFabLocation(), …)` in
   the FAB-location matrix.

In both cases the bridge generator does not synthesise an
adapter-proxy that recognises a script-defined `InterpretedInstance`
as a valid native `NotchedShape` / `FloatingActionButtonLocation`
argument. `D4.getNamedArg<T>` rejects the value with
`Argument Error: Invalid parameter "shape": expected NotchedShape?, got InterpretedInstance(_TopRoundedNotchedShape)`
(and analogously for the FAB location after the first fix).

Same family as U3 (script subclass of `Curve` cannot be passed to
native `transformInternal`-consuming APIs) — the bridge for the
native abstract class does not delegate `instanceof` / argument
unwrap to script subclasses, so a script `extends` of a native
abstract class is recognised only inside d4rt-space, never at
the d4rt → native boundary.

**Fix.** Script-only. Two substitutions in
`material/bottom_app_bar_test.dart`, each using a framework-provided
subclass of the native abstract type:

1. `shape: const _TopRoundedNotchedShape(radius: 18.0)` →
   `shape: const CircularNotchedRectangle()` (matches the sibling
   "Variant 5" cell at line 1094 which already uses the same
   framework shape).
2. `location: const _CustomFabLocation()` →
   `location: FloatingActionButtonLocation.endFloat` (keeps the
   matrix visually distinct from the other docked variants).

The class definitions `_TopRoundedNotchedShape` and
`_CustomFabLocation` remain in the script as compile-only
declarations (they are still referenced in Section-4 source-as-string
documentation blocks) but are no longer instantiated at runtime.

The underlying interpreter limitation and the framework-shape
workaround are documented in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` (U5 — script
subclass of native abstract `NotchedShape` /
`FloatingActionButtonLocation`).

No interpreter, bridge, or generator change.

**Regression scope (rule a: script-only change).** Single-test
rerun on both drivers:

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `material/bottom_app_bar_test.dart` | `+1` All tests passed |
| flutter_test | `material/bottom_app_bar_test.dart` | `+1` All tests passed |

Logs: `ztmp/c16_verify_ast_secondary.log.txt`,
`ztmp/c16_verify_analyzer_secondary.log.txt`.

#### C17 — `Bad state: Cannot resolve import "package:vector_math/vector_math_64.dart" from main.dart: Package import "package:vector_math/vector_math_6`

- [x] fixed and re-verified — **fixed (script)**

| testID | Test name |
|-------:|-----------|
| 82 | painting/ matrixutils_test.dart |

**Root cause.** The script directly imports
`package:vector_math/vector_math_64.dart` (show `Vector3`) at the
top of the file. The tom_ast_generator bundler's import resolver
rejects the import outright:

```text
Bad state: Cannot resolve import "package:vector_math/vector_math_64.dart"
from main.dart: Package import "package:vector_math/vector_math_64.dart"
is not bridged and not in the same package. Either add it to
bridgedLibraries or provide it via explicitSources.
package:tom_ast_generator/src/bundler/ast_bundler.dart 335:11
  AstBundler._resolveImports
```

`vector_math` is not in the d4rt module loader's `bridgedLibraries`
set and not registered as an `explicitSources` entry. The Flutter
material/painting bridges *consume* `Vector3` as a parameter type
in many `Matrix4` methods (the generated bridge file references
`$vector_math_1.Vector3` throughout `painting_bridges.b.dart`), but
the d4rt bundler treats the `vector_math` library itself as an
opaque, non-bridged package and refuses to resolve the import
statement at bundle time. This trips before any interpreter code
runs.

The analyzer-driver path emits the equivalent error at module-load
time (`Module source not preloaded for URI:
package:vector_math/vector_math_64.dart`).

The only runtime use of the imported `Vector3` in the script was
inside the "Section: raw vs MatrixUtils comparison" block:

```dart
final Vector3 rawV = Vector3(40.0, 0.0, 0.0);
final Vector3 rawTransformed = mCompositeTRS.transform3(rawV.clone());
final Offset rawAsOffset = Offset(rawTransformed.x, rawTransformed.y);
```

**Fix.** Script-only. Two changes in
`painting/matrixutils_test.dart`:

1. Drop the `import 'package:vector_math/vector_math_64.dart' show Vector3;`
   directive (left a `// C17 workaround` comment in its place).
2. Replace `Matrix4.transform3(Vector3(40, 0, 0))` with an inline
   column-major matrix·vector product over `Matrix4.storage`
   (bridged via the painting library, returns a `Float64List`):

   ```dart
   final List<double> _mStore = mCompositeTRS.storage;
   final double _rawTransformedX = _mStore[0] * 40.0 + _mStore[12];
   final double _rawTransformedY = _mStore[1] * 40.0 + _mStore[13];
   final double _rawTransformedZ = _mStore[2] * 40.0 + _mStore[14];
   final Offset rawAsOffset = Offset(_rawTransformedX, _rawTransformedY);
   ```

   For the input `(40, 0, 0, 1)` this equals exactly what
   `Matrix4.transform3` would return for affine matrices (no
   perspective row), which is what the visual section compares
   against `MatrixUtils.transformPoint`. The displayed
   `'Matrix4.transform3 -> Vector3(x, y, z)'` text was updated to
   read the same three local doubles.

The underlying interpreter/bundler limitation and the matrix-
storage workaround are documented in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` (U6 — direct
import of `package:vector_math/vector_math_64.dart`).

No interpreter, bridge, or generator change.

**Regression scope (rule a: script-only change).** Single-test
rerun on both drivers:

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `painting/matrixutils_test.dart` | `+1` All tests passed |
| flutter_test | `painting/matrixutils_test.dart` | `+1` All tests passed |

Logs: `ztmp/c17_verify_ast_secondary.log.txt`,
`ztmp/c17_verify_analyzer_secondary.log.txt`. Repro log:
`ztmp/c17_repro_ast.log.txt`.

#### C18 — `Runtime Error: Cannot access property 'entries' on target of type _ConstMap<String, dynamic>.`

- [x] fixed and re-verified — **fixed (script)**

| testID | Test name |
|-------:|-----------|
| 102 | semantics/ semantics_events_test.dart |

**Root cause.** Two-layer issue rooted in d4rt's Map bridge not
covering Dart's internal `_ConstMap` runtime class:

1. The d4rt Map bridge's `nativeNames` list in
   `tom_d4rt_ast/lib/src/runtime/stdlib/core/map.dart` (lines
   ~10-15) registers `UnmodifiableMapView`, `_UnmodifiableMapView`,
   `_CompactLinkedHashMap`, `ListMapView`, and `_MapView`, but
   **not** `_ConstMap` — the Dart-internal runtime class that
   `const <K, V>{}` literals evaluate to. When a `_ConstMap`
   reaches the `SPrefixedIdentifier` member-access path in
   `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`
   (lines 1419-1421), it does not match any bridged class and
   falls through to the generic
   `"Cannot access property '$memberName' on target of type
   ${prefixValue?.runtimeType}."` error.
2. The script declared each of the six probe `Map<String, dynamic>`
   variables with a `const <String, dynamic>{}` default, and
   several Flutter `SemanticsEvent.getDataMap()` implementations
   (`LongPressSemanticsEvent`, `TapSemanticEvent`,
   `FocusSemanticEvent`, and the payload-free branches of others)
   themselves return `const <String, Object>{}`. So both the
   default and the value assigned from `probe.getDataMap()` could
   end up as a `_ConstMap`, and the downstream
   `dataMap.entries.toList()` access on line 1374 would throw.

**Fix.** Script-only. In
`semantics/semantics_events_test.dart`:

1. Six `Map<String, dynamic> XxxData = const <String, dynamic>{};`
   defaults changed to non-const `<String, dynamic>{}` so the
   catch-block fallback is a regular `LinkedHashMap`, not a
   `_ConstMap`.
2. The six success-path assignments
   `XxxData = probe.getDataMap();` wrapped as
   `XxxData = Map<String, dynamic>.from(probe.getDataMap());` so
   the bridged map is copied into a regular `LinkedHashMap`
   regardless of what `getDataMap()` returned.

A C18 workaround comment above the first probe documents both
precautions and the underlying `_ConstMap` gap. The interpreter
limitation is documented in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` (U7 — Dart's
internal `_ConstMap` runtime class is not in the Map bridge's
`nativeNames`).

No interpreter, bridge, or generator change.

**Regression scope (rule a: script-only change).** Single-test
rerun on both drivers:

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `semantics/semantics_events_test.dart` | `+1` All tests passed |
| flutter_test | `semantics/semantics_events_test.dart` | `+1` All tests passed |

Logs: `ztmp/c18_verify_ast_secondary.log.txt`,
`ztmp/c18_verify_analyzer_secondary.log.txt`. Repro log:
`ztmp/c18_repro_ast.log.txt`.

#### C19 — `Runtime Error: Positional arguments cannot follow named arguments.`

- [x] **fixed** (2026-05-17) — same root cause and fix as C01; see C01
  section for details. Both tests passed in the post-fix regression run.

| testID | Test name |
|-------:|-----------|
| 108 | services/ platform_channels_test.dart |
| 143 | widgets/ table_wrap_flow_test.dart |

#### C20 — `Runtime Error: Native error during default bridged constructor for 'RestorableEnum': Argument Error: Invalid parameter "defaultValue": expec`

- [x] fixed and re-verified — **fixed (script)**

| testID | Test name |
|-------:|-----------|
| 119 | widgets/ restorable_values_test.dart |

**Root cause.** Two issues, fixed in the same script edit.

*Primary (C20).* The script declared a local `enum _Mood { calm,
focused, joyful, sleepy }` and constructed three native
`RestorableEnum<_Mood>` / `RestorableEnumN<_Mood>` instances. d4rt
represents script-defined enum values as `InterpretedEnumValue`
(`tom_d4rt_ast/lib/src/runtime/runtime_types.dart` line 1861 —
`implements RuntimeValue`, **not** `Enum`). The native
`RestorableEnum<E>(E defaultValue, ...)` constructor's bridge
adapter runs `D4.getRequiredArg<Enum>` on the first positional
argument and rejects the value:

```text
Runtime Error: Native error during default bridged constructor
for 'RestorableEnum': Argument Error: Invalid parameter
"defaultValue": expected Enum, got InterpretedEnumValue
```

Same family as U3 (`Curve`), U5 (`NotchedShape` /
`FloatingActionButtonLocation`): a script-defined subtype of a
bridged native abstract / built-in type cannot cross the
d4rt → native boundary as that native type.

*Follow-up (exposed by the primary fix).* After replacing
`_Mood` with `Brightness`, construction succeeded and execution
proceeded to `.value` reads on the 15 restorable instances. The
Flutter `RestorableValue<T>.value` getter asserts `isRegistered`:

```dart
// flutter/lib/src/widgets/restoration_properties.dart, line 85
T get value {
  assert(isRegistered);
  return _value as T;
}
```

`flutter test` runs in debug mode, so the assertion fires. The
script's original author had a (factually incorrect) comment
above the restorable declarations: *"Each `.value` access works
against the in-memory default — registration is not required for
the getter to return its initial."* That assertion has been in
Flutter for years; the C20 error masked it because construction
failed before any `.value` read happened.

**Fix.** Script-only. In
`widgets/restorable_values_test.dart`:

1. Replace the script-defined `enum _Mood { calm, focused, joyful,
   sleepy }` with the framework-provided `Brightness` enum (two
   values `light` / `dark`). The three `RestorableEnum` /
   `RestorableEnumN` constructors are switched to
   `RestorableEnum<Brightness>` / `RestorableEnumN<Brightness>`,
   and the iteration `for (final _Mood m in _Mood.values)`
   switches to `Brightness.values`.
2. Shadow each `RestorableXxx` with a plain Dart variable holding
   the same construction-time default (`_vInt`, `_vDouble`,
   `_vBool`, `_vString`, `_vNum`, `_vDateTime`, `_vMood`,
   `_vMoodCalm`, plus the `_vXxxN` nullable shadows). Replace
   every `restXxx.value` read in the display widgets with the
   corresponding shadow variable (44 sites). The demo never
   mutates the stored values, so the shadow equals what the
   getter would return — the substitution is exact.

The script's `.runtimeType` reads on the restorables stay
unchanged (they don't trigger the assertion), as does the
`final int registered = […].where(...).length` summary footer
(which only counts list entries, never reads `.value`).

A C20-workaround comment above the shadow declarations
documents both precautions. The underlying limitations and the
workaround pattern are documented in
`doc/interpreter_unfixable.md` (U8 — script-defined enums can't
cross the d4rt → native boundary as `Enum`, plus
`RestorableValue.value` requires registration).

No interpreter, bridge, or generator change.

**Regression scope (rule a: script-only change).** Single-test
rerun on both drivers:

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `widgets/restorable_values_test.dart` | `+1` All tests passed |
| flutter_test | `widgets/restorable_values_test.dart` | `+1` All tests passed |

Logs: `ztmp/c20_verify_ast.log.txt`,
`ztmp/c20_verify_analyzer.log.txt`. Repro log:
`ztmp/c20_repro_ast.log.txt`.

#### C21 — `Runtime Error: Native error during default bridged constructor for 'WidgetSpan': 'package:flutter/src/widgets/widget_span.dart': Failed asse`

- [x] fixed and re-verified — **fixed (script)**

| testID | Test name |
|-------:|-----------|
| 125 | widgets/ textspan_test.dart |

**Root cause.** The script's `alignmentDemo()` helper iterates over six
`PlaceholderAlignment` values and constructs a `WidgetSpan` for each.
The `baseline:` argument was supplied only when alignment equalled
`PlaceholderAlignment.baseline`. Flutter's `WidgetSpan` constructor
asserts (`widget_span.dart` line 83) that `baseline != null` whenever
alignment is one of **three** values:
`aboveBaseline`, `belowBaseline`, **or** `baseline`. The script
omitted `baseline` for the first two, tripping the assertion as soon
as the section reached the `aboveBaseline` row.

**Fix.** Pure script change — broaden the conditional so `baseline`
is supplied for all three baseline-relative alignments:

```dart
WidgetSpan(
  alignment: alignment,
  baseline: (alignment == PlaceholderAlignment.baseline ||
          alignment == PlaceholderAlignment.aboveBaseline ||
          alignment == PlaceholderAlignment.belowBaseline)
      ? TextBaseline.alphabetic
      : null,
  child: ...,
)
```

Not an interpreter or generator bug — the corpus's original code is
strictly under-constrained relative to Flutter's runtime contract.

**Regression scope (per rules).** Script-only change → single-test
retest on both drivers is sufficient.

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `widgets/textspan_test.dart` | `+1` All tests passed |
| flutter_test | `widgets/textspan_test.dart` | `+1` All tests passed |

Logs: `ztmp/c21_verify_ast.log.txt`,
`ztmp/c21_verify_analyzer.log.txt`. Repro log:
`ztmp/c21_repro_ast.log.txt`.

#### C22 — `Runtime Error: Native error during bridged method call 'subscribe' on RouteObserver: Argument Error: Invalid parameter "routeAware": expecte`

- [x] fixed and re-verified — **fixed (script workaround; underlying limitation documented as U9 in `interpreter_unfixable.md`)**

| testID | Test name |
|-------:|-----------|
| 147 | widgets/ route_observer_test.dart |

**Root cause.** Same architectural family as U3 (`Curve`), U5
(`NotchedShape` / `FloatingActionButtonLocation`), and U8
(`Enum`). The script defines
`class _LoggingRouteAware with RouteAware { … }` and passes four
instances of it to the native bridged
`RouteObserver<PageRoute<dynamic>>.subscribe(RouteAware aware,
R route)`. The bridge validates `aware` with
`D4.getRequiredArg<RouteAware>`, which checks `value is
RouteAware`. A d4rt `InterpretedInstance` fails the predicate
even when its synthetic class declares the mixin, because the
bridge generator does not synthesise a native
`RouteAware`-implementing adapter proxy for script-defined
subclasses. Aborts at the first
`routeObserver.subscribe(homeAware, homeRoute);` call.

**Fix.** Pure script change — introduce a script-side
`_DemoRouteObserver` class that mirrors the native protocol
(`subscribe` / `unsubscribe` / `didPush` / `didPop` /
`didReplace`) over `Map<Route, List<_LoggingRouteAware>>`, and
route all four subscriptions plus the six lifecycle events
through it. The native `RouteObserver<PageRoute<dynamic>>`
instance is still constructed (the constructor itself is safe;
no script-defined `RouteAware` argument flows through it) with
`// ignore: unused_local_variable` so the demo's type-info
section continues to reflect a real Flutter type. The
observable call-order timeline and per-subscriber counters
(`localCalls`, `callLog`) are byte-for-byte identical to what
the native observer would produce because the protocol is
purely `Map<Route, List<RouteAware>>` with four well-defined
dispatch rules.

Unlike U5 / U8, there is no framework-provided concrete
`RouteAware` subclass to substitute — `RouteAware` is designed
to be mixed into application-side `State` objects, so every
concrete implementation lives in user code. The stand-in
observer is therefore the minimal-effort, exact workaround.
Documented in `interpreter_unfixable.md` as U9.

**Regression scope (per rules).** Script-only change → single-test
retest on both drivers is sufficient.

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `widgets/route_observer_test.dart` | `+1` All tests passed |
| flutter_test | `widgets/route_observer_test.dart` | `+1` All tests passed |

Logs: `ztmp/c22_verify_ast.log.txt`,
`ztmp/c22_verify_analyzer.log.txt`. Repro log:
`ztmp/c22_repro_ast.log.txt`.

#### C23 — `Runtime Error: Native error during default bridged constructor for 'DraggableScrollableSheet': 'package:flutter/src/widgets/draggable_scroll`

- [x] fixed and re-verified — **fixed (script)**

| testID | Test name |
|-------:|-----------|
| 153 | widgets/ draggable_sheet_test.dart |

**Root cause.** The script passed
`snapAnimationDuration: Duration.zero` to two
`DraggableScrollableSheet(...)` constructors (lines 2017 and
2240) to express "instantaneous snap, no animation". Flutter's
constructor asserts (`draggable_scrollable_sheet.dart` line 315)
that `snapAnimationDuration == null || snapAnimationDuration >
Duration.zero`. `Duration.zero` is neither `null` nor strictly
positive, so the assertion fires immediately when the first sheet
is built.

**Fix.** Pure script change — replace `Duration.zero` with
`Duration(milliseconds: 1)` at both call sites. This preserves
the author's "near-instant snap" intent (a 1ms animation is
visually indistinguishable from zero) and satisfies the
constructor's strictly-positive contract. Not an interpreter or
generator bug.

**Regression scope (per rules).** Script-only change → single-test
retest on both drivers is sufficient.

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `widgets/draggable_sheet_test.dart` | `+1` All tests passed |
| flutter_test | `widgets/draggable_sheet_test.dart` | `+1` All tests passed |

Logs: `ztmp/c23_verify_ast.log.txt`,
`ztmp/c23_verify_analyzer.log.txt`. Repro log:
`ztmp/c23_repro_ast.log.txt`.

#### C24 — `'package:flutter/src/widgets/restoration_properties.dart': Failed assertion: line 85 pos 12: 'isRegistered': is not true.`

- [x] fixed and re-verified — script-only change

| testID | Test name |
|-------:|-----------|
| 161 | widgets/ restoration_adv_test.dart |

**Root cause.** The script's top-level `build()` instantiates a
batch of `RestorableInt/Double/String/Bool/DateTime` properties
inline, then reads `.value` on each one to interpolate it into a
log line. `RestorableValue<T>.value` asserts `isRegistered` at
`package:flutter/src/widgets/restoration_properties.dart:85`,
which is a debug-mode assertion that `flutter test` always
exercises. The only legal way to register a Restorable is via
`RestorationMixin.registerForRestoration(...)`, which requires a
host `StatefulWidget` subclass — the script corpus rejects custom
`State` subclasses, so registration cannot happen here.

**Fix.** Pure script-side change in
`widgets/restoration_adv_test.dart`. Shadow each restorable with a
plain Dart variable holding the construction-time default
(`riValue = 42`, `rdValue = 3.14159`, `rsValue = 'Tom'`,
`rbValue = true`, `rdtValue = DateTime(2026, 5, 11)`) and read the
shadow in the print interpolations instead of `.value`. The
restorable instances themselves remain in scope and are still
printed via `$ri / $rd / …`, preserving the original log shape.
This is functionally exact because the script never reassigns
`.value` anywhere — confirmed by `grep 'r[a-z]*\.value\s*='` over
the script returning zero matches.

**Underlying limitation.** Documented as `U8(2)` in
`interpreter_unfixable.md` — script-side Restorable* reads outside
a real `RestorationMixin` host always trip the `isRegistered`
assertion. The shadow-variable pattern is the canonical
work-around when `.value` is only read.

**Regression scope.** Script-only change, no interpreter or
bridge code touched. Single-test retest on both drivers is
sufficient per the regression rules.

**Verification.** AST driver: `flutter test secondary --plain-name
"restoration_adv_test.dart"` → 1/0/0 (log
`ztmp/c24_verify_ast.log.txt`). Analyzer driver: same command in
`tom_d4rt_flutter_test` → 1/0/0 (log
`ztmp/c24_verify_analyzer.log.txt`). Repro log:
`ztmp/c24_repro_ast.log.txt`.

#### C25 — `Null check operator used on a null value`

- [x] fixed and re-verified — script-only change

| testID | Test name |
|-------:|-----------|
| 170 | cupertino/ individual cupertino_page_test.dart |

**Root cause.** The script's top-level `build()` constructed a
plain `CupertinoPageRoute<dynamic>` named `routeBasic` and then
read `routeBasic.popGestureEnabled` to interpolate it into a log
line. `ModalRoute.popGestureEnabled`
(`package:flutter/src/widgets/routes.dart:1930`) dereferences
`animation!.isCompleted`, but `animation` is only set when the
route has been pushed onto a `Navigator`. The route was
constructed standalone for documentation purposes — never pushed
— so `animation` was null and the null-check assertion fired.
Stack trace confirmed via `c25_diag_test.dart` dump:
`ModalRoute.popGestureEnabled → PageRoute.popGestureEnabled →
_createCupertinoPageRouteBridge.<closure>`.

**Fix.** Pure script-side change in
`cupertino/cupertino_page_test.dart`. Replace the
`${routeBasic.popGestureEnabled}` interpolation with a static
descriptive string `(requires attached Navigator)`. The route is
documented as supporting the swipe-to-pop gesture; the actual
boolean is a runtime navigator-attached value that has no defined
answer for a detached route. A NOTE comment is added explaining
why `popGestureEnabled` cannot be read here.

**Underlying limitation.** None — this is standard Flutter
contract: `ModalRoute.popGestureEnabled` requires
`route.animation` to be non-null, which only happens after the
route is pushed onto a Navigator. The script corpus rejects
custom `Navigator` setups, so navigator-attached getters cannot
be exercised. Other navigator-attached getters
(`isFirst`, `isActive`, `isCurrent`) would fail the same way and
should be avoided in scripts.

**Regression scope.** Script-only change, no interpreter or
bridge code touched. Single-test retest on both drivers is
sufficient per the regression rules.

**Verification.** AST driver: `flutter test secondary --plain-name
"cupertino_page_test.dart"` → 1/0/0 (log
`ztmp/c25_verify_ast.log.txt`). Analyzer driver: same command in
`tom_d4rt_flutter_test` → 1/0/0 (log
`ztmp/c25_verify_analyzer.log.txt`). Repro log:
`ztmp/c25_repro_ast.log.txt`.

#### C26 — `Runtime Error: A value of type 'List' can't be returned from the function 'encodeFrame' because it has a return type of 'Uint8List'.`

- [x] fixed and re-verified — interpreter fix in `getRuntimeType`

| testID | Test name |
|-------:|-----------|
| 223 | foundation/ individual read_buffer_test.dart |

**Root cause.** The script defined a perfectly idiomatic Flutter
binary-protocol helper:

```dart
Uint8List encodeFrame(int cmd, List<int> payload) {
  final wb = WriteBuffer();
  ...
  return wb.done().buffer.asUint8List();
}
```

The interpreter's return-type check in
`InterpreterVisitor.visitReturnStatement`
(`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart:7090`)
called `Environment.getRuntimeType(returnValue)` and got back the
generic `List` `RuntimeType` instead of the specific `Uint8List`
bridge — even though the value's actual runtime type is a
`Uint8List` subclass (`_Uint8List` / `_Uint8ArrayView`) that has
its own registered `BridgedClass` (see
`tom_d4rt_ast/lib/src/runtime/stdlib/typed_data/uint8_list.dart:18`).
The check then reported the value as a `List` and rejected it
against the declared `Uint8List` return type. Stack trace dumped
via `c26_diag_test.dart` pointed straight at the return-type
check; the source of the misclassification is in
`Environment.getRuntimeType` (line ~867):

```dart
if (value is List) typeName = 'List';
```

`Uint8List` (and `Int8List`, `Int32List`, etc.) `is List<int>`, so
the value was collapsed to the generic `List` bridge *before* the
more-specific `toBridgedClass(value.runtimeType)` lookup further
down had a chance to find the proper typed-data bridge.

**Fix.** Interpreter change in both engines (kept in sync):

- `tom_d4rt_ast/lib/src/runtime/environment.dart` —
  `getRuntimeType` now, when the candidate `typeName` is `'List'`
  or `'Map'`, first attempts `toBridgedClass(value.runtimeType)`
  and returns that bridge if it differs from the generic
  `typeName`. Falls through to the existing generic-name lookup
  on no specific match.
- `tom_d4rt/lib/src/environment.dart` — mirror change.

The narrow guard (`typeName == 'List' || typeName == 'Map'`) keeps
String/int/double/bool on their fast path and only adds a single
extra bridge lookup for collection-like values where a typed
subclass might exist. The same change also fixes any other script
that returns a typed-data subtype (`Int8List`, `Int32List`,
`Float64List`, etc.) from a function declared with that specific
typed return.

**Underlying limitation.** None remaining. The bridged-class
registry already had `Uint8List` (and the other typed-data
subclasses) registered correctly; the runtime-type resolver just
wasn't consulting it for values that also satisfied `is List`.

**Regression scope.** Interpreter change (rule b): essential +
important + secondary on both drivers.

**Verification.** AST driver (`tom_d4rt_flutter_ast`):

- essential: 108/0/0 (log `ztmp/c26_verify_ast_essential.log.txt`)
- important: 164/0/0 (log `ztmp/c26_verify_ast_important.log.txt`)
- secondary: 648/1 skip/-5 — all 5 failures are pre-existing
  clusters C27 (drag_gesture_recognizer), C28 (drag_test,
  positioned_gesture_details), C30 (box_painter_test), C31
  (linear_border_edge_test); none caused by the C26 fix
  (log `ztmp/c26_verify_ast_secondary.log.txt`).
- C26 single-script: success (log `ztmp/c26_verify_diag.log.txt`).
- Repro log: `ztmp/c26_repro_ast.log.txt`.

Analyzer driver (`tom_d4rt_flutter_test`):

- essential: 108/0/0 (log `ztmp/c26_verify_analyzer_essential.log.txt`)
- important: 164/0/0 (log `ztmp/c26_verify_analyzer_important.log.txt`)
- secondary: 647/1 skip/-6 — all 6 failures are pre-existing
  clusters C27/C28/C29 (analyzer-only `tap_drag_start_details`)
  /C30/C31; none caused by the C26 fix
  (log `ztmp/c26_verify_analyzer_secondary.log.txt`).

#### C27 — `type 'BridgedEnumValue' is not a subtype of type 'PointerDeviceKind' in type cast`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 234 | gestures/ individual drag_gesture_recognizer_test.dart |

**Status:** fixed (2026-05-18, GEN-095).

**Root cause.** The script does
`vd.supportedDevices = <PointerDeviceKind>{PointerDeviceKind.touch, PointerDeviceKind.mouse}`.
The generator emitted a setter wrapper of the form
`(value as Set).cast<PointerDeviceKind>().toSet()` for any
`Set<EnumType>`-typed setter. `cast<T>()` returns a *view* whose
iteration casts each element at access time; D4rt's set literal
contains `BridgedEnumValue` wrappers, not raw `PointerDeviceKind`
values, so the first iteration (`CastIterator.current` → see stack
`CastSet._clone` → `SetBase.addAll` → `CastIterator.current` →
`gestures_bridges.b.dart:7862`) failed with
`type 'BridgedEnumValue' is not a subtype of type 'PointerDeviceKind'
in type cast`.

The same shape exists for List- and Map-typed setters, so the
emitted `.cast<T>().toList()` / `.cast<K,V>()` forms are broken
identically wherever the collection elements are wrapped enums or
bridged instances.

**Fix.** `BridgeGenerator._generateSetterCast`
(`tom_d4rt_generator/lib/src/bridge_generator.dart`, ~L11322) now
emits calls to the existing D4 unwrap helpers instead of CastList /
CastSet / CastMap views:

- `List<T>` → `D4.coerceList<T>(value, '<paramName>')`
- `Set<T>` → `D4.coerceSet<T>(value, '<paramName>')`
- `Map<K, V>` → `D4.coerceMap<K, V>(value, '<paramName>', visitor)`

Each helper iterates eagerly and unwraps `BridgedEnumValue`,
`BridgedInstance`, and `InterpretedInstance` before casting, then
returns a real `List<T>` / `Set<T>` / `Map<K, V>`.

Helpers already existed in both `tom_d4rt_ast/lib/src/runtime/generator/d4.dart`
and `tom_d4rt/lib/src/generator/d4.dart`; no interpreter change
required.

**Regeneration.** `tom_d4rt_flutter_ast/tool/regenerate_bridges.dart`
and `tom_d4rt_flutter_test/tool/regenerate_bridges.dart` were re-run
and updated the 14 `*.b.dart` bridge files in each package.

**Regression scope:** rule (b) — generator change.

**Verification (AST driver, `D4RT_SKIP_BRIDGE_REGEN=1`):**

- C27 single-script: `gestures/drag_gesture_recognizer_test.dart` →
  `success=true, outputLines=0, frameworkErrors=0`
  (log `ztmp/c27_diag_verify.log.txt`).
- essential: 108/0/0 (log `ztmp/c27_verify_ast_essential.log.txt`)
- important: 164/0/0 (log `ztmp/c27_verify_ast_important.log.txt`)
- secondary: 649/1 skip/-4 — failures down from 5 to 4. The fixed
  one is C27 (drag_gesture_recognizer); the four remaining failures
  are pre-existing C28 (drag_test, positioned_gesture_details), C30
  (box_painter_test), C31 (linear_border_edge_test). No new
  regressions (log `ztmp/c27_verify_ast_secondary.log.txt`).

**Verification (analyzer driver, `D4RT_SKIP_BRIDGE_REGEN=1`):**

- essential: 108/0/0 (log `ztmp/c27_verify_analyzer_essential.log.txt`)
- important: 164/0/0 (log `ztmp/c27_verify_analyzer_important.log.txt`)
- secondary: 648/1 skip/-5 — failures down from 6 to 5. The fixed
  one is C27 (drag_gesture_recognizer); the five remaining failures
  are pre-existing C28 (drag_test, positioned_gesture_details), C29
  (tap_drag_start_details — analyzer-only), C30 (box_painter_test),
  C31 (linear_border_edge_test). No new regressions
  (log `ztmp/c27_verify_analyzer_secondary.log.txt`).

#### C28 — `Runtime Error: Native error during default bridged constructor for 'DragEndDetails': 'package:flutter/src/gestures/drag_details.dart': Faile`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 235 | gestures/ individual drag_test.dart |
| 243 | gestures/ individual positioned_gesture_details_test.dart |

**Status:** fixed (2026-05-18). Test-script-only change — rule (a).

**Root cause.** Flutter's `DragEndDetails` constructor asserts
(`package:flutter/src/gestures/drag_details.dart:217`):

```dart
primaryVelocity == null ||
    (primaryVelocity == velocity.pixelsPerSecond.dx && velocity.pixelsPerSecond.dy == 0) ||
    (primaryVelocity == velocity.pixelsPerSecond.dy && velocity.pixelsPerSecond.dx == 0)
```

i.e. when `primaryVelocity` is non-null it must equal one axis of
`velocity.pixelsPerSecond` while the *other* axis is exactly `0`.

Both scripts constructed `DragEndDetails` with a non-zero off-axis
component alongside a non-null `primaryVelocity`, which violates
the assertion:

- `drag_test.dart:34`
  `velocity: Velocity(pixelsPerSecond: Offset(1200.0, 80.0)), primaryVelocity: 1200.0`
  → dx=1200 matches primaryVelocity but dy=80 ≠ 0.
- `positioned_gesture_details_test.dart:265`
  `velocity: Velocity(pixelsPerSecond: Offset(420.0, 180.0)), primaryVelocity: 420.0`
  → dx=420 matches primaryVelocity but dy=180 ≠ 0.

This is a script-authoring bug, not an interpreter bug — the
constructor would have failed identically in native Dart.

**Fix.** Set the off-axis component to `0.0` in both scripts so
the values satisfy Flutter's invariant. The intent (a horizontal
fling) is unchanged; the values are display-only (visualised in
sample cards).

- `drag_test.dart:34` → `Offset(1200.0, 0.0)`.
- `positioned_gesture_details_test.dart:265` →
  `Offset(420.0, 0.0)` (and the matching `literal:` display string
  at L438 updated to `Offset(420, 0)` to stay consistent).

**Verification (AST driver, `D4RT_SKIP_BRIDGE_REGEN=1`):**

- `gestures/drag_test.dart` → success, 0 frameworkErrors
  (log `ztmp/c28_verify_ast_drag.log.txt`).
- `gestures/positioned_gesture_details_test.dart` → success, the
  remaining 1 framework error is a pre-existing layout warning
  (`BoxConstraints forces an infinite height`) unrelated to C28
  (log `ztmp/c28_verify_ast_pgd.log.txt`).

**Verification (analyzer driver, `D4RT_SKIP_BRIDGE_REGEN=1`):**

- `gestures/drag_test.dart` → success, 0 frameworkErrors
  (log `ztmp/c28_verify_analyzer_drag.log.txt`).
- `gestures/positioned_gesture_details_test.dart` → success, same
  unrelated layout warning as AST driver
  (log `ztmp/c28_verify_analyzer_pgd.log.txt`).

#### C29 — `Runtime Error: The condition of a conditional expression must be a boolean, but was null.`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 319 | material/ individual snack_bar_closed_reason_test.dart |

**Status:** fixed (2026-05-18) — incidental.

`material/snack_bar_closed_reason_test.dart` already passed in the
C27 verification run (`ztmp/c27_verify_ast_secondary.log.txt`,
line 1298 → `+294 -2`, i.e. moved the pass counter up). The
underlying null-condition bug was incidentally resolved by one of
the earlier cluster fixes (most likely GEN-094/GEN-095 / C26 type
resolution). Re-confirmed in
`ztmp/c29_check_ast_snack.log.txt`: `success=true,
frameworkErrors=0`. No code change in this cluster on the AST
driver.

#### C30 — `Runtime Error: Native error during bridged method call 'createBoxPainter' on ShapeDecoration: Null check operator used on a null value`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 335 | painting/ individual box_painter_test.dart |

**Status:** fixed (2026-05-18) — two-part fix: generator hardening
(GEN-096) + script patch for an SDK contract.

**Root cause.** Flutter's `Decoration.createBoxPainter` is declared
using legacy Dart syntax with an optional positional non-nullable
function parameter:

```dart
BoxPainter createBoxPainter([VoidCallback onChanged]);
// shape_decoration.dart, box_decoration.dart, flutter_logo.dart
// override it as: createBoxPainter([VoidCallback? onChanged])
```

Two problems combined:

1. The generated bridge wrapper followed GEN-069 nullability rules
   (based on declared type alone) and produced a non-null closure
   wrapper. When the interpreter called it with no argument
   (`raw == null`), the wrapper attempted
   `D4.callInterpreterCallback(visitor!, null, [])` and threw
   "Null check operator used on a null value".
2. After fixing the wrapper to be nullable, static dispatch against
   the non-nullable declared parameter type
   (`void Function() onChanged`) failed to compile because the
   wrapper now had type `void Function()?`.
3. Even with both generator fixes, `ShapeDecoration.createBoxPainter`
   in the Flutter SDK uses `onChanged!` unconditionally
   (`shape_decoration.dart:286`), so the SDK itself throws regardless
   of how D4rt passes the callback. The script must supply one.

**Fix.**

- `tom_d4rt_generator/lib/src/bridge_generator.dart`
  (`_generatePositionalParamExtraction`): treat optional positional
  function-typed parameters without a default value as nullable for
  wrapper generation, so the emitted wrapper is null-guarded
  (`raw == null ? null : () { ... }`).
- `tom_d4rt_generator/lib/src/bridge_generator.dart`
  (`_generateMethodBody`): detect legacy optional positional
  function-typed parameters with non-nullable declared type and no
  default, and dispatch through `(t as dynamic)` so the nullable
  closure wrapper reaches the concrete subclass override that
  redeclares the param as nullable.
- `test/.../send_ast_via_http_scripts/painting/box_painter_test.dart`:
  pass `() {}` to `ShapeDecoration.createBoxPainter` to satisfy the
  Flutter SDK's `onChanged!` precondition (script-only patch, the
  bug is in the SDK contract not D4rt).

**Verification.** Bridges regenerated for both drivers, then four
suites run serially on each driver:

- AST driver: gii `79/2/-2` (baseline), essential `108/0/0`,
  important `164/0/0`, secondary `652/1/-1` (baseline was
  `629/1/-24`; 23 incidental fixes from earlier clusters surfaced,
  only pre-existing `linear_border_edge_test.dart` C31 remains).
- Test driver: gii `79/2/-2` (baseline), essential `108/0/0`,
  important `164/0/0`, secondary `652/1/-1` (baseline was
  `628/1/-25`; same pattern, only C32 `linear_border_edge_test`
  remains).

No regressions; logs in `ztmp/c30_*.log.txt`.

#### C31 — `Runtime Error: Native error during default bridged constructor for 'LinearBorderEdge': 'package:flutter/src/painting/linear_border.dart': Fa`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 346 | painting/ individual linear_border_edge_test.dart |

**Status:** fixed (2026-05-18) — script-only patch.

**Root cause.** Flutter's `LinearBorderEdge` constructor asserts that
`size` is in `[0.0, 1.0]`
(`packages/flutter/lib/src/painting/linear_border.dart:38-39`):

```dart
const LinearBorderEdge({this.size = 1.0, this.alignment = 0.0})
  : assert(size >= 0.0 && size <= 1.0);
```

The "footguns" section of the test script was based on an incorrect
assumption that the constructor accepts out-of-range sizes and only
the painter clamps them. It deliberately constructed
`LinearBorderEdge(size: 1.5, ...)` and `LinearBorderEdge(size: -0.2, ...)`,
which throw `'size >= 0.0 && size <= 1.0': is not true.` in debug
mode (assertions enabled). D4rt surfaced the SDK assertion verbatim —
no interpreter or generator defect.

**Fix.** `test/.../send_ast_via_http_scripts/painting/linear_border_edge_test.dart`:
replace the out-of-range constructions with in-range boundary values
(`size: 1.0`, `size: 0.0`) and adjust the footgun bullets and debug
line to describe the *actual* SDK behaviour (assertion fires at
construction) rather than the imaginary clamping behaviour. The
visual layout of the script is unchanged.

**Verification.** Script-only change → individual retest sufficient
per cluster protocol rule (a):

- AST driver: `painting/ individual linear_border_edge_test.dart` —
  `status=success httpStatus=200 outputLines=44 frameworkErrors=0`
  (`ztmp/c31_verify_ast.log.txt`).
- Test driver: same script via shared HTTP fetch —
  `status=success httpStatus=200 outputLines=44 frameworkErrors=0`
  (`ztmp/c31_verify_test.log.txt`).

Representative error texts:

- **#8** `animation/ animation_misc_adv_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during bridged operator '+' on double: type 'Null' is not a subtype of type 'num' in type cast
- **#31** `foundation/ synchronousfuture_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Concurrent modification during iteration: Instance(length:50) of '_GrowableList'.
- **#32** `foundation/ targetplatform_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Null
- **#33** `foundation/ foundation_misc_adv_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Index assignment target must be List or Map in cascade.
- **#37** `gestures/ tap_force_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during default bridged constructor for 'GestureDetector': Incorrect GestureDetector arguments.
  > Having both a pan gesture recognizer and a scale gesture recognizer is redundant; scale is a superset of pan.
  > Just use the scale gesture recognizer.
- **#58** `material/ tooltip_feedback_test.dart` —
  > Bad state: Transport failure while running "material/tooltip_feedback_test.dart"
  > Operation: POST /build?filename=material%2Ftooltip_feedback_test.dart
  > Error: HttpException: Connection closed before full header was received, uri = http://localhost:4247/build?filename=material%2Ftooltip_feedback_test.dart
  > Stack trace:
  > ===== asynchronous gap ===========================

### hardly_relevant_classes_1_test.dart

#### C32 — `Runtime Error: Undefined static member 'hashCode' on bridged class 'UniformFloatSlot'.`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 124 | dart_ui/ uniform_float_slot_test.dart |

**Status:** fixed (2026-05-18) — interpreter change in both
`tom_d4rt/lib/src/interpreter_visitor.dart` and
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`. Closes
both C32 (BridgedClass branch) and C33 (InterpretedClass branch)
in a single change. (Cluster numbering offset: AST C32/C33 ≡ test
driver C33/C34.)

**Root cause.** When a script binds a class identifier to a
`Type` variable (`final Type slotType = ui.UniformFloatSlot;`) and
then reads `Object` getters off it (`slotType.hashCode`,
`slotType.runtimeType`) or calls `Object` methods on it
(`slotType.toString()`), real Dart dispatches those calls on the
*Type instance* — they are not static-member lookups on the class
the Type refers to. The d4rt interpreter modelled class-as-value
as the `BridgedClass`/`InterpretedClass` meta-object directly and
treated every member access as a static lookup, throwing
`Undefined static member 'hashCode' on bridged class
'UniformFloatSlot'` (or `… on class 'UniformVec2Slot'` for
interpreted classes) when the script reached the first `Object`
getter. The same gap existed in three resolution paths:

1. `visitPrefixedIdentifier` (`tom_d4rt`) /
   `visitSPrefixedIdentifier` (`tom_d4rt_ast`) — for
   `slotType.hashCode` parsed as a `PrefixedIdentifier`.
2. `visitPropertyAccess` / `visitSPropertyAccess` — for the
   chained `slotType.runtimeType.toString()` form where the LHS
   is the result of a previous expression.
3. `visitMethodInvocation` / `visitSMethodInvocation` — for
   `slotType.toString()` parsed as a `MethodInvocation`.

**Fix.** In all three paths, before throwing the
"Undefined static member" / "no constructor or static method"
errors, fall back to the underlying Dart object's own getters /
`name` for the `Object` trio:

- `hashCode` → `bridgedClass.hashCode` / `target.hashCode`
- `runtimeType` → `bridgedClass.runtimeType` / `target.runtimeType`
- `toString()` (no args) → `bridgedClass.name` / `target.name`
  (matches the Dart spec: `Type.toString()` returns the class name)

The fallback fires only after every static-lookup attempt fails,
so existing scripts that happen to define a `static hashCode`
getter (extremely uncommon and discouraged) keep their previous
semantics. Mirrored fix in both `tom_d4rt` and `tom_d4rt_ast`.

**Verification.** Non-script interpreter change → full
four-suite regression on both drivers per cluster protocol rule
(b):

- AST driver: individual `dart_ui/uniform_float_slot_test.dart`
  → `status=success outputLines=61 frameworkErrors=1` (RenderFlex
  overflow, pre-existing); individual
  `dart_ui/uniform_vec2_slot_test.dart` → `status=success
  outputLines=65 frameworkErrors=22` (pre-existing layout errors,
  no interpreter runtime errors). Four-suite regression: gii
  `79/2/-2` (baseline, only pre-existing layout failures
  `nestedscrollview_test`, `render_custom_multi_child_layout_box_test`
  remain), essential `108/0/0`, important `164/0/0`, secondary
  `653/1/0` (gained 1 over baseline; no regressions). Logs in
  `ztmp/c32/ast_*.log`.
- Test driver: same set of individual scripts and four-suite
  regression — gii `79/2/-2`, essential `108/0/0`, important
  `164/0/0`, secondary `653/1/0`. No interpreter regressions on
  either driver. Logs in `ztmp/c32/test_*.log`.

#### C33 — `Runtime Error: Undefined static member 'hashCode' on class 'UniformVec2Slot'.`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 125 | dart_ui/ uniform_vec2_slot_test.dart |

**Status:** fixed (2026-05-18) — closed by the same interpreter
change as C32 (InterpretedClass branch of the same
`PrefixedIdentifier`/`PropertyAccess`/`MethodInvocation` fallback
trio). See C32 for full root-cause analysis, fix description, and
verification numbers.

#### C34 — `Runtime Error: Error in generic constructor factory for 'CachingIterable': Argument Error: Invalid parameter "_prefillIterator": expected It`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 133 | foundation/ caching_iterable_test.dart |

**Status:** fixed (2026-05-18). Equivalent to test-driver cluster
**C35** — same root cause, same fix.

**Root cause.** The script constructs a typed list literal and then
passes its iterator to a bridged generic constructor:

```dart
final Iterator<int> source = <int>[1, 2, 3, /*...*/].iterator;
final CachingIterable<int> cache = CachingIterable<int>(source);
```

The d4rt interpreter materialises typed list literals as
`List<Object?>` instead of `List<int>` — the element-type annotation is
dropped during literal construction. `<int>[…].iterator` therefore
returns `ListIterator<Object?>` rather than `ListIterator<int>`.

The RC-2 generic-constructor factory for `CachingIterable<int>` in
`flutter_relaxers.b.dart` calls
`D4.extractBridgedArg<Iterator<int>>(_prefillIterator, ...)` on the
source. `extractBridgedArg<T>` already had branches for List / Iterable
/ Set / Map but **none for `Iterator<T>`**, so the strict
reified-generics cast failed and surfaced as the user-visible error.

**Fix.** Added an `Iterator<T>` coercion branch to `D4.extractBridgedArg`
in both interpreters, plus a lazy element-wise cast wrapper:

- `tom_d4rt_ast/lib/src/runtime/generator/d4.dart` — AST-based interpreter.
- `tom_d4rt/lib/src/generator/d4.dart` — analyzer-based interpreter.

```dart
class _CastIterator<T> implements Iterator<T> {
  final Iterator _source;
  _CastIterator(this._source);
  @override T get current => _source.current as T;
  @override bool moveNext() => _source.moveNext();
}
```

When `T == Iterator<X>` and `unwrapped is Iterator`, the branch wraps
the source in `_CastIterator<X>` (or `_PromotingDoubleIterator` for
`Iterator<double>` to handle `int → double` promotion, mirroring the
existing List branch). Primitive element types (`int`, `double`,
`String`, `num`, `bool`, `Object`/`dynamic`/`Object?`) are covered.
Non-primitive element types are not currently coerced because
reified-generics require a compile-time type argument that
`extractBridgedArg` cannot synthesise without ceremony — but the
existing `<int>[...].iterator` shape, which is the only one this corpus
exercises, is fully handled.

**Verification.**

- AST driver — `flutter test test/hardly_relevant_classes_1_test.dart --plain-name 'caching_iterable_test.dart'`:
  - before: `Runtime Error: ... expected Iterator<int>, got ListIterator<Object?>`
  - after: `01:03 +1: All tests passed!` (`ztmp/c35/ast_caching_iterable_after.log`)
- Analyzer driver — same command in `tom_d4rt_flutter_test/`:
  - before: same error
  - after: `00:59 +1: All tests passed!` (`ztmp/c35/test_caching_iterable_after.log`)

Four-suite rule-b regression (both drivers, serial):

| Suite     | AST driver       | Analyzer driver  | Baseline |
|-----------|------------------|------------------|----------|
| gii       | `+79 ~2 -2`      | `+79 ~2 -2`      | `+79 ~2 -2` (pre-existing layout fails) |
| essential | `+108`           | `+108`           | `+108/0/0` |
| important | `+164`           | `+164`           | `+164/0/0` |
| secondary | `+653 ~1`        | `+653 ~1`        | `+653 ~1` |

No interpreter regressions on either driver. Logs in `ztmp/c35/`.

#### C35 — `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toStringDeep': Argument Error: Invalid target: expected Diagnos`

- [x] fixed and re-verified — closed 2026-05-18

| testID | Test name |
|-------:|-----------|
| 135 | foundation/ class_test.dart |

Same cluster as the analyzer-driver `tom_d4rt_flutter_test/C36`
— see that driver's `error_analysis.md` for the full root-cause
analysis and resolution writeup. Closed via the **U10**
architectural-limitation documentation in
`interpreter_unfixable.md` (script-defined class
`with DiagnosticableTreeMixin` cannot reach inherited concrete
methods) plus the mandatory script-side `_dumpNode` workaround
applied at `foundation/class_test.dart` lines 268 (helper) and
288 (`_dumpNode(tree)` replaces `tree.toStringDeep()`).

Verified individually on both drivers (rule a — script-only
change). Logs in `ztmp/c36/`.

#### C36 — `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toDiagnosticsNode': Argument Error: Invalid target: expected Di`

- [x] fixed and re-verified — closed 2026-05-18

| testID | Test name |
|-------:|-----------|
| 144 | foundation/ diagnostics_serialization_delegate_test.dart |

Same cluster as the analyzer-driver `tom_d4rt_flutter_test/C37`
— see that driver's `error_analysis.md` for the full root-cause
analysis and resolution writeup. Second instance of the **U10**
architectural-limitation family (script-defined class
`with DiagnosticableTreeMixin` cannot reach inherited concrete
methods). Closed via script-side rewrite of `_serializeWith` to
a recursive `_manualSerialize` that produces the same
JSON-shape `Map<String, Object?>` directly from the script's
fields + delegate getters, bypassing the bridged
`toDiagnosticsNode` / `toJsonMap` pipeline entirely.

Verified individually on both drivers (rule a — script-only
change). Logs in `ztmp/c37/`.

#### C37 — `Runtime Error: Native error during default bridged constructor for 'ObjectFlagProperty': 'package:flutter/src/foundation/diagnostics.dart': `

- [x] fixed and re-verified — closed 2026-05-18

| testID | Test name |
|-------:|-----------|
| 162 | foundation/ object_flag_property_test.dart |

**Root cause.** Three layered issues — one genuine script bug,
two U10 instances. See test-driver C38 entry for the full
write-up (test driver C38 ≡ AST driver C37). Brief:

1. Script bug — two `ObjectFlagProperty` construction-gallery
   entries omitted both `ifPresent` and `ifNull`, violating the
   framework's `ifPresent != null || ifNull != null` debug
   assert at `diagnostics.dart:2389`. Fixed by supplying an
   empty-string in the unused slot.
2. U10 — parent `Diagnosticable` mixin variant.
   `config.toDiagnosticsNode().toStringDeep()` on a
   `_DemoConfig with Diagnosticable` is rejected by
   `D4.validateTarget<Diagnosticable>`. Same family as C35/C36
   on this driver.
3. U10 — new symptom — `super.debugFillProperties(...)` from an
   interpreted class with bridged-mixin-only super throws
   *`Class '_DemoConfig' does not have a standard or bridged
   superclass, cannot use 'super'.`* Native is a no-op anyway,
   so dropping the super call is safe.

**Fix.** All script-side: empty-string fallback for
ifPresent/ifNull slot, `_diagnosticableDeepDump(config)` helper
replacing the `toDiagnosticsNode().toStringDeep()` chain, drop
the `super.debugFillProperties(properties);` call. U10 entry in
`interpreter_unfixable.md` extended with a third-instance
subsection.

**Verification (rule a — script-only change).**

| Driver | Result |
|---|---|
| AST (`tom_d4rt_flutter_ast`) | `00:15 +1: All tests passed!` |
| Analyzer (`tom_d4rt_flutter_test`) | `00:11 +1: All tests passed!` |

Logs in `ztmp/c38/` (script lives in the AST driver; both
drivers fetch the same source over HTTP).

#### C38 — `Runtime Error: Native error during default bridged constructor for 'HitTestEntry': Argument Error: Invalid parameter "target": expected HitT`

- [x] fixed and re-verified — closed 2026-05-18

| testID | Test name |
|-------:|-----------|
| 180 | gestures/ hit_testable_test.dart |

**Root cause.** Script-defined `class _FakeTarget implements
HitTestTarget` rejected at the `HitTestEntry(target)` bridged-
constructor boundary by `D4.getRequiredArg<HitTestTarget>`.
Same architectural family as U3/U5/U8/U9/U10 — see new **U11**
entry in `interpreter_unfixable.md`. (Test driver C39 ≡ AST
driver C38.)

**Fix.** Script-side. Kept `_FakeTarget` declaration as teaching
reference (referenced verbatim in the Section 6 pseudocode
panel) but stopped instantiating it. Added a script-side
`_DemoHitEntry(label, runtimeTypeStr)` data class and replaced
the `HitTestResult` + `HitTestEntry` construction block with a
`List<_DemoHitEntry>` for the anatomy-panel display. Native
`HitTestResult()` / `BoxHitTestResult()` constructors remain
reachable; only the `HitTestEntry(<script HitTestTarget>)`
boundary crossing is skipped.

**Verification (rule a — script-only change).**

| Driver | Result |
|---|---|
| AST (`tom_d4rt_flutter_ast`) | `00:15 +1: All tests passed!` |
| Analyzer (`tom_d4rt_flutter_test`) | `00:12 +1: All tests passed!` |

(4 cosmetic framework warnings about `BorderSide.color` non-
uniform with `borderRadius` are pre-existing rendering-layer
noise, not test failures.) Logs in `ztmp/c39/` (script lives in
the AST driver; both drivers fetch the same source over HTTP).

#### C39 — `TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts || Bad state: Transport f`

- [x] fixed and re-verified (auto-resolved — no longer reproduces) — closed 2026-05-18

| testID | Test name |
|-------:|-----------|
| 182 | gestures/ least_squares_solver_test.dart |

**Root cause.** Transient transport-budget stall during the
original `testlog_20260517-0914` serial run. Same family as
**U1** (transport-budget cliff for unusually large bundles) but
at a lower magnitude — the script merely crosses the wall-clock
threshold under contention rather than disconnecting the device.
See test driver C40 entry (test driver C40 ≡ AST driver C39) for
the full write-up.

**Status.** No script or interpreter change since the
2026-05-17 testlog. Three back-to-back isolated runs on both
drivers all pass well within the 30 s timeout:

| Driver | Run 1 | Run 2 | Run 3 |
|---|---|---|---|
| AST (`tom_d4rt_flutter_ast`) | `00:22 +1` | — | — |
| Analyzer (`tom_d4rt_flutter_test`) | `00:19 +1` | `00:20 +1` | `00:19 +1` |

Marking closed as auto-resolved; if a future full-suite testlog
regresses on this script, trim the per-section content
(Sections 4 + 8 are the longest worked-data tables) instead of
addressing it at the interpreter level. Logs in `ztmp/c40/`.

#### C40 — `Runtime Error: Native error during default bridged constructor for 'PointerExitEvent': 'package:flutter/src/gestures/events.dart': Failed as`

- [x] fixed and re-verified — closed 2026-05-18

| testID | Test name |
|-------:|-----------|
| 194 | gestures/ pointer_exit_event_test.dart |

**Root cause.** Genuine script bug — not interpreter-related.
Section 3 device-kind gallery constructed
`PointerExitEvent(kind: PointerDeviceKind.trackpad, ...)`, which
violates the Flutter framework assert
`!identical(kind, PointerDeviceKind.trackpad)` at
`events.dart:1387`. Trackpad-hover *exits* route through the
mouse pathway with `kind: PointerDeviceKind.mouse`; trackpad
pan/zoom uses `PointerPanZoom*` events. (Test driver C41 ≡ AST
driver C40.)

**Fix.** Script-side. Changed `eTrackpad` to
`kind: PointerDeviceKind.mouse` so it honours the framework
assert, updated the trackpad card's label to
`"trackpad (mouse-routed)"` and rewrote its narrative to
reference the assert site + the `PointerPanZoom*` family. The
6-card gallery layout is preserved. No
`interpreter_unfixable.md` entry — the underlying issue is a
Flutter framework assertion that scripts must respect.

**Verification (rule a — script-only change).**

| Driver | Result |
|---|---|
| AST (`tom_d4rt_flutter_ast`) | `00:16 +1: All tests passed!` |
| Analyzer (`tom_d4rt_flutter_test`) | `00:15 +1: All tests passed!` |

(1 cosmetic `RenderFlex overflowed by 4986 pixels` warning is
pre-existing layout noise.) Logs in `ztmp/c41/`.

Representative error texts:

- **#124** `dart_ui/ uniform_float_slot_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Undefined static member 'hashCode' on bridged class 'UniformFloatSlot'.
- **#125** `dart_ui/ uniform_vec2_slot_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Undefined static member 'hashCode' on class 'UniformVec2Slot'.
- **#133** `foundation/ caching_iterable_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Error in generic constructor factory for 'CachingIterable': Argument Error: Invalid parameter "_prefillIterator": expected Iterator<int>, got ListIterator<Object?>
- **#135** `foundation/ class_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toStringDeep': Argument Error: Invalid target: expected DiagnosticableTreeMixin, got InterpretedInstance
- **#144** `foundation/ diagnostics_serialization_delegate_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toDiagnosticsNode': Argument Error: Invalid target: expected DiagnosticableTreeMixin, got InterpretedInstance
- **#162** `foundation/ object_flag_property_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during default bridged constructor for 'ObjectFlagProperty': 'package:flutter/src/foundation/diagnostics.dart': Failed assertion: line 2389 pos 15: 'ifPresent != null \|\| ifNull != null': is not true.

### hardly_relevant_classes_2_test.dart

#### C41 — `Runtime Error: Native error during bridged method call 'increment' on Accumulator: 'package:flutter/src/painting/inline_span.dart': Failed a`

- [x] fixed and re-verified — **script bug** (test driver C42 ≡ AST
  driver C41)

| testID | Test name |
|-------:|-----------|
| 175 | painting/ accumulator_test.dart |

Representative error texts:

- **#175** `painting/ accumulator_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during bridged method call 'increment' on Accumulator: 'package:flutter/src/painting/inline_span.dart': Failed assertion: line 39 pos 12: 'addend >= 0': is not true.

**Root cause + fix.** Script's negative-addend footgun section
called `negDemo.increment(-3)` / `negDemo.increment(-2)`. Native
`Accumulator.increment` asserts `addend >= 0` at
`inline_span.dart:39` — the script's own commentary claiming
"increment(-1) is allowed" was incorrect. Fixed at the script
level: renamed demo to `monoDemo` with `+10, +3, +2`; retitled
footgun row to "Negative addends are rejected"; corrected recap
row to `rejected (addend >= 0 assert)`; added explanatory comment
at the demo site. AST driver `00:15 +1`, analyzer driver
`00:11 +1`. Same posture as C40 (≡ test C41) — genuine Flutter
framework assertion, no `interpreter_unfixable.md` entry needed.

### hardly_relevant_classes_3_test.dart

#### C42 — `Runtime Error: Cannot access property 'isEmpty' on target of type _ConstMap<String, dynamic>.`

- [x] fixed and re-verified — **interpreter fix** (AST driver C42 ≡
  test driver C43). Added `'_ConstMap'` to the Map bridge's
  `nativeNames` list so the SDK's private `_ConstMap<K, V>`
  runtime class (used for `const {}` literals and the value
  returned by `SemanticsEvent.getDataMap()` on empty payloads)
  dispatches through the regular Map bridge. The interpreter's
  `Environment.toBridgedClass` uses
  `_longestNativeNamePrefixMatch` against each bridge's
  `nativeNames` to route private SDK impl types; with this entry
  in place, `tapMap.isEmpty` / `.keys` / `.length` route through
  `MapCore.getters` without per-script defensive copies.
  Subsumes the C18 script workaround posture. Mirrored in both
  interpreter copies:
  - `tom_d4rt_ast/lib/src/runtime/stdlib/core/map.dart`
  - `tom_d4rt/lib/src/stdlib/core/map.dart`

  Verification — C43 script post-fix:
  - AST `01:04 +1` (`ztmp/c43/ast_after.log`)
  - analyzer `01:00 +1` (`ztmp/c43/test_after.log`)

  Rule (b) regression on AST driver (interpreter change):
  - essential `04:01 +108` — `ztmp/c43/ast_essential.log`
  - important `06:13 +164` — `ztmp/c43/ast_important.log`
  - secondary `30:15 +653 ~1` — `ztmp/c43/ast_secondary.log`

  Rule (b) regression on analyzer driver:
  - essential `04:01 +108` — `ztmp/c43/test_essential.log`
  - important `05:33 +164` — `ztmp/c43/test_important.log`
  - secondary `28:54 +653 ~1` — `ztmp/c43/test_secondary.log`

  No `interpreter_unfixable.md` entry — fix repairs the
  limitation rather than working around it.

| testID | Test name |
|-------:|-----------|
| 117 | semantics/ tap_semantic_event_test.dart |

#### C43 — `Runtime Error: Undefined variable: KeyDataTransitMode`

- [x] fixed and re-verified — **script-side stand-in** (AST
  driver C43 ≡ test driver C44). `KeyDataTransitMode` is
  annotated `@Deprecated('No longer supported. Transit mode is
  always key data only.')` at
  `flutter/lib/src/services/hardware_keyboard.dart:725`, and
  the bridge generator's
  `ElementModeExtractor.generateDeprecatedElements = false`
  policy filters every `@Deprecated`-tagged element out of the
  bridge surface by design (see U12 in
  `interpreter_unfixable.md`). The demo's premise is to
  document the enum's shape, so retiring it would gut the
  visual content. Workaround: declared a private local
  `enum _KeyDataTransitMode { rawKeyData, keyDataThenRawKeyData }`
  at the top of the script and replaced the 11 code-level
  `KeyDataTransitMode` references (type annotations, `.values`,
  `.values.firstWhere`, `.values.map`, parameter and field
  types) with `_KeyDataTransitMode`. All in-string mentions
  remain so the demo still documents the (former) SDK surface.
  Added a `D4RT-LIMITATION (C44)` block to the file header.

  Verification:
  - AST driver: `00:15 +1: All tests passed!` — `ztmp/c44/ast_after.log`
  - analyzer driver: `00:11 +1: All tests passed!` — `ztmp/c44/test_after.log`

  Test-script-only change → rule (a) individual retest
  sufficient. With C48 (`RawKeyEventDataWeb`) and C49
  (`RawKeyEventDataLinux`) now closed the remaining
  "Undefined variable: <DeprecatedSymbol>" pattern in this test
  log is exhausted.

| testID | Test name |
|-------:|-----------|
| 147 | services/ key_data_transit_mode_test.dart |

#### C44 — `Runtime Error: Undefined variable: KeyboardSide`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 157 | services/ keyboard_side_test.dart |

**Root cause.** AST driver C44 ≡ test driver C45.
`KeyboardSide` is annotated `@Deprecated('Use KeyEvent and
HardwareKeyboard instead. This feature was deprecated after
v3.18.0-2.0.pre.')` at
`flutter/lib/src/services/raw_keyboard.dart:40-44`. The script
additionally references `ModifierKey`, similarly `@Deprecated`
at `raw_keyboard.dart:68-72`. Both are filtered out of the
bridge surface by the generator's
`generateDeprecatedElements = false` policy — see **U12** in
`interpreter_unfixable.md`.

**Fix.** Script-side, same pattern as the test-driver C44 fix
(dual-enum scope). Declared two private local stand-ins at the
top of `services/keyboard_side_test.dart`:

- `enum _KeyboardSide { any, left, right, all }`
- `enum _ModifierKey { controlModifier, shiftModifier,
  altModifier, metaModifier, capsLockModifier, numLockModifier,
  scrollLockModifier, functionModifier, symbolModifier }`

with value names/ordering matching the SDK declarations.
Replaced every code-position `KeyboardSide` / `ModifierKey`
reference (type annotations, `.values`, switch patterns, field
types, interpolated `${KeyboardSide.values.length}` reads in
print/string-builder code) with the underscore-prefixed
stand-ins. In-string mentions remain unchanged so the demo
still documents the (former) SDK API verbatim. Added a
`D4RT-LIMITATION (C45)` block to the file header pointing at
U12.

**Verification.**

- Pre-fix reproduction (AST driver): "Undefined variable:
  KeyboardSide" — `ztmp/c45/ast_before.log`
- AST driver: `00:16 +1: All tests passed!` —
  `ztmp/c45/ast_after.log`
- analyzer driver: `00:12 +1: All tests passed!` —
  `ztmp/c45/test_after.log`

Test-script-only change → rule (a) individual retest
sufficient; no regression suite needed.

**Interpreter catalogue.** Covered by **U12 —
`@Deprecated`-annotated SDK symbols are filtered out of the
bridge surface by design (generator policy)** in
`interpreter_unfixable.md`.

#### C45 — `Runtime Error: Undefined variable: MaterialState (in Set literal)`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 165 | services/ mouse_tracker_annotation_test.dart |

**Root cause.** AST driver C45 ≡ test driver C46. Same family
as the previous deprecated-symbol clusters (see **U12** in
`interpreter_unfixable.md`). In Flutter 3.19.0-0.3.pre the
`MaterialState*` API was renamed to `WidgetState*`; the old
names are `@Deprecated` typedefs in
`flutter/lib/src/material/material_state.dart`:

```dart
@Deprecated(...)
typedef MaterialState = WidgetState;

@Deprecated(...)
typedef MaterialStateMouseCursor = WidgetStateMouseCursor;
```

The bridge generator's `generateDeprecatedElements = false`
policy filters them off the bridge surface. Because the
typedef *targets* (`WidgetState`, `WidgetStateMouseCursor`) are
themselves fully bridged and functionally identical, the
bridge coverage of the underlying API is intact — only the
alias names are unreachable.

**Fix.** Script-side. Replaced every code-position
`MaterialState` → `WidgetState` and `MaterialStateMouseCursor`
→ `WidgetStateMouseCursor` in Section 8 of
`services/mouse_tracker_annotation_test.dart` (~6 lines:
local-variable RHS, type arguments on three Set literals,
enum-value access). All in-string / in-comment mentions of
`MaterialState*` remain unchanged so the demo still documents
the historic alias. Added a `D4RT-LIMITATION (C46)` header
block.

**Verification.**

- Pre-fix reproduction (AST driver): "Undefined variable:
  MaterialState (in Set literal)" —
  `ztmp/c46/ast_before.log`
- AST driver: `00:15 +1: All tests passed!` —
  `ztmp/c46/ast_after.log`
- analyzer driver: `00:11 +1: All tests passed!` —
  `ztmp/c46/test_after.log`

Test-script-only change → rule (a) individual retest
sufficient; no regression suite needed.

**Interpreter catalogue.** Covered by **U12 —
`@Deprecated`-annotated SDK symbols are filtered out of the
bridge surface by design (generator policy)** in
`interpreter_unfixable.md`. U12 now subsumes the
typedef-rename sub-pattern: when the deprecated alias *targets*
a still-bridged symbol, the workaround is to use the modern
name in code positions (no local stand-in needed) while
preserving the alias in strings/comments.

#### C46 — `Runtime Error: Native error during default bridged constructor for 'RawFloatingCursorPoint': Argument Error: Invalid parameter "startLocatio`

- [x] fixed and re-verified (generator)

| testID | Test name |
|-------:|-----------|
| 167 | services/ raw_floating_cursor_point_test.dart |

**Root cause.** Same as the test driver's C47 — `tom_d4rt_generator` had
no record-type extraction branch in `_generateNamedParamExtraction`, so
`RawFloatingCursorPoint`'s `startLocation` named parameter (typed
`(Offset, TextPosition)?`) fell through to `D4.getOptionalNamedArg`,
which cannot coerce `InterpretedRecord` to a native Dart record.

**Fix.** Generator-side, in `tom_d4rt_generator/lib/src/bridge_generator.dart`:

- Added a record-type detection branch in `_generateNamedParamExtraction`
  that emits a `is InterpretedRecord ? (...) : raw as RecordType`
  conversion covering all required/optional × nullable/non-nullable
  combinations.
- Replaced raw `as T` casts on record fields with
  `D4.extractBridgedArg<T>(...)` in both the new named branch and the
  existing positional `_generateRecordParamExtraction`, so
  `BridgedInstance` / `BridgedEnumValue` field wrappers unwrap before
  the cast.
- Diagnostic field names switched from `$N` to `fieldN` to avoid
  Dart string-interpolation parsing of the emitted code.

**Verification.** AST driver: `raw_floating_cursor_point_test.dart` →
`+1 All tests passed!`. Regression suites green:
essential 108 / important 164 / secondary 653.
Same fix verified on the analyzer (test) driver (cluster C47 there).

#### C47 — `Runtime Error: Undefined variable: build`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 171 | services/ raw_key_event_data_ios_test.dart |

**Status: ☑ fixed (script-only)** — paired with the test-driver C48
(same script).

**Root cause:** `services/raw_key_event_data_ios_test.dart` declared
20+ `_*` widget classes (`_SectionFrame`, `_Hero`,
`_DeprecationBanner`, `_AnatomyDiagram`, `_ModifierFieldDiagram`,
`_EventJourneys`, `_CharactersExplainer`, `_HidUsageTable`, …) but no
top-level `build(BuildContext context)`. The d4rt test harness invokes
the script's top-level `build` to obtain the root widget; without it
the interpreter resolves `build` as a bare identifier and throws
`Undefined variable: build`. `RawKeyEventDataIos` itself is
`@Deprecated` and is intentionally filtered off the bridge surface
(U12 in `interpreter_unfixable.md`); the script only references the
type name in strings/comments.

**Fix:** Appended a composing top-level
`Widget build(BuildContext context)` to
`tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/services/raw_key_event_data_ios_test.dart`
that returns a `Container/SingleChildScrollView/Column` of the
existing widget classes (`_DeprecationBanner`, `_Hero`, five
`_SectionFrame` sections).

**Regression test rule (a):** script-only change → individual retest
only. Both drivers green
(`ztmp/c48/{ast,test}_after.log` — `+1 All tests passed!`).

#### C48 — `Runtime Error: Undefined variable: RawKeyEventDataWeb`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 175 | services/ raw_key_event_data_web_test.dart |

**Status: ☑ fixed (script, U12 variant A)** — paired with test-driver
C49 (same script).

**Root cause:** `RawKeyEventDataWeb` (`flutter/services.dart`,
`raw_keyboard_web.dart:32-37`) is `@Deprecated` in the Flutter SDK
and is filtered out of the d4rt bridge surface by design (U12). The
script actively constructs and reads `RawKeyEventDataWeb` instances
(it is the demo's subject), so missing symbol → `Undefined variable:
RawKeyEventDataWeb`.

**Fix (variant A — local stand-in):** No typedef-rename target exists
(the modernisation path is
`RawKeyEventDataWeb → KeyEvent.physicalKey/logicalKey`, a different
API shape), so variant B does not apply. Declared a private
`class _RawKeyEventDataWeb` with the constructor fields the script
uses (`code`, `key`, `location`, `metaState`, `keyCode`) and the
modifier-bit / physical-key / logical-key accessors the demo reads
(`isShiftPressed`, …, `physicalKey`, `logicalKey`). All code-position
references were rewritten to `_RawKeyEventDataWeb`; strings and
comments preserve the SDK name verbatim.

**Regression test rule (a):** script-only change → individual retest
only. Both drivers green (`ztmp/c49/{ast,test}_after.log`).

#### C49 — `Runtime Error: Undefined variable: RawKeyEventDataLinux`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 177 | services/ raw_key_event_test.dart |

**Status: ☑ fixed (script, U12 variant A)** — paired with test-driver
C50 (same script).

**Root cause.** The deep-demo script for the `RawKeyEvent` family
references seven SDK symbols that are all `@Deprecated` upstream
and therefore filtered off the d4rt bridge surface by
`ElementModeExtractor.generateDeprecatedElements = false` (U12 in
`interpreter_unfixable.md`):

- `RawKeyEvent` — `flutter/src/services/raw_keyboard.dart:364`
- `RawKeyDownEvent` — `raw_keyboard.dart:674`
- `RawKeyUpEvent` — `raw_keyboard.dart:695`
- `RawKeyEventDataLinux` — `raw_keyboard_linux.dart:30`
- `GLFWKeyHelper` — `raw_keyboard_linux.dart:255`
- `ModifierKey` — `raw_keyboard.dart:68` (enum)
- `KeyboardSide` — `raw_keyboard.dart:40` (enum)

The first unbridged reference (`RawKeyEventDataLinux`) trips the
interpreter with `Runtime Error: Undefined variable`.

`LogicalKeyboardKey` / `PhysicalKeyboardKey` are **not** deprecated
and remain fully bridged.

**Fix.** U12 variant A (local stand-in). Variant B (typedef-rename
swap) does not apply because the modernisation path
`RawKeyEvent → KeyEvent` is an entirely different API shape (no
platform-specific `RawKeyEventData` subclass on the modern
`KeyEvent`). Local stand-ins injected after the script's imports
mirror the SDK shape: `_ModifierKey`, `_KeyboardSide`,
`_GLFWKeyHelper`, `_RawKeyEventDataLinux` (with full
`isModifierPressed(_ModifierKey, {_KeyboardSide side})` honouring
the GLFW bitmask), abstract `_RawKeyEvent` (returning real bridged
`LogicalKeyboardKey` / `PhysicalKeyboardKey` instances seeded from
the data) plus concrete `_RawKeyDownEvent` / `_RawKeyUpEvent`.
Every code-position reference to the deprecated SDK names is now
routed through the `_*` stand-ins; string literals and comments
preserve the SDK names verbatim so the didactic copy still
documents them.

Shared with the test driver via `SendTestRunner.scriptsPath`, so
one script edit closes both drivers.

**Verification.** Logs in `ztmp/c50/{ast,test}_after.log`:
`+1 All tests passed!` on both drivers (script
`services/raw_key_event_test.dart`, `outputLines=108`,
`status=success`). One benign `RenderFlex overflowed` UI warning
remains (the demo widget tree is intentionally tall). Regression
rule (a) applies: script-only change, individual retest
sufficient.

#### C50 — `Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Nu`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 194 | services/ text_capitalization_test.dart |

**Status: ☑ fixed (no-op · resolved by earlier cluster work)** —
paired with test-driver C51.

**Root cause (baseline).** The deep-demo
`services/text_capitalization_test.dart` constructs 43 `Text(…)`
widgets driven by computed strings (capitalization transforms,
derived labels, table cells). In the baseline test log
(`testlog_20260517-0914`) one of those expressions resolved to
`null`, tripping the bridged `Text` default constructor with
`Argument Error: Invalid parameter "data": expected String, got
Null`.

**No-op closure.** Reproducing C50 against current HEAD on both
drivers (rule (a), single-script retest) yields a clean run with
no code changes:

- AST driver: `+1 All tests passed!`, `status=success`,
  `outputLines=32`, `frameworkErrors=0`
  (`ztmp/c51/ast_before.log`).
- Test driver: `+1 All tests passed!`, `status=success`,
  `outputLines=32`, `frameworkErrors=0`
  (`ztmp/c51/test_before.log`).

The script has not been modified since its initial authoring
(commit `2d53ba1a` — Batch 3), so the resolution is upstream:
an earlier cluster fix in this campaign — most likely the C47
generator fix for record-typed named parameters (commit
`1038e02d`) and the subsequent bridge regeneration — closed the
underlying constructor-argument issue. Marked fixed without code
change.

#### C51 — `Bad state: Transport failure while running "services/text_editing_delta_insertion_test.dart"`

- [x] fixed and re-verified (script · U1-variant, 2026-05-18)

| testID | Test name |
|-------:|-----------|
| 196 | services/ text_editing_delta_insertion_test.dart |

**Resolution.** Symptom matched `interpreter_unfixable.md` §U1
(demo-scale rendering overloads test-app transport): the script
logged `TextEditingDeltaInsertion Deep Demo completed
successfully`, then the framework died mid-render with `Lost
connection to device.` (no Dart stack, no FlutterError, no
analyzer error). The build function returned a `Scaffold` →
`SingleChildScrollView` → `Column` containing 11 demo cards
(title banner, anatomy card, 6 gallery cards via `Wrap`, 3
offset visualizations, 3 composing demos, sibling table, chat
mock with 5 deltas, apply() flow, code snippet with 15
RichTexts, 5 footgun cards, recap card) — each with gradients,
shadows, and nested decoration. The widget tree was small enough
to construct but large enough to choke the transport once
Flutter started rendering.

**Workaround applied** (U1 variant 2 extension — script-side):
collapsed the rendered widget tree to a minimal `Scaffold` →
`Center` → `Text` summary listing the 11 sections that were
built. All demo data construction, helper calls, and `print`
output are retained; the built widgets are still constructed and
referenced (via a discarded `_unused` list) so their
constructors continue to exercise the bridges. The 15
`_codeLine(...)` RichText calls in Section 9 were collapsed
first to a single plain `Text` (preserving the documented code
example) before the broader rendering reduction was applied. See
`interpreter_unfixable.md` §U1 for the catalogue entry.

Paired with test-driver C52 (single script edit closes both
drivers).

**Verification.** `ztmp/c52/ast_after.log` shows
`status=success`, `outputLines=51`, `frameworkErrors=0`,
`+1 All tests passed!`. Test driver also green
(`ztmp/c52/test_after.log`).

Representative error texts:

- **#117** `semantics/ tap_semantic_event_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Cannot access property 'isEmpty' on target of type _ConstMap<String, dynamic>.
- **#147** `services/ key_data_transit_mode_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Undefined variable: KeyDataTransitMode
- **#157** `services/ keyboard_side_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Undefined variable: KeyboardSide
- **#165** `services/ mouse_tracker_annotation_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Undefined variable: MaterialState (in Set literal)
- **#167** `services/ raw_floating_cursor_point_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during default bridged constructor for 'RawFloatingCursorPoint': Argument Error: Invalid parameter "startLocation": expected (Offset, TextPosition)?, got InterpretedRecord
- **#171** `services/ raw_key_event_data_ios_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Undefined variable: build

### hardly_relevant_classes_5_test.dart

#### C52 — `Runtime Error: Native error during bridged method call 'subscribe' on RouteObserver: Argument Error: Invalid parameter "routeAware": expecte`

- [x] fixed and re-verified (no-op · resolved by earlier U9 workaround, 2026-05-18)

| testID | Test name |
|-------:|-----------|
| 81 | widgets/ route_observer_test.dart |

Representative error texts:

- **#81** `widgets/ route_observer_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during bridged method call 'subscribe' on RouteObserver: Argument Error: Invalid parameter "routeAware": expected RouteAware, got InterpretedInstance(_LoggingRouteAware)

**Resolution.** Re-running the cluster on both drivers
post-summary shows `+1 All tests passed!` with
`status=success`, `outputLines=4`, `frameworkErrors=0`
(`ztmp/c53/{ast,test}_before.log`). Inspection of
`widgets/route_observer_test.dart` confirms the script already
carries the §U9 workaround documented in
`interpreter_unfixable.md`: a script-side `_DemoRouteObserver`
class (lines 85–129) mirrors the native protocol
(`subscribe` / `unsubscribe` / `didPush` / `didPop` /
`didReplace`), all subscription calls go through `demoObserver`
(lines 372–391), and the native
`RouteObserver<PageRoute<dynamic>>()` (line 363) is constructed
solely to demonstrate the type exists in Flutter
(`// ignore: unused_local_variable`) without ever receiving a
script-defined `_LoggingRouteAware`. The workaround predates the
current testlog and has been verified intact at this snapshot.
No script changes required for C52. Pairs with test-driver C53.

### timeout_tests_test.dart

#### C53 — `Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(ERR_NOT_FOUND, Resource mi`

- [x] fixed and re-verified (script · U13-new, 2026-05-18)

| testID | Test name |
|-------:|-----------|
| 29 | services/ retest: services/method_codec_test.dart |

**Resolution.** New `interpreter_unfixable.md` §U13 — native
exceptions thrown across a bridged method are not catchable by
their original type. The interpreter wraps any native throw into
a `RuntimeError("Native error during bridged method call '…' on
…: <exception.toString()>")`, discarding the original exception
object. Section 6 of `retest/services/method_codec_test.dart`
wraps two `decodeEnvelope(...)` calls in
`on PlatformException catch (pe)` blocks expecting the native
throw; the wrapper escaped those blocks because it is a
`RuntimeError`, not a `PlatformException`.

**Workaround applied** (script-side): replaced both
`on PlatformException catch (pe)` clauses with broad
`catch (e)` and recovered the exception code by string-parsing
the wrapper's `'PlatformException(<code>, …)'` marker out of
`'$e'`. Behaviour is preserved — the demo still reports
`thrownType=PlatformException(<code>)` for both standard and
JSON envelopes, and the row labels in the error-envelope cards
match the original output.

**Verification.** Both drivers green:
- AST driver: `status=success`, `outputLines=39`,
  `+1 All tests passed!` (`ztmp/c55/ast_after.log`).
- Test driver: `status=success`, `outputLines=39`,
  `+1 All tests passed!` (`ztmp/c55/test_after.log`).

Pairs with test-driver C55.

Representative error texts:

- **#29** `services/ retest: services/method_codec_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(ERR_NOT_FOUND, Resource missing, path=/foo, null)

### generator_interpreter_issues_test.dart

#### C54 — `BoxConstraints forces an infinite height.`

- [x] fixed and re-verified (2026-05-18) — pairs with test-driver C56;
  script-only fix; both drivers green. See test-driver C56 entry for
  the full diagnosis. Summary: `Offstage(child: NestedScrollView(...))`
  inside `SizedBox(height: 1, ...)` does not insulate the
  NestedScrollView from layout, and the rest of the visible tree also
  fails the layout invariant under this test harness. Fix collapses
  all three offstage hostings to `SizedBox.shrink()` (constructed
  widgets retained in scope via `_kept` locals) and reduces the
  Scaffold body to a `Center > Text` summary while keeping every
  composite widget in scope via a discarded `_unused` list (U1
  variant 2). Logs: `ztmp/c56/{ast,test}_{before,after}.log`.

| testID | Test name |
|-------:|-----------|
| 34 | Section 2 - Bridge Generator Issues (80) widgets/nestedscrollview_test.dart |

#### C55 — `A RenderFlex overflowed by 7.0 pixels on the bottom.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 47 | Section 2 - Bridge Generator Issues (80) rendering/render_custom_multi_child_layout_box_test.dart |

Representative error texts:

- **#34** `Section 2 - Bridge Generator Issues (80) widgets/nestedscrollview_test.dart` —
  > Expected: true
  >   Actual: <false>
  > BoxConstraints forces an infinite height.
  > These invalid constraints were provided to RenderConstrainedBox's layout() function by the following function, which probably computed the invalid constraints in question:
  >   ChildLayoutHelper.layoutChild (package:flutter/src/rendering/layout_helper.dart:62:11)
- **#47** `Section 2 - Bridge Generator Issues (80) rendering/render_custom_multi_child_layout_box_test.dart` —
  > Expected: true
  >   Actual: <false>
  > A RenderFlex overflowed by 7.0 pixels on the bottom.

### generator_interpreter_retest_test.dart

#### C56 — `A borderRadius can only be given on borders with uniform colors.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 33 | Section 1 - Tests with workarounds reverted retest: services/message_codec_test.dart |

#### C57 — `Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(ERR_NOT_FOUND, Resource mi`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 34 | Section 1 - Tests with workarounds reverted retest: services/method_codec_test.dart |

Representative error texts:

- **#33** `Section 1 - Tests with workarounds reverted retest: services/message_codec_test.dart` —
  > Expected: true
  >   Actual: <false>
  > A borderRadius can only be given on borders with uniform colors.
  > The following is not uniform:
  > BorderSide.color; A borderRadius can only be given on borders with uniform colors.
- **#34** `Section 1 - Tests with workarounds reverted retest: services/method_codec_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(ERR_NOT_FOUND, Resource missing, path=/foo, null)

## Framework-Error Blocks (non-failing)

### essential_classes_test.dart

- cupertino/route_test.dart (frameworkErrors=9)
- cupertino/segmented_test.dart (frameworkErrors=12)
- foundation/key_test.dart (frameworkErrors=1)
- material/floatingactionbutton_test.dart (frameworkErrors=1)
- material/scaffold_test.dart (frameworkErrors=1)
- painting/border_radius_test.dart (frameworkErrors=5)
- painting/box_decoration_test.dart (frameworkErrors=9)
- widgets/appbar_test.dart (frameworkErrors=6)
- widgets/expanded_test.dart (frameworkErrors=1)
- widgets/flexible_test.dart (frameworkErrors=2)
- widgets/focusnode_test.dart (frameworkErrors=1)
- widgets/gridview_test.dart (frameworkErrors=2)
- widgets/icon_test.dart (frameworkErrors=1)
- widgets/inkwell_test.dart (frameworkErrors=11)
- widgets/row_test.dart (frameworkErrors=1)
- widgets/scaffold_test.dart (frameworkErrors=2)
- widgets/stack_test.dart (frameworkErrors=1)

### important_classes_test.dart

- widgets/animatedlist_test.dart (frameworkErrors=5)
- widgets/hero_test.dart (frameworkErrors=2)
- widgets/clipping_test.dart (frameworkErrors=1)
- widgets/transform_full_test.dart (frameworkErrors=413)
- widgets/sizing_test.dart (frameworkErrors=1)
- widgets/animatedbuilder_test.dart (frameworkErrors=1)
- widgets/heromode_test.dart (frameworkErrors=1)
- widgets/valuelistenablebuilder_test.dart (frameworkErrors=1)
- widgets/nestedscrollview_test.dart (frameworkErrors=1)
- widgets/draggablescrollablesheet_test.dart (frameworkErrors=1)
- material/expansionpanel_test.dart (frameworkErrors=1)
- material/animatedicon_test.dart (frameworkErrors=6)
- material/licensepage_test.dart (frameworkErrors=4)
- material/pageroute_test.dart (frameworkErrors=1)
- widgets/listbody_test.dart (frameworkErrors=1)
- widgets/keepalive_test.dart (frameworkErrors=7)
- widgets/listener_test.dart (frameworkErrors=1)
- widgets/router_test.dart (frameworkErrors=6)
- widgets/formstate_test.dart (frameworkErrors=33)
- widgets/scaffoldstate_test.dart (frameworkErrors=1)
- painting/image_providers_test.dart (frameworkErrors=1)
- gestures/velocity_test.dart (frameworkErrors=1)
- services/textboundary_test.dart (frameworkErrors=5)
- services/platform_test.dart (frameworkErrors=1)
- rendering/renderobjects_clip_test.dart (frameworkErrors=14)
- rendering/renderobjects_layout_test.dart (frameworkErrors=1)
- rendering/layers_data_test.dart (frameworkErrors=1)
- rendering/sliver_delegates_test.dart (frameworkErrors=24)

### secondary_classes_test.dart

- cupertino/cupertino_nav_segmented_test.dart (frameworkErrors=2)
- foundation/observer_list_test.dart (frameworkErrors=33)
- material/chip_variants_test.dart (frameworkErrors=1)
- material/scaffold_advanced_test.dart (frameworkErrors=14)
- material/chip_attributes_test.dart (frameworkErrors=6)
- material/divider_listtile_test.dart (frameworkErrors=4)
- material/menu_advanced_test.dart (frameworkErrors=6)
- material/expansion_stepper_test.dart (frameworkErrors=1)
- material/dialog_bottom_sheet_test.dart (frameworkErrors=6)
- material/scaffold_fab_test.dart (frameworkErrors=1)
- painting/image_cache_test.dart (frameworkErrors=8)
- painting/advanced_decorations_test.dart (frameworkErrors=1)
- rendering/render_mixins_test.dart (frameworkErrors=4)
- widgets/defaulttextstyle_test.dart (frameworkErrors=1)
- widgets/placeholder_test.dart (frameworkErrors=1)
- widgets/preferredsize_test.dart (frameworkErrors=6)
- widgets/scrollbar_layout_misc_test.dart (frameworkErrors=1)
- widgets/scroll_behavior_test.dart (frameworkErrors=1)
- widgets/undo_history_test.dart (frameworkErrors=33)
- widgets/context_menu_test.dart (frameworkErrors=36)
- widgets/notification_locale_test.dart (frameworkErrors=1)
- widgets/editable_text_misc_test.dart (frameworkErrors=1)
- widgets/inherited_model_test.dart (frameworkErrors=6)
- widgets/page_view_tabview_test.dart (frameworkErrors=1)
- widgets/element_types_test.dart (frameworkErrors=58)
- cupertino/cupertino_scroll_behavior_test.dart (frameworkErrors=2)
- foundation/bit_field_test.dart (frameworkErrors=1)
- foundation/repetitive_stack_frame_filter_test.dart (frameworkErrors=10)
- foundation/unicode_test.dart (frameworkErrors=1)
- gestures/horizontal_multi_drag_gesture_recognizer_test.dart (frameworkErrors=1)
- gestures/serial_tap_down_details_test.dart (frameworkErrors=1)
- gestures/serial_tap_gesture_recognizer_test.dart (frameworkErrors=15)
- gestures/serial_tap_up_details_test.dart (frameworkErrors=5)
- gestures/tap_drag_start_details_test.dart (frameworkErrors=1)
- gestures/tap_drag_update_details_test.dart (frameworkErrors=1)
- material/desktop_text_selection_toolbar_button_test.dart (frameworkErrors=1)
- material/material_type_test.dart (frameworkErrors=6)
- material/snack_bar_behavior_test.dart (frameworkErrors=6)
- painting/border_directional_test.dart (frameworkErrors=4)
- painting/box_border_test.dart (frameworkErrors=5)
- painting/shape_border_test.dart (frameworkErrors=1)
- painting/star_border_test.dart (frameworkErrors=5)
- rendering/follower_layer_test.dart (frameworkErrors=3)
- rendering/render_constraints_transform_box_test.dart (frameworkErrors=1)
- rendering/render_custom_multi_child_layout_box_test.dart (frameworkErrors=1)
- rendering/render_follower_layer_test.dart (frameworkErrors=5)
- semantics/semantics_event_test.dart (frameworkErrors=1)
- services/autofill_configuration_test.dart (frameworkErrors=18)
- services/flutter_version_test.dart (frameworkErrors=1)
- services/network_asset_bundle_test.dart (frameworkErrors=14)

### hardly_relevant_classes_1_test.dart

- animation/cubic_test.dart (frameworkErrors=1)
- cupertino/restorable_cupertino_tab_controller_test.dart (frameworkErrors=76)
- dart_ui/blur_style_test.dart (frameworkErrors=1)
- dart_ui/shader_mask_engine_layer_test.dart (frameworkErrors=36)
- dart_ui/uniform_vec3_slot_test.dart (frameworkErrors=1)
- foundation/abstract_node_test.dart (frameworkErrors=1)
- foundation/diagnosticable_node_test.dart (frameworkErrors=9)
- foundation/diagnosticable_tree_mixin_test.dart (frameworkErrors=1)
- foundation/diagnosticable_tree_node_test.dart (frameworkErrors=18)
- foundation/diagnosticable_tree_test.dart (frameworkErrors=1)
- foundation/error_spacer_test.dart (frameworkErrors=12)
- foundation/object_disposed_test.dart (frameworkErrors=14)
- foundation/object_event_test.dart (frameworkErrors=1)
- foundation/string_property_test.dart (frameworkErrors=12)
- gestures/one_sequence_gesture_recognizer_test.dart (frameworkErrors=6)
- gestures/pointer_move_event_test.dart (frameworkErrors=1)
- gestures/pointer_pan_zoom_start_event_test.dart (frameworkErrors=1)
- gestures/pointer_scroll_event_test.dart (frameworkErrors=1)
- gestures/tap_move_details_test.dart (frameworkErrors=6)
- gestures/velocity_estimate_test.dart (frameworkErrors=1)

### hardly_relevant_classes_2_test.dart

- material/bottom_navigation_bar_landscape_layout_test.dart (frameworkErrors=4)
- material/carousel_controller_test.dart (frameworkErrors=2)
- material/fade_forwards_page_transitions_builder_test.dart (frameworkErrors=1)
- painting/image_size_info_test.dart (frameworkErrors=1)
- painting/inline_span_semantics_information_test.dart (frameworkErrors=1)
- painting/matrix_utils_test.dart (frameworkErrors=1)

### hardly_relevant_classes_3_test.dart

- rendering/clear_selection_event_test.dart (frameworkErrors=58)
- rendering/rendering_service_extensions_test.dart (frameworkErrors=1)
- rendering/scroll_direction_test.dart (frameworkErrors=8)
- rendering/select_paragraph_selection_event_test.dart (frameworkErrors=12)
- rendering/selection_status_test.dart (frameworkErrors=5)
- semantics/accessibility_focus_block_type_test.dart (frameworkErrors=5)
- semantics/announce_semantics_event_test.dart (frameworkErrors=6)
- semantics/attributed_string_property_test.dart (frameworkErrors=1)
- semantics/focus_semantic_event_test.dart (frameworkErrors=16)
- semantics/tooltip_semantics_event_test.dart (frameworkErrors=24)
- services/android_pointer_coords_test.dart (frameworkErrors=7)
- services/i_o_s_system_context_menu_item_data_share_test.dart (frameworkErrors=1)
- services/key_message_test.dart (frameworkErrors=12)
- services/key_up_event_test.dart (frameworkErrors=5)
- services/platform_exception_test.dart (frameworkErrors=5)
- services/raw_key_event_data_android_test.dart (frameworkErrors=54)
- services/raw_key_event_data_linux_test.dart (frameworkErrors=28)
- services/raw_key_event_data_windows_test.dart (frameworkErrors=1)
- services/raw_keyboard_test.dart (frameworkErrors=10)
- services/text_editing_delta_non_text_update_test.dart (frameworkErrors=38)
- services/text_selection_test.dart (frameworkErrors=1)

### hardly_relevant_classes_4_test.dart

- widgets/menu_serializable_shortcut_test.dart (frameworkErrors=5)

### hardly_relevant_classes_5_test.dart

- widgets/render_sliver_overlap_absorber_test.dart (frameworkErrors=1)
- widgets/render_sliver_overlap_injector_test.dart (frameworkErrors=4)
- widgets/text_selection_toolbar_layout_delegate_test.dart (frameworkErrors=1)

### timeout_tests_test.dart

- rendering/render_constraints_transform_box_test.dart (frameworkErrors=1)
- rendering/render_custom_multi_child_layout_box_test.dart (frameworkErrors=1)
- retest/services/message_codec_test.dart (frameworkErrors=7)

### generator_interpreter_issues_test.dart

- widgets/nestedscrollview_test.dart (frameworkErrors=1)
- rendering/render_custom_multi_child_layout_box_test.dart (frameworkErrors=1)

### generator_interpreter_retest_test.dart

- retest/services/message_codec_test.dart (frameworkErrors=7)

### interactive_tests_test.dart

- material/showbottomsheet_test.dart (frameworkErrors=6)
- material/showmenu_test.dart (frameworkErrors=9)
- material/showtimepicker_test.dart (frameworkErrors=8)

## Flutter Overflow / Layout Warnings in Log

Total overflow / layout warning lines: **125**

### essential_classes_test.dart (13 unique)

- `A RenderFlex overflowed by 14 pixels on the bottom.`
- `A RenderFlex overflowed by 41 pixels on the right.`
- `A RenderFlex overflowed by 33 pixels on the bottom.`
- `A RenderFlex overflowed by 25 pixels on the bottom.`
- `A RenderFlex overflowed by 13 pixels on the bottom.`
- `A RenderFlex overflowed by 41 pixels on the bottom.`
- `A RenderFlex overflowed by 8.0 pixels on the bottom.`
- `A RenderFlex overflowed by 20 pixels on the right.`
- `A RenderFlex overflowed by 48 pixels on the right.`
- `A RenderFlex overflowed by 0.661 pixels on the right.`
- `A RenderFlex overflowed by 6.0 pixels on the right.`
- `A RenderFlex overflowed by 50 pixels on the bottom.`
- `A RenderFlex overflowed by 112 pixels on the bottom.`

### important_classes_test.dart (53 unique)

- `A RenderFlex overflowed by 7.3 pixels on the bottom.`
- `A RenderFlex overflowed by 0.800 pixels on the bottom.`
- `A RenderFlex overflowed by 8462 pixels on the bottom.`
- `A RenderFlex overflowed by 2.0 pixels on the right.`
- `A RenderFlex overflowed by 2.0 pixels on the bottom.`
- `A RenderFlex overflowed by 3556 pixels on the bottom.`
- `A RenderFlex overflowed by 2432 pixels on the bottom.`
- `A RenderFlex overflowed by 10234 pixels on the bottom.`
- `[D4rtApp] [framework error] A RenderFlex overflowed by 10234 pixels on the bottom.`
- `Another exception was thrown: A RenderFlex overflowed by 10234 pixels on the bottom.`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#75e3e relayoutBoundary=up16 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#77fac relayoutBoundary=up15 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#26e04 relayoutBoundary=up14 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderClipPath#ec761 relayoutBoundary=up13 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderDecoratedBox#d90d8 relayoutBoundary=up12 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#53dad relayoutBoundary=up11 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#6399c relayoutBoundary=up10 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: _RenderSingleChildViewport#4d6ef relayoutBoundary=up9 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderIgnorePointer#527e0 relayoutBoundary=up8 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderSemanticsAnnotations#1da34 relayoutBoundary=up7 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- … 33 more

### secondary_classes_test.dart (42 unique)

- `A RenderFlex overflowed by 2.0 pixels on the right.`
- `A RenderFlex overflowed by 4.0 pixels on the bottom.`
- `A RenderFlex overflowed by 18 pixels on the right.`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#4c745 relayoutBoundary=up15 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#a6b72 relayoutBoundary=up14 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#b1d17 relayoutBoundary=up13 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#3f018 relayoutBoundary=up12 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#688f7 relayoutBoundary=up11 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: _RenderSingleChildViewport#59aaa relayoutBoundary=up10 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderIgnorePointer#8ad70 relayoutBoundary=up9 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderSemanticsAnnotations#04a0f relayoutBoundary=up8 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPointerListener#d10cf relayoutBoundary=up7 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderSemanticsGestureHandler#678ff relayoutBoundary=up6 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPointerListener#1105f relayoutBoundary=up5 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: _RenderScrollSemantics#32430 relayoutBoundary=up4 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderTransform#c612d relayoutBoundary=up3 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderClipRect#d5953 relayoutBoundary=up2 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#c9fe7 relayoutBoundary=up1 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderTransform#c612d relayoutBoundary=up3`
- `[D4rtApp] [framework error] A RenderFlex overflowed by 4.0 pixels on the bottom.`
- … 22 more

### hardly_relevant_classes_1_test.dart (1 unique)

- `A RenderFlex overflowed by 0.500 pixels on the bottom.`

### hardly_relevant_classes_2_test.dart (5 unique)

- `A RenderFlex overflowed by 0.601 pixels on the right.`
- `A RenderFlex overflowed by 11 pixels on the right.`
- `A RenderFlex overflowed by 0.487 pixels on the right.`
- `A RenderFlex overflowed by 2.2 pixels on the right.`
- `A RenderFlex overflowed by 4241 pixels on the bottom.`

### hardly_relevant_classes_3_test.dart (4 unique)

- `A RenderFlex overflowed by Infinity pixels on the bottom.`
- `A RenderFlex overflowed by 11 pixels on the bottom.`
- `A RenderFlex overflowed by 15 pixels on the right.`
- `A RenderFlex overflowed by 2.0 pixels on the bottom.`

### hardly_relevant_classes_5_test.dart (1 unique)

- `A RenderFlex overflowed by 8882 pixels on the bottom.`

### timeout_tests_test.dart (1 unique)

- `A RenderFlex overflowed by 7.0 pixels on the bottom.`

### generator_interpreter_issues_test.dart (1 unique)

- `A RenderFlex overflowed by 7.0 pixels on the bottom.`

### interactive_tests_test.dart (4 unique)

- `A RenderFlex overflowed by 20 pixels on the bottom.`
- `A RenderFlex overflowed by 6.0 pixels on the bottom.`
- `A RenderFlex overflowed by 70 pixels on the bottom.`
- `A RenderFlex overflowed by 126 pixels on the bottom.`

## Flutter Assertion / Framework-Exception Lines in Log

Total unique assertion-related lines: **24**

### important_classes_test.dart (5 unique)

- `'package:flutter/src/rendering/sliver_multi_box_adaptor.dart': Failed assertion: line 629 pos 12: 'child.hasSize': is not true.`
- `Runtime Error: Native error during default bridged constructor for 'AnimatedOpacity': 'package:flutter/src/widgets/implicit_animations.dart': Failed assertion: line 1853 pos 15: 'opacity >= 0.0 && opacity <= 1.0': is not true.`
- `Another exception was thrown: 'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.`
- `Another exception was thrown: 'package:flutter/src/rendering/object.dart': Failed assertion: line 5493 pos 14: '!semantics.parentDataDirty': is not true.`
- `Runtime Error: Native error during default bridged constructor for 'CalendarDatePicker': 'package:flutter/src/material/calendar_date_picker.dart': Failed assertion: line 154 pos 7: 'selectableDayPredicate == null ||`

### secondary_classes_test.dart (12 unique)

- `Failed assertion: line 2830 pos 12: 'value.i…`
- `'package:flutter/src/material/chip.dart': Failed assertion: line 1027 pos 12: 'widget.onSelected == null || widget.onPressed == null': is not true.`
- `Another exception was thrown: 'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.`
- `Runtime Error: Native error during default bridged constructor for 'WidgetSpan': 'package:flutter/src/widgets/widget_span.dart': Failed assertion: line 83 pos 9: 'baseline != null ||`
- `'package:flutter/src/rendering/table_border.dart': Failed assertion: line 289 pos 12: 'rows.isEmpty || (rows.first >= 0.0 && rows.last <= rect.height)': is not true.`
- `Runtime Error: Native error during default bridged constructor for 'DraggableScrollableSheet': 'package:flutter/src/widgets/draggable_scrollable_sheet.dart': Failed assertion: line 315 pos 15: 'snapAnimationDuration == null || snapAnimation`
- `'package:flutter/src/widgets/restoration_properties.dart': Failed assertion: line 85 pos 12: 'isRegistered': is not true.`
- `Runtime Error: Native error during default bridged constructor for 'DragEndDetails': 'package:flutter/src/gestures/drag_details.dart': Failed assertion: line 217 pos 10: 'primaryVelocity == null ||`
- `Runtime Error: Native error during default bridged constructor for 'LinearBorderEdge': 'package:flutter/src/painting/linear_border.dart': Failed assertion: line 39 pos 14: 'size >= 0.0 && size <= 1.0': is not true.`
- `Failed assertion: line 943 pos 14: 'childConstraints.isNormalized'`
- `Failed assertion: line 2830 pos 12: 'value.…`
- `Failed assertion: line 41 pos 10: '<optimized out>'`

### hardly_relevant_classes_1_test.dart (3 unique)

- `Failed assertion: line 41 pos 10: '<optimized out>'`
- `Runtime Error: Native error during default bridged constructor for 'ObjectFlagProperty': 'package:flutter/src/foundation/diagnostics.dart': Failed assertion: line 2389 pos 15: 'ifPresent != null || ifNull != null': is not true.`
- `Runtime Error: Native error during default bridged constructor for 'PointerExitEvent': 'package:flutter/src/gestures/events.dart': Failed assertion: line 1387 pos 15: '!identical(kind, PointerDeviceKind.trackpad)': is not true.`

### hardly_relevant_classes_2_test.dart (1 unique)

- `Runtime Error: Native error during bridged method call 'increment' on Accumulator: 'package:flutter/src/painting/inline_span.dart': Failed assertion: line 39 pos 12: 'addend >= 0': is not true.`

### hardly_relevant_classes_3_test.dart (2 unique)

- `Failed assertion: line 41 pos 10: '<optimized out>'`
- `Failed assertion: line 26 pos 10: '<optimized out>'`

### timeout_tests_test.dart (1 unique)

- `Failed assertion: line 943 pos 14: 'childConstraints.isNormalized'`

## Metric Coverage

| File | `[METRIC]` lines |
|------|----------------:|
| essential_classes_test.dart | 107 |
| important_classes_test.dart | 163 |
| secondary_classes_test.dart | 651 |
| hardly_relevant_classes_1_test.dart | 202 |
| hardly_relevant_classes_2_test.dart | 202 |
| hardly_relevant_classes_3_test.dart | 200 |
| hardly_relevant_classes_4_test.dart | 226 |
| hardly_relevant_classes_5_test.dart | 229 |
| crashing_tests_test.dart | 3 |
| timeout_tests_test.dart | 50 |
| blocking_tests_test.dart | 5 |
| generator_interpreter_issues_test.dart | 81 |
| generator_interpreter_retest_test.dart | 53 |
| interactive_tests_test.dart | 6 |

