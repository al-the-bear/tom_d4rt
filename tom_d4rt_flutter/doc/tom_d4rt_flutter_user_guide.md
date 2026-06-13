# tom_d4rt_flutter — User Guide

`tom_d4rt_flutter` renders interpreted Dart UI against **real Flutter
widgets**. It wraps the analyzer-based `tom_d4rt` interpreter with the full
generated Flutter Material bridge surface and the hand-written runtime
registrations (interface proxies, type relaxers, generic-constructor
factories) needed to make script-defined widgets behave like native ones.
Feed it raw Dart source, get back a live `Widget`.

This is the **authoritative Flutter-runtime guide**. Its AST sibling
`tom_d4rt_flutter_ast` (class `FlutterD4rt`) is documented differences-only
against this guide — it runs the same corpus from pre-compiled `AstBundle`s
with no analyzer and a web-compatible footprint.

> **Related guides**
> - Language semantics, supported Dart subset, bridging model →
>   [`tom_d4rt/doc/d4rt_user_guide.md`](../../tom_d4rt/doc/d4rt_user_guide.md).
> - The extension-hook contract (`registerExtensions` / `finalizeBridges`) →
>   [`tom_d4rt_ast/doc/extension_registration.md`](../../tom_d4rt_ast/doc/extension_registration.md).
> - The full Flutter-runtime limits / workarounds catalogue →
>   [`tom_d4rt_flutter_limitations.md`](tom_d4rt_flutter_limitations.md)
>   and the canonical
>   [`tom_d4rt/doc/d4rt_limitations.md`](../../tom_d4rt/doc/d4rt_limitations.md).

This package declares `publish_to: 'none'` — it lives inside the D4rt
monorepo and is consumed via path dependency by the demo/test application
(`tom_d4rt_flutter_test`) and the HTTP conformance harness.

---

## 1. Quick start

```dart
import 'package:flutter/widgets.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

final runner = SourceFlutterD4rt();

const source = '''
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return const Center(child: Text('Hello from D4rt'));
}
''';

// Inside a build method, with a real BuildContext:
Widget render(BuildContext context) => runner.build<Widget>(source, context);
```

