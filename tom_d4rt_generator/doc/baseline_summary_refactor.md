# Phase 0 — Summary Refactor Baseline

Regression oracle for the `tom_d4rt_generator` summary-backed refactoring
(see `doc/summary_refactoring_plan.md`). Every subsequent phase MUST keep
these test results flat: zero new failures; pre-existing failures may
stay failing with the **same test IDs** listed below.

- **Baseline captured:** 2026-04-22
- **Generator HEAD at capture:** `8b30ff9983b35c2ed4570ac5eb03fe9158159205`
  (= `main` after `docs(tom_d4rt_generator): add summary-backed
  refactoring plan`; no generator code changes — any prior experimental
  `TOM_D4RT_BRIDGE_USE_SUMMARIES` scaffolding was stashed before
  regeneration).
- **d4rtgen binary used for non-flutterm consumers:** `d4rtgen v1.8.16+57`
  (precompiled, from `$TOM_BINARY_PATH`).
- **Flutterm regen tool:** `dart run tool/regenerate_bridges.dart` (uses
  local path-dep on `../tom_d4rt_generator`).

## Per-consumer baseline table

| Consumer | Tests | Passed | Failed | Skipped | Baseline file | Notes |
|---|---|---|---|---|---|---|
| `tom_d4rt_flutterm` (essential) | 111 | 111 | 0 | 0 | `doc/baseline_runs/essential.json` | All pass. |
| `tom_d4rt_flutterm` (important) | 172 | 171 | 1 | 0 | `doc/baseline_runs/important.json` | 1 known fail: `services/codecs_test.dart` (id=161). |
| `tom_d4rt_flutterm` (secondary) | 657 | 656 | 1 | 0 | `doc/baseline_runs/secondary.json` | 1 known fail: `widgets/gesture_detector_adv_test.dart` (id=145). |
| `tom_d4rt_flutterm` (bridge_execution) | 4 | 4 | 0 | 0 | sanity-run transcript in log | Quick smoke — not a gate but useful. |
| `tom_d4rt_dcli` | 704 | 702 | 2 | 0 | `tom_d4rt_dcli/doc/baseline_0422_2007.csv` | Both fails are VS Code live-bridge tests (need active VS Code session). |
| `tom_d4rt_exec` | 2244 | 2233 | 11 | 0 | `tom_d4rt_exec/doc/baseline_0422_1959.csv` | All 11 fails carry the `(FAIL)` marker in description — known accepted failures. |
| `tom_dcli_exec` | 75 | 72 | 3 | 0 | `tom_dcli_exec/doc/baseline_0422_2008.csv` | 3 environment-dependent fails (process_execution / redirect / environment in advanced dcli-project tests). |
| `tom_d4rt` | 1703 | 1699 | 3 | 1 | `tom_d4rt/doc/baseline_0422_1959.csv` | 1 `(FAIL)`-marked + 2 pre-existing non-marked (`I-FILE-47`, `I-COLL-25`); skipped is `D4-WRAP-01`. |

### Flutterm gating-suite match against plan

The plan's Phase 0 exit criterion was:

> today: 1 failing test in `important_classes_test`, 1 failing test in
> `secondary_classes_test`, everything else green.

Confirmed. Exact match.

## Known pre-existing failures (enumerated)

These are allowed to stay failing throughout the migration. Any
regression that ADDS a new failure or flips one of these back to passing
and then breaks again must be treated as a migration bug.

### tom_d4rt_flutterm

| Suite | Test ID | Test name |
|---|---|---|
| important | 161 | `services/codecs_test.dart` |
| secondary | 145 | `widgets/gesture_detector_adv_test.dart` |

### tom_d4rt_exec (all marked `(FAIL)` in description)

See `tom_d4rt_exec/doc/baseline_0422_1959.csv` for the 11 rows whose
description ends in `(FAIL)`. Includes: `I-BUG-14a` records-with-named-
fields, `G-TYPE-1/2` record parameter/return, `G-DOV-1..12` various
interpreter gaps, `G-DOV2-5` cast pattern, etc.

### tom_d4rt

| ID | Description | Marker |
|---|---|---|
| I-FILE-47 | `Lim-1: Extension types should work.` | no `(FAIL)` — legacy pre-existing |
| I-COLL-25 | `Iterator basics and forEach.` (HashSet) | no `(FAIL)` — legacy pre-existing |
| I-BUG-14a | `Records with named fields.` | `(FAIL)` |
| D4-WRAP-01 | `extractBridgedArg unwraps BridgedInstance<int> to double.` | `(FAIL)` — skipped |

