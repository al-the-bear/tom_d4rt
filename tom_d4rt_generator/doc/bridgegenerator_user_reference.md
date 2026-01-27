# D4rt Bridge Generator User Reference

Quick reference for D4rt bridge generation tool.

---

## 1. Overview

The D4rt Bridge Generator analyzes Dart source files and automatically generates `BridgedClass` implementations that make Dart APIs accessible to D4rt scripts.

**Key Features:**
- Generates bridges from barrel file exports
- Supports build_runner integration
- Configurable via `build.yaml` or JSON config
- Glob pattern support for excluding files

---

## 2. Command Line Usage

```bash
dart run tom_d4rt_generator:d4rt_generator [options]
```

### Options

| Option | Short | Description |
|--------|-------|-------------|
| `--project=<path>` | `-p` | Path to project directory |
| `--config=<path>` | `-c` | Path to specific `d4rt_bridging.json` file |
| `--scan=<path>` | `-s` | Scan directory for all config files |
| `--recursive` | `-r` | Recursively scan for config files |
| `--verbose` | `-v` | Enable verbose output |
| `--help` | `-h` | Show usage help |

### Examples

```bash
# Generate for current project (uses build.yaml or d4rt_bridging.json)
dart run tom_d4rt_generator:d4rt_generator

# Generate for a specific project
dart run tom_d4rt_generator:d4rt_generator --project=/path/to/project

# Use a specific JSON config file
dart run tom_d4rt_generator:d4rt_generator --config=/path/to/d4rt_bridging.json

# Scan workspace recursively
dart run tom_d4rt_generator:d4rt_generator --scan=/path/to/workspace --recursive

# Verbose output
dart run tom_d4rt_generator:d4rt_generator -v
```

---

## 3. build_runner Integration

The preferred method is via build_runner for automatic regeneration on file changes.

### 3.1 Setup

Add to `pubspec.yaml`:

```yaml
dev_dependencies:
  build_runner: ^2.4.0
  tom_d4rt_generator:
    path: ../tom_d4rt_generator  # or version
```

### 3.2 Configuration (build.yaml)

Create `build.yaml` in your project root:

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
              barrelFiles:
                - lib/my_package.dart
              outputPath: lib/src/d4rt_bridges/my_package_bridges.dart
              barrelImport: my_package.dart
              excludePatterns: []
              excludeClasses: []
          helpersImport: package:tom_d4rt/tom_d4rt.dart
          generateBarrel: true
          barrelPath: lib/d4rt_bridges.dart
          generateDartscript: true
          dartscriptPath: lib/dartscript.dart
          registrationClass: MyPackageBridges
```

### 3.3 Running build_runner

```bash
# One-time build
dart run build_runner build

# Watch mode (rebuilds on changes)
dart run build_runner watch
```

---

## 4. Configuration Reference

### 4.1 Top-Level Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `name` | String | **required** | Package name for imports |
| `modules` | List | **required** | List of module configurations |
| `helpersImport` | String | `package:tom_d4rt/tom_d4rt.dart` | Import path for D4rt helpers |
| `generateBarrel` | bool | `true` | Generate barrel export file |
| `barrelPath` | String | `lib/d4rt_bridges.dart` | Path for barrel file |
| `generateDartscript` | bool | `true` | Generate DartScript registration file |
| `dartscriptPath` | String | `lib/dartscript.dart` | Path for DartScript file |
| `registrationClass` | String | `{Name}Bridges` | Name of registration class |

### 4.2 Module Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `name` | String | **required** | Module name |
| `barrelFiles` | List\<String\> | **required** | Barrel files to analyze |
| `outputPath` | String | **required** | Output path for generated bridges |
| `barrelImport` | String | first barrelFile | Import path for source code |
| `excludePatterns` | List\<String\> | `[]` | Glob patterns for files to exclude |
| `excludeClasses` | List\<String\> | `[]` | Class names to exclude |

### 4.3 Exclude Patterns

Patterns use **glob syntax** for matching file paths:

| Pattern | Matches |
|---------|---------|
| `**/*_bridge.dart` | Any file ending in `_bridge.dart` |
| `**/generated/**` | Any file in a `generated` directory |
| `lib/src/internal/**` | All files under `lib/src/internal/` |
| `**/test_*.dart` | Any file starting with `test_` |

**Default Excludes:** The generator always excludes:
- `**/*_bridges.dart` - Generated bridge files
- `**/d4rt_bridges.dart` - Barrel bridge files

---

## 5. Generated Files

### 5.1 Bridge File (`*_bridges.dart`)

Contains `BridgedClass` implementations for each class:

```dart
// D4rt Bridge - Generated file, do not edit
// Sources: 15 files
// Generated: 2026-01-18T12:00:00.000000

