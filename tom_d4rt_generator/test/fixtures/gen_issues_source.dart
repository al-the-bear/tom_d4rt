/// Test fixture for generator issues (GEN-095, GEN-096).
///
/// This file contains classes that reproduce generator-specific issues:
/// - GEN-095: Missing static factory method bridges
/// - GEN-096: Getter/method signature mismatch
library;

// =============================================================================
// GEN-095: Static Factory Methods
// =============================================================================

/// Class with static factory methods - simulates FontFeature pattern.
///
/// D4rt scripts should be able to call:
/// - `FeatureMock.feature('test')` - static factory method
/// - `FeatureMock.enable('test')` - another static factory
/// - `FeatureMock.disable('test')` - another static factory
class FeatureMock {
  final String tag;
  final int value;

  /// Private constructor.
  const FeatureMock._(this.tag, this.value);

  /// Named constructor - should be bridged.
  const FeatureMock.withValue(this.tag, this.value);

  /// Static factory method - reproduces GEN-095 if not bridged.
  static FeatureMock feature(String tag, [int value = 1]) {
    return FeatureMock._(tag, value);
  }

  /// Another static factory.
  static FeatureMock enable(String tag) {
    return FeatureMock._(tag, 1);
  }

  /// Another static factory.
  static FeatureMock disable(String tag) {
    return FeatureMock._(tag, 0);
  }

  /// Static getter returning an instance.
  static FeatureMock get defaultFeature => FeatureMock._('default', 1);

  /// Static method returning different type.
  static String describe(FeatureMock f) => '${f.tag}=${f.value}';

  @override
  String toString() => 'FeatureMock($tag, $value)';
}

/// Another class with static factories - different patterns.
class ColorMock {
  final int red;
  final int green;
  final int blue;
  final int alpha;

  const ColorMock(this.red, this.green, this.blue, [this.alpha = 255]);

  /// Static factory from hex.
  static ColorMock fromARGB(int a, int r, int g, int b) {
    return ColorMock(r, g, b, a);
  }

  /// Static factory from hex string.
  static ColorMock fromHex(String hex) {
    // Simplified parsing
    return ColorMock(0, 0, 0);
  }

  /// Static const-like factory.
  static ColorMock get transparent => ColorMock(0, 0, 0, 0);

  /// Static const-like factory.
  static ColorMock get black => ColorMock(0, 0, 0);

  /// Static const-like factory.
  static ColorMock get white => ColorMock(255, 255, 255);

  @override
  String toString() => 'ColorMock($red, $green, $blue, $alpha)';
}

// =============================================================================
// GEN-096: Getter vs Method Mismatch
// =============================================================================

/// Class demonstrating getter/method disambiguation.
///
/// Problem: Bridge may generate a member with wrong signature.
/// If DoNothingAction.consumesKey changed from getter to method,
/// or script calls method without required argument.
class ActionMock {
  final String name;

  ActionMock(this.name);

  /// Getter - should be accessible as property without ().
  bool get isEnabled => true;

  /// Method with parameter - must be called with argument.
  bool consumesKey(String key) {
    return key.isNotEmpty;
  }

  /// Method with optional parameter.
  bool maybeConsumesKey([String? key]) {
    return key?.isNotEmpty ?? false;
  }

  /// Getter with same pattern as potential method.
  /// If SDK changes this to method, bridge must regenerate.
  bool get shouldHandle => true;
}

/// Class simulating DoNothingAction pattern.
class DoNothingActionMock extends ActionMock {
  DoNothingActionMock() : super('doNothing');

  /// Override with different behavior.
  @override
  bool consumesKey(String key) {
    return false; // Do nothing action never consumes key
  }

  /// Overridden getter.
  @override
  bool get isEnabled => false;
}

// =============================================================================
// Combined Pattern: Static + Instance Members
// =============================================================================

/// Class with both static factories and instance members with potential issues.
class CombinedPatternMock {
  final String id;
  final int value;

  CombinedPatternMock(this.id, this.value);

  // Static factories
  static CombinedPatternMock create(String id) => CombinedPatternMock(id, 0);
  static CombinedPatternMock withValue(String id, int v) =>
      CombinedPatternMock(id, v);
  static CombinedPatternMock get empty => CombinedPatternMock('', 0);

  // Getter that could be mistaken for method
  bool get isEmpty => id.isEmpty && value == 0;

  // Method that could be mistaken for getter
  bool isValid() => id.isNotEmpty;

  // Callback setter (ENG-010 pattern)
  void Function()? onChange;
}
