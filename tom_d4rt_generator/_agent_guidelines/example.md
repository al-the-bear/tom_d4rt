# Adding and maintaining an example in tom_d4rt_generator

`example/` holds eight independent Dart packages. Each one is a generation
fixture: real source, a `buildkit.yaml`, and committed `*.b.dart` output that
the generator's own suite holds to being what the current generator produces.

Every command below was run against the tree before this document was
committed.

## What is actually there

```
example/
├── run_all_examples.dart        # runs the examples that have a run script
├── generate_example_bridges.dart
├── test_example_bridges.dart
├── buildkit_skip.yaml           # keeps workspace-wide scans out of example/
├── d4/                          # the large one: 12 modules, shared by several suites
├── d4_test_scripts/             # scripts run against d4; no buildkit.yaml of its own
├── dart_overview/
├── example_project/
├── user_guide/
├── user_reference/
├── userbridge_override/
└── userbridge_user_guide/
```

A single example is a normal package:

```
example/user_guide/
├── pubspec.yaml
├── buildkit.yaml                # the d4rtgen: section is the generator's input
├── lib/
│   ├── user_guide_example.dart  # the barrel the generator reads
│   ├── src/                     # the classes being bridged
│   └── src/d4rt_bridges/        # generated output, committed
├── bin/run_example.dart         # optional: makes it runnable
└── scripts/*.d4rt               # optional: D4rt scripts the example executes
```

Three of the eight — `user_guide`, `user_reference`, `userbridge_override` —
have a `bin/run_example.dart`. The rest are generation fixtures with no
runnable entry point, which is why `run_all_examples.dart` lists three.

## Adding an example

### 1. The package

`pubspec.yaml`. The interpreter floor is a **copy surface**, not a
requirement: an example is what a reader copies into a project of their own,
so it names the current release rather than the oldest version that would
work. `F-SCC45-4` in `tom_d4rt_ast/test/scc45_resolution_guard_test.dart`
fails once a newer release is in the pub cache, so the floor cannot rot
quietly.

```yaml
name: my_feature_example
publish_to: none

environment:
  sdk: ^3.10.4

dependencies:
  # Tracks the current published release: an example is what a new project
  # copies, so it names the release it is run against. F-SCC45-4 fails when a
  # newer one is in the pub cache.
  tom_d4rt: ">=1.77.0"

dev_dependencies:
  # Keep in step with this package's own version: an example that resolves an
  # older published generator than the tree it lives in demonstrates behaviour
  # the tree no longer has.
  tom_d4rt_generator: ">=1.26.2"
```

**Name the interpreter line the example actually runs on.** `tom_d4rt` is the
analyzer-based reference; `tom_d4rt_exec` is the analyzer-free line. Declaring
one and configuring the other produces output that analyzes clean and is
generated against an interpreter the package does not have — a result that
passes and is wrong. SCE1 found eight `buildkit.yaml` files in this state
across two packages.

**Do not path to a sibling.** `path: ../../../tom_d4rt_exec` resolves nowhere
outside this repo and silently measures a working tree rather than a release
(SCE6). Depending on another EXAMPLE by path is different and is fine —
`d4_test_scripts` takes `d4_example: path: ../d4`, because that package is
unpublished by design.

### 2. The generator configuration

`buildkit.yaml`, whose `d4rtgen:` section is the whole input:

```yaml
d4rtgen:
  name: my_feature_example
  helpersImport: package:tom_d4rt/tom_d4rt.dart   # the exec line: package:tom_d4rt_exec/tom_d4rt.dart
  d4rtImport: package:tom_d4rt/d4rt.dart          # the exec line: package:tom_d4rt_exec/d4rt.dart
  generateBarrel: true
  barrelPath: lib/d4rt_bridges.b.dart
  generateDartscript: true
  dartscriptPath: lib/dartscript.b.dart
  registrationClass: MyFeatureExampleBridges
  generateTestRunner: true
  testRunnerPath: bin/d4rtrun.b.dart
  modules:
    - name: all
      barrelFiles:
        - lib/my_feature_example.dart
      barrelImport: package:my_feature_example/my_feature_example.dart
      outputPath: lib/src/d4rt_bridges/my_feature_bridges.b.dart
```

