// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo of PlatformViewRenderBox from rendering
//
// PlatformViewRenderBox is the RenderObject that backs `PlatformViewSurface`.
// It is responsible for handing off a region of the Flutter render tree
// to a native platform view (Android `View` / iOS `UIView`) so the host
// platform can composite content underneath the Flutter surface.
//
// Constructor (Flutter 3.41.6):
//   PlatformViewRenderBox({
//     required PlatformViewController controller,
//     required PlatformViewHitTestBehavior hitTestBehavior,
//     required Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
//   })
//
// Setters: controller, hitTestBehavior, gestureRecognizers.
//
// PlatformViewRenderBox cannot be exercised in pure-Flutter contexts
// because it requires a real PlatformViewController bound to engine
// channels. This demo therefore renders illustrative diagrams,
// guidance and decision tables, guarded by the runtime platform.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// PALETTE / DESIGN TOKENS
// ═══════════════════════════════════════════════════════════════════════════

const Color _kHeroPrimary = Color(0xFF1A237E);
const Color _kHeroAccent = Color(0xFF3949AB);
const Color _kArchPrimary = Color(0xFF00695C);
const Color _kArchAccent = Color(0xFF26A69A);
const Color _kCtorPrimary = Color(0xFF4527A0);
const Color _kCtorAccent = Color(0xFF7E57C2);
const Color _kHitPrimary = Color(0xFFC62828);
const Color _kHitAccent = Color(0xFFEF5350);
const Color _kGesturePrimary = Color(0xFFEF6C00);
const Color _kGestureAccent = Color(0xFFFFB74D);
const Color _kPlatformPrimary = Color(0xFF2E7D32);
const Color _kPlatformAccent = Color(0xFF66BB6A);
const Color _kLifecyclePrimary = Color(0xFF6A1B9A);
const Color _kLifecycleAccent = Color(0xFFAB47BC);
const Color _kCompositingPrimary = Color(0xFF00838F);
const Color _kCompositingAccent = Color(0xFF26C6DA);
const Color _kPitfallPrimary = Color(0xFFAD1457);
const Color _kPitfallAccent = Color(0xFFEC407A);
const Color _kDecisionPrimary = Color(0xFF283593);
const Color _kDecisionAccent = Color(0xFF5C6BC0);
const Color _kReferencePrimary = Color(0xFF37474F);
const Color _kReferenceAccent = Color(0xFF78909C);
const Color _kFooterPrimary = Color(0xFF212121);
const Color _kFooterAccent = Color(0xFF616161);
const Color _kSurface = Color(0xFFF5F5FA);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER: section title
// ═══════════════════════════════════════════════════════════════════════════

Widget _sectionTitle(String title, IconData icon, Color primary) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primary.withAlpha(30),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: primary, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: primary,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// HELPER: card frame
// ═══════════════════════════════════════════════════════════════════════════

Widget _card({
  required Color primary,
  required Widget child,
  EdgeInsets padding = const EdgeInsets.all(16),
}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: primary.withAlpha(40)),
      boxShadow: [
        BoxShadow(
          color: primary.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// HELPER: code view
// ═══════════════════════════════════════════════════════════════════════════

Widget _codeView(String code, {Color primary = _kCtorPrimary}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1B1F2A),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: primary.withAlpha(60)),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.45,
        color: Color(0xFFE0E0FF),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// HELPER: bullet
// ═══════════════════════════════════════════════════════════════════════════

Widget _bullet(String text, {Color color = Colors.black87}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13.5, color: color, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// HELPER: chip
// ═══════════════════════════════════════════════════════════════════════════

Widget _chip(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// HELPER: hero header for sections
// ═══════════════════════════════════════════════════════════════════════════

Widget _sectionHero({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color primary,
  required Color accent,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [primary, accent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: primary.withAlpha(80),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 40),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withAlpha(220),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTER 1: hero "Flutter surface ── hole ── native view" diagram
// ═══════════════════════════════════════════════════════════════════════════

class _HeroSurfacePainter extends CustomPainter {
  _HeroSurfacePainter(this.primary, this.accent);
  final Color primary;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFF1F3FA);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    // Flutter surface band (top stripe)
    final flutterTop = Paint()..color = accent.withAlpha(120);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, 36), flutterTop);
    final flutterBottom = Paint()..color = accent.withAlpha(120);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - 36, size.width, 36),
      flutterBottom,
    );

    // Hole rect for native view
    final hole = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.55,
      height: size.height * 0.55,
    );

    final holeStroke = Paint()
      ..color = primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final holeFill = Paint()..color = const Color(0xFFFFF8E1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(hole, const Radius.circular(8)),
      holeFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(hole, const Radius.circular(8)),
      holeStroke,
    );

    // Diagonal hatch inside hole = native content
    final hatch = Paint()
      ..color = primary.withAlpha(70)
      ..strokeWidth = 1.4;
    for (var x = -size.height; x < size.width; x += 12) {
      canvas.drawLine(
        Offset(x.toDouble(), hole.top),
        Offset(x + hole.height, hole.bottom),
        hatch,
      );
    }

    // Labels
    _label(canvas, 'Flutter surface (Skia)', Offset(10, 10), accent);
    _label(
      canvas,
      'Native view composited beneath',
      Offset(hole.left + 8, hole.top + 8),
      primary,
    );
    _label(
      canvas,
      'Flutter surface continues',
      Offset(10, size.height - 28),
      accent,
    );

    // Arrow pointing into hole
    final arrow = Paint()
      ..color = primary
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(20, size.height / 2),
      Offset(hole.left - 6, size.height / 2),
      arrow,
    );
    final triPath = Path()
      ..moveTo(hole.left - 6, size.height / 2)
      ..lineTo(hole.left - 14, size.height / 2 - 5)
      ..lineTo(hole.left - 14, size.height / 2 + 5)
      ..close();
    canvas.drawPath(triPath, Paint()..color = primary);
  }

  void _label(Canvas canvas, String text, Offset at, Color color) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant _HeroSurfacePainter oldDelegate) =>
      oldDelegate.primary != primary || oldDelegate.accent != accent;
}

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTER 2: architecture diagram
// ═══════════════════════════════════════════════════════════════════════════

