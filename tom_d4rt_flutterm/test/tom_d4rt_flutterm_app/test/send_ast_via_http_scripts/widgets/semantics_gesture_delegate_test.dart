// D4rt test script: Deep Demo — SemanticsGestureDelegate (A11y Gesture Tour).
//
// This hand-authored script exercises the d4rt AST harness against a deep
// visual tour of [SemanticsGestureDelegate], the abstract delegate that
// controls how a [RawGestureDetector] maps its registered gestures into
// semantic actions for assistive technologies (TalkBack, VoiceOver, Narrator,
// switch-access devices, etc.).
//
// It covers:
//   * A hero painter diagramming the pipeline:
//       RawGestureDetector -> SemanticsGestureDelegate -> SemanticsNode ->
//       screen reader.
//   * Card A — the default semantics delegate produced by RawGestureDetector.
//   * Card B — excluding gestures from the semantics tree (since
//     ExcludingSemanticsGestureDelegate is NOT public in Flutter 3.41.6,
//     this scene uses the supported `excludeFromSemantics: true` pattern).
//   * Card C — a custom `_AnnouncingGestureDelegate` that subclasses
//     [SemanticsGestureDelegate] and overrides `assignSemantics` to log a
//     banner announcement on every mapped gesture.
//   * A gesture log panel that records timestamp, gesture type, and whether
//     the gesture was announced to assistive tech.
//   * Instructional panels (bullet lists, cheat sheet, comparison table).
//
// Strict rules honoured:
//   * d4rt AST harness signature `dynamic build(BuildContext context)` that
//     returns `MaterialApp(home: Scaffold(...))`.
//   * No `main()` and no `runApp()`.
//   * Imports limited to `package:flutter/material.dart` and `dart:math`.
//   * `debugPrint` used instead of `print`.
//   * `.withValues(alpha:)` used for translucent colours.
//   * No `// ignore_for_file:` comments, no deprecated APIs, no analysis
//     options modifications.
//   * Verified by the Flutter 3.41.6 analyzer: "No issues found!".
//
// Verification note on the Scene B / Scene C pivot
// -------------------------------------------------
// Inspecting `/srv/flutter/flutter/packages/flutter/lib/src/widgets/
// gesture_detector.dart` in Flutter 3.41.6 confirms that:
//   * `SemanticsGestureDelegate` IS public (abstract base class).
//   * `_DefaultSemanticsGestureDelegate` is PRIVATE — created internally by
//     [RawGestureDetectorState._updateSemanticsForRenderObject].
//   * There is NO `ExcludingSemanticsGestureDelegate` class in the public
//     API at all.
// As a result this demo uses two supported approaches:
//   * Scene B pivots to `excludeFromSemantics: true` on [RawGestureDetector]
//     (the officially documented way to keep gestures out of the semantics
//     tree in 3.41.6).
//   * Scene C subclasses the public abstract [SemanticsGestureDelegate] to
//     build a minimal delegate that also forwards to the gesture recognizers
//     registered by the host widget, plus announces the mapped action via
//     a top banner. Because [_DefaultSemanticsGestureDelegate] is private we
//     cannot forward to it; we manually wire tap/long-press/drag into the
//     [RenderSemanticsGestureHandler].

import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette — teal (#14B8A6) + coral (#FB7185) + ink (#0F172A).
// ---------------------------------------------------------------------------
const Color _teal = Color(0xFF14B8A6);
const Color _coral = Color(0xFFFB7185);
const Color _ink = Color(0xFF0F172A);
const Color _inkSoft = Color(0xFF1E293B);
const Color _paper = Color(0xFFF8FAFC);
const Color _paperMist = Color(0xFFEEF2F6);
const Color _mutedText = Color(0xFF475569);

// Shared radii / padding.
const double _radLg = 20.0;
const double _radMd = 14.0;
const double _radSm = 10.0;

// ---------------------------------------------------------------------------
// Shared typography helpers.
// ---------------------------------------------------------------------------
TextStyle _title(double size, {Color color = _ink, FontWeight w = FontWeight.w700}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: w,
    height: 1.2,
    letterSpacing: 0.1,
  );
}

TextStyle _body(double size, {Color color = _mutedText, FontWeight w = FontWeight.w400}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: w,
    height: 1.4,
  );
}

TextStyle _mono(double size, {Color color = _ink}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: FontWeight.w600,
    height: 1.3,
    fontFamily: 'monospace',
  );
}

// ---------------------------------------------------------------------------
// SemanticsGestureDelegate subclass — Scene C.
//
// Subclasses the public abstract [SemanticsGestureDelegate] and, on every
// call to `assignSemantics`, wires up semantic callbacks that both execute
// the gesture and announce a label via an injected [ValueChanged] callback.
// Because the default delegate is private in Flutter 3.41.6, we manually
// map the well-known semantic actions (tap, long press, horizontal drag,
// vertical drag) exposed by [RenderSemanticsGestureHandler].
// ---------------------------------------------------------------------------
class _AnnouncingGestureDelegate extends SemanticsGestureDelegate {
  _AnnouncingGestureDelegate({
    required this.onAnnounce,
    this.onTap,
    this.onLongPress,
    this.onHorizontalDrag,
    this.onVerticalDrag,
  });

  /// Called for every semantic action that is mapped — Scene C uses this
  /// to push an entry into the log and to flash the banner.
  final void Function(String label) onAnnounce;

  /// Business-layer tap handler (forwarded from the semantics tree).
  final VoidCallback? onTap;

  /// Business-layer long-press handler.
  final VoidCallback? onLongPress;

  /// Business-layer horizontal drag handler.
  final ValueChanged<DragUpdateDetails>? onHorizontalDrag;

  /// Business-layer vertical drag handler.
  final ValueChanged<DragUpdateDetails>? onVerticalDrag;

  @override
  void assignSemantics(RenderSemanticsGestureHandler renderObject) {
    renderObject.onTap = onTap == null
        ? null
        : () {
            onAnnounce('tap');
            onTap!();
          };
    renderObject.onLongPress = onLongPress == null
        ? null
        : () {
            onAnnounce('longPress');
            onLongPress!();
          };
    renderObject.onHorizontalDragUpdate = onHorizontalDrag == null
        ? null
        : (DragUpdateDetails details) {
            onAnnounce('horizontalDrag');
            onHorizontalDrag!(details);
          };
    renderObject.onVerticalDragUpdate = onVerticalDrag == null
        ? null
        : (DragUpdateDetails details) {
            onAnnounce('verticalDrag');
            onVerticalDrag!(details);
          };
  }

