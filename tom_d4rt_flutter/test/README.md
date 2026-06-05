# D4rt Flutter bridge corpus — running the tests

This folder holds the D4rt Flutter bridge test corpus. Each test in the
13 "corpus" files sends a D4rt script to a **single, long-lived companion app**
over a **local HTTP server** and asserts on the rendered result. Two helper
scripts run the whole corpus reproducibly for issue analysis:

- `run_issue_analysis_tests.sh` — macOS / Linux (bash)
- `run_issue_analysis_tests.ps1` — Windows (PowerShell / pwsh)

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

Each run writes, per test file `<base>`, into `doc/testlog_<ID>/`:

| File | Contents |
| ---- | -------- |
| `<base>.result.json` | Machine-readable results (`flutter test --file-reporter json`) — includes per-test timing **metrics**. |
| `<base>.log.txt` | Full stdout, including Flutter framework output (overflow errors, assertion banners, transport errors) that does **not** necessarily fail a test. |
| `metrics.txt` | One line per file: exit code + the `+passed ~skipped -failed` summary. |

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

- run the 13 files **one at a time**, in sequence, and
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

## The 13 corpus files (run order)

1. `essential_classes_test.dart`
2. `important_classes_test.dart`
3. `secondary_classes_test.dart`
4. `hardly_relevant_classes_1_test.dart` … `hardly_relevant_classes_5_test.dart`
5. `timeout_tests_test.dart`
6. `blocking_tests_test.dart`
7. `generator_interpreter_issues_test.dart`
8. `generator_interpreter_retest_test.dart`
9. `interactive_tests_test.dart`

Other `*_test.dart` files in this folder (bisect, cluster repros, probes) are
ad-hoc investigation harnesses and are **not** part of the issue-analysis run.
