# tom_dcli_exec examples → see tom_d4rt_dcli

`tom_dcli_exec` is the **analyzer-free** sibling of
[`tom_d4rt_dcli`](../../tom_d4rt_dcli): same DCli shell-scripting bridge
surface, different interpreter (mirror-AST runtime vs analyzer-based). To
avoid duplicating sample code that must be kept in lock-step, the canonical
DCli sample home is **`tom_d4rt_dcli/example/`** — every sample there runs
unchanged on this analyzer-free runtime.

## Canonical samples

| Sample | Location |
|--------|----------|
| Basic single-file snippets (file ops, dirs, processes, env, colour, errors) | [`tom_d4rt_dcli/example/`](../../tom_d4rt_dcli/example/README.md) |
| **build_suite** — multi-file build/automation tool (BuildKit + cross-file classes + shell bridges) | [`tom_d4rt_dcli/example/build_suite/`](../../tom_d4rt_dcli/example/build_suite/README.md) |
| **log_pipeline** — multi-file parse→filter→aggregate file-processing pipeline | [`tom_d4rt_dcli/example/log_pipeline/`](../../tom_d4rt_dcli/example/log_pipeline/README.md) |

## Running a canonical sample on this runtime

The samples are ordinary multi-file D4rt CLI scripts, so they run on either
tool. Using this package's analyzer-free executable:

```bash
# From the tom_d4rt_dcli example tree:
dart run tom_dcli_exec:dclie ../tom_d4rt_dcli/example/build_suite/main.dart all
dart run tom_dcli_exec:dclie ../tom_d4rt_dcli/example/log_pipeline/main.dart ERROR WARN
```

(Replace the entry point with the compiled binary name once built — see this
package's README for the executable details.)

> **Why a pointer, not a copy?** Keeping one canonical sample set means a fix
> or new sample lands once and is exercised on both the analyzer-based
> (`tom_d4rt_dcli`) and analyzer-free (`tom_dcli_exec`) runtimes, instead of
> drifting between two near-identical copies.
