// CustomPainter that draws the Life board.
//
// We paint live cells as filled squares and overlay a thin grid so
// the player can tell where to click. The painter takes the live
// `Set<Cell>` directly — content-equality on `Cell` means we don't
// need any auxiliary `Map<int,int>` indexing.
import 'package:flutter/material.dart';

import 'board.dart';

class GridPainter extends CustomPainter {
  final Set<Cell> live;
  final Color liveColor;
  final Color gridColor;

  GridPainter({
    required this.live,
    this.liveColor = Colors.black,
    this.gridColor = const Color(0xFFE0E0E0),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellW = size.width / kBoardW;
    final cellH = size.height / kBoardH;

    // Filled live cells first so the grid lines sit on top of them.
    final livePaint = Paint()..color = liveColor;
    for (final c in live) {
      final r = Rect.fromLTWH(
        c.x * cellW,
        c.y * cellH,
        cellW,
        cellH,
      );
      canvas.drawRect(r, livePaint);
    }

    // Then the thin grid.
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;
    for (var i = 0; i <= kBoardW; i++) {
      final x = i * cellW;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (var j = 0; j <= kBoardH; j++) {
      final y = j * cellH;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter old) {
    // The Set<Cell> identity changes every generation (we always
    // produce a brand-new set in `stepLife`), so a cheap reference
    // check is enough. The cell-count check is a safety net for
    // toggles that mutate the same set instance.
    return !identical(old.live, live) || old.live.length != live.length;
  }
}