Run `dart run bin/d4rtgen.dart -s example/my_feature --dump-config` to see
what the generator read, which is the quickest way to find a key in the wrong
place.

### 3. Generate

From this package's root:

```bash
dart run bin/d4rtgen.dart -s example/my_feature
```

**Run it until the output stops changing.** Generation is not a one-pass fixed
point — the second run reads what the first wrote and can produce a different,
larger file. Measured on `dart_overview`: 2934 committed lines became 5144
after one run and 5960 after two, and 5960 is stable (SCE1). A single run
leaves a package that is still not what the generator makes of it, and the
next person to run the tool sees a diff again.

Commit everything it writes, `relaxers.b.dart` included — the generated
`dartscript.b.dart` imports it, and a checkout without it does not compile.

If a generated file ever shows conflict-marker damage, regenerate; do not
repair it by hand. `user_reference` carried 228 parse errors for six months
from a hand-resolved merge of generated output.

### 4. Make it runnable (optional)

Add `bin/run_example.dart` and register it in `example/run_all_examples.dart`'s
`examples` list. Only do this if there is something to run; a fixture with no
entry point belongs off that list.

## What the suite then requires

Nothing needs registering for the tests — both discover examples by scanning
`example/` with `findD4rtgenProjects`:

| Test | Requires |
| ---- | -------- |
| `test/example_resolution_test.dart` | the example resolves (`dart pub get --offline`, online on failure) |
| `test/example_bridges_fresh_test.dart` | its committed bridges match a fresh generation |

`example_bridges_fresh_test` is a **ratchet**: an example on its `knownStale`
set must STAY stale, and every other must be fresh. Regenerating one therefore
means deleting its entry in the same commit, or the test fails for the
opposite reason.

Two exclusions, both with a reason in the file:

- `untrackedOutput` skips `d4`. `.gitignore` carries
  `**/example/d4/**/*.b.dart`, so nothing under it is versioned and freshness
  would be a statement about local untracked files — fresh on a machine that
  regenerated recently, absent on a clean clone.
- `knownStale` currently holds `dart_overview`, which is NOT stale. It is a
  fixed point under `d4rtgen`, and the check disagrees because
  `checkBridgeFreshness` runs `generateBridges` while the tool runs
  `_generateBridges` — two implementations that have drifted. SCF1 owns that;
  the entry goes when it lands.

**A NEW EXAMPLE WILL FAIL THIS GATE, and it is not your fault.** Measured by
adding one and following this document exactly: `example_resolution_test`
discovers it and passes, `example_bridges_fresh_test` discovers it and fails.
The two generator paths write a different second line — the tool writes

    // Source: example/<name>/lib/<name>_example.dart

and the check's path writes the same file as an ABSOLUTE path. The 246 lines
below it were identical. So the check reports "committed content differs from a
fresh generation" over one header comment.

Until SCF1 lands, add the new example to `knownStale` with a comment saying
this is the reason, and delete the entry in the same commit that closes SCF1.
Do not try to make it pass by committing the check's output: that bakes a
path from one developer's machine into the repository. Four files in the two
Flutter twins already carry one, which is how this was found.

## Running the examples

```bash
dart run example/run_all_examples.dart                  # generate, then run
dart run example/run_all_examples.dart --generate-only
dart run example/run_all_examples.dart --run-only
```

It runs the three examples that have a `bin/run_example.dart`. There is no
per-example argument; to work on one, use `-s example/<name>` for generation
and run its `bin/run_example.dart` directly.

## Before committing

```bash
dart run bin/d4rtgen.dart -s example/<name>   # twice; see above
cd example/<name> && dart analyze
cd ../.. && dart test test/example_resolution_test.dart \
                     test/example_bridges_fresh_test.dart
dart run example/run_all_examples.dart        # if it has a run script
```
