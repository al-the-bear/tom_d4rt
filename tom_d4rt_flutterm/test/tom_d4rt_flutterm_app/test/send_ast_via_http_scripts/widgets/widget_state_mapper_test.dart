import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetStateMapperDeepDemo();
}

const Color _kMapperNavy = Color(0xFF0B132B);
const Color _kMapperCanvas = Color(0xFFF4F7FB);

class _WidgetStateMapperDeepDemo extends StatefulWidget {
  const _WidgetStateMapperDeepDemo();

  @override
  State<_WidgetStateMapperDeepDemo> createState() =>
      _WidgetStateMapperDeepDemoState();
}

class _WidgetStateMapperDeepDemoState extends State<_WidgetStateMapperDeepDemo>
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
      backgroundColor: _kMapperCanvas,
      appBar: AppBar(
        backgroundColor: _kMapperNavy,
        foregroundColor: Colors.white,
        title: const Text('WidgetStateMapper Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Resolver Lab'),
            Tab(text: 'Precedence Grid'),
            Tab(text: 'Visual Gallery'),
            Tab(text: 'Recipes'),
            Tab(text: 'Diagnostics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _MapperOverviewPanel(),
          _ResolverLabPanel(),
          _PrecedenceGridPanel(),
          _VisualGalleryPanel(),
          _RecipePanel(),
          _DiagnosticsPanel(),
        ],
      ),
    );
  }
}

class _MapperOverviewPanel extends StatelessWidget {
  const _MapperOverviewPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _HeadlineCard(
          title: 'Why WidgetStateMapper exists',
          body:
              'WidgetStateMapper<T> is a concrete state-property object that '
              'maps interactive state constraints to values. Use it when you '
              'want readable, inspectable mappings instead of ad-hoc if-chains.',
          tone: Color(0xFF1D4ED8),
        ),
        SizedBox(height: 12),
        _HeadlineCard(
          title: 'What this demo teaches',
          body:
              'You will see real-time state toggles, map precedence behavior, '
              'value fallbacks, and practical composition in button cards, '
              'surfaces, paddings, and typography.',
          tone: Color(0xFF047857),
        ),
        SizedBox(height: 12),
        _ChecklistCard(
          title: 'Use WidgetStateMapper when',
          tone: Color(0xFF7C3AED),
          bullets: [
            'Several components share the same state-resolution rules.',
            'You need deterministic fallback values with WidgetState.any.',
            'Design teams review mappings and expect declarative tables.',
            'You want inspector-friendly diagnostics for style decisions.',
          ],
        ),
        SizedBox(height: 12),
        _ChecklistCard(
          title: 'Avoid brittle patterns',
          tone: Color(0xFFB91C1C),
          bullets: [
            'Unordered condition chains duplicated in multiple widgets.',
            'No explicit fallback for unmatched state sets.',
            'Hardcoded style constants that ignore disabled or error states.',
            'Mixing hover-only desktop assumptions into mobile-only flows.',
          ],
        ),
        SizedBox(height: 12),
        _InlineCodeCard(),
      ],
    );
  }
}

class _ResolverLabPanel extends StatefulWidget {
  const _ResolverLabPanel();

  @override
  State<_ResolverLabPanel> createState() => _ResolverLabPanelState();
}

class _ResolverLabPanelState extends State<_ResolverLabPanel> {
  final Set<WidgetState> _states = <WidgetState>{};
  final List<String> _history = <String>[
    'Resolver lab initialized.',
    'Toggle states to inspect value changes.',
  ];

  final WidgetStateMapper<double> _radiusMapper = WidgetStateMapper<double>({
    WidgetState.disabled: 4,
    WidgetState.error: 24,
    WidgetState.pressed: 22,
    WidgetState.hovered: 16,
    WidgetState.focused: 18,
    WidgetState.any: 12,
  });

