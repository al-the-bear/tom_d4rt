/// GEN-079: Generic type relaxers for D4rt bridge type covariance.
///
/// When D4rt creates generic instances (e.g., `WidgetStateProperty.all(value)`),
/// the type argument defaults to `dynamic` because D4rt doesn't propagate
/// generic type arguments. Dart's reified generics then reject these at
/// parameter boundaries (e.g., `WidgetStatePropertyAll<dynamic>` is NOT
/// `WidgetStateProperty<Color?>`).
///
/// This file provides typed wrapper/proxy classes that implement the correct
/// generic interface and delegate to the underlying instance. A registration
/// function registers wrapper factories with [D4.registerGenericTypeWrapper]
/// so that [D4.extractBridgedArg] can automatically create wrappers when needed.
library;

import 'dart:ui' show Color, Offset, Size, VoidCallback;

import 'package:flutter/widgets.dart'
    show
        Animation,
        AnimationStatus,
        AnimationStatusListener,
        BorderSide,
        EdgeInsets,
        EdgeInsetsGeometry,
        Icon,
        IconThemeData,
        MagnifierInfo,
        MouseCursor,
        OutlinedBorder,
        TextStyle,
        ValueNotifier,
        Widget,
        WidgetState,
        WidgetStateProperty;
import 'package:tom_d4rt_exec/d4rt.dart' show D4;

/// Register all generic type wrapper factories with the D4rt runtime.
///
/// Call this once during bridge setup (before executing any D4rt scripts).
void registerGenericTypeRelaxers() {
  D4.registerGenericTypeWrapper(
    'WidgetStateProperty',
    _widgetStatePropertyFactory,
  );
  D4.registerGenericTypeWrapper('Animation', _animationFactory);
  D4.registerGenericTypeWrapper('ValueNotifier', _valueNotifierFactory);
}

/// Factory for creating typed [WidgetStateProperty] wrappers.
///
/// Maps inner type argument strings to properly typed [_RelaxedWSP] instances.
Object? _widgetStatePropertyFactory(Object value, String innerTypeArg) {
  if (value is! WidgetStateProperty) return null;
  return switch (innerTypeArg) {
    // dart:ui types
    'Color' => _RelaxedWSP<Color>(value),
    'Color?' => _RelaxedWSP<Color?>(value),
    'Size' => _RelaxedWSP<Size>(value),
    'Size?' => _RelaxedWSP<Size?>(value),
    // painting types
    'TextStyle' => _RelaxedWSP<TextStyle>(value),
    'TextStyle?' => _RelaxedWSP<TextStyle?>(value),
    'BorderSide' => _RelaxedWSP<BorderSide>(value),
    'BorderSide?' => _RelaxedWSP<BorderSide?>(value),
    'OutlinedBorder' => _RelaxedWSP<OutlinedBorder>(value),
    'OutlinedBorder?' => _RelaxedWSP<OutlinedBorder?>(value),
    'EdgeInsetsGeometry' => _RelaxedWSP<EdgeInsetsGeometry>(value),
    'EdgeInsetsGeometry?' => _RelaxedWSP<EdgeInsetsGeometry?>(value),
    // widgets types
    'MouseCursor' => _RelaxedWSP<MouseCursor>(value),
    'MouseCursor?' => _RelaxedWSP<MouseCursor?>(value),
    'Icon' => _RelaxedWSP<Icon>(value),
    'Icon?' => _RelaxedWSP<Icon?>(value),
    'Widget' => _RelaxedWSP<Widget>(value),
    'Widget?' => _RelaxedWSP<Widget?>(value),
    'IconThemeData' => _RelaxedWSP<IconThemeData>(value),
    'IconThemeData?' => _RelaxedWSP<IconThemeData?>(value),
    // primitives
    'double' => _RelaxedWSP<double>(value),
    'double?' => _RelaxedWSP<double?>(value),
    'bool' => _RelaxedWSP<bool>(value),
    'bool?' => _RelaxedWSP<bool?>(value),
    _ => null,
  };
}

/// GEN-079: Type-relaxing proxy for [WidgetStateProperty] with mismatched
/// generic type arguments.
///
/// Wraps a [WidgetStateProperty] (typically with `<dynamic>` type arg) and
/// presents it as [WidgetStateProperty<V>] with the correct type argument.
/// Delegates [resolve] to the inner instance and casts the result.
///
/// This is safe because the actual resolved values ARE of the correct type
/// (e.g., `WidgetStateProperty.all(Colors.red)` resolves to a `Color`),
/// only the compile-time generic argument was lost to `dynamic`.
class _RelaxedWSP<V> implements WidgetStateProperty<V> {
  final WidgetStateProperty _inner;

