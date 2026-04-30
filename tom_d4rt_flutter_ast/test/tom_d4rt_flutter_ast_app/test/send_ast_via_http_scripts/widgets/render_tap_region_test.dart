import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Top-level mutable state  (STATELESS: all ValueNotifiers live here)
// ─────────────────────────────────────────────────────────────────────────────

/// Tab 2 — basic single TapRegion demo
final ValueNotifier<String> _lastEvent = ValueNotifier<String>('(none yet)');

/// Tab 3 — enabled toggle
final ValueNotifier<bool> _tapRegionEnabled = ValueNotifier<bool>(true);
final ValueNotifier<String> _enabledEvent = ValueNotifier<String>('(none yet)');

/// Tab 4 — groupId grouping
final ValueNotifier<String> _groupedEvent = ValueNotifier<String>('(none yet)');
final ValueNotifier<String> _ungroupedEvent =
    ValueNotifier<String>('(none yet)');

/// Tab 5 — dropdown dismiss
final ValueNotifier<bool> _dropdownOpen = ValueNotifier<bool>(false);
final ValueNotifier<String> _dropdownLog = ValueNotifier<String>('(closed)');

/// Tab 6 — consumeOutsideTaps
final ValueNotifier<bool> _consumeOutside = ValueNotifier<bool>(false);
final ValueNotifier<String> _consumeLog = ValueNotifier<String>('(none yet)');
final ValueNotifier<int> _underlyingTaps = ValueNotifier<int>(0);

/// Tab 9 — behavior tab
final ValueNotifier<HitTestBehavior> _behavior =
    ValueNotifier<HitTestBehavior>(HitTestBehavior.deferToChild);
final ValueNotifier<String> _behaviorEvent =
    ValueNotifier<String>('(none yet)');

// ─────────────────────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    home: const _TapRegionDemo(),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Root shell — 9 tabs
// ─────────────────────────────────────────────────────────────────────────────

