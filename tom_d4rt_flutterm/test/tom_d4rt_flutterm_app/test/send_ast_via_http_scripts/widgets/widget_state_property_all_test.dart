import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetStatePropertyAllDeepDemo();
}

const Color _kAllBar = Color(0xFF0F172A);
const Color _kAllCanvas = Color(0xFFF8FAFC);

class _WidgetStatePropertyAllDeepDemo extends StatefulWidget {
  const _WidgetStatePropertyAllDeepDemo();

  @override
  State<_WidgetStatePropertyAllDeepDemo> createState() =>
      _WidgetStatePropertyAllDeepDemoState();
}

class _WidgetStatePropertyAllDeepDemoState
    extends State<_WidgetStatePropertyAllDeepDemo>
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
      backgroundColor: _kAllCanvas,
      appBar: AppBar(
        backgroundColor: _kAllBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetStatePropertyAll Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Foundation'),
            Tab(text: 'State Stress Test'),
            Tab(text: 'Type Showcase'),
            Tab(text: 'Component Lab'),
            Tab(text: 'Usage Recipes'),
            Tab(text: 'Audit Console'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _AllFoundationPanel(),
          _StateStressPanel(),
          _TypeShowcasePanel(),
          _ComponentLabPanel(),
          _UsageRecipesPanel(),
          _AuditConsolePanel(),
        ],
      ),
    );
  }
}

class _AllFoundationPanel extends StatelessWidget {
  const _AllFoundationPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _AllInfoCard(
          title: 'What WidgetStatePropertyAll means',
          tone: Color(0xFF1D4ED8),
          body:
              'WidgetStatePropertyAll<T> is the simplest state property: it '
              'returns one constant value for every state set. It intentionally '
              'opts out of dynamic adaptation.',
        ),
        SizedBox(height: 12),
        _AllInfoCard(
          title: 'When to use it',
          tone: Color(0xFF047857),
          body:
              'Use it for stable tokens such as base paddings, fixed elevations, '
              'or shape defaults. It keeps style definitions compact and explicit '
              'when state variability is not needed.',
        ),
        SizedBox(height: 12),
        _AllBulletCard(
          title: 'Typical constant candidates',
          tone: Color(0xFF7C3AED),
          items: [
            'Elevation for flat icon buttons in low-emphasis contexts.',
            'Uniform chip padding shared across all states.',
            'Global typography baseline for label components.',
            'Fixed border radius for cards within one section.',
          ],
        ),
        SizedBox(height: 12),
        _AllBulletCard(
          title: 'Signals you need a dynamic property instead',
          tone: Color(0xFFB91C1C),
          items: [
            'Pressed state should visually differ from idle state.',
            'Disabled controls require reduced contrast.',
            'Focused fields need stronger outlines for accessibility.',
            'Error states require distinct styling semantics.',
          ],
        ),
        SizedBox(height: 12),
        _AllCodeCard(),
      ],
    );
  }
}

class _StateStressPanel extends StatefulWidget {
  const _StateStressPanel();

  @override
  State<_StateStressPanel> createState() => _StateStressPanelState();
}

class _StateStressPanelState extends State<_StateStressPanel> {
  final Set<WidgetState> _states = <WidgetState>{};
  final List<String> _events = <String>['Stress test initialized.'];

  final WidgetStatePropertyAll<Color> _color =
      const WidgetStatePropertyAll(Color(0xFF0EA5E9));
  final WidgetStatePropertyAll<double> _elevation =
      const WidgetStatePropertyAll(6.0);
  final WidgetStatePropertyAll<EdgeInsets> _padding =
      const WidgetStatePropertyAll(
    EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  );

