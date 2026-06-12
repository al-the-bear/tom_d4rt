// CustomPainter that draws the Life board (optimized variant).
//
// Takes the live dense board as a `ValueListenable<List<int>>` and registers
// it as its `repaint:` source. The `CustomPaint` is built once; each
// generation that replaces `cells.value` repaints just this painter — the
// interpreted `paint()` re-runs but no widget subtree is re-interpreted.
//
// Live cells are read by flat index (`y * kBoardW + x`); no `Cell` objects,
// no `Set` membership tests.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'board.dart';

class GridPainter extends CustomPainter {
  final ValueListenable<List<int>> cells;
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

    // Filled live cells first so the grid lines sit on top of them.
    final livePaint = Paint()..color = liveColor;
    for (var y = 0; y < kBoardH; y++) {
      final rowBase = y * kBoardW;
      for (var x = 0; x < kBoardW; x++) {
        if (board[rowBase + x] == 1) {
          final r = Rect.fromLTWH(x * cellW, y * cellH, cellW, cellH);
          canvas.drawRect(r, livePaint);
        }
      }
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
