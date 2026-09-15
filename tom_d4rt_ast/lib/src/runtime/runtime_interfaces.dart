import 'bridge/bridged_types.dart';

/// Common interface for types defined at runtime (interpreted or bridged).
abstract class RuntimeType {
  /// The name of the type.
  String get name;

  /// Checks if this type is a subtype of [other].
  bool isSubtypeOf(RuntimeType other, {Object? value});
}

/// True for the names that denote a TOP TYPE — one every value inhabits.
///
/// `dynamic`, `Object`, `Object?` and `void`. Treating them as "matches
/// anything" keeps a comparison permissive exactly where Dart's own
/// assignability is permissive, which matters most on annotations the
/// interpreter can only resolve coarsely.
///
/// **One predicate, because three used to disagree.** SCD90 measured the
/// question `X <: <top>` across the implementations of [RuntimeType] and found
/// [NamedRuntimeType] and `TypeParameter` answering `true` for all of
/// `Object` / `dynamic` / `void`, while `BridgedClass` answered `true` only for
/// a `BridgedClass` named `Object` — false for `dynamic`, for `void`, and for
/// every [NamedRuntimeType] target including `Object`, which is the sentinel
/// this very file documents as how `dynamic` is spelled when a richer type
/// object is unavailable. Five of six cells wrong in one implementation, right
/// in the others. So the fix is one shared answer rather than a fourth private
/// copy of it.
///
/// `Object?` is included although nothing was measured spelling it: a type
/// whose name is literally `Object?` can only be the nullable top type, so
/// admitting it cannot be wrong, and omitting it would be the next asymmetry.
bool isTopTypeName(String n) =>
    n == 'dynamic' || n == 'Object' || n == 'Object?' || n == 'void';

/// Deprecated spelling kept for the structural helpers below, which read better
/// with the old name at their call sites.
bool _isWildcardTypeName(String n) => isTopTypeName(n);

/// Structural field/parameter compatibility used by [FunctionRuntimeType] and
/// [RecordRuntimeType]. Independent of the concrete [RuntimeType] class so it
/// works uniformly across bridged classes, named sentinels, and nested
/// function/record types (where the concrete `isSubtypeOf` implementations do
/// not know about each other).
bool _runtimeTypeCompatible(RuntimeType sub, RuntimeType sup) {
  if (_isWildcardTypeName(sub.name) || _isWildcardTypeName(sup.name)) {
    return true;
  }
  if (sub.name == sup.name) return true;
  return sub.isSubtypeOf(sup);
}

/// A minimal, self-contained [RuntimeType] identified purely by name. Used as a
/// sentinel for `dynamic` return/parameter types when a richer type object is
/// unavailable, and as a fallback for parameter types the resolver cannot map
/// to a concrete class.
class NamedRuntimeType implements RuntimeType {
  @override
  final String name;

  const NamedRuntimeType(this.name);

  @override
  bool isSubtypeOf(RuntimeType other, {Object? value}) {
    if (_isWildcardTypeName(name) || _isWildcardTypeName(other.name)) {
      return true;
    }
    return name == other.name;
  }

  @override
  String toString() => name;
}

/// Runtime model of a function type such as `int Function(String, [double])` or
/// `void Function({int count})`. Subtyping is structural: return type
/// covariant, parameters contravariant, arities and named-parameter shape must
/// line up.
class FunctionRuntimeType implements RuntimeType {
  final RuntimeType returnType;
  final List<RuntimeType> positionalParameterTypes;
  final List<RuntimeType> optionalPositionalParameterTypes;
  final Map<String, RuntimeType> namedParameterTypes;

  const FunctionRuntimeType({
    required this.returnType,
    this.positionalParameterTypes = const [],
    this.optionalPositionalParameterTypes = const [],
    this.namedParameterTypes = const {},
  });

  /// A function type with no declared shape — used as the default for callables
  /// whose parameter/return annotations could not be resolved. It matches any
  /// other function type.
  factory FunctionRuntimeType.untyped() =>
      const FunctionRuntimeType(returnType: NamedRuntimeType('dynamic'));

