/// Top-level configuration that a user bridge overrides wholesale.
///
/// `@D4rtGlobalsUserBridge` lets a bridge replace global variables, getters and
/// functions of a library — handy when the *script* should see different
/// defaults (or a sandboxed implementation) than the native Dart program does.
/// The values here are the native defaults; [AppConfigUserBridge] substitutes
/// the values scripts actually observe.
library;

/// The application name as seen by native Dart code.
const String appName = 'NativeLedger';

/// The default maximum number of line items.
const int maxItems = 25;

/// The wall-clock time. A getter, so it is evaluated on each access.
DateTime get currentTime => DateTime.now();

/// Human-readable description of [what].
String describe(String what) => 'native: $what';

/// Apply a tax [rate] to an amount given in [cents], returning whole cents.
int taxCents(int cents, {double rate = 0.0}) => (cents * rate).round();
