# Which interpreter a suite measures, and how to know

Every package in this repo except `tom_d4rt`, `tom_d4rt_ast` and `tom_ast_model`
gets its interpreter **from pub.dev**. That is deliberate — a consumer's suite
should certify what a consumer actually installs (DGUC6) — and it has one
consequence that has cost this repo three separate incidents:

**`pubspec.lock` is gitignored repo-wide.** The version a run measured is
per-machine state. It appears in no diff, no review and no fleet sync, so two
hosts can run the same suite against different interpreters and nothing in the
repository records which.

---

## The rule: libraries declare a caret, copy surfaces declare a floor

```yaml
# a library — tom_d4rt_exec, tom_dcli_exec, both Flutter twins, …
dependencies:
  tom_d4rt_ast: "^0.65.0"     # one minor line, named in a committed file
```

`pub get` is **lock-preserving**: a lower-bound-only constraint such as
`>=0.55.0` *admits* 0.65.0 but never *selects* it once a lock exists. The lock
then satisfies the constraint forever and nothing notices. A caret removes the
licence rather than detecting its use — a lock outside the minor line does not
resolve at all.

`F-SCC45-5` in `tom_d4rt_ast/test/scc45_resolution_guard_test.dart` enforces it,
with `_caretExempt` for the one case that defers to another package's
constraint.

**Copy surfaces are the exception, and for a different reason.** An example, a
sample or a standalone demo app is a file a new project copies, so what it
should declare is what a reader would write: a floor naming the current release.
`F-SCC45-4` holds them to that.

### What the caret costs

**Every interpreter publish needs its consumers' constraints bumped.** That is
not a side effect to discover later — it is the point. The alternative is a
constraint that never moves and a lock that never moves either, which is the
state this rule replaced.

The quest overview already writes this protocol for the Flutter twins; it is now
true of every consumer:

```bash
# after publishing tom_d4rt_ast
#   1. raise the caret in each consuming pubspec.yaml
#   2. pub get in the package AND in any companion app beside it
#   3. re-run
```

A twin and its companion app have separate lockfiles. Upgrading one without the
other is a near-miss the bridge corpus has already had.

---

## Clearing a frozen lock

One command, from anywhere inside the repo:

```bash
dart run tom_d4rt_ast/tool/upgrade_stale_locks.dart --dry-run   # the plan
dart run tom_d4rt_ast/tool/upgrade_stale_locks.dart             # apply
```

It walks every package under the repo root — nested fixtures and both
companion apps included, each of which carries its own ignored lock — chooses
`flutter pub upgrade` or `dart pub upgrade` by reading `sdk: flutter` out of
the pubspec rather than guessing from the path, and **re-measures afterwards**
rather than trusting exit codes. A lock that will not move is a *constraint*
holding it there, and the tool says so instead of reporting success.

It shares its definition with the guard: the walk, the lock parse and the
version comparison live in `tom_d4rt_ast/tool/stale_locks.dart`, which
`scc45_resolution_guard_test.dart` imports. A tool that clears a red the guard
still reports would be worse than either alone.

**A green `F-SCC45-2` is not a corpus re-measurement.** Upgrading a Flutter
twin's lock moves the bridge corpus onto a new interpreter without re-running
it — DGUC6 arriving by a side door. The tool prints a warning naming the
packages it moved when that happens; re-run `./test/run_base_tests.sh` in each
twin, serially, and record the run.

## Before any run whose result will be quoted

A baseline, a conformance claim, a "the suite is green" statement — start with
an upgrade, or you are measuring whatever this machine last locked:

```bash
dart pub upgrade      # flutter pub upgrade in the Flutter packages
dart test
```

## Where the resolved version is recorded

Four mechanisms, each answering a different question. None of them is a
substitute for another.

| Mechanism | Answers | Scope |
| --------- | ------- | ----- |
| The caret in `pubspec.yaml` | which minor line, from a committed file | every library |
| `[SCC45] interpreter resolved per package` | the exact version every package in the repo resolves, printed on every run | `tom_d4rt_ast`'s suite |
| `F-SCC80-1`'s printed line | the exact version and declared floor, in the run's own log | `tom_d4rt_exec` |
| The `# attribution:` header in `metrics.txt` | every `tom_*` package the twin AND its companion app resolved, per corpus run | both Flutter twins |

The last two are the ones that put the number in **the log of the run it
describes**, which is what makes a recorded result comparable to a later one.
For a consumer that is not a corpus host, the caret is the record.

## Related guards

| Check | Lives in | Asserts |
| ----- | -------- | ------- |
| `F-SCC45-1` | `tom_d4rt_ast` | no package resolves a `tom_*` from a path it does not declare |
| `F-SCC45-2` | `tom_d4rt_ast` | no lock is behind a version already in this machine's pub cache |
| `F-SCC45-6` | `tom_d4rt_ast` | the shared walk reaches both companion apps and classifies them as Flutter |
| `F-SCC45-4` | `tom_d4rt_ast` | no copy surface declares a floor below the current release |
| `F-SCC45-5` | `tom_d4rt_ast` | every library declares its interpreter with a caret |
| `F-SCC80-1` | `tom_d4rt_exec` | the resolved version is readable, printed, and not behind the floor |
| `F-SCC80-3` | `tom_d4rt_exec` | the resolved interpreter and the working tree are the same bytes |
| `companion_app_resolution.dart` | both Flutter twins | the companion app resolves what its package resolves |

**`F-SCC45-2` is per-machine and says so.** It compares a lock against the pub
cache, so it can only see a freeze whose newer version this host has already
downloaded. A cold cache under-reports rather than accusing an innocent package;
every count it prints is a floor. `F-SCC45-5` is the half that is the same
sentence on every host, because a constraint is committed.
