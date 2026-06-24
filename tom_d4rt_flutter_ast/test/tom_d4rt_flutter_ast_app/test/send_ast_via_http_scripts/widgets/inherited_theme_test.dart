import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

const _cInk = Color(0xFF173752);
const _cBlue = Color(0xFF31759F);
const _cTeal = Color(0xFF318C7B);
const _cAmber = Color(0xFFBC8A44);
const _cRose = Color(0xFF9B5F79);
const _cViolet = Color(0xFF645EA8);
const _cOlive = Color(0xFF747C42);

dynamic build(BuildContext context) {
  return const _InheritedThemeDeepDemoApp();
}

class _InheritedThemeDeepDemoApp extends StatelessWidget {
  const _InheritedThemeDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cBlue),
        scaffoldBackgroundColor: const Color(0xFFF2F6FA),
      ),
      home: const _InheritedThemeDeepDemoPage(),
    );
  }
}

class _InheritedThemeDeepDemoPage extends StatefulWidget {
  const _InheritedThemeDeepDemoPage();

  @override
  State<_InheritedThemeDeepDemoPage> createState() => _InheritedThemeDeepDemoPageState();
}

class _InheritedThemeDeepDemoPageState extends State<_InheritedThemeDeepDemoPage> {
  bool _compact = false;
  bool _showGrid = true;
  bool _showLabels = true;
  bool _rtl = false;
  double _scale = 1.0;

