import 'package:flutter/material.dart';

import 'engine.dart';

class ArenaPainter extends CustomPainter {
  final TronEngine engine;
  final int tick;

  ArenaPainter({required this.engine, required this.tick});

  static const Color bgColor = Color(0xFF05060A);
  static const Color playerColor = Color(0xFF00E5FF); // cyan
  static const Color aiColor = Color(0xFFFF2D55); // hot pink/red
  static const Color borderColor = Color(0xFF1F3A55);

  static final Paint _bg = Paint()..color = bgColor;
  static final Paint _playerPaint = Paint()..color = playerColor;
  static final Paint _aiPaint = Paint()..color = aiColor;
  static final Paint _border = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..color = borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final cellW = size.width / engine.cols;
    final cellH = size.height / engine.rows;

    canvas.drawRect(Offset.zero & size, _bg);

    // Trails — batch every trail cell into ONE Path per side and
    // draw with a single `canvas.drawPath`. The previous code issued
    // N `drawRect` calls per side per frame, which goes through the
    // d4rt-bridged Canvas N times — by ~60 ticks the engine was
    // making 100+ bridge round-trips per frame and the UI dropped
    // to a crawl. Path-based batched rendering needs just 2.
    _paintTrailPath(canvas, engine.playerTrail, cellW, cellH, _playerPaint);
    _paintTrailPath(canvas, engine.aiTrail, cellW, cellH, _aiPaint);

    _drawHead(canvas, engine.player.x, engine.player.y, cellW, cellH,
        _playerPaint);
    _drawHead(canvas, engine.ai.x, engine.ai.y, cellW, cellH, _aiPaint);

    canvas.drawRect(Offset.zero & size, _border);
  }

  void _paintTrailPath(Canvas canvas, List<int> trail, double cellW,
      double cellH, Paint paint) {
    if (trail.isEmpty) return;
    final path = Path();
    for (int i = 0; i < trail.length; i++) {
      final e = trail[i];
      final x = engine.xOf(e);
      final y = engine.yOf(e);
      path.addRect(Rect.fromLTWH(
          x * cellW + 0.6, y * cellH + 0.6, cellW - 1.2, cellH - 1.2));
    }
    canvas.drawPath(path, paint);
  }

  void _drawHead(
      Canvas canvas, int x, int y, double cellW, double cellH, Paint paint) {
    // Heads used to draw a blurred glow via MaskFilter.blur — every
    // such call ran the gaussian-blur shader per frame, which is
    // catastrophically expensive when CustomPaint runs through the
    // d4rt interpreter. We render the head as a single filled rect
    // instead. Visual fidelity is slightly lower but the game stays
    // playable at the engine's 110 ms tick rate.
    canvas.drawRect(
        Rect.fromLTWH(x * cellW, y * cellH, cellW, cellH), paint);
  }

  @override
  bool shouldRepaint(covariant ArenaPainter old) => old.tick != tick;
}
