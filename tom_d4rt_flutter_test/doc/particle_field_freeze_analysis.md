# particle_field freeze — root-cause analysis

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
3. **Reduce per-frame interpretation** — cache the interpreted widget subtree
   when inputs are unchanged, so `onHover`-driven rebuilds don't re-run the
   whole tree. Highest leverage for the real app, but an architectural change
   in `SourceFlutterD4rt` / the sample-runner layer.
4. **VM old-gen tuning** — cap / shrink old-gen so the major GC runs more
   often but far cheaper. A mitigation, not a fix; only available where the
   embedder controls VM flags.

Fully eliminating the recurring freeze most likely needs (1) and/or (3) and is
a material design decision rather than a localized bug fix.
