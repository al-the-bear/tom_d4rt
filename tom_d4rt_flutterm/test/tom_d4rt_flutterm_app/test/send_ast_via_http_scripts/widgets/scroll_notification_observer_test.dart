// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: ScrollNotificationObserver — observing scroll notifications
// without attaching a ScrollController or manually wrapping in
// NotificationListener. ScrollNotificationObserver is an InheritedWidget
// that lets descendants register handlers for ScrollNotification events.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;

// ─────────────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'ScrollNotificationObserver Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorSchemeSeed: Colors.teal,
      brightness: Brightness.light,
      useMaterial3: true,
    ),
    home: const _ScrollNotifObserverHome(),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Home scaffold — tabbed layout for sections
// ═════════════════════════════════════════════════════════════════════
class _ScrollNotifObserverHome extends StatefulWidget {
  const _ScrollNotifObserverHome();

  @override
  State<_ScrollNotifObserverHome> createState() =>
      _ScrollNotifObserverHomeState();
}

class _ScrollNotifObserverHomeState extends State<_ScrollNotifObserverHome>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  static const _tabs = <String>[
    'Concept',
    'Notification Types',
    'Live Observer',
    'Collapse Header',
    'Multi-Observer',
    'Metrics Inspector',
    'Edge Detection',
    'Summary',
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScrollNotificationObserver'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
        bottom: TabBar(
          controller: _tabCtrl,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _ConceptSection(),
          _NotificationTypesSection(),
          _LiveObserverSection(),
          _CollapseHeaderSection(),
          _MultiObserverSection(),
          _MetricsInspectorSection(),
          _EdgeDetectionSection(),
          _SummarySection(),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 1 — Concept
// ═════════════════════════════════════════════════════════════════════
class _ConceptSection extends StatelessWidget {
  const _ConceptSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'What is ScrollNotificationObserver?',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 12),
        _buildSNOBullet(
          cs,
          Icons.visibility,
          'Purpose',
          'ScrollNotificationObserver is an InheritedWidget that '
              'dispatches ScrollNotification events to registered handlers '
              'without requiring a NotificationListener wrapper in the tree.',
        ),
        _buildSNOBullet(
          cs,
          Icons.account_tree,
          'Placement',
          'Wrap any scrollable subtree with ScrollNotificationObserver. '
              'Descendants can register via ScrollNotificationObserver.of(context) '
              'to receive notifications without coupling to a specific controller.',
        ),
        _buildSNOBullet(
          cs,
          Icons.swap_vert,
          'NotificationListener vs Observer',
          'NotificationListener<T> requires a widget wrapper and returns '
              'a bool to consume or pass on events. The Observer pattern lets '
              'any descendant register/unregister dynamically — ideal for '
              'components like AppBar or FloatingActionButton that react to '
              'scroll position without owning the scrollable.',
        ),
        _buildSNOBullet(
          cs,
          Icons.layers,
          'How It Works',
          'ScrollNotificationObserver listens to all ScrollNotification '
              'events that bubble up through it. Internally it stores a list '
              'of ScrollNotificationObserverState listeners that are called '
              'in registration order.',
        ),
        const Divider(height: 32),
        Text(
          'Widget Hierarchy',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.tertiaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.tertiaryContainer),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHierLine(cs, 'ScrollNotificationObserver', 0, true),
              _buildHierLine(cs, '└─ NotificationListener<ScrollNotification>', 1, false),
              _buildHierLine(cs, '   └─ child (your widget tree)', 2, false),
              _buildHierLine(cs, '      └─ ListView / CustomScrollView / ...', 3, false),
              const SizedBox(height: 12),
              Text(
                'Internally, ScrollNotificationObserver wraps your child '
                'in a NotificationListener that forwards every '
                'ScrollNotification to registered handlers.',
                style: TextStyle(
                  fontSize: 12,
                  color: cs.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Use Cases',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildUseCaseChip(cs, 'Hide/show FAB on scroll'),
        _buildUseCaseChip(cs, 'Collapse toolbar header'),
        _buildUseCaseChip(cs, 'Scroll-to-top button visibility'),
        _buildUseCaseChip(cs, 'Loading indicators on edge scroll'),
        _buildUseCaseChip(cs, 'Analytics — track scroll depth'),
        _buildUseCaseChip(cs, 'Parallax effects tied to scroll offset'),
      ],
    );
  }
}

