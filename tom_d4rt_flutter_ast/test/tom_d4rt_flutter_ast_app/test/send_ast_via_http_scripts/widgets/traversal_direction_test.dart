import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _TraversalDirectionDeepDemo();
}

const Color _kPrimary = Color(0xFF6A1B9A);
const Color _kAccent = Color(0xFF26C6DA);
const Color _kSurface = Color(0xFFF3E5F5);
const Color _kPanel = Colors.white;

class _TraversalDirectionDeepDemo extends StatefulWidget {
  const _TraversalDirectionDeepDemo();

  @override
  State<_TraversalDirectionDeepDemo> createState() =>
      _TraversalDirectionDeepDemoState();
}

class _TraversalDirectionDeepDemoState extends State<_TraversalDirectionDeepDemo>
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
        title: const Text('TraversalDirection Deep Demo'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          tabs: const [
            Tab(text: 'Direction Basics'),
            Tab(text: 'Navigation Lab'),
            Tab(text: 'Policy Strategies'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _DirectionBasicsTab(),
          _NavigationLabTab(),
          _PolicyStrategiesTab(),
        ],
      ),
    );
  }
}

class _DirectionBasicsTab extends StatelessWidget {
  const _DirectionBasicsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _InfoCard(
          title: 'TraversalDirection Overview',
          body:
              'TraversalDirection communicates the intended spatial focus move: '
              'up, right, down, or left. Traversal policy then maps that request '
              'to the best focus candidate by geometry and constraints.',
        ),
        SizedBox(height: 12),
        _DirectionDeck(),
        SizedBox(height: 12),
        _TopicCard(
          title: 'Absolute direction model',
          bullets: [
            'Direction tokens are spatial, not lexical.',
            'Policies may adapt behavior for RTL but direction remains explicit.',
            'Directional intent can coexist with tab-order traversal.',
            'Result quality depends on focus tree geometry metadata.',
          ],
          color: Color(0xFF1565C0),
        ),
        _TopicCard(
          title: 'Where it is used',
          bullets: [
            'Arrow-key handling in desktop/mobile keyboard contexts.',
            'Remote-control and gamepad navigation surfaces.',
            'Accessibility navigation in non-linear layouts.',
            'Custom action maps for intent-driven focus UX.',
          ],
          color: Color(0xFF2E7D32),
        ),
      ],
    );
  }
}

class _NavigationLabTab extends StatefulWidget {
  const _NavigationLabTab();

  @override
  State<_NavigationLabTab> createState() => _NavigationLabTabState();
}

class _NavigationLabTabState extends State<_NavigationLabTab> {
  static const int _rows = 3;
  static const int _cols = 4;

  int _activeIndex = 0;
  bool _wrapEdges = false;
  bool _skipDisabled = true;
  final Set<int> _disabled = {5, 8};
  final List<String> _events = ['Navigation lab initialized'];

  void _append(String line) {
    setState(() {
      _events.add(line);
      if (_events.length > 32) {
        _events.removeAt(0);
      }
    });
  }

