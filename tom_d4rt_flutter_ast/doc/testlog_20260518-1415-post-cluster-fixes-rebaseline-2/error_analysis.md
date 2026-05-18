# Error analysis — `20260518-1415-post-cluster-fixes-rebaseline-2`

This run was a reproducibility check of the same-day
`testlog_20260518-1357-post-cluster-fixes-rebaseline` against the
same HEAD (`65677675` differs from `40b8ac30` only in the testlog
folder that documented 1357 itself — no code under test changed).

The result is bit-identical: same 8 failures, same totals, same
captured compile-error blocks at the same source location. See the
full diagnosis, suspect commit, blast-radius analysis, and
recommended fix shape in:

- [`../testlog_20260518-1357-post-cluster-fixes-rebaseline/error_analysis.md`](../testlog_20260518-1357-post-cluster-fixes-rebaseline/error_analysis.md)

## Quick summary of what's failing

| Bucket | Count | Status |
|---|---:|---|
| `I-BUG-14a` "SHOULD FAIL" (records with named fields) | 2 | Pre-existing won't-fix, mounted twice (tom_d4rt + tom_d4rt_exec share `limitations_and_bugs_test.dart`). |
| `setUpAll` compile failures in `example/d4` smoke tests | 6 | New since `0503-2238`. Same generator-emission bug at `test_callback_types.b.dart:175:158`. |

## Root cause (one-liner)

`tom_d4rt_generator` emits

```dart
... as FutureOr<Object?> Function(dynamic))
```

for a callback parameter whose source declares
`FutureOr<Object> Function(dynamic)`. The non-generic overload of
`CallbackTypeService.withConnection` gets the same generic-erasure
treatment as the generic `GenericCallbackService.withConnection<T>`,
but should not.

Suspect commit: `114f11f5 fix(d4rt): close C11 — self-import guard
+ nullable FutureOr callback returns` (the only post-baseline
`tom_d4rt_generator/lib/` change matching the shape).

## No new captured errors beyond the 1357 set

`grep`ed for `Runtime Error:`, `Bridge generation failed`,
`COMPILATION FAILED`, and `Exception` across all seven
`<project>.log.txt`. Only hits resolve to the eight reported
failures plus the two intentional `print('Skipping HTTP request
test: …')` lines — same baseline as 1357 and 0503-2238.
