# D4rt Project Guidelines - Index

This folder contains project-specific guidelines for the `tom_d4rt` package.

## Files

| File | Description |
|------|-------------|
| [testing.md](testing.md) | Testing strategy, test IDs, and testkit baseline tracking |
| [example.md](example.md) | Guidelines for creating and maintaining example files |
| [documentation.md](documentation.md) | Documentation standards for this package |
| [build.md](build.md) | Build, test, and publishing guidelines |
| [d4rt_interpreter_vs_d4rt_generator.md](d4rt_interpreter_vs_d4rt_generator.md) | Clarifies which tom_d4rt code is generator support vs interpreter logic |

## Quick Reference

**Package:** `tom_d4rt`  
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

- `tom_d4rt_generator` - Code generator for bridges (see `../tom_d4rt_generator/_copilot_guidelines/`)
- `tom_d4rt_dcli` - DCli integration for D4rt scripting
