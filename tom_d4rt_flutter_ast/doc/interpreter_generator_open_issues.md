# Interpreter & Generator — Verified Open Issues

**Quest:** d4rt
**Created:** 2026-06-04
**Status:** Triage — every entry below was re-verified against the current
`tom_ai/d4rt` source + commit history (HEAD `2e38dd0b`). Items fixed in the
meantime are **excluded** (listed in §1 for traceability).

**2026-06-04 re-verification:** the `open_issues/` reproduction corpus was run
against **both** runtimes — source-direct (`tom_d4rt`, via `tom_d4rt_flutter`)
and analyzer-free AST (`tom_d4rt_ast`, via `tom_d4rt_flutter_ast`). The two
runtimes agreed exactly. **9 entries fully removed** (A.8, B.2, B.3, B.4, B.6,
B.7, B.8, B.10, C.2) — their documented defect no longer reproduces on either
runtime; they are recorded in §1 and their numbering is **not** reused.
**2 entries narrowed** (C.5, C.6) — the verified-fixed sub-parts (C.5
`semanticsBuilder`/idx 310, C.6 `EagerGestureRecognizer.new`/idx 77·79·329) are
recorded in §1, but each entry **stays open** for the still-uncovered sub-parts.
The still-open reproductions are A.2, A.3, A.4, A.5, B.1, B.5, B.9, C.1 (plus
the narrowed C.5/C.6 remainders). A.6 and A.7 still reproduce but are non-fatal
(suppressed/cosmetic), so they are not assertable as build failures.

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
| A.8 — private SDK view `_ByteDataView.lengthInBytes` unreachable | **NO LONGER REPRODUCES** (runtime) | 2026-06-04 both runtimes; `ByteData.view(...).lengthInBytes` resolves via the public `ByteData` static type. Repro `open_issues/a8_private_view_type_unreachable_test.dart` |
| B.2 — C-style `for(;;)` shares one loop variable across closures | **FIXED** (interpreter) | 2026-06-04 both runtimes; closures now capture per-iteration values (`[0, 1, 2]`). Repro `open_issues/b2_cstyle_for_closure_capture_test.dart` |
| B.3 — `runtimeType.toString()` on interpreted classes | **FIXED** (interpreter) | 2026-06-04 both runtimes; yields the declared class name. Repro `open_issues/b3_runtimetype_tostring_test.dart` |
| B.4 — `const`-shaped constructor bypasses static-method registration | **FIXED** (interpreter) | 2026-06-04 both runtimes; `const Stream<int>.empty()` constructs. Repro `open_issues/b4_const_stream_empty_static_bypass_test.dart` |
| B.6 — `switch` over a `BridgedEnum` falls through to null | **FIXED** (interpreter) | 2026-06-04 both runtimes; bridged-enum cases match. Repro `open_issues/b6_switch_over_bridged_enum_test.dart` |
| B.7 — `_ConstMap` (`const {}`) missing from Map bridge `nativeNames` | **FIXED** (interpreter/stdlib) | 2026-06-04 both runtimes; const-map member access works. Repro `open_issues/b7_const_map_native_name_test.dart` |
| B.8 — spurious `!` null-check error on nullable static getters | **FIXED** (interpreter) | 2026-06-04 both runtimes; `!` on a static getter no longer raises. Repro `open_issues/b8_null_assert_on_static_getter_test.dart` |
| B.10 — private script class with a parameterized unnamed constructor | **FIXED** (interpreter) | 2026-06-04 both runtimes; parameterized unnamed ctor on a private interpreted class instantiates. Repro `open_issues/b10_private_class_parameterized_ctor_test.dart` |
| C.2 — proxies emitted with `<dynamic>` type args | **FIXED** (generator) | 2026-06-04 both runtimes; `LeafRenderObjectWidget` subclass crosses to native. Repro `open_issues/c2_typed_proxy_emission_test.dart` |
| C.5 (partial) — nullable callback param coercion (`semanticsBuilder`, idx 310) | **FIXED** (generator) | 2026-06-04 both runtimes; nullable function-typed param crosses the bridge. Repro `open_issues/c5_nullable_callback_param_coercion_test.dart`. **C.5 stays open** for the generic-`T` callback signature + `VoidCallback?` (idx 290) parts, which are not yet covered by a repro |
| C.6 (partial) — static constructor tearoff (`EagerGestureRecognizer.new`, idx 77/79/329) | **FIXED** (generator) | 2026-06-04 both runtimes; static constructor tearoff resolves. Repro `open_issues/c6_eager_gesture_recognizer_tearoff_test.dart`. **C.6 stays open** for `Key.label` (idx 14) and `ByteData` symbol resolution (idx 279), not yet covered by a repro |

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

### B.5 — Bridge-wrapped exceptions escape typed `on` / bare `catch` (U13, U24)
A native throw is wrapped in `RuntimeError`, discarding the original type, so
`on PlatformException` never matches (U13); some bridged static getters that
throw bypass even an untyped `catch` (U24). *Workaround:* pre-check
preconditions; don't rely on typed catch across the bridge. *Fix:* preserve the
original native exception type through the wrap so `on`/`catch` clauses match.

