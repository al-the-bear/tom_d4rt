# Relaxer / proxy / ctor usage logging

Opt-in instrumentation on `D4` that records which generated
**relaxer**, **interface-proxy**, **type-coercion**, and
**generic-constructor** cases a real script exercises at runtime — plus
the unresolved **misses**. The accumulated data is the empirical
"actually used" evidence that drives the mass-generation reduction work:
it shows which of the ~181k lines of combinatorial
`_relaxX$module` / `_rc2…` switch arms scripts ever hit, so the rest can
be pruned with confidence.

This is a **diagnostic feature only** — no config knob, no generator
change, no behavioural effect on script execution. Every instrumentation
call site is guarded so the log is completely silent and zero-overhead
when disabled.

## Enabling

The toggle is the process-global static field:

```dart
D4.usageLogEnabled = true;   // arm before running a script
D4.resetUsageLog();          // optional: start from a clean slate
```

On the analyzer-based VM twin (`tom_d4rt`) the `D4rt` facade additionally
auto-enables it from an environment variable when bridges are finalized:

```bash
D4RT_LOG_RELAXER_USAGE=1 dart run my_script.dart
# truthy values: 1, true, yes, on  (case-insensitive)
```

When enabled via the env var, the `D4rt` facade prints
`D4.usageLogSummary()` to stdout at the end of each `execute*` run. When
you flip `D4.usageLogEnabled` programmatically you own the reporting —
call `D4.usageLogSummary()` yourself.

### Twin divergence (deliberate)

`tom_d4rt_ast` is the web-capable twin and has **no `dart:io`**, so it
cannot read environment variables. There the flag is purely
programmatic; callers set `D4.usageLogEnabled = true` directly. The env
var convenience is the VM-only path — the one intentional divergence for
this feature. The recording logic itself is identical in both twins.

## What gets recorded

`extractBridgedArg<T>` and the interpreter's generic-constructor path
call into the log on each resolution. Records are keyed
`category|base|typeArg`:

| Category   | When | `base` | `typeArg` |
|------------|------|--------|-----------|
| `relaxer`  | a generic-wrapper factory resolved the arg (GEN-079 / RC-6b) | target base type | inner type-argument |
| `proxy`    | an interface proxy was created for an interpreted instance | target base type | the instance's class name |
| `coercion` | an RC-3 cross-package type coercion succeeded | target base type | source runtime type |
| `ctor`     | a registered generic constructor (RC-2) produced a native object | bridged class name | joined evaluated type-arguments |
| `miss`     | nothing resolved the arg — recorded just before the throw | target base type | inner type-argument |

Misses are kept under their own `miss|base|typeArg` key space (queried
via `D4.usageMisses`).

## API surface

| Member | Purpose |
|--------|---------|
| `D4.usageLogEnabled` | the opt-in toggle (default `false`) |
| `D4.recordUsageHit(category, base, typeArg)` | record a hit (no-op when off) |
| `D4.recordUsageMiss(base, typeArg)` | record a miss (no-op when off) |
| `D4.usageHits` / `D4.usageMisses` | unmodifiable snapshots, keyed `category\|base\|typeArg` |
| `D4.usageHitCount` / `D4.usageMissCount` | aggregate event totals |
| `D4.usageLogSummary()` | human-readable end-of-run summary, sorted by descending count |
| `D4.resetUsageLog()` | clear all accumulated data |

## Example summary

```
=== D4 relaxer/proxy/ctor usage log ===
Hits: 3 event(s), 2 distinct
  2× relaxer|List|Color
  1× proxy|CustomPainter|P
Misses: 1 event(s), 1 distinct
  1× miss|CustomClipper|Path
```

## Tests

- `tom_d4rt_ast/test/runtime/usage_log_test.dart` and
  `tom_d4rt/test/bridge/usage_log_test.dart` — recording API contract
  (hit keys, miss keys, aggregation, summary formatting, reset,
  silence-when-off, unmodifiable snapshots).
- `tom_d4rt/test/bridge/usage_log_runner_test.dart` — integration: a
  script run through `D4rt.execute` with logging enabled records a `ctor`
  hit and the summary reflects it.

## Source

- VM twin: `tom_d4rt/lib/src/generator/d4.dart` (API + relaxer/proxy/
  coercion/miss sites), `tom_d4rt/lib/src/interpreter_visitor.dart` (two
  `ctor` sites), `tom_d4rt/lib/src/d4rt_base.dart` (env-var auto-enable +
  end-of-run print).
- Web twin: `tom_d4rt_ast/lib/src/runtime/generator/d4.dart` and
  `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` (identical
  recording logic; no env-var path).
