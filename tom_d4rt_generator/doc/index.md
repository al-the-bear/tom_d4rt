# tom_d4rt_generator — Documentation Index

The bridge generator reads `buildkit.yaml` / `build.yaml`, follows barrel
files, and emits `*.b.dart` bridge registrations (plus relaxer wrappers,
generic-constructor factories, and proxy classes) that let the `tom_d4rt`
interpreter call native Dart code. This index is the navigable entry point to
the generator's documentation, organized by the four mechanism areas that the
proxy/relaxer optimization work (quest `d4rt`, P&R campaign) consolidated.

> Maintenance note: the generator is the **single source of truth** for every
> `*.b.dart`. Never hand-edit generated files — fix the generator and
> regenerate. See the quest rule in `_ai/quests/d4rt/overview.d4rt.md`.

---

## Getting started

| Doc | What it covers |
|-----|----------------|
| [bridgegenerator_user_guide.md](bridgegenerator_user_guide.md) | Quick start: dependencies, annotations, running `build_runner`. |
| [d4rt_generator_cli_user_guide.md](d4rt_generator_cli_user_guide.md) | The `d4rtgen` CLI (no-build_runner generation, CI, batch). |
| [bridgegenerator_user_reference.md](bridgegenerator_user_reference.md) | `build.yaml` builder-configuration reference. |

---

## The four mechanism areas

The generator emits four categories of artifact. The labels **A–D** are the
ones used throughout the codebase and in
[mass_generation_reduction.md](mass_generation_reduction.md):

| Cat | Artifact | Selection | Canonical doc |
|-----|----------|-----------|---------------|
| **A** | `$Relaxed*<V>` type-relaxing wrapper classes | auto (1 type param) | [generics_wrapper_and_type_relaxation_strategy.md](generics_wrapper_and_type_relaxation_strategy.md) |
| **B** | `_relax*` factory switches (`registerGenericTypeWrapper`) | auto + combinatorial | [generics_wrapper_and_type_relaxation_strategy.md](generics_wrapper_and_type_relaxation_strategy.md) |
| **C** | `_rc2*` generic-constructor factories (`registerGenericConstructor`) | auto + combinatorial | [generic_constructor_and_other_extensions.md](generic_constructor_and_other_extensions.md) |
| **D** | `D4rt*` proxy classes (`registerInterfaceProxy`) | explicit `proxyClasses:` | [proxy_class_generation.md](proxy_class_generation.md) |

### 1. Categories — wrappers, relaxers, constructor factories, proxies

- **Type relaxation (A/B):** why erased generics (`ValueNotifier<dynamic>` ≠
  `ValueNotifier<MagnifierInfo>`) need relaxing wrappers and factory switches —
  [generics_wrapper_and_type_relaxation_strategy.md](generics_wrapper_and_type_relaxation_strategy.md).
- **Generic constructors + runtime extensions (C):** the RC-1…RC-5 runtime
  registration categories that complement the generated bridges —
  [generic_constructor_and_other_extensions.md](generic_constructor_and_other_extensions.md).
- **Proxy classes (D):** native subclasses of abstract framework classes
  (`CustomPainter`, `FlowDelegate`, …) that delegate to interpreter callbacks —
  [proxy_class_generation.md](proxy_class_generation.md).

### 2. Reduction config — deciding what gets emitted

The combinatorial B/C switch families dominate generated size. The reduction
knobs let a consumer trade generate-everything for a scanned allowlist.

