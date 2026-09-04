import 'package:tom_d4rt/d4rt.dart';

class IterableCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Iterable,
    name: 'Iterable',
    typeParameterCount: 1,
    nativeNames: [
      '_GeneratorIterable',
      '_HashMapKeyIterable',
      '_HashMapValueIterable',
      '_CompactKeysIterable',
      '_CompactEntriesIterable',
      '_CompactValuesIterable',
      '_SplayTreeKeyIterable',
      '_SplayTreeValueIterable',
      // `SplayTreeMap.entries` — the key and value views were listed but
      // the entry view was not, so `.entries` was unusable on a
      // `SplayTreeMap` while it worked on every other map.
      '_SplayTreeMapEntryIterable',
      '_AllMatchesIterable',
      '_LineSplitIterable', // LineSplitter.split()
      '_SyncGeneratorIterable', // D4rt interpreter sync* generator
      '_SyncStarIterable', // Dart SDK sync* generator (from bridged code)
      // List transformation iterables (returned by .map(), .where(), etc.)
      'MappedListIterable',
      'MappedIterable',
      'WhereIterable',
      'WhereTypeIterable',
      'ExpandIterable',
      'TakeIterable',
      'TakeWhileIterable',
      'SkipIterable',
      'SkipWhileIterable',
      'FollowedByIterable',
      'ReversedListIterable',
      'SubListIterable',
      'CastIterable',
      // `Iterable.castFrom` / `.cast()` return the *efficient-length*
      // subtype whenever the source can report its length cheaply — which
      // is the common case (a list). Listing only `CastIterable` left
      // `.length` on a cast list unreachable.
      '_EfficientLengthCastIterable',
      'EfficientLengthMappedIterable',
      'EfficientLengthSkipIterable',
      'EfficientLengthTakeIterable',
    ],
    staticMethods: {
      // Re-types an existing iterable as a live view rather than a copy.
      // Type arguments are erased at the bridge boundary, so the native
      // call is instantiated at `dynamic` and the observable contract is
      // "same elements, still a view".
      'castFrom': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || namedArgs.isNotEmpty) {
          throw RuntimeD4rtException(
            'Iterable.castFrom(source) expects one positional argument.',
          );
        }
        final source = positionalArgs[0];
        if (source is! Iterable) {
          throw RuntimeD4rtException(
            'The argument to Iterable.castFrom must be an Iterable.',
          );
        }
        return Iterable.castFrom<dynamic, dynamic>(source);
      },
      // The two rendering helpers differ only in truncation: the short
      // form elides the middle of a long iterable, the full form does not.
      // Both default to round delimiters — `(1, 2, 3)`, not `[1, 2, 3]`.
      'iterableToShortString': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs.length > 3) {
          throw RuntimeD4rtException(
            'Iterable.iterableToShortString(iterable, [leftDelimiter, '
            'rightDelimiter]) expects one to three positional arguments.',
          );
        }
        final iterable = positionalArgs[0];
        if (iterable is! Iterable) {
          throw RuntimeD4rtException(
            'The first argument to Iterable.iterableToShortString must '
            'be an Iterable.',
          );
        }
        return Iterable.iterableToShortString(
          iterable,
          positionalArgs.length > 1 ? positionalArgs[1] as String : '(',
          positionalArgs.length > 2 ? positionalArgs[2] as String : ')',
        );
      },
      'iterableToFullString': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs.length > 3) {
          throw RuntimeD4rtException(
            'Iterable.iterableToFullString(iterable, [leftDelimiter, '
            'rightDelimiter]) expects one to three positional arguments.',
          );
        }
        final iterable = positionalArgs[0];
        if (iterable is! Iterable) {
          throw RuntimeD4rtException(
            'The first argument to Iterable.iterableToFullString must '
            'be an Iterable.',
          );
        }
        return Iterable.iterableToFullString(
          iterable,
          positionalArgs.length > 1 ? positionalArgs[1] as String : '(',
          positionalArgs.length > 2 ? positionalArgs[2] as String : ')',
        );
      },
      'generate': (visitor, positionalArgs, namedArgs, _) {
        final count = positionalArgs[0] as int;
        final generator = positionalArgs.length > 1
            ? positionalArgs[1] as Callable?
            : null;

        return Iterable.generate(
          count,
          generator == null
              ? null
              : (index) {
                  return generator.call(visitor, [index]);
                },
        );
      },
      'empty': (visitor, positionalArgs, namedArgs, _) {
        return Iterable.empty();
      },
    },
    methods: {
      'map': (visitor, target, positionalArgs, namedArgs, _) {
        final f = positionalArgs[0] as Callable;
        return (target as Iterable).map((element) {
          return f.call(visitor, [element]);
        });
      },
      'where': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        return (target as Iterable).where((element) {
          return test.call(visitor, [element]) as bool;
        });
      },
      'expand': (visitor, target, positionalArgs, namedArgs, _) {
        final f = positionalArgs[0] as Callable;
        return (target as Iterable).expand((element) {
          return f.call(visitor, [element]) as Iterable;
        });
      },
      'contains': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Iterable).contains(positionalArgs[0]);
      },
      'forEach': (visitor, target, positionalArgs, namedArgs, _) {
        final action = positionalArgs[0] as Callable;
        for (var element in (target as Iterable)) {
          action.call(visitor, [element]);
        }
        return null;
      },
      'reduce': (visitor, target, positionalArgs, namedArgs, _) {
        final combine = positionalArgs[0] as Callable;
        return (target as Iterable).reduce((value, element) {
          return combine.call(visitor, [value, element]);
        });
      },
      'fold': (visitor, target, positionalArgs, namedArgs, _) {
        final initialValue = positionalArgs[0];
        final combine = positionalArgs[1] as Callable;
        return (target as Iterable).fold(initialValue, (
          previousValue,
          element,
        ) {
          return combine.call(visitor, [previousValue, element]);
        });
      },
      'every': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        return (target as Iterable).every((element) {
          return test.call(visitor, [element]) as bool;
        });
      },
      'join': (visitor, target, positionalArgs, namedArgs, _) {
        final separator = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String
            : '';
        return (target as Iterable).join(separator);
      },
      'any': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        return (target as Iterable).any((element) {
          return test.call(visitor, [element]) as bool;
        });
      },
      'toList': (visitor, target, positionalArgs, namedArgs, _) {
        final growable = namedArgs['growable'] as bool? ?? true;
        return (target as Iterable).toList(growable: growable);
      },
      'toSet': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Iterable).toSet();
      },
      'take': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Iterable).take(positionalArgs[0] as int);
      },
      'takeWhile': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        return (target as Iterable).takeWhile((element) {
          return test.call(visitor, [element]) as bool;
        });
      },
      'skip': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Iterable).skip(positionalArgs[0] as int);
      },
      'skipWhile': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        return (target as Iterable).skipWhile((element) {
          return test.call(visitor, [element]) as bool;
        });
      },
      'firstWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        final orElse = namedArgs['orElse'] as Callable?;
        return (target as Iterable).firstWhere(
          (element) => test.call(visitor, [element]) as bool,
          orElse: orElse == null ? null : () => orElse.call(visitor, []),
        );
      },
      'lastWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        final orElse = namedArgs['orElse'] as Callable?;
        return (target as Iterable).lastWhere(
          (element) => test.call(visitor, [element]) as bool,
          orElse: orElse == null ? null : () => orElse.call(visitor, []),
        );
      },
      'singleWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        final orElse = namedArgs['orElse'] as Callable?;
        return (target as Iterable).singleWhere(
          (element) => test.call(visitor, [element]) as bool,
          orElse: orElse == null ? null : () => orElse.call(visitor, []),
        );
      },
      'elementAt': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Iterable).elementAt(positionalArgs[0] as int);
      },
      'elementAtOrNull': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Iterable).elementAtOrNull(positionalArgs[0] as int);
      },
      'followedBy': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Iterable).followedBy(positionalArgs[0] as Iterable);
      },
      'whereType': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Iterable).whereType();
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Iterable).cast();
      },
    },
    getters: {
      'length': (visitor, target) => (target as Iterable).length,
      'isEmpty': (visitor, target) => (target as Iterable).isEmpty,
      'isNotEmpty': (visitor, target) => (target as Iterable).isNotEmpty,
      'first': (visitor, target) => (target as Iterable).first,
      'last': (visitor, target) => (target as Iterable).last,
      'single': (visitor, target) => (target as Iterable).single,
      'iterator': (visitor, target) => (target as Iterable).iterator,
      'firstOrNull': (visitor, target) => (target as Iterable).firstOrNull,
      'lastOrNull': (visitor, target) => (target as Iterable).lastOrNull,
      'singleOrNull': (visitor, target) => (target as Iterable).singleOrNull,
      // Dart 3 IndexedIterable extension: returns Iterable<(int, E)>.
      // Bridged here so scripts can use `for (final (i, x) in xs.indexed)`.
      'indexed': (visitor, target) => (target as Iterable).indexed,
    },
  );
}
