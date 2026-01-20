## 1.1.2

### Changes
- **Repository reorganization**: Moved to tom_module_d4rt repository as part of modular workspace structure
- Updated repository URL to https://github.com/al-the-bear/tom_module_d4rt
- Package now published to pub.dev (removed `publish_to: none`)
- **followReExports feature**: Bridge generator can now follow re-exports from external packages

## 1.1.1

### Fixes
- **Operator argument typing**: Operator bridges now use `D4.getRequiredArg<T>()` for properly typed argument extraction
- This ensures type-safe operator implementations (e.g., `operator+` extracts `other` as the correct type)
- Affected operators: `[]`, `[]=`, and all binary operators (`+`, `-`, `*`, `/`, `%`, `&`, `|`, `^`, `<<`, `>>`, `>>>`, `<`, `>`, `<=`, `>=`, `==`)

## 1.1.0

### Features
- **Operator bridging**: Full support for all Dart operators (+, -, *, /, [], []=, ==, <, >, etc.)
- **UserBridge override system**: Selective method overrides via `*UserBridge` companion classes extending `D4UserBridge`
- Override individual constructors, getters, setters, methods, and operators while generating the rest

### Documentation
- Added comprehensive operator override reference
- Added UserBridge override design documentation

## 1.0.1

- Fix: BuildRunnerFileWriter now writes directly to filesystem for `build_to: source` compatibility
- This fixes `UnexpectedOutputException` when using build_runner integration

## 1.0.0

- Initial version.
