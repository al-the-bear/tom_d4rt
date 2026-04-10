import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show LogicalKeyboardKey;

dynamic build(BuildContext context) {
  return const _VoidCallbackActionDeepDemo();
}

const Color _kBg = Color(0xFFF8FAFC);
const Color _kInk = Color(0xFF0F172A);

class _VoidCallbackActionDeepDemo extends StatefulWidget {
  const _VoidCallbackActionDeepDemo();

  @override
  State<_VoidCallbackActionDeepDemo> createState() =>
      _VoidCallbackActionDeepDemoState();
}

class _VoidCallbackActionDeepDemoState extends State<_VoidCallbackActionDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 5, vsync: this);
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
        backgroundColor: _kInk,
        foregroundColor: Colors.white,
        title: const Text('VoidCallbackAction Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Concept Atlas'),
            Tab(text: 'Dispatch Lab'),
            Tab(text: 'Shortcut Bridge'),
            Tab(text: 'Choreography Board'),
            Tab(text: 'Playbook'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ConceptAtlasPanel(),
          _DispatchLabPanel(),
          _ShortcutBridgePanel(),
          _ChoreographyBoardPanel(),
          _PlaybookPanel(),
        ],
      ),
    );
  }
}

class _ConceptAtlasPanel extends StatelessWidget {
  const _ConceptAtlasPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _HeroCard(
          title: 'What VoidCallbackAction does',
          body:
              'VoidCallbackAction is an Action specialized for VoidCallbackIntent. '
              'It simply executes the callback supplied by the intent, making the '
              'intent itself the carrier of behavior.',
        ),
        SizedBox(height: 10),
        _BulletCard(
          title: 'Core semantics',
          accent: Color(0xFF1D4ED8),
          bullets: [
            'Action type: Action<VoidCallbackIntent>.',
            'Execution: invoke(intent) calls intent.callback().',
            'Behavior source: varies per intent instance.',
            'Useful for lightweight command dispatch from multiple surfaces.',
          ],
        ),
        _BulletCard(
          title: 'Why this matters in interpreters',
          accent: Color(0xFF166534),
          bullets: [
            'Quickly binds runtime commands without defining many action classes.',
            'Supports dynamic callbacks generated from current UI state.',
            'Pairs naturally with Shortcuts and Actions widgets.',
            'Makes behavior easy to inspect through logs and side effects.',
          ],
        ),
        _BulletCard(
          title: 'Typical usage contexts',
          accent: Color(0xFF9A3412),
          bullets: [
            'Toolbar actions that share one action type but differ behavior.',
            'Keyboard shortcuts mapped to local command closures.',
            'Temporary command overlays and quick palettes.',
            'Testing command routing in bridge/interpreter scenarios.',
          ],
        ),
      ],
    );
  }
}

class _DispatchLabPanel extends StatefulWidget {
  const _DispatchLabPanel();

  @override
  State<_DispatchLabPanel> createState() => _DispatchLabPanelState();
}

class _DispatchLabPanelState extends State<_DispatchLabPanel> {
  final List<String> _logs = ['Dispatch lab armed'];
  int _counter = 0;
  bool _toggle = false;
  double _progress = 0.2;
  Color _panel = const Color(0xFFDBEAFE);

  void _track(String line) {
    setState(() {
      _logs.add(line);
      if (_logs.length > 24) {
        _logs.removeAt(0);
      }
    });
  }

  VoidCallbackIntent _makeIntent(String label, VoidCallback callback) {
    return VoidCallbackIntent(() {
      callback();
      _track(label);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        VoidCallbackIntent: VoidCallbackAction(),
      },
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: ListView(
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
                          onPressed: () {
                            Actions.invoke(
                              context,
                              _makeIntent('Counter increment callback executed', () {
                                _counter += 1;
                              }),
                            );
                          },
                          child: const Text('Increment Counter'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            Actions.invoke(
                              context,
                              _makeIntent('Toggle callback executed', () {
                                _toggle = !_toggle;
                              }),
                            );
                          },
                          child: const Text('Toggle Flag'),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Actions.invoke(
                              context,
                              _makeIntent('Progress callback executed', () {
                                _progress += 0.15;
                                if (_progress > 1) {
                                  _progress = 0;
                                }
                              }),
                            );
                          },
                          child: const Text('Step Progress'),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Actions.invoke(
                              context,
                              _makeIntent('Palette callback executed', () {
                                _panel = _panel == const Color(0xFFDBEAFE)
                                    ? const Color(0xFFD1FAE5)
                                    : const Color(0xFFDBEAFE);
                              }),
                            );
                          },
                          child: const Text('Swap Palette'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  color: _panel,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Live Command State', style: TextStyle(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Text('Counter: $_counter'),
                        Text('Toggle: $_toggle'),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(value: _progress),
                        const SizedBox(height: 6),
                        Text('Progress: ${(_progress * 100).toStringAsFixed(0)}%'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const _InfoStrip(
                  title: 'Observation',
                  content:
                      'Each button builds a unique VoidCallbackIntent and routes it '
                      'through the same VoidCallbackAction instance.',
                ),
              ],
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
                  const Text('Execution Log', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  for (final row in _logs.reversed)
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
    );
  }
}

class _ShortcutBridgePanel extends StatefulWidget {
  const _ShortcutBridgePanel();

