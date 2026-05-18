# Post-cluster-fixes rebaseline — `20260518-1357-post-cluster-fixes-rebaseline`

Re-run of the **non-flutter** d4rt-repository test suites to check
whether the ~190 cluster-fix commits landed since the
`20260503-2238-post-fixes-rebaseline` baseline have caused
regressions in the component-level test suites of tom_d4rt /
tom_d4rt_ast / tom_d4rt_generator / tom_d4rt_exec / tom_ast_generator
/ tom_d4rt_dcli / tom_dcli_exec. The cluster-fix work was driven
primarily by the flutter-material script corpus in
`tom_d4rt_flutter_ast` and `tom_d4rt_flutter_test`; this rebaseline
asks: did that work break anything *here*.

The flutter-material suites are intentionally **not** part of this
rebaseline — they continue to run via the per-cluster
`testlog_20260517-0914-test_analysis` workflow in both
`tom_d4rt_flutter_ast/doc/` and `tom_d4rt_flutter_test/doc/`.

| Field | Value |
| --- | --- |
| Baseline ID | `20260518-1357-post-cluster-fixes-rebaseline` |
| Date | 2026-05-18 (Mon, 13:57:54 CEST) |
| Git revision | `40b8ac30` (`40b8ac30a3466749f2cd8761df43543936fa2327`) |
| Branch | `main` |
| Bridges | regenerated via `tom_d4rt_flutter_ast/tool/regenerate_bridges.dart` (log: `_regen_bridges.log.txt`, success=true, 26.5 s, 18 output files, 2019 classes, 13 modules) |
| Run protocol | `dart test --reporter expanded --file-reporter "json:<base>/<project>.result.json"`, all 7 projects in parallel (independent suites, no shared HTTP server) |
| Comparison | non-flutter projects only |
| Verdict | **Regression** — 6 new `setUpAll` failures introduced by a generator-side `FutureOr` nullability mismatch (see *Failing tests* and `error_analysis.md`). |

## Commits since `0503-2238`

192 commits in `71e1984c..40b8ac30`. The bulk are flutter-script
fixes that don't touch any project under test here. The commits
that *do* land in component libraries the non-flutter suites
exercise:

```
1038e02d fix(generator): handle record-typed named params in bridges (C47)
f5ff30ee fix(d4rt-interpreter): register _ConstMap in Map bridge nativeNames (C43)
1eab39fc fix(C34/C35): coerce Iterator<Object?> to Iterator<T> in D4.extractBridgedArg
efe83f71 fix(C32/C33): dispatch Object methods on Type-literal class values
a8efd8da fix(C30): null-safe wrapper + dynamic dispatch for legacy optional positional function params
5da5f567 fix(C29): defensive function-resolution in visitReturnStatement
39b94ab3 fix(GEN-095): emit D4.coerce{List,Set,Map} for collection setters
0c402ab7 fix(C26): resolve typed-data List subclasses to their specific bridge in getRuntimeType
7959f165 fix(d4rt): close C13 — bridged []= in cascade + getter-returning-callable as method
42174e00 fix(d4rt): close C12 — fall through empty grouped pattern cases
114f11f5 fix(d4rt): close C11 — self-import guard + nullable FutureOr callback returns
40f58416 fix(d4rt): let GEN-100 cast fall through to RC-3 cross-package coercion (C07)
5e9289e0 fix(d4rt): allow named arguments anywhere in call (Dart 3 semantics)
cf7a4052 fix(d4rt): resolve prefixed `is` type-test via prefixed-imports env (GEN-100c)
208bab4f fix(d4rt): distinguish absent vs explicit-null in D4.getNamedArgWithDefault (§G1)
434b9bef fix(d4rt): universal Object members + generic List dispatch (GEN-C3c, GEN-C3d)
50083b5b Fix cluster C3: codec rejects BridgedInstance, exception toString fallback
39b94ab3 fix(GEN-095): emit D4.coerce{List,Set,Map} for collection setters
```

The regression observed below is attributable to `114f11f5`
("nullable FutureOr callback returns") — see `error_analysis.md`.

## Result totals

| Project | Total | Passed | Failed | Skipped | Errors | Wall |
|---|---:|---:|---:|---:|---:|---:|
| `tom_ast_generator` | 390 | 388 | 2 | 0 | 0 | 00:43 |
| `tom_d4rt` | 1753 | 1751 | 1 | 1 | 0 | 00:28 |
| `tom_d4rt_ast` | 117 | 117 | 0 | 0 | 0 | 00:02 |
| `tom_d4rt_dcli` | 706 | 706 | 0 | 0 | 0 | 06:00 |
| `tom_d4rt_exec` | 2146 | 2143 | 3 | 0 | 0 | 00:56 |
| `tom_d4rt_generator` | 540 | 538 | 2 | 0 | 0 | 00:44 |
| `tom_dcli_exec` | 412 | 412 | 0 | 0 | 0 | 00:13 |
| **TOTAL** | **6064** | **6055** | **8** | **1** | **0** |  |

