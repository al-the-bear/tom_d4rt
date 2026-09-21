# Tom D4rt AST - Copilot Guidelines

**Project:** `tom_d4rt_ast`  
**Type:** Dart Package

---

## 🚨 CRITICAL SYNCHRONIZATION WARNING 🚨

**Changes to the D4 class (`lib/src/runtime/generator/d4.dart`) MUST also be made in `tom_d4rt`!**

See [sync_with_tom_d4rt.md](sync_with_tom_d4rt.md) for details. Both packages must be published together.

---

## Applicable Guidelines

### Global Guidelines
| Document | Purpose |
|----------|---------|
| [Documentation Guidelines](../../../../_copilot_guidelines/documentation_guidelines.md) | Where to place user docs vs development docs |
| [Specification Workflow](../../../../_copilot_guidelines/spec_workflow.md) | How to implement from specifications |

### Dart Guidelines
| Document | Purpose |
|----------|---------|
| [Coding Guidelines](../../../../_copilot_guidelines/dart/coding_guidelines.md) | Naming conventions, error handling, patterns |
| [Unit Tests](../../../../_copilot_guidelines/dart/unit_tests.md) | Test structure, matchers, mocking patterns |
| [Examples](../../../../_copilot_guidelines/dart/examples.md) | Example file creation guidelines |

## Project-Specific Guidelines

| File | Description |
|------|-------------|
| [testing.md](testing.md) | This tree's own testing conventions — no source execution, hand-built bundles, the `-AST-` id infix, and the dependency and platform constraints |
| [sync_with_tom_d4rt.md](sync_with_tom_d4rt.md) | 🚨 **CRITICAL** D4 class synchronization with tom_d4rt |
| [same_name_class_resolution.md](../../tom_d4rt_generator/_copilot_guidelines/same_name_class_resolution.md) | Resolution rule for two packages declaring the same class name (implemented identically here and in `tom_d4rt`; canonical doc lives with the generator) |

## The four files the other two trees have and this one does not

`tom_d4rt` and `tom_d4rt_exec` each carry seven guideline files; this package
carries three. Three of the four absences are decisions and one is a gap, and
they are written out here so that the next reader does not have to decide
which is which — the reason this section exists at all is that the absence of
`testing.md` looked like a decision for as long as nobody asked.

| File they have | Status here |
|----------------|-------------|
| `build.md` | **Partly covered.** Its publishing half — publish in step, order, run both suites first — is [sync_with_tom_d4rt.md](sync_with_tom_d4rt.md), which is stricter than theirs because these two packages must be published together. Its analyzer/test half is two commands and is in [testing.md](testing.md). |
| `documentation.md` | **Not needed.** Nothing about doc placement differs from the workspace rule, and a third copy is a third thing to keep in step. See the global [Documentation Guidelines](../../../../_copilot_guidelines/documentation_guidelines.md). |
| `d4rt_interpreter_vs_d4rt_generator.md` | **Not applicable.** It is about choosing between the interpreter and the generator, a question asked from outside this package. |
| `example.md` | **A real gap, not a decision.** `example/` here holds one `README.md` and no runnable example, and an example for this package has a constraint the other two do not: it cannot parse source, so it needs a pre-built `AstBundle`. Nobody has written that, and nothing here says so until now. |

`testing.md` is the one that was most missing: four conventions in this tree
are its own and were folklore until they were written down.

**`F-SCC6-9` in `tom_d4rt_exec` does not walk this folder**, in either
direction. It compares guideline files that are expected to be IDENTICAL
between `tom_d4rt` and `tom_d4rt_exec`, and this tree's `testing.md` is
deliberately not a copy of theirs — it describes a package that cannot run a
script from source, so forcing it into that comparison would require making it
wrong in order to keep the guard green.

## Quick Reference

See project README.md for usage documentation.
