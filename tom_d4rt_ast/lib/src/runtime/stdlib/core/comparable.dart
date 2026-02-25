import 'package:tom_d4rt_ast/runtime.dart';

class ComparableCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: Comparable,
        name: 'Comparable',
        typeParameterCount: 0,
        constructors: {},
        staticMethods: {
          'compare': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 2 ||
                positionalArgs[0] is! Comparable ||
                positionalArgs[1] is! Comparable) {
              throw RuntimeD4rtException(
                  'Comparable.compare expects two Comparable arguments.');
            }
            return Comparable.compare(positionalArgs[0] as Comparable,
                positionalArgs[1] as Comparable);
          },
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Comparable).toString();
          },
          'compareTo': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1) {
              throw RuntimeD4rtException(
                  'Comparable.compareTo requires a Comparable argument.');
            }
            return (target as Comparable).compareTo(positionalArgs[0]);
          }
        },
        getters: {
          'hashCode': (visitor, target) => (target as Comparable).hashCode,
          'runtimeType': (visitor, target) =>
              (target as Comparable).runtimeType,
        },
      );
}
