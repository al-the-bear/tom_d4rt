import 'dart:math' as math;

import 'package:flutter/material.dart';

const _ink = Color(0xFF0F2B3B);
const _marine = Color(0xFF1E5A86);
const _mint = Color(0xFF1E8A70);
const _amber = Color(0xFFBD8D3D);
const _rose = Color(0xFFA0567C);
const _violet = Color(0xFF6255A8);

dynamic build(BuildContext context) {
  return const _InheritedWidgetDeepDemoApp();
}

class _InheritedWidgetDeepDemoApp extends StatelessWidget {
  const _InheritedWidgetDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _marine),
        scaffoldBackgroundColor: const Color(0xFFF3F8FC),
      ),
      home: const _InheritedWidgetDeepDemoPage(),
    );
  }
}

@immutable
class AppStateSnapshot {
  const AppStateSnapshot({
    required this.accent,
    required this.surface,
    required this.frame,
    required this.corner,
    required this.density,
    required this.zoom,
    required this.counter,
    required this.energy,
    required this.message,
    required this.quickActions,
  });

  final Color accent;
  final Color surface;
  final Color frame;
  final double corner;
  final double density;
  final double zoom;
  final int counter;
  final double energy;
  final String message;
  final List<String> quickActions;

  AppStateSnapshot copyWith({
    Color? accent,
    Color? surface,
    Color? frame,
    double? corner,
    double? density,
    double? zoom,
    int? counter,
    double? energy,
    String? message,
    List<String>? quickActions,
  }) {
    return AppStateSnapshot(
      accent: accent ?? this.accent,
      surface: surface ?? this.surface,
      frame: frame ?? this.frame,
      corner: corner ?? this.corner,
      density: density ?? this.density,
      zoom: zoom ?? this.zoom,
      counter: counter ?? this.counter,
      energy: energy ?? this.energy,
      message: message ?? this.message,
      quickActions: quickActions ?? this.quickActions,
    );
  }

  AppStateSnapshot randomize() {
    final random = math.Random(DateTime.now().microsecondsSinceEpoch);
    final hue = random.nextDouble() * 360;
    final accentColor = HSLColor.fromAHSL(1, hue, 0.55, 0.43).toColor();
    final surfaceColor = HSLColor.fromAHSL(1, hue, 0.40, 0.95).toColor();
    final frameColor = HSLColor.fromAHSL(1, hue, 0.28, 0.73).toColor();
    final words = ['Focus', 'Inspect', 'Compose', 'Refine', 'Audit', 'Ship', 'Deploy', 'Review'];
    final picks = <String>[];
    while (picks.length < 4) {
      final candidate = words[random.nextInt(words.length)];
      if (!picks.contains(candidate)) {
        picks.add(candidate);
      }
    }
    return copyWith(
      accent: accentColor,
      surface: surfaceColor,
      frame: frameColor,
      corner: 8 + random.nextDouble() * 18,
      density: 0.32 + random.nextDouble() * 0.56,
      zoom: 0.86 + random.nextDouble() * 0.54,
      counter: counter + 1,
      energy: 0.20 + random.nextDouble() * 0.78,
      message: 'Profile #${100 + random.nextInt(900)}',
      quickActions: picks,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AppStateSnapshot &&
        other.accent == accent &&
        other.surface == surface &&
        other.frame == frame &&
        other.corner == corner &&
        other.density == density &&
        other.zoom == zoom &&
        other.counter == counter &&
        other.energy == energy &&
        other.message == message &&
        _sameList(other.quickActions, quickActions);
  }

  @override
  int get hashCode {
    return Object.hash(
      accent,
      surface,
      frame,
      corner,
      density,
      zoom,
      counter,
      energy,
      message,
      Object.hashAll(quickActions),
    );
  }
}

bool _sameList(List<String> a, List<String> b) {
  if (a.length != b.length) {
    return false;
  }
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return false;
    }
  }
  return true;
}

class AppStateScope extends InheritedWidget {
  const AppStateScope({super.key, required this.snapshot, required super.child});

  final AppStateSnapshot snapshot;

  static AppStateSnapshot watch(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    if (scope == null) {
      throw FlutterError('AppStateScope.watch called without AppStateScope in context');
    }
    return scope.snapshot;
  }

  static AppStateSnapshot read(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<AppStateScope>();
    if (scope == null) {
      throw FlutterError('AppStateScope.read called without AppStateScope in context');
    }
    return scope.snapshot;
  }

  @override
  bool updateShouldNotify(covariant AppStateScope oldWidget) {
    return snapshot != oldWidget.snapshot;
  }
}

class _InheritedWidgetDeepDemoPage extends StatefulWidget {
  const _InheritedWidgetDeepDemoPage();

  @override
  State<_InheritedWidgetDeepDemoPage> createState() => _InheritedWidgetDeepDemoPageState();
}

class _InheritedWidgetDeepDemoPageState extends State<_InheritedWidgetDeepDemoPage> {
  bool _compact = false;
  bool _guide = true;
  bool _labels = true;
  bool _rtl = false;

  AppStateSnapshot _state = const AppStateSnapshot(
    accent: _marine,
    surface: Color(0xFFF4FAFF),
    frame: Color(0xFFB6D0E8),
    corner: 12,
    density: 0.58,
    zoom: 1,
    counter: 1,
    energy: 0.62,
    message: 'Baseline profile',
    quickActions: ['Inspect', 'Tune', 'Sync', 'Publish'],
  );

  final List<String> _events = <String>[];

