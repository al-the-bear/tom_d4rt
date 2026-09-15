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

A third runner is **not** part of the corpus and answers in seconds:

- `run_guard_tests.sh` — the fast, transport-free guards (no companion app, no
  HTTP server, no `concurrency: 1`): the AST/non-AST user-bridge de-dup, the
  `doc/`-holds-no-runner-output check, the pooled-registration skip path, and
  SCD133's registry-wide bridged-enum resolution guard.

`tom_d4rt_flutter` has its own `run_guard_tests.sh` now, covering the checks
that are genuinely per-twin. Run both; neither is a superset of the other.

It is separate on purpose (SCD108). A test matching neither corpus glob is
invoked by nothing, which is how `text_user_bridge.dart` stayed duplicated and
unguarded in both twins for months — but folding a one-second file check into a
sixteen-minute serial suite answers at the wrong cadence and makes the cheap
guard hostage to the expensive one. Enforcement lives in
`.githooks/pre-commit` at the repo root, which refuses a commit that drifts the
twins apart; run `git config core.hooksPath .githooks` once per machine to
enable it. This script is what a human runs on a clone where nobody has.

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
result-JSON and log files staged for commit. It actually happened, and it was
not caught for a month: **104 machine-generated files across four `doc/` run
folders** in this project and its siblings reached the repository before being
untracked (`git rm --cached`, left on disk — they are still valid local results,
just not versioned).

**There is no `doc/`-shaped ignore rule, and adding one is the wrong instinct.**
Three of them accumulated — `**/doc/basetestlog_*/`, `**/doc/testlog_*/`,
`**/doc/extlog_*/` — one added each time somebody found a run folder already
committed under a name the previous rules did not cover. None of them could
catch the *next* name, which is the only occurrence that matters, and each one
falsified the comment directly above it claiming `doc/` carries no test
artifacts. Worse, ignoring a path does nothing to a file git already tracks, so
for three months the rules kept the violation quiet rather than ending it.

All three are gone. Two shape-based checks replaced them, and between them they
cover the three moments the mistake can be made:

| Check | Fires when | Covers |
| --- | --- | --- |
| `.githooks/pre-commit` | you stage it | the staged paths, before anything is authored |
| `tom_d4rt/test/scd110_doc_holds_no_runner_output_test.dart` | you run the guards | the tracked tree, this machine's disk, the runner scripts, and `.gitignore` itself |

Both match on the *shape* of a path — a `*log_*` run folder, a `.result.json`,
a `.log.txt`, a `.console.log`, a `metrics.txt`, a testkit baseline — so a
fourth folder name is caught on its first appearance. Run them together with
`./test/run_guard_tests.sh`. If one goes red on your machine, move the folder
into `testlog/`; do not add a rule to hide it.

If you write an analysis document about a run, do not leave it in the run
folder. Raw results are machine output and stay uncommitted in `testlog/`; a
document a **person** wrote is the one thing in that folder worth keeping, and
it belongs in `doc/` under a name that survives the run it came from. The
2026-06-24 analysis was preserved that way, as `doc/issue_analysis_20260624.md`;
the raw metrics it was written from are no longer tracked, which is the same
convention every historical entry in `doc/interpreter_issues.md` follows.

## ⚠️ Read all three numbers — a rising skip count is a regression

A runner prints `+45 ~1 -2`: **pass, skip, fail**. Only `-N` is habitually read
as bad, and that is the hole SCD140 closes.

On 2026-07-28 `flutter_extended_23` went from `+44 ~1 -1` to `+44 ~2`. It was
recorded beside genuine recoveries, annotated "not a pass", and left. The pass
count had not moved: a visible FAILURE had become an invisible SKIP. That is a
regression in measurement, not a repair, and it sat unexamined for six weeks in
a file whose test group is named "Tests with workarounds reverted retest".

**`+44 ~2` and `+44 ~1 -1` describe the same amount of working software. Only
one of them tells you so.** So compare a run against its baseline on all three:

| change | reading |
| ------ | ------- |
| fail rises | regression — the usual one |
| **skip rises, pass unchanged** | **regression. A test stopped being measured.** Explain it in the verification entry exactly as a new failure would be |
| skip rises, pass rises by the same amount | a test moved between files, or a driver was split. Say which |
| skip falls, pass rises | a skip was audited and became a measured test (SCD139) — worth calling out |
| skip falls, fail rises | a masker was removed and the truth is red. Better than a skip, and it needs a cluster entry |

