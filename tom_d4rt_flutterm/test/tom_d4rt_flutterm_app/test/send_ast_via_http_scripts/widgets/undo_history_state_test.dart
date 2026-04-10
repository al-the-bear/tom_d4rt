import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _UndoHistoryStateDeepDemo();
}

const Color _kCoal = Color(0xFF0F172A);
const Color _kPaper = Color(0xFFF8FAFC);
const Color _kMintGlow = Color(0xFF99F6E4);

class _UndoHistoryStateDeepDemo extends StatefulWidget {
  const _UndoHistoryStateDeepDemo();

  @override
  State<_UndoHistoryStateDeepDemo> createState() => _UndoHistoryStateDeepDemoState();
}

class _UndoHistoryStateDeepDemoState extends State<_UndoHistoryStateDeepDemo>
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
        backgroundColor: _kCoal,
        foregroundColor: Colors.white,
        title: const Text('UndoHistoryState Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kMintGlow,
          tabs: const [
            Tab(text: 'State Blueprint'),
            Tab(text: 'Commit Cycle Lab'),
            Tab(text: 'Focus Binding'),
            Tab(text: 'Action Routing'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _StateBlueprintPanel(),
          _CommitCyclePanel(),
          _FocusBindingPanel(),
          _ActionRoutingPanel(),
        ],
      ),
    );
  }
}

class _StateBlueprintPanel extends StatelessWidget {
  const _StateBlueprintPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _PrimeCard(
          title: 'UndoHistoryState Responsibilities',
          body:
              'UndoHistoryState coordinates edit snapshots, focus-sensitive capture, '
              'controller synchronization, and command dispatch from actions/shortcuts. '
              'It is the runtime brain of UndoHistory widget behavior.',
        ),
        SizedBox(height: 12),
        _DataCard(
          title: 'Lifecycle checkpoints',
          tone: Color(0xFF166534),
          bullets: [
            'initState wires controller listeners and baseline value.',
            'didUpdateWidget adapts to new controller and policy callbacks.',
            'build provides action mapping and child integration context.',
            'dispose detaches listeners and releases owned resources.',
          ],
        ),
        _DataCard(
          title: 'Stack semantics',
          tone: Color(0xFF1D4ED8),
          bullets: [
            'Undo stack stores prior meaningful states.',
            'Redo stack stores reverted states after undo.',
            'New commit after undo invalidates redo future branch.',
            'Throttling and equality checks reduce noisy snapshots.',
          ],
        ),
        _DataCard(
          title: 'Controller bridge',
          tone: Color(0xFF9A3412),
          bullets: [
            'State updates UndoHistoryController.value availability flags.',
            'External commands call controller undo/redo entry points.',
            'State responds by mutating active pointer and content value.',
            'UI reflects new availability after each transition.',
          ],
        ),
        SizedBox(height: 12),
        _FlowMapCard(),
      ],
    );
  }
}

class _FlowMapCard extends StatelessWidget {
  const _FlowMapCard();

  @override
  Widget build(BuildContext context) {
    final map = <String>[
      'Focus enters editable child with UndoHistory wrapper.',
      'User edit mutates focused value and triggers candidate commit.',
      'State decides whether snapshot should enter undo stack.',
      'Controller value is refreshed for canUndo/canRedo.',
      'Actions/Shortcuts call undo/redo to traverse timeline.',
    ];
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Operational Flow Map', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            for (var i = 0; i < map.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0EA5E9)),
                      alignment: Alignment.center,
                      child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(map[i])),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CommitCyclePanel extends StatefulWidget {
  const _CommitCyclePanel();

  @override
  State<_CommitCyclePanel> createState() => _CommitCyclePanelState();
}

class _CommitCyclePanelState extends State<_CommitCyclePanel> {
  late final UndoHistoryController _controller;
  final List<String> _timeline = [''];
  int _pointer = 0;
  int _throttleMs = 250;
  int _clock = 0;
  final List<String> _events = ['Commit cycle lab initialized'];

