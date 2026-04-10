// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for ScrollUpdateNotification.
///
/// ScrollUpdateNotification is fired every frame when a Scrollable changes its
/// scroll position. It extends ScrollNotification and delivers the scroll
/// delta and optional DragUpdateDetails.
///
/// Demonstrates:
/// - Tab 1 (Live Capture): Real-time capture of ScrollUpdateNotification from
///   a ListView, displaying scrollDelta, pixels, viewport, and max extent
/// - Tab 2 (Delta Analysis): Cumulative delta tracker, direction indicator,
///   velocity estimation from consecutive deltas, and histogram of delta values
/// - Tab 3 (Use Cases): Parallax, infinite scroll, collapsing header, and
///   velocity-based animations — each with interactive scroll demonstrations

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF616161); // Grey 700
const Color _kAccent = Color(0xFFFFD740); // Amber A200
const Color _kSurface = Color(0xFF1A1B1D);
const Color _kCard = Color(0xFF2A2B2D);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF3A3B3D);
const Color _kPositive = Color(0xFF66BB6A);
const Color _kNegative = Color(0xFFEF5350);
const Color _kHighlight = Color(0xFF42A5F5);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _UpdateNotifDemo(),
  );
}

class _UpdateNotifDemo extends StatefulWidget {
  const _UpdateNotifDemo();
  @override
  State<_UpdateNotifDemo> createState() => _UpdateNotifDemoState();
}

