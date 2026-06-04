// Photo model + CustomPaint-based gradient tile for the
// photo_gallery_hero sample (example #16).
//
// Each `Photo` is a placeholder "picture" — a deterministic id, a
// two-colour gradient that fills the tile, and an emoji label drawn
// on top. There are no actual images; the gradient + emoji combo is
// enough to give the tester a recognisable target and to exercise
// `CustomPaint` end-to-end.
//
// `GradientTile` accepts a fixed list of photos plus the index to
// render so the same widget can drive both the grid thumbnail and
// the InteractiveViewer body — `Hero` matches by `tag` and animates
// the painted bounds across the route push.
import 'package:flutter/material.dart';

class Photo {
  final int id;
  final String emoji;
  final Color colorA;
  final Color colorB;
  const Photo({
    required this.id,
    required this.emoji,
    required this.colorA,
    required this.colorB,
  });
}

/// Stable, deterministic catalogue used by both the grid and the
/// fullscreen viewer so the Hero matched-tag invariant holds.
const List<Photo> kPhotos = <Photo>[
  Photo(
    id: 0,
    emoji: '🌅',
    colorA: Color(0xFFFB923C),
    colorB: Color(0xFFFCD34D),
  ),
  Photo(
    id: 1,
    emoji: '🌊',
    colorA: Color(0xFF0EA5E9),
    colorB: Color(0xFF1E3A8A),
  ),
  Photo(
    id: 2,
    emoji: '🌲',
    colorA: Color(0xFF15803D),
    colorB: Color(0xFF065F46),
  ),
  Photo(
    id: 3,
    emoji: '🏔️',
    colorA: Color(0xFF94A3B8),
    colorB: Color(0xFF475569),
  ),
  Photo(
    id: 4,
    emoji: '🌸',
    colorA: Color(0xFFEC4899),
    colorB: Color(0xFFF472B6),
  ),
  Photo(
    id: 5,
    emoji: '🌌',
    colorA: Color(0xFF312E81),
    colorB: Color(0xFF1E1B4B),
  ),
];

/// Returns the canonical hero tag for a photo id. Centralised so the
/// grid tile and the viewer page can't drift apart — drifting tags
/// would silently break the matched-tag animation.
String photoHeroTag(int id) => 'photo-$id';

class GradientTile extends StatelessWidget {
  final Photo photo;
  final double fontSize;

  const GradientTile({
    super.key,
    required this.photo,
    this.fontSize = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    // CustomPaint draws the gradient; the emoji is overlaid via a
    // simple `Center`/`Text` so layout still flexes with the parent.
    return CustomPaint(
      painter: _GradientPainter(colorA: photo.colorA, colorB: photo.colorB),
      child: Center(
        child: Text(
          photo.emoji,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Color colorA;
  final Color colorB;

  const _GradientPainter({required this.colorA, required this.colorB});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[colorA, colorB],
    ).createShader(rect);
    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(_GradientPainter oldDelegate) =>
      oldDelegate.colorA != colorA || oldDelegate.colorB != colorB;
}