class _ArchitecturePainter extends CustomPainter {
  _ArchitecturePainter(this.primary, this.accent);
  final Color primary;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFF1FBF7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    final boxes = <_ArchBox>[
      _ArchBox('PlatformViewSurface (Widget)', 0.05, 0.10, 0.45, 0.16, accent),
      _ArchBox('PlatformViewRenderBox', 0.05, 0.34, 0.45, 0.16, primary),
      _ArchBox('PlatformViewController', 0.55, 0.10, 0.4, 0.16, accent),
      _ArchBox('Engine (C++/Skia)', 0.55, 0.34, 0.4, 0.16, primary),
      _ArchBox('Android View / UIView', 0.30, 0.65, 0.4, 0.18, primary),
    ];

    for (final b in boxes) {
      final rect = Rect.fromLTWH(
        b.x * size.width,
        b.y * size.height,
        b.w * size.width,
        b.h * size.height,
      );
      final fill = Paint()..color = b.color.withAlpha(35);
      final stroke = Paint()
        ..color = b.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8;
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        fill,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        stroke,
      );

      final tp = TextPainter(
        text: TextSpan(
          text: b.label,
          style: TextStyle(
            color: b.color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: rect.width - 12);
      tp.paint(
        canvas,
        Offset(
          rect.left + (rect.width - tp.width) / 2,
          rect.top + (rect.height - tp.height) / 2,
        ),
      );
    }

    // Arrows
    final arrowPaint = Paint()
      ..color = primary.withAlpha(180)
      ..strokeWidth = 1.6;

    void arrow(Offset from, Offset to) {
      canvas.drawLine(from, to, arrowPaint);
      final dx = to.dx - from.dx;
      final dy = to.dy - from.dy;
      final mag = (dx * dx + dy * dy);
      if (mag <= 0) return;
      final inv = 1.0 / (mag <= 0 ? 1 : (mag * 0.5)); // not used directly
      // small arrow head
      final ah = Path()
        ..moveTo(to.dx, to.dy)
        ..lineTo(to.dx - 6, to.dy - 4)
        ..lineTo(to.dx - 6, to.dy + 4)
        ..close();
      canvas.drawPath(ah, Paint()..color = primary);
      // suppress unused
      // ignore: unused_local_variable
      final _ = inv;
    }

    arrow(
      Offset(0.275 * size.width, 0.26 * size.height),
      Offset(0.275 * size.width, 0.34 * size.height),
    );
    arrow(
      Offset(0.50 * size.width, 0.18 * size.height),
      Offset(0.55 * size.width, 0.18 * size.height),
    );
    arrow(
      Offset(0.75 * size.width, 0.26 * size.height),
      Offset(0.75 * size.width, 0.34 * size.height),
    );
    arrow(
      Offset(0.50 * size.width, 0.42 * size.height),
      Offset(0.55 * size.width, 0.42 * size.height),
    );
    arrow(
      Offset(0.50 * size.width, 0.48 * size.height),
      Offset(0.50 * size.width, 0.65 * size.height),
    );
  }

  @override
  bool shouldRepaint(covariant _ArchitecturePainter oldDelegate) =>
      oldDelegate.primary != primary || oldDelegate.accent != accent;
}

class _ArchBox {
  const _ArchBox(this.label, this.x, this.y, this.w, this.h, this.color);
  final String label;
  final double x;
  final double y;
  final double w;
  final double h;
  final Color color;
}

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTER 3: lifecycle flow
// ═══════════════════════════════════════════════════════════════════════════

