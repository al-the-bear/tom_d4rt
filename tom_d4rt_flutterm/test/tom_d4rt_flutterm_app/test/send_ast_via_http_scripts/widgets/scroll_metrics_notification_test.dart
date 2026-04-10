// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  ScrollMetricsNotification  –  Deep Visual Demo
//
//  Palette: Teal 700 / Rose 400
//  Tabs  : Theory · Monitor · Dashboard
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('ScrollMetricsNotification demo building');
  return _ScrollMetricsNotificationDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF00796B); // Teal 700
const _kAccent = Color(0xFFEC407A); // Rose 400
const _kSurface = Color(0xFFE0F2F1); // Teal 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF004D40); // Teal 900
const _kMuted = Color(0xFF80CBC4); // Teal 200
const _kCodeBg = Color(0xFFE8F5E9); // Green 50
const _kHighlight = Color(0xFFFCE4EC); // Pink 50
const _kBarPixels = Color(0xFF00ACC1); // Cyan 600
const _kBarMax = Color(0xFFFF7043); // DeepOrange 400
const _kBarViewport = Color(0xFF66BB6A); // Green 400

class _ScrollMetricsNotificationDemo extends StatefulWidget {
  @override
  State<_ScrollMetricsNotificationDemo> createState() =>
      _ScrollMetricsNotificationDemoState();
}

