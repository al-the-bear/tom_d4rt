import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _ScrollableStateDeepDemo();
}

const Color _kCore = Color(0xFF111827);
const Color _kShell = Color(0xFFF8FAFC);
const Color _kPulse = Color(0xFFA7F3D0);

class _ScrollableStateDeepDemo extends StatefulWidget {
  const _ScrollableStateDeepDemo();

  @override
  State<_ScrollableStateDeepDemo> createState() => _ScrollableStateDeepDemoState();
}

class _ScrollableStateDeepDemoState extends State<_ScrollableStateDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kShell,
      appBar: AppBar(
        backgroundColor: _kCore,
        foregroundColor: Colors.white,
        title: const Text('TwoDimensionalScrollableState Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kPulse,
          tabs: const [
            Tab(text: 'State Anatomy'),
            Tab(text: 'Controller Lab'),
            Tab(text: 'Scroll Arena'),
            Tab(text: 'Notification Desk'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _StateAnatomyPanel(),
          _ControllerLabPanel(),
          _ScrollArenaPanel(),
          _NotificationDeskPanel(),
        ],
      ),
    );
  }
}

class _StateAnatomyPanel extends StatelessWidget {
  const _StateAnatomyPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _FrameCard(
          title: 'What TwoDimensionalScrollableState Owns',
          body:
              'The state object orchestrates horizontal and vertical scrolling '
              'contexts, coordinates controller ownership, and exposes axis-specific '
              'ScrollableState handles used by descendants and diagnostics.',
        ),
        SizedBox(height: 12),
        _TopicCard(
          title: 'Lifecycle responsibilities',
          color: Color(0xFF14532D),
          bullets: [
            'initState: setup fallback controllers when explicit ones are absent.',
            'didUpdateWidget: swap ownership when provided controllers change.',
            'build: compose axis wrappers around shared viewport content.',
            'dispose: release fallback controllers and detach listeners.',
          ],
        ),
        _TopicCard(
          title: 'Runtime behavior',
          color: Color(0xFF1D4ED8),
          bullets: [
            'Both axes maintain independent offsets and physics.',
            'Diagonal movement is achieved by combining axis deltas.',
            'Notifications identify axis and metrics independently.',
            'State access is context-scoped through inherited lookup paths.',
          ],
        ),
        _TopicCard(
          title: 'Troubleshooting hints',
          color: Color(0xFF9A3412),
          bullets: [
            'Unexpected jumps usually indicate controller replacement timing.',
            'Stuck axis often means one controller is detached from viewport.',
            'Noise in notifications suggests nested scrollables are not filtered.',
            'Memory leaks come from unreleased fallback controllers.',
          ],
        ),
        SizedBox(height: 12),
        _LookupCard(),
      ],
    );
  }
}

class _LookupCard extends StatelessWidget {
  const _LookupCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Lookup Routes', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            SizedBox(height: 8),
            Text('• TwoDimensionalScrollable.of(context) => full two-axis state access.'),
            Text('• Scrollable.of(context, axis: Axis.vertical) => vertical state path.'),
            Text('• Scrollable.of(context, axis: Axis.horizontal) => horizontal state path.'),
            Text('• NotificationListener<ScrollNotification> => per-axis telemetry stream.'),
          ],
        ),
      ),
    );
  }
}

class _ControllerLabPanel extends StatefulWidget {
  const _ControllerLabPanel();

  @override
  State<_ControllerLabPanel> createState() => _ControllerLabPanelState();
}

class _ControllerLabPanelState extends State<_ControllerLabPanel> {
  bool _useProvidedVertical = false;
  bool _useProvidedHorizontal = false;
  bool _fallBackDisposed = false;
  int _epoch = 1;
  final List<String> _events = <String>['Controller lab initialized'];

  void _push(String text) {
    _events.add(text);
    if (_events.length > 30) {
      _events.removeAt(0);
    }
  }