  final WidgetStateMapper<double> _elevationMapper = WidgetStateMapper<double>({
    WidgetState.disabled: 0,
    WidgetState.pressed: 10,
    WidgetState.hovered: 6,
    WidgetState.focused: 7,
    WidgetState.any: 3,
  });

  final WidgetStateMapper<Color> _colorMapper = WidgetStateMapper<Color>({
    WidgetState.disabled: const Color(0xFF94A3B8),
    WidgetState.error: const Color(0xFFB91C1C),
    WidgetState.pressed: const Color(0xFF0EA5E9),
    WidgetState.hovered: const Color(0xFF2563EB),
    WidgetState.focused: const Color(0xFF6D28D9),
    WidgetState.any: const Color(0xFF14B8A6),
  });

  final WidgetStateMapper<EdgeInsets> _paddingMapper =
      WidgetStateMapper<EdgeInsets>({
    WidgetState.disabled: const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 8,
    ),
    WidgetState.pressed: const EdgeInsets.symmetric(
      horizontal: 26,
      vertical: 16,
    ),
    WidgetState.hovered: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 14,
    ),
    WidgetState.any: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    ),
  });

  void _toggleState(WidgetState state, bool enabled) {
    setState(() {
      if (enabled) {
        _states.add(state);
      } else {
        _states.remove(state);
      }
      _history.add('${DateTime.now().toIso8601String()} :: ${state.name} -> $enabled');
      if (_history.length > 24) {
        _history.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = _radiusMapper.resolve(_states);
    final elevation = _elevationMapper.resolve(_states);
    final color = _colorMapper.resolve(_states);
    final padding = _paddingMapper.resolve(_states);

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
                        'Interactive states',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      for (final state in const [
                        WidgetState.hovered,
                        WidgetState.focused,
                        WidgetState.pressed,
                        WidgetState.error,
                        WidgetState.disabled,
                        WidgetState.selected,
                      ])
                        SwitchListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Text(state.name),
                          subtitle: Text('Applies ${state.name} constraint if mapped.'),
                          value: _states.contains(state),
                          onChanged: (value) => _toggleState(state, value),
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
                    children: [
                      const Text(
                        'Resolved Surface',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 12),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        padding: padding,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(radius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.22),
                              blurRadius: elevation + 2,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const SizedBox(
                          width: double.infinity,
                          height: 110,
                          child: Center(
                            child: Text(
                              'WidgetStateMapper in action',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _MetricTile(label: 'Radius', value: radius.toStringAsFixed(1)),
                          _MetricTile(label: 'Elevation', value: elevation.toStringAsFixed(1)),
                          _MetricTile(
                            label: 'Color',
                            value: '#${color.toARGB32().toRadixString(16).padLeft(8, '0')}',
                          ),
                          _MetricTile(label: 'Padding H', value: padding.horizontal.toStringAsFixed(1)),
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
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final text = _history[_history.length - 1 - index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFFA7F3D0),
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

class _PrecedenceGridPanel extends StatelessWidget {
  const _PrecedenceGridPanel();

  @override
  Widget build(BuildContext context) {
    final WidgetStateMapper<String> mapper = WidgetStateMapper<String>({
      WidgetState.disabled: 'disabled rule',
      WidgetState.error: 'error rule',
      WidgetState.pressed: 'pressed rule',
      WidgetState.hovered: 'hovered rule',
      WidgetState.focused: 'focused rule',
      WidgetState.any: 'fallback rule',
    });

    final rows = <({Set<WidgetState> states, String label})>[
      (states: <WidgetState>{}, label: 'empty'),
      (states: {WidgetState.hovered}, label: 'hovered'),
      (states: {WidgetState.focused}, label: 'focused'),
      (states: {WidgetState.pressed}, label: 'pressed'),
      (states: {WidgetState.error}, label: 'error'),
      (states: {WidgetState.disabled}, label: 'disabled'),
      (states: {WidgetState.hovered, WidgetState.focused}, label: 'hovered+focused'),
      (states: {WidgetState.hovered, WidgetState.pressed}, label: 'hovered+pressed'),
      (states: {WidgetState.error, WidgetState.focused}, label: 'error+focused'),
      (states: {WidgetState.selected}, label: 'selected only'),
      (states: {WidgetState.dragged}, label: 'dragged only'),
    ];

    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        const _HeadlineCard(
          title: 'Constraint precedence exploration',
          body:
              'This table reveals how each state set resolves through mapper '
              'entries and where fallback takes over. Use it to explain style '
              'bugs when teams ask why a widget color or radius changed.',
          tone: Color(0xFF0F766E),
        ),
        const SizedBox(height: 12),
        Card(
          clipBehavior: Clip.antiAlias,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('State set')),
              DataColumn(label: Text('Resolved value')),
              DataColumn(label: Text('Interpretation')),
            ],
            rows: [
              for (final row in rows)
                DataRow(
                  cells: [
                    DataCell(Text(row.label)),
                    DataCell(Text(mapper.resolve(row.states))),
                    DataCell(
                      Text(
                        row.states.isEmpty
                            ? 'No explicit state, fallback handles this.'
                            : 'Evaluates first matching mapping entry.',
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const _ChecklistCard(
          title: 'Debugging sequence',
          tone: Color(0xFF1D4ED8),
          bullets: [
            'Capture active state set at the time style resolves.',
            'Inspect mapper entries order and specific constraints.',
            'Verify that WidgetState.any exists as a deterministic fallback.',
            'Track environment differences between desktop and touch flows.',
          ],
        ),
      ],
    );
  }
}

class _VisualGalleryPanel extends StatelessWidget {
  const _VisualGalleryPanel();

  @override
  Widget build(BuildContext context) {
    final bgMapper = WidgetStateMapper<Color>({
      WidgetState.disabled: const Color(0xFFE2E8F0),
      WidgetState.pressed: const Color(0xFF0EA5E9),
      WidgetState.hovered: const Color(0xFF38BDF8),
      WidgetState.selected: const Color(0xFF22C55E),
      WidgetState.any: const Color(0xFF334155),
    });

    final textMapper = WidgetStateMapper<TextStyle>({
      WidgetState.disabled: const TextStyle(
        color: Color(0xFF64748B),
        fontWeight: FontWeight.w600,
      ),
      WidgetState.pressed: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
      ),
      WidgetState.hovered: const TextStyle(
        color: Colors.white,
        letterSpacing: 0.3,
        fontWeight: FontWeight.w700,
      ),
      WidgetState.any: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    });

    final cards = <({String name, Set<WidgetState> states, String note})>[
      (name: 'Idle chip', states: <WidgetState>{}, note: 'WidgetState.any fallback.'),
      (name: 'Hover chip', states: {WidgetState.hovered}, note: 'Desktop affordance preview.'),
      (name: 'Pressed chip', states: {WidgetState.pressed}, note: 'Action confirmation emphasis.'),
      (name: 'Selected chip', states: {WidgetState.selected}, note: 'Persistent chosen state.'),
      (name: 'Disabled chip', states: {WidgetState.disabled}, note: 'Reduced contrast and intent.'),
    ];

    return GridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      childAspectRatio: 1.18,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        for (final card in cards)
          Container(
            decoration: BoxDecoration(
              color: bgMapper.resolve(card.states),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(card.name, style: textMapper.resolve(card.states)),
                const SizedBox(height: 8),
                Text(
                  'States: ${card.states.map((e) => e.name).join(', ').ifEmpty('none')}',
                  style: textMapper.resolve(card.states).copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  card.note,
                  style: textMapper.resolve(card.states).copyWith(
                    fontSize: 12,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _RecipePanel extends StatelessWidget {
  const _RecipePanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: const [
        _HeadlineCard(
          title: 'Recipe 1: Unified button style tokens',
          body:
              'Create one mapper per token class (background, text style, '
              'padding, border radius) and reuse in primary, danger, and '
              'secondary button families for consistency and easy tuning.',
          tone: Color(0xFF1E40AF),
        ),
        SizedBox(height: 10),
        _HeadlineCard(
          title: 'Recipe 2: Input feedback hierarchy',
          body:
              'Combine focused, error, and disabled mappings for border and '
              'helper text styles to communicate validation states clearly '
              'without abrupt jumps in layout rhythm.',
          tone: Color(0xFF7C2D12),
        ),
        SizedBox(height: 10),
        _HeadlineCard(
          title: 'Recipe 3: Cross-platform hover strategy',
          body:
              'Keep hover mappings subtle and non-essential for touch devices. '
              'Use hover for visual richness on desktop while ensuring pressed '
              'and focused states carry functional semantics everywhere.',
          tone: Color(0xFF047857),
        ),
        SizedBox(height: 10),
        _ChecklistCard(
          title: 'Rollout checklist',
          tone: Color(0xFF9333EA),
          bullets: [
            'Document map values with design token names.',
            'Validate contrast in disabled and error states.',
            'Use UI review captures for each state combination.',
            'Track regressions with state simulation screenshots.',
          ],
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
  final List<String> _messages = <String>[];
  int _counter = 0;

  WidgetStateMapper<String> _messageMapper() {
    return WidgetStateMapper<String>({
      WidgetState.disabled: 'Component unavailable, fallback semantics active.',
      WidgetState.error: 'Validation priority overrides neutral mappings.',
      WidgetState.pressed: 'High intent gesture, accent response triggered.',
      WidgetState.hovered: 'Pointer discovery state, micro-emphasis applied.',
      WidgetState.focused: 'Keyboard navigation state, focus ring intent.',
      WidgetState.any: 'Default state baseline from WidgetState.any.',
    });
  }

  void _simulate(Set<WidgetState> states) {
    setState(() {
      _counter += 1;
      final text = _messageMapper().resolve(states);
      _messages.add('Run $_counter -> {${states.map((e) => e.name).join(', ')}} => $text');
      if (_messages.length > 18) {
        _messages.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ElevatedButton(
              onPressed: () => _simulate(<WidgetState>{}),
              child: const Text('Simulate default'),
            ),
            ElevatedButton(
              onPressed: () => _simulate({WidgetState.hovered}),
              child: const Text('Simulate hovered'),
            ),
            ElevatedButton(
              onPressed: () => _simulate({WidgetState.pressed}),
              child: const Text('Simulate pressed'),
            ),
            ElevatedButton(
              onPressed: () => _simulate({WidgetState.error}),
              child: const Text('Simulate error'),
            ),
            ElevatedButton(
              onPressed: () => _simulate({WidgetState.disabled}),
              child: const Text('Simulate disabled'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF020617),
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
                      color: Color(0xFFA5F3FC),
                      fontSize: 12,
                      fontFamily: 'monospace',
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

class _HeadlineCard extends StatelessWidget {
  const _HeadlineCard({
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
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: tone,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(body, style: const TextStyle(height: 1.4)),
          ],
        ),
      ),
    );
  }
}

class _ChecklistCard extends StatelessWidget {
  const _ChecklistCard({
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
            for (final line in bullets)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: tone)),
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

class _InlineCodeCard extends StatelessWidget {
  const _InlineCodeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF0F172A),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Reference snippet',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'final mapper = WidgetStateMapper<Color>({\n'
              '  WidgetState.disabled: const Color(0xFF94A3B8),\n'
              '  WidgetState.pressed: const Color(0xFF0EA5E9),\n'
              '  WidgetState.any: const Color(0xFF14B8A6),\n'
              '});\n\n'
              'final resolved = mapper.resolve(states);',
              style: TextStyle(
                color: Color(0xFF93C5FD),
                fontFamily: 'monospace',
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w700),
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
