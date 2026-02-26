/// Test fixtures for bridge generator Flutter-specific patterns.
///
/// This file reproduces patterns found in Flutter SDK APIs that
/// cause compilation errors in generated bridges:
/// - RC-3: Enum as type parameter (core language type used as generic arg)
/// - RC-1: Non-wrappable const constructor defaults
/// - RC-5: Default values with import prefix references (e.g., ui.Type)
/// - RC-2: Callback parameters with non-nullable optional named params
/// - RC-9: Type parameter upper bounds erased to dynamic
/// - RC-4: dart: SDK type name clashes (e.g., dart:ui.Image vs Flutter Image)
/// - RC-8.1: Optional positional callback should NOT be made nullable
/// - RC-8.2: Callback return type should be preserved (not erased to dynamic)
library;

import 'dart:math';

// ignore_for_file: unused_element

// =============================================================================
// RC-3: Enum as type parameter
// =============================================================================

/// Simulates RestorableEnumN<T extends Enum> pattern from Flutter.
/// The generator must emit `Enum` unprefixed (it's a dart:core type).
class RestorableEnumLike<T extends Enum> {
  final T? defaultValue;
  final Iterable<T> values;

  RestorableEnumLike(this.defaultValue, {required this.values});

  Set<T> get currentValues => values.toSet();
}

/// Class that uses Enum directly as a parameter type.
class EnumHolder {
  final Enum value;
  final List<Enum> allValues;

  EnumHolder(this.value, {required this.allValues});
}

// =============================================================================
// RC-1: Non-wrappable const constructor defaults
// =============================================================================

/// A value class used in defaults (like Color, Radius, BorderSide, EdgeInsets).
class SimpleValue {
  final double x;
  final double y;
  const SimpleValue(this.x, this.y);
  const SimpleValue.zero() : x = 0, y = 0;
  static const SimpleValue origin = SimpleValue(0, 0);
}

/// Another value class for testing default patterns.
class BoxSideLike {
  final double width;
  const BoxSideLike({this.width = 1.0});
  static const BoxSideLike none = BoxSideLike(width: 0);
}

/// Class with non-wrappable const constructor defaults.
/// These are the patterns that cause RC-1 nullable fallback.
class WidgetWithDefaults {
  final SimpleValue offset;
  final BoxSideLike side;
  final double width;
  final bool enabled;

  /// Constructor with const constructor default values.
  /// `offset` default is `const SimpleValue(0, 0)` — non-wrappable.
  /// `side` default is `const BoxSideLike()` — non-wrappable.
  /// `width` default is `1.0` — wrappable (numeric literal).
  /// `enabled` default is `true` — wrappable (boolean literal).
  const WidgetWithDefaults({
    this.offset = const SimpleValue(0, 0),
    this.side = const BoxSideLike(),
    this.width = 1.0,
    this.enabled = true,
  });

  /// Named constructor with static access default (wrappable).
  const WidgetWithDefaults.withOrigin({
    this.offset = SimpleValue.origin,
    this.side = BoxSideLike.none,
    this.width = 2.0,
    this.enabled = false,
  });

  /// Named constructor with const named constructor default.
  const WidgetWithDefaults.zeroed({
    this.offset = const SimpleValue.zero(),
    this.side = const BoxSideLike(width: 0),
    this.width = 0.0,
    this.enabled = false,
  });
}

// =============================================================================
// RC-1b: Many non-wrappable defaults (exceeds combinatorial threshold of 4)
// =============================================================================

/// Simulates a Flutter widget with many const constructor defaults.
/// With 5 non-wrappable defaults, combinatorial dispatch (2^5 = 32) is disabled
/// and the generator falls back to individual parameter extraction.
class ManyDefaultsWidget {
  final SimpleValue topLeft;
  final SimpleValue topRight;
  final SimpleValue bottomLeft;
  final SimpleValue bottomRight;
  final BoxSideLike border;
  final double opacity;

  const ManyDefaultsWidget({
    this.topLeft = const SimpleValue(0, 0),
    this.topRight = const SimpleValue(1, 0),
    this.bottomLeft = const SimpleValue(0, 1),
    this.bottomRight = const SimpleValue(1, 1),
    this.border = const BoxSideLike(width: 2.0),
    this.opacity = 1.0,
  });
}

// =============================================================================
// RC-5: Typed empty collection with type that needs prefix resolution
// =============================================================================

