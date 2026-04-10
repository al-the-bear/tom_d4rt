import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetInspectorServiceExtensionsDeepDemo();
}

const Color _kBar = Color(0xFF111827);
const Color _kSurface = Color(0xFFF8FAFC);

class _WidgetInspectorServiceExtensionsDeepDemo extends StatefulWidget {
  const _WidgetInspectorServiceExtensionsDeepDemo();

  @override
  State<_WidgetInspectorServiceExtensionsDeepDemo> createState() =>
      _WidgetInspectorServiceExtensionsDeepDemoState();
}

class _WidgetInspectorServiceExtensionsDeepDemoState
    extends State<_WidgetInspectorServiceExtensionsDeepDemo>
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
      backgroundColor: _kSurface,
      appBar: AppBar(
        backgroundColor: _kBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetInspectorServiceExtensions Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Extension Atlas'),
            Tab(text: 'Invocation Console'),
            Tab(text: 'Tree Query Lab'),
            Tab(text: 'Flex Edit Studio'),
            Tab(text: 'Integration Notes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ExtensionAtlasPanel(),
          _InvocationConsolePanel(),
          _TreeQueryLabPanel(),
          _FlexEditStudioPanel(),
          _IntegrationNotesPanel(),
        ],
      ),
    );
  }
}

class _ExtensionAtlasPanel extends StatelessWidget {
  const _ExtensionAtlasPanel();

  @override
  Widget build(BuildContext context) {
    final all = WidgetInspectorServiceExtensions.values;
    final groups = _ExtensionGroups.from(all);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _TopCard(
          title: 'Enum as protocol contract',
          body:
              'WidgetInspectorServiceExtensions enumerates command identifiers '
              'exposed via VM service extensions for inspector and DevTools-like '
              'workflows. This panel groups values by operational domain.',
        ),
        const SizedBox(height: 10),
        _GroupCard(title: 'Tree', color: const Color(0xFFDBEAFE), entries: groups.tree),
        _GroupCard(title: 'Selection/Visibility', color: const Color(0xFFD1FAE5), entries: groups.selection),
        _GroupCard(title: 'Layout/Flex', color: const Color(0xFFEDE9FE), entries: groups.layout),
        _GroupCard(title: 'Lifecycle/Dispose', color: const Color(0xFFFEF3C7), entries: groups.lifecycle),
        _GroupCard(title: 'Tracking/Debug', color: const Color(0xFFFCE7F3), entries: groups.tracking),
      ],
    );
  }
}

class _InvocationConsolePanel extends StatefulWidget {
  const _InvocationConsolePanel();

  @override
  State<_InvocationConsolePanel> createState() => _InvocationConsolePanelState();
}

class _InvocationConsolePanelState extends State<_InvocationConsolePanel> {
  final List<_ExtensionInvocation> _recent = [];
  final TextEditingController _argKey = TextEditingController(text: 'groupName');
  final TextEditingController _argValue = TextEditingController(text: 'demo-group');
  WidgetInspectorServiceExtensions _selected =
      WidgetInspectorServiceExtensions.values.first;

  @override
  void dispose() {
    _argKey.dispose();
    _argValue.dispose();
    super.dispose();
  }

