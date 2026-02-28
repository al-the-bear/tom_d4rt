// D4rt Bridge - Generated file, do not edit
// Sources: 7 files
// Generated: 2026-02-28T12:38:50.755009

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/tom_d4rt_ast.dart';
import 'dart:ui' as $dart_ui;
import 'dart:ui';

import 'package:flutter/src/physics/clamped_simulation.dart' as $flutter_1;
import 'package:flutter/src/physics/friction_simulation.dart' as $flutter_2;
import 'package:flutter/src/physics/gravity_simulation.dart' as $flutter_3;
import 'package:flutter/src/physics/simulation.dart' as $flutter_4;
import 'package:flutter/src/physics/spring_simulation.dart' as $flutter_5;
import 'package:flutter/src/physics/tolerance.dart' as $flutter_6;
import 'package:flutter/src/physics/utils.dart' as $flutter_7;

/// Bridge class for flutter_physics module.
class FlutterPhysicsBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createToleranceBridge(),
      _createSimulationBridge(),
      _createClampedSimulationBridge(),
      _createFrictionSimulationBridge(),
      _createBoundedFrictionSimulationBridge(),
      _createGravitySimulationBridge(),
      _createSpringDescriptionBridge(),
      _createSpringSimulationBridge(),
      _createScrollSpringSimulationBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Tolerance': 'package:flutter/src/physics/tolerance.dart',
      'Simulation': 'package:flutter/src/physics/simulation.dart',
      'ClampedSimulation': 'package:flutter/src/physics/clamped_simulation.dart',
      'FrictionSimulation': 'package:flutter/src/physics/friction_simulation.dart',
      'BoundedFrictionSimulation': 'package:flutter/src/physics/friction_simulation.dart',
      'GravitySimulation': 'package:flutter/src/physics/gravity_simulation.dart',
      'SpringDescription': 'package:flutter/src/physics/spring_simulation.dart',
      'SpringSimulation': 'package:flutter/src/physics/spring_simulation.dart',
      'ScrollSpringSimulation': 'package:flutter/src/physics/spring_simulation.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$flutter_5.SpringType>(
        name: 'SpringType',
        values: $flutter_5.SpringType.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'SpringType': 'package:flutter/src/physics/spring_simulation.dart',
    };
  }

  /// Returns all bridged extension definitions.
  static List<BridgedExtensionDefinition> bridgedExtensions() {
    return [
    ];
  }

  /// Returns a map of extension identifiers to their canonical source URIs.
  static Map<String, String> extensionSourceUris() {
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

    // Register bridged enums with source URIs for deduplication
    final enums = bridgedEnums();
    final enumSources = enumSourceUris();
    for (final enumDef in enums) {
      interpreter.registerBridgedEnum(enumDef, importPath, sourceUri: enumSources[enumDef.name]);
    }

    // Register global functions with source URIs for deduplication
    final funcs = globalFunctions();
    final funcSources = globalFunctionSourceUris();
    final funcSigs = globalFunctionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'nearEqual': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'nearEqual');
        final a = D4.getRequiredArg<double?>(positional, 0, 'a', 'nearEqual');
        final b = D4.getRequiredArg<double?>(positional, 1, 'b', 'nearEqual');
        final epsilon = D4.getRequiredArg<double>(positional, 2, 'epsilon', 'nearEqual');
        return $flutter_7.nearEqual(a, b, epsilon);
      },
      'nearZero': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'nearZero');
        final a = D4.getRequiredArg<double>(positional, 0, 'a', 'nearZero');
        final epsilon = D4.getRequiredArg<double>(positional, 1, 'epsilon', 'nearZero');
        return $flutter_7.nearZero(a, epsilon);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'nearEqual': 'package:flutter/src/physics/utils.dart',
      'nearZero': 'package:flutter/src/physics/utils.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'nearEqual': 'bool nearEqual(double? a, double? b, double epsilon)',
      'nearZero': 'bool nearZero(double a, double epsilon)',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:flutter/src/physics/clamped_simulation.dart',
      'package:flutter/src/physics/friction_simulation.dart',
      'package:flutter/src/physics/gravity_simulation.dart',
      'package:flutter/src/physics/simulation.dart',
      'package:flutter/src/physics/spring_simulation.dart',
      'package:flutter/src/physics/tolerance.dart',
      'package:flutter/src/physics/utils.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:flutter/physics.dart';";
  }

  /// Returns barrel import URIs for sub-packages discovered through re-exports.
  ///
  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports
  /// dcli_core), D4rt scripts may import those sub-packages directly.
  /// These barrels need to be registered with the interpreter separately
  /// so that module resolution finds content for those URIs.
  static List<String> subPackageBarrels() {
    return [];
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'SpringType',
  ];

}

