/// User-bridge overrides for [Grid]'s composite index operators.
///
/// `grid[[row, col]]` passes a `List<int>` as the index. The generator expects
/// a scalar index and cannot coerce the list, so we bridge `operator[]` and
/// `operator[]=` by hand. The second positional argument of an index-assign is
/// the value being stored.
library;

import 'package:tom_d4rt/d4rt.dart';

import '../grid/grid.dart';

/// Hand-written index-operator bridges for [Grid].
@D4rtUserBridge('package:d4rt_userbridges_sample/src/grid/grid.dart', 'Grid')
class GridUserBridge extends D4UserBridge {
  /// `grid[[row, col]]` — read.
  static Object? overrideOperatorIndex(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    final grid = D4.validateTarget<Grid>(target, 'Grid');
    final rc = D4.coerceList<int>(positional[0], 'rc');
    return grid[rc];
  }

  /// `grid[[row, col]] = value` — write.
  static Object? overrideOperatorIndexAssign(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    final grid = D4.validateTarget<Grid>(target, 'Grid');
    final rc = D4.coerceList<int>(positional[0], 'rc');
    final value = D4.extractBridgedArg<num>(positional[1], 'value');
    grid[rc] = value;
    return value;
  }
}
