# Step-0 Review Baseline — Proxy & Relaxer Generation Optimization

**Quest:** d4rt · **Date:** 2026-06-05 · **Source todo:** cleanup_todos.md #1
(= `proxy_and_relaxer_generation_optimization.md` step 0, sub-steps a–g).

This is the durable record produced by the step-0 code review. It is the
accurate baseline that later steps (1–7) amend. Generation **metrics** live
separately in `mass_generation_reduction.md` (step 0d); this doc holds the
pipeline data-flow map (0a), the line-reference verification (0a), the
runtime-contract / twin-divergence result (0b), the test inventory + gap map
(0c), and the documentation-review outcome (0e).

---

## 0a — Pipeline data-flow map

Two generators (`relaxer_generator.dart`, `proxy_generator.dart`) emit the
four mass-generated categories; `bridge_api.dart` orchestrates the end-to-end
flow. Entry points (file:line):

| Stage | What | Where |
|-------|------|-------|
| 1. Load config | `buildkit.yaml` `d4rtgen:` → `BridgeConfig` | `build_config_loader.dart:28` (`loadFromTomBuildYaml`), invoked `bridge_api.dart:98` |
| 2. Summary cache | build/load `.sum` bundles | `bridge_api.dart:149` (`runSummaryCacheStage`) |
| 3. Pre-scan user bridges | walk `lib/src/d4rt_user_bridges/` then `lib/d4rt_user_bridges/`, resolve to `LibraryElement`, feed scanner | `bridge_api.dart:441` (`_preScanUserBridges`, called ~:171) → `user_bridge_scanner.dart:261` (`scanLibrary`) |
| 4. Per-module bridge emission | construct `BridgeGenerator`, emit each module `*.b.dart`; accumulate `classLookup`, `genericExtractionSites`, `gen075Classes` | `bridge_api.dart:208` → `bridge_generator.dart:2247` (`generateBridgesFromExports`) |
| 5. Barrel / dartscript / test-runner files | optional | `bridge_api.dart:281–318` |
| 6. **Proxies** | if `generateProxies` && `proxyClasses` non-empty | `bridge_api.dart:327` → `proxy_generator.dart:203` (`generateProxies`) |
| 7. **Relaxers (LAST)** | always; consumes accumulated lookup + extraction sites | `bridge_api.dart:349` → `relaxer_generator.dart:109` → `_buildRelaxerTargets` (`relaxer_generator.dart:384`) |

Supporting classes: `BridgeGenerator` (`bridge_generator.dart:1052`),
`UserBridgeScanner` (`user_bridge_scanner.dart:207`),
`PerPackageBridgeOrchestrator` (`per_package_orchestrator.dart:87`, a distinct
per-package dedup path that runs stages 1–4 and delegates proxies/relaxers to
its caller), `BuildConfigLoader` (`build_config_loader.dart:23`).

**Note (not a defect, but a hazard for later steps):** there are two
orchestration paths that mirror the same 1→7 ordering — `bridge_api.dart`
(`generateBridges`, :80) and `v2/d4rtgen_executor.dart` (own `_scanUserBridges`
:120, proxies :365, relaxers :389). Any generator-side change in steps 4/5/6
must be applied to **both** paths or verified that only one is the live caller.

### Line-reference verification (§2–§4 of the analysis doc vs current code)

Re-verified every cited line. Result: **accurate** — all references are exact
or within ±1 line, with **one** correction:

| Doc ref | Symbol | Actual | Status |
|---------|--------|-------:|--------|
| relaxer `384` | `_buildRelaxerTargets` | 384 | ✓ |
| relaxer `197/233` | `typeParameters.length != 1` | 197, 233 | ✓ |
| relaxer `408` | `_dartCoreGenericTypes` (use) | 408 (decl 593) | ✓ |
| relaxer `1438` | `_generateFactoryFunction` | 1438 | ✓ |
| relaxer `470–477 / 574–580` | `allConcreteBridgedTypes` loops (Step 2b/2c) | 440 decl, 470, 574 | ✓ |
| relaxer `1500` | `registerRelaxers()` body | **1520** (doc-comment 1499) | **corrected → 1520** |
| relaxer `1849 / 1962 / 2220` | ctor-section / factory / RC-2 case | 1849, 1962, 2220 | ✓ |
| relaxer `1880–1891 / 2191–2211` | `allBridgedTypes` decl + loop | 1880, 2191 | ✓ |
| proxy `203` | `generateProxies` | 203 | ✓ |
| bridge_config `355/362/368/386/405/420` | config fields | all exact | ✓ |
| bridge_config `257` | `ProxyClassConfig.fromYaml` | 257 | ✓ |
| bridge_config `444–483 / 535–561 / 564–606` | fromJson / toJson / copyWith | exact | ✓ |

