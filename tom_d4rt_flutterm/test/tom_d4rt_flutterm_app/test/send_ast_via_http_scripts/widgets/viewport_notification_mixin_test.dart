import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _ViewportNotificationMixinDeepDemo();
}

const Color _kBar = Color(0xFF111827);
const Color _kCanvas = Color(0xFFF8FAFC);

class _ViewportNotificationMixinDeepDemo extends StatefulWidget {
  const _ViewportNotificationMixinDeepDemo();

  @override
  State<_ViewportNotificationMixinDeepDemo> createState() =>
      _ViewportNotificationMixinDeepDemoState();
}

class _ViewportNotificationMixinDeepDemoState
    extends State<_ViewportNotificationMixinDeepDemo>
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
      backgroundColor: _kCanvas,
      appBar: AppBar(
        backgroundColor: _kBar,
        foregroundColor: Colors.white,
        title: const Text('ViewportNotificationMixin Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Depth Primer'),
            Tab(text: 'Real Scroll Depth'),
            Tab(text: 'Synthetic Routing'),
            Tab(text: 'Filter Recipes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _DepthPrimerPanel(),
          _RealScrollDepthPanel(),
          _SyntheticRoutingPanel(),
          _FilterRecipesPanel(),
        ],
      ),
    );
  }
}

class _DepthPrimerPanel extends StatelessWidget {
  const _DepthPrimerPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _InfoCard(
          title: 'ViewportNotificationMixin at a glance',
          body:
              'ViewportNotificationMixin contributes a depth counter to viewport '
              'related notifications (for example scroll notifications). As the '
              'notification traverses viewport elements, depth increments.',
        ),
        SizedBox(height: 10),
        _BulletInfo(
          title: 'Depth interpretation',
          accent: Color(0xFF1D4ED8),
          bullets: [
            'depth == 0: notification from immediate descendant viewport.',
            'depth == 1: one additional viewport boundary crossed.',
            'depth >= 2: deeply nested viewport source.',
            'Depth is ideal for filtering nested scroll side effects.',
          ],
        ),
        _BulletInfo(
          title: 'What increments depth',
          accent: Color(0xFF166534),
          bullets: [
            'Viewport-related elements intercept bubbling notifications.',
            'Each viewport layer increments notification depth.',
            'Listeners above the source receive the accumulated value.',
            'This avoids ambiguity in nested scrolling interfaces.',
          ],
        ),
        _BulletInfo(
          title: 'Typical usage',
          accent: Color(0xFF9A3412),
          bullets: [
            'Ignore nested scroll notifications for top app bar animation.',
            'Run expensive logic only for depth 0 sources.',
            'Debug event routing in mixed horizontal/vertical scroll layouts.',
            'Pair with runtimeType checks for precise handling.',
          ],
        ),
      ],
    );
  }
}

class _RealScrollDepthPanel extends StatefulWidget {
  const _RealScrollDepthPanel();

  @override
  State<_RealScrollDepthPanel> createState() => _RealScrollDepthPanelState();
}

class _RealScrollDepthPanelState extends State<_RealScrollDepthPanel> {
  final ScrollController _outer = ScrollController();
  final ScrollController _inner = ScrollController();
  final List<String> _log = ['Depth monitor online'];
  int _depth0Count = 0;
  int _nestedCount = 0;

  @override
  void dispose() {
    _outer.dispose();
    _inner.dispose();
    super.dispose();
  }

