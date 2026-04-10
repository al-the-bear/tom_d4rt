import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;

dynamic build(BuildContext context) {
  return const _UserScrollNotificationDeepDemo();
}

const Color _kNight = Color(0xFF111827);
const Color _kPaper = Color(0xFFF8FAFC);

class _UserScrollNotificationDeepDemo extends StatefulWidget {
  const _UserScrollNotificationDeepDemo();

  @override
  State<_UserScrollNotificationDeepDemo> createState() =>
      _UserScrollNotificationDeepDemoState();
}

class _UserScrollNotificationDeepDemoState
    extends State<_UserScrollNotificationDeepDemo>
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
      backgroundColor: _kPaper,
      appBar: AppBar(
        backgroundColor: _kNight,
        foregroundColor: Colors.white,
        title: const Text('UserScrollNotification Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: const Color(0xFF93C5FD),
          tabs: const [
            Tab(text: 'Concept Matrix'),
            Tab(text: 'Live Feed'),
            Tab(text: 'Nested Arenas'),
            Tab(text: 'Playbook'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ConceptMatrixPanel(),
          _LiveFeedPanel(),
          _NestedArenasPanel(),
          _PlaybookPanel(),
        ],
      ),
    );
  }
}

class _ConceptMatrixPanel extends StatelessWidget {
  const _ConceptMatrixPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _HeadingCard(
          title: 'What UserScrollNotification Represents',
          body:
              'UserScrollNotification appears when user input changes effective '
              'scroll direction. It carries direction plus inherited viewport depth.',
        ),
        SizedBox(height: 10),
        _BulletCard(
          title: 'Direction semantics',
          tint: Color(0xFF1D4ED8),
          bullets: [
            'ScrollDirection.forward: movement toward beginning in viewport terms.',
            'ScrollDirection.reverse: movement toward end in viewport terms.',
            'ScrollDirection.idle: no active user-driven directional movement.',
            'Direction value is different from raw pixel delta interpretation.',
          ],
        ),
        _BulletCard(
          title: 'Dispatch timing',
          tint: Color(0xFF166534),
          bullets: [
            'Comes from user interaction pathways (drag/wheel/touchpad gestures).',
            'Emitted during directional transitions while scrolling is active.',
            'Can be filtered by depth to isolate immediate child scrollables.',
            'Complements ScrollUpdateNotification instead of replacing it.',
          ],
        ),
        _BulletCard(
          title: 'Common production patterns',
          tint: Color(0xFF9A3412),
          bullets: [
            'Hide top bars when direction is reverse; reveal on forward.',
            'Trigger prefetch when consistent reverse movement is detected.',
            'Mute expensive effects when direction becomes idle.',
            'Debug nested scroll event origin via notification.depth.',
          ],
        ),
      ],
    );
  }
}

class _LiveFeedPanel extends StatefulWidget {
  const _LiveFeedPanel();

  @override
  State<_LiveFeedPanel> createState() => _LiveFeedPanelState();
}

