import 'dart:math' show Random;

import 'package:tom_d4rt_ast/runtime.dart';

// SCD26 moved `coerceElements` here from this file. It was never
// typed-data-specific — the defect it fixes is that d4rt erases a list
// literal's element type, which is true of every adapter that takes a
// collection — and `core/runes.dart` should not import out of `typed_data/`
// to reach it. Re-exported so the eleven typed-data bridges that import
// this file keep compiling unchanged.
export '../coerce_elements.dart' show coerceElements;

import '../coerce_elements.dart';

/// The `List<E>` setters every typed list inherits.
///
/// SCD28. `Uint8List` hand-rolled these three and the other ten had NO `setters`
/// map at all, so `l.first = 1` worked on `Uint8List` and raised
/// `RuntimeD4rtException` on its siblings — with `Uint8List` being the correct
/// one for once. All three are valid Dart on every typed list:
/// `first` and `last` are length-PRESERVING and simply assign, and `length` is
/// declared but throws `UnsupportedError` on a fixed-length list, which is a
/// runtime answer rather than a missing member.
///
/// That is the shape SCD28 exists to remove: a member correct in one variant
/// and absent from ten, because one variant did not share the code. Reached
/// through the shared helper, the eleven cannot disagree again.
Map<String, BridgedInstanceSetterAdapter> inheritedListSetters<E>(
  List<E> Function(Object target) coerce,
) {
  return {
    'length': (visitor, target, value) {
      coerce(target).length = value as int;
    },
    // `value as E` would do, and reports a raw `_TypeError` when it fails:
    // "type 'int' is not a subtype of type 'double' in type cast", with no
    // mention of the member or the list. The check is the same — an `int` into
    // a `Float64List` is a type error in Dart and stays one, so this widens
    // nothing — but the message names what the script did.
    'first': (visitor, target, value) {
      final v = value is BridgedInstance ? value.nativeObject : value;
      if (v is! E) {
        throw RuntimeD4rtException(
          "Cannot assign ${v.runtimeType} to first: this list holds $E.",
        );
      }
      coerce(target).first = v;
    },
    'last': (visitor, target, value) {
      final v = value is BridgedInstance ? value.nativeObject : value;
      if (v is! E) {
        throw RuntimeD4rtException(
          "Cannot assign ${v.runtimeType} to last: this list holds $E.",
        );
      }
      coerce(target).last = v;
    },
  };
}

/// Returns a map of methods that are inherited from `Iterable<E>` and the
/// read-only portion of `List<E>` for use in typed-data list bridges
/// (`Float64List`, `Int32List`, `Uint8List`, …).
///
/// **Why this helper exists.** Each typed-data list variant has to declare
/// its own copy of `toList`, `map`, `where`, etc. Without this helper,
/// exposing those methods would mean duplicating ~30 adapters across the
/// typed-data variant files. The helper centralises the implementations and
/// each variant just merges `inheritedListMethods<E>(...)` into its
/// `methods:` map.
///
/// **Why the explicit lists are not redundant with the `List` bridge.** The
/// supertype registry declares `Int8List -> List -> Iterable` (and the same
/// for every other variant), so a member that misses on a typed view's own
/// bridge falls back to `lookupOnBridgedSupertypes` and reaches the generic
/// `List` bridge. Every member below therefore *resolves* either way, which
/// makes deleting the spread look safe. It is not.
///
/// Resolution is not the question. The `List` bridge is generic over
/// `Object?`, while a typed-data list is a `List<E>` whose element type is
/// *reified* at the native boundary. Any member that passes an iterable or a
/// callback *into* the native call needs the concrete `E`, which only a
/// per-element-type adapter can supply. Measured on `Int8List` with the
/// spread removed, three members change behaviour:
///
///   * `followedBy([9])` hands a `List<Object?>` to a parameter typed
///     `Iterable<int>` and throws `_TypeError`;
///   * `reduce((a, b) => a + b)` builds a `(dynamic, dynamic) => Object?`
///     closure where `(int, int) => int` is required, and throws;
///   * `firstWhere(…, orElse: () => 's')` returns the `String` to the script
///     instead of rejecting it.
///
/// `test/stdlib/typed_data/typed_list_inherited_members_test.dart` pins the
/// last two as F-SCC60-1 and F-SCC60-2; F-SCB3-20 pins the first. A prune
/// that reaches for the supertype walk will turn those red.
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
      return coerce(
        target,
      ).followedBy(coerceElements<E>(positionalArgs[0], 'followedBy'));
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
      final separator = positionalArgs.isNotEmpty
          ? positionalArgs[0] as String
          : '';
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
      final start = positionalArgs.length > 1
          ? positionalArgs[1] as int?
          : null;
      return coerce(target).lastIndexOf(element, start);
    },
    'indexWhere': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      final start = positionalArgs.length > 1 ? positionalArgs[1] as int : 0;
      return coerce(
        target,
      ).indexWhere((element) => test.call(visitor, [element]) as bool, start);
    },
    'lastIndexWhere': (visitor, target, positionalArgs, namedArgs, _) {
      final test = positionalArgs[0] as Callable;
      final start = positionalArgs.length > 1
          ? positionalArgs[1] as int?
          : null;
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
  return {'bytesPerElement': (visitor) => bytesPerElement};
}