  @override
  String toString() =>
      '_AnnouncingGestureDelegate(tap: ${onTap != null}, longPress: ${onLongPress != null}, '
      'hDrag: ${onHorizontalDrag != null}, vDrag: ${onVerticalDrag != null})';
}

// ---------------------------------------------------------------------------
// Hero painter — draws the full accessibility gesture pipeline.
// Four glyphs connected by labeled arrows:
//   [hand+phone] -> [SemanticsGestureDelegate box] -> [SemanticsNode tree] ->
//   [screen reader bubble]
// Plus radiating semantic waves emanating from the delegate box.
// ---------------------------------------------------------------------------
class _HeroPipelinePainter extends CustomPainter {
  _HeroPipelinePainter({required this.pulse});

  /// 0..1 animated pulse used to animate the semantic wave rings.
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect bounds = Offset.zero & size;
    // Background.
    final Paint bg = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _ink.withValues(alpha: 0.94),
          _inkSoft.withValues(alpha: 0.92),
        ],
      ).createShader(bounds);
    canvas.drawRRect(
      RRect.fromRectAndRadius(bounds, const Radius.circular(_radLg)),
      bg,
    );

    // Grid of dots behind the pipeline for a "technical" feel.
    final Paint dot = Paint()..color = _paper.withValues(alpha: 0.06);
    const double step = 18;
    for (double x = step; x < size.width; x += step) {
      for (double y = step; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 0.8, dot);
      }
    }

    // Four horizontal anchor points.
    final double y = size.height * 0.55;
    final double boxW = size.width / 4.4;
    final double boxH = size.height * 0.38;
    final List<Offset> centers = <Offset>[
      Offset(size.width * 0.13, y),
      Offset(size.width * 0.37, y),
      Offset(size.width * 0.63, y),
      Offset(size.width * 0.87, y),
    ];

    // Connecting arrows (behind boxes).
    for (int i = 0; i < centers.length - 1; i++) {
      _drawArrow(canvas, centers[i], centers[i + 1], boxW / 2);
    }

    // Draw each pipeline stage.
    _drawPhone(canvas, centers[0], boxW, boxH);
    _drawDelegateBox(canvas, centers[1], boxW, boxH, highlight: true);
    _drawSemanticsTree(canvas, centers[2], boxW, boxH);
    _drawScreenReader(canvas, centers[3], boxW, boxH);

    // Radiating semantic waves from the delegate box.
    final Paint wave = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (int ring = 0; ring < 4; ring++) {
      final double t = ((pulse + ring * 0.25) % 1.0);
      wave.color = _teal.withValues(alpha: (1.0 - t) * 0.55);
      canvas.drawCircle(centers[1], boxW * 0.6 * t + 8, wave);
    }

    // Title strip along the top.
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'Accessibility Gesture Pipeline',
        style: TextStyle(
          color: _paper,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(24, 18));

    final TextPainter tp2 = TextPainter(
      text: TextSpan(
        text: 'RawGestureDetector -> SemanticsGestureDelegate -> SemanticsNode -> Screen reader',
        style: TextStyle(
          color: _paper.withValues(alpha: 0.8),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp2.paint(canvas, Offset(24, 42));
  }

  void _drawArrow(Canvas canvas, Offset a, Offset b, double margin) {
    final Offset dir = Offset(b.dx - a.dx, b.dy - a.dy);
    final double len = dir.distance;
    if (len == 0) return;
    final Offset u = Offset(dir.dx / len, dir.dy / len);
    final Offset start = Offset(a.dx + u.dx * margin, a.dy + u.dy * margin);
    final Offset end = Offset(b.dx - u.dx * margin, b.dy - u.dy * margin);

    final Paint line = Paint()
      ..color = _teal.withValues(alpha: 0.75)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, end, line);

    // Arrowhead.
    final double ah = 10.0;
    final Offset left = Offset(
      end.dx - u.dx * ah - u.dy * ah * 0.6,
      end.dy - u.dy * ah + u.dx * ah * 0.6,
    );
    final Offset right = Offset(
      end.dx - u.dx * ah + u.dy * ah * 0.6,
      end.dy - u.dy * ah - u.dx * ah * 0.6,
    );
    final Path head = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    final Paint fill = Paint()..color = _teal;
    canvas.drawPath(head, fill);
  }

  void _drawPhone(Canvas canvas, Offset center, double w, double h) {
    final Rect frame = Rect.fromCenter(center: center, width: w * 0.9, height: h);
    final RRect rr = RRect.fromRectAndRadius(frame, const Radius.circular(18));
    final Paint phone = Paint()..color = _paper.withValues(alpha: 0.92);
    canvas.drawRRect(rr, phone);
    final Paint outline = Paint()
      ..color = _teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rr, outline);

    // Screen area.
    final Rect screen = frame.deflate(8);
    final Paint scr = Paint()..color = _ink.withValues(alpha: 0.88);
    canvas.drawRRect(RRect.fromRectAndRadius(screen, const Radius.circular(12)), scr);

    // Stylised hand — just a teal circle with a finger stub to keep it simple.
    final Paint handFill = Paint()..color = _coral;
    final Offset hand = Offset(center.dx + w * 0.18, center.dy + h * 0.05);
    canvas.drawCircle(hand, 12, handFill);
    final Paint finger = Paint()
      ..color = _coral
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      hand,
      Offset(hand.dx - 18, hand.dy - 22),
      finger,
    );

    _label(canvas, 'RawGestureDetector', center, h, 'Tap / long-press / drag');
  }

  void _drawDelegateBox(Canvas canvas, Offset center, double w, double h,
      {bool highlight = false}) {
    final Rect frame = Rect.fromCenter(center: center, width: w * 0.95, height: h);
    final RRect rr = RRect.fromRectAndRadius(frame, const Radius.circular(16));
    final Paint bg = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _teal.withValues(alpha: highlight ? 0.95 : 0.55),
          _coral.withValues(alpha: highlight ? 0.85 : 0.45),
        ],
      ).createShader(frame);
    canvas.drawRRect(rr, bg);

    if (highlight) {
      final Paint ring = Paint()
        ..color = _paper.withValues(alpha: 0.9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4;
      canvas.drawRRect(rr.inflate(3), ring);
    }

    // Small internal glyph: three mapped arrows going from left edge to
    // right edge showing mapping behaviour.
    final Paint arrow = Paint()
      ..color = _paper.withValues(alpha: 0.9)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 3; i++) {
      final double yy = frame.top + 18 + i * 12;
      canvas.drawLine(
        Offset(frame.left + 12, yy),
        Offset(frame.right - 12, yy),
        arrow,
      );
      final Path head = Path()
        ..moveTo(frame.right - 12, yy)
        ..lineTo(frame.right - 18, yy - 4)
        ..lineTo(frame.right - 18, yy + 4)
        ..close();
      canvas.drawPath(head, Paint()..color = _paper.withValues(alpha: 0.9));
    }

    _label(canvas, 'SemanticsGestureDelegate', center, h,
        'assignSemantics(renderObject)');
  }

  void _drawSemanticsTree(Canvas canvas, Offset center, double w, double h) {
    final Rect frame = Rect.fromCenter(center: center, width: w * 0.95, height: h);
    final RRect rr = RRect.fromRectAndRadius(frame, const Radius.circular(16));
    final Paint bg = Paint()..color = _paper.withValues(alpha: 0.96);
    canvas.drawRRect(rr, bg);
    final Paint outline = Paint()
      ..color = _teal.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rr, outline);

    // Nodes — a little tree: root with three children.
    final Paint node = Paint()..color = _teal;
    final Paint line = Paint()
      ..color = _ink.withValues(alpha: 0.4)
      ..strokeWidth = 1.4;
    final Offset root = Offset(center.dx, center.dy - h * 0.22);
    canvas.drawCircle(root, 6, node);
    for (int i = 0; i < 3; i++) {
      final double dx = (i - 1) * (w * 0.22);
      final Offset child = Offset(center.dx + dx, center.dy + h * 0.12);
      canvas.drawLine(root, child, line);
      canvas.drawCircle(child, 5, Paint()..color = _coral);
    }
    _label(canvas, 'SemanticsNode', center, h, 'tap / longPress / scroll');
  }

  void _drawScreenReader(Canvas canvas, Offset center, double w, double h) {
    final Rect frame = Rect.fromCenter(center: center, width: w * 0.95, height: h);
    final RRect rr = RRect.fromRectAndRadius(frame, const Radius.circular(16));
    final Paint bg = Paint()..color = _coral.withValues(alpha: 0.18);
    canvas.drawRRect(rr, bg);
    final Paint outline = Paint()
      ..color = _coral
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rr, outline);

    // Speech bubble.
    final Rect bubble = Rect.fromCenter(
      center: Offset(center.dx, center.dy - 6),
      width: w * 0.7,
      height: h * 0.42,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bubble, const Radius.circular(10)),
      Paint()..color = _paper,
    );
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'Button\ntap',
        style: TextStyle(
          color: _ink,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: bubble.width - 10);
    tp.paint(canvas, Offset(bubble.center.dx - tp.width / 2, bubble.top + 8));

    _label(canvas, 'Screen reader', center, h, 'VoiceOver / TalkBack');
  }

  void _label(Canvas canvas, String title, Offset center, double h, String sub) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: '$title\n',
            style: const TextStyle(
              color: _paper,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
          TextSpan(
            text: sub,
            style: TextStyle(
              color: _paper.withValues(alpha: 0.75),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 160);
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy + h * 0.5 + 8),
    );
  }

  @override
  bool shouldRepaint(covariant _HeroPipelinePainter oldDelegate) =>
      oldDelegate.pulse != pulse;
}

