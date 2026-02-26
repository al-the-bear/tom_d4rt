/// UserBridge Override Example Package
///
/// This package demonstrates the UserBridge override system from
/// userbridge_override_design.md.
///
/// It contains:
/// - `MyList<T>` - A generic list that requires operator overrides
/// - Global variables and getters that need custom handling
library;

// Source classes to be bridged
export 'src/my_list.dart';
export 'src/globals.dart';

// User bridge overrides (must extend D4UserBridge)
export 'src/my_list_user_bridge.dart';
export 'src/globals_user_bridge.dart';
