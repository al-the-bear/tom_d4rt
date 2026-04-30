import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers — stateless demo, all mutable state lives here.
// ---------------------------------------------------------------------------

final ValueNotifier<List<String>> _activeEntryLabels =
    ValueNotifier<List<String>>([]);

final ValueNotifier<int> _markNeedsBuildCounter = ValueNotifier<int>(0);

final ValueNotifier<bool> _tooltipVisible = ValueNotifier<bool>(false);

final ValueNotifier<bool> _dropdownVisible = ValueNotifier<bool>(false);

final ValueNotifier<String?> _dropdownSelection = ValueNotifier<String?>(null);

// Overlay entries that live across rebuilds — keyed by label.
final Map<String, OverlayEntry> _liveEntries = {};

// Anchor entry used for insertAllBelow demo.
OverlayEntry? _anchorEntry;

// Entry for markNeedsBuild demo.
OverlayEntry? _counterEntry;

// Entry for tooltip demo.
OverlayEntry? _tooltipEntry;

// Entries for dropdown demo (barrier + menu).
OverlayEntry? _dropdownBarrierEntry;
OverlayEntry? _dropdownMenuEntry;

// ---------------------------------------------------------------------------
// Colour palette used across demos.
// ---------------------------------------------------------------------------

const List<Color> _cardColors = [
  Color(0xFF6750A4),
  Color(0xFF7965AF),
  Color(0xFF03DAC6),
  Color(0xFFEF6C00),
  Color(0xFF388E3C),
  Color(0xFF1976D2),
  Color(0xFFD32F2F),
  Color(0xFF7B1FA2),
];

// ---------------------------------------------------------------------------
// Entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
    ),
    home: const _OverlayStateDemo(),
  );
}

// ---------------------------------------------------------------------------
// Root widget — builds the DefaultTabController + TabBar + TabBarView.
// ---------------------------------------------------------------------------

class _OverlayStateDemo extends StatelessWidget {
  const _OverlayStateDemo();

