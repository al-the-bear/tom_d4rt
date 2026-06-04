# Interpreter & Generator — Verified Open Issues

**Quest:** d4rt
**Created:** 2026-06-04
**Status:** Triage — every entry below was re-verified against the current
`tom_ai/d4rt` source + commit history (HEAD `2e38dd0b`). Items fixed in the
meantime are **excluded** (listed in §1 for traceability).

The three source logs (`generator_issues.md`, `interpreter_issues.md`,
`interpreter_unfixable.md`) were **not kept up to date** — their in-doc status
tags (`[WEDGE — Open]`, `Plan E2 (open)`, "deferred, feature-scale") predate the
fixes that have since landed. This document is the reconciled, evidence-checked
view.

Numbering: **A.x** genuinely unfixable (→ add to
`interpreter_limits_and_workarounds.md`), **B.x** interpreter-fixable,
**C.x** generator-fixable.

---

## 1. Excluded — verified FIXED since the logs were written

Do not re-file these; evidence in parentheses.

| Was claimed open | Real status | Evidence |
|---|---|---|
| Plan E2 — null-receiver BuildContext on `dependOnInheritedWidgetOfExactType` | **FIXED** (interpreter) | `920032c7` (C14: `nativeStateProxy` getter fallback) + `80c5d1d4`; regression tests `_plan_e2_static_in_closure_test.dart` |
| U10 / E12 — `_InterpretedDiagnosticableTreeMixin` adapter proxy | **FIXED** | `3a068fd8`; registered `d4rt_runtime_registrations.dart:597`, proxy `:4860`. Doc "deferred, feature-scale" is stale |
| L1 — `ChangeNotifier`/`Listenable` subtype crossing | **FIXED** | `registerInterfaceProxy` at `:554`/`:563` |
| Object() default-constructor bridge | **FIXED** (generator) | GEN-042, `element_mode_extractor.dart:1029-1037` |
| int→double constructor-factory coercion | **FIXED** (generator) | GEN-075, `relaxer_generator.dart` `_coerceToV` (`:630`), `48e56052` |
| `Iterable.whereType` lookup + `String.characters` | **FIXED** (runtime stdlib) | `66ad44a8`; `list.dart:221`, `registration.dart:296` (note: `whereType<T>` resolves but the `<T>` filter is erased — see A.2) |
| InterpretedInstance→Widget: `StatelessWidget`/`StatefulWidget` core | **FIXED** | `registerInterfaceProxy('StatelessWidget')` `:292`, `('StatefulWidget')` `:305` |
| Inherited `State.widget` / `setState` exposure | **FIXED** (runtime) | `registerSupplementaryMethod('State','widget')` `:2023`, `('setState')` `:2047`; `StateUserBridge`; generator `c092d361` (GEN-112) |
| WEDGE W1–W5 (context_action, default_text_editing_shortcuts, live_text_input_status, lock_state, animated_switcher) — as *interpreter* bugs | **FIXED as scripts** — de-skipped, pass in isolation | Cluster R `interpreter_unfixable.md:167-194`; de-skip commits `056743e7`, `89997a53`, relocated to `timeout_tests_test.dart:488-504`. The *transport-cascade* residue is A.1 |
| [META] watchdog / per-test process restart | **DEFERRED, not a bug** | `50bfc8a8` formally defers; rendered moot once W1–W5 proved isolation-clean |

---

## 2. A — Genuinely unfixable limitations (→ limits doc)

These cannot be fixed in the interpreter or generator; each needs a curated
entry in `interpreter_limits_and_workarounds.md` with the explanation + workaround
below.

### A.1 — Test-app HTTP transport wedge cascade (W1–W5)

**Symptom:** Running certain scripts in-sequence against the long-lived test app
wedges a later `/clear` or `/build` (HttpException / hang); each script passes
cleanly in a fresh process.
**Root cause:** Not an interpreter or generator defect. The driver app uses a
single shared local HTTP server; after the process has been alive long enough
(W4: ~13 min) and accumulated framework/native state, the transport layer
stalls. `frameworkErrors=0` for every W-script in isolation (Cluster R table).
**Why unfixable here:** the cascade lives in the test harness/transport, below
the interpreter; the proper fix (a per-test watchdog / process restart) is
multi-day test-infra work that was formally deferred (`50bfc8a8`) and is moot for
correctness — the scripts themselves are clean.
**Workaround:** run wedge-prone scripts in isolation or with a `waitBeforeClear`
buffer; never run multiple `flutter test` invocations in parallel in this
package (already a standing quest rule).

