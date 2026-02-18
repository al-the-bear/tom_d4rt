# Tom Analyzer Reflection System

## Overview

The Tom Analyzer Reflection System generates runtime reflection capabilities from the static analysis model. It uses **type parameters** and a generic mirror system to provide type-safe reflection without generating a separate class for each analyzed type.

## Architecture

```
┌──────────────────┐
│   Source Code    │
└────────┬─────────┘
         │ analyze
         ▼
┌──────────────────────┐      serialize     ┌───────────────┐
│   AnalysisResult     │────────────────────▶│ analysis.yaml │
│  (Static Analysis)   │                     └───────────────┘
└────────┬─────────────┘
         │ load
         ▼
┌──────────────────────┐      generate      ┌─────────────────────┐
│  ReflectionModel     │◀───────────────────│  Code Generator     │
│  (Runtime Mirrors)   │                    │  (build_runner)     │
└────────┬─────────────┘                    └─────────────────────┘
         │ use
         ▼
┌──────────────────────┐
│  Application Code    │
│  (Dynamic Invocation)│
└──────────────────────┘
```

## Design Philosophy

### Static Analysis Model (Pure Data)
- Serializable to YAML/JSON
- Platform-independent
- No runtime behavior
- Can analyze code that doesn't compile

### Reflection Model (Runtime Behavior)
- Generated from AnalysisResult
- Uses type parameters for type safety
- Minimal generated code (one data file)
- Supports dynamic invocation

## Core Design Pattern

### Type-Parameterized Mirrors

Instead of generating a class per analyzed class, we use **generic mirror classes** with type parameters:

```dart
// Not generated: Generic mirror class
class ClassMirror<T> {
  final ClassInfo info;
  final ReflectorData _data;
  
  ClassMirror(this.info, this._data);
  
  // Type-safe instance creation
  T newInstance({
    String constructorName = '',
    List<dynamic> positionalArgs = const [],
    Map<Symbol, dynamic> namedArgs = const {},
  }) {
    return _data.createInstance<T>(
      info.qualifiedName,
      constructorName,
      positionalArgs,
      namedArgs,
    );
  }
  
  // Get method mirror with covariant return
  MethodMirror<T, R> method<R>(String name) {
    final methodInfo = info.methods.firstWhere((m) => m.name == name);
    return MethodMirror<T, R>(methodInfo, _data);
  }
  
  // Get field mirror
  FieldMirror<T, F> field<F>(String name) {
    final fieldInfo = info.fields.firstWhere((f) => f.name == name);
    return FieldMirror<T, F>(fieldInfo, _data);
  }
}

// Not generated: Generic method mirror
class MethodMirror<TClass, TReturn> {
  final MethodInfo info;
  final ReflectorData _data;
  
  MethodMirror(this.info, this._data);
  
  // Type-safe invocation
  TReturn invoke(
    TClass instance, {
    List<dynamic> positionalArgs = const [],
    Map<Symbol, dynamic> namedArgs = const {},
  }) {
    return _data.invokeMethod<TReturn>(
      instance,
      info.declaringClass!.qualifiedName,
      info.name,
      positionalArgs,
      namedArgs,
    );
  }
}

// Not generated: Generic field mirror
class FieldMirror<TClass, TField> {
  final FieldInfo info;
  final ReflectorData _data;
  
  FieldMirror(this.info, this._data);
  
  // Type-safe get
  TField get(TClass instance) {
    return _data.getField<TField>(
      instance,
      info.declaringClass!.qualifiedName,
      info.name,
    );
  }
  
  // Type-safe set
  void set(TClass instance, TField value) {
    _data.setField(
      instance,
      info.declaringClass!.qualifiedName,
      info.name,
      value,
    );
  }
}
```

## Generated Code Structure

### Single Data File Pattern

Following tom_reflection's pattern, we generate **one data file** containing lookup tables and factory functions:

