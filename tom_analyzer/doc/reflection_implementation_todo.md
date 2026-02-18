# Tom Analyzer Reflection Implementation Plan

This document outlines the phased implementation plan for the reflection functionality in `tom_analyzer`. Each step references sections in [reflection_implementation.md](reflection_implementation.md) and [reflection_user_guide.md](reflection_user_guide.md).

**Last Updated:** 2026-02-04

**User Guide:** [reflection_user_guide.md](reflection_user_guide.md) - End-user documentation for reflection generation

---

## Phase 1: Core Runtime Library ✅ COMPLETE

**Goal:** Create the runtime types that generated code will use.

**Status:** All runtime library files created in `lib/src/reflection/runtime/`

### 1.1 Base Trait Interfaces ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 1.1.1 | Implement `Element` base trait with `name`, `qualifiedName`, `libraryUri`, `package`, `kind`, and annotation methods | ✅ | `element.dart` |
| 1.1.2 | Implement `ElementKind` enum | ✅ | `element.dart` |
| 1.1.3 | Implement `ElementFilter` and `ElementProcessor` classes | ✅ | `element.dart` |

### 1.2 Typed Trait ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 1.2.1 | Implement `Typed<T>` trait with `reflectedType`, `isSubtypeOf`, `isAssignableFrom`, collection factories | ✅ | `typed.dart` |
| 1.2.2 | Implement `TypedFilter` and `TypedProcessor` classes | ✅ | `typed.dart` |

### 1.3 Invokable Trait ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 1.3.1 | Implement `Invokable` trait with `invoke`, `invokeWithNamedArgs`, `invokeWithMap` | ✅ | `invokable.dart` |
| 1.3.2 | Implement parameter handling (positional, named, spread) | ✅ | `invokable.dart` |
| 1.3.3 | Implement `InvokableFilter` and `InvokableProcessor` classes | ✅ | `invokable.dart` |

### 1.4 OwnedElement Trait ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 1.4.1 | Implement `OwnedElement` trait with `owner`, `isGlobal`, `isInherited`, `declaringClass` | ✅ | `owned_element.dart` |
| 1.4.2 | Implement `OwnedElementFilter` and `OwnedElementProcessor` classes | ✅ | `owned_element.dart` |

### 1.5 GenericElement Trait ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 1.5.1 | Implement `GenericElement` trait with `typeParameters`, `isGeneric`, `instantiate` | ✅ | `generic_element.dart` |
| 1.5.2 | Implement `GenericElementFilter` and `GenericElementProcessor` classes | ✅ | `generic_element.dart` |

### 1.6 Accessible Trait ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 1.6.1 | Implement `Accessible<T>` trait with `getValue`, `setValue`, `canRead`, `canWrite` | ✅ | `accessible.dart` |
| 1.6.2 | Implement `AccessibleFilter` and `AccessibleProcessor` classes | ✅ | `accessible.dart` |

---

## Phase 2: Core Type Mirrors ✅ COMPLETE

**Goal:** Implement the main type mirrors for classes, enums, mixins, extensions.

### 2.1 TypeMirror Base ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 2.1.1 | Implement `TypeMirror<T>` base class combining `Element`, `Typed<T>`, `GenericElement` | ✅ | `type_mirror.dart` |

### 2.2 ClassMirror ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 2.2.1 | Implement `ClassMirror<T>` with modifiers (`isAbstract`, `isSealed`, `isFinal`, `isMixin`, `isInterface`) | ✅ | `class_mirror.dart` |
| 2.2.2 | Implement type hierarchy (`superclass`, `interfaces`, `mixins`, `allSupertypes`) | ✅ | `class_mirror.dart` |
| 2.2.3 | Implement member getters (`constructors`, `methods`, `fields`, `getters`, `setters`) | ✅ | `class_mirror.dart` |
| 2.2.4 | Implement filter/process methods (`filterMethods`, `processMethods`, etc.) | ✅ | `class_mirror.dart` |
| 2.2.5 | Implement factory constructors vs static methods distinction | ✅ | `class_mirror.dart` |
| 2.2.6 | Implement `newInstance()`, `newInstanceNamed()` convenience methods | ✅ | `class_mirror.dart` |

