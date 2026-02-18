# Tom Analyzer Reflection User Guide

This guide shows how to generate and consume reflection output from `tom_analyzer`.

## Analyzer vs Reflection

The `tom_analyzer` package provides two related but distinct capabilities:

| Capability | Input | Follows | Output |
|------------|-------|---------|--------|
| **Analysis** | Barrel files / packages | Imports, exports, re-exports | Analysis data (JSON, YAML) |
| **Reflection** | Entry points | Imports only | Dart reflection file (`.r.dart`) |

This guide covers **reflection generation**. For analysis, see the separate analyzer documentation.

## What gets generated

The reflection generator produces a **single Dart file** per entry point. It contains a `reflectionApi` instance with:

- Classes, enums, mixins, extensions, extension types, and type aliases
- Top-level globals (functions, variables, getters, setters)
- Class members (constructors, methods, fields, getters, setters)
- Parameters and type parameters
- Annotations and metadata
- Type relationships (superclass, interfaces, mixins, applied extensions)

Documentation strings and source locations are intentionally omitted. Private members are excluded by default to avoid library privacy violations.

**Important:** There is always exactly ONE reflection file per entry point. This ensures a single, authoritative source of reflection data for your application.

## Output file naming

The reflection output file is named based on the entry point or explicitly configured:

| Scenario | Output Path |
|----------|-------------|
| Default (entry point) | `lib/my_app.dart` → `lib/my_app.r.dart` |
| Explicit output | Specified via `output` in config or `--output` on CLI |
| Binary entry point | `bin/server.dart` → `bin/server.r.dart` |

The output always uses the `.r.dart` extension. For multi-entry-point projects (e.g., separate CLI and server), each entry point generates its own reflection file.

## CLI usage

Run reflection generation directly from the CLI:

```bash
# Basic: uses default output path (<entry_point>.r.dart)
dart run tom_analyzer reflect \
  --config tom_analyzer.yaml \
  --entry lib/my_app.dart

# Explicit output path
dart run tom_analyzer reflect \
  --config tom_analyzer.yaml \
  --entry lib/my_app.dart \
  --output lib/reflection

# Multiple entry points (generates separate files)
dart run tom_analyzer reflect \
  --config tom_analyzer.yaml \
  --entry bin/cli.dart \
  --entry bin/server.dart
```

Notes:
- If `--output` is omitted, the default output is `<entry_point>.r.dart`.
- The output path is always normalized to end with `.r.dart`.

## Configuration file

Use `tom_analyzer.yaml` in your package root.

### Basic configuration

```yaml
# Entry point(s) for analysis - determines what gets reflected
entry_points:
  - lib/my_app.dart

# Output file (optional, base name). Defaults to <entry_point>.r.dart
# Extension .r.dart is always added automatically
output: lib/my_app
```

### Filtering configuration

Filters control what gets included and excluded. **All elements reachable from entry points are included by default** (this cannot be turned off). Filters then expand or shrink this set.

```yaml
entry_points:
  - lib/my_app.dart

output: lib/my_app

# Filters are processed in order
filters:
  # Filter 1: Exclude framework packages
  - exclude:
      packages:
        - flutter
        - flutter_*        # Wildcard matching
        - dart:*           # Dart SDK
  
  # Filter 2: Also include any class with @Entity annotation
  #           (even if not directly reachable from entry point)
  - include:
      annotations:
        - 'package:my_app/models.dart#Entity'
  
  # Filter 3: Exclude test-only code by path
  - exclude:
      paths:
        - '**/test/**'
        - '**/*_test.dart'
```

### Individual element inclusion/exclusion

For fine-grained control, you can include or exclude individual elements using a hide/show style syntax:

```yaml
filters:
  - include:
      # Include specific elements (even if not reachable)
      elements:
        - 'package:my_shared/models.dart#User'
        - 'package:my_shared/models.dart#Address'
  
  - exclude:
      # Exclude specific elements (even if reachable)
      elements:
        - 'package:my_app/internal.dart#_InternalHelper'
```

### Transitive dependency inclusion

When a type is included (by reachability, annotation, or other filter), its **dependencies are automatically included** as well. This behavior is controlled by the `dependency_config` section.

### dependency_config

The `dependency_config` section specifies what "and dependencies" means when elements are included. **All options default to enabled** - only specify options you want to change:

```yaml
# Default: include all dependencies (no configuration needed)
# dependency_config: {}  # or omit entirely

# Example: limit external package depth
dependency_config:
  superclasses:
    external_depth: 2                # Follow into max 2 external packages deep
    exclude_types: [Object, Enum]    # Stop at these types
```