/// Class with typed empty collection defaults whose type arg needs prefixing.
/// Simulates patterns like `const <ui.StringAttribute>[]` in Flutter.
class WidgetWithCollectionDefaults {
  final List<SimpleValue> items;
  final Map<String, BoxSideLike> named;

  const WidgetWithCollectionDefaults({
    this.items = const <SimpleValue>[],
    this.named = const <String, BoxSideLike>{},
  });
}

// =============================================================================
// RC-7: Map value type erased when it's a function type alias
// =============================================================================

/// A function typedef similar to WidgetBuilder.
typedef BuilderCallback = Object Function(String context);

/// Class with a Map parameter whose value type is a function typedef.
/// Simulates WidgetsApp.routes: Map<String, WidgetBuilder>.
class RouterLike {
  final Map<String, BuilderCallback> routes;

  RouterLike({this.routes = const {}});
}

// =============================================================================
// RC-2: Callback with non-nullable optional named params
// =============================================================================

/// Typedef that simulates ImageDecoderCallback from Flutter.
/// The `allowUpscaling` param is non-nullable bool but optional (has a default).
typedef DecoderCallback =
    Future<Object> Function(
      Object buffer, {
      bool allowUpscaling,
      int? cacheHeight,
      int? cacheWidth,
    });

/// Class that takes the callback as a parameter.
class ImageProviderLike {
  Object load(Object key, DecoderCallback decode) {
    return decode(key, allowUpscaling: false);
  }
}

// =============================================================================
// RC-9: Generic type bounds erased to dynamic
// =============================================================================

/// Simulates SlottedMultiChildRenderObjectWidgetMixin pattern.
/// Type parameter S has an upper bound that must be preserved.
class SlottedWidgetLike<S extends Comparable<S>, R extends Object> {
  final S slot;
  final R renderObject;

  SlottedWidgetLike(this.slot, this.renderObject);

  R getRenderObject() => renderObject;
}

/// Method taking a bounded generic parameter.
class LayoutBuilderLike<T extends num> {
  final T constraint;

  LayoutBuilderLike(this.constraint);

  T process(T input) => input;
}

/// RC-9 variant: Type parameter bounded by a non-built-in type from the same package.
/// In Flutter, this would be like `<R extends RenderObject>` where RenderObject
/// comes from a package import and needs to be prefixed.
class ContainerLike<T extends SimpleValue> {
  final T item;

  ContainerLike(this.item);

  T getItem() => item;
}

// =============================================================================
// RC-4: dart: SDK type name clashes
// =============================================================================

/// Uses dart:math.Point to test that non-core dart: SDK types get import
/// prefixes. In real Flutter scenarios, dart:ui.Image clashes with
/// Flutter's Image widget when both are imported unprefixed.
class WidgetWithSdkType {
  final Point<double> position;
  final Random rng;

  WidgetWithSdkType({required this.position, required this.rng});
}

// =============================================================================
// RC-8.1: Optional positional callback — non-nullable type shouldn't become nullable
// =============================================================================

void _noop() {}

/// Simulates pattern where optional positional callback has non-nullable type
/// with a default value. The generator must NOT emit `void Function()?` — the
/// type is non-nullable even though the param is optional.
class DecorationLike {
  void createBoxPainter([void Function() onChanged = _noop]) {
    onChanged();
  }
}
// =============================================================================
// RC-8.2: Callback return type preserved (not erased to dynamic)
// =============================================================================

/// Simulates dart:ui Codec — a concrete class used as callback return type.
class CodecLike {
  final int frameCount;
  CodecLike(this.frameCount);
}

/// Callback that returns a Future of a concrete type.
/// In Flutter: typedef ImageDecoderCallback = Future<Codec> Function(...)
typedef CodecDecoderCallback = Future<CodecLike> Function(Object key);

/// Uses a typedef callback with a concrete return type.
/// The generator must preserve the return type in the cast:
/// `as Future<CodecLike>` not `as Future<dynamic>`.
class ImageDecoderLike {
  Future<Object> load(Object key, CodecDecoderCallback decode) {
    return decode(key);
  }
}

// =============================================================================
// RC-8.3+4: Nullability of generic type params in callbacks + contravariance
// =============================================================================

/// Simulates DragTarget<T extends Object>.builder(List<T?>, ...) pattern.
/// When T is erased, List<T?> should become List<Object?> not List<Object>.
class DragTargetLike<T extends Object> {
  void build(
    void Function(List<T?> candidates, List<dynamic> rejected) builder,
  ) {
    builder([], []);
  }
}