```dart
// lib/generated/tom_analyzer.reflection.dart (GENERATED)

import 'package:tom_analyzer/tom_analyzer.dart' as prefix0;
import 'package:tom_reflection/mirrors.dart' as m;
import 'package:tom_reflection/generated.dart' as r;

// Main registry mapping reflector to data
final _reflectionData = <r.Reflector, r.ReflectorData>{
  const TomAnalyzerReflector(): r.ReflectorData(
    // Type mirrors
    <m.TypeMirror>[
      // ClassMirror for TomAnalyzer
      r.NonGenericClassMirrorImpl<prefix0.TomAnalyzer>(
        r'TomAnalyzer',
        r'.TomAnalyzer',
        134217735,  // Encoded flags
        0,          // Index
        const TomAnalyzerReflector(),
        const <int>[0, 1],  // Constructor indices
        const <int>[2, 3, 4],  // Method indices
        const <int>[],  // Field indices
        50,  // Mirror count
        {},  // Named constructors
        {},  // Declarations
        {
          // Default constructor factory
          r'': (bool isNew) =>
              () => isNew ? prefix0.TomAnalyzer() : null,
        },
        0,  // Superclass index
        0,  // Mixin count
        const <int>[],  // Mixin indices
        const <Object>[],  // Metadata
        null,
      ),
      
      // ClassMirror for AnalysisResult
      r.NonGenericClassMirrorImpl<prefix0.AnalysisResult>(
        r'AnalysisResult',
        r'.AnalysisResult',
        134217735,
        1,
        const TomAnalyzerReflector(),
        const <int>[5],  // Constructors
        const <int>[6, 7, 8, 9],  // Methods (findClass, etc.)
        const <int>[10, 11, 12],  // Fields (timestamp, etc.)
        50,
        {},
        {},
        {},
        0,
        0,
        const <int>[],
        const <Object>[],
        null,
      ),
    ],
    
    // Methods
    <m.MethodMirror>[
      // Index 2: TomAnalyzer.analyzeBarrel
      r.MethodMirrorImpl(
        r'analyzeBarrel',
        134348038,  // Flags: instance, regular method
        2,  // Declaring class index (TomAnalyzer)
        -1, // No return type
        const <int>[13, 14],  // Parameter indices
        const <int>[],  // Type variable indices
        const <Object>[],  // Metadata
        r'',  // Empty string for instance method
      ),
      
      // Index 3: TomAnalyzer.analyze
      r.MethodMirrorImpl(
        r'analyze',
        134348038,
        2,
        -1,
        const <int>[15],  // Parameters
        const <int>[],
        const <Object>[],
        r'',
      ),
    ],
    
    // Parameters
    <m.ParameterMirror>[
      // Index 13: analyzeBarrel.barrelPath
      r.ParameterMirrorImpl(
        r'barrelPath',
        67244166,  // Flags: named, required
        16,  // Type index (String)
        const <int>[],  // Type arguments
        -1,  // No default value
        const <Object>[],
      ),
      
      // Index 14: analyzeBarrel.workspaceRoot
      r.ParameterMirrorImpl(
        r'workspaceRoot',
        67244166,
        16,
        const <int>[],
        17,  // Default value index
        const <Object>[],
      ),
    ],
    
    // Member invocation map
    memberSymbolMap: {
      #analyzeBarrel: 'analyzeBarrel',
      #analyze: 'analyze',
      #findClass: 'findClass',
      #allClasses: 'allClasses',
      // ... all members
    },
  ),
};

// Reflector class (user-facing entry point)
class TomAnalyzerReflector extends r.Reflector {
  const TomAnalyzerReflector();
  
  @override
  r.ReflectorData? data(r.Reflector reflector) => _reflectionData[reflector];
}

// Global reflector instance
const tomAnalyzerReflector = TomAnalyzerReflector();
```

## Usage API

### Type-Safe Reflection

```dart
import 'package:tom_analyzer/tom_analyzer.dart';
import 'package:tom_analyzer/generated/tom_analyzer.reflection.dart';

void main() {
  // Get reflector
  final reflector = tomAnalyzerReflector;
  
  // Create instance using reflection
  final analyzer = reflector.createInstance<TomAnalyzer>(
    'package:tom_analyzer/tom_analyzer.TomAnalyzer',
  );
  
  // Get class mirror
  final classMirror = reflector.reflectType<TomAnalyzer>();
  
  // Invoke method with type safety
  final result = classMirror
      .method<Future<AnalysisResult>>('analyzeBarrel')
      .invoke(
        analyzer,
        namedArgs: {
          #barrelPath: 'lib/tom_analyzer.dart',
          #workspaceRoot: '.',
        },
      );
  
  // Access fields
  final resultMirror = reflector.reflectType<AnalysisResult>();
  final instance = await result;
  
  final timestamp = resultMirror
      .field<DateTime>('timestamp')
      .get(instance);
  
  print('Analysis completed at: $timestamp');
}
```

### Dynamic Reflection (Untyped)

