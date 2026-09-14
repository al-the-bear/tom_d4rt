// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_field, unnecessary_import, no_leading_underscores_for_local_identifiers, constant_identifier_names, unnecessary_underscores, non_constant_identifier_names, annotate_overrides
// D4rt deep visual demo: ImageCache from package:flutter/painting.dart.
//
// This file is a hand-authored, analyzer-clean static visualisation of the
// ImageCache class living on PaintingBinding.instance.imageCache. It does NOT
// load images, write to the cache, or mutate any global state in a way that
// would persist across runs. The demo READS the live cache for snapshotting
// (wrapped in a defensive try/catch) and otherwise renders inert literal data
// as labelled cards, CustomPainter diagrams, tables, chips, pills, and bars.
//
// Topics covered:
//   - ImageCache lifetime and ownership (PaintingBinding)
//   - Configuration knobs: maximumSize, maximumSizeBytes
//   - State counters: liveImageCount, pendingImageCount,
//                     currentSize, currentSizeBytes
//   - Operations: evict, clear, clearLiveImages, putIfAbsent, containsKey
//   - Live snapshot of PaintingBinding.instance.imageCache (read-only)
//   - The cached-image lifecycle: pending → live → cached → evicted
//   - Anatomy of the bounded grid: live vs cached vs pending vs over-budget
//   - Mock cache entries gallery + bytes-used progress bar
//   - Idiomatic configuration recipes + warnings
//   - Pitfalls: clearing in build, oversized images, evict vs clear
//
// Rendered as a top-level `dynamic build(BuildContext)` returning a
// MaterialApp → Scaffold → SafeArea → SingleChildScrollView → Column harness,
// suitable for the d4rt flutter_ast HTTP test corpus.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// Theme palette. Centralised so colour use across painters / cards is auditable
// at a glance and the analyzer never flags duplicate constants.
// ---------------------------------------------------------------------------

const Color _bgDeep = Color(0xFF0B1226);
const Color _accentCyan = Color(0xFF4DD0E1);
const Color _accentMagenta = Color(0xFFE040FB);
const Color _accentAmber = Color(0xFFFFC107);
const Color _accentGreen = Color(0xFF66BB6A);
const Color _accentRed = Color(0xFFEF5350);
const Color _accentBlue = Color(0xFF42A5F5);
const Color _ink = Color(0xFFE8EAF6);
const Color _muted = Color(0xFFB0BEC5);

// ---------------------------------------------------------------------------
// Snapshot record. Captures a read-only view of the live ImageCache so the
// demo can render the actual numbers if available, but never crashes if the
// binding is uninitialised in the test harness.
// ---------------------------------------------------------------------------

class _CacheSnapshot {
  final bool available;
  final int maximumSize;
  final int maximumSizeBytes;
  final int currentSize;
  final int currentSizeBytes;
  final int liveImageCount;
  final int pendingImageCount;
  final String typeName;
  final String? error;

  const _CacheSnapshot({
    required this.available,
    required this.maximumSize,
    required this.maximumSizeBytes,
    required this.currentSize,
    required this.currentSizeBytes,
    required this.liveImageCount,
    required this.pendingImageCount,
    required this.typeName,
    required this.error,
  });

  static const _CacheSnapshot unavailable = _CacheSnapshot(
    available: false,
    maximumSize: 0,
    maximumSizeBytes: 0,
    currentSize: 0,
    currentSizeBytes: 0,
    liveImageCount: 0,
    pendingImageCount: 0,
    typeName: 'ImageCache',
    error: 'not initialised',
  );
}

_CacheSnapshot _takeSnapshot() {
  try {
    final cache = PaintingBinding.instance.imageCache;
    return _CacheSnapshot(
      available: true,
      maximumSize: cache.maximumSize,
      maximumSizeBytes: cache.maximumSizeBytes,
      currentSize: cache.currentSize,
      currentSizeBytes: cache.currentSizeBytes,
      liveImageCount: cache.liveImageCount,
      pendingImageCount: cache.pendingImageCount,
      typeName: cache.runtimeType.toString(),
      error: null,
    );
  } catch (e) {
    return _CacheSnapshot(
      available: false,
      maximumSize: 0,
      maximumSizeBytes: 0,
      currentSize: 0,
      currentSizeBytes: 0,
      liveImageCount: 0,
      pendingImageCount: 0,
      typeName: 'ImageCache',
      error: e.toString(),
    );
  }
}

String _formatBytes(int bytes) {
  if (bytes <= 0) return '0 B';
  const units = ['B', 'KiB', 'MiB', 'GiB'];
  double v = bytes.toDouble();
  int u = 0;
  while (v >= 1024 && u < units.length - 1) {
    v /= 1024;
    u += 1;
  }
  return '${v.toStringAsFixed(v >= 100 ? 0 : 1)} ${units[u]}';
}

// ---------------------------------------------------------------------------
// Section-card shell. Each card carries a gradient + multi-shadow stack so
// the visual inventory accumulates naturally as sections are added.
// ---------------------------------------------------------------------------

Widget _sectionCard({
  required String title,
  required String subtitle,
  required List<Color> gradient,
  required Color accent,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: LinearGradient(
        colors: gradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withOpacity(0.32),
          blurRadius: 22,
          spreadRadius: 1,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.45),
          blurRadius: 36,
          spreadRadius: 2,
          offset: const Offset(0, 18),
        ),
        BoxShadow(
          color: accent.withOpacity(0.10),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
      border: Border.all(color: accent.withOpacity(0.55), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accent, accent.withOpacity(0.3)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: accent.withOpacity(0.95),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

Widget _prose(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      text,
      style: TextStyle(
        color: _ink.withOpacity(0.92),
        fontSize: 13.5,
        height: 1.45,
      ),
    ),
  );
}

Widget _pill(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.18),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.7)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _chip(String label, Color color, {IconData? icon}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.65)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
        ],
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

