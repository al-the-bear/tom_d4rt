// Test fixtures intentionally contain doc comments with generic types
// ignore_for_file: unintended_html_in_doc_comment

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
/// - RC-6: Generic function types should preserve Function<T>(...) shape
library;

import 'dart:async';
import 'dart:collection' as coll;
import 'dart:math';
import 'package:meta/meta.dart';

import 'flutter_patterns_external_types.dart';
import 'flutter_patterns_external_types.dart' as ext;

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

/// Static constants used inside nested const-constructor defaults.
class ScalarPaletteLike {
  static const double thick = 3.0;
}

/// Reproduces defaults like `const BorderSide(color: Colors.white)`.
class WidgetWithNestedStaticConstDefault {
  final BoxSideLike side;

  const WidgetWithNestedStaticConstDefault({
    this.side = const BoxSideLike(width: ScalarPaletteLike.thick),
  });
}

const double _privateDefaultWidth = 2.5;
const double touchSlopLike = 18.0;

/// Reproduces Flutter defaults that reference private constants inside
/// const-constructor arguments. These identifiers are not visible from the
/// generated bridge library and must therefore be treated as non-wrappable.
class WidgetWithPrivateConstArgDefault {
  final BoxSideLike side;

  const WidgetWithPrivateConstArgDefault({
    this.side = const BoxSideLike(width: _privateDefaultWidth),
  });
}

class WidgetWithIdentifierConstArgDefault {
  final BoxSideLike side;

  const WidgetWithIdentifierConstArgDefault({
    this.side = const BoxSideLike(width: touchSlopLike),
  });
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

/// RC-9d: Slotted mixin-like generic bounds mirroring Flutter's
/// SlottedMultiChildRenderObjectWidgetMixin<dynamic, RenderObject> pattern.
class RenderObjectLike {}

class SlottedMultiChildRenderObjectWidgetMixinLike<
  ChildType,
  R extends RenderObjectLike
> {
  const SlottedMultiChildRenderObjectWidgetMixinLike();

  R updateRenderObject(R renderObject) => renderObject;
}

class SlottedRenderObjectElementLike {
  const SlottedRenderObjectElementLike();

  RenderObjectLike updateRenderObject(
    SlottedMultiChildRenderObjectWidgetMixinLike<dynamic, RenderObjectLike>
    widget,
    RenderObjectLike renderObject,
  ) {
    return widget.updateRenderObject(renderObject);
  }
}

class ConstraintsLike {}

class AbstractLayoutBuilderLike<C extends ConstraintsLike> {
  final C constraints;

  const AbstractLayoutBuilderLike(this.constraints);

  C current() => constraints;
}

class LayoutHostLike {
  final AbstractLayoutBuilderLike<ConstraintsLike> builder;

  const LayoutHostLike({required this.builder});
}

abstract class AbstractLayoutBuilderFamilyLike<
  ConstraintType extends ConstraintsLike
> {
  const AbstractLayoutBuilderFamilyLike();

  bool updateShouldRebuild(
    covariant AbstractLayoutBuilderFamilyLike<ConstraintType> oldWidget,
  ) {
    return identical(this, oldWidget);
  }
}

class ConstrainedLayoutBuilderLike<ConstraintType extends ConstraintsLike>
    extends AbstractLayoutBuilderFamilyLike<ConstraintType> {
  const ConstrainedLayoutBuilderLike();

  @override
  bool updateShouldRebuild(
    covariant AbstractLayoutBuilderFamilyLike<ConstraintType> oldWidget,
  ) {
    return false;
  }
}

class ConstrainedLayoutBuilderInheritedLike<
  ConstraintType extends ConstraintsLike
>
    extends AbstractLayoutBuilderFamilyLike<ConstraintType> {
  const ConstrainedLayoutBuilderInheritedLike();
}

abstract class AbstractLayoutBuilderGenericLike<C extends ConstraintsLike> {
  const AbstractLayoutBuilderGenericLike();

