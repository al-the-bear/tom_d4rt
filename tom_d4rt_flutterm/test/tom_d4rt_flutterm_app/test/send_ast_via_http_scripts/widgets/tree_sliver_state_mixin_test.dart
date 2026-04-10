import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _TreeSliverStateMixinDeepDemo();
}

const Color _kPrimary = Color(0xFF263238);
const Color _kAccent = Color(0xFF80CBC4);
const Color _kSurface = Color(0xFFE0F2F1);
const Color _kPanel = Colors.white;

class _TreeSliverStateMixinDeepDemo extends StatefulWidget {
  const _TreeSliverStateMixinDeepDemo();

  @override
  State<_TreeSliverStateMixinDeepDemo> createState() =>
      _TreeSliverStateMixinDeepDemoState();
}

class _TreeSliverStateMixinDeepDemoState extends State<_TreeSliverStateMixinDeepDemo>
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
        title: const Text('TreeSliverStateMixin Deep Demo'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          tabs: const [
            Tab(text: 'State Model'),
            Tab(text: 'Expansion Lab'),
            Tab(text: 'Lifecycle Diagnostics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _StateModelTab(),
          _ExpansionLabTab(),
          _LifecycleDiagnosticsTab(),
        ],
      ),
    );
  }
}

class _StateModelTab extends StatelessWidget {
  const _StateModelTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _IntroCard(
          title: 'TreeSliverStateMixin Purpose',
          body:
              'TreeSliverStateMixin coordinates expansion state, visible row '
              'projection, and node-index lookup for hierarchical sliver data. '
              'It is state infrastructure rather than end-user widget API.',
        ),
        SizedBox(height: 12),
        _TopicCard(
          title: 'Core responsibilities',
          bullets: [
            'Track expanded node keys and query expansion efficiently.',
            'Flatten visible rows from nested hierarchy on each state change.',
            'Provide row lookup and active-row navigation helpers.',
            'Synchronize with controller and animation pipelines.',
          ],
          color: Color(0xFF1565C0),
        ),
        _TopicCard(
          title: 'State transitions',
          bullets: [
            'toggleExpansion updates expansion set.',
            'row projection recomputes visible node order.',
            'render pipeline reuses mapped rows for sliver delegates.',
            'disposal releases listeners and transient animation state.',
          ],
          color: Color(0xFF2E7D32),
        ),
        _TopicCard(
          title: 'Failure modes to guard against',
          bullets: [
            'Orphaned expansion keys after model replacement.',
            'Row index mismatch when collapsing deep branches.',
            'Concurrent animation updates racing with rebuilds.',
            'Controller callbacks after state disposal.',
          ],
          color: Color(0xFF6A1B9A),
        ),
      ],
    );
  }
}

class _ExpansionLabTab extends StatefulWidget {
  const _ExpansionLabTab();

  @override
  State<_ExpansionLabTab> createState() => _ExpansionLabTabState();
}

class _ExpansionLabTabState extends State<_ExpansionLabTab> {
  final _TreeNode _root = _buildDemoTree();
  final Set<String> _expanded = {'root', 'A'};
  final List<String> _events = ['Expansion lab initialized'];

  void _append(String message) {
    setState(() {
      _events.add(message);
      if (_events.length > 36) {
        _events.removeAt(0);
      }
    });
  }

