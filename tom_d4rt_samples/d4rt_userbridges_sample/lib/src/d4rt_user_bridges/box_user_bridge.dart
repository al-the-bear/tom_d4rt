/// User-bridge overrides for the generic [Box]'s index operators.
///
/// A generic `operator[]` cannot be auto-bridged because the element type `T`
/// is erased at generation time. We bridge the read/write operators by hand and
/// let the generator handle the non-generic members (`size`, `isEmpty`). The
/// stored value passes through untouched, so any bridged element type works.
library;

import 'package:tom_d4rt/d4rt.dart';

import '../box/box.dart';

/// Hand-written index-operator bridges for [Box].
@D4rtUserBridge('package:d4rt_userbridges_sample/src/box/box.dart', 'Box')
class BoxUserBridge extends D4UserBridge {
  /// `box[index]` — read.
  static Object? overrideOperatorIndex(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    final box = D4.validateTarget<Box>(target, 'Box');
    final index = D4.getRequiredArg<int>(positional, 0, 'index', '[]');
    return box[index];
  }

  /// `box[index] = value` — write.
  static Object? overrideOperatorIndexAssign(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    final box = D4.validateTarget<Box>(target, 'Box');
    final index = D4.getRequiredArg<int>(positional, 0, 'index', '[]=');
    final value = positional[1];
    box[index] = value;
    return value;
  }
}