The `registerRelaxers() (1500)` drift was corrected in the analysis doc.

---

## 0b — Runtime contract & d4.dart twin divergence

`d4.dart` exists in two places that must stay in lockstep:
`tom_d4rt_ast/lib/src/runtime/generator/d4.dart` (2,437 lines, web-capable)
and `tom_d4rt/lib/src/generator/d4.dart` (2,389 lines).

**Registries** (all process-global static fields on `D4`, keyed by class-name
`String`), AST line / tom_d4rt line:

| Registry | AST | tom_d4rt | Category |
|----------|----:|---------:|----------|
| `_genericTypeWrappers` | 132 | ~130 | A/B |
| `_interfaceProxies` | 184 | 182 | D |
| `_genericConstructors` | 329 | 307 | C |
| `_typeCoercions` / `_typeCoercionsByType` | 258 / 284 | — / 262 | RC-3 |

**Resolution order** in `extractBridgedArg<T>` (AST line 1271): generic-wrapper
(success returns **1410 / 1420**) → interface-proxy (1639–1644) → RC-3
coercion (success return **1657**) → **throw** at 1667–1669, with the
insertion landmark at **1662** (right after the coercion block closes at 1660,
before the throw preamble). There is **no silent `<dynamic>` fallback** at this
leaf — it rethrows. This is the single insertion point for the step-3
user-factory lookup and the step-2 enriched message; the step-1 logging hooks
are the success returns (1410/1420 wrappers, 2243 proxies, 1657 coercions) and
the 1662 miss.

**Twin divergence:** the two files are **semantically identical** along the
resolution path. A region diff (lines 1250–1700) shows only (a) cosmetic
`dart format` line-wrapping differences and (b) a constant line-number offset
(registries sit ~2 lines earlier in `tom_d4rt`, growing to ~40 lines later
because the AST file carries slightly more comment text). **No semantic
divergence defect to file.** Every step that touches d4.dart must still mirror
into both, keeping the web caveat in mind (AST is the only web-capable twin).

**Public extension API** (identical on both runners): `registerExtensions` +
`finalizeBridges` on the AST `D4rtRunner` (`d4rt_runner.dart`) and the `D4rt`
facade (`tom_d4rt/lib/src/d4rt_base.dart`). The new step-3
`registerRelaxerFactory` / `registerInterfaceProxy` / `registerGenericConstructor`
should be thin public delegates to the static `D4.register…` sinks, called
inside a `registerExtensions` body.

---

## 0c — Test inventory & gap map (steps 1–7)

Generator tests live in `tom_d4rt_exec/test/generator_tests/` (**22** top-level
`*_test.dart` + `fixtures/` + a `v2/` subtree). Runtime/interpreter behaviour
is exercised by the Flutter corpus at
`tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/`
(**2,069** `*_test.dart` scripts) plus the per-component
`essential/important/secondary/hardly_relevant*` corpus files. Source-direct
documentation samples (for step 7/d) live under `tom_d4rt_flutter_test/lib/src/`.

| Step | Feature | Existing coverage | Gap / fixtures to reuse |
|------|---------|-------------------|--------------------------|
| 1 | Runtime usage logging + miss-tracking | **none** (no logging exists) | new; reuse `d4_example_test.dart`, `d4rt_coverage_test.dart` to drive d4.dart paths |
| 2 | Enriched miss-message @1662 | partial (`type_erasure_test.dart`, `edge_cases_test.dart` exercise extraction failures) | new assertion on message text; **sweep** both suites for old-message assertions before changing the contract |
| 3 | Public user-registration API + pre-throw lookup | `user_bridge_test.dart` (user-bridge pattern is the closest model) | new tests for `registerRelaxerFactory`/`registerInterfaceProxy`/`registerGenericConstructor` + the 1662 lookup |
| 4 | Generator reduction knobs | `bridge_config_test.dart` (config parse/round-trip — reuse for new flags) | new generation tests proving default = byte-identical, flag-on = reduced |
| 5 | Corpus type-combination scanner | **none** | new; input corpus is the 2,069-script set above |
| 6 | `@D4rtUserProxy`/`@D4rtUserRelaxer` + multi-param | `user_bridge_test.dart` + `user_bridge_scanner` fixtures (annotation-scan model) | new annotation discovery/parse/expand tests; **multi-type-param generation does not exist yet** |
| 7 | Documentation + worked samples | n/a | draw runnable samples from `tom_d4rt_flutter_test/lib/src/` |

