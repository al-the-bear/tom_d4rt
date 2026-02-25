# Tom DCli Examples

Comprehensive examples demonstrating DCli shell scripting library usage.

## Examples

| File | Description |
|------|-------------|
| [file_operations.dart](file_operations.dart) | copy, move, delete, touch, cat, read, head, tail, replace |
| [directory_operations.dart](directory_operations.dart) | createDir, deleteDir, find, exists, isDirectory, copyTree |
| [process_execution.dart](process_execution.dart) | run, start, toList, firstLine, lastLine, forEach, Progress |
| [environment.dart](environment.dart) | env, envs, HOME, PATH, isOnPATH, withEnvironment |
| [color_output.dart](color_output.dart) | red, green, blue, yellow, cyan, colored output patterns |
| [error_handling.dart](error_handling.dart) | Exception handling patterns for DCli operations |

## Running Examples

From the `dcli/dcli` directory:

```bash
# Run individual examples
dart run example/tomexample/file_operations.dart
dart run example/tomexample/directory_operations.dart
dart run example/tomexample/process_execution.dart
dart run example/tomexample/environment.dart
dart run example/tomexample/color_output.dart
dart run example/tomexample/error_handling.dart
```

## Key Patterns

### File Operations

```dart
import 'package:dcli/dcli.dart';

// Create file
touch('file.txt', create: true);

// Write content
'file.txt'.write('content');
'file.txt'.append('more content');

// Read content
final lines = read('file.txt').toList();
final content = 'file.txt'.read;
cat('file.txt');

// Copy, move, delete
copy('source.txt', 'dest.txt');
move('old.txt', 'new.txt');
delete('file.txt');
```

### Directory Operations

```dart
// Create directories
createDir('mydir');
createDir('a/b/c', recursive: true);

// Find files
find('*.dart', workingDirectory: 'lib', recursive: true)
    .forEach((f) => print(f.path));

// Delete directories
deleteDir('mydir', recursive: true);
```

### Process Execution

```dart
// Simple execution
'echo hello'.run;

// Capture output
final lines = 'ls -la'.toList();
final first = 'cat file.txt'.firstLine;
final last = 'cat file.txt'.lastLine;

// With progress
'command'.start(progress: Progress((line) => print(line)));

// Ignore errors
'command'.start(nothrow: true, progress: Progress.devNull());
```

### Environment

```dart
// Access variables
final home = env['HOME'];
final path = env['PATH'];

// Shortcuts
print(HOME);
print(PATH);

// Check commands
if (isOnPATH('git')) { ... }
```

### Error Handling

```dart
try {
  read('nonexistent.txt').toList();
} on FileNotFoundException catch (e) {
  print('File not found: ${e.message}');
}

try {
  'bad_command'.run;
} on RunException catch (e) {
  print('Command failed: ${e.exitCode}');
}
```

## See Also

- Global DCli overview: `_copilot_guidelines/d4rt/dcli_overview.md`
- Scripting guide: `_copilot_guidelines/d4rt/dcli_scripting_guide.md`
- Tom tests: `test/tomtest/`
