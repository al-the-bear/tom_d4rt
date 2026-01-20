# Native Binary - Known Limitation

## Important Notice

The compiled native binary in this directory **cannot be used standalone** due to a limitation with the Dart `analyzer` package.

### The Problem

The d4rt_generator uses the `analyzer` package to parse Dart source code. The analyzer package requires access to the Dart SDK's internal library metadata files at runtime. When compiled to a native binary, the analyzer looks for these files relative to the binary's location, not the system-installed Dart SDK.

### Recommended Usage

**Use the Dart script directly:**

```bash
# From workspace root
dart run tom_d4rt_generator:d4rt_generator [options]

# Or from tom_d4rt_generator directory  
dart run bin/d4rt_generator.dart [options]
```

This is the **official and supported** way to run the tool.

### Why Keep the Binary?

The binary and shell script are included for reference and potential future use if the analyzer package limitation is resolved. Currently, they serve as documentation of the limitation.

### Alternative Approaches

If you need a standalone executable, consider:

1. **Wrapper script that invokes dart run** (recommended for CI/CD):
   ```bash
   #!/bin/bash
   dart run tom_d4rt_generator:d4rt_generator "$@"
   ```

2. **Docker container** with Dart SDK installed

3. **Use a different approach** that doesn't rely on the analyzer package (significant rewrite)

### Technical Details

The analyzer package tries to load files from:
- `<executable-directory>/lib/_internal/sdk_library_metadata/lib/libraries.dart`
- `<executable-directory>/lib/_internal/libraries.dart`

These paths are relative to the binary location and cannot be redirected to the system Dart SDK, even with the `DART_SDK` environment variable set.

This is a known limitation of the analyzer package when used in compiled Dart applications.
