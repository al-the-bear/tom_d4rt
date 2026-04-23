import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// ScrollMetricsNotification — extent changes without a scroll
// -----------------------------------------------------------------------------
// This demo is a "Metrics Change Detector". It is built specifically to
// highlight the behaviour of ScrollMetricsNotification, the Notification
// subclass (NOT a ScrollNotification) that Flutter dispatches when a
// Scrollable's metrics change for reasons OTHER than the user scrolling.
//
// Typical triggers:
//   - adding / removing items from a ListView (maxScrollExtent grows/shrinks)
//   - window resize or a SizedBox around the Scrollable changing size
//     (viewportDimension changes)
//   - orientation change
//   - expanded / collapsed SliverAppBar or variable-sized headers
//
// Fields on ScrollMetricsNotification:
//   - metrics (ScrollMetrics): the *new* metrics snapshot
//   - context (BuildContext?): the Scrollable's build context
//
// Hard constraints in effect:
//   - d4rt AST harness style: a top-level `dynamic build(BuildContext context)`
//     function returning a MaterialApp. No `main()` / `runApp()`.
//   - Only `package:flutter/material.dart` imported.
//   - Uses `debugPrint` instead of `print`.
//   - Colors use `withValues(alpha: ...)` instead of `withOpacity`.
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Palette
// -----------------------------------------------------------------------------
const Color kBurgundy = Color(0xFF6A040F);
const Color kCream = Color(0xFFFFF3E4);
const Color kInk = Color(0xFF2B2B2B);
const Color kLeaf = Color(0xFF3E7C17);
const Color kRed = Color(0xFFD62828);
const Color kMidBurgundy = Color(0xFF9D0208);
const Color kPale = Color(0xFFFFE1C4);
const Color kSlate = Color(0xFF6C6C6C);
const Color kSoft = Color(0xFFF7E6CE);
const Color kGridLine = Color(0xFFE6CFAE);

// -----------------------------------------------------------------------------
// Data records — plain maps instead of custom classes so the d4rt AST harness
// has no trouble decoding the literal tree.
// -----------------------------------------------------------------------------
const List<Map<String, Object>> kInitialTiles = <Map<String, Object>>[
  <String, Object>{'label': 'Tile  1', 'color': 0xFF6A040F},
  <String, Object>{'label': 'Tile  2', 'color': 0xFF9D0208},
  <String, Object>{'label': 'Tile  3', 'color': 0xFFD00000},
  <String, Object>{'label': 'Tile  4', 'color': 0xFFDC2F02},
  <String, Object>{'label': 'Tile  5', 'color': 0xFFE85D04},
  <String, Object>{'label': 'Tile  6', 'color': 0xFFF48C06},
  <String, Object>{'label': 'Tile  7', 'color': 0xFFFAA307},
  <String, Object>{'label': 'Tile  8', 'color': 0xFFFFBA08},
  <String, Object>{'label': 'Tile  9', 'color': 0xFF3E7C17},
  <String, Object>{'label': 'Tile 10', 'color': 0xFF2D6A4F},
  <String, Object>{'label': 'Tile 11', 'color': 0xFF1B4332},
  <String, Object>{'label': 'Tile 12', 'color': 0xFF081C15},
];

const List<Map<String, String>> kMetricsFields = <Map<String, String>>[
  <String, String>{
    'name': 'pixels',
    'desc': 'Current scroll offset. Typically unchanged by a pure metrics event.',
  },
  <String, String>{
    'name': 'minScrollExtent',
    'desc': 'Lower boundary of the scrollable region.',
  },
  <String, String>{
    'name': 'maxScrollExtent',
    'desc': 'Upper boundary; grows/shrinks when items are added or removed.',
  },
  <String, String>{
    'name': 'viewportDimension',
    'desc': 'Visible size of the viewport along the main axis.',
  },
  <String, String>{
    'name': 'axisDirection',
    'desc': 'Direction of positive scroll offset (e.g. AxisDirection.down).',
  },
  <String, String>{
    'name': 'axis',
    'desc': 'Derived axis (horizontal or vertical) from axisDirection.',
  },
  <String, String>{
    'name': 'extentBefore',
    'desc': 'How many pixels are scrolled off the leading edge.',
  },
  <String, String>{
    'name': 'extentInside',
    'desc': 'Visible portion of the content inside the viewport.',
  },
  <String, String>{
    'name': 'extentAfter',
    'desc': 'How many pixels are still off the trailing edge.',
  },
  <String, String>{
    'name': 'outOfRange',
    'desc': 'True when pixels is outside [minScrollExtent, maxScrollExtent].',
  },
  <String, String>{
    'name': 'atEdge',
    'desc': 'True when the current pixels lie exactly at a boundary.',
  },
  <String, String>{
    'name': 'hasContentDimensions',
    'desc': 'Whether min/max extents are known yet.',
  },
];