### A.2 — Generic type-argument erasure at the d4rt→native bridge boundary

**Symptom:** `findAncestorStateOfType<T>()`, `Iterable.whereType<T>()`,
`dependOnInheritedWidgetOfExactType<T>()` and similar lose `<T>` when they cross
into native code; the call resolves but `T` is treated as `dynamic`.
**Root cause:** Dart has **no runtime generic synthesis** — the interpreter
cannot reify a script's type argument into a real native `<T>`. The generated
bridge adapter therefore drops it. (E3, E7.)
**Why unfixable in general:** a native generic method keyed on the reified `T`
(e.g. `_inheritedElements[_Scope<T>]`) can never be satisfied from interpreted
code. Per-method interceptors (`registerBridgedMethodInterceptor` for
`Element.dependOn…`, `ThemeData.extension`, `InheritedModel.inheritFrom`,
`RadioGroup.maybeOf`) patch *specific* methods by walking ancestors and matching
on `klass.name`, but the general limit stands.
**Workaround:** don't rely on `<T>` across the boundary — pass values/controllers
down explicitly, filter/cast manually instead of `whereType<T>`.

### A.3 — Runtime mixin application & type-arg reification are impossible (proxy-explosion root)

**Symptom:** A script `extends RenderBox with ContainerRenderObjectMixin`, or
`extends CustomClipper<Path>`, needs a *distinct* native proxy per mixin-set and
per type argument (`_InterpretedRenderBoxContainer`,
`_InterpretedCustomClipperPath`, …).
**Root cause:** Dart cannot add a mixin to a class at runtime, and cannot
construct a generic type from a runtime type name. So one native proxy class must
be pre-written/pre-generated per `{mixin set}` × `{type arg}` combination.
**Why unfixable:** this is a language limitation; the *number* of proxies can be
reduced by generation (see C.1), but the need for concrete-per-variant classes
cannot be eliminated.
**Workaround:** provide a concrete proxy variant per used mixin-set / type arg
(today hand-written in `d4rt_runtime_registrations.dart`; see
`manual_code_interventions.md` for the automation path).

### A.4 — `vector_math_64` types unreachable (Quad / Vector3 / Vector4)

**Symptom:** `import 'package:vector_math/vector_math_64.dart';` is unresolvable;
only `Matrix4` (re-exported by Flutter) is bridged. (U6, U21.)
**Root cause:** `vector_math` is deliberately **not** in the bridge's
`bridgedLibraries`. Adding it would balloon the bridge surface.
**Why unfixable (policy):** an intentional bridge-size trade-off, not a defect.
**Workaround:** drop the import; use `Matrix4.storage` / indexable accessors and
compute matrix·vector products inline.

### A.5 — `@Deprecated` SDK symbols absent from the bridge surface

**Symptom:** deprecated Flutter/Dart symbols are "undefined" in scripts. (U12.)
**Root cause:** `ElementModeExtractor.generateDeprecatedElements = false` skips
every `@Deprecated` element by design, to keep the bridge aligned with the
non-deprecated API.
**Why unfixable (policy):** intentional generator policy.
**Workaround:** declare a local stand-in, or swap to the modern symbol name.

### A.6 — `MemoryImage(Uint8List)` PNG codec rejection (U29)

**Symptom:** valid PNG bytes handed to `MemoryImage` raise "Codec failed to
produce an image"; the broken-image glyph renders.
**Root cause:** the interpreter↔`ui.ImmutableBuffer` bridge path corrupts/rejects
the byte buffer; the deep fix is unidentified. Currently only the *observable
banner* is suppressed (`main.dart:364` ignored-pattern), not the codec failure.
**Why in the limits doc:** accepted as a standing bridge limitation; no reliable
fix in interpreter or generator to date.
**Workaround:** suppress the framework error; don't assert on rendered pixels for
in-memory images.

### A.7 — Empty `Text('')` / per-char non-Latin `TextSpan` → NaN layout assertion

**Symptom:** non-fatal `Offset`/`Rect` `NaN` banner from an empty `Text` (U16) or
a per-character non-Latin `TextSpan` stream (U19).
**Root cause:** a text-layout edge in the bridged paragraph path; non-fatal
(tests pass) but the underlying bridge bug persists.
**Why in the limits doc:** longstanding, cosmetic, no clean fix.
**Workaround:** substitute a single space for empty `Text`; avoid per-character
non-Latin `TextSpan` construction.

### A.8 — Private SDK view types (`_ByteDataView.lengthInBytes`) unreachable

