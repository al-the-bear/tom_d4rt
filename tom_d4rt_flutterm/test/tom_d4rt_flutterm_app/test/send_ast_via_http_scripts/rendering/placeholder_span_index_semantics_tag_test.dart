import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _Zone {
  const _Zone({
    required this.id,
    required this.name,
    required this.description,
    required this.seed,
    required this.brightness,
  });

  final String id;
  final String name;
  final String description;
  final Color seed;
  final Brightness brightness;
}

class _Scenario {
  const _Scenario(this.id, this.title, this.description);

  final String id;
  final String title;
  final String description;
}

class _TagDescriptor {
  const _TagDescriptor({
    required this.index,
    required this.slot,
    required this.role,
    required this.note,
  });

  final int index;
  final String slot;
  final String role;
  final String note;
}

class _Faq {
  const _Faq(this.q, this.a);

  final String q;
  final String a;
}

class _Metric {
  const _Metric({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

const List<_Zone> _zones = [
  _Zone(
    id: 'editor',
    name: 'Editor Surface',
    description: 'Readable semantics overlays for inline placeholders in article/editor content.',
    seed: Color(0xFF0284C7),
    brightness: Brightness.light,
  ),
  _Zone(
    id: 'ops',
    name: 'Ops Surface',
    description: 'High-contrast semantics index diagnostics for fast accessibility QA.',
    seed: Color(0xFF0F172A),
    brightness: Brightness.dark,
  ),
  _Zone(
    id: 'lab',
    name: 'Lab Surface',
    description: 'Exploratory mode for grouping and reordering placeholder tags.',
    seed: Color(0xFF7C3AED),
    brightness: Brightness.dark,
  ),
  _Zone(
    id: 'review',
    name: 'Review Surface',
    description: 'Balanced mode for explaining PlaceholderSpanIndexSemanticsTag usage patterns.',
    seed: Color(0xFF059669),
    brightness: Brightness.light,
  ),
];

const List<_Scenario> _scenarios = [
  _Scenario('gallery', 'Inline Gallery', 'Compare multiple inline WidgetSpan layouts with explicit placeholder semantics tags.'),
  _Scenario('routing', 'Index Routing', 'Map placeholder indexes to semantic groups and ordered traversal intent.'),
  _Scenario('grouping', 'Tag Grouping', 'Demonstrate grouping, reindexing, and local role-based semantics lanes.'),
  _Scenario('integrated', 'Integrated Article', 'Embed tagged placeholders in realistic article blocks and controls.'),
];

const List<_TagDescriptor> _descriptors = [
  _TagDescriptor(index: 0, slot: 'headline-badge', role: 'badge', note: 'Status badge inserted near title line'),
  _TagDescriptor(index: 1, slot: 'summary-chip', role: 'chip', note: 'Summary chip used in section lead'),
  _TagDescriptor(index: 2, slot: 'metric-pill', role: 'metric', note: 'Key metric pill in body paragraph'),
  _TagDescriptor(index: 3, slot: 'note-box', role: 'note', note: 'Inline note icon/box for caution text'),
  _TagDescriptor(index: 4, slot: 'chart-token', role: 'chart', note: 'Mini chart placeholder in analysis section'),
  _TagDescriptor(index: 5, slot: 'avatar-inline', role: 'identity', note: 'Inline avatar marker for author reference'),
  _TagDescriptor(index: 6, slot: 'cta-segment', role: 'action', note: 'Call-to-action segment in footer sentence'),
  _TagDescriptor(index: 7, slot: 'quote-pin', role: 'quote', note: 'Quote marker placeholder for citations'),
];

const List<String> _guide = [
  'PlaceholderSpanIndexSemanticsTag is a SemanticsTag that represents a placeholder index in rich text semantics.',
  'Use it when WidgetSpan placeholders need explicit semantic indexing and stable traversal mapping.',
  'Attach tags through Semantics(tagForChildren: yourTag) around placeholder widgets.',
  'Index values should stay deterministic across rebuilds for consistent accessibility behavior.',
  'Build visual boards that make index movement and grouping changes observable.',
  'If placeholders are reordered, update displayed mapping and explain semantic implications.',
  'Use clear labels around placeholders so users understand purpose beyond decorative visuals.',
  'Demonstrate both compact inline placements and larger integrated article scenes.',
  'Keep diagnostics visible: index, tag name, and semantic slot role should be easy to inspect.',
  'Use realistic content patterns instead of API-only snippets for strong interpreter validation.',
];

const List<_Faq> _faq = [
  _Faq('What problem does PlaceholderSpanIndexSemanticsTag solve?', 'It identifies placeholder positions semantically so assistive tooling can reason about inline widget slots.'),
  _Faq('Where should tag instances be created?', 'Create stable tag instances in state or deterministic factories when indexes are dynamic.'),
  _Faq('Do tags replace normal semantics labels?', 'No. Tags augment structure; labels still provide human-readable meaning.'),
  _Faq('How should I test index updates?', 'Simulate reorder and grouping changes and verify mapped descriptors and visual timeline updates.'),
];

dynamic build(BuildContext context) {
  return const _PlaceholderSpanSemanticsStudio();
}

class _PlaceholderSpanSemanticsStudio extends StatefulWidget {
  const _PlaceholderSpanSemanticsStudio();

  @override
  State<_PlaceholderSpanSemanticsStudio> createState() => _PlaceholderSpanSemanticsStudioState();
}

class _PlaceholderSpanSemanticsStudioState extends State<_PlaceholderSpanSemanticsStudio> {
  int _zoneIndex = 0;
  int _scenarioIndex = 0;
  int _boardIndex = 0;

  bool _showDiagnostics = true;
  bool _dense = false;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showTagNames = true;
  bool _showRoleLegend = true;
  bool _compactCards = false;
  bool _autoPulse = false;
  bool _semanticsDebugMode = false;

  double _placeholderScale = 1.0;
  double _spacingScale = 1.0;
  double _noise = 0.35;

  int _tick = 0;
  int _reindexOps = 0;
  int _groupOps = 0;
  int _timelineEvents = 0;

  List<bool> _modeSelection = <bool>[true, false, false, false];
  List<bool> _routeSelection = <bool>[true, true, false, true, false, false];
  List<bool> _groupSelection = <bool>[true, false, true, false];
  List<bool> _articleSelection = <bool>[true, false, false];

  final List<int> _indexOrder = <int>[0, 1, 2, 3, 4, 5, 6, 7];
  final List<String> _timeline = <String>[];

  late final List<PlaceholderSpanIndexSemanticsTag> _tags;

  @override
  void initState() {
    super.initState();
    _tags = List<PlaceholderSpanIndexSemanticsTag>.generate(
      8,
      (i) => PlaceholderSpanIndexSemanticsTag(i),
    );
    _event('Placeholder semantics studio initialized.');
  }

  void _event(String text) {
    final now = DateTime.now();
    final stamp =
        '[${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';
    _timeline.insert(0, '$stamp $text');
    if (_timeline.length > 32) {
      _timeline.removeRange(32, _timeline.length);
    }
    _timelineEvents += 1;
  }

  void _reindexForward() {
    setState(() {
      final first = _indexOrder.removeAt(0);
      _indexOrder.add(first);
      _reindexOps += 1;
      _tick += 1;
      _event('Reindex forward operation applied.');
    });
  }

  void _reindexBackward() {
    setState(() {
      final last = _indexOrder.removeLast();
      _indexOrder.insert(0, last);
      _reindexOps += 1;
      _tick += 1;
      _event('Reindex backward operation applied.');
    });
  }

  void _shuffleGroups() {
    setState(() {
      _indexOrder.sort((a, b) => ((a + _tick) % 3).compareTo((b + _tick) % 3));
      _groupOps += 1;
      _tick += 1;
      _event('Group shuffle operation applied.');
    });
  }

  @override
  Widget build(BuildContext context) {
    final zone = _zones[_zoneIndex];
    final scenario = _scenarios[_scenarioIndex];

    final scheme = ColorScheme.fromSeed(seedColor: zone.seed, brightness: zone.brightness);
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      visualDensity: _dense ? VisualDensity.compact : VisualDensity.standard,
    );

    final metrics = _metrics();

    return Theme(
      data: theme,
      child: Container(
        color: theme.colorScheme.surface,
        child: Column(
          children: [
            _header(theme, zone, scenario),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _controls(theme),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 12, 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.surface,
                            theme.colorScheme.surfaceContainerHighest.withAlpha(165),
                            theme.colorScheme.surface,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
                      ),
                      child: _board(theme, scenario, metrics),
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

  List<_Metric> _metrics() {
    return [
      _Metric(label: 'Reindex Ops', value: '$_reindexOps', note: 'index order mutations', icon: Icons.swap_vert),
      _Metric(label: 'Group Ops', value: '$_groupOps', note: 'group reassignments', icon: Icons.group_work),
      _Metric(label: 'Timeline', value: '${_timeline.length}', note: 'captured interaction events', icon: Icons.timeline),
      _Metric(label: 'Tick', value: '$_tick', note: 'state progression counter', icon: Icons.av_timer),
    ];
  }

  Widget _header(ThemeData theme, _Zone zone, _Scenario scenario) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer.withAlpha(180),
            theme.colorScheme.secondaryContainer.withAlpha(150),
            theme.colorScheme.tertiaryContainer.withAlpha(130),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(140)),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
            ),
            child: CustomPaint(
              painter: _GlyphPainter(
                a: zone.seed,
                b: theme.colorScheme.tertiary,
                seed: _tick.toDouble(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PlaceholderSpanIndexSemanticsTag Studio', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(
                  'zone: ${zone.name}  scenario: ${scenario.title}  order: ${_indexOrder.join('→')}',
                  style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180), fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(zone.description, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(175))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _controls(ThemeData theme) {
    return Container(
      width: 390,
      margin: const EdgeInsets.fromLTRB(12, 10, 0, 12),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.surfaceContainerHighest.withAlpha(126),
            theme.colorScheme.surfaceContainer.withAlpha(98),
            theme.colorScheme.surfaceContainerLow.withAlpha(84),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Semantics Controls', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            const Text('Tune placeholder index behavior, grouping, and semantics diagnostics.'),
            const SizedBox(height: 10),
            _dropdownCard(
              label: 'Zone',
              value: _zoneIndex,
              options: _zones.map((e) => e.name).toList(),
              onChanged: (v) {
                setState(() {
                  _zoneIndex = v;
                  _tick += 1;
                  _event('Zone switched to ${_zones[v].name}.');
                });
              },
            ),
            _dropdownCard(
              label: 'Scenario',
              value: _scenarioIndex,
              options: _scenarios.map((e) => e.title).toList(),
              onChanged: (v) {
                setState(() {
                  _scenarioIndex = v;
                  _tick += 1;
                  _event('Scenario switched to ${_scenarios[v].title}.');
                });
              },
            ),
            _dropdownCard(
              label: 'Board',
              value: _boardIndex,
              options: List.generate(5, _boardTitle),
              onChanged: (v) {
                setState(() {
                  _boardIndex = v;
                  _tick += 1;
                  _event('Board switched to ${_boardTitle(v)}.');
                });
              },
            ),
            _switchCard(
              title: 'Diagnostics',
              subtitle: 'Show tag index, hash, and route details',
              value: _showDiagnostics,
              onChanged: (v) => setState(() => _showDiagnostics = v),
            ),
            _switchCard(
              title: 'Dense mode',
              subtitle: 'Compact spacing for crowded text samples',
              value: _dense,
              onChanged: (v) => setState(() => _dense = v),
            ),
            _switchCard(
              title: 'Show guide',
              subtitle: 'Display detailed semantics usage guidance',
              value: _showGuide,
              onChanged: (v) => setState(() => _showGuide = v),
            ),
            _switchCard(
              title: 'Show timeline',
              subtitle: 'Display event history for reindex/group operations',
              value: _showTimeline,
              onChanged: (v) => setState(() => _showTimeline = v),
            ),
            _switchCard(
              title: 'Show tag names',
              subtitle: 'Display tag.name values in diagnostics cards',
              value: _showTagNames,
              onChanged: (v) => setState(() => _showTagNames = v),
            ),
            _switchCard(
              title: 'Role legend',
              subtitle: 'Show role-based placeholder legend blocks',
              value: _showRoleLegend,
              onChanged: (v) => setState(() => _showRoleLegend = v),
            ),
            _switchCard(
              title: 'Compact cards',
              subtitle: 'Use tighter metric cards and inline panels',
              value: _compactCards,
              onChanged: (v) => setState(() => _compactCards = v),
            ),
            _switchCard(
              title: 'Auto pulse',
              subtitle: 'Emit timeline events automatically on index interactions',
              value: _autoPulse,
              onChanged: (v) => setState(() => _autoPulse = v),
            ),
            _switchCard(
              title: 'Semantics debug mode',
              subtitle: 'Highlight semantics wrappers around placeholders',
              value: _semanticsDebugMode,
              onChanged: (v) => setState(() => _semanticsDebugMode = v),
            ),
            _sliderCard(
              label: 'Placeholder scale',
              value: _placeholderScale,
              min: 0.7,
              max: 1.7,
              onChanged: (v) => setState(() => _placeholderScale = v),
            ),
            _sliderCard(
              label: 'Spacing scale',
              value: _spacingScale,
              min: 0.8,
              max: 1.7,
              onChanged: (v) => setState(() => _spacingScale = v),
            ),
            _sliderCard(
              label: 'Noise',
              value: _noise,
              min: 0.0,
              max: 1.0,
              onChanged: (v) => setState(() => _noise = v),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropdownCard({
    required String label,
    required int value,
    required List<String> options,
    required ValueChanged<int> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(130),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withAlpha(22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          DropdownButtonFormField<int>(
            initialValue: value,
            decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
            items: [
              for (var i = 0; i < options.length; i++) DropdownMenuItem<int>(value: i, child: Text(options[i])),
            ],
            onChanged: (v) {
              if (v != null) {
                onChanged(v);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _switchCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(130),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700))),
              Switch(value: value, onChanged: onChanged),
            ],
          ),
          Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.black.withAlpha(160))),
        ],
      ),
    );
  }

  Widget _sliderCard({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(130),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ${value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700)),
          Slider(value: value, min: min, max: max, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _board(ThemeData theme, _Scenario scenario, List<_Metric> metrics) {
    switch (_boardIndex) {
      case 0:
        return _galleryBoard(theme, scenario);
      case 1:
        return _routingBoard(theme);
      case 2:
        return _groupBoard(theme);
      case 3:
        return _integratedBoard(theme, scenario, metrics);
      default:
        return _guideBoard(theme, metrics);
    }
  }

  Widget _galleryBoard(ThemeData theme, _Scenario scenario) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Inline Gallery', scenario.description, 'gallery'),
          const SizedBox(height: 10),
          _card(
            theme,
            'WidgetSpan Samples',
            'Inline placeholders are wrapped with tagForChildren semantics using PlaceholderSpanIndexSemanticsTag.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _richSample(
                  theme: theme,
                  title: 'Article Lead',
                  body: 'This article highlights semantics for inline placeholders in rich text flows.',
                  indexes: const [0, 1, 2],
                ),
                SizedBox(height: 10 * _spacingScale),
                _richSample(
                  theme: theme,
                  title: 'Annotated Body',
                  body: 'Body content can embed badges, notes, and metrics while preserving semantic index meaning.',
                  indexes: const [3, 4, 5],
                ),
                SizedBox(height: 10 * _spacingScale),
                _richSample(
                  theme: theme,
                  title: 'Summary Footer',
                  body: 'Footer content may include quote and action placeholders for contextual actions.',
                  indexes: const [6, 7],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Mode Controls',
            'Switch rendering profile for inline placeholder density and emphasis.',
            ToggleButtons(
              isSelected: _modeSelection,
              onPressed: (i) {
                setState(() {
                  _modeSelection = _singleSelect(_modeSelection, i);
                  _tick += 1;
                  _event('Gallery mode changed: index $i.');
                });
                if (_autoPulse) {
                  _event('Auto pulse from gallery mode change.');
                }
              },
              children: const [
                _TagButton(icon: Icons.description, text: 'Article'),
                _TagButton(icon: Icons.analytics, text: 'Analytics'),
                _TagButton(icon: Icons.menu_book, text: 'Docs'),
                _TagButton(icon: Icons.dashboard, text: 'Dashboard'),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _diagnostics(theme, 'Gallery Diagnostics', [
              'tag count: ${_tags.length}',
              'index order: ${_indexOrder.join(', ')}',
              'placeholderScale: ${_placeholderScale.toStringAsFixed(2)}',
              'spacingScale: ${_spacingScale.toStringAsFixed(2)}',
              'semanticsDebugMode: $_semanticsDebugMode',
            ]),
          ],
        ],
      ),
    );
  }

  Widget _routingBoard(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Index Routing Matrix', 'Map index ordering to semantic slot roles and queue priorities.', 'routing'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Routing Controls',
            'Reindex operations mutate placeholder order and update routing cards.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  isSelected: _routeSelection,
                  onPressed: (i) {
                    setState(() {
                      _routeSelection = _toggle(_routeSelection, i);
                      _tick += 1;
                      _event('Routing flag toggled: index $i.');
                    });
                  },
                  children: const [
                    _TagButton(icon: Icons.filter_1, text: 'Lane A'),
                    _TagButton(icon: Icons.filter_2, text: 'Lane B'),
                    _TagButton(icon: Icons.filter_3, text: 'Lane C'),
                    _TagButton(icon: Icons.accessibility_new, text: 'A11y'),
                    _TagButton(icon: Icons.priority_high, text: 'Hot'),
                    _TagButton(icon: Icons.low_priority, text: 'Low'),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: _reindexForward,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Reindex forward'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _reindexBackward,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Reindex backward'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _shuffleGroups,
                      icon: const Icon(Icons.shuffle),
                      label: const Text('Shuffle groups'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Routing Table',
            'Each row binds current index order to role and semantic tag metadata.',
            Column(
              children: [
                for (var i = 0; i < _indexOrder.length; i++) _routingRow(theme, i, _indexOrder[i]),
              ],
            ),
          ),
          if (_showRoleLegend) ...[
            const SizedBox(height: 10),
            _card(
              theme,
              'Role Legend',
              'Role families used in this demo to illustrate semantics intent beyond index values.',
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _legendChip(theme, 'badge', Colors.blue),
                  _legendChip(theme, 'chip', Colors.teal),
                  _legendChip(theme, 'metric', Colors.orange),
                  _legendChip(theme, 'note', Colors.purple),
                  _legendChip(theme, 'chart', Colors.indigo),
                  _legendChip(theme, 'identity', Colors.green),
                  _legendChip(theme, 'action', Colors.red),
                  _legendChip(theme, 'quote', Colors.brown),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _routingRow(ThemeData theme, int lane, int index) {
    final d = _descriptors[index];
    final tag = _tags[index];
    final intensity = ((index + 1) / 8.0 * _spacingScale * (0.55 + _noise)).clamp(0.1, 1.0);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(120),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('L$lane', style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w700, fontSize: 11)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${d.slot} (${d.role})', style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text('index: ${d.index}  note: ${d.note}', style: TextStyle(fontSize: 12.5, color: Colors.black.withAlpha(170))),
                if (_showTagNames)
                  Text('tag.name: ${tag.name}  hash: ${tag.hashCode}', style: const TextStyle(fontSize: 11.5, fontFamily: 'monospace')),
              ],
            ),
          ),
          SizedBox(
            width: 82,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${(intensity * 100).round()}%'),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    value: intensity,
                    backgroundColor: theme.colorScheme.primary.withAlpha(40),
                    valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _groupBoard(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Tag Grouping Simulator', 'Group placeholders by role and semantic lanes while preserving index tags.', 'groups'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Grouping Controls',
            'Use toggles and actions to simulate grouping strategy shifts.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  isSelected: _groupSelection,
                  onPressed: (i) {
                    setState(() {
                      _groupSelection = _toggle(_groupSelection, i);
                      _tick += 1;
                      _event('Grouping toggle changed: index $i.');
                    });
                  },
                  children: const [
                    _TagButton(icon: Icons.category, text: 'Role'),
                    _TagButton(icon: Icons.numbers, text: 'Index'),
                    _TagButton(icon: Icons.alt_route, text: 'Lane'),
                    _TagButton(icon: Icons.auto_awesome, text: 'Auto'),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: _shuffleGroups,
                      icon: const Icon(Icons.shuffle),
                      label: const Text('Shuffle grouping'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _reindexForward,
                      icon: const Icon(Icons.keyboard_double_arrow_right),
                      label: const Text('Roll order'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _reindexBackward,
                      icon: const Icon(Icons.keyboard_double_arrow_left),
                      label: const Text('Rollback'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Grouped Cards',
            'Cards below represent grouped placeholder semantics slices.',
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (var i = 0; i < _indexOrder.length; i++) _groupCard(theme, _indexOrder[i]),
              ],
            ),
          ),
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _diagnostics(theme, 'Grouping Diagnostics', [
              'groupOps: $_groupOps',
              'reindexOps: $_reindexOps',
              'order: ${_indexOrder.join('→')}',
              'compactCards: $_compactCards',
              'semanticsDebugMode: $_semanticsDebugMode',
            ]),
          ],
        ],
      ),
    );
  }

  Widget _groupCard(ThemeData theme, int index) {
    final d = _descriptors[index];
    final tag = _tags[index];
    return SizedBox(
      width: _compactCards ? 218 : 246,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(_compactCards ? 10 : 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('index ${d.index}', style: TextStyle(color: theme.colorScheme.onPrimaryContainer, fontWeight: FontWeight.w700, fontSize: 11)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(d.role, style: const TextStyle(fontWeight: FontWeight.w700))),
                ],
              ),
              const SizedBox(height: 8),
              Text(d.slot, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(d.note, style: TextStyle(color: Colors.black.withAlpha(170))),
              const SizedBox(height: 8),
              Semantics(
                tagForChildren: tag,
                child: Container(
                  height: 36 * _placeholderScale,
                  decoration: BoxDecoration(
                    color: _semanticsDebugMode ? theme.colorScheme.secondaryContainer : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
                  ),
                  alignment: Alignment.center,
                  child: Text('placeholder ${d.index}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _integratedBoard(ThemeData theme, _Scenario scenario, List<_Metric> metrics) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Integrated Article Scene', scenario.description, 'scene'),
          const SizedBox(height: 10),
          _card(
            theme,
            'Article Controls',
            'Toggle integrated reading modes and trigger semantics-affecting changes.',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToggleButtons(
                  isSelected: _articleSelection,
                  onPressed: (i) {
                    setState(() {
                      _articleSelection = _singleSelect(_articleSelection, i);
                      _tick += 1;
                      _event('Article mode changed: index $i.');
                    });
                    if (_autoPulse) {
                      _event('Auto pulse from article mode change.');
                    }
                  },
                  children: const [
                    _TagButton(icon: Icons.visibility, text: 'Reader'),
                    _TagButton(icon: Icons.edit, text: 'Editor'),
                    _TagButton(icon: Icons.preview, text: 'Preview'),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: _reindexForward,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Apply index roll'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _shuffleGroups,
                      icon: const Icon(Icons.hub),
                      label: const Text('Re-map groups'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _card(
            theme,
            'Integrated RichText Article',
            'A realistic article block with inline placeholders tagged by PlaceholderSpanIndexSemanticsTag.',
            _integratedArticle(theme),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final m in metrics)
                SizedBox(
                  width: _compactCards ? 218 : 246,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(_compactCards ? 10 : 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(m.icon),
                              const SizedBox(width: 8),
                              Expanded(child: Text(m.label, style: const TextStyle(fontWeight: FontWeight.w700))),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(m.value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          Text(m.note),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _integratedArticle(ThemeData theme) {
    final t0 = _tags[_indexOrder[0]];
    final t1 = _tags[_indexOrder[1]];
    final t2 = _tags[_indexOrder[2]];
    final t3 = _tags[_indexOrder[3]];
    final t4 = _tags[_indexOrder[4]];
    final t5 = _tags[_indexOrder[5]];
    final t6 = _tags[_indexOrder[6]];
    final t7 = _tags[_indexOrder[7]];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(color: theme.colorScheme.onSurface, height: 1.55),
            children: [
              const TextSpan(text: 'Modern accessibility-friendly documents often embed inline widgets for status and context. '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Semantics(
                  tagForChildren: t0,
                  child: _inlineToken(theme, 'A', Colors.blue),
                ),
              ),
              const TextSpan(text: ' Using index-aware semantics tags helps assistive technology correlate placeholder positions. '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Semantics(
                  tagForChildren: t1,
                  child: _inlineToken(theme, 'B', Colors.teal),
                ),
              ),
              const TextSpan(text: ' When content reorders, stable tag descriptors keep navigation predictable.'),
            ],
          ),
        ),
        SizedBox(height: 10 * _spacingScale),
        RichText(
          text: TextSpan(
            style: TextStyle(color: theme.colorScheme.onSurface, height: 1.55),
            children: [
              const TextSpan(text: 'In analytics narratives, placeholders may represent metrics '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Semantics(tagForChildren: t2, child: _inlineToken(theme, 'C', Colors.orange)),
              ),
              const TextSpan(text: ', alerts '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Semantics(tagForChildren: t3, child: _inlineToken(theme, 'D', Colors.purple)),
              ),
              const TextSpan(text: ', and charts '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Semantics(tagForChildren: t4, child: _inlineToken(theme, 'E', Colors.indigo)),
              ),
              const TextSpan(text: '. Explicit index tags preserve this structure semantically.'),
            ],
          ),
        ),
        SizedBox(height: 10 * _spacingScale),
        RichText(
          text: TextSpan(
            style: TextStyle(color: theme.colorScheme.onSurface, height: 1.55),
            children: [
              const TextSpan(text: 'Author context can include inline identity markers '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Semantics(tagForChildren: t5, child: _inlineToken(theme, 'F', Colors.green)),
              ),
              const TextSpan(text: ', action callouts '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Semantics(tagForChildren: t6, child: _inlineToken(theme, 'G', Colors.red)),
              ),
              const TextSpan(text: ', and citations '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Semantics(tagForChildren: t7, child: _inlineToken(theme, 'H', Colors.brown)),
              ),
              const TextSpan(text: ', all while maintaining semantic map quality.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _inlineToken(ThemeData theme, String label, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3 * _spacingScale),
      padding: EdgeInsets.symmetric(horizontal: 7 * _placeholderScale, vertical: 3 * _placeholderScale),
      decoration: BoxDecoration(
        color: color.withAlpha(40),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(170)),
      ),
      child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
    );
  }

  Widget _guideBoard(ThemeData theme, List<_Metric> metrics) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section(theme, 'Guide + Timeline', 'How to use PlaceholderSpanIndexSemanticsTag in practical rich text flows.', 'guide'),
          if (_showGuide) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.tertiaryContainer.withAlpha(108),
                border: Border.all(color: theme.colorScheme.tertiary.withAlpha(120)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Usage Guide', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  for (final line in _guide) _bullet(theme, line),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.surfaceContainerHighest.withAlpha(122),
                border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('FAQ', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  for (final f in _faq)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(f.q, style: const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(f.a),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
          if (_showTimeline) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.primaryContainer.withAlpha(106),
                border: Border.all(color: theme.colorScheme.primary.withAlpha(130)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Timeline', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('events: ${_timeline.length}  |  tick: $_tick  |  timelineEvents: $_timelineEvents'),
                  const SizedBox(height: 8),
                  if (_timeline.isEmpty)
                    const Text('No events yet. Trigger index operations to populate this timeline.')
                  else
                    for (final e in _timeline)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(e, style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
                      ),
                ],
              ),
            ),
          ],
          if (_showDiagnostics) ...[
            const SizedBox(height: 10),
            _card(
              theme,
              'Metric Digest',
              'Summary of current semantics index activity and operations.',
              Column(
                children: [
                  for (final m in metrics)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Icon(m.icon, size: 18),
                          const SizedBox(width: 8),
                          Expanded(child: Text(m.label, style: const TextStyle(fontWeight: FontWeight.w700))),
                          Text(m.value),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _richSample({
    required ThemeData theme,
    required String title,
    required String body,
    required List<int> indexes,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(124),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              style: TextStyle(color: theme.colorScheme.onSurface, height: 1.48),
              children: [
                TextSpan(text: '$body '),
                for (final i in indexes) ...[
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Semantics(
                      tagForChildren: _tags[i],
                      child: _inlineToken(theme, String.fromCharCode(65 + i), Colors.primaries[i % Colors.primaries.length]),
                    ),
                  ),
                  const TextSpan(text: ' '),
                ],
                const TextSpan(text: 'These placeholders are explicitly tagged for semantic indexing.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendChip(ThemeData theme, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(36),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withAlpha(150)),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }

  Widget _section(ThemeData theme, String title, String subtitle, String chip) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(176))),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withAlpha(170),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(chip, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }

  Widget _card(ThemeData theme, String title, String subtitle, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surface.withAlpha(194),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(130)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: theme.colorScheme.onSurface.withAlpha(180))),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _diagnostics(ThemeData theme, String title, List<String> lines) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.primaryContainer.withAlpha(100),
        border: Border.all(color: theme.colorScheme.primary.withAlpha(130)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 8),
          for (final line in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(line, style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5)),
            ),
        ],
      ),
    );
  }

  Widget _bullet(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7, right: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  List<bool> _singleSelect(List<bool> values, int index) {
    final next = List<bool>.filled(values.length, false);
    next[index] = true;
    return next;
  }

  List<bool> _toggle(List<bool> values, int index) {
    final next = List<bool>.from(values);
    next[index] = !next[index];
    return next;
  }

  String _boardTitle(int i) {
    const titles = [
      'Inline Gallery',
      'Index Routing Matrix',
      'Tag Grouping Simulator',
      'Integrated Article Scene',
      'Guide + Timeline',
    ];
    return titles[i.clamp(0, titles.length - 1)];
  }
}

class _TagButton extends StatelessWidget {
  const _TagButton({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }
}

class _GlyphPainter extends CustomPainter {
  _GlyphPainter({required this.a, required this.b, required this.seed});

  final Color a;
  final Color b;
  final double seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed.toInt() + 57);
    final p = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      final w = size.width * (0.34 + rnd.nextDouble() * 0.58);
      final y = 8 + i * 8.1;
      p.color = Color.lerp(a, b, i / 5)?.withAlpha(220) ?? a;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(8, y, w, 5.2), const Radius.circular(4)),
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GlyphPainter oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b || oldDelegate.seed != seed;
  }
}