class _LifecyclePainter extends CustomPainter {
  _LifecyclePainter(this.activeIndex, this.primary, this.accent);
  final int activeIndex;
  final Color primary;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFFAF5FE);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    const stages = ['create', 'attach', 'resize', 'pointer', 'dispose'];
    final stepW = size.width / stages.length;

    for (var i = 0; i < stages.length; i++) {
      final isActive = i == activeIndex;
      final centerX = stepW * i + stepW / 2;
      final centerY = size.height / 2;
      final color = isActive ? primary : accent.withAlpha(160);
      final radius = isActive ? 26.0 : 20.0;

      canvas.drawCircle(Offset(centerX, centerY), radius, Paint()..color = color);

      final tp = TextPainter(
        text: TextSpan(
          text: stages[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(centerX - tp.width / 2, centerY - tp.height / 2),
      );

      if (i < stages.length - 1) {
        final p = Paint()
          ..color = primary.withAlpha(120)
          ..strokeWidth = 2;
        canvas.drawLine(
          Offset(centerX + radius, centerY),
          Offset(centerX + stepW - 20, centerY),
          p,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LifecyclePainter oldDelegate) =>
      oldDelegate.activeIndex != activeIndex;
}

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTER 4: hit-test stacks (opaque/translucent/transparent)
// ═══════════════════════════════════════════════════════════════════════════

class _HitStackPainter extends CustomPainter {
  _HitStackPainter(this.label, this.color, this.passThrough);
  final String label;
  final Color color;
  final bool passThrough;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFFFF7F7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );
    // Background flutter widgets
    final back = Paint()..color = color.withAlpha(90);
    canvas.drawRect(Rect.fromLTWH(8, size.height - 32, size.width - 16, 24), back);

    // Platform view region
    final pv = Paint()..color = color.withAlpha(passThrough ? 80 : 200);
    canvas.drawRect(
      Rect.fromLTWH(20, 20, size.width - 40, size.height - 60),
      pv,
    );

    // Pointer arrow
    final arrowPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.6;
    canvas.drawLine(
      Offset(size.width / 2, 4),
      Offset(size.width / 2, size.height - 14),
      arrowPaint,
    );
    final ah = Path()
      ..moveTo(size.width / 2, size.height - 14)
      ..lineTo(size.width / 2 - 5, size.height - 22)
      ..lineTo(size.width / 2 + 5, size.height - 22)
      ..close();
    canvas.drawPath(ah, Paint()..color = Colors.black);

    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, size.height / 2 - 6));
  }

  @override
  bool shouldRepaint(covariant _HitStackPainter oldDelegate) =>
      oldDelegate.label != label ||
      oldDelegate.color != color ||
      oldDelegate.passThrough != passThrough;
}

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTER 5: compositing strategies
// ═══════════════════════════════════════════════════════════════════════════

class _CompositingPainter extends CustomPainter {
  _CompositingPainter(this.mode, this.primary, this.accent);
  final String mode; // 'hybrid' or 'texture'
  final Color primary;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFE0F7FA);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    // Title
    final title = TextPainter(
      text: TextSpan(
        text: mode == 'hybrid' ? 'Hybrid Composition' : 'Texture Layer',
        style: TextStyle(
          color: primary,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    title.paint(canvas, const Offset(12, 10));

    // Bands
    if (mode == 'hybrid') {
      // Native draws into Flutter surface (in-line)
      final native = Paint()..color = primary.withAlpha(120);
      canvas.drawRect(
        Rect.fromLTWH(20, 40, size.width - 40, 36),
        native,
      );
      _txt(
        canvas,
        'Native view rendered in-place',
        const Offset(28, 48),
        Colors.white,
      );
      _txt(
        canvas,
        'Pros: real native widgets / full feature set',
        const Offset(20, 88),
        primary,
      );
      _txt(
        canvas,
        'Cons: thread sync cost; older Android only platform views thread',
        const Offset(20, 104),
        primary,
      );
    } else {
      // Texture: native renders off-screen, sent as texture
      final tex = Paint()..color = accent.withAlpha(150);
      canvas.drawRect(
        Rect.fromLTWH(20, 40, size.width - 40, 24),
        tex,
      );
      _txt(canvas, 'Texture (off-screen)', const Offset(28, 44), Colors.white);
      final draw = Paint()..color = primary.withAlpha(150);
      canvas.drawRect(
        Rect.fromLTWH(20, 70, size.width - 40, 18),
        draw,
      );
      _txt(canvas, 'Composited by Flutter', const Offset(28, 72), Colors.white);
      _txt(
        canvas,
        'Pros: GPU-friendly compositing',
        const Offset(20, 96),
        primary,
      );
      _txt(
        canvas,
        'Cons: not all native APIs available, focus issues',
        const Offset(20, 112),
        primary,
      );
    }
  }

  void _txt(Canvas canvas, String text, Offset at, Color color) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant _CompositingPainter oldDelegate) =>
      oldDelegate.mode != mode;
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION BUILDERS
// ═══════════════════════════════════════════════════════════════════════════

// 1. HERO INTRO ────────────────────────────────────────────────────────────
Widget _section1HeroIntro() {
  return _card(
    primary: _kHeroPrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHero(
              title: 'PlatformViewRenderBox',
              subtitle:
                  'The render box that hands a region of the Flutter surface '
                  'to a native platform view (Android View / iOS UIView).',
              icon: Icons.developer_board,
              primary: _kHeroPrimary,
              accent: _kHeroAccent,
            ),
            const SizedBox(height: 16),
            const Text(
              'A platform view embeds a real native widget — a WebView, '
              'MapView, AdView, video player, native camera preview — '
              'inside a Flutter app. The Flutter framework cuts a '
              '"hole" in the rendered output so the host platform can '
              'composite that native widget into the same window.',
              style: TextStyle(fontSize: 14, height: 1.55),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: CustomPaint(
                painter: _HeroSurfacePainter(_kHeroPrimary, _kHeroAccent),
                size: const Size(double.infinity, 200),
              ),
            ),
            const SizedBox(height: 16),
            _bullet(
              'Why a special RenderBox? Standard Flutter widgets cannot '
              'host an opaque native surface — paint commands flow through '
              'Skia, but a native view lives outside Skia.',
            ),
            _bullet(
              'PlatformViewRenderBox uses a PlatformViewLayer in painting '
              'and forwards size + transform to the engine, which forwards '
              'it to the platform side.',
            ),
            _bullet(
              'Hit testing is special: pointer events that land inside the '
              'platform view region must be routed to the native view (or '
              'not, depending on hitTestBehavior).',
            ),
            _bullet(
              'Gestures the Flutter side wants to keep (e.g. an outer '
              'scroll) are claimed via the gestureRecognizers factory set.',
            ),
          ],
        );
      },
    ),
  );
}

