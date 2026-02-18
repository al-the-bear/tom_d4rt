/// Accessible trait for elements with runtime value access.
///
/// This trait provides methods to get and set values on fields,
/// getters, setters, and top-level variables.
library;

import 'element.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Accessor Types
// ═══════════════════════════════════════════════════════════════════════════

/// Getter function for instance fields/getters.
typedef InstanceGetter<T> = T Function(Object instance);

/// Setter function for instance fields/setters.
typedef InstanceSetter<T> = void Function(Object instance, T value);

/// Getter function for static fields/getters.
typedef StaticGetter<T> = T Function();

/// Setter function for static fields/setters.
typedef StaticSetter<T> = void Function(T value);

// ═══════════════════════════════════════════════════════════════════════════
// Accessible Trait
// ═══════════════════════════════════════════════════════════════════════════

/// Trait for elements that can have their values accessed.
///
/// This includes fields, getters, setters, and top-level variables.
abstract class Accessible<T> implements Element {
  /// Whether this element can be read (has a getter).
  bool get canRead;

  /// Whether this element can be written (has a setter, is not final/const).
  bool get canWrite;

  /// Whether this is a static member or top-level element.
  bool get isStatic;

  /// Whether this element has an accessor (can access values at runtime).
  ///
  /// Elements without accessors are declaration-only (metadata available
  /// but not accessible, typically from external packages).
  bool get hasAccessor;

  // ─────────────────────────────────────────────────────────────────────────
  // Instance Access
  // ─────────────────────────────────────────────────────────────────────────

  /// Get the value from an instance.
  ///
  /// Throws if this is a static member or [canRead] is false.
  ///
  /// ```dart
  /// final field = cls.fields['name'];
  /// final name = field.getValue(user);
  /// ```
  T getValue(Object instance);

  /// Set the value on an instance.
  ///
  /// Throws if this is a static member, [canWrite] is false, or
  /// the value type doesn't match.
  ///
  /// ```dart
  /// final field = cls.fields['name'];
  /// field.setValue(user, 'Alice');
  /// ```
  void setValue(Object instance, T value);

  // ─────────────────────────────────────────────────────────────────────────
  // Static Access
  // ─────────────────────────────────────────────────────────────────────────

  /// Get the static or top-level value.
  ///
  /// Throws if this is an instance member or [canRead] is false.
  ///
  /// ```dart
  /// final staticField = cls.staticFields['defaultTimeout'];
  /// final timeout = staticField.getStaticValue();
  /// ```
  T getStaticValue();

  /// Set the static or top-level value.
  ///
  /// Throws if this is an instance member or [canWrite] is false.
  ///
  /// ```dart
  /// final staticField = cls.staticFields['defaultTimeout'];
  /// staticField.setStaticValue(Duration(seconds: 30));
  /// ```
  void setStaticValue(T value);
}

// ═══════════════════════════════════════════════════════════════════════════
// AccessibleMixin - Default Implementation
// ═══════════════════════════════════════════════════════════════════════════

/// Mixin providing error-throwing defaults for [Accessible] methods.
///
/// Generated code should override these with actual implementations.
mixin AccessibleMixin<T> implements Accessible<T> {
  @override
  T getValue(Object instance) {
    if (!canRead) {
      throw UnsupportedError('Cannot read value from ${(this as Element).name}');
    }
    if (isStatic) {
      throw UnsupportedError(
        'Cannot read instance value from static member ${(this as Element).name}',
      );
    }
    throw UnimplementedError(
      'getValue not implemented for ${(this as Element).name}',
    );
  }

  @override
  void setValue(Object instance, T value) {
    if (!canWrite) {
      throw UnsupportedError(
        'Cannot write value to ${(this as Element).name}',
      );
    }
    if (isStatic) {
      throw UnsupportedError(
        'Cannot write instance value to static member ${(this as Element).name}',
      );
    }
    throw UnimplementedError(
      'setValue not implemented for ${(this as Element).name}',
    );
  }

  @override
  T getStaticValue() {
    if (!canRead) {
      throw UnsupportedError(
        'Cannot read value from ${(this as Element).name}',
      );
    }
    if (!isStatic) {
      throw UnsupportedError(
        'Cannot read static value from instance member ${(this as Element).name}',
      );
    }
    throw UnimplementedError(
      'getStaticValue not implemented for ${(this as Element).name}',
    );
  }

  @override
  void setStaticValue(T value) {
    if (!canWrite) {
      throw UnsupportedError(
        'Cannot write value to ${(this as Element).name}',
      );
    }
    if (!isStatic) {
      throw UnsupportedError(
        'Cannot write static value to instance member ${(this as Element).name}',
      );
    }
    throw UnimplementedError(
      'setStaticValue not implemented for ${(this as Element).name}',
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// AccessibleFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [Accessible] elements.
class AccessibleFilter<T> {
  /// Filter function.
  final bool Function(Accessible<T>)? filter;

  const AccessibleFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(Accessible<T> element) {
    return filter?.call(element) ?? true;
  }

  /// Filter for readable elements.
  static AccessibleFilter<T> readable<T>() => AccessibleFilter<T>(
        filter: (e) => e.canRead,
      );

  /// Filter for writable elements.
  static AccessibleFilter<T> writable<T>() => AccessibleFilter<T>(
        filter: (e) => e.canWrite,
      );

  /// Filter for static elements.
  static AccessibleFilter<T> static_<T>() => AccessibleFilter<T>(
        filter: (e) => e.isStatic,
      );

  /// Filter for instance elements.
  static AccessibleFilter<T> instance<T>() => AccessibleFilter<T>(
        filter: (e) => !e.isStatic,
      );

  /// Filter for elements with accessors.
  static AccessibleFilter<T> hasAccessor<T>() => AccessibleFilter<T>(
        filter: (e) => e.hasAccessor,
      );

  /// Filter for declaration-only elements (no accessor).
  static AccessibleFilter<T> declarationOnly<T>() => AccessibleFilter<T>(
        filter: (e) => !e.hasAccessor,
      );

  /// Filter for read-write elements.
  static AccessibleFilter<T> readWrite<T>() => AccessibleFilter<T>(
        filter: (e) => e.canRead && e.canWrite,
      );

  /// Filter for read-only elements.
  static AccessibleFilter<T> readOnly<T>() => AccessibleFilter<T>(
        filter: (e) => e.canRead && !e.canWrite,
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// AccessibleProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [Accessible] elements.
class AccessibleProcessor<T> {
  /// Process any accessible element.
  final void Function(Accessible<T>)? process;

  const AccessibleProcessor({this.process});

  /// Execute the processor.
  void execute(Accessible<T> element) {
    process?.call(element);
  }
}