class _TapRegionDemo extends StatelessWidget {
  const _TapRegionDemo();

  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Hero'),
    Tab(text: 'Basic'),
    Tab(text: 'Enabled'),
    Tab(text: 'GroupId'),
    Tab(text: 'Dropdown'),
    Tab(text: 'Consume'),
    Tab(text: 'vs Barrier'),
    Tab(text: 'Arch'),
    Tab(text: 'Behavior'),
    Tab(text: 'Use Cases'),
    Tab(text: 'API'),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: cs.surface,
        appBar: AppBar(
          backgroundColor: cs.primaryContainer,
          title: Text(
            'TapRegion / RenderTapRegion',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: cs.onPrimaryContainer,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: cs.onPrimaryContainer,
            indicatorColor: cs.primary,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: [
            _HeroBannerTab(),
            _BasicTapRegionTab(),
            _EnabledToggleTab(),
            _GroupIdTab(),
            _DropdownDismissTab(),
            _ConsumeOutsideTapsTab(),
            _VsModalBarrierTab(),
            _ArchDiagramTab(),
            _BehaviorTab(),
            _UseCasesTab(),
            _ApiCheatSheetTab(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: cs.surfaceContainerHighest.withValues(alpha: 0.55),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _PropRow extends StatelessWidget {
  const _PropRow(this.name, this.value, {this.highlight = false});

  final String name;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color:
            highlight
                ? cs.primaryContainer.withValues(alpha: 0.35)
                : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: cs.outlineVariant, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  const _CodeSnippet(this.code);

  final String code;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.inverseSurface.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Text(
        code,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontFamily: 'monospace',
          color: cs.onSurface,
        ),
      ),
    );
  }
}

class _EventBadge extends StatelessWidget {
  const _EventBadge({required this.notifier, required this.label});

  final ValueNotifier<String> notifier;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ValueListenableBuilder<String>(
      valueListenable: notifier,
      builder: (context, value, _) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: cs.secondaryContainer,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cs.secondary.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Icon(Icons.notifications_active, size: 16, color: cs.secondary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$label: $value',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: cs.onSecondaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader(this.cells);

  final List<String> cells;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      color: cs.primaryContainer.withValues(alpha: 0.45),
      child: Row(
        children:
            cells
                .map(
                  (c) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      child: Text(
                        c,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow(this.cells, {this.shade = false});

  final List<String> cells;
  final bool shade;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      color: shade ? cs.surfaceContainerHighest.withValues(alpha: 0.3) : null,
      child: Row(
        children:
            cells
                .map(
                  (c) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      child: Text(c, style: Theme.of(context).textTheme.bodySmall),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 1 — Hero Banner
// ─────────────────────────────────────────────────────────────────────────────

class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Hero card
        Card(
          color: cs.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.touch_app,
                      size: 40,
                      color: cs.onPrimaryContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'TapRegion & RenderTapRegion',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          color: cs.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'TapRegion registers a widget subtree as a named tap zone '
                  'within the nearest TapRegionSurface ancestor. When a '
                  'pointer-down event lands anywhere on the surface, the surface '
                  'routes the event to every registered TapRegion and fires '
                  'onTapOutside on regions that did NOT contain the hit, and '
                  'onTapInside on the one that did.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cs.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Tap-outside dismiss pattern
        _SectionCard(
          title: 'The Tap-Outside Dismiss Pattern',
          subtitle:
              'Why TapRegion exists and when to reach for it.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Many UI components — dropdowns, autocomplete lists, color '
                'pickers, context menus — should close when the user taps '
                'outside them. Historically this required routing global '
                'pointer events with Overlay or ModalBarrier tricks that '
                'interfered with scroll physics and sibling interactivity.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              Text(
                'TapRegion solves this without a modal layer. The component '
                'wraps itself in a TapRegion and listens to onTapOutside. '
                'Siblings remain fully interactive. Scrolling is unaffected. '
                'The surface handles all routing transparently.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _HighlightTile(
                      icon: Icons.check_circle_outline,
                      color: cs.tertiary,
                      title: 'Non-modal',
                      body:
                          'Siblings stay interactive — no invisible blocker layer needed.',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _HighlightTile(
                      icon: Icons.groups,
                      color: cs.secondary,
                      title: 'Groupable',
                      body:
                          'Multiple regions share a groupId to act as one logical unit.',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Relationship with TapRegionSurface
        _SectionCard(
          title: 'Relationship with TapRegionSurface',
          subtitle:
              'TapRegion is useless without a TapRegionSurface ancestor.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TapRegionSurface is a special RenderProxyBox descendant that '
                'implements the TapRegionRegistry. Every TapRegion walks up '
                'the element tree to find it and registers itself. When a '
                'pointer-down event arrives at the surface, it iterates its '
                'registry and calls onTapInside / onTapOutside as appropriate.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              _CodeSnippet(
                'TapRegionSurface(\n'
                '  child: Stack(children: [\n'
                '    _MyTextField(),         // wrapped in TapRegion A\n'
                '    _MySuggestionsPanel(),  // wrapped in TapRegion A (same groupId)\n'
                '    _OtherContent(),        // outside — triggers onTapOutside\n'
                '  ]),\n'
                ')',
              ),
              const SizedBox(height: 10),
              Text(
                'Scaffold already wraps its body in a TapRegionSurface, so '
                'most Material widgets (DropdownMenu, Autocomplete) work '
                'without manually adding one.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        // Class declaration
        _SectionCard(
          title: 'Class Declaration',
          subtitle: 'TapRegion extends SingleChildRenderObjectWidget.',
          child: _CodeSnippet(
            'class TapRegion extends SingleChildRenderObjectWidget {\n'
            '  const TapRegion({\n'
            '    super.key,\n'
            '    this.enabled = true,\n'
            '    this.behavior = HitTestBehavior.deferToChild,\n'
            '    this.groupId,\n'
            '    this.onTapInside,\n'
            '    this.onTapOutside,\n'
            '    this.consumeOutsideTaps = false,\n'
            '    this.debugLabel,\n'
            '    super.child,\n'
            '  });\n'
            '\n'
            '  @override\n'
            '  RenderObject createRenderObject(BuildContext context)\n'
            '      => RenderTapRegion(...);\n'
            '}',
          ),
        ),
      ],
    );
  }
}

class _HighlightTile extends StatelessWidget {
  const _HighlightTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(body, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 2 — Basic TapRegion Demo
// ─────────────────────────────────────────────────────────────────────────────

class _BasicTapRegionTab extends StatelessWidget {
  const _BasicTapRegionTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TapRegionSurface(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'Basic TapRegion Demo',
            subtitle:
                'A single TapRegion-wrapped card. Tap inside or outside to '
                'observe events.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The purple card below is wrapped in a TapRegion. Tap it '
                  'to fire onTapInside. Tap this text or elsewhere on the '
                  'surface to fire onTapOutside.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                TapRegion(
                  onTapInside: (_) {
                    _lastEvent.value =
                        'onTapInside fired at ${DateTime.now().second}s';
                  },
                  onTapOutside: (_) {
                    _lastEvent.value =
                        'onTapOutside fired at ${DateTime.now().second}s';
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: cs.primary, width: 2),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.touch_app,
                          size: 36,
                          color: cs.onPrimaryContainer,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap Region Target',
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            color: cs.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '← tap inside here →',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: cs.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _EventBadge(notifier: _lastEvent, label: 'Last event'),
                const SizedBox(height: 16),
                _CodeSnippet(
                  'TapRegion(\n'
                  '  onTapInside: (event) {\n'
                  '    _lastEvent.value = "inside";\n'
                  '  },\n'
                  '  onTapOutside: (event) {\n'
                  '    _lastEvent.value = "outside";\n'
                  '  },\n'
                  '  child: MyCard(),\n'
                  ')',
                ),
              ],
            ),
          ),

          _SectionCard(
            title: 'How the Callback Fires',
            subtitle:
                'The pointer event that arrives at TapRegionSurface.',
            child: Column(
              children: const [
                _PropRow('Callback', 'Fires when …'),
                _PropRow(
                  'onTapInside',
                  'pointer-down lands inside this region\'s paint bounds',
                  highlight: true,
                ),
                _PropRow(
                  'onTapOutside',
                  'pointer-down lands outside this region\'s paint bounds',
                ),
                _PropRow(
                  'Parameter type',
                  'PointerDownEvent — full pointer metadata',
                  highlight: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 3 — Enabled Toggle
// ─────────────────────────────────────────────────────────────────────────────

class _EnabledToggleTab extends StatelessWidget {
  const _EnabledToggleTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TapRegionSurface(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'enabled Toggle',
            subtitle:
                'When enabled=false the TapRegion is unregistered; callbacks '
                'never fire.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: _tapRegionEnabled,
                  builder: (context, enabled, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'TapRegion enabled',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            SegmentedButton<bool>(
                              segments: const [
                                ButtonSegment(
                                  value: true,
                                  label: Text('On'),
                                  icon: Icon(Icons.check),
                                ),
                                ButtonSegment(
                                  value: false,
                                  label: Text('Off'),
                                  icon: Icon(Icons.block),
                                ),
                              ],
                              selected: {enabled},
                              onSelectionChanged: (s) {
                                _tapRegionEnabled.value = s.first;
                                _enabledEvent.value =
                                    'enabled set to ${s.first}';
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TapRegion(
                          enabled: enabled,
                          onTapInside: (_) {
                            _enabledEvent.value =
                                'onTapInside at ${DateTime.now().second}s';
                          },
                          onTapOutside: (_) {
                            _enabledEvent.value =
                                'onTapOutside at ${DateTime.now().second}s';
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: enabled
                                  ? cs.primaryContainer
                                  : cs.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: enabled
                                    ? cs.primary
                                    : cs.outline.withValues(alpha: 0.4),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  enabled
                                      ? Icons.sensor_occupied
                                      : Icons.sensors_off,
                                  color: enabled
                                      ? cs.onPrimaryContainer
                                      : cs.outline,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  enabled
                                      ? 'Region ACTIVE — tap me'
                                      : 'Region DISABLED — taps ignored',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall?.copyWith(
                                    color: enabled
                                        ? cs.onPrimaryContainer
                                        : cs.outline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _EventBadge(
                          notifier: _enabledEvent,
                          label: 'Event',
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                _CodeSnippet(
                  'ValueListenableBuilder<bool>(\n'
                  '  valueListenable: _enabled,\n'
                  '  builder: (context, enabled, _) {\n'
                  '    return TapRegion(\n'
                  '      enabled: enabled,  // ← key prop\n'
                  '      onTapOutside: (_) => _dismiss(),\n'
                  '      child: MyOverlay(),\n'
                  '    );\n'
                  '  },\n'
                  ')',
                ),
              ],
            ),
          ),

          _SectionCard(
            title: 'Lifecycle Effect of enabled',
            subtitle: 'RenderTapRegion registers/unregisters on change.',
            child: Column(
              children: const [
                _PropRow('enabled=true', 'RenderTapRegion registers with surface'),
                _PropRow(
                  'enabled=false',
                  'RenderTapRegion unregisters — zero overhead',
                  highlight: true,
                ),
                _PropRow(
                  'Widget removed',
                  'Automatically unregistered in detachFromRenderTree',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 4 — GroupId Grouping
// ─────────────────────────────────────────────────────────────────────────────

class _GroupIdTab extends StatelessWidget {
  const _GroupIdTab();

  static const Object _groupId = 'demo-group';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TapRegionSurface(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'groupId — Logical Region Groups',
            subtitle:
                'Three TapRegions share one groupId. Tap inside any one → '
                '"inside group". Tap outside all → "outside group".',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The three purple tiles below all share groupId "demo-group". '
                  'Tapping any one counts as "inside the group". Only tapping '
                  'outside all three triggers onTapOutside.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _GroupedTile(
                      label: 'A',
                      groupId: _groupId,
                      notifier: _groupedEvent,
                    ),
                    const SizedBox(width: 8),
                    _GroupedTile(
                      label: 'B',
                      groupId: _groupId,
                      notifier: _groupedEvent,
                    ),
                    const SizedBox(width: 8),
                    _GroupedTile(
                      label: 'C',
                      groupId: _groupId,
                      notifier: _groupedEvent,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _EventBadge(notifier: _groupedEvent, label: 'Group event'),
                const SizedBox(height: 16),
                Divider(color: cs.outlineVariant),
                const SizedBox(height: 8),
                Text(
                  'Ungrouped — same layout, each TapRegion is independent.',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _GroupedTile(
                      label: 'X',
                      groupId: null,
                      notifier: _ungroupedEvent,
                      color: cs.tertiaryContainer,
                      onColor: cs.onTertiaryContainer,
                    ),
                    const SizedBox(width: 8),
                    _GroupedTile(
                      label: 'Y',
                      groupId: null,
                      notifier: _ungroupedEvent,
                      color: cs.tertiaryContainer,
                      onColor: cs.onTertiaryContainer,
                    ),
                    const SizedBox(width: 8),
                    _GroupedTile(
                      label: 'Z',
                      groupId: null,
                      notifier: _ungroupedEvent,
                      color: cs.tertiaryContainer,
                      onColor: cs.onTertiaryContainer,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _EventBadge(notifier: _ungroupedEvent, label: 'Ungrouped event'),
              ],
            ),
          ),

          _SectionCard(
            title: 'groupId Code Pattern',
            subtitle: 'Anchor the same Object constant to every member.',
            child: _CodeSnippet(
              'const Object _menuGroup = \'context-menu\';\n'
              '\n'
              'TapRegion(\n'
              '  groupId: _menuGroup,\n'
              '  onTapOutside: (_) => _closeMenu(),\n'
              '  child: _MenuAnchorWidget(),\n'
              ')\n'
              '\n'
              'TapRegion(\n'
              '  groupId: _menuGroup,  // same constant\n'
              '  onTapOutside: (_) => _closeMenu(),\n'
              '  child: _MenuPanel(),\n'
              ')',
            ),
          ),

          _SectionCard(
            title: 'Grouping Rules',
            subtitle: 'How the surface routes events for grouped regions.',
            child: Column(
              children: const [
                _PropRow('Same groupId', 'All members fire onTapInside together'),
                _PropRow(
                  'Different groupId',
                  'Each region is independent',
                  highlight: true,
                ),
                _PropRow('null groupId', 'Region is its own group (default)'),
                _PropRow(
                  'Equality check',
                  'groupId uses == for matching — const preferred',
                  highlight: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupedTile extends StatelessWidget {
  const _GroupedTile({
    required this.label,
    required this.groupId,
    required this.notifier,
    this.color,
    this.onColor,
  });

  final String label;
  final Object? groupId;
  final ValueNotifier<String> notifier;
  final Color? color;
  final Color? onColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = color ?? cs.primaryContainer;
    final fg = onColor ?? cs.onPrimaryContainer;
    return Expanded(
      child: TapRegion(
        groupId: groupId,
        onTapInside: (_) {
          notifier.value = 'inside ($label) at ${DateTime.now().second}s';
        },
        onTapOutside: (_) {
          notifier.value = 'outside ($label) at ${DateTime.now().second}s';
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: fg.withValues(alpha: 0.4)),
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: fg,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 5 — Dropdown Dismiss Pattern
// ─────────────────────────────────────────────────────────────────────────────

class _DropdownDismissTab extends StatelessWidget {
  const _DropdownDismissTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TapRegionSurface(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'Autocomplete-Style Dropdown',
            subtitle:
                'Text field and dropdown panel share a groupId. Tapping '
                'outside both closes the panel.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tap the text field below to open the suggestions panel. '
                  'Tap a suggestion or tap outside everything to dismiss.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                _DropdownRegionDemo(cs: cs),
                const SizedBox(height: 12),
                _EventBadge(notifier: _dropdownLog, label: 'State'),
              ],
            ),
          ),

          _SectionCard(
            title: 'Implementation Pattern',
            subtitle:
                'Both the input and the overlay share the same groupId.',
            child: _CodeSnippet(
              'const Object _inputGroup = #autocompleteGroup;\n'
              '\n'
              '// Text field\n'
              'TapRegion(\n'
              '  groupId: _inputGroup,\n'
              '  onTapInside: (_) => _open.value = true,\n'
              '  onTapOutside: (_) => _open.value = false,\n'
              '  child: TextField(...),\n'
              ')\n'
              '\n'
              '// Suggestions overlay\n'
              'if (open)\n'
              '  TapRegion(\n'
              '    groupId: _inputGroup,  // same\n'
              '    onTapOutside: (_) => _open.value = false,\n'
              '    child: _SuggestionsPanel(),\n'
              '  )',
            ),
          ),

          _SectionCard(
            title: 'Why groupId is Critical Here',
            subtitle:
                'Without groupId, tapping a suggestion fires onTapOutside on '
                'the text field.',
            child: Column(
              children: const [
                _PropRow('Without groupId', 'Panel tap → onTapOutside on field → closes'),
                _PropRow(
                  'With same groupId',
                  'Panel tap → inside the group → field stays open',
                  highlight: true,
                ),
                _PropRow(
                  'Outside click',
                  'Neither region hit → onTapOutside on both → closes',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const Object _dropdownGroup = #dropdownDemoGroup;

class _DropdownRegionDemo extends StatelessWidget {
  const _DropdownRegionDemo({required this.cs});

  final ColorScheme cs;

  static const List<String> _suggestions = [
    'Apple',
    'Apricot',
    'Avocado',
    'Banana',
    'Blueberry',
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _dropdownOpen,
      builder: (context, open, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TapRegion(
              groupId: _dropdownGroup,
              onTapInside: (_) {
                _dropdownOpen.value = true;
                _dropdownLog.value = 'panel opened';
              },
              onTapOutside: (_) {
                _dropdownOpen.value = false;
                _dropdownLog.value = 'dismissed via outside tap';
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: open ? cs.primary : cs.outline,
                    width: open ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: open ? cs.primary : cs.onSurfaceVariant,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        open ? 'Searching fruits…' : 'Tap to search fruits',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: open ? cs.onSurface : cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Icon(
                      open ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: cs.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
            if (open)
              TapRegion(
                groupId: _dropdownGroup,
                onTapOutside: (_) {
                  _dropdownOpen.value = false;
                  _dropdownLog.value = 'dismissed via outside tap';
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cs.outline),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.10),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children:
                        _suggestions
                            .map(
                              (s) => InkWell(
                                onTap: () {
                                  _dropdownOpen.value = false;
                                  _dropdownLog.value = 'selected: $s';
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 8,
                                        color: cs.primary,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(s),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 6 — consumeOutsideTaps Demo
// ─────────────────────────────────────────────────────────────────────────────

class _ConsumeOutsideTapsTab extends StatelessWidget {
  const _ConsumeOutsideTapsTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TapRegionSurface(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'consumeOutsideTaps',
            subtitle:
                'Controls whether outside taps propagate to underlying '
                'GestureDetectors after the region fires onTapOutside.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Toggle the switch, then tap the GestureDetector button below '
                  'the region. When consume=true, the button does NOT receive '
                  'the tap.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 14),
                ValueListenableBuilder<bool>(
                  valueListenable: _consumeOutside,
                  builder: (context, consume, _) {
                    return Row(
                      children: [
                        const Expanded(
                          child: Text('consumeOutsideTaps'),
                        ),
                        Switch(
                          value: consume,
                          onChanged: (v) {
                            _consumeOutside.value = v;
                            _consumeLog.value = 'consume set to $v';
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<bool>(
                  valueListenable: _consumeOutside,
                  builder: (context, consume, _) {
                    return Stack(
                      children: [
                        // Underlying interactive button
                        GestureDetector(
                          onTap: () {
                            _underlyingTaps.value++;
                            _consumeLog.value =
                                'GestureDetector tapped (total: ${_underlyingTaps.value})';
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: cs.tertiaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ValueListenableBuilder<int>(
                              valueListenable: _underlyingTaps,
                              builder: (context, taps, _) {
                                return Text(
                                  'GestureDetector (taps: $taps)',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color: cs.onTertiaryContainer,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // TapRegion overlay
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: TapRegion(
                              consumeOutsideTaps: consume,
                              onTapInside: (_) {
                                _consumeLog.value =
                                    'onTapInside at ${DateTime.now().second}s';
                              },
                              onTapOutside: (_) {
                                _consumeLog.value = consume
                                    ? 'onTapOutside — tap CONSUMED'
                                    : 'onTapOutside — tap propagated';
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: cs.primaryContainer.withValues(
                                    alpha: 0.9,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: cs.primary),
                                ),
                                child: Text(
                                  'TapRegion (consumeOutsideTaps: $consume)',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: cs.onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),
                _EventBadge(notifier: _consumeLog, label: 'Event'),
              ],
            ),
          ),

          _SectionCard(
            title: 'consumeOutsideTaps Semantics',
            subtitle:
                'What "consume" means in Flutter hit-testing.',
            child: Column(
              children: const [
                _PropRow('false (default)', 'Tap continues up the hit-test chain'),
                _PropRow(
                  'true',
                  'Tap is consumed — siblings/ancestors do NOT receive it',
                  highlight: true,
                ),
                _PropRow(
                  'Use case',
                  'Prevent accidental button presses when dismissing a popup',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 7 — TapRegion vs ModalBarrier
// ─────────────────────────────────────────────────────────────────────────────

class _VsModalBarrierTab extends StatelessWidget {
  const _VsModalBarrierTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SectionCard(
          title: 'TapRegion vs ModalBarrier',
          subtitle: 'Choosing the right dismiss mechanism.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _CompareCard(
                      icon: Icons.touch_app,
                      color: cs.primary,
                      title: 'TapRegion',
                      points: const [
                        'Non-modal — siblings interactive',
                        'Uses pointer routing, not overlay',
                        '"Soft dismiss" UX',
                        'Zero zIndex impact',
                        'Works inside scrollables',
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _CompareCard(
                      icon: Icons.layers,
                      color: cs.tertiary,
                      title: 'ModalBarrier',
                      points: const [
                        'Blocks all input below',
                        'Sits in Overlay stack',
                        '"Hard block" UX',
                        'Optional dismissOnTap',
                        'For dialogs/sheets',
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Comparison table',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: cs.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _TableHeader(const [
                      'Aspect',
                      'TapRegion',
                      'ModalBarrier',
                    ]),
                    const _TableRow([
                      'Blocks siblings',
                      'No',
                      'Yes',
                    ]),
                    const _TableRow(
                      ['Overlay required', 'No', 'Yes'],
                      shade: true,
                    ),
                    const _TableRow([
                      'Dismiss on outside',
                      'onTapOutside cb',
                      'dismissOnTap: true',
                    ]),
                    const _TableRow(
                      ['Use for', 'Popups, dropdowns', 'Dialogs, sheets'],
                      shade: true,
                    ),
                    const _TableRow([
                      'Scrollables',
                      'Compatible',
                      'Interferes',
                    ]),
                    const _TableRow(
                      ['Performance', 'Very low', 'Medium (Overlay)'],
                      shade: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        _SectionCard(
          title: 'Decision Guide',
          subtitle: 'Pick the right tool for your dismiss UX.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DecisionRow(
                condition: 'Dropdown / autocomplete / tooltip',
                answer: 'TapRegion',
                icon: Icons.check,
                color: cs.primary,
              ),
              _DecisionRow(
                condition: 'AlertDialog / BottomSheet',
                answer: 'ModalBarrier (built-in)',
                icon: Icons.layers,
                color: cs.tertiary,
              ),
              _DecisionRow(
                condition: 'Context menu stays visible while user scrolls',
                answer: 'TapRegion',
                icon: Icons.check,
                color: cs.primary,
              ),
              _DecisionRow(
                condition: 'Prevent ALL interaction while loading',
                answer: 'ModalBarrier',
                icon: Icons.layers,
                color: cs.tertiary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CompareCard extends StatelessWidget {
  const _CompareCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.points,
  });

  final IconData icon;
  final Color color;
  final String title;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...points.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.fiber_manual_record, size: 8, color: color),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(p, style: Theme.of(context).textTheme.bodySmall),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DecisionRow extends StatelessWidget {
  const _DecisionRow({
    required this.condition,
    required this.answer,
    required this.icon,
    required this.color,
  });

  final String condition;
  final String answer;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              condition,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 14, color: color),
                const SizedBox(width: 4),
                Text(
                  answer,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 8 — Architecture Diagram (CustomPainter)
// ─────────────────────────────────────────────────────────────────────────────

class _ArchDiagramTab extends StatelessWidget {
  const _ArchDiagramTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SectionCard(
          title: 'Architecture Diagram',
          subtitle:
              'TapRegionSurface routes pointer events to all registered '
              'RenderTapRegion children.',
          child: SizedBox(
            height: 320,
            child: CustomPaint(
              painter: _ArchPainter(
                colors: Theme.of(context).colorScheme,
              ),
            ),
          ),
        ),

        _SectionCard(
          title: 'How Routing Works',
          subtitle: 'Step-by-step pointer-down event flow.',
          child: Column(
            children: const [
              _PropRow('1. Pointer down', 'OS delivers PointerDownEvent to Flutter'),
              _PropRow(
                '2. Hit test',
                'RenderTapRegionSurface receives the event',
                highlight: true,
              ),
              _PropRow(
                '3. Region lookup',
                'Surface iterates its TapRegionRegistry',
              ),
              _PropRow(
                '4. Position check',
                'Each RenderTapRegion checks if point is inside its bounds',
                highlight: true,
              ),
              _PropRow(
                '5. Callbacks',
                'onTapInside for hit regions; onTapOutside for misses',
              ),
              _PropRow(
                '6. Groups',
                'Group members treated as one logical region',
                highlight: true,
              ),
            ],
          ),
        ),

        _SectionCard(
          title: 'Registration Lifecycle',
          subtitle: 'When TapRegion attaches and detaches from the surface.',
          child: _CodeSnippet(
            '// In RenderTapRegion\n'
            '@override\n'
            'void attach(PipelineOwner owner) {\n'
            '  super.attach(owner);\n'
            '  _registry?.registerTapRegion(this);\n'
            '}\n'
            '\n'
            '@override\n'
            'void detach() {\n'
            '  _registry?.unregisterTapRegion(this);\n'
            '  super.detach();\n'
            '}',
          ),
        ),
      ],
    );
  }
}

class _ArchPainter extends CustomPainter {
  const _ArchPainter({required this.colors});

  final ColorScheme colors;

  @override
  void paint(Canvas canvas, Size size) {
    final surfacePaint = Paint()
      ..color = colors.primaryContainer.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final surfaceBorder = Paint()
      ..color = colors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final regionAPaint = Paint()
      ..color = colors.secondaryContainer
      ..style = PaintingStyle.fill;

    final regionBPaint = Paint()
      ..color = colors.tertiaryContainer
      ..style = PaintingStyle.fill;

    final arrowPaint = Paint()
      ..color = colors.error
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final textStyle = TextStyle(
      color: colors.onSurface,
      fontSize: 11,
    );

    final labelStyle = TextStyle(
      color: colors.primary,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    // TapRegionSurface box
    final surfaceRect = Rect.fromLTWH(
      20,
      60,
      size.width - 40,
      size.height - 80,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(surfaceRect, const Radius.circular(12)),
      surfacePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(surfaceRect, const Radius.circular(12)),
      surfaceBorder,
    );

    // Surface label
    _drawText(
      canvas,
      'TapRegionSurface (RenderTapRegionSurface)',
      Offset(surfaceRect.left + 14, surfaceRect.top + 10),
      labelStyle,
    );

    // Region A
    final regionA = Rect.fromLTWH(
      surfaceRect.left + 20,
      surfaceRect.top + 40,
      (surfaceRect.width - 60) * 0.45,
      120,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(regionA, const Radius.circular(8)),
      regionAPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(regionA, const Radius.circular(8)),
      Paint()
        ..color = colors.secondary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    _drawText(
      canvas,
      'RenderTapRegion A\ngroupId: #menu',
      Offset(regionA.left + 8, regionA.top + 12),
      textStyle,
    );

    // Region B
    final regionB = Rect.fromLTWH(
      surfaceRect.left + 40 + (surfaceRect.width - 60) * 0.45,
      surfaceRect.top + 40,
      (surfaceRect.width - 60) * 0.45,
      120,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(regionB, const Radius.circular(8)),
      regionBPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(regionB, const Radius.circular(8)),
      Paint()
        ..color = colors.tertiary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    _drawText(
      canvas,
      'RenderTapRegion B\ngroupId: #menu',
      Offset(regionB.left + 8, regionB.top + 12),
      textStyle,
    );

    // Pointer arrow from top
    final arrowStart = Offset(size.width / 2, 10);
    final arrowEnd = Offset(size.width / 2, surfaceRect.top + 8);
    canvas.drawLine(arrowStart, arrowEnd, arrowPaint);
    // Arrowhead
    canvas.drawLine(
      arrowEnd,
      Offset(arrowEnd.dx - 6, arrowEnd.dy - 10),
      arrowPaint,
    );
    canvas.drawLine(
      arrowEnd,
      Offset(arrowEnd.dx + 6, arrowEnd.dy - 10),
      arrowPaint,
    );

    _drawText(
      canvas,
      'PointerDownEvent',
      Offset(size.width / 2 + 6, 12),
      TextStyle(color: colors.error, fontSize: 11, fontWeight: FontWeight.bold),
    );

    // Routing arrows: surface → regions
    final surfaceMid = Offset(size.width / 2, surfaceRect.top + 35);
    final regionACenter = Offset(regionA.center.dx, regionA.top);
    final regionBCenter = Offset(regionB.center.dx, regionB.top);

    final routePaint = Paint()
      ..color = colors.primary.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(surfaceMid, regionACenter, routePaint);
    canvas.drawLine(surfaceMid, regionBCenter, routePaint);

    // Legend
    _drawText(
      canvas,
      'A & B share groupId → both fire onTapInside together',
      Offset(surfaceRect.left + 14, surfaceRect.bottom - 24),
      TextStyle(
        color: colors.onSurfaceVariant,
        fontSize: 10,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 200);
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_ArchPainter old) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 9 — behavior (HitTestBehavior)
// ─────────────────────────────────────────────────────────────────────────────

class _BehaviorTab extends StatelessWidget {
  const _BehaviorTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TapRegionSurface(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionCard(
            title: 'HitTestBehavior on TapRegion',
            subtitle:
                'Controls how the region\'s RenderBox participates in hit '
                'testing for its own child subtree.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<HitTestBehavior>(
                  valueListenable: _behavior,
                  builder: (context, behavior, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          children: HitTestBehavior.values.map((b) {
                            final selected = b == behavior;
                            return FilterChip(
                              label: Text(b.name),
                              selected: selected,
                              onSelected: (_) {
                                _behavior.value = b;
                                _behaviorEvent.value = 'behavior → ${b.name}';
                              },
                              selectedColor: cs.primaryContainer,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),
                        TapRegion(
                          behavior: behavior,
                          onTapInside: (_) {
                            _behaviorEvent.value =
                                'onTapInside (${behavior.name}) at '
                                '${DateTime.now().second}s';
                          },
                          onTapOutside: (_) {
                            _behaviorEvent.value =
                                'onTapOutside (${behavior.name}) at '
                                '${DateTime.now().second}s';
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: cs.secondaryContainer,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: cs.secondary),
                            ),
                            child: Text(
                              'behavior: ${behavior.name}\nTap me or outside',
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                color: cs.onSecondaryContainer,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _EventBadge(notifier: _behaviorEvent, label: 'Event'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          _SectionCard(
            title: 'HitTestBehavior Values',
            subtitle:
                'Effect on the TapRegion render object itself — not on the '
                'TapRegionSurface routing.',
            child: Column(
              children: const [
                _PropRow('deferToChild', 'Hit only if a child claims the hit (default)'),
                _PropRow(
                  'opaque',
                  'Region claims every hit within its bounds — even transparent areas',
                  highlight: true,
                ),
                _PropRow(
                  'translucent',
                  'Passes hits through AND claims them — both paths active',
                ),
              ],
            ),
          ),

          _SectionCard(
            title: 'Important Distinction',
            subtitle:
                'behavior affects local hit-testing, not the surface routing.',
            child: Text(
              'The behavior prop governs whether the TapRegion\'s own '
              'RenderBox "claims" a pointer hit during the local hit-test walk. '
              'The TapRegionSurface routing (onTapInside / onTapOutside) is '
              'separate — it fires on pointer-down regardless of whether the '
              'local hit test succeeded, as long as enabled=true.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 10 — Use Cases
// ─────────────────────────────────────────────────────────────────────────────

class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final useCases = [
      _UseCase(
        icon: Icons.arrow_drop_down_circle,
        color: cs.primary,
        title: 'Dropdown Menu',
        description:
            'Dismiss the dropdown when user taps outside the anchor and panel.',
        code:
            'TapRegion(\n'
            '  groupId: #dropdown,\n'
            '  onTapOutside: (_) => close(),\n'
            '  child: DropdownPanel(),\n'
            ')',
      ),
      _UseCase(
        icon: Icons.search,
        color: cs.secondary,
        title: 'Autocomplete',
        description:
            'Suggestions panel and text field share a groupId so clicking a '
            'suggestion does not dismiss the list.',
        code:
            'TapRegion(\n'
            '  groupId: #auto,\n'
            '  onTapOutside: (_) => hideSuggestions(),\n'
            '  child: SuggestionsPanel(),\n'
            ')',
      ),
      _UseCase(
        icon: Icons.palette,
        color: cs.tertiary,
        title: 'Color Picker',
        description:
            'Floating color picker closes when the user clicks back on the '
            'document canvas.',
        code:
            'TapRegion(\n'
            '  onTapOutside: (_) => _pickerOpen.value = false,\n'
            '  child: ColorPickerOverlay(),\n'
            ')',
      ),
      _UseCase(
        icon: Icons.calendar_today,
        color: cs.error,
        title: 'Date Picker',
        description:
            'Inline date picker panel dismisses without blocking the rest of '
            'the form.',
        code:
            'TapRegion(\n'
            '  groupId: #datePicker,\n'
            '  onTapOutside: (_) => _calendarOpen.value = false,\n'
            '  child: CalendarWidget(),\n'
            ')',
      ),
      _UseCase(
        icon: Icons.info_outline,
        color: Colors.teal,
        title: 'Tooltip',
        description:
            'Rich tooltip card stays open while hovering inside; closes on '
            'any tap outside.',
        code:
            'TapRegion(\n'
            '  onTapOutside: (_) => _tooltip.value = false,\n'
            '  child: TooltipCard(),\n'
            ')',
      ),
      _UseCase(
        icon: Icons.more_vert,
        color: Colors.orange,
        title: 'Context Menu',
        description:
            'Right-click context menu dismisses when the user taps anywhere '
            'else on the surface.',
        code:
            'TapRegion(\n'
            '  onTapOutside: (_) => _menu.value = false,\n'
            '  consumeOutsideTaps: true,\n'
            '  child: ContextMenuPanel(),\n'
            ')',
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4),
          child: Text(
            '6 Real-World Use Cases',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.78,
          ),
          itemCount: useCases.length,
          itemBuilder: (context, i) => _UseCaseCard(useCase: useCases[i]),
        ),
      ],
    );
  }
}

class _UseCase {
  const _UseCase({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.code,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final String code;
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({required this.useCase});

  final _UseCase useCase;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(useCase.icon, color: useCase.color, size: 28),
            const SizedBox(height: 8),
            Text(
              useCase.title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: useCase.color,
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                useCase.description,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cs.inverseSurface.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                useCase.code,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  fontSize: 9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 11 — API Cheat Sheet
// ─────────────────────────────────────────────────────────────────────────────

class _ApiCheatSheetTab extends StatelessWidget {
  const _ApiCheatSheetTab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SectionCard(
          title: 'TapRegion API Reference',
          subtitle: 'All constructor parameters and their roles.',
          child: Column(
            children: const [
              _PropRow('key', 'Widget identity key (optional)', highlight: false),
              _PropRow(
                'enabled',
                'bool — register with surface when true (default: true)',
                highlight: true,
              ),
              _PropRow(
                'behavior',
                'HitTestBehavior — local hit-test mode (default: deferToChild)',
              ),
              _PropRow(
                'groupId',
                'Object? — group key; null = independent region (default: null)',
                highlight: true,
              ),
              _PropRow(
                'onTapInside',
                'GestureTapCallback? — called when pointer-down hits inside',
              ),
              _PropRow(
                'onTapOutside',
                'GestureTapCallback? — called when pointer-down hits outside',
                highlight: true,
              ),
              _PropRow(
                'consumeOutsideTaps',
                'bool — absorb outside taps so siblings don\'t get them '
                    '(default: false)',
              ),
              _PropRow(
                'debugLabel',
                'String? — identifier shown in debug output',
                highlight: true,
              ),
              _PropRow('child', 'Widget? — child widget'),
            ],
          ),
        ),

        _SectionCard(
          title: 'RenderTapRegion Role',
          subtitle:
              'The RenderObject behind TapRegion.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RenderTapRegion is a RenderProxyBox subclass created by '
                'TapRegion.createRenderObject(). It is responsible for:',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              Column(
                children: const [
                  _PropRow(
                    'Registration',
                    'Calls registry.registerTapRegion(this) on attach',
                    highlight: true,
                  ),
                  _PropRow(
                    'Deregistration',
                    'Calls registry.unregisterTapRegion(this) on detach',
                  ),
                  _PropRow(
                    'Bounds query',
                    'Provides its paint bounds for inside/outside determination',
                    highlight: true,
                  ),
                  _PropRow(
                    'groupId storage',
                    'Holds the groupId for surface-side grouping logic',
                  ),
                  _PropRow(
                    'consumeOutsideTaps',
                    'Tells the surface whether to eat the event after routing',
                    highlight: true,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _CodeSnippet(
                '// Pseudo-code — RenderTapRegion\n'
                'class RenderTapRegion extends RenderProxyBoxWithHitTestBehavior\n'
                '    implements TapRegion {\n'
                '  Object? groupId;\n'
                '  bool consumeOutsideTaps;\n'
                '  TapRegionRegistry? _registry;\n'
                '\n'
                '  @override\n'
                '  void attach(PipelineOwner owner) {\n'
                '    super.attach(owner);\n'
                '    if (enabled) _registry?.registerTapRegion(this);\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  void detach() {\n'
                '    _registry?.unregisterTapRegion(this);\n'
                '    super.detach();\n'
                '  }\n'
                '}',
              ),
            ],
          ),
        ),

        _SectionCard(
          title: 'TapRegionRegistry Interface',
          subtitle: 'The contract TapRegionSurface implements.',
          child: _CodeSnippet(
            'abstract interface class TapRegionRegistry {\n'
            '  void registerTapRegion(TapRegion region);\n'
            '  void unregisterTapRegion(TapRegion region);\n'
            '\n'
            '  /// Retrieve the nearest ancestor registry.\n'
            '  static TapRegionRegistry? of(BuildContext context) { ... }\n'
            '}',
          ),
        ),

        _SectionCard(
          title: 'Quick Recipes',
          subtitle: 'Copy-paste patterns for common scenarios.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Soft-dismiss overlay',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              _CodeSnippet(
                'TapRegion(\n'
                '  onTapOutside: (_) => _visible.value = false,\n'
                '  child: MyOverlay(),\n'
                ')',
              ),
              const SizedBox(height: 12),
              Text(
                'Grouped field + panel (autocomplete)',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              _CodeSnippet(
                'const Object _g = #myGroup;\n'
                '\n'
                'TapRegion(groupId: _g, onTapOutside: close, child: Field())\n'
                'TapRegion(groupId: _g, onTapOutside: close, child: Panel())',
              ),
              const SizedBox(height: 12),
              Text(
                'Dismiss + block underlying tap',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              _CodeSnippet(
                'TapRegion(\n'
                '  onTapOutside: (_) => _close(),\n'
                '  consumeOutsideTaps: true,  // eat the tap\n'
                '  child: ContextMenu(),\n'
                ')',
              ),
              const SizedBox(height: 12),
              Text(
                'Conditionally active region',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              _CodeSnippet(
                'TapRegion(\n'
                '  enabled: _isOpen,  // only register when open\n'
                '  onTapOutside: (_) => _isOpen = false,\n'
                '  child: PopupPanel(),\n'
                ')',
              ),
            ],
          ),
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.primaryContainer.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.primary.withValues(alpha: 0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: cs.primary, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'TapRegion + TapRegionSurface is Flutter\'s built-in, '
                  'composable solution to the "dismiss on outside tap" problem. '
                  'Scaffold already provides a TapRegionSurface, so most '
                  'Material widgets (DropdownMenu, Autocomplete, MenuBar) work '
                  'out of the box without adding one manually.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: cs.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
