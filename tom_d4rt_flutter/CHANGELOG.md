## 1.4.0

### Documented — why GEN-126's last two bases have no interface proxy (sce164)

`RenderProxyBox` and `TwoDimensionalChildBuilderDelegate` are the third and last
case of GEN-126: a script subclass returns as its bridged base and the
declared-parameter check refuses it. The obvious repair is a proxy registration.
Both were written, registered, measured and reverted; the analysis is recorded
in `d4rt_runtime_registrations.dart` where the registrations would go.

* A registration alone does nothing for these two. The proxy registry is
  consulted only when the bridged super class has NO constructor adapter — the
  ABSTRACT bases. Both of these are concrete, so the native base is built
  directly and handed across and the proxy is never constructed.
* Flipping that preference fixes the binding and WEDGES the app:
  `rendering/render_shrink_wrapping_viewport_test.dart` times out and
  `flutter_base_13` goes `+54` → `+52 -2`. Reverting restores `+54` exactly.
* The delegate proxy removes three type errors and produces 408 framework
  errors, because it makes the script's `build` override run for the first time
  and that override calls setState during build.

Comment-only in `lib/`. `test/sce164_proxy_registry_parity_test.dart` (AST twin,
covering both) fails if either is registered again, and independently holds that
the two hand-duplicated registries agree and that every proxy class exposes its
interpreted instance. scf31 owns the remaining work.

## 1.3.0

### Changed — the extension registry keys a named extension by name AND target type (sce1)

Regenerated at `tom_d4rt_generator` 1.26.2. These eighteen bridge files were
the last in the repo whose writer could not be named — they predate the
generator's version stamping — and unlike every other package in that sweep
the content moved rather than only the stamp:

    'StringCharacters'    -> 'StringCharacters@String'
    'HtmlElementViewImpl' -> 'HtmlElementViewImpl@HtmlElementView'

A NAMED extension was keyed by its bare name, so two extensions of the same
name on different target types collided. `tom_d4rt_flutter_ast` received this
at generator 1.26.0; this package never did, and the twins are now on the same
generator and the same keying.

Verified by the bridge corpus, which is the right gate for a bridge change:
base corpus 927 / 1 / 0, identical to the two preceding recorded runs cell for
cell.

## 1.2.3

### Fixed - a script subclass now binds as itself after a round trip (scd138 / GEN-126)

A script declaring `class _A11yNote extends StatelessWidget` and handing
instances to Flutter got the bridged BASE back when the value returned to a
parameter declared as its own class:

```
type 'StatelessWidget' is not a subtype of type '_A11yNote'
```

scd119 (tom_d4rt 1.106.0 / tom_d4rt_ast 0.93.0) fixed the MECHANISM:
`ResolvedBinding.bind` retries against the interpreted instance behind a
`D4InterpretedProxy` after the base check has failed. What it could not fix is
a proxy that does not expose one - and 21 of this package's 40 interpreted
proxies did not implement the interface, so the retry saw nothing and refused a
value that works.

Among them were the two bases a script is most likely to extend
(`StatelessWidget`, `StatefulWidget`) and several GEN-126 names its symptom
list.

Each now implements `D4InterpretedProxy` and exposes its instance. Purely
additive: the retry runs only after the base check has already failed, so it
can remove a rejection but never add one, and no program that binds today stops
binding.

**Needs an interpreter carrying scd119.** Below that the retry does not exist
and these declarations are inert.

## 1.2.2

### Fixed — a dangling citation in `d4rt_runtime_registrations.dart`

The `// Why:` above the slotted render-object proxy explained itself in full and
then cited `doc/testlog_20260427-1339-post-c22/error_analysis.md` for the D7
label. That folder was pruned in April along with every other run folder, so the
path had been unresolvable in any clone for months while still reading as
something a reader could open.

The comment now names the run (`20260427-1339-post-c22`) rather than a path,
which is the convention `interpreter_unfixable.md` states for a past pass: a run
id is the name of a pass, not a location. No behaviour changes.

## 1.2.1

### Changed — formatted the hand-written half of `lib/` (scd81)

The formatter had never been run here, so until this commit `dart format` on any
single file rewrote it wholesale and buried whatever real edit came with it. That
matters more in these two packages than in most: they are twins, and the shared
`d4rt_user_bridges/` set is derived by `sync_shared_user_bridges.dart` rewriting
one import line and checked by comparing TEXT.

**Only the hand-written files — the 18 generated `*.b.dart` are deliberately
untouched.** `tom_d4rt_generator` emits them by string concatenation and depends
on no formatter, so formatting them would start a permanent fight: format,
regenerate, and the diff is back. Teaching the generator to format its own output
is tracked separately, and needs a workspace-wide regeneration because every
consumer's freshness guard reads committed output.

Layout-only, measured rather than asserted: normalising away whitespace and then
whitespace-and-commas leaves every changed file byte-identical to its previous
content, and no quote count changed, so no string literal was re-split and no
D4rt script text moved. `dart analyze` clean in both twins.

## 1.2.0

- Add `ProfilingMetrics` (exported from `tom_d4rt_flutter.dart`) — a single
  compile-time switch mirroring the interpreter's `D4rtProfiler.enabled`, plus
  `snapshot()`, `report()` and `reset()`. The test app and the test drivers now
  read one source of truth for whether D4rt's init-path profiler is compiled
  in. The published default is off, so every profiling branch behind it is
  dead-code-eliminated at zero runtime cost.
- Migrate the `TwoDimensionalChildDelegate` proxies to `ScrollCacheExtent`,
  following the Flutter SDK's replacement of the raw cache-extent doubles
  (RCK22).
- Regenerate all 15 Flutter bridge files under the upgraded Flutter SDK on
  `tom_d4rt_generator` 1.14.0. The visible surface change is that bridged enums
  now carry their static methods — e.g. `KeyboardLockMode.findLockByLogicalKey`
  is callable from interpreted code.
- Fix the `idle_timeout` watchdog in the test harness on Linux (RCK22).

## 1.1.0

- Add `SourceFlutterD4rt.warmup()` — forwards to `D4rt.warmup()` so embedders
  can pay the residual eager warm-up cost (warm-parent `Environment`, stdlib,
  and the analyzer parser front-end) off the first frame instead of stalling
  the first script build. The recommended call site is a post-first-frame
  callback: `WidgetsBinding.instance.addPostFrameCallback((_) => d4rt.warmup())`.
  Idempotent and script-neutral.

## 1.0.1

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 1.0.0

Initial pub.dev release of the source-based Flutter bridge runtime — the
recommended way to run D4rt scripts that return Flutter widget trees.

- `SourceFlutterD4rt` — a `tom_d4rt` interpreter pre-loaded with the full
  generated Flutter Material bridge surface (17 generated `*.b.dart` files under
  `lib/src/bridges/`). Feed it raw Dart source; it returns a live `Widget`.
- `build(source, context)` and `buildMultiFile(...)` entry points; rendering
  against **real** Flutter widgets (not mocks).
- Hand-written runtime registrations layered on top of the generated bridges:
  interface proxies, generic type relaxers, and generic constructor factories.
- `d4rt_user_bridges/` — hand-written `D4UserBridge` overrides for classes that
  need bespoke behaviour beyond the generated adapters.
- Sample-source loaders (`SampleProgram`, `SampleSource`, `createSampleSource`,
  `DiskSampleSource`, `AssetSampleSource`, `buildDiskProgram`, …) for loading
  multi-file sample apps.
- Bridge conformance test suite plus the long-lived companion-app HTTP harness
  used to drive the flutter-material corpus.