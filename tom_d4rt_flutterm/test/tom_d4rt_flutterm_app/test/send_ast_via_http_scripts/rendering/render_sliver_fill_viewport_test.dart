import 'package:flutter/material.dart';

class _Palette {
  final String name;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color ink;
  final Color muted;

  const _Palette({
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

const _palettes = <_Palette>[
  _Palette(
    name: 'Cobalt Canyon',
    primary: Color(0xFF1D4ED8),
    secondary: Color(0xFFEA580C),
    accent: Color(0xFF14B8A6),
    background: Color(0xFFF4F8FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1F2937),
    muted: Color(0xFF64748B),
  ),
  _Palette(
    name: 'Forest Studio',
    primary: Color(0xFF0F766E),
    secondary: Color(0xFFBE123C),
    accent: Color(0xFF2563EB),
    background: Color(0xFFF2FBF8),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF19302D),
    muted: Color(0xFF5C6E68),
  ),
  _Palette(
    name: 'Graphite Citrus',
    primary: Color(0xFF111827),
    secondary: Color(0xFF65A30D),
    accent: Color(0xFF0EA5E9),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF111827),
    muted: Color(0xFF6B7280),
  ),
];

enum _StudioStage {
  fractionGallery,
  edgeLab,
  storyboard,
  axisArena,
  kioskShowcase,
  verificationDeck,
}

enum _AxisMode {
  vertical,
  horizontal,
}

class _ShellSpec {
  final String label;
  final double height;
  final double fraction;
  final bool padEnds;

  const _ShellSpec({
    required this.label,
    required this.height,
    required this.fraction,
    required this.padEnds,
  });
}

const _kioskSpecs = <_ShellSpec>[
  _ShellSpec(label: 'Pocket', height: 430, fraction: 0.84, padEnds: true),
  _ShellSpec(label: 'Default', height: 560, fraction: 0.92, padEnds: true),
  _ShellSpec(label: 'Poster', height: 700, fraction: 1.0, padEnds: false),
];

dynamic build(BuildContext context) {
  return const _FillViewportObservatory();
}

class _FillViewportObservatory extends StatefulWidget {
  const _FillViewportObservatory();

  @override
  State<_FillViewportObservatory> createState() =>
      _FillViewportObservatoryState();
}

class _FillViewportObservatoryState extends State<_FillViewportObservatory> {
  _StudioStage _stage = _StudioStage.fractionGallery;
  int _paletteIndex = 0;
  bool _verbose = false;

  double _galleryFraction = 0.88;
  double _galleryItems = 8;
  bool _galleryPadEnds = true;
  bool _galleryShowRail = true;

  double _edgeFractionLeft = 0.80;
  double _edgeFractionRight = 1.00;
  bool _edgeLeftPad = true;
  bool _edgeRightPad = false;
  double _edgeItems = 5;

  double _storyLeadCount = 2;
  double _storyFraction = 0.92;
  bool _storyPadEnds = true;
  bool _storyShowFooter = true;

  _AxisMode _axisMode = _AxisMode.vertical;
  double _axisFraction = 0.9;
  bool _axisPadEnds = true;
  double _axisItems = 6;
  bool _axisShowLegend = true;

  bool _kioskTriView = true;
  double _kioskCustomHeight = 620;
  double _kioskCustomFraction = 0.9;
  bool _kioskCustomPad = true;
  double _kioskLeadCount = 1;

  static const _stageLabels = <String>[
    '1 Fraction Gallery',
    '2 Pad-Ends Edge Lab',
    '3 Storyboard Integration',
    '4 Axis Arena',
    '5 Device Kiosk Showcase',
    '6 Verification Deck',
  ];

  _Palette get _p => _palettes[_paletteIndex];

  void _trace(String text) {
    if (_verbose) {
      debugPrint('[RenderSliverFillViewportDemo] $text');
    }
  }

