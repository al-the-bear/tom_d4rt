````markdown
# D4rt Generator Project Guidelines - Index

This folder contains project-specific guidelines for the `tom_d4rt_generator` package.

## Files

| File | Description |
|------|-------------|
| [example.md](example.md) | Guidelines for creating and maintaining example files |
| [documentation.md](documentation.md) | Documentation standards for this package |
| [build.md](build.md) | Build, test, and publishing guidelines |
| [testing.md](testing.md) | D4rt bridge generator testing: D4rtTester infrastructure, test scripts, user bridge verification, issue tracking |

## Quick Reference

**Package:** `tom_d4rt_generator`  
**Purpose:** Bridge code generator for D4rt interpreter

**Key Components:**
- `BridgeGenerator` - Core generator class that analyzes Dart source and produces BridgedClass implementations
- `d4rt_generator` CLI - Command-line tool for generating bridges
- `d4rt_bridging.json` - Configuration file format for bridge generation

**Documentation:**
- [User Guide](../doc/bridgegenerator_user_guide.md) - Complete usage documentation
- [Configuration Reference](../doc/bridgegenerator_user_reference.md) - build.yaml options
- [UserBridge Override Design](../doc/userbridge_override_design.md) - Override system
- [README](../README.md) - Quick start guide

## Related Packages

- `tom_d4rt` - The interpreter that uses generated bridges (see `../tom_d4rt/_copilot_guidelines/`)
- `tom_d4rt_dcli` - DCli integration for D4rt scripting

## Project Type

This is a **code generator package**, not an interpreter. Key differences from tom_d4rt:
- Output is Dart source code (bridge files)
- Uses analyzer package to parse Dart source
- Configuration-driven via JSON or build.yaml
- Examples demonstrate generated output, not script execution

````
