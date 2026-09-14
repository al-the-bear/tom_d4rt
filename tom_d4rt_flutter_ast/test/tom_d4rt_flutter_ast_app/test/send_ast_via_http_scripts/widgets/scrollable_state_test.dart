// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

/// Deep visual demo — ScrollableState
///
/// ScrollableState is the State object for the Scrollable widget. It manages
/// the ScrollPosition lifecycle, implements the ScrollContext interface,
/// and coordinates with ScrollController for programmatic scroll control.
/// Almost every scrollable surface in Flutter (ListView, GridView, CustomScrollView)
/// uses Scrollable internally, and ScrollableState is the engine behind scrolling.
///
/// Sections
/// ─────────
/// 1. What is ScrollableState?
/// 2. The ScrollContext interface
/// 3. ScrollPosition management
/// 4. Live: scroll monitoring via Scrollable.of()
/// 5. Live: programmatic scroll control
/// 6. Axis & ScrollPhysics configuration
/// 7. Drag & hold gesture coordination
/// 8. Key concepts and integration points

// ─── palette ───────────────────────────────────────────────
const _kPurple      = Color(0xFF673AB7);
const _kPurpleLight = Color(0xFFD1C4E9);
const _kPurpleDark  = Color(0xFF311B92);
const _kLime        = Color(0xFF8BC34A);
const _kLimeLight   = Color(0xFFF0F4C3);
const _kLimeDark    = Color(0xFF33691E);
const _kSurface     = Color(0xFFF5F5FA);
const _kDivider     = Color(0xFFE0E0E0);
const _kTextDark    = Color(0xFF212121);
const _kTextMuted   = Color(0xFF757575);

// ─── 1. Overview ───────────────────────────────────────────
const _kOverview = 'ScrollableState is the State for a Scrollable widget — the '
    'invisible engine that makes scrolling work in Flutter. Every ListView, '
    'GridView, and CustomScrollView ultimately contains a Scrollable (found via '
    'Scrollable.of(context)). ScrollableState manages a ScrollPosition, listens '
    'to gesture events, and coordinates with the viewport to transform drags '
    'into pixel offsets.';

// ─── 2. ScrollContext ──────────────────────────────────────
class _ContextMember {
  const _ContextMember(this.name, this.type, this.description);
  final String name;
  final String type;
  final String description;
}

const _kContextMembers = <_ContextMember>[
  _ContextMember('axisDirection', 'AxisDirection',
      'The direction in which the view scrolls (down, up, left, right). '
      'Combined with growth direction to determine content flow.'),
  _ContextMember('notificationContext', 'BuildContext?',
      'The context for dispatching ScrollNotification objects up the tree. '
      'Used by NotificationListener<ScrollNotification>.'),
  _ContextMember('storageContext', 'BuildContext',
      'The context used for saving and restoring scroll position. '
      'PageStorage uses this to persist scroll offset.'),
  _ContextMember('vsync', 'TickerProvider',
      'Provides the ticker for smooth scroll animations (ballistic, driven). '
      'ScrollableState mixes in TickerProviderStateMixin for this.'),
  _ContextMember('setIgnorePointer', 'void → (bool)',
      'Called to toggle the IgnorePointer widget that overlays the scrollable '
      'during a ballistic animation, preventing accidental taps.'),
  _ContextMember('setSemanticsActions', 'void → (Set<SemanticsAction>)',
      'Updates accessibility semantics for scroll (scrollUp, scrollDown, etc.).'),
  _ContextMember('saveOffset', 'void → (double)',
      'Persists the current scroll offset to PageStorage for later restoration.'),
];

// ─── 3. Position management ────────────────────────────────
const _kPositionSteps = <String, String>{
  'Attach':
      'When Scrollable.createState runs, the ScrollController creates a '
      'ScrollPosition and attaches it to the ScrollableState. If no controller '
      'is specified, Scrollable creates a default single-position controller.',
  'Initialize':
      'On first layout, the viewport computes its dimensions and the position '
      'receives its initial scroll offset (from PageStorage or 0.0).',
  'Update':
      'During drags, flings, or programmatic scrolls, the position\'s pixels '
      'property changes and the viewport re-lays out its children.',
  'Detach':
      'On dispose, the position is detached from the controller and cleaned up. '
      'The last offset is persisted to PageStorage.',
};

