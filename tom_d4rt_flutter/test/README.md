# D4rt Flutter bridge corpus — running the tests

> **Attribution.** The `tom_d4rt` project is an extended clone of the original
> d4rt project by Moustapha Kodjo Amadou, initially published in 2025. The
> complete interpreter is based on his idea.

This folder holds the D4rt Flutter bridge test corpus. The corpus is split into
`flutter_base_NN_test.dart` and `flutter_extended_NN_test.dart` files (~50 tests
each). Each test sends a D4rt script to a **freshly-spawned companion app** over
a **local HTTP server** and asserts on the rendered result; every file launches
and tears down its own app. Helper scripts run the corpus reproducibly:

- `run_issue_analysis_tests.sh` / `.ps1` — the **full** corpus (base + extended)
- `run_base_tests.sh` / `.ps1` — the **base** subset only (fast regression gate)

The `.sh` variants are macOS / Linux (bash); the `.ps1` variants are Windows
(PowerShell / pwsh). Each globs its file list in numeric order, so adding or
regenerating split files needs no script edit.

## Usage

```bash
# macOS / Linux — from anywhere; the script cd's to the project root itself.
./test/run_issue_analysis_tests.sh                 # ID = <YYYYMMDD-HHMM>-issue-analysis
./test/run_issue_analysis_tests.sh 20260604-1035-issue-analysis   # explicit ID
```

```powershell
# Windows
./test/run_issue_analysis_tests.ps1
./test/run_issue_analysis_tests.ps1 -Id 20260604-1035-issue-analysis
```

Each run writes, per test file `<base>`, into a folder under `testlog/`:

| Runner | Output folder |
| ------ | ------------- |
| `run_base_tests.{sh,ps1}` | `testlog/basetestlog_<ID>/` |
| `run_issue_analysis_tests.{sh,ps1}` | `testlog/testlog_<ID>/` |

| File | Contents |
| ---- | -------- |
| `<base>.result.json` | Machine-readable results (`flutter test --file-reporter json`) — includes per-test timing **metrics**. |
| `<base>.log.txt` | Full stdout, including Flutter framework output (overflow errors, assertion banners, transport errors) that does **not** necessarily fail a test. |
| `metrics.txt` | One line per file: exit code + the `+passed ~skipped -failed` summary. |

### Everything goes to `testlog/`, and `testlog/` is gitignored

There is **no base-vs-sweep split**: all four runners, on both platforms, write
under `testlog/`, which `.gitignore` ignores wholesale. Test artifacts are never
versioned — a committed one is a photograph of one machine's build that nothing
updates, so a later reader cannot tell it from a current one. `doc/` is
hand-authored only; nothing a runner writes belongs there.

**Do not "tidy" a runner back to `doc/`.** That is not hypothetical: the
`doc/` → `testlog/` decision was made on 2026-06-24 and applied in `1a4250154`
to the two `.sh` issue-analysis runners *only*. The two `.ps1` twins and both
`run_base_tests` scripts were missed and kept writing to `doc/` — so the same
command produced a gitignored folder on macOS/Linux and a **tracked** one on
Windows, and a contributor following this README on Windows would find ~41
result-JSON and log files staged for commit. It actually happened: the 90 files
under `doc/testlog_20260624-0713-issue-analysis/` are still in git for exactly
this reason.

If you write an analysis document about a run (`error_analysis.md`), it goes in
the run's `testlog/` folder with the results it describes — durable on disk,
deliberately not committed.

## ⚠️ The tests must run strictly serially — never in parallel

The corpus drives **one** companion-app process through **one** local HTTP
server. Running more than one `flutter test` at a time — within this project or
across the sibling project (`tom_d4rt_flutter` ⇄ `tom_d4rt_flutter_ast`) — lets
two test runs hit the shared server and process concurrently and **corrupt each
other's results**.

This is not theoretical. In one measured instance, `essential_classes_test`
went from **108 / 0 / 0** (pass/skip/fail) when run serially to **40 / 2 / 66**
(66 errors) when run concurrently with `important_classes_test`. The runner
scripts therefore:

- run the split files **one at a time**, in sequence, and
- **must not** be launched for both projects simultaneously. Even though the AST
  app and the source-direct app bind **different ports**, running both at once
  overloads the host and the shared-resource contention reintroduces the same
  corruption. Run one project to completion, then the other.

Do **not** add `-j`/concurrency flags, and do **not** background (`&`) multiple
invocations.

## ⚠️ Why the per-test timeout is 60 s

Every `flutter test` command in the scripts passes `--timeout 60s`. The corpus
tests include a cold-start cost (parser + interpreter + bridge warmup on the
first script after `setUpAll`) and real widget pump/settle cycles. Flutter's
default per-test timeout (~30 s, scaled) is **too tight on a busy host** — under
CI load or a loaded developer machine, an otherwise-passing test can blow the
default timeout purely because the host was busy, producing a spurious failure.

The 60 s ceiling gives enough headroom that a momentarily busy host does not
turn green tests red, while still bounding genuinely wedged tests so the run
cannot hang indefinitely. It is a **per-test** limit; the shell script adds a
separate ~15 min **per-file** wall-clock backstop (via `timeout`/`gtimeout` when
available) so a wedged transport cannot stall the entire sequence.

## ⚠️ The idle-output watchdog (fail fast on a wedged run)

Neither the per-test `--timeout 60s` nor the ~15 min per-file backstop helps the
two failure modes seen most often in practice:

1. the companion-app transport **wedges mid-run** and `flutter test` sits in
   silence for the rest of the per-file backstop, and
2. the run **never even reaches the first test** (cold hang) — there is no
   running test for the per-test timeout to bound.

Both waste up to ~15 minutes per file before the backstop fires. To fail fast,
each `flutter test` invocation is wrapped by `idle_timeout.sh` (bash) /
`idle_timeout.ps1` (PowerShell): if the run produces **no output at all for
`IDLE_TIMEOUT` seconds (default 70)** the wrapper kills the entire process group
— `flutter test` and any child it spawned — and returns exit code **124**. The
metrics line for that file is annotated `(IDLE-KILLED after <n>s of no output)`.

70 s = the ~60 s per-test maximum plus margin, so a single slow-but-progressing
test is never killed while a true stall is caught within ~70 s instead of ~900 s.
Override with the `IDLE_TIMEOUT` env var (and `IDLE_POLL` for the check cadence):

```bash
IDLE_TIMEOUT=120 ./test/run_issue_analysis_tests.sh   # more headroom
```

```powershell
$env:IDLE_TIMEOUT = 120; ./test/run_issue_analysis_tests.ps1
```

## ⚠️ The corpus certifies the PUBLISHED interpreter, not the working tree

This package resolves ``tom_d4rt`` **from pub.dev**, and so does its companion
app. Neither is path-resolved, and that is a deliberate policy rather than an
oversight: the corpus is meant to measure what a consumer of the published
package actually gets.

The cost is accepted knowingly, and it is easy to be caught by:

- **Bridge and generator changes are exercised.** The `*.b.dart` files, the
  user bridges and `tom_d4rt_generator` all live in this tree, so a corpus run
  is the right gate for them.
- **Interpreter changes are NOT exercised until they are published.** A change
  to ``tom_d4rt`` that is only in the working tree is not in the package this
  corpus loads. An hour of green results after such a change is evidence about
  the PREVIOUS release, and reading it as proof of the change is the failure
  this section exists to prevent — it is silent in both directions: the fix
  looks verified without having run, and a regression it would have caused is
  not caught.

So for an interpreter change the primary gate is the `tom_d4rt` and
`tom_d4rt_ast` suites. Publish first, raise the constraint, `flutter pub
upgrade` here AND in the companion app, and only then does a corpus run say
anything about it. **Do not route around this with a `pubspec_overrides.yaml`**
— the workspace rule against path overrides exists for exactly this shape.

**Name-resolution changes always get a corpus run after publishing**, before
the work is called done, and the run is recorded under `## Verification runs`
in `tom_d4rt_flutter_ast/doc/interpreter_issues.md` with the interpreter pair
it measured. That entry is the ONLY durable record of which interpreter a run
used: `pubspec.lock` is gitignored in both twins and in both companion apps, so
the resolved version is machine-local and invisible in any diff or review, and
two fleet hosts can run the same corpus against different interpreters with
nothing in the repository saying which.

