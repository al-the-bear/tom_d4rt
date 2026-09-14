import 'package:flutter/material.dart';

class _PadTheme {
  final String name;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color ink;
  final Color muted;

  const _PadTheme({
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

const _themes = <_PadTheme>[
  _PadTheme(
    name: 'Blueprint Canvas',
    primary: Color(0xFF2563EB),
    secondary: Color(0xFFF97316),
    accent: Color(0xFF14B8A6),
    background: Color(0xFFF3F7FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1F2937),
    muted: Color(0xFF64748B),
  ),
  _PadTheme(
    name: 'Garden Notes',
    primary: Color(0xFF047857),
    secondary: Color(0xFFE11D48),
    accent: Color(0xFF0EA5E9),
    background: Color(0xFFF1FBF7),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1D2C25),
    muted: Color(0xFF5F6F67),
  ),
  _PadTheme(
    name: 'Slate Focus',
    primary: Color(0xFF0F172A),
    secondary: Color(0xFF22D3EE),
    accent: Color(0xFFA3E635),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF0F172A),
    muted: Color(0xFF64748B),
  ),
];

enum _PadStage {
  playground,
  axisFocus,
  directional,
  nested,
  gallery,
  verification,
}

enum _GalleryKind {
  list,
  grid,
  fixedExtent,
  adapter,
}

dynamic build(BuildContext context) {
  return const _SliverPaddingAtlas();
}

class _SliverPaddingAtlas extends StatefulWidget {
  const _SliverPaddingAtlas();

  @override
  State<_SliverPaddingAtlas> createState() => _SliverPaddingAtlasState();
}

class _SliverPaddingAtlasState extends State<_SliverPaddingAtlas> {
  _PadStage _stage = _PadStage.playground;
  int _themeIndex = 0;
  bool _verbose = false;

  double _playTop = 20;
  double _playBottom = 20;
  double _playStart = 24;
  double _playEnd = 24;
  bool _playShowGuide = true;
  bool _playDenseRows = false;

  double _axisVertical = 28;
  double _axisHorizontal = 28;
  bool _axisShowOverlay = true;

  double _dirStart = 32;
  double _dirEnd = 18;
  double _dirTop = 20;
  double _dirBottom = 26;
  bool _dirIsRtl = false;
  bool _dirShowMapping = true;

  bool _nestedOuter = true;
  bool _nestedInner = true;
  bool _nestedCenterCap = false;
  double _nestedOuterPad = 24;
  double _nestedInnerPad = 14;
  double _nestedCap = 420;

  _GalleryKind _galleryKind = _GalleryKind.list;
  double _galleryH = 18;
  double _galleryV = 16;
  bool _galleryCardView = true;

  static const _stageTitles = <String>[
    '1 - Insets Playground',
    '2 - Axis Focus Lab',
    '3 - Directional and RTL',
    '4 - Nested Padding Stack',
    '5 - Sliver Family Gallery',
    '6 - Verification Guide',
  ];

  _PadTheme get _t => _themes[_themeIndex];

