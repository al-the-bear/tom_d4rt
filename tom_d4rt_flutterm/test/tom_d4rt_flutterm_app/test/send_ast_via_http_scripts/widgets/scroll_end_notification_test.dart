// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollEndNotification from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF7B1FA2); // Purple 700
const _kAccent = Color(0xFFFFE57F); // Amber A100
const _kSurface = Color(0xFF121212);
const _kCard = Color(0xFF1E1E1E);
const _kDim = Color(0xFF9E9E9E);
const _kBright = Color(0xFFEEEEEE);
const _kStart = Color(0xFF66BB6A); // Green 400
const _kUpdate = Color(0xFF42A5F5); // Blue 400
const _kEnd = Color(0xFFEF5350); // Red 400

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: ColorScheme.dark(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _ScrollEndNotificationDemo(),
  );
}

class _ScrollEndNotificationDemo extends StatefulWidget {
  const _ScrollEndNotificationDemo();

  @override
  State<_ScrollEndNotificationDemo> createState() =>
      _ScrollEndNotificationDemoState();
}

class _ScrollEndNotificationDemoState
    extends State<_ScrollEndNotificationDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: const Text('ScrollEndNotification',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDim,
          tabs: const [
            Tab(icon: Icon(Icons.timeline), text: 'Lifecycle'),
            Tab(icon: Icon(Icons.compare_arrows), text: 'DragDetails'),
            Tab(icon: Icon(Icons.search), text: 'Inspector'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _LifecycleTab(),
          _DragDetailsTab(),
          _InspectorTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Lifecycle: notification sequence
// ═══════════════════════════════════════════════════════════════════════════
class _LifecycleTab extends StatefulWidget {
  const _LifecycleTab();

  @override
  State<_LifecycleTab> createState() => _LifecycleTabState();
}

class _LifecycleTabState extends State<_LifecycleTab> {
  int _startCount = 0;
  int _updateCount = 0;
  int _endCount = 0;
  String _lastNotif = '—';
  final List<_NotifEntry> _history = [];

  void _onNotification(ScrollNotification n) {
    setState(() {
      if (n is ScrollStartNotification) {
        _startCount++;
        _lastNotif = 'ScrollStartNotification';
        _history.insert(0, _NotifEntry('START', _kStart, _startCount));
      } else if (n is ScrollUpdateNotification) {
        _updateCount++;
        _lastNotif = 'ScrollUpdateNotification';
        if (_history.isEmpty || _history.first.label != 'UPDATE') {
          _history.insert(0, _NotifEntry('UPDATE', _kUpdate, _updateCount));
        } else {
          _history.first = _NotifEntry('UPDATE', _kUpdate, _updateCount);
        }
      } else if (n is ScrollEndNotification) {
        _endCount++;
        _lastNotif = 'ScrollEndNotification';
        _history.insert(0, _NotifEntry('END', _kEnd, _endCount));
      }
      if (_history.length > 40) _history.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kPrimary.withAlpha(40), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const Text(
                'ScrollEndNotification',
                style: TextStyle(
                    color: _kBright,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _badge('class', _kPrimary),
                  const SizedBox(width: 6),
                  _badge('extends ScrollNotification', _kEnd),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Dispatched when a Scrollable widget stops scrolling. '
                'Part of the three-notification sequence: Start → Update → End.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 11, height: 1.4),
              ),
            ],
          ),
        ),

        // Counters
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: _kCard,
          child: Row(
            children: [
              _counterChip('Start', _startCount, _kStart),
              const SizedBox(width: 6),
              _counterChip('Update', _updateCount, _kUpdate),
              const SizedBox(width: 6),
              _counterChip('End', _endCount, _kEnd),
            ],
          ),
        ),

        // Last notification
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text('Last: $_lastNotif',
              style: const TextStyle(
                  color: _kAccent, fontFamily: 'monospace', fontSize: 11)),
        ),

        // Sequence diagram
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _seqStep('Start', _kStart, _startCount > 0),
              _seqArrow(),
              _seqStep('Update ×N', _kUpdate, _updateCount > 0),
              _seqArrow(),
              _seqStep('End', _kEnd, _endCount > 0),
            ],
          ),
        ),

        // Scrollable area
        Expanded(
          flex: 3,
          child: NotificationListener<ScrollNotification>(
            onNotification: (n) {
              _onNotification(n);
              return false;
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kPrimary.withAlpha(40)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (ctx, i) {
                    final hue = (270 + i * 3.0) % 360;
                    return Container(
                      height: 44,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: HSLColor.fromAHSL(1, hue, 0.2, 0.15)
                            .toColor(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text('Item $i',
                          style: TextStyle(
                              color: HSLColor.fromAHSL(1, hue, 0.5, 0.6)
                                  .toColor(),
                              fontSize: 12)),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        // History
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kPrimary.withAlpha(30)),
            ),
            child: _history.isEmpty
                ? const Center(
                    child: Text('Scroll the list above to see notifications',
                        style: TextStyle(color: _kDim, fontSize: 11)))
                : ListView.builder(
                    itemCount: _history.length,
                    itemBuilder: (ctx, i) {
                      final e = _history[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: e.color),
                            ),
                            const SizedBox(width: 6),
                            Text('${e.label} #${e.count}',
                                style: TextStyle(
                                    color: e.color,
                                    fontFamily: 'monospace',
                                    fontSize: 10)),
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

  Widget _counterChip(String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: color.withAlpha(12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Text(label,
                style: TextStyle(color: color, fontSize: 9)),
            Text('$count',
                style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }

  Widget _seqStep(String label, Color color, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: active ? color.withAlpha(20) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: active ? color.withAlpha(60) : _kDim.withAlpha(20)),
      ),
      child: Text(label,
          style: TextStyle(
              color: active ? color : _kDim.withAlpha(60),
              fontSize: 10,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _seqArrow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(Icons.arrow_forward, size: 14, color: _kDim.withAlpha(40)),
    );
  }
}

class _NotifEntry {
  final String label;
  final Color color;
  final int count;
  _NotifEntry(this.label, this.color, this.count);
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — DragDetails: when null vs non-null
// ═══════════════════════════════════════════════════════════════════════════
class _DragDetailsTab extends StatelessWidget {
  const _DragDetailsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _hdr('dragDetails Property'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.info_outline,
                      color: _kAccent, size: 16),
                  const SizedBox(width: 8),
                  const Text('DragEndDetails? dragDetails',
                      style: TextStyle(
                          color: _kAccent,
                          fontFamily: 'monospace',
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'The dragDetails field captures END details from the drag '
                'gesture that stopped scrolling. It is null when scrolling '
                'ended from a ballistic (fling) animation rather than a '
                'direct drag-end.',
                style: TextStyle(color: _kDim, fontSize: 11, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Scenario A: drag details present
        _hdr('Scenario A — dragDetails Present'),
        const SizedBox(height: 10),
        _scenarioCard(
          'Slow Drag, Then Lift',
          _kStart,
          Icons.pan_tool,
          'User drags slowly and lifts finger. Velocity is too low to '
              'trigger ballistic scrolling. The ScrollEndNotification fires '
              'immediately with dragDetails containing the DragEndDetails.',
          [
            'Touch down → HoldScrollActivity',
            'Drag slowly → DragScrollActivity',
            'Lift finger → velocity ≈ 0',
            'ScrollEndNotification (dragDetails: DragEndDetails)',
            'No ballistic phase',
          ],
          'dragDetails != null ✓',
        ),
        const SizedBox(height: 10),

        // Scenario B: drag details null
        _hdr('Scenario B — dragDetails Null'),
        const SizedBox(height: 10),
        _scenarioCard(
          'Fast Fling, Then Coast',
          _kEnd,
          Icons.swipe,
          'User flings quickly. High velocity triggers ballistic scrolling. '
              'The ScrollEndNotification is deferred until the ballistic '
              'animation completes. By then, dragDetails is null because the '
              'end was not caused by a direct drag-end.',
          [
            'Touch down → HoldScrollActivity',
            'Drag fast → DragScrollActivity',
            'Lift finger → high velocity',
            'BallisticScrollActivity starts',
            'Ballistic scroll decelerates to 0',
            'ScrollEndNotification (dragDetails: null)',
          ],
          'dragDetails == null ✗',
        ),
        const SizedBox(height: 16),

        // Live comparison
        _hdr('Live Comparison'),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(child: _DragDetailsPanel(
              label: 'Slow drag',
              color: _kStart,
            )),
            SizedBox(width: 8),
            Expanded(child: _DragDetailsPanel(
              label: 'Fast fling',
              color: _kEnd,
            )),
          ],
        ),
        const SizedBox(height: 16),

        // Constructor
        _hdr('Constructor'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kAccent.withAlpha(30)),
          ),
          child: const Text(
            'ScrollEndNotification({\n'
            '  required ScrollMetrics metrics,\n'
            '  BuildContext? context,\n'
            '  DragEndDetails? dragDetails,\n'
            '})',
            style: TextStyle(
                color: _kBright,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5),
          ),
        ),
        const SizedBox(height: 16),

        // Inherited members
        _hdr('Inherited from ScrollNotification'),
        const SizedBox(height: 10),
        _memberRow('metrics', 'ScrollMetrics', 'Current scroll position state'),
        const SizedBox(height: 4),
        _memberRow('context', 'BuildContext?', 'Where notification dispatched'),
        const SizedBox(height: 4),
        _memberRow('depth', 'int', 'Nesting depth in scrollable tree'),
        const SizedBox(height: 4),
        _memberRow('debugFillDescription()',
            'void', 'Adds debug properties to description list'),
      ],
    );
  }

  static Widget _scenarioCard(
    String title,
    Color color,
    IconData icon,
    String description,
    List<String> steps,
    String result,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: color,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: color.withAlpha(15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: color.withAlpha(30)),
                      ),
                      child: Text(result,
                          style: TextStyle(
                              color: color,
                              fontSize: 9,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(description,
              style:
                  const TextStyle(color: _kDim, fontSize: 11, height: 1.4)),
          const SizedBox(height: 10),
          ...steps.asMap().entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.withAlpha(15),
                        border: Border.all(color: color.withAlpha(40)),
                      ),
                      child: Center(
                        child: Text('${e.key + 1}',
                            style: TextStyle(
                                color: color,
                                fontSize: 8,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(e.value,
                          style: const TextStyle(
                              color: _kDim,
                              fontSize: 10,
                              fontFamily: 'monospace',
                              height: 1.3)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  static Widget _memberRow(String name, String type, String desc) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kPrimary.withAlpha(25)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(name,
                style: const TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text(type,
                style: TextStyle(
                    color: _kDim.withAlpha(150),
                    fontFamily: 'monospace',
                    fontSize: 10)),
          ),
          Expanded(
            flex: 4,
            child: Text(desc,
                style: const TextStyle(color: _kDim, fontSize: 10)),
          ),
        ],
      ),
    );
  }
}

// ─── DragDetails live panel ────────────────────────────────────────────
class _DragDetailsPanel extends StatefulWidget {
  final String label;
  final Color color;

  const _DragDetailsPanel({required this.label, required this.color});

  @override
  State<_DragDetailsPanel> createState() => _DragDetailsPanelState();
}

class _DragDetailsPanelState extends State<_DragDetailsPanel> {
  String _lastEnd = 'Scroll to see';
  int _endCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withAlpha(40)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: widget.color.withAlpha(12),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Center(
              child: Text(widget.label.toUpperCase(),
                  style: TextStyle(
                      color: widget.color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1)),
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (n) {
                setState(() {
                  _endCount++;
                  _lastEnd = n.dragDetails != null
                      ? 'dragDetails: present'
                      : 'dragDetails: null';
                });
                return false;
              },
              child: ListView.builder(
                itemCount: 40,
                itemBuilder: (ctx, i) => Container(
                  height: 32,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: widget.color.withAlpha(8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text('$i',
                      style: TextStyle(
                          color: widget.color.withAlpha(100),
                          fontSize: 10)),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            child: Column(
              children: [
                Text('End #$_endCount',
                    style: TextStyle(
                        color: widget.color,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
                Text(_lastEnd,
                    style: const TextStyle(
                        color: _kDim,
                        fontFamily: 'monospace',
                        fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Inspector: live metric capture
// ═══════════════════════════════════════════════════════════════════════════
class _InspectorTab extends StatefulWidget {
  const _InspectorTab();

  @override
  State<_InspectorTab> createState() => _InspectorTabState();
}

class _InspectorTabState extends State<_InspectorTab> {
  final List<_EndSnapshot> _snapshots = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Info bar
        Container(
          padding: const EdgeInsets.all(10),
          color: _kCard,
          child: const Text(
            'Scroll the list below. Every ScrollEndNotification is captured '
            'with full metrics snapshot.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _kDim, fontSize: 11, height: 1.3),
          ),
        ),

        // Scrollable
        Expanded(
          flex: 3,
          child: NotificationListener<ScrollNotification>(
            onNotification: (n) {
              if (n is ScrollEndNotification) {
                setState(() {
                  _snapshots.insert(
                    0,
                    _EndSnapshot(
                      pixels: n.metrics.pixels,
                      minExtent: n.metrics.minScrollExtent,
                      maxExtent: n.metrics.maxScrollExtent,
                      viewport: n.metrics.viewportDimension,
                      direction: n.metrics.axisDirection,
                      depth: n.depth,
                      hasDragDetails: n.dragDetails != null,
                    ),
                  );
                  if (_snapshots.length > 30) _snapshots.removeLast();
                });
              }
              return false;
            },
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kPrimary.withAlpha(40)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ListView.builder(
                  itemCount: 80,
                  itemBuilder: (ctx, i) {
                    final shade = (i / 80 * 0.3 + 0.1);
                    return Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: _kPrimary.withAlpha((shade * 50).toInt()),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text('Row $i',
                          style: TextStyle(
                              color: _kBright.withAlpha(100),
                              fontSize: 11)),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        // Snapshot list
        Expanded(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kPrimary.withAlpha(30)),
            ),
            child: _snapshots.isEmpty
                ? const Center(
                    child: Text('No end notifications yet',
                        style: TextStyle(color: _kDim, fontSize: 11)))
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _snapshots.length,
                    itemBuilder: (ctx, i) {
                      final s = _snapshots[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _kCard,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: s.hasDragDetails
                                  ? _kStart.withAlpha(30)
                                  : _kEnd.withAlpha(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('#${_snapshots.length - i}',
                                    style: const TextStyle(
                                        color: _kAccent,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: s.hasDragDetails
                                        ? _kStart.withAlpha(15)
                                        : _kEnd.withAlpha(15),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: s.hasDragDetails
                                            ? _kStart.withAlpha(40)
                                            : _kEnd.withAlpha(40)),
                                  ),
                                  child: Text(
                                    s.hasDragDetails
                                        ? 'dragDetails ✓'
                                        : 'dragDetails ✗',
                                    style: TextStyle(
                                        color: s.hasDragDetails
                                            ? _kStart
                                            : _kEnd,
                                        fontSize: 9,
                                        fontFamily: 'monospace'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            _snapField('pixels',
                                s.pixels.toStringAsFixed(1)),
                            _snapField('extent',
                                '${s.minExtent.toStringAsFixed(0)}..${s.maxExtent.toStringAsFixed(0)}'),
                            _snapField('viewport',
                                s.viewport.toStringAsFixed(1)),
                            _snapField('direction',
                                s.direction.name),
                            _snapField('depth', '${s.depth}'),
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

  Widget _snapField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(label,
                style: TextStyle(
                    color: _kDim.withAlpha(150),
                    fontSize: 9,
                    fontFamily: 'monospace')),
          ),
          Text(value,
              style: const TextStyle(
                  color: _kBright,
                  fontSize: 9,
                  fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

class _EndSnapshot {
  final double pixels;
  final double minExtent;
  final double maxExtent;
  final double viewport;
  final AxisDirection direction;
  final int depth;
  final bool hasDragDetails;

  _EndSnapshot({
    required this.pixels,
    required this.minExtent,
    required this.maxExtent,
    required this.viewport,
    required this.direction,
    required this.depth,
    required this.hasDragDetails,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// Shared Helpers
// ═══════════════════════════════════════════════════════════════════════════
Widget _hdr(String title) {
  return Row(
    children: [
      Container(width: 4, height: 20, color: _kAccent),
      const SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: const TextStyle(
                color: _kBright,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ),
    ],
  );
}

Widget _badge(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Text(text,
        style: TextStyle(
            color: color.withAlpha(200),
            fontSize: 10,
            fontFamily: 'monospace')),
  );
}
