# Tom Analyzer Project Guidelines

**Project:** `tom_analyzer`  
**Type:** CLI Tool

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

## Project-Specific Guidelines

| File | Description |
|------|-------------|
| [implementation_hints.md](implementation_hints.md) | tom_build_base integration and CLI infrastructure |

## Quick Reference

**Purpose:** Dart code analysis tooling

**Key Components:**
- **analyzer** CLI — Code analysis with AST introspection
- **reflector** CLI — Reflection metadata generation
- Integration with Dart analyzer package

**Documentation:**
- [Analyzer Usage Guide](../doc/analyzer_usage_guide.md) — Analyzer CLI reference
- [Reflector Usage Guide](../doc/reflector_usage_guide.md) — Reflector CLI reference
- [README](../README.md) — Quick start guide

## Related Packages

- [tom_build_base](../../tom_build_base/) — Shared CLI infrastructure (navigation, project discovery)
- [tom_analyzer_model](../../tom_analyzer_model/) — Analyzer data models

## Dependencies

This package depends on **tom_build_base** for:
- Workspace navigation options (`-s`, `-r`, `-R`, `-p`, `-x`, etc.)
- Project discovery and scanning
- Configuration loading (TomBuildConfig)
- CLI standardization (help/version commands)

See [implementation_hints.md](implementation_hints.md) for details.
