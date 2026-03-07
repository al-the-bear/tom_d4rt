/// Test fixture for setter callback issues (ENG-010).
///
/// This file contains classes with function-type setters to test that
/// the bridge generator wraps InterpretedFunction in native closures
/// for setter assignments, not just constructor parameters.
library;

// =============================================================================
// ENG-010: Function-typed Setters
// =============================================================================

/// Typedef simulating Flutter's gesture callback.
typedef GestureCallback = void Function(GestureDetails details);

/// Typedef simulating Flutter's animation status callback.
typedef AnimationStatusCallback = void Function(AnimationStatus status);

/// Simple details class for testing.
class GestureDetails {
  final double x;
  final double y;
  GestureDetails(this.x, this.y);
}

/// Simple enum for testing.
enum AnimationStatus { forward, reverse, completed, dismissed }

/// Class with callback setters - simulates GestureRecognizer pattern.
///
/// This reproduces the ENG-010 issue where:
/// - D4rt script assigns an InterpretedFunction to a callback setter
/// - Native code expects a typed function (void Function(GestureDetails))
/// - Assignment fails with "expected (GestureDetails) => void, got InterpretedFunction"
class GestureRecognizerMock {
  /// Callback setter - should wrap InterpretedFunction in native closure.
  GestureCallback? onStart;

  /// Another callback setter.
  GestureCallback? onUpdate;

  /// Yet another callback setter.
  GestureCallback? onEnd;

  /// Reset all callbacks.
  void reset() {
    onStart = null;
    onUpdate = null;
    onEnd = null;
  }

  /// Trigger callbacks for testing.
  void trigger() {
    onStart?.call(GestureDetails(0, 0));
    onUpdate?.call(GestureDetails(50, 50));
    onEnd?.call(GestureDetails(100, 100));
  }
}

/// Class with animation status callback - simulates AnimationController.
class AnimationMock {
  /// Status listener callback.
  AnimationStatusCallback? onStatusChanged;

  /// Method with callback parameter (already supported).
  void addStatusListener(AnimationStatusCallback listener) {
    // This should already work because method params are wrapped.
    listener(AnimationStatus.forward);
  }

  /// Trigger status change.
  void complete() {
    onStatusChanged?.call(AnimationStatus.completed);
  }
}

// =============================================================================
// ENG-010: Callback with Return Value Setters
// =============================================================================

/// Typedef for predicate callback with return value.
typedef FilterCallback = bool Function(int index);

/// Typedef for transform callback.
typedef TransformCallback = String Function(String input);

/// Class with callback setters that have return values.
class CallbackReturnSetters {
  /// Predicate setter - callback returns bool.
  FilterCallback? filter;

  /// Transform setter - callback returns String.
  TransformCallback? transform;

  /// Apply filter to list.
  List<int> applyFilter(List<int> items) {
    if (filter == null) return items;
    final result = <int>[];
    for (var i = 0; i < items.length; i++) {
      if (filter!(i)) result.add(items[i]);
    }
    return result;
  }

  /// Apply transform.
  String applyTransform(String input) {
    return transform?.call(input) ?? input;
  }
}

// =============================================================================
// ENG-011: Generic Method with Callback Return
// =============================================================================

/// Class simulating SynchronousFuture with generic then() method.
class SyncFutureMock<T> {
  final T value;

  SyncFutureMock(this.value);

  /// Generic method where callback may return null.
  /// This reproduces ENG-011 where:
  /// - D4rt callback returns null
  /// - Bridge tries to cast result as R (non-nullable)
  /// - Cast fails: "type 'Null' is not a subtype of type 'Object' in type cast"
  SyncFutureMock<R> then<R>(R Function(T) onValue) {
    final result = onValue(value);
    return SyncFutureMock<R>(result);
  }

  /// Generic method with nullable return.
  SyncFutureMock<R?> thenOrNull<R>(R? Function(T) onValue) {
    final result = onValue(value);
    return SyncFutureMock<R?>(result);
  }
}

// =============================================================================
// ENG-007: Nullable Type Extraction
// =============================================================================

/// Class for testing nullable parameter handling.
class TextStyleMock {
  final String fontFamily;
  final double fontSize;

  TextStyleMock({
    required this.fontFamily,
    required this.fontSize,
  });
}

/// Class that accepts nullable TextStyleMock parameters.
class TextWidgetMock {
  /// Nullable style parameter - should accept both null and non-null values.
  final TextStyleMock? style;

  TextWidgetMock({this.style});

  /// Method with nullable style parameter.
  String formatWith(TextStyleMock? customStyle) {
    final s = customStyle ?? style;
    return s != null ? '${s.fontFamily} ${s.fontSize}' : 'default';
  }
}