  void _log(String value) {
    if (_verbose) {
      debugPrint('[RenderSliverEdgeInsetsPaddingDemo] $value');
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
              const Icon(Icons.space_dashboard_rounded,
                  color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Sliver Padding Atlas',
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
                  'RenderSliverEdgeInsetsPadding',
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
            'RenderSliverEdgeInsetsPadding powers SliverPadding by offsetting '
            'and reducing sliver layout space through edge insets. This demo '
            'shows how padding affects paint, hit regions, and scroll composition.',
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
                setState(() => _stage = _PadStage.values[i]);
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
      case _PadStage.playground:
        return _buildPlaygroundStage();
      case _PadStage.axisFocus:
        return _buildAxisFocusStage();
      case _PadStage.directional:
        return _buildDirectionalStage();
      case _PadStage.nested:
        return _buildNestedStage();
      case _PadStage.gallery:
        return _buildGalleryStage();
      case _PadStage.verification:
        return _buildVerificationStage();
    }
  }

  Widget _buildPlaygroundStage() {
    final insets = EdgeInsetsDirectional.only(
      top: _playTop,
      bottom: _playBottom,
      start: _playStart,
      end: _playEnd,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Insets Playground'),
          const SizedBox(height: 8),
          Text(
            'Tune each edge inset and observe how SliverPadding adjusts '
            'child placement and available layout space. The guide overlay '
            'shows the buffered region around the padded sliver.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Playground Controls',
            subtitle: 'Adjust all four edges independently.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Top inset',
                  value: _playTop,
                  min: 0,
                  max: 80,
                  divisions: 16,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _playTop = v),
                ),
                _sliderRow(
                  label: 'Bottom inset',
                  value: _playBottom,
                  min: 0,
                  max: 80,
                  divisions: 16,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _playBottom = v),
                ),
                _sliderRow(
                  label: 'Start inset',
                  value: _playStart,
                  min: 0,
                  max: 80,
                  divisions: 16,
                  color: _t.secondary,
                  onChanged: (v) => setState(() => _playStart = v),
                ),
                _sliderRow(
                  label: 'End inset',
                  value: _playEnd,
                  min: 0,
                  max: 80,
                  divisions: 16,
                  color: _t.secondary,
                  onChanged: (v) => setState(() => _playEnd = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _playShowGuide,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _playShowGuide = v ?? true),
                    ),
                    Text(
                      'Show guide overlay',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _playDenseRows,
                      activeColor: _t.secondary,
                      onChanged: (v) =>
                          setState(() => _playDenseRows = v ?? false),
                    ),
                    Text(
                      'Dense rows',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('T', _playTop.toStringAsFixed(0), _t.primary),
                    const SizedBox(width: 6),
                    _metricChip('B', _playBottom.toStringAsFixed(0), _t.primary),
                    const SizedBox(width: 6),
                    _metricChip('S', _playStart.toStringAsFixed(0), _t.secondary),
                    const SizedBox(width: 6),
                    _metricChip('E', _playEnd.toStringAsFixed(0), _t.secondary),
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
                  title: 'Live SliverPadding Scene',
                  subtitle: 'Insets wrap a sliver list between intro and outro blocks.',
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
                          if (_playShowGuide)
                            Positioned.fill(
                              child: IgnorePointer(
                                child: _paddingGuideOverlay(
                                  top: _playTop,
                                  bottom: _playBottom,
                                  start: _playStart,
                                  end: _playEnd,
                                ),
                              ),
                            ),
                          CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: _stageBanner('Padded segment starts below'),
                              ),
                              SliverPadding(
                                padding: insets,
                                sliver: SliverList.builder(
                                  itemCount: _playDenseRows ? 26 : 16,
                                  itemBuilder: (context, index) => _storyCard(
                                    title: 'Padded item ${index + 1}',
                                    subtitle: 'Affected by all edge insets.',
                                    color: index.isEven
                                        ? _t.primary.withValues(alpha: 0.13)
                                        : _t.secondary.withValues(alpha: 0.12),
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: _stageBanner('Padded segment ended'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _card(
                  title: 'Playground Notes',
                  subtitle: 'What changes when each edge grows.',
                  tint: _t.secondary.withValues(alpha: 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _bullet('Top and bottom insets add scroll spacing around sliver.'),
                      _bullet('Start and end insets shrink available cross-axis width.'),
                      _bullet('Inset changes propagate through sliver layout each frame.'),
                      _bullet('SliverPadding is render-layer aware, unlike box padding.'),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _t.muted.withValues(alpha: 0.2)),
                        ),
                        child: Text(
                          'Current insets\n'
                          'top=${_playTop.toStringAsFixed(0)}\n'
                          'bottom=${_playBottom.toStringAsFixed(0)}\n'
                          'start=${_playStart.toStringAsFixed(0)}\n'
                          'end=${_playEnd.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: _t.ink,
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
          ),
          const SizedBox(height: 12),
          _infoBox(
            'RenderSliverEdgeInsetsPadding is best understood as a sliver-space '
            'transform. It offsets child slivers and modifies the constraints '
            'that reach them.',
          ),
        ],
      ),
    );
  }

  Widget _buildAxisFocusStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Axis Focus Lab'),
          const SizedBox(height: 8),
          Text(
            'Compare vertical-only, horizontal-only, and full insets side by '
            'side. This highlights which spacing belongs to scroll axis versus '
            'cross axis in sliver layout.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Axis Controls',
            subtitle: 'Shared axis inset sliders.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Vertical inset size',
                  value: _axisVertical,
                  min: 0,
                  max: 70,
                  divisions: 14,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _axisVertical = v),
                ),
                _sliderRow(
                  label: 'Horizontal inset size',
                  value: _axisHorizontal,
                  min: 0,
                  max: 70,
                  divisions: 14,
                  color: _t.secondary,
                  onChanged: (v) => setState(() => _axisHorizontal = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _axisShowOverlay,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _axisShowOverlay = v ?? true),
                    ),
                    Text(
                      'Show metric overlay',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('V', _axisVertical.toStringAsFixed(0), _t.primary),
                    const SizedBox(width: 6),
                    _metricChip('H', _axisHorizontal.toStringAsFixed(0), _t.secondary),
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
              _axisCaseCard(
                title: 'Vertical Only',
                subtitle: 'Top and bottom insets only',
                padding: EdgeInsets.symmetric(vertical: _axisVertical),
                color: _t.primary,
                overlayText: 'top/bottom only',
              ),
              _axisCaseCard(
                title: 'Horizontal Only',
                subtitle: 'Start and end insets only',
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: _axisHorizontal),
                color: _t.secondary,
                overlayText: 'start/end only',
              ),
              _axisCaseCard(
                title: 'Combined Insets',
                subtitle: 'All edges inset',
                padding: EdgeInsetsDirectional.only(
                  top: _axisVertical,
                  bottom: _axisVertical,
                  start: _axisHorizontal,
                  end: _axisHorizontal,
                ),
                color: _t.accent,
                overlayText: 'full edge insets',
              ),
            ],
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Axis Interpretation',
            subtitle: 'Key mental model.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Vertical insets alter where sliver content starts/ends in scroll axis.'),
                _bullet('Horizontal insets reduce child cross-axis budget.'),
                _bullet('Combined insets can frame content as a centered reading corridor.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _axisCaseCard({
    required String title,
    required String subtitle,
    required EdgeInsetsGeometry padding,
    required Color color,
    required String overlayText,
  }) {
    return SizedBox(
      width: 410,
      child: _card(
        title: title,
        subtitle: subtitle,
        tint: color.withValues(alpha: 0.05),
        child: SizedBox(
          height: 300,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
            ),
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _stageBanner('Axis case: $overlayText'),
                    ),
                    SliverPadding(
                      padding: padding,
                      sliver: SliverList.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) => _storyCard(
                          title: 'Case row ${index + 1}',
                          subtitle: overlayText,
                          color: color.withValues(alpha: 0.13),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_axisShowOverlay)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: _metricChip('mode', overlayText, color),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDirectionalStage() {
    final edgeInsets = EdgeInsetsDirectional.only(
      start: _dirStart,
      end: _dirEnd,
      top: _dirTop,
      bottom: _dirBottom,
    );

    final resolvedLeft = _dirIsRtl ? _dirEnd : _dirStart;
    final resolvedRight = _dirIsRtl ? _dirStart : _dirEnd;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Directional and RTL Studio'),
          const SizedBox(height: 8),
          Text(
            'EdgeInsetsDirectional depends on text direction. Toggle LTR/RTL '
            'to see start and end swap their physical left/right mapping.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Directional Controls',
            subtitle: 'Edit start/end and switch text direction.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Start inset',
                  value: _dirStart,
                  min: 0,
                  max: 90,
                  divisions: 18,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _dirStart = v),
                ),
                _sliderRow(
                  label: 'End inset',
                  value: _dirEnd,
                  min: 0,
                  max: 90,
                  divisions: 18,
                  color: _t.secondary,
                  onChanged: (v) => setState(() => _dirEnd = v),
                ),
                _sliderRow(
                  label: 'Top inset',
                  value: _dirTop,
                  min: 0,
                  max: 80,
                  divisions: 16,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _dirTop = v),
                ),
                _sliderRow(
                  label: 'Bottom inset',
                  value: _dirBottom,
                  min: 0,
                  max: 80,
                  divisions: 16,
                  color: _t.secondary,
                  onChanged: (v) => setState(() => _dirBottom = v),
                ),
                Row(
                  children: [
                    ChoiceChip(
                      selected: !_dirIsRtl,
                      label: const Text('LTR'),
                      onSelected: (_) => setState(() => _dirIsRtl = false),
                    ),
                    const SizedBox(width: 6),
                    ChoiceChip(
                      selected: _dirIsRtl,
                      label: const Text('RTL'),
                      onSelected: (_) => setState(() => _dirIsRtl = true),
                    ),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _dirShowMapping,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _dirShowMapping = v ?? true),
                    ),
                    Text(
                      'Show left/right mapping panel',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('left', resolvedLeft.toStringAsFixed(0), _t.primary),
                    const SizedBox(width: 6),
                    _metricChip('right', resolvedRight.toStringAsFixed(0), _t.secondary),
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
                  title: 'Directional Sliver Surface',
                  subtitle: 'Padding uses EdgeInsetsDirectional and live directionality.',
                  tint: _t.primary.withValues(alpha: 0.04),
                  child: SizedBox(
                    height: 540,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
                      ),
                      child: Directionality(
                        textDirection:
                            _dirIsRtl ? TextDirection.rtl : TextDirection.ltr,
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: _stageBanner(_dirIsRtl
                                  ? 'RTL direction active'
                                  : 'LTR direction active'),
                            ),
                            SliverPadding(
                              padding: edgeInsets,
                              sliver: SliverList.builder(
                                itemCount: 14,
                                itemBuilder: (context, index) => _storyCard(
                                  title: 'Directional card ${index + 1}',
                                  subtitle: _dirIsRtl
                                      ? 'start maps to right, end maps to left'
                                      : 'start maps to left, end maps to right',
                                  color: index.isEven
                                      ? _t.primary.withValues(alpha: 0.12)
                                      : _t.secondary.withValues(alpha: 0.12),
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
              if (_dirShowMapping) ...[
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _card(
                    title: 'Mapping Panel',
                    subtitle: 'Resolved physical edge values.',
                    tint: _t.secondary.withValues(alpha: 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _bullet('EdgeInsetsDirectional is locale direction aware.'),
                        _bullet('Start/end are semantic edges, not physical edges.'),
                        _bullet('Top/bottom stay unchanged across direction modes.'),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _t.muted.withValues(alpha: 0.2)),
                          ),
                          child: Text(
                            'Direction: ${_dirIsRtl ? 'RTL' : 'LTR'}\n'
                            'start=${_dirStart.toStringAsFixed(0)}\n'
                            'end=${_dirEnd.toStringAsFixed(0)}\n'
                            'resolvedLeft=${resolvedLeft.toStringAsFixed(0)}\n'
                            'resolvedRight=${resolvedRight.toStringAsFixed(0)}\n'
                            'top=${_dirTop.toStringAsFixed(0)}\n'
                            'bottom=${_dirBottom.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: _t.ink,
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

  Widget _buildNestedStage() {
    Widget lane = SliverList.builder(
      itemCount: 14,
      itemBuilder: (context, index) => _storyCard(
        title: 'Nested row ${index + 1}',
        subtitle: 'Observe cumulative sliver insets.',
        color: index.isEven
            ? _t.primary.withValues(alpha: 0.12)
            : _t.secondary.withValues(alpha: 0.12),
      ),
    );

    if (_nestedInner) {
      lane = SliverPadding(
        padding: EdgeInsets.all(_nestedInnerPad),
        sliver: lane,
      );
    }

    if (_nestedCenterCap) {
      lane = SliverConstrainedCrossAxis(
        maxExtent: _nestedCap,
        sliver: lane,
      );
    }

    if (_nestedOuter) {
      lane = SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: _nestedOuterPad, vertical: 10),
        sliver: lane,
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Nested Padding Stack'),
          const SizedBox(height: 8),
          Text(
            'Layering multiple SliverPadding wrappers composes offsets in a '
            'predictable way. This stage shows outer and inner paddings plus '
            'optional cross-axis cap in the middle.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Nested Controls',
            subtitle: 'Enable or disable each wrapper layer.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Outer horizontal inset',
                  value: _nestedOuterPad,
                  min: 0,
                  max: 48,
                  divisions: 12,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _nestedOuterPad = v),
                ),
                _sliderRow(
                  label: 'Inner all-side inset',
                  value: _nestedInnerPad,
                  min: 0,
                  max: 36,
                  divisions: 9,
                  color: _t.secondary,
                  onChanged: (v) => setState(() => _nestedInnerPad = v),
                ),
                _sliderRow(
                  label: 'Center maxExtent',
                  value: _nestedCap,
                  min: 280,
                  max: 620,
                  divisions: 17,
                  color: _t.accent,
                  onChanged: (v) => setState(() => _nestedCap = v),
                ),
                Row(
                  children: [
                    _toggleChip(
                      label: 'Outer SliverPadding',
                      value: _nestedOuter,
                      onChanged: (v) => setState(() => _nestedOuter = v),
                    ),
                    const SizedBox(width: 8),
                    _toggleChip(
                      label: 'Inner SliverPadding',
                      value: _nestedInner,
                      onChanged: (v) => setState(() => _nestedInner = v),
                    ),
                    const SizedBox(width: 8),
                    _toggleChip(
                      label: 'Center cap lane',
                      value: _nestedCenterCap,
                      onChanged: (v) => setState(() => _nestedCenterCap = v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Layered Sliver Scene',
            subtitle: 'Wrapper order is visually encoded by badges.',
            tint: _t.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 560,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _t.muted.withValues(alpha: 0.24)),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _stageBanner('Nested wrapper chain active'),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 6),
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            if (_nestedOuter)
                              _metricChip('outer',
                                  _nestedOuterPad.toStringAsFixed(0), _t.primary),
                            if (_nestedInner)
                              _metricChip('inner',
                                  _nestedInnerPad.toStringAsFixed(0), _t.secondary),
                            if (_nestedCenterCap)
                              _metricChip('max',
                                  _nestedCap.toStringAsFixed(0), _t.accent),
                            if (!_nestedOuter && !_nestedInner && !_nestedCenterCap)
                              _metricChip('mode', 'no wrappers', _t.muted),
                          ],
                        ),
                      ),
                    ),
                    lane,
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Nested Guidance',
            subtitle: 'Ordering matters.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Outer wrappers affect larger layout region first.'),
                _bullet('Inner wrappers further inset child slivers after outer transforms.'),
                _bullet('Insert cross-axis constraints between padding layers when needed.'),
                _bullet('Use clear wrapper intent to keep layout maintenance simple.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryStage() {
    Widget demoSliver;
    String kindText;

    switch (_galleryKind) {
      case _GalleryKind.list:
        kindText = 'SliverList';
        demoSliver = SliverList.builder(
          itemCount: 12,
          itemBuilder: (context, index) => _storyCard(
            title: 'List card ${index + 1}',
            subtitle: 'Padding around list lane',
            color: _t.primary.withValues(alpha: 0.12),
          ),
        );
        break;
      case _GalleryKind.grid:
        kindText = 'SliverGrid';
        demoSliver = SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 84,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _t.secondary.withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Grid ${index + 1}',
                style: TextStyle(
                  color: _t.ink,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            childCount: 12,
          ),
        );
        break;
      case _GalleryKind.fixedExtent:
        kindText = 'SliverFixedExtentList';
        demoSliver = SliverFixedExtentList.builder(
          itemExtent: 68,
          itemCount: 14,
          itemBuilder: (context, index) => _storyCard(
            title: 'Fixed row ${index + 1}',
            subtitle: 'Padding plus fixed row extent',
            color: _t.accent.withValues(alpha: 0.14),
          ),
        );
        break;
      case _GalleryKind.adapter:
        kindText = 'SliverToBoxAdapter stack';
        demoSliver = SliverMainAxisGroup(
          slivers: [
            for (var i = 0; i < 8; i++)
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: _t.secondary.withValues(alpha: 0.13),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Adapter card ${i + 1}',
                    style: TextStyle(
                      color: _t.ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        );
        break;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Sliver Family Gallery'),
          const SizedBox(height: 8),
          Text(
            'RenderSliverEdgeInsetsPadding can wrap many sliver families. '
            'Switch sample type to observe consistent padding behavior across '
            'different sliver renderers.',
            style: TextStyle(color: _t.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Gallery Controls',
            subtitle: 'Pick sliver family and padding sizes.',
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _kindChip('List', _GalleryKind.list),
                    _kindChip('Grid', _GalleryKind.grid),
                    _kindChip('FixedExtent', _GalleryKind.fixedExtent),
                    _kindChip('Adapter', _GalleryKind.adapter),
                  ],
                ),
                const SizedBox(height: 8),
                _sliderRow(
                  label: 'Horizontal gallery inset',
                  value: _galleryH,
                  min: 0,
                  max: 48,
                  divisions: 12,
                  color: _t.primary,
                  onChanged: (v) => setState(() => _galleryH = v),
                ),
                _sliderRow(
                  label: 'Vertical gallery inset',
                  value: _galleryV,
                  min: 0,
                  max: 48,
                  divisions: 12,
                  color: _t.secondary,
                  onChanged: (v) => setState(() => _galleryV = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _galleryCardView,
                      activeColor: _t.primary,
                      onChanged: (v) =>
                          setState(() => _galleryCardView = v ?? true),
                    ),
                    Text(
                      'Use card shell around viewport',
                      style: TextStyle(color: _t.ink, fontSize: 12),
                    ),
                    const Spacer(),
                    _metricChip('sliver', kindText, _t.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Gallery Viewport',
            subtitle: 'Selected sliver wrapped with SliverPadding.',
            tint: _t.secondary.withValues(alpha: 0.04),
            child: SizedBox(
              height: 560,
              child: Container(
                decoration: BoxDecoration(
                  color: _galleryCardView ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: _galleryCardView
                      ? Border.all(color: _t.muted.withValues(alpha: 0.24))
                      : null,
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _stageBanner('Gallery mode: $kindText'),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: _galleryH, vertical: _galleryV),
                      sliver: demoSliver,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Family Notes',
            subtitle: 'Uniform inset behavior, diverse child rendering.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Padding logic is consistent even as child sliver type changes.'),
                _bullet('Grid and fixed-extent slivers keep their own internal layout rules.'),
                _bullet('Padding is ideal for section framing in large composite scroll views.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kindChip(String label, _GalleryKind kind) {
    return ChoiceChip(
      selected: _galleryKind == kind,
      selectedColor: _t.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _galleryKind == kind ? Colors.white : _t.ink,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) => setState(() => _galleryKind = kind),
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
            subtitle: 'Core layout effects of RenderSliverEdgeInsetsPadding.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Main-axis insets',
                  value:
                      'Top and bottom increase spacing before and after child sliver content.',
                ),
                _matrixRow(
                  keyText: 'Cross-axis insets',
                  value:
                      'Start and end reduce child cross-axis extent before child layout.',
                ),
                _matrixRow(
                  keyText: 'Directional semantics',
                  value:
                      'Start and end resolve according to active TextDirection.',
                ),
                _matrixRow(
                  keyText: 'Composition role',
                  value:
                      'Works as a wrapper sliver that can be nested and combined with others.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do and Dont',
            subtitle: 'Practical usage in production sliver layouts.',
            child: Column(
              children: [
                _doDont(
                  good: true,
                  title: 'Use SliverPadding to frame sections in CustomScrollView',
                  detail:
                      'It preserves sliver-aware layout behavior and scroll geometry.',
                ),
                _doDont(
                  good: false,
                  title: 'Replace all spacing with box padding inside sliver children',
                  detail:
                      'You lose clear section-level sliver framing and can complicate structure.',
                ),
                _doDont(
                  good: true,
                  title: 'Prefer EdgeInsetsDirectional for localized apps',
                  detail:
                      'Start/end naturally adapt in RTL and LTR contexts.',
                ),
                _doDont(
                  good: false,
                  title: 'Over-nest padding without intent',
                  detail:
                      'Too many layers can make spacing hard to reason about.',
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
                  q: 'Does SliverPadding change child sliver type?',
                  a: 'No. It wraps the child and transforms its constraints and '
                      'position through edge insets.',
                ),
                _qa(
                  q: 'Can I use SliverPadding around SliverGrid?',
                  a: 'Yes. It works with most sliver children including lists, '
                      'grids, and adapter-based compositions.',
                ),
                _qa(
                  q: 'Should I use EdgeInsetsDirectional always?',
                  a: 'Use it when direction-aware spacing is desired. Use plain '
                      'EdgeInsets when physical left/right is intentional.',
                ),
                _qa(
                  q: 'How does it interact with cross-axis constraints?',
                  a: 'Padding insets apply first, then downstream wrappers like '
                      'SliverConstrainedCrossAxis can further constrain width.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo completion checkpoints.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Four-edge interactive insets playground implemented.'),
                _check('Axis-specific comparison across vertical/horizontal/full cases.'),
                _check('Directional and RTL mapping demonstrated visually.'),
                _check('Nested wrapper stack behavior shown with toggles.'),
                _check('Multiple sliver families padded in gallery mode.'),
                _check('Guide includes matrix, dos and donts, FAQ, and checklist.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'RenderSliverEdgeInsetsPadding is a precision spacing tool for '
            'sliver pipelines. Use it to build readable, structured, and '
            'direction-aware scroll compositions.',
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

  Widget _paddingGuideOverlay({
    required double top,
    required double bottom,
    required double start,
    required double end,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: top,
              color: _t.primary.withValues(alpha: 0.08),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: start,
                    color: _t.secondary.withValues(alpha: 0.08),
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    width: end,
                    color: _t.secondary.withValues(alpha: 0.08),
                  ),
                ],
              ),
            ),
            Container(
              height: bottom,
              color: _t.primary.withValues(alpha: 0.08),
            ),
          ],
        );
      },
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
          Icon(Icons.padding, color: _t.primary, size: 16),
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
          width: 200,
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

  Widget _toggleChip({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return FilterChip(
      selected: value,
      selectedColor: _t.primary.withValues(alpha: 0.16),
      backgroundColor: Colors.white,
      side: BorderSide(color: _t.primary.withValues(alpha: 0.24)),
      onSelected: onChanged,
      label: Text(
        label,
        style: TextStyle(
          color: _t.ink,
          fontSize: 11.3,
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
