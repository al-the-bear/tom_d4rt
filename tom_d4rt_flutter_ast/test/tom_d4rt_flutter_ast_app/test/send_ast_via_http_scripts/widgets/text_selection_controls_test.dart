// D4rt test script: Deep Demo — TextSelectionControls
// Demonstrates TextSelectionControls — the abstract base class that
// defines the visual contract for text selection handles and
// the selection toolbar (cut/copy/paste/select-all).  Concrete
// subclasses include MaterialTextSelectionControls (teardrop handles,
// Material toolbar), CupertinoTextSelectionControls (pill handles,
// loupe, iOS-style toolbar) and DesktopTextSelectionControls (no
// handles, right-click context menu).  The abstract extension
// points are buildHandle, getHandleAnchor, getHandleSize and the
// deprecated buildToolbar; the modern pattern for the toolbar is
// EditableText.contextMenuBuilder which supersedes buildToolbar.
//
// Theme: Selection Toolbar Foundry — steel blue-grey + warm ivory
// + copper + iron-black.  Cast pieces, tool racks, hot-metal glow.
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ============================================================
// SECTION 0: Foundry palette
// ============================================================
// Named colour constants anchor the foundry aesthetic throughout
// the demo.  Every accent, divider, border and painted shape pulls
// from this palette so that the visuals remain coherent from the
// hero forge all the way down to the migration note card.
const Color _tscSteel = Color(0xFF4A5D73);
const Color _tscIvory = Color(0xFFF2EEE3);
const Color _tscCopper = Color(0xFFAD6446);
const Color _tscIron = Color(0xFF1F1B16);
const Color _tscSteelDark = Color(0xFF2F3D4E);
const Color _tscSteelLight = Color(0xFF6F8396);
const Color _tscCopperGlow = Color(0xFFE28A56);
const Color _tscIvoryDark = Color(0xFFD9D1BF);
const Color _tscIvoryDeep = Color(0xFFBFB6A2);
const Color _tscSpark = Color(0xFFFFD9A8);

// ============================================================
// SECTION 1: Hero forge — animated CustomPainter
// ============================================================
// The hero header paints a stylised foundry scene: an anvil on a
// plinth, a glowing cast piece, and a shower of copper sparks.
// The sparks are driven by an AnimationController that ticks in
// the parent StatefulWidget below.  The painter is deliberately
// hand-authored — no image assets — so the demo runs cleanly
// through the d4rt AST harness without external resources.

class _TscSpark {
  _TscSpark({
    required this.seed,
    required this.originX,
    required this.originY,
    required this.angle,
    required this.speed,
    required this.life,
    required this.hue,
  });

  final int seed;
  final double originX;
  final double originY;
  final double angle;
  final double speed;
  final double life;
  final double hue;
}

class _TscForgePainter extends CustomPainter {
  _TscForgePainter({required this.t, required this.sparks});

  final double t;
  final List<_TscSpark> sparks;

  @override
  void paint(Canvas canvas, Size size) {
    // Background — a deep steel gradient that fades to iron-black
    // at the bottom so the hot-metal glow reads as emissive.
    final Rect full = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _tscSteel,
          _tscSteelDark,
          _tscIron,
        ],
        stops: const <double>[0.0, 0.6, 1.0],
      ).createShader(full);
    canvas.drawRect(full, bg);

    // Faint brick pattern on the back wall, drawn as thin ivory
    // lines with low alpha so it suggests a foundry interior
    // without competing with the foreground shapes.
    final Paint brick = Paint()
      ..color = _tscIvory.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    const double brickH = 14.0;
    for (double y = 0; y < size.height * 0.7; y += brickH) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), brick);
    }
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height * 0.7), brick);
    }

    // Plinth — a trapezoid of dark iron that the anvil rests on.
    final double plinthTopY = size.height * 0.74;
    final double plinthBotY = size.height * 0.94;
    final double plinthTopHalf = size.width * 0.18;
    final double plinthBotHalf = size.width * 0.24;
    final double cx = size.width / 2;
    final Path plinth = Path()
      ..moveTo(cx - plinthTopHalf, plinthTopY)
      ..lineTo(cx + plinthTopHalf, plinthTopY)
      ..lineTo(cx + plinthBotHalf, plinthBotY)
      ..lineTo(cx - plinthBotHalf, plinthBotY)
      ..close();
    final Paint plinthPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_tscIron, Color(0xFF0E0C09)],
      ).createShader(Rect.fromLTRB(
          cx - plinthBotHalf, plinthTopY, cx + plinthBotHalf, plinthBotY));
    canvas.drawPath(plinth, plinthPaint);

    // Anvil — a classic silhouette rendered with a darker steel
    // highlight on top and a hot-metal rim where the cast piece
    // sits.  Colours are tuned so the glow in the rim reads as
    // residual heat transferred from the workpiece.
    final double anvilBaseY = plinthTopY;
    final double anvilHornY = anvilBaseY - 38;
    final double anvilMidY = anvilBaseY - 18;
    final Path anvil = Path()
      ..moveTo(cx - 70, anvilBaseY)
      ..lineTo(cx + 80, anvilBaseY)
      ..lineTo(cx + 70, anvilMidY + 4)
      ..lineTo(cx + 90, anvilMidY)
      ..lineTo(cx + 90, anvilHornY + 4)
      ..lineTo(cx + 50, anvilHornY)
      ..lineTo(cx - 60, anvilHornY)
      ..lineTo(cx - 70, anvilMidY)
      ..close();
    final Paint anvilPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_tscSteelLight, _tscSteelDark],
      ).createShader(Rect.fromLTRB(cx - 90, anvilHornY, cx + 90, anvilBaseY));
    canvas.drawPath(anvil, anvilPaint);

    // Cast piece — a glowing copper ingot on the anvil flat.
    final Rect ingotRect =
        Rect.fromLTWH(cx - 34, anvilHornY - 10, 68, 14);
    final RRect ingot = RRect.fromRectAndRadius(
        ingotRect, const Radius.circular(4));
    final double glowPulse =
        0.55 + 0.25 * math.sin(t * math.pi * 2 * 1.3);
    final Paint glow = Paint()
      ..color = _tscCopperGlow.withValues(alpha: 0.45 * glowPulse)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18.0);
    canvas.drawRRect(ingot.inflate(6), glow);
    final Paint ingotPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_tscCopperGlow, _tscCopper],
      ).createShader(ingotRect);
    canvas.drawRRect(ingot, ingotPaint);

    // Hammer leaning against the anvil — a simple rectangle head
    // plus a wooden handle.  Small detail, but it sells the scene.
    final Path hammerHandle = Path()
      ..moveTo(cx + 96, anvilMidY)
      ..lineTo(cx + 140, anvilBaseY + 6);
    final Paint handlePaint = Paint()
      ..color = const Color(0xFF7A4B25)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(hammerHandle, handlePaint);
    final Rect hammerHeadRect =
        Rect.fromLTWH(cx + 86, anvilMidY - 10, 22, 20);
    final Paint hammerHeadPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_tscSteelLight, _tscSteelDark],
      ).createShader(hammerHeadRect);
    canvas.drawRRect(
        RRect.fromRectAndRadius(hammerHeadRect, const Radius.circular(3)),
        hammerHeadPaint);

    // Sparks — each spark has a per-sparkle phase so that the
    // shower shimmers rather than marching in lockstep.
    for (final _TscSpark s in sparks) {
      final double phase = (t + s.seed * 0.137) % 1.0;
      final double p = phase;
      final double x = s.originX + math.cos(s.angle) * s.speed * p;
      final double y =
          s.originY + math.sin(s.angle) * s.speed * p + 160 * p * p;
      if (y > size.height) {
        continue;
      }
      final double fade = 1.0 - p;
      final Color c = Color.lerp(_tscSpark, _tscCopper, 1.0 - fade)!;
      final Paint sparkPaint = Paint()
        ..color = c.withValues(alpha: fade * 0.9)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);
      canvas.drawCircle(Offset(x, y), 1.8 + 1.4 * fade, sparkPaint);
    }

    // Title text baked into the hero — the demo name is rendered
    // as a path-painted label so no TextPainter imports are pulled
    // in.  The actual text label on the scaffold is a Text widget.
    final Paint plateRim = Paint()
      ..color = _tscIvory.withValues(alpha: 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final Rect plate =
        Rect.fromLTWH(16, 16, size.width - 32, 34);
    canvas.drawRRect(
        RRect.fromRectAndRadius(plate, const Radius.circular(6)), plateRim);
  }

  @override
  bool shouldRepaint(covariant _TscForgePainter oldDelegate) =>
      oldDelegate.t != t || oldDelegate.sparks.length != sparks.length;
}

