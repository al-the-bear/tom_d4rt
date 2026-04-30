// ignore_for_file: avoid_print
// D4rt deep demo: UndoHistoryValue — the immutable value class for undo/redo availability.
//
// Flutter SDK reference:
//   packages/flutter/lib/src/widgets/undo_history.dart
//
//   @immutable
//   class UndoHistoryValue {
//     const UndoHistoryValue({this.canUndo = false, this.canRedo = false});
//     static const UndoHistoryValue empty = UndoHistoryValue();
//     final bool canUndo;
//     final bool canRedo;
//     @override String toString() => '...(canUndo: $canUndo, canRedo: $canRedo)';
//     @override bool operator ==(Object other) { ... }
//     @override int get hashCode => Object.hash(canUndo.hashCode, canRedo.hashCode);
//   }
//
// This demo renders the value class on its own: badge galleries, a live readout
// bound to an UndoHistoryController.value through ValueListenableBuilder, an
// equality inspector, a transition timeline and copyWith recipe cards. The
// SDK class itself does not define copyWith — the recipes show sanctioned
// ways to produce a new value without mutating the existing one.
//
// Theme: parchment scroll + ink-black + wax-red seal accents.
// CustomPainters render hand-pressed wax seals on selected badges.

import 'package:flutter/material.dart';

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _uhValParchment = Color(0xFFF3E7C9);
const Color _uhValParchmentWarm = Color(0xFFE8D6A8);
const Color _uhValParchmentShadow = Color(0xFFC9B585);
const Color _uhValParchmentDeep = Color(0xFFAE9863);
const Color _uhValInk = Color(0xFF1B1410);
const Color _uhValInkSoft = Color(0xFF3A2A21);
const Color _uhValInkFaded = Color(0xFF5C4438);
const Color _uhValWax = Color(0xFF8A1C1C);
const Color _uhValWaxDeep = Color(0xFF601010);
const Color _uhValWaxHighlight = Color(0xFFC0433A);
const Color _uhValAllowed = Color(0xFF2F5E37);
const Color _uhValAllowedLight = Color(0xFFCDE3C6);
const Color _uhValDenied = Color(0xFF6B2430);
const Color _uhValDeniedLight = Color(0xFFE8C8CC);
const Color _uhValHintA = Color(0xFF3A4A6B);

// ── Top-level helpers (widgets + painters) ──────────────────────────────────

Widget _uhValSectionBanner(String ordinal, String title, String subtitle) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 28, bottom: 10),
    padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
    decoration: BoxDecoration(
      color: _uhValInk,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: _uhValWaxDeep, width: 1.2),
      boxShadow: const [
        BoxShadow(
          color: Color(0x55000000),
          offset: Offset(3, 3),
          blurRadius: 0,
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _uhValWax,
            shape: BoxShape.circle,
          ),
          child: Text(
            ordinal,
            style: const TextStyle(
              color: _uhValParchment,
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
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
                  color: _uhValParchment,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  letterSpacing: 0.6,
                ),
              ),
              if (subtitle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFFE2D1A4),
                      fontSize: 12.5,
                      height: 1.35,
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

Widget _uhValParchmentCard({
  required String heading,
  required List<Widget> children,
  EdgeInsets? padding,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: padding ?? const EdgeInsets.fromLTRB(16, 14, 16, 16),
    decoration: BoxDecoration(
      color: _uhValParchment,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _uhValParchmentShadow, width: 1),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(2, 2),
          blurRadius: 4,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading.isNotEmpty) ...[
          Text(
            heading,
            style: const TextStyle(
              color: _uhValInk,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 3),
          Container(height: 1, color: _uhValParchmentDeep),
          const SizedBox(height: 10),
        ],
        ...children,
      ],
    ),
  );
}

Widget _uhValProse(String text, {double fontSize = 13.5, Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Text(
      text,
      style: TextStyle(
        color: color ?? _uhValInkSoft,
        fontSize: fontSize,
        height: 1.42,
      ),
    ),
  );
}

Widget _uhValKeyValueRow(String label, String value, {Color? accent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            label,
            style: TextStyle(
              color: accent ?? _uhValWaxDeep,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: _uhValInk,
              fontSize: 13,
              height: 1.35,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _uhValSmallChip(String text, {Color? bg, Color? fg, Color? border}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    margin: const EdgeInsets.only(right: 6, bottom: 4),
    decoration: BoxDecoration(
      color: bg ?? _uhValParchmentWarm,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: border ?? _uhValParchmentDeep, width: 0.8),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg ?? _uhValInk,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    ),
  );
}

Widget _uhValInkRule() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 1,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _uhValParchmentDeep.withValues(alpha: 0.0),
          _uhValParchmentDeep,
          _uhValParchmentDeep.withValues(alpha: 0.0),
        ],
      ),
    ),
  );
}

