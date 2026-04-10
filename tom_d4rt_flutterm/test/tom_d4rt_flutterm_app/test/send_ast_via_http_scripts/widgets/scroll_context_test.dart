// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollContext from widgets
import 'package:flutter/material.dart';

// ─── Palette ────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF3949AB); // Indigo 600
const _kAccent = Color(0xFFFF80AB); // Pink A100
const _kSurface = Color(0xFF121212);
const _kCard = Color(0xFF1E1E1E);
const _kDim = Color(0xFF9E9E9E);
const _kBright = Color(0xFFEEEEEE);
const _kGetter = Color(0xFF80DEEA); // Cyan 200
const _kSetter = Color(0xFFFFCC80); // Orange 200

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
    home: const _ScrollContextDemo(),
  );
}

class _ScrollContextDemo extends StatefulWidget {
  const _ScrollContextDemo();

  @override
  State<_ScrollContextDemo> createState() => _ScrollContextDemoState();
}

class _ScrollContextDemoState extends State<_ScrollContextDemo>
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
        title: const Text('ScrollContext',
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold)),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kDim,
          tabs: const [
            Tab(icon: Icon(Icons.description), text: 'Contract'),
            Tab(icon: Icon(Icons.visibility), text: 'Live Inspector'),
            Tab(icon: Icon(Icons.route), text: 'Notification Path'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ContractTab(),
          _LiveInspectorTab(),
          _NotificationPathTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 1 — Contract
// ═══════════════════════════════════════════════════════════════════════════
class _ContractTab extends StatelessWidget {
  const _ContractTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Hero
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF283593), Color(0xFF1A237E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _kAccent.withAlpha(60), width: 2),
          ),
          child: Column(
            children: [
              const Icon(Icons.hub, color: _kAccent, size: 48),
              const SizedBox(height: 12),
              const Text('ScrollContext',
                  style: TextStyle(
                      color: _kBright,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _kAccent.withAlpha(80)),
                ),
                child: Text(
                  'abstract class ScrollContext',
                  style: TextStyle(
                      color: _kAccent.withAlpha(200),
                      fontSize: 11,
                      fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'The bridge between ScrollPosition and the widget that '
                'hosts it (ScrollableState). Provides everything a position '
                'needs: BuildContexts for notifications and storage, a '
                'TickerProvider for animations, axis info, and device metrics.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Abstract Getters
        _hdr('Abstract Getters'),
        const SizedBox(height: 10),
        _memberCard(
          'notificationContext',
          'BuildContext?',
          'The context used to dispatch ScrollNotification. Positioned '
              'outside the Viewport but inside scroll indicators, so '
              'indicators can listen for their own scroll events without '
              'infinite loops.',
          Icons.notifications_none,
          _kGetter,
          true,
        ),
        const SizedBox(height: 10),
        _memberCard(
          'storageContext',
          'BuildContext',
          'The context used for PageStorage lookups. ScrollPosition persists '
              'the scroll offset via PageStorage.of(storageContext) so it '
              'survives widget rebuilds and route pushes.',
          Icons.storage,
          _kGetter,
          true,
        ),
        const SizedBox(height: 10),
        _memberCard(
          'vsync',
          'TickerProvider',
          'A TickerProvider for creating Ticker objects. Used by '
              'BallisticScrollActivity and DrivenScrollActivity to drive '
              'animations frame-by-frame. ScrollableState with '
              'TickerProviderStateMixin fulfills this.',
          Icons.timer,
          _kGetter,
          true,
        ),
        const SizedBox(height: 10),
        _memberCard(
          'axisDirection',
          'AxisDirection',
          'The direction the scroll view scrolls: up, down, left, right. '
              'ScrollPosition uses this for layout calculations and to '
              'determine which axis user gestures should affect.',
          Icons.swap_vert,
          _kGetter,
          true,
        ),
        const SizedBox(height: 10),
        _memberCard(
          'devicePixelRatio',
          'double',
          'The device pixel ratio from the view. Used for pixel-perfect '
              'alignment and rounding scroll offsets to physical pixels.',
          Icons.devices,
          _kGetter,
          true,
        ),
        const SizedBox(height: 24),

        // Abstract setters / methods
        _hdr('Abstract Methods'),
        const SizedBox(height: 10),
        _memberCard(
          'setIgnorePointer(bool)',
          'void',
          'Tell the scrollable to ignore pointer events on its content. '
              'Called with true during ballistic/driven activities so the '
              'user cannot accidentally tap items while the list is coasting.',
          Icons.do_not_touch,
          _kSetter,
          false,
        ),
        const SizedBox(height: 10),
        _memberCard(
          'setCanDrag(bool)',
          'void',
          'Enable or disable drag scrolling. ScrollPosition calls this '
              'after consulting ScrollPhysics.shouldAcceptUserOffset(). '
              'When false, the scrollable does not set up drag gesture '
              'recognizers.',
          Icons.pan_tool_alt,
          _kSetter,
          false,
        ),
        const SizedBox(height: 10),
        _memberCard(
          'setSemanticsActions(Set<SemanticsAction>)',
          'void',
          'Expose scroll actions (scrollUp, scrollDown, scrollLeft, '
              'scrollRight) to the accessibility tree. Screen readers '
              'use these to programmatically scroll the view.',
          Icons.accessibility_new,
          _kSetter,
          false,
        ),
        const SizedBox(height: 10),
        _memberCard(
          'saveOffset(double)',
          'void',
          'Persist the current scroll offset into PageStorage so the '
              'position can be restored when coming back from another route. '
              'Called after every scroll update.',
          Icons.save,
          _kSetter,
          false,
        ),
        const SizedBox(height: 20),

        // Who implements it
        _hdr('Primary Implementation'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kPrimary.withAlpha(50)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kPrimary.withAlpha(15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kPrimary.withAlpha(40)),
                ),
                child: const Text(
                  'class ScrollableState extends State<Scrollable>\n'
                  '    with TickerProviderStateMixin,\n'
                  '         RestorationMixin\n'
                  '    implements ScrollContext { ... }',
                  style: TextStyle(
                      color: _kBright,
                      fontFamily: 'monospace',
                      fontSize: 11,
                      height: 1.5),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'ScrollableState is the only production implementation. '
                'It provides the contexts, ticker, and axis from its own '
                'State lifecycle and widget configuration.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _kDim, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _memberCard(
    String name,
    String type,
    String description,
    IconData icon,
    Color color,
    bool isGetter,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(name,
                          style: TextStyle(
                              color: color,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace')),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withAlpha(15),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: color.withAlpha(30)),
                      ),
                      child: Text(
                        isGetter ? 'get → $type' : '→ $type',
                        style: TextStyle(
                            color: color,
                            fontSize: 9,
                            fontFamily: 'monospace'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(description,
                    style: const TextStyle(
                        color: _kDim, fontSize: 12, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 2 — Live Inspector
// ═══════════════════════════════════════════════════════════════════════════
class _LiveInspectorTab extends StatefulWidget {
  const _LiveInspectorTab();

  @override
  State<_LiveInspectorTab> createState() => _LiveInspectorTabState();
}

class _LiveInspectorTabState extends State<_LiveInspectorTab> {
  final ScrollController _ctrl = ScrollController();
  double _offset = 0;
  double _maxExtent = 0;
  String _lastNotif = 'none';

  @override
  void initState() {
    super.initState();
    _ctrl.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_ctrl.hasClients) return;
    setState(() {
      _offset = _ctrl.position.pixels;
      _maxExtent = _ctrl.position.maxScrollExtent;
    });
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onScroll);
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Inspector panel
        Container(
          padding: const EdgeInsets.all(12),
          color: _kCard,
          child: Column(
            children: [
              const Text('ScrollableState — Live Context Values',
                  style: TextStyle(
                      color: _kAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  _inspVal('axisDirection', 'down', _kGetter),
                  const SizedBox(width: 8),
                  _inspVal('devicePixelRatio',
                      MediaQuery.of(context).devicePixelRatio.toStringAsFixed(1),
                      _kGetter),
                  const SizedBox(width: 8),
                  _inspVal('vsync', 'TickerProvider', _kGetter),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _inspVal('offset', _offset.toStringAsFixed(1), _kPrimary),
                  const SizedBox(width: 8),
                  _inspVal('maxExtent', _maxExtent.toStringAsFixed(0), _kPrimary),
                  const SizedBox(width: 8),
                  _inspVal('lastNotif', _lastNotif, _kAccent),
                ],
              ),
            ],
          ),
        ),

        // Live scrollable
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (n) {
              String label;
              if (n is ScrollStartNotification) {
                label = 'Start';
              } else if (n is ScrollUpdateNotification) {
                label = 'Update';
              } else if (n is ScrollEndNotification) {
                label = 'End';
              } else if (n is OverscrollNotification) {
                label = 'Overscroll';
              } else {
                label = n.runtimeType.toString();
              }
              setState(() => _lastNotif = label);
              return false;
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kPrimary.withAlpha(50)),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView.builder(
                controller: _ctrl,
                itemCount: 40,
                itemBuilder: (ctx, i) {
                  final hue = (i * 9.0) % 360;
                  return Container(
                    height: 54,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color:
                          HSLColor.fromAHSL(1, hue, 0.3, 0.18).toColor(),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: HSLColor.fromAHSL(1, hue, 0.4, 0.3)
                              .toColor()),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text('Item $i',
                            style: TextStyle(
                                color: HSLColor.fromAHSL(1, hue, 0.5, 0.65)
                                    .toColor(),
                                fontSize: 13,
                                fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text('scroll to see context values update',
                            style: TextStyle(
                                color: HSLColor.fromAHSL(1, hue, 0.3, 0.4)
                                    .toColor(),
                                fontSize: 9)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // Explanation
        Container(
          padding: const EdgeInsets.all(12),
          color: _kCard,
          child: const Text(
            'As you scroll, the ScrollableState (implementing ScrollContext) '
            'provides notificationContext for dispatching notifications, '
            'storageContext for PageStorage, and vsync for animation tickers.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _kDim, fontSize: 11, height: 1.4),
          ),
        ),
      ],
    );
  }

  Widget _inspVal(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Text(label,
                style: const TextStyle(color: _kDim, fontSize: 8)),
            const SizedBox(height: 2),
            Text(value,
                style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace'),
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAB 3 — Notification Path
// ═══════════════════════════════════════════════════════════════════════════
class _NotificationPathTab extends StatefulWidget {
  const _NotificationPathTab();

  @override
  State<_NotificationPathTab> createState() => _NotificationPathTabState();
}

class _NotificationPathTabState extends State<_NotificationPathTab> {
  bool _showNotifPath = true; // toggle between notification and storage

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Toggle
        Row(
          children: [
            _toggleBtn('notificationContext', _showNotifPath, _kGetter,
                () => setState(() => _showNotifPath = true)),
            const SizedBox(width: 8),
            _toggleBtn('storageContext', !_showNotifPath, _kSetter,
                () => setState(() => _showNotifPath = false)),
          ],
        ),
        const SizedBox(height: 16),

        if (_showNotifPath) ...[
          _hdr('Notification Context Path'),
          const SizedBox(height: 10),
          _buildNotificationDiagram(),
          const SizedBox(height: 16),
          _buildNotifExplanation(),
        ] else ...[
          _hdr('Storage Context Path'),
          const SizedBox(height: 10),
          _buildStorageDiagram(),
          const SizedBox(height: 16),
          _buildStorageExplanation(),
        ],

        const SizedBox(height: 20),
        _hdr('setIgnorePointer Behavior'),
        const SizedBox(height: 10),
        _buildIgnorePointerDemo(),
        const SizedBox(height: 20),

        _hdr('setCanDrag Behavior'),
        const SizedBox(height: 10),
        _buildCanDragDemo(),
        const SizedBox(height: 20),

        _hdr('saveOffset Persistence'),
        const SizedBox(height: 10),
        _buildSaveOffsetDemo(),
      ],
    );
  }

  Widget _toggleBtn(
      String label, bool active, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? color.withAlpha(20) : _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: active ? color : _kDim.withAlpha(30)),
          ),
          child: Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: active ? color : _kDim,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight:
                      active ? FontWeight.bold : FontWeight.normal)),
        ),
      ),
    );
  }

  Widget _buildNotificationDiagram() {
    const nodes = [
      ('MaterialApp', 'Root of widget tree', _kDim),
      ('Scaffold', 'Layout structure', _kDim),
      ('NotificationListener', 'Catches ScrollNotification here', _kAccent),
      ('ScrollbarState', 'Listens for scroll indicators', _kPrimary),
      ('← notificationContext', 'Context is here, OUTSIDE Viewport', _kGetter),
      ('Viewport', 'Renders slivers', _kDim),
      ('SliverList / SliverGrid', 'Content slivers', _kDim),
    ];
    return _buildTreeDiagram(nodes);
  }

  Widget _buildStorageDiagram() {
    const nodes = [
      ('MaterialApp', 'Root', _kDim),
      ('PageStorage (route)', 'Bucket for this route', _kSetter),
      ('Scaffold', 'Layout', _kDim),
      ('← storageContext', 'Context used for PageStorage.of()', _kSetter),
      ('Scrollable', 'Has PageStorageKey', _kPrimary),
      ('Viewport', 'Renders content', _kDim),
    ];
    return _buildTreeDiagram(nodes);
  }

  Widget _buildTreeDiagram(List<(String, String, Color)> nodes) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(50)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < nodes.length; i++) ...[
            Row(
              children: [
                SizedBox(width: (i * 12).toDouble()),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: nodes[i].$3.withAlpha(60),
                    shape: BoxShape.circle,
                    border: Border.all(color: nodes[i].$3),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: [
                      Text(nodes[i].$1,
                          style: TextStyle(
                              color: nodes[i].$3,
                              fontSize: 12,
                              fontWeight: nodes[i].$1.startsWith('←')
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontFamily: 'monospace')),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(nodes[i].$2,
                            style: const TextStyle(
                                color: _kDim, fontSize: 9),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (i < nodes.length - 1)
              Row(
                children: [
                  SizedBox(width: (i * 12).toDouble() + 3.5),
                  Container(
                    height: 10,
                    width: 1,
                    color: nodes[i].$3.withAlpha(30),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildNotifExplanation() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kGetter.withAlpha(8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kGetter.withAlpha(30)),
      ),
      child: const Text(
        'notificationContext is placed between the scrollbar indicator '
        'and the Viewport. This allows the scrollbar to observe '
        'ScrollNotifications (it listens above this context) without '
        'creating infinite loops (its own scrolling would trigger more '
        'notifications below).',
        style: TextStyle(color: _kDim, fontSize: 12, height: 1.5),
      ),
    );
  }

  Widget _buildStorageExplanation() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSetter.withAlpha(8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kSetter.withAlpha(30)),
      ),
      child: const Text(
        'storageContext is the Scrollable\'s own BuildContext. It walks up '
        'to find a PageStorage bucket where the scroll offset is saved. '
        'Next time the widget tree rebuilds or the route returns, the '
        'scroll position is restored from this bucket.',
        style: TextStyle(color: _kDim, fontSize: 12, height: 1.5),
      ),
    );
  }

  Widget _buildIgnorePointerDemo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kAccent.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.do_not_touch, color: _kAccent, size: 20),
              const SizedBox(width: 8),
              const Text('setIgnorePointer(bool)',
                  style: TextStyle(
                      color: _kAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 10),
          _scenarioRow('Idle', 'false',
              'User can tap items, long press, etc.', _kDim),
          _scenarioRow('Drag', 'true',
              'Prevents accidental taps during drag', _kGetter),
          _scenarioRow('Ballistic', 'true',
              'List coasting — items not interactive', _kPrimary),
          _scenarioRow('Driven', 'true',
              'Animation in progress — items blocked', _kSetter),
        ],
      ),
    );
  }

  Widget _buildCanDragDemo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kPrimary.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.pan_tool_alt, color: _kPrimary, size: 20),
              const SizedBox(width: 8),
              const Text('setCanDrag(bool)',
                  style: TextStyle(
                      color: _kPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'ScrollPhysics.shouldAcceptUserOffset() determines whether '
            'the user should be allowed to drag. When setCanDrag(false) '
            'is called, the scrollable removes its gesture recognizer '
            'entirely — no drag detection at all.',
            style: TextStyle(color: _kDim, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _compactBadge('NeverScrollable', 'canDrag=false', _kAccent),
              const SizedBox(width: 8),
              _compactBadge('AlwaysBouncing', 'canDrag=true', _kGetter),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaveOffsetDemo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kSetter.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.save, color: _kSetter, size: 20),
              const SizedBox(width: 8),
              const Text('saveOffset(double)',
                  style: TextStyle(
                      color: _kSetter,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace')),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'After every scroll update, the position calls saveOffset() '
            'to persist the current pixel offset. ScrollableState implements '
            'this by writing to PageStorage, and when using RestorationMixin, '
            'to the restoration bucket as well.',
            style: TextStyle(color: _kDim, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kSetter.withAlpha(25)),
            ),
            child: const Text(
              'void saveOffset(double offset) {\n'
              '  PageStorage.of(storageContext)\n'
              '    .writeState(\n'
              '      storageContext,\n'
              '      offset,\n'
              '    );\n'
              '}',
              style: TextStyle(
                  color: _kBright,
                  fontFamily: 'monospace',
                  fontSize: 11,
                  height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scenarioRow(
      String activity, String value, String explanation, Color c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: Text(activity,
                style: TextStyle(
                    color: c,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: c.withAlpha(15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(value,
                style: TextStyle(
                    color: c,
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(explanation,
                style: const TextStyle(color: _kDim, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _compactBadge(String label, String value, Color c) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: c.withAlpha(10),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: c.withAlpha(30)),
        ),
        child: Column(
          children: [
            Text(label,
                style: TextStyle(
                    color: c,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace')),
            Text(value,
                style: const TextStyle(color: _kDim, fontSize: 10)),
          ],
        ),
      ),
    );
  }
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
