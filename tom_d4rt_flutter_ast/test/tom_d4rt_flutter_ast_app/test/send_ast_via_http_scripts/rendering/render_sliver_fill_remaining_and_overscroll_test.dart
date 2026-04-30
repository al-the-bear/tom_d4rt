import 'package:flutter/material.dart';

class _FillTheme {
  final String name;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color ink;
  final Color muted;

  const _FillTheme({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.ink,
    required this.muted,
  });
}

const _themes = <_FillTheme>[
  _FillTheme(
    name: 'Azure Burst',
    primary: Color(0xFF1D4ED8),
    secondary: Color(0xFFF97316),
    accent: Color(0xFF14B8A6),
    background: Color(0xFFF3F7FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1F2937),
    muted: Color(0xFF64748B),
  ),
  _FillTheme(
    name: 'Pine Glow',
    primary: Color(0xFF047857),
    secondary: Color(0xFFE11D48),
    accent: Color(0xFF0EA5E9),
    background: Color(0xFFF1FBF7),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1D2C25),
    muted: Color(0xFF5F6F67),
  ),
  _FillTheme(
    name: 'Slate Mint',
    primary: Color(0xFF0F172A),
    secondary: Color(0xFF22D3EE),
    accent: Color(0xFFA3E635),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF0F172A),
    muted: Color(0xFF64748B),
  ),
];

enum _Stage {
  baseline,
  overscrollLab,
  headerNarrative,
  childMatrix,
  viewportSimulator,
  verification,
}

enum _ChildMode {
  staticCard,
  internalList,
  mixedStack,
}

dynamic build(BuildContext context) {
  return const _FillRemainingOverscrollStudio();
}

class _FillRemainingOverscrollStudio extends StatefulWidget {
  const _FillRemainingOverscrollStudio();

  @override
  State<_FillRemainingOverscrollStudio> createState() =>
      _FillRemainingOverscrollStudioState();
}

