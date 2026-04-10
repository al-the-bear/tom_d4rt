import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetStateMouseCursorDeepDemo();
}

const Color _kCursorBar = Color(0xFF1E293B);
const Color _kCursorCanvas = Color(0xFFF1F5F9);

class _WidgetStateMouseCursorDeepDemo extends StatefulWidget {
  const _WidgetStateMouseCursorDeepDemo();

  @override
  State<_WidgetStateMouseCursorDeepDemo> createState() =>
      _WidgetStateMouseCursorDeepDemoState();
}

class _WidgetStateMouseCursorDeepDemoState
    extends State<_WidgetStateMouseCursorDeepDemo>
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
      backgroundColor: _kCursorCanvas,
      appBar: AppBar(
        backgroundColor: _kCursorBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetStateMouseCursor Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Primer'),
            Tab(text: 'State Switchboard'),
            Tab(text: 'Cursor Zones'),
            Tab(text: 'Resolver Comparisons'),
            Tab(text: 'UX Guidance'),
            Tab(text: 'Trace Console'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _CursorPrimerPanel(),
          _StateSwitchboardPanel(),
          _CursorZonesPanel(),
          _ResolverComparisonPanel(),
          _UxGuidancePanel(),
          _TraceConsolePanel(),
        ],
      ),
    );
  }
}

class _CursorPrimerPanel extends StatelessWidget {
  const _CursorPrimerPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _CursorInfoCard(
          title: 'What WidgetStateMouseCursor solves',
          body:
              'WidgetStateMouseCursor allows one declarative cursor policy '
              'that adapts to widget states like hovered, pressed, and disabled. '
              'This keeps pointer behavior aligned with visual semantics.',
          tone: Color(0xFF1D4ED8),
        ),
        SizedBox(height: 12),
        _CursorInfoCard(
          title: 'Core variants',
          body:
              'clickable, textable, adaptiveClickable, and resolveWith are the '
              'main options. They cover standard interactions and advanced '
              'state-specific cursor choreography.',
          tone: Color(0xFF047857),
        ),
        SizedBox(height: 12),
        _CursorBulletCard(
          title: 'Practical usage targets',
          tone: Color(0xFF7C3AED),
          points: [
            'Button clusters and segmented controls.',
            'Selectable cards and list rows on desktop/web.',
            'Text editing surfaces and rich text components.',
            'Mixed enable/disable states in enterprise forms.',
          ],
        ),
        SizedBox(height: 12),
        _CursorBulletCard(
          title: 'Common failures',
          tone: Color(0xFFB91C1C),
          points: [
            'Disabled controls still showing click cursor.',
            'Hover affordance missing in desktop interactions.',
            'Text fields using click instead of text cursor.',
            'Inconsistent cursor policies across related components.',
          ],
        ),
        SizedBox(height: 12),
        _CursorCodeCard(),
      ],
    );
  }
}

class _StateSwitchboardPanel extends StatefulWidget {
  const _StateSwitchboardPanel();

  @override
  State<_StateSwitchboardPanel> createState() => _StateSwitchboardPanelState();
}

class _StateSwitchboardPanelState extends State<_StateSwitchboardPanel> {
  final Set<WidgetState> _states = <WidgetState>{};
  final List<String> _events = <String>[
    'Switchboard started.',
    'Toggle states to resolve cursor policies.',
  ];

