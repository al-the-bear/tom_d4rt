// D4rt test script: Deep Demo — ViewportElementMixin
//
// ViewportElementMixin is a Flutter framework element-level mixin defined in
// `package:flutter/src/widgets/scroll_notification.dart` (line ~52):
//
//     mixin ViewportElementMixin on NotifiableElementMixin {
//       @override
//       bool onNotification(Notification notification) {
//         if (notification is ViewportNotificationMixin) {
//           notification._depth += 1;
//         }
//         return false;
//       }
//     }
//
// It is applied by the framework's library-private viewport elements:
//   * `_ViewportElement`                  (lib/src/widgets/viewport.dart)
//   * `_SingleChildViewportElement`       (lib/src/widgets/single_child_scroll_view.dart)
//   * `_TwoDimensionalViewportElement`    (lib/src/widgets/two_dimensional_viewport.dart)
//
// Each of those elements is of the shape:
//     class _XxxViewportElement extends MultiChildRenderObjectElement
//         with NotifiableElementMixin, ViewportElementMixin { ... }
//
// The mixin's sole responsibility is: as a `ViewportNotificationMixin`
// (ScrollNotification, OverscrollIndicatorNotification, etc.) bubbles UP the
// element tree, every viewport element the notification crosses increments
// its `depth` by one. A NotificationListener can therefore reason about how
// many viewports sit between it and the originating scrollable.
//
// Because the mixin is `on NotifiableElementMixin` and both viewport elements
// that apply it are library-private, application code CANNOT mix
// ViewportElementMixin into its own `Element` directly. This demo therefore
// narrates the mixin's behaviour indirectly:
//   * by instrumenting real viewports (CustomScrollView, SingleChildScrollView,
//     nested CustomScrollView) and observing `ScrollNotification.depth`;
//   * by walking the element tree at runtime to locate `RenderViewportBase`
//     render objects and describing where the mixin is installed;
//   * by diagramming Widget/Element/RenderObject triad with a CustomPainter.
//
// The d4rt harness contract requires:
//   * no `main()`, no `runApp()`;
//   * a top-level `dynamic build(BuildContext context)` returning a
//     `MaterialApp(home: ...)`.
//
// Visual theme: "lens-grid workshop" — slate grey panels, brass accents,
// ivory labels, camera-lens motifs drawn via CustomPainter.

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ----------------------------------------------------------------------------
// Theme constants — the lens-grid workshop palette.
// ----------------------------------------------------------------------------

const Color _vemSlate = Color(0xFF2B3138);
const Color _vemSlateDeep = Color(0xFF1D2126);
const Color _vemSlateSoft = Color(0xFF3A4148);
const Color _vemBrass = Color(0xFFB08D3A);
const Color _vemBrassHi = Color(0xFFE0BE6A);
const Color _vemBrassDim = Color(0xFF6F571F);
const Color _vemIvory = Color(0xFFF4ECD6);
const Color _vemIvoryDim = Color(0xFFCEC6B2);
const Color _vemInk = Color(0xFF14181C);
const Color _vemAccent = Color(0xFF7FA9C9);
const String _vemTitleFamily = 'monospace';

// ----------------------------------------------------------------------------
// Top-level harness entrypoint.
// ----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'ViewportElementMixin — Lens-Grid Workshop',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _vemSlate,
      canvasColor: _vemSlate,
      primaryColor: _vemBrass,
      colorScheme: const ColorScheme.dark(
        primary: _vemBrass,
        secondary: _vemBrassHi,
        surface: _vemSlateSoft,
        onPrimary: _vemInk,
        onSecondary: _vemInk,
        onSurface: _vemIvory,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _vemIvory),
        bodySmall: TextStyle(color: _vemIvoryDim),
        titleLarge: TextStyle(
          color: _vemBrassHi,
          fontFamily: _vemTitleFamily,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.1,
        ),
      ),
      dividerColor: _vemBrassDim,
    ),
    home: const _VemWorkshop(),
  );
}

// ============================================================================
// Root widget — orchestrates all scenarios.
// ============================================================================

class _VemWorkshop extends StatefulWidget {
  const _VemWorkshop();

  @override
  State<_VemWorkshop> createState() => _VemWorkshopState();
}

class _VemWorkshopState extends State<_VemWorkshop> {
  AxisDirection _axisDirection = AxisDirection.down;
  bool _useShrinkWrap = false;
  double _crossAxisExtent = 280.0;
  int _notificationBudget = 0;
  int _scrollEventCount = 0;
  int _maxDepthSeen = 0;
  String _lastNotificationLabel = '—';

  void _handleOuterScroll(ScrollNotification notification) {
    setState(() {
      _scrollEventCount += 1;
      _notificationBudget =
          (_notificationBudget + 1).clamp(0, 999999999).toInt();
      if (notification.depth > _maxDepthSeen) {
        _maxDepthSeen = notification.depth;
      }
      _lastNotificationLabel =
          '${notification.runtimeType} @ depth ${notification.depth}';
    });
  }

  void _setAxisDirection(AxisDirection? direction) {
    if (direction == null) return;
    setState(() => _axisDirection = direction);
  }

  void _setUseShrinkWrap(bool value) {
    setState(() => _useShrinkWrap = value);
  }

  void _setCrossAxisExtent(double value) {
    setState(() => _crossAxisExtent = value);
  }