// =============================================================================
// Tolerance Bridge
// =============================================================================

BridgedClass _createToleranceBridge() {
  return BridgedClass(
    nativeType: $flutter_6.Tolerance,
    name: 'Tolerance',
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('distance') && !named.containsKey('time') && !named.containsKey('velocity')) {
          return $flutter_6.Tolerance();
        }
        if (named.containsKey('distance') && !named.containsKey('time') && !named.containsKey('velocity')) {
          final distance = D4.getRequiredNamedArg<double>(named, 'distance', 'Tolerance');
          return $flutter_6.Tolerance(distance: distance);
        }
        if (!named.containsKey('distance') && named.containsKey('time') && !named.containsKey('velocity')) {
          final time = D4.getRequiredNamedArg<double>(named, 'time', 'Tolerance');
          return $flutter_6.Tolerance(time: time);
        }
        if (named.containsKey('distance') && named.containsKey('time') && !named.containsKey('velocity')) {
          final distance = D4.getRequiredNamedArg<double>(named, 'distance', 'Tolerance');
          final time = D4.getRequiredNamedArg<double>(named, 'time', 'Tolerance');
          return $flutter_6.Tolerance(distance: distance, time: time);
        }
        if (!named.containsKey('distance') && !named.containsKey('time') && named.containsKey('velocity')) {
          final velocity = D4.getRequiredNamedArg<double>(named, 'velocity', 'Tolerance');
          return $flutter_6.Tolerance(velocity: velocity);
        }
        if (named.containsKey('distance') && !named.containsKey('time') && named.containsKey('velocity')) {
          final distance = D4.getRequiredNamedArg<double>(named, 'distance', 'Tolerance');
          final velocity = D4.getRequiredNamedArg<double>(named, 'velocity', 'Tolerance');
          return $flutter_6.Tolerance(distance: distance, velocity: velocity);
        }
        if (!named.containsKey('distance') && named.containsKey('time') && named.containsKey('velocity')) {
          final time = D4.getRequiredNamedArg<double>(named, 'time', 'Tolerance');
          final velocity = D4.getRequiredNamedArg<double>(named, 'velocity', 'Tolerance');
          return $flutter_6.Tolerance(time: time, velocity: velocity);
        }
        if (named.containsKey('distance') && named.containsKey('time') && named.containsKey('velocity')) {
          final distance = D4.getRequiredNamedArg<double>(named, 'distance', 'Tolerance');
          final time = D4.getRequiredNamedArg<double>(named, 'time', 'Tolerance');
          final velocity = D4.getRequiredNamedArg<double>(named, 'velocity', 'Tolerance');
          return $flutter_6.Tolerance(distance: distance, time: time, velocity: velocity);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'distance': (visitor, target) => D4.validateTarget<$flutter_6.Tolerance>(target, 'Tolerance').distance,
      'time': (visitor, target) => D4.validateTarget<$flutter_6.Tolerance>(target, 'Tolerance').time,
      'velocity': (visitor, target) => D4.validateTarget<$flutter_6.Tolerance>(target, 'Tolerance').velocity,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_6.Tolerance>(target, 'Tolerance');
        return t.toString();
      },
    },
    staticGetters: {
      'defaultTolerance': (visitor) => $flutter_6.Tolerance.defaultTolerance,
    },
    constructorSignatures: {
      '': 'const Tolerance({double distance = _epsilonDefault, double time = _epsilonDefault, double velocity = _epsilonDefault})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'distance': 'double get distance',
      'time': 'double get time',
      'velocity': 'double get velocity',
    },
    staticGetterSignatures: {
      'defaultTolerance': 'Tolerance get defaultTolerance',
    },
  );
}

// =============================================================================
// Simulation Bridge
// =============================================================================

BridgedClass _createSimulationBridge() {
  return BridgedClass(
    nativeType: $flutter_4.Simulation,
    name: 'Simulation',
    constructors: {
    },
    getters: {
      'tolerance': (visitor, target) => D4.validateTarget<$flutter_4.Simulation>(target, 'Simulation').tolerance,
    },
    setters: {
      'tolerance': (visitor, target, value) => 
        D4.validateTarget<$flutter_4.Simulation>(target, 'Simulation').tolerance = value as $flutter_6.Tolerance,
    },
    methods: {
      'x': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.Simulation>(target, 'Simulation');
        D4.requireMinArgs(positional, 1, 'x');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'x');
        return t.x(time);
      },
      'dx': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.Simulation>(target, 'Simulation');
        D4.requireMinArgs(positional, 1, 'dx');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'dx');
        return t.dx(time);
      },
      'isDone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.Simulation>(target, 'Simulation');
        D4.requireMinArgs(positional, 1, 'isDone');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'isDone');
        return t.isDone(time);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_4.Simulation>(target, 'Simulation');
        return t.toString();
      },
    },
    methodSignatures: {
      'x': 'double x(double time)',
      'dx': 'double dx(double time)',
      'isDone': 'bool isDone(double time)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'tolerance': 'Tolerance get tolerance',
    },
    setterSignatures: {
      'tolerance': 'set tolerance(dynamic value)',
    },
  );
}

