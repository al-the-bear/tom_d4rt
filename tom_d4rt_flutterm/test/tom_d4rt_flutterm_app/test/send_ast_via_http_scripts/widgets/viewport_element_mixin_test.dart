import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _ViewportElementMixinDeepDemo();
}

const Color _kFrame = Color(0xFF0F172A);
const Color _kBg = Color(0xFFF8FAFC);

class _ViewportElementMixinDeepDemo extends StatefulWidget {
  const _ViewportElementMixinDeepDemo();

  @override
  State<_ViewportElementMixinDeepDemo> createState() =>
      _ViewportElementMixinDeepDemoState();
}

class _ViewportElementMixinDeepDemoState extends State<_ViewportElementMixinDeepDemo>
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
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kFrame,
        foregroundColor: Colors.white,
        title: const Text('ViewportElementMixin Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Concept Deck'),
            Tab(text: 'Propagation Lab'),
            Tab(text: 'Layer Toggle'),
            Tab(text: 'Debug Notes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ConceptDeckPanel(),
          _PropagationLabPanel(),
          _LayerTogglePanel(),
          _DebugNotesPanel(),
        ],
      ),
    );
  }
}

class _ConceptDeckPanel extends StatelessWidget {
  const _ConceptDeckPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _DeckCard(
          title: 'Why ViewportElementMixin Exists',
          body:
              'ViewportElementMixin participates in notification bubbling and '
              'increments depth for viewport-aware notifications. This enables '
              'listeners to understand how many viewport boundaries were crossed.',
        ),
        SizedBox(height: 10),
        _ListCard(
          title: 'Core responsibilities',
          accent: Color(0xFF1D4ED8),
          lines: [
            'Intercept notifications during element-level bubbling.',
            'Detect viewport-aware notification type.',
            'Increment depth before forwarding to ancestors.',
            'Preserve normal Notification propagation semantics.',
          ],
        ),
        _ListCard(
          title: 'Why depth matters',
          accent: Color(0xFF166534),
          lines: [
            'Differentiate immediate child scroll from nested descendants.',
            'Prevent duplicate reactions in complex nested scroll layouts.',
            'Tune interactions by source hierarchy instead of only type.',
            'Support deterministic event routing in large UI trees.',
          ],
        ),
        _ListCard(
          title: 'Internal pairing',
          accent: Color(0xFF9A3412),
          lines: [
            'ViewportNotificationMixin stores depth counter.',
            'ViewportElementMixin increments that depth on traversal.',
            'NotificationListener filters using the final depth value.',
            'Together they build viewport-aware bubbling context.',
          ],
        ),
      ],
    );
  }
}

class _PropagationLabPanel extends StatefulWidget {
  const _PropagationLabPanel();

  @override
  State<_PropagationLabPanel> createState() => _PropagationLabPanelState();
}

class _PropagationLabPanelState extends State<_PropagationLabPanel> {
  final GlobalKey _dispatchZone = GlobalKey();
  final List<String> _journal = ['Propagation lab ready'];
  int _sequence = 0;

  void _emit() {
    final context = _dispatchZone.currentContext;
    if (context == null) {
      return;
    }
    _sequence += 1;
    final notification = _DepthProbeNotification(label: 'Probe #$_sequence');
    notification.dispatch(context);
  }

