/// Public barrel for the user-bridges sample.
///
/// The bridge generator follows this barrel (named in `buildkit.yaml`). It
/// generates a `BridgedClass` for every native type it exports, and — crucially
/// — pre-scans the exported `*_user_bridge.dart` files for `@D4rtUserBridge` /
/// `@D4rtGlobalsUserBridge` annotations, weaving those hand-written overrides
/// into the generated bridges. Scripts import this same package URI to reach
/// the bridged `Money`, `Grid`, `Box`, and the `app_config` globals.
library;

// Native source classes to be bridged.
export 'src/money/money.dart';
export 'src/grid/grid.dart';
export 'src/box/box.dart';
export 'src/config/app_config.dart';

// User-bridge overrides (each extends D4UserBridge). Exporting them makes them
// reachable from the barrel so the generator's pre-scan finds the annotations.
export 'src/d4rt_user_bridges/money_user_bridge.dart';
export 'src/d4rt_user_bridges/grid_user_bridge.dart';
export 'src/d4rt_user_bridges/box_user_bridge.dart';
export 'src/d4rt_user_bridges/app_config_user_bridge.dart';