// 2. ARCHITECTURE MAP ──────────────────────────────────────────────────────
Widget _section2Architecture() {
  return _card(
    primary: _kArchPrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHero(
              title: 'Architecture',
              subtitle:
                  'PlatformViewSurface ▶ PlatformViewRenderBox ▶ '
                  'PlatformViewController ▶ Engine ▶ Native widget',
              icon: Icons.account_tree,
              primary: _kArchPrimary,
              accent: _kArchAccent,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 240,
              child: CustomPaint(
                painter: _ArchitecturePainter(_kArchPrimary, _kArchAccent),
                size: const Size(double.infinity, 240),
              ),
            ),
            const SizedBox(height: 12),
            _bullet(
              'PlatformViewSurface is a Widget. It builds the leaf '
              'render object PlatformViewRenderBox.',
              color: _kArchPrimary,
            ),
            _bullet(
              'PlatformViewRenderBox needs a PlatformViewController; '
              'changing the controller via the setter detaches/attaches.',
              color: _kArchPrimary,
            ),
            _bullet(
              'PlatformViewController owns engine channel calls — '
              'create(), dispose(), dispatchPointerEvent(), '
              'clearFocus().',
              color: _kArchPrimary,
            ),
            _bullet(
              'The engine then talks to the platform-specific native '
              'plugin (FlutterAndroidPlatformView, FlutterPlatformView '
              'on iOS).',
              color: _kArchPrimary,
            ),
          ],
        );
      },
    ),
  );
}

// 3. CONSTRUCTOR ───────────────────────────────────────────────────────────
Widget _section3Constructor() {
  return _card(
    primary: _kCtorPrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHero(
              title: 'Constructor parameters',
              subtitle:
                  'Three required parameters; setters of the same name '
                  'allow live updates.',
              icon: Icons.construction,
              primary: _kCtorPrimary,
              accent: _kCtorAccent,
            ),
            const SizedBox(height: 16),
            _codeView(
              'PlatformViewRenderBox({\n'
              '  required PlatformViewController controller,\n'
              '  required PlatformViewHitTestBehavior hitTestBehavior,\n'
              '  required Set<Factory<OneSequenceGestureRecognizer>>\n'
              '      gestureRecognizers,\n'
              '})',
            ),
            const SizedBox(height: 16),
            const Text(
              'controller',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _kCtorPrimary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'A PlatformViewController is the bridge to the engine. '
              'On Android it is typically an AndroidViewController; on '
              'iOS a UiKitViewController. It must be live (not disposed) '
              'and bound to a viewId.',
              style: TextStyle(fontSize: 13.5, height: 1.5),
            ),
            const SizedBox(height: 12),
            const Text(
              'hitTestBehavior',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _kCtorPrimary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Decides what happens to pointer events inside the bounds '
              'of the platform view: opaque, translucent, transparent.',
              style: TextStyle(fontSize: 13.5, height: 1.5),
            ),
            const SizedBox(height: 12),
            const Text(
              'gestureRecognizers',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _kCtorPrimary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'A set of GestureRecognizer factories that can compete in '
              'the Flutter gesture arena BEFORE the native side wins. '
              'Use this to let an outer Scrollable steal vertical drags.',
              style: TextStyle(fontSize: 13.5, height: 1.5),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'How AndroidView builds it internally (sketch):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 8),
            _codeView(
              '// pseudocode of AndroidView -> _PlatformViewSurface chain\n'
              'AndroidView(\n'
              '  viewType: "com.example/native_map",\n'
              '  layoutDirection: TextDirection.ltr,\n'
              '  onPlatformViewCreated: (id) {/* ... */},\n'
              '  hitTestBehavior: PlatformViewHitTestBehavior.opaque,\n'
              '  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{\n'
              '    Factory(() => EagerGestureRecognizer()),\n'
              '  },\n'
              ')\n'
              '// builds:\n'
              'PlatformViewSurface(\n'
              '  controller: <AndroidViewController>,\n'
              '  hitTestBehavior: PlatformViewHitTestBehavior.opaque,\n'
              '  gestureRecognizers: { ... },\n'
              ')\n'
              '// which creates a PlatformViewRenderBox',
            ),
          ],
        );
      },
    ),
  );
}

// 4. HIT-TEST BEHAVIOR GALLERY ─────────────────────────────────────────────
Widget _section4HitTest() {
  Widget panel(String title, String desc, Color color, bool passThrough) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 130,
            child: CustomPaint(
              painter: _HitStackPainter(title, color, passThrough),
              size: const Size(double.infinity, 130),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: const TextStyle(fontSize: 11.5, height: 1.4),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  return _card(
    primary: _kHitPrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHero(
              title: 'Hit-test behavior',
              subtitle:
                  'Three modes decide whether pointer events stop at the '
                  'platform view, pass through, or are ignored entirely.',
              icon: Icons.touch_app,
              primary: _kHitPrimary,
              accent: _kHitAccent,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                panel(
                  'opaque',
                  'PV always wins; widgets behind never see the pointer.',
                  _kHitPrimary,
                  false,
                ),
                const SizedBox(width: 8),
                panel(
                  'translucent',
                  'PV gets the pointer AND widgets behind also receive it.',
                  _kHitAccent,
                  true,
                ),
                const SizedBox(width: 8),
                panel(
                  'transparent',
                  'PV passes pointer through; widgets behind handle it.',
                  Colors.deepOrange,
                  true,
                ),
              ],
            ),
            const SizedBox(height: 12),
            _bullet(
              'Default for AndroidView/UiKitView is `opaque` — sensible '
              'for full-screen native components like maps.',
              color: _kHitPrimary,
            ),
            _bullet(
              '`translucent` is useful if you want both Flutter and the '
              'native view to react (e.g. analytics overlay).',
              color: _kHitPrimary,
            ),
            _bullet(
              '`transparent` is rare: makes the native view purely '
              'cosmetic from a hit-test point of view.',
              color: _kHitPrimary,
            ),
          ],
        );
      },
    ),
  );
}

