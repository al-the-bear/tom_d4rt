// Fixture for A.5 `@Deprecated` allowlist tests.
// ignore_for_file: provide_deprecation_message
//
// Exercises `ElementModeExtractor._isDeprecatedExcluded`:
//   - `generateDeprecatedElements == false` + empty allowlist ⇒ every
//     `@Deprecated` symbol is skipped (historical behaviour).
//   - `generateDeprecatedElements == true` ⇒ every symbol emitted.
//   - allowlist containing a symbol's simple name ⇒ that symbol emitted
//     while the others stay skipped.
//
// One deprecated + one live symbol per element category that has a skip
// site (class, enum, function, top-level getter, top-level variable).

/// A live class that is always bridged.
class LiveWidget {
  final int value;
  const LiveWidget(this.value);
}

@Deprecated('use LiveWidget instead')
class LegacyWidget {
  final int value;
  const LegacyWidget(this.value);
}

@Deprecated('use a different gadget')
class LegacyGadget {
  final String label;
  const LegacyGadget(this.label);
}

enum LiveMode { a, b }

@Deprecated('use LiveMode instead')
enum LegacyMode { x, y }

int liveFunction(int a) => a + 1;

@Deprecated('use liveFunction instead')
int legacyFunction(int a) => a - 1;

int get liveGetter => 1;

@Deprecated('use liveGetter instead')
int get legacyGetter => 2;

const int liveConstant = 10;

@Deprecated('use liveConstant instead')
const int legacyConstant = 20;
