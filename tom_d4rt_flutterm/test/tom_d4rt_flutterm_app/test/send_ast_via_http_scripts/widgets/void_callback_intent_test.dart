import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _VoidCallbackIntentDeepDemo();
}

const Color _kShell = Color(0xFF111827);
const Color _kPage = Color(0xFFF8FAFC);

class _VoidCallbackIntentDeepDemo extends StatefulWidget {
  const _VoidCallbackIntentDeepDemo();

  @override
  State<_VoidCallbackIntentDeepDemo> createState() =>
      _VoidCallbackIntentDeepDemoState();
}

class _VoidCallbackIntentDeepDemoState extends State<_VoidCallbackIntentDeepDemo>
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
      backgroundColor: _kPage,
      appBar: AppBar(
        backgroundColor: _kShell,
        foregroundColor: Colors.white,
        title: const Text('VoidCallbackIntent Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Intent Primer'),
            Tab(text: 'Payload Workshop'),
            Tab(text: 'Action Routing'),
            Tab(text: 'Intent Gallery'),
            Tab(text: 'Usage Guide'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _IntentPrimerPanel(),
          _PayloadWorkshopPanel(),
          _ActionRoutingPanel(),
          _IntentGalleryPanel(),
          _UsageGuidePanel(),
        ],
      ),
    );
  }
}

class _IntentPrimerPanel extends StatelessWidget {
  const _IntentPrimerPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _IntroCard(
          title: 'Intent as callback carrier',
          body:
              'VoidCallbackIntent stores executable behavior as data. The action '
              'layer can stay generic while each interaction supplies unique work '
              'through a per-instance callback closure.',
        ),
        SizedBox(height: 10),
        _PointCard(
          title: 'Anatomy',
          accent: Color(0xFF1D4ED8),
          points: [
            'Class type: Intent subclass.',
            'Payload: final VoidCallback callback.',
            'Semantics: command intent with executable closure payload.',
            'Execution partner: usually VoidCallbackAction.',
          ],
        ),
        _PointCard(
          title: 'Strengths',
          accent: Color(0xFF166534),
          points: [
            'Very low boilerplate for command dispatch.',
            'Behavior can be assembled from current UI state.',
            'Good fit for temporary context-specific actions.',
            'Natural bridge between UI events and command bus.',
          ],
        ),
        _PointCard(
          title: 'Cautions',
          accent: Color(0xFFB91C1C),
          points: [
            'Avoid large closures that hide business logic complexity.',
            'Be careful with stale captures in async flows.',
            'Prefer explicit intent classes for rich typed payloads.',
            'Keep callbacks side-effect scoped and observable.',
          ],
        ),
      ],
    );
  }
}

class _PayloadWorkshopPanel extends StatefulWidget {
  const _PayloadWorkshopPanel();

  @override
  State<_PayloadWorkshopPanel> createState() => _PayloadWorkshopPanelState();
}

class _PayloadWorkshopPanelState extends State<_PayloadWorkshopPanel> {
  final TextEditingController _commandName =
      TextEditingController(text: 'Warm cache');
  final TextEditingController _deltaInput = TextEditingController(text: '2');
  final List<String> _feed = ['Workshop initialized'];

  int _score = 0;
  bool _flag = false;
  Color _tone = const Color(0xFFDBEAFE);

  @override
  void dispose() {
    _commandName.dispose();
    _deltaInput.dispose();
    super.dispose();
  }

  void _append(String message) {
    setState(() {
      _feed.add(message);
      if (_feed.length > 28) {
        _feed.removeAt(0);
      }
    });
  }

  VoidCallbackIntent _makePayloadIntent() {
    final raw = int.tryParse(_deltaInput.text.trim()) ?? 1;
    final name = _commandName.text.trim().isEmpty
        ? 'Unnamed command'
        : _commandName.text.trim();

    return VoidCallbackIntent(() {
      setState(() {
        _score += raw;
        _flag = !_flag;
        _tone = _tone == const Color(0xFFDBEAFE)
            ? const Color(0xFFD1FAE5)
            : const Color(0xFFDBEAFE);
      });
      _append('Intent "$name" executed with delta=$raw');
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
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Intent Payload Builder', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _commandName,
                          decoration: const InputDecoration(
                            labelText: 'Command label',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _deltaInput,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Score delta',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FilledButton(
                              onPressed: () {
                                Actions.invoke(context, _makePayloadIntent());
                              },
                              child: const Text('Dispatch Intent'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _score = 0;
                                  _flag = false;
                                  _tone = const Color(0xFFDBEAFE);
                                  _feed
                                    ..clear()
                                    ..add('Workshop reset');
                                });
                              },
                              child: const Text('Reset State'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  color: _tone,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Live Visual State', style: TextStyle(fontWeight: FontWeight.w800)),
                        const SizedBox(height: 8),
                        Text('Score: $_score'),
                        Text('Toggle flag: $_flag'),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(value: (_score.abs() % 20) / 20),
                        const SizedBox(height: 6),
                        Text('Pulse: ${(_score.abs() % 20) * 5}%'),
                      ],
                    ),
                  ),
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
                  const Text('Payload Feed', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  for (final e in _feed.reversed)
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
    );
  }
}