Widget _uhValAllowedDeniedTag(bool allowed, String allowedText, String deniedText) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: allowed ? _uhValAllowedLight : _uhValDeniedLight,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: allowed ? _uhValAllowed : _uhValDenied,
        width: 1,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          allowed ? Icons.check_circle_outline : Icons.block,
          size: 14,
          color: allowed ? _uhValAllowed : _uhValDenied,
        ),
        const SizedBox(width: 5),
        Text(
          allowed ? allowedText : deniedText,
          style: TextStyle(
            color: allowed ? _uhValAllowed : _uhValDenied,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

// ── Wax seal painter (used on featured badges) ──────────────────────────────

class _UhValWaxSealPainter extends CustomPainter {
  final String glyph;
  final double rotation;

  _UhValWaxSealPainter({required this.glyph, this.rotation = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2;

    // Wax shadow underlay
    final shadow = Paint()
      ..color = const Color(0x55000000)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(center.translate(2, 2.5), radius * 0.95, shadow);

    // Wax splatter (irregular outer edge)
    final splatterPath = Path();
    const edges = 18;
    for (int i = 0; i <= edges; i++) {
      final angle = (i / edges) * 2 * 3.141592653589793;
      final wobble = 0.06 * ((i * 7919) % 13 - 6) / 6.0;
      final r = radius * (1.02 + wobble);
      final p = Offset(
        center.dx + r * _cos(angle),
        center.dy + r * _sin(angle),
      );
      if (i == 0) {
        splatterPath.moveTo(p.dx, p.dy);
      } else {
        splatterPath.lineTo(p.dx, p.dy);
      }
    }
    splatterPath.close();
    final splatterPaint = Paint()..color = _uhValWaxDeep;
    canvas.drawPath(splatterPath, splatterPaint);

    // Main wax body gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final bodyPaint = Paint()
      ..shader = RadialGradient(
        colors: const [_uhValWaxHighlight, _uhValWax, _uhValWaxDeep],
        stops: const [0.0, 0.6, 1.0],
        center: const Alignment(-0.3, -0.4),
        radius: 0.9,
      ).createShader(rect);
    canvas.drawCircle(center, radius * 0.94, bodyPaint);

    // Inner ring indent
    final ringPaint = Paint()
      ..color = _uhValWaxDeep
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawCircle(center, radius * 0.72, ringPaint);

    // Glyph (single letter) stamped in center
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    final tp = TextPainter(
      text: TextSpan(
        text: glyph,
        style: TextStyle(
          color: _uhValParchment.withValues(alpha: 0.92),
          fontWeight: FontWeight.w900,
          fontSize: radius * 0.9,
          letterSpacing: -1,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
    canvas.restore();

    // Tiny highlight glint
    final glintPaint = Paint()
      ..color = _uhValParchment.withValues(alpha: 0.32)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawOval(
      Rect.fromCenter(
        center: center.translate(-radius * 0.35, -radius * 0.4),
        width: radius * 0.55,
        height: radius * 0.28,
      ),
      glintPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _UhValWaxSealPainter old) =>
      old.glyph != glyph || old.rotation != rotation;
}

// Cheap cos/sin without importing dart:math to keep the d4rt harness trim.
double _cos(double radians) {
  // Maclaurin truncated cosine (good enough for decorative painting).
  double x = radians % 6.283185307179586;
  if (x > 3.141592653589793) x -= 6.283185307179586;
  final x2 = x * x;
  return 1 - x2 / 2 + (x2 * x2) / 24 - (x2 * x2 * x2) / 720;
}

double _sin(double radians) {
  double x = radians % 6.283185307179586;
  if (x > 3.141592653589793) x -= 6.283185307179586;
  final x2 = x * x;
  return x - (x * x2) / 6 + (x * x2 * x2) / 120 - (x * x2 * x2 * x2) / 5040;
}

// ── Parchment background painter (speckle grain) ────────────────────────────

class _UhValParchmentBackgroundPainter extends CustomPainter {
  const _UhValParchmentBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final base = Paint()
      ..shader = const LinearGradient(
        colors: [_uhValParchment, _uhValParchmentWarm, _uhValParchment],
        stops: [0.0, 0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRect(rect, base);

    final speckle = Paint()..color = _uhValParchmentDeep.withValues(alpha: 0.08);
    for (int i = 0; i < 260; i++) {
      final seed = i * 6271 + 17;
      final x = (seed % 997) / 997 * size.width;
      final y = ((seed * 31) % 991) / 991 * size.height;
      canvas.drawCircle(Offset(x, y), 0.7, speckle);
    }

    // Soft edge vignette
    final edge = Paint()
      ..shader = RadialGradient(
        colors: [
          _uhValParchment.withValues(alpha: 0.0),
          _uhValParchmentDeep.withValues(alpha: 0.25),
        ],
        stops: const [0.65, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, edge);
  }

  @override
  bool shouldRepaint(covariant _UhValParchmentBackgroundPainter old) => false;
}

// ── Badge: one (canUndo, canRedo) combination ───────────────────────────────

class _UhValCombinationBadge extends StatelessWidget {
  final bool canUndo;
  final bool canRedo;
  final String label;
  final String interpretation;
  final String analogy;
  final bool featured;

  const _UhValCombinationBadge({
    required this.canUndo,
    required this.canRedo,
    required this.label,
    required this.interpretation,
    required this.analogy,
    this.featured = false,
  });

  @override
  Widget build(BuildContext context) {
    // Simulate UndoHistoryValue via two bools; the displayed value is exactly
    // what UndoHistoryValue(canUndo: canUndo, canRedo: canRedo) would equal.
    final toStr = 'UndoHistoryValue(canUndo: $canUndo, canRedo: $canRedo)';
    final hash = Object.hash(canUndo.hashCode, canRedo.hashCode);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: _uhValParchmentWarm,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: featured ? _uhValWax : _uhValParchmentDeep,
          width: featured ? 1.6 : 1.0,
        ),
        boxShadow: featured
            ? const [
                BoxShadow(
                  color: Color(0x33000000),
                  offset: Offset(2, 3),
                  blurRadius: 4,
                ),
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seal / marker
          SizedBox(
            width: 72,
            height: 72,
            child: featured
                ? CustomPaint(
                    painter: _UhValWaxSealPainter(glyph: label.substring(0, 1)),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: _uhValParchment,
                      shape: BoxShape.circle,
                      border: Border.all(color: _uhValInk, width: 1.2),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      label.substring(0, 1),
                      style: const TextStyle(
                        color: _uhValInk,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: _uhValInk,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    _uhValAllowedDeniedTag(canUndo, 'undo OK', 'no undo'),
                    const SizedBox(width: 6),
                    _uhValAllowedDeniedTag(canRedo, 'redo OK', 'no redo'),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  interpretation,
                  style: const TextStyle(
                    color: _uhValInkSoft,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _uhValParchment,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: _uhValParchmentShadow,
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    'Analogy: $analogy',
                    style: const TextStyle(
                      color: _uhValInkFaded,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  toStr,
                  style: const TextStyle(
                    color: _uhValWaxDeep,
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  'hashCode: $hash',
                  style: const TextStyle(
                    color: _uhValInkFaded,
                    fontSize: 11.5,
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

// ── Live readout: UndoHistoryController + ValueListenableBuilder ────────────

class _UhValLiveReadout extends StatefulWidget {
  const _UhValLiveReadout();

  @override
  State<_UhValLiveReadout> createState() => _UhValLiveReadoutState();
}

class _UhValLiveReadoutState extends State<_UhValLiveReadout> {
  late final TextEditingController _text;
  late final UndoHistoryController _undo;
  final List<UndoHistoryValue> _tail = <UndoHistoryValue>[];
  int _emitCount = 0;

  @override
  void initState() {
    super.initState();
    _text = TextEditingController(text: 'Quill the fox leaps parchment.');
    _undo = UndoHistoryController();
    _undo.addListener(_capture);
  }

  void _capture() {
    _emitCount++;
    _tail.add(_undo.value);
    // Keep last 12 emissions for the ribbon
    if (_tail.length > 12) {
      _tail.removeRange(0, _tail.length - 12);
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _undo.removeListener(_capture);
    _undo.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _uhValProse(
          'The TextField below owns an UndoHistoryController. Type a few '
          'characters, press backspace, then watch the ValueListenableBuilder '
          'paint the current UndoHistoryValue in real time.',
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: _uhValParchment,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _uhValInk, width: 1.2),
          ),
          child: TextField(
            controller: _text,
            undoController: _undo,
            maxLines: 2,
            style: const TextStyle(
              color: _uhValInk,
              fontSize: 14,
              fontFamily: 'monospace',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
              hintText: 'Edit here, then undo / redo…',
              hintStyle: TextStyle(color: _uhValInkFaded),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _undo.undo(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _uhValWax,
                  foregroundColor: _uhValParchment,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                icon: const Icon(Icons.undo, size: 16),
                label: const Text('Undo'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _undo.redo(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _uhValInk,
                  foregroundColor: _uhValParchment,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                icon: const Icon(Icons.redo, size: 16),
                label: const Text('Redo'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // The headline listener: paint current value as badges
        ValueListenableBuilder<UndoHistoryValue>(
          valueListenable: _undo,
          builder: (context, value, _) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              decoration: BoxDecoration(
                color: _uhValInk,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _uhValWaxDeep, width: 1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current UndoHistoryValue',
                    style: TextStyle(
                      color: _uhValParchment,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value.toString(),
                    style: const TextStyle(
                      color: Color(0xFFE2D1A4),
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _uhValAllowedDeniedTag(
                          value.canUndo, 'canUndo = true', 'canUndo = false'),
                      const SizedBox(width: 6),
                      _uhValAllowedDeniedTag(
                          value.canRedo, 'canRedo = true', 'canRedo = false'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _uhValSmallChip(
                        'emissions: $_emitCount',
                        bg: _uhValParchmentWarm,
                        fg: _uhValInk,
                      ),
                      _uhValSmallChip(
                        '== empty: ${value == UndoHistoryValue.empty}',
                        bg: _uhValParchmentWarm,
                        fg: _uhValInk,
                      ),
                      _uhValSmallChip(
                        'hash: ${Object.hash(value.canUndo.hashCode, value.canRedo.hashCode)}',
                        bg: _uhValParchmentWarm,
                        fg: _uhValInk,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Recent emissions (oldest → newest):',
                    style: TextStyle(
                      color: _uhValParchment.withValues(alpha: 0.85),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _UhValEmissionStrip(values: _tail),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// Horizontal strip of small squares: green = canUndo, blue = canRedo
class _UhValEmissionStrip extends StatelessWidget {
  final List<UndoHistoryValue> values;
  const _UhValEmissionStrip({required this.values});

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          '(no emissions yet — edit the text field above)',
          style: TextStyle(
            color: _uhValParchment.withValues(alpha: 0.5),
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }
    return SizedBox(
      height: 34,
      child: Row(
        children: [
          for (final v in values) _UhValStripCell(value: v),
        ],
      ),
    );
  }
}

class _UhValStripCell extends StatelessWidget {
  final UndoHistoryValue value;
  const _UhValStripCell({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      width: 22,
      decoration: BoxDecoration(
        color: _uhValInkSoft,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: _uhValParchmentDeep, width: 0.6),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: value.canUndo ? _uhValAllowed : _uhValDenied,
            ),
          ),
          Container(height: 1, color: _uhValInk),
          Expanded(
            child: Container(
              color: value.canRedo ? _uhValHintA : _uhValDenied,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Equality inspector: two values built from switches ──────────────────────

class _UhValEqualityInspector extends StatefulWidget {
  const _UhValEqualityInspector();

  @override
  State<_UhValEqualityInspector> createState() =>
      _UhValEqualityInspectorState();
}

class _UhValEqualityInspectorState extends State<_UhValEqualityInspector> {
  bool _aUndo = true;
  bool _aRedo = false;
  bool _bUndo = true;
  bool _bRedo = false;

  @override
  Widget build(BuildContext context) {
    final a = UndoHistoryValue(canUndo: _aUndo, canRedo: _aRedo);
    final b = UndoHistoryValue(canUndo: _bUndo, canRedo: _bRedo);
    final equal = a == b;
    final identicalRef = identical(a, b);

    // A hand-written copyWith — the SDK class does not ship one, so show the
    // recipe directly and invoke it here:
    final aWithRedo = _uhValCopyWith(a, canRedo: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _uhValProse(
          'Toggle the switches to build two UndoHistoryValues side by side. '
          'The == operator checks canUndo and canRedo structurally, so two '
          'distinct instances holding the same booleans compare equal.',
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _UhValValueColumn(
                title: 'Value A',
                canUndo: _aUndo,
                canRedo: _aRedo,
                onUndo: (v) => setState(() => _aUndo = v),
                onRedo: (v) => setState(() => _aRedo = v),
                highlight: _uhValWax,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _UhValValueColumn(
                title: 'Value B',
                canUndo: _bUndo,
                canRedo: _bRedo,
                onUndo: (v) => setState(() => _bUndo = v),
                onRedo: (v) => setState(() => _bRedo = v),
                highlight: _uhValInk,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: equal ? _uhValAllowedLight : _uhValDeniedLight,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: equal ? _uhValAllowed : _uhValDenied,
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    equal ? Icons.handshake : Icons.compare_arrows,
                    size: 18,
                    color: equal ? _uhValAllowed : _uhValDenied,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    equal
                        ? 'a == b evaluates to TRUE'
                        : 'a == b evaluates to FALSE',
                    style: TextStyle(
                      color: equal ? _uhValAllowed : _uhValDenied,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'identical(a, b) = $identicalRef — distinct instances never '
                'share identity, but == still returns true when the two '
                'booleans match.',
                style: const TextStyle(
                  color: _uhValInk,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'a.hashCode = ${a.hashCode}\n'
                'b.hashCode = ${b.hashCode}',
                style: const TextStyle(
                  color: _uhValInkFaded,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _uhValParchmentWarm,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _uhValParchmentDeep, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hand-written copyWith demo',
                style: TextStyle(
                  color: _uhValInk,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              _uhValProse(
                'UndoHistoryValue does not ship with copyWith. A local helper '
                'takes the original and patches canRedo to true without '
                'mutating A. The rest of the code sees A unchanged.',
                fontSize: 12.5,
              ),
              const SizedBox(height: 6),
              _uhValKeyValueRow('Original A', a.toString()),
              _uhValKeyValueRow('copyWith(canRedo: true)', aWithRedo.toString()),
              _uhValKeyValueRow(
                'original untouched',
                'a.canRedo still ${a.canRedo}',
              ),
              _uhValKeyValueRow(
                'new instance identity',
                'identical(a, aWithRedo) = ${identical(a, aWithRedo)}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Top-level copyWith that mimics the common data-class idiom.
UndoHistoryValue _uhValCopyWith(
  UndoHistoryValue src, {
  bool? canUndo,
  bool? canRedo,
}) {
  return UndoHistoryValue(
    canUndo: canUndo ?? src.canUndo,
    canRedo: canRedo ?? src.canRedo,
  );
}

class _UhValValueColumn extends StatelessWidget {
  final String title;
  final bool canUndo;
  final bool canRedo;
  final ValueChanged<bool> onUndo;
  final ValueChanged<bool> onRedo;
  final Color highlight;

  const _UhValValueColumn({
    required this.title,
    required this.canUndo,
    required this.canRedo,
    required this.onUndo,
    required this.onRedo,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    final v = UndoHistoryValue(canUndo: canUndo, canRedo: canRedo);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _uhValParchment,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: highlight, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: highlight,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: _uhValInk,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'canUndo',
                style: TextStyle(
                  color: _uhValInkSoft,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Switch(
                value: canUndo,
                onChanged: onUndo,
                activeThumbColor: _uhValAllowed,
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'canRedo',
                style: TextStyle(
                  color: _uhValInkSoft,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Switch(
                value: canRedo,
                onChanged: onRedo,
                activeThumbColor: _uhValHintA,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            v.toString(),
            style: const TextStyle(
              color: _uhValWaxDeep,
              fontFamily: 'monospace',
              fontSize: 11.5,
            ),
          ),
          Text(
            'hashCode: ${v.hashCode}',
            style: const TextStyle(
              color: _uhValInkFaded,
              fontFamily: 'monospace',
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Timeline visualiser: push synthetic values into a notifier ─────────────

class _UhValTimelineVisualiser extends StatefulWidget {
  const _UhValTimelineVisualiser();

  @override
  State<_UhValTimelineVisualiser> createState() =>
      _UhValTimelineVisualiserState();
}

class _UhValTimelineVisualiserState extends State<_UhValTimelineVisualiser> {
  late final ValueNotifier<UndoHistoryValue> _notifier;
  final List<UndoHistoryValue> _log = <UndoHistoryValue>[
    const UndoHistoryValue(canUndo: false, canRedo: false),
  ];
  int _step = 0;

  // Deterministic pseudo-random cycle that covers each quadrant.
  static const List<List<bool>> _cycle = <List<bool>>[
    <bool>[true, false],
    <bool>[true, true],
    <bool>[false, true],
    <bool>[false, false],
    <bool>[true, false],
    <bool>[true, true],
    <bool>[false, false],
    <bool>[true, true],
  ];

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier<UndoHistoryValue>(
      const UndoHistoryValue(canUndo: false, canRedo: false),
    );
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  void _pushNext() {
    _step = (_step + 1) % _cycle.length;
    final pair = _cycle[_step];
    final next = UndoHistoryValue(canUndo: pair[0], canRedo: pair[1]);
    _notifier.value = next;
    _log.add(next);
    if (_log.length > 20) {
      _log.removeRange(0, _log.length - 20);
    }
    setState(() {});
  }

  void _reset() {
    _step = 0;
    _notifier.value = const UndoHistoryValue();
    _log
      ..clear()
      ..add(const UndoHistoryValue());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _uhValProse(
          'Each button press pushes the next UndoHistoryValue into a '
          'ValueNotifier. The ribbon below records every transition; coloured '
          'bands indicate the canUndo (top half) and canRedo (bottom half) '
          'flags at that moment in time.',
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _pushNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _uhValWax,
                  foregroundColor: _uhValParchment,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                icon: const Icon(Icons.playlist_add, size: 16),
                label: const Text('Push next value'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  foregroundColor: _uhValInk,
                  side: const BorderSide(color: _uhValInk, width: 1.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Reset timeline'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ValueListenableBuilder<UndoHistoryValue>(
          valueListenable: _notifier,
          builder: (context, value, _) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _uhValInk,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _uhValWaxDeep, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latest notifier value: ${value.toString()}',
                    style: const TextStyle(
                      color: _uhValParchment,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    child: CustomPaint(
                      painter: _UhValTimelinePainter(log: _log),
                      size: const Size(double.infinity, 60),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    children: [
                      _uhValSmallChip('green top = canUndo true',
                          bg: _uhValAllowedLight,
                          fg: _uhValAllowed,
                          border: _uhValAllowed),
                      _uhValSmallChip('blue bottom = canRedo true',
                          bg: const Color(0xFFD4DEF0),
                          fg: _uhValHintA,
                          border: _uhValHintA),
                      _uhValSmallChip('crimson = false',
                          bg: _uhValDeniedLight,
                          fg: _uhValDenied,
                          border: _uhValDenied),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Entries logged: ${_log.length}  |  Step: $_step',
                    style: TextStyle(
                      color: _uhValParchment.withValues(alpha: 0.7),
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _UhValTimelinePainter extends CustomPainter {
  final List<UndoHistoryValue> log;

  _UhValTimelinePainter({required this.log});

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    final bg = Paint()..color = _uhValInkSoft;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      bg,
    );

    if (log.isEmpty) return;

    final cellW = size.width / log.length;
    final halfH = size.height / 2;

    final undoOn = Paint()..color = _uhValAllowed;
    final undoOff = Paint()..color = _uhValDenied;
    final redoOn = Paint()..color = _uhValHintA;
    final redoOff = Paint()..color = _uhValDenied.withValues(alpha: 0.75);

    for (int i = 0; i < log.length; i++) {
      final v = log[i];
      final x = i * cellW;
      canvas.drawRect(
        Rect.fromLTWH(x + 0.5, 0, cellW - 1, halfH - 1),
        v.canUndo ? undoOn : undoOff,
      );
      canvas.drawRect(
        Rect.fromLTWH(x + 0.5, halfH + 1, cellW - 1, halfH - 1),
        v.canRedo ? redoOn : redoOff,
      );
    }

    // Draw midline
    final mid = Paint()
      ..color = _uhValInk
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, halfH), Offset(size.width, halfH), mid);

    // Draw end marker
    final end = Paint()
      ..color = _uhValParchment
      ..strokeWidth = 1.4;
    canvas.drawLine(
      Offset(size.width - 0.5, 0),
      Offset(size.width - 0.5, size.height),
      end,
    );
  }

  @override
  bool shouldRepaint(covariant _UhValTimelinePainter old) =>
      old.log.length != log.length ||
      (log.isNotEmpty && old.log.isNotEmpty && old.log.last != log.last);
}

// ── copyWith recipe card ────────────────────────────────────────────────────

class _UhValRecipeCard extends StatelessWidget {
  final String title;
  final String intent;
  final String code;
  final List<String> notes;
  final Color accent;

  const _UhValRecipeCard({
    required this.title,
    required this.intent,
    required this.code,
    required this.notes,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: _uhValParchmentWarm,
        borderRadius: BorderRadius.circular(4),
        border: Border(left: BorderSide(color: accent, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: _uhValInk,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            intent,
            style: const TextStyle(
              color: _uhValInkSoft,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _uhValInk,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              code,
              style: const TextStyle(
                color: Color(0xFFE2D1A4),
                fontFamily: 'monospace',
                fontSize: 11.8,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 6),
          for (final n in notes)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ',
                      style: TextStyle(
                          color: _uhValWaxDeep, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(
                      n,
                      style: const TextStyle(
                        color: _uhValInkFaded,
                        fontSize: 12,
                        height: 1.35,
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
}

// ── Main build() — the d4rt harness entry point ─────────────────────────────

dynamic build(BuildContext context) {
  // ── Badge gallery data (all four quadrants) ───────────────────────────
  const combinations = <Map<String, Object>>[
    <String, Object>{
      'label': 'Empty',
      'canUndo': false,
      'canRedo': false,
      'interp':
          'UndoHistoryValue.empty — the freshly initialised state. No edits '
              'have been recorded, so there is nothing to rewind or replay.',
      'analogy':
          'A virgin page. The quill has touched no ink; no strokes to '
              'unwrite, no strokes to re-write.',
      'featured': true,
    },
    <String, Object>{
      'label': 'Classic',
      'canUndo': true,
      'canRedo': false,
      'interp':
          'The common case while typing forward: history has grown, so undo '
              'is available, but no branch has been rolled back, so redo is '
              'unavailable.',
      'analogy':
          'A scribe mid-sentence — they can erase the last stroke, but the '
              'future pages are still blank.',
      'featured': true,
    },
    <String, Object>{
      'label': 'Middle',
      'canUndo': true,
      'canRedo': true,
      'interp':
          'The user is sitting mid-history: something behind them, something '
              'ahead of them. Both arrows light up.',
      'analogy':
          'A reader leafing between chapters — pages before and pages after, '
              'both accessible.',
      'featured': true,
    },
    <String, Object>{
      'label': 'Rewound',
      'canUndo': false,
      'canRedo': true,
      'interp':
          'All edits have been undone. The past is exhausted, but the redo '
              'stack still remembers every step that was rolled back.',
      'analogy':
          'A film reel rewound to the start — no more footage to reverse, '
              'but plenty to play forward.',
      'featured': false,
    },
  ];

  final body = DecoratedBox(
    decoration: const BoxDecoration(),
    child: CustomPaint(
      painter: const _UhValParchmentBackgroundPainter(),
      // Fa1 — C22 ListView replacement to avoid the
      // SingleChildScrollView + Column infinite-height cascade.
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
        children: [
            // ── Header ──────────────────────────────────────────────────
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10, bottom: 4),
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              decoration: BoxDecoration(
                color: _uhValInk,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _uhValWaxDeep, width: 1.4),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: CustomPaint(
                      painter: _UhValWaxSealPainter(glyph: 'U', rotation: -0.1),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'UndoHistoryValue',
                          style: TextStyle(
                            color: _uhValParchment,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            letterSpacing: 0.6,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'The immutable record of undo / redo availability.',
                          style: TextStyle(
                            color: Color(0xFFE2D1A4),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── §1 Preamble ─────────────────────────────────────────────
            _uhValSectionBanner(
              'I',
              'Preamble — what it is and where it lives',
              'A two-bool value class sealed @immutable, returned by '
                  'UndoHistoryController.value and distributed via '
                  'ValueListenableBuilder.',
            ),
            _uhValParchmentCard(
              heading: 'Definition at a glance',
              children: [
                _uhValKeyValueRow('library',
                    'package:flutter/widgets.dart → src/widgets/undo_history.dart'),
                _uhValKeyValueRow('annotation', '@immutable'),
                _uhValKeyValueRow(
                    'constructor',
                    'const UndoHistoryValue({\n'
                        '  this.canUndo = false,\n'
                        '  this.canRedo = false,\n'
                        '})'),
                _uhValKeyValueRow(
                    'fields',
                    'final bool canUndo\n'
                        'final bool canRedo'),
                _uhValKeyValueRow('sentinel',
                    'static const UndoHistoryValue empty = UndoHistoryValue();'),
                _uhValKeyValueRow(
                    'equality',
                    'structural on (canUndo, canRedo);\n'
                        'identical() shortcut first'),
                _uhValKeyValueRow(
                    'hashCode',
                    'Object.hash(canUndo.hashCode, canRedo.hashCode) — '
                        'consistent with ==.'),
                _uhValKeyValueRow(
                    'toString',
                    'UndoHistoryValue(canUndo: \$canUndo, canRedo: \$canRedo)'),
                _uhValKeyValueRow('copyWith',
                    'not defined on the SDK type — see §VI for recipes'),
              ],
            ),
            _uhValParchmentCard(
              heading: 'Why a dedicated value class?',
              children: [
                _uhValProse(
                  'Flutter could have exposed canUndo and canRedo as two '
                  'separate ValueNotifiers. Packaging them into one value '
                  'object buys three things at once:',
                ),
                _uhValProse(
                    '  1. Atomic updates — listeners receive exactly one '
                    'emission per state transition, never a torn view of '
                    'two flags mid-flight.'),
                _uhValProse(
                    '  2. Structural equality — rebuilds can be skipped when '
                    'the pair of booleans is unchanged, even if a new '
                    'instance arrives.'),
                _uhValProse(
                    '  3. Future-proof shape — additional fields (e.g. '
                    'number of steps) could be added without breaking the '
                    'listener API.'),
              ],
            ),
            _uhValParchmentCard(
              heading: 'Where it is produced',
              children: [
                _uhValProse(
                    'The canonical producer is UndoHistoryController, which '
                    'extends ValueNotifier<UndoHistoryValue>. Any code that '
                    'mutates the undo stack — typically via UndoHistory / '
                    'UndoHistoryState inside EditableText — calls into the '
                    'controller, which emits a fresh UndoHistoryValue.'),
                _uhValProse(
                    'Consumers rarely construct UndoHistoryValue themselves; '
                    'they listen to the controller and read value.canUndo / '
                    'value.canRedo. Direct construction is useful for tests '
                    'and for synthetic timelines — exactly the scenarios '
                    'demonstrated in this demo.'),
              ],
            ),

            // ── §2 Badge gallery ───────────────────────────────────────
            _uhValSectionBanner(
              'II',
              'Badge gallery — every (canUndo, canRedo) combination',
              'Four quadrants of a simple truth table, each with a physical '
                  'analogy and a printed toString representation.',
            ),
            _uhValParchmentCard(
              heading: 'Reading the badges',
              children: [
                _uhValProse(
                  'Featured badges (the first three below) carry a hand-painted '
                  'wax seal; the last is shown without seal to emphasise that '
                  'it is the asymmetric twin of the Classic case. Each card '
                  'prints the toString() you would observe in a debug log.',
                ),
                const SizedBox(height: 6),
                Wrap(
                  children: [
                    _uhValSmallChip('wax seal = featured state'),
                    _uhValSmallChip('green tag = flag allowed'),
                    _uhValSmallChip('crimson tag = flag denied'),
                    _uhValSmallChip('mono line = toString()'),
                  ],
                ),
              ],
            ),
            for (final c in combinations)
              _UhValCombinationBadge(
                canUndo: c['canUndo'] as bool,
                canRedo: c['canRedo'] as bool,
                label: c['label'] as String,
                interpretation: c['interp'] as String,
                analogy: c['analogy'] as String,
                featured: c['featured'] as bool,
              ),
            _uhValParchmentCard(
              heading: 'Truth table',
              children: [
                _uhValKeyValueRow('(false, false)',
                    'empty — fresh or exhausted in both directions'),
                _uhValKeyValueRow('(true , false)',
                    'classic forward typing — undo available, redo gone'),
                _uhValKeyValueRow('(true , true )',
                    'mid-history — both arrows armed'),
                _uhValKeyValueRow('(false, true )',
                    'fully rewound — redo still holds the future'),
                _uhValInkRule(),
                _uhValProse(
                    'Because every field is a bool, there are exactly four '
                    'reachable values. The ValueNotifier never has to emit '
                    'more than one of each in sequence — a tight invariant '
                    'you can lean on when writing rebuild heuristics.'),
              ],
            ),

            // ── §3 Live readout ────────────────────────────────────────
            _uhValSectionBanner(
              'III',
              'Live readout — ValueListenableBuilder<UndoHistoryValue>',
              'A real UndoHistoryController attached to a TextField. Every '
                  'emission paints the current value and pushes into a '
                  'history ribbon.',
            ),
            _uhValParchmentCard(
              heading: 'Interactive demo',
              children: const [
                _UhValLiveReadout(),
              ],
            ),
            _uhValParchmentCard(
              heading: 'What to notice',
              children: [
                _uhValProse(
                    'Initially the value is UndoHistoryValue.empty. The '
                    'first keystroke flips canUndo to true; pressing the '
                    'Undo button rewinds and flips canRedo to true as well.'),
                _uhValProse(
                    'The ribbon only records the four reachable states — '
                    'see §II. Consecutive emissions carrying the same '
                    'booleans still come through because UndoHistoryController '
                    'is ValueNotifier-based, and ValueNotifier suppresses '
                    'notifications only when the value is equal and you '
                    'assign .value directly. Listeners on top still fire '
                    'when the controller calls notifyListeners() internally.'),
                _uhValProse(
                    'If you want to filter consecutive duplicates yourself, '
                    'wrap the controller with a DistinctValueListenable — a '
                    'pattern shown in §VI.'),
              ],
            ),

            // ── §4 Equality inspector ──────────────────────────────────
            _uhValSectionBanner(
              'IV',
              'Equality inspector — two values under the microscope',
              'Build two values from independent switches. Observe ==, '
                  'identical(), hashCode and a hand-written copyWith.',
            ),
            _uhValParchmentCard(
              heading: 'Side-by-side inspector',
              children: const [
                _UhValEqualityInspector(),
              ],
            ),
            _uhValParchmentCard(
              heading: 'Guarantees of the == contract',
              children: [
                _uhValKeyValueRow('reflexive', 'a == a is always true'),
                _uhValKeyValueRow(
                    'symmetric', 'a == b ⇔ b == a (both branches structural)'),
                _uhValKeyValueRow(
                    'transitive', 'if a == b and b == c then a == c'),
                _uhValKeyValueRow('hash consistent',
                    'a == b ⇒ a.hashCode == b.hashCode (Object.hash composes)'),
                _uhValKeyValueRow('identity shortcut',
                    'identical(a, b) short-circuits without field reads'),
              ],
            ),

            // ── §5 Timeline visualiser ────────────────────────────────
            _uhValSectionBanner(
              'V',
              'Timeline visualiser — transitions over time',
              'A ValueNotifier<UndoHistoryValue> driven by a deterministic '
                  'cycle. CustomPainter draws the canUndo / canRedo ribbons.',
            ),
            _uhValParchmentCard(
              heading: 'Synthetic ribbon',
              children: const [
                _UhValTimelineVisualiser(),
              ],
            ),
            _uhValParchmentCard(
              heading: 'Interpreting the ribbon',
              children: [
                _uhValProse(
                    'The painter splits each column into two bands — the '
                    'top shows canUndo, the bottom canRedo. Because the '
                    'cycle visits every quadrant of the truth table at '
                    'least once, you can watch the ribbon produce each of '
                    'the four reachable UndoHistoryValue instances.'),
                _uhValProse(
                    'The Reset button clears the log and snaps the '
                    'notifier back to UndoHistoryValue.empty — a cheap way '
                    'to show that const sentinel values retain their '
                    'identity across resets.'),
              ],
            ),

            // ── §6 Copy / with / compose recipes ──────────────────────
            _uhValSectionBanner(
              'VI',
              'copyWith & composition recipes',
              'UndoHistoryValue is tiny on purpose. Here are three '
                  'conventional ways to produce a new value or observe it '
                  'through different lenses.',
            ),
            _uhValParchmentCard(
              heading: 'Recipes',
              children: [
                _UhValRecipeCard(
                  title: 'Recipe A — manual copyWith',
                  accent: _uhValWax,
                  intent:
                      'The SDK does not provide copyWith. Write one as a '
                      'free function; keep it const-friendly.',
                  code: 'UndoHistoryValue copyWith(\n'
                      '  UndoHistoryValue src, {\n'
                      '  bool? canUndo,\n'
                      '  bool? canRedo,\n'
                      '}) => UndoHistoryValue(\n'
                      '      canUndo: canUndo ?? src.canUndo,\n'
                      '      canRedo: canRedo ?? src.canRedo,\n'
                      '    );',
                  notes: <String>[
                    'Returns a new instance; the original is untouched — '
                        'exactly what an @immutable value class expects.',
                    'Nullability pattern mirrors Flutter\'s own ThemeData.copyWith.',
                    'Because both fields are non-nullable bool, null here '
                        'legitimately means "unchanged", not "unset".',
                  ],
                ),
                _UhValRecipeCard(
                  title: 'Recipe B — distinct listener wrapper',
                  accent: _uhValInk,
                  intent:
                      'Only fire onChanged when the value actually differs. '
                      'Useful when upstream controllers notify on every '
                      'keystroke.',
                  code: 'class DistinctUhvListener extends ValueNotifier<UndoHistoryValue> {\n'
                      '  DistinctUhvListener(super.initial);\n'
                      '  @override\n'
                      '  set value(UndoHistoryValue next) {\n'
                      '    if (next == value) return;\n'
                      '    super.value = next;\n'
                      '  }\n'
                      '}',
                  notes: <String>[
                    'ValueNotifier already suppresses equal values by default; '
                        'this override is only needed when wrapping a source '
                        'that notifies without changing .value.',
                    'Pair it with an addListener that forwards from the '
                        'original controller.',
                  ],
                ),
                _UhValRecipeCard(
                  title: 'Recipe C — compose with another ValueNotifier',
                  accent: _uhValWaxDeep,
                  intent:
                      'Surface "anyChange" from two UndoHistoryControllers '
                      '(e.g. a title field and a body field) as a single '
                      'combined ValueListenable<bool>.',
                  code: 'class EitherCanUndo extends ValueNotifier<bool> {\n'
                      '  final UndoHistoryController a;\n'
                      '  final UndoHistoryController b;\n'
                      '  EitherCanUndo(this.a, this.b) : super(false) {\n'
                      '    a.addListener(_tick);\n'
                      '    b.addListener(_tick);\n'
                      '  }\n'
                      '  void _tick() {\n'
                      '    value = a.value.canUndo || b.value.canUndo;\n'
                      '  }\n'
                      '  @override void dispose() {\n'
                      '    a.removeListener(_tick);\n'
                      '    b.removeListener(_tick);\n'
                      '    super.dispose();\n'
                      '  }\n'
                      '}',
                  notes: <String>[
                    'Combine values as booleans to power a single "Undo" '
                        'toolbar button that toggles the union of both fields.',
                    'Remember to remove the listeners you added to avoid '
                        'post-dispose notifications.',
                  ],
                ),
              ],
            ),

            // ── §7 Epilogue ────────────────────────────────────────────
            _uhValSectionBanner(
              'VII',
              'Epilogue — patterns and debugging',
              'When to subclass, when to compose, when to rebuild, when to '
                  'leave the notifier alone.',
            ),
            _uhValParchmentCard(
              heading: 'Subclass vs compose',
              children: [
                _uhValProse(
                    'UndoHistoryValue is annotated @immutable and is '
                    'designed to be final in spirit. Flutter itself does '
                    'not subclass it. Prefer composition (a wrapping '
                    'ValueNotifier or an EitherCanUndo as above) when you '
                    'need to derive new signals.'),
                _uhValProse(
                    'A legitimate reason to wrap is stream adaptation: if '
                    'you need an async Stream<UndoHistoryValue>, bridge via '
                    'a StreamController in an addListener — do not extend '
                    'UndoHistoryValue itself.'),
              ],
            ),
            _uhValParchmentCard(
              heading: 'When to rebuild',
              children: [
                _uhValProse(
                    'ValueListenableBuilder will rebuild on any '
                    'notification; it does not re-compare its builder '
                    'arguments. If your builder is expensive, short-circuit '
                    'with a Selector-like wrapper:'),
                _uhValProse(
                    '  ValueListenableBuilder<UndoHistoryValue>(\n'
                    '    valueListenable: controller,\n'
                    '    builder: (_, v, child) {\n'
                    '      if (!v.canUndo && !v.canRedo) return child!;\n'
                    '      return ExpensiveBar(v);\n'
                    '    },\n'
                    '    child: const SizedBox.shrink(),\n'
                    '  );'),
                _uhValProse(
                    'The `child` slot lets you reuse a prebuilt subtree for '
                    'the idle (empty) state without rebuilding it on every '
                    'emission.'),
              ],
            ),
            _uhValParchmentCard(
              heading: 'Debugging checklist',
              children: [
                _uhValKeyValueRow('no emissions',
                    'Check that the TextField has `undoController: …` wired.'),
                _uhValKeyValueRow('too many rebuilds',
                    'Wrap the controller with a distinct listener (Recipe B).'),
                _uhValKeyValueRow('empty never reached',
                    'Remember: clearing the text still retains redo. Force '
                        'controller.value = UndoHistoryValue.empty to reset.'),
                _uhValKeyValueRow('testing',
                    'Construct values directly; they are const-friendly and '
                        'cheap to compare in expect() matchers.'),
                _uhValKeyValueRow('instrumenting',
                    'Log with toString(); the output already includes both '
                        'fields and the class name prefix.'),
              ],
            ),
            _uhValParchmentCard(
              heading: 'Summary',
              children: [
                _uhValProse(
                    'UndoHistoryValue is a disciplined, two-field, '
                    'immutable record. The entire public surface is a '
                    'constructor, two booleans, a sentinel, toString, == '
                    'and hashCode. Everything else — copyWith, composition, '
                    'filtering — lives in your code, exactly the way '
                    'Flutter prefers it.'),
                _uhValInkRule(),
                _uhValProse(
                    'Scroll back up and try the TextField in §III; note '
                    'how the wax seals and ribbons are only there to make '
                    'a very small value class feel as memorable as it '
                    'deserves to be.'),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: CustomPaint(
                      painter: _UhValWaxSealPainter(glyph: 'V', rotation: 0.2),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '— fin —',
                    style: TextStyle(
                      color: _uhValInkFaded,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
        ],
      ),
    ),
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _uhValParchment,
      useMaterial3: false,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _uhValInk),
      ),
    ),
    home: Scaffold(
      backgroundColor: _uhValParchment,
      appBar: AppBar(
        backgroundColor: _uhValInk,
        foregroundColor: _uhValParchment,
        elevation: 0,
        title: const Text(
          'UndoHistoryValue — the immutable undo/redo witness',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: body,
    ),
  );
}
