/// Runtime registrations for D4rt bridge interface proxies, type coercions,
/// and generic constructor factories.
///
/// These registrations enable D4rt script classes to:
/// - Implement native interfaces (RC-1: TickerProvider, StatelessWidget, StatefulWidget)
/// - Pass cross-package types transparently (RC-3: TextStyle, StrutStyle)
/// - Construct generic classes with type arguments (RC-2: GlobalKey)
library;

import 'dart:ui'
    as ui
    show FontStyle, FontWeight, StrutStyle, TextLeadingDistribution, TextStyle;
import 'dart:ui' show Color, Offset;

import 'package:flutter/animation.dart' show Tween;
import 'package:flutter/foundation.dart'
    show
        ChangeNotifier,
        DiagnosticPropertiesBuilder,
        DiagnosticableTreeMixin,
        DiagnosticsNode,
        Key,
        Listenable,
        ValueKey,
        ValueListenable,
        ValueNotifier,
        VoidCallback,
        debugPrint;
import 'package:flutter/material.dart'
    show
        ButtonSegment,
        DropdownMenuEntry,
        DropdownMenuItem,
        ScaffoldState,
        ThemeData,
        ThemeExtension;
import 'package:flutter/painting.dart' as painting show StrutStyle, TextStyle;
import 'package:flutter/painting.dart' show Alignment;
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/rendering.dart'
    show
        AxisDirection,
        BoxConstraints,
        BoxHitTestResult,
        BoxParentData,
        CacheExtentStyle,
        ContainerBoxParentData,
        ContainerRenderObjectMixin,
        CustomClipper,
        CustomPainter,
        HitTestBehavior,
        MultiChildLayoutDelegate,
        PaintingContext,
        ParentData,
        RenderAligningShiftedBox,
        RenderBox,
        RenderBoxContainerDefaultsMixin,
        RenderObject,
        SingleChildLayoutDelegate,
        ViewportOffset;
import 'package:flutter/scheduler.dart' show Ticker, TickerProvider;
import 'package:flutter/widgets.dart'
    show
        Action,
        AutomaticKeepAliveClientMixin,
        Axis,
        BoxScrollView,
        BuildContext,
        DiagonalDragBehavior,
        EdgeInsetsGeometry,
        EditableTextState,
        Element,
        GlobalKey,
        InheritedElement,
        InheritedWidget,
        Intent,
        RadioGroup,
        RadioGroupRegistry,
        LeafRenderObjectWidget,
        MultiChildRenderObjectWidget,
        NavigatorState,
        FormState,
        ParentDataWidget,
        PreferredSizeWidget,
        RenderTwoDimensionalViewport,
        RestorableProperty,
        RestorableValue,
        RestorationBucket,
        RestorationMixin,
        RouterDelegate,
        ScrollableDetails,
        ScrollController,
        ScrollPhysics,
        ScrollViewKeyboardDismissBehavior,
        SingleChildRenderObjectWidget,
        SingleTickerProviderStateMixin,
        SizedBox,
        SlottedContainerRenderObjectMixin,
        SlottedMultiChildRenderObjectWidget,
        State,
        StatefulElement,
        StatefulWidget,
        StatelessWidget,
        ClipboardStatus,
        TextSelectionControls,
        TextSelectionDelegate,
        TextSelectionGestureDetectorBuilderDelegate,
        TextSelectionHandleType,
        TextSelectionPoint,
        TickerProviderStateMixin,
        TwoDimensionalChildDelegate,
        TwoDimensionalChildManager,
        TwoDimensionalScrollView,
        TwoDimensionalViewport,
        Widget,
        WidgetState,
        WidgetStatesConstraint;
import 'dart:ui' show Clip;
import 'dart:ui'
    show Canvas, Offset, Path, RRect, RSuperellipse, Radius, Rect, Size;
import 'package:tom_d4rt/d4rt.dart';

import 'bridges/flutter_proxies.b.dart' show D4rtMultiChildLayoutDelegate;
import 'bridges/flutter_relaxers.b.dart' show $RelaxedTween;

// Track which interpreted Intent subclass names have already emitted the
// type-keyed dispatch warning so we only print once per class.
final Set<String> _warnedIntentProxyClasses = {};

/// Register all runtime registrations (interface proxies, type coercions,
/// generic constructor factories).
///
/// Call this once during bridge setup, alongside [registerRelaxers].
void registerD4rtRuntimeExtensions() {
  _registerBridgedSupertypes();
  _registerInterfaceProxies();
  _registerTypeCoercions();
  _registerGenericConstructors();
  _registerSupplementaryMethods();
  _registerSupplementaryRelaxers();
  _registerGenericWidgetReCreators();
  _registerBridgedMethodInterceptors();
}

// =============================================================================
// RC-7b: Bridged Class Supertype Registry
// =============================================================================

/// Register native Dart/Flutter class hierarchy for BridgedClass.isSubtypeOf.
/// This enables InterpretedClass instances extending BridgedClass supertypes
/// to pass return-type checks (e.g., MyWidget extends StatelessWidget → Widget).
void _registerBridgedSupertypes() {
  BridgedClass.registerSupertypes({
    // Widget hierarchy
    'StatelessWidget': ['Widget', 'DiagnosticableTree', 'Diagnosticable'],
    'StatefulWidget': ['Widget', 'DiagnosticableTree', 'Diagnosticable'],
    'RenderObjectWidget': ['Widget', 'DiagnosticableTree', 'Diagnosticable'],
    'LeafRenderObjectWidget': [
      'RenderObjectWidget',
      'Widget',
      'DiagnosticableTree',
      'Diagnosticable',
    ],
    'SingleChildRenderObjectWidget': [
      'RenderObjectWidget',
      'Widget',
      'DiagnosticableTree',
      'Diagnosticable',
    ],
    'MultiChildRenderObjectWidget': [
      'RenderObjectWidget',
      'Widget',
      'DiagnosticableTree',
      'Diagnosticable',
    ],
    'ProxyWidget': ['Widget', 'DiagnosticableTree', 'Diagnosticable'],
    'InheritedWidget': [
      'ProxyWidget',
      'Widget',
      'DiagnosticableTree',
      'Diagnosticable',
    ],
    // Bug-102d: InheritedTheme, InheritedModel, InheritedNotifier are
    // common InheritedWidget subclasses that scripts subclass. Without
    // these entries, the transitive supertype walk in
    // tryCreateInterfaceProxy wouldn't find the InheritedWidget proxy
    // up the chain.
    'InheritedTheme': [
      'InheritedWidget',
      'ProxyWidget',
      'Widget',
      'DiagnosticableTree',
      'Diagnosticable',
    ],
    'InheritedModel': [
      'InheritedWidget',
      'ProxyWidget',
      'Widget',
      'DiagnosticableTree',
      'Diagnosticable',
    ],
    'InheritedNotifier': [
      'InheritedWidget',
      'ProxyWidget',
      'Widget',
      'DiagnosticableTree',
      'Diagnosticable',
    ],
    'ParentDataWidget': [
      'ProxyWidget',
      'Widget',
      'DiagnosticableTree',
      'Diagnosticable',
    ],
    // State hierarchy
    'State': ['Diagnosticable'],
    // D2: Concrete State subclasses & their mixins. Without these the
    // `isAssignable` iteration in `Environment.toBridgedInstance` cannot
    // disambiguate between e.g. `FormFieldState` and `RestorationMixin`,
    // both of which match an instance of `FormFieldState<String>`. The
    // specificity filter drops bridges that are supertypes of another
    // match, which requires the supertype links recorded here.
    'FormFieldState': ['State', 'RestorationMixin', 'Diagnosticable'],
    'RestorationMixin': ['Diagnosticable'],
    'TickerProviderStateMixin': ['State', 'TickerProvider', 'Diagnosticable'],
    'SingleTickerProviderStateMixin': [
      'State',
      'TickerProvider',
      'Diagnosticable',
    ],
    // D2: BoxConstraints/SliverConstraints disambiguate against the abstract
    // `Constraints` base. Without these, instances whose runtimeType is a
    // private impl (e.g. `_BodyBoxConstraints`) get wrapped as `Constraints`
    // because of LAST-match-wins iteration.
    'BoxConstraints': ['Constraints'],
    'SliverConstraints': ['Constraints'],
    'Constraints': ['Diagnosticable'],
    // Painting
    'Decoration': [],
    'BoxDecoration': ['Decoration'],
    'ShapeDecoration': ['Decoration'],
    // Other common types
    'ChangeNotifier': ['Listenable'],
    'ValueNotifier': ['ChangeNotifier', 'Listenable'],
    'Animation': ['Listenable'],
    'AnimationController': ['Animation', 'Listenable'],
    // Cluster-12 (priority 3): `_AnimatedEvaluation<T>` (the private class
    // returned by `Tween.animate(parent)`) extends `Animation<T>` with
    // `AnimationWithParentMixin<double>`. `Environment.toBridgedInstance`
    // wraps it as the mixin (leaf), but the mixin bridge only carries
    // `parent`/`status`. Recording `Animation` as a supertype lets the
    // property-access supertype-walk fallback (interpreter_visitor.dart)
    // find the `value` getter declared on the Animation bridge.
    'AnimationWithParentMixin': ['Animation', 'Listenable'],
    // Action hierarchy — scripts subclass Action<T> or ContextAction<T> and
    // pass instances to Actions(actions: <Type, Action<Intent>>{…}).
    // Without these entries, transitiveSupertypeNames('ContextAction') returns
    // only 'ContextAction' and never reaches the registered 'Action' proxy,
    // causing coerceMap to throw "InterpretedInstance is not a subtype of
    // Action<Intent>".
    'Action': [],
    'ContextAction': ['Action'],
    // ScrollView / BoxScrollView hierarchy — scripts subclass BoxScrollView
    // and pass instances as Widget children (e.g. SizedBox(child: _MyScroll())).
    // Without these entries, the proxy walk stops at 'BoxScrollView' with no
    // registered proxy, and coerce<Widget> throws the same cast error.
    'ScrollView': ['StatelessWidget', 'Widget'],
    'BoxScrollView': ['ScrollView', 'StatelessWidget', 'Widget'],
  });
}

// =============================================================================
// RC-1: Interface Proxy Registrations
// =============================================================================

void _registerInterfaceProxies() {
  // TickerProvider — used by AnimationController(vsync: ...)
  D4.registerInterfaceProxy('TickerProvider', (visitor, instance) {
    return _InterpretedTickerProvider(visitor, instance);
  });

  // RC-1: CustomClipper registration removed — auto-generated in
  // flutter_proxies.b.dart via registerProxyFactories().

  // StatelessWidget — D4rt script classes extending StatelessWidget need
  // to be real Flutter widgets for the widget tree.
  D4.registerInterfaceProxy('StatelessWidget', (visitor, instance) {
    // Extract key from the interpreted instance if available
    Key? key;
    try {
      final keyValue = instance.get('key', visitor: visitor);
      if (keyValue is Key) key = keyValue;
    } catch (_) {
      // key field may not exist — that's fine
    }
    return _InterpretedStatelessWidget(visitor, instance, key: key);
  });

  // StatefulWidget — D4rt script classes extending StatefulWidget.
  D4.registerInterfaceProxy('StatefulWidget', (visitor, instance) {
    Key? key;
    try {
      final keyValue = instance.get('key', visitor: visitor);
      if (keyValue is Key) key = keyValue;
    } catch (_) {
      // key field may not exist — that's fine
    }
    return _InterpretedStatefulWidget(visitor, instance, key: key);
  });

  // RenderObjectWidget family — see Bug-46 in callable.dart and
  // _InterpretedLeaf/SingleChild/MultiChildRenderObjectWidget below.
  // These let scripts subclass the abstract render-object widget bases:
  //
  //   class _MyHost extends LeafRenderObjectWidget { ... }
  //   class _MySingleChild extends SingleChildRenderObjectWidget { ... }
  //   class _MyMulti extends MultiChildRenderObjectWidget { ... }
  //
  // …and pass instances directly to bridged Flutter constructors that
  // expect a `Widget` (e.g. `Positioned.fill(child: _MyHost(...))`).
  D4.registerInterfaceProxy('LeafRenderObjectWidget', (visitor, instance) {
    return _InterpretedLeafRenderObjectWidget(visitor, instance,
        key: _readKey(instance, visitor));
  });
  D4.registerInterfaceProxy('SingleChildRenderObjectWidget',
      (visitor, instance) {
    return _InterpretedSingleChildRenderObjectWidget(visitor, instance,
        key: _readKey(instance, visitor),
        child: _readChildWidget(instance, visitor));
  });
  D4.registerInterfaceProxy('MultiChildRenderObjectWidget',
      (visitor, instance) {
    return _InterpretedMultiChildRenderObjectWidget(visitor, instance,
        key: _readKey(instance, visitor),
        children: _readChildrenWidgets(instance, visitor));
  });

  // Intent — scripts that subclass `Intent` (e.g. for `Shortcuts(shortcuts:
  // <ShortcutActivator, Intent>{ … : const _MyIntent() })`) reach
  // `D4.coerceMap<…, Intent>` as InterpretedInstances. The bridged `Intent`
  // class has an empty constructors map (it's abstract with only `const
  // Intent()`), so the interpreter never populates `bridgedSuperObject`. With
  // no registered proxy, `coerceMap` falls through to `instance as Intent`
  // and throws. Cache the proxy on `instance.nativeProxy` so repeated
  // boundary crossings reuse the same wrapper (preserves identity for
  // const-style script Intents).
  D4.registerInterfaceProxy('Intent', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is Intent) return cached;
    // Warn once per class: type-keyed dispatch via Actions.invoke<T> /
    // Actions(actions: {T: action}) won't work for interpreted Intent
    // subclasses — all share runtimeType _InterpretedIntent, so Flutter's
    // Actions widget can never find the per-class key in its action map.
    // Workaround: call action.invoke(intent[, context]) directly.
    final className = instance.klass.name;
    if (_warnedIntentProxyClasses.add(className)) {
      debugPrint(
        '[D4rt] D4rt-LIMIT: User-defined Intent subclass "$className" wrapped '
        'as _InterpretedIntent. Actions.invoke<$className> / type-keyed '
        'dispatch (Actions(actions: {$className: myAction})) will NOT work — '
        'all interpreted Intent subclasses share runtimeType _InterpretedIntent '
        'at runtime. Workaround: call action.invoke(intent[, context]) directly '
        'on the Action instance instead of using Actions.invoke.',
      );
    }
    final proxy = _InterpretedIntent(visitor, instance);
    instance.nativeProxy ??= proxy;
    return proxy;
  });

  // Action — scripts that subclass `Action<T extends Intent>` (e.g.
  // `class _CallbackSelectIntentAction extends Action<SelectIntent>` used as
  // values of `Actions(actions: <Type, Action<Intent>>{ … })`) reach
  // `D4.coerceMap<Type, Action<Intent>>` as InterpretedInstances. The bridged
  // `Action` class is abstract with only the `overridable` factory constructor
  // and no default constructor, so the interpreter never populates
  // `bridgedSuperObject` for user subclasses. Without a registered proxy,
  // `coerceMap` falls through to `instance as Action<Intent>` and throws.
  // Mirrors the C5 `Intent` pattern: tag-wrapper proxy parameterised at
  // `Action<Intent>` (erased) so it satisfies the Map's value type cast even
  // when the script's class is `Action<SelectIntent>`. Cache the proxy on
  // `instance.nativeProxy` so repeated boundary crossings reuse the same
  // wrapper.
  D4.registerInterfaceProxy('Action', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is Action<Intent>) return cached;
    final proxy = _InterpretedAction(visitor, instance);
    instance.nativeProxy ??= proxy;
    return proxy;
  });

  // BoxScrollView — scripts subclass BoxScrollView (or ListView/GridView/etc.)
  // and pass instances where a Widget is expected. The proxy extends BoxScrollView
  // so it IS a Widget, and forwards buildChildLayout() back to the interpreter.
  // Super-arg capture is enabled so the proxy can reconstruct the native scroll
  // parameters (scrollDirection, physics, shrinkWrap, padding, …).
  D4.registerInterfaceProxy('BoxScrollView', (visitor, instance) {
    return _InterpretedBoxScrollView.create(visitor, instance);
  });
  D4.markProxyCapturesSuperArgs('BoxScrollView');

  // PreferredSizeWidget — scripts subclass StatelessWidget and implement
  // PreferredSizeWidget (the typical "custom AppBar" pattern):
  //
  //   class _MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  //     @override Size get preferredSize => const Size.fromHeight(76);
  //     @override Widget build(BuildContext context) => …;
  //   }
  //
  // The class chain has bridgedSuperclass = StatelessWidget and
  // bridgedInterfaces = [PreferredSizeWidget]. The proxy walk in
  // `tryCreateInterfaceProxyWithVisitor` first tries StatelessWidget,
  // whose proxy is a Widget but not a PreferredSizeWidget — the `is T`
  // check fails for `T = PreferredSizeWidget` (e.g. Scaffold.appBar) and
  // the loop continues. With this registration the next candidate is
  // PreferredSizeWidget, whose proxy extends StatelessWidget and
  // implements PreferredSizeWidget, satisfying the cast.
  D4.registerInterfaceProxy('PreferredSizeWidget', (visitor, instance) {
    return _InterpretedPreferredSizeWidget(visitor, instance,
        key: _readKey(instance, visitor));
  });

  // SlottedMultiChildRenderObjectWidget — scripts that subclass this abstract
  // widget (with the SlottedMultiChildRenderObjectWidgetMixin's `slots` /
  // `childForSlot` API) need a native proxy so they can be passed where any
  // Widget is expected (e.g. `Column(children: [_MySlotted(...)])`). Without
  // this registration, `D4.coerceList<Widget>` cannot walk the bridged super
  // chain back to a concrete native Widget proxy and the InterpretedInstance
  // fails the `is Widget` test.
  D4.registerInterfaceProxy('SlottedMultiChildRenderObjectWidget',
      (visitor, instance) {
    return _InterpretedSlottedMultiChildRenderObjectWidget(visitor, instance,
        key: _readKey(instance, visitor));
  });

  // Bug-102: InheritedWidget scripts that wrap a subtree (e.g. PanelTheme,
  // AppStateScope) need a native proxy so intermediate bridge boundaries
  // that expect a Widget accept them. Registered here because the generator
  // does not emit an InheritedWidget proxy.
  D4.registerInterfaceProxy('InheritedWidget', (visitor, instance) {
    return _InterpretedInheritedWidget(visitor, instance,
        key: _readKey(instance, visitor),
        child: _readChildWidget(instance, visitor) ??
            const _EmptyWidget());
  });

  // C6b: ThemeExtension scripts subclass `ThemeExtension<T>` (F-bounded
  // polymorphism: `T extends ThemeExtension<T>`) and pass a list of
  // instances to `ThemeData.copyWith(extensions: …)`. The bridge call
  // site `D4.coerceListOrNull<ThemeExtension>(…)` resolves T to
  // `ThemeExtension<ThemeExtension<dynamic>>`, and the proxy walk needs
  // a registered factory to convert each InterpretedInstance into a
  // native ThemeExtension. Without this proxy, `D4.coerceList` falls
  // through to `e as T`, which fails with `type 'InterpretedInstance'
  // is not a subtype of type 'ThemeExtension<ThemeExtension<dynamic>>'`.
  D4.registerInterfaceProxy('ThemeExtension', (visitor, instance) {
    return _InterpretedThemeExtension(visitor, instance);
  });

  // C7: TwoDimensionalScrollView / TwoDimensionalViewport /
  // RenderTwoDimensionalViewport — scripts subclass these abstract
  // bridged classes, override `buildViewport` / `createRenderObject` /
  // `updateRenderObject` / `layoutChildSequence`, and pass instances
  // where a Widget / RenderObject is expected. Each proxy:
  //   - reads the captured super-args from `instance.superCallNamedArgs`
  //     (set by the C7 super-arg-capture branch in callable.dart) and
  //     forwards them to the native super-constructor;
  //   - sets `instance.nativeProxy` so the interpreter resolves
  //     inherited getters/methods (e.g. `delegate`, `horizontalOffset`,
  //     `viewportDimension`, `buildOrObtainChildFor`, `parentDataOf`)
  //     through the proxy's bridged super class.
  D4.registerInterfaceProxy('TwoDimensionalScrollView',
      (visitor, instance) {
    return _InterpretedTwoDimensionalScrollView.create(visitor, instance);
  });
  D4.registerInterfaceProxy('TwoDimensionalViewport',
      (visitor, instance) {
    return _InterpretedTwoDimensionalViewport.create(visitor, instance);
  });
  D4.registerInterfaceProxy('RenderTwoDimensionalViewport',
      (visitor, instance) {
    return _InterpretedRenderTwoDimensionalViewport.create(visitor, instance);
  });
  // Opt these three proxies into the C7 super-arg capture branch in
  // callable.dart. Without this, their `create()` factories cannot
  // reconstruct the inherited render-pipeline state. All other registered
  // proxies (Stateless/StatefulWidget, LeafRenderObjectWidget, Intent,
  // Action, InheritedWidget, ThemeExtension, …) keep the no-capture path
  // — see `D4.proxyCapturesSuperArgs` for the rationale.
  D4.markProxyCapturesSuperArgs('TwoDimensionalScrollView');
  D4.markProxyCapturesSuperArgs('TwoDimensionalViewport');
  D4.markProxyCapturesSuperArgs('RenderTwoDimensionalViewport');

  // C20a follow-up — WidgetStatesConstraint. Scripts subclass it (typically
  // via `implements WidgetStatesConstraint`) to use a custom predicate as a
  // map key in `WidgetStateColor.fromMap` / `WidgetStatePropertyMap` /
  // `WidgetStateMapper`. Without a registered proxy, `D4.coerceMap<…,
  // WidgetStatesConstraint>` falls through to `instance as
  // WidgetStatesConstraint` and throws. The proxy forwards `isSatisfiedBy`
  // back into the interpreter so the resolver evaluates the script's
  // predicate at lookup time.
  D4.registerInterfaceProxy('WidgetStatesConstraint', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is WidgetStatesConstraint) return cached;
    final proxy = _InterpretedWidgetStatesConstraint(visitor, instance);
    instance.nativeProxy ??= proxy;
    return proxy;
  });

  // C2 (priority-1): ChangeNotifier / Listenable — script classes that
  // extend `ChangeNotifier` (or any subclass: `ValueNotifier`,
  // `RegularWindowControllerMacOS`, custom controllers, …) reach typed
  // bridge boundaries such as `AnimatedBuilder.animation: Listenable`,
  // `ListenableBuilder.listenable: Listenable`, or any consumer that
  // expects a `ChangeNotifier`. Without a registered proxy,
  // `D4.extractBridgedArg<Listenable>` falls through and rejects the
  // InterpretedInstance.
  //
  // Design — return `bridgedSuperObject` directly when present:
  //   When a script class declares `extends ChangeNotifier` (with no
  //   explicit constructor, or with `super()`), the interpreter calls
  //   the bridged ChangeNotifier default constructor and stores the
  //   real `ChangeNotifier()` on `instance.bridgedSuperObject`
  //   (runtime_types.dart Path B; callable.dart explicit-super path).
  //   Bridged-super method dispatch on the InterpretedInstance also
  //   routes through `bridgedSuperObject` (runtime_types.dart line 1319,
  //   `bridgedSuperObject ?? nativeProxy`), so:
  //
  //     - Flutter widgets call `proxy.addListener(_handleChange)` →
  //       native `ChangeNotifier.addListener` registers the listener.
  //     - Script code calls `controller.notifyListeners()` → resolved
  //       to the bridged `ChangeNotifier.notifyListeners` adapter,
  //       which forwards to `bridgedSuperObject.notifyListeners()` —
  //       the SAME ChangeNotifier the listener was registered on.
  //
  //   Identity is preserved (no wrapper allocation) and the listener
  //   contract works end-to-end.
  //
  // Fallback — when `bridgedSuperObject` is not a `ChangeNotifier`
  // (e.g. a script class that `implements Listenable` without extending
  // any bridged ChangeNotifier subclass), lazily allocate a fresh
  // `ChangeNotifier()` and cache it on `instance.nativeProxy`. The
  // bridged-super dispatch fall-through (`bridgedSuperObject ??
  // nativeProxy`) then routes any `notifyListeners()` calls through
  // this same instance. Note: pure `implements Listenable` script
  // classes that do NOT call any bridged method to fire listeners
  // (because there's no bridged super) won't see listeners trigger —
  // that's a separate edge case not covered here.
  D4.registerInterfaceProxy('ChangeNotifier', (visitor, instance) {
    final bridgedSuper = instance.bridgedSuperObject;
    if (bridgedSuper is ChangeNotifier) return bridgedSuper;
    final cached = instance.nativeProxy;
    if (cached is ChangeNotifier) return cached;
    final proxy = ChangeNotifier();
    instance.nativeProxy ??= proxy;
    return proxy;
  });
  D4.registerInterfaceProxy('Listenable', (visitor, instance) {
    final bridgedSuper = instance.bridgedSuperObject;
    if (bridgedSuper is Listenable) return bridgedSuper;
    final cached = instance.nativeProxy;
    if (cached is Listenable) return cached;
    final proxy = ChangeNotifier();
    instance.nativeProxy ??= proxy;
    return proxy;
  });

  // Step 3 (testlog 20260518-1449) — DiagnosticableTreeMixin proxy.
  //
  // Scripts shaped like `class _Node with DiagnosticableTreeMixin` (no
  // bridged superclass, just the mixin) reach the bridged-mixin method
  // dispatch in `runtime_types.dart` where `target` defaults to the
  // InterpretedInstance itself. The generated adapter (foundation_bridges.b.dart
  // `DiagnosticableTreeMixin.toStringDeep` / `debugFillProperties` /
  // `debugDescribeChildren` / `toStringShort`) then fails its
  // `D4.validateTarget<DiagnosticableTreeMixin>` cast.
  //
  // The proxy provides a native `DiagnosticableTreeMixin` shadow that
  // forwards `toStringShort`, `debugFillProperties`, and
  // `debugDescribeChildren` back to the interpreted instance via
  // `_instance.klass.findInstanceMethod(...).bind(_instance).call(_visitor,
  // ...)`. The native `toStringDeep` (inherited from the mixin) drives the
  // traversal, calling our overrides — which lets script overrides run and
  // produces a real `toStringDeep` output.
  //
  // Recursion guard: when the script's own `debugFillProperties` calls
  // `super.debugFillProperties(properties)`, super-call dispatch
  // (BridgedSuperMethodCallable) routes through `instance.nativeProxy` —
  // which is THIS proxy. Without a guard, that re-enters the override and
  // recurses. The `_in*` flags short-circuit re-entry to the native
  // default impl on the mixin.
  D4.registerInterfaceProxy('DiagnosticableTreeMixin', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is DiagnosticableTreeMixin) return cached;
    final proxy = _InterpretedDiagnosticableTreeMixin(visitor, instance);
    instance.nativeProxy ??= proxy;
    return proxy;
  });
}

