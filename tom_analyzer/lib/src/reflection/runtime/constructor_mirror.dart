/// ConstructorMirror - Reflects a constructor (named, unnamed, or factory).
///
/// Constructors are invokable elements that create instances of a class.
library;

import 'element.dart';
import 'annotation_mirror.dart';
import 'invokable.dart';
import 'owned_element.dart';
import 'parameter_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// ConstructorMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a constructor (named, unnamed, or factory).
///
/// Constructors have:
/// - Parameters for instance creation
/// - Owner (the class they belong to)
/// - Modifiers (factory, const, redirecting)
abstract class ConstructorMirror<T>
    with ElementMixin, InvokableMixin<T>, OwnedElementMixin
    implements Element, Invokable<T>, OwnedElement {
  // ─────────────────────────────────────────────────────────────────────────
  // Element Implementation
  // ─────────────────────────────────────────────────────────────────────────

  /// The constructor name.
  ///
  /// - Empty string for unnamed constructors
  /// - 'fromJson' for `MyClass.fromJson(...)`
  @override
  String get name;

  @override
  String get qualifiedName;

  @override
  String get libraryUri;

  @override
  String get package;

  @override
  ElementKind get kind => ElementKind.constructor;

  @override
  List<AnnotationMirror> get annotations;

  // ─────────────────────────────────────────────────────────────────────────
  // Invokable Implementation
  // ─────────────────────────────────────────────────────────────────────────

  @override
  List<ParameterMirror> get parameters;

  @override
  bool get hasInvoker;

  @override
  int get invokerIndex;

  // ─────────────────────────────────────────────────────────────────────────
  // OwnedElement Implementation
  // ─────────────────────────────────────────────────────────────────────────

  @override
  Element? get owner;

  @override
  String? get declaringTypeName;

  @override
  bool get isInherited => false; // Constructors are never inherited

  @override
  bool get isGlobal => false; // Constructors always have an owner

  // ─────────────────────────────────────────────────────────────────────────
  // Constructor Properties
  // ─────────────────────────────────────────────────────────────────────────

  /// Whether this is the unnamed constructor.
  bool get isUnnamed => name.isEmpty;

  /// Whether this is a named constructor.
  bool get isNamed => name.isNotEmpty;

  /// Whether this is a factory constructor.
  bool get isFactory;

  /// Whether this is a const constructor.
  bool get isConst;

  /// Whether this is a redirecting constructor.
  bool get isRedirecting;

  /// Whether this constructor is external.
  bool get isExternal;

  /// Documentation comment for this constructor.
  String? get docComment;

  // ─────────────────────────────────────────────────────────────────────────
  // Instance Creation
  // ─────────────────────────────────────────────────────────────────────────

  /// Create a new instance using this constructor.
  ///
  /// ```dart
  /// final ctor = cls.constructors[''];
  /// final instance = ctor.newInstance(['Alice', 30]);
  /// ```
  T newInstance(List<dynamic> positional);

  /// Create a new instance with named parameters.
  ///
  /// ```dart
  /// final ctor = cls.constructors['fromJson'];
  /// final instance = ctor.newInstanceNamed([], {#name: 'Alice', #age: 30});
  /// ```
  T newInstanceNamed(List<dynamic> positional, Map<Symbol, dynamic> named);

  /// Create a new instance from a map of arguments.
  ///
  /// Arguments are matched to parameters by name.
  ///
  /// ```dart
  /// final ctor = cls.constructors['fromJson'];
  /// final instance = ctor.newInstanceFromMap({'name': 'Alice', 'age': 30});
  /// ```
  T newInstanceFromMap(Map<String, dynamic> args);
}

// ═══════════════════════════════════════════════════════════════════════════
// ConstructorMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [ConstructorMirror] elements.
class ConstructorMirrorFilter<T> {
  /// Filter function.
  final bool Function(ConstructorMirror<T>)? filter;

  const ConstructorMirrorFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(ConstructorMirror<T> ctor) {
    return filter?.call(ctor) ?? true;
  }

  /// Filter for unnamed constructors.
  static ConstructorMirrorFilter<T> unnamed<T>() => ConstructorMirrorFilter<T>(
        filter: (c) => c.isUnnamed,
      );

  /// Filter for named constructors.
  static ConstructorMirrorFilter<T> named<T>() => ConstructorMirrorFilter<T>(
        filter: (c) => c.isNamed,
      );

  /// Filter for factory constructors.
  static ConstructorMirrorFilter<T> factory_<T>() => ConstructorMirrorFilter<T>(
        filter: (c) => c.isFactory,
      );

  /// Filter for const constructors.
  static ConstructorMirrorFilter<T> const_<T>() => ConstructorMirrorFilter<T>(
        filter: (c) => c.isConst,
      );

  /// Filter for generative (non-factory) constructors.
  static ConstructorMirrorFilter<T> generative<T>() =>
      ConstructorMirrorFilter<T>(
        filter: (c) => !c.isFactory,
      );

  /// Filter for constructors that can be invoked.
  static ConstructorMirrorFilter<T> invokable<T>() =>
      ConstructorMirrorFilter<T>(
        filter: (c) => c.hasInvoker,
      );

  /// Filter for no-argument constructors.
  static ConstructorMirrorFilter<T> noArgs<T>() => ConstructorMirrorFilter<T>(
        filter: (c) =>
            c.requiredPositionalCount == 0 &&
            c.parameters.every((p) => !p.isNamed || !p.isRequired),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// ConstructorMirrorProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [ConstructorMirror] elements.
class ConstructorMirrorProcessor<T> {
  /// Process any constructor mirror.
  final void Function(ConstructorMirror<T>)? process;

  const ConstructorMirrorProcessor({this.process});

  /// Execute the processor.
  void execute(ConstructorMirror<T> ctor) {
    process?.call(ctor);
  }
}
