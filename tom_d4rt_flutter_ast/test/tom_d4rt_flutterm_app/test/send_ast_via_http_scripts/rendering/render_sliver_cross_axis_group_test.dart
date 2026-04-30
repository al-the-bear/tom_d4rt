import 'package:flutter/material.dart';

class _Palette {
  final String name;
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color background;
  final Color surface;
  final Color ink;
  final Color muted;

  const _Palette({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.background,
    required this.surface,
    required this.ink,
    required this.muted,
  });
}

const _palettes = <_Palette>[
  _Palette(
    name: 'Ocean Desk',
    primary: Color(0xFF2563EB),
    secondary: Color(0xFFF97316),
    tertiary: Color(0xFF14B8A6),
    background: Color(0xFFF3F7FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1F2937),
    muted: Color(0xFF64748B),
  ),
  _Palette(
    name: 'Forest Studio',
    primary: Color(0xFF047857),
    secondary: Color(0xFFFB7185),
    tertiary: Color(0xFF0EA5E9),
    background: Color(0xFFF1FBF7),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1D2C25),
    muted: Color(0xFF5F6F67),
  ),
  _Palette(
    name: 'Slate Neon',
    primary: Color(0xFF111827),
    secondary: Color(0xFF22D3EE),
    tertiary: Color(0xFFA3E635),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF0F172A),
    muted: Color(0xFF64748B),
  ),
];

enum _GroupStage {
  dashboard,
  flexMixer,
  mixedSlivers,
  geometryTheater,
  patterns,
  verification,
}

dynamic build(BuildContext context) {
  return const _CrossAxisGroupLab();
}

class _CrossAxisGroupLab extends StatefulWidget {
  const _CrossAxisGroupLab();

  @override
  State<_CrossAxisGroupLab> createState() => _CrossAxisGroupLabState();
}

class _CrossAxisGroupLabState extends State<_CrossAxisGroupLab> {
  _GroupStage _stage = _GroupStage.dashboard;
  int _paletteIndex = 0;
  bool _verbose = false;

  int _dashLeftFlex = 1;
  int _dashCenterFlex = 2;
  int _dashRightFlex = 1;
  bool _dashDense = false;

  int _mixerLeftFlex = 1;
  int _mixerCenterFlex = 2;
  int _mixerRightFlex = 1;
  bool _mixerUseFixedCenter = false;
  double _mixerCenterMax = 260;
  bool _mixerShowDistribution = true;

  bool _mixedUseHeader = true;
  bool _mixedUseGrid = true;
  bool _mixedUseFixedRail = true;
  int _mixedCenterFlex = 2;

  int _geoLeftFlex = 1;
  int _geoCenterFlex = 3;
  int _geoRightFlex = 2;
  bool _geoShowLongest = true;
  bool _geoCenterLong = true;

  double _patternViewportWidth = 980;
  int _patternLeftFlex = 1;
  int _patternCenterFlex = 3;
  int _patternRightFlex = 1;

  static const _stageTitles = <String>[
    '1 · Multi-Lane Dashboard',
    '2 · Flex Mixer Lab',
    '3 · Mixed Sliver Types',
    '4 · Geometry Theater',
    '5 · Pattern Gallery',
    '6 · Verification Guide',
  ];

  _Palette get _p => _palettes[_paletteIndex];

