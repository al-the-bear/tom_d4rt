// ScrollbarPainter Studio — a deep visual harness for Flutter's
// ScrollbarPainter. One real ScrollController drives a ListView on the
// left and a row of CustomPaint previews on the right, so every knob of
// ScrollbarPainter (thickness, radius, track*, margins, orientation,
// fade) becomes visible. This is a d4rt AST test harness: the entry
// point is `dynamic build(BuildContext context)` returning a
// MaterialApp.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette
// ---------------------------------------------------------------------------

const Color _kBackground = Color(0xFFF7F4ED);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kInk = Color(0xFF1F1B16);
const Color _kInkSoft = Color(0xFF4A4640);
const Color _kAccent = Color(0xFFE87A00);
const Color _kTeal = Color(0xFF0E9488);
const Color _kPurple = Color(0xFF7B5EA7);
const Color _kTrack = Color(0xFFE6E1D6);
const Color _kTrackBorder = Color(0xFFB7B0A2);
const Color _kDivider = Color(0xFFEDE7DA);

const String _kMono = 'monospace';

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ScrollbarPainter Studio',
    home: _ScrollbarPainterStudio(),
  );
}

// ---------------------------------------------------------------------------
// Root scaffold
// ---------------------------------------------------------------------------

class _ScrollbarPainterStudio extends StatefulWidget {
  const _ScrollbarPainterStudio();

  @override
  State<_ScrollbarPainterStudio> createState() =>
      _ScrollbarPainterStudioState();
}

class _ScrollbarPainterStudioState extends State<_ScrollbarPainterStudio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackground,
      appBar: AppBar(
        backgroundColor: _kCard,
        foregroundColor: _kInk,
        elevation: 0,
        titleSpacing: 24,
        title: Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _kAccent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.swap_vert, color: _kAccent, size: 22),
            ),
            const SizedBox(width: 12),
            const Text(
              'ScrollbarPainter Studio',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kTeal.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'flutter 3.41.6',
                style: TextStyle(
                  fontSize: 11,
                  color: _kTeal,
                  fontWeight: FontWeight.w700,
                  fontFamily: _kMono,
                ),
              ),
            ),
          ],
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: _kDivider),
        ),
      ),
      body: const _StudioBody(),
    );
  }
}

class _StudioBody extends StatelessWidget {
  const _StudioBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _HeroHeader(),
          SizedBox(height: 28),
          _DriverAndPanelsSection(),
          SizedBox(height: 28),
          _HorizontalPanelSection(),
          SizedBox(height: 28),
          _FadeDemoSection(),
          SizedBox(height: 28),
          _TrackStylingSection(),
          SizedBox(height: 28),
          _ParameterReferenceSection(),
          SizedBox(height: 28),
          _TeachingPanelSection(),
          SizedBox(height: 28),
          _FooterCard(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero header
// ---------------------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return _StudioCard(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _Pill(
                      label: 'CustomPainter',
                      color: _kAccent,
                    ),
                    const SizedBox(width: 8),
                    _Pill(
                      label: 'ChangeNotifier',
                      color: _kTeal,
                    ),
                    const SizedBox(width: 8),
                    _Pill(
                      label: 'ScrollMetrics',
                      color: _kPurple,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'One painter, every scrollbar.',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: _kInk,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ScrollbarPainter turns a ScrollMetrics into a thumb and '
                  'track on a canvas. Flutter\'s Scrollbar and RawScrollbar '
                  'widgets use it under the hood — you can too, when you '
                  'need a custom scrollable surface.',
                  style: TextStyle(
                    fontSize: 14,
                    color: _kInkSoft,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: <Widget>[
                    _KeyFact(icon: Icons.brush_outlined, label: 'paints a thumb'),
                    SizedBox(width: 18),
                    _KeyFact(icon: Icons.tune, label: '16 knobs'),
                    SizedBox(width: 18),
                    _KeyFact(icon: Icons.animation, label: 'fade-aware'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: _HeroPreview(),
          ),
        ],
      ),
    );
  }
}

class _KeyFact extends StatelessWidget {
  const _KeyFact({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 16, color: _kAccent),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: _kInkSoft,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w700,
          fontFamily: _kMono,
        ),
      ),
    );
  }
}

// A small decorative preview with a faux vertical scrollbar painted on top
// of a gradient, using a ScrollbarPainter with a hand-made ScrollMetrics.
class _HeroPreview extends StatefulWidget {
  @override
  State<_HeroPreview> createState() => _HeroPreviewState();
}

