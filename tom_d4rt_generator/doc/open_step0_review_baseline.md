# OPEN Step 0 — Review + Sync/Divergence Baseline

**Date:** 2026-06-05
**Scope:** cleanup_todos.md item #3 — "Re-verify all file/line references in
OPEN against the current tree; build the tom_d4rt ↔ tom_d4rt_ast sync/divergence
map." Verification + documentation only; **no production code changed**.
**Source doc:** `_ai/quests/d4rt/interpreter_generator_open_issues.md` (the
623-line canonical OPEN log), HEAD `2e38dd0b`.

This is the durable record for OPEN Step 0, modelled on
`mci_step0_review_baseline.md`. It captures the line-ref verification (0a), the
sync/divergence map for the targets the OPEN items act on (0b), and the
baseline/component-doc reuse (0c/0d).

---

## Key premise: library source is unchanged since OPEN HEAD

P&R#0 and MCI#0 (cleanup_todos #1/#2) made **no production code changes** — they
were code-review + documentation-baseline steps. Therefore no library `.dart`
source has moved since OPEN's references were first written. **Any line-ref
mismatch found below is an original doc error, not code drift.** This narrows 0a
to correcting genuine transcription errors rather than chasing moved code.

---

## 0a — Line-reference verification

All commit hashes cited in OPEN §1 are valid with matching subjects (14/14).
The reference drift found and corrected inline in the OPEN doc:

| OPEN site | Symbol | Doc said | Actual (verified) |
|---|---|---|---|
| §1 (int→double coercion) | `relaxer_generator.dart` `_coerceToV` | `:630` | **`:643`** |
| §1 (`whereType`/`characters`) | `registration.dart` | `registration.dart:296` | **`tom_d4rt/lib/src/bridge/registration.dart:296`** (doc-comment anchor for `String.characters`) |
| A.6 (`MemoryImage` codec) | banner ignored-pattern | `main.dart:364` | **`tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/lib/main.dart:391`** ("Codec failed to produce an image", tagged "1944 TODO A.1") |
| B.14 (input-pump starve) | `callable.dart` sync `_callImpl` branch | `:1287` | **`:1201`** (`_callImpl` def; dispatch at `:1196`) |
| B.14 | `_InterpretedCustomPainter.paint` | `d4rt_runtime_registrations.dart:2826` | **`:2988` (AST)** / `~:3170` (non-AST); class at AST `:2977` |
| B.14 | `_rc2GenerateFunctionWrapper` | `relaxer_generator.dart:2664` | **`:2782`** (def; call sites at `:2329/:2386/:2486/:2521`) |
| B.14 | `D4.callInterpreterCallback` | `d4.dart:1889` | **`:1934` (VM)** / **`:1972` (AST)**; `:1889`/`:1894` are the dispatch block |
| C.3 (non-wrappable defaults) | `BridgeGenerator._wrapDefaultValue` | symbol cited | **does not exist** → real: `_isWrappableDefault` (`bridge_generator.dart:4727`, returns `bool`) + `_recordNonWrappableDefault` (`:4746`); throwing fallback is `getRequiredArgTodoDefault`/`getRequiredNamedArgTodoDefault` |

Confirmed accurate (no change needed): DiagnosticableTreeMixin reg `:597` /
proxy `:4860`; ChangeNotifier `:554` / Listenable `:563`; StatelessWidget `:292`
/ StatefulWidget `:305`; `registerSupplementaryMethod('State','widget')` `:2023`
/ `('setState')` `:2047`; `element_mode_extractor.dart:1029-1037` (GEN-042);
`list.dart:221` (whereType); `callable.dart:1240` (async area); `timer.dart:18`;
`timeout_tests_test.dart:488-504` (both component copies present);
`interpreter_unfixable.md:7272` / `:7304-7326` (AST copy).

### Substantive finding — C.4 is already fixed

