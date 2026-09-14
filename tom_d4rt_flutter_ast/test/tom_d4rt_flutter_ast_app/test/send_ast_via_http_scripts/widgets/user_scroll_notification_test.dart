// D4rt test script: Deep Demo — UserScrollNotification
// -----------------------------------------------------------------------------
// Seismograph-style exploration of UserScrollNotification, the subclass of
// ScrollNotification that fires when the user changes direction on a
// Scrollable (ScrollDirection.idle / forward / reverse). The demo wires a
// NotificationListener<UserScrollNotification> into real scrollables and
// records each event as a cream/red/black seismograph trace.
//
// Visual scenarios in this file:
//   1. Preamble anatomy card — what the notification represents and how it
//      differs from ScrollStartNotification / ScrollUpdateNotification.
//   2. Primary seismograph — a tall ListView feeding a rolling CustomPainter
//      strip with direction needle and scroll-offset ink trace.
//   3. Counter panel — badges counting idle / forward / reverse events.
//   4. Multi-scrollable dashboard — three scrollables with independent
//      listeners showing notification.depth bubbling.
//   5. Pinned-header hide pattern — practical hide-on-forward, show-on-reverse.
//   6. Notification filtering — a switch that suppresses idle events.
//   7. Epilogue — production tips (debouncing, vs ScrollController, rebuilds).
//
// The harness contract: no main()/runApp(); the top-level `build(context)`
// returns a MaterialApp whose home is a stateful demo widget.
// -----------------------------------------------------------------------------

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// =============================================================================
// Theme — seismograph paper
// =============================================================================

class _UsnTheme {
  static const Color paper = Color(0xFFF7EFD9);
  static const Color paperAlt = Color(0xFFEFE3C2);
  static const Color paperDeep = Color(0xFFE6D6AE);
  static const Color ink = Color(0xFF181411);
  static const Color inkSoft = Color(0xFF3A332B);
  static const Color needle = Color(0xFFB8321A);
  static const Color needleHot = Color(0xFFE1482B);
  static const Color teal = Color(0xFF1F6E6A);
  static const Color tealSoft = Color(0xFF4FA49F);
  static const Color amber = Color(0xFFB8860B);
  static const Color mute = Color(0xFF8A7A5C);
  static const Color card = Color(0xFFFFF8E5);
  static const Color divider = Color(0xFFB8A57A);
}

// =============================================================================
// Records — compact event model
// =============================================================================

/// A single captured seismograph sample derived from a UserScrollNotification
/// (or a synthetic idle sample when no events arrive for a while).
class _UsnRec {
  final int index;
  final DateTime at;
  final ScrollDirection direction;
  final double pixels;
  final double maxScrollExtent;
  final int depth;
  final String source;

  const _UsnRec({
    required this.index,
    required this.at,
    required this.direction,
    required this.pixels,
    required this.maxScrollExtent,
    required this.depth,
    required this.source,
  });

  double get normalizedOffset {
    if (maxScrollExtent <= 0) return 0;
    return (pixels / maxScrollExtent).clamp(0.0, 1.0);
  }

  String get directionLabel {
    switch (direction) {
      case ScrollDirection.idle:
        return 'idle';
      case ScrollDirection.forward:
        return 'forward';
      case ScrollDirection.reverse:
        return 'reverse';
    }
  }
}

/// Running counter state used for the badge panel.
class _UsnCounters {
  int idle;
  int forward;
  int reverse;

  _UsnCounters({this.idle = 0, this.forward = 0, this.reverse = 0});

  int get total => idle + forward + reverse;

  void bump(ScrollDirection d) {
    switch (d) {
      case ScrollDirection.idle:
        idle += 1;
        break;
      case ScrollDirection.forward:
        forward += 1;
        break;
      case ScrollDirection.reverse:
        reverse += 1;
        break;
    }
  }

  void reset() {
    idle = 0;
    forward = 0;
    reverse = 0;
  }

  _UsnCounters copy() =>
      _UsnCounters(idle: idle, forward: forward, reverse: reverse);
}

// =============================================================================
// Entry point: d4rt harness `build` function
// =============================================================================

dynamic build(BuildContext context) {
  debugPrint('UserScrollNotification deep demo building');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'UserScrollNotification — Seismograph',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _UsnTheme.paper,
      primaryColor: _UsnTheme.teal,
      colorScheme: const ColorScheme.light(
        primary: _UsnTheme.teal,
        secondary: _UsnTheme.needle,
        surface: _UsnTheme.card,
        onSurface: _UsnTheme.ink,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _UsnTheme.ink, fontSize: 14),
        bodySmall: TextStyle(color: _UsnTheme.inkSoft, fontSize: 12),
        titleMedium: TextStyle(
            color: _UsnTheme.ink, fontSize: 16, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(
            color: _UsnTheme.ink, fontSize: 20, fontWeight: FontWeight.w800),
      ),
      dividerColor: _UsnTheme.divider,
    ),
    home: const _UsnSeismographApp(),
  );
}

// =============================================================================
// Top-level stateful app container
// =============================================================================

class _UsnSeismographApp extends StatefulWidget {
  const _UsnSeismographApp();

  @override
  State<_UsnSeismographApp> createState() => _UsnSeismographAppState();
}

class _UsnSeismographAppState extends State<_UsnSeismographApp> {
  // --- primary seismograph state -----------------------------------------
  final List<_UsnRec> _primarySamples = <_UsnRec>[];
  final _UsnCounters _primaryCounters = _UsnCounters();
  ScrollDirection _primaryDirection = ScrollDirection.idle;
  int _primaryCounter = 0;

