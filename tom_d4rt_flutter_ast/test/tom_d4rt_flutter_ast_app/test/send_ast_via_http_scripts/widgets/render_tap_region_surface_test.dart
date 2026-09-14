import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level state (ValueNotifier – stateless widgets observe via
// ValueListenableBuilder; no StatefulWidget used anywhere).
// ---------------------------------------------------------------------------

final ValueNotifier<List<String>> _log = ValueNotifier<List<String>>([]);
final ValueNotifier<int?> _activeCard = ValueNotifier<int?>(null);
final ValueNotifier<bool> _consumeOutside = ValueNotifier<bool>(false);
final ValueNotifier<int?> _firedRegion = ValueNotifier<int?>(null);
final ValueNotifier<String?> _firedGroupId = ValueNotifier<String?>(null);
final ValueNotifier<bool> _dropdownOpen = ValueNotifier<bool>(false);
final ValueNotifier<String> _dropdownSelected =
    ValueNotifier<String>('Choose an item…');

// ---------------------------------------------------------------------------
// Entry point required by the harness.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    home: const _RenderTapRegionSurfaceDemo(),
  );
}

// ---------------------------------------------------------------------------
// Root scaffold with DefaultTabController (9 tabs).
// ---------------------------------------------------------------------------

class _RenderTapRegionSurfaceDemo extends StatelessWidget {
  const _RenderTapRegionSurfaceDemo();

  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Hero'),
    Tab(text: 'Live Demo'),
    Tab(text: 'Multi Region'),
    Tab(text: 'GroupId'),
    Tab(text: 'consumeOutside'),
    Tab(text: 'Architecture'),
    Tab(text: 'Dropdown'),
    Tab(text: 'Comparison'),
    Tab(text: 'Pitfalls & API'),
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          title: const Text('RenderTapRegionSurface Deep Demo'),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: cs.onPrimary,
            unselectedLabelColor: cs.onPrimary.withAlpha(180),
            indicatorColor: cs.onPrimary,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _LiveDemoTab(),
            _MultiRegionTab(),
            _GroupIdTab(),
            _ConsumeOutsideTab(),
            _ArchitectureTab(),
            _DropdownTab(),
            _ComparisonTab(),
            _PitfallsApiTab(),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 1 – Hero Banner
// ===========================================================================

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ── Banner card ──────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[cs.primary, cs.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.touch_app, size: 56, color: cs.onPrimary),
                const SizedBox(height: 16),
                Text(
                  'RenderTapRegionSurface',
                  style: tt.headlineMedium?.copyWith(
                    color: cs.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'The RenderObject underlying TapRegionSurface — the '
                  'coordinator that routes pointer events to a registered '
                  'set of TapRegion children.',
                  style: tt.bodyLarge?.copyWith(color: cs.onPrimary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // ── Intro prose ─────────────────────────────────────────────────
          Text('What is TapRegionSurface?', style: tt.titleLarge),
          const SizedBox(height: 8),
          Text(
            'TapRegionSurface is a Flutter widget that acts as the '
            'coordinator for a group of TapRegion descendants. It installs '
            'a RenderTapRegionSurface in the render tree, which intercepts '
            'every pointer-down event passing through the surface and checks '
            'it against all registered TapRegion render objects.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text('The tap-outside pattern', style: tt.titleLarge),
          const SizedBox(height: 8),
          Text(
            'When a pointer-down lands INSIDE at least one registered '
            'TapRegion, nothing special happens — the event propagates '
            'normally. When a pointer-down lands OUTSIDE ALL registered '
            'TapRegions, the surface calls each region\'s onTapOutside '
            'callback. This "tap outside to dismiss" pattern is used '
            'throughout Flutter\'s Material library for menus, dropdowns, '
            'date pickers, and tooltips.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),
          // ── Key facts chips ──────────────────────────────────────────────
          Text('Key facts', style: tt.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _InfoChip(label: 'RenderProxyBox subclass'),
              _InfoChip(label: 'Intercepts pointer events'),
              _InfoChip(label: 'Manages TapRegion registry'),
              _InfoChip(label: 'Fires onTapOutside callbacks'),
              _InfoChip(label: 'Supports groupId grouping'),
              _InfoChip(label: 'consumeOutsideTaps option'),
              _InfoChip(label: 'Used by menus & dropdowns'),
              _InfoChip(label: 'No state needed in widgets'),
            ],
          ),
          const SizedBox(height: 24),
          // ── Class hierarchy ──────────────────────────────────────────────
          Text('Class hierarchy', style: tt.titleMedium),
          const SizedBox(height: 8),
          _CodeBlock(code: '''
RenderObject
 └─ RenderBox
     └─ RenderProxyBox
         └─ RenderTapRegionSurface

TapRegionSurface (Widget)
 └─ SingleChildRenderObjectWidget
     builds RenderTapRegionSurface
'''),
          const SizedBox(height: 24),
          // ── Roles diagram ────────────────────────────────────────────────
          Text('Roles', style: tt.titleMedium),
          const SizedBox(height: 12),
          _RolesTable(),
        ],
      ),
    );
  }
}

