# DCli Scripting Guide Examples

This folder contains runnable examples extracted from the [DCli Scripting Guide](../../../_copilot_guidelines/dcli_scripting_guide.md).

**Purpose:** These examples serve as test cases for D4rt/DCli bridge coverage. They should run unmodified in both `dart run` and `dcli`/`d4rt`.

## Prerequisites

Run `dart pub get` in this directory to install dependencies.

## Examples

| File | Description | DCli Features Tested |
|------|-------------|---------------------|
| [01_hello.dart](01_hello.dart) | Basic shebang usage | Basic import |
| [02_string_as_process.dart](02_string_as_process.dart) | StringAsProcess extension | `.run`, `.toList()`, `.firstLine`, `.forEach()` |
| [03_colors.dart](03_colors.dart) | Color output functions | `red()`, `green()`, `yellow()`, `blue()`, etc. |
| [04_file_write.dart](04_file_write.dart) | File write/append | `String.write()`, `String.append()` |
| [05_progress_capture.dart](05_progress_capture.dart) | Progress class | `Progress.print()`, `progress.lines`, `Progress.devNull()` |
| [06_env_access.dart](06_env_access.dart) | Environment variables | `env[]`, `pwd`, `HOME`, `PATH` |
| [07_basic_file_ops.dart](07_basic_file_ops.dart) | File operations | `join()`, `createDir()`, `copy()`, `find().forEach()` |
| [08_command_execution.dart](08_command_execution.dart) | Command execution | `.run`, `.forEach()`, `RunException`, `nothrow` |
| [09_interactive_input.dart](09_interactive_input.dart) | User input *(terminal)* | `ask()`, `confirm()`, `menu()` |
| [10_temp_files.dart](10_temp_files.dart) | Temporary files | `withTempDir()`, `join()` |
| [11_find_details.dart](11_find_details.dart) | Find function | `find().forEach()`, type filters |
| [12_error_handling.dart](12_error_handling.dart) | Error handling | `CopyException`, `RunException`, `nothrow` |
| [13_cross_platform.dart](13_cross_platform.dart) | Cross-platform | `truepath()`, `join()`, `which()`, `eol` |
| [14_shell_execution.dart](14_shell_execution.dart) | Shell execution | `runInShell: true` |

## Running Examples

```bash
# With dart run (JIT compiled)
dart run 01_hello.dart

# With dcli
dcli 01_hello.dart

# With d4rt
d4rt 01_hello.dart
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

- Example 09 requires a terminal for interactive input
- Examples create temporary files in `/tmp/` which are cleaned up
- DCli version 8.4.2 or later required
