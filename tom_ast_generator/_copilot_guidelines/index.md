# Tom D4rt AST Generator Project Guidelines

**Project:** `tom_d4rt_astgen`  
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

**Purpose:** Convert Dart source files to serialized AST YAML files

**Key Components:**
- **astgen** CLI — Command-line AST generation tool
- AST serialization to YAML format
- Integration with D4rt runtime

**Documentation:**
- [AST Build Configuration](../doc/astgen_build_yaml.md) — build.yaml configuration
- [CLI Reference](../doc/tom_build_configuration_and_cli.md) — CLI options and tom_build.yaml
- [README](../README.md) — Quick start guide

## Related Packages

- [tom_build_base](../../tom_build_base/) — Shared CLI infrastructure (navigation, project discovery)
- [tom_d4rt](../../tom_d4rt/) — D4rt interpreter that uses AST files
- [tom_d4rt_generator](../../tom_d4rt_generator/) — Bridge generator

## Dependencies

This package depends on **tom_build_base** for:
- Workspace navigation options (`-s`, `-r`, `-R`, `-p`, `-x`, etc.)
- Project discovery and scanning
- Configuration loading (TomBuildConfig)
- CLI standardization (help/version commands)

See [implementation_hints.md](implementation_hints.md) for details.