class _ActionRoutingPanel extends StatefulWidget {
  const _ActionRoutingPanel();

  @override
  State<_ActionRoutingPanel> createState() => _ActionRoutingPanelState();
}

class _ActionRoutingPanelState extends State<_ActionRoutingPanel> {
  final List<String> _events = ['Routing panel online'];
  final List<_RouteLane> _lanes = [
    _RouteLane(name: 'Toolbar lane', color: Color(0xFFEFF6FF)),
    _RouteLane(name: 'Menu lane', color: Color(0xFFF0FDF4)),
    _RouteLane(name: 'Context lane', color: Color(0xFFFEFCE8)),
  ];

  void _dispatchLane(_RouteLane lane) {
    final intent = VoidCallbackIntent(() {
      setState(() {
        lane.count += 1;
        lane.active = !lane.active;
        _events.add('${lane.name} dispatched callback #${lane.count}');
        if (_events.length > 26) {
          _events.removeAt(0);
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
          flex: 6,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _lanes.length,
            itemBuilder: (context, index) {
              final lane = _lanes[index];
              return Card(
                color: lane.color,
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lane.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      const SizedBox(height: 6),
                      Text('Dispatch count: ${lane.count}'),
                      Text('Active: ${lane.active}'),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: () => _dispatchLane(lane),
                        child: const Text('Emit VoidCallbackIntent'),
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
                const Text('Routing Timeline', style: TextStyle(fontWeight: FontWeight.w800)),
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

class _IntentGalleryPanel extends StatefulWidget {
  const _IntentGalleryPanel();

  @override
  State<_IntentGalleryPanel> createState() => _IntentGalleryPanelState();
}

class _IntentGalleryPanelState extends State<_IntentGalleryPanel> {
  final List<_IntentTileData> _tiles = [
    _IntentTileData('Open diagnostics', Color(0xFFDBEAFE)),
    _IntentTileData('Toggle telemetry', Color(0xFFD1FAE5)),
    _IntentTileData('Sync script cache', Color(0xFFEDE9FE)),
    _IntentTileData('Rebuild inspector tree', Color(0xFFFEF3C7)),
    _IntentTileData('Capture screenshot', Color(0xFFFCE7F3)),
    _IntentTileData('Clear overlays', Color(0xFFE2E8F0)),
  ];

  final List<String> _journal = ['Intent gallery active'];

  void _activate(_IntentTileData tile) {
    final intent = VoidCallbackIntent(() {
      setState(() {
        tile.runs += 1;
        tile.enabled = !tile.enabled;
        _journal.add('${tile.label} callback run #${tile.runs}');
        if (_journal.length > 30) {
          _journal.removeAt(0);
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
            itemCount: _tiles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.45,
            ),
            itemBuilder: (context, index) {
              final tile = _tiles[index];
              return Card(
                color: tile.color,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tile.label, style: const TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      Text('Enabled: ${tile.enabled}'),
                      Text('Runs: ${tile.runs}'),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () => _activate(tile),
                              child: const Text('Dispatch Intent'),
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
                const Text('Gallery Journal', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _journal.reversed)
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

class _UsageGuidePanel extends StatelessWidget {
  const _UsageGuidePanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _PointCard(
          title: 'How to use effectively',
          accent: Color(0xFF0F766E),
          points: [
            'Create callback closures close to the interaction origin.',
            'Keep callback body concise and delegate to domain services.',
            'Route through Actions for consistent command infrastructure.',
            'Record minimal telemetry for command debugging.',
          ],
        ),
        _PointCard(
          title: 'Choosing between intent styles',
          accent: Color(0xFF7C3AED),
          points: [
            'Use VoidCallbackIntent for lightweight, local command payloads.',
            'Use typed intent classes when payload has structured fields.',
            'Use dedicated actions for globally standardized behaviors.',
            'Mix approaches: generic local commands + typed global commands.',
          ],
        ),
        _PointCard(
          title: 'Interpreter-focused test guidance',
          accent: Color(0xFFB91C1C),
          points: [
            'Prefer visible state mutation after callback dispatch.',
            'Use logs/timelines to prove callback route was executed.',
            'Exercise multiple dispatch surfaces (buttons, menus, shortcuts).',
            'Avoid heavy assert-only tests for these bridge demonstrations.',
          ],
        ),
      ],
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.title, required this.body});

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

class _PointCard extends StatelessWidget {
  const _PointCard({required this.title, required this.accent, required this.points});

  final String title;
  final Color accent;
  final List<String> points;

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
              for (final point in points)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $point'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RouteLane {
  _RouteLane({required this.name, required this.color});

  final String name;
  final Color color;
  int count = 0;
  bool active = false;
}

class _IntentTileData {
  _IntentTileData(this.label, this.color);

  final String label;
  final Color color;
  int runs = 0;
  bool enabled = false;
}