`interpreter_issues_doc_test.dart` in the AST twin guards that record: it fails
when the newest `## Verification runs` entry names a pair that differs from
what the companion apps resolve on this machine, so a recorded run that is no
longer comparable to a run made here is reported rather than assumed.

### The opt-in pre-publish pass

A publish cannot be undone, and the rule above means a corpus regression from
an interpreter change is found only AFTER the release that carries it. So
there is a supported way to run the corpus against the working tree first:

```bash
cd tom_d4rt_flutter_ast
dart run tool/prepublish_overrides.dart            # status: what resolves what
dart run tool/prepublish_overrides.dart --set      # path-resolve + pub get
# ... run the corpus, serially, as usual ...
dart run tool/prepublish_overrides.dart --restore  # back to hosted
```

`--set` covers both twins, both companion apps and `tom_d4rt_exec` — the apps
are separate packages with their own lockfiles and reach the interpreter
through their twin, so overriding the twin alone leaves the run measuring the
published interpreter.

**Results from a pre-publish pass must never be recorded under
`## Verification runs`.** That section records which PUBLISHED pair a run
measured; an entry naming a version nobody can install is worse than no entry.
Use the pass to decide whether to publish, then publish, then run and record
normally.

The mechanism is a gitignored `pubspec_overrides.yaml`, never an edit to a
`pubspec.yaml`, and `scd66_resolution_strategy_test.dart` fails if a
`dependency_overrides:` block appears in a tracked pubspec or if the gitignore
entry goes away. The workspace rule against path overrides is about making a
package WORK against an unpublished API and shipping it; this is a measurement
that is thrown away, and it is enforced to stay that way rather than promised.

## The companion app is resolved and checked before any test runs

The corpus scripts run inside `test/tom_d4rt_flutter_test_app/`, a separate package with its own
gitignored `pubspec.lock`. Nothing re-resolves it when this package moves, so
without a check it can keep an older interpreter than the package itself:
either the corpus silently certifies that older interpreter, or the app fails
to build and the file ends in "test app failed to start" with nothing naming
the lock. Two things now prevent that:

- **The runner scripts resolve the app** (`flutter pub get` in its directory)
  once, before the first file. If that fails, pub's message is printed, a
  `companion app: flutter pub get failed` line goes to `metrics.txt`, and the
  run stops.
- **The harness checks the app before launching it**
  (`test/companion_app_resolution.dart`, called from `SendTestRunner.setUp`).
  Every hosted `tom_*` package the app resolves must be the version this
  package resolves, and the app's lock must record this package at its current
  version. Otherwise `setUpAll` fails in seconds, naming each package with both
  versions and the remedy. This covers files run by hand, outside the scripts.

If the app still does not come up, the failure says whether it exited (with its
exit code) or never answered `/health`, lists what the app resolves beside this
package, and shows the last lines of the app's output — for a build failure,
the compiler error. The wait also ends as soon as the app process exits, rather
than running out the launch timeout.

## The split corpus files (run order)

The corpus is packed into ordered, ~50-test files. The runners glob them in
numeric order: all `flutter_base_*` first, then all `flutter_extended_*`.

- `flutter_base_01_test.dart` … `flutter_base_17_test.dart` — the essential +
  important + secondary tiers (groups kept verbatim, duplicates removed).
- `flutter_extended_01_test.dart` … `flutter_extended_23_test.dart` — the
  hardly-relevant / timeout / blocking / generator tiers.
- `flutter_extended_24_test.dart` — the **interactive** suite (its custom
  `setUpAll` and `/interact` behaviour are preserved verbatim in its own file).

Each file opens with a `Test App Health` group (`app is running`) that is **not**
counted toward the ~50-test target; it is a per-file smoke check.

The files are generated from the legacy tier corpus by `ztmp/split_tests.py`
(brace-aware parser → dedup → group-slice → pack). Re-run that generator if the
underlying tier sources change.

Other `*_test.dart` files in this folder (e.g. `interpreter_generator_open_issues_test.dart`,
`suspicious_rewrite_test.dart`) are standalone suites with their own purpose and
are **not** part of the base/extended corpus run.
