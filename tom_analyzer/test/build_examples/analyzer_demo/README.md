# Analyzer Demo

A self-contained test project demonstrating tom_analyzer working with build_runner.

## What it Contains

- `lib/sample_code.dart` - Sample Dart code with various constructs:
  - 2 enums (Weekday, Priority)
  - 2 mixins (Validatable, Serializable)
  - 2 abstract classes (Entity, Repository)
  - 4 concrete classes (User, Task, Result)
  - 2 extensions (StringExtensions, ListExtensions)
  - 4 top-level functions
  - 3 type aliases

- `bin/verify.dart` - Verification script that parses the generated YAML and prints statistics

## Usage

1. Install dependencies:
   ```bash
   dart pub get
   ```

2. Run the analyzer:
   ```bash
   dart run build_runner build
   ```

3. Verify the output:
   ```bash
   dart run bin/verify.dart
   ```

## Expected Output

The verification script should show:
- Analysis metadata (timestamp, version)
- Package and library counts
- Type definition counts (classes, enums, mixins, etc.)
- Member counts (methods, fields, constructors, etc.)
- Reflection file statistics

## Notes

- The **analysis output** (`sample_code.analysis.yaml`) is the primary output and works correctly
- The **reflection output** (`sample_code.r.dart`) may have compilation issues for advanced edge cases (abstract classes, read-only properties, generics) - these are known limitations of the reflection generator
