// SlottedMultiChildRenderObjectWidgetMixin<SlotType, ChildType> — widget-tier
// mixin demo.
//
// File 414 of a 4-file cluster:
//   * 413 — SlottedContainerRenderObjectMixin         (render-object tier)
//   * 414 — SlottedMultiChildRenderObjectWidgetMixin  (widget tier; THIS FILE)
//   * 415 — a concrete SlottedMultiChildRenderObjectWidget
//   * 416 — SlottedRenderObjectElement                (element tier)
//
// This file stays strictly on the WIDGET-MIXIN side: we show what the mixin
// asks a widget to provide, how `slots` + `childForSlot` are consumed by the
// matching element, and how `createRenderObject` / `updateRenderObject` wire
// into a render-object that uses SlottedContainerRenderObjectMixin. We do
// implement a small working render-object because the widget mixin is useless
// without one, but the visual framing keeps the focus on the widget side of
// the binding contract.
//
// Theme: "Widget-Side Slot Binding" — purple / mint / warm-white binding-panel
// aesthetic with sockets, plugs, and labeled connectors drawn in
// CustomPainters.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// -----------------------------------------------------------------------------
//  Palette
// -----------------------------------------------------------------------------

const Color _smcrowmPurple = Color(0xFF6B2C91);
const Color _smcrowmPurpleDeep = Color(0xFF4A1D66);
const Color _smcrowmPurpleSoft = Color(0xFFB089CF);
const Color _smcrowmMint = Color(0xFF3FD8A0);
const Color _smcrowmMintDeep = Color(0xFF1E9E73);
const Color _smcrowmWarm = Color(0xFFF9F5F2);
const Color _smcrowmWarmDark = Color(0xFFE4DAD1);
const Color _smcrowmInk = Color(0xFF231A2A);
const Color _smcrowmInkSoft = Color(0xFF4D3A5E);

// -----------------------------------------------------------------------------
//  Entry point — d4rt AST harness
// -----------------------------------------------------------------------------

/// Top-level entry required by the d4rt AST harness. No `main()` and no
/// `runApp()` — the harness drives the tree by calling `build(context)` and
/// mounting the returned `MaterialApp`.
dynamic build(BuildContext context) {
  return const _SmcrowmApp();
}

// -----------------------------------------------------------------------------
//  App shell
// -----------------------------------------------------------------------------

class _SmcrowmApp extends StatelessWidget {
  const _SmcrowmApp();

  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _smcrowmWarm,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _smcrowmPurple,
        brightness: Brightness.light,
        primary: _smcrowmPurple,
        secondary: _smcrowmMint,
        surface: _smcrowmWarm,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: _smcrowmInk,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
        titleLarge: TextStyle(
          color: _smcrowmInk,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
        titleMedium: TextStyle(
          color: _smcrowmInk,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: _smcrowmInkSoft,
          height: 1.45,
        ),
        bodySmall: TextStyle(
          color: _smcrowmInkSoft,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          color: _smcrowmInk,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SlottedMultiChildRenderObjectWidgetMixin',
      theme: base,
      home: const _SmcrowmHome(),
    );
  }
}

class _SmcrowmHome extends StatefulWidget {
  const _SmcrowmHome();

  @override
  State<_SmcrowmHome> createState() => _SmcrowmHomeState();
}