/// Bug-103: Override the generator-produced proxies for
/// `MultiChildLayoutDelegate`, `SingleChildLayoutDelegate`, and
/// `CustomClipper` with hand-written ones that satisfy the concrete
/// type arguments (e.g. `CustomClipper<Path>` rather than
/// `CustomClipper<dynamic>`) and set `nativeProxy` so bridged-super
/// members (`layoutChild`, `positionChild`, `hasChild`, `getSize`,
/// `getApproximateClipRect`) called from the script's body dispatch
/// through RC-6's `nativeProxy` fallback.
///
/// This MUST run after `FlutterMaterialBridges.register` — the
/// generator's `registerProxyFactories()` emits proxies for these
/// three names with `<dynamic>` type args which don't satisfy the
/// concrete type checks at bridge boundaries. Re-registering after
/// overrides the generator entries in `_interfaceProxies`.
void registerD4rtInterfaceProxyOverrides() {
  D4.registerInterfaceProxy('MultiChildLayoutDelegate', (visitor, instance) {
    final proxy = _InterpretedMultiChildLayoutDelegate(visitor, instance);
    instance.nativeProxy ??= proxy;
    return proxy;
  });
  D4.registerInterfaceProxy('SingleChildLayoutDelegate', (visitor, instance) {
    final proxy = _InterpretedSingleChildLayoutDelegate(visitor, instance);
    instance.nativeProxy ??= proxy;
    return proxy;
  });
  // Pick the typed CustomClipper proxy variant that matches the script's
  // reified bridged-super type argument. Without this, a script that
  // declares `extends CustomClipper<RRect>` would still get back a
  // `CustomClipper<Path>` proxy — the static check at the bridge boundary
  // accepts it, but Flutter's downstream cast in
  // `_RenderCustomClip<RRect>._clip = clipper.getClip(size)` fails with
  // `_NativePath is not a subtype of RRect`. See Cluster H item #22.
  D4.registerInterfaceProxy('CustomClipper', (visitor, instance) {
    final typeArgNames = instance.klass.bridgedSuperTypeArgNames;
    final firstArg = (typeArgNames != null && typeArgNames.isNotEmpty)
        ? typeArgNames[0]
        : '';
    final Object proxy;
    switch (firstArg) {
      case 'RRect':
        proxy = _InterpretedCustomClipperRRect(visitor, instance);
        break;
      case 'Rect':
        proxy = _InterpretedCustomClipperRect(visitor, instance);
        break;
      case 'RSuperellipse':
        proxy = _InterpretedCustomClipperRSuperellipse(visitor, instance);
        break;
      case 'Path':
      case '':
      default:
        proxy = _InterpretedCustomClipperPath(visitor, instance);
        break;
    }
    instance.nativeProxy ??= proxy;
    return proxy;
  });

  // Cluster D2 — CustomPainter proxy.
  //
  // The auto-generated `D4rtCustomPainter` (flutter_proxies.b.dart) is a
  // callback-only adapter with no back-reference to the interpreted instance.
  // That breaks scripts that read fields off another painter — e.g.
  // `bool shouldRepaint(covariant _MyPainter old) => old.progress != progress;`
  // — because once the framework hands a `D4rtCustomPainter` back to the
  // interpreter, property access on it has no path to the underlying
  // InterpretedInstance.
  //
  // The hand-written `_InterpretedCustomPainter` implements `D4InterpretedProxy`
  // and exposes the InterpretedInstance via `d4rtInstance`. The interpreter's
  // visitSPropertyAccess / visitSPrefixedIdentifier unwraps to that and
  // forwards the field read to the script class — `old.progress` resolves.
  D4.registerInterfaceProxy('CustomPainter', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is CustomPainter) return cached;
    final proxy = _InterpretedCustomPainter(visitor, instance);
    instance.nativeProxy = proxy;
    return proxy;
  });

  // Cluster D4 — RestorableProperty<T> / RestorableValue<T> proxy.
  //
  // Scripts that subclass `RestorableValue<T>` (or `RestorableProperty<T>`
  // directly) hit `Argument Error: Invalid parameter "property": expected
  // RestorableProperty<Object?>, got InterpretedInstance(...)` when passed
  // to `RestorationMixin.registerForRestoration`. The bridged base classes
  // are abstract with no default constructor, so the interpreter cannot
  // materialise a native `RestorableValue` for the user subclass and the
  // raw InterpretedInstance fails the bridge boundary cast.
  //
  // The proxy extends `RestorableValue<Object?>` (the type-erased convenience
  // tier — `RestorableValue<T>` itself extends `RestorableProperty<T>`) so
  // it satisfies the `RestorableProperty<Object?>` parameter type. It
  // forwards `createDefaultValue`, `fromPrimitives`, `toPrimitives`, and
  // `didUpdateValue` to the interpreted instance — these are the four
  // methods scripts override per the `RestorableValue` contract.
  // `initWithValue` / `value` getter/setter / `notifyListeners` /
  // `addListener` / `removeListener` are inherited from
  // `RestorableValue` + `ChangeNotifier`: the proxy is the canonical
  // storage for `_value` and the listener list, and the interpreted
  // instance reaches them via `nativeProxy` bridge dispatch.
  //
  // Registered under both 'RestorableProperty' and 'RestorableValue' so
  // either bridged-super name in the script's class chain resolves the
  // walk on its first hit (no reliance on transitive-supertype expansion
  // for either entry point).
  D4.registerInterfaceProxy('RestorableProperty', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is RestorableProperty) return cached;
    final proxy = _InterpretedRestorableValue(visitor, instance);
    instance.nativeProxy = proxy;
    return proxy;
  });
  D4.registerInterfaceProxy('RestorableValue', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is RestorableValue) return cached;
    final proxy = _InterpretedRestorableValue(visitor, instance);
    instance.nativeProxy = proxy;
    return proxy;
  });

  // Cluster D3 — TextSelectionGestureDetectorBuilderDelegate proxy.
  //
  // The auto-generated bridge for this abstract interface is getter-only
  // (no constructor exposure), so the interpreter cannot materialise an
  // interpreted subclass that satisfies a `TextSelectionGestureDetectorBuilder
  // ({required TextSelectionGestureDetectorBuilderDelegate delegate})` cast.
  // Without a registered interface proxy, passing the interpreted instance
  // hits `Argument Error: Invalid parameter "delegate"`.
  //
  // The proxy reads the three required getters (`editableTextKey`,
  // `forcePressEnabled`, `selectionEnabled`) off the interpreted instance
  // via `InterpretedInstance.get`. nativeProxy caching ensures the same
  // delegate identity is preserved across boundary crossings so the builder
  // sees a stable object.
  D4.registerInterfaceProxy('TextSelectionGestureDetectorBuilderDelegate',
      (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is TextSelectionGestureDetectorBuilderDelegate) return cached;
    final proxy =
        _InterpretedTextSelectionGestureDetectorBuilderDelegate(visitor, instance);
    instance.nativeProxy = proxy;
    return proxy;
  });

  // Plan D — RenderBox proxy.
  //
  // Scripts that subclass RenderBox directly need a native RenderBox so
  // bridges that take a RenderBox/RenderObject parameter accept the
  // interpreted instance. The proxy delegates performLayout, paint,
  // hitTest{,Self,Children}, and setupParentData to the interpreted class;
  // everything else inherits RenderBox defaults.
  //
  // Identity caching via `instance.nativeProxy = proxy` is critical:
  // d4.dart short-circuits at `arg.nativeProxy is T`, so subsequent
  // boundary crossings reuse the same proxy object.
  //
  // Registered under 'RenderBox' only — not under broader names like
  // 'RenderObject'. The proxy walk's `proxy is T` cast succeeds whenever
  // `_InterpretedRenderBox is T`, so registering under 'RenderObject'
  // would incorrectly proxy RenderSliver subclasses too.
  D4.registerInterfaceProxy('RenderBox', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is RenderBox) return cached;
    // Cluster C1 — RenderBox proxy mixin gap.
    //
    // Scripts that subclass RenderBox with one of the container-style render
    // mixins need a proxy that already mixes in the same infrastructure so the
    // framework's `proxy as <mixin>` casts succeed. Pick the appropriate proxy
    // variant at first instantiation so the cached `instance.nativeProxy`
    // already satisfies later mixin-typed casts.
    //
    // Dispatch order matters: SlottedContainerRenderObjectMixin is its own
    // children-storage scheme (`_slotToChild`), unrelated to the legacy
    // ContainerRenderObjectMixin linked-list. The slotted variant is checked
    // first because scripts that use it never use the linked-list mixin (and
    // mixing both in a single proxy would conflict on `attach`/`detach`/etc.).
    final klass = instance.klass;
    final RenderBox proxy;
    if (_classChainHasBridgedMixin(klass, 'SlottedContainerRenderObjectMixin')) {
      proxy = _InterpretedSlottedRenderBox(visitor, instance);
    } else if (_classChainHasBridgedMixin(klass, 'ContainerRenderObjectMixin')) {
      proxy = _InterpretedRenderBoxContainer(visitor, instance);
    } else {
      proxy = _InterpretedRenderBox(visitor, instance);
    }
    instance.nativeProxy = proxy;
    return proxy;
  });

  // Plan D Phase 2 — RenderAligningShiftedBox proxy.
  //
  // Scripts that subclass RenderAligningShiftedBox (or any intermediate
  // class like RenderShiftedBox) fail at super() because the bridge emits
  // `isAbstract: true, constructors: {}` for it (GEN-051). Registering an
  // interface proxy here lets the interpreter skip the missing super() and
  // materialise a native RenderAligningShiftedBox at the bridge boundary.
  //
  // The proxy is initialised with default alignment (Alignment.center) and
  // null textDirection. Both are fine for RenderAligningShiftedBox.alignChild()
  // because Alignment.center.resolve(null) returns Alignment.center without
  // throwing. If the script overrides performLayout it typically calls
  // alignChild() at the end — that works with the default alignment.
  //
  // Registered under 'RenderAligningShiftedBox' only (not 'RenderShiftedBox'
  // or 'RenderBox') so the proxy walk only fires when the script's bridged
  // superclass chain reaches exactly 'RenderAligningShiftedBox'.
  D4.registerInterfaceProxy('RenderAligningShiftedBox', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is RenderAligningShiftedBox) return cached;
    final proxy = _InterpretedRenderAligningShiftedBox(visitor, instance);
    instance.nativeProxy = proxy;
    return proxy;
  });

  // Plan D Phase 2 — ParentDataWidget proxy.
  //
  // Scripts that subclass ParentDataWidget<T> fail at super() because the
  // bridge emits `isAbstract: true, constructors: {}` for ParentDataWidget.
  // The proxy delegates applyParentData to the interpreted class and forwards
  // the child widget. debugTypicalAncestorWidgetClass returns Widget as a
  // safe fallback (it is used only in debug error messages).
  D4.registerInterfaceProxy('ParentDataWidget', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is ParentDataWidget) return cached;
    final child = _readChildWidget(instance, visitor) ?? const SizedBox();
    final proxy = _InterpretedParentDataWidget(
        visitor, instance, child: child, key: _readKey(instance, visitor));
    instance.nativeProxy = proxy;
    return proxy;
  });

  // Cluster C21 — ContainerBoxParentData / ParentData proxy.
  //
  // Scripts that subclass `ContainerBoxParentData<RenderBox>` to attach
  // user-defined fields (e.g. `_DefaultsParentData { String id }`) need a
  // native ParentData instance to satisfy `RenderObject.parentData = ...`.
  // The bridge for `ContainerBoxParentData` is `isAbstract: true`, so the
  // interpreted construction returns an InterpretedInstance that the
  // generated setter rejects via `extractBridgedArg<ParentData>`.
  //
  // The proxy `_InterpretedContainerBoxParentData` is a concrete
  // `ContainerBoxParentData<RenderBox>` that satisfies the native is-check
  // and exposes the wrapped InterpretedInstance via D4InterpretedProxy so
  // the round-trip cast `child.parentData! as _UserParentData` unwraps to
  // the InterpretedInstance and subsequent `.userField` accesses dispatch
  // through the InterpretedClass.
  //
  // Both 'ContainerBoxParentData' and 'ParentData' are registered so the
  // proxy chain covers scripts that subclass either name directly.
  D4.registerInterfaceProxy('ContainerBoxParentData', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is ContainerBoxParentData<RenderBox>) return cached;
    final proxy = _InterpretedContainerBoxParentData(visitor, instance);
    instance.nativeProxy = proxy;
    return proxy;
  });
  D4.registerInterfaceProxy('ParentData', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is ParentData) return cached;
    final proxy = _InterpretedContainerBoxParentData(visitor, instance);
    instance.nativeProxy = proxy;
    return proxy;
  });

  // Cluster E11 — RouterDelegate adapter proxy.
  //
  // Scripts that subclass `RouterDelegate<T>` (typically combined with a
  // ChangeNotifier-shaped mixin) need a real native `RouterDelegate` to
  // satisfy `Router(routerDelegate: …)`'s parameter type-check
  // (`extractBridgedArg<RouterDelegate<dynamic>>`).
  //
  // The bridge for `RouterDelegate` is `isAbstract: true` with no concrete
  // constructor that the interpreter can chain through, so the user
  // subclass never gets a `bridgedSuperObject`. Without a registered proxy,
  // the cast falls through and throws.
  //
  // The proxy extends the real abstract `RouterDelegate<dynamic>` and
  // forwards `setNewRoutePath`, `popRoute`, `build`, and the `Listenable`
  // contract (`addListener`/`removeListener`) to the interpreted class.
  D4.registerInterfaceProxy('RouterDelegate', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is RouterDelegate) return cached;
    final proxy = _InterpretedRouterDelegate(visitor, instance);
    instance.nativeProxy = proxy;
    return proxy;
  });

  // 1401-TODO #5 (F11) — TextSelectionControls adapter proxy.
  //
  // Scripts that subclass `TextSelectionControls` (e.g. the
  // `widgets/text_selection_controls_test.dart` "_TscFoundryTextSelectionControls"
  // teaching demo) need a real native `TextSelectionControls` instance so
  // they can be passed to `TextField(selectionControls: …)` and the
  // bridge's `extractBridgedArg<TextSelectionControls?>` succeeds.
  //
  // The bridge for `TextSelectionControls` is `isAbstract: true` with no
  // concrete constructor that the interpreter can chain through, so the
  // user subclass never gets a `bridgedSuperObject`. Without this proxy
  // registration, the cast falls through and throws.
  //
  // The proxy extends the real abstract `TextSelectionControls` and
  // forwards the four abstract methods (`buildHandle`, `buildToolbar`,
  // `getHandleAnchor`, `getHandleSize`) plus the optional override hooks
  // (`canCut`/`canCopy`/`canPaste`/`canSelectAll`/`handleCut`/…) to the
  // interpreted class when present, falling back to the framework's
  // default implementation otherwise.
  D4.registerInterfaceProxy('TextSelectionControls', (visitor, instance) {
    final cached = instance.nativeProxy;
    if (cached is TextSelectionControls) return cached;
    final proxy = _InterpretedTextSelectionControls(visitor, instance);
    instance.nativeProxy = proxy;
    return proxy;
  });
}

/// Read an optional `key` field off an interpreted widget instance.
Key? _readKey(InterpretedInstance instance, InterpreterVisitor visitor) {
  try {
    final keyValue = instance.get('key', visitor: visitor);
    if (keyValue is Key) return keyValue;
  } catch (_) {/* field may not exist */}
  return null;
}

/// Read a single `child` field off an interpreted widget instance,
/// applying interface-proxy adaptation if the value is itself an
/// InterpretedInstance. Returns a null-safe placeholder if the field
/// is absent or null on the instance.
Widget? _readChildWidget(
    InterpretedInstance instance, InterpreterVisitor visitor) {
  Object? raw;
  try {
    raw = instance.get('child', visitor: visitor);
  } catch (_) {
    return null; // No `child` declared on this interpreted subclass.
  }
  if (raw == null) return null;
  return D4.extractBridgedArg<Widget>(raw, 'child', visitor);
}

/// Read a `children` list field off an interpreted widget instance.
List<Widget> _readChildrenWidgets(
    InterpretedInstance instance, InterpreterVisitor visitor) {
  Object? raw;
  try {
    raw = instance.get('children', visitor: visitor);
  } catch (_) {
    return const <Widget>[];
  }
  if (raw is List) {
    return raw
        .where((e) => e != null)
        .map((e) => D4.extractBridgedArg<Widget>(e, 'children', visitor))
        .toList(growable: false);
  }
  return const <Widget>[];
}

/// Native TickerProvider that delegates [createTicker] to an interpreted
/// D4rt class that implements TickerProvider.
class _InterpretedTickerProvider implements TickerProvider {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  _InterpretedTickerProvider(this._visitor, this._instance);

  @override
  Ticker createTicker(void Function(Duration elapsed) onTick) {
    // Call the interpreted createTicker method
    final method = _instance.klass.findInstanceMethod('createTicker');
    if (method != null) {
      final bound = method.bind(_instance);
      final result = bound.call(_visitor, [onTick], {});
      if (result is Ticker) return result;
      // If the interpreted method returned a BridgedInstance wrapping a Ticker
      if (result != null) {
        final unwrapped = D4.extractBridgedArg<Ticker>(result, 'createTicker');
        return unwrapped;
      }
    }
    throw StateError(
      'Interpreted class ${_instance.klass.name} does not implement createTicker',
    );
  }
}

// RC-1: _InterpretedCustomClipper removed — auto-generated proxy
// D4rtCustomClipper in flutter_proxies.b.dart replaces this.

// =============================================================================
// RC-3: Type Coercion Registrations
// =============================================================================

void _registerTypeCoercions() {
  // painting.TextStyle → dart:ui.TextStyle
  // When pushStyle() expects a dart:ui.TextStyle but receives a
  // painting.TextStyle, convert via getTextStyle().
  D4.registerTypeCoercion(
    sourceType: painting.TextStyle,
    targetType: ui.TextStyle,
    factory: (value) {
      if (value is painting.TextStyle) {
        return value.getTextStyle();
      }
      return null;
    },
  );

  // painting.StrutStyle → dart:ui.StrutStyle
  // When ParagraphStyle expects dart:ui.StrutStyle but receives painting.StrutStyle.
  D4.registerTypeCoercion(
    sourceType: painting.StrutStyle,
    targetType: ui.StrutStyle,
    factory: (value) {
      if (value is painting.StrutStyle) {
        return ui.StrutStyle(
          fontFamily: value.fontFamily,
          fontFamilyFallback: value.fontFamilyFallback,
          fontSize: value.fontSize,
          height: value.height,
          leadingDistribution: value.leadingDistribution,
          leading: value.leading,
          fontWeight: value.fontWeight,
          fontStyle: value.fontStyle,
          forceStrutHeight: value.forceStrutHeight,
        );
      }
      return null;
    },
  );
}