(Wall times are per-suite; runs were parallel — total wall ≈ 6 min.)

## Delta vs `testlog_20260503-2238-post-fixes-rebaseline`

| Project | 2238 (T/P/F/S/E) | 1357 (T/P/F/S/E) | Δ tests | Δ pass | Δ fail | Δ err |
|---|---|---|---:|---:|---:|---:|
| `tom_ast_generator` | 510/510/0/0/0 | 390/388/2/0/0 | **−120** | **−122** | **+2** | 0 |
| `tom_d4rt` | 1747/1745/1/1/0 | 1753/1751/1/1/0 | **+6** | **+6** | 0 | 0 |
| `tom_d4rt_ast` | 117/117/0/0/0 | 117/117/0/0/0 | 0 | 0 | 0 | 0 |
| `tom_d4rt_dcli` | 706/706/0/0/0 | 706/706/0/0/0 | 0 | 0 | 0 | 0 |
| `tom_d4rt_exec` | 2260/2259/1/0/0 | 2146/2143/3/0/0 | **−114** | **−116** | **+2** | 0 |
| `tom_d4rt_generator` | 660/660/0/0/0 | 540/538/2/0/0 | **−120** | **−122** | **+2** | 0 |
| `tom_dcli_exec` | 412/412/0/0/0 | 412/412/0/0/0 | 0 | 0 | 0 | 0 |
| **non-flutter total** | **6412/6409/2/1/0** | **6064/6055/8/1/0** | **−348** | **−354** | **+6** | 0 |

The −348 test-count shift is driven by **three projects each
losing roughly the same fixture suite** (≈120 tests in
tom_ast_generator and tom_d4rt_generator; ≈114 in tom_d4rt_exec).
These are not silent removals — the dropouts trace back to a
single `setUpAll` block that now throws, taking every dependent
test in those suites with it. See `error_analysis.md` for the
root-cause walk-through.

## Delta vs `testlog_20260502-1010-consol-rebaseline`

| Project | 0502 (T/P/F/S/E) | 1357 (T/P/F/S/E) | Δ tests | Δ pass | Δ fail | Δ err |
|---|---|---|---:|---:|---:|---:|
| `tom_ast_generator` | 510/503/6/0/1 | 390/388/2/0/0 | **−120** | **−115** | **−4** | **−1** |
| `tom_d4rt` | 1747/1736/9/1/1 | 1753/1751/1/1/0 | **+6** | **+15** | **−8** | **−1** |
| `tom_d4rt_ast` | 117/115/0/0/2 | 117/117/0/0/0 | 0 | **+2** | 0 | **−2** |
| `tom_d4rt_dcli` | 706/704/1/0/1 | 706/706/0/0/0 | 0 | **+2** | **−1** | **−1** |
| `tom_d4rt_exec` | 2260/2234/25/0/1 | 2146/2143/3/0/0 | **−114** | **−91** | **−22** | **−1** |
| `tom_d4rt_generator` | 660/652/8/0/0 | 540/538/2/0/0 | **−120** | **−114** | **−6** | 0 |
| `tom_dcli_exec` | 75/72/3/0/0 | 412/412/0/0/0 | **+337** | **+340** | **−3** | 0 |
| **non-flutter total** | **6075/6016/52/1/6** | **6064/6055/8/1/0** | **−11** | **+39** | **−44** | **−6** |

Vs the older `0502-1010` baseline the picture is mixed: net
failure count is still well below the May-2 high-water mark
(−44 / −6), but the new May-18 regressions claw back some of the
gains that `0503-2238` had cleanly resolved.

## Failing tests

`_failures.md` lists 8 total:

```
tom_ast_generator      (2):
  (setUpAll)                                                                 [d4rt_tester_test.dart]
  dart_overview coverage (setUpAll)                                          [d4rt_coverage_test.dart]

tom_d4rt               (1):
  Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields.  [limitations_and_bugs_test.dart]

tom_d4rt_exec          (3):
  Open Bugs - Won't Fix (SHOULD FAIL) I-BUG-14a: Records with named fields.  [limitations_and_bugs_test.dart]
  (setUpAll)                                                                 [d4rt_tester_test.dart]
  dart_overview coverage (setUpAll)                                          [d4rt_coverage_test.dart]

tom_d4rt_generator     (2):
  (setUpAll)                                                                 [d4rt_tester_test.dart]
  dart_overview coverage (setUpAll)                                          [d4rt_coverage_test.dart]
```