class _SmcrowmHomeState extends State<_SmcrowmHome> {
  final ScrollController _scroll = ScrollController();
  int _heroHits = 0;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onHeroTapped() {
    setState(() => _heroHits += 1);
    debugPrint('Smcrowm: hero tapped (count=$_heroHits)');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _smcrowmWarm,
      body: Scrollbar(
        controller: _scroll,
        thumbVisibility: true,
        child: CustomScrollView(
          controller: _scroll,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _SmcrowmHero(onTap: _onHeroTapped, taps: _heroHits),
            ),
            const SliverToBoxAdapter(child: _SmcrowmIntroStrip()),
            const SliverToBoxAdapter(child: _SmcrowmContractCard()),
            const SliverToBoxAdapter(child: _SmcrowmLiveBindings()),
            const SliverToBoxAdapter(child: _SmcrowmBindingDiagram()),
            const SliverToBoxAdapter(child: _SmcrowmTabsPanel()),
            const SliverToBoxAdapter(child: _SmcrowmIncorrectVsCorrect()),
            const SliverToBoxAdapter(child: _SmcrowmPitfallCard()),
            const SliverToBoxAdapter(child: _SmcrowmClusterMap()),
            const SliverToBoxAdapter(child: _SmcrowmFooter()),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
//  Hero — animated socket/plug painter
// -----------------------------------------------------------------------------

class _SmcrowmHero extends StatefulWidget {
  const _SmcrowmHero({required this.onTap, required this.taps});

  final VoidCallback onTap;
  final int taps;

  @override
  State<_SmcrowmHero> createState() => _SmcrowmHeroState();
}

class _SmcrowmHeroState extends State<_SmcrowmHero>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[_smcrowmPurpleDeep, _smcrowmPurple],
          ),
          borderRadius: BorderRadius.circular(26),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _smcrowmPurple.withValues(alpha: 0.32),
              blurRadius: 28,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _smcrowmMint.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: _smcrowmMint.withValues(alpha: 0.55),
                    ),
                  ),
                  child: const Text(
                    'FILE 414  ·  WIDGET-TIER MIXIN',
                    style: TextStyle(
                      color: _smcrowmMint,
                      fontSize: 11,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: widget.onTap,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.12),
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.auto_awesome_outlined),
                  tooltip: 'ping the binding panel',
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'SlottedMultiChildRenderObjectWidgetMixin',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.8,
                height: 1.05,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Widget-side of the slotted render-object binding: declare your '
              'slot enum, answer childForSlot(slot), wire the render-object. '
              'The element walks your slots and mounts each child under a '
              'named identity — not a list index.',
              style: TextStyle(
                fontSize: 14.5,
                height: 1.55,
                color: Colors.white.withValues(alpha: 0.88),
              ),
            ),
            const SizedBox(height: 22),
            AspectRatio(
              aspectRatio: 2.7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(color: _smcrowmPurpleDeep),
                    AnimatedBuilder(
                      animation: _ctrl,
                      builder: (BuildContext ctx, Widget? _) {
                        return CustomPaint(
                          painter: _SmcrowmHeroPainter(
                            progress: _ctrl.value,
                            taps: widget.taps,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      left: 18,
                      bottom: 14,
                      child: _smcrowmChipDark('widgets → slots'),
                    ),
                    Positioned(
                      right: 18,
                      top: 14,
                      child: _smcrowmChipMint('childForSlot'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                _SmcrowmHeroStat(
                  label: 'slots getter',
                  value: 'Iterable<SlotType>',
                ),
                const SizedBox(width: 10),
                _SmcrowmHeroStat(
                  label: 'lookup',
                  value: 'childForSlot(slot)',
                ),
                const SizedBox(width: 10),
                _SmcrowmHeroStat(
                  label: 'element',
                  value: 'SlottedRender…Element',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SmcrowmHeroStat extends StatelessWidget {
  const _SmcrowmHeroStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: _smcrowmMint.withValues(alpha: 0.9),
                fontSize: 10,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _smcrowmChipDark(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.88),
        fontFamily: 'monospace',
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _smcrowmChipMint(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: _smcrowmMint.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: _smcrowmMint.withValues(alpha: 0.55)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: _smcrowmMint,
        fontFamily: 'monospace',
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

/// Animated binding-panel painter: a row of widgets on the left plugs into a
/// row of render-object slots on the right, with pulsing signal dots travelling
/// along curved connectors. The metaphor matches `childForSlot` — widget in,
/// slot out.
class _SmcrowmHeroPainter extends CustomPainter {
  _SmcrowmHeroPainter({required this.progress, required this.taps});

  final double progress;
  final int taps;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_smcrowmPurpleDeep, _smcrowmPurple],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    _drawGrid(canvas, size);

    final double leftX = size.width * 0.16;
    final double rightX = size.width * 0.82;
    const int rowCount = 3;
    final double rowGap = size.height / (rowCount + 1);

    // widgets column
    for (int i = 0; i < rowCount; i++) {
      final Offset c = Offset(leftX, rowGap * (i + 1));
      _drawPlug(canvas, c, i);
    }
    // slots column
    for (int i = 0; i < rowCount; i++) {
      final Offset c = Offset(rightX, rowGap * (i + 1));
      _drawSocket(canvas, c, i);
    }

    // connectors
    for (int i = 0; i < rowCount; i++) {
      final Offset a = Offset(leftX + 22, rowGap * (i + 1));
      final Offset b = Offset(rightX - 22, rowGap * (i + 1));
      _drawConnector(canvas, a, b, i);
    }

    // ping radius responds to taps
    final double pingRadius = 12 + (taps % 5) * 3.0;
    final Paint ping = Paint()
      ..color = _smcrowmMint.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (int i = 0; i < rowCount; i++) {
      canvas.drawCircle(
        Offset(leftX, rowGap * (i + 1)),
        pingRadius + progress * 6,
        ping,
      );
    }

    _drawLabels(canvas, size, leftX, rightX);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 0.8;
    const double step = 28;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  void _drawPlug(Canvas canvas, Offset c, int idx) {
    final Paint fill = Paint()
      ..color = _smcrowmMint.withValues(alpha: 0.85);
    final Paint glow = Paint()
      ..color = _smcrowmMint.withValues(alpha: 0.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawCircle(c, 22, glow);
    final Rect body = Rect.fromCenter(center: c, width: 34, height: 28);
    canvas.drawRRect(
      RRect.fromRectAndRadius(body, const Radius.circular(6)),
      fill,
    );
    // three prongs
    final Paint prong = Paint()
      ..color = _smcrowmPurpleDeep;
    for (int p = 0; p < 3; p++) {
      final double dy = (p - 1) * 6.0;
      canvas.drawRect(
        Rect.fromLTWH(c.dx + 12, c.dy + dy - 1.5, 10, 3),
        prong,
      );
    }
    _drawPlugLabel(canvas, Offset(c.dx, c.dy - 24), _plugLabel(idx));
  }

  String _plugLabel(int idx) {
    switch (idx) {
      case 0:
        return 'Text()';
      case 1:
        return 'Column()';
      default:
        return 'FilledButton()';
    }
  }

  void _drawSocket(Canvas canvas, Offset c, int idx) {
    final Paint ring = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(c, 20, ring);
    // prong holes
    final Paint hole = Paint()..color = _smcrowmPurpleDeep;
    for (int p = 0; p < 3; p++) {
      final double dy = (p - 1) * 6.0;
      canvas.drawRect(
        Rect.fromLTWH(c.dx - 14, c.dy + dy - 1.5, 8, 3),
        hole,
      );
    }
    _drawPlugLabel(
      canvas,
      Offset(c.dx, c.dy - 28),
      _slotLabel(idx),
      color: _smcrowmMint,
    );
  }

  String _slotLabel(int idx) {
    switch (idx) {
      case 0:
        return 'slot.title';
      case 1:
        return 'slot.content';
      default:
        return 'slot.action';
    }
  }

  void _drawPlugLabel(
    Canvas canvas,
    Offset c,
    String label, {
    Color color = Colors.white,
  }) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: color.withValues(alpha: 0.92),
          fontFamily: 'monospace',
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();
    tp.paint(canvas, c + Offset(-tp.width / 2, -tp.height / 2));
  }

  void _drawConnector(Canvas canvas, Offset a, Offset b, int idx) {
    final Path p = Path()
      ..moveTo(a.dx, a.dy)
      ..cubicTo(
        a.dx + 80, a.dy,
        b.dx - 80, b.dy,
        b.dx, b.dy,
      );
    final Paint stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..color = _smcrowmPurpleSoft.withValues(alpha: 0.7);
    canvas.drawPath(p, stroke);

    // pulses
    final ui.PathMetric metric = p.computeMetrics().first;
    for (int pulse = 0; pulse < 3; pulse++) {
      final double t =
          (progress + pulse / 3.0 + idx * 0.08).remainder(1.0);
      final ui.Tangent? tan = metric.getTangentForOffset(t * metric.length);
      if (tan == null) continue;
      final Paint dot = Paint()
        ..color = _smcrowmMint.withValues(alpha: 0.9);
      canvas.drawCircle(tan.position, 3.2, dot);
      final Paint aura = Paint()
        ..color = _smcrowmMint.withValues(alpha: 0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(tan.position, 6, aura);
    }
  }

  void _drawLabels(Canvas canvas, Size size, double leftX, double rightX) {
    _drawPlugLabel(
      canvas,
      Offset(leftX, size.height - 16),
      'widgets',
      color: Colors.white.withValues(alpha: 0.7),
    );
    _drawPlugLabel(
      canvas,
      Offset(rightX, size.height - 16),
      'RO slots',
      color: _smcrowmMint.withValues(alpha: 0.8),
    );
  }

  @override
  bool shouldRepaint(covariant _SmcrowmHeroPainter old) =>
      old.progress != progress || old.taps != taps;
}

// -----------------------------------------------------------------------------
//  Intro strip — short description row
// -----------------------------------------------------------------------------

class _SmcrowmIntroStrip extends StatelessWidget {
  const _SmcrowmIntroStrip();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Expanded(
            child: _SmcrowmIntroCell(
              head: 'Not a RenderObject mixin',
              body: 'This mixin is applied to a *Widget*. The matching render-'
                  'object mixin lives in file 413.',
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _SmcrowmIntroCell(
              head: 'Slots are named',
              body: 'Children are identified by a SlotType value — typically '
                  'a small enum — not a list index.',
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _SmcrowmIntroCell(
              head: 'Element walks slots',
              body: 'The element asks the widget for each slot via '
                  'childForSlot(slot) at mount/update time.',
            ),
          ),
        ],
      ),
    );
  }
}

class _SmcrowmIntroCell extends StatelessWidget {
  const _SmcrowmIntroCell({required this.head, required this.body});

  final String head;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _smcrowmWarmDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            head,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: _smcrowmPurple,
              fontSize: 13.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: _smcrowmInkSoft,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
//  Contract card — the four things a user of this mixin must provide
// -----------------------------------------------------------------------------

class _SmcrowmContractCard extends StatelessWidget {
  const _SmcrowmContractCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _smcrowmWarmDark),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _smcrowmInk.withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _smcrowmPurple.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.menu_book_outlined,
                    color: _smcrowmPurple,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Contract — what the mixin asks you to implement',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      color: _smcrowmInk,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const _SmcrowmContractRow(
              member: 'Iterable<SlotType> get slots',
              explanation: 'Returns the identity of every slot the widget may '
                  'expose, in stable order. The element walks this list to '
                  'build child elements.',
            ),
            const _SmcrowmContractRow(
              member: 'Widget? childForSlot(SlotType slot)',
              explanation: 'Lookup from slot identity to the widget that '
                  'currently fills it. Returning null means the slot is empty.',
            ),
            const _SmcrowmContractRow(
              member:
                  'RenderObject createRenderObject(BuildContext context)',
              explanation: 'Instantiates the render-object that uses the '
                  'paired SlottedContainerRenderObjectMixin (file 413).',
            ),
            const _SmcrowmContractRow(
              member:
                  'void updateRenderObject(BuildContext, covariant RenderObject)',
              explanation: 'Pushes non-child configuration changes (colors, '
                  'padding, layout policy) onto the existing render-object.',
              last: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _SmcrowmContractRow extends StatelessWidget {
  const _SmcrowmContractRow({
    required this.member,
    required this.explanation,
    this.last = false,
  });

  final String member;
  final String explanation;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: _smcrowmMint,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _smcrowmPurple.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _smcrowmPurple.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Text(
                    member,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: _smcrowmPurpleDeep,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  explanation,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.5,
                    color: _smcrowmInkSoft,
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

// -----------------------------------------------------------------------------
//  Slot enum + concrete widget applying the mixin
// -----------------------------------------------------------------------------

/// The SlotType parameter. Tiny enum — exactly what the mixin expects. Kept
/// here so the entire contract (enum + widget + RO) is visible on one screen.
enum _BindingSlot { title, content, action }

/// Concrete widget applying the widget-tier mixin.
///
/// Signature highlights:
///   * `with SlottedMultiChildRenderObjectWidgetMixin<_BindingSlot, RenderBox>`
///   * `slots` returns `_BindingSlot.values` verbatim so the order matches the
///     slot declaration order.
///   * `childForSlot` is a plain switch — no list lookups.
///   * `createRenderObject` hands back the working render-object below.
///   * `updateRenderObject` pushes colors / padding onto the existing RO.
class _SmcrowmBindingWidget extends SlottedMultiChildRenderObjectWidget<
    _BindingSlot, RenderBox> {
  const _SmcrowmBindingWidget({
    this.title,
    this.content,
    this.action,
    this.padding = const EdgeInsets.all(14),
    this.spacing = 10.0,
    this.accent = _smcrowmPurple,
    this.surface = Colors.white,
  });

  final Widget? title;
  final Widget? content;
  final Widget? action;
  final EdgeInsets padding;
  final double spacing;
  final Color accent;
  final Color surface;

  // ---------------------------------------------------------------------------
  //  Widget-mixin contract
  // ---------------------------------------------------------------------------

  @override
  Iterable<_BindingSlot> get slots => _BindingSlot.values;

  @override
  Widget? childForSlot(_BindingSlot slot) {
    switch (slot) {
      case _BindingSlot.title:
        return title;
      case _BindingSlot.content:
        return content;
      case _BindingSlot.action:
        return action;
    }
  }

  @override
  SlottedContainerRenderObjectMixin<_BindingSlot, RenderBox> createRenderObject(
    BuildContext context,
  ) {
    return _SmcrowmBindingRender(
      padding: padding,
      spacing: spacing,
      accent: accent,
      surface: surface,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _SmcrowmBindingRender renderObject,
  ) {
    renderObject
      ..padding = padding
      ..spacing = spacing
      ..accent = accent
      ..surface = surface;
  }
}

/// Minimal-but-functional render-object paired with the widget above. It uses
/// `SlottedContainerRenderObjectMixin` — which is file 413's subject, so we
/// keep the body short and on-topic.
class _SmcrowmBindingRender extends RenderBox
    with SlottedContainerRenderObjectMixin<_BindingSlot, RenderBox> {
  _SmcrowmBindingRender({
    required EdgeInsets padding,
    required double spacing,
    required Color accent,
    required Color surface,
  })  : _padding = padding,
        _spacing = spacing,
        _accent = accent,
        _surface = surface;

  EdgeInsets _padding;
  EdgeInsets get padding => _padding;
  set padding(EdgeInsets value) {
    if (_padding == value) return;
    _padding = value;
    markNeedsLayout();
  }

  double _spacing;
  double get spacing => _spacing;
  set spacing(double value) {
    if (_spacing == value) return;
    _spacing = value;
    markNeedsLayout();
  }

  Color _accent;
  Color get accent => _accent;
  set accent(Color value) {
    if (_accent == value) return;
    _accent = value;
    markNeedsPaint();
  }

  Color _surface;
  Color get surface => _surface;
  set surface(Color value) {
    if (_surface == value) return;
    _surface = value;
    markNeedsPaint();
  }

  RenderBox? get _title => childForSlot(_BindingSlot.title);
  RenderBox? get _content => childForSlot(_BindingSlot.content);
  RenderBox? get _action => childForSlot(_BindingSlot.action);

  @override
  Iterable<RenderBox> get children => <RenderBox>[
        ?_title,
        ?_content,
        ?_action,
      ];

  @override
  void performLayout() {
    final double maxW = constraints.maxWidth;
    final double availW =
        (maxW - _padding.horizontal).clamp(0.0, double.infinity);
    final BoxConstraints inner = BoxConstraints(maxWidth: availW);

    double y = _padding.top;
    double width = _padding.horizontal;

    final RenderBox? t = _title;
    if (t != null) {
      t.layout(inner, parentUsesSize: true);
      _setOffset(t, Offset(_padding.left, y));
      y += t.size.height + _spacing;
      width = math.max(width, t.size.width + _padding.horizontal);
    }
    final RenderBox? c = _content;
    if (c != null) {
      c.layout(inner, parentUsesSize: true);
      _setOffset(c, Offset(_padding.left, y));
      y += c.size.height + _spacing;
      width = math.max(width, c.size.width + _padding.horizontal);
    }
    final RenderBox? a = _action;
    if (a != null) {
      a.layout(inner, parentUsesSize: true);
      _setOffset(a, Offset(_padding.left, y));
      y += a.size.height;
      width = math.max(width, a.size.width + _padding.horizontal);
    } else if (y > _padding.top) {
      y -= _spacing;
    }

    size = constraints.constrain(Size(
      math.max(width, _padding.horizontal + 80),
      y + _padding.bottom,
    ));
  }

  void _setOffset(RenderBox child, Offset offset) {
    final BoxParentData pd = child.parentData! as BoxParentData;
    pd.offset = offset;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final Rect bg = offset & size;
    final RRect rr = RRect.fromRectAndRadius(bg, const Radius.circular(14));
    canvas.drawRRect(rr, Paint()..color = _surface);
    // accent stripe
    final Rect stripe = Rect.fromLTWH(offset.dx, offset.dy, 4, size.height);
    canvas.drawRect(stripe, Paint()..color = _accent);
    canvas.drawRRect(
      rr,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = _smcrowmWarmDark,
    );
    for (final RenderBox child in children) {
      final BoxParentData pd = child.parentData! as BoxParentData;
      context.paintChild(child, offset + pd.offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final RenderBox child in children) {
      final BoxParentData pd = child.parentData! as BoxParentData;
      final bool hit = result.addWithPaintOffset(
        offset: pd.offset,
        position: position,
        hitTest: (BoxHitTestResult r, Offset p) {
          return child.hitTest(r, position: p);
        },
      );
      if (hit) return true;
    }
    return false;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    double w = 0;
    for (final RenderBox c in children) {
      w = math.max(w, c.getMinIntrinsicWidth(height));
    }
    return w + _padding.horizontal;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    double w = 0;
    for (final RenderBox c in children) {
      w = math.max(w, c.getMaxIntrinsicWidth(height));
    }
    return w + _padding.horizontal;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _measureHeight(width);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _measureHeight(width);
  }

  double _measureHeight(double width) {
    final double innerW =
        (width - _padding.horizontal).clamp(0.0, double.infinity);
    double h = _padding.vertical;
    int visible = 0;
    for (final RenderBox c in children) {
      h += c.getMaxIntrinsicHeight(innerW);
      visible++;
    }
    if (visible > 1) h += (visible - 1) * _spacing;
    return h;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final double innerW =
        (constraints.maxWidth - _padding.horizontal).clamp(0.0, double.infinity);
    double h = _padding.vertical;
    double w = _padding.horizontal;
    int visible = 0;
    for (final RenderBox c in children) {
      final Size s = c.getDryLayout(BoxConstraints(maxWidth: innerW));
      h += s.height;
      w = math.max(w, s.width + _padding.horizontal);
      visible++;
    }
    if (visible > 1) h += (visible - 1) * _spacing;
    return constraints.constrain(Size(math.max(w, 80), h));
  }
}

// -----------------------------------------------------------------------------
//  Live bindings — three instances of the widget
// -----------------------------------------------------------------------------

class _SmcrowmLiveBindings extends StatelessWidget {
  const _SmcrowmLiveBindings();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _smcrowmSectionHead(
            kicker: 'SECTION 01',
            title: 'Three live bindings, three shapes',
            subtitle: 'Same mixin, same slot enum — different widget contents '
                'wired into each slot.',
          ),
          const SizedBox(height: 12),
          _SmcrowmBindingWidget(
            title: const Text(
              'Title slot',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: _smcrowmInk,
              ),
            ),
            content: const Text(
              'A short Text in the content slot. Notice how the widget lookup '
              'flows through childForSlot(_BindingSlot.content) — no index.',
              style: TextStyle(
                height: 1.5,
                color: _smcrowmInkSoft,
              ),
            ),
            action: Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: _smcrowmPurple,
                ),
                onPressed: () {
                  debugPrint('Smcrowm: action slot A tapped');
                },
                child: const Text('Primary'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _SmcrowmBindingWidget(
            accent: _smcrowmMint,
            title: Row(
              children: const <Widget>[
                Icon(Icons.bolt_rounded, color: _smcrowmMintDeep, size: 18),
                SizedBox(width: 6),
                Text(
                  'Mint-accented binding',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: _smcrowmInk,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _smcrowmBullet('Each slot holds a whole widget, not a string.'),
                _smcrowmBullet('Change `accent` → updateRenderObject runs.'),
                _smcrowmBullet('Change `title` widget → element visits the '
                    'title slot only.'),
              ],
            ),
            action: Wrap(
              spacing: 6,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    debugPrint('Smcrowm: secondary tapped');
                  },
                  child: const Text('Secondary'),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    debugPrint('Smcrowm: tonal tapped');
                  },
                  child: const Text('Tonal'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _SmcrowmBindingWidget(
            accent: _smcrowmInkSoft,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            spacing: 12,
            surface: _smcrowmWarm,
            title: const Text(
              'Minimal: title + content, no action',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: _smcrowmInk,
              ),
            ),
            content: const Text(
              'When childForSlot(_BindingSlot.action) returns null, the slot '
              'stays empty. The element simply does not mount a child there.',
              style: TextStyle(
                color: _smcrowmInkSoft,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _smcrowmBullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 7, right: 8),
          child: SizedBox(
            width: 6,
            height: 6,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: _smcrowmMintDeep,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              height: 1.45,
              color: _smcrowmInkSoft,
              fontSize: 12.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _smcrowmSectionHead({
  required String kicker,
  required String title,
  required String subtitle,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        kicker,
        style: const TextStyle(
          color: _smcrowmPurple,
          letterSpacing: 2,
          fontWeight: FontWeight.w800,
          fontSize: 11,
        ),
      ),
      const SizedBox(height: 3),
      Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: _smcrowmInk,
          letterSpacing: -0.3,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        subtitle,
        style: const TextStyle(
          color: _smcrowmInkSoft,
          height: 1.5,
          fontSize: 13,
        ),
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
//  Binding diagram — widgets column / connectors / slots column
// -----------------------------------------------------------------------------

class _SmcrowmBindingDiagram extends StatelessWidget {
  const _SmcrowmBindingDiagram();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _smcrowmWarmDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _smcrowmSectionHead(
              kicker: 'SECTION 02',
              title: 'Binding diagram',
              subtitle: 'Left: widgets you hand back from childForSlot. '
                  'Right: render-object slots. Purple arcs = the lookup the '
                  'element performs for every slot in the `slots` iterable.',
            ),
            const SizedBox(height: 14),
            AspectRatio(
              aspectRatio: 1.85,
              child: CustomPaint(
                painter: _SmcrowmDiagramPainter(),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Read the diagram in slot order: title first, then content, '
              'then action. The element calls childForSlot(slot) once per '
              'slot, in the order your `slots` iterable yields them.',
              style: TextStyle(
                color: _smcrowmInkSoft,
                height: 1.5,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmcrowmDiagramPainter extends CustomPainter {
  _SmcrowmDiagramPainter();

  static const List<String> _widgetCol = <String>[
    'Text("Title")',
    'Column(children: [...])',
    'FilledButton(...)',
  ];

  static const List<String> _slotCol = <String>[
    '_BindingSlot.title',
    '_BindingSlot.content',
    '_BindingSlot.action',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _smcrowmWarm;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(16),
      ),
      bg,
    );

    final double colLeftX = size.width * 0.12;
    final double colLeftW = size.width * 0.32;
    final double colRightX = size.width * 0.56;
    final double colRightW = size.width * 0.32;

    const int rows = 3;
    final double gap = size.height / (rows + 1);

    // column labels
    _drawHeader(
      canvas,
      Rect.fromLTWH(colLeftX, 10, colLeftW, 22),
      'widgets',
      _smcrowmPurple,
    );
    _drawHeader(
      canvas,
      Rect.fromLTWH(colRightX, 10, colRightW, 22),
      'slots',
      _smcrowmMintDeep,
    );

    for (int i = 0; i < rows; i++) {
      final double y = gap * (i + 1) + 10;
      final Rect lbox =
          Rect.fromCenter(center: Offset(colLeftX + colLeftW / 2, y),
              width: colLeftW, height: 42);
      final Rect rbox =
          Rect.fromCenter(center: Offset(colRightX + colRightW / 2, y),
              width: colRightW, height: 42);
      _drawWidgetBox(canvas, lbox, _widgetCol[i]);
      _drawSlotBox(canvas, rbox, _slotCol[i]);

      // connector
      final Offset a = Offset(lbox.right, y);
      final Offset b = Offset(rbox.left, y);
      final Path p = Path()
        ..moveTo(a.dx, a.dy)
        ..cubicTo(
          a.dx + 40, a.dy,
          b.dx - 40, b.dy,
          b.dx, b.dy,
        );
      final Paint stroke = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..color = _smcrowmPurple.withValues(alpha: 0.85);
      canvas.drawPath(p, stroke);
      // dot endpoints
      canvas.drawCircle(a, 4, Paint()..color = _smcrowmPurple);
      canvas.drawCircle(b, 4, Paint()..color = _smcrowmMintDeep);
      // mid-arrow annotation
      final Offset mid = Offset((a.dx + b.dx) / 2, y - 10);
      _drawAnnotation(canvas, mid, 'childForSlot');
    }
  }

  void _drawHeader(Canvas canvas, Rect rect, String text, Color color) {
    final Paint p = Paint()
      ..color = color.withValues(alpha: 0.14);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(8)),
      p,
    );
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.4,
          fontSize: 11,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, rect.center - Offset(tp.width / 2, tp.height / 2));
  }

  void _drawWidgetBox(Canvas canvas, Rect rect, String label) {
    final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    canvas.drawRRect(
      rr,
      Paint()..color = _smcrowmPurple.withValues(alpha: 0.12),
    );
    canvas.drawRRect(
      rr,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = _smcrowmPurple.withValues(alpha: 0.55),
    );
    _drawLabel(canvas, rect.center, label, _smcrowmPurpleDeep);
  }

  void _drawSlotBox(Canvas canvas, Rect rect, String label) {
    final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    canvas.drawRRect(
      rr,
      Paint()..color = _smcrowmMint.withValues(alpha: 0.18),
    );
    canvas.drawRRect(
      rr,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = _smcrowmMintDeep.withValues(alpha: 0.85),
    );
    _drawLabel(canvas, rect.center, label, _smcrowmMintDeep);
  }

  void _drawLabel(Canvas canvas, Offset c, String label, Color color) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, c - Offset(tp.width / 2, tp.height / 2));
  }

  void _drawAnnotation(Canvas canvas, Offset c, String label) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: _smcrowmInkSoft,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final Rect box = Rect.fromCenter(
      center: c,
      width: tp.width + 10,
      height: tp.height + 6,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(box, const Radius.circular(6)),
      Paint()..color = _smcrowmWarm,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(box, const Radius.circular(6)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = _smcrowmInkSoft.withValues(alpha: 0.35),
    );
    tp.paint(canvas, c - Offset(tp.width / 2, tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant _SmcrowmDiagramPainter old) => false;
}

// -----------------------------------------------------------------------------
//  Tabs panel — four code-quoting tabs
// -----------------------------------------------------------------------------

class _SmcrowmTabsPanel extends StatelessWidget {
  const _SmcrowmTabsPanel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
      child: DefaultTabController(
        length: 4,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _smcrowmWarmDark),
          ),
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _smcrowmSectionHead(
                kicker: 'SECTION 03',
                title: 'Four facets of the widget-mixin contract',
                subtitle: 'Each tab quotes the exact code you would write in '
                    'a real project when applying the mixin.',
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: _smcrowmWarm,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _smcrowmWarmDark),
                ),
                child: const TabBar(
                  labelColor: _smcrowmPurple,
                  unselectedLabelColor: _smcrowmInkSoft,
                  indicatorColor: _smcrowmMintDeep,
                  indicatorWeight: 3,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                  ),
                  tabs: <Widget>[
                    Tab(text: 'Slot enum'),
                    Tab(text: 'Widget constructor'),
                    Tab(text: 'childForSlot body'),
                    Tab(text: 'create / updateRenderObject'),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const SizedBox(
                height: 340,
                child: TabBarView(
                  children: <Widget>[
                    _SmcrowmCodeTile(
                      caption: 'The slot enum — the SlotType generic',
                      code: _slotEnumCode,
                    ),
                    _SmcrowmCodeTile(
                      caption: 'Applying the mixin on a concrete widget',
                      code: _widgetCtorCode,
                    ),
                    _SmcrowmCodeTile(
                      caption: 'childForSlot as a pure switch',
                      code: _childForSlotCode,
                    ),
                    _SmcrowmCodeTile(
                      caption: 'Wiring the paired render-object',
                      code: _createUpdateCode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const String _slotEnumCode = '''
/// The SlotType generic passed into the mixin. Small, total, stable.
enum _BindingSlot { title, content, action }

// Iterable<_BindingSlot> get slots  => _BindingSlot.values;
// The framework visits slots in THIS order; keep it stable across updates.
''';

const String _widgetCtorCode = '''
class _SmcrowmBindingWidget
    extends SlottedMultiChildRenderObjectWidget<_BindingSlot, RenderBox> {
  const _SmcrowmBindingWidget({
    this.title,
    this.content,
    this.action,
    this.padding = const EdgeInsets.all(14),
    this.spacing = 10.0,
    this.accent = _smcrowmPurple,
    this.surface = Colors.white,
  });

  final Widget? title;
  final Widget? content;
  final Widget? action;
  final EdgeInsets padding;
  final double spacing;
  final Color accent;
  final Color surface;

  @override
  Iterable<_BindingSlot> get slots => _BindingSlot.values;
  // childForSlot + createRenderObject on the next tabs.
}
''';

const String _childForSlotCode = '''
@override
Widget? childForSlot(_BindingSlot slot) {
  switch (slot) {
    case _BindingSlot.title:
      return title;
    case _BindingSlot.content:
      return content;
    case _BindingSlot.action:
      return action;
  }
}

// Return null to leave a slot empty — the element will NOT mount a child
// for that slot, and the render-object gets no RenderBox for it either.
''';

const String _createUpdateCode = '''
@override
SlottedContainerRenderObjectMixin<_BindingSlot, RenderBox> createRenderObject(
  BuildContext context,
) {
  return _SmcrowmBindingRender(
    padding: padding,
    spacing: spacing,
    accent: accent,
    surface: surface,
  );
}

@override
void updateRenderObject(
  BuildContext context,
  covariant _SmcrowmBindingRender renderObject,
) {
  renderObject
    ..padding = padding
    ..spacing = spacing
    ..accent = accent
    ..surface = surface;
  // Children are NOT touched here — the element visits childForSlot for each
  // slot and reparents them as needed.
}
''';

class _SmcrowmCodeTile extends StatelessWidget {
  const _SmcrowmCodeTile({required this.caption, required this.code});

  final String caption;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          caption,
          style: const TextStyle(
            color: _smcrowmPurple,
            fontWeight: FontWeight.w700,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 6),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _smcrowmPurpleDeep,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: SelectableText(
                code,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.8,
                  height: 1.45,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
//  Incorrect-vs-correct — indexed MultiChildRenderObjectWidget vs slotted mixin
// -----------------------------------------------------------------------------

class _SmcrowmIncorrectVsCorrect extends StatelessWidget {
  const _SmcrowmIncorrectVsCorrect();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _smcrowmSectionHead(
            kicker: 'SECTION 04',
            title: 'Indexed list vs named slots',
            subtitle: 'The indexed MultiChildRenderObjectWidget on the left '
                'looks similar but is NOT equivalent. Named slots are the '
                'whole point of the mixin.',
          ),
          const SizedBox(height: 12),
          // D7 layout-cascade fix: the original
          // Row(crossAxisAlignment: stretch) sat inside a SliverToBoxAdapter
          // which provides unbounded vertical constraints, so the cross-axis
          // stretch propagated h=Infinity into each Expanded card → "BoxConstraints
          // forces an infinite height" cascade. Removing stretch lets each card
          // size to its content; the cards no longer line up at the bottom but
          // they render correctly. Kept in mind that IntrinsicHeight is the
          // canonical fix under native Flutter, but it routes intrinsic queries
          // through the d4rt proxy pipeline (see C3 in interpreter_unfixable.md)
          // and reproduces the same null-walk under the interpreter.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _SmcrowmDiffCard(
                  tone: _SmcrowmDiffTone.incorrect,
                  label: 'INCORRECT',
                  title: 'MultiChildRenderObjectWidget with indexed lookup',
                  code: _wrongCode,
                  caption: 'Children are identified by position in the list. '
                      'Reordering or optional slots shift every index. The '
                      'render-object has to translate positions back into '
                      'roles, which is brittle and undocumented.',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SmcrowmDiffCard(
                  tone: _SmcrowmDiffTone.correct,
                  label: 'CORRECT',
                  title: 'SlottedMultiChildRenderObjectWidgetMixin with '
                      'named slots',
                  code: _rightCode,
                  caption: 'Slots are named by the SlotType enum. Optional '
                      'slots return null without shifting anything. '
                      'childForSlot reads like a switch table — no index '
                      'arithmetic at any layer.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _SmcrowmDiffTone { correct, incorrect }

const String _wrongCode = '''
// ✗ Indexed layout: positions leak into the render-object.
class BadBindingWidget extends MultiChildRenderObjectWidget {
  const BadBindingWidget({
    Widget? title,
    Widget? content,
    Widget? action,
  }) : super(children: <Widget>[
          if (title   != null) title,
          if (content != null) content,
          if (action  != null) action,
        ]);

  @override
  RenderBadBinding createRenderObject(BuildContext context) =>
      RenderBadBinding();
}

// Render-object now has to guess which child is which:
//   - if 1 child: title? content? action?
//   - if 2 children: which one is which?
// Add a new slot later and every consumer breaks silently.
''';

const String _rightCode = '''
// ✓ Named slots: identity is explicit at every layer.
enum _BindingSlot { title, content, action }

class GoodBindingWidget extends SlottedMultiChildRenderObjectWidget<
    _BindingSlot, RenderBox> {
  const GoodBindingWidget({this.title, this.content, this.action});

  final Widget? title;
  final Widget? content;
  final Widget? action;

  @override
  Iterable<_BindingSlot> get slots => _BindingSlot.values;

  @override
  Widget? childForSlot(_BindingSlot slot) => switch (slot) {
        _BindingSlot.title   => title,
        _BindingSlot.content => content,
        _BindingSlot.action  => action,
      };
  // create/updateRenderObject unchanged — see Section 03.
}
''';

class _SmcrowmDiffCard extends StatelessWidget {
  const _SmcrowmDiffCard({
    required this.tone,
    required this.label,
    required this.title,
    required this.code,
    required this.caption,
  });

  final _SmcrowmDiffTone tone;
  final String label;
  final String title;
  final String code;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final bool good = tone == _SmcrowmDiffTone.correct;
    final Color bar = good ? _smcrowmMintDeep : _smcrowmPurpleDeep;
    final Color tag = good ? _smcrowmMint : _smcrowmPurple;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _smcrowmWarmDark),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: bar,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: tag.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: bar,
                    fontSize: 10,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: _smcrowmInk,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _smcrowmPurpleDeep,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SelectableText(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 11.3,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            caption,
            style: const TextStyle(
              color: _smcrowmInkSoft,
              fontSize: 12.2,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
//  Pitfall card — applied to a Widget, NOT a RenderObject
// -----------------------------------------------------------------------------

class _SmcrowmPitfallCard extends StatelessWidget {
  const _SmcrowmPitfallCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[_smcrowmPurple, _smcrowmPurpleDeep],
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: _smcrowmMint.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _smcrowmMint.withValues(alpha: 0.6),
                    ),
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: _smcrowmMint,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Pitfall — the mixin goes on a WIDGET, not a RenderObject',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _SmcrowmPitfallRow(
              headline: 'Swapping the tiers is silent',
              detail: 'Applying SlottedContainerRenderObjectMixin to a widget '
                  'compiles (the constraints are permissive) but gives you a '
                  'non-functional widget. Likewise, putting '
                  'SlottedMultiChildRenderObjectWidgetMixin on a RenderObject '
                  'gives you garbage. Remember: this file is 414, not 413.',
            ),
            _SmcrowmPitfallRow(
              headline: 'Do not touch children in updateRenderObject',
              detail: 'Children are owned by the element — it calls '
                  'childForSlot(slot) and manages mounts/unmounts itself. '
                  'updateRenderObject should only push non-child configuration '
                  '(colors, padding, layout policy).',
            ),
            _SmcrowmPitfallRow(
              headline: 'slots must be stable in order, but may change contents',
              detail: 'Returning a new Iterable order across rebuilds '
                  'confuses the element. Keep `slots` pointing at a constant '
                  'iterable (typically the enum’s values), and let '
                  'childForSlot reflect null for absent children.',
              last: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _SmcrowmPitfallRow extends StatelessWidget {
  const _SmcrowmPitfallRow({
    required this.headline,
    required this.detail,
    this.last = false,
  });

  final String headline;
  final String detail;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 10),
            child: Icon(
              Icons.chevron_right_rounded,
              color: _smcrowmMint,
              size: 18,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  headline,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.82),
                    fontSize: 12.3,
                    height: 1.5,
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

// -----------------------------------------------------------------------------
//  Cluster map — show all 4 cluster files and which this one is
// -----------------------------------------------------------------------------

class _SmcrowmClusterMap extends StatelessWidget {
  const _SmcrowmClusterMap();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _smcrowmWarmDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _smcrowmSectionHead(
              kicker: 'CLUSTER',
              title: 'Where this file sits in the 4-file cluster',
              subtitle: 'Each file stays on its own tier. This file never '
                  'strays into the render-object or element tiers — those '
                  'have their own demos in 413 and 416.',
            ),
            const SizedBox(height: 12),
            const _SmcrowmClusterRow(
              index: '413',
              title: 'SlottedContainerRenderObjectMixin',
              tagline: 'Render-object tier — mounts/unmounts RenderBox '
                  'children by slot, exposes `children`, `childForSlot`.',
            ),
            _SmcrowmClusterRow(
              index: '414',
              title: 'SlottedMultiChildRenderObjectWidgetMixin',
              tagline: 'Widget tier — this file. Defines slots + '
                  'childForSlot, creates and updates the paired RO.',
              highlighted: true,
            ),
            const _SmcrowmClusterRow(
              index: '415',
              title: 'A concrete SlottedMultiChildRenderObjectWidget',
              tagline: 'Worked example of the widget above applied end-to-'
                  'end, with example layouts and children.',
            ),
            const _SmcrowmClusterRow(
              index: '416',
              title: 'SlottedRenderObjectElement',
              tagline: 'Element tier — owns the actual Element children and '
                  'drives childForSlot lookups during update.',
              last: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _SmcrowmClusterRow extends StatelessWidget {
  const _SmcrowmClusterRow({
    required this.index,
    required this.title,
    required this.tagline,
    this.highlighted = false,
    this.last = false,
  });

  final String index;
  final String title;
  final String tagline;
  final bool highlighted;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final Color base = highlighted ? _smcrowmMint : _smcrowmPurple;
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: highlighted
              ? _smcrowmMint.withValues(alpha: 0.12)
              : _smcrowmWarm,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: base.withValues(alpha: highlighted ? 0.55 : 0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: base.withValues(alpha: highlighted ? 0.9 : 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                index,
                style: TextStyle(
                  color: highlighted ? _smcrowmPurpleDeep : base,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: _smcrowmInk,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (highlighted)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _smcrowmMintDeep,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'YOU ARE HERE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tagline,
                    style: const TextStyle(
                      color: _smcrowmInkSoft,
                      fontSize: 12.2,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
//  Footer
// -----------------------------------------------------------------------------

class _SmcrowmFooter extends StatelessWidget {
  const _SmcrowmFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _smcrowmPurpleDeep,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _smcrowmMint.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _smcrowmMint.withValues(alpha: 0.55),
                ),
              ),
              child: const Icon(Icons.flag_outlined, color: _smcrowmMint),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Takeaway',
                    style: TextStyle(
                      color: _smcrowmMint,
                      letterSpacing: 1.5,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'SlottedMultiChildRenderObjectWidgetMixin lets a widget '
                    'declare a small named-slot contract and hand it to an '
                    'element that speaks the matching render-object mixin. '
                    'Keep `slots` stable, let childForSlot speak the full '
                    'identity, and never touch children in updateRenderObject.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