// =============================================================================
// ClampedSimulation Bridge
// =============================================================================

BridgedClass _createClampedSimulationBridge() {
  return BridgedClass(
    nativeType: $flutter_1.ClampedSimulation,
    name: 'ClampedSimulation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ClampedSimulation');
        final simulation = D4.getRequiredArg<$flutter_4.Simulation>(positional, 0, 'simulation', 'ClampedSimulation');
        if (!named.containsKey('xMin') && !named.containsKey('xMax') && !named.containsKey('dxMin') && !named.containsKey('dxMax')) {
          return $flutter_1.ClampedSimulation(simulation);
        }
        if (named.containsKey('xMin') && !named.containsKey('xMax') && !named.containsKey('dxMin') && !named.containsKey('dxMax')) {
          final xMin = D4.getRequiredNamedArg<double>(named, 'xMin', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMin: xMin);
        }
        if (!named.containsKey('xMin') && named.containsKey('xMax') && !named.containsKey('dxMin') && !named.containsKey('dxMax')) {
          final xMax = D4.getRequiredNamedArg<double>(named, 'xMax', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMax: xMax);
        }
        if (named.containsKey('xMin') && named.containsKey('xMax') && !named.containsKey('dxMin') && !named.containsKey('dxMax')) {
          final xMin = D4.getRequiredNamedArg<double>(named, 'xMin', 'ClampedSimulation');
          final xMax = D4.getRequiredNamedArg<double>(named, 'xMax', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMin: xMin, xMax: xMax);
        }
        if (!named.containsKey('xMin') && !named.containsKey('xMax') && named.containsKey('dxMin') && !named.containsKey('dxMax')) {
          final dxMin = D4.getRequiredNamedArg<double>(named, 'dxMin', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, dxMin: dxMin);
        }
        if (named.containsKey('xMin') && !named.containsKey('xMax') && named.containsKey('dxMin') && !named.containsKey('dxMax')) {
          final xMin = D4.getRequiredNamedArg<double>(named, 'xMin', 'ClampedSimulation');
          final dxMin = D4.getRequiredNamedArg<double>(named, 'dxMin', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMin: xMin, dxMin: dxMin);
        }
        if (!named.containsKey('xMin') && named.containsKey('xMax') && named.containsKey('dxMin') && !named.containsKey('dxMax')) {
          final xMax = D4.getRequiredNamedArg<double>(named, 'xMax', 'ClampedSimulation');
          final dxMin = D4.getRequiredNamedArg<double>(named, 'dxMin', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMax: xMax, dxMin: dxMin);
        }
        if (named.containsKey('xMin') && named.containsKey('xMax') && named.containsKey('dxMin') && !named.containsKey('dxMax')) {
          final xMin = D4.getRequiredNamedArg<double>(named, 'xMin', 'ClampedSimulation');
          final xMax = D4.getRequiredNamedArg<double>(named, 'xMax', 'ClampedSimulation');
          final dxMin = D4.getRequiredNamedArg<double>(named, 'dxMin', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMin: xMin, xMax: xMax, dxMin: dxMin);
        }
        if (!named.containsKey('xMin') && !named.containsKey('xMax') && !named.containsKey('dxMin') && named.containsKey('dxMax')) {
          final dxMax = D4.getRequiredNamedArg<double>(named, 'dxMax', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, dxMax: dxMax);
        }
        if (named.containsKey('xMin') && !named.containsKey('xMax') && !named.containsKey('dxMin') && named.containsKey('dxMax')) {
          final xMin = D4.getRequiredNamedArg<double>(named, 'xMin', 'ClampedSimulation');
          final dxMax = D4.getRequiredNamedArg<double>(named, 'dxMax', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMin: xMin, dxMax: dxMax);
        }
        if (!named.containsKey('xMin') && named.containsKey('xMax') && !named.containsKey('dxMin') && named.containsKey('dxMax')) {
          final xMax = D4.getRequiredNamedArg<double>(named, 'xMax', 'ClampedSimulation');
          final dxMax = D4.getRequiredNamedArg<double>(named, 'dxMax', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMax: xMax, dxMax: dxMax);
        }
        if (named.containsKey('xMin') && named.containsKey('xMax') && !named.containsKey('dxMin') && named.containsKey('dxMax')) {
          final xMin = D4.getRequiredNamedArg<double>(named, 'xMin', 'ClampedSimulation');
          final xMax = D4.getRequiredNamedArg<double>(named, 'xMax', 'ClampedSimulation');
          final dxMax = D4.getRequiredNamedArg<double>(named, 'dxMax', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMin: xMin, xMax: xMax, dxMax: dxMax);
        }
        if (!named.containsKey('xMin') && !named.containsKey('xMax') && named.containsKey('dxMin') && named.containsKey('dxMax')) {
          final dxMin = D4.getRequiredNamedArg<double>(named, 'dxMin', 'ClampedSimulation');
          final dxMax = D4.getRequiredNamedArg<double>(named, 'dxMax', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, dxMin: dxMin, dxMax: dxMax);
        }
        if (named.containsKey('xMin') && !named.containsKey('xMax') && named.containsKey('dxMin') && named.containsKey('dxMax')) {
          final xMin = D4.getRequiredNamedArg<double>(named, 'xMin', 'ClampedSimulation');
          final dxMin = D4.getRequiredNamedArg<double>(named, 'dxMin', 'ClampedSimulation');
          final dxMax = D4.getRequiredNamedArg<double>(named, 'dxMax', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMin: xMin, dxMin: dxMin, dxMax: dxMax);
        }
        if (!named.containsKey('xMin') && named.containsKey('xMax') && named.containsKey('dxMin') && named.containsKey('dxMax')) {
          final xMax = D4.getRequiredNamedArg<double>(named, 'xMax', 'ClampedSimulation');
          final dxMin = D4.getRequiredNamedArg<double>(named, 'dxMin', 'ClampedSimulation');
          final dxMax = D4.getRequiredNamedArg<double>(named, 'dxMax', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMax: xMax, dxMin: dxMin, dxMax: dxMax);
        }
        if (named.containsKey('xMin') && named.containsKey('xMax') && named.containsKey('dxMin') && named.containsKey('dxMax')) {
          final xMin = D4.getRequiredNamedArg<double>(named, 'xMin', 'ClampedSimulation');
          final xMax = D4.getRequiredNamedArg<double>(named, 'xMax', 'ClampedSimulation');
          final dxMin = D4.getRequiredNamedArg<double>(named, 'dxMin', 'ClampedSimulation');
          final dxMax = D4.getRequiredNamedArg<double>(named, 'dxMax', 'ClampedSimulation');
          return $flutter_1.ClampedSimulation(simulation, xMin: xMin, xMax: xMax, dxMin: dxMin, dxMax: dxMax);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'tolerance': (visitor, target) => D4.validateTarget<$flutter_1.ClampedSimulation>(target, 'ClampedSimulation').tolerance,
      'simulation': (visitor, target) => D4.validateTarget<$flutter_1.ClampedSimulation>(target, 'ClampedSimulation').simulation,
      'xMin': (visitor, target) => D4.validateTarget<$flutter_1.ClampedSimulation>(target, 'ClampedSimulation').xMin,
      'xMax': (visitor, target) => D4.validateTarget<$flutter_1.ClampedSimulation>(target, 'ClampedSimulation').xMax,
      'dxMin': (visitor, target) => D4.validateTarget<$flutter_1.ClampedSimulation>(target, 'ClampedSimulation').dxMin,
      'dxMax': (visitor, target) => D4.validateTarget<$flutter_1.ClampedSimulation>(target, 'ClampedSimulation').dxMax,
    },
    setters: {
      'tolerance': (visitor, target, value) => 
        D4.validateTarget<$flutter_1.ClampedSimulation>(target, 'ClampedSimulation').tolerance = value as $flutter_6.Tolerance,
    },
    methods: {
      'x': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.ClampedSimulation>(target, 'ClampedSimulation');
        D4.requireMinArgs(positional, 1, 'x');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'x');
        return t.x(time);
      },
      'dx': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.ClampedSimulation>(target, 'ClampedSimulation');
        D4.requireMinArgs(positional, 1, 'dx');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'dx');
        return t.dx(time);
      },
      'isDone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.ClampedSimulation>(target, 'ClampedSimulation');
        D4.requireMinArgs(positional, 1, 'isDone');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'isDone');
        return t.isDone(time);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_1.ClampedSimulation>(target, 'ClampedSimulation');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ClampedSimulation(Simulation simulation, {double xMin = double.negativeInfinity, double xMax = double.infinity, double dxMin = double.negativeInfinity, double dxMax = double.infinity})',
    },
    methodSignatures: {
      'x': 'double x(double time)',
      'dx': 'double dx(double time)',
      'isDone': 'bool isDone(double time)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'tolerance': 'Tolerance get tolerance',
      'simulation': 'Simulation get simulation',
      'xMin': 'double get xMin',
      'xMax': 'double get xMax',
      'dxMin': 'double get dxMin',
      'dxMax': 'double get dxMax',
    },
    setterSignatures: {
      'tolerance': 'set tolerance(dynamic value)',
    },
  );
}

