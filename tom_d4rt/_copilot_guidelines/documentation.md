# D4rt Documentation Guidelines

This document provides project-specific documentation guidelines for the `tom_d4rt` package.

## Documentation Structure

| File | Location | Purpose |
|------|----------|---------|
| `README.md` | `tom_d4rt/` | Quick start guide, installation, features |
| `CHANGELOG.md` | `tom_d4rt/` | Version history and changes |
| `d4rt_user_guide.md` | `doc/` | Complete usage documentation |
| `BRIDGING_GUIDE.md` | `doc/` | Manual bridging documentation |

## Key Terminology

Use consistent terminology throughout documentation:

| Term | Description |
|------|-------------|
| D4rt | The interpreter (class name is `D4rt`) |
| Script | User-provided Dart code to execute |
| Bridge | Connection between native Dart and interpreted code |
| Native | Host Dart code (not interpreted) |
| Interpreted | Code running inside D4rt |
| Sandbox | Security isolation for scripts |

## API Documentation Accuracy

**CRITICAL:** Always verify API signatures against source code before documenting.

### Common Mistakes to Avoid

1. ❌ **No `init()` method** - D4rt is initialized by calling `execute()`
2. ❌ **No `TomD4rt` class** - The class is named `D4rt`
3. ❌ **Cannot use `eval()` before `execute()`** - Must establish context first
4. ❌ **Function name is configurable** - Not always `main()`
5. ❌ **No `NetworkPermission.connect()`** - Use `NetworkPermission.connectTo(host)`

### execute() Method Parameters

```dart
d4rt.execute(
  source: String?,           // Inline script source
  name: String = 'main',     // Function to call
  positionalArgs: List?,     // Positional arguments
  namedArgs: Map?,           // Named arguments
  library: String?,          // Main library URI (for multi-file)
  sources: Map?,             // Map of library URIs to source code
  basePath: String?,         // Base path for filesystem imports
  allowFileSystemImports: bool?,  // Enable relative imports
);
```

## Key Entrypoints

When working with D4rt code, start here:

| File | Purpose |
|------|---------|
| `lib/d4rt.dart` | Public API exports |
| `lib/src/d4rt.dart` | Main `D4rt` class implementation |
| `lib/src/bridge/bridged_class.dart` | Bridge definition classes |
| `lib/src/permissions/` | Permission system |

## Code Examples Rules

**CRITICAL:** All code examples in documentation MUST follow these rules:

1. **Examples MUST exist as runnable files** in `example/<document-name>/`:
   - README.md examples → `example/readme/`
   - d4rt_user_guide.md examples → `example/user_guide/`
   - BRIDGING_GUIDE.md examples → `example/bridging_guide/`

2. **Inline examples in docs** must be short (< 20 lines). For longer examples, reference the file:
   ```markdown
   See [basic_execution_example.dart](../example/user_guide/basic_execution_example.dart) for a complete example.
   ```

3. **All examples MUST be included in `run_all_examples.dart`** and verified to run:
   ```bash
   dart run example/run_all_examples.dart
   ```

4. **Script source escaping** - Use proper escaping for D4rt script strings:
   - `\$` for string interpolation
   - `'''` for multi-line scripts

5. **When adding new examples:**
   - Add to appropriate subfolder
   - Add import and run call to `run_all_examples.dart`
   - Verify all examples still run
