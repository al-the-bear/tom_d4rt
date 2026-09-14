// ignore_for_file: avoid_print
// D4rt deep-demo script: WidgetInspector
// Visual demonstration of the Flutter WidgetInspector widget.
//
// WidgetInspector (package:flutter/src/widgets/widget_inspector.dart, re-
// exported via package:flutter/widgets.dart) wraps a subtree and enables
// pointer-level "pick a widget" behaviour.  When DevTools or the VM
// service flips `debugShowWidgetInspectorOverride` to true, the inspector
// intercepts pointer events, walks the render tree, paints a crimson
// selection halo over the chosen widget, and publishes the details into
// `WidgetInspectorService.instance.selection`.
//
// The public constructor in recent Flutter SDKs takes three builder
// callbacks:
//
//   • tapBehaviorButtonBuilder           — builds the "select-on-tap"
//                                          toggle button
//   • exitWidgetSelectionButtonBuilder   — builds the "leave select mode"
//                                          button
//   • moveExitWidgetSelectionButtonBuilder — builds the "swap the exit
//                                          button to the other corner"
//                                          button
//
// All three fields are typed as nullable (`…?`), but the constructor
// declares them `required`.  You pass real builders to wire real widgets,
// or `null` to skip the corresponding overlay control.  The `selectButton`
// concept from older SDKs is no longer a dedicated builder — selection is
// now driven by the DevTools pipeline.
//
// In the d4rt AST harness the inspector cannot actually hit-test through
// the interpreter boundary, so this demo:
//
//   • instantiates a real WidgetInspector with three live builder
//     callbacks,
//   • wraps the call in try/catch so an interpreter-side failure does not
//     tank the whole page, and
//   • falls back to a deterministic visualisation that mirrors the UX the
//     inspector would provide on a native build.
//
// Theme : Magnifying Glass over Widget Tree — brass, glass, midnight.
// Prefix: _Wi (top-level classes use _WiMag… / _WiScope… to avoid
// clashing with stand-alone `_Wi*` helpers inside build()).
import 'dart:math' as math;

import 'package:flutter/material.dart';

// ─────────────────────── palette & theme tokens ──────────────────────
//
// Declared as top-level const fields so they can appear inside const
// constructor expressions (a class-instance `.field` access does not
// qualify as a constant expression even when the instance is const).

const String _wiMagName = 'Magnifier Midnight';
const Color _wiMagMidnight = Color(0xFF0B1E2E);
const Color _wiMagBrass = Color(0xFFC8A15A);
const Color _wiMagBrassDeep = Color(0xFF8A6B2E);
const Color _wiMagGlass = Color(0xFFDDE9F2);
const Color _wiMagGlassEdge = Color(0xFFAAC2D6);
const Color _wiMagHalo = Color(0xFFE53935);
const Color _wiMagHaloSoft = Color(0xFFFF8A80);
const Color _wiMagPaper = Color(0xFFF6F2E9);
const Color _wiMagInk = Color(0xFF102033);
const Color _wiMagMute = Color(0xFF5B6B7A);
const Color _wiMagSuccess = Color(0xFF2E7D32);
const Color _wiMagWarn = Color(0xFFEF6C00);

// ─────────────────────── mock tap-behaviour enum ──────────────────────

enum _WiTapBehavior {
  select,
  passThrough,
}

// ─────────────────────── widget-tree node model ──────────────────────

class _WiTreeNode {
  final String id;
  final String kind;
  final String label;
  final IconData icon;
  final List<_WiTreeNode> children;
  final Offset position;
  final Size size;

  const _WiTreeNode({
    required this.id,
    required this.kind,
    required this.label,
    required this.icon,
    required this.position,
    required this.size,
    this.children = const <_WiTreeNode>[],
  });
}

// ─────────────────────── magnifier custom painter ────────────────────

class _WiMagnifierPainter extends CustomPainter {
  final double pulse;
  final Offset focus;
  final Color brass;
  final Color glass;
  final Color halo;
  final Color midnight;

  _WiMagnifierPainter({
    required this.pulse,
    required this.focus,
    required this.brass,
    required this.glass,
    required this.halo,
    required this.midnight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = midnight.withValues(alpha: 0.08)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    const double step = 24.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Draw several "widgets" under the magnifier
    final Paint widgetPaint = Paint()..style = PaintingStyle.fill;
    final List<Rect> widgets = <Rect>[
      Rect.fromLTWH(size.width * 0.08, size.height * 0.18, 90, 48),
      Rect.fromLTWH(size.width * 0.42, size.height * 0.22, 120, 60),
      Rect.fromLTWH(size.width * 0.18, size.height * 0.55, 70, 36),
      Rect.fromLTWH(size.width * 0.55, size.height * 0.58, 96, 52),
    ];
    for (int i = 0; i < widgets.length; i++) {
      widgetPaint.color = (i == 1)
          ? brass.withValues(alpha: 0.35)
          : midnight.withValues(alpha: 0.12);
      final RRect rr = RRect.fromRectAndRadius(
        widgets[i],
        const Radius.circular(8),
      );
      canvas.drawRRect(rr, widgetPaint);
      final Paint border = Paint()
        ..color = (i == 1) ? brass : midnight.withValues(alpha: 0.35)
        ..strokeWidth = 1.4
        ..style = PaintingStyle.stroke;
      canvas.drawRRect(rr, border);
    }

    // Selection halo on widget #1
    final double haloAlpha = 0.35 + 0.35 * pulse;
    final Paint haloPaint = Paint()
      ..color = halo.withValues(alpha: haloAlpha)
      ..strokeWidth = 3.0 + 1.5 * pulse
      ..style = PaintingStyle.stroke;
    final RRect haloRR = RRect.fromRectAndRadius(
      widgets[1].inflate(4 + 2 * pulse),
      const Radius.circular(12),
    );
    canvas.drawRRect(haloRR, haloPaint);

    // Magnifier glass
    final double radius = math.min(size.width, size.height) * 0.28;
    final Offset center = Offset(
      focus.dx.clamp(radius + 8, size.width - radius - 8),
      focus.dy.clamp(radius + 8, size.height - radius - 8),
    );
    final Paint glassFill = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          glass.withValues(alpha: 0.95),
          glass.withValues(alpha: 0.55),
          midnight.withValues(alpha: 0.15),
        ],
        stops: const <double>[0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, glassFill);

    final Paint rim = Paint()
      ..color = brass
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, rim);

    final Paint innerRim = Paint()
      ..color = brass.withValues(alpha: 0.4)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius - 6, innerRim);

    // Highlight gleam on the glass
    final Paint gleam = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;
    final Path gleamPath = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(center.dx - radius * 0.35, center.dy - radius * 0.45),
          width: radius * 0.55,
          height: radius * 0.25,
        ),
      );
    canvas.drawPath(gleamPath, gleam);

    // Handle of the magnifier
    final double angle = math.pi * 0.25;
    final Offset handleStart = Offset(
      center.dx + math.cos(angle) * radius,
      center.dy + math.sin(angle) * radius,
    );
    final Offset handleEnd = Offset(
      handleStart.dx + math.cos(angle) * radius * 0.9,
      handleStart.dy + math.sin(angle) * radius * 0.9,
    );
    final Paint handle = Paint()
      ..color = brass
      ..strokeWidth = 14.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(handleStart, handleEnd, handle);
    final Paint handleInner = Paint()
      ..color = midnight.withValues(alpha: 0.6)
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(handleStart, handleEnd, handleInner);
  }

  @override
  bool shouldRepaint(covariant _WiMagnifierPainter old) {
    return old.pulse != pulse ||
        old.focus != focus ||
        old.brass != brass ||
        old.glass != glass ||
        old.halo != halo ||
        old.midnight != midnight;
  }
}