class _FillRemainingOverscrollStudioState
    extends State<_FillRemainingOverscrollStudio> {
  _Stage _stage = _Stage.baseline;
  int _themeIndex = 0;
  bool _verbose = false;

  double _baseLeadItems = 4;
  bool _baseUseFill = true;
  bool _baseShowViewportBadge = true;

  double _overLeadItems = 3;
  double _overStretchFactor = 1.0;
  bool _overShowElasticMarker = true;
  bool _overHeavyContent = false;

  bool _headPinned = true;
  bool _headFloating = false;
  double _headTopItems = 3;
  bool _headShowGuide = true;

  _ChildMode _childMode = _ChildMode.staticCard;
  bool _childUseScrollbar = true;
  bool _childFillScrollable = false;

  double _simHeight = 560;
  double _simLead = 3;
  bool _simShowThreeDevices = true;

  static const _stageTitles = <String>[
    '1 - Fill Baseline Theater',
    '2 - Overscroll Elastic Lab',
    '3 - Header Fill Narrative',
    '4 - Scrollable Child Matrix',
    '5 - Device Height Simulator',
    '6 - Verification Guide',
  ];

  _FillTheme get _t => _themes[_themeIndex];

  void _log(String value) {
    if (_verbose) {
      debugPrint('[RenderSliverFillRemainingAndOverscrollDemo] $value');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _t.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTopBar(),
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
          colors: [_t.primary, _t.secondary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.swap_vertical_circle_rounded,
                  color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Fill Remaining & Overscroll Studio',
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
                  'RenderSliverFillRemainingAndOverscroll',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'RenderSliverFillRemainingAndOverscroll extends the fill-remaining '
            'pattern so content can participate gracefully in overscroll space. '
            'This demo explores stretch, pinning context, and child modes.',
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

  Widget _buildTopBar() {
    return Container(
      width: double.infinity,
      color: _t.primary.withValues(alpha: 0.06),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Stage',
            style: TextStyle(
              color: _t.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (var i = 0; i < _stageTitles.length; i++)
            ChoiceChip(
              selected: _stage.index == i,
              selectedColor: _t.primary,
              backgroundColor: Colors.white,
              label: Text('${i + 1}'),
              labelStyle: TextStyle(
                color: _stage.index == i ? Colors.white : _t.ink,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
              onSelected: (_) {
                setState(() => _stage = _Stage.values[i]);
                _log('stage => ${_stage.name}');
              },
            ),
          const SizedBox(width: 8),
          Text(
            'Palette',
            style: TextStyle(
              color: _t.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (var i = 0; i < _themes.length; i++)
            GestureDetector(
              onTap: () => setState(() => _themeIndex = i),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _themes[i].primary,
                  border: Border.all(
                    color: _themeIndex == i ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Verbose', style: TextStyle(color: _t.ink, fontSize: 12)),
              Switch(
                value: _verbose,
                activeTrackColor: _t.accent,
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
      case _Stage.baseline:
        return _buildBaselineStage();
      case _Stage.overscrollLab:
        return _buildOverscrollStage();
      case _Stage.headerNarrative:
        return _buildHeaderNarrativeStage();
      case _Stage.childMatrix:
        return _buildChildMatrixStage();
      case _Stage.viewportSimulator:
        return _buildViewportSimulatorStage();
      case _Stage.verification:
        return _buildVerificationStage();
    }
  }

  Widget _buildBaselineStage() {
    final leadCount = _baseLeadItems.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Fill Baseline Theater'),
          const SizedBox(height: 8),
          Text(
            'This stage contrasts a regular sliver tail with '
            'SliverFillRemainingAndOverscroll. As lead content height changes, '
            'the fill behavior in remaining viewport becomes immediately visible.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Baseline Controls',
            subtitle: 'Lead sliver length and fill mode toggles.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Lead items',
                  value: _baseLeadItems,
                  min: 1,
                  max: 10,
                  divisions: 9,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _baseLeadItems = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _baseUseFill,
                      activeColor: _t.primary,
                      onChanged: (v) => setState(() => _baseUseFill = v ?? true),
                    ),
                    Text(
                      'Use SliverFillRemainingAndOverscroll',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _baseShowViewportBadge,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _baseShowViewportBadge = v ?? true),
                    ),
                    Text(
                      'Show viewport badge',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('lead', '$leadCount', _t.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Baseline Viewport',
            subtitle: _baseUseFill
                ? 'Tail section fills remaining space and can grow into overscroll.'
                : 'Tail section is a normal sliver box without fill semantics.',
            tint: _t.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
                ),
                child: Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _stageBanner('Lead section'),
                        ),
                        SliverList.builder(
                          itemCount: leadCount,
                          itemBuilder: (context, index) => _storyCard(
                            title: 'Lead card ${index + 1}',
                            subtitle: 'Consumes vertical scroll budget first.',
                            color: _t.primary.withValues(alpha: 0.13),
                          ),
                        ),
                        if (_baseUseFill)
                          SliverFillRemaining(
                            hasScrollBody: false,
                            fillOverscroll: true,
                            child: _fillPanel(
                              title: 'FillRemaining + Overscroll active',
                              detail:
                                  'Panel expands to occupy remaining viewport and stretches during pull.',
                              color: _t.secondary,
                              icon: Icons.open_in_full,
                            ),
                          )
                        else
                          SliverToBoxAdapter(
                            child: _fillPanel(
                              title: 'Regular box tail',
                              detail:
                                  'No fill behavior. Height is intrinsic to child.',
                              color: _t.secondary,
                              icon: Icons.crop_free,
                            ),
                          ),
                      ],
                    ),
                    if (_baseShowViewportBadge)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: _metricChip(
                            'mode', _baseUseFill ? 'fill' : 'normal', _t.secondary),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'Use this sliver when a bottom region should naturally occupy '
            'remaining viewport and still feel elastic when users pull beyond bounds.',
          ),
        ],
      ),
    );
  }

  Widget _buildOverscrollStage() {
    final lead = _overLeadItems.round();
    final stretchHeight = 220 + (_overStretchFactor * 120);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Overscroll Elastic Lab'),
          const SizedBox(height: 8),
          Text(
            'This lab emphasizes pull-beyond-boundary behavior. The fill panel '
            'acts like an elastic canvas, and simulated stretch intensity helps '
            'visualize overscroll participation.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Elastic Controls',
            subtitle: 'Lead content amount and stretch intensity.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Lead cards',
                  value: _overLeadItems,
                  min: 1,
                  max: 8,
                  divisions: 7,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _overLeadItems = v),
                ),
                _sliderRow(
                  label: 'Stretch factor',
                  value: _overStretchFactor,
                  min: 0.4,
                  max: 2.0,
                  divisions: 16,
                  color: _t.secondary,
                  onChanged: (v) => setState(() => _overStretchFactor = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _overShowElasticMarker,
                      activeColor: _t.secondary,
                      onChanged: (v) => setState(
                          () => _overShowElasticMarker = v ?? true),
                    ),
                    Text(
                      'Show elastic marker',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _overHeavyContent,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _overHeavyContent = v ?? false),
                    ),
                    Text(
                      'Heavy fill content',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('stretch', _overStretchFactor.toStringAsFixed(2),
                        _t.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Elastic Playground',
            subtitle: 'Pull downward at top/bottom to inspect responsive fill behavior.',
            tint: _t.secondary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
                ),
                child: Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(child: _stageBanner('Elastic lead lane')),
                        SliverList.builder(
                          itemCount: lead,
                          itemBuilder: (context, index) => _storyCard(
                            title: 'Lead elastic card ${index + 1}',
                            subtitle: 'Sets up remaining-space conditions.',
                            color: _t.primary.withValues(alpha: 0.12),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          fillOverscroll: true,
                          child: _elasticPanel(
                            stretchHeight: stretchHeight,
                            heavy: _overHeavyContent,
                          ),
                        ),
                      ],
                    ),
                    if (_overShowElasticMarker)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: _metricChip(
                            'elastic h', stretchHeight.toStringAsFixed(0), _t.secondary),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Elastic Notes',
            subtitle: 'Overscroll participation insights.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('fillOverscroll allows the tail region to stretch into pull space.'),
                _bullet('Great for playful empty states or call-to-action footers.'),
                _bullet('Avoid over-complex heavy children if smooth pull is a priority.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderNarrativeStage() {
    final lead = _headTopItems.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Header + Fill Narrative'),
          const SizedBox(height: 8),
          Text(
            'This stage combines app-bar dynamics with fill-remaining overscroll. '
            'It demonstrates realistic page structure where a hero/header leads '
            'into a remaining-space action region.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Header Controls',
            subtitle: 'Pinned/floating behavior and lead card count.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Lead cards after header',
                  value: _headTopItems,
                  min: 0,
                  max: 7,
                  divisions: 7,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _headTopItems = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _headPinned,
                      activeColor: _t.primary,
                      onChanged: (v) => setState(() => _headPinned = v ?? true),
                    ),
                    Text('Pinned', style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _headFloating,
                      activeColor: _t.secondary,
                      onChanged: (v) => setState(() => _headFloating = v ?? false),
                    ),
                    Text('Floating', style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _headShowGuide,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _headShowGuide = v ?? true),
                    ),
                    Text('Show guide', style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _metricChip('lead', '$lead', _t.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Narrative Scroll',
            subtitle: 'Header behaviors with fill-remaining tail.',
            tint: _t.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
                ),
                child: Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          pinned: _headPinned,
                          floating: _headFloating,
                          expandedHeight: 120,
                          backgroundColor: _t.primary,
                          flexibleSpace: FlexibleSpaceBar(
                            title: const Text('Narrative Header',
                                style: TextStyle(fontSize: 13)),
                            background: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [_t.primary, _t.secondary],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverList.builder(
                          itemCount: lead,
                          itemBuilder: (context, index) => _storyCard(
                            title: 'Narrative card ${index + 1}',
                            subtitle: 'Context before action panel.',
                            color: _t.primary.withValues(alpha: 0.12),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          fillOverscroll: true,
                          child: _fillPanel(
                            title: 'Action Footer Zone',
                            detail:
                                'This region remains anchored as trailing content and stretches into overscroll.',
                            color: _t.secondary,
                            icon: Icons.rocket_launch_rounded,
                          ),
                        ),
                      ],
                    ),
                    if (_headShowGuide)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: _metricChip(
                          'header',
                          '${_headPinned ? 'pinned' : 'loose'} / ${_headFloating ? 'floating' : 'static'}',
                          _t.secondary,
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

  Widget _buildChildMatrixStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Scrollable Child Matrix'),
          const SizedBox(height: 8),
          Text(
            'Compare child strategies inside fill-remaining-overscroll. '
            'Static, internally scrollable, and mixed stack variants each have '
            'different UX implications.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Child Mode Controls',
            subtitle: 'Select child strategy and scroll affordances.',
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _modeChip('Static', _ChildMode.staticCard),
                    _modeChip('Internal List', _ChildMode.internalList),
                    _modeChip('Mixed Stack', _ChildMode.mixedStack),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: _childUseScrollbar,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _childUseScrollbar = v ?? true),
                    ),
                    Text(
                      'Show scrollbar for internal list',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _childFillScrollable,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _childFillScrollable = v ?? false),
                    ),
                    Text(
                      'fill hasScrollBody',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('mode', _childMode.name, _t.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Child Matrix View',
            subtitle: 'How internal child behavior combines with fill/overscroll mechanics.',
            tint: _t.secondary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
                ),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: _stageBanner('Child mode: ${_childMode.name}'),
                    ),
                    SliverList.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => _storyCard(
                        title: 'Prelude ${index + 1}',
                        subtitle: 'Leading content before fill region.',
                        color: _t.primary.withValues(alpha: 0.12),
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: _childFillScrollable,
                      fillOverscroll: true,
                      child: _buildChildModeContent(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Child Strategy Notes',
            subtitle: 'When to choose each mode.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Static child: best for empty states and CTA panels.'),
                _bullet('Internal list child: useful for nested feeds in remaining area.'),
                _bullet('Mixed stack: good for hybrid forms and status + actions.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildModeContent() {
    switch (_childMode) {
      case _ChildMode.staticCard:
        return _fillPanel(
          title: 'Static Fill Child',
          detail: 'Simple fixed panel stretching into overscroll area.',
          color: _t.secondary,
          icon: Icons.crop_square_rounded,
        );
      case _ChildMode.internalList:
        final list = ListView.builder(
          itemCount: 18,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: _t.secondary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Internal item ${index + 1}',
              style: TextStyle(
                color: _t.ink,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
        if (_childUseScrollbar) {
          return Scrollbar(child: list);
        }
        return list;
      case _ChildMode.mixedStack:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _t.secondary.withValues(alpha: 0.16),
                _t.primary.withValues(alpha: 0.08),
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              _miniPanel('Status: Waiting for user action', Icons.notifications_active),
              _miniPanel('Tip: Pull further to preview stretch', Icons.touch_app),
              _miniPanel('Next: Submit or dismiss', Icons.task_alt),
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Dismiss'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Continue'),
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

  Widget _miniPanel(String text, IconData icon) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: _t.primary, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: _t.ink,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewportSimulatorStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Device Height Simulator'),
          const SizedBox(height: 8),
          Text(
            'Simulate short, medium, and tall viewport shells to understand '
            'where fill-remaining-and-overscroll provides most visual value.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Simulator Controls',
            subtitle: 'Viewport height and lead content size.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Single viewport height',
                  value: _simHeight,
                  min: 420,
                  max: 760,
                  divisions: 17,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _simHeight = v),
                ),
                _sliderRow(
                  label: 'Lead cards',
                  value: _simLead,
                  min: 1,
                  max: 7,
                  divisions: 6,
                  color: _t.secondary,
                  onChanged: (v) => setState(() => _simLead = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _simShowThreeDevices,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _simShowThreeDevices = v ?? true),
                    ),
                    Text(
                      'Show short/medium/tall trio',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('lead', _simLead.toStringAsFixed(0), _t.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_simShowThreeDevices)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _simCard('Short', 460, _simLead.round()),
                _simCard('Medium', 560, _simLead.round()),
                _simCard('Tall', 680, _simLead.round()),
              ],
            )
          else
            _simCard('Custom', _simHeight, _simLead.round()),
          const SizedBox(height: 12),
          _card(
            title: 'Simulator Takeaways',
            subtitle: 'How height influences perception.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Short viewports show fill transition quickly.'),
                _bullet('Medium viewports reveal balanced lead/fill behavior.'),
                _bullet('Tall viewports emphasize empty-space occupancy and pull stretch.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _simCard(String label, double height, int lead) {
    return SizedBox(
      width: 400,
      child: _card(
        title: '$label Shell',
        subtitle: 'Height ${height.toStringAsFixed(0)}',
        tint: _t.primary.withValues(alpha: 0.04),
        child: SizedBox(
          height: height,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
            ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _stageBanner('$label viewport simulation'),
                ),
                SliverList.builder(
                  itemCount: lead,
                  itemBuilder: (context, index) => _storyCard(
                    title: '$label lead ${index + 1}',
                    subtitle: 'Lead segment',
                    color: _t.primary.withValues(alpha: 0.12),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  fillOverscroll: true,
                  child: _fillPanel(
                    title: '$label fill zone',
                    detail: 'Remaining area behavior',
                    color: _t.secondary,
                    icon: Icons.aspect_ratio_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification Guide'),
          const SizedBox(height: 12),
          _card(
            title: 'Behavior Matrix',
            subtitle: 'Core semantics of this render sliver.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Primary role',
                  value:
                      'Occupy remaining viewport area after preceding slivers are laid out.',
                ),
                _matrixRow(
                  keyText: 'Overscroll behavior',
                  value:
                      'Can stretch into overscroll region when fillOverscroll is enabled.',
                ),
                _matrixRow(
                  keyText: 'Child strategy',
                  value:
                      'Supports static or scrollable children depending on hasScrollBody.',
                ),
                _matrixRow(
                  keyText: 'Best fit',
                  value:
                      'Bottom CTA zones, empty states, onboarding tails, adaptive footers.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do and Dont',
            subtitle: 'Practical guidance.',
            child: Column(
              children: [
                _doDont(
                  good: true,
                  title: 'Use for meaningful trailing viewport occupancy',
                  detail:
                      'Great when bottom section should avoid awkward dead space.',
                ),
                _doDont(
                  good: false,
                  title: 'Use as default tail everywhere',
                  detail:
                      'Regular slivers may be simpler when fill behavior is unnecessary.',
                ),
                _doDont(
                  good: true,
                  title: 'Tune hasScrollBody based on child behavior',
                  detail:
                      'Choose static panel vs nested scroll intentionally.',
                ),
                _doDont(
                  good: false,
                  title: 'Ignore pull physics on target platforms',
                  detail:
                      'Overscroll visuals vary with platform physics and config.',
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
                  q: 'How is this different from SliverFillRemaining?',
                  a: 'It supports fill into overscroll space when configured, '
                      'making pull gestures visually coherent.',
                ),
                _qa(
                  q: 'Should child always be non-scrollable?',
                  a: 'No. Choose based on UX. Non-scrollable for static CTA panels; '
                      'scrollable for rich internal content.',
                ),
                _qa(
                  q: 'Does it work with pinned headers above?',
                  a: 'Yes. It is often used after app bars or section headers '
                      'to complete the page composition.',
                ),
                _qa(
                  q: 'Can it be used in short pages only?',
                  a: 'It is most visible there, but also useful in tall layouts '
                      'where adaptive footers are desired.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo criteria validation.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Baseline comparison between normal tail and fill overscroll tail.'),
                _check('Interactive overscroll elasticity lab with stretch factor.'),
                _check('Header + fill scenario showing realistic scroll narrative.'),
                _check('Child mode matrix covering static, internal, and mixed strategies.'),
                _check('Viewport simulator across short, medium, and tall shells.'),
                _check('Guide includes matrix, dos/donts, FAQ, and checklist.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'RenderSliverFillRemainingAndOverscroll is a high-leverage tail '
            'sliver for adaptive pages where remaining space and overscroll '
            'interaction should feel intentional and alive.',
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _t.ink.withValues(alpha: 0.05),
      child: Row(
        children: [
          Text(
            _stageTitles[_stage.index],
            style: TextStyle(
              color: _t.muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            'Palette: ${_t.name}',
            style: TextStyle(color: _t.muted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _fillPanel({
    required String title,
    required String detail,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.14),
            color.withValues(alpha: 0.07),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 34),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: _t.ink,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              detail,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _t.muted,
                fontSize: 12.2,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _elasticPanel({required double stretchHeight, required bool heavy}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _t.secondary.withValues(alpha: 0.18),
            _t.primary.withValues(alpha: 0.08),
          ],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          _metricChip('stretch target', stretchHeight.toStringAsFixed(0), _t.secondary),
          const SizedBox(height: 10),
          Container(
            height: stretchHeight,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Elastic canvas',
                style: TextStyle(
                  color: _t.ink,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          if (heavy) ...[
            const SizedBox(height: 10),
            for (var i = 0; i < 6; i++)
              Container(
                margin: const EdgeInsets.fromLTRB(14, 4, 14, 4),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Heavy extra segment ${i + 1}',
                  style: TextStyle(
                    color: _t.ink,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
          const Spacer(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _modeChip(String label, _ChildMode mode) {
    return ChoiceChip(
      selected: _childMode == mode,
      selectedColor: _t.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _childMode == mode ? Colors.white : _t.ink,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) => setState(() => _childMode = mode),
    );
  }

  Widget _storyCard({
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
              color: _t.ink,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: _t.muted,
              fontSize: 11.2,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stageBanner(String text) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _t.primary.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.vertical_align_bottom_rounded, color: _t.primary, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: _t.ink,
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
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 220,
          child: Text(
            '$label: ${value.toStringAsFixed(0)}',
            style: TextStyle(color: _t.ink, fontSize: 12),
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
        border: Border.all(color: color.withValues(alpha: 0.34)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: _t.ink,
          fontSize: 10.5,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _matrixRow({required String keyText, required String value}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _t.muted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              keyText,
              style: TextStyle(
                color: _t.primary,
                fontSize: 11.3,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: _t.ink, fontSize: 11.4, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doDont({
    required bool good,
    required String title,
    required String detail,
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
                    color: _t.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: TextStyle(color: _t.muted, fontSize: 11.3),
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
        border: Border.all(color: _t.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q: $q',
            style: TextStyle(
              color: _t.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'A: $a',
            style: TextStyle(color: _t.muted, fontSize: 11.4, height: 1.35),
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
              style: TextStyle(color: _t.ink, fontSize: 12),
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
        color: _t.secondary.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _t.secondary.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _t.secondary, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _t.ink, fontSize: 12, height: 1.35),
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
            color: _t.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: _t.ink,
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
        color: tint ?? _t.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _t.muted.withValues(alpha: 0.2)),
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
              color: _t.ink,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(color: _t.muted, fontSize: 11.5),
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
              color: _t.primary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _t.ink, fontSize: 12, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
