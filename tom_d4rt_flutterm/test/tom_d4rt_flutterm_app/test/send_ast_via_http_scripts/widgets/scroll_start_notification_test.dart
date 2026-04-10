// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for ScrollStartNotification.
///
/// ScrollStartNotification is sent when a Scrollable widget has started
/// scrolling. It extends ScrollNotification and provides optional
/// DragStartDetails if scrolling was initiated by a drag gesture.
///
/// Demonstrates:
/// - Tab 1 (Notification Capture): Real-time capture of ScrollStartNotification
///   from a scrollable list, displaying metrics snapshot, dragDetails presence,
///   depth, and context information
/// - Tab 2 (Lifecycle Sequence): Visualization of the scroll notification
///   lifecycle (Start → Update → End / Overscroll), showing the ordering and
///   frequency of each notification type during scroll interaction
/// - Tab 3 (DragDetails & Filtering): DragStartDetails structure with
///   globalPosition, localPosition, sourceTimeStamp, programmatic vs gesture
///   distinction, and NotificationListener filtering patterns

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF4E342E); // Brown 800
const Color _kAccent = Color(0xFFF48FB1); // Pink A100
const Color _kSurface = Color(0xFF1B1A1E);
const Color _kCard = Color(0xFF2B2A2E);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF3A393E);
const Color _kSuccess = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFFFCA28);
const Color _kInfo = Color(0xFF42A5F5);

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
    home: const _ScrollStartDemo(),
  );
}

class _ScrollStartDemo extends StatefulWidget {
  const _ScrollStartDemo();
  @override
  State<_ScrollStartDemo> createState() => _ScrollStartDemoState();
}