- [mass_generation_reduction.md](mass_generation_reduction.md) — the measured
  baselines, category counts, and the `generateAllRelaxers` /
  `relaxerClasses` / `additionalRelaxerTypes` knobs (P&R#4), plus the
  test-corpus type scanner workflow (`scan_corpus_types`, P&R#5) and the
  `corpus_relaxer_allowlist.yaml` artifact.

### 3. User registration — overriding what the generator can't derive

- [user_bridge_user_guide.md](user_bridge_user_guide.md) — authoring
  `@D4rtUserBridge` overrides for members the generator handles incorrectly.
- [userbridge_override_design.md](userbridge_override_design.md) — the design
  of the override pre-scan and registration routing.
- Programmatic registration (`registerRelaxerFactory`, the typed-execute and
  extension-hook API) is covered in the `tom_d4rt_ast` docs
  (`extension_registration.md`); the generator emits the registrations these
  consume.

### 4. Annotation patterns — declared variant generation

- `@D4rtUserProxy` / `@D4rtUserRelaxer` declare the concrete type-argument and
  mixin-set variants the generator should emit for a base class, including the
  single-`*` wildcard pattern (`$0` full / `$1` captured) and multi-type-param
  expansion. The parsing/expansion engine
  (`lib/src/user_variant_pattern.dart`) and the annotations shipped under
  P&R#6 / MCI#3 / MCI#6; the **annotation-driven emission** and worked
  examples are part of the deferred tail (see Status below).

### Web-divergence registry (VM↔web signature skew)

- [vm_web_skew_coercion.md](vm_web_skew_coercion.md) — the full reference:
  `_vmWebSkewNonNullParams` in `bridge_generator.dart` records parameters that
  are nullable on the VM SDK but non-nullable on web (dart2js), so the
  generator can emit a `?? default` coercion. Seeded with
  `SceneBuilder.pushOpacity.offset`. Gated behind the default-off
  `enableVmWebSkewCoercion` flag (B5/R6, MCI#10 / cleanup_todos #38). The doc
  covers the mechanism (registry / gate / integration site), the
  extend-the-registry recipe, the interim `SceneBuilderUserBridge` override and
  its retirement, the unit tests, and the deferred both-twin regen tail.

---

## Status — shipped cores vs. deferred tails

The P&R / MCI campaign shipped each mechanism's **analyzer-free / config core
with unit tests** while deferring the heavyweight tails (annotation-driven
emission, both-twin regeneration, serial `flutter test` + dart2js/web smoke,
and obsolete-code removal). The authoritative live status is in the quest:

- `_ai/quests/d4rt/cleanup_todos.md` — the ordered backlog with per-item
  DONE / DEFERRED status.
- `_ai/quests/d4rt/completion_steps.d4rt.md` — the deferred regen / integration
  tails, including the worked-samples + executable-docs harness (P&R#7 b/c).

The worked-sample apps that the deferred docs will draw from live under
`tom_d4rt_flutter_test/example/` (calculator, clock_face, counter_app,
stopwatch_laps, tip_calculator) — **not** `lib/`, as some older prose states.

---

## Plans, reviews, and historical analysis

These are development-time records, not user documentation; kept for context:

| Doc | Purpose |
|-----|---------|
| [step0_review_baseline.md](step0_review_baseline.md), [mci_step0_review_baseline.md](mci_step0_review_baseline.md), [open_step0_review_baseline.md](open_step0_review_baseline.md) | P&R step-0 component reviews / baselines. |
| [summary_refactoring_plan.md](summary_refactoring_plan.md), [baseline_summary_refactor.md](baseline_summary_refactor.md) | Refactoring plan + summary. |
| [reexport_implementation_plan.md](reexport_implementation_plan.md) | Re-export resolution plan. |
| [flutter_fixes_1.md](flutter_fixes_1.md), [flutter_fixes_2.md](flutter_fixes_2.md) | Flutter-corpus fix logs. |
| [summary_phase7_regression.md](summary_phase7_regression.md), [test_coverage.md](test_coverage.md), [issues.md](issues.md) | Regression / coverage / issue logs. |

> Stale-prose flags (do not treat as current): the April "Current Scale"
> figures in `mass_generation_reduction.md` are explicitly superseded by its
> 2026-06-05 step-0 baseline; `generic_constructor_and_other_extensions.md`
> references `tom_d4rt_flutterm` paths — the live flutter-material twins are
> `tom_d4rt_flutter` and `tom_d4rt_flutter_ast`.