// 5. GESTURE RECOGNIZER FACTORIES ──────────────────────────────────────────
Widget _section5Gestures() {
  return _card(
    primary: _kGesturePrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        var lastEvent = '(no gesture yet)';
        var tapCount = 0;
        var dragDx = 0.0;
        return StatefulBuilder(
          builder: (context, setLocal) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHero(
                  title: 'Gesture recognizer factories',
                  subtitle:
                      'A Set<Factory<OneSequenceGestureRecognizer>> tells '
                      'the framework which recognizers may compete with '
                      'the native view in the gesture arena.',
                  icon: Icons.gesture,
                  primary: _kGesturePrimary,
                  accent: _kGestureAccent,
                ),
                const SizedBox(height: 16),
                _codeView(
                  'final recognizers = <Factory<OneSequenceGestureRecognizer>>{\n'
                  '  Factory<TapGestureRecognizer>(\n'
                  '    () => TapGestureRecognizer(),\n'
                  '  ),\n'
                  '  Factory<HorizontalDragGestureRecognizer>(\n'
                  '    () => HorizontalDragGestureRecognizer(),\n'
                  '  ),\n'
                  '  Factory<EagerGestureRecognizer>(\n'
                  '    () => EagerGestureRecognizer(),\n'
                  '  ),\n'
                  '};\n'
                  '// then pass to PlatformViewSurface:\n'
                  'PlatformViewSurface(\n'
                  '  controller: ctrl,\n'
                  '  hitTestBehavior: PlatformViewHitTestBehavior.opaque,\n'
                  '  gestureRecognizers: recognizers,\n'
                  ')',
                ),
                const SizedBox(height: 16),
                const Text(
                  'Simulated gesture target (cross-platform safe):',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    setLocal(() {
                      tapCount += 1;
                      lastEvent = 'tap (#$tapCount)';
                    });
                  },
                  onHorizontalDragUpdate: (details) {
                    setLocal(() {
                      dragDx += details.delta.dx;
                      lastEvent =
                          'horizontal drag dx=${dragDx.toStringAsFixed(1)}';
                    });
                  },
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: _kGesturePrimary.withAlpha(40),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _kGesturePrimary),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      lastEvent,
                      style: TextStyle(
                        color: _kGesturePrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _chip('TapGestureRecognizer', _kGesturePrimary),
                    _chip('HorizontalDragGestureRecognizer', _kGesturePrimary),
                    _chip('VerticalDragGestureRecognizer', _kGesturePrimary),
                    _chip('ScaleGestureRecognizer', _kGesturePrimary),
                    _chip('LongPressGestureRecognizer', _kGesturePrimary),
                    _chip('EagerGestureRecognizer (always wins)',
                        _kGestureAccent),
                  ],
                ),
                const SizedBox(height: 12),
                _bullet(
                  'EagerGestureRecognizer is a common shortcut — it wins '
                  'every gesture immediately, giving the native view '
                  'full control.',
                  color: _kGesturePrimary,
                ),
                _bullet(
                  'Add only the gestures the OUTER Flutter UI wants to '
                  'compete for. Everything not listed is forwarded to '
                  'native.',
                  color: _kGesturePrimary,
                ),
              ],
            );
          },
        );
      },
    ),
  );
}

