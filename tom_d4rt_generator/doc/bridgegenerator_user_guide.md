# D4rt Bridge Generator User Guide

Generate `BridgedClass` implementations from Dart source files to expose APIs to D4rt scripts.

## Quick Start

```bash
# Add dependencies
dart pub add dev:build_runner dev:tom_d4rt_generator

# Create build.yaml (see Configuration section)

# Generate bridges
dart run build_runner build
```

---

## 1. CLI Usage

```bash
dart run tom_d4rt_generator:d4rt_generator [options]
```

| Option | Short | Description |
|--------|-------|-------------|
| `--project=<path>` | `-p` | Project directory |
| `--config=<path>` | `-c` | Path to `d4rt_bridging.json` |
| `--scan=<path>` | `-s` | Scan directory for configs |
| `--recursive` | `-r` | Recursive scan |
| `--verbose` | `-v` | Verbose output |

```bash
# Examples
dart run tom_d4rt_generator:d4rt_generator                    # Current project
dart run tom_d4rt_generator:d4rt_generator -p /path/to/proj   # Specific project
dart run tom_d4rt_generator:d4rt_generator -s . -r -v         # Recursive scan
```

---

## 2. Configuration

### build.yaml (Recommended)

```yaml
targets:
  $default:
    builders:
      tom_d4rt_generator:d4rt_bridge_builder:
        enabled: true
        options:
          name: my_package
          modules:
            - name: all
              barrelFiles: [lib/my_package.dart]
              outputPath: lib/src/d4rt_bridges/bridges.dart
              excludePatterns: []
              excludeClasses: []
          generateBarrel: true
          barrelPath: lib/d4rt_bridges.dart
          generateDartscript: true
          dartscriptPath: lib/dartscript.dart
          registrationClass: MyPackageBridges
```

### Configuration Options

| Option | Type | Required | Description |
|--------|------|:--------:|-------------|
| `name` | String | ✓ | Package name |
| `modules` | List | ✓ | Module configs (see below) |
| `helpersImport` | String | | D4rt import (default: `package:tom_d4rt/tom_d4rt.dart`) |
| `generateBarrel` | bool | | Generate barrel file (default: `true`) |
| `barrelPath` | String | | Barrel output path |
| `generateDartscript` | bool | | Generate registration file (default: `true`) |
| `dartscriptPath` | String | | Registration file path |
| `registrationClass` | String | | Registration class name |

### Module Options

| Option | Type | Required | Description |
|--------|------|:--------:|-------------|
| `name` | String | ✓ | Module identifier |
| `barrelFiles` | List | ✓ | Source barrel files to analyze |
| `outputPath` | String | ✓ | Output path for generated bridges |
| `excludePatterns` | List | | Glob patterns to exclude files |
| `excludeClasses` | List | | Class names to exclude |

### Exclude Patterns (Glob Syntax)

| Pattern | Matches |
|---------|---------|
| `**/*_bridge.dart` | Any `*_bridge.dart` file |
| `**/generated/**` | Files in `generated/` directories |
| `lib/src/internal/**` | All files under `lib/src/internal/` |

**Auto-excluded:** `**/*_bridges.dart`, `**/d4rt_bridges.dart`

---

## 3. Generated Output

### Bridge File Structure

```dart
// lib/src/d4rt_bridges/bridges.dart
import 'package:tom_d4rt/d4rt.dart';
import 'package:my_package/my_package.dart';

class AllBridge {
  /// All bridged classes
  static List<BridgedClass> bridgeClasses() => [
    _createMyClassBridge(),
    _createAnotherClassBridge(),
  ];
  
  /// All bridged enums
  static List<BridgedEnumDefinition> bridgedEnums() => [
    BridgedEnumDefinition<Status>(name: 'Status', values: Status.values),
  ];
  
  /// Register all bridges with interpreter
  static void registerBridges(D4rt interpreter, String importPath) {
    for (final bridge in bridgeClasses()) {
      interpreter.registerBridgedClass(bridge, importPath);
    }
    for (final enumDef in bridgedEnums()) {
      interpreter.registerBridgedEnum(enumDef, importPath);
    }
  }
}

BridgedClass _createMyClassBridge() {
  return BridgedClass(
    nativeType: MyClass,
    name: 'MyClass',
    constructors: {
      '': (visitor, positional, named) => MyClass(),
      'named': (visitor, positional, named) {
        final arg = D4.getRequiredArg<String>(positional, 0, 'arg', 'MyClass.named');
        return MyClass.named(arg);
      },
    },
    getters: {
      'value': (visitor, target) => D4.validateTarget<MyClass>(target, 'MyClass').value,
    },
    setters: {
      'value': (visitor, target, val) => D4.validateTarget<MyClass>(target, 'MyClass').value = val,
    },
    methods: {
      'doWork': (visitor, target, positional, named) {
        final t = D4.validateTarget<MyClass>(target, 'MyClass');
        final arg = D4.getRequiredArg<String>(positional, 0, 'arg', 'doWork');
        return t.doWork(arg);
      },
      '+': (visitor, target, positional, named) {
        final t = D4.validateTarget<MyClass>(target, 'MyClass');
        final other = D4.getRequiredArg<MyClass>(positional, 0, 'other', 'operator+');
        return t + other;
      },
    },
    staticGetters: { 'instance': (visitor) => MyClass.instance },
    staticMethods: { 'create': (visitor, pos, named) => MyClass.create() },
  );
}
```

### Registration File

```dart
// lib/dartscript.dart
import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/bridges.dart';

class MyPackageBridges {
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt.instance;
    AllBridge.registerBridges(d4rt, 'package:my_package/my_package.dart');
  }
}
```

### What Gets Generated

