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
| **C07** | `important_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'ParagraphStyle': type 'StrutStyle' is not a subtype of type 'StrutStyle?` | ☐ |
| **C08** | `important_classes_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'substring' on String: RangeError (end): Invalid value: Not in inclusive range 12..16` | ☐ |
| **C09** | `important_classes_test.dart` | 1 | `Runtime Error: Native error during bridged constructor 'sweep' for class 'Gradient': Argument Error: Gradient: Parameter "endAngle" has non-` | ☐ |
| **C10** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during bridged operator '+' on double: type 'Null' is not a subtype of type 'num' in type cast` | ☐ |
| **C11** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: Concurrent modification during iteration: Instance(length:50) of '_GrowableList'.` | ☐ |
| **C12** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Nu` | ☐ |
| **C13** | `secondary_classes_test.dart` | 1 | `Runtime Error: Index assignment target must be List or Map in cascade.` | ☐ |
| **C14** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'GestureDetector': Incorrect GestureDetector arguments.` | ☐ |
| **C15** | `secondary_classes_test.dart` | 1 | `Bad state: Transport failure while running "material/tooltip_feedback_test.dart"` | ☐ |
| **C16** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'BottomAppBar': Argument Error: Invalid parameter "shape": expected Notch` | ☐ |
| **C17** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: SourceCodeException: Module source not preloaded for URI: package:vector_math/vector_math_64.dart, and not ` | ☐ |
| **C18** | `secondary_classes_test.dart` | 1 | `Runtime Error: Cannot access property 'entries' on target of type _ConstMap<String, dynamic>.` | ☐ |
| **C19** | `secondary_classes_test.dart` | 2 | `Runtime Error: Positional arguments cannot follow named arguments.` | ☑ fixed |
| **C20** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'RestorableEnum': Argument Error: Invalid parameter "defaultValue": expec` | ☐ |
| **C21** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'WidgetSpan': 'package:flutter/src/widgets/widget_span.dart': Failed asse` | ☐ |
| **C22** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'subscribe' on RouteObserver: Argument Error: Invalid parameter "routeAware": expecte` | ☐ |
| **C23** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'DraggableScrollableSheet': 'package:flutter/src/widgets/draggable_scroll` | ☐ |
| **C24** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: 'package:flutter/src/widgets/restoration_properties.dart': Failed assertion: line 85 pos 12: 'isRegistered'` | ☐ |
| **C25** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: Null check operator used on a null value` | ☐ |
| **C26** | `secondary_classes_test.dart` | 1 | `Runtime Error: A value of type 'List' can't be returned from the function 'encodeFrame' because it has a return type of 'Uint8List'.` | ☐ |
| **C27** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: type 'BridgedEnumValue' is not a subtype of type 'PointerDeviceKind' in type cast` | ☐ |
| **C28** | `secondary_classes_test.dart` | 2 | `Runtime Error: Native error during default bridged constructor for 'DragEndDetails': 'package:flutter/src/gestures/drag_details.dart': Faile` | ☐ |
| **C29** | `secondary_classes_test.dart` | 1 | `Runtime Error: Unexpected error: type 'String' is not a subtype of type 'InterpretedFunction?' in type cast` | ☐ |
| **C30** | `secondary_classes_test.dart` | 1 | `Runtime Error: The condition of a conditional expression must be a boolean, but was null.` | ☐ |
| **C31** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during bridged method call 'createBoxPainter' on ShapeDecoration: Null check operator used on a null value` | ☐ |
| **C32** | `secondary_classes_test.dart` | 1 | `Runtime Error: Native error during default bridged constructor for 'LinearBorderEdge': 'package:flutter/src/painting/linear_border.dart': Fa` | ☐ |
| **C33** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Undefined static member 'hashCode' on bridged class 'UniformFloatSlot'.` | ☐ |
| **C34** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Undefined static member 'hashCode' on class 'UniformVec2Slot'.` | ☐ |
| **C35** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Error in generic constructor factory for 'CachingIterable': Argument Error: Invalid parameter "_prefillIterator": expected It` | ☐ |
| **C36** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toStringDeep': Argument Error: Invalid target: expected Diagnos` | ☐ |
| **C37** | `hardly_relevant_classes_1_test.dart` | 1 | `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toDiagnosticsNode': Argument Error: Invalid target: expected Di` | ☐ |
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

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 147 | dart_ui/ text_data_test.dart |

#### C08 — `Runtime Error: Native error during bridged method call 'substring' on String: RangeError (end): Invalid value: Not in inclusive range 12..16`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 161 | services/ spellcheck_test.dart |

#### C09 — `Runtime Error: Native error during bridged constructor 'sweep' for class 'Gradient': Argument Error: Gradient: Parameter "endAngle" has non-`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 179 | rendering/ gradient_rendering_test.dart |

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

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 8 | animation/ animation_misc_adv_test.dart |

#### C11 — `Runtime Error: Unexpected error: Concurrent modification during iteration: Instance(length:50) of '_GrowableList'.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 31 | foundation/ synchronousfuture_test.dart |