// 6. LIVE NATIVE-VIEW SECTION (guarded) ────────────────────────────────────
Widget _section6PlatformGuarded() {
  return _card(
    primary: _kPlatformPrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        final platform = Theme.of(context).platform;
        final platformName = platform.toString().split('.').last;

        Widget body;
        if (platform == TargetPlatform.android) {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Running on Android: real platform views are available.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _kPlatformPrimary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'On Android you would normally use `AndroidView` or '
                '`AndroidViewSurface`. They internally create a '
                'PlatformViewController and a PlatformViewSurface, which '
                'then builds the PlatformViewRenderBox.',
                style: TextStyle(fontSize: 13.5, height: 1.5),
              ),
              const SizedBox(height: 8),
              _codeView(
                'AndroidView(\n'
                '  viewType: "plugins.flutter.io/google_maps",\n'
                '  creationParams: const {},\n'
                '  creationParamsCodec: const StandardMessageCodec(),\n'
                ')',
              ),
            ],
          );
        } else if (platform == TargetPlatform.iOS) {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Running on iOS: real platform views are available.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _kPlatformPrimary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'On iOS you would use `UiKitView`. Like AndroidView it '
                'wraps a PlatformViewSurface and the underlying '
                'PlatformViewRenderBox.',
                style: TextStyle(fontSize: 13.5, height: 1.5),
              ),
              const SizedBox(height: 8),
              _codeView(
                'UiKitView(\n'
                '  viewType: "plugins.flutter.io/webview",\n'
                '  creationParams: const {},\n'
                '  creationParamsCodec: const StandardMessageCodec(),\n'
                ')',
              ),
            ],
          );
        } else {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withAlpha(50),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber.shade700),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded,
                        color: Colors.orange),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Platform views only render on Android or iOS. '
                        'You are on `$platformName`. Below is a schematic '
                        'of what would otherwise be drawn here.',
                        style: const TextStyle(fontSize: 13.2, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: CustomPaint(
                  painter:
                      _HeroSurfacePainter(_kPlatformPrimary, _kPlatformAccent),
                  size: const Size(double.infinity, 200),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'On a desktop / web build, attempting to use AndroidView '
                'or UiKitView throws AssertionError or simply renders '
                'nothing. Always guard with Theme.of(context).platform.',
                style: TextStyle(fontSize: 13.5, height: 1.5),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHero(
              title: 'Live native view (guarded)',
              subtitle:
                  'Detected platform: $platformName. PlatformViewRenderBox '
                  'is only meaningful on Android or iOS.',
              icon: Icons.devices,
              primary: _kPlatformPrimary,
              accent: _kPlatformAccent,
            ),
            const SizedBox(height: 16),
            body,
          ],
        );
      },
    ),
  );
}

// 7. STATE-CONTROLLER LIFECYCLE ────────────────────────────────────────────
Widget _section7Lifecycle() {
  return _card(
    primary: _kLifecyclePrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        var stage = 0;
        var creates = 0;
        var resizes = 0;
        var disposes = 0;
        return StatefulBuilder(
          builder: (context, setLocal) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHero(
                  title: 'Controller lifecycle',
                  subtitle:
                      'create → attach → resize ↔ pointer → dispose. '
                      'PlatformViewRenderBox forwards layout and pointer '
                      'events to the controller at each step.',
                  icon: Icons.replay,
                  primary: _kLifecyclePrimary,
                  accent: _kLifecycleAccent,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 90,
                  child: CustomPaint(
                    painter: _LifecyclePainter(
                      stage,
                      _kLifecyclePrimary,
                      _kLifecycleAccent,
                    ),
                    size: const Size(double.infinity, 90),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kLifecyclePrimary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () =>
                          setLocal(() {
                            creates += 1;
                            stage = 0;
                          }),
                      icon: const Icon(Icons.add),
                      label: Text('create() ($creates)'),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kLifecycleAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => setLocal(() {
                        stage = 1;
                      }),
                      icon: const Icon(Icons.link),
                      label: const Text('attach()'),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kLifecyclePrimary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => setLocal(() {
                        resizes += 1;
                        stage = 2;
                      }),
                      icon: const Icon(Icons.aspect_ratio),
                      label: Text('resize() ($resizes)'),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kLifecycleAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => setLocal(() {
                        stage = 3;
                      }),
                      icon: const Icon(Icons.touch_app),
                      label: const Text('pointer()'),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kPitfallPrimary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => setLocal(() {
                        disposes += 1;
                        stage = 4;
                      }),
                      icon: const Icon(Icons.delete),
                      label: Text('dispose() ($disposes)'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _bullet(
                  'PlatformViewRenderBox.attach(PipelineOwner) registers '
                  'the box with the rendering pipeline; it forwards '
                  'attach/detach to the controller via subscriptions.',
                  color: _kLifecyclePrimary,
                ),
                _bullet(
                  'During performLayout the box accepts the parent '
                  'constraints, sizes itself, and the engine resizes the '
                  'native view to match.',
                  color: _kLifecyclePrimary,
                ),
                _bullet(
                  'On dispose, the controller must call '
                  'PlatformViewController.dispose(); failing to do so '
                  'leaks a native window.',
                  color: _kLifecyclePrimary,
                ),
              ],
            );
          },
        );
      },
    ),
  );
}

// 8. COMPOSITING TRADE-OFFS ────────────────────────────────────────────────
Widget _section8Compositing() {
  return _card(
    primary: _kCompositingPrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHero(
              title: 'Compositing strategies',
              subtitle:
                  'Hybrid Composition vs Texture Layer — both are valid '
                  'PlatformViewRenderBox backends with different costs.',
              icon: Icons.layers,
              primary: _kCompositingPrimary,
              accent: _kCompositingAccent,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: CustomPaint(
                      painter: _CompositingPainter(
                        'hybrid',
                        _kCompositingPrimary,
                        _kCompositingAccent,
                      ),
                      size: const Size(double.infinity, 150),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: CustomPaint(
                      painter: _CompositingPainter(
                        'texture',
                        _kCompositingPrimary,
                        _kCompositingAccent,
                      ),
                      size: const Size(double.infinity, 150),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _bullet(
              'Hybrid Composition (Android default since 1.22, iOS '
              'default): native renders into the same Flutter window, '
              'gives the highest fidelity but requires UI/raster thread '
              'merger.',
              color: _kCompositingPrimary,
            ),
            _bullet(
              'Texture Layer (Android virtual display): native renders '
              'off-screen and the bitmap is composited as a Flutter '
              'texture. Lighter and animatable, but loses focus / '
              'accessibility integration.',
              color: _kCompositingPrimary,
            ),
            _bullet(
              'PlatformViewRenderBox is unaware of the strategy — that '
              'is decided by the controller variant (e.g. '
              'TextureAndroidViewController vs SurfaceAndroidViewController).',
              color: _kCompositingPrimary,
            ),
          ],
        );
      },
    ),
  );
}