// ─── 6. Axis & physics ─────────────────────────────────────
class _PhysicsInfo {
  const _PhysicsInfo(this.name, this.behavior, this.platform);
  final String name;
  final String behavior;
  final String platform;
}

const _kPhysics = <_PhysicsInfo>[
  _PhysicsInfo('ClampingScrollPhysics',
      'Stops at edge; overscroll clamped to 0. Familiar rigid feel.',
      'Android'),
  _PhysicsInfo('BouncingScrollPhysics',
      'Allows elastic overscroll past edges with spring-back. Rubbery feel.',
      'iOS'),
  _PhysicsInfo('AlwaysScrollableScrollPhysics',
      'Wraps another physics; ensures scrollable even when content fits.',
      'Cross-platform'),
  _PhysicsInfo('NeverScrollableScrollPhysics',
      'Disables user scrolling entirely. Content can only be scrolled programmatically.',
      'Cross-platform'),
  _PhysicsInfo('PageScrollPhysics',
      'Snaps to page boundaries. Used by PageView.',
      'Cross-platform'),
];

// ─── 7. Gesture coordination ───────────────────────────────
const _kGestureSteps = <String, String>{
  'Pointer down':
      'ScrollableState receives the initial touch. If scrolling is possible, '
      'a drag or hold gesture begins.',
  'Drag active':
      'ScrollDragController translates pointer deltas to pixel offsets. The '
      'position applies physics (e.g., overscroll resistance).',
  'Drag end / fling':
      'If velocity exceeds threshold, a BallisticScrollActivity simulates '
      'deceleration. Otherwise, the position settles immediately.',
  'Hold':
      'If the user touches during a ballistic fling, a ScrollHoldController '
      'is created. The fling pauses until the user releases or starts dragging.',
  'Idle':
      'When all animation completes, an IdleScrollActivity takes over. The '
      'position stops updating pixels.',
};

// ─── 8. Integration points ─────────────────────────────────
const _kIntegrationPoints = <String, String>{
  'Scrollable.of(context)':
      'Returns the nearest ScrollableState. Use to access position, axisDirection, '
      'or to register notification handlers.',
  'ScrollController':
      'Manages one or more ScrollPositions. Provides jumpTo(), animateTo(), and '
      'the positions list. Attached to Scrollable via constructor.',
  'ScrollNotification':
      'Dispatched by ScrollableState whenever scroll metrics change. Caught by '
      'NotificationListener widgets above in the tree.',
  'PageStorage':
      'ScrollableState automatically saves/restores offset using the storage '
      'context. Enables scroll position persistence across navigation.',
  'RawGestureDetector':
      'ScrollableState wraps its content in a RawGestureDetector configured '
      'for vertical or horizontal drags based on the scroll axis.',
};

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kPurpleDark, _kLimeDark]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16,
                  fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: Offset(0, 2))],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text,
      style: TextStyle(fontSize: 11, color: _kTextMuted,
          fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(text,
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.5,
          color: color ?? _kTextDark, height: 1.45));
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kPurple, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('ScrollableState deep visual demo');
  print('─' * 48);
  print('Sections: overview, ScrollContext, position management,');
  print('live monitoring, programmatic control, axis/physics,');
  print('gesture coordination, integration points.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kPurple, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: _DemoScaffold(),
  );
}

