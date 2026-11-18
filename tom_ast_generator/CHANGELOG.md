## 0.2.9

### Fixed — the resolving check reads each package under its own language version (ghissues74)

With `explicitSources` the resolving check placed every package in a virtual
workspace under the SDK's language version, so a package written for an older
one was refused: intl 0.20.3 (language 3.9) declares
`num parse(final String inputText)`, which Dart 3.13 reports as
`extraneous_modifier`.

- `AstBundler.packageLanguageVersions` (package name -> `major.minor`) gives
  each package placed from `explicitSources` or `declarationStubs` its
  language version (`AstResolver.checkModules(languageVersions:)`,
  `checkFiles(languageVersions:)`); a package without an entry keeps the
  SDK's.
- `astgen --resolve --package-config <file>` reads those versions from a
  `package_config.json` (its `languageVersion` entries; `rootUri` is not
  read).
- In a project, an explicit source of a package the project places outside
  its root (the pub cache) failed with `Unable to find the context`. Such a
  package is now moved into the virtual workspace with its other library
  files, under the project's language version, and its facts stamp keeps
  its version.

The intl 0.20.3 closure (intl, clock, meta, path) from `explicitSources`
passes the check with the packages' language versions given.

## 0.2.8

### Added — the static facts table (ghissues69, GitHub #18 option 3, part 2)

- **A resolving bundle records static facts.** With
  `AstBundlerConfig(resolve: true)` and `staticFacts: true` (the default), the
  resolution also records, per module and node `offset:length`:
  - the static receiver type, extension and type arguments of every extension
    member access with an explicit receiver;
  - the inferred type arguments of generic calls, instance creations and
    collection literals that do not write them.

  Types are interned once per bundle. The table is stamped with the Dart SDK
  version and the versions of the packages its types come from.
- **`ResolvedAstBundle`**, an `AstBundle` whose JSON (and so `toBytes`)
  carries the table under the optional `facts` key; `ResolvedAstBundle.readFacts`
  reads it back. Readers that do not know the key, the published tom_d4rt_ast
  included, read and run the bundle as before, and the bundle format version
  stays `2.0`. The ZIP form does not carry the table yet.
- **`StaticFactsCollector`**, the collector, and `ResolveReport.facts`.
- **`doc/resolved_bundles.md`**: what is recorded, the layout, the stamp and
  the rule a runtime compares it with, and sizes (the 351 material corpus
  scripts: +0.3% JSON / +1.1% gz).
- **Requires tom_ast_model 0.3.2**, which holds the model and codec
  (`SStaticFacts`).

## 0.2.7

### Added — the resolving check (ghissues68, GitHub #18 option 3, part 1)

An opt-in mode that resolves a bundle's modules with the analyzer and reports
what Dart would reject - a name the script never imported, a type mismatch, a
missing member - which parse-only bundling cannot see. Plain bundling is
unchanged and stays parse-only.

- **`AstBundlerConfig(resolve: true)`**: after collecting the modules,
  `AstBundler` resolves them; on an error it throws `AstResolveException`
  (`report.errors`: module URI, line, column, analyzer code, message) and
  returns no bundle. A passed check's report is `AstBundler.lastResolveReport`.
  Works from `explicitSources` with file reads disabled (the sources are
  analyzer overlays in a virtual package configuration; nothing is written to
  disk) and inside a project (`createFromFile`, `projectRoot`), whose
  `package_config.json` supplies the packages.
- **`AstBundler.declarationStubs`**: Dart declarations, by library URI, for
  libraries that exist only at run time (a host function registered with
  `registerTopLevelFunction`). The resolver checks against them; they are
  never bundled.
- **Runtime-only libraries without source or stub** (`bridgedLibraries`):
  their import and the names they would supply are left out and counted
  (`ResolveReport.filtered`), not reported.
- **The Dart SDK is found without a flag** (`findDartSdk`):
  `AstBundlerConfig.sdkPath`, else `DART_SDK`, else the `dart` on `PATH`, else
  the `flutter` on `PATH` (`bin/cache/dart-sdk`), else the running VM. Works in
  the AOT-compiled `astgen`; when nothing is found, `DartSdkNotFoundException`
  names every place searched.