**Every `skip:` in a driver file must state the MECHANISM that makes the
condition unobservable to the interpreter, and name its evidence** — a commit, a
source location, or a reproduction. "Platform-dependent API" is not a mechanism:
a script can guard a platform-dependent API and still be measured, and two of
the three surviving skips were justified that way until SCD139 re-measured them.
`scd140_skip_hygiene_test.dart` enforces the shape over both twins' drivers, and
it is in `run_guard_tests.sh`.

Why the shape and not the prose: SCC47 found a skip asserting that "the d4rt
bridge wraps the native `UnsupportedError` in a way that the script's `catch (e)`
does not reliably intercept" — a mechanism that does not exist, masking a plain
script defect. SCD139 found another claiming an interpreter capability gap that
was really a permission gate. Both read plausibly. Neither named evidence, and
that is the part a test can check.

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
`IDLE_TIMEOUT` seconds (default 300)** the wrapper kills the entire process group
— `flutter test` and any child it spawned — and returns exit code **124**. The
metrics line for that file is annotated `(IDLE-KILLED after <n>s of no output)`.

**The default was 80 (70 in the `.ps1` twins) and that was too short — SCD131.**
The watchdog was shorter than the thing it watches: `SendTestRunner.setUp` waits
up to **120 s** for the companion app to start, so on a cold build cache the
first file produced no output for longer than the watchdog allowed and was
killed with `exit=124 +0` before the harness could report anything. That reads
as a hang and is not one, and the state it happens in is not unusual — it is
what a `flutter pub upgrade` leaves behind, i.e. exactly the state the corpus
protocol requires a sweep to run in. Every run between 2026-08-12 and the fix
passed `IDLE_TIMEOUT=300` by hand.

So the floor is not "the per-test maximum plus margin" but **the companion
app's own start timeout plus margin**. Any future change to
`SendTestRunner.setUp`'s 120 s has to move this default with it.

A genuine stall is still caught: the `.sh` runners wrap each file in
`timeout 900` regardless. The `.ps1` runners have no such backstop — see
SCE148 — so there the watchdog is the only cap.

Override with the `IDLE_TIMEOUT` env var (and `IDLE_POLL` for the check cadence,
which defaults to 5 s — an `IDLE_TIMEOUT` below that is meaningless because the
first poll already exceeds it):

```bash
IDLE_TIMEOUT=600 ./test/run_issue_analysis_tests.sh   # more headroom still
```

```powershell
$env:IDLE_TIMEOUT = 600; ./test/run_issue_analysis_tests.ps1
```

## ⚠️ The corpus certifies the PUBLISHED interpreter, not the working tree

This package resolves ``tom_d4rt_ast`` **from pub.dev**, and so does its companion
app. Neither is path-resolved, and that is a deliberate policy rather than an
oversight: the corpus is meant to measure what a consumer of the published
package actually gets.

The cost is accepted knowingly, and it is easy to be caught by:

- **Bridge and generator changes are exercised.** The `*.b.dart` files, the
  user bridges and `tom_d4rt_generator` all live in this tree, so a corpus run
  is the right gate for them.
- **Interpreter changes are NOT exercised until they are published.** A change
  to ``tom_d4rt_ast`` that is only in the working tree is not in the package this
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

The corpus scripts run inside `test/tom_d4rt_flutter_ast_app/`, a separate package with its own
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

Other `*_test.dart` files in this folder (e.g. `bridge_execution_test.dart`,
`interpreter_generator_open_issues_test.dart`, `sync_shared_user_bridges_test.dart`,
`interpreter_issues_doc_test.dart`) are standalone suites with their own purpose
and are **not** part of the base/extended corpus run.

`interpreter_issues_doc_test.dart` is a documentation guard: it pins the
"What is still open" table in `doc/interpreter_issues.md` to the cluster
sections it summarises, and fails if a corpus pass/skip/fail triple reappears
in that document's header (results belong in `## Verification runs`, which
records the interpreter pair, and in `testlog/`). Pure file I/O — no companion
app, no port — so it is safe to run at any time, including alongside nothing
else.