Breakdown:

- **2 × `I-BUG-14a` "SHOULD FAIL"** — same documented won't-fix
  marker as the prior baseline. Not a regression.
- **6 × `setUpAll` failures** — *new since 0503-2238*. Three
  projects each report two suite-level `setUpAll` failures
  (`d4rt_tester_test.dart` + `d4rt_coverage_test.dart`); the
  underlying cause is identical across all three. This is the
  regression.

## Captured-error sweep

Per-project D4 compile-failure blocks were extracted to
`<project>_d4_compile_error.log.txt`:

| File | Bytes | Content |
| --- | ---: | --- |
| `tom_ast_generator_d4_compile_error.log.txt` | 665 | `COMPILATION FAILED` block with `FutureOr<Object?>` vs `FutureOr<Object>` mismatch at `test_callback_types.b.dart:175:158` |
| `tom_d4rt_exec_d4_compile_error.log.txt` | 665 | identical block |
| `tom_d4rt_generator_d4_compile_error.log.txt` | 643 | identical block surfaced via `BRIDGE ERRORS: [Failed to compile test runner: …]` |

All three projects fail the *same* compile in the *same* generated
file at the *same* line. They share that generated file because
they each carry a copy of the `example/d4` bridge bundle (built
by `tom_d4rt_generator`) and use it as a `setUpAll` smoke test.

The compile error itself is generator-emitted code in
`test_callback_types.b.dart`:

```dart
return t.withConnection(((dynamic p0) {
  return D4.castCallbackResult<FutureOr<Object?>>(
    D4.callInterpreterCallback(visitor!, callbackRaw, [p0]));
}) as FutureOr<Object?> Function(dynamic));
```

The source signature is non-nullable:

```dart
// example/d4/lib/test_callback_types.dart:57
Future<String> withConnection(
  FutureOr<Object> Function(dynamic connection) callback,
) async { ... }
```

The generator emits `FutureOr<Object?>` for both the callback's
return-type and the outer `as Function(...)` cast where the
signature is `FutureOr<Object>`. The compiler correctly rejects
the resulting assignment. See `error_analysis.md` for the
diagnosed source commit and recommended fix shape.

## Verdict — regression introduced; pin and follow up separately

- 0 unrelated regressions: the deltas across `tom_d4rt_ast`,
  `tom_d4rt_dcli`, `tom_dcli_exec`, and `tom_d4rt` proper are
  clean.
- 1 generator regression with three downstream symptoms: 6 new
  `setUpAll` failures concentrated in the three projects that
  smoke-test the `example/d4` bridge bundle. Root cause is the
  generator emitting `FutureOr<Object?>` where the source declares
  `FutureOr<Object>`.
- Outside the regression, the `0502 → now` improvement
  (−44 failures / −6 errors) is preserved.

This baseline is **not green**. Treat as the new "before" for the
follow-up generator fix; do not regenerate downstream bridges
until the `FutureOr` nullability emission is corrected, otherwise
the flutter-script bundles risk inheriting the same defect.

## Files in this directory

| File | What it is |
| --- | --- |
| `_baseline_id.txt` | Just the baseline ID string. |
| `_revision.txt` | Git SHA + branch at the time of the run. |
| `_timestamp.txt` | Wall-clock timestamp. |
| `_regen_bridges.log.txt` | Output from `tool/regenerate_bridges.dart`. |
| `_progress.txt` | Per-suite completion markers (one line per suite). |
| `_summarize.dart` | Result.json → totals table. Re-runnable. |
| `_summary.md` | Latest table generated by `_summarize.dart`. |
| `_failures.dart` | Result.json → per-project failure list. Re-runnable. |
| `_failures.md` | Latest list generated by `_failures.dart`. |
| `error_analysis.md` | Failure / error analysis summary. |
| `<project>.result.json` | Raw `dart test` JSON file-reporter output. |
| `<project>.log.txt` | tee'd console output for human inspection. |
| `<project>_d4_compile_error.log.txt` | Extracted compile-failure block (only present for the three regressing projects). |

## How to compare a future run

```bash
cd doc/testlog_<new-id>
dart run _summarize.dart > _summary.md
dart run _failures.dart > _failures.md
diff _summary.md ../testlog_20260518-1357-post-cluster-fixes-rebaseline/_summary.md
diff _failures.md ../testlog_20260518-1357-post-cluster-fixes-rebaseline/_failures.md
```
