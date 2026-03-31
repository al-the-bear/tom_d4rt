import 'package:flutter/material.dart';

const _cNavy = Color(0xFF1E4E75);
const _cAmber = Color(0xFFC57B35);
const _cTeal = Color(0xFF277E71);
const _cRose = Color(0xFF92466A);
const _cIndigo = Color(0xFF5653A0);
const _cOlive = Color(0xFF6B682D);

dynamic build(BuildContext context) {
  return const _FlexDeepDemoApp();
}

class _FlexDeepDemoApp extends StatelessWidget {
  const _FlexDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cNavy),
      ),
      home: const _FlexDemoPage(),
    );
  }
}

class _FlexDemoPage extends StatefulWidget {
  const _FlexDemoPage();

  @override
  State<_FlexDemoPage> createState() => _FlexDemoPageState();
}

class _FlexDemoPageState extends State<_FlexDemoPage> {
  bool _rtl = false;
  bool _compact = false;
  bool _showGrid = true;

  Axis _axis = Axis.horizontal;
  double _spacing = 8;
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  MainAxisSize _mainAxisSize = MainAxisSize.max;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.center;
  VerticalDirection _verticalDirection = VerticalDirection.down;

  @override
  Widget build(BuildContext context) {
    final config = _FlexConfig(
      compact: _compact,
      showGrid: _showGrid,
      axis: _axis,
      spacing: _spacing,
      mainAxisAlignment: _mainAxisAlignment,
      mainAxisSize: _mainAxisSize,
      crossAxisAlignment: _crossAxisAlignment,
      verticalDirection: _verticalDirection,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F5F8),
        appBar: AppBar(
          backgroundColor: _cNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 78,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Flex Deep Demo'),
              const SizedBox(height: 2),
              Text(
                _rtl ? 'Ambient Direction: RTL' : 'Ambient Direction: LTR',
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
              _HeroDeck(
                rtl: _rtl,
                compact: _compact,
                showGrid: _showGrid,
                axis: _axis,
                spacing: _spacing,
                mainAxisAlignment: _mainAxisAlignment,
                mainAxisSize: _mainAxisSize,
                crossAxisAlignment: _crossAxisAlignment,
                verticalDirection: _verticalDirection,
                onRtlChanged: (value) => setState(() => _rtl = value),
                onCompactChanged: (value) => setState(() => _compact = value),
                onShowGridChanged: (value) => setState(() => _showGrid = value),
                onAxisChanged: (value) => setState(() => _axis = value),
                onSpacingChanged: (value) => setState(() => _spacing = value),
                onMainAxisAlignmentChanged: (value) => setState(() => _mainAxisAlignment = value),
                onMainAxisSizeChanged: (value) => setState(() => _mainAxisSize = value),
                onCrossAxisAlignmentChanged: (value) => setState(() => _crossAxisAlignment = value),
                onVerticalDirectionChanged: (value) => setState(() => _verticalDirection = value),
              ),
              const SizedBox(height: 12),
              const _ScenePanel(
                index: 1,
                accent: _cNavy,
                title: 'Flex Fundamentals and Layout Steps',
                subtitle:
                    'Understand Flex as the generic engine behind Row and Column, including the six-step layout process from the framework docs.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 2,
                accent: _cAmber,
                title: 'Direction and Main/Cross Axis Lab',
                subtitle:
                    'Switch horizontal/vertical direction and see how main and cross axis semantics move with the chosen axis.',
                child: _AxisLabScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 3,
                accent: _cTeal,
                title: 'Alignment Matrix and Spacing',
                subtitle:
                    'Interactively compare MainAxisAlignment, CrossAxisAlignment, mainAxisSize, and spacing with immediate visual feedback.',
                child: _AlignmentMatrixScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 4,
                accent: _cRose,
                title: 'Flexible, Expanded, and Space Distribution',
                subtitle:
                    'Explore flex factors and FlexFit modes to understand how leftover main-axis space is allocated and constrained.',
                child: _FlexibleExpandedScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 5,
                accent: _cIndigo,
                title: 'Baseline Alignment and Typography',
                subtitle:
                    'Demonstrates CrossAxisAlignment.baseline with mixed font metrics and highlights when textBaseline is required.',
                child: _BaselineScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 6,
                accent: _cOlive,
                title: 'Overflow, ClipBehavior, and Practical Nested Flex',
                subtitle:
                    'Inspect clipping with overflowing children and finish with a realistic dashboard layout built with nested Flex widgets.',
                child: _ClipAndPracticalScene(config: config),
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

class _FlexConfig {
  const _FlexConfig({
    required this.compact,
    required this.showGrid,
    required this.axis,
    required this.spacing,
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required this.crossAxisAlignment,
    required this.verticalDirection,
    required this.textDirection,
  });

  final bool compact;
  final bool showGrid;
  final Axis axis;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final TextDirection textDirection;
}

class _HeroDeck extends StatelessWidget {
  const _HeroDeck({
    required this.rtl,
    required this.compact,
    required this.showGrid,
    required this.axis,
    required this.spacing,
    required this.mainAxisAlignment,
    required this.mainAxisSize,
    required this.crossAxisAlignment,
    required this.verticalDirection,
    required this.onRtlChanged,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onAxisChanged,
    required this.onSpacingChanged,
    required this.onMainAxisAlignmentChanged,
    required this.onMainAxisSizeChanged,
    required this.onCrossAxisAlignmentChanged,
    required this.onVerticalDirectionChanged,
  });

  final bool rtl;
  final bool compact;
  final bool showGrid;
  final Axis axis;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;

  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<Axis> onAxisChanged;
  final ValueChanged<double> onSpacingChanged;
  final ValueChanged<MainAxisAlignment> onMainAxisAlignmentChanged;
  final ValueChanged<MainAxisSize> onMainAxisSizeChanged;
  final ValueChanged<CrossAxisAlignment> onCrossAxisAlignmentChanged;
  final ValueChanged<VerticalDirection> onVerticalDirectionChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E4E75), Color(0xFF426A87), Color(0xFF724D67)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Flex Control Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 27),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tune shared Flex properties globally, then inspect each scene to learn how axis, alignment, spacing, and flex factors combine.',
            style: TextStyle(color: Color(0xFFF3F8FF), fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact cards', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: showGrid,
                  onChanged: onShowGridChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _SmallSelect<Axis>(
                title: 'Direction',
                value: axis,
                values: Axis.values,
                labelBuilder: (v) => v.name,
                onChanged: onAxisChanged,
              ),
              _SmallSelect<MainAxisAlignment>(
                title: 'MainAxisAlignment',
                value: mainAxisAlignment,
                values: MainAxisAlignment.values,
                labelBuilder: (v) => v.name,
                onChanged: onMainAxisAlignmentChanged,
              ),
              _SmallSelect<CrossAxisAlignment>(
                title: 'CrossAxisAlignment',
                value: crossAxisAlignment,
                values: CrossAxisAlignment.values,
                labelBuilder: (v) => v.name,
                onChanged: onCrossAxisAlignmentChanged,
              ),
              _SmallSelect<MainAxisSize>(
                title: 'MainAxisSize',
                value: mainAxisSize,
                values: MainAxisSize.values,
                labelBuilder: (v) => v.name,
                onChanged: onMainAxisSizeChanged,
              ),
              _SmallSelect<VerticalDirection>(
                title: 'VerticalDirection',
                value: verticalDirection,
                values: VerticalDirection.values,
                labelBuilder: (v) => v.name,
                onChanged: onVerticalDirectionChanged,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Spacing: ${spacing.toStringAsFixed(1)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: spacing,
            min: 0,
            max: 36,
            divisions: 18,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
            onChanged: onSpacingChanged,
          ),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _DeckTag(label: 'Flex(direction, mainAxisAlignment, crossAxisAlignment)'),
              _DeckTag(label: 'mainAxisSize + spacing + verticalDirection'),
              _DeckTag(label: 'Flexible/Expanded control remaining space'),
              _DeckTag(label: 'baseline requires textBaseline'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmallSelect<T> extends StatelessWidget {
  const _SmallSelect({
    required this.title,
    required this.value,
    required this.values,
    required this.labelBuilder,
    required this.onChanged,
  });

  final String title;
  final T value;
  final List<T> values;
  final String Function(T value) labelBuilder;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 6),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                isExpanded: true,
                borderRadius: BorderRadius.circular(12),
                dropdownColor: const Color(0xFF3A5E7A),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                items: values
                    .map((item) => DropdownMenuItem<T>(
                          value: item,
                          child: Text(labelBuilder(item), style: const TextStyle(color: Colors.white)),
                        ))
                    .toList(),
                onChanged: (selected) {
                  if (selected != null) {
                    onChanged(selected);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeckTag extends StatelessWidget {
  const _DeckTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _ScenePanel extends StatelessWidget {
  const _ScenePanel({
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
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
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
                      const SizedBox(height: 3),
                      Text(subtitle, style: const TextStyle(height: 1.4, color: Color(0xFF2F3B45))),
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

class _ConceptScene extends StatelessWidget {
  const _ConceptScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Flex in one sentence', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        const Text(
          'Flex is the generalized layout primitive behind Row and Column. It measures inflexible children first, allocates remaining main-axis space to flexible children, then positions children according to axis alignment rules.',
          style: TextStyle(height: 1.45),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFD),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDDE5EE)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Bullet(text: '1) Non-flex children are laid out first in the main axis with unbounded constraints.'),
              _Bullet(text: '2) Remaining main-axis space is divided by flex factors.'),
              _Bullet(text: '3) Flexible children are laid out with tight or loose fits (FlexFit.tight / FlexFit.loose).'),
              _Bullet(text: '4) Cross-axis extent becomes the max cross-axis child extent.'),
              _Bullet(text: '5) mainAxisSize decides whether Flex takes max constraints or wraps content.'),
              _Bullet(text: '6) mainAxisAlignment and crossAxisAlignment place children in final positions.'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Wrap(
          spacing: 14,
          runSpacing: 8,
          children: [
            _Legend(color: _cNavy, label: 'Axis decides layout orientation'),
            _Legend(color: _cTeal, label: 'Flex factors distribute leftover space'),
            _Legend(color: _cRose, label: 'Baseline mode needs textBaseline'),
          ],
        ),
      ],
    );
  }
}

class _AxisLabScene extends StatelessWidget {
  const _AxisLabScene({required this.config});

  final _FlexConfig config;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Direction: ${config.axis.name} | mainAxisAlignment: ${config.mainAxisAlignment.name} | crossAxisAlignment: ${config.crossAxisAlignment.name}',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: config.compact ? 190 : 250,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Center(
                    child: _FlexPreviewBox(
                      label: 'Axis lab',
                      child: _FlexSampleStrip(config: config),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FBFE),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFDDE8F2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Interpretation', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text(
                        config.axis == Axis.horizontal
                            ? 'Main axis is horizontal. textDirection affects start/end order, and verticalDirection influences cross-axis start/end meaning.'
                            : 'Main axis is vertical. verticalDirection controls start/end order, and textDirection affects cross-axis start/end meaning.',
                        style: const TextStyle(height: 1.4),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Try these combinations:',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      const _Bullet(text: 'Set direction to vertical with mainAxisSize.min to watch the container shrink-wrap children.'),
                      const _Bullet(text: 'Use MainAxisAlignment.spaceBetween with spacing > 0 to compare fixed gap vs distributed free space.'),
                      const _Bullet(text: 'Toggle RTL and observe how start/end remap for horizontal layouts.'),
                    ],
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

class _AlignmentMatrixScene extends StatefulWidget {
  const _AlignmentMatrixScene({required this.config});

  final _FlexConfig config;

  @override
  State<_AlignmentMatrixScene> createState() => _AlignmentMatrixSceneState();
}

class _AlignmentMatrixSceneState extends State<_AlignmentMatrixScene> {
  final List<_TileSpec> _tiles = const [
    _TileSpec('A', Color(0xFFB5D5F0), 36, 44),
    _TileSpec('B', Color(0xFFCDE8C4), 62, 36),
    _TileSpec('C', Color(0xFFF0D7B4), 46, 62),
    _TileSpec('D', Color(0xFFE9C3D8), 58, 52),
    _TileSpec('E', Color(0xFFD2CBF2), 40, 40),
  ];

  bool _useMinContainer = false;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    final localMainAxisSize = _useMinContainer ? MainAxisSize.min : config.mainAxisSize;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: _useMinContainer ? 'Container extent: min' : 'Container extent: global',
              color: _cTeal,
              onPressed: () => setState(() => _useMinContainer = !_useMinContainer),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'This scene emphasizes how alignment values reposition children once size allocation is complete.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 190 : 250,
          child: _GuideStage(
            showGrid: config.showGrid,
            child: Center(
              child: Container(
                width: 380,
                height: 170,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD8E3EE)),
                ),
                child: Flex(
                  direction: config.axis,
                  spacing: config.spacing,
                  mainAxisAlignment: config.mainAxisAlignment,
                  mainAxisSize: localMainAxisSize,
                  crossAxisAlignment: config.crossAxisAlignment,
                  textDirection: config.textDirection,
                  verticalDirection: config.verticalDirection,
                  clipBehavior: Clip.none,
                  children: _tiles
                      .map(
                        (tile) => Container(
                          width: config.axis == Axis.horizontal ? tile.mainAxisExtent : tile.crossAxisExtent,
                          height: config.axis == Axis.horizontal ? tile.crossAxisExtent : tile.mainAxisExtent,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: tile.color,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFF6D7E8F)),
                          ),
                          child: Text(tile.label, style: const TextStyle(fontWeight: FontWeight.w800)),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TileSpec {
  const _TileSpec(this.label, this.color, this.mainAxisExtent, this.crossAxisExtent);

  final String label;
  final Color color;
  final double mainAxisExtent;
  final double crossAxisExtent;
}

class _FlexibleExpandedScene extends StatefulWidget {
  const _FlexibleExpandedScene({required this.config});

  final _FlexConfig config;

  @override
  State<_FlexibleExpandedScene> createState() => _FlexibleExpandedSceneState();
}

class _FlexibleExpandedSceneState extends State<_FlexibleExpandedScene> {
  int _leftFlex = 1;
  int _middleFlex = 2;
  int _rightFlex = 1;
  bool _middleTight = true;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: 'Left flex: $_leftFlex',
              color: _cRose,
              onPressed: () => setState(() => _leftFlex = _leftFlex == 3 ? 1 : _leftFlex + 1),
            ),
            _ActionButton(
              label: 'Middle flex: $_middleFlex',
              color: _cIndigo,
              onPressed: () => setState(() => _middleFlex = _middleFlex == 4 ? 1 : _middleFlex + 1),
            ),
            _ActionButton(
              label: 'Right flex: $_rightFlex',
              color: _cTeal,
              onPressed: () => setState(() => _rightFlex = _rightFlex == 3 ? 1 : _rightFlex + 1),
            ),
            _ActionButton(
              label: _middleTight ? 'Middle fit: tight' : 'Middle fit: loose',
              color: _cAmber,
              onPressed: () => setState(() => _middleTight = !_middleTight),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Expanded is equivalent to Flexible(fit: FlexFit.tight). Loose fit allows a child to be smaller than its allocated slot.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 220 : 280,
          child: _GuideStage(
            showGrid: config.showGrid,
            child: Center(
              child: Container(
                width: 420,
                height: 180,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD8E3EE)),
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  spacing: config.spacing,
                  textDirection: config.textDirection,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      flex: _leftFlex,
                      fit: FlexFit.tight,
                      child: _FlexFactorTile(
                        color: const Color(0xFFC8DEF3),
                        title: 'Left Expanded',
                        subtitle: 'flex=$_leftFlex',
                      ),
                    ),
                    Flexible(
                      flex: _middleFlex,
                      fit: _middleTight ? FlexFit.tight : FlexFit.loose,
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: _middleTight ? double.infinity : 86,
                          child: _FlexFactorTile(
                            color: const Color(0xFFEED1DF),
                            title: 'Middle Flexible',
                            subtitle: 'flex=$_middleFlex | fit=${_middleTight ? 'tight' : 'loose'}',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: _rightFlex,
                      child: _FlexFactorTile(
                        color: const Color(0xFFD7ECC7),
                        title: 'Right Expanded',
                        subtitle: 'flex=$_rightFlex',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FlexFactorTile extends StatelessWidget {
  const _FlexFactorTile({
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF6D7E8F)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle),
        ],
      ),
    );
  }
}

class _BaselineScene extends StatefulWidget {
  const _BaselineScene({required this.config});

  final _FlexConfig config;

  @override
  State<_BaselineScene> createState() => _BaselineSceneState();
}

class _BaselineSceneState extends State<_BaselineScene> {
  bool _showGuides = true;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: _showGuides ? 'Hide baseline guides' : 'Show baseline guides',
              color: _cIndigo,
              onPressed: () => setState(() => _showGuides = !_showGuides),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'CrossAxisAlignment.baseline only works with horizontal Flex and requires textBaseline.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 190 : 240,
          child: _GuideStage(
            showGrid: config.showGrid,
            child: Center(
              child: Container(
                width: 500,
                height: 170,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD8E3EE)),
                ),
                child: Stack(
                  children: [
                    if (_showGuides)
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _HorizontalGuidePainter(),
                        ),
                      ),
                    Flex(
                      direction: Axis.horizontal,
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      textDirection: config.textDirection,
                      children: const [
                        _BaselineToken(text: 'Flex', size: 18, color: Color(0xFF7A5A25)),
                        _BaselineToken(text: 'baseline', size: 34, color: Color(0xFF345A7F)),
                        _BaselineToken(text: 'align', size: 24, color: Color(0xFF7A2F55)),
                        _BaselineToken(text: 'TEXT', size: 42, color: Color(0xFF3A6C53)),
                        _BaselineToken(text: '123', size: 28, color: Color(0xFF4B458A)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HorizontalGuidePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x33C14E4E)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(0, size.height * 0.58), Offset(size.width, size.height * 0.58), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BaselineToken extends StatelessWidget {
  const _BaselineToken({
    required this.text,
    required this.size,
    required this.color,
  });

  final String text;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}

class _ClipAndPracticalScene extends StatefulWidget {
  const _ClipAndPracticalScene({required this.config});

  final _FlexConfig config;

  @override
  State<_ClipAndPracticalScene> createState() => _ClipAndPracticalSceneState();
}

class _ClipAndPracticalSceneState extends State<_ClipAndPracticalScene> {
  Clip _clip = Clip.none;
  int _selectedPanel = 0;

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    final panels = <_PanelSpec>[
      const _PanelSpec('Overview', 'System-wide metrics and trend summary.'),
      const _PanelSpec('Tasks', 'Queue depth, processing throughput, and backpressure.'),
      const _PanelSpec('Alerts', 'Escalations, ownership handoff, and severity mix.'),
      const _PanelSpec('Audit', 'Recent actor events and policy checks.'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: 'clipBehavior: ${_clip.name}',
              color: _cOlive,
              onPressed: () {
                setState(() {
                  _clip = switch (_clip) {
                    Clip.none => Clip.hardEdge,
                    Clip.hardEdge => Clip.antiAlias,
                    Clip.antiAlias => Clip.none,
                    Clip.antiAliasWithSaveLayer => Clip.none,
                  };
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'First panel demonstrates clipBehavior with intentionally overflowing child decorations. Second panel is a practical nested Flex dashboard.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 250 : 320,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Center(
                    child: Container(
                      width: 350,
                      height: 220,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFD8E3EE)),
                      ),
                      child: Flex(
                        direction: Axis.horizontal,
                        spacing: 10,
                        clipBehavior: _clip,
                        textDirection: config.textDirection,
                        children: [
                          Expanded(
                            child: _OverflowTile(color: const Color(0xFFC8DEF3), label: 'A'),
                          ),
                          Expanded(
                            child: _OverflowTile(color: const Color(0xFFEFD2E0), label: 'B'),
                          ),
                          Expanded(
                            child: _OverflowTile(color: const Color(0xFFD7ECC7), label: 'C'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFD8E3EE)),
                    ),
                    child: Flex(
                      direction: Axis.vertical,
                      spacing: 8,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          color: const Color(0xFFEAF2FA),
                          child: const Text('Operations Dashboard', style: TextStyle(fontWeight: FontWeight.w800)),
                        ),
                        Expanded(
                          child: Flex(
                            direction: Axis.horizontal,
                            spacing: 8,
                            textDirection: config.textDirection,
                            children: [
                              Flexible(
                                flex: 2,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: panels.length,
                                  itemBuilder: (context, index) {
                                    final selected = index == _selectedPanel;
                                    final panel = panels[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(8),
                                        onTap: () => setState(() => _selectedPanel = index),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: selected ? const Color(0xFFDDEBF9) : const Color(0xFFF6FAFD),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: const Color(0xFFD2DFEC)),
                                          ),
                                          child: Text(panel.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF8FCFF),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xFFD4E2EF)),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Flex(
                                      direction: Axis.vertical,
                                      spacing: 8,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          panels[_selectedPanel].title,
                                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                                        ),
                                        Text(
                                          panels[_selectedPanel].detail,
                                          style: const TextStyle(height: 1.35),
                                        ),
                                        const Spacer(),
                                        const Text(
                                          'Nested Flex keeps the layout explicit and predictable across axis changes.',
                                          style: TextStyle(color: Color(0xFF506273)),
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

class _OverflowTile extends StatelessWidget {
  const _OverflowTile({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF6D7E8F)),
          ),
          alignment: Alignment.center,
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
        Positioned(
          right: -18,
          top: -12,
          child: Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFF36495A),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class _PanelSpec {
  const _PanelSpec(this.title, this.detail);

  final String title;
  final String detail;
}

class _FlexSampleStrip extends StatelessWidget {
  const _FlexSampleStrip({required this.config});

  final _FlexConfig config;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      _SampleTile(label: 'One', color: const Color(0xFFC8DEF3), mainExtent: 60, crossExtent: 48),
      _SampleTile(label: 'Two', color: const Color(0xFFEFD2E0), mainExtent: 48, crossExtent: 66),
      _SampleTile(label: 'Three', color: const Color(0xFFD7ECC7), mainExtent: 74, crossExtent: 44),
    ];

    return Container(
      width: 320,
      height: 170,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD8E3EE)),
      ),
      child: Flex(
        direction: config.axis,
        spacing: config.spacing,
        mainAxisAlignment: config.mainAxisAlignment,
        mainAxisSize: config.mainAxisSize,
        crossAxisAlignment: config.crossAxisAlignment,
        textDirection: config.textDirection,
        verticalDirection: config.verticalDirection,
        children: children,
      ),
    );
  }
}

class _SampleTile extends StatelessWidget {
  const _SampleTile({
    required this.label,
    required this.color,
    required this.mainExtent,
    required this.crossExtent,
  });

  final String label;
  final Color color;
  final double mainExtent;
  final double crossExtent;

  @override
  Widget build(BuildContext context) {
    final direction = Directionality.of(context);
    final axis = _findAxis(context);

    final width = axis == Axis.horizontal ? mainExtent : crossExtent;
    final height = axis == Axis.horizontal ? crossExtent : mainExtent;

    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF6D7E8F)),
        ),
        child: Center(
          child: Text(
            '$label\n${direction.name}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
          ),
        ),
      ),
    );
  }

  Axis _findAxis(BuildContext context) {
    final parent = context.findAncestorWidgetOfExactType<Flex>();
    return parent?.direction ?? Axis.horizontal;
  }
}

class _FlexPreviewBox extends StatelessWidget {
  const _FlexPreviewBox({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _GuideStage extends StatelessWidget {
  const _GuideStage({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFF7FBFF), Color(0xFFEAF2F8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFD4E0EB)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid)
            CustomPaint(
              painter: _GridPainter(),
            ),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const step = 22.0;
    final paint = Paint()..color = const Color(0x11000000);

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

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.color, required this.onPressed});

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 9, height: 9, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, size: 7, color: Color(0xFF36536D)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
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
        color: const Color(0xFF10273C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recap: When to choose Flex directly',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Use Flex directly when layout axis is dynamic, when you need explicit control over direction-sensitive behavior, or when composing custom row/column hybrids with precise spacing, alignment, and clipping semantics.',
            style: TextStyle(color: Color(0xFFD9E5F1), height: 1.4),
          ),
        ],
      ),
    );
  }
}
