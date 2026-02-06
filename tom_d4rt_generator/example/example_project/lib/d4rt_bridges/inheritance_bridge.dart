// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/example_project/lib/test_classes/inheritance_classes.dart
// Generated: 2026-02-06T08:25:25.336238

// ignore_for_file: unused_import, deprecated_member_use

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4rt_generator_example/test_classes.dart' as $pkg;

/// Bridge class for Inheritance module.
class InheritanceBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createShapeBridge(),
      _createCircleBridge(),
      _createRectangleBridge(),
      _createSerializableBridge(),
      _createCloneableBridge(),
      _createPointBridge(),
      _createColoredRectangleBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Shape': 'package:d4rt_generator_example/test_classes/inheritance_classes.dart',
      'Circle': 'package:d4rt_generator_example/test_classes/inheritance_classes.dart',
      'Rectangle': 'package:d4rt_generator_example/test_classes/inheritance_classes.dart',
      'Serializable': 'package:d4rt_generator_example/test_classes/inheritance_classes.dart',
      'Cloneable': 'package:d4rt_generator_example/test_classes/inheritance_classes.dart',
      'Point': 'package:d4rt_generator_example/test_classes/inheritance_classes.dart',
      'ColoredRectangle': 'package:d4rt_generator_example/test_classes/inheritance_classes.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
    };
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes with source URIs for deduplication
    final classes = bridgeClasses();
    final classSources = classSourceUris();
    for (final bridge in classes) {
      interpreter.registerBridgedClass(bridge, importPath, sourceUri: classSources[bridge.name]);
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {};
  }

  /// Returns a map of global function names to their canonical source URIs.
  static Map<String, String> globalFunctionSourceUris() {
    return {};
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {};
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:d4rt_generator_example/test_classes/inheritance_classes.dart',
    ];
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
// Shape Bridge
// =============================================================================

BridgedClass _createShapeBridge() {
  return BridgedClass(
    nativeType: $pkg.Shape,
    name: 'Shape',
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Shape>(target, 'Shape').name,
    },
    methods: {
      'area': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shape>(target, 'Shape');
        return t.area();
      },
      'perimeter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shape>(target, 'Shape');
        return t.perimeter();
      },
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shape>(target, 'Shape');
        return t.describe();
      },
    },
    methodSignatures: {
      'area': 'double area()',
      'perimeter': 'double perimeter()',
      'describe': 'String describe()',
    },
    getterSignatures: {
      'name': 'String get name',
    },
  );
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
      'name': (visitor, target) => D4.validateTarget<$pkg.Circle>(target, 'Circle').name,
      'radius': (visitor, target) => D4.validateTarget<$pkg.Circle>(target, 'Circle').radius,
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
      'describe': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Circle>(target, 'Circle');
        return t.describe();
      },
    },
    constructorSignatures: {
      '': 'Circle(double radius)',
    },
    methodSignatures: {
      'area': 'double area()',
      'perimeter': 'double perimeter()',
      'describe': 'String describe()',
    },
    getterSignatures: {
      'name': 'String get name',
      'radius': 'double get radius',
      'diameter': 'double get diameter',
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
      'name': (visitor, target) => D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').name,
      'width': (visitor, target) => D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').width,
      'height': (visitor, target) => D4.validateTarget<$pkg.Rectangle>(target, 'Rectangle').height,
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
    constructorSignatures: {
      '': 'Rectangle(double width, double height)',
      'square': 'Rectangle.square(double side)',
    },
    methodSignatures: {
      'area': 'double area()',
      'perimeter': 'double perimeter()',
      'describe': 'String describe()',
    },
    getterSignatures: {
      'name': 'String get name',
      'width': 'double get width',
      'height': 'double get height',
      'isSquare': 'bool get isSquare',
    },
  );
}

// =============================================================================
// Serializable Bridge
// =============================================================================

BridgedClass _createSerializableBridge() {
  return BridgedClass(
    nativeType: $pkg.Serializable,
    name: 'Serializable',
    constructors: {
    },
    methods: {
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Serializable>(target, 'Serializable');
        return t.toJson();
      },
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
    },
  );
}

// =============================================================================
// Cloneable Bridge
// =============================================================================

BridgedClass _createCloneableBridge() {
  return BridgedClass(
    nativeType: $pkg.Cloneable,
    name: 'Cloneable',
    constructors: {
    },
    methods: {
      'clone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Cloneable>(target, 'Cloneable');
        return t.clone();
      },
    },
    methodSignatures: {
      'clone': 'T clone()',
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
        if (positional.isEmpty) {
          throw ArgumentError('fromJson: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.Point.fromJson(json);
      },
    },
    constructorSignatures: {
      '': 'Point(double x, double y)',
      'origin': 'Point.origin()',
    },
    methodSignatures: {
      'toJson': 'Map<String, dynamic> toJson()',
      'clone': 'Point clone()',
      'distanceTo': 'double distanceTo(Point other)',
      'add': 'Point add(Point other)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'x': 'double get x',
      'y': 'double get y',
    },
    staticMethodSignatures: {
      'fromJson': 'Point fromJson(Map<String, dynamic> json)',
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
      'name': (visitor, target) => D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle').name,
      'width': (visitor, target) => D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle').width,
      'height': (visitor, target) => D4.validateTarget<$pkg.ColoredRectangle>(target, 'ColoredRectangle').height,
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
    constructorSignatures: {
      '': 'ColoredRectangle(double width, double height, String color)',
      'red': 'ColoredRectangle.red(double width, double height)',
    },
    methodSignatures: {
      'area': 'double area()',
      'perimeter': 'double perimeter()',
      'describe': 'String describe()',
      'toJson': 'Map<String, dynamic> toJson()',
    },
    getterSignatures: {
      'name': 'String get name',
      'width': 'double get width',
      'height': 'double get height',
      'isSquare': 'bool get isSquare',
      'color': 'String get color',
    },
  );
}

