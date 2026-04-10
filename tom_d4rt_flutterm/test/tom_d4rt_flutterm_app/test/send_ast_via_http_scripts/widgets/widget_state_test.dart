import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetStateDeepDemo();
}

const Color _kStateBar = Color(0xFF1F2937);
const Color _kStateCanvas = Color(0xFFF8FAFC);

class _WidgetStateDeepDemo extends StatefulWidget {
  const _WidgetStateDeepDemo();

  @override
  State<_WidgetStateDeepDemo> createState() => _WidgetStateDeepDemoState();
}

class _WidgetStateDeepDemoState extends State<_WidgetStateDeepDemo>
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
      backgroundColor: _kStateCanvas,
      appBar: AppBar(
        backgroundColor: _kStateBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetState Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'State Primer'),
            Tab(text: 'Atlas'),
            Tab(text: 'Set Composer'),
            Tab(text: 'Constraint Lab'),
            Tab(text: 'Applied Scenes'),
            Tab(text: 'Telemetry'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _StatePrimerPanel(),
          _StateAtlasPanel(),
          _SetComposerPanel(),
          _ConstraintLabPanel(),
          _AppliedScenesPanel(),
          _TelemetryPanel(),
        ],
      ),
    );
  }
}

class _StatePrimerPanel extends StatelessWidget {
  const _StatePrimerPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _StateCard(
          title: 'WidgetState in one sentence',
          tone: Color(0xFF1D4ED8),
          body:
              'WidgetState describes interaction and semantic conditions used '
              'to resolve UI styles. A single state or a set of states drives '
              'properties like color, shape, cursor, padding, and typography.',
        ),
        SizedBox(height: 12),
        _StateCard(
          title: 'Why state sets matter',
          tone: Color(0xFF047857),
          body:
              'Real interactions overlap. A control can be hovered and focused, '
              'or pressed and selected. WidgetStateProperty systems evaluate '
              'entire sets, not isolated states, so precedence design matters.',
        ),
        SizedBox(height: 12),
        _StateBulletCard(
          title: 'Core states',
          tone: Color(0xFF7C3AED),
          items: [
            'hovered: pointer is currently over the widget.',
            'focused: keyboard or accessibility focus is active.',
            'pressed: a primary gesture is currently active.',
            'selected: the widget is in chosen/toggled state.',
            'disabled: interaction is unavailable.',
            'error: component indicates invalid or failed condition.',
          ],
        ),
        SizedBox(height: 12),
        _StateBulletCard(
          title: 'Design discipline',
          tone: Color(0xFFB91C1C),
          items: [
            'Define deterministic precedence for conflicting states.',
            'Ensure disabled semantics win over cosmetic states.',
            'Preserve readability and contrast under all combinations.',
            'Log active sets when debugging unexpected visuals.',
          ],
        ),
        SizedBox(height: 12),
        _StateCodeCard(),
      ],
    );
  }
}

class _StateAtlasPanel extends StatelessWidget {
  const _StateAtlasPanel();

