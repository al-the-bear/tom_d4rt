import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetStateColorDeepDemo();
}

const Color _kColorBar = Color(0xFF111827);
const Color _kColorBg = Color(0xFFF8FAFC);

class _WidgetStateColorDeepDemo extends StatefulWidget {
  const _WidgetStateColorDeepDemo();

  @override
  State<_WidgetStateColorDeepDemo> createState() =>
      _WidgetStateColorDeepDemoState();
}

class _WidgetStateColorDeepDemoState extends State<_WidgetStateColorDeepDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kColorBg,
      appBar: AppBar(
        backgroundColor: _kColorBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetStateColor Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Color Primer'),
            Tab(text: 'State Mixer'),
            Tab(text: 'Palette Walls'),
            Tab(text: 'Component Themes'),
            Tab(text: 'Resolution Notes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ColorPrimerPanel(),
          _StateMixerPanel(),
          _PaletteWallsPanel(),
          _ComponentThemesPanel(),
          _ResolutionNotesPanel(),
        ],
      ),
    );
  }
}

class _ColorPrimerPanel extends StatelessWidget {
  const _ColorPrimerPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _PrimerCard(
          title: 'WidgetStateColor concept',
          body:
              'WidgetStateColor resolves color dynamically from interactive state '
              'sets while still behaving as a Color subtype, enabling direct use '
              'inside many component color properties.',
        ),
        SizedBox(height: 10),
        _PointsCard(
          title: 'Capabilities',
          tone: Color(0xFF1D4ED8),
          points: [
            'State-aware color resolution via resolve(Set<WidgetState>).',
            'Can encode hover/focus/press/disabled visual semantics.',
            'Supports transparent fallback via WidgetStateColor.transparent.',
            'Pairs with other state properties for complete design systems.',
          ],
        ),
        _PointsCard(
          title: 'Design priorities',
          tone: Color(0xFF166534),
          points: [
            'Maintain clear contrast deltas across states.',
            'Define deterministic precedence between state combinations.',
            'Keep neutral defaults and intentional accent states.',
            'Avoid saturated overload that reduces hierarchy readability.',
          ],
        ),
        _PointsCard(
          title: 'Common mistakes',
          tone: Color(0xFFB91C1C),
          points: [
            'Using near-identical colors for all states.',
            'No disabled-specific fallback color behavior.',
            'Inconsistent state precedence across components.',
            'Missing telemetry for state-to-color debugging.',
          ],
        ),
      ],
    );
  }
}

class _StateMixerPanel extends StatefulWidget {
  const _StateMixerPanel();

  @override
  State<_StateMixerPanel> createState() => _StateMixerPanelState();
}

class _StateMixerPanelState extends State<_StateMixerPanel> {
  final Set<WidgetState> _states = <WidgetState>{};
  final List<String> _events = ['State mixer initialized'];

  WidgetStateColor _resolver() {
    return WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return const Color(0xFF94A3B8);
      }
      if (states.contains(WidgetState.error)) {
        return const Color(0xFFB91C1C);
      }
      if (states.contains(WidgetState.pressed)) {
        return const Color(0xFFEF4444);
      }
      if (states.contains(WidgetState.focused)) {
        return const Color(0xFF8B5CF6);
      }
      if (states.contains(WidgetState.hovered)) {
        return const Color(0xFF2563EB);
      }
      return const Color(0xFF16A34A);
    });
  }

  void _toggle(WidgetState state, bool active) {
    setState(() {
      if (active) {
        _states.add(state);
      } else {
        _states.remove(state);
      }
      _events.add('State ${state.name} -> $active');
      if (_events.length > 28) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = _resolver().resolve(_states);
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      for (final state in const [
                        WidgetState.hovered,
                        WidgetState.focused,
                        WidgetState.pressed,
                        WidgetState.error,
                        WidgetState.disabled,
                      ])
                        SwitchListTile(
                          title: Text(state.name),
                          value: _states.contains(state),
                          onChanged: (v) => _toggle(state, v),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Resolved Color\n${color.toARGB32().toRadixString(16)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
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
          child: Card(
            margin: const EdgeInsets.all(12),
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const Text('Mixer Events', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final event in _events.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $event', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PaletteWallsPanel extends StatefulWidget {
  const _PaletteWallsPanel();

  @override
  State<_PaletteWallsPanel> createState() => _PaletteWallsPanelState();
}

class _PaletteWallsPanelState extends State<_PaletteWallsPanel> {
  int _activeWall = 0;

  WidgetStateColor _paletteResolver(int wall) {
    if (wall == 0) {
      return WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return const Color(0xFF94A3B8);
        if (states.contains(WidgetState.pressed)) return const Color(0xFFDC2626);
        if (states.contains(WidgetState.hovered)) return const Color(0xFF2563EB);
        return const Color(0xFF1D4ED8);
      });
    }
    if (wall == 1) {
      return WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return const Color(0xFFA3A3A3);
        if (states.contains(WidgetState.pressed)) return const Color(0xFF15803D);
        if (states.contains(WidgetState.hovered)) return const Color(0xFF16A34A);
        return const Color(0xFF22C55E);
      });
    }
    return WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return const Color(0xFF94A3B8);
      if (states.contains(WidgetState.pressed)) return const Color(0xFF7C3AED);
      if (states.contains(WidgetState.hovered)) return const Color(0xFFA855F7);
      return const Color(0xFFC084FC);
    });
  }

  @override
  Widget build(BuildContext context) {
    final resolver = _paletteResolver(_activeWall);
    final defaults = resolver.resolve({});
    final hover = resolver.resolve({WidgetState.hovered});
    final press = resolver.resolve({WidgetState.pressed});
    final disabled = resolver.resolve({WidgetState.disabled});

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var i = 0; i < 3; i++)
                  ChoiceChip(
                    label: Text('Palette $i'),
                    selected: _activeWall == i,
                    onSelected: (_) => setState(() => _activeWall = i),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        _ColorSwatchRow(label: 'default', color: defaults),
        _ColorSwatchRow(label: 'hovered', color: hover),
        _ColorSwatchRow(label: 'pressed', color: press),
        _ColorSwatchRow(label: 'disabled', color: disabled),
      ],
    );
  }
}

