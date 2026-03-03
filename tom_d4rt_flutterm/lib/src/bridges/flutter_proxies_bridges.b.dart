// D4rt Bridge - Proxy class bridges for abstract delegates
// Generated proxy bridges for GEN-083: proxy class generation
// Generated: 2026-03-03

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';

import 'package:flutter/rendering.dart';
import 'flutter_proxies.b.dart';

/// D4rt Bridge Registration for proxy classes.
///
/// These bridges enable D4rt scripts to construct proxy/adapter
/// subclasses of abstract delegates (CustomPainter, CustomClipper, etc.)
/// by passing callback functions for abstract methods.
class FlutterProxiesBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createD4rtCustomPainterBridge(),
      _createD4rtCustomClipperBridge(),
      _createD4rtFlowDelegateBridge(),
      _createD4rtMultiChildLayoutDelegateBridge(),
      _createD4rtSingleChildLayoutDelegateBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  static Map<String, String> classSourceUris() {
    return {
      'D4rtCustomPainter': 'package:tom_d4rt_flutterm/src/bridges/flutter_proxies.b.dart',
      'D4rtCustomClipper': 'package:tom_d4rt_flutterm/src/bridges/flutter_proxies.b.dart',
      'D4rtFlowDelegate': 'package:tom_d4rt_flutterm/src/bridges/flutter_proxies.b.dart',
      'D4rtMultiChildLayoutDelegate': 'package:tom_d4rt_flutterm/src/bridges/flutter_proxies.b.dart',
      'D4rtSingleChildLayoutDelegate': 'package:tom_d4rt_flutterm/src/bridges/flutter_proxies.b.dart',
    };
  }

  /// Returns sub-package barrel URIs for this bridge module.
  static List<String> subPackageBarrels() {
    return [
      'package:flutter/rendering.dart',
    ];
  }

  /// Returns the import block for this bridge module.
  static String getImportBlock() {
    return "import 'package:flutter/rendering.dart';";
  }

  /// Registers all proxy bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:flutter/rendering.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    final classes = bridgeClasses();
    final classSources = classSourceUris();
    for (final bridge in classes) {
      interpreter.registerBridgedClass(bridge, importPath, sourceUri: classSources[bridge.name]);
    }
  }
}

// =============================================================================
// D4rtCustomPainter Bridge
// =============================================================================

BridgedClass _createD4rtCustomPainterBridge() {
  return BridgedClass(
    nativeType: D4rtCustomPainter,
    name: 'D4rtCustomPainter',
    isAssignable: (v) => v is D4rtCustomPainter,
    constructors: {
      '': (visitor, positional, named) {
        final onPaintRaw = D4.getRequiredNamedArg<Object>(named, 'onPaint', 'D4rtCustomPainter');
        final onShouldRepaintRaw = D4.getRequiredNamedArg<Object>(named, 'onShouldRepaint', 'D4rtCustomPainter');
        return D4rtCustomPainter(
          onPaint: (Canvas canvas, Size size) {
            D4.callInterpreterCallback(visitor, onPaintRaw, [canvas, size]);
          },
          onShouldRepaint: (CustomPainter oldDelegate) {
            return D4.callInterpreterCallback(visitor, onShouldRepaintRaw, [oldDelegate]) as bool;
          },
        );
      },
    },
    getters: {
      'onPaint': (visitor, target) => D4.validateTarget<D4rtCustomPainter>(target, 'D4rtCustomPainter').onPaint,
      'onShouldRepaint': (visitor, target) => D4.validateTarget<D4rtCustomPainter>(target, 'D4rtCustomPainter').onShouldRepaint,
    },
    methods: {
      'paint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCustomPainter>(target, 'D4rtCustomPainter');
        D4.requireMinArgs(positional, 2, 'paint');
        final canvas = D4.getRequiredArg<Canvas>(positional, 0, 'canvas', 'paint');
        final size = D4.getRequiredArg<Size>(positional, 1, 'size', 'paint');
        t.paint(canvas, size);
        return null;
      },
      'shouldRepaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCustomPainter>(target, 'D4rtCustomPainter');
        D4.requireMinArgs(positional, 1, 'shouldRepaint');
        final oldDelegate = D4.getRequiredArg<CustomPainter>(positional, 0, 'oldDelegate', 'shouldRepaint');
        return t.shouldRepaint(oldDelegate);
      },
    },
    constructorSignatures: {
      '': 'D4rtCustomPainter({required void Function(Canvas, Size) onPaint, required bool Function(CustomPainter) onShouldRepaint})',
    },
    methodSignatures: {
      'paint': 'void paint(Canvas canvas, Size size)',
      'shouldRepaint': 'bool shouldRepaint(CustomPainter oldDelegate)',
    },
    getterSignatures: {
      'onPaint': 'void Function(Canvas, Size) get onPaint',
      'onShouldRepaint': 'bool Function(CustomPainter) get onShouldRepaint',
    },
  );
}

