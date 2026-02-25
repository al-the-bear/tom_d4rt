# Running d4rtgen

This document explains how to run the `d4rtgen` command-line tool, especially when using compiled binaries.

## Prerequisites

The `d4rtgen` tool uses the Dart analyzer to parse source files. The analyzer requires access to the Dart SDK to resolve `dart:` libraries (`dart:core`, `dart:async`, etc.).

## SDK Path Detection

When running `d4rtgen`, the SDK path is resolved in this order:

1. **`DART_SDK` environment variable** (recommended for compiled binaries)
2. **Derive from `dart` executable in PATH**
3. **Analyzer default** (uses `Platform.resolvedExecutable` — fails for compiled binaries)

## The Problem with Compiled Binaries

When `d4rtgen` is compiled to a native binary (e.g., at `~/.tom/bin/darwin-arm64/d4rtgen`), the Dart analyzer's default SDK detection fails. It uses:

```dart
dart:io Platform.resolvedExecutable  // Returns ~/.tom/bin/darwin-arm64/d4rtgen
```

The analyzer then derives the SDK path as `dirname(dirname(executable))` = `~/.tom/bin/`, which is not a valid SDK.

This causes errors like:
```
PathNotFoundException(path=/Users/.../.tom/bin/lib/_internal/sdk_library_metadata/lib/libraries.dart; message=Cannot open file)
```

## Solution: Set DART_SDK

Set the `DART_SDK` environment variable to your Dart SDK path:

### Find your Dart SDK path

```bash
# If using standalone Dart:
which dart
# Output: /path/to/dart-sdk/bin/dart
# SDK path: /path/to/dart-sdk

# If using Flutter (Dart is embedded):
which dart
# Output: /path/to/flutter/bin/dart
# SDK path: /path/to/flutter/bin/cache/dart-sdk
```

### Set DART_SDK

**Temporary (current session):**
```bash
export DART_SDK=/path/to/dart-sdk
d4rtgen
```

**Permanent (add to shell profile):**

For zsh (`~/.zshrc`):
```bash
export DART_SDK=/path/to/flutter/bin/cache/dart-sdk
```

For bash (`~/.bashrc` or `~/.bash_profile`):
```bash
export DART_SDK=/path/to/flutter/bin/cache/dart-sdk
```

### Example with Flutter installation

```bash
# macOS with Flutter
export DART_SDK=$HOME/development/flutter/bin/cache/dart-sdk

# Verify
ls $DART_SDK/lib/_internal
# Should show: sdk_library_metadata, dart2js_platform.dill, etc.
```

## Running from Source (No Issue)

When running `d4rtgen` via `dart run` from the source package, the SDK detection works correctly because `Platform.resolvedExecutable` returns the actual Dart executable path:

```bash
cd tom_d4rt_generator
dart run bin/d4rtgen.dart
```

## Troubleshooting

### Error: `PathNotFoundException` for SDK libraries

**Cause:** `DART_SDK` not set and binary is in a non-SDK location.

**Fix:** Set `DART_SDK` environment variable.

### Error: `Cannot find dart` 

**Cause:** `dart` not in PATH and `DART_SDK` not set.

**Fix:** Either:
1. Add `dart` to PATH, or
2. Set `DART_SDK` explicitly

### Verify SDK path

```bash
# Check if DART_SDK is set
echo $DART_SDK

# Verify it's a valid SDK
ls $DART_SDK/lib/_internal/sdk_library_metadata/lib/libraries.dart
```

## VS Code Integration

If using VS Code with the Dart extension, you can find the SDK path in VS Code settings:

- **Setting key:** `dart.sdkPath` or `dart.flutterSdkPath`
- **Location:** Settings > Extensions > Dart & Flutter

The VS Code Dart extension typically auto-detects the SDK, but `d4rtgen` runs outside VS Code and needs explicit configuration.
