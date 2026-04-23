// Fixture for Phase 3 default-value rendering tests.
// ignore_for_file: avoid_init_to_null
//
// Exercises `_defaultValueSource` in `ElementModeExtractor`:
//   1. Primary: `param.constantInitializer?.toSource()`
//   2. Fallback: `param.defaultValueCode`
//
// Representative patterns the element walker must render correctly in the
// emitted bridge code. Each constructor covers a category:
//   - primitive literals (int, double, bool, String)
//   - explicit `null` default on a nullable type
//   - const collection literals
//   - enum-value defaults
//   - const constructor-call defaults
//   - nested expression defaults

enum TriState { on, off, auto }

class DurationLike {
  final int seconds;
  const DurationLike({this.seconds = 0});
}

class DefaultsAllKinds {
  DefaultsAllKinds({
    this.i = 42,
    this.d = 1.5,
    this.b = false,
    this.s = 'hello',
    this.n = null,
    this.list = const [1, 2, 3],
    this.map = const {'a': 1},
    this.tri = TriState.auto,
    this.dur = const DurationLike(seconds: 5),
  });

  final int i;
  final double d;
  final bool b;
  final String s;
  final String? n;
  final List<int> list;
  final Map<String, int> map;
  final TriState tri;
  final DurationLike dur;
}

class OptionalPositionalDefaults {
  OptionalPositionalDefaults([this.value = 0, this.label = 'x']);
  final int value;
  final String label;
}