class _ScrollStartDemoState extends State<_ScrollStartDemo>
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
          'ScrollStartNotification',
          style: TextStyle(
            color: _kAccent,
            fontSize: 16,
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
            Tab(text: 'Lifecycle'),
            Tab(text: 'Details'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _NotificationCaptureTab(),
          _LifecycleSequenceTab(),
          _DragDetailsTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Notification Capture
// ═══════════════════════════════════════════════════════════════════════════════

class _NotificationCaptureTab extends StatefulWidget {
  const _NotificationCaptureTab();
  @override
  State<_NotificationCaptureTab> createState() =>
      _NotificationCaptureTabState();
}

class _NotificationCaptureTabState extends State<_NotificationCaptureTab>
    with AutomaticKeepAliveClientMixin {
  final List<_CapturedStart> _captures = [];
  int _captureId = 0;

  @override
  bool get wantKeepAlive => true;

  void _onScrollStart(ScrollStartNotification n) {
    _captureId++;
    setState(() {
      _captures.insert(
        0,
        _CapturedStart(
          id: _captureId,
          pixels: n.metrics.pixels,
          maxExtent: n.metrics.maxScrollExtent,
          viewportDim: n.metrics.viewportDimension,
          hasDragDetails: n.dragDetails != null,
          depth: n.depth,
          timestamp: DateTime.now(),
        ),
      );
      if (_captures.length > 30) _captures.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // ── Stats bar ──
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: _kCard,
          child: Row(
            children: [
              _buildPill('${_captures.length} captured', _kAccent),
              const SizedBox(width: 8),
              _buildPill(
                '${_captures.where((c) => c.hasDragDetails).length} with drag',
                _kSuccess,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _captures.clear()),
                child: const Icon(Icons.clear_all, color: _kDimText, size: 20),
              ),
            ],
          ),
        ),

        // ── Latest capture detail ──
        if (_captures.isNotEmpty) _buildLatestCard(_captures.first),

        // ── Scrollable list (generates notifications) ──
        Expanded(
          child: NotificationListener<ScrollStartNotification>(
            onNotification: (n) {
              _onScrollStart(n);
              return false;
            },
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: 60,
              itemBuilder: (_, i) {
                return Container(
                  height: 48,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: _kCard,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _kSubtle.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        decoration: BoxDecoration(
                          color: _kAccent.withValues(
                            alpha: (1.0 - i / 60.0).clamp(0.15, 1.0),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        'Scrollable item $i',
                        style: const TextStyle(
                          color: _kDimText,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '← scroll to trigger start',
                        style: TextStyle(
                          color: _kDimText.withValues(alpha: 0.35),
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        _buildInfoBanner(
          'ScrollStartNotification is dispatched once per scroll gesture start. '
          'It carries a ScrollMetrics snapshot and optional DragStartDetails.',
        ),
      ],
    );
  }

  Widget _buildLatestCard(_CapturedStart c) {
    final timeStr =
        '${c.timestamp.hour.toString().padLeft(2, '0')}:'
        '${c.timestamp.minute.toString().padLeft(2, '0')}:'
        '${c.timestamp.second.toString().padLeft(2, '0')}.'
        '${c.timestamp.millisecond.toString().padLeft(3, '0')}';
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _kAccent.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.play_arrow, size: 16, color: _kAccent),
              const SizedBox(width: 6),
              Text(
                'Capture #${c.id}',
                style: const TextStyle(
                  color: _kAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                timeStr,
                style: const TextStyle(
                  color: _kDimText,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _kvRow('metrics.pixels', c.pixels.toStringAsFixed(1)),
          _kvRow('metrics.maxScrollExtent', c.maxExtent.toStringAsFixed(1)),
          _kvRow(
            'metrics.viewportDimension',
            c.viewportDim.toStringAsFixed(1),
          ),
          _kvRow(
            'dragDetails',
            c.hasDragDetails ? 'DragStartDetails(…)' : 'null (programmatic)',
          ),
          _kvRow('depth', '${c.depth}'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Lifecycle Sequence
// ═══════════════════════════════════════════════════════════════════════════════

class _LifecycleSequenceTab extends StatefulWidget {
  const _LifecycleSequenceTab();
  @override
  State<_LifecycleSequenceTab> createState() => _LifecycleSequenceTabState();
}

class _LifecycleSequenceTabState extends State<_LifecycleSequenceTab>
    with AutomaticKeepAliveClientMixin {
  int _startCount = 0;
  int _updateCount = 0;
  int _endCount = 0;
  int _overscrollCount = 0;
  final List<_LifecycleEntry> _timeline = [];
  int _sessionId = 0;

  @override
  bool get wantKeepAlive => true;

  void _recordStart() {
    _sessionId++;
    _startCount++;
    setState(() {
      _timeline.insert(
        0,
        _LifecycleEntry(
          session: _sessionId,
          type: _NotifType.start,
          message: 'Session #$_sessionId — ScrollStartNotification',
        ),
      );
    });
  }

  void _recordUpdate() {
    _updateCount++;
    setState(() {
      // collapse consecutive updates
      if (_timeline.isNotEmpty && _timeline.first.type == _NotifType.update) {
        _timeline.first = _LifecycleEntry(
          session: _sessionId,
          type: _NotifType.update,
          message:
              'Session #$_sessionId — ScrollUpdateNotification ×$_updateCount',
        );
      } else {
        _timeline.insert(
          0,
          _LifecycleEntry(
            session: _sessionId,
            type: _NotifType.update,
            message: 'Session #$_sessionId — ScrollUpdateNotification',
          ),
        );
      }
    });
  }

  void _recordEnd() {
    _endCount++;
    setState(() {
      _timeline.insert(
        0,
        _LifecycleEntry(
          session: _sessionId,
          type: _NotifType.end,
          message: 'Session #$_sessionId — ScrollEndNotification',
        ),
      );
    });
  }

  void _recordOverscroll() {
    _overscrollCount++;
    setState(() {
      _timeline.insert(
        0,
        _LifecycleEntry(
          session: _sessionId,
          type: _NotifType.overscroll,
          message: 'Session #$_sessionId — OverscrollNotification',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // ── Counters ──
        Container(
          padding: const EdgeInsets.all(12),
          color: _kCard,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _counterChip('START', _startCount, _kAccent),
              _counterChip('UPDATE', _updateCount, _kInfo),
              _counterChip('END', _endCount, _kSuccess),
              _counterChip('OVER', _overscrollCount, _kWarning),
            ],
          ),
        ),

        // ── Lifecycle diagram ──
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Scroll Notification Lifecycle',
                    style: TextStyle(
                      color: _kAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _lifecycleRow(
                  '1',
                  'ScrollStartNotification',
                  'scrolling begins',
                  _kAccent,
                ),
                _lifecycleArrow(),
                _lifecycleRow(
                  '2',
                  'ScrollUpdateNotification',
                  'position changes ×N',
                  _kInfo,
                ),
                _lifecycleArrow(),
                Row(
                  children: [
                    Expanded(
                      child: _lifecycleRow(
                        '3a',
                        'ScrollEndNotification',
                        'scrolling ends',
                        _kSuccess,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('or', style: TextStyle(color: _kDimText, fontSize: 10)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _lifecycleRow(
                        '3b',
                        'OverscrollNotification',
                        'exceeded bounds',
                        _kWarning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // ── Scrollable (generates all notification types) ──
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (n) {
              if (n is ScrollStartNotification) {
                _recordStart();
              } else if (n is ScrollUpdateNotification) {
                _recordUpdate();
              } else if (n is ScrollEndNotification) {
                _recordEnd();
              } else if (n is OverscrollNotification) {
                _recordOverscroll();
              }
              return false;
            },
            child: _timeline.isEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: 50,
                    itemBuilder: (_, i) => _scrollItem(i),
                  )
                : Column(
                    children: [
                      // ── Timeline ──
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          itemCount: _timeline.length,
                          itemBuilder: (_, i) {
                            final e = _timeline[i];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: _notifColor(e.type),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      e.message,
                                      style: TextStyle(
                                        color: _notifColor(e.type),
                                        fontSize: 11,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // ── Smaller scroll area ──
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: 50,
                          itemBuilder: (_, i) => _scrollItem(i),
                        ),
                      ),
                    ],
                  ),
          ),
        ),

        _buildInfoBanner(
          'Each scroll interaction produces exactly one ScrollStartNotification, '
          'many ScrollUpdateNotifications, and one ScrollEndNotification. '
          'OverscrollNotification replaces updates when bounds are exceeded.',
        ),
      ],
    );
  }

  Widget _scrollItem(int i) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 14),
      child: Text(
        'Row $i',
        style: const TextStyle(color: _kDimText, fontSize: 12),
      ),
    );
  }

  Color _notifColor(_NotifType t) {
    return switch (t) {
      _NotifType.start => _kAccent,
      _NotifType.update => _kInfo,
      _NotifType.end => _kSuccess,
      _NotifType.overscroll => _kWarning,
    };
  }

  Widget _lifecycleRow(
    String step,
    String name,
    String desc,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.5),
          ),
          child: Text(
            step,
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                desc,
                style: const TextStyle(color: _kDimText, fontSize: 9),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _lifecycleArrow() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 12,
          color: _kDimText.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — DragDetails & Filtering
// ═══════════════════════════════════════════════════════════════════════════════

class _DragDetailsTab extends StatefulWidget {
  const _DragDetailsTab();
  @override
  State<_DragDetailsTab> createState() => _DragDetailsTabState();
}

class _DragDetailsTabState extends State<_DragDetailsTab>
    with AutomaticKeepAliveClientMixin {
  bool _showDragCase = true;

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
          // ── Constructor ──
          _buildSectionTitle('Constructor'),
          const SizedBox(height: 8),
          _buildCodeBlock(
            'ScrollStartNotification({\n'
            '  required ScrollMetrics metrics,\n'
            '  required BuildContext context,\n'
            '  DragStartDetails? dragDetails,\n'
            '})',
          ),
          const SizedBox(height: 16),

          // ── DragStartDetails toggle ──
          _buildSectionTitle('DragStartDetails'),
          const SizedBox(height: 8),
          Row(
            children: [
              _toggleChip('User Drag', _showDragCase, () {
                setState(() => _showDragCase = true);
              }),
              const SizedBox(width: 8),
              _toggleChip('Programmatic', !_showDragCase, () {
                setState(() => _showDragCase = false);
              }),
            ],
          ),
          const SizedBox(height: 12),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _showDragCase
                ? _buildDragDetailsCard()
                : _buildProgrammaticCard(),
          ),
          const SizedBox(height: 16),

          // ── Inherited from ScrollNotification ──
          _buildSectionTitle('Inherited Properties'),
          const SizedBox(height: 8),
          _buildInheritedProps(),
          const SizedBox(height: 16),

          // ── Listener pattern ──
          _buildSectionTitle('NotificationListener Pattern'),
          const SizedBox(height: 8),
          _buildCodeBlock(
            'NotificationListener<ScrollStartNotification>(\n'
            '  onNotification: (notification) {\n'
            '    final metrics = notification.metrics;\n'
            '    final drag = notification.dragDetails;\n'
            '    // Handle scroll start event\n'
            '    return false; // Allow bubbling\n'
            '  },\n'
            '  child: scrollableWidget,\n'
            ')',
          ),
          const SizedBox(height: 16),

          // ── Filtering patterns ──
          _buildSectionTitle('Filtering Patterns'),
          const SizedBox(height: 8),
          _buildFilteringSection(),
          const SizedBox(height: 16),

          // ── Use cases ──
          _buildSectionTitle('Common Use Cases'),
          const SizedBox(height: 8),
          _buildUseCaseCard(
            Icons.pause_circle_outline,
            'Pause Animations',
            'Halt expensive animations when user starts scrolling to '
                'preserve frame rate. Resume on ScrollEndNotification.',
          ),
          const SizedBox(height: 8),
          _buildUseCaseCard(
            Icons.analytics_outlined,
            'Analytics Tracking',
            'Log scroll initiation events with drag position for '
                'user behavior analysis and engagement metrics.',
          ),
          const SizedBox(height: 8),
          _buildUseCaseCard(
            Icons.visibility_off,
            'Hide UI Elements',
            'Collapse floating action buttons, toolbars, or overlays '
                'when scrolling begins. Show again on end.',
          ),
          const SizedBox(height: 8),
          _buildUseCaseCard(
            Icons.keyboard,
            'Dismiss Keyboard',
            'Close the soft keyboard when the user starts scrolling a '
                'form or list to reveal more content.',
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'ScrollStartNotification.dragDetails is non-null only for user-'
            'initiated drags. Programmatic scrolling (animateTo, jumpTo) '
            'produces null dragDetails.',
          ),
        ],
      ),
    );
  }

  Widget _buildDragDetailsCard() {
    return Container(
      key: const ValueKey('drag'),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.touch_app, size: 16, color: _kAccent),
              const SizedBox(width: 8),
              const Text(
                'DragStartDetails (non-null)',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _kvRow('globalPosition', 'Offset(156.0, 342.0)'),
          _kvRow('localPosition', 'Offset(156.0, 128.0)'),
          _kvRow('sourceTimeStamp', 'Duration(0:00:02.341)'),
          _kvRow('kind', 'PointerDeviceKind.touch'),
          const SizedBox(height: 8),
          const Text(
            'User touched screen and began dragging → '
            'scroll start triggered with touch details',
            style: TextStyle(color: _kDimText, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildProgrammaticCard() {
    return Container(
      key: const ValueKey('programmatic'),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kDimText.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.code, size: 16, color: _kDimText),
              const SizedBox(width: 8),
              const Text(
                'dragDetails = null',
                style: TextStyle(
                  color: _kDimText,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _kvRow('cause', 'controller.animateTo() or jumpTo()'),
          _kvRow('dragDetails', 'null'),
          _kvRow('metrics', 'still populated with current position'),
          const SizedBox(height: 8),
          const Text(
            'Programmatic scroll — no user gesture, so no '
            'drag details are available',
            style: TextStyle(color: _kDimText, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildInheritedProps() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _propRow(
            'metrics',
            'ScrollMetrics',
            'Snapshot of scroll position, extent, viewport',
          ),
          _propRow(
            'context',
            'BuildContext?',
            'The Scrollable widget that dispatched',
          ),
          _propRow(
            'depth',
            'int',
            'Nesting depth (0 = direct child)',
          ),
        ],
      ),
    );
  }

  Widget _propRow(String name, String type, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
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
            width: 90,
            child: Text(
              type,
              style: const TextStyle(
                color: _kInfo,
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

  Widget _buildFilteringSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _filterRow(
            'Type-specific',
            'NotificationListener<ScrollStartNotification>',
            'Only ScrollStartNotification',
          ),
          _filterRow(
            'All scroll',
            'NotificationListener<ScrollNotification>',
            'Start + Update + End + Overscroll',
          ),
          _filterRow(
            'Depth filter',
            'if (notification.depth == 0)',
            'Only direct scrollable child',
          ),
          _filterRow(
            'Drag only',
            'if (notification.dragDetails != null)',
            'Only user-initiated scrolls',
          ),
        ],
      ),
    );
  }

  Widget _filterRow(String label, String code, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            code,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            desc,
            style: const TextStyle(color: _kDimText, fontSize: 10),
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }

  Widget _buildUseCaseCard(IconData icon, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kSubtle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: _kAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: const TextStyle(color: _kDimText, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers & data models
// ═══════════════════════════════════════════════════════════════════════════════

class _CapturedStart {
  _CapturedStart({
    required this.id,
    required this.pixels,
    required this.maxExtent,
    required this.viewportDim,
    required this.hasDragDetails,
    required this.depth,
    required this.timestamp,
  });
  final int id;
  final double pixels;
  final double maxExtent;
  final double viewportDim;
  final bool hasDragDetails;
  final int depth;
  final DateTime timestamp;
}

class _LifecycleEntry {
  _LifecycleEntry({
    required this.session,
    required this.type,
    required this.message,
  });
  final int session;
  final _NotifType type;
  final String message;
}

enum _NotifType { start, update, end, overscroll }

Widget _buildPill(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _counterChip(String label, int count, Color color) {
  return Column(
    children: [
      Text(
        '$count',
        style: TextStyle(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        label,
        style: TextStyle(
          color: color.withValues(alpha: 0.7),
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Widget _kvRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            key,
            style: const TextStyle(
              color: _kDimText,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _toggleChip(String label, bool selected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? _kPrimary.withValues(alpha: 0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? _kAccent : _kDimText.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? _kAccent : _kDimText,
          fontSize: 12,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kSubtle),
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