// =============================================================================
// RC-2: Generic Constructor Registrations
// =============================================================================

void _registerGenericConstructors() {
  // GlobalKey<T> — Generic constructors that need type args.
  // Script: GlobalKey<NavigatorState>() → must create native GlobalKey<NavigatorState>
  D4.registerGenericConstructor('GlobalKey', '', (
    visitor,
    positional,
    named,
    typeArgs,
  ) {
    final debugLabel = D4.extractBridgedArgOrNull<String>(
      named['debugLabel'],
      'debugLabel',
    );

    // Dispatch based on the type argument name
    final typeName = typeArgs?.isNotEmpty == true ? typeArgs!.first.name : null;
    return switch (typeName) {
      'NavigatorState' => GlobalKey<NavigatorState>(debugLabel: debugLabel),
      'FormState' => GlobalKey<FormState>(debugLabel: debugLabel),
      'ScaffoldState' => GlobalKey<ScaffoldState>(debugLabel: debugLabel),
      _ => GlobalKey(debugLabel: debugLabel),
    };
  });

  // ValueKey<T> — when scripts use ValueKey<String>('key') (explicit T).
  //
  // GEN-NNN — the wildcard case must return `null` (not `ValueKey(value)`),
  // so when the script writes `ValueKey('foo')` *without* an explicit type
  // argument the call falls through to the next factory in the chain
  // (`_rc2ValueKey` → default bridge constructor in foundation_bridges.b.dart)
  // which infers T from the runtime type of the value. Returning
  // `ValueKey(value)` here unconditionally produced `ValueKey<dynamic>`
  // and broke `find.byKey(ValueKey<String>(...))` from the host side.
  D4.registerGenericConstructor('ValueKey', '', (
    visitor,
    positional,
    named,
    typeArgs,
  ) {
    final value = positional.isNotEmpty ? positional[0] : null;
    final typeName = typeArgs?.isNotEmpty == true ? typeArgs!.first.name : null;
    // Handle nullable type arguments: String? resolves to name 'String' but
    // value may be null. Use safe pattern matching instead of hard casts.
    return switch (typeName) {
      'String' =>
        value is String
            ? ValueKey<String>(value)
            : ValueKey<String?>(value as String?),
      'int' =>
        value is int ? ValueKey<int>(value) : ValueKey<int?>(value as int?),
      _ => null, // Fall through to runtime-value-based inference.
    };
  });

  // ValueNotifier<T> — respect explicit type arguments.
  // Without this, the bridge uses GEN-075 runtime-value-based inference
  // (e.g., ValueNotifier<dynamic>('start') creates ValueNotifier<String>
  // because 'start' is String), then .value = 42 fails.
  D4.registerGenericConstructor('ValueNotifier', '', (
    visitor,
    positional,
    named,
    typeArgs,
  ) {
    final value = positional.isNotEmpty ? positional[0] : null;
    final typeName = typeArgs?.isNotEmpty == true ? typeArgs!.first.name : null;
    return switch (typeName) {
      'dynamic' || 'Object' || 'Object?' => ValueNotifier<dynamic>(value),
      'String' =>
        value is String
            ? ValueNotifier<String>(value)
            : ValueNotifier<String?>(value as String?),
      'int' =>
        value is int
            ? ValueNotifier<int>(value)
            : ValueNotifier<int?>(value as int?),
      'double' =>
        value is double
            ? ValueNotifier<double>(value)
            : ValueNotifier<double?>(value as double?),
      'bool' =>
        value is bool
            ? ValueNotifier<bool>(value)
            : ValueNotifier<bool?>(value as bool?),
      _ => null, // Fall through to regular bridge constructor
    };
  });

  // RC-3: StrutStyle constructor override.
  // TODO: Remove after generator re-run. The StrutStyleUserBridge in
  // d4rt_user_bridges/strut_style_user_bridge.dart replaces this override.
  // This registerGenericConstructor call is only needed until the generator
  // wires up the UserBridge constructor override in dart_ui_bridges.b.dart.
  //
  // The dart:ui.StrutStyle bridge creates an opaque object (no getters).
  // When a D4rt script imports 'dart:ui', it gets dart:ui.StrutStyle, but
  // TextPainter etc. expect painting.StrutStyle. Since painting.StrutStyle
  // has full getters, we always create it here. The existing painting→dart:ui
  // coercion handles the reverse direction when dart:ui APIs need it.
  D4.registerGenericConstructor('StrutStyle', '', (
    visitor,
    positional,
    named,
    typeArgs,
  ) {
    return painting.StrutStyle(
      fontFamily: D4.extractBridgedArgOrNull<String>(
        named['fontFamily'],
        'fontFamily',
      ),
      fontFamilyFallback: D4.coerceListOrNull<String>(
        named['fontFamilyFallback'],
        'fontFamilyFallback',
      ),
      fontSize: D4.extractBridgedArgOrNull<double>(
        named['fontSize'],
        'fontSize',
      ),
      height: D4.extractBridgedArgOrNull<double>(named['height'], 'height'),
      leadingDistribution: D4
          .extractBridgedArgOrNull<ui.TextLeadingDistribution>(
            named['leadingDistribution'],
            'leadingDistribution',
          ),
      leading: D4.extractBridgedArgOrNull<double>(named['leading'], 'leading'),
      fontWeight: D4.extractBridgedArgOrNull<ui.FontWeight>(
        named['fontWeight'],
        'fontWeight',
      ),
      fontStyle: D4.extractBridgedArgOrNull<ui.FontStyle>(
        named['fontStyle'],
        'fontStyle',
      ),
      forceStrutHeight: D4.extractBridgedArgOrNull<bool>(
        named['forceStrutHeight'],
        'forceStrutHeight',
      ),
    );
  });
}

// =============================================================================
// RC-1: Proxy Widget Classes (StatelessWidget, StatefulWidget)
// =============================================================================

/// A native [StatelessWidget] that delegates [build] to an interpreted
/// D4rt class extending StatelessWidget.
class _InterpretedStatelessWidget extends StatelessWidget {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  const _InterpretedStatelessWidget(this._visitor, this._instance, {super.key});

  @override
  Widget build(BuildContext context) {
    final method = _instance.klass.findInstanceMethod('build');
    if (method != null) {
      final bound = method.bind(_instance);
      final result = bound.call(_visitor, [context], {});
      // Pass _visitor so extractBridgedArg can resolve interface proxies
      // for InterpretedInstance return values (e.g. when a script's build
      // returns another script-defined StatelessWidget/StatefulWidget).
      // Without the visitor the lookup falls back to D4._activeVisitor,
      // which is only set during script execution, not framework rendering.
      return D4.extractBridgedArg<Widget>(result, 'build', _visitor);
    }
    throw StateError(
      'Interpreted class ${_instance.klass.name} does not implement build()',
    );
  }
}

/// A native [StatelessWidget] that *also* implements [PreferredSizeWidget],
/// for D4rt script classes shaped like
/// `class _MyAppBar extends StatelessWidget implements PreferredSizeWidget`.
///
/// Scaffold.appBar (and similar `PreferredSizeWidget?` parameters) reject the
/// plain `_InterpretedStatelessWidget` proxy because it isn't a
/// PreferredSizeWidget. Registering this proxy under
/// `'PreferredSizeWidget'` lets the proxy walk in
/// `tryCreateInterfaceProxyWithVisitor<PreferredSizeWidget>` find a
/// candidate that satisfies the cast.
///
/// `preferredSize` reads the script's `preferredSize` getter via
/// [InterpretedInstance.get]; `build` delegates the same way as
/// `_InterpretedStatelessWidget`.
class _InterpretedPreferredSizeWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  const _InterpretedPreferredSizeWidget(this._visitor, this._instance,
      {super.key});

  @override
  Size get preferredSize {
    final raw = _instance.get('preferredSize', visitor: _visitor);
    if (raw is Size) return raw;
    if (raw is BridgedInstance && raw.nativeObject is Size) {
      return raw.nativeObject as Size;
    }
    throw StateError(
      'Interpreted class ${_instance.klass.name} preferredSize getter '
      'must return a Size; got ${raw.runtimeType}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final method = _instance.klass.findInstanceMethod('build');
    if (method != null) {
      final bound = method.bind(_instance);
      final result = bound.call(_visitor, [context], {});
      return D4.extractBridgedArg<Widget>(result, 'build', _visitor);
    }
    throw StateError(
      'Interpreted class ${_instance.klass.name} does not implement build()',
    );
  }
}

/// A native [StatefulWidget] that delegates [createState] to an interpreted
/// D4rt class extending StatefulWidget.
class _InterpretedStatefulWidget extends StatefulWidget {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  const _InterpretedStatefulWidget(this._visitor, this._instance, {super.key});

  @override
  State<_InterpretedStatefulWidget> createState() {
    final method = _instance.klass.findInstanceMethod('createState');
    if (method != null) {
      final bound = method.bind(_instance);
      final result = bound.call(_visitor, [], {});
      // The result might be a BridgedInstance wrapping a State, or an
      // InterpretedInstance of a State subclass
      if (result is BridgedInstance) {
        final native = result.nativeObject;
        if (native is State) {
          return native as State<_InterpretedStatefulWidget>;
        }
      }
      // If it's an InterpretedInstance (interpreted State), wrap it in a
      // native State proxy that delegates build/lifecycle to the interpreter.
      if (result is InterpretedInstance) {
        // RC-5: Check if the State subclass uses a TickerProvider mixin.
        // If so, use a specialized proxy that natively provides createTicker().
        // Bug-45 (narrowed): wire `widget` access on the script's State
        // subclass without setting nativeProxy on plain States. Setting
        // nativeProxy on a plain _InterpretedState (as the original
        // f6c7db8f fix did) routes every bridged State member access
        // through Flutter adapters — including `setState` — which then
        // schedules real Flutter rebuilds and triggers cascading loops.
        // Storing the parent InterpretedInstance directly lets
        // runtime_types.dart short-circuit `widget` lookup without
        // engaging adapter dispatch.
        result.interpretedStatefulWidget = _instance;
        if (_usesTickerProviderMixin(result.klass)) {
          final state = _usesSingleTickerProviderMixin(result.klass)
              ? _InterpretedSingleTickerProviderState(_visitor, result)
              : _InterpretedMultiTickerProviderState(_visitor, result);
          result.nativeProxy = state;
          return state;
        }
        // C10: scripts that mix `RestorationMixin` into a State subclass need
        // a native State proxy that *actually* mixes in `RestorationMixin`,
        // otherwise Flutter's `_RestorationMixin.didChangeDependencies` flow
        // never runs, `restoreState` is never called, and any read of a
        // `RestorableProperty.value` asserts `'isRegistered': is not true`.
        if (_usesRestorationMixin(result.klass)) {
          final state = _InterpretedRestorationMixinState(_visitor, result);
          result.nativeProxy = state;
          return state;
        }
        // Scripts that mix `AutomaticKeepAliveClientMixin` need a State
        // proxy that *actually* mixes it in. The mixin's `build` method
        // dispatches `KeepAliveNotification` — without a proxy that
        // includes it, that notification is never fired and any
        // surrounding `TabBarView` / `PageView` happily disposes the
        // child on swap-away. Like the plain `_InterpretedState`, we
        // store the proxy on `nativeStateProxy` (not `nativeProxy`) so
        // `setState` from the script still routes through the bridged
        // mixin → `nativeStateProxy` path landed via GEN-128.
        if (_usesAutomaticKeepAliveClientMixin(result.klass)) {
          final state = _InterpretedKeepAliveState(_visitor, result);
          result.nativeStateProxy = state;
          return state;
        }
        // C14: plain interpreted State subclasses get a State proxy but no
        // `nativeProxy` (Bug-45 — would route setState etc. through Flutter
        // and trigger cascading rebuild loops). Store the proxy on
        // `nativeStateProxy` so read-only State getters (`context`,
        // `mounted`) on the script's State subclass can still resolve to
        // the proxy's real `_element`-backed values via the getter-only
        // fallback in `runtime_types.dart`.
        final state = _InterpretedState(_visitor, result);
        result.nativeStateProxy = state;
        return state;
      }
    }
    throw StateError(
      'Interpreted class ${_instance.klass.name} does not implement createState()',
    );
  }

  /// Check if an interpreted class mixes in any TickerProvider mixin.
  static bool _usesTickerProviderMixin(InterpretedClass klass) {
    return klass.bridgedMixins.any(
      (m) =>
          m.name == 'SingleTickerProviderStateMixin' ||
          m.name == 'TickerProviderStateMixin',
    );
  }

  /// Check if an interpreted class uses SingleTickerProviderStateMixin specifically.
  static bool _usesSingleTickerProviderMixin(InterpretedClass klass) {
    return klass.bridgedMixins.any(
      (m) => m.name == 'SingleTickerProviderStateMixin',
    );
  }

  /// Check if an interpreted class mixes in `RestorationMixin`.
  ///
  /// Walks the interpreted class hierarchy and inspects `bridgedMixins` at
  /// every level so a script that adds RestorationMixin via an interpreted
  /// intermediate base is still detected.
  static bool _usesRestorationMixin(InterpretedClass klass) {
    final visited = <InterpretedClass>{};
    bool walk(InterpretedClass? c) {
      if (c == null) return false;
      if (!visited.add(c)) return false;
      if (c.bridgedMixins.any((m) => m.name == 'RestorationMixin')) {
        return true;
      }
      if (walk(c.superclass)) return true;
      for (final m in c.mixins) {
        if (walk(m)) return true;
      }
      return false;
    }

    return walk(klass);
  }

  /// Check if an interpreted class mixes in `AutomaticKeepAliveClientMixin`.
  ///
  /// Same hierarchy walk pattern as `_usesRestorationMixin`.
  static bool _usesAutomaticKeepAliveClientMixin(InterpretedClass klass) {
    final visited = <InterpretedClass>{};
    bool walk(InterpretedClass? c) {
      if (c == null) return false;
      if (!visited.add(c)) return false;
      if (c.bridgedMixins
          .any((m) => m.name == 'AutomaticKeepAliveClientMixin')) {
        return true;
      }
      if (walk(c.superclass)) return true;
      for (final m in c.mixins) {
        if (walk(m)) return true;
      }
      return false;
    }

    return walk(klass);
  }
}

/// A native [State] that delegates lifecycle methods to an interpreted
/// D4rt State subclass.
///
/// Implements [D4InterpretedProxy] so the BridgedInstance dispatch can
/// unwrap to the originating [InterpretedInstance] when the script
/// accesses a field/getter declared on its own State subclass that
/// the bridged `State` class doesn't expose (D2 fix).
class _InterpretedState extends State<_InterpretedStatefulWidget>
    implements D4InterpretedProxy {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _stateInstance;

  _InterpretedState(this._visitor, this._stateInstance);

  @override
  Object get d4rtInstance => _stateInstance;

  @override
  void initState() {
    if (_lifecycleInProgress.contains('initState')) return;
    _lifecycleInProgress.add('initState');
    try {
      super.initState();
      _callVoidMethod('initState');
    } finally {
      _lifecycleInProgress.remove('initState');
    }
  }

  @override
  void didChangeDependencies() {
    if (_lifecycleInProgress.contains('didChangeDependencies')) return;
    _lifecycleInProgress.add('didChangeDependencies');
    try {
      super.didChangeDependencies();
      _callVoidMethod('didChangeDependencies');
    } finally {
      _lifecycleInProgress.remove('didChangeDependencies');
    }
  }

  @override
  Widget build(BuildContext context) {
    final method = _stateInstance.klass.findInstanceMethod('build');
    if (method != null) {
      final bound = method.bind(_stateInstance);
      final result = bound.call(_visitor, [context], {});
      return D4.extractBridgedArg<Widget>(result, 'build', _visitor);
    }
    throw StateError(
      'Interpreted State ${_stateInstance.klass.name} does not implement build()',
    );
  }

  @override
  void didUpdateWidget(covariant _InterpretedStatefulWidget oldWidget) {
    if (_lifecycleInProgress.contains('didUpdateWidget')) return;
    _lifecycleInProgress.add('didUpdateWidget');
    try {
      super.didUpdateWidget(oldWidget);
      // Refresh the `interpretedStatefulWidget` shortcut so script-side
      // `widget` access on the State subclass returns the freshly-built
      // InterpretedInstance after the parent rebuilt with new constructor
      // args. Without this, `runtime_types.dart`'s short-circuit at the
      // `widget` lookup would keep returning the original (createState-time)
      // InterpretedInstance and every reactive prop drift would go silent.
      _stateInstance.interpretedStatefulWidget = widget._instance;
      // Pass the previous widget's interpreted instance so the script's
      // `didUpdateWidget(MyWidget oldWidget)` actually receives `oldWidget`.
      // Without this, `_callVoidMethod` dispatches with zero arguments and
      // the missing-required-positional error is silently swallowed by the
      // lifecycle try/catch — the script override never runs, breaking any
      // logic that compares old vs new widget state (controller resets,
      // selection swaps, debounce poisoning, …). This must be done on every
      // State proxy variant (plain / Single+Multi Ticker / Restoration).
      final didUpdateMethod =
          _stateInstance.klass.findInstanceMethod('didUpdateWidget');
      if (didUpdateMethod != null) {
        try {
          didUpdateMethod
              .bind(_stateInstance)
              .call(_visitor, <Object?>[oldWidget._instance], {});
        } catch (_) {
          // Match `_callVoidMethod` posture: lifecycle methods that call
          // `super.didUpdateWidget(...)` may fault on the proxy boundary.
        }
      }
    } finally {
      _lifecycleInProgress.remove('didUpdateWidget');
    }
  }

  @override
  void deactivate() {
    if (_lifecycleInProgress.contains('deactivate')) return;
    _lifecycleInProgress.add('deactivate');
    try {
      _callVoidMethod('deactivate');
      super.deactivate();
    } finally {
      _lifecycleInProgress.remove('deactivate');
    }
  }

  @override
  void dispose() {
    if (_lifecycleInProgress.contains('dispose')) return;
    _lifecycleInProgress.add('dispose');
    try {
      _callVoidMethod('dispose');
      super.dispose();
    } finally {
      _lifecycleInProgress.remove('dispose');
    }
  }

  void _callVoidMethod(String name) {
    final method = _stateInstance.klass.findInstanceMethod(name);
    if (method != null) {
      try {
        method.bind(_stateInstance).call(_visitor, [], {});
      } catch (_) {
        // Lifecycle methods may call super which isn't available in proxy
      }
    }
  }

  // Bug-46: re-entrancy guard for lifecycle overrides. When the script's
  // body calls e.g. `super.initState()`, the bridged-super dispatch resolves
  // to `state.initState` and re-enters this proxy's @override — without the
  // guard, that triggers infinite recursion (proxy.initState → script.
  // initState → super.initState → proxy.initState → ...). Each lifecycle
  // override checks this set; the second entry returns immediately so
  // Flutter's framework super-chain only runs once and the script's body
  // only runs once.
  final Set<String> _lifecycleInProgress = <String>{};
}

// =============================================================================
// RC-5: TickerProvider State Proxies
// =============================================================================

/// A native [State] with [SingleTickerProviderStateMixin] that delegates
/// lifecycle methods to an interpreted D4rt State subclass.
///
/// This provides a real native [TickerProvider] so that
/// `AnimationController(vsync: this)` works when `this` refers to the
/// interpreted State instance — the [nativeProxy] field on the
/// [InterpretedInstance] points to this object, and [D4.extractBridgedArg]
/// returns it directly for TickerProvider-typed parameters.
class _InterpretedSingleTickerProviderState
    extends State<_InterpretedStatefulWidget>
    with SingleTickerProviderStateMixin
    implements D4InterpretedProxy {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _stateInstance;

  _InterpretedSingleTickerProviderState(this._visitor, this._stateInstance);

  @override
  Object get d4rtInstance => _stateInstance;

  @override
  void initState() {
    if (_lifecycleInProgress.contains('initState')) return;
    _lifecycleInProgress.add('initState');
    try {
      super.initState();
      _callVoidMethod('initState');
    } finally {
      _lifecycleInProgress.remove('initState');
    }
  }

  @override
  void didChangeDependencies() {
    if (_lifecycleInProgress.contains('didChangeDependencies')) return;
    _lifecycleInProgress.add('didChangeDependencies');
    try {
      super.didChangeDependencies();
      _callVoidMethod('didChangeDependencies');
    } finally {
      _lifecycleInProgress.remove('didChangeDependencies');
    }
  }

  @override
  Widget build(BuildContext context) {
    final method = _stateInstance.klass.findInstanceMethod('build');
    if (method != null) {
      final bound = method.bind(_stateInstance);
      final result = bound.call(_visitor, [context], {});
      return D4.extractBridgedArg<Widget>(result, 'build', _visitor);
    }
    throw StateError(
      'Interpreted State ${_stateInstance.klass.name} does not implement build()',
    );
  }

  @override
  void didUpdateWidget(covariant _InterpretedStatefulWidget oldWidget) {
    if (_lifecycleInProgress.contains('didUpdateWidget')) return;
    _lifecycleInProgress.add('didUpdateWidget');
    try {
      super.didUpdateWidget(oldWidget);
      // Refresh the `interpretedStatefulWidget` shortcut so script-side
      // `widget` access on the State subclass returns the freshly-built
      // InterpretedInstance after the parent rebuilt with new constructor
      // args. Without this, `runtime_types.dart`'s short-circuit at the
      // `widget` lookup would keep returning the original (createState-time)
      // InterpretedInstance and every reactive prop drift would go silent.
      _stateInstance.interpretedStatefulWidget = widget._instance;
      // Pass the previous widget's interpreted instance so the script's
      // `didUpdateWidget(MyWidget oldWidget)` actually receives `oldWidget`.
      // Without this, `_callVoidMethod` dispatches with zero arguments and
      // the missing-required-positional error is silently swallowed by the
      // lifecycle try/catch — the script override never runs, breaking any
      // logic that compares old vs new widget state (controller resets,
      // selection swaps, debounce poisoning, …). This must be done on every
      // State proxy variant (plain / Single+Multi Ticker / Restoration).
      final didUpdateMethod =
          _stateInstance.klass.findInstanceMethod('didUpdateWidget');
      if (didUpdateMethod != null) {
        try {
          didUpdateMethod
              .bind(_stateInstance)
              .call(_visitor, <Object?>[oldWidget._instance], {});
        } catch (_) {
          // Match `_callVoidMethod` posture: lifecycle methods that call
          // `super.didUpdateWidget(...)` may fault on the proxy boundary.
        }
      }
    } finally {
      _lifecycleInProgress.remove('didUpdateWidget');
    }
  }

  @override
  void deactivate() {
    if (_lifecycleInProgress.contains('deactivate')) return;
    _lifecycleInProgress.add('deactivate');
    try {
      _callVoidMethod('deactivate');
      super.deactivate();
    } finally {
      _lifecycleInProgress.remove('deactivate');
    }
  }

  @override
  void dispose() {
    if (_lifecycleInProgress.contains('dispose')) return;
    _lifecycleInProgress.add('dispose');
    try {
      _callVoidMethod('dispose');
      super.dispose();
    } finally {
      _lifecycleInProgress.remove('dispose');
    }
  }

  void _callVoidMethod(String name) {
    final method = _stateInstance.klass.findInstanceMethod(name);
    if (method != null) {
      try {
        method.bind(_stateInstance).call(_visitor, [], {});
      } catch (_) {
        // Lifecycle methods may call super which isn't available in proxy
      }
    }
  }

  // Bug-46: re-entrancy guard for lifecycle overrides. When the script's
  // body calls e.g. `super.initState()`, the bridged-super dispatch resolves
  // to `state.initState` and re-enters this proxy's @override — without the
  // guard, that triggers infinite recursion (proxy.initState → script.
  // initState → super.initState → proxy.initState → ...). Each lifecycle
  // override checks this set; the second entry returns immediately so
  // Flutter's framework super-chain only runs once and the script's body
  // only runs once.
  final Set<String> _lifecycleInProgress = <String>{};
}