`D4.getNamedArgWithDefault<T>` (`tom_d4rt/lib/src/generator/d4.dart:1749`, mirror
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart:1791`) already gates on
`containsKey` only and preserves a nullable-`T` explicit `null`
(`if (null is T) return null as T;`). The buggy `|| named[p] == null` guard the
C.4 bug describes is gone in **both** twins. Flagged in the OPEN doc as a §1
candidate: when item #15 (C.4) is reached, confirm with a repro/unit test and
move the row to §1 — **no code change expected**.

---

## 0b — tom_d4rt ↔ tom_d4rt_ast sync/divergence map (OPEN targets)

The registration **API** is in lockstep across the twins — the nine `D4.register*`
sinks and the helpers the OPEN items touch all exist twin-for-twin, offset only
by a constant comment-block delta. Verified pairs relevant to OPEN:

| Symbol (OPEN target) | tom_d4rt (VM) | tom_d4rt_ast (web) | Status |
|---|---|---|---|
| `getNamedArgWithDefault` (C.4) | `generator/d4.dart:1749` | `runtime/generator/d4.dart:1791` | in sync (already-fixed) |
| `callInterpreterCallback` (B.14) | `generator/d4.dart:1934` | `runtime/generator/d4.dart:1972` | in sync |
| `_callImpl` (B.14) | `callable.dart:1201` | mirror | in sync |
| `_isWrappableDefault` / `_recordNonWrappableDefault` (C.3) | generator-only (`bridge_generator.dart:4727/:4746`) | — | generator, single-sourced |
| `_coerceToV` / `_rc2GenerateFunctionWrapper` (B.14/§1) | generator-only (`relaxer_generator.dart:643/:2782`) | — | generator, single-sourced |

Functional divergence lives **only** in the downstream manual registration file
`tom_d4rt_flutter{,_ast}/lib/src/d4rt_runtime_registrations.dart` (AST **4925**
lines / non-AST **5102** lines):

| Divergence | Status | Tracked |
|---|---|---|
| `_InterpretedKeepAliveState` (`AutomaticKeepAliveClientMixin`) + walk/dispatch — **non-AST only** | accidental drift (web twin behind) | MCI #3 (`mixinVariants:` State family) |
| `RouterDelegate<Object>` (non-AST) vs `<dynamic>` (AST) | suspected drift — one is wrong | MCI #2 |
| `scene_builder_user_bridge.dart` — **AST only** | legitimate web-only artifact (VM↔web `SceneBuilder` skew) | — |
| narrow `src/runtime/…` imports (AST) vs single barrel (non-AST) | legitimate (AST barrel does not re-export the same internals) | — |

The line-referenced canonical of this map is §0b of `mci_step0_review_baseline.md`
and §5 of `tom_d4rt_ast/doc/runtime_registration_surface.md`.

---

## 0c — Base-test baseline (reused)

No code changed in OPEN Step 0, so no new test run was required. The anchor is the
P&R#0 0g green baseline (`tom_d4rt_generator/doc/step0_review_baseline.md`):
`test/run_base_tests.{sh,ps1}` present in **both** Flutter components; both
components **+105 essential / +162 important, 0 fail** (serial only — shared HTTP
companion app). Every later OPEN fix gate compares against this anchor.

---

## 0d — Component docs (reused) + discrepancies flagged

- Runtime-surface component docs reused from MCI#0:
  `tom_d4rt_ast/doc/runtime_registration_surface.md` (canonical) +
  `tom_d4rt/doc/runtime_registration_surface.md` (VM thin pointer).
- **OPEN component-doc copies are stale.**
  `tom_d4rt_flutter/doc/interpreter_generator_open_issues.md` and
  `tom_d4rt_flutter_ast/doc/interpreter_generator_open_issues.md` are **332 lines
  each** — a shorter, older snapshot of the 623-line canonical in
  `_ai/quests/d4rt/`. Flagged here for a later sync; not corrected in Step 0
  (out of scope — verification only).
- **§5 source logs are AST-component-only.** `interpreter_issues.md`,
  `interpreter_unfixable.md`, and `generator_issues.md` exist only in
  `tom_d4rt_flutter_ast/doc/`; the non-AST component has no copies. §5 line
  anchors (e.g. `interpreter_unfixable.md:7272`, `:167-194`) resolve against the
  AST component.
