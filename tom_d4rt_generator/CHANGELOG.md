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
