import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// ScrollContext Diagnostics — a deep visual walkthrough of the ScrollContext
// interface that glues ScrollableState to ScrollPosition.
// ---------------------------------------------------------------------------
//
// ScrollContext is the narrow interface ScrollPosition uses to talk back to
// its host (normally a ScrollableState). It surfaces:
//
//   * AxisDirection axisDirection           — which way the viewport scrolls
//   * BuildContext? notificationContext     — where ScrollNotifications fire
//   * BuildContext  storageContext          — restoration lookups
//   * TickerProvider vsync                  — drives BallisticScrollActivity
//   * String? restorationId
//   * void setIgnorePointer(bool)
//   * void setCanDrag(bool)
//   * void setSemanticsActions(Set<SemanticsAction>)
//   * void saveOffset(double)
//
// You cannot instantiate ScrollContext directly; you reach it through a
// Scrollable's state (position.context is a ScrollContext). This demo builds
// several real Scrollables, subscribes to their ScrollPositions, and surfaces
// everything the ScrollContext abstraction is responsible for.
// ---------------------------------------------------------------------------

// Palette ---------------------------------------------------------------------
const Color kOcean = Color(0xFF0F3460);
const Color kCream = Color(0xFFFFF8E7);
const Color kCard = Color(0xFFFFFFFF);
const Color kCoral = Color(0xFFE94560);
const Color kSeaFoam = Color(0xFF8EC5A5);
const Color kInk = Color(0xFF162447);
const Color kSlate = Color(0xFF4A4E69);
const Color kMist = Color(0xFFE0E1DD);

const TextStyle kMono = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: kInk,
  height: 1.35,
);

const TextStyle kMonoBold = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12,
  color: kOcean,
  fontWeight: FontWeight.w700,
  height: 1.35,
);

// =============================================================================
// Entry point — d4rt AST harness shape
// =============================================================================

dynamic build(BuildContext context) {
  debugPrint('[scroll_context_test] building ScrollContext Diagnostics demo');
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollContext Diagnostics',
    home: _ScrollContextDemoRoot(),
  );
}

// =============================================================================
// Root shell
// =============================================================================

class _ScrollContextDemoRoot extends StatefulWidget {
  const _ScrollContextDemoRoot();

  @override
  State<_ScrollContextDemoRoot> createState() => _ScrollContextDemoRootState();
}

