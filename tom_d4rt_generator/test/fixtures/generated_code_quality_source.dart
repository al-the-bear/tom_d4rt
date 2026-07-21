/// Fixture for DGU4 generated-code-quality regression guards.
///
/// Upstream 0.2.1 shipped four generated-code-quality fixes; this fixture
/// exercises the emission paths where those anti-patterns would appear so a
/// guard test can assert our analyzer-driven output already avoids them:
///
///   1. generic collection extraction — [Panel.mount] takes a `List<Item>`, so
///      the emitted `D4.coerceList<...Item>(...)` must be well-formed (no stray
///      spaces, no invalid angle-bracket tags).
///   2. abstract-class instantiation — [Delegate] is abstract with a generative
///      constructor (must be stripped) plus a factory (must be kept).
///   3. redundant `?? null` — [Panel]'s optional `label` must not extract with a
///      trailing `?? null`.
///   4. aggressive `key` inference — [Panel]'s `key` param is declared `Marker?`
///      and must extract as that declared type, never a force-inferred one.
library;

class Marker {
  const Marker();
}

class Item {
  final int id;
  const Item(this.id);
}

/// Abstract delegate: the generative `Delegate()` constructor must be stripped
/// from the bridge (cannot instantiate an abstract class), while the
/// `Delegate.create` factory must survive.
abstract class Delegate {
  Delegate();
  factory Delegate.create() = _ConcreteDelegate;
  void handle();
}

class _ConcreteDelegate implements Delegate {
  @override
  void handle() {}
}

class Panel {
  Panel({this.key, this.label});

  /// Declared nullable custom type — must not be aggressively re-typed just
  /// because the parameter is named `key`.
  final Marker? key;

  /// Optional string — extraction must not append `?? null`.
  final String? label;

  void mount(List<Item> items) {}
}