| Dart Feature | Bridge Support |
|---|---|
| Classes | Full support |
| Enums (simple & enhanced) | Full support |
| Constructors (default & named) | Full support |
| Instance getters/setters | Full support |
| Instance methods | Full support |
| Static members | Full support |
| All operators | Full support (`+`, `-`, `*`, `/`, `[]`, `[]=`, `==`, `&lt;`, `&gt;`, etc.) |
| Private members | Skipped by default |
| Generic type constraints | Limited (may need manual bridge) |
| Complex default values | May fail |

---

## 4. Custom Overrides

### Option A: Exclude & Handwrite

For classes needing full control:

```yaml
# build.yaml
modules:
  - name: all
    excludeClasses: [MyComplexClass]
```

```dart
// lib/src/d4rt_bridges/my_complex_class_bridge.dart
BridgedClass createMyComplexClassBridge() {
  return BridgedClass(
    nativeType: MyComplexClass,
    name: 'MyComplexClass',
    nativeNames: ['_MyComplexClassImpl'],  // Map internal types
    constructors: { '': (v, p, n) => MyComplexClass() },
    methods: { /* ... */ },
  );
}
```

### Option B: UserBridge (Selective Override)

Override individual members while auto-generating the rest:

```dart
// lib/src/d4rt_bridges/user_bridges/my_list_user_bridge.dart
import 'package:tom_d4rt/d4rt.dart';

class MyListUserBridge extends D4UserBridge {
  /// Map internal implementation types
  static List<String> get nativeNames => ['_GrowableList'];
  
  /// Override only operator[]
  static Object? overrideOperatorIndex(
    Object? visitor, Object? target,
    List<Object?> positional, Map<String, Object?> named,
  ) {
    final list = D4.validateTarget<MyList>(target, 'MyList');
    return list[D4.getRequiredArg<int>(positional, 0, 'index', '[]')];
  }
  
  /// Override method with custom logic
  static Object? overrideMethodAdd(
    Object? visitor, Object? target,
    List<Object?> positional, Map<String, Object?> named,
  ) {
    final list = D4.validateTarget<MyList>(target, 'MyList');
    final item = D4.getRequiredArg<Object?>(positional, 0, 'item', 'add');
    list.add(item);
    return null;
  }
}
```

The generator automatically:
1. Detects `MyListUserBridge extends D4UserBridge`
2. Uses overrides for specified members
3. Auto-generates all other members

### Override Naming Convention

| Member Type | Override Method |
|-------------|-----------------|
| Constructor `Foo()` | `overrideConstructor` |
| Constructor `Foo.named()` | `overrideConstructorNamed` |
| Getter `value` | `overrideGetterValue` |
| Setter `value=` | `overrideSetterValue` |
| Method `doWork()` | `overrideMethodDoWork` |
| Static getter | `overrideStaticGetterName` |
| Static setter | `overrideStaticSetterName` |
| Static method | `overrideStaticMethodName` |

### Operator Override Names

| Operator | Override Method |
|----------|-----------------|
| `+` | `overrideOperatorPlus` |
| `-` | `overrideOperatorMinus` |
| `- (unary)` | `overrideOperatorUnaryMinus` |
| `*` | `overrideOperatorMultiply` |
| `/` | `overrideOperatorDivide` |
| `~/` | `overrideOperatorIntegerDivide` |
| `%` | `overrideOperatorModulo` |
| `[]` | `overrideOperatorIndex` |
| `[]=` | `overrideOperatorIndexAssign` |
| `==` | `overrideOperatorEquals` |
| `<` | `overrideOperatorLessThan` |
| `>` | `overrideOperatorGreaterThan` |
| `<=` | `overrideOperatorLessThanOrEqual` |
| `>=` | `overrideOperatorGreaterThanOrEqual` |
| `&` | `overrideOperatorBitwiseAnd` |
| `|` | `overrideOperatorBitwiseOr` |
| `^` | `overrideOperatorBitwiseXor` |
| `~` | `overrideOperatorBitwiseNot` |
| `<<` | `overrideOperatorLeftShift` |
| `>>` | `overrideOperatorRightShift` |
| `>>>` | `overrideOperatorUnsignedRightShift` |

---

## 5. Programmatic API

```dart
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

final generator = BridgeGenerator(
  workspacePath: '/path/to/project',
  packageName: 'my_package',
);

final result = await generator.generateBridgesFromExports(
  barrelFiles: ['lib/my_package.dart'],
  outputPath: 'lib/src/d4rt_bridges/bridges.dart',
  moduleName: 'all',
);

print('Generated: ${result.classesGenerated} classes, ${result.enumsGenerated} enums');
print('Warnings: ${result.warnings}');
```

---

## 6. Troubleshooting

| Issue | Solution |
|-------|----------|
| No exports found | Verify barrel file has `export` statements |
| Class not bridged | Check it's exported and not in `excludeClasses` |
| Build fails | Run `dart analyze` on source files first |
| Operator not working | Ensure operator is defined in source class |
| nativeNames needed | Use UserBridge or handwritten bridge |

**Debug mode:**

```bash
dart run tom_d4rt_generator:d4rt_generator -v
dart run build_runner build --verbose
```

---

## 7. Best Practices

1. **Use barrel files** — Single export point for all public APIs
2. **Use build_runner watch** — Auto-regenerate on changes: `dart run build_runner watch`
3. **Commit generated files** — Version control for reproducibility
4. **Check warnings** — External types may need wrapper classes
5. **Test bridges** — Verify D4rt scripts can use generated bridges
6. **Use UserBridge for fixes** — Override specific members instead of excluding entire classes

---

## See Also

- [UserBridge Override Design](userbridge_override_design.md) — Full UserBridge specification
- [D4rt Bridging Guide](../../_copilot_guidelines/d4rt/BRIDGING_GUIDE.md) — Advanced bridging patterns