#### C12 — `Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Nu`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 32 | foundation/ targetplatform_test.dart |

#### C13 — `Runtime Error: Index assignment target must be List or Map in cascade.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 33 | foundation/ foundation_misc_adv_test.dart |

#### C14 — `Runtime Error: Native error during default bridged constructor for 'GestureDetector': Incorrect GestureDetector arguments.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 37 | gestures/ tap_force_test.dart |

#### C15 — `Bad state: Transport failure while running "material/tooltip_feedback_test.dart"`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 58 | material/ tooltip_feedback_test.dart |

#### C16 — `Runtime Error: Native error during default bridged constructor for 'BottomAppBar': Argument Error: Invalid parameter "shape": expected Notch`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 69 | material/ bottom_app_bar_test.dart |

#### C17 — `Runtime Error: Unexpected error: SourceCodeException: Module source not preloaded for URI: package:vector_math/vector_math_64.dart, and not `

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 82 | painting/ matrixutils_test.dart |

#### C18 — `Runtime Error: Cannot access property 'entries' on target of type _ConstMap<String, dynamic>.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 102 | semantics/ semantics_events_test.dart |

#### C19 — `Runtime Error: Positional arguments cannot follow named arguments.`

- [x] **fixed** (2026-05-17) — same root cause and fix as C01; see C01
  section for details. Both tests passed in the post-fix regression run.

| testID | Test name |
|-------:|-----------|
| 108 | services/ platform_channels_test.dart |
| 143 | widgets/ table_wrap_flow_test.dart |

#### C20 — `Runtime Error: Native error during default bridged constructor for 'RestorableEnum': Argument Error: Invalid parameter "defaultValue": expec`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 119 | widgets/ restorable_values_test.dart |

#### C21 — `Runtime Error: Native error during default bridged constructor for 'WidgetSpan': 'package:flutter/src/widgets/widget_span.dart': Failed asse`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 125 | widgets/ textspan_test.dart |

#### C22 — `Runtime Error: Native error during bridged method call 'subscribe' on RouteObserver: Argument Error: Invalid parameter "routeAware": expecte`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 147 | widgets/ route_observer_test.dart |

#### C23 — `Runtime Error: Native error during default bridged constructor for 'DraggableScrollableSheet': 'package:flutter/src/widgets/draggable_scroll`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 153 | widgets/ draggable_sheet_test.dart |

#### C24 — `Runtime Error: Unexpected error: 'package:flutter/src/widgets/restoration_properties.dart': Failed assertion: line 85 pos 12: 'isRegistered'`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 161 | widgets/ restoration_adv_test.dart |

#### C25 — `Runtime Error: Unexpected error: Null check operator used on a null value`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 170 | cupertino/ individual cupertino_page_test.dart |

#### C26 — `Runtime Error: A value of type 'List' can't be returned from the function 'encodeFrame' because it has a return type of 'Uint8List'.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 223 | foundation/ individual read_buffer_test.dart |

#### C27 — `Runtime Error: Unexpected error: type 'BridgedEnumValue' is not a subtype of type 'PointerDeviceKind' in type cast`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 234 | gestures/ individual drag_gesture_recognizer_test.dart |

#### C28 — `Runtime Error: Native error during default bridged constructor for 'DragEndDetails': 'package:flutter/src/gestures/drag_details.dart': Faile`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 235 | gestures/ individual drag_test.dart |
| 243 | gestures/ individual positioned_gesture_details_test.dart |

#### C29 — `Runtime Error: Unexpected error: type 'String' is not a subtype of type 'InterpretedFunction?' in type cast`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 252 | gestures/ individual tap_drag_start_details_test.dart |

#### C30 — `Runtime Error: The condition of a conditional expression must be a boolean, but was null.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 319 | material/ individual snack_bar_closed_reason_test.dart |

#### C31 — `Runtime Error: Native error during bridged method call 'createBoxPainter' on ShapeDecoration: Null check operator used on a null value`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 335 | painting/ individual box_painter_test.dart |

#### C32 — `Runtime Error: Native error during default bridged constructor for 'LinearBorderEdge': 'package:flutter/src/painting/linear_border.dart': Fa`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 346 | painting/ individual linear_border_edge_test.dart |

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

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 124 | dart_ui/ uniform_float_slot_test.dart |

#### C34 — `Runtime Error: Undefined static member 'hashCode' on class 'UniformVec2Slot'.`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 125 | dart_ui/ uniform_vec2_slot_test.dart |

#### C35 — `Runtime Error: Error in generic constructor factory for 'CachingIterable': Argument Error: Invalid parameter "_prefillIterator": expected It`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 133 | foundation/ caching_iterable_test.dart |

#### C36 — `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toStringDeep': Argument Error: Invalid target: expected Diagnos`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 135 | foundation/ class_test.dart |

#### C37 — `Runtime Error: Native error in bridged mixin method 'DiagnosticableTreeMixin.toDiagnosticsNode': Argument Error: Invalid target: expected Di`

- [ ] fixed and re-verified

| testID | Test name |
|-------:|-----------|
| 144 | foundation/ diagnostics_serialization_delegate_test.dart |

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

