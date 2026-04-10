import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _TraversalEdgeBehaviorDeepDemo();
}

const Color _kPrimary = Color(0xFF37474F);
const Color _kAccent = Color(0xFFFFB74D);
const Color _kSurface = Color(0xFFECEFF1);
const Color _kPanel = Colors.white;

class _TraversalEdgeBehaviorDeepDemo extends StatefulWidget {
  const _TraversalEdgeBehaviorDeepDemo();

  @override
  State<_TraversalEdgeBehaviorDeepDemo> createState() =>
      _TraversalEdgeBehaviorDeepDemoState();
}

class _TraversalEdgeBehaviorDeepDemoState extends State<_TraversalEdgeBehaviorDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        title: const Text('TraversalEdgeBehavior Deep Demo'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          tabs: const [
            Tab(text: 'Edge Modes'),
            Tab(text: 'Boundary Lab'),
            Tab(text: 'Usage Playbooks'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _EdgeModesTab(),
          _BoundaryLabTab(),
          _UsagePlaybooksTab(),
        ],
      ),
    );
  }
}

class _EdgeModesTab extends StatelessWidget {
  const _EdgeModesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _IntroCard(
          title: 'Why Edge Behavior Matters',
          body:
              'When focus navigation reaches group boundaries, edge behavior '
              'decides whether focus wraps, escapes, or delegates to parent scope. '
              'This policy strongly impacts accessibility and keyboard UX.',
        ),
        SizedBox(height: 12),
        _ModeCard(
          mode: TraversalEdgeBehavior.closedLoop,
          description:
              'Wrap within the same group. Useful for modal dialogs and focus traps '
              'where keyboard users should stay inside a bounded interaction.',
          color: Color(0xFF1565C0),
        ),
        _ModeCard(
          mode: TraversalEdgeBehavior.parentScope,
          description:
              'Escalate to parent traversal scope. Useful in nested forms or '
              'sectioned layouts where inner groups are only local clusters.',
          color: Color(0xFF2E7D32),
        ),
        _ModeCard(
          mode: TraversalEdgeBehavior.leaveFlutterView,
          description:
              'Allow focus to leave the Flutter view when at edge. Useful in '
              'hybrid hosts where native controls are part of the same workflow.',
          color: Color(0xFF6A1B9A),
        ),
        SizedBox(height: 12),
        _ChecklistCard(
          lines: [
            'Pick one mode per container based on user task boundaries.',
            'Document edge-mode rationale for accessibility reviews.',
            'Avoid mixing contradictory modes at same hierarchy level.',
            'Test both forward and reverse navigation at boundaries.',
          ],
        ),
      ],
    );
  }
}

class _BoundaryLabTab extends StatefulWidget {
  const _BoundaryLabTab();

  @override
  State<_BoundaryLabTab> createState() => _BoundaryLabTabState();
}

class _BoundaryLabTabState extends State<_BoundaryLabTab> {
  static const int _count = 6;

  int _active = 0;
  TraversalEdgeBehavior _edgeBehavior = TraversalEdgeBehavior.closedLoop;
  bool _reverse = false;
  final List<String> _events = ['Boundary lab initialized'];

  void _append(String line) {
    setState(() {
      _events.add(line);
      if (_events.length > 30) {
        _events.removeAt(0);
      }
    });
  }