class _DemoScaffold extends StatefulWidget {
  @override
  State<_DemoScaffold> createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<_DemoScaffold> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollableState'),
        backgroundColor: _kPurpleDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [_TheoryPage(), _MonitorPage(), _ControlPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        selectedItemColor: _kPurpleDark,
        onTap: (i) => setState(() => _tabIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Theory'),
          BottomNavigationBarItem(icon: Icon(Icons.monitor_heart_outlined), label: 'Monitor'),
          BottomNavigationBarItem(icon: Icon(Icons.gamepad_outlined), label: 'Control'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 1: Theory
// ═══════════════════════════════════════════════════════════
class _TheoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        // ── Section 1 ──
        _sectionHeader('1 · What Is ScrollableState?', Icons.info_outline),
        SizedBox(height: 8),
        _card(child: Text(_kOverview,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('WIDGET TREE STRUCTURE'),
              SizedBox(height: 8),
              _mono('ListView'),
              _mono('  └─ Scrollable  ← you\'re here'),
              _mono('       ├─ RawGestureDetector (captures drags)'),
              _mono('       └─ Viewport (lays out slivers)'),
              _mono('            └─ SliverList / SliverGrid ...'),
              SizedBox(height: 8),
              _bullet('Scrollable.of(context) returns the nearest ScrollableState.'),
              _bullet('ScrollableState mixes in TickerProviderStateMixin.'),
              _bullet('It implements ScrollContext for position communication.'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 2 ──
        _sectionHeader('2 · ScrollContext Interface', Icons.description_outlined),
        SizedBox(height: 8),
        _card(
          child: Text(
            'ScrollableState implements ScrollContext — the contract that '
            'ScrollPosition uses to communicate back to the widget layer. '
            'Every member here is called by the position at specific lifecycle '
            'moments.',
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
          ),
        ),
        ..._kContextMembers.map((m) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _kPurpleLight,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(m.name,
                        style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                            fontSize: 11.5, color: _kPurpleDark)),
                  ),
                  SizedBox(width: 8),
                  Text(m.type,
                      style: TextStyle(fontFamily: 'monospace', fontSize: 11,
                          color: _kLimeDark, fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(height: 6),
              Text(m.description,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 3 ──
        _sectionHeader('3 · ScrollPosition Management', Icons.swap_vert),
        SizedBox(height: 8),
        ..._kPositionSteps.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kLimeLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(e.key,
                    style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                        fontSize: 12, color: _kLimeDark)),
              ),
              SizedBox(height: 6),
              Text(e.value,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 6 ──
        _sectionHeader('6 · Axis & ScrollPhysics', Icons.tune),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('PHYSICS COMPARISON'),
              SizedBox(height: 8),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2.5),
                  2: FlexColumnWidth(1),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.top,
                border: TableBorder.all(color: _kDivider, width: 0.5),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: _kPurpleLight.withOpacity(0.5)),
                    children: ['Class', 'Behavior', 'Platform'].map((h) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(h, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.5, color: _kPurpleDark)),
                    )).toList(),
                  ),
                  ..._kPhysics.map((p) => TableRow(
                    children: [p.name, p.behavior, p.platform].map((c) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(c, style: TextStyle(fontSize: 10.5, color: _kTextDark)),
                    )).toList(),
                  )),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 7 ──
        _sectionHeader('7 · Drag & Hold Gesture Coordination', Icons.touch_app_outlined),
        SizedBox(height: 8),
        ..._kGestureSteps.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kPurpleLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(e.key,
                    style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                        fontSize: 12, color: _kPurpleDark)),
              ),
              SizedBox(height: 6),
              Text(e.value,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 8 ──
        _sectionHeader('8 · Integration Points', Icons.hub_outlined),
        SizedBox(height: 8),
        ..._kIntegrationPoints.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.key,
                  style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700,
                      fontSize: 13, color: _kLimeDark)),
              SizedBox(height: 4),
              Text(e.value,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 2: Live scroll monitoring
// ═══════════════════════════════════════════════════════════
class _MonitorPage extends StatefulWidget {
  @override
  State<_MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<_MonitorPage> {
  double _pixels = 0;
  double _minExtent = 0;
  double _maxExtent = 0;
  double _viewportDim = 0;
  bool _atEdge = false;
  bool _outOfRange = false;

  bool _onNotification(ScrollNotification notification) {
    final metrics = notification.metrics;
    setState(() {
      _pixels = metrics.pixels;
      _minExtent = metrics.minScrollExtent;
      _maxExtent = metrics.maxScrollExtent;
      _viewportDim = metrics.viewportDimension;
      _atEdge = metrics.atEdge;
      _outOfRange = metrics.outOfRange;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final scrollFraction = _maxExtent > 0 ? (_pixels / _maxExtent).clamp(0.0, 1.0) : 0.0;

    return Column(
      children: [
        // Metrics dashboard
        Container(
          padding: EdgeInsets.all(12),
          color: _kPurpleDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SCROLL METRICS MONITOR',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 8),
              Row(
                children: [
                  _metricChip('pixels', _pixels.toStringAsFixed(1)),
                  SizedBox(width: 8),
                  _metricChip('min', _minExtent.toStringAsFixed(0)),
                  SizedBox(width: 8),
                  _metricChip('max', _maxExtent.toStringAsFixed(0)),
                ],
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  _metricChip('viewport', _viewportDim.toStringAsFixed(0)),
                  SizedBox(width: 8),
                  _metricChip('atEdge', _atEdge.toString()),
                  SizedBox(width: 8),
                  _metricChip('outOfRange', _outOfRange.toString()),
                ],
              ),
              SizedBox(height: 8),
              // Visual scrollbar
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: _kPurple.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: scrollFraction.toDouble(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _kLime,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Scrollable content
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: _onNotification,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 50,
              itemBuilder: (context, index) {
                final hue = (index * 7.2) % 360;
                final color = HSVColor.fromAHSV(1, hue, 0.4, 0.95).toColor();
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  height: 56,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color.withOpacity(0.6)),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text('${index + 1}',
                            style: TextStyle(fontWeight: FontWeight.w800,
                                fontSize: 12, color: _kTextDark)),
                      ),
                      SizedBox(width: 12),
                      Text('List item ${index + 1}',
                          style: TextStyle(fontWeight: FontWeight.w600,
                              fontSize: 14, color: _kTextDark)),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _metricChip(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(color: Colors.white54, fontSize: 9,
                    fontWeight: FontWeight.w600)),
            Text(value,
                style: TextStyle(color: _kLime, fontFamily: 'monospace',
                    fontSize: 12, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 3: Programmatic control
// ═══════════════════════════════════════════════════════════
class _ControlPage extends StatefulWidget {
  @override
  State<_ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<_ControlPage> {
  final ScrollController _controller = ScrollController();
  final List<String> _log = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    // We only log occasionally to avoid flooding
    final px = _controller.position.pixels;
    if (_log.isEmpty || (px - double.tryParse(_log.last.split('→ ').last.replaceAll('px', ''))!).abs() > 50) {
      setState(() {
        _log.add('scroll → ${px.toStringAsFixed(0)}px');
        if (_log.length > 20) _log.removeAt(0);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _jump(double offset) {
    _controller.jumpTo(offset);
    setState(() => _log.add('jumpTo(${offset.toInt()})'));
    print('[Control] jumpTo(${offset.toInt()})');
  }

  void _animate(double offset) {
    _controller.animateTo(offset,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic);
    setState(() => _log.add('animateTo(${offset.toInt()})'));
    print('[Control] animateTo(${offset.toInt()})');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Control buttons
        Container(
          padding: EdgeInsets.all(12),
          color: _kPurpleDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PROGRAMMATIC SCROLL CONTROL',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8, runSpacing: 6,
                children: [
                  _controlButton('Jump 0', () => _jump(0)),
                  _controlButton('Jump 500', () => _jump(500)),
                  _controlButton('Jump 1500', () => _jump(1500)),
                  _controlButton('Anim 0', () => _animate(0)),
                  _controlButton('Anim 800', () => _animate(800)),
                  _controlButton('Anim End', () {
                    final max = _controller.position.maxScrollExtent;
                    _animate(max);
                  }),
                ],
              ),
              SizedBox(height: 8),
              // Event log
              Container(
                height: 60,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: ListView(
                  reverse: true,
                  children: _log.reversed.map((l) => Text(l,
                      style: TextStyle(fontFamily: 'monospace', fontSize: 10,
                          color: _kLime, height: 1.4))).toList(),
                ),
              ),
            ],
          ),
        ),
        // Scrollable list
        Expanded(
          child: ListView.builder(
            controller: _controller,
            physics: ClampingScrollPhysics(),
            itemCount: 80,
            itemBuilder: (context, index) {
              final isTarget = index == 0 || index == 24 || index == 79;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                height: 44,
                decoration: BoxDecoration(
                  color: isTarget ? _kLime.withOpacity(0.3) : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: isTarget ? _kLimeDark : _kDivider,
                      width: isTarget ? 2 : 1),
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Text('#${index + 1}',
                        style: TextStyle(fontFamily: 'monospace',
                            fontWeight: FontWeight.w700, fontSize: 12,
                            color: isTarget ? _kLimeDark : _kTextMuted)),
                    if (isTarget) ...[
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _kLimeDark,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text('TARGET',
                            style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _controlButton(String label, VoidCallback onTap) {
    return Material(
      color: _kLimeDark,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(label,
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