**Full reference (all defaults shown):**

```yaml
dependency_config:
  # Superclass chain inclusion
  superclasses:
    enabled: true                    # Include superclasses
    depth: -1                        # -1 = unlimited, 0 = none, N = N levels (class hierarchy)
    external_depth: 2                # Max packages deep to follow (e.g., 2 = package → dep → dep's dep)
    # exclude_types: []              # Stop at these types (don't include them)
  
  # Interface inclusion
  interfaces:
    enabled: true                    # Include implemented interfaces
    external: true                   # Include interfaces from external packages
  
  # Mixin inclusion
  mixins:
    enabled: true                    # Include applied mixins
    external: true                   # Include mixins from external packages
  
  # Type argument inclusion (generics)
  type_arguments:
    enabled: true                    # Include types used as generic arguments
    external: true                   # Include external type arguments
  
  # Type annotation inclusion (field types, parameter types, return types)
  type_annotations:
    enabled: true                    # Include types used in fields/params/returns
    transitive: false                # Follow annotations of annotations
    external: true                   # Include external annotation types
  
  # Subtype inclusion (less common, opt-in)
  subtypes:
    enabled: false                   # Include subtypes of covered classes
```

**Depth terminology:**

| Setting | Meaning | Example |
|---------|---------|---------|
| `depth: N` | Class hierarchy levels | `depth: 2` = MyClass → Parent → Grandparent |
| `external_depth: N` | Package dependency levels | `external_depth: 2` = my_app → pkg_a → pkg_b |

**Key behaviors:**

- **Superclasses**: If a class is included, its superclass chain is included up to the configured depth
- **Interfaces**: If a class implements an interface, that interface is included
- **Mixins**: If a class applies a mixin, that mixin is included
- **Type arguments**: If `List<User>` is used, `User` is included
- **Type annotations**: If a field has type `Address`, `Address` is included

### coverage_config

The `coverage_config` section specifies what reflection support to generate for covered elements. **All options default to enabled** - only specify options you want to change:

```yaml
# Default: full coverage (no configuration needed)
# coverage_config: {}  # or omit entirely

# Example: customize only what differs from defaults
coverage_config:
  constructors:
    pattern: 'from*'                 # Only fromX constructors (fromJson, fromMap, etc.)
    unnamed: true                    # Also include unnamed constructor
  top_level:
    enabled: false                   # Skip global functions
  declarations:
    default_values: true             # Include default values (expensive, default: false)
```

**Full reference (all defaults shown):**

```yaml
coverage_config:
  instance_members:
    enabled: true                    # Generate invokers for instance members
    # pattern: ''                    # Glob pattern (empty/omitted = all)
    # annotations: []                # Only members with these annotations
    # exclude_inherited: false       # Exclude inherited members
  
  static_members:
    enabled: true                    # Generate invokers for static members
  
  constructors:
    enabled: true                    # Generate invokers for constructors
    # pattern: ''                    # e.g., 'from*' for fromJson, fromMap, etc.
    unnamed: true                    # Include unnamed constructor
  
  top_level:
    enabled: true                    # Generate invokers for top-level members
  
  metadata:
    enabled: true                    # Include metadata in reflection output
  
  type_info:
    enabled: true                    # Include type mirrors
    relations: true                  # Include superclass/interface/mixin relationships
    reflected_type: true             # Support reflectedType property
  
  declarations:
    enabled: true                    # Include declaration lists
    parameters: true                 # Include parameter info
    default_values: false            # Include default values (expensive)
```

**Coverage vs Dependencies:**

| Config | Purpose | Example |
|--------|---------|---------|
| `dependency_config` | What types to include | "Include superclasses up to 2 levels" |
| `coverage_config` | What invokers to generate | "Generate invokers for constructors matching `^from.*`" |

A type can be **included** (appears in reflection data) but not **covered** (no invoker generated). This allows metadata-only reflection for external types.

### Global defaults

To avoid repetition, you can specify global settings that apply before any filters. These provide package-level boundaries for reflection generation.

```yaml
# Global defaults - applied before filters
defaults:
  # Packages to exclude from reflection (even if reachable)
  exclude_packages:
    - dart:*
    - flutter
    - flutter_*
  
  # Additional packages to include (even if not reachable from entry point)
  include_packages:
    - my_shared_models
  
  # Annotations that always trigger inclusion
  include_annotations:
    - Reflectable
    - Entity

# Filters refine the set further
filters:
  - include:
      annotations:
        - 'package:my_app/annotations.dart#Serializable'  # Added to global
  - exclude:
      paths:
        - '**/test/**'
```

