# D4rt Bridge Generator Configuration Reference

This reference details the `build.yaml` configuration options for `tom_d4rt_generator`.

## Builder Configuration

Configure the builder under `tom_d4rt_generator:d4rt_bridge_builder` in your `build.yaml`.

```yaml
targets:
  $default:
    builders:
      tom_d4rt_generator:d4rt_bridge_builder:
        options:
          # Global options
          generateBarrel: true
          generateDartscript: true
          helpersImport: "package:my_app/helpers.dart"
          importedBridges: ["OtherBridge"]
          
          # Module definitions
          modules:
            - package: example_package
              barrelFile: lib/example.dart
              followAllReExports: true
              skipReExports: ["flutter", "sky_engine"]
              excludeSourcePatterns: ["src/internal/**"]
```

## Option Details

### `modules` (Required)
A list of module objects defining which packages to bridge. 
*   **Type**: `List<Map>`

#### Module Properties:
*   **`package`** (`String`): The package name to scan. must match `pubspec.yaml`.
*   **`barrelFile`** (`String`): Path to the library file (relative to package root) that exports the API surface. Usually `lib/<package_name>.dart`.
*   **`followAllReExports`** (`bool`, default: `false`): If true, recursively analyzes all `export '...'` directives. Important for packages that expose their API through multiple sub-libraries re-exported by the main file.
*   **`skipReExports`** (`List<String>`): Package names to ignore when following re-exports. Useful to prevent analyzing huge dependencies (like Flutter) if you only want to bridge your own code.
*   **`excludeSourcePatterns`** (`List<String>`): Glob patterns to exclude specific files/folders from analysis within the package.

### `generateBarrel` (Optional)
If true, generates a single file (usually `lib/generated_bridges.dart` or similar based on build configuration) that exports all individual bridge files.
*   **Type**: `bool`
*   **Default**: `false`

### `generateDartscript` (Optional)
Generates a `generated_bridges.dart` file containing a static helper to register all generated bridges.
*   **Type**: `bool`
*   **Default**: `false`
*   **Usage**:
    ```dart
    import 'generated_bridges.dart';
    GeneratedBridges.register(d4rt);
    ```

### `helpersImport` (Optional)
A custom import string to add to every generated bridge file. Use this if you have custom type converters or helper functions that the generated code relies on (e.g., custom `d4rt` type extensions).
*   **Type**: `String`
*   **Default**: `null`

### `importedBridges` (Optional)
A list of class names of bridges generated in dependent packages.
*   **Type**: `List<String>`
*   **Purpose**:
    When Package B depends on Package A, and both use `tom_d4rt_generator`, the generator for B needs to know about types bridged in A.
    Adding `"PackageABridge"` to this list allows Package B's bridges to refer to types from A solely by their bridged name, preventing type duplication errors in the interpreter.

---

## Generated File Structure

The generator produces the following files in `lib/generated/`:

1.  **`{package}_bridge.dart`**: The main bridge class for a package module.
    *   Contains `class {Package}Bridge extends Bridge { ... }`
2.  **`{package}_library.dart`**: Defines the library structure for the interpreter.
3.  **`generated_bridges.dart`** (if enabled): Registration helper.

## User Bridges (Manual Overrides)

To customize a specific class bridge:
1.  Create a file named `lib/generated/bridges/{class_name}_user_bridge.dart` (or similar, check generated output for expected path).
2.  Implement the class extending the generated bridge or `BridgedClass`.
3.  The generator uses the "UserBridge" naming convention to detect if it should yield to a manual implementation.
*(See `userbridge_override_design.md` for architectural details)*