class _HeroPreviewState extends State<_HeroPreview>
    with SingleTickerProviderStateMixin {
  late final ScrollbarPainter _painter;
  late final AnimationController _breathing;
  double _heroOffset = 120;

  @override
  void initState() {
    super.initState();
    _breathing = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _painter = ScrollbarPainter(
      color: _kAccent,
      textDirection: TextDirection.ltr,
      thickness: 10,
      radius: const Radius.circular(6),
      trackRadius: const Radius.circular(6),
      trackColor: _kTrack,
      trackBorderColor: _kTrackBorder,
      mainAxisMargin: 6,
      crossAxisMargin: 4,
      fadeoutOpacityAnimation: const AlwaysStoppedAnimation<double>(1.0),
    );
    _breathing.addListener(_tick);
  }

  void _tick() {
    setState(() {
      _heroOffset = 40 + (_breathing.value * 320);
    });
  }

  @override
  void dispose() {
    _breathing.removeListener(_tick);
    _breathing.dispose();
    _painter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final metrics = FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: 400,
      pixels: _heroOffset,
      viewportDimension: 240,
      axisDirection: AxisDirection.down,
      devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
    );
    _painter.update(metrics, AxisDirection.down);
    return Container(
      height: 240,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFFFF0E0), Color(0xFFFFE3C6)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kAccent.withValues(alpha: 0.22)),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Live preview',
                    style: TextStyle(
                      color: _kAccent.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A ScrollbarPainter driven by a synthetic\n'
                    'FixedScrollMetrics and a breathing\n'
                    'AnimationController.',
                    style: TextStyle(
                      color: _kInk,
                      height: 1.4,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 2,
            top: 0,
            bottom: 0,
            width: 22,
            child: CustomPaint(
              painter: _PainterAdapter(_painter, metrics),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CustomPaint adapter
// ---------------------------------------------------------------------------

// We need to re-run painter.update when the CustomPaint lays out so that
// the metrics get sized to the *canvas* size instead of a guessed viewport.
class _PainterAdapter extends CustomPainter {
  _PainterAdapter(this.painter, this.metrics) : super(repaint: painter);

  final ScrollbarPainter painter;
  final ScrollMetrics metrics;

  @override
  void paint(Canvas canvas, Size size) {
    final fitted = FixedScrollMetrics(
      minScrollExtent: metrics.minScrollExtent,
      maxScrollExtent: metrics.maxScrollExtent,
      pixels: metrics.pixels,
      viewportDimension: size.height,
      axisDirection: metrics.axisDirection,
      devicePixelRatio: metrics.devicePixelRatio,
    );
    painter.update(fitted, fitted.axisDirection);
    painter.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant _PainterAdapter oldDelegate) {
    return oldDelegate.painter != painter || oldDelegate.metrics != metrics;
  }
}

// Horizontal variant — we need to pass horizontal size + axis.
class _HorizontalPainterAdapter extends CustomPainter {
  _HorizontalPainterAdapter(this.painter, this.metrics)
      : super(repaint: painter);

  final ScrollbarPainter painter;
  final ScrollMetrics metrics;

  @override
  void paint(Canvas canvas, Size size) {
    final fitted = FixedScrollMetrics(
      minScrollExtent: metrics.minScrollExtent,
      maxScrollExtent: metrics.maxScrollExtent,
      pixels: metrics.pixels,
      viewportDimension: size.width,
      axisDirection: AxisDirection.right,
      devicePixelRatio: metrics.devicePixelRatio,
    );
    painter.update(fitted, AxisDirection.right);
    painter.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant _HorizontalPainterAdapter oldDelegate) {
    return oldDelegate.painter != painter || oldDelegate.metrics != metrics;
  }
}

// ---------------------------------------------------------------------------
// Driver + 2x2 panels section
// ---------------------------------------------------------------------------

class _DriverAndPanelsSection extends StatefulWidget {
  const _DriverAndPanelsSection();

  @override
  State<_DriverAndPanelsSection> createState() =>
      _DriverAndPanelsSectionState();
}

class _DriverAndPanelsSectionState extends State<_DriverAndPanelsSection> {
  final ScrollController _driver = ScrollController();
  final ValueNotifier<int> _tick = ValueNotifier<int>(0);

  late final ScrollbarPainter _painterA;
  late final ScrollbarPainter _painterB;
  late final ScrollbarPainter _painterC;
  late final ScrollbarPainter _painterD;

  @override
  void initState() {
    super.initState();
    _painterA = ScrollbarPainter(
      color: _kTeal,
      textDirection: TextDirection.ltr,
      thickness: 4,
      radius: const Radius.circular(2),
      fadeoutOpacityAnimation: const AlwaysStoppedAnimation<double>(1.0),
    );
    _painterB = ScrollbarPainter(
      color: _kAccent,
      textDirection: TextDirection.ltr,
      thickness: 16,
      radius: const Radius.circular(8),
      trackColor: _kTrack,
      fadeoutOpacityAnimation: const AlwaysStoppedAnimation<double>(1.0),
    );
    _painterC = ScrollbarPainter(
      color: _kInk,
      textDirection: TextDirection.ltr,
      thickness: 8,
      radius: Radius.zero,
      crossAxisMargin: 8,
      fadeoutOpacityAnimation: const AlwaysStoppedAnimation<double>(1.0),
    );
    _painterD = ScrollbarPainter(
      color: _kPurple,
      textDirection: TextDirection.ltr,
      thickness: 12,
      radius: const Radius.circular(20),
      mainAxisMargin: 12,
      trackColor: _kPurple.withValues(alpha: 0.08),
      trackBorderColor: _kPurple.withValues(alpha: 0.4),
      trackRadius: const Radius.circular(20),
      fadeoutOpacityAnimation: const AlwaysStoppedAnimation<double>(1.0),
    );

    _driver.addListener(_bump);
  }

  void _bump() {
    _tick.value = _tick.value + 1;
  }

  @override
  void dispose() {
    _driver.removeListener(_bump);
    _driver.dispose();
    _painterA.dispose();
    _painterB.dispose();
    _painterC.dispose();
    _painterD.dispose();
    _tick.dispose();
    super.dispose();
  }

  ScrollMetrics _currentMetrics(double viewportHeight) {
    if (_driver.hasClients) {
      final ScrollPosition pos = _driver.position;
      return FixedScrollMetrics(
        minScrollExtent: pos.minScrollExtent,
        maxScrollExtent: pos.maxScrollExtent,
        pixels: pos.pixels,
        viewportDimension: viewportHeight,
        axisDirection: pos.axisDirection,
        devicePixelRatio: pos.devicePixelRatio,
      );
    }
    return FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: 2000,
      pixels: 0,
      viewportDimension: viewportHeight,
      axisDirection: AxisDirection.down,
      devicePixelRatio:
          MediaQuery.maybeOf(context)?.devicePixelRatio ?? 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _StudioCard(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            index: '01',
            title: 'Shared driver controller',
            blurb:
                'A real ListView on the left. Its ScrollController feeds four '
                'independent ScrollbarPainter previews on the right.',
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 360,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: 220,
                  child: _DriverListView(controller: _driver),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: ValueListenableBuilder<int>(
                    valueListenable: _tick,
                    builder: (BuildContext context, int _, Widget? _) {
                      return _PanelGrid(
                        metricsBuilder: _currentMetrics,
                        painterA: _painterA,
                        painterB: _painterB,
                        painterC: _painterC,
                        painterD: _painterD,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const _CalloutStrip(
            icon: Icons.lightbulb_outline,
            text:
                'Scroll the list to watch every preview\'s thumb move. The '
                'painters share one set of metrics; only their styling '
                'differs.',
          ),
        ],
      ),
    );
  }
}

class _DriverListView extends StatelessWidget {
  const _DriverListView({required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              color: _kCard,
              border: Border(
                bottom: BorderSide(color: _kDivider),
              ),
            ),
            child: const Text(
              'driver ListView',
              style: TextStyle(
                fontFamily: _kMono,
                fontSize: 11,
                color: _kInkSoft,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              padding: const EdgeInsets.all(8),
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                final hue = (index * 17) % 360;
                final color = HSLColor.fromAHSL(
                  1,
                  hue.toDouble(),
                  0.5,
                  0.82,
                ).toColor();
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: _kCard,
                        radius: 14,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: _kInk,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _sampleTitles[index % _sampleTitles.length],
                          style: const TextStyle(
                            fontSize: 12,
                            color: _kInk,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
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

const List<String> _sampleTitles = <String>[
  'Spruce Mountain',
  'Cobalt Afternoon',
  'Paper Notebook',
  'Cinnamon Thread',
  'Birch Wood Bench',
  'Olive Canvas',
  'Tangerine Kite',
  'Marble Notebook',
  'Harbor Sketch',
  'Russet Journal',
  'Plum Lantern',
  'Linen Day',
];

class _PanelGrid extends StatelessWidget {
  const _PanelGrid({
    required this.metricsBuilder,
    required this.painterA,
    required this.painterB,
    required this.painterC,
    required this.painterD,
  });

  final ScrollMetrics Function(double viewportHeight) metricsBuilder;
  final ScrollbarPainter painterA;
  final ScrollbarPainter painterB;
  final ScrollbarPainter painterC;
  final ScrollbarPainter painterD;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _PreviewPanel(
                  label: 'A',
                  title: 'hairline teal',
                  config: 'thickness: 4\nradius: 2\ncolor: teal',
                  accent: _kTeal,
                  painter: painterA,
                  metricsBuilder: metricsBuilder,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PreviewPanel(
                  label: 'B',
                  title: 'chonky with track',
                  config: 'thickness: 16\nradius: 8\ntrackColor: grey',
                  accent: _kAccent,
                  painter: painterB,
                  metricsBuilder: metricsBuilder,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _PreviewPanel(
                  label: 'C',
                  title: 'sharp ink',
                  config: 'thickness: 8\nradius: 0\ncrossAxisMargin: 8',
                  accent: _kInk,
                  painter: painterC,
                  metricsBuilder: metricsBuilder,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PreviewPanel(
                  label: 'D',
                  title: 'pill with frame',
                  config:
                      'thickness: 12\nradius: 20\nmainAxisMargin: 12\ntrack+border',
                  accent: _kPurple,
                  painter: painterD,
                  metricsBuilder: metricsBuilder,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PreviewPanel extends StatelessWidget {
  const _PreviewPanel({
    required this.label,
    required this.title,
    required this.config,
    required this.accent,
    required this.painter,
    required this.metricsBuilder,
  });

  final String label;
  final String title;
  final String config;
  final Color accent;
  final ScrollbarPainter painter;
  final ScrollMetrics Function(double viewportHeight) metricsBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.09),
              border: const Border(
                bottom: BorderSide(color: _kDivider),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: accent,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: _FauxContentBackground(accent: accent),
                ),
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints c) {
                      final metrics = metricsBuilder(c.maxHeight);
                      return CustomPaint(
                        painter: _PainterAdapter(painter, metrics),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
            decoration: const BoxDecoration(
              color: _kCard,
              border: Border(top: BorderSide(color: _kDivider)),
            ),
            child: Text(
              config,
              style: const TextStyle(
                fontFamily: _kMono,
                fontSize: 10.5,
                color: _kInkSoft,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FauxContentBackground extends StatelessWidget {
  const _FauxContentBackground({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List<Widget>.generate(6, (int i) {
          final opacity = 0.10 + (i % 3) * 0.04;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: opacity),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Horizontal scrollbar section
// ---------------------------------------------------------------------------

class _HorizontalPanelSection extends StatefulWidget {
  const _HorizontalPanelSection();

  @override
  State<_HorizontalPanelSection> createState() =>
      _HorizontalPanelSectionState();
}

class _HorizontalPanelSectionState extends State<_HorizontalPanelSection> {
  final ScrollController _hController = ScrollController();
  final ValueNotifier<int> _tick = ValueNotifier<int>(0);
  late final ScrollbarPainter _painter;

  @override
  void initState() {
    super.initState();
    _painter = ScrollbarPainter(
      color: _kAccent,
      textDirection: TextDirection.ltr,
      thickness: 10,
      radius: const Radius.circular(5),
      trackColor: _kTrack,
      trackBorderColor: _kTrackBorder,
      trackRadius: const Radius.circular(5),
      scrollbarOrientation: ScrollbarOrientation.bottom,
      fadeoutOpacityAnimation: const AlwaysStoppedAnimation<double>(1.0),
    );
    _hController.addListener(() => _tick.value = _tick.value + 1);
  }

  @override
  void dispose() {
    _hController.dispose();
    _painter.dispose();
    _tick.dispose();
    super.dispose();
  }

  ScrollMetrics _currentMetrics(double viewportWidth) {
    if (_hController.hasClients) {
      final pos = _hController.position;
      return FixedScrollMetrics(
        minScrollExtent: pos.minScrollExtent,
        maxScrollExtent: pos.maxScrollExtent,
        pixels: pos.pixels,
        viewportDimension: viewportWidth,
        axisDirection: AxisDirection.right,
        devicePixelRatio: pos.devicePixelRatio,
      );
    }
    return FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: 1600,
      pixels: 0,
      viewportDimension: viewportWidth,
      axisDirection: AxisDirection.right,
      devicePixelRatio:
          MediaQuery.maybeOf(context)?.devicePixelRatio ?? 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _StudioCard(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            index: '02',
            title: 'Horizontal orientation',
            blurb:
                'A horizontal ListView drives a horizontal ScrollbarPainter. '
                'We pass ScrollbarOrientation.bottom so the thumb sits along '
                'the bottom edge of the preview.',
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.separated(
              controller: _hController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: 24,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (BuildContext context, int index) {
                return _HorizontalTile(
                  index: index,
                  color: _horizColor(index),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: _kBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kDivider),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: _kCard,
                    border: Border(bottom: BorderSide(color: _kDivider)),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'ScrollbarOrientation.bottom preview',
                    style: TextStyle(
                      fontFamily: _kMono,
                      fontSize: 11,
                      color: _kInkSoft,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  child: ValueListenableBuilder<int>(
                    valueListenable: _tick,
                    builder: (BuildContext context, int _, Widget? _) {
                      return LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints c) {
                          final metrics = _currentMetrics(c.maxWidth);
                          return Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    12,
                                    12,
                                    12,
                                    20,
                                  ),
                                  child: Row(
                                    children: List<Widget>.generate(12,
                                        (int i) {
                                      return Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          decoration: BoxDecoration(
                                            color: _kAccent.withValues(
                                                alpha: 0.08 + (i % 4) * 0.03),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: _HorizontalPainterAdapter(
                                    _painter,
                                    metrics,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const _CalloutStrip(
            icon: Icons.swap_horiz,
            text:
                'The only differences from the vertical painter are '
                'axisDirection on the metrics (right) and the '
                'scrollbarOrientation argument on the painter.',
          ),
        ],
      ),
    );
  }

  Color _horizColor(int i) {
    const colors = <Color>[
      _kTeal,
      _kAccent,
      _kPurple,
    ];
    return colors[i % colors.length];
  }
}

class _HorizontalTile extends StatelessWidget {
  const _HorizontalTile({required this.index, required this.color});
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        border: Border.all(color: color.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
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
                'Tile ${index + 1}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'horizontal content is useful for',
            style: TextStyle(fontSize: 10.5, color: _kInkSoft),
          ),
          const Text(
            'demoing the axisDirection knob',
            style: TextStyle(fontSize: 10.5, color: _kInkSoft),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Fade demo section
// ---------------------------------------------------------------------------

class _FadeDemoSection extends StatefulWidget {
  const _FadeDemoSection();

  @override
  State<_FadeDemoSection> createState() => _FadeDemoSectionState();
}

class _FadeDemoSectionState extends State<_FadeDemoSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final ScrollbarPainter _painter;
  double _fade = 1.0;
  double _offset = 80;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1),
      value: 1.0,
    );
    _painter = ScrollbarPainter(
      color: _kPurple,
      textDirection: TextDirection.ltr,
      thickness: 10,
      radius: const Radius.circular(6),
      trackColor: _kPurple.withValues(alpha: 0.08),
      fadeoutOpacityAnimation: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _painter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _StudioCard(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            index: '03',
            title: 'Fade opacity control',
            blurb:
                'ScrollbarPainter multiplies its thumb color by '
                'fadeoutOpacityAnimation.value. Here we bind the painter to '
                'an AnimationController and drive the value with a slider.',
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: _kBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kDivider),
                  ),
                  height: 220,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'opacity: ${_fade.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontFamily: _kMono,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: _kPurple,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Drag the slider on the right to fade the '
                                'thumb in and out. This mirrors how Flutter\'s '
                                'Scrollbar widget hides the thumb after the '
                                'user stops interacting.',
                                style: TextStyle(
                                  color: _kInkSoft,
                                  fontSize: 13,
                                  height: 1.45,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'offset: ${_offset.toStringAsFixed(0)}px',
                                    style: const TextStyle(
                                      fontFamily: _kMono,
                                      fontSize: 12,
                                      color: _kInkSoft,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Slider(
                                      min: 0,
                                      max: 800,
                                      value: _offset,
                                      activeColor: _kPurple,
                                      onChanged: (double v) {
                                        setState(() {
                                          _offset = v;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4,
                        top: 0,
                        bottom: 0,
                        width: 22,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (BuildContext context, Widget? _) {
                            return LayoutBuilder(
                              builder: (
                                BuildContext context,
                                BoxConstraints c,
                              ) {
                                final metrics = FixedScrollMetrics(
                                  minScrollExtent: 0,
                                  maxScrollExtent: 800,
                                  pixels: _offset,
                                  viewportDimension: c.maxHeight,
                                  axisDirection: AxisDirection.down,
                                  devicePixelRatio:
                                      MediaQuery.of(context).devicePixelRatio,
                                );
                                return CustomPaint(
                                  painter: _PainterAdapter(_painter, metrics),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: _kCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kDivider),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'fadeoutOpacityAnimation',
                        style: TextStyle(
                          fontFamily: _kMono,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: _kInk,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _fade.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          color: _kPurple.withValues(alpha: 0.2 + 0.8 * _fade),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          min: 0,
                          max: 1,
                          value: _fade,
                          activeColor: _kPurple,
                          onChanged: (double v) {
                            setState(() {
                              _fade = v;
                              _controller.value = v;
                            });
                          },
                        ),
                      ),
                      const Text(
                        'Drag up to show, down to hide.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: _kInkSoft,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _CalloutStrip(
            icon: Icons.info_outline,
            text:
                'The painter listens to its Animation<double> and repaints '
                'whenever the value changes. Passing AlwaysStoppedAnimation(1) '
                'is the "always visible" shortcut used in the other demos.',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Track styling section
// ---------------------------------------------------------------------------

class _TrackStylingSection extends StatefulWidget {
  const _TrackStylingSection();

  @override
  State<_TrackStylingSection> createState() =>
      _TrackStylingSectionState();
}

class _TrackStylingSectionState extends State<_TrackStylingSection> {
  late final ScrollbarPainter _painter;
  double _offset = 260;

  @override
  void initState() {
    super.initState();
    _painter = ScrollbarPainter(
      color: _kTeal,
      textDirection: TextDirection.ltr,
      thickness: 14,
      radius: const Radius.circular(7),
      trackColor: _kTeal.withValues(alpha: 0.10),
      trackBorderColor: _kTeal.withValues(alpha: 0.45),
      trackRadius: const Radius.circular(7),
      mainAxisMargin: 6,
      crossAxisMargin: 3,
      fadeoutOpacityAnimation: const AlwaysStoppedAnimation<double>(1.0),
    );
  }

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _StudioCard(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            index: '04',
            title: 'Track styling',
            blurb:
                'trackColor, trackBorderColor, and trackRadius make the '
                'track visible as a framed channel the thumb slides inside.',
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 260,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _kBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _kDivider),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  'Framed track',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: _kInk,
                                  ),
                                ),
                                _callout(
                                  'trackColor',
                                  'fills the channel behind the thumb',
                                ),
                                _callout(
                                  'trackBorderColor / Width',
                                  'outlines the channel edges',
                                ),
                                _callout(
                                  'trackRadius',
                                  'lets the channel itself be pill-shaped',
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'offset: ${_offset.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontFamily: _kMono,
                                        fontSize: 12,
                                        color: _kInkSoft,
                                      ),
                                    ),
                                    Expanded(
                                      child: Slider(
                                        min: 0,
                                        max: 800,
                                        value: _offset,
                                        activeColor: _kTeal,
                                        onChanged: (double v) {
                                          setState(() {
                                            _offset = v;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: LayoutBuilder(
                            builder:
                                (BuildContext context, BoxConstraints c) {
                              final metrics = FixedScrollMetrics(
                                minScrollExtent: 0,
                                maxScrollExtent: 800,
                                pixels: _offset,
                                viewportDimension: c.maxHeight,
                                axisDirection: AxisDirection.down,
                                devicePixelRatio:
                                    MediaQuery.of(context).devicePixelRatio,
                              );
                              return CustomPaint(
                                painter: _PainterAdapter(_painter, metrics),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                flex: 2,
                child: _TrackStyleLegend(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _callout(String title, String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6, right: 8),
            decoration: const BoxDecoration(
              color: _kTeal,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 12,
                  height: 1.35,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: '$title ',
                    style: const TextStyle(
                      fontFamily: _kMono,
                      color: _kTeal,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(text: body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackStyleLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const rows = <_LegendRow>[
      _LegendRow(key_: 'trackColor', value: 'teal @ 0.10'),
      _LegendRow(key_: 'trackBorderColor', value: 'teal @ 0.45'),
      _LegendRow(key_: 'trackRadius', value: 'Radius.circular(7)'),
      _LegendRow(key_: 'mainAxisMargin', value: '6'),
      _LegendRow(key_: 'crossAxisMargin', value: '3'),
      _LegendRow(key_: 'thickness', value: '14'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'painter config',
            style: TextStyle(
              fontFamily: _kMono,
              fontSize: 11,
              color: _kInkSoft,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          for (final _LegendRow row in rows) ...<Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  row.key_,
                  style: const TextStyle(
                    fontFamily: _kMono,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _kTeal,
                  ),
                ),
                Text(
                  row.value,
                  style: const TextStyle(
                    fontFamily: _kMono,
                    fontSize: 12,
                    color: _kInk,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _LegendRow {
  const _LegendRow({required this.key_, required this.value});
  final String key_;
  final String value;
}

// ---------------------------------------------------------------------------
// Parameter reference section
// ---------------------------------------------------------------------------

class _ParameterReferenceSection extends StatelessWidget {
  const _ParameterReferenceSection();

  static const List<_ParamRow> _params = <_ParamRow>[
    _ParamRow('color', 'required', 'Thumb fill color.'),
    _ParamRow(
      'textDirection',
      'required',
      'Resolves LTR/RTL for ScrollbarOrientation defaults.',
    ),
    _ParamRow('thickness', 'required', 'Cross-axis extent of the thumb.'),
    _ParamRow(
      'fadeoutOpacityAnimation',
      'required',
      'Multiplies the thumb color alpha every paint.',
    ),
    _ParamRow(
      'shape',
      'OutlinedBorder?',
      'Alternate thumb shape; wins over radius when set.',
    ),
    _ParamRow(
      'mainAxisMargin',
      '= 0.0',
      'Inset applied along the scroll axis.',
    ),
    _ParamRow(
      'crossAxisMargin',
      '= 0.0',
      'Inset applied perpendicular to the scroll axis.',
    ),
    _ParamRow('radius', 'Radius?', 'Rounded corner radius for the thumb.'),
    _ParamRow(
      'trackRadius',
      'Radius?',
      'Rounded corner radius for the track rect.',
    ),
    _ParamRow(
      'minLength',
      '= 18.0',
      'Lower bound on the thumb length in pixels.',
    ),
    _ParamRow(
      'minOverscrollLength',
      'double?',
      'Minimum length while overscrolling; defaults to minLength.',
    ),
    _ParamRow(
      'trackColor',
      '= 0x00000000',
      'Fill color of the track rectangle.',
    ),
    _ParamRow(
      'trackBorderColor',
      '= 0x00000000',
      'Outline color of the track rectangle.',
    ),
    _ParamRow(
      'scrollbarOrientation',
      'ScrollbarOrientation?',
      'Overrides the default orientation derived from axis + textDirection.',
    ),
    _ParamRow(
      'padding',
      '= EdgeInsets.zero',
      'Inset applied inside the paint bounds before layout.',
    ),
    _ParamRow(
      'ignorePointer',
      '= false',
      'If true, hitTestInteractive always returns false.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _StudioCard(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            index: '05',
            title: 'Constructor reference',
            blurb:
                'Every knob on ScrollbarPainter, in one table. Required '
                'parameters are marked; the rest have sensible defaults.',
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: _kBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kDivider),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  color: _kCard,
                  child: Row(
                    children: const <Widget>[
                      SizedBox(
                        width: 190,
                        child: Text(
                          'parameter',
                          style: TextStyle(
                            fontFamily: _kMono,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _kInkSoft,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: Text(
                          'type / default',
                          style: TextStyle(
                            fontFamily: _kMono,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _kInkSoft,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'description',
                          style: TextStyle(
                            fontFamily: _kMono,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _kInkSoft,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: _kDivider),
                for (int i = 0; i < _params.length; i++)
                  _ParamRowView(
                    row: _params[i],
                    even: i.isEven,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ParamRow {
  const _ParamRow(this.name, this.type, this.description);
  final String name;
  final String type;
  final String description;
}

class _ParamRowView extends StatelessWidget {
  const _ParamRowView({required this.row, required this.even});
  final _ParamRow row;
  final bool even;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: even ? _kBackground : _kCard,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 190,
            child: Text(
              row.name,
              style: const TextStyle(
                fontFamily: _kMono,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: _kAccent,
              ),
            ),
          ),
          SizedBox(
            width: 170,
            child: Text(
              row.type,
              style: const TextStyle(
                fontFamily: _kMono,
                fontSize: 12,
                color: _kTeal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.description,
              style: const TextStyle(
                fontSize: 12.5,
                color: _kInk,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Teaching panel section
// ---------------------------------------------------------------------------

class _TeachingPanelSection extends StatelessWidget {
  const _TeachingPanelSection();

  static const String _snippet = '''
// Use ScrollbarPainter when you paint your own scrollable surface.
class CustomStrip extends StatefulWidget { ... }

class _CustomStripState extends State<CustomStrip>
    with SingleTickerProviderStateMixin {
  late final ScrollController _ctrl;
  late final ScrollbarPainter _painter;
  late final AnimationController _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = ScrollController();
    _fade = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _painter = ScrollbarPainter(
      color: Colors.black54,
      textDirection: TextDirection.ltr,
      thickness: 8,
      radius: const Radius.circular(4),
      fadeoutOpacityAnimation: _fade,
    );
    _ctrl.addListener(() {
      _painter.update(_ctrl.position, _ctrl.position.axisDirection);
      _fade.forward();
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      ListView(controller: _ctrl, children: const [...]),
      Positioned(
        right: 0, top: 0, bottom: 0, width: 12,
        child: CustomPaint(painter: _ScrollbarDelegate(_painter)),
      ),
    ],
  );
}
''';

  @override
  Widget build(BuildContext context) {
    return _StudioCard(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            index: '06',
            title: 'Do you need ScrollbarPainter directly?',
            blurb:
                'Usually no — prefer the Scrollbar or RawScrollbar widget. '
                'They already wrap ScrollbarPainter, manage the fade '
                'controller, and wire up drag / hover hit testing. Drop to '
                'the painter only when the scrollable surface is custom.',
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _kBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kDivider),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      _TeachingBullet(
                        kind: _BulletKind.good,
                        label: 'Scrollbar / CupertinoScrollbar',
                        body:
                            'First choice. Hover, drag, theming, fade — all '
                            'handled for you.',
                      ),
                      SizedBox(height: 10),
                      _TeachingBullet(
                        kind: _BulletKind.good,
                        label: 'RawScrollbar',
                        body:
                            'When you want to bring the painter and fade '
                            'yourself but keep the gesture plumbing.',
                      ),
                      SizedBox(height: 10),
                      _TeachingBullet(
                        kind: _BulletKind.warn,
                        label: 'ScrollbarPainter (direct)',
                        body:
                            'When you render a scrollable surface without a '
                            'Scrollable — e.g. a PageView-backed canvas, a '
                            'custom virtualized grid, or a recycled viewport '
                            'whose position is hand-simulated.',
                      ),
                      SizedBox(height: 10),
                      _TeachingBullet(
                        kind: _BulletKind.note,
                        label: 'Remember to dispose',
                        body:
                            'ScrollbarPainter is a ChangeNotifier. Call '
                            'dispose() from your State\'s dispose, alongside '
                            'the ScrollController and any AnimationController '
                            'you plug into fadeoutOpacityAnimation.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1B16),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const SelectableText(
                    _snippet,
                    style: TextStyle(
                      fontFamily: _kMono,
                      fontSize: 11.5,
                      color: Color(0xFFE7DFCE),
                      height: 1.4,
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
}

enum _BulletKind { good, warn, note }

class _TeachingBullet extends StatelessWidget {
  const _TeachingBullet({
    required this.kind,
    required this.label,
    required this.body,
  });
  final _BulletKind kind;
  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    late final Color color;
    late final IconData icon;
    switch (kind) {
      case _BulletKind.good:
        color = _kTeal;
        icon = Icons.check_circle_outline;
        break;
      case _BulletKind.warn:
        color = _kAccent;
        icon = Icons.build_outlined;
        break;
      case _BulletKind.note:
        color = _kPurple;
        icon = Icons.info_outline;
        break;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 2),
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  fontFamily: _kMono,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: _kInkSoft,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Footer card
// ---------------------------------------------------------------------------

class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    return _StudioCard(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _kAccent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.auto_awesome, color: _kAccent),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'ScrollbarPainter in one sentence',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: _kInk,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Given ScrollMetrics + a canvas, paint a styled thumb and '
                  'optional track — that\'s it. Everything else in this '
                  'studio is sugar on top.',
                  style: TextStyle(
                    color: _kInkSoft,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          _Pill(label: 'demo v1', color: _kPurple),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared chrome widgets
// ---------------------------------------------------------------------------

class _StudioCard extends StatelessWidget {
  const _StudioCard({required this.child, this.padding});
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kDivider),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.blurb,
  });

  final String index;
  final String title;
  final String blurb;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            index,
            style: const TextStyle(
              fontFamily: _kMono,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _kAccent,
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
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                blurb,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CalloutStrip extends StatelessWidget {
  const _CalloutStrip({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _kAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kAccent.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 18, color: _kAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _kInk,
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
// End of file — ScrollbarPainter Studio
// ---------------------------------------------------------------------------