// 9. COMMON PITFALLS ───────────────────────────────────────────────────────
Widget _section9Pitfalls() {
  Widget pitfall(String title, String body, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kPitfallAccent.withAlpha(20),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kPitfallPrimary.withAlpha(80)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _kPitfallPrimary, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _kPitfallPrimary,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(fontSize: 13, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _card(
    primary: _kPitfallPrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHero(
              title: 'Common pitfalls',
              subtitle:
                  'Mistakes that show up as black holes, dropped pointers '
                  'or memory leaks.',
              icon: Icons.bug_report,
              primary: _kPitfallPrimary,
              accent: _kPitfallAccent,
            ),
            const SizedBox(height: 16),
            pitfall(
              'Null / disposed controller',
              'Passing a controller whose engine view was already '
              'disposed leaves the render box with nothing to display. '
              'Always recreate the controller when the surface widget is '
              'recreated, or use a key.',
              Icons.power_off,
            ),
            pitfall(
              'Missing gestureRecognizers',
              'If the outer scrollable wraps the platform view and '
              'gestureRecognizers is empty, the native view will swallow '
              'all drags. Add at least a VerticalDragGestureRecognizer '
              'so the parent Scrollable can win.',
              Icons.swipe,
            ),
            pitfall(
              'Hit-test layering',
              'Stacking a translucent overlay over an opaque platform '
              'view with the wrong hitTestBehavior on the OVERLAY can '
              'block ALL pointers. Pick translucent on the topmost '
              'widgets you want to pass through.',
              Icons.layers_outlined,
            ),
            pitfall(
              'Resizing every frame',
              'A parent that animates the size of the platform view '
              'forces an engine resize each frame, which on Android '
              'can stutter for hybrid composition. Snap sizes to '
              'discrete steps if possible.',
              Icons.aspect_ratio,
            ),
            pitfall(
              'Forgetting platform guard',
              'Importing a plugin that uses AndroidView/UiKitView and '
              'building it on desktop/web will break or render '
              'nothing — always guard with '
              'Theme.of(context).platform == TargetPlatform.android/iOS.',
              Icons.shield,
            ),
          ],
        );
      },
    ),
  );
}

// 10. DECISION CARD ────────────────────────────────────────────────────────
Widget _section10Decision() {
  Widget choice(String title, String when, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(when, style: const TextStyle(fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _card(
    primary: _kDecisionPrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHero(
              title: 'Decision card',
              subtitle:
                  'When does PlatformViewRenderBox / PlatformViewSurface '
                  'belong in the widget tree?',
              icon: Icons.compare_arrows,
              primary: _kDecisionPrimary,
              accent: _kDecisionAccent,
            ),
            const SizedBox(height: 16),
            choice(
              'AndroidView',
              'You need any native Android View on Android only — Map, '
              'WebView, AdView, native camera preview. Most projects '
              'should start here.',
              Icons.android,
              _kDecisionPrimary,
            ),
            choice(
              'UiKitView',
              'iOS counterpart of AndroidView for UIView-based plugins.',
              Icons.phone_iphone,
              _kDecisionAccent,
            ),
            choice(
              'webview_flutter / google_maps_flutter',
              'You only want a WebView or Google Map. Use the official '
              'plugin — they wrap PlatformViewSurface for you.',
              Icons.public,
              _kDecisionPrimary,
            ),
            choice(
              'Custom controller + PlatformViewSurface',
              'You are writing your own native plugin and need full '
              'control of creationParams, hit testing and gestures.',
              Icons.build,
              _kDecisionAccent,
            ),
            choice(
              'NOT a platform view',
              'Pure-Flutter graphics, custom paint, video via Texture '
              'plugin only. Avoid the platform-view tax of compositing '
              'overhead and gesture arena complexity.',
              Icons.block,
              _kPitfallPrimary,
            ),
          ],
        );
      },
    ),
  );
}

