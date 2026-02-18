/// MethodMirror - Reflects a method (instance or static).
///
/// Methods are invokable elements that belong to a class, mixin, or extension.
library;

import 'element.dart';
import 'annotation_mirror.dart';
import 'generic_element.dart';
import 'invokable.dart';
import 'owned_element.dart';
import 'parameter_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// MethodMirror
// ═══════════════════════════════════════════════════════════════════════════

/// Reflects a method (instance or static).
///
/// Methods have:
/// - Parameters and return type
/// - Type parameters (if generic)
/// - Owner (the class/mixin/extension they belong to)
/// - Modifiers (static, abstract, async, etc.)
abstract class MethodMirror<R>
    with
        ElementMixin,
        InvokableMixin<R>,
        OwnedElementMixin,
        GenericElementMixin
    implements Element, Invokable<R>, OwnedElement, GenericElement {
  // ─────────────────────────────────────────────────────────────────────────
  // Element Implementation
  // ─────────────────────────────────────────────────────────────────────────

  @override
  String get name;

  @override
  String get qualifiedName;

  @override
  String get libraryUri;

  @override
  String get package;

  @override
  ElementKind get kind => ElementKind.method;

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
  // GenericElement Implementation
  // ─────────────────────────────────────────────────────────────────────────

  @override
  List<TypeParameterMirror> get typeParameters;

  // ─────────────────────────────────────────────────────────────────────────
  // OwnedElement Implementation
  // ─────────────────────────────────────────────────────────────────────────

  @override
  Element? get owner;

  @override
  String? get declaringTypeName;

  @override
  bool get isInherited;

  // ─────────────────────────────────────────────────────────────────────────
  // Method Properties
  // ─────────────────────────────────────────────────────────────────────────

  /// The return type as a string.
  String get returnTypeName;

  /// Whether this is a static method.
  bool get isStatic;

  /// Whether this is an abstract method.
  bool get isAbstract;

  /// Whether this is an async method.
  bool get isAsync;

  /// Whether this is a generator method (sync* or async*).
  bool get isGenerator;

  /// Whether this is an operator method.
  bool get isOperator;

  /// The operator symbol if this is an operator (e.g., '+', '[]', '==').
  String? get operatorSymbol;

  /// Documentation comment for this method.
  String? get docComment;
}

// ═══════════════════════════════════════════════════════════════════════════
// MethodMirrorFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [MethodMirror] elements.
class MethodMirrorFilter<R> {
  /// Filter function.
  final bool Function(MethodMirror<R>)? filter;

  const MethodMirrorFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(MethodMirror<R> method) {
    return filter?.call(method) ?? true;
  }

  /// Filter for static methods.
  static MethodMirrorFilter<R> static_<R>() => MethodMirrorFilter<R>(
        filter: (m) => m.isStatic,
      );

  /// Filter for instance methods.
  static MethodMirrorFilter<R> instance<R>() => MethodMirrorFilter<R>(
        filter: (m) => !m.isStatic,
      );

  /// Filter for abstract methods.
  static MethodMirrorFilter<R> abstract_<R>() => MethodMirrorFilter<R>(
        filter: (m) => m.isAbstract,
      );

  /// Filter for async methods.
  static MethodMirrorFilter<R> async_<R>() => MethodMirrorFilter<R>(
        filter: (m) => m.isAsync,
      );

  /// Filter for operator methods.
  static MethodMirrorFilter<R> operator_<R>() => MethodMirrorFilter<R>(
        filter: (m) => m.isOperator,
      );

  /// Filter for methods with no parameters.
  static MethodMirrorFilter<R> noParameters<R>() => MethodMirrorFilter<R>(
        filter: (m) => m.parameters.isEmpty,
      );

  /// Filter for methods that are invokable.
  static MethodMirrorFilter<R> invokable<R>() => MethodMirrorFilter<R>(
        filter: (m) => m.hasInvoker,
      );

  /// Filter for inherited methods.
  static MethodMirrorFilter<R> inherited<R>() => MethodMirrorFilter<R>(
        filter: (m) => m.isInherited,
      );

  /// Filter for declared (non-inherited) methods.
  static MethodMirrorFilter<R> declared<R>() => MethodMirrorFilter<R>(
        filter: (m) => !m.isInherited,
      );

  /// Filter by return type name.
  static MethodMirrorFilter<R> returnType<R>(String typeName) =>
      MethodMirrorFilter<R>(
        filter: (m) => m.returnTypeName == typeName,
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// MethodMirrorProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [MethodMirror] elements.
class MethodMirrorProcessor<R> {
  /// Process any method mirror.
  final void Function(MethodMirror<R>)? process;

  const MethodMirrorProcessor({this.process});

  /// Execute the processor.
  void execute(MethodMirror<R> method) {
    process?.call(method);
  }
}