class _RolesTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final rows = <List<String>>[
      ['TapRegionSurface', 'Widget that installs the surface in the tree'],
      ['RenderTapRegionSurface', 'RenderObject; intercepts hit tests'],
      ['TapRegion', 'Marks a subtree as a named region'],
      ['RenderTapRegion', 'Registers itself with the nearest surface'],
      ['groupId', 'Merges multiple regions into one logical unit'],
      ['onTapOutside', 'Callback fired when tap lands outside the region'],
    ];
    return Table(
      border: TableBorder.all(color: cs.outlineVariant),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(color: cs.primaryContainer),
          children: <Widget>[
            _TCell('Symbol', header: true),
            _TCell('Role', header: true),
          ],
        ),
        for (final row in rows)
          TableRow(
            children: <Widget>[
              _TCell(row[0]),
              _TCell(row[1]),
            ],
          ),
      ],
    );
  }
}

class _TCell extends StatelessWidget {
  const _TCell(this.text, {this.header = false});
  final String text;
  final bool header;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Text(
        text,
        style: header ? tt.labelMedium?.copyWith(fontWeight: FontWeight.bold) : tt.bodySmall,
      ),
    );
  }
}

// ===========================================================================
// TAB 2 – Live TapRegionSurface Demo
// ===========================================================================

class _LiveDemoTab extends StatelessWidget {
  const _LiveDemoTab();