  _RelaxedWSP(this._inner);

  @override
  V resolve(Set<WidgetState> states) => _inner.resolve(states) as V;
}

// =============================================================================
// Animation<V> wrapper
// =============================================================================

/// Factory for creating typed [Animation] wrappers.
Object? _animationFactory(Object value, String innerTypeArg) {
  if (value is! Animation) return null;
  return switch (innerTypeArg) {
    'Color' => _RelaxedAnimation<Color>(value),
    'Color?' => _RelaxedAnimation<Color?>(value),
    'double' => _RelaxedAnimation<double>(value),
    'double?' => _RelaxedAnimation<double?>(value),
    'int' => _RelaxedAnimation<int>(value),
    'Offset' => _RelaxedAnimation<Offset>(value),
    'Size' => _RelaxedAnimation<Size>(value),
    _ => null,
  };
}

/// GEN-079: Type-relaxing proxy for [Animation] with mismatched
/// generic type arguments.
///
/// Wraps an [Animation] (typically with `<dynamic>` type arg) and
/// presents it as [Animation<V>] with the correct type argument.
class _RelaxedAnimation<V> extends Animation<V> {
  final Animation _inner;

  _RelaxedAnimation(this._inner);

  @override
  V get value => _inner.value as V;

  @override
  AnimationStatus get status => _inner.status;

  @override
  void addListener(VoidCallback listener) => _inner.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _inner.removeListener(listener);

  @override
  void addStatusListener(AnimationStatusListener listener) =>
      _inner.addStatusListener(listener);

  @override
  void removeStatusListener(AnimationStatusListener listener) =>
      _inner.removeStatusListener(listener);
}

// =============================================================================
// ValueNotifier<V> wrapper
// =============================================================================

/// Factory for creating typed [ValueNotifier] wrappers.
///
/// When D4rt creates `ValueNotifier(someValue)` and the value type isn't in
/// the foundation-library switch, the result is `ValueNotifier<dynamic>`.
/// This factory wraps it into a properly typed `ValueNotifier<V>`.
Object? _valueNotifierFactory(Object value, String innerTypeArg) {
  if (value is! ValueNotifier) return null;
  return switch (innerTypeArg) {
    // widgets types
    'MagnifierInfo' => _RelaxedValueNotifier<MagnifierInfo>(value),
    // painting types
    'EdgeInsets' => _RelaxedValueNotifier<EdgeInsets>(value),
    // dart:ui types
    'Color' => _RelaxedValueNotifier<Color>(value),
    'Color?' => _RelaxedValueNotifier<Color?>(value),
    'Offset' => _RelaxedValueNotifier<Offset>(value),
    'Size' => _RelaxedValueNotifier<Size>(value),
    // primitives (usually handled by constructor switch, but just in case)
    'int' => _RelaxedValueNotifier<int>(value),
    'double' => _RelaxedValueNotifier<double>(value),
    'bool' => _RelaxedValueNotifier<bool>(value),
    'String' => _RelaxedValueNotifier<String>(value),
    _ => null,
  };
}

/// GEN-079: Type-relaxing proxy for [ValueNotifier] with mismatched
/// generic type arguments.
///
/// Wraps a [ValueNotifier] (typically with `<dynamic>` type arg) and presents
/// it as [ValueNotifier<V>] with the correct type argument. Extends
/// [ValueNotifier<V>] to satisfy `is ValueNotifier<V>` checks and delegates
/// value access to the inner instance. Listener notifications are forwarded
/// bidirectionally to keep inner and wrapper in sync.
class _RelaxedValueNotifier<V> extends ValueNotifier<V> {
  final ValueNotifier _inner;
  bool _syncing = false;

  _RelaxedValueNotifier(this._inner) : super(_inner.value as V) {
    _inner.addListener(_forwardNotify);
  }

  /// Forward notifications from inner → wrapper so that listeners registered
  /// on this typed wrapper are notified when the inner value changes.
  void _forwardNotify() {
    if (!_syncing) {
      _syncing = true;
      super.value = _inner.value as V;
      _syncing = false;
    }
  }

  @override
  V get value => _inner.value as V;

  @override
  set value(V newValue) {
    if (!_syncing) {
      _syncing = true;
      _inner.value = newValue;
      super.value = newValue;
      _syncing = false;
    }
  }

  @override
  void dispose() {
    _inner.removeListener(_forwardNotify);
    super.dispose();
  }
}
