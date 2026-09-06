// Resolve a bridged member the way the interpreter does — by reachability
// across the registered supertype chain, not by asking one bridge whether it
// declares the name itself.
//
// WHY THIS EXISTS. Registration-level tests naturally reach for
// `env.findBridgedClassByName('HashSet')!.getters['first']!`, which asserts two
// separate things at once: that the member is usable, and that *this
// particular* bridge is the one carrying it. Only the first is a contract. The
// second is an implementation detail that SC7 made variable — once the
// `HashSet -> Set -> Iterable` edges exist, `first` may correctly live on any
// of the three — and SCC51 then made it move, by deleting the seventeen leaf
// copies of `first`/`last`/`single` that shadowed a correct inherited one.
//
// A test written against the declaring bridge fails when the member moves
// upward even though nothing a script can observe has changed; worse, it passes
// when a leaf re-adds a divergent copy, which is the defect SCC51 exists to
// prevent. Resolving by reachability tests the contract and stays silent about
// the layout.
//
// This mirrors `InterpreterVisitor.lookupOnBridgedSupertypes` — the production
// walk — one layer down, so a test using it fails exactly when a script would.

import 'package:tom_d4rt_ast/runtime.dart';

/// The names to search for a member on [className], nearest first: the class
/// itself, then its registered supertypes in breadth-first order.
Iterable<String> _resolutionOrder(String className) => [
  className,
  ...BridgedClass.transitiveSupertypeNames(className),
];

/// The getter adapter a script would reach for `<className>.<member>`, or null
/// if no bridge in the chain declares it.
BridgedInstanceGetterAdapter? findReachableGetter(
  Environment env,
  String className,
  String member,
) {
  for (final name in _resolutionOrder(className)) {
    final adapter = env.findBridgedClassByName(name)?.getters[member];
    if (adapter != null) return adapter;
  }
  return null;
}

/// The method adapter a script would reach for `<className>.<member>()`, or
/// null if no bridge in the chain declares it.
BridgedMethodAdapter? findReachableMethod(
  Environment env,
  String className,
  String member,
) {
  for (final name in _resolutionOrder(className)) {
    final adapter = env.findBridgedClassByName(name)?.methods[member];
    if (adapter != null) return adapter;
  }
  return null;
}

/// Every method name reachable on [className], across the whole chain. Use in
/// place of `bridge.methods.keys` when the assertion is "a script can call
/// these", which is almost always what such an assertion means.
Set<String> reachableMethodNames(Environment env, String className) => {
  for (final name in _resolutionOrder(className))
    ...?env.findBridgedClassByName(name)?.methods.keys,
};

/// Reads `<className>.<member>` through the reachable getter, failing loudly
/// rather than with a null-check error when nothing in the chain declares it.
Object? readReachable(
  Environment env,
  String className,
  Object target,
  String member, {
  InterpreterVisitor? visitor,
}) {
  final adapter = findReachableGetter(env, className, member);
  if (adapter == null) {
    throw StateError(
      'no bridge on $className or its registered supertypes declares the '
      'getter `$member`',
    );
  }
  return adapter(visitor, target);
}
