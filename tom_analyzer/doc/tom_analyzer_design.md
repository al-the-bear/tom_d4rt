# Tom Analyzer Design Document

## Overview

**tom_analyzer** is a comprehensive Dart code analysis tool that captures complete analyzer results for import barrels and generates structured object models. It serves three roles:

1. **Standalone CLI tool** - Analyze projects from command line
2. **build_runner builder** - Integrate analysis into build pipeline
3. **Library package** - Programmatic access to analysis results

The analyzer produces a complete snapshot of a codebase's structure, serializable to JSON, enabling downstream tools to consume analysis results without re-running expensive analyzer operations.

## Design Goals

### Primary Goals

- **Comprehensive Analysis**: Capture all relevant information from Dart analyzer
- **Stability & Backwards Compatibility**: Isolate from dart analyzer package changes and Dart language evolution
- **Type Parameter Resolution**: Handle complex generics, bounds, and inference correctly
- **Serialization**: Full JSON round-trip support for all data structures
- **Reusability**: Clean object model usable by other packages
- **Performance**: Efficient analysis and caching strategies

### Use Cases

1. **Code Generation**: Tools that need type information without running analyzer
2. **Documentation**: Generate API docs from analysis cache
3. **Bridge Generation**: D4rt bridge generator can consume analysis results
4. **Workspace Indexing**: Build searchable indexes of workspace APIs
5. **Dependency Analysis**: Understand package dependencies and usage
6. **Stable API Surface**: Insulate downstream tools from analyzer/Dart version changes
7. **Complex Type Resolution**: Provide pre-resolved type information including tricky generics

## Architecture

### Package Structure

```
tom_analyzer/
├── bin/
│   └── tom_analyzer.dart          # CLI entry point
├── lib/
│   ├── tom_analyzer.dart          # Main library export
│   ├── src/
│   │   ├── analyzer/              # Analysis engine
│   │   │   ├── analyzer_runner.dart
│   │   │   ├── barrel_analyzer.dart
│   │   │   └── element_visitor.dart
│   │   ├── model/                 # Object model
│   │   │   ├── analysis_result.dart
│   │   │   ├── library_info.dart
│   │   │   ├── class_info.dart
│   │   │   ├── function_info.dart
│   │   │   ├── enum_info.dart
│   │   │   └── ...
│   │   ├── serialization/         # JSON serialization
│   │   │   ├── json_serializer.dart
│   │   │   └── json_deserializer.dart
│   │   ├── builder/               # build_runner integration
│   │   │   └── analyzer_builder.dart
│   │   └── cli/                   # CLI implementation
│   │       ├── commands.dart
│   │       └── output_formatter.dart
│   └── builder.dart               # build_runner builder export
├── doc/
│   ├── tom_analyzer_design.md     # This file
│   ├── usage_cli.md               # CLI usage guide
│   ├── usage_builder.md           # build_runner usage guide
│   └── usage_library.md           # Library usage guide
└── test/
    ├── analyzer_test.dart
    ├── model_test.dart
    └── serialization_test.dart
```

### Completeness Analysis

The object model captures all information available from the Dart analyzer:

**✅ Covered:**
- Classes (abstract, sealed, final, base, interface, mixin modifiers)
- Enums (including enhanced enums with methods/fields)
- Mixins, Extensions, Extension Types
- Functions, Methods, Constructors (generative, factory, redirecting)
- Fields, Getters, Setters (instance and static)
- Type parameters with bounds and variance
- Annotations with arguments
- Type references (nullable, dynamic, void, function types)
- Libraries, imports, exports (with show/hide)
- Documentation comments
- Source locations
- Operators and special methods
- Abstract/external/static modifiers
- Const values in annotations

**Design Decisions:**
- Use direct object references instead of string references for easier navigation
- Serialization uses unique IDs to handle circular references
- Both serialized (ID-based) and in-memory (reference-based) representations

### Object Model Hierarchy

The object model follows a **typed hierarchy with sealed base types** for type-safe navigation and pattern matching.

#### Design Principles

1. **Typed References**: Properties return specific types (ClassInfo, not Element)
2. **Covariant Returns**: Subclasses override with more specific return types
3. **Direct Navigation**: Object graph navigation without casting
4. **Sealed Base Types**: Enable exhaustive pattern matching
5. **Null Safety**: Precise nullability based on Dart semantics
6. **Direct Object References**: Classes reference each other directly (e.g., `LibraryInfo library` not `Uri libraryUri`)

#### Type Hierarchy

```
Element (sealed base class)
├── ContainerElement (sealed)
│   ├── AnalysisResult
│   ├── PackageInfo
│   └── LibraryInfo
├── DeclarationElement (sealed)
│   ├── TypeDeclaration (sealed)
│   │   ├── ClassInfo
│   │   ├── EnumInfo
│   │   ├── MixinInfo
│   │   ├── ExtensionInfo
│   │   ├── ExtensionTypeInfo
│   │   └── TypeAliasInfo
│   ├── ExecutableElement (sealed)
│   │   ├── FunctionInfo
│   │   ├── MethodInfo
│   │   ├── ConstructorInfo
│   │   ├── GetterInfo
│   │   └── SetterInfo
│   └── VariableElement (sealed)
│       ├── FieldInfo
│       └── VariableInfo (top-level)
├── ParameterInfo
└── TypeParameterInfo
```

**Pattern Matching Example:**

```dart
void processElement(Element element) {
  switch (element) {
    case ClassInfo cls:
      print('Class: ${cls.name}, superclass: ${cls.superclass?.name}');
    case FunctionInfo func:
      print('Function: ${func.name}, returns: ${func.returnType}');
    case VariableInfo variable:
      print('Variable: ${variable.name}, type: ${variable.type}');
  }
}

void processExecutable(ExecutableElement exec) {
  // Exhaustive: compiler ensures all ExecutableElement subtypes handled
  switch (exec) {
    case FunctionInfo func:
      print('Top-level function');
    case MethodInfo method:
      print('Method in ${method.declaringClass!.name}');
    case ConstructorInfo ctor:
      print('Constructor: ${ctor.name.isEmpty ? "default" : ctor.name}');
    case GetterInfo getter:
      print('Getter: ${getter.name}');
    case SetterInfo setter:
      print('Setter: ${setter.name}');
  }
}
```

#### Serialization Strategy

Serialization uses a two-phase approach with ID references:

1. **Assign unique IDs** to all elements during analysis
2. **Serialize with ID references** for cross-references (e.g., `"@lib:123"`, `"@class:456"`)
3. **Deserialize** by rebuilding object graph from IDs

**In-memory:** Direct object references (`ClassInfo.library: LibraryInfo`)
**Serialized:** ID-based references (`ClassInfo.libraryId: "@lib:123"`)

#### Top-Level: AnalysisResult

```dart
class AnalysisResult {
  /// Unique ID for serialization
  String id;
  
  /// Timestamp of analysis
  DateTime timestamp;
  
  /// Dart SDK version used
  String dartSdkVersion;
  
  /// Analyzer version
  String analyzerVersion;
  
  /// tom_analyzer schema version (for backwards compatibility)
  String schemaVersion;
  
  /// Root package being analyzed (direct reference)
  PackageInfo rootPackage;
  
  /// All packages referenced in analysis (direct references)
  Map<String, PackageInfo> packages;
  
  /// All libraries discovered (direct references)
  Map<Uri, LibraryInfo> libraries;
  
  /// All source files analyzed (direct references)
  Map<String, FileInfo> files;
  
  /// Analysis errors and warnings
  List<AnalysisError> errors;
  
  /// Metadata about the analysis run
  Map<String, dynamic> metadata;
  
  // ========================================================================
  // Convenience accessors for all element types
  // Note: These may contain duplicates from different packages/libraries
  // ========================================================================
  
  /// Get all classes from all libraries
  List<ClassInfo> get allClasses {
    return libraries.values
        .expand((lib) => lib.classes)
        .toList();
  }
  
  /// Get all enums from all libraries
  List<EnumInfo> get allEnums {
    return libraries.values
        .expand((lib) => lib.enums)
        .toList();
  }
  
  /// Get all mixins from all libraries
  List<MixinInfo> get allMixins {
    return libraries.values
        .expand((lib) => lib.mixins)
        .toList();
  }
  
  /// Get all extensions from all libraries
  List<ExtensionInfo> get allExtensions {
    return libraries.values
        .expand((lib) => lib.extensions)
        .toList();
  }
  
  /// Get all extension types from all libraries
  List<ExtensionTypeInfo> get allExtensionTypes {
    return libraries.values
        .expand((lib) => lib.extensionTypes)
        .toList();
  }
  
  /// Get all top-level functions from all libraries
  List<FunctionInfo> get allFunctions {
    return libraries.values
        .expand((lib) => lib.functions)
        .toList();
  }
  
  /// Get all top-level variables from all libraries
  List<VariableInfo> get allVariables {
    return libraries.values
        .expand((lib) => lib.variables)
        .toList();
  }
  
  /// Get all top-level getters from all libraries
  List<GetterInfo> get allGetters {
    return libraries.values
        .expand((lib) => lib.getters)
        .toList();
  }
  
  /// Get all top-level setters from all libraries
  List<SetterInfo> get allSetters {
    return libraries.values
        .expand((lib) => lib.setters)
        .toList();
  }
  
  /// Get all type aliases from all libraries
  List<TypeAliasInfo> get allTypeAliases {
    return libraries.values
        .expand((lib) => lib.typeAliases)
        .toList();
  }
  
  /// Get all annotations used across all elements
  List<AnnotationInfo> get allAnnotations {
    final annotations = <AnnotationInfo>[];
    
    for (final lib in libraries.values) {
      // Library-level annotations
      annotations.addAll(lib.annotations ?? []);
      
      // Class annotations
      for (final cls in lib.classes) {
        annotations.addAll(cls.annotations);
        // Constructor, method, field annotations
        annotations.addAll(cls.constructors.expand((c) => c.annotations));
        annotations.addAll(cls.methods.expand((m) => m.annotations));
        annotations.addAll(cls.fields.expand((f) => f.annotations));
      }
      
      // Enum annotations
      for (final enm in lib.enums) {
        annotations.addAll(enm.annotations);
      }
      
      // Function annotations
      for (final func in lib.functions) {
        annotations.addAll(func.annotations);
      }
    }
    
    return annotations;
  }
  
  // ========================================================================
  // Typed query methods with generics
  // ========================================================================
  
  // ========================================================================
  // Simple API - assumes single element, throws if not found or ambiguous
  // Use these when you expect exactly one element with the given name
  // ========================================================================
  
  /// Get class by simple name - throws if not found or if multiple matches
  /// 
  /// Use this when you know there's exactly one class with this name.
  /// Throws [ElementNotFoundException] if not found.
  /// Throws [AmbiguousElementException] if multiple classes have this name.
  ClassInfo getClassOrThrow(String name) {
    final matches = allClasses.where((c) => c.name == name).toList();
    if (matches.isEmpty) {
      throw ElementNotFoundException('No class found with name: $name');
    }
    if (matches.length > 1) {
      throw AmbiguousElementException(
        'Multiple classes found with name "$name": '
        '${matches.map((c) => c.qualifiedName).join(", ")}',
        candidates: matches.map((c) => c.qualifiedName).toList(),
      );
    }
    return matches.first;
  }
  
  /// Get enum by simple name - throws if not found or ambiguous
  EnumInfo getEnumOrThrow(String name) {
    final matches = allEnums.where((e) => e.name == name).toList();
    if (matches.isEmpty) {
      throw ElementNotFoundException('No enum found with name: $name');
    }
    if (matches.length > 1) {
      throw AmbiguousElementException(
        'Multiple enums found with name "$name": '
        '${matches.map((e) => e.qualifiedName).join(", ")}',
        candidates: matches.map((e) => e.qualifiedName).toList(),
      );
    }
    return matches.first;
  }
  
  /// Get function by simple name - throws if not found or ambiguous
  FunctionInfo getFunctionOrThrow(String name) {
    final matches = allFunctions.where((f) => f.name == name).toList();
    if (matches.isEmpty) {
      throw ElementNotFoundException('No function found with name: $name');
    }
    if (matches.length > 1) {
      throw AmbiguousElementException(
        'Multiple functions found with name "$name": '
        '${matches.map((f) => f.qualifiedName).join(", ")}',
        candidates: matches.map((f) => f.qualifiedName).toList(),
      );
    }
    return matches.first;
  }
  
  // ========================================================================
  // Advanced API - for handling multiple elements
  // ========================================================================
  
  /// Find class by qualified name (always unambiguous)
  ClassInfo? findClass(String qualifiedName) {
    return allClasses.firstWhereOrNull((c) => c.qualifiedName == qualifiedName);
  }
  
  /// Find all classes with given simple name (safe, returns empty list if none)
  List<ClassInfo> findClassesByName(String name) {
    return allClasses.where((c) => c.name == name).toList();
  }
  
  /// Find class by name in specific library
  ClassInfo? findClassInLibrary(String name, Uri libraryUri) {
    final lib = libraries[libraryUri];
    return lib?.classes.firstWhereOrNull((c) => c.name == name);
  }
  
  /// Find all classes with a specific annotation
  List<ClassInfo> findClassesWithAnnotation(String annotationName) {
    return allClasses
        .where((c) => c.hasAnnotation(annotationName))
        .toList();
  }
  
  /// Find all functions with a specific annotation
  List<FunctionInfo> findFunctionsWithAnnotation(String annotationName) {
    return allFunctions
        .where((f) => f.hasAnnotation(annotationName))
        .toList();
  }
  
  /// Generic element finder with type parameter
  T? findElement<T extends Element>(String qualifiedName) {
    if (T == ClassInfo || T == Element) {
      final result = findClass(qualifiedName);
      if (result != null) return result as T?;
    }
    if (T == FunctionInfo || T == Element) {
      final result = allFunctions.firstWhereOrNull((f) => f.qualifiedName == qualifiedName);
      if (result != null) return result as T?;
    }
    if (T == EnumInfo || T == Element) {
      final result = allEnums.firstWhereOrNull((e) => e.qualifiedName == qualifiedName);
      if (result != null) return result as T?;
    }
    // ... handle other types
    return null;
  }
  
  /// Find all elements of a specific type with an annotation
  List<T> findElementsWithAnnotation<T extends DeclarationElement>(String annotationName) {
    final results = <T>[];
    
    if (T == ClassInfo || T == DeclarationElement) {
      results.addAll(allClasses.where((c) => c.hasAnnotation(annotationName)) as Iterable<T>);
    }
    if (T == FunctionInfo || T == DeclarationElement) {
      results.addAll(allFunctions.where((f) => f.hasAnnotation(annotationName)) as Iterable<T>);
    }
    if (T == MethodInfo || T == DeclarationElement) {
      final methods = allClasses.expand((c) => c.methods);
      results.addAll(methods.where((m) => m.hasAnnotation(annotationName)) as Iterable<T>);
    }
    
    return results;
  }
  
  /// Get unique annotation names used in the codebase
  Set<String> get annotationNames {
    return allAnnotations.map((a) => a.name).toSet();
  }
  
  /// Find all elements (classes, functions, etc.) from a specific package
  PackageElements getPackageElements(String packageName) {
    final packageLibs = libraries.values
        .where((lib) => lib.package.name == packageName)
        .toList();
    
    return PackageElements(
      classes: packageLibs.expand((lib) => lib.classes).toList(),
      enums: packageLibs.expand((lib) => lib.enums).toList(),
      functions: packageLibs.expand((lib) => lib.functions).toList(),
      mixins: packageLibs.expand((lib) => lib.mixins).toList(),
      extensions: packageLibs.expand((lib) => lib.extensions).toList(),
    );
  }
}

/// Helper class for package-specific elements with typed collections
class PackageElements {
  final List<ClassInfo> classes;
  final List<EnumInfo> enums;
  final List<FunctionInfo> functions;
  final List<MixinInfo> mixins;
  final List<ExtensionInfo> extensions;
  
  PackageElements({
    required this.classes,
    required this.enums,
    required this.functions,
    required this.mixins,
    required this.extensions,
  });
  
  /// Get all type declarations
  List<TypeDeclaration> get allTypes => [
    ...classes,
    ...enums,
    ...mixins,
    ...extensions,
  ];
  
  /// Get all executables (functions, methods from classes)
  List<ExecutableElement> get allExecutables => [
    ...functions,
    ...classes.expand((c) => c.methods),
    ...classes.expand((c) => c.getters),
    ...classes.expand((c) => c.setters),
  ];
}
```