  void _move(TraversalDirection direction) {
    final next = _nextIndex(
      current: _activeIndex,
      direction: direction,
      rows: _rows,
      cols: _cols,
      wrapEdges: _wrapEdges,
      skipDisabled: _skipDisabled,
      disabled: _disabled,
    );
    if (next == _activeIndex) {
      _append('move $direction => blocked');
      return;
    }
    setState(() => _activeIndex = next);
    _append('move $direction => node $next');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _InfoCard(
          title: 'Directional Navigation Lab',
          body:
              'Use directional commands to navigate a focus grid. Toggle wrapping '
              'and disabled-node handling to observe policy differences.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('wrap edges'),
                      selected: _wrapEdges,
                      onSelected: (value) => setState(() => _wrapEdges = value),
                    ),
                    FilterChip(
                      label: const Text('skip disabled'),
                      selected: _skipDisabled,
                      onSelected: (value) => setState(() => _skipDisabled = value),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 220,
                  child: GridView.builder(
                    itemCount: _rows * _cols,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _cols,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final isActive = index == _activeIndex;
                      final isDisabled = _disabled.contains(index);
                      return _FocusNodeTile(
                        index: index,
                        active: isActive,
                        disabled: isDisabled,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () => _move(TraversalDirection.up),
                      child: const Text('Up'),
                    ),
                    OutlinedButton(
                      onPressed: () => _move(TraversalDirection.right),
                      child: const Text('Right'),
                    ),
                    OutlinedButton(
                      onPressed: () => _move(TraversalDirection.down),
                      child: const Text('Down'),
                    ),
                    OutlinedButton(
                      onPressed: () => _move(TraversalDirection.left),
                      child: const Text('Left'),
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
                const Text('Event Stream', style: TextStyle(fontWeight: FontWeight.w700)),
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

class _PolicyStrategiesTab extends StatelessWidget {
  const _PolicyStrategiesTab();

  static const List<_PolicyProfile> _profiles = [
    _PolicyProfile(
      title: 'Grid controls',
      bullets: [
        'Use geometric nearest-neighbor search in requested direction.',
        'Skip disabled nodes by default for faster keyboard flow.',
        'Optional wrap helps gamepad/TV-like navigation.',
      ],
      color: Color(0xFF6A1B9A),
    ),
    _PolicyProfile(
      title: 'Form sections',
      bullets: [
        'Prioritize reading-order fallback when directional candidate missing.',
        'Prevent wrap to avoid jumping between unrelated sections.',
        'Annotate focus order explicitly for assistive predictability.',
      ],
      color: Color(0xFF1565C0),
    ),
    _PolicyProfile(
      title: 'Spatial dashboards',
      bullets: [
        'Allow long-distance jumps if nearest candidate is obstructed.',
        'Record traversal path for diagnostics and UX tuning.',
        'Integrate with shortcuts to toggle policy mode on demand.',
      ],
      color: Color(0xFF2E7D32),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _InfoCard(
          title: 'Policy Strategy Gallery',
          body:
              'TraversalDirection is just the request token. Product quality '
              'comes from policy rules that decide candidate ranking, wrapping, '
              'disabled handling, and fallback behavior.',
        ),
        const SizedBox(height: 12),
        for (final profile in _profiles)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              color: _kPanel,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.title,
                      style: TextStyle(fontWeight: FontWeight.w700, color: profile.color),
                    ),
                    const SizedBox(height: 8),
                    for (final bullet in profile.bullets)
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

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

class _DirectionDeck extends StatelessWidget {
  const _DirectionDeck();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _kPanel,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _DirectionRow(direction: TraversalDirection.up, icon: Icons.keyboard_arrow_up),
            const SizedBox(height: 6),
            _DirectionRow(direction: TraversalDirection.right, icon: Icons.keyboard_arrow_right),
            const SizedBox(height: 6),
            _DirectionRow(direction: TraversalDirection.down, icon: Icons.keyboard_arrow_down),
            const SizedBox(height: 6),
            _DirectionRow(direction: TraversalDirection.left, icon: Icons.keyboard_arrow_left),
          ],
        ),
      ),
    );
  }
}

class _DirectionRow extends StatelessWidget {
  const _DirectionRow({required this.direction, required this.icon});

  final TraversalDirection direction;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Expanded(child: Text('TraversalDirection.$direction')), 
      ],
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.title, required this.bullets, required this.color});

  final String title;
  final List<String> bullets;
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
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

class _FocusNodeTile extends StatelessWidget {
  const _FocusNodeTile({required this.index, required this.active, required this.disabled});

  final int index;
  final bool active;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final color = disabled
        ? const Color(0xFFCFD8DC)
        : active
            ? const Color(0xFF7E57C2)
            : const Color(0xFFD1C4E9);
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: active ? const Color(0xFF4A148C) : Colors.transparent, width: 2),
      ),
      child: Center(
        child: Text(
          disabled ? 'X$index' : '$index',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

int _nextIndex({
  required int current,
  required TraversalDirection direction,
  required int rows,
  required int cols,
  required bool wrapEdges,
  required bool skipDisabled,
  required Set<int> disabled,
}) {
  int row = current ~/ cols;
  int col = current % cols;

  int moveRow = row;
  int moveCol = col;
  switch (direction) {
    case TraversalDirection.up:
      moveRow -= 1;
    case TraversalDirection.right:
      moveCol += 1;
    case TraversalDirection.down:
      moveRow += 1;
    case TraversalDirection.left:
      moveCol -= 1;
  }

  if (wrapEdges) {
    moveRow = (moveRow + rows) % rows;
    moveCol = (moveCol + cols) % cols;
  }

  if (moveRow < 0 || moveRow >= rows || moveCol < 0 || moveCol >= cols) {
    return current;
  }

  int candidate = moveRow * cols + moveCol;
  if (!skipDisabled || !disabled.contains(candidate)) {
    return candidate;
  }

  // Continue in same direction until a non-disabled node or boundary is found.
  int searchRow = moveRow;
  int searchCol = moveCol;
  for (var i = 0; i < rows * cols; i++) {
    switch (direction) {
      case TraversalDirection.up:
        searchRow -= 1;
      case TraversalDirection.right:
        searchCol += 1;
      case TraversalDirection.down:
        searchRow += 1;
      case TraversalDirection.left:
        searchCol -= 1;
    }

    if (wrapEdges) {
      searchRow = (searchRow + rows) % rows;
      searchCol = (searchCol + cols) % cols;
    }

    if (searchRow < 0 || searchRow >= rows || searchCol < 0 || searchCol >= cols) {
      return current;
    }

    candidate = searchRow * cols + searchCol;
    if (!disabled.contains(candidate)) {
      return candidate;
    }
  }
  return current;
}

class _PolicyProfile {
  const _PolicyProfile({required this.title, required this.bullets, required this.color});

  final String title;
  final List<String> bullets;
  final Color color;
}
