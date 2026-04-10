import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _UnfocusDispositionDeepDemo();
}

const Color _kJet = Color(0xFF111827);
const Color _kFog = Color(0xFFF8FAFC);
const Color _kMint = Color(0xFFA7F3D0);

class _UnfocusDispositionDeepDemo extends StatefulWidget {
  const _UnfocusDispositionDeepDemo();

  @override
  State<_UnfocusDispositionDeepDemo> createState() => _UnfocusDispositionDeepDemoState();
}

class _UnfocusDispositionDeepDemoState extends State<_UnfocusDispositionDeepDemo>
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
      backgroundColor: _kFog,
      appBar: AppBar(
        backgroundColor: _kJet,
        foregroundColor: Colors.white,
        title: const Text('UnfocusDisposition Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kMint,
          tabs: const [
            Tab(text: 'Concept Atlas'),
            Tab(text: 'Focus Tree Lab'),
            Tab(text: 'Overlay Scenarios'),
            Tab(text: 'A11y Playbook'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ConceptAtlasPanel(),
          _FocusTreeLabPanel(),
          _OverlayScenarioPanel(),
          _A11yPlaybookPanel(),
        ],
      ),
    );
  }
}

class _ConceptAtlasPanel extends StatelessWidget {
  const _ConceptAtlasPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _LeadCard(
          title: 'UnfocusDisposition Overview',
          body:
              'UnfocusDisposition defines where focus goes after a node calls '
              'unfocus(). The selected strategy determines whether focus lands on '
              'scope or returns to the previously focused child.',
        ),
        SizedBox(height: 12),
        _TopicCard(
          title: 'UnfocusDisposition.scope',
          tone: Color(0xFF166534),
          points: [
            'Default unfocus strategy in many flows.',
            'Moves focus to enclosing FocusScopeNode.',
            'Useful for dismissing text input focus directly.',
            'Often used on form submit or explicit cancel actions.',
          ],
        ),
        _TopicCard(
          title: 'UnfocusDisposition.previouslyFocusedChild',
          tone: Color(0xFF1D4ED8),
          points: [
            'Restores prior focused child in same scope when available.',
            'Supports temporary focus steals such as overlays.',
            'Fallbacks to scope when no prior child is known.',
            'Helps keyboard users resume previous navigation context.',
          ],
        ),
        _TopicCard(
          title: 'Practical command mapping',
          tone: Color(0xFF9A3412),
          points: [
            'Escape key for closing transient controls and restoring target focus.',
            'Submit actions often use scope to drop field focus and keyboard.',
            'Contextual menus may prefer previouslyFocusedChild.',
            'Wizard step transitions can intentionally reset to scope root.',
          ],
        ),
        SizedBox(height: 12),
        _EnumReferenceCard(),
      ],
    );
  }
}

class _EnumReferenceCard extends StatelessWidget {
  const _EnumReferenceCard();

  @override
  Widget build(BuildContext context) {
    final values = UnfocusDisposition.values;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enum Value Reference', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            for (final v in values)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• ${v.name} (index: ${v.index})'),
              ),
          ],
        ),
      ),
    );
  }
}

class _FocusTreeLabPanel extends StatefulWidget {
  const _FocusTreeLabPanel();

  @override
  State<_FocusTreeLabPanel> createState() => _FocusTreeLabPanelState();
}

class _FocusTreeLabPanelState extends State<_FocusTreeLabPanel> {
  final List<_FocusNodeRecord> _nodes = [
    _FocusNodeRecord(scope: 'EditorScope', id: 'titleField'),
    _FocusNodeRecord(scope: 'EditorScope', id: 'bodyField'),
    _FocusNodeRecord(scope: 'EditorScope', id: 'tagField'),
    _FocusNodeRecord(scope: 'SideScope', id: 'filterSearch'),
    _FocusNodeRecord(scope: 'SideScope', id: 'sortButton'),
  ];
  String _active = 'titleField';
  String _previous = 'bodyField';
  UnfocusDisposition _mode = UnfocusDisposition.scope;
  final List<String> _events = ['Focus tree lab initialized'];

