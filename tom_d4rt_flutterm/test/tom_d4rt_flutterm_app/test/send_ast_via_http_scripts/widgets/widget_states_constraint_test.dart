import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetStatesConstraintDeepDemo();
}

const Color _kConstraintBar = Color(0xFF0F172A);
const Color _kConstraintCanvas = Color(0xFFF8FAFC);

class _WidgetStatesConstraintDeepDemo extends StatefulWidget {
  const _WidgetStatesConstraintDeepDemo();

  @override
  State<_WidgetStatesConstraintDeepDemo> createState() =>
      _WidgetStatesConstraintDeepDemoState();
}

class _WidgetStatesConstraintDeepDemoState
    extends State<_WidgetStatesConstraintDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kConstraintCanvas,
      appBar: AppBar(
        backgroundColor: _kConstraintBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetStatesConstraint Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Foundation'),
            Tab(text: 'Constraint Atlas'),
            Tab(text: 'Set Composer'),
            Tab(text: 'Truth Table'),
            Tab(text: 'Applied Resolver'),
            Tab(text: 'Trace Console'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _FoundationPanel(),
          _ConstraintAtlasPanel(),
          _SetComposerPanel(),
          _TruthTablePanel(),
          _AppliedResolverPanel(),
          _ConstraintTracePanel(),
        ],
      ),
    );
  }
}

class _FoundationPanel extends StatelessWidget {
  const _FoundationPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _ConstraintCard(
          title: 'What WidgetStatesConstraint defines',
          tone: Color(0xFF1D4ED8),
          body:
              'WidgetStatesConstraint is the contract behind state matching. '
              'It answers whether a candidate state set satisfies a given '
              'constraint using isSatisfiedBy(Set<WidgetState>).',
        ),
        SizedBox(height: 12),
        _ConstraintCard(
          title: 'How Flutter uses it',
          tone: Color(0xFF047857),
          body:
              'WidgetState values and WidgetState.any behave as constraints. '
              'They are used as keys in state maps and in custom resolution '
              'logic for colors, typography, borders, cursors, and more.',
        ),
        SizedBox(height: 12),
        _ConstraintBulletCard(
          title: 'Design principles',
          tone: Color(0xFF7C3AED),
          bullets: [
            'Model explicit precedence between conflicting states.',
            'Always provide deterministic fallback behavior.',
            'Keep disabled semantics stronger than cosmetic states.',
            'Expose trace output when debugging state mismatches.',
          ],
        ),
        SizedBox(height: 12),
        _ConstraintBulletCard(
          title: 'Failure patterns',
          tone: Color(0xFFB91C1C),
          bullets: [
            'Assuming hover and pressed cannot coexist in matching flows.',
            'Missing any/fallback path for empty state sets.',
            'Using inconsistent ordering across component families.',
            'Not logging actual active state set at render time.',
          ],
        ),
      ],
    );
  }
}

class _ConstraintAtlasPanel extends StatelessWidget {
  const _ConstraintAtlasPanel();

