import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetStateTextStyleDeepDemo();
}

const Color _kTextStyleBar = Color(0xFF111827);
const Color _kTextStyleCanvas = Color(0xFFF8FAFC);

class _WidgetStateTextStyleDeepDemo extends StatefulWidget {
  const _WidgetStateTextStyleDeepDemo();

  @override
  State<_WidgetStateTextStyleDeepDemo> createState() =>
      _WidgetStateTextStyleDeepDemoState();
}

class _WidgetStateTextStyleDeepDemoState
    extends State<_WidgetStateTextStyleDeepDemo>
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
      backgroundColor: _kTextStyleCanvas,
      appBar: AppBar(
        backgroundColor: _kTextStyleBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetStateTextStyle Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Concept'),
            Tab(text: 'State Resolver'),
            Tab(text: 'Type Scale Wall'),
            Tab(text: 'Readability Lab'),
            Tab(text: 'Applied Cards'),
            Tab(text: 'Trace Console'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _TextStyleConceptPanel(),
          _StateResolverPanel(),
          _TypeScaleWallPanel(),
          _ReadabilityLabPanel(),
          _AppliedCardsPanel(),
          _TraceConsolePanel(),
        ],
      ),
    );
  }
}

class _TextStyleConceptPanel extends StatelessWidget {
  const _TextStyleConceptPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _InfoCard(
          title: 'What WidgetStateTextStyle is for',
          tone: Color(0xFF1D4ED8),
          body:
              'WidgetStateTextStyle resolves text styles from interactive state '
              'sets. Use it when text needs dynamic semantics for hover, focus, '
              'pressed, disabled, error, and selected interactions.',
        ),
        SizedBox(height: 12),
        _InfoCard(
          title: 'Why state typography matters',
          tone: Color(0xFF047857),
          body:
              'Color alone is not always enough. Weight, decoration, spacing, '
              'and style can clarify intent, improve hierarchy, and support '
              'accessibility for keyboard and pointer users.',
        ),
        SizedBox(height: 12),
        _BulletCard(
          title: 'Good usage patterns',
          tone: Color(0xFF7C3AED),
          points: [
            'Headings shift subtly between focus and default states.',
            'Interactive labels underline or increase weight on hover.',
            'Disabled text uses lower emphasis and no decorative cues.',
            'Error text combines contrast and clear semantic markers.',
          ],
        ),
        SizedBox(height: 12),
        _BulletCard(
          title: 'Common mistakes',
          tone: Color(0xFFB91C1C),
          points: [
            'Applying dramatic font-size jumps on simple hover state.',
            'No clear disabled style fallback branch.',
            'Decoration overload that reduces readability.',
            'Inconsistent precedence across screens and components.',
          ],
        ),
      ],
    );
  }
}

class _StateResolverPanel extends StatefulWidget {
  const _StateResolverPanel();

  @override
  State<_StateResolverPanel> createState() => _StateResolverPanelState();
}

class _StateResolverPanelState extends State<_StateResolverPanel> {
  final Set<WidgetState> _states = <WidgetState>{};
  final List<String> _history = <String>['Resolver initialized.'];