class _ScrollMetricsNotificationDemoState
    extends State<_ScrollMetricsNotificationDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: Text('ScrollMetricsNotification',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kAccent,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Theory'),
            Tab(text: 'Monitor'),
            Tab(text: 'Dashboard'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _MonitorTab(),
          _DashboardTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 1  –  Theory
// ═══════════════════════════════════════════════════════════
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Overview ────────────────────────────────────
        _sectionCard(
          'What is ScrollMetricsNotification?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ScrollMetricsNotification is dispatched when the scroll '
                'metrics of a Scrollable change without the user scrolling. '
                'This happens when the viewport resizes (e.g., keyboard '
                'appears) or the scroll content size changes (items added or '
                'removed). It extends Notification and mixes in '
                'ViewportNotificationMixin.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _codeBlock(
                'class ScrollMetricsNotification\n'
                '    extends Notification\n'
                '    with ViewportNotificationMixin {\n'
                '  ScrollMetricsNotification({\n'
                '    required this.metrics,\n'
                '    required this.context,\n'
                '  });\n'
                '\n'
                '  final ScrollMetrics metrics;\n'
                '  final BuildContext context;\n'
                '}',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── ScrollMetrics properties ────────────────────
        _sectionCard(
          'Key ScrollMetrics Properties',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _metricRow('pixels', 'double',
                  'Current scroll position in logical pixels.',
                  _kBarPixels),
              SizedBox(height: 8),
              _metricRow('minScrollExtent', 'double',
                  'Minimum scroll offset (usually 0.0).',
                  _kPrimary),
              SizedBox(height: 8),
              _metricRow('maxScrollExtent', 'double',
                  'Maximum scroll offset. Equals total content height minus viewport.',
                  _kBarMax),
              SizedBox(height: 8),
              _metricRow('viewportDimension', 'double',
                  'Size of the visible area (viewport height or width).',
                  _kBarViewport),
              SizedBox(height: 8),
              _metricRow('axisDirection', 'AxisDirection',
                  'Which direction content scrolls (down, up, right, left).',
                  _kAccent),
              SizedBox(height: 8),
              _metricRow('extentBefore', 'double',
                  'How much content is before the viewport (≈ pixels).',
                  Color(0xFF5C6BC0)),
              SizedBox(height: 8),
              _metricRow('extentInside', 'double',
                  'Amount of content visible (≈ viewportDimension).',
                  Color(0xFF26A69A)),
              SizedBox(height: 8),
              _metricRow('extentAfter', 'double',
                  'How much content is after the viewport.',
                  Color(0xFFEF5350)),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── When it fires ───────────────────────────────
        _sectionCard(
          'When Does It Fire?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _triggerRow(
                icon: Icons.phone_android,
                title: 'Keyboard appearance',
                detail: 'The viewport shrinks → viewportDimension decreases '
                    '→ maxScrollExtent may increase.',
              ),
              _triggerRow(
                icon: Icons.add_box_outlined,
                title: 'Content size change',
                detail: 'Items added or removed → maxScrollExtent changes '
                    '→ notification dispatched.',
              ),
              _triggerRow(
                icon: Icons.aspect_ratio,
                title: 'Window resize',
                detail: 'On desktop/web, resizing the window changes '
                    'viewportDimension.',
              ),
              _triggerRow(
                icon: Icons.rotate_90_degrees_ccw,
                title: 'Orientation change',
                detail: 'Device rotation swaps width/height, changing '
                    'viewportDimension and maxScrollExtent.',
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kHighlight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kAccent.withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: _kAccent, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Important: This notification does NOT fire during '
                        'user-initiated scrolling. For scroll position '
                        'changes, listen to ScrollNotification or '
                        'ScrollUpdateNotification instead.',
                        style: TextStyle(
                            fontSize: 12,
                            color: _kDarkText,
                            height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Comparison with ScrollNotification ──────────
        _sectionCard(
          'ScrollMetrics vs ScrollNotification',
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              _tableRow(
                ['Aspect', 'ScrollMetricsNotification', 'ScrollNotification'],
                isHeader: true,
              ),
              _tableRow([
                'Trigger',
                'Metrics change (non-scroll)',
                'User scroll / programmatic scroll',
              ]),
              _tableRow([
                'Has pixels delta?',
                'No',
                'Yes (ScrollUpdateNotification)',
              ]),
              _tableRow([
                'Subtypes',
                'None',
                'Start / Update / End / Overscroll',
              ]),
              _tableRow([
                'Common use',
                'Layout changes, resize',
                'Scroll position tracking',
              ]),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Best practices ──────────────────────────────
        _sectionCard(
          'Best Practices',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bp(true,
                  'Use NotificationListener<ScrollMetricsNotification> to '
                  'react to viewport or content size changes.'),
              _bp(true,
                  'Combine with ScrollNotification listeners for a complete '
                  'picture of scroll behavior.'),
              _bp(true,
                  'Check extentAfter to decide whether to show a "scroll '
                  'to bottom" button.'),
              _bp(false,
                  'Do NOT trigger heavy rebuilds from metrics notifications — '
                  'they can fire in quick succession during animations.'),
              _bp(false,
                  'Do NOT confuse this with ScrollUpdateNotification — '
                  'that one fires during scrolling, not metrics changes.'),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Monitor
// ═══════════════════════════════════════════════════════════
class _MonitorTab extends StatefulWidget {
  @override
  State<_MonitorTab> createState() => _MonitorTabState();
}

class _MonitorTabState extends State<_MonitorTab> {
  int _itemCount = 20;
  int _notifCount = 0;
  ScrollMetrics? _lastMetrics;
  final List<_MetricsEvent> _events = [];
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      // Also track user scroll for comparison
      setState(() {}); // Refresh metrics display
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  bool _onMetricsNotification(ScrollMetricsNotification notif) {
    setState(() {
      _notifCount++;
      _lastMetrics = notif.metrics;
      _events.insert(
        0,
        _MetricsEvent(
          '#$_notifCount',
          notif.metrics.pixels,
          notif.metrics.maxScrollExtent,
          notif.metrics.viewportDimension,
          DateTime.now(),
        ),
      );
      if (_events.length > 30) _events.removeLast();
    });
    print('ScrollMetricsNotification #$_notifCount: '
        'pixels=${notif.metrics.pixels.toStringAsFixed(1)}, '
        'max=${notif.metrics.maxScrollExtent.toStringAsFixed(1)}, '
        'viewport=${notif.metrics.viewportDimension.toStringAsFixed(1)}');
    return false; // allow further propagation
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Control bar ─────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: _kPrimary.withOpacity(0.06),
          child: Row(
            children: [
              _statPill('Notifications', '$_notifCount', _kAccent),
              SizedBox(width: 8),
              _statPill('Items', '$_itemCount', _kPrimary),
              Spacer(),
              SizedBox(
                height: 32,
                child: ElevatedButton.icon(
                  onPressed: () => setState(() => _itemCount += 5),
                  icon: Icon(Icons.add, size: 14),
                  label: Text('+5', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              SizedBox(width: 6),
              SizedBox(
                height: 32,
                child: ElevatedButton.icon(
                  onPressed: _itemCount > 5
                      ? () => setState(() => _itemCount -= 5)
                      : null,
                  icon: Icon(Icons.remove, size: 14),
                  label: Text('-5', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              SizedBox(width: 6),
              SizedBox(
                height: 32,
                child: ElevatedButton.icon(
                  onPressed: () => setState(() {
                    _itemCount = 20;
                    _notifCount = 0;
                    _events.clear();
                    _lastMetrics = null;
                  }),
                  icon: Icon(Icons.refresh, size: 14),
                  label: Text('Reset', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Main area ───────────────────────────────────
        Expanded(
          child: Row(
            children: [
              // Left: scrollable list with notification listener
              Expanded(
                flex: 3,
                child: NotificationListener<ScrollMetricsNotification>(
                  onNotification: _onMetricsNotification,
                  child: Column(
                    children: [
                      // Live metrics bar
                      if (_lastMetrics != null || _scrollCtrl.hasClients)
                        _buildLiveMetricsBar(),

                      // List
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollCtrl,
                          padding: EdgeInsets.all(12),
                          itemCount: _itemCount,
                          itemBuilder: (_, i) => _buildListItem(i),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Right: event log
              Container(
                width: 250,
                decoration: BoxDecoration(
                  color: _kCardBg,
                  border: Border(
                      left: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: _kAccent.withOpacity(0.08),
                      child: Row(
                        children: [
                          Icon(Icons.show_chart,
                              size: 16, color: _kAccent),
                          SizedBox(width: 6),
                          Text('Metrics Events',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: _kDarkText)),
                          Spacer(),
                          GestureDetector(
                            onTap: () => setState(() {
                              _events.clear();
                              _notifCount = 0;
                            }),
                            child: Icon(Icons.delete_sweep,
                                size: 16, color: _kMuted),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _events.isEmpty
                          ? Center(
                              child: Text(
                                'Add/remove items to\ntrigger notifications',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: _kMuted, fontSize: 12),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(6),
                              itemCount: _events.length,
                              itemBuilder: (_, i) {
                                final e = _events[i];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: _kAccent.withOpacity(0.04),
                                      borderRadius:
                                          BorderRadius.circular(6),
                                      border: Border.all(
                                          color: _kAccent
                                              .withOpacity(0.15)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(e.label,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700,
                                                    fontSize: 11,
                                                    color: _kAccent)),
                                            Spacer(),
                                            Text(
                                              '${e.time.hour.toString().padLeft(2, '0')}:'
                                              '${e.time.minute.toString().padLeft(2, '0')}:'
                                              '${e.time.second.toString().padLeft(2, '0')}',
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: _kMuted),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        Row(
                                          children: [
                                            _miniProp('px',
                                                e.pixels.toStringAsFixed(0),
                                                _kBarPixels),
                                            SizedBox(width: 4),
                                            _miniProp('max',
                                                e.maxExtent.toStringAsFixed(0),
                                                _kBarMax),
                                            SizedBox(width: 4),
                                            _miniProp('vp',
                                                e.viewport.toStringAsFixed(0),
                                                _kBarViewport),
                                          ],
                                        ),
                                      ],
                                    ),
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
        ),
      ],
    );
  }

  Widget _buildLiveMetricsBar() {
    final metrics = _lastMetrics;
    final pos = _scrollCtrl.hasClients ? _scrollCtrl.position : null;
    final px = pos?.pixels ?? metrics?.pixels ?? 0.0;
    final maxExt = pos?.maxScrollExtent ?? metrics?.maxScrollExtent ?? 0.0;
    final vpDim = pos?.viewportDimension ?? metrics?.viewportDimension ?? 0.0;
    final totalContent = maxExt + vpDim;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: _kPrimary.withOpacity(0.04),
      child: Column(
        children: [
          Row(
            children: [
              _metricChip('pixels', px.toStringAsFixed(1), _kBarPixels),
              SizedBox(width: 6),
              _metricChip('max', maxExt.toStringAsFixed(1), _kBarMax),
              SizedBox(width: 6),
              _metricChip('viewport', vpDim.toStringAsFixed(1), _kBarViewport),
              SizedBox(width: 6),
              _metricChip('total', totalContent.toStringAsFixed(1),
                  _kPrimary),
            ],
          ),
          SizedBox(height: 6),
          // Visual scroll position bar
          Container(
            height: 14,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(7),
            ),
            child: LayoutBuilder(
              builder: (_, constraints) {
                final barWidth = constraints.maxWidth;
                if (totalContent <= 0) {
                  return SizedBox.shrink();
                }
                final vpFrac = vpDim / totalContent;
                final pxFrac = px / totalContent;
                final thumbW = (vpFrac * barWidth).clamp(8.0, barWidth);
                final thumbX = (pxFrac * barWidth).clamp(0.0, barWidth - thumbW);
                return Stack(
                  children: [
                    Positioned(
                      left: thumbX,
                      top: 0,
                      bottom: 0,
                      width: thumbW,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _kPrimary.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(int i) {
    final hue = (i * 17) % 360;
    final itemColor =
        HSLColor.fromAHSL(1.0, hue.toDouble(), 0.4, 0.85).toColor();
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: itemColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text('$i',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: _kDarkText)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Item #$i',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: _kDarkText)),
                Text('Scroll content for metrics monitoring',
                    style: TextStyle(fontSize: 11, color: _kMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricChip(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(
                  fontSize: 10, color: _kMuted, fontFamily: 'monospace'),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: color,
                  fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniProp(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text('$label:$value',
          style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: color,
              fontWeight: FontWeight.w600)),
    );
  }

  Widget _statPill(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label: ',
              style: TextStyle(color: Colors.white70, fontSize: 11)),
          Text(value,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ],
      ),
    );
  }
}

class _MetricsEvent {
  final String label;
  final double pixels;
  final double maxExtent;
  final double viewport;
  final DateTime time;
  _MetricsEvent(this.label, this.pixels, this.maxExtent,
      this.viewport, this.time);
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Dashboard
// ═══════════════════════════════════════════════════════════
class _DashboardTab extends StatefulWidget {
  @override
  State<_DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<_DashboardTab> {
  final ScrollController _scrollCtrl = ScrollController();
  int _itemCount = 30;
  int _metricsEventCount = 0;

  double _currentPixels = 0;
  double _currentMax = 0;
  double _currentViewport = 0;
  double _extentBefore = 0;
  double _extentInside = 0;
  double _extentAfter = 0;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_updateFromScroll);
  }

  void _updateFromScroll() {
    if (!_scrollCtrl.hasClients) return;
    final pos = _scrollCtrl.position;
    setState(() {
      _currentPixels = pos.pixels;
      _currentMax = pos.maxScrollExtent;
      _currentViewport = pos.viewportDimension;
      _extentBefore = pos.extentBefore;
      _extentInside = pos.extentInside;
      _extentAfter = pos.extentAfter;
    });
  }

  bool _onMetricsChange(ScrollMetricsNotification notif) {
    setState(() {
      _metricsEventCount++;
      _currentPixels = notif.metrics.pixels;
      _currentMax = notif.metrics.maxScrollExtent;
      _currentViewport = notif.metrics.viewportDimension;
      _extentBefore = notif.metrics.extentBefore;
      _extentInside = notif.metrics.extentInside;
      _extentAfter = notif.metrics.extentAfter;
    });
    print('Dashboard metrics event #$_metricsEventCount');
    return false;
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalContent = _currentMax + _currentViewport;

    return Column(
      children: [
        // ── Controls ────────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: _kPrimary.withOpacity(0.06),
          child: Row(
            children: [
              _statPill('Items', '$_itemCount', _kPrimary),
              SizedBox(width: 8),
              _statPill('Metric Events', '$_metricsEventCount', _kAccent),
              Spacer(),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () => setState(() => _itemCount += 10),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  child: Text('+10', style: TextStyle(fontSize: 11)),
                ),
              ),
              SizedBox(width: 4),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: _itemCount > 10
                      ? () => setState(() => _itemCount -= 10)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  child: Text('-10', style: TextStyle(fontSize: 11)),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Row(
            children: [
              // Left: scroll area
              Expanded(
                flex: 2,
                child: NotificationListener<ScrollMetricsNotification>(
                  onNotification: _onMetricsChange,
                  child: ListView.builder(
                    controller: _scrollCtrl,
                    padding: EdgeInsets.all(10),
                    itemCount: _itemCount,
                    itemBuilder: (_, i) {
                      final frac = _itemCount > 0 ? i / _itemCount : 0.0;
                      return Container(
                        margin: EdgeInsets.only(bottom: 4),
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              HSLColor.fromAHSL(
                                      1.0, frac * 240, 0.5, 0.75)
                                  .toColor(),
                              HSLColor.fromAHSL(
                                      1.0, frac * 240 + 30, 0.5, 0.85)
                                  .toColor(),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('Item #$i',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: _kDarkText,
                                fontSize: 12)),
                      );
                    },
                  ),
                ),
              ),

              // Right: dashboard
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: _kCardBg,
                  border: Border(
                      left: BorderSide(color: Colors.grey.shade300)),
                ),
                child: ListView(
                  padding: EdgeInsets.all(12),
                  children: [
                    // Minimap
                    _sectionCard(
                      'Viewport Minimap',
                      Column(
                        children: [
                          Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey.shade300),
                            ),
                            child: LayoutBuilder(
                              builder: (_, constraints) {
                                if (totalContent <= 0) {
                                  return Center(
                                    child: Text('Scroll to see',
                                        style: TextStyle(
                                            color: _kMuted,
                                            fontSize: 11)),
                                  );
                                }
                                final barH = constraints.maxHeight;
                                final vpFrac =
                                    _currentViewport / totalContent;
                                final pxFrac =
                                    _currentPixels / totalContent;
                                final thumbH = (vpFrac * barH)
                                    .clamp(8.0, barH);
                                final thumbY = (pxFrac * barH)
                                    .clamp(0.0, barH - thumbH);
                                return Stack(
                                  children: [
                                    // Before region
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      height: thumbY,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF5C6BC0)
                                              .withOpacity(0.15),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(7),
                                            topRight: Radius.circular(7),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: thumbY > 16
                                            ? Text('before',
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    color: Color(0xFF5C6BC0)))
                                            : null,
                                      ),
                                    ),
                                    // Viewport thumb
                                    Positioned(
                                      top: thumbY,
                                      left: 0,
                                      right: 0,
                                      height: thumbH,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _kPrimary
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text('viewport',
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.white,
                                                fontWeight:
                                                    FontWeight.w600)),
                                      ),
                                    ),
                                    // After region
                                    Positioned(
                                      top: thumbY + thumbH,
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEF5350)
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(7),
                                            bottomRight: Radius.circular(7),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: (barH - thumbY - thumbH) > 16
                                            ? Text('after',
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    color: Color(0xFFEF5350)))
                                            : null,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),

                    // Extent bars
                    _sectionCard(
                      'Extent Distribution',
                      Column(
                        children: [
                          _extentBar('extentBefore', _extentBefore,
                              totalContent, Color(0xFF5C6BC0)),
                          SizedBox(height: 6),
                          _extentBar('extentInside', _extentInside,
                              totalContent, Color(0xFF26A69A)),
                          SizedBox(height: 6),
                          _extentBar('extentAfter', _extentAfter,
                              totalContent, Color(0xFFEF5350)),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),

                    // Raw values
                    _sectionCard(
                      'Raw Metrics',
                      Column(
                        children: [
                          _rawRow('pixels', _currentPixels, _kBarPixels),
                          _rawRow('minScrollExtent', 0, _kPrimary),
                          _rawRow('maxScrollExtent', _currentMax, _kBarMax),
                          _rawRow('viewportDimension', _currentViewport,
                              _kBarViewport),
                          _rawRow('totalContent', totalContent,
                              Color(0xFF6D4C41)),
                          Divider(height: 12),
                          _rawRow('extentBefore', _extentBefore,
                              Color(0xFF5C6BC0)),
                          _rawRow('extentInside', _extentInside,
                              Color(0xFF26A69A)),
                          _rawRow('extentAfter', _extentAfter,
                              Color(0xFFEF5350)),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _extentBar(
      String label, double value, double total, Color color) {
    final fraction = total > 0 ? (value / total).clamp(0.0, 1.0) : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label,
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w600)),
            Spacer(),
            Text(value.toStringAsFixed(0),
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: _kDarkText)),
          ],
        ),
        SizedBox(height: 2),
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: fraction,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rawRow(String name, double value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 6),
          Expanded(
            child: Text(name,
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: _kMuted)),
          ),
          Text(value.toStringAsFixed(1),
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: _kDarkText)),
        ],
      ),
    );
  }

  Widget _statPill(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label: ',
              style: TextStyle(color: Colors.white70, fontSize: 11)),
          Text(value,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  Shared helpers
// ═══════════════════════════════════════════════════════════

Widget _sectionCard(String title, Widget child) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: _kPrimary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: _kDarkText)),
            ),
          ],
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kPrimary.withOpacity(0.15)),
    ),
    child: Text(code,
        style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: _kDarkText,
            height: 1.5)),
  );
}

Widget _metricRow(
    String name, String type, String desc, Color color) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.05),
      borderRadius: BorderRadius.circular(6),
      border: Border(left: BorderSide(color: color, width: 3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(name,
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type,
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: _kMuted)),
              Text(desc,
                  style: TextStyle(fontSize: 11, color: _kDarkText)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _triggerRow({
  required IconData icon,
  required String title,
  required String detail,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _kPrimary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kPrimary, size: 18),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: _kDarkText)),
              Text(detail,
                  style: TextStyle(
                      fontSize: 12, color: _kMuted, height: 1.3)),
            ],
          ),
        ),
      ],
    ),
  );
}

TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
  return TableRow(
    decoration: isHeader
        ? BoxDecoration(color: _kPrimary.withOpacity(0.08))
        : null,
    children: cells.map((c) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Text(c,
            style: TextStyle(
              fontSize: 11,
              fontWeight:
                  isHeader ? FontWeight.w700 : FontWeight.w400,
              color: isHeader ? _kPrimary : _kDarkText,
            )),
      );
    }).toList(),
  );
}

Widget _bp(bool isGood, String text) {
  final color = isGood ? Color(0xFF2E7D32) : Color(0xFFC62828);
  final icon =
      isGood ? Icons.check_circle_outline : Icons.cancel_outlined;
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  fontSize: 12, color: _kDarkText, height: 1.4)),
        ),
      ],
    ),
  );
}
