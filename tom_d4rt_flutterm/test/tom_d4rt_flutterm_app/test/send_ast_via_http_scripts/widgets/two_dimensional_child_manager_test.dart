import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _ChildManagerDeepDemo();
}

const Color _kIron = Color(0xFF1E293B);
const Color _kFog = Color(0xFFF8FAFC);
const Color _kSignal = Color(0xFF67E8F9);

class _ChildManagerDeepDemo extends StatefulWidget {
  const _ChildManagerDeepDemo();

  @override
  State<_ChildManagerDeepDemo> createState() => _ChildManagerDeepDemoState();
}

class _ChildManagerDeepDemoState extends State<_ChildManagerDeepDemo>
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
      backgroundColor: _kFog,
      appBar: AppBar(
        backgroundColor: _kIron,
        foregroundColor: Colors.white,
        title: const Text('TwoDimensionalChildManager Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kSignal,
          tabs: const [
            Tab(text: 'Architecture'),
            Tab(text: 'Lifecycle Sim'),
            Tab(text: 'Underflow Lab'),
            Tab(text: 'Diagnostics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ArchitecturePanel(),
          _LifecycleSimulationPanel(),
          _UnderflowLabPanel(),
          _DiagnosticsPanel(),
        ],
      ),
    );
  }
}

class _ArchitecturePanel extends StatelessWidget {
  const _ArchitecturePanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _IntroCard(
          title: 'Manager Role in 2D Viewports',
          description:
              'TwoDimensionalChildManager coordinates child creation/removal between '
              'viewport layout logic and delegate-provided widgets. It is a render-layer '
              'management interface rather than a typical app-level class.',
        ),
        SizedBox(height: 12),
        _RoleCard(
          title: 'Primary responsibilities',
          tint: Color(0xFF0F766E),
          bullets: [
            'createChild(vicinity): request and mount child structure.',
            'removeChild(vicinity): detach or recycle child resources.',
            'didAdoptChild(vicinity): wire parent data and map ownership.',
            'setDidUnderflow(flag): communicate extent/boundary conditions.',
          ],
        ),
        _RoleCard(
          title: 'Collaboration graph',
          tint: Color(0xFF1D4ED8),
          bullets: [
            'Viewport asks manager for visible vicinities.',
            'Manager asks delegate for widgets at vicinities.',
            'Element/render records are tracked in active and cached pools.',
            'Parent-data updates map child to geometry slots.',
          ],
        ),
        _RoleCard(
          title: 'Why this matters for deep demos',
          tint: Color(0xFF9A3412),
          bullets: [
            'Most UI glitches in massive grids are lifecycle/caching issues.',
            'Underflow handling impacts scroll extent and edge behavior.',
            'Understanding manager flow helps debug missing or stale children.',
            'Interpreter integration relies on correct child orchestration.',
          ],
        ),
        SizedBox(height: 12),
        _PipelineCard(),
      ],
    );
  }
}

class _PipelineCard extends StatelessWidget {
  const _PipelineCard();

  @override
  Widget build(BuildContext context) {
    final steps = <String>[
      'Viewport computes needed vicinities for current scroll offsets.',
      'Manager creates missing children and reuses cached ones when possible.',
      'Manager removes off-screen children and tracks keep-alive candidates.',
      'Manager reports underflow when finite edges are reached.',
      'Viewport finalizes geometry and paint traversal for active children.',
    ];
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lifecycle Pipeline', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            for (var i = 0; i < steps.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0EA5E9)),
                      child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(steps[i])),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LifecycleSimulationPanel extends StatefulWidget {
  const _LifecycleSimulationPanel();

  @override
  State<_LifecycleSimulationPanel> createState() => _LifecycleSimulationPanelState();
}

class _LifecycleSimulationPanelState extends State<_LifecycleSimulationPanel> {
  int _viewportX = 0;
  int _viewportY = 0;
  int _viewW = 4;
  int _viewH = 3;
  bool _keepAlive = true;

  final Map<String, _ManagedNode> _active = <String, _ManagedNode>{};
  final Map<String, _ManagedNode> _cache = <String, _ManagedNode>{};
  final List<String> _events = <String>['Simulation initialized'];

  String _key(int x, int y) => '$x:$y';

  void _log(String text) {
    _events.add(text);
    if (_events.length > 40) {
      _events.removeAt(0);
    }
  }

