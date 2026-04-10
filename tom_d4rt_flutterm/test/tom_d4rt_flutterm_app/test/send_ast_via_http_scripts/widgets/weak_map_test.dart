import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WeakMapDeepDemo();
}

const Color _kTop = Color(0xFF0F172A);
const Color _kBackdrop = Color(0xFFF8FAFC);

class _WeakMapDeepDemo extends StatefulWidget {
  const _WeakMapDeepDemo();

  @override
  State<_WeakMapDeepDemo> createState() => _WeakMapDeepDemoState();
}

class _WeakMapDeepDemoState extends State<_WeakMapDeepDemo>
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
      backgroundColor: _kBackdrop,
      appBar: AppBar(
        backgroundColor: _kTop,
        foregroundColor: Colors.white,
        title: const Text('WeakMap Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Concept Matrix'),
            Tab(text: 'Object Key Arena'),
            Tab(text: 'Primitive Lane'),
            Tab(text: 'Inspector Metadata'),
            Tab(text: 'Guidance Board'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _ConceptMatrixPanel(),
          _ObjectKeyArenaPanel(),
          _PrimitiveLanePanel(),
          _InspectorMetadataPanel(),
          _GuidanceBoardPanel(),
        ],
      ),
    );
  }
}

class _ConceptMatrixPanel extends StatelessWidget {
  const _ConceptMatrixPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _LeadCard(
          title: 'WeakMap purpose',
          body:
              'WeakMap associates values to keys while allowing object keys to be '
              'garbage collected. This is essential for metadata side channels that '
              'must not own lifecycle of inspected objects.',
        ),
        SizedBox(height: 10),
        _MatrixCard(
          title: 'Hybrid storage strategy',
          tint: Color(0xFF1D4ED8),
          rows: [
            'Object keys -> weak semantics (Expando-backed behavior).',
            'Primitive keys -> strong map semantics fallback.',
            'Single API for both key classes.',
            'Designed for framework diagnostics and inspector metadata.',
          ],
        ),
        _MatrixCard(
          title: 'Why not a plain Map',
          tint: Color(0xFFB91C1C),
          rows: [
            'Map strongly references keys and can keep dead objects alive.',
            'WeakMap enables attachment without ownership.',
            'Important in long-lived tooling sessions.',
            'Reduces accidental memory retention in metadata systems.',
          ],
        ),
        _MatrixCard(
          title: 'Operational constraints',
          tint: Color(0xFF166534),
          rows: [
            'Do not expect full key enumeration for weak associations.',
            'Treat it as lookup channel from known key object.',
            'Store compact values to limit diagnostic overhead.',
            'Use explicit cleanup for primitive-key sections when needed.',
          ],
        ),
      ],
    );
  }
}

class _ObjectKeyArenaPanel extends StatefulWidget {
  const _ObjectKeyArenaPanel();

  @override
  State<_ObjectKeyArenaPanel> createState() => _ObjectKeyArenaPanelState();
}

class _ObjectKeyArenaPanelState extends State<_ObjectKeyArenaPanel> {
  final WeakMap<Object, _WeakPayload> _objectMap = WeakMap<Object, _WeakPayload>();

  final List<_ObjectHandle> _handles = [
    _ObjectHandle('Element-A', Color(0xFFDBEAFE)),
    _ObjectHandle('Element-B', Color(0xFFD1FAE5)),
    _ObjectHandle('Element-C', Color(0xFFEDE9FE)),
    _ObjectHandle('Element-D', Color(0xFFFEF3C7)),
  ];

  final List<String> _journal = ['Object-key arena initialized'];

  void _tag(_ObjectHandle handle) {
    final old = _objectMap[handle.token];
    final next = _WeakPayload(
      label: handle.label,
      tags: (old?.tags ?? 0) + 1,
      stamp: DateTime.now().toIso8601String(),
    );

    setState(() {
      _objectMap[handle.token] = next;
      _journal.add('Tagged ${handle.label} -> tags=${next.tags}');
      if (_journal.length > 30) {
        _journal.removeAt(0);
      }
    });
  }