```dart
void processUnknownType(dynamic obj) {
  final reflector = tomAnalyzerReflector;
  final instanceMirror = reflector.reflect(obj);
  final classMirror = instanceMirror.type;
  
  print('Type: ${classMirror.simpleName}');
  print('Package: ${classMirror.owner.simpleName}');
  
  // List methods
  for (final method in classMirror.declarations.values) {
    if (method is MethodMirror) {
      print('  Method: ${method.simpleName}');
    }
  }
  
  // Invoke method by name
  if (classMirror.declarations.containsKey(Symbol('analyzeBarrel'))) {
    final result = instanceMirror.invoke(
      Symbol('analyzeBarrel'),
      [],
      {Symbol('barrelPath'): 'lib/test.dart'},
    );
    print('Result: $result');
  }
}
```

### Integration with AnalysisResult

```dart
// Load analysis result and create reflection model
Future<void> reflectOnAnalysis() async {
  // Load static analysis
  final yaml = await File('analysis.yaml').readAsString();
  final analysisResult = AnalysisResult.fromYaml(yaml);
  
  // Create reflection model
  final reflectionModel = ReflectionModel.fromAnalysis(
    analysisResult,
    tomAnalyzerReflector,
  );
  
  // Get mirror for analyzed class
  final classInfo = analysisResult.findClass(
    'package:my_app/models.User',
  );
  
  if (classInfo != null) {
    // Create runtime mirror from static info
    final classMirror = reflectionModel.getClassMirror(classInfo);
    
    // Create instance
    final userInstance = classMirror.newInstance(
      namedArgs: {
        Symbol('id'): 1,
        Symbol('name'): 'John',
      },
    );
    
    // Invoke getter
    final name = classMirror
        .method('getName')
        .invoke(userInstance);
    
    print('User name: $name');
  }
}
```

## ReflectionModel Bridge

The bridge between static analysis and runtime reflection:

```dart
class ReflectionModel {
  final AnalysisResult analysisResult;
  final Reflector reflector;
  final Map<ClassInfo, Type?> _typeCache = {};
  
  ReflectionModel(this.analysisResult, this.reflector);
  
  /// Create reflection model from analysis result
  factory ReflectionModel.fromAnalysis(
    AnalysisResult analysis,
    Reflector reflector,
  ) {
    return ReflectionModel(analysis, reflector);
  }
  
  /// Get runtime mirror for a ClassInfo
  ClassMirror<T>? getClassMirror<T>(ClassInfo classInfo) {
    // Try to resolve runtime type
    final type = _resolveType<T>(classInfo.qualifiedName);
    if (type == null) return null;
    
    // Get mirror from reflector
    final typeMirror = reflector.reflectType(type);
    if (typeMirror is! ClassMirror) return null;
    
    return typeMirror as ClassMirror<T>;
  }
  
  /// Create instance from ClassInfo
  T? createInstance<T>(
    ClassInfo classInfo, {
    String constructorName = '',
    List<dynamic> positionalArgs = const [],
    Map<Symbol, dynamic> namedArgs = const {},
  }) {
    return reflector.createInstance<T>(
      classInfo.qualifiedName,
      constructorName: constructorName,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
  }
  
  /// Invoke method from MethodInfo
  R? invokeMethod<R>(
    dynamic instance,
    MethodInfo methodInfo, {
    List<dynamic> positionalArgs = const [],
    Map<Symbol, dynamic> namedArgs = const {},
  }) {
    final instanceMirror = reflector.reflect(instance);
    return instanceMirror.invoke(
      Symbol(methodInfo.name),
      positionalArgs,
      namedArgs,
    ) as R?;
  }
  
  Type? _resolveType<T>(String qualifiedName) {
    // Use reflector's type registry
    return reflector.findTypeByQualifiedName(qualifiedName);
  }
}
```

## Code Generation Process

### Generator Implementation

```dart
// tool/generate_reflection.dart
import 'dart:io';
import 'package:tom_analyzer/tom_analyzer.dart';
import 'package:tom_analyzer/src/reflection/reflection_generator.dart';

Future<void> main(List<String> args) async {
  // Load analysis result
  final yamlContent = await File('analysis.yaml').readAsString();
  final analysisResult = AnalysisResult.fromYaml(yamlContent);
  
  // Generate reflection data
  final generator = ReflectionGenerator();
  final code = generator.generate(analysisResult);
  
  // Write generated file
  await File('lib/generated/tom_analyzer.reflection.dart')
      .writeAsString(code);
  
  print('Generated reflection data');
}
```

