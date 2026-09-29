import 'package:tom_d4rt/d4rt.dart';

class ComparableCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Comparable,
    name: 'Comparable',
    // SCE233 KEEP. No value resolves here today: `Comparable` is an interface
    // class, so nothing extends it, and every stdlib implementor has its own
    // bridge declaring these members. A native type named after the interface
    // (`_FooComparable`) would still reach it through SCC49's suffix fallback,
    // and these adapters forward to the interface, so they are right for any
    // implementor. Deleting them would turn that case into "undefined method".
    // scc24 SCD197 pins the count.
    typeParameterCount: 0,
    constructors: {},
    staticMethods: {
      'compare': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 2 ||
            positionalArgs[0] is! Comparable ||
            positionalArgs[1] is! Comparable) {
          throw RuntimeD4rtException(
            'Comparable.compare expects two Comparable arguments.',
          );
        }
        return Comparable.compare(
          positionalArgs[0] as Comparable,
          positionalArgs[1] as Comparable,
        );
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Comparable).toString();
      },
      'compareTo': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            'Comparable.compareTo requires a Comparable argument.',
          );
        }
        return (target as Comparable).compareTo(positionalArgs[0]);
      },
    },
    getters: {
      'hashCode': (visitor, target) => (target as Comparable).hashCode,
      'runtimeType': (visitor, target) => (target as Comparable).runtimeType,
    },
  );
}
