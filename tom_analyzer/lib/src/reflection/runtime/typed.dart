/// Typed trait for elements that represent a specific Dart type.
///
/// This trait provides type-safe access to the represented type,
/// including subtype checking and collection factory methods.
library;

// ═══════════════════════════════════════════════════════════════════════════
// Typed<T> Trait
// ═══════════════════════════════════════════════════════════════════════════

/// Trait for elements that represent a specific Dart type.
///
/// This trait provides type-safe access to the reflected type `T`,
/// enabling compile-time type safety and runtime type operations.
abstract class Typed<T> {
  /// The Dart [Type] represented by this element.
  Type get reflectedType => T;

  /// Check if this type is a subtype of another type.
  bool isSubtypeOf<Other>();

  /// Check if this type is a supertype of another type.
  bool isSupertypeOf<Other>();

  /// Check if a value of type [Other] can be assigned to a variable of this type.
  bool isAssignableFrom<Other>();

  /// Check if a value of this type can be assigned to a variable of type [Other].
  bool isAssignableTo<Other>();

  // ─────────────────────────────────────────────────────────────────────────
  // Collection Factories
  // ─────────────────────────────────────────────────────────────────────────

  /// Create a fixed-length list of this type.
  ///
  /// ```dart
  /// final cls = reflectionApi.findClassByType<User>();
  /// final List<User> users = cls!.createList(10);
  /// ```
  List<T> createList(int length, {T? fill});

  /// Create a growable list of this type.
  ///
  /// ```dart
  /// final cls = reflectionApi.findClassByType<User>();
  /// final List<User> users = cls!.createGrowableList();
  /// users.add(User('Alice'));
  /// ```
  List<T> createGrowableList();

  /// Create a set of this type.
  ///
  /// ```dart
  /// final cls = reflectionApi.findClassByType<User>();
  /// final Set<User> users = cls!.createSet();
  /// ```
  Set<T> createSet();

  /// Create an iterable from elements.
  ///
  /// ```dart
  /// final cls = reflectionApi.findClassByType<User>();
  /// final Iterable<User> users = cls!.createIterable([user1, user2]);
  /// ```
  Iterable<T> createIterable(Iterable<T> elements);
}

// ═══════════════════════════════════════════════════════════════════════════
// TypedMixin - Default Implementation
// ═══════════════════════════════════════════════════════════════════════════

/// Mixin providing default implementations for [Typed] methods.
mixin TypedMixin<T> implements Typed<T> {
  @override
  bool isSubtypeOf<Other>() {
    // Runtime subtype check using is-test
    // Note: This is a simplified check; real implementation would use
    // the type hierarchy data from the reflection system
    return _isSubtype<T, Other>();
  }

  @override
  bool isSupertypeOf<Other>() {
    return _isSubtype<Other, T>();
  }

  @override
  bool isAssignableFrom<Other>() {
    return isSupertypeOf<Other>();
  }

  @override
  bool isAssignableTo<Other>() {
    return isSubtypeOf<Other>();
  }

  @override
  List<T> createList(int length, {T? fill}) {
    if (fill != null) {
      return List<T>.filled(length, fill);
    }
    // For nullable T, we can use null as fill
    if (null is T) {
      return List<T>.filled(length, null as T);
    }
    throw ArgumentError('fill is required for non-nullable type $T');
  }

  @override
  List<T> createGrowableList() {
    return <T>[];
  }

  @override
  Set<T> createSet() {
    return <T>{};
  }

  @override
  Iterable<T> createIterable(Iterable<T> elements) {
    return elements;
  }

  /// Runtime subtype check helper.
  static bool _isSubtype<Sub, Super>() {
    // Use a trick: create a function that accepts Super,
    // and check if it accepts Sub
    void Function(Super) superFn;
    try {
      // ignore: unused_local_variable
      superFn = (_) {};
      // If Sub is a subtype of Super, this cast should work
      // ignore: unnecessary_cast
      final subFn = superFn as void Function(Sub);
      // ignore: unnecessary_null_comparison
      return subFn != null;
    } catch (_) {
      return false;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TypedFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [Typed] elements.
class TypedFilter<T> {
  /// Filter by subtype relationship.
  final bool Function(Typed<T>)? filter;

  const TypedFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(Typed<T> typed) {
    return filter?.call(typed) ?? true;
  }

  /// Create a filter that matches types that are subtypes of [Super].
  static TypedFilter<T> isSubtypeOf<T, Super>() => TypedFilter<T>(
        filter: (typed) => typed.isSubtypeOf<Super>(),
      );

  /// Create a filter that matches types that are supertypes of [Sub].
  static TypedFilter<T> isSupertypeOf<T, Sub>() => TypedFilter<T>(
        filter: (typed) => typed.isSupertypeOf<Sub>(),
      );

  /// Create a filter that matches the exact type.
  static TypedFilter<T> exactType<T, MatchType>() => TypedFilter<T>(
        filter: (typed) => typed.reflectedType == MatchType,
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// TypedProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [Typed] elements.
class TypedProcessor<T> {
  /// Process any typed element.
  final void Function(Typed<T>)? process;

  const TypedProcessor({this.process});

  /// Execute the processor.
  void execute(Typed<T> typed) {
    process?.call(typed);
  }
}
