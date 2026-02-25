/// UserBridge User Guide Example Package
///
/// Demonstrates the D4UserBridge pattern for creating custom overrides
/// when the generator cannot handle certain patterns automatically.
///
/// Contains:
/// - `Vector2D` — A 2D vector requiring operator overrides (+, -, *, unary -)
/// - `Matrix2x2` — A 2x2 matrix requiring index operator overrides ([], []=)
/// - `Vector2DUserBridge` — Custom operator bridges for Vector2D
/// - `Matrix2x2UserBridge` — Custom index operator bridges for Matrix2x2
library;

// Source classes to be bridged
export 'src/vector2d.dart';
export 'src/matrix2x2.dart';

// User bridge overrides (must extend D4UserBridge)
export 'src/vector2d_user_bridge.dart';
export 'src/matrix2x2_user_bridge.dart';