import 'package:tom_d4rt/d4rt.dart';
import 'package:my_package/my_package.dart';

class AllBridge {
  static List<BridgedClass> createBridges() {
    return [
      _createMyClassBridge(),
      _createAnotherClassBridge(),
      // ...
    ];
  }

  static String getImportBlock() {
    return "import 'package:my_package/my_package.dart';";
  }
}

BridgedClass _createMyClassBridge() {
  return BridgedClass(
    nativeType: MyClass,
    name: 'MyClass',
    constructors: { /* ... */ },
    getters: { /* ... */ },
    methods: { /* ... */ },
  );
}
```

### 5.2 Enum Bridging

The generator automatically detects and bridges Dart enums, making them available
in D4rt scripts. Both simple enums and enhanced enums (with members) are supported.

**Generated code structure:**

```dart
class AllBridge {
  // ... bridgeClasses() ...
  
  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<MyEnum>(
        name: 'MyEnum',
        values: MyEnum.values,
      ),
    ];
  }
  
  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'MyEnum',
  ];
  
  /// Registers all bridges (classes and enums) with an interpreter.
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes
    for (final bridge in bridgeClasses()) {
      interpreter.registerBridgedClass(bridge, importPath);
    }
    
    // Register bridged enums
    for (final enumDef in bridgedEnums()) {
      interpreter.registerBridgedEnum(enumDef, importPath);
    }
  }
}
```

**Enum features supported:**

| Feature | Status |
|---------|--------|
| Simple enums | ✅ Fully supported |
| Enhanced enums with fields | ✅ Fully supported |
| Enums with methods | ✅ Detected (members accessible in D4rt) |
| Private enums (\_prefixed) | ⚠️ Skipped when `skipPrivate: true` |
| Single-value enums | ✅ Supported |

**D4rt script usage:**

```dart
// Access enum values
var status = SimpleStatus.active;

// Use in switch/match
switch (status) {
  case SimpleStatus.pending: print('Waiting...');
  case SimpleStatus.active: print('Running');
}

// Access enum name and index
print(status.name);   // 'active'
print(status.index);  // 1
```

### 5.3 Barrel File (`d4rt_bridges.dart`)

Re-exports all bridge modules:

```dart
// D4rt Bridge Barrel - Generated file, do not edit
export 'src/d4rt_bridges/my_package_bridges.dart';
```

### 5.3 DartScript File (`dartscript.dart`)

Registration class for D4rt interpreter:

```dart
// D4rt Registration - Generated file, do not edit
import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/my_package_bridges.dart';

class MyPackageBridges {
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt.instance;
    for (final bridge in AllBridge.createBridges()) {
      d4rt.registerBridgedClass(bridge);
    }
  }
}
```

---

## 6. Programmatic API

### 6.1 Basic Usage

```dart
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

Future<void> main() async {
  final generator = BridgeGenerator(
    workspacePath: '/path/to/project',
    packageName: 'my_package',
    helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
  );

  final result = await generator.generateBridgesFromExports(
    barrelFiles: ['lib/my_package.dart'],
    outputPath: 'lib/src/d4rt_bridges/my_package_bridges.dart',
    moduleName: 'all',
  );

  print('Generated ${result.classesGenerated} bridges');
  print('Errors: ${result.errors}');
  print('Warnings: ${result.warnings}');
}
```

### 6.2 Using Configuration

```dart
final config = BridgeConfig(
  name: 'my_package',
  modules: [
    ModuleConfig(
      name: 'all',
      barrelFiles: ['lib/my_package.dart'],
      outputPath: 'lib/src/d4rt_bridges/bridges.dart',
      excludePatterns: ['**/*_test.dart'],
    ),
  ],
  generateBarrel: true,
  barrelPath: 'lib/d4rt_bridges.dart',
);

// Save to JSON
config.toFile('d4rt_bridging.json');