### tom_d4rt_dcli

| Group | Description |
|---|---|
| VS Code Scripting API - Live Bridge Commands | `script can get active editor through bridge` |
| VS Code Scripting API - VSCodeWindow | `getActiveTextEditor returns editor info` |

Environment-dependent — these need an active VS Code session.

### tom_dcli_exec

| Group | Description |
|---|---|
| DCli Project - tomexample (advanced) | `process_execution` |
| DCli Project - standalone (advanced) | `redirect` |
| DCli Project - tomexample (advanced) | `environment` |

Environment-dependent — shell redirection / process spawning.

## Regen + re-test commands per consumer

Every Phase of the migration must, for a given consumer, (1) regenerate
bridges, (2) re-run tests, (3) compare the result column against the
Phase 0 baseline. Commands (all run from the **project root** of the
respective consumer):

```sh
# tom_d4rt_flutterm
dart pub get
dart run tool/regenerate_bridges.dart
flutter test test/essential_classes_test.dart -r json > /tmp/essential.json
flutter test test/important_classes_test.dart -r json > /tmp/important.json
flutter test test/secondary_classes_test.dart -r json > /tmp/secondary.json
# Compare against doc/baseline_runs/{essential,important,secondary}.json
# (same pass/fail counts + same failing test IDs required).

# tom_d4rt_dcli
dart pub get
d4rtgen           # regenerates lib/src/bridges/*.b.dart
testkit :test     # appends result column to latest doc/baseline_*.csv

# tom_d4rt_exec — no d4rtgen section in buildkit.yaml; nothing to regen
dart pub get
testkit :test

# tom_dcli_exec
dart pub get
d4rtgen
testkit :test

# tom_d4rt — no d4rtgen section in buildkit.yaml; nothing to regen
dart pub get
testkit :test
```

## Artefact locations

- Bridge-file snapshots (post-regen output at Phase 0):
  - `tom_d4rt_generator/doc/baselines_summary_refactor/flutterm/` — 18 files
  - `tom_d4rt_generator/doc/baselines_summary_refactor/dcli/` — 9 files
  - `tom_d4rt_generator/doc/baselines_summary_refactor/dclie/` — 9 files
- Baseline CSVs live under each consumer's `doc/baseline_*.csv`. The
  Phase 0 baselines are tagged `"summary-refactor Phase 0 baseline
  (pre-migration)"` in the column header.
- Flutterm regen transcript: `tom_d4rt_flutterm/doc/regen_transcript_baseline_20260422.txt`.
- Flutterm per-suite JSON reporter output: `tom_d4rt_flutterm/doc/baseline_runs/`.
- DCli regen transcript: `tom_d4rt_dcli/doc/regen_transcript_baseline_20260422.txt`.
- DCli-exec regen transcript: `tom_dcli_exec/doc/regen_transcript_baseline_20260422.txt`.

## Bridge-diff caveats observed at capture

- `tom_d4rt_flutterm`: regenerated bridges are byte-identical to the
  committed copies modulo the `Generated: <timestamp>` header.
- `tom_d4rt_dcli`: committed bridges were stale (generated 2026-03-25)
  and diverged substantially from the current `d4rtgen v1.8.16+57`
  output (876-line reduction in `dcli_bridges.b.dart`, smaller diffs in
  the other four modules). The Phase 0 baseline reflects **freshly
  regenerated** bridges, not the committed ones. These regenerated files
  are committed along with this baseline to normalise the starting
  point. Phase 1+ work must re-regenerate before every test run.
- `tom_dcli_exec`: same situation as `tom_d4rt_dcli`; freshly
  regenerated and committed.

## How to diff a phase against this baseline

1. From the consumer's project root, regenerate bridges and run the
   same test command(s) as above.
2. For CSV-based consumers: `testkit :test` appends a column whose
   format is `<current>/<baseline>`. Any row with `X/OK` is a new
   regression and must be investigated. `X/X` is an ongoing pre-existing
   failure and is fine provided it matches a row in this document.
3. For flutterm JSON: parse the `-r json` output with
   `grep -o '"result":"[^"]*"' run.json | sort | uniq -c` and compare
   the `success`/`failure`/`error` counts against the per-suite table
   above. For a deeper diff, extract failing test IDs with the same
   python snippet used to populate "Known pre-existing failures" above.