// 11. REFERENCE TABLE ──────────────────────────────────────────────────────
Widget _section11ReferenceTable() {
  final rows = <List<String>>[
    [
      'controller',
      'PlatformViewController',
      'Bridge to engine; setter detaches old, attaches new.',
    ],
    [
      'hitTestBehavior',
      'PlatformViewHitTestBehavior',
      'opaque / translucent / transparent — pointer routing.',
    ],
    [
      'gestureRecognizers',
      'Set<Factory<…>>',
      'Recognizers that compete with native in the gesture arena.',
    ],
    [
      'sizedByParent',
      'bool (true)',
      'Layout is fully decided by parent constraints; no child layout.',
    ],
    [
      'isRepaintBoundary',
      'bool (true)',
      'Always its own layer so the engine can hand the region to native.',
    ],
    [
      'paint(context, offset)',
      'override',
      'Adds a PlatformViewLayer with the bounding rect.',
    ],
    [
      'hitTest(result, position)',
      'override',
      'Implements the chosen hitTestBehavior policy.',
    ],
    [
      'attach(owner) / detach()',
      'override',
      'Subscribes / unsubscribes the controller to pointer routing.',
    ],
    [
      'describeApproximatePaintClip',
      'override',
      'Reports the platform view bounds to the painting pipeline.',
    ],
  ];

  return _card(
    primary: _kReferencePrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHero(
              title: 'API reference',
              subtitle:
                  'Public members exposed by PlatformViewRenderBox and '
                  'what they affect.',
              icon: Icons.menu_book,
              primary: _kReferencePrimary,
              accent: _kReferenceAccent,
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  _kReferencePrimary.withAlpha(25),
                ),
                columns: const [
                  DataColumn(label: Text('Member')),
                  DataColumn(label: Text('Type / Kind')),
                  DataColumn(label: Text('Effect')),
                ],
                rows: rows
                    .map(
                      (r) => DataRow(
                        cells: r
                            .map(
                              (c) => DataCell(
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 320),
                                  child: Text(
                                    c,
                                    style: const TextStyle(
                                      fontSize: 12.5,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    ),
  );
}

// 12. FOOTER ───────────────────────────────────────────────────────────────
Widget _section12Footer() {
  return _card(
    primary: _kFooterPrimary,
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHero(
              title: 'References',
              subtitle: 'Primary Flutter SDK types relevant to '
                  'PlatformViewRenderBox.',
              icon: Icons.link,
              primary: _kFooterPrimary,
              accent: _kFooterAccent,
            ),
            const SizedBox(height: 12),
            _bullet(
              'PlatformViewSurface – the widget that creates a '
              'PlatformViewRenderBox.',
              color: _kFooterPrimary,
            ),
            _bullet(
              'PlatformViewController – the bridge to the engine; '
              'usually AndroidViewController or UiKitViewController.',
              color: _kFooterPrimary,
            ),
            _bullet(
              'AndroidView / UiKitView – the convenience widgets that '
              'most apps consume directly.',
              color: _kFooterPrimary,
            ),
            _bullet(
              'PlatformViewHitTestBehavior – the enum used by '
              'hitTestBehavior.',
              color: _kFooterPrimary,
            ),
            _bullet(
              'OneSequenceGestureRecognizer – the gesture-arena '
              'participant whose factories you supply.',
              color: _kFooterPrimary,
            ),
            _bullet(
              'PlatformViewLayer – the compositing layer added during '
              'paint; the actual handoff to the engine.',
              color: _kFooterPrimary,
            ),
            _bullet(
              'Hybrid Composition vs Texture Layer – '
              'flutter.dev/docs/development/platform-integration/platform-views.',
              color: _kFooterPrimary,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kFooterPrimary.withAlpha(15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'PlatformViewRenderBox is the lowest stable rendering '
                'API you should ever touch when embedding native views. '
                'Prefer the higher-level AndroidView / UiKitView in '
                'almost all cases — only drop down when writing a '
                'custom plugin that needs its own '
                'PlatformViewController.',
                style: TextStyle(fontSize: 13.5, height: 1.5),
              ),
            ),
          ],
        );
      },
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// HARNESS ENTRY POINT
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== PlatformViewRenderBox Deep Demo ===');
  print('Subject: PlatformViewRenderBox (rendering library)');
  print('Constructor params: controller, hitTestBehavior, gestureRecognizers');
  print('Sections: 12 (hero, architecture, ctor, hit-test, gestures, '
      'platform-guard, lifecycle, compositing, pitfalls, decisions, '
      'reference, footer)');
  print('Painters: 5 (hero, architecture, lifecycle, hitstack, compositing)');

  return MaterialApp(
    title: 'PlatformViewRenderBox Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: _kHeroPrimary,
      scaffoldBackgroundColor: _kSurface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kHeroPrimary,
        primary: _kHeroPrimary,
      ),
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        backgroundColor: _kHeroPrimary,
        foregroundColor: Colors.white,
        title: const Text(
          'PlatformViewRenderBox',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _section1HeroIntro(),
              const SizedBox(height: 20),
              _sectionTitle('Architecture map', Icons.account_tree,
                  _kArchPrimary),
              _section2Architecture(),
              const SizedBox(height: 20),
              _sectionTitle('Constructor', Icons.construction, _kCtorPrimary),
              _section3Constructor(),
              const SizedBox(height: 20),
              _sectionTitle('Hit-test behavior', Icons.touch_app,
                  _kHitPrimary),
              _section4HitTest(),
              const SizedBox(height: 20),
              _sectionTitle('Gestures', Icons.gesture, _kGesturePrimary),
              _section5Gestures(),
              const SizedBox(height: 20),
              _sectionTitle('Platform guard', Icons.devices, _kPlatformPrimary),
              _section6PlatformGuarded(),
              const SizedBox(height: 20),
              _sectionTitle('Lifecycle', Icons.replay, _kLifecyclePrimary),
              _section7Lifecycle(),
              const SizedBox(height: 20),
              _sectionTitle('Compositing', Icons.layers, _kCompositingPrimary),
              _section8Compositing(),
              const SizedBox(height: 20),
              _sectionTitle('Pitfalls', Icons.bug_report, _kPitfallPrimary),
              _section9Pitfalls(),
              const SizedBox(height: 20),
              _sectionTitle('Decision', Icons.compare_arrows,
                  _kDecisionPrimary),
              _section10Decision(),
              const SizedBox(height: 20),
              _sectionTitle('Reference', Icons.menu_book, _kReferencePrimary),
              _section11ReferenceTable(),
              const SizedBox(height: 20),
              _sectionTitle('References & links', Icons.link, _kFooterPrimary),
              _section12Footer(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}