class _LiveFeedPanelState extends State<_LiveFeedPanel> {
  final ScrollController _controller = ScrollController();
  final List<String> _events = ['Live feed ready: scroll list manually'];
  final Map<ScrollDirection, int> _counts = {
    ScrollDirection.forward: 0,
    ScrollDirection.reverse: 0,
    ScrollDirection.idle: 0,
  };
  ScrollDirection _last = ScrollDirection.idle;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _onNotification(UserScrollNotification n) {
    setState(() {
      _last = n.direction;
      _counts[n.direction] = (_counts[n.direction] ?? 0) + 1;
      final stamp = TimeOfDay.now().format(context);
      _events.add(
        '$stamp | dir=${n.direction.name} | depth=${n.depth} '
        '| px=${n.metrics.pixels.toStringAsFixed(1)}',
      );
      if (_events.length > 26) {
        _events.removeAt(0);
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton(
                onPressed: () => setState(() {
                  _events.clear();
                  _events.add('Feed reset');
                  _counts.updateAll((key, value) => 0);
                  _last = ScrollDirection.idle;
                }),
                child: const Text('Reset Feed'),
              ),
              OutlinedButton(
                onPressed: () => _controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                ),
                child: const Text('Jump Top'),
              ),
              OutlinedButton(
                onPressed: () => _controller.animateTo(
                  _controller.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                ),
                child: const Text('Jump Bottom'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(child: Text('last: ${_last.name}')),
                  Expanded(child: Text('forward: ${_counts[ScrollDirection.forward]}')),
                  Expanded(child: Text('reverse: ${_counts[ScrollDirection.reverse]}')),
                  Expanded(child: Text('idle: ${_counts[ScrollDirection.idle]}')),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: NotificationListener<UserScrollNotification>(
                  onNotification: _onNotification,
                  child: ListView.builder(
                    controller: _controller,
                    padding: const EdgeInsets.all(12),
                    itemCount: 38,
                    itemBuilder: (context, index) {
                      return Card(
                        color: index.isEven ? const Color(0xFFE0F2FE) : Colors.white,
                        child: ListTile(
                          title: Text('Feed item ${index + 1}'),
                          subtitle: const Text(
                            'Manual gestures generate UserScrollNotification; '
                            'button-triggered programmatic jumps may not.',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Card(
                  margin: const EdgeInsets.only(top: 12, right: 12, bottom: 12),
                  color: Colors.white,
                  child: ListView(
                    padding: const EdgeInsets.all(10),
                    children: [
                      const Text('Notification Stream', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      for (final row in _events.reversed)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text('• $row', style: const TextStyle(fontSize: 12)),
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
}

class _NestedArenasPanel extends StatefulWidget {
  const _NestedArenasPanel();

  @override
  State<_NestedArenasPanel> createState() => _NestedArenasPanelState();
}

class _NestedArenasPanelState extends State<_NestedArenasPanel> {
  final ScrollController _outer = ScrollController();
  final ScrollController _inner = ScrollController();
  final List<String> _depthLog = ['Nested arena armed'];

  @override
  void dispose() {
    _outer.dispose();
    _inner.dispose();
    super.dispose();
  }

  bool _capture(String lane, UserScrollNotification n) {
    setState(() {
      _depthLog.add(
        '$lane -> direction=${n.direction.name} depth=${n.depth} '
        'pixels=${n.metrics.pixels.toStringAsFixed(1)}',
      );
      if (_depthLog.length > 30) {
        _depthLog.removeAt(0);
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: NotificationListener<UserScrollNotification>(
            onNotification: (n) => _capture('outer-listener', n),
            child: ListView(
              controller: _outer,
              padding: const EdgeInsets.all(12),
              children: [
                const _HeadingCard(
                  title: 'Nested listener probe',
                  body:
                      'The inner horizontal list has its own listener. Compare depth '
                      'signals when scrolling outer versus inner areas.',
                ),
                const SizedBox(height: 10),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFC7D2FE)),
                  ),
                  child: NotificationListener<UserScrollNotification>(
                    onNotification: (n) => _capture('inner-listener', n),
                    child: ListView.builder(
                      controller: _inner,
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 180,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFBFDBFE)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Inner tile ${index + 1}', style: const TextStyle(fontWeight: FontWeight.w700)),
                              const SizedBox(height: 6),
                              const Text('Scroll horizontally here to inspect depth behavior.'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                for (var i = 0; i < 24; i++)
                  Card(
                    color: i.isEven ? Colors.white : const Color(0xFFF1F5F9),
                    child: ListTile(
                      title: Text('Outer item ${i + 1}'),
                      subtitle: const Text('Vertical outer scrolling emits notifications through outer lane.'),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Card(
            margin: const EdgeInsets.all(12),
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const Text('Depth & Lane Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final entry in _depthLog.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $entry', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaybookPanel extends StatelessWidget {
  const _PlaybookPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _BulletCard(
          title: 'Implementation checklist',
          tint: Color(0xFF1E3A8A),
          bullets: [
            'Use NotificationListener<UserScrollNotification> near relevant scroll nodes.',
            'Filter by notification.depth == 0 for immediate child behavior.',
            'Track direction transitions, not only absolute position deltas.',
            'Combine with ScrollController for richer diagnostics and replay.',
          ],
        ),
        _BulletCard(
          title: 'Pitfalls to avoid',
          tint: Color(0xFFB91C1C),
          bullets: [
            'Assuming programmatic animateTo always emits user scroll notifications.',
            'Treating reverse/forward as always equal to up/down across axis reversals.',
            'Ignoring nested depth can produce duplicated behavior triggers.',
            'Heavy work inside notification callback can degrade scroll smoothness.',
          ],
        ),
        _BulletCard(
          title: 'Accessibility and UX notes',
          tint: Color(0xFF0F766E),
          bullets: [
            'Direction-driven chrome transitions should remain predictable.',
            'Do not hide critical controls instantly without recovery paths.',
            'Pair movement-based reactions with explicit user controls.',
            'Provide non-gesture alternatives for key navigation actions.',
          ],
        ),
      ],
    );
  }
}

class _HeadingCard extends StatelessWidget {
  const _HeadingCard({required this.title, required this.body});

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
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _BulletCard extends StatelessWidget {
  const _BulletCard({required this.title, required this.tint, required this.bullets});

  final String title;
  final Color tint;
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: tint, fontSize: 16)),
              const SizedBox(height: 8),
              for (final item in bullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $item'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