#### Exception Types

```dart
/// Thrown when an expected element is not found
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
  String toString() {
    final buffer = StringBuffer('AmbiguousElementException: $message');
    if (candidates.isNotEmpty) {
      buffer.write('\nCandidates:\n');
      for (final candidate in candidates) {
        buffer.write('  - $candidate\n');
      }
    }
    return buffer.toString();
  }
}
```

**Usage patterns:**

```dart
// Simple case - know there's exactly one User class
try {
  final userClass = analysisResult.getClassOrThrow('User');
  print('Found: ${userClass.qualifiedName}');
} on ElementNotFoundException catch (e) {
  print('User class not found');
} on AmbiguousElementException catch (e) {
  print('Multiple User classes found:');
  for (final candidate in e.candidates) {
    print('  - $candidate');
  }
  
  // Disambiguate by using qualified name
  final userClass = analysisResult.findClass(
    'package:my_app/models/user.User',
  );
}

// Safe optional access - use find methods
final userClasses = analysisResult.findClassesByName('User');
if (userClasses.length == 1) {
  final userClass = userClasses.first;
  // Use it
} else if (userClasses.isEmpty) {
  print('No User class found');
} else {
  print('Multiple User classes, need disambiguation');
}

// When you know there might be multiple, use find methods
final allUserClasses = analysisResult.findClassesByName('User');
for (final cls in allUserClasses) {
  print('Found User in: ${cls.library.uri}');
}

// Get from specific library
final modelUser = analysisResult.findClassInLibrary(
  'User',
  Uri.parse('package:my_app/models/user.dart'),
);
```

#### PackageInfo

```dart
class PackageInfo {
  /// Unique ID for serialization
  String id;
  
  /// Package name (e.g., 'tom_analyzer')
  String name;
  
  /// Package version
  String? version;
  
  /// Package root directory
  String rootPath;
  
  /// All libraries in this package (direct references)
  List<LibraryInfo> libraries;
  
  /// Dependencies (package name -> PackageInfo references)
  Map<String, PackageInfo> dependencies;
  
  /// Dev dependencies (package name -> PackageInfo references)
  Map<String, PackageInfo> devDependencies;
  
  /// Whether this is the analyzed package or a dependency
  bool isRoot;
  
  /// Pubspec.yaml metadata
  Map<String, dynamic>? pubspecMetadata;
  
  /// Parent analysis result
  AnalysisResult analysisResult;
  
  // Note: PackageInfo does NOT contain global elements directly.
  // Global/top-level elements (functions, variables, etc.) are scoped to
  // libraries, not packages. To get all globals in a package, query all
  // libraries belonging to this package.
  // Use: AnalysisResult.getPackageElements(packageName) for convenience.
}
```

#### LibraryInfo

```dart
class LibraryInfo {
  /// Unique ID for serialization
  String id;
  
  /// Library URI (package:tom_analyzer/tom_analyzer.dart)
  Uri uri;
  
  /// Package this library belongs to (direct reference)
  PackageInfo package;
  
  /// Main library source file (direct reference)
  FileInfo mainSourceFile;
  
  /// Part files belonging to this library (direct references)
  List<FileInfo> partFiles;
  
  /// All source files in this library (mainSourceFile + partFiles)
  List<FileInfo> get sourceFiles => [mainSourceFile, ...partFiles];
  
  /// Documentation comment
  String? documentation;
  
  /// Annotations on the library directive
  List<AnnotationInfo> annotations;
  
  // ========================================================================
  // Type declarations (classes, enums, mixins, extensions, type aliases)
  // ========================================================================
  
  /// All classes defined in this library
  List<ClassInfo> classes;
  
  /// All enums defined in this library
  List<EnumInfo> enums;
  
  /// All mixins defined in this library
  List<MixinInfo> mixins;
  
  /// All extensions defined in this library
  List<ExtensionInfo> extensions;
  
  /// All extension types defined in this library
  List<ExtensionTypeInfo> extensionTypes;
  
  /// Type aliases (typedef)
  List<TypeAliasInfo> typeAliases;
  
  // ========================================================================
  // Global/Top-level elements
  // Note: In Dart, these are library-scoped, not package-scoped.
  // Each library has its own namespace for top-level declarations.
  // ========================================================================
  
  /// Top-level functions (global functions in this library's namespace)
  List<FunctionInfo> functions;
  
  /// Top-level variables (global variables in this library's namespace)
  List<VariableInfo> variables;
  
  /// Top-level getters (global getters in this library's namespace)
  List<GetterInfo> getters;
  
  /// Top-level setters (global setters in this library's namespace)
  List<SetterInfo> setters;
  
  // ========================================================================
  // Import/Export declarations
  // ========================================================================
  
  /// Libraries exported by this library
  List<ExportInfo> exports;
  
  /// Libraries imported by this library
  List<ImportInfo> imports;
}
```

#### Base Element Classes (Sealed Hierarchy)

```dart
/// Base class for all elements in the analysis result
sealed class Element {
  String get id;
  String get name;
  String? get documentation;
  List<AnnotationInfo> get annotations;
  
  /// Check if element has specific annotation
  bool hasAnnotation(String annotationName) {
    return annotations.any((a) => a.name == annotationName);
  }
}

/// Base class for container elements (hold other elements)
sealed class ContainerElement extends Element {
  // Containers like AnalysisResult, PackageInfo, LibraryInfo
}

/// Base class for declared elements (have source locations)
sealed class DeclarationElement extends Element {
  String get qualifiedName;
  LibraryInfo get library;
  FileInfo get sourceFile;
  SourceLocation get location;
}

/// Base class for type declarations
sealed class TypeDeclaration extends DeclarationElement {
  List<AnnotationInfo> get annotations;
  
  // Covariant return: subclasses override with more specific type
  @override
  LibraryInfo get library;
}

/// Base class for executable elements (functions, methods, getters, setters, constructors)
sealed class ExecutableElement extends DeclarationElement {
  bool get isAsync;
  bool get isExternal;
  bool get isStatic;
  
  // Methods and constructors have parameters
  List<ParameterInfo> get parameters;
}

/// Base class for variable elements (fields, top-level variables)
sealed class VariableElement extends DeclarationElement {
  TypeReference get type;
  bool get isFinal;
  bool get isConst;
  bool get isLate;
  bool get isStatic;
}
```

#### ClassInfo

```dart
/// Class declaration element
class ClassInfo extends TypeDeclaration {
  /// Unique ID for serialization
  String id;
  
  /// Class name
  String name;
  
  /// Fully qualified name (package:tom_analyzer/src/model.ClassInfo)
  String qualifiedName;
  
  /// Source library (direct reference)
  LibraryInfo library;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Line and column in source
  SourceLocation location;
  
  /// Documentation comment
  String? documentation;
  
  /// Whether abstract
  bool isAbstract;
  
  /// Whether sealed
  bool isSealed;
  
  /// Whether final
  bool isFinal;
  
  /// Whether base
  bool isBase;
  
  /// Whether interface
  bool isInterface;
  
  /// Whether mixin
  bool isMixin;
  
  /// Superclass (if any)
  TypeReference? superclass;
  
  /// Implemented interfaces
  List<TypeReference> interfaces;
  
  /// Mixed-in types
  List<TypeReference> mixins;
  
  /// Type parameters
  List<TypeParameterInfo> typeParameters;
  
  /// Constructors
  List<ConstructorInfo> constructors;
  
  /// Methods (includes regular methods and operators)
  List<MethodInfo> methods;
  
  /// Operator overloads (subset of methods)
  List<MethodInfo> get operators => methods.where((m) => m.isOperator).toList();
  
  /// Fields
  List<FieldInfo> fields;
  
  /// Getters
  List<GetterInfo> getters;
  
  /// Setters
  List<SetterInfo> setters;
  
  /// Static members (reference to static methods/fields/getters/setters)
  ClassStaticMembers get staticMembers => ClassStaticMembers(
    methods: methods.where((m) => m.isStatic).toList(),
    fields: fields.where((f) => f.isStatic).toList(),
    getters: getters.where((g) => g.isStatic).toList(),
    setters: setters.where((s) => s.isStatic).toList(),
  );
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}

class ClassStaticMembers {
  final List<MethodInfo> methods;
  final List<FieldInfo> fields;
  final List<GetterInfo> getters;
  final List<SetterInfo> setters;
  
  ClassStaticMembers({
    required this.methods,
    required this.fields,
    required this.getters,
    required this.setters,
  });
}
```

#### EnumInfo

```dart
class EnumInfo {
  /// Unique ID for serialization
  String id;
  
  /// Enum name
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Source library (direct reference)
  LibraryInfo library;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// Enum values
  List<EnumValueInfo> values;
  
  /// Implemented interfaces
  List<TypeReference> interfaces;
  
  /// Mixed-in types
  List<TypeReference> mixins;
  
  /// Fields (for enhanced enums)
  List<FieldInfo> fields;
  
  /// Methods (for enhanced enums)
  List<MethodInfo> methods;
  
  /// Getters (for enhanced enums)
  List<GetterInfo> getters;
  
  /// Setters (for enhanced enums)
  List<SetterInfo> setters;
  
  /// Constructors (for enhanced enums)
  List<ConstructorInfo> constructors;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}

class EnumValueInfo {
  /// Unique ID
  String id;
  
  /// Value name
  String name;
  
  /// Parent enum (direct reference)
  EnumInfo parentEnum;
  
  /// Documentation
  String? documentation;
  
  /// Annotations
  List<AnnotationInfo> annotations;
  
  /// Index in enum
  int index;
}
```

#### FunctionInfo