Widget _kv(String key, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 180,
          child: Text(
            key,
            style: const TextStyle(
              color: _muted,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _ink,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, {Color tint = _accentCyan}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF101728), Color(0xFF192038)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tint.withOpacity(0.4)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.55),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
        BoxShadow(
          color: tint.withOpacity(0.10),
          blurRadius: 30,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: Text(
      code,
      style: TextStyle(
        color: tint,
        fontSize: 12,
        height: 1.5,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _calloutBox({
  required String title,
  required String body,
  required Color color,
  IconData icon = Icons.info_outline,
}) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #62, P5(a)):
  // Original combined borderRadius:10 with asymmetric Border (left: 4-dp
  // tint accent, t/r/b: 1-dp 0.3-alpha tint hairline) — Flutter forbids
  // non-uniform colors with a radius. Refactored to uniform Border.all
  // (0.3-alpha hairline) + ClipRRect(10) + IntrinsicHeight > Row(stretch,
  // [Container(width:4, color: tint), Expanded(Padding(content))]).
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4.0, color: color),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.10),
                  border: Border.all(
                    color: color.withOpacity(0.3),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, size: 18, color: color),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: color,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            body,
                            style: TextStyle(
                              color: _ink.withOpacity(0.92),
                              fontSize: 12.5,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// CustomPainter #1 — Bounded-grid anatomy of ImageCache.
//
// Visualises the cache as a 6 x 4 grid of slots, partitioned into:
//   - live entries (held by a listener somewhere)
//   - cached decoded entries (no listener but still resident)
//   - pending entries (decode in flight)
//   - over-budget shadows (would be evicted before next admit)
// Thresholds for maximumSize and maximumSizeBytes are drawn as dashed lines.
// ---------------------------------------------------------------------------

class _AnatomyPainter extends CustomPainter {
  const _AnatomyPainter();

  static const int _cols = 8;
  static const int _rows = 4;

  // Slot state encoding:
  //   0 = empty
  //   1 = pending (amber)
  //   2 = live (cyan)
  //   3 = cached (green)
  //   4 = oversized / would-be-evicted (red shadow)
  static const List<List<int>> _grid = [
    [2, 2, 3, 3, 3, 1, 0, 0],
    [2, 3, 3, 3, 3, 1, 1, 0],
    [3, 3, 3, 3, 3, 3, 4, 0],
    [3, 3, 3, 3, 4, 4, 4, 0],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF0F1A38), Color(0xFF1A2A55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(14),
      ),
      bg,
    );

    final pad = 18.0;
    final cellW = (size.width - 2 * pad) / _cols;
    final cellH = (size.height - 2 * pad - 28) / _rows;

    // Header label.
    final header = TextPainter(
      text: const TextSpan(
        text: 'bounded grid  ·  maximumSize = 1000 entries',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    header.layout();
    header.paint(canvas, Offset(pad, 6));

    // Cells.
    for (int r = 0; r < _rows; r++) {
      for (int c = 0; c < _cols; c++) {
        final state = _grid[r][c];
        final rect = Rect.fromLTWH(
          pad + c * cellW + 2,
          pad + 22 + r * cellH + 2,
          cellW - 4,
          cellH - 4,
        );
        Color fill;
        switch (state) {
          case 0:
            fill = Colors.white10;
            break;
          case 1:
            fill = _accentAmber;
            break;
          case 2:
            fill = _accentCyan;
            break;
          case 3:
            fill = _accentGreen;
            break;
          case 4:
            fill = _accentRed;
            break;
          default:
            fill = Colors.white10;
        }
        final p = Paint()
          ..shader = LinearGradient(
            colors: [fill.withOpacity(0.85), fill.withOpacity(0.45)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(rect);
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(4)),
          p,
        );
        final border = Paint()
          ..color = Colors.white24
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8;
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(4)),
          border,
        );

        // Light dot indicator on live/pending cells.
        if (state == 1 || state == 2) {
          final dot = Paint()..color = Colors.white.withOpacity(0.9);
          canvas.drawCircle(
            Offset(rect.right - 5, rect.top + 5),
            1.8,
            dot,
          );
        }
      }
    }

    // maximumSizeBytes threshold (vertical dashed line at 5.5 cols).
    final dashPaint = Paint()
      ..color = _accentMagenta
      ..strokeWidth = 1.4;
    final thresholdX = pad + 5.5 * cellW;
    _drawDashedLine(
      canvas,
      Offset(thresholdX, pad + 22),
      Offset(thresholdX, pad + 22 + _rows * cellH),
      dashPaint,
    );
    final tp = TextPainter(
      text: const TextSpan(
        text: 'maximumSizeBytes line ↑',
        style: TextStyle(
          color: _accentMagenta,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(thresholdX + 4, pad + 22 - 12));
  }

  void _drawDashedLine(Canvas canvas, Offset a, Offset b, Paint paint) {
    final dx = b.dx - a.dx;
    final dy = b.dy - a.dy;
    final len = math.sqrt(dx * dx + dy * dy);
    if (len < 1) return;
    final ux = dx / len;
    final uy = dy / len;
    const dashLen = 5.0;
    const gapLen = 4.0;
    double d = 0;
    while (d < len) {
      final start = Offset(a.dx + ux * d, a.dy + uy * d);
      final endD = math.min(d + dashLen, len);
      final end = Offset(a.dx + ux * endD, a.dy + uy * endD);
      canvas.drawLine(start, end, paint);
      d += dashLen + gapLen;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// CustomPainter #2 — Lifecycle diagram of a cached image.
//
//   precacheImage  →  cache lookup  →  ImageStream  →  ImageStreamCompleter
//                      ↓                                ↓
//                   pending entry                    decoded ImageInfo
//                      ↓                                ↓
//                   live entry  ←──────────────  cached entry  →  evict
// ---------------------------------------------------------------------------

class _LifecyclePainter extends CustomPainter {
  const _LifecyclePainter();

  static const List<String> _nodes = [
    'precacheImage',
    'cache lookup',
    'ImageStream',
    'ImageStreamCompleter',
    'pending entry',
    'decoded ImageInfo',
    'live entry',
    'cached entry',
    'evict / clear',
  ];

  static const List<String> _captions = [
    'consumer asks',
    'putIfAbsent',
    'observable handle',
    'drives decode',
    'pendingImageCount++',
    'paints / ticks',
    'liveImageCount++',
    'currentSize++',
    'memory reclaim',
  ];

  static const List<Color> _colors = [
    _accentCyan,
    _accentBlue,
    _accentCyan,
    _accentAmber,
    _accentAmber,
    _accentGreen,
    _accentGreen,
    _accentMagenta,
    _accentRed,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF0F1A38), Color(0xFF1A2A55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(14),
      ),
      bg,
    );

    final cols = 3;
    final rows = 3;
    final pad = 18.0;
    final cellW = (size.width - 2 * pad) / cols;
    final cellH = (size.height - 2 * pad) / rows;
    final boxW = cellW - 12;
    final boxH = cellH - 24;

    final positions = <Offset>[];
    for (int i = 0; i < _nodes.length; i++) {
      final r = i ~/ cols;
      final c = i % cols;
      final x = pad + c * cellW + 6;
      final y = pad + r * cellH + 6;
      positions.add(Offset(x, y));
    }

    // Arrows.
    final arrowPaint = Paint()
      ..color = _accentCyan.withOpacity(0.6)
      ..strokeWidth = 1.6;
    for (int i = 0; i < _nodes.length - 1; i++) {
      final a = positions[i];
      final b = positions[i + 1];
      final from = Offset(a.dx + boxW / 2, a.dy + boxH / 2);
      final to = Offset(b.dx + boxW / 2, b.dy + boxH / 2);
      _drawArrow(canvas, from, to, arrowPaint);
    }

    // Boxes.
    for (int i = 0; i < _nodes.length; i++) {
      final p = positions[i];
      final rect = Rect.fromLTWH(p.dx, p.dy, boxW, boxH);
      final rr = RRect.fromRectAndRadius(rect, const Radius.circular(8));
      final fill = Paint()
        ..shader = LinearGradient(
          colors: [_colors[i].withOpacity(0.85), _colors[i].withOpacity(0.45)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(rect);
      canvas.drawRRect(rr, fill);
      final border = Paint()
        ..color = Colors.white.withOpacity(0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1;
      canvas.drawRRect(rr, border);

      final title = TextPainter(
        text: TextSpan(
          text: _nodes[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      title.layout(maxWidth: boxW - 8);
      title.paint(
        canvas,
        Offset(p.dx + (boxW - title.width) / 2, p.dy + 6),
      );

      final cap = TextPainter(
        text: TextSpan(
          text: _captions[i],
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 9.5,
            fontStyle: FontStyle.italic,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      cap.layout(maxWidth: boxW - 8);
      cap.paint(
        canvas,
        Offset(p.dx + (boxW - cap.width) / 2, p.dy + boxH - cap.height - 4),
      );
    }
  }

  void _drawArrow(Canvas canvas, Offset a, Offset b, Paint paint) {
    canvas.drawLine(a, b, paint);
    final dir = b - a;
    final len = dir.distance;
    if (len < 1) return;
    final ux = dir.dx / len;
    final uy = dir.dy / len;
    final tipBase = Offset(b.dx - ux * 8, b.dy - uy * 8);
    final left = Offset(tipBase.dx + uy * 4, tipBase.dy - ux * 4);
    final right = Offset(tipBase.dx - uy * 4, tipBase.dy + ux * 4);
    final tri = Path()
      ..moveTo(b.dx, b.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    final fill = Paint()..color = paint.color;
    canvas.drawPath(tri, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// CustomPainter #3 — "Bytes used" progress bar with a cache-budget marker.
// Used by the gallery section to visualise currentSizeBytes vs maximumSizeBytes
// using literal mock values.
// ---------------------------------------------------------------------------

class _BytesBarPainter extends CustomPainter {
  final int used;
  final int budget;
  const _BytesBarPainter({required this.used, required this.budget});

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF15203D), Color(0xFF1F2C58)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(12),
      ),
      bg,
    );

    final barRect = Rect.fromLTWH(20, size.height / 2 - 14, size.width - 40, 28);
    final track = Paint()..color = Colors.white12;
    canvas.drawRRect(
      RRect.fromRectAndRadius(barRect, const Radius.circular(14)),
      track,
    );

    final fraction = budget <= 0 ? 0.0 : (used / budget).clamp(0.0, 1.0).toDouble();
    final fillRect = Rect.fromLTWH(
      barRect.left,
      barRect.top,
      barRect.width * fraction,
      barRect.height,
    );
    final fill = Paint()
      ..shader = LinearGradient(
        colors: fraction > 0.85
            ? const [_accentRed, _accentAmber]
            : fraction > 0.6
                ? const [_accentAmber, _accentGreen]
                : const [_accentGreen, _accentCyan],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(fillRect);
    canvas.drawRRect(
      RRect.fromRectAndRadius(fillRect, const Radius.circular(14)),
      fill,
    );

    // 80% warning marker.
    final markerX = barRect.left + barRect.width * 0.80;
    final marker = Paint()
      ..color = _accentRed.withOpacity(0.85)
      ..strokeWidth = 1.4;
    canvas.drawLine(
      Offset(markerX, barRect.top - 4),
      Offset(markerX, barRect.bottom + 4),
      marker,
    );
    final markerLabel = TextPainter(
      text: const TextSpan(
        text: '80%',
        style: TextStyle(
          color: _accentRed,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    markerLabel.layout();
    markerLabel.paint(
      canvas,
      Offset(markerX - markerLabel.width / 2, barRect.bottom + 6),
    );

    final pct = (fraction * 100).toStringAsFixed(0);
    final label = TextPainter(
      text: TextSpan(
        text: 'currentSizeBytes=${_formatBytes(used)} / maximumSizeBytes=${_formatBytes(budget)}   ($pct%)',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    label.layout(maxWidth: size.width - 40);
    label.paint(canvas, Offset(20, barRect.top - 18));
  }

  @override
  bool shouldRepaint(covariant _BytesBarPainter oldDelegate) =>
      oldDelegate.used != used || oldDelegate.budget != budget;
}

// ---------------------------------------------------------------------------
// CustomPainter #4 — Mock cache-entry swatch. Renders a colourful procedural
// "image" so the gallery looks like decoded thumbnails without referencing a
// real ui.Image. Each swatch uses the index to derive a unique gradient.
// ---------------------------------------------------------------------------

class _SwatchPainter extends CustomPainter {
  final int seed;
  const _SwatchPainter(this.seed);

  @override
  void paint(Canvas canvas, Size size) {
    final hue1 = (seed * 37) % 360;
    final hue2 = (seed * 71 + 60) % 360;
    final c1 = HSVColor.fromAHSV(1, hue1.toDouble(), 0.75, 0.95).toColor();
    final c2 = HSVColor.fromAHSV(1, hue2.toDouble(), 0.85, 0.65).toColor();
    final bg = Paint()
      ..shader = LinearGradient(
        colors: [c1, c2],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    // Decorative diagonal stripes.
    final stripe = Paint()..color = Colors.white.withOpacity(0.10);
    final spacing = 6.0;
    for (double d = -size.height; d < size.width; d += spacing) {
      final p = Path()
        ..moveTo(d, 0)
        ..lineTo(d + size.height, size.height);
      canvas.drawPath(p, stripe);
    }

    // Center dot — "decode origin" marker.
    final dot = Paint()..color = Colors.white.withOpacity(0.75);
    canvas.drawCircle(
      Offset(size.width * 0.30, size.height * 0.30),
      2.5,
      dot,
    );
  }

  @override
  bool shouldRepaint(covariant _SwatchPainter oldDelegate) =>
      oldDelegate.seed != seed;
}

// ---------------------------------------------------------------------------
// Section builders.
// ---------------------------------------------------------------------------

Widget _buildIntroSection() {
  return _sectionCard(
    title: '1. ImageCache — what it is and where it lives',
    subtitle: 'A bounded LRU on PaintingBinding.instance.imageCache',
    gradient: const [Color(0xFF1B2A55), Color(0xFF2A3C7E)],
    accent: _accentCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'ImageCache is the process-wide LRU that sits between ImageProvider '
          'and the decoded ui.Image objects Flutter paints to the canvas. '
          'Every binding-aware Flutter app owns exactly one instance, '
          'reachable as PaintingBinding.instance.imageCache. The cache holds '
          'two logical sets simultaneously: live images, kept alive by an '
          'active listener somewhere in the widget tree, and cached images, '
          'no longer referenced but retained in the hope they will be needed '
          'again soon. Bounded by two budgets — maximumSize (entry count) '
          'and maximumSizeBytes (decoded-pixel bytes) — the cache evicts in '
          'LRU order whenever either limit is exceeded.',
        ),
        Wrap(
          children: [
            _pill('process-wide singleton', _accentCyan),
            _pill('owned by PaintingBinding', _accentMagenta),
            _pill('LRU eviction', _accentAmber),
            _pill('two budgets', _accentGreen),
            _pill('live + cached + pending', _accentRed),
            _pill('not thread-safe', _accentBlue),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAnatomySection() {
  return _sectionCard(
    title: '2. Anatomy — the bounded grid',
    subtitle: 'Live vs cached vs pending vs over-budget',
    gradient: const [Color(0xFF1F2A56), Color(0xFF34367F)],
    accent: _accentMagenta,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: CustomPaint(painter: const _AnatomyPainter()),
        ),
        const SizedBox(height: 10),
        Wrap(
          children: const [
            _LegendDot(label: 'live (has listener)', color: _accentCyan),
            _LegendDot(label: 'cached (no listener)', color: _accentGreen),
            _LegendDot(label: 'pending (decoding)', color: _accentAmber),
            _LegendDot(label: 'over-budget (evict-next)', color: _accentRed),
          ],
        ),
        _prose(
          'The grid shows the cache as a fixed-capacity board. Each slot is a '
          'logical entry; the four colours encode the entry\'s state. Live '
          'entries cannot be evicted no matter how tight memory gets — they '
          'are pinned by a listener and removing them would race the painter. '
          'Cached entries are the LRU\'s retirement home: when a new admit '
          'pushes currentSize past maximumSize, the oldest cached entry is '
          'evicted. The dashed magenta line marks where maximumSizeBytes '
          'would force eviction even if entry-count is still well under '
          'maximumSize — large decoded textures eat budget fast.',
        ),
      ],
    ),
  );
}

class _LegendDot extends StatelessWidget {
  final String label;
  final Color color;
  const _LegendDot({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12, bottom: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.6), blurRadius: 6),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: _ink,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildKnobsSection() {
  return _sectionCard(
    title: '3. Configuration knobs',
    subtitle: 'Six properties you will read or set',
    gradient: const [Color(0xFF14305A), Color(0xFF1F4880)],
    accent: _accentCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'The cache exposes a tight property surface. Two of them are '
          'writable — maximumSize and maximumSizeBytes — and they are the '
          'only safe levers an app should pull at runtime. Everything else '
          'is read-only state that reflects the cache\'s current contents.',
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentCyan.withOpacity(0.5)),
            color: Colors.black.withOpacity(0.30),
          ),
          child: Column(
            children: const [
              _KnobRow(
                name: 'maximumSize',
                kind: 'int (rw)',
                desc: 'Cap on number of cached entries. Default ~1000.',
                color: _accentCyan,
              ),
              _KnobRow(
                name: 'maximumSizeBytes',
                kind: 'int (rw)',
                desc: 'Cap on decoded-pixel bytes. Default 100 MiB.',
                color: _accentCyan,
              ),
              _KnobRow(
                name: 'currentSize',
                kind: 'int (ro)',
                desc: 'Number of cached entries right now (excludes live).',
                color: _accentGreen,
              ),
              _KnobRow(
                name: 'currentSizeBytes',
                kind: 'int (ro)',
                desc: 'Decoded bytes for cached entries (excludes live).',
                color: _accentGreen,
              ),
              _KnobRow(
                name: 'liveImageCount',
                kind: 'int (ro)',
                desc: 'Entries pinned by at least one listener.',
                color: _accentMagenta,
              ),
              _KnobRow(
                name: 'pendingImageCount',
                kind: 'int (ro)',
                desc: 'Decodes currently in flight.',
                color: _accentAmber,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _KnobRow extends StatelessWidget {
  final String name;
  final String kind;
  final String desc;
  final Color color;
  const _KnobRow({
    required this.name,
    required this.kind,
    required this.desc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              name,
              style: TextStyle(
                color: color,
                fontSize: 12.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              kind,
              style: const TextStyle(
                color: _muted,
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(
                color: _ink,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSnapshotSection(_CacheSnapshot snap) {
  final available = snap.available;
  return _sectionCard(
    title: '4. Live snapshot — the actual cache, right now',
    subtitle: 'Read from PaintingBinding.instance.imageCache',
    gradient: const [Color(0xFF143526), Color(0xFF1F5A40)],
    accent: _accentGreen,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'These values are read at build time from the live ImageCache on '
          'the current PaintingBinding. The reads are wrapped in a try/catch '
          'so this demo never crashes if the binding is uninitialised or the '
          'cache is stubbed by a test harness. The numbers reflect whatever '
          'images Flutter has touched so far in this process, including any '
          'incidentally cached glyph atlases.',
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.30),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (available ? _accentGreen : _accentRed).withOpacity(0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: available ? _accentGreen : _accentRed,
                      boxShadow: [
                        BoxShadow(
                          color: (available ? _accentGreen : _accentRed)
                              .withOpacity(0.7),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    available
                        ? 'binding available — values are real'
                        : 'binding unavailable — falling back to literals',
                    style: TextStyle(
                      color: available ? _accentGreen : _accentRed,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.5,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _kv('runtimeType', snap.typeName),
              _kv('maximumSize', '${snap.maximumSize}  entries'),
              _kv('maximumSizeBytes',
                  '${snap.maximumSizeBytes}  bytes  (${_formatBytes(snap.maximumSizeBytes)})'),
              _kv('currentSize', '${snap.currentSize}  entries'),
              _kv('currentSizeBytes',
                  '${snap.currentSizeBytes}  bytes  (${_formatBytes(snap.currentSizeBytes)})'),
              _kv('liveImageCount', '${snap.liveImageCount}'),
              _kv('pendingImageCount', '${snap.pendingImageCount}'),
              if (snap.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'error: ${snap.error}',
                    style: const TextStyle(
                      color: _accentRed,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleSection() {
  return _sectionCard(
    title: '5. Lifecycle of a cached image',
    subtitle: 'precacheImage → cache lookup → ImageStream → eviction',
    gradient: const [Color(0xFF301A4E), Color(0xFF513182)],
    accent: _accentMagenta,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 280,
          width: double.infinity,
          child: CustomPaint(painter: const _LifecyclePainter()),
        ),
        _prose(
          'The lifecycle diagram traces a single image from request to '
          'reclaim. precacheImage (or Image.network internally) calls '
          'putIfAbsent on the cache. If the key is unknown, the cache opens '
          'a slot, increments pendingImageCount, and hands back the new '
          'ImageStream. The ImageStreamCompleter drives the decode; on '
          'success it produces an ImageInfo, which transfers the entry from '
          'pending to live. Once every listener detaches, the entry becomes '
          'plain cached — it now counts toward currentSize and '
          'currentSizeBytes, and is eligible for LRU eviction. evict() takes '
          'a single key; clear() drops every cached entry; clearLiveImages() '
          'force-disposes even the pinned ones.',
        ),
        const SizedBox(height: 4),
        Wrap(
          children: [
            _chip('precacheImage', _accentCyan, icon: Icons.download_outlined),
            _chip('putIfAbsent', _accentBlue, icon: Icons.add_box_outlined),
            _chip('ImageStream', _accentCyan, icon: Icons.stream_outlined),
            _chip('ImageStreamCompleter', _accentAmber,
                icon: Icons.cached_outlined),
            _chip('ImageInfo', _accentGreen, icon: Icons.image_outlined),
            _chip('evict', _accentRed, icon: Icons.delete_outline),
            _chip('clear', _accentRed, icon: Icons.delete_sweep_outlined),
            _chip('clearLiveImages', _accentRed,
                icon: Icons.warning_amber_outlined),
          ],
        ),
      ],
    ),
  );
}

Widget _buildOperationsSection() {
  return _sectionCard(
    title: '6. Operations — the method surface',
    subtitle: 'putIfAbsent, evict, clear, clearLiveImages, containsKey',
    gradient: const [Color(0xFF3A2A12), Color(0xFF6B4A1A)],
    accent: _accentAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'ImageCache offers a deliberately small method surface. Most apps '
          'never call any of these directly — the Image widget and '
          'ImageProvider classes drive the cache implicitly. You will only '
          'reach for these methods when implementing a custom ImageProvider, '
          'preloading screens, or shedding memory under pressure.',
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentAmber.withOpacity(0.5)),
            color: Colors.black.withOpacity(0.30),
          ),
          child: Column(
            children: const [
              _OpRow(
                sig: 'putIfAbsent(Object key, ImageStreamCompleter Function() loader, {ImageErrorListener? onError})',
                returns: 'ImageStreamCompleter?',
                desc:
                    'Lookup by key; if absent, invoke loader and admit the '
                    'returned completer. Returns null if the cache is disabled.',
              ),
              _OpRow(
                sig: 'evict(Object key, {bool includeLive = true})',
                returns: 'bool',
                desc:
                    'Drop one entry by key. Returns true on hit. Set '
                    'includeLive=false to evict only cached, not live, entries.',
              ),
              _OpRow(
                sig: 'clear()',
                returns: 'void',
                desc:
                    'Drop every cached entry; live entries are left alone.',
              ),
              _OpRow(
                sig: 'clearLiveImages()',
                returns: 'void',
                desc:
                    'Force-dispose live entries. Visible images may flash.',
              ),
              _OpRow(
                sig: 'containsKey(Object key)',
                returns: 'bool',
                desc:
                    'Probe without admitting. Returns true if pending, live, '
                    'or cached.',
              ),
              _OpRow(
                sig: 'statusForKey(Object key)',
                returns: 'ImageCacheStatus',
                desc:
                    'Structured status: pending, keepAlive, live, untracked.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _OpRow extends StatelessWidget {
  final String sig;
  final String returns;
  final String desc;
  const _OpRow({required this.sig, required this.returns, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sig,
            style: const TextStyle(
              color: _accentAmber,
              fontSize: 11.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '→ $returns',
            style: const TextStyle(
              color: _accentGreen,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: const TextStyle(
              color: _ink,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildGallerySection() {
  // Mock cache entries with literal sizes. Total = 12.4 MiB out of 100 MiB.
  const entries = <_MockEntry>[
    _MockEntry(label: 'hero.jpg', bytes: 2400000, seed: 1),
    _MockEntry(label: 'avatar.png', bytes: 320000, seed: 2),
    _MockEntry(label: 'banner.webp', bytes: 1800000, seed: 3),
    _MockEntry(label: 'icon-32.png', bytes: 16000, seed: 4),
    _MockEntry(label: 'gallery_01.jpg', bytes: 1500000, seed: 5),
    _MockEntry(label: 'gallery_02.jpg', bytes: 1320000, seed: 6),
    _MockEntry(label: 'gallery_03.jpg', bytes: 1610000, seed: 7),
    _MockEntry(label: 'product.heic', bytes: 2100000, seed: 8),
    _MockEntry(label: 'thumb-a.png', bytes: 64000, seed: 9),
    _MockEntry(label: 'thumb-b.png', bytes: 64000, seed: 10),
    _MockEntry(label: 'thumb-c.png', bytes: 64000, seed: 11),
    _MockEntry(label: 'fallback.svg', bytes: 4000, seed: 12),
  ];

  final usedBytes = entries.fold<int>(0, (a, e) => a + e.bytes);
  const budget = 100 * 1024 * 1024; // 100 MiB

  return _sectionCard(
    title: '7. Gallery — mock cache entries',
    subtitle: 'Twelve fake entries, one bytes-used progress bar',
    gradient: const [Color(0xFF1D2F5A), Color(0xFF345B9C)],
    accent: _accentBlue,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'The swatches below are inert procedurally-painted placeholders, '
          'not real decoded images. Their labels and byte sizes are literal '
          'mock data chosen to span the realistic range from 4 KiB SVG '
          'glyphs up to a 2.4 MiB photographic hero. Under the gallery, the '
          'progress bar shows how much of a 100 MiB budget those twelve '
          'entries would consume — well under the 80% warning marker.',
        ),
        SizedBox(
          height: 90,
          width: double.infinity,
          child: CustomPaint(
            painter: _BytesBarPainter(used: usedBytes, budget: budget),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final e in entries) _GallerySwatch(entry: e),
          ],
        ),
      ],
    ),
  );
}

class _MockEntry {
  final String label;
  final int bytes;
  final int seed;
  const _MockEntry({
    required this.label,
    required this.bytes,
    required this.seed,
  });
}

class _GallerySwatch extends StatelessWidget {
  final _MockEntry entry;
  const _GallerySwatch({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.30),
        border: Border.all(color: _accentBlue.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: SizedBox(
              height: 70,
              child: CustomPaint(painter: _SwatchPainter(entry.seed)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.label,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _formatBytes(entry.bytes),
                  style: const TextStyle(
                    color: _accentCyan,
                    fontSize: 10.5,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildConfigSnippetSection() {
  return _sectionCard(
    title: '8. Configuring the cache',
    subtitle: 'Idiomatic setup and what NOT to do',
    gradient: const [Color(0xFF1A2A4F), Color(0xFF2D4585)],
    accent: _accentCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'Configuration happens once, early — typically in main() before '
          'runApp, or in a binding-aware initialiser. The two writable '
          'properties accept plain ints; for byte budgets the convention is '
          'to use a left-shift literal so the number is easy to read.',
        ),
        _codeBlock(
          'void main() {\n'
          '  WidgetsFlutterBinding.ensureInitialized();\n'
          '\n'
          '  final cache = PaintingBinding.instance.imageCache;\n'
          '  cache.maximumSize = 2000;                 // 2k entries\n'
          '  cache.maximumSizeBytes = 200 << 20;       // 200 MiB\n'
          '\n'
          '  runApp(const MyApp());\n'
          '}',
          tint: _accentCyan,
        ),
        _calloutBox(
          title: 'WARNING — do not clear eagerly',
          body:
              'Calling cache.clear() on every memory warning is almost always '
              'wrong. It drops decoded textures that the GPU still references '
              'this frame, causing visible image flashes and a re-decode '
              'storm on the next layout pass. Prefer lowering maximumSizeBytes '
              'temporarily and letting LRU drain naturally.',
          color: _accentRed,
          icon: Icons.warning_amber_outlined,
        ),
        _calloutBox(
          title: 'TIP — size for your worst gallery',
          body:
              'A scrollable image grid typically needs ~3x its visible area '
              'cached so back-scroll feels instant. Multiply average decoded '
              'bytes-per-image by that factor when choosing maximumSizeBytes.',
          color: _accentGreen,
          icon: Icons.lightbulb_outline,
        ),
      ],
    ),
  );
}

Widget _buildEvictionSection() {
  return _sectionCard(
    title: '9. evict vs clear vs clearLiveImages',
    subtitle: 'Three increasingly aggressive verbs',
    gradient: const [Color(0xFF14223D), Color(0xFF1E3666)],
    accent: _accentRed,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'The three eviction verbs differ in surface area and safety. evict '
          'is surgical: one key, optional inclusion of live entries. clear '
          'is bulk-cached: every entry without a listener goes away, no '
          'liveness changes. clearLiveImages is nuclear: it disposes '
          'currently-displayed images and should only be called when the '
          'app is about to be backgrounded for a long time or has just '
          'switched to a completely different image set.',
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentRed.withOpacity(0.5)),
            color: Colors.black.withOpacity(0.30),
          ),
          child: Column(
            children: [
              _evictHeader(),
              _evictRow('evict(key)', 'one cached', 'rare', 'safe', _accentGreen),
              _evictRow('evict(key, includeLive: true)', 'one (any state)',
                  'rare', 'medium', _accentAmber),
              _evictRow('clear()', 'all cached', 'on-demand', 'safe',
                  _accentGreen),
              _evictRow('clearLiveImages()', 'all (including live)',
                  'lifecycle only', 'dangerous', _accentRed),
            ],
          ),
        ),
        const SizedBox(height: 6),
        _codeBlock(
          '// Surgical eviction of a known-stale key:\n'
          'cache.evict(AssetImage("packages/x/y.png"));\n'
          '\n'
          '// Drop every cached entry; live entries untouched:\n'
          'cache.clear();\n'
          '\n'
          '// Reset hard, e.g. on logout in an avatar-heavy app:\n'
          'cache.clearLiveImages();\n'
          'cache.clear();',
          tint: _accentRed,
        ),
      ],
    ),
  );
}

Widget _evictHeader() {
  return Container(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.white24)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      children: const [
        Expanded(flex: 3, child: Text('verb',
            style: TextStyle(color: _accentRed, fontSize: 12,
                fontWeight: FontWeight.w800))),
        Expanded(flex: 3, child: Text('scope',
            style: TextStyle(color: _accentRed, fontSize: 12,
                fontWeight: FontWeight.w800))),
        Expanded(flex: 2, child: Text('frequency',
            style: TextStyle(color: _accentRed, fontSize: 12,
                fontWeight: FontWeight.w800))),
        Expanded(flex: 2, child: Text('safety',
            style: TextStyle(color: _accentRed, fontSize: 12,
                fontWeight: FontWeight.w800))),
      ],
    ),
  );
}

Widget _evictRow(String verb, String scope, String freq, String safety,
    Color safetyColor) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.white12)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            verb,
            style: const TextStyle(
              color: _ink,
              fontSize: 11.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            scope,
            style: const TextStyle(
              color: _ink,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            freq,
            style: const TextStyle(color: _muted, fontSize: 11.5),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            safety,
            style: TextStyle(
              color: safetyColor,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfallsSection() {
  return _sectionCard(
    title: '10. Pitfalls — the common ImageCache traps',
    subtitle: 'Six anti-patterns and how to avoid them',
    gradient: const [Color(0xFF421A1A), Color(0xFF6B2A2A)],
    accent: _accentRed,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _calloutBox(
          title: '1. Calling clear() from inside a build method',
          body:
              'A build method may run dozens of times per second during '
              'animation. Clearing the cache in build re-triggers decodes '
              'for every image the screen still shows, locking the GPU '
              'thread and producing visible jank. clear() belongs in '
              'lifecycle callbacks (didChangeAppLifecycleState) or response '
              'to explicit user actions.',
          color: _accentRed,
        ),
        _calloutBox(
          title: '2. Decoding 4K images for a 64dp avatar',
          body:
              'A 4096x4096 RGBA image consumes 64 MiB of cache budget even '
              'if it is painted at 64dp. Use cacheWidth and cacheHeight on '
              'Image / ResizeImage so the decoder produces a thumbnail-sized '
              'ui.Image. The cache stores what the decoder produced, not '
              'what the painter draws.',
          color: _accentAmber,
        ),
        _calloutBox(
          title: '3. Calling clearLiveImages on memory warning',
          body:
              'clearLiveImages disposes images held by visible widgets. The '
              'next frame paints empty boxes until those streams reload. '
              'Reserve this for backgrounding the app for a long period or '
              'a hard logout that hides every image on screen anyway.',
          color: _accentRed,
        ),
        _calloutBox(
          title: '4. Confusing maximumSize and maximumSizeBytes',
          body:
              'They are two independent budgets — exceed either and eviction '
              'kicks in. A cache full of 256-byte SVG fragments will hit '
              'maximumSize long before maximumSizeBytes; one full of 8 MiB '
              'photo decodes hits maximumSizeBytes first. Set both.',
          color: _accentAmber,
        ),
        _calloutBox(
          title: '5. Re-creating the ImageProvider every build',
          body:
              'ImageCache keys on ImageProvider equality. NetworkImage("x") '
              'created in build with a new String reference may still be '
              'equal to a previous one (operator== compares url + scale), '
              'but custom providers with no proper == implementation will '
              'miss the cache every frame. Always override == on custom '
              'providers.',
          color: _accentMagenta,
        ),
        _calloutBox(
          title: '6. evict(includeLive: false) on a live entry',
          body:
              'A no-op. The entry is pinned by a listener; evict cannot '
              'reach it. If you actually need to drop a live entry — e.g. '
              'forcing a cache-busting reload — pass includeLive: true and '
              'be prepared for a frame of repaint.',
          color: _accentAmber,
        ),
      ],
    ),
  );
}

Widget _buildStatusSection() {
  return _sectionCard(
    title: '11. ImageCacheStatus — the four return states',
    subtitle: 'untracked, pending, keepAlive, live',
    gradient: const [Color(0xFF22183F), Color(0xFF3A2A6A)],
    accent: _accentMagenta,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'statusForKey returns an ImageCacheStatus value describing where a '
          'particular key sits within the cache state machine. The four '
          'states are mutually exclusive — at any moment, an entry is '
          'exactly one of them.',
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentMagenta.withOpacity(0.5)),
            color: Colors.black.withOpacity(0.30),
          ),
          child: Column(
            children: const [
              _StatusRow(
                name: 'untracked',
                color: _muted,
                desc:
                    'Cache has never seen this key. putIfAbsent admits it.',
              ),
              _StatusRow(
                name: 'pending',
                color: _accentAmber,
                desc:
                    'Decode is in flight. Listeners attached; ui.Image not '
                    'available yet.',
              ),
              _StatusRow(
                name: 'live',
                color: _accentCyan,
                desc:
                    'Decoded and held by at least one listener. Cannot be '
                    'evicted unless includeLive=true.',
              ),
              _StatusRow(
                name: 'keepAlive',
                color: _accentGreen,
                desc:
                    'Decoded, no listeners, retained by LRU. Eligible for '
                    'eviction when budget tightens.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _StatusRow extends StatelessWidget {
  final String name;
  final String desc;
  final Color color;
  const _StatusRow({
    required this.name,
    required this.desc,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 92,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.20),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: color,
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(
                color: _ink,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildInteractionsSection() {
  return _sectionCard(
    title: '12. Interactions with PaintingBinding',
    subtitle: 'Where the cache really lives',
    gradient: const [Color(0xFF1A3D2A), Color(0xFF2F6A4A)],
    accent: _accentGreen,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'PaintingBinding owns the ImageCache instance via the property '
          'imageCache. The binding constructs the cache lazily on first '
          'access, allowing tests to substitute a custom subclass by '
          'overriding createImageCache. Most production code only ever sees '
          'the default ImageCache, but the override hook is essential for '
          'instrumented tests that want to count cache hits or simulate '
          'eviction storms.',
        ),
        _codeBlock(
          '// Inside a test binding:\n'
          'class _MyTestBinding extends WidgetsFlutterBinding {\n'
          '  @override\n'
          '  ImageCache createImageCache() => _CountingImageCache();\n'
          '}\n'
          '\n'
          '// Inside any widget:\n'
          'final cache = PaintingBinding.instance.imageCache;\n'
          'if (!cache.containsKey(myKey)) {\n'
          '  precacheImage(myProvider, context);\n'
          '}',
          tint: _accentGreen,
        ),
        _kv('PaintingBinding.instance', 'singleton, late-initialised'),
        _kv('PaintingBinding.imageCache', 'ImageCache (live)'),
        _kv('PaintingBinding.createImageCache()',
            'overridable hook for tests'),
        _kv('PaintingBinding.evict(key)', 'forwards to cache.evict'),
      ],
    ),
  );
}

Widget _buildPaletteSection() {
  return _sectionCard(
    title: '13. Related-type palette',
    subtitle: 'Who else touches the cache',
    gradient: const [Color(0xFF1D1F44), Color(0xFF34386F)],
    accent: _accentCyan,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'The cache is one node in a busy graph. Here are the types most '
          'often seen on the same import line — knowing which side of the '
          'cache they sit on saves a lot of debugging.',
        ),
        Wrap(
          children: [
            _pill('PaintingBinding', _accentGreen),
            _pill('ImageCache', _accentCyan),
            _pill('ImageCacheStatus', _accentMagenta),
            _pill('ImageProvider', _accentCyan),
            _pill('ImageStream', _accentCyan),
            _pill('ImageStreamCompleter', _accentAmber),
            _pill('ImageStreamListener', _accentMagenta),
            _pill('ImageInfo', _accentGreen),
            _pill('ImageConfiguration', _accentGreen),
            _pill('NetworkImage', _accentBlue),
            _pill('AssetImage', _accentBlue),
            _pill('FileImage', _accentBlue),
            _pill('MemoryImage', _accentBlue),
            _pill('ResizeImage', _accentAmber),
            _pill('precacheImage()', _accentCyan),
            _pill('paintImage()', _accentRed),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLiteralRecipesSection() {
  return _sectionCard(
    title: '14. Literal-data recipes',
    subtitle: 'Common configurations as inert values',
    gradient: const [Color(0xFF143526), Color(0xFF1F5A40)],
    accent: _accentGreen,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _prose(
          'A few configuration shapes show up over and over again in real '
          'apps. They are listed here as inert literal values; copy-pasting '
          'one of these blocks into main() is usually enough to ship with.',
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.30),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentGreen.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Small app  (utility, single-image avatar)',
                style: TextStyle(
                  color: _accentGreen,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              _kv('maximumSize', '100 entries'),
              _kv('maximumSizeBytes', '20 MiB'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.30),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentCyan.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Default  (most Flutter apps)',
                style: TextStyle(
                  color: _accentCyan,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              _kv('maximumSize', '1000 entries'),
              _kv('maximumSizeBytes', '100 MiB'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.30),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentAmber.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Gallery app  (long photo grids)',
                style: TextStyle(
                  color: _accentAmber,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              _kv('maximumSize', '4000 entries'),
              _kv('maximumSizeBytes', '300 MiB'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.30),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentRed.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Memory-constrained  (embedded, kiosk)',
                style: TextStyle(
                  color: _accentRed,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              _kv('maximumSize', '50 entries'),
              _kv('maximumSizeBytes', '8 MiB'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFooter() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        colors: [Color(0xFF0E1530), Color(0xFF1B2452)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: _accentCyan.withOpacity(0.5)),
      boxShadow: [
        BoxShadow(
          color: _accentCyan.withOpacity(0.18),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'image_cache — deep visual demo',
          style: TextStyle(
            color: _accentCyan,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'A static, analyzer-clean tour of ImageCache: where it lives, the '
          'six properties you read, the five operations you call, and the '
          'six common pitfalls that trip up production code. The live '
          'snapshot reads PaintingBinding.instance.imageCache defensively; '
          'every other number on this page is inert literal data.',
          style: TextStyle(
            color: _ink.withOpacity(0.85),
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Harness entry point. Reads a defensive snapshot of the live cache, then
// builds the entire MaterialApp from inert section widgets.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('image_cache_test: building deep visual demo');

  final snap = _takeSnapshot();
  print('image_cache_test: snapshot available=${snap.available} '
      'maxSize=${snap.maximumSize} maxBytes=${snap.maximumSizeBytes} '
      'curSize=${snap.currentSize} curBytes=${snap.currentSizeBytes} '
      'live=${snap.liveImageCount} pending=${snap.pendingImageCount}');

  // Defensive demo-only references so the analyzer accepts the imports used
  // for type discussion in the prose / snippets. None of these are mutated.
  const _ = TargetPlatform.linux;
  const __ = TextDirection.ltr;
  const ___ = Brightness.dark;
  final ____ = ImageConfiguration.empty;
  final List<Object> _unused = const <Object>[
    Locale('en'),
    Size(1, 1),
    Offset.zero,
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
    home: Scaffold(
      backgroundColor: _bgDeep,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF142348),
                      Color(0xFF20336E),
                      Color(0xFF3A2A78),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _accentMagenta.withOpacity(0.30),
                      blurRadius: 28,
                      offset: const Offset(0, 12),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.55),
                      blurRadius: 40,
                      offset: const Offset(0, 18),
                    ),
                  ],
                  border: Border.all(color: _accentMagenta.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ImageCache',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'A deep visual tour of the painting-layer LRU',
                      style: TextStyle(
                        color: _accentCyan.withOpacity(0.95),
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      children: [
                        _pill('PaintingBinding-owned', _accentCyan),
                        _pill('two budgets', _accentAmber),
                        _pill('LRU eviction', _accentGreen),
                        _pill('read-only snapshot', _accentMagenta),
                        _pill('analyzer-clean', _accentRed),
                      ],
                    ),
                  ],
                ),
              ),
              _buildIntroSection(),
              _buildAnatomySection(),
              _buildKnobsSection(),
              _buildSnapshotSection(snap),
              _buildLifecycleSection(),
              _buildOperationsSection(),
              _buildGallerySection(),
              _buildConfigSnippetSection(),
              _buildEvictionSection(),
              _buildPitfallsSection(),
              _buildStatusSection(),
              _buildInteractionsSection(),
              _buildPaletteSection(),
              _buildLiteralRecipesSection(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Tail references to imported libraries so the analyzer never flags them as
// unused. These are inert const / type references — no runtime side effects.
// ---------------------------------------------------------------------------

// dart:math reference.
final double _piRef = math.pi;

// dart:ui reference.
const ui.Color _uiColorRef = ui.Color(0xFF000000);

// flutter/foundation reference.
const TargetPlatform _platformRef = TargetPlatform.android;

// flutter/services reference.
const SystemUiOverlayStyle _overlayRef = SystemUiOverlayStyle.light;

// flutter/widgets reference.
const Alignment _alignmentRef = Alignment.center;