// =============================================================================
// FrictionSimulation Bridge
// =============================================================================

BridgedClass _createFrictionSimulationBridge() {
  return BridgedClass(
    nativeType: $flutter_2.FrictionSimulation,
    name: 'FrictionSimulation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'FrictionSimulation');
        final drag = D4.getRequiredArg<double>(positional, 0, 'drag', 'FrictionSimulation');
        final position = D4.getRequiredArg<double>(positional, 1, 'position', 'FrictionSimulation');
        final velocity = D4.getRequiredArg<double>(positional, 2, 'velocity', 'FrictionSimulation');
        final tolerance = D4.getNamedArgWithDefault<$flutter_6.Tolerance>(named, 'tolerance', $flutter_6.Tolerance.defaultTolerance);
        final constantDeceleration = D4.getNamedArgWithDefault<double>(named, 'constantDeceleration', 0);
        return $flutter_2.FrictionSimulation(drag, position, velocity, tolerance: tolerance, constantDeceleration: constantDeceleration);
      },
      'through': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'FrictionSimulation');
        final startPosition = D4.getRequiredArg<double>(positional, 0, 'startPosition', 'FrictionSimulation');
        final endPosition = D4.getRequiredArg<double>(positional, 1, 'endPosition', 'FrictionSimulation');
        final startVelocity = D4.getRequiredArg<double>(positional, 2, 'startVelocity', 'FrictionSimulation');
        final endVelocity = D4.getRequiredArg<double>(positional, 3, 'endVelocity', 'FrictionSimulation');
        return $flutter_2.FrictionSimulation.through(startPosition, endPosition, startVelocity, endVelocity);
      },
    },
    getters: {
      'tolerance': (visitor, target) => D4.validateTarget<$flutter_2.FrictionSimulation>(target, 'FrictionSimulation').tolerance,
      'finalX': (visitor, target) => D4.validateTarget<$flutter_2.FrictionSimulation>(target, 'FrictionSimulation').finalX,
    },
    setters: {
      'tolerance': (visitor, target, value) => 
        D4.validateTarget<$flutter_2.FrictionSimulation>(target, 'FrictionSimulation').tolerance = value as $flutter_6.Tolerance,
    },
    methods: {
      'x': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FrictionSimulation>(target, 'FrictionSimulation');
        D4.requireMinArgs(positional, 1, 'x');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'x');
        return t.x(time);
      },
      'dx': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FrictionSimulation>(target, 'FrictionSimulation');
        D4.requireMinArgs(positional, 1, 'dx');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'dx');
        return t.dx(time);
      },
      'isDone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FrictionSimulation>(target, 'FrictionSimulation');
        D4.requireMinArgs(positional, 1, 'isDone');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'isDone');
        return t.isDone(time);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FrictionSimulation>(target, 'FrictionSimulation');
        return t.toString();
      },
      'timeAtX': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.FrictionSimulation>(target, 'FrictionSimulation');
        D4.requireMinArgs(positional, 1, 'timeAtX');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'timeAtX');
        return t.timeAtX(x);
      },
    },
    constructorSignatures: {
      '': 'FrictionSimulation(double drag, double position, double velocity, {Tolerance tolerance = Tolerance.defaultTolerance, double constantDeceleration = 0})',
      'through': 'factory FrictionSimulation.through(double startPosition, double endPosition, double startVelocity, double endVelocity)',
    },
    methodSignatures: {
      'x': 'double x(double time)',
      'dx': 'double dx(double time)',
      'isDone': 'bool isDone(double time)',
      'toString': 'String toString()',
      'timeAtX': 'double timeAtX(double x)',
    },
    getterSignatures: {
      'tolerance': 'Tolerance get tolerance',
      'finalX': 'double get finalX',
    },
    setterSignatures: {
      'tolerance': 'set tolerance(dynamic value)',
    },
  );
}