  void _invokeSelected() {
    final record = _ExtensionInvocation(
      extension: _selected,
      payload: {
        _argKey.text.trim().isEmpty ? 'arg' : _argKey.text.trim():
            _argValue.text.trim(),
      },
      timeLabel: TimeOfDay.now().format(context),
    );

    setState(() {
      _recent.add(record);
      if (_recent.length > 32) {
        _recent.removeAt(0);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Service Extension Invocation', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<WidgetInspectorServiceExtensions>(
                        initialValue: _selected,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Extension',
                        ),
                        items: [
                          for (final ext in WidgetInspectorServiceExtensions.values)
                            DropdownMenuItem(
                              value: ext,
                              child: Text(ext.name),
                            ),
                        ],
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() => _selected = value);
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _argKey,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Argument key',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _argValue,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Argument value',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: _invokeSelected,
                        child: const Text('Simulate VM Service Call'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: const Color(0xFFEFF6FF),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Last selected extension: ${_selected.name}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
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
                const Text('Invocation Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final item in _recent.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '• ${item.timeLabel} | ${item.extension.name} | ${item.payload}',
                      style: const TextStyle(fontSize: 12),
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

class _TreeQueryLabPanel extends StatefulWidget {
  const _TreeQueryLabPanel();

  @override
  State<_TreeQueryLabPanel> createState() => _TreeQueryLabPanelState();
}

class _TreeQueryLabPanelState extends State<_TreeQueryLabPanel> {
  final List<_TreeNode> _nodes = [
    _TreeNode('root', 0),
    _TreeNode('header', 1),
    _TreeNode('body', 1),
    _TreeNode('sidebar', 2),
    _TreeNode('contentList', 2),
    _TreeNode('footer', 1),
  ];

  final List<String> _events = ['Tree query lab initialized'];
  String _selected = 'root';

  void _query(String node) {
    setState(() {
      _selected = node;
      _events.add('Queried $node via getChildren/getRootWidget style extension');
      if (_events.length > 26) {
        _events.removeAt(0);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tree Query Scenarios', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                      const SizedBox(height: 8),
                      for (final node in _nodes)
                        Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          padding: EdgeInsets.only(left: 10 + (node.depth * 20).toDouble(), top: 8, bottom: 8, right: 8),
                          decoration: BoxDecoration(
                            color: node.name == _selected
                                ? const Color(0xFFDBEAFE)
                                : const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Text(node.name)),
                              OutlinedButton(
                                onPressed: () => _query(node.name),
                                child: const Text('Query'),
                              ),
                            ],
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
                const Text('Tree Query Events', style: TextStyle(fontWeight: FontWeight.w800)),
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

class _FlexEditStudioPanel extends StatefulWidget {
  const _FlexEditStudioPanel();

  @override
  State<_FlexEditStudioPanel> createState() => _FlexEditStudioPanelState();
}

class _FlexEditStudioPanelState extends State<_FlexEditStudioPanel> {
  int _left = 1;
  int _middle = 2;
  int _right = 1;
  final List<String> _events = ['Flex edit studio started'];

  void _apply(String field, int value) {
    setState(() {
      if (field == 'left') {
        _left = value;
      } else if (field == 'middle') {
        _middle = value;
      } else {
        _right = value;
      }
      _events.add('Applied setFlexProperties-like edit: $field -> $value');
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
          flex: 6,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Flex command simulation', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                      const SizedBox(height: 8),
                      _FlexSliderLine(label: 'Left', value: _left, onChanged: (v) => _apply('left', v)),
                      _FlexSliderLine(label: 'Middle', value: _middle, onChanged: (v) => _apply('middle', v)),
                      _FlexSliderLine(label: 'Right', value: _right, onChanged: (v) => _apply('right', v)),
                      const SizedBox(height: 10),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: _left,
                              child: Container(
                                color: const Color(0xFFBFDBFE),
                                alignment: Alignment.center,
                                child: Text('L ($_left)'),
                              ),
                            ),
                            Expanded(
                              flex: _middle,
                              child: Container(
                                color: const Color(0xFFC7F9CC),
                                alignment: Alignment.center,
                                child: Text('M ($_middle)'),
                              ),
                            ),
                            Expanded(
                              flex: _right,
                              child: Container(
                                color: const Color(0xFFFDE68A),
                                alignment: Alignment.center,
                                child: Text('R ($_right)'),
                              ),
                            ),
                          ],
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
                const Text('Flex Edit Events', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _events.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $line', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _IntegrationNotesPanel extends StatelessWidget {
  const _IntegrationNotesPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _NotesCard(
          title: 'Recommended workflow',
          tone: Color(0xFF0F766E),
          notes: [
            'Resolve enum names from WidgetInspectorServiceExtensions directly.',
            'Map UI actions to extension IDs through a thin command adapter.',
            'Keep payload contracts stable and documented per extension.',
            'Capture invocation logs for debugging inspector tool behavior.',
          ],
        ),
        _NotesCard(
          title: 'Testing guidance',
          tone: Color(0xFF1D4ED8),
          notes: [
            'Use visual command consoles to validate dispatch wiring.',
            'Exercise tree, selection, and layout extension families separately.',
            'Simulate payload arguments and inspect command history rendering.',
            'Focus on interpreter interaction correctness over Flutter internals.',
          ],
        ),
        _NotesCard(
          title: 'Pitfalls',
          tone: Color(0xFFB91C1C),
          notes: [
            'Hard-coding extension strings outside enum increases drift risk.',
            'Mixing transport concerns with UI widgets complicates testing.',
            'Ignoring payload validation can produce hard-to-debug failures.',
            'Flooding command channels without throttling may reduce responsiveness.',
          ],
        ),
      ],
    );
  }
}

class _TopCard extends StatelessWidget {
  const _TopCard({required this.title, required this.body});

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

class _GroupCard extends StatelessWidget {
  const _GroupCard({
    required this.title,
    required this.color,
    required this.entries,
  });

  final String title;
  final Color color;
  final List<String> entries;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 8),
              if (entries.isEmpty)
                const Text('• none in this SDK build')
              else
                for (final e in entries)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $e'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotesCard extends StatelessWidget {
  const _NotesCard({required this.title, required this.tone, required this.notes});

  final String title;
  final Color tone;
  final List<String> notes;

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
              Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 8),
              for (final n in notes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $n'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExtensionGroups {
  const _ExtensionGroups({
    required this.tree,
    required this.selection,
    required this.layout,
    required this.lifecycle,
    required this.tracking,
  });

  final List<String> tree;
  final List<String> selection;
  final List<String> layout;
  final List<String> lifecycle;
  final List<String> tracking;

  factory _ExtensionGroups.from(List<WidgetInspectorServiceExtensions> values) {
    final tree = <String>[];
    final selection = <String>[];
    final layout = <String>[];
    final lifecycle = <String>[];
    final tracking = <String>[];

    for (final ext in values) {
      final name = ext.name;
      if (name.startsWith('getRoot') || name.startsWith('getChildren')) {
        tree.add(name);
      } else if (name.contains('Selected') || name == 'show') {
        selection.add(name);
      } else if (name.contains('Flex') || name.contains('Layout')) {
        layout.add(name);
      } else if (name.startsWith('dispose')) {
        lifecycle.add(name);
      } else {
        tracking.add(name);
      }
    }

    return _ExtensionGroups(
      tree: tree,
      selection: selection,
      layout: layout,
      lifecycle: lifecycle,
      tracking: tracking,
    );
  }
}

class _ExtensionInvocation {
  const _ExtensionInvocation({
    required this.extension,
    required this.payload,
    required this.timeLabel,
  });

  final WidgetInspectorServiceExtensions extension;
  final Map<String, String> payload;
  final String timeLabel;
}

class _TreeNode {
  const _TreeNode(this.name, this.depth);

  final String name;
  final int depth;
}

class _FlexSliderLine extends StatelessWidget {
  const _FlexSliderLine({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label flex: $value'),
        Slider(
          value: value.toDouble(),
          min: 1,
          max: 6,
          divisions: 5,
          label: '$value',
          onChanged: (v) => onChanged(v.round()),
        ),
      ],
    );
  }
}