// ============================================================
// SECTION 2: Cast-pieces painter — side-by-side handle shapes
// ============================================================
// The "cast pieces" panel renders a Material teardrop, a Cupertino
// pill and the custom foundry hammer handle at the same scale so
// viewers can see how anchor offsets differ.  Anchors are annotated
// as small crosshairs with coordinates.

class _TscCastPiecesPainter extends CustomPainter {
  _TscCastPiecesPainter({required this.accent});

  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _tscIvory;
    canvas.drawRect(Offset.zero & size, bg);

    // Three equal-width columns with a subtle vertical rule.
    final double colW = size.width / 3;
    final Paint rule = Paint()
      ..color = _tscIvoryDeep
      ..strokeWidth = 1;
    canvas.drawLine(Offset(colW, 10), Offset(colW, size.height - 10), rule);
    canvas.drawLine(
        Offset(colW * 2, 10), Offset(colW * 2, size.height - 10), rule);

    _drawMaterialTeardrop(canvas, Offset(colW * 0.5, size.height * 0.5));
    _drawCupertinoPill(canvas, Offset(colW * 1.5, size.height * 0.5));
    _drawFoundryHammer(canvas, Offset(colW * 2.5, size.height * 0.5));

    _drawAnchorCross(canvas, Offset(colW * 0.5, size.height * 0.5 + 30));
    _drawAnchorCross(canvas, Offset(colW * 1.5, size.height * 0.5 + 28));
    _drawAnchorCross(canvas, Offset(colW * 2.5, size.height * 0.5 + 30));
  }

  void _drawMaterialTeardrop(Canvas canvas, Offset c) {
    final Path p = Path();
    p.moveTo(c.dx, c.dy - 24);
    p.cubicTo(c.dx - 22, c.dy - 24, c.dx - 22, c.dy + 18, c.dx, c.dy + 30);
    p.cubicTo(c.dx + 22, c.dy + 18, c.dx + 22, c.dy - 24, c.dx, c.dy - 24);
    p.close();
    final Paint fill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[accent, _tscCopper],
      ).createShader(Rect.fromCircle(center: c, radius: 28));
    canvas.drawPath(p, fill);
    final Paint rim = Paint()
      ..color = _tscIron.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawPath(p, rim);
  }

  void _drawCupertinoPill(Canvas canvas, Offset c) {
    final Rect rect = Rect.fromCenter(center: c, width: 8, height: 48);
    final RRect pill =
        RRect.fromRectAndRadius(rect, const Radius.circular(4));
    final Paint fill = Paint()
      ..color = _tscSteel;
    canvas.drawRRect(pill, fill);
    final Paint knob = Paint()..color = _tscSteelDark;
    canvas.drawCircle(Offset(c.dx, c.dy - 28), 6, knob);
    final Paint knobRim = Paint()
      ..color = _tscIron.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(Offset(c.dx, c.dy - 28), 6, knobRim);
  }

  void _drawFoundryHammer(Canvas canvas, Offset c) {
    // Handle — a diagonal stroke to suggest the shaft.
    final Paint handle = Paint()
      ..color = const Color(0xFF7A4B25)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
        Offset(c.dx - 18, c.dy + 24), Offset(c.dx + 14, c.dy - 22), handle);
    // Hammer head block.
    final Rect head =
        Rect.fromCenter(center: Offset(c.dx + 14, c.dy - 22), width: 28, height: 14);
    final Paint headPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_tscCopperGlow, _tscCopper],
      ).createShader(head);
    canvas.drawRRect(
        RRect.fromRectAndRadius(head, const Radius.circular(2)), headPaint);
    final Paint rim = Paint()
      ..color = _tscIron
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRRect(
        RRect.fromRectAndRadius(head, const Radius.circular(2)), rim);
  }

  void _drawAnchorCross(Canvas canvas, Offset c) {
    final Paint p = Paint()
      ..color = _tscSteelDark
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(c.dx - 6, c.dy), Offset(c.dx + 6, c.dy), p);
    canvas.drawLine(Offset(c.dx, c.dy - 6), Offset(c.dx, c.dy + 6), p);
    final Paint dot = Paint()..color = _tscCopper;
    canvas.drawCircle(c, 2.0, dot);
  }

  @override
  bool shouldRepaint(covariant _TscCastPiecesPainter oldDelegate) =>
      oldDelegate.accent != accent;
}

