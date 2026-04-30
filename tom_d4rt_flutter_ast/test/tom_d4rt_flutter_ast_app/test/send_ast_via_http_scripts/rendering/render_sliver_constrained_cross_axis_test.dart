import 'package:flutter/material.dart';

class _ThemePack {
  final String name;
  final Color primary;
  final Color secondary;
  final Color canvas;
  final Color surface;
  final Color text;
  final Color muted;

  const _ThemePack({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.canvas,
    required this.surface,
    required this.text,
    required this.muted,
  });
}

const _packs = <_ThemePack>[
  _ThemePack(
    name: 'Cobalt / Amber',
    primary: Color(0xFF1D4ED8),
    secondary: Color(0xFFF59E0B),
    canvas: Color(0xFFF3F7FF),
    surface: Color(0xFFFFFFFF),
    text: Color(0xFF1F2937),
    muted: Color(0xFF64748B),
  ),
  _ThemePack(
    name: 'Pine / Coral',
    primary: Color(0xFF047857),
    secondary: Color(0xFFFB7185),
    canvas: Color(0xFFF1FBF8),
    surface: Color(0xFFFFFFFF),
    text: Color(0xFF1D2C25),
    muted: Color(0xFF5F6F67),
  ),
  _ThemePack(
    name: 'Slate / Mint',
    primary: Color(0xFF0F172A),
    secondary: Color(0xFF14B8A6),
    canvas: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    text: Color(0xFF0F172A),
    muted: Color(0xFF64748B),
  ),
];

enum _DemoStage {
  constraintLens,
  crossAxisGroup,
  nestedComposition,
  breakpointLab,
  comparisons,
  verification,
}

dynamic build(BuildContext context) {
  return const _CrossAxisConstraintObservatory();
}

class _CrossAxisConstraintObservatory extends StatefulWidget {
  const _CrossAxisConstraintObservatory();

  @override
  State<_CrossAxisConstraintObservatory> createState() =>
      _CrossAxisConstraintObservatoryState();
}