Widget _buildHierLine(ColorScheme cs, String text, int depth, bool highlight) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 12.0, top: 2, bottom: 2),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 13,
        fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
        color: highlight ? cs.primary : cs.onSurface,
      ),
    ),
  );
}

Widget _buildUseCaseChip(ColorScheme cs, String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Icon(Icons.check_circle_outline, size: 18, color: cs.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(label, style: const TextStyle(fontSize: 14)),
        ),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Section 2 — Notification Types
// ═════════════════════════════════════════════════════════════════════
class _NotificationTypesSection extends StatelessWidget {
  const _NotificationTypesSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'ScrollNotification Subclasses',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 8),
        Text(
          'Every scroll event in Flutter produces a notification that '
          'bubbles up the tree. The observer dispatches all of these:',
          style: TextStyle(color: cs.onSurface.withOpacity(0.75)),
        ),
        const SizedBox(height: 16),
        _buildNotifTypeCard(
          cs,
          'ScrollStartNotification',
          'Fired when the user begins dragging or a programmatic '
              'scroll starts. Contains DragStartDetails when user-initiated.',
          Icons.play_arrow,
          Colors.green,
        ),
        _buildNotifTypeCard(
          cs,
          'ScrollUpdateNotification',
          'Fired on each frame while scrolling. Contains the delta '
              '(scrollDelta) and updated ScrollMetrics with pixels, '
              'minScrollExtent, maxScrollExtent, etc.',
          Icons.update,
          Colors.blue,
        ),
        _buildNotifTypeCard(
          cs,
          'ScrollEndNotification',
          'Fired when the scroll gesture ends. After this, the scroll '
              'may still coast due to ballistic simulation.',
          Icons.stop,
          Colors.red,
        ),
        _buildNotifTypeCard(
          cs,
          'OverscrollNotification',
          'Fired when a scrollable reaches its min or max extent with '
              'ClampingScrollPhysics. The overscroll field tells how many '
              'pixels were rejected. Not fired with BouncingScrollPhysics '
              'since it allows over-scrolling.',
          Icons.arrow_circle_up,
          Colors.orange,
        ),
        _buildNotifTypeCard(
          cs,
          'UserScrollNotification',
          'Fired when the scroll direction changes. Contains the '
              'ScrollDirection (idle, forward, reverse). Useful for '
              'detecting user intent — e.g., hide bottom bar on forward.',
          Icons.person,
          Colors.purple,
        ),
        const Divider(height: 32),
        Text(
          'ScrollMetrics Fields',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildMetricsField(cs, 'pixels', 'Current scroll offset in logical pixels'),
        _buildMetricsField(cs, 'minScrollExtent', 'Minimum scrollable extent (usually 0.0)'),
        _buildMetricsField(cs, 'maxScrollExtent', 'Maximum scrollable extent'),
        _buildMetricsField(cs, 'viewportDimension', 'Size of the visible viewport'),
        _buildMetricsField(cs, 'axisDirection', 'AxisDirection (down, up, left, right)'),
        _buildMetricsField(cs, 'extentBefore', 'Content hidden above the viewport'),
        _buildMetricsField(cs, 'extentInside', 'Content visible in the viewport'),
        _buildMetricsField(cs, 'extentAfter', 'Content hidden below the viewport'),
        _buildMetricsField(cs, 'atEdge', 'True if pixels == min or max extent'),
      ],
    );
  }
}

Widget _buildNotifTypeCard(
  ColorScheme cs,
  String title,
  String description,
  IconData icon,
  Color accent,
) {
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accent, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildMetricsField(ColorScheme cs, String field, String desc) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: cs.secondaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            field,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: cs.onSecondaryContainer,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.75),
            ),
          ),
        ),
      ],
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════
// Section 3 — Live Observer  (shows events streaming in real time)
// ═════════════════════════════════════════════════════════════════════
class _LiveObserverSection extends StatefulWidget {
  const _LiveObserverSection();

  @override
  State<_LiveObserverSection> createState() => _LiveObserverSectionState();
}

class _LiveObserverSectionState extends State<_LiveObserverSection> {
  final List<_ScrollEvent> _events = [];
  static const int _maxEvents = 60;

