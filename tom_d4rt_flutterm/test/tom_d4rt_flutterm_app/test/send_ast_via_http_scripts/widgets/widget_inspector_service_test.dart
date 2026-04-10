import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetInspectorServiceDeepDemo();
}

const Color _kInspectorBar = Color(0xFF0F172A);
const Color _kInspectorBg = Color(0xFFF8FAFC);

class _WidgetInspectorServiceDeepDemo extends StatefulWidget {
  const _WidgetInspectorServiceDeepDemo();

  @override
  State<_WidgetInspectorServiceDeepDemo> createState() =>
      _WidgetInspectorServiceDeepDemoState();
}

class _WidgetInspectorServiceDeepDemoState
    extends State<_WidgetInspectorServiceDeepDemo>
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
      backgroundColor: _kInspectorBg,
      appBar: AppBar(
        backgroundColor: _kInspectorBar,
        foregroundColor: Colors.white,
        title: const Text('WidgetInspectorService Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Service Atlas'),
            Tab(text: 'Selection Desk'),
            Tab(text: 'Group Registry'),
            Tab(text: 'Extension Router'),
            Tab(text: 'Debug Playbook'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ServiceAtlasPanel(),
          _SelectionDeskPanel(),
          _GroupRegistryPanel(),
          _ExtensionRouterPanel(),
          _DebugPlaybookPanel(),
        ],
      ),
    );
  }
}

class _ServiceAtlasPanel extends StatelessWidget {
  const _ServiceAtlasPanel();

  @override
  Widget build(BuildContext context) {
    final service = WidgetInspectorService.instance;
    final extensions = WidgetInspectorServiceExtensions.values;
    final tree = <String>[];
    final selection = <String>[];
    final layout = <String>[];
    final lifecycle = <String>[];
    final tracking = <String>[];

    for (final ext in extensions) {
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

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _AtlasCard(
          title: 'Service identity snapshot',
          body: 'WidgetInspectorService.instance resolved as ${service.runtimeType}. '
              'This singleton coordinates selection state, object references, '
              'extension registration, and inspector communication paths.',
        ),
        const SizedBox(height: 10),
        const _BulletCard(
          title: 'Core responsibilities',
          color: Color(0xFF1D4ED8),
          bullets: [
            'Manage selected object/widget state for inspector UIs.',
            'Map runtime objects to inspector IDs within object groups.',
            'Expose VM service extensions used by tooling and DevTools.',
            'Bridge widget tree queries and debug metadata retrieval.',
          ],
        ),
        _GroupCard(title: 'Tree operations', tint: const Color(0xFFDBEAFE), entries: tree),
        _GroupCard(title: 'Selection operations', tint: const Color(0xFFD1FAE5), entries: selection),
        _GroupCard(title: 'Layout/Flex operations', tint: const Color(0xFFEDE9FE), entries: layout),
        _GroupCard(title: 'Lifecycle operations', tint: const Color(0xFFFEF3C7), entries: lifecycle),
        _GroupCard(title: 'Tracking/flags operations', tint: const Color(0xFFFCE7F3), entries: tracking),
      ],
    );
  }
}

class _SelectionDeskPanel extends StatefulWidget {
  const _SelectionDeskPanel();

  @override
  State<_SelectionDeskPanel> createState() => _SelectionDeskPanelState();
}

class _SelectionDeskPanelState extends State<_SelectionDeskPanel> {
  final List<_InspectableEntry> _entries = [
    _InspectableEntry(name: 'RootScaffold', kind: 'Widget'),
    _InspectableEntry(name: 'CommandSidebar', kind: 'Element'),
    _InspectableEntry(name: 'RenderViewport', kind: 'RenderObject'),
    _InspectableEntry(name: 'DetailCard', kind: 'Widget'),
    _InspectableEntry(name: 'FooterActions', kind: 'Element'),
  ];
  final List<String> _events = ['Selection desk initialized'];
  String _selected = 'none';

