import 'package:flutter/material.dart';

/// Deep demo for TextSelectionGestureDetectorBuilder concepts.
///
/// This file is intentionally visual and educational. It demonstrates how a
/// builder-style abstraction can centralize gesture policy while still allowing
/// scene-specific customization.
void main() {
  runApp(const TextSelectionGestureDetectorBuilderDeepDemoApp());
}

class TextSelectionGestureDetectorBuilderDeepDemoApp extends StatelessWidget {
  const TextSelectionGestureDetectorBuilderDeepDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TextSelectionGestureDetectorBuilder Deep Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F6B3A)),
        useMaterial3: true,
      ),
      home: const TextSelectionGestureDetectorBuilderDeepDemoPage(),
    );
  }
}

class TextSelectionGestureDetectorBuilderDeepDemoPage extends StatefulWidget {
  const TextSelectionGestureDetectorBuilderDeepDemoPage({super.key});

  @override
  State<TextSelectionGestureDetectorBuilderDeepDemoPage> createState() =>
      _TextSelectionGestureDetectorBuilderDeepDemoPageState();
}

class _TextSelectionGestureDetectorBuilderDeepDemoPageState
    extends State<TextSelectionGestureDetectorBuilderDeepDemoPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);

  final ValueNotifier<GestureProfile> _profile = ValueNotifier<GestureProfile>(
    const GestureProfile(),
  );

  final ValueNotifier<GestureTimeline> _timeline = ValueNotifier<GestureTimeline>(
    const GestureTimeline.empty(),
  );

  final ScrollController _docScroll = ScrollController();
  final ScrollController _logScroll = ScrollController();

  @override
  void dispose() {
    _tabController.dispose();
    _profile.dispose();
    _timeline.dispose();
    _docScroll.dispose();
    _logScroll.dispose();
    super.dispose();
  }

  void _appendEvent(String event) {
    final updated = _timeline.value.push(event);
    _timeline.value = updated;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_logScroll.hasClients) {
        _logScroll.animateTo(
          _logScroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextSelectionGestureDetectorBuilder Deep Demo'),
        actions: [
          ValueListenableBuilder<GestureProfile>(
            valueListenable: _profile,
            builder: (context, profile, _) {
              return Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Center(
                  child: Chip(
                    label: Text(
                      profile.displayName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    avatar: Icon(profile.mode.icon, size: 18),
                  ),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Architecture'),
            Tab(text: 'Gesture Lab'),
            Tab(text: 'Policies'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.surface,
              colors.surfaceContainerLowest,
              colors.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _ArchitectureTab(
              profile: _profile,
              timeline: _timeline,
              onEvent: _appendEvent,
              scrollController: _docScroll,
            ),
            _GestureLabTab(
              profile: _profile,
              timeline: _timeline,
              onEvent: _appendEvent,
              docScroll: _docScroll,
              logScroll: _logScroll,
            ),
            _PolicyTab(profile: _profile, onEvent: _appendEvent),
          ],
        ),
      ),
    );
  }
}

class _ArchitectureTab extends StatelessWidget {
  const _ArchitectureTab({
    required this.profile,
    required this.timeline,
    required this.onEvent,
    required this.scrollController,
  });

  final ValueNotifier<GestureProfile> profile;
  final ValueNotifier<GestureTimeline> timeline;
  final ValueChanged<String> onEvent;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(20),
      children: [
        const _SectionHeader(
          title: 'Builder Responsibilities',
          subtitle:
              'A text-selection gesture builder coordinates gesture decoding, '
              'selection updates, and UI affordances through a narrow set of '
              'policy decisions.',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _ResponsibilityCard(
              title: 'Event Translation',
              icon: Icons.touch_app_outlined,
              bullets: [
                'Converts pointer events into semantic gestures.',
                'Decides tap/double-tap/long-press behavior per platform.',
                'Keeps recognizer glue away from text rendering code.',
              ],
            ),
            _ResponsibilityCard(
              title: 'Selection Actions',
              icon: Icons.select_all,
              bullets: [
                'Maps gestures to cursor movement and range updates.',
                'Applies policies such as drag granularity.',
                'Coordinates with selection handles and toolbar triggers.',
              ],
            ),
            _ResponsibilityCard(
              title: 'Integration Layer',
              icon: Icons.layers_outlined,
              bullets: [
                'Wraps editor widgets with a consistent detector shell.',
                'Injects diagnostics and analytics hooks centrally.',
                'Allows app-specific behavior without forking internals.',
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        _LiveTopologyPanel(profile: profile, timeline: timeline, onEvent: onEvent),
      ],
    );
  }
}

class _LiveTopologyPanel extends StatelessWidget {
  const _LiveTopologyPanel({
    required this.profile,
    required this.timeline,
    required this.onEvent,
  });

  final ValueNotifier<GestureProfile> profile;
  final ValueNotifier<GestureTimeline> timeline;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Live Topology',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'Switch profile presets and inspect how the virtual builder '
              'pipeline changes the active behavior graph.',
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<GestureProfile>(
              valueListenable: profile,
              builder: (context, value, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SegmentedButton<GestureMode>(
                      segments: GestureMode.values
                          .map(
                            (mode) => ButtonSegment<GestureMode>(
                              value: mode,
                              icon: Icon(mode.icon, size: 16),
                              label: Text(mode.label),
                            ),
                          )
                          .toList(),
                      selected: {value.mode},
                      onSelectionChanged: (selection) {
                        final selected = selection.first;
                        profile.value = value.copyWith(mode: selected);
                        onEvent('Profile switched to ${selected.label} mode');
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      value.mode.description,
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 14),
                    _BehaviorGraph(profile: value),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BehaviorGraph extends StatelessWidget {
  const _BehaviorGraph({required this.profile});

  final GestureProfile profile;

  @override
  Widget build(BuildContext context) {
    final stages = profile.activeStages;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final stage in stages)
          _GraphNode(
            title: stage.title,
            detail: stage.detail,
            intensity: stage.intensity,
          ),
      ],
    );
  }
}

class _GraphNode extends StatelessWidget {
  const _GraphNode({
    required this.title,
    required this.detail,
    required this.intensity,
  });

  final String title;
  final String detail;
  final double intensity;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tint = Color.lerp(
      scheme.primaryContainer,
      scheme.tertiaryContainer,
      intensity,
    )!;
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(detail),
        ],
      ),
    );
  }
}