// =============================================================================
// D4rtCustomClipper Bridge
// =============================================================================

BridgedClass _createD4rtCustomClipperBridge() {
  return BridgedClass(
    nativeType: D4rtCustomClipper,
    name: 'D4rtCustomClipper',
    isAssignable: (v) => v is D4rtCustomClipper,
    constructors: {
      '': (visitor, positional, named) {
        final onGetClipRaw = D4.getRequiredNamedArg<Object>(named, 'onGetClip', 'D4rtCustomClipper');
        final onShouldReclipRaw = D4.getRequiredNamedArg<Object>(named, 'onShouldReclip', 'D4rtCustomClipper');
        return D4rtCustomClipper<Rect>(
          onGetClip: (Size size) {
            return D4.callInterpreterCallback(visitor, onGetClipRaw, [size]) as Rect;
          },
          onShouldReclip: (CustomClipper<Rect> oldClipper) {
            return D4.callInterpreterCallback(visitor, onShouldReclipRaw, [oldClipper]) as bool;
          },
        );
      },
      'rect': (visitor, positional, named) {
        final onGetClipRaw = D4.getRequiredNamedArg<Object>(named, 'onGetClip', 'D4rtCustomClipper.rect');
        final onShouldReclipRaw = D4.getRequiredNamedArg<Object>(named, 'onShouldReclip', 'D4rtCustomClipper.rect');
        return D4rtCustomClipper<Rect>(
          onGetClip: (Size size) {
            return D4.callInterpreterCallback(visitor, onGetClipRaw, [size]) as Rect;
          },
          onShouldReclip: (CustomClipper<Rect> oldClipper) {
            return D4.callInterpreterCallback(visitor, onShouldReclipRaw, [oldClipper]) as bool;
          },
        );
      },
      'path': (visitor, positional, named) {
        final onGetClipRaw = D4.getRequiredNamedArg<Object>(named, 'onGetClip', 'D4rtCustomClipper.path');
        final onShouldReclipRaw = D4.getRequiredNamedArg<Object>(named, 'onShouldReclip', 'D4rtCustomClipper.path');
        return D4rtCustomClipper<Path>(
          onGetClip: (Size size) {
            return D4.callInterpreterCallback(visitor, onGetClipRaw, [size]) as Path;
          },
          onShouldReclip: (CustomClipper<Path> oldClipper) {
            return D4.callInterpreterCallback(visitor, onShouldReclipRaw, [oldClipper]) as bool;
          },
        );
      },
    },
    getters: {
      'onGetClip': (visitor, target) => D4.validateTarget<D4rtCustomClipper>(target, 'D4rtCustomClipper').onGetClip,
      'onShouldReclip': (visitor, target) => D4.validateTarget<D4rtCustomClipper>(target, 'D4rtCustomClipper').onShouldReclip,
    },
    methods: {
      'getClip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCustomClipper>(target, 'D4rtCustomClipper');
        D4.requireMinArgs(positional, 1, 'getClip');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'getClip');
        return t.getClip(size);
      },
      'shouldReclip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCustomClipper>(target, 'D4rtCustomClipper');
        D4.requireMinArgs(positional, 1, 'shouldReclip');
        final oldClipper = D4.getRequiredArg<CustomClipper>(positional, 0, 'oldClipper', 'shouldReclip');
        return t.shouldReclip(oldClipper);
      },
    },
    constructorSignatures: {
      '': 'D4rtCustomClipper({required Rect Function(Size) onGetClip, required bool Function(CustomClipper<Rect>) onShouldReclip})',
      'rect': 'D4rtCustomClipper.rect({required Rect Function(Size) onGetClip, required bool Function(CustomClipper<Rect>) onShouldReclip})',
      'path': 'D4rtCustomClipper.path({required Path Function(Size) onGetClip, required bool Function(CustomClipper<Path>) onShouldReclip})',
    },
    methodSignatures: {
      'getClip': 'T getClip(Size size)',
      'shouldReclip': 'bool shouldReclip(CustomClipper<T> oldClipper)',
    },
    getterSignatures: {
      'onGetClip': 'T Function(Size) get onGetClip',
      'onShouldReclip': 'bool Function(CustomClipper<T>) get onShouldReclip',
    },
  );
}

