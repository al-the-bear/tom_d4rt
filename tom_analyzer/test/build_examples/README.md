# Build Examples

These test projects demonstrate how to use the `tom_analyzer` package with
the standalone CLI tools for code analysis and reflection generation.

## Projects

| Project | Tool | Target | Description |
|---------|------|--------|-------------|
| `analyze_analyzer` | Analyzer | analyzer | Analyzes the analyzer package itself |
| `analyze_dart_overview` | Analyzer | dart_overview | Analyzes the dart_overview fixture |
| `analyze_tom_core_kernel` | Analyzer | tom_core_kernel | Analyzes tom_core_kernel |
| `analyze_tom_core_server` | Analyzer | tom_core_server | Analyzes tom_core_server |
| `analyzer_demo` | Both | sample_code | Demonstrates both analysis and reflection |
| `reflect_analyzer` | Reflector | analyzer | Generates reflection for analyzer |
| `reflect_dart_overview` | Reflector | dart_overview | Generates reflection for dart_overview |
| `reflect_tom_core_kernel` | Reflector | tom_core_kernel | Generates reflection for tom_core_kernel |
| `reflect_tom_core_server` | Reflector | tom_core_server | Generates reflection for tom_core_server |

## Running Build Examples

Each project uses standalone CLI tools via buildkit configuration:

```bash
cd <project>
dart pub get

# For analysis projects:
dart run tom_analyzer --config buildkit.yaml

# For reflection projects:
dart run tom_analyzer:tom_reflector --config buildkit.yaml
```

## Configuration Files

Each project contains:

- `pubspec.yaml` - Package configuration with tom_analyzer dependency
- `buildkit.yaml` - Standalone tool configuration (tom_analyzer/tom_reflector sections)
- `lib/` - Target source files or imports
