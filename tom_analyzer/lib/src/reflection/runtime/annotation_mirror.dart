/// Annotation mirror for the reflection system.
///
/// Represents an annotation applied to an element at compile time.
library;

// ═══════════════════════════════════════════════════════════════════════════
// AnnotationMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Represents an annotation applied to an element.
///
/// Annotations are const constructor invocations applied to declarations.
/// This mirror provides access to the annotation type and its arguments.
class AnnotationMirror {
  /// The short name of the annotation type (e.g., "Entity").
  final String name;

  /// The fully qualified name of the annotation type.
  /// Format: "package:my_pkg/src/annotations.dart.Entity"
  final String qualifiedName;

  /// The constructor name used, or empty string for unnamed constructor.
  final String constructorName;

  /// Positional arguments passed to the annotation constructor.
  final List<Object?> positionalArguments;

  /// Named arguments passed to the annotation constructor.
  final Map<String, Object?> namedArguments;

  /// The actual annotation value, if available at runtime.
  ///
  /// This is only available if the annotation was instantiated with
  /// the actual value. May be null if only metadata is available.
  final Object? value;

  /// Type check function to verify if the annotation is of type T.
  final bool Function<T>() _isType;

  const AnnotationMirror({
    required this.name,
    required this.qualifiedName,
    this.constructorName = '',
    this.positionalArguments = const [],
    this.namedArguments = const {},
    this.value,
    required bool Function<T>() isType,
  }) : _isType = isType;

  /// Check if this annotation is of the given type.
  bool isType<T>() => _isType<T>();

  /// Get the value of a named argument, or null if not present.
  Object? getArgument(String name) => namedArguments[name];

  /// Get a positional argument by index, or null if out of range.
  Object? getPositionalArgument(int index) {
    if (index < 0 || index >= positionalArguments.length) return null;
    return positionalArguments[index];
  }

  /// Check if a named argument exists.
  bool hasArgument(String name) => namedArguments.containsKey(name);

  /// Get the annotation value cast to the expected type.
  ///
  /// Returns null if value is null or cannot be cast.
  T? valueOf<T>() {
    final v = value;
    if (v is T) return v;
    return null;
  }

  @override
  String toString() {
    final buffer = StringBuffer('@$name');
    if (constructorName.isNotEmpty) {
      buffer.write('.$constructorName');
    }
    if (positionalArguments.isNotEmpty || namedArguments.isNotEmpty) {
      buffer.write('(');
      final args = <String>[];
      for (final arg in positionalArguments) {
        args.add(_formatValue(arg));
      }
      for (final entry in namedArguments.entries) {
        args.add('${entry.key}: ${_formatValue(entry.value)}');
      }
      buffer.write(args.join(', '));
      buffer.write(')');
    }
    return buffer.toString();
  }

  String _formatValue(Object? value) {
    if (value is String) return "'$value'";
    return value.toString();
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// AnnotationMirror Factory
// ═══════════════════════════════════════════════════════════════════════════

/// Helper to create AnnotationMirror instances in generated code.
class AnnotationMirrorFactory {
  /// Create an AnnotationMirror for a known type.
  static AnnotationMirror create<A>({
    required String name,
    required String qualifiedName,
    String constructorName = '',
    List<Object?> positionalArguments = const [],
    Map<String, Object?> namedArguments = const {},
    Object? value,
  }) {
    return AnnotationMirror(
      name: name,
      qualifiedName: qualifiedName,
      constructorName: constructorName,
      positionalArguments: positionalArguments,
      namedArguments: namedArguments,
      value: value,
      isType: <T>() => A == T,
    );
  }
}
