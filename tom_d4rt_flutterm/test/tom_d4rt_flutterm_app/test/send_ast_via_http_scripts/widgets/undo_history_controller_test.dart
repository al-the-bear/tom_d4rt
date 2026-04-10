import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _UndoHistoryControllerDeepDemo();
}

const Color _kNavy = Color(0xFF1E293B);
const Color _kGround = Color(0xFFF8FAFC);
const Color _kHighlight = Color(0xFFBFDBFE);

class _UndoHistoryControllerDeepDemo extends StatefulWidget {
  const _UndoHistoryControllerDeepDemo();

  @override
  State<_UndoHistoryControllerDeepDemo> createState() => _UndoHistoryControllerDeepDemoState();
}

class _UndoHistoryControllerDeepDemoState extends State<_UndoHistoryControllerDeepDemo>
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
      backgroundColor: _kGround,
      appBar: AppBar(
        backgroundColor: _kNavy,
        foregroundColor: Colors.white,
        title: const Text('UndoHistoryController Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kHighlight,
          tabs: const [
            Tab(text: 'Controller Atlas'),
            Tab(text: 'Single Document Lab'),
            Tab(text: 'Workspace Sessions'),
            Tab(text: 'Integration Desk'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ControllerAtlasPanel(),
          _SingleDocumentLabPanel(),
          _WorkspaceSessionsPanel(),
          _IntegrationDeskPanel(),
        ],
      ),
    );
  }
}

class _ControllerAtlasPanel extends StatelessWidget {
  const _ControllerAtlasPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _HeaderCard(
          title: 'UndoHistoryController in Context',
          body:
              'UndoHistoryController is the state authority for undo/redo availability '
              'and command dispatch in editable surfaces. It centralizes canUndo/canRedo '
              'signals and exposes operations consumed by UI actions and shortcuts.',
        ),
        SizedBox(height: 12),
        _PaletteCard(
          title: 'Responsibilities',
          tone: Color(0xFF166534),
          bullets: [
            'Expose current UndoHistoryValue state for UI decisions.',
            'Provide undo() and redo() command entry points.',
            'Synchronize command availability with history transitions.',
            'Serve as bridge between text editing and app-level actions.',
          ],
        ),
        _PaletteCard(
          title: 'When to use',
          tone: Color(0xFF1D4ED8),
          bullets: [
            'Editor widgets requiring explicit undo/redo controls.',
            'Toolbars with context-sensitive command enablement.',
            'Workspaces with multiple independent editing sessions.',
            'Shortcuts and menu commands mapped to undo stacks.',
          ],
        ),
        _PaletteCard(
          title: 'Common mistakes',
          tone: Color(0xFF9A3412),
          bullets: [
            'Forgetting to refresh controller value after stack changes.',
            'Issuing undo/redo without checking canUndo/canRedo.',
            'Reusing one controller across unrelated documents.',
            'Not disposing controller when editor scope ends.',
          ],
        ),
        SizedBox(height: 12),
        _CommandFlowCard(),
      ],
    );
  }
}

class _CommandFlowCard extends StatelessWidget {
  const _CommandFlowCard();

  @override
  Widget build(BuildContext context) {
    final flow = <String>[
      'Edit action pushes new snapshot to history.',
      'Controller value updates canUndo/canRedo flags.',
      'UI buttons and shortcuts read flags to enable commands.',
      'undo()/redo() moves pointer and triggers another value update.',
      'Renderable editor state refreshes from active snapshot.',
    ];

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Command Flow', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
            const SizedBox(height: 8),
            for (var i = 0; i < flow.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(radius: 11, backgroundColor: const Color(0xFF2563EB), child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontSize: 11))),
                    const SizedBox(width: 8),
                    Expanded(child: Text(flow[i])),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SingleDocumentLabPanel extends StatefulWidget {
  const _SingleDocumentLabPanel();

  @override
  State<_SingleDocumentLabPanel> createState() => _SingleDocumentLabPanelState();
}

class _SingleDocumentLabPanelState extends State<_SingleDocumentLabPanel> {
  late final UndoHistoryController _controller;
  final List<String> _history = [''];
  int _pointer = 0;
  final List<String> _events = ['Single document lab initialized'];
  final TextEditingController _input = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = UndoHistoryController();
    _syncController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _input.dispose();
    super.dispose();
  }

