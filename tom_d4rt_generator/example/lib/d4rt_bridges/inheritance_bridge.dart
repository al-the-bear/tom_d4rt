// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/lib/test_classes/inheritance_classes.dart
// Generated: 2026-01-28T12:35:50.923126

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4rt_generator_example/test_classes.dart' as $pkg;

/// Bridge class for Inheritance module.
class InheritanceBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createCircleBridge(),
      _createRectangleBridge(),
      _createPointBridge(),
      _createColoredRectangleBridge(),
    ];
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes
    for (final bridge in bridgeClasses()) {
      interpreter.registerBridgedClass(bridge, importPath);
    }
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4rt_generator_example/test_classes.dart';";
  }

}

// =============================================================================
// Circle Bridge
// =============================================================================

BridgedClass _createCircleBridge() {
  return BridgedClass(
    nativeType: $pkg.Circle,
    name: 'Circle',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Circle');
        final radius = D4.getRequiredArg<double>(positional, 0, 'radius', 'Circle');
        return $pkg.Circle(radius);
      },
    },
    getters: {
      'radius': (visitor, target) => D4.validateTarget<$pkg.Circle>(target, 'Circle').radius,
      'name': (visitor, target) => D4.validateTarget<$pkg.Circle>(target, 'Circle').name,
      'diameter': (visitor, target) => D4.validateTarget<$pkg.Circle>(target, 'Circle').diameter,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Circle>(target, 'Circle');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Circle>(target, 'Circle');
        return t.perimeter();
      },
    },
  );
}

// =============================================================================
// Rectangle Bridge
// =============================================================================

BridgedClass _createRectangleBridge() {
  return BridgedClass(
    nativeType: $pkg.Rectangle,
    name: 'Rectangle',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Rectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'Rectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'Rectangle');
        return $pkg.Rectangle(width, height);
      },
      'square': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Rectangle');
        final side = D4.getRequiredArg<double>(positional, 0, 'side', 'Rectangle');
        return $pkg.Rectangle.square(side);
      },
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').width,
      'height': (visitor, target) => D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').height,
      'name': (visitor, target) => D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').name,
      'isSquare': (visitor, target) => D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').isSquare,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle');
        return t.perimeter();
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle');
        return t.describe();
      },
    },
  );
}

// =============================================================================
// Point Bridge
// =============================================================================

BridgedClass _createPointBridge() {
  return BridgedClass(
    nativeType: $pkg.Point,
    name: 'Point',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Point');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Point');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Point');
        return $pkg.Point(x, y);
      },
      'origin': (visitor, positional, named) {
        return $pkg.Point.origin();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$pkg.Point>(target, 'Point').x,
      'y': (visitor, target) => D4.validateTarget<$pkg.Point>(target, 'Point').y,
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Point>(target, 'Point');
        return t.toJson();
      },
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Point>(target, 'Point');
        return t.clone();
      },
      'distanceTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Point>(target, 'Point');
        D4.requireMinArgs(positional, 1, 'distanceTo');
        final other = D4.getRequiredArg<$pkg.Point>(positional, 0, 'other', 'distanceTo');
        return t.distanceTo(other);
      },
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Point>(target, 'Point');
        D4.requireMinArgs(positional, 1, 'add');
        final other = D4.getRequiredArg<$pkg.Point>(positional, 0, 'other', 'add');
        return t.add(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Point>(target, 'Point');
        return t.toString();
      },
    },
    staticMethods: {
      'fromJson': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromJson');
        if (positional.length <= 0) {
          throw ArgumentError('fromJson: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.Point.fromJson(json);
      },
    },
  );
}

// =============================================================================
// ColoredRectangle Bridge
// =============================================================================

BridgedClass _createColoredRectangleBridge() {
  return BridgedClass(
    nativeType: $pkg.ColoredRectangle,
    name: 'ColoredRectangle',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'ColoredRectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'ColoredRectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'ColoredRectangle');
        final color = D4.getRequiredArg<String>(positional, 2, 'color', 'ColoredRectangle');
        return $pkg.ColoredRectangle(width, height, color);
      },
      'red': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'ColoredRectangle');
        final width = D4.getRequiredArg<double>(positional, 0, 'width', 'ColoredRectangle');
        final height = D4.getRequiredArg<double>(positional, 1, 'height', 'ColoredRectangle');
        return $pkg.ColoredRectangle.red(width, height);
      },
    },
    getters: {
      'width': (visitor, target) => D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle').width,
      'height': (visitor, target) => D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle').height,
      'name': (visitor, target) => D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle').name,
      'isSquare': (visitor, target) => D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle').isSquare,
      'color': (visitor, target) => D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle').color,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle');
        return t.perimeter();
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle');
        return t.describe();
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle');
        return t.toJson();
      },
    },
  );
}

