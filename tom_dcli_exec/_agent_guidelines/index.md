# Tom D4rt DCli Project Guidelines

**Project:** `tom_d4rt_dcli`  
**Type:** CLI Tool

## Global Guidelines

| Document | Purpose |
|----------|---------|
| [Documentation Guidelines](../../../../../../../../_agent_guidelines/documentation_guidelines.md) | Where to place user docs vs development docs |

## Dart Guidelines

| Document | Purpose |
|----------|---------|
| [Coding Guidelines](../../../../_agent_guidelines/dart/coding_guidelines.md) | Naming conventions, error handling, patterns |
| [Unit Tests](../../../../_agent_guidelines/dart/unit_tests.md) | Test structure, matchers, mocking patterns |
| [Examples](../../../../_agent_guidelines/dart/examples.md) | Example file creation guidelines |

## Publishing

This package is published to pub.dev. See [Project Republishing](../../../../_agent_guidelines/dart/project_republishing.md) for the complete publishing workflow.

## Project-Specific Guidelines

| File | Description |
|------|-------------|
| [testing.md](testing.md) | Testing strategy and testkit baseline tracking |
| [build.md](build.md) | Build, test, and publishing guidelines |

## Quick Reference

**Purpose:** DCli integration for D4rt interpreter

**Key Components:**
- `dcli` command — Interactive D4rt shell
- Script execution and REPL
- Command-line utilities

**Documentation:**
- [README](../README.md) — Quick start guide

## Related Packages

- [tom_d4rt](../../tom_d4rt/) — Core D4rt interpreter
- [tom_d4rt_generator](../../tom_d4rt_generator/) — Bridge code generator
