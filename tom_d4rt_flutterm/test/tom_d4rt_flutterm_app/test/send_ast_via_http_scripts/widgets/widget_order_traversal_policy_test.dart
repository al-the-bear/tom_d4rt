import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetOrderTraversalPolicyDeepDemo();
}

const Color _kNavTop = Color(0xFF0F172A);
const Color _kNavBg = Color(0xFFF8FAFC);

class _WidgetOrderTraversalPolicyDeepDemo extends StatefulWidget {
  const _WidgetOrderTraversalPolicyDeepDemo();

  @override
  State<_WidgetOrderTraversalPolicyDeepDemo> createState() =>
      _WidgetOrderTraversalPolicyDeepDemoState();
}

class _WidgetOrderTraversalPolicyDeepDemoState
    extends State<_WidgetOrderTraversalPolicyDeepDemo>
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
      backgroundColor: _kNavBg,
      appBar: AppBar(
        backgroundColor: _kNavTop,
        foregroundColor: Colors.white,
        title: const Text('WidgetOrderTraversalPolicy Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Policy Atlas'),
            Tab(text: 'Order Sequence'),
            Tab(text: 'Directional Lab'),
            Tab(text: 'Form Navigator'),
            Tab(text: 'Comparison Guide'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _PolicyAtlasPanel(),
          _OrderSequencePanel(),
          _DirectionalLabPanel(),
          _FormNavigatorPanel(),
          _ComparisonGuidePanel(),
        ],
      ),
    );
  }
}

class _PolicyAtlasPanel extends StatelessWidget {
  const _PolicyAtlasPanel();

  @override
  Widget build(BuildContext context) {
    final policy = WidgetOrderTraversalPolicy();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _MainCard(
          title: 'Policy identity',
          body: 'Created policy instance: ${policy.runtimeType}. '
              'WidgetOrderTraversalPolicy follows widget tree order and '
              'DirectionalFocusTraversalPolicyMixin behavior for key-based movement.',
        ),
        const SizedBox(height: 10),
        const _LineCard(
          title: 'How ordering works',
          tone: Color(0xFF1D4ED8),
          lines: [
            'Traversal sequence follows natural widget insertion order.',
            'No explicit FocusOrder widgets are required.',
            'Works well for forms and structured panels.',
            'Combined with directional mixin for arrow navigation.',
          ],
        ),
        const _LineCard(
          title: 'Where it shines',
          tone: Color(0xFF166534),
          lines: [
            'Rapid UI prototyping with predictable focus movement.',
            'Data-entry workflows with top-to-bottom progression.',
            'Layouts where reading order equals interaction order.',
            'Minimal focus config overhead in medium complexity screens.',
          ],
        ),
        const _LineCard(
          title: 'When to consider alternatives',
          tone: Color(0xFFB91C1C),
          lines: [
            'Complex custom focus graphs across disjoint areas.',
            'Non-linear navigation requirements by business priority.',
            'Accessibility paths that diverge from widget order.',
            'Large dashboards requiring explicit curated traversal.',
          ],
        ),
      ],
    );
  }
}

class _OrderSequencePanel extends StatefulWidget {
  const _OrderSequencePanel();

  @override
  State<_OrderSequencePanel> createState() => _OrderSequencePanelState();
}

class _OrderSequencePanelState extends State<_OrderSequencePanel> {
  final List<_FocusCell> _cells = [
    _FocusCell('Name field', const Color(0xFFDBEAFE)),
    _FocusCell('Email field', const Color(0xFFD1FAE5)),
    _FocusCell('Phone field', const Color(0xFFEDE9FE)),
    _FocusCell('Company field', const Color(0xFFFEF3C7)),
    _FocusCell('Role selector', const Color(0xFFFCE7F3)),
    _FocusCell('Submit button', const Color(0xFFE2E8F0)),
  ];
  int _index = 0;
  final List<String> _events = ['Sequence lab initialized at index 0'];

  void _next() {
    setState(() {
      _index = (_index + 1) % _cells.length;
      _events.add('Tab -> focused ${_cells[_index].name}');
      if (_events.length > 30) {
        _events.removeAt(0);
      }
    });
  }

