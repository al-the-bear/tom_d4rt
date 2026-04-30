// D4rt AST harness script — deep visual demo of the four main
// ScrollController variants shipping in the Flutter framework:
//
//   1. ScrollController          — base class, single ScrollPosition
//   2. TrackingScrollController  — attaches to many positions at once
//   3. PrimaryScrollController   — InheritedWidget providing a shared one
//   4. PageController            — ScrollController specialised for PageView
//
// The build() entry point returns a MaterialApp(home: ...). There is no
// main(), no runApp(), no foundation.dart import. debugPrint from
// material.dart is used for diagnostics, and Color.withValues(alpha: ...)
// is used in preference to the deprecated withOpacity().

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette — one accent colour per controller type
// ---------------------------------------------------------------------------

const Color kAccentScroll = Color(0xFF6D28D9); // purple — ScrollController
const Color kAccentTrack = Color(0xFFDB2777); // magenta — TrackingScrollController
const Color kAccentPrimary = Color(0xFF0E9488); // teal   — PrimaryScrollController
const Color kAccentPage = Color(0xFFF59E0B); // amber  — PageController

const Color kInk = Color(0xFF111827);
const Color kInkMuted = Color(0xFF4B5563);
const Color kSurface = Color(0xFFFAFAFA);
const Color kCardBg = Color(0xFFFFFFFF);
const Color kCardOutline = Color(0xFFE5E7EB);
const Color kMonoBg = Color(0xFF0B1021);
const Color kMonoInk = Color(0xFFE2E8F0);

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('ScrollControllersTypesDemo: build() entered');
  debugPrint('ScrollControllersTypesDemo: four controllers on stage:');
  debugPrint('  - ScrollController         (single position)');
  debugPrint('  - TrackingScrollController (many positions)');
  debugPrint('  - PrimaryScrollController  (inherited)');
  debugPrint('  - PageController           (PageView driver)');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Four ScrollController Types',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: kAccentScroll,
      scaffoldBackgroundColor: kSurface,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.w700,
          color: kInk,
        ),
        bodyMedium: TextStyle(color: kInk),
      ),
    ),
    home: const _ControllersShowcaseScreen(),
  );
}

// ---------------------------------------------------------------------------
// Root screen — hosts all demo cards vertically in a CustomScrollView
// ---------------------------------------------------------------------------

class _ControllersShowcaseScreen extends StatefulWidget {
  const _ControllersShowcaseScreen();

  @override
  State<_ControllersShowcaseScreen> createState() =>
      _ControllersShowcaseScreenState();
}

class _ControllersShowcaseScreenState
    extends State<_ControllersShowcaseScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('ShowcaseScreen: initState — mounting demo cards');
  }

  @override
  void dispose() {
    debugPrint('ShowcaseScreen: dispose — root screen unmounted');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          children: const <Widget>[
            _HeroHeader(),
            SizedBox(height: 20),
            _ScrollControllerCard(),
            SizedBox(height: 20),
            _TrackingScrollControllerCard(),
            SizedBox(height: 20),
            _PrimaryScrollControllerCard(),
            SizedBox(height: 20),
            _PageControllerCard(),
            SizedBox(height: 20),
            _ComparisonTableCard(),
            SizedBox(height: 20),
            _WhenToUseCard(),
            SizedBox(height: 20),
            _CodeSnippetCard(),
            SizedBox(height: 20),
            _TeachingPanelCard(),
            SizedBox(height: 20),
            _FooterCard(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable card chrome — coloured top strip + title + body + metrics footer
// ---------------------------------------------------------------------------

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.metrics,
    this.icon,
  });

  final Color accent;
  final String title;
  final String subtitle;
  final Widget body;
  final Widget metrics;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kCardOutline),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Top coloured strip — identity ribbon
          Container(
            height: 6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  accent,
                  accent.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
          // Title row
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
            child: Row(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    icon ?? Icons.swap_vert,
                    color: accent,
                    size: 20,
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
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: kInk,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: kInkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
            child: body,
          ),
          // Metrics footer
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.05),
              border: Border(
                top: BorderSide(color: accent.withValues(alpha: 0.15)),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: metrics,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. Hero header — "Four ScrollController Types" + 4-quadrant preview
// ---------------------------------------------------------------------------

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1E1B4B),
            Color(0xFF4C1D95),
            Color(0xFF831843),
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Flutter scrolling deep-dive',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFDDD6FE),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Four ScrollController Types',
                  style: TextStyle(
                    fontSize: 26,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'ScrollController · TrackingScrollController · '
                  'PrimaryScrollController · PageController',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFE9D5FF),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const _QuadrantPreview(),
        ],
      ),
    );
  }
}