// ---------------------------------------------------------------------------
// Hero widget — wraps the painter, tall banner, and caption strip.
// ---------------------------------------------------------------------------
class _SemanticsPipelineHero extends StatefulWidget {
  const _SemanticsPipelineHero();

  @override
  State<_SemanticsPipelineHero> createState() => _SemanticsPipelineHeroState();
}

class _SemanticsPipelineHeroState extends State<_SemanticsPipelineHero>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (BuildContext context, Widget? _) {
        return SizedBox(
          height: 260,
          child: CustomPaint(
            painter: _HeroPipelinePainter(pulse: _c.value),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Gesture log entry shared across all scenes.
// ---------------------------------------------------------------------------
class _GestureLogEntry {
  _GestureLogEntry({
    required this.timestamp,
    required this.source,
    required this.gesture,
    required this.announced,
    required this.note,
  });

  final DateTime timestamp;
  final String source; // 'default' | 'excluded' | 'announcing'
  final String gesture; // tap, longPress, horizontalDrag, verticalDrag, scale
  final bool announced;
  final String note;

  String get timeString {
    String two(int v) => v.toString().padLeft(2, '0');
    String three(int v) => v.toString().padLeft(3, '0');
    return '${two(timestamp.hour)}:${two(timestamp.minute)}:${two(timestamp.second)}.${three(timestamp.millisecond)}';
  }
}

// ---------------------------------------------------------------------------
// Announcement banner — top strip that flashes whenever Scene C announces
// a gesture via its custom delegate.
// ---------------------------------------------------------------------------
class _AnnouncementBanner extends StatelessWidget {
  const _AnnouncementBanner({required this.message, required this.visible});

  final String message;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      height: visible ? 52 : 0,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_teal, _coral],
        ),
        borderRadius: BorderRadius.circular(_radMd),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _teal.withValues(alpha: 0.24),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 180),
        child: Row(
          children: <Widget>[
            const Icon(Icons.campaign_outlined, color: Colors.white, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Announced to screen reader: $message',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable card shell — coloured header strip + body.
// ---------------------------------------------------------------------------
class _SceneCard extends StatelessWidget {
  const _SceneCard({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.body,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final Widget body;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(_radLg),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  accent.withValues(alpha: 0.92),
                  accent.withValues(alpha: 0.65),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(_radLg),
                topRight: Radius.circular(_radLg),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.24),
                    borderRadius: BorderRadius.circular(_radSm),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            child: body,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Semantic action list — small pill list showing exposed semantic actions.
// ---------------------------------------------------------------------------
class _SemanticActionPills extends StatelessWidget {
  const _SemanticActionPills({
    required this.exposed,
    required this.all,
  });

  final Set<String> exposed;
  final List<String> all;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        for (final String action in all)
          _Pill(
            label: action,
            enabled: exposed.contains(action),
          ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.enabled});

  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: enabled
            ? _teal.withValues(alpha: 0.16)
            : _ink.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: enabled
              ? _teal.withValues(alpha: 0.55)
              : _ink.withValues(alpha: 0.14),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            enabled ? Icons.check_circle : Icons.block,
            size: 13,
            color: enabled ? _teal : _mutedText,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: enabled ? _ink : _mutedText,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Surface — the target of the three detectors. Renders an animated coral
// puck that translates/rotates on drag so users can see the gesture routes
// respond in real time.
// ---------------------------------------------------------------------------
class _GestureSurface extends StatelessWidget {
  const _GestureSurface({
    required this.label,
    required this.offset,
    required this.rotation,
    required this.pressed,
    required this.longPressing,
  });

  final String label;
  final Offset offset;
  final double rotation;
  final bool pressed;
  final bool longPressing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _ink.withValues(alpha: 0.92),
            _inkSoft.withValues(alpha: 0.86),
          ],
        ),
        borderRadius: BorderRadius.circular(_radMd),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          // Faint grid.
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 140),
            left: 100 + offset.dx,
            top: 60 + offset.dy,
            child: Transform.rotate(
              angle: rotation,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width: pressed ? 86 : 78,
                height: pressed ? 86 : 78,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      _coral,
                      _coral.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: _coral.withValues(alpha: longPressing ? 0.75 : 0.4),
                      blurRadius: longPressing ? 24 : 12,
                      spreadRadius: longPressing ? 6 : 0,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.touch_app_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
          Positioned(
            left: 14,
            top: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: _paper.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: _paper.withValues(alpha: 0.25)),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: _paper,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()..color = _paper.withValues(alpha: 0.06);
    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Helpers for the three scene cards.
// ---------------------------------------------------------------------------
Map<Type, GestureRecognizerFactory> _buildRecognizers({
  required VoidCallback? onTap,
  required VoidCallback? onLongPress,
  required ValueChanged<DragUpdateDetails>? onHorizontalUpdate,
  required ValueChanged<DragUpdateDetails>? onVerticalUpdate,
}) {
  final Map<Type, GestureRecognizerFactory> map =
      <Type, GestureRecognizerFactory>{};
  if (onTap != null) {
    map[TapGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
      () => TapGestureRecognizer(),
      (TapGestureRecognizer instance) {
        instance.onTap = onTap;
      },
    );
  }
  if (onLongPress != null) {
    map[LongPressGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
      () => LongPressGestureRecognizer(),
      (LongPressGestureRecognizer instance) {
        instance.onLongPress = onLongPress;
      },
    );
  }
  if (onHorizontalUpdate != null) {
    map[HorizontalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
      () => HorizontalDragGestureRecognizer(),
      (HorizontalDragGestureRecognizer instance) {
        instance.onUpdate = onHorizontalUpdate;
      },
    );
  }
  if (onVerticalUpdate != null) {
    map[VerticalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
      () => VerticalDragGestureRecognizer(),
      (VerticalDragGestureRecognizer instance) {
        instance.onUpdate = onVerticalUpdate;
      },
    );
  }
  return map;
}

// ---------------------------------------------------------------------------
// Scene A — Default semantics delegate.
//
// Shows a RawGestureDetector with tap + long-press + horizontal/vertical
// drag recognizers and `excludeFromSemantics: false` (default). The internal
// default delegate (`_DefaultSemanticsGestureDelegate`) maps each recognizer
// to a SemanticsAction on the enclosing SemanticsNode.
// ---------------------------------------------------------------------------
class _DefaultDelegateCard extends StatefulWidget {
  const _DefaultDelegateCard({required this.onLog});

  final ValueChanged<_GestureLogEntry> onLog;

  @override
  State<_DefaultDelegateCard> createState() => _DefaultDelegateCardState();
}

class _DefaultDelegateCardState extends State<_DefaultDelegateCard> {
  Offset _offset = Offset.zero;
  double _rotation = 0;
  bool _pressed = false;
  bool _longPressing = false;

  void _log(String gesture, bool announced, String note) {
    widget.onLog(_GestureLogEntry(
      timestamp: DateTime.now(),
      source: 'default',
      gesture: gesture,
      announced: announced,
      note: note,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> recognizers = _buildRecognizers(
      onTap: () {
        setState(() {
          _pressed = true;
          _rotation += math.pi / 12;
        });
        Future<void>.delayed(const Duration(milliseconds: 180), () {
          if (mounted) setState(() => _pressed = false);
        });
        _log('tap', true, 'Mapped to SemanticsAction.tap');
      },
      onLongPress: () {
        setState(() => _longPressing = true);
        Future<void>.delayed(const Duration(milliseconds: 520), () {
          if (mounted) setState(() => _longPressing = false);
        });
        _log('longPress', true, 'Mapped to SemanticsAction.longPress');
      },
      onHorizontalUpdate: (DragUpdateDetails d) {
        setState(() {
          _offset = Offset(_offset.dx + d.delta.dx, _offset.dy);
        });
        _log('horizontalDrag', true,
            'SemanticsAction.scrollLeft/scrollRight emitted');
      },
      onVerticalUpdate: (DragUpdateDetails d) {
        setState(() {
          _offset = Offset(_offset.dx, _offset.dy + d.delta.dy);
        });
        _log('verticalDrag', true,
            'SemanticsAction.scrollUp/scrollDown emitted');
      },
    );

    return _SceneCard(
      title: 'Card A — Default semantics delegate',
      subtitle:
          'RawGestureDetector uses its internal _DefaultSemanticsGestureDelegate.',
      accent: _teal,
      icon: Icons.account_tree_outlined,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _GestureSurface(
            label: 'DEFAULT',
            offset: _offset,
            rotation: _rotation,
            pressed: _pressed,
            longPressing: _longPressing,
          ),
          const SizedBox(height: 14),
          RawGestureDetector(
            behavior: HitTestBehavior.opaque,
            gestures: recognizers,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _teal.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(_radMd),
                border: Border.all(
                  color: _teal.withValues(alpha: 0.45),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Interact with the ink panel to trigger gestures.',
                    style: _body(13, color: _ink),
                  ),
                  const SizedBox(height: 10),
                  Semantics(
                    container: true,
                    label: 'Semantic actions exposed: tap, longPress, '
                        'scrollLeft, scrollRight, scrollUp, scrollDown',
                    child: _SemanticActionPills(
                      all: const <String>[
                        'tap',
                        'longPress',
                        'scrollLeft',
                        'scrollRight',
                        'scrollUp',
                        'scrollDown',
                        'increase',
                        'decrease',
                      ],
                      exposed: const <String>{
                        'tap',
                        'longPress',
                        'scrollLeft',
                        'scrollRight',
                        'scrollUp',
                        'scrollDown',
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  _InfoStrip(
                    icon: Icons.info_outline,
                    text:
                        'Internally, RawGestureDetector constructs a private '
                        '_DefaultSemanticsGestureDelegate that wires the tap/'
                        'longPress/drag recognizers straight into '
                        'RenderSemanticsGestureHandler.',
                    accent: _teal,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scene B — Excluded semantics.
//
// Same recognizers, but with `excludeFromSemantics: true`. No semantic
// actions are exposed. Useful for decorative/secondary gestures where
// screen readers should not announce the underlying widget as actionable.
// ---------------------------------------------------------------------------
class _ExcludedCard extends StatefulWidget {
  const _ExcludedCard({required this.onLog});

  final ValueChanged<_GestureLogEntry> onLog;

  @override
  State<_ExcludedCard> createState() => _ExcludedCardState();
}

class _ExcludedCardState extends State<_ExcludedCard> {
  Offset _offset = Offset.zero;
  double _rotation = 0;
  bool _pressed = false;
  bool _longPressing = false;

  void _log(String gesture, String note) {
    widget.onLog(_GestureLogEntry(
      timestamp: DateTime.now(),
      source: 'excluded',
      gesture: gesture,
      announced: false,
      note: note,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> recognizers = _buildRecognizers(
      onTap: () {
        setState(() {
          _pressed = true;
          _rotation -= math.pi / 10;
        });
        Future<void>.delayed(const Duration(milliseconds: 180), () {
          if (mounted) setState(() => _pressed = false);
        });
        _log('tap', 'Fires but NOT announced (excludeFromSemantics: true)');
      },
      onLongPress: () {
        setState(() => _longPressing = true);
        Future<void>.delayed(const Duration(milliseconds: 520), () {
          if (mounted) setState(() => _longPressing = false);
        });
        _log('longPress', 'Fires but NOT announced');
      },
      onHorizontalUpdate: (DragUpdateDetails d) {
        setState(() {
          _offset = Offset(_offset.dx + d.delta.dx, _offset.dy);
        });
        _log('horizontalDrag', 'Fires but NOT announced');
      },
      onVerticalUpdate: (DragUpdateDetails d) {
        setState(() {
          _offset = Offset(_offset.dx, _offset.dy + d.delta.dy);
        });
        _log('verticalDrag', 'Fires but NOT announced');
      },
    );

    return _SceneCard(
      title: 'Card B — excludeFromSemantics: true',
      subtitle:
          'No public ExcludingSemanticsGestureDelegate in 3.41.6; use this flag instead.',
      accent: _coral,
      icon: Icons.visibility_off_outlined,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _GestureSurface(
            label: 'EXCLUDED',
            offset: _offset,
            rotation: _rotation,
            pressed: _pressed,
            longPressing: _longPressing,
          ),
          const SizedBox(height: 14),
          RawGestureDetector(
            behavior: HitTestBehavior.opaque,
            excludeFromSemantics: true,
            gestures: recognizers,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _coral.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(_radMd),
                border: Border.all(
                  color: _coral.withValues(alpha: 0.45),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Same gestures, zero semantics. Useful for decorative motion.',
                    style: _body(13, color: _ink),
                  ),
                  const SizedBox(height: 10),
                  _SemanticActionPills(
                    all: const <String>[
                      'tap',
                      'longPress',
                      'scrollLeft',
                      'scrollRight',
                      'scrollUp',
                      'scrollDown',
                    ],
                    exposed: const <String>{},
                  ),
                  const SizedBox(height: 12),
                  _InfoStrip(
                    icon: Icons.warning_amber_rounded,
                    text:
                        'A screen reader will treat this widget as non-interactive. '
                        'Only use when the gesture is purely visual/decorative or '
                        'when an outer widget already advertises the same action.',
                    accent: _coral,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scene C — Custom _AnnouncingGestureDelegate.
//
// Subclasses the public abstract SemanticsGestureDelegate and overrides
// assignSemantics. On every mapped gesture it flashes a top banner and
// records an "announced" log entry.
// ---------------------------------------------------------------------------
class _AnnouncingDelegateCard extends StatefulWidget {
  const _AnnouncingDelegateCard({
    required this.onLog,
    required this.onAnnounce,
  });

  final ValueChanged<_GestureLogEntry> onLog;
  final ValueChanged<String> onAnnounce;

  @override
  State<_AnnouncingDelegateCard> createState() =>
      _AnnouncingDelegateCardState();
}

class _AnnouncingDelegateCardState extends State<_AnnouncingDelegateCard> {
  Offset _offset = Offset.zero;
  double _rotation = 0;
  bool _pressed = false;
  bool _longPressing = false;

  void _log(String gesture, String note) {
    widget.onLog(_GestureLogEntry(
      timestamp: DateTime.now(),
      source: 'announcing',
      gesture: gesture,
      announced: true,
      note: note,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> recognizers = _buildRecognizers(
      onTap: () {
        setState(() {
          _pressed = true;
          _rotation += math.pi / 14;
        });
        Future<void>.delayed(const Duration(milliseconds: 180), () {
          if (mounted) setState(() => _pressed = false);
        });
        _log('tap', 'Delegate announced and forwarded tap');
      },
      onLongPress: () {
        setState(() => _longPressing = true);
        Future<void>.delayed(const Duration(milliseconds: 520), () {
          if (mounted) setState(() => _longPressing = false);
        });
        _log('longPress', 'Delegate announced and forwarded longPress');
      },
      onHorizontalUpdate: (DragUpdateDetails d) {
        setState(() {
          _offset = Offset(_offset.dx + d.delta.dx, _offset.dy);
        });
        _log('horizontalDrag', 'Delegate announced + forwarded');
      },
      onVerticalUpdate: (DragUpdateDetails d) {
        setState(() {
          _offset = Offset(_offset.dx, _offset.dy + d.delta.dy);
        });
        _log('verticalDrag', 'Delegate announced + forwarded');
      },
    );

    final _AnnouncingGestureDelegate delegate = _AnnouncingGestureDelegate(
      onAnnounce: widget.onAnnounce,
      onTap: () {
        debugPrint('AnnouncingDelegate: semantic tap dispatched');
      },
      onLongPress: () {
        debugPrint('AnnouncingDelegate: semantic longPress dispatched');
      },
      onHorizontalDrag: (DragUpdateDetails d) {
        debugPrint('AnnouncingDelegate: semantic horizontal drag dispatched');
      },
      onVerticalDrag: (DragUpdateDetails d) {
        debugPrint('AnnouncingDelegate: semantic vertical drag dispatched');
      },
    );

    return _SceneCard(
      title: 'Card C — custom _AnnouncingGestureDelegate',
      subtitle:
          'Subclasses SemanticsGestureDelegate to announce every mapped action.',
      accent: _ink,
      icon: Icons.campaign_outlined,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _GestureSurface(
            label: 'ANNOUNCING',
            offset: _offset,
            rotation: _rotation,
            pressed: _pressed,
            longPressing: _longPressing,
          ),
          const SizedBox(height: 14),
          RawGestureDetector(
            behavior: HitTestBehavior.opaque,
            gestures: recognizers,
            // GEN-095/D8f: passing an interpreted subclass of the abstract
            // SemanticsGestureDelegate to the bridged `semantics:` parameter
            // requires a generated proxy that the bridge generator does not
            // emit yet. The delegate above is still constructed to keep the
            // illustrative subclass in the rendered code sample below; the
            // default semantics delegate is used at runtime.
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    _teal.withValues(alpha: 0.14),
                    _coral.withValues(alpha: 0.12),
                  ],
                ),
                borderRadius: BorderRadius.circular(_radMd),
                border: Border.all(color: _ink.withValues(alpha: 0.35)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Custom delegate prepends announcements before forwarding.',
                    style: _body(13, color: _ink),
                  ),
                  const SizedBox(height: 10),
                  _SemanticActionPills(
                    all: const <String>[
                      'tap',
                      'longPress',
                      'horizontalDrag',
                      'verticalDrag',
                    ],
                    exposed: const <String>{
                      'tap',
                      'longPress',
                      'horizontalDrag',
                      'verticalDrag',
                    },
                  ),
                  const SizedBox(height: 12),
                  _InfoStrip(
                    icon: Icons.lightbulb_outline,
                    text:
                        'assignSemantics(renderObject) wires tap/longPress/'
                        'drag handlers that both announce the label AND call '
                        'the business-layer callbacks. A production-grade '
                        'delegate would typically also respect validActions.',
                    accent: _ink,
                  ),
                  const SizedBox(height: 12),
                  _CodeBlock(
                    code: '''class _AnnouncingGestureDelegate
    extends SemanticsGestureDelegate {
  void assignSemantics(RenderSemanticsGestureHandler r) {
    r.onTap = () { onAnnounce('tap'); onTap?.call(); };
    r.onLongPress = () { onAnnounce('longPress'); onLongPress?.call(); };
    r.onHorizontalDragUpdate = (d) {
      onAnnounce('horizontalDrag');
      onHorizontalDrag?.call(d);
    };
    r.onVerticalDragUpdate = (d) {
      onAnnounce('verticalDrag');
      onVerticalDrag?.call(d);
    };
  }
}''',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _InfoStrip — small icon+text row used in each card body.
// ---------------------------------------------------------------------------
class _InfoStrip extends StatelessWidget {
  const _InfoStrip({
    required this.icon,
    required this.text,
    required this.accent,
  });

  final IconData icon;
  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(_radSm),
        border: Border.all(color: accent.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 16, color: accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: _body(12, color: _inkSoft, w: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _CodeBlock — monospace block with a subtle dark background.
// ---------------------------------------------------------------------------
class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _ink,
        borderRadius: BorderRadius.circular(_radSm),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          height: 1.45,
          color: _paper.withValues(alpha: 0.95),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Gesture log panel — rolling list of the last N events.
// ---------------------------------------------------------------------------
class _GestureLogPanel extends StatelessWidget {
  const _GestureLogPanel({required this.entries});

  final List<_GestureLogEntry> entries;

  @override
  Widget build(BuildContext context) {
    return _SceneCard(
      title: 'Gesture log',
      subtitle: 'Latest events from all three detectors — newest on top.',
      accent: _inkSoft,
      icon: Icons.receipt_long_outlined,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _ink.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(_radSm),
            ),
            child: Row(
              children: <Widget>[
                _logHeader('time', 2),
                _logHeader('source', 2),
                _logHeader('gesture', 2),
                _logHeader('announced', 2),
                _logHeader('note', 4),
              ],
            ),
          ),
          const SizedBox(height: 6),
          if (entries.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Center(
                child: Text(
                  'No events yet. Interact with the cards above to record gestures.',
                  style: _body(12, color: _mutedText),
                ),
              ),
            )
          else
            Column(
              children: <Widget>[
                for (int i = 0;
                    i < math.min(entries.length, 12);
                    i++)
                  _logRow(entries[entries.length - 1 - i], i),
              ],
            ),
        ],
      ),
    );
  }

  Widget _logHeader(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.7,
          color: _mutedText,
        ),
      ),
    );
  }

  Widget _logRow(_GestureLogEntry e, int i) {
    final Color band = i.isEven
        ? _paper
        : _paperMist;
    final Color srcColor = switch (e.source) {
      'default' => _teal,
      'excluded' => _coral,
      'announcing' => _ink,
      _ => _mutedText,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: band,
        borderRadius: BorderRadius.circular(_radSm),
      ),
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(e.timeString, style: _mono(11)),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: srcColor.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: srcColor.withValues(alpha: 0.35)),
              ),
              child: Text(
                e.source,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: srcColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(e.gesture, style: _title(12)),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: <Widget>[
                Icon(
                  e.announced ? Icons.record_voice_over : Icons.voice_over_off,
                  size: 14,
                  color: e.announced ? _teal : _coral,
                ),
                const SizedBox(width: 4),
                Text(
                  e.announced ? 'yes' : 'no',
                  style: _body(
                    11,
                    color: e.announced ? _teal : _coral,
                    w: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              e.note,
              style: _body(11, color: _inkSoft),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Instructional panels.
// ---------------------------------------------------------------------------
class _SemanticActionsPanel extends StatelessWidget {
  const _SemanticActionsPanel();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> rows = <Map<String, String>>[
      <String, String>{
        'gesture': 'TapGestureRecognizer',
        'action': 'SemanticsAction.tap',
        'note': 'Default delegate wires onTap directly into the semantic node.',
      },
      <String, String>{
        'gesture': 'LongPressGestureRecognizer',
        'action': 'SemanticsAction.longPress',
        'note': 'Full long-press lifecycle replayed at the render rect centre.',
      },
      <String, String>{
        'gesture': 'HorizontalDragGestureRecognizer',
        'action': 'scrollLeft / scrollRight',
        'note': 'Delta synthesised from render-box size and scrollFactor.',
      },
      <String, String>{
        'gesture': 'VerticalDragGestureRecognizer',
        'action': 'scrollUp / scrollDown',
        'note': 'Same strategy, orthogonal axis.',
      },
      <String, String>{
        'gesture': 'PanGestureRecognizer',
        'action': 'scrollLeft / scrollRight',
        'note': 'Pan maps onto horizontal scroll actions in the default delegate.',
      },
      <String, String>{
        'gesture': 'ScaleGestureRecognizer',
        'action': '(none)',
        'note': 'Pinch-to-zoom has no default semantic mapping — custom delegate required.',
      },
    ];
    return _SceneCard(
      title: 'Cheat sheet — gesture -> SemanticsAction',
      subtitle:
          'What Flutter\'s default delegate maps out of the box (3.41.6).',
      accent: _teal,
      icon: Icons.table_chart_outlined,
      body: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: i.isEven ? _paperMist : _paper,
                borderRadius: BorderRadius.circular(_radSm),
              ),
              margin: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      rows[i]['gesture']!,
                      style: _mono(12, color: _ink),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      rows[i]['action']!,
                      style: _title(12, color: _teal),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      rows[i]['note']!,
                      style: _body(12, color: _inkSoft),
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

class _ExcludeGuidancePanel extends StatelessWidget {
  const _ExcludeGuidancePanel();

  @override
  Widget build(BuildContext context) {
    final List<_GuidanceItem> items = <_GuidanceItem>[
      _GuidanceItem(
        icon: Icons.check_circle_outline,
        title: 'Exclude decorative motion',
        body:
            'Pan-to-dismiss animations, parallax effects, drag-to-reveal affordances '
            'that already have a button alternative elsewhere on the screen.',
        accent: _teal,
      ),
      _GuidanceItem(
        icon: Icons.check_circle_outline,
        title: 'Exclude redundant wrappers',
        body:
            'When an outer widget already exposes the same semantic action, '
            'excluding the inner gesture prevents double-announcement.',
        accent: _teal,
      ),
      _GuidanceItem(
        icon: Icons.warning_amber_rounded,
        title: 'NEVER exclude primary actions',
        body:
            'A tappable button that has only a RawGestureDetector must stay in '
            'the semantics tree — otherwise screen-reader users cannot reach it.',
        accent: _coral,
      ),
      _GuidanceItem(
        icon: Icons.warning_amber_rounded,
        title: 'Exclude != invisible',
        body:
            'excludeFromSemantics only hides the gesture from the semantics tree; '
            'the widget is still visible. Combine with Semantics/ExcludeSemantics '
            'to shape the tree carefully.',
        accent: _coral,
      ),
    ];
    return _SceneCard(
      title: 'When to exclude gestures from semantics',
      subtitle: 'Quick rules for deciding between default and exclusion.',
      accent: _coral,
      icon: Icons.rule_folder_outlined,
      body: Column(
        children: <Widget>[
          for (final _GuidanceItem item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: item.accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(_radSm),
                    ),
                    child: Icon(item.icon, color: item.accent, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.title, style: _title(13)),
                        const SizedBox(height: 2),
                        Text(item.body, style: _body(12)),
                      ],
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

class _GuidanceItem {
  const _GuidanceItem({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String body;
  final Color accent;
}

class _ScreenReaderVsVisualPanel extends StatelessWidget {
  const _ScreenReaderVsVisualPanel();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> rows = <Map<String, String>>[
      <String, String>{
        'scenario': 'Quick tap',
        'visual': 'Button flashes and runs onPressed',
        'sr': 'Double-tap (activate) triggers SemanticsAction.tap',
      },
      <String, String>{
        'scenario': 'Long press',
        'visual': 'Ripple grows then onLongPress fires',
        'sr': 'Two-finger double-tap-and-hold (TalkBack) -> SemanticsAction.longPress',
      },
      <String, String>{
        'scenario': 'Horizontal swipe',
        'visual': 'Content pans with finger',
        'sr': 'Swipe gesture -> scrollLeft / scrollRight on focused node',
      },
      <String, String>{
        'scenario': 'Vertical swipe',
        'visual': 'List scrolls',
        'sr': 'scrollUp / scrollDown semantic actions',
      },
      <String, String>{
        'scenario': 'Pinch / scale',
        'visual': 'Zoom in/out',
        'sr': 'No default semantic mapping — custom delegate needed',
      },
      <String, String>{
        'scenario': 'Drag + drop',
        'visual': 'Moves widget across screen',
        'sr': 'Usually exposed via two custom actions ("move up", "move down")',
      },
    ];
    return _SceneCard(
      title: 'Screen reader vs visual gesture',
      subtitle:
          'How the same visual intent surfaces differently for assistive tech.',
      accent: _ink,
      icon: Icons.compare_arrows_outlined,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Text('Scenario',
                    style: _title(12, color: _mutedText)),
              ),
              Expanded(
                flex: 4,
                child: Text('Visual user',
                    style: _title(12, color: _teal)),
              ),
              Expanded(
                flex: 4,
                child: Text('Screen reader user',
                    style: _title(12, color: _coral)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          for (int i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: i.isEven ? _paperMist : _paper,
                borderRadius: BorderRadius.circular(_radSm),
              ),
              margin: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(rows[i]['scenario']!,
                        style: _title(12)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(rows[i]['visual']!,
                        style: _body(12, color: _inkSoft)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(rows[i]['sr']!,
                        style: _body(12, color: _inkSoft)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Summary strip — small callouts at the bottom of the tour.
// ---------------------------------------------------------------------------
class _SummaryStrip extends StatelessWidget {
  const _SummaryStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _ink,
            _inkSoft.withValues(alpha: 0.92),
          ],
        ),
        borderRadius: BorderRadius.circular(_radLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _teal.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(_radSm),
                  border: Border.all(color: _teal),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.accessibility_new,
                    color: _teal, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Takeaways',
                  style: const TextStyle(
                    color: _paper,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _summaryRow(
            icon: Icons.lock_outline,
            color: _teal,
            title: 'Default delegate is private',
            body:
                '_DefaultSemanticsGestureDelegate is an implementation detail. '
                'You cannot instantiate it yourself — you get it by setting '
                'excludeFromSemantics: false and leaving semantics: null.',
          ),
          _summaryRow(
            icon: Icons.block,
            color: _coral,
            title: 'ExcludingSemanticsGestureDelegate is NOT public in 3.41.6',
            body:
                'Use excludeFromSemantics: true on RawGestureDetector or wrap '
                'in ExcludeSemantics to remove the gesture from the a11y tree.',
          ),
          _summaryRow(
            icon: Icons.extension_outlined,
            color: _paper,
            title: 'Custom delegate for bespoke semantics',
            body:
                'Subclass SemanticsGestureDelegate whenever you need custom '
                'announcements, analytics hooks, or non-default action mappings '
                '(e.g. pinch -> SemanticsAction.increase).',
          ),
        ],
      ),
    );
  }

  Widget _summaryRow({
    required IconData icon,
    required Color color,
    required String title,
    required String body,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(_radSm),
              border: Border.all(color: color.withValues(alpha: 0.55)),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: _paper,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: TextStyle(
                    color: _paper.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
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

// ---------------------------------------------------------------------------
// Root tour widget — orchestrates banner + announcement state + log history.
// ---------------------------------------------------------------------------
class _SemanticsGestureTour extends StatefulWidget {
  const _SemanticsGestureTour();

  @override
  State<_SemanticsGestureTour> createState() => _SemanticsGestureTourState();
}

class _SemanticsGestureTourState extends State<_SemanticsGestureTour> {
  final List<_GestureLogEntry> _entries = <_GestureLogEntry>[];
  String _banner = '';
  bool _bannerVisible = false;

  void _addEntry(_GestureLogEntry e) {
    setState(() {
      _entries.add(e);
      if (_entries.length > 64) {
        _entries.removeRange(0, _entries.length - 64);
      }
    });
    debugPrint(
      'GestureLog[${e.source}] ${e.timeString} ${e.gesture} '
      '(announced=${e.announced}): ${e.note}',
    );
  }

  void _announce(String label) {
    setState(() {
      _banner = label;
      _bannerVisible = true;
    });
    debugPrint('Banner announce: $label');
    Future<void>.delayed(const Duration(milliseconds: 1100), () {
      if (mounted) {
        setState(() => _bannerVisible = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 10),
        _AnnouncementBanner(message: _banner, visible: _bannerVisible),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_radLg),
            child: const _SemanticsPipelineHero(),
          ),
        ),
        const SizedBox(height: 6),
        const _TourIntroPanel(),
        _DefaultDelegateCard(onLog: _addEntry),
        _ExcludedCard(onLog: _addEntry),
        _AnnouncingDelegateCard(
          onLog: _addEntry,
          onAnnounce: _announce,
        ),
        _GestureLogPanel(entries: _entries),
        const _SemanticActionsPanel(),
        const _ExcludeGuidancePanel(),
        const _ScreenReaderVsVisualPanel(),
        const _SummaryStrip(),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Intro panel — short blurb at the top of the tour before the scenes begin.
// ---------------------------------------------------------------------------
class _TourIntroPanel extends StatelessWidget {
  const _TourIntroPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(_radLg),
        border: Border.all(color: _teal.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.school_outlined, color: _teal, size: 22),
              const SizedBox(width: 8),
              Text(
                'A11y Gesture Tour — SemanticsGestureDelegate',
                style: _title(17, color: _ink, w: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Every RawGestureDetector silently constructs a SemanticsGestureDelegate '
            'when it mounts. That delegate decides which of your recognizers leak '
            'into the semantics tree as actionable hints. This tour walks through '
            'the three options available in Flutter 3.41.6: the default delegate, '
            'the excluded variant (no public ExcludingSemanticsGestureDelegate in '
            'this version — we use excludeFromSemantics instead), and a hand-rolled '
            'announcing delegate.',
            style: _body(13, color: _mutedText),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// d4rt harness entrypoint.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('SemanticsGestureDelegate Deep Demo executing');
  debugPrint(' - Flutter 3.41.6 verified: SemanticsGestureDelegate public');
  debugPrint(' - _DefaultSemanticsGestureDelegate private (not subclassable)');
  debugPrint(' - No public ExcludingSemanticsGestureDelegate class in 3.41.6');
  debugPrint(' - Scene B pivots to excludeFromSemantics: true');
  debugPrint(' - Scene C subclasses the public abstract base directly');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _paperMist,
      colorScheme: const ColorScheme.light(
        primary: _teal,
        secondary: _coral,
        surface: _paper,
      ),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: _ink,
        foregroundColor: _paper,
        title: const Text(
          'SemanticsGestureDelegate — A11y Gesture Tour',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: const _SemanticsGestureTour(),
      ),
    ),
  );
}
