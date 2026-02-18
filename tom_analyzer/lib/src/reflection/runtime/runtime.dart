/// Runtime reflection library.
///
/// This library provides the core traits, mirrors, and utilities
/// for runtime reflection in Dart without dart:mirrors.
///
/// ## Main Entry Point
///
/// - [ReflectionApi] - Main API for type lookup, filtering, processing
/// - [PackageApi] - Scoped API for a specific package
/// - [LibraryApi] - Scoped API for a specific library
///
/// ## Core Traits
///
/// - [Element] - Base trait for all reflection elements
/// - [Typed] - Type-safe access to reflected types
/// - [Invokable] - Method, constructor, and function invocation
/// - [OwnedElement] - Ownership information (member vs global)
/// - [GenericElement] - Type parameter support
/// - [Accessible] - Field and property value access
///
/// ## Type Mirrors
///
/// - [TypeMirror] - Base class for all type mirrors
/// - [ClassMirror] - Reflects classes with members, constructors, type info
/// - [EnumMirror] - Reflects enums with values and members
/// - [MixinMirror] - Reflects mixins with constraints
/// - [ExtensionMirror] - Reflects extensions on types
/// - [ExtensionTypeMirror] - Reflects extension types
/// - [TypeAliasMirror] - Reflects type aliases (typedefs)
///
/// ## Member Mirrors
///
/// - [MethodMirror] - Reflects methods (instance and static)
/// - [FieldMirror] - Reflects fields (instance and static)
/// - [GetterMirror] - Reflects getters
/// - [SetterMirror] - Reflects setters
/// - [ConstructorMirror] - Reflects constructors
/// - [ParameterMirror] - Represents method/function parameters
/// - [TypeParameterMirror] - Represents generic type parameters
/// - [AnnotationMirror] - Represents annotations on elements
///
/// ## Filters and Processors
///
/// Each trait and mirror has associated Filter and Processor classes for
/// querying and processing collections of elements.
library;

// Core element types
export 'annotation_mirror.dart';
export 'element.dart';

// Traits
export 'accessible.dart';
export 'generic_element.dart';
export 'invokable.dart';
export 'owned_element.dart';
export 'typed.dart';

// Type mirrors
export 'type_mirror.dart';
export 'class_mirror.dart';
export 'enum_mirror.dart';
export 'mixin_mirror.dart';
export 'extension_mirror.dart';
export 'extension_type_mirror.dart';
export 'type_alias_mirror.dart';

// Member mirrors
export 'method_mirror.dart';
export 'field_mirror.dart';
export 'constructor_mirror.dart';
export 'getter_setter_mirror.dart';
export 'parameter_mirror.dart';

// API
export 'reflection_api.dart';

// Utilities
export 'cross_reference.dart';

// Errors
export 'errors.dart';

// Specialized Filters and Processors
export 'filters.dart';
export 'processors.dart';

// Generated data structures
export 'reflection_data.dart';