  @override
  void initState() {
    super.initState();
    _controller = UndoHistoryController();
    _syncController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _syncController() {
    _controller.value = UndoHistoryValue(
      canUndo: _pointer > 0,
      canRedo: _pointer < _timeline.length - 1,
    );
  }

  void _commit(String marker) {
    _clock += 100;
    final shouldMerge = _clock % _throttleMs != 0 && _timeline[_pointer].isNotEmpty;
    setState(() {
      if (_pointer < _timeline.length - 1) {
        _timeline.removeRange(_pointer + 1, _timeline.length);
      }
      if (shouldMerge) {
        _timeline[_pointer] = '${_timeline[_pointer]}$marker';
        _events.add('merged commit "$marker" at pointer $_pointer');
      } else {
        _timeline.add('${_timeline[_pointer]}$marker');
        _pointer = _timeline.length - 1;
        _events.add('new commit "$marker" -> pointer $_pointer');
      }
      if (_events.length > 30) {
        _events.removeAt(0);
      }
      _syncController();
    });
  }

  void _undo() {
    if (!_controller.value.canUndo) {
      return;
    }
    setState(() {
      _controller.undo();
      _pointer--;
      _events.add('undo -> pointer $_pointer');
      _syncController();
    });
  }

  void _redo() {
    if (!_controller.value.canRedo) {
      return;
    }
    setState(() {
      _controller.redo();
      _pointer++;
      _events.add('redo -> pointer $_pointer');
      _syncController();
    });
  }

  @override
  Widget build(BuildContext context) {
    final active = _timeline[_pointer];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _PrimeCard(
          title: 'Commit Cycle Lab',
          body:
              'Explore snapshot commit behavior with throttling, undo/redo traversal, '
              'and branch invalidation after new commits.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NumberSlider(
                  label: 'Throttle window (ms)',
                  value: _throttleMs.toDouble(),
                  min: 100,
                  max: 800,
                  divisions: 14,
                  onChanged: (v) => setState(() => _throttleMs = v.round()),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(onPressed: () => _commit('a'), child: const Text('Commit "a"')),
                    FilledButton(onPressed: () => _commit('b'), child: const Text('Commit "b"')),
                    FilledButton(onPressed: () => _commit('!'), child: const Text('Commit "!"')),
                    OutlinedButton(onPressed: _undo, child: const Text('Undo')),
                    OutlinedButton(onPressed: _redo, child: const Text('Redo')),
                  ],
                ),
                const SizedBox(height: 8),
                Text('canUndo: ${_controller.value.canUndo} | canRedo: ${_controller.value.canRedo}'),
                Text('timeline length: ${_timeline.length} | pointer: $_pointer | clock: $_clock ms'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFECFEFF),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Active Value', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFA5F3FC)),
                  ),
                  child: Text(active.isEmpty ? '(empty)' : active),
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
                const Text('Timeline Snapshots', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (var i = 0; i < _timeline.length; i++)
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: i == _pointer ? const Color(0xFFDBEAFE) : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('[$i] ${_timeline[i].isEmpty ? '(empty)' : _timeline[i]}'),
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
                const Text('Event Log', style: TextStyle(fontWeight: FontWeight.w800)),
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

class _FocusBindingPanel extends StatefulWidget {
  const _FocusBindingPanel();

  @override
  State<_FocusBindingPanel> createState() => _FocusBindingPanelState();
}

class _FocusBindingPanelState extends State<_FocusBindingPanel> {
  int _focusedIndex = 0;
  final List<_FocusRecord> _records = [
    _FocusRecord(name: 'Editor A', hasUndoScope: true, focusedValue: 'alpha'),
    _FocusRecord(name: 'Editor B', hasUndoScope: true, focusedValue: 'beta'),
    _FocusRecord(name: 'Inspector Panel', hasUndoScope: false, focusedValue: 'read-only'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _PrimeCard(
          title: 'Focus Binding and Scope',
          body:
              'UndoHistoryState should respond to the focused editing scope. '
              'This panel demonstrates how focused context routes undo commands.',
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
                for (var i = 0; i < _records.length; i++)
                  ChoiceChip(
                    label: Text(_records[i].name),
                    selected: _focusedIndex == i,
                    onSelected: (_) => setState(() => _focusedIndex = i),
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
                for (var i = 0; i < _records.length; i++)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: i == _focusedIndex ? const Color(0xFFD1FAE5) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: i == _focusedIndex ? const Color(0xFF10B981) : const Color(0xFFCBD5E1)),
                    ),
                    child: Text(
                      '${_records[i].name}: '
                      'hasUndoScope=${_records[i].hasUndoScope}, '
                      'focusedValue=${_records[i].focusedValue}',
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

class _ActionRoutingPanel extends StatelessWidget {
  const _ActionRoutingPanel();

  @override
  Widget build(BuildContext context) {
    final rows = <_RouteRow>[
      const _RouteRow('Ctrl/Cmd + Z', 'UndoTextIntent', 'Undo command for focused editor scope.'),
      const _RouteRow('Ctrl/Cmd + Shift + Z', 'RedoTextIntent', 'Redo command after at least one undo.'),
      const _RouteRow('Toolbar Undo', 'Undo trigger action', 'UI button mirrors keyboard intent path.'),
      const _RouteRow('Toolbar Redo', 'Redo trigger action', 'UI button enabled by controller canRedo.'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _PrimeCard(
          title: 'Action Routing Matrix',
          body:
              'UndoHistoryState participates in Actions/Shortcuts routing so input '
              'methods and UI commands converge into the same undo engine.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8F0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Expanded(child: Text('Input', style: TextStyle(fontWeight: FontWeight.w800))),
                      Expanded(child: Text('Intent/Action', style: TextStyle(fontWeight: FontWeight.w800))),
                      Expanded(child: Text('Effect', style: TextStyle(fontWeight: FontWeight.w800))),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                for (final row in rows)
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(row.input)),
                        Expanded(child: Text(row.intent)),
                        Expanded(child: Text(row.effect)),
                      ],
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

class _PrimeCard extends StatelessWidget {
  const _PrimeCard({required this.title, required this.body});

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

class _DataCard extends StatelessWidget {
  const _DataCard({required this.title, required this.tone, required this.bullets});

  final String title;
  final Color tone;
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
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: tone)),
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

class _NumberSlider extends StatelessWidget {
  const _NumberSlider({
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

class _FocusRecord {
  _FocusRecord({required this.name, required this.hasUndoScope, required this.focusedValue});

  final String name;
  final bool hasUndoScope;
  final String focusedValue;
}

class _RouteRow {
  const _RouteRow(this.input, this.intent, this.effect);

  final String input;
  final String intent;
  final String effect;
}