// =============================================================================
// BoundedFrictionSimulation Bridge
// =============================================================================

BridgedClass _createBoundedFrictionSimulationBridge() {
  return BridgedClass(
    nativeType: $flutter_2.BoundedFrictionSimulation,
    name: 'BoundedFrictionSimulation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 5, 'BoundedFrictionSimulation');
        final drag = D4.getRequiredArg<double>(positional, 0, 'drag', 'BoundedFrictionSimulation');
        final position = D4.getRequiredArg<double>(positional, 1, 'position', 'BoundedFrictionSimulation');
        final velocity = D4.getRequiredArg<double>(positional, 2, 'velocity', 'BoundedFrictionSimulation');
        final minX = D4.getRequiredArg<double>(positional, 3, '_minX', 'BoundedFrictionSimulation');
        final maxX = D4.getRequiredArg<double>(positional, 4, '_maxX', 'BoundedFrictionSimulation');
        return $flutter_2.BoundedFrictionSimulation(drag, position, velocity, minX, maxX);
      },
    },
    getters: {
      'tolerance': (visitor, target) => D4.validateTarget<$flutter_2.BoundedFrictionSimulation>(target, 'BoundedFrictionSimulation').tolerance,
      'finalX': (visitor, target) => D4.validateTarget<$flutter_2.BoundedFrictionSimulation>(target, 'BoundedFrictionSimulation').finalX,
    },
    setters: {
      'tolerance': (visitor, target, value) => 
        D4.validateTarget<$flutter_2.BoundedFrictionSimulation>(target, 'BoundedFrictionSimulation').tolerance = value as $flutter_6.Tolerance,
    },
    methods: {
      'x': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.BoundedFrictionSimulation>(target, 'BoundedFrictionSimulation');
        D4.requireMinArgs(positional, 1, 'x');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'x');
        return t.x(time);
      },
      'dx': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.BoundedFrictionSimulation>(target, 'BoundedFrictionSimulation');
        D4.requireMinArgs(positional, 1, 'dx');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'dx');
        return t.dx(time);
      },
      'isDone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.BoundedFrictionSimulation>(target, 'BoundedFrictionSimulation');
        D4.requireMinArgs(positional, 1, 'isDone');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'isDone');
        return t.isDone(time);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.BoundedFrictionSimulation>(target, 'BoundedFrictionSimulation');
        return t.toString();
      },
      'timeAtX': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_2.BoundedFrictionSimulation>(target, 'BoundedFrictionSimulation');
        D4.requireMinArgs(positional, 1, 'timeAtX');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'timeAtX');
        return t.timeAtX(x);
      },
    },
    constructorSignatures: {
      '': 'BoundedFrictionSimulation(double drag, double position, double velocity, double _minX, double _maxX)',
    },
    methodSignatures: {
      'x': 'double x(double time)',
      'dx': 'double dx(double time)',
      'isDone': 'bool isDone(double time)',
      'toString': 'String toString()',
      'timeAtX': 'double timeAtX(double x)',
    },
    getterSignatures: {
      'tolerance': 'Tolerance get tolerance',
      'finalX': 'double get finalX',
    },
    setterSignatures: {
      'tolerance': 'set tolerance(dynamic value)',
    },
  );
}

