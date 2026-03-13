// D4rt Bridge - Generated file, do not edit
// Sources: 2 files
// Generated: 2026-03-12T17:04:25.436042

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';

import 'package:userbridge_user_guide_example/src/vector2d.dart' as $userbridge_user_guide_example_1;

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
      'Vector2D': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_exec\example\userbridge_user_guide\lib\src\vector2d.dart',
      'Matrix2x2': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_exec\example\userbridge_user_guide\lib\src\matrix2x2.dart',
    };
  }

    nativeType: $userbridge_user_guide_example_1.Vector2D,
    name: 'Vector2D',
    isAssignable: (v) => v is $userbridge_user_guide_example_1.Vector2D,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'Vector2D');
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector2D');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector2D');
        return $userbridge_user_guide_example_1.Vector2D(x, y);
      },
      'zero': (visitor, positional, named) {
        return $userbridge_user_guide_example_1.Vector2D.zero();
      },
    },
    getters: {
      'x': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D').x,
      'y': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D').y,
      'hashCode': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D').hashCode,
      'magnitude': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D').magnitude,
      'normalized': (visitor, target) => D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D').normalized,
    },
    methods: {
      'dot': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D');
        D4.requireMinArgs(positional, 1, 'dot');
        final other = D4.getRequiredArg<$userbridge_user_guide_example_1.Vector2D>(positional, 0, 'other', 'dot');
        return t.dot(other);
      },
      'scale': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D');
        D4.requireMinArgs(positional, 1, 'scale');
        final factor = D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return t.scale(factor);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D');
        return t.toString();
      },
      '+': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<$userbridge_user_guide_example_1.Vector2D>(positional, 0, 'other', 'operator+');
        return t + other;
      },
      '-': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D');
        if (positional.isEmpty) {
          // Unary operator
          return -t;
        } else {
          // Binary operator
          final other = D4.getRequiredArg<$userbridge_user_guide_example_1.Vector2D>(positional, 0, 'other', 'operator-');
          return t - other;
        }
      },
      '*': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D');
        final other = D4.getRequiredArg<double>(positional, 0, 'other', 'operator*');
        return t * other;
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$userbridge_user_guide_example_1.Vector2D>(target, 'Vector2D');
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
    nativeType: Matrix2x2,
    name: 'Matrix2x2',
    isAssignable: (v) => v is Matrix2x2,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'Matrix2x2');
        final a = D4.getRequiredArg<double>(positional, 0, 'a', 'Matrix2x2');
        final b = D4.getRequiredArg<double>(positional, 1, 'b', 'Matrix2x2');
        final c = D4.getRequiredArg<double>(positional, 2, 'c', 'Matrix2x2');
        final d = D4.getRequiredArg<double>(positional, 3, 'd', 'Matrix2x2');
        return Matrix2x2(a, b, c, d);
      },
      'identity': (visitor, positional, named) {
        return Matrix2x2.identity();
      },
    },
    getters: {
      'determinant': (visitor, target) => D4.validateTarget<Matrix2x2>(target, 'Matrix2x2').determinant,
      'trace': (visitor, target) => D4.validateTarget<Matrix2x2>(target, 'Matrix2x2').trace,
    },
    methods: {
      'row': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
        D4.requireMinArgs(positional, 1, 'row');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'row');
        return t.row(index);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
        return t.toString();
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
        final index = D4.getRequiredArg<List<int>>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
        final index = D4.getRequiredArg<List<int>>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<double>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
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

