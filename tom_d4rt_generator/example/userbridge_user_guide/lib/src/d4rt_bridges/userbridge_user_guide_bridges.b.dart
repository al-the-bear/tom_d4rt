// D4rt Bridge - Generated file, do not edit
// Sources: 2 files
// Generated: 2026-02-08T19:28:45.230050

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:userbridge_user_guide_example/userbridge_user_guide_example.dart' as $pkg;

/// Bridge class for all module.
class AllBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createVector2DBridge(),
      _createMatrix2x2Bridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Vector2D': 'package:userbridge_user_guide_example/src/vector2d.dart',
      'Matrix2x2': 'package:userbridge_user_guide_example/src/matrix2x2.dart',
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
      'package:userbridge_user_guide_example/src/matrix2x2.dart',
      'package:userbridge_user_guide_example/src/vector2d.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:userbridge_user_guide_example/userbridge_user_guide_example.dart';";
  }

}

// =============================================================================
// Vector2D Bridge
// =============================================================================

BridgedClass _createVector2DBridge() {
  return BridgedClass(
    nativeType: $pkg.Vector2D,
    name: 'Vector2D',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector2D');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector2D');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector2D');
        return $pkg.Vector2D(x, y);
      },
      'zero': (visitor, positional, named) {
        return $pkg.Vector2D.zero();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D').x,
      'y': (visitor, target) => D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D').y,
      'hashCode': (visitor, target) => D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D').hashCode,
      'magnitude': (visitor, target) => D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D').magnitude,
      'normalized': (visitor, target) => D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D').normalized,
    },
    methods: {
      'dot': $pkg.Vector2DUserBridge.overrideMethodDot,
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D');
        return t.toString();
      },
      '+': $pkg.Vector2DUserBridge.overrideOperatorPlus,
      '-': $pkg.Vector2DUserBridge.overrideOperatorMinus,
      '*': $pkg.Vector2DUserBridge.overrideOperatorMultiply,
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'Vector2D(double x, double y)',
      'zero': 'Vector2D.zero()',
    },
    methodSignatures: {
      'dot': 'double dot(Vector2D other)',
      'scale': 'Vector2D scale(double factor)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'x': 'double get x',
      'y': 'double get y',
      'hashCode': 'int get hashCode',
      'magnitude': 'double get magnitude',
      'normalized': 'Vector2D get normalized',
    },
  );
}

// =============================================================================
// Matrix2x2 Bridge
// =============================================================================

BridgedClass _createMatrix2x2Bridge() {
  return BridgedClass(
    nativeType: $pkg.Matrix2x2,
    name: 'Matrix2x2',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Matrix2x2');
        final a = D4.getRequiredArg<double>(positional, 0, 'a', 'Matrix2x2');
        final b = D4.getRequiredArg<double>(positional, 1, 'b', 'Matrix2x2');
        final c = D4.getRequiredArg<double>(positional, 2, 'c', 'Matrix2x2');
        final d = D4.getRequiredArg<double>(positional, 3, 'd', 'Matrix2x2');
        return $pkg.Matrix2x2(a, b, c, d);
      },
      'identity': (visitor, positional, named) {
        return $pkg.Matrix2x2.identity();
      },
    },
    getters: {
      'determinant': (visitor, target) => D4.validateTarget<$pkg.Matrix2x2>(target, 'Matrix2x2').determinant,
      'trace': (visitor, target) => D4.validateTarget<$pkg.Matrix2x2>(target, 'Matrix2x2').trace,
    },
    methods: {
      'row': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Matrix2x2>(target, 'Matrix2x2');
        D4.requireMinArgs(positional, 1, 'row');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'row');
        return t.row(index);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Matrix2x2>(target, 'Matrix2x2');
        return t.toString();
      },
      '[]': $pkg.Matrix2x2UserBridge.overrideOperatorIndex,
      '[]=': $pkg.Matrix2x2UserBridge.overrideOperatorIndexAssign,
    },
    constructorSignatures: {
      '': 'Matrix2x2(double a, double b, double c, double d)',
      'identity': 'Matrix2x2.identity()',
    },
    methodSignatures: {
      'row': 'List<double> row(int index)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'determinant': 'double get determinant',
      'trace': 'double get trace',
    },
  );
}