  PanelThemeData _root = const PanelThemeData(
    accent: _cBlue,
    surface: Color(0xFFF5FAFF),
    border: Color(0xFFB5CCE2),
    glow: Color(0x5530759E),
    cornerRadius: 12,
    density: 0.60,
  );

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
      child: PanelTheme(
        data: _root,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: _cInk,
            foregroundColor: Colors.white,
            toolbarHeight: 84,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('InheritedTheme Deep Demo'),
                const SizedBox(height: 2),
                Text(
                  'Root accent: #${_root.accent.toARGB32().toRadixString(16).toUpperCase()} | radius ${_root.cornerRadius.toStringAsFixed(1)} | density ${_root.density.toStringAsFixed(2)}',
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
                _TopDeck(
                  compact: _compact,
                  showGrid: _showGrid,
                  showLabels: _showLabels,
                  rtl: _rtl,
                  scale: _scale,
                  root: _root,
                  onCompactChanged: (v) => setState(() => _compact = v),
                  onShowGridChanged: (v) => setState(() => _showGrid = v),
                  onShowLabelsChanged: (v) => setState(() => _showLabels = v),
                  onRtlChanged: (v) => setState(() => _rtl = v),
                  onScaleChanged: (v) => setState(() => _scale = v),
                  onRootRandomize: () => setState(() => _root = _root.randomized()),
                  onRootReset: () => setState(
                    () => _root = const PanelThemeData(
                      accent: _cBlue,
                      surface: Color(0xFFF5FAFF),
                      border: Color(0xFFB5CCE2),
                      glow: Color(0x5530759E),
                      cornerRadius: 12,
                      density: 0.60,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 1,
                  accent: _cBlue,
                  title: 'InheritedTheme Fundamentals',
                  subtitle:
                      'Custom InheritedTheme implementation, dependency access, and inherited appearance propagation through the subtree.',
                  child: _FundamentalsScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 2,
                  accent: _cTeal,
                  title: 'Nested Override Layers',
                  subtitle:
                      'Demonstrates local theme overrides while preserving root defaults outside nested zones.',
                  child: _LayeredOverridesScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 3,
                  accent: _cAmber,
                  title: 'captureAll Transfer Lab',
                  subtitle:
                      'Uses InheritedTheme.captureAll to preserve source inherited themes when moving a child into a foreign theme subtree.',
                  child: _CaptureAllScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 4,
                  accent: _cRose,
                  title: 'Rebuild and Dependency Behavior',
                  subtitle:
                      'Compares watcher cards versus static/read-once cards to highlight inherited dependency rebuild behavior.',
                  child: _RebuildBehaviorScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 5,
                  accent: _cViolet,
                  title: 'Dynamic Theme Timeline',
                  subtitle:
                      'Animated theme mutation with IndexedStack panels to visualize inherited updates across hidden/visible views.',
                  child: _DynamicTimelineScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 6,
                  accent: _cOlive,
                  title: 'Practical Workspace Composition',
                  subtitle:
                      'Realistic multi-panel board using inherited theme scopes for consistent visual language with localized overrides.',
                  child: _PracticalWorkspaceScene(config: config),
                ),
                const SizedBox(height: 12),
                const _RecapPanel(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class PanelThemeData {
  const PanelThemeData({
    required this.accent,
    required this.surface,
    required this.border,
    required this.glow,
    required this.cornerRadius,
    required this.density,
  });

  final Color accent;
  final Color surface;
  final Color border;
  final Color glow;
  final double cornerRadius;
  final double density;

  PanelThemeData copyWith({
    Color? accent,
    Color? surface,
    Color? border,
    Color? glow,
    double? cornerRadius,
    double? density,
  }) {
    return PanelThemeData(
      accent: accent ?? this.accent,
      surface: surface ?? this.surface,
      border: border ?? this.border,
      glow: glow ?? this.glow,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      density: density ?? this.density,
    );
  }

  static PanelThemeData lerp(PanelThemeData a, PanelThemeData b, double t) {
    return PanelThemeData(
      accent: Color.lerp(a.accent, b.accent, t) ?? a.accent,
      surface: Color.lerp(a.surface, b.surface, t) ?? a.surface,
      border: Color.lerp(a.border, b.border, t) ?? a.border,
      glow: Color.lerp(a.glow, b.glow, t) ?? a.glow,
      cornerRadius: a.cornerRadius + ((b.cornerRadius - a.cornerRadius) * t),
      density: a.density + ((b.density - a.density) * t),
    );
  }

  PanelThemeData randomized() {
    final random = math.Random(DateTime.now().microsecondsSinceEpoch);
    final h = random.nextDouble() * 360;
    final accentHsl = HSLColor.fromAHSL(1, h, 0.52, 0.44);
    final accentColor = accentHsl.toColor();
    final surfaceColor = HSLColor.fromAHSL(1, h, 0.45, 0.95).toColor();
    final borderColor = HSLColor.fromAHSL(1, h, 0.34, 0.72).toColor();
    final glowColor = accentColor.withValues(alpha: 0.35);
    return copyWith(
      accent: accentColor,
      surface: surfaceColor,
      border: borderColor,
      glow: glowColor,
      cornerRadius: 8 + random.nextDouble() * 18,
      density: 0.30 + random.nextDouble() * 0.55,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PanelThemeData &&
        other.accent == accent &&
        other.surface == surface &&
        other.border == border &&
        other.glow == glow &&
        other.cornerRadius == cornerRadius &&
        other.density == density;
  }

  @override
  int get hashCode => Object.hash(accent, surface, border, glow, cornerRadius, density);
}

class PanelTheme extends InheritedTheme {
  const PanelTheme({super.key, required this.data, required super.child});

  final PanelThemeData data;

  static PanelThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<PanelTheme>();
    if (theme == null) {
      throw FlutterError('PanelTheme.of called with no PanelTheme in context.');
    }
    return theme.data;
  }

  static PanelThemeData read(BuildContext context) {
    final theme = context.getInheritedWidgetOfExactType<PanelTheme>();
    if (theme == null) {
      throw FlutterError('PanelTheme.read called with no PanelTheme in context.');
    }
    return theme.data;
  }

  @override
  bool updateShouldNotify(covariant PanelTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return PanelTheme(data: data, child: child);
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

class _TopDeck extends StatelessWidget {
  const _TopDeck({
    required this.compact,
    required this.showGrid,
    required this.showLabels,
    required this.rtl,
    required this.scale,
    required this.root,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onShowLabelsChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
    required this.onRootRandomize,
    required this.onRootReset,
  });

  final bool compact;
  final bool showGrid;
  final bool showLabels;
  final bool rtl;
  final double scale;
  final PanelThemeData root;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<bool> onShowLabelsChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;
  final VoidCallback onRootRandomize;
  final VoidCallback onRootReset;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF173A55), Color(0xFF2A6F83), Color(0xFF5B5CA4)],
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
              'InheritedTheme Control Deck',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'This demo uses a custom InheritedTheme to show dependency-aware theme propagation, captureAll behavior, nested overrides, and practical app composition patterns.',
              style: TextStyle(color: Color(0xFFE6EFF9), height: 1.35),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: compact,
                    onChanged: onCompactChanged,
                    title: const Text('Compact', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  ),
                ),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: showGrid,
                    onChanged: onShowGridChanged,
                    title: const Text('Guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  ),
                ),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: showLabels,
                    onChanged: onShowLabelsChanged,
                    title: const Text('Labels', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  ),
                ),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: rtl,
                    onChanged: onRtlChanged,
                    title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('Global scale: ${scale.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
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
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: _DeckMetric(label: 'accent', value: '#${root.accent.toARGB32().toRadixString(16).toUpperCase()}'),
                ),
                const SizedBox(width: 8),
                Expanded(child: _DeckMetric(label: 'radius', value: root.cornerRadius.toStringAsFixed(1))),
                const SizedBox(width: 8),
                Expanded(child: _DeckMetric(label: 'density', value: root.density.toStringAsFixed(2))),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton.tonal(
                          onPressed: onRootRandomize,
                          style: FilledButton.styleFrom(foregroundColor: Colors.white),
                          child: const Text('Randomize'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onRootReset,
                          style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white70)),
                          child: const Text('Reset'),
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

class _DeckMetric extends StatelessWidget {
  const _DeckMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700)),
          const SizedBox(height: 1),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
        ],
      ),
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

class _FundamentalsScene extends StatefulWidget {
  const _FundamentalsScene({required this.config});

  final _DemoConfig config;

  @override
  State<_FundamentalsScene> createState() => _FundamentalsSceneState();
}

class _FundamentalsSceneState extends State<_FundamentalsScene> {
  bool _showBounds = true;
  bool _showLabels = true;
  int _view = 0;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final root = PanelTheme.of(context);

    return SizedBox(
      height: config.compact ? 580 : 680,
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
                      const Text('Fundamental controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(value: 0, label: Text('Tree')),
                          ButtonSegment(value: 1, label: Text('Cards')),
                          ButtonSegment(value: 2, label: Text('Bars')),
                        ],
                        selected: {_view},
                        onSelectionChanged: (v) => setState(() => _view = v.first),
                      ),
                      const SizedBox(height: 8),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _showBounds,
                        onChanged: (v) => setState(() => _showBounds = v),
                        title: const Text('Show panel bounds'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _showLabels,
                        onChanged: (v) => setState(() => _showLabels = v),
                        title: const Text('Show role labels'),
                      ),
                      ),
                      const SizedBox(height: 8),
                      _ThemeInfoTable(data: root),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _softBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Core principles', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _BulletText(text: 'InheritedTheme is still an InheritedWidget with notifier-less semantics by default.'),
                            _BulletText(text: 'wrap() enables theme re-application when subtree is moved.'),
                            _BulletText(text: 'captureAll() snapshots inherited themes from one context and wraps another child.'),
                            _BulletText(text: 'Use Theme-like classes for predictable, reusable visual contracts.'),
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
                child: IndexedStack(
                  index: _view,
                  children: [
                    _ThemeTreePreview(showBounds: _showBounds, showLabels: _showLabels),
                    _ThemeCardsPreview(showBounds: _showBounds),
                    _ThemeBarsPreview(showLabels: _showLabels),
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

class _ThemeTreePreview extends StatelessWidget {
  const _ThemeTreePreview({required this.showBounds, required this.showLabels});

  final bool showBounds;
  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    final root = PanelTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: root.surface,
        borderRadius: BorderRadius.circular(root.cornerRadius),
        border: Border.all(color: showBounds ? root.border : root.border.withValues(alpha: 0.22), width: showBounds ? 2 : 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showLabels)
              Text('Root PanelTheme', style: TextStyle(color: root.accent, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _MiniThemeNode(
                      title: 'Root Node',
                      data: root,
                      showLabel: showLabels,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: PanelTheme(
                      data: root.copyWith(
                        accent: _cTeal,
                        surface: const Color(0xFFF0FBF8),
                        border: const Color(0xFF9AD0C2),
                      ),
                      child: const _MiniThemeNode(
                        title: 'Nested Override',
                        showLabel: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: PanelTheme(
                      data: root.copyWith(
                        accent: _cRose,
                        surface: const Color(0xFFFCF4F7),
                        border: const Color(0xFFD8A5BD),
                      ),
                      child: const _MiniThemeNode(
                        title: 'Alternate Branch',
                        showLabel: true,
                      ),
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

class _MiniThemeNode extends StatelessWidget {
  const _MiniThemeNode({required this.title, this.data, required this.showLabel});

  final String title;
  final PanelThemeData? data;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final d = data ?? PanelTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: d.surface,
        borderRadius: BorderRadius.circular(d.cornerRadius),
        border: Border.all(color: d.border),
        boxShadow: [
          BoxShadow(color: d.glow.withValues(alpha: 0.22), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLabel)
            Text(title, style: TextStyle(color: d.accent, fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 6),
          _StatPill(label: 'radius', value: d.cornerRadius.toStringAsFixed(1), color: d.accent),
          const SizedBox(height: 6),
          _StatPill(label: 'density', value: d.density.toStringAsFixed(2), color: d.accent),
          const Spacer(),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: d.accent.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: d.density.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(color: d.accent, borderRadius: BorderRadius.circular(999)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeCardsPreview extends StatelessWidget {
  const _ThemeCardsPreview({required this.showBounds});

  final bool showBounds;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.05,
      children: List<Widget>.generate(
        6,
        (i) {
          final d = PanelTheme.of(context);
          final tone = HSLColor.fromColor(d.accent).withHue((HSLColor.fromColor(d.accent).hue + (i * 14)) % 360).toColor();
          return PanelTheme(
            data: d.copyWith(
              accent: tone,
              border: tone.withValues(alpha: 0.4),
              surface: Color.lerp(Colors.white, tone, 0.08)!,
            ),
            child: _CardThemeTile(index: i, showBounds: showBounds),
          );
        },
      ),
    );
  }
}

class _CardThemeTile extends StatelessWidget {
  const _CardThemeTile({required this.index, required this.showBounds});

  final int index;
  final bool showBounds;

  @override
  Widget build(BuildContext context) {
    final d = PanelTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: d.surface,
        borderRadius: BorderRadius.circular(d.cornerRadius),
        border: Border.all(color: d.border, width: showBounds ? 2 : 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tile ${index + 1}', style: TextStyle(color: d.accent, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(d.cornerRadius * 0.7),
                border: Border.all(color: d.accent.withValues(alpha: 0.22)),
              ),
              child: Center(
                child: Icon(Icons.palette_rounded, color: d.accent),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text('density ${d.density.toStringAsFixed(2)}', style: TextStyle(fontSize: 11, color: d.accent.withValues(alpha: 0.85))),
        ],
      ),
    );
  }
}

class _ThemeBarsPreview extends StatelessWidget {
  const _ThemeBarsPreview({required this.showLabels});

  final bool showLabels;

  @override
  Widget build(BuildContext context) {
    final d = PanelTheme.of(context);
    return Column(
      children: List<Widget>.generate(7, (i) {
        final ratio = ((i + 2) / 10).clamp(0.0, 1.0);
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: d.surface,
                borderRadius: BorderRadius.circular(d.cornerRadius),
                border: Border.all(color: d.border),
              ),
              child: Row(
                children: [
                  if (showLabels)
                    SizedBox(
                      width: 120,
                      child: Text('Segment ${i + 1}', style: TextStyle(color: d.accent, fontWeight: FontWeight.w700)),
                    ),
                  Expanded(
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: d.accent.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: ratio,
                        child: Container(
                          decoration: BoxDecoration(
                            color: d.accent,
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
    );
  }
}

class _LayeredOverridesScene extends StatefulWidget {
  const _LayeredOverridesScene({required this.config});

  final _DemoConfig config;

  @override
  State<_LayeredOverridesScene> createState() => _LayeredOverridesSceneState();
}

class _LayeredOverridesSceneState extends State<_LayeredOverridesScene> {
  bool _enableMiddle = true;
  bool _enableInner = true;
  bool _showBorders = true;

  @override
  Widget build(BuildContext context) {
    final root = PanelTheme.of(context);
    final config = widget.config;

    final middle = root.copyWith(
      accent: _cTeal,
      surface: const Color(0xFFF0FBF8),
      border: const Color(0xFF95D0C1),
      glow: const Color(0x55318C7B),
      cornerRadius: root.cornerRadius + 4,
      density: (root.density + 0.08).clamp(0.0, 1.0),
    );

    final inner = root.copyWith(
      accent: _cRose,
      surface: const Color(0xFFFCF4F7),
      border: const Color(0xFFD8A4BC),
      glow: const Color(0x559A5D78),
      cornerRadius: root.cornerRadius + 8,
      density: (root.density + 0.14).clamp(0.0, 1.0),
    );

    return SizedBox(
      height: config.compact ? 620 : 740,
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
                      const Text('Override toggles', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _enableMiddle,
                        onChanged: (v) => setState(() => _enableMiddle = v),
                        title: const Text('Enable middle theme layer'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _enableInner,
                        onChanged: (v) => setState(() => _enableInner = v),
                        title: const Text('Enable inner theme layer'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _showBorders,
                        onChanged: (v) => setState(() => _showBorders = v),
                        title: const Text('Show layer border emphasis'),
                      ),
                      ),
                      const SizedBox(height: 8),
                      _ThemeInfoTable(data: root, title: 'Root data'),
                      const SizedBox(height: 8),
                      _ThemeInfoTable(data: middle, title: 'Middle override data'),
                      const SizedBox(height: 8),
                      _ThemeInfoTable(data: inner, title: 'Inner override data'),
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
                child: _layer(
                  data: root,
                  borderColor: _showBorders ? root.border : Colors.transparent,
                  label: 'Root Layer',
                  child: _enableMiddle
                      ? _layer(
                          data: middle,
                          borderColor: _showBorders ? middle.border : Colors.transparent,
                          label: 'Middle Layer',
                          child: _enableInner
                              ? _layer(
                                  data: inner,
                                  borderColor: _showBorders ? inner.border : Colors.transparent,
                                  label: 'Inner Layer',
                                  child: const _LayerProbeGrid(),
                                )
                              : const _LayerProbeGrid(),
                        )
                      : const _LayerProbeGrid(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _layer({
    required PanelThemeData data,
    required Color borderColor,
    required String label,
    required Widget child,
  }) {
    return PanelTheme(
      data: data,
      child: Builder(
        builder: (context) {
          final d = PanelTheme.of(context);
          return Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: d.surface,
              borderRadius: BorderRadius.circular(d.cornerRadius),
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: d.accent, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Expanded(child: child),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LayerProbeGrid extends StatelessWidget {
  const _LayerProbeGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.15,
      children: List<Widget>.generate(
        6,
        (i) => _LayerProbeCard(index: i),
      ),
    );
  }
}

class _LayerProbeCard extends StatelessWidget {
  const _LayerProbeCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final d = PanelTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(d.cornerRadius * 0.72),
        border: Border.all(color: d.accent.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Probe ${index + 1}', style: TextStyle(color: d.accent, fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 6),
          Expanded(
            child: Center(
              child: Icon(Icons.layers_rounded, color: d.accent, size: 26),
            ),
          ),
          Text('radius ${d.cornerRadius.toStringAsFixed(1)}', style: TextStyle(fontSize: 11, color: d.accent.withValues(alpha: 0.85))),
        ],
      ),
    );
  }
}

class _CaptureAllScene extends StatefulWidget {
  const _CaptureAllScene({required this.config});

  final _DemoConfig config;

  @override
  State<_CaptureAllScene> createState() => _CaptureAllSceneState();
}

class _CaptureAllSceneState extends State<_CaptureAllScene> {
  bool _preserve = true;
  bool _foreignTint = true;
  bool _showWire = true;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final root = PanelTheme.of(context);

    final sourceData = root.copyWith(
      accent: _cViolet,
      surface: const Color(0xFFF4F2FF),
      border: const Color(0xFFB0A6E0),
      glow: const Color(0x55645EA8),
      cornerRadius: root.cornerRadius + 4,
      density: (root.density + 0.10).clamp(0.0, 1.0),
    );

    final foreignData = root.copyWith(
      accent: _foreignTint ? _cOlive : _cBlue,
      surface: _foreignTint ? const Color(0xFFF7F9EE) : const Color(0xFFF4F8FC),
      border: _foreignTint ? const Color(0xFFC7D19E) : const Color(0xFFABC6DD),
      cornerRadius: root.cornerRadius + 2,
    );

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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('captureAll controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _preserve,
                        onChanged: (v) => setState(() => _preserve = v),
                        title: const Text('Preserve source inherited theme using captureAll'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _foreignTint,
                        onChanged: (v) => setState(() => _foreignTint = v),
                        title: const Text('Use olive foreign target theme'),
                      ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: SwitchListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: _showWire,
                        onChanged: (v) => setState(() => _showWire = v),
                        title: const Text('Show transfer wire overlay'),
                      ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _softBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('How to read this scene', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _BulletText(text: 'Left side defines source context with a violet local PanelTheme.'),
                            _BulletText(text: 'Right side is wrapped by a foreign target theme.'),
                            _BulletText(text: 'Without captureAll, moved child resolves foreign target theme.'),
                            _BulletText(text: 'With captureAll, moved child keeps source inherited theme.'),
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
                child: Builder(
                  builder: (outerContext) {
                    return PanelTheme(
                      data: sourceData,
                      child: Builder(
                        builder: (sourceContext) {
                          final moved = _preserve
                              ? InheritedTheme.captureAll(sourceContext, const _TransferPayload())
                              : const _TransferPayload();

                          return Stack(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _transferZone(
                                      title: 'Source Zone',
                                      note: 'Violet source inherited theme',
                                      child: const _TransferPayload(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: PanelTheme(
                                      data: foreignData,
                                      child: _transferZone(
                                        title: 'Foreign Target Zone',
                                        note: 'Moved payload inserted here',
                                        child: moved,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (_showWire)
                                const Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 130,
                                  child: IgnorePointer(
                                    child: _TransferWire(),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transferZone({required String title, required String note, required Widget child}) {
    return Builder(
      builder: (context) {
        final d = PanelTheme.of(context);
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: d.surface,
            borderRadius: BorderRadius.circular(d.cornerRadius),
            border: Border.all(color: d.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: d.accent, fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text(note, style: TextStyle(color: d.accent.withValues(alpha: 0.82), fontSize: 12)),
              const SizedBox(height: 8),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}

class _TransferPayload extends StatelessWidget {
  const _TransferPayload();

  @override
  Widget build(BuildContext context) {
    final d = PanelTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(d.cornerRadius * 0.8),
        border: Border.all(color: d.accent.withValues(alpha: 0.30)),
        boxShadow: [
          BoxShadow(color: d.glow.withValues(alpha: 0.30), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Moved Child', style: TextStyle(color: d.accent, fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 8),
          _InfoRow(label: 'accent', value: '#${d.accent.toARGB32().toRadixString(16).toUpperCase()}'),
          _InfoRow(label: 'radius', value: d.cornerRadius.toStringAsFixed(1)),
          _InfoRow(label: 'density', value: d.density.toStringAsFixed(2)),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 10,
            decoration: BoxDecoration(
              color: d.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: d.density.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(color: d.accent, borderRadius: BorderRadius.circular(999)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransferWire extends StatelessWidget {
  const _TransferWire();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: CustomPaint(
        painter: _WirePainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _WirePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0x804E6A80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.28, size.height * 0.5)
      ..cubicTo(size.width * 0.40, 0, size.width * 0.60, size.height, size.width * 0.72, size.height * 0.5);
    canvas.drawPath(path, p);

    final arrow = Paint()..color = const Color(0xAA4E6A80);
    final tip = Offset(size.width * 0.72, size.height * 0.5);
    final wingA = Offset(tip.dx - 8, tip.dy - 5);
    final wingB = Offset(tip.dx - 8, tip.dy + 5);
    final arrowPath = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(wingA.dx, wingA.dy)
      ..lineTo(wingB.dx, wingB.dy)
      ..close();
    canvas.drawPath(arrowPath, arrow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RebuildBehaviorScene extends StatefulWidget {
  const _RebuildBehaviorScene({required this.config});

  final _DemoConfig config;

  @override
  State<_RebuildBehaviorScene> createState() => _RebuildBehaviorSceneState();
}

class _RebuildBehaviorSceneState extends State<_RebuildBehaviorScene> {
  int _localBuildKick = 0;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final root = PanelTheme.read(context);

    return SizedBox(
      height: config.compact ? 650 : 770,
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
                    const Text('Rebuild controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    FilledButton.tonal(
                      onPressed: () {
                        setState(() => _localBuildKick += 1);
                      },
                      child: Text('Parent setState kick ($_localBuildKick)'),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () {
                              final pageState = context.findAncestorStateOfType<_InheritedThemeDeepDemoPageState>();
                              if (pageState != null) {
                                pageState.setState(() {
                                  pageState._root = pageState._root.copyWith(
                                    density: (pageState._root.density + 0.05).clamp(0.0, 1.0),
                                  );
                                });
                              }
                            },
                            child: const Text('Root density +'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton.tonal(
                            onPressed: () {
                              final pageState = context.findAncestorStateOfType<_InheritedThemeDeepDemoPageState>();
                              if (pageState != null) {
                                pageState.setState(() {
                                  pageState._root = pageState._root.copyWith(
                                    accent: HSLColor.fromColor(pageState._root.accent)
                                        .withHue((HSLColor.fromColor(pageState._root.accent).hue + 16) % 360)
                                        .toColor(),
                                  );
                                });
                              }
                            },
                            child: const Text('Root hue shift'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _ThemeInfoTable(data: root, title: 'Current root data'),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _softBox(),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Observation checklist', style: TextStyle(fontWeight: FontWeight.w800)),
                          SizedBox(height: 6),
                          _BulletText(text: 'watch cards rebuild on root theme changes.'),
                          _BulletText(text: 'read-once card updates only when refresh is pressed.'),
                          _BulletText(text: 'static card only follows parent local setState.'),
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
                child: Column(
                  children: const [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _WatchBuildCard(title: 'Watch Card A', tone: _cBlue)),
                          SizedBox(width: 8),
                          Expanded(child: _WatchBuildCard(title: 'Watch Card B', tone: _cTeal)),
                          SizedBox(width: 8),
                          Expanded(child: _ReadBuildCard(title: 'Read Card', tone: _cAmber)),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _StaticBuildCard(title: 'Static Card', tone: _cViolet)),
                          SizedBox(width: 8),
                          Expanded(child: _WatchBuildCard(title: 'Watch Card C', tone: _cRose)),
                          SizedBox(width: 8),
                          Expanded(child: _WatchBuildCard(title: 'Watch Card D', tone: _cOlive)),
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

class _WatchBuildCard extends StatelessWidget {
  const _WatchBuildCard({required this.title, required this.tone});

  final String title;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return _BuildCardShell(
      title: title,
      tone: tone,
      mode: 'watch',
      builder: (context, builds) {
        final d = PanelTheme.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('builds: $builds', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('accent: #${d.accent.toARGB32().toRadixString(16).toUpperCase()}', style: const TextStyle(fontSize: 11)),
            Text('radius: ${d.cornerRadius.toStringAsFixed(1)}', style: const TextStyle(fontSize: 11)),
            Text('density: ${d.density.toStringAsFixed(2)}', style: const TextStyle(fontSize: 11)),
            const Spacer(),
            _DensityBar(value: d.density, color: d.accent),
          ],
        );
      },
    );
  }
}

class _ReadBuildCard extends StatefulWidget {
  const _ReadBuildCard({required this.title, required this.tone});

  final String title;
  final Color tone;

  @override
  State<_ReadBuildCard> createState() => _ReadBuildCardState();
}

class _ReadBuildCardState extends State<_ReadBuildCard> {
  String _snapshot = 'tap refresh';

  @override
  Widget build(BuildContext context) {
    return _BuildCardShell(
      title: widget.title,
      tone: widget.tone,
      mode: 'read',
      builder: (context, builds) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('builds: $builds', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(_snapshot, style: const TextStyle(fontSize: 11, height: 1.3)),
            const Spacer(),
            FilledButton.tonal(
              onPressed: () {
                final d = PanelTheme.read(context);
                setState(() {
                  _snapshot = 'accent=${d.accent.toARGB32().toRadixString(16)}\n'
                      'radius=${d.cornerRadius.toStringAsFixed(1)} density=${d.density.toStringAsFixed(2)}';
                });
              },
              child: const Text('Refresh read snapshot'),
            ),
          ],
        );
      },
    );
  }
}

class _StaticBuildCard extends StatelessWidget {
  const _StaticBuildCard({required this.title, required this.tone});

  final String title;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return _BuildCardShell(
      title: title,
      tone: tone,
      mode: 'static',
      builder: (context, builds) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('builds: $builds', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('No inherited dependency.', style: TextStyle(fontSize: 11)),
            const Text('Rebuild only on parent rebuilds.', style: TextStyle(fontSize: 11)),
            const Spacer(),
            Icon(Icons.do_not_disturb_alt_rounded, color: tone, size: 28),
          ],
        );
      },
    );
  }
}

class _BuildCardShell extends StatefulWidget {
  const _BuildCardShell({
    required this.title,
    required this.tone,
    required this.mode,
    required this.builder,
  });

  final String title;
  final Color tone;
  final String mode;
  final Widget Function(BuildContext context, int builds) builder;

  @override
  State<_BuildCardShell> createState() => _BuildCardShellState();
}

class _BuildCardShellState extends State<_BuildCardShell> {
  int _builds = 0;

  @override
  Widget build(BuildContext context) {
    _builds += 1;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.tone.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.34)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(widget.mode, style: TextStyle(color: widget.tone.withValues(alpha: 0.82), fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 8),
          Expanded(child: widget.builder(context, _builds)),
        ],
      ),
    );
  }
}

class _DensityBar extends StatelessWidget {
  const _DensityBar({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10,
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
    );
  }
}

class _DynamicTimelineScene extends StatefulWidget {
  const _DynamicTimelineScene({required this.config});

  final _DemoConfig config;

  @override
  State<_DynamicTimelineScene> createState() => _DynamicTimelineSceneState();
}

class _DynamicTimelineSceneState extends State<_DynamicTimelineScene> {
  late final Timer _timer;
  int _index = 0;
  bool _running = true;
  bool _freezeViews = false;
  double _phase = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!mounted || !_running) {
        return;
      }
      setState(() {
        _phase += 0.03;
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
    final config = widget.config;
    final root = PanelTheme.of(context);

    final animated = root.copyWith(
      accent: HSLColor.fromColor(root.accent).withHue((HSLColor.fromColor(root.accent).hue + (_phase * 360)) % 360).toColor(),
      cornerRadius: 8 + ((math.sin(_phase * math.pi * 2) + 1) * 7),
      density: (0.35 + ((math.cos(_phase * math.pi * 2) + 1) * 0.30)).clamp(0.0, 1.0),
    );

    return SizedBox(
      height: config.compact ? 690 : 830,
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
                    const Text('Dynamic controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 0, label: Text('A')),
                        ButtonSegment(value: 1, label: Text('B')),
                        ButtonSegment(value: 2, label: Text('C')),
                      ],
                      selected: {_index},
                      onSelectionChanged: (v) => setState(() => _index = v.first),
                    ),
                    const SizedBox(height: 8),
                    Material(
                      type: MaterialType.transparency,
                      child: SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _running,
                      onChanged: (v) => setState(() => _running = v),
                      title: const Text('Run dynamic theme animation'),
                    ),
                    ),
                    Material(
                      type: MaterialType.transparency,
                      child: SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _freezeViews,
                      onChanged: (v) => setState(() => _freezeViews = v),
                      title: const Text('Freeze content animations in panels'),
                    ),
                    ),
                    const SizedBox(height: 8),
                    _ThemeInfoTable(data: animated, title: 'Animated inherited data'),
                    const SizedBox(height: 8),
                    _LabeledSlider(
                      label: 'Manual phase',
                      value: _phase % 1,
                      min: 0,
                      max: 1,
                      onChanged: (v) => setState(() => _phase = v),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: PanelTheme(
              data: animated,
              child: _BackdropPanel(
                showGrid: config.showGrid,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: IndexedStack(
                    index: _index,
                    children: [
                      _AnimatedThemePanel(name: 'Panel A', freeze: _freezeViews),
                      _AnimatedThemePanel(name: 'Panel B', freeze: _freezeViews),
                      _AnimatedThemePanel(name: 'Panel C', freeze: _freezeViews),
                    ],
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

class _AnimatedThemePanel extends StatefulWidget {
  const _AnimatedThemePanel({required this.name, required this.freeze});

  final String name;
  final bool freeze;

  @override
  State<_AnimatedThemePanel> createState() => _AnimatedThemePanelState();
}

class _AnimatedThemePanelState extends State<_AnimatedThemePanel> {
  late final Timer _timer;
  double _pulse = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 550), (_) {
      if (!mounted || widget.freeze) {
        return;
      }
      setState(() {
        _pulse += 0.15;
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
    final d = PanelTheme.of(context);
    final wave = (math.sin(_pulse) + 1) * 0.5;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: d.surface,
        borderRadius: BorderRadius.circular(d.cornerRadius),
        border: Border.all(color: d.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name, style: TextStyle(color: d.accent, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          _InfoRow(label: 'radius', value: d.cornerRadius.toStringAsFixed(1)),
          _InfoRow(label: 'density', value: d.density.toStringAsFixed(2)),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.1,
              children: List<Widget>.generate(
                6,
                (i) {
                  final factor = (((i + 1) / 6) * 0.7) + (wave * 0.3);
                  return Container(
                    decoration: BoxDecoration(
                      color: d.accent.withValues(alpha: factor.clamp(0.08, 0.95)),
                      borderRadius: BorderRadius.circular(d.cornerRadius * 0.65),
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
      _WorkspaceMetrics(onEvent: _log),
      _WorkspaceTasks(onEvent: _log),
      _WorkspaceTimeline(onEvent: _log),
      _WorkspaceLogs(onEvent: _log),
    ];
  }

  void _log(String line) {
    setState(() {
      _events.insert(0, '${_clock()} | $line');
      if (_events.length > 30) {
        _events.removeRange(30, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final root = PanelTheme.of(context);
    final labels = ['Metrics', 'Tasks', 'Timeline', 'Logs'];

    final workspaceTheme = root.copyWith(
      accent: _highContrast ? const Color(0xFFDDEEFF) : _cOlive,
      surface: _highContrast ? const Color(0xFF1D2832) : const Color(0xFFF8FBF2),
      border: _highContrast ? const Color(0xFF3D4E5E) : const Color(0xFFC4D09E),
      glow: _highContrast ? const Color(0x33263644) : const Color(0x55747C42),
      cornerRadius: root.cornerRadius + 2,
    );

    return SizedBox(
      height: config.compact ? 860 : 1040,
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
                            _log('workspace -> ${labels[i]}');
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
                      child: PanelTheme(
                        data: workspaceTheme,
                        child: Builder(
                          builder: (context) {
                            final d = PanelTheme.of(context);
                            final fg = _highContrast ? Colors.white : _cInk;

                            return Container(
                              decoration: BoxDecoration(
                                color: d.surface,
                                borderRadius: BorderRadius.circular(d.cornerRadius),
                                border: Border.all(color: d.border),
                              ),
                              child: Column(
                                children: [
                                  _workspaceTopBar(fg),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        _workspaceRail(labels, fg),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              if (_showMeta) _workspaceMeta(fg),
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
                                  _workspaceFooter(fg),
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
            child: _EventPanel(title: 'Workspace log', events: _events),
          ),
        ],
      ),
    );
  }

  Widget _workspaceTopBar(Color fg) {
    final d = PanelTheme.of(context);
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: d.accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.vertical(top: Radius.circular(d.cornerRadius)),
      ),
      child: Row(
        children: [
          Icon(Icons.layers_rounded, color: d.accent),
          const SizedBox(width: 8),
          Text('Theme Workspace', style: TextStyle(color: fg, fontWeight: FontWeight.w800, fontSize: 18)),
          const Spacer(),
          Text('shared inherited style contract', style: TextStyle(color: fg.withValues(alpha: 0.82), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _workspaceRail(List<String> labels, Color fg) {
    final d = PanelTheme.of(context);
    return Container(
      width: _compactRail ? 72 : 110,
      decoration: BoxDecoration(
        color: d.accent.withValues(alpha: 0.08),
        border: Border(right: BorderSide(color: d.border)),
      ),
      child: ListView.builder(
        itemCount: labels.length,
        itemBuilder: (context, index) {
          final selected = _index == index;
          return InkWell(
            onTap: () {
              setState(() => _index = index);
              _log('rail -> ${labels[index]}');
            },
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              decoration: BoxDecoration(
                color: selected ? d.accent.withValues(alpha: 0.24) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: selected ? d.accent.withValues(alpha: 0.45) : Colors.transparent),
              ),
              child: Column(
                children: [
                  Icon(_workspaceIcons[index], color: selected ? d.accent : fg.withValues(alpha: 0.78), size: _compactRail ? 18 : 20),
                  if (!_compactRail) ...[
                    const SizedBox(height: 3),
                    Text(labels[index], style: TextStyle(color: fg, fontSize: 10), textAlign: TextAlign.center),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _workspaceMeta(Color fg) {
    final d = PanelTheme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: d.accent.withValues(alpha: 0.12),
        border: Border(bottom: BorderSide(color: d.border)),
      ),
      child: Row(
        children: [
          Text('active index: $_index', style: TextStyle(color: fg, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('radius ${d.cornerRadius.toStringAsFixed(1)}', style: TextStyle(color: fg.withValues(alpha: 0.82), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _workspaceFooter(Color fg) {
    final d = PanelTheme.of(context);
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: d.accent.withValues(alpha: 0.10),
        border: Border(top: BorderSide(color: d.border)),
      ),
      child: Row(
        children: [
          Text('Workspace footer', style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 12)),
          const Spacer(),
          Text('InheritedTheme-driven shell', style: TextStyle(color: fg.withValues(alpha: 0.82), fontSize: 12)),
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

class _WorkspaceMetrics extends StatelessWidget {
  const _WorkspaceMetrics({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  Widget build(BuildContext context) {
    final d = PanelTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: d.surface,
        borderRadius: BorderRadius.circular(d.cornerRadius),
        border: Border.all(color: d.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Metrics', style: TextStyle(color: d.accent, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _MetricCard(title: 'Availability', value: '99.7%', tone: d.accent)),
                const SizedBox(width: 8),
                Expanded(child: _MetricCard(title: 'Latency', value: '142ms', tone: d.accent)),
                const SizedBox(width: 8),
                Expanded(child: _MetricCard(title: 'Queue', value: '31', tone: d.accent)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: () => onEvent('metrics refresh requested'),
            child: const Text('Refresh metrics'),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.title, required this.value, required this.tone});

  final String title;
  final String value;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.25)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 18)),
        ],
      ),
    );
  }
}

class _WorkspaceTasks extends StatefulWidget {
  const _WorkspaceTasks({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  State<_WorkspaceTasks> createState() => _WorkspaceTasksState();
}

class _WorkspaceTasksState extends State<_WorkspaceTasks> {
  final List<_TaskEntry> _tasks = List<_TaskEntry>.generate(12, (i) => _TaskEntry('Task ${i + 1}', i.isEven && i % 3 == 0));

  @override
  Widget build(BuildContext context) {
    final d = PanelTheme.of(context);
    final done = _tasks.where((t) => t.done).length;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: d.surface,
        borderRadius: BorderRadius.circular(d.cornerRadius),
        border: Border.all(color: d.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tasks ($done/${_tasks.length})', style: TextStyle(color: d.accent, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Material(
                  type: MaterialType.transparency,
                  child: CheckboxListTile(
                  dense: true,
                  value: task.done,
                  onChanged: (v) {
                    setState(() => task.done = v ?? false);
                    widget.onEvent('task ${task.name} -> ${task.done}');
                  },
                  title: Text(task.name),
                  subtitle: Text(task.done ? 'done' : 'pending'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskEntry {
  _TaskEntry(this.name, this.done);

  final String name;
  bool done;
}

class _WorkspaceTimeline extends StatefulWidget {
  const _WorkspaceTimeline({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  State<_WorkspaceTimeline> createState() => _WorkspaceTimelineState();
}

class _WorkspaceTimelineState extends State<_WorkspaceTimeline> {
  double _progress = 0.37;
  bool _milestones = true;

  @override
  Widget build(BuildContext context) {
    final d = PanelTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: d.surface,
        borderRadius: BorderRadius.circular(d.cornerRadius),
        border: Border.all(color: d.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Timeline', style: TextStyle(color: d.accent, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          _LabeledSlider(
            label: 'Progress',
            value: _progress,
            min: 0,
            max: 1,
            onChanged: (v) {
              setState(() => _progress = v);
              widget.onEvent('timeline progress ${(v * 100).toStringAsFixed(1)}%');
            },
          ),
          Material(
            type: MaterialType.transparency,
            child: SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            value: _milestones,
            onChanged: (v) {
              setState(() => _milestones = v);
              widget.onEvent('timeline milestones = $v');
            },
            title: const Text('Show milestones'),
          ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: CustomPaint(
              painter: _SimpleTimelinePainter(progress: _progress, milestones: _milestones, color: d.accent),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SimpleTimelinePainter extends CustomPainter {
  const _SimpleTimelinePainter({required this.progress, required this.milestones, required this.color});

  final double progress;
  final bool milestones;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()
      ..color = const Color(0xFFC9D7E3)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final fill = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final y = size.height * 0.52;
    canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), base);
    canvas.drawLine(Offset(20, y), Offset(20 + (size.width - 40) * progress, y), fill);

    if (milestones) {
      for (int i = 0; i <= 4; i++) {
        final x = 20 + ((size.width - 40) * (i / 4));
        canvas.drawCircle(Offset(x, y), 6, Paint()..color = i / 4 <= progress ? color : const Color(0xFF9FB0C2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SimpleTimelinePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.milestones != milestones || oldDelegate.color != color;
  }
}

class _WorkspaceLogs extends StatefulWidget {
  const _WorkspaceLogs({required this.onEvent});

  final ValueChanged<String> onEvent;

  @override
  State<_WorkspaceLogs> createState() => _WorkspaceLogsState();
}

class _WorkspaceLogsState extends State<_WorkspaceLogs> {
  final List<String> _lines = List<String>.generate(24, (i) => 'line ${i + 1}: module-${(i % 5) + 1} initialized');
  late final ScrollController _scroll;

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
    final d = PanelTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: d.surface,
        borderRadius: BorderRadius.circular(d.cornerRadius),
        border: Border.all(color: d.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Logs', style: TextStyle(color: d.accent, fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 8),
          Row(
            children: [
              FilledButton.tonal(
                onPressed: () {
                  setState(() => _lines.add('line ${_lines.length + 1}: event @ ${_clock()}'));
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
                color: const Color(0xFF1D2732),
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
                        color: index.isEven ? const Color(0xFFB7CBDB) : const Color(0xFF8EB9DE),
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

class _ThemeInfoTable extends StatelessWidget {
  const _ThemeInfoTable({required this.data, this.title = 'Theme data'});

  final PanelThemeData data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: _softBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          _InfoRow(label: 'accent', value: '#${data.accent.toARGB32().toRadixString(16).toUpperCase()}'),
          _InfoRow(label: 'surface', value: '#${data.surface.toARGB32().toRadixString(16).toUpperCase()}'),
          _InfoRow(label: 'border', value: '#${data.border.toARGB32().toRadixString(16).toUpperCase()}'),
          _InfoRow(label: 'radius', value: data.cornerRadius.toStringAsFixed(1)),
          _InfoRow(label: 'density', value: data.density.toStringAsFixed(2)),
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
    final d = PanelTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: d.border),
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
    final p = Paint()..color = const Color(0x11000000);
    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
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

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.34)),
      ),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11)),
          const SizedBox(width: 6),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 11)),
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
          Text('Recap: InheritedTheme', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'InheritedTheme provides reusable inherited appearance contracts with support for subtree re-wrapping and captureAll transfer. It is ideal for structured visual systems where consistent style inheritance and context migration are required.',
            style: TextStyle(color: Color(0xFFD8E6F3), height: 1.36),
          ),
        ],
      ),
    );
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