// =============================================================================
// GravitySimulation Bridge
// =============================================================================

BridgedClass _createGravitySimulationBridge() {
  return BridgedClass(
    nativeType: $flutter_3.GravitySimulation,
    name: 'GravitySimulation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'GravitySimulation');
        final acceleration = D4.getRequiredArg<double>(positional, 0, 'acceleration', 'GravitySimulation');
        final distance = D4.getRequiredArg<double>(positional, 1, 'distance', 'GravitySimulation');
        final endDistance = D4.getRequiredArg<double>(positional, 2, 'endDistance', 'GravitySimulation');
        final velocity = D4.getRequiredArg<double>(positional, 3, 'velocity', 'GravitySimulation');
        return $flutter_3.GravitySimulation(acceleration, distance, endDistance, velocity);
      },
    },
    getters: {
      'tolerance': (visitor, target) => D4.validateTarget<$flutter_3.GravitySimulation>(target, 'GravitySimulation').tolerance,
    },
    setters: {
      'tolerance': (visitor, target, value) => 
        D4.validateTarget<$flutter_3.GravitySimulation>(target, 'GravitySimulation').tolerance = value as $flutter_6.Tolerance,
    },
    methods: {
      'x': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.GravitySimulation>(target, 'GravitySimulation');
        D4.requireMinArgs(positional, 1, 'x');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'x');
        return t.x(time);
      },
      'dx': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.GravitySimulation>(target, 'GravitySimulation');
        D4.requireMinArgs(positional, 1, 'dx');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'dx');
        return t.dx(time);
      },
      'isDone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.GravitySimulation>(target, 'GravitySimulation');
        D4.requireMinArgs(positional, 1, 'isDone');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'isDone');
        return t.isDone(time);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_3.GravitySimulation>(target, 'GravitySimulation');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'GravitySimulation(double acceleration, double distance, double endDistance, double velocity)',
    },
    methodSignatures: {
      'x': 'double x(double time)',
      'dx': 'double dx(double time)',
      'isDone': 'bool isDone(double time)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'tolerance': 'Tolerance get tolerance',
    },
    setterSignatures: {
      'tolerance': 'set tolerance(dynamic value)',
    },
  );
}