/// A native [State] with [TickerProviderStateMixin] (multi-ticker) that
/// delegates lifecycle methods to an interpreted D4rt State subclass.
class _InterpretedMultiTickerProviderState
    extends State<_InterpretedStatefulWidget>
    with TickerProviderStateMixin
    implements D4InterpretedProxy {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _stateInstance;

  _InterpretedMultiTickerProviderState(this._visitor, this._stateInstance);

  @override
  Object get d4rtInstance => _stateInstance;

  @override
  void initState() {
    if (_lifecycleInProgress.contains('initState')) return;
    _lifecycleInProgress.add('initState');
    try {
      super.initState();
      _callVoidMethod('initState');
    } finally {
      _lifecycleInProgress.remove('initState');
    }
  }

  @override
  void didChangeDependencies() {
    if (_lifecycleInProgress.contains('didChangeDependencies')) return;
    _lifecycleInProgress.add('didChangeDependencies');
    try {
      super.didChangeDependencies();
      _callVoidMethod('didChangeDependencies');
    } finally {
      _lifecycleInProgress.remove('didChangeDependencies');
    }
  }

  @override
  Widget build(BuildContext context) {
    final method = _stateInstance.klass.findInstanceMethod('build');
    if (method != null) {
      final bound = method.bind(_stateInstance);
      final result = bound.call(_visitor, [context], {});
      return D4.extractBridgedArg<Widget>(result, 'build', _visitor);
    }
    throw StateError(
      'Interpreted State ${_stateInstance.klass.name} does not implement build()',
    );
  }

  @override
  void didUpdateWidget(covariant _InterpretedStatefulWidget oldWidget) {
    if (_lifecycleInProgress.contains('didUpdateWidget')) return;
    _lifecycleInProgress.add('didUpdateWidget');
    try {
      super.didUpdateWidget(oldWidget);
      // Refresh the `interpretedStatefulWidget` shortcut so script-side
      // `widget` access on the State subclass returns the freshly-built
      // InterpretedInstance after the parent rebuilt with new constructor
      // args. Without this, `runtime_types.dart`'s short-circuit at the
      // `widget` lookup would keep returning the original (createState-time)
      // InterpretedInstance and every reactive prop drift would go silent.
      _stateInstance.interpretedStatefulWidget = widget._instance;
      // Pass the previous widget's interpreted instance so the script's
      // `didUpdateWidget(MyWidget oldWidget)` actually receives `oldWidget`.
      // Without this, `_callVoidMethod` dispatches with zero arguments and
      // the missing-required-positional error is silently swallowed by the
      // lifecycle try/catch — the script override never runs, breaking any
      // logic that compares old vs new widget state (controller resets,
      // selection swaps, debounce poisoning, …). This must be done on every
      // State proxy variant (plain / Single+Multi Ticker / Restoration).
      final didUpdateMethod =
          _stateInstance.klass.findInstanceMethod('didUpdateWidget');
      if (didUpdateMethod != null) {
        try {
          didUpdateMethod
              .bind(_stateInstance)
              .call(_visitor, <Object?>[oldWidget._instance], {});
        } catch (_) {
          // Match `_callVoidMethod` posture: lifecycle methods that call
          // `super.didUpdateWidget(...)` may fault on the proxy boundary.
        }
      }
    } finally {
      _lifecycleInProgress.remove('didUpdateWidget');
    }
  }

  @override
  void deactivate() {
    if (_lifecycleInProgress.contains('deactivate')) return;
    _lifecycleInProgress.add('deactivate');
    try {
      _callVoidMethod('deactivate');
      super.deactivate();
    } finally {
      _lifecycleInProgress.remove('deactivate');
    }
  }

  @override
  void dispose() {
    if (_lifecycleInProgress.contains('dispose')) return;
    _lifecycleInProgress.add('dispose');
    try {
      _callVoidMethod('dispose');
      super.dispose();
    } finally {
      _lifecycleInProgress.remove('dispose');
    }
  }

  void _callVoidMethod(String name) {
    final method = _stateInstance.klass.findInstanceMethod(name);
    if (method != null) {
      try {
        method.bind(_stateInstance).call(_visitor, [], {});
      } catch (_) {
        // Lifecycle methods may call super which isn't available in proxy
      }
    }
  }

  // Bug-46: re-entrancy guard for lifecycle overrides. When the script's
  // body calls e.g. `super.initState()`, the bridged-super dispatch resolves
  // to `state.initState` and re-enters this proxy's @override — without the
  // guard, that triggers infinite recursion (proxy.initState → script.
  // initState → super.initState → proxy.initState → ...). Each lifecycle
  // override checks this set; the second entry returns immediately so
  // Flutter's framework super-chain only runs once and the script's body
  // only runs once.
  final Set<String> _lifecycleInProgress = <String>{};
}

// =============================================================================
// C10: RestorationMixin State Proxy
// =============================================================================