  bool get _isUntyped =>
      _isWildcardTypeName(returnType.name) &&
      positionalParameterTypes.isEmpty &&
      optionalPositionalParameterTypes.isEmpty &&
      namedParameterTypes.isEmpty;

  @override
  String get name {
    final params = <String>[
      ...positionalParameterTypes.map((t) => t.name),
      if (optionalPositionalParameterTypes.isNotEmpty)
        '[${optionalPositionalParameterTypes.map((t) => t.name).join(', ')}]',
      if (namedParameterTypes.isNotEmpty)
        '{${namedParameterTypes.entries.map((e) => '${e.value.name} ${e.key}').join(', ')}}',
    ];
    return '${returnType.name} Function(${params.join(', ')})';
  }

  @override
  bool isSubtypeOf(RuntimeType other, {Object? value}) {
    if (other is FunctionRuntimeType) {
      // An untyped function type matches any function and vice-versa.
      if (_isUntyped || other._isUntyped) return true;
      // Return type is covariant.
      if (!_runtimeTypeCompatible(returnType, other.returnType)) return false;
      // Required positional parameters must line up 1:1 (contravariant).
      if (positionalParameterTypes.length !=
          other.positionalParameterTypes.length) {
        return false;
      }
      for (var i = 0; i < positionalParameterTypes.length; i++) {
        if (!_runtimeTypeCompatible(
          other.positionalParameterTypes[i],
          positionalParameterTypes[i],
        )) {
          return false;
        }
      }
      // Named parameters: every named parameter the supertype declares must be
      // present here with a contravariant-compatible type.
      for (final entry in other.namedParameterTypes.entries) {
        final mine = namedParameterTypes[entry.key];
        if (mine == null) return false;
        if (!_runtimeTypeCompatible(entry.value, mine)) return false;
      }
      return true;
    }
    // GEN-125 / SCD136 — a function TYPEDEF is bridged as
    // `BridgedClass(nativeType: Function, name: typedef.name)`, so its name is
    // `VoidCallback`, never `Function`. The name is the one property of that
    // bridge deliberately not `Function`, so the nominal test below could
    // never match one and every Flutter callback was refused:
    //
    //     type 'dynamic Function()' is not a subtype of type 'VoidCallback?'
    //
    // Ask what the bridge IS rather than what it is called. This subsumes the
    // nominal test — `dart:core`'s own `Function` bridge carries
    // `nativeType: Function` too — and because the argument check, the return
    // check and `is`/`as` all route through here, one rule repairs all three.
    //
    // WHY THIS FILE MAY KNOW ABOUT `BridgedClass`, given that it is the
    // interface file everything else depends on: it already did. The line
    // below is a STRING GUESS about how bridges are named, which is the same
    // coupling in its worst form. Replacing a guess about an implementor with
    // a typed question to it removes knowledge from this file rather than
    // adding it.
    //
    // Deliberately arity-blind, exactly as the nominal test it subsumes was: a
    // bridged typedef carries `nativeType: Function` and nothing else, so
    // there is no signature here to check a closure against. Making the bridge
    // carry one is a generator change, tracked as scd137. Until then the
    // posture is the documented one — be permissive rather than reject working
    // callbacks.
    if (other is BridgedClass && other.nativeType == Function) {
      // SCD137 — when the bridge carries the typedef's positional arity, a
      // callable that PROVABLY cannot be invoked is refused here instead of
      // throwing later at the call, with a message that names neither the
      // parameter nor the typedef.
      //
      // The rule is deliberately the conservative one. Only the typedef's
      // REQUIRED count is checked: that is the one invocation shape it
      // guarantees, and rejecting on a possibility is how a working callback
      // gets refused. Optional positionals on the callable side count toward
      // what it can accept, so `(a, [b]) {}` serves a one-argument typedef.
      //
      // No arity means no opinion — scd136's acceptance, unchanged. Every
      // `.b.dart` generated before the generator carried signatures through is
      // in that state, so this is inert until both have shipped.
      final required = other.typedefRequiredPositional;
      if (required == null) return true;
      final minAccepted = positionalParameterTypes.length;
      final maxAccepted = minAccepted + optionalPositionalParameterTypes.length;
      return minAccepted <= required && required <= maxAccepted;
    }
    // Every function is a `Function` and an `Object`.
    return _isWildcardTypeName(other.name) || other.name == 'Function';
  }

