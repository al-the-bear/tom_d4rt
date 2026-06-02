// Result of the winner check + the painter that draws the line through
// the three cells.
//
// The line animates from its start point towards its end point as
// `progress` advances from 0 → 1; the host widget feeds an
// `AnimationController` value into `progress` via `AnimatedBuilder`.
import 'package:flutter/material.dart';

enum WinKind { row, column, diagDown, diagUp }

class WinLine {
  final WinKind kind;

  /// Row or column index when `kind == row | column`. Ignored for
  /// diagonals (kept as 0 for diff stability).
  final int index;

  /// 'X' or 'O' — which player owns the line.
  final String winner;

  const WinLine({
    required this.kind,
    required this.index,
    required this.winner,
  });
}

class WinLinePainter extends CustomPainter {
  final WinLine line;
  final double progress;
  final Color color;

  const WinLinePainter({
    required this.line,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.width / 3;
    // Inset so the line doesn't run all the way to the edge of the board.
    final pad = cell * 0.15;

    Offset start;
    Offset end;
    switch (line.kind) {
      case WinKind.row:
        final y = cell * (line.index + 0.5);
        start = Offset(pad, y);
        end = Offset(size.width - pad, y);
        break;
      case WinKind.column:
        final x = cell * (line.index + 0.5);
        start = Offset(x, pad);
        end = Offset(x, size.height - pad);
        break;
      case WinKind.diagDown:
        start = Offset(pad, pad);
        end = Offset(size.width - pad, size.height - pad);
        break;
      case WinKind.diagUp:
        start = Offset(pad, size.height - pad);
        end = Offset(size.width - pad, pad);
        break;
    }

    final currentEnd = Offset(
      start.dx + (end.dx - start.dx) * progress,
      start.dy + (end.dy - start.dy) * progress,
    );

    final paint = Paint()
      ..color = color
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, currentEnd, paint);
  }

  @override
  bool shouldRepaint(WinLinePainter oldDelegate) {
    return oldDelegate.line.kind != line.kind ||
        oldDelegate.line.index != line.index ||
        oldDelegate.progress != progress ||
        oldDelegate.color != color;
  }
}