  void _syncController() {
    _controller.value = UndoHistoryValue(
      canUndo: _pointer > 0,
      canRedo: _pointer < _history.length - 1,
    );
  }

  void _appendText(String value) {
    if (value.isEmpty) {
      return;
    }
    final base = _history[_pointer];
    final next = base + value;
    setState(() {
      if (_pointer < _history.length - 1) {
        _history.removeRange(_pointer + 1, _history.length);
      }
      _history.add(next);
      _pointer = _history.length - 1;
      _events.add('append "$value" -> pointer $_pointer');
      if (_events.length > 30) {
        _events.removeAt(0);
      }
      _syncController();
    });
  }

  void _undo() {
    if (!_controller.value.canUndo) {
      return;
    }
    setState(() {
      _controller.undo();
      _pointer--;
      _events.add('undo -> pointer $_pointer');
      if (_events.length > 30) {
        _events.removeAt(0);
      }
      _syncController();
    });
  }

  void _redo() {
    if (!_controller.value.canRedo) {
      return;
    }
    setState(() {
      _controller.redo();
      _pointer++;
      _events.add('redo -> pointer $_pointer');
      if (_events.length > 30) {
        _events.removeAt(0);
      }
      _syncController();
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = _history[_pointer];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _HeaderCard(
          title: 'Single Document Command Lab',
          body:
              'Simulate edit pushes and undo/redo transitions while observing '
              'controller flags and timeline behavior.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _input,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Append text fragment',
                    hintText: 'Type fragment and click Push Edit',
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(
                      onPressed: () {
                        final fragment = _input.text;
                        _appendText(fragment);
                        _input.clear();
                      },
                      child: const Text('Push Edit'),
                    ),
                    OutlinedButton(onPressed: _undo, child: const Text('Undo')),
                    OutlinedButton(onPressed: _redo, child: const Text('Redo')),
                    TextButton(
                      onPressed: () => setState(() {
                        _history
                          ..clear()
                          ..add('');
                        _pointer = 0;
                        _events.add('history reset');
                        _syncController();
                      }),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('canUndo: ${_controller.value.canUndo} | canRedo: ${_controller.value.canRedo}'),
                Text('history length: ${_history.length} | pointer: $_pointer'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFDBEAFE),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current Document View', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF93C5FD)),
                  ),
                  child: Text(content.isEmpty ? '(empty)' : content),
                ),
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
                const Text('History Strip', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (var i = 0; i < _history.length; i++)
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: i == _pointer ? const Color(0xFFE0F2FE) : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: i == _pointer ? const Color(0xFF0284C7) : const Color(0xFFCBD5E1)),
                    ),
                    child: Text('[$i] ${_history[i].isEmpty ? '(empty)' : _history[i]}'),
                  ),
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
                const Text('Command Timeline', style: TextStyle(fontWeight: FontWeight.w800)),
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

class _WorkspaceSessionsPanel extends StatefulWidget {
  const _WorkspaceSessionsPanel();

  @override
  State<_WorkspaceSessionsPanel> createState() => _WorkspaceSessionsPanelState();
}

class _WorkspaceSessionsPanelState extends State<_WorkspaceSessionsPanel> {
  final List<_SessionRecord> _sessions = [
    _SessionRecord(name: 'notes.md', controller: UndoHistoryController(), history: ['init'], pointer: 0),
    _SessionRecord(name: 'query.sql', controller: UndoHistoryController(), history: ['SELECT *'], pointer: 0),
    _SessionRecord(name: 'config.yaml', controller: UndoHistoryController(), history: ['version: 1'], pointer: 0),
  ];

  int _selected = 0;

  @override
  void initState() {
    super.initState();
    for (final s in _sessions) {
      _syncSession(s);
    }
  }

  @override
  void dispose() {
    for (final s in _sessions) {
      s.controller.dispose();
    }
    super.dispose();
  }

  void _syncSession(_SessionRecord s) {
    s.controller.value = UndoHistoryValue(
      canUndo: s.pointer > 0,
      canRedo: s.pointer < s.history.length - 1,
    );
  }

  void _applySyntheticEdit(_SessionRecord s) {
    if (s.pointer < s.history.length - 1) {
      s.history.removeRange(s.pointer + 1, s.history.length);
    }
    final next = '${s.history[s.pointer]} -> edit${s.history.length}';
    s.history.add(next);
    s.pointer = s.history.length - 1;
    _syncSession(s);
  }

  void _undo(_SessionRecord s) {
    if (!s.controller.value.canUndo) {
      return;
    }
    s.controller.undo();
    s.pointer--;
    _syncSession(s);
  }

  void _redo(_SessionRecord s) {
    if (!s.controller.value.canRedo) {
      return;
    }
    s.controller.redo();
    s.pointer++;
    _syncSession(s);
  }

  @override
  Widget build(BuildContext context) {
    final active = _sessions[_selected];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _HeaderCard(
          title: 'Workspace Session Controls',
          body:
              'Use one controller per editor session and keep undo stacks isolated. '
              'This panel demonstrates independent command availability across documents.',
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
                for (var i = 0; i < _sessions.length; i++)
                  ChoiceChip(
                    label: Text(_sessions[i].name),
                    selected: _selected == i,
                    onSelected: (_) => setState(() => _selected = i),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFFF8FAFC),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Active: ${active.name}', style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text('canUndo: ${active.controller.value.canUndo} | canRedo: ${active.controller.value.canRedo}'),
                Text('history length: ${active.history.length} | pointer: ${active.pointer}'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilledButton(
                      onPressed: () => setState(() => _applySyntheticEdit(active)),
                      child: const Text('Synthetic Edit'),
                    ),
                    OutlinedButton(
                      onPressed: () => setState(() => _undo(active)),
                      child: const Text('Undo'),
                    ),
                    OutlinedButton(
                      onPressed: () => setState(() => _redo(active)),
                      child: const Text('Redo'),
                    ),
                  ],
                ),
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
                const Text('Session Overview', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final s in _sessions)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: Text(
                      '${s.name}: canUndo=${s.controller.value.canUndo}, '
                      'canRedo=${s.controller.value.canRedo}, pointer=${s.pointer}',
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _IntegrationDeskPanel extends StatelessWidget {
  const _IntegrationDeskPanel();

  @override
  Widget build(BuildContext context) {
    final cards = <_ShortcutCardData>[
      const _ShortcutCardData(
        title: 'Toolbar Buttons',
        description: 'Bind enabled state directly to controller.value.canUndo/canRedo for clear command UX.',
        icon: Icons.view_quilt,
      ),
      const _ShortcutCardData(
        title: 'Keyboard Shortcuts',
        description: 'Map Ctrl/Cmd+Z to undo and Shift-modified variant to redo using Actions/Shortcuts.',
        icon: Icons.keyboard,
      ),
      const _ShortcutCardData(
        title: 'Context Menus',
        description: 'Expose undo/redo entries near text interactions to reduce pointer travel.',
        icon: Icons.menu_open,
      ),
      const _ShortcutCardData(
        title: 'Command Palette',
        description: 'Route global command dispatch to currently focused editor controller.',
        icon: Icons.search,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _HeaderCard(
          title: 'Integration Desk',
          body:
              'This panel summarizes practical integration patterns for menus, '
              'shortcuts, and command dispatch using UndoHistoryController.',
        ),
        const SizedBox(height: 12),
        for (final item in cards)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(item.icon, color: const Color(0xFF1D4ED8)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 4),
                          Text(item.description),
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

class _PaletteCard extends StatelessWidget {
  const _PaletteCard({required this.title, required this.tone, required this.bullets});

  final String title;
  final Color tone;
  final List<String> bullets;

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
              for (final bullet in bullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $bullet'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionRecord {
  _SessionRecord({
    required this.name,
    required this.controller,
    required this.history,
    required this.pointer,
  });

  final String name;
  final UndoHistoryController controller;
  final List<String> history;
  int pointer;
}

class _ShortcutCardData {
  const _ShortcutCardData({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
}