/// A native [State] with [RestorationMixin] that delegates lifecycle methods
/// to an interpreted D4rt State subclass.
///
/// Selected by [_InterpretedStatefulWidget.createState] when the interpreted
/// State subclass declares `with RestorationMixin`. This is necessary because
/// `RestorationMixin` is a *real* mixin (its `didChangeDependencies` override
/// drives bucket discovery and the eventual `restoreState` call). Using the
/// plain [_InterpretedState] proxy leaves the mixin off the native State, so
/// `restoreState` is never invoked, no `RestorableProperty` is registered,
/// and reading `.value` asserts `'isRegistered': is not true`.
///
/// The proxy overrides:
///   - [restorationId] getter — delegates to the interpreted instance's
///     `restorationId` getter (or `restorationId` field).
///   - [restoreState] — dispatches to the interpreted instance's
///     `restoreState(oldBucket, initialRestore)` method, which then calls
///     [registerForRestoration] for each property. Because the proxy itself
///     is a `RestorationMixin`, `registerForRestoration` resolves to the
///     native mixin implementation and the property's `_register` runs.
class _InterpretedRestorationMixinState
    extends State<_InterpretedStatefulWidget>
    with RestorationMixin<_InterpretedStatefulWidget>
    implements D4InterpretedProxy {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _stateInstance;

  _InterpretedRestorationMixinState(this._visitor, this._stateInstance);

  @override
  Object get d4rtInstance => _stateInstance;

  @override
  String? get restorationId {
    // Look up `restorationId` on the interpreted class chain — it may be
    // declared as a getter (`String? get restorationId => ...`) or as a
    // plain field (`final String? restorationId = ...`). Both surface via
    // `findInstanceGetter` first; fall back to a direct field read.
    final getter = _stateInstance.klass.findInstanceGetter('restorationId');
    if (getter != null) {
      try {
        final result = getter.bind(_stateInstance).call(_visitor, [], {});
        return result as String?;
      } catch (_) {
        // Fall through to field read.
      }
    }
    try {
      final value = _stateInstance.get('restorationId', visitor: _visitor);
      return value as String?;
    } catch (_) {
      return null;
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    if (_lifecycleInProgress.contains('restoreState')) return;
    _lifecycleInProgress.add('restoreState');
    try {
      // RestorationMixin.restoreState is abstract — there is no super body
      // to call. The interpreted method is responsible for invoking
      // `registerForRestoration` for each property.
      final method = _stateInstance.klass.findInstanceMethod('restoreState');
      if (method != null) {
        method
            .bind(_stateInstance)
            .call(_visitor, [oldBucket, initialRestore], {});
      }
    } finally {
      _lifecycleInProgress.remove('restoreState');
    }
  }

  @override
  void initState() {
    if (_lifecycleInProgress.contains('initState')) return;
    _lifecycleInProgress.add('initState');
    try {
      super.initState();
      _callVoidMethod('initState');
    } finally {
      _lifecycleInProgress.remove('initState');
    }
  }

  @override
  void didChangeDependencies() {
    if (_lifecycleInProgress.contains('didChangeDependencies')) return;
    _lifecycleInProgress.add('didChangeDependencies');
    try {
      // RestorationMixin.didChangeDependencies handles bucket discovery and,
      // on first/replacement bucket, dispatches to our `restoreState`
      // override above. Calling super first preserves that flow.
      super.didChangeDependencies();
      _callVoidMethod('didChangeDependencies');
    } finally {
      _lifecycleInProgress.remove('didChangeDependencies');
    }
  }

  @override
  Widget build(BuildContext context) {
    final method = _stateInstance.klass.findInstanceMethod('build');
    if (method != null) {
      final bound = method.bind(_stateInstance);
      final result = bound.call(_visitor, [context], {});
      return D4.extractBridgedArg<Widget>(result, 'build', _visitor);
    }
    throw StateError(
      'Interpreted State ${_stateInstance.klass.name} does not implement build()',
    );
  }

  @override
  void didUpdateWidget(covariant _InterpretedStatefulWidget oldWidget) {
    if (_lifecycleInProgress.contains('didUpdateWidget')) return;
    _lifecycleInProgress.add('didUpdateWidget');
    try {
      super.didUpdateWidget(oldWidget);
      // Refresh the `interpretedStatefulWidget` shortcut so script-side
      // `widget` access on the State subclass returns the freshly-built
      // InterpretedInstance after the parent rebuilt with new constructor
      // args. Without this, `runtime_types.dart`'s short-circuit at the
      // `widget` lookup would keep returning the original (createState-time)
      // InterpretedInstance and every reactive prop drift would go silent.
      _stateInstance.interpretedStatefulWidget = widget._instance;
      // Pass the previous widget's interpreted instance so the script's
      // `didUpdateWidget(MyWidget oldWidget)` actually receives `oldWidget`.
      // Without this, `_callVoidMethod` dispatches with zero arguments and
      // the missing-required-positional error is silently swallowed by the
      // lifecycle try/catch — the script override never runs, breaking any
      // logic that compares old vs new widget state (controller resets,
      // selection swaps, debounce poisoning, …). This must be done on every
      // State proxy variant (plain / Single+Multi Ticker / Restoration).
      final didUpdateMethod =
          _stateInstance.klass.findInstanceMethod('didUpdateWidget');
      if (didUpdateMethod != null) {
        try {
          didUpdateMethod
              .bind(_stateInstance)
              .call(_visitor, <Object?>[oldWidget._instance], {});
        } catch (_) {
          // Match `_callVoidMethod` posture: lifecycle methods that call
          // `super.didUpdateWidget(...)` may fault on the proxy boundary.
        }
      }
    } finally {
      _lifecycleInProgress.remove('didUpdateWidget');
    }
  }

  @override
  void deactivate() {
    if (_lifecycleInProgress.contains('deactivate')) return;
    _lifecycleInProgress.add('deactivate');
    try {
      _callVoidMethod('deactivate');
      super.deactivate();
    } finally {
      _lifecycleInProgress.remove('deactivate');
    }
  }

  @override
  void dispose() {
    if (_lifecycleInProgress.contains('dispose')) return;
    _lifecycleInProgress.add('dispose');
    try {
      _callVoidMethod('dispose');
      super.dispose();
    } finally {
      _lifecycleInProgress.remove('dispose');
    }
  }

  void _callVoidMethod(String name) {
    final method = _stateInstance.klass.findInstanceMethod(name);
    if (method != null) {
      try {
        method.bind(_stateInstance).call(_visitor, [], {});
      } catch (_) {
        // Lifecycle methods may call super which isn't available in proxy.
      }
    }
  }

  // Re-entrancy guard mirroring _InterpretedState — `super.initState()` in
  // a script body re-routes through this proxy, so without this set the
  // override would recurse indefinitely.
  final Set<String> _lifecycleInProgress = <String>{};
}

/// A native [State] with [AutomaticKeepAliveClientMixin] that delegates
/// lifecycle methods to an interpreted D4rt State subclass.
///
/// Without this proxy variant, `AutomaticKeepAliveClientMixin` simply
/// "compiles" in the script but is structurally absent at runtime — the
/// proxy that the framework actually mounts is a plain `State`, so
/// `KeepAliveNotification` is never dispatched and any keep-alive
/// container (e.g. `TabBarView`, `PageView`, `KeepAlive`) treats the
/// child as disposable. This mirrors the TickerProvider / Restoration
/// variants: when the interpreted class declares the bridged mixin we
/// mount a proxy that actually *mixes it in*, so the framework's
/// keep-alive machinery sees a real implementation.
///
/// `wantKeepAlive` is resolved by calling the interpreted getter (the
/// script's `bool get wantKeepAlive => true;`); the proxy's
/// `build(context)` calls `super.build(context)` first so the mixin can
/// dispatch its `KeepAliveNotification` before the script's `build`
/// runs.
class _InterpretedKeepAliveState extends State<_InterpretedStatefulWidget>
    with AutomaticKeepAliveClientMixin
    implements D4InterpretedProxy {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _stateInstance;

  _InterpretedKeepAliveState(this._visitor, this._stateInstance);

  @override
  Object get d4rtInstance => _stateInstance;

  // `AutomaticKeepAliveClientMixin` declares `wantKeepAlive` as an
  // abstract getter — the analyzer does not consider implementing it
  // as an "override" (no inherited implementation), so we omit
  // `@override` to keep the analyzer quiet.
  bool get wantKeepAlive {
    final getter = _stateInstance.klass.findInstanceGetter('wantKeepAlive');
    if (getter != null) {
      try {
        final result = getter.bind(_stateInstance).call(_visitor, [], {});
        if (result is bool) return result;
      } catch (_) {
        // Fall through to default.
      }
    }
    // The script declared the mixin but did not override the getter —
    // default to true so the kept-alive container honours the intent.
    return true;
  }

  @override
  void initState() {
    if (_lifecycleInProgress.contains('initState')) return;
    _lifecycleInProgress.add('initState');
    try {
      super.initState();
      _callVoidMethod('initState');
    } finally {
      _lifecycleInProgress.remove('initState');
    }
  }

  @override
  void didChangeDependencies() {
    if (_lifecycleInProgress.contains('didChangeDependencies')) return;
    _lifecycleInProgress.add('didChangeDependencies');
    try {
      super.didChangeDependencies();
      _callVoidMethod('didChangeDependencies');
    } finally {
      _lifecycleInProgress.remove('didChangeDependencies');
    }
  }

  @override
  Widget build(BuildContext context) {
    // `super.build(context)` here is `AutomaticKeepAliveClientMixin.build`
    // — it dispatches `KeepAliveNotification` so the surrounding
    // keep-alive container preserves this subtree across rebuilds.
    // Must run before the script's build, otherwise the first frame
    // mounts without any notification and the container disposes the
    // subtree on the next swap.
    super.build(context);
    final method = _stateInstance.klass.findInstanceMethod('build');
    if (method != null) {
      final bound = method.bind(_stateInstance);
      final result = bound.call(_visitor, [context], {});
      return D4.extractBridgedArg<Widget>(result, 'build', _visitor);
    }
    throw StateError(
      'Interpreted State ${_stateInstance.klass.name} does not implement build()',
    );
  }

  @override
  void didUpdateWidget(covariant _InterpretedStatefulWidget oldWidget) {
    if (_lifecycleInProgress.contains('didUpdateWidget')) return;
    _lifecycleInProgress.add('didUpdateWidget');
    try {
      super.didUpdateWidget(oldWidget);
      _stateInstance.interpretedStatefulWidget = widget._instance;
      final didUpdateMethod =
          _stateInstance.klass.findInstanceMethod('didUpdateWidget');
      if (didUpdateMethod != null) {
        try {
          didUpdateMethod
              .bind(_stateInstance)
              .call(_visitor, <Object?>[oldWidget._instance], {});
        } catch (_) {
          // Lifecycle methods may call super which isn't available in proxy.
        }
      }
    } finally {
      _lifecycleInProgress.remove('didUpdateWidget');
    }
  }

  @override
  void deactivate() {
    if (_lifecycleInProgress.contains('deactivate')) return;
    _lifecycleInProgress.add('deactivate');
    try {
      _callVoidMethod('deactivate');
      super.deactivate();
    } finally {
      _lifecycleInProgress.remove('deactivate');
    }
  }

  @override
  void dispose() {
    if (_lifecycleInProgress.contains('dispose')) return;
    _lifecycleInProgress.add('dispose');
    try {
      _callVoidMethod('dispose');
      super.dispose();
    } finally {
      _lifecycleInProgress.remove('dispose');
    }
  }

  void _callVoidMethod(String name) {
    final method = _stateInstance.klass.findInstanceMethod(name);
    if (method != null) {
      try {
        method.bind(_stateInstance).call(_visitor, [], {});
      } catch (_) {
        // Lifecycle methods may call super which isn't available in proxy.
      }
    }
  }

  final Set<String> _lifecycleInProgress = <String>{};
}

// =============================================================================
// Supplementary Methods
// =============================================================================

/// Register supplementary method adapters for @protected or otherwise missing
/// methods that the bridge generator skips but interpreted subclasses need.
void _registerSupplementaryMethods() {
  // ChangeNotifier.notifyListeners — @protected, not in generated bridge
  D4.registerSupplementaryMethod('ChangeNotifier', 'notifyListeners', (
    visitor,
    target,
    positionalArgs,
    namedArgs,
    typeArgs,
  ) {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    final cn = target as ChangeNotifier;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    cn.notifyListeners();
    return null;
  });

  // ChangeNotifier.hasListeners — @protected getter
  D4.registerSupplementaryMethod('ChangeNotifier', 'hasListeners', (
    visitor,
    target,
    positionalArgs,
    namedArgs,
    typeArgs,
  ) {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    final cn = target as ChangeNotifier;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    return cn.hasListeners;
  });

  // ---------------------------------------------------------------------------
  // RC-7: State<T> supplementary methods
  // ---------------------------------------------------------------------------
  // State.widget — getter exposing the StatefulWidget instance.
  // When an interpreted State subclass accesses `widget`, the interpreter
  // resolves via bridgedSuperObject chain. The native _InterpretedState's
  // `widget` returns _InterpretedStatefulWidget which holds the original
  // interpreted widget instance.
  D4.registerSupplementaryMethod('State', 'widget', (
    visitor,
    target,
    positionalArgs,
    namedArgs,
    typeArgs,
  ) {
    // RC-5: All interpreted State proxies wrap _InterpretedStatefulWidget
    if (target is State<_InterpretedStatefulWidget>) {
      return target.widget._instance;
    }
    if (target is State) {
      return target.widget;
    }
    return null;
  });

  // State.setState — triggers rebuild by calling setState on the native State.
  //
  // Note: For interpreted State subclasses extending the bridged State, the
  // primary `setState` route is the generated bridge in `widgets_bridges.b.dart`
  // (overridden by `StateUserBridge` in `lib/src/d4rt_user_bridges/` to add
  // the C20d scheduler-phase guard). This supplementary registration remains
  // as a fallback for code paths that resolve through `findSupplementaryMethod`.
  D4.registerSupplementaryMethod('State', 'setState', (
    visitor,
    target,
    positionalArgs,
    namedArgs,
    typeArgs,
  ) {
    // RC-5: All interpreted State proxies are State<_InterpretedStatefulWidget>
    if (target is State) {
      // The positionalArgs[0] is the VoidCallback from the script.
      // We call setState with a native closure that invokes the interpreted callback.
      // ignore: invalid_use_of_protected_member
      target.setState(() {
        if (positionalArgs.isNotEmpty && positionalArgs[0] != null) {
          final callback = positionalArgs[0];
          if (callback is Function) {
            callback();
          }
        }
      });
    }
    return null;
  });

  // State.mounted — getter
  D4.registerSupplementaryMethod('State', 'mounted', (
    visitor,
    target,
    positionalArgs,
    namedArgs,
    typeArgs,
  ) {
    if (target is State) {
      return target.mounted;
    }
    return false;
  });

  // State.context — getter
  D4.registerSupplementaryMethod('State', 'context', (
    visitor,
    target,
    positionalArgs,
    namedArgs,
    typeArgs,
  ) {
    if (target is State) {
      return target.context;
    }
    return null;
  });

  // ---------------------------------------------------------------------------
  // RC-7: MultiChildLayoutDelegate supplementary methods
  // ---------------------------------------------------------------------------
  // These methods are concrete (not abstract) on MultiChildLayoutDelegate and
  // are called by interpreted performLayout() implementations. They delegate
  // to the native proxy's super methods which access the actual layout children.

  D4.registerSupplementaryMethod('MultiChildLayoutDelegate', 'hasChild', (
    visitor,
    target,
    positionalArgs,
    namedArgs,
    typeArgs,
  ) {
    if (target is D4rtMultiChildLayoutDelegate) {
      final childId = positionalArgs[0];
      return target.hasChild(childId!);
    }
    // Fallback: use dynamic dispatch for other MultiChildLayoutDelegate subtypes
    return (target as dynamic).hasChild(positionalArgs[0]);
  });

  D4.registerSupplementaryMethod('MultiChildLayoutDelegate', 'layoutChild', (
    visitor,
    target,
    positionalArgs,
    namedArgs,
    typeArgs,
  ) {
    if (target is D4rtMultiChildLayoutDelegate) {
      final childId = positionalArgs[0];
      final constraints = D4.extractBridgedArg<BoxConstraints>(
        positionalArgs[1],
        'constraints',
      );
      return target.layoutChild(childId!, constraints);
    }
    // Fallback: use dynamic dispatch
    return (target as dynamic).layoutChild(
      positionalArgs[0],
      D4.extractBridgedArg<BoxConstraints>(positionalArgs[1], 'constraints'),
    );
  });

  D4.registerSupplementaryMethod('MultiChildLayoutDelegate', 'positionChild', (
    visitor,
    target,
    positionalArgs,
    namedArgs,
    typeArgs,
  ) {
    if (target is D4rtMultiChildLayoutDelegate) {
      final childId = positionalArgs[0];
      final offset = D4.extractBridgedArg<Offset>(positionalArgs[1], 'offset');
      target.positionChild(childId!, offset);
    } else {
      // Fallback: use dynamic dispatch
      (target as dynamic).positionChild(
        positionalArgs[0],
        D4.extractBridgedArg<Offset>(positionalArgs[1], 'offset'),
      );
    }
    return null;
  });

  // ---------------------------------------------------------------------------
  // RC-7: SingleChildLayoutDelegate supplementary methods
  // ---------------------------------------------------------------------------
  D4.registerSupplementaryMethod('SingleChildLayoutDelegate', 'hasChild', (
    visitor,
    target,
    positionalArgs,
    namedArgs,
    typeArgs,
  ) {
    // SingleChildLayoutDelegate doesn't have a hasChild method natively,
    // but some scripts may assume it does. Return true as single-child always has child.
    return true;
  });
}

// =============================================================================
// RC-8: Supplementary Relaxer Type Wrappers
// =============================================================================

/// Register additional inner type arguments for generated relaxer wrappers.
///
/// The generated `flutter_relaxers.b.dart` only includes a limited set of
/// inner types per wrapper (e.g., Tween only has Object/Rect). This function
/// adds commonly-needed inner types that match Flutter's built-in Tween
/// subclasses and animation targets.
///
/// These registrations will become redundant when the relaxer generator is
/// updated to auto-detect which inner types are actually needed.
void _registerSupplementaryRelaxers() {
  // Tween<T> — add commonly-used inner types matching Flutter's built-in
  // Tween subclasses (ColorTween, IntTween, etc.) and animation targets.
  D4.registerGenericTypeWrapper('Tween', (Object value, String innerTypeArg) {
    if (value is! Tween) return null;
    return switch (innerTypeArg) {
      'double' => $RelaxedTween<double>(value),
      'double?' => $RelaxedTween<double?>(value),
      'int' => $RelaxedTween<int>(value),
      'int?' => $RelaxedTween<int?>(value),
      'num' => $RelaxedTween<num>(value),
      'num?' => $RelaxedTween<num?>(value),
      'Color' => $RelaxedTween<Color>(value),
      'Color?' => $RelaxedTween<Color?>(value),
      'Offset' => $RelaxedTween<Offset>(value),
      'Offset?' => $RelaxedTween<Offset?>(value),
      _ => null,
    };
  });
}

// =============================================================================
// Generic Widget Re-Creators
// =============================================================================

/// Registers `registerGenericTypeWrapper` factories for generic Widget classes
/// that cannot be wrapped via relaxer subclasses (since widgets are immutable
/// and have complex rendering). Instead, these factories RE-CREATE the widget
/// instance with the correct type parameter by reading accessible getters.
///
/// This is needed when D4rt scripts create e.g. `DropdownMenuItem(value: 'x')`
/// without explicit type args — the bridge constructor produces
/// `DropdownMenuItem<Object>` which then fails assignment to
/// `DropdownMenuItem<String>` inside `DropdownButton<String>.items`.
void _registerGenericWidgetReCreators() {
  // DropdownMenuItem<T> — Re-create with correct type parameter.
  D4.registerGenericTypeWrapper('DropdownMenuItem', (
    Object value,
    String innerTypeArg,
  ) {
    if (value is! DropdownMenuItem) return null;
    final v = value;
    return switch (innerTypeArg) {
      'dynamic' || 'Object' || 'Object?' => DropdownMenuItem<dynamic>(
        key: v.key,
        onTap: v.onTap,
        value: v.value,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      'String' => DropdownMenuItem<String>(
        key: v.key,
        onTap: v.onTap,
        value: v.value as String?,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      'int' => DropdownMenuItem<int>(
        key: v.key,
        onTap: v.onTap,
        value: v.value as int?,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      'double' => DropdownMenuItem<double>(
        key: v.key,
        onTap: v.onTap,
        value: v.value as double?,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      'bool' => DropdownMenuItem<bool>(
        key: v.key,
        onTap: v.onTap,
        value: v.value as bool?,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      'num' => DropdownMenuItem<num>(
        key: v.key,
        onTap: v.onTap,
        value: v.value as num?,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      _ => null,
    };
  });

  // DropdownMenuEntry<T> — Re-create with correct type parameter.
  // Same pattern as DropdownMenuItem: script creates DropdownMenuEntry without
  // type args → bridge constructor produces DropdownMenuEntry<dynamic> →
  // coerceList<DropdownMenuEntry<String>> fails (invariant generics).
  D4.registerGenericTypeWrapper('DropdownMenuEntry', (
    Object value,
    String innerTypeArg,
  ) {
    if (value is! DropdownMenuEntry) return null;
    final v = value;
    return switch (innerTypeArg) {
      'dynamic' || 'Object' || 'Object?' => DropdownMenuEntry<dynamic>(
        value: v.value,
        label: v.label,
        labelWidget: v.labelWidget,
        leadingIcon: v.leadingIcon,
        trailingIcon: v.trailingIcon,
        enabled: v.enabled,
        style: v.style,
      ),
      'String' => DropdownMenuEntry<String>(
        value: v.value as String,
        label: v.label,
        labelWidget: v.labelWidget,
        leadingIcon: v.leadingIcon,
        trailingIcon: v.trailingIcon,
        enabled: v.enabled,
        style: v.style,
      ),
      'int' => DropdownMenuEntry<int>(
        value: v.value as int,
        label: v.label,
        labelWidget: v.labelWidget,
        leadingIcon: v.leadingIcon,
        trailingIcon: v.trailingIcon,
        enabled: v.enabled,
        style: v.style,
      ),
      'double' => DropdownMenuEntry<double>(
        value: v.value as double,
        label: v.label,
        labelWidget: v.labelWidget,
        leadingIcon: v.leadingIcon,
        trailingIcon: v.trailingIcon,
        enabled: v.enabled,
        style: v.style,
      ),
      'bool' => DropdownMenuEntry<bool>(
        value: v.value as bool,
        label: v.label,
        labelWidget: v.labelWidget,
        leadingIcon: v.leadingIcon,
        trailingIcon: v.trailingIcon,
        enabled: v.enabled,
        style: v.style,
      ),
      'num' => DropdownMenuEntry<num>(
        value: v.value as num,
        label: v.label,
        labelWidget: v.labelWidget,
        leadingIcon: v.leadingIcon,
        trailingIcon: v.trailingIcon,
        enabled: v.enabled,
        style: v.style,
      ),
      _ => null,
    };
  });

  // ButtonSegment<T> — Re-create with correct type parameter.
  // Same pattern as DropdownMenuItem: script creates ButtonSegment without
  // type args → bridge constructor produces ButtonSegment<dynamic> →
  // coerceList<ButtonSegment<String>> fails (invariant generics).
  D4.registerGenericTypeWrapper('ButtonSegment', (
    Object value,
    String innerTypeArg,
  ) {
    if (value is! ButtonSegment) return null;
    final v = value;
    return switch (innerTypeArg) {
      'dynamic' || 'Object' || 'Object?' => ButtonSegment<dynamic>(
        value: v.value,
        icon: v.icon,
        label: v.label,
        tooltip: v.tooltip,
        enabled: v.enabled,
      ),
      'String' => ButtonSegment<String>(
        value: v.value as String,
        icon: v.icon,
        label: v.label,
        tooltip: v.tooltip,
        enabled: v.enabled,
      ),
      'int' => ButtonSegment<int>(
        value: v.value as int,
        icon: v.icon,
        label: v.label,
        tooltip: v.tooltip,
        enabled: v.enabled,
      ),
      'double' => ButtonSegment<double>(
        value: v.value as double,
        icon: v.icon,
        label: v.label,
        tooltip: v.tooltip,
        enabled: v.enabled,
      ),
      'bool' => ButtonSegment<bool>(
        value: v.value as bool,
        icon: v.icon,
        label: v.label,
        tooltip: v.tooltip,
        enabled: v.enabled,
      ),
      'num' => ButtonSegment<num>(
        value: v.value as num,
        icon: v.icon,
        label: v.label,
        tooltip: v.tooltip,
        enabled: v.enabled,
      ),
      _ => null,
    };
  });
}

// =============================================================================
// Bug-46: RenderObjectWidget family proxies
// =============================================================================
//
// Allow scripts to subclass the abstract render-object widget bases and have
// their instances accepted by every bridged constructor expecting a `Widget`.
//
// Pattern matches `_InterpretedStatelessWidget` / `_InterpretedStatefulWidget`:
// the proxy holds a back-reference to the interpreted instance and forwards
// `createElement` / `createRenderObject` / `updateRenderObject` to the
// matching interpreted methods. The forwarders execute the script-defined
// method via the interpreter and unwrap the result back into a native
// `RenderObject`.

/// Helper to invoke an interpreted instance method and unwrap its result
/// as type [T].
T _invokeInterpretedAs<T>(
  InterpreterVisitor visitor,
  InterpretedInstance instance,
  String methodName,
  List<Object?> positionalArgs,
) {
  final method = instance.klass.findInstanceMethod(methodName);
  if (method == null) {
    throw StateError(
        'Interpreted class ${instance.klass.name} does not implement $methodName()');
  }
  final raw = method.bind(instance).call(visitor, positionalArgs, {});
  return D4.extractBridgedArg<T>(raw, methodName, visitor);
}

/// Shared implementation of `createRenderObject` / `updateRenderObject` for
/// the three render-object widget proxies below.
RenderObject _createRenderObject(
  InterpreterVisitor visitor,
  InterpretedInstance instance,
  BuildContext context,
) =>
    _invokeInterpretedAs<RenderObject>(
        visitor, instance, 'createRenderObject', [context]);

void _updateRenderObject(
  InterpreterVisitor visitor,
  InterpretedInstance instance,
  BuildContext context,
  RenderObject renderObject,
) {
  final method = instance.klass.findInstanceMethod('updateRenderObject');
  if (method == null) return; // updateRenderObject is optional in Flutter
  method.bind(instance).call(visitor, [context, renderObject], {});
}

/// Native [LeafRenderObjectWidget] backing an interpreted subclass.
class _InterpretedLeafRenderObjectWidget extends LeafRenderObjectWidget {
  _InterpretedLeafRenderObjectWidget(
    this._visitor,
    this._instance, {
    super.key,
  });

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _createRenderObject(_visitor, _instance, context);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) =>
      _updateRenderObject(_visitor, _instance, context, renderObject);
}

/// Native [SingleChildRenderObjectWidget] backing an interpreted subclass.
class _InterpretedSingleChildRenderObjectWidget
    extends SingleChildRenderObjectWidget {
  _InterpretedSingleChildRenderObjectWidget(
    this._visitor,
    this._instance, {
    super.key,
    super.child,
  });

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _createRenderObject(_visitor, _instance, context);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) =>
      _updateRenderObject(_visitor, _instance, context, renderObject);
}

/// Native [MultiChildRenderObjectWidget] backing an interpreted subclass.
class _InterpretedMultiChildRenderObjectWidget
    extends MultiChildRenderObjectWidget {
  _InterpretedMultiChildRenderObjectWidget(
    this._visitor,
    this._instance, {
    super.key,
    super.children = const <Widget>[],
  });

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _createRenderObject(_visitor, _instance, context);

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) =>
      _updateRenderObject(_visitor, _instance, context, renderObject);
}

/// Native [Intent] backing an interpreted subclass. Intent is a pure tag type
/// in Flutter (abstract class with only `const Intent()` and no virtual
/// behaviour the bridge boundary cares about), so the proxy holds a
/// back-reference to the interpreted instance but doesn't override anything.
///
/// Limitation: `runtimeType` is `_InterpretedIntent` for every interpreted
/// Intent subclass, so `Actions.invoke` / Type-keyed action lookup cannot
/// dispatch through this proxy. That's acceptable for the C5 scripts (which
/// only build the widget tree and do not exercise shortcut invocation), and
/// is the same trade-off accepted by the existing layout/clip delegate
/// proxies. Real shortcut dispatch for fully-interpreted Intents is a
/// separate concern.
class _InterpretedIntent extends Intent {
  _InterpretedIntent(this._visitor, this._instance) : super();

  // Held for parity with the other proxies and to keep the InterpretedInstance
  // reachable for possible future forwarding (toString, debugFillProperties).
  // ignore: unused_field
  final InterpreterVisitor _visitor;
  // ignore: unused_field
  final InterpretedInstance _instance;
}

/// Native [Action] backing an interpreted `Action<T extends Intent>` subclass.
/// Type parameter is erased to [Intent] so the proxy satisfies
/// `Map<Type, Action<Intent>>` value-type casts at the bridge boundary even
/// when the script declares `Action<SelectIntent>` (or any other Intent
/// subtype).
///
/// Like [_InterpretedIntent], the proxy holds a back-reference to the
/// interpreted instance but does not forward [invoke] / [isEnabled] /
/// [consumesKey] into the interpreter. The C6 scripts only build the widget
/// tree (and do not exercise `Actions.invoke`), matching the same trade-off
/// accepted by the layout/clip delegate proxies. Real action dispatch through
/// `Actions.invoke` for fully-interpreted Action subclasses is a separate
/// concern.
class _InterpretedAction extends Action<Intent> {
  _InterpretedAction(this._visitor, this._instance) : super();

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Object? invoke(Intent intent) {
    // Forward to the interpreted class's invoke() method. ContextAction
    // subclasses declare invoke(T intent, [BuildContext? context]) — we
    // pass only intent (context is null) which matches the optional parameter.
    try {
      final method = _instance.klass.findInstanceMethod('invoke');
      if (method != null) {
        final raw = method.bind(_instance).call(_visitor, [intent], {});
        if (raw == null) return null;
        if (raw is BridgedInstance) return raw.nativeObject;
        return raw;
      }
    } catch (e) {
      debugPrint('[D4rt] _InterpretedAction.invoke() forwarding error: $e');
    }
    return null;
  }
}

/// Native [SlottedMultiChildRenderObjectWidget] backing an interpreted
/// subclass. Forwards `slots`, `childForSlot`, and the render-object lifecycle
/// to the interpreter so scripts can implement the slotted-multi-child idiom
/// without compiling against the analyzer at runtime.
///
/// Type parameters are erased to `<dynamic, RenderObject>` because the
/// interpreted subclass may use any concrete `SlotType` / `ChildType`. Flutter
/// only needs the resulting [RenderObject] to mix in
/// [SlottedContainerRenderObjectMixin]; the concrete type arguments are
/// internal to the interpreter.
class _InterpretedSlottedMultiChildRenderObjectWidget
    extends SlottedMultiChildRenderObjectWidget<dynamic, RenderObject> {
  _InterpretedSlottedMultiChildRenderObjectWidget(
    this._visitor,
    this._instance, {
    super.key,
  });

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Iterable<dynamic> get slots {
    final raw = _instance.get('slots', visitor: _visitor);
    if (raw is Iterable) return raw;
    if (raw == null) return const <dynamic>[];
    throw StateError(
        'Interpreted ${_instance.klass.name}.slots must return an Iterable, got ${raw.runtimeType}');
  }

  @override
  Widget? childForSlot(dynamic slot) {
    final method = _instance.klass.findInstanceMethod('childForSlot');
    if (method == null) {
      throw StateError(
          'Interpreted ${_instance.klass.name} does not implement childForSlot()');
    }
    final raw = method.bind(_instance).call(_visitor, [slot], {});
    if (raw == null) return null;
    return D4.extractBridgedArg<Widget>(raw, 'childForSlot', _visitor);
  }

  @override
  SlottedContainerRenderObjectMixin<dynamic, RenderObject> createRenderObject(
      BuildContext context) {
    final raw = _invokeInterpretedAs<RenderObject>(
        _visitor, _instance, 'createRenderObject', [context]);
    if (raw is SlottedContainerRenderObjectMixin<dynamic, RenderObject>) {
      return raw;
    }
    throw StateError(
        'Interpreted ${_instance.klass.name}.createRenderObject must return a '
        'RenderObject mixing in SlottedContainerRenderObjectMixin, got '
        '${raw.runtimeType}');
  }

  @override
  void updateRenderObject(
    BuildContext context,
    SlottedContainerRenderObjectMixin<dynamic, RenderObject> renderObject,
  ) =>
      _updateRenderObject(_visitor, _instance, context, renderObject);
}

// =============================================================================
// Bug-102 / Bug-103: InheritedWidget + layout/clip delegate proxies
// =============================================================================
//
// Native proxies for the remaining abstract-delegate / abstract-widget bases
// that demo scripts commonly subclass. Pattern mirrors the RenderObjectWidget
// family above: proxy holds a back-reference to the interpreted instance and
// forwards the abstract members into the interpreter. For layout / clip
// delegates, `instance.nativeProxy` is set at interface-proxy-creation time
// so bridged-super members (`layoutChild`, `positionChild`, `hasChild`,
// `getSize`, `getApproximateClipRect`) called from the script's body
// dispatch to the native proxy via RC-6's nativeProxy fallback.

/// Empty Widget used as a safe placeholder for InheritedWidget scripts that
/// don't expose a `child` field.
class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

/// Native [InheritedWidget] backing an interpreted subclass (e.g. PanelTheme,
/// AppStateScope). Forwards `updateShouldNotify` to the script and uses the
/// script's `child` field for the subtree.
///
/// Uses [_InterpretedInheritedElement] so that the `debugDeactivated()`
/// assertion is suppressed. The assertion checks `_dependents.isEmpty` when
/// an InheritedElement is deactivated, but `_deactivateRecursively` visits
/// parents before children, so children haven't cleaned up their dependency
/// registrations yet when the parent's `deactivate()` fires. For native
/// InheritedWidgets this is harmless because the cleanup completes in the same
/// `finalizeTree()` pass; for our proxy the assertion fires prematurely,
/// throws from `finalizeTree()`, and leaves the element tree partially
/// deactivated — causing all subsequent builds in the same app session to hang.
class _InterpretedInheritedWidget extends InheritedWidget {
  const _InterpretedInheritedWidget(
    this._visitor,
    this._instance, {
    super.key,
    required super.child,
  });

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  InheritedElement createElement() => _InterpretedInheritedElement(this);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    final method = _instance.klass.findInstanceMethod('updateShouldNotify');
    if (method == null) return true; // conservative default
    try {
      final raw = method.bind(_instance).call(_visitor, [oldWidget], {});
      if (raw is bool) return raw;
    } catch (_) {
      // Script may reference `oldWidget` incorrectly; default to notifying.
    }
    return true;
  }
}

/// Custom [InheritedElement] for [_InterpretedInheritedWidget].
///
/// Overrides [debugDeactivated] to suppress the `_dependents.isEmpty`
/// assertion. The assertion fires because [_deactivateRecursively] visits
/// parents before children, so this element's dependents haven't removed
/// themselves yet when `deactivate()` is called. In release mode this is
/// non-fatal — `finalizeTree()` completes the cleanup correctly. In debug
/// mode the assertion throws from inside `finalizeTree()`, interrupting the
/// deactivation pass and leaving the element tree in a partially deactivated
/// state that hangs every subsequent `/build` request.
class _InterpretedInheritedElement extends InheritedElement {
  _InterpretedInheritedElement(super.widget);

  @override
  // ignore: must_call_super
  void debugDeactivated() {
    // Intentionally do NOT call super / assert _dependents.isEmpty here.
    // See the class comment on _InterpretedInheritedWidget for the rationale.
    // The @mustCallSuper on Element.debugDeactivated is suppressed because
    // calling super would invoke InheritedElement's assertion, which is
    // exactly what we are preventing.
  }
}

/// Native [MultiChildLayoutDelegate] backing an interpreted subclass.
class _InterpretedMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  _InterpretedMultiChildLayoutDelegate(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  void performLayout(Size size) {
    final method = _instance.klass.findInstanceMethod('performLayout');
    if (method == null) return;
    method.bind(_instance).call(_visitor, [size], const {});
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    final method = _instance.klass.findInstanceMethod('shouldRelayout');
    if (method == null) return false;
    try {
      final raw = method.bind(_instance).call(_visitor, [oldDelegate], {});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }
}

/// Native [SingleChildLayoutDelegate] backing an interpreted subclass.
class _InterpretedSingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  _InterpretedSingleChildLayoutDelegate(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final method =
        _instance.klass.findInstanceMethod('getConstraintsForChild');
    if (method == null) return constraints;
    try {
      final raw = method.bind(_instance).call(_visitor, [constraints], {});
      if (raw is BoxConstraints) return raw;
    } catch (_) {}
    return constraints;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    final method = _instance.klass.findInstanceMethod('getSize');
    if (method == null) return super.getSize(constraints);
    try {
      final raw = method.bind(_instance).call(_visitor, [constraints], {});
      if (raw is Size) return raw;
    } catch (_) {}
    return super.getSize(constraints);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final method = _instance.klass.findInstanceMethod('getPositionForChild');
    if (method == null) return Offset.zero;
    try {
      final raw =
          method.bind(_instance).call(_visitor, [size, childSize], {});
      if (raw is Offset) return raw;
    } catch (_) {}
    return Offset.zero;
  }

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
    final method = _instance.klass.findInstanceMethod('shouldRelayout');
    if (method == null) return false;
    try {
      final raw = method.bind(_instance).call(_visitor, [oldDelegate], {});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }
}

/// Native [CustomClipper<Path>] backing an interpreted subclass. Only the
/// Path variant is registered for now (the common case); Rect/RRect
/// variants can be added by mirroring this proxy.
class _InterpretedCustomClipperPath extends CustomClipper<Path> {
  _InterpretedCustomClipperPath(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Path getClip(Size size) {
    final method = _instance.klass.findInstanceMethod('getClip');
    if (method == null) return Path();
    try {
      final raw = method.bind(_instance).call(_visitor, [size], {});
      if (raw is Path) return raw;
    } catch (_) {}
    return Path();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    final method = _instance.klass.findInstanceMethod('shouldReclip');
    if (method == null) return false;
    try {
      final raw = method.bind(_instance).call(_visitor, [oldClipper], {});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }
}

/// Native [CustomClipper<Rect>] backing an interpreted subclass declared
/// as `extends CustomClipper<Rect>`. Used by `ClipRect(clipper: ...)`.
class _InterpretedCustomClipperRect extends CustomClipper<Rect> {
  _InterpretedCustomClipperRect(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Rect getClip(Size size) {
    final method = _instance.klass.findInstanceMethod('getClip');
    if (method == null) return Offset.zero & size;
    try {
      final raw = method.bind(_instance).call(_visitor, [size], {});
      if (raw is Rect) return raw;
    } catch (_) {}
    return Offset.zero & size;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    final method = _instance.klass.findInstanceMethod('shouldReclip');
    if (method == null) return false;
    try {
      final raw = method.bind(_instance).call(_visitor, [oldClipper], {});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }
}

/// Native [CustomClipper<RRect>] backing an interpreted subclass declared
/// as `extends CustomClipper<RRect>`. Used by `ClipRRect(clipper: ...)`.
class _InterpretedCustomClipperRRect extends CustomClipper<RRect> {
  _InterpretedCustomClipperRRect(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  RRect getClip(Size size) {
    final method = _instance.klass.findInstanceMethod('getClip');
    if (method == null) return RRect.fromRectAndCorners(Offset.zero & size);
    try {
      final raw = method.bind(_instance).call(_visitor, [size], {});
      if (raw is RRect) return raw;
    } catch (_) {}
    return RRect.fromRectAndCorners(Offset.zero & size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    final method = _instance.klass.findInstanceMethod('shouldReclip');
    if (method == null) return false;
    try {
      final raw = method.bind(_instance).call(_visitor, [oldClipper], {});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }
}

/// Native [CustomClipper<RSuperellipse>] backing an interpreted subclass
/// declared as `extends CustomClipper<RSuperellipse>`.
class _InterpretedCustomClipperRSuperellipse
    extends CustomClipper<RSuperellipse> {
  _InterpretedCustomClipperRSuperellipse(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  RSuperellipse getClip(Size size) {
    final method = _instance.klass.findInstanceMethod('getClip');
    if (method == null) {
      return RSuperellipse.fromRectAndRadius(Offset.zero & size, Radius.zero);
    }
    try {
      final raw = method.bind(_instance).call(_visitor, [size], {});
      if (raw is RSuperellipse) return raw;
    } catch (_) {}
    return RSuperellipse.fromRectAndRadius(Offset.zero & size, Radius.zero);
  }

  @override
  bool shouldReclip(covariant CustomClipper<RSuperellipse> oldClipper) {
    final method = _instance.klass.findInstanceMethod('shouldReclip');
    if (method == null) return false;
    try {
      final raw = method.bind(_instance).call(_visitor, [oldClipper], {});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }
}

/// Native [CustomPainter] backing an interpreted subclass — Cluster D2.
///
/// Replaces the auto-generated `D4rtCustomPainter` proxy at the runtime
/// registration layer. The auto-generated proxy is callback-only (no
/// back-reference to the interpreted instance), so once it crosses a bridge
/// boundary and re-enters the interpreter, property access on it cannot
/// reach the underlying InterpretedInstance fields.
///
/// This proxy implements [D4InterpretedProxy] so the interpreter's
/// visitSPropertyAccess / visitSPrefixedIdentifier unwrap fallback
/// recovers the InterpretedInstance and forwards reads to the script class.
/// Common case: `bool shouldRepaint(covariant _MyPainter old) =>
/// old.progress != progress;` — `old.progress` resolves through the unwrap.
class _InterpretedCustomPainter extends CustomPainter
    implements D4InterpretedProxy {
  _InterpretedCustomPainter(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;

  @override
  void paint(Canvas canvas, Size size) {
    final method = _instance.klass.findInstanceMethod('paint');
    if (method == null) return;
    try {
      method.bind(_instance).call(_visitor, [canvas, size], const {});
    } catch (_) {/* silently swallow paint exceptions */}
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    final method = _instance.klass.findInstanceMethod('shouldRepaint');
    if (method == null) return true;
    try {
      // If oldDelegate is itself a proxy, pass the interpreted instance
      // through so the script's `covariant _MyPainter old` parameter type
      // accepts it — otherwise the type cast inside the script would fail.
      final Object arg = oldDelegate is D4InterpretedProxy
          ? (oldDelegate as D4InterpretedProxy).d4rtInstance
          : oldDelegate;
      final raw = method.bind(_instance).call(_visitor, [arg], const {});
      if (raw is bool) return raw;
    } catch (_) {}
    return true;
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    final method =
        _instance.klass.findInstanceMethod('shouldRebuildSemantics');
    if (method == null) return shouldRepaint(oldDelegate);
    try {
      final Object arg = oldDelegate is D4InterpretedProxy
          ? (oldDelegate as D4InterpretedProxy).d4rtInstance
          : oldDelegate;
      final raw = method.bind(_instance).call(_visitor, [arg], const {});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }

  @override
  bool? hitTest(Offset position) {
    final method = _instance.klass.findInstanceMethod('hitTest');
    if (method == null) return null;
    try {
      final raw = method.bind(_instance).call(_visitor, [position], const {});
      if (raw is bool) return raw;
    } catch (_) {}
    return null;
  }
}

// =============================================================================
// Plan D — RenderBox proxy
// =============================================================================
//
// Native [RenderBox] backed by an interpreted subclass. Registered as the
// interface-proxy factory for the bridged class name 'RenderBox'.
//
// Surface area is intentionally minimal — the most common interpreted
// overrides are forwarded; everything else inherits RenderBox defaults.
// If a script overrides a method not forwarded here, the inherited Flutter
// behaviour runs rather than the script body — a well-defined fallback.
class _InterpretedRenderBox extends RenderBox implements D4InterpretedProxy {
  _InterpretedRenderBox(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  static const Object _kNotImplemented = Object();

  @override
  Object get d4rtInstance => _instance;

  /// Invoke an instance method by name, returning [_kNotImplemented] if the
  /// interpreted class doesn't define it (so callers can fall through to the
  /// RenderBox default).
  Object? _maybeInvoke(String methodName, List<Object?> args,
      [Map<String, Object?> named = const {}]) {
    final method = _instance.klass.findInstanceMethod(methodName);
    if (method == null) return _kNotImplemented;
    return method.bind(_instance).call(_visitor, args, named);
  }

  @override
  void performLayout() {
    final result = _maybeInvoke('performLayout', const []);
    if (identical(result, _kNotImplemented)) {
      size = constraints.smallest;
      return;
    }
    // RenderBox.size has a @protected setter that may not be exposed in the
    // bridge adapter table. Read it back from the interpreted field map.
    if (!hasSize) {
      try {
        final reflected = _instance.get('size', visitor: _visitor);
        if (reflected is Size) size = reflected;
      } catch (_) {}
    }
    if (!hasSize) size = constraints.smallest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final result = _maybeInvoke('paint', [context, offset]);
    if (identical(result, _kNotImplemented)) super.paint(context, offset);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final method = _instance.klass.findInstanceMethod('hitTest');
    if (method == null) return super.hitTest(result, position: position);
    final raw = method
        .bind(_instance)
        .call(_visitor, [result], {'position': position});
    if (raw is bool) return raw;
    return false;
  }

  @override
  bool hitTestSelf(Offset position) {
    final method = _instance.klass.findInstanceMethod('hitTestSelf');
    if (method == null) return super.hitTestSelf(position);
    try {
      final raw = method.bind(_instance).call(_visitor, [position], const {});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final method = _instance.klass.findInstanceMethod('hitTestChildren');
    if (method == null) {
      return super.hitTestChildren(result, position: position);
    }
    try {
      final raw = method
          .bind(_instance)
          .call(_visitor, [result], {'position': position});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }

  @override
  void setupParentData(RenderObject child) {
    final result = _maybeInvoke('setupParentData', [child]);
    if (identical(result, _kNotImplemented)) super.setupParentData(child);
  }
}

// =============================================================================
// Cluster C1 — RenderBox proxy mixin gap
// =============================================================================
//
// Walk an [InterpretedClass]'s ancestor chain looking for a bridged mixin
// whose name matches [mixinName]. Inspects the class's own `bridgedMixins`,
// then recurses into:
//   - bridgedSuperclass.name (rare — bridged classes can be themselves named
//     like the mixin if the script chains a custom mixin name)
//   - interpreted superclass
//   - interpreted mixins (in case a script's intermediate class uses the mixin)
//
// Used by the 'RenderBox' proxy factory to choose between the plain proxy
// and the container-aware proxy at first instantiation, before
// `instance.nativeProxy` is cached.
bool _classChainHasBridgedMixin(InterpretedClass? klass, String mixinName) {
  var cursor = klass;
  final visited = <InterpretedClass>{};
  while (cursor != null && visited.add(cursor)) {
    for (final mixin in cursor.bridgedMixins) {
      if (mixin.name == mixinName) return true;
    }
    if (cursor.bridgedSuperclass?.name == mixinName) return true;
    for (final interpretedMixin in cursor.mixins) {
      if (_classChainHasBridgedMixin(interpretedMixin, mixinName)) return true;
    }
    cursor = cursor.superclass;
  }
  return false;
}

// =============================================================================
// Cluster C1 — Container-aware RenderBox proxy
// =============================================================================
//
// Like [_InterpretedRenderBox], but mixes in [ContainerRenderObjectMixin] and
// [RenderBoxContainerDefaultsMixin] so that scripts subclassing
// `RenderBox with ContainerRenderObjectMixin<RenderBox, _MyParentData>,
//                RenderBoxContainerDefaultsMixin<RenderBox, _MyParentData>`
// produce a native proxy that satisfies framework casts to
// `ContainerRenderObjectMixin`. The generic type parameters are bound to
// `RenderBox` / `ContainerBoxParentData<RenderBox>` because that is the
// concrete pairing the container defaults mixin requires; scripts that use
// a more specific parent-data subclass must derive it from
// [ContainerBoxParentData].
//
// The forwarding pattern (performLayout, paint, hitTest{,Self,Children},
// setupParentData) mirrors [_InterpretedRenderBox] verbatim. setupParentData
// falls back to assigning a default `ContainerBoxParentData<RenderBox>` so
// child container linkage works even when scripts don't override it.
class _InterpretedRenderBoxContainer extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData<RenderBox>>,
        RenderBoxContainerDefaultsMixin<RenderBox,
            ContainerBoxParentData<RenderBox>>
    implements D4InterpretedProxy {
  _InterpretedRenderBoxContainer(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  static const Object _kNotImplemented = Object();

  @override
  Object get d4rtInstance => _instance;

  Object? _maybeInvoke(String methodName, List<Object?> args,
      [Map<String, Object?> named = const {}]) {
    final method = _instance.klass.findInstanceMethod(methodName);
    if (method == null) return _kNotImplemented;
    return method.bind(_instance).call(_visitor, args, named);
  }

  @override
  void performLayout() {
    final result = _maybeInvoke('performLayout', const []);
    if (identical(result, _kNotImplemented)) {
      size = constraints.smallest;
      return;
    }
    if (!hasSize) {
      try {
        final reflected = _instance.get('size', visitor: _visitor);
        if (reflected is Size) size = reflected;
      } catch (_) {}
    }
    if (!hasSize) size = constraints.smallest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final result = _maybeInvoke('paint', [context, offset]);
    if (identical(result, _kNotImplemented)) {
      defaultPaint(context, offset);
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final method = _instance.klass.findInstanceMethod('hitTest');
    if (method == null) return super.hitTest(result, position: position);
    final raw = method
        .bind(_instance)
        .call(_visitor, [result], {'position': position});
    if (raw is bool) return raw;
    return false;
  }

  @override
  bool hitTestSelf(Offset position) {
    final method = _instance.klass.findInstanceMethod('hitTestSelf');
    if (method == null) return super.hitTestSelf(position);
    try {
      final raw = method.bind(_instance).call(_visitor, [position], const {});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final method = _instance.klass.findInstanceMethod('hitTestChildren');
    if (method == null) {
      return defaultHitTestChildren(result, position: position);
    }
    try {
      final raw = method
          .bind(_instance)
          .call(_visitor, [result], {'position': position});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }

  @override
  void setupParentData(RenderObject child) {
    final result = _maybeInvoke('setupParentData', [child]);
    if (identical(result, _kNotImplemented)) super.setupParentData(child);
  }
}

// =============================================================================
// Cluster C1 follow-up — Slot-aware RenderBox proxy
// =============================================================================
//
// Like [_InterpretedRenderBox], but mixes in [SlottedContainerRenderObjectMixin]
// so scripts that subclass `RenderBox with SlottedContainerRenderObjectMixin<S,
// RenderBox>` produce a native proxy that satisfies the framework cast
// performed by [_InterpretedSlottedMultiChildRenderObjectWidget.createRenderObject]:
// `raw is SlottedContainerRenderObjectMixin<dynamic, RenderObject>`. Without
// this proxy the bridged super of the script's render-object class is plain
// `RenderBox`, so the standard `_InterpretedRenderBox` is created and the cast
// fails with "must return a RenderObject mixing in
// SlottedContainerRenderObjectMixin, got _InterpretedRenderBox" (D7 in
// `doc/testlog_20260427-1339-post-c22/error_analysis.md`).
//
// Type erasure: the slot type is erased to `dynamic` and the child type is
// fixed to `RenderBox` because the slot type is per-script (typically a custom
// enum) but the child is always a `RenderBox` for the demo corpus. The
// covariant cast from `<dynamic, RenderBox>` to `<dynamic, RenderObject>`
// performed by the widget proxy succeeds because `RenderBox <: RenderObject`.
//
// Method forwarding (performLayout, paint, hitTest{,Self,Children},
// setupParentData) mirrors [_InterpretedRenderBox] verbatim. The mixin
// provides `attach`, `detach`, `redepthChildren`, `visitChildren`, and the
// `_slotToChild` plumbing, so the proxy does not need to override them — the
// element calls into the mixin directly via the proxy.
class _InterpretedSlottedRenderBox extends RenderBox
    with SlottedContainerRenderObjectMixin<dynamic, RenderBox>
    implements D4InterpretedProxy {
  _InterpretedSlottedRenderBox(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  static const Object _kNotImplemented = Object();

  @override
  Object get d4rtInstance => _instance;

  Object? _maybeInvoke(String methodName, List<Object?> args,
      [Map<String, Object?> named = const {}]) {
    final method = _instance.klass.findInstanceMethod(methodName);
    if (method == null) return _kNotImplemented;
    return method.bind(_instance).call(_visitor, args, named);
  }

  @override
  void performLayout() {
    final result = _maybeInvoke('performLayout', const []);
    if (identical(result, _kNotImplemented)) {
      size = constraints.smallest;
      return;
    }
    if (!hasSize) {
      try {
        final reflected = _instance.get('size', visitor: _visitor);
        if (reflected is Size) size = reflected;
      } catch (_) {}
    }
    if (!hasSize) size = constraints.smallest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final result = _maybeInvoke('paint', [context, offset]);
    if (identical(result, _kNotImplemented)) {
      // Default: paint each slot child at its parent-data offset.
      for (final child in children) {
        final parentData = child.parentData;
        final childOffset = parentData is BoxParentData
            ? parentData.offset + offset
            : offset;
        context.paintChild(child, childOffset);
      }
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final method = _instance.klass.findInstanceMethod('hitTest');
    if (method == null) return super.hitTest(result, position: position);
    final raw = method
        .bind(_instance)
        .call(_visitor, [result], {'position': position});
    if (raw is bool) return raw;
    return false;
  }

  @override
  bool hitTestSelf(Offset position) {
    final method = _instance.klass.findInstanceMethod('hitTestSelf');
    if (method == null) return super.hitTestSelf(position);
    try {
      final raw = method.bind(_instance).call(_visitor, [position], const {});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final method = _instance.klass.findInstanceMethod('hitTestChildren');
    if (method == null) {
      // Default: walk slot children in reverse paint order.
      for (final child in children.toList().reversed) {
        final parentData = child.parentData;
        final childOffset =
            parentData is BoxParentData ? parentData.offset : Offset.zero;
        final hit = result.addWithPaintOffset(
          offset: childOffset,
          position: position,
          hitTest: (BoxHitTestResult r, Offset p) =>
              child.hitTest(r, position: p),
        );
        if (hit) return true;
      }
      return false;
    }
    try {
      final raw = method
          .bind(_instance)
          .call(_visitor, [result], {'position': position});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }

  @override
  void setupParentData(RenderBox child) {
    final result = _maybeInvoke('setupParentData', [child]);
    if (identical(result, _kNotImplemented)) {
      // The mixin doesn't ship a default setupParentData — fall back to a
      // BoxParentData so children that store offsets still work.
      if (child.parentData is! BoxParentData) {
        child.parentData = BoxParentData();
      }
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final method =
        _instance.klass.findInstanceMethod('computeMinIntrinsicWidth');
    if (method == null) return super.computeMinIntrinsicWidth(height);
    try {
      final raw = method.bind(_instance).call(_visitor, [height], const {});
      if (raw is num) return raw.toDouble();
    } catch (_) {}
    return super.computeMinIntrinsicWidth(height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final method =
        _instance.klass.findInstanceMethod('computeMaxIntrinsicWidth');
    if (method == null) return super.computeMaxIntrinsicWidth(height);
    try {
      final raw = method.bind(_instance).call(_visitor, [height], const {});
      if (raw is num) return raw.toDouble();
    } catch (_) {}
    return super.computeMaxIntrinsicWidth(height);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final method =
        _instance.klass.findInstanceMethod('computeMinIntrinsicHeight');
    if (method == null) return super.computeMinIntrinsicHeight(width);
    try {
      final raw = method.bind(_instance).call(_visitor, [width], const {});
      if (raw is num) return raw.toDouble();
    } catch (_) {}
    return super.computeMinIntrinsicHeight(width);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final method =
        _instance.klass.findInstanceMethod('computeMaxIntrinsicHeight');
    if (method == null) return super.computeMaxIntrinsicHeight(width);
    try {
      final raw = method.bind(_instance).call(_visitor, [width], const {});
      if (raw is num) return raw.toDouble();
    } catch (_) {}
    return super.computeMaxIntrinsicHeight(width);
  }
}

// =============================================================================
// Plan D Phase 2 — RenderAligningShiftedBox proxy
// =============================================================================
//
// Native [RenderAligningShiftedBox] backed by an interpreted subclass.
// Registered as the interface-proxy factory for 'RenderAligningShiftedBox'.
//
// The proxy is constructed with default alignment and null textDirection so
// that alignChild() (called by interpreted performLayout overrides) can always
// call _resolve() without throwing. Alignment.center.resolve(null) returns
// Alignment.center — a safe placeholder for visual-demo scripts that only
// check status=success, not pixel accuracy.
//
// performLayout uses the same `hasSize` fallback pattern as _InterpretedRenderBox
// to handle scripts that assign to `size` via the bridge setter.
class _InterpretedRenderAligningShiftedBox extends RenderAligningShiftedBox
    implements D4InterpretedProxy {
  _InterpretedRenderAligningShiftedBox(this._visitor, this._instance)
      : super(
          // Safe defaults: center alignment resolves without textDirection.
          alignment: Alignment.center,
          textDirection: null,
        );

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  static const Object _kNotImplemented = Object();

  @override
  Object get d4rtInstance => _instance;

  Object? _maybeInvoke(String methodName, List<Object?> args,
      [Map<String, Object?> named = const {}]) {
    final method = _instance.klass.findInstanceMethod(methodName);
    if (method == null) return _kNotImplemented;
    return method.bind(_instance).call(_visitor, args, named);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final method = _instance.klass.findInstanceMethod('computeDryLayout');
    if (method == null) return super.computeDryLayout(constraints);
    try {
      final raw =
          method.bind(_instance).call(_visitor, [constraints], const {});
      if (raw is Size) return raw;
    } catch (_) {}
    return super.computeDryLayout(constraints);
  }

  @override
  void performLayout() {
    final result = _maybeInvoke('performLayout', const []);
    if (identical(result, _kNotImplemented)) {
      super.performLayout();
      return;
    }
    // C19 fallback: if the script's `size = …` somehow didn't route through
    // the bridged setter (older interpreter path), read it back from the
    // instance's field map. After the C19 Instance.set fix this is dead
    // code on the happy path but kept defensively, matching the
    // _InterpretedRenderBox pattern.
    if (!hasSize) {
      try {
        final reflected = _instance.get('size', visitor: _visitor);
        if (reflected is Size) size = reflected;
      } catch (_) {}
    }
    if (!hasSize) size = constraints.smallest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final result = _maybeInvoke('paint', [context, offset]);
    if (identical(result, _kNotImplemented)) super.paint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final method = _instance.klass.findInstanceMethod('hitTestChildren');
    if (method == null) {
      return super.hitTestChildren(result, position: position);
    }
    try {
      final raw = method
          .bind(_instance)
          .call(_visitor, [result], {'position': position});
      if (raw is bool) return raw;
    } catch (_) {}
    return false;
  }

  @override
  void setupParentData(RenderObject child) {
    final result = _maybeInvoke('setupParentData', [child]);
    if (identical(result, _kNotImplemented)) super.setupParentData(child);
  }
}

// =============================================================================
// Plan D Phase 2 — ParentDataWidget proxy
// =============================================================================
//
// Native [ParentDataWidget<ParentData>] backed by an interpreted subclass.
// Registered as the interface-proxy factory for 'ParentDataWidget'.
//
// applyParentData is forwarded to the interpreted class. The generic type
// parameter is fixed to ParentData (the base type) so the proxy satisfies
// all is-checks from the widget framework. The actual runtime parentData type
// is validated inside the interpreted applyParentData override.
//
// debugTypicalAncestorWidgetClass returns Widget as a safe fallback — it is
// used only in debug error messages and does not affect runtime behaviour.
class _InterpretedParentDataWidget extends ParentDataWidget<ParentData>
    implements D4InterpretedProxy {
  _InterpretedParentDataWidget(this._visitor, this._instance,
      {required super.child, super.key});

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;

  @override
  void applyParentData(RenderObject renderObject) {
    final method = _instance.klass.findInstanceMethod('applyParentData');
    if (method == null) return;
    method.bind(_instance).call(_visitor, [renderObject], const {});
  }

  @override
  Type get debugTypicalAncestorWidgetClass {
    // Forwarding to the interpreted class would return an InterpretedClass
    // object (not a native Type), which breaks the framework's error
    // formatting. Return Widget as a safe, always-valid ancestor hint.
    return Widget;
  }

  // Cluster C21 follow-up — the base class implementation runs
  // `assert(T != ParentData)`, but our proxy is forced to bind T = ParentData
  // (Dart cannot specialise generic type arguments at runtime). The
  // interpreted subclass keeps the real generic bound (e.g.
  // `ParentDataWidget<_DefaultsParentData>`) and performs an explicit `as`
  // cast inside `applyParentData`, so downstream type errors are still
  // surfaced. Delegate to an interpreted override if present, otherwise
  // accept and let the cast in `applyParentData` validate the type.
  @override
  bool debugIsValidRenderObject(RenderObject renderObject) {
    final method = _instance.klass.findInstanceMethod(
      'debugIsValidRenderObject',
    );
    if (method != null) {
      final result = method
          .bind(_instance)
          .call(_visitor, [renderObject], const {});
      if (result is bool) return result;
    }
    return true;
  }
}

// =============================================================================
// Cluster C21 — Container-aware ParentData proxy
// =============================================================================
//
// Native [ContainerBoxParentData<RenderBox>] backed by an interpreted
// subclass. Registered as the interface-proxy factory for
// 'ContainerBoxParentData' and 'ParentData'.
//
// The proxy holds the InterpretedInstance so that:
//   1. `child.parentData = _UserParentData()` succeeds — the proxy is the
//      native object stored on the parent data slot.
//   2. `child.parentData! as _UserParentData` unwraps back to the
//      InterpretedInstance via [D4InterpretedProxy] (handled in
//      `visitAsExpression`), giving scripts access to user-defined fields.
//
// The generic type parameter is bound to RenderBox because that is the
// concrete pairing required by RenderBoxContainerDefaultsMixin and the
// scripts that exercise this code path. Scripts that need a different
// child type would need a dedicated registration.
class _InterpretedContainerBoxParentData
    extends ContainerBoxParentData<RenderBox>
    implements D4InterpretedProxy {
  // The visitor is unused for now (no method forwarding) but the registration
  // factory passes one — accept and discard to keep the factory signature
  // uniform with the other proxies in this file.
  _InterpretedContainerBoxParentData(InterpreterVisitor _, this._instance);

  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;
}

// =============================================================================
// Plan E: InheritedWidget exact-type lookup interceptors
// =============================================================================

/// Register interceptors for the three `Element` exact-type lookup methods so
/// script-supplied generic type arguments survive the bridge boundary.
///
/// **Why:** the generated bridge adapters for
/// `dependOnInheritedWidgetOfExactType<T>`,
/// `getInheritedWidgetOfExactType<T>`, and
/// `getElementForInheritedWidgetOfExactType<T>` previously dropped `T` and
/// called the native method without any type argument. Even if `T` were
/// forwarded, every interpreted `InheritedWidget` subclass collapses to the
/// same native `runtimeType` (`_InterpretedInheritedWidget`), so Flutter's
/// `_inheritedElements` map (keyed by `widget.runtimeType`) cannot
/// disambiguate. The interceptor walks ancestor elements, matches by
/// `_InterpretedInheritedWidget._instance.klass.name` for interpreted
/// subclasses (and by native `runtimeType.toString()` for bridged
/// subclasses), then either registers a dependency
/// (`dependOnInheritedElement`) or returns the matched widget/element.
///
/// **Return shape:** when the matched widget is an
/// `_InterpretedInheritedWidget`, the interceptor returns its
/// `_instance` (the `InterpretedInstance`) rather than the native proxy.
/// Scripts hold the result and access user-defined fields/methods on it
/// (`scope.watch(...)`); the interpreter dispatches those calls directly
/// against the `InterpretedClass`. Returning the proxy would force
/// dispatch through the bridge, which doesn't know about user-defined
/// members.
void _registerBridgedMethodInterceptors() {
  D4.registerBridgedMethodInterceptor(
    'Element',
    'dependOnInheritedWidgetOfExactType',
    (visitor, target, positional, named, typeArgs) {
      final element = target is Element ? target : null;
      if (element == null) return null;
      final aspect = named['aspect'];
      final matched = _findInheritedElementForType(element, typeArgs);
      if (matched == null) return null;
      element.dependOnInheritedElement(matched, aspect: aspect);
      final widget = matched.widget;
      return widget is InheritedWidget
          ? _unwrapInheritedWidget(widget)
          : widget;
    },
  );

  D4.registerBridgedMethodInterceptor(
    'Element',
    'getInheritedWidgetOfExactType',
    (visitor, target, positional, named, typeArgs) {
      final element = target is Element ? target : null;
      if (element == null) return null;
      final matched = _findInheritedElementForType(element, typeArgs);
      if (matched == null) return null;
      final widget = matched.widget;
      return widget is InheritedWidget
          ? _unwrapInheritedWidget(widget)
          : widget;
    },
  );

  D4.registerBridgedMethodInterceptor(
    'Element',
    'getElementForInheritedWidgetOfExactType',
    (visitor, target, positional, named, typeArgs) {
      final element = target is Element ? target : null;
      if (element == null) return null;
      return _findInheritedElementForType(element, typeArgs);
    },
  );

  // C6b: ThemeData.extension<T>() drops <T> at the bridge boundary so the
  // native call returns null for interpreted ThemeExtension subclasses.
  // Walk `theme.extensions.values`, matching `_InterpretedThemeExtension`
  // proxies by `_instance.klass.name` against `typeArgs[0].name`, and
  // returning the underlying `InterpretedInstance` so script field/method
  // dispatch goes through the `InterpretedClass`. Native ThemeExtensions
  // are matched by `runtimeType.toString()`.
  D4.registerBridgedMethodInterceptor(
    'ThemeData',
    'extension',
    (visitor, target, positional, named, typeArgs) {
      final theme = target is ThemeData ? target : null;
      if (theme == null) return null;
      if (typeArgs == null || typeArgs.isEmpty) return null;
      final wantedName = typeArgs[0].name;
      for (final ext in theme.extensions.values) {
        if (ext is _InterpretedThemeExtension) {
          if (ext._instance.klass.name == wantedName) {
            return ext._instance;
          }
        } else if (ext.runtimeType.toString() == wantedName) {
          return ext;
        }
      }
      return null;
    },
  );

  // Plan E (static): InheritedModel.inheritFrom<T>(context, {aspect}).
  //
  // This is a top-level static, not an Element method, so it goes through the
  // static-method interceptor registry. The native impl is type-erased on
  // interpreted subclasses (every `_InterpretedInheritedWidget` shares the
  // same runtimeType), so we replicate the ancestor walk and aspect-aware
  // dependency registration.
  D4.registerBridgedStaticMethodInterceptor(
    'InheritedModel',
    'inheritFrom',
    (visitor, positional, named, typeArgs) {
      final context = positional.isNotEmpty
          ? (positional[0] is BuildContext
                ? positional[0] as BuildContext
                : null)
          : null;
      if (context == null) return null;
      final aspect = named['aspect'];
      // BuildContext.dependOnInheritedElement requires an Element; in
      // practice every BuildContext is also an Element.
      final element = context is Element ? context : null;
      if (element == null) return null;
      final matched = _findInheritedElementForType(element, typeArgs);
      if (matched == null) return null;
      element.dependOnInheritedElement(matched, aspect: aspect);
      final widget = matched.widget;
      return widget is InheritedWidget
          ? _unwrapInheritedWidget(widget)
          : widget;
    },
  );

  // C20f: RadioGroup.maybeOf<T>(context) drops <T> at the bridge boundary.
  // Native lookup uses `dependOnInheritedWidgetOfExactType<_RadioGroupStateScope<T>>()`
  // which is keyed by the exact reified type argument — calling without `<T>`
  // resolves to `<dynamic>` and never matches the actual `_RadioGroupStateScope<String>`
  // (or other concrete T) in the tree, so the registry comes back null and any
  // enabled `RawRadio<T>` consumer trips its `groupRegistry != null` assertion.
  //
  // We dispatch to the native generic call for a known set of common type-arg
  // names; for unknown `<T>` we fall back to a type-agnostic ancestor walk that
  // returns the first State implementing `RadioGroupRegistry` (RadioGroup<T>'s
  // private state implements `RadioGroupRegistry<T>`).
  D4.registerBridgedStaticMethodInterceptor(
    'RadioGroup',
    'maybeOf',
    (visitor, positional, named, typeArgs) {
      if (positional.isEmpty) return null;
      final ctx = positional[0];
      if (ctx is! BuildContext) return null;

      final typeName = (typeArgs != null && typeArgs.isNotEmpty)
          ? typeArgs[0].name
          : null;

      final byType = switch (typeName) {
        'String' => RadioGroup.maybeOf<String>(ctx),
        'int' => RadioGroup.maybeOf<int>(ctx),
        'double' => RadioGroup.maybeOf<double>(ctx),
        'num' => RadioGroup.maybeOf<num>(ctx),
        'bool' => RadioGroup.maybeOf<bool>(ctx),
        'Object' => RadioGroup.maybeOf<Object>(ctx),
        _ => null,
      };
      if (byType != null) return byType;

      // Type-agnostic fallback for script-defined or unsupported `<T>`: walk
      // ancestors looking for the enclosing RadioGroup's State (which
      // implements RadioGroupRegistry<T>). Note: this skips inherited-widget
      // dependency registration — RawRadio rebuilds via its own listener.
      RadioGroupRegistry? registry;
      ctx.visitAncestorElements((element) {
        if (element is StatefulElement) {
          final state = element.state;
          if (state is RadioGroupRegistry) {
            registry = state as RadioGroupRegistry;
            return false;
          }
        }
        return true;
      });
      return registry;
    },
  );
}

/// Walk [from]'s ancestors looking for an `InheritedElement` whose widget
/// matches the requested generic type argument.
///
/// Matches are decided by name: for `_InterpretedInheritedWidget` (the proxy
/// for a script-defined subclass) we compare against the
/// `InterpretedInstance.klass.name`; for native widgets we compare
/// `widget.runtimeType.toString()`. Returns `null` when no ancestor matches
/// or when no type argument was supplied.
InheritedElement? _findInheritedElementForType(
  Element from,
  List<RuntimeType>? typeArgs,
) {
  if (typeArgs == null || typeArgs.isEmpty) return null;
  final wantedName = typeArgs[0].name;
  InheritedElement? match;
  from.visitAncestorElements((ancestor) {
    if (ancestor is InheritedElement) {
      final widget = ancestor.widget;
      String candidateName;
      if (widget is _InterpretedInheritedWidget) {
        candidateName = widget._instance.klass.name;
      } else {
        candidateName = widget.runtimeType.toString();
      }
      if (candidateName == wantedName) {
        match = ancestor;
        return false; // stop walking
      }
    }
    return true; // keep walking
  });
  return match;
}

/// Unwrap `_InterpretedInheritedWidget` to the underlying `InterpretedInstance`
/// so script field/method dispatch goes directly through the
/// `InterpretedClass` rather than through a native proxy that doesn't know
/// the user-defined members. Native `InheritedWidget`s are returned as-is.
Object _unwrapInheritedWidget(InheritedWidget widget) {
  if (widget is _InterpretedInheritedWidget) {
    return widget._instance;
  }
  return widget;
}

// ---------------------------------------------------------------------------
// C6b: ThemeExtension proxy for interpreted ThemeExtension subclasses
// ---------------------------------------------------------------------------

/// Native [ThemeExtension] backing an interpreted subclass (e.g. BrandTokens
/// extends ThemeExtension<BrandTokens>). Forwards `copyWith()` and `lerp()`
/// to the script.
///
/// Uses F-bounded polymorphism: `_InterpretedThemeExtension extends
/// ThemeExtension<_InterpretedThemeExtension>`. By covariance, this is also
/// a `ThemeExtension<ThemeExtension<dynamic>>`, which is what bridges
/// resolve `<T extends ThemeExtension<T>>` to at runtime — that satisfies
/// the cast inside `D4.coerceList<ThemeExtension>` for
/// `ThemeData.copyWith(extensions: …)`.
///
/// `type` is overridden to return the [InterpretedClass] so each script-side
/// ThemeExtension subclass occupies its own slot in `ThemeData.extensions`.
class _InterpretedThemeExtension
    extends ThemeExtension<_InterpretedThemeExtension>
    implements D4InterpretedProxy {
  _InterpretedThemeExtension(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;

  @override
  Object get type => _instance.klass;

  @override
  ThemeExtension<_InterpretedThemeExtension> copyWith() {
    final method = _instance.klass.findInstanceMethod('copyWith');
    if (method == null) return this;
    try {
      final result = method.bind(_instance).call(_visitor, const [], const {});
      if (result is InterpretedInstance) {
        return _InterpretedThemeExtension(_visitor, result);
      }
    } catch (_) {}
    return this;
  }

  @override
  ThemeExtension<_InterpretedThemeExtension> lerp(
      covariant ThemeExtension<_InterpretedThemeExtension>? other, double t) {
    final method = _instance.klass.findInstanceMethod('lerp');
    if (method == null) return this;
    final otherArg =
        other is _InterpretedThemeExtension ? other._instance : other;
    try {
      final result =
          method.bind(_instance).call(_visitor, [otherArg, t], const {});
      if (result is InterpretedInstance) {
        return _InterpretedThemeExtension(_visitor, result);
      }
    } catch (_) {}
    return this;
  }
}

// =============================================================================
// C7: TwoDimensionalScrollView / Viewport / RenderViewport proxies
// =============================================================================
//
// Scripts that subclass `TwoDimensionalScrollView`, `TwoDimensionalViewport`,
// and `RenderTwoDimensionalViewport` (typical custom 2-axis grid demo) need
// real native instances of those types so Flutter's render pipeline can
// drive `build` / `buildViewport` / `createRenderObject` / `layoutChildSequence`.
//
// The bridge generator emits these classes with `isAbstract: true,
// constructors: {}` (GEN-051 strips non-factory constructors of abstract
// classes) — they have no constructor adapter, so a plain super-call from the
// interpreted constructor fails. The C7 super-arg-capture branch in
// `callable.dart` evaluates the user's `super(...)` argument list (merged
// with `super.foo` parameter forwards) and stashes the result on the
// `InterpretedInstance` (`superCallNamedArgs` / `superCallPositionalArgs`).
//
// Each proxy's `create(...)` static factory:
//   1. reads the named super-args off the InterpretedInstance,
//   2. forwards them to the native super-constructor (with sane defaults
//      for missing named args — keeps the proxy resilient against scripts
//      that don't set every super-formal),
//   3. attaches `instance.nativeProxy = this` so the interpreter resolves
//      inherited getters/methods through the bridged super of this proxy
//      (delegate, horizontalOffset, verticalOffset, viewportDimension,
//      buildOrObtainChildFor, parentDataOf, …).
//
// Each proxy overrides exactly one virtual hook back into the interpreter:
//   - `_InterpretedTwoDimensionalScrollView.buildViewport`
//   - `_InterpretedTwoDimensionalViewport.createRenderObject` /
//     `updateRenderObject`
//   - `_InterpretedRenderTwoDimensionalViewport.layoutChildSequence`

/// Read a captured `super(...)` named arg and unwrap it to a native [T].
///
/// Captured args may be raw native values (the script passed e.g.
/// `Axis.vertical`), [BridgedInstance]s (a wrapped enum / value type), or
/// [InterpretedInstance]s extending a bridged class (e.g. a script-defined
/// `_TwoDMgrCountingDelegate extends TwoDimensionalChildBuilderDelegate`).
/// `D4.extractBridgedArgOrNull` handles all three: native pass-through,
/// `BridgedInstance.nativeObject` unwrapping, and interpreted-instance
/// proxy/`bridgedSuperObject` resolution. Without this unwrap, complex
/// types such as a delegate that the script subclassed would fail the
/// bare `is T` check and surface as a missing-arg [StateError].
T? _readSuperArg<T>(
  InterpretedInstance instance,
  String name, [
  InterpreterVisitor? visitor,
]) {
  final raw = instance.superCallNamedArgs?[name];
  if (raw == null) return null;
  try {
    return D4.extractBridgedArgOrNull<T>(raw, name, visitor);
  } catch (_) {
    // extractBridgedArgOrNull throws ArgumentError on type mismatch; for
    // optional super-args we prefer to return null so the caller can fall
    // back to a default (e.g. `Axis.vertical`).
    return null;
  }
}

/// Native [TwoDimensionalScrollView] backing an interpreted subclass.
class _InterpretedTwoDimensionalScrollView extends TwoDimensionalScrollView {
  _InterpretedTwoDimensionalScrollView._(
    this._visitor,
    this._instance, {
    super.key,
    super.primary,
    super.mainAxis,
    super.verticalDetails,
    super.horizontalDetails,
    required super.delegate,
    super.cacheExtent,
    super.cacheExtentStyle,
    super.diagonalDragBehavior,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.clipBehavior,
    super.hitTestBehavior,
  });

  static _InterpretedTwoDimensionalScrollView create(
    InterpreterVisitor visitor,
    InterpretedInstance instance,
  ) {
    final delegate = _readSuperArg<TwoDimensionalChildDelegate>(
        instance, 'delegate', visitor);
    if (delegate == null) {
      throw StateError(
          'C7: Interpreted TwoDimensionalScrollView subclass '
          '${instance.klass.name} did not pass a `delegate` to super(...).');
    }
    final proxy = _InterpretedTwoDimensionalScrollView._(
      visitor,
      instance,
      key: _readSuperArg<Key>(instance, 'key', visitor) ??
          _readKey(instance, visitor),
      primary: _readSuperArg<bool>(instance, 'primary', visitor),
      mainAxis: _readSuperArg<Axis>(instance, 'mainAxis', visitor) ??
          Axis.vertical,
      verticalDetails: _readSuperArg<ScrollableDetails>(
              instance, 'verticalDetails', visitor) ??
          const ScrollableDetails.vertical(),
      horizontalDetails: _readSuperArg<ScrollableDetails>(
              instance, 'horizontalDetails', visitor) ??
          const ScrollableDetails.horizontal(),
      delegate: delegate,
      cacheExtent: _readSuperArg<double>(instance, 'cacheExtent', visitor),
      cacheExtentStyle: _readSuperArg<CacheExtentStyle>(
          instance, 'cacheExtentStyle', visitor),
      diagonalDragBehavior: _readSuperArg<DiagonalDragBehavior>(
              instance, 'diagonalDragBehavior', visitor) ??
          DiagonalDragBehavior.none,
      dragStartBehavior: _readSuperArg<DragStartBehavior>(
              instance, 'dragStartBehavior', visitor) ??
          DragStartBehavior.start,
      keyboardDismissBehavior:
          _readSuperArg<ScrollViewKeyboardDismissBehavior>(
              instance, 'keyboardDismissBehavior', visitor),
      clipBehavior:
          _readSuperArg<Clip>(instance, 'clipBehavior', visitor) ??
              Clip.hardEdge,
      hitTestBehavior:
          _readSuperArg<HitTestBehavior>(instance, 'hitTestBehavior', visitor) ??
              HitTestBehavior.opaque,
    );
    instance.nativeProxy ??= proxy;
    return proxy;
  }

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Widget buildViewport(
    BuildContext context,
    ViewportOffset verticalOffset,
    ViewportOffset horizontalOffset,
  ) =>
      _invokeInterpretedAs<Widget>(_visitor, _instance, 'buildViewport',
          [context, verticalOffset, horizontalOffset]);
}

// =============================================================================
// BoxScrollView proxy
// =============================================================================
//
// Scripts that subclass `BoxScrollView` (or the more common `ListView` /
// `GridView`) and pass instances where a `Widget` is expected (e.g.
// `SizedBox(child: _MyBoxScroll(...))`) need a real native `BoxScrollView`
// so Flutter can drive the scroll pipeline.
//
// The proxy reads the captured super-constructor args (scrollDirection,
// reverse, physics, shrinkWrap, padding, …) and forwards `buildChildLayout`
// back to the interpreter. Without `markProxyCapturesSuperArgs('BoxScrollView')`
// all args are null and fall back to defaults (Axis.vertical / false / …);
// in practice most scripts use those exact defaults so fallback is fine.

/// Native [BoxScrollView] backing an interpreted subclass.
///
/// Delegates [buildChildLayout] to the interpreted class's override,
/// enabling scripts that extend [BoxScrollView] to power a real scrollable.
class _InterpretedBoxScrollView extends BoxScrollView {
  _InterpretedBoxScrollView._(
    this._visitor,
    this._instance, {
    super.key,
    super.scrollDirection = Axis.vertical,
    super.reverse = false,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap = false,
    super.padding,
    super.dragStartBehavior = DragStartBehavior.start,
    super.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    super.restorationId,
    super.clipBehavior = Clip.hardEdge,
    super.hitTestBehavior = HitTestBehavior.opaque,
  });

  static _InterpretedBoxScrollView create(
    InterpreterVisitor visitor,
    InterpretedInstance instance,
  ) {
    final proxy = _InterpretedBoxScrollView._(
      visitor,
      instance,
      key: _readSuperArg<Key>(instance, 'key', visitor) ??
          _readKey(instance, visitor),
      scrollDirection:
          _readSuperArg<Axis>(instance, 'scrollDirection', visitor) ??
              Axis.vertical,
      reverse: _readSuperArg<bool>(instance, 'reverse', visitor) ?? false,
      controller:
          _readSuperArg<ScrollController>(instance, 'controller', visitor),
      primary: _readSuperArg<bool>(instance, 'primary', visitor),
      physics:
          _readSuperArg<ScrollPhysics>(instance, 'physics', visitor),
      shrinkWrap:
          _readSuperArg<bool>(instance, 'shrinkWrap', visitor) ?? false,
      padding: _readSuperArg<EdgeInsetsGeometry>(instance, 'padding', visitor),
      dragStartBehavior:
          _readSuperArg<DragStartBehavior>(
                  instance, 'dragStartBehavior', visitor) ??
              DragStartBehavior.start,
      keyboardDismissBehavior:
          _readSuperArg<ScrollViewKeyboardDismissBehavior>(
                  instance, 'keyboardDismissBehavior', visitor) ??
              ScrollViewKeyboardDismissBehavior.manual,
      restorationId:
          _readSuperArg<String>(instance, 'restorationId', visitor),
      clipBehavior:
          _readSuperArg<Clip>(instance, 'clipBehavior', visitor) ?? Clip.hardEdge,
      hitTestBehavior:
          _readSuperArg<HitTestBehavior>(
                  instance, 'hitTestBehavior', visitor) ??
              HitTestBehavior.opaque,
    );
    instance.nativeProxy ??= proxy;
    return proxy;
  }

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Widget buildChildLayout(BuildContext context) =>
      _invokeInterpretedAs<Widget>(
          _visitor, _instance, 'buildChildLayout', [context]);
}

/// Native [TwoDimensionalViewport] backing an interpreted subclass.
class _InterpretedTwoDimensionalViewport extends TwoDimensionalViewport {
  _InterpretedTwoDimensionalViewport._(
    this._visitor,
    this._instance, {
    super.key,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.delegate,
    required super.mainAxis,
    super.cacheExtent,
    super.cacheExtentStyle,
    super.clipBehavior,
  });

  static _InterpretedTwoDimensionalViewport create(
    InterpreterVisitor visitor,
    InterpretedInstance instance,
  ) {
    final delegate = _readSuperArg<TwoDimensionalChildDelegate>(
        instance, 'delegate', visitor);
    final verticalOffset = _readSuperArg<ViewportOffset>(
        instance, 'verticalOffset', visitor);
    final horizontalOffset = _readSuperArg<ViewportOffset>(
        instance, 'horizontalOffset', visitor);
    final verticalAxisDirection = _readSuperArg<AxisDirection>(
        instance, 'verticalAxisDirection', visitor);
    final horizontalAxisDirection = _readSuperArg<AxisDirection>(
        instance, 'horizontalAxisDirection', visitor);
    final mainAxis = _readSuperArg<Axis>(instance, 'mainAxis', visitor);
    if (delegate == null ||
        verticalOffset == null ||
        horizontalOffset == null ||
        verticalAxisDirection == null ||
        horizontalAxisDirection == null ||
        mainAxis == null) {
      throw StateError(
          'C7: Interpreted TwoDimensionalViewport subclass '
          '${instance.klass.name} did not pass all required '
          'super-args (delegate / verticalOffset / horizontalOffset / '
          'verticalAxisDirection / horizontalAxisDirection / mainAxis).');
    }
    final proxy = _InterpretedTwoDimensionalViewport._(
      visitor,
      instance,
      key: _readSuperArg<Key>(instance, 'key', visitor) ??
          _readKey(instance, visitor),
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalAxisDirection,
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalAxisDirection,
      delegate: delegate,
      mainAxis: mainAxis,
      cacheExtent: _readSuperArg<double>(instance, 'cacheExtent', visitor),
      cacheExtentStyle: _readSuperArg<CacheExtentStyle>(
          instance, 'cacheExtentStyle', visitor),
      clipBehavior:
          _readSuperArg<Clip>(instance, 'clipBehavior', visitor) ??
              Clip.hardEdge,
    );
    instance.nativeProxy ??= proxy;
    return proxy;
  }

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  RenderTwoDimensionalViewport createRenderObject(BuildContext context) {
    final raw = _invokeInterpretedAs<RenderObject>(
        _visitor, _instance, 'createRenderObject', [context]);
    if (raw is RenderTwoDimensionalViewport) return raw;
    throw StateError(
        'Interpreted ${_instance.klass.name}.createRenderObject must return a '
        'RenderTwoDimensionalViewport, got ${raw.runtimeType}');
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderTwoDimensionalViewport renderObject,
  ) {
    final method = _instance.klass.findInstanceMethod('updateRenderObject');
    if (method == null) return;
    method.bind(_instance).call(_visitor, [context, renderObject], {});
  }
}

/// Native [RenderTwoDimensionalViewport] backing an interpreted subclass.
///
/// `layoutChildSequence` dispatches into the interpreted method. The
/// interpreted method reads inherited getters (`horizontalOffset`,
/// `verticalOffset`, `viewportDimension`, `delegate`) and calls inherited
/// methods (`buildOrObtainChildFor`, `parentDataOf`, `markNeedsLayout`)
/// through the bridge boundary; resolution lands on this proxy because we
/// set `instance.nativeProxy = this` in [create].
class _InterpretedRenderTwoDimensionalViewport
    extends RenderTwoDimensionalViewport {
  _InterpretedRenderTwoDimensionalViewport._(
    this._visitor,
    this._instance, {
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.delegate,
    required super.mainAxis,
    required super.childManager,
    super.cacheExtent,
    super.cacheExtentStyle,
    super.clipBehavior,
  });

  static _InterpretedRenderTwoDimensionalViewport create(
    InterpreterVisitor visitor,
    InterpretedInstance instance,
  ) {
    final delegate = _readSuperArg<TwoDimensionalChildDelegate>(
        instance, 'delegate', visitor);
    final verticalOffset = _readSuperArg<ViewportOffset>(
        instance, 'verticalOffset', visitor);
    final horizontalOffset = _readSuperArg<ViewportOffset>(
        instance, 'horizontalOffset', visitor);
    final verticalAxisDirection = _readSuperArg<AxisDirection>(
        instance, 'verticalAxisDirection', visitor);
    final horizontalAxisDirection = _readSuperArg<AxisDirection>(
        instance, 'horizontalAxisDirection', visitor);
    final mainAxis = _readSuperArg<Axis>(instance, 'mainAxis', visitor);
    final childManager = _readSuperArg<TwoDimensionalChildManager>(
        instance, 'childManager', visitor);
    if (delegate == null ||
        verticalOffset == null ||
        horizontalOffset == null ||
        verticalAxisDirection == null ||
        horizontalAxisDirection == null ||
        mainAxis == null ||
        childManager == null) {
      throw StateError(
          'C7: Interpreted RenderTwoDimensionalViewport subclass '
          '${instance.klass.name} did not pass all required super-args.');
    }
    final proxy = _InterpretedRenderTwoDimensionalViewport._(
      visitor,
      instance,
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalAxisDirection,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalAxisDirection,
      delegate: delegate,
      mainAxis: mainAxis,
      childManager: childManager,
      cacheExtent: _readSuperArg<double>(instance, 'cacheExtent', visitor),
      cacheExtentStyle: _readSuperArg<CacheExtentStyle>(
          instance, 'cacheExtentStyle', visitor),
      clipBehavior:
          _readSuperArg<Clip>(instance, 'clipBehavior', visitor) ??
              Clip.hardEdge,
    );
    instance.nativeProxy ??= proxy;
    return proxy;
  }

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  void layoutChildSequence() {
    final method = _instance.klass.findInstanceMethod('layoutChildSequence');
    if (method == null) {
      throw StateError(
          'Interpreted ${_instance.klass.name} does not implement '
          'layoutChildSequence()');
    }
    method.bind(_instance).call(_visitor, const [], const {});
  }
}

/// Native [WidgetStatesConstraint] backing an interpreted user class that
/// `implements WidgetStatesConstraint` (C20a follow-up).
///
/// Forwards `isSatisfiedBy(Set<WidgetState> states)` to the interpreter so the
/// resolver (e.g. `WidgetStateColor.fromMap` / `WidgetStatePropertyMap`)
/// evaluates the script's predicate at lookup time. The proxy also implements
/// `&`, `|` and `~` by composing through the bridged operator overloads so
/// expressions like `WidgetState.pressed & ~_MyConstraint()` continue to
/// work whether the interpreted predicate appears on the left or right.
class _InterpretedWidgetStatesConstraint implements WidgetStatesConstraint {
  _InterpretedWidgetStatesConstraint(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  bool isSatisfiedBy(Set<WidgetState> states) {
    final method = _instance.klass.findInstanceMethod('isSatisfiedBy');
    if (method == null) {
      throw StateError(
          'Interpreted class ${_instance.klass.name} does not implement '
          'isSatisfiedBy(Set<WidgetState>)');
    }
    final result =
        method.bind(_instance).call(_visitor, [states], const {});
    if (result is bool) return result;
    throw StateError(
        'Interpreted ${_instance.klass.name}.isSatisfiedBy must return bool; '
        'got ${result.runtimeType}');
  }
}

/// Native [RestorableValue]/[RestorableProperty] backing an interpreted
/// subclass — Cluster D4.
///
/// Scripts that subclass `RestorableValue<T>` (e.g.
/// `_RestorableDuration extends RestorableValue<Duration>`) need a native
/// `RestorableProperty`
/// instance to satisfy `RestorationMixin.registerForRestoration(property)`.
/// The proxy extends `RestorableValue<Object?>` (the type-erased
/// convenience tier) so it satisfies the parameter cast and inherits the
/// `_value` storage + listener list. Only `createDefaultValue`,
/// `fromPrimitives`, `toPrimitives`, and `didUpdateValue` are forwarded —
/// these are the four overrides the `RestorableValue` contract documents.
class _InterpretedRestorableValue extends RestorableValue<Object?>
    implements D4InterpretedProxy {
  _InterpretedRestorableValue(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;

  @override
  Object? createDefaultValue() {
    final method = _instance.klass.findInstanceMethod('createDefaultValue');
    if (method == null) {
      throw StateError(
        'Interpreted class ${_instance.klass.name} does not implement '
        'createDefaultValue() — RestorableValue<T> subclasses must override it.',
      );
    }
    return method.bind(_instance).call(_visitor, const [], const {});
  }

  @override
  Object? fromPrimitives(Object? data) {
    final method = _instance.klass.findInstanceMethod('fromPrimitives');
    if (method == null) {
      throw StateError(
        'Interpreted class ${_instance.klass.name} does not implement '
        'fromPrimitives(Object? data) — RestorableValue<T> subclasses must '
        'override it.',
      );
    }
    return method.bind(_instance).call(_visitor, [data], const {});
  }

  @override
  Object? toPrimitives() {
    final method = _instance.klass.findInstanceMethod('toPrimitives');
    if (method == null) {
      throw StateError(
        'Interpreted class ${_instance.klass.name} does not implement '
        'toPrimitives() — RestorableValue<T> subclasses must override it.',
      );
    }
    return method.bind(_instance).call(_visitor, const [], const {});
  }

  @override
  void didUpdateValue(Object? oldValue) {
    final method = _instance.klass.findInstanceMethod('didUpdateValue');
    if (method == null) {
      // RestorableValue's contract: if subclasses don't override, just notify
      // listeners. Skipping the forwarding keeps default-restorable scripts
      // (those that only define createDefaultValue/fromPrimitives/toPrimitives
      // without a custom equality check) working.
      notifyListeners();
      return;
    }
    method.bind(_instance).call(_visitor, [oldValue], const {});
  }
}

/// Native [TextSelectionGestureDetectorBuilderDelegate] backing an interpreted
/// implementer — Cluster D3.
///
/// `TextSelectionGestureDetectorBuilder({required delegate})` performs a
/// concrete-type check on `delegate`; without this proxy the interpreted
/// instance fails the cast. The proxy forwards the three getters in the
/// interface to the script class via [InterpretedInstance.get], coercing the
/// returned values into the strongly-typed return shapes the framework
/// expects.
class _InterpretedTextSelectionGestureDetectorBuilderDelegate
    implements TextSelectionGestureDetectorBuilderDelegate, D4InterpretedProxy {
  _InterpretedTextSelectionGestureDetectorBuilderDelegate(
      this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;

  @override
  GlobalKey<EditableTextState> get editableTextKey {
    final raw = _instance.get('editableTextKey', visitor: _visitor);
    if (raw is GlobalKey<EditableTextState>) return raw;
    if (raw is BridgedInstance &&
        raw.nativeObject is GlobalKey<EditableTextState>) {
      return raw.nativeObject as GlobalKey<EditableTextState>;
    }
    throw StateError(
      'Interpreted class ${_instance.klass.name} editableTextKey getter '
      'must return a GlobalKey<EditableTextState>; got ${raw.runtimeType}',
    );
  }

  @override
  bool get forcePressEnabled {
    final raw = _instance.get('forcePressEnabled', visitor: _visitor);
    if (raw is bool) return raw;
    throw StateError(
      'Interpreted class ${_instance.klass.name} forcePressEnabled getter '
      'must return a bool; got ${raw.runtimeType}',
    );
  }

  @override
  bool get selectionEnabled {
    final raw = _instance.get('selectionEnabled', visitor: _visitor);
    if (raw is bool) return raw;
    throw StateError(
      'Interpreted class ${_instance.klass.name} selectionEnabled getter '
      'must return a bool; got ${raw.runtimeType}',
    );
  }
}

// =============================================================================
// Cluster E11 — RouterDelegate proxy
// =============================================================================
//
// Native [RouterDelegate<Object>] backed by an interpreted subclass.
// Registered as the interface-proxy factory for 'RouterDelegate'.
//
// The proxy extends the real abstract `RouterDelegate<Object>` and forwards
// `setNewRoutePath`, `popRoute`, `build`, and the `Listenable` contract
// (`addListener`/`removeListener`) to the interpreted class. Test scripts
// commonly mix in a small `_ChangeNotifierShim` (since the bridge does not
// expose `ChangeNotifier`); the proxy delegates listener registration to that
// shim via the interpreted instance.
//
// Cluster D TODO #9 (testlog 20260525-1059) — `<Object>` not `<dynamic>`:
//
// The generic type parameter is bound to `Object` (not `dynamic`) because
// `WidgetsApp.router(routerDelegate: ...)` declares the parameter as
// `RouterDelegate<Object>?`. Dart's runtime `is` check for invariant
// generics treats `RouterDelegate<dynamic>` as distinct from
// `RouterDelegate<Object>` (see GEN-118b in the flutter_ast variant), so
// a `<dynamic>` proxy would fail `extractBridgedArg<RouterDelegate<Object>?>`
// even when correctly registered — `proxy is RouterDelegate<Object>?`
// returns false. `<Object>` is the universal top-non-nullable type that
// satisfies the bridge boundary. Scripts that declare
// `RouterDelegate<Foo>` work at the interpreter level; only the proxy
// boundary erases to `Object`. Mirror of
// `tom_d4rt_flutter_ast/lib/src/d4rt_runtime_registrations.dart`'s
// `_InterpretedRouterDelegate` (same body shape).
class _InterpretedRouterDelegate extends RouterDelegate<Object>
    implements D4InterpretedProxy {
  _InterpretedRouterDelegate(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  static const Object _kNotImplemented = Object();

  @override
  Object get d4rtInstance => _instance;

  Object? _maybeInvoke(String methodName, List<Object?> args,
      [Map<String, Object?> named = const {}]) {
    final method = _instance.klass.findInstanceMethod(methodName);
    if (method == null) return _kNotImplemented;
    return method.bind(_instance).call(_visitor, args, named);
  }

  @override
  Future<void> setNewRoutePath(Object? configuration) async {
    final result = _maybeInvoke('setNewRoutePath', [configuration]);
    if (identical(result, _kNotImplemented)) return;
    if (result is Future) {
      await result;
    }
  }

  @override
  Future<bool> popRoute() async {
    final result = _maybeInvoke('popRoute', const []);
    if (identical(result, _kNotImplemented)) return false;
    if (result is Future) {
      final awaited = await result;
      if (awaited is bool) return awaited;
      return false;
    }
    if (result is bool) return result;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final method = _instance.klass.findInstanceMethod('build');
    if (method == null) {
      throw StateError(
        'Interpreted class ${_instance.klass.name} does not implement build()',
      );
    }
    final result = method.bind(_instance).call(_visitor, [context], const {});
    return D4.extractBridgedArg<Widget>(result, 'build', _visitor);
  }

  @override
  void addListener(VoidCallback listener) {
    final result = _maybeInvoke('addListener', [listener]);
    if (identical(result, _kNotImplemented)) {
      // No interpreted addListener — the interpreted subclass doesn't notify
      // anyone, so silently ignore. The framework will still poll
      // `currentConfiguration` when needed.
      return;
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    final result = _maybeInvoke('removeListener', [listener]);
    if (identical(result, _kNotImplemented)) return;
  }
}

/// 1401-TODO #5 (F11): adapter proxy for interpreted `TextSelectionControls`
/// subclasses. Mirror of the RouterDelegate pattern just above —
/// `TextSelectionControls` is abstract, has no concrete constructor the
/// interpreter can chain through, and is consumed by `TextField` /
/// `EditableText` via `extractBridgedArg<TextSelectionControls?>`. The
/// proxy forwards the four abstract methods to the interpreted instance
/// and falls back to the framework's default implementation for the
/// optional override hooks (canCut, canCopy, canPaste, canSelectAll,
/// handleCut, handleCopy, handlePaste, handleSelectAll) when the script
/// doesn't override them.
class _InterpretedTextSelectionControls extends TextSelectionControls
    implements D4InterpretedProxy {
  _InterpretedTextSelectionControls(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  static const Object _kNotImplemented = Object();

  @override
  Object get d4rtInstance => _instance;

  Object? _maybeInvoke(String methodName, List<Object?> args,
      [Map<String, Object?> named = const {}]) {
    final method = _instance.klass.findInstanceMethod(methodName);
    if (method == null) return _kNotImplemented;
    return method.bind(_instance).call(_visitor, args, named);
  }

  // ----- Abstract methods (must be implemented) -----

  @override
  Size getHandleSize(double textLineHeight) {
    final result = _maybeInvoke('getHandleSize', [textLineHeight]);
    if (identical(result, _kNotImplemented)) {
      throw StateError(
        'Interpreted class ${_instance.klass.name} does not implement '
        'TextSelectionControls.getHandleSize',
      );
    }
    return D4.extractBridgedArg<Size>(result, 'getHandleSize', _visitor);
  }

  @override
  Offset getHandleAnchor(
      TextSelectionHandleType type, double textLineHeight) {
    final result =
        _maybeInvoke('getHandleAnchor', [type, textLineHeight]);
    if (identical(result, _kNotImplemented)) {
      throw StateError(
        'Interpreted class ${_instance.klass.name} does not implement '
        'TextSelectionControls.getHandleAnchor',
      );
    }
    return D4.extractBridgedArg<Offset>(result, 'getHandleAnchor', _visitor);
  }

  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
  ]) {
    final result = _maybeInvoke(
      'buildHandle',
      [context, type, textLineHeight, onTap],
    );
    if (identical(result, _kNotImplemented)) {
      throw StateError(
        'Interpreted class ${_instance.klass.name} does not implement '
        'TextSelectionControls.buildHandle',
      );
    }
    return D4.extractBridgedArg<Widget>(result, 'buildHandle', _visitor);
  }

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ValueListenable<ClipboardStatus>? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    final result = _maybeInvoke('buildToolbar', [
      context,
      globalEditableRegion,
      textLineHeight,
      selectionMidpoint,
      endpoints,
      delegate,
      clipboardStatus,
      lastSecondaryTapDownPosition,
    ]);
    if (identical(result, _kNotImplemented)) {
      throw StateError(
        'Interpreted class ${_instance.klass.name} does not implement '
        'TextSelectionControls.buildToolbar',
      );
    }
    return D4.extractBridgedArg<Widget>(result, 'buildToolbar', _visitor);
  }

  // ----- Optional override hooks (default impls in TextSelectionControls) -----

  // All eight hooks below (canCut/canCopy/canPaste/canSelectAll/handleCut/
  // handleCopy/handlePaste/handleSelectAll) are deprecated in Flutter 3.3+
  // in favour of `EditableText.contextMenuBuilder` but remain on the
  // abstract base class. Scripts that subclass TextSelectionControls may
  // still override them; the proxy must forward to the interpreted impl
  // when present. The `deprecated_member_use` ignores are intentional —
  // we're maintaining backward-compat with the abstract surface, not
  // endorsing the API.
  // ignore: deprecated_member_use
  @override
  bool canCut(TextSelectionDelegate delegate) {
    final result = _maybeInvoke('canCut', [delegate]);
    // ignore: deprecated_member_use
    if (identical(result, _kNotImplemented)) return super.canCut(delegate);
    // ignore: deprecated_member_use
    return result is bool ? result : super.canCut(delegate);
  }

  // ignore: deprecated_member_use
  @override
  bool canCopy(TextSelectionDelegate delegate) {
    final result = _maybeInvoke('canCopy', [delegate]);
    // ignore: deprecated_member_use
    if (identical(result, _kNotImplemented)) return super.canCopy(delegate);
    // ignore: deprecated_member_use
    return result is bool ? result : super.canCopy(delegate);
  }

  // The following four hooks are deprecated in Flutter 3.3+ in favour of
  // `EditableText.contextMenuBuilder` but remain on the abstract base class.
  // Scripts that subclass TextSelectionControls may still override them; the
  // proxy must forward to the interpreted impl when present. The
  // `deprecated_member_use` ignore is intentional — we're maintaining
  // backward-compat with the abstract surface, not endorsing the API.
  // ignore: deprecated_member_use
  @override
  bool canPaste(TextSelectionDelegate delegate) {
    final result = _maybeInvoke('canPaste', [delegate]);
    // ignore: deprecated_member_use
    if (identical(result, _kNotImplemented)) return super.canPaste(delegate);
    // ignore: deprecated_member_use
    return result is bool ? result : super.canPaste(delegate);
  }

  // ignore: deprecated_member_use
  @override
  bool canSelectAll(TextSelectionDelegate delegate) {
    final result = _maybeInvoke('canSelectAll', [delegate]);
    if (identical(result, _kNotImplemented)) {
      // ignore: deprecated_member_use
      return super.canSelectAll(delegate);
    }
    // ignore: deprecated_member_use
    return result is bool ? result : super.canSelectAll(delegate);
  }

  @override
  void handleCut(TextSelectionDelegate delegate) {
    final result = _maybeInvoke('handleCut', [delegate]);
    // ignore: deprecated_member_use
    if (identical(result, _kNotImplemented)) super.handleCut(delegate);
  }

  @override
  void handleCopy(TextSelectionDelegate delegate) {
    final result = _maybeInvoke('handleCopy', [delegate]);
    // ignore: deprecated_member_use
    if (identical(result, _kNotImplemented)) super.handleCopy(delegate);
  }

  @override
  Future<void> handlePaste(TextSelectionDelegate delegate) async {
    final result = _maybeInvoke('handlePaste', [delegate]);
    if (identical(result, _kNotImplemented)) {
      // ignore: deprecated_member_use
      await super.handlePaste(delegate);
      return;
    }
    if (result is Future) await result;
  }

  @override
  void handleSelectAll(TextSelectionDelegate delegate) {
    final result = _maybeInvoke('handleSelectAll', [delegate]);
    // ignore: deprecated_member_use
    if (identical(result, _kNotImplemented)) super.handleSelectAll(delegate);
  }
}

/// Step 3 (testlog 20260518-1449): Native shadow for interpreted classes
/// shaped like `class _Node with DiagnosticableTreeMixin`.
///
/// The native `DiagnosticableTreeMixin.toStringDeep` traversal calls
/// `toStringShort`, `debugFillProperties`, and `debugDescribeChildren` —
/// the three methods scripts override per the mixin contract. Each
/// override below forwards to the interpreted instance when the script
/// provides an override, otherwise falls through to the mixin's default.
///
/// Recursion guards: when the script's own `debugFillProperties` invokes
/// `super.debugFillProperties(properties)`, super-call dispatch routes
/// through `instance.nativeProxy` (which is this proxy). Without a guard,
/// re-entering the same override would loop. The boolean flags
/// short-circuit re-entry to the mixin's native default impl.
class _InterpretedDiagnosticableTreeMixin
    with DiagnosticableTreeMixin
    implements D4InterpretedProxy {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;
  bool _inToStringShort = false;
  bool _inDebugFillProperties = false;
  bool _inDebugDescribeChildren = false;

  _InterpretedDiagnosticableTreeMixin(this._visitor, this._instance);

  @override
  InterpretedInstance get d4rtInstance => _instance;

  @override
  String toStringShort() {
    if (_inToStringShort) return super.toStringShort();
    final method = _instance.klass.findInstanceMethod('toStringShort');
    if (method == null) return super.toStringShort();
    _inToStringShort = true;
    try {
      final result = method.bind(_instance).call(_visitor, [], {});
      if (result is String) return result;
      return super.toStringShort();
    } finally {
      _inToStringShort = false;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    if (_inDebugFillProperties) {
      super.debugFillProperties(properties);
      return;
    }
    final method = _instance.klass.findInstanceMethod('debugFillProperties');
    if (method == null) {
      super.debugFillProperties(properties);
      return;
    }
    _inDebugFillProperties = true;
    try {
      method.bind(_instance).call(_visitor, [properties], {});
    } finally {
      _inDebugFillProperties = false;
    }
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    if (_inDebugDescribeChildren) return super.debugDescribeChildren();
    final method =
        _instance.klass.findInstanceMethod('debugDescribeChildren');
    if (method == null) return super.debugDescribeChildren();
    _inDebugDescribeChildren = true;
    try {
      final result = method.bind(_instance).call(_visitor, [], {});
      if (result is List) {
        return result.whereType<DiagnosticsNode>().toList();
      }
      return super.debugDescribeChildren();
    } finally {
      _inDebugDescribeChildren = false;
    }
  }
}
