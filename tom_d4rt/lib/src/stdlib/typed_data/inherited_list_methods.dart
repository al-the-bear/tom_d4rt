import 'dart:math' show Random;

import 'package:tom_d4rt/d4rt.dart';

/// Coerces an adapter argument that the SDK expects as `Iterable<E>`.
///
/// **Why a bare cast is not enough.** d4rt evaluates a list literal to
/// `List<Object?>` — element types are erased — and elements that came from
/// bridged code arrive as `BridgedInstance` wrappers. So
/// `positionalArgs[n] as Iterable<int>` throws `_TypeError` on
/// `l.setAll(0, [7, 8])` even though every element really is an `int`. The
/// same call with a typed-data argument (`l.setAll(0, Uint8List.fromList([7,
/// 8]))`) passes the cast, which is why the bug survived: the natural
/// spot-check uses the typed form.
///
/// **Why it matters twice over.** On a member that should succeed, the failed
/// cast simply kills the script. On a length-*changing* member it is worse:
/// the cast throws *before* the native call, so the `UnsupportedError` that a
/// fixed-length list would have raised never happens, and a script written as
///
///     try { list.addAll(more); } on UnsupportedError { … }
///
/// dies instead of taking its recovery path.
///
/// An element whose type genuinely does not match still fails — this widens
/// nothing. `Float32List.setAll(0, [7, 8])` (ints into a `double` list) is a
/// type error in Dart and stays one here.
List<E> coerceElements<E>(Object? arg, String member) {
  final value = arg is BridgedInstance ? arg.nativeObject : arg;
  if (value is Iterable<E>) return value.toList();
  if (value is Iterable) {
    return value.map<E>((element) {
      final unwrapped =
          element is BridgedInstance ? element.nativeObject : element;
      if (unwrapped is E) return unwrapped;
      throw RuntimeD4rtException(
          "$member expects an Iterable<$E>, but an element was "
          "${unwrapped.runtimeType}.");
    }).toList();
  }
  throw RuntimeD4rtException(
      "$member expects an Iterable<$E>, got ${value.runtimeType}.");
}

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
/// Length-*changing* `List<E>` operations (`add`, `insert`, `remove`,
/// `clear`, …) are *not* included here: typed-data lists are
/// fixed-length and those genuinely throw `UnsupportedError`.
///
/// In-place reordering, however, *is* included. `sort` and `shuffle`
/// permute the existing elements without changing the length, so the
/// SDK supports them on every typed-data variant. They were once
/// excluded here on the mistaken grounds that all "mutating" operations
/// throw — which conflated fixed-*length* with immutable, and left nine
/// of the ten shared variants unable to sort while `Uint8List` (which
/// hand-rolls its own adapter map) could.
///
/// [unmodifiableView] is required rather than optional because
/// `asUnmodifiableView` is declared on each concrete typed-data class,
/// not on `List<E>`, so it cannot be expressed through [coerce]. Making
/// it required means a newly added variant cannot silently omit it.
Map<String, BridgedMethodAdapter> inheritedListMethods<E>(
  List<E> Function(Object target) coerce, {
  required Object Function(Object target) unmodifiableView,
}) {
  return {
    // List<E> — in-place reordering (length-preserving, so supported).
    'sort': (visitor, target, positionalArgs, namedArgs, _) {
      if (positionalArgs.isEmpty || positionalArgs[0] == null) {
        coerce(target).sort();
        return null;
      }
      final compare = positionalArgs[0] as Callable;
      coerce(target).sort((a, b) => compare.call(visitor, [a, b]) as int);
      return null;
    },
    'shuffle': (visitor, target, positionalArgs, namedArgs, _) {
      final random = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
      coerce(target).shuffle(random as Random?);
      return null;
    },

    // Declared per concrete variant, so it arrives via the callback.
    'asUnmodifiableView': (visitor, target, positionalArgs, namedArgs, _) {
      return unmodifiableView(target);
    },

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
      return coerce(target)
          .followedBy(coerceElements<E>(positionalArgs[0], 'followedBy'));
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

/// Static members shared by every typed-data list variant.
///
/// `bytesPerElement` is a `static const int` on each concrete class, so it
/// cannot be reached through the instance maps or through any supertype
/// fallback — the interpreter does not walk the chain for statics at all.
/// Pass the SDK constant itself (`typedListStaticGetters(Float32List
/// .bytesPerElement)`) rather than a literal, so the bridged value cannot
/// drift from the platform's.
Map<String, BridgedStaticGetterAdapter> typedListStaticGetters(
  int bytesPerElement,
) {
  return {
    'bytesPerElement': (visitor) => bytesPerElement,
  };
}
