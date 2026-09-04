import 'package:tom_d4rt_ast/runtime.dart';

extension InterpreterVisitorExtension on InterpreterVisitor {
  (BridgedInstance?, bool) toBridgedInstance(
    Object? nativeObject, {
    String? methodName,
  }) {
    //adjustment for the extension method
    if (methodName != null) {
      final extensionCallable = environment.findExtensionMember(
        nativeObject,
        methodName,
      );
      if (extensionCallable is ExtensionMemberCallable) {
        return (null, false);
      }
    }
    if (nativeObject == null) {
      return (null, false);
    }
    if (nativeObject is BridgedInstance) {
      return (nativeObject, true);
    }
    try {
      return (globalEnvironment.toBridgedInstance(nativeObject), true);
    } catch (e) {
      // Revoke the error since we're handling it gracefully by returning false
      // This prevents spurious "BridgedClass not registered" errors when
      // the target is an internal D4rt type (BridgedEnum, BridgedClass, etc.)
      if (e is D4rtException) {
        e.revoke();
      }
      return (null, false);
    }
  }

  /// Cluster-12 (priority 3): Walks the registered supertype chain of
  /// [bridgedInstance]'s class and returns the first matching getter result
  /// or method tear-off for [propertyName]. Used as a fallback in property
  /// access when the leaf bridge has no matching adapter.
  ///
  /// Concrete motivating case: `_AnimatedEvaluation<T>` (the private class
  /// returned by `Tween.animate(parent)`) extends `Animation<T>` with
  /// `AnimationWithParentMixin<double>`. `Environment.toBridgedInstance`
  /// wraps it as `AnimationWithParentMixin` (the leaf picked by
  /// `_filterToMostSpecific`), but the mixin's bridge only exposes
  /// `parent`/`status`. The `value` getter is declared on `Animation<T>`
  /// (the mixin's supertype), and the supertype walk recovers it.
  ///
  /// Returns `(value, true)` on a match, `(null, false)` otherwise. The
  /// walk relies on `BridgedClass.transitiveSupertypeNames`, which returns
  /// ancestor class names recorded via `BridgedClass.registerSupertypes`
  /// (typically in the bridge package's `d4rt_runtime_registrations.dart`).
  /// For unregistered classes the walk is a no-op.
  (Object?, bool) lookupOnBridgedSupertypes(
    BridgedInstance bridgedInstance,
    String propertyName,
  ) {
    final supertypeNames = BridgedClass.transitiveSupertypeNames(
      bridgedInstance.bridgedClass.name,
    );
    for (final superName in supertypeNames) {
      final superBridge = environment.findBridgedClassByName(superName);
      if (superBridge == null) continue;
      final superGetter = superBridge.findInstanceGetterAdapter(propertyName);
      if (superGetter != null) {
        return (superGetter(this, bridgedInstance.nativeObject), true);
      }
      final superMethod = superBridge.findInstanceMethodAdapter(propertyName);
      if (superMethod != null) {
        return (
          BridgedMethodCallable(bridgedInstance, superMethod, propertyName),
          true,
        );
      }
    }
    return (null, false);
  }
}
