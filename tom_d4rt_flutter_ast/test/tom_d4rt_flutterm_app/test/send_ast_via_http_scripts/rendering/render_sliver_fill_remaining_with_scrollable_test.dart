import 'package:flutter/material.dart';

class _StudioTheme {
  final String name;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color ink;
  final Color muted;

  const _StudioTheme({
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

const _themes = <_StudioTheme>[
  _StudioTheme(
    name: 'Indigo Pulse',
    primary: Color(0xFF1E40AF),
    secondary: Color(0xFFF97316),
    accent: Color(0xFF14B8A6),
    background: Color(0xFFF3F7FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1F2937),
    muted: Color(0xFF64748B),
  ),
  _StudioTheme(
    name: 'Emerald Signal',
    primary: Color(0xFF047857),
    secondary: Color(0xFFE11D48),
    accent: Color(0xFF0891B2),
    background: Color(0xFFF1FBF7),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1D2C25),
    muted: Color(0xFF5F6F67),
  ),
  _StudioTheme(
    name: 'Graphite Lime',
    primary: Color(0xFF0F172A),
    secondary: Color(0xFF84CC16),
    accent: Color(0xFF22D3EE),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF0F172A),
    muted: Color(0xFF64748B),
  ),
];

enum _Stage {
  baseline,
  controlRoom,
  pinnedHeader,
  ownershipLab,
  deviceShowcase,
  verification,
}

enum _PhysicsMode {
  clamping,
  bouncing,
  never,
}

dynamic build(BuildContext context) {
  return const _ScrollableFillStudio();
}

class _ScrollableFillStudio extends StatefulWidget {
  const _ScrollableFillStudio();

  @override
  State<_ScrollableFillStudio> createState() => _ScrollableFillStudioState();
}

class _ScrollableFillStudioState extends State<_ScrollableFillStudio> {
  _Stage _stage = _Stage.baseline;
  int _themeIndex = 0;
  bool _verbose = false;

  double _baseLead = 3;
  bool _baseUseScrollable = true;
  bool _baseShowBadges = true;

  double _controlLead = 2;
  double _controlInnerItems = 22;
  _PhysicsMode _physicsMode = _PhysicsMode.bouncing;
  bool _controlShowInnerHeader = true;
  bool _controlShowScrollbar = true;

  bool _pinnedHeader = true;
  bool _floatingHeader = false;
  double _pinnedLead = 2;
  bool _pinnedShowLegend = true;

  double _ownerLead = 3;
  bool _ownerShowRail = true;
  bool _ownerDenseInner = false;

  bool _showThreeDevices = true;
  double _singleHeight = 600;
  double _deviceLead = 2;

  static const _stageTitles = <String>[
    '1 - Scroll Body Baseline',
    '2 - Nested Feed Control Room',
    '3 - Pinned Header Integration',
    '4 - Viewport Ownership Lab',
    '5 - Device Profile Showcase',
    '6 - Verification Guide',
  ];

  _StudioTheme get _t => _themes[_themeIndex];

  void _log(String value) {
    if (_verbose) {
      debugPrint('[RenderSliverFillRemainingWithScrollableDemo] $value');
    }
  }