```dart
class FunctionInfo {
  /// Unique ID for serialization
  String id;
  
  /// Function name
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Source library (direct reference)
  LibraryInfo library;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// Return type
  TypeReference returnType;
  
  /// Type parameters
  List<TypeParameterInfo> typeParameters;
  
  /// Parameters
  List<ParameterInfo> parameters;
  
  /// Whether async
  bool isAsync;
  
  /// Whether generator (sync*/async*)
  bool isGenerator;
  
  /// Whether external
  bool isExternal;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}

class MethodInfo {
  /// Unique ID
  String id;
  
  /// Method name
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Declaring class (direct reference)
  ClassInfo declaringClass;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// Return type
  TypeReference returnType;
  
  /// Type parameters
  List<TypeParameterInfo> typeParameters;
  
  /// Parameters
  List<ParameterInfo> parameters;
  
  /// Whether static
  bool isStatic;
  
  /// Whether abstract
  bool isAbstract;
  
  /// Whether external
  bool isExternal;
  
  /// Whether async
  bool isAsync;
  
  /// Whether generator
  bool isGenerator;
  
  /// Whether operator overload
  bool isOperator;
  
  /// Operator symbol if operator (e.g., '+', '==', '[]')
  String? operatorSymbol;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}

class ConstructorInfo {
  /// Unique ID
  String id;
  
  /// Constructor name (empty for default, named for named constructors)
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Declaring class (direct reference)
  ClassInfo declaringClass;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// Parameters
  List<ParameterInfo> parameters;
  
  /// Whether const
  bool isConst;
  
  /// Whether factory
  bool isFactory;
  
  /// Whether external
  bool isExternal;
  
  /// Whether redirecting
  bool isRedirecting;
  
  /// If redirecting, the target constructor (direct reference)
  ConstructorInfo? redirectTarget;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}

class FieldInfo {
  /// Unique ID
  String id;
  
  /// Field name
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Declaring class (direct reference)
  ClassInfo declaringClass;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// Field type
  TypeReference type;
  
  /// Whether static
  bool isStatic;
  
  /// Whether final
  bool isFinal;
  
  /// Whether const
  bool isConst;
  
  /// Whether late
  bool isLate;
  
  /// Whether has initializer
  bool hasInitializer;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}

class GetterInfo {
  /// Unique ID
  String id;
  
  /// Getter name
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Declaring class (direct reference, null for top-level)
  ClassInfo? declaringClass;
  
  /// Source library (direct reference, for top-level)
  LibraryInfo? library;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// Return type
  TypeReference returnType;
  
  /// Whether static
  bool isStatic;
  
  /// Whether abstract
  bool isAbstract;
  
  /// Whether external
  bool isExternal;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}

class SetterInfo {
  /// Unique ID
  String id;
  
  /// Setter name
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Declaring class (direct reference, null for top-level)
  ClassInfo? declaringClass;
  
  /// Source library (direct reference, for top-level)
  LibraryInfo? library;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// Parameter (the value being set)
  ParameterInfo parameter;
  
  /// Whether static
  bool isStatic;
  
  /// Whether abstract
  bool isAbstract;
  
  /// Whether external
  bool isExternal;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}

class VariableInfo {
  /// Unique ID
  String id;
  
  /// Variable name
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Source library (direct reference)
  LibraryInfo library;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// Variable type
  TypeReference type;
  
  /// Whether final
  bool isFinal;
  
  /// Whether const
  bool isConst;
  
  /// Whether late
  bool isLate;
  
  /// Whether has initializer
  bool hasInitializer;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}
```

#### FileInfo

```dart
class FileInfo {
  /// Unique ID for serialization
  String id;
  
  /// Absolute file path
  String path;
  
  /// Package this file belongs to (direct reference)
  PackageInfo package;
  
  /// Library this file belongs to (direct reference)
  LibraryInfo library;
  
  /// Whether this is a part file (vs main library file)
  bool isPart;
  
  /// If part file, the 'part of' directive target
  String? partOfDirective;
  
  /// Number of lines
  int lines;
  
  /// Content hash (SHA-256) for cache validation
  String contentHash;
  
  /// Last modified timestamp
  DateTime modified;
}
```

#### ExportInfo / ImportInfo

```dart
class ExportInfo {
  /// Unique ID
  String id;
  
  /// Exporting library (direct reference)
  LibraryInfo exportingLibrary;
  
  /// Exported library (direct reference)
  LibraryInfo exportedLibrary;
  
  /// Show combinator (exported symbols)
  List<String>? show;
  
  /// Hide combinator (hidden symbols)
  List<String>? hide;
  
  /// Documentation comment on export directive
  String? documentation;
}

class ImportInfo {
  /// Unique ID
  String id;
  
  /// Importing library (direct reference)
  LibraryInfo importingLibrary;
  
  /// Imported library (direct reference)
  LibraryInfo importedLibrary;
  
  /// Import prefix (as)
  String? prefix;
  
  /// Whether deferred
  bool isDeferred;
  
  /// Show combinator (imported symbols)
  List<String>? show;
  
  /// Hide combinator (hidden symbols)
  List<String>? hide;
  
  /// Documentation comment on import directive
  String? documentation;
}
```

#### MixinInfo

```dart
class MixinInfo {
  /// Unique ID
  String id;
  
  /// Mixin name
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Source library (direct reference)
  LibraryInfo library;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// On clause (superclass constraint)
  List<TypeReference> onClause;
  
  /// Implemented interfaces
  List<TypeReference> interfaces;
  
  /// Type parameters
  List<TypeParameterInfo> typeParameters;
  
  /// Methods
  List<MethodInfo> methods;
  
  /// Fields
  List<FieldInfo> fields;
  
  /// Getters
  List<GetterInfo> getters;
  
  /// Setters
  List<SetterInfo> setters;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}
```

#### ExtensionInfo

```dart
class ExtensionInfo {
  /// Unique ID
  String id;
  
  /// Extension name (may be null for unnamed extensions)
  String? name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Source library (direct reference)
  LibraryInfo library;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// Extended type
  TypeReference extendedType;
  
  /// Type parameters
  List<TypeParameterInfo> typeParameters;
  
  /// Methods
  List<MethodInfo> methods;
  
  /// Getters
  List<GetterInfo> getters;
  
  /// Setters
  List<SetterInfo> setters;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}
```

#### ExtensionTypeInfo

```dart
class ExtensionTypeInfo {
  /// Unique ID
  String id;
  
  /// Extension type name
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Source library (direct reference)
  LibraryInfo library;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// Representation type
  TypeReference representationType;
  
  /// Representation field name
  String representationFieldName;
  
  /// Implemented interfaces
  List<TypeReference> interfaces;
  
  /// Type parameters
  List<TypeParameterInfo> typeParameters;
  
  /// Constructors
  List<ConstructorInfo> constructors;
  
  /// Methods
  List<MethodInfo> methods;
  
  /// Getters
  List<GetterInfo> getters;
  
  /// Setters
  List<SetterInfo> setters;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}
```

#### TypeAliasInfo

```dart
class TypeAliasInfo {
  /// Unique ID
  String id;
  
  /// Alias name
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Source library (direct reference)
  LibraryInfo library;
  
  /// Source file (direct reference)
  FileInfo sourceFile;
  
  /// Source location
  SourceLocation location;
  
  /// Documentation
  String? documentation;
  
  /// Type parameters
  List<TypeParameterInfo> typeParameters;
  
  /// Aliased type
  TypeReference aliasedType;
  
  /// Metadata annotations
  List<AnnotationInfo> annotations;
}
```

#### Supporting Types

```dart
/// Type reference with typed resolution
class TypeReference {
  /// Unique ID
  String id;
  
  /// Type name (String, List, Map, etc.)
  String name;
  
  /// Fully qualified type name
  String qualifiedName;
  
  /// Type arguments (for generics)
  List<TypeReference> typeArguments;
  
  /// Whether nullable
  bool isNullable;
  
  /// Whether dynamic
  bool isDynamic;
  
  /// Whether void
  bool isVoid;
  
  /// Whether Function type
  bool isFunction;
  
  /// For function types
  FunctionTypeInfo? functionType;
  
  /// Library where type is defined (direct reference)
  LibraryInfo? definitionLibrary;
  
  /// Whether this is a type parameter (T, E, K, V, etc.)
  bool isTypeParameter;
  
  /// If type parameter, the bound (T extends Comparable<T>)
  TypeReference? typeParameterBound;
  
  /// If type parameter, the declaring element info (direct reference)
  TypeParameterInfo? typeParameterInfo;
  
  /// For resolved types, the full inheritance chain
  List<TypeReference>? supertypes;
  
  /// Variance for type parameters (in, out, inout)
  TypeParameterVariance? variance;
  
  // ========================================================================
  // Typed resolution methods - covariant returns
  // ========================================================================
  
  /// Try to resolve as ClassInfo (type-safe, returns null if not a class)
  ClassInfo? resolveAsClass() {
    final element = _resolvedElement;
    return element is ClassInfo ? element : null;
  }
  
  /// Try to resolve as EnumInfo
  EnumInfo? resolveAsEnum() {
    final element = _resolvedElement;
    return element is EnumInfo ? element : null;
  }
  
  /// Try to resolve as MixinInfo
  MixinInfo? resolveAsMixin() {
    final element = _resolvedElement;
    return element is MixinInfo ? element : null;
  }
  
  /// Try to resolve as TypeAliasInfo
  TypeAliasInfo? resolveAsTypeAlias() {
    final element = _resolvedElement;
    return element is TypeAliasInfo ? element : null;
  }
  
  /// Try to resolve as ExtensionTypeInfo
  ExtensionTypeInfo? resolveAsExtensionType() {
    final element = _resolvedElement;
    return element is ExtensionTypeInfo ? element : null;
  }
  
  /// Resolve as any TypeDeclaration (sealed base type)
  TypeDeclaration? resolveAsTypeDeclaration() {
    final element = _resolvedElement;
    return element is TypeDeclaration ? element : null;
  }
  
  /// Generic resolution with type parameter
  T? resolveAs<T extends TypeDeclaration>() {
    final element = _resolvedElement;
    return element is T ? element : null;
  }
  
  /// Internal storage for resolved element
  /// (Serialized as ID reference: "@class:123", "@enum:456", etc.)
  TypeDeclaration? _resolvedElement;
  
  /// Whether this type has been resolved to a declaration
  bool get isResolved => _resolvedElement != null;
  
  /// Get the resolved element (dynamic for pattern matching)
  TypeDeclaration? get resolvedElement => _resolvedElement;
  
  /// Pattern matching on resolved type
  R? matchResolved<R>({
    required R Function(ClassInfo) onClass,
    required R Function(EnumInfo) onEnum,
    required R Function(MixinInfo) onMixin,
    required R Function(TypeAliasInfo) onTypeAlias,
    required R Function(ExtensionTypeInfo) onExtensionType,
    required R Function() onUnresolved,
  }) {
    final element = _resolvedElement;
    if (element == null) return onUnresolved();
    
    return switch (element) {
      ClassInfo cls => onClass(cls),
      EnumInfo enm => onEnum(enm),
      MixinInfo mix => onMixin(mix),
      TypeAliasInfo alias => onTypeAlias(alias),
      ExtensionTypeInfo ext => onExtensionType(ext),
    };
  }
}

enum TypeParameterVariance {
  /// Covariant (out T)
  covariant,
  
  /// Contravariant (in T)
  contravariant,
  
  /// Invariant (default)
  invariant,
}

class ParameterInfo {
  /// Unique ID
  String id;
  
  /// Parameter name
  String name;
  
  /// Parameter type
  TypeReference type;
  
  /// Whether required
  bool isRequired;
  
  /// Whether named
  bool isNamed;
  
  /// Whether positional
  bool isPositional;
  
  /// Whether has default value
  bool hasDefaultValue;
  
  /// Default value (as source string)
  String? defaultValue;
  
  /// Default value (as parsed constant)
  ArgumentValue? defaultValueParsed;
  
  /// Documentation
  String? documentation;
  
  /// Annotations
  List<AnnotationInfo> annotations;
  
  /// Declaring function/method/constructor (direct reference)
  dynamic declaringCallable; // FunctionInfo | MethodInfo | ConstructorInfo
}

class FunctionTypeInfo {
  /// Unique ID
  String id;
  
  /// Return type
  TypeReference returnType;
  
  /// Type parameters
  List<TypeParameterInfo> typeParameters;
  
  /// Parameters
  List<ParameterInfo> parameters;
  
  /// Whether nullable
  bool isNullable;
}

class TypeParameterInfo {
  /// Unique ID
  String id;
  
  /// Parameter name (T, E, K, V, etc.)
  String name;
  
  /// Bound constraint (extends Comparable<T>)
  TypeReference? bound;
  
  /// Default type if not specified
  TypeReference? defaultType;
  
  /// Variance (in, out, or invariant)
  TypeParameterVariance variance;
  
  /// Whether this is a function type parameter vs class type parameter
  bool isFunctionTypeParameter;
  
  /// For recursive bounds like T extends Comparable<T>
  bool hasRecursiveBound;
  
  /// Full bound chain for complex constraints
  List<TypeReference> boundChain;
}

class SourceLocation {
  String filePath;
  int line;
  int column;
  int offset;
  int length;
}

class AnnotationInfo {
  /// Unique ID
  String id;
  
  /// Annotation name (e.g., 'override', 'deprecated', 'JsonSerializable')
  String name;
  
  /// Fully qualified name
  String qualifiedName;
  
  /// Resolved annotation class (direct reference)
  ClassInfo? resolvedClass;
  
  /// Library where annotation is defined (direct reference)
  LibraryInfo? definitionLibrary;
  
  /// Positional arguments
  List<ArgumentValue> positionalArguments;
  
  /// Named arguments
  Map<String, ArgumentValue> namedArguments;
  
  /// Whether this is a built-in annotation (override, deprecated, etc.)
  bool isBuiltIn;
  
  /// The element this annotation is on (direct reference)
  dynamic annotatedElement; // ClassInfo | MethodInfo | FieldInfo | etc.
  
  /// Location where annotation is applied
  SourceLocation location;
}

class ArgumentValue {
  /// The value (could be literal, reference, or complex expression)
  dynamic value;
  
  /// Type of the value
  TypeReference type;
  
  /// Whether this is a constant expression
  bool isConstant;
  
  /// Source representation
  String source;
}

class AnnotationTarget {
  /// Type of target (class, method, parameter, etc.)
  String targetType;
  
  /// Name of the target element
  String targetName;
  
  /// Location where annotation is applied
  SourceLocation location;
}

class AnalysisError {
  String severity; // ERROR, WARNING, INFO, LINT
  String message;
  String code;
  SourceLocation location;
  String? correction;
}
```