**Symptom:** member access on a private SDK view type (`_ByteDataView`) is
undefined. (generator_issues idx 71–72.)
**Root cause:** the runtime type is a *private* SDK view with no bridge mapping;
it cannot be named or registered.
**Why unfixable:** private types are outside the bridgeable surface.
**Workaround:** normalize to the public `ByteData` before access.

---

## 3. B — Interpreter-fixable issues

Real interpreter-semantics gaps; fix in the interpreter and **mirror tom_d4rt ↔
tom_d4rt_ast** per the quest rule. None has a landed code fix — all are currently
script-side worked around only.

### B.1 — Redirecting factory `factory X() = Y` not implemented (R1)
Redirecting-factory constructors aren't resolved. *Workaround:* instantiate the
redirected concrete subclass directly. *Fix:* implement redirecting-factory
resolution in the constructor evaluator. (Closed script-side in `7b6aed97`, no
interpreter change.)

### B.2 — C-style `for(;;)` shares one loop variable across closures (I1)
`_executeClassicFor` reuses a single `loopEnvironment`; closures capture the
post-loop value instead of the per-iteration value. *Workaround:*
`List.generate(n, (i) => …)`. *Fix:* fresh per-iteration binding (clone the loop
var into a new scope each turn), matching Dart semantics.

### B.3 — `runtimeType.toString()` on interpreted classes fails (T1)
`InterpretedInstance.runtimeType` returns an `InterpretedClass` with no callable
`toString`. *Workaround:* `is`-check ladder emitting the name. *Fix:* give
`InterpretedClass` a `toString` returning the declared class name.

### B.4 — `const`-shaped constructor bypasses static-method registration (S1)
`const Stream<int>.empty()` routes only through `findConstructorAdapter`, never
`staticMethods`, so factory-as-static registrations are missed. *Workaround:*
drop `const`/type-arg and call as a method. *Fix:* consult `staticMethods` on the
const-construction path.

### B.5 — Bridge-wrapped exceptions escape typed `on` / bare `catch` (U13, U24)
A native throw is wrapped in `RuntimeError`, discarding the original type, so
`on PlatformException` never matches (U13); some bridged static getters that
throw bypass even an untyped `catch` (U24). *Workaround:* pre-check
preconditions; don't rely on typed catch across the bridge. *Fix:* preserve the
original native exception type through the wrap so `on`/`catch` clauses match.

### B.6 — `switch` over a `BridgedEnum` falls through to null (P4)
The equality probe in `visitSwitchStatement` returns false both directions for
certain bridged-enum values; a String-returning helper falls through to implicit
null. *Workaround:* `if/else` over `==`, seed a default. *Fix:* correct bridged-
enum equality in switch-case matching.

### B.7 — `_ConstMap` (`const {}`) missing from Map bridge `nativeNames` (U7)
The Map `BridgedClass` `nativeNames` omits `_ConstMap` (the runtime type of a
const map literal), so member access throws. *Workaround:* `Map.from(...)` / drop
`const`. *Fix:* one-line addition of `_ConstMap` to the Map bridge `nativeNames`.

### B.8 — Spurious `!` null-check error on nullable static getters (step-7 sidebar a)
`visitPostfixExpression` (`SPostfixExpression`) raises a spurious Runtime Error
when `!` is applied to a nullable static getter (`static BitField get bf => _bf!`).
*Workaround:* top-level mutable var + lazy helper. *Fix:* handle the null-assert
operator on static-getter receivers. (Closed script-side only in `39c37e5d`.)

### B.9 — Static-field write from a sibling static method not persisting (step-7 sidebar b)
A static-field write performed inside a sibling static method does not survive
across calls. Distinct from initializer-ordering (`2b836ca6`). *Workaround:*
top-level mutable variable. *Fix:* ensure static-field stores from any static
member persist to the class's static slot.

### B.10 — Private script class with a parameterized unnamed constructor not instantiable
Script-local private classes (`_FlowStage`, `_Pattern`, `_Playbook`, … ~15
distinct) with an **argument-taking** unnamed constructor raise "does not have an
unnamed constructor that accepts arguments." These are interpreted (not bridged)
classes, so this is an interpreter constructor-resolution gap, not a generator
gap. *Workaround:* refactor the script to a named ctor or public class.
*Fix:* resolve parameterized unnamed constructors on private interpreted classes.

### B.11 — No app-startup / parser warmup (cold-start flakiness) (U25)
The first script after `setUpAll` flakes under host load because the parser +
interpreter infrastructure cold-starts mid-test. The shipped reset API does not
warm anything. *Workaround:* re-run the first-after-setup script individually.
*Fix:* an interpreter warmup pass (or `/warmup` endpoint) that pre-builds parser
+ bridge infrastructure before the first real build.