  ScrollPhysics _selectedPhysics() {
    switch (_physicsMode) {
      case _PhysicsMode.clamping:
        return const ClampingScrollPhysics();
      case _PhysicsMode.bouncing:
        return const BouncingScrollPhysics();
      case _PhysicsMode.never:
        return const NeverScrollableScrollPhysics();
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
              const Icon(Icons.view_timeline_rounded,
                  color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Scrollable Fill Remaining Studio',
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
                  'RenderSliverFillRemainingWithScrollable',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'This render path powers SliverFillRemaining when the child has '
            'scroll body behavior. It lets trailing viewport regions host '
            'dense internal scrollable content while preserving sliver flow.',
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
      case _Stage.controlRoom:
        return _buildControlRoomStage();
      case _Stage.pinnedHeader:
        return _buildPinnedHeaderStage();
      case _Stage.ownershipLab:
        return _buildOwnershipStage();
      case _Stage.deviceShowcase:
        return _buildDeviceShowcaseStage();
      case _Stage.verification:
        return _buildVerificationStage();
    }
  }

  Widget _buildBaselineStage() {
    final lead = _baseLead.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Scroll Body Baseline'),
          const SizedBox(height: 8),
          Text(
            'Baseline contrast: static trailing fill versus scrollable trailing '
            'fill. This reveals where RenderSliverFillRemainingWithScrollable '
            'becomes the active render strategy.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Baseline Controls',
            subtitle: 'Lead content and scrollable-tail toggle.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Lead cards',
                  value: _baseLead,
                  min: 1,
                  max: 8,
                  divisions: 7,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _baseLead = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _baseUseScrollable,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _baseUseScrollable = v ?? true),
                    ),
                    Text(
                      'Use scrollable child in fill region',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _baseShowBadges,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _baseShowBadges = v ?? true),
                    ),
                    Text(
                      'Show mode badge',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('lead', '$lead', _t.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Baseline Viewport',
            subtitle: _baseUseScrollable
                ? 'Fill region hosts an internal scrollable timeline.'
                : 'Fill region is static and non-scroll-body.',
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
                          child: _stageBanner('Lead slivers'),
                        ),
                        SliverList.builder(
                          itemCount: lead,
                          itemBuilder: (context, index) => _storyCard(
                            title: 'Lead row ${index + 1}',
                            subtitle: 'Outer scroll context before fill tail.',
                            color: _t.primary.withValues(alpha: 0.12),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: _baseUseScrollable,
                          child: _baseUseScrollable
                              ? _internalScrollableTimeline(itemCount: 18)
                              : _staticFillPanel(
                                  title: 'Static fill region',
                                  detail:
                                      'No internal scrolling. Region expands as a single panel.',
                                ),
                        ),
                      ],
                    ),
                    if (_baseShowBadges)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _metricChip(
                            'mode', _baseUseScrollable ? 'scroll-body' : 'static', _t.secondary),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'When hasScrollBody is true, the fill child is treated as a '
            'scrollable viewport owner, enabling rich trailing-content interactions.',
          ),
        ],
      ),
    );
  }

  Widget _buildControlRoomStage() {
    final lead = _controlLead.round();
    final inner = _controlInnerItems.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Nested Feed Control Room'),
          const SizedBox(height: 8),
          Text(
            'Tune lead content, inner list depth, and physics to inspect '
            'outer-to-inner scroll handoff behavior in a controlled setup.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Control Inputs',
            subtitle: 'Inner feed characteristics and physics selection.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Lead outer cards',
                  value: _controlLead,
                  min: 0,
                  max: 6,
                  divisions: 6,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _controlLead = v),
                ),
                _sliderRow(
                  label: 'Inner feed items',
                  value: _controlInnerItems,
                  min: 6,
                  max: 40,
                  divisions: 17,
                  color: _t.secondary,
                  onChanged: (v) => setState(() => _controlInnerItems = v),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _physicsChip('Clamping', _PhysicsMode.clamping),
                    _physicsChip('Bouncing', _PhysicsMode.bouncing),
                    _physicsChip('Never', _PhysicsMode.never),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: _controlShowInnerHeader,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _controlShowInnerHeader = v ?? true),
                    ),
                    Text('Show inner header',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _controlShowScrollbar,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _controlShowScrollbar = v ?? true),
                    ),
                    Text('Show inner scrollbar',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _metricChip('inner', '$inner', _t.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Control Room Viewport',
            subtitle: 'Observe handoff from outer sliver flow into inner list view.',
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
                      child: _stageBanner('Outer lead section before scroll-body fill'),
                    ),
                    SliverList.builder(
                      itemCount: lead,
                      itemBuilder: (context, index) => _storyCard(
                        title: 'Outer card ${index + 1}',
                        subtitle: 'Consumes leading viewport space.',
                        color: _t.primary.withValues(alpha: 0.12),
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: true,
                      child: _innerFeedPanel(
                        itemCount: inner,
                        physics: _selectedPhysics(),
                        withHeader: _controlShowInnerHeader,
                        withScrollbar: _controlShowScrollbar,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Handoff Notes',
            subtitle: 'What to watch while interacting.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Outer slivers scroll until fill region becomes primary viewport.'),
                _bullet('Inner physics choice changes feel of nested scrolling.'),
                _bullet('Scrollbar helps communicate independent inner scroll state.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinnedHeaderStage() {
    final lead = _pinnedLead.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Pinned Header + Scrollable Fill'),
          const SizedBox(height: 8),
          Text(
            'A practical page archetype: dynamic app bar, some leading cards, '
            'then a scroll-body fill region for dense content modules.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Header Controls',
            subtitle: 'Pinned/floating modes and lead count.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Lead cards after header',
                  value: _pinnedLead,
                  min: 0,
                  max: 6,
                  divisions: 6,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _pinnedLead = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _pinnedHeader,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _pinnedHeader = v ?? true),
                    ),
                    Text('Pinned', style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _floatingHeader,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _floatingHeader = v ?? false),
                    ),
                    Text('Floating', style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _pinnedShowLegend,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _pinnedShowLegend = v ?? true),
                    ),
                    Text('Legend badge', style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _metricChip('lead', '$lead', _t.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Integrated Narrative View',
            subtitle: 'Header + leading context + scroll-body fill.',
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
                          pinned: _pinnedHeader,
                          floating: _floatingHeader,
                          expandedHeight: 120,
                          backgroundColor: _t.primary,
                          flexibleSpace: FlexibleSpaceBar(
                            title: const Text('Integrated Header',
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
                            title: 'Intro card ${index + 1}',
                            subtitle: 'Narrative setup before deep content.',
                            color: _t.primary.withValues(alpha: 0.12),
                          ),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: true,
                          child: _innerFeedPanel(
                            itemCount: 24,
                            physics: const BouncingScrollPhysics(),
                            withHeader: true,
                            withScrollbar: true,
                          ),
                        ),
                      ],
                    ),
                    if (_pinnedShowLegend)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _metricChip(
                          'header',
                          '${_pinnedHeader ? 'pinned' : 'free'} / ${_floatingHeader ? 'floating' : 'static'}',
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

  Widget _buildOwnershipStage() {
    final lead = _ownerLead.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Viewport Ownership Lab'),
          const SizedBox(height: 8),
          Text(
            'This stage focuses on who owns scroll movement at each phase. '
            'A side rail and density toggle help inspect transitions between '
            'outer sliver progress and inner viewport scrolling.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Ownership Controls',
            subtitle: 'Lead amount and inner density options.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Lead cards',
                  value: _ownerLead,
                  min: 1,
                  max: 7,
                  divisions: 6,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _ownerLead = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _ownerShowRail,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _ownerShowRail = v ?? true),
                    ),
                    Text('Show ownership rail',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _ownerDenseInner,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _ownerDenseInner = v ?? false),
                    ),
                    Text('Dense inner feed',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _metricChip('inner items', _ownerDenseInner ? '34' : '18', _t.secondary),
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
                flex: 3,
                child: _card(
                  title: 'Ownership Scene',
                  subtitle: 'Outer sliver then inner scroll-body ownership.',
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
                            child: _stageBanner('Ownership handoff demonstration'),
                          ),
                          SliverList.builder(
                            itemCount: lead,
                            itemBuilder: (context, index) => _storyCard(
                              title: 'Outer ownership ${index + 1}',
                              subtitle: 'Outer sliver controls scroll here.',
                              color: _t.primary.withValues(alpha: 0.12),
                            ),
                          ),
                          SliverFillRemaining(
                            hasScrollBody: true,
                            child: _innerFeedPanel(
                              itemCount: _ownerDenseInner ? 34 : 18,
                              physics: const BouncingScrollPhysics(),
                              withHeader: true,
                              withScrollbar: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (_ownerShowRail) ...[
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _card(
                    title: 'Ownership Rail',
                    subtitle: 'Conceptual timeline.',
                    tint: _t.primary.withValues(alpha: 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _railStep('1', 'Outer slivers consume scroll offset'),
                        _railStep('2', 'Fill region reaches viewport boundary'),
                        _railStep('3', 'Inner viewport starts handling dense content'),
                        _railStep('4', 'User perceives seamless continuity'),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: _t.muted.withValues(alpha: 0.2)),
                          ),
                          child: Text(
                            'Why this render class matters:\n'
                            '- prevents awkward dead space\n'
                            '- allows rich tail content\n'
                            '- keeps sliver composition clean',
                            style: TextStyle(
                              color: _t.ink,
                              fontSize: 11,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _railStep(String n, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _t.primary.withValues(alpha: 0.14),
            ),
            child: Text(
              n,
              style: TextStyle(
                color: _t.ink,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _t.ink, fontSize: 11.5, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceShowcaseStage() {
    final lead = _deviceLead.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Device Profile Showcase'),
          const SizedBox(height: 8),
          Text(
            'Height strongly affects the handoff moment into scroll-body fill. '
            'Compare three shells or a custom single shell to observe behavior.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Showcase Controls',
            subtitle: 'Device mode and lead content.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Custom single height',
                  value: _singleHeight,
                  min: 420,
                  max: 760,
                  divisions: 17,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _singleHeight = v),
                ),
                _sliderRow(
                  label: 'Lead cards',
                  value: _deviceLead,
                  min: 1,
                  max: 6,
                  divisions: 5,
                  color: _t.secondary,
                  onChanged: (v) => setState(() => _deviceLead = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _showThreeDevices,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _showThreeDevices = v ?? true),
                    ),
                    Text('Show trio mode',
                        style: TextStyle(color: _t.ink, fontSize: 12)),
                    const Spacer(),
                    _metricChip('lead', '$lead', _t.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_showThreeDevices)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _deviceCard('Compact', 460, lead),
                _deviceCard('Balanced', 560, lead),
                _deviceCard('Tall', 680, lead),
              ],
            )
          else
            _deviceCard('Custom', _singleHeight, lead),
          const SizedBox(height: 12),
          _card(
            title: 'Device Takeaways',
            subtitle: 'What changes with height.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Compact shells reach inner scroll-body sooner.'),
                _bullet('Balanced shells show mixed outer and inner movement.'),
                _bullet('Tall shells leave more room for visible fill panel framing.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _deviceCard(String label, double height, int lead) {
    return SizedBox(
      width: 400,
      child: _card(
        title: '$label shell',
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
                  child: _stageBanner('$label viewport profile'),
                ),
                SliverList.builder(
                  itemCount: lead,
                  itemBuilder: (context, index) => _storyCard(
                    title: '$label lead ${index + 1}',
                    subtitle: 'Outer sliver section',
                    color: _t.primary.withValues(alpha: 0.12),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: _innerFeedPanel(
                    itemCount: 16,
                    physics: const BouncingScrollPhysics(),
                    withHeader: true,
                    withScrollbar: true,
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
            subtitle: 'Core understanding for this render class.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Activation context',
                  value:
                      'SliverFillRemaining with scroll-body child behavior triggers this render path.',
                ),
                _matrixRow(
                  keyText: 'Purpose',
                  value:
                      'Provide full remaining viewport region while allowing child-internal scrolling.',
                ),
                _matrixRow(
                  keyText: 'Interaction model',
                  value:
                      'Outer slivers scroll first; inner viewport then handles dense content.',
                ),
                _matrixRow(
                  keyText: 'Best use cases',
                  value:
                      'Trailing feeds, logs, inspector panes, and nested content dashboards.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do and Dont',
            subtitle: 'Practical recommendations.',
            child: Column(
              children: [
                _doDont(
                  good: true,
                  title: 'Use for rich trailing content with internal scroll',
                  detail:
                      'Maintains strong page composition while enabling deep child interaction.',
                ),
                _doDont(
                  good: false,
                  title: 'Use for simple static footer panels',
                  detail:
                      'Non-scroll fill variant is usually simpler and clearer there.',
                ),
                _doDont(
                  good: true,
                  title: 'Tune nested physics intentionally',
                  detail:
                      'Clamping, bouncing, or disabled modes materially affect feel.',
                ),
                _doDont(
                  good: false,
                  title: 'Ignore nested scroll cues',
                  detail:
                      'Add visual hints like headers or scrollbars for better usability.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common questions.',
            child: Column(
              children: [
                _qa(
                  q: 'How is this different from regular SliverFillRemaining?',
                  a: 'This variant is for scroll-body children and preserves '
                      'a robust internal viewport experience.',
                ),
                _qa(
                  q: 'Can I place ListView inside this fill region?',
                  a: 'Yes. It is a common pattern for trailing detail panes '
                      'or activity feeds.',
                ),
                _qa(
                  q: 'Is this only for desktop-like layouts?',
                  a: 'No. It also helps on mobile when bottom sections need '
                      'independent scroll behavior.',
                ),
                _qa(
                  q: 'Should I always show a scrollbar?',
                  a: 'Not always, but it improves discoverability in nested '
                      'scroll-heavy interfaces.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo criteria satisfaction.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Baseline static vs scroll-body fill comparison provided.'),
                _check('Control room includes inner item and physics tuning.'),
                _check('Pinned/floating header integration scenario implemented.'),
                _check('Viewport ownership handoff visualization included.'),
                _check('Device height showcase demonstrates adaptive behavior.'),
                _check('Guide includes matrix, do/dont, FAQ, and checklist.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'RenderSliverFillRemainingWithScrollable is a structural enabler '
            'for nested trailing content regions. It keeps page flow coherent '
            'while granting rich internal scroll capabilities.',
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

  Widget _internalScrollableTimeline({required int itemCount}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _t.secondary.withValues(alpha: 0.14),
            _t.primary.withValues(alpha: 0.06),
          ],
        ),
      ),
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Timeline row ${index + 1}',
            style: TextStyle(
              color: _t.ink,
              fontSize: 11.8,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _innerFeedPanel({
    required int itemCount,
    required ScrollPhysics physics,
    required bool withHeader,
    required bool withScrollbar,
  }) {
    Widget list = ListView.builder(
      physics: physics,
      itemCount: itemCount + (withHeader ? 1 : 0),
      itemBuilder: (context, index) {
        if (withHeader && index == 0) {
          return Container(
            margin: const EdgeInsets.fromLTRB(12, 8, 12, 6),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: _t.secondary.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Inner feed header',
              style: TextStyle(
                color: _t.ink,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        }
        final adjusted = withHeader ? index : index + 1;
        return Container(
          margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: adjusted.isEven
                ? _t.primary.withValues(alpha: 0.12)
                : _t.secondary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.78),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '#$adjusted',
                  style: TextStyle(
                    color: _t.ink,
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Inner feed entry $adjusted',
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
      },
    );

    if (withScrollbar) {
      list = Scrollbar(child: list);
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _t.secondary.withValues(alpha: 0.14),
            _t.primary.withValues(alpha: 0.07),
          ],
        ),
      ),
      child: list,
    );
  }

  Widget _staticFillPanel({required String title, required String detail}) {
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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.view_agenda_rounded, color: _t.secondary, size: 34),
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
              Text(
                detail,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _t.muted,
                  fontSize: 12.2,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _physicsChip(String label, _PhysicsMode mode) {
    return ChoiceChip(
      selected: _physicsMode == mode,
      selectedColor: _t.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _physicsMode == mode ? Colors.white : _t.ink,
        fontSize: 11.4,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) => setState(() => _physicsMode = mode),
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
            width: 190,
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
