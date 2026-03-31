import 'package:flutter/material.dart';

const _cInk = Color(0xFF1B2E42);
const _cOcean = Color(0xFF2D6A97);
const _cTeal = Color(0xFF2E8A79);
const _cCoral = Color(0xFFBC6D5E);
const _cViolet = Color(0xFF6E63AC);
const _cOlive = Color(0xFF6D7342);

dynamic build(BuildContext context) {
  return const _IgnoreBaselineDemoApp();
}

class _IgnoreBaselineDemoApp extends StatelessWidget {
  const _IgnoreBaselineDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cOcean),
        scaffoldBackgroundColor: const Color(0xFFF3F7FB),
      ),
      home: const _IgnoreBaselineLabPage(),
    );
  }
}

class _IgnoreBaselineLabPage extends StatefulWidget {
  const _IgnoreBaselineLabPage();

  @override
  State<_IgnoreBaselineLabPage> createState() => _IgnoreBaselineLabPageState();
}

class _IgnoreBaselineLabPageState extends State<_IgnoreBaselineLabPage> {
  bool _compact = false;
  bool _showGuideGrid = true;
  bool _showBaselineGuide = true;
  bool _rtl = false;
  double _globalScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final config = _LabConfig(
      compact: _compact,
      showGuideGrid: _showGuideGrid,
      showBaselineGuide: _showBaselineGuide,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      globalScale: _globalScale,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _cInk,
          foregroundColor: Colors.white,
          toolbarHeight: 84,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('IgnoreBaseline Deep Demo'),
              const SizedBox(height: 2),
              Text(
                'Direction: ${_rtl ? 'RTL' : 'LTR'} | Baseline guide: ${_showBaselineGuide ? 'ON' : 'OFF'} | Scale: ${_globalScale.toStringAsFixed(2)}',
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
              _ControlDeck(
                compact: _compact,
                showGuideGrid: _showGuideGrid,
                showBaselineGuide: _showBaselineGuide,
                rtl: _rtl,
                scale: _globalScale,
                onCompactChanged: (value) => setState(() => _compact = value),
                onGridChanged: (value) => setState(() => _showGuideGrid = value),
                onBaselineGuideChanged: (value) => setState(() => _showBaselineGuide = value),
                onRtlChanged: (value) => setState(() => _rtl = value),
                onScaleChanged: (value) => setState(() => _globalScale = value),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 1,
                accent: _cOcean,
                title: 'Baseline Primer',
                subtitle:
                    'Introduces baseline alignment and shows what happens when mixed visual elements participate in baseline layout.',
                child: _BaselinePrimerScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 2,
                accent: _cTeal,
                title: 'IgnoreBaseline Side-by-Side',
                subtitle:
                    'Compares identical layouts with and without IgnoreBaseline to reveal how decorative widgets can be excluded from baseline calculations.',
                child: _ComparisonScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 3,
                accent: _cCoral,
                title: 'Nested Flex Baseline Lab',
                subtitle:
                    'Interactive experiment for Rows/Columns using baseline alignment with selective IgnoreBaseline wrappers and diagnostics.',
                child: _NestedFlexScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 4,
                accent: _cViolet,
                title: 'Typography Rhythm Studio',
                subtitle:
                    'Demonstrates how IgnoreBaseline helps maintain clean text rhythm by excluding ornamental glyphs from typographic baseline flow.',
                child: _RhythmStudioScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 5,
                accent: _cOlive,
                title: 'Baseline Stress Matrix',
                subtitle:
                    'Runs a broad matrix of text sizes, styles, and badge placements to show where IgnoreBaseline stabilizes line composition.',
                child: _StressMatrixScene(config: config),
              ),
              const SizedBox(height: 12),
              _SceneCard(
                index: 6,
                accent: _cInk,
                title: 'Practical Multi-Zone Dashboard',
                subtitle:
                    'A realistic dashboard where IgnoreBaseline is applied strategically in toolbars, task tables, and status strips to preserve text alignment.',
                child: _PracticalScene(config: config),
              ),
              const SizedBox(height: 12),
              const _RecapCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabConfig {
  const _LabConfig({
    required this.compact,
    required this.showGuideGrid,
    required this.showBaselineGuide,
    required this.textDirection,
    required this.globalScale,
  });

  final bool compact;
  final bool showGuideGrid;
  final bool showBaselineGuide;
  final TextDirection textDirection;
  final double globalScale;
}

class _ControlDeck extends StatelessWidget {
  const _ControlDeck({
    required this.compact,
    required this.showGuideGrid,
    required this.showBaselineGuide,
    required this.rtl,
    required this.scale,
    required this.onCompactChanged,
    required this.onGridChanged,
    required this.onBaselineGuideChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool showGuideGrid;
  final bool showBaselineGuide;
  final bool rtl;
  final double scale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGridChanged;
  final ValueChanged<bool> onBaselineGuideChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF16324C), Color(0xFF2A607A), Color(0xFF624E7D)],
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
              'IgnoreBaseline Control Deck',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'IgnoreBaseline makes a child invisible to parent baseline alignment. Use it when a decorative or status element should not pull text rhythm up or down.',
              style: TextStyle(color: Color(0xFFE8F1F9), height: 1.36),
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
                    value: showGuideGrid,
                    onChanged: onGridChanged,
                    title: const Text('Guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: SwitchListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: showBaselineGuide,
                    onChanged: onBaselineGuideChanged,
                    title: const Text('Baseline line', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
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
            const SizedBox(height: 6),
            Text('Global scale: ${scale.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            Slider(
              value: scale,
              min: 0.75,
              max: 1.5,
              divisions: 15,
              label: scale.toStringAsFixed(2),
              activeColor: Colors.white,
              inactiveColor: Colors.white.withValues(alpha: 0.3),
              onChanged: onScaleChanged,
            ),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _DeckTag(label: 'Flex baseline alignment'),
                _DeckTag(label: 'Decorative widget exclusion'),
                _DeckTag(label: 'Typography rhythm stabilization'),
                _DeckTag(label: 'Scoped production usage'),
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
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
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
                      Text(subtitle, style: const TextStyle(color: Color(0xFF304454), height: 1.36)),
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

class _BaselinePrimerScene extends StatefulWidget {
  const _BaselinePrimerScene({required this.config});

  final _LabConfig config;

  @override
  State<_BaselinePrimerScene> createState() => _BaselinePrimerSceneState();
}

class _BaselinePrimerSceneState extends State<_BaselinePrimerScene> {
  double _fontA = 18;
  double _fontB = 30;
  double _iconSize = 34;
  double _badgeScale = 1;
  bool _wrapBadge = false;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final previewHeight = config.compact ? 220.0 : 270.0;

    return SizedBox(
      height: config.compact ? 470 : 560,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: _GuideStage(
              showGrid: config.showGuideGrid,
              showBaselineLine: config.showBaselineGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Primer controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    _LabeledSlider(label: 'small text size', value: _fontA, min: 12, max: 28, onChanged: (v) => setState(() => _fontA = v)),
                    _LabeledSlider(label: 'large text size', value: _fontB, min: 22, max: 52, onChanged: (v) => setState(() => _fontB = v)),
                    _LabeledSlider(label: 'icon size', value: _iconSize, min: 20, max: 64, onChanged: (v) => setState(() => _iconSize = v)),
                    _LabeledSlider(label: 'badge scale', value: _badgeScale, min: 0.6, max: 1.8, onChanged: (v) => setState(() => _badgeScale = v)),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _wrapBadge,
                      onChanged: (v) => setState(() => _wrapBadge = v),
                      title: const Text('Wrap badge with IgnoreBaseline'),
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: _panelBox(),
                        padding: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('What baseline alignment means', style: TextStyle(fontWeight: FontWeight.w800)),
                              SizedBox(height: 6),
                              _Bullet(text: 'Baseline alignment attempts to line up text baselines across siblings.'),
                              _Bullet(text: 'Large decorative widgets can shift visual rhythm if they expose a baseline.'),
                              _Bullet(text: 'IgnoreBaseline makes a child report no baseline to parent layout.'),
                              _Bullet(text: 'Use it for ornaments, badges, and status chips near critical text rows.'),
                              _Bullet(text: 'Avoid it for text that must truly align with other text baselines.'),
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
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  child: _GuideStage(
                    showGrid: config.showGuideGrid,
                    showBaselineLine: config.showBaselineGuide,
                    baselineFraction: 0.66,
                    child: Container(
                      height: previewHeight,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Baseline-aligned row', style: TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Center(
                              child: _baselineRow(
                                fontA: _fontA,
                                fontB: _fontB,
                                iconSize: _iconSize,
                                badgeScale: _badgeScale,
                                wrapBadge: _wrapBadge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: _GuideStage(
                    showGrid: false,
                    showBaselineLine: false,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Effective values', style: TextStyle(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 8),
                          _InfoLine(label: 'small text', value: _fontA.toStringAsFixed(1)),
                          _InfoLine(label: 'large text', value: _fontB.toStringAsFixed(1)),
                          _InfoLine(label: 'icon size', value: _iconSize.toStringAsFixed(1)),
                          _InfoLine(label: 'badge scale', value: _badgeScale.toStringAsFixed(2)),
                          _InfoLine(label: 'ignore badge baseline', value: _wrapBadge ? 'true' : 'false'),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: _panelBox(),
                            child: const Text(
                              'If the badge is ornamental, wrapping it in IgnoreBaseline keeps baseline-driven text alignment cleaner.',
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
          ),
        ],
      ),
    );
  }

  Widget _baselineRow({
    required double fontA,
    required double fontB,
    required double iconSize,
    required double badgeScale,
    required bool wrapBadge,
  }) {
    final badge = Transform.scale(
      scale: badgeScale,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: _cCoral.withValues(alpha: 0.17),
          border: Border.all(color: _cCoral.withValues(alpha: 0.4)),
        ),
        child: const Text('ALERT', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11)),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('alpha', style: TextStyle(fontSize: fontA, fontWeight: FontWeight.w600, color: _cInk)),
        const SizedBox(width: 10),
        Icon(Icons.auto_awesome, size: iconSize, color: _cOcean),
        const SizedBox(width: 10),
        Text('baseline', style: TextStyle(fontSize: fontB, fontWeight: FontWeight.w800, color: _cTeal)),
        const SizedBox(width: 10),
        wrapBadge ? IgnoreBaseline(child: badge) : badge,
      ],
    );
  }
}

class _ComparisonScene extends StatefulWidget {
  const _ComparisonScene({required this.config});

  final _LabConfig config;

  @override
  State<_ComparisonScene> createState() => _ComparisonSceneState();
}

class _ComparisonSceneState extends State<_ComparisonScene> {
  bool _ignoreChip = true;
  bool _ignoreAvatar = false;
  bool _ignoreFlag = true;
  double _textSize = 24;
  double _ornamentSize = 28;
  final List<String> _events = <String>[];

  void _push(String line) {
    setState(() {
      _events.insert(0, '${_clock()} | $line');
      if (_events.length > 20) {
        _events.removeRange(20, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return SizedBox(
      height: config.compact ? 500 : 610,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: _GuideStage(
              showGrid: config.showGuideGrid,
              showBaselineLine: config.showBaselineGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Comparison controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _LabeledSlider(
                      label: 'text size',
                      value: _textSize,
                      min: 16,
                      max: 42,
                      onChanged: (v) => setState(() => _textSize = v),
                    ),
                    _LabeledSlider(
                      label: 'ornament size',
                      value: _ornamentSize,
                      min: 16,
                      max: 58,
                      onChanged: (v) => setState(() => _ornamentSize = v),
                    ),
                    const SizedBox(height: 4),
                    FilterChip(
                      selected: _ignoreChip,
                      label: const Text('Ignore chip baseline'),
                      onSelected: (v) {
                        setState(() => _ignoreChip = v);
                        _push('ignore chip = $v');
                      },
                    ),
                    const SizedBox(height: 6),
                    FilterChip(
                      selected: _ignoreAvatar,
                      label: const Text('Ignore avatar baseline'),
                      onSelected: (v) {
                        setState(() => _ignoreAvatar = v);
                        _push('ignore avatar = $v');
                      },
                    ),
                    const SizedBox(height: 6),
                    FilterChip(
                      selected: _ignoreFlag,
                      label: const Text('Ignore status flag baseline'),
                      onSelected: (v) {
                        setState(() => _ignoreFlag = v);
                        _push('ignore status flag = $v');
                      },
                    ),
                    const SizedBox(height: 8),
                    Expanded(child: _EventLog(title: 'Interaction log', events: _events)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _GuideStage(
              showGrid: config.showGuideGrid,
              showBaselineLine: config.showBaselineGuide,
              baselineFraction: 0.62,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _ComparisonColumn(
                              title: 'Normal ornaments',
                              accent: _cCoral,
                              rows: _buildRows(
                                textSize: _textSize,
                                ornamentSize: _ornamentSize,
                                forceIgnoreChip: false,
                                forceIgnoreAvatar: false,
                                forceIgnoreFlag: false,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _ComparisonColumn(
                              title: 'With IgnoreBaseline',
                              accent: _cTeal,
                              rows: _buildRows(
                                textSize: _textSize,
                                ornamentSize: _ornamentSize,
                                forceIgnoreChip: _ignoreChip,
                                forceIgnoreAvatar: _ignoreAvatar,
                                forceIgnoreFlag: _ignoreFlag,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _panelBox(),
                      child: const Text(
                        'Read this panel left-to-right: the right side selectively hides decorative baselines, which helps preserve a more stable text baseline rhythm for critical content labels.',
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

  List<_ScenarioRow> _buildRows({
    required double textSize,
    required double ornamentSize,
    required bool forceIgnoreChip,
    required bool forceIgnoreAvatar,
    required bool forceIgnoreFlag,
  }) {
    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: _cCoral.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text('HOT', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10)),
    );

    final avatar = CircleAvatar(
      radius: ornamentSize * 0.32,
      backgroundColor: _cViolet.withValues(alpha: 0.2),
      foregroundColor: _cViolet,
      child: Icon(Icons.person, size: ornamentSize * 0.56),
    );

    final flag = Container(
      width: ornamentSize,
      height: ornamentSize * 0.8,
      decoration: BoxDecoration(
        color: _cOlive.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(Icons.flag, size: ornamentSize * 0.6, color: _cOlive),
    );

    return [
      _ScenarioRow(
        label: 'Release quality',
        value: 'Excellent',
        textSize: textSize,
        ornament: forceIgnoreChip ? IgnoreBaseline(child: chip) : chip,
      ),
      _ScenarioRow(
        label: 'Owner',
        value: 'Alice Kim',
        textSize: textSize * 0.9,
        ornament: forceIgnoreAvatar ? IgnoreBaseline(child: avatar) : avatar,
      ),
      _ScenarioRow(
        label: 'Risk level',
        value: 'Moderate',
        textSize: textSize * 1.05,
        ornament: forceIgnoreFlag ? IgnoreBaseline(child: flag) : flag,
      ),
    ];
  }
}

class _ScenarioRow {
  const _ScenarioRow({
    required this.label,
    required this.value,
    required this.textSize,
    required this.ornament,
  });

  final String label;
  final String value;
  final double textSize;
  final Widget ornament;
}

class _ComparisonColumn extends StatelessWidget {
  const _ComparisonColumn({required this.title, required this.accent, required this.rows});

  final String title;
  final Color accent;
  final List<_ScenarioRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          ...rows.map(
            (entry) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFD6E2ED)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(entry.label, style: TextStyle(fontSize: entry.textSize, fontWeight: FontWeight.w700, color: _cInk)),
                  const SizedBox(width: 8),
                  entry.ornament,
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(fontSize: entry.textSize * 0.82, color: const Color(0xFF495D6E)),
                      textAlign: TextAlign.end,
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
}

class _NestedFlexScene extends StatefulWidget {
  const _NestedFlexScene({required this.config});

  final _LabConfig config;

  @override
  State<_NestedFlexScene> createState() => _NestedFlexSceneState();
}

class _NestedFlexSceneState extends State<_NestedFlexScene> {
  bool _ignoreTagA = true;
  bool _ignoreTagB = false;
  bool _ignoreTagC = true;
  bool _ignoreTagD = false;
  bool _useDenseSpacing = false;
  double _headingSize = 24;
  double _metricSize = 17;
  final List<String> _events = <String>[];

  void _log(String text) {
    setState(() {
      _events.insert(0, '${_clock()} | $text');
      if (_events.length > 24) {
        _events.removeRange(24, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final spacing = _useDenseSpacing ? 4.0 : 10.0;

    return SizedBox(
      height: config.compact ? 600 : 710,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _GuideStage(
              showGrid: config.showGuideGrid,
              showBaselineLine: config.showBaselineGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nested flex controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _LabeledSlider(label: 'heading size', value: _headingSize, min: 16, max: 42, onChanged: (v) => setState(() => _headingSize = v)),
                    _LabeledSlider(label: 'metric size', value: _metricSize, min: 12, max: 28, onChanged: (v) => setState(() => _metricSize = v)),
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      value: _useDenseSpacing,
                      onChanged: (v) {
                        setState(() => _useDenseSpacing = v);
                        _log('dense spacing = $v');
                      },
                      title: const Text('Dense spacing'),
                    ),
                    const SizedBox(height: 4),
                    _boolChip('Ignore tag A', _ignoreTagA, (v) {
                      setState(() => _ignoreTagA = v);
                      _log('ignore tag A = $v');
                    }),
                    const SizedBox(height: 6),
                    _boolChip('Ignore tag B', _ignoreTagB, (v) {
                      setState(() => _ignoreTagB = v);
                      _log('ignore tag B = $v');
                    }),
                    const SizedBox(height: 6),
                    _boolChip('Ignore tag C', _ignoreTagC, (v) {
                      setState(() => _ignoreTagC = v);
                      _log('ignore tag C = $v');
                    }),
                    const SizedBox(height: 6),
                    _boolChip('Ignore tag D', _ignoreTagD, (v) {
                      setState(() => _ignoreTagD = v);
                      _log('ignore tag D = $v');
                    }),
                    const SizedBox(height: 8),
                    Expanded(child: _EventLog(title: 'Flex lab log', events: _events)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 10,
            child: _GuideStage(
              showGrid: config.showGuideGrid,
              showBaselineLine: config.showBaselineGuide,
              baselineFraction: 0.60,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _baselineGroup(
                            title: 'Milestone overview',
                            heading: 'Release Gate',
                            metric: '92%',
                            tag: _tag('A', _cTeal),
                            ignoreTag: _ignoreTagA,
                            headingSize: _headingSize,
                            metricSize: _metricSize,
                            spacing: spacing,
                          ),
                          SizedBox(height: spacing),
                          _baselineGroup(
                            title: 'Pipeline capacity',
                            heading: 'Build Queue',
                            metric: '43 jobs',
                            tag: _tag('B', _cCoral),
                            ignoreTag: _ignoreTagB,
                            headingSize: _headingSize * 0.94,
                            metricSize: _metricSize,
                            spacing: spacing,
                          ),
                          SizedBox(height: spacing),
                          _baselineGroup(
                            title: 'Incident readiness',
                            heading: 'Hotfix Path',
                            metric: 'Green',
                            tag: _tag('C', _cViolet),
                            ignoreTag: _ignoreTagC,
                            headingSize: _headingSize * 1.05,
                            metricSize: _metricSize * 0.95,
                            spacing: spacing,
                          ),
                          SizedBox(height: spacing),
                          _baselineGroup(
                            title: 'Data quality',
                            heading: 'Verification',
                            metric: 'Stable',
                            tag: _tag('D', _cOlive),
                            ignoreTag: _ignoreTagD,
                            headingSize: _headingSize,
                            metricSize: _metricSize * 1.08,
                            spacing: spacing,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: _panelBox(),
                      child: const Text(
                        'Nested flex layouts often mix text and ornamental labels. IgnoreBaseline lets you preserve cross-row typographic rhythm while keeping badges visually expressive.',
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

  Widget _boolChip(String label, bool value, ValueChanged<bool> onSelected) {
    return FilterChip(
      selected: value,
      label: Text(label),
      onSelected: onSelected,
    );
  }

  Widget _tag(String letter, Color color) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Center(
        child: Text(letter, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
      ),
    );
  }

  Widget _baselineGroup({
    required String title,
    required String heading,
    required String metric,
    required Widget tag,
    required bool ignoreTag,
    required double headingSize,
    required double metricSize,
    required double spacing,
  }) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(spacing),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FCFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD7E2ED)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: Color(0xFF4B6070))),
            const SizedBox(height: 4),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(heading, style: TextStyle(fontSize: headingSize, fontWeight: FontWeight.w800, color: _cInk)),
                  SizedBox(width: spacing),
                  ignoreTag ? IgnoreBaseline(child: tag) : tag,
                  const Spacer(),
                  Text(metric, style: TextStyle(fontSize: metricSize, fontWeight: FontWeight.w700, color: _cOcean)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RhythmStudioScene extends StatefulWidget {
  const _RhythmStudioScene({required this.config});

  final _LabConfig config;

  @override
  State<_RhythmStudioScene> createState() => _RhythmStudioSceneState();
}

class _RhythmStudioSceneState extends State<_RhythmStudioScene> {
  int _presetIndex = 0;
  bool _ignoreAllOrnaments = true;
  bool _showAccentCapsules = true;
  bool _showMetaIcons = true;
  double _headlineScale = 1.0;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final preset = _rhythmPresets[_presetIndex];

    return SizedBox(
      height: config.compact ? 620 : 730,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _GuideStage(
              showGrid: config.showGuideGrid,
              showBaselineLine: config.showBaselineGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rhythm controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        _rhythmPresets.length,
                        (index) => ChoiceChip(
                          selected: _presetIndex == index,
                          label: Text(_rhythmPresets[index].name),
                          onSelected: (_) => setState(() => _presetIndex = index),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FilterChip(
                      selected: _ignoreAllOrnaments,
                      label: const Text('Ignore all ornament baselines'),
                      onSelected: (v) => setState(() => _ignoreAllOrnaments = v),
                    ),
                    const SizedBox(height: 6),
                    FilterChip(
                      selected: _showAccentCapsules,
                      label: const Text('Show accent capsules'),
                      onSelected: (v) => setState(() => _showAccentCapsules = v),
                    ),
                    const SizedBox(height: 6),
                    FilterChip(
                      selected: _showMetaIcons,
                      label: const Text('Show metadata icons'),
                      onSelected: (v) => setState(() => _showMetaIcons = v),
                    ),
                    const SizedBox(height: 6),
                    _LabeledSlider(
                      label: 'headline scale',
                      value: _headlineScale,
                      min: 0.8,
                      max: 1.4,
                      onChanged: (v) => setState(() => _headlineScale = v),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _panelBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Studio guidance', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _Bullet(text: 'Editorial layouts rely on clean baseline rhythm to feel readable.'),
                            _Bullet(text: 'Decorative symbols should not overpower typographic alignment.'),
                            _Bullet(text: 'IgnoreBaseline can separate ornament from textual baseline logic.'),
                            _Bullet(text: 'When ornaments carry semantic text, keep baseline participation.'),
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
            flex: 10,
            child: _GuideStage(
              showGrid: config.showGuideGrid,
              showBaselineLine: config.showBaselineGuide,
              baselineFraction: 0.58,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: preset.articles.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final article = preset.articles[index];
                          return _ArticleCard(
                            article: article,
                            headlineScale: _headlineScale,
                            ignoreOrnamentBaseline: _ignoreAllOrnaments,
                            showAccentCapsules: _showAccentCapsules,
                            showMetaIcons: _showMetaIcons,
                          );
                        },
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

class _RhythmPreset {
  const _RhythmPreset({required this.name, required this.articles});

  final String name;
  final List<_ArticleData> articles;
}

class _ArticleData {
  const _ArticleData({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.meta,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final String tag;
  final String meta;
  final IconData icon;
  final Color color;
}

const _rhythmPresets = <_RhythmPreset>[
  _RhythmPreset(
    name: 'Editorial',
    articles: [
      _ArticleData(
        title: 'Baseline Rhythm in Dense Dashboards',
        subtitle: 'How ornament-aware layout choices improve scan speed for high-density interfaces.',
        tag: 'Insight',
        meta: '7 min read',
        icon: Icons.auto_stories,
        color: _cOcean,
      ),
      _ArticleData(
        title: 'Typography and Signals',
        subtitle: 'Balancing textual hierarchy with alerts, badges, and iconography in operational tools.',
        tag: 'Guide',
        meta: '5 min read',
        icon: Icons.design_services,
        color: _cTeal,
      ),
      _ArticleData(
        title: 'When Decorative UI Should Stay Silent',
        subtitle: 'Practical criteria for excluding non-text visuals from baseline calculations.',
        tag: 'Pattern',
        meta: '8 min read',
        icon: Icons.lightbulb,
        color: _cViolet,
      ),
    ],
  ),
  _RhythmPreset(
    name: 'Operations',
    articles: [
      _ArticleData(
        title: 'Service Health Digest',
        subtitle: 'Morning baseline: stability metrics, error trend watch, and active mitigations.',
        tag: 'Ops',
        meta: 'Updated 2h ago',
        icon: Icons.monitor_heart,
        color: _cOlive,
      ),
      _ArticleData(
        title: 'Build Throughput Report',
        subtitle: 'Queue pressure, cycle time, and lane saturation with human-friendly typography.',
        tag: 'Delivery',
        meta: 'Updated 45m ago',
        icon: Icons.speed,
        color: _cCoral,
      ),
      _ArticleData(
        title: 'Deployment Window Notes',
        subtitle: 'Risk envelopes and rollback readiness summarized in aligned visual blocks.',
        tag: 'Release',
        meta: 'Updated now',
        icon: Icons.rocket_launch,
        color: _cOcean,
      ),
    ],
  ),
  _RhythmPreset(
    name: 'Product',
    articles: [
      _ArticleData(
        title: 'Navigation Consistency Sweep',
        subtitle: 'Audit of icon/text relationships across app shells and embedded tools.',
        tag: 'UX',
        meta: 'Owner: Team Atlas',
        icon: Icons.route,
        color: _cViolet,
      ),
      _ArticleData(
        title: 'Status Language Refresh',
        subtitle: 'Refactoring stale labels and decorative markers for clearer intent communication.',
        tag: 'Content',
        meta: 'Owner: Team Nova',
        icon: Icons.edit_note,
        color: _cTeal,
      ),
      _ArticleData(
        title: 'Telemetry Storyboard',
        subtitle: 'Making trend cards legible under pressure without sacrificing visual richness.',
        tag: 'Analytics',
        meta: 'Owner: Team Flux',
        icon: Icons.query_stats,
        color: _cCoral,
      ),
    ],
  ),
];

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({
    required this.article,
    required this.headlineScale,
    required this.ignoreOrnamentBaseline,
    required this.showAccentCapsules,
    required this.showMetaIcons,
  });

  final _ArticleData article;
  final double headlineScale;
  final bool ignoreOrnamentBaseline;
  final bool showAccentCapsules;
  final bool showMetaIcons;

  @override
  Widget build(BuildContext context) {
    final ornament = Icon(article.icon, size: 28, color: article.color);
    final ornamentWidget = ignoreOrnamentBaseline ? IgnoreBaseline(child: ornament) : ornament;

    final capsule = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: article.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: article.color.withValues(alpha: 0.35)),
      ),
      child: Text(article.tag, style: TextStyle(color: article.color, fontWeight: FontWeight.w800, fontSize: 11)),
    );

    final capsuleWidget = ignoreOrnamentBaseline ? IgnoreBaseline(child: capsule) : capsule;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E2ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              ornamentWidget,
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  article.title,
                  style: TextStyle(fontSize: 21 * headlineScale, fontWeight: FontWeight.w800, color: _cInk),
                ),
              ),
              if (showAccentCapsules) ...[
                const SizedBox(width: 8),
                capsuleWidget,
              ],
            ],
          ),
          const SizedBox(height: 6),
          Text(article.subtitle, style: const TextStyle(height: 1.35, color: Color(0xFF465B6D))),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              if (showMetaIcons) ...[
                ignoreOrnamentBaseline
                    ? IgnoreBaseline(child: const Icon(Icons.schedule, size: 16, color: Color(0xFF557089)))
                    : const Icon(Icons.schedule, size: 16, color: Color(0xFF557089)),
                const SizedBox(width: 6),
              ],
              Text(article.meta, style: const TextStyle(fontSize: 12, color: Color(0xFF5B7081))),
            ],
          ),
        ],
      ),
    );
  }
}

class _StressMatrixScene extends StatefulWidget {
  const _StressMatrixScene({required this.config});

  final _LabConfig config;

  @override
  State<_StressMatrixScene> createState() => _StressMatrixSceneState();
}

class _StressMatrixSceneState extends State<_StressMatrixScene> {
  bool _ignoreOrnaments = true;
  bool _uppercase = false;
  bool _showSecondaryText = true;
  int _fontFamilyIndex = 0;
  double _globalFontDelta = 0;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return SizedBox(
      height: config.compact ? 700 : 820,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _GuideStage(
              showGrid: config.showGuideGrid,
              showBaselineLine: config.showBaselineGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Matrix controls', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    FilterChip(
                      selected: _ignoreOrnaments,
                      label: const Text('Ignore ornament baselines'),
                      onSelected: (v) => setState(() => _ignoreOrnaments = v),
                    ),
                    const SizedBox(height: 6),
                    FilterChip(
                      selected: _uppercase,
                      label: const Text('Uppercase titles'),
                      onSelected: (v) => setState(() => _uppercase = v),
                    ),
                    const SizedBox(height: 6),
                    FilterChip(
                      selected: _showSecondaryText,
                      label: const Text('Show secondary text'),
                      onSelected: (v) => setState(() => _showSecondaryText = v),
                    ),
                    const SizedBox(height: 8),
                    _LabeledSlider(
                      label: 'global font delta',
                      value: _globalFontDelta,
                      min: -5,
                      max: 8,
                      onChanged: (v) => setState(() => _globalFontDelta = v),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List<Widget>.generate(
                        _fontFamilies.length,
                        (index) => ChoiceChip(
                          selected: _fontFamilyIndex == index,
                          label: Text(_fontFamilies[index]),
                          onSelected: (_) => setState(() => _fontFamilyIndex = index),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: _panelBox(),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Matrix intent', style: TextStyle(fontWeight: FontWeight.w800)),
                            SizedBox(height: 6),
                            _Bullet(text: 'Stress test line composition under diverse text scales and ornaments.'),
                            _Bullet(text: 'Compare readability with decorative baseline participation on/off.'),
                            _Bullet(text: 'Observe where labels remain stable versus where drift appears.'),
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
            flex: 10,
            child: _GuideStage(
              showGrid: config.showGuideGrid,
              showBaselineLine: config.showBaselineGuide,
              baselineFraction: 0.6,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: _matrixCases.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.22,
                  ),
                  itemBuilder: (context, index) {
                    final item = _matrixCases[index];
                    return _MatrixTile(
                      item: item,
                      ignoreOrnaments: _ignoreOrnaments,
                      uppercase: _uppercase,
                      showSecondaryText: _showSecondaryText,
                      fontFamily: _fontFamilies[_fontFamilyIndex],
                      globalFontDelta: _globalFontDelta,
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
}

class _MatrixCase {
  const _MatrixCase({
    required this.title,
    required this.status,
    required this.icon,
    required this.color,
    required this.headlineSize,
    required this.secondarySize,
    required this.badge,
  });

  final String title;
  final String status;
  final IconData icon;
  final Color color;
  final double headlineSize;
  final double secondarySize;
  final String badge;
}

const _matrixCases = <_MatrixCase>[
  _MatrixCase(title: 'Asset Sync', status: 'Stable', icon: Icons.sync, color: _cOcean, headlineSize: 18, secondarySize: 12, badge: 'A1'),
  _MatrixCase(title: 'Gate Health', status: 'Warning', icon: Icons.health_and_safety, color: _cCoral, headlineSize: 23, secondarySize: 12, badge: 'B2'),
  _MatrixCase(title: 'Release Notes', status: 'Draft', icon: Icons.notes, color: _cViolet, headlineSize: 20, secondarySize: 13, badge: 'C3'),
  _MatrixCase(title: 'Policy Drift', status: 'Review', icon: Icons.rule, color: _cTeal, headlineSize: 19, secondarySize: 11, badge: 'D4'),
  _MatrixCase(title: 'Queue Depth', status: 'High', icon: Icons.layers, color: _cOlive, headlineSize: 25, secondarySize: 13, badge: 'E5'),
  _MatrixCase(title: 'SLA Pulse', status: 'On track', icon: Icons.favorite, color: _cOcean, headlineSize: 21, secondarySize: 12, badge: 'F6'),
  _MatrixCase(title: 'Telemetry', status: 'Rising', icon: Icons.query_stats, color: _cCoral, headlineSize: 17, secondarySize: 11, badge: 'G7'),
  _MatrixCase(title: 'Ops Window', status: 'Open', icon: Icons.timelapse, color: _cViolet, headlineSize: 24, secondarySize: 13, badge: 'H8'),
  _MatrixCase(title: 'Recovery', status: 'Ready', icon: Icons.restore, color: _cTeal, headlineSize: 20, secondarySize: 12, badge: 'I9'),
  _MatrixCase(title: 'Routing', status: 'Balanced', icon: Icons.route, color: _cOlive, headlineSize: 22, secondarySize: 13, badge: 'J10'),
  _MatrixCase(title: 'Audit', status: 'Pending', icon: Icons.fact_check, color: _cOcean, headlineSize: 19, secondarySize: 12, badge: 'K11'),
  _MatrixCase(title: 'Integrity', status: 'Verified', icon: Icons.verified, color: _cCoral, headlineSize: 23, secondarySize: 12, badge: 'L12'),
];

const _fontFamilies = <String>[
  'Roboto',
  'monospace',
  'serif',
];

class _MatrixTile extends StatelessWidget {
  const _MatrixTile({
    required this.item,
    required this.ignoreOrnaments,
    required this.uppercase,
    required this.showSecondaryText,
    required this.fontFamily,
    required this.globalFontDelta,
  });

  final _MatrixCase item;
  final bool ignoreOrnaments;
  final bool uppercase;
  final bool showSecondaryText;
  final String fontFamily;
  final double globalFontDelta;

  @override
  Widget build(BuildContext context) {
    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(item.badge, style: TextStyle(fontSize: 10, color: item.color, fontWeight: FontWeight.w800)),
    );

    final icon = Icon(item.icon, size: 20, color: item.color);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: item.color.withValues(alpha: 0.36)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              ignoreOrnaments ? IgnoreBaseline(child: icon) : icon,
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  uppercase ? item.title.toUpperCase() : item.title,
                  style: TextStyle(
                    fontSize: item.headlineSize + globalFontDelta,
                    fontWeight: FontWeight.w800,
                    color: _cInk,
                    fontFamily: fontFamily,
                  ),
                ),
              ),
              ignoreOrnaments ? IgnoreBaseline(child: badge) : badge,
            ],
          ),
          const SizedBox(height: 6),
          if (showSecondaryText)
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  item.status,
                  style: TextStyle(
                    fontSize: item.secondarySize + (globalFontDelta * 0.4),
                    color: const Color(0xFF516577),
                    fontFamily: fontFamily,
                  ),
                ),
                const Spacer(),
                Text('Baseline sample', style: TextStyle(fontSize: 10, color: item.color.withValues(alpha: 0.85), fontFamily: fontFamily)),
              ],
            ),
        ],
      ),
    );
  }
}

class _PracticalScene extends StatefulWidget {
  const _PracticalScene({required this.config});

  final _LabConfig config;

  @override
  State<_PracticalScene> createState() => _PracticalSceneState();
}

class _PracticalSceneState extends State<_PracticalScene> {
  int _themeProfile = 0;
  int _moduleIndex = 0;
  bool _ignoreToolbarDecor = true;
  bool _ignoreTableDecor = true;
  bool _ignoreFooterDecor = false;
  bool _showLabels = true;
  final List<String> _events = <String>[];

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
    final profile = _profiles[_themeProfile];
    final module = profile.modules[_moduleIndex];

    return SizedBox(
      height: config.compact ? 740 : 870,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _GuideStage(
              showGrid: config.showGuideGrid,
              showBaselineLine: config.showBaselineGuide,
              baselineFraction: 0.55,
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
                          selected: _themeProfile == index,
                          label: Text(_profiles[index].name),
                          onSelected: (_) {
                            setState(() {
                              _themeProfile = index;
                              _moduleIndex = 0;
                            });
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
                          selected: _ignoreToolbarDecor,
                          label: const Text('Ignore toolbar ornaments'),
                          onSelected: (v) {
                            setState(() => _ignoreToolbarDecor = v);
                            _push('toolbar ignore = $v');
                          },
                        ),
                        FilterChip(
                          selected: _ignoreTableDecor,
                          label: const Text('Ignore table ornaments'),
                          onSelected: (v) {
                            setState(() => _ignoreTableDecor = v);
                            _push('table ignore = $v');
                          },
                        ),
                        FilterChip(
                          selected: _ignoreFooterDecor,
                          label: const Text('Ignore footer ornaments'),
                          onSelected: (v) {
                            setState(() => _ignoreFooterDecor = v);
                            _push('footer ignore = $v');
                          },
                        ),
                        FilterChip(
                          selected: _showLabels,
                          label: const Text('Show rail labels'),
                          onSelected: (v) {
                            setState(() => _showLabels = v);
                            _push('rail labels = $v');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD6E2ED)),
                        ),
                        child: Column(
                          children: [
                            _dashboardTopBar(profile),
                            Expanded(
                              child: Row(
                                children: [
                                  _dashboardRail(profile),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        _moduleTabs(profile),
                                        Expanded(child: _moduleTable(module)),
                                      ],
                                    ),
                                  ),
                                  _dashboardAlerts(profile),
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
            child: _EventLog(title: 'Dashboard log', events: _events),
          ),
        ],
      ),
    );
  }

  Widget _dashboardTopBar(_ProfileData profile) {
    final leading = Icon(profile.leading, color: profile.color, size: 20);
    final leadingWidget = _ignoreToolbarDecor ? IgnoreBaseline(child: leading) : leading;

    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: profile.color.withValues(alpha: 0.12),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: const Border(bottom: BorderSide(color: Color(0xFFD6E2ED))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          leadingWidget,
          const SizedBox(width: 8),
          Text(profile.name, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: _cInk)),
          const Spacer(),
          ...profile.topActions.map((entry) {
            final icon = Icon(entry.icon, size: 18, color: _cInk);
            final iconWidget = _ignoreToolbarDecor ? IgnoreBaseline(child: icon) : icon;
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _push('top action ${entry.label}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      iconWidget,
                      const SizedBox(width: 4),
                      Text(entry.label, style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _dashboardRail(_ProfileData profile) {
    return Container(
      width: 98,
      decoration: const BoxDecoration(
        color: Color(0xFFF8FBFF),
        border: Border(right: BorderSide(color: Color(0xFFD6E2ED))),
      ),
      child: Column(
        children: List<Widget>.generate(profile.rail.length, (index) {
          final entry = profile.rail[index];
          final selected = index == _moduleIndex;
          return InkWell(
            onTap: () {
              setState(() => _moduleIndex = index);
              _push('module index = $index');
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: selected ? profile.color.withValues(alpha: 0.12) : Colors.transparent,
              child: Column(
                children: [
                  Icon(entry.icon, color: selected ? profile.color : _cInk, size: 20),
                  const SizedBox(height: 3),
                  if (_showLabels)
                    Text(
                      entry.label,
                      style: TextStyle(fontSize: 10, color: selected ? profile.color : const Color(0xFF526676)),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _moduleTabs(_ProfileData profile) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD6E2ED)))),
      child: Row(
        children: [
          Text('Module: ${profile.modules[_moduleIndex].name}', style: const TextStyle(fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('IgnoreBaseline in table: ${_ignoreTableDecor ? 'ON' : 'OFF'}', style: const TextStyle(fontSize: 11, color: Color(0xFF586C7D))),
        ],
      ),
    );
  }

  Widget _moduleTable(_ModuleData module) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: module.rows.length,
      separatorBuilder: (_, _) => const SizedBox(height: 6),
      itemBuilder: (context, index) {
        final row = module.rows[index];
        final chip = Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: row.color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(row.badge, style: TextStyle(fontSize: 10, color: row.color, fontWeight: FontWeight.w800)),
        );
        final chipWidget = _ignoreTableDecor ? IgnoreBaseline(child: chip) : chip;
        final icon = Icon(row.icon, size: 18, color: row.color);
        final iconWidget = _ignoreTableDecor ? IgnoreBaseline(child: icon) : icon;

        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => _push('row tap ${row.title}'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: row.color.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                iconWidget,
                const SizedBox(width: 8),
                Expanded(
                  child: Text(row.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _cInk)),
                ),
                chipWidget,
                const SizedBox(width: 8),
                Text(row.state, style: const TextStyle(fontSize: 12, color: Color(0xFF556879))),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dashboardAlerts(_ProfileData profile) {
    return Container(
      width: 190,
      decoration: const BoxDecoration(
        color: Color(0xFFFCF7F7),
        border: Border(left: BorderSide(color: Color(0xFFD6E2ED))),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Alerts', style: TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            ...profile.alerts.map((entry) {
              final icon = Icon(entry.icon, size: 16, color: entry.color);
              final iconWidget = _ignoreTableDecor ? IgnoreBaseline(child: icon) : icon;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: entry.color.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: entry.color.withValues(alpha: 0.35)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    iconWidget,
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(entry.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(entry.note, style: const TextStyle(fontSize: 11, height: 1.3)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _dashboardFooter(_ProfileData profile) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFD),
        border: Border(top: BorderSide(color: Color(0xFFD6E2ED))),
      ),
      child: Row(
        children: [
          ...profile.footerActions.map((entry) {
            final icon = Icon(entry.icon, size: 15, color: _cInk);
            final iconWidget = _ignoreFooterDecor ? IgnoreBaseline(child: icon) : icon;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _push('footer action ${entry.label}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      iconWidget,
                      const SizedBox(width: 4),
                      Text(entry.label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          Text('Profile tone: ${profile.name}', style: const TextStyle(fontSize: 11, color: Color(0xFF596C7D))),
        ],
      ),
    );
  }
}

class _ProfileData {
  const _ProfileData({
    required this.name,
    required this.color,
    required this.leading,
    required this.topActions,
    required this.rail,
    required this.modules,
    required this.alerts,
    required this.footerActions,
  });

  final String name;
  final Color color;
  final IconData leading;
  final List<_ActionItem> topActions;
  final List<_ActionItem> rail;
  final List<_ModuleData> modules;
  final List<_AlertData> alerts;
  final List<_ActionItem> footerActions;
}

class _ActionItem {
  const _ActionItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class _ModuleData {
  const _ModuleData({required this.name, required this.rows});

  final String name;
  final List<_ModuleRow> rows;
}

class _ModuleRow {
  const _ModuleRow({
    required this.title,
    required this.badge,
    required this.state,
    required this.icon,
    required this.color,
  });

  final String title;
  final String badge;
  final String state;
  final IconData icon;
  final Color color;
}

class _AlertData {
  const _AlertData({required this.title, required this.note, required this.icon, required this.color});

  final String title;
  final String note;
  final IconData icon;
  final Color color;
}

const _profiles = <_ProfileData>[
  _ProfileData(
    name: 'Calm Ops',
    color: _cOcean,
    leading: Icons.dashboard,
    topActions: [
      _ActionItem(icon: Icons.search, label: 'Search'),
      _ActionItem(icon: Icons.filter_alt, label: 'Filter'),
      _ActionItem(icon: Icons.more_horiz, label: 'More'),
    ],
    rail: [
      _ActionItem(icon: Icons.route, label: 'Plan'),
      _ActionItem(icon: Icons.timeline, label: 'Flow'),
      _ActionItem(icon: Icons.rocket_launch, label: 'Ship'),
    ],
    modules: [
      _ModuleData(
        name: 'Plan',
        rows: [
          _ModuleRow(title: 'Roadmap quality review', badge: 'P1', state: 'Good', icon: Icons.alt_route, color: _cOcean),
          _ModuleRow(title: 'Dependency bottleneck scan', badge: 'P2', state: 'Watch', icon: Icons.account_tree, color: _cTeal),
          _ModuleRow(title: 'Risk backlog triage', badge: 'P3', state: 'Moderate', icon: Icons.warning_amber, color: _cCoral),
          _ModuleRow(title: 'Budget variance digest', badge: 'P4', state: 'Stable', icon: Icons.pie_chart, color: _cViolet),
        ],
      ),
      _ModuleData(
        name: 'Flow',
        rows: [
          _ModuleRow(title: 'Queue pressure', badge: 'F1', state: 'High', icon: Icons.layers, color: _cCoral),
          _ModuleRow(title: 'Lane handoff quality', badge: 'F2', state: 'Good', icon: Icons.hub, color: _cTeal),
          _ModuleRow(title: 'Cycle-time trend', badge: 'F3', state: 'Rising', icon: Icons.speed, color: _cViolet),
          _ModuleRow(title: 'SLA confidence', badge: 'F4', state: 'Healthy', icon: Icons.monitor_heart, color: _cOcean),
        ],
      ),
      _ModuleData(
        name: 'Ship',
        rows: [
          _ModuleRow(title: 'Gate checklist', badge: 'S1', state: 'Complete', icon: Icons.gpp_good, color: _cTeal),
          _ModuleRow(title: 'Canary rollout', badge: 'S2', state: '31%', icon: Icons.cloud_upload, color: _cOcean),
          _ModuleRow(title: 'Rollback readiness', badge: 'S3', state: 'Ready', icon: Icons.restore, color: _cViolet),
          _ModuleRow(title: 'Telemetry drift', badge: 'S4', state: 'Low', icon: Icons.query_stats, color: _cOlive),
        ],
      ),
    ],
    alerts: [
      _AlertData(title: 'Latency bump', note: 'API p95 rose by 11%.', icon: Icons.speed, color: _cCoral),
      _AlertData(title: 'Queue depth', note: 'Build queue above baseline.', icon: Icons.timer, color: _cOlive),
      _AlertData(title: 'Risk note', note: 'Policy check due in 2h.', icon: Icons.rule, color: _cViolet),
    ],
    footerActions: [
      _ActionItem(icon: Icons.download, label: 'Export'),
      _ActionItem(icon: Icons.bookmark, label: 'Snapshot'),
      _ActionItem(icon: Icons.share, label: 'Share'),
    ],
  ),
  _ProfileData(
    name: 'Incident Focus',
    color: _cCoral,
    leading: Icons.local_fire_department,
    topActions: [
      _ActionItem(icon: Icons.notifications_active, label: 'Alerts'),
      _ActionItem(icon: Icons.call, label: 'Bridge'),
      _ActionItem(icon: Icons.more_horiz, label: 'More'),
    ],
    rail: [
      _ActionItem(icon: Icons.crisis_alert, label: 'Incidents'),
      _ActionItem(icon: Icons.shield, label: 'Contain'),
      _ActionItem(icon: Icons.restore, label: 'Recover'),
    ],
    modules: [
      _ModuleData(
        name: 'Incidents',
        rows: [
          _ModuleRow(title: 'Primary outage timeline', badge: 'I1', state: 'Live', icon: Icons.timeline, color: _cCoral),
          _ModuleRow(title: 'Owner routing map', badge: 'I2', state: 'Assigned', icon: Icons.person_pin_circle, color: _cViolet),
          _ModuleRow(title: 'Comms cadence', badge: 'I3', state: 'On time', icon: Icons.campaign, color: _cTeal),
          _ModuleRow(title: 'Escalation matrix', badge: 'I4', state: 'Active', icon: Icons.warning, color: _cOlive),
        ],
      ),
      _ModuleData(
        name: 'Contain',
        rows: [
          _ModuleRow(title: 'Boundary rule patch', badge: 'C1', state: 'Applied', icon: Icons.security, color: _cCoral),
          _ModuleRow(title: 'Rate cap tuning', badge: 'C2', state: 'Running', icon: Icons.filter_alt, color: _cTeal),
          _ModuleRow(title: 'Fallback lane', badge: 'C3', state: 'Ready', icon: Icons.low_priority, color: _cViolet),
          _ModuleRow(title: 'Health probe', badge: 'C4', state: 'Green', icon: Icons.monitor_heart, color: _cOlive),
        ],
      ),
      _ModuleData(
        name: 'Recover',
        rows: [
          _ModuleRow(title: 'Rollback candidate', badge: 'R1', state: 'Prepared', icon: Icons.undo, color: _cCoral),
          _ModuleRow(title: 'Repair scripts', badge: 'R2', state: 'Running', icon: Icons.auto_fix_high, color: _cTeal),
          _ModuleRow(title: 'Validation checks', badge: 'R3', state: 'Pending', icon: Icons.fact_check, color: _cViolet),
          _ModuleRow(title: 'Closure report', badge: 'R4', state: 'Draft', icon: Icons.description, color: _cOlive),
        ],
      ),
    ],
    alerts: [
      _AlertData(title: 'Critical path', note: 'Checkout API unstable.', icon: Icons.warning_amber, color: _cCoral),
      _AlertData(title: 'Data lag', note: 'Replication queue elevated.', icon: Icons.sync_problem, color: _cViolet),
      _AlertData(title: 'Client impact', note: 'Error budget at 68%.', icon: Icons.support_agent, color: _cTeal),
    ],
    footerActions: [
      _ActionItem(icon: Icons.call, label: 'War room'),
      _ActionItem(icon: Icons.book, label: 'Runbook'),
      _ActionItem(icon: Icons.archive, label: 'Archive'),
    ],
  ),
  _ProfileData(
    name: 'Design Lens',
    color: _cViolet,
    leading: Icons.palette,
    topActions: [
      _ActionItem(icon: Icons.layers, label: 'Layers'),
      _ActionItem(icon: Icons.text_fields, label: 'Type'),
      _ActionItem(icon: Icons.more_horiz, label: 'More'),
    ],
    rail: [
      _ActionItem(icon: Icons.style, label: 'Tokens'),
      _ActionItem(icon: Icons.widgets, label: 'Components'),
      _ActionItem(icon: Icons.fact_check, label: 'Review'),
    ],
    modules: [
      _ModuleData(
        name: 'Tokens',
        rows: [
          _ModuleRow(title: 'Palette token sync', badge: 'T1', state: 'Aligned', icon: Icons.color_lens, color: _cViolet),
          _ModuleRow(title: 'Type scale audit', badge: 'T2', state: 'Review', icon: Icons.format_size, color: _cOcean),
          _ModuleRow(title: 'Radius consistency', badge: 'T3', state: 'Stable', icon: Icons.rounded_corner, color: _cTeal),
          _ModuleRow(title: 'Depth language', badge: 'T4', state: 'Draft', icon: Icons.layers, color: _cOlive),
        ],
      ),
      _ModuleData(
        name: 'Components',
        rows: [
          _ModuleRow(title: 'Button state matrix', badge: 'C1', state: 'Pass', icon: Icons.smart_button, color: _cViolet),
          _ModuleRow(title: 'Form rhythm', badge: 'C2', state: 'Pass', icon: Icons.input, color: _cOcean),
          _ModuleRow(title: 'Navigation cues', badge: 'C3', state: 'Watch', icon: Icons.menu, color: _cTeal),
          _ModuleRow(title: 'Feedback styling', badge: 'C4', state: 'Refine', icon: Icons.chat, color: _cOlive),
        ],
      ),
      _ModuleData(
        name: 'Review',
        rows: [
          _ModuleRow(title: 'Contrast report', badge: 'R1', state: 'Good', icon: Icons.visibility, color: _cViolet),
          _ModuleRow(title: 'Motion timing', badge: 'R2', state: 'Good', icon: Icons.animation, color: _cOcean),
          _ModuleRow(title: 'Localization pass', badge: 'R3', state: 'Pending', icon: Icons.translate, color: _cTeal),
          _ModuleRow(title: 'Sign-off queue', badge: 'R4', state: 'Queued', icon: Icons.verified, color: _cOlive),
        ],
      ),
    ],
    alerts: [
      _AlertData(title: 'Contrast warning', note: 'Two icon-label pairs below threshold.', icon: Icons.visibility_off, color: _cCoral),
      _AlertData(title: 'Token drift', note: 'Unmapped semantic token detected.', icon: Icons.error_outline, color: _cViolet),
      _AlertData(title: 'Review SLA', note: 'Design review due in 4h.', icon: Icons.timer, color: _cTeal),
    ],
    footerActions: [
      _ActionItem(icon: Icons.file_download, label: 'Export'),
      _ActionItem(icon: Icons.auto_awesome, label: 'Generate'),
      _ActionItem(icon: Icons.send, label: 'Submit'),
    ],
  ),
];

class _GuideStage extends StatelessWidget {
  const _GuideStage({
    required this.showGrid,
    required this.showBaselineLine,
    required this.child,
    this.baselineFraction = 0.6,
  });

  final bool showGrid;
  final bool showBaselineLine;
  final double baselineFraction;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD7E2ED)),
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FCFF), Color(0xFFECF3FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid || showBaselineLine)
            CustomPaint(
              painter: _GuidePainter(
                showGrid: showGrid,
                showBaselineLine: showBaselineLine,
                baselineFraction: baselineFraction,
              ),
            ),
          child,
        ],
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
  _GuidePainter({required this.showGrid, required this.showBaselineLine, required this.baselineFraction});

  final bool showGrid;
  final bool showBaselineLine;
  final double baselineFraction;

  @override
  void paint(Canvas canvas, Size size) {
    if (showGrid) {
      final grid = Paint()..color = const Color(0x11000000);
      const step = 22.0;
      for (double x = 0; x <= size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }

    if (showBaselineLine) {
      final y = size.height * baselineFraction;
      final baseline = Paint()
        ..color = const Color(0xAAE24D6B)
        ..strokeWidth = 1.6;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), baseline);
      final label = TextPainter(
        text: const TextSpan(
          text: 'baseline guide',
          style: TextStyle(fontSize: 10, color: Color(0xCCB1324B), fontWeight: FontWeight.w700),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      label.paint(canvas, Offset(6, y - 14));
    }
  }

  @override
  bool shouldRepaint(covariant _GuidePainter oldDelegate) {
    return oldDelegate.showGrid != showGrid ||
        oldDelegate.showBaselineLine != showBaselineLine ||
        oldDelegate.baselineFraction != baselineFraction;
  }
}

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
          SizedBox(width: 170, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
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
            child: Icon(Icons.circle, size: 7, color: Color(0xFF3B5A72)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.34))),
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
        border: Border.all(color: const Color(0xFFD9E4F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No events yet.', style: TextStyle(color: Color(0xFF5C7182)))
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
        color: const Color(0xFF172F44),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: IgnoreBaseline', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'IgnoreBaseline is a surgical layout tool: it prevents a child from contributing baseline information to parent baseline alignment. Use it when decorative widgets should stay visually present but typographically silent.',
            style: TextStyle(color: Color(0xFFD8E6F3), height: 1.38),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _panelBox() {
  return BoxDecoration(
    color: const Color(0xFFF2F7FC),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: const Color(0xFFD7E2EE)),
  );
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
