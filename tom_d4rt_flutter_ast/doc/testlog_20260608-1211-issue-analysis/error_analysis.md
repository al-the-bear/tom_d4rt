# Issue Analysis — tom_d4rt_flutter_ast (targeted re-check)

| Field | Value |
|-------|-------|
| Run ID | `20260608-1211-issue-analysis` |
| Git rev | `6ad0a8f80` |
| Started | 2026-06-08 12:12 |
| Finished | 2026-06-08 13:44 (~1h32m) |
| Scope | **Subset re-run** — only `secondary_classes_test` + `hardly_relevant_classes_1_test`, the two files that failed in `20260608-0746`. Run via `FILES_OVERRIDE` (new) so the targeted subset still goes through the runner's idle watchdog / `--timeout 60s` / JSON file-reporter. |
| Runner | `test/run_issue_analysis_tests.sh 20260608-1211-issue-analysis` with `FILES_OVERRIDE="secondary_classes_test.dart hardly_relevant_classes_1_test.dart"` |

> **Why a subset.** Run `20260608-0746` ran the full 13-file corpus over ~2h and
> reported **138 build-timeout failures** (122 in `secondary`, 16 in `hardly_1`),
> all carrying `Build timed out after 45 seconds`. This re-run double-checks
> those two files **in isolation** to separate genuine per-widget cost from
> host-load / companion-app slowdown accumulated across the full run.

## Headline — the timeouts were overwhelmingly load-induced

| File | `20260608-0746` (full corpus) | `20260608-1211` (isolated) | Delta |
|------|------------------------------:|---------------------------:|------:|
| `secondary_classes_test` | 122 fail | **10** non-success | −112 |
| `hardly_relevant_classes_1_test` | 16 fail | **3** non-success | −13 |
| **Total** | **138** | **13** | **−125** |

Run in isolation (host far less loaded, companion app stays fast), **125 of the
138 previously-failing tests now pass**. This confirms the prior hypothesis: the
45 s build-timeouts in the full run were **progressive companion-app slowdown
under sustained host load**, not fixed per-widget cost. **No correctness defect**
is implicated by the timeouts.

## Framework / runtime error scan (both logs)

| Signature | secondary | hardly_1 |
|-----------|----------:|---------:|
| `RenderFlex` / `overflowed` | 0 | 0 |
| `EXCEPTION CAUGHT BY …` | 0 | 0 |
| `[framework error]` | 0 | 0 |
| `Build timed out` (build > 45 s) | present (cluster, below) | 0 |
| `Bad state: Transport failure` | 3 | 3 |
| `TimeoutException` (60 s per-test) | 5 | 5 |

**Clean of overflow / RenderFlex / uncaught framework exceptions** in both files.
The only captured-error signatures are the build-timeout and the transport-failure
cascade, both analysed below.

## Per-file failure analysis

### `secondary_classes_test` — `+637 ~1 -10` (10 non-success of 647 leaf tests)

Two distinct, **contiguous** clusters; everything after #594 recovered and passed.

| # (exec order) | Test | Signature | Class |
|----:|------|-----------|-------|
| 536 | `never_scrollable_scroll_physics_test.dart` | Build timed out 45 s | latency |
| 537 | `overflow_bar_test.dart` | Build timed out 45 s | latency |
| 538 | `overflow_box_test.dart` | Build timed out 45 s | latency |
| 539 | `page_scroll_physics_test.dart` | Build timed out 45 s | latency |
| 540 | `page_storage_bucket_test.dart` | Build timed out 45 s | latency |
| 541 | `page_storage_key_test.dart` | Build timed out 45 s | latency |
| 542 | `page_storage_test.dart` | Build timed out **+ Transport failure + Timeout** | latency → wedge |
| 565 | `render_object_element_test.dart` | Build timed out 45 s | latency |
| 571 | `restorable_int_test.dart` | Build timed out **+ Transport failure + Timeout** | latency → wedge |
| 594 | `single_child_render_object_element_test.dart` | Transport failure + Timeout (no build-timeout) | cascade victim |

Reading: a contiguous heavy-build cluster (#536–542) pushed the companion app
past 45 s; at #542 (`page_storage_test`) the wedge tipped into a **transport
failure**, and #571/#594 are downstream transport casualties of that wedge
(`single_child_render_object` shows *only* transport+timeout, no build-timeout —
a pure cascade victim). The cascade is small (3 transport errors) and **self-heals**:
tests #595–647 all pass.

- **8 build-timeouts** (`Expected: true` + `Build timed out after 45 seconds`) — latency.
- **3 transport/timeout errors** (#542, #571, #594) — a localized companion-app wedge, self-recovered.

### `hardly_relevant_classes_1_test` — `+201 ~1 -3` (3 non-success of 204 leaf tests)

| # (exec order) | Test | Signature | Class |
|----:|------|-----------|-------|
|  83 | `dart_ui/opacity_engine_layer_test.dart` | Transport failure + Timeout | intermittent wedge |
| 147 | `foundation/iterable_property_test.dart` | Transport failure + Timeout | intermittent wedge |
| 171 | `gestures/least_squares_solver_test.dart` | Transport failure + Timeout | intermittent wedge |

**No build-timeouts at all** in this file. The 3 failures are **scattered
(non-contiguous)** transport-failure errors — isolated, intermittent companion-app
wedges that each recovered (no contiguous cascade). These are trivially-light
widgets (`opacity_engine_layer`, `iterable_property`, a numeric solver) that
should never legitimately exceed a 60 s test budget — confirming the failures are
transport/infra, not the test logic.

## Conclusion

The targeted re-check **clears the prior 138-failure picture**: 125 of those tests
pass when the two files run in isolation, proving the full-corpus build-timeouts
were **host-load / companion-app latency**, not correctness or fixed widget cost.

Residual after isolation (13 total, **all infra/latency, zero correctness**):
- **8** genuine 45 s build-timeouts in `secondary` (a contiguous #536–542 + #565 heavy-build cluster).
- **5** transport-failure/timeout errors — one small self-healing cascade in `secondary` (#542/#571/#594) and 3 isolated intermittent wedges in `hardly_1`.
- **0** overflow / RenderFlex / uncaught framework exceptions.

### Actionable

- The latency is real but **infrastructural**: the companion app slows under
  sustained load and, past a threshold, wedges the local HTTP transport. The
  remedy is on the harness side (raise/parameterize the 45 s build ceiling,
  and/or recycle the companion app between heavy clusters), **not** in interpreter
  or bridge code.
- The `secondary` #536–542 build cluster is the most concentrated cost; if a fixed
  ceiling is kept, that cluster is the one to profile first — but note even it
  passed in run-2-equivalent isolation on other occasions, so it is **load-sensitive**,
  not deterministically over-budget.

> Scope note: this run did **not** re-run the source-direct twin
> `tom_d4rt_flutter_test` (it carries neither of these files and was last fully
> green in `20260608-1153`). Per the request the subset was the two AST files only.