  @override
  State<_ShortcutBridgePanel> createState() => _ShortcutBridgePanelState();
}

class _ShortcutBridgePanelState extends State<_ShortcutBridgePanel> {
  final List<String> _events = ['Focus the pad and use key chords'];
  int _hotCounter = 0;
  String _mode = 'idle';

  void _push(String s) {
    setState(() {
      _events.add(s);
      if (_events.length > 26) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.keyI, control: true):
            VoidCallbackIntent(() {
              setState(() {
                _hotCounter += 1;
                _mode = 'ctrl+i';
              });
              _push('Shortcut Ctrl+I executed via VoidCallbackAction');
            }),
        const SingleActivator(LogicalKeyboardKey.keyR, control: true):
            VoidCallbackIntent(() {
              setState(() {
                _hotCounter = 0;
                _mode = 'reset';
              });
              _push('Shortcut Ctrl+R executed via VoidCallbackAction');
            }),
        const SingleActivator(LogicalKeyboardKey.space):
            VoidCallbackIntent(() {
              setState(() {
                _mode = 'space-pulse';
              });
              _push('Space shortcut executed via VoidCallbackAction');
            }),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          VoidCallbackIntent: VoidCallbackAction(),
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Focus(
                  autofocus: true,
                  child: Card(
                    color: const Color(0xFFEFF6FF),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Keyboard Command Pad', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                          const SizedBox(height: 8),
                          const Text('Try Ctrl+I, Ctrl+R, and Space while this panel has focus.'),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              Chip(label: Text('hotCounter: $_hotCounter')),
                              Chip(label: Text('mode: $_mode')),
                            ],
                          ),
                          const SizedBox(height: 14),
                          LinearProgressIndicator(
                            value: (_hotCounter % 10) / 10,
                            minHeight: 10,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Progress pulse: ${(_hotCounter % 10) * 10}%',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Card(
                  margin: const EdgeInsets.only(left: 12),
                  color: Colors.white,
                  child: ListView(
                    padding: const EdgeInsets.all(10),
                    children: [
                      const Text('Shortcut Event Log', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      for (final e in _events.reversed)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text('• $e', style: const TextStyle(fontSize: 12)),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChoreographyBoardPanel extends StatefulWidget {
  const _ChoreographyBoardPanel();

  @override
  State<_ChoreographyBoardPanel> createState() => _ChoreographyBoardPanelState();
}

class _ChoreographyBoardPanelState extends State<_ChoreographyBoardPanel> {
  final List<_CommandNode> _nodes = [
    _CommandNode(title: 'Refresh data', color: Color(0xFFDBEAFE)),
    _CommandNode(title: 'Toggle sidebar', color: Color(0xFFD1FAE5)),
    _CommandNode(title: 'Open command palette', color: Color(0xFFFEF3C7)),
    _CommandNode(title: 'Sync cloud state', color: Color(0xFFEDE9FE)),
    _CommandNode(title: 'Focus diagnostics', color: Color(0xFFFCE7F3)),
  ];

  final List<String> _story = ['Choreography board initialized'];

  void _runNode(int index) {
    final node = _nodes[index];
    final intent = VoidCallbackIntent(() {
      setState(() {
        node.count += 1;
        node.active = !node.active;
        _story.add('${node.title} executed #${node.count}');
        if (_story.length > 26) {
          _story.removeAt(0);
        }
      });
    });
    VoidCallbackAction().invoke(intent);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _nodes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.45,
            ),
            itemBuilder: (context, index) {
              final node = _nodes[index];
              return Card(
                color: node.color,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(node.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      const SizedBox(height: 6),
                      Text('Executed: ${node.count}'),
                      Text('Active: ${node.active}'),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () => _runNode(index),
                              child: const Text('Run Callback'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
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
                const Text('Command Story', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _story.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $line', style: const TextStyle(fontSize: 12)),
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
          title: 'Adoption checklist',
          accent: Color(0xFF0F766E),
          bullets: [
            'Register VoidCallbackAction once in an Actions map.',
            'Emit VoidCallbackIntent instances near interaction source.',
            'Keep callbacks short and delegate heavy work elsewhere.',
            'Add logging to track intent origin and effect chain.',
          ],
        ),
        _BulletCard(
          title: 'Common pitfalls',
          accent: Color(0xFFB91C1C),
          bullets: [
            'Capturing stale context/state inside long-lived callbacks.',
            'Packing too much business logic directly in intent callback.',
            'Overusing global shortcut maps without local focus boundaries.',
            'Forgetting to communicate side effects in UI feedback.',
          ],
        ),
        _BulletCard(
          title: 'When to choose a custom Action subclass instead',
          accent: Color(0xFF7C3AED),
          bullets: [
            'When behavior is stable and reused across many intent sources.',
            'When you need typed payloads beyond a plain callback closure.',
            'When enabling/disabling logic should live in Action.isEnabled.',
            'When command tracing and analytics need uniform instrumentation.',
          ],
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.title, required this.body});

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

class _InfoStrip extends StatelessWidget {
  const _InfoStrip({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF1F5F9),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(Icons.lightbulb_outline),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black87),
                  children: [
                    TextSpan(text: '$title: ', style: const TextStyle(fontWeight: FontWeight.w700)),
                    TextSpan(text: content),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletCard extends StatelessWidget {
  const _BulletCard({
    required this.title,
    required this.accent,
    required this.bullets,
  });

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

class _CommandNode {
  _CommandNode({required this.title, required this.color});

  final String title;
  final Color color;
  int count = 0;
  bool active = false;
}
