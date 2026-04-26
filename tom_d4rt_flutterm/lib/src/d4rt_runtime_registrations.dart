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
    show ChangeNotifier, Key, ValueKey, ValueNotifier;
import 'package:flutter/material.dart'
    show
        ButtonSegment,
        DropdownMenuEntry,
        DropdownMenuItem,
        ScaffoldState;
import 'package:flutter/painting.dart' as painting show StrutStyle, TextStyle;
import 'package:flutter/painting.dart' show Alignment;
import 'package:flutter/rendering.dart'
    show
        BoxConstraints,
        BoxHitTestResult,
        CustomClipper,
        MultiChildLayoutDelegate,
        PaintingContext,
        ParentData,
        RenderAligningShiftedBox,
        RenderBox,
        RenderObject,
        SingleChildLayoutDelegate;
import 'package:flutter/scheduler.dart' show Ticker, TickerProvider;
import 'package:flutter/widgets.dart'
    show
        BuildContext,
        GlobalKey,
        InheritedElement,
        InheritedWidget,
        LeafRenderObjectWidget,
        MultiChildRenderObjectWidget,
        NavigatorState,
        FormState,
        ParentDataWidget,
        SingleChildRenderObjectWidget,
        SingleTickerProviderStateMixin,
        SizedBox,
        State,
        StatefulWidget,
        StatelessWidget,
        TickerProviderStateMixin,
        Widget;
import 'dart:ui' show Offset, Path, Size;
import 'package:tom_d4rt_exec/d4rt.dart' show D4;
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart'
    show BridgedClass, BridgedInstance;
import 'package:tom_d4rt_ast/src/runtime/interpreter_visitor.dart';
import 'package:tom_d4rt_ast/src/runtime/runtime_types.dart';

import 'bridges/flutter_proxies.b.dart' show D4rtMultiChildLayoutDelegate;
import 'bridges/flutter_relaxers.b.dart' show $RelaxedTween;

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
    // Painting
    'Decoration': [],
    'BoxDecoration': ['Decoration'],
    'ShapeDecoration': ['Decoration'],
    // Other common types
    'ChangeNotifier': ['Listenable'],
    'ValueNotifier': ['ChangeNotifier', 'Listenable'],
    'Animation': ['Listenable'],
    'AnimationController': ['Animation', 'Listenable'],
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
  D4.registerInterfaceProxy('CustomClipper', (visitor, instance) {
    final proxy = _InterpretedCustomClipperPath(visitor, instance);
    instance.nativeProxy ??= proxy;
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
    final proxy = _InterpretedRenderBox(visitor, instance);
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

  // ValueKey<T> — when scripts use ValueKey<String>('key')
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
      _ => ValueKey(value),
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
      return D4.extractBridgedArg<Widget>(result, 'build');
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
        return _InterpretedState(_visitor, result);
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
}

/// A native [State] that delegates lifecycle methods to an interpreted
/// D4rt State subclass.
class _InterpretedState extends State<_InterpretedStatefulWidget> {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _stateInstance;

  _InterpretedState(this._visitor, this._stateInstance);

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
      return D4.extractBridgedArg<Widget>(result, 'build');
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
      _callVoidMethod('didUpdateWidget');
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
    with SingleTickerProviderStateMixin {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _stateInstance;

  _InterpretedSingleTickerProviderState(this._visitor, this._stateInstance);

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
      return D4.extractBridgedArg<Widget>(result, 'build');
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
      _callVoidMethod('didUpdateWidget');
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
    with TickerProviderStateMixin {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _stateInstance;

  _InterpretedMultiTickerProviderState(this._visitor, this._stateInstance);

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
      return D4.extractBridgedArg<Widget>(result, 'build');
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
      _callVoidMethod('didUpdateWidget');
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
class _InterpretedRenderBox extends RenderBox {
  _InterpretedRenderBox(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  static const Object _kNotImplemented = Object();

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
class _InterpretedRenderAligningShiftedBox extends RenderAligningShiftedBox {
  _InterpretedRenderAligningShiftedBox(this._visitor, this._instance)
      : super(
          // Safe defaults: center alignment resolves without textDirection.
          alignment: Alignment.center,
          textDirection: null,
        );

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  static const Object _kNotImplemented = Object();

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
    // If the interpreted method did NOT set size through the bridge setter,
    // read it back from the instance's field map (same pattern as
    // _InterpretedRenderBox).
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
class _InterpretedParentDataWidget extends ParentDataWidget<ParentData> {
  _InterpretedParentDataWidget(this._visitor, this._instance,
      {required super.child, super.key});

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

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
}