`SourceFlutterD4rt()` constructs a fresh `tom_d4rt` interpreter, registers
the entire bridge surface, and calls `finalizeBridges()` — so the returned
runner is ready to evaluate scripts immediately. Construction is the
expensive step; reuse a single runner across many `build` calls where you
can (see [§5 Performance & GC](#5-performance--gc)).

---

## 2. The `SourceFlutterD4rt` runner

`SourceFlutterD4rt` is the single public entry point. It is the source-based
parallel of `FlutterD4rt` in `tom_d4rt_flutter_ast`: same corpus, same
rendered output, but it accepts raw Dart source strings rather than
pre-compiled `AstBundle`s — so scripts load straight from disk with no
offline compile step.

| Constructor | Use |
|-------------|-----|
| `SourceFlutterD4rt()` | Fresh interpreter with all bridges registered (the common case). |
| `SourceFlutterD4rt.withInterpreter(D4rt)` | Reuse an existing `D4rt` instance — for tests that pre-seed the runner or share an interpreter across calls. |

`interpreter` exposes the underlying `D4rt` for advanced inspection (reading
the environment directly in tests).

### Execution entry points

All four methods are generic in the return type `T` and route the raw
interpreter result through `D4.unwrapAs<T>` so callers receive a **native
`T`** (e.g. a real `Widget`) rather than an interpreter-internal
`BridgedInstance`. A value that cannot be unwrapped to `T` surfaces as a
`SourceFlutterD4rtException`.

| Method | Calls | Notes |
|--------|-------|-------|
| `build<T>(source, [context])` | the function named `build` | Passes `context` as the first positional arg when provided. The shape every corpus script follows. |
| `buildMultiFile<T>(mainFilePath, {buildContext})` | `build` of a multi-file program | Resolves relative imports off disk, then interprets. **Desktop only** — reads the filesystem. |
| `buildProgram<T>(program, {buildContext})` | `build` of a resolved program | Platform-neutral core: the `SampleProgram.sources` map already holds every transitively-imported file, so the interpreter does **no** I/O (`allowFileSystemImports: false`). The asset path (iOS/iPadOS/Android) uses this. |
| `execute<T>(source, {name, positionalArgs, namedArgs})` | an arbitrary function | Generic escape hatch — call any top-level function by `name`, not just `build`. |

`resetScript()` forwards to `D4rt.resetScriptDeclarations()`, evicting
script-declared globals so a follower `build`/`execute` starts from the same
name-set the last run produced. It exists for parity with the AST app's
`/clear` contract; on the analyzer-based path it is effectively a no-op
because each `execute*` already builds a fresh `ModuleLoader` (see the
caveat in `D4rt.resetScriptDeclarations`).

---

## 3. Multi-file programs

Sample apps whose logic spans more than one file are loaded as a
`SampleProgram` — a fully-resolved bundle of `{ libraryUri → source }`
covering the entry point and every transitive relative import:

```dart
// Desktop: resolve relative imports off disk and render.
final widget = runner.buildMultiFile<Widget>(
  '/path/to/example/counter_app/main.dart',
  buildContext: context,
);

// Platform-neutral: pre-resolved program (no filesystem access).
final program = SampleProgram(
  libraryUri: 'main.dart',
  basePath: '',
  sources: {
    'main.dart': mainSrc,
    'counter.dart': counterSrc,
  },
);
final widget2 = runner.buildProgram<Widget>(program, buildContext: context);
```

The platform split is handled by `createSampleSource()`, which returns a
`DiskSampleSource` on desktop and an `AssetSampleSource` on mobile
(`package:`/`dart:` imports are left to the bridge layer either way).
`buildDiskProgram(mainFilePath)` is the disk resolver that `buildMultiFile`
calls internally; you can call it directly to inspect the resolved
`sources` map before interpreting.

---

## 4. Extension registration

The bridge surface is assembled in one place — the runner's private
`_registerBridges()`, called from both constructors — in a fixed order that
the `tom_d4rt_ast` extension-hook contract enforces:

```dart
void _registerBridges() {
  registerRelaxers();                 // $Relaxed* generic-wrapper factories
  registerD4rtRuntimeExtensions();    // interface proxies, coercions, RC-2 factories
  FlutterMaterialBridges.register(_interpreter); // the generated *.b.dart surface
  _interpreter.registerExtensions(    // queued — fires once at finalize
    'tom_d4rt_flutter',
    registerD4rtInterfaceProxyOverrides,
  );
  _interpreter.finalizeBridges();     // runs the queued callback, in order
}
```

Two registration styles co-exist:

- **Eager top-level calls** (`registerRelaxers`,
  `registerD4rtRuntimeExtensions`) populate the **process-global** static
  tables on the `D4` class (`D4._interfaceProxies`,
  `D4._genericTypeWrappers`, …). They are idempotent: constructing more than
  one `SourceFlutterD4rt` in an isolate is safe as long as the tables don't
  drift.
- **The deferred `registerExtensions(name, callback)` hook** queues a
  callback that fires exactly once, in registration order, when
  `finalizeBridges()` runs. This replaces the old "must run *after* bridges"
  comment convention with an enforced contract — overrides that must see the
  fully-built bridge surface (the interface-proxy overrides here) go through
  this hook. See
  [`tom_d4rt_ast/doc/extension_registration.md`](../../tom_d4rt_ast/doc/extension_registration.md)
  for the full contract.

The hand-written registrations live in
[`d4rt_runtime_registrations.dart`](../lib/src/d4rt_runtime_registrations.dart)
and the `d4rt_user_bridges/` overrides; the generated adapters are the
`lib/src/bridges/*.b.dart` files. **Never hand-edit the generated files** —
fix the generator (`tom_d4rt_generator`) or `buildkit.yaml` and regenerate
with `dart run tool/regenerate_bridges.dart`.

---

## 5. Performance & GC

- **Construction is the cost.** `SourceFlutterD4rt()` registers the full
  Material bridge surface and finalizes it. Prefer one long-lived runner
  over per-frame construction; the global registration tables make repeated
  construction safe but not free.
- **Rendering is per-`build`.** Each `build`/`buildProgram` re-interprets
  the script from source — there is no AST cache on this (source) path. For
  hot paths that re-run an identical script, hoist the work or move to the
  AST sibling (`tom_d4rt_flutter_ast`), whose pre-compiled `AstBundle`
  skips the parse step.
- **Long-lived interpreted state retains native objects.** Interpreted
  `State` subclasses hold their native proxy (`_InterpretedState`,
  `_InterpretedTickerProviderState`, …) for their whole lifetime; tickers
  and controllers created with `vsync: this` are disposed by the native
  proxy's `dispose()`. Scripts that leak controllers leak the same way they
  would in native Flutter — the bridge does not add a GC layer. Between
  conformance runs the host app drives `/clear` (→ `resetScript()`) to drop
  script-declared globals.

### 5.1 High-frequency loops and the major-GC freeze

A script that drives a **high-frequency loop** — a per-frame simulation step,
a particle/cellular-automaton update, a tight `while` — can stall the whole UI
for **multiple seconds** at a time. The stall is a Dart **stop-the-world major
(old-generation) GC**, not a bridge defect. Interpretation allocates far more
short-lived objects per unit of work than compiled Dart (every evaluated
expression mints AST-walk temporaries; every call frame mints an
`Environment`), so a fast loop promotes enough survivors into the old
generation to trigger a costly collection.

The governing relation is:

```text
allocation_rate = garbage_per_step × steps_per_second
```

> **Counter-intuitive corollary.** The compiled-Dart instinct that "fewer,
> tighter steps = less garbage" *inverts* under the interpreter. A rewrite that
> cuts native allocations but removes an accidental cadence cap (e.g. an
> implicit frame-rate governor) raises `steps_per_second`, raising the
> allocation rate, and hits the freeze **sooner** — in one measured
> particle-field case ≈12× sooner (≈4–5 s vs ≈60 s) than the "less optimal"
> original. Reason about loop-iteration count and per-iteration `Environment`
> minting, not native allocation counts.

This is the interpreter-level limitation
[`tom_d4rt/doc/d4rt_limitations.md` → Lim-10](../../tom_d4rt/doc/d4rt_limitations.md#lim-10-per-step-allocation-rate-drives-major-gc).
Two independent levers mitigate it; use them together for smooth high-frequency
simulations.

#### Lever 1 — cap the cadence (fixed-timestep governor)

Decouple simulation cadence from frame cadence with a fixed-timestep
accumulator: bank elapsed wall-clock time and drain it in fixed quanta, with a
small catch-up cap as a spiral-of-death guard. This bounds `steps_per_second`
regardless of how fast frames arrive. The optimized samples use a 20 Hz step
(`kStepDt = 0.05 s`) and a 4-step catch-up cap:

```dart
static const double kStepDt = 0.05;        // 20 Hz simulation tick
static const int _kMaxCatchUpSteps = 4;    // spiral-of-death guard

void _onFrame(Duration elapsed) {
  if (paused.value) return;
  final nowUs = elapsed.inMicroseconds;
  if (_lastElapsedUs == 0) { _lastElapsedUs = nowUs; return; }
  final dtUs = nowUs - _lastElapsedUs;
  _lastElapsedUs = nowUs;
  var frameS = dtUs / 1000000.0;
  if (frameS <= 0.0) return;
  // Clamp one frame so a long pause can't queue an unbounded burst of steps.
  if (frameS > _kMaxCatchUpSteps * kStepDt) frameS = _kMaxCatchUpSteps * kStepDt;
  _simAccumS += frameS;
  var steps = 0;
  while (_simAccumS >= kStepDt && steps < _kMaxCatchUpSteps) {
    field.value = stepField(field.value, kStepDt);
    _simAccumS -= kStepDt;
    steps++;
  }
}
```

Full sample:
`tom_d4rt_flutter_test/example/particle_field_optimized/field_controller.dart`.

#### Lever 2 — cap the Dart old-gen heap (engine switch)

Limiting the Dart old generation keeps collections **short and frequent**
instead of **rare and catastrophic**. Set the `old-gen-heap-size` Flutter
engine switch (which forwards to the VM flag `--old_gen_heap_size=<MB>`) via the
generic engine-switch environment protocol:

```bash
FLUTTER_ENGINE_SWITCHES=1 \
FLUTTER_ENGINE_SWITCH_1="old-gen-heap-size=256" \
flutter run --release
```

- Caps the Dart **old generation** (≈256 MB confirmed effective for the
  particle-field case), **not** process RSS.
- Works in **release** builds, not just debug.
- Combine with Lever 1: the governor keeps the allocation rate bounded; the
  heap cap keeps each collection cheap.

---

## 6. Known limits & workarounds

The Flutter bridge surface is broad but not total. The full catalogue —
with error messages, root-cause analysis, and per-case script workarounds —
is in
[`tom_d4rt_flutter_limitations.md`](tom_d4rt_flutter_limitations.md);
interpreter-level language limits live in the canonical
[`tom_d4rt/doc/d4rt_limitations.md`](../../tom_d4rt/doc/d4rt_limitations.md).
The headline cases a script author hits most often:

| # | Limit | Script workaround |
|---|-------|-------------------|
| 1 | `SingleTickerProviderStateMixin` / ticker mixins | Use the supported animation patterns; the `_InterpretedTickerProviderState` proxy covers the common single-ticker case. |
| 2 | Enum exhaustiveness in `switch` | Always add a `default:` / `_` wildcard arm. |
| 3 | Sealed-class exhaustiveness | Same — add a default/wildcard arm. |
| 4 | `SystemColor` on Linux/embedded | Wrap access in `try/catch` and fall back. |
| 5 | Abstract-class inheritance (`widget`/`context`/`mounted`) | Handled by adapter proxies + property interceptors (RC-9) — no script change for the common case. |
| 6 | Real Dart isolates (`Isolate.spawn`, `IsolateNameServer`) | **Won't fix** — single-isolate sandbox. Avoid cross-isolate APIs. |
| 7 | `FragmentProgram.fromAsset` hangs on missing asset (Linux) | Race the call against a short `Future.delayed` timeout. |
| 8 | `Actions`/`Intent` type-keyed dispatch for user Intents | Call `action.invoke(intent, context)` directly; SDK Intent types work as-is. |

---

## 7. Testing & samples

The bridge-conformance suite under `test/` drives a Flutter HTTP harness app
over HTTP: each test POSTs raw Dart source to `/build` and asserts on the
rendered widget, captured `print()` output, and framework errors. The test
scripts are the **shared corpus** with the AST sibling, so the source-based
and AST-based suites run identical scripts app-for-app.

> **All HTTP-harness tests share one local server — run them serially.**
> Never launch multiple `flutter test` invocations in parallel in this
> package; concurrent runs corrupt the shared server's results. Chain runs
> with `&&` or issue sequential commands.

```bash
flutter test test/essential_classes_test.dart \
  && flutter test test/important_classes_test.dart
```

The 33 multi-file example apps live in the companion **`tom_d4rt_flutter_test`**
project (`tom_d4rt_flutter_test/example/`) and are mirrored in
`tom_d4rt_flutter_ast_test/example/` so the source-direct and AST paths can
be compared app-for-app. See the `tom_d4rt_flutter` README "Example
applications" section for the full list and the run instructions.
