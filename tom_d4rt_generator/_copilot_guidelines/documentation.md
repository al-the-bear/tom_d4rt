````markdown
# D4rt Generator Documentation Guidelines

This document provides project-specific documentation guidelines for the `tom_d4rt_generator` package.

## Documentation Structure

| File | Location | Purpose |
|------|----------|---------|
| `README.md` | `tom_d4rt_generator/` | Quick start guide, installation, CLI usage |
| `CHANGELOG.md` | `tom_d4rt_generator/` | Version history and changes |
| `bridgegenerator_user_guide.md` | `doc/` | Complete usage documentation |
| `bridgegenerator_user_reference.md` | `doc/` | Configuration reference |
| `userbridge_override_design.md` | `doc/` | UserBridge override system design |

## Key Terminology

Use consistent terminology throughout documentation:

| Term | Description |
|------|-------------|
| Bridge | BridgedClass implementation that exposes native Dart to D4rt |
| Generator | The BridgeGenerator class that produces bridge code |
| Barrel file | Main library export file (e.g., `lib/my_package.dart`) |
| UserBridge | Manual override class extending D4UserBridge |
| Configuration | build.yaml (preferred) or d4rt_bridging.json (fallback) |
| CLI | Command-line interface tool (d4rt_generator) |

## Configuration Approaches

**Preferred:** `build.yaml` - Integrates with standard Dart build tooling
**Fallback:** `d4rt_bridging.json` - Standalone config for projects not using build_runner

### build.yaml (Preferred)

```yaml
targets:
  $default:
    builders:
      tom_d4rt_generator:d4rt_bridge_builder:
        options:
          modules:
            - package: my_package
              barrelFile: lib/my_package.dart
              followAllReExports: true
          generateBarrel: true
          generateDartscript: true
```

### d4rt_bridging.json (Fallback)

```json
{
  "name": "my_package",
  "modules": [
    {
      "name": "all",
      "barrelFiles": ["lib/my_package.dart"],
      "outputPath": "lib/src/d4rt_bridges/my_package_bridges.dart"
    }
  ],
  "generateBarrel": true,
  "generateDartscript": true
}
```

The CLI can use either:
```bash
# Uses build.yaml or d4rt_bridging.json automatically
dart run tom_d4rt_generator:d4rt_generator --project=/path/to/project

# Explicit JSON config
dart run tom_d4rt_generator:d4rt_generator --config=/path/to/config.json
```

## API Documentation Accuracy

**CRITICAL:** Always verify configuration options and CLI flags against source code.

### Common Mistakes to Avoid

1. ❌ **Config file is `d4rt_bridging.json`** - Not `bridges.json` or `config.json`
2. ❌ **CLI is `d4rt_generator`** - Not `generate_bridges` (deprecated)
3. ❌ **Barrel file paths are relative** - To package root, not project root
4. ❌ **UserBridge methods must be static** - Instance methods won't work
5. ❌ **Classes extending D4UserBridge are excluded** - They are helpers, not bridged

### d4rt_bridging.json Schema

```json
{
  "name": "package_name",
  "modules": [
    {
      "name": "module_name",
      "barrelFiles": ["lib/package.dart"],
      "outputPath": "lib/src/d4rt_bridges/package_bridges.dart",
      "barrelImport": "package.dart",
      "excludePatterns": ["_bridge.dart"],
      "excludeClasses": [],
      "excludeEnums": [],
      "excludeFunctions": [],
      "excludeVariables": [],
      "followReExports": []
    }
  ],
  "helpersImport": "package:tom_d4rt/tom_d4rt.dart",
  "generateBarrel": true,
  "barrelPath": "lib/d4rt_bridges.dart",
  "generateDartscript": true,
  "dartscriptPath": "lib/dartscript.dart",
  "registrationClass": "PackageNameBridges"
}
```

## Key Entrypoints

When working with generator code, start here:

| File | Purpose |
|------|---------|
| `lib/tom_d4rt_generator.dart` | Public API exports |
| `lib/src/bridge_generator.dart` | Core BridgeGenerator class |
| `lib/src/config/` | Configuration parsing |
| `bin/d4rt_generator.dart` | CLI entry point |

## Code Examples Rules

**CRITICAL:** All code examples in documentation MUST follow these rules:

1. **Configuration examples MUST be valid JSON/YAML**
   - Verify against the actual schema
   - Include required fields
   - Use realistic values

2. **CLI examples MUST work**
   - Test commands before documenting
   - Include expected output where helpful

3. **Generated code examples**
   - Show realistic bridge output
   - Include comments explaining key parts
   - Reference actual generated files in `example/lib/d4rt_bridges/`

4. **Examples from docs should have corresponding files:**
   - README.md examples → `example/readme/` (if applicable)
   - User guide examples → `example/user_guide/` (if applicable)
   - Reference examples → inline only (configuration snippets)

5. **When adding new documentation examples:**
   - Verify syntax is correct
   - Test any CLI commands
   - For large examples, create actual files in example/

## Generated Code Documentation

When documenting what the generator produces:

1. **Show input (source class) and output (generated bridge)**
2. **Explain member mapping:**
   - Constructors → `constructors` map
   - Methods → `methods` map
   - Getters → `getters` map
   - Setters → `setters` map
   - Operators → `methods` map with operator symbol keys

3. **Reference actual generated files:**
   ```markdown
   See [basic_bridge.dart](../example/lib/d4rt_bridges/basic_bridge.dart) for a generated example.
   ```

## UserBridge Documentation

When documenting UserBridge overrides:

1. **Always show the override method signature exactly**
2. **Emphasize static requirement**
3. **Show corresponding generated code that would call the override**
4. **Reference the override method naming table in userbridge_override_design.md**

````