### Filter options

Each filter can have these properties:

```yaml
filters:
  - include:                          # or 'exclude:'
      # By package (glob syntax)
      packages:
        - my_app
        - my_shared_*
      
      # By annotation (see Annotation Matching below)
      annotations:
        - Reflectable                 # Short name if unambiguous
        - 'package:my_app/a.dart#Entity'  # Full URI if needed
        - 'Entity(tableName: *)'      # With field matching (glob)
      
      # By file path pattern (glob syntax)
      paths:
        - 'lib/models/**'
        - 'lib/services/*.dart'
      
      # By type name pattern (glob syntax)
      types:
        - '*Service'
        - '*Repository'
      
      # By individual element (hide/show style)
      elements:
        - 'package:my_app/models.dart#User'
        - 'package:my_app/models.dart#Address'

# Global settings
include_private: false                # Include private members (default: false)
```

### Example configurations

**Minimal (covers everything reachable from entry point):**

```yaml
entry_points:
  - lib/my_app.dart
```

**Annotation-based (covers only annotated types and their dependencies):**

```yaml
entry_points:
  - lib/my_app.dart

filters:
  - include:
      annotations:
        - 'package:my_app/annotations.dart#Reflectable'
```

This scans all code reachable from the entry point for `@Reflectable` annotations, but only includes annotated elements (plus their transitive dependencies like superclasses and field types).

**Extra annotated types (beyond reachable):**

```yaml
entry_points:
  - lib/main.dart

filters:
  # Also include @Entity classes (even if not directly reachable)
  - include:
      annotations:
        - 'package:my_app/models.dart#Entity'
```

**Package-scoped (exclude frameworks):**

```yaml
entry_points:
  - lib/my_app.dart

filters:
  - exclude:
      packages:
        - flutter
        - flutter_*
        - dart:*
        - build_runner
        - analyzer
```

**Combined (exclusions and path filters):**

```yaml
entry_points:
  - lib/main.dart

filters:
  # Exclude SDK and framework
  - exclude:
      packages:
        - dart:*
        - flutter
  
  # Exclude test code by path
  - exclude:
      paths:
        - '**/test/**'
```

**Complete example with all configuration sections:**

```yaml
# tom_analyzer.yaml - Full Reflection Configuration Example

entry_points:
  - lib/my_app.dart

output: lib/my_app

# What elements to scan and include
filters:
  - include:
      annotations:
        - 'package:my_app/annotations.dart#Reflectable'
  - exclude:
      packages:
        - dart:*
        - flutter

# What "and dependencies" means for included elements
dependency_config:
  superclasses:
    enabled: true
    external_depth: 2
    exclude_types: [Object]
  interfaces:
    enabled: true
    external: true
  mixins:
    enabled: true
  type_annotations:
    enabled: true
    transitive: false

# What reflection support to generate for covered elements
coverage_config:
  instance_members:
    enabled: true
  static_members:
    enabled: true
  constructors:
    enabled: true
    pattern: 'from*'                 # Only fromX constructors (fromJson, fromMap, etc.)
    unnamed: true                    # Also include unnamed constructor
  top_level:
    enabled: false                   # Skip global functions
  metadata:
    enabled: true
  type_info:
    enabled: true
    relations: true

# Global settings
include_private: false
```

## build_runner usage

Add the reflection builder to `build.yaml`:

```yaml
targets:
  $default:
    builders:
      tom_analyzer:tom_analyzer_reflection:
        options:
          entry_points:
            - lib/my_app.dart
          output: lib/my_app
          filters:
            - exclude:
                packages:
                  - flutter
                  - dart:*
```

Then run:

```bash
dart run build_runner build
```

## Consuming the reflection index

After generation, import the `.r.dart` file and use the `reflectionApi` instance:

```dart
import 'my_app.r.dart';

void main() {
  final cls = reflectionApi.findClassByName('MyService');
  print('Classes: ${reflectionApi.allClasses.length}');
  print('First class: ${reflectionApi.allClasses.first.qualifiedName}');
  print('Find MyService: ${cls?.qualifiedName}');
}
```

## API overview