### B.12 — Framework/runtime state accumulates across `/build` cycles; reset API is a no-op (U28)
Repeated `/build` cycles accumulate native-side state (Expando
`D4._nativeToInterpreted`, D4 static caches, Flutter framework state). The shipped
`resetScriptDeclarations`/`resetScript` API is architecturally a **no-op** (a
fresh `Environment` is already built per build — audit `interpreter_unfixable.md:7272`).
*Workaround:* `SendTestRunner.requestRecycle()` kills+respawns the app process.
*Fix:* instrument and clear the actual native accumulator (ranked but
uninvestigated at `:7304-7326`).

### B.13 — Interpreted-element dependent registrations not cleared on `/clear` (U30, latent)
Interpreted `InheritedElement` dependents leak across `/clear`; currently **no
observable failure** (the one reproducing script was rewritten, `da4b3234`), so
this is latent. *Workaround:* none needed today. *Fix (deferred):* clear
interpreted-element dependent registrations / track interpreted-element lifecycle
on `/clear`. Keep on the radar so the leak doesn't resurface.

### B.14 — Interpreter starves the embedder's input/frame pump during long sync runs (cooperative yielding)

**Symptom:** Auto-ticker samples driven by `Timer.periodic` (snake, tron) ignore
keyboard input mid-game. Verified below the script: a pure-Dart
`HardwareKeyboard.instance.addHandler` installed in the host `main()` (never
through d4rt) is *also* starved during interpreted gameplay; every queued
`KeyEvent` flushes the instant `_ticker.cancel()` runs at game-over. Slowing the
tick (snake 250→600 ms, tron 110→180 ms) restores input but feels sluggish.

**Root cause:** `InterpreterVisitor` (and its `tom_d4rt_ast` mirror) is a
synchronous `GeneralizingAstVisitor`. Every sync entry point — Timer callbacks,
`KeyEvent` handlers, `paint`, `build` — runs straight through to completion with
**no yield**, so the Dart isolate's main loop never returns control to the
embedder to pump GTK/Wayland/NSRunLoop input or schedule frames. The existing
`AsyncSuspensionRequest`/`AsyncExecutionState` machinery
(`async_state.dart`, `callable.dart:1240`) only triggers inside script-declared
`async` functions; the sync `_callImpl` branch (`callable.dart:1287`) runs
`executeBlock` to completion.

**What has shipped (partial, does NOT close it):**
- `7011045a` — one `await Future.delayed(Duration.zero)` after each Timer
  callback. Didn't move the needle.
- `13528d0a` — multi-yield in the Timer bridge (`_yieldEventLoop`: 1 ms + 2×
  zero, `tom_d4rt/lib/src/stdlib/async/timer.dart:18`). Helps *between-tick*
  input on slower ticks but cannot help when a single tick's interpreted work
  exceeds a frame, and does nothing for non-Timer paths.

**Why still open:** the Timer-bridge yield only covers void Timer callbacks.
Three classes of work remain unyielded and are the real blockers:
1. **Interpreted `paint`/`build`** — the framework calls these *synchronously*
   (`RenderCustomPaint` finalizes the `PictureRecorder` via `endRecording()` the
   moment `paint` returns, so microtask-deferring the interpreted paint draws
   nothing — ruled out). `_InterpretedCustomPainter.paint`
   (`d4rt_runtime_registrations.dart:2826`) and `_InterpretedState.build` cannot
   be async-wrapped.
2. **Non-void bridged callbacks** (`Widget Function(BuildContext)` builders,
   `bool shouldRepaint`, `int compareTo`) — async-wrapping changes the return
   type to `Future`, which the framework can't consume.
3. **Recursive interpreted game logic** longer than one frame.

**Fix direction (interpreter, large):** make the visitor *resumable* — an
op-count or wall-clock budget that suspends the sync visitor at node boundaries
and returns control to the event loop, reusing/extending `AsyncExecutionState`
to capture the next AST node + loop/try stacks. This is the only fix that covers
paint/build/non-void/recursive cases. It is a multi-week refactor (every
control-flow node needs resumption logic; the bridged-call layer must save the
visitor stack at each sync boundary) and must be guarded by the full regression
suite. Do **not** async-fy the entire visitor (option 5.4) — the per-node
microtask overhead would measurably slow CLI/build scripting, the main d4rt use
case.