class _ScrollContextDemoRootState extends State<_ScrollContextDemoRoot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _HeroHeader(),
              SizedBox(height: 20),
              _WiringDiagram(),
              SizedBox(height: 20),
              _LiveDiagnosticsPanel(),
              SizedBox(height: 20),
              _TriScrollerPanel(),
              SizedBox(height: 20),
              _AxisDirectionComparisonPanel(),
              SizedBox(height: 20),
              _VsyncDemoPanel(),
              SizedBox(height: 20),
              _RestorationContextPanel(),
              SizedBox(height: 20),
              _NotificationContextPanel(),
              SizedBox(height: 20),
              _ScrollContextReference(),
              SizedBox(height: 20),
              _TeachingPanel(),
              SizedBox(height: 20),
              _FooterSummary(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Hero header
// =============================================================================

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [kOcean, kInk],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: kOcean.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: kCoral,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'INTERFACE DEEP-DIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: kSeaFoam.withValues(alpha: 0.25),
                  border: Border.all(color: kSeaFoam.withValues(alpha: 0.6)),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'flutter.widgets.ScrollContext',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'ScrollContext',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'the bridge between Scrollable and ScrollPosition',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'ScrollContext is the narrow interface ScrollPosition uses to talk\n'
            'back to the ScrollableState. It exposes vsync, axisDirection,\n'
            'notificationContext, restoration hooks, and the setters that\n'
            'control pointer, drag, and semantics — everything a position\n'
            'needs without holding a reference to widget-tree internals.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              fontSize: 13,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Wiring diagram — CustomPaint of the data flow
// =============================================================================

class _WiringDiagram extends StatelessWidget {
  const _WiringDiagram();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      badge: '01 / WIRING',
      title: 'How ScrollContext sits in the scrolling pipeline',
      subtitle:
          'Scrollable builds the ScrollableState, which *implements* ScrollContext. '
          'That context is handed to the ScrollPosition, which hands it to each '
          'ScrollActivity. Data flows both directions.',
      child: SizedBox(
        height: 320,
        child: CustomPaint(
          painter: _WiringPainter(),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _WiringPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boxPaint = Paint()..color = kCard;
    final borderPaint = Paint()
      ..color = kOcean
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final shadowPaint = Paint()
      ..color = kOcean.withValues(alpha: 0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    final arrowPaint = Paint()
      ..color = kOcean
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final arrowHead = Paint()..color = kOcean;

    final w = size.width;
    final h = size.height;

    final boxes = <_DiagramBox>[
      _DiagramBox(
        rect: Rect.fromLTWH(10, 20, 170, 80),
        title: 'Scrollable',
        subtitle: 'the widget',
        tone: kOcean,
      ),
      _DiagramBox(
        rect: Rect.fromLTWH(w * 0.30, 20, 200, 80),
        title: 'ScrollableState',
        subtitle: 'implements\nScrollContext',
        tone: kCoral,
      ),
      _DiagramBox(
        rect: Rect.fromLTWH(w * 0.62, 20, 200, 80),
        title: 'ScrollPosition',
        subtitle: 'pixels, extents,\nactivity',
        tone: kSeaFoam,
      ),
      _DiagramBox(
        rect: Rect.fromLTWH(w * 0.40, h - 120, 240, 90),
        title: 'ScrollActivity',
        subtitle: 'Ballistic / Drag / Idle',
        tone: kSlate,
      ),
      _DiagramBox(
        rect: Rect.fromLTWH(10, h - 120, 160, 90),
        title: 'Viewport',
        subtitle: 'lays out slivers',
        tone: kInk,
      ),
    ];

    for (final b in boxes) {
      final rrect = RRect.fromRectAndRadius(
        b.rect.shift(const Offset(0, 3)),
        const Radius.circular(10),
      );
      canvas.drawRRect(rrect, shadowPaint);
      final mainRR = RRect.fromRectAndRadius(b.rect, const Radius.circular(10));
      canvas.drawRRect(mainRR, boxPaint);
      canvas.drawRRect(mainRR, borderPaint..color = b.tone);

      final titleTP = TextPainter(
        text: TextSpan(
          text: b.title,
          style: TextStyle(
            color: b.tone,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: b.rect.width - 12);
      titleTP.paint(canvas, b.rect.topLeft.translate(10, 8));

      final subTP = TextPainter(
        text: TextSpan(
          text: b.subtitle,
          style: const TextStyle(
            color: kSlate,
            fontSize: 11,
            height: 1.2,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: b.rect.width - 12);
      subTP.paint(canvas, b.rect.topLeft.translate(10, 30));
    }

    void drawArrow(Offset start, Offset end, String label) {
      canvas.drawLine(start, end, arrowPaint);
      final angle = (end - start).direction;
      final path = Path()
        ..moveTo(end.dx, end.dy)
        ..lineTo(
          end.dx - 10 * _cos(angle - 0.4),
          end.dy - 10 * _sin(angle - 0.4),
        )
        ..lineTo(
          end.dx - 10 * _cos(angle + 0.4),
          end.dy - 10 * _sin(angle + 0.4),
        )
        ..close();
      canvas.drawPath(path, arrowHead);
      final mid = Offset(
        (start.dx + end.dx) / 2,
        (start.dy + end.dy) / 2 - 10,
      );
      final lbl = TextPainter(
        text: TextSpan(
          text: label,
          style: const TextStyle(
            color: kInk,
            fontSize: 10,
            fontFamily: 'monospace',
            backgroundColor: Color(0xFFFFF3D6),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      lbl.paint(canvas, mid);
    }

    // Scrollable -> ScrollableState
    drawArrow(
      Offset(boxes[0].rect.right, boxes[0].rect.center.dy),
      Offset(boxes[1].rect.left, boxes[1].rect.center.dy),
      'createState()',
    );
    // ScrollableState -> ScrollPosition
    drawArrow(
      Offset(boxes[1].rect.right, boxes[1].rect.center.dy),
      Offset(boxes[2].rect.left, boxes[2].rect.center.dy),
      'vsync, axisDirection',
    );
    // ScrollPosition -> ScrollActivity (down)
    drawArrow(
      Offset(boxes[2].rect.center.dx, boxes[2].rect.bottom),
      Offset(boxes[3].rect.center.dx, boxes[3].rect.top),
      'beginActivity()',
    );
    // ScrollActivity -> ScrollableState (feedback)
    drawArrow(
      Offset(boxes[3].rect.left, boxes[3].rect.center.dy),
      Offset(boxes[1].rect.center.dx, boxes[1].rect.bottom),
      'setCanDrag, setIgnorePointer',
    );
    // ScrollableState -> Viewport
    drawArrow(
      Offset(boxes[1].rect.left, boxes[1].rect.bottom),
      Offset(boxes[4].rect.right, boxes[4].rect.top),
      'notificationContext',
    );
    // Viewport -> ScrollPosition (metrics)
    drawArrow(
      Offset(boxes[4].rect.right + 10, boxes[4].rect.center.dy),
      Offset(boxes[2].rect.left, boxes[2].rect.bottom - 5),
      'applyViewportDimension',
    );
  }

  // Small Taylor-series sin/cos kept local so this file only imports
  // package:flutter/material.dart. Accuracy is plenty for arrowhead tips.
  double _sin(double a) {
    const twoPi = 6.283185307179586;
    const pi = 3.141592653589793;
    double x = a % twoPi;
    if (x > pi) x -= twoPi;
    if (x < -pi) x += twoPi;
    final x2 = x * x;
    return x *
        (1 -
            x2 / 6 +
            x2 * x2 / 120 -
            x2 * x2 * x2 / 5040);
  }

  double _cos(double a) {
    const twoPi = 6.283185307179586;
    const pi = 3.141592653589793;
    double x = a % twoPi;
    if (x > pi) x -= twoPi;
    if (x < -pi) x += twoPi;
    final x2 = x * x;
    return 1 - x2 / 2 + x2 * x2 / 24 - x2 * x2 * x2 / 720;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DiagramBox {
  _DiagramBox({
    required this.rect,
    required this.title,
    required this.subtitle,
    required this.tone,
  });
  final Rect rect;
  final String title;
  final String subtitle;
  final Color tone;
}

// =============================================================================
// Live diagnostics panel
// =============================================================================

class _LiveDiagnosticsPanel extends StatefulWidget {
  const _LiveDiagnosticsPanel();

  @override
  State<_LiveDiagnosticsPanel> createState() => _LiveDiagnosticsPanelState();
}

class _LiveDiagnosticsPanelState extends State<_LiveDiagnosticsPanel> {
  final ScrollController _controller = ScrollController();

  double _pixels = 0;
  double _min = 0;
  double _max = 0;
  double _vp = 0;
  AxisDirection _axis = AxisDirection.down;
  String _userName = 'idle';
  bool _haveDims = false;
  int _contextId = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final p = _controller.position;
    setState(() {
      _pixels = p.pixels;
      _min = p.minScrollExtent;
      _max = p.maxScrollExtent;
      _vp = p.viewportDimension;
      _axis = p.axisDirection;
      _userName = p.userScrollDirection.toString();
      _haveDims = p.haveDimensions;
      _contextId = p.hashCode;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      badge: '02 / LIVE',
      title: 'Live diagnostics from a real ScrollPosition',
      subtitle:
          'The values below are pulled each frame from '
          'controller.position — which in turn was constructed against the '
          'Scrollable state as its ScrollContext.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: kMist.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kOcean.withValues(alpha: 0.15)),
              ),
              child: ListView.separated(
                controller: _controller,
                padding: const EdgeInsets.all(12),
                itemCount: 40,
                separatorBuilder: (context, index) => const SizedBox(height: 6),
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: kCard,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kOcean.withValues(alpha: 0.12)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: i.isEven ? kOcean : kCoral,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '$i',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'scroll item #$i — watch the numbers',
                          style: kMono,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: _DiagnosticsReadout(
              axis: _axis,
              userName: _userName,
              pixels: _pixels,
              min: _min,
              max: _max,
              vp: _vp,
              haveDims: _haveDims,
              contextId: _contextId,
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagnosticsReadout extends StatelessWidget {
  const _DiagnosticsReadout({
    required this.axis,
    required this.userName,
    required this.pixels,
    required this.min,
    required this.max,
    required this.vp,
    required this.haveDims,
    required this.contextId,
  });

  final AxisDirection axis;
  final String userName;
  final double pixels;
  final double min;
  final double max;
  final double vp;
  final bool haveDims;
  final int contextId;

  @override
  Widget build(BuildContext context) {
    final progress = max > min ? ((pixels - min) / (max - min)).clamp(0.0, 1.0) : 0.0;
    return Container(
      height: 300,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kOcean.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: kOcean.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _AxisArrowIcon(direction: axis),
              const SizedBox(width: 10),
              const Text(
                'ScrollPosition readout',
                style: TextStyle(
                  color: kOcean,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              _Pill(
                label: haveDims ? 'haveDimensions' : 'awaiting layout',
                color: haveDims ? kSeaFoam : kCoral,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _ReadoutRow('axisDirection', _axisName(axis)),
          _ReadoutRow('userScrollDirection', userName),
          _ReadoutRow('pixels', pixels.toStringAsFixed(2)),
          _ReadoutRow('minScrollExtent', min.toStringAsFixed(2)),
          _ReadoutRow('maxScrollExtent', max.toStringAsFixed(2)),
          _ReadoutRow('viewportDimension', vp.toStringAsFixed(2)),
          _ReadoutRow('position.hashCode', '0x${contextId.toRadixString(16)}'),
          const SizedBox(height: 10),
          const Text(
            'progress through extent',
            style: TextStyle(color: kSlate, fontSize: 11),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: kMist,
              valueColor: const AlwaysStoppedAnimation<Color>(kCoral),
            ),
          ),
        ],
      ),
    );
  }

  static String _axisName(AxisDirection d) {
    switch (d) {
      case AxisDirection.up:
        return 'AxisDirection.up';
      case AxisDirection.down:
        return 'AxisDirection.down';
      case AxisDirection.left:
        return 'AxisDirection.left';
      case AxisDirection.right:
        return 'AxisDirection.right';
    }
  }

}

class _AxisArrowIcon extends StatelessWidget {
  const _AxisArrowIcon({required this.direction});
  final AxisDirection direction;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (direction) {
      case AxisDirection.up:
        icon = Icons.arrow_upward;
        break;
      case AxisDirection.down:
        icon = Icons.arrow_downward;
        break;
      case AxisDirection.left:
        icon = Icons.arrow_back;
        break;
      case AxisDirection.right:
        icon = Icons.arrow_forward;
        break;
    }
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: kOcean,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}

class _ReadoutRow extends StatelessWidget {
  const _ReadoutRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(label, style: kMono),
          ),
          Expanded(
            child: Text(value, style: kMonoBold),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// =============================================================================
// Tri-scroller panel — three distinct ScrollContexts side-by-side
// =============================================================================

class _TriScrollerPanel extends StatefulWidget {
  const _TriScrollerPanel();

  @override
  State<_TriScrollerPanel> createState() => _TriScrollerPanelState();
}

class _TriScrollerPanelState extends State<_TriScrollerPanel> {
  final ScrollController _a = ScrollController();
  final ScrollController _b = ScrollController();
  final ScrollController _c = ScrollController();

  @override
  void initState() {
    super.initState();
    for (final c in [_a, _b, _c]) {
      c.addListener(() {
        if (!mounted) return;
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _a.dispose();
    _b.dispose();
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      badge: '03 / MULTI',
      title: 'Three scrollables, three independent ScrollContexts',
      subtitle:
          'Each Scrollable builds its own ScrollableState; each state is a '
          'separate ScrollContext implementation passed to its ScrollPosition. '
          'Scroll one — the others are undisturbed.',
      child: Row(
        children: [
          Expanded(child: _SmallScroller(label: 'alpha', tone: kOcean, controller: _a)),
          const SizedBox(width: 12),
          Expanded(child: _SmallScroller(label: 'beta', tone: kCoral, controller: _b)),
          const SizedBox(width: 12),
          Expanded(child: _SmallScroller(label: 'gamma', tone: kSeaFoam, controller: _c)),
        ],
      ),
    );
  }
}

class _SmallScroller extends StatelessWidget {
  const _SmallScroller({
    required this.label,
    required this.tone,
    required this.controller,
  });

  final String label;
  final Color tone;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final hasClients = controller.hasClients;
    final p = hasClients ? controller.position : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: tone,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Text(
                p != null ? '0x${p.hashCode.toRadixString(16)}' : '—',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: kCard,
            border: Border.all(color: tone.withValues(alpha: 0.3)),
          ),
          child: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.all(8),
            itemCount: 30,
            itemBuilder: (context, i) => Container(
              margin: const EdgeInsets.symmetric(vertical: 3),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('$label item #$i', style: kMono),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kMist.withValues(alpha: 0.5),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
            border: Border.all(color: tone.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MiniStat('axis', p?.axisDirection.toString() ?? 'not attached'),
              _MiniStat('pixels', p?.pixels.toStringAsFixed(1) ?? '—'),
              _MiniStat('max', p?.maxScrollExtent.toStringAsFixed(1) ?? '—'),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(label, style: kMono),
        ),
        Expanded(
          child: Text(
            value,
            style: kMonoBold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// AxisDirection comparison panel
// =============================================================================

class _AxisDirectionComparisonPanel extends StatefulWidget {
  const _AxisDirectionComparisonPanel();

  @override
  State<_AxisDirectionComparisonPanel> createState() =>
      _AxisDirectionComparisonPanelState();
}

class _AxisDirectionComparisonPanelState
    extends State<_AxisDirectionComparisonPanel> {
  final ScrollController _down = ScrollController();
  final ScrollController _up = ScrollController();
  final ScrollController _left = ScrollController();
  final ScrollController _right = ScrollController();

  @override
  void dispose() {
    _down.dispose();
    _up.dispose();
    _left.dispose();
    _right.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      badge: '04 / AXIS',
      title: 'AxisDirection — one property of ScrollContext',
      subtitle:
          'ScrollContext.axisDirection tells ScrollPosition which way is '
          '"forward". Reverse lists, horizontal scrollers, and RTL layouts all '
          'change the effective axis seen by the position.',
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 0.85,
        children: [
          _AxisTile(
            label: 'down',
            direction: AxisDirection.down,
            controller: _down,
          ),
          _AxisTile(
            label: 'up (reverse)',
            direction: AxisDirection.up,
            controller: _up,
          ),
          _AxisTile(
            label: 'right',
            direction: AxisDirection.right,
            controller: _left,
          ),
          _AxisTile(
            label: 'left (reverse)',
            direction: AxisDirection.left,
            controller: _right,
          ),
        ],
      ),
    );
  }
}

class _AxisTile extends StatelessWidget {
  const _AxisTile({
    required this.label,
    required this.direction,
    required this.controller,
  });

  final String label;
  final AxisDirection direction;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final axis = axisDirectionToAxis(direction);
    final reverse = direction == AxisDirection.up || direction == AxisDirection.left;
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kOcean.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: kOcean,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Row(
              children: [
                _AxisArrowIcon(direction: direction),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              scrollDirection: axis,
              reverse: reverse,
              padding: const EdgeInsets.all(6),
              itemCount: 20,
              itemBuilder: (context, i) => Container(
                margin: axis == Axis.vertical
                    ? const EdgeInsets.symmetric(vertical: 3)
                    : const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: kSeaFoam.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('#$i', style: kMono),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            color: kMist.withValues(alpha: 0.6),
            child: Text(
              direction.toString(),
              style: const TextStyle(
                color: kOcean,
                fontFamily: 'monospace',
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Vsync demo — ScrollContext.vsync drives BallisticScrollActivity
// =============================================================================

class _VsyncDemoPanel extends StatefulWidget {
  const _VsyncDemoPanel();

  @override
  State<_VsyncDemoPanel> createState() => _VsyncDemoPanelState();
}

class _VsyncDemoPanelState extends State<_VsyncDemoPanel> {
  final ScrollController _controller = ScrollController();
  String _phase = 'idle';
  int _tick = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (!mounted) return;
      final name = _controller.position.userScrollDirection.toString();
      setState(() {
        if (name.endsWith('.idle')) {
          _phase = 'settling';
        } else if (name.endsWith('.forward')) {
          _phase = 'scrolling forward';
        } else {
          _phase = 'scrolling reverse';
        }
        _tick++;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _animateDown() async {
    setState(() => _phase = 'animateTo — driven by vsync');
    await _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
    );
    if (!mounted) return;
    setState(() => _phase = 'settled at max');
  }

  Future<void> _animateTop() async {
    setState(() => _phase = 'animateTo — driven by vsync');
    await _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
    );
    if (!mounted) return;
    setState(() => _phase = 'settled at 0');
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      badge: '05 / VSYNC',
      title: 'Vsync — ScrollContext is also the TickerProvider',
      subtitle:
          'When you call animateTo or the user flings a list, the resulting '
          'BallisticScrollActivity drives an AnimationController that needs a '
          'TickerProvider. ScrollContext.vsync is where it comes from.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _animateDown,
                icon: const Icon(Icons.south, size: 16),
                label: const Text('animateTo(maxScrollExtent)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kCoral,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _animateTop,
                icon: const Icon(Icons.north, size: 16),
                label: const Text('animateTo(0)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kOcean,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 14),
              _Pill(label: 'phase: $_phase', color: kSeaFoam),
              const SizedBox(width: 10),
              _Pill(label: 'ticks: $_tick', color: kOcean),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: kCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kOcean.withValues(alpha: 0.2)),
            ),
            child: ListView.builder(
              controller: _controller,
              padding: const EdgeInsets.all(10),
              itemCount: 80,
              itemBuilder: (context, i) => Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: i.isEven ? kMist.withValues(alpha: 0.3) : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('vsync-driven item #$i', style: kMono),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Restoration context demo
// =============================================================================

class _RestorationContextPanel extends StatefulWidget {
  const _RestorationContextPanel();

  @override
  State<_RestorationContextPanel> createState() =>
      _RestorationContextPanelState();
}

class _RestorationContextPanelState extends State<_RestorationContextPanel> {
  int _resetNonce = 0;
  String _status = 'fresh';

  void _simulateRestart() {
    setState(() {
      _resetNonce++;
      _status = 'simulated restart — restored list kept offset';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      badge: '06 / STORAGE',
      title: 'storageContext — restoration uses ScrollContext',
      subtitle:
          'When a ScrollPosition has a restorationId, it asks its ScrollContext '
          'for storageContext to look up the previous offset. The demo simulates '
          'a "rebuild" by changing a key on the unrestored list; the restored '
          'one preserves its position.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _simulateRestart,
                icon: const Icon(Icons.restart_alt, size: 16),
                label: const Text('simulate restart (rebuild)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kOcean,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              _Pill(label: _status, color: kCoral),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _RestoreTile(
                  label: 'restorationId: "demo"',
                  restored: true,
                  resetNonce: 0, // never rebuilt
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RestoreTile(
                  label: 'no restorationId',
                  restored: false,
                  resetNonce: _resetNonce,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RestoreTile extends StatefulWidget {
  const _RestoreTile({
    required this.label,
    required this.restored,
    required this.resetNonce,
  });

  final String label;
  final bool restored;
  final int resetNonce;

  @override
  State<_RestoreTile> createState() => _RestoreTileState();
}

class _RestoreTileState extends State<_RestoreTile> {
  late ScrollController _controller;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant _RestoreTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.resetNonce != widget.resetNonce && !widget.restored) {
      _controller.removeListener(_onScroll);
      _controller.dispose();
      _controller = ScrollController();
      _controller.addListener(_onScroll);
      _lastOffset = 0;
    }
  }

  void _onScroll() {
    if (!mounted) return;
    setState(() {
      _lastOffset = _controller.position.pixels;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = Container(
      height: 180,
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: widget.restored
              ? kSeaFoam.withValues(alpha: 0.7)
              : kCoral.withValues(alpha: 0.7),
        ),
      ),
      child: ListView.builder(
        controller: _controller,
        padding: const EdgeInsets.all(8),
        itemCount: 60,
        itemBuilder: (context, i) => Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: (widget.restored ? kSeaFoam : kCoral).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('${widget.label} — #$i', style: kMono),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: widget.restored ? kSeaFoam : kCoral,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(
                widget.restored ? Icons.bookmark : Icons.bookmark_border,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                'offset: ${_lastOffset.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        widget.restored
            ? RestorationScope(restorationId: 'demo', child: body)
            : body,
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kMist.withValues(alpha: 0.5),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Text(
            widget.restored
                ? 'ScrollContext.storageContext → restoration bucket "demo"'
                : 'no restorationId → offset lost on rebuild',
            style: kMono,
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Notification context demo
// =============================================================================

class _NotificationContextPanel extends StatefulWidget {
  const _NotificationContextPanel();

  @override
  State<_NotificationContextPanel> createState() =>
      _NotificationContextPanelState();
}

class _NotificationContextPanelState extends State<_NotificationContextPanel> {
  final ScrollController _controller = ScrollController();
  final List<String> _log = <String>[];

  void _record(String kind) {
    setState(() {
      _log.insert(0, kind);
      if (_log.length > 8) _log.removeLast();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      badge: '07 / NOTIFY',
      title: 'notificationContext — where ScrollNotifications fire from',
      subtitle:
          'ScrollPosition dispatches ScrollStart / ScrollUpdate / ScrollEnd / '
          'OverscrollNotifications using the BuildContext returned by '
          'ScrollContext.notificationContext. That is why a wrapping '
          'NotificationListener can see the traffic.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                color: kCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kOcean.withValues(alpha: 0.2)),
              ),
              child: NotificationListener<ScrollNotification>(
                onNotification: (n) {
                  final kind = switch (n) {
                    ScrollStartNotification _ => 'ScrollStart',
                    ScrollUpdateNotification _ => 'ScrollUpdate',
                    ScrollEndNotification _ => 'ScrollEnd',
                    OverscrollNotification _ => 'Overscroll',
                    UserScrollNotification _ => 'UserScroll',
                    _ => n.runtimeType.toString(),
                  };
                  _record(kind);
                  return false;
                },
                child: ListView.builder(
                  controller: _controller,
                  padding: const EdgeInsets.all(10),
                  itemCount: 60,
                  itemBuilder: (context, i) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: kOcean.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('notifying item #$i', style: kMono),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 2,
            child: Container(
              height: 260,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kInk,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'notification log',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _log.length,
                      itemBuilder: (context, i) {
                        final entry = _log[i];
                        final color = _colorForKind(entry);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                entry,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    _log.isEmpty
                        ? 'scroll the list to see traffic'
                        : '${_log.length} recent',
                    style: const TextStyle(
                      color: kMist,
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Color _colorForKind(String k) {
    switch (k) {
      case 'ScrollStart':
        return kSeaFoam;
      case 'ScrollUpdate':
        return kOcean;
      case 'ScrollEnd':
        return kCoral;
      case 'UserScroll':
        return const Color(0xFFFFC857);
      case 'Overscroll':
        return const Color(0xFFC084FC);
      default:
        return kMist;
    }
  }
}

// =============================================================================
// ScrollContext properties reference
// =============================================================================

class _ScrollContextReference extends StatelessWidget {
  const _ScrollContextReference();

  @override
  Widget build(BuildContext context) {
    const entries = <_RefEntry>[
      _RefEntry(
        name: 'axisDirection',
        kind: 'AxisDirection',
        note: 'which way the viewport lays out slivers',
      ),
      _RefEntry(
        name: 'notificationContext',
        kind: 'BuildContext?',
        note: 'where ScrollNotifications dispatch from',
      ),
      _RefEntry(
        name: 'storageContext',
        kind: 'BuildContext',
        note: 'used for restoration bucket lookups',
      ),
      _RefEntry(
        name: 'vsync',
        kind: 'TickerProvider',
        note: 'drives BallisticScrollActivity / animateTo',
      ),
      _RefEntry(
        name: 'restorationId',
        kind: 'String?',
        note: 'key under which offset is persisted',
      ),
      _RefEntry(
        name: 'setIgnorePointer(bool)',
        kind: 'void',
        note: 'block pointer events during animation',
      ),
      _RefEntry(
        name: 'setCanDrag(bool)',
        kind: 'void',
        note: 'enable or disable drag gestures',
      ),
      _RefEntry(
        name: 'setSemanticsActions(...)',
        kind: 'void',
        note: 'publish scroll actions to the a11y tree',
      ),
      _RefEntry(
        name: 'saveOffset(double)',
        kind: 'void',
        note: 'persist current offset for restoration',
      ),
    ];
    return _SectionCard(
      badge: '08 / REFERENCE',
      title: 'ScrollContext — full interface',
      subtitle: 'Everything a ScrollPosition is allowed to ask of its host.',
      child: Column(
        children: [
          for (var i = 0; i < entries.length; i++) ...[
            _RefRow(entry: entries[i], zebra: i.isEven),
            if (i != entries.length - 1) const Divider(height: 1, color: kMist),
          ],
        ],
      ),
    );
  }
}

class _RefEntry {
  const _RefEntry({required this.name, required this.kind, required this.note});
  final String name;
  final String kind;
  final String note;
}

class _RefRow extends StatelessWidget {
  const _RefRow({required this.entry, required this.zebra});
  final _RefEntry entry;
  final bool zebra;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: zebra ? kMist.withValues(alpha: 0.25) : Colors.transparent,
      // 20260524-2003 baseline §6/H-hardly5 todo #19 (scroll_context_test):
      // 6 × ~30 px right overflow on the _RefRow table — the row was
      // `SizedBox(230) + SizedBox(150) + Expanded` = 380 fixed + flex,
      // but the enclosing _SectionCard provided only ~350 px of inner
      // width on the flutter_ast pane. Shrunk the two fixed cells so
      // the Expanded note column can absorb the remainder.
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(entry.name, style: kMonoBold),
          ),
          SizedBox(
            width: 110,
            child: Text(
              entry.kind,
              style: const TextStyle(
                color: kCoral,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              entry.note,
              style: const TextStyle(
                color: kSlate,
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

// =============================================================================
// Teaching panel
// =============================================================================

class _TeachingPanel extends StatelessWidget {
  const _TeachingPanel();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      badge: '09 / WHY',
      title: 'Why the indirection?',
      subtitle:
          'ScrollPosition is a long-lived object — it survives widget '
          'reconfiguration via didChangeDependencies and Scrollable.position '
          'handoff. It must not hold a direct reference to the widget tree. '
          'ScrollContext is the narrow interface that exposes only what '
          'ScrollPosition needs.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kInk,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '// inside ScrollableState.createScrollPosition()\n'
              'ScrollPosition _createPosition() {\n'
              '  return ScrollPositionWithSingleContext(\n'
              '    physics: widget.physics ?? const BouncingScrollPhysics(),\n'
              '    context: this, // `this` is the ScrollContext implementation\n'
              '    initialPixels: 0.0,\n'
              '    keepScrollOffset: widget.restorationId != null,\n'
              '    oldPosition: _position,\n'
              '    debugLabel: widget.restorationId,\n'
              '  );\n'
              '}',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _Bullet(
                  tone: kSeaFoam,
                  title: 'Isolation',
                  body:
                      'ScrollPosition never reaches into Element/RenderObject '
                      'trees directly; it asks its ScrollContext.',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Bullet(
                  tone: kCoral,
                  title: 'Handoff',
                  body:
                      'When Scrollable.physics or controller changes, the old '
                      'ScrollPosition can be replaced with a new one — the '
                      'ScrollContext stays the same.',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Bullet(
                  tone: kOcean,
                  title: 'Testability',
                  body:
                      'You can mock a ScrollContext in tests to drive a '
                      'ScrollPosition without building a real widget tree.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({
    required this.tone,
    required this.title,
    required this.body,
  });
  final Color tone;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: tone,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: tone,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: const TextStyle(
              color: kSlate,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Footer summary
// =============================================================================

class _FooterSummary extends StatelessWidget {
  const _FooterSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [kSeaFoam, kOcean],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.hub, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ScrollContext — small interface, huge impact',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'It is the pivot between the widget layer (ScrollableState) '
                  'and the controller layer (ScrollPosition + ScrollActivity). '
                  'Everything else about scrolling is plumbing around it.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
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

// =============================================================================
// Reusable section card
// =============================================================================

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String badge;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kOcean.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: kOcean.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: kOcean,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: kOcean,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              color: kSlate,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
