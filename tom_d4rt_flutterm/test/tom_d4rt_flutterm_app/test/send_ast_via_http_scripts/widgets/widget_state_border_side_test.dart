import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetStateBorderSideDeepDemo();
}

const Color _kBorderBar = Color(0xFF111827);
const Color _kBorderBg = Color(0xFFF8FAFC);

class _WidgetStateBorderSideDeepDemo extends StatefulWidget {
  const _WidgetStateBorderSideDeepDemo();

  @override
  State<_WidgetStateBorderSideDeepDemo> createState() =>
      _WidgetStateBorderSideDeepDemoState();
}

class _WidgetStateBorderSideDeepDemoState
    extends State<_WidgetStateBorderSideDeepDemo>
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
      backgroundColor: _kBorderBg,
      appBar: AppBar(
        backgroundColor: _kBorderBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetStateBorderSide Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Border Primer'),
            Tab(text: 'State Lab'),
            Tab(text: 'Component Skins'),
            Tab(text: 'Resolution Console'),
            Tab(text: 'Design Notes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _BorderPrimerPanel(),
          _StateLabPanel(),
          _ComponentSkinsPanel(),
          _ResolutionConsolePanel(),
          _DesignNotesPanel(),
        ],
      ),
    );
  }
}

class _BorderPrimerPanel extends StatelessWidget {
  const _BorderPrimerPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _HeaderCard(
          title: 'Why WidgetStateBorderSide exists',
          body:
              'WidgetStateBorderSide allows border visual style to resolve from '
              'interactive widget states such as hovered, focused, pressed, and '
              'disabled while still behaving like a BorderSide definition.',
        ),
        SizedBox(height: 10),
        _BulletDeck(
          title: 'Core semantics',
          color: Color(0xFF1D4ED8),
          lines: [
            'Implements WidgetStateProperty<BorderSide?> resolution contract.',
            'Returns borders based on a state set at render/interaction time.',
            'Supports consistent styling logic across many component types.',
            'Encodes both color and width behavior per state.',
          ],
        ),
        _BulletDeck(
          title: 'Typical state precedence',
          color: Color(0xFF166534),
          lines: [
            'Disabled often overrides all other visual states.',
            'Pressed can supersede hovered for active feedback.',
            'Focused border commonly adds contrast and width accent.',
            'Default fallback should be stable and neutral.',
          ],
        ),
        _BulletDeck(
          title: 'Usage contexts',
          color: Color(0xFFB91C1C),
          lines: [
            'Buttons with custom interactive outlines.',
            'Selection cards and filter chips.',
            'Form controls needing focus/disabled border differentiation.',
            'Inspector/debug widgets that visualize state transitions.',
          ],
        ),
      ],
    );
  }
}

class _StateLabPanel extends StatefulWidget {
  const _StateLabPanel();

  @override
  State<_StateLabPanel> createState() => _StateLabPanelState();
}

class _StateLabPanelState extends State<_StateLabPanel> {
  final Set<WidgetState> _states = <WidgetState>{};
  final List<String> _events = ['State lab initialized'];

