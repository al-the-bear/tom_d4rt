/// Common interface for types defined at runtime (interpreted or bridged).
abstract class RuntimeType {
  /// The name of the type.
  String get name;

  /// Checks if this type is a subtype of [other].
  bool isSubtypeOf(RuntimeType other, {Object? value});
}

/// Common interface for values defined at runtime (interpreted or bridged instances).
abstract class RuntimeValue {
  /// The runtime type of this value.
  RuntimeType get valueType;

  /// Accesses a property or method of this value.
  Object? get(String name);

  /// Sets a property of this value.
  void set(String name, Object? value);
}

/// Marker for native objects produced by an interface-proxy factory that
/// wrap an [InterpretedInstance].
///
/// **Why this exists:** When a script subclasses a bridged type whose
/// downstream native API (e.g., `RenderObject.parentData = _MyParentData()`)
/// requires a native instance, a runtime registration produces a
/// `_InterpretedX` proxy that satisfies the native `is`-check. The original
/// [InterpretedInstance] is cached on the proxy.
///
/// On the way back, the script may cast that proxy to its scripted subtype
/// (e.g., `child.parentData! as _MyParentData`) and access user-defined
/// fields/methods on it. Without unwrap support the cast returns the bridged
/// proxy, and field access fails because the bridge knows nothing about the
/// scripted members.
///
/// Proxies that hold a back-reference to an interpreted instance should
/// implement this marker. `visitAsExpression` checks for it and unwraps
/// to [d4rtInstance] when the cast target name matches a class/mixin/
/// interface in the instance's class chain.
abstract class D4InterpretedProxy {
  /// The interpreted instance wrapped by this native proxy.
  Object get d4rtInstance;
}