  void _toggle(WidgetState state, bool value) {
    setState(() {
      if (value) {
        _states.add(state);
      } else {
        _states.remove(state);
      }
      _events.add('${DateTime.now().toIso8601String()} -> ${state.name}:$value');
      if (_events.length > 24) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = _color.resolve(_states);
    final elevation = _elevation.resolve(_states);
    final padding = _padding.resolve(_states);

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
                        'State toggles',
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
                      ])
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(state.name),
                          subtitle: const Text('Constant properties should not change.'),
                          value: _states.contains(state),
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
                    duration: const Duration(milliseconds: 220),
                    padding: padding,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.22),
                          blurRadius: elevation + 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Invariant style snapshot',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Active states: ${_states.map((e) => e.name).join(', ').ifEmpty('none')}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _AllMetric(label: 'Color', value: '#${color.toARGB32().toRadixString(16)}'),
                            _AllMetric(
                              label: 'Elevation',
                              value: elevation.toStringAsFixed(1),
                            ),
                            _AllMetric(
                              label: 'Padding H',
                              value: padding.horizontal.toStringAsFixed(1),
                            ),
                          ],
                        ),
                      ],
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
                final line = _events[_events.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    line,
                    style: const TextStyle(
                      color: Color(0xFFFDE68A),
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

class _TypeShowcasePanel extends StatelessWidget {
  const _TypeShowcasePanel();

  @override
  Widget build(BuildContext context) {
    const colorToken = WidgetStatePropertyAll<Color>(Color(0xFF2563EB));
    const numberToken = WidgetStatePropertyAll<double>(22.0);
    const edgeToken = WidgetStatePropertyAll<EdgeInsets>(
      EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    );
    const textToken = WidgetStatePropertyAll<TextStyle>(
      TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );
    const cursorToken = WidgetStatePropertyAll<MouseCursor>(
      SystemMouseCursors.click,
    );
    const shapeToken = WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        side: BorderSide(color: Color(0xFF1D4ED8), width: 2),
      ),
    );

    final sets = <({String name, Set<WidgetState> states})>[
      (name: 'None', states: <WidgetState>{}),
      (name: 'Hovered', states: {WidgetState.hovered}),
      (name: 'Focused', states: {WidgetState.focused}),
      (name: 'Pressed', states: {WidgetState.pressed}),
      (name: 'Disabled', states: {WidgetState.disabled}),
      (
        name: 'Mixed',
        states: {WidgetState.hovered, WidgetState.pressed, WidgetState.focused},
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const _AllInfoCard(
          title: 'Generic type coverage',
          tone: Color(0xFF1E40AF),
          body:
              'WidgetStatePropertyAll<T> supports many value types. This table '
              'shows that each type resolves identically across different state sets.',
        ),
        const SizedBox(height: 10),
        Card(
          clipBehavior: Clip.antiAlias,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('State Set')),
              DataColumn(label: Text('Color')),
              DataColumn(label: Text('Double')),
              DataColumn(label: Text('Padding')),
              DataColumn(label: Text('Cursor')),
            ],
            rows: [
              for (final set in sets)
                DataRow(
                  cells: [
                    DataCell(Text(set.name)),
                    DataCell(
                      Text('#${colorToken.resolve(set.states).toARGB32().toRadixString(16)}'),
                    ),
                    DataCell(Text(numberToken.resolve(set.states).toStringAsFixed(1))),
                    DataCell(
                      Text(edgeToken.resolve(set.states).horizontal.toStringAsFixed(1)),
                    ),
                    DataCell(Text(cursorToken.resolve(set.states).debugDescription)),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            MouseRegion(
              cursor: cursorToken.resolve(<WidgetState>{}),
              child: OutlinedButton(
                style: ButtonStyle(
                  side: WidgetStatePropertyAll(shapeToken.resolve(<WidgetState>{}).side),
                  shape: WidgetStatePropertyAll(shapeToken.resolve(<WidgetState>{})),
                  backgroundColor: WidgetStatePropertyAll(colorToken.resolve(<WidgetState>{})),
                  padding: WidgetStatePropertyAll(edgeToken.resolve(<WidgetState>{})),
                ),
                onPressed: () {},
                child: Text('Type showcase sample', style: textToken.resolve(<WidgetState>{})),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ComponentLabPanel extends StatelessWidget {
  const _ComponentLabPanel();

  @override
  Widget build(BuildContext context) {
    const cardPadding = WidgetStatePropertyAll<EdgeInsets>(
      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
    const cardBg = WidgetStatePropertyAll<Color>(Color(0xFF1D4ED8));
    const cardText = WidgetStatePropertyAll<TextStyle>(
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
    );
    const cardShape = WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        side: BorderSide(color: Color(0xFF60A5FA), width: 1.8),
      ),
    );

    final samples = <String>[
      'Project status card',
      'Approval summary card',
      'Launch readiness card',
      'Release notes card',
      'Customer alert card',
      'Migration summary card',
    ];

    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.25,
      children: [
        for (final sample in samples)
          Container(
            decoration: ShapeDecoration(
              color: cardBg.resolve(<WidgetState>{}),
              shape: cardShape.resolve(<WidgetState>{}),
            ),
            padding: cardPadding.resolve(<WidgetState>{}),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sample, style: cardText.resolve(<WidgetState>{})),
                const SizedBox(height: 8),
                Text(
                  'This card intentionally keeps styling fixed in all states. '
                  'It demonstrates deterministic token behavior with '
                  'WidgetStatePropertyAll.',
                  style: cardText.resolve(<WidgetState>{}).copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Constant style token set',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _UsageRecipesPanel extends StatelessWidget {
  const _UsageRecipesPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: const [
        _AllInfoCard(
          title: 'Recipe 1: Freeze baseline theme tokens',
          tone: Color(0xFF047857),
          body:
              'Use WidgetStatePropertyAll for baseline tokens first, then '
              'override only properties that truly require state adaptation. '
              'This keeps style systems clear and maintainable.',
        ),
        SizedBox(height: 10),
        _AllInfoCard(
          title: 'Recipe 2: Fast design experiments',
          tone: Color(0xFF1D4ED8),
          body:
              'When prototyping, lock several values with PropertyAll so teams '
              'can evaluate layout and color hierarchy before investing in '
              'fine-grained state-specific mappings.',
        ),
        SizedBox(height: 10),
        _AllInfoCard(
          title: 'Recipe 3: Shared infrastructure widgets',
          tone: Color(0xFF7C3AED),
          body:
              'Infrastructure widgets such as wrappers and shells often need '
              'consistent styling. PropertyAll eliminates accidental drift '
              'between interaction pathways.',
        ),
        SizedBox(height: 10),
        _AllBulletCard(
          title: 'Adoption checklist',
          tone: Color(0xFFB45309),
          items: [
            'Audit which tokens are truly state-dependent.',
            'Promote invariant tokens to PropertyAll wrappers.',
            'Document where dynamic state properties remain necessary.',
            'Monitor UX for over-constant visuals in interactive controls.',
          ],
        ),
      ],
    );
  }
}

class _AuditConsolePanel extends StatefulWidget {
  const _AuditConsolePanel();

  @override
  State<_AuditConsolePanel> createState() => _AuditConsolePanelState();
}

class _AuditConsolePanelState extends State<_AuditConsolePanel> {
  final List<String> _messages = <String>['Audit console ready.'];

  final WidgetStatePropertyAll<String> _messageToken =
      const WidgetStatePropertyAll<String>(
    'Constant token response from WidgetStatePropertyAll',
  );

  void _check(Set<WidgetState> states) {
    final result = _messageToken.resolve(states);
    setState(() {
      _messages.add(
        '${DateTime.now().toIso8601String()} -> ${states.map((e) => e.name).join(', ').ifEmpty('none')} => $result',
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
              onPressed: () => _check(<WidgetState>{}),
              child: const Text('Check default'),
            ),
            ElevatedButton(
              onPressed: () => _check({WidgetState.hovered}),
              child: const Text('Check hovered'),
            ),
            ElevatedButton(
              onPressed: () => _check({WidgetState.focused}),
              child: const Text('Check focused'),
            ),
            ElevatedButton(
              onPressed: () => _check({WidgetState.pressed}),
              child: const Text('Check pressed'),
            ),
            ElevatedButton(
              onPressed: () => _check({WidgetState.disabled}),
              child: const Text('Check disabled'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final line = _messages[_messages.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    line,
                    style: const TextStyle(
                      color: Color(0xFFBAE6FD),
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

class _AllInfoCard extends StatelessWidget {
  const _AllInfoCard({
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

class _AllBulletCard extends StatelessWidget {
  const _AllBulletCard({
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

class _AllCodeCard extends StatelessWidget {
  const _AllCodeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF020617),
      child: const Padding(
        padding: EdgeInsets.all(14),
        child: Text(
          'const padding = WidgetStatePropertyAll<EdgeInsets>(\n'
          '  EdgeInsets.symmetric(horizontal: 16, vertical: 10),\n'
          ');\n\n'
          'final value = padding.resolve(states);\n'
          '// value is identical for any state set',
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

class _AllMetric extends StatelessWidget {
  const _AllMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
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