// ============================================================
// SECTION 3: Custom _FoundryTextSelectionControls
// ============================================================
// The demo's central technical artefact: a hand-authored subclass
// of TextSelectionControls that overrides exactly the three
// abstract visual methods (buildHandle, getHandleAnchor,
// getHandleSize) and produces a copper-hammer handle motif.  The
// deprecated buildToolbar is implemented as a thin Material
// toolbar clone so the class is fully concrete and compiles
// cleanly in Flutter 3.41.6 where buildToolbar is still abstract.

class _TscFoundryTextSelectionControls extends TextSelectionControls {
  _TscFoundryTextSelectionControls();

  static const double _handleWidth = 28.0;
  static const double _handleHeight = 36.0;

  @override
  Size getHandleSize(double textLineHeight) {
    // The framework uses this size to hit-test the handle and to
    // lay it out relative to the text line.  The foundry hammer
    // motif is a fixed-size widget — textLineHeight does not
    // influence the geometry, though we clamp to a minimum so
    // very small text still gets a touchable target.
    final double h = math.max(_handleHeight, textLineHeight + 14);
    return Size(_handleWidth, h);
  }

  @override
  Offset getHandleAnchor(
      TextSelectionHandleType type, double textLineHeight) {
    // Anchor offset: the point within the handle widget that the
    // framework aligns with the text selection endpoint.  For a
    // left handle we anchor top-right; for a right handle we
    // anchor top-left; for a collapsed cursor we anchor the top
    // centre.  This mirrors Material's convention so the handle
    // "points to" the caret position.
    switch (type) {
      case TextSelectionHandleType.left:
        return const Offset(_handleWidth, 0);
      case TextSelectionHandleType.right:
        return Offset.zero;
      case TextSelectionHandleType.collapsed:
        return const Offset(_handleWidth / 2, 0);
    }
  }

  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
  ]) {
    // The handle widget is a GestureDetector wrapping a
    // CustomPaint with the foundry hammer motif.  onTap is wired
    // up so platforms that route handle taps (Android) still get
    // the chance to show the toolbar.
    final Size size = getHandleSize(textLineHeight);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: CustomPaint(
          painter: _TscFoundryHandlePainter(type: type),
        ),
      ),
    );
  }

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ValueListenable<ClipboardStatus>? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    // buildToolbar is deprecated in favour of
    // EditableText.contextMenuBuilder, but remains abstract on the
    // base class in Flutter 3.41.6 so we must implement it to make
    // the subclass concrete.  The implementation here is
    // intentionally minimal — a small foundry-themed Material pill
    // positioned above the selection midpoint.
    final Offset anchor = Offset(
      selectionMidpoint.dx,
      math.max(0, selectionMidpoint.dy - textLineHeight - 36),
    );
    return Stack(
      children: <Widget>[
        Positioned(
          left: anchor.dx - 80,
          top: anchor.dy,
          child: Material(
            color: _tscIron,
            elevation: 2,
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text('Cut',
                      style: TextStyle(
                          color: _tscIvory, fontSize: 12)),
                  SizedBox(width: 12),
                  Text('Copy',
                      style: TextStyle(
                          color: _tscIvory, fontSize: 12)),
                  SizedBox(width: 12),
                  Text('Paste',
                      style: TextStyle(
                          color: _tscIvory, fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TscFoundryHandlePainter extends CustomPainter {
  _TscFoundryHandlePainter({required this.type});

  final TextSelectionHandleType type;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    // Shaft — diagonal wood handle.
    final Paint shaft = Paint()
      ..color = const Color(0xFF7A4B25)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final Offset shaftStart;
    final Offset shaftEnd;
    switch (type) {
      case TextSelectionHandleType.left:
        shaftStart = Offset(size.width - 2, 2);
        shaftEnd = Offset(2, size.height - 4);
        break;
      case TextSelectionHandleType.right:
        shaftStart = Offset(2, 2);
        shaftEnd = Offset(size.width - 2, size.height - 4);
        break;
      case TextSelectionHandleType.collapsed:
        shaftStart = Offset(cx, 2);
        shaftEnd = Offset(cx, size.height - 4);
        break;
    }
    canvas.drawLine(shaftStart, shaftEnd, shaft);

    // Hammer head — a small copper block at the top.
    final Rect head = Rect.fromCenter(
      center: shaftStart + const Offset(0, 2),
      width: 16,
      height: 10,
    );
    final Paint headPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_tscCopperGlow, _tscCopper],
      ).createShader(head);
    canvas.drawRRect(
        RRect.fromRectAndRadius(head, const Radius.circular(2)), headPaint);
    final Paint rim = Paint()
      ..color = _tscIron
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawRRect(
        RRect.fromRectAndRadius(head, const Radius.circular(2)), rim);
  }

  @override
  bool shouldRepaint(covariant _TscFoundryHandlePainter oldDelegate) =>
      oldDelegate.type != type;
}

// ============================================================
// SECTION 4: Stateful host with AnimationController
// ============================================================
// The top-level widget owns the animation controller that drives
// the sparks.  It also owns the controllers for the interactive
// TextField showcase (Section 9) so the "Select All" button can
// mutate the selection from outside the field.

class _TscDemoRoot extends StatefulWidget {
  const _TscDemoRoot();

  @override
  State<_TscDemoRoot> createState() => _TscDemoRootState();
}

class _TscDemoRootState extends State<_TscDemoRoot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sparkController;
  late final List<_TscSpark> _sparks;
  late final TextEditingController _showcaseController;
  late final TextEditingController _contextMenuController;
  late final TextEditingController _materialController;
  late final TextEditingController _cupertinoController;
  late final TextEditingController _foundryController;
  late final FocusNode _showcaseFocus;
  late final FocusNode _contextMenuFocus;
  late final _TscFoundryTextSelectionControls _foundryControls;

  @override
  void initState() {
    super.initState();
    _sparkController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Pre-compute spark trajectories so the painter is a pure
    // function of the animation phase.  Each spark is seeded from
    // a Random with a fixed seed so the demo is deterministic.
    final math.Random rnd = math.Random(7);
    _sparks = <_TscSpark>[];
    for (int i = 0; i < 28; i++) {
      _sparks.add(_TscSpark(
        seed: i,
        originX: 180 + rnd.nextDouble() * 40,
        originY: 160,
        angle: -math.pi / 2 + (rnd.nextDouble() - 0.5) * 1.2,
        speed: 80 + rnd.nextDouble() * 120,
        life: 0.6 + rnd.nextDouble() * 0.6,
        hue: rnd.nextDouble(),
      ));
    }

    _showcaseController = TextEditingController(
      text: 'Select All to reveal the foundry handles and toolbar.',
    );
    _contextMenuController = TextEditingController(
      text: 'The modern contextMenuBuilder lives on EditableText.',
    );
    _materialController = TextEditingController(
      text: 'Material teardrop handles — the canned Android look.',
    );
    _cupertinoController = TextEditingController(
      text: 'Cupertino pill handles — iOS-style loupe and chrome.',
    );
    _foundryController = TextEditingController(
      text: 'Foundry hammer handles — custom subclass in this file.',
    );
    _showcaseFocus = FocusNode(debugLabel: 'tsc-showcase');
    _contextMenuFocus = FocusNode(debugLabel: 'tsc-context-menu');
    _foundryControls = _TscFoundryTextSelectionControls();
  }

  @override
  void dispose() {
    _sparkController.dispose();
    _showcaseController.dispose();
    _contextMenuController.dispose();
    _materialController.dispose();
    _cupertinoController.dispose();
    _foundryController.dispose();
    _showcaseFocus.dispose();
    _contextMenuFocus.dispose();
    super.dispose();
  }

  void _selectAllShowcase() {
    _showcaseFocus.requestFocus();
    _showcaseController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _showcaseController.text.length,
    );
    debugPrint('TextSelectionControls demo: Select All triggered '
        'on showcase field, length=${_showcaseController.text.length}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _tscIvory,
      appBar: AppBar(
        backgroundColor: _tscIron,
        foregroundColor: _tscIvory,
        title: const Text('TextSelectionControls — Foundry'),
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _TscHeroForge(
            controller: _sparkController,
            sparks: _sparks,
          ),
          const SizedBox(height: 18),
          const _TscSectionTitle(
            index: 1,
            label: 'Concept — selection handle contract',
          ),
          const _TscConceptCards(),
          const SizedBox(height: 18),
          const _TscSectionTitle(
            index: 2,
            label: 'Three specimens — Material, Cupertino, Foundry',
          ),
          _TscThreeSpecimens(
            materialController: _materialController,
            cupertinoController: _cupertinoController,
            foundryController: _foundryController,
            foundryControls: _foundryControls,
          ),
          const SizedBox(height: 18),
          const _TscSectionTitle(
            index: 3,
            label: 'Cast pieces — handle shapes side by side',
          ),
          const _TscCastPiecesPanel(),
          const SizedBox(height: 18),
          const _TscSectionTitle(
            index: 4,
            label: 'Method directory — overridable API',
          ),
          const _TscMethodDirectory(),
          const SizedBox(height: 18),
          _TscSectionTitle(
            index: 5,
            label: 'Interactive showcase — Select All',
            trailing: IconButton(
              icon: const Icon(Icons.touch_app, color: _tscCopper),
              onPressed: _selectAllShowcase,
              tooltip: 'Select All',
            ),
          ),
          _TscShowcasePanel(
            controller: _showcaseController,
            focusNode: _showcaseFocus,
            foundryControls: _foundryControls,
            onSelectAll: _selectAllShowcase,
          ),
          const SizedBox(height: 18),
          const _TscSectionTitle(
            index: 6,
            label: 'Migration — buildToolbar → contextMenuBuilder',
          ),
          _TscMigrationCard(
            controller: _contextMenuController,
            focusNode: _contextMenuFocus,
          ),
          const SizedBox(height: 18),
          const _TscSectionTitle(
            index: 7,
            label: 'Pitfall — do not instantiate the abstract class',
          ),
          const _TscPitfallCard(),
          const SizedBox(height: 18),
          const _TscSectionTitle(
            index: 8,
            label: 'Lifecycle — when controls are consulted',
          ),
          const _TscLifecycleTimeline(),
          const SizedBox(height: 18),
          const _TscSectionTitle(
            index: 9,
            label: 'Checklist — authoring a custom subclass',
          ),
          const _TscChecklistPanel(),
          const SizedBox(height: 18),
          const _TscSectionTitle(
            index: 10,
            label: 'Comparison — canned subclasses at a glance',
          ),
          const _TscComparisonTable(),
          const SizedBox(height: 18),
          const _TscSectionTitle(
            index: 11,
            label: 'Anchor mathematics — left / right / collapsed',
          ),
          const _TscAnchorMathPanel(),
          const SizedBox(height: 18),
          const _TscSectionTitle(
            index: 12,
            label: 'Footer — foundry marks',
          ),
          const _TscFooter(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 5: Hero forge widget
// ============================================================
class _TscHeroForge extends StatelessWidget {
  const _TscHeroForge({required this.controller, required this.sparks});

  final AnimationController controller;
  final List<_TscSpark> sparks;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 240,
        child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              painter: _TscForgePainter(
                t: controller.value,
                sparks: sparks,
              ),
              child: const _TscHeroOverlay(),
            );
          },
        ),
      ),
    );
  }
}