// =============================================================================
// D4rtFlowDelegate Bridge
// =============================================================================

BridgedClass _createD4rtFlowDelegateBridge() {
  return BridgedClass(
    nativeType: D4rtFlowDelegate,
    name: 'D4rtFlowDelegate',
    isAssignable: (v) => v is D4rtFlowDelegate,
    constructors: {
      '': (visitor, positional, named) {
        final onPaintChildrenRaw = D4.getRequiredNamedArg<Object>(named, 'onPaintChildren', 'D4rtFlowDelegate');
        final onShouldRepaintRaw = D4.getRequiredNamedArg<Object>(named, 'onShouldRepaint', 'D4rtFlowDelegate');
        return D4rtFlowDelegate(
          onPaintChildren: (FlowPaintingContext context) {
            D4.callInterpreterCallback(visitor, onPaintChildrenRaw, [context]);
          },
          onShouldRepaint: (FlowDelegate oldDelegate) {
            return D4.callInterpreterCallback(visitor, onShouldRepaintRaw, [oldDelegate]) as bool;
          },
        );
      },
    },
    getters: {
      'onPaintChildren': (visitor, target) => D4.validateTarget<D4rtFlowDelegate>(target, 'D4rtFlowDelegate').onPaintChildren,
      'onShouldRepaint': (visitor, target) => D4.validateTarget<D4rtFlowDelegate>(target, 'D4rtFlowDelegate').onShouldRepaint,
    },
    methods: {
      'paintChildren': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtFlowDelegate>(target, 'D4rtFlowDelegate');
        D4.requireMinArgs(positional, 1, 'paintChildren');
        final context = D4.getRequiredArg<FlowPaintingContext>(positional, 0, 'context', 'paintChildren');
        t.paintChildren(context);
        return null;
      },
      'shouldRepaint': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtFlowDelegate>(target, 'D4rtFlowDelegate');
        D4.requireMinArgs(positional, 1, 'shouldRepaint');
        final oldDelegate = D4.getRequiredArg<FlowDelegate>(positional, 0, 'oldDelegate', 'shouldRepaint');
        return t.shouldRepaint(oldDelegate);
      },
    },
    constructorSignatures: {
      '': 'D4rtFlowDelegate({required void Function(FlowPaintingContext) onPaintChildren, required bool Function(FlowDelegate) onShouldRepaint})',
    },
    methodSignatures: {
      'paintChildren': 'void paintChildren(FlowPaintingContext context)',
      'shouldRepaint': 'bool shouldRepaint(FlowDelegate oldDelegate)',
    },
    getterSignatures: {
      'onPaintChildren': 'void Function(FlowPaintingContext) get onPaintChildren',
      'onShouldRepaint': 'bool Function(FlowDelegate) get onShouldRepaint',
    },
  );
}

// =============================================================================
// D4rtMultiChildLayoutDelegate Bridge
// =============================================================================

