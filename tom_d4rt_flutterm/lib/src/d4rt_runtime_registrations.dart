/// Runtime registrations for D4rt bridge interface proxies, type coercions,
/// and generic constructor factories.
///
/// These registrations enable D4rt script classes to:
/// - Implement native interfaces (RC-1: TickerProvider, CustomClipper)
/// - Pass cross-package types transparently (RC-3: TextStyle, StrutStyle)
/// - Construct generic classes with type arguments (RC-2: GlobalKey)
library;

import 'dart:ui' as ui
    show
        FontStyle,
        FontWeight,
        Path,
        Size,
        StrutStyle,
        TextLeadingDistribution,
        TextStyle;

import 'package:flutter/foundation.dart'
    show ChangeNotifier, Key, ValueKey, ValueNotifier;
import 'package:flutter/material.dart' show ScaffoldState;
import 'package:flutter/painting.dart' as painting
    show StrutStyle, TextStyle;
import 'package:flutter/scheduler.dart' show Ticker, TickerProvider;
import 'package:flutter/rendering.dart' show CustomClipper;
import 'package:flutter/widgets.dart'
    show
        BuildContext,
        GlobalKey,
        NavigatorState,
        FormState,
        State,
        StatefulWidget,
        StatelessWidget,
        Widget;
import 'package:tom_d4rt_exec/d4rt.dart' show D4;
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart'
    show BridgedInstance;
import 'package:tom_d4rt_ast/src/runtime/interpreter_visitor.dart';
import 'package:tom_d4rt_ast/src/runtime/runtime_types.dart';

/// Register all runtime registrations (interface proxies, type coercions,
/// generic constructor factories).
///
/// Call this once during bridge setup, alongside [registerGenericTypeRelaxers].
void registerD4rtRuntimeExtensions() {
  _registerInterfaceProxies();
  _registerTypeCoercions();
  _registerGenericConstructors();
  _registerSupplementaryMethods();
}

// =============================================================================
// RC-1: Interface Proxy Registrations
// =============================================================================