  // --- multi-scrollable dashboard state ----------------------------------
  final List<_UsnRec> _dashSamples = <_UsnRec>[];
  final Map<String, ScrollDirection> _dashDirections = <String, ScrollDirection>{
    'feed-a': ScrollDirection.idle,
    'feed-b': ScrollDirection.idle,
    'feed-c': ScrollDirection.idle,
  };
  final Map<String, _UsnCounters> _dashCounters = <String, _UsnCounters>{
    'feed-a': _UsnCounters(),
    'feed-b': _UsnCounters(),
    'feed-c': _UsnCounters(),
  };
  int _dashCounter = 0;

  // --- pinned-header state -----------------------------------------------
  bool _pinnedHeaderVisible = true;
  ScrollDirection _pinnedHeaderDir = ScrollDirection.idle;
  int _pinnedUpdates = 0;

  // --- filtering + tempo --------------------------------------------------
  bool _suppressIdle = false;
  double _stripTimescale = 1.0;
  bool _showDepthBadges = true;

  // --- controllers -------------------------------------------------------
  final ScrollController _primaryCtrl = ScrollController();
  final ScrollController _dashACtrl = ScrollController();
  final ScrollController _dashBCtrl = ScrollController();
  final ScrollController _dashCCtrl = ScrollController();
  final ScrollController _pinnedCtrl = ScrollController();
  final ScrollController _pageCtrl = ScrollController();

  static const int _maxSamplesPerStrip = 120;

  @override
  void dispose() {
    _primaryCtrl.dispose();
    _dashACtrl.dispose();
    _dashBCtrl.dispose();
    _dashCCtrl.dispose();
    _pinnedCtrl.dispose();
    _pageCtrl.dispose();
    super.dispose();
  }

  // ----- notification ingestion ------------------------------------------

  bool _onPrimaryUserScroll(UserScrollNotification n) {
    if (_suppressIdle && n.direction == ScrollDirection.idle) {
      return false;
    }
    final rec = _UsnRec(
      index: _primaryCounter++,
      at: DateTime.now(),
      direction: n.direction,
      pixels: n.metrics.pixels,
      maxScrollExtent: n.metrics.maxScrollExtent,
      depth: n.depth,
      source: 'primary',
    );
    setState(() {
      _primaryDirection = n.direction;
      _primaryCounters.bump(n.direction);
      _primarySamples.add(rec);
      if (_primarySamples.length > _maxSamplesPerStrip) {
        _primarySamples.removeRange(
            0, _primarySamples.length - _maxSamplesPerStrip);
      }
    });
    return false;
  }

  bool _onDashUserScroll(UserScrollNotification n, String source) {
    if (_suppressIdle && n.direction == ScrollDirection.idle) {
      return false;
    }
    final rec = _UsnRec(
      index: _dashCounter++,
      at: DateTime.now(),
      direction: n.direction,
      pixels: n.metrics.pixels,
      maxScrollExtent: n.metrics.maxScrollExtent,
      depth: n.depth,
      source: source,
    );
    setState(() {
      _dashDirections[source] = n.direction;
      _dashCounters[source]!.bump(n.direction);
      _dashSamples.add(rec);
      if (_dashSamples.length > _maxSamplesPerStrip * 2) {
        _dashSamples.removeRange(
            0, _dashSamples.length - _maxSamplesPerStrip * 2);
      }
    });
    return false;
  }

  bool _onPinnedUserScroll(UserScrollNotification n) {
    setState(() {
      _pinnedHeaderDir = n.direction;
      _pinnedUpdates += 1;
      if (n.direction == ScrollDirection.forward) {
        _pinnedHeaderVisible = true;
      } else if (n.direction == ScrollDirection.reverse) {
        _pinnedHeaderVisible = false;
      }
    });
    return false;
  }

  // ----- actions ---------------------------------------------------------