const List<Map<String, String>> kCompareRows = <Map<String, String>>[
  <String, String>{
    'aspect': 'dispatched during',
    'metrics': 'layout — when extents change without user scroll',
    'scroll': 'an active scroll gesture / animation',
  },
  <String, String>{
    'aspect': 'dispatches to',
    'metrics': 'NotificationListener<ScrollMetricsNotification>',
    'scroll': 'NotificationListener<ScrollNotification> and subclasses',
  },
  <String, String>{
    'aspect': 'when',
    'metrics': 'item add/remove, viewport resize, header expand',
    'scroll': 'start / update / end / user overscroll',
  },
];

const List<Map<String, String>> kUseCases = <Map<String, String>>[
  <String, String>{
    'icon': 'hide',
    'title': 'Auto-hide FAB',
    'body':
        'Remove a "scroll to top" FAB the moment maxScrollExtent drops to 0 — the list now fits the viewport and the button would be meaningless.',
  },
  <String, String>{
    'icon': 'bar',
    'title': 'Scrollbar visibility',
    'body':
        'Only reveal the scrollbar thumb when maxScrollExtent > 0. React to metrics events instead of scroll events; otherwise the bar appears only AFTER the first swipe.',
  },
  <String, String>{
    'icon': 'resize',
    'title': 'Layout refetch',
    'body':
        'When the viewport size changes, recompute how many pixels equal one screen so Page Up / Page Down shortcuts stay correct.',
  },
  <String, String>{
    'icon': 'anchor',
    'title': 'Keep bottom anchored',
    'body':
        'In a chat log, when a new message appended makes maxScrollExtent grow, jump the controller to the new maximum so the latest message stays visible.',
  },
];

const List<Map<String, String>> kTeachingTiles = <Map<String, String>>[
  <String, String>{
    'headline': 'Fires during layout',
    'body':
        'ScrollMetricsNotification is dispatched inside the Scrollable when its position learns about new content/viewport dimensions — not during a scroll frame.',
  },
  <String, String>{
    'headline': 'Avoid re-entrant layout',
    'body':
        'Do NOT call setState synchronously inside the listener if that setState would resize the scrollable itself. Schedule a post-frame callback instead, or you will spiral.',
  },
  <String, String>{
    'headline': 'Prefer ScrollController.addListener for pixels',
    'body':
        'Use a ScrollController listener for pixel-accurate reads every frame. Use ScrollMetricsNotification for structural changes to extents.',
  },
  <String, String>{
    'headline': 'Bubbles like any Notification',
    'body':
        'The event walks up the widget tree. Any ancestor NotificationListener can observe or stop it by returning true from its callback.',
  },
];

const String kCanonicalSnippet = '''NotificationListener<ScrollMetricsNotification>(
  onNotification: (ScrollMetricsNotification n) {
    final ScrollMetrics m = n.metrics;
    debugPrint(
      'metrics changed: max=\${m.maxScrollExtent.toStringAsFixed(1)} '
      'viewport=\${m.viewportDimension.toStringAsFixed(1)}',
    );
    // Return false so ancestors can also listen.
    return false;
  },
  child: ListView.builder(
    itemCount: items.length,
    itemBuilder: (ctx, i) => ListTile(title: Text(items[i])),
  ),
);''';

// -----------------------------------------------------------------------------
// Root widget
// -----------------------------------------------------------------------------
class MetricsChangeDetector extends StatefulWidget {
  const MetricsChangeDetector({super.key});

  @override
  State<MetricsChangeDetector> createState() => _MetricsChangeDetectorState();
}

