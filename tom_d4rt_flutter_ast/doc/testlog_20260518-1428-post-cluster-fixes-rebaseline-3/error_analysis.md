# Error analysis — `20260518-1428-post-cluster-fixes-rebaseline-3`

Third same-day rebaseline against the same HEAD (`0fc468d4`
differs from `40b8ac30` only in the three testlog folders that
documented the prior runs of this same prompt — no code under test
has changed).

Result is bit-identical to both prior same-day runs:
8 failures total, same identity, same compile-error blocks at the
same source location. Full diagnosis lives at:

- [`../testlog_20260518-1357-post-cluster-fixes-rebaseline/error_analysis.md`](../testlog_20260518-1357-post-cluster-fixes-rebaseline/error_analysis.md)

## Quick summary

| Bucket | Count | Status |
|---|---:|---|
| `I-BUG-14a` "SHOULD FAIL" (records with named fields) | 2 | Pre-existing won't-fix. |
| `setUpAll` compile failures in `example/d4` smoke tests | 6 | New since `0503-2238`. Generator emits `FutureOr<Object?>` where source declares `FutureOr<Object>`. |

## Root cause (one-liner)

`tom_d4rt_generator` emits the cast

```dart
... as FutureOr<Object?> Function(dynamic)
```

for `CallbackTypeService.withConnection`'s parameter, whose source
declares `FutureOr<Object> Function(dynamic connection)`. The
generic-erasure path intended for
`GenericCallbackService.withConnection<T>` is being applied to the
non-generic overload too.

Suspect commit: `114f11f5 fix(d4rt): close C11 — self-import guard
+ nullable FutureOr callback returns`.

## No new captured errors beyond the 1357 set

Same dismissal as 1357/1415. No work to do here beyond what the
1357 analysis already proposes.
