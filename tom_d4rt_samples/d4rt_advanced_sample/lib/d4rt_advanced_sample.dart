/// Public barrel for the advanced sample's native library.
///
/// The bridge generator follows this barrel (named in `buildkit.yaml`) and
/// emits a `BridgedClass` registration for every type it exports. Scripts then
/// `import 'package:d4rt_advanced_sample/d4rt_advanced_sample.dart';` to reach
/// the bridged `Vector2`, `Shape`/`Circle`/`Rect`, `PhysicsWorld`, and `Body`.
library;

export 'src/geometry/vector2.dart';
export 'src/geometry/shapes.dart';
export 'src/geometry/physics_world.dart';