class _MetricsChangeDetectorState extends State<MetricsChangeDetector>
    with TickerProviderStateMixin {
  // --------- mutable list state ---------
  late List<Map<String, Object>> _tiles;
  int _nextId = 13;

  // --------- viewport toggle ---------
  static const double _viewportSmall = 300;
  static const double _viewportLarge = 500;
  double _viewportHeight = _viewportLarge;

  // --------- captured events ---------
  final List<_MetricsEvent> _events = <_MetricsEvent>[];
  _MetricsSample? _lastSample;
  final List<double> _maxExtentHistory = <double>[];

  // --------- ruler animation for hero ---------
  late final AnimationController _rulerCtrl;
  late final Animation<double> _rulerAnim;

  @override
  void initState() {
    super.initState();
    _tiles = List<Map<String, Object>>.from(kInitialTiles);
    _rulerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _rulerAnim = CurvedAnimation(parent: _rulerCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _rulerCtrl.dispose();
    super.dispose();
  }

  // --------- list mutation actions ---------
  void _addFive() {
    setState(() {
      for (int i = 0; i < 5; i++) {
        _tiles.add(<String, Object>{
          'label': 'Tile ${_nextId.toString().padLeft(2, ' ')}',
          'color': _rotatingColor(_nextId),
        });
        _nextId++;
      }
    });
  }

  void _removeFive() {
    setState(() {
      for (int i = 0; i < 5 && _tiles.isNotEmpty; i++) {
        _tiles.removeLast();
      }
    });
  }

  void _toggleViewport() {
    setState(() {
      _viewportHeight = _viewportHeight == _viewportLarge
          ? _viewportSmall
          : _viewportLarge;
    });
  }

  void _clearLog() {
    setState(() {
      _events.clear();
      _lastSample = null;
      _maxExtentHistory.clear();
    });
  }

  int _rotatingColor(int id) {
    const List<int> palette = <int>[
      0xFF6A040F,
      0xFF9D0208,
      0xFFD00000,
      0xFFDC2F02,
      0xFFE85D04,
      0xFFF48C06,
      0xFFFAA307,
      0xFFFFBA08,
      0xFF3E7C17,
      0xFF2D6A4F,
    ];
    return palette[id % palette.length];
  }

  // --------- notification ingestion ---------
  bool _onMetrics(ScrollMetricsNotification n) {
    final ScrollMetrics m = n.metrics;
    final _MetricsSample current = _MetricsSample(
      pixels: m.pixels,
      minScrollExtent: m.minScrollExtent,
      maxScrollExtent: m.maxScrollExtent,
      viewportDimension: m.viewportDimension,
      axis: m.axisDirection.toString(),
    );
    final _MetricsSample? previous = _lastSample;
    final _MetricsEvent event = _MetricsEvent(
      index: _events.length + 1,
      before: previous,
      after: current,
      itemCount: _tiles.length,
      viewportHeight: _viewportHeight,
    );
    // debugPrint keeps this demo out of the `avoid_print` lint.
    debugPrint(
      'metrics#${event.index} '
      'max=${current.maxScrollExtent.toStringAsFixed(1)} '
      'viewport=${current.viewportDimension.toStringAsFixed(1)}',
    );
    setState(() {
      _events.insert(0, event);
      if (_events.length > 40) {
        _events.removeLast();
      }
      _lastSample = current;
      _maxExtentHistory.add(current.maxScrollExtent);
      if (_maxExtentHistory.length > 60) {
        _maxExtentHistory.removeAt(0);
      }
    });
    return false;
  }

  // ---------------------------------------------------------------------------
  // build()
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      appBar: AppBar(
        backgroundColor: kBurgundy,
        foregroundColor: kCream,
        elevation: 0,
        title: const Text('ScrollMetricsNotification'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 36),
        children: <Widget>[
          _HeroHeader(anim: _rulerAnim),
          const SizedBox(height: 22),
          _SectionTitle(
            number: '1',
            title: 'Live list laboratory',
            subtitle:
                'Mutate the list or resize the viewport and watch the metrics events land.',
          ),
          const SizedBox(height: 12),
          _LaboratoryPanel(
            tiles: _tiles,
            viewportHeight: _viewportHeight,
            events: _events,
            onMetrics: _onMetrics,
            onAdd: _addFive,
            onRemove: _removeFive,
            onResize: _toggleViewport,
            onClear: _clearLog,
          ),
          const SizedBox(height: 28),
          _SectionTitle(
            number: '2',
            title: 'Diff badges',
            subtitle:
                'For each event we subtract the previous metrics snapshot from the new one.',
          ),
          const SizedBox(height: 12),
          _DiffBadgesPanel(events: _events),
          const SizedBox(height: 28),
          _SectionTitle(
            number: '3',
            title: 'Extent sparkline',
            subtitle:
                'maxScrollExtent sampled on every ScrollMetricsNotification (last 60).',
          ),
          const SizedBox(height: 12),
          _SparklineCard(history: _maxExtentHistory),
          const SizedBox(height: 28),
          _SectionTitle(
            number: '4',
            title: 'Before / After viewport bars',
            subtitle:
                'Each row renders the viewport+content extents before and after an event.',
          ),
          const SizedBox(height: 12),
          _BeforeAfterPanel(events: _events),
          const SizedBox(height: 28),
          _SectionTitle(
            number: '5',
            title: 'ScrollMetrics fields',
            subtitle:
                'Getters on ScrollMetrics that this notification carries via n.metrics.',
          ),
          const SizedBox(height: 12),
          const _MetricsFieldGrid(),
          const SizedBox(height: 28),
          _SectionTitle(
            number: '6',
            title: 'ScrollMetricsNotification vs ScrollNotification',
            subtitle:
                'Two distinct event families — pick the listener that matches your intent.',
          ),
          const SizedBox(height: 12),
          const _CompareCard(),
          const SizedBox(height: 28),
          _SectionTitle(
            number: '7',
            title: 'Use cases',
            subtitle: 'Four real product patterns that depend on this notification.',
          ),
          const SizedBox(height: 12),
          const _UseCaseStrip(),
          const SizedBox(height: 28),
          _SectionTitle(
            number: '8',
            title: 'Canonical snippet',
            subtitle: 'The shortest real listener you would write in production.',
          ),
          const SizedBox(height: 12),
          const _CodeSnippetCard(),
          const SizedBox(height: 28),
          _SectionTitle(
            number: '9',
            title: 'Teaching notes',
            subtitle: 'Four rules of thumb worth internalising.',
          ),
          const SizedBox(height: 12),
          const _TeachingPanel(),
          const SizedBox(height: 28),
          const _FooterSummary(),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. Hero header
// -----------------------------------------------------------------------------
class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.anim});

  final Animation<double> anim;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            kBurgundy,
            kBurgundy.withValues(alpha: 0.82),
            kMidBurgundy,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kBurgundy.withValues(alpha: 0.28),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kCream.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: kCream.withValues(alpha: 0.4),
                  ),
                ),
                child: const Text(
                  'Notification subclass',
                  style: TextStyle(
                    color: kCream,
                    fontSize: 11,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kCream.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: kCream.withValues(alpha: 0.22),
                  ),
                ),
                child: const Text(
                  'not a ScrollNotification',
                  style: TextStyle(
                    color: kCream,
                    fontSize: 11,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'ScrollMetricsNotification',
            style: TextStyle(
              color: kCream,
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'extent changes without a scroll',
            style: TextStyle(
              color: kPale,
              fontSize: 15,
              fontStyle: FontStyle.italic,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 22),
          _RulerWidget(anim: anim),
          const SizedBox(height: 14),
          const Text(
            'Fires when a Scrollable discovers its metrics have changed for reasons '
            'other than a user scroll: list item additions, viewport resizes, '
            'orientation flips, expandable headers, reflow.',
            style: TextStyle(
              color: kCream,
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _RulerWidget extends StatelessWidget {
  const _RulerWidget({required this.anim});

  final Animation<double> anim;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: anim,
      builder: (BuildContext ctx, Widget? child) {
        final double t = anim.value;
        final double growingEnd = 120 + t * 180;
        return SizedBox(
          height: 56,
          child: Row(
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 120,
                height: 34,
                decoration: BoxDecoration(
                  color: kCream.withValues(alpha: 0.85),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'viewport',
                  style: TextStyle(
                    color: kBurgundy,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                width: growingEnd,
                height: 34,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      kCream.withValues(alpha: 0.55),
                      kCream.withValues(alpha: 0.15),
                    ],
                  ),
                  border: Border(
                    top: BorderSide(
                      color: kCream.withValues(alpha: 0.35),
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: kCream.withValues(alpha: 0.35),
                      width: 1,
                    ),
                  ),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'maxScrollExtent → ${growingEnd.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: kCream,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: 6,
                height: 34,
                decoration: const BoxDecoration(
                  color: kCream,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(3),
                    bottomRight: Radius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
// Section title helper
// -----------------------------------------------------------------------------
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: kBurgundy,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kBurgundy.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: kCream,
              fontSize: 18,
              fontWeight: FontWeight.w800,
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
                  color: kInk,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: kSlate,
                  fontSize: 12.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 2. Laboratory panel — the actual live NotificationListener
// -----------------------------------------------------------------------------
class _LaboratoryPanel extends StatelessWidget {
  const _LaboratoryPanel({
    required this.tiles,
    required this.viewportHeight,
    required this.events,
    required this.onMetrics,
    required this.onAdd,
    required this.onRemove,
    required this.onResize,
    required this.onClear,
  });

  final List<Map<String, Object>> tiles;
  final double viewportHeight;
  final List<_MetricsEvent> events;
  final bool Function(ScrollMetricsNotification) onMetrics;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onResize;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kGridLine),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kBurgundy.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _LabChip(
                label: 'items: ${tiles.length}',
                color: kBurgundy,
              ),
              const SizedBox(width: 8),
              _LabChip(
                label: 'viewport: ${viewportHeight.toStringAsFixed(0)} px',
                color: kLeaf,
              ),
              const SizedBox(width: 8),
              _LabChip(
                label: 'events: ${events.length}',
                color: kInk,
              ),
              const Spacer(),
              TextButton(
                onPressed: onClear,
                style: TextButton.styleFrom(foregroundColor: kBurgundy),
                child: const Text('clear log'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _LabButton(
                label: 'Add 5 items',
                icon: Icons.add,
                color: kLeaf,
                onPressed: onAdd,
              ),
              _LabButton(
                label: 'Remove 5 items',
                icon: Icons.remove,
                color: kRed,
                onPressed: onRemove,
              ),
              _LabButton(
                label: viewportHeight == 500
                    ? 'Resize viewport → 300'
                    : 'Resize viewport → 500',
                icon: Icons.height,
                color: kBurgundy,
                onPressed: onResize,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const _PanelSubheader(
                      label: 'Scrollable under observation',
                    ),
                    const SizedBox(height: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 320),
                      curve: Curves.easeInOut,
                      height: viewportHeight,
                      decoration: BoxDecoration(
                        color: kSoft,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kGridLine),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: NotificationListener<ScrollMetricsNotification>(
                          onNotification: onMetrics,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: tiles.length,
                            itemBuilder: (BuildContext ctx, int i) {
                              final Map<String, Object> t = tiles[i];
                              final int c = t['color']! as int;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(c).withValues(alpha: 0.92),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Color(c).withValues(alpha: 0.28),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.drag_indicator,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        t['label']! as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '#${i + 1}',
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const _PanelSubheader(label: 'Event log'),
                    const SizedBox(height: 8),
                    Container(
                      height: viewportHeight,
                      decoration: BoxDecoration(
                        color: kInk,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      child: events.isEmpty
                          ? const Center(
                              child: Text(
                                'Tap a lab button to generate\n'
                                'a ScrollMetricsNotification.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: kSoft,
                                  fontSize: 12.5,
                                  height: 1.4,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: events.length,
                              itemBuilder: (BuildContext ctx, int i) {
                                final _MetricsEvent e = events[i];
                                return _EventRow(event: e);
                              },
                            ),
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

class _PanelSubheader extends StatelessWidget {
  const _PanelSubheader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: kBurgundy,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: kInk,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

class _LabChip extends StatelessWidget {
  const _LabChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _LabButton extends StatelessWidget {
  const _LabButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _EventRow extends StatelessWidget {
  const _EventRow({required this.event});
  final _MetricsEvent event;

  @override
  Widget build(BuildContext context) {
    final _MetricsSample a = event.after;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kSlate.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: kBurgundy,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '#${event.index}',
                  style: const TextStyle(
                    color: kCream,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'items ${event.itemCount}  ·  vp ${event.viewportHeight.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: kSoft,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'max=${a.maxScrollExtent.toStringAsFixed(1)}  '
            'viewport=${a.viewportDimension.toStringAsFixed(1)}',
            style: const TextStyle(
              color: kCream,
              fontSize: 11.5,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            'pixels=${a.pixels.toStringAsFixed(1)}  '
            'min=${a.minScrollExtent.toStringAsFixed(1)}',
            style: TextStyle(
              color: kCream.withValues(alpha: 0.7),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. Diff badges panel
// -----------------------------------------------------------------------------
class _DiffBadgesPanel extends StatelessWidget {
  const _DiffBadgesPanel({required this.events});
  final List<_MetricsEvent> events;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return _EmptyPanel(message: 'No metrics events captured yet.');
    }
    final List<_MetricsEvent> sliced =
        events.take(6).toList(growable: false);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kGridLine),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        children: sliced
            .map((_MetricsEvent e) => _DiffRow(event: e))
            .toList(growable: false),
      ),
    );
  }
}

class _DiffRow extends StatelessWidget {
  const _DiffRow({required this.event});
  final _MetricsEvent event;

  @override
  Widget build(BuildContext context) {
    final _MetricsSample? before = event.before;
    final _MetricsSample after = event.after;
    final double dMax = before == null
        ? after.maxScrollExtent
        : after.maxScrollExtent - before.maxScrollExtent;
    final double dViewport = before == null
        ? after.viewportDimension
        : after.viewportDimension - before.viewportDimension;
    final double dPixels = before == null
        ? after.pixels
        : after.pixels - before.pixels;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kBurgundy.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '#${event.index}',
              style: const TextStyle(
                color: kBurgundy,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _DeltaBadge(label: 'Δ maxScrollExtent', value: dMax),
                _DeltaBadge(label: 'Δ viewportDimension', value: dViewport),
                _DeltaBadge(label: 'Δ pixels', value: dPixels),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeltaBadge extends StatelessWidget {
  const _DeltaBadge({required this.label, required this.value});
  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final bool zero = value.abs() < 0.01;
    final bool positive = value > 0;
    final Color tint = zero ? kSlate : (positive ? kLeaf : kRed);
    final String arrow = zero ? '•' : (positive ? '↑' : '↓');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: zero ? 0.06 : 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: tint.withValues(alpha: zero ? 0.15 : 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            arrow,
            style: TextStyle(
              color: tint,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: kInk,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            value.toStringAsFixed(1),
            style: TextStyle(
              color: tint,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4. Sparkline
// -----------------------------------------------------------------------------
class _SparklineCard extends StatelessWidget {
  const _SparklineCard({required this.history});
  final List<double> history;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kGridLine),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.stacked_line_chart,
                color: kBurgundy,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'maxScrollExtent sparkline',
                style: TextStyle(
                  color: kInk,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                'samples: ${history.length}/60',
                style: const TextStyle(
                  color: kSlate,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: CustomPaint(
              painter: _SparklinePainter(points: history),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'The line walks right as new notifications arrive; height is scaled '
            'to the current min/max of the window.',
            style: TextStyle(
              color: kSlate,
              fontSize: 11.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.points});
  final List<double> points;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = kSoft.withValues(alpha: 0.5);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(10),
      ),
      bg,
    );

    final Paint grid = Paint()
      ..color = kGridLine
      ..strokeWidth = 1;
    for (int i = 1; i < 4; i++) {
      final double y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    if (points.length < 2) {
      final TextPainter tp = TextPainter(
        text: const TextSpan(
          text: 'awaiting samples…',
          style: TextStyle(color: kSlate, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(
          (size.width - tp.width) / 2,
          (size.height - tp.height) / 2,
        ),
      );
      return;
    }

    double minV = points.first;
    double maxV = points.first;
    for (final double v in points) {
      if (v < minV) minV = v;
      if (v > maxV) maxV = v;
    }
    if (maxV - minV < 1) {
      maxV = minV + 1;
    }

    final Path linePath = Path();
    final Path fillPath = Path();
    for (int i = 0; i < points.length; i++) {
      final double x =
          points.length == 1 ? 0 : size.width * i / (points.length - 1);
      final double normalised = (points[i] - minV) / (maxV - minV);
      final double y = size.height - normalised * (size.height - 8) - 4;
      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          kBurgundy.withValues(alpha: 0.35),
          kBurgundy.withValues(alpha: 0.02),
        ],
      ).createShader(Offset.zero & size);
    canvas.drawPath(fillPath, fillPaint);

    final Paint linePaint = Paint()
      ..color = kBurgundy
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(linePath, linePaint);

    // last-point dot
    final double lastX = size.width;
    final double lastNorm = (points.last - minV) / (maxV - minV);
    final double lastY = size.height - lastNorm * (size.height - 8) - 4;
    canvas.drawCircle(
      Offset(lastX, lastY),
      4,
      Paint()..color = kBurgundy,
    );
    canvas.drawCircle(
      Offset(lastX, lastY),
      2,
      Paint()..color = kCream,
    );

    // axis labels
    final TextPainter maxLbl = TextPainter(
      text: TextSpan(
        text: maxV.toStringAsFixed(0),
        style: const TextStyle(color: kInk, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    maxLbl.paint(canvas, const Offset(6, 4));

    final TextPainter minLbl = TextPainter(
      text: TextSpan(
        text: minV.toStringAsFixed(0),
        style: const TextStyle(color: kInk, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    minLbl.paint(canvas, Offset(6, size.height - minLbl.height - 4));
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.points.length != points.length;
  }
}

// -----------------------------------------------------------------------------
// 5. Before/After visualisation
// -----------------------------------------------------------------------------
class _BeforeAfterPanel extends StatelessWidget {
  const _BeforeAfterPanel({required this.events});
  final List<_MetricsEvent> events;

  @override
  Widget build(BuildContext context) {
    final List<_MetricsEvent> sliced =
        events.take(3).toList(growable: false);
    if (sliced.isEmpty) {
      return _EmptyPanel(
        message: 'No notifications yet — nothing to compare.',
      );
    }
    return Column(
      children: sliced.map((_MetricsEvent e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _BeforeAfterRow(event: e),
        );
      }).toList(growable: false),
    );
  }
}

class _BeforeAfterRow extends StatelessWidget {
  const _BeforeAfterRow({required this.event});
  final _MetricsEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kGridLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: kBurgundy,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'event #${event.index}',
                  style: const TextStyle(
                    color: kCream,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'items ${event.itemCount}  ·  vp ${event.viewportHeight.toStringAsFixed(0)}px',
                style: const TextStyle(
                  color: kInk,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: _ViewportBar(
                  title: 'BEFORE',
                  sample: event.before,
                  accent: kSlate,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ViewportBar(
                  title: 'AFTER',
                  sample: event.after,
                  accent: kBurgundy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ViewportBar extends StatelessWidget {
  const _ViewportBar({
    required this.title,
    required this.sample,
    required this.accent,
  });

  final String title;
  final _MetricsSample? sample;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    if (sample == null) {
      return Container(
        height: 72,
        decoration: BoxDecoration(
          color: kSoft.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kGridLine),
        ),
        alignment: Alignment.center,
        child: const Text(
          'no prior metrics',
          style: TextStyle(color: kSlate, fontSize: 12),
        ),
      );
    }
    final double total =
        (sample!.maxScrollExtent + sample!.viewportDimension)
            .clamp(1.0, 100000.0);
    final double viewRatio = sample!.viewportDimension / total;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints c) {
              final double viewPx = (c.maxWidth * viewRatio).clamp(12.0, c.maxWidth);
              final double extPx = c.maxWidth - viewPx;
              return SizedBox(
                height: 22,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: viewPx,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.85),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                    ),
                    Container(
                      width: extPx,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.25),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 6),
          Text(
            'max=${sample!.maxScrollExtent.toStringAsFixed(1)}  '
            'vp=${sample!.viewportDimension.toStringAsFixed(1)}',
            style: const TextStyle(
              color: kInk,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 6. ScrollMetrics field grid
// -----------------------------------------------------------------------------
class _MetricsFieldGrid extends StatelessWidget {
  const _MetricsFieldGrid();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kGridLine),
      ),
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints c) {
          final int columns = c.maxWidth > 720 ? 2 : 1;
          final List<Widget> children = <Widget>[];
          for (final Map<String, String> row in kMetricsFields) {
            children.add(_MetricsFieldTile(row: row));
          }
          return GridView.count(
            crossAxisCount: columns,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: columns == 2 ? 4.5 : 5.5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: children,
          );
        },
      ),
    );
  }
}

class _MetricsFieldTile extends StatelessWidget {
  const _MetricsFieldTile({required this.row});
  final Map<String, String> row;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kGridLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: kBurgundy,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  row['name']!,
                  style: const TextStyle(
                    color: kBurgundy,
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            row['desc']!,
            style: const TextStyle(
              color: kInk,
              fontSize: 11.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 7. Compare card
// -----------------------------------------------------------------------------
class _CompareCard extends StatelessWidget {
  const _CompareCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kGridLine),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Expanded(
                child: _CompareHeader(
                  label: 'aspect',
                  color: kInk,
                ),
              ),
              Expanded(
                child: _CompareHeader(
                  label: 'ScrollMetricsNotification',
                  color: kBurgundy,
                ),
              ),
              Expanded(
                child: _CompareHeader(
                  label: 'ScrollNotification',
                  color: kLeaf,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...kCompareRows.map((Map<String, String> row) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      row['aspect']!,
                      style: const TextStyle(
                        color: kInk,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _CompareCell(
                      text: row['metrics']!,
                      accent: kBurgundy,
                    ),
                  ),
                  Expanded(
                    child: _CompareCell(
                      text: row['scroll']!,
                      accent: kLeaf,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CompareHeader extends StatelessWidget {
  const _CompareHeader({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _CompareCell extends StatelessWidget {
  const _CompareCell({required this.text, required this.accent});
  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: kInk,
          fontSize: 11.5,
          height: 1.35,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 8. Use case strip
// -----------------------------------------------------------------------------
class _UseCaseStrip extends StatelessWidget {
  const _UseCaseStrip();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints c) {
        final int columns = c.maxWidth > 820
            ? 4
            : c.maxWidth > 560
                ? 2
                : 1;
        return GridView.count(
          crossAxisCount: columns,
          childAspectRatio: 1.55,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: kUseCases
              .map((Map<String, String> row) => _UseCaseTile(row: row))
              .toList(growable: false),
        );
      },
    );
  }
}

class _UseCaseTile extends StatelessWidget {
  const _UseCaseTile({required this.row});
  final Map<String, String> row;

  IconData _icon() {
    switch (row['icon']) {
      case 'hide':
        return Icons.visibility_off;
      case 'bar':
        return Icons.unfold_less;
      case 'resize':
        return Icons.aspect_ratio;
      case 'anchor':
      default:
        return Icons.anchor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kGridLine),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kBurgundy.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: kBurgundy.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(_icon(), color: kBurgundy, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            row['title']!,
            style: const TextStyle(
              color: kInk,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              row['body']!,
              style: const TextStyle(
                color: kSlate,
                fontSize: 11.8,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 9. Code snippet card
// -----------------------------------------------------------------------------
class _CodeSnippetCard extends StatelessWidget {
  const _CodeSnippetCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: kRed,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: kLeaf,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'listener.dart',
                style: TextStyle(
                  color: kSoft,
                  fontSize: 11,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SelectableText(
            kCanonicalSnippet,
            style: const TextStyle(
              color: kCream,
              fontSize: 12,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 10. Teaching panel
// -----------------------------------------------------------------------------
class _TeachingPanel extends StatelessWidget {
  const _TeachingPanel();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints c) {
        final int columns = c.maxWidth > 720 ? 2 : 1;
        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: columns == 2 ? 2.3 : 3.2,
          children: kTeachingTiles
              .map((Map<String, String> row) => _TeachingTile(row: row))
              .toList(growable: false),
        );
      },
    );
  }
}

class _TeachingTile extends StatelessWidget {
  const _TeachingTile({required this.row});
  final Map<String, String> row;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: kBurgundy, width: 4),
          top: BorderSide(color: kGridLine),
          right: BorderSide(color: kGridLine),
          bottom: BorderSide(color: kGridLine),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            row['headline']!,
            style: const TextStyle(
              color: kBurgundy,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              row['body']!,
              style: const TextStyle(
                color: kInk,
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

// -----------------------------------------------------------------------------
// 11. Footer
// -----------------------------------------------------------------------------
class _FooterSummary extends StatelessWidget {
  const _FooterSummary();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            kInk,
            kInk.withValues(alpha: 0.92),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.flag, color: kCream, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Take-aways',
                style: TextStyle(
                  color: kCream,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: kCream.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: kCream.withValues(alpha: 0.22),
                  ),
                ),
                child: const Text(
                  'ScrollMetricsNotification',
                  style: TextStyle(
                    color: kCream,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '• Subclass of Notification, NOT of ScrollNotification.\n'
            '• Fires when extents change independently of user scroll.\n'
            '• Use it to observe structural changes (item adds/removes, viewport resizes).\n'
            '• Use ScrollController.addListener when you need every-frame pixel reads.\n'
            '• Never trigger layout that re-enters the same Scrollable synchronously from the listener.',
            style: TextStyle(
              color: kCream,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Empty state helper
// -----------------------------------------------------------------------------
class _EmptyPanel extends StatelessWidget {
  const _EmptyPanel({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kGridLine),
      ),
      alignment: Alignment.center,
      child: Text(
        message,
        style: const TextStyle(
          color: kSlate,
          fontSize: 12.5,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Data types
// -----------------------------------------------------------------------------
class _MetricsSample {
  const _MetricsSample({
    required this.pixels,
    required this.minScrollExtent,
    required this.maxScrollExtent,
    required this.viewportDimension,
    required this.axis,
  });

  final double pixels;
  final double minScrollExtent;
  final double maxScrollExtent;
  final double viewportDimension;
  final String axis;
}

class _MetricsEvent {
  const _MetricsEvent({
    required this.index,
    required this.before,
    required this.after,
    required this.itemCount,
    required this.viewportHeight,
  });

  final int index;
  final _MetricsSample? before;
  final _MetricsSample after;
  final int itemCount;
  final double viewportHeight;
}

// -----------------------------------------------------------------------------
// d4rt AST harness entry point
// -----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MetricsChangeDetector(),
  );
}
