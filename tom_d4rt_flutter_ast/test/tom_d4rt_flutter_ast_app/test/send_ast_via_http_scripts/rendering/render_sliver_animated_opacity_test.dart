import 'package:flutter/material.dart';

class _Pal {
  final String name;
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color ink;
  final Color accent;
  final Color muted;

  const _Pal({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.ink,
    required this.accent,
    required this.muted,
  });
}

const _palettes = <_Pal>[
  _Pal(
    name: 'Navy / Apricot',
    primary: Color(0xFF1E3A8A),
    secondary: Color(0xFFFB923C),
    surface: Color(0xFFEEF2FF),
    ink: Color(0xFF1F2937),
    accent: Color(0xFF2563EB),
    muted: Color(0xFF6B7280),
  ),
  _Pal(
    name: 'Burgundy / Mint',
    primary: Color(0xFF7F1D1D),
    secondary: Color(0xFF34D399),
    surface: Color(0xFFFFF1F2),
    ink: Color(0xFF3F2A2D),
    accent: Color(0xFFBE123C),
    muted: Color(0xFF7C6A70),
  ),
  _Pal(
    name: 'Slate / Lime',
    primary: Color(0xFF0F172A),
    secondary: Color(0xFF84CC16),
    surface: Color(0xFFF1F5F9),
    ink: Color(0xFF0F172A),
    accent: Color(0xFF14B8A6),
    muted: Color(0xFF64748B),
  ),
];

enum _SemanticsMode {
  alwaysInclude,
  includeWhenVisible,
}

String _semanticsModeLabel(_SemanticsMode mode) {
  switch (mode) {
    case _SemanticsMode.alwaysInclude:
      return 'alwaysIncludeSemantics: true';
    case _SemanticsMode.includeWhenVisible:
      return 'alwaysIncludeSemantics: false';
  }
}

dynamic build(BuildContext context) {
  return const _SliverFadeTheater();
}

class _SliverFadeTheater extends StatefulWidget {
  const _SliverFadeTheater();

  @override
  State<_SliverFadeTheater> createState() => _SliverFadeTheaterState();
}

class _SliverFadeTheaterState extends State<_SliverFadeTheater> {
  int _scenario = 0;
  int _paletteIndex = 0;
  bool _verbose = false;

  double _stageOpacity = 0.68;
  double _scrollFadeTension = 0.65;
  double _overlayOpacity = 0.45;
  bool _enablePinnedHeader = true;
  bool _showOpacityRuler = true;
  bool _showComparisonLegend = true;

  _SemanticsMode _semanticsMode = _SemanticsMode.includeWhenVisible;

  static const _scenarioTitles = <String>[
    '1 · Core Fade Timeline',
    '2 · Scroll-Reactive Fades',
    '3 · Overlap Choreography',
    '4 · Semantics & Hit Zones',
    '5 · Pattern Gallery',
    '6 · Verification & Guide',
  ];

  _Pal get _p => _palettes[_paletteIndex];

