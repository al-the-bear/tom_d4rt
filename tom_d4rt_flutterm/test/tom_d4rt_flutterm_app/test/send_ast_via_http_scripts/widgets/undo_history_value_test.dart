import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _UndoHistoryValueDeepDemo();
}

const Color _kNightInk = Color(0xFF0B1324);
const Color _kCloud = Color(0xFFF8FAFC);
const Color _kAqua = Color(0xFFA5F3FC);

class _UndoHistoryValueDeepDemo extends StatefulWidget {
  const _UndoHistoryValueDeepDemo();

  @override
  State<_UndoHistoryValueDeepDemo> createState() => _UndoHistoryValueDeepDemoState();
}

class _UndoHistoryValueDeepDemoState extends State<_UndoHistoryValueDeepDemo>
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
      backgroundColor: _kCloud,
      appBar: AppBar(
        backgroundColor: _kNightInk,
        foregroundColor: Colors.white,
        title: const Text('UndoHistoryValue Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAqua,
          tabs: const [
            Tab(text: 'Value Semantics'),
            Tab(text: 'State Machine'),
            Tab(text: 'UI Policy Lab'),
            Tab(text: 'Diagnostics Grid'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ValueSemanticsPanel(),
          _StateMachinePanel(),
          _UiPolicyPanel(),
          _DiagnosticsGridPanel(),
        ],
      ),
    );
  }
}

class _ValueSemanticsPanel extends StatelessWidget {
  const _ValueSemanticsPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _MainCard(
          title: 'UndoHistoryValue Overview',
          body:
              'UndoHistoryValue is a compact immutable representation of command '
              'availability. It does not store content snapshots, only whether undo '
              'or redo is currently possible from state perspective.',
        ),
        SizedBox(height: 12),
        _BulletBlock(
          title: 'Core facts',
          tone: Color(0xFF166534),
          items: [
            'Two boolean flags: canUndo and canRedo.',
            'Static empty value is fully disabled state.',
            'Designed for cheap comparison and notifier updates.',
            'Often emitted by UndoHistoryController and observed by UI.',
          ],
        ),
        _BulletBlock(
          title: 'Design rationale',
          tone: Color(0xFF1D4ED8),
          items: [
            'Decouples stack internals from UI command surfaces.',
            'Allows action bars to react without reading full history.',
            'Supports predictable rendering because state is immutable.',
            'Plays well with ValueNotifier and widget rebuild heuristics.',
          ],
        ),
        _BulletBlock(
          title: 'Usage strategy',
          tone: Color(0xFF9A3412),
          items: [
            'Treat value changes as command policy updates.',
            'Map to enabled/disabled states for controls and menus.',
            'Use pair transitions to drive user hints and telemetry.',
            'Avoid deriving stack depth from this value alone.',
          ],
        ),
        SizedBox(height: 12),
        _SemanticsMatrixCard(),
      ],
    );
  }
}

class _SemanticsMatrixCard extends StatelessWidget {
  const _SemanticsMatrixCard();

  @override
  Widget build(BuildContext context) {
    const rows = [
      _StateInfo('false', 'false', 'No command available; initial or reset state.'),
      _StateInfo('true', 'false', 'Undo available; timeline has earlier snapshot.'),
      _StateInfo('false', 'true', 'Redo available after at least one undo.'),
      _StateInfo('true', 'true', 'Both directions available in a branched timeline.'),
    ];

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Availability Matrix', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            for (final row in rows)
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text('canUndo=${row.undo}, canRedo=${row.redo} -> ${row.explanation}'),
              ),
          ],
        ),
      ),
    );
  }
}

class _StateMachinePanel extends StatefulWidget {
  const _StateMachinePanel();

  @override
  State<_StateMachinePanel> createState() => _StateMachinePanelState();
}

class _StateMachinePanelState extends State<_StateMachinePanel> {
  late UndoHistoryValue _value;
  int _stackDepth = 1;
  int _pointer = 0;
  final List<String> _log = ['State machine initialized'];

  @override
  void initState() {
    super.initState();
    _value = UndoHistoryValue.empty;
  }

  void _sync() {
    _value = UndoHistoryValue(
      canUndo: _pointer > 0,
      canRedo: _pointer < _stackDepth - 1,
    );
  }

  void _pushEvent(String event) {
    _log.add(event);
    if (_log.length > 26) {
      _log.removeAt(0);
    }
  }

  void _commit() {
    setState(() {
      _stackDepth = _pointer + 2;
      _pointer++;
      _sync();
      _pushEvent('commit -> depth $_stackDepth, pointer $_pointer');
    });
  }

  void _undo() {
    if (!_value.canUndo) {
      return;
    }
    setState(() {
      _pointer--;
      _sync();
      _pushEvent('undo -> pointer $_pointer');
    });
  }

  void _redo() {
    if (!_value.canRedo) {
      return;
    }
    setState(() {
      _pointer++;
      _sync();
      _pushEvent('redo -> pointer $_pointer');
    });
  }