  void _log(String entry) {
    setState(() {
      _events.insert(0, '${_clock()} | $entry');
      if (_events.length > 45) {
        _events.removeRange(45, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = _DemoConfig(
      compact: _compact,
      guide: _guide,
      labels: _labels,
      direction: _rtl ? TextDirection.rtl : TextDirection.ltr,
    );

    return Directionality(
      textDirection: config.direction,
      child: AppStateScope(
        snapshot: _state,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 86,
            backgroundColor: _ink,
            foregroundColor: Colors.white,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('InheritedWidget Deep Demo'),
                const SizedBox(height: 3),
                Text(
                  'counter ${_state.counter} | density ${_state.density.toStringAsFixed(2)} | energy ${_state.energy.toStringAsFixed(2)} | ${_state.message}',
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _CommandDeck(
                  compact: _compact,
                  guide: _guide,
                  labels: _labels,
                  rtl: _rtl,
                  snapshot: _state,
                  onCompactChanged: (v) => setState(() => _compact = v),
                  onGuideChanged: (v) => setState(() => _guide = v),
                  onLabelsChanged: (v) => setState(() => _labels = v),
                  onRtlChanged: (v) => setState(() => _rtl = v),
                  onEnergyChanged: (v) => setState(() => _state = _state.copyWith(energy: v)),
                  onDensityChanged: (v) => setState(() => _state = _state.copyWith(density: v)),
                  onZoomChanged: (v) => setState(() => _state = _state.copyWith(zoom: v)),
                  onMessageChanged: (value) => setState(() => _state = _state.copyWith(message: value)),
                  onRandomize: () {
                    setState(() => _state = _state.randomize());
                    _log('root snapshot randomized');
                  },
                  onBumpCounter: () {
                    setState(() => _state = _state.copyWith(counter: _state.counter + 1));
                    _log('counter bumped to ${_state.counter}');
                  },
                  onReset: () {
                    setState(
                      () => _state = const AppStateSnapshot(
                        accent: _marine,
                        surface: Color(0xFFF4FAFF),
                        frame: Color(0xFFB6D0E8),
                        corner: 12,
                        density: 0.58,
                        zoom: 1,
                        counter: 1,
                        energy: 0.62,
                        message: 'Baseline profile',
                        quickActions: ['Inspect', 'Tune', 'Sync', 'Publish'],
                      ),
                    );
                    _log('root snapshot reset');
                  },
                ),
                const SizedBox(height: 12),
                _SceneShell(
                  index: 1,
                  title: 'Fundamentals and Data Flow',
                  subtitle:
                      'A direct InheritedWidget implementation that shares immutable snapshot data to descendants and demonstrates typical access methods.',
                  tone: _marine,
                  child: _FundamentalsScene(config: config, onEvent: _log),
                ),
                const SizedBox(height: 12),
                _SceneShell(
                  index: 2,
                  title: 'Nested Scope Overrides',
                  subtitle:
                      'Shows branch-local overrides by wrapping descendants with a second AppStateScope and comparing inherited values side by side.',
                  tone: _mint,
                  child: _NestedOverridesScene(config: config, onEvent: _log),
                ),
                const SizedBox(height: 12),
                _SceneShell(
                  index: 3,
                  title: 'Dependency and Rebuild Semantics',
                  subtitle:
                      'Contrasts watch dependencies with read snapshots and static widgets to visualize when descendants rebuild.',
                  tone: _amber,
                  child: _DependencyStudioScene(config: config, onEvent: _log),
                ),
                const SizedBox(height: 12),
                _SceneShell(
                  index: 4,
                  title: 'Context Boundaries and Scope Selection',
                  subtitle:
                      'Builder placement and context origin determine which scope is seen; this scene makes those boundaries explicit.',
                  tone: _rose,
                  child: _ContextBoundaryScene(config: config, onEvent: _log),
                ),
                const SizedBox(height: 12),
                _SceneShell(
                  index: 5,
                  title: 'Practical Workspace Composition',
                  subtitle:
                      'A realistic multi-panel workspace where InheritedWidget provides app-wide visual and behavioral profile data.',
                  tone: _violet,
                  child: _PracticalWorkspaceScene(config: config, onEvent: _log),
                ),
                const SizedBox(height: 12),
                _EventBoard(events: _events),
                const SizedBox(height: 12),
                const _RecapSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DemoConfig {
  const _DemoConfig({
    required this.compact,
    required this.guide,
    required this.labels,
    required this.direction,
  });

  final bool compact;
  final bool guide;
  final bool labels;
  final TextDirection direction;
}

class _CommandDeck extends StatelessWidget {
  const _CommandDeck({
    required this.compact,
    required this.guide,
    required this.labels,
    required this.rtl,
    required this.snapshot,
    required this.onCompactChanged,
    required this.onGuideChanged,
    required this.onLabelsChanged,
    required this.onRtlChanged,
    required this.onEnergyChanged,
    required this.onDensityChanged,
    required this.onZoomChanged,
    required this.onMessageChanged,
    required this.onRandomize,
    required this.onBumpCounter,
    required this.onReset,
  });

  final bool compact;
  final bool guide;
  final bool labels;
  final bool rtl;
  final AppStateSnapshot snapshot;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuideChanged;
  final ValueChanged<bool> onLabelsChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onEnergyChanged;
  final ValueChanged<double> onDensityChanged;
  final ValueChanged<double> onZoomChanged;
  final ValueChanged<String> onMessageChanged;
  final VoidCallback onRandomize;
  final VoidCallback onBumpCounter;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF10304A), Color(0xFF1A5C80), Color(0xFF35658D), Color(0xFF5E4EA8)],
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
              'InheritedWidget Control Deck',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
            ),
            const SizedBox(height: 6),
            const Text(
              'InheritedWidget is ideal for propagating immutable snapshots through the tree. '
              'This dashboard updates the scope ancestor to demonstrate descendant reactions in different dependency modes.',
              style: TextStyle(color: Color(0xFFD7E7F6), height: 1.36),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: SwitchListTile(
                    value: compact,
                    onChanged: onCompactChanged,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Compact layout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  ),
                ),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: SwitchListTile(
                    value: guide,
                    onChanged: onGuideChanged,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Guide background', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  ),
                ),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: SwitchListTile(
                    value: labels,
                    onChanged: onLabelsChanged,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Show labels', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  ),
                ),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: SwitchListTile(
                    value: rtl,
                    onChanged: onRtlChanged,
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: const Text('RTL mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _DeckReadout(label: 'accent', value: '#${snapshot.accent.toARGB32().toRadixString(16).toUpperCase()}'),
                ),
                const SizedBox(width: 8),
                Expanded(child: _DeckReadout(label: 'counter', value: '${snapshot.counter}')),
                const SizedBox(width: 8),
                Expanded(child: _DeckReadout(label: 'corner', value: snapshot.corner.toStringAsFixed(1))),
                const SizedBox(width: 8),
                Expanded(child: _DeckReadout(label: 'message', value: snapshot.message)),
              ],
            ),
            const SizedBox(height: 10),
            _LabeledSlider(
              label: 'Density',
              value: snapshot.density,
              min: 0.2,
              max: 1,
              onChanged: onDensityChanged,
              activeColor: Colors.white,
              inactiveColor: Colors.white.withValues(alpha: 0.32),
            ),
            _LabeledSlider(
              label: 'Energy',
              value: snapshot.energy,
              min: 0,
              max: 1,
              onChanged: onEnergyChanged,
              activeColor: Colors.white,
              inactiveColor: Colors.white.withValues(alpha: 0.32),
            ),
            _LabeledSlider(
              label: 'Zoom',
              value: snapshot.zoom,
              min: 0.75,
              max: 1.45,
              onChanged: onZoomChanged,
              activeColor: Colors.white,
              inactiveColor: Colors.white.withValues(alpha: 0.32),
            ),
            const SizedBox(height: 6),
            TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: onMessageChanged,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Edit snapshot message',
                hintStyle: const TextStyle(color: Color(0xFFD6E6F5)),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onRandomize,
                    style: FilledButton.styleFrom(foregroundColor: Colors.white),
                    child: const Text('Randomize Profile'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onBumpCounter,
                    style: FilledButton.styleFrom(foregroundColor: Colors.white),
                    child: const Text('Bump Counter'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReset,
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white70)),
                    child: const Text('Reset Baseline'),
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

class _DeckReadout extends StatelessWidget {
  const _DeckReadout({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.36)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFFCCE0F1), fontSize: 11, fontWeight: FontWeight.w700)),
          const SizedBox(height: 1),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _SceneShell extends StatelessWidget {
  const _SceneShell({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.tone,
    required this.child,
  });

  final int index;
  final String title;
  final String subtitle;
  final Color tone;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 7)),
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
                  radius: 15,
                  backgroundColor: tone,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 19)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF34495D), height: 1.35)),
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

