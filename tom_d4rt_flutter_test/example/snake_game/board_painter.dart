// CustomPainter for the snake board.
//
// Draws (in this order): a faint grid backdrop, the food pellet
// as a filled circle, the snake body as rounded squares, and the
// head with a slightly brighter fill so the player can tell which
// end is which. The painter is intentionally cheap — paint sizing
// is recomputed from the current widget size every frame.
//
// `shouldRepaint` is the conservative "always repaint" — the host
// only constructs a new painter inside `setState`, so a true here
// is correct (every rebuild paints the new state).
import 'package:flutter/material.dart';

import 'board.dart';

class BoardPainter extends CustomPainter {
  /// Snake body, head first.
  final List<Cell> body;

  /// Current food pellet position, or `null` if the snake fills
  /// every cell (player has won).
  final Cell? food;

  /// Whether the game is currently in the game-over state. When
  /// `true` we overlay a faint red wash so the board reads as
  /// "ended" before the modal animates in.
  final bool over;

  const BoardPainter({
    required this.body,
    required this.food,
    required this.over,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.shortestSide / kBoardSize;

    final gridPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    for (var i = 0; i <= kBoardSize; i++) {
      final off = i * cell;
      canvas.drawLine(Offset(off, 0), Offset(off, kBoardSize * cell),
          gridPaint);
      canvas.drawLine(Offset(0, off), Offset(kBoardSize * cell, off),
          gridPaint);
    }

    if (food != null) {
      final foodPaint = Paint()
        ..color = const Color(0xFFDC2626)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset((food!.x + 0.5) * cell, (food!.y + 0.5) * cell),
        cell * 0.35,
        foodPaint,
      );
    }

    final bodyPaint = Paint()
      ..color = const Color(0xFF059669)
      ..style = PaintingStyle.fill;
    final headPaint = Paint()
      ..color = const Color(0xFF065F46)
      ..style = PaintingStyle.fill;
    for (var i = 0; i < body.length; i++) {
      final c = body[i];
      final rect = Rect.fromLTWH(
        c.x * cell + 1,
        c.y * cell + 1,
        cell - 2,
        cell - 2,
      );
      final rrect = RRect.fromRectAndRadius(
        rect,
        Radius.circular(cell * 0.18),
      );
      canvas.drawRRect(rrect, i == 0 ? headPaint : bodyPaint);
    }

    if (over) {
      final overlay = Paint()
        ..color = const Color(0x33DC2626)
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromLTWH(0, 0, kBoardSize * cell, kBoardSize * cell),
        overlay,
      );
    }
  }

  @override
  bool shouldRepaint(BoardPainter oldDelegate) => true;
}
