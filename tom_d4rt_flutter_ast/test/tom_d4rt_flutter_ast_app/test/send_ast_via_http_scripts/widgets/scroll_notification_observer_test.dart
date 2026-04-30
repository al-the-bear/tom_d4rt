import 'dart:math' as math;

import 'package:flutter/material.dart';

// =============================================================================
// ScrollNotificationObserver — Tree-wide Scroll Broadcast
// -----------------------------------------------------------------------------
// A single observer inserted high in the tree receives ScrollNotifications from
// every scrollable descendant. Subscribers anywhere beneath the observer can
// react without sharing ScrollControllers or wrapping every scrollable in a
// NotificationListener. This demo paints that superpower across ten panels.
// =============================================================================

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------
const Color _indigo = Color(0xFF3730A3);
const Color _indigoDeep = Color(0xFF1E1B4B);
const Color _gold = Color(0xFFF59E0B);
const Color _goldSoft = Color(0xFFFCD34D);
const Color _cream = Color(0xFFFFF8E7);
const Color _creamDeep = Color(0xFFFDEBC8);
const Color _charcoal = Color(0xFF111827);
const Color _charcoalSoft = Color(0xFF374151);
const Color _mistyIndigo = Color(0xFFE0E7FF);

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollNotificationObserver Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _indigo,
      scaffoldBackgroundColor: _cream,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _charcoal, height: 1.45),
        titleLarge: TextStyle(
          color: _indigoDeep,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    home: const _BroadcastHomePage(),
  );
}

// ---------------------------------------------------------------------------
// Home page: scrolls vertically through the ten teaching sections.
// ---------------------------------------------------------------------------
class _BroadcastHomePage extends StatefulWidget {
  const _BroadcastHomePage();

  @override
  State<_BroadcastHomePage> createState() => _BroadcastHomePageState();
}

