// D4rt Bridge - Generated file, do not edit
// Source: /Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example/lib/test_classes/operator_classes.dart
// Generated: 2026-01-28T18:18:48.477553

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4rt_generator_example/test_classes.dart' as $pkg;

/// Bridge class for Operator module.
class OperatorBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createVector2DBridge(),
      _createMatrixBridge(),
      _createDictionaryBridge(),
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
      'magnitude': (visitor, target) => D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D').magnitude,
      'hashCode': (visitor, target) => D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D').hashCode,
    },
    methods: {
      'normalize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D');
        return t.normalize();
      },
      'dot': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D');
        D4.requireMinArgs(positional, 1, 'dot');
        final other = D4.getRequiredArg<$pkg.Vector2D>(positional, 0, 'other', 'dot');
        return t.dot(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<$pkg.Vector2D>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$pkg.Vector2D>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '/': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator/');
        return t / other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
  );
}

// =============================================================================
// Matrix Bridge
// =============================================================================

BridgedClass _createMatrixBridge() {
  return BridgedClass(
    nativeType: $pkg.Matrix,
    name: 'Matrix',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Matrix');
        final rows = D4.getRequiredArg<int>(positional, 0, 'rows', 'Matrix');
        final cols = D4.getRequiredArg<int>(positional, 1, 'cols', 'Matrix');
        return $pkg.Matrix(rows, cols);
      },
      'fromList': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix');
        if (positional.length <= 0) {
          throw ArgumentError('Matrix: Missing required argument "data" at position 0');
        }
        final data = D4.coerceList<List<double>>(positional[0], 'data');
        return $pkg.Matrix.fromList(data);
      },
      'identity': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Matrix');
        final size = D4.getRequiredArg<int>(positional, 0, 'size', 'Matrix');
        return $pkg.Matrix.identity(size);
      },
    },
    getters: {
      'rows': (visitor, target) => D4.validateTarget<$pkg.Matrix>(target, 'Matrix').rows,
      'cols': (visitor, target) => D4.validateTarget<$pkg.Matrix>(target, 'Matrix').cols,
    },
    methods: {
      'get': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Matrix>(target, 'Matrix');
        D4.requireMinArgs(positional, 2, 'get');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'get');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'get');
        return t.get(row, col);
      },
      'set': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Matrix>(target, 'Matrix');
        D4.requireMinArgs(positional, 3, 'set');
        final row = D4.getRequiredArg<int>(positional, 0, 'row', 'set');
        final col = D4.getRequiredArg<int>(positional, 1, 'col', 'set');
        final value = D4.getRequiredArg<double>(positional, 2, 'value', 'set');
        t.set(row, col, value);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Matrix>(target, 'Matrix');
        return t.toString();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Matrix>(target, 'Matrix');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Matrix>(target, 'Matrix');
        final other = D4.getRequiredArg<$pkg.Matrix>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Matrix>(target, 'Matrix');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
    },
  );
}

// =============================================================================
// Dictionary Bridge
// =============================================================================

BridgedClass _createDictionaryBridge() {
  return BridgedClass(
    nativeType: $pkg.Dictionary,
    name: 'Dictionary',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Dictionary();
      },
    },
    getters: {
      'keys': (visitor, target) => D4.validateTarget<$pkg.Dictionary>(target, 'Dictionary').keys,
      'values': (visitor, target) => D4.validateTarget<$pkg.Dictionary>(target, 'Dictionary').values,
      'length': (visitor, target) => D4.validateTarget<$pkg.Dictionary>(target, 'Dictionary').length,
    },
    methods: {
      'containsKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Dictionary>(target, 'Dictionary');
        D4.requireMinArgs(positional, 1, 'containsKey');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'containsKey');
        return t.containsKey(key);
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Dictionary>(target, 'Dictionary');
        D4.requireMinArgs(positional, 1, 'remove');
        final key = D4.getRequiredArg<dynamic>(positional, 0, 'key', 'remove');
        return t.remove(key);
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Dictionary>(target, 'Dictionary');
        t.clear();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Dictionary>(target, 'Dictionary');
        return t.toString();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Dictionary>(target, 'Dictionary');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Dictionary>(target, 'Dictionary');
        final index = D4.getRequiredArg<dynamic>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
  );
}

