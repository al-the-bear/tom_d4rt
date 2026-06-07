// Fixture for the VM↔web signature-skew coercion table (B5/R6).
//
// Mirrors the shape of `dart:ui`'s `SceneBuilder.pushOpacity`, whose `offset`
// parameter is nullable on the VM (`Offset? offset = Offset.zero`) but
// non-nullable on web. The generator's skew table appends a `?? default`
// coercion so the extracted local infers the non-null type.

/// Stand-in for `dart:ui`'s `Offset`.
class Offset {
  final double dx;
  final double dy;
  const Offset(this.dx, this.dy);
  static const Offset zero = Offset(0.0, 0.0);
}

/// Stand-in for `dart:ui`'s `OpacityEngineLayer`.
class OpacityEngineLayer {}

/// Stand-in for `dart:ui`'s `SceneBuilder`.
class SceneBuilder {
  /// Mirrors `SceneBuilder.pushOpacity` — `offset` is the skewed parameter.
  OpacityEngineLayer pushOpacity(
    int alpha, {
    Offset? offset = Offset.zero,
    OpacityEngineLayer? oldLayer,
  }) {
    return OpacityEngineLayer();
  }
}
