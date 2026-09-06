import 'package:tom_d4rt_ast/runtime.dart';

/// The three `Set<E>` algebra operations — `difference`, `intersection`
/// and `union` — as bridge adapters, shared by every set bridge.
///
/// **Why this helper exists.** Before it, the plain `Set` bridge and
/// `UnmodifiableSetView` each hand-rolled the trio and the three
/// dart:collection sets simply lacked it — so `HashSet().difference(…)`
/// failed while the same call on a set literal worked.
///
/// **What is load-bearing: `coerce`, not the duplication.** [coerce]
/// hands back the *same* native object, cast — it does not copy into a
/// plain `Set`. That is what lets `target.union(…)` dispatch to the
/// native leaf's own override, so `SplayTreeSet.union` returns a sorted
/// set and `LinkedHashSet.union` returns insertion order. Rewriting any
/// of this to build a fresh `Set` first would keep every surface
/// assertion green and silently lose the ordering; `F-SCC50-AST-1..4` in
/// `test/runtime/stdlib_ordered_sorted_sets_test.dart` fail if it
/// happens, each paired with the `LinkedHashSet` call on the same input
/// so it cannot pass vacuously.
///
/// **Why each concrete set still spreads its own copy.** Not
/// reachability — since the `HashSet -> Set -> Iterable` edges were
/// registered, `Set`'s copy would be found. And not ordering: `Set`
/// passes `(t) => t as Set` too, so its adapter dispatches to the same
/// native override. The one thing that differs is [className], which
/// appears in the argument-type error, so `HashSet().difference(42)`
/// names the class the script actually called instead of `Set`. SCC51's
/// shadow audit deletes duplicated adapters that hide a correct
/// inherited copy; these are kept because that diagnostic is the
/// deliberate divergence.
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