## Serialization Strategy

The object model uses **direct object references** for ease of use in memory, but YAML/JSON serialization requires handling circular references. We use a **hybrid tree-based serialization** approach that maximizes readability:

### Serialization Philosophy

**Owned Elements (Inlined):** Elements that "belong to" their parent are serialized inline in a tree structure:
- Library → Classes, Functions, Variables (inlined)
- Class → Methods, Fields, Constructors (inlined)
- Method → Parameters (inlined)
- TypeReference → TypeArguments (inlined)

**Cross-References (ID-based):** Elements from other packages/libraries are referenced by ID:
- ClassInfo.superclass → ID reference if from another library
- ImportInfo.importedLibrary → ID reference
- TypeReference.resolvedElement → ID reference to class/enum
- PackageInfo.dependencies → ID references to other packages

### Serialization Structure

**YAML Format (Primary):** Uses YAML for maximum readability with proper indentation and structure.

**ID Format:** `@{type}:{qualified-name}` for stable, human-readable IDs:
```yaml
# Examples:
@lib:package:tom_analyzer/tom_analyzer.dart
@class:package:tom_analyzer/model.ClassInfo
@method:package:tom_analyzer/model.ClassInfo.findClass
```

### Tree-Based YAML Example

```yaml
# analysis_result.yaml
'@id': '@result:0'
schemaVersion: '1.0.0'
timestamp: '2026-02-03T10:30:00Z'
dartSdkVersion: '3.10.4'
analyzerVersion: '8.4.1'

# Root package with inlined structure
rootPackage:
  '@id': '@package:tom_analyzer'
  name: tom_analyzer
  version: 1.0.0
  rootPath: /path/to/tom_analyzer
  isRoot: true
  
  # Dependencies are cross-references
  dependencies:
    analyzer: '@package:analyzer'
    path: '@package:path'
  
  # Libraries are owned, so inlined
  libraries:
    - '@id': '@lib:package:tom_analyzer/tom_analyzer.dart'
      uri: package:tom_analyzer/tom_analyzer.dart
      
      # Main source file (owned)
      mainSourceFile:
        '@id': '@file:lib/tom_analyzer.dart'
        path: lib/tom_analyzer.dart
        isPart: false
        lines: 150
        contentHash: sha256:abc123...
        modified: '2026-02-03T10:25:00Z'
      
      partFiles: []
      
      documentation: |
        Main library for Tom Analyzer.
        Provides comprehensive Dart code analysis.
      
      # Classes are owned by library, so inlined
      classes:
        - '@id': '@class:package:tom_analyzer/tom_analyzer.TomAnalyzer'
          name: TomAnalyzer
          qualifiedName: package:tom_analyzer/tom_analyzer.TomAnalyzer
          
          location:
            filePath: lib/tom_analyzer.dart
            line: 10
            column: 7
            offset: 250
            length: 400
          
          documentation: Main analyzer class
          isAbstract: false
          isSealed: false
          isFinal: false
          
          # Superclass is a cross-reference (from dart:core)
          superclass:
            '@ref': '@class:dart:core.Object'
            name: Object
            qualifiedName: dart:core.Object
          
          interfaces: []
          mixins: []
          typeParameters: []
          
          # Constructors are owned, inlined
          constructors:
            - '@id': '@ctor:package:tom_analyzer/tom_analyzer.TomAnalyzer.'
              name: ''
              qualifiedName: package:tom_analyzer/tom_analyzer.TomAnalyzer.
              isConst: false
              isFactory: false
              isExternal: false
              parameters: []
              annotations: []
          
          # Methods are owned, inlined
          methods:
            - '@id': '@method:package:tom_analyzer/tom_analyzer.TomAnalyzer.analyzeBarrel'
              name: analyzeBarrel
              qualifiedName: package:tom_analyzer/tom_analyzer.TomAnalyzer.analyzeBarrel
              
              location:
                filePath: lib/tom_analyzer.dart
                line: 15
                column: 10
              
              documentation: Analyzes a barrel file
              
              # Return type with cross-reference
              returnType:
                name: Future
                qualifiedName: dart:async.Future
                isNullable: false
                # Type arguments are owned (part of this type)
                typeArguments:
                  - name: AnalysisResult
                    qualifiedName: package:tom_analyzer/model.AnalysisResult
                    # Cross-reference to class in same package
                    resolvedElement: '@class:package:tom_analyzer/model.AnalysisResult'
              
              # Parameters are owned, inlined
              parameters:
                - '@id': '@param:package:tom_analyzer/tom_analyzer.TomAnalyzer.analyzeBarrel.barrelPath'
                  name: barrelPath
                  type:
                    name: String
                    qualifiedName: dart:core.String
                    isNullable: false
                  isRequired: true
                  isNamed: true
                  hasDefaultValue: false
                  annotations: []
                
                - name: workspaceRoot
                  type:
                    name: String
                    qualifiedName: dart:core.String
                    isNullable: false
                  isRequired: false
                  isNamed: true
                  hasDefaultValue: true
                  defaultValue: '.'
              
              typeParameters: []
              isAsync: true
              isStatic: false
              isAbstract: false
              isOperator: false
              annotations: []
          
          fields: []
          getters: []
          setters: []
          annotations: []
        
        # Another class in same library
        - '@id': '@class:package:tom_analyzer/model.AnalysisResult'
          name: AnalysisResult
          qualifiedName: package:tom_analyzer/model.AnalysisResult
          documentation: Comprehensive analysis results
          
          # Superclass reference to dart:core
          superclass:
            '@ref': '@class:dart:core.Object'
            name: Object
          
          # ... methods, fields, etc. inlined here
          methods:
            - name: findClass
              returnType:
                name: ClassInfo
                qualifiedName: package:tom_analyzer/model.ClassInfo
                isNullable: true
                # Reference to another class in same library
                resolvedElement: '@class:package:tom_analyzer/model.ClassInfo'
              parameters:
                - name: qualifiedName
                  type:
                    name: String
                    qualifiedName: dart:core.String
      
      # Top-level functions owned by library, inlined
      functions:
        - '@id': '@func:package:tom_analyzer/tom_analyzer.createAnalyzer'
          name: createAnalyzer
          qualifiedName: package:tom_analyzer/tom_analyzer.createAnalyzer
          returnType:
            name: TomAnalyzer
            qualifiedName: package:tom_analyzer/tom_analyzer.TomAnalyzer
            # Reference to class in same library
            resolvedElement: '@class:package:tom_analyzer/tom_analyzer.TomAnalyzer'
          parameters: []
          isAsync: false
      
      # Top-level variables
      variables:
        - '@id': '@var:package:tom_analyzer/tom_analyzer.defaultOptions'
          name: defaultOptions
          qualifiedName: package:tom_analyzer/tom_analyzer.defaultOptions
          type:
            name: AnalyzerOptions
            qualifiedName: package:tom_analyzer/options.AnalyzerOptions
          isConst: true
          isFinal: true
      
      # Imports are cross-references
      imports:
        - importingLibrary: '@lib:package:tom_analyzer/tom_analyzer.dart'
          importedLibrary: '@lib:dart:core'
          prefix: null
          isDeferred: false
          show: null
          hide: null
        
        - importingLibrary: '@lib:package:tom_analyzer/tom_analyzer.dart'
          importedLibrary: '@lib:package:analyzer/dart/analysis/analysis_context.dart'
          prefix: null
          isDeferred: false
      
      # Exports are cross-references
      exports:
        - exportingLibrary: '@lib:package:tom_analyzer/tom_analyzer.dart'
          exportedLibrary: '@lib:package:tom_analyzer/model.dart'
          show: null
          hide: null

# Other packages are cross-referenced at top level
packages:
  analyzer:
    '@id': '@package:analyzer'
    name: analyzer
    version: 8.0.0
    isRoot: false
    # Libraries list with references only (not full structure)
    libraries:
      - '@lib:package:analyzer/dart/analysis/analysis_context.dart'
      - '@lib:package:analyzer/dart/ast/ast.dart'
    # Dependencies
    dependencies:
      meta: '@package:meta'
  
  path:
    '@id': '@package:path'
    name: path
    version: 1.9.0
    isRoot: false
```

### Key Distinctions

| Relationship | Serialization | Example |
|--------------|---------------|---------|
| **Parent owns child** | Inline full object | Library → Classes → Methods |
| **Sibling reference** | ID reference | Method.returnType → Class in same library |
| **Cross-package** | ID reference | TypeReference → dart:core.String |
| **Dependency** | ID reference | Package → dependency packages |
| **Type hierarchy** | ID reference | Class.superclass → another Class |

### Benefits

1. **Readability**: Tree structure shows ownership/containment clearly
2. **Navigation**: Easy to see what belongs where without jumping between sections
3. **Diffing**: Changes to a class show all its methods in context
4. **Selective Loading**: Can load just the root package tree without dependencies
5. **Human-Editable**: YAML format is easy to read and edit manually if needed
6. **Validation**: Schema validators can check tree structure
7. **Compact**: No duplication - owned elements appear once in their parent

### ID Assignment

Every serializable object gets a unique ID based on its type and identity:

```dart
// ID format: @{type}:{index}
// Examples:
//   @lib:0 - First library
//   @class:42 - Class with index 42
//   @method:156 - Method with index 156
//   @param:789 - Parameter with index 789
```

### Serialization Process

**Phase 1: ID Assignment**
- Traverse entire object graph
- Assign sequential IDs to each element by type
- Build ID → Object and Object → ID mappings

**Phase 2: JSON Generation**
- Serialize each object with its ID
- Replace object references with ID strings
- Handle special cases (nulls, primitives, collections)

**Example:**

In-memory model:
```dart
ClassInfo myClass = ClassInfo(
  name: 'MyClass',
  library: libraryRef,  // Direct LibraryInfo reference
  superclass: TypeReference(
    name: 'BaseClass',
    resolvedElement: baseClassRef,  // Direct ClassInfo reference
  ),
);
```

Serialized JSON:
```json
{
  "@id": "@class:10",
  "name": "MyClass",
  "library": "@lib:2",
  "superclass": {
    "@id": "@typeref:45",
    "name": "BaseClass",
    "resolvedElement": "@class:8"
  }
}
```

### Deserialization Process

**Phase 1: Parse All Objects**
- Parse JSON into temporary POJOs
- Extract IDs and create ID → POJO map
- Create stub objects for each ID

**Phase 2: Resolve References**
- For each stub object, resolve ID references to actual objects
- Build complete object graph with all references intact

### Implementation Classes