### 2.3 EnumMirror, MixinMirror, ExtensionTypeMirror ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 2.3.1 | Implement `EnumMirror<T>` with `values`, `valueOf(String)`, `byIndex(int)` | ✅ | `enum_mirror.dart` |
| 2.3.2 | Implement `MixinMirror<T>` with `superclassConstraints`, `on` | ✅ | `mixin_mirror.dart` |
| 2.3.3 | Implement `ExtensionTypeMirror<T>` with `representationType`, `erases` | ✅ | `extension_type_mirror.dart` |

### 2.4 ExtensionMirror ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 2.4.1 | Implement `ExtensionMirror` with `on` (extended type), `appliesTo()` | ✅ | `extension_mirror.dart` |
| 2.4.2 | Implement extension method invocation on ClassMirror | ✅ | `extension_mirror.dart` |

### 2.5 TypeAliasMirror ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 2.5.1 | Implement `TypeAliasMirror` with `aliasedType` | ✅ | `type_alias_mirror.dart` |

---

## Phase 3: Member Mirrors ✅ COMPLETE

**Goal:** Implement mirrors for methods, fields, constructors, parameters.

### 3.1 MemberMirror Base ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 3.1.1 | Implement `MemberMirror` base combining `Element`, `OwnedElement` | ✅ | (integrated in each mirror) |
| 3.1.2 | Implement modifiers (`isStatic`, `isPrivate`, `isConst`, `isFinal`, `isLate`) | ✅ | (integrated in each mirror) |

### 3.2 MethodMirror ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 3.2.1 | Implement `MethodMirror<R>` with `returnType`, `parameters`, `isAsync`, `isGenerator` | ✅ | `method_mirror.dart` |
| 3.2.2 | Implement `Invokable` for method invocation | ✅ | `method_mirror.dart` |

### 3.3 FieldMirror ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 3.3.1 | Implement `FieldMirror<T>` with `fieldType`, `isLate`, `hasInitializer` | ✅ | `field_mirror.dart` |
| 3.3.2 | Implement `Accessible<T>` for field access | ✅ | `field_mirror.dart` |

### 3.4 GetterMirror and SetterMirror ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 3.4.1 | Implement `GetterMirror<T>` with read access | ✅ | `getter_setter_mirror.dart` |
| 3.4.2 | Implement `SetterMirror<T>` with write access | ✅ | `getter_setter_mirror.dart` |

### 3.5 ConstructorMirror ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 3.5.1 | Implement `ConstructorMirror<T>` with `isFactory`, `isConst`, `isNamed`, `redirectedConstructor` | ✅ | `constructor_mirror.dart` |
| 3.5.2 | Implement `Invokable` for instance creation | ✅ | `constructor_mirror.dart` |

### 3.6 ParameterMirror ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 3.6.1 | Implement `ParameterMirror<T>` with `type`, `isRequired`, `isNamed`, `isOptional`, `defaultValue` | ✅ | `parameter_mirror.dart` |

### 3.7 AnnotationMirror ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 3.7.1 | Implement `AnnotationMirror` with `annotationType`, `value`, `arguments` | ✅ | `annotation_mirror.dart` |

### 3.8 TypeParameterMirror ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 3.8.1 | Implement `TypeParameterMirror` with `bound`, `defaultType`, `variance` | ✅ | `generic_element.dart` |

---

## Phase 4: Global Members and ReflectionApi ✅ COMPLETE

**Goal:** Implement top-level member handling and the main API entry point.

### 4.1 Global Members ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 4.1.1 | Implement global method handling (top-level functions) with `isGlobal: true` | ✅ | `reflection_api.dart` |
| 4.1.2 | Implement global field/getter/setter handling | ✅ | `reflection_api.dart` |

### 4.2 ReflectionApi ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 4.2.1 | Implement `ReflectionApi` core with all collections (`allClasses`, `allEnums`, `allMixins`, etc.) | ✅ | `reflection_api.dart` |
| 4.2.2 | Implement type lookup (`findClassByType<T>()`, `findClassByName(String)`, etc.) | ✅ | `reflection_api.dart` |
| 4.2.3 | Implement global member access (`allGlobalMethods`, `findGlobalMethod`, etc.) | ✅ | `reflection_api.dart` |
| 4.2.4 | Implement filter methods (`filterClasses`, `filterMethods`, etc.) | ✅ | `reflection_api.dart` |
| 4.2.5 | Implement process methods (`processClasses`, `processMethods`, etc.) | ✅ | `reflection_api.dart` |
| 4.2.6 | Implement `reflect(instance)` for runtime reflection | ✅ | `reflection_api.dart` |