**Partial generator mitigation (cheaper, available, not landed):** have the
bridge generator wrap *every void* bridged callback in an async closure with a
trailing `await Future.delayed(Duration.zero)` — emitter
`_rc2GenerateFunctionWrapper`
(`tom_d4rt_generator/lib/src/relaxer_generator.dart:2664`); the choke point
`D4.callInterpreterCallback` (`tom_d4rt/lib/src/generator/d4.dart:1889`) returns
`Object?` today so it can't await inside, hence the wrapper must do it. Native
APIs accepting `void Function(...)` accept `Future<void> Function(...)` too.
Covers KeyEvent/gesture/`onChanged`/listener callbacks but **not** the three
blockers above. ~3–5 LOC + bridge regen + ~5–10 hand-written proxy edits.

**Workaround in use:** widen the tick interval until the embedder gets idle time
between firings (stopgap, not a fix).

---

## 4. C — Generator-fixable issues

Bridge-generator gaps. Several are *functionally* worked around today by
hand-written runtime registrations (see `manual_code_interventions.md`); they
remain open as **generator** work because the generator cannot yet emit the fix
automatically.

### C.1 — Auto-synthesize interface proxies for unregistered script-subclassable abstract/mixin bases
**Open targets** (no proxy registered, so script subclasses still fail to cross
to native): `Curve` (U3), `NotchedShape` / `FloatingActionButtonLocation` (U5),
`Enum` (U8), `RouteAware` (U9), `HitTestTarget` (U11). ~33 proxies exist but are
hand-written one-per-type. *Fix:* generator auto-emits an interface proxy for any
script-defined subclass of a bridged abstract/mixin (the templatable majority;
the non-templatable residue is A.3). Overlaps
`manual_code_interventions.md` TODO #2.

### C.2 — Correctly-typed proxy emission (`registerProxyFactories` emits `<dynamic>`)
The generator's emitted proxies carry `<dynamic>` type args that fail concrete
type checks, forcing `registerD4rtInterfaceProxyOverrides()` to re-register
`MultiChildLayoutDelegate`, `SingleChildLayoutDelegate`, `CustomClipper`, etc. by
hand, and the long tail of widget bases (Gap 3 residue beyond
Stateless/Stateful). *Fix:* emit proxies with the concrete type arguments read
from the script's `extends` clause.

### C.3 — Non-wrappable arithmetic defaults on positional native ctors (U2)
`BridgeGenerator._wrapDefaultValue` returns null for any default containing an
operator (`math.pi * 2`), emitting a throwing `getRequiredArgTodoDefault`.
*Workaround:* at every call site supply all preceding positionals with literal
defaults. *Fix:* evaluate/emit operator-bearing constant default expressions.

### C.4 — `getNamedArgWithDefault<T?>` collapses explicit `null` vs absent (G1)
The helper guards on `!named.containsKey(p) || named[p] == null`, conflating
"argument absent" with "argument present-but-null", so an explicit `null` gets
overwritten by the bridge default. *Workaround:* avoid passing explicit `null`.
*Fix:* distinguish absence from explicit-null in the generated default guard.

### C.5 — Generic-`T` callback signature + nullable `VoidCallback` param coercion (Gap 7 residue)
`Future<X>` callback-return wrapping is fixed (`239cf773`) and arity-preserving
param closures work, but class-generic-`T` callback signatures
(`BasicMessageChannel<T>.setMessageHandler`) are only worked around by a
hand-written user bridge, and nullable `VoidCallback?` / `semanticsBuilder`
param coercion (idx 290, 310) have no landed fix. *Fix:* generate callback
adapters that preserve the class-level `T` and coerce nullable function params.

### C.6 — Missing member / static exposure (Gap 8 residue)
Still undefined: `Key.label` (idx 14), `EagerGestureRecognizer.new` static
constructor tearoff (idx 77/79/329), `ByteData` symbol resolution (idx 279).
*Fix:* expose the missing members / emit static constructor tearoffs in the
bridge. (`_ByteDataView.lengthInBytes` is A.8, not this — private type.)

---

## 5. Follow-up housekeeping (not an issue, but worth doing)

The three source logs still carry stale status tags that produced the original
"all open" miscount. When convenient, re-tag in place:
- `interpreter_issues.md` lines 2931, 3029, 3089, 3128, 3142, 3196, 3235 →
  point W1–W5 at Cluster R, Plan E2 at `920032c7`/`80c5d1d4`, META at `50bfc8a8`.
- `interpreter_unfixable.md` U10/E12 → mark the DiagnosticableTreeMixin proxy
  FIXED (`3a068fd8`), correct the "✅" headers on U28 (no-op reset) and
  U29/U30 (suppression/rewrite, not the named deep fix).