BridgedClass _createD4rtMultiChildLayoutDelegateBridge() {
  return BridgedClass(
    nativeType: D4rtMultiChildLayoutDelegate,
    name: 'D4rtMultiChildLayoutDelegate',
    isAssignable: (v) => v is D4rtMultiChildLayoutDelegate,
    constructors: {
      '': (visitor, positional, named) {
        final onPerformLayoutRaw = D4.getRequiredNamedArg<Object>(named, 'onPerformLayout', 'D4rtMultiChildLayoutDelegate');
        final onShouldRelayoutRaw = D4.getRequiredNamedArg<Object>(named, 'onShouldRelayout', 'D4rtMultiChildLayoutDelegate');
        return D4rtMultiChildLayoutDelegate(
          onPerformLayout: (Size size) {
            D4.callInterpreterCallback(visitor, onPerformLayoutRaw, [size]);
          },
          onShouldRelayout: (MultiChildLayoutDelegate oldDelegate) {
            return D4.callInterpreterCallback(visitor, onShouldRelayoutRaw, [oldDelegate]) as bool;
          },
        );
      },
    },
    getters: {
      'onPerformLayout': (visitor, target) => D4.validateTarget<D4rtMultiChildLayoutDelegate>(target, 'D4rtMultiChildLayoutDelegate').onPerformLayout,
      'onShouldRelayout': (visitor, target) => D4.validateTarget<D4rtMultiChildLayoutDelegate>(target, 'D4rtMultiChildLayoutDelegate').onShouldRelayout,
    },
    methods: {
      'performLayout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtMultiChildLayoutDelegate>(target, 'D4rtMultiChildLayoutDelegate');
        D4.requireMinArgs(positional, 1, 'performLayout');
        final size = D4.getRequiredArg<Size>(positional, 0, 'size', 'performLayout');
        t.performLayout(size);
        return null;
      },
      'shouldRelayout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtMultiChildLayoutDelegate>(target, 'D4rtMultiChildLayoutDelegate');
        D4.requireMinArgs(positional, 1, 'shouldRelayout');
        final oldDelegate = D4.getRequiredArg<MultiChildLayoutDelegate>(positional, 0, 'oldDelegate', 'shouldRelayout');
        return t.shouldRelayout(oldDelegate);
      },
    },
    constructorSignatures: {
      '': 'D4rtMultiChildLayoutDelegate({required void Function(Size) onPerformLayout, required bool Function(MultiChildLayoutDelegate) onShouldRelayout})',
    },
    methodSignatures: {
      'performLayout': 'void performLayout(Size size)',
      'shouldRelayout': 'bool shouldRelayout(MultiChildLayoutDelegate oldDelegate)',
    },
    getterSignatures: {
      'onPerformLayout': 'void Function(Size) get onPerformLayout',
      'onShouldRelayout': 'bool Function(MultiChildLayoutDelegate) get onShouldRelayout',
    },
  );
}

// =============================================================================
// D4rtSingleChildLayoutDelegate Bridge
// =============================================================================

BridgedClass _createD4rtSingleChildLayoutDelegateBridge() {
  return BridgedClass(
    nativeType: D4rtSingleChildLayoutDelegate,
    name: 'D4rtSingleChildLayoutDelegate',
    isAssignable: (v) => v is D4rtSingleChildLayoutDelegate,
    constructors: {
      '': (visitor, positional, named) {
        final onShouldRelayoutRaw = D4.getRequiredNamedArg<Object>(named, 'onShouldRelayout', 'D4rtSingleChildLayoutDelegate');
        return D4rtSingleChildLayoutDelegate(
          onShouldRelayout: (SingleChildLayoutDelegate oldDelegate) {
            return D4.callInterpreterCallback(visitor, onShouldRelayoutRaw, [oldDelegate]) as bool;
          },
        );
      },
    },
    getters: {
      'onShouldRelayout': (visitor, target) => D4.validateTarget<D4rtSingleChildLayoutDelegate>(target, 'D4rtSingleChildLayoutDelegate').onShouldRelayout,
    },
    methods: {
      'shouldRelayout': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtSingleChildLayoutDelegate>(target, 'D4rtSingleChildLayoutDelegate');
        D4.requireMinArgs(positional, 1, 'shouldRelayout');
        final oldDelegate = D4.getRequiredArg<SingleChildLayoutDelegate>(positional, 0, 'oldDelegate', 'shouldRelayout');
        return t.shouldRelayout(oldDelegate);
      },
    },
    constructorSignatures: {
      '': 'D4rtSingleChildLayoutDelegate({required bool Function(SingleChildLayoutDelegate) onShouldRelayout})',
    },
    methodSignatures: {
      'shouldRelayout': 'bool shouldRelayout(SingleChildLayoutDelegate oldDelegate)',
    },
    getterSignatures: {
      'onShouldRelayout': 'bool Function(SingleChildLayoutDelegate) get onShouldRelayout',
    },
  );
}
