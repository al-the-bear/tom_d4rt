/// Test fixture for callback wrapping functionality.
///
/// This file contains classes with various function-type parameters
/// to test the bridge generator's callback wrapping capabilities.
library;

// =============================================================================
// Simple Callbacks
// =============================================================================

/// Typedef for simple void callback (no params, no return).
typedef VoidCallback = void Function();

/// Typedef for progress callback.
typedef ProgressCallback = void Function(int progress);

/// Typedef for item processor with multiple params.
typedef ItemProcessor = void Function(int index, String item);

/// Typedef for filter predicate.
typedef FilterPredicate = bool Function(int value);

/// Typedef for string transformer.
typedef StringTransformer = String Function(String input);

// =============================================================================
// Class with Simple Callbacks
// =============================================================================

/// Class demonstrating various callback patterns.
class CallbackClass {
  final String name;

  CallbackClass(this.name);

  /// Method with VoidCallback parameter.
  void onComplete(VoidCallback callback) {
    callback();
  }

  /// Method with progress callback.
  void onProgress(void Function(int) callback) {
    callback(50);
  }

  /// Method with multiple parameter callback.
  void onItemProcessed(void Function(int, String) callback) {
    callback(0, 'item');
  }

  /// Method with return-value callback.
  bool filter(bool Function(int) predicate) {
    return predicate(42);
  }

  /// Method with string transformer callback.
  String transform(String Function(String) transformer) {
    return transformer(name);
  }

  /// Method with nullable callback.
  void maybeNotify(VoidCallback? callback) {
    callback?.call();
  }

  /// Method with named callback parameter.
  void doWorkWithCallback({required VoidCallback onDone}) {
    // do work
    onDone();
  }

  /// Method with multiple callbacks.
  void processWithCallbacks({
    required VoidCallback onStart,
    required ProgressCallback onProgress,
    required VoidCallback onComplete,
  }) {
    onStart();
    onProgress(50);
    onComplete();
  }
}

// =============================================================================
// Class with Complex Callback Patterns
// =============================================================================

/// Class with more complex callback patterns.
class AdvancedCallbackClass {
  /// Method with callback that has optional parameters.
  /// Note: Named params in callbacks may need special handling.
  void withOptionalParamCallback(void Function(int, [String?]) callback) {
    callback(1);
    callback(2, 'optional');
  }

  /// Method with generic callback.
  T mapValue<T>(T Function(String) mapper, String input) {
    return mapper(input);
  }

  /// Method with nullable return callback.
  String? maybeTransform(String? Function(String) transformer, String input) {
    return transformer(input);
  }
}

// =============================================================================
// Class with Callback Fields (Constructor Parameters)
// =============================================================================

/// Class that takes callbacks in constructor.
class CallbackHolder {
  final VoidCallback? onReady;
  final ProgressCallback? onProgress;
  final FilterPredicate? filter;

  CallbackHolder({
    this.onReady,
    this.onProgress,
    this.filter,
  });

  void initialize() {
    onReady?.call();
  }

  void reportProgress(int value) {
    onProgress?.call(value);
  }

  bool shouldInclude(int value) {
    return filter?.call(value) ?? true;
  }
}

// =============================================================================
// Typedef Aliases for Common Patterns
// =============================================================================

/// ValueChanged pattern (common in Flutter).
typedef ValueChanged<T> = void Function(T value);

/// ValueGetter pattern.
typedef ValueGetter<T> = T Function();

/// ValueSetter pattern.
typedef ValueSetter<T> = void Function(T value);

/// Class using typedef aliases.
class TypedefAliasClass {
  /// Method with ValueChanged callback.
  void onChange(ValueChanged<int> callback) {
    callback(100);
  }

  /// Method with ValueGetter callback.
  int getValue(ValueGetter<int> getter) {
    return getter();
  }

  /// Method with ValueSetter callback.
  void setValue(ValueSetter<int> setter) {
    setter(42);
  }
}