**Regression gate for every regen step:** the new base-test runner
(`test/run_base_tests.{sh,ps1}`, step 0f) runs essential + important on both
components; the full `run_issue_analysis_tests.*` (13 files) is the complete
reference pass.

---

## 0e — Documentation review outcome

Reviewed the authoritative component docs in `tom_d4rt_generator/doc/`:
`bridgegenerator_user_guide.md`, `bridgegenerator_user_reference.md`,
`proxy_class_generation.md`, `generics_wrapper_and_type_relaxation_strategy.md`,
`generic_constructor_and_other_extensions.md` (plus `user_bridge_user_guide.md`).

Outcome: the **code review found the pipeline descriptions and line references
accurate against current code** (single drift corrected, §0a). The one stale
artifact was the **metrics** in `mass_generation_reduction.md` (135 k vs the
current 181 k lines) — refreshed under step 0d with a dated, reproducible
baseline that supersedes the April figures. No substantive rewrite of the five
component guides was warranted by the review; they are the accurate baseline
that **step 7** later extends with worked samples. This doc + the refreshed
metrics doc are the authoritative step-0 baseline.

---

## 0f — Base-test runner

Created `test/run_base_tests.{sh,ps1}` in **both** Flutter components
(`tom_d4rt_flutter` and `tom_d4rt_flutter_ast`), the short sibling of
`run_issue_analysis_tests.*`. It runs ONLY the two heaviest corpus files
(`essential_classes_test.dart`, `important_classes_test.dart`) **strictly
serial**, file by file, into `doc/basetestlog_<ID>/` — the fast regression
gate after any bridge/proxy/relaxer regen. The runners wrap each
`flutter test` in an **idle-output watchdog** (`idle_timeout.{sh,ps1}`,
default 70 s) that kills a wedged transport fast (exit 124, noted
`IDLE-KILLED`), so an A.1 transport wedge fails the file instead of hanging
the whole run. Both components' scripts are byte-identical.

## 0g — Green-starting-point baseline (2026-06-05)

Base-test run on both components. **Both are fully green** — the two
combinatorial generators have a clean starting point before any reduction
work:

| Component | essential | important |
|-----------|-----------|-----------|
| `tom_d4rt_flutter_ast` (AST / pre-bundled) | **+105** (104 scripts, 0 fail) | **+162** (161 scripts, 0 fail) |
| `tom_d4rt_flutter` (source-direct) | **+105** (104 scripts, 0 fail) | **+162** (161 scripts, 0 fail) |

**A.1 cold-start wedge caveat (load-induced flakiness, not a regression).**
The *first* run of each component's pair showed one file wedged while the
other was clean (AST: essential `+2 −103`, important `+162`; non-ast:
essential `+105`, important `+39 −123`). Per-script `[METRIC]` logs trace
every failure to the documented A.1 transport-wedge cascade: one script
hitting the in-app 30 s build timeout (`httpStatus=400`) poisons the shared
HTTP companion app and cascade-fails the rest of that file
(`appInterpretStartMs=-1`). Re-running each wedged file **alone** produced a
clean all-pass (AST essential `+105`, non-ast important `+162`,
`status=success` for every script, `httpMs` in the normal 1–3 s band). No
generator/runtime/bridge code changed during step 0, so the wedge is the
pre-existing A.1/B.11/B.14 cold-start transport transient — load noise, not a
step-0 regression. Logs: `doc/basetestlog_20260605-step0/` in each component
(wedged `*_classes_test.*` + clean `*_rerun.*`).

**Full reference pass (`run_issue_analysis_tests.*`, 13 files × 2
components) — deferred.** The base-test pair is the green gate that gates the
reduction work; the full 13-file reference sweep is a multi-hour serial run
and is **not** required to establish the step-0 starting point. It is the
complete reference pass to run once at the *end* of the reduction work (and
after any large regen) to catch corpus-wide regressions beyond
essential+important. Deferred to that point rather than burned now.