  static const List<(IconData, String)> _tabs = [
    (Icons.auto_stories, 'Intro'),
    (Icons.layers, 'Insert/Remove'),
    (Icons.tune, 'Properties'),
    (Icons.stacked_bar_chart, 'insertAllBelow'),
    (Icons.refresh, 'markNeedsBuild'),
    (Icons.info_outline, 'Tooltip'),
    (Icons.arrow_drop_down_circle, 'Dropdown'),
    (Icons.architecture, 'Stack Diagram'),
    (Icons.timeline, 'Lifecycle'),
    (Icons.compare_arrows, 'Comparison'),
    (Icons.menu_book, 'API Cheat Sheet'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('OverlayState Deep Demo'),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: _tabs
                .map(
                  (t) => Tab(
                    icon: Icon(t.$1),
                    text: t.$2,
                  ),
                )
                .toList(),
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            _HeroBannerTab(),
            _LiveInsertRemoveTab(),
            _OverlayEntryPropertiesTab(),
            _InsertAllBelowTab(),
            _MarkNeedsBuildTab(),
            _TooltipSimulationTab(),
            _DropdownSimulationTab(),
            _StackDiagramTab(),
            _LifecycleDiagramTab(),
            _ComparisonTab(),
            _ApiCheatSheetTab(),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 1 — Hero Banner
// ===========================================================================

class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GradientBanner(
            title: 'OverlayState',
            subtitle: 'The portal for floating UI on top of everything.',
            colors: [cs.primary, cs.tertiary],
          ),
          const SizedBox(height: 28),
          Text(
            'What is OverlayState?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.layers,
            title: 'The State of Overlay',
            body:
                'OverlayState is the State object that backs an Overlay widget. '
                'It manages a Z-ordered stack of OverlayEntry objects, which are '
                'rendered above the route stack — making it the natural host for '
                'tooltips, dropdown menus, banners, toasts, and any floating UI '
                'that must appear above the normal widget tree.',
          ),
          const SizedBox(height: 16),
          const _InfoCard(
            icon: Icons.explore,
            title: 'How to access it',
            body: 'Call Overlay.of(context) anywhere below a MaterialApp or '
                'Navigator (both install an Overlay). The returned OverlayState '
                'is valid until the Overlay is disposed. You can also supply a '
                'rootOverlay: true flag to skip local Overlays and reach the '
                'Navigator\'s root Overlay.',
          ),
          const SizedBox(height: 16),
          const _InfoCard(
            icon: Icons.stacked_bar_chart,
            title: 'The invisible stack',
            body:
                'Think of OverlayState as an invisible Stack that sits above all '
                'routes in the Navigator. Each OverlayEntry contributes one layer. '
                'Entries inserted later appear on top. The Overlay itself is '
                'transparent unless an entry marks itself opaque: true, in which '
                'case everything below it is hidden from the compositor.',
          ),
          const SizedBox(height: 16),
          const _InfoCard(
            icon: Icons.bolt,
            title: 'Key methods at a glance',
            body: '• insert(entry)  — add one entry on top\n'
                '• insertAll(entries)  — add many entries at once\n'
                '• insertAllBelow(entries, below: anchor)  — insert a batch below an existing entry\n'
                '• rearrange(entries)  — reorder all entries atomically\n\n'
                'OverlayEntry methods:\n'
                '• remove()  — detach from the Overlay\n'
                '• markNeedsBuild()  — schedule a rebuild of the entry\'s builder',
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'Where OverlayState fits in the widget tree'),
          const SizedBox(height: 12),
          const _LayerCard(
            layers: [
              ('MaterialApp', Color(0xFF6750A4)),
              ('Navigator', Color(0xFF7965AF)),
              ('Overlay  ← OverlayState lives here', Color(0xFF03DAC6)),
              ('Route widgets (pages)', Color(0xFF388E3C)),
              ('OverlayEntry (floating UI)', Color(0xFFEF6C00)),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Why not just use Stack?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.compare_arrows,
            title: 'Stack vs Overlay',
            body:
                'A Stack is a layout widget — it can only render children provided '
                'at build time. OverlayState allows any code (even code in a '
                'completely separate widget subtree) to insert entries imperatively '
                'at any time, without rebuilding the host widget. This decoupling '
                'is what makes tooltips and menus practical in Flutter.',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 2 — Live insert / remove
// ===========================================================================

class _LiveInsertRemoveTab extends StatelessWidget {
  const _LiveInsertRemoveTab();

  void _insertEntry(BuildContext context) {
    final overlay = Overlay.of(context);
    final label = 'Entry-${_activeEntryLabels.value.length + 1}';
    final color = _cardColors[
        _activeEntryLabels.value.length % _cardColors.length];

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _FloatingCard(label: label, color: color),
    );

    overlay.insert(entry);
    _liveEntries[label] = entry;
    _activeEntryLabels.value = List.from(_activeEntryLabels.value)..add(label);
  }

  void _removeLastEntry() {
    if (_activeEntryLabels.value.isEmpty) return;
    final label = _activeEntryLabels.value.last;
    _liveEntries[label]?.remove();
    _liveEntries.remove(label);
    _activeEntryLabels.value = List.from(_activeEntryLabels.value)
      ..removeLast();
  }

  void _removeAllEntries() {
    for (final e in _liveEntries.values) {
      e.remove();
    }
    _liveEntries.clear();
    _activeEntryLabels.value = [];
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(label: 'Live OverlayEntry Insert / Remove'),
          const SizedBox(height: 8),
          Text(
            'Tap Insert to push a coloured card into the Overlay above this '
            'screen. Tap Remove Last or Clear All to remove them. The list '
            'below tracks what is currently live in the OverlayState.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () => _insertEntry(context),
                icon: const Icon(Icons.add),
                label: const Text('Insert Entry'),
              ),
              FilledButton.icon(
                onPressed: _removeLastEntry,
                icon: const Icon(Icons.remove),
                label: const Text('Remove Last'),
                style: FilledButton.styleFrom(
                  backgroundColor: cs.error,
                  foregroundColor: cs.onError,
                ),
              ),
              OutlinedButton.icon(
                onPressed: _removeAllEntries,
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear All'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ValueListenableBuilder<List<String>>(
            valueListenable: _activeEntryLabels,
            builder: (_, labels, child) {
              if (labels.isEmpty) {
                return _EmptyStateChip(
                  label: 'No active overlay entries. Tap Insert to add one.',
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active entries (${labels.length})',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ...labels.asMap().entries.map((e) {
                    final color = _cardColors[e.key % _cardColors.length];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(e.value),
                        ],
                      ),
                    );
                  }),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'How insert() works'),
          const SizedBox(height: 12),
          const _CodeSnippetCard(
            code: '''// 1. Obtain OverlayState from context
final overlay = Overlay.of(context);

// 2. Create an OverlayEntry with a builder
final entry = OverlayEntry(
  builder: (ctx) => Positioned(
    top: 80, right: 20,
    child: Card(child: Text('Floating!')),
  ),
);

// 3. Insert it
overlay.insert(entry);

// 4. Later, remove it
entry.remove();''',
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'insertAll()'),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.layers,
            title: 'Batch insert',
            body:
                'overlay.insertAll([entryA, entryB, entryC]) inserts multiple '
                'entries in a single pass. They are ordered so entryA is below '
                'entryB which is below entryC (matching list order from bottom '
                'to top). Prefer this over repeated insert() calls when adding '
                'multiple layers atomically.',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// Helper: coloured card rendered inside an OverlayEntry.
class _FloatingCard extends StatelessWidget {
  const _FloatingCard({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70 + (_activeEntryLabels.value.indexOf(label) * 10).toDouble(),
      right: 16,
      child: IgnorePointer(
        child: Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(12),
          color: color,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 3 — OverlayEntry properties
// ===========================================================================

class _OverlayEntryPropertiesTab extends StatelessWidget {
  const _OverlayEntryPropertiesTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(label: 'OverlayEntry Properties'),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.tune,
            title: 'Three key properties',
            body:
                'Every OverlayEntry has three properties that control its behavior:\n\n'
                '• builder  — (BuildContext) → Widget. Called whenever the entry '
                'needs to draw itself.\n\n'
                '• opaque  — bool. When true, the entry blocks all entries below it '
                'from being painted. This is used by full-screen routes.\n\n'
                '• maintainState  — bool. When false and the entry is below an opaque '
                'entry, its widget subtree is removed from the tree entirely. '
                'When true, the subtree is kept alive even if obscured.',
          ),
          const SizedBox(height: 24),
          _PropertyDemoRow(
            title: 'opaque: false (default)',
            description:
                'Entries below remain visible and painted. The compositor '
                'composites all layers. Use for semi-transparent overlays, '
                'tooltips, and drawers.',
            badge: 'TRANSPARENT',
            badgeColor: Colors.blue,
            stackPreview: const _OpaquePreview(opaque: false),
          ),
          const SizedBox(height: 16),
          _PropertyDemoRow(
            title: 'opaque: true',
            description:
                'This entry and all entries above it block entries below from '
                'being painted. The route system uses opaque: true for full-screen '
                'pages so that the previous page is not composited needlessly.',
            badge: 'OPAQUE',
            badgeColor: Colors.deepOrange,
            stackPreview: const _OpaquePreview(opaque: true),
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'maintainState behaviour'),
          const SizedBox(height: 12),
          _MaintainStateTable(),
          const SizedBox(height: 24),
          _SectionHeader(label: 'builder contract'),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.build,
            title: 'builder is called on demand',
            body:
                'The builder callback is called each time the OverlayEntry needs '
                'to rebuild. You can trigger a rebuild manually with '
                'entry.markNeedsBuild(). The BuildContext passed to the builder '
                'is a child of the Overlay\'s context, NOT of the widget that '
                'created the entry. Accessing inherited widgets (like Theme or '
                'MediaQuery) works because Overlay is inside MaterialApp.',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _PropertyDemoRow extends StatelessWidget {
  const _PropertyDemoRow({
    required this.title,
    required this.description,
    required this.badge,
    required this.badgeColor,
    required this.stackPreview,
  });

  final String title;
  final String description;
  final String badge;
  final Color badgeColor;
  final Widget stackPreview;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 100,
              height: 100,
              child: stackPreview,
            ),
          ],
        ),
      ),
    );
  }
}

class _OpaquePreview extends StatelessWidget {
  const _OpaquePreview({required this.opaque});

  final bool opaque;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'Bottom\nlayer',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: opaque
                  ? Colors.deepOrange.shade300
                  : Colors.purple.shade200.withAlpha(180),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                opaque ? 'OPAQUE\nentry' : 'Transparent\nentry',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 9, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MaintainStateTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const headers = ['opaque below', 'maintainState', 'Result'];
    const rows = [
      ['Any entry', 'true', 'Subtree kept in memory, state preserved'],
      ['opaque: true', 'false', 'Subtree torn down, state lost'],
      ['opaque: false', 'false', 'Subtree visible — no effect'],
    ];

    return Table(
      border: TableBorder.all(
        color: Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          children: headers
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    h,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              )
              .toList(),
        ),
        ...rows.map(
          (r) => TableRow(
            children: r
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(cell),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// TAB 4 — insertAllBelow
// ===========================================================================

class _InsertAllBelowTab extends StatelessWidget {
  const _InsertAllBelowTab();

  void _setupAnchorAndBatch(BuildContext context) {
    _cleanupInsertAllBelow();
    final overlay = Overlay.of(context);

    // Anchor entry — always at the top initially.
    _anchorEntry = OverlayEntry(
      builder: (_) => const _PositionedLabel(
        top: 120,
        left: 20,
        label: 'ANCHOR (top)',
        color: Color(0xFF6750A4),
      ),
    );
    overlay.insert(_anchorEntry!);

    // Batch of 3 entries inserted BELOW the anchor.
    final batch = [
      OverlayEntry(
        builder: (_) => const _PositionedLabel(
          top: 160,
          left: 20,
          label: 'Batch-A (below anchor)',
          color: Color(0xFF03DAC6),
        ),
      ),
      OverlayEntry(
        builder: (_) => const _PositionedLabel(
          top: 200,
          left: 20,
          label: 'Batch-B (below anchor)',
          color: Color(0xFFEF6C00),
        ),
      ),
      OverlayEntry(
        builder: (_) => const _PositionedLabel(
          top: 240,
          left: 20,
          label: 'Batch-C (below anchor)',
          color: Color(0xFF388E3C),
        ),
      ),
    ];

    overlay.insertAll(batch, below: _anchorEntry);
  }

  void _cleanupInsertAllBelow() {
    _anchorEntry?.remove();
    _anchorEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(label: 'insertAllBelow'),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.stacked_bar_chart,
            title: 'Inserting below an existing entry',
            body:
                'overlay.insertAllBelow(entries, below: anchorEntry) inserts a '
                'batch of entries directly below the specified anchor. The entries '
                'appear in list order from bottom to top, and all of them are '
                'below the anchor.\n\n'
                'Use case: inserting a background blur layer below a dialog '
                'without disturbing entries above the dialog.',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () => _setupAnchorAndBatch(context),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Run Demo'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: _cleanupInsertAllBelow,
                icon: const Icon(Icons.stop),
                label: const Text('Clean Up'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'Z-order explained'),
          const SizedBox(height: 12),
          _ZOrderDiagram(),
          const SizedBox(height: 24),
          _SectionHeader(label: 'Code'),
          const SizedBox(height: 12),
          const _CodeSnippetCard(
            code: '''final anchor = OverlayEntry(
  builder: (_) => const TopWidget(),
);
overlay.insert(anchor); // anchor is now on top

final batch = [entryA, entryB, entryC];

// Insert the batch below the anchor.
// Z-order (bottom→top): entryA, entryB, entryC, anchor
overlay.insertAllBelow(batch, below: anchor);''',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _PositionedLabel extends StatelessWidget {
  const _PositionedLabel({
    required this.top,
    required this.left,
    required this.label,
    required this.color,
  });

  final double top;
  final double left;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: IgnorePointer(
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          color: color,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ZOrderDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      ('entryA (bottom)', const Color(0xFF03DAC6)),
      ('entryB', const Color(0xFFEF6C00)),
      ('entryC', const Color(0xFF388E3C)),
      ('ANCHOR (top)', const Color(0xFF6750A4)),
    ];

    return Column(
      children: items.reversed.toList().asMap().entries.map((e) {
        final idx = e.key;
        final item = e.value;
        final z = items.length - idx;
        return Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: item.$2,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.$1,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Z = $z',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ===========================================================================
// TAB 5 — markNeedsBuild
// ===========================================================================

class _MarkNeedsBuildTab extends StatelessWidget {
  const _MarkNeedsBuildTab();

  void _createCounterEntry(BuildContext context) {
    _counterEntry?.remove();
    _counterEntry = OverlayEntry(
      builder: (_) => _CounterOverlayWidget(
        notifier: _markNeedsBuildCounter,
      ),
    );
    Overlay.of(context).insert(_counterEntry!);
  }

  void _increment() {
    _markNeedsBuildCounter.value++;
    _counterEntry?.markNeedsBuild();
  }

  void _removeCounterEntry() {
    _counterEntry?.remove();
    _counterEntry = null;
    _markNeedsBuildCounter.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(label: 'markNeedsBuild()'),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.refresh,
            title: 'Triggering a rebuild without setState',
            body:
                'entry.markNeedsBuild() schedules a rebuild of the OverlayEntry\'s '
                'builder. This is how you update the content of a floating widget '
                'without tearing it down and re-inserting. It is equivalent to '
                'calling setState inside a StatefulWidget — but for overlay content '
                'that lives outside the normal widget tree.',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () => _createCounterEntry(context),
                icon: const Icon(Icons.add_box),
                label: const Text('Create Entry'),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: _increment,
                icon: const Icon(Icons.add),
                label: const Text('Increment + markNeedsBuild'),
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: _removeCounterEntry,
                icon: const Icon(Icons.close),
                label: const Text('Remove'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ValueListenableBuilder<int>(
            valueListenable: _markNeedsBuildCounter,
            builder: (_, count, child) => _StatChip(
              label: 'Current counter value',
              value: count.toString(),
            ),
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'How it works'),
          const SizedBox(height: 12),
          const _CodeSnippetCard(
            code: '''int _counter = 0;
late OverlayEntry entry;

entry = OverlayEntry(
  builder: (_) => Positioned(
    top: 80, right: 16,
    child: Badge(label: Text('\$_counter')),
  ),
);

overlay.insert(entry);

// Later, in a button callback:
_counter++;
entry.markNeedsBuild(); // entry's builder is called again''',
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'Comparison to ValueNotifier pattern'),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.compare,
            title: 'markNeedsBuild vs ValueListenableBuilder',
            body:
                'You can use either approach inside an OverlayEntry builder:\n\n'
                '• markNeedsBuild(): rebuild the whole entry. Simple, imperative.\n\n'
                '• ValueListenableBuilder inside the builder: finer-grained '
                'rebuild. The entry\'s builder is still called once, but the '
                'ValueListenableBuilder sub-tree updates on its own. This avoids '
                'redundant work if the entry is large.\n\n'
                'For small overlays, markNeedsBuild is perfectly fine.',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _CounterOverlayWidget extends StatelessWidget {
  const _CounterOverlayWidget({required this.notifier});

  final ValueNotifier<int> notifier;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      right: 16,
      child: IgnorePointer(
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(40),
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'Counter: ${notifier.value}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 6 — Tooltip simulation
// ===========================================================================

class _TooltipSimulationTab extends StatelessWidget {
  const _TooltipSimulationTab();

  void _showTooltip(BuildContext context, Offset globalPosition) {
    if (_tooltipVisible.value) return;
    _tooltipVisible.value = true;

    _tooltipEntry = OverlayEntry(
      builder: (_) => _TooltipOverlay(position: globalPosition),
    );
    Overlay.of(context).insert(_tooltipEntry!);
  }

  void _hideTooltip() {
    if (!_tooltipVisible.value) return;
    _tooltipEntry?.remove();
    _tooltipEntry = null;
    _tooltipVisible.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(label: 'Tooltip via OverlayEntry'),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.info_outline,
            title: 'Simulating Flutter\'s Tooltip widget',
            body:
                'Flutter\'s built-in Tooltip internally uses OverlayState to '
                'display its label. Here we replicate that pattern: tap the '
                'button to show a tooltip-style OverlayEntry positioned near '
                'the trigger. Tap anywhere to dismiss.\n\n'
                'The key technique: use a GestureDetector barrier entry behind '
                'the tooltip to detect outside taps.',
          ),
          const SizedBox(height: 24),
          Builder(
            builder: (ctx) => Center(
              child: GestureDetector(
                onTapDown: (details) =>
                    _showTooltip(ctx, details.globalPosition),
                child: Container(
                  width: 140,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.touch_app,
                        color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Tap me',
                        style: TextStyle(
                          color: Theme.of(ctx).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<bool>(
            valueListenable: _tooltipVisible,
            builder: (_, visible, child) => Center(
              child: visible
                  ? FilledButton.icon(
                      onPressed: _hideTooltip,
                      icon: const Icon(Icons.close),
                      label: const Text('Dismiss Tooltip'),
                    )
                  : const _EmptyStateChip(
                      label: 'Tooltip hidden. Tap the button above.',
                    ),
            ),
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'Pattern code'),
          const SizedBox(height: 12),
          const _CodeSnippetCard(
            code: '''OverlayEntry? _tooltipEntry;

void _showTooltip(BuildContext ctx, Offset pos) {
  _tooltipEntry = OverlayEntry(
    builder: (_) => Positioned(
      top: pos.dy + 8,
      left: pos.dx - 60,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text('Hello, tooltip!'),
        ),
      ),
    ),
  );
  Overlay.of(ctx).insert(_tooltipEntry!);
}

void _hideTooltip() {
  _tooltipEntry?.remove();
  _tooltipEntry = null;
}''',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _TooltipOverlay extends StatelessWidget {
  const _TooltipOverlay({required this.position});

  final Offset position;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position.dy + 12,
      left: (position.dx - 80).clamp(8.0, double.infinity),
      child: IgnorePointer(
        child: Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF323232),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.info, color: Colors.white, size: 14),
                SizedBox(width: 6),
                Text(
                  'This is an OverlayEntry tooltip!',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 7 — Dropdown simulation
// ===========================================================================

const List<String> _dropdownItems = [
  'Option Alpha',
  'Option Beta',
  'Option Gamma',
  'Option Delta',
  'Option Epsilon',
];

class _DropdownSimulationTab extends StatelessWidget {
  const _DropdownSimulationTab();

  void _openDropdown(BuildContext context, Offset buttonGlobal, Size buttonSize) {
    if (_dropdownVisible.value) return;
    _dropdownVisible.value = true;

    _dropdownBarrierEntry = OverlayEntry(
      builder: (_) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _closeDropdown,
        child: const SizedBox.expand(),
      ),
    );

    _dropdownMenuEntry = OverlayEntry(
      builder: (_) => _DropdownMenuOverlay(
        position: Offset(buttonGlobal.dx, buttonGlobal.dy + buttonSize.height),
        onSelect: (item) {
          _dropdownSelection.value = item;
          _closeDropdown();
        },
      ),
    );

    Overlay.of(context)
        .insertAll([_dropdownBarrierEntry!, _dropdownMenuEntry!]);
  }

  void _closeDropdown() {
    _dropdownBarrierEntry?.remove();
    _dropdownMenuEntry?.remove();
    _dropdownBarrierEntry = null;
    _dropdownMenuEntry = null;
    _dropdownVisible.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(label: 'Dropdown Menu via OverlayEntry'),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.arrow_drop_down_circle,
            title: 'Two-entry dropdown pattern',
            body:
                'A robust dropdown uses two OverlayEntries:\n\n'
                '1. Barrier entry  — transparent, full-screen GestureDetector. '
                'Inserted first (below the menu). Dismisses the dropdown on '
                'outside tap.\n\n'
                '2. Menu entry  — the actual floating menu, positioned below '
                'the trigger button.\n\n'
                'Both are inserted together with insertAll() and removed '
                'together when dismissed.',
          ),
          const SizedBox(height: 20),
          Builder(
            builder: (ctx) {
              final buttonKey = GlobalKey();
              return Column(
                children: [
                  Center(
                    child: ValueListenableBuilder<String?>(
                      valueListenable: _dropdownSelection,
                      builder: (_, selection, child) {
                        return GestureDetector(
                          key: buttonKey,
                          onTap: () {
                            final box = buttonKey.currentContext
                                ?.findRenderObject() as RenderBox?;
                            if (box == null) return;
                            final pos = box.localToGlobal(Offset.zero);
                            _openDropdown(ctx, pos, box.size);
                          },
                          child: Container(
                            width: 200,
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Theme.of(ctx).colorScheme.outlineVariant,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(ctx).colorScheme.surface,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(selection ?? 'Select an option'),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<bool>(
                    valueListenable: _dropdownVisible,
                    builder: (_, open, child) => _StatChip(
                      label: 'Dropdown',
                      value: open ? 'OPEN' : 'CLOSED',
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'Pattern code'),
          const SizedBox(height: 12),
          const _CodeSnippetCard(
            code: '''void _openDropdown(BuildContext ctx, Offset pos, Size size) {
  late OverlayEntry barrier, menu;

  barrier = OverlayEntry(
    builder: (_) => GestureDetector(
      onTap: () { barrier.remove(); menu.remove(); },
      child: const SizedBox.expand(),
    ),
  );

  menu = OverlayEntry(
    builder: (_) => Positioned(
      top: pos.dy + size.height,
      left: pos.dx,
      child: _DropdownMenu(items: items),
    ),
  );

  // Insert barrier below menu.
  Overlay.of(ctx).insertAll([barrier, menu]);
}''',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _DropdownMenuOverlay extends StatelessWidget {
  const _DropdownMenuOverlay({
    required this.position,
    required this.onSelect,
  });

  final Offset position;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position.dy,
      left: position.dx - 80,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _dropdownItems.map((item) {
              return InkWell(
                onTap: () => onSelect(item),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.chevron_right, size: 16),
                      const SizedBox(width: 8),
                      Text(item),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 8 — Stack Diagram (CustomPainter)
// ===========================================================================

class _StackDiagramTab extends StatelessWidget {
  const _StackDiagramTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(label: 'Navigator / Overlay Stack Diagram'),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.architecture,
            title: 'Z-order of Flutter\'s rendering layers',
            body:
                'The diagram below shows how Flutter layers its rendering. '
                'The Overlay sits at the top of the Navigator\'s stack, and '
                'OverlayEntry objects float above all routes. Arrows indicate '
                'ownership / containment.',
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 480,
            child: CustomPaint(
              painter: _StackDiagramPainter(
                theme: Theme.of(context),
              ),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'Layer descriptions'),
          const SizedBox(height: 12),
          _LayerDescriptionList(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _StackDiagramPainter extends CustomPainter {
  _StackDiagramPainter({required this.theme});

  final ThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    const layers = [
      (
        'MaterialApp',
        Color(0xFF6750A4),
        'Root — installs Navigator + Theme',
        1
      ),
      (
        'Navigator',
        Color(0xFF7965AF),
        'Manages route stack; installs Overlay',
        2
      ),
      (
        'Overlay (OverlayState)',
        Color(0xFF03DAC6),
        'Hosts all floating entries',
        3
      ),
      (
        'Route 1 — previous page',
        Color(0xFF388E3C),
        'Beneath current route; may be hidden',
        4
      ),
      (
        'Route 2 — current page',
        Color(0xFF1976D2),
        'Active page; highest route Z',
        5
      ),
      (
        'OverlayEntry (tooltip/menu)',
        Color(0xFFEF6C00),
        'Floats above all routes',
        6
      ),
    ];

    final boxHeight = (size.height - 80) / layers.length;
    final boxWidth = size.width - 80;

    for (var i = 0; i < layers.length; i++) {
      final layer = layers[i];
      final top = 40.0 + i * boxHeight;
      final indent = i * 12.0;
      final rect = Rect.fromLTWH(
        40 + indent,
        top,
        boxWidth - indent * 2,
        boxHeight - 8,
      );

      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8));

      final paint = Paint()
        ..color = layer.$2.withAlpha(200)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(rrect, paint);

      final borderPaint = Paint()
        ..color = layer.$2
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRRect(rrect, borderPaint);

      // Z-order label on the right.
      final zText = TextPainter(
        text: TextSpan(
          text: 'Z=${layer.$4}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      zText.paint(
        canvas,
        Offset(rect.right - zText.width - 8, rect.top + 8),
      );

      // Layer name.
      final nameText = TextPainter(
        text: TextSpan(
          text: layer.$1,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: rect.width - 60);
      nameText.paint(canvas, Offset(rect.left + 8, rect.top + 8));

      // Description.
      final descText = TextPainter(
        text: TextSpan(
          text: layer.$3,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: rect.width - 60);
      descText.paint(
        canvas,
        Offset(rect.left + 8, rect.top + 28),
      );

      // Arrow down (except last).
      if (i < layers.length - 1) {
        final arrowPaint = Paint()
          ..color = Colors.grey.shade400
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;
        final arrowX = size.width / 2;
        final arrowTop = top + boxHeight - 8;
        final arrowBottom = arrowTop + 8;
        canvas.drawLine(
          Offset(arrowX, arrowTop),
          Offset(arrowX, arrowBottom),
          arrowPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LayerDescriptionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const items = [
      (Color(0xFF6750A4), 'MaterialApp', 'Root widget. Installs Navigator, Theme, Directionality and more.'),
      (Color(0xFF7965AF), 'Navigator', 'Manages the stack of Route objects. Installs its own Overlay to host routes and transitions.'),
      (Color(0xFF03DAC6), 'Overlay / OverlayState', 'The Z-ordered stack that backs all floating widgets. The OverlayState is reached via Overlay.of(context).'),
      (Color(0xFF388E3C), 'Route 1 (previous)', 'A route beneath the active one. Hidden by opaque: true routes above it.'),
      (Color(0xFF1976D2), 'Route 2 (current)', 'The active page shown to the user. Built by the route\'s builder.'),
      (Color(0xFFEF6C00), 'OverlayEntry', 'A floating layer above all routes. Used for tooltips, menus, banners, and custom HUD elements.'),
    ];

    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                  color: item.$1,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: '${item.$2}  ',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: item.$3),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ===========================================================================
// TAB 9 — Lifecycle diagram
// ===========================================================================

class _LifecycleDiagramTab extends StatelessWidget {
  const _LifecycleDiagramTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(label: 'OverlayEntry Lifecycle'),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.timeline,
            title: 'From creation to disposal',
            body:
                'An OverlayEntry travels through a well-defined sequence of '
                'states. Understanding this lifecycle prevents common bugs '
                'like calling remove() after disposal or markNeedsBuild() '
                'on a detached entry.',
          ),
          const SizedBox(height: 24),
          _LifecycleStep(
            index: 1,
            state: 'Created',
            color: cs.primary,
            code: 'final entry = OverlayEntry(builder: ...);',
            description:
                'An OverlayEntry is a plain Dart object. It is created with a '
                'builder callback and optional opaque/maintainState flags. '
                'At this point it is NOT attached to any Overlay.',
          ),
          _Arrow(),
          _LifecycleStep(
            index: 2,
            state: 'Inserted',
            color: cs.secondary,
            code: 'overlay.insert(entry); // or insertAll / insertAllBelow',
            description:
                'Once inserted into an OverlayState, the entry\'s builder is '
                'called during the next frame. The entry is now part of the '
                'widget tree and can be seen on screen.',
          ),
          _Arrow(),
          _LifecycleStep(
            index: 3,
            state: 'Active (opaque/transparent)',
            color: cs.tertiary,
            code: 'entry.markNeedsBuild(); // trigger rebuild',
            description:
                'The entry is live. If opaque: true, it blocks painting of '
                'entries below it. markNeedsBuild() can be called any time '
                'to refresh the content. maintainState: false entries below '
                'an opaque entry may be detached.',
          ),
          _Arrow(),
          _LifecycleStep(
            index: 4,
            state: 'Removed',
            color: const Color(0xFFEF6C00),
            code: 'entry.remove();',
            description:
                'After remove(), the entry is detached from the OverlayState. '
                'Its widget subtree is unmounted. Calling markNeedsBuild() on '
                'a removed entry is a no-op (safe but does nothing).',
          ),
          _Arrow(),
          _LifecycleStep(
            index: 5,
            state: 'Disposed',
            color: cs.error,
            code: '// Overlay itself is disposed when removed from tree',
            description:
                'When the Overlay widget is itself removed from the tree '
                '(e.g., the Navigator is destroyed), all remaining OverlayEntry '
                'objects are disposed. After disposal, do not call any methods '
                'on the entry.',
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'Key rules'),
          const SizedBox(height: 12),
          const _InfoCard(
            icon: Icons.rule,
            title: 'Lifecycle safety rules',
            body:
                '1. Never call remove() twice — it will throw an assertion error.\n\n'
                '2. Never call insert() on an already-inserted entry.\n\n'
                '3. markNeedsBuild() after remove() is safe but does nothing.\n\n'
                '4. Keep a reference to each OverlayEntry you insert so you can '
                'remove it later — the Overlay does not provide a way to look up '
                'entries by identity.\n\n'
                '5. If you rebuild the widget that created the entry, do not '
                're-insert the same entry — it is still live from the previous build.',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _LifecycleStep extends StatelessWidget {
  const _LifecycleStep({
    required this.index,
    required this.state,
    required this.color,
    required this.code,
    required this.description,
  });

  final int index;
  final String state;
  final Color color;
  final String code;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color,
              foregroundColor: Colors.white,
              child: Text(
                '$index',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: color),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      code,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodySmall,
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

class _Arrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 28),
      child: Column(
        children: [
          Container(
            width: 2,
            height: 16,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          Icon(
            Icons.arrow_downward,
            size: 18,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 10 — Comparison
// ===========================================================================

class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(label: 'OverlayState vs Alternatives'),
          const SizedBox(height: 12),
          _ComparisonCard(
            name: 'OverlayState / OverlayEntry',
            icon: Icons.layers,
            pros: [
              'Imperative — insert/remove from anywhere',
              'Survives route transitions',
              'Composites above all routes',
              'Used by Tooltip, PopupMenu, DropdownMenu',
            ],
            cons: [
              'Manual lifecycle management required',
              'Builder context is Overlay\'s context, not parent',
              'No built-in positioning helpers',
            ],
            usedFor:
                'Tooltips, contextual menus, custom HUDs, loading overlays',
          ),
          const SizedBox(height: 16),
          _ComparisonCard(
            name: 'Stack',
            icon: Icons.dashboard,
            pros: [
              'Declarative — children defined at build time',
              'Built-in Positioned / Alignment',
              'No external state needed',
            ],
            cons: [
              'Cannot add children from outside the Stack\'s build method',
              'Does not survive route navigation',
              'No Z-order management API',
            ],
            usedFor: 'Fixed layouts with overlapping children',
          ),
          const SizedBox(height: 16),
          _ComparisonCard(
            name: 'Navigator / showDialog / push',
            icon: Icons.route,
            pros: [
              'Full route semantics (back button, hero animations)',
              'Modal barrier built-in',
              'Works with route observers',
            ],
            cons: [
              'Heavyweight — creates a full route',
              'Cannot be as easily repositioned or customised',
              'Back-button handling may interfere',
            ],
            usedFor: 'Dialogs, bottom sheets, full-screen modals',
          ),
          const SizedBox(height: 16),
          _ComparisonCard(
            name: 'CompositedTransformFollower + LayerLink',
            icon: Icons.link,
            pros: [
              'Automatically tracks a leader widget\'s position',
              'Works even when the follower is in an OverlayEntry',
              'No manual position calculation needed',
            ],
            cons: [
              'Requires CompositedTransformTarget on the leader',
              'More setup; not standalone',
              'Only positions — does not manage Z-order',
            ],
            usedFor:
                'Positioning overlays relative to another widget (combined with OverlayEntry)',
          ),
          const SizedBox(height: 16),
          _ComparisonCard(
            name: 'OverlayPortal',
            icon: Icons.open_in_new,
            pros: [
              'Declarative — overlay child defined in build()',
              'Automatically shown/hidden via controller',
              'Overlay child has access to parent\'s context',
            ],
            cons: [
              'Requires Flutter 3.7+',
              'Controller must be managed (StatefulWidget or notifier)',
              'Less flexible than raw OverlayEntry for custom scenarios',
            ],
            usedFor:
                'Declarative popups, autocomplete, ComboBox-style widgets',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({
    required this.name,
    required this.icon,
    required this.pros,
    required this.cons,
    required this.usedFor,
  });

  final String name;
  final IconData icon;
  final List<String> pros;
  final List<String> cons;
  final String usedFor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: cs.primary),
                const SizedBox(width: 8),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            _ProConList(label: 'Pros', items: pros, color: cs.primary),
            const SizedBox(height: 8),
            _ProConList(label: 'Cons', items: cons, color: cs.error),
            const SizedBox(height: 8),
            Wrap(
              children: [
                const Text(
                  'Best for: ',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                ),
                Text(usedFor, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProConList extends StatelessWidget {
  const _ProConList({
    required this.label,
    required this.items,
    required this.color,
  });

  final String label;
  final List<String> items;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: color,
          ),
        ),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(left: 12, top: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label == 'Pros' ? '+ ' : '− ',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                Expanded(
                  child: Text(item, style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// TAB 11 — API Cheat Sheet
// ===========================================================================

class _ApiCheatSheetTab extends StatelessWidget {
  const _ApiCheatSheetTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(label: 'OverlayState API Cheat Sheet'),
          const SizedBox(height: 12),
          _ApiSection(
            title: 'Accessing OverlayState',
            entries: const [
              _ApiEntry(
                signature: 'Overlay.of(BuildContext context)',
                returns: 'OverlayState',
                description:
                    'Returns the OverlayState from the nearest Overlay ancestor. '
                    'Throws if none found (use rootOverlay: true to reach Navigator\'s root Overlay).',
              ),
              _ApiEntry(
                signature:
                    'Overlay.of(context, rootOverlay: true)',
                returns: 'OverlayState',
                description:
                    'Skips any local Overlays and returns the root Navigator\'s OverlayState.',
              ),
              _ApiEntry(
                signature:
                    'Overlay.maybeOf(BuildContext context)',
                returns: 'OverlayState?',
                description:
                    'Like Overlay.of but returns null if no Overlay is found instead of throwing.',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _ApiSection(
            title: 'OverlayState methods',
            entries: const [
              _ApiEntry(
                signature: 'insert(OverlayEntry entry, {OverlayEntry? below, OverlayEntry? above})',
                returns: 'void',
                description:
                    'Inserts entry into the overlay. Optionally specify below or above to control Z-order relative to an existing entry.',
              ),
              _ApiEntry(
                signature: 'insertAll(Iterable<OverlayEntry> entries, {OverlayEntry? below, OverlayEntry? above})',
                returns: 'void',
                description:
                    'Inserts multiple entries atomically. Entries are ordered as given (first is bottom-most of the batch).',
              ),
              _ApiEntry(
                signature: 'insertAllBelow(Iterable<OverlayEntry> entries, {required OverlayEntry below})',
                returns: 'void',
                description:
                    'Inserts a batch of entries below the specified anchor entry. '
                    'Entries are ordered bottom-to-top as given, all below the anchor.',
              ),
              _ApiEntry(
                signature: 'rearrange(Iterable<OverlayEntry> newEntries, {OverlayEntry? below, OverlayEntry? above})',
                returns: 'void',
                description:
                    'Atomically reorders all (or a subset of) entries. Entries not in the iterable remain in their existing positions.',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _ApiSection(
            title: 'OverlayEntry constructor',
            entries: const [
              _ApiEntry(
                signature:
                    'OverlayEntry({required WidgetBuilder builder, bool opaque = false, bool maintainState = false})',
                returns: 'OverlayEntry',
                description:
                    'Creates a new entry. builder is called every time the entry needs to rebuild. '
                    'opaque blocks entries below from painting. maintainState keeps the subtree alive when obscured.',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _ApiSection(
            title: 'OverlayEntry methods & properties',
            entries: const [
              _ApiEntry(
                signature: 'remove()',
                returns: 'void',
                description:
                    'Removes this entry from the OverlayState. After removal, the entry\'s subtree is unmounted. Safe to call only once.',
              ),
              _ApiEntry(
                signature: 'markNeedsBuild()',
                returns: 'void',
                description:
                    'Schedules a rebuild of this entry\'s builder. Equivalent to setState inside a StatefulWidget.',
              ),
              _ApiEntry(
                signature: 'builder',
                returns: 'WidgetBuilder',
                description:
                    'Read-only. The builder callback provided at construction.',
              ),
              _ApiEntry(
                signature: 'opaque',
                returns: 'bool',
                description:
                    'Read-write. Whether this entry prevents entries below from being painted. '
                    'Setting this triggers a rebuild of the overlay.',
              ),
              _ApiEntry(
                signature: 'maintainState',
                returns: 'bool',
                description:
                    'Read-write. Whether the entry\'s subtree is kept alive when it is below an opaque entry.',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _ApiSection(
            title: 'Overlay widget constructor',
            entries: const [
              _ApiEntry(
                signature:
                    'Overlay({Key? key, List<OverlayEntry> initialEntries = const [], Clip clipBehavior = Clip.hardEdge})',
                returns: 'Overlay',
                description:
                    'Creates an Overlay widget with optional initial entries. '
                    'Typically you do not create Overlay directly — Navigator creates one for you.',
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SectionHeader(label: 'Quick patterns'),
          const SizedBox(height: 12),
          const _CodeSnippetCard(
            code: '''// Pattern 1: Basic toast
final toast = OverlayEntry(
  builder: (_) => const Positioned(
    bottom: 80,
    left: 20,
    right: 20,
    child: _Toast(message: 'Saved!'),
  ),
);
Overlay.of(context).insert(toast);
Future.delayed(const Duration(seconds: 2), toast.remove);

// Pattern 2: Loading blocker (opaque)
final blocker = OverlayEntry(
  opaque: true,
  builder: (_) => const ColoredBox(
    color: Colors.black54,
    child: Center(child: CircularProgressIndicator()),
  ),
);
Overlay.of(context).insert(blocker);

// Pattern 3: CompositedTransformFollower tooltip
final link = LayerLink();
// In widget tree: CompositedTransformTarget(link: link, child: trigger)
final tip = OverlayEntry(
  builder: (_) => CompositedTransformFollower(
    link: link,
    offset: const Offset(0, 40),
    child: const _TooltipBox(),
  ),
);
Overlay.of(context).insert(tip);''',
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _ApiSection extends StatelessWidget {
  const _ApiSection({
    required this.title,
    required this.entries,
  });

  final String title;
  final List<_ApiEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
        ),
        const SizedBox(height: 8),
        ...entries.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _ApiEntryCard(entry: e),
            )),
      ],
    );
  }
}

class _ApiEntry {
  const _ApiEntry({
    required this.signature,
    required this.returns,
    required this.description,
  });

  final String signature;
  final String returns;
  final String description;
}

class _ApiEntryCard extends StatelessWidget {
  const _ApiEntryCard({required this.entry});

  final _ApiEntry entry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    entry.signature,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    entry.returns,
                    style: TextStyle(
                      fontSize: 10,
                      color: cs.onSecondaryContainer,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              entry.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// Shared helper widgets
// ===========================================================================

class _GradientBanner extends StatelessWidget {
  const _GradientBanner({
    required this.title,
    required this.subtitle,
    required this.colors,
  });

  final String title;
  final String subtitle;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.first.withAlpha(80),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodySmall,
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

class _CodeSnippetCard extends StatelessWidget {
  const _CodeSnippetCard({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 13),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyStateChip extends StatelessWidget {
  const _EmptyStateChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

class _LayerCard extends StatelessWidget {
  const _LayerCard({required this.layers});

  final List<(String, Color)> layers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: layers.reversed.toList().asMap().entries.map((e) {
        final item = e.value;
        final depth = layers.length - e.key;
        return Container(
          margin: EdgeInsets.only(
            bottom: 4,
            left: (layers.length - depth) * 8.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: item.$2.withAlpha(200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            item.$1,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        );
      }).toList(),
    );
  }
}