  final WidgetStateTextStyle _headlineStyle =
      WidgetStateTextStyle.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return const TextStyle(
        color: Color(0xFF94A3B8),
        fontSize: 30,
        fontWeight: FontWeight.w600,
      );
    }
    if (states.contains(WidgetState.error)) {
      return const TextStyle(
        color: Color(0xFFB91C1C),
        fontSize: 32,
        fontWeight: FontWeight.w900,
        decoration: TextDecoration.underline,
        decorationThickness: 2,
      );
    }
    if (states.contains(WidgetState.pressed)) {
      return const TextStyle(
        color: Color(0xFF0EA5E9),
        fontSize: 32,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.5,
      );
    }
    if (states.contains(WidgetState.hovered)) {
      return const TextStyle(
        color: Color(0xFF2563EB),
        fontSize: 31,
        fontWeight: FontWeight.w800,
        decoration: TextDecoration.overline,
      );
    }
    if (states.contains(WidgetState.focused)) {
      return const TextStyle(
        color: Color(0xFF7C3AED),
        fontSize: 31,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.35,
      );
    }
    return const TextStyle(
      color: Color(0xFF0F172A),
      fontSize: 30,
      fontWeight: FontWeight.w700,
    );
  });

  final WidgetStateTextStyle _bodyStyle =
      WidgetStateTextStyle.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return const TextStyle(
        color: Color(0xFF64748B),
        fontSize: 15,
        height: 1.45,
      );
    }
    if (states.contains(WidgetState.error)) {
      return const TextStyle(
        color: Color(0xFF991B1B),
        fontSize: 15,
        height: 1.45,
        decoration: TextDecoration.underline,
      );
    }
    if (states.contains(WidgetState.pressed)) {
      return const TextStyle(
        color: Color(0xFF0C4A6E),
        fontSize: 15,
        height: 1.45,
        fontWeight: FontWeight.w600,
      );
    }
    if (states.contains(WidgetState.hovered)) {
      return const TextStyle(
        color: Color(0xFF1D4ED8),
        fontSize: 15,
        height: 1.45,
      );
    }
    if (states.contains(WidgetState.focused)) {
      return const TextStyle(
        color: Color(0xFF4338CA),
        fontSize: 15,
        height: 1.45,
      );
    }
    return const TextStyle(
      color: Color(0xFF334155),
      fontSize: 15,
      height: 1.45,
    );
  });

  void _toggle(WidgetState state, bool enabled) {
    setState(() {
      if (enabled) {
        _states.add(state);
      } else {
        _states.remove(state);
      }
      final style = _headlineStyle.resolve(_states);
      _history.add(
        '${DateTime.now().toIso8601String()} -> ${state.name}:$enabled | size:${style.fontSize} weight:${style.fontWeight}',
      );
      if (_history.length > 24) {
        _history.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final headline = _headlineStyle.resolve(_states);
    final body = _bodyStyle.resolve(_states);

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
                        WidgetState.error,
                        WidgetState.disabled,
                        WidgetState.selected,
                      ])
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(state.name),
                          subtitle: Text('Resolve style including ${state.name}.'),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('State-driven headline', style: headline),
                      const SizedBox(height: 10),
                      Text(
                        'WidgetStateTextStyle can coordinate visual semantics for '
                        'high-level title and detail copy without duplicating '
                        'condition trees across multiple widgets.',
                        style: body,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _MetricChip(
                            label: 'Color',
                            value: '#${(headline.color ?? Colors.black).toARGB32().toRadixString(16)}',
                          ),
                          _MetricChip(
                            label: 'Size',
                            value: (headline.fontSize ?? 0).toStringAsFixed(1),
                          ),
                          _MetricChip(
                            label: 'Weight',
                            value: '${headline.fontWeight}',
                          ),
                          _MetricChip(
                            label: 'Decoration',
                            value: '${headline.decoration}',
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
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final line = _history[_history.length - 1 - index];
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

class _TypeScaleWallPanel extends StatelessWidget {
  const _TypeScaleWallPanel();

  WidgetStateTextStyle _titleToken() {
    return WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 24,
          fontWeight: FontWeight.w600,
        );
      }
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          color: Color(0xFF16A34A),
          fontSize: 24,
          fontWeight: FontWeight.w900,
        );
      }
      if (states.contains(WidgetState.hovered)) {
        return const TextStyle(
          color: Color(0xFF1D4ED8),
          fontSize: 24,
          fontWeight: FontWeight.w800,
        );
      }
      return const TextStyle(
        color: Color(0xFF0F172A),
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final token = _titleToken();
    final scenarios = <({String name, Set<WidgetState> states, String note})>[
      (
        name: 'Default heading',
        states: <WidgetState>{},
        note: 'Baseline semantic style.',
      ),
      (
        name: 'Hovered heading',
        states: {WidgetState.hovered},
        note: 'Pointer discovery emphasis.',
      ),
      (
        name: 'Selected heading',
        states: {WidgetState.selected},
        note: 'Persistent active route label.',
      ),
      (
        name: 'Disabled heading',
        states: {WidgetState.disabled},
        note: 'Inactive but still readable.',
      ),
      (
        name: 'Hovered + Selected',
        states: {WidgetState.hovered, WidgetState.selected},
        note: 'Combined semantic state case.',
      ),
      (
        name: 'Pressed',
        states: {WidgetState.pressed},
        note: 'Falls to default in this token.',
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.28,
      children: [
        for (final scenario in scenarios)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scenario.name,
                    style: token.resolve(scenario.states),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'State set: ${scenario.states.map((e) => e.name).join(', ').ifEmpty('none')}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(scenario.note),
                  const Spacer(),
                  Text(
                    'Resolved color: #${(token.resolve(scenario.states).color ?? Colors.black).toARGB32().toRadixString(16)}',
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ReadabilityLabPanel extends StatefulWidget {
  const _ReadabilityLabPanel();

  @override
  State<_ReadabilityLabPanel> createState() => _ReadabilityLabPanelState();
}

class _ReadabilityLabPanelState extends State<_ReadabilityLabPanel> {
  bool _dark = false;
  bool _hovered = false;
  bool _focused = false;
  bool _error = false;
  bool _disabled = false;

  WidgetStateTextStyle _bodyToken() {
    return WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 16,
          height: 1.5,
        );
      }
      if (states.contains(WidgetState.error)) {
        return const TextStyle(
          color: Color(0xFFDC2626),
          fontSize: 16,
          height: 1.5,
          fontWeight: FontWeight.w700,
        );
      }
      if (states.contains(WidgetState.focused)) {
        return const TextStyle(
          color: Color(0xFF7C3AED),
          fontSize: 16,
          height: 1.5,
          decoration: TextDecoration.underline,
        );
      }
      if (states.contains(WidgetState.hovered)) {
        return const TextStyle(
          color: Color(0xFF2563EB),
          fontSize: 16,
          height: 1.5,
        );
      }
      return const TextStyle(
        color: Color(0xFF1E293B),
        fontSize: 16,
        height: 1.5,
      );
    });
  }

  Set<WidgetState> _states() {
    final result = <WidgetState>{};
    if (_hovered) {
      result.add(WidgetState.hovered);
    }
    if (_focused) {
      result.add(WidgetState.focused);
    }
    if (_error) {
      result.add(WidgetState.error);
    }
    if (_disabled) {
      result.add(WidgetState.disabled);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final states = _states();
    final style = _bodyToken().resolve(states);

    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 14,
              runSpacing: 10,
              children: [
                FilterChip(
                  label: const Text('Dark background'),
                  selected: _dark,
                  onSelected: (v) => setState(() => _dark = v),
                ),
                FilterChip(
                  label: const Text('Hovered'),
                  selected: _hovered,
                  onSelected: (v) => setState(() => _hovered = v),
                ),
                FilterChip(
                  label: const Text('Focused'),
                  selected: _focused,
                  onSelected: (v) => setState(() => _focused = v),
                ),
                FilterChip(
                  label: const Text('Error'),
                  selected: _error,
                  onSelected: (v) => setState(() => _error = v),
                ),
                FilterChip(
                  label: const Text('Disabled'),
                  selected: _disabled,
                  onSelected: (v) => setState(() => _disabled = v),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: _dark ? const Color(0xFF0B1020) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            'Readable typography depends on both style and context. '
            'This panel demonstrates how WidgetStateTextStyle can preserve '
            'clarity while communicating interaction semantics across backgrounds.',
            style: style.copyWith(
              color: _dark
                  ? (style.color ?? Colors.white).withValues(alpha: 0.95)
                  : style.color,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _MetricChip(
              label: 'States',
              value: states.map((e) => e.name).join(', ').ifEmpty('none'),
            ),
            _MetricChip(
              label: 'Font Size',
              value: '${style.fontSize}',
            ),
            _MetricChip(
              label: 'Weight',
              value: '${style.fontWeight}',
            ),
            _MetricChip(
              label: 'Decoration',
              value: '${style.decoration}',
            ),
          ],
        ),
      ],
    );
  }
}

class _AppliedCardsPanel extends StatelessWidget {
  const _AppliedCardsPanel();

  WidgetStateTextStyle _titleToken() {
    return WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.error)) {
        return const TextStyle(
          color: Color(0xFFDC2626),
          fontSize: 18,
          fontWeight: FontWeight.w900,
        );
      }
      if (states.contains(WidgetState.selected)) {
        return const TextStyle(
          color: Color(0xFF16A34A),
          fontSize: 18,
          fontWeight: FontWeight.w800,
        );
      }
      if (states.contains(WidgetState.disabled)) {
        return const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 18,
          fontWeight: FontWeight.w700,
        );
      }
      return const TextStyle(
        color: Color(0xFF0F172A),
        fontSize: 18,
        fontWeight: FontWeight.w800,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final token = _titleToken();
    final samples = <({String title, Set<WidgetState> states, String body})>[
      (
        title: 'Release summary',
        states: <WidgetState>{},
        body: 'Neutral card title with baseline style.',
      ),
      (
        title: 'Selected workspace',
        states: {WidgetState.selected},
        body: 'Selected text style indicates active context.',
      ),
      (
        title: 'Validation issue',
        states: {WidgetState.error},
        body: 'Error text emphasizes important corrective action.',
      ),
      (
        title: 'Archived module',
        states: {WidgetState.disabled},
        body: 'Disabled style lowers emphasis while staying legible.',
      ),
      (
        title: 'Selected with hover',
        states: {WidgetState.selected, WidgetState.hovered},
        body: 'State intersection still resolves deterministically.',
      ),
      (
        title: 'Error with focus',
        states: {WidgetState.error, WidgetState.focused},
        body: 'Error can be prioritized over focus in title tokens.',
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.32,
      children: [
        for (final sample in samples)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sample.title, style: token.resolve(sample.states)),
                  const SizedBox(height: 8),
                  Text(sample.body),
                  const Spacer(),
                  Text(
                    'States: ${sample.states.map((e) => e.name).join(', ').ifEmpty('none')}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Color: #${(token.resolve(sample.states).color ?? Colors.black).toARGB32().toRadixString(16)}',
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                  ),
                ],
              ),
            ),
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
  final List<String> _logs = <String>['Trace console ready.'];

  final WidgetStateTextStyle _traceToken =
      WidgetStateTextStyle.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return const TextStyle(color: Color(0xFF94A3B8), fontSize: 14);
    }
    if (states.contains(WidgetState.error)) {
      return const TextStyle(
        color: Color(0xFFB91C1C),
        fontSize: 14,
        fontWeight: FontWeight.w700,
      );
    }
    if (states.contains(WidgetState.pressed)) {
      return const TextStyle(
        color: Color(0xFF0EA5E9),
        fontSize: 14,
        fontWeight: FontWeight.w700,
      );
    }
    return const TextStyle(color: Color(0xFF1D4ED8), fontSize: 14);
  });

  void _simulate(Set<WidgetState> states) {
    final style = _traceToken.resolve(states);
    setState(() {
      _logs.add(
        '${DateTime.now().toIso8601String()} -> {${states.map((e) => e.name).join(', ').ifEmpty('none')}} => color:${style.color} weight:${style.fontWeight}',
      );
      if (_logs.length > 20) {
        _logs.removeAt(0);
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
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                final line = _logs[_logs.length - 1 - index];
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({
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

class _BulletCard extends StatelessWidget {
  const _BulletCard({
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
                    Text('- ', style: TextStyle(color: tone)),
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

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
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