### 4.3 Scoped APIs ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 4.3.1 | Implement `PackageApi` for package-scoped reflection | ✅ | `reflection_api.dart` |
| 4.3.2 | Implement `LibraryApi` for library-scoped reflection | ✅ | `reflection_api.dart` |
| 4.3.3 | Connect scoped APIs via `reflectionApi.forPackage()`, `reflectionApi.forLibrary()` | ✅ | `reflection_api.dart` |

---

## Phase 5: Filters and Processors ✅ COMPLETE

**Goal:** Implement specialized filter and processor classes.

**Status:** All filters and processors implemented in `filters.dart` and `processors.dart`.

### 5.1 Type-Specific Filters ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 5.1.1 | Implement `ClassFilter` with `isAbstract`, `isConcrete`, `extendsClass`, `implementsInterface`, `usesMixin` | ✅ | `filters.dart` |
| 5.1.2 | Implement `MethodFilter` with `returnsTypeName`, `returnsVoid`, `hasParameterCount`, `isAsync` | ✅ | `filters.dart` |
| 5.1.3 | Implement `FieldFilter` with `hasType`, `isFinal`, `isLate`, `isConst`, `isReadOnly` | ✅ | `filters.dart` |
| 5.1.4 | Implement `TypeFilter` for TypeMirror hierarchy queries | ✅ | `filters.dart` |

### 5.2 Processors ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 5.2.1 | Implement `TypeProcessor` with type-specific dispatch | ✅ | `processors.dart` |
| 5.2.2 | Implement `MemberProcessor` with member-specific dispatch | ✅ | `processors.dart` |

**Additional implementations:**
- `ConstructorFilter` - Filter constructors by factory, const, named, parameter count
- `GetterFilter` - Filter getters by return type, static, global
- `SetterFilter` - Filter setters by parameter type, static, global
- `ElementVisitor` - Comprehensive visitor combining type and member processors
- `CollectingTypeProcessor` - Collects elements into typed lists
- `CollectingMemberProcessor` - Collects members into typed lists

---

## Phase 6: Name Resolution and Errors ✅ COMPLETE

**Goal:** Implement name resolution logic and error handling.

### 6.1 Name Resolution ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 6.1.1 | Implement short name vs qualified name lookup | ✅ | `reflection_api.dart` |
| 6.1.2 | Implement ambiguity detection and error reporting | ✅ | `reflection_api.dart` |

### 6.2 Error Types ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 6.2.1 | Implement `AmbiguousNameError` | ✅ | `errors.dart` |
| 6.2.2 | Implement `ReadOnlyFieldError` | ✅ | `errors.dart` |
| 6.2.3 | Implement `UncoveredMemberError` | ✅ | `errors.dart` |
| 6.2.4 | Implement `UncoveredTypeError` | ✅ | `errors.dart` |
| 6.2.5 | Implement `InvalidInvocationError` | ✅ | `errors.dart` |
| 6.2.6 | Implement `FilterReason` enum | ✅ | `errors.dart` |

---

## Phase 7: Code Generator ✅ COMPLETE

**Goal:** Implement the generator that produces `.r.dart` files.

**Status:** Core generator infrastructure complete in `lib/src/reflection/generator/`

### 7.1 Configuration Parsing ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 7.1.1 | Parse `tom_analyzer.yaml` configuration | ✅ | `reflection_config.dart` |
| 7.1.2 | Parse `entry_points` and resolve to files | ✅ | `reflection_config.dart` |
| 7.1.3 | Parse `output` with base name normalization (add `.r.dart`) | ✅ | `reflection_config.dart` |
| 7.1.4 | Parse `defaults` section (global exclude/include packages, annotations) | ✅ | `reflection_config.dart` |
| 7.1.5 | Parse `filters` section with `include`/`exclude` logic | ✅ | `reflection_config.dart` |
| 7.1.6 | Parse `dependency_config` section | ✅ | `reflection_config.dart` |
| 7.1.7 | Parse `coverage_config` section | ✅ | `reflection_config.dart` |

