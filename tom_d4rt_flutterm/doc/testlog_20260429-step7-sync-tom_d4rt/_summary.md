# Step 7 follow-up — sync audit + back-port to `tom_d4rt`

## Trigger

User request, 2026-04-29:

> Make sure the implementation of
> `tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md` was done in both
> `tom_d4rt` and `tom_d4rt_ast` in parallel. Retest again if there was
> need for further changes in one of the project.

The quest's hard rule (`overview.d4rt.md` → "Keep tom_d4rt ↔
tom_d4rt_ast in sync") requires every interpreter-level change to
land on both forks. The seven-step migration was driven primarily
through the AST side; this audit walked the merged plan step-by-step
to confirm dual-landing.

## Audit findings

| Step | Generic surface | tom_d4rt_ast | tom_d4rt | Verdict |
|------|----------------|--------------|----------|---------|
| 1 — `D4.unwrapAs<T>` + `D4UnwrapException` | helper + exception | `runtime/generator/d4.dart:1741` + `runtime/exceptions.dart` | `generator/d4.dart:1661` + `exceptions.dart` | dual-landed |
| 2 — `D4rtRunner.executeBundleAs<T>` / async | bundle-mode typed execute | `runtime/d4rt_runner.dart` | **N/A** — `tom_d4rt` is source-based (no `executeBundle`), `executeBundleAs` is mirrored on `tom_d4rt_exec.D4rt` instead | not applicable |
| 3 — `FlutterD4rt._unwrap` cutover | `tom_d4rt_flutterm` only | n/a | n/a | flutterm-internal |
| 4 — `_bridgeInterpreterValueToNative` leaf delegation | unwrap delegation | `runtime/interpreter_visitor.dart:10457` | `interpreter_visitor.dart:9152` + `d4rt_base.dart` recursive sync | dual-landed |
| 5 — Registry idempotency tags + `Set<Factory>` dedupe | helper contract | `runtime/generator/d4.dart` (idempotent tags + per-key Sets) | `generator/d4.dart` (parallel) | dual-landed |
| 6 — `registerExtensions` / `finalizeBridges` extension hook | runner-level API | `runtime/d4rt_runner.dart` | **MISSING** — never landed on `D4rt` in `tom_d4rt/lib/src/d4rt_base.dart` | **drift, fixed below** |
| 7 — Doc-only shrink | docs | n/a | n/a | doc-only |

Step 6 was the only real drift. The original step-6 plan-spec line
"`tom_d4rt_exec/lib/src/d4rt_base.dart` — mirror the methods on
`D4rt`, forwarding to the inner runner" referenced the analyzer-based
`D4rt` shell in `tom_d4rt_exec`, but the same surface should also
live on the analyzer-based `D4rt` in `tom_d4rt`'s `d4rt_base.dart`
to keep the source-based runner symmetric with the AST runner. The
miss was cosmetic for `tom_d4rt_flutterm` (which depends only on
`tom_d4rt_ast`/`tom_d4rt_exec`) but a real sync gap for any embedder
or downstream test that drives the analyzer-based source runner
directly.

## Back-port

`tom_d4rt/lib/src/d4rt_base.dart` — parallel to
`D4rtRunner.registerExtensions` / `finalizeBridges` on the AST side:

- New field: `_extensionCallbacks: Map<String, void Function()>` —
  insertion-ordered (Dart's `LinkedHashMap` semantics) so callbacks
  fire in registration order.
- New field: `_bridgesFinalized: bool` and matching getter.
- New method: `registerExtensions(String packageName, void Function() body)`.
  Last-write-wins on package name (overwrites previous body for the
  same key). Throws `StateError` if `finalizeBridges()` has already
  run.
- New method: `finalizeBridges()`. Idempotent — second call is a
  no-op. Iterates the callback map in registration order.
- Implicit finalize wired at the top of `_executeInEnvironment`
  (the single funnel through which `execute()`, `eval()`, and
  `evaluateExpression` route). Already-finalized → no-op; first call
  flushes the queue before pass 1 sees any declarations.

Mirror semantics, line for line, with the AST-side runner.

`tom_d4rt/test/extension_hook_test.dart` (new) — 7 contract tests
parallel to `tom_d4rt_ast/test/runtime/extension_hook_test.dart`, but
driven through `d4rt.execute(source: 'int main() => N;')` instead
of `executeBundle(...)` since `tom_d4rt` is source-based:

1. callbacks fire in registration order on `finalizeBridges()`
2. `finalizeBridges()` is idempotent — repeat calls do not re-run
3. re-registering with the same package name overwrites the body
4. `registerExtensions` throws `StateError` after `finalizeBridges`
5. callbacks fire implicitly on the first `execute` call
6. a second `execute` call does NOT re-run callbacks
7. explicit `finalizeBridges` before `execute` is supported and
   does not double-fire

All 7 pass.

## Verification

Dart battery (separate-process, runs do not race):

| Project | Step 7 baseline | Step 7 sync | Δ |
|---------|-----------------|-------------|---|
| `tom_d4rt` | +1733 ~1 −6 | +1740 ~1 −6 | +7 (the new contract tests) |
| `tom_d4rt_ast` | +115 −2 | +115 −2 | 0 |
| `tom_d4rt_generator` | +639 −21 | +639 −21 | 0 |
| `tom_d4rt_dcli` | +706 / 0 | (run pending — log file) | tracked |

Format: `passing/skipped -failing` (skip count omitted when zero).

The `tom_d4rt` delta is exactly +7 — the new
`extension_hook_test.dart` contract suite — with no other test count
change. No pre-existing test regressed; no new test failed. The
back-port is behaviour-additive on `D4rt`'s public surface.

`tom_d4rt_ast` and `tom_d4rt_generator` match the step-7 baseline
exactly, confirming the back-port is local to `tom_d4rt` and does
not perturb the AST runner or the bridge generator.

The flutter battery was not re-run as part of this addendum:
`tom_d4rt_flutterm` does not depend on `tom_d4rt` (only
`tom_d4rt_ast` / `tom_d4rt_exec` and `tom_d4rt_generator`), so the
sync change has no path into the flutter-material corpus.

## Logs in this folder

- `tom_d4rt.log` — full `tom_d4rt` suite (`+1740 ~1 −6`)
- `tom_d4rt_ast.log` — full `tom_d4rt_ast` suite (`+115 −2`)
- `tom_d4rt_generator.log` — full `tom_d4rt_generator` suite (`+639 −21`)
- `tom_d4rt_dcli.log` — full `tom_d4rt_dcli` suite

## What changed in the plan doc

`tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md` — step 6 row in
the status log gains a sync addendum noting the back-port. Files
list for step 6 updated to include the `tom_d4rt` half (previously
omitted). Status stays `done`.
