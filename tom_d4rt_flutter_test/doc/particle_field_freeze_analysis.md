# Interpreter per-rebuild GC freeze — root-cause analysis

_(originally diagnosed on `particle_field`; the same root cause and
mitigation were since confirmed on Conway's Life — see "Second
reproduction" below.)_

## Symptom (user report)

Running the `particle_field` D4rt sample and switching modes
(attract / repel / orbit) a few times causes the macOS app to freeze after
~1 minute. Each freeze lasts 30s–1m (dead app, wait cursor), then the app
recovers and re-freezes. The user suspected a GC pause from excessive garbage.

## Reproduction harness

`test/particle_field_navigation_leak_test.dart` →
`single-mount particle_field: per-frame build time stays bounded`.

It mounts the sample once and drives 2400 pumped frames (~40s at 60fps) with
periodic mode switches and canvas taps, recording per-pump: wall-clock pump
time, `ProcessInfo.currentRss`, and the `D4rtDiag` interpreter counters
(call volume, recursion depth, and per-type allocation counts).

## What the data shows

Per interpreted ~30-widget rebuild (steady state, after the primitive-wrapper
fix below):

| Counter | Per frame |
| --- | --- |
| interpreted calls | ~655 |
| max call depth | 5 |
| `Environment` allocations | ~1400 |
| closures (`InterpretedFunction`) | ~661 |
| `InterpretedInstance` | ~23 |
| `BridgedInstance` | ~760 (was ~2000) |

Decisive observations:

1. **Slow frames carry identical work.** The 11–17s pumps (frames ~916/920/923)
   execute the *same* 655 calls / depth-5 / ~1400 env / ~760 bridged as the
   7ms fast frames. The freeze is therefore **not** extra interpreter work,
   deep recursion, an exception storm, or a value-dependent loop — it is pure
   garbage collection.
2. **RSS balloons then collapses.** During the slow frames RSS spikes to
   ~3GB, then the steady state returns to ~780MB. This is a stop-the-world
   **major (old-gen) GC** reclaiming accumulated promoted garbage.
3. **In this harness the freeze is one-time.** The major GC fires once around
   frame ~916 (a 3-frame thrash cluster) and never again across the remaining
   1500 frames (flat ~785MB). The mean pump also *decreases* 11.9ms→6.8ms over
   the run (JIT warmup). So the harness reproduces a single major GC once the
   warmup-phase garbage first crosses the old-gen threshold.
4. **The real app freezes recurringly** because continuous interaction
   (notably the `MouseRegion` `onHover` → `setState` → full interpreted
   rebuild on every mouse move) sustains a much higher allocation rate, so
   old-gen refills and the major GC repeats — matching the user's
   freeze / recover / refreeze report.

## Root cause

Interpreting a **full Flutter widget rebuild every frame** generates a large
volume of short-lived objects. Enough of them survive a young-gen scavenge
(the live scope chain + partially-built tree held across a mid-frame scavenge)
to be **promoted to old-gen**, where they become garbage that only a major GC
can reclaim. The VM defers the major GC until old-gen is large (~GBs), so when
it finally runs it is a multi-second stop-the-world pause. Under sustained
interaction it recurs.

## Fix landed so far

**Stop wrapping primitive operands in binary expressions**
(`interpreter_visitor.dart`, mirrored in tom_d4rt + tom_d4rt_ast).
`num`/`int`/`double`/`String`/`bool` all have direct-type stdlib bridges, so
binary-expression operand resolution minted a throwaway `BridgedInstance` for
every arithmetic / comparison / equality operand — only to immediately unwrap
it via `.nativeObject` (which equals the primitive). The fix short-circuits
those primitives and reuses the already-resolved left/right wrappers in the
bridged-operator block instead of re-calling `toBridgedInstance` three more
times.

Result: `BridgedInstance` allocations per frame **~2000 → ~760 (-62%)**, with
no test regression (tom_d4rt 1851 pass / 1 pre-existing Won't-Fix / 1 skip;
tom_d4rt_ast 162/162). This cuts young-gen scavenge pressure and lowers the
allocation rate that drives major-GC frequency in the real (sustained-load)
scenario. It did **not** shift the harness's one-time major GC, because the
primitive wrappers died young (immediate garbage) and were never the promoted
fraction.

## Mitigation: cap the Dart old-gen heap (verified, app-confirmed)

The freeze length is a function of *how large old-gen is allowed to grow*
before the major GC runs. Capping the Dart old generation forces the major
GC to fire early and often over a small heap, trading one multi-second
stop-the-world pause for many sub-second ones.

The VM flag is **`--old_gen_heap_size=<MB>`** (`0` = unlimited). Flutter
exposes it as the first-class **engine switch** `old-gen-heap-size`, which
the macOS embedder reads from environment variables at VM init:

```bash
cd tom_d4rt_flutter_test
FLUTTER_ENGINE_SWITCHES=1 \
FLUTTER_ENGINE_SWITCH_1="old-gen-heap-size=256" \
build/macos/Build/Products/Profile/tom_d4rt_flutterm_test.app/Contents/MacOS/tom_d4rt_flutterm_test
```

Verified facts (Flutter 3.41.9, macOS):

- **The env-var switch channel is honoured.** A disallowed entry aborts with
  `[FATAL:…switches.cc] Encountered disallowed Dart VM flag`; `old-gen-heap-size`
  is a real engine switch (not a `--dart-flags` allowlist item), so it is
  accepted directly and **also works in release** — unlike `--dart-flags` /
  `DART_VM_OPTIONS`, which the embedded engine ignores.
- **It caps Dart old-gen only, not process RSS.** The ~780 MB steady RSS in
  the analysis is dominated by the native Flutter/Skia side (~650 MB at idle
  before the sample even runs); the genuinely-live Dart set is far smaller, so
  the cap can sit well below 780 MB. Launch the inner executable directly (as
  above) so the env vars propagate — `open App.app` does **not** forward them.
- **User-confirmed.** `particle_field` ran smooth for 3+ minutes of mode
  switching at `old-gen-heap-size=256` with no visible freeze, confirming the
  freeze is purely GC. The cap must stay above the live floor or the app
  OOM-crashes; 256 MB held, 384–512 MB gives more headroom / fewer (slightly
  larger) collections.

This is the immediate, no-code-change mitigation. It is **option 4 below,
now verified** — a trade of pause *length* for pause *frequency*, not an
elimination of the garbage.

## Second reproduction: Conway's Life (R-pentomino) — same root cause

User report: Conway's Life with the R-pentomino preset gets *gradually*
slower from ~gen 60–70 and appears frozen by ~gen 194. The gradual onset
looked like it might be a different (algorithmic) problem.

Headless reproduction straight through the interpreter:
`tom_d4rt/test/_conway_perf_probe_test.dart` runs `stepLife` on the
R-pentomino for 220 generations, timing each generation and reading the
`D4rtDiag` allocation counters. Two clean conclusions:

1. **No algorithmic bug.** Time *per live cell* is flat (~700 µs/cell) across
   all 220 generations — it does **not** grow with population. The interpreter's
   `Set<Cell>` / `Map<Cell,int>` bucket correctly on the custom `hashCode`
   (O(1), not the O(n²) linear scan one might suspect). The gradual slowdown is
   simply **R-pentomino's natural population growth** — it is a methuselah that
   expands for ~1100 generations, and per-generation cost is linear in live-cell
   count (~0.7 ms/cell interpreted, so a few-hundred-cell board → hundreds of ms
   per step).
2. **The freeze is the same major-GC pause.** The step loop is an allocation
   firehose — per generation (steady state, growing with population):

   | Object | Total over 220 gens | Per generation |
   | --- | --- | --- |
   | `Environment` | 5,777,388 | ~26,261 |
   | closures (`InterpretedFunction`) | 2,589,641 | ~11,771 |
   | `BridgedInstance` | 1,324,333 | ~6,020 |
   | `InterpretedInstance` (`Cell`) | 140,119 | ~637 |

   ~10 million interpreter objects of garbage. That is **~18× the per-frame
   churn of `particle_field`** (~1,400 `Environment`/frame), so old-gen refills
   even faster → major GC → the gen-194 freeze. The same `old-gen-heap-size`
   cap mitigates it (more frequent but sub-second collections).

Note the two effects are independent: the cap fixes the *freeze* but not the
*gradual slowdown* — at high population the raw interpret cost (~0.7 ms/cell)
can still exceed the tick interval. That part needs the deeper interpreter
work (Environment/closure reuse) and/or the optimized-script rewrite below.

## Remaining work (deeper promotion fix)

The promoted live-set per frame is dominated by `Environment` (~1400) and
closures (~661). Candidate directions, in rough order of leverage / risk:

1. **Reduce per-frame `Environment` allocation** — reuse / skip a fresh
   `Environment` for blocks and loop bodies that declare no locals (the slot
   runtime in `environment.dart` is already moving this way). High leverage,
   touches scoping → needs the full flutterm verification suite.
2. **Avoid redundant closure re-minting** — cache method tear-offs / bound
   closures on the hot property-access path rather than allocating a fresh
   `InterpretedFunction` per access. Medium leverage.
3. **Reduce per-frame interpretation via the *script*, not a tree cache.**
   Caching the interpreted widget subtree inside `SourceFlutterD4rt` is **ruled
   out** — it would require the runner to reason about widget identity/equality
   across rebuilds, which is fragile and couples the interpreter to Flutter's
   diffing. Instead, **rewrite the sample scripts so the widget tree is built
   once and stays structurally identical across repaints**, and only a small
   listenable-driven leaf re-runs (see "Optimized-script rewrite plan" below).
   Highest leverage for the real app, achievable purely in script with no
   interpreter/runner change.
4. **VM old-gen tuning — DONE / verified** (see "Mitigation" above). Cap
   old-gen via the `old-gen-heap-size` engine switch so the major GC runs more
   often but far cheaper. A mitigation, not a fix; available wherever the
   embedder reads engine switches (it does on macOS).

Fully eliminating the recurring freeze most likely needs (1) and/or (3); (4)
is the immediate stopgap already in hand.

## Optimized-script rewrite plan (no tree caching)

**Principle.** Today every `setState` re-interprets the *entire* `build()`
method, so the per-frame interpreter churn (thousands of `Environment`s /
closures) scales with the whole widget tree. If we instead **separate the
static widget tree from the mutable state**, the tree is interpreted once and
only a tiny leaf re-runs per frame. Concretely:

- Move mutable simulation state out of `setState` into a **`ValueNotifier`**
  (or a holder exposing `ValueListenable`s) owned by the host, not the tree.
- Build the scaffold / controls / layout as **`StatelessWidget`s** that are
  interpreted once and never rebuilt.
- Re-render only what changes, by the cheapest available channel:
  - **Painters listen directly** — `CustomPainter(repaint: listenable)` lets a
    `CustomPaint` repaint with **zero widget rebuild**; only the interpreted
    `paint()` re-runs. This is the ideal for both samples' canvases.
  - **Wrap text/badges** that must change in a small `ValueListenableBuilder`
    whose `builder` returns a minimal widget (e.g. just a `Text`).

This works whenever a frame needs **no new widgets** — only repainting an
existing painter or updating a leaf value. It also helps partially when only a
*small* sub-tree genuinely needs reconstruction.

### particle_field (highest payoff — the freeze is rebuild-driven)

The real-app freeze is driven by `MouseRegion onHover → setState → full
interpreted rebuild on every mouse move`. Rewrite:

- Hold the simulation in `ValueNotifier<FieldSnapshot>` (particles + attractor
  + mode), ticked by the physics timer. `onHover` / taps **update the notifier**
  instead of calling `setState`.
- The whole page is `StatelessWidget`; the canvas is a single static
  `CustomPaint` whose `ParticlePainter(... , repaint: snapshot)` listens to the
  notifier. On every tick / hover the painter repaints; **the widget tree is
  never re-interpreted.**
- Mode-selector highlight + any HUD text wrap in `ValueListenableBuilder`s
  returning leaf widgets.

Expected effect: per-frame interpreted rebuild churn drops to ~0; only the
interpreted `paint()` (which iterates particles) remains. That removes the
sustained-allocation source that refills old-gen, so the freeze stops *without*
relying on the heap cap.

### conway_life (rewrite the rendering **and** the model)

Conway has two allocators: the per-tick widget rebuild **and** `stepLife`
itself (the ~26k `Environment`/gen measured above). Both need attention.

- **Rendering:** same pattern as particle_field — `StatelessWidget` scaffold,
  `GridPainter(repaint: liveListenable)` repaints on the `ValueNotifier`, and a
  `ValueListenableBuilder` around the `gen=… alive=…` readout in the control
  bar. Eliminates the per-tick rebuild.
- **Model:** switch the sparse `Set<Cell>` / `Map<Cell,int>` to a **dense
  integer grid** (`List<int>` of length `kBoardW*kBoardH`, or `Uint8List`).
  On a bounded 60×40 board the dense form is both simpler and *far* cheaper in
  the interpreter: neighbour counting becomes integer index arithmetic with
  **no `Cell` allocation and no interpreted `hashCode`/`==` dispatch per cell**.
  That directly attacks the ~26k `Environment`/gen — each avoided
  `Map`/`Set` operation on a `Cell` key removes the interpreted getter/operator
  calls (and their minted `Environment`s + closures) that dominate the churn.

Expected effect: rendering rewrite removes the rebuild allocation; dense-grid
model removes most of `stepLife`'s allocation *and* its per-cell interpret cost,
addressing the gradual slowdown that the heap cap alone cannot.

> These are **script rewrites of the sample apps** (assets under
> `assets/samples/{particle_field,conway_life}/`), not interpreter changes —
> they can land independently of, and in addition to, the deeper
> `Environment`/closure-reuse work in items (1)/(2).