  void _log(String msg) {
    if (_verbose) {
      debugPrint('[SliverFadeTheater] $msg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildControlStrip(),
            Expanded(child: _buildScenarioBody()),
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
              const Icon(Icons.filter_hdr_rounded,
                  size: 28, color: Colors.white),
              const SizedBox(width: 10),
              const Text(
                'Sliver Fade Theater',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'RenderSliverAnimatedOpacity',
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
            'RenderSliverAnimatedOpacity animates opacity for sliver geometry '
            'inside scrollable pipelines. This deep demo explores staged fades, '
            'scroll-reactive transitions, overlap behavior, semantics visibility, '
            'and production patterns for list UX and progressive reveal.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 12.5,
              height: 1.34,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlStrip() {
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
            'Scenario',
            style: TextStyle(
              color: _p.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          for (var i = 0; i < _scenarioTitles.length; i++)
            ChoiceChip(
              selected: _scenario == i,
              label: Text('${i + 1}'),
              onSelected: (_) {
                setState(() => _scenario = i);
                _log('scenario => $_scenario');
              },
              labelStyle: TextStyle(
                color: _scenario == i ? Colors.white : _p.ink,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
              selectedColor: _p.primary,
              backgroundColor: Colors.white,
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
              onTap: () {
                setState(() => _paletteIndex = i);
                _log('palette => $i');
              },
              child: Container(
                width: 23,
                height: 23,
                decoration: BoxDecoration(
                  color: _palettes[i].primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _paletteIndex == i ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Verbose', style: TextStyle(fontSize: 12, color: _p.ink)),
              Switch(
                value: _verbose,
                activeTrackColor: _p.accent,
                onChanged: (v) => setState(() => _verbose = v),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioBody() {
    switch (_scenario) {
      case 0:
        return _scenarioCoreFadeTimeline();
      case 1:
        return _scenarioScrollReactive();
      case 2:
        return _scenarioOverlapChoreography();
      case 3:
        return _scenarioSemanticsAndHitZones();
      case 4:
        return _scenarioPatternGallery();
      case 5:
        return _scenarioVerification();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _scenarioCoreFadeTimeline() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Core Fade Timeline'),
          const SizedBox(height: 8),
          Text(
            'This stage compares a static sliver against SliverAnimatedOpacity. '
            'Move opacity to inspect visual transitions while sliver geometry '
            'and scroll structure remain intact.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Opacity Control',
            subtitle: 'Adjust SliverAnimatedOpacity target opacity.',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _stageOpacity,
                        min: 0,
                        max: 1,
                        divisions: 20,
                        activeColor: _p.primary,
                        label: _stageOpacity.toStringAsFixed(2),
                        onChanged: (v) {
                          setState(() => _stageOpacity = v);
                          _log('stage opacity => $_stageOpacity');
                        },
                      ),
                    ),
                    _metricChip('Opacity', _stageOpacity.toStringAsFixed(2),
                        _p.primary),
                  ],
                ),
                const SizedBox(height: 6),
                if (_showComparisonLegend)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _legendPill('Static Sliver', _p.secondary),
                      _legendPill('Animated Sliver', _p.primary),
                      _legendPill('Current α = ${_stageOpacity.toStringAsFixed(2)}',
                          _p.accent),
                    ],
                  ),
                Row(
                  children: [
                    Checkbox(
                      value: _showComparisonLegend,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _showComparisonLegend = v ?? true),
                    ),
                    Text(
                      'Show comparison legend',
                      style: TextStyle(fontSize: 12, color: _p.ink),
                    ),
                    const SizedBox(width: 16),
                    Checkbox(
                      value: _showOpacityRuler,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _showOpacityRuler = v ?? true),
                    ),
                    Text(
                      'Show opacity ruler',
                      style: TextStyle(fontSize: 12, color: _p.ink),
                    ),
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
                  title: 'Reference Column (Static)',
                  subtitle: 'No animation. Baseline visual behavior.',
                  tint: _p.secondary.withValues(alpha: 0.05),
                  child: _sliverStage(
                    title: 'Static Stage',
                    animatedOpacity: null,
                    color: _p.secondary,
                    showRuler: _showOpacityRuler,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _card(
                  title: 'Animated Column',
                  subtitle: 'SliverAnimatedOpacity drives fade over time.',
                  tint: _p.primary.withValues(alpha: 0.05),
                  child: _sliverStage(
                    title: 'Animated Stage',
                    animatedOpacity: _stageOpacity,
                    color: _p.primary,
                    showRuler: _showOpacityRuler,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _card(
            title: 'What to Observe',
            subtitle: 'Behavior cues while changing opacity.',
            tint: _p.accent.withValues(alpha: 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Sliver remains in scroll pipeline while opacity changes.'),
                _bullet('Transition is animation-driven, not a hard visibility switch.'),
                _bullet('Geometry and sliver ordering are preserved.'),
                _bullet('Use for progressive reveal inside custom scroll sequences.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sliverStage({
    required String title,
    required double? animatedOpacity,
    required Color color,
    required bool showRuler,
  }) {
    return Container(
      width: double.infinity,
      height: 380,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: _p.ink,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _sliverBanner('Header sliver', color),
                    ),
                    if (animatedOpacity == null)
                      SliverToBoxAdapter(
                        child: _fadeCard('Static Block', color,
                            opacityLabel: '1.00', staticMode: true),
                      )
                    else
                      SliverAnimatedOpacity(
                        opacity: animatedOpacity,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        sliver: SliverToBoxAdapter(
                          child: _fadeCard(
                            'Animated Block',
                            color,
                            opacityLabel: animatedOpacity.toStringAsFixed(2),
                            staticMode: false,
                          ),
                        ),
                      ),
                    SliverList.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return _tile(
                          label: 'Row ${index + 1}',
                          color: color.withValues(alpha: 0.12),
                          icon: Icons.view_stream_rounded,
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: _sliverBanner('Footer sliver', color),
                    ),
                  ],
                ),
                if (showRuler)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: _opacityRuler(animatedOpacity ?? 1),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _opacityRuler(double opacity) {
    return Container(
      width: 64,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 84,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: 14,
                  decoration: BoxDecoration(
                    color: _p.muted.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: opacity.clamp(0, 1),
                  child: Container(
                    width: 14,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [_p.primary, _p.secondary],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            opacity.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: _p.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _fadeCard(String title, Color color,
      {required String opacityLabel, required bool staticMode}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.2),
            _p.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(staticMode ? Icons.radio_button_checked : Icons.animation,
              color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$title · alpha $opacityLabel',
              style: TextStyle(
                color: _p.ink,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scenarioScrollReactive() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Scroll-Reactive Fade Sections'),
          const SizedBox(height: 8),
          Text(
            'This scene demonstrates staged opacity values driven by '
            'scroll-progress logic. In production, this can be bound to a '
            'ScrollController to make reveal and de-emphasis transitions feel '
            'natural across sliver sections.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Fade Tension',
            subtitle: 'Higher values keep sections visible longer.',
            child: Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _scrollFadeTension,
                    min: 0.2,
                    max: 1.0,
                    divisions: 16,
                    activeColor: _p.primary,
                    label: _scrollFadeTension.toStringAsFixed(2),
                    onChanged: (v) {
                      setState(() => _scrollFadeTension = v);
                      _log('scrollFadeTension => $_scrollFadeTension');
                    },
                  ),
                ),
                _metricChip('Tension', _scrollFadeTension.toStringAsFixed(2),
                    _p.primary),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Reactive Stage',
            subtitle: 'Multiple sliver sections using different opacity curves.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Container(
              width: double.infinity,
              height: 480,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _p.primary.withValues(alpha: 0.3)),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _sliverBanner('Section 1 · Intro', _p.primary),
                  ),
                  SliverAnimatedOpacity(
                    opacity: (1.0 * _scrollFadeTension).clamp(0, 1),
                    duration: const Duration(milliseconds: 420),
                    curve: Curves.easeOut,
                    sliver: SliverList.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return _tile(
                          label: 'Intro row ${index + 1}',
                          color: _p.primary.withValues(alpha: 0.12),
                          icon: Icons.north,
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _sliverBanner('Section 2 · Mid fade', _p.secondary),
                  ),
                  SliverAnimatedOpacity(
                    opacity: (0.72 * _scrollFadeTension).clamp(0, 1),
                    duration: const Duration(milliseconds: 460),
                    curve: Curves.easeInOut,
                    sliver: SliverList.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return _tile(
                          label: 'Middle row ${index + 1}',
                          color: _p.secondary.withValues(alpha: 0.12),
                          icon: Icons.trending_flat,
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _sliverBanner('Section 3 · Late reveal', _p.accent),
                  ),
                  SliverAnimatedOpacity(
                    opacity: (0.48 * _scrollFadeTension).clamp(0, 1),
                    duration: const Duration(milliseconds: 520),
                    curve: Curves.easeIn,
                    sliver: SliverList.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return _tile(
                          label: 'Late row ${index + 1}',
                          color: _p.accent.withValues(alpha: 0.12),
                          icon: Icons.south,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Curve Strategy',
            subtitle: 'Suggested tuning model for layered sliver fades.',
            tint: _p.secondary.withValues(alpha: 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Early sections often use slower decay (higher alpha).'),
                _bullet('Mid sections can balance context and emphasis.'),
                _bullet('Late sections may start lower to suggest continuation.'),
                _bullet('Mix different durations to avoid synchronized flashing.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scenarioOverlapChoreography() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Overlap Choreography with Pinned Header'),
          const SizedBox(height: 8),
          Text(
            'Fading slivers are often staged under persistent headers. '
            'This scenario explores compositional clarity when overlap and '
            'animated opacity happen together in one scroll pipeline.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Header + Overlay Controls',
            subtitle: 'Tune pinned behavior and overlay fade intensity.',
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _enablePinnedHeader,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _enablePinnedHeader = v ?? true),
                    ),
                    Text(
                      'Enable pinned header',
                      style: TextStyle(fontSize: 12, color: _p.ink),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Slider(
                        value: _overlayOpacity,
                        min: 0,
                        max: 1,
                        divisions: 20,
                        label: _overlayOpacity.toStringAsFixed(2),
                        activeColor: _p.secondary,
                        onChanged: (v) {
                          setState(() => _overlayOpacity = v);
                          _log('overlay opacity => $_overlayOpacity');
                        },
                      ),
                    ),
                    _metricChip('Overlay', _overlayOpacity.toStringAsFixed(2),
                        _p.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Choreography Stage',
            subtitle: 'Pinned sliver header + animated opacity blocks + overlay veil.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _p.primary.withValues(alpha: 0.32)),
              ),
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      if (_enablePinnedHeader)
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _PinnedHeaderDelegate(
                            minExtentValue: 56,
                            maxExtentValue: 88,
                            builder: (context, shrinkOffset, overlapsContent) {
                              final t =
                                  (shrinkOffset / (88 - 56)).clamp(0.0, 1.0);
                              return Container(
                                color: Color.lerp(
                                  _p.primary.withValues(alpha: 0.22),
                                  _p.primary.withValues(alpha: 0.45),
                                  t,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  children: [
                                    Icon(Icons.push_pin,
                                        color: _p.primary.withValues(alpha: 0.9)),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Pinned Navigator',
                                      style: TextStyle(
                                        color: _p.ink,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      overlapsContent ? 'overlap on' : 'overlap off',
                                      style: TextStyle(
                                        color: _p.muted,
                                        fontSize: 11,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      SliverToBoxAdapter(
                        child: _sliverBanner('Scene A', _p.primary),
                      ),
                      SliverAnimatedOpacity(
                        opacity: (1 - _overlayOpacity * 0.4).clamp(0, 1),
                        duration: const Duration(milliseconds: 420),
                        sliver: SliverList.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return _tile(
                              label: 'Scene A row ${index + 1}',
                              color: _p.primary.withValues(alpha: 0.12),
                              icon: Icons.movie_filter,
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: _sliverBanner('Scene B', _p.secondary),
                      ),
                      SliverAnimatedOpacity(
                        opacity: (1 - _overlayOpacity * 0.7).clamp(0, 1),
                        duration: const Duration(milliseconds: 460),
                        sliver: SliverList.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return _tile(
                              label: 'Scene B row ${index + 1}',
                              color: _p.secondary.withValues(alpha: 0.12),
                              icon: Icons.layers,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              _p.surface.withValues(alpha: _overlayOpacity * 0.5),
                              _p.surface.withValues(alpha: _overlayOpacity * 0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'Compositional tip: when opacity transitions and pinned headers '
            'coexist, tune alpha ranges so navigation context remains legible '
            'while content still conveys depth and stage transitions.',
          ),
        ],
      ),
    );
  }

  Widget _scenarioSemanticsAndHitZones() {
    final alwaysInclude = _semanticsMode == _SemanticsMode.alwaysInclude;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Semantics & Hit Zone Checkpoints'),
          const SizedBox(height: 8),
          Text(
            'Animated opacity can make content visually subtle or invisible. '
            'This section demonstrates semantics configuration choices and '
            'interaction clarity during transitions.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Semantics Mode',
            subtitle: 'Switch between alwaysIncludeSemantics true/false.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final mode in _SemanticsMode.values)
                  ChoiceChip(
                    selected: _semanticsMode == mode,
                    onSelected: (_) {
                      setState(() => _semanticsMode = mode);
                      _log('semantics mode => ${_semanticsMode.name}');
                    },
                    label: Text(_semanticsModeLabel(mode)),
                    labelStyle: TextStyle(
                      fontSize: 11,
                      color: _semanticsMode == mode ? Colors.white : _p.ink,
                      fontWeight: FontWeight.w700,
                    ),
                    selectedColor: _p.primary,
                    backgroundColor: Colors.white,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Semantics Simulation Stage',
            subtitle: 'Toggle opacity and read semantic mode indicator.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _stageOpacity,
                        min: 0,
                        max: 1,
                        divisions: 20,
                        activeColor: _p.primary,
                        label: _stageOpacity.toStringAsFixed(2),
                        onChanged: (v) => setState(() => _stageOpacity = v),
                      ),
                    ),
                    _metricChip('Opacity', _stageOpacity.toStringAsFixed(2),
                        _p.primary),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 360,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _p.primary.withValues(alpha: 0.3)),
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: _sliverBanner('Semantics Zone', _p.primary),
                      ),
                      SliverAnimatedOpacity(
                        opacity: _stageOpacity,
                        alwaysIncludeSemantics: alwaysInclude,
                        duration: const Duration(milliseconds: 420),
                        sliver: SliverToBoxAdapter(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _p.primary.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.accessibility_new,
                                        color: _p.primary),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Semantic content panel',
                                      style: TextStyle(
                                        color: _p.ink,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Mode: ${_semanticsModeLabel(_semanticsMode)}\n'
                                  'Visual alpha: ${_stageOpacity.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: _p.ink,
                                      fontSize: 11.5,
                                      height: 1.35),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        child: const Text('Secondary action'),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _p.primary,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {},
                                        child: const Text('Primary action'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverList.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return _tile(
                            label: 'Reference row ${index + 1}',
                            color: _p.secondary.withValues(alpha: 0.12),
                            icon: Icons.checklist,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Interaction Checklist',
            subtitle: 'Ensure UX and accessibility remain coherent.',
            tint: _p.secondary.withValues(alpha: 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('At low opacity, decide if semantics should still be exposed.'),
                _bullet('Prevent confusing invisible-but-clickable controls.'),
                _bullet('Pair opacity transitions with clear state cues.'),
                _bullet('Audit reading order in scroll contexts with fading sections.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scenarioPatternGallery() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Pattern Gallery'),
          const SizedBox(height: 8),
          Text(
            'Three high-value production patterns using SliverAnimatedOpacity: '
            'skeleton-to-content transitions, onboarding staged reveals, and '
            'attention prompts that fade as users progress.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _patternSkeletonToContent(),
          const SizedBox(height: 12),
          _patternOnboardingReveal(),
          const SizedBox(height: 12),
          _patternAnnouncementFade(),
          const SizedBox(height: 12),
          _card(
            title: 'Pattern Summary',
            subtitle: 'When this render object provides real UX value.',
            tint: _p.accent.withValues(alpha: 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Fading sliver blocks reduces abrupt context shifts.'),
                _bullet('Keep list rhythm while transitioning content states.'),
                _bullet('Use durations that match perceived scroll velocity.'),
                _bullet('Coordinate with pinned headers and semantics modes.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _patternSkeletonToContent() {
    final loadingOpacity = (1 - _stageOpacity).clamp(0.0, 1.0);
    final contentOpacity = _stageOpacity.clamp(0.0, 1.0);
    return _card(
      title: 'Pattern 1 · Skeleton to Content',
      subtitle: 'Two slivers cross-fade between loading and real rows.',
      tint: _p.primary.withValues(alpha: 0.04),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _stageOpacity,
                  min: 0,
                  max: 1,
                  divisions: 20,
                  activeColor: _p.primary,
                  onChanged: (v) => setState(() => _stageOpacity = v),
                ),
              ),
              const SizedBox(width: 8),
              _metricChip('Load→Content', _stageOpacity.toStringAsFixed(2),
                  _p.primary),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 260,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _p.primary.withValues(alpha: 0.3)),
            ),
            child: CustomScrollView(
              slivers: [
                SliverAnimatedOpacity(
                  opacity: loadingOpacity,
                  duration: const Duration(milliseconds: 380),
                  sliver: SliverList.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                        height: 52,
                        decoration: BoxDecoration(
                          color: _p.muted.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    },
                  ),
                ),
                SliverAnimatedOpacity(
                  opacity: contentOpacity,
                  duration: const Duration(milliseconds: 420),
                  sliver: SliverList.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return _tile(
                        label: 'Loaded row ${index + 1}',
                        color: _p.primary.withValues(alpha: 0.14),
                        icon: Icons.done_outline,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _patternOnboardingReveal() {
    return _card(
      title: 'Pattern 2 · Onboarding Staged Reveal',
      subtitle: 'Section opacities increase in sequence to guide attention.',
      tint: _p.secondary.withValues(alpha: 0.04),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _p.secondary.withValues(alpha: 0.3)),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAnimatedOpacity(
              opacity: (_stageOpacity * 1.0).clamp(0, 1),
              duration: const Duration(milliseconds: 350),
              sliver: SliverToBoxAdapter(
                child: _guidedBlock('Step 1 · Overview', _p.primary,
                    Icons.looks_one_rounded),
              ),
            ),
            SliverAnimatedOpacity(
              opacity: ((_stageOpacity - 0.2) * 1.25).clamp(0, 1),
              duration: const Duration(milliseconds: 400),
              sliver: SliverToBoxAdapter(
                child: _guidedBlock('Step 2 · Configure', _p.secondary,
                    Icons.looks_two_rounded),
              ),
            ),
            SliverAnimatedOpacity(
              opacity: ((_stageOpacity - 0.4) * 1.7).clamp(0, 1),
              duration: const Duration(milliseconds: 470),
              sliver: SliverToBoxAdapter(
                child: _guidedBlock('Step 3 · Launch', _p.accent,
                    Icons.looks_3_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _guidedBlock(String title, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: _p.ink,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _patternAnnouncementFade() {
    return _card(
      title: 'Pattern 3 · Dismissive Announcement Fade',
      subtitle: 'Top announcement sliver fades as interaction progresses.',
      tint: _p.accent.withValues(alpha: 0.04),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _overlayOpacity,
                  min: 0,
                  max: 1,
                  divisions: 20,
                  activeColor: _p.accent,
                  onChanged: (v) => setState(() => _overlayOpacity = v),
                ),
              ),
              const SizedBox(width: 8),
              _metricChip('Dismiss', _overlayOpacity.toStringAsFixed(2),
                  _p.accent),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _p.accent.withValues(alpha: 0.3)),
            ),
            child: CustomScrollView(
              slivers: [
                SliverAnimatedOpacity(
                  opacity: (1 - _overlayOpacity).clamp(0, 1),
                  duration: const Duration(milliseconds: 360),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _p.accent.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.campaign, color: _p.accent),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Announcement banner fades out when acknowledged.',
                              style: TextStyle(
                                color: _p.ink,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return _tile(
                      label: 'Content row ${index + 1}',
                      color: _p.secondary.withValues(alpha: 0.12),
                      icon: Icons.format_list_bulleted,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scenarioVerification() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification & Guide'),
          const SizedBox(height: 12),
          _card(
            title: 'API Matrix',
            subtitle: 'Main properties and effect on sliver behavior.',
            child: Column(
              children: [
                _apiRow(
                  prop: 'opacity',
                  type: 'double',
                  meaning: 'Target alpha of the sliver child during animation.',
                ),
                _apiRow(
                  prop: 'duration',
                  type: 'Duration',
                  meaning: 'Fade transition length.',
                ),
                _apiRow(
                  prop: 'curve',
                  type: 'Curve',
                  meaning: 'Animation pacing profile.',
                ),
                _apiRow(
                  prop: 'alwaysIncludeSemantics',
                  type: 'bool',
                  meaning:
                      'Controls semantics inclusion regardless of visual opacity.',
                ),
                _apiRow(
                  prop: 'sliver',
                  type: 'Widget',
                  meaning: 'The sliver content whose opacity is animated.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do / Don\'t Matrix',
            subtitle: 'Practical guardrails for production lists.',
            child: Column(
              children: [
                _decisionRow(
                  use: 'Progressive reveal of informational slivers',
                  decision: 'Do',
                  reason: 'Smooth transition preserves reading context.',
                  good: true,
                ),
                _decisionRow(
                  use: 'Hide critical actions only via opacity',
                  decision: 'Don\'t',
                  reason: 'Can cause discoverability and semantics confusion.',
                  good: false,
                ),
                _decisionRow(
                  use: 'Cross-fade loading blocks to real content',
                  decision: 'Do',
                  reason: 'Maintains sliver flow with reduced visual jump.',
                  good: true,
                ),
                _decisionRow(
                  use: 'Use many independent fades with long durations',
                  decision: 'Don\'t',
                  reason: 'Can feel sluggish and noisy while scrolling.',
                  good: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Answers to common implementation questions.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _qa(
                  q: 'How is this different from wrapping a box widget in AnimatedOpacity?',
                  a: 'SliverAnimatedOpacity operates natively in the sliver '
                      'layout pipeline, preserving sliver composition and '
                      'scroll geometry expectations.',
                ),
                _qa(
                  q: 'Does opacity animation remove the sliver from layout?',
                  a: 'No, not by itself. Opacity changes paint output. Use '
                      'additional visibility logic if layout removal is needed.',
                ),
                _qa(
                  q: 'When should alwaysIncludeSemantics be true?',
                  a: 'Use true when semantic presence must remain stable '
                      'despite visual fading, such as assistive workflows.',
                ),
                _qa(
                  q: 'Can this be scroll-driven?',
                  a: 'Yes. Bind opacity values to scroll progress (directly or '
                      'via notifiers) for narrative-style sliver transitions.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Checklist',
            subtitle: 'Coverage points validated by this deep demo.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Core static vs animated sliver comparison shown.'),
                _check('Scroll-reactive staged fades demonstrated.'),
                _check('Pinned header and overlap choreography covered.'),
                _check('Semantics and hit-zone guidance included.'),
                _check('Three production patterns with visuals implemented.'),
                _check('API matrix and do/don\'t guidance provided.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'Summary: RenderSliverAnimatedOpacity is ideal for nuanced '
            'transitions in sliver-based interfaces where content should '
            'gradually emerge or de-emphasize without collapsing scroll '
            'structure.',
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
            _scenarioTitles[_scenario],
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
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: _p.ink,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
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
        color: tint ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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

  Widget _sliverBanner(String text, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.view_day, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: _p.ink,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile({
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: _p.ink),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: _p.ink),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: _p.ink,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  Widget _legendPill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: _p.ink,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _apiRow({
    required String prop,
    required String type,
    required String meaning,
  }) {
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
            width: 150,
            child: Text(
              prop,
              style: TextStyle(
                color: _p.primary,
                fontSize: 11.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 130,
            child: Text(
              type,
              style: TextStyle(
                color: _p.ink,
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              meaning,
              style: TextStyle(color: _p.muted, fontSize: 11.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _decisionRow({
    required String use,
    required String decision,
    required String reason,
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
          Icon(good ? Icons.check_circle : Icons.cancel, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  use,
                  style: TextStyle(
                    color: _p.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  decision,
                  style: TextStyle(
                    color: color,
                    fontSize: 11.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  reason,
                  style: TextStyle(color: _p.muted, fontSize: 11.4),
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
            style: TextStyle(color: _p.muted, fontSize: 11.5, height: 1.35),
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
        color: _p.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.secondary.withValues(alpha: 0.26)),
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

class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minExtentValue;
  final double maxExtentValue;
  final Widget Function(BuildContext, double, bool) builder;

  const _PinnedHeaderDelegate({
    required this.minExtentValue,
    required this.maxExtentValue,
    required this.builder,
  });

  @override
  double get minExtent => minExtentValue;

  @override
  double get maxExtent => maxExtentValue;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  bool shouldRebuild(covariant _PinnedHeaderDelegate oldDelegate) {
    return oldDelegate.minExtentValue != minExtentValue ||
        oldDelegate.maxExtentValue != maxExtentValue ||
        oldDelegate.builder != builder;
  }
}
