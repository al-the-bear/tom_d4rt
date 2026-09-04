import 'package:tom_d4rt/d4rt.dart';

/// The three `Set<E>` algebra operations — `difference`, `intersection`
/// and `union` — as bridge adapters, shared by every set bridge.
///
/// **Why this helper exists.** The interpreter resolves a bridged
/// instance method with a direct `bridgedClass.methods[name]` lookup and
/// its supertype fallback is not uniform, so declaring these on the
/// `Set` bridge does not make them reachable on `HashSet`,
/// `LinkedHashSet` or `SplayTreeSet`. Each concrete set has to carry its
/// own copy. Before this helper existed, the plain `Set` bridge and
/// `UnmodifiableSetView` each hand-rolled the trio and the three
/// dart:collection sets simply lacked it — so `HashSet().difference(…)`
/// failed while the same call on a set literal worked.
///
/// [className] is used only in the error message, so a bad argument
/// names the class the script actually called.
Map<String, BridgedMethodAdapter> setAlgebraMethods(
  String className,
  Set Function(Object target) coerce,
) {
  Set requireSet(Object? argument, String method) {
    if (argument is! Set) {
      throw RuntimeD4rtException(
        'Argument to $className.$method must be a Set.',
      );
    }
    return argument;
  }

  return {
    'difference': (visitor, target, positionalArgs, namedArgs, _) {
      return coerce(
        target,
      ).difference(requireSet(positionalArgs[0], 'difference'));
    },
    'intersection': (visitor, target, positionalArgs, namedArgs, _) {
      return coerce(
        target,
      ).intersection(requireSet(positionalArgs[0], 'intersection'));
    },
    'union': (visitor, target, positionalArgs, namedArgs, _) {
      return coerce(target).union(requireSet(positionalArgs[0], 'union'));
    },
  };
}
