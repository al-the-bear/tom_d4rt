import 'package:flutter/material.dart';

import 'engine.dart';

/// Cached, append-only Paths representing the player + AI trails in
/// UNIT-CELL coordinates (each cell is a 1×1 square at integer
/// `(x, y)`). The home widget owns one of these and re-uses it across
/// paints; the painter just calls `drawPath` on the already-built
/// Path after `canvas.scale(cellW, cellH)`.
///
/// Why this matters: rebuilding the Path from scratch every paint
/// loops through every trail cell (and each iteration crosses the
/// d4rt bridge 4-5 times to compute the Rect and addRect to the
/// Path). By turn 30 that's ~150 bridge calls per paint × 2 sides ≈
/// 300+ calls per frame, which exceeds one frame's budget and stalls
/// the visible framerate. Append-only keeps it to O(1) per tick.
class TrailPathCache {
  final Path playerPath = Path();
  final Path aiPath = Path();
  int _playerLen = 0;
  int _aiLen = 0;

  /// Extend the cached paths by appending unit-cell rects for any
  /// trail entries past the previously-known length. Call from the
  /// home's tick handler (after `engine.step()`) so the per-tick
  /// cost is constant — typically one addRect per side.
  void syncFrom(TronEngine engine) {
    final pt = engine.playerTrail;
    while (_playerLen < pt.length) {
      final e = pt[_playerLen];
      playerPath.addRect(Rect.fromLTWH(
          engine.xOf(e) + 0.05, engine.yOf(e) + 0.05, 0.9, 0.9));
      _playerLen++;
    }
    final at = engine.aiTrail;
    while (_aiLen < at.length) {
      final e = at[_aiLen];
      aiPath.addRect(Rect.fromLTWH(
          engine.xOf(e) + 0.05, engine.yOf(e) + 0.05, 0.9, 0.9));
      _aiLen++;
    }
  }

  /// Drop the accumulated state — call from the host on engine
  /// reset (a new round) so the next sync starts fresh.
  void reset() {
    playerPath.reset();
    aiPath.reset();
    _playerLen = 0;
    _aiLen = 0;
  }
}

class ArenaPainter extends CustomPainter {
  final TronEngine engine;
  final TrailPathCache cache;
  final int tick;

  ArenaPainter({
    required this.engine,
    required this.cache,
    required this.tick,
  });

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

    // Trails — paths are pre-built in unit-cell space by the host
    // via `TrailPathCache.syncFrom(engine)`. We draw them at the
    // current canvas scale; per-paint cost is two `drawPath` calls
    // regardless of trail length.
    canvas.save();
    canvas.scale(cellW, cellH);
    canvas.drawPath(cache.playerPath, _playerPaint);
    canvas.drawPath(cache.aiPath, _aiPaint);
    canvas.restore();

    _drawHead(canvas, engine.player.x, engine.player.y, cellW, cellH,
        _playerPaint);
    _drawHead(canvas, engine.ai.x, engine.ai.y, cellW, cellH, _aiPaint);

    canvas.drawRect(Offset.zero & size, _border);
  }

  void _drawHead(
      Canvas canvas, int x, int y, double cellW, double cellH, Paint paint) {
    canvas.drawRect(
        Rect.fromLTWH(x * cellW, y * cellH, cellW, cellH), paint);
  }

  @override
  bool shouldRepaint(covariant ArenaPainter old) => old.tick != tick;
}
