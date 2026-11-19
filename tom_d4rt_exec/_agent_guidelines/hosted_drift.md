# Hosted-vs-worktree drift

`tool/hosted_drift.dart` reports, per file, where a consumer's *resolved*
(pub.dev-hosted) copy of a workspace package differs from the working tree
beside it.

## The question it answers

`tom_d4rt_exec` and both `tom_d4rt_flutter*` twins resolve the interpreter
**from pub.dev, not by path** (DGUC6). That is deliberate: their suites are meant
to certify what a consumer actually gets. The cost is that an interpreter fix in
the working tree is invisible to them until it is published — so a failing test
in any of those packages has two possible causes:

- the analyzer-free interpreter has a genuine bug, or
- the test is measuring a version that predates the fix.

Those call for opposite responses. Before this tool they were told apart by
recalling which fix shipped when, which is not an instrument. Run the tool first
and the question is answered by the bytes: a file reported `identical` cannot be
the explanation for a failure, which eliminates most of the search space before
any debugging starts.

## Running it

The script has **no package dependencies** — only `dart:io` — so it runs with a
plain `dart <path>` from any directory, including a package whose own resolution
is the thing under investigation.

```sh
# Every consumer the repo contains.
dart run tom_d4rt_exec/tool/hosted_drift.dart

# One consumer, with the per-file listing.
dart tom_d4rt_exec/tool/hosted_drift.dart --consumer tom_d4rt_flutter_ast --files

# Machine-readable, for recording a measurement verbatim.
dart tom_d4rt_exec/tool/hosted_drift.dart --json

# Guard mode: exit 2 if any consumer resolves a stale or unmeasurable copy.
dart tom_d4rt_exec/tool/hosted_drift.dart --check
```

Exit codes: `0` measured successfully (and, under `--check`, in sync), `1` hard
error, `2` `--check` found drift.

## Reading the output

For each consumer it lists every hosted dependency that also exists as a
working-tree sibling, the resolved version against the tree version, the archive
`sha256`, and — when they differ — a breakdown:

- **differs** — present on both sides with different content.
- **only-in-tree** — a file that exists only in the working tree: unreleased.
- **only-in-hosted** — deleted since the release.

and then the **stranded subsystems**: the differing files grouped by their
directory, largest group first. That grouping is the part worth acting on. A
count ("36 files differ") does not tell anyone what to do; "the whole of
`src/runtime/stdlib/typed_data` is unpublished" does.

Line endings are normalised before comparison, so a Windows checkout does not
report every file as drifted.

`UNMEASURABLE` is a distinct verdict from `IN SYNC`. `pubspec.lock` is gitignored
in the Flutter twins, so a consumer with no lockfile is the normal state on a
fresh checkout — and "I could not tell" must not look like "there is no drift".

## No list is maintained here

The tool carries no list of consumers, dependencies or versions. It walks the
repository for packages with a `pubspec.lock`, and for each reports the hosted
dependencies that also exist as a working-tree sibling. A new consumer, or a new
package pair, is picked up with no edit. This is the same discipline as the
user-bridge sync tool: a membership list maintained alongside the directory it
describes cannot notice its own omissions.

In particular, **the twins need no tool of their own** — they are found by the
same survey, and adding a second copy of this logic beside them would be the
duplication the derivation exists to avoid.

## Failure is loud

The worst outcome for a tool like this is a clean bill of health produced by
looking in the wrong place. The hosted path is composed from a version string
parsed out of a gitignored lockfile, so pointing at a directory that is not there
is the *expected* way to be wrong. A missing lockfile, a missing hosted archive,
a missing working tree, or a hosted archive with **zero** `lib/` files is
therefore a hard error, never an empty report. `test/hosted_drift_test.dart`
pins that (F-SCC66-8, F-SCC66-9).

## What the current drift looks like

Numbers are not reproduced here — they are per-machine (gitignored lockfiles) and
change with every publish, so a snapshot in this file would read as current long
after it stopped being true. Run the tool.

The *shape* of the finding is durable and worth knowing before reading one:

- Every consumer in the repo resolves the same interpreter versions, so the
  stranded set is identical across all of them. There is one gap, not ten.
- The stranded files concentrate in `stdlib` — `typed_data` and `collection`
  dominate, followed by `io`. That is where the recent bridge work has been.
- `interpreter_visitor.dart` and `environment.dart` are usually in the differing
  set too. Those are the files most likely to explain a behavioural failure, so a
  consumer-suite failure that points at either is a candidate for the stale-copy
  reading rather than the bug reading.

## Its first consumer: the conformance census

`test/conformance_drift_test.dart` decides, for every reference test with no
counterpart here, whether the gap is a genuine port to make or a version the
published interpreter does not yet carry. That decision used to be made from
memory. It is now made from this tool's output first and a run second:

1. Run the tool. A reference test whose subject is a library file reported
   `only-in-tree` cannot be ported today, and no run is needed to know it.
2. For the rest, port verbatim and run against the resolved interpreter. The
   pass/fail shape distinguishes a migration bug (scattered failures) from a
   version gap (every case that needs the new behaviour fails, and only the
   unrelated guards pass).
3. Record the shape in `_uncoveredBaseline` and the flip version in
   `_pinnedInterpreterFloors`, in the same edit. The prose is read by whoever
   rereads it; the register is read by the suite.

Two of the seven `dart:io` entries recorded that way do not fail against the old
interpreter — they **hang**, and `--timeout` does not stop them. That is a
materially worse outcome than a red suite and is the kind of thing only a run
finds; it is recorded on the entries so nobody discovers it twice.

## Related

- `tom_d4rt_flutter_ast/doc/interpreter_issues.md` § *Verification runs* — the
  per-run record of which interpreter pair a corpus run measured. This tool
  produces the version pair those entries need.
- `tom_d4rt_flutter_ast/tool/sync_shared_user_bridges.dart` — the other derived
  cross-package consistency tool, and the structural template for this one.