### Reflection Generator

```dart
class ReflectionGenerator {
  int _classIndex = 0;
  int _methodIndex = 0;
  int _paramIndex = 0;
  int _fieldIndex = 0;
  
  final _imports = <String>{};
  final _classMirrors = <String>[];
  final _methods = <String>[];
  final _params = <String>[];
  final _fields = <String>[];
  final _constructors = <String>{};
  
  String generate(AnalysisResult result) {
    // Reset state
    _classIndex = 0;
    _methodIndex = 0;
    _paramIndex = 0;
    _fieldIndex = 0;
    _imports.clear();
    _classMirrors.clear();
    _methods.clear();
    _params.clear();
    _fields.clear();
    _constructors.clear();
    
    // Collect imports
    for (final lib in result.libraries.values) {
      if (lib.package.isRoot) {
        _imports.add("import '${lib.uri}' as prefix$_classIndex;");
      }
    }
    
    // Generate class mirrors
    for (final lib in result.libraries.values) {
      if (lib.package.isRoot) {
        for (final classInfo in lib.classes) {
          _generateClassMirror(classInfo);
        }
      }
    }
    
    // Build output
    return _buildOutput();
  }
  
  void _generateClassMirror(ClassInfo classInfo) {
    final classIdx = _classIndex++;
    final prefix = 'prefix$classIdx';
    
    // Collect methods
    final methodIndices = <int>[];
    for (final method in classInfo.methods) {
      methodIndices.add(_methodIndex);
      _generateMethodMirror(method);
    }
    
    // Collect fields
    final fieldIndices = <int>[];
    for (final field in classInfo.fields) {
      fieldIndices.add(_fieldIndex);
      _generateFieldMirror(field);
    }
    
    // Generate constructor factories
    final ctorMap = <String>[];
    for (final ctor in classInfo.constructors) {
      final name = ctor.name.isEmpty ? '' : '.${ctor.name}';
      _constructors.add(_generateConstructorFactory(classInfo, ctor));
      ctorMap.add("r'${ctor.name}': _create_${_sanitize(classInfo.qualifiedName)}_${ctor.name},");
    }
    
    // Build class mirror
    _classMirrors.add('''
      r.NonGenericClassMirrorImpl<$prefix.${classInfo.name}>(
        r'${classInfo.name}',
        r'.${classInfo.name}',
        134217735,
        $classIdx,
        const TomAnalyzerReflector(),
        const <int>[$methodIndices],
        const <int>[$fieldIndices],
        50,
        {${ctorMap.join('\n')}},
        const <Object>[],
        null,
      ),
    ''');
  }
  
  void _generateMethodMirror(MethodInfo method) {
    final paramIndices = <int>[];
    for (final param in method.parameters) {
      paramIndices.add(_paramIndex);
      _generateParamMirror(param);
    }
    
    _methods.add('''
      r.MethodMirrorImpl(
        r'${method.name}',
        134348038,
        ${method.declaringClass != null ? _findClassIndex(method.declaringClass!) : -1},
        -1,
        const <int>[${paramIndices.join(', ')}],
        const <int>[],
        const <Object>[],
        r'',
      ),
    ''');
    
    _methodIndex++;
  }
  
  void _generateParamMirror(ParameterInfo param) {
    _params.add('''
      r.ParameterMirrorImpl(
        r'${param.name}',
        ${param.isRequired ? 67244166 : 67244165},
        -1,
        const <int>[],
        -1,
        const <Object>[],
      ),
    ''');
    
    _paramIndex++;
  }
  
  String _generateConstructorFactory(ClassInfo cls, ConstructorInfo ctor) {
    final params = ctor.parameters;
    final paramCode = params.map((p) {
      if (p.isNamed) {
        return '${p.name}: namedArgs[Symbol(\'${p.name}\')]';
      } else {
        return 'positionalArgs[${params.indexOf(p)}]';
      }
    }).join(', ');
    
    final ctorName = ctor.name.isEmpty ? '' : '.${ctor.name}';
    
    return '''
Function _create_${_sanitize(cls.qualifiedName)}_${ctor.name}(
  List positionalArgs,
  Map<Symbol, dynamic> namedArgs,
) {
  return () => prefix${_findClassIndex(cls)}.${cls.name}$ctorName($paramCode);
}
''';
  }
  
  String _buildOutput() {
    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND

${_imports.join('\n')}

import 'package:tom_reflection/mirrors.dart' as m;
import 'package:tom_reflection/generated.dart' as r;

${_constructors.join('\n\n')}

final _reflectionData = <r.Reflector, r.ReflectorData>{
  const TomAnalyzerReflector(): r.ReflectorData(
    <m.TypeMirror>[
      ${_classMirrors.join('\n')}
    ],
    <m.MethodMirror>[
      ${_methods.join('\n')}
    ],
    <m.ParameterMirror>[
      ${_params.join('\n')}
    ],
    <m.VariableMirror>[
      ${_fields.join('\n')}
    ],
    memberSymbolMap: {},
  ),
};

class TomAnalyzerReflector extends r.Reflector {
  const TomAnalyzerReflector();
  
  @override
  r.ReflectorData? data(r.Reflector reflector) => _reflectionData[reflector];
}

const tomAnalyzerReflector = TomAnalyzerReflector();
''';
  }
  
  String _sanitize(String name) => name.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');
  
  int _findClassIndex(ClassInfo cls) {
    // Implementation to find class index
    return 0;
  }
}
```

