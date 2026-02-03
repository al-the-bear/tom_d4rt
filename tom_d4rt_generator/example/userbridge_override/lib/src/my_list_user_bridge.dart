/// User bridge overrides for MyList class.
///
/// This file demonstrates the UserBridge override system where you can
/// selectively override specific methods while letting the generator
/// handle the rest.
library;

import 'package:tom_d4rt/tom_d4rt.dart';

import 'my_list.dart';

/// User overrides for MyList bridge.
///
/// Only override methods that need custom handling (like operators).
/// All other members will be auto-generated.
class MyListUserBridge extends D4UserBridge {
  /// Override operator[] for generic type handling.
  ///
  /// This is needed because the auto-generator cannot determine
  /// the generic type T at generation time.
  static Object? overrideOperatorIndex(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final list = D4.validateTarget<MyList>(target, 'MyList');
    final index = D4.getRequiredArg<int>(positional, 0, 'index', '[]');
    return list[index];
  }

  /// Override operator[]= for generic type handling.
  static dynamic overrideOperatorIndexAssign(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final list = D4.validateTarget<MyList>(target, 'MyList');
    final index = D4.getRequiredArg<int>(positional, 0, 'index', '[]=');
    final value = positional[1];
    list[index] = value;
    return value;
  }
}