  void _step() {
    final dir = _reverse ? -1 : 1;
    final next = _resolveEdgeMove(
      current: _active,
      count: _count,
      direction: dir,
      behavior: _edgeBehavior,
    );
    setState(() => _active = next.index);
    _append('move(${_reverse ? 'backward' : 'forward'}) => ${next.message}');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Boundary Simulation',
          body:
              'Simulate repeated edge crossings in a linear focus group and '
              'inspect how each TraversalEdgeBehavior changes the outcome.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Policy controls', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                SegmentedButton<TraversalEdgeBehavior>(
                  segments: TraversalEdgeBehavior.values
                      .map(
                        (m) => ButtonSegment<TraversalEdgeBehavior>(
                          value: m,
                          label: Text(m.name),
                        ),
                      )
                      .toList(),
                  selected: {_edgeBehavior},
                  onSelectionChanged: (selection) {
                    setState(() => _edgeBehavior = selection.first);
                    _append('edge behavior switched to ${selection.first.name}');
                  },
                ),
                const SizedBox(height: 8),
                FilterChip(
                  label: const Text('reverse direction'),
                  selected: _reverse,
                  onSelected: (value) => setState(() => _reverse = value),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 84,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _count,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final active = index == _active;
                      return _FocusItem(index: index, active: active);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(onPressed: _step, child: const Text('Step Traversal')), 
                    OutlinedButton(
                      onPressed: () {
                        setState(() => _active = 0);
                        _append('reset active index to 0');
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Trace Log', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                for (final line in _events)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
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

class _UsagePlaybooksTab extends StatelessWidget {
  const _UsagePlaybooksTab();

  static const List<_Playbook> _playbooks = [
    _Playbook(
      title: 'Dialog focus trap',
      behavior: TraversalEdgeBehavior.closedLoop,
      bullets: [
        'Keep tab traversal inside the modal until dismissed.',
        'Pair with clear escape action and initial focus target.',
        'Prevents accidental focus loss to background routes.',
      ],
      color: Color(0xFF1565C0),
    ),
    _Playbook(
      title: 'Nested settings panes',
      behavior: TraversalEdgeBehavior.parentScope,
      bullets: [
        'Allow local groups but flow naturally between sections.',
        'Reduces cognitive load in long forms.',
        'Works well with reading-order traversal policies.',
      ],
      color: Color(0xFF2E7D32),
    ),
    _Playbook(
      title: 'Hybrid host app',
      behavior: TraversalEdgeBehavior.leaveFlutterView,
      bullets: [
        'Enable escape toward native controls around embedded Flutter.',
        'Coordinate focus semantics with platform host framework.',
        'Validate browser/desktop differences for edge transitions.',
      ],
      color: Color(0xFF6A1B9A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Playbook Library',
          body:
              'Edge behavior is a product-level choice. These playbooks provide '
              'practical defaults and risks to review before shipping keyboard UX.',
        ),
        const SizedBox(height: 12),
        for (final item in _playbooks)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              color: _kPanel,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: TextStyle(fontWeight: FontWeight.w700, color: item.color)),
                    const SizedBox(height: 6),
                    Text('Recommended behavior: ${item.behavior.name}'),
                    const SizedBox(height: 8),
                    for (final bullet in item.bullets)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text('• $bullet'),
                      ),
                  ],
                ),
              ),
            ),
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
      color: _kPanel,
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

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.mode,
    required this.description,
    required this.color,
  });

  final TraversalEdgeBehavior mode;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: _kPanel,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mode.name, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
              const SizedBox(height: 8),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChecklistCard extends StatelessWidget {
  const _ChecklistCard({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kPanel,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            for (final line in lines)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FocusItem extends StatelessWidget {
  const _FocusItem({required this.index, required this.active});

  final int index;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF455A64) : const Color(0xFFB0BEC5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '$index',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _MoveResult {
  const _MoveResult({required this.index, required this.message});

  final int index;
  final String message;
}

_MoveResult _resolveEdgeMove({
  required int current,
  required int count,
  required int direction,
  required TraversalEdgeBehavior behavior,
}) {
  final candidate = current + direction;
  if (candidate >= 0 && candidate < count) {
    return _MoveResult(index: candidate, message: 'moved to $candidate within group');
  }

  switch (behavior) {
    case TraversalEdgeBehavior.closedLoop:
      final wrapped = candidate < 0 ? count - 1 : 0;
      return _MoveResult(index: wrapped, message: 'wrapped to $wrapped');
    case TraversalEdgeBehavior.stop:
      return _MoveResult(index: current, message: 'stopped at edge (no move)');
    case TraversalEdgeBehavior.parentScope:
      return _MoveResult(index: current, message: 'delegated to parent scope (local index unchanged)');
    case TraversalEdgeBehavior.leaveFlutterView:
      return _MoveResult(index: current, message: 'focus left Flutter view (local index unchanged)');
  }
}

class _Playbook {
  const _Playbook({
    required this.title,
    required this.behavior,
    required this.bullets,
    required this.color,
  });

  final String title;
  final TraversalEdgeBehavior behavior;
  final List<String> bullets;
  final Color color;
}