// =============================================================================
// SpringDescription Bridge
// =============================================================================

BridgedClass _createSpringDescriptionBridge() {
  return BridgedClass(
    nativeType: $flutter_5.SpringDescription,
    name: 'SpringDescription',
    constructors: {
      '': (visitor, positional, named) {
        final mass = D4.getRequiredNamedArg<double>(named, 'mass', 'SpringDescription');
        final stiffness = D4.getRequiredNamedArg<double>(named, 'stiffness', 'SpringDescription');
        final damping = D4.getRequiredNamedArg<double>(named, 'damping', 'SpringDescription');
        return $flutter_5.SpringDescription(mass: mass, stiffness: stiffness, damping: damping);
      },
      'withDampingRatio': (visitor, positional, named) {
        final mass = D4.getRequiredNamedArg<double>(named, 'mass', 'SpringDescription');
        final stiffness = D4.getRequiredNamedArg<double>(named, 'stiffness', 'SpringDescription');
        final ratio = D4.getNamedArgWithDefault<double>(named, 'ratio', 1.0);
        return $flutter_5.SpringDescription.withDampingRatio(mass: mass, stiffness: stiffness, ratio: ratio);
      },
      'withDurationAndBounce': (visitor, positional, named) {
        final duration = D4.getNamedArgWithDefault<Duration>(named, 'duration', const Duration(milliseconds: 500));
        final bounce = D4.getNamedArgWithDefault<double>(named, 'bounce', 0.0);
        return $flutter_5.SpringDescription.withDurationAndBounce(duration: duration, bounce: bounce);
      },
    },
    getters: {
      'mass': (visitor, target) => D4.validateTarget<$flutter_5.SpringDescription>(target, 'SpringDescription').mass,
      'stiffness': (visitor, target) => D4.validateTarget<$flutter_5.SpringDescription>(target, 'SpringDescription').stiffness,
      'damping': (visitor, target) => D4.validateTarget<$flutter_5.SpringDescription>(target, 'SpringDescription').damping,
      'duration': (visitor, target) => D4.validateTarget<$flutter_5.SpringDescription>(target, 'SpringDescription').duration,
      'bounce': (visitor, target) => D4.validateTarget<$flutter_5.SpringDescription>(target, 'SpringDescription').bounce,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SpringDescription>(target, 'SpringDescription');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const SpringDescription({required double mass, required double stiffness, required double damping})',
      'withDampingRatio': 'SpringDescription.withDampingRatio({required double mass, required double stiffness, double ratio = 1.0})',
      'withDurationAndBounce': 'factory SpringDescription.withDurationAndBounce({Duration duration = const Duration(milliseconds: 500), double bounce = 0.0})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'mass': 'double get mass',
      'stiffness': 'double get stiffness',
      'damping': 'double get damping',
      'duration': 'Duration get duration',
      'bounce': 'double get bounce',
    },
  );
}

// =============================================================================
// SpringSimulation Bridge
// =============================================================================