class _CrossAxisConstraintObservatoryState
    extends State<_CrossAxisConstraintObservatory> {
  _DemoStage _stage = _DemoStage.constraintLens;
  int _packIndex = 0;
  bool _verbose = false;

  double _lensMaxExtent = 360;
  double _lensViewport = 860;
  bool _lensShowGuides = true;

  int _leftFlex = 1;
  int _rightFlex = 2;
  double _groupMaxExtent = 240;
  bool _groupDenseRows = false;

  bool _nestedUseHeader = true;
  bool _nestedUsePadding = true;
  bool _nestedUseGrid = true;
  double _nestedConstraint = 420;

  double _breakpointViewport = 980;
  double _breakpointConstraint = 600;
  double _breakpointPadding = 20;

  double _compareViewport = 760;
  double _compareConstraint = 420;
  bool _compareShowRulers = true;

  static const _stageLabels = <String>[
    '1 · Constraint Lens',
    '2 · Cross-Axis Group',
    '3 · Nested Composition',
    '4 · Breakpoint Lab',
    '5 · Comparisons Gallery',
    '6 · Verification Guide',
  ];

  _ThemePack get _theme => _packs[_packIndex];

  void _debug(String text) {
    if (_verbose) {
      debugPrint('[RenderSliverConstrainedCrossAxisDemo] $text');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _theme.canvas,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildGlobalControls(),
            Expanded(child: _buildStage()),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_theme.primary, _theme.secondary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.straighten_rounded,
                  color: Colors.white, size: 26),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Cross-Axis Constraint Observatory',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'RenderSliverConstrainedCrossAxis',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            'RenderSliverConstrainedCrossAxis caps how much cross-axis space '
            'a sliver child may consume. It is ideal for readable article columns, '
            'balanced desktop layouts, and mixed-width sliver compositions.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.93),
              fontSize: 12.5,
              height: 1.34,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlobalControls() {
    return Container(
      width: double.infinity,
      color: _theme.primary.withValues(alpha: 0.06),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Stage',
            style: TextStyle(
              color: _theme.text,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (var i = 0; i < _stageLabels.length; i++)
            ChoiceChip(
              selected: _stage.index == i,
              selectedColor: _theme.primary,
              backgroundColor: Colors.white,
              side: BorderSide(color: _theme.primary.withValues(alpha: 0.2)),
              onSelected: (_) {
                setState(() => _stage = _DemoStage.values[i]);
                _debug('stage => ${_stage.name}');
              },
              label: Text(
                '${i + 1}',
                style: TextStyle(
                  color: _stage.index == i ? Colors.white : _theme.text,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
          const SizedBox(width: 8),
          Text(
            'Palette',
            style: TextStyle(
              color: _theme.text,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (var i = 0; i < _packs.length; i++)
            GestureDetector(
              onTap: () => setState(() => _packIndex = i),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _packs[i].primary,
                  border: Border.all(
                    color: _packIndex == i ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Verbose',
                  style: TextStyle(color: _theme.text, fontSize: 12)),
              Switch(
                value: _verbose,
                activeTrackColor: _theme.secondary,
                onChanged: (v) => setState(() => _verbose = v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStage() {
    switch (_stage) {
      case _DemoStage.constraintLens:
        return _buildConstraintLens();
      case _DemoStage.crossAxisGroup:
        return _buildCrossAxisGroupStudio();
      case _DemoStage.nestedComposition:
        return _buildNestedComposition();
      case _DemoStage.breakpointLab:
        return _buildBreakpointLab();
      case _DemoStage.comparisons:
        return _buildComparisonsGallery();
      case _DemoStage.verification:
        return _buildVerificationGuide();
    }
  }

  Widget _buildConstraintLens() {
    final available = _lensViewport;
    final constrained = _lensMaxExtent < available ? _lensMaxExtent : available;
    final gutter = ((available - constrained) / 2).clamp(0.0, 9999.0);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Constraint Lens'),
          const SizedBox(height: 8),
          Text(
            'This stage compares an unconstrained sliver against a constrained '
            'one under the same viewport width. It makes side gutters explicit '
            'so you can see exactly how max cross-axis extent limits content.',
            style: TextStyle(color: _theme.text, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Lens Controls',
            subtitle: 'Viewport width, constrained max extent, and overlay guides.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Viewport width',
                  value: _lensViewport,
                  min: 520,
                  max: 1200,
                  divisions: 34,
                  onChanged: (v) => setState(() => _lensViewport = v),
                  color: _theme.primary,
                ),
                _sliderRow(
                  label: 'Constrained maxExtent',
                  value: _lensMaxExtent,
                  min: 220,
                  max: 900,
                  divisions: 34,
                  onChanged: (v) => setState(() => _lensMaxExtent = v),
                  color: _theme.secondary,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _lensShowGuides,
                      activeColor: _theme.primary,
                      onChanged: (v) =>
                          setState(() => _lensShowGuides = v ?? true),
                    ),
                    Text(
                      'Show side-gutter guides',
                      style: TextStyle(color: _theme.text, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('viewport', available.toStringAsFixed(0),
                        _theme.primary),
                    const SizedBox(width: 6),
                    _metricChip('constrained', constrained.toStringAsFixed(0),
                        _theme.secondary),
                    const SizedBox(width: 6),
                    _metricChip(
                        'gutter each', gutter.toStringAsFixed(0), _theme.text),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _card(
                  title: 'A · Unconstrained SliverList',
                  subtitle: 'Sliver consumes full cross-axis viewport width.',
                  tint: _theme.primary.withValues(alpha: 0.04),
                  child: _demoViewport(
                    width: _lensViewport,
                    showGuides: _lensShowGuides,
                    constrainedExtent: null,
                    tileColor: _theme.primary.withValues(alpha: 0.14),
                    labelPrefix: 'Full-width row',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _card(
                  title: 'B · SliverConstrainedCrossAxis',
                  subtitle:
                      'Cross-axis consumption is capped by maxExtent value.',
                  tint: _theme.secondary.withValues(alpha: 0.04),
                  child: _demoViewport(
                    width: _lensViewport,
                    showGuides: _lensShowGuides,
                    constrainedExtent: _lensMaxExtent,
                    tileColor: _theme.secondary.withValues(alpha: 0.14),
                    labelPrefix: 'Constrained row',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _infoBox(
            'Use SliverConstrainedCrossAxis when wide layouts make line length '
            'uncomfortable. Keeping a readable column width while preserving '
            'scroll performance is its primary strength.',
          ),
        ],
      ),
    );
  }

  Widget _demoViewport({
    required double width,
    required bool showGuides,
    required double? constrainedExtent,
    required Color tileColor,
    required String labelPrefix,
  }) {
    final effective = constrainedExtent == null
        ? width
        : (constrainedExtent < width ? constrainedExtent : width);
    final gutter = ((width - effective) / 2).clamp(0.0, 9999.0);

    return SizedBox(
      width: width,
      height: 490,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _theme.muted.withValues(alpha: 0.24)),
          ),
          child: Stack(
            children: [
              if (showGuides)
                Row(
                  children: [
                    SizedBox(
                      width: gutter,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: _theme.primary.withValues(alpha: 0.06),
                          border: Border(
                            right: BorderSide(
                              color: _theme.primary.withValues(alpha: 0.2),
                            ),
                          ),
                        ),
                        child: const SizedBox.expand(),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: gutter,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: _theme.primary.withValues(alpha: 0.06),
                          border: Border(
                            left: BorderSide(
                              color: _theme.primary.withValues(alpha: 0.2),
                            ),
                          ),
                        ),
                        child: const SizedBox.expand(),
                      ),
                    ),
                  ],
                ),
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _miniBanner(
                      constrainedExtent == null
                          ? 'No cross-axis cap'
                          : 'maxExtent=${constrainedExtent.toStringAsFixed(0)}',
                    ),
                  ),
                  if (constrainedExtent == null)
                    SliverList.builder(
                      itemCount: 22,
                      itemBuilder: (context, index) => _storyTile(
                        title: '$labelPrefix ${index + 1}',
                        subtitle:
                            'Uses full width provided by SliverConstraints.crossAxisExtent.',
                        color: tileColor,
                      ),
                    )
                  else
                    SliverConstrainedCrossAxis(
                      maxExtent: constrainedExtent,
                      sliver: SliverList.builder(
                        itemCount: 22,
                        itemBuilder: (context, index) => _storyTile(
                          title: '$labelPrefix ${index + 1}',
                          subtitle:
                              'Width is capped before child layout; gutters absorb the rest.',
                          color: tileColor,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCrossAxisGroupStudio() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Cross-Axis Group Studio'),
          const SizedBox(height: 8),
          Text(
            'SliverConstrainedCrossAxis sets crossAxisFlex=0 so it can coexist '
            'with flex-driven siblings inside SliverCrossAxisGroup. This stage '
            'demonstrates one constrained lane between two expanded lanes.',
            style: TextStyle(color: _theme.text, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Group Controls',
            subtitle: 'Tune fixed middle extent and side lane flex ratios.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Middle maxExtent',
                  value: _groupMaxExtent,
                  min: 160,
                  max: 480,
                  divisions: 32,
                  onChanged: (v) => setState(() => _groupMaxExtent = v),
                  color: _theme.primary,
                ),
                _sliderRow(
                  label: 'Left flex',
                  value: _leftFlex.toDouble(),
                  min: 1,
                  max: 4,
                  divisions: 3,
                  onChanged: (v) => setState(() => _leftFlex = v.round()),
                  color: _theme.secondary,
                ),
                _sliderRow(
                  label: 'Right flex',
                  value: _rightFlex.toDouble(),
                  min: 1,
                  max: 4,
                  divisions: 3,
                  onChanged: (v) => setState(() => _rightFlex = v.round()),
                  color: _theme.secondary,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _groupDenseRows,
                      activeColor: _theme.primary,
                      onChanged: (v) =>
                          setState(() => _groupDenseRows = v ?? false),
                    ),
                    Text(
                      'Dense lane rows',
                      style: TextStyle(color: _theme.text, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('left flex', '$_leftFlex', _theme.primary),
                    const SizedBox(width: 6),
                    _metricChip(
                        'middle fixed', _groupMaxExtent.toStringAsFixed(0),
                        _theme.secondary),
                    const SizedBox(width: 6),
                    _metricChip('right flex', '$_rightFlex', _theme.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Three-Lane SliverCrossAxisGroup',
            subtitle:
                'Left/right lanes flex; center lane remains width-capped via SliverConstrainedCrossAxis.',
            tint: _theme.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 520,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _theme.muted.withValues(alpha: 0.26)),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _miniBanner('Cross-axis lane orchestration'),
                    ),
                    SliverCrossAxisGroup(
                      slivers: [
                        SliverCrossAxisExpanded(
                          flex: _leftFlex,
                          sliver: SliverList.builder(
                            itemCount: _groupDenseRows ? 28 : 18,
                            itemBuilder: (context, index) => _laneTile(
                              lane: 'LEFT',
                              index: index,
                              color: _theme.primary.withValues(alpha: 0.13),
                              text:
                                  'Expanded lane (flex $_leftFlex) absorbs remainder.',
                            ),
                          ),
                        ),
                        SliverConstrainedCrossAxis(
                          maxExtent: _groupMaxExtent,
                          sliver: SliverList.builder(
                            itemCount: _groupDenseRows ? 28 : 18,
                            itemBuilder: (context, index) => _laneTile(
                              lane: 'CENTER',
                              index: index,
                              color: _theme.secondary.withValues(alpha: 0.13),
                              text:
                                  'Constrained lane remains capped at maxExtent.',
                            ),
                          ),
                        ),
                        SliverCrossAxisExpanded(
                          flex: _rightFlex,
                          sliver: SliverList.builder(
                            itemCount: _groupDenseRows ? 28 : 18,
                            itemBuilder: (context, index) => _laneTile(
                              lane: 'RIGHT',
                              index: index,
                              color: _theme.primary.withValues(alpha: 0.13),
                              text:
                                  'Expanded lane (flex $_rightFlex) fills leftover space.',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Interpretation',
            subtitle: 'Why this matters for desktop/tablet composition.',
            tint: _theme.secondary.withValues(alpha: 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet(
                    'Constrained center lane can host article content for stable readability.'),
                _bullet(
                    'Flexible side lanes are useful for metadata rails, reactions, or tools.'),
                _bullet(
                    'Cross-axis group allows multi-column sliver composition in one scroll axis.'),
                _bullet(
                    'A fixed middle lane avoids over-long lines on ultrawide displays.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNestedComposition() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Nested Composition'),
          const SizedBox(height: 8),
          Text(
            'RenderSliverConstrainedCrossAxis is often one segment in a larger '
            'sliver pipeline. This scenario composes headers, padding, '
            'constrained content, and optional grids in a single scroll view.',
            style: TextStyle(color: _theme.text, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Composition Controls',
            subtitle: 'Toggle optional sliver building blocks.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Constrained lane maxExtent',
                  value: _nestedConstraint,
                  min: 280,
                  max: 680,
                  divisions: 20,
                  onChanged: (v) => setState(() => _nestedConstraint = v),
                  color: _theme.primary,
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 6,
                  children: [
                    _toggleChip(
                      label: 'Pinned header',
                      value: _nestedUseHeader,
                      onChanged: (v) => setState(() => _nestedUseHeader = v),
                    ),
                    _toggleChip(
                      label: 'Outer sliver padding',
                      value: _nestedUsePadding,
                      onChanged: (v) => setState(() => _nestedUsePadding = v),
                    ),
                    _toggleChip(
                      label: 'Trailing grid block',
                      value: _nestedUseGrid,
                      onChanged: (v) => setState(() => _nestedUseGrid = v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Composed Scroll Scene',
            subtitle:
                'Observe how the constrained segment remains bounded amid other slivers.',
            tint: _theme.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 540,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _theme.muted.withValues(alpha: 0.26)),
                ),
                child: CustomScrollView(
                  slivers: [
                    if (_nestedUseHeader)
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: _theme.primary,
                        expandedHeight: 120,
                        flexibleSpace: FlexibleSpaceBar(
                          title: const Text(
                            'Composed Header',
                            style: TextStyle(fontSize: 13),
                          ),
                          background: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  _theme.primary,
                                  _theme.secondary,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: _miniBanner('Lead-in sliver adapter section'),
                    ),
                    SliverList.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) => _storyTile(
                        title: 'Prelude card ${index + 1}',
                        subtitle:
                            'Regular sliver list cards before constrained article lane.',
                        color: _theme.primary.withValues(alpha: 0.11),
                      ),
                    ),
                    if (_nestedUsePadding)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverConstrainedCrossAxis(
                          maxExtent: _nestedConstraint,
                          sliver: SliverList.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) => _articleTile(
                              index: index,
                              constrainedLabel:
                                  'Constrained + padded segment (max ${_nestedConstraint.toStringAsFixed(0)})',
                            ),
                          ),
                        ),
                      )
                    else
                      SliverConstrainedCrossAxis(
                        maxExtent: _nestedConstraint,
                        sliver: SliverList.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) => _articleTile(
                            index: index,
                            constrainedLabel:
                                'Constrained segment without outer sliver padding',
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: _miniBanner('Post-constrained continuation'),
                    ),
                    SliverList.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => _storyTile(
                        title: 'Continuation card ${index + 1}',
                        subtitle: 'Downstream slivers are unaffected by prior cap.',
                        color: _theme.secondary.withValues(alpha: 0.12),
                      ),
                    ),
                    if (_nestedUseGrid)
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 14),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 68,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _theme.primary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Tag ${index + 1}',
                                  style: TextStyle(
                                    color: _theme.text,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              );
                            },
                            childCount: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'Constrained cross-axis sections are compositional building blocks. '
            'They can be dropped into larger sliver pipelines without changing '
            'main-axis behavior of neighboring slivers.',
          ),
        ],
      ),
    );
  }

  Widget _buildBreakpointLab() {
    final constrained =
        _breakpointConstraint < _breakpointViewport ? _breakpointConstraint : _breakpointViewport;
    final leftOver = (_breakpointViewport - constrained).clamp(0.0, 9999.0);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Breakpoint Lab'),
          const SizedBox(height: 8),
          Text(
            'This lab models responsive content rails. Vary viewport and '
            'maxExtent to see when constrained columns preserve readable line '
            'length and where side whitespace becomes excessive.',
            style: TextStyle(color: _theme.text, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Responsive Controls',
            subtitle: 'Try presets and fine-grained slider adjustments.',
            child: Column(
              children: [
                Row(
                  children: [
                    _presetButton('Tablet', 840, 520),
                    const SizedBox(width: 6),
                    _presetButton('Desktop', 1080, 620),
                    const SizedBox(width: 6),
                    _presetButton('Ultrawide', 1320, 700),
                    const Spacer(),
                    _metricChip('gutter total', leftOver.toStringAsFixed(0),
                        _theme.secondary),
                  ],
                ),
                const SizedBox(height: 8),
                _sliderRow(
                  label: 'Viewport width',
                  value: _breakpointViewport,
                  min: 620,
                  max: 1400,
                  divisions: 39,
                  onChanged: (v) => setState(() => _breakpointViewport = v),
                  color: _theme.primary,
                ),
                _sliderRow(
                  label: 'maxExtent',
                  value: _breakpointConstraint,
                  min: 340,
                  max: 820,
                  divisions: 24,
                  onChanged: (v) => setState(() => _breakpointConstraint = v),
                  color: _theme.secondary,
                ),
                _sliderRow(
                  label: 'Outer horizontal padding',
                  value: _breakpointPadding,
                  min: 0,
                  max: 56,
                  divisions: 14,
                  onChanged: (v) => setState(() => _breakpointPadding = v),
                  color: _theme.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Responsive Article Surface',
            subtitle:
                'Constrained article cards stay readable while viewport grows wider.',
            tint: _theme.secondary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 520,
              child: Center(
                child: SizedBox(
                  width: _breakpointViewport,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: _theme.muted.withValues(alpha: 0.24)),
                    ),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: _miniBanner(
                            'Viewport ${_breakpointViewport.toStringAsFixed(0)} | '
                            'maxExtent ${_breakpointConstraint.toStringAsFixed(0)}',
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _breakpointPadding, vertical: 8),
                          sliver: SliverConstrainedCrossAxis(
                            maxExtent: _breakpointConstraint,
                            sliver: SliverList.builder(
                              itemCount: 12,
                              itemBuilder: (context, index) => _articleTile(
                                index: index,
                                constrainedLabel:
                                    'Breakpoint narrative sample ${index + 1}',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Breakpoint Guidance',
            subtitle: 'Choosing maxExtent values by content type.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet(
                    'Text-heavy lanes: keep maxExtent moderate for line readability.'),
                _bullet(
                    'Card grids: either skip constraints or use larger maxExtent caps.'),
                _bullet(
                    'Data tables: consider separate layouts rather than strict caps.'),
                _bullet(
                    'When side gutters become very large, add utility side lanes.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonsGallery() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Comparisons Gallery'),
          const SizedBox(height: 8),
          Text(
            'Three visual cards compare unconstrained, constrained, and '
            'cross-axis-group patterns with identical content density. Use this '
            'as a quick decision matrix for production layouts.',
            style: TextStyle(color: _theme.text, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Gallery Controls',
            subtitle: 'Synchronize viewport and constraint values across cards.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Gallery viewport',
                  value: _compareViewport,
                  min: 560,
                  max: 980,
                  divisions: 21,
                  onChanged: (v) => setState(() => _compareViewport = v),
                  color: _theme.primary,
                ),
                _sliderRow(
                  label: 'Constraint maxExtent',
                  value: _compareConstraint,
                  min: 260,
                  max: 620,
                  divisions: 18,
                  onChanged: (v) => setState(() => _compareConstraint = v),
                  color: _theme.secondary,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _compareShowRulers,
                      activeColor: _theme.primary,
                      onChanged: (v) =>
                          setState(() => _compareShowRulers = v ?? true),
                    ),
                    Text(
                      'Show ruler overlays',
                      style: TextStyle(color: _theme.text, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _comparisonCard(
                title: 'Unconstrained Lane',
                subtitle: 'Consumes all cross-axis space.',
                tint: _theme.primary.withValues(alpha: 0.04),
                child: _galleryViewport(
                  viewport: _compareViewport,
                  constrained: null,
                  ruler: _compareShowRulers,
                ),
              ),
              _comparisonCard(
                title: 'Constrained Lane',
                subtitle: 'Single lane with max cross-axis extent cap.',
                tint: _theme.secondary.withValues(alpha: 0.04),
                child: _galleryViewport(
                  viewport: _compareViewport,
                  constrained: _compareConstraint,
                  ruler: _compareShowRulers,
                ),
              ),
              _comparisonCard(
                title: 'Cross-Axis Group Blend',
                subtitle: 'Constrained center + expanded side rails.',
                tint: _theme.primary.withValues(alpha: 0.04),
                child: _galleryGroupViewport(
                  viewport: _compareViewport,
                  constrained: _compareConstraint,
                  ruler: _compareShowRulers,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Selection Heuristics',
            subtitle: 'Choose strategy by content and screen class.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet(
                    'Unconstrained: best for visual media and full-bleed dashboards.'),
                _bullet(
                    'Constrained lane: best for long-form reading and forms.'),
                _bullet(
                    'Cross-axis group: best for rich desktop workflows with side context.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _comparisonCard({
    required String title,
    required String subtitle,
    required Color tint,
    required Widget child,
  }) {
    return SizedBox(
      width: 410,
      child: _card(
        title: title,
        subtitle: subtitle,
        tint: tint,
        child: child,
      ),
    );
  }

  Widget _galleryViewport({
    required double viewport,
    required double? constrained,
    required bool ruler,
  }) {
    final effective = constrained == null
        ? viewport
        : (constrained < viewport ? constrained : viewport);
    final gutter = ((viewport - effective) / 2).clamp(0.0, 9999.0);

    return SizedBox(
      height: 300,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: _theme.muted.withValues(alpha: 0.26)),
        ),
        child: Stack(
          children: [
            if (ruler)
              Positioned(
                right: 8,
                top: 8,
                child: _metricChip('gutter', gutter.toStringAsFixed(0),
                    _theme.secondary),
              ),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _miniBanner(
                    constrained == null
                        ? 'No cap'
                        : 'maxExtent ${constrained.toStringAsFixed(0)}',
                  ),
                ),
                if (constrained == null)
                  SliverList.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) => _storyTile(
                      title: 'Story ${index + 1}',
                      subtitle: 'Full cross-axis lane',
                      color: _theme.primary.withValues(alpha: 0.12),
                    ),
                  )
                else
                  SliverConstrainedCrossAxis(
                    maxExtent: constrained,
                    sliver: SliverList.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) => _storyTile(
                        title: 'Story ${index + 1}',
                        subtitle: 'Constrained lane',
                        color: _theme.secondary.withValues(alpha: 0.12),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _galleryGroupViewport({
    required double viewport,
    required double constrained,
    required bool ruler,
  }) {
    return SizedBox(
      height: 300,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: _theme.muted.withValues(alpha: 0.26)),
        ),
        child: Stack(
          children: [
            if (ruler)
              Positioned(
                right: 8,
                top: 8,
                child: _metricChip('center cap',
                    constrained.toStringAsFixed(0), _theme.secondary),
              ),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _miniBanner('Cross-axis blend')),
                SliverCrossAxisGroup(
                  slivers: [
                    SliverCrossAxisExpanded(
                      flex: 1,
                      sliver: SliverList.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) => _compactTile(
                          'L${index + 1}',
                          _theme.primary.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    SliverConstrainedCrossAxis(
                      maxExtent: constrained,
                      sliver: SliverList.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) => _compactTile(
                          'C${index + 1}',
                          _theme.secondary.withValues(alpha: 0.12),
                        ),
                      ),
                    ),
                    SliverCrossAxisExpanded(
                      flex: 1,
                      sliver: SliverList.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) => _compactTile(
                          'R${index + 1}',
                          _theme.primary.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _compactTile(String text, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 4, 6, 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: _theme.text,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildVerificationGuide() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification Guide'),
          const SizedBox(height: 10),
          _card(
            title: 'Behavior Summary',
            subtitle: 'What RenderSliverConstrainedCrossAxis changes.',
            child: Column(
              children: [
                _matrixRow(
                  aspect: 'Cross-axis extent',
                  unconstrained: 'Uses full viewport cross axis',
                  constrained:
                      'Uses min(maxExtent, viewportCrossAxisExtent)',
                ),
                _matrixRow(
                  aspect: 'Main-axis scroll',
                  unconstrained: 'Normal sliver scroll behavior',
                  constrained: 'Unchanged main-axis behavior',
                ),
                _matrixRow(
                  aspect: 'SliverCrossAxisGroup role',
                  unconstrained: 'May flex based on parent data',
                  constrained: 'Sets crossAxisFlex = 0 (fixed lane)',
                ),
                _matrixRow(
                  aspect: 'Best use case',
                  unconstrained: 'Media-heavy, full-bleed layouts',
                  constrained: 'Readable columns in wide contexts',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do / Don\'t',
            subtitle: 'Production practices when applying cross-axis caps.',
            child: Column(
              children: [
                _doDont(
                  title: 'Constrain text-heavy lanes on desktop widths',
                  detail:
                      'Improves readability and prevents fatiguing long line lengths.',
                  good: true,
                ),
                _doDont(
                  title: 'Constrain every sliver blindly',
                  detail:
                      'Visual media grids often benefit from wider unconstrained lanes.',
                  good: false,
                ),
                _doDont(
                  title: 'Pair with SliverCrossAxisGroup for side utilities',
                  detail:
                      'Create center-focus layouts with contextual side rails.',
                  good: true,
                ),
                _doDont(
                  title: 'Use hardcoded giant maxExtent everywhere',
                  detail:
                      'Constraint becomes meaningless when always near viewport size.',
                  good: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common implementation questions.',
            child: Column(
              children: [
                _qa(
                  q: 'Does this widget affect scroll direction?',
                  a: 'No. It only caps cross-axis extent; main-axis scrolling '
                      'and sliver order remain the same.',
                ),
                _qa(
                  q: 'Can it be used outside CustomScrollView?',
                  a: 'It is a sliver widget, so it should be used in sliver '
                      'contexts like CustomScrollView slivers.',
                ),
                _qa(
                  q: 'Why combine it with SliverCrossAxisGroup?',
                  a: 'Group layouts allow a fixed-width center lane while '
                      'expanded side lanes consume the rest.',
                ),
                _qa(
                  q: 'What happens if maxExtent exceeds viewport width?',
                  a: 'The effective cross-axis extent is clamped to the '
                      'viewport cross-axis extent.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Completion Checklist',
            subtitle: 'Coverage delivered by this deep demo.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Visual unconstrained vs constrained side-by-side display'),
                _check('Cross-axis group scenario with fixed+flex lane composition'),
                _check('Nested sliver composition with optional sections and toggles'),
                _check('Responsive breakpoint lab with live viewport and cap controls'),
                _check('Comparison gallery with three strategy cards'),
                _check('Instructive matrix, FAQ, and do/don\'t guidance'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'RenderSliverConstrainedCrossAxis is a focused but high-leverage '
            'tool. It gives sliver-based layouts a precise cross-axis width cap '
            'without sacrificing the sliver pipeline or scrolling behavior.',
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _theme.text.withValues(alpha: 0.05),
      child: Row(
        children: [
          Text(
            _stageLabels[_stage.index],
            style: TextStyle(
              color: _theme.muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            'Palette: ${_theme.name}',
            style: TextStyle(color: _theme.muted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _storyTile({
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _theme.text,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: _theme.muted,
              fontSize: 11.3,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _articleTile({required int index, required String constrainedLabel}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 6, 10, 6),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: _theme.surface,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: _theme.primary.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _theme.primary.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Section ${index + 1}',
                  style: TextStyle(
                    color: _theme.text,
                    fontSize: 10.5,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Constrained lane',
                style: TextStyle(
                  color: _theme.muted,
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            constrainedLabel,
            style: TextStyle(
              color: _theme.text,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'This paragraph intentionally mimics long-form content. The cross-axis '
            'constraint keeps measure stable and readable as viewport size changes.',
            style: TextStyle(
              color: _theme.muted,
              fontSize: 11.4,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _laneTile({
    required String lane,
    required int index,
    required Color color,
    required String text,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 4, 6, 4),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '$lane ${index + 1}',
              style: TextStyle(
                color: _theme.text,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: _theme.text,
                fontSize: 10.8,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _presetButton(String label, double viewport, double constraint) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _breakpointViewport = viewport;
          _breakpointConstraint = constraint;
        });
        _debug('breakpoint preset => $label');
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: _theme.primary.withValues(alpha: 0.36)),
      ),
      child: Text(label),
    );
  }

  Widget _toggleChip({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return FilterChip(
      selected: value,
      selectedColor: _theme.primary.withValues(alpha: 0.18),
      backgroundColor: Colors.white,
      side: BorderSide(color: _theme.primary.withValues(alpha: 0.24)),
      onSelected: onChanged,
      label: Text(
        label,
        style: TextStyle(
          color: _theme.text,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _miniBanner(String text) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _theme.primary.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.view_column_rounded, color: _theme.primary, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: _theme.text,
              fontSize: 11.2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    required Color color,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 210,
          child: Text(
            '$label: ${value.toStringAsFixed(0)}',
            style: TextStyle(color: _theme.text, fontSize: 12),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: color,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _metricChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: _theme.text,
          fontSize: 10.5,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _matrixRow({
    required String aspect,
    required String unconstrained,
    required String constrained,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _theme.muted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(
              aspect,
              style: TextStyle(
                color: _theme.primary,
                fontSize: 11.2,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              unconstrained,
              style: TextStyle(color: _theme.muted, fontSize: 11.3),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              constrained,
              style: TextStyle(color: _theme.text, fontSize: 11.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doDont({
    required String title,
    required String detail,
    required bool good,
  }) {
    final color = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(good ? Icons.check_circle : Icons.cancel,
              color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _theme.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: TextStyle(color: _theme.muted, fontSize: 11.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qa({required String q, required String a}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _theme.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q: $q',
            style: TextStyle(
              color: _theme.text,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'A: $a',
            style: TextStyle(color: _theme.muted, fontSize: 11.4, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _check(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _theme.text, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _theme.secondary.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _theme.secondary.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _theme.secondary, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _theme.text, fontSize: 12, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: _theme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: _theme.text,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _card({
    required String title,
    required String subtitle,
    required Widget child,
    Color? tint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? _theme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _theme.muted.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _theme.text,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(color: _theme.muted, fontSize: 11.5),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _theme.primary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _theme.text, fontSize: 12, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