### 7.2 Entry Point Analysis ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 7.2.1 | Use Dart analyzer to resolve entry point imports | ✅ | `entry_point_analyzer.dart` |
| 7.2.2 | Build reachability graph from entry points | ✅ | `entry_point_analyzer.dart` |
| 7.2.3 | Track all reachable types and their dependencies | ✅ | `entry_point_analyzer.dart` |

### 7.3 Filter Application ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 7.3.1 | Apply global `exclude_packages` to remove packages | ✅ | `filter_matcher.dart` |
| 7.3.2 | Apply global `include_packages` to add non-reachable packages | ✅ | `filter_matcher.dart` |
| 7.3.3 | Apply global `include_annotations` to add annotated elements | ✅ | `filter_matcher.dart` |
| 7.3.4 | Process filters in order (include expands, exclude shrinks) | ✅ | `filter_matcher.dart` |
| 7.3.5 | Implement glob pattern matching for packages, paths, types | ✅ | `filter_matcher.dart` |
| 7.3.6 | Implement annotation matching (short name, qualified, field patterns) | ✅ | `filter_matcher.dart` |
| 7.3.7 | Implement element inclusion/exclusion (hide/show style) | ✅ | `filter_matcher.dart` |

### 7.4 Dependency Resolution ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 7.4.1 | Apply `superclasses` config (depth, external_depth, exclude_types) | ✅ | `entry_point_analyzer.dart` |
| 7.4.2 | Apply `interfaces` config (enabled, external) | ✅ | `entry_point_analyzer.dart` |
| 7.4.3 | Apply `mixins` config (enabled, external) | ✅ | `entry_point_analyzer.dart` |
| 7.4.4 | Apply `type_arguments` config (generics) | ✅ | `entry_point_analyzer.dart` |
| 7.4.5 | Apply `type_annotations` config (field types, parameter types) | ✅ | `entry_point_analyzer.dart` |
| 7.4.6 | Track external package depth for dependency limits | ✅ | `entry_point_analyzer.dart` |

### 7.5 Coverage Determination ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 7.5.1 | Determine which types get full invoker coverage | ✅ | `reflection_generator.dart` |
| 7.5.2 | Apply `instance_members` pattern/annotation filters | ✅ | `reflection_generator.dart` |
| 7.5.3 | Apply `constructors` pattern filter (e.g., `from*`) | ✅ | `reflection_generator.dart` |
| 7.5.4 | Apply `top_level` config for global members | ✅ | `reflection_generator.dart` |
| 7.5.5 | Mark types as declarations-only (negative invoker index) for metadata-only types | ✅ | `reflection_generator.dart` |

### 7.6 Code Generation ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 7.6.1 | Generate package imports with prefixes | ✅ | `reflection_generator.dart` |
| 7.6.2 | Generate bit flag constants | ✅ | `reflection_generator.dart` |
| 7.6.3 | Generate package/library structure arrays | ✅ | `reflection_generator.dart` |
| 7.6.4 | Generate type data arrays (classes, enums, mixins) | ✅ | `reflection_generator.dart` |
| 7.6.5 | Generate member data arrays with invoker indices | ✅ | `reflection_generator.dart` |
| 7.6.6 | Generate invoker closures for methods, constructors, fields | ✅ | `reflection_generator.dart` |
| 7.6.7 | Generate extension method entries on ClassMirror | ✅ | `reflection_generator.dart` |
| 7.6.8 | Generate `reflectionApi` singleton instantiation | ✅ | `reflection_generator.dart` |
| 7.6.9 | Write output to configured path (base name + `.r.dart`) | ✅ | `reflection_generator.dart` |

### 7.7 Runtime Data Structures ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 7.7.1 | Implement `PackageData` and `LibraryData` | ✅ | `reflection_data.dart` |
| 7.7.2 | Implement `ClassMirrorData`, `EnumMirrorData`, `MixinMirrorData` | ✅ | `reflection_data.dart` |
| 7.7.3 | Implement `FieldMirrorData`, `MethodMirrorData`, `ConstructorMirrorData` | ✅ | `reflection_data.dart` |
| 7.7.4 | Implement `ParameterMirrorData`, `AnnotationMirrorData` | ✅ | `reflection_data.dart` |
| 7.7.5 | Implement `ReflectionData` container and registration | ✅ | `reflection_data.dart` |
| 7.7.6 | Create `reflection_runtime.dart` export library | ✅ | `lib/reflection_runtime.dart` |