// ─────────────────────── selection halo painter ──────────────────────

class _WiHaloPainter extends CustomPainter {
  final double phase;
  final Color halo;
  final Color haloSoft;

  _WiHaloPainter({
    required this.phase,
    required this.halo,
    required this.haloSoft,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double t = (math.sin(phase * math.pi * 2.0) + 1.0) * 0.5;
    final Rect base = Offset.zero & size;
    final Paint outer = Paint()
      ..color = halo.withValues(alpha: 0.35 + 0.3 * t)
      ..strokeWidth = 2.0 + 1.5 * t
      ..style = PaintingStyle.stroke;
    canvas.drawRRect(
      RRect.fromRectAndRadius(base.deflate(2), const Radius.circular(10)),
      outer,
    );
    final Paint inner = Paint()
      ..color = haloSoft.withValues(alpha: 0.18 + 0.22 * (1 - t))
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(base.deflate(6), const Radius.circular(8)),
      inner,
    );
    final Paint corners = Paint()
      ..color = halo
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    const double c = 12;
    final Offset tl = base.topLeft.translate(2, 2);
    final Offset tr = base.topRight.translate(-2, 2);
    final Offset bl = base.bottomLeft.translate(2, -2);
    final Offset br = base.bottomRight.translate(-2, -2);
    canvas.drawLine(tl, tl.translate(c, 0), corners);
    canvas.drawLine(tl, tl.translate(0, c), corners);
    canvas.drawLine(tr, tr.translate(-c, 0), corners);
    canvas.drawLine(tr, tr.translate(0, c), corners);
    canvas.drawLine(bl, bl.translate(c, 0), corners);
    canvas.drawLine(bl, bl.translate(0, -c), corners);
    canvas.drawLine(br, br.translate(-c, 0), corners);
    canvas.drawLine(br, br.translate(0, -c), corners);
  }

  @override
  bool shouldRepaint(covariant _WiHaloPainter old) =>
      old.phase != phase || old.halo != halo || old.haloSoft != haloSoft;
}

// ─────────────────────── parallax widget-tree painter ────────────────

class _WiMiniTreePainter extends CustomPainter {
  final List<_WiTreeNode> nodes;
  final String? selectedId;
  final double phase;
  final Color brass;
  final Color midnight;
  final Color halo;

  _WiMiniTreePainter({
    required this.nodes,
    required this.selectedId,
    required this.phase,
    required this.brass,
    required this.midnight,
    required this.halo,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = midnight.withValues(alpha: 0.04);
    canvas.drawRect(Offset.zero & size, bg);

    final Paint line = Paint()
      ..color = brass.withValues(alpha: 0.55)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    for (final _WiTreeNode parent in nodes) {
      final Offset pc = Offset(
        parent.position.dx + parent.size.width / 2,
        parent.position.dy + parent.size.height,
      );
      for (final _WiTreeNode child in parent.children) {
        final Offset cc = Offset(
          child.position.dx + child.size.width / 2,
          child.position.dy,
        );
        final Path path = Path()
          ..moveTo(pc.dx, pc.dy)
          ..cubicTo(
            pc.dx,
            (pc.dy + cc.dy) / 2,
            cc.dx,
            (pc.dy + cc.dy) / 2,
            cc.dx,
            cc.dy,
          );
        canvas.drawPath(path, line);
      }
    }

    void drawNode(_WiTreeNode node) {
      final Rect r = node.position & node.size;
      final bool selected = node.id == selectedId;
      final Paint fill = Paint()
        ..color = selected
            ? brass.withValues(alpha: 0.25)
            : midnight.withValues(alpha: 0.06);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(6));
      canvas.drawRRect(rr, fill);

      final Paint border = Paint()
        ..color = selected ? halo : brass.withValues(alpha: 0.75)
        ..strokeWidth = selected ? 2.0 : 1.2
        ..style = PaintingStyle.stroke;
      canvas.drawRRect(rr, border);

      if (selected) {
        final double t = (math.sin(phase * math.pi * 2.0) + 1.0) * 0.5;
        final Paint pulseRim = Paint()
          ..color = halo.withValues(alpha: 0.35 + 0.3 * t)
          ..strokeWidth = 2.5 + 1.5 * t
          ..style = PaintingStyle.stroke;
        canvas.drawRRect(
          RRect.fromRectAndRadius(r.inflate(3), const Radius.circular(9)),
          pulseRim,
        );
      }

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: node.label,
          style: TextStyle(
            color: midnight,
            fontSize: 10,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: node.size.width - 10);
      tp.paint(
        canvas,
        Offset(r.left + 6, r.top + (r.height - tp.height) / 2),
      );

      for (final _WiTreeNode c in node.children) {
        drawNode(c);
      }
    }

    for (final _WiTreeNode n in nodes) {
      drawNode(n);
    }
  }

  @override
  bool shouldRepaint(covariant _WiMiniTreePainter old) {
    return old.selectedId != selectedId ||
        old.phase != phase ||
        old.nodes.length != nodes.length;
  }
}

// ─────────────────────── top-level build() entry ─────────────────────

dynamic build(BuildContext context) {
  print('=== WidgetInspector deep demo bootstrapping ===');
  return const _WiMagApp();
}

// ─────────────────────── root MaterialApp shell ──────────────────────

class _WiMagApp extends StatelessWidget {
  const _WiMagApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WidgetInspector Magnifier Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _wiMagBrass,
          primary: _wiMagBrass,
          secondary: _wiMagMidnight,
          surface: _wiMagPaper,
        ),
        scaffoldBackgroundColor: _wiMagPaper,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const _WiMagHome(),
    );
  }
}

// ─────────────────────── stateful home ───────────────────────────────

class _WiMagHome extends StatefulWidget {
  const _WiMagHome();

  @override
  State<_WiMagHome> createState() => _WiMagHomeState();
}