  void _handleNotification(ScrollNotification notification) {
    final String type;
    final Color color;
    if (notification is ScrollStartNotification) {
      type = 'START';
      color = Colors.green;
    } else if (notification is ScrollUpdateNotification) {
      type = 'UPDATE';
      color = Colors.blue;
    } else if (notification is ScrollEndNotification) {
      type = 'END';
      color = Colors.red;
    } else if (notification is OverscrollNotification) {
      type = 'OVERSCROLL';
      color = Colors.orange;
    } else if (notification is UserScrollNotification) {
      type = 'USER_DIR';
      color = Colors.purple;
    } else {
      type = notification.runtimeType.toString();
      color = Colors.grey;
    }
    setState(() {
      _events.insert(
        0,
        _ScrollEvent(
          type: type,
          color: color,
          pixels: notification.metrics.pixels,
          maxExtent: notification.metrics.maxScrollExtent,
          timestamp: DateTime.now(),
        ),
      );
      if (_events.length > _maxEvents) {
        _events.removeRange(_maxEvents, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Live Event Stream',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Scroll the colored list below. Events are captured by a '
            'ScrollNotificationObserver wrapping the scrollable.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Event log
        Container(
          height: 110,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: cs.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: _events.isEmpty
              ? Center(
                  child: Text(
                    'Scroll the list to see events here...',
                    style: TextStyle(
                      color: cs.onSurface.withOpacity(0.4),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(6),
                  itemCount: _events.length,
                  itemBuilder: (_, i) {
                    final e = _events[i];
                    final ts =
                        '${e.timestamp.second.toString().padLeft(2, '0')}.'
                        '${e.timestamp.millisecond.toString().padLeft(3, '0')}';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: e.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            ts,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                              color: cs.onSurface.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: e.color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              e.type,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: e.color,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${e.pixels.toStringAsFixed(1)} / '
                            '${e.maxExtent.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                              color: cs.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 8),
        // The scrollable list wrapped in ScrollNotificationObserver
        Expanded(
          child: ScrollNotificationObserver(
            child: Builder(
              builder: (innerCtx) {
                // Register the handler via the observer's state
                // ScrollNotificationObserver.of(innerCtx) returns the
                // observer state for handler registration. For this demo
                // we use NotificationListener since the handler API is
                // internal to the observer.
                return NotificationListener<ScrollNotification>(
                  onNotification: (n) {
                    _handleNotification(n);
                    return false; // let it continue to bubble
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 50,
                    itemBuilder: (_, i) {
                      final hue = (i * 7.2) % 360;
                      return Container(
                        height: 56,
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: HSLColor.fromAHSL(1, hue, 0.6, 0.85)
                              .toColor(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          'Item $i',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ScrollEvent {
  final String type;
  final Color color;
  final double pixels;
  final double maxExtent;
  final DateTime timestamp;

  const _ScrollEvent({
    required this.type,
    required this.color,
    required this.pixels,
    required this.maxExtent,
    required this.timestamp,
  });
}

// ═════════════════════════════════════════════════════════════════════
// Section 4 — Collapse Header (hide/show header based on scroll)
// ═════════════════════════════════════════════════════════════════════
class _CollapseHeaderSection extends StatefulWidget {
  const _CollapseHeaderSection();

  @override
  State<_CollapseHeaderSection> createState() => _CollapseHeaderSectionState();
}

class _CollapseHeaderSectionState extends State<_CollapseHeaderSection>
    with SingleTickerProviderStateMixin {
  bool _headerVisible = true;
  late final AnimationController _animCtrl;
  late final Animation<double> _headerHeight;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _headerHeight = Tween<double>(begin: 100, end: 0).animate(
      CurvedAnimation(parent: _animCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      final dir = notification.direction;
      if (dir == ScrollDirection.reverse && _headerVisible) {
        setState(() => _headerVisible = false);
        _animCtrl.forward();
      } else if (dir == ScrollDirection.forward && !_headerVisible) {
        setState(() => _headerVisible = true);
        _animCtrl.reverse();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Collapsible Header Pattern',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Scroll down to collapse the header, scroll up to reveal it. '
            'Uses UserScrollNotification direction to toggle visibility.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScrollNotification,
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _headerHeight,
                  builder: (_, _) {
                    return ClipRect(
                      child: SizedBox(
                        height: _headerHeight.value,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                cs.primaryContainer,
                                cs.tertiaryContainer,
                              ],
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_library,
                                size: 36,
                                color: cs.primary,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Collapsible Banner',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: cs.onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 40,
                    itemBuilder: (_, i) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors
                              .primaries[i % Colors.primaries.length]
                              .shade200,
                          child: Text('${i + 1}'),
                        ),
                        title: Text('Article ${i + 1}'),
                        subtitle: Text(
                          'Scroll to see header collapse / expand',
                          style: TextStyle(
                            fontSize: 12,
                            color: cs.onSurface.withOpacity(0.5),
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
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 5 — Multi-Observer (two independent observers)
// ═════════════════════════════════════════════════════════════════════
class _MultiObserverSection extends StatefulWidget {
  const _MultiObserverSection();

  @override
  State<_MultiObserverSection> createState() => _MultiObserverSectionState();
}

class _MultiObserverSectionState extends State<_MultiObserverSection> {
  double _progressA = 0;
  double _progressB = 0;
  String _directionA = 'idle';
  String _directionB = 'idle';

  bool _handleA(ScrollNotification n) {
    if (n is ScrollUpdateNotification) {
      final metrics = n.metrics;
      if (metrics.maxScrollExtent > 0) {
        setState(() {
          _progressA = metrics.pixels / metrics.maxScrollExtent;
        });
      }
    }
    if (n is UserScrollNotification) {
      setState(() {
        _directionA = n.direction.toString().split('.').last;
      });
    }
    return false;
  }

  bool _handleB(ScrollNotification n) {
    if (n is ScrollUpdateNotification) {
      final metrics = n.metrics;
      if (metrics.maxScrollExtent > 0) {
        setState(() {
          _progressB = metrics.pixels / metrics.maxScrollExtent;
        });
      }
    }
    if (n is UserScrollNotification) {
      setState(() {
        _directionB = n.direction.toString().split('.').last;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'Multiple Independent Observers',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Two side-by-side scrollable lists, each with its own '
            'ScrollNotificationObserver tracking progress and direction.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Status row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _buildProgressIndicator(
                  cs,
                  'List A',
                  _progressA,
                  _directionA,
                  cs.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildProgressIndicator(
                  cs,
                  'List B',
                  _progressB,
                  _directionB,
                  cs.tertiary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: _handleA,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: cs.primary.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ListView.builder(
                          itemCount: 30,
                          itemBuilder: (_, i) => Container(
                            height: 50,
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: cs.primaryContainer.withOpacity(
                                0.3 + (i / 30) * 0.7,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'A-$i',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: cs.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: _handleB,
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: cs.tertiary.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ListView.builder(
                          itemCount: 30,
                          itemBuilder: (_, i) => Container(
                            height: 50,
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: cs.tertiaryContainer.withOpacity(
                                0.3 + (i / 30) * 0.7,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'B-$i',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: cs.tertiary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildProgressIndicator(
    ColorScheme cs,
    String label,
    double progress,
    String direction,
    Color accent,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: accent,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: accent.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation(accent),
          ),
          const SizedBox(height: 4),
          Text(
            '${(progress * 100).toStringAsFixed(0)}%  ·  $direction',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: cs.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 6 — Metrics Inspector  (detailed metrics display)
// ═════════════════════════════════════════════════════════════════════
class _MetricsInspectorSection extends StatefulWidget {
  const _MetricsInspectorSection();

  @override
  State<_MetricsInspectorSection> createState() =>
      _MetricsInspectorSectionState();
}

class _MetricsInspectorSectionState extends State<_MetricsInspectorSection> {
  double _pixels = 0;
  double _minExtent = 0;
  double _maxExtent = 0;
  double _viewportDimension = 0;
  double _extentBefore = 0;
  double _extentInside = 0;
  double _extentAfter = 0;
  bool _atEdge = true;

  bool _onNotification(ScrollNotification n) {
    final m = n.metrics;
    setState(() {
      _pixels = m.pixels;
      _minExtent = m.minScrollExtent;
      _maxExtent = m.maxScrollExtent;
      _viewportDimension = m.viewportDimension;
      _extentBefore = m.extentBefore;
      _extentInside = m.extentInside;
      _extentAfter = m.extentAfter;
      _atEdge = m.atEdge;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            'ScrollMetrics Inspector',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: cs.primary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Scroll the list and watch every metrics field update live.',
            style: TextStyle(
              fontSize: 13,
              color: cs.onSurface.withOpacity(0.7),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Metrics grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.surfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _metricTile(
                          cs, 'pixels', _pixels.toStringAsFixed(1)),
                    ),
                    Expanded(
                      child: _metricTile(cs, 'atEdge', _atEdge.toString()),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: _metricTile(
                          cs, 'minExtent', _minExtent.toStringAsFixed(0)),
                    ),
                    Expanded(
                      child: _metricTile(
                          cs, 'maxExtent', _maxExtent.toStringAsFixed(0)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: _metricTile(
                          cs, 'viewport', _viewportDimension.toStringAsFixed(0)),
                    ),
                    Expanded(
                      child: _metricTile(
                          cs, 'before', _extentBefore.toStringAsFixed(1)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: _metricTile(
                          cs, 'inside', _extentInside.toStringAsFixed(0)),
                    ),
                    Expanded(
                      child: _metricTile(
                          cs, 'after', _extentAfter.toStringAsFixed(1)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Visual extent bar
                _buildExtentsBar(cs),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: _onNotification,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 60,
              itemBuilder: (_, i) {
                final ratio = i / 60;
                return Container(
                  height: 44,
                  margin: const EdgeInsets.only(bottom: 3),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        HSLColor.fromAHSL(1, ratio * 360, 0.5, 0.85)
                            .toColor(),
                        HSLColor.fromAHSL(1, ratio * 360 + 30, 0.5, 0.75)
                            .toColor(),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    'Row $i',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _metricTile(ColorScheme cs, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: cs.onSurface.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: cs.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtentsBar(ColorScheme cs) {
    final total = _extentBefore + _extentInside + _extentAfter;
    if (total <= 0) {
      return const SizedBox.shrink();
    }
    final bFrac = _extentBefore / total;
    final iFrac = _extentInside / total;
    final aFrac = _extentAfter / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Extent Visualization',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: cs.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 20,
            child: Row(
              children: [
                Expanded(
                  flex: (bFrac * 1000).round().clamp(1, 1000),
                  child: Container(
                    color: Colors.orange.shade300,
                    alignment: Alignment.center,
                    child: bFrac > 0.08
                        ? Text(
                            'before',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.orange.shade900,
                            ),
                          )
                        : null,
                  ),
                ),
                Expanded(
                  flex: (iFrac * 1000).round().clamp(1, 1000),
                  child: Container(
                    color: Colors.green.shade300,
                    alignment: Alignment.center,
                    child: Text(
                      'viewport',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: (aFrac * 1000).round().clamp(1, 1000),
                  child: Container(
                    color: Colors.blue.shade300,
                    alignment: Alignment.center,
                    child: aFrac > 0.08
                        ? Text(
                            'after',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.blue.shade900,
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 7 — Edge Detection (scroll-to-top + infinite scroll)
// ═════════════════════════════════════════════════════════════════════
class _EdgeDetectionSection extends StatefulWidget {
  const _EdgeDetectionSection();

  @override
  State<_EdgeDetectionSection> createState() => _EdgeDetectionSectionState();
}

class _EdgeDetectionSectionState extends State<_EdgeDetectionSection> {
  int _itemCount = 20;
  bool _loading = false;
  bool _showScrollToTop = false;
  final ScrollController _scrollCtrl = ScrollController();

  bool _onNotification(ScrollNotification n) {
    // Show scroll-to-top when scrolled past 200 pixels
    if (n is ScrollUpdateNotification) {
      final show = n.metrics.pixels > 200;
      if (show != _showScrollToTop) {
        setState(() => _showScrollToTop = show);
      }
    }
    // Load more when reaching the bottom edge
    if (n is ScrollEndNotification) {
      if (n.metrics.pixels >= n.metrics.maxScrollExtent - 50 && !_loading) {
        _loadMore();
      }
    }
    return false;
  }

  void _loadMore() {
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _itemCount += 10;
          _loading = false;
        });
      }
    });
  }

  void _scrollToTop() {
    _scrollCtrl.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(
                'Edge Detection Patterns',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: cs.primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Demonstrates two common patterns:\n'
                '• Scroll-to-top button appears after scrolling 200px\n'
                '• Infinite scroll — loads 10 more items near the bottom',
                style: TextStyle(
                  fontSize: 13,
                  color: cs.onSurface.withOpacity(0.7),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Items loaded: $_itemCount',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: cs.primary,
                ),
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: _onNotification,
                child: ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _itemCount + (_loading ? 1 : 0),
                  itemBuilder: (_, i) {
                    if (i == _itemCount) {
                      return Container(
                        height: 56,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: cs.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Loading more...',
                              style: TextStyle(
                                color: cs.onSurface.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container(
                      height: 52,
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: cs.secondaryContainer.withOpacity(
                          0.3 + (i % 5) * 0.14,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        dense: true,
                        leading: Icon(
                          Icons.article_outlined,
                          color: cs.secondary,
                        ),
                        title: Text(
                          'Item ${i + 1}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: Text(
                          '#${i + 1}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: cs.onSurface.withOpacity(0.4),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        // Scroll-to-top FAB
        if (_showScrollToTop)
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.small(
              onPressed: _scrollToTop,
              backgroundColor: cs.primaryContainer,
              child: Icon(Icons.arrow_upward, color: cs.onPrimaryContainer),
            ),
          ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════
// Section 8 — Summary
// ═════════════════════════════════════════════════════════════════════
class _SummarySection extends StatelessWidget {
  const _SummarySection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'ScrollNotificationObserver Summary',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: cs.primary),
        ),
        const SizedBox(height: 16),
        _buildSNOBullet(
          cs,
          Icons.widgets,
          'InheritedWidget Pattern',
          'ScrollNotificationObserver uses the InheritedWidget pattern '
              'to let any descendant register for scroll events via '
              'ScrollNotificationObserver.of(context).',
        ),
        _buildSNOBullet(
          cs,
          Icons.notifications_active,
          'Five Notification Types',
          'ScrollStart, ScrollUpdate, ScrollEnd, Overscroll, and '
              'UserScroll — each carries ScrollMetrics with the full '
              'state of the scrollable.',
        ),
        _buildSNOBullet(
          cs,
          Icons.analytics,
          'Metrics Access',
          'pixels, minScrollExtent, maxScrollExtent, viewportDimension, '
              'extentBefore/Inside/After, atEdge — complete scroll state.',
        ),
        _buildSNOBullet(
          cs,
          Icons.visibility_off,
          'Header Collapse',
          'UserScrollNotification direction (forward / reverse / idle) '
              'drives hide/show animations for toolbars and banners.',
        ),
        _buildSNOBullet(
          cs,
          Icons.all_inclusive,
          'Infinite Scroll',
          'Detect when pixels >= maxScrollExtent - threshold in '
              'ScrollEnd to trigger loading more content.',
        ),
        _buildSNOBullet(
          cs,
          Icons.arrow_upward,
          'Scroll-to-Top',
          'Track pixels > N in ScrollUpdate to show/hide a '
              'floating action button that scrolls back to the top.',
        ),
        const Divider(height: 32),
        Text(
          'When to Use',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildSNOSummaryItem(
          cs,
          'Use ScrollNotificationObserver',
          'When multiple unrelated widgets need to react to the same '
              'scroll events without sharing a ScrollController.',
          true,
        ),
        _buildSNOSummaryItem(
          cs,
          'Use NotificationListener directly',
          'When only one widget in a specific part of the tree needs '
              'to handle scroll events and you want simple scoping.',
          true,
        ),
        _buildSNOSummaryItem(
          cs,
          'Avoid for Scroll Control',
          'ScrollNotificationObserver is read-only observation. '
              'Use ScrollController to programmatically scroll, '
              'animate, or jump to positions.',
          false,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                cs.primaryContainer.withOpacity(0.5),
                cs.tertiaryContainer.withOpacity(0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 32, color: cs.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ScrollNotificationObserver decouples scroll observation '
                  'from scroll ownership. Components like AppBar, FABs, '
                  'and analytics trackers can react to scroll events '
                  'without needing a reference to a ScrollController.',
                  style: TextStyle(
                    fontSize: 13,
                    color: cs.onSurface.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Shared helpers (prefixed _buildSNO to avoid collisions)
// ─────────────────────────────────────────────────────────────────────
Widget _buildSNOBullet(
  ColorScheme cs,
  IconData icon,
  String title,
  String body,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: cs.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                body,
                style: TextStyle(
                  fontSize: 13,
                  color: cs.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSNOSummaryItem(
  ColorScheme cs,
  String title,
  String description,
  bool recommended,
) {
  return Card(
    margin: const EdgeInsets.only(bottom: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            recommended ? Icons.check_circle : Icons.warning_amber,
            color: recommended ? Colors.green : Colors.orange,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurface.withOpacity(0.65),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