  void _log(String value) {
    if (_verbose) {
      debugPrint('[RenderSliverCrossAxisGroupDemo] $value');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTopControls(),
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
          colors: [_p.primary, _p.secondary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.view_week_rounded,
                  color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Cross-Axis Group Lab',
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
                  'RenderSliverCrossAxisGroup',
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
            'RenderSliverCrossAxisGroup lays out multiple slivers side by side '
            'across the cross axis. It enables lane-based designs where each '
            'lane is still a true sliver with independent composition.',
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

  Widget _buildTopControls() {
    return Container(
      width: double.infinity,
      color: _p.primary.withValues(alpha: 0.06),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Stage',
            style: TextStyle(
              color: _p.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (var i = 0; i < _stageTitles.length; i++)
            ChoiceChip(
              selected: _stage.index == i,
              selectedColor: _p.primary,
              backgroundColor: Colors.white,
              label: Text('${i + 1}'),
              labelStyle: TextStyle(
                color: _stage.index == i ? Colors.white : _p.ink,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
              onSelected: (_) {
                setState(() => _stage = _GroupStage.values[i]);
                _log('stage => ${_stage.name}');
              },
            ),
          const SizedBox(width: 8),
          Text(
            'Palette',
            style: TextStyle(
              color: _p.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (var i = 0; i < _palettes.length; i++)
            GestureDetector(
              onTap: () => setState(() => _paletteIndex = i),
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _palettes[i].primary,
                  border: Border.all(
                    color: _paletteIndex == i ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Verbose', style: TextStyle(color: _p.ink, fontSize: 12)),
              Switch(
                value: _verbose,
                activeTrackColor: _p.tertiary,
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
      case _GroupStage.dashboard:
        return _buildDashboardStage();
      case _GroupStage.flexMixer:
        return _buildFlexMixerStage();
      case _GroupStage.mixedSlivers:
        return _buildMixedSliverStage();
      case _GroupStage.geometryTheater:
        return _buildGeometryTheaterStage();
      case _GroupStage.patterns:
        return _buildPatternGalleryStage();
      case _GroupStage.verification:
        return _buildVerificationStage();
    }
  }

  Widget _buildDashboardStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Multi-Lane Dashboard'),
          const SizedBox(height: 8),
          Text(
            'This baseline scene shows a three-lane dashboard where each lane '
            'is a sliver subtree. The group coordinates cross-axis allocation '
            'while each lane keeps its own sliver composition style.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Dashboard Controls',
            subtitle: 'Adjust lane flex ratios and row density.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Left flex',
                  value: _dashLeftFlex.toDouble(),
                  min: 1,
                  max: 4,
                  divisions: 3,
                  color: _p.primary,
                  onChanged: (v) => setState(() => _dashLeftFlex = v.round()),
                ),
                _sliderRow(
                  label: 'Center flex',
                  value: _dashCenterFlex.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _dashCenterFlex = v.round()),
                ),
                _sliderRow(
                  label: 'Right flex',
                  value: _dashRightFlex.toDouble(),
                  min: 1,
                  max: 4,
                  divisions: 3,
                  color: _p.tertiary,
                  onChanged: (v) => setState(() => _dashRightFlex = v.round()),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _dashDense,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _dashDense = v ?? false),
                    ),
                    Text(
                      'Dense lane content',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('L', '$_dashLeftFlex', _p.primary),
                    const SizedBox(width: 6),
                    _metricChip('C', '$_dashCenterFlex', _p.secondary),
                    const SizedBox(width: 6),
                    _metricChip('R', '$_dashRightFlex', _p.tertiary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Lane-Based Work Surface',
            subtitle:
                'Three independent sliver lanes share one scroll context via SliverCrossAxisGroup.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _laneBanner(
                          'Dashboard lanes orchestrated by SliverCrossAxisGroup'),
                    ),
                    SliverCrossAxisGroup(
                      slivers: [
                        SliverCrossAxisExpanded(
                          flex: _dashLeftFlex,
                          sliver: SliverList.builder(
                            itemCount: _dashDense ? 20 : 12,
                            itemBuilder: (context, index) => _laneCard(
                              lane: 'Tools',
                              title: 'Shortcut ${index + 1}',
                              subtitle: 'Quick command lane item',
                              color: _p.primary.withValues(alpha: 0.13),
                            ),
                          ),
                        ),
                        SliverCrossAxisExpanded(
                          flex: _dashCenterFlex,
                          sliver: SliverList.builder(
                            itemCount: _dashDense ? 24 : 14,
                            itemBuilder: (context, index) => _laneCard(
                              lane: 'Feed',
                              title: 'Main card ${index + 1}',
                              subtitle:
                                  'Primary narrative lane with more visual weight.',
                              color: _p.secondary.withValues(alpha: 0.13),
                            ),
                          ),
                        ),
                        SliverCrossAxisExpanded(
                          flex: _dashRightFlex,
                          sliver: SliverList.builder(
                            itemCount: _dashDense ? 18 : 10,
                            itemBuilder: (context, index) => _laneCard(
                              lane: 'Activity',
                              title: 'Signal ${index + 1}',
                              subtitle: 'Status and alerts lane',
                              color: _p.tertiary.withValues(alpha: 0.14),
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
          _infoBox(
            'Each lane is a full sliver subtree, not just a widget column. '
            'That means lane internals can still use advanced sliver patterns.',
          ),
        ],
      ),
    );
  }

  Widget _buildFlexMixerStage() {
    final totalFlex = _mixerUseFixedCenter
        ? _mixerLeftFlex + _mixerRightFlex
        : _mixerLeftFlex + _mixerCenterFlex + _mixerRightFlex;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Flex Mixer Lab'),
          const SizedBox(height: 8),
          Text(
            'This lab explores allocation behavior. You can switch center lane '
            'between flex mode and fixed-width mode (via SliverConstrainedCrossAxis).',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Mixer Controls',
            subtitle: 'Tune lane distribution and center mode.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Left flex',
                  value: _mixerLeftFlex.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  color: _p.primary,
                  onChanged: (v) => setState(() => _mixerLeftFlex = v.round()),
                ),
                _sliderRow(
                  label: 'Center flex',
                  value: _mixerCenterFlex.toDouble(),
                  min: 1,
                  max: 6,
                  divisions: 5,
                  color: _p.secondary,
                  onChanged: (v) =>
                      setState(() => _mixerCenterFlex = v.round()),
                ),
                _sliderRow(
                  label: 'Right flex',
                  value: _mixerRightFlex.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  color: _p.tertiary,
                  onChanged: (v) => setState(() => _mixerRightFlex = v.round()),
                ),
                _sliderRow(
                  label: 'Center maxExtent',
                  value: _mixerCenterMax,
                  min: 180,
                  max: 420,
                  divisions: 24,
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _mixerCenterMax = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _mixerUseFixedCenter,
                      activeColor: _p.secondary,
                      onChanged: (v) =>
                          setState(() => _mixerUseFixedCenter = v ?? false),
                    ),
                    Text(
                      'Center uses fixed maxExtent lane',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _mixerShowDistribution,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _mixerShowDistribution = v ?? true),
                    ),
                    Text(
                      'Show distribution panel',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('total flex', '$totalFlex', _p.primary),
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
                  title: 'Mixer Viewport',
                  subtitle: _mixerUseFixedCenter
                      ? 'Center lane fixed by maxExtent; side lanes divide remainder.'
                      : 'All three lanes flex proportionally.',
                  tint: _p.secondary.withValues(alpha: 0.04),
                  child: SizedBox(
                    height: 520,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: _p.muted.withValues(alpha: 0.25)),
                      ),
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: _laneBanner('Interactive lane distribution'),
                          ),
                          SliverCrossAxisGroup(
                            slivers: [
                              SliverCrossAxisExpanded(
                                flex: _mixerLeftFlex,
                                sliver: SliverList.builder(
                                  itemCount: 14,
                                  itemBuilder: (context, index) => _laneCard(
                                    lane: 'Left',
                                    title: 'Item ${index + 1}',
                                    subtitle: 'Flex lane $_mixerLeftFlex',
                                    color: _p.primary.withValues(alpha: 0.12),
                                  ),
                                ),
                              ),
                              if (_mixerUseFixedCenter)
                                SliverConstrainedCrossAxis(
                                  maxExtent: _mixerCenterMax,
                                  sliver: SliverList.builder(
                                    itemCount: 14,
                                    itemBuilder: (context, index) => _laneCard(
                                      lane: 'Center',
                                      title: 'Item ${index + 1}',
                                      subtitle:
                                          'Fixed lane max ${_mixerCenterMax.toStringAsFixed(0)}',
                                      color:
                                          _p.secondary.withValues(alpha: 0.13),
                                    ),
                                  ),
                                )
                              else
                                SliverCrossAxisExpanded(
                                  flex: _mixerCenterFlex,
                                  sliver: SliverList.builder(
                                    itemCount: 14,
                                    itemBuilder: (context, index) => _laneCard(
                                      lane: 'Center',
                                      title: 'Item ${index + 1}',
                                      subtitle: 'Flex lane $_mixerCenterFlex',
                                      color:
                                          _p.secondary.withValues(alpha: 0.13),
                                    ),
                                  ),
                                ),
                              SliverCrossAxisExpanded(
                                flex: _mixerRightFlex,
                                sliver: SliverList.builder(
                                  itemCount: 14,
                                  itemBuilder: (context, index) => _laneCard(
                                    lane: 'Right',
                                    title: 'Item ${index + 1}',
                                    subtitle: 'Flex lane $_mixerRightFlex',
                                    color: _p.tertiary.withValues(alpha: 0.13),
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
              ),
              if (_mixerShowDistribution) ...[
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _card(
                    title: 'Distribution Notes',
                    subtitle: 'How space assignment changes by mode.',
                    tint: _p.primary.withValues(alpha: 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _bullet(
                            'Flex mode: all lanes divide available cross axis by flex ratio.'),
                        _bullet(
                            'Fixed center mode: center lane consumes up to maxExtent first.'),
                        _bullet(
                            'Remaining cross axis is split between side flex lanes.'),
                        _bullet(
                            'Useful for fixed reading lanes with adaptive side tooling.'),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: _p.muted.withValues(alpha: 0.2)),
                          ),
                          child: Text(
                            _mixerUseFixedCenter
                                ? 'Center mode: fixed\nLeft flex: $_mixerLeftFlex\nRight flex: $_mixerRightFlex\nMax center: ${_mixerCenterMax.toStringAsFixed(0)}'
                                : 'Center mode: flex\nLeft flex: $_mixerLeftFlex\nCenter flex: $_mixerCenterFlex\nRight flex: $_mixerRightFlex',
                            style: TextStyle(
                              color: _p.ink,
                              fontSize: 11,
                              fontFamily: 'monospace',
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

  Widget _buildMixedSliverStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Mixed Sliver Types'),
          const SizedBox(height: 8),
          Text(
            'Each lane can host different sliver species. This stage combines '
            'lists, grids, adapters, and optional fixed rails inside one '
            'cross-axis group to showcase heterogeneous composition.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Mixed Controls',
            subtitle: 'Toggle optional sliver features for each lane.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Center flex',
                  value: _mixedCenterFlex.toDouble(),
                  min: 1,
                  max: 4,
                  divisions: 3,
                  color: _p.secondary,
                  onChanged: (v) =>
                      setState(() => _mixedCenterFlex = v.round()),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    _toggleChip(
                      label: 'Include app header lane intro',
                      value: _mixedUseHeader,
                      onChanged: (v) => setState(() => _mixedUseHeader = v),
                    ),
                    _toggleChip(
                      label: 'Center lane uses grid section',
                      value: _mixedUseGrid,
                      onChanged: (v) => setState(() => _mixedUseGrid = v),
                    ),
                    _toggleChip(
                      label: 'Right lane fixed-width rail',
                      value: _mixedUseFixedRail,
                      onChanged: (v) =>
                          setState(() => _mixedUseFixedRail = v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Hybrid Sliver Scene',
            subtitle: 'One group, mixed lane internals.',
            tint: _p.tertiary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
                ),
                child: CustomScrollView(
                  slivers: [
                    if (_mixedUseHeader)
                      SliverToBoxAdapter(
                        child: _laneBanner(
                            'Hybrid lane internals: list + grid + adapter'),
                      ),
                    SliverCrossAxisGroup(
                      slivers: [
                        SliverCrossAxisExpanded(
                          flex: 1,
                          sliver: SliverList.builder(
                            itemCount: 14,
                            itemBuilder: (context, index) => _laneCard(
                              lane: 'Left List',
                              title: 'Task ${index + 1}',
                              subtitle: 'Classic list lane',
                              color: _p.primary.withValues(alpha: 0.12),
                            ),
                          ),
                        ),
                        SliverCrossAxisExpanded(
                          flex: _mixedCenterFlex,
                          sliver: SliverMainAxisGroup(
                            slivers: [
                              SliverToBoxAdapter(
                                child: _laneSubHeader('Center lane intro card'),
                              ),
                              if (_mixedUseGrid)
                                SliverPadding(
                                  padding: const EdgeInsets.all(8),
                                  sliver: SliverGrid(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 72,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) => Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: _p.secondary
                                              .withValues(alpha: 0.14),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'Grid ${index + 1}',
                                          style: TextStyle(
                                            color: _p.ink,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      childCount: 8,
                                    ),
                                  ),
                                ),
                              SliverList.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) => _laneCard(
                                  lane: 'Center List',
                                  title: 'Narrative ${index + 1}',
                                  subtitle:
                                      'Lane combines multiple sliver segment types.',
                                  color: _p.secondary.withValues(alpha: 0.12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_mixedUseFixedRail)
                          SliverConstrainedCrossAxis(
                            maxExtent: 220,
                            sliver: SliverList.builder(
                              itemCount: 12,
                              itemBuilder: (context, index) => _laneCard(
                                lane: 'Fixed Rail',
                                title: 'Signal ${index + 1}',
                                subtitle: 'Constrained width utility lane',
                                color: _p.tertiary.withValues(alpha: 0.14),
                              ),
                            ),
                          )
                        else
                          SliverCrossAxisExpanded(
                            flex: 1,
                            sliver: SliverList.builder(
                              itemCount: 12,
                              itemBuilder: (context, index) => _laneCard(
                                lane: 'Right List',
                                title: 'Signal ${index + 1}',
                                subtitle: 'Flexible side lane',
                                color: _p.tertiary.withValues(alpha: 0.14),
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
          _infoBox(
            'Cross-axis grouping does not force uniform lane internals. Each '
            'lane remains free to use sliver lists, grids, adapters, and groups.',
          ),
        ],
      ),
    );
  }

  Widget _buildGeometryTheaterStage() {
    final longestLane = _geoCenterLong ? 'Center' : 'Right';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Scroll Geometry Theater'),
          const SizedBox(height: 8),
          Text(
            'RenderSliverCrossAxisGroup geometry follows the longest lane '
            'scroll extent. This scene exaggerates lane lengths to make that '
            'behavior visible.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Geometry Controls',
            subtitle: 'Switch which lane is longest and tune lane flexes.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Left flex',
                  value: _geoLeftFlex.toDouble(),
                  min: 1,
                  max: 4,
                  divisions: 3,
                  color: _p.primary,
                  onChanged: (v) => setState(() => _geoLeftFlex = v.round()),
                ),
                _sliderRow(
                  label: 'Center flex',
                  value: _geoCenterFlex.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _geoCenterFlex = v.round()),
                ),
                _sliderRow(
                  label: 'Right flex',
                  value: _geoRightFlex.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  color: _p.tertiary,
                  onChanged: (v) => setState(() => _geoRightFlex = v.round()),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _geoCenterLong,
                      activeColor: _p.secondary,
                      onChanged: (v) => setState(() => _geoCenterLong = v ?? true),
                    ),
                    Text(
                      'Center lane is longest',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _geoShowLongest,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _geoShowLongest = v ?? true),
                    ),
                    Text(
                      'Show longest-lane badge',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    if (_geoShowLongest)
                      _metricChip('Longest lane', longestLane, _p.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Geometry Stage',
            subtitle:
                'Observe how scrollable extent aligns with the lane having greatest length.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
                ),
                child: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: _laneBanner('Longest-lane geometry emphasis'),
                        ),
                        SliverCrossAxisGroup(
                          slivers: [
                            SliverCrossAxisExpanded(
                              flex: _geoLeftFlex,
                              sliver: SliverList.builder(
                                itemCount: 12,
                                itemBuilder: (context, index) => _laneCard(
                                  lane: 'Left',
                                  title: 'Left ${index + 1}',
                                  subtitle: 'Short lane baseline',
                                  color: _p.primary.withValues(alpha: 0.12),
                                ),
                              ),
                            ),
                            SliverCrossAxisExpanded(
                              flex: _geoCenterFlex,
                              sliver: SliverList.builder(
                                itemCount: _geoCenterLong ? 28 : 14,
                                itemBuilder: (context, index) => _laneCard(
                                  lane: 'Center',
                                  title: 'Center ${index + 1}',
                                  subtitle: _geoCenterLong
                                      ? 'Longest lane candidate'
                                      : 'Medium lane',
                                  color: _p.secondary.withValues(alpha: 0.13),
                                ),
                              ),
                            ),
                            SliverCrossAxisExpanded(
                              flex: _geoRightFlex,
                              sliver: SliverList.builder(
                                itemCount: _geoCenterLong ? 18 : 30,
                                itemBuilder: (context, index) => _laneCard(
                                  lane: 'Right',
                                  title: 'Right ${index + 1}',
                                  subtitle: _geoCenterLong
                                      ? 'Medium lane'
                                      : 'Longest lane candidate',
                                  color: _p.tertiary.withValues(alpha: 0.13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (_geoShowLongest)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _p.secondary.withValues(alpha: 0.17),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                                color: _p.secondary.withValues(alpha: 0.4)),
                          ),
                          child: Text(
                            'Longest lane: ${_geoCenterLong ? 'Center' : 'Right'}',
                            style: TextStyle(
                              color: _p.ink,
                              fontSize: 10.5,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Geometry Notes',
            subtitle: 'Operational intuition for grouped sliver scroll behavior.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Group scroll extent tracks the longest child lane.'),
                _bullet('Shorter lanes can visually "end" earlier inside viewport.'),
                _bullet('Cross-axis extent equals overall group cross-axis size.'),
                _bullet('Use fillers/placeholders if lane termination feels abrupt.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatternGalleryStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Pattern Gallery'),
          const SizedBox(height: 8),
          Text(
            'Three practical layouts demonstrate where SliverCrossAxisGroup '
            'shines: editorial pages, board workflows, and analytics consoles.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Pattern Controls',
            subtitle: 'Global viewport and lane weighting.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Pattern viewport width',
                  value: _patternViewportWidth,
                  min: 720,
                  max: 1280,
                  divisions: 28,
                  color: _p.primary,
                  onChanged: (v) => setState(() => _patternViewportWidth = v),
                ),
                _sliderRow(
                  label: 'Left flex',
                  value: _patternLeftFlex.toDouble(),
                  min: 1,
                  max: 3,
                  divisions: 2,
                  color: _p.primary,
                  onChanged: (v) => setState(() => _patternLeftFlex = v.round()),
                ),
                _sliderRow(
                  label: 'Center flex',
                  value: _patternCenterFlex.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  color: _p.secondary,
                  onChanged: (v) =>
                      setState(() => _patternCenterFlex = v.round()),
                ),
                _sliderRow(
                  label: 'Right flex',
                  value: _patternRightFlex.toDouble(),
                  min: 1,
                  max: 3,
                  divisions: 2,
                  color: _p.tertiary,
                  onChanged: (v) =>
                      setState(() => _patternRightFlex = v.round()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _patternCard(
                title: 'Editorial + Side Notes',
                subtitle: 'Center article lane with left nav and right references.',
                child: _patternViewport(
                  mode: 0,
                  height: 300,
                ),
              ),
              _patternCard(
                title: 'Workflow Board',
                subtitle: 'Task lanes represented as grouped sliver columns.',
                child: _patternViewport(
                  mode: 1,
                  height: 300,
                ),
              ),
              _patternCard(
                title: 'Analytics Cockpit',
                subtitle: 'Metrics rail + detailed center + event feed.',
                child: _patternViewport(
                  mode: 2,
                  height: 300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Pattern Selection Tips',
            subtitle: 'Quick strategy cues.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Use grouped lanes when each column needs sliver behavior.'),
                _bullet('For static columns, regular Row/Expanded may be sufficient.'),
                _bullet('Combine with constrained lanes for readability-centric centers.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _patternCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return SizedBox(
      width: 410,
      child: _card(
        title: title,
        subtitle: subtitle,
        tint: _p.primary.withValues(alpha: 0.04),
        child: child,
      ),
    );
  }

  Widget _patternViewport({required int mode, required double height}) {
    final leftFlex = _patternLeftFlex;
    final centerFlex = _patternCenterFlex;
    final rightFlex = _patternRightFlex;

    String leftLabel;
    String centerLabel;
    String rightLabel;

    if (mode == 0) {
      leftLabel = 'Nav';
      centerLabel = 'Article';
      rightLabel = 'Notes';
    } else if (mode == 1) {
      leftLabel = 'Backlog';
      centerLabel = 'In Progress';
      rightLabel = 'Done';
    } else {
      leftLabel = 'KPI';
      centerLabel = 'Details';
      rightLabel = 'Events';
    }

    return SizedBox(
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _laneBanner('$leftLabel | $centerLabel | $rightLabel'),
            ),
            SliverCrossAxisGroup(
              slivers: [
                SliverCrossAxisExpanded(
                  flex: leftFlex,
                  sliver: SliverList.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) => _miniLaneTile(
                      '$leftLabel ${index + 1}',
                      _p.primary.withValues(alpha: 0.12),
                    ),
                  ),
                ),
                SliverCrossAxisExpanded(
                  flex: centerFlex,
                  sliver: SliverList.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => _miniLaneTile(
                      '$centerLabel ${index + 1}',
                      _p.secondary.withValues(alpha: 0.13),
                    ),
                  ),
                ),
                SliverCrossAxisExpanded(
                  flex: rightFlex,
                  sliver: SliverList.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) => _miniLaneTile(
                      '$rightLabel ${index + 1}',
                      _p.tertiary.withValues(alpha: 0.14),
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

  Widget _miniLaneTile(String title, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 4, 6, 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: _p.ink,
          fontSize: 11,
          fontWeight: FontWeight.w700,
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
            title: 'Core Behavior Matrix',
            subtitle: 'How grouped slivers are laid out.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Cross-axis allocation',
                  value:
                      'Zero/null flex lanes are laid out first; remaining width is divided among flex lanes.',
                ),
                _matrixRow(
                  keyText: 'Lane internals',
                  value:
                      'Each lane remains a normal sliver subtree (list, grid, adapters, groups).',
                ),
                _matrixRow(
                  keyText: 'Group geometry',
                  value:
                      'Scroll extent is based on the lane with the largest scroll extent.',
                ),
                _matrixRow(
                  keyText: 'Best use cases',
                  value:
                      'Desktop/tablet multi-lane workflows requiring real sliver behavior per lane.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do / Don\'t',
            subtitle: 'Practical usage rules.',
            child: Column(
              children: [
                _doDontRow(
                  good: true,
                  title: 'Use grouped slivers for lane-specific scroll composition',
                  detail:
                      'Ideal when each lane needs independent sliver capabilities.',
                ),
                _doDontRow(
                  good: false,
                  title: 'Use it for static side-by-side boxes only',
                  detail:
                      'Simple Rows may be lighter when sliver behavior is unnecessary.',
                ),
                _doDontRow(
                  good: true,
                  title: 'Combine fixed and flex lanes intentionally',
                  detail:
                      'Use SliverConstrainedCrossAxis to anchor center rails.',
                ),
                _doDontRow(
                  good: false,
                  title: 'Ignore lane length asymmetry',
                  detail:
                      'Plan for visual endings when one lane is much shorter.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common questions when adopting cross-axis groups.',
            child: Column(
              children: [
                _qa(
                  q: 'Can lanes contain SliverGrid and SliverList together?',
                  a: 'Yes. Use SliverMainAxisGroup in a lane to combine multiple '
                      'sliver types sequentially.',
                ),
                _qa(
                  q: 'How do I make one lane fixed width?',
                  a: 'Wrap that lane with SliverConstrainedCrossAxis and give '
                      'it a maxExtent; keep other lanes flexed.',
                ),
                _qa(
                  q: 'Why does scrolling continue after one lane looks finished?',
                  a: 'Group geometry follows the longest lane scroll extent, so '
                      'shorter lanes may appear to end early.',
                ),
                _qa(
                  q: 'Is this only for large screens?',
                  a: 'Mostly valuable there, but can also support compact '
                      'two-lane patterns on medium viewports.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo requirements satisfied.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Baseline multi-lane dashboard scenario implemented.'),
                _check('Interactive flex mixer with fixed/flex center variations.'),
                _check('Heterogeneous sliver internals demonstrated per lane.'),
                _check('Longest-lane geometry behavior visualized and explained.'),
                _check('Pattern gallery includes three practical layout families.'),
                _check('Guide includes matrix, do/don\'t, FAQ, and checklist.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'RenderSliverCrossAxisGroup is a structural tool for serious '
            'multi-lane sliver interfaces. It preserves sliver power while '
            'unlocking side-by-side cross-axis composition.',
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _p.ink.withValues(alpha: 0.05),
      child: Row(
        children: [
          Text(
            _stageTitles[_stage.index],
            style: TextStyle(
              color: _p.muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            'Palette: ${_p.name}',
            style: TextStyle(color: _p.muted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _laneCard({
    required String lane,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6, 4, 6, 4),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  lane,
                  style: TextStyle(
                    color: _p.ink,
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: _p.ink,
              fontSize: 11.8,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(
              color: _p.muted,
              fontSize: 10.8,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _laneBanner(String text) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _p.primary.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.dashboard_customize_rounded,
              color: _p.primary, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: _p.ink,
              fontSize: 11.2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _laneSubHeader(String text) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 6),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: _p.secondary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: _p.ink,
          fontSize: 11.2,
          fontWeight: FontWeight.w700,
        ),
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
          width: 190,
          child: Text(
            '$label: ${value.toStringAsFixed(0)}',
            style: TextStyle(color: _p.ink, fontSize: 12),
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

  Widget _toggleChip({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return FilterChip(
      selected: value,
      selectedColor: _p.primary.withValues(alpha: 0.16),
      backgroundColor: Colors.white,
      side: BorderSide(color: _p.primary.withValues(alpha: 0.24)),
      onSelected: onChanged,
      label: Text(
        label,
        style: TextStyle(
          color: _p.ink,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
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
          color: _p.ink,
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
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 190,
            child: Text(
              keyText,
              style: TextStyle(
                color: _p.primary,
                fontSize: 11.3,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doDontRow({
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
                    color: _p.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: TextStyle(color: _p.muted, fontSize: 11.3),
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
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q: $q',
            style: TextStyle(
              color: _p.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'A: $a',
            style: TextStyle(color: _p.muted, fontSize: 11.4, height: 1.35),
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
              style: TextStyle(color: _p.ink, fontSize: 12),
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
        color: _p.secondary.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.secondary.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _p.secondary, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _p.ink, fontSize: 12, height: 1.35),
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
            color: _p.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: _p.ink,
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
        color: tint ?? _p.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
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
              color: _p.ink,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(color: _p.muted, fontSize: 11.5),
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
              color: _p.primary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _p.ink, fontSize: 12, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