  bool updateShouldRebuild(
    covariant AbstractLayoutBuilderGenericLike<C> oldWidget,
  );
}

class ConcreteConstraintsLike extends ConstraintsLike {}

class ConcreteLayoutBuilderLike
    extends AbstractLayoutBuilderGenericLike<ConcreteConstraintsLike> {
  const ConcreteLayoutBuilderLike();

  @override
  bool updateShouldRebuild(
    covariant AbstractLayoutBuilderGenericLike<ConcreteConstraintsLike>
    oldWidget,
  ) {
    return false;
  }
}

class SlottedRenderObjectElementGenericLike<
  ChildType,
  R extends RenderObjectLike
> {
  const SlottedRenderObjectElementGenericLike();

  void update(
    SlottedMultiChildRenderObjectWidgetMixinLike<ChildType, R> widget,
  ) {
    widget.updateRenderObject(
      widget.updateRenderObject(RenderObjectLike() as R),
    );
  }
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

typedef PointFactoryLike = Point<double> Function();

class PointFactoryHostLike {
  final PointFactoryLike factory;

  const PointFactoryHostLike({required this.factory});

  Point<double> create() => factory();
}

class Queue {
  final String id;
  const Queue(this.id);
}

class QueueHostLike {
  final coll.Queue<int> items;

  const QueueHostLike({required this.items});
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

class FutureCodecHostLike {
  final Future<CodecLike> codec;

  const FutureCodecHostLike({required this.codec});
}

class PrefixedFutureExternalTypeHostLike {
  final Future<ext.ExternalBoundLike> value;

  const PrefixedFutureExternalTypeHostLike({required this.value});
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

// =============================================================================
// RC-6: Generic function type support
// =============================================================================

/// Generic callback type similar to Flutter pageRouteBuilder signatures.
typedef GenericRouteFactoryLike =
    T Function<T>(String name, Object Function(String context) builder);

/// Uses a generic function-typed callback. The generated wrapper must preserve
/// function-level type parameters (`<T>`) instead of erasing them.
class GenericRouteHostLike {
  Object makeRoute(
    String name,
    GenericRouteFactoryLike routeFactory,
    Object Function(String context) builder,
  ) {
    return routeFactory<Object>(name, builder);
  }
}

// =============================================================================
// RC-9b: Generic bounds from imported types (cross-file)
// =============================================================================

/// Tests that imported type bounds are preserved for generic parameters.
/// In Flutter this mirrors patterns like `<S extends RenderObject>`.
class ImportedBoundHostLike<T extends ExternalBoundLike> {
  final T value;

  ImportedBoundHostLike(this.value);

  T getValue() => value;
}

// =============================================================================
// RC-8.4b: `void` callback parameter should not be used as expression value
// =============================================================================

/// Mirrors Future<void>.then-like callback shape where the callback argument is
/// typed `void`. Generated wrappers must not use that parameter as a value.
typedef VoidValueCallbackLike = FutureOr<Object> Function(void value);

class VoidValueCallbackHostLike {
  final VoidValueCallbackLike onValue;

  const VoidValueCallbackHostLike({required this.onValue});
}

// =============================================================================
// RC-1c: Optional non-nullable bool parameters should not become bool?
// =============================================================================

class OptionalBoolHostLike {
  final bool autofocus;
  final bool includeSemantics;

  const OptionalBoolHostLike({
    this.autofocus = false,
    this.includeSemantics = true,
  });
}

// =============================================================================
// RC-7b: Imported function typedef in Map values should not degrade to dynamic
// =============================================================================

class ImportedRoutesHostLike {
  final Map<String, ExternalBuilderLike> routes;

  const ImportedRoutesHostLike({this.routes = const {}});
}

// =============================================================================
// RC-8.5: Optional named callback with default should remain non-nullable
// =============================================================================

List<String> _defaultInitialRoutes(int state, String name) => <String>[];

typedef InitialRoutesCallbackLike =
    List<String> Function(int state, String name);

class NavigatorLike {
  final InitialRoutesCallbackLike onGenerateInitialRoutes;

  const NavigatorLike({this.onGenerateInitialRoutes = _defaultInitialRoutes});
}

// =============================================================================
// RC-6b: Generic callback return type with nested generic argument
// =============================================================================

class PageRouteLike<T> {
  final T value;
  const PageRouteLike(this.value);
}

typedef GenericPageRouteBuilderLike =
    PageRouteLike<T> Function<T>(
      String settings,
      Object Function(String context) builder,
    );

class WidgetsAppLike {
  final GenericPageRouteBuilderLike? pageRouteBuilder;

  const WidgetsAppLike({this.pageRouteBuilder});
}

// =============================================================================
// RC-8.6: Contravariance for nullable callback parameter types
// =============================================================================

typedef NullableObjectPredicateLike = bool Function(Object? value);

class GestureMatcherLike {
  final NullableObjectPredicateLike? accepts;

  const GestureMatcherLike({this.accepts});

  bool matches(Object? candidate, [NullableObjectPredicateLike? override]) {
    final callback = override ?? accepts;
    if (callback == null) {
      return false;
    }
    return callback(candidate);
  }
}

// =============================================================================
// RC-1c: External-style defaults unavailable in analyzer metadata
// =============================================================================

class ExternalDefaultGapLike {
  external factory ExternalDefaultGapLike({bool scrollable, int maxLines});
}

class ExternalWideDefaultGapLike {
  external factory ExternalWideDefaultGapLike({
    bool scrollable,
    int maxLines,
    double scale,
    Duration duration,
    String label,
    SimpleValue offset,
  });
}

typedef StateSetterLike = void Function(void Function());
typedef StatefulBuilderLike =
    Object Function(String context, StateSetterLike setState);

class StatefulBuilderHostLike {
  final StatefulBuilderLike builder;

  const StatefulBuilderHostLike({required this.builder});
}

class ExternalStatefulBuilderHostLike {
  final ExternalStatefulBuilderLike builder;

  const ExternalStatefulBuilderHostLike({required this.builder});
}

class ExternalStatefulBuilderViaAliasHostLike {
  final ExternalStatefulBuilderViaAliasLike builder;

  const ExternalStatefulBuilderViaAliasHostLike({required this.builder});
}

class ExternalDragTargetLike<T extends Object> {
  final ExternalNullablePredicateLike<T>? onWillAccept;

  const ExternalDragTargetLike({this.onWillAccept});
}

class SlottedContainerRenderObjectMixinLike2<
  SlotType,
  R extends RenderObjectLike
>
    extends RenderObjectLike {}

abstract class SlottedWidgetBaseLike2<ChildType extends RenderObjectLike> {
  void updateRenderObject(ChildType renderObject);
}

class SlottedWidgetImplLike2
    extends
        SlottedWidgetBaseLike2<
          SlottedContainerRenderObjectMixinLike2<dynamic, RenderObjectLike>
        > {
  @override
  void updateRenderObject(
    SlottedContainerRenderObjectMixinLike2<dynamic, RenderObjectLike>
    renderObject,
  ) {}
}

class BaseRenderObjectWidgetLike {
  void updateRenderObject(
    String context,
    covariant RenderObjectLike renderObject,
  ) {}
}

mixin SlottedRenderObjectMixinOverrideLike<
  SlotType,
  ChildType extends RenderObjectLike
>
    on BaseRenderObjectWidgetLike {
  @override
  void updateRenderObject(
    String context,
    SlottedContainerRenderObjectMixinLike2<SlotType, ChildType> renderObject,
  ) {}
}

class SlottedInheritedPrecedenceWidgetLike extends BaseRenderObjectWidgetLike
    with SlottedRenderObjectMixinOverrideLike<dynamic, RenderObjectLike> {}

class SlottedContainerRenderObjectMixinRecursiveLike<
  SlotType,
  ChildType extends SlottedContainerRenderObjectMixinRecursiveLike<
    SlotType,
    ChildType
  >
>
    extends RenderObjectLike {}

abstract class SlottedMultiChildRenderObjectWidgetRecursiveLike<
  SlotType,
  ChildType extends SlottedContainerRenderObjectMixinRecursiveLike<
    SlotType,
    ChildType
  >
> {
  void updateRenderObject(String context, ChildType renderObject);
}

class ConcreteSlottedContainerRenderObjectLike
    extends
        SlottedContainerRenderObjectMixinRecursiveLike<
          dynamic,
          ConcreteSlottedContainerRenderObjectLike
        > {}

class SlottedMultiChildRenderObjectWidgetRecursiveImplLike
    extends
        SlottedMultiChildRenderObjectWidgetRecursiveLike<
          dynamic,
          ConcreteSlottedContainerRenderObjectLike
        > {
  @override
  void updateRenderObject(
    String context,
    ConcreteSlottedContainerRenderObjectLike renderObject,
  ) {}
}

abstract class SlottedMultiChildRenderObjectWidgetCovariantLike<
  SlotType,
  ChildType extends SlottedContainerRenderObjectMixinRecursiveLike<
    SlotType,
    ChildType
  >
> {
  void updateRenderObject(
    String context,
    covariant SlottedContainerRenderObjectMixinRecursiveLike<
      SlotType,
      ChildType
    >
    renderObject,
  );
}

class SlottedMultiChildRenderObjectWidgetCovariantImplLike
    extends
        SlottedMultiChildRenderObjectWidgetCovariantLike<
          dynamic,
          ConcreteSlottedContainerRenderObjectLike
        > {
  @override
  void updateRenderObject(
    String context,
    covariant SlottedContainerRenderObjectMixinRecursiveLike<
      dynamic,
      ConcreteSlottedContainerRenderObjectLike
    >
    renderObject,
  ) {}
}

class RenderObject {}

class RecursiveRenderObjectMixinLike<
  ChildType extends RecursiveRenderObjectMixinLike<ChildType>
>
    extends RenderObject {}

abstract class RecursiveRenderObjectWidgetLike<
  ChildType extends RecursiveRenderObjectMixinLike<ChildType>
> {
  void updateRenderObject(ChildType renderObject);
}

typedef SchedulingStrategyLike =
    bool Function({
      required int priority,
      required SchedulerBindingLike scheduler,
    });

class SchedulerBindingLike {
  SchedulingStrategyLike schedulingStrategy =
      ({required int priority, required SchedulerBindingLike scheduler}) =>
          true;
}

class ExternalSchedulingBaseLike {
  ext.ExternalSchedulingStrategyLike schedulingStrategy =
      ({
        required int priority,
        required ext.ExternalSchedulerBindingLike scheduler,
      }) => true;
}

class ExternalSchedulingInheritedLike extends ExternalSchedulingBaseLike {}

class InlineSchedulingStrategyHostLike {
  bool Function({
    required int priority,
    required ext.ExternalSchedulerBindingLike scheduler,
  })
  schedulingStrategy =
      ({
        required int priority,
        required ext.ExternalSchedulerBindingLike scheduler,
      }) => true;
}

class ProtectedBaseLike {
  @protected
  int get textTreeConfigurationLike => 1;

  @protected
  void debugFillPropertiesLike(String properties) {}
}

class ProtectedDerivedLike extends ProtectedBaseLike {}

class VisibleForOverridingHostLike {
  @visibleForOverriding
  void activateLike() {}
}

class ProtectedLifecycleBaseLike {
  @protected
  void lifecycleLike() {}
}

class ProtectedLifecycleOverrideLike extends ProtectedLifecycleBaseLike {
  @override
  void lifecycleLike() {}
}