  final WidgetStateMouseCursor _custom = WidgetStateMouseCursor.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return SystemMouseCursors.forbidden;
    }
    if (states.contains(WidgetState.error)) {
      return SystemMouseCursors.help;
    }
    if (states.contains(WidgetState.pressed)) {
      return SystemMouseCursors.grabbing;
    }
    if (states.contains(WidgetState.hovered)) {
      return SystemMouseCursors.click;
    }
    if (states.contains(WidgetState.focused)) {
      return SystemMouseCursors.precise;
    }
    return SystemMouseCursors.basic;
  });

  void _setStateValue(WidgetState state, bool enabled) {
    setState(() {
      if (enabled) {
        _states.add(state);
      } else {
        _states.remove(state);
      }
      _events.add('${DateTime.now().toIso8601String()} -> ${state.name}:$enabled');
      if (_events.length > 25) {
        _events.removeAt(0);
      }
    });
  }

  String _cursorName(MouseCursor cursor) {
    return cursor.debugDescription;
  }

  @override
  Widget build(BuildContext context) {
    final clickableResolved = WidgetStateMouseCursor.clickable.resolve(_states);
    final textableResolved = WidgetStateMouseCursor.textable.resolve(_states);
    final adaptiveResolved = WidgetStateMouseCursor.adaptiveClickable.resolve(_states);
    final customResolved = _custom.resolve(_states);

    return Row(
      children: [
        Expanded(
          flex: 5,
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
                        'State toggles',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      for (final state in const [
                        WidgetState.hovered,
                        WidgetState.focused,
                        WidgetState.pressed,
                        WidgetState.error,
                        WidgetState.disabled,
                      ])
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(state.name),
                          subtitle: Text('Include ${state.name} in resolution set.'),
                          value: _states.contains(state),
                          onChanged: (value) => _setStateValue(state, value),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resolved cursors',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 10),
                      _CursorRow(
                        label: 'clickable',
                        value: _cursorName(clickableResolved),
                        color: const Color(0xFF1D4ED8),
                      ),
                      _CursorRow(
                        label: 'textable',
                        value: _cursorName(textableResolved),
                        color: const Color(0xFF0F766E),
                      ),
                      _CursorRow(
                        label: 'adaptiveClickable',
                        value: _cursorName(adaptiveResolved),
                        color: const Color(0xFF9333EA),
                      ),
                      _CursorRow(
                        label: 'custom resolveWith',
                        value: _cursorName(customResolved),
                        color: const Color(0xFFB45309),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              MouseRegion(
                cursor: customResolved,
                child: Card(
                  color: const Color(0xFF0F172A),
                  child: const SizedBox(
                    height: 140,
                    child: Center(
                      child: Text(
                        'Hover this preview surface\nwith resolved custom cursor',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFBAE6FD),
                          fontWeight: FontWeight.w700,
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
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final msg = _events[_events.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    msg,
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

class _CursorZonesPanel extends StatelessWidget {
  const _CursorZonesPanel();

  @override
  Widget build(BuildContext context) {
    final zones = <({String title, MouseCursor cursor, Color color, String text})>[
      (
        title: 'Navigation tile',
        cursor: SystemMouseCursors.click,
        color: const Color(0xFF1D4ED8),
        text: 'Use click cursor for actionable tiles.',
      ),
      (
        title: 'Text editor strip',
        cursor: SystemMouseCursors.text,
        color: const Color(0xFF0F766E),
        text: 'Text cursor communicates editable content.',
      ),
      (
        title: 'Drag handle',
        cursor: SystemMouseCursors.grab,
        color: const Color(0xFF7C3AED),
        text: 'Grab cursor advertises reordering affordance.',
      ),
      (
        title: 'Disabled region',
        cursor: SystemMouseCursors.forbidden,
        color: const Color(0xFFB91C1C),
        text: 'Forbidden cursor clarifies unavailable action.',
      ),
      (
        title: 'Precision canvas',
        cursor: SystemMouseCursors.precise,
        color: const Color(0xFFCA8A04),
        text: 'Precise cursor helps plotting and design tasks.',
      ),
      (
        title: 'Help hotspot',
        cursor: SystemMouseCursors.help,
        color: const Color(0xFF0F766E),
        text: 'Help cursor signals discoverable guidance.',
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        for (final zone in zones)
          MouseRegion(
            cursor: zone.cursor,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [zone.color.withValues(alpha: 0.84), zone.color],
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
                    zone.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cursor: ${zone.cursor.debugDescription}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const Spacer(),
                  Text(
                    zone.text,
                    style: const TextStyle(color: Colors.white, height: 1.3),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ResolverComparisonPanel extends StatelessWidget {
  const _ResolverComparisonPanel();

  @override
  Widget build(BuildContext context) {
    final scenarios = <({String name, Set<WidgetState> states})>[
      (name: 'Idle', states: <WidgetState>{}),
      (name: 'Hovered', states: {WidgetState.hovered}),
      (name: 'Pressed', states: {WidgetState.pressed}),
      (name: 'Focused', states: {WidgetState.focused}),
      (name: 'Disabled', states: {WidgetState.disabled}),
      (name: 'Error', states: {WidgetState.error}),
      (name: 'Hovered+Pressed', states: {WidgetState.hovered, WidgetState.pressed}),
    ];

    final custom = WidgetStateMouseCursor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      if (states.contains(WidgetState.error)) {
        return SystemMouseCursors.help;
      }
      if (states.contains(WidgetState.pressed)) {
        return SystemMouseCursors.grabbing;
      }
      if (states.contains(WidgetState.hovered)) {
        return SystemMouseCursors.click;
      }
      return SystemMouseCursors.basic;
    });

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const _CursorInfoCard(
          title: 'Resolver output matrix',
          body:
              'Compare built-in and custom resolvers side-by-side to ensure '
              'your chosen strategy matches component intent and platform behavior.',
          tone: Color(0xFF1E40AF),
        ),
        const SizedBox(height: 10),
        Card(
          clipBehavior: Clip.antiAlias,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Scenario')),
              DataColumn(label: Text('clickable')),
              DataColumn(label: Text('textable')),
              DataColumn(label: Text('adaptive')),
              DataColumn(label: Text('custom')),
            ],
            rows: [
              for (final scenario in scenarios)
                DataRow(
                  cells: [
                    DataCell(Text(scenario.name)),
                    DataCell(
                      Text(WidgetStateMouseCursor.clickable.resolve(scenario.states).debugDescription),
                    ),
                    DataCell(
                      Text(WidgetStateMouseCursor.textable.resolve(scenario.states).debugDescription),
                    ),
                    DataCell(
                      Text(
                        WidgetStateMouseCursor.adaptiveClickable
                            .resolve(scenario.states)
                            .debugDescription,
                      ),
                    ),
                    DataCell(Text(custom.resolve(scenario.states).debugDescription)),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UxGuidancePanel extends StatelessWidget {
  const _UxGuidancePanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: const [
        _CursorInfoCard(
          title: 'Guideline 1: Cursor equals promise',
          body:
              'Only present action cursors when interaction is truly available. '
              'Users trust pointer feedback as a contract of what can happen next.',
          tone: Color(0xFF047857),
        ),
        SizedBox(height: 10),
        _CursorInfoCard(
          title: 'Guideline 2: Disabled clarity',
          body:
              'Disabled controls should visually and behaviorally indicate no '
              'interaction. Use basic or forbidden cursors consistently.',
          tone: Color(0xFFB45309),
        ),
        SizedBox(height: 10),
        _CursorInfoCard(
          title: 'Guideline 3: Text contexts',
          body:
              'Editable and selectable text zones should resolve to text cursors. '
              'This reduces hesitation in data-heavy workflows.',
          tone: Color(0xFF1D4ED8),
        ),
        SizedBox(height: 10),
        _CursorBulletCard(
          title: 'Rollout checklist',
          tone: Color(0xFF9333EA),
          points: [
            'Document cursor policy per component family.',
            'Validate with keyboard-focused accessibility flows.',
            'Review desktop and web parity in staging demos.',
            'Capture trace logs when a cursor mismatch is reported.',
          ],
        ),
      ],
    );
  }
}

class _TraceConsolePanel extends StatefulWidget {
  const _TraceConsolePanel();

  @override
  State<_TraceConsolePanel> createState() => _TraceConsolePanelState();
}

class _TraceConsolePanelState extends State<_TraceConsolePanel> {
  final List<String> _messages = <String>[
    'Trace console ready.',
  ];

  final WidgetStateMouseCursor _resolver = WidgetStateMouseCursor.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return SystemMouseCursors.forbidden;
    }
    if (states.contains(WidgetState.pressed)) {
      return SystemMouseCursors.grabbing;
    }
    if (states.contains(WidgetState.hovered)) {
      return SystemMouseCursors.click;
    }
    if (states.contains(WidgetState.focused)) {
      return SystemMouseCursors.precise;
    }
    return SystemMouseCursors.basic;
  });

  void _log(Set<WidgetState> states) {
    final resolved = _resolver.resolve(states);
    setState(() {
      _messages.add(
        '${DateTime.now().toIso8601String()} | ${states.map((e) => e.name).join(', ').ifEmpty('none')} -> ${resolved.debugDescription}',
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
              child: const Text('Log default'),
            ),
            ElevatedButton(
              onPressed: () => _log({WidgetState.hovered}),
              child: const Text('Log hovered'),
            ),
            ElevatedButton(
              onPressed: () => _log({WidgetState.focused}),
              child: const Text('Log focused'),
            ),
            ElevatedButton(
              onPressed: () => _log({WidgetState.pressed}),
              child: const Text('Log pressed'),
            ),
            ElevatedButton(
              onPressed: () => _log({WidgetState.disabled}),
              child: const Text('Log disabled'),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    _messages[_messages.length - 1 - index],
                    style: const TextStyle(
                      color: Color(0xFFFDE68A),
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

class _CursorInfoCard extends StatelessWidget {
  const _CursorInfoCard({
    required this.title,
    required this.body,
    required this.tone,
  });

  final String title;
  final String body;
  final Color tone;

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
              style: TextStyle(
                color: tone,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(body, style: const TextStyle(height: 1.4)),
          ],
        ),
      ),
    );
  }
}

class _CursorBulletCard extends StatelessWidget {
  const _CursorBulletCard({
    required this.title,
    required this.tone,
    required this.points,
  });

  final String title;
  final Color tone;
  final List<String> points;

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
            for (final point in points)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: tone)),
                    Expanded(child: Text(point)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CursorCodeCard extends StatelessWidget {
  const _CursorCodeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF020617),
      child: const Padding(
        padding: EdgeInsets.all(14),
        child: Text(
          'final resolver = WidgetStateMouseCursor.resolveWith((states) {\n'
          '  if (states.contains(WidgetState.disabled)) {\n'
          '    return SystemMouseCursors.forbidden;\n'
          '  }\n'
          '  if (states.contains(WidgetState.hovered)) {\n'
          '    return SystemMouseCursors.click;\n'
          '  }\n'
          '  return SystemMouseCursors.basic;\n'
          '});',
          style: TextStyle(
            color: Color(0xFF7DD3FC),
            fontFamily: 'monospace',
            height: 1.35,
          ),
        ),
      ),
    );
  }
}

class _CursorRow extends StatelessWidget {
  const _CursorRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

extension on String {
  String ifEmpty(String fallback) {
    return isEmpty ? fallback : this;
  }
}