```dart
class AnalysisSerializer {
  /// Serialize AnalysisResult to YAML/JSON with tree structure
  Map<String, dynamic> serialize(AnalysisResult result) {
    final context = SerializationContext();
    
    // Build tree structure with inline owned elements
    return _serializeResult(result, context);
  }
  
  Map<String, dynamic> _serializeResult(
    AnalysisResult result,
    SerializationContext context,
  ) {
    return {
      '@id': context.getId(result, 'result'),
      'schemaVersion': result.schemaVersion,
      'timestamp': result.timestamp.toIso8601String(),
      'dartSdkVersion': result.dartSdkVersion,
      'analyzerVersion': result.analyzerVersion,
      
      // Root package is owned, serialize inline with full tree
      'rootPackage': _serializePackageTree(result.rootPackage, context),
      
      // Other packages are cross-referenced with minimal info
      'packages': {
        for (final pkg in result.packages.values)
          if (!pkg.isRoot)
            pkg.name: _serializePackageReference(pkg, context),
      },
    };
  }
  
  Map<String, dynamic> _serializePackageTree(
    PackageInfo package,
    SerializationContext context,
  ) {
    return {
      '@id': context.getId(package, 'package', package.name),
      'name': package.name,
      'version': package.version,
      'rootPath': package.rootPath,
      'isRoot': package.isRoot,
      
      // Dependencies are cross-references
      'dependencies': {
        for (final entry in package.dependencies.entries)
          entry.key: context.getIdRef(entry.value, 'package', entry.key),
      },
      
      // Libraries are owned, inline full tree
      'libraries': [
        for (final lib in package.libraries)
          _serializeLibraryTree(lib, context),
      ],
    };
  }
  
  Map<String, dynamic> _serializeLibraryTree(
    LibraryInfo library,
    SerializationContext context,
  ) {
    return {
      '@id': context.getId(library, 'lib', library.uri.toString()),
      'uri': library.uri.toString(),
      
      // Main file is owned, inline
      'mainSourceFile': _serializeFile(library.mainSourceFile, context),
      
      // Part files are owned, inline
      'partFiles': [
        for (final part in library.partFiles)
          _serializeFile(part, context),
      ],
      
      'documentation': library.documentation,
      
      // Classes are owned, inline full tree with methods/fields
      'classes': [
        for (final cls in library.classes)
          _serializeClassTree(cls, context),
      ],
      
      // Enums are owned, inline
      'enums': [
        for (final enm in library.enums)
          _serializeEnumTree(enm, context),
      ],
      
      // Functions are owned, inline
      'functions': [
        for (final func in library.functions)
          _serializeFunction(func, context),
      ],
      
      // Variables are owned, inline
      'variables': [
        for (final variable in library.variables)
          _serializeVariable(variable, context),
      ],
      
      // Imports/exports are cross-references
      'imports': [
        for (final imp in library.imports)
          _serializeImport(imp, context),
      ],
      
      'exports': [
        for (final exp in library.exports)
          _serializeExport(exp, context),
      ],
    };
  }
  
  Map<String, dynamic> _serializeClassTree(
    ClassInfo cls,
    SerializationContext context,
  ) {
    return {
      '@id': context.getId(cls, 'class', cls.qualifiedName),
      'name': cls.name,
      'qualifiedName': cls.qualifiedName,
      'location': _serializeLocation(cls.location),
      'documentation': cls.documentation,
      'isAbstract': cls.isAbstract,
      'isSealed': cls.isSealed,
      'isFinal': cls.isFinal,
      
      // Superclass is a cross-reference
      'superclass': cls.superclass != null
          ? _serializeTypeReference(cls.superclass!, context)
          : null,
      
      // Interfaces are cross-references
      'interfaces': [
        for (final iface in cls.interfaces)
          _serializeTypeReference(iface, context),
      ],
      
      // Type parameters are owned, inline
      'typeParameters': [
        for (final tp in cls.typeParameters)
          _serializeTypeParameter(tp, context),
      ],
      
      // Constructors are owned, inline with parameters
      'constructors': [
        for (final ctor in cls.constructors)
          _serializeConstructor(ctor, context),
      ],
      
      // Methods are owned, inline with parameters
      'methods': [
        for (final method in cls.methods)
          _serializeMethod(method, context),
      ],
      
      // Fields are owned, inline
      'fields': [
        for (final field in cls.fields)
          _serializeField(field, context),
      ],
      
      'annotations': [
        for (final ann in cls.annotations)
          _serializeAnnotation(ann, context),
      ],
    };
  }
  
  Map<String, dynamic> _serializeTypeReference(
    TypeReference type,
    SerializationContext context,
  ) {
    final result = <String, dynamic>{
      'name': type.name,
      'qualifiedName': type.qualifiedName,
      'isNullable': type.isNullable,
    };
    
    // If resolved element exists and is from another library,
    // add cross-reference
    if (type.resolvedElement != null) {
      result['resolvedElement'] = context.getIdRef(
        type.resolvedElement!,
        _getTypeForElement(type.resolvedElement!),
        type.qualifiedName,
      );
    }
    
    // Type arguments are owned (part of this type), inline them
    if (type.typeArguments.isNotEmpty) {
      result['typeArguments'] = [
        for (final arg in type.typeArguments)
          _serializeTypeReference(arg, context),
      ];
    }
    
    return result;
  }
  
  String _getTypeForElement(dynamic element) {
    if (element is ClassInfo) return 'class';
    if (element is EnumInfo) return 'enum';
    if (element is TypeAliasInfo) return 'typedef';
    return 'unknown';
  }
}

class SerializationContext {
  final _idMap = <Object, String>{};
  int _counter = 0;
  
  /// Get or assign ID for an element
  String getId(Object obj, String type, [String? qualifier]) {
    if (_idMap.containsKey(obj)) return _idMap[obj]!;
    
    // Use qualifier for stable, human-readable IDs
    final id = qualifier != null ? '@$type:$qualifier' : '@$type:${_counter++}';
    _idMap[obj] = id;
    return id;
  }
  
  /// Get ID reference string for cross-references
  String getIdRef(Object obj, String type, [String? qualifier]) {
    return getId(obj, type, qualifier);
  }
}

class AnalysisDeserializer {
  /// Deserialize AnalysisResult from YAML/JSON
  AnalysisResult deserialize(Map<String, dynamic> data) {
    final context = DeserializationContext();
    
    // Phase 1: Parse tree and build objects
    // Owned elements are created directly from inline data
    final result = _deserializeResult(data, context);
    
    // Phase 2: Resolve cross-references
    context.resolveReferences();
    
    return result;
  }
  
  AnalysisResult _deserializeResult(
    Map<String, dynamic> data,
    DeserializationContext context,
  ) {
    final result = AnalysisResult(
      id: data['@id'],
      schemaVersion: data['schemaVersion'],
      timestamp: DateTime.parse(data['timestamp']),
      dartSdkVersion: data['dartSdkVersion'],
      analyzerVersion: data['analyzerVersion'],
    );
    
    context.register(data['@id'], result);
    
    // Deserialize root package tree (inline)
    result.rootPackage = _deserializePackageTree(
      data['rootPackage'],
      context,
    );
    
    // Register cross-referenced packages
    for (final entry in (data['packages'] as Map).entries) {
      final pkg = _deserializePackageReference(
        entry.value as Map<String, dynamic>,
        context,
      );
      result.packages[entry.key] = pkg;
    }
    
    return result;
  }
  
  PackageInfo _deserializePackageTree(
    Map<String, dynamic> data,
    DeserializationContext context,
  ) {
    final package = PackageInfo(
      id: data['@id'],
      name: data['name'],
      version: data['version'],
      rootPath: data['rootPath'],
      isRoot: data['isRoot'],
    );
    
    context.register(data['@id'], package);
    
    // Deserialize libraries tree (inline)
    package.libraries = [
      for (final libData in data['libraries'])
        _deserializeLibraryTree(libData, context),
    ];
    
    // Register dependency references for phase 2
    for (final entry in (data['dependencies'] as Map? ?? {}).entries) {
      context.addReference(
        package,
        'dependencies.${entry.key}',
        entry.value as String,
      );
    }
    
    return package;
  }
  
  // ... similar methods for deserializing other elements
}

class DeserializationContext {
  final _registry = <String, Object>{};
  final _pendingRefs = <Object, Map<String, String>>{};
  
  void register(String id, Object obj) {
    _registry[id] = obj;
  }
  
  void addReference(Object owner, String field, String targetId) {
    _pendingRefs.putIfAbsent(owner, () => {})[field] = targetId;
  }
  
  Object? resolve(String id) => _registry[id];
  
  void resolveReferences() {
    // Wire up all cross-references after tree is built
    for (final entry in _pendingRefs.entries) {
      final owner = entry.key;
      final refs = entry.value;
      
      for (final field in refs.keys) {
        final targetId = refs[field]!;
        final target = resolve(targetId);
        if (target != null) {
          _setField(owner, field, target);
        }
      }
    }
  }
  
  void _setField(Object owner, String field, Object value) {
    // Use reflection or generated code to set field
    // ...
  }
}
```

### YAML vs JSON

The serialization supports both formats since they're structurally compatible:

**YAML (Primary):**
```yaml
# analysis_result.yaml
'@id': '@result:0'
schemaVersion: '1.0.0'
rootPackage:
  name: tom_analyzer
  libraries:
    - uri: package:tom_analyzer/tom_analyzer.dart
      classes:
        - name: TomAnalyzer
          methods:
            - name: analyzeBarrel
```

**JSON (Alternative):**
```json
{
  "@id": "@result:0",
  "schemaVersion": "1.0.0",
  "rootPackage": {
    "name": "tom_analyzer",
    "libraries": [{
      "uri": "package:tom_analyzer/tom_analyzer.dart",
      "classes": [{
        "name": "TomAnalyzer",
        "methods": [{
          "name": "analyzeBarrel"
        }]
      }]
    }]
  }
}
```

Use `package:yaml` for YAML support:

```dart
import 'package:yaml/yaml.dart';

// Serialize to YAML string
String toYaml(AnalysisResult result) {
  final map = AnalysisSerializer().serialize(result);
  return YamlWriter().write(map);
}

// Deserialize from YAML string
AnalysisResult fromYaml(String yaml) {
  final map = loadYaml(yaml) as Map;
  return AnalysisDeserializer().deserialize(Map<String, dynamic>.from(map));
}
```
 
### Benefits of Direct References + ID Serialization

1. **Easy Navigation**: In-memory model allows `myMethod.declaringClass.library.package` navigation
2. **Type Safety**: Static typing with direct references (no string lookups)
3. **Serialization Efficiency**: ID-based JSON is compact and handles cycles
4. **Backwards Compatibility**: Schema version in JSON enables migration
5. **Tooling Support**: IDE autocomplete works with direct references
6. **Query Performance**: No hash lookups needed when traversing object graph

### Handling Circular References

Common circular reference patterns:
- `ClassInfo.library` ↔ `LibraryInfo.classes`
- `MethodInfo.declaringClass` ↔ `ClassInfo.methods`
- `TypeReference.resolvedElement` → `ClassInfo` ↔ `ClassInfo.superclass` → `TypeReference`
- `ParameterInfo.declaringCallable` ↔ `MethodInfo.parameters`

The ID-based serialization naturally breaks these cycles since references become strings during serialization.

## CLI Interface

### Commands

#### analyze

Analyze a Dart project or barrel file:

```bash
# Analyze a barrel file
tom_analyzer analyze lib/tom_analyzer.dart

# Analyze with specific output
tom_analyzer analyze lib/tom_analyzer.dart -o analysis.json

# Analyze multiple barrels
tom_analyzer analyze lib/tom_analyzer.dart lib/builder.dart -o analysis.json

# Analyze entire package
tom_analyzer analyze --package

# Include dependencies
tom_analyzer analyze --package --include-deps

# Pretty-print to stdout
tom_analyzer analyze lib/tom_analyzer.dart --format pretty
```

#### diff

Compare two analysis results:

```bash
tom_analyzer diff old_analysis.json new_analysis.json
```

#### query

Query analysis results:

```bash
# Find all classes
tom_analyzer query analysis.json --classes

# Find specific class
tom_analyzer query analysis.json --class AnalysisResult

# Find all public APIs
tom_analyzer query analysis.json --public-api
```

### Configuration File

**IMPORTANT:** The configuration structure in `tom_analyzer.yaml` and `build.yaml` is **identical**. The only difference is indentation level:
- `tom_analyzer.yaml`: Top-level keys
- `build.yaml`: Nested under `targets.$default.builders.tom_analyzer.options`

This allows copying configuration between files with only indentation adjustment.

#### tom_analyzer.yaml

`tom_analyzer.yaml` in project root:

```yaml
# Analysis configuration
# This EXACT structure (minus indentation) is used in build.yaml
barrels:
  - lib/tom_analyzer.dart
  - lib/builder.dart

include_dependencies: false

output_format: yaml  # yaml, json, or both

output_file: analysis_results.yaml

options:
  include_private: false
  include_implementation: false
  include_source: false
  include_locations: true
  include_documentation: true
  resolve_types: true
```

## build_runner Integration

### Builder Configuration

In `pubspec.yaml`:

```yaml
dev_dependencies:
  build_runner: ^2.4.0
  tom_analyzer:

builders:
  tom_analyzer:
    import: "package:tom_analyzer/builder.dart"
    builder_factories: ["analyzerBuilder"]
    build_extensions: {".dart": [".analysis.yaml"]}
    auto_apply: none
    build_to: source
```

In `build.yaml`:

```yaml
targets:
  $default:
    builders:
      tom_analyzer:
        enabled: true
        options:
          # IDENTICAL to tom_analyzer.yaml (just indented)
          barrels:
            - lib/tom_analyzer.dart
            - lib/builder.dart
          
          include_dependencies: false
          
          output_format: yaml
          
          output_file: analysis_results.yaml
          
          options:
            include_private: false
            include_implementation: false
            include_source: false
            include_locations: true
            include_documentation: true
            resolve_types: true
```

**Configuration Copy Pattern:**

1. Copy entire config block from `tom_analyzer.yaml`
2. Paste under `targets.$default.builders.tom_analyzer.options` in `build.yaml`
3. Adjust indentation (add 2 spaces per level)
4. Done!

**Example:**

```yaml
# tom_analyzer.yaml
barrels:
  - lib/main.dart
options:
  include_private: true

# Becomes in build.yaml:
targets:
  $default:
    builders:
      tom_analyzer:
        enabled: true
        options:
          barrels:              # +10 spaces
            - lib/main.dart     # +12 spaces
          options:              # +10 spaces
            include_private: true  # +12 spaces
```

### Usage

```bash
dart run build_runner build
```

This generates `lib/tom_analyzer.analysis.json` with analysis results.

## Library API

### Basic Usage

