/// MixinMirror - Reflects a Dart mixin.
///
/// Provides access to mixin members and constraints.
library;

import 'type_mirror.dart';
import 'element.dart';
import 'method_mirror.dart';
import 'field_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// MixinMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a Dart mixin.
///
/// Mixins have:
/// - Members (methods, fields)
/// - Superclass constraints (on clause)
/// - Interface constraints (implements clause)
abstract class MixinMirror<T> extends TypeMirror<T> {
  @override
  ElementKind get kind => ElementKind.mixin_;

  // ─────────────────────────────────────────────────────────────────────────
  // Constraints
  // ─────────────────────────────────────────────────────────────────────────

  /// Superclass constraints from the `on` clause.
  ///
  /// ```dart
  /// mixin MyMixin on BaseClass, OtherClass { ... }
  /// ```
  List<TypeMirror<Object>> get superclassConstraints;

  /// Implemented interfaces.
  List<TypeMirror<Object>> get interfaces;

  // ─────────────────────────────────────────────────────────────────────────
  // Members
  // ─────────────────────────────────────────────────────────────────────────

  /// All methods in this mixin.
  Map<String, MethodMirror<Object?>> get methods;

  /// Get a method by name.
  MethodMirror<Object?>? getMethod(String name);

  /// All fields in this mixin.
  Map<String, FieldMirror<Object?>> get fields;

  /// Get a field by name.
  FieldMirror<Object?>? getField(String name);
}

// ═══════════════════════════════════════════════════════════════════════════
// MixinMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [MixinMirror] elements.
class MixinMirrorFilter<T> {
  /// Filter function.
  final bool Function(MixinMirror<T>)? filter;

  const MixinMirrorFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(MixinMirror<T> mixin) {
    return filter?.call(mixin) ?? true;
  }

  /// Filter for mixins with a specific superclass constraint.
  static MixinMirrorFilter<T> onType<T, C>() => MixinMirrorFilter<T>(
        filter: (m) => m.superclassConstraints.any((c) => c.reflectedType == C),
      );

  /// Filter for mixins with a specific method.
  static MixinMirrorFilter<T> hasMethod<T>(String name) =>
      MixinMirrorFilter<T>(
        filter: (m) => m.methods.containsKey(name),
      );

  /// Filter for mixins with a specific field.
  static MixinMirrorFilter<T> hasField<T>(String name) => MixinMirrorFilter<T>(
        filter: (m) => m.fields.containsKey(name),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// MixinMirrorProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [MixinMirror] elements.
class MixinMirrorProcessor<T> {
  /// Process any mixin mirror.
  final void Function(MixinMirror<T>)? process;

  const MixinMirrorProcessor({this.process});

  /// Execute the processor.
  void execute(MixinMirror<T> mixin) {
    process?.call(mixin);
  }
}