class _TscHeroOverlay extends StatelessWidget {
  const _TscHeroOverlay();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _tscIron.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: _tscCopper.withValues(alpha: 0.6), width: 1),
            ),
            child: const Text(
              'SELECTION TOOLBAR FOUNDRY',
              style: TextStyle(
                color: _tscIvory,
                fontSize: 12,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'TextSelectionControls',
            style: TextStyle(
              color: _tscIvory,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Cast the handles. Stoke the toolbar. Pick your subclass.',
            style: TextStyle(
              color: _tscIvoryDark.withValues(alpha: 0.9),
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Spacer(),
          Row(
            children: <Widget>[
              _TscHeroChip(label: 'buildHandle', color: _tscCopper),
              const SizedBox(width: 8),
              _TscHeroChip(label: 'getHandleAnchor', color: _tscCopperGlow),
              const SizedBox(width: 8),
              _TscHeroChip(label: 'getHandleSize', color: _tscCopper),
              const SizedBox(width: 8),
              _TscHeroChip(
                  label: 'buildToolbar (deprecated)',
                  color: _tscIvoryDark),
            ],
          ),
        ],
      ),
    );
  }
}

class _TscHeroChip extends StatelessWidget {
  const _TscHeroChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _tscIron.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.7), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ============================================================
// SECTION 6: Section title + concept cards
// ============================================================
class _TscSectionTitle extends StatelessWidget {
  const _TscSectionTitle({
    required this.index,
    required this.label,
    this.trailing,
  });