class _UpdateNotifDemoState extends State<_UpdateNotifDemo>
    with TickerProviderStateMixin {
  late final TabController _tabCtrl;

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
      appBar: AppBar(
        title: const Text(
          'ScrollUpdateNotification',
          style: TextStyle(
            color: _kAccent,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kPrimary,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(text: 'Capture'),
            Tab(text: 'Delta'),
            Tab(text: 'Use Cases'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _LiveCaptureTab(),
          _DeltaAnalysisTab(),
          _UseCasesTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Live Capture
// ═══════════════════════════════════════════════════════════════════════════════

class _LiveCaptureTab extends StatefulWidget {
  const _LiveCaptureTab();
  @override
  State<_LiveCaptureTab> createState() => _LiveCaptureTabState();
}

class _LiveCaptureTabState extends State<_LiveCaptureTab>
    with AutomaticKeepAliveClientMixin {
  double _lastDelta = 0;
  double _pixels = 0;
  double _maxExtent = 0;
  double _viewportDim = 0;
  bool _isDrag = false;
  int _updateCount = 0;
  final List<_CapturedUpdate> _log = [];

  @override
  bool get wantKeepAlive => true;

  bool _onNotification(ScrollUpdateNotification n) {
    setState(() {
      _lastDelta = n.scrollDelta ?? 0;
      _pixels = n.metrics.pixels;
      _maxExtent = n.metrics.maxScrollExtent;
      _viewportDim = n.metrics.viewportDimension;
      _isDrag = n.dragDetails != null;
      _updateCount++;
      _log.insert(
        0,
        _CapturedUpdate(
          count: _updateCount,
          delta: _lastDelta,
          pixels: _pixels,
          isDrag: _isDrag,
        ),
      );
      if (_log.length > 80) _log.removeLast();
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // ── Metrics panel ──
        Container(
          padding: const EdgeInsets.all(12),
          color: _kCard,
          child: Column(
            children: [
              Row(
                children: [
                  _metricBadge(
                    'scrollDelta',
                    '${_lastDelta.toStringAsFixed(1)} px',
                    _lastDelta > 0
                        ? _kPositive
                        : _lastDelta < 0
                            ? _kNegative
                            : _kDimText,
                  ),
                  const SizedBox(width: 8),
                  _metricBadge(
                    'pixels',
                    _pixels.toStringAsFixed(1),
                    _kHighlight,
                  ),
                  const SizedBox(width: 8),
                  _metricBadge(
                    'updates',
                    '$_updateCount',
                    _kAccent,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _metricBadge(
                    'viewport',
                    '${_viewportDim.toStringAsFixed(0)} px',
                    _kDimText,
                  ),
                  const SizedBox(width: 8),
                  _metricBadge(
                    'maxExtent',
                    '${_maxExtent.toStringAsFixed(0)} px',
                    _kDimText,
                  ),
                  const SizedBox(width: 8),
                  _metricBadge(
                    'source',
                    _isDrag ? 'USER DRAG' : 'MOMENTUM',
                    _isDrag ? _kAccent : _kPrimary,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Progress bar
              _buildProgressBar(),
            ],
          ),
        ),

        // ── Scrollable list ──
        Expanded(
          child: Row(
            children: [
              // Scroll area
              Expanded(
                flex: 3,
                child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: _onNotification,
                  child: ListView.builder(
                    itemCount: 60,
                    itemBuilder: (_, i) => _scrollItem(i),
                  ),
                ),
              ),
              // Log panel
              Expanded(
                flex: 2,
                child: Container(
                  color: _kCard,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Update Log',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Divider(color: _kSubtle, height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _log.length,
                          itemBuilder: (_, i) {
                            final e = _log[i];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 1),
                              child: Text(
                                '#${e.count} Δ${e.delta >= 0 ? "+" : ""}'
                                '${e.delta.toStringAsFixed(1)} '
                                '→ ${e.pixels.toStringAsFixed(0)} '
                                '${e.isDrag ? "D" : "M"}',
                                style: TextStyle(
                                  color: e.delta > 0
                                      ? _kPositive
                                      : e.delta < 0
                                          ? _kNegative
                                          : _kDimText,
                                  fontSize: 9,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _scrollItem(int index) {
    return Container(
      height: 52,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kPrimary.withValues(alpha: 0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomLeft: Radius.circular(6),
              ),
            ),
            child: Text(
              '$index',
              style: const TextStyle(
                color: _kAccent,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Item $index',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Height: 52px  Offset: ${index * 56}px',
                    style: const TextStyle(
                      color: _kDimText,
                      fontSize: 9,
                      fontFamily: 'monospace',
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

  Widget _metricBadge(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(color: _kDimText, fontSize: 8),
            ),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final fraction = _maxExtent > 0
        ? (_pixels / _maxExtent).clamp(0.0, 1.0)
        : 0.0;
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Scroll Progress',
              style: TextStyle(color: _kDimText, fontSize: 9),
            ),
            const Spacer(),
            Text(
              '${(fraction * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                color: _kAccent,
                fontSize: 9,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: fraction,
            backgroundColor: _kSubtle,
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.lerp(_kNegative, _kPositive, fraction) ?? _kAccent,
            ),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

class _CapturedUpdate {
  _CapturedUpdate({
    required this.count,
    required this.delta,
    required this.pixels,
    required this.isDrag,
  });
  final int count;
  final double delta;
  final double pixels;
  final bool isDrag;
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Delta Analysis
// ═══════════════════════════════════════════════════════════════════════════════

class _DeltaAnalysisTab extends StatefulWidget {
  const _DeltaAnalysisTab();
  @override
  State<_DeltaAnalysisTab> createState() => _DeltaAnalysisTabState();
}

class _DeltaAnalysisTabState extends State<_DeltaAnalysisTab>
    with AutomaticKeepAliveClientMixin {
  double _cumulativeDelta = 0;
  int _posCount = 0;
  int _negCount = 0;
  double _maxDelta = 0;
  double _prevPixels = 0;
  double _velocity = 0;
  DateTime _prevTime = DateTime.now();
  final List<double> _deltaHistory = [];
  final List<double> _histogram = List.filled(10, 0); // 0-9, 10-19, ... 90+

  @override
  bool get wantKeepAlive => true;

  void _reset() {
    setState(() {
      _cumulativeDelta = 0;
      _posCount = 0;
      _negCount = 0;
      _maxDelta = 0;
      _prevPixels = 0;
      _velocity = 0;
      _deltaHistory.clear();
      for (var i = 0; i < _histogram.length; i++) {
        _histogram[i] = 0;
      }
    });
  }

  bool _onNotification(ScrollUpdateNotification n) {
    final now = DateTime.now();
    final dt = now.difference(_prevTime).inMilliseconds;
    final delta = n.scrollDelta ?? 0;
    setState(() {
      _cumulativeDelta += delta;
      if (delta > 0) _posCount++;
      if (delta < 0) _negCount++;
      final absDelta = delta.abs();
      if (absDelta > _maxDelta) _maxDelta = absDelta;

      // Velocity estimation
      if (dt > 0) {
        final posDiff = (n.metrics.pixels - _prevPixels).abs();
        _velocity = posDiff / dt * 1000; // px/s
      }
      _prevPixels = n.metrics.pixels;
      _prevTime = now;

      // History
      _deltaHistory.add(delta);
      if (_deltaHistory.length > 120) _deltaHistory.removeAt(0);

      // Histogram
      final bin = (absDelta / 10).floor().clamp(0, 9);
      _histogram[bin]++;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // ── Stats panel ──
        Container(
          padding: const EdgeInsets.all(12),
          color: _kCard,
          child: Column(
            children: [
              Row(
                children: [
                  _statBadge(
                    'Cumulative',
                    '${_cumulativeDelta.toStringAsFixed(0)} px',
                    _cumulativeDelta >= 0 ? _kPositive : _kNegative,
                  ),
                  const SizedBox(width: 8),
                  _statBadge(
                    'Velocity',
                    '${_velocity.toStringAsFixed(0)} px/s',
                    _kHighlight,
                  ),
                  const SizedBox(width: 8),
                  _statBadge(
                    'Peak |Δ|',
                    '${_maxDelta.toStringAsFixed(1)} px',
                    _kAccent,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _statBadge('↓ Forward', '$_posCount', _kPositive),
                  const SizedBox(width: 8),
                  _statBadge('↑ Backward', '$_negCount', _kNegative),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 60,
                    child: GestureDetector(
                      onTap: _reset,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _kPrimary.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'RESET',
                          style: TextStyle(
                            color: _kAccent,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── Histogram ──
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Delta Distribution (|Δ| in 10px bins)',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _buildHistogram(),
            ],
          ),
        ),

        // ── Delta sparkline ──
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recent Deltas (sparkline)',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _buildSparkline(),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // ── Scrollable for capturing ──
        Expanded(
          child: NotificationListener<ScrollUpdateNotification>(
            onNotification: _onNotification,
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: _kSubtle),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (_, i) => Container(
                  height: 36,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '  Scroll item $i  ─  offset ~${i * 38}px',
                    style: const TextStyle(
                      color: _kDimText,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statBadge(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(color: _kDimText, fontSize: 8),
            ),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistogram() {
    final maxVal =
        _histogram.fold(0.0, (m, v) => v > m ? v : m).clamp(1.0, double.infinity);
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kSubtle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(10, (i) {
          final frac = _histogram[i] / maxVal;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: frac,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.lerp(
                              _kPositive,
                              _kNegative,
                              i / 9.0,
                            ),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    i < 9 ? '${i * 10}' : '90+',
                    style: const TextStyle(
                      color: _kDimText,
                      fontSize: 7,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSparkline() {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kSubtle),
      ),
      child: CustomPaint(
        painter: _SparklinePainter(
          data: _deltaHistory,
          positiveColor: _kPositive,
          negativeColor: _kNegative,
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({
    required this.data,
    required this.positiveColor,
    required this.negativeColor,
  });
  final List<double> data;
  final Color positiveColor;
  final Color negativeColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;
    final maxAbs =
        data.fold(0.0, (m, v) => v.abs() > m ? v.abs() : m).clamp(1.0, double.infinity);
    final midY = size.height / 2;
    final stepX = data.length > 1 ? size.width / (data.length - 1) : 0.0;

    // Zero line
    canvas.drawLine(
      Offset(0, midY),
      Offset(size.width, midY),
      Paint()
        ..color = _kDimText.withValues(alpha: 0.2)
        ..strokeWidth = 0.5,
    );

    final posPaint = Paint()
      ..color = positiveColor
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final negPaint = Paint()
      ..color = negativeColor
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (var i = 1; i < data.length; i++) {
      final x0 = (i - 1) * stepX;
      final x1 = i * stepX;
      final y0 = midY - (data[i - 1] / maxAbs) * midY * 0.9;
      final y1 = midY - (data[i] / maxAbs) * midY * 0.9;
      canvas.drawLine(
        Offset(x0, y0),
        Offset(x1, y1),
        data[i] >= 0 ? posPaint : negPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter old) => true;
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Use Cases
// ═══════════════════════════════════════════════════════════════════════════════

class _UseCasesTab extends StatefulWidget {
  const _UseCasesTab();
  @override
  State<_UseCasesTab> createState() => _UseCasesTabState();
}

class _UseCasesTabState extends State<_UseCasesTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Use case 1: Parallax ──
          _buildSectionTitle('1. Parallax Effect'),
          const SizedBox(height: 8),
          const _ParallaxDemo(),
          const SizedBox(height: 16),

          // ── Use case 2: Infinite scroll ──
          _buildSectionTitle('2. Infinite Scroll / Load More'),
          const SizedBox(height: 8),
          const _InfiniteScrollDemo(),
          const SizedBox(height: 16),

          // ── Use case 3: Collapsing header ──
          _buildSectionTitle('3. Collapsing Header'),
          const SizedBox(height: 8),
          const _CollapsingHeaderDemo(),
          const SizedBox(height: 16),

          // ── Constructor reference ──
          _buildSectionTitle('Constructor'),
          const SizedBox(height: 8),
          _buildCodeBlock(
            'ScrollUpdateNotification({\n'
            '  required ScrollMetrics metrics,\n'
            '  required BuildContext context,\n'
            '  DragUpdateDetails? dragDetails,\n'
            '  double? scrollDelta,\n'
            '  int depth = 0,\n'
            '})',
          ),
          const SizedBox(height: 16),

          // ── Properties reference ──
          _buildSectionTitle('Key Properties'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                _propRow('scrollDelta', 'double?',
                    'Distance scrolled in logical px'),
                _propRow('dragDetails', 'DragUpdateDetails?',
                    'Non-null for user drag'),
                _propRow('metrics', 'ScrollMetrics',
                    'Snapshot of scroll position'),
                _propRow('depth', 'int',
                    'Nesting depth of Scrollable ancestor'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Notification hierarchy ──
          _buildSectionTitle('Notification Hierarchy'),
          const SizedBox(height: 8),
          _buildHierarchy(),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'ScrollUpdateNotification fires every frame during scrolling. '
            'Filter by dragDetails != null to distinguish user-initiated '
            'scrolls from ballistic/momentum scrolls.',
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchy() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _hierRow('Notification', _kDimText, false),
          _hierConnector(),
          _hierRow('ScrollNotification', _kHighlight, false),
          _hierConnector(),
          _hierRow('ScrollUpdateNotification', _kAccent, true),
          const SizedBox(height: 8),
          const Divider(color: _kSubtle, height: 1),
          const SizedBox(height: 8),
          const Text(
            'Sibling notifications:',
            style: TextStyle(color: _kDimText, fontSize: 10),
          ),
          const SizedBox(height: 4),
          _hierRow('ScrollStartNotification', _kDimText, false),
          _hierRow('ScrollEndNotification', _kDimText, false),
          _hierRow('OverscrollNotification', _kDimText, false),
          _hierRow('UserScrollNotification', _kDimText, false),
        ],
      ),
    );
  }

  Widget _hierRow(String name, Color color, bool current) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: current ? color : Colors.transparent,
              border: Border.all(color: color, width: 1.2),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: current ? FontWeight.w700 : FontWeight.w400,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _hierConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 12,
          color: _kDimText.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

// ── Parallax Demo ──

class _ParallaxDemo extends StatefulWidget {
  const _ParallaxDemo();
  @override
  State<_ParallaxDemo> createState() => _ParallaxDemoState();
}

class _ParallaxDemoState extends State<_ParallaxDemo> {
  double _scrollOffset = 0;

  bool _onNotification(ScrollUpdateNotification n) {
    setState(() {
      _scrollOffset = n.metrics.pixels;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(color: _kSubtle),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background layer — moves at 0.3x scroll speed
          Positioned(
            top: -_scrollOffset * 0.3,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1A237E),
                    Color(0xFF0D47A1),
                    Color(0xFF01579B),
                    Color(0xFF006064),
                  ],
                ),
              ),
              child: CustomPaint(
                painter: _StarsPainter(offset: _scrollOffset * 0.1),
              ),
            ),
          ),
          // Foreground scrollable
          NotificationListener<ScrollUpdateNotification>(
            onNotification: _onNotification,
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (_, i) => Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: _kCard.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'Parallax item $i  (bg offset: '
                  '${(_scrollOffset * 0.3).toStringAsFixed(0)}px)',
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontFamily: 'monospace',
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

class _StarsPainter extends CustomPainter {
  _StarsPainter({required this.offset});
  final double offset;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white24;
    // Pseudo-random star positions
    for (var i = 0; i < 30; i++) {
      final x = ((i * 97 + 13) % 100) / 100 * size.width;
      final y = ((i * 73 + 47) % 100) / 100 * size.height + offset * 0.5;
      canvas.drawCircle(Offset(x, y % size.height), 1.2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarsPainter old) => old.offset != offset;
}

// ── Infinite Scroll Demo ──

class _InfiniteScrollDemo extends StatefulWidget {
  const _InfiniteScrollDemo();
  @override
  State<_InfiniteScrollDemo> createState() => _InfiniteScrollDemoState();
}

class _InfiniteScrollDemoState extends State<_InfiniteScrollDemo> {
  int _itemCount = 10;
  bool _loading = false;
  String _status = 'Scroll to bottom to load more';

  bool _onNotification(ScrollUpdateNotification n) {
    final remaining =
        n.metrics.maxScrollExtent - n.metrics.pixels;
    if (remaining < 80 && !_loading) {
      _loadMore();
    }
    return false;
  }

  void _loadMore() {
    setState(() {
      _loading = true;
      _status = 'Loading...';
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _itemCount += 5;
          _loading = false;
          _status = 'Loaded! $_itemCount items total';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: _kSubtle),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Status bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            color: _kCard,
            child: Row(
              children: [
                if (_loading)
                  const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: _kAccent,
                    ),
                  ),
                if (_loading) const SizedBox(width: 8),
                Text(
                  _status,
                  style: TextStyle(
                    color: _loading ? _kAccent : _kDimText,
                    fontSize: 10,
                  ),
                ),
                const Spacer(),
                Text(
                  '$_itemCount items',
                  style: const TextStyle(
                    color: _kHighlight,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: _onNotification,
              child: ListView.builder(
                itemCount: _itemCount,
                itemBuilder: (_, i) => Container(
                  height: 32,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: _kCard,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'Row $i',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
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

// ── Collapsing Header Demo ──

class _CollapsingHeaderDemo extends StatefulWidget {
  const _CollapsingHeaderDemo();
  @override
  State<_CollapsingHeaderDemo> createState() => _CollapsingHeaderDemoState();
}

class _CollapsingHeaderDemoState extends State<_CollapsingHeaderDemo> {
  double _headerHeight = 60;
  static const double _maxHeader = 60;
  static const double _minHeader = 20;

  bool _onNotification(ScrollUpdateNotification n) {
    final delta = n.scrollDelta ?? 0;
    setState(() {
      _headerHeight = (_headerHeight - delta * 0.5).clamp(
        _minHeader,
        _maxHeader,
      );
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(color: _kSubtle),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Collapsing header
          AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            height: _headerHeight,
            color: _kPrimary.withValues(alpha: 0.4),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(
                  Icons.article,
                  color: _kAccent,
                  size: _headerHeight > 30 ? 20 : 14,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Collapsing Header',
                        style: TextStyle(
                          color: _kAccent,
                          fontSize: _headerHeight > 40 ? 13 : 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (_headerHeight > 35)
                        Text(
                          'Height: ${_headerHeight.toStringAsFixed(0)}px',
                          style: const TextStyle(
                            color: _kDimText,
                            fontSize: 9,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Scroll content
          Expanded(
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: _onNotification,
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (_, i) => Container(
                  height: 30,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: _kCard,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'Content row $i — scroll to collapse header',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
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

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

Widget _propRow(String name, String type, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: Text(
            type,
            style: const TextStyle(
              color: _kHighlight,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(color: _kDimText, fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 11,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildInfoBanner(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    color: _kPrimary.withValues(alpha: 0.08),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lightbulb_outline, size: 14, color: _kAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _kDimText, fontSize: 11),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: _kAccent,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
}