// Load from JSON
final loaded = BridgeConfig.fromFile('d4rt_bridging.json');
```

---

## 7. Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| No exports found | Check barrel file exports are correct |
| Class not bridged | Verify class is exported and not excluded |
| Circular reference | Add pattern to `excludePatterns` |
| Build fails | Check for analyzer errors in source files |

### Debug Mode

Use verbose output to see what's being processed:

```bash
dart run tom_d4rt_generator:d4rt_generator -v
```

Or with build_runner:

```bash
dart run build_runner build --verbose
```

---

## 8. Custom Bridge Overrides

The generator works well for most classes, but some require handwritten bridges:
- Classes needing `nativeNames` mapping for internal implementations
- Complex generic patterns
- Classes with unsupported parameter types

> **Note:** All operators (`+`, `-`, `*`, `/`, `[]`, `[]=`, `&`, `|`, `<`, `>`, `==`, etc.) are now automatically generated by the bridge generator. You only need handwritten bridges for operators if you need special handling.

### 8.1 Override Workflow

**Step 1:** Exclude the problematic class from generation:

```yaml
# In build.yaml
modules:
  - name: all
    barrelFiles:
      - lib/my_package.dart
    outputPath: lib/src/d4rt_bridges/bridges.dart
    excludeClasses:
      - MyComplexClass  # Exclude from auto-generation
```

**Step 2:** Create a handwritten bridge file:

```dart
// lib/src/d4rt_bridges/my_complex_class_bridge.dart
import 'package:tom_d4rt/d4rt.dart';
import 'package:my_package/my_package.dart';

/// Handwritten bridge for MyComplexClass.
/// 
/// This bridge is excluded from auto-generation because:
/// - Needs nativeNames for internal implementations
BridgedClass createMyComplexClassBridge() {
  return BridgedClass(
    nativeType: MyComplexClass,
    name: 'MyComplexClass',
    // Map internal implementation types to this bridge
    nativeNames: ['_MyComplexClassImpl', '_MyComplexClassInternal'],
    constructors: {
      '': (visitor, positional, named) {
        return MyComplexClass();
      },
    },
    methods: {
      // Custom method handling if needed
      'customMethod': (visitor, target, positional, named) {
        final t = D4.validateTarget<MyComplexClass>(target, 'MyComplexClass');
        final arg = D4.getRequiredArg<Object?>(positional, 0, 'arg', 'customMethod');
        return t.customMethod(arg);
      },
    },
    getters: { /* ... */ },
  );
}
```

**Step 3:** Register the custom bridge alongside generated bridges:

```dart
// In your registration code
import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/bridges.dart';
import 'src/d4rt_bridges/my_complex_class_bridge.dart';

void registerAllBridges(D4rt interpreter) {
  // Register auto-generated bridges
  AllBridge.registerBridges(interpreter, 'package:my_package/my_package.dart');
  
  // Register custom handwritten bridges
  interpreter.registerBridgedClass(
    createMyComplexClassBridge(),
    'package:my_package/my_package.dart',
  );
}
```

### 8.2 Using BridgeConfiguration

For applications using `BridgeConfiguration`, add custom bridges:

```dart
final config = BridgeConfiguration(
  bridgeModules: ['my_package'],
  additionalClasses: [
    createMyComplexClassBridge(),
  ],
  additionalClassImportPath: 'package:my_package/my_package.dart',
);

config.apply(interpreter);
```

### 8.3 UserBridge Override System

A more elegant approach allows selective method overrides without excluding the entire class. This system uses companion `{ClassName}UserBridge` classes extending `D4UserBridge` with **static** override methods.

**Step 1:** Import D4UserBridge and create a UserBridge class:

```dart
// lib/src/d4rt_bridges/user_bridges/my_list_user_bridge.dart
import 'package:tom_d4rt/d4rt.dart';

/// User overrides for MyList bridge.
/// Only override methods that need custom handling.
/// All override methods must be static.
class MyListUserBridge extends D4UserBridge {
  /// Custom nativeNames for internal implementations.
  static List<String> get nativeNames => ['_GrowableList', '_FixedLengthList'];
  
  /// Override operator[] - not auto-generated.
  static Object? overrideOperatorIndex(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final list = D4.validateTarget<MyList>(target, 'MyList');
    final index = D4.getRequiredArg<int>(positional, 0, 'index', '[]');
    return list[index];
  }
  