```dart
import 'dart:io';
import 'package:tom_analyzer/tom_analyzer.dart';
import 'package:yaml/yaml.dart';

void main() async {
  // Create analyzer
  final analyzer = TomAnalyzer();
  
  // Analyze a barrel
  final result = await analyzer.analyzeBarrel(
    barrelPath: 'lib/tom_analyzer.dart',
    workspaceRoot: '/path/to/project',
  );
  
  // Access results using direct references
  print('Found ${result.libraries.length} libraries');
  print('Found ${result.packages.length} packages');
  
  // Find specific class - returns direct reference
  final classInfo = result.findClass('AnalysisResult');
  if (classInfo != null) {
    print('Class: ${classInfo.name}');
    print('Library: ${classInfo.library.uri}');
    print('Package: ${classInfo.library.package.name}');
    print('Constructors: ${classInfo.constructors.length}');
    
    // Navigate through object graph
    for (final method in classInfo.methods) {
      print('  Method: ${method.name}');
      print('  Returns: ${method.returnType.name}');
      
      // Access resolved types
      if (method.returnType.resolvedElement != null) {
        final resolved = method.returnType.resolvedElement as ClassInfo;
        print('  Resolved to: ${resolved.qualifiedName}');
      }
    }
  }
  
  // Access global/top-level elements across all libraries
  print('\nGlobal Functions:');
  for (final func in result.allFunctions) {
    print('  ${func.name} in ${func.library.uri}');
  }
  
  print('\nGlobal Variables:');
  for (final variable in result.allVariables) {
    print('  ${variable.name} in ${variable.library.uri}');
  }
  
  // Get all elements from a specific library (direct access)
  final myLib = result.libraries.values.firstWhere(
    (lib) => lib.uri.toString().endsWith('my_lib.dart'),
  );
  print('\nLibrary: ${myLib.uri}');
  print('  Package: ${myLib.package.name}');
  print('  Main file: ${myLib.mainSourceFile.path}');
  print('  Classes: ${myLib.classes.length}');
  print('  Top-level functions: ${myLib.functions.length}');
  print('  Top-level variables: ${myLib.variables.length}');
  
  // Navigate class hierarchy using direct references
  for (final cls in myLib.classes) {
    if (cls.superclass != null && cls.superclass!.resolvedElement != null) {
      final superclass = cls.superclass!.resolvedElement as ClassInfo;
      print('${cls.name} extends ${superclass.name}');
    }
  }
  
  // Serialize to YAML (tree structure, human-readable)
  final yamlString = await result.toYaml();
  await File('analysis.yaml').writeAsString(yamlString);
  
  // Or serialize to JSON
  final jsonString = await result.toJson();
  await File('analysis.json').writeAsString(jsonString);
  
  // Load from YAML file
  final yamlContent = await File('analysis.yaml').readAsString();
  final loaded = AnalysisResult.fromYaml(yamlContent);
  
  // Now use loaded result with full object graph
  final loadedClass = loaded.findClass('AnalysisResult');
  print('Loaded class: ${loadedClass?.name}');
  print('Has ${loadedClass?.methods.length} methods');
}
```
```

### Advanced Querying

```dart
// Find all public classes in a package
final publicClasses = result.libraries
    .where((lib) => lib.packageName == 'tom_analyzer')
    .expand((lib) => lib.classes)
    .where((cls) => !cls.name.startsWith('_'));

// Find all classes with a specific annotation
final annotatedClasses = result.findClassesWithAnnotation('JsonSerializable');

// Get inheritance hierarchy
final hierarchy = result.getClassHierarchy('MyClass');

// Find all implementations of an interface
final implementations = result.findImplementations('Comparable');

// Get all dependencies of a class
final deps = result.getClassDependencies('MyClass');
```

## YAML/JSON Output Format

### Complete Example (YAML Tree Format)

```yaml
# analysis_result.yaml
'@id': '@result:0'
schemaVersion: '1.0.0'
timestamp: '2026-02-03T10:30:00Z'
dartSdkVersion: '3.10.4'
analyzerVersion: '8.4.1'

# Root package is serialized as full tree
rootPackage:
  '@id': '@package:tom_analyzer'
  name: tom_analyzer
  version: 1.0.0
  rootPath: /path/to/tom_analyzer
  isRoot: true
  
  # Dependencies are ID references
  dependencies:
    analyzer: '@package:analyzer'
  
  # Libraries are owned - full tree structure
  libraries:
    # Library 1: Main library
    - '@id': '@lib:package:tom_analyzer/tom_analyzer.dart'
      uri: package:tom_analyzer/tom_analyzer.dart
      
      # Source files are owned - inlined
      mainSourceFile:
        '@id': '@file:lib/tom_analyzer.dart'
        path: lib/tom_analyzer.dart
        isPart: false
        lines: 150
        contentHash: sha256:abc123...
        modified: '2026-02-03T10:25:00Z'
      
      partFiles: []
      
      documentation: |
        Main library for Tom Analyzer.
        Provides comprehensive Dart code analysis.
      
      annotations: []
      
      # Classes are owned - full tree with all members
      classes:
        - '@id': '@class:package:tom_analyzer/tom_analyzer.TomAnalyzer'
          name: TomAnalyzer
          qualifiedName: package:tom_analyzer/tom_analyzer.TomAnalyzer
          
          location:
            filePath: lib/tom_analyzer.dart
            line: 10
            column: 7
            offset: 250
            length: 400
          
          documentation: Main analyzer class for comprehensive code analysis
          
          isAbstract: false
          isSealed: false
          isFinal: false
          isBase: false
          isInterface: false
          isMixin: false
          
          # Superclass is ID reference (from dart:core)
          superclass:
            name: Object
            qualifiedName: dart:core.Object
            isNullable: false
            resolvedElement: '@class:dart:core.Object'
          
          interfaces: []
          mixins: []
          typeParameters: []
          
          # Constructors are owned - inlined
          constructors:
            - '@id': '@ctor:package:tom_analyzer/tom_analyzer.TomAnalyzer.'
              name: ''
              qualifiedName: package:tom_analyzer/tom_analyzer.TomAnalyzer.
              location:
                filePath: lib/tom_analyzer.dart
                line: 11
                column: 3
              documentation: Creates a new TomAnalyzer instance
              parameters: []
              isConst: false
              isFactory: false
              isExternal: false
              isRedirecting: false
              redirectTarget: null
              annotations: []
          
          # Methods are owned - inlined with all details
          methods:
            - '@id': '@method:package:tom_analyzer/tom_analyzer.TomAnalyzer.analyzeBarrel'
              name: analyzeBarrel
              qualifiedName: package:tom_analyzer/tom_analyzer.TomAnalyzer.analyzeBarrel
              
              location:
                filePath: lib/tom_analyzer.dart
                line: 15
                column: 10
                offset: 350
                length: 200
              
              documentation: |
                Analyzes a barrel file and returns comprehensive analysis results.
                
                The barrel file is the entry point for analysis.
              
              # Return type with cross-reference
              returnType:
                name: Future
                qualifiedName: dart:async.Future
                isNullable: false
                isDynamic: false
                isVoid: false
                isFunction: false
                # Type arguments are owned (part of type), inlined
                typeArguments:
                  - name: AnalysisResult
                    qualifiedName: package:tom_analyzer/model.AnalysisResult
                    isNullable: false
                    # Cross-reference to class in same package
                    resolvedElement: '@class:package:tom_analyzer/model.AnalysisResult'
                    # Definition library reference
                    definitionLibrary: '@lib:package:tom_analyzer/model.dart'
              
              # Parameters are owned - full details inlined
              parameters:
                - '@id': '@param:package:tom_analyzer/tom_analyzer.TomAnalyzer.analyzeBarrel.barrelPath'
                  name: barrelPath
                  type:
                    name: String
                    qualifiedName: dart:core.String
                    isNullable: false
                    resolvedElement: '@class:dart:core.String'
                  isRequired: true
                  isNamed: true
                  isPositional: false
                  hasDefaultValue: false
                  documentation: Path to the barrel file
                  annotations: []
                
                - '@id': '@param:package:tom_analyzer/tom_analyzer.TomAnalyzer.analyzeBarrel.workspaceRoot'
                  name: workspaceRoot
                  type:
                    name: String
                    qualifiedName: dart:core.String
                    isNullable: false
                  isRequired: false
                  isNamed: true
                  hasDefaultValue: true
                  defaultValue: "'.'"
                  documentation: Root directory of workspace
                  annotations: []
              
              typeParameters: []
              isAsync: true
              isGenerator: false
              isStatic: false
              isAbstract: false
              isExternal: false
              isOperator: false
              operatorSymbol: null
              annotations: []
          
          fields: []
          getters: []
          setters: []
          
          annotations: []
      
      # Top-level functions are owned - inlined
      functions:
        - '@id': '@func:package:tom_analyzer/tom_analyzer.createAnalyzer'
          name: createAnalyzer
          qualifiedName: package:tom_analyzer/tom_analyzer.createAnalyzer
          location:
            filePath: lib/tom_analyzer.dart
            line: 50
            column: 1
          documentation: Factory function to create a configured analyzer
          returnType:
            name: TomAnalyzer
            qualifiedName: package:tom_analyzer/tom_analyzer.TomAnalyzer
            isNullable: false
            # Reference to class in same library
            resolvedElement: '@class:package:tom_analyzer/tom_analyzer.TomAnalyzer'
          parameters: []
          typeParameters: []
          isAsync: false
          isGenerator: false
          isExternal: false
          annotations: []
      
      # Top-level variables are owned - inlined
      variables:
        - '@id': '@var:package:tom_analyzer/tom_analyzer.defaultOptions'
          name: defaultOptions
          qualifiedName: package:tom_analyzer/tom_analyzer.defaultOptions
          location:
            filePath: lib/tom_analyzer.dart
            line: 8
            column: 1
          documentation: Default analyzer options
          type:
            name: AnalyzerOptions
            qualifiedName: package:tom_analyzer/options.AnalyzerOptions
            resolvedElement: '@class:package:tom_analyzer/options.AnalyzerOptions'
          isFinal: true
          isConst: true
          isLate: false
          hasInitializer: true
          annotations: []
      
      getters: []
      setters: []
      
      # Imports are cross-references to other libraries
      imports:
        - '@id': '@import:0'
          importingLibrary: '@lib:package:tom_analyzer/tom_analyzer.dart'
          importedLibrary: '@lib:dart:async'
          prefix: null
          isDeferred: false
          show: null
          hide: null
          documentation: null
        
        - '@id': '@import:1'
          importingLibrary: '@lib:package:tom_analyzer/tom_analyzer.dart'
          importedLibrary: '@lib:package:analyzer/dart/analysis/analysis_context.dart'
          prefix: null
          isDeferred: false
          show: null
          hide: null
      
      # Exports are cross-references
      exports:
        - '@id': '@export:0'
          exportingLibrary: '@lib:package:tom_analyzer/tom_analyzer.dart'
          exportedLibrary: '@lib:package:tom_analyzer/model.dart'
          show: null
          hide: ['_internal']
          documentation: null

# Dependency packages are cross-referenced with minimal structure
packages:
  analyzer:
    '@id': '@package:analyzer'
    name: analyzer
    version: 8.0.0
    rootPath: /path/to/pub_cache/analyzer-8.0.0
    isRoot: false
    # Just list library references, not full tree
    libraries:
      - '@lib:package:analyzer/dart/analysis/analysis_context.dart'
      - '@lib:package:analyzer/dart/ast/ast.dart'
    dependencies:
      meta: '@package:meta'
    devDependencies: {}
```

### JSON Equivalent (Same Structure)

The same structure in JSON format:

```json
{
  "@id": "@result:0",
  "schemaVersion": "1.0.0",
  "timestamp": "2026-02-03T10:30:00Z",
  "dartSdkVersion": "3.10.4",
  "analyzerVersion": "8.4.1",
  "rootPackage": {
    "@id": "@package:tom_analyzer",
    "name": "tom_analyzer",
    "version": "1.0.0",
    "libraries": [
      {
        "@id": "@lib:package:tom_analyzer/tom_analyzer.dart",
        "uri": "package:tom_analyzer/tom_analyzer.dart",
        "classes": [
          {
            "@id": "@class:package:tom_analyzer/tom_analyzer.TomAnalyzer",
            "name": "TomAnalyzer",
            "methods": [
              {
                "@id": "@method:package:tom_analyzer/tom_analyzer.TomAnalyzer.analyzeBarrel",
                "name": "analyzeBarrel",
                "returnType": {
                  "name": "Future",
                  "typeArguments": [{
                    "name": "AnalysisResult",
                    "resolvedElement": "@class:package:tom_analyzer/model.AnalysisResult"
                  }]
                }
              }
            ]
          }
        ]
      }
    ]
  }
}
```

## Performance Considerations

### Caching Strategy

1. **Analysis Cache**: Store analyzer results to avoid re-analyzing unchanged files
2. **Incremental Updates**: Only re-analyze modified files
3. **Lazy Loading**: Load analysis results on-demand from JSON
4. **Memory Management**: Stream large analysis results instead of loading entirely

### Implementation

```dart
class CachedAnalyzer {
  final Map<String, CacheEntry> _cache = {};
  
  Future<AnalysisResult> analyze(String path) async {
    final file = File(path);
    final modified = await file.lastModified();
    
    final cached = _cache[path];
    if (cached != null && cached.modified == modified) {
      return cached.result;
    }
    
    // Perform analysis
    final result = await _performAnalysis(path);
    
    _cache[path] = CacheEntry(
      modified: modified,
      result: result,
    );
    
    return result;
  }
}
```

## Extension Points

### Custom Analyzers

Users can extend the analyzer:

```dart
abstract class CustomAnalyzer {
  void analyzeClass(ClassInfo classInfo);
  void analyzeFunction(FunctionInfo functionInfo);
  Map<String, dynamic> getCustomData();
}