  Future<void> _autoScrollPrimary() async {
    if (!_primaryCtrl.hasClients) return;
    final pos = _primaryCtrl.position;
    final target = pos.pixels < pos.maxScrollExtent / 2
        ? pos.maxScrollExtent
        : 0.0;
    await _primaryCtrl.animateTo(
      target,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _autoScrollDash(String which) async {
    ScrollController? c;
    switch (which) {
      case 'feed-a':
        c = _dashACtrl;
        break;
      case 'feed-b':
        c = _dashBCtrl;
        break;
      case 'feed-c':
        c = _dashCCtrl;
        break;
    }
    if (c == null || !c.hasClients) return;
    final pos = c.position;
    final target =
        pos.pixels < pos.maxScrollExtent / 2 ? pos.maxScrollExtent : 0.0;
    await c.animateTo(
      target,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
    );
  }

  void _resetAll() {
    setState(() {
      _primarySamples.clear();
      _primaryCounters.reset();
      _primaryDirection = ScrollDirection.idle;
      _primaryCounter = 0;
      _dashSamples.clear();
      for (final k in _dashCounters.keys) {
        _dashCounters[k]!.reset();
      }
      for (final k in _dashDirections.keys) {
        _dashDirections[k] = ScrollDirection.idle;
      }
      _dashCounter = 0;
      _pinnedHeaderVisible = true;
      _pinnedHeaderDir = ScrollDirection.idle;
      _pinnedUpdates = 0;
    });
  }

  // ----- build -----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _UsnTheme.paper,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _pageCtrl,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildPreambleSection(),
              const SizedBox(height: 22),
              _buildControlsCard(),
              const SizedBox(height: 22),
              _buildPrimarySeismographSection(),
              const SizedBox(height: 22),
              _buildCounterPanelSection(),
              const SizedBox(height: 22),
              _buildDashboardSection(),
              const SizedBox(height: 22),
              _buildPinnedHeaderSection(),
              const SizedBox(height: 22),
              _buildFilteringSection(),
              const SizedBox(height: 22),
              _buildEpilogueSection(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _UsnTheme.paperAlt,
      elevation: 0,
      title: Row(
        children: const <Widget>[
          Icon(Icons.graphic_eq, color: _UsnTheme.needle),
          SizedBox(width: 10),
          Text(
            'UserScrollNotification — Seismograph',
            style: TextStyle(
              color: _UsnTheme.ink,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          tooltip: 'Reset traces',
          onPressed: _resetAll,
          icon: const Icon(Icons.restart_alt, color: _UsnTheme.ink),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(3),
        child: Container(height: 3, color: _UsnTheme.divider),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 1 — Preamble anatomy
  // -----------------------------------------------------------------------

  Widget _buildPreambleSection() {
    return _UsnSection(
      badge: '01',
      title: 'Anatomy of a UserScrollNotification',
      subtitle:
          'What fires, when it fires, and how it differs from other scroll notifications.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _UsnFactGrid(facts: const <_UsnFact>[
            _UsnFact(
              icon: Icons.category,
              label: 'Class',
              value: 'UserScrollNotification extends ScrollNotification',
            ),
            _UsnFact(
              icon: Icons.swap_vert,
              label: 'Field',
              value: 'ScrollDirection direction — idle / forward / reverse',
            ),
            _UsnFact(
              icon: Icons.tune,
              label: 'Fires when',
              value:
                  'The user changes the direction of the drag on a Scrollable.',
            ),
            _UsnFact(
              icon: Icons.layers,
              label: 'Bubbles via',
              value: 'NotificationListener; depth increments per Viewport.',
            ),
            _UsnFact(
              icon: Icons.compare_arrows,
              label: 'Not the same as',
              value:
                  'ScrollStartNotification (drag begins) or ScrollUpdateNotification (offset delta).',
            ),
            _UsnFact(
              icon: Icons.auto_graph,
              label: 'Use case',
              value:
                  'Hide/show toolbars, pause animations, report engagement analytics.',
            ),
          ]),
          const SizedBox(height: 14),
          _UsnCompareTable(rows: const <_UsnCompareRow>[
            _UsnCompareRow(
              lifecycle: 'ScrollStartNotification',
              fires: 'Once per user gesture or animation start',
              carries: 'metrics',
            ),
            _UsnCompareRow(
              lifecycle: 'ScrollUpdateNotification',
              fires: 'Every pixel change while scrolling',
              carries: 'metrics, scrollDelta, dragDetails',
            ),
            _UsnCompareRow(
              lifecycle: 'UserScrollNotification',
              fires: 'User changes drag direction (incl. idle)',
              carries: 'metrics, direction',
            ),
            _UsnCompareRow(
              lifecycle: 'ScrollEndNotification',
              fires: 'Scroll activity ends',
              carries: 'metrics, dragDetails',
            ),
            _UsnCompareRow(
              lifecycle: 'OverscrollNotification',
              fires: 'Attempted scroll beyond bounds',
              carries: 'metrics, overscroll, velocity',
            ),
          ]),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION — Global controls card (timescale / suppress idle / depth)
  // -----------------------------------------------------------------------

  Widget _buildControlsCard() {
    return _UsnSection(
      badge: '02',
      title: 'Instrument controls',
      subtitle:
          'These controls apply globally — tune the seismograph paper feed rate and event filter.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _UsnSliderRow(
            label: 'Strip timescale',
            minLabel: '0.5x',
            maxLabel: '2.0x',
            value: _stripTimescale,
            min: 0.5,
            max: 2.0,
            divisions: 15,
            valueLabel: '${_stripTimescale.toStringAsFixed(2)}x',
            onChanged: (v) => setState(() => _stripTimescale = v),
          ),
          const Divider(height: 22, color: _UsnTheme.divider),
          _UsnSwitchRow(
            title: 'Suppress idle notifications',
            subtitle:
                'Drop UserScrollNotifications whose direction is ScrollDirection.idle.',
            value: _suppressIdle,
            onChanged: (v) => setState(() => _suppressIdle = v),
          ),
          const Divider(height: 22, color: _UsnTheme.divider),
          _UsnSwitchRow(
            title: 'Show depth badges',
            subtitle:
                'Annotate each trace with notification.depth (0 = local, >0 = bubbled).',
            value: _showDepthBadges,
            onChanged: (v) => setState(() => _showDepthBadges = v),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 2 — Primary seismograph
  // -----------------------------------------------------------------------

  Widget _buildPrimarySeismographSection() {
    return _UsnSection(
      badge: '03',
      title: 'Primary seismograph',
      subtitle:
          'A tall ListView feeds a NotificationListener<UserScrollNotification>. '
          'Each direction change paints an ink trace on the rolling strip.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 160,
            child: _UsnSeismographStrip(
              samples: _primarySamples,
              timescale: _stripTimescale,
              showDepth: _showDepthBadges,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              _UsnDirectionNeedle(direction: _primaryDirection),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Live direction: ${_describeDirection(_primaryDirection)} · '
                  'samples captured: ${_primarySamples.length}',
                  style: const TextStyle(
                    color: _UsnTheme.inkSoft,
                    fontSize: 13,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: _autoScrollPrimary,
                style: TextButton.styleFrom(
                  foregroundColor: _UsnTheme.teal,
                ),
                icon: const Icon(Icons.play_arrow, size: 18),
                label: const Text('Auto-scroll'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: _UsnTheme.card,
              border: Border.all(color: _UsnTheme.divider),
              borderRadius: BorderRadius.circular(10),
            ),
            child: NotificationListener<UserScrollNotification>(
              onNotification: _onPrimaryUserScroll,
              child: ListView.builder(
                controller: _primaryCtrl,
                padding: const EdgeInsets.all(12),
                itemCount: 60,
                itemBuilder: (context, index) =>
                    _UsnListRow(index: index, palette: _UsnTheme.teal),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _UsnHelperCaption(
              text:
                  'Drag the list above. Note how ScrollDirection flips between '
                  'forward and reverse when you reverse direction, and returns '
                  'to idle when the drag ends.'),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 3 — Counter panel
  // -----------------------------------------------------------------------

  Widget _buildCounterPanelSection() {
    final c = _primaryCounters;
    return _UsnSection(
      badge: '04',
      title: 'Counter panel',
      subtitle:
          'Aggregated UserScrollNotification direction counts for the primary feed.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _UsnCountBadge(
                  label: 'idle',
                  count: c.idle,
                  color: _UsnTheme.mute,
                  icon: Icons.pause_circle_outline,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _UsnCountBadge(
                  label: 'forward',
                  count: c.forward,
                  color: _UsnTheme.teal,
                  icon: Icons.north,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _UsnCountBadge(
                  label: 'reverse',
                  count: c.reverse,
                  color: _UsnTheme.needle,
                  icon: Icons.south,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _UsnProportionBar(counters: c),
          const SizedBox(height: 10),
          Text(
            'Total captured: ${c.total}',
            style: const TextStyle(
              color: _UsnTheme.inkSoft,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 4 — Multi-scrollable dashboard
  // -----------------------------------------------------------------------

  Widget _buildDashboardSection() {
    return _UsnSection(
      badge: '05',
      title: 'Multi-scrollable dashboard',
      subtitle:
          'Three independent scrollables. Each sends its own UserScrollNotifications; '
          'notification.depth confirms the level of nesting.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _buildDashFeed(
                  title: 'Feed A · horizontal',
                  source: 'feed-a',
                  ctrl: _dashACtrl,
                  axis: Axis.horizontal,
                  swatch: _UsnTheme.teal,
                  itemCount: 30,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDashFeed(
                  title: 'Feed B · vertical',
                  source: 'feed-b',
                  ctrl: _dashBCtrl,
                  axis: Axis.vertical,
                  swatch: _UsnTheme.amber,
                  itemCount: 40,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDashFeed(
                  title: 'Feed C · vertical',
                  source: 'feed-c',
                  ctrl: _dashCCtrl,
                  axis: Axis.vertical,
                  swatch: _UsnTheme.needle,
                  itemCount: 50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 140,
            child: _UsnSeismographStrip(
              samples: _dashSamples,
              timescale: _stripTimescale,
              showDepth: _showDepthBadges,
              useSourceColors: true,
            ),
          ),
          const SizedBox(height: 10),
          _UsnDashLegend(
            entries: <_UsnDashLegendEntry>[
              _UsnDashLegendEntry(
                label: 'feed-a',
                color: _UsnTheme.teal,
                direction: _dashDirections['feed-a']!,
                counters: _dashCounters['feed-a']!,
              ),
              _UsnDashLegendEntry(
                label: 'feed-b',
                color: _UsnTheme.amber,
                direction: _dashDirections['feed-b']!,
                counters: _dashCounters['feed-b']!,
              ),
              _UsnDashLegendEntry(
                label: 'feed-c',
                color: _UsnTheme.needle,
                direction: _dashDirections['feed-c']!,
                counters: _dashCounters['feed-c']!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashFeed({
    required String title,
    required String source,
    required ScrollController ctrl,
    required Axis axis,
    required Color swatch,
    required int itemCount,
  }) {
    final dir = _dashDirections[source]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: swatch,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: _UsnTheme.ink,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              tooltip: 'Auto-scroll',
              onPressed: () => _autoScrollDash(source),
              icon: const Icon(Icons.play_arrow, size: 16),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 28,
                minHeight: 28,
              ),
              color: _UsnTheme.teal,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'dir: ${_describeDirection(dir)}',
          style: const TextStyle(color: _UsnTheme.inkSoft, fontSize: 11),
        ),
        const SizedBox(height: 6),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: _UsnTheme.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _UsnTheme.divider),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: NotificationListener<UserScrollNotification>(
              onNotification: (n) => _onDashUserScroll(n, source),
              child: axis == Axis.horizontal
                  ? ListView.builder(
                      controller: ctrl,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemCount: itemCount,
                      itemBuilder: (ctx, i) =>
                          _UsnHChip(index: i, color: swatch),
                    )
                  : ListView.builder(
                      controller: ctrl,
                      padding: const EdgeInsets.all(8),
                      itemCount: itemCount,
                      itemBuilder: (ctx, i) =>
                          _UsnMiniRow(index: i, color: swatch),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 5 — Pinned-header hide pattern
  // -----------------------------------------------------------------------

  Widget _buildPinnedHeaderSection() {
    return _UsnSection(
      badge: '06',
      title: 'Hide-on-forward, show-on-reverse',
      subtitle:
          'A pinned header listens to UserScrollNotifications and hides when '
          'the user scrolls forward, reappears on reverse.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: _UsnTheme.card,
              border: Border.all(color: _UsnTheme.divider),
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: NotificationListener<UserScrollNotification>(
                    onNotification: _onPinnedUserScroll,
                    child: ListView.builder(
                      controller: _pinnedCtrl,
                      padding: const EdgeInsets.fromLTRB(12, 60, 12, 12),
                      itemCount: 80,
                      itemBuilder: (ctx, i) =>
                          _UsnListRow(index: i, palette: _UsnTheme.needle),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  left: 0,
                  right: 0,
                  top: _pinnedHeaderVisible ? 0 : -56,
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  child: _UsnPinnedHeader(
                    visible: _pinnedHeaderVisible,
                    direction: _pinnedHeaderDir,
                    updates: _pinnedUpdates,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _UsnHelperCaption(
              text:
                  'Implementation tip: only toggle visibility when the direction '
                  'actually changed. This avoids rebuilding the pinned widget '
                  'on every duplicate event.'),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 6 — Notification filtering
  // -----------------------------------------------------------------------

  Widget _buildFilteringSection() {
    return _UsnSection(
      badge: '07',
      title: 'Filtering idle events',
      subtitle:
          'Toggle the "Suppress idle" switch in the instrument controls above. '
          'The filter is applied at the NotificationListener callback.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _UsnCodePreview(lines: const <String>[
            'NotificationListener<UserScrollNotification>(',
            '  onNotification: (n) {',
            '    if (suppressIdle && n.direction == ScrollDirection.idle) {',
            '      return false; // drop the event before doing any work',
            '    }',
            '    _record(n);',
            '    return false; // let the notification continue to bubble',
            '  },',
            '  child: _theScrollable,',
            ')',
          ]),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              _UsnMiniStat(
                label: 'Currently',
                value: _suppressIdle ? 'Idle suppressed' : 'All events',
                color: _suppressIdle ? _UsnTheme.needle : _UsnTheme.teal,
              ),
              const SizedBox(width: 10),
              _UsnMiniStat(
                label: 'Primary idle count',
                value: '${_primaryCounters.idle}',
                color: _UsnTheme.mute,
              ),
              const SizedBox(width: 10),
              _UsnMiniStat(
                label: 'Primary total',
                value: '${_primaryCounters.total}',
                color: _UsnTheme.amber,
              ),
            ],
          ),
          const SizedBox(height: 8),
          _UsnHelperCaption(
            text:
                'Filtering at the listener is cheaper than filtering downstream '
                'because you avoid triggering setState() for events that would '
                'not change UI state.',
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // SECTION 7 — Epilogue / production tips
  // -----------------------------------------------------------------------

  Widget _buildEpilogueSection() {
    return _UsnSection(
      badge: '08',
      title: 'Epilogue — production tips',
      subtitle:
          'When UserScrollNotification is the right tool, and when it is not.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _UsnTip(
            icon: Icons.speed,
            color: _UsnTheme.teal,
            title: 'Debounce state updates',
            body:
                'Flutter may fire many UserScrollNotifications per second on '
                'fast gestures. Only setState when the direction actually '
                'transitions; ignore repeats of the same direction.',
          ),
          _UsnTip(
            icon: Icons.handyman,
            color: _UsnTheme.amber,
            title: 'Prefer this over ScrollController for direction',
            body:
                'ScrollController.position.userScrollDirection works, but '
                'requires you to observe the controller. A NotificationListener '
                'is typically less boilerplate and composes better with nested '
                'scrollables.',
          ),
          _UsnTip(
            icon: Icons.filter_alt,
            color: _UsnTheme.needle,
            title: 'Filter by depth',
            body:
                'If you only care about local scrolls, check notification.depth '
                '== 0 in onNotification. Parent listeners otherwise receive '
                'events bubbling up from descendants.',
          ),
          _UsnTip(
            icon: Icons.warning_amber,
            color: _UsnTheme.mute,
            title: 'Do not place expensive work in the callback',
            body:
                'The notification callback runs on the build/layout path. '
                'Offload analytics reporting, animations, or network work to '
                'a microtask or a ticker.',
          ),
          _UsnTip(
            icon: Icons.flag,
            color: _UsnTheme.tealSoft,
            title: 'Combine with ScrollEndNotification for commit semantics',
            body:
                'For "hide on scroll" UI, pair UserScrollNotification with a '
                'ScrollEndNotification listener to "finalize" direction after '
                'the gesture concludes — avoids jitter at the idle boundary.',
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------

  String _describeDirection(ScrollDirection d) {
    switch (d) {
      case ScrollDirection.idle:
        return 'idle';
      case ScrollDirection.forward:
        return 'forward';
      case ScrollDirection.reverse:
        return 'reverse';
    }
  }
}

// =============================================================================
// Reusable visual parts
// =============================================================================

class _UsnSection extends StatelessWidget {
  final String badge;
  final String title;
  final String subtitle;
  final Widget child;

  const _UsnSection({
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _UsnTheme.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _UsnTheme.divider),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _UsnTheme.ink.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _UsnTheme.needle,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: _UsnTheme.paper,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
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
                        color: _UsnTheme.ink,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: _UsnTheme.inkSoft,
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ---- fact grid ---------------------------------------------------------------

class _UsnFact {
  final IconData icon;
  final String label;
  final String value;
  const _UsnFact(
      {required this.icon, required this.label, required this.value});
}

class _UsnFactGrid extends StatelessWidget {
  final List<_UsnFact> facts;
  const _UsnFactGrid({required this.facts});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth < 520 ? 1 : 2;
        final rows = <Widget>[];
        for (var i = 0; i < facts.length; i += cols) {
          final chunk = facts.skip(i).take(cols).toList();
          rows.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var j = 0; j < chunk.length; j++) ...<Widget>[
                Expanded(child: _UsnFactTile(fact: chunk[j])),
                if (j != chunk.length - 1) const SizedBox(width: 10),
              ],
              if (chunk.length < cols)
                for (var k = chunk.length; k < cols; k++) ...<Widget>[
                  const SizedBox(width: 10),
                  const Expanded(child: SizedBox.shrink()),
                ],
            ],
          ));
          rows.add(const SizedBox(height: 10));
        }
        if (rows.isNotEmpty) rows.removeLast();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rows,
        );
      },
    );
  }
}

class _UsnFactTile extends StatelessWidget {
  final _UsnFact fact;
  const _UsnFactTile({required this.fact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _UsnTheme.paperAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _UsnTheme.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _UsnTheme.teal.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Icon(fact.icon, size: 16, color: _UsnTheme.teal),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  fact.label,
                  style: const TextStyle(
                    color: _UsnTheme.inkSoft,
                    fontSize: 11,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  fact.value,
                  style: const TextStyle(
                    color: _UsnTheme.ink,
                    fontSize: 13,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
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

// ---- comparison table -------------------------------------------------------

class _UsnCompareRow {
  final String lifecycle;
  final String fires;
  final String carries;
  const _UsnCompareRow({
    required this.lifecycle,
    required this.fires,
    required this.carries,
  });
}

class _UsnCompareTable extends StatelessWidget {
  final List<_UsnCompareRow> rows;
  const _UsnCompareTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _UsnTheme.paperAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _UsnTheme.divider),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: _UsnTheme.divider)),
            ),
            child: Row(
              children: const <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    'Notification',
                    style: TextStyle(
                        fontSize: 11,
                        color: _UsnTheme.inkSoft,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Fires when',
                    style: TextStyle(
                        fontSize: 11,
                        color: _UsnTheme.inkSoft,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Carries',
                    style: TextStyle(
                        fontSize: 11,
                        color: _UsnTheme.inkSoft,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6),
                  ),
                ),
              ],
            ),
          ),
          for (final row in rows)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: rows.indexOf(row).isEven
                    ? Colors.transparent
                    : _UsnTheme.paper.withValues(alpha: 0.6),
                border: Border(
                  bottom: rows.last == row
                      ? BorderSide.none
                      : const BorderSide(color: _UsnTheme.divider, width: 0.5),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(
                      row.lifecycle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: _UsnTheme.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      row.fires,
                      style: const TextStyle(
                        fontSize: 12,
                        color: _UsnTheme.inkSoft,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      row.carries,
                      style: const TextStyle(
                        fontSize: 12,
                        color: _UsnTheme.inkSoft,
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

// ---- slider row -------------------------------------------------------------

class _UsnSliderRow extends StatelessWidget {
  final String label;
  final String minLabel;
  final String maxLabel;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final String valueLabel;
  final ValueChanged<double> onChanged;

  const _UsnSliderRow({
    required this.label,
    required this.minLabel,
    required this.maxLabel,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.valueLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(
              color: _UsnTheme.ink,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        Text(minLabel,
            style: const TextStyle(color: _UsnTheme.mute, fontSize: 11)),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: _UsnTheme.needle,
              inactiveTrackColor: _UsnTheme.divider,
              thumbColor: _UsnTheme.needle,
              overlayColor: _UsnTheme.needle.withValues(alpha: 0.2),
              valueIndicatorColor: _UsnTheme.needle,
              valueIndicatorTextStyle:
                  const TextStyle(color: _UsnTheme.paper),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              label: valueLabel,
              onChanged: onChanged,
            ),
          ),
        ),
        Text(maxLabel,
            style: const TextStyle(color: _UsnTheme.mute, fontSize: 11)),
        const SizedBox(width: 10),
        SizedBox(
          width: 54,
          child: Text(
            valueLabel,
            style: const TextStyle(
              color: _UsnTheme.needle,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

// ---- switch row -------------------------------------------------------------

class _UsnSwitchRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _UsnSwitchRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _UsnTheme.ink,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _UsnTheme.inkSoft,
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: _UsnTheme.needle,
          activeTrackColor: _UsnTheme.needle.withValues(alpha: 0.35),
          inactiveThumbColor: _UsnTheme.mute,
          inactiveTrackColor: _UsnTheme.divider,
        ),
      ],
    );
  }
}

// ---- direction needle -------------------------------------------------------

class _UsnDirectionNeedle extends StatelessWidget {
  final ScrollDirection direction;
  const _UsnDirectionNeedle({required this.direction});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    String label;
    switch (direction) {
      case ScrollDirection.idle:
        icon = Icons.horizontal_rule;
        color = _UsnTheme.mute;
        label = 'idle';
        break;
      case ScrollDirection.forward:
        icon = Icons.north_east;
        color = _UsnTheme.teal;
        label = 'forward';
        break;
      case ScrollDirection.reverse:
        icon = Icons.south_east;
        color = _UsnTheme.needle;
        label = 'reverse';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---- count badge ------------------------------------------------------------

class _UsnCountBadge extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;

  const _UsnCountBadge({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '$count',
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ---- proportion bar ---------------------------------------------------------

class _UsnProportionBar extends StatelessWidget {
  final _UsnCounters counters;
  const _UsnProportionBar({required this.counters});

  @override
  Widget build(BuildContext context) {
    final total = counters.total;
    if (total == 0) {
      return Container(
        height: 16,
        decoration: BoxDecoration(
          color: _UsnTheme.paperAlt,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _UsnTheme.divider),
        ),
        alignment: Alignment.center,
        child: const Text(
          'no samples yet — scroll the primary feed to fill this bar',
          style: TextStyle(color: _UsnTheme.mute, fontSize: 11),
        ),
      );
    }
    final idleFrac = counters.idle / total;
    final forwardFrac = counters.forward / total;
    final reverseFrac = counters.reverse / total;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 16,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: (idleFrac * 1000).round().clamp(0, 1000),
              child: Container(color: _UsnTheme.mute),
            ),
            Expanded(
              flex: (forwardFrac * 1000).round().clamp(0, 1000),
              child: Container(color: _UsnTheme.teal),
            ),
            Expanded(
              flex: (reverseFrac * 1000).round().clamp(0, 1000),
              child: Container(color: _UsnTheme.needle),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- dashboard legend -------------------------------------------------------

class _UsnDashLegendEntry {
  final String label;
  final Color color;
  final ScrollDirection direction;
  final _UsnCounters counters;

  const _UsnDashLegendEntry({
    required this.label,
    required this.color,
    required this.direction,
    required this.counters,
  });
}

class _UsnDashLegend extends StatelessWidget {
  final List<_UsnDashLegendEntry> entries;
  const _UsnDashLegend({required this.entries});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _UsnTheme.paperAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _UsnTheme.divider),
      ),
      child: Column(
        children: <Widget>[
          for (final e in entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: e.color,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: Text(
                      e.label,
                      style: const TextStyle(
                        color: _UsnTheme.ink,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  _UsnDirectionNeedle(direction: e.direction),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'idle ${e.counters.idle} · fwd ${e.counters.forward} · rev ${e.counters.reverse}',
                      style: const TextStyle(
                        color: _UsnTheme.inkSoft,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.end,
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

// ---- list rows --------------------------------------------------------------

class _UsnListRow extends StatelessWidget {
  final int index;
  final Color palette;
  const _UsnListRow({required this.index, required this.palette});

  @override
  Widget build(BuildContext context) {
    final shades = <double>[0.1, 0.18, 0.26];
    final alpha = shades[index % shades.length];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: palette.withValues(alpha: alpha),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: palette.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: palette,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: _UsnTheme.paper,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sample row #${index + 1}',
                  style: const TextStyle(
                    color: _UsnTheme.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Drag to trigger a UserScrollNotification.',
                  style: const TextStyle(
                    color: _UsnTheme.inkSoft,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.drag_indicator, color: _UsnTheme.mute),
        ],
      ),
    );
  }
}

class _UsnMiniRow extends StatelessWidget {
  final int index;
  final Color color;
  const _UsnMiniRow({required this.index, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 6,
            height: 18,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Row ${index + 1}',
              style: const TextStyle(
                color: _UsnTheme.ink,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UsnHChip extends StatelessWidget {
  final int index;
  final Color color;
  const _UsnHChip({required this.index, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 46,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.inventory_2, color: color, size: 16),
          Text(
            '#$index',
            style: const TextStyle(
              color: _UsnTheme.ink,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---- code preview ----------------------------------------------------------

class _UsnCodePreview extends StatelessWidget {
  final List<String> lines;
  const _UsnCodePreview({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _UsnTheme.ink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (var i = 0; i < lines.length; i++)
            Row(
              children: <Widget>[
                SizedBox(
                  width: 28,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: _UsnTheme.mute,
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    lines[i],
                    style: const TextStyle(
                      color: _UsnTheme.paper,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      height: 1.45,
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

// ---- mini stat -------------------------------------------------------------

class _UsnMiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _UsnMiniStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- helper caption --------------------------------------------------------

class _UsnHelperCaption extends StatelessWidget {
  final String text;
  const _UsnHelperCaption({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _UsnTheme.paperAlt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _UsnTheme.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.info_outline, color: _UsnTheme.teal, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _UsnTheme.inkSoft,
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

// ---- pinned header ---------------------------------------------------------

class _UsnPinnedHeader extends StatelessWidget {
  final bool visible;
  final ScrollDirection direction;
  final int updates;

  const _UsnPinnedHeader({
    required this.visible,
    required this.direction,
    required this.updates,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: _UsnTheme.needle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _UsnTheme.ink.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.push_pin, color: _UsnTheme.paper, size: 18),
          const SizedBox(width: 10),
          const Text(
            'Pinned header',
            style: TextStyle(
              color: _UsnTheme.paper,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _UsnTheme.paper.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_label(direction)} · $updates',
              style: const TextStyle(
                color: _UsnTheme.paper,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _label(ScrollDirection d) {
    switch (d) {
      case ScrollDirection.idle:
        return 'idle';
      case ScrollDirection.forward:
        return 'forward';
      case ScrollDirection.reverse:
        return 'reverse';
    }
  }
}

// ---- tip card --------------------------------------------------------------

class _UsnTip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;

  const _UsnTip({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.32)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: _UsnTheme.inkSoft,
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

// =============================================================================
// Seismograph strip — CustomPainter
// =============================================================================

class _UsnSeismographStrip extends StatelessWidget {
  final List<_UsnRec> samples;
  final double timescale;
  final bool showDepth;
  final bool useSourceColors;

  const _UsnSeismographStrip({
    required this.samples,
    required this.timescale,
    required this.showDepth,
    this.useSourceColors = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _UsnTheme.paperAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _UsnTheme.divider),
      ),
      clipBehavior: Clip.antiAlias,
      child: CustomPaint(
        painter: _UsnSeismographPainter(
          samples: samples,
          timescale: timescale,
          showDepth: showDepth,
          useSourceColors: useSourceColors,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _UsnSeismographPainter extends CustomPainter {
  final List<_UsnRec> samples;
  final double timescale;
  final bool showDepth;
  final bool useSourceColors;

  _UsnSeismographPainter({
    required this.samples,
    required this.timescale,
    required this.showDepth,
    required this.useSourceColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _paintBackground(canvas, size);
    _paintGrid(canvas, size);
    _paintAxes(canvas, size);
    _paintOffsetTrace(canvas, size);
    _paintDirectionBars(canvas, size);
    _paintNeedle(canvas, size);
    _paintLegend(canvas, size);
  }

  void _paintBackground(Canvas canvas, Size size) {
    final paint = Paint()..color = _UsnTheme.paperAlt;
    canvas.drawRect(Offset.zero & size, paint);
    // subtle paper speckle (deterministic, not random per paint)
    final speckle = Paint()
      ..color = _UsnTheme.paperDeep.withValues(alpha: 0.25);
    const step = 14.0;
    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        final odd = (((x ~/ step) + (y ~/ step)) % 2) == 0;
        if (odd) {
          canvas.drawCircle(Offset(x, y), 0.6, speckle);
        }
      }
    }
  }

  void _paintGrid(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = _UsnTheme.divider.withValues(alpha: 0.55)
      ..strokeWidth = 0.6;
    const cellW = 24.0;
    for (double x = 0; x <= size.width; x += cellW) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    const cellH = 16.0;
    for (double y = 0; y <= size.height; y += cellH) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  void _paintAxes(Canvas canvas, Size size) {
    final axis = Paint()
      ..color = _UsnTheme.teal
      ..strokeWidth = 1.2;
    // Baseline axis
    final baseY = size.height - 18;
    canvas.drawLine(Offset(0, baseY), Offset(size.width, baseY), axis);
    // Top axis
    canvas.drawLine(
      const Offset(0, 16),
      Offset(size.width, 16),
      Paint()
        ..color = _UsnTheme.teal.withValues(alpha: 0.4)
        ..strokeWidth = 0.8,
    );
  }

  void _paintOffsetTrace(Canvas canvas, Size size) {
    if (samples.isEmpty) {
      _paintEmptyHint(canvas, size);
      return;
    }
    final baseY = size.height - 18;
    final topY = 20.0;
    final totalSamples = samples.length;
    final visible = math.max(24, (60 * timescale).round());
    final start = math.max(0, totalSamples - visible);
    final slice = samples.sublist(start);
    if (slice.isEmpty) return;

    final path = Path();
    for (var i = 0; i < slice.length; i++) {
      final s = slice[i];
      final x = (i / (visible - 1)) * size.width;
      final y = baseY - (baseY - topY) * s.normalizedOffset;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final ink = Paint()
      ..color = _UsnTheme.ink
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, ink);

    // Sample dots, colored by direction
    for (var i = 0; i < slice.length; i++) {
      final s = slice[i];
      final x = (i / (visible - 1)) * size.width;
      final y = baseY - (baseY - topY) * s.normalizedOffset;
      canvas.drawCircle(
        Offset(x, y),
        2.4,
        Paint()..color = _colorFor(s),
      );
    }
  }

  Color _colorFor(_UsnRec s) {
    if (useSourceColors) {
      switch (s.source) {
        case 'feed-a':
          return _UsnTheme.teal;
        case 'feed-b':
          return _UsnTheme.amber;
        case 'feed-c':
          return _UsnTheme.needle;
        default:
          return _UsnTheme.ink;
      }
    }
    switch (s.direction) {
      case ScrollDirection.idle:
        return _UsnTheme.mute;
      case ScrollDirection.forward:
        return _UsnTheme.teal;
      case ScrollDirection.reverse:
        return _UsnTheme.needle;
    }
  }

  void _paintDirectionBars(Canvas canvas, Size size) {
    if (samples.isEmpty) return;
    final baseY = size.height - 18;
    final visible = math.max(24, (60 * timescale).round());
    final totalSamples = samples.length;
    final start = math.max(0, totalSamples - visible);
    final slice = samples.sublist(start);

    for (var i = 0; i < slice.length; i++) {
      final s = slice[i];
      final x = (i / (visible - 1)) * size.width;
      final barHeight = switch (s.direction) {
        ScrollDirection.idle => 4.0,
        ScrollDirection.forward => 10.0,
        ScrollDirection.reverse => 10.0,
      };
      final color = _colorFor(s);
      final rect = Rect.fromLTWH(
        x - 1.2,
        baseY + 2,
        2.4,
        barHeight,
      );
      canvas.drawRect(rect, Paint()..color = color.withValues(alpha: 0.8));

      if (showDepth && s.depth > 0) {
        final depthPaint = Paint()
          ..color = _UsnTheme.needle.withValues(alpha: 0.5)
          ..strokeWidth = 1.0;
        canvas.drawLine(
          Offset(x, baseY - 2),
          Offset(x, baseY - 8 - (s.depth * 2)),
          depthPaint,
        );
      }
    }
  }

  void _paintNeedle(Canvas canvas, Size size) {
    if (samples.isEmpty) return;
    final last = samples.last;
    final x = size.width - 6;
    final paint = Paint()
      ..color = _UsnTheme.needleHot
      ..strokeWidth = 1.6;
    canvas.drawLine(Offset(x, 4), Offset(x, size.height - 4), paint);

    // small triangular marker at top
    final marker = Path()
      ..moveTo(x - 6, 0)
      ..lineTo(x + 6, 0)
      ..lineTo(x, 10)
      ..close();
    canvas.drawPath(marker, Paint()..color = _UsnTheme.needleHot);

    // legend: current direction as text-like mark
    final dirPaint = Paint()
      ..color = switch (last.direction) {
        ScrollDirection.idle => _UsnTheme.mute,
        ScrollDirection.forward => _UsnTheme.teal,
        ScrollDirection.reverse => _UsnTheme.needle,
      };
    canvas.drawCircle(Offset(x - 12, 14), 4, dirPaint);
  }

  void _paintEmptyHint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: const TextSpan(
        text: 'No samples yet — scroll a feed to draw the trace.',
        style: TextStyle(
          color: _UsnTheme.mute,
          fontSize: 12,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 24);
    tp.paint(canvas, Offset(12, size.height / 2 - tp.height / 2));
  }

  void _paintLegend(Canvas canvas, Size size) {
    final legendItems = <MapEntry<String, Color>>[
      const MapEntry('idle', _UsnTheme.mute),
      const MapEntry('forward', _UsnTheme.teal),
      const MapEntry('reverse', _UsnTheme.needle),
    ];
    double cursor = 12;
    for (final item in legendItems) {
      final chip = Paint()..color = item.value;
      canvas.drawRect(
        Rect.fromLTWH(cursor, 4, 10, 4),
        chip,
      );
      final tp = TextPainter(
        text: TextSpan(
          text: item.key,
          style: TextStyle(
            color: _UsnTheme.inkSoft,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(cursor + 14, 0));
      cursor += 14 + tp.width + 10;
    }
  }

  @override
  bool shouldRepaint(covariant _UsnSeismographPainter old) {
    return old.samples != samples ||
        old.timescale != timescale ||
        old.showDepth != showDepth ||
        old.useSourceColors != useSourceColors;
  }
}
