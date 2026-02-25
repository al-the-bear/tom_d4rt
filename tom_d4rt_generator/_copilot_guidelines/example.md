````markdown
# D4rt Generator Example Guidelines

This document provides guidelines for creating and maintaining example files in the `tom_d4rt_generator` package.

## Example Structure Overview

The `example/` folder contains two types of examples:

1. **Document-based examples** - Standalone mini-packages in `example/<document-name>/` that correspond to documentation files
2. **Test class examples** - The main example package with comprehensive test classes

## Document-Based Examples

Each documentation file in `doc/` should have a corresponding example folder:

```
example/
├── run_all_examples.dart         # Master script to run all examples
├── user_guide/                   # From bridgegenerator_user_guide.md
│   ├── pubspec.yaml
│   ├── d4rt_bridging.json       # CLI configuration (fallback)
│   ├── lib/
│   │   ├── user_guide_example.dart
│   │   └── src/
│   └── bin/
│       └── run_example.dart
├── user_reference/               # From bridgegenerator_user_reference.md
│   ├── pubspec.yaml
│   ├── d4rt_bridging.json       # Full config reference example
│   ├── lib/
│   │   ├── user_reference_example.dart
│   │   └── src/
│   └── bin/
│       └── run_example.dart
├── userbridge_override/          # From userbridge_override_design.md
│   ├── pubspec.yaml
│   ├── d4rt_bridging.json
│   ├── lib/
│   │   ├── userbridge_override_example.dart
│   │   └── src/
│   │       ├── my_list.dart     # Source class
│   │       ├── my_list_user_bridge.dart  # UserBridge override
│   │       ├── globals.dart
│   │       └── globals_user_bridge.dart
│   └── bin/
│       └── run_example.dart
└── ... (existing test_classes structure)
```

### Document Example Configuration

Each document example uses `d4rt_bridging.json` as the CLI configuration file:

```json
{
  "$schema": "../../json_schema/d4rt_bridging_schema.json",
  "name": "example_name",
  "description": "Example description",
  "modules": [
    {
      "package": "example_package_name",
      "barrelFile": "lib/example_package.dart"
    }
  ],
  "outputPath": "lib/src/d4rt_bridges/"
}
```

### Running Document Examples

Each example can be run standalone:

```bash
cd example/user_guide
dart pub get
dart run tom_d4rt_generator --config d4rt_bridging.json
dart run bin/run_example.dart
```

Or all examples can be run with the master script:

```bash
dart run example/run_all_examples.dart
dart run example/run_all_examples.dart --generate-only
dart run example/run_all_examples.dart --run-only
```

---

## Main Example Package Structure

The main `example/` folder is also a Dart package demonstrating the bridge generator:

```
example/
├── pubspec.yaml                # Example package definition
├── analysis_options.yaml       # Analyzer config
├── generate_bridges.dart       # Local generation script
├── run_examples.dart           # Runs D4rt scripts with generated bridges
├── lib/
│   ├── test_classes.dart       # Barrel export of test classes
│   ├── d4rt_bridges.dart       # Barrel export of generated bridges
│   ├── test_classes/           # Source classes to be bridged
│   │   ├── basic_classes.dart
│   │   ├── generic_classes.dart
│   │   ├── inheritance_classes.dart
│   │   ├── callback_classes.dart
│   │   ├── operator_classes.dart
│   │   ├── enum_classes.dart
│   │   └── global_members.dart
│   └── d4rt_bridges/           # Generated bridge files
│       ├── basic_bridge.dart
│       ├── generic_bridge.dart
│       ├── inheritance_bridge.dart
│       ├── callback_bridge.dart
│       ├── operator_bridge.dart
│       ├── enum_bridge.dart
│       └── global_bridge.dart
├── scripts/                    # D4rt scripts demonstrating bridges
│   ├── basic_example.d4rt
│   ├── generic_example.d4rt
│   ├── inheritance_example.d4rt
│   ├── callbacks_example.d4rt
│   └── operators_example.d4rt
└── test/                       # Unit tests for generated bridges
    ├── test_bridge_context.dart
    ├── test_covariance.dart
    └── ...
```

## Example Categories

### Test Classes (`example/lib/test_classes/`)

Each file demonstrates a specific bridging feature:

| File | Feature Demonstrated |
|------|---------------------|
| `basic_classes.dart` | Simple classes with constructors, methods, getters, setters |
| `generic_classes.dart` | Generic classes and methods with type parameters |
| `inheritance_classes.dart` | Class inheritance, abstract classes, interfaces |
| `callback_classes.dart` | Methods accepting function parameters |
| `operator_classes.dart` | Operator overloading |
| `enum_classes.dart` | Enum bridging |
| `global_members.dart` | Top-level functions and variables |

### D4rt Scripts (`example/scripts/`)

Each `.d4rt` file demonstrates using the corresponding bridges:

