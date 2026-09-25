import 'package:tom_d4rt/d4rt.dart';

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

  /// SCD145 — the clause a member error should carry when its receiver is a
  /// NATIVE object that **no bridge claims**.
  ///
  /// `Environment.toBridgedClass` throws
  /// `Cannot bridge native object: No registered bridged class found for native
  /// type …` and [toBridgedInstance] above catches it, `revoke()`s it and
  /// returns `(null, false)`. That catch is correct and load-bearing: its
  /// callers use the `false` as a CONTROL-FLOW signal and fall through to other
  /// registries, because an interpreter-internal value legitimately has no
  /// bridge. The cost is that the real cause is gone by the time the
  /// fallthrough chain gives up, and what the script author sees is
  ///
  ///     Undefined property or method 'moveNext' on _TallyIterator
  ///
  /// which points at the member. The reader goes looking for a missing method
  /// on a bridge that does not exist.
  ///
  /// This recovers the cause at the point of failure. It changes only the
  /// MESSAGE — not the exception type, not `memberName`, not `receiver`, and not
  /// the control flow. `environment.dart`'s own note records why widening
  /// resolution instead broke 43 enum-dispatch tests: callers use the throw as
  /// a signal. A message change on a path that is already failing cannot
  /// regress a passing one.
  ///
  /// Returns `''` for anything that is not in that situation, and the two
  /// exclusions are the interesting part:
  ///
  ///   * **Interpreter-internal values.** Tested against the abstractions the
  ///     interpreter owns — `RuntimeValue`, `RuntimeType`, `Callable`,
  ///     `InterpretedRecord` — rather than a list of concrete types, because a
  ///     list is what rots when a new value shape appears. A script-declared
  ///     class has no bridge and is not supposed to, so saying so would be
  ///     noise on every script typo.
  ///   * **Types a bridge DOES claim.** There the member really is the problem
  ///     and the new wording would be a lie.
  /// Dart's callable-object rule for an interpreted instance: `a(3)` means
  /// `a.call(3)` when the class, a superclass or a mixin declares an
  /// instance method named `call`. Returns that method bound to [value], or
  /// null when [value] is not such an instance.
  ///
  /// Both call paths ask this before deciding a value is not callable. Until
  /// SCE176 neither did: a call through a variable fell through to returning
  /// the instance itself, and a call through an expression threw.
  Callable? interpretedCallMethod(Object? value) {
    if (value is! InterpretedInstance) return null;
    return value.klass.findInstanceMethod('call')?.bind(value);
  }

  String unbridgedNativeClause(Object? receiver) {
    if (receiver == null) return '';
    if (receiver is RuntimeValue ||
        receiver is RuntimeType ||
        receiver is Callable ||
        receiver is InterpretedRecord) {
      return '';
    }
    try {
      globalEnvironment.toBridgedInstance(receiver);
      return '';
    } catch (e) {
      if (e is D4rtException) e.revoke();
      final type = receiver.runtimeType;
      return ' No bridge claims this type: no bridged class is registered for the '
          'native type $type, so the object was never bridged and has no '
          'members at all — the missing member is a consequence. Register a '
          "bridge for $type, or add '$type' to an existing bridge's "
          '`nativeNames`.';
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
  ///
  /// Mirror of tom_d4rt_ast `lookupOnBridgedSupertypes`.
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