### B.9 — Static-field write from a sibling static method not persisting (step-7 sidebar b)
A static-field write performed inside a sibling static method does not survive
across calls. Distinct from initializer-ordering (`2b836ca6`). *Workaround:*
top-level mutable variable. *Fix:* ensure static-field stores from any static
member persist to the class's static slot.

### B.11 — No app-startup / parser warmup (cold-start flakiness) (U25)
The first script after `setUpAll` flakes under host load because the parser +
interpreter infrastructure cold-starts mid-test. The shipped reset API does not
warm anything. *Workaround:* re-run the first-after-setup script individually.
*Fix:* an interpreter warmup pass (or `/warmup` endpoint) that pre-builds parser
+ bridge infrastructure before the first real build.

### B.12 — Framework/runtime state accumulates across `/build` cycles; reset API is a no-op (U28) — ✅ FIXED (2026-06-05)
Repeated `/build` cycles accumulated native-side state. The audit
(`interpreter_unfixable.md:7304-7326`) ranked the `D4._nativeToInterpreted`
**Expando** as the #1 genuine cross-build accumulator: its entries are weak, but
they are pinned by framework objects (Flutter Elements / RenderObjects /
animations) the embedder keeps alive across `/build` cycles, so they do NOT
self-clear the way the per-call-fresh `_values` environment map does. The shipped
`resetScriptDeclarations`/`resetScript` API walked only `_values` and never
touched the Expando — hence the no-op.

**Fix:** added `D4.resetNativeAccumulators()` (swaps in a fresh Expando — the only
way to bulk-drop entries, since Expando exposes no `clear()`/iterator — and zeroes
a new `D4.nativeRegistrationCount` instrumentation counter) and wired it into
`resetScriptDeclarations()` on both runtimes. The D4 static *registration* caches
(`_interfaceProxies`, `_genericConstructors`, `_typeCoercions`, …) are deliberately
**not** cleared — they are populated once at bridge finalization and must persist.
*Workaround retained:* `SendTestRunner.requestRecycle()` stays as the
belt-and-braces fallback.
- a. ✅ Added `D4.resetNativeAccumulators()` + `nativeRegistrationCount` getter in
  `tom_d4rt_ast/lib/src/runtime/generator/d4.dart`; **mirrored** in
  `tom_d4rt/lib/src/generator/d4.dart`. Wired into
  `D4rtRunner.resetScriptDeclarations()` (AST) and `D4rt.resetScriptDeclarations()`
  (VM); `tom_d4rt_exec` inherits it via its runner forward. Docstrings updated
  (the old "Expando is NOT touched" note replaced).
- b. ✅ **Unit/integration test (both runtimes):** N repeated build cycles without
  a reset grow the counter (the bug); with a reset between cycles the accumulator
  returns to baseline and previously-mapped keys read back `null` even while still
  reachable; the runner/facade reset API clears the native state too.
  `tom_d4rt_ast/test/runtime/native_accumulator_reset_test.dart` (6 cases) +
  `tom_d4rt/test/open_issues/b12_native_accumulator_reset_test.dart` (6 cases).
- c. ✅ **Base-test gate** both (tom_d4rt +1826/−1, tom_d4rt_ast +147, tom_d4rt_exec
  +2308/−1 — only the pre-existing `I-BUG-14a` "Won't Fix"). `requestRecycle()`
  kept; the §U28 audit note updated. `dart analyze` clean on all touched files.

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

### C.5 — Generic-`T` callback signature (Gap 7 residue)
`Future<X>` callback-return wrapping is fixed (`239cf773`) and arity-preserving
param closures work, but class-generic-`T` callback signatures
(`BasicMessageChannel<T>.setMessageHandler`) are only worked around by a
hand-written user bridge. *Fix:* generate callback adapters that preserve the
class-level `T`. (The nullable `semanticsBuilder` param-coercion sub-part — idx
310 — was verified fixed 2026-06-04, see §1; the `VoidCallback?` idx 290
sub-part is not yet covered by a repro.)

### C.6 — Missing member / static exposure (Gap 8 residue)
Still undefined: `Key.label` (idx 14), `ByteData` symbol resolution (idx 279).
*Fix:* expose the missing members in the bridge.
(`_ByteDataView.lengthInBytes` was A.8 — now non-reproducing, see §1.
`EagerGestureRecognizer.new` static-constructor tearoff — idx 77/79/329 — was
verified fixed 2026-06-04, see §1.)

---

## 5. Follow-up housekeeping (not an issue, but worth doing)

The three source logs still carry stale status tags that produced the original
"all open" miscount. When convenient, re-tag in place:
- `interpreter_issues.md` lines 2931, 3029, 3089, 3128, 3142, 3196, 3235 →
  point W1–W5 at Cluster R, Plan E2 at `920032c7`/`80c5d1d4`, META at `50bfc8a8`.
- `interpreter_unfixable.md` U10/E12 → mark the DiagnosticableTreeMixin proxy
  FIXED (`3a068fd8`), correct the "✅" headers on U28 (no-op reset) and
  U29/U30 (suppression/rewrite, not the named deep fix).