  void _reset() {
    setState(() {
      _stackDepth = 1;
      _pointer = 0;
      _sync();
      _pushEvent('reset -> empty state');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _MainCard(
          title: 'State Machine Simulator',
          body:
              'Simulate timeline transitions and inspect UndoHistoryValue updates '
              'without exposing stack internals to the UI layer.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(onPressed: _commit, child: const Text('Commit')), 
                    OutlinedButton(onPressed: _undo, child: const Text('Undo')),
                    OutlinedButton(onPressed: _redo, child: const Text('Redo')),
                    TextButton(onPressed: _reset, child: const Text('Reset')),
                  ],
                ),
                const SizedBox(height: 10),
                Text('stack depth: $_stackDepth'),
                Text('pointer: $_pointer'),
                Text('UndoHistoryValue(canUndo: ${_value.canUndo}, canRedo: ${_value.canRedo})'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: _value.canUndo || _value.canRedo ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Value Classification', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text(_classify(_value)),
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
                const Text('Transition Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _log)
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

String _classify(UndoHistoryValue value) {
  if (!value.canUndo && !value.canRedo) {
    return 'Idle state: both commands unavailable.';
  }
  if (value.canUndo && !value.canRedo) {
    return 'Forward timeline state: undo available, redo unavailable.';
  }
  if (!value.canUndo && value.canRedo) {
    return 'Reverted root state: redo available only.';
  }
  return 'Branched middle state: both undo and redo available.';
}

class _UiPolicyPanel extends StatefulWidget {
  const _UiPolicyPanel();

  @override
  State<_UiPolicyPanel> createState() => _UiPolicyPanelState();
}

class _UiPolicyPanelState extends State<_UiPolicyPanel> {
  UndoHistoryValue _value = UndoHistoryValue.empty;

  @override
  Widget build(BuildContext context) {
    final undoEnabled = _value.canUndo;
    final redoEnabled = _value.canRedo;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _MainCard(
          title: 'UI Policy Playground',
          body:
              'Map UndoHistoryValue to UI policy decisions for toolbar buttons, '
              'context menus, and keyboard hint overlays.',
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
                ChoiceChip(
                  label: const Text('empty'),
                  selected: _value == UndoHistoryValue.empty,
                  onSelected: (_) => setState(() => _value = UndoHistoryValue.empty),
                ),
                ChoiceChip(
                  label: const Text('undo only'),
                  selected: _value.canUndo && !_value.canRedo,
                  onSelected: (_) => setState(() => _value = const UndoHistoryValue(canUndo: true, canRedo: false)),
                ),
                ChoiceChip(
                  label: const Text('redo only'),
                  selected: !_value.canUndo && _value.canRedo,
                  onSelected: (_) => setState(() => _value = const UndoHistoryValue(canUndo: false, canRedo: true)),
                ),
                ChoiceChip(
                  label: const Text('both'),
                  selected: _value.canUndo && _value.canRedo,
                  onSelected: (_) => setState(() => _value = const UndoHistoryValue(canUndo: true, canRedo: true)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFF8FAFC),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Toolbar Preview', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: undoEnabled ? () {} : null,
                      icon: const Icon(Icons.undo),
                      label: const Text('Undo'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: redoEnabled ? () {} : null,
                      icon: const Icon(Icons.redo),
                      label: const Text('Redo'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Menu policy: ${undoEnabled ? 'show Undo enabled' : 'show Undo disabled'}'),
                Text('Menu policy: ${redoEnabled ? 'show Redo enabled' : 'show Redo disabled'}'),
                Text('Hint text: ${_classify(_value)}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DiagnosticsGridPanel extends StatelessWidget {
  const _DiagnosticsGridPanel();

  @override
  Widget build(BuildContext context) {
    final samples = <UndoHistoryValue>[
      UndoHistoryValue.empty,
      const UndoHistoryValue(canUndo: true, canRedo: false),
      const UndoHistoryValue(canUndo: false, canRedo: true),
      const UndoHistoryValue(canUndo: true, canRedo: true),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _MainCard(
          title: 'Diagnostics and Equality Grid',
          body:
              'UndoHistoryValue equality is central to stable updates. This grid '
              'illustrates pairwise comparisons and value identity expectations.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                for (var i = 0; i < samples.length; i++)
                  for (var j = 0; j < samples.length; j++)
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: samples[i] == samples[j] ? const Color(0xFFDCFCE7) : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        'v$i (${samples[i].canUndo},${samples[i].canRedo}) == '
                        'v$j (${samples[j].canUndo},${samples[j].canRedo}) '
                        '=> ${samples[i] == samples[j]}',
                      ),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MainCard extends StatelessWidget {
  const _MainCard({required this.title, required this.body});

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

class _BulletBlock extends StatelessWidget {
  const _BulletBlock({required this.title, required this.tone, required this.items});

  final String title;
  final Color tone;
  final List<String> items;

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
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: tone)),
              const SizedBox(height: 6),
              for (final item in items)
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

class _StateInfo {
  const _StateInfo(this.undo, this.redo, this.explanation);

  final String undo;
  final String redo;
  final String explanation;
}