  /// Override add method with custom handling.
  static Object? overrideMethodAdd(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final list = D4.validateTarget<MyList>(target, 'MyList');
    final item = D4.getRequiredArg<Object?>(positional, 0, 'item', 'add');
    list.add(item);
    return null;
  }
}
```

**Step 2:** Ensure the UserBridge file is included in the source files being scanned.

The generator will automatically:
1. Detect `MyListUserBridge` extending `D4UserBridge`
2. Exclude `MyListUserBridge` from bridge generation (it's a helper class)
3. For class `MyList`, reference static methods from `MyListUserBridge`
4. Use `MyListUserBridge.nativeNames` in the generated bridge
5. Generate non-overridden members normally

**Generated output:**

```dart
BridgedClass _createMyListBridge() {
  return BridgedClass(
    nativeType: MyList,
    name: 'MyList',
    nativeNames: MyListUserBridge.nativeNames,  // From UserBridge
    constructors: {
      '': (visitor, positional, named) {
        // Auto-generated
        return MyList();
      },
    },
    getters: {
      'length': (visitor, target) {
        // Auto-generated
        return D4.validateTarget<MyList>(target, 'MyList').length;
      },
    },
    methods: {
      'add': MyListUserBridge.overrideMethodAdd,  // Uses override
      'clear': (visitor, target, positional, named) {
        // Auto-generated (no override)
        final t = D4.validateTarget<MyList>(target, 'MyList');
        t.clear();
        return null;
      },
    },
  );
}
```

**Override naming convention:**

All override methods must be **static**. The naming convention is:

| Member | Static Override Method |
|--------|------------------------|
| Constructor `Foo()` | `static overrideConstructor(...)` |
| Constructor `Foo.named()` | `static overrideConstructorNamed(...)` |
| Getter `value` | `static overrideGetterValue(...)` |
| Setter `value=` | `static overrideSetterValue(...)` |
| Method `doWork()` | `static overrideMethodDoWork(...)` |
| Static getter | `static overrideStaticGetterName(...)` |
| Static setter | `static overrideStaticSetterName(...)` |
| Static method | `static overrideStaticMethodName(...)` |
| Operator `+` | `static overrideOperatorPlus(...)` |
| Operator `-` (binary) | `static overrideOperatorMinus(...)` |
| Operator `-` (unary) | `static overrideOperatorUnaryMinus(...)` |
| Operator `*` | `static overrideOperatorMultiply(...)` |
| Operator `/` | `static overrideOperatorDivide(...)` |
| Operator `~/` | `static overrideOperatorIntegerDivide(...)` |
| Operator `%` | `static overrideOperatorModulo(...)` |
| Operator `[]` | `static overrideOperatorIndex(...)` |
| Operator `[]=` | `static overrideOperatorIndexAssign(...)` |
| Operator `&` | `static overrideOperatorBitwiseAnd(...)` |
| Operator `|` | `static overrideOperatorBitwiseOr(...)` |
| Operator `^` | `static overrideOperatorBitwiseXor(...)` |
| Operator `~` | `static overrideOperatorBitwiseNot(...)` |
| Operator `<<` | `static overrideOperatorLeftShift(...)` |
| Operator `>>` | `static overrideOperatorRightShift(...)` |
| Operator `>>>` | `static overrideOperatorUnsignedRightShift(...)` |
| Operator `<` | `static overrideOperatorLessThan(...)` |
| Operator `>` | `static overrideOperatorGreaterThan(...)` |
| Operator `<=` | `static overrideOperatorLessThanOrEqual(...)` |
| Operator `>=` | `static overrideOperatorGreaterThanOrEqual(...)` |
| Operator `==` | `static overrideOperatorEquals(...)` |

**Why extend D4UserBridge?**

The `extends D4UserBridge` pattern ensures:
- Reliable exclusion from bridge generation (even if similar class names exist)
- Clear marker that identifies bridge helper classes
- Future compatibility with tooling and IDE support

See [userbridge_override_design.md](userbridge_override_design.md) for full specification.

### 8.4 GlobalsUserBridge Override System

Similar to class-level UserBridges, you can override top-level global functions, variables, and getters using a `GlobalsUserBridge` class.

**Step 1:** Create a GlobalsUserBridge class:

```dart
// lib/src/d4rt_bridges/user_bridges/my_globals_user_bridge.dart
import 'package:tom_d4rt/d4rt.dart';

/// User overrides for global functions, variables, and getters.
class MyGlobalsUserBridge extends D4UserBridge {
  /// Override a global variable - returns the replacement value.
  static int get overrideGlobalVariableMaxRetries => 10;
  
