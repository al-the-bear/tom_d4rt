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

## Code Examples in Documentation

### Inline vs Referenced

For short examples (< 20 lines), include inline:
```markdown
```dart
final d4rt = D4rt();
d4rt.execute(source: 'void main() => print("Hello");');
```​
```

For longer examples, reference the example file:
```markdown
See [basic_execution_example.dart](../example/basic_execution_example.dart) for a complete example.
```

### Script Examples in Documentation

When showing D4rt scripts (code that runs inside D4rt), use proper escaping:
- `\$` for string interpolation in script source strings
- `'''` for multi-line scripts

## README.md Requirements

The README should include:

1. **Package description** - What D4rt is
2. **Features list** - Key capabilities
3. **Installation** - pubspec.yaml snippet
4. **Quick Start** - Minimal working example
5. **Basic Usage** - Common patterns
6. **Documentation links** - To guides
7. **License** - MIT

## CHANGELOG.md Format

Follow Keep a Changelog format:

```markdown
## [1.5.0] - 2024-01-XX

### Added
- New feature description

### Changed
- Changed behavior description

### Fixed
- Bug fix description

### Deprecated
- Deprecated feature notice
```

## Cross-References

When referencing related documentation:
- Use relative paths: `[Bridging Guide](BRIDGING_GUIDE.md)`
- Use descriptive link text: Not "click here"
- Verify links work before committing

## Updating Documentation

When making code changes:

1. Update relevant documentation sections
2. Update CHANGELOG.md
3. Verify all code examples still work
4. Run examples to confirm accuracy