  void _record(String lane, _DepthProbeNotification n) {
    setState(() {
      _journal.add('$lane saw ${n.label} at depth=${n.depth}');
      if (_journal.length > 24) {
        _journal.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        FilledButton(onPressed: _emit, child: const Text('Dispatch Probe Notification')),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () => setState(() {
                            _journal
                              ..clear()
                              ..add('Journal reset');
                          }),
                          child: const Text('Clear Journal'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: _ViewportLayer(
                    name: 'Viewport-A',
                    color: const Color(0xFFDBEAFE),
                    onSeen: _record,
                    child: _ViewportLayer(
                      name: 'Viewport-B',
                      color: const Color(0xFFE0E7FF),
                      onSeen: _record,
                      child: _ViewportLayer(
                        name: 'Viewport-C',
                        color: const Color(0xFFF5D0FE),
                        onSeen: _record,
                        child: Container(
                          key: _dispatchZone,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFCBD5E1)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Dispatch zone\n(analog to source element)',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w700),
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
        Expanded(
          flex: 4,
          child: Card(
            margin: const EdgeInsets.all(12),
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const Text('Propagation Journal', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final row in _journal.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $row'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LayerTogglePanel extends StatefulWidget {
  const _LayerTogglePanel();

  @override
  State<_LayerTogglePanel> createState() => _LayerTogglePanelState();
}

class _LayerTogglePanelState extends State<_LayerTogglePanel> {
  bool _includeMiddle = true;
  int _lastDepth = -1;
  String _lastPath = 'No dispatch yet';
  final GlobalKey _source = GlobalKey();

  void _dispatch() {
    final context = _source.currentContext;
    if (context == null) {
      return;
    }
    final n = _DepthProbeNotification(label: 'Toggle-run');
    n.dispatch(context);
    setState(() {
      _lastDepth = n.depth;
      _lastPath = _includeMiddle
          ? 'Top -> Middle -> Bottom'
          : 'Top -> Bottom';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget chain = _ViewportLayer(
      name: 'Bottom',
      color: const Color(0xFFD1FAE5),
      onSeen: (_, notification) {},
      child: Container(
        key: _source,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFA7F3D0)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(14),
          child: Text('Event source', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ),
    );

    if (_includeMiddle) {
      chain = _ViewportLayer(
        name: 'Middle',
        color: const Color(0xFFFEF3C7),
        onSeen: (_, notification) {},
        child: chain,
      );
    }

    chain = _ViewportLayer(
      name: 'Top',
      color: const Color(0xFFE0F2FE),
      onSeen: (_, notification) {},
      child: chain,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Text('Include middle viewport layer'),
                  const SizedBox(width: 8),
                  Switch(
                    value: _includeMiddle,
                    onChanged: (v) => setState(() => _includeMiddle = v),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(onPressed: _dispatch, child: const Text('Dispatch')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(child: chain),
          const SizedBox(height: 12),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Last path: $_lastPath'),
                  Text('Last resulting depth: $_lastDepth'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DebugNotesPanel extends StatelessWidget {
  const _DebugNotesPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _ListCard(
          title: 'Debug checklist for nested viewport notifications',
          accent: Color(0xFF0F766E),
          lines: [
            'Log both notification.runtimeType and depth near top-level listeners.',
            'Confirm expected viewport boundaries exist in actual widget hierarchy.',
            'Be explicit about whether depth==0 or depth>0 behavior is desired.',
            'Use synthetic notification labs to verify routing assumptions.',
          ],
        ),
        _ListCard(
          title: 'Regression signals',
          accent: Color(0xFFB91C1C),
          lines: [
            'Header collapsing twice per gesture often indicates depth filtering bugs.',
            'Parent and child listeners firing identical logic can signal overreach.',
            'Scroll effects bound to wrong depth cause flicker in nested layouts.',
            'Missing depth increments imply viewport layer interception is absent.',
          ],
        ),
      ],
    );
  }
}

class _ViewportLayer extends StatelessWidget {
  const _ViewportLayer({
    required this.name,
    required this.color,
    required this.onSeen,
    required this.child,
  });

  final String name;
  final Color color;
  final void Function(String lane, _DepthProbeNotification notification) onSeen;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<_DepthProbeNotification>(
      onNotification: (n) {
        n.depth += 1;
        onSeen(name, n);
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
              child: Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _DepthProbeNotification extends Notification {
  _DepthProbeNotification({required this.label});

  final String label;
  int depth = 0;
}

class _DeckCard extends StatelessWidget {
  const _DeckCard({required this.title, required this.body});

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

class _ListCard extends StatelessWidget {
  const _ListCard({required this.title, required this.accent, required this.lines});

  final String title;
  final Color accent;
  final List<String> lines;

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
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: accent, fontSize: 16)),
              const SizedBox(height: 8),
              for (final line in lines)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $line'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