  /// Override a global getter - returns a lazy evaluation function.
  static Object? Function() get overrideGlobalGetterLogger => 
      () => CustomLogger.instance;
  
  /// Override a global function - returns the function implementation.
  static Object? Function(InterpreterVisitor, List<Object?>, Map<String, Object?>, List<RuntimeType>?) 
      get overrideGlobalFunctionCalculate => 
          (visitor, positional, named, typeArgs) {
            final a = D4.getRequiredArg<int>(positional, 0, 'a', 'calculate');
            final b = D4.getRequiredArg<int>(positional, 1, 'b', 'calculate');
            return customCalculate(a, b);
          };
}
```

**Step 2:** Ensure the GlobalsUserBridge file is included in the source files being scanned.

The generator will automatically:
1. Detect `GlobalsUserBridge` or `*GlobalsUserBridge` classes extending `D4UserBridge`
2. Use override values/functions for specified globals
3. Generate non-overridden globals normally

**Global override naming convention:**

| Global Type | Override Property Name |
|-------------|------------------------|
| Variable `myVar` | `overrideGlobalVariableMyVar` |
| Getter `myGetter` | `overrideGlobalGetterMyGetter` |
| Function `myFunc()` | `overrideGlobalFunctionMyFunc` |

**Note:** The override name uses PascalCase for the global name (e.g., `maxRetries` → `overrideGlobalVariableMaxRetries`).

**Override return types:**

| Override Type | Return Type |
|---------------|-------------|
| `overrideGlobalVariableXxx` | The value directly (any type) |
| `overrideGlobalGetterXxx` | `Object? Function()` - lazy evaluation function |
| `overrideGlobalFunctionXxx` | `Object? Function(InterpreterVisitor, List<Object?>, Map<String, Object?>, List<RuntimeType>?)` |

**Generated output example:**

```dart
// Auto-generated registerGlobalVariables method
static void registerGlobalVariables(D4rt interpreter) {
  // Uses override value
  interpreter.registerGlobalVariable('maxRetries', MyGlobalsUserBridge.overrideGlobalVariableMaxRetries);
  // Auto-generated
  interpreter.registerGlobalVariable('appName', appName);
}

// Auto-generated registerGlobalGetters method
static void registerGlobalGetters(D4rt interpreter) {
  // Uses override getter
  interpreter.registerGlobalGetter('logger', MyGlobalsUserBridge.overrideGlobalGetterLogger);
  // Auto-generated
  interpreter.registerGlobalGetter('currentUser', () => currentUser);
}

// Auto-generated globalFunctions map
static Map<String, NativeFunctionImpl> globalFunctions() {
  return {
    // Uses override function
    'calculate': MyGlobalsUserBridge.overrideGlobalFunctionCalculate,
    // Auto-generated
    'validate': (visitor, positional, named, typeArgs) {
      final value = D4.getRequiredArg<String>(positional, 0, 'value', 'validate');
      return validate(value);
    },
  };
}
```

### 8.5 When to Use Custom Bridges

| Scenario | Solution |
|----------|----------|
| Operators with special handling | Use user bridge operator overrides |
| Internal implementation types (e.g., `_MultiStream`) | Add `nativeNames` mapping |
| Complex factory constructors | Handwritten constructor adapter |
| Generic class with type constraints | Handwritten with proper type handling |
| Generated bridge has bugs | Exclude and write manual bridge |

---

## 9. Known Limitations

The generator does NOT support:

| Feature | Status | Workaround |
|---------|--------|------------|
| Operator methods (`[]`, `[]=`, `+`, etc.) | ✅ Supported | Auto-generated |
| `nativeNames` mapping | ⚠️ Not generated | Add manually to custom bridge |
| Complex default parameter expressions | ⚠️ May fail | Use `excludeClasses` |
| Covariant parameter overrides | ⚠️ May be incorrect | Review generated code |

See the [D4rt Bridging Guide](_copilot_guidelines/d4rt/BRIDGING_GUIDE.md) for advanced bridging patterns.

---

## 10. Best Practices

1. **Use barrel files** - Export all public APIs from a single barrel file
2. **Exclude generated files** - Add `**/*_generated.dart` to patterns if needed
3. **Use build_runner** - Automatic regeneration on file changes
4. **Version control bridges** - Commit generated files for reproducibility
5. **Check warnings** - External types may need wrapper classes
6. **Test thoroughly** - Verify generated bridges work with D4rt scripts
