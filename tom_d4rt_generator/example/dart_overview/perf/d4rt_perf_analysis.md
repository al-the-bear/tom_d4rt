# D4rt Interpreter Performance Bottleneck Analysis

**Date:** 2026-06-09
**Interpreter:** `tom_d4rt` (analyzer-based reference interpreter)
**Method:** sampling CPU profiler (`vm_service.getCpuSamples`) over the perf
benchmark corpus; see [`README.md`](README.md) for how to reproduce.
**Raw data:** [`results/cpu_profile_latest.txt`](results/cpu_profile_latest.txt)

> All numbers below come from a profile-mode run on macOS (Apple Silicon),
> `dart` stable, full-suite budget 1500 ms/benchmark, 165 121 CPU samples. The
> profiler aggregates samples by function; *exclusive* = self ticks (CPU spent
> in that function's own body), *inclusive* = self + callees.

## TL;DR

Four bottlenecks, in priority order:

| # | Bottleneck | Evidence | Fix cost | Expected win |
|---|------------|----------|----------|--------------|
| 1 | **`ErrorReporter` O(n) exception tracking** | `_GrowableList.remove` **62.7%** + `LinkedHashMap.remove` **6.9%** exclusive | Low | Huge (exception/macro workloads) |
| 2 | **`return` implemented as a thrown `ReturnException` unwinding through `finally`** | `StackTrace.current` **20.9%** on call-heavy code | Medium | Large (all function-call code) |
| 3 | **Eager debug-string construction regardless of debug flag** | `_concatAll` + `_interpolate` + `_AbstractType.toString` + `_Smi.toString` ≈ **15–20%** combined | Low | Medium (all returns / hot logs) |
| 4 | **`Environment.get` linear scope-chain lookup** | `Environment.get` **23.5%** exclusive on call-heavy code | Medium | Medium |

The headline number — **~70% of all CPU in two `.remove()` calls** — is a
single, fixable design flaw, not a fundamental interpreter limitation.

## Throughput baseline

ns/op = nanoseconds per inner-loop operation (lower is better).

| Benchmark | ns/op | Notes |
|-----------|------:|-------|
| string_interp | 18 515 | |
| arithmetic | 27 954 | |
| closures | 53 281 | |
| method_dispatch | 56 630 | |
| pattern_switch | 113 018 | |
| exceptions | 51 739 | try/catch/throw |
| map_ops | 424 955 | |
| polymorphism | 1 082 947 | virtual + `super` dispatch |
| **list_ops** | **4 546 913** | ~4.5 µs **per list operation** |
| recursion_fib | 229 340 208 | per `fib(24)` call tree |
| wrap_collections | 437 673 640 | macro: whole `collections` area ×25 |
| wrap_classes | 832 909 400 | macro: whole `classes` area ×25 |

`list_ops` and the macro wrappers are the slow outliers — and they are exactly
the workloads that construct the most internal `D4rtException`s (see Bottleneck
1), which is not a coincidence.

---

## Bottleneck 1 — `ErrorReporter` O(n) exception tracking (≈70% of CPU)

### Evidence

```
   ticks     pct  function
  103561   62.7%  _GrowableList.remove
   11430    6.9%  __Map&...&_LinkedHashMapMixin.remove
    6704    4.1%  StackTrace.current
```

A prior, shorter run showed `_GrowableList.remove` at 48.5%; the longer run
pushed it to **62.7%**. That the cost *grows with run length* is the signature
of an O(n) operation over an unbounded, accumulating collection.

### Root cause

`tom_d4rt/lib/src/exceptions.dart`:

```dart
class ErrorReporter {
  static final List<D4rtException> _errors = [];                 // <-- List
  static final Map<D4rtException, StackTrace> _stackTraces = {};
  static bool _trackingEnabled = true;                           // <-- ON by default

  static void reportError(D4rtException error, [StackTrace? st]) {
    if (_trackingEnabled) {
      _errors.add(error);
      _stackTraces[error] = st ?? StackTrace.current;            // <-- captures a stack trace
    }
  }

  static bool revokeError(D4rtException error) {
    _stackTraces.remove(error);                                  // <-- LinkedHashMap.remove (6.9%)
    return _errors.remove(error);                                // <-- O(n) List.remove (62.7%)
  }
}

abstract class D4rtException implements Exception {
  D4rtException(this.message) {
    ErrorReporter.reportError(this);                             // <-- EVERY D4rtException
  }
}
```

The interpreter constructs `D4rtException` subclasses **as part of normal
operation**, not just on real errors — e.g. `RuntimeD4rtException` thrown and
caught during type-check fallbacks, no-such-method probing, speculative
parsing, etc. Each construction:

1. **`_errors.add(this)`** — O(1), but the list never shrinks unless every
   error is later revoked.
2. **`_stackTraces[this] = StackTrace.current`** — materializes a full stack
   trace (the `StackTrace.current` 4.1% line, higher in shorter runs).

When the exception is caught and handled, `revoke()` calls:

3. **`_errors.remove(this)`** — a **linear scan** of the entire accumulated
   list. As more exceptions are reported across a run, `n` grows and every
   revoke gets slower → **O(n²)** aggregate. This is the 62.7%.
4. **`_stackTraces.remove(this)`** — `LinkedHashMap.remove` keyed by the
   exception object's identity hash (6.9%).

### Recommendation

Two independent fixes, both low-risk:

- **Use an identity `Set` for `_errors`** so `revokeError` is O(1):
  ```dart
  static final Set<D4rtException> _errors = Identity HashSet();
  ```
  `revokeError` becomes `_errors.remove(error)` on a set (O(1)) and the
  `_stackTraces` map can be dropped entirely if the stack trace is stored on the
  exception instance instead. This alone removes ~70% of profiled CPU on
  exception-heavy and macro workloads.

- **Default `_trackingEnabled` to `false`** (opt-in for test mode). The class
  doc says it is "used primarily in test modes"; paying `StackTrace.current` +
  collection bookkeeping on every exception in production/perf is pure overhead.
  Gate it behind the same debug/test flag the rest of the interpreter uses, and
  have the test harness enable it explicitly.

> **Cross-package note:** per the quest's "keep tom_d4rt ↔ tom_d4rt_ast in
> sync" rule, the same change must land in
> `tom_d4rt_ast/lib/src/runtime/exceptions.dart` (or its equivalent). Verify
> via the cluster-fix protocol (gii + essential + important + secondary)
> before committing.

---

## Bottleneck 2 — `return` as a thrown exception unwinding through `finally`

### Evidence (call-heavy subset: `recursion_fib` + `method_dispatch`)

```
   ticks     pct  function
    3061   23.5%  Environment.get
    2719   20.9%  StackTrace.current
    2471   19.0%  InterpreterVisitor.visitReturnStatement
```

With exception-heavy benchmarks excluded, `StackTrace.current` is still
**20.9%** — and it pairs with `visitReturnStatement` (94% inclusive on this
subset).

### Root cause

Every `return` is implemented by **throwing** a `ReturnException`
(`interpreter_visitor.dart:6826`), caught in `InterpretedFunction._callImpl`
(`callable.dart:1345/1370/1381`). The exception object itself is `const` (no
stack capture), but it unwinds through `executeBlock`'s `try { … } finally { … }`
(`interpreter_visitor.dart:125-155`) and the function-call `try/finally`
layers. When the Dart VM unwinds an exception through a `finally` block, it
**materializes the stack trace** so propagation can resume after the `finally`
runs. With `return` ≡ throw, *every function call pays a stack-trace
materialization on the way out.*

### Recommendation

Avoid exception-based unwinding for the common `return` case. Options, roughly
ascending in effort:

- Have `executeBlock` / statement visitors return a small sentinel
  (`_ReturnSignal(value)`) that callers check, instead of throwing — reserving
  exceptions for genuinely exceptional control flow. The inclusive trace shows
  `executeBlock` is already on every call path, so threading a return-signal
  through it is localized.
- If exception-based return must stay, ensure no `finally` sits between the
  throw and the catch on the hot path (move env restoration to explicit
  save/restore around the catch rather than in a `finally`).

This is a deeper change; it should be its own task with full regression
coverage. It is the single biggest win for *pure computation* code (recursion,
arithmetic-in-functions, method dispatch).

---

## Bottleneck 3 — Eager debug-string construction (≈15–20%)

### Evidence

```
    4912    3.0%  _OneByteString._concatAll
    4453    2.7%  _StringBase._interpolate
    3919    2.4%  _AbstractType.toString
     743    0.4%  _Smi.toString
```

On the call-heavy subset these are even larger (8.8% + 4.1% + 6.0% + 1.0%).

### Root cause

`visitReturnStatement` (`interpreter_visitor.dart:6722-6750`) builds
`declaredTypeDetails` and `valueRuntimeTypeDetails` — full interpolated strings
including `hashCode`, `nativeType.hashCode` and type `toString()` — **before**
passing them to `Logger.debug(...)`. Those strings are constructed
unconditionally on every return, then discarded when debug logging is off
(the default). This is the classic "eager log-argument evaluation" anti-pattern.

### Recommendation

- Guard the string construction behind the debug check, or pass a closure /
  use lazy logging so the interpolation only runs when the log will actually be
  emitted:
  ```dart
  if (Logger.isDebug) {
    Logger.debug('[visitReturnStatement] Declared Type: ${_describe(declaredType)}');
  }
  ```
- Audit other hot visitors (`visitMethodInvocation`, `visitBinaryExpression`)
  for the same pattern. `Logger.log` itself only shows 0.3–0.9%, so the cost is
  almost entirely the *argument* construction, not the logging call.

Low-risk, mechanical, and independently shippable from Bottlenecks 1 & 2.

---

## Bottleneck 4 — `Environment.get` linear scope-chain lookup (≈5–24%)

### Evidence

`Environment.get` is **4.8%** exclusive over the full suite and **23.5%** on
the call-heavy subset, plus it appears at **52.6% inclusive** on that subset.

### Root cause

`Environment.get` (`environment.dart`) resolves a name by walking the
enclosing-environment chain, doing a map lookup at each level until found. The
interpreter creates a fresh `Environment` per block and per loop iteration (see
`_executeClassicFor` allocating an `iterEnv`/`updateEnv` per iteration), so the
chain a lookup must traverse can be several levels deep, and the per-iteration
allocation adds GC pressure. `visitReturnStatement` additionally does an extra
`environment.get(functionName)` lookup on every return (Bottleneck 2's code),
compounding this.

### Recommendation

- **Resolve variable slots at parse/declaration time** (a "resolver" pass that
  annotates each identifier with its scope depth + slot index), turning
  `Environment.get` from an O(depth) chained map lookup into an O(1) indexed
  array access. This is the standard interpreter optimization (cf. Crafting
  Interpreters' resolver) and the highest-leverage structural change.
- Cheaper interim: avoid the redundant `environment.get(functionName)` in
  `visitReturnStatement` by using `currentFunction` directly (the code already
  falls back to it), and reuse loop environments where no closure captures them.

---

## Suggested sequencing

1. **Bottleneck 1** (ErrorReporter Set + default-off tracking) — biggest win,
   lowest risk, mechanical. Do this first.
2. **Bottleneck 3** (lazy debug strings) — mechanical, independent, ship next.
3. **Bottleneck 4** interim (drop redundant return lookup) — small, safe.
4. **Bottleneck 2** (non-exception return) and **Bottleneck 4** full (slot
   resolver) — larger structural changes, each its own task with full
   regression coverage and tom_d4rt ↔ tom_d4rt_ast mirroring.

After each fix, re-run `test/perf/run_profile.sh` and diff the exclusive table
against `results/cpu_profile_latest.txt` to confirm the targeted line dropped
and no new hot spot emerged.