void _registerInterfaceProxies() {
  // TickerProvider — used by AnimationController(vsync: ...)
  D4.registerInterfaceProxy('TickerProvider', (visitor, instance) {
    return _InterpretedTickerProvider(visitor, instance);
  });

  // CustomClipper<Path> — used by ClipPath(clipper: ...), ClipRRect(clipper: ...)
  D4.registerInterfaceProxy('CustomClipper', (visitor, instance) {
    return _InterpretedCustomClipper(visitor, instance);
  });

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

/// Native CustomClipper<Path> that delegates [getClip] and [shouldReclip]
/// to an interpreted D4rt class extending CustomClipper<Path>.
class _InterpretedCustomClipper extends CustomClipper<ui.Path> {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  _InterpretedCustomClipper(this._visitor, this._instance);

  @override
  ui.Path getClip(ui.Size size) {
    final method = _instance.klass.findInstanceMethod('getClip');
    if (method != null) {
      final bound = method.bind(_instance);
      final result = bound.call(_visitor, [size], {});
      return D4.extractBridgedArg<ui.Path>(result, 'getClip');
    }
    throw StateError(
      'Interpreted class ${_instance.klass.name} does not implement getClip',
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<ui.Path> oldClipper) {
    final method = _instance.klass.findInstanceMethod('shouldReclip');
    if (method != null) {
      final bound = method.bind(_instance);
      final result = bound.call(_visitor, [oldClipper], {});
      if (result is bool) return result;
    }
    // Default behavior: always reclip
    return true;
  }
}

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
  D4.registerGenericConstructor('GlobalKey', '', (visitor, positional, named, typeArgs) {
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
  D4.registerGenericConstructor('ValueKey', '', (visitor, positional, named, typeArgs) {
    final value = positional.isNotEmpty ? positional[0] : null;
    final typeName = typeArgs?.isNotEmpty == true ? typeArgs!.first.name : null;
    // Handle nullable type arguments: String? resolves to name 'String' but
    // value may be null. Use safe pattern matching instead of hard casts.
    return switch (typeName) {
      'String' => value is String
          ? ValueKey<String>(value)
          : ValueKey<String?>(value as String?),
      'int' => value is int
          ? ValueKey<int>(value)
          : ValueKey<int?>(value as int?),
      _ => ValueKey(value),
    };
  });

  // ValueNotifier<T> — respect explicit type arguments.
  // Without this, the bridge uses GEN-075 runtime-value-based inference
  // (e.g., ValueNotifier<dynamic>('start') creates ValueNotifier<String>
  // because 'start' is String), then .value = 42 fails.
  D4.registerGenericConstructor('ValueNotifier', '',
      (visitor, positional, named, typeArgs) {
    final value = positional.isNotEmpty ? positional[0] : null;
    final typeName = typeArgs?.isNotEmpty == true ? typeArgs!.first.name : null;
    return switch (typeName) {
      'dynamic' || 'Object' || 'Object?' => ValueNotifier<dynamic>(value),
      'String' => value is String
          ? ValueNotifier<String>(value)
          : ValueNotifier<String?>(value as String?),
      'int' => value is int
          ? ValueNotifier<int>(value)
          : ValueNotifier<int?>(value as int?),
      'double' => value is double
          ? ValueNotifier<double>(value)
          : ValueNotifier<double?>(value as double?),
      'bool' => value is bool
          ? ValueNotifier<bool>(value)
          : ValueNotifier<bool?>(value as bool?),
      _ => null, // Fall through to regular bridge constructor
    };
  });

  // RC-3: StrutStyle constructor override.
  // The dart:ui.StrutStyle bridge creates an opaque object (no getters).
  // When a D4rt script imports 'dart:ui', it gets dart:ui.StrutStyle, but
  // TextPainter etc. expect painting.StrutStyle. Since painting.StrutStyle
  // has full getters, we always create it here. The existing painting→dart:ui
  // coercion handles the reverse direction when dart:ui APIs need it.
  D4.registerGenericConstructor('StrutStyle', '',
      (visitor, positional, named, typeArgs) {
    return painting.StrutStyle(
      fontFamily: D4.extractBridgedArgOrNull<String>(
          named['fontFamily'], 'fontFamily'),
      fontFamilyFallback: D4.coerceListOrNull<String>(
          named['fontFamilyFallback'], 'fontFamilyFallback'),
      fontSize: D4.extractBridgedArgOrNull<double>(
          named['fontSize'], 'fontSize'),
      height:
          D4.extractBridgedArgOrNull<double>(named['height'], 'height'),
      leadingDistribution:
          D4.extractBridgedArgOrNull<ui.TextLeadingDistribution>(
              named['leadingDistribution'], 'leadingDistribution'),
      leading:
          D4.extractBridgedArgOrNull<double>(named['leading'], 'leading'),
      fontWeight: D4.extractBridgedArgOrNull<ui.FontWeight>(
          named['fontWeight'], 'fontWeight'),
      fontStyle: D4.extractBridgedArgOrNull<ui.FontStyle>(
          named['fontStyle'], 'fontStyle'),
      forceStrutHeight: D4.extractBridgedArgOrNull<bool>(
          named['forceStrutHeight'], 'forceStrutHeight'),
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

  const _InterpretedStatelessWidget(
    this._visitor,
    this._instance, {
    super.key,
  });

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

  const _InterpretedStatefulWidget(
    this._visitor,
    this._instance, {
    super.key,
  });

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
        return _InterpretedState(_visitor, result, this);
      }
    }
    throw StateError(
      'Interpreted class ${_instance.klass.name} does not implement createState()',
    );
  }
}

/// A native [State] that delegates lifecycle methods to an interpreted
/// D4rt State subclass.
class _InterpretedState extends State<_InterpretedStatefulWidget> {
  final InterpreterVisitor _visitor;
  final InterpretedInstance _stateInstance;

  _InterpretedState(this._visitor, this._stateInstance, _InterpretedStatefulWidget parentWidget);

  @override
  void initState() {
    super.initState();
    _callVoidMethod('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _callVoidMethod('didChangeDependencies');
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
    super.didUpdateWidget(oldWidget);
    _callVoidMethod('didUpdateWidget');
  }

  @override
  void deactivate() {
    _callVoidMethod('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    _callVoidMethod('dispose');
    super.dispose();
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
}

// =============================================================================
// Supplementary Methods
// =============================================================================

/// Register supplementary method adapters for @protected or otherwise missing
/// methods that the bridge generator skips but interpreted subclasses need.
void _registerSupplementaryMethods() {
  // ChangeNotifier.notifyListeners — @protected, not in generated bridge
  D4.registerSupplementaryMethod('ChangeNotifier', 'notifyListeners',
      (visitor, target, positionalArgs, namedArgs, typeArgs) {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    final cn = target as ChangeNotifier;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    cn.notifyListeners();
    return null;
  });

  // ChangeNotifier.hasListeners — @protected getter
  D4.registerSupplementaryMethod('ChangeNotifier', 'hasListeners',
      (visitor, target, positionalArgs, namedArgs, typeArgs) {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    final cn = target as ChangeNotifier;
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    return cn.hasListeners;
  });
}
