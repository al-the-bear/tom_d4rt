import 'package:tom_d4rt_ast/runtime.dart';

class ErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Error,
    name: 'Error',
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        return Error();
      },
    },
    staticMethods: {
      'safeToString': (visitor, positionalArgs, namedArgs, _) {
        return Error.safeToString(positionalArgs[0]);
      },
      // Rethrows `error` while keeping an *earlier* stack trace. Forwarding
      // to the native helper rather than re-`throw`ing is what preserves the
      // caller's trace; a plain `throw error` here would substitute this
      // frame and quietly defeat the only reason the member exists.
      'throwWithStackTrace': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 2) {
          throw RuntimeD4rtException(
            'Error.throwWithStackTrace(error, stackTrace) expects two '
            'positional arguments.',
          );
        }
        final stackTrace = positionalArgs[1];
        if (stackTrace is! StackTrace) {
          throw RuntimeD4rtException(
            'The second argument to Error.throwWithStackTrace must be a '
            'StackTrace.',
          );
        }
        Error.throwWithStackTrace(positionalArgs[0] as Object, stackTrace);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Error).toString();
      },
    },
    getters: {
      'hashCode': (visitor, target) => (target as Error).hashCode,
      'runtimeType': (visitor, target) => (target as Error).runtimeType,
      'stackTrace': (visitor, target) => (target as Error).stackTrace,
    },
  );
}

class StateErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: StateError,
    name: 'StateError',
    isAssignable: (v) => v is StateError,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final message = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String
            : '';
        return StateError(message);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as StateError).toString();
      },
    },
    getters: {
      'message': (visitor, target) => (target as StateError).message,
      'hashCode': (visitor, target) => (target as StateError).hashCode,
      'runtimeType': (visitor, target) => (target as StateError).runtimeType,
      'stackTrace': (visitor, target) => (target as StateError).stackTrace,
    },
  );
}

class ArgumentErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: ArgumentError,
    name: 'ArgumentError',
    isAssignable: (v) => v is ArgumentError,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final message = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
        return ArgumentError(message);
      },
      'value': (visitor, positionalArgs, namedArgs) {
        final value = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
        final name = positionalArgs.length > 1
            ? positionalArgs[1] as String?
            : null;
        final message = positionalArgs.length > 2 ? positionalArgs[2] : null;
        return ArgumentError.value(value, name, message);
      },
      'notNull': (visitor, positionalArgs, namedArgs) {
        final name = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String?
            : null;
        return ArgumentError.notNull(name);
      },
    },
    staticMethods: {
      // The single most-used validation helper in idiomatic Dart. Throwing
      // is its normal behaviour, and the thrown value must be the bridged
      // `ArgumentError` so an interpreted `on ArgumentError` clause matches
      // — which is exactly what letting the native helper raise gives us.
      'checkNotNull': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs.length > 2) {
          throw RuntimeD4rtException(
            'ArgumentError.checkNotNull(argument, [name]) expects one or '
            'two positional arguments.',
          );
        }
        final name = positionalArgs.length > 1
            ? positionalArgs[1] as String?
            : null;
        return ArgumentError.checkNotNull<Object>(positionalArgs[0], name);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as ArgumentError).toString();
      },
    },
    getters: {
      'message': (visitor, target) => (target as ArgumentError).message,
      'name': (visitor, target) => (target as ArgumentError).name,
      'invalidValue': (visitor, target) =>
          (target as ArgumentError).invalidValue,
      'hashCode': (visitor, target) => (target as ArgumentError).hashCode,
      'runtimeType': (visitor, target) => (target as ArgumentError).runtimeType,
      'stackTrace': (visitor, target) => (target as ArgumentError).stackTrace,
    },
  );
}

class RangeErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: RangeError,
    name: 'RangeError',
    isAssignable: (v) => v is RangeError,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final message = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String
            : '';
        return RangeError(message);
      },
      'value': (visitor, positionalArgs, namedArgs) {
        final value = positionalArgs[0] as num;
        final name = positionalArgs.length > 1
            ? positionalArgs[1] as String?
            : null;
        final message = positionalArgs.length > 2
            ? positionalArgs[2] as String?
            : null;
        return RangeError.value(value, name, message);
      },
      'range': (visitor, positionalArgs, namedArgs) {
        final invalidValue = positionalArgs[0] as num;
        final minValue = positionalArgs[1] as num?;
        final maxValue = positionalArgs[2] as num?;
        final name = positionalArgs.length > 3
            ? positionalArgs[3] as String?
            : null;
        final message = positionalArgs.length > 4
            ? positionalArgs[4] as String?
            : null;
        return RangeError.range(
          invalidValue,
          minValue as int?,
          maxValue as int?,
          name,
          message,
        );
      },
    },
    // The four `check*` validation helpers. Each takes its optional
    // arguments *positionally* — unlike `IndexError.check`, which takes
    // named ones. Reading them the other way round would compile and then
    // silently drop every diagnostic the caller supplied, so the shapes are
    // spelled out one member at a time rather than shared.
    staticMethods: {
      'checkNotNegative': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs.length > 3) {
          throw RuntimeD4rtException(
            'RangeError.checkNotNegative(value, [name, message]) expects '
            'one to three positional arguments.',
          );
        }
        return RangeError.checkNotNegative(
          positionalArgs[0] as int,
          positionalArgs.length > 1 ? positionalArgs[1] as String? : null,
          positionalArgs.length > 2 ? positionalArgs[2] as String? : null,
        );
      },
      'checkValidIndex': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length < 2 || positionalArgs.length > 5) {
          throw RuntimeD4rtException(
            'RangeError.checkValidIndex(index, indexable, [name, length, '
            'message]) expects two to five positional arguments.',
          );
        }
        return RangeError.checkValidIndex(
          positionalArgs[0] as int,
          positionalArgs[1],
          positionalArgs.length > 2 ? positionalArgs[2] as String? : null,
          positionalArgs.length > 3 ? positionalArgs[3] as int? : null,
          positionalArgs.length > 4 ? positionalArgs[4] as String? : null,
        );
      },
      'checkValidRange': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length < 3 || positionalArgs.length > 6) {
          throw RuntimeD4rtException(
            'RangeError.checkValidRange(start, end, length, [startName, '
            'endName, message]) expects three to six positional '
            'arguments.',
          );
        }
        return RangeError.checkValidRange(
          positionalArgs[0] as int,
          positionalArgs[1] as int?,
          positionalArgs[2] as int,
          positionalArgs.length > 3 ? positionalArgs[3] as String? : null,
          positionalArgs.length > 4 ? positionalArgs[4] as String? : null,
          positionalArgs.length > 5 ? positionalArgs[5] as String? : null,
        );
      },
      'checkValueInInterval': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length < 3 || positionalArgs.length > 5) {
          throw RuntimeD4rtException(
            'RangeError.checkValueInInterval(value, minValue, maxValue, '
            '[name, message]) expects three to five positional '
            'arguments.',
          );
        }
        RangeError.checkValueInInterval(
          positionalArgs[0] as int,
          positionalArgs[1] as int,
          positionalArgs[2] as int,
          positionalArgs.length > 3 ? positionalArgs[3] as String? : null,
          positionalArgs.length > 4 ? positionalArgs[4] as String? : null,
        );
        return null;
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as RangeError).toString();
      },
    },
    getters: {
      'start': (visitor, target) => (target as RangeError).start,
      'end': (visitor, target) => (target as RangeError).end,
      'message': (visitor, target) => (target as RangeError).message,
      'name': (visitor, target) => (target as RangeError).name,
      'invalidValue': (visitor, target) => (target as RangeError).invalidValue,
      'hashCode': (visitor, target) => (target as RangeError).hashCode,
      'runtimeType': (visitor, target) => (target as RangeError).runtimeType,
      'stackTrace': (visitor, target) => (target as RangeError).stackTrace,
    },
  );
}

class UnsupportedErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: UnsupportedError,
    name: 'UnsupportedError',
    isAssignable: (v) => v is UnsupportedError,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final message = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String
            : '';
        return UnsupportedError(message);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as UnsupportedError).toString();
      },
    },
    getters: {
      'message': (visitor, target) => (target as UnsupportedError).message,
      'hashCode': (visitor, target) => (target as UnsupportedError).hashCode,
      'runtimeType': (visitor, target) =>
          (target as UnsupportedError).runtimeType,
      'stackTrace': (visitor, target) =>
          (target as UnsupportedError).stackTrace,
    },
  );
}

class UnimplementedErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: UnimplementedError,
    name: 'UnimplementedError',
    isAssignable: (v) => v is UnimplementedError,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final message = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String?
            : null;
        return UnimplementedError(message);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as UnimplementedError).toString();
      },
    },
    getters: {
      'message': (visitor, target) => (target as UnimplementedError).message,
      'hashCode': (visitor, target) => (target as UnimplementedError).hashCode,
      'runtimeType': (visitor, target) =>
          (target as UnimplementedError).runtimeType,
      'stackTrace': (visitor, target) =>
          (target as UnimplementedError).stackTrace,
    },
  );
}

class NoSuchMethodErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: NoSuchMethodError,
    name: 'NoSuchMethodError',
    isAssignable: (v) => v is NoSuchMethodError,
    typeParameterCount: 0,
    constructors: {
      // The SDK's unnamed constructor is deprecated and throws; only
      // `withInvocation` is a usable entry point.
      'withInvocation': (visitor, positionalArgs, namedArgs) {
        return NoSuchMethodError.withInvocation(
          positionalArgs[0],
          positionalArgs[1] as Invocation,
        );
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as NoSuchMethodError).toString();
      },
    },
    getters: {
      // No `invocation` getter: the SDK keeps the captured Invocation
      // private and only surfaces it through `toString()`.
      'hashCode': (visitor, target) => (target as NoSuchMethodError).hashCode,
      'runtimeType': (visitor, target) =>
          (target as NoSuchMethodError).runtimeType,
      'stackTrace': (visitor, target) =>
          (target as NoSuchMethodError).stackTrace,
    },
  );
}

class ConcurrentModificationErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: ConcurrentModificationError,
    name: 'ConcurrentModificationError',
    isAssignable: (v) => v is ConcurrentModificationError,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        return ConcurrentModificationError(
          positionalArgs.isNotEmpty ? positionalArgs[0] : null,
        );
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as ConcurrentModificationError).toString();
      },
    },
    getters: {
      'modifiedObject': (visitor, target) =>
          (target as ConcurrentModificationError).modifiedObject,
      'hashCode': (visitor, target) =>
          (target as ConcurrentModificationError).hashCode,
      'runtimeType': (visitor, target) =>
          (target as ConcurrentModificationError).runtimeType,
      'stackTrace': (visitor, target) =>
          (target as ConcurrentModificationError).stackTrace,
    },
  );
}

/// `IndexError` — the `RangeError` subtype the SDK throws for out-of-bounds
/// indexing.
///
/// The subtype edge to `RangeError` is declared in [ErrorHierarchyCore], not
/// by widening `RangeErrorCore.isAssignable`: `isAssignable` is what decides
/// which bridge *owns* a native object, so leaving `RangeError`'s closure as
/// `v is RangeError` (which already answers true for an `IndexError`) while
/// registering `IndexError` with a narrower closure keeps the more specific
/// bridge winning dispatch.
class IndexErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: IndexError,
    name: 'IndexError',
    isAssignable: (v) => v is IndexError,
    typeParameterCount: 0,
    constructors: {
      'withLength': (visitor, positionalArgs, namedArgs) {
        return IndexError.withLength(
          positionalArgs[0] as int,
          positionalArgs[1] as int,
          indexable: namedArgs['indexable'],
          name: namedArgs['name'] as String?,
          message: namedArgs['message'] as String?,
        );
      },
    },
    staticMethods: {
      // `IndexError.check(index, length, {indexable, name, message})` — the
      // only member of this family whose optional arguments are *named*.
      // Reading them from `positionalArgs` would compile and then ignore
      // everything the caller passed.
      'check': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 2) {
          throw RuntimeD4rtException(
            'IndexError.check(index, length, {indexable, name, message}) '
            'expects two positional arguments.',
          );
        }
        return IndexError.check(
          positionalArgs[0] as int,
          positionalArgs[1] as int,
          indexable: namedArgs['indexable'],
          name: namedArgs['name'] as String?,
          message: namedArgs['message'] as String?,
        );
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as IndexError).toString();
      },
    },
    getters: {
      'indexable': (visitor, target) => (target as IndexError).indexable,
      'length': (visitor, target) => (target as IndexError).length,
      'start': (visitor, target) => (target as IndexError).start,
      'end': (visitor, target) => (target as IndexError).end,
      'message': (visitor, target) => (target as IndexError).message,
      'name': (visitor, target) => (target as IndexError).name,
      'invalidValue': (visitor, target) => (target as IndexError).invalidValue,
      'hashCode': (visitor, target) => (target as IndexError).hashCode,
      'runtimeType': (visitor, target) => (target as IndexError).runtimeType,
      'stackTrace': (visitor, target) => (target as IndexError).stackTrace,
    },
  );
}

