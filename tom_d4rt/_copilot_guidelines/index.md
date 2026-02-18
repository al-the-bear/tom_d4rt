# D4rt Project Guidelines

**Project:** `tom_d4rt`  
**Type:** Dart Package

## Global Guidelines

| Document | Purpose |
|----------|---------|
| [Documentation Guidelines](/_copilot_guidelines/documentation_guidelines.md) | Where to place user docs vs development docs |

## Dart Guidelines

| Document | Purpose |
|----------|---------|
| [Coding Guidelines](/_copilot_guidelines/dart/coding_guidelines.md) | Naming conventions, error handling, patterns |
| [Unit Tests](/_copilot_guidelines/dart/unit_tests.md) | Test structure, matchers, mocking patterns |
| [Examples](/_copilot_guidelines/dart/examples.md) | Example file creation guidelines |

## Publishing

This package is published to pub.dev. See [Project Republishing](/_copilot_guidelines/dart/project_republishing.md) for the complete publishing workflow.

## Project-Specific Guidelines

| File | Description |
|------|-------------|
| [testing.md](testing.md) | Testing strategy, test IDs, and testkit baseline tracking |
| [example.md](example.md) | Guidelines for creating and maintaining example files |
| [documentation.md](documentation.md) | Documentation standards for this package |
| [build.md](build.md) | Build, test, and publishing guidelines |
| [d4rt_interpreter_vs_d4rt_generator.md](d4rt_interpreter_vs_d4rt_generator.md) | Clarifies which tom_d4rt code is generator support vs interpreter logic |

## Quick Reference

**Purpose:** Sandboxed Dart interpreter for runtime script execution

**Key Classes:**
- `D4rt` - Main interpreter class
- `BridgedClass` - Bridge definition for native classes
- `BridgedEnumDefinition` - Bridge definition for native enums

**Documentation:**
- [User Guide](../doc/d4rt_user_guide.md) - Complete usage documentation
- [Bridging Guide](../doc/BRIDGING_GUIDE.md) - Manual bridging documentation
- [README](../README.md) - Quick start guide

## Related Packages

- `tom_d4rt_exec` — Migration target: analyzer-free D4rt interpreter (copy of tom_d4rt being transformed to use mirror AST)
- `tom_d4rt_generator` - Code generator for bridges (see `../tom_d4rt_generator/_copilot_guidelines/`)
- `tom_d4rt_dcli` - DCli integration for D4rt scripting
- `tom_d4rt_ast` - 1:1 mirror of the analyzer AST (zero deps, serializable)
- `tom_d4rt_astgen` - 1:1 copier: analyzer AST → mirror AST
