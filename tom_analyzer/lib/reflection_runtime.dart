/// Tom Analyzer Reflection Runtime Library.
///
/// This library provides the runtime support for reflection generated
/// by the tom_analyzer reflection generator. It includes:
///
/// - Mirror classes for types, members, and parameters
/// - Trait interfaces for common capabilities
/// - Filter and processor utilities
/// - Data structures for generated code
///
/// ## Usage
///
/// Import this library in generated `.r.dart` files:
///
/// ```dart
/// import 'package:tom_analyzer/reflection_runtime.dart' as r;
/// ```
///
/// The generated code uses the `r.` prefix for all runtime types.
library;

export 'src/reflection/runtime/runtime.dart';