/// `TypeError` — thrown by failed casts and type checks.
///
/// `nativeNames` carries `_TypeError` because that is the private class the
/// VM actually instantiates; without it a natively-thrown cast failure would
/// reach no bridge at all.
class TypeErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: TypeError,
    name: 'TypeError',
    nativeNames: const ['_TypeError'],
    isAssignable: (v) => v is TypeError,
    typeParameterCount: 0,
    constructors: {'': (visitor, positionalArgs, namedArgs) => TypeError()},
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as TypeError).toString();
      },
    },
    getters: {
      'hashCode': (visitor, target) => (target as TypeError).hashCode,
      'runtimeType': (visitor, target) => (target as TypeError).runtimeType,
      'stackTrace': (visitor, target) => (target as TypeError).stackTrace,
    },
  );
}

/// `AssertionError` — `nativeNames` carries `_AssertionError`, the private
/// subclass the VM raises for a failing `assert`.
class AssertionErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: AssertionError,
    name: 'AssertionError',
    nativeNames: const ['_AssertionError'],
    isAssignable: (v) => v is AssertionError,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        return AssertionError(
          positionalArgs.isNotEmpty ? positionalArgs[0] : null,
        );
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as AssertionError).toString();
      },
    },
    getters: {
      'message': (visitor, target) => (target as AssertionError).message,
      'hashCode': (visitor, target) => (target as AssertionError).hashCode,
      'runtimeType': (visitor, target) =>
          (target as AssertionError).runtimeType,
      'stackTrace': (visitor, target) => (target as AssertionError).stackTrace,
    },
  );
}

class StackOverflowErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: StackOverflowError,
    name: 'StackOverflowError',
    isAssignable: (v) => v is StackOverflowError,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) => StackOverflowError(),
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as StackOverflowError).toString();
      },
    },
    getters: {
      'hashCode': (visitor, target) => (target as StackOverflowError).hashCode,
      'runtimeType': (visitor, target) =>
          (target as StackOverflowError).runtimeType,
      'stackTrace': (visitor, target) =>
          (target as StackOverflowError).stackTrace,
    },
  );
}

class OutOfMemoryErrorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: OutOfMemoryError,
    name: 'OutOfMemoryError',
    isAssignable: (v) => v is OutOfMemoryError,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) => OutOfMemoryError(),
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as OutOfMemoryError).toString();
      },
    },
    getters: {
      'hashCode': (visitor, target) => (target as OutOfMemoryError).hashCode,
      'runtimeType': (visitor, target) =>
          (target as OutOfMemoryError).runtimeType,
      'stackTrace': (visitor, target) =>
          (target as OutOfMemoryError).stackTrace,
    },
  );
}

/// Declares the `dart:core` error inheritance chain to the subtype registry.
///
/// Bridges are registered flat — each `BridgedClass` knows only its own native
/// type — so without this the interpreter has no way to answer
/// `indexError is RangeError`. [BridgedClass.registerSupertypes] feeds
/// `isSubtypeOf` only; it deliberately does not affect which bridge owns a
/// native object, so declaring the chain cannot disturb member dispatch.
class ErrorHierarchyCore {
  static void register() {
    BridgedClass.registerSupertypes(const {
      'StateError': ['Error'],
      'ArgumentError': ['Error'],
      'RangeError': ['ArgumentError', 'Error'],
      'IndexError': ['RangeError', 'ArgumentError', 'Error'],
      'UnsupportedError': ['Error'],
      // UnimplementedError extends Error and implements UnsupportedError.
      'UnimplementedError': ['UnsupportedError', 'Error'],
      'NoSuchMethodError': ['Error'],
      'ConcurrentModificationError': ['Error'],
      'TypeError': ['Error'],
      'AssertionError': ['Error'],
      'StackOverflowError': ['Error'],
      'OutOfMemoryError': ['Error'],
    });
  }
}