class _FundamentalsScene extends StatefulWidget {
  const _FundamentalsScene({required this.config, required this.onEvent});

  final _DemoConfig config;
  final ValueChanged<String> onEvent;

  @override
  State<_FundamentalsScene> createState() => _FundamentalsSceneState();
}

class _FundamentalsSceneState extends State<_FundamentalsScene> {
  int _tab = 0;
  bool _showTree = true;
  bool _showBars = true;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final snapshot = AppStateScope.watch(context);

    return SizedBox(
      height: config.compact ? 640 : 760,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _SurfacePanel(
              showGuide: config.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Scene controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(value: 0, label: Text('Tree')),
                          ButtonSegment(value: 1, label: Text('Cards')),
                          ButtonSegment(value: 2, label: Text('Flows')),
                        ],
                        selected: {_tab},
                        onSelectionChanged: (s) {
                          setState(() => _tab = s.first);
                          widget.onEvent('fundamentals tab -> $_tab');
                        },
                      ),
                      const SizedBox(height: 8),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _showTree,
                        onChanged: (v) => setState(() => _showTree = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show branch tree labels'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _showBars,
                        onChanged: (v) => setState(() => _showBars = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show density/energy bars'),
                      ),
                      ),
                      const SizedBox(height: 8),
                      _SnapshotTable(data: snapshot, title: 'Current inherited snapshot'),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _mutedBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('What this demonstrates', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _LineBullet(text: 'AppStateScope extends InheritedWidget and holds immutable snapshot data.'),
                            _LineBullet(text: 'Descendants using watch establish dependencies and rebuild on snapshot changes.'),
                            _LineBullet(text: 'The ancestor widget mutates snapshot by rebuilding with a new object.'),
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
            child: _SurfacePanel(
              showGuide: config.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IndexedStack(
                  index: _tab,
                  children: [
                    _FundamentalsTree(showLabels: _showTree, showBars: _showBars),
                    _FundamentalsCards(showBars: _showBars),
                    _FundamentalsFlows(showLabels: _showTree),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FundamentalsTree extends StatelessWidget {
  const _FundamentalsTree({required this.showLabels, required this.showBars});

  final bool showLabels;
  final bool showBars;

  @override
  Widget build(BuildContext context) {
    final s = AppStateScope.watch(context);
    return Container(
      decoration: BoxDecoration(
        color: s.surface,
        borderRadius: BorderRadius.circular(s.corner),
        border: Border.all(color: s.frame),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showLabels)
              Text('Root scope data tree', style: TextStyle(color: s.accent, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Expanded(
              child: Row(
                children: const [
                  Expanded(child: _TreeNodeCard(title: 'Root Consumer A')),
                  SizedBox(width: 8),
                  Expanded(child: _TreeNodeCard(title: 'Root Consumer B')),
                  SizedBox(width: 8),
                  Expanded(child: _TreeNodeCard(title: 'Root Consumer C')),
                ],
              ),
            ),
            if (showBars) ...[
              const SizedBox(height: 8),
              _DualBar(density: s.density, energy: s.energy, color: s.accent),
            ],
          ],
        ),
      ),
    );
  }
}

class _TreeNodeCard extends StatelessWidget {
  const _TreeNodeCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final s = AppStateScope.watch(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(s.corner * 0.7),
        border: Border.all(color: s.accent.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: s.accent, fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 6),
          _TinyInfo(label: 'counter', value: '${s.counter}'),
          _TinyInfo(label: 'zoom', value: s.zoom.toStringAsFixed(2)),
          _TinyInfo(label: 'msg', value: s.message),
          const Spacer(),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: s.accent.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: s.density.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(color: s.accent, borderRadius: BorderRadius.circular(999)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FundamentalsCards extends StatelessWidget {
  const _FundamentalsCards({required this.showBars});

  final bool showBars;

  @override
  Widget build(BuildContext context) {
    final s = AppStateScope.watch(context);
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.08,
      children: List<Widget>.generate(
        6,
        (index) {
          final hue = (HSLColor.fromColor(s.accent).hue + (index * 12)) % 360;
          final tone = HSLColor.fromAHSL(1, hue, 0.54, 0.44).toColor();
          return AppStateScope(
            snapshot: s.copyWith(accent: tone, message: 'Card ${index + 1}', counter: s.counter + index),
            child: _CardNode(showBars: showBars, index: index),
          );
        },
      ),
    );
  }
}

class _CardNode extends StatelessWidget {
  const _CardNode({required this.showBars, required this.index});

  final bool showBars;
  final int index;

  @override
  Widget build(BuildContext context) {
    final s = AppStateScope.watch(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: s.surface,
        borderRadius: BorderRadius.circular(s.corner * 0.72),
        border: Border.all(color: s.frame),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sample ${index + 1}', style: TextStyle(color: s.accent, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(s.corner * 0.55),
                border: Border.all(color: s.accent.withValues(alpha: 0.25)),
              ),
              child: Center(child: Icon(Icons.account_tree_rounded, color: s.accent, size: 26 * s.zoom)),
            ),
          ),
          const SizedBox(height: 6),
          Text('counter ${s.counter}', style: TextStyle(fontSize: 11, color: s.accent.withValues(alpha: 0.85))),
          if (showBars) ...[
            const SizedBox(height: 4),
            _DualBar(density: s.density, energy: s.energy, color: s.accent),
          ],
        ],
      ),
    );
  }
}

class _FundamentalsFlows extends StatelessWidget {
  const _FundamentalsFlows({required this.showLabels});

  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    final s = AppStateScope.watch(context);
    return Container(
      decoration: BoxDecoration(
        color: s.surface,
        borderRadius: BorderRadius.circular(s.corner),
        border: Border.all(color: s.frame),
      ),
      child: Column(
        children: List<Widget>.generate(7, (index) {
          final ratio = ((index + 2) / 10).clamp(0.0, 1.0);
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(s.corner * 0.65),
                  border: Border.all(color: s.frame.withValues(alpha: 0.62)),
                ),
                child: Row(
                  children: [
                    if (showLabels)
                      SizedBox(
                        width: 140,
                        child: Text('Flow segment ${index + 1}', style: TextStyle(color: s.accent, fontWeight: FontWeight.w700)),
                      ),
                    Expanded(
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: s.accent.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: ratio,
                          child: Container(
                            decoration: BoxDecoration(
                              color: s.accent,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NestedOverridesScene extends StatefulWidget {
  const _NestedOverridesScene({required this.config, required this.onEvent});

  final _DemoConfig config;
  final ValueChanged<String> onEvent;

  @override
  State<_NestedOverridesScene> createState() => _NestedOverridesSceneState();
}

class _NestedOverridesSceneState extends State<_NestedOverridesScene> {
  bool _middle = true;
  bool _inner = true;
  bool _hardContrast = false;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final root = AppStateScope.watch(context);

    final middleSnap = root.copyWith(
      accent: _mint,
      surface: const Color(0xFFF0FBF7),
      frame: const Color(0xFF95CFBE),
      corner: root.corner + 3,
      message: 'Middle override',
      counter: root.counter + 50,
      density: (root.density + 0.09).clamp(0.0, 1.0),
    );

    final innerAccent = _hardContrast ? const Color(0xFF1B1F2B) : _rose;
    final innerSurface = _hardContrast ? const Color(0xFFE8EAF0) : const Color(0xFFFDF4F8);
    final innerFrame = _hardContrast ? const Color(0xFF6A778F) : const Color(0xFFD7A3BC);

    final innerSnap = root.copyWith(
      accent: innerAccent,
      surface: innerSurface,
      frame: innerFrame,
      corner: root.corner + 7,
      message: 'Inner override',
      counter: root.counter + 120,
      density: (root.density + 0.16).clamp(0.0, 1.0),
      energy: (root.energy + 0.22).clamp(0.0, 1.0),
    );

    return SizedBox(
      height: config.compact ? 690 : 810,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _SurfacePanel(
              showGuide: config.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Override controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _middle,
                        onChanged: (v) {
                          setState(() => _middle = v);
                          widget.onEvent('middle override -> $v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Enable middle scope override'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _inner,
                        onChanged: (v) {
                          setState(() => _inner = v);
                          widget.onEvent('inner override -> $v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Enable inner scope override'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _hardContrast,
                        onChanged: (v) {
                          setState(() => _hardContrast = v);
                          widget.onEvent('hard contrast inner -> $v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Hard contrast inner profile'),
                      ),
                      ),
                      const SizedBox(height: 8),
                      _SnapshotTable(data: root, title: 'Root snapshot'),
                      const SizedBox(height: 8),
                      _SnapshotTable(data: middleSnap, title: 'Middle snapshot'),
                      const SizedBox(height: 8),
                      _SnapshotTable(data: innerSnap, title: 'Inner snapshot'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _SurfacePanel(
              showGuide: config.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _scopeLayer(
                  label: 'Root Scope',
                  snapshot: root,
                  child: _middle
                      ? AppStateScope(
                          snapshot: middleSnap,
                          child: _scopeLayer(
                            label: 'Middle Scope',
                            snapshot: middleSnap,
                            child: _inner
                                ? AppStateScope(
                                    snapshot: innerSnap,
                                    child: _scopeLayer(
                                      label: 'Inner Scope',
                                      snapshot: innerSnap,
                                      child: const _NestedProbeGrid(),
                                    ),
                                  )
                                : const _NestedProbeGrid(),
                          ),
                        )
                      : const _NestedProbeGrid(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scopeLayer({
    required String label,
    required AppStateSnapshot snapshot,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: snapshot.surface,
        borderRadius: BorderRadius.circular(snapshot.corner),
        border: Border.all(color: snapshot.frame, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: snapshot.accent, fontWeight: FontWeight.w800)),
          const SizedBox(height: 7),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _NestedProbeGrid extends StatelessWidget {
  const _NestedProbeGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.12,
      children: List<Widget>.generate(6, (i) => _NestedProbeCard(index: i)),
    );
  }
}

class _NestedProbeCard extends StatelessWidget {
  const _NestedProbeCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final s = AppStateScope.watch(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(s.corner * 0.65),
        border: Border.all(color: s.accent.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Probe ${index + 1}', style: TextStyle(color: s.accent, fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 7),
          Expanded(child: Center(child: Icon(Icons.hub_rounded, color: s.accent, size: 28))),
          Text('counter ${s.counter + index}', style: TextStyle(fontSize: 11, color: s.accent.withValues(alpha: 0.83))),
        ],
      ),
    );
  }
}

class _DependencyStudioScene extends StatefulWidget {
  const _DependencyStudioScene({required this.config, required this.onEvent});

  final _DemoConfig config;
  final ValueChanged<String> onEvent;

  @override
  State<_DependencyStudioScene> createState() => _DependencyStudioSceneState();
}

class _DependencyStudioSceneState extends State<_DependencyStudioScene> {
  int _kicks = 0;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final state = AppStateScope.read(context);

    return SizedBox(
      height: config.compact ? 700 : 840,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _SurfacePanel(
              showGuide: config.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rebuild controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    FilledButton.tonal(
                      onPressed: () {
                        setState(() => _kicks += 1);
                        widget.onEvent('dependency scene local setState kick #$_kicks');
                      },
                      child: Text('Local setState kick ($_kicks)'),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () {
                              final root = context.findAncestorStateOfType<_InheritedWidgetDeepDemoPageState>();
                              if (root != null) {
                                root.setState(
                                  () => root._state = root._state.copyWith(
                                    density: (root._state.density + 0.06).clamp(0.0, 1.0),
                                    counter: root._state.counter + 1,
                                  ),
                                );
                              }
                              widget.onEvent('root density increase via ancestor state');
                            },
                            child: const Text('Root density +'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () {
                              final root = context.findAncestorStateOfType<_InheritedWidgetDeepDemoPageState>();
                              if (root != null) {
                                final hue = HSLColor.fromColor(root._state.accent).hue;
                                root.setState(
                                  () => root._state = root._state.copyWith(
                                    accent: HSLColor.fromColor(root._state.accent).withHue((hue + 18) % 360).toColor(),
                                    counter: root._state.counter + 1,
                                  ),
                                );
                              }
                              widget.onEvent('root hue shift via ancestor state');
                            },
                            child: const Text('Root hue shift'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _SnapshotTable(data: state, title: 'Current root snapshot'),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _mutedBox(),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Expected behavior', style: TextStyle(fontWeight: FontWeight.w800)),
                          SizedBox(height: 6),
                          _LineBullet(text: 'Watch widgets rebuild on inherited snapshot changes.'),
                          _LineBullet(text: 'Read widgets do not depend and only change when they call read again.'),
                          _LineBullet(text: 'Static widgets ignore inherited data entirely.'),
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
            child: _SurfacePanel(
              showGuide: config.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: const [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _WatchCard(title: 'Watch A', tone: _marine)),
                          SizedBox(width: 8),
                          Expanded(child: _WatchCard(title: 'Watch B', tone: _mint)),
                          SizedBox(width: 8),
                          Expanded(child: _ReadCard(title: 'Read Snapshot', tone: _amber)),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _StaticCard(title: 'Static Node', tone: _rose)),
                          SizedBox(width: 8),
                          Expanded(child: _WatchCard(title: 'Watch C', tone: _violet)),
                          SizedBox(width: 8),
                          Expanded(child: _WatchCard(title: 'Watch D', tone: _ink)),
                        ],
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
}

class _WatchCard extends StatelessWidget {
  const _WatchCard({required this.title, required this.tone});

  final String title;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return _BuildCounterShell(
      title: title,
      tone: tone,
      mode: 'watch',
      bodyBuilder: (context, builds) {
        final s = AppStateScope.watch(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('builds: $builds', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
            const SizedBox(height: 4),
            Text('counter ${s.counter}', style: const TextStyle(fontSize: 11)),
            Text('density ${s.density.toStringAsFixed(2)}', style: const TextStyle(fontSize: 11)),
            Text('message ${s.message}', style: const TextStyle(fontSize: 11)),
            const Spacer(),
            _DualBar(density: s.density, energy: s.energy, color: s.accent),
          ],
        );
      },
    );
  }
}

class _ReadCard extends StatefulWidget {
  const _ReadCard({required this.title, required this.tone});

  final String title;
  final Color tone;

  @override
  State<_ReadCard> createState() => _ReadCardState();
}

class _ReadCardState extends State<_ReadCard> {
  String _cached = 'press capture';

  @override
  Widget build(BuildContext context) {
    return _BuildCounterShell(
      title: widget.title,
      tone: widget.tone,
      mode: 'read',
      bodyBuilder: (context, builds) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('builds: $builds', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
            const SizedBox(height: 4),
            Text(_cached, style: const TextStyle(fontSize: 11, height: 1.35)),
            const Spacer(),
            FilledButton.tonal(
              onPressed: () {
                final s = AppStateScope.read(context);
                setState(
                  () => _cached = 'counter ${s.counter}\n'
                      'density ${s.density.toStringAsFixed(2)}\n'
                      'msg ${s.message}',
                );
              },
              child: const Text('Capture read() snapshot'),
            ),
          ],
        );
      },
    );
  }
}

class _StaticCard extends StatelessWidget {
  const _StaticCard({required this.title, required this.tone});

  final String title;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return _BuildCounterShell(
      title: title,
      tone: tone,
      mode: 'static',
      bodyBuilder: (context, builds) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('builds: $builds', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
            const SizedBox(height: 4),
            const Text('No AppStateScope access.', style: TextStyle(fontSize: 11)),
            const Text('Only parent rebuild triggers it.', style: TextStyle(fontSize: 11)),
            const Spacer(),
            Icon(Icons.block_rounded, color: tone, size: 28),
          ],
        );
      },
    );
  }
}

class _BuildCounterShell extends StatefulWidget {
  const _BuildCounterShell({
    required this.title,
    required this.tone,
    required this.mode,
    required this.bodyBuilder,
  });

  final String title;
  final Color tone;
  final String mode;
  final Widget Function(BuildContext context, int builds) bodyBuilder;

  @override
  State<_BuildCounterShell> createState() => _BuildCounterShellState();
}

class _BuildCounterShellState extends State<_BuildCounterShell> {
  int _builds = 0;

  @override
  Widget build(BuildContext context) {
    _builds += 1;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.tone.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(widget.mode, style: TextStyle(color: widget.tone.withValues(alpha: 0.83), fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Expanded(child: widget.bodyBuilder(context, _builds)),
        ],
      ),
    );
  }
}

class _ContextBoundaryScene extends StatefulWidget {
  const _ContextBoundaryScene({required this.config, required this.onEvent});

  final _DemoConfig config;
  final ValueChanged<String> onEvent;

  @override
  State<_ContextBoundaryScene> createState() => _ContextBoundarySceneState();
}

class _ContextBoundarySceneState extends State<_ContextBoundaryScene> {
  bool _overrideRight = true;
  bool _highlight = true;
  bool _showBuilderTags = true;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final root = AppStateScope.watch(context);
    final rightSnap = root.copyWith(
      accent: _violet,
      surface: const Color(0xFFF5F1FF),
      frame: const Color(0xFFBBAFDF),
      message: 'Right branch override',
      counter: root.counter + 300,
      density: (root.density + 0.11).clamp(0.0, 1.0),
      energy: (root.energy + 0.18).clamp(0.0, 1.0),
    );

    return SizedBox(
      height: config.compact ? 700 : 850,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _SurfacePanel(
              showGuide: config.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Boundary controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _overrideRight,
                        onChanged: (v) {
                          setState(() => _overrideRight = v);
                          widget.onEvent('right branch override -> $v');
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Enable right branch local scope'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _highlight,
                        onChanged: (v) => setState(() => _highlight = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Highlight branch boundary frames'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        value: _showBuilderTags,
                        onChanged: (v) => setState(() => _showBuilderTags = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show Builder placement tags'),
                      ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _mutedBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Boundary lesson', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _LineBullet(text: 'Inherited lookup starts from the BuildContext location.'),
                            _LineBullet(text: 'A Builder creates a new context below where it appears in the tree.'),
                            _LineBullet(text: 'Moving a widget across scope boundaries changes what it inherits.'),
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
            child: _SurfacePanel(
              showGuide: config.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: _BranchZone(
                        title: 'Left branch (root only)',
                        highlight: _highlight,
                        child: _BoundaryProbeColumn(showBuilderTags: _showBuilderTags),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _overrideRight
                          ? AppStateScope(
                              snapshot: rightSnap,
                              child: _BranchZone(
                                title: 'Right branch (override)',
                                highlight: _highlight,
                                child: _BoundaryProbeColumn(showBuilderTags: _showBuilderTags),
                              ),
                            )
                          : _BranchZone(
                              title: 'Right branch (root)',
                              highlight: _highlight,
                              child: _BoundaryProbeColumn(showBuilderTags: _showBuilderTags),
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
}

class _BranchZone extends StatelessWidget {
  const _BranchZone({required this.title, required this.highlight, required this.child});

  final String title;
  final bool highlight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final s = AppStateScope.watch(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: s.surface,
        borderRadius: BorderRadius.circular(s.corner),
        border: Border.all(color: highlight ? s.frame : s.frame.withValues(alpha: 0.4), width: highlight ? 2 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: s.accent, fontWeight: FontWeight.w800)),
          const SizedBox(height: 7),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _BoundaryProbeColumn extends StatelessWidget {
  const _BoundaryProbeColumn({required this.showBuilderTags});

  final bool showBuilderTags;

  @override
  Widget build(BuildContext context) {
    final outer = AppStateScope.watch(context);
    return Column(
      children: [
        Expanded(
          child: _BoundaryProbeCard(
            label: 'Direct child context',
            valueBuilder: (_) => AppStateScope.watch(context),
            showBuilderTag: showBuilderTags,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Builder(
            builder: (innerContext) {
              return _BoundaryProbeCard(
                label: 'Builder child context',
                valueBuilder: (_) => AppStateScope.watch(innerContext),
                showBuilderTag: showBuilderTags,
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: _BoundaryProbeCard(
            label: 'read() snapshot',
            valueBuilder: (_) => AppStateScope.read(context),
            showBuilderTag: false,
          ),
        ),
        const SizedBox(height: 8),
        _DualBar(density: outer.density, energy: outer.energy, color: outer.accent),
      ],
    );
  }
}

class _BoundaryProbeCard extends StatelessWidget {
  const _BoundaryProbeCard({
    required this.label,
    required this.valueBuilder,
    required this.showBuilderTag,
  });

  final String label;
  final AppStateSnapshot Function(BuildContext context) valueBuilder;
  final bool showBuilderTag;

  @override
  Widget build(BuildContext context) {
    final s = valueBuilder(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(s.corner * 0.64),
        border: Border.all(color: s.accent.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(label, style: TextStyle(color: s.accent, fontWeight: FontWeight.w800, fontSize: 12))),
              if (showBuilderTag)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: s.accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text('Builder', style: TextStyle(color: s.accent, fontSize: 10, fontWeight: FontWeight.w700)),
                ),
            ],
          ),
          const SizedBox(height: 6),
          _TinyInfo(label: 'accent', value: '#${s.accent.toARGB32().toRadixString(16).toUpperCase()}'),
          _TinyInfo(label: 'message', value: s.message),
          _TinyInfo(label: 'counter', value: '${s.counter}'),
        ],
      ),
    );
  }
}

class _PracticalWorkspaceScene extends StatefulWidget {
  const _PracticalWorkspaceScene({required this.config, required this.onEvent});

  final _DemoConfig config;
  final ValueChanged<String> onEvent;

  @override
  State<_PracticalWorkspaceScene> createState() => _PracticalWorkspaceSceneState();
}

class _PracticalWorkspaceSceneState extends State<_PracticalWorkspaceScene> {
  int _active = 0;
  bool _compactRail = false;
  bool _contrast = false;
  bool _meta = true;

  final List<String> _localLog = <String>[];

  void _push(String line) {
    setState(() {
      _localLog.insert(0, '${_clock()} | $line');
      if (_localLog.length > 24) {
        _localLog.removeRange(24, _localLog.length);
      }
    });
    widget.onEvent(line);
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final root = AppStateScope.watch(context);

    final workspace = root.copyWith(
      accent: _contrast ? const Color(0xFFD9E7F9) : _violet,
      surface: _contrast ? const Color(0xFF1A2230) : const Color(0xFFF5F2FF),
      frame: _contrast ? const Color(0xFF41526A) : const Color(0xFFBDAFDF),
      message: _contrast ? 'Contrast workspace profile' : 'Violet workspace profile',
      corner: root.corner + 2,
    );

    final fg = _contrast ? Colors.white : _ink;
    final tabs = const ['Overview', 'Tasks', 'Timeline', 'Logs'];

    return SizedBox(
      height: config.compact ? 910 : 1070,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _SurfacePanel(
              showGuide: config.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        tabs.length,
                        (i) => ChoiceChip(
                          selected: _active == i,
                          label: Text(tabs[i]),
                          onSelected: (_) {
                            setState(() => _active = i);
                            _push('workspace tab -> ${tabs[i]}');
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
                          selected: _contrast,
                          label: const Text('Contrast theme'),
                          onSelected: (v) => setState(() => _contrast = v),
                        ),
                        FilterChip(
                          selected: _meta,
                          label: const Text('Metadata strip'),
                          onSelected: (v) => setState(() => _meta = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: AppStateScope(
                        snapshot: workspace,
                        child: Builder(
                          builder: (context) {
                            final s = AppStateScope.watch(context);
                            return Container(
                              decoration: BoxDecoration(
                                color: s.surface,
                                borderRadius: BorderRadius.circular(s.corner),
                                border: Border.all(color: s.frame),
                              ),
                              child: Column(
                                children: [
                                  _wsTop(fg),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        _wsRail(tabs, fg),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              if (_meta) _wsMeta(fg),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: IndexedStack(
                                                    index: _active,
                                                    children: [
                                                      _wsOverview(fg),
                                                      _wsTasks(fg),
                                                      _wsTimeline(fg),
                                                      _wsLogs(fg),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _wsFooter(fg),
                                ],
                              ),
                            );
                          },
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
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFBFCFF),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFD4E0EC)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Workspace local log', style: TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  if (_localLog.isEmpty)
                    const Text('No local actions yet.', style: TextStyle(color: Color(0xFF607487)))
                  else
                    ..._localLog.map(
                      (line) => Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(line, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _wsTop(Color fg) {
    final s = AppStateScope.watch(context);
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: s.accent.withValues(alpha: 0.16),
        borderRadius: BorderRadius.vertical(top: Radius.circular(s.corner)),
      ),
      child: Row(
        children: [
          Icon(Icons.widgets_rounded, color: s.accent),
          const SizedBox(width: 8),
          Text('Scope Workspace', style: TextStyle(color: fg, fontWeight: FontWeight.w800, fontSize: 18)),
          const Spacer(),
          Text('InheritedWidget profile shell', style: TextStyle(color: fg.withValues(alpha: 0.82), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _wsRail(List<String> tabs, Color fg) {
    final s = AppStateScope.watch(context);
    return Container(
      width: _compactRail ? 74 : 118,
      decoration: BoxDecoration(
        color: s.accent.withValues(alpha: 0.10),
        border: Border(right: BorderSide(color: s.frame)),
      ),
      child: ListView.builder(
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final selected = _active == index;
          return InkWell(
            onTap: () {
              setState(() => _active = index);
              _push('rail -> ${tabs[index]}');
            },
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? s.accent.withValues(alpha: 0.24) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: selected ? s.accent.withValues(alpha: 0.48) : Colors.transparent),
              ),
              child: Column(
                children: [
                  Icon(_icons[index], color: selected ? s.accent : fg.withValues(alpha: 0.78), size: _compactRail ? 18 : 20),
                  if (!_compactRail) ...[
                    const SizedBox(height: 3),
                    Text(tabs[index], style: TextStyle(color: fg, fontSize: 10), textAlign: TextAlign.center),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _wsMeta(Color fg) {
    final s = AppStateScope.watch(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: s.accent.withValues(alpha: 0.11),
        border: Border(bottom: BorderSide(color: s.frame)),
      ),
      child: Row(
        children: [
          Text('message: ${s.message}', style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 12)),
          const Spacer(),
          Text('counter ${s.counter}', style: TextStyle(color: fg.withValues(alpha: 0.85), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _wsFooter(Color fg) {
    final s = AppStateScope.watch(context);
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: s.accent.withValues(alpha: 0.10),
        border: Border(top: BorderSide(color: s.frame)),
      ),
      child: Row(
        children: [
          Text('density ${s.density.toStringAsFixed(2)}', style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 12)),
          const Spacer(),
          Text('energy ${s.energy.toStringAsFixed(2)}', style: TextStyle(color: fg.withValues(alpha: 0.83), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _wsOverview(Color fg) {
    final s = AppStateScope.watch(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: _contrast ? 0.06 : 0.94),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: s.frame.withValues(alpha: 0.72)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview', style: TextStyle(color: fg, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _MetricChip(title: 'Active users', value: '${120 + s.counter}', fg: fg, tone: s.accent)),
                const SizedBox(width: 8),
                Expanded(child: _MetricChip(title: 'Throughput', value: '${(s.energy * 100).toStringAsFixed(0)}%', fg: fg, tone: s.accent)),
                const SizedBox(width: 8),
                Expanded(child: _MetricChip(title: 'Zoom', value: s.zoom.toStringAsFixed(2), fg: fg, tone: s.accent)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: () => _push('overview refresh'),
            child: const Text('Refresh overview data'),
          ),
        ],
      ),
    );
  }

  Widget _wsTasks(Color fg) {
    final s = AppStateScope.watch(context);
    final tasks = List<String>.generate(8, (i) => 'Task ${i + 1}: ${s.quickActions[i % s.quickActions.length]}');
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: _contrast ? 0.06 : 0.94),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: s.frame.withValues(alpha: 0.72)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tasks', style: TextStyle(color: fg, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: s.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.checklist_rounded, color: s.accent, size: 18),
                      const SizedBox(width: 6),
                      Expanded(child: Text(tasks[i], style: TextStyle(color: fg))),
                      Text('P${(i % 3) + 1}', style: TextStyle(color: fg.withValues(alpha: 0.82), fontSize: 11)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _wsTimeline(Color fg) {
    final s = AppStateScope.watch(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: _contrast ? 0.06 : 0.94),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: s.frame.withValues(alpha: 0.72)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Timeline', style: TextStyle(color: fg, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          Expanded(
            child: CustomPaint(
              painter: _TimelinePainter(color: s.accent, progress: s.energy),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: () => _push('timeline sync'),
            child: const Text('Sync timeline markers'),
          ),
        ],
      ),
    );
  }

  Widget _wsLogs(Color fg) {
    final s = AppStateScope.watch(context);
    final lines = List<String>.generate(18, (i) => 'log ${i + 1}: ${s.message} :: ${s.quickActions[i % s.quickActions.length]}');
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1D2732),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: lines.length,
        itemBuilder: (context, i) {
          final color = i.isEven ? const Color(0xFFA4C3DD) : const Color(0xFF77A6D0);
          return Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(lines[i], style: TextStyle(fontFamily: 'monospace', color: color, fontSize: 12)),
          );
        },
      ),
    );
  }
}

const _icons = <IconData>[
  Icons.dashboard_rounded,
  Icons.task_alt_rounded,
  Icons.timeline_rounded,
  Icons.subject_rounded,
];

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.title, required this.value, required this.fg, required this.tone});

  final String title;
  final String value;
  final Color fg;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.30)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(color: fg.withValues(alpha: 0.86), fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: fg, fontWeight: FontWeight.w800, fontSize: 20)),
        ],
      ),
    );
  }
}

class _TimelinePainter extends CustomPainter {
  const _TimelinePainter({required this.color, required this.progress});

  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height * 0.54;
    final baseline = Paint()
      ..color = const Color(0xFFB7C9D9)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final active = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(18, y), Offset(size.width - 18, y), baseline);
    canvas.drawLine(Offset(18, y), Offset(18 + ((size.width - 36) * progress), y), active);

    for (int i = 0; i <= 5; i++) {
      final x = 18 + ((size.width - 36) * (i / 5));
      final done = (i / 5) <= progress;
      canvas.drawCircle(Offset(x, y), 6, Paint()..color = done ? color : const Color(0xFF92A9BD));
    }
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.progress != progress;
  }
}

class _SurfacePanel extends StatelessWidget {
  const _SurfacePanel({required this.showGuide, required this.child});

  final bool showGuide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final s = AppStateScope.watch(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: s.frame),
        gradient: const LinearGradient(
          colors: [Color(0xFFF9FCFF), Color(0xFFEFF5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGuide) const CustomPaint(painter: _GuidePainter()),
          child,
        ],
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
  const _GuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x11000000);
    const gap = 23.0;
    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SnapshotTable extends StatelessWidget {
  const _SnapshotTable({required this.data, required this.title});

  final AppStateSnapshot data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: _mutedBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          _DataRow(label: 'accent', value: '#${data.accent.toARGB32().toRadixString(16).toUpperCase()}'),
          _DataRow(label: 'surface', value: '#${data.surface.toARGB32().toRadixString(16).toUpperCase()}'),
          _DataRow(label: 'counter', value: '${data.counter}'),
          _DataRow(label: 'density', value: data.density.toStringAsFixed(2)),
          _DataRow(label: 'energy', value: data.energy.toStringAsFixed(2)),
          _DataRow(label: 'message', value: data.message),
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

class _TinyInfo extends StatelessWidget {
  const _TinyInfo({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          SizedBox(width: 54, child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 10))),
        ],
      ),
    );
  }
}

class _DualBar extends StatelessWidget {
  const _DualBar({required this.density, required this.energy, required this.color});

  final double density;
  final double energy;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SimpleBar(value: density, color: color, label: 'density'),
        const SizedBox(height: 4),
        _SimpleBar(value: energy, color: color, label: 'energy'),
      ],
    );
  }
}

class _SimpleBar extends StatelessWidget {
  const _SimpleBar({required this.value, required this.color, required this.label});

  final double value;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 56, child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700))),
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: value.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
        ),
      ],
    );
  }
}

class _LineBullet extends StatelessWidget {
  const _LineBullet({required this.text});

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
            child: Icon(Icons.circle, size: 7, color: Color(0xFF3E5F7C)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
        ],
      ),
    );
  }
}

class _EventBoard extends StatelessWidget {
  const _EventBoard({required this.events});

  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFEFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD5E1EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Global interaction log', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No interactions yet.', style: TextStyle(color: Color(0xFF607487)))
          else
            ...events.map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(line, style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
              ),
            ),
        ],
      ),
    );
  }
}

class _RecapSection extends StatelessWidget {
  const _RecapSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF15344E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: When to use InheritedWidget', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text(
            'Use InheritedWidget to distribute immutable snapshots to broad subtrees with efficient dependency tracking. '
            'Rebuild the scope ancestor with a new snapshot when state changes. Descendants that depend on the scope rebuild automatically, '
            'while read-only and static widgets remain stable by design.',
            style: TextStyle(color: Color(0xFFD8E6F4), height: 1.36),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _mutedBox() {
  return BoxDecoration(
    color: const Color(0xFFF2F7FC),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: const Color(0xFFD7E2EE)),
  );
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