  Set<String> _targetWindow() {
    final result = <String>{};
    for (var y = _viewportY; y < _viewportY + _viewH; y++) {
      for (var x = _viewportX; x < _viewportX + _viewW; x++) {
        result.add(_key(x, y));
      }
    }
    return result;
  }

  void _syncWindow() {
    final target = _targetWindow();
    final toRemove = _active.keys.where((k) => !target.contains(k)).toList();
    for (final key in toRemove) {
      final node = _active.remove(key)!;
      if (_keepAlive) {
        _cache[key] = node.copyWith(state: _NodeState.cached);
        _log('removeChild($key) -> moved to keepAlive cache');
      } else {
        _log('removeChild($key) -> disposed');
      }
    }

    for (final key in target) {
      if (_active.containsKey(key)) {
        continue;
      }
      if (_cache.containsKey(key)) {
        final restored = _cache.remove(key)!.copyWith(state: _NodeState.active);
        _active[key] = restored;
        _log('createChild($key) -> restored from cache');
      } else {
        _active[key] = _ManagedNode(id: key, state: _NodeState.active, frameBorn: DateTime.now().millisecondsSinceEpoch);
        _log('createChild($key) -> new node');
      }
      _log('didAdoptChild($key) -> parentData set');
    }
  }

  @override
  void initState() {
    super.initState();
    _syncWindow();
  }

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var y = _viewportY; y < _viewportY + _viewH; y++) {
      final children = <Widget>[];
      for (var x = _viewportX; x < _viewportX + _viewW; x++) {
        final key = _key(x, y);
        final active = _active[key];
        children.add(
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(2),
              height: 62,
              decoration: BoxDecoration(
                color: active == null ? const Color(0xFFE2E8F0) : const Color(0xFFBAE6FD),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF334155), width: 0.7),
              ),
              child: Center(
                child: Text(active == null ? 'inactive' : key),
              ),
            ),
          ),
        );
      }
      rows.add(Row(children: children));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Lifecycle Simulation Console',
          description:
              'This panel emulates createChild/removeChild/didAdoptChild flows for '
              'a moving viewport window and visualizes active versus cached nodes.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _RangeSliderRow(
                  label: 'Viewport offset X',
                  value: _viewportX.toDouble(),
                  min: 0,
                  max: 8,
                  divisions: 8,
                  onChanged: (v) => setState(() => _viewportX = v.round()),
                ),
                _RangeSliderRow(
                  label: 'Viewport offset Y',
                  value: _viewportY.toDouble(),
                  min: 0,
                  max: 8,
                  divisions: 8,
                  onChanged: (v) => setState(() => _viewportY = v.round()),
                ),
                _RangeSliderRow(
                  label: 'Window width',
                  value: _viewW.toDouble(),
                  min: 2,
                  max: 6,
                  divisions: 4,
                  onChanged: (v) => setState(() => _viewW = v.round()),
                ),
                _RangeSliderRow(
                  label: 'Window height',
                  value: _viewH.toDouble(),
                  min: 2,
                  max: 6,
                  divisions: 4,
                  onChanged: (v) => setState(() => _viewH = v.round()),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Keep off-screen nodes in cache bucket'),
                  value: _keepAlive,
                  onChanged: (v) => setState(() => _keepAlive = v),
                ),
                Row(
                  children: [
                    FilledButton(
                      onPressed: () => setState(_syncWindow),
                      child: const Text('Apply Viewport Change'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () => setState(() {
                        _active.clear();
                        _cache.clear();
                        _events.clear();
                        _events.add('Simulation reset');
                        _syncWindow();
                      }),
                      child: const Text('Reset Simulation'),
                    ),
                  ],
                ),
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
                Text('Active nodes: ${_active.length} | Cached nodes: ${_cache.length}', style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...rows,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UnderflowLabPanel extends StatefulWidget {
  const _UnderflowLabPanel();

  @override
  State<_UnderflowLabPanel> createState() => _UnderflowLabPanelState();
}

class _UnderflowLabPanelState extends State<_UnderflowLabPanel> {
  int _maxX = 7;
  int _maxY = 6;
  int _probeX = 0;
  int _probeY = 0;
  bool _didUnderflow = false;
  final List<String> _timeline = <String>['Underflow lab initialized'];

  void _evaluate() {
    final underflow = _probeX > _maxX || _probeY > _maxY;
    setState(() {
      _didUnderflow = underflow;
      _timeline.add('setDidUnderflow($_didUnderflow) for probe ($_probeX,$_probeY) against max($_maxX,$_maxY)');
      if (_timeline.length > 26) {
        _timeline.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Underflow Lab',
          description:
              'Underflow tells the viewport it has reached finite content limits. '
              'This affects extent calculations and edge scrolling behavior.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _RangeSliderRow(
                  label: 'Content maxX',
                  value: _maxX.toDouble(),
                  min: 2,
                  max: 12,
                  divisions: 10,
                  onChanged: (v) => setState(() => _maxX = v.round()),
                ),
                _RangeSliderRow(
                  label: 'Content maxY',
                  value: _maxY.toDouble(),
                  min: 2,
                  max: 12,
                  divisions: 10,
                  onChanged: (v) => setState(() => _maxY = v.round()),
                ),
                _RangeSliderRow(
                  label: 'Probe X',
                  value: _probeX.toDouble(),
                  min: 0,
                  max: 14,
                  divisions: 14,
                  onChanged: (v) => setState(() => _probeX = v.round()),
                ),
                _RangeSliderRow(
                  label: 'Probe Y',
                  value: _probeY.toDouble(),
                  min: 0,
                  max: 14,
                  divisions: 14,
                  onChanged: (v) => setState(() => _probeY = v.round()),
                ),
                const SizedBox(height: 6),
                FilledButton(onPressed: _evaluate, child: const Text('Evaluate Underflow')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _didUnderflow ? const Color(0xFFFEE2E2) : const Color(0xFFDCFCE7),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('didUnderflow = $_didUnderflow', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                const SizedBox(height: 6),
                Text(
                  _didUnderflow
                      ? 'Probe is outside content range. Viewport should stop expecting more children.'
                      : 'Probe is within bounds. Child creation may continue for this vicinity.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Underflow Timeline', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _timeline)
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

class _DiagnosticsPanel extends StatefulWidget {
  const _DiagnosticsPanel();

  @override
  State<_DiagnosticsPanel> createState() => _DiagnosticsPanelState();
}

class _DiagnosticsPanelState extends State<_DiagnosticsPanel> {
  final List<_DiagnosticProbe> _probes = <_DiagnosticProbe>[
    const _DiagnosticProbe('Child churn', 'Frequent create/remove in short intervals', Icons.sync_alt),
    const _DiagnosticProbe('Stale parent data', 'Rows paint at wrong offsets after reuse', Icons.warning_amber),
    const _DiagnosticProbe('Cache overflow', 'KeepAlive bucket grows without trimming', Icons.inbox),
    const _DiagnosticProbe('Underflow mismatch', 'Viewport over-scrolls beyond content', Icons.border_all),
  ];

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final active = _probes[_selected];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _IntroCard(
          title: 'Diagnostics Playbook',
          description:
              'Use this panel as a troubleshooting reference when integrating '
              'interpreter-driven two-dimensional viewports.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var i = 0; i < _probes.length; i++)
                  ChoiceChip(
                    label: Text(_probes[i].title),
                    selected: _selected == i,
                    onSelected: (_) => setState(() => _selected = i),
                  ),
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
                Row(
                  children: [
                    Icon(active.icon, color: const Color(0xFF0C4A6E)),
                    const SizedBox(width: 8),
                    Text(active.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(active.detail),
                const SizedBox(height: 8),
                const Text('Recommended checks:', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text('• Verify create/remove symmetry over a full scroll cycle.'),
                Text('• Confirm didAdoptChild updates vicinity-specific parent data.'),
                Text('• Track cache growth and prune when visibility horizon changes.'),
                Text('• Compare underflow transitions with viewport boundary gestures.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.title, required this.description});

  final String title;
  final String description;

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
            Text(description),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({required this.title, required this.tint, required this.bullets});

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
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: tint)),
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

class _RangeSliderRow extends StatelessWidget {
  const _RangeSliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.round()}'),
        Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged),
      ],
    );
  }
}

enum _NodeState { active, cached }

class _ManagedNode {
  const _ManagedNode({required this.id, required this.state, required this.frameBorn});

  final String id;
  final _NodeState state;
  final int frameBorn;

  _ManagedNode copyWith({_NodeState? state}) {
    return _ManagedNode(id: id, state: state ?? this.state, frameBorn: frameBorn);
  }
}

class _DiagnosticProbe {
  const _DiagnosticProbe(this.title, this.detail, this.icon);

  final String title;
  final String detail;
  final IconData icon;
}
