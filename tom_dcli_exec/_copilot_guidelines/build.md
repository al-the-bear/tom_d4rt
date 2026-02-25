# Build Guidelines for tom_d4rt_dcli

## Building dcli

The dcli CLI requires code generation before compilation. The build script handles this automatically.

### Quick Build (Recommended)

Run the compile script from the project directory:

```bash
cd xternal/tom_module_d4rt/tom_d4rt_dcli
./compile.sh
```

The script automatically:
1. Gets dependencies (`dart pub get`)
2. Runs build_runner to regenerate bridges
3. Compiles the executable to `~/.tom/bin/{platform}/dcli`

### Manual Build Steps

If you need to build manually:
1. **Delete generated files**: Delete all `*.g.dart` files in the project to ensure a clean build.
   ```bash
   find . -name "*.g.dart" -delete
   ```

2. **Run build_runner** (regenerates bridge code):
   ```bash
   cd xternal/tom_module_d4rt/tom_d4rt_dcli
   dart pub get
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Compile the executable**:
   ```bash
   dart compile exe bin/dclie.dart -o ~/.tom/bin/darwin-arm64/dclie
   ```

### What Gets Generated

- `lib/src/d4rt_library_bridges/package_dcli_bridges.dart` - Bridge code for dcli package
- `lib/src/d4rt_library_bridges/package_dcli_core_bridges.dart` - Bridge code for dcli_core
- `lib/src/d4rt_library_bridges/package_dcli_terminal_bridges.dart` - Bridge code for dcli_terminal
- `lib/src/d4rt_library_bridges/package_crypto_bridges.dart` - Bridge code for crypto

### Version Management

To dependency on a version generation library dcli uses a simple const version in `lib/tom_d4rt_dcli.dart`:

```dart
const String dcliVersion = '0.1.0';
```

To update the version, manually edit the `dcliVersion` constant.

### Common Issues

- **Missing bridges**: If bridged classes aren't available, run build_runner
- **Compile errors about missing generated files**: Run build_runner first
- **Dependency issues**: Run `dart pub get` first

### Architecture-Specific Binaries

| Platform | Binary Location |
|----------|-----------------|
| macOS ARM64 | `~/.tom/bin/darwin-arm64/dcli` |
| macOS x64 | `~/.tom/bin/darwin-x64/dcli` |
| Linux x64 | `~/.tom/bin/linux-x64/dcli` |
| Windows x64 | `~/.tom/bin/win32-x64/dcli.exe` |

### Relationship with d4rt

`tom_d4rt_dcli` provides the base REPL (`D4rtReplBase`) that `tom_dartscript_bridges` extends:

- **dcli** - Base tool with only dcli package bridges
- **d4rt** - Full tool with all Tom Framework bridges + VS Code integration

If you modify `D4rtReplBase` in this package, you'll need to rebuild both `dcli` and `d4rt`.