  final int index;
  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _tscSteel,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _tscCopper, width: 1.2),
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: _tscIvory,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _tscIron,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class _TscConceptCards extends StatelessWidget {
  const _TscConceptCards();

  @override
  Widget build(BuildContext context) {
    final List<_TscConceptEntry> entries = <_TscConceptEntry>[
      _TscConceptEntry(
        icon: Icons.architecture,
        title: 'Abstract foundation',
        body:
            'TextSelectionControls is an abstract class. You never '
            'instantiate it directly — you either pick a canned '
            'subclass (Material, Cupertino, Desktop) or author '
            'your own subclass and override the visual hooks.',
        accent: _tscSteel,
      ),
      _TscConceptEntry(
        icon: Icons.build,
        title: 'Three visual hooks',
        body:
            'buildHandle, getHandleAnchor and getHandleSize '
            'together describe the drag-handle widget at each end '
            'of a selection. The framework calls them whenever a '
            'selection is painted or the user drags a handle.',
        accent: _tscCopper,
      ),
      _TscConceptEntry(
        icon: Icons.layers,
        title: 'Toolbar in transition',
        body:
            'buildToolbar is the classic hook for the '
            'cut/copy/paste/select-all bar, but it is deprecated '
            'in favour of EditableText.contextMenuBuilder. New '
            'code should prefer the contextMenuBuilder pattern.',
        accent: _tscSteelDark,
      ),
      _TscConceptEntry(
        icon: Icons.rule,
        title: 'Capability gates',
        body:
            'canCut / canCopy / canPaste / canSelectAll let a '
            'subclass hide toolbar actions without a full '
            'contextMenuBuilder rewrite — useful for read-only '
            'fields or kiosk modes.',
        accent: _tscCopperGlow,
      ),
    ];
    return Column(
      children: entries
          .map((_TscConceptEntry e) => _TscConceptCard(entry: e))
          .toList(),
    );
  }
}

class _TscConceptEntry {
  _TscConceptEntry({
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

class _TscConceptCard extends StatelessWidget {
  const _TscConceptCard({required this.entry});

  final _TscConceptEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: entry.accent.withValues(alpha: 0.4), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _tscIron.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: entry.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(entry.icon, color: entry.accent, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.title,
                  style: TextStyle(
                    color: entry.accent,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.body,
                  style: const TextStyle(
                    color: _tscIron,
                    fontSize: 12.5,
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

// ============================================================
// SECTION 7: Three specimens — TextFields with different controls
// ============================================================
// The core "show don't tell" part of the demo.  Each TextField
// receives a different selectionControls value, exercising all
// three code paths: canned Material, canned Cupertino and the
// custom Foundry subclass.  The TextFields share styling so only
// the handle/toolbar differs at runtime.

class _TscThreeSpecimens extends StatelessWidget {
  const _TscThreeSpecimens({
    required this.materialController,
    required this.cupertinoController,
    required this.foundryController,
    required this.foundryControls,
  });

  final TextEditingController materialController;
  final TextEditingController cupertinoController;
  final TextEditingController foundryController;
  final _TscFoundryTextSelectionControls foundryControls;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool wide = constraints.maxWidth > 780;
        final List<Widget> columns = <Widget>[
          _TscSpecimenColumn(
            label: 'MaterialTextSelectionControls',
            subtitle: 'Teardrop handles — Android default',
            accent: _tscSteel,
            controller: materialController,
            selectionControls: materialTextSelectionControls,
          ),
          _TscSpecimenColumn(
            label: 'CupertinoTextSelectionControls',
            subtitle: 'Pill handles — iOS default',
            accent: _tscSteelDark,
            controller: cupertinoController,
            selectionControls: cupertinoTextSelectionControls,
          ),
          _TscSpecimenColumn(
            label: '_FoundryTextSelectionControls',
            subtitle: 'Copper hammer — custom subclass',
            accent: _tscCopper,
            controller: foundryController,
            selectionControls: foundryControls,
          ),
        ];
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columns
                .map((Widget w) => Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: w)))
                .toList(),
          );
        }
        return Column(
          children: columns
              .map((Widget w) => Padding(
                  padding: const EdgeInsets.only(bottom: 10), child: w))
              .toList(),
        );
      },
    );
  }
}

class _TscSpecimenColumn extends StatelessWidget {
  const _TscSpecimenColumn({
    required this.label,
    required this.subtitle,
    required this.accent,
    required this.controller,
    required this.selectionControls,
  });

  final String label;
  final String subtitle;
  final Color accent;
  final TextEditingController controller;
  final TextSelectionControls selectionControls;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: accent,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: _tscIron, fontSize: 11),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            selectionControls: selectionControls,
            maxLines: 3,
            minLines: 3,
            style: const TextStyle(color: _tscIron, fontSize: 13),
            decoration: InputDecoration(
              filled: true,
              fillColor: _tscIvory,
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: accent),
                borderRadius: BorderRadius.circular(6),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: accent.withValues(alpha: 0.6)),
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _tscCopper, width: 1.5),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          const SizedBox(height: 6),
          _TscKeyValueRow(
            k: 'selectionControls',
            v: label,
            accent: accent,
          ),
        ],
      ),
    );
  }
}

class _TscKeyValueRow extends StatelessWidget {
  const _TscKeyValueRow({
    required this.k,
    required this.v,
    required this.accent,
  });

