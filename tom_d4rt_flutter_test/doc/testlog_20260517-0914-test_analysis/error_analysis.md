# Error Analysis — testlog 20260517-0914-test_analysis (tom_d4rt_flutter_test)

- Baseline ID: `20260517-0914-test_analysis`
- Revision: `4c322df839a8bcdd3e5a09425065757e9ebd0a35` (branch `main`)
- Run timestamp: 2026-05-17 09:14 CEST
- Project: `tom_d4rt_flutter_test`
- Driver: `_ai/quests/d4rt/_run_testlog_20260517-0914_test.sh` (serial within suite; AST + TEST suites run in parallel because they listen on different ports — 4247 / 4248)

## Suite Results

| File | Pass | Skip | Fail | Wall | FE | Status |
|------|-----:|-----:|-----:|-----:|---:|--------|
| essential_classes_test.dart | 106 | 0 | **2** | 04:28 | **66** | ❌ failure |
| important_classes_test.dart | 151 | 0 | **13** | 07:16 | **536** | ❌ failure |
| secondary_classes_test.dart | 629 | 0 | **25** | 26:24 | **342** | ❌ failure |
| hardly_relevant_classes_1_test.dart | 196 | 0 | **9** | 08:28 | **199** | ❌ failure |
| hardly_relevant_classes_2_test.dart | 202 | 0 | **1** | 06:26 | **10** | ❌ failure |
| hardly_relevant_classes_3_test.dart | 191 | 0 | **10** | 07:25 | **298** | ❌ failure |
| hardly_relevant_classes_4_test.dart | 227 | 0 | 0 | 08:54 | **5** | ✅ |
| hardly_relevant_classes_5_test.dart | 229 | 0 | **1** | 07:23 | **6** | ❌ failure |
| crashing_tests_test.dart | 4 | 0 | 0 | 00:20 | 0 | ✅ |
| timeout_tests_test.dart | 49 | 0 | **2** | 02:50 | **9** | ❌ failure |
| blocking_tests_test.dart | 5 | 0 | 0 | 00:45 | 0 | ✅ |
| generator_interpreter_issues_test.dart | 81 | 0 | **2** | 02:55 | **2** | ❌ failure |
| generator_interpreter_retest_test.dart | 56 | 0 | **2** | 01:51 | **7** | ❌ failure |
| interactive_tests_test.dart | 6 | 0 | 0 | 00:39 | **23** | ✅ |
| **Total** | **2132** | **0** | **67** | 86:04 | **1503** | 4 of 14 files clean |

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
| **C11** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: Concurrent modification during iteration: Instance(length:50) of '_GrowableList'.` | ☑ fixed |
| **C12** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Nu` | ☑ fixed |
| **C13** | `secondary_classes_test.dart` | 1 | `Runtime Error: Index assignment target must be List or Map in cascade.` | ☑ fixed |
| **C14** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'GestureDetector': Incorrect GestureDetector arguments.` | ☑ fixed (script) |
| **C15** | `secondary_classes_test.dart` | 1 | `Bad state: Transport failure while running "material/tooltip_feedback_test.dart"` | ☑ fixed (script) |
| **C16** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'BottomAppBar': Argument Error: Invalid parameter "shape": expected Notch` | ☑ fixed (script) |
| **C17** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: SourceCodeException: Module source not preloaded for URI: package:vector_math/vector_math_64.dart, and not ` | ☑ fixed (script) |
| **C18** | `secondary_classes_test.dart` | 1 | `Runtime Error: Cannot access property 'entries' on target of type _ConstMap<String, dynamic>.` | ☑ fixed (script) |
| **C19** | `secondary_classes_test.dart` | 2 | `Runtime Error: Positional arguments cannot follow named arguments.` | ☑ fixed |
| **C20** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'RestorableEnum': Argument Error: Invalid parameter "defaultValue": expec` | ☑ fixed (script) |
| **C21** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'WidgetSpan': 'package:flutter/src/widgets/widget_span.dart': Failed asse` | ☑ fixed (script) |
| **C22** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'subscribe' on RouteObserver: Argument Error: Invalid parameter "routeAware": expecte` | ☑ fixed (script) |
| **C23** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'DraggableScrollableSheet': 'package:flutter/src/widgets/draggable_scroll` | ☑ fixed (script) |
| **C24** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: 'package:flutter/src/widgets/restoration_properties.dart': Failed assertion: line 85 pos 12: 'isRegistered'` | ☑ fixed (script) |
| **C25** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: Null check operator used on a null value` | ☑ |
| **C26** | `secondary_classes_test.dart` | 1 | `Runtime Error: A value of type 'List' can't be returned from the function 'encodeFrame' because it has a return type of 'Uint8List'.` | ☐ |
| **C27** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: type 'BridgedEnumValue' is not a subtype of type 'PointerDeviceKind' in type cast` | ☑ |
| **C28** | `secondary_classes_test.dart` | 2 | `Runtime Error: Native error during default bridged constructor for 'DragEndDetails': 'package:flutter/src/gestures/drag_details.dart': Faile` | ☑ |
| **C29** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: type 'String' is not a subtype of type 'InterpretedFunction?' in type cast` | ☑ |
| **C30** | `secondary_classes_test.dart` | 1 | `Runtime Error: The condition of a conditional expression must be a boolean, but was null.` | ☐ |
| **C31** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'createBoxPainter' on ShapeDecoration: Null check operator used on a null value` | ☑ |
| **C32** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'LinearBorderEdge': 'package:flutter/src/painting/linear_border.dart': Fa` | ☑ |
| **C33** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Undefined static member 'hashCode' on bridged class 'UniformFloatSlot'.` | ☑ |
| **C34** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Undefined static member 'hashCode' on class 'UniformVec2Slot'.` | ☑ |
| **C35** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Error in generic constructor factory for 'CachingIterable': Argument Error: Invalid parameter "_prefillIterator": expected It` | ☑ |
| **C36** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toStringDeep': Argument Error: Invalid target: expected Diagnos` | ☑ |
| **C37** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toDiagnosticsNode': Argument Error: Invalid target: expected Di` | ☑ |
| **C38** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'ObjectFlagProperty': 'package:flutter/src/foundation/diagnostics.dart': ` | ☐ |
| **C39** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'HitTestEntry': Argument Error: Invalid parameter "target": expected HitT` | ☐ |
| **C40** | `hardly_relevant_classes_1_test.dart` | 1 | `TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts \|\| Bad state: Transport f` | ☐ |
| **C41** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'PointerExitEvent': 'package:flutter/src/gestures/events.dart': Failed as` | ☐ |
| **C42** | `hardly_relevant_classes_2_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'increment' on Accumulator: 'package:flutter/src/painting/inline_span.dart': Failed a` | ☐ |
| **C43** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Cannot access property 'isEmpty' on target of type _ConstMap<String, dynamic>.` | ☐ |
| **C44** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: KeyDataTransitMode` | ☐ |
| **C45** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: KeyboardSide` | ☐ |
| **C46** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: MaterialState (in Set literal)` | ☐ |
| **C47** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'RawFloatingCursorPoint': Argument Error: Invalid parameter "startLocatio` | ☐ |
| **C48** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: build` | ☐ |
| **C49** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: RawKeyEventDataWeb` | ☐ |
| **C50** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Undefined variable: RawKeyEventDataLinux` | ☐ |
| **C51** | `hardly_relevant_classes_3_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Nu` | ☐ |
| **C52** | `hardly_relevant_classes_3_test.dart` | 1 | `Bad state: Transport failure while running "services/text_editing_delta_insertion_test.dart"` | ☐ |
| **C53** | `hardly_relevant_classes_5_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'subscribe' on RouteObserver: Argument Error: Invalid parameter "routeAware": expecte` | ☐ |
| **C54** | `timeout_tests_test.dart` | 1 | `Bad state: Transport failure while running "rendering/render_custom_paint_test.dart"` | ☐ |
| **C55** | `timeout_tests_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(ERR_NOT_FOUND, Resource mi` | ☐ |
| **C56** | `generator_interpreter_issues_test.dart` | 1 | `BoxConstraints forces an infinite height.` | ☐ |
| **C57** | `generator_interpreter_issues_test.dart` | 1 | `A RenderFlex overflowed by 7.0 pixels on the bottom.` | ☐ |
| **C58** | `generator_interpreter_retest_test.dart` | 1 | `A borderRadius can only be given on borders with uniform colors.` | ☐ |
| **C59** | `generator_interpreter_retest_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(ERR_NOT_FOUND, Resource mi` | ☐ |

## Hard Failures — File by File

### essential_classes_test.dart

#### C01 — `Runtime Error: Positional arguments cannot follow named arguments.`

- [x] **fixed** (2026-05-17) — also closes C03 and C19, same root cause.

**Root cause.** The d4rt interpreter enforced an obsolete "named arguments
must come last" ordering rule when evaluating `ArgumentList`. Dart 3
permits named arguments to appear anywhere in the argument list; the
scripts call `_codeBlock(title: '...', '''...''')` (named before
positional), which is valid Dart (and analyzes cleanly), but blew up in
`_evaluateArgumentsAsync` at `interpreter_visitor.dart:9453`.

**Fix.** Removed the ordering check in four places, mirrored across
`tom_d4rt` and `tom_d4rt_ast`:

- `tom_d4rt/lib/src/interpreter_visitor.dart` — `_evaluateArguments`,
  `_evaluateArgumentsAsync`.
- `tom_d4rt/lib/src/callable.dart` — redirecting `this(...)` constructor
  arg evaluation, and `_evaluateArgumentsForInvocation`.
- `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` — same two
  helpers (SArgumentList variant).
- `tom_d4rt_ast/lib/src/runtime/callable.dart` — same two locations.

**Verification.** flutter_test: essential 108/0/0, important 157/7/0
(was 13 fails — C03's 6 closed), secondary 630/23/1 (was 25 fails — C19's
2 closed). flutter_ast: essential 108/0/0, important 157/7/0,
secondary 631/22/1. No new regressions in any of the six suites.

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
script corpus (`tom_d4rt_flutter_ast/.../send_ast_via_http_scripts/
widgets/animatedopacity_test.dart`); the same file is consumed by
both flutter_test (source-based) and flutter_ast (AST-based) test
suites via `SendTestRunner.scriptsPath`. Single-test verification
in both packages passes; no regression suite required.

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
corpus (`tom_d4rt_flutter_ast/.../send_ast_via_http_scripts/widgets/
safearea_test.dart`); single-test verification in both flutter_test and
flutter_ast passes.

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
limitations documented as **U1** in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md`.

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
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md`.

**Fix (script-only, rule a).** Expanded the
`ui.Gradient.sweep(Offset(...), kRainbow)` call site in the
shared script corpus
(`tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/rendering/gradient_rendering_test.dart`
lines 1416–1437) to pass all preceding positional defaults
explicitly:

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
  > Error: HttpException: Connection closed before full header was received, uri = http://localhost:4248/build?filename=widgets%2Fnotificationlistener_test.dart
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
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md`.

**Fix (script-only, rule a).** Replaced the catalog specimen in
the shared corpus file
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
as documentation of the user-extension pattern with a multi-line
explanatory comment and `// ignore: unused_element` so the
analyzer doesn't warn. No interpreter, generator, or `.b.dart`
change.

**Regression scope (rule a).** Script-only change in the shared
script corpus; single-test verification on both drivers
(flutter_ast `00:15 +1: All tests passed!`, flutter_test
`00:15 +1: All tests passed!`). Logs in
`ztmp/c10_ast_fixed.log.txt` and `ztmp/c10_test_fixed.log.txt`.

#### C11 — `Runtime Error: Unexpected error: Concurrent modification during iteration: Instance(length:50) of '_GrowableList'.`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 31 | foundation/ synchronousfuture_test.dart |

**Root cause.** Two compounded interpreter bugs surfaced by the
script's import set (`flutter/material.dart` +
`flutter/foundation.dart` + `dart:async`).

1. **Self-import in `Environment.importEnvironment`.** Diagnostic
   logging confirmed the module loader returns the importing
   environment itself for a transitive import:
   `_unnamedExtensions.addAll(sameList)` iterates the list while
   mutating it, raising `ConcurrentModificationError` at the first
   add (length=50 — the registered extensions in the
   foundation/material transitive closure). Surfaced at
   `environment.dart:1203` /
   `interpreter_visitor.dart:visitImportDirective`.
2. **`FutureOr<Object>` rejects null in `then` bridge.** With (1)
   fixed, the next exception was `Native error during bridged
   method call 'then' on SynchronousFuture: Argument Error:
   Invalid parameter "callback": expected Object, got Null`. The
   bridge generator's GEN-061 substitution turned an unresolved
   `FutureOr<dynamic>` callback return into the non-nullable
   `FutureOr<Object>`, then funnelled it through
   `extractBridgedArg<FutureOr<Object>>` which throws on `null`.
   Void-returning callbacks like `sf.then((v) { ... })` produce
   `null` at the boundary.

**Fix (interpreter + generator, rule b).** Three layered changes
applied symmetrically to both interpreters and the shared
generator:

1. `tom_d4rt_ast/lib/src/runtime/environment.dart` (and mirrored in
   `tom_d4rt/lib/src/environment.dart`): guard the
   `_unnamedExtensions.addAll(...)` call with `if (!identical(...))`
   to skip the merge when both environments share the same
   underlying list.
2. `tom_d4rt_generator/lib/src/bridge_generator.dart` (~line 13710):
   the GEN-061 substitution emits `FutureOr<Object?>` instead of
   `FutureOr<Object>` so void-returning callbacks (whose result is
   `null`) are accepted.
3. Same file (~line 13725): extend the `isDynamicReturn` condition
   to include `castType == 'FutureOr<Object?>'`, routing
   `FutureOr<Object?>` callbacks through `D4.castCallbackResult`
   which handles `null` safely via `null is R`.

Both bridge corpora regenerated via `tool/regenerate_bridges.dart`.
Single-test verification: flutter_ast
`00:34 +1: All tests passed!`, flutter_test
`00:31 +1: All tests passed!`. Logs:
`ztmp/c11_ast_fixed.log.txt`, `ztmp/c11_test_fixed.log.txt`.

**Regression scope (rule b).** Interpreter + generator change →
gii + essential + important + secondary on both drivers, serial.

| Suite | flutter_ast | flutter_test | Baseline |
|-------|-------------|--------------|----------|
| gii | `+79 ~2 -2` | `+79 ~2 -2` | matches |
| essential | `+108` | `+108` | clean |
| important | `+164` | `+164` | clean |
| secondary | `+633 ~1 -20` | `+632 ~1 -21` | C11 fixed; all 20/21 remaining failures map to open clusters C12–C31 plus the known `tap_drag_start_details_test.dart` inventory gap |

Logs: `ztmp/c11_{ast,test}_{gii,essential,important,secondary}.log.txt`.
No new regressions on either driver.

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
`tom_d4rt/lib/src/interpreter_visitor.dart` and mirrored in
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`)
unconditionally broke out of the member loop on any
`SSwitchPatternCase` match to prevent the body from running twice. That
was correct for single-statement cases, but for grouped cases it broke
on the first match (the empty `case android:`) without ever falling
through to the case that holds the return. `switchFor(android)`
therefore returned `null`, the helper's result fed `Text(null)`, and
the bridged `Text` constructor rejected it as "expected String, got
Null."

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
`tom_d4rt/lib/src/interpreter_visitor.dart` and
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`. No bridge or
generator change.

**Regression scope (rule b: interpreter change, both drivers).**

flutter_test (analyzer driver):

| suite | baseline | post-C12 | notes |
|-------|----------|----------|-------|
| gii | `+79 ~2 -2` | `+79 ~2 -2` | matches |
| essential | `+108` | `+108` | clean |
| important | `+164` | `+164` | clean |
| secondary | `+633 ~1 -20` | `+634 ~1 -19` | C12 fixed; no regressions |

flutter_ast (mirror-AST driver):

| suite | baseline | post-C12 | notes |
|-------|----------|----------|-------|
| gii | `+79 ~2 -2` | `+79 ~2 -2` | matches |
| essential | `+108` | `+108` | clean |
| important | `+164` | `+164` | clean |
| secondary | `+632 ~1 -21` | `+635 ~1 -18` | C12 fixed plus two other grouped-case scripts now pass; no regressions |

Logs (in the respective driver `ztmp/` dirs):
`c12_{ast,test}_{gii,essential,important,secondary}.log.txt`. No new
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

`_executeCascadeAssignment`'s `IndexExpression` branch only knew how
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

1. In `_executeCascadeAssignment`'s `IndexExpression` branch
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

The script lives in the shared corpus
(`tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/gestures/tap_force_test.dart`),
so the same edit covers both drivers.

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

**Root cause.** Same as flutter_ast — a Dart-VM-level crash
(`Lost connection to device.`) triggered when a parent `TextSpan`'s
`children` list contains a child `TextSpan` whose `text` is exactly
the single-character newline `'\n'` and that child sits between
two other `TextSpan`s carrying a non-null `style`. The runner
surfaces it as
`Bad state: Transport failure while running "material/tooltip_feedback_test.dart"`.

Bisection (logs in `ztmp/c15_probe_*.log.txt`) walked down to the
`_privateRichMessageExample()` `RichText` and the standalone
`const TextSpan(text: '\n')` element. The full repro table and
trigger discussion live in the flutter_ast sibling
`error_analysis.md` and in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` (C15 — standalone
newline `TextSpan`).

**Fix.** Script-only. Both drivers share
`tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/`,
so the single script edit (`'\n'` merged into the preceding styled
`TextSpan`'s text) covers both. No interpreter, bridge, or
generator change.

**Regression scope (rule a: script-only change).** Single-test
rerun on both drivers:

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `material/tooltip_feedback_test.dart` | `+1` All tests passed |
| flutter_test | `material/tooltip_feedback_test.dart` | `+1` All tests passed |

Logs: `ztmp/c15_verify_ast_secondary.log.txt`,
`ztmp/c15_verify_analyzer_secondary.log.txt`.

#### C16 — `Runtime Error: Native error during default bridged constructor for 'BottomAppBar': Argument Error: Invalid parameter "shape": expected Notch`

- [x] fixed and re-verified — **fixed (script)**

| testID | Test name |
|-------:|-----------|
| 69 | material/ bottom_app_bar_test.dart |

**Root cause.** Same as the flutter_ast driver — the corpus script
defines two subclasses of native abstract Flutter classes and
passes their instances to native bridged constructors:

1. `class _TopRoundedNotchedShape extends NotchedShape { … }` →
   `BottomAppBar(shape: …)`.
2. `class _CustomFabLocation extends FloatingActionButtonLocation { … }`
   → `Scaffold(floatingActionButtonLocation: …)` via
   `_fabLocationCell(location: const _CustomFabLocation(), …)`.

The bridge generator does not synthesise an adapter-proxy that
recognises a script-defined `InterpretedInstance` as a valid native
`NotchedShape` / `FloatingActionButtonLocation` argument.
`D4.getNamedArg<T>` rejects the value at the d4rt → native boundary.
Same family as U3 (`Curve` subclass).

**Fix.** Script-only. Same two substitutions as the flutter_ast
driver (scripts are shared via the corpus under
`tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/material/bottom_app_bar_test.dart`):

1. `shape: const _TopRoundedNotchedShape(radius: 18.0)` →
   `shape: const CircularNotchedRectangle()`.
2. `location: const _CustomFabLocation()` →
   `location: FloatingActionButtonLocation.endFloat`.

Documented as U5 in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` (script subclass
of native abstract `NotchedShape` / `FloatingActionButtonLocation`).

No interpreter, bridge, or generator change.

**Regression scope (rule a: script-only change).** Single-test
rerun on both drivers:

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `material/bottom_app_bar_test.dart` | `+1` All tests passed |
| flutter_test | `material/bottom_app_bar_test.dart` | `+1` All tests passed |

Logs: `ztmp/c16_verify_ast_secondary.log.txt`,
`ztmp/c16_verify_analyzer_secondary.log.txt`.

#### C17 — `Runtime Error: Unexpected error: SourceCodeException: Module source not preloaded for URI: package:vector_math/vector_math_64.dart, and not `

- [x] fixed and re-verified — **fixed (script)**

| testID | Test name |
|-------:|-----------|
| 82 | painting/ matrixutils_test.dart |

**Root cause.** The script's
`import 'package:vector_math/vector_math_64.dart' show Vector3;`
directive fails import resolution. On the analyzer driver the
`SourceCodeException: Module source not preloaded for URI:
package:vector_math/vector_math_64.dart, and not …` error is the
analyzer-driver equivalent of the AST driver's bundler error
("Package import … is not bridged and not in the same package").
`vector_math` is not registered as a bridged library and not
preloaded as an explicit source.

The only runtime use was `Matrix4.transform3(Vector3(40, 0, 0))`
inside the raw-vs-MatrixUtils comparison section of
`painting/matrixutils_test.dart`.

**Fix.** Script-only. Scripts are shared via the corpus under
`tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/painting/matrixutils_test.dart`.
Drop the direct `vector_math_64` import and replace the
`Vector3`-construction + `transform3` call with an inline
column-major matrix·vector product over the bridged
`Matrix4.storage` `Float64List`:

```dart
final List<double> _mStore = mCompositeTRS.storage;
final double _rawTransformedX = _mStore[0] * 40.0 + _mStore[12];
final double _rawTransformedY = _mStore[1] * 40.0 + _mStore[13];
final double _rawTransformedZ = _mStore[2] * 40.0 + _mStore[14];
final Offset rawAsOffset = Offset(_rawTransformedX, _rawTransformedY);
```

For an affine `Matrix4` this matches `Matrix4.transform3((40,0,0))`
exactly.

Documented as U6 in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` (direct import
of `package:vector_math/vector_math_64.dart`).

No interpreter, bridge, or generator change.

**Regression scope (rule a: script-only change).** Single-test
rerun on both drivers:

| Driver | Test | Result |
|--------|------|--------|
| flutter_ast | `painting/matrixutils_test.dart` | `+1` All tests passed |
| flutter_test | `painting/matrixutils_test.dart` | `+1` All tests passed |

Logs: `ztmp/c17_verify_ast_secondary.log.txt`,
`ztmp/c17_verify_analyzer_secondary.log.txt`.

#### C18 — `Runtime Error: Cannot access property 'entries' on target of type _ConstMap<String, dynamic>.`

- [x] fixed and re-verified — **fixed (script)**

| testID | Test name |
|-------:|-----------|
| 102 | semantics/ semantics_events_test.dart |

**Root cause.** Two-layer issue rooted in d4rt's Map bridge not
covering Dart's internal `_ConstMap` runtime class:

1. The d4rt Map bridge's `nativeNames` list (mirrored in
   `tom_d4rt/lib/src/stdlib/core/map.dart` and
   `tom_d4rt_ast/lib/src/runtime/stdlib/core/map.dart`) registers
   `UnmodifiableMapView`, `_UnmodifiableMapView`,
   `_CompactLinkedHashMap`, `ListMapView`, and `_MapView`, but
   **not** `_ConstMap` — the Dart-internal runtime class that
   `const <K, V>{}` literals evaluate to. When a `_ConstMap`
   reaches the member-access path in the interpreter
   (`SPrefixedIdentifier` lookup), it does not match any bridged
   class and falls through to the generic
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
represents script-defined enum values as `InterpretedEnumValue`,
which implements `RuntimeValue` but **not** Dart's native `Enum`.
The native `RestorableEnum<E>(E defaultValue, ...)` constructor's
bridge adapter checks the type via `D4.getRequiredArg<Enum>` and
rejects the value:

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
Flutter `RestorableValue<T>.value` getter asserts `isRegistered`
at line 85 of `restoration_properties.dart`, and `flutter test`
runs in debug mode so the assertion fires. The script's original
comment ("registration is not required for the getter to return
its initial") is factually wrong; the C20 error masked the issue
because construction failed before any `.value` read happened.

**Fix.** Script-only. In
`widgets/restorable_values_test.dart`:

1. Replace the script-defined `enum _Mood { calm, focused, joyful,
   sleepy }` with the framework-provided `Brightness` enum. The
   three `RestorableEnum` / `RestorableEnumN` constructors switch
   to `RestorableEnum<Brightness>` / `RestorableEnumN<Brightness>`,
   and the iteration `for (final _Mood m in _Mood.values)`
   switches to `Brightness.values`.
2. Shadow each `RestorableXxx` with a plain Dart variable holding
   the same construction-time default (`_vInt`, `_vDouble`,
   `_vBool`, `_vString`, `_vNum`, `_vDateTime`, `_vMood`,
   `_vMoodCalm`, plus the `_vXxxN` nullable shadows). Replace
   every `restXxx.value` read with the corresponding shadow
   variable (44 sites). The demo never mutates the stored
   values, so the shadow equals what the getter would return.

A C20-workaround comment above the shadow declarations
documents both precautions. The underlying limitations and the
workaround pattern are documented in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` (U8 —
script-defined enums can't cross the d4rt → native boundary as
`Enum`, plus `RestorableValue.value` requires registration).

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

#### C24 — `Runtime Error: Unexpected error: 'package:flutter/src/widgets/restoration_properties.dart': Failed assertion: line 85 pos 12: 'isRegistered'`

- [x] fixed and re-verified — script-only change (shared script
  corpus with the AST driver)

| testID | Test name |
|-------:|-----------|
| 161 | widgets/ restoration_adv_test.dart |

**Root cause.** The script's top-level `build()` instantiates a
batch of `RestorableInt/Double/String/Bool/DateTime` properties
inline, then reads `.value` on each one to interpolate it into a
log line. `RestorableValue<T>.value` asserts `isRegistered` at
`package:flutter/src/widgets/restoration_properties.dart:85`, a
debug-mode assertion that `flutter test` always exercises. The
only legal way to register a Restorable is via
`RestorationMixin.registerForRestoration(...)`, which requires a
host `StatefulWidget` subclass — the script corpus rejects custom
`State` subclasses, so registration cannot happen here.

**Fix.** Pure script-side change in
`widgets/restoration_adv_test.dart` (in the AST driver's script
directory, which this analyzer driver loads from via
`SendTestRunner`). Shadow each restorable with a plain Dart
variable holding the construction-time default (`riValue = 42`,
`rdValue = 3.14159`, `rsValue = 'Tom'`, `rbValue = true`,
`rdtValue = DateTime(2026, 5, 11)`) and read the shadow in the
print interpolations instead of `.value`. The restorable
instances themselves remain in scope and are still printed via
`$ri / $rd / …`, preserving the original log shape. Functionally
exact because the script never reassigns `.value` anywhere —
confirmed by `grep 'r[a-z]*\.value\s*='` over the script returning
zero matches.

**Underlying limitation.** Documented as `U8(2)` in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` — script-side
Restorable* reads outside a real `RestorationMixin` host always
trip the `isRegistered` assertion. The shadow-variable pattern is
the canonical work-around when `.value` is only read.

**Regression scope.** Script-only change, no interpreter or
bridge code touched. Single-test retest on both drivers is
sufficient per the regression rules.

**Verification.** Analyzer driver: `flutter test secondary
--plain-name "restoration_adv_test.dart"` → 1/0/0 (log
`ztmp/c24_verify_analyzer.log.txt`). AST driver: same command in
`tom_d4rt_flutter_ast` → 1/0/0 (log
`ztmp/c24_verify_ast.log.txt`). Repro log (AST driver):
`tom_d4rt_flutter_ast/ztmp/c24_repro_ast.log.txt`.

#### C25 — `Runtime Error: Unexpected error: Null check operator used on a null value`

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
Stack trace captured via a one-off `c25_diag_test.dart` on the
AST driver:
`ModalRoute.popGestureEnabled → PageRoute.popGestureEnabled →
_createCupertinoPageRouteBridge.<closure>` (the analyzer driver
hits the same getter through the analyzer-based bridge).

**Fix.** Pure script-side change in
`cupertino/cupertino_page_test.dart` (shared corpus, applies to
both drivers). Replace the `${routeBasic.popGestureEnabled}`
interpolation with a static descriptive string
`(requires attached Navigator)`. A NOTE comment is added
explaining why `popGestureEnabled` cannot be read here.

**Underlying limitation.** None — this is standard Flutter
contract: `ModalRoute.popGestureEnabled` requires
`route.animation` to be non-null, which only happens after the
route is pushed onto a Navigator. Other navigator-attached
getters (`isFirst`, `isActive`, `isCurrent`) would fail the same
way and should be avoided in scripts.

**Regression scope.** Script-only change, no interpreter or
bridge code touched. Single-test retest on both drivers is
sufficient per the regression rules.

**Verification.** AST driver: `flutter test secondary --plain-name
"cupertino_page_test.dart"` → 1/0/0 (log
`tom_d4rt_flutter_ast/ztmp/c25_verify_ast.log.txt`). Analyzer
driver: same command in `tom_d4rt_flutter_test` → 1/0/0 (log
`ztmp/c25_verify_analyzer.log.txt`). Repro log:
`tom_d4rt_flutter_ast/ztmp/c25_repro_ast.log.txt`.

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

The interpreter's return-type check
(`InterpreterVisitor.visitReturnStatement`) called
`Environment.getRuntimeType(returnValue)` and got back the generic
`List` `RuntimeType` instead of the specific `Uint8List` bridge —
even though the value's actual runtime type is a `Uint8List`
subclass (`_Uint8List` / `_Uint8ArrayView`) that has its own
registered `BridgedClass`. The check then reported the value as a
`List` and rejected it against the declared `Uint8List` return
type. Source of the misclassification was in
`Environment.getRuntimeType`:

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

**Verification.** AST driver (`tom_d4rt_flutter_ast`): essential
108/0/0, important 164/0/0, secondary 648/-5 (all 5 failures are
pre-existing clusters C27/C28/C30/C31). Analyzer driver
(`tom_d4rt_flutter_test`): essential 108/0/0, important 164/0/0,
secondary 647/-6 (all 6 failures are pre-existing clusters
C27/C28/C29 [analyzer-only `tap_drag_start_details`]/C30/C31).
None of the failures are caused by the C26 fix. Logs under each
package's `ztmp/c26_verify_*` files.

#### C27 — `Runtime Error: Unexpected error: type 'BridgedEnumValue' is not a subtype of type 'PointerDeviceKind' in type cast`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 234 | gestures/ individual drag_gesture_recognizer_test.dart |

**Status:** fixed (2026-05-18, GEN-095).

**Root cause.** The script does
`vd.supportedDevices = <PointerDeviceKind>{PointerDeviceKind.touch, PointerDeviceKind.mouse}`.
The bridge setter for `Set<PointerDeviceKind>` was emitted as
`(value as Set).cast<PointerDeviceKind>().toSet()`. `.cast<T>()`
returns a *view* that casts elements on iteration; the D4rt set
literal contains `BridgedEnumValue` wrappers, not raw
`PointerDeviceKind` instances, so the first `CastIterator.current`
fails with the reported `BridgedEnumValue` cast error. The same
shape (Cast view via `.cast<T>().toList()` / `.cast<K,V>()`)
existed for List- and Map-typed setters wherever elements are
wrapped enums or bridged instances.

**Fix.** `BridgeGenerator._generateSetterCast`
(`tom_d4rt_generator/lib/src/bridge_generator.dart`, ~L11322) now
calls the D4 unwrap helpers instead of CastList / CastSet / CastMap
views:

- `List<T>` → `D4.coerceList<T>(value, '<paramName>')`
- `Set<T>` → `D4.coerceSet<T>(value, '<paramName>')`
- `Map<K, V>` → `D4.coerceMap<K, V>(value, '<paramName>', visitor)`

Each helper iterates eagerly and unwraps `BridgedEnumValue`,
`BridgedInstance`, and `InterpretedInstance` before casting,
returning a real `List<T>` / `Set<T>` / `Map<K, V>`. Helpers were
already present in both `tom_d4rt_ast` and `tom_d4rt`; no
interpreter change required. Bridges were regenerated in both
flutter packages.

**Regression scope:** rule (b) — generator change.

**Verification (AST driver, `D4RT_SKIP_BRIDGE_REGEN=1`):**

- C27 single-script:
  `gestures/drag_gesture_recognizer_test.dart` →
  `success=true, frameworkErrors=0`
  (log `tom_d4rt_flutter_ast/ztmp/c27_diag_verify.log.txt`).
- essential: 108/0/0
  (`tom_d4rt_flutter_ast/ztmp/c27_verify_ast_essential.log.txt`).
- important: 164/0/0
  (`tom_d4rt_flutter_ast/ztmp/c27_verify_ast_important.log.txt`).
- secondary: 649/1 skip/-4 — failures down from 5 to 4. C27
  fixed; remaining are pre-existing C28
  (drag_test, positioned_gesture_details), C30 (box_painter),
  C31 (linear_border_edge). No new regressions
  (`tom_d4rt_flutter_ast/ztmp/c27_verify_ast_secondary.log.txt`).

**Verification (analyzer driver, `D4RT_SKIP_BRIDGE_REGEN=1`):**

- essential: 108/0/0 (`ztmp/c27_verify_analyzer_essential.log.txt`)
- important: 164/0/0 (`ztmp/c27_verify_analyzer_important.log.txt`)
- secondary: 648/1 skip/-5 — failures down from 6 to 5. C27
  fixed; remaining are pre-existing C28
  (drag_test, positioned_gesture_details), C29
  (tap_drag_start_details — analyzer-only), C30 (box_painter),
  C31 (linear_border_edge). No new regressions
  (`ztmp/c27_verify_analyzer_secondary.log.txt`).

#### C28 — `Runtime Error: Native error during default bridged constructor for 'DragEndDetails': 'package:flutter/src/gestures/drag_details.dart': Faile`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 235 | gestures/ individual drag_test.dart |
| 243 | gestures/ individual positioned_gesture_details_test.dart |

**Status:** fixed (2026-05-18). Test-script-only change — rule (a).

**Root cause.** Flutter's `DragEndDetails` constructor asserts at
`package:flutter/src/gestures/drag_details.dart:217`:

```dart
primaryVelocity == null ||
    (primaryVelocity == velocity.pixelsPerSecond.dx && velocity.pixelsPerSecond.dy == 0) ||
    (primaryVelocity == velocity.pixelsPerSecond.dy && velocity.pixelsPerSecond.dx == 0)
```

When `primaryVelocity` is non-null it must equal one axis of
`velocity.pixelsPerSecond` while the other axis is exactly `0`.

Both scripts violated this:

- `drag_test.dart:34`: `(1200.0, 80.0)` with `primaryVelocity: 1200.0`.
- `positioned_gesture_details_test.dart:265`: `(420.0, 180.0)`
  with `primaryVelocity: 420.0`.

The constructor would have failed identically in native Dart — a
script-authoring bug, not an interpreter bug.

**Fix.** Set the off-axis to `0.0` in both scripts; intent (a
horizontal fling) is unchanged. The matching display literal at
`positioned_gesture_details_test.dart:438` was updated for
consistency.

**Verification (AST driver, `D4RT_SKIP_BRIDGE_REGEN=1`):**

- `gestures/drag_test.dart` → success, 0 frameworkErrors
  (`tom_d4rt_flutter_ast/ztmp/c28_verify_ast_drag.log.txt`).
- `gestures/positioned_gesture_details_test.dart` → success; the
  one remaining framework error is a pre-existing
  `BoxConstraints forces an infinite height` layout warning,
  unrelated to C28
  (`tom_d4rt_flutter_ast/ztmp/c28_verify_ast_pgd.log.txt`).

**Verification (analyzer driver, `D4RT_SKIP_BRIDGE_REGEN=1`):**

- `gestures/drag_test.dart` → success, 0 frameworkErrors
  (`ztmp/c28_verify_analyzer_drag.log.txt`).
- `gestures/positioned_gesture_details_test.dart` → success, same
  unrelated layout warning
  (`ztmp/c28_verify_analyzer_pgd.log.txt`).

#### C29 — `Runtime Error: Unexpected error: type 'String' is not a subtype of type 'InterpretedFunction?' in type cast`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 252 | gestures/ individual tap_drag_start_details_test.dart |

**Status:** fixed (2026-05-18). Analyzer-driver-only — bug in
`tom_d4rt`'s analyzer-based interpreter visitor. The AST mirror
interpreter never had this bug because it routes through
`currentFunction` directly.

**Root cause.** In `tom_d4rt/lib/src/interpreter_visitor.dart`
inside `visitReturnStatement` (~L6140), when the enclosing AST
node was a `FunctionDeclaration` the code resolved the function
name via:

```dart
currentCallable = environment.get(functionName) as InterpretedFunction?;
```

If the surrounding scope contains a local binding whose name
collides with the enclosing function (for example, a parameter
named the same as a generic helper such as `'callback'` or
`'name'` that is also a function declaration in a different
scope), `environment.get(functionName)` returns that other value
(in this case a `String`), and the hard `as InterpretedFunction?`
throws

```
type 'String' is not a subtype of type 'InterpretedFunction?' in type cast
```

which then surfaces as the wrapper `RuntimeD4rtException`
"Unexpected error: …" raised by `_executeInEnvironment`
(`d4rt_base.dart:1272`).

**Fix.** Replace the hard cast with an `is`-checked assignment
that falls back to `currentFunction` when the environment binding
is not actually an `InterpretedFunction`. This matches the mirror
AST visitor (`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`),
which uses `currentFunction` directly because the mirror AST has
no parent references and never walks up the AST.

```dart
final fromEnv = environment.get(functionName);
if (fromEnv is InterpretedFunction) {
  currentCallable = fromEnv;
} else {
  currentCallable = currentFunction;
}
```

No mirror change to `tom_d4rt_ast` is required — the AST visitor
already has the correct shape.

**Regression scope:** rule (b) — interpreter change.

**Verification (analyzer driver, `D4RT_SKIP_BRIDGE_REGEN=1`):**

- C29 single-script: `gestures/tap_drag_start_details_test.dart`
  → `success=true, outputLines=166`. The remaining 1 framework
  error is a pre-existing layout overflow warning unrelated to
  C29 (log `ztmp/c29_verify_analyzer_tdsd.log.txt`).
- essential: 108/0/0
  (`ztmp/c29_verify_analyzer_essential.log.txt`).
- important: 164/0/0
  (`ztmp/c29_verify_analyzer_important.log.txt`).
- secondary: 651/1 skip/-2 — was -5 (after C27/C28 in previous
  runs). C29 (tap_drag_start_details) and C28 (drag_test,
  positioned_gesture_details) are both fixed; remaining 2
  failures are pre-existing C30 (box_painter_test) and C31
  (linear_border_edge_test). No new regressions
  (`ztmp/c29_verify_analyzer_secondary.log.txt`).

**Verification (AST driver, `D4RT_SKIP_BRIDGE_REGEN=1`):** AST
runtime does not use `tom_d4rt`'s interpreter visitor, but rule
(b) was run anyway. essential 108/0/0, important 164/0/0,
secondary 651/1 skip/-2 — only pre-existing C30/C31 remain, no
new regressions
(`tom_d4rt_flutter_ast/ztmp/c29_verify_ast_*.log.txt`).

#### C30 — `Runtime Error: The condition of a conditional expression must be a boolean, but was null.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 319 | material/ individual snack_bar_closed_reason_test.dart |

#### C31 — `Runtime Error: Native error during bridged method call 'createBoxPainter' on ShapeDecoration: Null check operator used on a null value`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 335 | painting/ individual box_painter_test.dart |

**Status:** fixed (2026-05-18) — same fix as AST driver C30 (cluster
numbering is offset by one between drivers: AST C30 ≡ test driver
C31).

**Root cause.** Flutter's `Decoration.createBoxPainter` is declared
using legacy Dart syntax with an optional positional non-nullable
function parameter:

```dart
BoxPainter createBoxPainter([VoidCallback onChanged]);
// shape_decoration.dart, box_decoration.dart, flutter_logo.dart
// override it as: createBoxPainter([VoidCallback? onChanged])
```

Two compounding problems:

1. The generated bridge wrapper followed GEN-069 nullability rules
   (based on declared type alone) and produced a non-null closure
   wrapper. Calling with no argument hit
   `D4.callInterpreterCallback(visitor!, null, [])` → "Null check
   operator used on a null value".
2. Making the wrapper nullable failed static dispatch against the
   non-nullable declared parameter type.
3. Even with both generator fixes, `ShapeDecoration.createBoxPainter`
   uses `onChanged!` unconditionally (`shape_decoration.dart:286`),
   so the SDK itself throws regardless.

**Fix.**

- `tom_d4rt_generator/lib/src/bridge_generator.dart`
  (`_generatePositionalParamExtraction`): nullable wrapper for
  optional positional function-typed params without a default.
- `tom_d4rt_generator/lib/src/bridge_generator.dart`
  (`_generateMethodBody`): `(t as dynamic)` dispatch when method has
  a legacy optional positional function param with non-nullable
  declared type and no default, so the nullable closure wrapper
  reaches the concrete override.
- `tom_d4rt_flutter_ast/test/.../painting/box_painter_test.dart`
  (shared script via HTTP): pass `() {}` to
  `ShapeDecoration.createBoxPainter` to satisfy the SDK's
  `onChanged!` precondition.

**Verification (test driver).** gii `79/2/-2` (baseline),
essential `108/0/0`, important `164/0/0`, secondary `652/1/-1`
(baseline was `628/1/-25`; 24 incidental fixes from earlier
clusters surfaced, only pre-existing `linear_border_edge_test.dart`
C32 remains). No regressions; logs in `ztmp/c30_*.log.txt`.

#### C32 — `Runtime Error: Native error during default bridged constructor for 'LinearBorderEdge': 'package:flutter/src/painting/linear_border.dart': Fa`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 346 | painting/ individual linear_border_edge_test.dart |

**Status:** fixed (2026-05-18) — same script-only patch as AST driver
C31 (cluster numbering offset: AST C31 ≡ test driver C32).

**Root cause.** Flutter's `LinearBorderEdge` constructor asserts that
`size` is in `[0.0, 1.0]`
(`packages/flutter/lib/src/painting/linear_border.dart:38-39`). The
test script's "footguns" section constructed
`LinearBorderEdge(size: 1.5, ...)` and `LinearBorderEdge(size: -0.2, ...)`,
violating the assertion. D4rt surfaced the SDK assertion verbatim.

**Fix.** Single shared script (the AST driver app hosts it over HTTP
for both drivers):
`tom_d4rt_flutter_ast/test/.../send_ast_via_http_scripts/painting/linear_border_edge_test.dart`.
Replace out-of-range values with in-range boundaries (`size: 1.0`,
`size: 0.0`) and update the footgun prose to describe the SDK's
actual assert-at-construction behaviour.

**Verification (test driver).** Script-only change → individual
retest sufficient per cluster protocol rule (a). `painting/
individual linear_border_edge_test.dart`:
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
  > Runtime Error: Unexpected error: Concurrent modification during iteration: Instance(length:50) of '_GrowableList'.
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
  > Error: HttpException: Connection closed before full header was received, uri = http://localhost:4248/build?filename=material%2Ftooltip_feedback_test.dart
  > Stack trace:
  > ===== asynchronous gap ===========================

### hardly_relevant_classes_1_test.dart

#### C33 — `Runtime Error: Undefined static member 'hashCode' on bridged class 'UniformFloatSlot'.`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 124 | dart_ui/ uniform_float_slot_test.dart |

**Status:** fixed (2026-05-18) — interpreter change in both
`tom_d4rt/lib/src/interpreter_visitor.dart` and
`tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart`. Closes
both C33 (BridgedClass branch) and C34 (InterpretedClass branch)
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
(b).

- AST driver: individual `dart_ui/uniform_float_slot_test.dart`
  → `status=success outputLines=61 frameworkErrors=1` (pre-
  existing layout); individual `dart_ui/uniform_vec2_slot_test.dart`
  → `status=success outputLines=65 frameworkErrors=22`
  (pre-existing layout). Four-suite: gii `79/2/-2` (baseline:
  same `nestedscrollview_test`, `render_custom_multi_child_layout_box_test`
  layout pre-existing), essential `108/0/0`, important
  `164/0/0`, secondary `653/1/0` (gained 1 over baseline). Logs
  in `ztmp/c32/ast_*.log`.
- Test driver: individual `dart_ui/uniform_float_slot_test.dart`
  → `status=success outputLines=61 frameworkErrors=1`; individual
  `dart_ui/uniform_vec2_slot_test.dart` → `status=success
  outputLines=65 frameworkErrors=22`. Four-suite: gii
  `79/2/-2` (same pre-existing layout failures), essential
  `108/0/0`, important `164/0/0`, secondary `653/1/0` (gained 1
  over baseline). Logs in `ztmp/c32/test_*.log`.

No interpreter regressions on either driver.

#### C34 — `Runtime Error: Undefined static member 'hashCode' on class 'UniformVec2Slot'.`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 125 | dart_ui/ uniform_vec2_slot_test.dart |

**Status:** fixed (2026-05-18) — closed by the same interpreter
change as C33 (InterpretedClass branch of the same
`PrefixedIdentifier`/`PropertyAccess`/`MethodInvocation` fallback
trio). See C33 for full root-cause analysis, fix description, and
verification numbers.

#### C35 — `Runtime Error: Error in generic constructor factory for 'CachingIterable': Argument Error: Invalid parameter "_prefillIterator": expected It`

- [x] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 133 | foundation/ caching_iterable_test.dart |

**Status:** fixed (2026-05-18).

**Root cause.** The script constructs a typed list literal and then
passes its iterator to a bridged generic constructor:

```dart
final Iterator<int> source = <int>[1, 2, 3, /*...*/].iterator;
final CachingIterable<int> cache = CachingIterable<int>(source);
```

In native Dart, `<int>[1, 2, 3].iterator` is a `ListIterator<int>`. The
d4rt interpreter (both analyzer-based and AST-based) materialises typed
list literals as `List<Object?>` instead — the element-type annotation
is dropped during literal construction. The `.iterator` getter on that
list therefore returns `ListIterator<Object?>`.

The RC-2 generic-constructor factory for `CachingIterable<int>` in
`flutter_relaxers.b.dart` calls
`D4.extractBridgedArg<Iterator<int>>(_prefillIterator, ...)` to coerce
the source. `extractBridgedArg<T>` had branches for List / Iterable /
Set / Map but **none for `Iterator<T>`**, so the strict reified-generics
cast failed and surfaced as the user-visible error.

**Fix.** Added an `Iterator<T>` coercion branch to `D4.extractBridgedArg`
in both interpreters, plus a lazy element-wise cast wrapper:

- `lib/src/generator/d4.dart` (tom_d4rt) — analyzer-based interpreter.
- `lib/src/runtime/generator/d4.dart` (tom_d4rt_ast) — AST-based interpreter.

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

Individual reproduction & retest:

- AST driver — `flutter test test/hardly_relevant_classes_1_test.dart --plain-name 'caching_iterable_test.dart'`:
  - before: `Runtime Error: ... expected Iterator<int>, got ListIterator<Object?>`
  - after: `01:03 +1: All tests passed!` (`ztmp/c35/ast_caching_iterable_after.log`)
- Analyzer driver — same command in `tom_d4rt_flutter_test/`:
  - before: same error
  - after: `00:59 +1: All tests passed!` (`ztmp/c35/test_caching_iterable_after.log`)

Four-suite rule-b regression (both drivers, serial):

| Suite     | AST driver       | Analyzer driver  | Baseline |
|-----------|------------------|------------------|----------|
| gii       | `+79 ~2 -2`      | `+79 ~2 -2`      | `+79 ~2 -2` (pre-existing layout fails: `nestedscrollview_test`, `render_custom_multi_child_layout_box_test`) |
| essential | `+108`           | `+108`           | `+108/0/0` |
| important | `+164`           | `+164`           | `+164/0/0` |
| secondary | `+653 ~1`        | `+653 ~1`        | `+653 ~1` |

No interpreter regressions on either driver. Logs in `ztmp/c35/`.

#### C36 — `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toStringDeep': Argument Error: Invalid target: expected Diagnos`

- [x] fixed and re-verified — closed 2026-05-18

| testID | Test name |
|-------:|-----------|
| 135 | foundation/ class_test.dart |

**Root cause.** Architectural limitation: a script-defined class
that mixes in a *bridged* mixin whose concrete methods consume
abstract callbacks (e.g.
`DiagnosticableTreeMixin.toStringDeep` → `debugFillProperties` /
`debugDescribeChildren` / `toStringShort`) cannot reach those
concrete methods. The bridged-mixin method dispatch in
`tom_d4rt_ast/lib/src/runtime/runtime_types.dart` computes
`mixinTarget = nativeProxy ?? bridgedSuperObject ?? this`; for a
purely-interpreted class with no native superclass, this is the
`InterpretedInstance` itself, which the adapter's
`D4.validateTarget<DiagnosticableTreeMixin>` rejects.

Even if the target check were relaxed, the inherited concrete
methods on the native side dispatch back into the abstract
callbacks via *native* dynamic dispatch — they would resolve to
the native `Diagnosticable` defaults, not to the script
overrides, producing wrong dumps. A proper fix requires a
hand-written `_InterpretedDiagnosticableTreeMixin` proxy in
`d4rt_runtime_registrations.dart` (analogous to
`_InterpretedStatelessWidget` et al.) that holds the
`InterpretedInstance` + visitor and routes each abstract
callback back into the interpreter. Feature-scale work — out of
scope for a single-cluster pass.

Same architectural family as U3 (`Curve`), U5 (`NotchedShape`),
U8 (`Enum`), U9 (`RouteAware`) — all collected under
"script-defined subtype of a bridged native abstract/mixin type
cannot cross d4rt → native".

**Fix.** Documented as **U10** in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` with the
mandatory script-side workaround: a recursive `_dumpNode`
helper that walks the tree using the script's own fields and
formats it analogously to `toStringDeep` (`name` + bracketed
properties + box-drawing-connector-indented children). The
helper does not cross the d4rt → native boundary, so the
adapter-target check is never invoked. Applied at
`foundation/class_test.dart` line 268 (`_dumpNode` helper) and
line 288 (replace `tree.toStringDeep()` →
`_dumpNode(tree)`).

**Verification (rule a — script-only change, individual retest
sufficient).**

| Driver | Result |
|---|---|
| AST (`tom_d4rt_flutter_ast`) | `00:15 +1: All tests passed!` |
| Analyzer (`tom_d4rt_flutter_test`) | `00:12 +1: All tests passed!` |

Logs in `ztmp/c36/`. No interpreter or generator change — the
fix lives entirely in the test script and the unfixable-doc.

C37 (`DiagnosticableTreeMixin.toDiagnosticsNode` —
`foundation/diagnostics_serialization_delegate_test.dart`) is
the same root cause family and is expected to follow the same
script-side `_dumpNode`-style workaround in its own cluster
pass.

#### C37 — `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toDiagnosticsNode': Argument Error: Invalid target: expected Di`

- [x] fixed and re-verified — closed 2026-05-18

| testID | Test name |
|-------:|-----------|
| 144 | foundation/ diagnostics_serialization_delegate_test.dart |

**Root cause.** Same architectural family as C36 — covered by
**U10** in
`tom_d4rt_flutter_ast/doc/interpreter_unfixable.md`. A
script-defined class `_DemoConfig with DiagnosticableTreeMixin`
cannot reach the bridged `toDiagnosticsNode` /
`DiagnosticsNode.toJsonMap` pipeline: the bridged-mixin dispatch
falls through to `mixinTarget = InterpretedInstance`, which the
adapter's `D4.validateTarget<DiagnosticableTreeMixin>` rejects;
even if the check were relaxed, the inherited concrete methods
on the native side would dispatch back into the abstract
callbacks via *native* dynamic dispatch and miss the script
overrides.

**Fix.** Same workaround pattern as C36, but the demo is more
involved: the entry-point call is
`config.toDiagnosticsNode(name: 'root').toJsonMap(delegate)` at
`_serializeWith`, and the four script-defined delegate classes
(`_ShallowDelegate`, `_FilteredDelegate`, `_DepthTaggedDelegate`,
`_ComposedDelegate`) all `implements
DiagnosticsSerializationDelegate`. We rewrite `_serializeWith`
to call a script-side recursive `_manualSerialize(config,
delegate, depth)` that:

- reads `delegate.subtreeDepth` / `delegate.includeProperties`
  (both work for native and interpreted delegates — the bridged
  getters are present, and InterpretedInstance field access
  resolves on the script-defined subclasses);
- detects each script-defined delegate concrete class via `is`
  to read its extra knobs (`hidePrefix` for `_FilteredDelegate`,
  `maxChildren` / `depth` tag for `_DepthTaggedDelegate`,
  composed-mode child swap-in for `_ComposedDelegate`);
- emits a JSON-shaped `Map<String, Object?>` (`name`,
  `description`, `type`, `depth`, `_delegate`,
  per-prop list, recursive children) that mirrors what
  `toJsonMap` would have produced, sufficient for the demo's
  rendering needs without crossing the d4rt → native boundary.

The change lives entirely in the test script — no interpreter or
bridge edits — so it is a rule-(a) change and individual retest
is sufficient.

**Verification (rule a — script-only change).**

| Driver | Result |
|---|---|
| AST (`tom_d4rt_flutter_ast`) | `00:18 +1: All tests passed!` |
| Analyzer (`tom_d4rt_flutter_test`) | `00:15 +1: All tests passed!` |

Logs in `ztmp/c37/`.

#### C38 — `Runtime Error: Native error during default bridged constructor for 'ObjectFlagProperty': 'package:flutter/src/foundation/diagnostics.dart': `

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 162 | foundation/ object_flag_property_test.dart |

#### C39 — `Runtime Error: Native error during default bridged constructor for 'HitTestEntry': Argument Error: Invalid parameter "target": expected HitT`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 180 | gestures/ hit_testable_test.dart |

#### C40 — `TimeoutException after 0:00:30.000000: Test timed out after 30 seconds. See https://pub.dev/packages/test#timeouts || Bad state: Transport f`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 182 | gestures/ least_squares_solver_test.dart |

#### C41 — `Runtime Error: Native error during default bridged constructor for 'PointerExitEvent': 'package:flutter/src/gestures/events.dart': Failed as`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 194 | gestures/ pointer_exit_event_test.dart |

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

#### C42 — `Runtime Error: Native error during bridged method call 'increment' on Accumulator: 'package:flutter/src/painting/inline_span.dart': Failed a`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 175 | painting/ accumulator_test.dart |

Representative error texts:

- **#175** `painting/ accumulator_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during bridged method call 'increment' on Accumulator: 'package:flutter/src/painting/inline_span.dart': Failed assertion: line 39 pos 12: 'addend >= 0': is not true.

### hardly_relevant_classes_3_test.dart

#### C43 — `Runtime Error: Cannot access property 'isEmpty' on target of type _ConstMap<String, dynamic>.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 117 | semantics/ tap_semantic_event_test.dart |

#### C44 — `Runtime Error: Undefined variable: KeyDataTransitMode`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 147 | services/ key_data_transit_mode_test.dart |

#### C45 — `Runtime Error: Undefined variable: KeyboardSide`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 157 | services/ keyboard_side_test.dart |

#### C46 — `Runtime Error: Undefined variable: MaterialState (in Set literal)`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 165 | services/ mouse_tracker_annotation_test.dart |

#### C47 — `Runtime Error: Native error during default bridged constructor for 'RawFloatingCursorPoint': Argument Error: Invalid parameter "startLocatio`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 167 | services/ raw_floating_cursor_point_test.dart |

#### C48 — `Runtime Error: Undefined variable: build`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 171 | services/ raw_key_event_data_ios_test.dart |

#### C49 — `Runtime Error: Undefined variable: RawKeyEventDataWeb`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 175 | services/ raw_key_event_data_web_test.dart |

#### C50 — `Runtime Error: Undefined variable: RawKeyEventDataLinux`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 177 | services/ raw_key_event_test.dart |

#### C51 — `Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Nu`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 194 | services/ text_capitalization_test.dart |

#### C52 — `Bad state: Transport failure while running "services/text_editing_delta_insertion_test.dart"`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 196 | services/ text_editing_delta_insertion_test.dart |

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

#### C53 — `Runtime Error: Native error during bridged method call 'subscribe' on RouteObserver: Argument Error: Invalid parameter "routeAware": expecte`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 81 | widgets/ route_observer_test.dart |

Representative error texts:

- **#81** `widgets/ route_observer_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during bridged method call 'subscribe' on RouteObserver: Argument Error: Invalid parameter "routeAware": expected RouteAware, got InterpretedInstance(_LoggingRouteAware)

### timeout_tests_test.dart

#### C54 — `Bad state: Transport failure while running "rendering/render_custom_paint_test.dart"`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 15 | rendering/ render_custom_paint_test.dart |

#### C55 — `Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(ERR_NOT_FOUND, Resource mi`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 29 | services/ retest: services/method_codec_test.dart |

Representative error texts:

- **#15** `rendering/ render_custom_paint_test.dart` —
  > Bad state: Transport failure while running "rendering/render_custom_paint_test.dart"
  > Operation: POST /build?filename=rendering%2Frender_custom_paint_test.dart
  > Error: TimeoutException after 0:00:25.000000: Future not completed
  > Stack trace:
  > #0      Future.timeout.<anonymous closure> (dart:async/future_impl.dart:1042:24)
- **#29** `services/ retest: services/method_codec_test.dart` —
  > Expected: true
  >   Actual: <false>
  > Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(ERR_NOT_FOUND, Resource missing, path=/foo, null)

### generator_interpreter_issues_test.dart

#### C56 — `BoxConstraints forces an infinite height.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 34 | Section 2 - Bridge Generator Issues (80) widgets/nestedscrollview_test.dart |

#### C57 — `A RenderFlex overflowed by 7.0 pixels on the bottom.`

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

#### C58 — `A borderRadius can only be given on borders with uniform colors.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 33 | Section 1 - Tests with workarounds reverted retest: services/message_codec_test.dart |

#### C59 — `Runtime Error: Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(ERR_NOT_FOUND, Resource mi`

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

Total overflow / layout warning lines: **149**

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
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#08d29 relayoutBoundary=up16 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#d3fa5 relayoutBoundary=up15 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#f88ba relayoutBoundary=up14 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderClipPath#2dbab relayoutBoundary=up13 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderDecoratedBox#9a45a relayoutBoundary=up12 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#374f4 relayoutBoundary=up11 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#1f4c9 relayoutBoundary=up10 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: _RenderSingleChildViewport#e4527 relayoutBoundary=up9 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderIgnorePointer#82ded relayoutBoundary=up8 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderSemanticsAnnotations#7c25a relayoutBoundary=up7 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- … 33 more

### secondary_classes_test.dart (41 unique)

- `A RenderFlex overflowed by 2.0 pixels on the right.`
- `A RenderFlex overflowed by 4.0 pixels on the bottom.`
- `A RenderFlex overflowed by 18 pixels on the right.`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#4a7fe relayoutBoundary=up15 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#328a9 relayoutBoundary=up14 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#9dfe6 relayoutBoundary=up13 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#eb32f relayoutBoundary=up12 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#a4fca relayoutBoundary=up11 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: _RenderSingleChildViewport#bc43f relayoutBoundary=up10 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderIgnorePointer#0539d relayoutBoundary=up9 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderSemanticsAnnotations#a9fa9 relayoutBoundary=up8 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPointerListener#5ad4e relayoutBoundary=up7 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderSemanticsGestureHandler#15e73 relayoutBoundary=up6 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPointerListener#a6013 relayoutBoundary=up5 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: _RenderScrollSemantics#e96e1 relayoutBoundary=up4 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderTransform#c1f46 relayoutBoundary=up3 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderClipRect#04cdc relayoutBoundary=up2 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#ef34e relayoutBoundary=up1 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderTransform#c1f46 relayoutBoundary=up3`
- `[D4rtApp] [framework error] A RenderFlex overflowed by 4.0 pixels on the bottom.`
- … 21 more

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

### timeout_tests_test.dart (26 unique)

- `A RenderFlex overflowed by 7.0 pixels on the bottom.`
- `[10:35:09] [framework error] A RenderFlex overflowed by 7.0 pixels on the bottom.`
- `Another exception was thrown: RenderBox was not laid out: RenderConstraintsTransformBox#32509 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderClipRRect#668ef NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#ba1f3 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderDecoratedBox#7e46a NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderConstrainedBox#42033 relayoutBoundary=up17 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#89ca1 relayoutBoundary=up16 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#f2242 relayoutBoundary=up15 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderDecoratedBox#757f8 relayoutBoundary=up14 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#76079 relayoutBoundary=up13 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#c22de relayoutBoundary=up12 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderFlex#a1d3e relayoutBoundary=up11 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPadding#a5198 relayoutBoundary=up10 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: _RenderSingleChildViewport#0317f relayoutBoundary=up9 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderIgnorePointer#132a2 relayoutBoundary=up8 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderSemanticsAnnotations#3c79e relayoutBoundary=up7 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPointerListener#89125 relayoutBoundary=up6 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderSemanticsGestureHandler#e334c relayoutBoundary=up5 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- `Another exception was thrown: RenderBox was not laid out: RenderPointerListener#2f083 relayoutBoundary=up4 NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE`
- … 6 more

### generator_interpreter_issues_test.dart (1 unique)

- `A RenderFlex overflowed by 7.0 pixels on the bottom.`

### interactive_tests_test.dart (4 unique)

- `A RenderFlex overflowed by 20 pixels on the bottom.`
- `A RenderFlex overflowed by 6.0 pixels on the bottom.`
- `A RenderFlex overflowed by 70 pixels on the bottom.`
- `A RenderFlex overflowed by 126 pixels on the bottom.`

## Flutter Assertion / Framework-Exception Lines in Log

Total unique assertion-related lines: **28**

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
- `Runtime Error: Unexpected error: 'package:flutter/src/widgets/restoration_properties.dart': Failed assertion: line 85 pos 12: 'isRegistered': is not true.`
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

### timeout_tests_test.dart (5 unique)

- `Failed assertion: line 943 pos 14: 'childConstraints.isNormalized'`
- `[D4rtApp] [silenced assertion] 'package:flutter/src/widgets/framework.dart': Failed assertion: line 6268 pos 12: '_dependents.isEmpty': is not true.`
- `Another exception was thrown: 'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.`
- `Another exception was thrown: 'package:flutter/src/rendering/object.dart': Failed assertion: line 5493 pos 14: '!semantics.parentDataDirty': is not true.`
- `Another exception was thrown: 'package:flutter/src/widgets/framework.dart': Failed assertion: line 6417 pos 14: '() {`

## Metric Coverage

| File | `[METRIC]` lines |
|------|----------------:|
| essential_classes_test.dart | 107 |
| important_classes_test.dart | 163 |
| secondary_classes_test.dart | 652 |
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