## Benefits

✅ **Type Safety**: Type parameters provide compile-time type checking
✅ **Minimal Code Gen**: One data file instead of class per type
✅ **Performance**: Direct function pointers, no string lookups
✅ **Compatibility**: Works with tom_reflection package
✅ **Flexibility**: Supports both typed and dynamic reflection
✅ **Serialization**: Analysis model remains serializable
✅ **Integration**: Seamless bridge between static analysis and runtime

## Comparison

| Feature | Traditional (dart:mirrors) | Tom Reflection (This Design) |
|---------|---------------------------|------------------------------|
| Code Generation | None (runtime only) | One data file |
| Type Safety | Runtime only | Compile-time with generics |
| Tree Shaking | Not supported | Supported |
| Platform Support | VM only | All platforms |
| Performance | Slower (symbol lookups) | Faster (direct pointers) |
| Analysis Integration | None | Full integration with AnalysisResult |

## Handling Duplicate Elements

### Problem: Multiple Elements with Same Name

In large codebases, the same class/function name may appear in multiple libraries:

```dart
// package:app/models/user.dart
class User { ... }

// package:app/api/user.dart  
class User { ... }

// package:some_dependency/user.dart
class User { ... }
```

### Solution: Qualified Name Resolution

**Reflection Model Strategy:**

1. **Primary key: Fully qualified name**
   - `package:app/models/user.User` (unique)
   - `package:app/api/user.User` (unique)
   - Simple name `User` is ambiguous

2. **Library-scoped reflection**
   ```dart
   // Get mirror with library context
   final userMirror = reflector.reflectType(
     'User',
     libraryUri: Uri.parse('package:app/models/user.dart'),
   );
   ```

3. **Ambiguity detection**
   ```dart
   // Throws AmbiguousElementException if multiple matches
   final userMirror = reflector.reflectTypeByName('User');
   
   // Safe: returns all matches
   final allUsers = reflector.findTypesByName('User');
   ```

4. **Type-based disambiguation**
   ```dart
   // Use runtime type to get exact mirror
   import 'package:app/models/user.dart' as models;
   
   final mirror = reflector.reflectType(models.User);
   ```

### ReflectorData Organization

```dart
class ReflectorData {
  // Qualified name -> type mirror (primary index)
  final Map<String, TypeMirror> _qualifiedNameIndex;
  
  // Simple name -> list of type mirrors (ambiguous)
  final Map<String, List<TypeMirror>> _simpleNameIndex;
  
  // Library URI -> types in that library
  final Map<Uri, List<TypeMirror>> _libraryIndex;
  
  /// Get mirror by qualified name (always unambiguous)
  TypeMirror? byQualifiedName(String qualifiedName) {
    return _qualifiedNameIndex[qualifiedName];
  }
  
  /// Get mirror by simple name - throws if ambiguous
  TypeMirror bySimpleName(String name) {
    final matches = _simpleNameIndex[name];
    if (matches == null || matches.isEmpty) {
      throw ElementNotFoundException('No type found with name: $name');
    }
    if (matches.length > 1) {
      throw AmbiguousElementException(
        'Multiple types found with name "$name": '
        '${matches.map((m) => m.qualifiedName).join(", ")}'
      );
    }
    return matches.first;
  }
  
  /// Get mirror by simple name in specific library
  TypeMirror? bySimpleNameInLibrary(String name, Uri libraryUri) {
    final libraryTypes = _libraryIndex[libraryUri] ?? [];
    return libraryTypes.firstWhereOrNull((t) => t.simpleName == name);
  }
  
  /// Get all mirrors matching simple name (safe)
  List<TypeMirror> findBySimpleName(String name) {
    return _simpleNameIndex[name] ?? [];
  }
}
```

