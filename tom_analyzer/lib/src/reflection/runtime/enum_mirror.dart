/// EnumMirror - Reflects a Dart enum.
///
/// Provides access to enum values and members.
library;

import 'annotation_mirror.dart';
import 'type_mirror.dart';
import 'element.dart';
import 'method_mirror.dart';
import 'field_mirror.dart';
import 'constructor_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// EnumValueMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a single enum value.
class EnumValueMirror<T> with ElementMixin implements Element {
  @override
  final String name;

  @override
  final String qualifiedName;

  @override
  final String libraryUri;

  @override
  final String package;

  @override
  final List<AnnotationMirror> annotations;

  /// The index of this enum value.
  final int index;

  /// The actual enum value.
  final T value;

  /// Documentation comment for this value.
  final String? docComment;

  const EnumValueMirror({
    required this.name,
    required this.qualifiedName,
    required this.libraryUri,
    required this.package,
    required this.index,
    required this.value,
    this.annotations = const [],
    this.docComment,
  });

  @override
  ElementKind get kind => ElementKind.field;
}

// ═══════════════════════════════════════════════════════════════════════════
// EnumMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a Dart enum.
///
/// Enums have:
/// - Enum values
/// - Methods (including any defined on the enum)
/// - Fields (static and the enum values themselves)
/// - Constructors (for enhanced enums)
abstract class EnumMirror<T> extends TypeMirror<T> {
  @override
  ElementKind get kind => ElementKind.enum_;

  // ─────────────────────────────────────────────────────────────────────────
  // Enum Values
  // ─────────────────────────────────────────────────────────────────────────

  /// All enum values in declaration order.
  List<EnumValueMirror<T>> get values;

  /// Get an enum value by name.
  EnumValueMirror<T>? getValue(String name);

  /// Get an enum value by index.
  EnumValueMirror<T>? getValueAt(int index);

  /// The number of enum values.
  int get valueCount => values.length;

  /// Get the enum value names.
  List<String> get valueNames => values.map((v) => v.name).toList();

  // ─────────────────────────────────────────────────────────────────────────
  // Members
  // ─────────────────────────────────────────────────────────────────────────

  /// Instance methods on this enum.
  Map<String, MethodMirror<Object?>> get instanceMethods;

  /// Get an instance method by name.
  MethodMirror<Object?>? getInstanceMethod(String name);

  /// Static methods on this enum.
  Map<String, MethodMirror<Object?>> get staticMethods;

  /// Get a static method by name.
  MethodMirror<Object?>? getStaticMethod(String name);

  /// Static fields on this enum.
  Map<String, FieldMirror<Object?>> get staticFields;

  /// Get a static field by name.
  FieldMirror<Object?>? getStaticField(String name);

  /// Constructors (for enhanced enums).
  Map<String, ConstructorMirror<T>> get constructors;

  /// Get a constructor by name.
  ConstructorMirror<T>? getConstructor(String name);

  // ─────────────────────────────────────────────────────────────────────────
  // Implemented Mixins
  // ─────────────────────────────────────────────────────────────────────────

  /// Mixins implemented by this enum.
  List<TypeMirror<Object>> get mixins;

  /// Interfaces implemented by this enum.
  List<TypeMirror<Object>> get interfaces;
}

// ═══════════════════════════════════════════════════════════════════════════
// EnumMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [EnumMirror] elements.
class EnumMirrorFilter<T> {
  /// Filter function.
  final bool Function(EnumMirror<T>)? filter;

  const EnumMirrorFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(EnumMirror<T> enumMirror) {
    return filter?.call(enumMirror) ?? true;
  }

  /// Filter for enums with a specific value.
  static EnumMirrorFilter<T> hasValue<T>(String name) =>
      EnumMirrorFilter<T>(
        filter: (e) => e.getValue(name) != null,
      );

  /// Filter by value count.
  static EnumMirrorFilter<T> valueCount<T>(int count) =>
      EnumMirrorFilter<T>(
        filter: (e) => e.valueCount == count,
      );

  /// Filter for enums with methods (enhanced enums).
  static EnumMirrorFilter<T> hasInstanceMethods<T>() =>
      EnumMirrorFilter<T>(
        filter: (e) => e.instanceMethods.isNotEmpty,
      );

  /// Filter for enums with a specific method.
  static EnumMirrorFilter<T> hasMethod<T>(String name) =>
      EnumMirrorFilter<T>(
        filter: (e) => e.instanceMethods.containsKey(name),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// EnumMirrorProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [EnumMirror] elements.
class EnumMirrorProcessor<T> {
  /// Process any enum mirror.
  final void Function(EnumMirror<T>)? process;

  const EnumMirrorProcessor({this.process});

  /// Execute the processor.
  void execute(EnumMirror<T> enumMirror) {
    process?.call(enumMirror);
  }
}