class _BroadcastHomePageState extends State<_BroadcastHomePage> {
  final ScrollController _pageController = ScrollController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: const _GentleScrollBehavior(),
          child: ListView(
            controller: _pageController,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            children: const <Widget>[
              _SectionHeroHeader(),
              SizedBox(height: 36),
              _SectionBigPictureDiagram(),
              SizedBox(height: 36),
              _SectionScaffoldLikeLayout(),
              SizedBox(height: 36),
              _SectionMultiScrollableSubtree(),
              SizedBox(height: 36),
              _SectionSubscriptionLifecycle(),
              SizedBox(height: 36),
              _SectionEventLogPanel(),
              SizedBox(height: 36),
              _SectionTeachingTiles(),
              SizedBox(height: 36),
              _SectionWhenToUseMatrix(),
              SizedBox(height: 36),
              _SectionCodeSnippetPanel(),
              SizedBox(height: 36),
              _SectionFooterSummary(),
              SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}

class _GentleScrollBehavior extends ScrollBehavior {
  const _GentleScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: _indigo,
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1 — Hero header with broadcast tower
// ---------------------------------------------------------------------------
class _SectionHeroHeader extends StatelessWidget {
  const _SectionHeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_indigoDeep, _indigo, Color(0xFF6366F1)],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _indigoDeep.withValues(alpha: 0.35),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(
              painter: _BroadcastWavesPainter(),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const _BroadcastTower(),
              const SizedBox(width: 28),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _gold.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: _gold.withValues(alpha: 0.5),
                        ),
                      ),
                      child: const Text(
                        'Flutter Widgets • Deep Dive',
                        style: TextStyle(
                          color: _goldSoft,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'ScrollNotificationObserver',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'listen to scrolls anywhere in your subtree',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.82),
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: const <Widget>[
                        _HeroBadge(label: 'Broadcast'),
                        SizedBox(width: 8),
                        _HeroBadge(label: 'No controllers'),
                        SizedBox(width: 8),
                        _HeroBadge(label: 'Opt-in'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _BroadcastTower extends StatelessWidget {
  const _BroadcastTower();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 260,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // Ground plate
          Positioned(
            bottom: 0,
            child: Container(
              width: 130,
              height: 18,
              decoration: BoxDecoration(
                color: _charcoalSoft.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          // Tower legs (tapered)
          CustomPaint(
            size: const Size(130, 260),
            painter: _TowerFramePainter(),
          ),
          // Antenna peak
          Positioned(
            top: 0,
            child: Container(
              width: 8,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[_gold, _goldSoft],
                ),
                borderRadius: BorderRadius.circular(4),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _gold.withValues(alpha: 0.6),
                    blurRadius: 14,
                  ),
                ],
              ),
            ),
          ),
          // Concentric signal arcs
          Positioned(
            top: 6,
            child: CustomPaint(
              size: const Size(260, 160),
              painter: _SignalArcsPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TowerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint stroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.85)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final double topLeft = size.width * 0.42;
    final double topRight = size.width * 0.58;
    final double botLeft = size.width * 0.12;
    final double botRight = size.width * 0.88;
    final double topY = 48;
    final double botY = size.height - 18;

    canvas.drawLine(Offset(topLeft, topY), Offset(botLeft, botY), stroke);
    canvas.drawLine(Offset(topRight, topY), Offset(botRight, botY), stroke);

    // Cross-beams
    final int steps = 6;
    for (int i = 1; i <= steps; i++) {
      final double t = i / (steps + 1);
      final double lx = topLeft + (botLeft - topLeft) * t;
      final double rx = topRight + (botRight - topRight) * t;
      final double y = topY + (botY - topY) * t;
      canvas.drawLine(Offset(lx, y), Offset(rx, y), stroke);
      if (i % 2 == 0) {
        canvas.drawLine(Offset(lx, y - 14), Offset(rx, y), stroke);
      } else {
        canvas.drawLine(Offset(rx, y - 14), Offset(lx, y), stroke);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TowerFramePainter oldDelegate) => false;
}

class _SignalArcsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;

    final Offset center = Offset(size.width / 2, size.height + 30);
    for (int i = 0; i < 5; i++) {
      final double radius = 50.0 + i * 22.0;
      arcPaint.color = _goldSoft.withValues(alpha: 0.7 - i * 0.12);
      final Rect rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, math.pi + 0.4, math.pi - 0.8, false, arcPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SignalArcsPainter oldDelegate) => false;
}

class _BroadcastWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = Colors.white.withValues(alpha: 0.07);
    for (int i = 0; i < 8; i++) {
      final double y = (size.height / 9) * (i + 1);
      final Path path = Path()..moveTo(0, y);
      for (double x = 0; x < size.width; x += 8) {
        path.lineTo(x, y + math.sin(x * 0.04 + i) * 4);
      }
      canvas.drawPath(path, p);
    }
  }

  @override
  bool shouldRepaint(covariant _BroadcastWavesPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Section 2 — Big picture diagram
// ---------------------------------------------------------------------------
class _SectionBigPictureDiagram extends StatelessWidget {
  const _SectionBigPictureDiagram();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: '02',
      title: 'Big picture: one observer, many listeners',
      subtitle:
          'The observer sits above scrollables and subscribers alike. '
          'Notifications bubble up, then the observer fans them out.',
      child: SizedBox(
        height: 360,
        child: CustomPaint(
          painter: _TreeDiagramPainter(),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: _DiagramNode(
                    label: 'ScrollNotificationObserver',
                    color: _indigo,
                    icon: Icons.hub_outlined,
                    wide: true,
                  ),
                ),
              ),
              const Positioned(
                top: 110,
                left: 0,
                right: 0,
                child: Center(
                  child: _DiagramNode(
                    label: 'Column',
                    color: _charcoalSoft,
                    icon: Icons.view_week_outlined,
                  ),
                ),
              ),
              const Positioned(
                bottom: 16,
                left: 8,
                child: _DiagramNode(
                  label: 'AppBarLike',
                  color: _gold,
                  icon: Icons.menu_outlined,
                ),
              ),
              const Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: _DiagramNode(
                    label: 'SubscribedListView',
                    color: _indigo,
                    icon: Icons.list_alt_outlined,
                  ),
                ),
              ),
              const Positioned(
                bottom: 16,
                right: 8,
                child: _DiagramNode(
                  label: 'FabLike',
                  color: _gold,
                  icon: Icons.add_circle_outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiagramNode extends StatelessWidget {
  const _DiagramNode({
    required this.label,
    required this.color,
    required this.icon,
    this.wide = false,
  });

  final String label;
  final Color color;
  final IconData icon;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wide ? 260 : 150,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _TreeDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = _indigo.withValues(alpha: 0.55)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    final Paint arrow = Paint()
      ..color = _gold
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final double cx = size.width / 2;
    // Observer -> Column
    canvas.drawLine(Offset(cx, 46), Offset(cx, 110), line);
    // Column -> three children
    final double colBottom = 150;
    final double childTop = size.height - 56;
    canvas.drawLine(Offset(cx, colBottom), Offset(96, childTop), line);
    canvas.drawLine(Offset(cx, colBottom), Offset(cx, childTop), line);
    canvas.drawLine(
      Offset(cx, colBottom),
      Offset(size.width - 96, childTop),
      line,
    );

    // Arrows from scrollables back up to observer (dashed, gold)
    _drawDashedLine(
      canvas,
      Offset(cx, childTop + 14),
      Offset(cx + 10, 30),
      arrow,
    );

    // Arrows from observer outward to subscribers (solid, gold)
    final Paint solid = Paint()
      ..color = _gold
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(cx - 100, 28), Offset(96, childTop - 6), solid);
    canvas.drawLine(
      Offset(cx + 100, 28),
      Offset(size.width - 96, childTop - 6),
      solid,
    );
  }

  void _drawDashedLine(Canvas canvas, Offset a, Offset b, Paint paint) {
    final double total = (b - a).distance;
    const double dash = 8;
    const double gap = 5;
    final Offset dir = (b - a) / total;
    double drawn = 0;
    while (drawn < total) {
      final Offset start = a + dir * drawn;
      final double end = math.min(drawn + dash, total);
      canvas.drawLine(start, a + dir * end, paint);
      drawn = end + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _TreeDiagramPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Section 3 — Scaffold-like layout with 4 subscribers
// ---------------------------------------------------------------------------
class _SectionScaffoldLikeLayout extends StatelessWidget {
  const _SectionScaffoldLikeLayout();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: '03',
      title: 'Scaffold-style chrome reacts to deep scrolling',
      subtitle:
          'CollapsingAppBar, ListView, floating button and status bar all '
          'subscribe to ONE observer at the top of this panel.',
      child: SizedBox(
        height: 520,
        child: ScrollNotificationObserver(
          child: _ScaffoldLikeShell(),
        ),
      ),
    );
  }
}

class _ScaffoldLikeShell extends StatelessWidget {
  const _ScaffoldLikeShell();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _mistyIndigo),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                const _CollapsingAppBarLike(),
                const Expanded(child: _TileListView()),
                const _ScrollStatusBar(),
              ],
            ),
            const Positioned(
              right: 20,
              bottom: 60,
              child: _FloatingFabLike(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollapsingAppBarLike extends StatefulWidget {
  const _CollapsingAppBarLike();

  @override
  State<_CollapsingAppBarLike> createState() => _CollapsingAppBarLikeState();
}

class _CollapsingAppBarLikeState extends State<_CollapsingAppBarLike> {
  ScrollNotificationObserverState? _obs;
  double _pixels = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _obs?.removeListener(_onScroll);
    _obs = ScrollNotificationObserver.of(context);
    _obs?.addListener(_onScroll);
  }

  @override
  void dispose() {
    _obs?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll(ScrollNotification n) {
    if (n.metrics.axis != Axis.vertical) return;
    final double px = n.metrics.pixels.clamp(0.0, 300.0);
    if ((px - _pixels).abs() > 0.5) {
      setState(() => _pixels = px);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double t = (_pixels / 300.0).clamp(0.0, 1.0);
    final double height = 120 - 56 * t;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOut,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color.lerp(_indigoDeep, _indigo, t) ?? _indigo,
            Color.lerp(_indigo, const Color(0xFF6366F1), t) ?? _indigo,
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8 + 4 * (1 - t)),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.menu,
            color: Colors.white.withValues(alpha: 0.9),
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Tree-wide broadcast',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 - 2 * t,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (t < 0.6) ...<Widget>[
                  const SizedBox(height: 2),
                  Text(
                    'scroll to collapse the app bar',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.72),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _gold.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${_pixels.toStringAsFixed(0)} px',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TileListView extends StatelessWidget {
  const _TileListView();

  @override
  Widget build(BuildContext context) {
    const List<Color> palette = <Color>[
      _indigo,
      _gold,
      _charcoalSoft,
      Color(0xFF0EA5E9),
      Color(0xFF10B981),
      Color(0xFFEF4444),
      Color(0xFFA855F7),
    ];
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      itemCount: 40,
      itemBuilder: (BuildContext c, int i) {
        final Color col = palette[i % palette.length];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: col.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: col.withValues(alpha: 0.32)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: col,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Scroll row ${i + 1}',
                      style: const TextStyle(
                        color: _charcoal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Observer catches every frame of this list',
                      style: TextStyle(
                        color: _charcoalSoft.withValues(alpha: 0.7),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.drag_indicator, color: col.withValues(alpha: 0.6)),
            ],
          ),
        );
      },
    );
  }
}

class _FloatingFabLike extends StatefulWidget {
  const _FloatingFabLike();

  @override
  State<_FloatingFabLike> createState() => _FloatingFabLikeState();
}

class _FloatingFabLikeState extends State<_FloatingFabLike> {
  ScrollNotificationObserverState? _obs;
  bool _scrolling = false;
  double _pixels = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _obs?.removeListener(_onScroll);
    _obs = ScrollNotificationObserver.of(context);
    _obs?.addListener(_onScroll);
  }

  @override
  void dispose() {
    _obs?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll(ScrollNotification n) {
    if (n is ScrollStartNotification) {
      setState(() => _scrolling = true);
    } else if (n is ScrollEndNotification) {
      setState(() => _scrolling = false);
    } else if (n is ScrollUpdateNotification) {
      final double px = n.metrics.pixels;
      if ((px - _pixels).abs() > 1) {
        setState(() => _pixels = px);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showArrow = _pixels > 400;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 220),
      opacity: _scrolling ? 0.3 : 1.0,
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[_gold, _goldSoft],
          ),
          shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _gold.withValues(alpha: 0.45),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          transitionBuilder: (Widget w, Animation<double> a) =>
              ScaleTransition(scale: a, child: w),
          child: Icon(
            showArrow ? Icons.arrow_upward : Icons.add,
            key: ValueKey<bool>(showArrow),
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}

class _ScrollStatusBar extends StatefulWidget {
  const _ScrollStatusBar();

  @override
  State<_ScrollStatusBar> createState() => _ScrollStatusBarState();
}

class _ScrollStatusBarState extends State<_ScrollStatusBar> {
  ScrollNotificationObserverState? _obs;
  double _pixels = 0;
  double _maxExtent = 0;
  String _phase = 'idle';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _obs?.removeListener(_onScroll);
    _obs = ScrollNotificationObserver.of(context);
    _obs?.addListener(_onScroll);
  }

  @override
  void dispose() {
    _obs?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll(ScrollNotification n) {
    setState(() {
      _pixels = n.metrics.pixels;
      _maxExtent = n.metrics.maxScrollExtent;
      if (n is ScrollStartNotification) {
        _phase = 'start';
      } else if (n is ScrollUpdateNotification) {
        _phase = 'update';
      } else if (n is ScrollEndNotification) {
        _phase = 'end';
      } else if (n is OverscrollNotification) {
        _phase = 'overscroll';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double pct = _maxExtent > 0
        ? (_pixels / _maxExtent).clamp(0.0, 1.0)
        : 0.0;
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _charcoal,
        border: Border(
          top: BorderSide(color: _indigo.withValues(alpha: 0.4), width: 1),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.signal_cellular_alt,
            color: _gold.withValues(alpha: 0.9),
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            'phase: $_phase',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: pct,
                minHeight: 6,
                backgroundColor: Colors.white.withValues(alpha: 0.12),
                valueColor: const AlwaysStoppedAnimation<Color>(_gold),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${_pixels.toStringAsFixed(0)} / ${_maxExtent.toStringAsFixed(0)}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              fontSize: 11.5,
              fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4 — Multi-scrollable subtree (horizontal + vertical)
// ---------------------------------------------------------------------------
class _SectionMultiScrollableSubtree extends StatelessWidget {
  const _SectionMultiScrollableSubtree();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: '04',
      title: 'The observer sees every descendant scrollable',
      subtitle:
          'A horizontal carousel nested in a vertical list — the observer '
          'distinguishes them via axis and metrics hash.',
      child: SizedBox(
        height: 500,
        child: ScrollNotificationObserver(
          child: const _MultiSourcePanel(),
        ),
      ),
    );
  }
}

class _MultiSourcePanel extends StatelessWidget {
  const _MultiSourcePanel();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const Expanded(flex: 3, child: _NestedListsArea()),
            Container(width: 1, color: _mistyIndigo),
            const Expanded(flex: 2, child: _AxisAwareLog()),
          ],
        ),
      ),
    );
  }
}

class _NestedListsArea extends StatelessWidget {
  const _NestedListsArea();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: 22,
      itemBuilder: (BuildContext c, int i) {
        if (i == 3) {
          return const _HorizontalCarousel(label: 'Featured scrollable A');
        }
        if (i == 10) {
          return const _HorizontalCarousel(label: 'Featured scrollable B');
        }
        return _vTile(i);
      },
    );
  }

  Widget _vTile(int i) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 4, 14, 4),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _creamDeep),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.swap_vert, color: _indigo, size: 18),
          const SizedBox(width: 10),
          Text(
            'Vertical row #$i',
            style: const TextStyle(
              color: _charcoal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _HorizontalCarousel extends StatelessWidget {
  const _HorizontalCarousel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: _indigoDeep.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _indigo.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
            child: Row(
              children: <Widget>[
                const Icon(Icons.swap_horiz, color: _gold, size: 18),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: _indigoDeep,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 14,
              itemBuilder: (BuildContext c, int i) => Container(
                width: 80,
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      HSVColor.fromAHSV(1, (i * 26) % 360.0, 0.55, 0.92)
                          .toColor(),
                      HSVColor.fromAHSV(1, (i * 26 + 40) % 360.0, 0.7, 0.7)
                          .toColor(),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AxisAwareLog extends StatefulWidget {
  const _AxisAwareLog();

  @override
  State<_AxisAwareLog> createState() => _AxisAwareLogState();
}

class _AxisAwareLogState extends State<_AxisAwareLog> {
  ScrollNotificationObserverState? _obs;
  int _vCount = 0;
  int _hCount = 0;
  final Set<int> _sources = <int>{};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _obs?.removeListener(_onScroll);
    _obs = ScrollNotificationObserver.of(context);
    _obs?.addListener(_onScroll);
  }

  @override
  void dispose() {
    _obs?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll(ScrollNotification n) {
    final int id = identityHashCode(n.metrics);
    setState(() {
      _sources.add(id);
      if (n.metrics.axis == Axis.vertical) {
        _vCount++;
      } else {
        _hCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: _cream,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Per-axis counters',
            style: TextStyle(
              color: _indigoDeep,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 14),
          _counterRow('Vertical notifications', _vCount, Icons.swap_vert),
          const SizedBox(height: 8),
          _counterRow('Horizontal notifications', _hCount, Icons.swap_horiz),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _indigoDeep,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.fingerprint, color: _goldSoft, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Unique metric sources: ${_sources.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Scroll the inner lists — vertical AND horizontal — and watch '
            'both counters tick independently.',
            style: TextStyle(
              color: _charcoalSoft,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _counterRow(String label, int v, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _mistyIndigo),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: _indigo, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _charcoal,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$v',
            style: const TextStyle(
              color: _indigoDeep,
              fontWeight: FontWeight.w800,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5 — Subscription lifecycle demo (checkbox toggle)
// ---------------------------------------------------------------------------
class _SectionSubscriptionLifecycle extends StatelessWidget {
  const _SectionSubscriptionLifecycle();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: '05',
      title: 'Subscription lifecycle — add, remove, leak',
      subtitle:
          'Toggle the subscriber off to dispose it; its effect halts. Every '
          'subscriber must removeListener in dispose to avoid leaks.',
      child: SizedBox(
        height: 430,
        child: ScrollNotificationObserver(
          child: const _LifecyclePanel(),
        ),
      ),
    );
  }
}

class _LifecyclePanel extends StatefulWidget {
  const _LifecyclePanel();

  @override
  State<_LifecyclePanel> createState() => _LifecyclePanelState();
}

class _LifecyclePanelState extends State<_LifecyclePanel> {
  bool _subscriberActive = true;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(14),
                      itemCount: 35,
                      itemBuilder: (BuildContext c, int i) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: _mistyIndigo.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Lifecycle list item ${i + 1}',
                          style: const TextStyle(
                            color: _charcoal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    color: _cream,
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: _subscriberActive,
                          activeColor: _indigo,
                          onChanged: (bool? v) =>
                              setState(() => _subscriberActive = v ?? false),
                        ),
                        const Expanded(
                          child: Text(
                            'Subscriber mounted (removeListener on unmount)',
                            style: TextStyle(
                              color: _charcoal,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(width: 1, color: _mistyIndigo),
            Expanded(
              flex: 2,
              child: _subscriberActive
                  ? const _LifecycleDot(key: ValueKey<String>('alive'))
                  : const _RetiredBanner(),
            ),
          ],
        ),
      ),
    );
  }
}

class _LifecycleDot extends StatefulWidget {
  const _LifecycleDot({super.key});

  @override
  State<_LifecycleDot> createState() => _LifecycleDotState();
}

class _LifecycleDotState extends State<_LifecycleDot> {
  ScrollNotificationObserverState? _obs;
  int _events = 0;
  double _lastDelta = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _obs?.removeListener(_onScroll);
    _obs = ScrollNotificationObserver.of(context);
    _obs?.addListener(_onScroll);
  }

  @override
  void dispose() {
    // Proper cleanup — without this, the state leaks.
    _obs?.removeListener(_onScroll);
    debugPrint('LifecycleDot disposed; listener removed.');
    super.dispose();
  }

  void _onScroll(ScrollNotification n) {
    if (n is ScrollUpdateNotification) {
      setState(() {
        _events++;
        _lastDelta = n.scrollDelta ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      color: _cream,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Live subscriber',
            style: TextStyle(
              color: _indigoDeep,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[_indigo, _gold],
                ),
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _indigo.withValues(alpha: 0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                '$_events',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _kvRow('events seen', '$_events'),
          _kvRow('last delta', _lastDelta.toStringAsFixed(2)),
          const SizedBox(height: 10),
          const Text(
            'Uncheck the box to dispose this widget; its listener is '
            'removed in dispose().',
            style: TextStyle(color: _charcoalSoft, fontSize: 12, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _kvRow(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              k,
              style: const TextStyle(
                color: _charcoalSoft,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            v,
            style: const TextStyle(
              color: _indigoDeep,
              fontWeight: FontWeight.w800,
              fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _RetiredBanner extends StatelessWidget {
  const _RetiredBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _charcoal,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.power_settings_new,
            color: _gold.withValues(alpha: 0.9),
            size: 54,
          ),
          const SizedBox(height: 12),
          const Text(
            'Subscriber disposed',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'removeListener was called in dispose(). '
            'No more callbacks, no leak.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12.5,
              height: 1.45,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6 — Event log panel
// ---------------------------------------------------------------------------
class _SectionEventLogPanel extends StatelessWidget {
  const _SectionEventLogPanel();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      number: '06',
      title: 'Chronological event log',
      subtitle:
          'The last 30 notifications seen, with type, pixels and source '
          'fingerprint. This is what downstream code reacts to.',
      child: SizedBox(
        height: 500,
        child: ScrollNotificationObserver(
          child: const _LogPanel(),
        ),
      ),
    );
  }
}

class _LogPanel extends StatelessWidget {
  const _LogPanel();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const Expanded(flex: 3, child: _ScrollableForLog()),
            Container(width: 1, color: _mistyIndigo),
            const Expanded(flex: 3, child: _LogStream()),
          ],
        ),
      ),
    );
  }
}

class _ScrollableForLog extends StatelessWidget {
  const _ScrollableForLog();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: 50,
      itemBuilder: (BuildContext c, int i) => Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: i.isEven ? _cream : _creamDeep.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: _indigo,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${i + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Scroll to generate notifications — row ${i + 1}',
                style: const TextStyle(color: _charcoal, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogEntry {
  _LogEntry(this.kind, this.pixels, this.axis, this.sourceId);
  final String kind;
  final double pixels;
  final Axis axis;
  final int sourceId;
}

class _LogStream extends StatefulWidget {
  const _LogStream();

  @override
  State<_LogStream> createState() => _LogStreamState();
}

class _LogStreamState extends State<_LogStream> {
  ScrollNotificationObserverState? _obs;
  final List<_LogEntry> _entries = <_LogEntry>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _obs?.removeListener(_onScroll);
    _obs = ScrollNotificationObserver.of(context);
    _obs?.addListener(_onScroll);
  }

  @override
  void dispose() {
    _obs?.removeListener(_onScroll);
    super.dispose();
  }

  String _kind(ScrollNotification n) {
    if (n is ScrollStartNotification) return 'Start';
    if (n is ScrollUpdateNotification) return 'Update';
    if (n is ScrollEndNotification) return 'End';
    if (n is OverscrollNotification) return 'Overscroll';
    if (n is ScrollMetricsNotification) return 'Metrics';
    return 'Other';
  }

  Color _colorFor(String kind) {
    switch (kind) {
      case 'Start':
        return _indigo;
      case 'Update':
        return _charcoalSoft;
      case 'End':
        return const Color(0xFF10B981);
      case 'Overscroll':
        return const Color(0xFFEF4444);
      case 'Metrics':
        return _gold;
      default:
        return _mistyIndigo;
    }
  }

  void _onScroll(ScrollNotification n) {
    setState(() {
      _entries.insert(
        0,
        _LogEntry(
          _kind(n),
          n.metrics.pixels,
          n.metrics.axis,
          identityHashCode(n.metrics),
        ),
      );
      if (_entries.length > 30) _entries.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _indigoDeep,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.terminal, color: _goldSoft),
              const SizedBox(width: 8),
              const Text(
                'event log',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _gold.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${_entries.length} / 30',
                  style: const TextStyle(
                    color: _goldSoft,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _entries.isEmpty
                ? Center(
                    child: Text(
                      'scroll left panel ->',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _entries.length,
                    itemBuilder: (BuildContext c, int i) {
                      final _LogEntry e = _entries[i];
                      final Color col = _colorFor(e.kind);
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            left: BorderSide(color: col, width: 3),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: col.withValues(alpha: 0.28),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                e.kind,
                                style: TextStyle(
                                  color: col == _charcoalSoft
                                      ? Colors.white
                                      : col,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              e.axis == Axis.vertical
                                  ? Icons.swap_vert
                                  : Icons.swap_horiz,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '${e.pixels.toStringAsFixed(1)} px',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.5,
                                  fontFeatures: <FontFeature>[
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              '#${e.sourceId % 10000}',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 10.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7 — Teaching tiles (prose)
// ---------------------------------------------------------------------------
class _SectionTeachingTiles extends StatelessWidget {
  const _SectionTeachingTiles();

  @override
  Widget build(BuildContext context) {
    const List<_TeachItem> items = <_TeachItem>[
      _TeachItem(
        icon: Icons.hub_outlined,
        title: 'One observer, many subscribers',
        body:
            'No need to pass ScrollControllers around your widget tree. '
            'Descendants opt in by calling of(context).',
      ),
      _TeachItem(
        icon: Icons.call_split,
        title: 'Works across boundaries',
        body:
            'Siblings of the scrollable receive events; they do not need to '
            'be descendants of a shared ScrollController.',
      ),
      _TeachItem(
        icon: Icons.verified_user_outlined,
        title: 'Used by Flutter itself',
        body:
            'Scaffold, AppBar and Material BottomNavigationBar use '
            'ScrollNotificationObserver internally for shadow and elevation.',
      ),
      _TeachItem(
        icon: Icons.refresh,
        title: 'Cheap and decoupled',
        body:
            'The observer multicasts a single notification to every '
            'subscriber — O(subscribers), no extra frame or rebuild cost.',
      ),
      _TeachItem(
        icon: Icons.timeline,
        title: 'Perfect for analytics',
        body:
            'Drop one listener at the root; log scroll depth, velocity and '
            'axis without touching any screen.',
      ),
      _TeachItem(
        icon: Icons.layers,
        title: 'Composable with providers',
        body:
            'Combine with Riverpod, Bloc or InheritedWidgets to turn raw '
            'notifications into derived domain signals.',
      ),
    ];

    return _SectionShell(
      number: '07',
      title: 'Why developers reach for it',
      subtitle: 'Six tiles that summarise everyday wins.',
      child: LayoutBuilder(
        builder: (BuildContext c, BoxConstraints cons) {
          final int cols = cons.maxWidth > 900 ? 3 : 2;
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: cols,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.55,
            children: items
                .map((_TeachItem it) => _TeachingTile(item: it))
                .toList(),
          );
        },
      ),
    );
  }
}

class _TeachItem {
  const _TeachItem({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;
}

class _TeachingTile extends StatelessWidget {
  const _TeachingTile({required this.item});

  final _TeachItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _mistyIndigo),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _indigo.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[_indigo, _indigoDeep],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item.icon, color: _goldSoft, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            item.title,
            style: const TextStyle(
              color: _indigoDeep,
              fontWeight: FontWeight.w800,
              fontSize: 14.5,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              item.body,
              style: const TextStyle(
                color: _charcoalSoft,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8 — When-to-use matrix
// ---------------------------------------------------------------------------
class _SectionWhenToUseMatrix extends StatelessWidget {
  const _SectionWhenToUseMatrix();

  @override
  Widget build(BuildContext context) {
    const List<_MatrixRow> rows = <_MatrixRow>[
      _MatrixRow(
        scenario: 'Collapsing AppBar over a scrollable body',
        observer: true,
        notificationWrap: true,
        controllerListener: false,
        note: 'Observer decouples the AppBar from any specific list.',
      ),
      _MatrixRow(
        scenario: 'Floating Action Button that hides while scrolling',
        observer: true,
        notificationWrap: false,
        controllerListener: true,
        note: 'Observer survives body swaps — no rewiring needed.',
      ),
      _MatrixRow(
        scenario: 'Sticky in-app notification when near bottom',
        observer: true,
        notificationWrap: false,
        controllerListener: true,
        note: 'Listen for ScrollEndNotification + pixels > 90% extent.',
      ),
      _MatrixRow(
        scenario: 'Analytics: track scroll depth for a whole page',
        observer: true,
        notificationWrap: true,
        controllerListener: false,
        note: 'One listener captures every descendant scrollable.',
      ),
    ];

    return _SectionShell(
      number: '08',
      title: 'When to use — and alternatives',
      subtitle:
          'ScrollNotificationObserver vs NotificationListener vs direct '
          'ScrollController hookup.',
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _mistyIndigo),
        ),
        child: Column(
          children: <Widget>[
            const _MatrixHeader(),
            ...List<Widget>.generate(
              rows.length,
              (int i) => _MatrixRowWidget(row: rows[i], alt: i.isOdd),
            ),
          ],
        ),
      ),
    );
  }
}

class _MatrixRow {
  const _MatrixRow({
    required this.scenario,
    required this.observer,
    required this.notificationWrap,
    required this.controllerListener,
    required this.note,
  });
  final String scenario;
  final bool observer;
  final bool notificationWrap;
  final bool controllerListener;
  final String note;
}

class _MatrixHeader extends StatelessWidget {
  const _MatrixHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: const BoxDecoration(
        color: _indigoDeep,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: const Row(
        children: <Widget>[
          Expanded(flex: 5, child: _HeadCell('Scenario')),
          Expanded(flex: 2, child: _HeadCell('Observer')),
          Expanded(flex: 2, child: _HeadCell('Notification wrap')),
          Expanded(flex: 2, child: _HeadCell('Controller listener')),
        ],
      ),
    );
  }
}

class _HeadCell extends StatelessWidget {
  const _HeadCell(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 12.5,
        letterSpacing: 0.4,
      ),
    );
  }
}

class _MatrixRowWidget extends StatelessWidget {
  const _MatrixRowWidget({required this.row, required this.alt});
  final _MatrixRow row;
  final bool alt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      color: alt ? _cream : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Text(
                  row.scenario,
                  style: const TextStyle(
                    color: _charcoal,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(flex: 2, child: _Check(value: row.observer)),
              Expanded(flex: 2, child: _Check(value: row.notificationWrap)),
              Expanded(flex: 2, child: _Check(value: row.controllerListener)),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              row.note,
              style: const TextStyle(
                color: _charcoalSoft,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Check extends StatelessWidget {
  const _Check({required this.value});
  final bool value;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (value ? _indigo : const Color(0xFFEF4444))
              .withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: (value ? _indigo : const Color(0xFFEF4444))
                .withValues(alpha: 0.4),
          ),
        ),
        child: Icon(
          value ? Icons.check_rounded : Icons.close_rounded,
          color: value ? _indigo : const Color(0xFFEF4444),
          size: 18,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 9 — Canonical code snippet
// ---------------------------------------------------------------------------
class _SectionCodeSnippetPanel extends StatelessWidget {
  const _SectionCodeSnippetPanel();

  @override
  Widget build(BuildContext context) {
    const String code = '''late final ScrollNotificationObserverState? _obs;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _obs?.removeListener(_onScroll);
  _obs = ScrollNotificationObserver.of(context);
  _obs?.addListener(_onScroll);
}

@override
void dispose() {
  _obs?.removeListener(_onScroll);
  super.dispose();
}

void _onScroll(ScrollNotification n) {
  if (n is ScrollUpdateNotification) {
    // react to pixel changes here...
  }
}''';

    return _SectionShell(
      number: '09',
      title: 'Canonical subscriber pattern',
      subtitle:
          'Resolve in didChangeDependencies, attach once, remove in dispose. '
          'Copy-paste friendly.',
      child: Container(
        decoration: BoxDecoration(
          color: _charcoal,
          borderRadius: BorderRadius.circular(18),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _charcoal.withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _CodeHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
              child: SelectableText(
                code,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 12.8,
                  height: 1.55,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
              decoration: BoxDecoration(
                color: _indigoDeep.withValues(alpha: 0.55),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.lightbulb_outline,
                    color: _goldSoft.withValues(alpha: 0.9),
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Resolve in didChangeDependencies so InheritedWidget '
                      'changes (observer being swapped) are handled '
                      'automatically.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        height: 1.45,
                      ),
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

class _CodeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _charcoalSoft.withValues(alpha: 0.55),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Row(
        children: <Widget>[
          _dot(const Color(0xFFEF4444)),
          const SizedBox(width: 6),
          _dot(_gold),
          const SizedBox(width: 6),
          _dot(const Color(0xFF10B981)),
          const SizedBox(width: 12),
          const Text(
            'subscriber.dart',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _gold.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'StatefulWidget',
              style: TextStyle(
                color: _goldSoft,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );
}

// ---------------------------------------------------------------------------
// Section 10 — Footer summary
// ---------------------------------------------------------------------------
class _SectionFooterSummary extends StatelessWidget {
  const _SectionFooterSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_indigoDeep, _indigo],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _indigo.withValues(alpha: 0.32),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[_gold, _goldSoft],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _gold.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.podcasts, color: Colors.white, size: 36),
          ),
          const SizedBox(width: 18),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'ScrollNotificationObserver in one sentence',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Insert it once; subscribe from anywhere beneath; react to '
                  'every ScrollNotification without sharing controllers — '
                  'then remove your listener when you dispose.',
                  style: TextStyle(
                    color: Color(0xFFE0E7FF),
                    fontSize: 13.5,
                    height: 1.55,
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
// Section shell — shared section chrome
// ---------------------------------------------------------------------------
class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String number;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _indigoDeep,
                borderRadius: BorderRadius.circular(14),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _indigoDeep.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                number,
                style: const TextStyle(
                  color: _goldSoft,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      color: _indigoDeep,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: _charcoalSoft,
                      fontSize: 13,
                      height: 1.45,
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
    );
  }
}