  BorderSide _resolve(Set<WidgetState> states) {
    final resolver = WidgetStateBorderSide.resolveWith((current) {
      if (current.contains(WidgetState.disabled)) {
        return const BorderSide(color: Color(0xFF94A3B8), width: 1.0);
      }
      if (current.contains(WidgetState.pressed)) {
        return const BorderSide(color: Color(0xFFDC2626), width: 3.0);
      }
      if (current.contains(WidgetState.focused)) {
        return const BorderSide(color: Color(0xFF7C3AED), width: 2.5);
      }
      if (current.contains(WidgetState.hovered)) {
        return const BorderSide(color: Color(0xFF2563EB), width: 2.0);
      }
      return const BorderSide(color: Color(0xFF475569), width: 1.5);
    });
    return resolver.resolve(states) ?? BorderSide.none;
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
    final border = _resolve(_states);
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
                color: const Color(0xFFEFF6FF),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.fromBorderSide(border),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Resolved border\n${border.color} | width ${border.width}',
                          textAlign: TextAlign.center,
                        ),
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
          child: Card(
            margin: const EdgeInsets.all(12),
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const Text('State Transitions', style: TextStyle(fontWeight: FontWeight.w800)),
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

class _ComponentSkinsPanel extends StatefulWidget {
  const _ComponentSkinsPanel();

  @override
  State<_ComponentSkinsPanel> createState() => _ComponentSkinsPanelState();
}

class _ComponentSkinsPanelState extends State<_ComponentSkinsPanel> {
  int _selectedSkin = 0;

  BorderSide _borderFor(int index) {
    final states = <WidgetState>{};
    if (index == 1) {
      states.add(WidgetState.hovered);
    }
    if (index == 2) {
      states.add(WidgetState.focused);
    }
    if (index == 3) {
      states.add(WidgetState.pressed);
    }
    if (index == 4) {
      states.add(WidgetState.disabled);
    }

    final resolver = WidgetStateBorderSide.resolveWith((s) {
      if (s.contains(WidgetState.disabled)) {
        return const BorderSide(color: Color(0xFF94A3B8), width: 1.0);
      }
      if (s.contains(WidgetState.pressed)) {
        return const BorderSide(color: Color(0xFFEF4444), width: 3.0);
      }
      if (s.contains(WidgetState.focused)) {
        return const BorderSide(color: Color(0xFF8B5CF6), width: 2.5);
      }
      if (s.contains(WidgetState.hovered)) {
        return const BorderSide(color: Color(0xFF2563EB), width: 2.0);
      }
      return const BorderSide(color: Color(0xFF475569), width: 1.5);
    });
    return resolver.resolve(states) ?? BorderSide.none;
  }

  @override
  Widget build(BuildContext context) {
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
                for (var i = 0; i < 5; i++)
                  ChoiceChip(
                    label: Text('Skin $i'),
                    selected: _selectedSkin == i,
                    onSelected: (_) => setState(() => _selectedSkin = i),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        for (var i = 0; i < 5; i++)
          Card(
            color: _selectedSkin == i
                ? const Color(0xFFEFF6FF)
                : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Component Skin $i',
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.fromBorderSide(_borderFor(i)),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text('state $i'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ResolutionConsolePanel extends StatefulWidget {
  const _ResolutionConsolePanel();

  @override
  State<_ResolutionConsolePanel> createState() => _ResolutionConsolePanelState();
}

class _ResolutionConsolePanelState extends State<_ResolutionConsolePanel> {
  final List<String> _log = ['Resolution console initialized'];

  BorderSide _resolve(Set<WidgetState> states) {
    final resolver = WidgetStateBorderSide.resolveWith((s) {
      if (s.contains(WidgetState.disabled)) {
        return const BorderSide(color: Color(0xFF94A3B8), width: 1.0);
      }
      if (s.contains(WidgetState.error)) {
        return const BorderSide(color: Color(0xFFB91C1C), width: 3.0);
      }
      if (s.contains(WidgetState.pressed)) {
        return const BorderSide(color: Color(0xFFDC2626), width: 2.8);
      }
      if (s.contains(WidgetState.focused)) {
        return const BorderSide(color: Color(0xFF7C3AED), width: 2.4);
      }
      if (s.contains(WidgetState.hovered)) {
        return const BorderSide(color: Color(0xFF2563EB), width: 2.0);
      }
      return const BorderSide(color: Color(0xFF334155), width: 1.4);
    });
    return resolver.resolve(states) ?? BorderSide.none;
  }

  void _evaluate(Set<WidgetState> states) {
    final b = _resolve(states);
    setState(() {
      _log.add('${states.map((e) => e.name).join('+')} -> ${b.color} w=${b.width}');
      if (_log.length > 32) {
        _log.removeAt(0);
      }
    });
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
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilledButton.tonal(
                        onPressed: () => _evaluate({}),
                        child: const Text('Default'),
                      ),
                      FilledButton.tonal(
                        onPressed: () => _evaluate({WidgetState.hovered}),
                        child: const Text('Hovered'),
                      ),
                      FilledButton.tonal(
                        onPressed: () => _evaluate({WidgetState.focused}),
                        child: const Text('Focused'),
                      ),
                      FilledButton.tonal(
                        onPressed: () => _evaluate({WidgetState.pressed}),
                        child: const Text('Pressed'),
                      ),
                      FilledButton.tonal(
                        onPressed: () => _evaluate({WidgetState.error}),
                        child: const Text('Error'),
                      ),
                      FilledButton.tonal(
                        onPressed: () => _evaluate({WidgetState.disabled}),
                        child: const Text('Disabled'),
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
          child: Card(
            margin: const EdgeInsets.all(12),
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const Text('Resolution Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final row in _log.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $row', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DesignNotesPanel extends StatelessWidget {
  const _DesignNotesPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _BulletDeck(
          title: 'Practical styling strategy',
          color: Color(0xFF0F766E),
          lines: [
            'Define clear state precedence and keep it documented.',
            'Use width change sparingly for pressed/focused emphasis.',
            'Pair border changes with color and fill for better affordance.',
            'Provide accessible contrast for all interactive states.',
          ],
        ),
        _BulletDeck(
          title: 'Common pitfalls',
          color: Color(0xFFB91C1C),
          lines: [
            'Ambiguous precedence causing jitter between hover and focus.',
            'Overly thick borders shifting perceived layout size.',
            'Disabled style not visually distinct from default state.',
            'Unlogged state transitions that are hard to debug.',
          ],
        ),
        _BulletDeck(
          title: 'Interpreter demo emphasis',
          color: Color(0xFF7C3AED),
          lines: [
            'Show visible border differences per state interaction.',
            'Use interactive controls to trigger and inspect resolutions.',
            'Demonstrate behavior across multiple component skins.',
            'Keep the demo explanatory and visually explicit.',
          ],
        ),
      ],
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.title, required this.body});

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

class _BulletDeck extends StatelessWidget {
  const _BulletDeck({required this.title, required this.color, required this.lines});

  final String title;
  final Color color;
  final List<String> lines;

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
                  style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 8),
              for (final line in lines)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $line'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
