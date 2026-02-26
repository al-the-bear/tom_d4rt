# DCli Scripting Guide Examples

This folder contains runnable examples extracted from the [DCli Scripting Guide](../../../_copilot_guidelines/dcli_scripting_guide.md).

**Purpose:** These examples serve as test cases for D4rt/DCli bridge coverage. They should run unmodified in both `dart run` and `dcli`/`d4rt`.

## Prerequisites

Run `dart pub get` in this directory to install dependencies.

## Examples

Located in `bin/dcli_scripting_guide/`:

| File | Description | DCli Features Tested |
|------|-------------|---------------------|
| [01_hello.dart](bin/dcli_scripting_guide/01_hello.dart) | Basic shebang usage | Basic import |
| [02_string_as_process.dart](bin/dcli_scripting_guide/02_string_as_process.dart) | StringAsProcess extension | `.run`, `.toList()`, `.firstLine`, `.forEach()` |
| [03_colors.dart](bin/dcli_scripting_guide/03_colors.dart) | Color output functions | `red()`, `green()`, `yellow()`, `blue()`, etc. |
| [04_file_write.dart](bin/dcli_scripting_guide/04_file_write.dart) | File write/append | `String.write()`, `String.append()` |
| [05_progress_capture.dart](bin/dcli_scripting_guide/05_progress_capture.dart) | Progress class | `Progress.print()`, `progress.lines`, `Progress.devNull()` |
| [06_env_access.dart](bin/dcli_scripting_guide/06_env_access.dart) | Environment variables | `env[]`, `pwd`, `HOME`, `PATH` |
| [07_basic_file_ops.dart](bin/dcli_scripting_guide/07_basic_file_ops.dart) | File operations | `join()`, `createDir()`, `copy()`, `find().forEach()` |
| [08_command_execution.dart](bin/dcli_scripting_guide/08_command_execution.dart) | Command execution | `.run`, `.forEach()`, `RunException`, `nothrow` |
| [10_temp_files.dart](bin/dcli_scripting_guide/10_temp_files.dart) | Temporary files | `withTempDir()`, `join()` |
| [11_find_details.dart](bin/dcli_scripting_guide/11_find_details.dart) | Find function | `find().forEach()`, type filters |
| [12_error_handling.dart](bin/dcli_scripting_guide/12_error_handling.dart) | Error handling | `CopyException`, `RunException`, `nothrow` |
| [13_cross_platform.dart](bin/dcli_scripting_guide/13_cross_platform.dart) | Cross-platform | `truepath()`, `join()`, `which()`, `eol` |
| [14_shell_execution.dart](bin/dcli_scripting_guide/14_shell_execution.dart) | Shell execution | `runInShell: true` |

**Note:** 09_interactive_input.dart is excluded - requires terminal interaction and cannot be automated.

## Running Examples

```bash
# With dart run (JIT compiled)
dart run bin/dcli_scripting_guide/01_hello.dart

# With dcli
dcli bin/dcli_scripting_guide/01_hello.dart

# With d4rt
d4rt bin/dcli_scripting_guide/01_hello.dart
```

## Known Issues (To Be Fixed)

When running via `dcli` or `d4rt`, the following features may not work until bridges are updated:

- **StringAsProcess extension:** `.run`, `.toList()`, `.forEach()` on String
- **File write extensions:** `String.write()`, `String.append()`
- **path package functions:** `join()` (DCli re-export)
- **Progress.lines:** Accessing `.lines` on Progress return value
- **FindProgress iteration:** `.forEach()` on find results
- **Exception handling:** DCli exceptions in try/catch blocks

## Notes

- Examples create temporary files in `/tmp/` which are cleaned up
- DCli version 8.4.2 or later required