```dart
import 'my_app.r.dart';

void main() {
  // Find by name or type
  final cls = reflectionApi.findClassByName('MyService');
  final typed = reflectionApi.findClassByType<MyService>();
  
  if (cls != null) {
    // Create instances
    final instance = cls.newInstance();
    
    // Invoke methods
    cls.invokeMethod(instance, 'doWork', ['arg1', 42]);
    
    // Access properties
    final value = cls.getProperty(instance, 'someValue');
    cls.setProperty(instance, 'someValue', 'newValue');
    
    // Static methods
    cls.invokeStatic('someStaticMethod', []);
  }

  // Type hierarchy queries
  final isSubclass = reflectionApi.isSubclassOf(
    'package:my_app/my_app.dart.MyService',
    'package:my_app/my_app.dart.BaseService',
  );

  // Global functions
  final global = reflectionApi.findGlobalMethod('processData');
  global?.invoke(null, ['data']);
}
```

## Tips

- **Keep entry points stable** to avoid regenerating reflection unnecessarily.
- **Use annotation-based filtering** for fine-grained control over what gets reflected.
- **Exclude framework packages** (flutter, dart:*) to reduce output size.
- **The reflection output is deterministic** and sorted, ideal for diffs and caching.
- **One reflection file per entry point** - if you have multiple binaries, each gets its own reflection data.

## Analysis-Time API

The `AnalysisResult` from `EntryPointAnalyzer` provides build-time access to discovered elements. This is useful for tooling, code generation, and static analysis.

### Accessing analysis results programmatically

```dart
import 'package:tom_analyzer/tom_analyzer.dart';

Future<void> main() async {
  final config = ReflectionConfig.load(path: 'tom_analyzer.yaml');
  final analyzer = EntryPointAnalyzer(config);
  final result = await analyzer.analyze();
  
  print('Found ${result.classes.length} classes');
  print('Found ${result.globalFunctions.length} global functions');
}
```

### Annotation discovery

The `AnalysisResult` provides convenient access to all annotations used in the analyzed code:

```dart
// Get all annotations with their usages
for (final entry in result.annotations.entries) {
  final name = entry.key;
  final info = entry.value;
  print('@$name: ${info.usageCount} usages');
  
  // Usages grouped by element kind
  for (final kind in info.usagesByKind.keys) {
    print('  $kind: ${info.usagesByKind[kind]!.length}');
  }
}

// Find all elements with a specific annotation
final reflectable = result.getAnnotatedElements('tomReflector');
for (final element in reflectable) {
  print('Reflectable: ${element.name}');
}

// Check if an annotation is used
if (result.hasAnnotation('JsonSerializable')) {
  print('Project uses JSON serialization');
}
```

### Flattened member access

Access all members across all classes without nested loops:

```dart
// All methods from all classes
for (final method in result.allMethods) {
  if (method.isDeprecated) {
    print('Deprecated: ${method.enclosingElement3.name}.${method.name}');
  }
}

// All fields from all classes
for (final field in result.allFields) {
  print('${field.enclosingElement3.name}.${field.name}: ${field.type}');
}

// All constructors from all classes
for (final ctor in result.allConstructors) {
  print('${ctor.enclosingElement3.name}.${ctor.name}');
}
```

### AnnotationInfo structure

```dart
class AnnotationInfo {
  String name;           // e.g., "override", "Deprecated"
  String qualifiedName;  // e.g., "dart:core#override"
  String sourceLibrary;  // e.g., "dart:core"
  List<AnnotatedElementInfo> usages;
  
  int get usageCount;
  Map<String, List<AnnotatedElementInfo>> get usagesByKind;
}

class AnnotatedElementInfo {
  String name;           // Element name
  String qualifiedName;  // e.g., "MyClass.myMethod"
  String kind;           // "class", "method", "field", etc.
  String library;        // Library URI
  Element element;       // The actual analyzer Element
}
```

## Configuration Reference

### Default behavior

All types reachable from entry points are always included (this is implicit and cannot be disabled). Filters then expand or shrink this set. The typical use case is annotation-based filtering, where you include only annotated elements, or package exclusion, where you remove framework packages.

When no `dependency_config` is specified, defaults are used (see the dependency_config section for default values).

When no `coverage_config` is specified, full coverage is generated for all included types.

### Filter processing rules

1. **Reachable is always included**: All types reachable from entry points are included by default
2. **Global defaults apply first**: `exclude_packages` removes packages, `include_packages` adds non-reachable packages
3. **Include filters expand the set**: Add packages, paths, annotations, or individual elements beyond reachable
4. **Exclude filters shrink the set**: Remove matching elements from whatever is currently included
5. **Order matters**: Filters are processed top-to-bottom; later filters refine earlier ones
6. **Transitive dependencies**: When an element is included, its dependencies are also included per `dependency_config`

### Pattern syntax

All patterns use **glob syntax** for consistency:

