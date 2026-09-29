import 'package:tom_d4rt/d4rt.dart';
import '../coerce_elements.dart';

class PatternCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Pattern,
    name: 'Pattern',
    // SCE233 KEEP. No value resolves here today: `Pattern` is an interface
    // class, so nothing extends it, and `String` and `RegExp` declare these
    // members themselves. A native type named after the interface would still
    // reach it through SCC49's suffix fallback, as `_StringMatch` reaches
    // `Match`, and these adapters forward to the interface, so they are right
    // for any implementor. scc24 SCD197 pins the count.
    typeParameterCount: 0,
    constructors: {},
    methods: {
      'allMatches': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Pattern.allMatches', atMost: 1);
        return (target as Pattern).allMatches(
          positionalArgs[0] as String,
          positionalArgs.get<int>(1) ?? 0,
        );
      },
      'matchAsPrefix': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Pattern.matchAsPrefix', atMost: 1);
        return (target as Pattern).matchAsPrefix(
          positionalArgs[0] as String,
          positionalArgs.get<int>(1) ?? 0,
        );
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as Pattern).toString(),
    },
    getters: {
      'hashCode': (visitor, target) => (target as Pattern).hashCode,
      'runtimeType': (visitor, target) => (target as Pattern).runtimeType,
    },
  );
}

class MatchCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Match,
    name: 'Match',
    isAssignable: (v) => v is Match,
    typeParameterCount: 0,
    constructors: {},
    methods: {
      'group': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Pattern.group', atMost: 1);
        return (target as Match).group(positionalArgs[0] as int);
      },
      'groups': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Pattern.groups', atMost: 1);
        return (target as Match).groups(
          coerceElements<int>(positionalArgs[0], 'Match.groups'),
        );
      },
      '[]': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! int) {
          throw RuntimeD4rtException(
            'Match index operator [] requires one integer argument (group index).',
          );
        }
        return (target as Match)[positionalArgs[0] as int];
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as Match).toString(),
    },
    getters: {
      'end': (visitor, target) => (target as Match).end,
      'groupCount': (visitor, target) => (target as Match).groupCount,
      'input': (visitor, target) => (target as Match).input,
      'start': (visitor, target) => (target as Match).start,
      'pattern': (visitor, target) => (target as Match).pattern,
      'hashCode': (visitor, target) => (target as Match).hashCode,
      'runtimeType': (visitor, target) => (target as Match).runtimeType,
    },
  );
}