class _GestureLabTab extends StatefulWidget {
  const _GestureLabTab({
    required this.profile,
    required this.timeline,
    required this.onEvent,
    required this.docScroll,
    required this.logScroll,
  });

  final ValueNotifier<GestureProfile> profile;
  final ValueNotifier<GestureTimeline> timeline;
  final ValueChanged<String> onEvent;
  final ScrollController docScroll;
  final ScrollController logScroll;

  @override
  State<_GestureLabTab> createState() => _GestureLabTabState();
}

class _GestureLabTabState extends State<_GestureLabTab> {
  final TextEditingController _editorController = TextEditingController(
    text: _demoArticle,
  );

  final ValueNotifier<SelectionSnapshot> _snapshot =
      ValueNotifier<SelectionSnapshot>(SelectionSnapshot.collapsed());

  bool _showHints = true;
  bool _enableDrag = true;
  bool _smartWordBoundary = true;

  @override
  void dispose() {
    _editorController.dispose();
    _snapshot.dispose();
    super.dispose();
  }

  void _logSelection(String source, TextSelection selection) {
    final text = _editorController.text;
    final selected = selection.textInside(text);
    final excerpt = selected.replaceAll('\n', ' ').trim();
    _snapshot.value = SelectionSnapshot(
      base: selection.baseOffset,
      extent: selection.extentOffset,
      length: selection.isValid ? selection.end - selection.start : 0,
      preview: excerpt.isEmpty ? '(caret only)' : excerpt,
    );
    widget.onEvent(
      '$source: base=${selection.baseOffset}, extent=${selection.extentOffset}, '
      'len=${selection.end - selection.start}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 1100;
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _buildEditorPanel(context)),
              SizedBox(
                width: 360,
                child: _buildInspectorPanel(context),
              ),
            ],
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildEditorPanel(context),
            const SizedBox(height: 14),
            _buildInspectorPanel(context),
          ],
        );
      },
    );
  }

  Widget _buildEditorPanel(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gesture Playground',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
            ),
            const SizedBox(height: 6),
            Text(
              'Interact with the editable text to observe gesture-to-selection '
              'translation under different detector policies.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            ValueListenableBuilder<GestureProfile>(
              valueListenable: widget.profile,
              builder: (context, profile, _) {
                return _BuilderShell(
                  profile: profile,
                  showHints: _showHints,
                  onTap: () => widget.onEvent('Tap detected by builder shell'),
                  onDoubleTap: () =>
                      widget.onEvent('Double tap detected by builder shell'),
                  onLongPress: () =>
                      widget.onEvent('Long press detected by builder shell'),
                  child: TextField(
                    controller: _editorController,
                    maxLines: 14,
                    minLines: 10,
                    style: const TextStyle(height: 1.45),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Try selecting words, lines, and paragraphs...',
                      helperText: _smartWordBoundary
                          ? 'Smart word boundary: on'
                          : 'Smart word boundary: off',
                    ),
                    onTap: () {
                      final selection = _editorController.selection;
                      _logSelection('tap selection', selection);
                    },
                    onChanged: (_) {
                      final selection = _editorController.selection;
                      _logSelection('text changed', selection);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                FilterChip(
                  selected: _showHints,
                  label: const Text('Overlay Hints'),
                  onSelected: (value) {
                    setState(() => _showHints = value);
                    widget.onEvent('Overlay hints ${value ? 'enabled' : 'disabled'}');
                  },
                ),
                FilterChip(
                  selected: _enableDrag,
                  label: const Text('Drag Select'),
                  onSelected: (value) {
                    setState(() => _enableDrag = value);
                    widget.onEvent('Drag select ${value ? 'enabled' : 'disabled'}');
                  },
                ),
                FilterChip(
                  selected: _smartWordBoundary,
                  label: const Text('Smart Word Boundary'),
                  onSelected: (value) {
                    setState(() => _smartWordBoundary = value);
                    widget.onEvent(
                      'Smart word boundary ${value ? 'enabled' : 'disabled'}',
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInspectorPanel(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 16, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inspector',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<SelectionSnapshot>(
              valueListenable: _snapshot,
              builder: (context, value, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MetricRow(label: 'Base', value: '${value.base}'),
                    _MetricRow(label: 'Extent', value: '${value.extent}'),
                    _MetricRow(label: 'Length', value: '${value.length}'),
                    const SizedBox(height: 8),
                    Text(
                      'Preview',
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(value.preview),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Gesture Timeline',
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder<GestureTimeline>(
                valueListenable: widget.timeline,
                builder: (context, value, _) {
                  final events = value.events;
                  return ListView.builder(
                    controller: widget.logScroll,
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 13,
                          child: Text('${index + 1}'),
                        ),
                        title: Text(event),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicyTab extends StatelessWidget {
  const _PolicyTab({required this.profile, required this.onEvent});

  final ValueNotifier<GestureProfile> profile;
  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    final cards = <PolicyRecipe>[
      PolicyRecipe(
        title: 'Desktop Precision Mode',
        summary:
            'Favor exact caret placement and conservative range expansion for '
            'mouse-driven workflows.',
        code: const [
          'builder.enableDrag = false;',
          'builder.wordBoundary = WordBoundary.precise;',
          'builder.longPressBehavior = LongPressBehavior.showMenu;',
        ],
        pros: const [
          'Predictable caret behavior for editors and IDE-like tools.',
          'Reduces accidental paragraph selection during quick clicks.',
        ],
        tradeOffs: const [
          'Less forgiving for touch-screen hybrids.',
        ],
      ),
      PolicyRecipe(
        title: 'Touch Discoverability Mode',
        summary:
            'Amplify long-press affordances and adaptive hit slop for dense '
            'mobile layouts.',
        code: const [
          'builder.hitSlop = const EdgeInsets.all(12);',
          'builder.enableMagnifier = true;',
          'builder.doubleTapWordSelection = true;',
        ],
        pros: const [
          'Improves selection success on small text and busy backgrounds.',
          'Better onboarding for non-expert users.',
        ],
        tradeOffs: const [
          'Can feel imprecise on large-screen desktop contexts.',
        ],
      ),
      PolicyRecipe(
        title: 'Observability Mode',
        summary:
            'Attach logging hooks around every gesture transition to support '
            'debugging and UX telemetry.',
        code: const [
          'builder.onGestureStart = telemetry.startSpan;',
          'builder.onSelectionChange = telemetry.recordSelection;',
          'builder.onGestureEnd = telemetry.closeSpan;',
        ],
        pros: const [
          'Makes regressions easier to isolate.',
          'Builds confidence during platform upgrades.',
        ],
        tradeOffs: const [
          'Requires log volume controls in production.',
        ],
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _SectionHeader(
          title: 'Policy Recipes',
          subtitle:
              'Recipes represent reusable builder configurations that can be '
              'applied per route, per editor, or per platform.',
        ),
        const SizedBox(height: 14),
        for (final recipe in cards)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _PolicyCard(
              recipe: recipe,
              onApply: () {
                final current = profile.value;
                profile.value = current.copyWith(
                  mode: switch (recipe.title) {
                    'Desktop Precision Mode' => GestureMode.desktop,
                    'Touch Discoverability Mode' => GestureMode.touch,
                    _ => GestureMode.observability,
                  },
                );
                onEvent('Applied ${recipe.title} profile');
              },
            ),
          ),
      ],
    );
  }
}

class _PolicyCard extends StatelessWidget {
  const _PolicyCard({required this.recipe, required this.onApply});

  final PolicyRecipe recipe;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    recipe.title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                  ),
                ),
                FilledButton.tonal(
                  onPressed: onApply,
                  child: const Text('Apply'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(recipe.summary),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: scheme.surfaceContainerHighest,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final line in recipe.code)
                    Text(
                      line,
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text('Strengths', style: TextStyle(color: scheme.primary)),
            for (final item in recipe.pros)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('• $item'),
              ),
            const SizedBox(height: 8),
            Text('Trade-offs', style: TextStyle(color: scheme.error)),
            for (final item in recipe.tradeOffs)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('• $item'),
              ),
          ],
        ),
      ),
    );
  }
}

class _BuilderShell extends StatelessWidget {
  const _BuilderShell({
    required this.profile,
    required this.showHints,
    required this.onTap,
    required this.onDoubleTap,
    required this.onLongPress,
    required this.child,
  });

  final GestureProfile profile;
  final bool showHints;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final VoidCallback onLongPress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          onDoubleTap: profile.mode == GestureMode.desktop ? null : onDoubleTap,
          onLongPress: profile.mode == GestureMode.desktop ? null : onLongPress,
          child: child,
        ),
        if (showHints)
          Positioned(
            right: 10,
            top: 10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Text(
                  profile.overlayHint,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
        ),
        const SizedBox(height: 6),
        Text(subtitle),
      ],
    );
  }
}

