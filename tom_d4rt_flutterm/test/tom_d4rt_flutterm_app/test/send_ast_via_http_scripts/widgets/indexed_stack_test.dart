import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

const _cNavy = Color(0xFF133651);
const _cBlue = Color(0xFF31729A);
const _cTeal = Color(0xFF2F8A78);
const _cAmber = Color(0xFFB98544);
const _cRose = Color(0xFF965D78);
const _cViolet = Color(0xFF605FA8);
const _cOlive = Color(0xFF737A42);

dynamic build(BuildContext context) {
  return const _IndexedStackDeepDemoApp();
}

class _IndexedStackDeepDemoApp extends StatelessWidget {
  const _IndexedStackDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cBlue),
        scaffoldBackgroundColor: const Color(0xFFF2F6FA),
      ),
      home: const _IndexedStackDeepDemoPage(),
    );
  }
}

class _IndexedStackDeepDemoPage extends StatefulWidget {
  const _IndexedStackDeepDemoPage();

  @override
  State<_IndexedStackDeepDemoPage> createState() => _IndexedStackDeepDemoPageState();
}

class _IndexedStackDeepDemoPageState extends State<_IndexedStackDeepDemoPage> {
  bool _compact = false;
  bool _showGrid = true;
  bool _showLabels = true;
  bool _rtl = false;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final config = _DemoConfig(
      compact: _compact,
      showGrid: _showGrid,
      showLabels: _showLabels,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      scale: _scale,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _cNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 84,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('IndexedStack Deep Demo'),
              const SizedBox(height: 2),
              Text(
                'Scale ${config.scale.toStringAsFixed(2)} | Direction ${config.textDirection == TextDirection.rtl ? 'RTL' : 'LTR'} | Focus: persistent child state',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopRibbon(
                compact: _compact,
                showGrid: _showGrid,
                showLabels: _showLabels,
                rtl: _rtl,
                scale: _scale,
                onCompactChanged: (v) => setState(() => _compact = v),
                onShowGridChanged: (v) => setState(() => _showGrid = v),
                onShowLabelsChanged: (v) => setState(() => _showLabels = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onScaleChanged: (v) => setState(() => _scale = v),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 1,
                accent: _cBlue,
                title: 'IndexedStack Fundamentals',
                subtitle:
                    'Visual explanation of how IndexedStack paints exactly one child by index while keeping all children alive in the tree.',
                child: _FundamentalScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 2,
                accent: _cTeal,
                title: 'Selection and Navigation Patterns',
                subtitle:
                    'Compares segmented controls, chips, sliders, and keyboard-style stepper controls driving the same IndexedStack content.',
                child: _SelectionPatternsScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 3,
                accent: _cAmber,
                title: 'Persistent Child State Lab',
                subtitle:
                    'Shows counters, form fields, toggles, and list selections surviving view switches because children are not rebuilt away.',
                child: _StatePersistenceScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 4,
                accent: _cRose,
                title: 'Background Activity Across Hidden Panels',
                subtitle:
                    'Demonstrates timers and streams continuing in non-visible panels to illustrate lifecycle implications of IndexedStack.',
                child: _BackgroundActivityScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 5,
                accent: _cViolet,
                title: 'Responsive and RTL Composition',
                subtitle:
                    'Builds adaptive layouts where IndexedStack drives panel mode while preserving local widget state under direction and size changes.',
                child: _ResponsiveRtlScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 6,
                accent: _cOlive,
                title: 'Practical Operations Workspace',
                subtitle:
                    'A realistic multi-view workspace (metrics, tasks, timeline, logs) implemented with IndexedStack for seamless mode switching.',
                child: _PracticalWorkspaceScene(config: config),
              ),
              const SizedBox(height: 12),
              const _RecapPanel(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoConfig {
  const _DemoConfig({
    required this.compact,
    required this.showGrid,
    required this.showLabels,
    required this.textDirection,
    required this.scale,
  });

  final bool compact;
  final bool showGrid;
  final bool showLabels;
  final TextDirection textDirection;
  final double scale;
}

class _TopRibbon extends StatelessWidget {
  const _TopRibbon({
    required this.compact,
    required this.showGrid,
    required this.showLabels,
    required this.rtl,
    required this.scale,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onShowLabelsChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool showGrid;
  final bool showLabels;
  final bool rtl;
  final double scale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<bool> onShowLabelsChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF173954), Color(0xFF2B6D84), Color(0xFF5A5DA3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'IndexedStack Control Deck',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 28),
            ),
            const SizedBox(height: 6),
            const Text(
              'Use IndexedStack when you need multiple panels to preserve local state while presenting only one panel at a time. This is ideal for tabs, workspaces, and mode-based dashboards.',
              style: TextStyle(color: Color(0xFFE6EFF9), height: 1.35),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: compact,
                    onChanged: onCompactChanged,
                    title: const Text('Compact', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: showGrid,
                    onChanged: onShowGridChanged,
                    title: const Text('Guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: showLabels,
                    onChanged: onShowLabelsChanged,
                    title: const Text('Labels', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: rtl,
                    onChanged: onRtlChanged,
                    title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Global scale: ${scale.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            Slider(
              value: scale,
              min: 0.75,
              max: 1.4,
              divisions: 13,
              label: scale.toStringAsFixed(2),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withValues(alpha: 0.35),
              onChanged: onScaleChanged,
            ),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _RibbonTag(label: 'single visible child'),
                _RibbonTag(label: 'state retention'),
                _RibbonTag(label: 'mode switching'),
                _RibbonTag(label: 'background activity'),
                _RibbonTag(label: 'dashboard composition'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RibbonTag extends StatelessWidget {
  const _RibbonTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({
    required this.index,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color accent;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 14, offset: const Offset(0, 6)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 18)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF2F4454), height: 1.34)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _FundamentalScene extends StatefulWidget {
  const _FundamentalScene({required this.config});

  final _DemoConfig config;

  @override
  State<_FundamentalScene> createState() => _FundamentalSceneState();
}

class _FundamentalSceneState extends State<_FundamentalScene> {
  int _index = 0;
  bool _showBounds = true;
  bool _showIndexBadge = true;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return SizedBox(
      height: config.compact ? 560 : 660,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Index controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(value: 0, label: Text('0')), 
                          ButtonSegment(value: 1, label: Text('1')), 
                          ButtonSegment(value: 2, label: Text('2')), 
                          ButtonSegment(value: 3, label: Text('3')),
                        ],
                        selected: {_index},
                        onSelectionChanged: (value) => setState(() => _index = value.first),
                      ),
                      const SizedBox(height: 8),
                      _LabeledSlider(
                        label: 'IndexedStack index',
                        value: _index.toDouble(),
                        min: 0,
                        max: 3,
                        divisions: 3,
                        onChanged: (v) => setState(() => _index = v.round()),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _showBounds,
                        onChanged: (v) => setState(() => _showBounds = v),
                        title: const Text('Show panel bounds'),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _showIndexBadge,
                        onChanged: (v) => setState(() => _showIndexBadge = v),
                        title: const Text('Show active index badge'),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _softBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Behavior essentials', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _BulletText(text: 'All children exist in the tree, but only one child is painted.'),
                            _BulletText(text: 'Switching index is instant and keeps hidden child states alive.'),
                            _BulletText(text: 'Parent size is determined by the largest child constraints.'),
                            _BulletText(text: 'Use this when tab contents must not reset on switch.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD8E2EE)),
                        ),
                        child: IndexedStack(
                          index: _index,
                          children: [
                            _fundamentalPanel(
                              title: 'Overview Panel',
                              color: _cBlue,
                              icon: Icons.grid_view_rounded,
                              note: 'High-level context and summary cards.',
                              showBounds: _showBounds,
                              scale: config.scale,
                            ),
                            _fundamentalPanel(
                              title: 'Analysis Panel',
                              color: _cTeal,
                              icon: Icons.analytics_rounded,
                              note: 'Chart-heavy details with focused metrics.',
                              showBounds: _showBounds,
                              scale: config.scale,
                            ),
                            _fundamentalPanel(
                              title: 'Timeline Panel',
                              color: _cAmber,
                              icon: Icons.timeline_rounded,
                              note: 'Sequence view with event progression.',
                              showBounds: _showBounds,
                              scale: config.scale,
                            ),
                            _fundamentalPanel(
                              title: 'Alerts Panel',
                              color: _cRose,
                              icon: Icons.notification_important_rounded,
                              note: 'Exception surfaces and anomaly routes.',
                              showBounds: _showBounds,
                              scale: config.scale,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_showIndexBadge)
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xCC1D2F3D),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'active index: $_index',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fundamentalPanel({
    required String title,
    required Color color,
    required IconData icon,
    required String note,
    required bool showBounds,
    required double scale,
  }) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withValues(alpha: 0.10),
        border: Border.all(color: showBounds ? color.withValues(alpha: 0.65) : color.withValues(alpha: 0.25), width: showBounds ? 2 : 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 22 * scale),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 18)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(note, style: const TextStyle(height: 1.3)),
            const SizedBox(height: 12),
            Expanded(
              child: Row(
                children: List<Widget>.generate(
                  3,
                  (i) => Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: i == 2 ? 0 : 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: color.withValues(alpha: 0.22)),
                      ),
                      child: Center(
                        child: Text(
                          'tile ${i + 1}',
                          style: TextStyle(color: color.withValues(alpha: 0.88), fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectionPatternsScene extends StatefulWidget {
  const _SelectionPatternsScene({required this.config});

  final _DemoConfig config;

  @override
  State<_SelectionPatternsScene> createState() => _SelectionPatternsSceneState();
}

class _SelectionPatternsSceneState extends State<_SelectionPatternsScene> {
  int _index = 0;
  bool _chipMode = true;
  bool _sliderMode = true;
  bool _stepButtons = true;
  final List<String> _events = <String>[];

  void _log(String event) {
    setState(() {
      _events.insert(0, '${_clock()} | $event');
      if (_events.length > 20) {
        _events.removeRange(20, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final labels = ['Console', 'Review', 'Deploy', 'Observe'];

    return SizedBox(
      height: config.compact ? 600 : 700,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Control modes', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _chipMode,
                        onChanged: (v) => setState(() => _chipMode = v),
                        title: const Text('Enable choice-chip control'),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _sliderMode,
                        onChanged: (v) => setState(() => _sliderMode = v),
                        title: const Text('Enable slider control'),
                      ),
                      SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _stepButtons,
                        onChanged: (v) => setState(() => _stepButtons = v),
                        title: const Text('Enable stepper buttons'),
                      ),
                      const SizedBox(height: 8),
                      if (_chipMode)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List<Widget>.generate(
                            labels.length,
                            (i) => ChoiceChip(
                              selected: _index == i,
                              label: Text(labels[i]),
                              onSelected: (_) {
                                setState(() => _index = i);
                                _log('chip -> index $i');
                              },
                            ),
                          ),
                        ),
                      if (_sliderMode) ...[
                        const SizedBox(height: 8),
                        _LabeledSlider(
                          label: 'Slider index',
                          value: _index.toDouble(),
                          min: 0,
                          max: 3,
                          divisions: 3,
                          onChanged: (v) {
                            setState(() => _index = v.round());
                            _log('slider -> index ${v.round()}');
                          },
                        ),
                      ],
                      if (_stepButtons) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _index > 0
                                    ? () {
                                        setState(() => _index -= 1);
                                        _log('step -1 -> $_index');
                                      }
                                    : null,
                                icon: const Icon(Icons.chevron_left_rounded),
                                label: const Text('Previous'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _index < 3
                                    ? () {
                                        setState(() => _index += 1);
                                        _log('step +1 -> $_index');
                                      }
                                    : null,
                                icon: const Icon(Icons.chevron_right_rounded),
                                label: const Text('Next'),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 8),
                      _EventPanel(title: 'Selection log', events: _events),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Unified IndexedStack output', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FBFF),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFD8E2EE)),
                        ),
                        child: IndexedStack(
                          index: _index,
                          children: [
                            _modePanel(_cBlue, 'Console Mode', Icons.terminal_rounded, 'Terminal-like panel with command snippets and output cards.'),
                            _modePanel(_cTeal, 'Review Mode', Icons.rate_review_rounded, 'Review board with checklist and annotation surfaces.'),
                            _modePanel(_cAmber, 'Deploy Mode', Icons.rocket_launch_rounded, 'Deployment deck with wave-progress indicators.'),
                            _modePanel(_cRose, 'Observe Mode', Icons.remove_red_eye_rounded, 'Monitoring panel for incident and health streams.'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Current mode: ${labels[_index]} (index $_index)',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modePanel(Color color, String title, IconData icon, String note) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.11),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 18)),
              ],
            ),
            const SizedBox(height: 8),
            Text(note, style: const TextStyle(height: 1.3)),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.25,
                children: List<Widget>.generate(
                  4,
                  (i) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: color.withValues(alpha: 0.2)),
                    ),
                    child: Center(
                      child: Text(
                        'module ${i + 1}',
                        style: TextStyle(color: color.withValues(alpha: 0.85), fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatePersistenceScene extends StatefulWidget {
  const _StatePersistenceScene({required this.config});

  final _DemoConfig config;

  @override
  State<_StatePersistenceScene> createState() => _StatePersistenceSceneState();
}

class _StatePersistenceSceneState extends State<_StatePersistenceScene> {
  int _index = 0;
  late final List<_PersistencePane> _panes;
  final List<String> _events = <String>[];

  @override
  void initState() {
    super.initState();
    _panes = [
      _PersistencePane(id: 'A', tone: _cBlue, title: 'Form Draft', onEvent: _push),
      _PersistencePane(id: 'B', tone: _cTeal, title: 'Checklist Board', onEvent: _push),
      _PersistencePane(id: 'C', tone: _cAmber, title: 'Counter Deck', onEvent: _push),
      _PersistencePane(id: 'D', tone: _cRose, title: 'Filter Matrix', onEvent: _push),
    ];
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      if (_events.length > 28) {
        _events.removeRange(28, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return SizedBox(
      height: config.compact ? 660 : 790,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Persistence controller', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        _panes.length,
                        (i) => ChoiceChip(
                          selected: _index == i,
                          label: Text('Pane ${i + 1}'),
                          onSelected: (_) {
                            setState(() => _index = i);
                            _push('select pane $i');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _LabeledSlider(
                      label: 'Active pane index',
                      value: _index.toDouble(),
                      min: 0,
                      max: (_panes.length - 1).toDouble(),
                      divisions: _panes.length - 1,
                      onChanged: (v) {
                        setState(() => _index = v.round());
                        _push('slider pane ${v.round()}');
                      },
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _softBox(),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('What to verify', style: TextStyle(fontWeight: FontWeight.w800)),
                          SizedBox(height: 6),
                          _BulletText(text: 'Edit text in one pane, switch away, then return: text remains.'),
                          _BulletText(text: 'Toggle switches and counters remain unchanged across index switches.'),
                          _BulletText(text: 'Scroll positions are retained when each pane owns a controller.'),
                          _BulletText(text: 'No reset unless parent rebuild replaces children instances.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(child: _EventPanel(title: 'Persistence events', events: _events)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IndexedStack(index: _index, children: _panes),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersistencePane extends StatefulWidget {
  const _PersistencePane({
    required this.id,
    required this.tone,
    required this.title,
    required this.onEvent,
  });

  final String id;
  final Color tone;
  final String title;
  final ValueChanged<String> onEvent;

  @override
  State<_PersistencePane> createState() => _PersistencePaneState();
}

class _PersistencePaneState extends State<_PersistencePane> {
  late final TextEditingController _controller;
  late final ScrollController _scroll;
  int _count = 0;
  bool _enabled = false;
  final Set<int> _selected = <int>{};

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'Draft for pane ${widget.id}');
    _scroll = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.layers_rounded, color: widget.tone),
              const SizedBox(width: 8),
              Expanded(
                child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800, fontSize: 18)),
              ),
              Text('count: $_count', style: TextStyle(color: widget.tone, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            onChanged: (value) => widget.onEvent('pane ${widget.id} text updated (${value.length} chars)'),
            decoration: const InputDecoration(
              labelText: 'Persistent text field',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () {
                    setState(() => _count += 1);
                    widget.onEvent('pane ${widget.id} counter $_count');
                  },
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  label: const Text('Increment'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() => _count = 0);
                    widget.onEvent('pane ${widget.id} counter reset');
                  },
                  icon: const Icon(Icons.restart_alt_rounded),
                  label: const Text('Reset'),
                ),
              ),
            ],
          ),
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            value: _enabled,
            onChanged: (v) {
              setState(() => _enabled = v);
              widget.onEvent('pane ${widget.id} switch = $v');
            },
            title: const Text('Pane-specific toggle'),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: widget.tone.withValues(alpha: 0.22)),
              ),
              child: ListView.builder(
                controller: _scroll,
                itemCount: 16,
                itemBuilder: (context, index) {
                  final selected = _selected.contains(index);
                  return ListTile(
                    dense: true,
                    title: Text('Item ${index + 1}'),
                    subtitle: Text('selection in pane ${widget.id}'),
                    trailing: Icon(selected ? Icons.check_circle : Icons.circle_outlined, color: selected ? widget.tone : null),
                    onTap: () {
                      setState(() {
                        if (selected) {
                          _selected.remove(index);
                        } else {
                          _selected.add(index);
                        }
                      });
                      widget.onEvent('pane ${widget.id} item ${index + 1} -> ${!selected}');
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundActivityScene extends StatefulWidget {
  const _BackgroundActivityScene({required this.config});

  final _DemoConfig config;

  @override
  State<_BackgroundActivityScene> createState() => _BackgroundActivitySceneState();
}

class _BackgroundActivitySceneState extends State<_BackgroundActivityScene> {
  int _index = 0;
  bool _paused = false;
  late final List<_TickerPane> _panes;

  @override
  void initState() {
    super.initState();
    _panes = [
      _TickerPane(title: 'CPU Feed', tone: _cBlue, seed: 1, paused: () => _paused),
      _TickerPane(title: 'Queue Feed', tone: _cTeal, seed: 2, paused: () => _paused),
      _TickerPane(title: 'Traffic Feed', tone: _cAmber, seed: 3, paused: () => _paused),
      _TickerPane(title: 'Error Feed', tone: _cRose, seed: 4, paused: () => _paused),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return SizedBox(
      height: config.compact ? 640 : 760,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Background activity controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 0, label: Text('CPU')),
                        ButtonSegment(value: 1, label: Text('Queue')),
                        ButtonSegment(value: 2, label: Text('Traffic')),
                        ButtonSegment(value: 3, label: Text('Error')),
                      ],
                      selected: {_index},
                      onSelectionChanged: (v) => setState(() => _index = v.first),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _paused,
                      onChanged: (v) => setState(() => _paused = v),
                      title: const Text('Pause all feeds'),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _softBox(),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lifecycle note', style: TextStyle(fontWeight: FontWeight.w800)),
                          SizedBox(height: 6),
                          _BulletText(text: 'IndexedStack keeps hidden children mounted.'),
                          _BulletText(text: 'Timers inside hidden children keep running unless manually paused.'),
                          _BulletText(text: 'This is powerful for continuity but has memory/cpu tradeoffs.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Try switching between tabs and observe counters continue.', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IndexedStack(index: _index, children: _panes),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TickerPane extends StatefulWidget {
  const _TickerPane({
    required this.title,
    required this.tone,
    required this.seed,
    required this.paused,
  });

  final String title;
  final Color tone;
  final int seed;
  final bool Function() paused;

  @override
  State<_TickerPane> createState() => _TickerPaneState();
}

class _TickerPaneState extends State<_TickerPane> {
  late final Timer _timer;
  late final math.Random _rnd;
  final List<double> _values = <double>[];
  int _tick = 0;

  @override
  void initState() {
    super.initState();
    _rnd = math.Random(widget.seed);
    _values.addAll(List<double>.generate(20, (_) => 30 + _rnd.nextDouble() * 50));
    _timer = Timer.periodic(const Duration(milliseconds: 600), (_) {
      if (!mounted || widget.paused()) {
        return;
      }
      setState(() {
        _tick += 1;
        _values.removeAt(0);
        _values.add(20 + _rnd.nextDouble() * 70);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.graphic_eq_rounded, color: widget.tone),
              const SizedBox(width: 8),
              Expanded(
                child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800, fontSize: 18)),
              ),
              Text('tick $_tick', style: TextStyle(color: widget.tone, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: CustomPaint(
              painter: _SparkPainter(values: _values, color: widget.tone),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _StatChip(label: 'min', value: _values.reduce(math.min).toStringAsFixed(1), color: widget.tone),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StatChip(label: 'max', value: _values.reduce(math.max).toStringAsFixed(1), color: widget.tone),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StatChip(label: 'avg', value: (_values.reduce((a, b) => a + b) / _values.length).toStringAsFixed(1), color: widget.tone),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SparkPainter extends CustomPainter {
  const _SparkPainter({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) {
      return;
    }

    final line = Paint()
      ..color = color
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fill = Paint()
      ..color = color.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    final maxValue = values.reduce(math.max);
    final minValue = values.reduce(math.min);
    final span = (maxValue - minValue).abs() < 0.001 ? 1.0 : (maxValue - minValue);

    final path = Path();
    final area = Path();

    for (int i = 0; i < values.length; i++) {
      final x = (i / (values.length - 1)) * size.width;
      final normalized = (values[i] - minValue) / span;
      final y = size.height - (normalized * (size.height - 8)) - 4;
      if (i == 0) {
        path.moveTo(x, y);
        area.moveTo(x, size.height);
        area.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        area.lineTo(x, y);
      }
    }
    area.lineTo(size.width, size.height);
    area.close();

    canvas.drawPath(area, fill);
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant _SparkPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.color != color;
  }
}

class _ResponsiveRtlScene extends StatefulWidget {
  const _ResponsiveRtlScene({required this.config});

  final _DemoConfig config;

  @override
  State<_ResponsiveRtlScene> createState() => _ResponsiveRtlSceneState();
}

class _ResponsiveRtlSceneState extends State<_ResponsiveRtlScene> {
  int _index = 0;
  bool _wide = true;
  bool _dense = false;
  bool _showHints = true;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final width = _wide ? 860.0 : 560.0;

    return SizedBox(
      height: config.compact ? 640 : 760,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Responsive controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 0, label: Text('Summary')),
                        ButtonSegment(value: 1, label: Text('Detail')),
                        ButtonSegment(value: 2, label: Text('Config')),
                      ],
                      selected: {_index},
                      onSelectionChanged: (v) => setState(() => _index = v.first),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _wide,
                      onChanged: (v) => setState(() => _wide = v),
                      title: const Text('Wide container mode'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _dense,
                      onChanged: (v) => setState(() => _dense = v),
                      title: const Text('Dense tile mode'),
                    ),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _showHints,
                      onChanged: (v) => setState(() => _showHints = v),
                      title: const Text('Show direction and size hints'),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _softBox(),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Composition advice', style: TextStyle(fontWeight: FontWeight.w800)),
                          SizedBox(height: 6),
                          _BulletText(text: 'IndexedStack works well with responsive wrappers and breakpoints.'),
                          _BulletText(text: 'RTL changes are naturally reflected by surrounding Directionality.'),
                          _BulletText(text: 'Keep child state local to each view and avoid re-creating children lists.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    width: width,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FBFF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFD8E2EE)),
                    ),
                    child: Column(
                      children: [
                        if (_showHints)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEAF1F8),
                              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            ),
                            child: Text(
                              'container ${_wide ? 'wide' : 'narrow'} | direction ${widget.config.textDirection == TextDirection.rtl ? 'rtl' : 'ltr'} | active view $_index',
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                            ),
                          ),
                        Expanded(
                          child: IndexedStack(
                            index: _index,
                            children: [
                              _adaptivePane(_cBlue, 'Summary', _dense, _wide),
                              _adaptivePane(_cTeal, 'Detail', _dense, _wide),
                              _adaptivePane(_cViolet, 'Config', _dense, _wide),
                            ],
                          ),
                        ),
                      ],
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

  Widget _adaptivePane(Color tone, String title, bool dense, bool wide) {
    final crossAxisCount = wide ? (dense ? 4 : 3) : (dense ? 2 : 1);
    final cardCount = wide ? 9 : 5;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: tone.withValues(alpha: 0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title View', style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: dense ? 1.35 : 1.0,
                children: List<Widget>.generate(
                  cardCount,
                  (i) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: tone.withValues(alpha: 0.22)),
                    ),
                    child: Center(
                      child: Text(
                        '$title ${i + 1}',
                        style: TextStyle(color: tone.withValues(alpha: 0.85), fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PracticalWorkspaceScene extends StatefulWidget {
  const _PracticalWorkspaceScene({required this.config});

  final _DemoConfig config;

  @override
  State<_PracticalWorkspaceScene> createState() => _PracticalWorkspaceSceneState();
}

class _PracticalWorkspaceSceneState extends State<_PracticalWorkspaceScene> {
  int _index = 0;
  bool _compactRail = false;
  bool _highContrast = false;
  bool _showMeta = true;
  final List<String> _events = <String>[];

  late final List<Widget> _views;

  @override
  void initState() {
    super.initState();
    _views = [
      _MetricsView(onEvent: _push),
      _TasksView(onEvent: _push),
      _TimelineView(onEvent: _push),
      _LogsView(onEvent: _push),
    ];
  }

  void _push(String event) {
    setState(() {
      _events.insert(0, '${_clock()} | $event');
      if (_events.length > 30) {
        _events.removeRange(30, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final labels = ['Metrics', 'Tasks', 'Timeline', 'Logs'];

    return SizedBox(
      height: config.compact ? 820 : 980,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _BackdropPanel(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        labels.length,
                        (i) => ChoiceChip(
                          selected: _index == i,
                          label: Text(labels[i]),
                          onSelected: (_) {
                            setState(() => _index = i);
                            _push('workspace view -> ${labels[i]}');
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          selected: _compactRail,
                          label: const Text('Compact rail'),
                          onSelected: (v) => setState(() => _compactRail = v),
                        ),
                        FilterChip(
                          selected: _highContrast,
                          label: const Text('High contrast'),
                          onSelected: (v) => setState(() => _highContrast = v),
                        ),
                        FilterChip(
                          selected: _showMeta,
                          label: const Text('Show metadata strip'),
                          onSelected: (v) => setState(() => _showMeta = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _highContrast ? const Color(0xFF1D2831) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD8E2EE)),
                        ),
                        child: Column(
                          children: [
                            _workspaceTopBar(_highContrast),
                            Expanded(
                              child: Row(
                                children: [
                                  _workspaceRail(_compactRail, _highContrast, labels),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        if (_showMeta) _workspaceMeta(_highContrast, labels[_index]),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: IndexedStack(index: _index, children: _views),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _workspaceFooter(_highContrast),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _EventPanel(title: 'Workspace events', events: _events),
          ),
        ],
      ),
    );
  }

  Widget _workspaceTopBar(bool highContrast) {
    final textColor = highContrast ? Colors.white : _cNavy;
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _cOlive.withValues(alpha: highContrast ? 0.22 : 0.12),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          const Icon(Icons.dashboard_customize_rounded, color: _cOlive),
          const SizedBox(width: 8),
          Text('Ops Workspace', style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 18)),
          const Spacer(),
          Text('IndexedStack mode switching', style: TextStyle(color: textColor.withValues(alpha: 0.85), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _workspaceRail(bool compact, bool highContrast, List<String> labels) {
    final textColor = highContrast ? Colors.white : _cNavy;
    return Container(
      width: compact ? 72 : 108,
      decoration: BoxDecoration(
        color: highContrast ? const Color(0xFF24313A) : const Color(0xFFF8FBFF),
        border: const Border(right: BorderSide(color: Color(0xFFD8E2EE))),
      ),
      child: ListView.builder(
        itemCount: labels.length,
        itemBuilder: (context, index) {
          final selected = _index == index;
          return InkWell(
            onTap: () {
              setState(() => _index = index);
              _push('rail -> ${labels[index]}');
            },
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              decoration: BoxDecoration(
                color: selected ? _cOlive.withValues(alpha: 0.22) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: selected ? _cOlive.withValues(alpha: 0.45) : Colors.transparent),
              ),
              child: Column(
                children: [
                  Icon(_workspaceIcons[index], color: selected ? _cOlive : textColor.withValues(alpha: 0.8), size: compact ? 18 : 20),
                  if (!compact) ...[
                    const SizedBox(height: 3),
                    Text(labels[index], style: TextStyle(color: textColor, fontSize: 10), textAlign: TextAlign.center),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _workspaceMeta(bool highContrast, String activeLabel) {
    final textColor = highContrast ? Colors.white : _cNavy;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: highContrast ? const Color(0xFF22313E) : const Color(0xFFEAF2FA),
        border: const Border(bottom: BorderSide(color: Color(0xFFD8E2EE))),
      ),
      child: Row(
        children: [
          Text('active: $activeLabel', style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('children preserved across view switches', style: TextStyle(color: textColor.withValues(alpha: 0.82), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _workspaceFooter(bool highContrast) {
    final textColor = highContrast ? Colors.white : _cNavy;
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: highContrast ? const Color(0xFF22313E) : const Color(0xFFF8FAFD),
        border: const Border(top: BorderSide(color: Color(0xFFD8E2EE))),
      ),
      child: Row(
        children: [
          Text('Workspace footer', style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 12)),
          const Spacer(),
          Text('Index: $_index', style: TextStyle(color: textColor.withValues(alpha: 0.82), fontSize: 12)),
        ],
      ),
    );
  }
}

const _workspaceIcons = <IconData>[
  Icons.dashboard_rounded,
  Icons.task_alt_rounded,
  Icons.timeline_rounded,
  Icons.receipt_long_rounded,
];

class _MetricsView extends StatefulWidget {
  const _MetricsView({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  State<_MetricsView> createState() => _MetricsViewState();
}

class _MetricsViewState extends State<_MetricsView> {
  double _load = 0.55;
  double _latency = 148;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _cBlue.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cBlue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Metrics View', style: TextStyle(color: _cBlue, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          _LabeledSlider(
            label: 'System load',
            value: _load,
            min: 0,
            max: 1,
            onChanged: (v) {
              setState(() => _load = v);
              widget.onEvent('metrics load ${v.toStringAsFixed(2)}');
            },
          ),
          _LabeledSlider(
            label: 'Latency (ms)',
            value: _latency,
            min: 80,
            max: 280,
            onChanged: (v) {
              setState(() => _latency = v);
              widget.onEvent('metrics latency ${v.toStringAsFixed(1)}ms');
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _MetricCard(title: 'Load', value: '${(_load * 100).toStringAsFixed(1)}%')),
                const SizedBox(width: 8),
                Expanded(child: _MetricCard(title: 'Latency', value: '${_latency.toStringAsFixed(1)}ms')),
                const SizedBox(width: 8),
                Expanded(child: _MetricCard(title: 'Errors', value: '${(3 + (_load * 12)).round()}')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TasksView extends StatefulWidget {
  const _TasksView({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  State<_TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<_TasksView> {
  final List<_TaskItem> _tasks = List<_TaskItem>.generate(
    12,
    (i) => _TaskItem(title: 'Task ${i + 1}', done: i.isEven && i % 3 == 0),
  );

  @override
  Widget build(BuildContext context) {
    final completed = _tasks.where((t) => t.done).length;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _cTeal.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cTeal.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tasks View ($completed/${_tasks.length})', style: const TextStyle(color: _cTeal, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return CheckboxListTile(
                  value: task.done,
                  onChanged: (v) {
                    setState(() => task.done = v ?? false);
                    widget.onEvent('task ${task.title} -> ${task.done}');
                  },
                  title: Text(task.title),
                  subtitle: Text(task.done ? 'Completed' : 'Pending'),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskItem {
  _TaskItem({required this.title, required this.done});

  final String title;
  bool done;
}

class _TimelineView extends StatefulWidget {
  const _TimelineView({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  State<_TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<_TimelineView> {
  double _progress = 0.35;
  bool _showMilestones = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _cAmber.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cAmber.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Timeline View', style: TextStyle(color: _cAmber, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          _LabeledSlider(
            label: 'Program progress',
            value: _progress,
            min: 0,
            max: 1,
            onChanged: (v) {
              setState(() => _progress = v);
              widget.onEvent('timeline progress ${(_progress * 100).toStringAsFixed(1)}%');
            },
          ),
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            value: _showMilestones,
            onChanged: (v) {
              setState(() => _showMilestones = v);
              widget.onEvent('timeline milestones = $v');
            },
            title: const Text('Show milestone markers'),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: CustomPaint(
              painter: _TimelinePainter(progress: _progress, showMilestones: _showMilestones),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelinePainter extends CustomPainter {
  const _TimelinePainter({required this.progress, required this.showMilestones});

  final double progress;
  final bool showMilestones;

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = const Color(0xFFCAD7E3)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final fill = Paint()
      ..color = _cAmber
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final y = size.height * 0.5;
    canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), line);
    canvas.drawLine(Offset(20, y), Offset(20 + (size.width - 40) * progress, y), fill);

    if (showMilestones) {
      for (int i = 0; i <= 4; i++) {
        final x = 20 + ((size.width - 40) * (i / 4));
        canvas.drawCircle(Offset(x, y), 6, Paint()..color = i / 4 <= progress ? _cAmber : const Color(0xFF9FB1C2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.showMilestones != showMilestones;
  }
}

class _LogsView extends StatefulWidget {
  const _LogsView({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  State<_LogsView> createState() => _LogsViewState();
}

class _LogsViewState extends State<_LogsView> {
  late final ScrollController _scroll;
  final List<String> _lines = List<String>.generate(30, (i) => 'line ${i + 1}: initialized module-${(i % 5) + 1}');

  @override
  void initState() {
    super.initState();
    _scroll = ScrollController();
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _cRose.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cRose.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Logs View', style: TextStyle(color: _cRose, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          Row(
            children: [
              FilledButton.tonal(
                onPressed: () {
                  setState(() => _lines.add('line ${_lines.length + 1}: event captured at ${_clock()}'));
                  widget.onEvent('log appended');
                },
                child: const Text('Append log'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {
                  if (_lines.isNotEmpty) {
                    setState(() => _lines.removeLast());
                    widget.onEvent('log removed');
                  }
                },
                child: const Text('Remove last'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1C2731),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                controller: _scroll,
                itemCount: _lines.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      _lines[index],
                      style: TextStyle(
                        color: index.isEven ? const Color(0xFFB8CBDC) : const Color(0xFF88B9E4),
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
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD7E2EE)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: _cBlue)),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _BackdropPanel extends StatelessWidget {
  const _BackdropPanel({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD7E2EE)),
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FCFF), Color(0xFFEDF3FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid) const CustomPaint(painter: _GridPainter()),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x11000000);
    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged),
      ],
    );
  }
}

class _EventPanel extends StatelessWidget {
  const _EventPanel({required this.title, required this.events});

  final String title;
  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFDFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E2EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No interactions yet.', style: TextStyle(color: Color(0xFF607489)))
          else
            ...events.map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(line, style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
              ),
            ),
        ],
      ),
    );
  }
}

class _BulletText extends StatelessWidget {
  const _BulletText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(Icons.circle, size: 7, color: Color(0xFF3B5E79)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.34))),
        ],
      ),
    );
  }
}

BoxDecoration _softBox() {
  return BoxDecoration(
    color: const Color(0xFFF2F7FC),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: const Color(0xFFD7E2EE)),
  );
}

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF16344E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: IndexedStack', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'IndexedStack is the go-to widget for mode switching where each panel must preserve local state. It paints one child at a time while keeping all children alive, enabling smooth workspace transitions and persistent UI context.',
            style: TextStyle(color: Color(0xFFD8E6F3), height: 1.36),
          ),
        ],
      ),
    );
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