  void _toggle(String id) {
    setState(() {
      if (_expanded.contains(id)) {
        _expanded.remove(id);
        _append('collapse: $id');
      } else {
        _expanded.add(id);
        _append('expand: $id');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final rows = _visibleRows(_root, _expanded);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Expansion State Lab',
          body:
              'Interact with a hierarchical data set and observe how expansion '
              'state affects visible sliver rows and row-index mapping.',
        ),
        const SizedBox(height: 12),
        Card(
          color: _kPanel,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tree Projection', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                for (final row in rows)
                  _TreeRowTile(
                    row: row,
                    expanded: _expanded.contains(row.node.id),
                    onToggle: row.node.children.isEmpty ? null : () => _toggle(row.node.id),
                  ),
                const SizedBox(height: 8),
                Text('Visible rows: ${rows.length}'),
                Text('Expanded keys: ${_expanded.toList()..sort()}'),
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
                const Text('Row Lookup Examples', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                for (final id in ['A', 'A-2', 'B-1', 'C'])
                  Text('node $id => row ${_rowForNode(rows, id) ?? 'hidden'}'),
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
                const Text('State Event Log', style: TextStyle(fontWeight: FontWeight.w700)),
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

class _LifecycleDiagnosticsTab extends StatefulWidget {
  const _LifecycleDiagnosticsTab();

  @override
  State<_LifecycleDiagnosticsTab> createState() => _LifecycleDiagnosticsTabState();
}

class _LifecycleDiagnosticsTabState extends State<_LifecycleDiagnosticsTab> {
  bool _controllerAttached = true;
  bool _animationsRunning = false;
  bool _disposed = false;
  final List<String> _timeline = ['Diagnostics initialized'];

  void _append(String line) {
    setState(() {
      _timeline.add(line);
      if (_timeline.length > 30) {
        _timeline.removeAt(0);
      }
    });
  }

  void _runCycle() {
    if (_disposed) {
      _append('cycle blocked: state disposed');
      return;
    }
    if (!_controllerAttached) {
      _append('cycle blocked: controller detached');
      return;
    }
    setState(() => _animationsRunning = true);
    _append('expansion animation started');
    Future<void>.delayed(const Duration(milliseconds: 200), () {
      if (!mounted || _disposed) {
        return;
      }
      setState(() => _animationsRunning = false);
      _append('expansion animation completed');
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = _diagnose(
      controllerAttached: _controllerAttached,
      animationsRunning: _animationsRunning,
      disposed: _disposed,
    );
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Lifecycle Diagnostics',
          body:
              'This panel models state-mixin lifecycle phases and common guard '
              'conditions around controller attachment, animation updates, and disposal.',
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
                      label: const Text('controller attached'),
                      selected: _controllerAttached,
                      onSelected: (value) {
                        setState(() => _controllerAttached = value);
                        _append(value ? 'controller attached' : 'controller detached');
                      },
                    ),
                    FilterChip(
                      label: const Text('disposed'),
                      selected: _disposed,
                      onSelected: (value) {
                        setState(() {
                          _disposed = value;
                          if (value) {
                            _animationsRunning = false;
                          }
                        });
                        _append(value ? 'state disposed' : 'state reactivated for demo');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(onPressed: _runCycle, child: const Text('Run Expansion Cycle')), 
                    OutlinedButton(
                      onPressed: () {
                        setState(() => _animationsRunning = false);
                        _append('animations cleared manually');
                      },
                      child: const Text('Stop Animations'),
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
                const Text('Diagnostic Status', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('phase: ${status.phase}'),
                Text('risk: ${status.risk}'),
                Text('guidance: ${status.guidance}'),
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
                const Text('Timeline', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                for (final entry in _timeline)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $entry'),
                  ),
              ],
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

class _TreeNode {
  const _TreeNode({
    required this.id,
    required this.label,
    required this.children,
  });

  final String id;
  final String label;
  final List<_TreeNode> children;
}

_TreeNode _buildDemoTree() {
  return const _TreeNode(
    id: 'root',
    label: 'Workspace',
    children: [
      _TreeNode(
        id: 'A',
        label: 'Applications',
        children: [
          _TreeNode(id: 'A-1', label: 'Editor', children: []),
          _TreeNode(id: 'A-2', label: 'Terminal', children: []),
        ],
      ),
      _TreeNode(
        id: 'B',
        label: 'Packages',
        children: [
          _TreeNode(id: 'B-1', label: 'core', children: []),
          _TreeNode(id: 'B-2', label: 'ui', children: []),
        ],
      ),
      _TreeNode(id: 'C', label: 'Docs', children: []),
    ],
  );
}

class _VisibleRow {
  const _VisibleRow({required this.node, required this.depth});

  final _TreeNode node;
  final int depth;
}

List<_VisibleRow> _visibleRows(_TreeNode root, Set<String> expanded) {
  final rows = <_VisibleRow>[];
  void visit(_TreeNode node, int depth) {
    rows.add(_VisibleRow(node: node, depth: depth));
    if (!expanded.contains(node.id)) {
      return;
    }
    for (final child in node.children) {
      visit(child, depth + 1);
    }
  }

  visit(root, 0);
  return rows;
}

int? _rowForNode(List<_VisibleRow> rows, String id) {
  for (var i = 0; i < rows.length; i++) {
    if (rows[i].node.id == id) {
      return i;
    }
  }
  return null;
}

class _TreeRowTile extends StatelessWidget {
  const _TreeRowTile({
    required this.row,
    required this.expanded,
    required this.onToggle,
  });

  final _VisibleRow row;
  final bool expanded;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final hasChildren = row.node.children.isNotEmpty;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFE0F7FA),
      ),
      child: Row(
        children: [
          SizedBox(width: row.depth * 20),
          if (hasChildren)
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: onToggle,
              icon: Icon(expanded ? Icons.expand_more : Icons.chevron_right),
            )
          else
            const SizedBox(width: 40),
          Expanded(
            child: Text('${row.node.label} (${row.node.id})'),
          ),
        ],
      ),
    );
  }
}

class _DiagStatus {
  const _DiagStatus({
    required this.phase,
    required this.risk,
    required this.guidance,
  });

  final String phase;
  final String risk;
  final String guidance;
}

_DiagStatus _diagnose({
  required bool controllerAttached,
  required bool animationsRunning,
  required bool disposed,
}) {
  if (disposed) {
    return const _DiagStatus(
      phase: 'disposed',
      risk: 'high if callbacks still fire',
      guidance: 'detach listeners and ignore post-dispose events',
    );
  }
  if (!controllerAttached) {
    return const _DiagStatus(
      phase: 'detached',
      risk: 'medium: updates may be dropped',
      guidance: 'reattach controller before expansion operations',
    );
  }
  if (animationsRunning) {
    return const _DiagStatus(
      phase: 'animating',
      risk: 'low unless overlapping transitions',
      guidance: 'coalesce state writes during active animation frame',
    );
  }
  return const _DiagStatus(
    phase: 'stable',
    risk: 'low',
    guidance: 'safe for row recalculation and user interactions',
  );
}
