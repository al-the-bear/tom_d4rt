import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


// D4rt bridge workaround: bridged TickerProvider mixins cannot be used as mixin
mixin _TickerProviderShim<T extends StatefulWidget> on State<T> implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

const _cBlue = Color(0xFF2B5F8C);
const _cTeal = Color(0xFF2F8A7B);
const _cCoral = Color(0xFFB76859);
const _cIndigo = Color(0xFF5A64A8);
const _cOlive = Color(0xFF6A7442);
const _cSlate = Color(0xFF1E2A34);

dynamic build(BuildContext context) {
  return const _IconThemeDataDeepDemoApp();
}

class _IconThemeDataDeepDemoApp extends StatelessWidget {
  const _IconThemeDataDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cBlue),
        scaffoldBackgroundColor: const Color(0xFFF2F6FA),
      ),
      home: const _IconThemeDataLabPage(),
    );
  }
}

class _IconThemeDataLabPage extends StatefulWidget {
  const _IconThemeDataLabPage();

  @override
  State<_IconThemeDataLabPage> createState() => _IconThemeDataLabPageState();
}

class _IconThemeDataLabPageState extends State<_IconThemeDataLabPage> {
  bool _compact = false;
  bool _showGrid = true;
  bool _rtl = false;
  double _globalTextScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final config = _LabConfig(
      compact: _compact,
      showGrid: _showGrid,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      globalTextScale: _globalTextScale,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(config.globalTextScale)),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: _cSlate,
            foregroundColor: Colors.white,
            toolbarHeight: 84,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('IconThemeData Deep Demo'),
                const SizedBox(height: 2),
                Text(
                  'Direction: ${_rtl ? 'RTL' : 'LTR'} | Global text scale: ${config.globalTextScale.toStringAsFixed(2)}',
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
                _TopControlDeck(
                  compact: _compact,
                  showGrid: _showGrid,
                  rtl: _rtl,
                  textScale: _globalTextScale,
                  onCompactChanged: (value) => setState(() => _compact = value),
                  onShowGridChanged: (value) => setState(() => _showGrid = value),
                  onRtlChanged: (value) => setState(() => _rtl = value),
                  onTextScaleChanged: (value) => setState(() => _globalTextScale = value),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 1,
                  accent: _cBlue,
                  title: 'Fundamentals and Live Inspector',
                  subtitle:
                      'Interactively edit IconThemeData fields and inspect the resulting values, isConcrete state, and visual impact on multiple icons.',
                  child: _FundamentalsScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 2,
                  accent: _cTeal,
                  title: 'copyWith and merge in Practice',
                  subtitle:
                      'Visualizes how base themes and patch themes combine through copyWith and merge, including nested icon zones for direct comparison.',
                  child: _MergeAndCopyScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 3,
                  accent: _cCoral,
                  title: 'IconThemeData.lerp Transition Lab',
                  subtitle:
                      'Shows interpolation of all key fields between start and end themes with animated previews and value readouts.',
                  child: _LerpScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 4,
                  accent: _cIndigo,
                  title: 'Resolution and Precedence Matrix',
                  subtitle:
                      'Demonstrates precedence between inherited IconThemeData and explicit Icon parameters like color, size, and variable font values.',
                  child: _PrecedenceScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 5,
                  accent: _cOlive,
                  title: 'Equality and Hash Behavior',
                  subtitle:
                      'Compares theme instances to reveal how identity works in sets/maps and why subtle field differences matter.',
                  child: _EqualityHashScene(config: config),
                ),
                const SizedBox(height: 12),
                _SceneCard(
                  index: 6,
                  accent: _cSlate,
                  title: 'Practical Multi-Zone Dashboard',
                  subtitle:
                      'A realistic layout with scoped IconThemeData for navigation, content, alerts, and utility areas, including interaction logs.',
                  child: _PracticalDashboardScene(config: config),
                ),
                const SizedBox(height: 12),
                const _RecapCard(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LabConfig {
  const _LabConfig({
    required this.compact,
    required this.showGrid,
    required this.textDirection,
    required this.globalTextScale,
  });

  final bool compact;
  final bool showGrid;
  final TextDirection textDirection;
  final double globalTextScale;
}

class _TopControlDeck extends StatelessWidget {
  const _TopControlDeck({
    required this.compact,
    required this.showGrid,
    required this.rtl,
    required this.textScale,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onRtlChanged,
    required this.onTextScaleChanged,
  });

  final bool compact;
  final bool showGrid;
  final bool rtl;
  final double textScale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onTextScaleChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF183855), Color(0xFF2A5E7A), Color(0xFF534A7A)],
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
              'IconThemeData Control Deck',
              style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'This demo focuses on how IconThemeData controls icon appearance through inherited context, composition helpers, interpolation, and scoped design language in real interfaces.',
              style: TextStyle(height: 1.38, color: Color(0xFFE6F0F7)),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: compact,
                    onChanged: onCompactChanged,
                    title: const Text('Compact layout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: showGrid,
                    onChanged: onShowGridChanged,
                    title: const Text('Guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    value: rtl,
                    onChanged: onRtlChanged,
                    title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text('Global text scale: ${textScale.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            Slider(
              value: textScale,
              min: 0.8,
              max: 1.5,
              divisions: 14,
              label: textScale.toStringAsFixed(2),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withValues(alpha: 0.3),
              onChanged: onTextScaleChanged,
            ),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DeckTag(label: 'size / color / opacity'),
                _DeckTag(label: 'fill / weight / grade / opticalSize'),
                _DeckTag(label: 'copyWith / merge / lerp'),
                _DeckTag(label: 'inheritance + precedence'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DeckTag extends StatelessWidget {
  const _DeckTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
        color: Colors.white.withValues(alpha: 0.14),
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
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
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
                      Text(subtitle, style: const TextStyle(color: Color(0xFF304352), height: 1.36)),
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

  final _LabConfig config;

  @override
  State<_FundamentalsScene> createState() => _FundamentalsSceneState();
}

class _FundamentalsSceneState extends State<_FundamentalsScene> {
  double _size = 38;
  double _fill = 0;
  double _weight = 400;
  double _grade = 0;
  double _opticalSize = 48;
  double _opacity = 1;
  Color _color = _cBlue;
  bool _enableShadows = false;
  bool _applyTextScaling = false;

  IconThemeData _buildTheme() {
    return IconThemeData(
      size: _size,
      fill: _fill,
      weight: _weight,
      grade: _grade,
      opticalSize: _opticalSize,
      color: _color,
      opacity: _opacity,
      shadows: _enableShadows
          ? const <Shadow>[Shadow(color: Color(0x55000000), blurRadius: 8, offset: Offset(2, 3))]
          : null,
      applyTextScaling: _applyTextScaling,
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final liveTheme = _buildTheme();
    const fallback = IconThemeData.fallback();
    final partial = IconThemeData(color: _color);

    return SizedBox(
      height: config.compact ? 510 : 630,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Live theme editor', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _LabeledSlider(
                              label: 'size',
                              value: _size,
                              min: 14,
                              max: 84,
                              onChanged: (v) => setState(() => _size = v),
                            ),
                            _LabeledSlider(
                              label: 'fill',
                              value: _fill,
                              min: 0,
                              max: 1,
                              onChanged: (v) => setState(() => _fill = v),
                            ),
                            _LabeledSlider(
                              label: 'weight',
                              value: _weight,
                              min: 100,
                              max: 700,
                              onChanged: (v) => setState(() => _weight = v),
                            ),
                            _LabeledSlider(
                              label: 'grade',
                              value: _grade,
                              min: -25,
                              max: 200,
                              onChanged: (v) => setState(() => _grade = v),
                            ),
                            _LabeledSlider(
                              label: 'opticalSize',
                              value: _opticalSize,
                              min: 18,
                              max: 72,
                              onChanged: (v) => setState(() => _opticalSize = v),
                            ),
                            _LabeledSlider(
                              label: 'opacity',
                              value: _opacity,
                              min: 0,
                              max: 1,
                              onChanged: (v) => setState(() => _opacity = v),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Text('Color:', style: TextStyle(fontWeight: FontWeight.w700)),
                                const SizedBox(width: 8),
                                ..._palette.map(
                                  (entry) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(999),
                                      onTap: () => setState(() => _color = entry),
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: entry,
                                          borderRadius: BorderRadius.circular(999),
                                          border: Border.all(
                                            color: _color == entry ? Colors.black : Colors.white,
                                            width: _color == entry ? 2 : 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: SwitchListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    value: _enableShadows,
                                    onChanged: (v) => setState(() => _enableShadows = v),
                                    title: const Text('shadows'),
                                  ),
                                ),
                                Expanded(
                                  child: SwitchListTile(
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    value: _applyTextScaling,
                                    onChanged: (v) => setState(() => _applyTextScaling = v),
                                    title: const Text('applyTextScaling'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: _panelBox(),
                              child: Text(
                                'Live IconThemeData: ${liveTheme.toString()}',
                                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
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
          const SizedBox(width: 10),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  child: _GuideStage(
                    showGrid: config.showGrid,
                    child: IconTheme(
                      data: liveTheme,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Live preview strip', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 8),
                            _IconStrip(),
                            SizedBox(height: 8),
                            _IconGrid(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: _GuideStage(
                    showGrid: false,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Inspector', style: TextStyle(fontWeight: FontWeight.w800)),
                            const SizedBox(height: 8),
                            _InfoLine(label: 'live.isConcrete', value: '${liveTheme.isConcrete}'),
                            _InfoLine(label: 'fallback.isConcrete', value: '${fallback.isConcrete}'),
                            _InfoLine(label: 'partial.isConcrete', value: '${partial.isConcrete}'),
                            _InfoLine(label: 'live.size', value: _n(liveTheme.size)),
                            _InfoLine(label: 'live.fill', value: _n(liveTheme.fill)),
                            _InfoLine(label: 'live.weight', value: _n(liveTheme.weight)),
                            _InfoLine(label: 'live.grade', value: _n(liveTheme.grade)),
                            _InfoLine(label: 'live.opticalSize', value: _n(liveTheme.opticalSize)),
                            _InfoLine(label: 'live.opacity', value: _n(liveTheme.opacity)),
                            _InfoLine(label: 'live.color', value: '${liveTheme.color}'),
                            _InfoLine(label: 'live.shadows', value: '${liveTheme.shadows?.length ?? 0}'),
                            _InfoLine(label: 'live.applyTextScaling', value: '${liveTheme.applyTextScaling}'),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: _panelBox(),
                              child: const Text(
                                'Guidance: use IconThemeData for consistent icon language in a subtree. Keep explicit Icon properties for one-off exceptions. Use fallback or concrete themes for deterministic visuals in critical surfaces.',
                                style: TextStyle(height: 1.35),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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

class _IconStrip extends StatelessWidget {
  const _IconStrip();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Icon(Icons.favorite),
        Icon(Icons.auto_graph),
        Icon(Icons.hub),
        Icon(Icons.flight_takeoff),
        Icon(Icons.local_fire_department),
        Icon(Icons.speed),
      ],
    );
  }
}

class _IconGrid extends StatelessWidget {
  const _IconGrid();

  @override
  Widget build(BuildContext context) {
    const entries = <_IconLabelData>[
      _IconLabelData(Icons.rocket_launch, 'Launch'),
      _IconLabelData(Icons.safety_check, 'Safety'),
      _IconLabelData(Icons.palette, 'Palette'),
      _IconLabelData(Icons.analytics, 'Analytics'),
      _IconLabelData(Icons.route, 'Routing'),
      _IconLabelData(Icons.view_timeline, 'Timeline'),
      _IconLabelData(Icons.check_circle, 'Checks'),
      _IconLabelData(Icons.pie_chart, 'Budget'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF7FBFF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD6E1ED)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(entry.icon),
              const SizedBox(height: 4),
              Text(entry.label, style: const TextStyle(fontSize: 11)),
            ],
          ),
        );
      },
    );
  }
}

class _MergeAndCopyScene extends StatefulWidget {
  const _MergeAndCopyScene({required this.config});

  final _LabConfig config;

  @override
  State<_MergeAndCopyScene> createState() => _MergeAndCopySceneState();
}

class _MergeAndCopySceneState extends State<_MergeAndCopyScene> {
  double _baseSize = 30;
  double _patchSize = 52;
  bool _patchColorEnabled = true;
  bool _patchWeightEnabled = true;
  bool _patchShadowsEnabled = false;
  bool _patchScalingEnabled = false;
  Color _baseColor = _cBlue;
  Color _patchColor = _cCoral;
  final List<String> _events = <String>[];

  void _pushEvent(String message) {
    setState(() {
      _events.insert(0, '${_ts()} | $message');
      if (_events.length > 18) {
        _events.removeRange(18, _events.length);
      }
    });
  }

  IconThemeData _baseTheme() {
    return IconThemeData(
      size: _baseSize,
      color: _baseColor,
      fill: 0,
      weight: 350,
      grade: 0,
      opticalSize: 48,
      opacity: 1,
      applyTextScaling: false,
    );
  }

  IconThemeData _patchTheme() {
    return IconThemeData(
      size: _patchSize,
      color: _patchColorEnabled ? _patchColor : null,
      fill: 0.25,
      weight: _patchWeightEnabled ? 650 : null,
      grade: 120,
      opticalSize: 56,
      opacity: 0.85,
      shadows: _patchShadowsEnabled
          ? const <Shadow>[Shadow(color: Color(0x3F000000), blurRadius: 9, offset: Offset(2, 2))]
          : null,
      applyTextScaling: _patchScalingEnabled ? true : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final base = _baseTheme();
    final patch = _patchTheme();
    final merged = base.merge(patch);
    final copied = base.copyWith(
      size: patch.size,
      color: patch.color,
      weight: patch.weight,
      grade: patch.grade,
      opticalSize: patch.opticalSize,
      opacity: patch.opacity,
      shadows: patch.shadows,
      applyTextScaling: patch.applyTextScaling,
      fill: patch.fill,
    );

    return SizedBox(
      height: config.compact ? 520 : 620,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Base/Patch controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _LabeledSlider(
                      label: 'base.size',
                      value: _baseSize,
                      min: 18,
                      max: 64,
                      onChanged: (v) => setState(() => _baseSize = v),
                    ),
                    _LabeledSlider(
                      label: 'patch.size',
                      value: _patchSize,
                      min: 18,
                      max: 84,
                      onChanged: (v) => setState(() => _patchSize = v),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text('Base color:', style: TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(width: 6),
                        ..._palette.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: _ColorDot(
                              color: entry,
                              selected: _baseColor == entry,
                              onTap: () => setState(() => _baseColor = entry),
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Text('Patch color:', style: TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(width: 6),
                        ..._palette.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: _ColorDot(
                              color: entry,
                              selected: _patchColor == entry,
                              onTap: () => setState(() => _patchColor = entry),
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          selected: _patchColorEnabled,
                          label: const Text('patch.color'),
                          onSelected: (v) {
                            setState(() => _patchColorEnabled = v);
                            _pushEvent('patch.color ${v ? 'enabled' : 'disabled'}');
                          },
                        ),
                        FilterChip(
                          selected: _patchWeightEnabled,
                          label: const Text('patch.weight'),
                          onSelected: (v) {
                            setState(() => _patchWeightEnabled = v);
                            _pushEvent('patch.weight ${v ? 'enabled' : 'disabled'}');
                          },
                        ),
                        FilterChip(
                          selected: _patchShadowsEnabled,
                          label: const Text('patch.shadows'),
                          onSelected: (v) {
                            setState(() => _patchShadowsEnabled = v);
                            _pushEvent('patch.shadows ${v ? 'enabled' : 'disabled'}');
                          },
                        ),
                        FilterChip(
                          selected: _patchScalingEnabled,
                          label: const Text('patch.applyTextScaling'),
                          onSelected: (v) {
                            setState(() => _patchScalingEnabled = v);
                            _pushEvent('patch.applyTextScaling ${v ? 'enabled' : 'disabled'}');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(child: _EventLog(title: 'Merge/copy log', events: _events)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _ThemePreviewCard(title: 'Base', color: _cBlue, data: base)),
                          const SizedBox(width: 8),
                          Expanded(child: _ThemePreviewCard(title: 'Patch', color: _cTeal, data: patch)),
                          const SizedBox(width: 8),
                          Expanded(child: _ThemePreviewCard(title: 'base.merge(patch)', color: _cCoral, data: merged)),
                          const SizedBox(width: 8),
                          Expanded(child: _ThemePreviewCard(title: 'base.copyWith(...)', color: _cIndigo, data: copied)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: _panelBox(),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Observations', style: TextStyle(fontWeight: FontWeight.w800)),
                                  SizedBox(height: 6),
                                  _Bullet(text: 'merge copies non-null values from patch to base.'),
                                  _Bullet(text: 'copyWith gives explicit field-by-field override control.'),
                                  _Bullet(text: 'Both are immutable: each result is a new IconThemeData instance.'),
                                  _Bullet(text: 'Use merge when patch object is optional and sparse.'),
                                  _Bullet(text: 'Use copyWith when changes are explicit and local to one place.'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: _panelBox(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Data snapshot', style: TextStyle(fontWeight: FontWeight.w800)),
                                  const SizedBox(height: 6),
                                  _InfoLine(label: 'base.isConcrete', value: '${base.isConcrete}'),
                                  _InfoLine(label: 'patch.isConcrete', value: '${patch.isConcrete}'),
                                  _InfoLine(label: 'merged.size', value: _n(merged.size)),
                                  _InfoLine(label: 'merged.color', value: '${merged.color}'),
                                  _InfoLine(label: 'copied.weight', value: _n(copied.weight)),
                                  _InfoLine(label: 'copied.applyTextScaling', value: '${copied.applyTextScaling}'),
                                  _InfoLine(label: 'merged.shadows', value: '${merged.shadows?.length ?? 0}'),
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
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemePreviewCard extends StatelessWidget {
  const _ThemePreviewCard({required this.title, required this.color, required this.data});

  final String title;
  final Color color;
  final IconThemeData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: IconTheme(
        data: data,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 12)),
            const SizedBox(height: 6),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home),
                Icon(Icons.settings),
                Icon(Icons.notifications),
                Icon(Icons.key),
              ],
            ),
            const SizedBox(height: 6),
            Text('size ${_n(data.size)}', style: const TextStyle(fontSize: 11)),
            Text('weight ${_n(data.weight)}', style: const TextStyle(fontSize: 11)),
            Text('color ${data.color}', style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _LerpScene extends StatefulWidget {
  const _LerpScene({required this.config});

  final _LabConfig config;

  @override
  State<_LerpScene> createState() => _LerpSceneState();
}

class _LerpSceneState extends State<_LerpScene> with _TickerProviderShim {
  late final AnimationController _controller;
  bool _playing = false;
  double _t = 0.25;

  final IconThemeData _start = const IconThemeData(
    size: 24,
    fill: 0,
    weight: 300,
    grade: -10,
    opticalSize: 36,
    color: _cBlue,
    opacity: 1,
    applyTextScaling: false,
  );

  final IconThemeData _end = const IconThemeData(
    size: 64,
    fill: 1,
    weight: 700,
    grade: 200,
    opticalSize: 72,
    color: _cCoral,
    opacity: 0.6,
    shadows: <Shadow>[Shadow(color: Color(0x55000000), blurRadius: 10, offset: Offset(3, 4))],
    applyTextScaling: true,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600));
    _controller.addListener(() {
      setState(() => _t = _controller.value);
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed && _playing) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _playing = !_playing);
    if (_playing) {
      _controller.forward(from: _t);
    } else {
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final live = IconThemeData.lerp(_start, _end, _t);

    return SizedBox(
      height: config.compact ? 500 : 600,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FilledButton(
                          onPressed: _toggle,
                          child: Text(_playing ? 'Pause' : 'Play'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () {
                            setState(() => _t = 0);
                            _controller.value = 0;
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('t = ${_t.toStringAsFixed(3)}', style: const TextStyle(fontWeight: FontWeight.w700)),
                    Slider(
                      value: _t,
                      min: 0,
                      max: 1,
                      onChanged: (v) {
                        setState(() {
                          _t = v;
                          _controller.value = v;
                        });
                      },
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(child: _ThemePreviewCard(title: 'Start', color: _cBlue, data: _start)),
                                const SizedBox(width: 8),
                                Expanded(child: _ThemePreviewCard(title: 'Lerp', color: _cCoral, data: live)),
                                const SizedBox(width: 8),
                                Expanded(child: _ThemePreviewCard(title: 'End', color: _cIndigo, data: _end)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: IconTheme(
                              data: live,
                              child: Container(
                                width: double.infinity,
                                decoration: _panelBox(),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.track_changes),
                                    Icon(Icons.keyboard_double_arrow_right),
                                    Icon(Icons.dynamic_feed),
                                    Icon(Icons.waves),
                                    Icon(Icons.layers),
                                    Icon(Icons.blur_on),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
            flex: 6,
            child: _GuideStage(
              showGrid: false,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Interpolated values', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _InfoLine(label: 'size', value: _n(live.size)),
                    _InfoLine(label: 'fill', value: _n(live.fill)),
                    _InfoLine(label: 'weight', value: _n(live.weight)),
                    _InfoLine(label: 'grade', value: _n(live.grade)),
                    _InfoLine(label: 'opticalSize', value: _n(live.opticalSize)),
                    _InfoLine(label: 'opacity', value: _n(live.opacity)),
                    _InfoLine(label: 'color', value: '${live.color}'),
                    _InfoLine(label: 'applyTextScaling', value: '${live.applyTextScaling}'),
                    _InfoLine(label: 'shadows', value: '${live.shadows?.length ?? 0}'),
                    const SizedBox(height: 8),
                    const Text('Field bars', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    _ValueBar(label: 'size', fraction: ((live.size ?? 0) - 14) / 70, color: _cBlue),
                    _ValueBar(label: 'fill', fraction: live.fill ?? 0, color: _cTeal),
                    _ValueBar(label: 'weight', fraction: ((live.weight ?? 100) - 100) / 600, color: _cCoral),
                    _ValueBar(label: 'grade', fraction: ((live.grade ?? -25) + 25) / 225, color: _cIndigo),
                    _ValueBar(label: 'optical', fraction: ((live.opticalSize ?? 18) - 18) / 54, color: _cOlive),
                    _ValueBar(label: 'opacity', fraction: live.opacity ?? 0, color: _cSlate),
                    const SizedBox(height: 10),
                    const Text(
                      'lerp is ideal for animated transitions between visual states, such as mode switches, status escalation, and responsive emphasis changes.',
                      style: TextStyle(height: 1.35),
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

class _PrecedenceScene extends StatefulWidget {
  const _PrecedenceScene({required this.config});

  final _LabConfig config;

  @override
  State<_PrecedenceScene> createState() => _PrecedenceSceneState();
}

class _PrecedenceSceneState extends State<_PrecedenceScene> {
  final IconThemeData _parent = const IconThemeData(
    size: 44,
    color: _cBlue,
    fill: 0,
    weight: 350,
    grade: 0,
    opticalSize: 48,
    opacity: 0.95,
    applyTextScaling: false,
  );

  final IconThemeData _child = const IconThemeData(
    size: 34,
    color: _cTeal,
    fill: 1,
    weight: 700,
    grade: 150,
    opticalSize: 60,
    opacity: 0.8,
    applyTextScaling: true,
  );

  bool _explicitColor = true;
  bool _explicitSize = false;
  bool _explicitWeight = false;
  bool _explicitOpacity = false;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return SizedBox(
      height: config.compact ? 500 : 580,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          selected: _explicitColor,
                          label: const Text('Icon.color override'),
                          onSelected: (v) => setState(() => _explicitColor = v),
                        ),
                        FilterChip(
                          selected: _explicitSize,
                          label: const Text('Icon.size override'),
                          onSelected: (v) => setState(() => _explicitSize = v),
                        ),
                        FilterChip(
                          selected: _explicitWeight,
                          label: const Text('Icon.weight override'),
                          onSelected: (v) => setState(() => _explicitWeight = v),
                        ),
                        FilterChip(
                          selected: _explicitOpacity,
                          label: const Text('Row Opacity wrapper'),
                          onSelected: (v) => setState(() => _explicitOpacity = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: IconTheme(
                        data: _parent,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF2FB),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFCEDCEB)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Parent IconTheme', style: TextStyle(fontWeight: FontWeight.w800)),
                              const SizedBox(height: 8),
                              _previewRow(title: 'Parent-only row', useChildTheme: false),
                              const SizedBox(height: 10),
                              IconTheme(
                                data: _child,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Nested child IconTheme', style: TextStyle(fontWeight: FontWeight.w800)),
                                    const SizedBox(height: 8),
                                    _previewRow(title: 'Child row', useChildTheme: true),
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
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _GuideStage(
              showGrid: false,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Precedence matrix', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _MatrixRow(
                      label: 'color',
                      inherited: '${_child.color}',
                      explicit: _explicitColor ? '${Colors.purple}' : '(none)',
                      winner: _explicitColor ? 'Icon.color' : 'IconThemeData.color',
                    ),
                    _MatrixRow(
                      label: 'size',
                      inherited: _n(_child.size),
                      explicit: _explicitSize ? '52.0' : '(none)',
                      winner: _explicitSize ? 'Icon.size' : 'IconThemeData.size',
                    ),
                    _MatrixRow(
                      label: 'weight',
                      inherited: _n(_child.weight),
                      explicit: _explicitWeight ? '250.0' : '(none)',
                      winner: _explicitWeight ? 'Icon.weight' : 'IconThemeData.weight',
                    ),
                    _MatrixRow(
                      label: 'opacity',
                      inherited: _n(_child.opacity),
                      explicit: _explicitOpacity ? '0.4 via Opacity' : '(none)',
                      winner: _explicitOpacity ? 'Opacity widget' : 'IconThemeData.opacity',
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _panelBox(),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Usage guidance', style: TextStyle(fontWeight: FontWeight.w800)),
                          SizedBox(height: 6),
                          _Bullet(text: 'Prefer IconThemeData for broad consistency in a subtree.'),
                          _Bullet(text: 'Use explicit Icon parameters only for local exceptions.'),
                          _Bullet(text: 'Nested IconTheme scopes are useful for contextual emphasis.'),
                          _Bullet(text: 'Keep override strategy intentional to avoid visual drift.'),
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

  Widget _previewRow({required String title, required bool useChildTheme}) {
    final color = _explicitColor ? Colors.purple : null;
    final size = _explicitSize ? 52.0 : null;
    final weight = _explicitWeight ? 250.0 : null;
    final iconOpacity = _explicitOpacity ? 0.4 : 1.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: useChildTheme ? const Color(0xFFE7F5F3) : const Color(0xFFF2F8FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCDDDEA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Opacity(opacity: iconOpacity, child: Icon(Icons.send, color: color, size: size, weight: weight)),
              Opacity(opacity: iconOpacity, child: Icon(Icons.forward, color: color, size: size, weight: weight)),
              Opacity(opacity: iconOpacity, child: Icon(Icons.arrow_right_alt, color: color, size: size, weight: weight)),
              Opacity(opacity: iconOpacity, child: Icon(Icons.login, color: color, size: size, weight: weight)),
            ],
          ),
        ],
      ),
    );
  }
}

class _MatrixRow extends StatelessWidget {
  const _MatrixRow({
    required this.label,
    required this.inherited,
    required this.explicit,
    required this.winner,
  });

  final String label;
  final String inherited;
  final String explicit;
  final String winner;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF8FBFF),
        border: Border.all(color: const Color(0xFFD4E0ED)),
      ),
      child: Row(
        children: [
          SizedBox(width: 72, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
          Expanded(child: Text('inherited: $inherited', style: const TextStyle(fontSize: 12))),
          Expanded(child: Text('explicit: $explicit', style: const TextStyle(fontSize: 12))),
          Expanded(child: Text('winner: $winner', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
        ],
      ),
    );
  }
}

class _EqualityHashScene extends StatelessWidget {
  const _EqualityHashScene({required this.config});

  final _LabConfig config;

  @override
  Widget build(BuildContext context) {
    final a = const IconThemeData(
      size: 24,
      fill: 0,
      weight: 400,
      grade: 0,
      opticalSize: 48,
      color: _cBlue,
      opacity: 1,
      applyTextScaling: false,
    );
    final b = const IconThemeData(
      size: 24,
      fill: 0,
      weight: 400,
      grade: 0,
      opticalSize: 48,
      color: _cBlue,
      opacity: 1,
      applyTextScaling: false,
    );
    final c = const IconThemeData(
      size: 24,
      fill: 1,
      weight: 400,
      grade: 0,
      opticalSize: 48,
      color: _cBlue,
      opacity: 1,
      applyTextScaling: false,
    );
    final d = const IconThemeData(
      size: 24,
      fill: 0,
      weight: 400,
      grade: 0,
      opticalSize: 48,
      color: _cBlue,
      opacity: 1,
      applyTextScaling: true,
    );
    final e = const IconThemeData(
      size: 24,
      fill: 0,
      weight: 400,
      grade: 0,
      opticalSize: 48,
      color: _cCoral,
      opacity: 1,
      applyTextScaling: false,
    );

    final set = <IconThemeData>{a, b, c, d, e};
    final rows = <_EqThemeRow>[
      _EqThemeRow('a vs b', a, b),
      _EqThemeRow('a vs c', a, c),
      _EqThemeRow('a vs d', a, d),
      _EqThemeRow('a vs e', a, e),
    ];

    return SizedBox(
      height: config.compact ? 380 : 470,
      child: Row(
        children: [
          Expanded(
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Set size from five instances: ${set.length}', style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: rows.length,
                        itemBuilder: (context, index) {
                          final row = rows[index];
                          final eq = row.a == row.b;
                          final hashEq = row.a.hashCode == row.b.hashCode;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: eq ? const Color(0xFFEAF8EF) : const Color(0xFFFCEEF0),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: eq ? const Color(0xFFC8E4D1) : const Color(0xFFE7CBD0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(row.label, style: const TextStyle(fontWeight: FontWeight.w800)),
                                const SizedBox(height: 4),
                                Text('== $eq | hashCode equal $hashEq', style: const TextStyle(fontSize: 12)),
                                const SizedBox(height: 4),
                                Text('A: ${row.a}', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                                Text('B: ${row.b}', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _GuideStage(
              showGrid: config.showGrid,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rendered identity chips', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _IdentityChip(label: 'A', icon: Icons.adjust, theme: a, accent: _cBlue),
                        _IdentityChip(label: 'B', icon: Icons.adjust, theme: b, accent: _cTeal),
                        _IdentityChip(label: 'C', icon: Icons.adjust, theme: c, accent: _cCoral),
                        _IdentityChip(label: 'D', icon: Icons.adjust, theme: d, accent: _cIndigo),
                        _IdentityChip(label: 'E', icon: Icons.adjust, theme: e, accent: _cOlive),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _panelBox(),
                      child: const Text(
                        'When using IconThemeData as map/set keys, every field contributes to identity. Seemingly minor differences like fill or applyTextScaling create distinct entries.',
                        style: TextStyle(height: 1.35),
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

class _EqThemeRow {
  const _EqThemeRow(this.label, this.a, this.b);

  final String label;
  final IconThemeData a;
  final IconThemeData b;
}

class _IdentityChip extends StatelessWidget {
  const _IdentityChip({
    required this.label,
    required this.icon,
    required this.theme,
    required this.accent,
  });

  final String label;
  final IconData icon;
  final IconThemeData theme;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: IconTheme(
        data: theme,
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
            Text('fill ${_n(theme.fill)}', style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

class _PracticalDashboardScene extends StatefulWidget {
  const _PracticalDashboardScene({required this.config});

  final _LabConfig config;

  @override
  State<_PracticalDashboardScene> createState() => _PracticalDashboardSceneState();
}

class _PracticalDashboardSceneState extends State<_PracticalDashboardScene> {
  int _profileIndex = 0;
  int _activeModule = 0;
  bool _denseIcons = false;
  bool _showLabels = true;
  final List<String> _events = <String>[];

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_ts()} | $message');
      if (_events.length > 26) {
        _events.removeRange(26, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final profile = _profiles[_profileIndex];

    return SizedBox(
      height: config.compact ? 640 : 760,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _GuideStage(
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
                        _profiles.length,
                        (index) => ChoiceChip(
                          selected: _profileIndex == index,
                          label: Text(_profiles[index].name),
                          onSelected: (_) {
                            setState(() => _profileIndex = index);
                            _push('profile -> ${_profiles[index].name}');
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
                          selected: _denseIcons,
                          label: const Text('Dense icons'),
                          onSelected: (v) {
                            setState(() => _denseIcons = v);
                            _push('dense icons ${v ? 'enabled' : 'disabled'}');
                          },
                        ),
                        FilterChip(
                          selected: _showLabels,
                          label: const Text('Show nav labels'),
                          onSelected: (v) {
                            setState(() => _showLabels = v);
                            _push('nav labels ${v ? 'visible' : 'hidden'}');
                          },
                        ),
                        FilledButton(
                          onPressed: () => setState(_events.clear),
                          child: const Text('Clear log'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD5E1EC)),
                        ),
                        child: Column(
                          children: [
                            _dashboardTopBar(profile),
                            Expanded(
                              child: Row(
                                children: [
                                  _dashboardRail(profile),
                                  Expanded(
                                    child: _dashboardContent(profile),
                                  ),
                                  _dashboardAlertColumn(profile),
                                ],
                              ),
                            ),
                            _dashboardFooter(profile),
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
            child: _EventLog(title: 'Dashboard interaction log', events: _events),
          ),
        ],
      ),
    );
  }

  Widget _dashboardTopBar(_Profile profile) {
    final iconTheme = _denseIcons ? profile.topBarTheme.copyWith(size: 17) : profile.topBarTheme;
    return IconTheme(
      data: iconTheme,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: profile.baseColor.withValues(alpha: 0.12),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          border: const Border(bottom: BorderSide(color: Color(0xFFD4E0EB))),
        ),
        child: Row(
          children: [
            Icon(profile.leading),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                profile.name,
                style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF243C4D)),
              ),
            ),
            ...profile.topActions.map(
              (entry) => IconButton(
                onPressed: () => _push('top action ${entry.label}'),
                icon: Icon(entry.icon),
                tooltip: entry.label,
                constraints: const BoxConstraints.tightFor(width: 34, height: 34),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardRail(_Profile profile) {
    final iconTheme = _denseIcons ? profile.railTheme.copyWith(size: 17) : profile.railTheme;
    return IconTheme(
      data: iconTheme,
      child: Container(
        width: 92,
        decoration: const BoxDecoration(
          color: Color(0xFFF8FBFF),
          border: Border(right: BorderSide(color: Color(0xFFD4E0EB))),
        ),
        child: Column(
          children: List<Widget>.generate(profile.modules.length, (index) {
            final module = profile.modules[index];
            final selected = _activeModule == index;
            return InkWell(
              onTap: () {
                setState(() => _activeModule = index);
                _push('module -> ${module.title}');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                color: selected ? profile.baseColor.withValues(alpha: 0.12) : Colors.transparent,
                child: Column(
                  children: [
                    Icon(module.icon),
                    const SizedBox(height: 4),
                    if (_showLabels)
                      Text(
                        module.title,
                        style: const TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _dashboardContent(_Profile profile) {
    final module = profile.modules[_activeModule];
    final iconTheme = _denseIcons ? profile.contentTheme.copyWith(size: 18) : profile.contentTheme;

    return IconTheme(
      data: iconTheme,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: module.cards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.14,
          ),
          itemBuilder: (context, index) {
            final card = module.cards[index];
            return InkWell(
              onTap: () => _push('card tap ${card.title}'),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: card.color.withValues(alpha: 0.35)),
                  color: card.color.withValues(alpha: 0.12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(card.icon),
                    const SizedBox(height: 6),
                    Text(card.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(card.description, style: const TextStyle(fontSize: 12, height: 1.3)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _dashboardAlertColumn(_Profile profile) {
    final iconTheme = _denseIcons ? profile.alertTheme.copyWith(size: 16) : profile.alertTheme;
    return IconTheme(
      data: iconTheme,
      child: Container(
        width: 180,
        decoration: const BoxDecoration(
          color: Color(0xFFFDF8F8),
          border: Border(left: BorderSide(color: Color(0xFFD4E0EB))),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Alerts', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              ...profile.alerts.map(
                (entry) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: entry.color.withValues(alpha: 0.14),
                    border: Border.all(color: entry.color.withValues(alpha: 0.35)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(entry.icon),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(entry.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                            Text(entry.note, style: const TextStyle(fontSize: 11, height: 1.3)),
                          ],
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
    );
  }

  Widget _dashboardFooter(_Profile profile) {
    final iconTheme = _denseIcons ? profile.footerTheme.copyWith(size: 15) : profile.footerTheme;
    return IconTheme(
      data: iconTheme,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFD4E0EB))),
          color: Color(0xFFF8FAFD),
        ),
        child: Row(
          children: [
            ...profile.footerActions.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => _push('footer action ${entry.label}'),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Icon(entry.icon),
                        const SizedBox(width: 4),
                        Text(entry.label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Text('Scoped IconThemeData by zone', style: TextStyle(fontSize: 11, color: Color(0xFF566A7A))),
          ],
        ),
      ),
    );
  }
}

class _Profile {
  const _Profile({
    required this.name,
    required this.baseColor,
    required this.leading,
    required this.topBarTheme,
    required this.railTheme,
    required this.contentTheme,
    required this.alertTheme,
    required this.footerTheme,
    required this.topActions,
    required this.modules,
    required this.alerts,
    required this.footerActions,
  });

  final String name;
  final Color baseColor;
  final IconData leading;
  final IconThemeData topBarTheme;
  final IconThemeData railTheme;
  final IconThemeData contentTheme;
  final IconThemeData alertTheme;
  final IconThemeData footerTheme;
  final List<_IconItem> topActions;
  final List<_Module> modules;
  final List<_AlertItem> alerts;
  final List<_IconItem> footerActions;
}

class _Module {
  const _Module({required this.title, required this.icon, required this.cards});

  final String title;
  final IconData icon;
  final List<_ModuleCard> cards;
}

class _ModuleCard {
  const _ModuleCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.color,
  });

  final String title;
  final IconData icon;
  final String description;
  final Color color;
}

class _AlertItem {
  const _AlertItem({
    required this.title,
    required this.note,
    required this.icon,
    required this.color,
  });

  final String title;
  final String note;
  final IconData icon;
  final Color color;
}

class _IconItem {
  const _IconItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

const _profiles = <_Profile>[
  _Profile(
    name: 'Calm Operations',
    baseColor: _cBlue,
    leading: Icons.dashboard_customize,
    topBarTheme: IconThemeData(size: 20, color: _cBlue, weight: 450, grade: 0, opticalSize: 48, opacity: 1, fill: 0),
    railTheme: IconThemeData(size: 19, color: _cBlue, weight: 450, grade: 0, opticalSize: 48, opacity: 0.95, fill: 0),
    contentTheme: IconThemeData(size: 22, color: _cTeal, weight: 500, grade: 80, opticalSize: 56, opacity: 1, fill: 0.2),
    alertTheme: IconThemeData(size: 18, color: _cCoral, weight: 600, grade: 120, opticalSize: 52, opacity: 1, fill: 1),
    footerTheme: IconThemeData(size: 16, color: _cSlate, weight: 430, grade: 0, opticalSize: 48, opacity: 0.9, fill: 0),
    topActions: <_IconItem>[
      _IconItem(icon: Icons.search, label: 'Search'),
      _IconItem(icon: Icons.tune, label: 'Filters'),
      _IconItem(icon: Icons.more_horiz, label: 'More'),
    ],
    modules: <_Module>[
      _Module(
        title: 'Plan',
        icon: Icons.route,
        cards: <_ModuleCard>[
          _ModuleCard(title: 'Roadmap', icon: Icons.alt_route, description: 'Cross-team milestones and sequence map.', color: _cBlue),
          _ModuleCard(title: 'Backlog', icon: Icons.view_stream, description: 'Prioritized delivery queue and ownership.', color: _cTeal),
          _ModuleCard(title: 'Risk Grid', icon: Icons.warning_amber, description: 'Mitigation status and confidence trends.', color: _cCoral),
          _ModuleCard(title: 'Budget Lens', icon: Icons.pie_chart, description: 'Spend, forecast, and utilization snapshots.', color: _cIndigo),
        ],
      ),
      _Module(
        title: 'Flow',
        icon: Icons.timeline,
        cards: <_ModuleCard>[
          _ModuleCard(title: 'Execution Path', icon: Icons.timeline, description: 'Live stage transitions and blockers.', color: _cBlue),
          _ModuleCard(title: 'Hand-offs', icon: Icons.hub, description: 'Inter-team transfer quality checks.', color: _cTeal),
          _ModuleCard(title: 'Latency', icon: Icons.hourglass_bottom, description: 'Slow-step diagnostics and throughput.', color: _cCoral),
          _ModuleCard(title: 'SLA Radar', icon: Icons.radar, description: 'Service-level budget signal strength.', color: _cIndigo),
        ],
      ),
      _Module(
        title: 'Ship',
        icon: Icons.rocket_launch,
        cards: <_ModuleCard>[
          _ModuleCard(title: 'Gate Checks', icon: Icons.gpp_good, description: 'Policy, security, and quality gates.', color: _cBlue),
          _ModuleCard(title: 'Canary', icon: Icons.cloud_upload, description: 'Progressive rollout status and health.', color: _cTeal),
          _ModuleCard(title: 'Telemetry', icon: Icons.query_stats, description: 'Post-release behavior and alerts.', color: _cCoral),
          _ModuleCard(title: 'Rollback', icon: Icons.restore, description: 'Recovery path readiness and timing.', color: _cIndigo),
        ],
      ),
    ],
    alerts: <_AlertItem>[
      _AlertItem(title: 'Latency Spike', note: 'Regional API latency up 18%.', icon: Icons.speed, color: _cCoral),
      _AlertItem(title: 'Budget Drift', note: 'Q2 infra forecast above target.', icon: Icons.account_balance_wallet, color: _cIndigo),
      _AlertItem(title: 'Queue Backlog', note: 'Build queue exceeded soft threshold.', icon: Icons.timer, color: _cOlive),
    ],
    footerActions: <_IconItem>[
      _IconItem(icon: Icons.download, label: 'Export'),
      _IconItem(icon: Icons.bookmark, label: 'Snapshot'),
      _IconItem(icon: Icons.share, label: 'Share'),
    ],
  ),
  _Profile(
    name: 'Escalation Focus',
    baseColor: _cCoral,
    leading: Icons.emergency,
    topBarTheme: IconThemeData(size: 21, color: _cCoral, weight: 650, grade: 160, opticalSize: 56, opacity: 1, fill: 1),
    railTheme: IconThemeData(size: 20, color: _cCoral, weight: 650, grade: 150, opticalSize: 56, opacity: 0.95, fill: 1),
    contentTheme: IconThemeData(size: 23, color: _cSlate, weight: 650, grade: 140, opticalSize: 60, opacity: 1, fill: 1),
    alertTheme: IconThemeData(size: 19, color: _cCoral, weight: 700, grade: 200, opticalSize: 64, opacity: 1, fill: 1),
    footerTheme: IconThemeData(size: 16, color: _cCoral, weight: 600, grade: 100, opticalSize: 52, opacity: 0.95, fill: 0.7),
    topActions: <_IconItem>[
      _IconItem(icon: Icons.notifications_active, label: 'Alerts'),
      _IconItem(icon: Icons.rule, label: 'Policy'),
      _IconItem(icon: Icons.more_horiz, label: 'More'),
    ],
    modules: <_Module>[
      _Module(
        title: 'Incidents',
        icon: Icons.local_fire_department,
        cards: <_ModuleCard>[
          _ModuleCard(title: 'Live Incidents', icon: Icons.crisis_alert, description: 'Severity timeline and owner assignment.', color: _cCoral),
          _ModuleCard(title: 'Mitigation', icon: Icons.health_and_safety, description: 'Active response playbook progress.', color: _cOlive),
          _ModuleCard(title: 'Comms', icon: Icons.campaign, description: 'Stakeholder and status channels.', color: _cBlue),
          _ModuleCard(title: 'Forensics', icon: Icons.manage_search, description: 'Root-cause traces and evidence links.', color: _cIndigo),
        ],
      ),
      _Module(
        title: 'Contain',
        icon: Icons.shield,
        cards: <_ModuleCard>[
          _ModuleCard(title: 'Traffic Guard', icon: Icons.security, description: 'Boundary rules and deny-list controls.', color: _cCoral),
          _ModuleCard(title: 'Rate Control', icon: Icons.filter_alt, description: 'Adaptive throttling and safe mode.', color: _cOlive),
          _ModuleCard(title: 'Circuit Path', icon: Icons.power_settings_new, description: 'Kill switch and fallback wiring.', color: _cBlue),
          _ModuleCard(title: 'Health Probe', icon: Icons.monitor_heart, description: 'Stability trend during containment.', color: _cIndigo),
        ],
      ),
      _Module(
        title: 'Recover',
        icon: Icons.restore,
        cards: <_ModuleCard>[
          _ModuleCard(title: 'Rollback Line', icon: Icons.undo, description: 'Version rollback readiness and checks.', color: _cCoral),
          _ModuleCard(title: 'Data Repair', icon: Icons.auto_fix_high, description: 'Repair jobs and confidence score.', color: _cOlive),
          _ModuleCard(title: 'Validation', icon: Icons.fact_check, description: 'Recovery acceptance criteria status.', color: _cBlue),
          _ModuleCard(title: 'Closure', icon: Icons.task_alt, description: 'Incident closure and lessons archive.', color: _cIndigo),
        ],
      ),
    ],
    alerts: <_AlertItem>[
      _AlertItem(title: 'Critical Outage', note: 'Auth service in partial failure.', icon: Icons.warning, color: _cCoral),
      _AlertItem(title: 'Data Drift', note: 'Replication lag beyond threshold.', icon: Icons.sync_problem, color: _cIndigo),
      _AlertItem(title: 'Customer Impact', note: 'Error rate visible in checkout path.', icon: Icons.support_agent, color: _cBlue),
    ],
    footerActions: <_IconItem>[
      _IconItem(icon: Icons.call, label: 'War Room'),
      _IconItem(icon: Icons.description, label: 'Runbook'),
      _IconItem(icon: Icons.archive, label: 'Archive'),
    ],
  ),
  _Profile(
    name: 'Design System',
    baseColor: _cIndigo,
    leading: Icons.palette,
    topBarTheme: IconThemeData(size: 20, color: _cIndigo, weight: 520, grade: 80, opticalSize: 54, opacity: 1, fill: 0.5),
    railTheme: IconThemeData(size: 19, color: _cIndigo, weight: 500, grade: 60, opticalSize: 50, opacity: 0.95, fill: 0.4),
    contentTheme: IconThemeData(size: 22, color: _cBlue, weight: 520, grade: 90, opticalSize: 56, opacity: 1, fill: 0.5),
    alertTheme: IconThemeData(size: 18, color: _cTeal, weight: 550, grade: 70, opticalSize: 52, opacity: 1, fill: 0.5),
    footerTheme: IconThemeData(size: 16, color: _cIndigo, weight: 480, grade: 60, opticalSize: 50, opacity: 0.9, fill: 0.3),
    topActions: <_IconItem>[
      _IconItem(icon: Icons.layers, label: 'Layers'),
      _IconItem(icon: Icons.text_fields, label: 'Type'),
      _IconItem(icon: Icons.more_horiz, label: 'More'),
    ],
    modules: <_Module>[
      _Module(
        title: 'Tokens',
        icon: Icons.style,
        cards: <_ModuleCard>[
          _ModuleCard(title: 'Palette Tokens', icon: Icons.color_lens, description: 'Color token naming and mapping.', color: _cIndigo),
          _ModuleCard(title: 'Type Scale', icon: Icons.format_size, description: 'Typography size and rhythm audits.', color: _cBlue),
          _ModuleCard(title: 'Radius Set', icon: Icons.rounded_corner, description: 'Corner radii consistency checks.', color: _cTeal),
          _ModuleCard(title: 'Elevation', icon: Icons.layers, description: 'Depth rules and shadow standards.', color: _cOlive),
        ],
      ),
      _Module(
        title: 'Components',
        icon: Icons.widgets,
        cards: <_ModuleCard>[
          _ModuleCard(title: 'Buttons', icon: Icons.smart_button, description: 'State matrix and interaction affordance.', color: _cIndigo),
          _ModuleCard(title: 'Forms', icon: Icons.input, description: 'Input consistency and validation visuals.', color: _cBlue),
          _ModuleCard(title: 'Navigation', icon: Icons.menu, description: 'Sidebar, tabs, and route cues.', color: _cTeal),
          _ModuleCard(title: 'Feedback', icon: Icons.chat, description: 'Toasts, banners, and inline notices.', color: _cOlive),
        ],
      ),
      _Module(
        title: 'Review',
        icon: Icons.fact_check,
        cards: <_ModuleCard>[
          _ModuleCard(title: 'Contrast', icon: Icons.visibility, description: 'Contrast and readability scoring.', color: _cIndigo),
          _ModuleCard(title: 'Motion', icon: Icons.animation, description: 'Animation timing and consistency.', color: _cBlue),
          _ModuleCard(title: 'Localization', icon: Icons.translate, description: 'Directionality and truncation audit.', color: _cTeal),
          _ModuleCard(title: 'Sign-off', icon: Icons.verified, description: 'Approval and handoff package.', color: _cOlive),
        ],
      ),
    ],
    alerts: <_AlertItem>[
      _AlertItem(title: 'Contrast Warning', note: 'Two text/icon pairs below threshold.', icon: Icons.visibility_off, color: _cCoral),
      _AlertItem(title: 'Token Drift', note: 'Unmapped color token detected.', icon: Icons.error_outline, color: _cIndigo),
      _AlertItem(title: 'Review Due', note: 'Design review SLA expires in 6h.', icon: Icons.timer, color: _cOlive),
    ],
    footerActions: <_IconItem>[
      _IconItem(icon: Icons.file_download, label: 'Export Pack'),
      _IconItem(icon: Icons.auto_awesome, label: 'Generate'),
      _IconItem(icon: Icons.send, label: 'Submit'),
    ],
  ),
];

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

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

class _ColorDot extends StatelessWidget {
  const _ColorDot({required this.color, required this.selected, required this.onTap});

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? Colors.black : Colors.white, width: selected ? 2 : 1),
        ),
      ),
    );
  }
}

class _GuideStage extends StatelessWidget {
  const _GuideStage({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD5E0EB)),
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FCFF), Color(0xFFECF3FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid) CustomPaint(painter: _GuidePainter()),
          child,
        ],
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
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

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(width: 150, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

class _ValueBar extends StatelessWidget {
  const _ValueBar({required this.label, required this.fraction, required this.color});

  final String label;
  final double fraction;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final value = fraction.clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 72, child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(value: value, minHeight: 10, color: color, backgroundColor: color.withValues(alpha: 0.2)),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconLabelData {
  const _IconLabelData(this.icon, this.label);

  final IconData icon;
  final String label;
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

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
            child: Icon(Icons.circle, size: 7, color: Color(0xFF35526A)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.32))),
        ],
      ),
    );
  }
}

class _EventLog extends StatelessWidget {
  const _EventLog({required this.title, required this.events});

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
        border: Border.all(color: const Color(0xFFD8E4F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No interactions yet.', style: TextStyle(color: Color(0xFF586D7E)))
          else
            ...events.map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(line, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
              ),
            ),
        ],
      ),
    );
  }
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF1A3247),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: IconThemeData', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'IconThemeData is the visual contract for icon systems in Flutter. Use it to keep icon tone, size, variable font traits, and opacity coherent across each UI zone. Prefer scoped inheritance for consistency, and explicit icon overrides only for deliberate exceptions.',
            style: TextStyle(color: Color(0xFFD6E4F2), height: 1.38),
          ),
        ],
      ),
    );
  }
}

const _palette = <Color>[
  _cBlue,
  _cTeal,
  _cCoral,
  _cIndigo,
  _cOlive,
  Color(0xFF40566A),
];

BoxDecoration _panelBox() {
  return BoxDecoration(
    color: const Color(0xFFF2F7FC),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: const Color(0xFFD7E2EE)),
  );
}

String _n(double? value) {
  if (value == null) {
    return '(null)';
  }
  return value.toStringAsFixed(2);
}

String _ts() => DateTime.now().toIso8601String().substring(11, 19);