  Axis get _axis => _axisMode == _AxisMode.vertical ? Axis.vertical : Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.background,
      body: SafeArea(
        child: Column(
          children: [
            _heroHeader(),
            _controlRibbon(),
            Expanded(child: _stageContent()),
            _bottomNote(),
          ],
        ),
      ),
    );
  }

  Widget _heroHeader() {
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
              const Icon(Icons.view_carousel_rounded,
                  color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'RenderSliverFillViewport Observatory',
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
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'SliverFillViewport Behavior Demo',
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
            'RenderSliverFillViewport gives each sliver child a viewport-based '
            'extent using viewportFraction. This studio demonstrates page-sized '
            'layouts, edge padding behavior, axis variation, and composition '
            'patterns for production interfaces.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.93),
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _controlRibbon() {
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
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          for (var i = 0; i < _stageLabels.length; i++)
            ChoiceChip(
              selected: _stage.index == i,
              selectedColor: _p.primary,
              backgroundColor: Colors.white,
              label: Text('${i + 1}'),
              labelStyle: TextStyle(
                color: _stage.index == i ? Colors.white : _p.ink,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
              onSelected: (_) {
                setState(() => _stage = _StudioStage.values[i]);
                _trace('stage => ${_stage.name}');
              },
            ),
          const SizedBox(width: 10),
          Text(
            'Palette',
            style: TextStyle(
              color: _p.ink,
              fontWeight: FontWeight.w700,
              fontSize: 12,
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
          const SizedBox(width: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Verbose', style: TextStyle(color: _p.ink, fontSize: 12)),
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

  Widget _stageContent() {
    switch (_stage) {
      case _StudioStage.fractionGallery:
        return _fractionGallery();
      case _StudioStage.edgeLab:
        return _edgeLab();
      case _StudioStage.storyboard:
        return _storyboardStage();
      case _StudioStage.axisArena:
        return _axisArena();
      case _StudioStage.kioskShowcase:
        return _kioskShowcase();
      case _StudioStage.verificationDeck:
        return _verificationDeck();
    }
  }

  Widget _fractionGallery() {
    final items = _galleryItems.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Fraction Gallery'),
          const SizedBox(height: 8),
          Text(
            'Viewport fraction is the primary control of SliverFillViewport. '
            'Lower values reveal neighboring cards, while larger values create '
            'single-focus page experiences.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Gallery Controls',
            subtitle: 'Tune fraction, child count, and edge strategy.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'viewportFraction',
                  value: _galleryFraction,
                  min: 0.6,
                  max: 1.2,
                  divisions: 12,
                  color: _p.primary,
                  display: _galleryFraction.toStringAsFixed(2),
                  onChanged: (v) => setState(() => _galleryFraction = v),
                ),
                _sliderRow(
                  label: 'cards',
                  value: _galleryItems,
                  min: 3,
                  max: 12,
                  divisions: 9,
                  color: _p.secondary,
                  display: '$items',
                  onChanged: (v) => setState(() => _galleryItems = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _galleryPadEnds,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _galleryPadEnds = v ?? true),
                    ),
                    Text(
                      'padEnds true',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _galleryShowRail,
                      activeColor: _p.secondary,
                      onChanged: (v) =>
                          setState(() => _galleryShowRail = v ?? true),
                    ),
                    Text(
                      'show reading rail',
                      style: TextStyle(color: _p.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _chip('fraction', _galleryFraction.toStringAsFixed(2), _p.primary),
                    const SizedBox(width: 6),
                    _chip('cards', '$items', _p.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Gallery Viewport',
            subtitle: 'A pure SliverFillViewport lane for page-sized cards.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
                ),
                child: Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _banner(
                            icon: Icons.fit_screen_rounded,
                            text: 'Each child extent is derived from viewportFraction.',
                          ),
                        ),
                        SliverFillViewport(
                          viewportFraction: _galleryFraction,
                          padEnds: _galleryPadEnds,
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => _galleryCard(index),
                            childCount: items,
                          ),
                        ),
                      ],
                    ),
                    if (_galleryShowRail)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _chip(
                          'padEnds',
                          _galleryPadEnds ? 'true' : 'false',
                          _p.secondary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'Try 0.70 to expose neighboring cards, then 1.10 for focus-first '
            'slides. This is the core “viewport-sized card rail” pattern.',
          ),
        ],
      ),
    );
  }

  Widget _edgeLab() {
    final count = _edgeItems.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Pad-Ends Edge Lab'),
          const SizedBox(height: 8),
          Text(
            'This lab compares two FillViewport lanes side-by-side to make '
            'edge treatment obvious. padEnds influences how first/last items '
            'align relative to viewport boundaries.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Edge Controls',
            subtitle: 'Tune each lane independently.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Left fraction',
                  value: _edgeFractionLeft,
                  min: 0.6,
                  max: 1.1,
                  divisions: 10,
                  color: _p.primary,
                  display: _edgeFractionLeft.toStringAsFixed(2),
                  onChanged: (v) => setState(() => _edgeFractionLeft = v),
                ),
                _sliderRow(
                  label: 'Right fraction',
                  value: _edgeFractionRight,
                  min: 0.6,
                  max: 1.1,
                  divisions: 10,
                  color: _p.secondary,
                  display: _edgeFractionRight.toStringAsFixed(2),
                  onChanged: (v) => setState(() => _edgeFractionRight = v),
                ),
                _sliderRow(
                  label: 'Cards per lane',
                  value: _edgeItems,
                  min: 3,
                  max: 10,
                  divisions: 7,
                  color: _p.accent,
                  display: '$count',
                  onChanged: (v) => setState(() => _edgeItems = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _edgeLeftPad,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _edgeLeftPad = v ?? true),
                    ),
                    Text('Left padEnds',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 14),
                    Checkbox(
                      value: _edgeRightPad,
                      activeColor: _p.secondary,
                      onChanged: (v) =>
                          setState(() => _edgeRightPad = v ?? false),
                    ),
                    Text('Right padEnds',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _edgeLaneCard(
                  title: 'Lane A',
                  fraction: _edgeFractionLeft,
                  padEnds: _edgeLeftPad,
                  count: count,
                  color: _p.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _edgeLaneCard(
                  title: 'Lane B',
                  fraction: _edgeFractionRight,
                  padEnds: _edgeRightPad,
                  count: count,
                  color: _p.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Interpretation',
            subtitle: 'Read this while comparing both lanes.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('padEnds true typically provides balanced edge breathing room.'),
                _bullet('padEnds false can start content flush with the viewport edge.'),
                _bullet('Combined with fraction < 1.0 this drives “peek” carousel styles.'),
                _bullet('Use consistent edge policy across app sections for visual rhythm.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _edgeLaneCard({
    required String title,
    required double fraction,
    required bool padEnds,
    required int count,
    required Color color,
  }) {
    return _panel(
      title: '$title preview',
      subtitle: 'fraction ${fraction.toStringAsFixed(2)} | padEnds $padEnds',
      tint: color.withValues(alpha: 0.05),
      child: SizedBox(
        height: 520,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _banner(
                  icon: Icons.compare_arrows_rounded,
                  text: '$title edge behavior lane',
                ),
              ),
              SliverFillViewport(
                viewportFraction: fraction,
                padEnds: padEnds,
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _edgeCard(index, color),
                  childCount: count,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _storyboardStage() {
    final lead = _storyLeadCount.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Storyboard Integration'),
          const SizedBox(height: 8),
          Text(
            'This stage demonstrates SliverFillViewport as one section inside '
            'a larger sliver narrative: lead context, viewport pages, then '
            'optional trailing summary.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Storyboard Controls',
            subtitle: 'Tune integration context.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Lead cards',
                  value: _storyLeadCount,
                  min: 0,
                  max: 5,
                  divisions: 5,
                  color: _p.primary,
                  display: '$lead',
                  onChanged: (v) => setState(() => _storyLeadCount = v),
                ),
                _sliderRow(
                  label: 'Viewport fraction',
                  value: _storyFraction,
                  min: 0.7,
                  max: 1.1,
                  divisions: 8,
                  color: _p.secondary,
                  display: _storyFraction.toStringAsFixed(2),
                  onChanged: (v) => setState(() => _storyFraction = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _storyPadEnds,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _storyPadEnds = v ?? true),
                    ),
                    Text('padEnds', style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 14),
                    Checkbox(
                      value: _storyShowFooter,
                      activeColor: _p.secondary,
                      onChanged: (v) =>
                          setState(() => _storyShowFooter = v ?? true),
                    ),
                    Text('show trailing footer',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('lead', '$lead', _p.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Narrative Scroll',
            subtitle: 'Lead section -> FillViewport pages -> Footer section.',
            tint: _p.secondary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 600,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
                ),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: _banner(
                        icon: Icons.auto_stories_rounded,
                        text: 'Lead section sets context before viewport pages.',
                      ),
                    ),
                    SliverList.builder(
                      itemCount: lead,
                      itemBuilder: (context, index) => _storyLead(index),
                    ),
                    SliverFillViewport(
                      viewportFraction: _storyFraction,
                      padEnds: _storyPadEnds,
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _storyPage(index),
                        childCount: 6,
                      ),
                    ),
                    if (_storyShowFooter)
                      SliverToBoxAdapter(
                        child: _storyFooter(),
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

  Widget _axisArena() {
    final count = _axisItems.round();
    final horizontal = _axis == Axis.horizontal;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Axis Arena'),
          const SizedBox(height: 8),
          Text(
            'RenderSliverFillViewport works in both directions. Horizontal '
            'mode creates track-like carousels; vertical mode resembles full '
            'height chapters. Compare both interaction signatures here.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Axis Controls',
            subtitle: 'Switch direction and tuning options.',
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _choice('Vertical', _axisMode == _AxisMode.vertical, () {
                      setState(() => _axisMode = _AxisMode.vertical);
                    }),
                    _choice('Horizontal', _axisMode == _AxisMode.horizontal, () {
                      setState(() => _axisMode = _AxisMode.horizontal);
                    }),
                  ],
                ),
                _sliderRow(
                  label: 'viewportFraction',
                  value: _axisFraction,
                  min: 0.6,
                  max: 1.2,
                  divisions: 12,
                  color: _p.primary,
                  display: _axisFraction.toStringAsFixed(2),
                  onChanged: (v) => setState(() => _axisFraction = v),
                ),
                _sliderRow(
                  label: 'item count',
                  value: _axisItems,
                  min: 3,
                  max: 10,
                  divisions: 7,
                  color: _p.secondary,
                  display: '$count',
                  onChanged: (v) => setState(() => _axisItems = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _axisPadEnds,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _axisPadEnds = v ?? true),
                    ),
                    Text('padEnds', style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _axisShowLegend,
                      activeColor: _p.secondary,
                      onChanged: (v) =>
                          setState(() => _axisShowLegend = v ?? true),
                    ),
                    Text('show legend', style: TextStyle(color: _p.ink, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: horizontal ? 'Horizontal FillViewport' : 'Vertical FillViewport',
            subtitle: horizontal
                ? 'Scroll left/right through viewport-sized cards.'
                : 'Scroll up/down through chapter-sized cards.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: horizontal ? 360 : 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
                ),
                child: Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: _axis,
                      slivers: [
                        if (!horizontal)
                          SliverToBoxAdapter(
                            child: _banner(
                              icon: Icons.swap_vert_rounded,
                              text: 'Vertical arena',
                            ),
                          ),
                        SliverFillViewport(
                          viewportFraction: _axisFraction,
                          padEnds: _axisPadEnds,
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => _axisCard(index, horizontal),
                            childCount: count,
                          ),
                        ),
                      ],
                    ),
                    if (_axisShowLegend)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _chip(
                          'axis',
                          horizontal ? 'horizontal' : 'vertical',
                          _p.secondary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Axis Guidance',
            subtitle: 'How to choose direction.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Use horizontal for media rails and gallery strips.'),
                _bullet('Use vertical for chaptered storytelling and guide flows.'),
                _bullet('Fraction under 1.0 is a useful cue that more content exists.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kioskShowcase() {
    final lead = _kioskLeadCount.round();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Device Kiosk Showcase'),
          const SizedBox(height: 8),
          Text(
            'Different shell heights and fractions change perceived rhythm. '
            'This stage presents presets and a custom shell for responsive '
            'validation of page-style sliver sections.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Kiosk Controls',
            subtitle: 'Preset trio or one custom shell.',
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _kioskTriView,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _kioskTriView = v ?? true),
                    ),
                    Text('show preset trio',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('lead', '$lead', _p.primary),
                  ],
                ),
                _sliderRow(
                  label: 'custom shell height',
                  value: _kioskCustomHeight,
                  min: 420,
                  max: 760,
                  divisions: 17,
                  color: _p.primary,
                  display: _kioskCustomHeight.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _kioskCustomHeight = v),
                ),
                _sliderRow(
                  label: 'custom fraction',
                  value: _kioskCustomFraction,
                  min: 0.65,
                  max: 1.15,
                  divisions: 10,
                  color: _p.secondary,
                  display: _kioskCustomFraction.toStringAsFixed(2),
                  onChanged: (v) => setState(() => _kioskCustomFraction = v),
                ),
                _sliderRow(
                  label: 'lead cards',
                  value: _kioskLeadCount,
                  min: 0,
                  max: 4,
                  divisions: 4,
                  color: _p.accent,
                  display: '$lead',
                  onChanged: (v) => setState(() => _kioskLeadCount = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _kioskCustomPad,
                      activeColor: _p.secondary,
                      onChanged: (v) =>
                          setState(() => _kioskCustomPad = v ?? true),
                    ),
                    Text('custom padEnds',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_kioskTriView)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final spec in _kioskSpecs)
                  _shellCard(spec: spec, leadCount: lead),
              ],
            )
          else
            _shellCard(
              spec: _ShellSpec(
                label: 'Custom',
                height: _kioskCustomHeight,
                fraction: _kioskCustomFraction,
                padEnds: _kioskCustomPad,
              ),
              leadCount: lead,
            ),
          const SizedBox(height: 12),
          _panel(
            title: 'Showcase Insights',
            subtitle: 'Practical responsive notes.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Compact shells emphasize paging transitions quickly.'),
                _bullet('Taller shells reveal more interior card composition detail.'),
                _bullet('Fractions close to 1.0 feel editorial; low fractions feel exploratory.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shellCard({required _ShellSpec spec, required int leadCount}) {
    return SizedBox(
      width: 400,
      child: _panel(
        title: '${spec.label} shell',
        subtitle:
            'height ${spec.height.toStringAsFixed(0)} | fraction ${spec.fraction.toStringAsFixed(2)} | padEnds ${spec.padEnds}',
        tint: _p.primary.withValues(alpha: 0.04),
        child: SizedBox(
          height: spec.height,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
            ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _banner(
                    icon: Icons.devices_rounded,
                    text: '${spec.label} responsive profile',
                  ),
                ),
                SliverList.builder(
                  itemCount: leadCount,
                  itemBuilder: (context, index) => _leadChipCard(
                    title: '${spec.label} lead ${index + 1}',
                    subtitle: 'Context sliver before viewport section',
                    color: _p.primary.withValues(alpha: 0.12),
                  ),
                ),
                SliverFillViewport(
                  viewportFraction: spec.fraction,
                  padEnds: spec.padEnds,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _kioskPage(index, spec.label),
                    childCount: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _verificationDeck() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification Deck'),
          const SizedBox(height: 12),
          _panel(
            title: 'RenderSliverFillViewport Matrix',
            subtitle: 'Behavior and usage summary.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Primary role',
                  value:
                      'Size each child as a viewport-relative page inside a sliver list pipeline.',
                ),
                _matrixRow(
                  keyText: 'Main control',
                  value:
                      'viewportFraction: defines per-child fraction of viewport extent.',
                ),
                _matrixRow(
                  keyText: 'Edge behavior',
                  value:
                      'padEnds controls edge spacing treatment for first and last child.',
                ),
                _matrixRow(
                  keyText: 'Direction support',
                  value:
                      'Works across vertical and horizontal sliver scroll directions.',
                ),
                _matrixRow(
                  keyText: 'Best suited for',
                  value:
                      'Carousels, chapter rails, onboarding panels, media strips, and page cards.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont Guide',
            subtitle: 'Operational recommendations.',
            child: Column(
              children: [
                _doDont(
                  good: true,
                  title: 'Use for viewport-scaled page sections',
                  detail:
                      'The render class is ideal when each child should feel like a page or card panel.',
                ),
                _doDont(
                  good: false,
                  title: 'Use for tiny list rows',
                  detail:
                      'Regular SliverList/SliverFixedExtentList is usually better for compact row lists.',
                ),
                _doDont(
                  good: true,
                  title: 'Tune fraction for intent',
                  detail:
                      'Use near 1.0 for immersive chapters; lower values for peeking carousels.',
                ),
                _doDont(
                  good: false,
                  title: 'Ignore edge consistency',
                  detail:
                      'Inconsistent padEnds choices across screens can feel visually unstable.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common implementation questions.',
            child: Column(
              children: [
                _qa(
                  q: 'How is this different from PageView?',
                  a: 'SliverFillViewport participates in CustomScrollView sliver '
                      'composition, making it easy to combine with other slivers.',
                ),
                _qa(
                  q: 'When should I set viewportFraction below 1.0?',
                  a: 'When you want users to perceive neighboring content and '
                      'understand additional pages exist.',
                ),
                _qa(
                  q: 'Should padEnds always be true?',
                  a: 'No. padEnds depends on the desired edge rhythm and '
                      'alignment with surrounding sections.',
                ),
                _qa(
                  q: 'Can this be horizontal?',
                  a: 'Yes. In horizontal scrollDirection it becomes a strong '
                      'foundation for media rails and kiosks.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo completeness criteria.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Fraction gallery demonstrates viewportFraction tuning.'),
                _check('Edge lab compares padEnds behavior side-by-side.'),
                _check('Storyboard integration shows composition with other slivers.'),
                _check('Axis arena demonstrates vertical and horizontal usage.'),
                _check('Kiosk showcase validates responsive shell profiles.'),
                _check('Guide includes matrix, do/dont, FAQ, and checklist.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'RenderSliverFillViewport is your sliver-level page sizing tool. '
            'Use it to create expressive, viewport-aware lanes that stay fully '
            'composable with other sliver building blocks.',
          ),
        ],
      ),
    );
  }

  Widget _galleryCard(int index) {
    final isEven = index.isEven;
    final base = isEven ? _p.primary : _p.secondary;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            base.withValues(alpha: 0.82),
            _p.accent.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.23),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Card ${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.open_in_full_rounded,
                    color: Colors.white, size: 18),
              ],
            ),
            const Spacer(),
            const Text(
              'Viewport page tile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'This tile uses SliverFillViewport sizing. Adjust fraction to '
              'change how much of each page is visible in the viewport.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _edgeCard(int index, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edge Card ${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 19,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Inspect start/end alignment',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _storyLead(int index) {
    return _leadChipCard(
      title: 'Lead scene ${index + 1}',
      subtitle: 'Narrative setup before viewport chapter rails',
      color: _p.primary.withValues(alpha: 0.13),
    );
  }

  Widget _storyPage(int index) {
    final tone = index.isEven ? _p.primary : _p.secondary;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.collections_bookmark_rounded,
                    color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Chapter ${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Text(
              'Viewport Story Card',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Rendered in SliverFillViewport to preserve page-scale visual rhythm inside CustomScrollView.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.93),
                fontSize: 12,
                height: 1.34,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _storyFooter() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _p.accent.withValues(alpha: 0.17),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.accent.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trailing summary',
            style: TextStyle(
              color: _p.ink,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'A regular sliver after FillViewport keeps narrative flexibility '
            'for CTAs, summaries, or related modules.',
            style: TextStyle(color: _p.muted, fontSize: 11.4, height: 1.34),
          ),
        ],
      ),
    );
  }

  Widget _axisCard(int index, bool horizontal) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            (index.isEven ? _p.primary : _p.secondary).withValues(alpha: 0.85),
            _p.accent.withValues(alpha: 0.82),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                horizontal ? Icons.swap_horiz_rounded : Icons.swap_vert_rounded,
                color: Colors.white,
                size: 26,
              ),
              const SizedBox(height: 8),
              Text(
                horizontal
                    ? 'Horizontal page ${index + 1}'
                    : 'Vertical page ${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                horizontal
                    ? 'Viewport-width aware card panel.'
                    : 'Viewport-height aware chapter panel.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kioskPage(int index, String label) {
    final color = index.isEven ? _p.primary : _p.secondary;
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label Page ${index + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Viewport-fractioned presentation tile',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 11.5,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'SliverFillViewport',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _leadChipCard({
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
              color: _p.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: _p.muted, fontSize: 11.2),
          ),
        ],
      ),
    );
  }

  Widget _banner({required IconData icon, required String text}) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _p.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: _p.primary, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: _p.ink,
                fontSize: 11.3,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _choice(String label, bool selected, VoidCallback onTap) {
    return ChoiceChip(
      selected: selected,
      selectedColor: _p.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: selected ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11.4,
      ),
      onSelected: (_) => onTap(),
    );
  }

  Widget _sliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color color,
    required String display,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 220,
          child: Text(
            '$label: $display',
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

  Widget _chip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: _p.ink,
          fontFamily: 'monospace',
          fontSize: 10.4,
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
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                fontSize: 11.3,
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

  Widget _doDont({
    required bool good,
    required String title,
    required String detail,
  }) {
    final tone = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(good ? Icons.check_circle : Icons.cancel,
              color: tone, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _p.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
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
            style: TextStyle(color: _p.muted, fontSize: 11.4, height: 1.34),
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
          const Icon(Icons.check_circle,
              color: Color(0xFF2E7D32), size: 18),
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

  Widget _note(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _p.secondary.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.secondary.withValues(alpha: 0.31)),
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
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _panel({
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
            style: TextStyle(color: _p.muted, fontSize: 11.4),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _bottomNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _p.ink.withValues(alpha: 0.05),
      child: Row(
        children: [
          Text(
            _stageLabels[_stage.index],
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
}