- **`AstResolver`**, the check itself: `checkModules` (what the bundler uses)
  and `checkFiles`, which resolves many files of one project in one analysis
  context, for checking a corpus.
- **`astgen --resolve`** checks each entrypoint before converting it; a file
  with an error is reported and not written, and the run exits non-zero.
  `--dart-sdk <path>`, `--stubs <folder>` (`<folder>/<package>/<path>`
  declares `package:<package>/<path>`) and `--runtime-library <uri>`
  (repeatable) go with it.
- **`tool/resolve_check.dart`** runs the check over folders of scripts in a
  project; `tom_d4rt_flutter_ast/test/run_corpus_check.sh` runs it over the
  twins' corpus (2096 scripts, 0 errors).
- In a project, an `analysis_options.yaml` that excludes files is seen by the
  check without its `analyzer: exclude`: a file the check is asked about is
  resolved even when `dart analyze` skips it.

Name resolution: no.

## 0.2.6

### Changed — takes tom_d4rt_ast 0.244.0

`tom_d4rt_ast ^0.244.0` (from `^0.243.0`): the release with per-execution
hooks (GitHub #19), aliases whose target a re-exported library declares, and
export-only bridged libraries. Nothing in the bundling changes.

Name resolution: no.

## 0.2.5

### Changed — takes tom_d4rt_ast 0.243.0

`tom_d4rt_ast ^0.243.0` (from `^0.237.0`): the interpreter release for GitHub
#13-#18 - a bridged `noSuchMethod` satisfies an interface, the extensions of a
prefixed import apply, generic function references keep their type
arguments, an extension's own type parameters are bound, explicit extension
overrides `E(x).member`, and an extension's getter and setter of one name.

Name resolution: no.

## 0.2.4

### Changed — the workspace root is the nearest `buildkit_master.yaml`

`astgen --list` names projects relative to tom_build_base's
`findWorkspaceRootOrNull` (tom_build_base `>=2.23.0 <3.0.0`), or the execution root
outside a workspace, instead of the deprecated `findWorkspaceRoot`.

## 0.2.3

### Changed — takes tom_d4rt_ast 0.237.0

`tom_d4rt_ast ^0.237.0` (from `^0.236.0`): the interpreter release that keeps a
generic call's type arguments with their `?` and their own type arguments.

Name resolution: no.

## 0.2.2

### Fixed — the bundler parses at the interpreters' language version (GitHub #9)

`AstBundler` and `astgen` called `parseString` without a feature set, so they
parsed at analyzer 14.7.0's newest language version, which rejects a `final`
parameter: bundling the unmodified intl 0.20.3 sources failed with "Can't have
modifier 'final' here" (`num parse(final String inputText)`). Both now parse
with `bundleFeatureSet`, the language version and flags the interpreters' own
parser uses. `pub_semver` is a direct dependency.

Name resolution: no.

### Changed — takes tom_d4rt_ast 0.236.0

The interpreter constraint is `tom_d4rt_ast ^0.236.0` (from `^0.212.0`), so a
package depending on this one can resolve the interpreter's current release.

Name resolution: no.

## 0.2.1

### Changed — on tom_d4rt_ast 0.212.0

Follows the interpreter release that adds the async entry points and keeps a
suspended `async` run's result when another run starts. No code changed here.

## 0.2.0

### Changed (breaking) — analyzer ^14.5.0 into tom_ast_model 0.3 (vstdm3)

The copier walks analyzer 14's AST and writes `tom_ast_model` 0.3 node for
node: one formal parameter with its default clause and function-typed suffix,
named arguments and named record fields, labels and label references, name
parts and bodies, the extension type's primary constructor, and dotted names
without their period tokens. Bundles are written in format 2.0.

### Fixed — named arguments are no longer dropped

The argument list collected `SExpression` nodes and the list helper dropped
every converted node of another type, so each named argument would have
vanished. The helper now throws, naming the analyzer node and the type it
became, instead of filtering.

## 0.1.17

### Changed — resolves tom_d4rt_ast 0.210.0 and tom_d4rt_exec 1.50.0 (dfin9)

`tom_d4rt_ast` ^0.210.0 and dev `tom_d4rt_exec` ^1.50.0, carrying the web
`int` fix.

## 0.1.16

### Changed — resolves tom_d4rt_ast 0.209.0 and tom_d4rt_exec 1.48.0 (dfin7)

`tom_d4rt_ast` ^0.209.0 and dev `tom_d4rt_exec` ^1.48.0, the correctness
release.

## 0.1.15

### Changed — resolves tom_d4rt_ast 0.207.0 and tom_d4rt_exec 1.45.0 (dfin4)

`tom_d4rt_ast` ^0.207.0 and dev `tom_d4rt_exec` ^1.45.0, the security release.

## 0.1.14

### Changed — resolves tom_d4rt_ast 0.206.0 and tom_d4rt_exec 1.42.0 (sci2)

`tom_d4rt_ast` ^0.206.0 and dev `tom_d4rt_exec` ^1.42.0. The generator tests
read generated code through `test/generator_tests/support/generated_code.dart`,
the helper tom_d4rt_generator's own suite uses, because tom_d4rt_generator
1.51.0 formats what it writes.

## 0.1.13

### Fixed — a failed project fails the run whether or not `--verbose` is set (scf33)

A conversion whose `output` could not be resolved (a `project:` name not in
the workspace) printed an error and counted it, but only a `--verbose` run
turned the count into a failure: the same configuration exited 0 without the
flag — including under `--dry-run`, the way a new configuration is checked.
The project's verdict is now the error count, whatever was printed.

### Docs — the `astgen` reference describes the shipped tool (scf33)

`doc/astgen_build_yaml.md` is rewritten from `lib/src/v2/`: the `astgen:`
section of `buildkit.yaml` is the only configuration, every `convert` key with
its default, the three `output` forms and the project lookup, the output
naming (`hello.runner.dart` → `hello.runner.ast.yaml`), what fails a project,
and the command-line options. `doc/tom_build_configuration_and_cli.md` is
removed: it described `tom_build.yaml` / `build.yaml` configuration and a
registration-code generator, none of which the package has.
`test/v2/scf33_astgen_doc_examples_test.dart` runs every `astgen:` example in
the doc through the executor.

## 0.1.12

### Changed — conditional imports are resolved for the bundle's target (scf16)

`AstBundler` followed only a directive's default URI, so
`import 'stub.dart' if (dart.library.io) 'io.dart';` bundled the stub on every
platform although the tree carried both branches (since sce49). The bundler
now resolves configurations when it builds: `AstBundlerConfig.target`, a
`BundleTarget` naming the platform's `dart:` libraries and environment
declarations, selects the first branch whose condition holds (else the
default), only that module is bundled, and the import or export is rewritten
to it with its configurations dropped.

**The default target is `BundleTarget.vm`, so a VM bundle of a source tree
with conditional imports now carries the `dart.library.io` branch where it
used to carry the default.** Build with `BundleTarget.web` for a bundle a web
app loads. A bundle is therefore specific to its target.

Numbered 0.1.12 rather than 0.2.0 for the reason sce241 gave:
`tom_d4rt_exec`, a dev dependency here, constrains this package to `^0.1.x`,
so a 0.2.0 could not resolve its own dev dependencies.

## 0.1.11

### Changed — resolves the current interpreter (sce237)

Requires `tom_d4rt_ast` ^0.184.0 (published 2026-09-29). Dev dependencies
follow: `tom_d4rt_exec` ^1.35.0 and `tom_d4rt_generator` ^1.46.0.

### Added — every bundle names the astgen that wrote it (scf3, sce15)

`AstBundler` now sets `AstBundle.generator` to `tom_ast_generator <version>`
on every bundle it builds, from `createFromSource` and `createFromFile`
alike. The version is the versioner stamp, the same value `astgen --version`
prints, so a bundle cannot disagree with the tool's banner. It reaches the
plain JSON, the gzip bytes and the ZIP manifest. A bundle that misbehaves on
a device can now say which tool produced it. Older bundles still load, with
`generator` null. This uses the field `tom_d4rt_ast` published in the
0.115.0 line, which every release this package accepts carries.

## 0.1.10

### Added — `AstBundlerConfig.includeSources` (sce236)

(This release was first numbered 0.2.0 in the working tree and never published
as that. A patch release on purpose. The option is additive and off by default, and a
0.2.0 would fall outside the `^0.1.x` that every published `tom_d4rt_exec`
declares. `tom_d4rt_exec` is this package's own dev dependency, so 0.2.0
could not resolve at all (sce241).)

The bundler can now fill `AstBundle.sources` with every bundled module's
source text. The analyzer-free interpreter uses it to quote the script in a
diagnostic. The option is off by default: it costs bundle size, and a release
bundle may not want to ship its own source.

Measured 2026-09-29 on a 26 KB corpus script
(`material/animated_theme_test.dart`):

| | Without sources | With sources | Change |
| --- | ---: | ---: | ---: |
| JSON | 308 KB | 335 KB | +9% |
| Gzipped | 26.7 KB | 30.9 KB | +16% |

## 0.1.9

### Changed — resolves the current interpreter (sce212)

`tom_d4rt_ast` ^0.177.0 (was ^0.65.0). Every published 0.1.6-0.1.8 pinned
0.65.0, so a consumer on a current interpreter could not resolve any of them
and pub fell back to 0.1.5 — the copier from before sce62's `library`
directive fix — without saying so. Dev dependencies follow: `tom_d4rt_exec`
^1.33.0, `tom_d4rt_generator` >=1.44.0, and the examples' exec floors.

## 0.1.8

### Fixed — `library` directives crashed the copier (sce62)

`_convertLibraryDirective` cast `node.name` to `SIdentifier?`, but the
`LibraryIdentifier` that holds it had no dispatch arm in `convert()`. So it
became the `_SUnknownNode` placeholder and the cast failed:

```
type '_SUnknownNode' is not a subtype of type 'SIdentifier?' in type cast
```

`library foo; main() => 42;` is valid Dart that the reference interpreter runs
and returns 42 for — a library directive has no runtime effect. exec could not
interpret it at all, which is a conformance break rather than a missing
feature.

The name is flattened to one `SSimpleIdentifier` carrying the dotted text.
`SPrefixedIdentifier` could have carried two components but not three, so it
would have worked until somebody wrote `library a.b.c`. Nothing reads the
component structure; the flattening is recorded at the conversion site rather
than left to be rediscovered.

### Changed — an unhandled node now says what it is

An unhandled node type reaches `_SUnknownNode`, and the two paths that consume
converted nodes both failed badly:

* `_as<T>` cast, producing `type '_SUnknownNode' is not a subtype of type
  'SIdentifier?' in type cast` — naming neither the construct nor its position.
* `_nodesAs<T>` filtered on a type pattern, so an unhandled node in a
  statement, member or collection list was **silently dropped** and the script
  ran without it.

Both now raise `UnsupportedError` naming the analyzer node type, the offset and
the source text, the way the reference interpreter's
`Unsupported AST node 'X' at offset N` does. The two constructs this currently
affects — `class B = A with M;` and dot shorthands — are unsupported by the
reference interpreter too, so this changes the diagnosis rather than the
capability.

No construct reaches the `_nodesAs` drop today: every statement, class-member
and collection-element type the analyzer parses is dispatched, and
`Configuration`, the one list element that WAS dropped (0.1.7), has had an arm
since. That path is closed for the next unhandled type rather than for a
present defect.

### Added — `tool/census_copier.dart`

Which of the copier's 154 `_convert*` methods a test suite has never executed,
and which node types reach the placeholder. See the file header for what the
census can and cannot see — notably that it cannot see a handled node whose
FIELD is silently not copied, which is what 0.1.7 fixed.

## 0.1.7

### Fixed — conditional import/export branches are no longer dropped (sce49)

`_convertImportDirective` read `uri`, `prefix`, `combinators` and
`deferredKeyword`, and never `node.configurations` — because the mirror AST had
no field to put them in. `_convertExportDirective` was the same. So

```dart
import 'stub.dart' if (dart.library.io) 'io.dart';
```

reached every consumer as `import 'stub.dart';`: a well-formed import of the
default URI with nothing anywhere recording that a branch had been discarded.
Conditional imports are the standard Dart mechanism for VM-vs-web divergence,
so the symptom surfaces on one platform, far from the cause.

Both converters now populate `configurations`, and `analyzer.Configuration` and
`analyzer.DottedName` are in the `convert()` dispatch chain — a node type that
is not in it falls through to the opaque unknown-node placeholder and is then
filtered out of the typed list, which is how DGUB8 lost every record-type
field.

The conditions are COPIED, not evaluated: which branch applies depends on the
target platform, which this converter does not know.

Requires `tom_ast_model` 0.2.2, which adds `SConfiguration` and `SDottedName`.

### Added — a 1:1 fidelity ratchet over the directive nodes

`test/directive_mirror_fidelity_test.dart` enumerates, by reflection, every
getter the analyzer's `ImportDirective`, `ExportDirective`, `Configuration` and
`DottedName` declare, and requires each to be classified exactly once: mirrored
(naming the field on the mirror node, which must exist) or deliberately absent
(with the reason). A field the analyzer adds later is in neither set and fails
the test by name, instead of disappearing the way `configurations` did.

## 0.1.6

### Released — so the corrected stamp reaches the package people install (sce9)

The tree's stamp has read 0.1.6 for some time; published 0.1.5 still ships one
saying 0.1.4, so `astgen --version` from pub.dev names the wrong release. This
release carries the corrected stamp.


### Changed — formatted the tree once (scd82)

Every package in this repo already declares an SDK floor above the 3.7
tall-style boundary, so the formatter can no longer produce two layouts here.
What was not true is that the trees were formatted: until this commit, running
`dart format` on any single file rewrote it wholesale and buried whatever real
edit came with it.

**Proven layout-only rather than assumed.** `git diff -w` cannot establish it,
because the tall style *splits* lines and a whitespace-insensitive diff still
counts a moved boundary as a change. What was checked is the token stream, per
file, twice: whitespace stripped, then whitespace and commas stripped. All 44 changed files are identical to HEAD under that normalisation — no braces were needed, so this commit is pure layout.

`dart analyze` is clean, the suite passes (566 tests), and the formatter is now
idempotent here.

## 0.1.5

### Fixed — record type annotation fields are converted, not dropped (DGUB8)

`_convertRecordTypeAnnotation` called the generic `convert()` on each
`analyzer.RecordTypeAnnotationField`. That class was never in the dispatch
chain, so every field fell through to the opaque unknown-node placeholder:
the mirror annotation reached the interpreter carrying only its ARITY — no
field types, and no named-field keys. Downstream that made
`(42, label: 'answer') is (int, {String label})` unanswerable, and let
`(1, 'a') is (String, int)` answer true.

Fields now convert into `SRecordTypeField` (`tom_ast_model` 0.2.0), keeping
the declared type — recursively, so a record inside a record survives — and
the named-field key. `RecordTypeAnnotationField` is also wired into the
generic dispatch, so no future caller can silently produce a placeholder
again.

Requires `tom_ast_model >=0.2.0`.

## 0.1.4

- Publish the analyzer-10 migration. The 0.1.3 release on pub.dev still carried
  `analyzer: ^8.0.0` / `tom_d4rt_ast: ^0.1.5`; the source had already moved to
  `analyzer: ^10.0.0` / `tom_d4rt_ast >=0.1.11` without a version bump, so the
  hosted package was stale. This bump ships the analyzer-10 constraints.
- In-workspace dependencies now use lower-bound-only constraints (no upper cap)
  so `pub upgrade` tracks our latest published components during active
  development.

## 0.1.3

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 0.1.2

- Documentation: build.yaml/CLI guide, limitations, and user guide updated;
  README aligned with the source-primary documentation reframe across the D4rt
  ecosystem.

## 0.1.1

- Consume `tom_ast_model ^0.1.1` / `tom_d4rt_ast ^0.1.5`: the converter now
  populates the `StaticResolver` slot-resolution members
  (`resolvedSlot` / `declSlot`) on the mirror AST it emits.

## 0.1.0

- First public release on pub.dev.
- 1:1 converter from the Dart analyzer AST to the serializable mirror AST
  (`SAstNode` from `tom_ast_model`), node-for-node and field-for-field.
- AST bundling machinery: parse once with the analyzer, copy to the mirror
  AST, serialize to JSON, interpret later without the analyzer.