# Error analysis — `20260518-1357-post-cluster-fixes-rebaseline`

8 failures across 7 suites. 2 are pre-existing won't-fix markers;
6 are new since `0503-2238` and trace back to a single
generator-side regression.

## Pre-existing — not regressions

### F1 · `I-BUG-14a` "SHOULD FAIL" (records with named fields) — `tom_d4rt`, `tom_d4rt_exec`

```
Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a:
  Records with named fields. [2026-02-10 06:37] (FAIL)
  [limitations_and_bugs_test.dart]
```

Same documented limitation that `0503-2238` reported. The
interpreter returns `InterpretedRecord:<(x: 10, y: 20)>` where the
test expects `Instance of '({int x, int y})'`. Tracked.
Mounted twice because `tom_d4rt` and `tom_d4rt_exec` both pull in
`limitations_and_bugs_test.dart`. No action.

## New since `0503-2238` — single root cause, three downstream symptoms

### F2 · `setUpAll` compile failure in `example/d4`-driven smoke tests — `tom_ast_generator`, `tom_d4rt_exec`, `tom_d4rt_generator`

Six failing test cases, two per project:

| Project | Test file | Test |
|---|---|---|
| `tom_ast_generator` | `test/generator_tests/d4rt_tester_test.dart` | `(setUpAll)` |
| `tom_ast_generator` | `test/generator_tests/d4rt_coverage_test.dart` | `dart_overview coverage (setUpAll)` |
| `tom_d4rt_exec` | `test/generator_tests/d4rt_tester_test.dart` | `(setUpAll)` |
| `tom_d4rt_exec` | `test/generator_tests/d4rt_coverage_test.dart` | `dart_overview coverage (setUpAll)` |
| `tom_d4rt_generator` | `test/d4rt_tester_test.dart` | `(setUpAll)` |
| `tom_d4rt_generator` | `test/d4rt_coverage_test.dart` | `dart_overview coverage (setUpAll)` |

All six fail with the same error:

```
COMPILATION FAILED:

lib/src/d4rt_bridges/test_callback_types.b.dart:175:158:
  Error: The argument type 'FutureOr<Object?> Function(dynamic)'
         can't be assigned to the parameter type
         'FutureOr<Object> Function(dynamic)'.
 - 'Object' is from 'dart:core'.

  return t.withConnection(
    ((dynamic p0) {
      return D4.castCallbackResult<FutureOr<Object?>>(
        D4.callInterpreterCallback(visitor!, callbackRaw, [p0]));
    }) as FutureOr<Object?> Function(dynamic));

Error: AOT compilation failed
Bad state: Generating AOT kernel dill failed!
```

Raw blocks captured to `tom_{ast_generator,d4rt_exec,d4rt_generator}_d4_compile_error.log.txt`.

#### Source vs generated mismatch

Source signature
(`tom_d4rt_generator/example/d4/lib/test_callback_types.dart:57`):

```dart
class CallbackTypeService {
  Future<String> withConnection(
    FutureOr<Object> Function(dynamic connection) callback,
  ) async { ... }
}
```

`FutureOr<Object>` — **non-nullable** `Object`. The callback
returns a value that the body unconditionally `await`s and then
`.toString()`s, so the non-nullable contract is meaningful.

Generated code
(`tom_d4rt_generator/example/d4/lib/src/d4rt_bridges/test_callback_types.b.dart:175`,
identical in the other two example folders):

```dart
'withConnection': (visitor, target, positional, named, typeArgs) {
  final t = D4.validateTarget<$d4_example_5.GenericCallbackService>(target, 'GenericCallbackService');
  ...
  final callbackRaw = positional[0];
  return t.withConnection(
    ((dynamic p0) {
      return D4.castCallbackResult<FutureOr<Object?>>(
        D4.callInterpreterCallback(visitor!, callbackRaw, [p0]));
    }) as FutureOr<Object?> Function(dynamic));
},
```

Two nullability bumps where the source declared non-nullable:

1. `D4.castCallbackResult<FutureOr<Object?>>(…)` — should be
   `FutureOr<Object>` (the declared return-type of the callback).
2. `… as FutureOr<Object?> Function(dynamic)` — should be
   `FutureOr<Object> Function(dynamic)` (the declared parameter
   type of `withConnection`).

The first emission is `D4.castCallbackResult<…>` which is presumably
tolerant either way; it's the outer `as` cast on (1)→(2) that the
analyzer/compiler rejects because `FutureOr<Object?> Function(_)`
is not a subtype of `FutureOr<Object> Function(_)` (function-return
covariance).

#### Suspect commit

`114f11f5 fix(d4rt): close C11 — self-import guard + nullable FutureOr callback returns`