  void _simulateUpdate() {
    setState(() {
      _epoch++;
      _fallBackDisposed = !_useProvidedVertical || !_useProvidedHorizontal;
      _push('didUpdateWidget epoch=$_epoch, providedV=$_useProvidedVertical, providedH=$_useProvidedHorizontal');
      if (_fallBackDisposed) {
        _push('fallback controller transition triggered');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final verticalOwner = _useProvidedVertical ? 'provided by parent' : 'fallback owned by state';
    final horizontalOwner = _useProvidedHorizontal ? 'provided by parent' : 'fallback owned by state';
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _FrameCard(
          title: 'Controller Ownership Lab',
          body:
              'Toggle between parent-provided and fallback controllers to inspect '
              'the ownership transitions a TwoDimensionalScrollableState must manage.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Use provided vertical controller'),
                  value: _useProvidedVertical,
                  onChanged: (v) => setState(() {
                    _useProvidedVertical = v;
                    _push('vertical ownership switched to ${v ? 'provided' : 'fallback'}');
                  }),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Use provided horizontal controller'),
                  value: _useProvidedHorizontal,
                  onChanged: (v) => setState(() {
                    _useProvidedHorizontal = v;
                    _push('horizontal ownership switched to ${v ? 'provided' : 'fallback'}');
                  }),
                ),
                Row(
                  children: [
                    FilledButton(onPressed: _simulateUpdate, child: const Text('Simulate didUpdateWidget')),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () => setState(() {
                        _events.clear();
                        _events.add('Controller lab reset');
                      }),
                      child: const Text('Clear Timeline'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Vertical controller owner: $verticalOwner'),
                Text('Horizontal controller owner: $horizontalOwner'),
                Text('Fallback disposal touched in last update: $_fallBackDisposed'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFE0F2FE),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lifecycle Timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final event in _events)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $event'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ScrollArenaPanel extends StatefulWidget {
  const _ScrollArenaPanel();

  @override
  State<_ScrollArenaPanel> createState() => _ScrollArenaPanelState();
}

class _ScrollArenaPanelState extends State<_ScrollArenaPanel> {
  late final ScrollController _vertical;
  late final ScrollController _horizontal;
  final List<String> _markers = <String>['Scroll arena ready'];

  @override
  void initState() {
    super.initState();
    _vertical = ScrollController();
    _horizontal = ScrollController();
  }

  @override
  void dispose() {
    _vertical.dispose();
    _horizontal.dispose();
    super.dispose();
  }

  void _log(String text) {
    setState(() {
      _markers.add(text);
      if (_markers.length > 20) {
        _markers.removeAt(0);
      }
    });
  }

  Widget _buildGrid() {
    const rows = 20;
    const cols = 24;
    return Column(
      children: [
        for (var y = 0; y < rows; y++)
          Row(
            children: [
              for (var x = 0; x < cols; x++)
                Container(
                  width: 90,
                  height: 56,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: HSLColor.fromAHSL(1, ((x * 15 + y * 11) % 360).toDouble(), 0.48, 0.73).toColor(),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF334155), width: 0.6),
                  ),
                  child: Center(
                    child: Text('x$x y$y', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _FrameCard(
          title: 'Two-Axis Scroll Arena',
          body:
              'This arena uses nested axis scrollables to visualize how 2D state '
              'coordinates diagonal movement and independent offsets.',
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            FilledButton(
              onPressed: () {
                _vertical.animateTo(
                  (_vertical.offset + 180).clamp(0, _vertical.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
                _horizontal.animateTo(
                  (_horizontal.offset + 220).clamp(0, _horizontal.position.maxScrollExtent),
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                );
                _log('programmatic diagonal scroll');
              },
              child: const Text('Scroll Diagonal'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () {
                _vertical.jumpTo(0);
                _horizontal.jumpTo(0);
                _log('jump to origin');
              },
              child: const Text('Reset Offset'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Card(
          color: Colors.white,
          child: SizedBox(
            height: 360,
            child: Scrollbar(
              controller: _vertical,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _vertical,
                child: Scrollbar(
                  controller: _horizontal,
                  thumbVisibility: true,
                  notificationPredicate: (_) => true,
                  child: SingleChildScrollView(
                    controller: _horizontal,
                    scrollDirection: Axis.horizontal,
                    child: _buildGrid(),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFF1F5F9),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vertical offset: ${_vertical.hasClients ? _vertical.offset.toStringAsFixed(1) : '0.0'}'),
                Text('Horizontal offset: ${_horizontal.hasClients ? _horizontal.offset.toStringAsFixed(1) : '0.0'}'),
                const SizedBox(height: 8),
                for (final marker in _markers)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Text('• $marker'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationDeskPanel extends StatefulWidget {
  const _NotificationDeskPanel();

  @override
  State<_NotificationDeskPanel> createState() => _NotificationDeskPanelState();
}

class _NotificationDeskPanelState extends State<_NotificationDeskPanel> {
  final ScrollController _v = ScrollController();
  final ScrollController _h = ScrollController();
  final List<String> _events = <String>['Notification desk initialized'];

  @override
  void dispose() {
    _v.dispose();
    _h.dispose();
    super.dispose();
  }

  bool _onNotice(ScrollNotification notice) {
    final axis = notice.metrics.axis == Axis.vertical ? 'vertical' : 'horizontal';
    setState(() {
      _events.add('$axis ${notice.runtimeType}: ${notice.metrics.pixels.toStringAsFixed(1)}');
      if (_events.length > 28) {
        _events.removeAt(0);
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _FrameCard(
          title: 'Notification Desk',
          body:
              'Observe axis-specific ScrollNotification streams emitted by a two-axis '
              'surface. This is useful for synchronized headers, minimaps, and analytics.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: SizedBox(
            height: 280,
            child: NotificationListener<ScrollNotification>(
              onNotification: _onNotice,
              child: SingleChildScrollView(
                controller: _v,
                child: SingleChildScrollView(
                  controller: _h,
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      for (var y = 0; y < 12; y++)
                        Row(
                          children: [
                            for (var x = 0; x < 16; x++)
                              Container(
                                width: 80,
                                height: 46,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: HSLColor.fromAHSL(1, ((x * 23 + y * 13) % 360).toDouble(), 0.55, 0.76).toColor(),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(child: Text('$x,$y', style: const TextStyle(fontSize: 11))),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFE2E8F0),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Notification Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final event in _events)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $event'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FrameCard extends StatelessWidget {
  const _FrameCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.title, required this.color, required this.bullets});

  final String title;
  final Color color;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: color)),
              const SizedBox(height: 6),
              for (final bullet in bullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $bullet'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