  bool _onScroll(ScrollNotification n) {
    setState(() {
      if (n.depth == 0) {
        _depth0Count += 1;
      } else {
        _nestedCount += 1;
      }
      _log.add(
        '${n.runtimeType} depth=${n.depth} '
        'px=${n.metrics.pixels.toStringAsFixed(1)}',
      );
      if (_log.length > 30) {
        _log.removeAt(0);
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
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: ListView(
              controller: _outer,
              padding: const EdgeInsets.all(12),
              children: [
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton(
                          onPressed: () => setState(() {
                            _depth0Count = 0;
                            _nestedCount = 0;
                            _log
                              ..clear()
                              ..add('Depth monitor reset');
                          }),
                          child: const Text('Reset Metrics'),
                        ),
                        OutlinedButton(
                          onPressed: () => _outer.animateTo(
                            0,
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.easeOut,
                          ),
                          child: const Text('Outer Top'),
                        ),
                        OutlinedButton(
                          onPressed: () => _inner.animateTo(
                            0,
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.easeOut,
                          ),
                          child: const Text('Inner Top'),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: const Color(0xFFE0F2FE),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'depth==0 events: $_depth0Count | '
                      'depth>0 events: $_nestedCount',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFC7D2FE)),
                  ),
                  child: ListView.builder(
                    controller: _inner,
                    scrollDirection: Axis.horizontal,
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
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
                            Text('Inner viewport ${index + 1}', style: const TextStyle(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 6),
                            const Text('Horizontal nested viewport section'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                for (var i = 0; i < 22; i++)
                  Card(
                    color: i.isEven ? Colors.white : const Color(0xFFF1F5F9),
                    child: ListTile(
                      title: Text('Outer row ${i + 1}'),
                      subtitle: const Text('Scroll outer area to emit depth=0 notifications.'),
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
                const Text('Scroll Notification Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final entry in _log.reversed)
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

class _SyntheticRoutingPanel extends StatefulWidget {
  const _SyntheticRoutingPanel();

  @override
  State<_SyntheticRoutingPanel> createState() => _SyntheticRoutingPanelState();
}

class _SyntheticRoutingPanelState extends State<_SyntheticRoutingPanel> {
  final GlobalKey _source = GlobalKey();
  final List<String> _events = ['Synthetic routing initialized'];
  bool _enableLayer2 = true;

  void _dispatch() {
    final context = _source.currentContext;
    if (context == null) {
      return;
    }
    final n = _SyntheticViewportNotification('Synthetic #${_events.length}');
    n.dispatch(context);
    setState(() {
      _events.add('Dispatched ${n.name}; resulting depth=${n.depth}');
      if (_events.length > 24) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget chain = _SyntheticLayer(
      label: 'Layer 1',
      color: const Color(0xFFE0F2FE),
      child: Container(
        key: _source,
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFBAE6FD)),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Text('Synthetic source', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ),
    );

    if (_enableLayer2) {
      chain = _SyntheticLayer(
        label: 'Layer 2',
        color: const Color(0xFFFEF3C7),
        child: chain,
      );
    }

    chain = _SyntheticLayer(
      label: 'Layer 3',
      color: const Color(0xFFEDE9FE),
      child: chain,
    );

    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text('Enable Layer 2'),
                        const SizedBox(width: 8),
                        Switch(
                          value: _enableLayer2,
                          onChanged: (v) => setState(() => _enableLayer2 = v),
                        ),
                        const SizedBox(width: 10),
                        FilledButton(onPressed: _dispatch, child: const Text('Dispatch Synthetic Event')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(child: chain),
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
                const Text('Synthetic Event Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _events.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $line'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterRecipesPanel extends StatelessWidget {
  const _FilterRecipesPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _BulletInfo(
          title: 'Filtering recipes',
          accent: Color(0xFF0F766E),
          bullets: [
            'Recipe A: if (notification.depth == 0) handle primary viewport only.',
            'Recipe B: if (notification.depth > 0) gather nested telemetry only.',
            'Recipe C: combine depth with runtimeType for precise branching.',
            'Recipe D: short-circuit on depth mismatch to reduce callback work.',
          ],
        ),
        _BulletInfo(
          title: 'Failure signatures',
          accent: Color(0xFFB91C1C),
          bullets: [
            'Top-level effects triggering while inner list scrolls.',
            'Double-animations caused by handling both depth 0 and depth 1.',
            'Incorrect assumptions that all scroll events should be global.',
            'UI jitter due to expensive handlers on all nested depths.',
          ],
        ),
      ],
    );
  }
}

class _SyntheticLayer extends StatelessWidget {
  const _SyntheticLayer({
    required this.label,
    required this.color,
    required this.child,
  });

  final String label;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<_SyntheticViewportNotification>(
      onNotification: (n) {
        n.depth += 1;
        return false;
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF94A3B8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _SyntheticViewportNotification extends Notification {
  _SyntheticViewportNotification(this.name);

  final String name;
  int depth = 0;
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

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

class _BulletInfo extends StatelessWidget {
  const _BulletInfo({required this.title, required this.accent, required this.bullets});

  final String title;
  final Color accent;
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
              Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 8),
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
