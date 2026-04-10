import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _WidgetDeepDemo();
}

const Color _kWidgetBar = Color(0xFF111827);
const Color _kWidgetCanvas = Color(0xFFF8FAFC);

class _WidgetDeepDemo extends StatefulWidget {
  const _WidgetDeepDemo();

  @override
  State<_WidgetDeepDemo> createState() => _WidgetDeepDemoState();
}

class _WidgetDeepDemoState extends State<_WidgetDeepDemo>
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
      backgroundColor: _kWidgetCanvas,
      appBar: AppBar(
        backgroundColor: _kWidgetBar,
        foregroundColor: Colors.white,
        title: const Text('Widget Base-Class Deep Demo'),
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Foundation'),
            Tab(text: 'Hierarchy Wall'),
            Tab(text: 'Identity Lab'),
            Tab(text: 'canUpdate Grid'),
            Tab(text: 'Composition Scenes'),
            Tab(text: 'Trace Console'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: const [
          _WidgetFoundationPanel(),
          _HierarchyWallPanel(),
          _IdentityLabPanel(),
          _CanUpdateGridPanel(),
          _CompositionScenesPanel(),
          _WidgetTracePanel(),
        ],
      ),
    );
  }
}

class _WidgetFoundationPanel extends StatelessWidget {
  const _WidgetFoundationPanel();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _WidgetInfoCard(
          title: 'Widget as immutable configuration',
          tone: Color(0xFF1D4ED8),
          body:
              'Widget objects describe UI configuration and are immutable. '
              'Elements hold runtime position and lifecycle, while RenderObjects '
              'handle layout and paint. Widget is the declarative entry point.',
        ),
        SizedBox(height: 12),
        _WidgetInfoCard(
          title: 'Why this matters in interpreter testing',
          tone: Color(0xFF047857),
          body:
              'Interpreter integration must preserve widget identity semantics, '
              'key behavior, and update decisions. This demo visualizes those '
              'rules with practical scenarios rather than static asserts.',
        ),
        SizedBox(height: 12),
        _WidgetBulletCard(
          title: 'Core APIs to understand',
          tone: Color(0xFF7C3AED),
          bullets: [
            'Widget.canUpdate(oldWidget, newWidget).',
            'key as identity discriminator during rebuilds.',
            'createElement implemented by concrete subclasses.',
            'toStringShort and diagnostics for debugging tree state.',
          ],
        ),
        SizedBox(height: 12),
        _WidgetBulletCard(
          title: 'Failure modes',
          tone: Color(0xFFB91C1C),
          bullets: [
            'Assuming value equality controls updates (it does not).',
            'Unexpected remounts because keys changed accidentally.',
            'Misinterpreting runtimeType differences as style changes only.',
            'Large visual churn from unstable widget construction patterns.',
          ],
        ),
      ],
    );
  }
}

class _HierarchyWallPanel extends StatelessWidget {
  const _HierarchyWallPanel();