// Usage
final analyzer = TomAnalyzer(
  customAnalyzers: [MyCustomAnalyzer()],
);
```

### Custom Serializers

```dart
abstract class CustomSerializer {
  String get key;
  dynamic serialize(dynamic value);
  dynamic deserialize(dynamic value);
}

// Usage
AnalysisResult.registerSerializer(MyCustomSerializer());
```

## Integration Examples

### D4rt Bridge Generator

```dart
// Load analysis results
final analysis = await AnalysisResult.fromFile('analysis.json');

// Generate bridges for all classes
for (final library in analysis.libraries.values) {
  for (final classInfo in library.classes) {
    final bridge = generateBridge(classInfo);
    // ... write bridge code
  }
}
```

### Documentation Generator

```dart
final analysis = await AnalysisResult.fromFile('analysis.json');

for (final library in analysis.libraries.values) {
  final markdown = generateMarkdown(library);
  await File('docs/${library.uri.path}.md').writeAsString(markdown);
}
```

## Testing Strategy

1. **Unit Tests**: Test each component independently
2. **Integration Tests**: Test full analysis pipeline
3. **Golden Tests**: Compare generated JSON against snapshots
4. **Performance Tests**: Benchmark analysis speed
5. **Regression Tests**: Ensure analysis results remain stable

## Phase 2: Reflective Runtime Model

After capturing the analysis results, **tom_analyzer** can generate executable Dart code that provides a complete reflective API. This allows runtime instantiation, method invocation, and type introspection without using dart:mirrors.

### Generated Reflection API

For each analyzed library, generate a reflection wrapper:

```dart
// Generated: lib/tom_analyzer.reflection.g.dart
class TomAnalyzerReflection {
  /// Create an instance of any class by name
  dynamic createInstance(String className, {
    String? constructorName,
    List<dynamic>? positionalArgs,
    Map<String, dynamic>? namedArgs,
  }) {
    switch (className) {
      case 'TomAnalyzer':
        return _createTomAnalyzer(constructorName, positionalArgs, namedArgs);
      case 'AnalysisResult':
        return _createAnalysisResult(constructorName, positionalArgs, namedArgs);
      default:
        throw ArgumentError('Unknown class: $className');
    }
  }
  
  /// Check if an object is instance of a class by name
  bool isInstanceOf(dynamic object, String className) {
    switch (className) {
      case 'TomAnalyzer':
        return object is TomAnalyzer;
      case 'AnalysisResult':
        return object is AnalysisResult;
      default:
        return false;
    }
  }
  
  /// Invoke a method by name
  dynamic invokeMethod(
    dynamic target,
    String methodName, {
    List<dynamic>? positionalArgs,
    Map<String, dynamic>? namedArgs,
  }) {
    if (target is TomAnalyzer) {
      return _invokeTomAnalyzerMethod(target, methodName, positionalArgs, namedArgs);
    }
    // ... other classes
    throw ArgumentError('Cannot invoke method on ${target.runtimeType}');
  }
  
  /// Get a field value by name
  dynamic getField(dynamic target, String fieldName) {
    if (target is TomAnalyzer) {
      return _getTomAnalyzerField(target, fieldName);
    }
    // ... other classes
    throw ArgumentError('Cannot get field from ${target.runtimeType}');
  }
  
  /// Set a field value by name
  void setField(dynamic target, String fieldName, dynamic value) {
    if (target is TomAnalyzer) {
      _setTomAnalyzerField(target, fieldName, value);
      return;
    }
    // ... other classes
    throw ArgumentError('Cannot set field on ${target.runtimeType}');
  }
  
  /// Get all metadata about a class
  ClassMetadata getClassMetadata(String className) {
    return _classMetadata[className] ??
        (throw ArgumentError('Unknown class: $className'));
  }
  
  /// Get all available class names
  List<String> get classNames => _classMetadata.keys.toList();
  
  /// Get all annotations on a class
  List<AnnotationInfo> getClassAnnotations(String className) {
    return getClassMetadata(className).annotations;
  }
  
  /// Find classes with specific annotation
  List<String> findClassesWithAnnotation(String annotationName) {
    return classNames
        .where((name) => getClassAnnotations(name)
            .any((ann) => ann.name == annotationName))
        .toList();
  }
}

// Generated helper methods
dynamic _createTomAnalyzer(
  String? constructorName,
  List<dynamic>? positionalArgs,
  Map<String, dynamic>? namedArgs,
) {
  positionalArgs ??= [];
  namedArgs ??= {};
  
  if (constructorName == null || constructorName.isEmpty) {
    // Default constructor
    return TomAnalyzer();
  }
  
  switch (constructorName) {
    case 'withOptions':
      return TomAnalyzer.withOptions(
        options: namedArgs['options'] as AnalyzerOptions,
      );
    default:
      throw ArgumentError('Unknown constructor: $constructorName');
  }
}

dynamic _invokeTomAnalyzerMethod(
  TomAnalyzer target,
  String methodName,
  List<dynamic>? positionalArgs,
  Map<String, dynamic>? namedArgs,
) {
  positionalArgs ??= [];
  namedArgs ??= {};
  
  switch (methodName) {
    case 'analyzeBarrel':
      return target.analyzeBarrel(
        barrelPath: namedArgs['barrelPath'] as String,
        workspaceRoot: namedArgs['workspaceRoot'] as String?,
      );
    case 'analyzePackage':
      return target.analyzePackage(
        packageRoot: namedArgs['packageRoot'] as String,
      );
    default:
      throw ArgumentError('Unknown method: $methodName');
  }
}

// Metadata about all classes
final Map<String, ClassMetadata> _classMetadata = {
  'TomAnalyzer': ClassMetadata(
    name: 'TomAnalyzer',
    qualifiedName: 'package:tom_analyzer/tom_analyzer.TomAnalyzer',
    constructors: [
      ConstructorMetadata(name: '', parameters: []),
      ConstructorMetadata(
        name: 'withOptions',
        parameters: [
          ParameterMetadata(
            name: 'options',
            type: 'AnalyzerOptions',
            isRequired: true,
            isNamed: true,
          ),
        ],
      ),
    ],
    methods: [
      MethodMetadata(
        name: 'analyzeBarrel',
        returnType: 'Future<AnalysisResult>',
        parameters: [
          ParameterMetadata(
            name: 'barrelPath',
            type: 'String',
            isRequired: true,
            isNamed: true,
          ),
          ParameterMetadata(
            name: 'workspaceRoot',
            type: 'String?',
            isRequired: false,
            isNamed: true,
          ),
        ],
      ),
    ],
    fields: [],
    annotations: [],
  ),
  // ... more classes
};
```

### Usage Examples

#### Dynamic Instance Creation

```dart
import 'package:tom_analyzer/tom_analyzer.reflection.g.dart';

void main() {
  final reflection = TomAnalyzerReflection();
  
  // Create instance dynamically
  final analyzer = reflection.createInstance('TomAnalyzer');
  
  // Invoke method dynamically
  final result = reflection.invokeMethod(
    analyzer,
    'analyzeBarrel',
    namedArgs: {'barrelPath': 'lib/my_lib.dart'},
  ) as Future<AnalysisResult>;
  
  // Type checking
  print(reflection.isInstanceOf(analyzer, 'TomAnalyzer')); // true
}
```

#### Annotation-Based Processing

```dart
// Find all classes with @JsonSerializable
final jsonClasses = reflection.findClassesWithAnnotation('JsonSerializable');

for (final className in jsonClasses) {
  final instance = reflection.createInstance(className);
  final json = reflection.invokeMethod(instance, 'toJson');
  print('$className: $json');
}
```

#### Plugin System

```dart
// Load plugins dynamically based on annotations
final plugins = reflection.findClassesWithAnnotation('TomPlugin');

for (final pluginClass in plugins) {
  final plugin = reflection.createInstance(pluginClass);
  
  // Get plugin metadata from annotation
  final metadata = reflection.getClassAnnotations(pluginClass)
      .firstWhere((a) => a.name == 'TomPlugin');
  
  final version = metadata.namedArguments['version'];
  final name = metadata.namedArguments['name'];
  
  print('Loading plugin: $name v$version');
  reflection.invokeMethod(plugin, 'initialize');
}
```

#### Form Generation from Class Metadata

```dart
// Generate UI form from class structure
Widget buildForm(String className) {
  final metadata = reflection.getClassMetadata(className);
  final fields = metadata.fields;
  
  return Form(
    child: Column(
      children: fields.map((field) {
        return TextFormField(
          decoration: InputDecoration(labelText: field.name),
          onChanged: (value) {
            // Update field dynamically
            reflection.setField(instance, field.name, value);
          },
        );
      }).toList(),
    ),
  );
}
```

### Generation Configuration

**Note:** Reflection configuration follows the same copy-paste structure as analysis configuration.

In `tom_analyzer.yaml`:

```yaml
# Reflection generation configuration
reflection:
  enabled: true
  
  output_file: lib/generated/{library_name}.reflection.dart
  
  include:
    - pattern: '**'
      exclude_private: true
  
  features:
    - instantiation
    - method_invocation
    - field_access
    - type_checking
    - metadata
    - annotations
  
  tree_shaking: true
```

In `build.yaml` (identical structure, adjusted indentation):

```yaml
targets:
  $default:
    builders:
      tom_analyzer:reflection:
        enabled: true
        options:
          reflection:
            enabled: true
            
            output_file: lib/generated/{library_name}.reflection.dart
            
            include:
              - pattern: '**'
                exclude_private: true
            
            features:
              - instantiation
              - method_invocation
              - field_access
              - type_checking
              - metadata
              - annotations
            
            tree_shaking: true
```

### CLI for Reflection Generation

```bash
# Analyze and generate reflection code
tom_analyzer reflect lib/tom_analyzer.dart -o lib/tom_analyzer.reflection.g.dart

# Generate reflection for multiple libraries
tom_analyzer reflect lib/**/*.dart --output-dir lib/generated/

# Generate with specific features
tom_analyzer reflect lib/my_lib.dart --features instantiation,metadata
```

### Type-Safe Reflection Wrappers

For better developer experience, also generate type-safe wrappers:

```dart
// Generated: lib/src/reflection/tom_analyzer_reflector.g.dart
class TomAnalyzerReflector extends Reflector<TomAnalyzer> {
  const TomAnalyzerReflector();
  
  @override
  TomAnalyzer create([List<dynamic>? positionalArgs, Map<String, dynamic>? namedArgs]) {
    return TomAnalyzer();
  }
  
  Future<AnalysisResult> analyzeBarrel(
    TomAnalyzer instance, {
    required String barrelPath,
    String? workspaceRoot,
  }) {
    return instance.analyzeBarrel(
      barrelPath: barrelPath,
      workspaceRoot: workspaceRoot,
    );
  }
  
  @override
  ClassMetadata get metadata => _tomAnalyzerMetadata;
}

// Usage
const reflector = TomAnalyzerReflector();
final analyzer = reflector.create();
final result = await reflector.analyzeBarrel(
  analyzer,
  barrelPath: 'lib/my_lib.dart',
);
```

### Integration with Existing Reflection Packages

The generated code can interoperate with:

- **reflectable**: Compatible metadata format
- **dart_mappable**: Similar code generation approach  
- **freezed**: Can read freezed annotations and generate compatible code

### Performance Considerations

1. **Tree Shaking**: Only generate reflection for used classes
2. **Lazy Loading**: Generate separate files per library
3. **Compile-Time**: All reflection is generated at compile-time (no mirrors)
4. **Type Safety**: Generated code is fully type-checked

### Roadmap

### Phase 1: Core Functionality (v0.1.0)

- [ ] Basic analyzer implementation
- [ ] Core object model (classes, functions, enums)
- [ ] Full annotation support
- [ ] JSON serialization/deserialization
- [ ] CLI with analyze command
- [ ] Unit tests

### Phase 2: Reflective Runtime Model (v0.2.0)

- [ ] Reflection code generation
- [ ] Dynamic instantiation API
- [ ] Method invocation API
- [ ] Field access API
- [ ] Annotation queries
- [ ] Type-safe reflector wrappers
- [ ] CLI with reflect command
- [ ] Integration tests

### Phase 3: Extended Features (v0.3.0)

- [ ] Full object model (mixins, extensions, etc.)
- [ ] build_runner integration
- [ ] Caching and incremental analysis
- [ ] Query API
- [ ] Documentation

### Phase 4: Advanced Features (v1.0.0)

- [ ] Dependency analysis
- [ ] Type hierarchy analysis
- [ ] Custom analyzers API
- [ ] Performance optimizations
- [ ] Comprehensive test coverage

## Dependencies

```yaml
dependencies:
  analyzer: ^8.0.0
  path: ^1.9.0
  yaml: ^3.1.2  # For YAML serialization/deserialization
  json_annotation: ^4.9.0
  args: ^2.5.0
  
dev_dependencies:
  build_runner: ^2.4.0
  json_serializable: ^6.8.0
  test: ^1.25.0