---

## Phase 8: Multi-Entry-Point Support ✅ COMPLETE

**Goal:** Handle multiple entry points with combined or separate output.

**Status:** Multi-entry-point infrastructure complete in `lib/src/reflection/generator/`

| Step | Description | Status | File |
|------|-------------|--------|------|
| 8.1 | Detect multiple entry points in configuration | ✅ | `reflection_config.dart` |
| 8.2 | Without `output`: generate separate `.r.dart` per entry point | ✅ | `multi_entry_generator.dart` |
| 8.3 | With `output`: merge reachable sets from all entry points | ✅ | `multi_entry_generator.dart` |
| 8.4 | Apply filters once to combined set | ✅ | `multi_entry_generator.dart` |
| 8.5 | Generate single combined output file | ✅ | `multi_entry_generator.dart` |

---

## Phase 9: CLI Integration ✅ COMPLETE

**Goal:** Expose reflection generation via CLI and build_runner.

**Status:** CLI command implemented in `bin/tom_analyzer.dart`. Build runner integration deferred.

### 9.1 CLI Command ✅

| Step | Description | Status | File |
|------|-------------|--------|------|
| 9.1.1 | Implement `tom_analyzer reflect` command | ✅ | `bin/tom_analyzer.dart` |
| 9.1.2 | Parse `--config`, `--entry`, `--output` arguments | ✅ | `bin/tom_analyzer.dart` |
| 9.1.3 | Normalize output path (add `.r.dart`, remove `.dart`) | ✅ | `reflection_config.dart` |

### 9.2 build_runner Integration

| Step | Description | Status | File |
|------|-------------|--------|------|
| 9.2.1 | Implement `tom_analyzer_reflection` builder | ⏳ Deferred | - |
| 9.2.2 | Read options from `build.yaml` | ⏳ Deferred | - |
| 9.2.3 | Integrate with build_runner lifecycle | ⏳ Deferred | - |

Note: build_runner integration is deferred as CLI-based generation is the primary workflow.

---

## Phase 10: Testing and Validation ✅ COMPLETE

**Goal:** Comprehensive testing of all functionality.

**Status:** Generator unit tests created in `test/reflection/`

| Step | Description | Status | File |
|------|-------------|--------|------|
| 10.1 | Unit tests for ReflectionConfig | ✅ | `reflection_config_test.dart` |
| 10.2 | Unit tests for FilterMatcher, GlobMatcher, AnnotationPattern | ✅ | `filter_matcher_test.dart` |
| 10.3 | Unit tests for EntryPointAnalyzer | ✅ | `entry_point_analyzer_test.dart` |
| 10.4 | Unit tests for ReflectionGenerator | ✅ | `reflection_generator_test.dart` |
| 10.5 | Integration tests for code generation | ✅ | `code_generation_integration_test.dart` |
| 10.6 | End-to-end tests with sample projects | ✅ | `end_to_end_test.dart`, `fixtures/sample_models.dart` |
| 10.7 | Performance tests with large codebases | ✅ | `performance_test.dart` (uses aa_server_start.dart) |

---

## Implementation Order Summary

| Phase | Priority | Dependency | Status | Estimated Effort |
|-------|----------|------------|--------|------------------|
| 1. Core Runtime Library | P0 | None | ✅ Complete | Medium |
| 2. Core Type Mirrors | P0 | Phase 1 | ✅ Complete | Large |
| 3. Member Mirrors | P0 | Phase 2 | ✅ Complete | Medium |
| 4. Global Members & ReflectionApi | P0 | Phase 3 | ✅ Complete | Medium |
| 5. Filters and Processors | P1 | Phase 4 | ✅ Complete | Medium |
| 6. Name Resolution & Errors | P1 | Phase 4 | ✅ Complete | Small |
| 7. Code Generator | P0 | Phase 4 | ✅ Complete | Large |
| 8. Multi-Entry-Point | P1 | Phase 7 | ✅ Complete | Small |
| 9. CLI Integration | P1 | Phase 7 | ✅ Complete | Small |
| 10. Testing | P0 | All | ✅ Complete | Large |

**Critical Path:** Phase 1 → Phase 2 → Phase 3 → Phase 4 → Phase 7