  void _resetCounters() {
    setState(() {
      _scrollEventCount = 0;
      _maxDepthSeen = 0;
      _lastNotificationLabel = '—';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _VemAppBar(
        scrollEvents: _scrollEventCount,
        maxDepth: _maxDepthSeen,
        lastLabel: _lastNotificationLabel,
        onReset: _resetCounters,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          _handleOuterScroll(notification);
          return false;
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 48),
          children: <Widget>[
            const _VemSectionHeader(
              number: '01',
              title: 'Preamble — What is ViewportElementMixin?',
              subtitle:
                  'Element-level mixin that counts viewport crossings on notifications.',
            ),
            const SizedBox(height: 14),
            const _VemPreambleCard(),
            const SizedBox(height: 30),

            const _VemSectionHeader(
              number: '02',
              title: 'Live Viewport — CustomScrollView + ScrollController',
              subtitle:
                  'Every ScrollNotification that leaves the inner viewport carries depth incremented by the mixin.',
            ),
            const SizedBox(height: 14),
            _VemLiveViewportCard(
              axisDirection: _axisDirection,
              useShrinkWrap: _useShrinkWrap,
              crossAxisExtent: _crossAxisExtent,
              onAxisChanged: _setAxisDirection,
              onShrinkWrapChanged: _setUseShrinkWrap,
              onCrossAxisExtentChanged: _setCrossAxisExtent,
            ),
            const SizedBox(height: 30),

            const _VemSectionHeader(
              number: '03',
              title: 'Viewport Anatomy — Widget / Element / RenderObject',
              subtitle:
                  'The triad. The mixin sits on the Element tier, not the Widget tier.',
            ),
            const SizedBox(height: 14),
            const _VemAnatomyCard(),
            const SizedBox(height: 30),

            const _VemSectionHeader(
              number: '04',
              title: 'Element-Tree Inspector',
              subtitle:
                  'Walks ancestors from a probe context to describe the viewport stack above it.',
            ),
            const SizedBox(height: 14),
            const _VemInspectorCard(),
            const SizedBox(height: 30),

            const _VemSectionHeader(
              number: '05',
              title: 'Notification Pass-Through — bubble path through viewports',
              subtitle:
                  'Shows how depth changes as ScrollNotifications cross nested CustomScrollViews.',
            ),
            const SizedBox(height: 14),
            const _VemNotificationPathCard(),
            const SizedBox(height: 30),

            const _VemSectionHeader(
              number: '06',
              title: 'Comparison — Viewport vs ShrinkWrappingViewport',
              subtitle:
                  'Two side-by-side scrollables. The mixin is installed in both variants.',
            ),
            const SizedBox(height: 14),
            const _VemComparisonCard(),
            const SizedBox(height: 30),

            const _VemSectionHeader(
              number: '07',
              title: 'Epilogue — The Element Tier',
              subtitle:
                  'Why Flutter splits Widget / Element / RenderObject and where mixins like this fit.',
            ),
            const SizedBox(height: 14),
            const _VemEpilogueCard(),
            const SizedBox(height: 40),
            const _VemFooter(),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// AppBar — live readout of notifications observed at the outermost listener.
// ============================================================================

class _VemAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _VemAppBar({
    required this.scrollEvents,
    required this.maxDepth,
    required this.lastLabel,
    required this.onReset,
  });

  final int scrollEvents;
  final int maxDepth;
  final String lastLabel;
  final VoidCallback onReset;

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _vemSlateDeep,
      elevation: 0,
      toolbarHeight: 88,
      title: Row(
        children: <Widget>[
          const _VemLensBadge(size: 42),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'ViewportElementMixin',
                  style: TextStyle(
                    color: _vemBrassHi,
                    fontFamily: _vemTitleFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    letterSpacing: 1.4,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Lens-Grid Workshop  //  element-tier narration',
                  style: TextStyle(
                    color: _vemIvoryDim,
                    fontSize: 11,
                    letterSpacing: 1.0,
                    fontFamily: _vemTitleFamily,
                  ),
                ),
              ],
            ),
          ),
          _VemReadout(
            label: 'events',
            value: scrollEvents.toString(),
          ),
          const SizedBox(width: 10),
          _VemReadout(
            label: 'max depth',
            value: maxDepth.toString(),
          ),
          const SizedBox(width: 10),
          _VemReadout(
            label: 'last',
            value: lastLabel,
            narrow: false,
          ),
          const SizedBox(width: 10),
          IconButton(
            tooltip: 'Reset counters',
            onPressed: onReset,
            icon: const Icon(Icons.restart_alt, color: _vemBrassHi),
          ),
        ],
      ),
    );
  }
}

class _VemReadout extends StatelessWidget {
  const _VemReadout({
    required this.label,
    required this.value,
    this.narrow = true,
  });

  final String label;
  final String value;
  final bool narrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: narrow ? 96 : 260),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _vemSlate,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _vemBrassDim),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: _vemBrass,
              fontSize: 9,
              letterSpacing: 1.4,
              fontFamily: _vemTitleFamily,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _vemIvory,
              fontSize: 12,
              fontFamily: _vemTitleFamily,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Reusable section header with numbered tab and divider.
// ============================================================================

class _VemSectionHeader extends StatelessWidget {
  const _VemSectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(color: _vemBrass, width: 1.2),
            borderRadius: BorderRadius.circular(4),
            color: _vemSlateDeep,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: _vemBrassHi,
              fontFamily: _vemTitleFamily,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  color: _vemBrassHi,
                  fontSize: 16,
                  fontFamily: _vemTitleFamily,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _vemIvoryDim,
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              const _VemHairline(),
            ],
          ),
        ),
      ],
    );
  }
}

class _VemHairline extends StatelessWidget {
  const _VemHairline();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: _vemBrassDim,
    );
  }
}

// ============================================================================
// _VemFrame — the signature card used throughout this demo.
// ============================================================================

class _VemFrame extends StatelessWidget {
  const _VemFrame({
    required this.child,
    this.title,
  });

  final Widget child;
  final String? title;

  Color get accent => _vemBrass;
  EdgeInsets get padding => const EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _vemSlateDeep,
        border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (title != null)
            Container(
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.10),
                border: Border(
                  bottom: BorderSide(color: accent.withValues(alpha: 0.35)),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title!,
                      style: TextStyle(
                        color: accent,
                        fontSize: 12,
                        fontFamily: _vemTitleFamily,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

// ============================================================================
// Lens badge — reusable camera-lens motif.
// ============================================================================

class _VemLensBadge extends StatelessWidget {
  const _VemLensBadge({this.size = 60});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _VemLensPainter()),
    );
  }
}