```

**Key Dependency: `package:yaml`**
- Primary serialization format for readability
- Compatible with JSON (can convert between formats)
- Human-editable output files
- Better for diffs and version control

## Analyzer vs Compiler: Technical Foundation

### Why Use the Dart Analyzer?

The Dart analyzer (`package:analyzer`) is the correct foundation because:

1. **Semantic Analysis**: Provides full type resolution, not just syntax
2. **Incomplete Code Support**: Can analyze code that doesn't compile (great for IDEs)
3. **Incremental**: Designed for repeated analysis (though we don't use this)
4. **Element Model**: Rich API for accessing resolved types, not just AST

### Analyzer Modes

The analyzer has several resolution modes:

1. **Full Resolution** (what we'll use)
   - Resolves all types
   - Resolves all imports/exports
   - Provides complete element information
   - **Can handle non-compiling code**

2. **Partial Resolution**
   - Faster but incomplete
   - May miss some type information

3. **Summary Resolution**
   - API-level only
   - Skips implementation details

We use **full resolution mode** but generate output that:
- **Is compilable** (even if source isn't)
- **Is stable** (doesn't change with analyzer updates)
- **Is complete** (includes all resolved type information)

### Isolation Strategy

To protect against analyzer API changes:

```dart
// Internal adapter layer
class AnalyzerAdapter {
  /// Version-specific adapter
  static AnalyzerAdapter create(String analyzerVersion) {
    // Return version-specific implementation
    if (analyzerVersion.startsWith('8.')) {
      return AnalyzerAdapter_v8();
    } else if (analyzerVersion.startsWith('9.')) {
      return AnalyzerAdapter_v9();
    }
    // Default to latest
    return AnalyzerAdapter_latest();
  }
  
  /// Extract class info (version-independent signature)
  ClassInfo extractClassInfo(ClassElement element);
  
  /// Extract type info (version-independent signature)
  TypeReference extractTypeInfo(DartType type);
}
```

### Type Parameter Resolution Strategy

The analyzer handles complex cases like:

```dart
// Recursive bounds
class MyClass<T extends Comparable<T>> { }

// Multiple bounds  
class MyClass<T extends A & B> { }

// Nested generics
class MyClass<T extends List<Map<String, T>>> { }

// Variance
class MyClass<out T, in E> { }
```

Our approach:
1. **Capture full bound information** including recursive references
2. **Resolve substitutions** for instantiated types
3. **Track variance** for sound null safety
4. **Preserve original vs resolved** for both source code generation and runtime use

### Why Not the Dart Compiler?

The Dart compiler (front_end/kernel):

**Pros**:
- Definitive type checking
- Generates executable code

**Cons**:
- **Requires compilable code** (blocker for our use case)
- Less accessible API

---

## Implementation Readiness Assessment

### Status Overview

| Component | Status | Completeness | Priority | Blockers |
|-----------|--------|--------------|----------|----------|
| **Core Object Model** | 🟢 Design Complete | 95% | P0 | None |
| **Sealed Base Classes** | 🟢 Design Complete | 100% | P0 | None |
| **Type Hierarchy** | 🟢 Design Complete | 100% | P0 | None |
| **Exception Types** | 🟢 Design Complete | 100% | P0 | None |
| **Serialization (YAML)** | 🟡 Design Complete | 90% | P0 | Schema validation |
| **Serialization (JSON)** | 🟢 Design Complete | 100% | P1 | None |
| **Analysis Engine** | 🔴 Not Designed | 30% | P0 | Analyzer API details |
| **Element Visitor** | 🔴 Not Designed | 20% | P0 | Traversal strategy |
| **Type Resolution** | 🔴 Not Designed | 40% | P0 | Complex generics |
| **CLI Tool** | 🟡 Design Complete | 80% | P1 | None |
| **build_runner Builder** | 🟡 Design Complete | 75% | P1 | Builder lifecycle |
| **Configuration System** | 🟢 Design Complete | 100% | P1 | None |
| **Reflection Generator** | 🟡 Design Complete | 70% | P2 | Code gen templates |
| **ReflectionModel Bridge** | 🟡 Design Complete | 60% | P2 | Type mapping |
| **Tests** | 🔴 Not Designed | 0% | P0 | Test strategy |
| **Documentation** | 🟡 Partial | 60% | P1 | Usage examples |

**Legend:**
- 🟢 Ready for implementation
- 🟡 Design complete, needs refinement
- 🔴 Significant design work needed
- P0: Critical path
- P1: Important
- P2: Nice to have

### Phase 1: Core Foundation (Ready to Start ✅)

**Estimated effort:** 2-3 weeks

**Tasks:**
1. ✅ **Sealed base classes** (Element, ContainerElement, DeclarationElement, etc.)
   - Implementation: ~2 days
   - All interfaces defined
   - Clear inheritance hierarchy

2. ✅ **Exception types** (ElementNotFoundException, AmbiguousElementException)
   - Implementation: ~1 day
   - Complete specification

3. ✅ **Info classes structure** (ClassInfo, FunctionInfo, etc.)
   - Implementation: ~5 days
   - All properties defined
   - Direct reference navigation
   - Need: Constructor implementations

4. 🟡 **TypeReference with resolution** (partial)
   - Implementation: ~3 days
   - Type-safe resolution methods designed
   - Need: Actual resolution logic from analyzer

5. ✅ **AnalysisResult with query methods**
   - Implementation: ~3 days
   - All query methods specified
   - Simple and advanced API defined

**Blockers:** None
**Dependencies:** None
**Can start immediately:** Yes

### Phase 2: Analysis Engine (Design Incomplete 🔴)

**Estimated effort:** 3-4 weeks

**Missing design elements:**

1. **Analyzer initialization and context**
   - How to create AnalysisContext
   - SDK resolution
   - Package resolution
   - Workspace configuration

2. **Element traversal strategy**
   - Which analyzer visitor to use
   - How to handle part files
   - Export resolution
   - Import chain following

3. **Type resolution implementation**
   - Generic type parameter substitution
   - Bounds checking and inference
   - Function type handling
   - Type alias expansion

4. **Annotation parsing**
   - Const expression evaluation
   - Argument value extraction
   - Complex argument types (lists, maps, etc.)

5. **Error handling**
   - Partial analysis on errors
   - Error recovery strategies
   - Validation reporting

**Required before implementation:**
- Study package:analyzer API in detail
- Create prototype for type resolution
- Define visitor pattern for element traversal
- Specify error handling behavior

### Phase 3: Serialization (Mostly Ready ✅)

**Estimated effort:** 1-2 weeks

**Tasks:**
1. ✅ **ID generation and assignment**
   - Implementation: ~1 day
   - Strategy defined (unique IDs per element)

2. ✅ **Tree-based YAML serialization**
   - Implementation: ~3 days
   - Format specified
   - Inline vs cross-reference rules defined

3. ✅ **JSON serialization (alternative)**
   - Implementation: ~2 days
   - Format specified

4. 🟡 **Deserialization with object graph reconstruction**
   - Implementation: ~4 days
   - Need: ID resolution algorithm
   - Need: Circular reference handling

5. 🟡 **Schema validation**
   - Implementation: ~2 days
   - Need: JSON Schema for validation
   - Need: DocSpecs schema integration

**Blockers:** 
- Schema definitions (can be done in parallel)

### Phase 4: CLI & Build Integration (Ready ✅)

**Estimated effort:** 1-2 weeks

**Tasks:**
1. ✅ **CLI argument parsing** (args package)
   - Implementation: ~2 days
   - Commands specified

2. ✅ **Configuration loading** (YAML parsing)
   - Implementation: ~1 day
   - Structure defined
   - Copy-paste compatible with build.yaml ✅

3. 🟡 **build_runner builder implementation**
   - Implementation: ~3 days
   - Need: Builder lifecycle hooks
   - Need: Incremental build strategy

4. ✅ **Output formatting** (console, files)
   - Implementation: ~2 days
   - Formats specified

**Blockers:**
- Need to understand build_runner lifecycle

### Phase 5: Reflection Generation (Design Complete, Details Needed 🟡)

**Estimated effort:** 3-4 weeks

**Tasks:**
1. ✅ **Parameterized mirror design**
   - Architecture complete
   - Pattern from tom_reflection

2. 🟡 **Code generation templates**
   - Implementation: ~5 days
   - Need: Dart code generation best practices
   - Need: Template structure for constructors/methods

3. 🟡 **ReflectorData structure generation**
   - Implementation: ~3 days
   - Need: Index generation algorithm
   - Need: Optimization strategy

4. 🟡 **ReflectionModel bridge**
   - Implementation: ~4 days
   - Need: Type mapping strategy
   - Need: Runtime type resolution

**Blockers:**
- Phase 2 (Analysis Engine) must be complete
- Phase 3 (Serialization) must be complete

### Phase 6: Testing (Not Designed 🔴)

**Estimated effort:** 2-3 weeks

**Missing design:**
- Test strategy (unit, integration, e2e)
- Test fixtures (sample Dart code)
- Test coverage targets
- Golden file strategy for serialization

**Required:**
- Define test structure
- Create sample projects for testing
- Specify expected outputs

### Critical Path Analysis

```
Phase 1 (Core) ──┐
                 ├──> Phase 2 (Engine) ──> Phase 3 (Serialization) ──┐
Phase 4 (CLI) ───┤                                                    ├──> Phase 5 (Reflection)
                 └──────────────────────────────────────────────────────┘

Phase 6 (Testing) - Can run in parallel with all phases
```

**Total estimated time:** 12-16 weeks (3-4 months)

### Immediate Next Steps

**Week 1-2: Core Model Implementation**
1. Create sealed base classes
2. Implement all Info classes with properties
3. Implement exception types
4. Create basic AnalysisResult with query methods
5. Write unit tests for object model

**Week 3-4: Analysis Engine Design**
1. Study package:analyzer API thoroughly
2. Create design document for analysis engine
3. Prototype type resolution
4. Define element visitor pattern
5. Specify error handling

**Week 5-6: Analysis Engine Implementation**
1. Implement analyzer initialization
2. Implement element visitor
3. Implement type resolution
4. Implement annotation parsing
5. Write tests

**Week 7-8: Serialization**
1. Implement ID generation
2. Implement YAML serialization
3. Implement deserialization
4. Add schema validation
5. Write serialization tests

### Risk Assessment

| Risk | Severity | Likelihood | Mitigation |
|------|----------|------------|------------|
| Analyzer API complexity | High | High | Early prototyping, incremental approach |
| Type resolution edge cases | High | Medium | Comprehensive test suite, reference analyzer behavior |
| Performance on large codebases | Medium | Medium | Profiling, caching, incremental analysis |
| Breaking changes in analyzer package | Medium | Medium | Adapter layer, version pinning |
| Reflection code gen complexity | High | Low | Follow tom_reflection pattern closely |
| Serialization of circular refs | Medium | Low | Well-defined ID system |

### Conclusion

**Can we start implementation?** 
✅ **Yes, Phase 1 can start immediately**

**What's ready:**
- Complete object model specification
- Type hierarchy with sealed classes
- API design (simple and advanced)
- Exception handling
- Configuration structure (copy-paste compatible ✅)
- Serialization format

**What needs more work:**
- Analysis engine details (interaction with package:analyzer)
- Type resolution algorithm specifics
- Test strategy and fixtures
- Code generation templates

**Recommendation:**
1. **Start Phase 1 now** (Core Model) - fully specified, low risk
2. **Prototype analysis engine** in parallel - identify unknowns early
3. **Complete Phase 2 design** before implementing serialization
4. **Defer reflection generation** until core is stable

**Confidence level:** 🟢 High for Phase 1, 🟡 Medium for Phases 2-4, 🟡 Medium for Phase 5
- Tightly coupled to dart2js/dart2native
- Not designed for tooling

**Decision**: Use analyzer for analysis, generate our own stable format

## Alternatives Considered

### analyzer_plugin

**Pros**: Deep integration with analyzer
**Cons**: Complex, requires language server setup

**Decision**: Not suitable for standalone tool

### package:code_builder

**Pros**: Code generation utilities
**Cons**: Focused on generation, not analysis

**Decision**: Complementary, may use for output generation

### Custom AST visitor

**Pros**: Full control
**Cons**: Reinventing wheel

**Decision**: Use analyzer package's element model + AST where needed

## Open Questions

1. **Scope**: Should we analyze all transitive dependencies or just direct imports?
   - **Decision**: Make it configurable, default to direct imports only

2. **Performance**: How to handle very large projects?
   - **Decision**: Caching only (no incremental updates)

3. **Versioning**: How to handle analyzer API changes?
   - **Decision**: Use adapter layer, maintain backwards compatibility in JSON schema

4. **Private APIs**: Include private members in analysis?
   - **Decision**: Make it configurable, default to public only

5. **Source code**: Include actual source code in output?
   - **Decision**: Optional, disabled by default for size reasons

6. **Duplicate handling**: How to handle same class name from different packages?
   - **Decision**: Keep all, provide qualified name filtering, let consumer decide

7. **Type parameter inference**: Should we include inferred types or just declared?
   - **Decision**: Include both - declared for source generation, inferred for runtime

## Conclusion

tom_analyzer provides a comprehensive solution for capturing and reusing Dart analyzer results. The three-mode approach (CLI, builder, library) makes it flexible for different use cases, while the JSON serialization enables offline consumption of analysis data.

The design prioritizes:
- **Completeness**: Capture all relevant analyzer information
- **Usability**: Clean APIs for both producers and consumers
- **Performance**: Efficient analysis with caching
- **Extensibility**: Hooks for custom analysis

This enables downstream tools to work with rich type information without expensive re-analysis.