  void _select(_InspectableEntry entry) {
    setState(() {
      for (final item in _entries) {
        item.active = identical(item, entry);
      }
      _selected = '${entry.kind}:${entry.name}';
      entry.hits += 1;
      _events.add('Selected ${entry.name} (${entry.kind}) [hits=${entry.hits}]');
      if (_events.length > 30) {
        _events.removeAt(0);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      for (final item in _entries) {
        item.active = false;
      }
      _selected = 'none';
      _events.add('Selection cleared');
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Current simulated selection: $_selected',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: _clearSelection,
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              for (final entry in _entries)
                Card(
                  color: entry.active
                      ? const Color(0xFFDBEAFE)
                      : const Color(0xFFF8FAFC),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(entry.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16)),
                              const SizedBox(height: 4),
                              Text('Kind: ${entry.kind}'),
                              Text('Selection hits: ${entry.hits}'),
                            ],
                          ),
                        ),
                        FilledButton(
                          onPressed: () => _select(entry),
                          child: const Text('Select'),
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
                const Text('Selection Events',
                    style: TextStyle(fontWeight: FontWeight.w800)),
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

class _GroupRegistryPanel extends StatefulWidget {
  const _GroupRegistryPanel();

  @override
  State<_GroupRegistryPanel> createState() => _GroupRegistryPanelState();
}

class _GroupRegistryPanelState extends State<_GroupRegistryPanel> {
  final List<_ObjectGroupState> _groups = [
    _ObjectGroupState('layout-lab', const Color(0xFFDBEAFE)),
    _ObjectGroupState('tree-snapshot', const Color(0xFFD1FAE5)),
    _ObjectGroupState('selection-focus', const Color(0xFFEDE9FE)),
    _ObjectGroupState('hot-reload-debug', const Color(0xFFFEF3C7)),
  ];
  final List<String> _log = ['Object group registry online'];

  void _register(_ObjectGroupState group) {
    setState(() {
      group.ids += 3;
      group.active = true;
      _log.add('Registered 3 objects into group ${group.name}');
      if (_log.length > 28) {
        _log.removeAt(0);
      }
    });
  }

  void _dispose(_ObjectGroupState group) {
    setState(() {
      group.ids = 0;
      group.active = false;
      _log.add('Disposed group ${group.name}');
      if (_log.length > 28) {
        _log.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _groups.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.4,
            ),
            itemBuilder: (context, index) {
              final group = _groups[index];
              return Card(
                color: group.color,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(group.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16)),
                      const SizedBox(height: 6),
                      Text('IDs tracked: ${group.ids}'),
                      Text('Active: ${group.active}'),
                      const Spacer(),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () => _register(group),
                            child: const Text('Register'),
                          ),
                          OutlinedButton(
                            onPressed: () => _dispose(group),
                            child: const Text('Dispose'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
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
                const Text('Group Registry Log',
                    style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final item in _log.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text('• $item', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ExtensionRouterPanel extends StatefulWidget {
  const _ExtensionRouterPanel();

  @override
  State<_ExtensionRouterPanel> createState() => _ExtensionRouterPanelState();
}

class _ExtensionRouterPanelState extends State<_ExtensionRouterPanel> {
  WidgetInspectorServiceExtensions _selected =
      WidgetInspectorServiceExtensions.values.first;
  final TextEditingController _arg = TextEditingController(text: 'group=lab');
  final List<String> _events = ['Extension router initialized'];

  @override
  void dispose() {
    _arg.dispose();
    super.dispose();
  }

  void _dispatch() {
    final payload = _arg.text.trim().isEmpty ? '{}' : _arg.text.trim();
    setState(() {
      _events.add(
        '${TimeOfDay.now().format(context)} -> ${_selected.name}($payload)',
      );
      if (_events.length > 32) {
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
                      const Text('Extension dispatch simulator',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 17)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<WidgetInspectorServiceExtensions>(
                        initialValue: _selected,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Extension name',
                        ),
                        items: [
                          for (final ext
                              in WidgetInspectorServiceExtensions.values)
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
                      TextField(
                        controller: _arg,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Payload (debug string)',
                        ),
                      ),
                      const SizedBox(height: 8),
                      FilledButton(
                        onPressed: _dispatch,
                        child: const Text('Dispatch Extension Command'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const _BulletCard(
                title: 'How this maps to real service behavior',
                color: Color(0xFF166534),
                bullets: [
                  'Enum name maps to extension channel identifier.',
                  'Payload encodes argument map for tooling commands.',
                  'Inspector service resolves and executes command handler.',
                  'Response data is consumed by DevTools UI panels.',
                ],
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
                const Text('Dispatch Timeline',
                    style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final event in _events.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child:
                        Text('• $event', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DebugPlaybookPanel extends StatelessWidget {
  const _DebugPlaybookPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _BulletCard(
          title: 'Inspector service workflow checklist',
          color: Color(0xFF0F766E),
          bullets: [
            'Verify extension registration during app boot.',
            'Use object groups for controlled lifecycle of debug IDs.',
            'Track selection transitions to validate tooling interactions.',
            'Capture extension command logs for regression diagnosis.',
          ],
        ),
        _BulletCard(
          title: 'Frequent failure modes',
          color: Color(0xFFB91C1C),
          bullets: [
            'Object IDs leaking because groups are not disposed.',
            'Selection desync between UI overlay and service state.',
            'Extension payload mismatch after schema evolution.',
            'Overly verbose tracking degrading debug session performance.',
          ],
        ),
        _BulletCard(
          title: 'Interpreter-focused demo guidance',
          color: Color(0xFF7C3AED),
          bullets: [
            'Demonstrate command routing with visual timelines.',
            'Show selection and group lifecycle as interactive cards.',
            'Use multiple operational panels, not single static placeholders.',
            'Prefer behavior visualization over assert-heavy unit checks.',
          ],
        ),
      ],
    );
  }
}

class _AtlasCard extends StatelessWidget {
  const _AtlasCard({required this.title, required this.body});

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
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard(
      {required this.title, required this.tint, required this.entries});

  final String title;
  final Color tint;
  final List<String> entries;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: tint,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 8),
              if (entries.isEmpty)
                const Text('• none discovered')
              else
                for (final entry in entries)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $entry'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletCard extends StatelessWidget {
  const _BulletCard(
      {required this.title, required this.color, required this.bullets});

  final String title;
  final Color color;
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
              Text(title,
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w800,
                      fontSize: 16)),
              const SizedBox(height: 8),
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

class _InspectableEntry {
  _InspectableEntry({required this.name, required this.kind});

  final String name;
  final String kind;
  int hits = 0;
  bool active = false;
}

class _ObjectGroupState {
  _ObjectGroupState(this.name, this.color);

  final String name;
  final Color color;
  int ids = 0;
  bool active = false;
}