class _ComponentThemesPanel extends StatefulWidget {
  const _ComponentThemesPanel();

  @override
  State<_ComponentThemesPanel> createState() => _ComponentThemesPanelState();
}

class _ComponentThemesPanelState extends State<_ComponentThemesPanel> {
  int _step = 0;
  final List<String> _steps = [
    'default',
    'hovered',
    'focused',
    'pressed',
    'disabled',
  ];

  Set<WidgetState> get _stateSet {
    switch (_step) {
      case 1:
        return {WidgetState.hovered};
      case 2:
        return {WidgetState.focused};
      case 3:
        return {WidgetState.pressed};
      case 4:
        return {WidgetState.disabled};
      default:
        return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return const Color(0xFF9CA3AF);
      if (states.contains(WidgetState.pressed)) return const Color(0xFFDC2626);
      if (states.contains(WidgetState.focused)) return const Color(0xFF7C3AED);
      if (states.contains(WidgetState.hovered)) return const Color(0xFF2563EB);
      return const Color(0xFF16A34A);
    }).resolve(_stateSet);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                FilledButton(
                  onPressed: () => setState(() {
                    _step = (_step - 1) % _steps.length;
                    if (_step < 0) {
                      _step = _steps.length - 1;
                    }
                  }),
                  child: const Text('Prev'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => setState(() {
                    _step = (_step + 1) % _steps.length;
                  }),
                  child: const Text('Next'),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text('Current state: ${_steps[_step]}')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        for (final label in const ['Primary Button', 'Accent Chip', 'Status Badge', 'Interactive Tile'])
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(child: Text(label)),
                  Container(
                    width: 120,
                    height: 42,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text('preview', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ResolutionNotesPanel extends StatelessWidget {
  const _ResolutionNotesPanel();

  @override
  Widget build(BuildContext context) {
    final transparent = WidgetStateColor.transparent;
    final resolvedTransparent = transparent.resolve({WidgetState.pressed});
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _PointsCard(
          title: 'Transparent resolver note',
          tone: const Color(0xFF7C3AED),
          points: [
            'WidgetStateColor.transparent resolves to: ${resolvedTransparent.toARGB32().toRadixString(16)}',
            'Useful when a state channel must explicitly provide no tint.',
            'Can be combined with borders/elevation to keep affordance.',
            'Avoid overusing transparent states in dense interactive zones.',
          ],
        ),
        const _PointsCard(
          title: 'Implementation checklist',
          tone: Color(0xFF0F766E),
          points: [
            'Document precedence: disabled > pressed > focused > hovered > default.',
            'Use color tokens consistent with app design system.',
            'Validate contrast in each state against accessibility thresholds.',
            'Log resolution paths during debugging sessions.',
          ],
        ),
        const _PointsCard(
          title: 'Interpreter-focused validation',
          tone: Color(0xFF1D4ED8),
          points: [
            'Show state toggles and resulting color swatches visually.',
            'Exercise color behavior across multiple component archetypes.',
            'Capture timeline entries for each state transition.',
            'Prioritize visual clarity over assert-heavy unit checks.',
          ],
        ),
      ],
    );
  }
}

class _PrimerCard extends StatelessWidget {
  const _PrimerCard({required this.title, required this.body});

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

class _PointsCard extends StatelessWidget {
  const _PointsCard({required this.title, required this.tone, required this.points});

  final String title;
  final Color tone;
  final List<String> points;

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
              Text(title,
                  style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 8),
              for (final point in points)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $point'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorSwatchRow extends StatelessWidget {
  const _ColorSwatchRow({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(child: Text(label)),
            Container(
              width: 140,
              height: 42,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                color.toARGB32().toRadixString(16),
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