  Color _stateColor(WidgetState state) {
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

  String _stateDescription(WidgetState state) {
    switch (state) {
      case WidgetState.hovered:
        return 'Pointer discovery state for desktop and web surfaces.';
      case WidgetState.focused:
        return 'Keyboard or accessibility focus indicator state.';
      case WidgetState.pressed:
        return 'Gesture in progress, typically short-lived feedback.';
      case WidgetState.dragged:
        return 'Object is currently being dragged in a gesture flow.';
      case WidgetState.selected:
        return 'Persistent user choice retained across frames.';
      case WidgetState.scrolledUnder:
        return 'A top surface is overlapped by scrolling content beneath.';
      case WidgetState.disabled:
        return 'No interaction allowed; semantics should communicate inactivity.';
      case WidgetState.error:
        return 'Invalid state or failed validation requiring clear affordance.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.25,
      children: [
        for (final state in WidgetState.values)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _stateColor(state).withValues(alpha: 0.82),
                  _stateColor(state),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _stateDescription(state),
                  style: const TextStyle(color: Colors.white, height: 1.3),
                ),
                const Spacer(),
                Text(
                  'isSatisfiedBy({${state.name}}): '
                  '${state.isSatisfiedBy({state})}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 12,
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
  final List<String> _history = <String>['Set composer ready.'];

  final WidgetStateProperty<Color> _background =
      WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return const Color(0xFF94A3B8);
    }
    if (states.contains(WidgetState.error)) {
      return const Color(0xFFB91C1C);
    }
    if (states.contains(WidgetState.pressed)) {
      return const Color(0xFF0EA5E9);
    }
    if (states.contains(WidgetState.selected)) {
      return const Color(0xFF16A34A);
    }
    if (states.contains(WidgetState.hovered)) {
      return const Color(0xFF2563EB);
    }
    if (states.contains(WidgetState.focused)) {
      return const Color(0xFF7C3AED);
    }
    return const Color(0xFF334155);
  });

  final WidgetStateProperty<String> _message =
      WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return 'Unavailable action state';
    }
    if (states.contains(WidgetState.error)) {
      return 'Error highlight state';
    }
    if (states.contains(WidgetState.pressed)) {
      return 'Active gesture state';
    }
    if (states.contains(WidgetState.selected)) {
      return 'Persistent selection state';
    }
    if (states.contains(WidgetState.hovered)) {
      return 'Pointer hover state';
    }
    if (states.contains(WidgetState.focused)) {
      return 'Keyboard focus state';
    }
    return 'Idle base state';
  });

  void _toggle(WidgetState state, bool enabled) {
    setState(() {
      if (enabled) {
        _active.add(state);
      } else {
        _active.remove(state);
      }
      _history.add(
        '${DateTime.now().toIso8601String()} -> ${state.name}:$enabled => ${_message.resolve(_active)}',
      );
      if (_history.length > 24) {
        _history.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = _background.resolve(_active);
    final message = _message.resolve(_active);

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
                        'Compose a state set',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      for (final state in const [
                        WidgetState.hovered,
                        WidgetState.focused,
                        WidgetState.pressed,
                        WidgetState.selected,
                        WidgetState.error,
                        WidgetState.disabled,
                        WidgetState.dragged,
                        WidgetState.scrolledUnder,
                      ])
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(state.name),
                          subtitle: Text('${state.name}.isSatisfiedBy(active)'),
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
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    height: 160,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        '$message\n\nActive: ${_active.map((e) => e.name).join(', ').ifEmpty('none')}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
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
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final text = _history[_history.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    text,
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

class _ConstraintLabPanel extends StatelessWidget {
  const _ConstraintLabPanel();

  @override
  Widget build(BuildContext context) {
    final samples = <({String name, Set<WidgetState> set})>[
      (name: 'empty', set: <WidgetState>{}),
      (name: 'hovered', set: {WidgetState.hovered}),
      (name: 'focused+hovered', set: {WidgetState.focused, WidgetState.hovered}),
      (name: 'pressed+selected', set: {WidgetState.pressed, WidgetState.selected}),
      (name: 'error+focused', set: {WidgetState.error, WidgetState.focused}),
      (name: 'disabled', set: {WidgetState.disabled}),
      (
        name: 'mixed',
        set: {
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.pressed,
          WidgetState.selected,
        },
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const _StateCard(
          title: 'Constraint evaluation matrix',
          tone: Color(0xFF1E40AF),
          body:
              'WidgetState values implement WidgetStatesConstraint. This matrix '
              'shows how each constraint reports matches for representative '
              'state sets, including WidgetState.any fallback behavior.',
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
              DataColumn(label: Text('disabled')),
              DataColumn(label: Text('any')),
            ],
            rows: [
              for (final sample in samples)
                DataRow(
                  cells: [
                    DataCell(Text(sample.name)),
                    DataCell(Text(WidgetState.hovered.isSatisfiedBy(sample.set).toString())),
                    DataCell(Text(WidgetState.focused.isSatisfiedBy(sample.set).toString())),
                    DataCell(Text(WidgetState.pressed.isSatisfiedBy(sample.set).toString())),
                    DataCell(Text(WidgetState.disabled.isSatisfiedBy(sample.set).toString())),
                    DataCell(Text(WidgetState.any.isSatisfiedBy(sample.set).toString())),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AppliedScenesPanel extends StatelessWidget {
  const _AppliedScenesPanel();

  Color _resolveSceneColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return const Color(0xFF94A3B8);
    }
    if (states.contains(WidgetState.error)) {
      return const Color(0xFFB91C1C);
    }
    if (states.contains(WidgetState.pressed)) {
      return const Color(0xFF0EA5E9);
    }
    if (states.contains(WidgetState.selected)) {
      return const Color(0xFF16A34A);
    }
    if (states.contains(WidgetState.hovered)) {
      return const Color(0xFF2563EB);
    }
    return const Color(0xFF334155);
  }

  @override
  Widget build(BuildContext context) {
    final scenes = <({String title, Set<WidgetState> states, String note})>[
      (
        title: 'Toolbar button',
        states: {WidgetState.hovered},
        note: 'Desktop hover cue before activation.',
      ),
      (
        title: 'Submit action',
        states: {WidgetState.pressed},
        note: 'Transient press feedback during click/tap.',
      ),
      (
        title: 'Navigation item',
        states: {WidgetState.selected},
        note: 'Persistent selected status across route changes.',
      ),
      (
        title: 'Form field',
        states: {WidgetState.focused},
        note: 'Keyboard focus for accessibility workflows.',
      ),
      (
        title: 'Validation tile',
        states: {WidgetState.error},
        note: 'Error conditions override neutral visuals.',
      ),
      (
        title: 'Blocked operation',
        states: {WidgetState.disabled},
        note: 'Disabled semantic with reduced action signals.',
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.25,
      children: [
        for (final scene in scenes)
          Container(
            decoration: BoxDecoration(
              color: _resolveSceneColor(scene.states),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scene.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  scene.note,
                  style: const TextStyle(color: Colors.white, height: 1.3),
                ),
                const Spacer(),
                Text(
                  'States: ${scene.states.map((e) => e.name).join(', ')}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _TelemetryPanel extends StatefulWidget {
  const _TelemetryPanel();

  @override
  State<_TelemetryPanel> createState() => _TelemetryPanelState();
}

class _TelemetryPanelState extends State<_TelemetryPanel> {
  final List<String> _messages = <String>['Telemetry ready.'];

  void _capture(Set<WidgetState> states) {
    setState(() {
      _messages.add(
        '${DateTime.now().toIso8601String()} -> set:{${states.map((e) => e.name).join(', ').ifEmpty('none')}} | any:${WidgetState.any.isSatisfiedBy(states)}',
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
              onPressed: () => _capture(<WidgetState>{}),
              child: const Text('Capture none'),
            ),
            ElevatedButton(
              onPressed: () => _capture({WidgetState.hovered}),
              child: const Text('Capture hovered'),
            ),
            ElevatedButton(
              onPressed: () => _capture({WidgetState.pressed}),
              child: const Text('Capture pressed'),
            ),
            ElevatedButton(
              onPressed: () => _capture({WidgetState.error, WidgetState.focused}),
              child: const Text('Capture error+focused'),
            ),
            ElevatedButton(
              onPressed: () => _capture({WidgetState.disabled}),
              child: const Text('Capture disabled'),
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

class _StateCard extends StatelessWidget {
  const _StateCard({
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

class _StateBulletCard extends StatelessWidget {
  const _StateBulletCard({
    required this.title,
    required this.tone,
    required this.items,
  });

  final String title;
  final Color tone;
  final List<String> items;

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
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: tone)),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StateCodeCard extends StatelessWidget {
  const _StateCodeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF020617),
      child: const Padding(
        padding: EdgeInsets.all(14),
        child: Text(
          'final color = WidgetStateProperty.resolveWith((states) {\n'
          '  if (states.contains(WidgetState.disabled)) {\n'
          '    return const Color(0xFF94A3B8);\n'
          '  }\n'
          '  if (states.contains(WidgetState.pressed)) {\n'
          '    return const Color(0xFF0EA5E9);\n'
          '  }\n'
          '  return const Color(0xFF334155);\n'
          '});',
          style: TextStyle(
            color: Color(0xFF86EFAC),
            fontFamily: 'monospace',
            height: 1.35,
          ),
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
