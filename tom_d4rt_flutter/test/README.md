# D4rt Flutter bridge corpus — running the tests

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

- run the split files **one at a time**, in sequence, and
- **must not** be launched for both projects simultaneously. Even though the AST
  app and the source-direct app bind **different ports**, running both at once
  overloads the host and the shared-resource contention reintroduces the same
  corruption. Run one project to completion, then the other.

Do **not** add `-j`/concurrency flags, and do **not** background (`&`) multiple
invocations.

## ⚠️ Why the per-test timeout is 70 s

Every `flutter test` command in the scripts passes `--timeout 70s`. The corpus
tests include a cold-start cost (parser + interpreter + bridge warmup on the
first script after `setUpAll`) and real widget pump/settle cycles. Flutter's
default per-test timeout (~30 s, scaled) is **too tight on a busy host** — under
CI load or a loaded developer machine, an otherwise-passing test can blow the
default timeout purely because the host was busy, producing a spurious failure.

The 70 s ceiling gives enough headroom that a momentarily busy host does not
turn green tests red, while still bounding genuinely wedged tests so the run
cannot hang indefinitely. The driver itself fails a wedged build fast — the
in-process `/build` HTTP call caps at ~55 s, and a test that wedged the app
recycles it (bounded to ~40 s boot) on the *next* test, so one wedge costs at
most one test and never cascades. It is a **per-test** limit; the shell script
adds a separate ~15 min **per-file** wall-clock backstop (via `timeout`/`gtimeout`
when available) so a wedged transport cannot stall the entire sequence.

## ⚠️ The idle-output watchdog (fail fast on a wedged run)

Neither the per-test `--timeout 70s` nor the ~15 min per-file backstop helps the
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

70 s sits above the ~55 s in-process `/build` cap (the longest a healthy test
goes without producing output), so a single slow-but-progressing test is never
killed while a true stall is caught within ~70 s instead of ~900 s.
Override with the `IDLE_TIMEOUT` env var (and `IDLE_POLL` for the check cadence):

```bash
IDLE_TIMEOUT=120 ./test/run_issue_analysis_tests.sh   # more headroom
```

```powershell
$env:IDLE_TIMEOUT = 120; ./test/run_issue_analysis_tests.ps1
```

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
`suspicious_rewrite_tests.dart`) are standalone suites with their own purpose and
are **not** part of the base/extended corpus run.
