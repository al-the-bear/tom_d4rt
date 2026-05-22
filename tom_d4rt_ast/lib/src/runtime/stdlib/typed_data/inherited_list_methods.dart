import 'package:tom_d4rt_ast/runtime.dart';

/// Returns a map of methods that are inherited from `Iterable<E>` and the
/// read-only portion of `List<E>` for use in typed-data list bridges
/// (`Float64List`, `Int32List`, `Uint8List`, …).
///
/// **Why this helper exists.** The d4rt interpreter resolves bridged method
/// names with a direct `bridgedClass.methods[name]` lookup
/// (`interpreter_visitor.dart`) — it does *not* walk the supertype chain
/// to the `List` / `Iterable` bridges. So each typed-data list variant
/// has to declare its own copy of `toList`, `map`, `where`, etc. Without
/// this helper, exposing those methods would mean duplicating ~25
/// adapters across 12 typed-data variant files. The helper centralises
/// the implementations and each variant just merges `inheritedListMethods<E>(...)`
/// into its `methods:` map.
///
/// The [coerce] callback narrows `target` to the concrete typed-data
/// variant — e.g. `(t) => t as Float64List`. Typed-data lists are all
/// `List<E>`, so the resulting object exposes the full read-only
/// `List<E>` surface natively.
///
/// Mutating `List<E>` operations (`add`, `remove`, `insert`, `sort`, …)
/// are *not* included here because typed-data lists are fixed-length
/// and would throw `UnsupportedError` at runtime.
Map<String, BridgedMethodAdapter> inheritedListMethods<E>(
  List<E> Function(Object target) coerce,
) {
  return {
    // Iterable<E> — collection conversion.
    'toList': (visitor, target, positionalArgs, namedArgs, _) {
      final growable = namedArgs['growable'] as bool? ?? true;
      return coerce(target).toList(growable: growable);
    },
    'toSet': (visitor, target, positionalArgs, namedArgs, _) {
      return coerce(target).toSet();
    },

    // Iterable<E> — transformations.
    'map': (visitor, target, positionalArgs, namedArgs, _) {
      final f = positionalArgs[0] as Callable;
      return coerce(target).map((element) {
        return f.call(visitor, [element]);
      });
    },
    'where': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      return coerce(target).where((element) {
        return test.call(visitor, [element]) as bool;
      });
    },
    'expand': (visitor, target, positionalArgs, namedArgs, _) {
      final f = positionalArgs[0] as Callable;
      return coerce(target).expand((element) {
        return f.call(visitor, [element]) as Iterable;
      });
    },
    'followedBy': (visitor, target, positionalArgs, namedArgs, _) {
      return coerce(target).followedBy(positionalArgs[0] as Iterable<E>);
    },
    'cast': (visitor, target, positionalArgs, namedArgs, _) {
      // d4rt erases the type argument; <Object?> preserves all elements.
      return coerce(target).cast<Object?>();
    },
    'whereType': (visitor, target, positionalArgs, namedArgs, _) {
      return coerce(target).whereType<Object>();
    },

    // Iterable<E> — searches.
    'contains': (visitor, target, positionalArgs, namedArgs, _) {
      return coerce(target).contains(positionalArgs[0]);
    },
    'firstWhere': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      final orElse = namedArgs['orElse'] as Callable?;
      return coerce(target).firstWhere(
        (element) => test.call(visitor, [element]) as bool,
        orElse: orElse == null ? null : () => orElse.call(visitor, []) as E,
      );
    },
    'lastWhere': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      final orElse = namedArgs['orElse'] as Callable?;
      return coerce(target).lastWhere(
        (element) => test.call(visitor, [element]) as bool,
        orElse: orElse == null ? null : () => orElse.call(visitor, []) as E,
      );
    },
    'singleWhere': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      final orElse = namedArgs['orElse'] as Callable?;
      return coerce(target).singleWhere(
        (element) => test.call(visitor, [element]) as bool,
        orElse: orElse == null ? null : () => orElse.call(visitor, []) as E,
      );
    },
    'elementAt': (visitor, target, positionalArgs, namedArgs, _) {
      return coerce(target).elementAt(positionalArgs[0] as int);
    },

    // Iterable<E> — quantifiers / iteration.
    'forEach': (visitor, target, positionalArgs, namedArgs, _) {
      final action = positionalArgs[0] as Callable;
      for (final element in coerce(target)) {
        action.call(visitor, [element]);
      }
      return null;
    },
    'reduce': (visitor, target, positionalArgs, namedArgs, _) {
      final combine = positionalArgs[0] as Callable;
      return coerce(target).reduce((value, element) {
        return combine.call(visitor, [value, element]) as E;
      });
    },
    'fold': (visitor, target, positionalArgs, namedArgs, _) {
      final initialValue = positionalArgs[0];
      final combine = positionalArgs[1] as Callable;
      return coerce(target).fold(initialValue, (previousValue, element) {
        return combine.call(visitor, [previousValue, element]);
      });
    },
    'every': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      return coerce(target).every((element) {
        return test.call(visitor, [element]) as bool;
      });
    },
    'any': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      return coerce(target).any((element) {
        return test.call(visitor, [element]) as bool;
      });
    },
    'join': (visitor, target, positionalArgs, namedArgs, _) {
      final separator =
          positionalArgs.isNotEmpty ? positionalArgs[0] as String : '';
      return coerce(target).join(separator);
    },

    // Iterable<E> — slicing.
    'take': (visitor, target, positionalArgs, namedArgs, _) {
      return coerce(target).take(positionalArgs[0] as int);
    },
    'takeWhile': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      return coerce(target).takeWhile((element) {
        return test.call(visitor, [element]) as bool;
      });
    },
    'skip': (visitor, target, positionalArgs, namedArgs, _) {
      return coerce(target).skip(positionalArgs[0] as int);
    },
    'skipWhile': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      return coerce(target).skipWhile((element) {
        return test.call(visitor, [element]) as bool;
      });
    },

    // List<E> — non-mutating read APIs.
    'indexOf': (visitor, target, positionalArgs, namedArgs, _) {
      final element = positionalArgs[0] as E;
      final start = positionalArgs.length > 1 ? positionalArgs[1] as int : 0;
      return coerce(target).indexOf(element, start);
    },
    'lastIndexOf': (visitor, target, positionalArgs, namedArgs, _) {
      final element = positionalArgs[0] as E;
      final start =
          positionalArgs.length > 1 ? positionalArgs[1] as int? : null;
      return coerce(target).lastIndexOf(element, start);
    },
    'indexWhere': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      final start = positionalArgs.length > 1 ? positionalArgs[1] as int : 0;
      return coerce(target).indexWhere(
        (element) => test.call(visitor, [element]) as bool,
        start,
      );
    },
    'lastIndexWhere': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      final start =
          positionalArgs.length > 1 ? positionalArgs[1] as int? : null;
      return coerce(target).lastIndexWhere(
        (element) => test.call(visitor, [element]) as bool,
        start,
      );
    },
    'asMap': (visitor, target, positionalArgs, namedArgs, _) {
      return coerce(target).asMap();
    },
  };
}

/// Companion to [inheritedListMethods] — getters that typed-data lists
/// inherit from `Iterable<E>` / `List<E>` but that the per-variant
/// bridges currently omit. Same rationale: no supertype walk in the
/// bridge resolver, so each variant has to expose them directly.
Map<String, BridgedInstanceGetterAdapter> inheritedListGetters<E>(
  List<E> Function(Object target) coerce,
) {
  return {
    'single': (visitor, target) => coerce(target).single,
    'iterator': (visitor, target) => coerce(target).iterator,
    'reversed': (visitor, target) => coerce(target).reversed,
  };
}