  Color _tone(WidgetState state) {
    switch (state) {
      case WidgetState.hovered:
        return const Color(0xFF2563EB);
      case WidgetState.focused:
        return const Color(0xFF7C3AED);
      case WidgetState.pressed:
        return const Color(0xFF0EA5E9);
      case WidgetState.dragged:
        return const Color(0xFF0F766E);
      case WidgetState.selected:
        return const Color(0xFF16A34A);
      case WidgetState.scrolledUnder:
        return const Color(0xFFCA8A04);
      case WidgetState.disabled:
        return const Color(0xFF64748B);
      case WidgetState.error:
        return const Color(0xFFB91C1C);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.28,
      children: [
        for (final state in WidgetState.values)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_tone(state).withValues(alpha: 0.82), _tone(state)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Constraint type: WidgetState',
                  style: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                Text(
                  'isSatisfiedBy({${state.name}}): ${state.isSatisfiedBy({state})}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF334155), Color(0xFF0F172A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'any',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Constraint type: WidgetState.any',
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              Text(
                'Always matches every state set.',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SetComposerPanel extends StatefulWidget {
  const _SetComposerPanel();

  @override
  State<_SetComposerPanel> createState() => _SetComposerPanelState();
}

class _SetComposerPanelState extends State<_SetComposerPanel> {
  final Set<WidgetState> _active = <WidgetState>{};
  final List<String> _events = <String>['Composer initialized.'];

  void _toggle(WidgetState state, bool value) {
    setState(() {
      if (value) {
        _active.add(state);
      } else {
        _active.remove(state);
      }
      _events.add(
        '${DateTime.now().toIso8601String()} -> ${state.name}:$value | any=${WidgetState.any.isSatisfiedBy(_active)}',
      );
      if (_events.length > 24) {
        _events.removeAt(0);
      }
    });
  }

  Widget _truthChip(String label, bool result) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: result ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$label: $result',
        style: TextStyle(
          color: result ? const Color(0xFF166534) : const Color(0xFF991B1B),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Compose active state set',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      for (final state in WidgetState.values)
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(state.name),
                          subtitle: Text('Toggle ${state.name} in active set.'),
                          value: _active.contains(state),
                          onChanged: (value) => _toggle(state, value),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current set: ${_active.map((e) => e.name).join(', ').ifEmpty('none')}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _truthChip(
                            'hovered',
                            WidgetState.hovered.isSatisfiedBy(_active),
                          ),
                          _truthChip(
                            'focused',
                            WidgetState.focused.isSatisfiedBy(_active),
                          ),
                          _truthChip(
                            'pressed',
                            WidgetState.pressed.isSatisfiedBy(_active),
                          ),
                          _truthChip(
                            'disabled',
                            WidgetState.disabled.isSatisfiedBy(_active),
                          ),
                          _truthChip(
                            'error',
                            WidgetState.error.isSatisfiedBy(_active),
                          ),
                          _truthChip(
                            'any',
                            WidgetState.any.isSatisfiedBy(_active),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final line = _events[_events.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    line,
                    style: const TextStyle(
                      color: Color(0xFF86EFAC),
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _TruthTablePanel extends StatelessWidget {
  const _TruthTablePanel();

  @override
  Widget build(BuildContext context) {
    final samples = <({String name, Set<WidgetState> states})>[
      (name: 'empty', states: <WidgetState>{}),
      (name: 'hovered', states: {WidgetState.hovered}),
      (name: 'focused+hovered', states: {WidgetState.focused, WidgetState.hovered}),
      (name: 'pressed', states: {WidgetState.pressed}),
      (name: 'selected+pressed', states: {WidgetState.selected, WidgetState.pressed}),
      (name: 'error+focused', states: {WidgetState.error, WidgetState.focused}),
      (name: 'disabled', states: {WidgetState.disabled}),
      (
        name: 'large mix',
        states: {
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
          WidgetState.dragged,
        },
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const _ConstraintCard(
          title: 'Constraint truth table',
          tone: Color(0xFF1E40AF),
          body:
              'This matrix helps reason about state intersections. It is '
              'especially useful when debugging map entries where order and '
              'fallback produce unexpected visual results.',
        ),
        const SizedBox(height: 10),
        Card(
          clipBehavior: Clip.antiAlias,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Sample Set')),
              DataColumn(label: Text('hovered')),
              DataColumn(label: Text('focused')),
              DataColumn(label: Text('pressed')),
              DataColumn(label: Text('selected')),
              DataColumn(label: Text('disabled')),
              DataColumn(label: Text('any')),
            ],
            rows: [
              for (final sample in samples)
                DataRow(
                  cells: [
                    DataCell(Text(sample.name)),
                    DataCell(Text(WidgetState.hovered.isSatisfiedBy(sample.states).toString())),
                    DataCell(Text(WidgetState.focused.isSatisfiedBy(sample.states).toString())),
                    DataCell(Text(WidgetState.pressed.isSatisfiedBy(sample.states).toString())),
                    DataCell(Text(WidgetState.selected.isSatisfiedBy(sample.states).toString())),
                    DataCell(Text(WidgetState.disabled.isSatisfiedBy(sample.states).toString())),
                    DataCell(Text(WidgetState.any.isSatisfiedBy(sample.states).toString())),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AppliedResolverPanel extends StatelessWidget {
  const _AppliedResolverPanel();

  @override
  Widget build(BuildContext context) {
    final map = <WidgetStatesConstraint, ({Color color, String label})>{
      WidgetState.disabled: (color: const Color(0xFF94A3B8), label: 'disabled branch'),
      WidgetState.error: (color: const Color(0xFFDC2626), label: 'error branch'),
      WidgetState.pressed: (color: const Color(0xFF0EA5E9), label: 'pressed branch'),
      WidgetState.selected: (color: const Color(0xFF16A34A), label: 'selected branch'),
      WidgetState.hovered: (color: const Color(0xFF2563EB), label: 'hovered branch'),
      WidgetState.any: (color: const Color(0xFF334155), label: 'fallback branch'),
    };

    ({Color color, String label}) resolveFor(Set<WidgetState> states) {
      for (final entry in map.entries) {
        if (entry.key.isSatisfiedBy(states)) {
          return entry.value;
        }
      }
      return (color: const Color(0xFF000000), label: 'unreachable');
    }

    final scenarios = <({String title, Set<WidgetState> states, String note})>[
      (
        title: 'Idle state',
        states: <WidgetState>{},
        note: 'No explicit state; fallback branch should match.',
      ),
      (
        title: 'Hover action',
        states: {WidgetState.hovered},
        note: 'Hover branch selected by constraint match.',
      ),
      (
        title: 'Selection mode',
        states: {WidgetState.selected},
        note: 'Selected branch conveys persistent active choice.',
      ),
      (
        title: 'Press gesture',
        states: {WidgetState.pressed},
        note: 'Pressed branch gives immediate action feedback.',
      ),
      (
        title: 'Error and focus',
        states: {WidgetState.error, WidgetState.focused},
        note: 'Error branch takes precedence in map order.',
      ),
      (
        title: 'Disabled control',
        states: {WidgetState.disabled},
        note: 'Disabled branch wins and blocks cosmetic states.',
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        for (final scenario in scenarios)
          Builder(
            builder: (context) {
              final resolved = resolveFor(scenario.states);
              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: resolved.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scenario.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      scenario.note,
                      style: const TextStyle(color: Colors.white, height: 1.3),
                    ),
                    const Spacer(),
                    Text(
                      'Match: ${resolved.label}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}

class _ConstraintTracePanel extends StatefulWidget {
  const _ConstraintTracePanel();

  @override
  State<_ConstraintTracePanel> createState() => _ConstraintTracePanelState();
}

class _ConstraintTracePanelState extends State<_ConstraintTracePanel> {
  final List<String> _messages = <String>['Trace ready.'];

  void _log(Set<WidgetState> states) {
    final values = <String, bool>{
      'hovered': WidgetState.hovered.isSatisfiedBy(states),
      'focused': WidgetState.focused.isSatisfiedBy(states),
      'pressed': WidgetState.pressed.isSatisfiedBy(states),
      'disabled': WidgetState.disabled.isSatisfiedBy(states),
      'any': WidgetState.any.isSatisfiedBy(states),
    };
    setState(() {
      _messages.add(
        '${DateTime.now().toIso8601String()} | {${states.map((e) => e.name).join(', ').ifEmpty('none')}} => $values',
      );
      if (_messages.length > 20) {
        _messages.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => _log(<WidgetState>{}),
              child: const Text('Trace empty'),
            ),
            ElevatedButton(
              onPressed: () => _log({WidgetState.hovered}),
              child: const Text('Trace hovered'),
            ),
            ElevatedButton(
              onPressed: () => _log({WidgetState.focused, WidgetState.hovered}),
              child: const Text('Trace focused+hovered'),
            ),
            ElevatedButton(
              onPressed: () => _log({WidgetState.error, WidgetState.focused}),
              child: const Text('Trace error+focused'),
            ),
            ElevatedButton(
              onPressed: () => _log({WidgetState.disabled}),
              child: const Text('Trace disabled'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final line = _messages[_messages.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    line,
                    style: const TextStyle(
                      color: Color(0xFF93C5FD),
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ConstraintCard extends StatelessWidget {
  const _ConstraintCard({
    required this.title,
    required this.tone,
    required this.body,
  });

  final String title;
  final Color tone;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: tone, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(body, style: const TextStyle(height: 1.4)),
          ],
        ),
      ),
    );
  }
}

class _ConstraintBulletCard extends StatelessWidget {
  const _ConstraintBulletCard({
    required this.title,
    required this.tone,
    required this.bullets,
  });

  final String title;
  final Color tone;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: tone, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            for (final bullet in bullets)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('- ', style: TextStyle(color: tone)),
                    Expanded(child: Text(bullet)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

extension on String {
  String ifEmpty(String fallback) {
    return isEmpty ? fallback : this;
  }
}
