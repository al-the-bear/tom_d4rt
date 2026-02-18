/// Invokable trait for elements that can be invoked (methods, constructors, functions).
///
/// This trait provides a unified interface for invoking callable elements
/// with positional and named arguments.
library;

import 'parameter_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Invoker Types
// ═══════════════════════════════════════════════════════════════════════════

/// Invoker for instance methods.
typedef InstanceMethodInvoker = Object? Function(
  Object instance,
  List<dynamic> positional,
  Map<Symbol, dynamic> named,
);

/// Invoker for static methods and top-level functions.
typedef StaticMethodInvoker = Object? Function(
  List<dynamic> positional,
  Map<Symbol, dynamic> named,
);

/// Invoker for constructors.
typedef ConstructorInvoker<T> = T Function(
  List<dynamic> positional,
  Map<Symbol, dynamic> named,
);

// ═══════════════════════════════════════════════════════════════════════════
// Invokable Trait
// ═══════════════════════════════════════════════════════════════════════════

/// Trait for elements that can be invoked.
///
/// This includes methods, constructors, and top-level functions.
/// Provides multiple invocation styles for convenience.
abstract class Invokable<R> {
  /// Parameters of this invokable element.
  List<ParameterMirror> get parameters;

  /// Whether this element has an invoker (can be called).
  ///
  /// Elements without invokers are declaration-only (metadata available
  /// but not invokable, typically from external packages).
  bool get hasInvoker;

  /// The index of this element's invoker in the invoker table.
  ///
  /// Negative values indicate declaration-only elements (no invoker).
  int get invokerIndex;

  // ─────────────────────────────────────────────────────────────────────────
  // Invocation Methods
  // ─────────────────────────────────────────────────────────────────────────

  /// Invoke with positional arguments only.
  ///
  /// ```dart
  /// final method = cls.methods['greet'];
  /// method.invoke(instance, ['Hello', 42]);
  /// ```
  R invoke(Object? target, List<dynamic> positional);

  /// Invoke with named arguments.
  ///
  /// ```dart
  /// final method = cls.methods['configure'];
  /// method.invokeNamed(instance, [], {#timeout: 30, #retries: 3});
  /// ```
  R invokeNamed(
    Object? target,
    List<dynamic> positional,
    Map<Symbol, dynamic> named,
  );

  /// Invoke with a map of argument names to values.
  ///
  /// This is useful for JSON-like invocation where you have
  /// string keys instead of symbols.
  ///
  /// ```dart
  /// final ctor = cls.constructors['fromJson'];
  /// final instance = ctor.invokeWithMap(null, {'name': 'Alice', 'age': 30});
  /// ```
  R invokeWithMap(Object? target, Map<String, dynamic> args);

  /// Invoke with a list of all arguments (positional followed by named).
  ///
  /// The arguments are matched to parameters in order.
  R invokeWithList(Object? target, List<dynamic> args);

  // ─────────────────────────────────────────────────────────────────────────
  // Parameter Helpers
  // ─────────────────────────────────────────────────────────────────────────

  /// Get the positional parameters.
  List<ParameterMirror> get positionalParameters =>
      parameters.where((p) => !p.isNamed).toList();

  /// Get the named parameters.
  List<ParameterMirror> get namedParameters =>
      parameters.where((p) => p.isNamed).toList();

  /// Get the required parameters.
  List<ParameterMirror> get requiredParameters =>
      parameters.where((p) => p.isRequired).toList();

  /// Get the optional parameters.
  List<ParameterMirror> get optionalParameters =>
      parameters.where((p) => !p.isRequired).toList();

  /// Get the number of required positional parameters.
  int get requiredPositionalCount =>
      parameters.where((p) => !p.isNamed && p.isRequired).length;

  /// Get the number of optional positional parameters.
  int get optionalPositionalCount =>
      parameters.where((p) => !p.isNamed && !p.isRequired).length;

  /// Check if a parameter with the given name exists.
  bool hasParameter(String name) => parameters.any((p) => p.name == name);

  /// Get a parameter by name, or null if not found.
  ParameterMirror? getParameter(String name) {
    for (final param in parameters) {
      if (param.name == name) return param;
    }
    return null;
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// InvokableMixin - Default Implementation
// ═══════════════════════════════════════════════════════════════════════════

/// Mixin providing default implementations for [Invokable] methods.
mixin InvokableMixin<R> implements Invokable<R> {
  @override
  R invokeWithMap(Object? target, Map<String, dynamic> args) {
    final positional = <dynamic>[];
    final named = <Symbol, dynamic>{};

    for (final param in parameters) {
      if (args.containsKey(param.name)) {
        if (param.isNamed) {
          named[Symbol(param.name)] = args[param.name];
        } else {
          positional.add(args[param.name]);
        }
      }
    }

    return invokeNamed(target, positional, named);
  }

  @override
  R invokeWithList(Object? target, List<dynamic> args) {
    final positional = <dynamic>[];
    final named = <Symbol, dynamic>{};

    var argIndex = 0;
    for (final param in parameters) {
      if (argIndex >= args.length) break;

      if (param.isNamed) {
        named[Symbol(param.name)] = args[argIndex];
      } else {
        positional.add(args[argIndex]);
      }
      argIndex++;
    }

    return invokeNamed(target, positional, named);
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// InvokableFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [Invokable] elements.
class InvokableFilter<R> {
  /// Filter function.
  final bool Function(Invokable<R>)? filter;

  const InvokableFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(Invokable<R> invokable) {
    return filter?.call(invokable) ?? true;
  }

  /// Create a filter that matches invokables with a specific parameter count.
  static InvokableFilter<R> parameterCount<R>(int count) => InvokableFilter<R>(
        filter: (inv) => inv.parameters.length == count,
      );

  /// Create a filter that matches invokables with at least N parameters.
  static InvokableFilter<R> minParameters<R>(int min) => InvokableFilter<R>(
        filter: (inv) => inv.parameters.length >= min,
      );

  /// Create a filter that matches invokables with at most N parameters.
  static InvokableFilter<R> maxParameters<R>(int max) => InvokableFilter<R>(
        filter: (inv) => inv.parameters.length <= max,
      );

  /// Create a filter that matches invokables with a parameter of the given name.
  static InvokableFilter<R> hasParameter<R>(String name) => InvokableFilter<R>(
        filter: (inv) => inv.hasParameter(name),
      );

  /// Create a filter that matches only invokables with invokers.
  static InvokableFilter<R> hasInvoker<R>() => InvokableFilter<R>(
        filter: (inv) => inv.hasInvoker,
      );

  /// Create a filter that matches declaration-only invokables.
  static InvokableFilter<R> declarationOnly<R>() => InvokableFilter<R>(
        filter: (inv) => !inv.hasInvoker,
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// InvokableProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [Invokable] elements.
class InvokableProcessor<R> {
  /// Process any invokable element.
  final void Function(Invokable<R>)? process;

  const InvokableProcessor({this.process});

  /// Execute the processor.
  void execute(Invokable<R> invokable) {
    process?.call(invokable);
  }
}
