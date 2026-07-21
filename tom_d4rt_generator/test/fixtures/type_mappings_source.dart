/// Fixture for DGU3 typeMappings escape-hatch tests.
///
/// [Gadget] exposes an [Awkward]-typed parameter, return value, and field so
/// the generated bridge references `Awkward` in several type-resolution paths.
/// A `typeMappings: {'Awkward': 'dynamic'}` config must substitute every such
/// reference with `dynamic` while leaving [Awkward]'s own bridge registration
/// intact.
library;

class Awkward {
  final int value;
  Awkward(this.value);
}

class Gadget {
  Gadget(this.seed);

  final Awkward seed;

  Awkward transform(Awkward input) => input;

  List<Awkward> collect(Awkward first) => [first, seed];
}