class _WiMagHomeState extends State<_WiMagHome>
    with TickerProviderStateMixin {
  late final AnimationController _haloController;
  late final AnimationController _magController;

  bool _inspectorActive = true;
  bool _selectionOnTap = true;
  bool _leftAligned = false;
  String _selectedNodeId = 'scaffold';
  _WiTapBehavior _tapBehavior = _WiTapBehavior.select;
  int _sdkBuilderCalls = 0;
  String _lastEvent = 'idle';

  final List<String> _eventLog = <String>[];

  @override
  void initState() {
    super.initState();
    _haloController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _magController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat();
    _logEvent('demo:init');
  }

  @override
  void dispose() {
    _haloController.dispose();
    _magController.dispose();
    super.dispose();
  }

  void _logEvent(String kind) {
    setState(() {
      _lastEvent = kind;
      _eventLog.insert(0, '${DateTime.now().toIso8601String()}  $kind');
      if (_eventLog.length > 12) {
        _eventLog.removeLast();
      }
    });
  }

  void _toggleInspector(bool v) {
    setState(() => _inspectorActive = v);
    _logEvent('inspector:${v ? "on" : "off"}');
  }

  void _toggleTap(bool v) {
    setState(() => _selectionOnTap = v);
    _logEvent('selectionOnTap:${v ? "on" : "off"}');
  }

  void _flipAlignment() {
    setState(() => _leftAligned = !_leftAligned);
    _logEvent('exitButton:${_leftAligned ? "left" : "right"}');
  }

  void _pickNode(String id) {
    setState(() => _selectedNodeId = id);
    _logEvent('node:pick:$id');
  }

  void _flipTapBehavior() {
    setState(() {
      _tapBehavior = _tapBehavior == _WiTapBehavior.select
          ? _WiTapBehavior.passThrough
          : _WiTapBehavior.select;
    });
    _logEvent('tapBehavior:${_tapBehavior.name}');
  }

  void _noteBuilderCall(String which) {
    _sdkBuilderCalls++;
    _logEvent('builder:$which');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _wiMagPaper,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(child: _WiMagDossier(paletteName: _wiMagName)),
            SliverToBoxAdapter(
              child: _WiMagControls(
                inspectorActive: _inspectorActive,
                selectionOnTap: _selectionOnTap,
                leftAligned: _leftAligned,
                tapBehavior: _tapBehavior,
                onToggleInspector: _toggleInspector,
                onToggleTap: _toggleTap,
                onFlipAlignment: _flipAlignment,
                onFlipTapBehavior: _flipTapBehavior,
                lastEvent: _lastEvent,
                eventLog: _eventLog,
                sdkBuilderCalls: _sdkBuilderCalls,
              ),
            ),
            SliverToBoxAdapter(
              child: _WiMagLiveWrap(
                inspectorActive: _inspectorActive,
                selectionOnTap: _selectionOnTap,
                leftAligned: _leftAligned,
                tapBehavior: _tapBehavior,
                onBuilderCall: _noteBuilderCall,
                haloController: _haloController,
              ),
            ),
            SliverToBoxAdapter(
              child: _WiMagBuilderGallery(
                onBuilderCall: _noteBuilderCall,
                leftAligned: _leftAligned,
                selectionOnTap: _selectionOnTap,
              ),
            ),
            SliverToBoxAdapter(
              child: _WiMagTreeOverlay(
                haloController: _haloController,
                magController: _magController,
                selectedId: _selectedNodeId,
                onPick: _pickNode,
              ),
            ),
            SliverToBoxAdapter(
              child: _WiMagTapBehaviorCard(
                tapBehavior: _tapBehavior,
                onFlip: _flipTapBehavior,
              ),
            ),
            const SliverToBoxAdapter(child: _WiMagKeyboardCard()),
            const SliverToBoxAdapter(child: _WiMagServiceBridge()),
            const SliverToBoxAdapter(child: _WiMagRecipes()),
            const SliverToBoxAdapter(child: _WiMagGlossary()),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 1 — Dossier / preamble card
// ═════════════════════════════════════════════════════════════════════

class _WiMagDossier extends StatelessWidget {
  final String paletteName;
  const _WiMagDossier({required this.paletteName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[_wiMagMidnight, Color(0xFF1C3449)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _wiMagMidnight.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: _wiMagBrass.withValues(alpha: 0.18),
                  border: Border.all(color: _wiMagBrass, width: 2),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(
                  Icons.travel_explore,
                  color: _wiMagBrass,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'WidgetInspector',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'A brass magnifier over the widget tree',
                      style: TextStyle(
                        color: _wiMagBrass,
                        fontSize: 13.5,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              _WiMagBadge(
                label: paletteName,
                background: _wiMagBrass.withValues(alpha: 0.22),
                foreground: _wiMagBrass,
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'WidgetInspector wraps a subtree and, while the DevTools '
            '"Select Widget" mode is on, intercepts pointer events to let '
            'you pick a widget by tapping its pixels. The picked widget is '
            'published to WidgetInspectorService.instance.selection, a '
            'crimson halo is painted over its rendered bounds, and DevTools '
            'opens the element in the widget tree panel.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _wiMagBrass.withValues(alpha: 0.45),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _WiMagBullet(
                  icon: Icons.memory,
                  text:
                      'Declared in package:flutter/src/widgets/widget_inspector.dart',
                ),
                _WiMagBullet(
                  icon: Icons.widgets,
                  text:
                      'Normally wrapped automatically by WidgetsApp when the '
                      'inspector is enabled.',
                ),
                _WiMagBullet(
                  icon: Icons.touch_app,
                  text:
                      'Uses its own RenderObject to hit-test the subtree and '
                      'paint the selection halo.',
                ),
                _WiMagBullet(
                  icon: Icons.extension,
                  text:
                      'Three nullable builders customise the overlay buttons: '
                      'tapBehaviour, exitSelection, moveExitSelection.',
                ),
                _WiMagBullet(
                  icon: Icons.warning_amber,
                  text:
                      'In this d4rt harness the real inspector cannot hit-test '
                      'through the interpreter bridge — we simulate the UX.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _WiMagPill(text: 'widget'),
              _WiMagPill(text: 'debug-only'),
              _WiMagPill(text: 'DevTools surface'),
              _WiMagPill(text: 'pointer-level'),
              _WiMagPill(text: 'render-object-aware'),
            ],
          ),
        ],
      ),
    );
  }
}

class _WiMagBadge extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;
  const _WiMagBadge({
    required this.label,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: foreground.withValues(alpha: 0.6)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _WiMagBullet extends StatelessWidget {
  final IconData icon;
  final String text;
  const _WiMagBullet({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: _wiMagBrass, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.3,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WiMagPill extends StatelessWidget {
  final String text;
  const _WiMagPill({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _wiMagBrass.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.55)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: _wiMagBrass,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 2A — Controls / event log panel
// ═════════════════════════════════════════════════════════════════════

class _WiMagControls extends StatelessWidget {
  final bool inspectorActive;
  final bool selectionOnTap;
  final bool leftAligned;
  final _WiTapBehavior tapBehavior;
  final ValueChanged<bool> onToggleInspector;
  final ValueChanged<bool> onToggleTap;
  final VoidCallback onFlipAlignment;
  final VoidCallback onFlipTapBehavior;
  final String lastEvent;
  final List<String> eventLog;
  final int sdkBuilderCalls;

  const _WiMagControls({
    required this.inspectorActive,
    required this.selectionOnTap,
    required this.leftAligned,
    required this.tapBehavior,
    required this.onToggleInspector,
    required this.onToggleTap,
    required this.onFlipAlignment,
    required this.onFlipTapBehavior,
    required this.lastEvent,
    required this.eventLog,
    required this.sdkBuilderCalls,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _wiMagMidnight.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.tune, color: _wiMagMidnight, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Inspector control panel',
                style: TextStyle(
                  color: _wiMagMidnight,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              _WiMagBadge(
                label: 'builder calls: $sdkBuilderCalls',
                background: _wiMagBrass.withValues(alpha: 0.18),
                foreground: _wiMagBrassDeep,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 14,
            runSpacing: 10,
            children: <Widget>[
              _WiMagControlChip(
                label: 'inspector active',
                value: inspectorActive,
                onChanged: onToggleInspector,
                icon: Icons.remove_red_eye,
              ),
              _WiMagControlChip(
                label: 'selectionOnTap',
                value: selectionOnTap,
                onChanged: onToggleTap,
                icon: Icons.ads_click,
              ),
              _WiMagButtonChip(
                label: leftAligned
                    ? 'exit: left corner'
                    : 'exit: right corner',
                icon: leftAligned
                    ? Icons.format_align_left
                    : Icons.format_align_right,
                onTap: onFlipAlignment,
              ),
              _WiMagButtonChip(
                label: tapBehavior == _WiTapBehavior.select
                    ? 'tap → select'
                    : 'tap → pass through',
                icon: tapBehavior == _WiTapBehavior.select
                    ? Icons.center_focus_strong
                    : Icons.touch_app,
                onTap: onFlipTapBehavior,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _wiMagMidnight.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.event_note,
                        color: _wiMagMidnight, size: 16),
                    const SizedBox(width: 6),
                    const Text(
                      'Event log',
                      style: TextStyle(
                        color: _wiMagMidnight,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'last: $lastEvent',
                      style: TextStyle(
                        color: _wiMagMute,
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 88,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: eventLog.length,
                    itemBuilder: (BuildContext c, int i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          eventLog[i],
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: _wiMagInk,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
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

class _WiMagControlChip extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;

  const _WiMagControlChip({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: value
            ? _wiMagBrass.withValues(alpha: 0.15)
            : _wiMagMute.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: value
              ? _wiMagBrass
              : _wiMagMute.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            size: 16,
            color: value ? _wiMagBrassDeep : _wiMagMute,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: value ? _wiMagBrassDeep : _wiMagMute,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: _wiMagBrass,
            ),
          ),
        ],
      ),
    );
  }
}

class _WiMagButtonChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _WiMagButtonChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _wiMagMidnight,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: _wiMagBrass, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 2B — Live wrapped-subtree demo
// ═════════════════════════════════════════════════════════════════════

class _WiMagLiveWrap extends StatelessWidget {
  final bool inspectorActive;
  final bool selectionOnTap;
  final bool leftAligned;
  final _WiTapBehavior tapBehavior;
  final void Function(String which) onBuilderCall;
  final AnimationController haloController;

  const _WiMagLiveWrap({
    required this.inspectorActive,
    required this.selectionOnTap,
    required this.leftAligned,
    required this.tapBehavior,
    required this.onBuilderCall,
    required this.haloController,
  });

  Widget _buildSubtree(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _wiMagGlass,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _wiMagGlassEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.apps, color: _wiMagMidnight),
              const SizedBox(width: 8),
              const Text(
                'Sample subtree under inspection',
                style: TextStyle(
                  color: _wiMagMidnight,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: inspectorActive ? _wiMagSuccess : _wiMagMute,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: _wiMagBrass.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Card A',
                      style: TextStyle(
                        color: _wiMagMidnight,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: _wiMagMidnight.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Card B',
                      style: TextStyle(
                        color: _wiMagMidnight,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              for (final String tag in const <String>['chip-1', 'chip-2', 'chip-3'])
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      border:
                          Border.all(color: _wiMagMidnight.withValues(alpha: 0.25)),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: _wiMagMidnight,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _exitBuilder(
    BuildContext context, {
    required VoidCallback onPressed,
    required String semanticsLabel,
    required GlobalKey key,
  }) {
    onBuilderCall('exitWidgetSelection');
    return _WiMagInspectorButton(
      key: key,
      icon: Icons.close,
      tooltip: semanticsLabel,
      background: _wiMagHalo,
      foreground: Colors.white,
      onPressed: onPressed,
    );
  }

  Widget _moveExitBuilder(
    BuildContext context, {
    required VoidCallback onPressed,
    required String semanticsLabel,
    bool usesDefaultAlignment = true,
  }) {
    onBuilderCall('moveExitWidgetSelection');
    return _WiMagInspectorButton(
      icon: usesDefaultAlignment
          ? Icons.swap_horiz
          : Icons.swap_horizontal_circle,
      tooltip: semanticsLabel,
      background: _wiMagMidnight,
      foreground: _wiMagBrass,
      onPressed: onPressed,
    );
  }

  Widget _tapBehaviorBuilder(
    BuildContext context, {
    required VoidCallback onPressed,
    required String semanticsLabel,
    required bool selectionOnTapEnabled,
  }) {
    onBuilderCall('tapBehavior');
    return _WiMagInspectorButton(
      icon: selectionOnTapEnabled
          ? Icons.center_focus_strong
          : Icons.touch_app,
      tooltip: semanticsLabel,
      background: selectionOnTapEnabled ? _wiMagBrass : _wiMagGlassEdge,
      foreground: _wiMagMidnight,
      onPressed: onPressed,
    );
  }

  Widget _wrappedAttempt(BuildContext context) {
    Widget wrapped;
    String status;
    IconData statusIcon;
    Color statusColor;

    try {
      wrapped = WidgetInspector(
        tapBehaviorButtonBuilder: _tapBehaviorBuilder,
        exitWidgetSelectionButtonBuilder: _exitBuilder,
        moveExitWidgetSelectionButtonBuilder: _moveExitBuilder,
        child: _buildSubtree(context),
      );
      status = 'WidgetInspector instantiated successfully.';
      statusIcon = Icons.check_circle;
      statusColor = _wiMagSuccess;
    } catch (e, st) {
      debugPrint('WidgetInspector construction failed: $e');
      debugPrint('$st');
      wrapped = _buildSubtree(context);
      status = 'WidgetInspector threw — falling back to plain subtree.';
      statusIcon = Icons.warning_amber;
      statusColor = _wiMagWarn;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(statusIcon, color: statusColor, size: 18),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: inspectorActive
              ? wrapped
              : Opacity(opacity: 0.55, child: _buildSubtree(context)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.widgets, color: _wiMagMidnight),
              SizedBox(width: 8),
              Text(
                '§2 Live wrapped-subtree demo',
                style: TextStyle(
                  color: _wiMagMidnight,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'We instantiate a real WidgetInspector and pass three builder '
            'callbacks. Each callback, when invoked by the SDK, builds a '
            'small floating-action-button-style control whose onPressed is '
            'wired to the inspector internals. In the AST harness these '
            'builders may be called during debug-only overlays or not at '
            'all — we log invocations in the event log above.',
            style: TextStyle(
              color: _wiMagInk,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          _WiMagSubSectionBanner(
            text: 'Inspector toggle',
            icon: Icons.power_settings_new,
          ),
          const SizedBox(height: 10),
          _wrappedAttempt(context),
          const SizedBox(height: 14),
          _WiMagSubSectionBanner(
            text: 'Overlay button (synthetic)',
            icon: Icons.layers,
          ),
          const SizedBox(height: 10),
          _WiMagSyntheticOverlay(
            selectionOnTap: selectionOnTap,
            leftAligned: leftAligned,
            tapBehavior: tapBehavior,
            haloController: haloController,
          ),
        ],
      ),
    );
  }
}

class _WiMagInspectorButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color background;
  final Color foreground;
  final VoidCallback onPressed;

  const _WiMagInspectorButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.background,
    required this.foreground,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: background,
        shape: const CircleBorder(),
        elevation: 3,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: 42,
            height: 42,
            child: Icon(icon, color: foreground, size: 22),
          ),
        ),
      ),
    );
  }
}

class _WiMagSubSectionBanner extends StatelessWidget {
  final String text;
  final IconData icon;
  const _WiMagSubSectionBanner({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _wiMagBrass.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.55)),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: _wiMagBrassDeep, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: _wiMagBrassDeep,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _WiMagSyntheticOverlay extends StatelessWidget {
  final bool selectionOnTap;
  final bool leftAligned;
  final _WiTapBehavior tapBehavior;
  final AnimationController haloController;

  const _WiMagSyntheticOverlay({
    required this.selectionOnTap,
    required this.leftAligned,
    required this.tapBehavior,
    required this.haloController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: _wiMagMidnight.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _wiMagMidnight.withValues(alpha: 0.1),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AnimatedBuilder(
                animation: haloController,
                builder: (BuildContext c, Widget? _) {
                  return CustomPaint(
                    painter: _WiHaloPainter(
                      phase: haloController.value,
                      halo: _wiMagHalo,
                      haloSoft: _wiMagHaloSoft,
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _wiMagGlass,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Selected widget — halo pulses',
                          style: TextStyle(
                            color: _wiMagMidnight,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: leftAligned ? 12 : null,
            right: leftAligned ? null : 12,
            child: Row(
              children: <Widget>[
                _WiMagInspectorButton(
                  icon: tapBehavior == _WiTapBehavior.select
                      ? Icons.center_focus_strong
                      : Icons.touch_app,
                  tooltip: 'Tap behavior',
                  background: selectionOnTap
                      ? _wiMagBrass
                      : _wiMagGlassEdge,
                  foreground: _wiMagMidnight,
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                _WiMagInspectorButton(
                  icon: Icons.swap_horiz,
                  tooltip: 'Move exit button',
                  background: _wiMagMidnight,
                  foreground: _wiMagBrass,
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                _WiMagInspectorButton(
                  icon: Icons.close,
                  tooltip: 'Exit select mode',
                  background: _wiMagHalo,
                  foreground: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 3 — Builder gallery (4 cards; selectButtonBuilder still
// documented for legacy awareness even though SDK dropped it)
// ═════════════════════════════════════════════════════════════════════

class _WiMagBuilderGallery extends StatelessWidget {
  final void Function(String which) onBuilderCall;
  final bool leftAligned;
  final bool selectionOnTap;

  const _WiMagBuilderGallery({
    required this.onBuilderCall,
    required this.leftAligned,
    required this.selectionOnTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<_WiMagBuilderSpec> cards = <_WiMagBuilderSpec>[
      _WiMagBuilderSpec(
        title: 'selectButtonBuilder  (legacy)',
        typedefText:
            'Widget Function(BuildContext, VoidCallback, GlobalKey)',
        description:
            'Older SDKs exposed this to build the "enter select mode" '
            'button. Recent Flutter SDKs removed the dedicated builder — '
            'DevTools now triggers select mode via debugShowWidgetInspectorOverride. '
            'Shown here for archaeological reference.',
        icon: Icons.center_focus_strong,
        demo: _WiMagInspectorButton(
          icon: Icons.search,
          tooltip: 'Legacy select button',
          background: _wiMagBrass,
          foreground: _wiMagMidnight,
          onPressed: () {},
        ),
        isLegacy: true,
      ),
      _WiMagBuilderSpec(
        title: 'tapBehaviorButtonBuilder',
        typedefText:
            'Widget Function(BuildContext, {onPressed, semanticsLabel, selectionOnTapEnabled})',
        description:
            'Builds the overlay button that toggles whether taps select a '
            'widget or pass through to the underlying app. Argument '
            'selectionOnTapEnabled is a bool; flip its icon to communicate '
            'the current mode.',
        icon: Icons.ads_click,
        demo: _WiMagInspectorButton(
          icon: selectionOnTap
              ? Icons.center_focus_strong
              : Icons.touch_app,
          tooltip: 'Tap behaviour',
          background: selectionOnTap ? _wiMagBrass : _wiMagGlassEdge,
          foreground: _wiMagMidnight,
          onPressed: () {},
        ),
        isLegacy: false,
      ),
      _WiMagBuilderSpec(
        title: 'exitWidgetSelectionButtonBuilder',
        typedefText:
            'Widget Function(BuildContext, {onPressed, semanticsLabel, key})',
        description:
            'Builds the "leave select mode" button shown while select mode '
            'is active. onPressed is wired to exit the overlay; semanticsLabel '
            'is a localised description; the GlobalKey is required so '
            'DevTools can target the widget in automation.',
        icon: Icons.close,
        demo: _WiMagInspectorButton(
          icon: Icons.close,
          tooltip: 'Exit select mode',
          background: _wiMagHalo,
          foreground: Colors.white,
          onPressed: () {},
        ),
        isLegacy: false,
      ),
      _WiMagBuilderSpec(
        title: 'moveExitWidgetSelectionButtonBuilder',
        typedefText:
            'Widget Function(BuildContext, {onPressed, semanticsLabel, usesDefaultAlignment})',
        description:
            'Builds the "move exit button" control, which flips the exit '
            'button between the left and right corners so it never obscures '
            'the widget you are trying to pick. usesDefaultAlignment maps '
            'to the current corner.',
        icon: Icons.swap_horiz,
        demo: _WiMagInspectorButton(
          icon: leftAligned
              ? Icons.format_align_left
              : Icons.format_align_right,
          tooltip: 'Move exit button',
          background: _wiMagMidnight,
          foreground: _wiMagBrass,
          onPressed: () {},
        ),
        isLegacy: false,
      ),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.view_module, color: _wiMagMidnight),
              SizedBox(width: 8),
              Text(
                '§3 Builder-callback gallery',
                style: TextStyle(
                  color: _wiMagMidnight,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Each card shows one builder, the typedef the SDK expects, and '
            'a live instance of the widget it returns. The legacy '
            'selectButtonBuilder is included for documentation parity — '
            'calling it on a modern SDK would not compile, so it is rendered '
            'here from a local stand-in.',
            style: TextStyle(
              color: _wiMagInk,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (BuildContext c, BoxConstraints cons) {
              final int cols = cons.maxWidth > 720 ? 2 : 1;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  for (final _WiMagBuilderSpec s in cards)
                    SizedBox(
                      width: cols == 2
                          ? (cons.maxWidth - 12) / 2
                          : cons.maxWidth,
                      child: _WiMagBuilderCard(spec: s),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WiMagBuilderSpec {
  final String title;
  final String typedefText;
  final String description;
  final IconData icon;
  final Widget demo;
  final bool isLegacy;

  const _WiMagBuilderSpec({
    required this.title,
    required this.typedefText,
    required this.description,
    required this.icon,
    required this.demo,
    required this.isLegacy,
  });
}

class _WiMagBuilderCard extends StatelessWidget {
  final _WiMagBuilderSpec spec;
  const _WiMagBuilderCard({required this.spec});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _wiMagPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: spec.isLegacy
              ? _wiMagWarn.withValues(alpha: 0.6)
              : _wiMagBrass.withValues(alpha: 0.6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(spec.icon, color: _wiMagMidnight, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  spec.title,
                  style: const TextStyle(
                    color: _wiMagMidnight,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (spec.isLegacy)
                _WiMagBadge(
                  label: 'legacy',
                  background: _wiMagWarn.withValues(alpha: 0.15),
                  foreground: _wiMagWarn,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _wiMagMidnight.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              spec.typedefText,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: _wiMagMidnight,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            spec.description,
            style: const TextStyle(
              color: _wiMagInk,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          Center(child: spec.demo),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 4 — Mock widget-tree overlay with selection halo
// ═════════════════════════════════════════════════════════════════════

class _WiMagTreeOverlay extends StatelessWidget {
  final AnimationController haloController;
  final AnimationController magController;
  final String selectedId;
  final ValueChanged<String> onPick;

  const _WiMagTreeOverlay({
    required this.haloController,
    required this.magController,
    required this.selectedId,
    required this.onPick,
  });

  static const List<_WiTreeNode> _nodes = <_WiTreeNode>[
    _WiTreeNode(
      id: 'app',
      kind: 'MaterialApp',
      label: 'MaterialApp',
      icon: Icons.apps,
      position: Offset(20, 10),
      size: Size(130, 28),
      children: <_WiTreeNode>[
        _WiTreeNode(
          id: 'scaffold',
          kind: 'Scaffold',
          label: 'Scaffold',
          icon: Icons.dashboard,
          position: Offset(20, 70),
          size: Size(130, 28),
          children: <_WiTreeNode>[
            _WiTreeNode(
              id: 'appbar',
              kind: 'AppBar',
              label: 'AppBar',
              icon: Icons.title,
              position: Offset(20, 130),
              size: Size(120, 24),
            ),
            _WiTreeNode(
              id: 'body',
              kind: 'Column',
              label: 'Column',
              icon: Icons.view_agenda,
              position: Offset(170, 130),
              size: Size(120, 24),
              children: <_WiTreeNode>[
                _WiTreeNode(
                  id: 'card-a',
                  kind: 'Card',
                  label: 'Card A',
                  icon: Icons.crop_square,
                  position: Offset(160, 180),
                  size: Size(70, 24),
                ),
                _WiTreeNode(
                  id: 'card-b',
                  kind: 'Card',
                  label: 'Card B',
                  icon: Icons.crop_square,
                  position: Offset(240, 180),
                  size: Size(70, 24),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];

  List<_WiTreeNode> _flatten(List<_WiTreeNode> roots) {
    final List<_WiTreeNode> out = <_WiTreeNode>[];
    void recurse(_WiTreeNode n) {
      out.add(n);
      for (final _WiTreeNode c in n.children) {
        recurse(c);
      }
    }
    for (final _WiTreeNode r in roots) {
      recurse(r);
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final List<_WiTreeNode> flat = _flatten(_nodes);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.account_tree, color: _wiMagMidnight),
              SizedBox(width: 8),
              Text(
                '§4 Mini widget-tree with selection halo',
                style: TextStyle(
                  color: _wiMagMidnight,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap a node card to select it. The selection halo is painted '
            'via a CustomPainter and pulses through an AnimationController. '
            'A brass magnifier hovers over the scene to evoke the '
            'inspector lens.',
            style: TextStyle(
              color: _wiMagInk,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          AnimatedBuilder(
            animation: Listenable.merge(<Listenable>[
              haloController,
              magController,
            ]),
            builder: (BuildContext c, Widget? _) {
              final double pulse =
                  (math.sin(haloController.value * math.pi * 2) + 1) * 0.5;
              final double t = magController.value * math.pi * 2;
              final Offset focus = Offset(
                180 + 90 * math.cos(t),
                130 + 40 * math.sin(t),
              );
              return Stack(
                children: <Widget>[
                  SizedBox(
                    height: 230,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: _WiMiniTreePainter(
                        nodes: _nodes,
                        selectedId: selectedId,
                        phase: haloController.value,
                        brass: _wiMagBrass,
                        midnight: _wiMagMidnight,
                        halo: _wiMagHalo,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: _WiMagnifierPainter(
                          pulse: pulse,
                          focus: focus,
                          brass: _wiMagBrass,
                          glass: _wiMagGlass,
                          halo: _wiMagHalo,
                          midnight: _wiMagMidnight,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final _WiTreeNode n in flat)
                InkWell(
                  onTap: () => onPick(n.id),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: selectedId == n.id
                          ? _wiMagHalo.withValues(alpha: 0.18)
                          : _wiMagPaper,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selectedId == n.id
                            ? _wiMagHalo
                            : _wiMagMidnight.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          n.icon,
                          size: 14,
                          color: selectedId == n.id
                              ? _wiMagHalo
                              : _wiMagMidnight,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          n.label,
                          style: TextStyle(
                            fontSize: 12,
                            color: selectedId == n.id
                                ? _wiMagHalo
                                : _wiMagMidnight,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 5 — Tap behaviour comparison card
// ═════════════════════════════════════════════════════════════════════

class _WiMagTapBehaviorCard extends StatelessWidget {
  final _WiTapBehavior tapBehavior;
  final VoidCallback onFlip;

  const _WiMagTapBehaviorCard({
    required this.tapBehavior,
    required this.onFlip,
  });

  @override
  Widget build(BuildContext context) {
    final bool selectActive = tapBehavior == _WiTapBehavior.select;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.compare, color: _wiMagMidnight),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  '§5 TapBehavior.select vs TapBehavior.passThrough',
                  style: TextStyle(
                    color: _wiMagMidnight,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _WiMagButtonChip(
                label: selectActive ? 'SELECT mode' : 'PASS-THROUGH mode',
                icon: selectActive
                    ? Icons.center_focus_strong
                    : Icons.touch_app,
                onTap: onFlip,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'The tapBehavior toggle decides what happens when the user taps '
            'the screen while the inspector is active. In SELECT mode, the '
            'inspector intercepts the tap to select the widget at that '
            'pixel. In PASS-THROUGH mode, the tap reaches the app below so '
            'the user can interact with buttons, scroll, etc. — useful when '
            'a widget has to be in a particular UI state before you inspect '
            'it.',
            style: TextStyle(
              color: _wiMagInk,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (BuildContext c, BoxConstraints cons) {
              final double w = cons.maxWidth < 620
                  ? cons.maxWidth
                  : (cons.maxWidth - 12) / 2;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  SizedBox(
                    width: w,
                    child: _WiMagTapBehaviorPanel(
                      title: 'TapBehavior.select',
                      icon: Icons.center_focus_strong,
                      active: selectActive,
                      description:
                          'Taps are absorbed by the inspector. The hit-test '
                          'walks the render tree and the nearest widget is '
                          'highlighted. Use this when picking a widget.',
                      simulation: const _WiMagSelectSimulation(),
                    ),
                  ),
                  SizedBox(
                    width: w,
                    child: _WiMagTapBehaviorPanel(
                      title: 'TapBehavior.passThrough',
                      icon: Icons.touch_app,
                      active: !selectActive,
                      description:
                          'Taps pass through to the underlying app, so real '
                          'buttons fire. The halo still marks the last '
                          'selected widget but new selections require the '
                          'other mode.',
                      simulation: const _WiMagPassThroughSimulation(),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WiMagTapBehaviorPanel extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool active;
  final String description;
  final Widget simulation;

  const _WiMagTapBehaviorPanel({
    required this.title,
    required this.icon,
    required this.active,
    required this.description,
    required this.simulation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: active
            ? _wiMagBrass.withValues(alpha: 0.1)
            : _wiMagMidnight.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: active
              ? _wiMagBrass
              : _wiMagMidnight.withValues(alpha: 0.2),
          width: active ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: active ? _wiMagBrassDeep : _wiMagMute),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: active ? _wiMagBrassDeep : _wiMagMute,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (active)
                _WiMagBadge(
                  label: 'ACTIVE',
                  background: _wiMagBrass.withValues(alpha: 0.2),
                  foreground: _wiMagBrassDeep,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: _wiMagInk,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          simulation,
        ],
      ),
    );
  }
}

class _WiMagSelectSimulation extends StatelessWidget {
  const _WiMagSelectSimulation();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wiMagMidnight.withValues(alpha: 0.1)),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              for (int i = 0; i < 3; i++)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: i == 1
                          ? _wiMagBrass.withValues(alpha: 0.3)
                          : _wiMagGlass,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: i == 1
                            ? _wiMagHalo
                            : _wiMagMidnight.withValues(alpha: 0.2),
                        width: i == 1 ? 2 : 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'W$i',
                        style: TextStyle(
                          color: i == 1 ? _wiMagHalo : _wiMagMidnight,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const Positioned(
            bottom: 4,
            right: 4,
            child: Text(
              'tap → picked W1',
              style: TextStyle(
                color: _wiMagHalo,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WiMagPassThroughSimulation extends StatelessWidget {
  const _WiMagPassThroughSimulation();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wiMagMidnight.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _wiMagMidnight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Real Button',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _wiMagGlass,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _wiMagMidnight.withValues(alpha: 0.2),
                      ),
                    ),
                    child: const Text(
                      'Text Field',
                      style: TextStyle(
                        color: _wiMagMidnight,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'tap → real onPressed fires',
              style: TextStyle(
                color: _wiMagMidnight,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 6 — Keyboard / overlay controls card
// ═════════════════════════════════════════════════════════════════════

class _WiMagKeyboardCard extends StatelessWidget {
  const _WiMagKeyboardCard();

  @override
  Widget build(BuildContext context) {
    final List<_WiMagKey> keys = <_WiMagKey>[
      _WiMagKey(
        combo: 'DevTools → Inspector',
        action: 'Enable / disable widget inspector globally',
        description:
            'DevTools sets debugShowWidgetInspectorOverride over the VM '
            'service. Without DevTools you can set it manually in main() '
            'for debug builds.',
        icon: Icons.build,
      ),
      _WiMagKey(
        combo: 'Select Widget',
        action: 'Enter / exit select mode',
        description:
            'Toggles whether taps pick a widget. Driven by '
            'WidgetInspectorService.setSelectionById and the overlay exit '
            'button.',
        icon: Icons.center_focus_strong,
      ),
      _WiMagKey(
        combo: 'Show Debug Paint',
        action: 'Toggle debugPaintSizeEnabled',
        description:
            'Unrelated to WidgetInspector but typically paired with it. '
            'Toggled from the inspector toolbar.',
        icon: Icons.brush,
      ),
      _WiMagKey(
        combo: 'Slow Animations',
        action: 'Toggle timeDilation to 5x',
        description:
            'Makes animations slow enough to inspect frame-by-frame while '
            'selection mode is on.',
        icon: Icons.slow_motion_video,
      ),
      _WiMagKey(
        combo: 'Highlight Oversized',
        action: 'Toggle debugInvertOversizedImages',
        description:
            'Inverts colors on assets wider or taller than their display '
            'size. A classic inspector-era debug mode.',
        icon: Icons.image,
      ),
      _WiMagKey(
        combo: 'Repaint Rainbow',
        action: 'Toggle debugRepaintRainbowEnabled',
        description:
            'Colours the bounds of repainted layers. Helps locate '
            'unnecessary rebuilds while the inspector watches.',
        icon: Icons.palette,
      ),
    ];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.keyboard, color: _wiMagMidnight),
              SizedBox(width: 8),
              Text(
                '§6 DevTools-side controls',
                style: TextStyle(
                  color: _wiMagMidnight,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'WidgetInspector itself is a passive widget — the orchestration '
            'is all on the DevTools side. Each row below shows one of the '
            'controls DevTools exposes and the underlying flag it flips.',
            style: TextStyle(
              color: _wiMagInk,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          for (final _WiMagKey k in keys) _WiMagKeyRow(entry: k),
        ],
      ),
    );
  }
}

class _WiMagKey {
  final String combo;
  final String action;
  final String description;
  final IconData icon;
  const _WiMagKey({
    required this.combo,
    required this.action,
    required this.description,
    required this.icon,
  });
}

class _WiMagKeyRow extends StatelessWidget {
  final _WiMagKey entry;
  const _WiMagKeyRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _wiMagPaper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _wiMagMidnight,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(entry.icon, color: _wiMagBrass, size: 14),
                const SizedBox(width: 6),
                Text(
                  entry.combo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.action,
                  style: const TextStyle(
                    color: _wiMagMidnight,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.description,
                  style: const TextStyle(
                    color: _wiMagInk,
                    fontSize: 12,
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

// ═════════════════════════════════════════════════════════════════════
// SECTION 7 — WidgetInspectorService bridge
// ═════════════════════════════════════════════════════════════════════

class _WiMagServiceBridge extends StatelessWidget {
  const _WiMagServiceBridge();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _wiMagMidnight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.cable, color: _wiMagBrass),
              const SizedBox(width: 8),
              const Text(
                '§7 Bridge to WidgetInspectorService',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'WidgetInspector is just the UI surface. The state lives in '
            'WidgetInspectorService.instance, a singleton that:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          for (final String line in const <String>[
            'exposes selection — an InspectorSelection ValueListenable,',
            'registers a dozen VM-service extensions for DevTools,',
            'serialises diagnostic nodes to JSON for the DevTools tree,',
            'pushes selection events when the overlay picks a widget,',
            'reads debugShowWidgetInspectorOverrideNotifier to flip modes.',
          ])
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(Icons.bolt, color: _wiMagBrass, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      line,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _wiMagBrass.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _wiMagBrass),
            ),
            child: const Text(
              'final svc = WidgetInspectorService.instance;\n'
              'svc.selection.addListener(() {\n'
              '  final node = svc.selection.currentElement;\n'
              '  debugPrint(\'picked: \${node?.widget}\');\n'
              '});',
              style: TextStyle(
                color: _wiMagBrass,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 8 — Recipe cards (5+)
// ═════════════════════════════════════════════════════════════════════

class _WiMagRecipe {
  final String title;
  final String summary;
  final String snippet;
  final IconData icon;
  final Color accent;
  const _WiMagRecipe({
    required this.title,
    required this.summary,
    required this.snippet,
    required this.icon,
    required this.accent,
  });
}

const List<_WiMagRecipe> _wiMagRecipes = <_WiMagRecipe>[
  _WiMagRecipe(
    title: 'Custom selection UI',
    summary:
        'Replace the brand-issued buttons with ones that match your design '
        'system. Supply real Material / Cupertino widgets from your own '
        'theme and wire onPressed unchanged.',
    snippet:
        'WidgetInspector(\n'
        '  tapBehaviorButtonBuilder: (ctx, {required onPressed, required semanticsLabel, required selectionOnTapEnabled}) =>\n'
        '      BrandIconButton(icon: selectionOnTapEnabled ? Icons.center_focus_strong : Icons.touch_app, onPressed: onPressed, tooltip: semanticsLabel),\n'
        '  exitWidgetSelectionButtonBuilder: (ctx, {required onPressed, required semanticsLabel, required key}) =>\n'
        '      BrandIconButton(key: key, icon: Icons.close, tooltip: semanticsLabel, onPressed: onPressed),\n'
        '  moveExitWidgetSelectionButtonBuilder: (ctx, {required onPressed, required semanticsLabel, bool usesDefaultAlignment = true}) =>\n'
        '      BrandIconButton(icon: Icons.swap_horiz, tooltip: semanticsLabel, onPressed: onPressed),\n'
        '  child: appShell,\n'
        ');',
    icon: Icons.palette,
    accent: Color(0xFFC8A15A),
  ),
  _WiMagRecipe(
    title: 'DevTools-free inspection',
    summary:
        'Flip debugShowWidgetInspectorOverride manually in a developer-only '
        'menu so field engineers without DevTools can still pick a widget '
        'in the running app.',
    snippet:
        'WidgetsBinding.instance.debugShowWidgetInspectorOverride = true;\n'
        '// later\n'
        'WidgetsBinding.instance.debugShowWidgetInspectorOverride = false;',
    icon: Icons.flashlight_on,
    accent: Color(0xFF2E7D32),
  ),
  _WiMagRecipe(
    title: 'Per-screen gating',
    summary:
        'Only enable the inspector on specific routes. Wrap sensitive '
        'screens in a plain subtree and other screens in a WidgetInspector '
        'to avoid tripping on modal UI.',
    snippet:
        'Widget buildScreen(BuildContext c, AppRoute r) {\n'
        '  final plain = r.screen;\n'
        '  if (!r.enableInspector || !kDebugMode) return plain;\n'
        '  return WidgetInspector(\n'
        '    tapBehaviorButtonBuilder: defaultTapBehaviorBuilder,\n'
        '    exitWidgetSelectionButtonBuilder: defaultExitBuilder,\n'
        '    moveExitWidgetSelectionButtonBuilder: defaultMoveExitBuilder,\n'
        '    child: plain,\n'
        '  );\n'
        '}',
    icon: Icons.route,
    accent: Color(0xFFEF6C00),
  ),
  _WiMagRecipe(
    title: 'Enable on release, behind a flag',
    summary:
        'Gated release builds for QA can opt into the inspector by reading a '
        'runtime flag. Do NOT ship this to end users — the inspector exposes '
        'diagnostic APIs that leak implementation details.',
    snippet:
        'if (RemoteFlags.qaInspector) {\n'
        '  WidgetsBinding.instance.debugShowWidgetInspectorOverride = true;\n'
        '}\n'
        '// wrap top-level like:\n'
        'return WidgetInspector(\n'
        '  tapBehaviorButtonBuilder: null,\n'
        '  exitWidgetSelectionButtonBuilder: null,\n'
        '  moveExitWidgetSelectionButtonBuilder: null,\n'
        '  child: app,\n'
        ');',
    icon: Icons.verified_user,
    accent: Color(0xFFE53935),
  ),
  _WiMagRecipe(
    title: 'Null builders for "button-less" inspector',
    summary:
        'All three builder fields are nullable. Pass null when you only '
        'want selection highlights — the inspector still paints the halo, '
        'but no overlay controls are rendered. Useful for screenshots.',
    snippet:
        'WidgetInspector(\n'
        '  tapBehaviorButtonBuilder: null,\n'
        '  exitWidgetSelectionButtonBuilder: null,\n'
        '  moveExitWidgetSelectionButtonBuilder: null,\n'
        '  child: subtree,\n'
        ');',
    icon: Icons.hide_source,
    accent: Color(0xFF0D9488),
  ),
  _WiMagRecipe(
    title: 'Forward selections into an observer',
    summary:
        'Bridge inspector selections into your own logging / telemetry '
        'store by subscribing to WidgetInspectorService.instance.selection. '
        'This is how DevTools-free dashboards are built.',
    snippet:
        'final sel = WidgetInspectorService.instance.selection;\n'
        'sel.addListener(() {\n'
        '  final el = sel.currentElement;\n'
        '  analytics.log(\'inspector.pick\', {\'widget\': el?.widget.runtimeType.toString()});\n'
        '});',
    icon: Icons.podcasts,
    accent: Color(0xFF1D4ED8),
  ),
];

class _WiMagRecipes extends StatelessWidget {
  const _WiMagRecipes();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.menu_book, color: _wiMagMidnight),
              SizedBox(width: 8),
              Text(
                '§8 Recipe cards',
                style: TextStyle(
                  color: _wiMagMidnight,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Six patterns that keep the inspector useful without polluting '
            'production code. Each one can be lifted verbatim.',
            style: TextStyle(
              color: _wiMagInk,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (BuildContext c, BoxConstraints cons) {
              final int cols = cons.maxWidth > 820 ? 2 : 1;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  for (final _WiMagRecipe r in _wiMagRecipes)
                    SizedBox(
                      width: cols == 2
                          ? (cons.maxWidth - 12) / 2
                          : cons.maxWidth,
                      child: _WiMagRecipeCard(recipe: r),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WiMagRecipeCard extends StatelessWidget {
  final _WiMagRecipe recipe;
  const _WiMagRecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _wiMagPaper,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: recipe.accent.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: recipe.accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(recipe.icon, color: recipe.accent, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  recipe.title,
                  style: const TextStyle(
                    color: _wiMagMidnight,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            recipe.summary,
            style: const TextStyle(
              color: _wiMagInk,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _wiMagMidnight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              recipe.snippet,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: recipe.accent,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// SECTION 9 — Glossary / epilogue
// ═════════════════════════════════════════════════════════════════════

class _WiMagGlossaryEntry {
  final String term;
  final String definition;
  final IconData icon;
  const _WiMagGlossaryEntry({
    required this.term,
    required this.definition,
    required this.icon,
  });
}

const List<_WiMagGlossaryEntry> _wiMagGlossary = <_WiMagGlossaryEntry>[
  _WiMagGlossaryEntry(
    term: 'WidgetInspector',
    definition:
        'Stateful widget in package:flutter/src/widgets/widget_inspector.dart '
        'that wraps a subtree and intercepts pointer events so the user can '
        'pick a widget by tapping its pixels.',
    icon: Icons.travel_explore,
  ),
  _WiMagGlossaryEntry(
    term: 'WidgetInspectorService',
    definition:
        'Singleton that holds inspector state: selection, notifier for the '
        'selection change stream, VM-service extensions, tree serialisation '
        'for DevTools.',
    icon: Icons.settings_suggest,
  ),
  _WiMagGlossaryEntry(
    term: 'InspectorSelection',
    definition:
        'ChangeNotifier whose currentElement / currentPosition / candidates '
        'drive the selection halo and the DevTools widget-tree cursor.',
    icon: Icons.ads_click,
  ),
  _WiMagGlossaryEntry(
    term: 'debugShowWidgetInspectorOverride',
    definition:
        'Binding-level bool that DevTools flips to toggle whether the '
        'inspector is active. Observed via '
        'debugShowWidgetInspectorOverrideNotifier.',
    icon: Icons.toggle_on,
  ),
  _WiMagGlossaryEntry(
    term: 'ExitWidgetSelectionButtonBuilder',
    definition:
        'Typedef for the builder that produces the "leave select mode" '
        'control. Receives {onPressed, semanticsLabel, key}.',
    icon: Icons.close,
  ),
  _WiMagGlossaryEntry(
    term: 'MoveExitWidgetSelectionButtonBuilder',
    definition:
        'Typedef for the builder that produces the "move exit button '
        'corner" control. Receives {onPressed, semanticsLabel, '
        'usesDefaultAlignment}.',
    icon: Icons.swap_horiz,
  ),
  _WiMagGlossaryEntry(
    term: 'TapBehaviorButtonBuilder',
    definition:
        'Typedef for the builder that produces the "toggle '
        'selectionOnTap" control. Receives {onPressed, semanticsLabel, '
        'selectionOnTapEnabled}.',
    icon: Icons.ads_click,
  ),
  _WiMagGlossaryEntry(
    term: 'RenderWidgetInspector',
    definition:
        'The private render object that hit-tests the subtree and paints '
        'the halo. Not publicly constructible — it is internal to the '
        'widget.',
    icon: Icons.grid_view,
  ),
  _WiMagGlossaryEntry(
    term: 'Selection halo',
    definition:
        'Red-on-red outline painted over the picked widget\'s bounds. In '
        'this demo it is drawn with an AnimationController-driven '
        'CustomPainter to visualise the pulsing effect.',
    icon: Icons.photo_filter,
  ),
];

class _WiMagGlossary extends StatelessWidget {
  const _WiMagGlossary();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _wiMagPaper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.menu_book, color: _wiMagBrassDeep),
              SizedBox(width: 8),
              Text(
                '§9 Glossary & epilogue',
                style: TextStyle(
                  color: _wiMagBrassDeep,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final _WiMagGlossaryEntry e in _wiMagGlossary)
            _WiMagGlossaryRow(entry: e),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _wiMagMidnight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.travel_explore, color: _wiMagBrass),
                const SizedBox(width: 10),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        height: 1.5,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Epilogue — ',
                          style: TextStyle(
                            color: _wiMagBrass,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text:
                              'WidgetInspector is a debug-only lens on the '
                              'widget tree. It feels magical because taps '
                              'pierce through the UI to pick exactly one '
                              'render object, but underneath it is just a '
                              'wrapper around a hit-test, a selection '
                              'notifier, and three nullable button builders. '
                              'Customise the builders to match your brand, '
                              'feed the selections into your telemetry, and '
                              'wrap only the subtrees that benefit from '
                              'inspection.',
                        ),
                      ],
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

class _WiMagGlossaryRow extends StatelessWidget {
  final _WiMagGlossaryEntry entry;
  const _WiMagGlossaryRow({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wiMagBrass.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _wiMagBrass.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(entry.icon, color: _wiMagBrassDeep, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.term,
                  style: const TextStyle(
                    color: _wiMagMidnight,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.definition,
                  style: const TextStyle(
                    color: _wiMagInk,
                    fontSize: 12.5,
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
}
