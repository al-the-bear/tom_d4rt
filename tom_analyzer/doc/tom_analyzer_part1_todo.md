# Tom Analyzer - Phase 1 Implementation TODO

**Status:** Ready to implement
**Estimated time:** 2-3 weeks
**Dependencies:** None

This document contains the concrete implementation steps for tom_analyzer Phase 1 (Core Foundation). Implementation details left open in the design will be decided during implementation.

---

## Phase 1: Core Foundation

### 1.1 Project Setup & Structure

**Estimated:** 1 day

- [ ] **1.1.1** Verify project structure matches design
  - Reference: [Package Structure](tom_analyzer_design.md#package-structure)
  - Verify directories: `lib/src/model/`, `lib/src/analyzer/`, `lib/src/serialization/`, etc.
  - Create missing directories

- [ ] **1.1.2** Set up `pubspec.yaml` dependencies
  - Reference: [Package Structure](tom_analyzer_design.md#package-structure)
  - Add `analyzer: ^8.0.0`
  - Add `yaml: ^3.1.2`
  - Add `args: ^2.4.0` (for CLI)
  - Add `path: ^1.8.3`
  - Add `collection: ^1.18.0`

- [ ] **1.1.3** Create main library exports
  - File: `lib/tom_analyzer.dart`
  - Reference: [Package Structure](tom_analyzer_design.md#package-structure)
  - Export all public model classes
  - Export analyzer entry point
  - Export exception types

- [ ] **1.1.4** Create builder export
  - File: `lib/builder.dart`
  - Reference: [build_runner Integration](tom_analyzer_design.md#build_runner-integration)
  - Placeholder for Phase 4

### 1.2 Base Element Classes (Sealed Hierarchy)

**Estimated:** 2 days

Reference: [Base Element Classes](tom_analyzer_design.md#base-element-classes-sealed-hierarchy)

- [ ] **1.2.1** Create `lib/src/model/element.dart`
  - Define `sealed class Element`
  - Properties: `id`, `name`, `documentation`, `annotations`
  - Method: `hasAnnotation(String annotationName)`

- [ ] **1.2.2** Create container element hierarchy
  - Define `sealed class ContainerElement extends Element`
  - Documentation about container vs declaration elements

- [ ] **1.2.3** Create declaration element hierarchy
  - Define `sealed class DeclarationElement extends Element`
  - Properties: `qualifiedName`, `library`, `sourceFile`, `location`

- [ ] **1.2.4** Create type declaration hierarchy
  - Define `sealed class TypeDeclaration extends DeclarationElement`
  - Properties: `annotations`
  - Covariant override: `LibraryInfo get library`

- [ ] **1.2.5** Create executable element hierarchy
  - Define `sealed class ExecutableElement extends DeclarationElement`
  - Properties: `isAsync`, `isExternal`, `isStatic`, `parameters`

- [ ] **1.2.6** Create variable element hierarchy
  - Define `sealed class VariableElement extends DeclarationElement`
  - Properties: `type`, `isFinal`, `isConst`, `isLate`, `isStatic`

- [ ] **1.2.7** Write unit tests for base hierarchy
  - Test type checking with sealed classes
  - Test pattern matching exhaustiveness
  - Verify inheritance relationships

### 1.3 Exception Types

**Estimated:** 0.5 days

Reference: [Exception Types](tom_analyzer_design.md#exception-types)

- [ ] **1.3.1** Create `lib/src/model/exceptions.dart`
  - Define `ElementNotFoundException`
  - Properties: `message`
  - Override `toString()`

- [ ] **1.3.2** Implement `AmbiguousElementException`
  - Properties: `message`, `candidates` (List<String>)
  - Override `toString()` with formatted candidate list

- [ ] **1.3.3** Write unit tests for exceptions
  - Test exception messages
  - Test candidate formatting

### 1.4 Supporting Types

**Estimated:** 1 day

- [ ] **1.4.1** Create `lib/src/model/source_location.dart`
  - Reference: [Supporting Types](tom_analyzer_design.md#supporting-types)
  - Properties: `line`, `column`, `offset`, `length`

- [ ] **1.4.2** Create `lib/src/model/annotation_info.dart`
  - Reference: [Supporting Types](tom_analyzer_design.md#supporting-types)
  - Properties: `name`, `qualifiedName`, `constructorName`, `arguments`
  - Implementation detail: ArgumentValue structure (decide during implementation)

- [ ] **1.4.3** Create `lib/src/model/type_parameter_info.dart`
  - Reference: [TypeParameterInfo](tom_analyzer_design.md#supporting-types)
  - Properties: `name`, `bound`, `defaultType`, `variance`
  - Enum: `TypeParameterVariance`

- [ ] **1.4.4** Create `lib/src/model/parameter_info.dart`
  - Reference: [ParameterInfo](tom_analyzer_design.md#supporting-types)
  - Properties: `name`, `type`, `isRequired`, `isNamed`, `isPositional`, etc.

- [ ] **1.4.5** Write unit tests for supporting types

### 1.5 TypeReference with Resolution

**Estimated:** 2 days

Reference: [TypeReference](tom_analyzer_design.md#supporting-types)

- [ ] **1.5.1** Create `lib/src/model/type_reference.dart`
  - Properties: `id`, `name`, `qualifiedName`, `typeArguments`, `isNullable`
  - Properties: `isDynamic`, `isVoid`, `isFunction`, `isTypeParameter`
  - Internal: `_resolvedElement` (TypeDeclaration?)

- [ ] **1.5.2** Implement type-safe resolution methods
  - `resolveAsClass() -> ClassInfo?`
  - `resolveAsEnum() -> EnumInfo?`
  - `resolveAsMixin() -> MixinInfo?`
  - `resolveAsTypeAlias() -> TypeAliasInfo?`
  - `resolveAsExtensionType() -> ExtensionTypeInfo?`
  - `resolveAsTypeDeclaration() -> TypeDeclaration?`
  - Generic: `resolveAs<T extends TypeDeclaration>() -> T?`

- [ ] **1.5.3** Implement pattern matching helper
  - `matchResolved<R>({...})` with all type cases

- [ ] **1.5.4** Create `lib/src/model/function_type_info.dart`
  - Properties: `returnType`, `typeParameters`, `parameters`

- [ ] **1.5.5** Write unit tests
  - Test resolution methods (with mock resolved elements)
  - Test pattern matching
  - Test type checking flags

### 1.6 Container Info Classes

**Estimated:** 2 days

- [ ] **1.6.1** Create `lib/src/model/package_info.dart`
  - Reference: [PackageInfo](tom_analyzer_design.md#packageinfo)
  - Extends: `ContainerElement`
  - Properties: `name`, `version`, `rootPath`, `libraries`, `dependencies`, `isRoot`
  - Circular reference: `AnalysisResult analysisResult`

- [ ] **1.6.2** Create `lib/src/model/file_info.dart`
  - Reference: [FileInfo](tom_analyzer_design.md#fileinfo)
  - Properties: `path`, `package`, `library`, `isPart`, `partOfDirective`
  - Properties: `lines`, `contentHash`, `modified`

- [ ] **1.6.3** Create `lib/src/model/library_info.dart`
  - Reference: [LibraryInfo](tom_analyzer_design.md#libraryinfo)
  - Extends: `ContainerElement`
  - Properties: `uri`, `package`, `mainSourceFile`, `partFiles`
  - Collections: `classes`, `enums`, `mixins`, `extensions`, `extensionTypes`, `typeAliases`
  - Collections: `functions`, `variables`, `getters`, `setters`
  - Collections: `imports`, `exports`
  - Computed: `sourceFiles`, `typeDeclarations`, `executables`

- [ ] **1.6.4** Create `lib/src/model/import_info.dart`
  - Reference: [ImportInfo](tom_analyzer_design.md#exportinfo--importinfo)
  - Properties: `importingLibrary`, `importedLibrary`, `prefix`, `isDeferred`
  - Properties: `show`, `hide`, `documentation`

- [ ] **1.6.5** Create `lib/src/model/export_info.dart`
  - Reference: [ExportInfo](tom_analyzer_design.md#exportinfo--importinfo)
  - Properties: `exportingLibrary`, `exportedLibrary`, `show`, `hide`, `documentation`

- [ ] **1.6.6** Write unit tests for container classes

### 1.7 Type Declaration Info Classes

**Estimated:** 3 days

- [ ] **1.7.1** Create `lib/src/model/class_info.dart`
  - Reference: [ClassInfo](tom_analyzer_design.md#classinfo)
  - Extends: `TypeDeclaration`
  - Properties: `isAbstract`, `isSealed`, `isFinal`, `isBase`, `isInterface`, `isMixin`
  - Properties: `superclass`, `interfaces`, `mixins`, `typeParameters`
  - Collections: `constructors`, `methods`, `fields`, `getters`, `setters`
  - Computed: `operators`, `staticMembers`

- [ ] **1.7.2** Create `lib/src/model/enum_info.dart`
  - Reference: [EnumInfo](tom_analyzer_design.md#enuminfo)
  - Extends: `TypeDeclaration`
  - Properties: `values`, `interfaces`, `mixins`
  - Collections: `fields`, `methods`, `getters`, `setters`, `constructors`

- [ ] **1.7.3** Create `lib/src/model/enum_value_info.dart`
  - Properties: `name`, `parentEnum`, `documentation`, `annotations`, `index`

- [ ] **1.7.4** Create `lib/src/model/mixin_info.dart`
  - Reference: [MixinInfo](tom_analyzer_design.md#mixininfo)
  - Extends: `TypeDeclaration`
  - Properties: `onTypes`, `implementsTypes`, `typeParameters`
  - Collections: `methods`, `fields`, `getters`, `setters`

- [ ] **1.7.5** Create `lib/src/model/extension_info.dart`
  - Reference: Similar to MixinInfo
  - Extends: `TypeDeclaration`
  - Properties: `extendedType`, `typeParameters`
  - Collections: `methods`, `fields`, `getters`, `setters`

- [ ] **1.7.6** Create `lib/src/model/extension_type_info.dart`
  - Extends: `TypeDeclaration`
  - Properties: `representationType`, `primaryConstructor`, `typeParameters`
  - Collections: `methods`, `fields`, `getters`, `setters`, `constructors`

- [ ] **1.7.7** Create `lib/src/model/type_alias_info.dart`
  - Extends: `TypeDeclaration`
  - Properties: `aliasedType`, `typeParameters`

- [ ] **1.7.8** Write unit tests for type declarations

### 1.8 Executable Info Classes

**Estimated:** 2 days

- [ ] **1.8.1** Create `lib/src/model/function_info.dart`
  - Reference: [FunctionInfo](tom_analyzer_design.md#functioninfo)
  - Extends: `ExecutableElement`
  - Properties: `returnType`, `typeParameters`, `parameters`
  - Properties: `isAsync`, `isGenerator`, `isExternal`

- [ ] **1.8.2** Create `lib/src/model/method_info.dart`
  - Reference: [MethodInfo](tom_analyzer_design.md#methodinfo)
  - Extends: `ExecutableElement`
  - Properties: `declaringClass`, `returnType`, `typeParameters`, `parameters`
  - Properties: `isStatic`, `isAbstract`, `isExternal`, `isAsync`, `isGenerator`, `isOperator`

- [ ] **1.8.3** Create `lib/src/model/constructor_info.dart`
  - Reference: Similar to MethodInfo
  - Extends: `ExecutableElement`
  - Properties: `declaringClass`, `parameters`, `isConst`, `isFactory`
  - Properties: `redirectedConstructor`, `superConstructorInvocation`

- [ ] **1.8.4** Create `lib/src/model/getter_info.dart`
  - Reference: [GetterInfo](tom_analyzer_design.md#getterinfo)
  - Extends: `ExecutableElement`
  - Properties: `declaringClass` (nullable), `library` (nullable), `returnType`
  - Properties: `isStatic`, `isAbstract`, `isExternal`

- [ ] **1.8.5** Create `lib/src/model/setter_info.dart`
  - Reference: [SetterInfo](tom_analyzer_design.md#setterinfo)
  - Extends: `ExecutableElement`
  - Properties: `declaringClass` (nullable), `library` (nullable), `parameter`
  - Properties: `isStatic`, `isAbstract`, `isExternal`

- [ ] **1.8.6** Write unit tests for executables

### 1.9 Variable Info Classes

**Estimated:** 1 day

- [ ] **1.9.1** Create `lib/src/model/field_info.dart`
  - Reference: Similar to VariableInfo
  - Extends: `VariableElement`
  - Properties: `declaringClass`, `type`, `isFinal`, `isConst`, `isLate`, `isStatic`
  - Properties: `hasInitializer`

- [ ] **1.9.2** Create `lib/src/model/variable_info.dart`
  - Reference: [VariableInfo](tom_analyzer_design.md#variableinfo)
  - Extends: `VariableElement`
  - Properties: `library`, `type`, `isFinal`, `isConst`, `isLate`, `hasInitializer`

- [ ] **1.9.3** Write unit tests for variables

### 1.10 AnalysisResult with Query Methods

**Estimated:** 2 days

Reference: [AnalysisResult](tom_analyzer_design.md#analysisresult-root)

- [ ] **1.10.1** Create `lib/src/model/analysis_result.dart`
  - Extends: `ContainerElement`
  - Properties: `timestamp`, `dartSdkVersion`, `analyzerVersion`, `schemaVersion`
  - Properties: `rootPackage`, `packages`, `libraries`, `files`
  - Properties: `errors`, `metadata`

- [ ] **1.10.2** Implement convenience accessors
  - All getters: `allClasses`, `allEnums`, `allMixins`, `allExtensions`, etc.
  - Computed: `allTypeDeclarations`, `allExecutables`, `allAnnotations`

- [ ] **1.10.3** Implement simple API (throws on not-found or ambiguous)
  - `getClassOrThrow(String name) -> ClassInfo`
  - `getEnumOrThrow(String name) -> EnumInfo`
  - `getFunctionOrThrow(String name) -> FunctionInfo`
  - Reference: [Simple API](tom_analyzer_design.md#simple-api---assumes-single-element-throws-if-not-found-or-ambiguous)

- [ ] **1.10.4** Implement advanced API (safe, returns nullable/list)
  - `findClass(String qualifiedName) -> ClassInfo?`
  - `findClassesByName(String name) -> List<ClassInfo>`
  - `findClassInLibrary(String name, Uri libraryUri) -> ClassInfo?`
  - `findClassesWithAnnotation(String annotationName) -> List<ClassInfo>`
  - `findFunctionsWithAnnotation(String annotationName) -> List<FunctionInfo>`
  - Reference: [Advanced API](tom_analyzer_design.md#advanced-api---for-handling-multiple-elements)

- [ ] **1.10.5** Implement generic query methods
  - `findElement<T extends Element>(String qualifiedName) -> T?`
  - `findElementsWithAnnotation<T extends DeclarationElement>(String annotationName) -> List<T>`

- [ ] **1.10.6** Create `lib/src/model/package_elements.dart`
  - Helper class for package-specific elements
  - Reference: [PackageElements](tom_analyzer_design.md#helper-class-for-package-specific-elements-with-typed-collections)
  - Properties: typed collections for all element types
  - Computed: `allTypes`, `allExecutables`

- [ ] **1.10.7** Implement `getPackageElements(String packageName) -> PackageElements`

- [ ] **1.10.8** Write comprehensive unit tests
  - Test all query methods with mock data
  - Test exception throwing (not found, ambiguous)
  - Test pattern matching on results

### 1.11 Helper Structures

**Estimated:** 0.5 days

- [ ] **1.11.1** Create `lib/src/model/class_static_members.dart`
  - Reference: [ClassInfo](tom_analyzer_design.md#classinfo)
  - Properties: `methods`, `fields`, `getters`, `setters` (all filtered for static)

- [ ] **1.11.2** Create `lib/src/model/analysis_error.dart`
  - Reference: [AnalysisResult](tom_analyzer_design.md#analysisresult-root)
  - Properties: `message`, `severity`, `location`, `code`
  - Implementation detail: decide during implementation

### 1.12 Integration & Testing

**Estimated:** 2 days

- [ ] **1.12.1** Verify all classes properly extend base hierarchy

- [ ] **1.12.2** Create mock data builders for testing
  - Helper functions to create test instances
  - Example graphs with circular references

- [ ] **1.12.3** Write integration tests
  - Create complete AnalysisResult with all element types
  - Test navigation through object graph
  - Test query methods on realistic data

- [ ] **1.12.4** Test pattern matching exhaustiveness
  - Ensure compiler enforces exhaustive switches
  - Test all sealed class hierarchies

- [ ] **1.12.5** Test exception scenarios
  - Not found cases
  - Ambiguous cases with multiple matches
  - Exception message formatting

- [ ] **1.12.6** Document public APIs
  - Add dartdoc comments to all public classes
  - Add usage examples in doc comments

---

## Phase 2: Analysis Engine

**Status:** Design incomplete - implementation details TBD
**Estimated:** 3-4 weeks
**Dependencies:** Phase 1 complete

Reference: [Phase 2: Analysis Engine](tom_analyzer_design.md#phase-2-analysis-engine-design-incomplete-)

**Note:** These tasks require studying `package:analyzer` API before implementation. Design decisions will be made during implementation based on analyzer capabilities.

### 2.1 Analyzer Initialization

- [ ] **2.1.1** Study `package:analyzer` AnalysisContext API
- [ ] **2.1.2** Create `lib/src/analyzer/analyzer_context_builder.dart`
  - Implementation detail: SDK resolution strategy
  - Implementation detail: Package resolution strategy
  - Implementation detail: Workspace configuration

- [ ] **2.1.3** Create `lib/src/analyzer/analyzer_runner.dart`
  - Entry point for analysis
  - Reference: [Package Structure](tom_analyzer_design.md#package-structure)

### 2.2 Element Visitor

- [ ] **2.2.1** Study analyzer visitor patterns
- [ ] **2.2.2** Create `lib/src/analyzer/element_visitor.dart`
  - Implementation detail: Which visitor class to extend
  - Implementation detail: Traversal order
  - Implementation detail: Part file handling
  - Reference: [Package Structure](tom_analyzer_design.md#package-structure)

### 2.3 Type Resolution

- [ ] **2.3.1** Study analyzer DartType API
- [ ] **2.3.2** Create `lib/src/analyzer/type_resolver.dart`
  - Implementation detail: Generic substitution algorithm
  - Implementation detail: Bounds checking
  - Implementation detail: Type inference handling
  - Reference: [Type Parameter Resolution Strategy](tom_analyzer_design.md#type-parameter-resolution-strategy)

### 2.4 Annotation Parsing

- [ ] **2.4.1** Study analyzer annotation API
- [ ] **2.4.2** Create `lib/src/analyzer/annotation_parser.dart`
  - Implementation detail: Const expression evaluation
  - Implementation detail: Complex argument extraction

### 2.5 Barrel Analysis

- [ ] **2.5.1** Create `lib/src/analyzer/barrel_analyzer.dart`
  - Export resolution
  - Transitive export following
  - Reference: [Package Structure](tom_analyzer_design.md#package-structure)

---

## Phase 3: Serialization

**Status:** Design mostly complete
**Estimated:** 1-2 weeks
**Dependencies:** Phase 1 complete

Reference: [Phase 3: Serialization](tom_analyzer_design.md#phase-3-serialization-mostly-ready-)

### 3.1 ID Generation

- [ ] **3.1.1** Create `lib/src/serialization/id_generator.dart`
  - Sequential ID generation
  - Unique per element type
  - Reference: [Tree-based YAML](tom_analyzer_design.md#tree-based-yaml)

### 3.2 YAML Serialization

- [ ] **3.2.1** Create `lib/src/serialization/yaml_serializer.dart`
  - Inline owned elements (classes in library, methods in class)
  - Cross-reference with @ prefix
  - Reference: [Tree-based YAML Serialization](tom_analyzer_design.md#tree-based-yaml-serialization)

### 3.3 JSON Serialization

- [ ] **3.3.1** Create `lib/src/serialization/json_serializer.dart`
  - Alternative flat format
  - Reference: [JSON Format](tom_analyzer_design.md#json-format-alternative)

### 3.4 Deserialization

- [ ] **3.4.1** Create `lib/src/serialization/yaml_deserializer.dart`
  - Two-pass: parse structure, resolve references
  - Implementation detail: ID resolution algorithm
  - Reference: [Tree-based YAML](tom_analyzer_design.md#tree-based-yaml)

- [ ] **3.4.2** Create `lib/src/serialization/json_deserializer.dart`

### 3.5 Schema Validation

- [ ] **3.5.1** Define JSON Schema for YAML format
- [ ] **3.5.2** Define DocSpecs schema
- [ ] **3.5.3** Create validator

---

## Phase 4: CLI & Build Integration

**Status:** Design complete
**Estimated:** 1-2 weeks
**Dependencies:** Phase 1, Phase 2, Phase 3 complete

Reference: [Phase 4: CLI & Build Integration](tom_analyzer_design.md#phase-4-cli--build-integration-ready-)

### 4.1 Configuration

- [ ] **4.1.1** Create `lib/src/config/configuration.dart`
  - Load from `tom_analyzer.yaml`
  - Identical structure to `build.yaml` options
  - Reference: [Configuration File](tom_analyzer_design.md#configuration-file)

### 4.2 CLI Tool

- [ ] **4.2.1** Create `bin/tom_analyzer.dart`
  - Reference: [CLI Commands](tom_analyzer_design.md#cli-commands)
- [ ] **4.2.2** Implement analyze command
- [ ] **4.2.3** Implement reflect command (Phase 5)
- [ ] **4.2.4** Implement output formatters

### 4.3 build_runner Builder

- [ ] **4.3.1** Study build_runner Builder API
- [ ] **4.3.2** Create `lib/src/builder/analyzer_builder.dart`
  - Implementation detail: Builder lifecycle
  - Implementation detail: Incremental build strategy
  - Reference: [build_runner Integration](tom_analyzer_design.md#build_runner-integration)

---

## Phase 5: Reflection Generation

**Status:** Design complete, details TBD
**Estimated:** 3-4 weeks
**Dependencies:** Phase 2, Phase 3 complete

Reference: [Phase 5: Reflection Generation](tom_analyzer_design.md#phase-5-reflection-generation-design-complete-details-needed-)

See [tom_analyzer_reflection.md](tom_analyzer_reflection.md) for complete reflection design.

### 5.1 Code Generation

- [ ] **5.1.1** Create `lib/src/reflection/reflection_generator.dart`
  - Generate parameterized mirrors
  - Generate ReflectorData
  - Reference: [Reflection Generator](tom_analyzer_reflection.md#reflection-generator)

### 5.2 ReflectionModel Bridge

- [ ] **5.2.1** Create `lib/src/reflection/reflection_model.dart`
  - Bridge between static analysis and runtime
  - Reference: [ReflectionModel Bridge](tom_analyzer_reflection.md#reflectionmodel-bridge)

---

## Notes

### Design Decisions During Implementation

The following items are intentionally left open and will be decided during implementation based on practical requirements:

1. **Analyzer API details** - Will study `package:analyzer` during Phase 2
2. **Type resolution algorithm** - Will prototype and refine during Phase 2
3. **Visitor pattern specifics** - Will decide based on analyzer capabilities
4. **ID resolution algorithm** - Will implement most efficient approach during Phase 3
5. **Builder lifecycle hooks** - Will study build_runner API during Phase 4
6. **Code generation templates** - Will refine based on tom_reflection patterns during Phase 5

### Testing Strategy

Each phase should have:
- Unit tests for individual classes
- Integration tests for phase functionality
- Mock data builders for testing
- Golden files for serialization tests (Phase 3+)

### Documentation

- Add dartdoc to all public APIs as implemented
- Update usage guides after each phase
- Keep design document in sync with implementation decisions