  void _query(_ObjectHandle handle) {
    final payload = _objectMap[handle.token];
    setState(() {
      _journal.add(
        payload == null
            ? 'Query ${handle.label} -> no payload'
            : 'Query ${handle.label} -> tags=${payload.tags}',
      );
      if (_journal.length > 30) {
        _journal.removeAt(0);
      }
    });
  }

  void _detach(_ObjectHandle handle) {
    setState(() {
      _objectMap[handle.token] = _WeakPayload(
        label: handle.label,
        tags: 0,
        stamp: 'detached',
      );
      _journal.add('Marked ${handle.label} payload as detached');
      if (_journal.length > 30) {
        _journal.removeAt(0);
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
            itemCount: _handles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.25,
            ),
            itemBuilder: (context, index) {
              final handle = _handles[index];
              final data = _objectMap[handle.token];
              return Card(
                color: handle.color,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(handle.label, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                      const SizedBox(height: 6),
                      Text('Payload tags: ${data?.tags ?? 0}'),
                      Text('Attached: ${data != null}'),
                      const SizedBox(height: 6),
                      Text(
                        data == null
                            ? 'No metadata currently attached'
                            : 'Last stamp: ${_tailStamp(data.stamp)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          FilledButton.tonal(
                            onPressed: () => _tag(handle),
                            child: const Text('Tag'),
                          ),
                          OutlinedButton(
                            onPressed: () => _query(handle),
                            child: const Text('Query'),
                          ),
                          OutlinedButton(
                            onPressed: () => _detach(handle),
                            child: const Text('Detach'),
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
                const Text('Object-Key Journal', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _journal.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('• $line', style: const TextStyle(fontSize: 12)),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _tailStamp(String stamp) {
    if (stamp.length < 19) {
      return stamp;
    }
    return stamp.substring(11, 19);
  }
}

class _PrimitiveLanePanel extends StatefulWidget {
  const _PrimitiveLanePanel();

  @override
  State<_PrimitiveLanePanel> createState() => _PrimitiveLanePanelState();
}

class _PrimitiveLanePanelState extends State<_PrimitiveLanePanel> {
  final WeakMap<Object, String> _primitiveMap = WeakMap<Object, String>();
  final List<String> _log = ['Primitive lane ready'];

  final List<Object> _keys = <Object>[
    7,
    42,
    'devtools',
    true,
    3.14,
    false,
  ];

  String _lookup = 'No lookup yet';

  void _write(Object key) {
    final value = 'value-${DateTime.now().millisecond}-${key.runtimeType}';
    setState(() {
      _primitiveMap[key] = value;
      _log.add('write key=$key -> $value');
      if (_log.length > 28) {
        _log.removeAt(0);
      }
    });
  }

  void _read(Object key) {
    final value = _primitiveMap[key];
    setState(() {
      _lookup = 'key=$key => ${value ?? 'null'}';
      _log.add('read key=$key -> ${value ?? 'null'}');
      if (_log.length > 28) {
        _log.removeAt(0);
      }
    });
  }

  void _clear(Object key) {
    setState(() {
      _primitiveMap[key] = '<cleared>';
      _log.add('clear key=$key -> <cleared>');
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
                      const Text('Primitive-key operations', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                      const SizedBox(height: 8),
                      const Text(
                        'This demonstrates WeakMap fallback behavior for primitive-like keys. '
                        'From a demo perspective, read/write/clear semantics remain consistent.',
                      ),
                      const SizedBox(height: 10),
                      for (final key in _keys)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Text('Key: $key (${key.runtimeType})')),
                              OutlinedButton(
                                onPressed: () => _write(key),
                                child: const Text('Write'),
                              ),
                              const SizedBox(width: 6),
                              OutlinedButton(
                                onPressed: () => _read(key),
                                child: const Text('Read'),
                              ),
                              const SizedBox(width: 6),
                              OutlinedButton(
                                onPressed: () => _clear(key),
                                child: const Text('Clear'),
                              ),
                            ],
                          ),
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
                  child: Text('Current lookup: $_lookup'),
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
                const Text('Primitive Log', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final line in _log.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
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

class _InspectorMetadataPanel extends StatefulWidget {
  const _InspectorMetadataPanel();

  @override
  State<_InspectorMetadataPanel> createState() => _InspectorMetadataPanelState();
}

class _InspectorMetadataPanelState extends State<_InspectorMetadataPanel> {
  final WeakMap<Object, _InspectorTag> _tagMap = WeakMap<Object, _InspectorTag>();
  final List<_InspectorNode> _nodes = [
    _InspectorNode('RootColumn', Color(0xFFDBEAFE)),
    _InspectorNode('MenuPane', Color(0xFFD1FAE5)),
    _InspectorNode('DetailsPanel', Color(0xFFEDE9FE)),
    _InspectorNode('FooterBar', Color(0xFFFCE7F3)),
  ];
  final List<String> _events = ['Inspector metadata panel initialized'];

  void _annotate(_InspectorNode node) {
    final prev = _tagMap[node.handle];
    final hits = (prev?.hits ?? 0) + 1;
    final next = _InspectorTag(owner: node.name, hits: hits, note: 'tagged-$hits');
    setState(() {
      _tagMap[node.handle] = next;
      _events.add('Annotated ${node.name} (hits=$hits)');
      if (_events.length > 30) {
        _events.removeAt(0);
      }
    });
  }

  void _inspect(_InspectorNode node) {
    final tag = _tagMap[node.handle];
    setState(() {
      _events.add(
        tag == null
            ? 'Inspect ${node.name} -> no metadata'
            : 'Inspect ${node.name} -> ${tag.note}',
      );
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
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: _nodes.length,
            itemBuilder: (context, index) {
              final node = _nodes[index];
              final tag = _tagMap[node.handle];
              return Card(
                color: node.color,
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(node.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      Text('Metadata attached: ${tag != null}'),
                      Text('Hits: ${tag?.hits ?? 0}'),
                      Text('Note: ${tag?.note ?? '-'}'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () => _annotate(node),
                            child: const Text('Annotate'),
                          ),
                          OutlinedButton(
                            onPressed: () => _inspect(node),
                            child: const Text('Inspect'),
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
                const Text('Inspector Event Stream', style: TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                for (final e in _events.reversed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
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

class _GuidanceBoardPanel extends StatelessWidget {
  const _GuidanceBoardPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _MatrixCard(
          title: 'Implementation guidance',
          tint: Color(0xFF0F766E),
          rows: [
            'Attach metadata to ephemeral framework objects safely.',
            'Prefer deterministic value payloads for easy diagnostics.',
            'Use explicit detach for known lifecycle boundaries.',
            'Keep metadata compact and debug-oriented.',
          ],
        ),
        _MatrixCard(
          title: 'Do not misuse WeakMap',
          tint: Color(0xFFB91C1C),
          rows: [
            'Not a replacement for iterable state stores.',
            'Not ideal when full key enumeration is required.',
            'Avoid large graphs in attached values.',
            'Do not rely on weak semantics for primitive-only workflows.',
          ],
        ),
        _MatrixCard(
          title: 'Interpreter demo checklist',
          tint: Color(0xFF7C3AED),
          rows: [
            'Show object-key association with visible state updates.',
            'Show primitive-key fallback route separately.',
            'Demonstrate attach/query/detach lifecycle flow.',
            'Provide inspector-style scenario for real context.',
          ],
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

class _MatrixCard extends StatelessWidget {
  const _MatrixCard({required this.title, required this.tint, required this.rows});

  final String title;
  final Color tint;
  final List<String> rows;

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
              Text(title, style: TextStyle(color: tint, fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 8),
              for (final row in rows)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $row'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ObjectHandle {
  _ObjectHandle(this.label, this.color);

  final String label;
  final Color color;
  final Object token = Object();
}

class _WeakPayload {
  const _WeakPayload({required this.label, required this.tags, required this.stamp});

  final String label;
  final int tags;
  final String stamp;
}

class _InspectorNode {
  _InspectorNode(this.name, this.color);

  final String name;
  final Color color;
  final Object handle = Object();
}

class _InspectorTag {
  const _InspectorTag({required this.owner, required this.hits, required this.note});

  final String owner;
  final int hits;
  final String note;
}