  _FocusNodeRecord _record(String id) {
    return _nodes.firstWhere((n) => n.id == id);
  }

  void _focus(String id) {
    setState(() {
      _previous = _active;
      _active = id;
      _events.add('focus moved to $id (previous $_previous)');
      if (_events.length > 28) {
        _events.removeAt(0);
      }
    });
  }

  void _unfocus() {
    setState(() {
      final scope = _record(_active).scope;
      if (_mode == UnfocusDisposition.scope) {
        _active = '$scope.scope-root';
        _events.add('unfocus(scope) -> $scope.scope-root');
      } else {
        final prevScope = _record(_previous).scope;
        if (prevScope == scope) {
          final old = _active;
          _active = _previous;
          _previous = old;
          _events.add('unfocus(previouslyFocusedChild) -> $_active');
        } else {
          _active = '$scope.scope-root';
          _events.add('unfocus(previouslyFocusedChild) fallback -> $scope.scope-root');
        }
      }
      if (_events.length > 28) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<_FocusNodeRecord>>{};
    for (final n in _nodes) {
      groups.putIfAbsent(n.scope, () => []).add(n);
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _LeadCard(
          title: 'Focus Tree Simulation',
          body:
              'This simulation visualizes focus movement and unfocus outcomes under '
              'both disposition modes. It highlights same-scope restoration behavior.',
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
                ChoiceChip(
                  label: const Text('scope'),
                  selected: _mode == UnfocusDisposition.scope,
                  onSelected: (_) => setState(() => _mode = UnfocusDisposition.scope),
                ),
                ChoiceChip(
                  label: const Text('previouslyFocusedChild'),
                  selected: _mode == UnfocusDisposition.previouslyFocusedChild,
                  onSelected: (_) => setState(() => _mode = UnfocusDisposition.previouslyFocusedChild),
                ),
                FilledButton(onPressed: _unfocus, child: const Text('Unfocus Active Node')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        for (final entry in groups.entries)
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final n in entry.value)
                        ChoiceChip(
                          label: Text(n.id),
                          selected: _active == n.id,
                          onSelected: (_) => _focus(n.id),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('scope root token: ${entry.key}.scope-root'),
                ],
              ),
            ),
          ),
        Card(
          color: const Color(0xFFECFEFF),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Active focus: $_active', style: const TextStyle(fontWeight: FontWeight.w800)),
                Text('Previous focus: $_previous'),
                Text('Mode: ${_mode.name}'),
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
                const Text('Focus Event Timeline', style: TextStyle(fontWeight: FontWeight.w800)),
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

class _OverlayScenarioPanel extends StatefulWidget {
  const _OverlayScenarioPanel();

  @override
  State<_OverlayScenarioPanel> createState() => _OverlayScenarioPanelState();
}

class _OverlayScenarioPanelState extends State<_OverlayScenarioPanel> {
  bool _overlayOpen = false;
  bool _commandPaletteOpen = false;
  String _focused = 'editor.body';
  String _previous = 'editor.title';
  final List<String> _journal = ['Overlay scenarios ready'];

  void _push(String text) {
    _journal.add(text);
    if (_journal.length > 24) {
      _journal.removeAt(0);
    }
  }

  void _openOverlay() {
    setState(() {
      _overlayOpen = true;
      _previous = _focused;
      _focused = 'overlay.search';
      _push('overlay opened -> focus moved to overlay.search');
    });
  }

  void _closeOverlay(UnfocusDisposition disposition) {
    setState(() {
      _overlayOpen = false;
      if (disposition == UnfocusDisposition.previouslyFocusedChild) {
        _focused = _previous;
        _push('overlay closed with previouslyFocusedChild -> $_focused');
      } else {
        _focused = 'editor.scope-root';
        _push('overlay closed with scope -> editor.scope-root');
      }
    });
  }

  void _togglePalette(UnfocusDisposition disposition) {
    setState(() {
      if (!_commandPaletteOpen) {
        _commandPaletteOpen = true;
        _previous = _focused;
        _focused = 'palette.query';
        _push('command palette opened -> palette.query focused');
      } else {
        _commandPaletteOpen = false;
        if (disposition == UnfocusDisposition.previouslyFocusedChild) {
          _focused = _previous;
          _push('palette closed with previouslyFocusedChild -> $_focused');
        } else {
          _focused = 'shell.scope-root';
          _push('palette closed with scope -> shell.scope-root');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _LeadCard(
          title: 'Overlay and Modal Scenarios',
          body:
              'Transient UI layers often steal focus. This panel shows how each '
              'disposition behaves when overlays and command palettes close.',
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
                FilledButton(onPressed: _openOverlay, child: const Text('Open Overlay')),
                OutlinedButton(
                  onPressed: () => _closeOverlay(UnfocusDisposition.scope),
                  child: const Text('Close Overlay (scope)'),
                ),
                OutlinedButton(
                  onPressed: () => _closeOverlay(UnfocusDisposition.previouslyFocusedChild),
                  child: const Text('Close Overlay (previouslyFocusedChild)'),
                ),
                FilledButton.tonal(
                  onPressed: () => _togglePalette(UnfocusDisposition.previouslyFocusedChild),
                  child: Text(_commandPaletteOpen ? 'Close Palette (previous)' : 'Open Palette'),
                ),
                FilledButton.tonal(
                  onPressed: () => _togglePalette(UnfocusDisposition.scope),
                  child: const Text('Toggle Palette (scope)'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFF1F5F9),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('focused target: $_focused', style: const TextStyle(fontWeight: FontWeight.w800)),
                Text('previous target: $_previous'),
                Text('overlay open: $_overlayOpen'),
                Text('command palette open: $_commandPaletteOpen'),
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
                const Text('Scenario Journal', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final row in _journal)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $row'),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _A11yPlaybookPanel extends StatelessWidget {
  const _A11yPlaybookPanel();

  @override
  Widget build(BuildContext context) {
    final list = <_GuidelineItem>[
      const _GuidelineItem(
        'Keyboard continuity',
        'Use previouslyFocusedChild when a temporary surface closes so users resume where they were.',
        Icons.keyboard,
      ),
      const _GuidelineItem(
        'Intentional reset',
        'Use scope when workflow explicitly ends and focus should return to group root.',
        Icons.restart_alt,
      ),
      const _GuidelineItem(
        'Screen reader predictability',
        'Announce where focus lands after unfocus transitions to avoid context loss.',
        Icons.record_voice_over,
      ),
      const _GuidelineItem(
        'Modal ergonomics',
        'Dialog/overlay closure is usually smoother with previouslyFocusedChild.',
        Icons.layers,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _LeadCard(
          title: 'Accessibility and UX Playbook',
          body:
              'Selecting an unfocus disposition is a UX choice. This playbook '
              'highlights when each mode improves keyboard and assistive navigation.',
        ),
        const SizedBox(height: 12),
        for (final item in list)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(item.icon, color: const Color(0xFF0369A1)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 4),
                          Text(item.detail),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _LeadCard extends StatelessWidget {
  const _LeadCard({required this.title, required this.body});

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

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.title, required this.tone, required this.points});

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
              Text(title, style: TextStyle(fontWeight: FontWeight.w800, color: tone)),
              const SizedBox(height: 6),
              for (final p in points)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $p'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FocusNodeRecord {
  const _FocusNodeRecord({required this.scope, required this.id});

  final String scope;
  final String id;
}

class _GuidelineItem {
  const _GuidelineItem(this.title, this.detail, this.icon);

  final String title;
  final String detail;
  final IconData icon;
}