BridgedClass _createSpringSimulationBridge() {
  return BridgedClass(
    nativeType: $flutter_5.SpringSimulation,
    name: 'SpringSimulation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'SpringSimulation');
        final spring = D4.getRequiredArg<$flutter_5.SpringDescription>(positional, 0, 'spring', 'SpringSimulation');
        final start = D4.getRequiredArg<double>(positional, 1, 'start', 'SpringSimulation');
        final end = D4.getRequiredArg<double>(positional, 2, 'end', 'SpringSimulation');
        final velocity = D4.getRequiredArg<double>(positional, 3, 'velocity', 'SpringSimulation');
        final snapToEnd = D4.getNamedArgWithDefault<bool>(named, 'snapToEnd', false);
        final tolerance = D4.getNamedArgWithDefault<$flutter_6.Tolerance>(named, 'tolerance', $flutter_6.Tolerance.defaultTolerance);
        return $flutter_5.SpringSimulation(spring, start, end, velocity, snapToEnd: snapToEnd, tolerance: tolerance);
      },
    },
    getters: {
      'tolerance': (visitor, target) => D4.validateTarget<$flutter_5.SpringSimulation>(target, 'SpringSimulation').tolerance,
      'type': (visitor, target) => D4.validateTarget<$flutter_5.SpringSimulation>(target, 'SpringSimulation').type,
    },
    setters: {
      'tolerance': (visitor, target, value) => 
        D4.validateTarget<$flutter_5.SpringSimulation>(target, 'SpringSimulation').tolerance = value as $flutter_6.Tolerance,
    },
    methods: {
      'x': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SpringSimulation>(target, 'SpringSimulation');
        D4.requireMinArgs(positional, 1, 'x');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'x');
        return t.x(time);
      },
      'dx': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SpringSimulation>(target, 'SpringSimulation');
        D4.requireMinArgs(positional, 1, 'dx');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'dx');
        return t.dx(time);
      },
      'isDone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SpringSimulation>(target, 'SpringSimulation');
        D4.requireMinArgs(positional, 1, 'isDone');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'isDone');
        return t.isDone(time);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.SpringSimulation>(target, 'SpringSimulation');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'SpringSimulation(SpringDescription spring, double start, double end, double velocity, {bool snapToEnd = false, Tolerance tolerance = Tolerance.defaultTolerance})',
    },
    methodSignatures: {
      'x': 'double x(double time)',
      'dx': 'double dx(double time)',
      'isDone': 'bool isDone(double time)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'tolerance': 'Tolerance get tolerance',
      'type': 'SpringType get type',
    },
    setterSignatures: {
      'tolerance': 'set tolerance(dynamic value)',
    },
  );
}

// =============================================================================
// ScrollSpringSimulation Bridge
// =============================================================================

BridgedClass _createScrollSpringSimulationBridge() {
  return BridgedClass(
    nativeType: $flutter_5.ScrollSpringSimulation,
    name: 'ScrollSpringSimulation',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'ScrollSpringSimulation');
        final spring = D4.getRequiredArg<$flutter_5.SpringDescription>(positional, 0, 'spring', 'ScrollSpringSimulation');
        final start = D4.getRequiredArg<double>(positional, 1, 'start', 'ScrollSpringSimulation');
        final end = D4.getRequiredArg<double>(positional, 2, 'end', 'ScrollSpringSimulation');
        final velocity = D4.getRequiredArg<double>(positional, 3, 'velocity', 'ScrollSpringSimulation');
        final tolerance = D4.getNamedArgWithDefault<$flutter_6.Tolerance>(named, 'tolerance', $flutter_6.Tolerance.defaultTolerance);
        return $flutter_5.ScrollSpringSimulation(spring, start, end, velocity, tolerance: tolerance);
      },
    },
    getters: {
      'tolerance': (visitor, target) => D4.validateTarget<$flutter_5.ScrollSpringSimulation>(target, 'ScrollSpringSimulation').tolerance,
      'type': (visitor, target) => D4.validateTarget<$flutter_5.ScrollSpringSimulation>(target, 'ScrollSpringSimulation').type,
    },
    setters: {
      'tolerance': (visitor, target, value) => 
        D4.validateTarget<$flutter_5.ScrollSpringSimulation>(target, 'ScrollSpringSimulation').tolerance = value as $flutter_6.Tolerance,
    },
    methods: {
      'x': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ScrollSpringSimulation>(target, 'ScrollSpringSimulation');
        D4.requireMinArgs(positional, 1, 'x');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'x');
        return t.x(time);
      },
      'dx': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ScrollSpringSimulation>(target, 'ScrollSpringSimulation');
        D4.requireMinArgs(positional, 1, 'dx');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'dx');
        return t.dx(time);
      },
      'isDone': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ScrollSpringSimulation>(target, 'ScrollSpringSimulation');
        D4.requireMinArgs(positional, 1, 'isDone');
        final time = D4.getRequiredArg<double>(positional, 0, 'time', 'isDone');
        return t.isDone(time);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$flutter_5.ScrollSpringSimulation>(target, 'ScrollSpringSimulation');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ScrollSpringSimulation(SpringDescription spring, double start, double end, double velocity, {Tolerance tolerance = Tolerance.defaultTolerance})',
    },
    methodSignatures: {
      'x': 'double x(double time)',
      'dx': 'double dx(double time)',
      'isDone': 'bool isDone(double time)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'tolerance': 'Tolerance get tolerance',
      'type': 'SpringType get type',
    },
    setterSignatures: {
      'tolerance': 'set tolerance(dynamic value)',
    },
  );
}