---

## Files Created

All runtime library files are in `lib/src/reflection/runtime/`:

| File | Description |
|------|-------------|
| `runtime.dart` | Barrel file exporting all modules |
| `element.dart` | Base Element trait, ElementKind enum, ElementFilter/Processor |
| `annotation_mirror.dart` | AnnotationMirror for annotation reflection |
| `typed.dart` | Typed<T> trait with type operations and collection factories |
| `invokable.dart` | Invokable<R> trait for method/constructor invocation |
| `parameter_mirror.dart` | ParameterMirror and ParameterKind |
| `owned_element.dart` | OwnedElement trait for member ownership |
| `generic_element.dart` | GenericElement trait and TypeParameterMirror |
| `accessible.dart` | Accessible<T> trait for field/property access |
| `type_mirror.dart` | TypeMirror<T> base class |
| `class_mirror.dart` | ClassMirror<T> with full member access |
| `enum_mirror.dart` | EnumMirror<T> and EnumValueMirror |
| `mixin_mirror.dart` | MixinMirror<T> with constraints |
| `extension_mirror.dart` | ExtensionMirror<T> for extension reflection |
| `extension_type_mirror.dart` | ExtensionTypeMirror<T> for extension types |
| `type_alias_mirror.dart` | TypeAliasMirror for typedefs |
| `method_mirror.dart` | MethodMirror<R> for method reflection |
| `field_mirror.dart` | FieldMirror<T> for field reflection |
| `constructor_mirror.dart` | ConstructorMirror<T> for constructor reflection |
| `getter_setter_mirror.dart` | GetterMirror<T> and SetterMirror<T> |
| `reflection_api.dart` | ReflectionApi, PackageApi, LibraryApi entry points |
| `errors.dart` | Error types (AmbiguousNameError, ReadOnlyFieldError, etc.) and FilterReason |
| `filters.dart` | ClassFilter, MethodFilter, FieldFilter, TypeFilter, ConstructorFilter, GetterFilter, SetterFilter |
| `processors.dart` | TypeProcessor, MemberProcessor, ElementVisitor, CollectingTypeProcessor, CollectingMemberProcessor |
| `reflection_data.dart` | Data structures for generated code (PackageData, LibraryData, TypeMirrorData, etc.) |

Generator files are in `lib/src/reflection/generator/`:

| File | Description |
|------|-------------|
| `generator.dart` | Barrel file exporting all generator modules |
| `reflection_config.dart` | Configuration parsing (ReflectionConfig, ReflectionFilter, DependencyConfig, CoverageConfig) |
| `filter_matcher.dart` | Filter matching utilities (GlobMatcher, AnnotationPattern, InclusionResolver) |
| `entry_point_analyzer.dart` | Entry point analysis (EntryPointAnalyzer, AnalysisResult) |
| `reflection_generator.dart` | Main code generator (ReflectionGenerator) |
| `multi_entry_generator.dart` | Multi-entry-point generation (MultiEntryGenerator, MultiEntryResult) |

Test files are in `test/reflection/`:

| File | Description |
|------|-------------|
| `reflection_config_test.dart` | Tests for ReflectionConfig and related config classes |
| `filter_matcher_test.dart` | Tests for FilterMatcher, GlobMatcher, AnnotationPattern, InclusionResolver |

Top-level library:

| File | Description |
|------|-------------|
| `lib/reflection_runtime.dart` | Export library for generated `.r.dart` files |

Documentation files in `doc/`:

| File | Description |
|------|-------------|
| `reflection_implementation.md` | Detailed implementation specification (~3200 lines) |
| `reflection_implementation_todo.md` | This implementation tracking document |
| `reflection_user_guide.md` | End-user guide for reflection generation (~660 lines) |

---

## Notes

- **Private members** are excluded from reflection output. See [Private Members](reflection_implementation.md#private-members) (L2961-2965).
- **No `dart:mirrors`** - all invocation uses statically generated closures. See [Invocation Strategy](reflection_implementation.md#invocation-strategy) (L2923-2942).
- **Compact format** is essential for large codebases. See [Compact Index-Based Format](reflection_implementation.md#compact-index-based-format) (L2346-2357).
- **Known limitations** are documented. See [Known Limitations](reflection_implementation.md#known-limitations) (L3149-3161).