  @override
  Widget build(BuildContext context) {
    final items = <({String title, String summary, Color tone})>[
      (
        title: 'Widget',
        summary: 'Immutable configuration unit for UI description.',
        tone: const Color(0xFF1D4ED8),
      ),
      (
        title: 'StatelessWidget',
        summary: 'Configuration without mutable local state.',
        tone: const Color(0xFF0F766E),
      ),
      (
        title: 'StatefulWidget',
        summary: 'Configuration linked to persistent mutable State object.',
        tone: const Color(0xFF7C3AED),
      ),
      (
        title: 'InheritedWidget',
        summary: 'Ambient dependencies distributed down subtree.',
        tone: const Color(0xFFCA8A04),
      ),
      (
        title: 'ProxyWidget',
        summary: 'Intermediate widgets forwarding behavior to children.',
        tone: const Color(0xFF0EA5E9),
      ),
      (
        title: 'Leaf widgets',
        summary: 'Widgets without child subtree, e.g., text, icon.',
        tone: const Color(0xFF16A34A),
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        for (final item in items)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [item.tone.withValues(alpha: 0.82), item.tone],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.summary,
                  style: const TextStyle(color: Colors.white, height: 1.3),
                ),
                const Spacer(),
                const Text(
                  'All derive from Widget',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _IdentityLabPanel extends StatefulWidget {
  const _IdentityLabPanel();

  @override
  State<_IdentityLabPanel> createState() => _IdentityLabPanelState();
}

class _IdentityLabPanelState extends State<_IdentityLabPanel> {
  bool _sameType = true;
  bool _sameKey = true;
  bool _useContainer = false;
  final List<String> _events = <String>['Identity lab initialized.'];

  Widget _oldWidget() {
    if (_useContainer) {
      return Container(
        key: _sameKey ? const ValueKey<String>('shared') : const ValueKey<String>('old'),
        padding: const EdgeInsets.all(8),
        color: const Color(0xFFD1FAE5),
        child: const Text('Old container'),
      );
    }
    return Text(
      'Old text',
      key: _sameKey ? const ValueKey<String>('shared') : const ValueKey<String>('old'),
    );
  }

  Widget _newWidget() {
    if (!_sameType) {
      return Container(
        key: _sameKey ? const ValueKey<String>('shared') : const ValueKey<String>('new'),
        padding: const EdgeInsets.all(8),
        color: const Color(0xFFDBEAFE),
        child: const Text('New container'),
      );
    }
    if (_useContainer) {
      return Container(
        key: _sameKey ? const ValueKey<String>('shared') : const ValueKey<String>('new'),
        padding: const EdgeInsets.all(8),
        color: const Color(0xFFDBEAFE),
        child: const Text('New container'),
      );
    }
    return Text(
      'New text',
      key: _sameKey ? const ValueKey<String>('shared') : const ValueKey<String>('new'),
    );
  }

  void _recompute() {
    final oldWidget = _oldWidget();
    final newWidget = _newWidget();
    final can = Widget.canUpdate(oldWidget, newWidget);
    setState(() {
      _events.add(
        '${DateTime.now().toIso8601String()} | old:${oldWidget.runtimeType}/${oldWidget.key} new:${newWidget.runtimeType}/${newWidget.key} canUpdate:$can',
      );
      if (_events.length > 22) {
        _events.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final oldWidget = _oldWidget();
    final newWidget = _newWidget();
    final can = Widget.canUpdate(oldWidget, newWidget);

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
                    children: [
                      SwitchListTile(
                        title: const Text('Same type'),
                        subtitle: const Text('Toggle runtimeType compatibility.'),
                        value: _sameType,
                        onChanged: (v) => setState(() => _sameType = v),
                      ),
                      SwitchListTile(
                        title: const Text('Same key'),
                        subtitle: const Text('Toggle key compatibility.'),
                        value: _sameKey,
                        onChanged: (v) => setState(() => _sameKey = v),
                      ),
                      SwitchListTile(
                        title: const Text('Use Container baseline'),
                        subtitle: const Text('Switch old/new source widget family.'),
                        value: _useContainer,
                        onChanged: (v) => setState(() => _useContainer = v),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _recompute,
                        child: const Text('Record evaluation'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Old widget: ${oldWidget.runtimeType} key:${oldWidget.key}'),
                      Text('New widget: ${newWidget.runtimeType} key:${newWidget.key}'),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: can
                              ? const Color(0xFFDCFCE7)
                              : const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Widget.canUpdate -> $can',
                          style: TextStyle(
                            color: can
                                ? const Color(0xFF166534)
                                : const Color(0xFF991B1B),
                            fontWeight: FontWeight.w800,
                          ),
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
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final line = _events[_events.length - 1 - index];
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

class _CanUpdateGridPanel extends StatelessWidget {
  const _CanUpdateGridPanel();

  @override
  Widget build(BuildContext context) {
    final rows = <({String caseName, Widget oldWidget, Widget newWidget})>[
      (
        caseName: 'Text no-key -> Text no-key',
        oldWidget: const Text('A'),
        newWidget: const Text('B'),
      ),
      (
        caseName: 'Text key:a -> Text key:a',
        oldWidget: const Text('A', key: ValueKey<String>('a')),
        newWidget: const Text('B', key: ValueKey<String>('a')),
      ),
      (
        caseName: 'Text key:a -> Text key:b',
        oldWidget: const Text('A', key: ValueKey<String>('a')),
        newWidget: const Text('B', key: ValueKey<String>('b')),
      ),
      (
        caseName: 'Text -> Container',
        oldWidget: const Text('A'),
        newWidget: const SizedBox.shrink(),
      ),
      (
        caseName: 'Container key:x -> Container key:x',
        oldWidget: Container(key: const ValueKey<String>('x')),
        newWidget: Container(key: const ValueKey<String>('x')),
      ),
      (
        caseName: 'Container null-key -> Container key:x',
        oldWidget: Container(),
        newWidget: Container(key: const ValueKey<String>('x')),
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const _WidgetInfoCard(
          title: 'canUpdate decision matrix',
          tone: Color(0xFF1E40AF),
          body:
              'canUpdate compares runtimeType and key. When both are compatible, '
              'framework updates existing element. Otherwise subtree replacement '
              'is triggered.',
        ),
        const SizedBox(height: 10),
        Card(
          clipBehavior: Clip.antiAlias,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Case')),
              DataColumn(label: Text('Old')),
              DataColumn(label: Text('New')),
              DataColumn(label: Text('canUpdate')),
            ],
            rows: [
              for (final row in rows)
                DataRow(
                  cells: [
                    DataCell(Text(row.caseName)),
                    DataCell(Text('${row.oldWidget.runtimeType}/${row.oldWidget.key}')),
                    DataCell(Text('${row.newWidget.runtimeType}/${row.newWidget.key}')),
                    DataCell(
                      Text(
                        Widget.canUpdate(row.oldWidget, row.newWidget).toString(),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CompositionScenesPanel extends StatelessWidget {
  const _CompositionScenesPanel();

  @override
  Widget build(BuildContext context) {
    final scenes = <({String title, Widget content, String note, Color tone})>[
      (
        title: 'Stateless scene',
        content: const _MiniStatelessCard(),
        note: 'Simple immutable configuration usage.',
        tone: const Color(0xFF1D4ED8),
      ),
      (
        title: 'Stateful scene',
        content: const _MiniStatefulCard(),
        note: 'Widget + State lifecycle relationship.',
        tone: const Color(0xFF7C3AED),
      ),
      (
        title: 'Inherited scene',
        content: const _MiniInheritedScene(),
        note: 'Ambient dependencies flowing through tree.',
        tone: const Color(0xFF16A34A),
      ),
      (
        title: 'Proxy scene',
        content: const _MiniProxyScene(),
        note: 'Proxy wrappers layering behavior.',
        tone: const Color(0xFF0F766E),
      ),
    ];

    return GridView.count(
      padding: const EdgeInsets.all(14),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.22,
      children: [
        for (final scene in scenes)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scene.title,
                    style: TextStyle(
                      color: scene.tone,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(height: 110, child: scene.content),
                  const Spacer(),
                  Text(scene.note),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _WidgetTracePanel extends StatefulWidget {
  const _WidgetTracePanel();

  @override
  State<_WidgetTracePanel> createState() => _WidgetTracePanelState();
}

class _WidgetTracePanelState extends State<_WidgetTracePanel> {
  final List<String> _trace = <String>['Trace console ready.'];

  void _log(Widget oldWidget, Widget newWidget) {
    final can = Widget.canUpdate(oldWidget, newWidget);
    setState(() {
      _trace.add(
        '${DateTime.now().toIso8601String()} | ${oldWidget.runtimeType}/${oldWidget.key} -> ${newWidget.runtimeType}/${newWidget.key} canUpdate:$can',
      );
      if (_trace.length > 20) {
        _trace.removeAt(0);
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
              onPressed: () => _log(const Text('A'), const Text('B')),
              child: const Text('Text -> Text'),
            ),
            ElevatedButton(
              onPressed: () => _log(
                const Text('A', key: ValueKey<String>('a')),
                const Text('B', key: ValueKey<String>('b')),
              ),
              child: const Text('Key mismatch'),
            ),
            ElevatedButton(
              onPressed: () => _log(const Text('A'), Container()),
              child: const Text('Type mismatch'),
            ),
            ElevatedButton(
              onPressed: () => _log(
                Container(key: const ValueKey<String>('x')),
                Container(key: const ValueKey<String>('x')),
              ),
              child: const Text('Container same key'),
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
              itemCount: _trace.length,
              itemBuilder: (context, index) {
                final line = _trace[_trace.length - 1 - index];
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

class _WidgetInfoCard extends StatelessWidget {
  const _WidgetInfoCard({
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

class _WidgetBulletCard extends StatelessWidget {
  const _WidgetBulletCard({
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
            for (final bullet in bullets)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('- ', style: TextStyle(color: tone)),
                    Expanded(child: Text(bullet)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniStatelessCard extends StatelessWidget {
  const _MiniStatelessCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2FE),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: const Text('StatelessWidget sample'),
    );
  }
}

class _MiniStatefulCard extends StatefulWidget {
  const _MiniStatefulCard();

  @override
  State<_MiniStatefulCard> createState() => _MiniStatefulCardState();
}

class _MiniStatefulCardState extends State<_MiniStatefulCard> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDE9FE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $_count'),
            TextButton(
              onPressed: () => setState(() => _count += 1),
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniInheritedScene extends InheritedWidget {
  const _MiniInheritedScene() : super(child: const _InheritedConsumer());

  static _MiniInheritedScene? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_MiniInheritedScene>();
  }

  @override
  bool updateShouldNotify(covariant _MiniInheritedScene oldWidget) {
    return false;
  }
}

class _InheritedConsumer extends StatelessWidget {
  const _InheritedConsumer();

  @override
  Widget build(BuildContext context) {
    final inherited = _MiniInheritedScene.maybeOf(context);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text('Inherited available: ${inherited != null}'),
    );
  }
}

class _MiniProxyScene extends StatelessWidget {
  const _MiniProxyScene();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFEDD5),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: const Opacity(
        opacity: 0.9,
        child: Text('Proxy layers: Padding + Opacity'),
      ),
    );
  }
}