class _QuadrantPreview extends StatelessWidget {
  const _QuadrantPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      padding: const EdgeInsets.all(6),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                _previewTile(kAccentScroll, Icons.view_list),
                const SizedBox(width: 4),
                _previewTile(kAccentTrack, Icons.vertical_align_center),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Row(
              children: <Widget>[
                _previewTile(kAccentPrimary, Icons.account_tree),
                const SizedBox(width: 4),
                _previewTile(kAccentPage, Icons.view_carousel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewTile(Color c, IconData icon) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. ScrollController card — single ListView driven by one controller
// ---------------------------------------------------------------------------

class _ScrollControllerCard extends StatefulWidget {
  const _ScrollControllerCard();

  @override
  State<_ScrollControllerCard> createState() => _ScrollControllerCardState();
}

class _ScrollControllerCardState extends State<_ScrollControllerCard> {
  final ScrollController _controller = ScrollController();

  double _pixels = 0;
  double _minExtent = 0;
  double _maxExtent = 0;
  double _sliderValue = 0;
  bool _hasClientsNow = false;

  @override
  void initState() {
    super.initState();
    debugPrint('ScrollController card: initState — attaching listener');
    _controller.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onScroll());
  }

  void _onScroll() {
    if (!mounted) return;
    final bool attached = _controller.hasClients;
    final double px = attached ? _controller.position.pixels : 0;
    final double min =
        attached ? _controller.position.minScrollExtent : 0;
    final double max =
        attached ? _controller.position.maxScrollExtent : 0;
    setState(() {
      _pixels = px;
      _minExtent = min;
      _maxExtent = max;
      _hasClientsNow = attached;
      if (max > 0) {
        _sliderValue = (px / max).clamp(0.0, 1.0);
      }
    });
  }

  Future<void> _jumpToStart() async {
    debugPrint('ScrollController card: jumpTo(0)');
    if (_controller.hasClients) _controller.jumpTo(0);
  }

  Future<void> _animateToEnd() async {
    if (!_controller.hasClients) return;
    debugPrint('ScrollController card: animateTo(maxExtent)');
    await _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _animatePlus200() async {
    if (!_controller.hasClients) return;
    final double target = (_controller.position.pixels + 200)
        .clamp(0.0, _controller.position.maxScrollExtent);
    debugPrint('ScrollController card: animateTo(+200) target=$target');
    await _controller.animateTo(
      target,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeInOut,
    );
  }

  void _scrub(double value) {
    if (!_controller.hasClients) return;
    final double target =
        (value * _controller.position.maxScrollExtent).clamp(
      _controller.position.minScrollExtent,
      _controller.position.maxScrollExtent,
    );
    _controller.jumpTo(target);
  }

  @override
  void dispose() {
    debugPrint('ScrollController card: dispose — releasing controller');
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      accent: kAccentScroll,
      icon: Icons.view_list,
      title: '1. ScrollController',
      subtitle: 'Base class — one controller drives one ScrollPosition.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: kAccentScroll.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: kAccentScroll.withValues(alpha: 0.18),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: ListView.builder(
              controller: _controller,
              itemCount: 30,
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemBuilder: (BuildContext context, int index) {
                final double t = (index % 10) / 10.0;
                final Color tile =
                    Color.lerp(kAccentScroll, const Color(0xFFF472B6), t)!;
                return Container(
                  height: 36,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: tile.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: tile.withValues(alpha: 0.4),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: tile,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Row ${index + 1} — pixel counted',
                        style: const TextStyle(fontSize: 13, color: kInk),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          // Scrub slider
          Row(
            children: <Widget>[
              const Icon(Icons.drag_indicator,
                  size: 18, color: kInkMuted),
              Expanded(
                child: Slider(
                  activeColor: kAccentScroll,
                  value: _sliderValue,
                  onChanged: (double v) {
                    setState(() => _sliderValue = v);
                    _scrub(v);
                  },
                ),
              ),
              SizedBox(
                width: 64,
                child: Text(
                  '${(_sliderValue * 100).toStringAsFixed(0)}%',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: kAccentScroll,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _PillButton(
                color: kAccentScroll,
                icon: Icons.first_page,
                label: 'Jump to start',
                onPressed: _jumpToStart,
              ),
              _PillButton(
                color: kAccentScroll,
                icon: Icons.fast_forward,
                label: 'Animate +200',
                onPressed: _animatePlus200,
              ),
              _PillButton(
                color: kAccentScroll,
                icon: Icons.last_page,
                label: 'Animate to end',
                onPressed: _animateToEnd,
              ),
            ],
          ),
        ],
      ),
      metrics: _MetricsRow(
        accent: kAccentScroll,
        entries: <_MetricEntry>[
          _MetricEntry('pixels', _pixels.toStringAsFixed(1)),
          _MetricEntry('min', _minExtent.toStringAsFixed(1)),
          _MetricEntry('max', _maxExtent.toStringAsFixed(1)),
          _MetricEntry('hasClients', _hasClientsNow.toString()),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. TrackingScrollController card — two ListViews share ONE controller
// ---------------------------------------------------------------------------

class _TrackingScrollControllerCard extends StatefulWidget {
  const _TrackingScrollControllerCard();

  @override
  State<_TrackingScrollControllerCard> createState() =>
      _TrackingScrollControllerCardState();
}

class _TrackingScrollControllerCardState
    extends State<_TrackingScrollControllerCard> {
  final TrackingScrollController _tracker = TrackingScrollController();
  final GlobalKey _listKey1 = GlobalKey();
  final GlobalKey _listKey2 = GlobalKey();

  int _activeIndex = 0; // 1 or 2; 0 = none
  double _pixels1 = 0;
  double _pixels2 = 0;

  @override
  void initState() {
    super.initState();
    debugPrint(
        'TrackingScrollController card: initState — tracker listening');
    _tracker.addListener(_onTrackerChanged);
  }

  void _onTrackerChanged() {
    if (!mounted) return;
    final ScrollPosition? recent = _tracker.mostRecentlyUpdatedPosition;
    // mostRecentlyUpdatedPosition returns whichever ScrollPosition was last
    // touched; comparing by identity across the tracker's positions tells us
    // which ListView was scrolled.
    int activeIdx = 0;
    final List<ScrollPosition> attached = _tracker.positions.toList();
    double p1 = 0;
    double p2 = 0;
    if (attached.isNotEmpty) {
      p1 = attached[0].pixels;
      if (attached.length > 1) p2 = attached[1].pixels;
      if (recent != null) {
        if (attached.isNotEmpty && identical(recent, attached[0])) {
          activeIdx = 1;
        } else if (attached.length > 1 && identical(recent, attached[1])) {
          activeIdx = 2;
        }
      }
    }
    setState(() {
      _activeIndex = activeIdx;
      _pixels1 = p1;
      _pixels2 = p2;
    });
  }

  @override
  void dispose() {
    debugPrint('TrackingScrollController card: dispose — tracker released');
    _tracker.removeListener(_onTrackerChanged);
    _tracker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      accent: kAccentTrack,
      icon: Icons.vertical_align_center,
      title: '2. TrackingScrollController',
      subtitle:
          'Attaches to MANY ScrollPositions; tracks most-recently-scrolled.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _ActiveBadge(
            index: _activeIndex,
            accent: kAccentTrack,
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _trackedList(
                  label: 'List #1',
                  isActive: _activeIndex == 1,
                  key: _listKey1,
                  startHue: 0.0,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _trackedList(
                  label: 'List #2',
                  isActive: _activeIndex == 2,
                  key: _listKey2,
                  startHue: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Teach-note: mostRecentlyUpdatedPosition points at whichever '
            'scrollable the user touched last. The other ScrollPosition is '
            'still attached — TrackingScrollController never "chooses" a '
            'single owner.',
            style: TextStyle(color: kInkMuted, fontSize: 12, height: 1.4),
          ),
        ],
      ),
      metrics: _MetricsRow(
        accent: kAccentTrack,
        entries: <_MetricEntry>[
          _MetricEntry('active', _activeIndex == 0 ? '—' : '#$_activeIndex'),
          _MetricEntry('#1 px', _pixels1.toStringAsFixed(1)),
          _MetricEntry('#2 px', _pixels2.toStringAsFixed(1)),
          _MetricEntry('positions', _tracker.positions.length.toString()),
        ],
      ),
    );
  }

  Widget _trackedList({
    required String label,
    required bool isActive,
    required Key key,
    required double startHue,
  }) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: kAccentTrack.withValues(alpha: isActive ? 0.08 : 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: kAccentTrack.withValues(alpha: isActive ? 0.6 : 0.2),
          width: isActive ? 2 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: kAccentTrack.withValues(alpha: isActive ? 0.25 : 0.08),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              children: <Widget>[
                Icon(
                  isActive ? Icons.flash_on : Icons.flash_off,
                  size: 14,
                  color: isActive ? kAccentTrack : kInkMuted,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: isActive ? kAccentTrack : kInkMuted,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              key: key,
              controller: _tracker,
              itemCount: 40,
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemBuilder: (BuildContext context, int index) {
                final double t =
                    ((startHue + index / 40.0) % 1.0).clamp(0.0, 1.0);
                final Color c = Color.lerp(
                  kAccentTrack,
                  const Color(0xFFF472B6),
                  t,
                )!;
                return Container(
                  height: 28,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$label · row ${index + 1}',
                    style: const TextStyle(fontSize: 11, color: kInk),
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

class _ActiveBadge extends StatelessWidget {
  const _ActiveBadge({required this.index, required this.accent});

  final int index;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final String text = index == 0
        ? 'Active position: — none yet'
        : 'Active position: List #$index';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.radio_button_checked, size: 14, color: accent),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. PrimaryScrollController card — InheritedWidget providing a shared one
// ---------------------------------------------------------------------------

class _PrimaryScrollControllerCard extends StatefulWidget {
  const _PrimaryScrollControllerCard();

  @override
  State<_PrimaryScrollControllerCard> createState() =>
      _PrimaryScrollControllerCardState();
}

class _PrimaryScrollControllerCardState
    extends State<_PrimaryScrollControllerCard> {
  final ScrollController _primary = ScrollController();
  double _primaryPx = 0;
  double _siblingPx = 0;

  @override
  void initState() {
    super.initState();
    debugPrint(
        'PrimaryScrollController card: initState — primary + sibling wired');
    _primary.addListener(_onPrimary);
  }

  void _onPrimary() {
    if (!mounted || !_primary.hasClients) return;
    setState(() => _primaryPx = _primary.position.pixels);
  }

  Future<void> _scrollToTop() async {
    debugPrint('PrimaryScrollController card: animateTo(0)');
    if (!_primary.hasClients) return;
    await _primary.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    debugPrint('PrimaryScrollController card: dispose — releasing primary');
    _primary.removeListener(_onPrimary);
    _primary.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      accent: kAccentPrimary,
      icon: Icons.account_tree,
      title: '3. PrimaryScrollController',
      subtitle:
          'InheritedWidget: scrollables with primary: true opt in by default.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // The primary-wrapped subtree
              Expanded(
                flex: 3,
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: kAccentPrimary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: kAccentPrimary.withValues(alpha: 0.25),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: PrimaryScrollController(
                    controller: _primary,
                    child: CustomScrollView(
                      // primary defaults to true for vertical CustomScrollView
                      slivers: <Widget>[
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 10, 12, 6),
                            child: Text(
                              'CustomScrollView (primary: true)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: kAccentPrimary,
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              final Color c = Color.lerp(
                                kAccentPrimary,
                                const Color(0xFF22D3EE),
                                (index % 10) / 10.0,
                              )!;
                              return Container(
                                height: 34,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: c.withValues(alpha: 0.18),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Primary row ${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: kInk,
                                  ),
                                ),
                              );
                            },
                            childCount: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Sibling scrollable with primary: false — NOT affected
              Expanded(
                flex: 2,
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kCardOutline),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: NotificationListener<ScrollUpdateNotification>(
                    onNotification: (ScrollUpdateNotification n) {
                      if (mounted) {
                        setState(() => _siblingPx = n.metrics.pixels);
                      }
                      return false;
                    },
                    child: ListView.builder(
                      primary: false, // opts out of PrimaryScrollController
                      itemCount: 25,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 28,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF9CA3AF)
                                .withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sibling row ${index + 1}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: kInkMuted,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              _PillButton(
                color: kAccentPrimary,
                icon: Icons.vertical_align_top,
                label: 'Primary: scroll to top',
                onPressed: _scrollToTop,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'The sibling on the right sets primary: false, so the '
                  'external controller does not move it.',
                  style: TextStyle(
                    color: kInkMuted,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      metrics: _MetricsRow(
        accent: kAccentPrimary,
        entries: <_MetricEntry>[
          _MetricEntry('primary px', _primaryPx.toStringAsFixed(1)),
          _MetricEntry('sibling px', _siblingPx.toStringAsFixed(1)),
          _MetricEntry(
            'attached',
            _primary.hasClients ? 'yes' : 'no',
          ),
          const _MetricEntry('inherited', 'via InheritedWidget'),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. PageController card — PageView with viewportFraction and page indicator
// ---------------------------------------------------------------------------

class _PageControllerCard extends StatefulWidget {
  const _PageControllerCard();

  @override
  State<_PageControllerCard> createState() => _PageControllerCardState();
}

class _PageControllerCardState extends State<_PageControllerCard> {
  static const int _initialPage = 0;
  static const double _viewportFraction = 0.85;

  final PageController _page = PageController(
    initialPage: _initialPage,
    viewportFraction: _viewportFraction,
    keepPage: true,
  );

  double _currentPage = _initialPage.toDouble();
  int _indicatorPage = _initialPage;

  static const List<_PageData> _pages = <_PageData>[
    _PageData('Welcome', Icons.waving_hand, Color(0xFFF59E0B),
        'Kick off your onboarding flow.'),
    _PageData('Connect', Icons.cable, Color(0xFFEF4444),
        'Link your accounts and data sources.'),
    _PageData('Customize', Icons.tune, Color(0xFF8B5CF6),
        'Pick a palette and layout density.'),
    _PageData('Invite', Icons.group_add, Color(0xFF0E9488),
        'Add teammates and assign roles.'),
    _PageData('Review', Icons.fact_check, Color(0xFF2563EB),
        'Double-check before you launch.'),
    _PageData('Launch', Icons.rocket_launch, Color(0xFFDB2777),
        'Go live — PageController snaps into place.'),
  ];

  @override
  void initState() {
    super.initState();
    debugPrint('PageController card: initState (viewportFraction='
        '$_viewportFraction, initialPage=$_initialPage)');
    _page.addListener(_onPage);
  }

  void _onPage() {
    if (!mounted || !_page.hasClients) return;
    final double? p = _page.page;
    if (p == null) return;
    setState(() {
      _currentPage = p;
      _indicatorPage = p.round().clamp(0, _pages.length - 1);
    });
  }

  Future<void> _next() async {
    if (!_page.hasClients) return;
    final int next = (_indicatorPage + 1).clamp(0, _pages.length - 1);
    debugPrint('PageController card: animateToPage($next)');
    await _page.animateToPage(
      next,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _prev() async {
    if (!_page.hasClients) return;
    final int prev = (_indicatorPage - 1).clamp(0, _pages.length - 1);
    debugPrint('PageController card: animateToPage($prev)');
    await _page.animateToPage(
      prev,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    debugPrint('PageController card: dispose — page controller released');
    _page.removeListener(_onPage);
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      accent: kAccentPage,
      icon: Icons.view_carousel,
      title: '4. PageController',
      subtitle: 'Extends ScrollController — adds paging and viewportFraction.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 220,
            child: PageView.builder(
              controller: _page,
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                final _PageData data = _pages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 4),
                  child: _OnboardingPage(data: data),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          _PageIndicator(
            count: _pages.length,
            current: _indicatorPage,
            accent: kAccentPage,
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              _PillButton(
                color: kAccentPage,
                icon: Icons.chevron_left,
                label: 'Prev',
                onPressed: _prev,
              ),
              const SizedBox(width: 8),
              _PillButton(
                color: kAccentPage,
                icon: Icons.chevron_right,
                label: 'Next',
                onPressed: _next,
              ),
              const Spacer(),
              Text(
                'page = ${_currentPage.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: kAccentPage,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
      metrics: _MetricsRow(
        accent: kAccentPage,
        entries: <_MetricEntry>[
          _MetricEntry('page', _currentPage.toStringAsFixed(2)),
          const _MetricEntry('initialPage', '$_initialPage'),
          const _MetricEntry('viewportFraction', '$_viewportFraction'),
          _MetricEntry('total', _pages.length.toString()),
        ],
      ),
    );
  }
}

class _PageData {
  const _PageData(this.title, this.icon, this.color, this.caption);
  final String title;
  final IconData icon;
  final Color color;
  final String caption;
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.data});
  final _PageData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            data.color,
            data.color.withValues(alpha: 0.65),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: data.color.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(data.icon, color: Colors.white, size: 22),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                data.caption,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.count,
    required this.current,
    required this.accent,
  });

  final int count;
  final int current;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(count, (int i) {
        final bool active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          width: active ? 22 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color:
                active ? accent : accent.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. Comparison table — columns: Controller | Extends | #positions | Use
// ---------------------------------------------------------------------------

class _ComparisonTableCard extends StatelessWidget {
  const _ComparisonTableCard();

  static const List<_TableRow> _rows = <_TableRow>[
    _TableRow(
      name: 'ScrollController',
      extend: 'ChangeNotifier',
      positions: '1',
      use: 'Single named handle to one scrollable.',
      accent: kAccentScroll,
    ),
    _TableRow(
      name: 'TrackingScrollController',
      extend: 'ScrollController',
      positions: 'N',
      use: 'Many scrollables share offset state.',
      accent: kAccentTrack,
    ),
    _TableRow(
      name: 'PrimaryScrollController',
      extend: 'InheritedWidget',
      positions: 'N (implicit)',
      use: 'Scaffold back-to-top, implicit Scrollbar wiring.',
      accent: kAccentPrimary,
    ),
    _TableRow(
      name: 'PageController',
      extend: 'ScrollController',
      positions: '1 (paged)',
      use: 'PageView carousels, onboarding flows.',
      accent: kAccentPage,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kCardOutline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: kInk.withValues(alpha: 0.04),
              border: const Border(
                bottom: BorderSide(color: kCardOutline),
              ),
            ),
            child: Row(
              children: const <Widget>[
                Icon(Icons.table_rows, size: 18, color: kInk),
                SizedBox(width: 8),
                Text(
                  'Comparison',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: kInk,
                  ),
                ),
              ],
            ),
          ),
          const _TableHeader(),
          for (final _TableRow row in _rows) _TableBodyRow(row: row),
        ],
      ),
    );
  }
}

class _TableRow {
  const _TableRow({
    required this.name,
    required this.extend,
    required this.positions,
    required this.use,
    required this.accent,
  });
  final String name;
  final String extend;
  final String positions;
  final String use;
  final Color accent;
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF9FAFB),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: const <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              'Controller',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: kInkMuted,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Extends',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: kInkMuted,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '# positions',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: kInkMuted,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Typical use',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: kInkMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableBodyRow extends StatelessWidget {
  const _TableBodyRow({required this.row});
  final _TableRow row;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: kCardOutline)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: row.accent,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    row.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: kInk,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.extend,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: kInkMuted,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.positions,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: kInk,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              row.use,
              style: const TextStyle(
                fontSize: 12,
                color: kInkMuted,
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
// 7. When-to-use tips — 4 tiles in a Wrap
// ---------------------------------------------------------------------------

class _WhenToUseCard extends StatelessWidget {
  const _WhenToUseCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kCardOutline),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.lightbulb_outline, size: 18, color: kInk),
              SizedBox(width: 8),
              Text(
                'When to use which',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: kInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const <Widget>[
              _TipTile(
                accent: kAccentScroll,
                icon: Icons.view_list,
                title: 'ScrollController',
                body:
                    'Use when you need a named handle to ONE scrollable — '
                    'jumpTo, animateTo, listening to pixels.',
              ),
              _TipTile(
                accent: kAccentTrack,
                icon: Icons.vertical_align_center,
                title: 'TrackingScrollController',
                body:
                    'Use when multiple scrollables must share state — '
                    'e.g. NestedScrollView, parallel list panels.',
              ),
              _TipTile(
                accent: kAccentPrimary,
                icon: Icons.account_tree,
                title: 'PrimaryScrollController',
                body:
                    'Use for implicit Scrollbar wiring and Scaffold '
                    'back-to-top on the primary scrollable.',
              ),
              _TipTile(
                accent: kAccentPage,
                icon: Icons.view_carousel,
                title: 'PageController',
                body:
                    'Use for paginated or carousel UI — onboarding, '
                    'image galleries, step-by-step wizards.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TipTile extends StatelessWidget {
  const _TipTile({
    required this.accent,
    required this.icon,
    required this.title,
    required this.body,
  });

  final Color accent;
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Container(
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accent.withValues(alpha: 0.3)),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, color: accent, size: 16),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: accent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: const TextStyle(
                fontSize: 12,
                color: kInk,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8. Code-snippet card — monospace canonical instantiations, side-by-side
// ---------------------------------------------------------------------------

class _CodeSnippetCard extends StatelessWidget {
  const _CodeSnippetCard();

  static const List<_Snippet> _snippets = <_Snippet>[
    _Snippet(
      accent: kAccentScroll,
      title: 'ScrollController',
      code: 'final c = ScrollController(\n'
          '  initialScrollOffset: 0,\n'
          '  keepScrollOffset: true,\n'
          ');\n\n'
          'c.jumpTo(0);\n'
          'await c.animateTo(\n'
          '  max,\n'
          '  duration: Duration(ms: 400),\n'
          '  curve: Curves.easeOut,\n'
          ');',
    ),
    _Snippet(
      accent: kAccentTrack,
      title: 'TrackingScrollController',
      code: 'final t = TrackingScrollController();\n\n'
          'ListView(controller: t, ...);\n'
          'ListView(controller: t, ...);\n\n'
          'final ScrollPosition? active =\n'
          '    t.mostRecentlyUpdatedPosition;\n'
          '// identity check against\n'
          '// t.positions gives "which".',
    ),
    _Snippet(
      accent: kAccentPrimary,
      title: 'PrimaryScrollController',
      code: 'PrimaryScrollController(\n'
          '  controller: c,\n'
          '  child: CustomScrollView(\n'
          '    // primary: true by default\n'
          '    slivers: [...],\n'
          '  ),\n'
          ');\n\n'
          'PrimaryScrollController.of(ctx)\n'
          '  ?.animateTo(0, ...);',
    ),
    _Snippet(
      accent: kAccentPage,
      title: 'PageController',
      code: 'final p = PageController(\n'
          '  initialPage: 0,\n'
          '  viewportFraction: 0.85,\n'
          '  keepPage: true,\n'
          ');\n\n'
          'PageView(controller: p, ...);\n'
          'await p.animateToPage(3,\n'
          '  duration: Duration(ms: 400),\n'
          '  curve: Curves.easeOut,\n'
          ');',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kCardOutline),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.code, size: 18, color: kInk),
              SizedBox(width: 8),
              Text(
                'Canonical instantiations',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: kInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              for (final _Snippet s in _snippets) _SnippetBlock(snippet: s),
            ],
          ),
        ],
      ),
    );
  }
}

class _Snippet {
  const _Snippet({
    required this.accent,
    required this.title,
    required this.code,
  });
  final Color accent;
  final String title;
  final String code;
}

class _SnippetBlock extends StatelessWidget {
  const _SnippetBlock({required this.snippet});
  final _Snippet snippet;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Container(
        decoration: BoxDecoration(
          color: kMonoBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: snippet.accent.withValues(alpha: 0.55)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: snippet.accent.withValues(alpha: 0.25),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: snippet.accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    snippet.title,
                    style: TextStyle(
                      color: snippet.accent,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                snippet.code,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: kMonoInk,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 9. Teaching panel — gotchas
// ---------------------------------------------------------------------------

class _TeachingPanelCard extends StatelessWidget {
  const _TeachingPanelCard();

  static const List<_Gotcha> _gotchas = <_Gotcha>[
    _Gotcha(
      icon: Icons.warning_amber,
      color: Color(0xFFEA580C),
      title: 'Forgetting to dispose',
      body:
          'All four controllers extend ChangeNotifier and hold listener '
          'closures. Always call dispose() in State.dispose to avoid '
          'leaks and stale callbacks after unmount.',
    ),
    _Gotcha(
      icon: Icons.block,
      color: Color(0xFFB91C1C),
      title: 'Plain ScrollController + multiple scrollables',
      body:
          'Attaching ONE ScrollController to two simultaneously mounted '
          'ListViews triggers an assertion: "ScrollController attached '
          'to multiple positions". Use TrackingScrollController instead, '
          'or hand each scrollable its own controller.',
    ),
    _Gotcha(
      icon: Icons.account_tree,
      color: Color(0xFF0E9488),
      title: 'PrimaryScrollController inheritance rules',
      body:
          'Vertical scrollables with primary: true (the default on mobile '
          'for some) pick up the nearest PrimaryScrollController. If you '
          'do not want that, set primary: false explicitly, or scope the '
          'PrimaryScrollController tighter with a wrapper widget.',
    ),
    _Gotcha(
      icon: Icons.swap_calls,
      color: Color(0xFF6D28D9),
      title: 'initialScrollOffset on ScrollController',
      body:
          'The controller cannot jumpTo() before a frame has laid out the '
          'scrollable. If you need to start scrolled, pass '
          'initialScrollOffset at construction time — not via jumpTo in '
          'initState.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kCardOutline),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.school, size: 18, color: kInk),
              SizedBox(width: 8),
              Text(
                'Teaching panel — gotchas',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: kInk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final _Gotcha g in _gotchas) ...<Widget>[
            _GotchaRow(gotcha: g),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _Gotcha {
  const _Gotcha({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String body;
}

class _GotchaRow extends StatelessWidget {
  const _GotchaRow({required this.gotcha});
  final _Gotcha gotcha;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: gotcha.color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: gotcha.color.withValues(alpha: 0.25)),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: gotcha.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(9),
            ),
            alignment: Alignment.center,
            child: Icon(gotcha.icon, color: gotcha.color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  gotcha.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: gotcha.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  gotcha.body,
                  style: const TextStyle(
                    fontSize: 12,
                    color: kInk,
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

// ---------------------------------------------------------------------------
// 10. Footer card — summary
// ---------------------------------------------------------------------------

class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF111827),
            Color(0xFF1F2937),
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.check_circle,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Summary',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Four controllers cover the scrolling surface area of Flutter: '
            'ScrollController for a single named handle, '
            'TrackingScrollController for shared-state across many '
            'scrollables, PrimaryScrollController for implicit opt-in via '
            'the inherited widget, and PageController for page-snapping '
            'PageViews. They all share the ScrollController contract — '
            'hasClients, position, jumpTo, animateTo — and differ in how '
            'many ScrollPositions they manage and how subtrees find them.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _FooterChip(label: 'disposed in State.dispose',
                  color: kAccentScroll),
              _FooterChip(
                  label: 'no runApp / no main', color: kAccentTrack),
              _FooterChip(
                  label: 'withValues(alpha:)', color: kAccentPrimary),
              _FooterChip(label: 'debugPrint only', color: kAccentPage),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterChip extends StatelessWidget {
  const _FooterChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared bits — pill buttons + metrics row
// ---------------------------------------------------------------------------

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.color,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onPressed,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricEntry {
  const _MetricEntry(this.label, this.value);
  final String label;
  final String value;
}

class _MetricsRow extends StatelessWidget {
  const _MetricsRow({required this.accent, required this.entries});
  final Color accent;
  final List<_MetricEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < entries.length; i++) ...<Widget>[
          Expanded(
            child: _MetricCell(accent: accent, entry: entries[i]),
          ),
          if (i < entries.length - 1)
            Container(
              width: 1,
              height: 30,
              color: accent.withValues(alpha: 0.2),
              margin: const EdgeInsets.symmetric(horizontal: 6),
            ),
        ],
      ],
    );
  }
}

class _MetricCell extends StatelessWidget {
  const _MetricCell({required this.accent, required this.entry});
  final Color accent;
  final _MetricEntry entry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          entry.label,
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
            color: accent.withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          entry.value,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: kInk,
          ),
        ),
      ],
    );
  }
}
