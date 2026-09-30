# Build Guidelines for tom_d4rt_dcli

## Building dcli

The dcli CLI requires code generation before compilation. The build script handles this automatically.

### Quick Build (Recommended)

Run the compile script from the project directory:

```bash
cd tom_ai/d4rt/tom_d4rt_dcli
./compile.sh
```

The script automatically:
1. Gets dependencies (`dart pub get`)
2. Runs `d4rtgen` to regenerate bridges
3. Compiles the executable to `~/.tom/bin/{platform}/dcli`

### Manual Build Steps

If you need to build manually:
1. **Regenerate bridges** with `d4rtgen`, which reads the `d4rtgen:` block of
   `buildkit.yaml` (the generator is a dev dependency for this command):
   ```bash
   cd tom_ai/d4rt/tom_dcli_exec
   dart pub get
   dart run tom_d4rt_generator:d4rtgen -p .
   ```

2. **Check freshness**: `dart test test/bridges_fresh_test.dart` fails when the
   committed `*.b.dart` differ from what the generator writes.

3. **Compile the executable**:
   ```bash
   dart compile exe bin/dclie.dart -o ~/.tom/bin/darwin-arm64/dclie
   ```

### What Gets Generated

Every output is a `*.b.dart` file, formatted as `dart format` would format it:

- `lib/src/bridges/*_bridges.b.dart` - one file per module in `buildkit.yaml`
  (`cli_api`, `dcli`, `path`, `tom_chattools`, `tom_vscode_scripting_api`)
- `lib/src/bridges/relaxers.b.dart` - relaxer wrappers
- `lib/d4rt_bridges.b.dart` - the barrel over the module bridges
- `lib/dartscript.b.dart` - the combined registration class

### Version Management

To dependency on a version generation library dcli uses a simple const version in `lib/tom_d4rt_dcli.dart`:

```dart
const String dcliVersion = '0.1.0';
```

To update the version, manually edit the `dcliVersion` constant.

### Common Issues

- **Missing bridges**: If bridged classes aren't available, run `dart run tom_d4rt_generator:d4rtgen -p .`
- **Compile errors about missing generated files**: Run `d4rtgen` first
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
