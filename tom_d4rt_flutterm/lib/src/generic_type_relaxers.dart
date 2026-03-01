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
        EdgeInsetsGeometry,
        Icon,
        IconThemeData,
        MouseCursor,
        OutlinedBorder,
        TextStyle,
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