  final String k;
  final String v;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          Text(
            '$k: ',
            style: TextStyle(
              color: accent,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: const TextStyle(
                color: _tscIron,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 8: Cast pieces panel
// ============================================================
class _TscCastPiecesPanel extends StatelessWidget {
  const _TscCastPiecesPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _tscSteel.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Handle silhouettes — the same scale, different shapes.',
            style: TextStyle(
              color: _tscIron,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 160,
            child: CustomPaint(
              painter: _TscCastPiecesPainter(accent: _tscSteel),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: const <Widget>[
              Expanded(
                child: _TscCastLabel(
                  title: 'Material teardrop',
                  anchor: 'anchor = (w/2, 0)',
                  color: _tscSteel,
                ),
              ),
              Expanded(
                child: _TscCastLabel(
                  title: 'Cupertino pill',
                  anchor: 'anchor = (w/2, h/2)',
                  color: _tscSteelDark,
                ),
              ),
              Expanded(
                child: _TscCastLabel(
                  title: 'Foundry hammer',
                  anchor: 'anchor = (w, 0) / (0, 0)',
                  color: _tscCopper,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TscCastLabel extends StatelessWidget {
  const _TscCastLabel({
    required this.title,
    required this.anchor,
    required this.color,
  });

  final String title;
  final String anchor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          anchor,
          style: const TextStyle(
            color: _tscIron,
            fontSize: 10.5,
            fontFamily: 'monospace',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ============================================================
// SECTION 9: Method directory — DataTable
// ============================================================
class _TscMethodDirectory extends StatelessWidget {
  const _TscMethodDirectory();

  @override
  Widget build(BuildContext context) {
    final List<_TscMethodEntry> rows = <_TscMethodEntry>[
      _TscMethodEntry(
        name: 'buildHandle',
        sig: 'Widget buildHandle(ctx, type, textLineHeight, [onTap])',
        kind: 'abstract',
        duty:
            'Builds the drag-handle widget. Called per endpoint with '
            'TextSelectionHandleType.left / right / collapsed.',
      ),
      _TscMethodEntry(
        name: 'getHandleAnchor',
        sig: 'Offset getHandleAnchor(type, textLineHeight)',
        kind: 'abstract',
        duty:
            'Returns the point within the handle widget that is '
            'anchored to the text selection endpoint.',
      ),
      _TscMethodEntry(
        name: 'getHandleSize',
        sig: 'Size getHandleSize(textLineHeight)',
        kind: 'abstract',
        duty:
            'Reports the handle widget size for layout and hit '
            'testing. Return Size.zero to disable handles.',
      ),
      _TscMethodEntry(
        name: 'buildToolbar',
        sig: 'Widget buildToolbar(ctx, region, lineHeight, mid, ...)',
        kind: 'deprecated',
        duty:
            'Legacy toolbar hook. Superseded by '
            'EditableText.contextMenuBuilder since v3.3.0-0.5.pre.',
      ),
      _TscMethodEntry(
        name: 'canCut',
        sig: 'bool canCut(TextSelectionDelegate delegate)',
        kind: 'virtual',
        duty:
            'Gate for the Cut toolbar entry. Default: true when a '
            'non-empty selection exists and the field is editable.',
      ),
      _TscMethodEntry(
        name: 'canCopy',
        sig: 'bool canCopy(TextSelectionDelegate delegate)',
        kind: 'virtual',
        duty:
            'Gate for the Copy toolbar entry. Default: true for any '
            'non-empty selection, including read-only fields.',
      ),
      _TscMethodEntry(
        name: 'canPaste',
        sig: 'bool canPaste(TextSelectionDelegate delegate)',
        kind: 'virtual',
        duty:
            'Gate for the Paste toolbar entry. Default: true when '
            'the field is editable and clipboard has text.',
      ),
      _TscMethodEntry(
        name: 'canSelectAll',
        sig: 'bool canSelectAll(TextSelectionDelegate delegate)',
        kind: 'virtual',
        duty:
            'Gate for Select All. Default: true when the selection '
            'is not already covering the entire text value.',
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _tscSteel.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor:
              WidgetStateProperty.all(_tscSteel.withValues(alpha: 0.1)),
          headingTextStyle: const TextStyle(
            color: _tscSteelDark,
            fontWeight: FontWeight.w700,
            fontSize: 12.5,
          ),
          dataTextStyle: const TextStyle(
            color: _tscIron,
            fontSize: 12,
          ),
          columnSpacing: 18,
          columns: const <DataColumn>[
            DataColumn(label: Text('Method')),
            DataColumn(label: Text('Kind')),
            DataColumn(label: Text('Signature')),
            DataColumn(label: Text('Responsibility')),
          ],
          rows: rows.map(_buildRow).toList(),
        ),
      ),
    );
  }

  DataRow _buildRow(_TscMethodEntry e) {
    Color kindColor;
    switch (e.kind) {
      case 'abstract':
        kindColor = _tscCopper;
        break;
      case 'deprecated':
        kindColor = _tscSteelLight;
        break;
      case 'virtual':
        kindColor = _tscSteel;
        break;
      default:
        kindColor = _tscIron;
    }
    return DataRow(cells: <DataCell>[
      DataCell(Text(
        e.name,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      )),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: kindColor.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          e.kind,
          style: TextStyle(
            color: kindColor,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      )),
      DataCell(SizedBox(
        width: 320,
        child: Text(
          e.sig,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
          ),
          softWrap: true,
        ),
      )),
      DataCell(SizedBox(
        width: 380,
        child: Text(e.duty, softWrap: true),
      )),
    ]);
  }
}

class _TscMethodEntry {
  _TscMethodEntry({
    required this.name,
    required this.sig,
    required this.kind,
    required this.duty,
  });

  final String name;
  final String sig;
  final String kind;
  final String duty;
}

// ============================================================
// SECTION 10: Interactive showcase panel
// ============================================================
class _TscShowcasePanel extends StatelessWidget {
  const _TscShowcasePanel({
    required this.controller,
    required this.focusNode,
    required this.foundryControls,
    required this.onSelectAll,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final _TscFoundryTextSelectionControls foundryControls;
  final VoidCallback onSelectAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: _tscCopper.withValues(alpha: 0.6), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.pan_tool, color: _tscCopper, size: 18),
              const SizedBox(width: 6),
              const Expanded(
                child: Text(
                  'Showcase — foundry handles and toolbar',
                  style: TextStyle(
                    color: _tscCopper,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: onSelectAll,
                icon: const Icon(Icons.select_all, size: 16),
                label: const Text('Select All'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _tscSteel,
                  foregroundColor: _tscIvory,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            focusNode: focusNode,
            selectionControls: foundryControls,
            maxLines: 3,
            style: const TextStyle(
              color: _tscIron,
              fontSize: 14,
              height: 1.3,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: _tscIvory,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: _tscSteel.withValues(alpha: 0.6)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: _tscCopper, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap Select All, then drag a handle — the custom '
            'buildHandle output is rendered by the copper-hammer '
            'painter defined in this file.',
            style: TextStyle(
              color: _tscIron.withValues(alpha: 0.75),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 11: Migration card — contextMenuBuilder
// ============================================================
class _TscMigrationCard extends StatelessWidget {
  const _TscMigrationCard({
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _tscIvoryDark.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: _tscSteelDark.withValues(alpha: 0.4), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.update, color: _tscSteelDark, size: 18),
              SizedBox(width: 6),
              Text(
                'Migration note — buildToolbar is deprecated',
                style: TextStyle(
                  color: _tscSteelDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Since Flutter 3.3.0-0.5.pre the buildToolbar hook on '
            'TextSelectionControls is marked @Deprecated. The '
            'modern pattern is contextMenuBuilder on EditableText '
            '(and on TextField / SelectableText, which forward the '
            'callback). contextMenuBuilder receives the '
            'EditableTextState and can return any Widget — not '
            'just a fixed toolbar — which is why it is the '
            'recommended migration target.',
            style: TextStyle(color: _tscIron, fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _tscIron,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'TextField(\n'
              '  contextMenuBuilder: (ctx, state) {\n'
              '    return AdaptiveTextSelectionToolbar.editableText(\n'
              '      editableTextState: state,\n'
              '    );\n'
              '  },\n'
              ')',
              style: TextStyle(
                color: _tscSpark,
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            focusNode: focusNode,
            maxLines: 2,
            contextMenuBuilder:
                (BuildContext context, EditableTextState state) {
              // Live example of the modern pattern.  We reuse the
              // adaptive toolbar — it picks the right chrome for
              // the current platform (Material, Cupertino, etc.).
              return AdaptiveTextSelectionToolbar.editableText(
                editableTextState: state,
              );
            },
            style: const TextStyle(color: _tscIron, fontSize: 13),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                    color: _tscSteelDark.withValues(alpha: 0.6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 12: Pitfall card
// ============================================================
class _TscPitfallCard extends StatelessWidget {
  const _TscPitfallCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _tscCopper.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _tscCopper, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.warning_amber, color: _tscCopper, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Do not instantiate TextSelectionControls directly',
                  style: TextStyle(
                    color: _tscCopper,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'TextSelectionControls is abstract. Calling its '
            'constructor directly produces a compiler error, and '
            'even if you bypass the analyser, every visual hook '
            'will throw at runtime. Always pick one of:\n'
            '  • materialTextSelectionControls (global instance)\n'
            '  • cupertinoTextSelectionControls (global instance)\n'
            '  • MaterialTextSelectionControls / CupertinoText… '
            '(concrete classes, if you want a fresh instance)\n'
            '  • DesktopTextSelectionControls (desktop platforms)\n'
            '  • EmptyTextSelectionControls (suppress handles)\n'
            '  • a custom subclass overriding the abstract hooks.',
            style: TextStyle(color: _tscIron, fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _tscIron,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              '// BAD — abstract class\n'
              'final controls = TextSelectionControls();\n\n'
              '// GOOD — pick a subclass\n'
              'final controls = materialTextSelectionControls;\n',
              style: TextStyle(
                color: _tscSpark,
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 13: Lifecycle timeline
// ============================================================
class _TscLifecycleTimeline extends StatelessWidget {
  const _TscLifecycleTimeline();

  @override
  Widget build(BuildContext context) {
    final List<_TscTimelineEntry> entries = <_TscTimelineEntry>[
      _TscTimelineEntry(
        label: 'User drags or taps',
        detail:
            'A long-press, double-tap or drag gesture on a '
            'selectable region triggers the selection overlay.',
        color: _tscSteel,
      ),
      _TscTimelineEntry(
        label: 'Framework resolves controls',
        detail:
            'EditableText resolves selectionControls from the '
            'widget tree (TextField.selectionControls, theme, '
            'platform default).',
        color: _tscSteelDark,
      ),
      _TscTimelineEntry(
        label: 'Size + anchor queried',
        detail:
            'getHandleSize and getHandleAnchor are called for '
            'each endpoint so the overlay knows where to place '
            'the handle.',
        color: _tscCopper,
      ),
      _TscTimelineEntry(
        label: 'Handles painted',
        detail:
            'buildHandle runs for each endpoint. The result is '
            'placed in a Positioned inside the SelectionOverlay.',
        color: _tscCopperGlow,
      ),
      _TscTimelineEntry(
        label: 'Toolbar painted',
        detail:
            'Either buildToolbar (legacy) or contextMenuBuilder '
            '(modern) runs to paint the action bar above the '
            'selection midpoint.',
        color: _tscSteel,
      ),
      _TscTimelineEntry(
        label: 'User releases',
        detail:
            'On handle release, the new selection is committed '
            'via TextSelectionDelegate; the overlay may rebuild.',
        color: _tscSteelDark,
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _tscSteel.withValues(alpha: 0.35)),
      ),
      child: Column(
        children: entries
            .map((_TscTimelineEntry e) => _TscTimelineRow(entry: e))
            .toList(),
      ),
    );
  }
}

class _TscTimelineEntry {
  _TscTimelineEntry({
    required this.label,
    required this.detail,
    required this.color,
  });
  final String label;
  final String detail;
  final Color color;
}

class _TscTimelineRow extends StatelessWidget {
  const _TscTimelineRow({required this.entry});

  final _TscTimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: entry.color,
                  shape: BoxShape.circle,
                  border: Border.all(color: _tscIvory, width: 2),
                ),
              ),
              Container(
                width: 2,
                height: 30,
                color: entry.color.withValues(alpha: 0.3),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.label,
                  style: TextStyle(
                    color: entry.color,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.detail,
                  style: const TextStyle(
                      color: _tscIron, fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 14: Checklist — authoring a subclass
// ============================================================
class _TscChecklistPanel extends StatelessWidget {
  const _TscChecklistPanel();

  @override
  Widget build(BuildContext context) {
    final List<String> items = <String>[
      'Override buildHandle — return a widget that renders your '
          'handle shape; wire onTap if the platform routes taps.',
      'Override getHandleSize — report the handle bounds so the '
          'framework can lay out and hit-test correctly.',
      'Override getHandleAnchor — return the point within the '
          'handle widget that aligns with the text endpoint.',
      'Implement buildToolbar (in Flutter 3.41.6) — it is '
          'abstract even though deprecated; otherwise the '
          'subclass will not be concrete.',
      'Optionally override canCut / canCopy / canPaste / '
          'canSelectAll to hide specific toolbar actions.',
      'Prefer EditableText.contextMenuBuilder for the toolbar '
          'itself — keep buildToolbar minimal or delegate.',
      'Expose a top-level final instance if the controls are '
          'stateless — mirrors materialTextSelectionControls.',
      'Write a golden test that drives selection to catch '
          'regressions in the handle geometry.',
    ];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tscIvoryDark.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _tscSteelDark.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .asMap()
            .entries
            .map((MapEntry<int, String> e) => _TscChecklistItem(
                  index: e.key + 1,
                  text: e.value,
                ))
            .toList(),
      ),
    );
  }
}

class _TscChecklistItem extends StatelessWidget {
  const _TscChecklistItem({required this.index, required this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _tscCopper.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _tscCopper, width: 1),
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: _tscCopper,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  color: _tscIron, fontSize: 12.5, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 15: Comparison table
// ============================================================
class _TscComparisonTable extends StatelessWidget {
  const _TscComparisonTable();

  @override
  Widget build(BuildContext context) {
    final List<_TscComparisonRow> rows = <_TscComparisonRow>[
      _TscComparisonRow(
        name: 'MaterialTextSelectionControls',
        handle: 'Teardrop',
        toolbar: 'Material popup',
        platforms: 'Android, web, desktop fallback',
        accent: _tscSteel,
      ),
      _TscComparisonRow(
        name: 'CupertinoTextSelectionControls',
        handle: 'Pill + knob',
        toolbar: 'Cupertino popover',
        platforms: 'iOS, macOS fallback',
        accent: _tscSteelDark,
      ),
      _TscComparisonRow(
        name: 'DesktopTextSelectionControls',
        handle: 'None',
        toolbar: 'Right-click context',
        platforms: 'Windows, macOS, Linux',
        accent: _tscSteelLight,
      ),
      _TscComparisonRow(
        name: 'EmptyTextSelectionControls',
        handle: 'None',
        toolbar: 'None',
        platforms: 'Custom overlays',
        accent: _tscIvoryDeep,
      ),
      _TscComparisonRow(
        name: '_FoundryTextSelectionControls',
        handle: 'Copper hammer',
        toolbar: 'Foundry pill',
        platforms: 'This demo',
        accent: _tscCopper,
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _tscSteel.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 18,
          headingRowColor:
              WidgetStateProperty.all(_tscSteel.withValues(alpha: 0.1)),
          columns: const <DataColumn>[
            DataColumn(label: Text('Subclass')),
            DataColumn(label: Text('Handle')),
            DataColumn(label: Text('Toolbar')),
            DataColumn(label: Text('Typical platforms')),
          ],
          rows: rows.map(_buildRow).toList(),
        ),
      ),
    );
  }

  DataRow _buildRow(_TscComparisonRow r) {
    return DataRow(cells: <DataCell>[
      DataCell(Row(children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration:
              BoxDecoration(color: r.accent, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          r.name,
          style: const TextStyle(
              fontFamily: 'monospace', fontSize: 12),
        ),
      ])),
      DataCell(Text(r.handle)),
      DataCell(Text(r.toolbar)),
      DataCell(Text(r.platforms)),
    ]);
  }
}

class _TscComparisonRow {
  _TscComparisonRow({
    required this.name,
    required this.handle,
    required this.toolbar,
    required this.platforms,
    required this.accent,
  });
  final String name;
  final String handle;
  final String toolbar;
  final String platforms;
  final Color accent;
}

// ============================================================
// SECTION 16: Anchor mathematics panel
// ============================================================
class _TscAnchorMathPanel extends StatelessWidget {
  const _TscAnchorMathPanel();

  @override
  Widget build(BuildContext context) {
    final List<_TscAnchorCase> cases = <_TscAnchorCase>[
      _TscAnchorCase(
        type: 'left',
        formula: 'anchor = (handleWidth, 0)',
        reason:
            'The left handle appears to the left of the caret; its '
            'top-right corner pins to the selection endpoint so '
            'the handle "points up and to the right".',
        accent: _tscSteel,
      ),
      _TscAnchorCase(
        type: 'right',
        formula: 'anchor = (0, 0)',
        reason:
            'The right handle appears to the right of the caret; '
            'its top-left corner pins to the endpoint so the '
            'handle points up and to the left.',
        accent: _tscSteelDark,
      ),
      _TscAnchorCase(
        type: 'collapsed',
        formula: 'anchor = (handleWidth / 2, 0)',
        reason:
            'A collapsed (cursor) handle is centred horizontally '
            'on the caret. The top-centre point is the anchor.',
        accent: _tscCopper,
      ),
    ];
    return Column(
      children: cases
          .map((_TscAnchorCase c) => _TscAnchorCaseCard(entry: c))
          .toList(),
    );
  }
}

class _TscAnchorCase {
  _TscAnchorCase({
    required this.type,
    required this.formula,
    required this.reason,
    required this.accent,
  });
  final String type;
  final String formula;
  final String reason;
  final Color accent;
}

class _TscAnchorCaseCard extends StatelessWidget {
  const _TscAnchorCaseCard({required this.entry});

  final _TscAnchorCase entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: entry.accent.withValues(alpha: 0.5), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: entry.accent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              entry.type,
              style: const TextStyle(
                color: _tscIvory,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.formula,
                  style: TextStyle(
                    color: entry.accent,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.reason,
                  style: const TextStyle(
                      color: _tscIron, fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 17: Footer — foundry marks
// ============================================================
class _TscFooter extends StatelessWidget {
  const _TscFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _tscIron,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Foundry marks',
            style: TextStyle(
              color: _tscCopperGlow,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'TextSelectionControls — abstract class, three visual '
            'hooks, one deprecated toolbar hook. This demo exercises '
            'all three canned subclasses and a custom one, and shows '
            'the modern contextMenuBuilder migration target.',
            style: TextStyle(
              color: _tscIvory.withValues(alpha: 0.85),
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              _TscFooterBadge(
                  label: 'steel', color: _tscSteel, value: '#4A5D73'),
              const SizedBox(width: 8),
              _TscFooterBadge(
                  label: 'ivory', color: _tscIvory, value: '#F2EEE3'),
              const SizedBox(width: 8),
              _TscFooterBadge(
                  label: 'copper', color: _tscCopper, value: '#AD6446'),
              const SizedBox(width: 8),
              _TscFooterBadge(
                  label: 'iron', color: _tscIvoryDark, value: '#1F1B16'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TscFooterBadge extends StatelessWidget {
  const _TscFooterBadge({
    required this.label,
    required this.color,
    required this.value,
  });

  final String label;
  final Color color;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.7)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                  color: _tscIvory.withValues(alpha: 0.4), width: 0.5),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: _tscIvory.withValues(alpha: 0.7),
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION 18: Entry point
// ============================================================
// The d4rt AST harness invokes build(context) and expects a Widget
// subtree rooted in MaterialApp.  We return a MaterialApp themed
// in iron/ivory with the foundry scaffold.  All state lives inside
// _TscDemoRoot so the entry point is a pure factory.

dynamic build(BuildContext context) {
  debugPrint('TextSelectionControls Foundry demo building '
      '— r=${_tscCopper.r}, g=${_tscCopper.g}, '
      'b=${_tscCopper.b}, a=${_tscCopper.a}');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TextSelectionControls Foundry',
    theme: ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: _tscSteel,
        onPrimary: _tscIvory,
        secondary: _tscCopper,
        onSecondary: _tscIvory,
        error: Color(0xFFB00020),
        onError: _tscIvory,
        surface: _tscIvory,
        onSurface: _tscIron,
      ),
      scaffoldBackgroundColor: _tscIvory,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: _tscCopper,
        selectionColor: Color(0x554A5D73),
        selectionHandleColor: _tscCopper,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _tscIvory,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: _tscSteel.withValues(alpha: 0.6)),
        ),
      ),
    ),
    home: const _TscDemoRoot(),
  );
}
