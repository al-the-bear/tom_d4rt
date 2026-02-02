# D4rt Bridge Generator User Guide

The `tom_d4rt_generator` automates the creation of "Bridges" – metadata classes that allow the `tom_d4rt` interpreter to interact with compiled Dart code at runtime. By generating these bridges, you expose native Dart libraries (like `dart:io`, `tom_core`, or your own packages) to scripts running safely inside the interpreter.

## Quick Start

1.  **Add Dependencies**:
    ```bash
    dart pub add tom_d4rt
    dart pub add --dev build_runner tom_d4rt_generator
    ```

2.  **Configure `build.yaml`**:
    Create or update `build.yaml` in your project root to tell the generator which specific libraries to bridge.

    ```yaml
    targets:
      $default:
        builders:
          tom_d4rt_generator:d4rt_bridge_builder:
            options:
              # (Optional) generate a convenience barrel file
              generateBarrel: true 
              # (Optional) generate a generated_bridges.dart for easier registration
              generateDartscript: true
              
              # List the libraries/packages you want to bridge
              modules:
                - package: my_package
                  # entry point to analyze (usually the main library file)
                  barrelFile: lib/my_package.dart
                  # (Optional) Follow all exports recursively to find classes
                  followAllReExports: true
                  # (Optional) Exclude internal classes/files
                  excludeSourcePatterns:
                    - "internal/**"
    ```

3.  **Run Builder**:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Register Bridges**:
    Use the generated bridges in your application setup.

    ```dart
    // lib/generated_bridges.dart (if generateDartscript: true)
    import 'package:tom_d4rt/tom_d4rt.dart';
    import 'generated/my_package_bridge.dart'; 

    void registerMyBridges(TomD4rt d4rt) {
      d4rt.registerBridge(MyPackageBridge());
    }
    ```

---

## Configuration Reference (`build.yaml`)

The builder is configured via the `options` map in `build.yaml`.

### General Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `generateBarrel` | `bool` | `false` | Generates a single `.dart` file exporting all generated bridges. |
| `generateDartscript` | `bool` | `false` | Generates a `generated_bridges.dart` file with a helper class/function to register all bridges at once. |
| `helpersImport` | `string` | `null` | Custom import string to include in generated files (e.g., for custom type helpers). |
| `importedBridges` | `List<String>` | `[]` | List of bridge class names from *other* packages that this bridge depends on. Essential for chaining bridges across package boundaries. |

### Module Options (`modules` list)

Each item in the `modules` list defines a package or library to analyze and bridge.

| Key | Type | Description |
|-----|------|-------------|
| `package` | `String` | **Required.** The name of the package containing the code to bridge (can be the current package or a dependency). |
| `barrelFile` | `String` | **Required.** Path to the main library file that exports the symbols you want to bridge (e.g., `lib/tom_core.dart`). |
| `followAllReExports` | `bool` | If `true`, the generator recursively analyzes all `export` directives to find classes. Essential for large libraries. |
| `excludeSourcePatterns` | `List<String>`| Glob patterns of file paths to exclude from analysis (e.g., `src/internal/**`). |
| `skipReExports` | `List<String>` | List of specific package names to *not* follow when analyzing exports. |

---

## Best Practices

### 1. Bridging External Packages
You can generate bridges for third-party packages (like `file` or `path`) by adding them to the `modules` list in *your* project's `build.yaml`. You don't need to modify the third-party package itself.

### 2. Handling Dependencies (`importedBridges`)
If your package's classes inherit from or use types bridged in another package (e.g., `tom_d4rt_dcli` depends on `tom_d4rt`), you must list the upstream bridge class in `importedBridges`.

```yaml
options:
  importedBridges:
    - "TomD4rtBridge" # From package:tom_d4rt
```
This ensures the generator knows about types defined elsewhere and doesn't generate duplicate or conflicting type definitions.

### 3. Using `generateDartscript`
Setting `generateDartscript: true` is highly recommended for applications. It creates a `YourPackageBridges` class with a static `register` method, simplifying the setup code:

```dart
// Register everything in one line
YourPackageBridges.register(d4rtInstance);
```

### 4. Overriding Generated Bridges
For complex cases where automated generation isn't enough (e.g., unsupported types, complex simplified logic), you can provide **User Bridges**.
Create a class that extends the generated bridge or `BridgedClass` manually, and register it *instead* of or *after* code generation. The generator respects manual "UserBridge" files if placed in specific locations (see *User Bridge Design*).

## Troubleshooting

*   **Missing Types**: If a class isn't showing up, ensure it is exported by the `barrelFile` and that `followAllReExports` is true if it's nested deep in exports.
*   **Build Conflicts**: Always use `--delete-conflicting-outputs` when running build_runner to clean up stale generated files.
*   **Type Mismatches**: If D4rt complains about type mismatches for bridged classes, ensure you are using `importedBridges` correctly so that all modules share the same bridge definitions for common types.
