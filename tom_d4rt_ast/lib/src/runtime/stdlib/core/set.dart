import 'package:tom_d4rt_ast/runtime.dart';

import '../collection/set_algebra_methods.dart';

class SetCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Set,
    name: 'Set',
    typeParameterCount: 1,
    nativeNames: [
      'UnmodifiableSetView',
      '_UnmodifiableSetView',
      '_CompactLinkedHashSet',
      'LinkedHashSet', // Explicit LinkedHashSet
      '_SetBase', // Internal Set base type
      '_ConstSet', // Const set literals
      '_HashSet', // HashSet internal type
      'CompactLinkedIdentityHashSet', // Identity hash set
    ],
    isAssignable: (v) => v is Set,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        return <dynamic>{};
      },
      'from': (visitor, positionalArgs, namedArgs) {
        return Set.from(positionalArgs[0] as Iterable);
      },
      'of': (visitor, positionalArgs, namedArgs) {
        return Set.of(positionalArgs[0] as Iterable);
      },
      'identity': (visitor, positionalArgs, namedArgs) {
        return Set.identity();
      },
      'unmodifiable': (visitor, positionalArgs, namedArgs) {
        return Set.unmodifiable(positionalArgs[0] as Iterable);
      },
    },
    staticMethods: {
      // `Set.castFrom(source, {newSet})` — the optional `newSet` is a
      // *generic* function (`Set<R> Function<R>()`), a value interpreted
      // code cannot construct, so it is rejected explicitly rather than
      // accepted and ignored. Silently dropping it would hand back a view
      // over the wrong set implementation.
      'castFrom': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
              'Set.castFrom(source) expects one positional argument.');
        }
        if (namedArgs.isNotEmpty) {
          throw RuntimeD4rtException(
              'Set.castFrom does not support the `newSet` argument: it is '
              'a generic function, which interpreted code cannot express.');
        }
        final source = positionalArgs[0];
        if (source is! Set) {
          throw RuntimeD4rtException(
              'The argument to Set.castFrom must be a Set.');
        }
        return Set.castFrom<dynamic, dynamic>(source);
      },
      'from': (visitor, positionalArgs, namedArgs, _) {
        return Set.from(positionalArgs[0] as Iterable);
      },
      'of': (visitor, positionalArgs, namedArgs, _) {
        return Set.of(positionalArgs[0] as Iterable);
      },
      'identity': (visitor, positionalArgs, namedArgs, _) {
        return Set.identity();
      },
      'unmodifiable': (visitor, positionalArgs, namedArgs, _) {
        return Set.unmodifiable(positionalArgs[0] as Iterable);
      },
    },
    methods: {
      'add': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Set).add(positionalArgs[0]);
      },
      'addAll': (visitor, target, positionalArgs, namedArgs, _) {
        (target as Set).addAll(positionalArgs[0] as Iterable);
        return null;
      },
      'clear': (visitor, target, positionalArgs, namedArgs, _) {
        (target as Set).clear();
        return null;
      },
      'contains': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Set).contains(positionalArgs[0]);
      },
      'containsAll': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Set).containsAll(positionalArgs[0] as Iterable);
      },
      ...setAlgebraMethods('Set', (t) => t as Set),
      'lookup': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Set).lookup(positionalArgs[0]);
      },
      'remove': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Set).remove(positionalArgs[0]);
      },
      'removeAll': (visitor, target, positionalArgs, namedArgs, _) {
        (target as Set).removeAll(positionalArgs[0] as Iterable);
        return null;
      },
      'removeWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        (target as Set).removeWhere((element) {
          return test.call(visitor, [element]) as bool;
        });
        return null;
      },
      'retainAll': (visitor, target, positionalArgs, namedArgs, _) {
        (target as Set).retainAll(positionalArgs[0] as Iterable);
        return null;
      },
      'retainWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        (target as Set).retainWhere((element) {
          return test.call(visitor, [element]) as bool;
        });
        return null;
      },
      'toSet': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Set).toSet();
      },
      'toList': (visitor, target, positionalArgs, namedArgs, _) {
        final growable = namedArgs['growable'] as bool? ?? true;
        return (target as Set).toList(growable: growable);
      },
      'forEach': (visitor, target, positionalArgs, namedArgs, _) {
        final action = positionalArgs[0] as Callable;
        for (var element in (target as Set)) {
          action.call(visitor, [element]);
        }
        return null;
      },
      'map': (visitor, target, positionalArgs, namedArgs, _) {
        final f = positionalArgs[0] as Callable;
        return (target as Set).map((element) {
          return f.call(visitor, [element]);
        });
      },
      'where': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        return (target as Set).where((element) {
          return test.call(visitor, [element]) as bool;
        });
      },
      'whereType': (visitor, target, positionalArgs, namedArgs, _) {
        // Mirrors the Iterable / List bridges so that `mySet.whereType<...>()`
        // resolves (returns Iterable<dynamic>; per-call type argument is not
        // applied yet).
        return (target as Set).whereType();
      },
      'expand': (visitor, target, positionalArgs, namedArgs, _) {
        final f = positionalArgs[0] as Callable;
        return (target as Set).expand((element) {
          return f.call(visitor, [element]) as Iterable;
        });
      },
      'every': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        return (target as Set).every((element) {
          return test.call(visitor, [element]) as bool;
        });
      },
      'any': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        return (target as Set).any((element) {
          return test.call(visitor, [element]) as bool;
        });
      },
      'firstWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        final orElse = namedArgs['orElse'] as Callable?;
        return (target as Set).firstWhere(
          (element) => test.call(visitor, [element]) as bool,
          orElse: orElse == null ? null : () => orElse.call(visitor, []),
        );
      },
      'lastWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        final orElse = namedArgs['orElse'] as Callable?;
        return (target as Set).lastWhere(
          (element) => test.call(visitor, [element]) as bool,
          orElse: orElse == null ? null : () => orElse.call(visitor, []),
        );
      },
      'singleWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as Callable;
        final orElse = namedArgs['orElse'] as Callable?;
        return (target as Set).singleWhere(
          (element) => test.call(visitor, [element]) as bool,
          orElse: orElse == null ? null : () => orElse.call(visitor, []),
        );
      },
      'elementAt': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Set).elementAt(positionalArgs[0] as int);
      },
      'take': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Set).take(positionalArgs[0] as int);
      },
      'skip': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Set).skip(positionalArgs[0] as int);
      },
      'takeWhile': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as InterpretedFunction;
        return (target as Set).takeWhile((element) {
          return test.call(visitor, [element]) as bool;
        });
      },
      'skipWhile': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs[0] as InterpretedFunction;
        return (target as Set).skipWhile((element) {
          return test.call(visitor, [element]) as bool;
        });
      },
      'fold': (visitor, target, positionalArgs, namedArgs, _) {
        final initialValue = positionalArgs[0];
        final combine = positionalArgs[1] as InterpretedFunction;
        return (target as Set).fold(initialValue, (previousValue, element) {
          return combine.call(visitor, [previousValue, element]);
        });
      },
      'reduce': (visitor, target, positionalArgs, namedArgs, _) {
        final combine = positionalArgs[0] as InterpretedFunction;
        return (target as Set).reduce((value, element) {
          return combine.call(visitor, [value, element]);
        });
      },
      'join': (visitor, target, positionalArgs, namedArgs, _) {
        final separator = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String
            : '';
        return (target as Set).join(separator);
      },
      'followedBy': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Set).followedBy(positionalArgs[0] as Iterable);
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Set).cast();
      },
    },
    getters: {
      'length': (visitor, target) => (target as Set).length,
      'isEmpty': (visitor, target) => (target as Set).isEmpty,
      'isNotEmpty': (visitor, target) => (target as Set).isNotEmpty,
      'first': (visitor, target) => (target as Set).first,
      'last': (visitor, target) => (target as Set).last,
      'single': (visitor, target) => (target as Set).single,
      'iterator': (visitor, target) => (target as Set).iterator,
    },
  );
}