class _ResponsibilityCard extends StatelessWidget {
  const _ResponsibilityCard({
    required this.title,
    required this.icon,
    required this.bullets,
  });

  final String title;
  final IconData icon;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 260, maxWidth: 360),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: scheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              for (final bullet in bullets)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('• $bullet'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 76,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

@immutable
class GestureProfile {
  const GestureProfile({
    this.mode = GestureMode.balanced,
  });

  final GestureMode mode;

  String get displayName => mode.label;

  String get overlayHint => switch (mode) {
        GestureMode.desktop => 'Single-click precision mode',
        GestureMode.touch => 'Touch affordances optimized',
        GestureMode.observability => 'Telemetry hooks active',
        GestureMode.balanced => 'Balanced cross-platform behavior',
      };

  List<BehaviorStage> get activeStages => switch (mode) {
        GestureMode.desktop => const [
            BehaviorStage(
              title: 'Pointer Decoder',
              detail: 'Mouse-first, reduced long-press path.',
              intensity: 0.10,
            ),
            BehaviorStage(
              title: 'Selection Core',
              detail: 'Caret accuracy over broad range expansion.',
              intensity: 0.35,
            ),
            BehaviorStage(
              title: 'Toolbar Trigger',
              detail: 'Context menu appears on explicit action.',
              intensity: 0.58,
            ),
          ],
        GestureMode.touch => const [
            BehaviorStage(
              title: 'Pointer Decoder',
              detail: 'Adaptive hit slop and gesture buffering.',
              intensity: 0.22,
            ),
            BehaviorStage(
              title: 'Selection Core',
              detail: 'Word- and sentence-aware expansions.',
              intensity: 0.52,
            ),
            BehaviorStage(
              title: 'Toolbar Trigger',
              detail: 'Long-press prioritizes discoverability.',
              intensity: 0.80,
            ),
          ],
        GestureMode.observability => const [
            BehaviorStage(
              title: 'Pointer Decoder',
              detail: 'All transitions logged with timestamps.',
              intensity: 0.30,
            ),
            BehaviorStage(
              title: 'Selection Core',
              detail: 'Selection spans emit telemetry snapshots.',
              intensity: 0.62,
            ),
            BehaviorStage(
              title: 'Toolbar Trigger',
              detail: 'UI triggers include performance markers.',
              intensity: 0.90,
            ),
          ],
        GestureMode.balanced => const [
            BehaviorStage(
              title: 'Pointer Decoder',
              detail: 'Moderate gesture filtering.',
              intensity: 0.15,
            ),
            BehaviorStage(
              title: 'Selection Core',
              detail: 'Cross-platform default range behavior.',
              intensity: 0.42,
            ),
            BehaviorStage(
              title: 'Toolbar Trigger',
              detail: 'Platform-aware invocation strategy.',
              intensity: 0.68,
            ),
          ],
      };

  GestureProfile copyWith({GestureMode? mode}) {
    return GestureProfile(mode: mode ?? this.mode);
  }
}

enum GestureMode {
  balanced(
    label: 'Balanced',
    description: 'A compromise suitable for mixed desktop/touch experiences.',
    icon: Icons.tune,
  ),
  desktop(
    label: 'Desktop',
    description: 'Optimized for mouse precision and explicit context menus.',
    icon: Icons.mouse_outlined,
  ),
  touch(
    label: 'Touch',
    description: 'Optimized for finger gestures and long-press interactions.',
    icon: Icons.touch_app_outlined,
  ),
  observability(
    label: 'Observability',
    description: 'Adds telemetry hooks for every gesture transition.',
    icon: Icons.query_stats,
  );

  const GestureMode({
    required this.label,
    required this.description,
    required this.icon,
  });

  final String label;
  final String description;
  final IconData icon;
}

@immutable
class BehaviorStage {
  const BehaviorStage({
    required this.title,
    required this.detail,
    required this.intensity,
  });

  final String title;
  final String detail;
  final double intensity;
}

@immutable
class GestureTimeline {
  const GestureTimeline({required this.events});

  const GestureTimeline.empty() : events = const ['Timeline initialized'];

  final List<String> events;

  GestureTimeline push(String event) {
    final stamped = '[${DateTime.now().toIso8601String().substring(11, 19)}] $event';
    final next = [...events, stamped];
    if (next.length > 120) {
      return GestureTimeline(events: next.sublist(next.length - 120));
    }
    return GestureTimeline(events: next);
  }
}

@immutable
class SelectionSnapshot {
  const SelectionSnapshot({
    required this.base,
    required this.extent,
    required this.length,
    required this.preview,
  });

  const SelectionSnapshot.collapsed()
      : base = -1,
        extent = -1,
        length = 0,
        preview = '(no selection yet)';

  final int base;
  final int extent;
  final int length;
  final String preview;
}

@immutable
class PolicyRecipe {
  const PolicyRecipe({
    required this.title,
    required this.summary,
    required this.code,
    required this.pros,
    required this.tradeOffs,
  });

  final String title;
  final String summary;
  final List<String> code;
  final List<String> pros;
  final List<String> tradeOffs;
}

const String _demoArticle = '''Text selection is one of the smallest interactions that can carry surprising complexity.

In a polished editor, users expect a clear mental model:
- A tap places the caret.
- A double tap expands to a word.
- A long press exposes controls.

The TextSelectionGestureDetectorBuilder abstraction exists to keep that model consistent across widgets.

Instead of duplicating gesture recognizer wiring in every editable component, a builder can:
1) centralize pointer decoding;
2) encode platform behavior differences;
3) expose extension points for app-specific policy.

When teams scale their editor surfaces, this builder pattern reduces fragile copy-paste logic and gives product teams a safer place to tune behavior.''';