| Script | Purpose |
|--------|---------|
| `basic_example.d4rt` | Using bridged constructors, methods, properties |
| `generic_example.d4rt` | Using generic classes from D4rt |
| `inheritance_example.d4rt` | Polymorphism with bridged classes |
| `callbacks_example.d4rt` | Passing interpreted functions to native code |
| `operators_example.d4rt` | Using bridged operators |

## Running Examples

### Running All Examples

```bash
cd example
dart run run_examples.dart all
```

### Running a Specific Example

```bash
dart run run_examples.dart basic
dart run run_examples.dart generic
dart run run_examples.dart inheritance
```

## Adding New Examples

When adding a new bridging feature demonstration:

### 1. Create Test Class

Add a new file in `example/lib/test_classes/`:

```dart
// example/lib/test_classes/new_feature_classes.dart

/// Demonstrates [feature name] for bridge generation.
class NewFeatureClass {
  // ... implementation showing the feature
}
```

### 2. Export from Barrel

Add export to `example/lib/test_classes.dart`:

```dart
export 'test_classes/new_feature_classes.dart';
```

### 3. Regenerate Bridges

```bash
cd tom_d4rt_generator
dart run bin/d4rt_generator.dart --project=example
```

### 4. Create D4rt Script

Add a script demonstrating usage in `example/scripts/`:

```dart
// example/scripts/new_feature_example.d4rt

import 'package:d4rt_generator_example/test_classes.dart';

void main() {
  print('=== New Feature Example ===');
  
  final instance = NewFeatureClass();
  // ... demonstrate the feature
}
```

### 5. Update run_examples.dart

Add the new script to `availableScripts` list and add bridge imports:

```dart
import 'package:d4rt_generator_example/d4rt_bridges/new_feature_bridge.dart';

// In availableScripts list:
'new_feature_example.d4rt',
```

### 6. Verify

```bash
cd example
dart run run_examples.dart new_feature
dart run run_examples.dart all
```

## Example File Templates

### Test Class Template

```dart
// example/lib/test_classes/{feature}_classes.dart

/// Demonstrates {feature} for D4rt bridge generation.
///
/// This file is processed by tom_d4rt_generator to produce
/// {feature}_bridge.dart in the d4rt_bridges folder.
library;

/// A class demonstrating {feature}.
class {FeatureName}Class {
  // Properties
  final String value;
  
  // Constructors
  {FeatureName}Class(this.value);
  {FeatureName}Class.named({required this.value});
  
  // Methods
  String describe() => '{FeatureName}: $value';
}
```

### D4rt Script Template

```dart
// example/scripts/{feature}_example.d4rt
//
// Demonstrates: {feature description}
// Bridge: d4rt_bridges/{feature}_bridge.dart

import 'package:d4rt_generator_example/test_classes.dart';

void main() {
  print('=== {Feature} Example ===');
  print('');
  
  // Create instance using bridged constructor
  final instance = {FeatureName}Class('test value');
  
  // Call bridged methods
  print('Result: ${instance.describe()}');
  
  print('');
  print('✓ {Feature} example complete');
}
```

## Verification Checklist

Before committing examples:

1. **Regenerate bridges:** `dart run bin/d4rt_generator.dart --project=example`
2. **Run analyzer:** `cd example && dart analyze`
3. **Run all examples:** `dart run run_examples.dart all` or `dart run example/run_all_examples.dart`
4. **Verify output is correct**

## Notes on Example Package Structure

The example is a separate Dart package (`d4rt_generator_example`) to:

1. Demonstrate realistic bridge generation workflow
2. Test the generator against a real package
3. Provide runnable D4rt scripts for verification
4. Show recommended project structure for bridge users

---

## Adding Document-Based Examples

When creating examples from documentation:

### 1. Create Example Directory

```bash
mkdir -p example/<document-name>/lib/src
mkdir -p example/<document-name>/bin
```

### 2. Create Package Files

**pubspec.yaml:**
```yaml
name: <document_name>_example
description: Example from <document-name>.md
version: 1.0.0
publish_to: none

environment:
  sdk: ^3.0.0

dependencies:
  tom_d4rt:
    path: ../../../../tom_d4rt

dev_dependencies:
  tom_d4rt_generator:
    path: ../..
```

**d4rt_bridging.json:**
```json
{
  "$schema": "../../json_schema/d4rt_bridging_schema.json",
  "name": "<document_name>",
  "modules": [
    {
      "package": "<document_name>_example",
      "barrelFile": "lib/<document_name>_example.dart"
    }
  ],
  "outputPath": "lib/src/d4rt_bridges/"
}
```

### 3. Create Source Files

Place source classes in `lib/src/` and export from the barrel file.

### 4. Create Run Script

Create `bin/run_example.dart` that demonstrates the example.

### 5. Add to run_all_examples.dart

Add the new example to the `examples` list in `example/run_all_examples.dart`.

### 6. Generate and Test

```bash
cd example/<document-name>
dart pub get
dart run tom_d4rt_generator --config d4rt_bridging.json --project .
dart run bin/run_example.dart
```

````