class _VemLensPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double r = math.min(size.width, size.height) / 2 - 2;

    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..color = _vemBrass
      ..strokeWidth = 1.6;
    canvas.drawCircle(center, r, ring);

    final Paint outerRing = Paint()
      ..style = PaintingStyle.stroke
      ..color = _vemBrassHi.withValues(alpha: 0.6)
      ..strokeWidth = 0.9;
    canvas.drawCircle(center, r - 3, outerRing);

    final Paint glass = Paint()..color = _vemSlate;
    canvas.drawCircle(center, r - 6, glass);

    // Aperture blades
    const int blades = 6;
    final Paint blade = Paint()
      ..style = PaintingStyle.fill
      ..color = _vemBrassHi.withValues(alpha: 0.4);
    for (int i = 0; i < blades; i++) {
      final double a = (i * 2 * math.pi) / blades;
      final Path p = Path();
      p.moveTo(center.dx, center.dy);
      p.lineTo(
        center.dx + math.cos(a) * (r - 7),
        center.dy + math.sin(a) * (r - 7),
      );
      p.lineTo(
        center.dx + math.cos(a + math.pi / blades) * (r - 11),
        center.dy + math.sin(a + math.pi / blades) * (r - 11),
      );
      p.close();
      canvas.drawPath(p, blade);
    }

    // Center hotspot
    final Paint hotspot = Paint()..color = _vemBrassHi;
    canvas.drawCircle(center, r / 6, hotspot);

    // Tick marks
    final Paint tick = Paint()
      ..color = _vemIvoryDim
      ..strokeWidth = 0.8;
    for (int i = 0; i < 12; i++) {
      final double a = (i * 2 * math.pi) / 12;
      final Offset p1 = Offset(
        center.dx + math.cos(a) * (r + 1),
        center.dy + math.sin(a) * (r + 1),
      );
      final Offset p2 = Offset(
        center.dx + math.cos(a) * (r - 1),
        center.dy + math.sin(a) * (r - 1),
      );
      canvas.drawLine(p1, p2, tick);
    }
  }

  @override
  bool shouldRepaint(covariant _VemLensPainter oldDelegate) => false;
}

// ============================================================================
// Section 01 — Preamble.
// ============================================================================

class _VemPreambleCard extends StatelessWidget {
  const _VemPreambleCard();

  @override
  Widget build(BuildContext context) {
    final List<_VemBullet> bullets = <_VemBullet>[
      const _VemBullet(
        glyph: 'M',
        title: 'A mixin for Elements — not for Widgets',
        body:
            'ViewportElementMixin extends NotifiableElementMixin. Flutter applies '
            'it to the concrete Element subclasses the viewport Widgets return '
            'from createElement(). The Widget tier remains untouched by this '
            'mixin; all behaviour lives one tier lower.',
      ),
      const _VemBullet(
        glyph: 'N',
        title: 'Sole behaviour: bump notification depth',
        body:
            'Every ScrollNotification (or any other ViewportNotificationMixin) '
            'that travels up through a viewport element is intercepted by '
            'onNotification, which increments depth by one. Consumers use '
            'depth == 0 to respond only to the nearest scrollable.',
      ),
      const _VemBullet(
        glyph: 'A',
        title: 'Applied in three framework sites',
        body:
            'The mixin is installed in _ViewportElement (CustomScrollView), '
            '_SingleChildViewportElement (SingleChildScrollView) and '
            '_TwoDimensionalViewportElement (two_dimensional_viewport.dart). '
            'All three are library-private.',
      ),
      const _VemBullet(
        glyph: 'D',
        title: 'Why element-tier is the right place',
        body:
            'Notifications bubble on the Element tree. Stateless Widgets cannot '
            'intercept bubbling, and RenderObjects do not see Notifications. '
            'The Element tier is the only layer where this interception is both '
            'possible and lifetime-stable.',
      ),
      const _VemBullet(
        glyph: 'P',
        title: 'Pivot note — this demo narrates, it does not subclass',
        body:
            'Because the mixin is constrained to NotifiableElementMixin and '
            'applied only in framework-private elements, application code cannot '
            'mix it in. The demo observes its behaviour indirectly through '
            'real CustomScrollViews and element-tree introspection.',
      ),
    ];

    return _VemFrame(
      title: 'PREAMBLE · THE MIXIN IN 5 POINTS',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Below: one sentence per concept. Read left-to-right before moving '
            'to the live scenarios.',
            style: TextStyle(color: _vemIvoryDim, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 12),
          for (final _VemBullet b in bullets) ...<Widget>[
            b,
            const SizedBox(height: 10),
          ],
          const _VemDivider(),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Icon(Icons.menu_book, size: 18, color: _vemBrass),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'SDK source: lib/src/widgets/scroll_notification.dart — '
                  'mixin ViewportElementMixin on NotifiableElementMixin.',
                  style: TextStyle(
                    color: _vemIvoryDim,
                    fontSize: 11,
                    fontFamily: _vemTitleFamily,
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

class _VemBullet extends StatelessWidget {
  const _VemBullet({
    required this.glyph,
    required this.title,
    required this.body,
  });

  final String glyph;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _vemSlate,
        border: Border.all(color: _vemBrassDim),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _vemBrass,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              glyph,
              style: const TextStyle(
                color: _vemInk,
                fontFamily: _vemTitleFamily,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _vemIvory,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: _vemTitleFamily,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: _vemIvoryDim,
                    fontSize: 12,
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

class _VemDivider extends StatelessWidget {
  const _VemDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Container(height: 1, color: _vemBrassDim)),
        const SizedBox(width: 8),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: _vemBrass,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Container(height: 1, color: _vemBrassDim)),
      ],
    );
  }
}

// ============================================================================
// Section 02 — Live viewport demo.
// ============================================================================

class _VemLiveViewportCard extends StatefulWidget {
  const _VemLiveViewportCard({
    required this.axisDirection,
    required this.useShrinkWrap,
    required this.crossAxisExtent,
    required this.onAxisChanged,
    required this.onShrinkWrapChanged,
    required this.onCrossAxisExtentChanged,
  });

  final AxisDirection axisDirection;
  final bool useShrinkWrap;
  final double crossAxisExtent;
  final ValueChanged<AxisDirection?> onAxisChanged;
  final ValueChanged<bool> onShrinkWrapChanged;
  final ValueChanged<double> onCrossAxisExtentChanged;

  @override
  State<_VemLiveViewportCard> createState() => _VemLiveViewportCardState();
}

class _VemLiveViewportCardState extends State<_VemLiveViewportCard> {
  final ScrollController _controller = ScrollController();
  int _innerDepthSeen = 0;
  int _innerEvents = 0;
  String _lastInnerType = '—';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _handleInner(ScrollNotification notification) {
    setState(() {
      _innerEvents += 1;
      if (notification.depth > _innerDepthSeen) {
        _innerDepthSeen = notification.depth;
      }
      _lastInnerType = notification.runtimeType.toString();
    });
    return false;
  }

  String get _axisLabel {
    switch (widget.axisDirection) {
      case AxisDirection.up:
        return 'up (reverse vertical)';
      case AxisDirection.down:
        return 'down (default)';
      case AxisDirection.left:
        return 'left (reverse horizontal)';
      case AxisDirection.right:
        return 'right (horizontal)';
    }
  }

