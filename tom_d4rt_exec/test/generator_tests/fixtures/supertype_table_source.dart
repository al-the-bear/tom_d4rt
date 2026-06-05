/// Test fixtures for the MCI#1 / A1 generated supertype table.
///
/// Exercises every edge the `classSupertypes()` emission must cover:
/// - a plain root class (no bridged supertype → omitted from the table),
/// - a direct `extends` link,
/// - a transitive `extends` chain (flattened),
/// - a directly-implemented interface,
/// - an applied mixin,
/// - a class combining `extends` + `with` + `implements`.
library;

/// Root of the hierarchy; extends Object only, so it has no entry.
class Animal {
  /// Name of the animal.
  String get name => 'animal';
}

/// An abstract interface scripts may implement.
abstract class Walks {
  /// Number of legs.
  int get legs;
}

/// A mixin scripts may apply.
mixin Swims {
  /// Swimming speed.
  double get speed => 1.0;
}

/// Direct `extends` + `implements`.
class Dog extends Animal implements Walks {
  @override
  int get legs => 4;
}

/// Transitive `extends` chain — flattened table must list both Dog and Animal.
class Puppy extends Dog {
  /// Whether the puppy is asleep.
  bool get asleep => true;
}

/// Applied mixin only.
class Fish with Swims {
  /// Whether the fish has scales.
  bool get hasScales => true;
}

/// Combines `extends` + `with` + `implements`.
class Amphibian extends Animal with Swims implements Walks {
  @override
  int get legs => 4;
}
