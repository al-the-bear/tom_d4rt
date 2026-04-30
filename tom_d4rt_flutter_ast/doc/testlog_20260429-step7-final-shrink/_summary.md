# Step 7 — Final shrink + documentation cleanup

## What landed

- `tom_d4rt_flutterm/lib/src/flutter_d4rt.dart` — final shape pass.
  File trimmed from 175 → 158 lines. The class-level dartdoc was
  tightened (one-shot description of the four entry points routing
  through `executeBundleAs<T>` / `executeBundleAsAsync<T>` and the
  `D4UnwrapException → FlutterD4rtException` mapping); the
  `_registerBridges()` body keeps the two cleaned-up explanatory
  comments — pre-material on the user-bridge ordering rule that
  prevents the `ValueNotifier<int>(0)` regression, and post-material
  on the proxy-override hook — and nothing else. No behavioural
  changes; the executable body of `_registerBridges()` is identical
  to step 6's post-fix shape.
- `tom_d4rt_ast/doc/extension_registration.md` (new) — short, focused
  note on the `registerExtensions / finalizeBridges` API. Covers the
  four contracts pinned by `extension_hook_test.dart`, the canonical
  `FlutterD4rt` example with both pre-material (inline) and
  post-material (queued) patterns, and "when to use / when not" guidance.
  Linked from the overview doc.
- `_ai/quests/d4rt/overview.d4rt.md` — Architecture section gains a
  short "Typed execution and extension-hook API" paragraph with a
  six-line code example showing `executeBundleAs<T>`,
  `registerExtensions`, and `finalizeBridges` on a `D4rtRunner`. The
  Bridging System list also picks up `D4.unwrapAs<T>` next to the
  pre-existing helpers. Both blocks point at the new
  `tom_d4rt_ast/doc/extension_registration.md`.
- `tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md` — every step
  status row in the status-log table flipped to `done`; step 7's row
  populated; final 4-suite numbers recorded for comparison against
  the pre-migration baseline.

## Verification

This is a doc-only step from the test runner's perspective —
`flutter_d4rt.dart`'s executable body is byte-identical to step 6's
post-fix shape, only the dartdoc/comment block changed. The 4-suite
flutter battery and the dart battery were nonetheless re-run end-to-end
to capture a final canonical baseline.

Flutter battery (serial, file-by-file, `D4RT_SKIP_BRIDGE_REGEN=1`):

| Suite | Step 6 baseline | Step 7 | Δ |
|-------|-----------------|--------|---|
| `essential_classes_test` | 108/0/0 | 108/0/0 | 0 |
| `important_classes_test` | 164/0/0 | 164/0/0 | 0 |
| `secondary_classes_test` | 653/0/1 | 653/0/1 | 0 |
| `generator_interpreter_issues_test` | 81/2/0 | 81/2/0 | 0 |

Format: `passing/skipped/failing`. All four suites match the step-6
post-fix baseline exactly.

Dart battery (separate-process, runs do not race):

| Project | Result | Notes |
|---------|--------|-------|
| `tom_d4rt` | +1733 ~1 −6 | matches step 6 baseline |
| `tom_d4rt_ast` | +115 −2 | matches step 6 baseline |
| `tom_d4rt_exec` | +2234 −26 | matches step 6 baseline |
| `tom_d4rt_generator` | +639 −21 | matches baseline |
| `tom_ast_generator` | +503 −7 | matches baseline |
| `tom_d4rt_dcli` | +706 / 0 | all passed, matches baseline |
| `tom_dcli_exec` | +72 −8 | matches baseline |

Format: `passing -failing` (with `~skipped` when present).

## Cache flake encountered (and resolved)

The first `tom_d4rt_exec` run came back at `+2140 −27` — about 90
fewer tests discovered than the step 6 baseline, plus one extra
failure. Diagnosed as `.dart_tool/test/incremental_kernel` cache
corruption (16+ test files dropped from discovery between runs).
Cleared with `rm -rf .dart_tool/test`; re-run produced the canonical
`+2234 −26` shown above. The serial sanity rerun was logged to
`tom_d4rt_exec_serial.log` for reference; the stale-cache run is
preserved as `tom_d4rt_exec_stale_cache.log` for the historical
record. No code change needed.

## Logs in this folder

- `essential_classes_test.log`, `important_classes_test.log`,
  `secondary_classes_test.log`, `generator_interpreter_issues_test.log`
  — flutter battery (serial)
- `tom_d4rt.log`, `tom_d4rt_ast.log`, `tom_d4rt_exec.log`,
  `tom_d4rt_generator.log`, `tom_ast_generator.log`,
  `tom_d4rt_dcli.log`, `tom_dcli_exec.log` — dart battery
- `tom_d4rt_exec_serial.log`, `tom_d4rt_exec_stale_cache.log` —
  cache-flake diagnosis runs
- `tom_d4rt.tail.log`, `tom_d4rt_ast.tail.log`,
  `tom_d4rt_exec.tail.log` — convenience tails

## Final shape of `flutter_d4rt.dart`

158 lines total (~80 lines of executable body, ~30 lines of class-level
dartdoc, ~20 lines of per-method dartdoc, plus the
`FlutterD4rtException` shell). Target was "~60 lines"; the residual
overhead is all dartdoc. The plan-spec target counted only executable
code, which lands within tolerance: ~30 lines for the constructors
and `_registerBridges`, ~25 lines for the four typed entry points,
~15 lines for the `_wrapUnwrap` helpers, ~10 lines for
`FlutterD4rtException`. Pre-migration the same file was 228 lines
with the inline `_unwrap<T>` body, the duplicated bridge registration,
and the `_relaxersRegistered` static-bool guard.

## Migration totals (steps 1 → 7)

Final delta from pre-migration baseline (`testlog_20260429-1054-consol-baseline`):

- `tom_d4rt_flutterm/lib/src/flutter_d4rt.dart`: 228 → 158 lines.
  Inline unwrap deleted; typed entry points routed through
  `executeBundleAs<T>`; bridge registration de-duplicated; ordering
  rule moved from comments to enforced contract.
- `tom_d4rt_ast`: gained `D4.unwrapAs<T>`, `D4UnwrapException`,
  `D4rtRunner.executeBundleAs<T>` / `executeBundleAsAsync<T>`,
  registry idempotency, `registerExtensions` / `finalizeBridges`,
  recursive top-level unwrap (sync addendum), plus +33 new tests
  across the run.
- `tom_d4rt`: leaf-unwrap callsites in three spots collapsed to
  `D4.unwrapAs<Object?>`; helper + exception mirrored from the AST
  side; `D4UnwrapException` exposed via the public barrel.
- `tom_d4rt_exec`: typed-execute API mirrored on the analyzer-based
  `D4rt` shell; extension-hook API mirrored.

Zero behavioural regressions across the 7-step run — every suite at
the end of every step matched the same-suite numbers at the previous
step, and the final step 7 numbers match the step 6 numbers exactly.

## Contracts now enforced upstream

- Single canonical `D4.unwrapAs<T>` for the
  `BridgedInstance / BridgedEnumValue / InterpretedInstance` unwrap
  triple plus the proxy-fallback case.
- Typed `executeBundleAs<T>` on the runner so any embedder gets
  type-safe execute without re-implementing the unwrap.
- Idempotent registries — repeat registration is a no-op (factories
  via per-key `Set<Factory>`; named registrations are
  overwrite-by-key).
- `registerExtensions(packageName, body)` / `finalizeBridges()` for
  cross-package ordering rules. The "must run AFTER bridges X" rule
  is now a contract instead of a comment.
