// CustomPainter that draws the Life board (optimized variant).
//
// Takes the live sparse board as a `ValueListenable<Set<int>>` and registers
// it as its `repaint:` source. The `CustomPaint` is built once; each
// generation that replaces `cells.value` repaints just this painter — the
// interpreted `paint()` re-runs but no widget subtree is re-interpreted.
//
// Drawing iterates ONLY the live cells (decoding each flat index back to
// (x, y)), so paint cost is proportional to population — not the full board
// area as the earlier dense variant's 2 400-cell scan was.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'board.dart';

class GridPainter extends CustomPainter {
  final ValueListenable<Set<int>> cells;
  final Color liveColor;
  final Color gridColor;

  GridPainter({
    required this.cells,
    this.liveColor = Colors.black,
    this.gridColor = const Color(0xFFE0E0E0),
  }) : super(repaint: cells);

  @override
  void paint(Canvas canvas, Size size) {
    final board = cells.value;
    final cellW = size.width / kBoardW;
    final cellH = size.height / kBoardH;

    // Filled live cells first so the grid lines sit on top of them. Only the
    // live set is visited.
    final livePaint = Paint()..color = liveColor;
    for (final idx in board) {
      final x = idx % kBoardW;
      final y = idx ~/ kBoardW;
      final r = Rect.fromLTWH(x * cellW, y * cellH, cellW, cellH);
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

  // Repaint is driven by the `repaint:` listenable; the painter instance is
  // stable across the single build, so there is nothing to compare here.
  @override
  bool shouldRepaint(covariant GridPainter old) => false;
}