  void _addLog(String msg) {
    final prev = List<String>.from(_log.value);
    prev.insert(0, msg);
    if (prev.length > 30) prev.removeLast();
    _log.value = prev;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        // ── Instructions ─────────────────────────────────────────────────
        Container(
          width: double.infinity,
          color: cs.secondaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'TapRegionSurface wraps the area below. Three cards are '
            'wrapped in TapRegion. Tap inside a card or on the grey '
            'background and watch the log.',
            style: tt.bodySmall,
          ),
        ),
        // ── Interactive area ─────────────────────────────────────────────
        Expanded(
          flex: 3,
          child: TapRegionSurface(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (_) => _addLog('↳ background tapped (outside all regions)'),
              child: Container(
                color: cs.surfaceContainerHighest,
                child: Center(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      for (int i = 1; i <= 3; i++)
                        TapRegion(
                          onTapInside: (_) {
                            _activeCard.value = i;
                            _addLog('✓ Inside card $i');
                          },
                          onTapOutside: (_) {
                            if (_activeCard.value == i) _activeCard.value = null;
                            _addLog('✗ Tapped outside card $i');
                          },
                          child: ValueListenableBuilder<int?>(
                            valueListenable: _activeCard,
                            builder: (context, active, _) => _LiveCard(
                              index: i,
                              active: active == i,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // ── Log panel ────────────────────────────────────────────────────
        Expanded(
          flex: 2,
          child: _LogPanel(log: _log),
        ),
      ],
    );
  }
}

class _LiveCard extends StatelessWidget {
  const _LiveCard({required this.index, required this.active});
  final int index;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 130,
      height: 100,
      decoration: BoxDecoration(
        color: active ? cs.primaryContainer : cs.surface,
        border: Border.all(
          color: active ? cs.primary : cs.outline,
          width: active ? 3 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: active
            ? <BoxShadow>[
                BoxShadow(
                  color: cs.primary.withAlpha(80),
                  blurRadius: 12,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.touch_app,
              color: active ? cs.primary : cs.onSurfaceVariant,
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              'Card $index',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: active ? cs.primary : cs.onSurface,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 3 – Multiple Tap Regions
// ===========================================================================

class _MultiRegionTab extends StatelessWidget {
  const _MultiRegionTab();

  static const List<_RegionDef> _regions = <_RegionDef>[
    _RegionDef(1, 'Alpha', Colors.red),
    _RegionDef(2, 'Beta', Colors.orange),
    _RegionDef(3, 'Gamma', Colors.green),
    _RegionDef(4, 'Delta', Colors.blue),
    _RegionDef(5, 'Epsilon', Colors.purple),
  ];

  void _addLog(String msg) {
    final prev = List<String>.from(_log.value);
    prev.insert(0, msg);
    if (prev.length > 30) prev.removeLast();
    _log.value = prev;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: cs.secondaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Five TapRegions are registered with the same surface. Each has '
            'its own onTapOutside. Tap any tile to see which regions fire.',
            style: tt.bodySmall,
          ),
        ),
        Expanded(
          flex: 3,
          child: TapRegionSurface(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: <Widget>[
                for (final def in _regions)
                  TapRegion(
                    onTapInside: (_) {
                      _firedRegion.value = def.id;
                      _addLog('▶ Tapped INSIDE region ${def.name}');
                    },
                    onTapOutside: (_) {
                      _addLog('  ↳ onTapOutside fired for ${def.name}');
                    },
                    child: ValueListenableBuilder<int?>(
                      valueListenable: _firedRegion,
                      builder: (context, fired, _) => _ColorTile(
                        def: def,
                        active: fired == def.id,
                      ),
                    ),
                  ),
                // Sixth cell: clear button (no TapRegion)
                Center(
                  child: FilledButton.icon(
                    onPressed: () {
                      _firedRegion.value = null;
                      _log.value = <String>[];
                    },
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _LogPanel(log: _log),
        ),
      ],
    );
  }
}

class _RegionDef {
  const _RegionDef(this.id, this.name, this.color);
  final int id;
  final String name;
  final MaterialColor color;
}

class _ColorTile extends StatelessWidget {
  const _ColorTile({required this.def, required this.active});
  final _RegionDef def;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: active ? def.color.shade200 : def.color.shade50,
        border: Border.all(
          color: def.color.shade400,
          width: active ? 3 : 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          def.name,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: def.color.shade800),
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 4 – GroupId Feature
// ===========================================================================

class _GroupIdTab extends StatelessWidget {
  const _GroupIdTab();

  static const String _groupA = 'group-A';
  static const String _groupB = 'group-B';

  void _addLog(String msg) {
    final prev = List<String>.from(_log.value);
    prev.insert(0, msg);
    if (prev.length > 30) prev.removeLast();
    _log.value = prev;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: cs.secondaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Two regions share groupId "$_groupA" (purple). A tap inside '
            'either does NOT fire onTapOutside for the other. '
            'One lone region uses groupId "$_groupB" (teal).',
            style: tt.bodySmall,
          ),
        ),
        Expanded(
          flex: 3,
          child: TapRegionSurface(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  // Group A label
                  _SectionLabel('Group A ($_groupA) — two regions acting as one'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: TapRegion(
                          groupId: _groupA,
                          onTapInside: (_) {
                            _firedGroupId.value = _groupA;
                            _addLog('✓ Inside Group A — Left panel');
                          },
                          onTapOutside: (_) {
                            _addLog('✗ Outside Group A — Left panel');
                          },
                          child: _GroupCard(
                            label: 'A – Left',
                            color: Colors.deepPurple,
                            notifier: _firedGroupId,
                            matchGroup: _groupA,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TapRegion(
                          groupId: _groupA,
                          onTapInside: (_) {
                            _firedGroupId.value = _groupA;
                            _addLog('✓ Inside Group A — Right panel');
                          },
                          onTapOutside: (_) {
                            _addLog('✗ Outside Group A — Right panel');
                          },
                          child: _GroupCard(
                            label: 'A – Right',
                            color: Colors.deepPurple,
                            notifier: _firedGroupId,
                            matchGroup: _groupA,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _SectionLabel('Group B ($_groupB) — standalone region'),
                  const SizedBox(height: 10),
                  TapRegion(
                    groupId: _groupB,
                    onTapInside: (_) {
                      _firedGroupId.value = _groupB;
                      _addLog('✓ Inside Group B');
                    },
                    onTapOutside: (_) {
                      _addLog('✗ Outside Group B');
                    },
                    child: _GroupCard(
                      label: 'B – Standalone',
                      color: Colors.teal,
                      notifier: _firedGroupId,
                      matchGroup: _groupB,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Explanation
                  Card(
                    color: cs.tertiaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('How groupId works', style: tt.titleSmall),
                          const SizedBox(height: 6),
                          Text(
                            'When the surface checks if a tap is "inside", it '
                            'considers all regions sharing the same groupId as '
                            'a single logical region. A tap inside any member '
                            'of the group suppresses onTapOutside for ALL '
                            'members of that group.',
                            style: tt.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _LogPanel(log: _log),
        ),
      ],
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({
    required this.label,
    required this.color,
    required this.notifier,
    required this.matchGroup,
  });
  final String label;
  final MaterialColor color;
  final ValueNotifier<String?> notifier;
  final String matchGroup;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: notifier,
      builder: (context, group, _) {
        final active = group == matchGroup;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 80,
          decoration: BoxDecoration(
            color: active ? color.shade200 : color.shade50,
            border: Border.all(
              color: color.shade400,
              width: active ? 3 : 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: color.shade800),
            ),
          ),
        );
      },
    );
  }
}

// ===========================================================================
// TAB 5 – consumeOutsideTaps
// ===========================================================================

class _ConsumeOutsideTab extends StatelessWidget {
  const _ConsumeOutsideTab();

  void _addLog(String msg) {
    final prev = List<String>.from(_log.value);
    prev.insert(0, msg);
    if (prev.length > 30) prev.removeLast();
    _log.value = prev;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: cs.secondaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Toggle consumeOutsideTaps. When ON, pointer events that land '
            'outside all TapRegions are absorbed — they will not reach '
            'the GestureDetector on the background.',
            style: tt.bodySmall,
          ),
        ),
        // Toggle row
        ValueListenableBuilder<bool>(
          valueListenable: _consumeOutside,
          builder: (context, consume, _) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: <Widget>[
                const Text('consumeOutsideTaps'),
                const Spacer(),
                Switch(
                  value: consume,
                  onChanged: (v) => _consumeOutside.value = v,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(consume ? 'ON' : 'OFF'),
                  backgroundColor:
                      consume ? cs.primaryContainer : cs.errorContainer,
                ),
              ],
            ),
          ),
        ),
        // Interactive area
        Expanded(
          flex: 3,
          child: ValueListenableBuilder<bool>(
            valueListenable: _consumeOutside,
            builder: (context, consume, _) => TapRegionSurface(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (_) => _addLog(
                  consume
                      ? '🚫 Background GestureDetector — NOT reached (taps consumed)'
                      : '✓ Background GestureDetector reached',
                ),
                child: Container(
                  color: cs.surfaceContainerHighest,
                  child: Center(
                    child: TapRegion(
                      consumeOutsideTaps: consume,
                      onTapInside: (_) =>
                          _addLog('✓ Inside the purple TapRegion'),
                      onTapOutside: (_) =>
                          _addLog('↳ onTapOutside fired for region'),
                      child: Container(
                        width: 200,
                        height: 140,
                        decoration: BoxDecoration(
                          color: cs.primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: cs.primary, width: 2),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.touch_app,
                                  color: cs.primary, size: 32),
                              const SizedBox(height: 8),
                              Text(
                                'TapRegion',
                                style: tt.titleMedium
                                    ?.copyWith(color: cs.primary),
                              ),
                              Text('Tap inside or outside',
                                  style: tt.bodySmall),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Explanation
        Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            color: cs.tertiaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Effect of consumeOutsideTaps', style: tt.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    'When true, the surface calls event.handled = true on '
                    'outside taps, so the HitTestResult is marked handled '
                    'and other GestureDetectors in the tree won\'t see '
                    'the pointer-down event.',
                    style: tt.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _LogPanel(log: _log),
        ),
      ],
    );
  }
}

// ===========================================================================
// TAB 6 – Architecture Diagram (CustomPainter)
// ===========================================================================

class _ArchitectureTab extends StatelessWidget {
  const _ArchitectureTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Pointer Event Routing Architecture', style: tt.titleLarge),
          const SizedBox(height: 4),
          Text(
            'How RenderTapRegionSurface intercepts and routes pointer events:',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 420,
            child: CustomPaint(
              painter: _ArchitecturePainter(cs: cs),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 24),
          Text('Step-by-step walkthrough', style: tt.titleMedium),
          const SizedBox(height: 8),
          const _StepCard(
            step: '1',
            title: 'Pointer down',
            detail: 'User finger lands on screen. Flutter dispatch calls '
                'hitTest() through the render tree.',
          ),
          const _StepCard(
            step: '2',
            title: 'HitTestEntry added',
            detail: 'RenderTapRegionSurface adds itself to the HitTestResult '
                'via addWithPaintTransform.',
          ),
          const _StepCard(
            step: '3',
            title: 'handleEvent',
            detail: 'On PointerDownEvent, the surface iterates ALL registered '
                'RenderTapRegion objects and checks whether the event '
                'position falls within each one\'s bounding box.',
          ),
          const _StepCard(
            step: '4',
            title: 'Inside / outside determination',
            detail: 'For each TapRegion (and its groupId members), if the '
                'hit test result contains a descendant of that region, it '
                'is considered "inside". Otherwise it is "outside".',
          ),
          const _StepCard(
            step: '5',
            title: 'onTapOutside callbacks',
            detail: 'For each region where the tap was outside, the surface '
                'calls onTapOutside(event). Regions inside the tap are '
                'untouched.',
          ),
          const _StepCard(
            step: '6',
            title: 'consumeOutsideTaps',
            detail: 'If any outside-tapped region has consumeOutsideTaps=true, '
                'the surface marks the event as handled, preventing '
                'further propagation.',
          ),
          const SizedBox(height: 20),
          Text('Key implementation detail', style: tt.titleMedium),
          const SizedBox(height: 8),
          _CodeBlock(code: '''
// Simplified pseudocode of RenderTapRegionSurface.handleEvent
void handleEvent(PointerEvent event, HitTestEntry entry) {
  if (event is! PointerDownEvent) return;

  final inside = <RenderTapRegion>{};
  for (final entry in event.result.path) {
    // Walk up to find TapRegion ancestors
    final region = _findRegion(entry.target);
    if (region != null) inside.add(region);
  }

  for (final region in _registeredRegions) {
    final groupInside = inside.any(
      (r) => r.groupId == region.groupId,
    );
    if (!groupInside) {
      region.onTapOutside?.call(event);
      if (region.consumeOutsideTaps) event.handled = true;
    }
  }
}
'''),
        ],
      ),
    );
  }
}

class _ArchitecturePainter extends CustomPainter {
  const _ArchitecturePainter({required this.cs});
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final boxPaint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final arrowPaint = Paint()
      ..color = cs.onSurface
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final labels = <String>[
      'Pointer Down',
      'Flutter dispatch\nhitTest()',
      'RenderTapRegionSurface\naddWithPaintTransform()',
      'handleEvent()\nPointerDownEvent',
      'Iterate registered\nTapRegions',
      'inside? → skip\noutside? → onTapOutside()',
      'consumeOutsideTaps?\n→ event.handled = true',
    ];

    const boxH = 48.0;
    const boxW = 220.0;
    const gap = 12.0;
    final startX = (size.width - boxW) / 2;
    final totalH = labels.length * boxH + (labels.length - 1) * gap;
    final startY = (size.height - totalH) / 2;

    final colors = <Color>[
      cs.primaryContainer,
      cs.secondaryContainer,
      cs.tertiaryContainer,
      cs.errorContainer,
      cs.primaryContainer,
      cs.secondaryContainer,
      cs.tertiaryContainer,
    ];

    final tp = TextPainter(textDirection: TextDirection.ltr);

    for (int i = 0; i < labels.length; i++) {
      final y = startY + i * (boxH + gap);
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(startX, y, boxW, boxH),
        const Radius.circular(8),
      );
      boxPaint.color = colors[i % colors.length];
      canvas.drawRRect(rect, boxPaint);
      borderPaint.color = cs.outline;
      canvas.drawRRect(rect, borderPaint);

      tp.text = TextSpan(
        text: labels[i],
        style: TextStyle(
          fontSize: 11,
          color: cs.onSurface,
          height: 1.3,
        ),
      );
      tp.layout(maxWidth: boxW - 12);
      tp.paint(
        canvas,
        Offset(startX + (boxW - tp.width) / 2, y + (boxH - tp.height) / 2),
      );

      // Arrow to next box
      if (i < labels.length - 1) {
        final ax = startX + boxW / 2;
        final ay1 = y + boxH;
        final ay2 = y + boxH + gap;
        canvas.drawLine(Offset(ax, ay1), Offset(ax, ay2), arrowPaint);
        // Arrow head
        final path = Path()
          ..moveTo(ax, ay2)
          ..lineTo(ax - 6, ay2 - 8)
          ..lineTo(ax + 6, ay2 - 8)
          ..close();
        canvas.drawPath(
          path,
          Paint()..color = cs.onSurface,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_ArchitecturePainter old) => false;
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.step,
    required this.title,
    required this.detail,
  });
  final String step;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 16,
              backgroundColor: cs.primary,
              child: Text(
                step,
                style: TextStyle(
                  color: cs.onPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      style:
                          tt.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(detail, style: tt.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 7 – Dropdown Dismiss Simulation
// ===========================================================================

class _DropdownTab extends StatelessWidget {
  const _DropdownTab();

  static const List<String> _items = <String>[
    'Flutter',
    'Dart',
    'Material 3',
    'TapRegion',
    'RenderObject',
  ];

  void _addLog(String msg) {
    final prev = List<String>.from(_log.value);
    prev.insert(0, msg);
    if (prev.length > 30) prev.removeLast();
    _log.value = prev;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: cs.secondaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Tap the "Select…" button to open a simulated dropdown. '
            'Tap outside the dropdown card to dismiss it — powered by '
            'TapRegionSurface + TapRegion.',
            style: tt.bodySmall,
          ),
        ),
        Expanded(
          flex: 3,
          child: TapRegionSurface(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Simulated Dropdown', style: tt.titleLarge),
                  const SizedBox(height: 16),
                  // Anchor button
                  ValueListenableBuilder<String>(
                    valueListenable: _dropdownSelected,
                    builder: (context, selected, _) =>
                        ValueListenableBuilder<bool>(
                      valueListenable: _dropdownOpen,
                      builder: (context, open, _) => TapRegion(
                        onTapOutside: (_) {
                          if (_dropdownOpen.value) {
                            _dropdownOpen.value = false;
                            _addLog('↳ Dismissed dropdown via tap outside');
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Trigger button
                            OutlinedButton.icon(
                              onPressed: () {
                                _dropdownOpen.value = !_dropdownOpen.value;
                                _addLog(open ? 'Closed dropdown' : 'Opened dropdown');
                              },
                              icon: Icon(open
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down),
                              label: Text(selected),
                            ),
                            const SizedBox(height: 4),
                            // Dropdown card
                            if (open)
                              Material(
                                elevation: 6,
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: 240,
                                  decoration: BoxDecoration(
                                    color: cs.surface,
                                    border: Border.all(color: cs.outline),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      for (final item in _items)
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          onTap: () {
                                            _dropdownSelected.value = item;
                                            _dropdownOpen.value = false;
                                            _addLog('Selected: $item');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(Icons.check,
                                                    size: 16,
                                                    color: selected == item
                                                        ? cs.primary
                                                        : Colors.transparent),
                                                const SizedBox(width: 8),
                                                Text(item),
                                              ],
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
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Background content to tap on
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTapDown: (_) => _addLog('Background tapped'),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: cs.outlineVariant, style: BorderStyle.none),
                        ),
                        child: Center(
                          child: Text(
                            'Tap here to dismiss the dropdown',
                            style: tt.bodyMedium
                                ?.copyWith(color: cs.onSurfaceVariant),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _LogPanel(log: _log),
        ),
      ],
    );
  }
}

// ===========================================================================
// TAB 8 – Comparison Table
// ===========================================================================

class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('TapRegionSurface vs alternatives', style: tt.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Several Flutter mechanisms can implement "tap outside to dismiss" '
            'behaviour, but they differ significantly in scope, complexity, '
            'and correctness.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 20),
          _ComparisonTable(cs: cs),
          const SizedBox(height: 24),
          Text('When to choose TapRegionSurface', style: tt.titleMedium),
          const SizedBox(height: 8),
          _ProConCard(
            title: 'TapRegionSurface + TapRegion',
            pros: const <String>[
              'Designed exactly for this pattern',
              'Handles groupId grouping automatically',
              'Works with nested surfaces',
              'Integrates with focus system',
              'Used by Material 3 components',
              'consumeOutsideTaps prevents leaks',
            ],
            cons: const <String>[
              'Requires understanding surface/region hierarchy',
              'Must be ancestor of all TapRegions',
            ],
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _ProConCard(
            title: 'GestureDetector.behavior + onTapDown',
            pros: const <String>[
              'Simple to add to existing trees',
              'No special widget needed',
            ],
            cons: const <String>[
              'Races with child GestureDetectors',
              'HitTestBehavior.translucent leaks through',
              'No grouping concept',
              'Doesn\'t handle multiple regions',
            ],
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _ProConCard(
            title: 'ModalBarrier',
            pros: const <String>[
              'Blocks all input outside the barrier',
              'Works with Navigator/routes',
            ],
            cons: const <String>[
              'Full-screen overlay — not suitable for inline UI',
              'Requires route push',
              'No fine-grained region control',
            ],
            color: Colors.red,
          ),
          const SizedBox(height: 12),
          _ProConCard(
            title: 'Listener (pointer events)',
            pros: const <String>[
              'Low level — full control',
              'Not affected by gesture arena',
            ],
            cons: const <String>[
              'Must manually hit-test all regions',
              'Fragile with transforms/clips',
              'Complex coordinate mapping',
            ],
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final cols = <String>[
      'Feature',
      'TapRegionSurface',
      'GestureDetector',
      'ModalBarrier',
      'Listener',
    ];
    final rows = <List<String>>[
      ['Tap outside pattern', '✓ built-in', 'manual', 'blocks all', 'manual'],
      ['Multiple regions', '✓', '✗', '✗', 'manual'],
      ['groupId grouping', '✓', '✗', '✗', '✗'],
      ['consumeOutsideTaps', '✓', 'approx.', 'always', 'manual'],
      ['Focus integration', '✓', '✗', '✓', '✗'],
      ['No route push needed', '✓', '✓', '✗', '✓'],
      ['Handles transforms', '✓', 'partial', 'N/A', 'manual'],
      ['Material 3 used', '✓', 'yes', 'yes', '✗'],
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: cs.outlineVariant),
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(160),
          1: FixedColumnWidth(130),
          2: FixedColumnWidth(130),
          3: FixedColumnWidth(110),
          4: FixedColumnWidth(110),
        },
        children: <TableRow>[
          TableRow(
            decoration: BoxDecoration(color: cs.primaryContainer),
            children: cols
                .map((c) => _TCell(c, header: true))
                .toList(),
          ),
          for (final row in rows)
            TableRow(
              children: row.map((c) => _TCell(c)).toList(),
            ),
        ],
      ),
    );
  }
}

class _ProConCard extends StatelessWidget {
  const _ProConCard({
    required this.title,
    required this.pros,
    required this.cons,
    required this.color,
  });
  final String title;
  final List<String> pros;
  final List<String> cons;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Pros',
                          style: tt.labelSmall
                              ?.copyWith(color: Colors.green.shade700)),
                      const SizedBox(height: 4),
                      for (final p in pros)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('• '),
                              Expanded(child: Text(p, style: tt.bodySmall)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Cons',
                          style: tt.labelSmall
                              ?.copyWith(color: Colors.red.shade700)),
                      const SizedBox(height: 4),
                      for (final c in cons)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('• '),
                              Expanded(child: Text(c, style: tt.bodySmall)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 9 – Pitfalls & API Cheat Sheet
// ===========================================================================

class _PitfallsApiTab extends StatelessWidget {
  const _PitfallsApiTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ── Pitfalls ─────────────────────────────────────────────────────
          Text('Common Pitfalls', style: tt.titleLarge),
          const SizedBox(height: 12),
          _PitfallCard(
            number: 1,
            title: 'Nested TapRegionSurfaces',
            description:
                'A TapRegion registers with its nearest TapRegionSurface '
                'ancestor. If you nest surfaces, TapRegions in the inner '
                'surface are invisible to the outer surface. This can lead '
                'to "tap outside" callbacks firing unexpectedly on the outer '
                'surface when you tap inside the inner surface\'s regions.',
            fix: 'Use a single TapRegionSurface wrapping the entire interactive '
                'area. Only add inner surfaces when you deliberately want '
                'isolation.',
            cs: cs,
          ),
          const SizedBox(height: 8),
          _PitfallCard(
            number: 2,
            title: 'consumeOutsideTaps blocking gestures',
            description:
                'Setting consumeOutsideTaps: true on a TapRegion causes ALL '
                'pointer-downs outside that region to be consumed. This means '
                'scrolling, other gestures, and background tap handlers will '
                'silently stop working while the region is registered.',
            fix: 'Only enable consumeOutsideTaps for modal-like scenarios '
                '(e.g., an open dropdown). Disable it once the region is '
                'dismissed. Consider using ModalBarrier instead if you need '
                'full blocking.',
            cs: cs,
          ),
          const SizedBox(height: 8),
          _PitfallCard(
            number: 3,
            title: 'groupId string collisions',
            description:
                'groupId is a plain Object (typically a String or Type). '
                'Using a common string like "menu" in multiple unrelated '
                'TapRegionSurface trees can cause unrelated regions to be '
                'grouped, suppressing onTapOutside when they shouldn\'t be.',
            fix: 'Prefer using a unique Type or a namespaced const symbol as '
                'groupId (e.g., const Object _myMenuGroupId = Object()). '
                'Never use plain generic strings in shared libraries.',
            cs: cs,
          ),
          const SizedBox(height: 8),
          _PitfallCard(
            number: 4,
            title: 'Missing TapRegionSurface ancestor',
            description:
                'A TapRegion without an ancestor TapRegionSurface silently '
                'does nothing — no callbacks fire, no errors are thrown. '
                'This can be confusing to debug because the widget tree '
                'appears correct.',
            fix: 'Always wrap the interactive area with TapRegionSurface. '
                'The surface must be an ancestor of all TapRegion widgets '
                'in that interaction group.',
            cs: cs,
          ),
          const SizedBox(height: 8),
          _PitfallCard(
            number: 5,
            title: 'Relying on onTapOutside for focus management',
            description:
                'onTapOutside fires on pointer-down, not on focus changes. '
                'If the user navigates via keyboard or controller, '
                'onTapOutside will not fire. This can leave dropdown/menu '
                'state stale.',
            fix: 'Combine TapRegion with FocusNode.onFocusChange or '
                'FocusScope.onFocusChange for complete dismissal logic.',
            cs: cs,
          ),
          const SizedBox(height: 24),
          // ── API Cheat Sheet ───────────────────────────────────────────────
          Text('API Cheat Sheet', style: tt.titleLarge),
          const SizedBox(height: 12),
          _ApiSection(
            className: 'TapRegionSurface',
            description:
                'Widget. Installs a RenderTapRegionSurface that coordinates '
                'all descendant TapRegion widgets. Only one is needed per '
                'interactive area.',
            constructorArgs: const <_ApiArg>[
              _ApiArg('child', 'Widget', 'Required. The widget subtree.'),
            ],
          ),
          const SizedBox(height: 12),
          _ApiSection(
            className: 'TapRegion',
            description:
                'Widget. Marks a subtree as a named tap region and registers '
                'it with the nearest TapRegionSurface ancestor.',
            constructorArgs: const <_ApiArg>[
              _ApiArg('child', 'Widget', 'Required.'),
              _ApiArg('onTapInside', 'PointerDownEventListener?',
                  'Called when pointer-down is inside this region.'),
              _ApiArg('onTapOutside', 'PointerDownEventListener?',
                  'Called when pointer-down is outside this region (and all '
                  'regions sharing the same groupId).'),
              _ApiArg('groupId', 'Object?',
                  'Logical group. Regions sharing a groupId act as one unit.'),
              _ApiArg('consumeOutsideTaps', 'bool',
                  'If true, outside pointer events are consumed (default: false).'),
              _ApiArg('enabled', 'bool',
                  'If false, region is not registered with the surface (default: true).'),
            ],
          ),
          const SizedBox(height: 12),
          _ApiSection(
            className: 'RenderTapRegionSurface',
            description:
                'RenderObject (RenderProxyBox subclass). Do not use directly. '
                'Intercepts handleEvent for PointerDownEvent. Holds the '
                'registry of RenderTapRegion objects.',
            constructorArgs: const <_ApiArg>[
              _ApiArg('— no public constructor args —', '', ''),
            ],
          ),
          const SizedBox(height: 12),
          _ApiSection(
            className: 'RenderTapRegion',
            description:
                'RenderObject for TapRegion. Registers/deregisters itself '
                'with the nearest RenderTapRegionSurface when attached/detached.',
            constructorArgs: const <_ApiArg>[
              _ApiArg('groupId', 'Object?', 'Forwarded from TapRegion.groupId.'),
              _ApiArg('onTapInside', 'PointerDownEventListener?', ''),
              _ApiArg('onTapOutside', 'PointerDownEventListener?', ''),
              _ApiArg('consumeOutsideTaps', 'bool', ''),
            ],
          ),
          const SizedBox(height: 24),
          // ── Quick example ─────────────────────────────────────────────────
          Text('Minimal usage example', style: tt.titleMedium),
          const SizedBox(height: 8),
          _CodeBlock(code: r'''
TapRegionSurface(
  child: Stack(
    children: [
      // Background — detects outside taps
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => open = false),
        child: const SizedBox.expand(),
      ),
      // Dropdown card — protected region
      TapRegion(
        onTapOutside: (_) => setState(() => open = false),
        consumeOutsideTaps: true,   // absorb the tap
        child: DropdownCard(...),
      ),
    ],
  ),
)
'''),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.description,
    required this.fix,
    required this.cs,
  });
  final int number;
  final String title;
  final String description;
  final String fix;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: cs.error.withAlpha(80)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 14,
                  backgroundColor: cs.error,
                  child: Text(
                    '$number',
                    style: TextStyle(color: cs.onError, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style:
                        tt.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(description, style: tt.bodySmall),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cs.primaryContainer.withAlpha(120),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.lightbulb_outline,
                      size: 16, color: cs.primary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Fix: $fix',
                      style: tt.bodySmall
                          ?.copyWith(color: cs.onPrimaryContainer),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ApiSection extends StatelessWidget {
  const _ApiSection({
    required this.className,
    required this.description,
    required this.constructorArgs,
  });
  final String className;
  final String description;
  final List<_ApiArg> constructorArgs;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Card(
      color: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: cs.primary.withAlpha(80)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                className,
                style: tt.labelLarge?.copyWith(
                  color: cs.onPrimaryContainer,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(description, style: tt.bodySmall),
            const SizedBox(height: 10),
            if (constructorArgs.isNotEmpty &&
                constructorArgs.first.name != '— no public constructor args —')
              Table(
                border: TableBorder.all(color: cs.outlineVariant),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(160),
                  1: FixedColumnWidth(100),
                  2: FlexColumnWidth(),
                },
                children: <TableRow>[
                  TableRow(
                    decoration:
                        BoxDecoration(color: cs.secondaryContainer),
                    children: <Widget>[
                      _TCell('Parameter', header: true),
                      _TCell('Type', header: true),
                      _TCell('Description', header: true),
                    ],
                  ),
                  for (final arg in constructorArgs)
                    TableRow(
                      children: <Widget>[
                        _TCell(arg.name),
                        _TCell(arg.type),
                        _TCell(arg.desc),
                      ],
                    ),
                ],
              )
            else
              Text('No public constructor arguments.',
                  style: tt.bodySmall
                      ?.copyWith(color: cs.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

class _ApiArg {
  const _ApiArg(this.name, this.type, this.desc);
  final String name;
  final String type;
  final String desc;
}

// ===========================================================================
// Shared helpers
// ===========================================================================

class _LogPanel extends StatelessWidget {
  const _LogPanel({required this.log});
  final ValueNotifier<List<String>> log;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerLowest,
        border: Border(top: BorderSide(color: cs.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
            child: Row(
              children: <Widget>[
                Icon(Icons.terminal, size: 16, color: cs.primary),
                const SizedBox(width: 6),
                Text('Event Log', style: tt.labelMedium),
                const Spacer(),
                TextButton(
                  onPressed: () => log.value = <String>[],
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: log,
              builder: (context, entries, _) => entries.isEmpty
                  ? Center(
                      child: Text(
                        'Tap to see events…',
                        style:
                            tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: entries.length,
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          entries[i],
                          style: tt.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                            color: i == 0
                                ? cs.primary
                                : cs.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Chip(
      label: Text(label),
      labelStyle: Theme.of(context).textTheme.labelSmall,
      backgroundColor: cs.secondaryContainer,
      side: BorderSide(color: cs.secondary.withAlpha(60)),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: SelectableText(
        code.trim(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