That commit (landed after `0503-2238`) is the only post-baseline
change in `tom_d4rt_generator/lib/` whose subject explicitly names
the offending shape ("nullable FutureOr callback returns"). The
likely intent of C11 was to make `FutureOr<T>` callback *returns*
nullable when the call site can yield `null` — but the
implementation appears to always coerce to `FutureOr<Object?>`
without checking the source's declared nullability, then re-emit
that same nullable type in the outer function-type cast.

This wants confirmation by reading the commit's diff against
`bridge_generator.dart` (or whichever helper builds the callback
adapter): the right fix preserves the source-declared nullability
of the callback's return type instead of normalising to `Object?`.

#### Downstream blast radius

This single emission lives in every generated copy of
`test_callback_types.b.dart`. The three projects that smoke-test
`example/d4` (the `d4rt_tester_test.dart` /
`d4rt_coverage_test.dart` `setUpAll` blocks compile the bundle
before running the test body) all fail at the same line. Because
the failures are in `setUpAll`, every dependent test in those
suites is reported as a test-count drop rather than as individual
failures — that's where the −348 test-count delta comes from:

| Project | Tests in 2238 | Tests in 1357 | Drop |
|---|---:|---:|---:|
| `tom_ast_generator` | 510 | 390 | −120 |
| `tom_d4rt_exec` | 2260 | 2146 | −114 |
| `tom_d4rt_generator` | 660 | 540 | −120 |

The combined ~354 absent tests are *not* removed from the corpus;
they simply never execute because their suite's `setUpAll`
short-circuits.

#### Recommended fix

In whichever generator method builds the callback-adapter cast for
`FutureOr<T>`-returning callbacks (likely in
`bridge_generator.dart`, plumbing through the parameter-type
emitter that runs on `FunctionType`), preserve the source-declared
nullability of the callback's return type:

- If the source says `FutureOr<Object>`, emit
  `castCallbackResult<FutureOr<Object>>` and cast to
  `FutureOr<Object> Function(...)`.
- If the source says `FutureOr<Object?>`, emit the nullable form.
- If the source uses a generic type parameter (e.g.
  `FutureOr<T>` from a method like `withConnection<T>` further up
  in the same source file), the existing relaxation that produced
  `FutureOr<Object?>` is probably correct — but only for the
  *generic* case, not for the concrete non-generic
  `CallbackTypeService.withConnection`.

The same source file at `test_callback_types.dart:29` declares a
generic version (`FutureOr<T> withConnection<T>(...)`) — that one
*does* need an erased `FutureOr<Object?>` because `T` cannot be
preserved at bridge-emission time. So the regression is plausibly
caused by C11 applying that generic-erasure path to *both*
overloads. The right shape is probably "only erase to
`FutureOr<Object?>` when the callback's return type literally
mentions a type parameter that escapes the bridged method's scope;
otherwise preserve."

### F3 · No other captured-but-non-failing errors

Outside of the 8 reported failures, the per-project logs were
scanned for `Runtime Error:`, `Bridge generation failed`,
`COMPILATION FAILED`, and `Exception` markers. All hits resolve
to:

- The two `(SHOULD FAIL)` records (`I-BUG-14a`) — accounted for.
- The six `setUpAll` compile failures above — accounted for.
- `Skipping HTTP request test: Runtime Error: Break statement
  outside of a loop` in `tom_d4rt.log.txt` and
  `tom_d4rt_exec.log.txt` — deliberate test-internal
  `print('Skipping HTTP request test: …')` lines emitted by an
  `expectError`-style fixture; the corresponding tests pass.
  Same pattern observed and dismissed in `0503-2238`.

No silent / unattributed errors. The regression is fully
characterised by F2.

## Action items (for a follow-up session)

1. Read the diff of `114f11f5` against
   `tom_d4rt_generator/lib/src/bridge_generator.dart` (and whatever
   helper emits the cast on
   `FunctionType` parameters / `FutureOr<T>` returns).
2. Reproduce the regression locally by regenerating
   `example/d4` bridges in any of the three example folders and
   running `dart test test/d4rt_tester_test.dart`.
3. Add a focussed unit test in `tom_d4rt_generator/test/` that
   feeds a non-generic `FutureOr<Object>`-returning callback into
   the bridge emitter and asserts the emitted parameter-type cast
   is `FutureOr<Object> Function(dynamic)`, not
   `FutureOr<Object?> Function(dynamic)`.
4. Fix the emitter to branch on "callback return-type mentions a
   bridged-method type parameter" rather than universally erasing.
5. Regenerate the three `example/d4` bridge bundles
   (`tom_d4rt_generator`, `tom_d4rt_exec`, `tom_ast_generator`) and
   re-run the three failing suites. Then re-run this rebaseline
   to confirm green.
6. After the generator fix lands, regenerate the flutter-material
   bridge bundle via `tom_d4rt_flutter_ast/tool/regenerate_bridges.dart`
   so any inherited defect there is also cleared — and re-run a
   small flutter-test slice (e.g. `essential_classes_test`) to
   confirm the regeneration didn't disturb the flutter corpus.