  void _previous() {
    setState(() {
      _index = (_index - 1) % _cells.length;
      if (_index < 0) {
        _index = _cells.length - 1;
      }
      _events.add('Shift+Tab -> focused ${_cells[_index].name}');
      if (_events.length > 30) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        FilledButton(onPressed: _previous, child: const Text('Shift+Tab')),
                        const SizedBox(width: 8),
                        FilledButton(onPressed: _next, child: const Text('Tab')),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Focused: ${_cells[_index].name}',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  itemCount: _cells.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.4,
                  ),
                  itemBuilder: (context, index) {
                    final cell = _cells[index];
                    final focused = index == _index;
                    return Card(
                      color: cell.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: focused
                              ? const Color(0xFF1D4ED8)
                              : const Color(0xFFCBD5E1),
                          width: focused ? 3 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}. ${cell.name}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: focused ? FontWeight.w800 : FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
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
                const Text('Traversal Events', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final e in _events.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $e', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DirectionalLabPanel extends StatefulWidget {
  const _DirectionalLabPanel();

  @override
  State<_DirectionalLabPanel> createState() => _DirectionalLabPanelState();
}

class _DirectionalLabPanelState extends State<_DirectionalLabPanel> {
  int _row = 1;
  int _col = 1;
  final List<String> _moves = ['Directional lab started at center'];

  void _move(int dr, int dc, String label) {
    setState(() {
      _row = (_row + dr).clamp(0, 2);
      _col = (_col + dc).clamp(0, 2);
      _moves.add('$label -> focus($_row,$_col)');
      if (_moves.length > 28) {
        _moves.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => _move(-1, 0, 'ArrowUp'),
                              icon: const Icon(Icons.keyboard_arrow_up),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => _move(0, -1, 'ArrowLeft'),
                              icon: const Icon(Icons.keyboard_arrow_left),
                            ),
                            IconButton(
                              onPressed: () => _move(0, 1, 'ArrowRight'),
                              icon: const Icon(Icons.keyboard_arrow_right),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => _move(1, 0, 'ArrowDown'),
                              icon: const Icon(Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final r = index ~/ 3;
                      final c = index % 3;
                      final focused = r == _row && c == _col;
                      return Container(
                        decoration: BoxDecoration(
                          color: focused
                              ? const Color(0xFFDBEAFE)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: focused
                                ? const Color(0xFF1D4ED8)
                                : const Color(0xFFCBD5E1),
                            width: focused ? 3 : 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text('R$r C$c'),
                      );
                    },
                  ),
                ),
              ],
            ),
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
                const Text('Directional Moves', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final move in _moves.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $move', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FormNavigatorPanel extends StatefulWidget {
  const _FormNavigatorPanel();

  @override
  State<_FormNavigatorPanel> createState() => _FormNavigatorPanelState();
}

class _FormNavigatorPanelState extends State<_FormNavigatorPanel> {
  final List<String> _steps = [
    'Profile Name',
    'Account Email',
    'Role',
    'Region',
    'Preferences',
    'Confirm',
  ];
  int _active = 0;

  @override
  Widget build(BuildContext context) {
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
                    _active = (_active - 1) % _steps.length;
                    if (_active < 0) {
                      _active = _steps.length - 1;
                    }
                  }),
                  child: const Text('Prev'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => setState(() {
                    _active = (_active + 1) % _steps.length;
                  }),
                  child: const Text('Next'),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text('Focused field: ${_steps[_active]}')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        for (var i = 0; i < _steps.length; i++)
          Card(
            color: i == _active
                ? const Color(0xFFDBEAFE)
                : const Color(0xFFF8FAFC),
            child: ListTile(
              leading: CircleAvatar(child: Text('${i + 1}')),
              title: Text(_steps[i]),
              subtitle: Text(i == _active ? 'Focused by traversal policy' : 'Pending'),
            ),
          ),
      ],
    );
  }
}

class _ComparisonGuidePanel extends StatelessWidget {
  const _ComparisonGuidePanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _LineCard(
          title: 'WidgetOrderTraversalPolicy vs OrderedTraversalPolicy',
          tone: Color(0xFF0F766E),
          lines: [
            'WidgetOrder: implicit widget tree order, minimal setup.',
            'Ordered: explicit FocusOrder declarations for custom paths.',
            'WidgetOrder: best for natural reading/entry forms.',
            'Ordered: best for intentionally non-linear navigation graphs.',
          ],
        ),
        _LineCard(
          title: 'Implementation checklist',
          tone: Color(0xFF1D4ED8),
          lines: [
            'Wrap navigable area with FocusTraversalGroup.',
            'Use WidgetOrderTraversalPolicy for sane defaults.',
            'Validate tab and arrow behavior in representative layouts.',
            'Document any deviations for accessibility review.',
          ],
        ),
        _LineCard(
          title: 'Failure signals',
          tone: Color(0xFFB91C1C),
          lines: [
            'Focus jumps unexpectedly across unrelated panes.',
            'Directional keys produce non-local movement patterns.',
            'Hidden widgets remain in traversal path.',
            'Traversal order diverges from user mental model.',
          ],
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
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _LineCard extends StatelessWidget {
  const _LineCard({required this.title, required this.tone, required this.lines});

  final String title;
  final Color tone;
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
                  style: TextStyle(
                      color: tone,
                      fontWeight: FontWeight.w800,
                      fontSize: 16)),
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

class _FocusCell {
  _FocusCell(this.name, this.color);

  final String name;
  final Color color;
}
