# MCI Step-0 Review Baseline — Runtime Registration Surface

**Quest:** d4rt · **Date:** 2026-06-05 · **Source todo:** cleanup_todos.md #2
(= `manual_code_interventions.md` step 0, sub-steps a–e).

This is the durable record produced by the MCI step-0 code review of the
**runtime/registration surface** that hosts every hand-written intervention,
across `tom_d4rt` (analyzer-based) and its web-capable twin `tom_d4rt_ast`.
It is the counterpart to the generator-pipeline review in
`step0_review_baseline.md` (P&R step 0); together they form the accurate
baseline the MCI automation steps (1–11) amend.

It holds the registration-API surface map + line-reference verification (0a),
the `tom_d4rt` ↔ `tom_d4rt_ast` divergence map (0b), the hand-written
intervention inventory + catalog re-verification (0c), and a pointer to the
refreshed component docs (0d) and the reused green baseline (0e).

---

## 0a — `tom_d4rt` registration-API surface (verified)

The registration API is **nine static `D4.register*` sinks** plus the
`BridgedClass` supertype table and the two proxy-creation entry points. All
keyed by class-name `String`, all process-global. File:line in
`tom_d4rt/lib/src/generator/d4.dart` (AST twin in
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart`):

| Sink | tom_d4rt | tom_d4rt_ast | Category (MCI §3) |
|------|---------:|-------------:|-------------------|
| `registerInterpretedForNative` | 157 | 159 | — (native→interpreted back-map) |
| `registerInterfaceProxy` | 193 | 195 | RC-1 / A2,A3,A4,A7,B1 |
| `registerTypeCoercion` | 251 | 273 | RC-3 / B5,C3 |
| `registerGenericTypeWrapper` | 287 | 309 | A5 (widget re-creators) |
| `registerGenericConstructor` | 334 | 356 | RC-2 / B3 |
| `registerSupplementaryMethod` | 388 | 415 | RC-5 / A6 |
| `registerBridgedMethodInterceptor` | 434 | 461 | B4 |
| `registerBridgedStaticMethodInterceptor` | 466 | 493 | B4 |
| `registerEnumStaticGetter` | 498 | 525 | RC-8 |
| `BridgedClass.registerSupertypes` | `bridge/bridged_types.dart:37` | `…/bridge/bridged_types.dart:42` | A1 |
| `BridgedClass.transitiveSupertypeNames` (the walk) | `bridged_types.dart` | `bridged_types.dart:56` | A1 |
| `tryCreateInterfaceProxyWithVisitor<T>` | 2136 | 2174 | proxy lookup |
| `tryCreateInterfaceProxyByName` | 2213 | 2261 | proxy lookup (by name) |
| `extractBridgedArg<T>` | 1237 | 1271 | resolution leaf (see P&R 0b) |

**Transitive-supertype walk + last-match-wins specificity filter** live in
`d4.dart` `tryCreateInterfaceProxyWithVisitor` (tom_d4rt ~2136 / AST ~2174),
which consults `BridgedClass.transitiveSupertypeNames(name)` (the `bc.name`
loop at tom_d4rt `d4.dart:2160`) and keeps the most specific match. The
`extractBridgedArg` resolution order (generic-wrapper → interface-proxy →
RC-3 coercion → throw) is documented in the P&R baseline (§0b) and unchanged.

### §2–§6 drift corrected in `manual_code_interventions.md`

| MCI ref | Claim | Reality | Action |
|---------|-------|---------|--------|
| §2 bullet | `registerPropertyInterceptor` is a current sink | **Does not exist** anywhere in the tree. RC-9 property interception was replaced by the field-based `interpretedStatefulWidget` / `nativeStateProxy` mechanism in `runtime_types.dart` (see 0b note). | **Removed** from §2; the stale RC-9 section in `tom_d4rt/doc/advanced_bridging_user_guide.md` is corrected under 0d. |
| §2 bullet | lists 6 sinks | actual surface is **9** `D4.register*` sinks (adds `registerInterpretedForNative`, `registerBridgedStaticMethodInterceptor`, `registerEnumStaticGetter`) | §2 list completed |
| §1 table | AST `d4rt_runtime_registrations.dart` = 4,926; non-AST "~same" | AST = **4,925**; non-AST = **5,102** (+177) | §1 corrected; the +177 is the `_InterpretedKeepAliveState` block (0b) |
| §4 A1 | "~40 entries" in `registerSupertypes` | **70 entries** | §4 A1 corrected |
| §4 A2 | "~20 proxy classes" | **40 (AST) / 41 (non-AST)** `_Interpreted*` classes total (the ~20 *abstract-interface forwarding* proxies is still roughly right once the State/RenderBox/clipper/helper families are excluded) | §4 A2 clarified |
| §4 A3 | "four near-verbatim" State proxies | **five** in non-AST (adds `_InterpretedKeepAliveState`), **four** in AST | §4 A3 corrected + AST-gap flagged (0b) |

All other A1–C4 catalog line references re-verified accurate within ±1–11
lines (same minor drift profile as P&R 0a); every cited body exists. Spot
checks (live AST file): A1 `registerSupertypes` @158, A2
`_InterpretedTickerProvider` @960 + registration @283, A3 `initState`
overrides @1383/1528/1663/1861, A5 `registerGenericTypeWrapper('DropdownMenuItem'`
@2229, A6 `registerSupplementaryMethod('ChangeNotifier','notifyListeners'`
@1987, B1 clipper variants @2865/2900, B3 `registerGenericConstructor('GlobalKey'`
@1039, B4 `RadioGroup.maybeOf<…>` @3821-3826.

---

## 0b — `tom_d4rt` ↔ `tom_d4rt_ast` divergence map

**API surface: in lockstep.** The nine `D4.register*` sinks, both
`tryCreateInterfaceProxy*` entry points, `extractBridgedArg`, and
`BridgedClass.registerSupertypes`/`transitiveSupertypeNames` exist **identically**
in both twins, offset only by a constant ~20–40-line block (the AST file
carries more comment text). No accidental drift in the registration API
itself — this matches the P&R 0b result for the resolution path.

**Manual registration files: real divergence.** The two
`d4rt_runtime_registrations.dart` files (`tom_d4rt_flutter` vs
`tom_d4rt_flutter_ast`) are **not** byte-identical-except-import. After
normalizing the `package:tom_d4rt` ↔ `package:tom_d4rt_ast` token, ~331 diff
lines remain. Classified:

| # | Divergence | Lines | Class | Disposition |
|---|------------|------:|-------|-------------|
| D1 | **`_InterpretedKeepAliveState`** (`with AutomaticKeepAliveClientMixin`) + `_usesAutomaticKeepAliveClientMixin` walk + the proxy-factory dispatch + the import/`with`-clause entries — present in **non-AST only**; the web twin **lacks AutomaticKeepAliveClientMixin keep-alive support entirely** | ~189 | **(i) accidental drift — web twin behind** | Re-sync: port to `tom_d4rt_ast` (or document a deliberate web reason). Folds into MCI item **3** (`mixinVariants:` State family) — the 5th variant must be added to the AST side. Flagged for the per-step sync gate. |
| D2 | **`RouterDelegate<Object>`** (non-AST) vs **`RouterDelegate<dynamic>`** (AST). The non-AST comment (Cluster D TODO #9, GEN-118b) insists `<Object>` is required for `extractBridgedArg<RouterDelegate<Object>?>` to pass, and claims to be a "mirror of" the AST file — but the AST file uses `<dynamic>` | 1 type arg | **(i) suspected accidental drift** | Investigate: one of the two is likely wrong. Reconcile during MCI item 2 (abstract-interface proxy template) or sooner. |
| D3 | AST file uses **narrow explicit imports** (`show D4` + `src/runtime/...` internal imports for `BridgedClass`, `InterpreterVisitor`, `D4InterpretedProxy`, `RuntimeType`, runtime_types) where non-AST uses a single `package:tom_d4rt/d4rt.dart` | ~6 | **(ii) legitimate — different package barrel layout** | Keep; comment. The AST `d4rt.dart` barrel does not re-export the same internal symbols. |
| D4 | Stale AST **comments**: a comment says "`_forwarding*` flags" but the actual fields are `_in*` in both files; another says `D4.unwrapAs<Listenable>` where non-AST says `D4.extractBridgedArg<Listenable>` (both describe the same fallback) | ~4 | drift — comment only | Low priority; correct opportunistically. |
| D5 | Richer AST doc comments on the CustomClipper / ThemeExtension proxies (the AST side documents the four-variant set + fallback clips); `dart format` line-wrapping differences | ~120 | cosmetic | Keep. |

**Net:** the only functionally-significant drift is **D1** (the AST web twin
is missing the `AutomaticKeepAliveClientMixin` State proxy) and **D2** (the
RouterDelegate type-arg mismatch). Both are recorded here as the reference
the per-step sync gate checks against; neither is a *web-only* legitimate
difference, so both should converge. The one genuinely web-only artifact
remains `scene_builder_user_bridge.dart` (AST-only, §1/§5 B5 — kept).

---

## 0c — Hand-written intervention inventory (re-verified)

| File | Lines | Note vs MCI §1 |
|------|------:|----------------|
| `tom_d4rt_flutter_ast/lib/src/d4rt_runtime_registrations.dart` | **4,925** | doc said 4,926 (−1, fine) |
| `tom_d4rt_flutter/lib/src/d4rt_runtime_registrations.dart` | **5,102** | doc said "~same"; actually **+177** (D1 KeepAlive) |
| `tom_d4rt_flutter_ast/lib/src/d4rt_user_bridges/` | **4 files** | `basic_message_channel`, `scene_builder` (AST-only), `state`, `strut_style` ✓ |
| `tom_d4rt_flutter/lib/src/d4rt_user_bridges/` | **3 files** | same minus `scene_builder` ✓ |

**"byte-identical except the import line"** claim — re-confirmed **true for
the three shared user-bridge files** (`basic_message_channel`, `state`,
`strut_style`): the *only* textual difference is
`package:tom_d4rt/d4rt.dart` → `package:tom_d4rt_ast/d4rt.dart`. The claim
does **not** extend to the two `d4rt_runtime_registrations.dart` files (those
diverge per 0b) — §1 conflated the two; corrected.

**`D4.register*` call inventory in the AST registrations file** (drives the
obsolete-code-removal targets for steps 1–8/10):
`registerInterfaceProxy` ×34, `registerSupplementaryMethod` ×10,
`registerGenericConstructor` ×4, `registerGenericTypeWrapper` ×4,
`registerBridgedMethodInterceptor` ×4, `registerBridgedStaticMethodInterceptor` ×2,
`registerTypeCoercion` ×2, `BridgedClass.registerSupertypes` ×1 (70 entries).
`_Interpreted*` proxy classes: 40 (AST) / 41 (non-AST).

---

## 0d — Documentation refresh

- **New** `tom_d4rt_ast/doc/runtime_registration_surface.md` — the canonical
  (web-capable) component reference: the nine-sink registration API, the
  `BridgedClass` supertype mechanism + transitive walk + last-match-wins
  filter, the interface-proxy / generic-wrapper / RC-2 / RC-3-coercion model,
  and the 0b web-divergence map.
- **New** `tom_d4rt/doc/runtime_registration_surface.md` — the VM-side
  counterpart: points to the canonical AST doc for the shared model and lists
  the VM-only specifics (the extra `_InterpretedKeepAliveState`, the
  `RouterDelegate<Object>` choice).
- **Corrected** `tom_d4rt/doc/advanced_bridging_user_guide.md` RC-9 section —
  it documented `registerPropertyInterceptor` / `InterceptedValue` /
  `interceptPropertyAccess`, **none of which exist**; the section now records
  that property interception is handled by the field-based
  `interpretedStatefulWidget` / `nativeStateProxy` mechanism in
  `runtime_types.dart`.

These are the baseline the later MCI per-step doc updates extend.

---

## 0e — Base-test runner + green baseline

The `test/run_base_tests.{sh,ps1}` runners exist in **both** Flutter
components (created in P&R step 0f, idle-watchdog wrapped) and the green
baseline is the shared P&R **0g** anchor — both components **+105 essential
(104 scripts) / +162 important (161 scripts), 0 fail** (first-pass wedges were
the A.1 cold-start transport transient, clean on isolated re-run). MCI step 0
introduces **no code change**, so that anchor is re-used verbatim; every MCI
regen + base-test gate compares against it. The full
`run_issue_analysis_tests.*` 13-file × 2-component reference sweep remains
**deferred** to end-of-reduction (shared with the P&R deferral), not required
to establish a documentation/review baseline.