| Field | Example | Description |
|-------|---------|-------------|
| `packages` | `flutter_*` | Wildcard matching on package names |
| `paths` | `lib/models/**` | Glob patterns on file paths |
| `types` | `*Service` | Wildcard matching on type names |
| `elements` | `package:app/x.dart#User` | Exact qualified element reference |
| `pattern` (coverage) | `from*` | Glob pattern on member names |

Glob wildcards:
- `*` matches any characters except `/`
- `**` matches any characters including `/`
- `?` matches a single character

### Multi-entry-point behavior

When multiple entry points are specified:

```yaml
entry_points:
  - bin/cli.dart
  - bin/server.dart
```

**Without `output`**: Each entry point generates a separate `.r.dart` file:
- `bin/cli.dart` → `bin/cli.r.dart`
- `bin/server.dart` → `bin/server.r.dart`

**With `output`**: All entry points are combined into a single file:

```yaml
entry_points:
  - bin/cli.dart
  - bin/server.dart

output: lib/app                     # Generates lib/app.r.dart
```

The generator:
1. Scans all entry points together
2. Merges their reachable sets
3. Applies filters once to the combined set
4. Generates the single output file

**Output naming**: The `output` field is the base name. The `.r.dart` extension is always added automatically. If the name ends in `.dart`, it is removed first:
- `output: lib/app` → `lib/app.r.dart`
- `output: lib/app.dart` → `lib/app.r.dart`
- `output: lib/app.r.dart` → `lib/app.r.dart`

### Annotation matching

Annotations can be specified in several ways:

```yaml
annotations:
  # Short name (if unambiguous in the codebase)
  - Reflectable
  - Entity
  
  # Fully qualified (required if name is ambiguous)
  - 'package:my_app/annotations.dart#Entity'
  
  # With field matching (glob syntax on field values)
  - 'Entity(tableName: users_*)'
  - 'JsonSerializable(explicitToJson: true)'
```

**Field matching** allows filtering based on annotation constructor arguments:

```dart
@Entity(tableName: 'users')          // Matches 'Entity(tableName: users*)'
@Entity(tableName: 'user_profiles')  // Matches 'Entity(tableName: user*)'
@Entity(tableName: 'orders')         // Does NOT match 'Entity(tableName: user*)'
```

Field matching syntax:
- `AnnotationType(fieldName: pattern)` - match if field equals pattern (glob)
- `AnnotationType(field1: *, field2: value)` - match multiple fields
- Fields not specified are ignored (wildcard)

**Matching rules:**
- Annotations are matched by type
- Field values are matched using glob patterns
- Annotations on superclasses do NOT cause subclasses to be included
- Only directly annotated elements are matched
---

## Source Code Extraction

The analyzer can optionally extract full source code, comments, and AST information for all discovered declarations. This is useful for documentation tools, code visualization, and source regeneration.

### Enabling Source Extraction

In YAML configuration:

```yaml
source_extraction:
  enabled: true
  include_source_code: true
  include_doc_comments: true
  include_all_comments: true
  include_line_info: true
  store_file_contents: true
```

Programmatically:

```dart
final config = ReflectionConfig(
  entryPoints: ['lib/main.dart'],
  sourceExtractionConfig: SourceExtractionConfig.full,
);

// Or with specific options:
final config = ReflectionConfig(
  entryPoints: ['lib/main.dart'],
  sourceExtractionConfig: const SourceExtractionConfig(
    enabled: true,
    includeDocComments: true,
    includeLineInfo: true,
  ),
);
```

### Using Source Info

```dart
final result = await analyzer.analyze();
final sourceInfo = result.sourceInfo;

if (sourceInfo != null) {
  // Get source info for a class
  for (final cls in result.classes) {
    final qualifiedName = '${cls.library.source.uri}#${cls.name}';
    final info = sourceInfo.get(qualifiedName);
    
    if (info != null) {
      print('${cls.name} at line ${info.line}');
      print('  Doc: ${info.docComment?.split('\n').first}');
    }
  }
  
  // Serialize for storage
  final json = sourceInfo.toJsonString();
  
  // Later, restore:
  final restored = SourceInfoCollection.fromJsonString(json);
}
```

### Memory Considerations

Source extraction is memory-intensive. Use the appropriate preset:

| Preset | Use Case | Memory |
|--------|----------|--------|
| `disabled` | Default, no source info | None |
| `docOnly` | Documentation extraction only | Low |
| `full` | Complete source for regeneration | High |

For large codebases (1000+ types), prefer `docOnly` or disable entirely.