  Axis get _axis {
    switch (widget.axisDirection) {
      case AxisDirection.up:
      case AxisDirection.down:
        return Axis.vertical;
      case AxisDirection.left:
      case AxisDirection.right:
        return Axis.horizontal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _VemFrame(
      title: 'SCENARIO · LIVE VIEWPORT',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildControlStrip(),
          const SizedBox(height: 14),
          _buildScrollArea(),
          const SizedBox(height: 12),
          _buildInnerReadout(),
          const SizedBox(height: 10),
          _buildNarration(),
        ],
      ),
    );
  }

  Widget _buildControlStrip() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _vemSlate,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _vemBrassDim),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.settings_input_component,
                  color: _vemBrass, size: 16),
              const SizedBox(width: 8),
              Text(
                'CONTROLS',
                style: TextStyle(
                  color: _vemBrass,
                  fontSize: 11,
                  letterSpacing: 1.3,
                  fontFamily: _vemTitleFamily,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              _buildAxisDropdown(),
              _buildShrinkWrapSwitch(),
              _buildCrossAxisSlider(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAxisDropdown() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'axisDirection:',
          style: TextStyle(
            color: _vemIvoryDim,
            fontSize: 12,
            fontFamily: _vemTitleFamily,
          ),
        ),
        const SizedBox(width: 8),
        DropdownButton<AxisDirection>(
          value: widget.axisDirection,
          dropdownColor: _vemSlateDeep,
          style: const TextStyle(
            color: _vemIvory,
            fontSize: 12,
            fontFamily: _vemTitleFamily,
          ),
          iconEnabledColor: _vemBrassHi,
          items: const <DropdownMenuItem<AxisDirection>>[
            DropdownMenuItem<AxisDirection>(
              value: AxisDirection.down,
              child: Text('down'),
            ),
            DropdownMenuItem<AxisDirection>(
              value: AxisDirection.up,
              child: Text('up'),
            ),
            DropdownMenuItem<AxisDirection>(
              value: AxisDirection.right,
              child: Text('right'),
            ),
            DropdownMenuItem<AxisDirection>(
              value: AxisDirection.left,
              child: Text('left'),
            ),
          ],
          onChanged: widget.onAxisChanged,
        ),
      ],
    );
  }

  Widget _buildShrinkWrapSwitch() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'shrinkWrap:',
          style: TextStyle(
            color: _vemIvoryDim,
            fontSize: 12,
            fontFamily: _vemTitleFamily,
          ),
        ),
        const SizedBox(width: 6),
        Switch(
          value: widget.useShrinkWrap,
          onChanged: widget.onShrinkWrapChanged,
          activeThumbColor: _vemBrassHi,
          activeTrackColor: _vemBrass,
          inactiveThumbColor: _vemIvoryDim,
          inactiveTrackColor: _vemSlateDeep,
        ),
      ],
    );
  }

  Widget _buildCrossAxisSlider() {
    return SizedBox(
      width: 260,
      child: Row(
        children: <Widget>[
          const Text(
            'cross-axis:',
            style: TextStyle(
              color: _vemIvoryDim,
              fontSize: 12,
              fontFamily: _vemTitleFamily,
            ),
          ),
          Expanded(
            child: Slider(
              value: widget.crossAxisExtent,
              min: 160,
              max: 360,
              divisions: 40,
              label: widget.crossAxisExtent.toStringAsFixed(0),
              activeColor: _vemBrassHi,
              inactiveColor: _vemBrassDim,
              onChanged: widget.onCrossAxisExtentChanged,
            ),
          ),
          SizedBox(
            width: 48,
            child: Text(
              widget.crossAxisExtent.toStringAsFixed(0),
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: _vemIvory,
                fontSize: 12,
                fontFamily: _vemTitleFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollArea() {
    final Widget body = _buildScrollable();
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: _vemSlate,
        border: Border.all(color: _vemBrass, width: 1.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              width: widget.crossAxisExtent.clamp(160, 360).toDouble(),
              child: NotificationListener<ScrollNotification>(
                onNotification: _handleInner,
                child: body,
              ),
            ),
            Container(width: 1, color: _vemBrassDim),
            Expanded(child: _buildGuide()),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollable() {
    if (widget.useShrinkWrap) {
      return SingleChildScrollView(
        controller: _controller,
        scrollDirection: _axis,
        reverse: widget.axisDirection == AxisDirection.up ||
            widget.axisDirection == AxisDirection.left,
        child: _buildLinearContent(),
      );
    }
    return CustomScrollView(
      controller: _controller,
      scrollDirection: _axis,
      reverse: widget.axisDirection == AxisDirection.up ||
          widget.axisDirection == AxisDirection.left,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverList.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) => _VemFilmRow(
              index: index,
              horizontal: _axis == Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLinearContent() {
    if (_axis == Axis.horizontal) {
      return Row(
        children: <Widget>[
          for (int i = 0; i < 30; i++)
            _VemFilmRow(index: i, horizontal: true),
        ],
      );
    }
    return Column(
      children: <Widget>[
        for (int i = 0; i < 30; i++)
          _VemFilmRow(index: i, horizontal: false),
      ],
    );
  }

  Widget _buildGuide() {
    return Container(
      color: _vemSlateDeep,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'AXIS:',
            style: _hintStyle(),
          ),
          const SizedBox(height: 2),
          Text(
            _axisLabel,
            style: const TextStyle(color: _vemIvory, fontSize: 12),
          ),
          const SizedBox(height: 10),
          Text(
            'SCROLLABLE:',
            style: _hintStyle(),
          ),
          Text(
            widget.useShrinkWrap
                ? 'SingleChildScrollView\n-> _SingleChildViewportElement'
                : 'CustomScrollView\n-> _ViewportElement',
            style: const TextStyle(
              color: _vemIvory,
              fontSize: 12,
              fontFamily: _vemTitleFamily,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'MIXIN INSTALLED:',
            style: _hintStyle(),
          ),
          Text(
            'NotifiableElementMixin\n+ ViewportElementMixin',
            style: const TextStyle(
              color: _vemBrassHi,
              fontSize: 12,
              fontFamily: _vemTitleFamily,
              height: 1.35,
            ),
          ),
          const Spacer(),
          Text(
            'every ScrollNotification exits the viewport with depth += 1',
            style: TextStyle(
              color: _vemIvoryDim,
              fontSize: 11,
              height: 1.4,
              fontFamily: _vemTitleFamily,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _hintStyle() => const TextStyle(
        color: _vemBrass,
        fontSize: 10,
        letterSpacing: 1.2,
        fontFamily: _vemTitleFamily,
      );

  Widget _buildInnerReadout() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _vemSlate,
        border: Border.all(color: _vemBrassDim),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.sensors, size: 16, color: _vemBrass),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'inner listener — events: $_innerEvents · max depth: '
              '$_innerDepthSeen · last: $_lastInnerType',
              style: const TextStyle(
                color: _vemIvory,
                fontSize: 12,
                fontFamily: _vemTitleFamily,
              ),
            ),
          ),
          TextButton(
            onPressed: () => setState(() {
              _innerEvents = 0;
              _innerDepthSeen = 0;
              _lastInnerType = '—';
            }),
            style: TextButton.styleFrom(foregroundColor: _vemBrassHi),
            child: const Text('reset'),
          ),
        ],
      ),
    );
  }

  Widget _buildNarration() {
    return Text(
      'The inner NotificationListener sits INSIDE the viewport — it receives '
      'notifications with depth = 0 (the mixin has not yet fired for the cross '
      'that would pass through its own viewport element). The outer listener '
      '(in the app bar) receives the same notifications with depth incremented '
      'by the number of viewport elements between the scrollable and that '
      'outer listener. Toggle shrinkWrap to swap _ViewportElement for '
      '_SingleChildViewportElement: both apply ViewportElementMixin.',
      style: TextStyle(
        color: _vemIvoryDim,
        fontSize: 11.5,
        height: 1.45,
      ),
    );
  }
}

class _VemFilmRow extends StatelessWidget {
  const _VemFilmRow({required this.index, required this.horizontal});

  final int index;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    final Color accent =
        index % 7 == 0 ? _vemBrassHi : _vemAccent.withValues(alpha: 0.8);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      constraints: BoxConstraints(
        minWidth: horizontal ? 140 : 0,
        minHeight: 36,
      ),
      decoration: BoxDecoration(
        color: _vemSlateSoft,
        borderRadius: BorderRadius.circular(4),
        border: Border(left: BorderSide(color: accent, width: 2.5)),
      ),
      child: Row(
        mainAxisSize: horizontal ? MainAxisSize.min : MainAxisSize.max,
        children: <Widget>[
          Text(
            '#${index.toString().padLeft(2, '0')}',
            style: const TextStyle(
              color: _vemBrassHi,
              fontSize: 11,
              fontFamily: _vemTitleFamily,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              'frame · ${_frameNames[index % _frameNames.length]}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: _vemIvory, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> _frameNames = <String>[
  'focus ring',
  'iris wheel',
  'aperture cam',
  'mount flange',
  'sensor plane',
  'tripod collar',
  'filter thread',
  'lens hood',
  'rear baffle',
  'zoom cam',
  'compensation group',
  'diopter stop',
  'anti-reflective coat',
  'front element',
  'diaphragm blade',
  'rail clamp',
];

// ============================================================================
// Section 03 — Anatomy diagram.
// ============================================================================

class _VemAnatomyCard extends StatelessWidget {
  const _VemAnatomyCard();

  @override
  Widget build(BuildContext context) {
    return _VemFrame(
      title: 'ANATOMY · WIDGET / ELEMENT / RENDEROBJECT',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 260,
            child: CustomPaint(
              painter: _VemAnatomyPainter(),
              child: Container(),
            ),
          ),
          const SizedBox(height: 14),
          _buildLegend(),
          const SizedBox(height: 12),
          const Text(
            'The blue column is the Widget tier — declarative, immutable, '
            'rebuilt every frame. The brass column in the middle is the Element '
            'tier — mutable, persistent, the home of ViewportElementMixin. The '
            'ivory column on the right is the RenderObject tier — layout, paint, '
            'hit-testing. Notifications bubble along the brass column.',
            style: TextStyle(color: _vemIvoryDim, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: <Widget>[
        _legendSwatch(_vemAccent, 'Widget'),
        const SizedBox(width: 18),
        _legendSwatch(_vemBrassHi, 'Element'),
        const SizedBox(width: 18),
        _legendSwatch(_vemIvoryDim, 'RenderObject'),
      ],
    );
  }

  Widget _legendSwatch(Color c, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: _vemIvory,
            fontSize: 12,
            fontFamily: _vemTitleFamily,
          ),
        ),
      ],
    );
  }
}

class _VemAnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _vemSlate;
    canvas.drawRect(Offset.zero & size, bg);

    final double colWidth = (size.width - 40) / 3;
    final List<_VemAnatomyCol> cols = <_VemAnatomyCol>[
      _VemAnatomyCol(
        color: _vemAccent,
        title: 'Widget',
        rows: const <String>[
          'CustomScrollView',
          'Viewport',
          'SliverList',
          'SliverToBoxAdapter',
        ],
      ),
      _VemAnatomyCol(
        color: _vemBrassHi,
        title: 'Element',
        rows: const <String>[
          '_ViewportElement',
          'MultiChildRenderObjectElement',
          '  + NotifiableElementMixin',
          '  + ViewportElementMixin',
        ],
      ),
      _VemAnatomyCol(
        color: _vemIvoryDim,
        title: 'RenderObject',
        rows: const <String>[
          'RenderViewport',
          'RenderSliverList',
          'RenderSliverPadding',
          'RenderBox leaves',
        ],
      ),
    ];

    double x = 15;
    for (int i = 0; i < cols.length; i++) {
      _drawColumn(canvas, Rect.fromLTWH(x, 15, colWidth, size.height - 30),
          cols[i]);
      x += colWidth + 10;
    }

    // Draw connectors between element column and others.
    final Paint link = Paint()
      ..color = _vemBrassDim
      ..strokeWidth = 1;
    for (int i = 0; i < 4; i++) {
      final double y = 55 + i * 40;
      canvas.drawLine(
        Offset(15 + colWidth, y),
        Offset(15 + colWidth + 10, y),
        link,
      );
      canvas.drawLine(
        Offset(15 + colWidth * 2 + 10, y),
        Offset(15 + colWidth * 2 + 20, y),
        link,
      );
    }
  }

  void _drawColumn(Canvas canvas, Rect rect, _VemAnatomyCol col) {
    final Paint frame = Paint()
      ..color = col.color.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRect(rect, frame);

    final TextPainter tpTitle = TextPainter(
      text: TextSpan(
        text: col.title,
        style: TextStyle(
          color: col.color,
          fontFamily: _vemTitleFamily,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width - 12);
    tpTitle.paint(canvas, Offset(rect.left + 8, rect.top + 6));

    for (int i = 0; i < col.rows.length; i++) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: col.rows[i],
          style: TextStyle(
            color: i >= 2 && col.title == 'Element'
                ? _vemBrassHi
                : _vemIvory.withValues(alpha: 0.9),
            fontFamily: _vemTitleFamily,
            fontSize: 11.5,
            height: 1.3,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: rect.width - 12);
      tp.paint(canvas, Offset(rect.left + 8, rect.top + 30 + i * 40));
    }
  }

  @override
  bool shouldRepaint(covariant _VemAnatomyPainter oldDelegate) => false;
}

class _VemAnatomyCol {
  const _VemAnatomyCol({
    required this.color,
    required this.title,
    required this.rows,
  });
  final Color color;
  final String title;
  final List<String> rows;
}

// ============================================================================
// Section 04 — Element-tree inspector.
// ============================================================================

class _VemInspectorCard extends StatefulWidget {
  const _VemInspectorCard();

  @override
  State<_VemInspectorCard> createState() => _VemInspectorCardState();
}

class _VemInspectorCardState extends State<_VemInspectorCard> {
  final GlobalKey _probeKey = GlobalKey();
  List<String> _report = const <String>[];
  String _summary = 'Not yet scanned.';

  void _scan() {
    final BuildContext? probe = _probeKey.currentContext;
    if (probe == null) {
      setState(() {
        _summary = 'Probe context unavailable — widget not mounted yet.';
        _report = const <String>[];
      });
      return;
    }
    final List<String> lines = <String>[];
    int viewportCount = 0;
    int scrollableCount = 0;
    int notificationListenerCount = 0;

    probe.visitAncestorElements((Element element) {
      final Widget w = element.widget;
      final String wName = w.runtimeType.toString();
      final RenderObject? ro = _safeRenderObject(element);
      final String roName = ro == null ? '—' : ro.runtimeType.toString();
      lines.add('$wName  ::  $roName');
      if (wName == 'Viewport' ||
          wName == 'ShrinkWrappingViewport' ||
          wName.contains('Viewport')) {
        viewportCount += 1;
      }
      if (wName == 'Scrollable' || wName.startsWith('Scrollable')) {
        scrollableCount += 1;
      }
      if (wName.startsWith('NotificationListener')) {
        notificationListenerCount += 1;
      }
      return true;
    });

    setState(() {
      _report = lines;
      _summary =
          'viewports: $viewportCount · scrollables: $scrollableCount · '
          'notification-listeners: $notificationListenerCount · total ancestors: '
          '${lines.length}';
    });
  }

  RenderObject? _safeRenderObject(Element element) {
    try {
      return element.renderObject;
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _VemFrame(
      title: 'INSPECTOR · ANCESTOR ELEMENTS ABOVE THE PROBE',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildProbeHost(),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _scan,
                icon: const Icon(Icons.search, size: 18),
                label: const Text('scan ancestor elements'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _vemBrass,
                  foregroundColor: _vemInk,
                  textStyle: const TextStyle(
                    fontFamily: _vemTitleFamily,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  _summary,
                  style: const TextStyle(
                    color: _vemIvory,
                    fontSize: 12,
                    fontFamily: _vemTitleFamily,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: _vemSlate,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _vemBrassDim),
            ),
            child: _report.isEmpty
                ? const Center(
                    child: Text(
                      'no data — press scan',
                      style: TextStyle(
                        color: _vemIvoryDim,
                        fontSize: 12,
                        fontFamily: _vemTitleFamily,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    itemCount: _report.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String line = _report[index];
                      final bool highlight = line.contains('Viewport') ||
                          line.contains('Scrollable');
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 28,
                              child: Text(
                                index.toString().padLeft(2, '0'),
                                style: const TextStyle(
                                  color: _vemBrass,
                                  fontFamily: _vemTitleFamily,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                line,
                                style: TextStyle(
                                  color: highlight
                                      ? _vemBrassHi
                                      : _vemIvory.withValues(alpha: 0.9),
                                  fontFamily: _vemTitleFamily,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Notes on reading the list: each row is a Widget :: RenderObject '
            'pair. Elements that apply ViewportElementMixin appear with widget '
            'names Viewport, ShrinkWrappingViewport and TwoDimensionalViewport '
            '(and within RenderViewport, RenderShrinkWrappingViewport).',
            style: TextStyle(color: _vemIvoryDim, fontSize: 11.5, height: 1.45),
          ),
        ],
      ),
    );
  }

  Widget _buildProbeHost() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: _vemSlate,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _vemBrass, width: 1.1),
      ),
      padding: const EdgeInsets.all(8),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed(<Widget>[
                const Text(
                  'This inner scrollable contains the probe. When you scan, '
                  'the list above should include a "Viewport" entry whose '
                  'element is _ViewportElement with ViewportElementMixin.',
                  style: TextStyle(color: _vemIvoryDim, fontSize: 12),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Container(
                      key: _probeKey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: _vemBrass.withValues(alpha: 0.18),
                        border: Border.all(color: _vemBrassHi),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '» PROBE «',
                        style: TextStyle(
                          color: _vemBrassHi,
                          fontSize: 12,
                          fontFamily: _vemTitleFamily,
                          letterSpacing: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'the brass pill above is the scan origin',
                        style: TextStyle(
                          color: _vemIvory,
                          fontSize: 11,
                          fontFamily: _vemTitleFamily,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < 6; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• sliver contents row $i',
                      style:
                          const TextStyle(color: _vemIvoryDim, fontSize: 11),
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Section 05 — Notification pass-through with nested viewports.
// ============================================================================

class _VemNotificationPathCard extends StatefulWidget {
  const _VemNotificationPathCard();

  @override
  State<_VemNotificationPathCard> createState() =>
      _VemNotificationPathCardState();
}

class _VemNotificationPathCardState extends State<_VemNotificationPathCard> {
  final List<_VemDepthEvent> _events = <_VemDepthEvent>[];
  int _maxDepth = 0;

  void _record(String label, ScrollNotification n) {
    setState(() {
      _events.insert(
        0,
        _VemDepthEvent(
          where: label,
          depth: n.depth,
          kind: n.runtimeType.toString(),
        ),
      );
      if (_events.length > 20) _events.removeLast();
      if (n.depth > _maxDepth) _maxDepth = n.depth;
    });
  }

  void _clear() {
    setState(() {
      _events.clear();
      _maxDepth = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _VemFrame(
      title: 'PATH · NESTED VIEWPORTS',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'A CustomScrollView contains another CustomScrollView in one of its '
            'slivers. Three NotificationListeners sit at different depths. '
            'Scroll the inner list and compare the depth reported at each '
            'listener to see the mixin at work.',
            style: TextStyle(color: _vemIvoryDim, fontSize: 12, height: 1.45),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 340,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification n) {
                _record('outer (above all viewports)', n);
                return false;
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: _vemBrassDim),
                  borderRadius: BorderRadius.circular(6),
                  color: _vemSlate,
                ),
                padding: const EdgeInsets.all(8),
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification n) {
                    _record('mid (inside outer viewport)', n);
                    return false;
                  },
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'outer CustomScrollView',
                            style: TextStyle(
                              color: _vemBrassHi,
                              fontSize: 11.5,
                              fontFamily: _vemTitleFamily,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: 180,
                          decoration: BoxDecoration(
                            color: _vemSlateDeep,
                            border: Border.all(color: _vemBrass, width: 1.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification n) {
                              _record('inner (inside nested viewport)', n);
                              return false;
                            },
                            child: CustomScrollView(
                              slivers: <Widget>[
                                SliverList(
                                  delegate:
                                      SliverChildBuilderDelegate(
                                    (BuildContext context, int index) =>
                                        _VemFilmRow(
                                      index: index,
                                      horizontal: false,
                                    ),
                                    childCount: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text(
                              '· outer item ${index.toString().padLeft(2, "0")}',
                              style: const TextStyle(
                                color: _vemIvory,
                                fontSize: 12,
                                fontFamily: _vemTitleFamily,
                              ),
                            ),
                          ),
                          childCount: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _buildDepthBadge('max depth', _maxDepth),
              const SizedBox(width: 12),
              _buildDepthBadge('events', _events.length),
              const Spacer(),
              TextButton.icon(
                onPressed: _clear,
                style: TextButton.styleFrom(foregroundColor: _vemBrassHi),
                icon: const Icon(Icons.clear_all, size: 16),
                label: const Text('clear log'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: _vemSlate,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _vemBrassDim),
            ),
            constraints: const BoxConstraints(maxHeight: 180),
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: _events.isEmpty
                ? Text(
                    'log empty — interact with the nested scrollables above',
                    style: TextStyle(
                      color: _vemIvoryDim.withValues(alpha: 0.7),
                      fontSize: 11.5,
                      fontFamily: _vemTitleFamily,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        for (final _VemDepthEvent e in _events)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 26,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        _vemBrass.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Text(
                                    '${e.depth}',
                                    style: const TextStyle(
                                      color: _vemBrassHi,
                                      fontFamily: _vemTitleFamily,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    '${e.where} · ${e.kind}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: _vemIvory,
                                      fontSize: 11.5,
                                      fontFamily: _vemTitleFamily,
                                    ),
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
    );
  }

  Widget _buildDepthBadge(String label, int value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _vemSlateDeep,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _vemBrassDim),
      ),
      child: Row(
        children: <Widget>[
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: _vemBrass,
              fontSize: 9,
              letterSpacing: 1.3,
              fontFamily: _vemTitleFamily,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$value',
            style: const TextStyle(
              color: _vemIvory,
              fontSize: 12,
              fontFamily: _vemTitleFamily,
            ),
          ),
        ],
      ),
    );
  }
}

class _VemDepthEvent {
  const _VemDepthEvent({
    required this.where,
    required this.depth,
    required this.kind,
  });
  final String where;
  final int depth;
  final String kind;
}

// ============================================================================
// Section 06 — Comparison, Viewport vs ShrinkWrappingViewport.
// ============================================================================

class _VemComparisonCard extends StatefulWidget {
  const _VemComparisonCard();

  @override
  State<_VemComparisonCard> createState() => _VemComparisonCardState();
}

class _VemComparisonCardState extends State<_VemComparisonCard> {
  int _leftEvents = 0;
  int _rightEvents = 0;

  @override
  Widget build(BuildContext context) {
    return _VemFrame(
      title: 'COMPARISON · VIEWPORT vs SHRINK-WRAPPING VIEWPORT',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _buildPane(
                  label: 'Viewport',
                  subtitle: '_ViewportElement + mixin',
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification n) {
                      setState(() => _leftEvents += 1);
                      return false;
                    },
                    child: _buildListView(shrinkWrap: false),
                  ),
                  eventCount: _leftEvents,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPane(
                  label: 'ShrinkWrappingViewport',
                  subtitle:
                      '_ShrinkWrappingViewportElement + mixin (identical behaviour)',
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification n) {
                      setState(() => _rightEvents += 1);
                      return false;
                    },
                    child: _buildListView(shrinkWrap: true),
                  ),
                  eventCount: _rightEvents,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'The two panes differ only in sizing strategy — the eager viewport '
            'takes all available main-axis extent, the shrink-wrapping one '
            'measures its children. For the purposes of ViewportElementMixin '
            'they are identical: each installs the mixin and each bumps the '
            'depth of passing ScrollNotifications by exactly one.',
            style: TextStyle(color: _vemIvoryDim, fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 10),
          _buildTable(),
        ],
      ),
    );
  }

  Widget _buildListView({required bool shrinkWrap}) {
    final Widget list = ListView.builder(
      shrinkWrap: shrinkWrap,
      physics:
          shrinkWrap ? const AlwaysScrollableScrollPhysics() : null,
      padding: const EdgeInsets.all(8),
      itemCount: 24,
      itemBuilder: (BuildContext context, int index) {
        return _VemFilmRow(index: index, horizontal: false);
      },
    );
    return Container(
      color: _vemSlateDeep,
      padding: const EdgeInsets.all(4),
      child: list,
    );
  }

  Widget _buildPane({
    required String label,
    required String subtitle,
    required Widget child,
    required int eventCount,
  }) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: _vemSlate,
        border: Border.all(color: _vemBrass, width: 1.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: const BoxDecoration(
              color: _vemSlateDeep,
              border: Border(bottom: BorderSide(color: _vemBrassDim)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        label,
                        style: const TextStyle(
                          color: _vemBrassHi,
                          fontFamily: _vemTitleFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: _vemIvoryDim,
                          fontSize: 10.5,
                          fontFamily: _vemTitleFamily,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _vemBrass.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'events: $eventCount',
                    style: const TextStyle(
                      color: _vemBrassHi,
                      fontFamily: _vemTitleFamily,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildTable() {
    final List<List<String>> rows = <List<String>>[
      <String>['Sizing', 'fills main axis', 'shrinks to content'],
      <String>['Element', '_ViewportElement', '_ShrinkWrappingViewportElement'],
      <String>['Mixin', 'ViewportElementMixin', 'ViewportElementMixin'],
      <String>['Mixin effect', 'depth += 1 on ScrollNotification',
          'depth += 1 on ScrollNotification'],
      <String>[
        'Common use',
        'CustomScrollView default, fixed-height parent',
        'ListView(shrinkWrap: true), embedded in Column',
      ],
    ];
    return Container(
      decoration: BoxDecoration(
        color: _vemSlate,
        border: Border.all(color: _vemBrassDim),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: _vemSlateDeep,
              border:
                  Border(bottom: BorderSide(color: _vemBrassDim)),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Row(
              children: const <Widget>[
                SizedBox(
                  width: 110,
                  child: Text(
                    'FACET',
                    style: TextStyle(
                      color: _vemBrass,
                      fontFamily: _vemTitleFamily,
                      fontSize: 11,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'VIEWPORT',
                    style: TextStyle(
                      color: _vemBrass,
                      fontFamily: _vemTitleFamily,
                      fontSize: 11,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'SHRINK-WRAPPING VIEWPORT',
                    style: TextStyle(
                      color: _vemBrass,
                      fontFamily: _vemTitleFamily,
                      fontSize: 11,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              decoration: BoxDecoration(
                color: i.isOdd
                    ? _vemSlateDeep.withValues(alpha: 0.5)
                    : Colors.transparent,
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 110,
                    child: Text(
                      rows[i][0],
                      style: const TextStyle(
                        color: _vemBrassHi,
                        fontFamily: _vemTitleFamily,
                        fontSize: 11.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rows[i][1],
                      style: const TextStyle(
                        color: _vemIvory,
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rows[i][2],
                      style: const TextStyle(
                        color: _vemIvory,
                        fontSize: 11.5,
                        height: 1.4,
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

// ============================================================================
// Section 07 — Epilogue.
// ============================================================================

class _VemEpilogueCard extends StatelessWidget {
  const _VemEpilogueCard();

  @override
  Widget build(BuildContext context) {
    final List<_VemEpilogueEntry> entries = const <_VemEpilogueEntry>[
      _VemEpilogueEntry(
        heading: 'Three trees, one scene',
        body:
            'Every Flutter frame lives simultaneously in three trees. Widgets '
            'describe configuration, Elements hold identity and lifetime, '
            'RenderObjects handle layout and paint. Mixins like '
            'ViewportElementMixin slot into the Element tier to manage '
            'cross-tree concerns such as notification bubbling.',
      ),
      _VemEpilogueEntry(
        heading: 'Why not at the Widget layer?',
        body:
            'Widgets are rebuilt every frame — they are cheap, immutable, '
            'and cannot carry long-lived behaviour. Any stateful '
            'interception must happen below them. Elements sit exactly where '
            'the tree traversal needs it: the bubbling path for notifications '
            'and hit-testing walks ancestor elements, not widgets.',
      ),
      _VemEpilogueEntry(
        heading: 'Why not at the RenderObject layer?',
        body:
            'RenderObjects perform layout, painting, and semantics; they do '
            'not participate in the Notification system at all. Notifications '
            'use Element.visitAncestorElements via the NotifiableElementMixin '
            'plumbing. Placing the depth-count responsibility on Elements '
            'keeps render-tree code oblivious to application-level events.',
      ),
      _VemEpilogueEntry(
        heading: 'Depth as a routing hint',
        body:
            'Because the mixin increments depth at every viewport the '
            'notification crosses, listeners that only want to respond to '
            'their nearest scrollable can gate on depth == 0. This avoids '
            'cascading updates when a page contains multiple independent '
            'scroll regions.',
      ),
      _VemEpilogueEntry(
        heading: 'In practice: where you feel it',
        body:
            'Whenever you attach a NotificationListener<ScrollNotification> '
            'above a nested scroll view and correctly filter on depth, you '
            'are leveraging the work this tiny 8-line mixin has been doing '
            'invisibly. The mixin is simple, specific, and everywhere.',
      ),
    ];

    return _VemFrame(
      title: 'EPILOGUE · THE ELEMENT TIER IN FLUTTER',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final _VemEpilogueEntry e in entries) ...<Widget>[
            _buildEntry(e),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 4),
          const _VemDivider(),
          const SizedBox(height: 10),
          const _VemMixinSourceBlock(),
        ],
      ),
    );
  }

  Widget _buildEntry(_VemEpilogueEntry e) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _vemSlate,
        border: Border.all(color: _vemBrassDim),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: _vemBrassHi,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  e.heading,
                  style: const TextStyle(
                    color: _vemBrassHi,
                    fontFamily: _vemTitleFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            e.body,
            style: const TextStyle(
              color: _vemIvory,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _VemEpilogueEntry {
  const _VemEpilogueEntry({required this.heading, required this.body});
  final String heading;
  final String body;
}

class _VemMixinSourceBlock extends StatelessWidget {
  const _VemMixinSourceBlock();

  @override
  Widget build(BuildContext context) {
    const String source = '''
// lib/src/widgets/scroll_notification.dart
mixin ViewportElementMixin on NotifiableElementMixin {
  @override
  bool onNotification(Notification notification) {
    if (notification is ViewportNotificationMixin) {
      notification._depth += 1;
    }
    return false;
  }
}
''';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _vemInk,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _vemBrass),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'CANONICAL SOURCE',
            style: TextStyle(
              color: _vemBrassHi,
              fontSize: 11,
              fontFamily: _vemTitleFamily,
              letterSpacing: 1.3,
            ),
          ),
          SizedBox(height: 6),
          Text(
            source,
            style: TextStyle(
              color: _vemIvory,
              fontFamily: _vemTitleFamily,
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Footer.
// ============================================================================

class _VemFooter extends StatelessWidget {
  const _VemFooter();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const _VemLensBadge(size: 34),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'end of workshop · ViewportElementMixin — a 9-line mixin that '
            'every scrollable page in Flutter depends on, quietly.',
            style: TextStyle(
              color: _vemIvoryDim.withValues(alpha: 0.85),
              fontSize: 11.5,
              fontFamily: _vemTitleFamily,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: _vemBrass),
            borderRadius: BorderRadius.circular(3),
          ),
          child: const Text(
            'lens-grid',
            style: TextStyle(
              color: _vemBrass,
              fontSize: 10,
              fontFamily: _vemTitleFamily,
              letterSpacing: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