  @override
  String toString() => name;
}

/// Runtime model of a record type such as `(int, String)` or
/// `(int, {String label})`. Subtyping requires an identical shape (same
/// positional arity, same named keys) with each field compatible.
class RecordRuntimeType implements RuntimeType {
  final List<RuntimeType> positionalFieldTypes;
  final Map<String, RuntimeType> namedFieldTypes;

  const RecordRuntimeType({
    this.positionalFieldTypes = const [],
    this.namedFieldTypes = const {},
  });

  @override
  String get name {
    final parts = <String>[
      ...positionalFieldTypes.map((t) => t.name),
      if (namedFieldTypes.isNotEmpty)
        '{${namedFieldTypes.entries.map((e) => '${e.value.name} ${e.key}').join(', ')}}',
    ];
    return '(${parts.join(', ')})';
  }

  @override
  bool isSubtypeOf(RuntimeType other, {Object? value}) {
    if (other is RecordRuntimeType) {
      if (positionalFieldTypes.length != other.positionalFieldTypes.length) {
        return false;
      }
      if (namedFieldTypes.length != other.namedFieldTypes.length) return false;
      for (var i = 0; i < positionalFieldTypes.length; i++) {
        if (!_runtimeTypeCompatible(
          positionalFieldTypes[i],
          other.positionalFieldTypes[i],
        )) {
          return false;
        }
      }
      for (final entry in other.namedFieldTypes.entries) {
        final mine = namedFieldTypes[entry.key];
        if (mine == null) return false;
        if (!_runtimeTypeCompatible(mine, entry.value)) return false;
      }
      return true;
    }
    // Every record is a `Record` and an `Object`.
    return _isWildcardTypeName(other.name) || other.name == 'Record';
  }

  @override
  String toString() => name;
}

/// Runtime model of a generic type applied to concrete type arguments, such as
/// `Box<int>` or `List<String>`. Preserves the applied type arguments at
/// runtime so `is Box<int>` and generic/collection return-type checks can
/// compare the arguments element-wise instead of collapsing to the raw base
/// type. Ports the applied-runtime-types half of upstream 1042fff.
///
/// Subtyping is base-then-arguments: the [baseType]s must be compatible
/// (wildcard / name-equality / base `isSubtypeOf`), then each declared type
/// argument on [other] is matched against the corresponding argument here. An
/// `other` argument named `dynamic`/`Object`/`void` acts as a wildcard. When
/// [other] is not itself an [AppliedRuntimeType] (a raw base type or a
/// structural function/record type), the comparison falls back to the base type
/// only — a `Box<int>` is still a `Box`, an `Object`, etc. Differing arities
/// also stay permissive, so coarsely-resolved (partially-applied) annotations
/// don't regress.
class AppliedRuntimeType implements RuntimeType {
  final RuntimeType baseType;
  final List<RuntimeType> typeArguments;

  AppliedRuntimeType(this.baseType, List<RuntimeType> typeArguments)
    : typeArguments = List.unmodifiable(typeArguments);

  @override
  String get name =>
      '${baseType.name}<${typeArguments.map((t) => t.name).join(', ')}>';

  @override
  bool isSubtypeOf(RuntimeType other, {Object? value}) {
    if (other is AppliedRuntimeType) {
      if (!_runtimeTypeCompatible(baseType, other.baseType)) return false;
      // Only compare arguments when both sides declare the same arity; a
      // mismatch stays permissive so partially-applied annotations don't fail.
      if (typeArguments.length != other.typeArguments.length) return true;
      for (var i = 0; i < typeArguments.length; i++) {
        final theirs = other.typeArguments[i];
        if (_isWildcardTypeName(theirs.name)) continue;
        if (!_runtimeTypeCompatible(typeArguments[i], theirs)) return false;
      }
      return true;
    }
    // Comparing an applied type against a raw base / structural type: match on
    // the base type only.
    return _runtimeTypeCompatible(baseType, other);
  }

  @override
  String toString() => name;
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