### Exception Types

```dart
/// Thrown when element is not found
class ElementNotFoundException implements Exception {
  final String message;
  ElementNotFoundException(this.message);
  
  @override
  String toString() => 'ElementNotFoundException: $message';
}

/// Thrown when multiple elements match and disambiguation is required
class AmbiguousElementException implements Exception {
  final String message;
  final List<String> candidates;
  
  AmbiguousElementException(this.message, {this.candidates = const []});
  
  @override
  String toString() => 'AmbiguousElementException: $message';
}
```

### Simple API for Common Case

**Design principle:** Make the common case (single element) easy, fail fast on ambiguity.

```dart
class Reflector {
  // ========================================================================
  // Simple API - assumes single element, throws if not found or ambiguous
  // ========================================================================
  
  /// Get type mirror by name - throws if not found or ambiguous
  /// 
  /// Use this when you know there's exactly one type with this name.
  /// Throws [ElementNotFoundException] if not found.
  /// Throws [AmbiguousElementException] if multiple matches.
  ClassMirror<T> getTypeOrThrow<T>(String name) {
    final data = this.data(this);
    if (data == null) throw ElementNotFoundException('No reflection data');
    
    return data.bySimpleName(name) as ClassMirror<T>;
  }
  
  /// Get type mirror by qualified name (always safe, returns null if not found)
  ClassMirror<T>? getTypeByQualifiedName<T>(String qualifiedName) {
    final data = this.data(this);
    return data?.byQualifiedName(qualifiedName) as ClassMirror<T>?;
  }
  
  // ========================================================================
  // Advanced API - returns multiple results
  // ========================================================================
  
  /// Find all types with given name (safe, returns empty list if none)
  List<ClassMirror> findTypesByName(String name) {
    final data = this.data(this);
    if (data == null) return [];
    return data.findBySimpleName(name).cast<ClassMirror>();
  }
  
  /// Get type in specific library
  ClassMirror<T>? getTypeInLibrary<T>(String name, Uri libraryUri) {
    final data = this.data(this);
    return data?.bySimpleNameInLibrary(name, libraryUri) as ClassMirror<T>?;
  }
}
```

### Usage Examples

**Simple case (common):**
```dart
// Assumes exactly one User class in analyzed code
final userMirror = reflector.getTypeOrThrow<User>('User');
final user = userMirror.newInstance();
```

**Handle potential ambiguity or missing element:**
```dart
try {
  final userMirror = reflector.getTypeOrThrow<User>('User');
  // ...
} on ElementNotFoundException catch (e) {
  print('User class not found in reflection data');
} on AmbiguousElementException catch (e) {
  print('Multiple User classes found: ${e.candidates}');
  // Disambiguate by qualified name
  final userMirror = reflector.getTypeByQualifiedName<User>(
    'package:my_app/models/user.User',
  );
}
```

**Explicit disambiguation:**
```dart
// When you know there are multiple, find and choose
final userMirrors = reflector.findTypesByName('User');
for (final mirror in userMirrors) {
  print('Found: ${mirror.qualifiedName}');
}

// Choose specific one
final modelUser = reflector.getTypeInLibrary<User>(
  'User',
  Uri.parse('package:my_app/models/user.dart'),
);
```

**Safe optional access:**
```dart
// Use find methods for safe access
final userMirrors = reflector.findTypesByName('User');
if (userMirrors.length == 1) {
  final user = userMirrors.first.newInstance();
} else if (userMirrors.isEmpty) {
  print('User class not found');
} else {
  print('Multiple User classes, need disambiguation');
}

// Or use qualified name lookup (returns null if not found)
final userMirror = reflector.getTypeByQualifiedName<User>(
  'package:my_app/models/user.User',
);
if (userMirror != null) {
  final user = userMirror.newInstance();
}
```

## Next Steps

1. ✅ Define object model for static analysis (complete)
2. ✅ Design reflection architecture (this document)
3. ✅ Define duplicate element handling strategy (this section)
4. ⏳ Implement ReflectionGenerator
5. ⏳ Create ReflectionModel bridge
6. ⏳ Add build_runner support
7. ⏳ Write comprehensive tests
8. ⏳ Document usage patterns
