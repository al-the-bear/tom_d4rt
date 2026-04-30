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
    name: 'Sapphire / Coral',
    primary: Color(0xFF1E3A8A),
    secondary: Color(0xFFEF6C57),
    surface: Color(0xFFEFF4FF),
    ink: Color(0xFF1E2A3A),
    accent: Color(0xFF4F46E5),
    muted: Color(0xFF6B7280),
  ),
  _Pal(
    name: 'Forest / Copper',
    primary: Color(0xFF166534),
    secondary: Color(0xFFB45309),
    surface: Color(0xFFEEF8F0),
    ink: Color(0xFF233327),
    accent: Color(0xFF22C55E),
    muted: Color(0xFF6B7280),
  ),
  _Pal(
    name: 'Charcoal / Neon',
    primary: Color(0xFF1F2937),
    secondary: Color(0xFF84CC16),
    surface: Color(0xFFF4F6F8),
    ink: Color(0xFF1F2937),
    accent: Color(0xFF0EA5E9),
    muted: Color(0xFF6B7280),
  ),
];

enum _AnchorPreset {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

Alignment _anchorToAlignment(_AnchorPreset p) {
  switch (p) {
    case _AnchorPreset.topLeft:
      return Alignment.topLeft;
    case _AnchorPreset.topCenter:
      return Alignment.topCenter;
    case _AnchorPreset.topRight:
      return Alignment.topRight;
    case _AnchorPreset.centerLeft:
      return Alignment.centerLeft;
    case _AnchorPreset.center:
      return Alignment.center;
    case _AnchorPreset.centerRight:
      return Alignment.centerRight;
    case _AnchorPreset.bottomLeft:
      return Alignment.bottomLeft;
    case _AnchorPreset.bottomCenter:
      return Alignment.bottomCenter;
    case _AnchorPreset.bottomRight:
      return Alignment.bottomRight;
  }
}

String _anchorLabel(_AnchorPreset p) {
  switch (p) {
    case _AnchorPreset.topLeft:
      return 'Top Left';
    case _AnchorPreset.topCenter:
      return 'Top Center';
    case _AnchorPreset.topRight:
      return 'Top Right';
    case _AnchorPreset.centerLeft:
      return 'Center Left';
    case _AnchorPreset.center:
      return 'Center';
    case _AnchorPreset.centerRight:
      return 'Center Right';
    case _AnchorPreset.bottomLeft:
      return 'Bottom Left';
    case _AnchorPreset.bottomCenter:
      return 'Bottom Center';
    case _AnchorPreset.bottomRight:
      return 'Bottom Right';
  }
}

dynamic build(BuildContext context) {
  return const _OverflowAtelier();
}

class _OverflowAtelier extends StatefulWidget {
  const _OverflowAtelier();

  @override
  State<_OverflowAtelier> createState() => _OverflowAtelierState();
}

class _OverflowAtelierState extends State<_OverflowAtelier> {
  int _scenario = 0;
  int _paletteIndex = 0;
  bool _verbose = false;

  double _parentWidth = 180;
  double _parentHeight = 90;
  double _childWidth = 250;
  double _childHeight = 130;
  _AnchorPreset _anchor = _AnchorPreset.center;

  double _labOuterWidth = 220;
  double _labOuterHeight = 120;
  double _labSizedOverflowWidth = 130;
  double _labSizedOverflowHeight = 70;
  double _labChildWidth = 240;
  double _labChildHeight = 110;

  bool _showClipHardEdge = false;
  bool _showConstraintGrid = true;
  bool _showRulers = true;
  bool _showBadgePattern = true;
  bool _showPeekingCardPattern = true;
  bool _showCalloutPattern = true;

  static const _scenarioTitles = <String>[
    '1 · Concept Comparison',
    '2 · Alignment Playground',
    '3 · Constraint Lab',
    '4 · Pattern Gallery',
    '5 · Clipping & Hit Regions',
    '6 · Verification & Guide',
  ];

  _Pal get _p => _palettes[_paletteIndex];

  void _log(String message) {
    if (_verbose) {
      debugPrint('[OverflowAtelier] $message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.surface,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _controlStrip(),
            Expanded(child: _scenarioBody()),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 15),
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
              const Icon(Icons.open_in_full_rounded,
                  color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Text(
                'Overflow Atelier',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'RenderSizedOverflowBox',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 10.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'SizedOverflowBox gives itself an explicit size while still passing '
            'incoming constraints to its child. This means the child can be '
            'larger than the render box and visually overflow. Explore anchors, '
            'constraints, clipping decisions, and practical UI compositions.',
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

  Widget _controlStrip() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: _p.primary.withValues(alpha: 0.06),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Scenario',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _p.ink,
            ),
          ),
          for (var i = 0; i < _scenarioTitles.length; i++)
            ChoiceChip(
              selected: _scenario == i,
              label: Text('${i + 1}'),
              onSelected: (_) {
                setState(() => _scenario = i);
                _log('scenario changed to $_scenario');
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
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _p.ink,
            ),
          ),
          for (var i = 0; i < _palettes.length; i++)
            GestureDetector(
              onTap: () {
                setState(() => _paletteIndex = i);
                _log('palette changed to $i');
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

  Widget _scenarioBody() {
    switch (_scenario) {
      case 0:
        return _scenarioConceptComparison();
      case 1:
        return _scenarioAlignmentPlayground();
      case 2:
        return _scenarioConstraintLab();
      case 3:
        return _scenarioPatternGallery();
      case 4:
        return _scenarioClippingAndHitRegion();
      case 5:
        return _scenarioVerification();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _scenarioConceptComparison() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Concept Comparison: SizedBox vs OverflowBox vs SizedOverflowBox'),
          const SizedBox(height: 8),
          Text(
            'All three widgets can affect geometry, but they do so very '
            'differently. SizedOverflowBox is unique: the render box size is '
            'fixed by a declared size while the child still receives parent '
            'constraints and can visually extend beyond the box.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Quick Parameter Controls',
            subtitle: 'These values feed all examples in this section.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Parent Width',
                  value: _parentWidth,
                  min: 120,
                  max: 260,
                  onChanged: (v) => setState(() => _parentWidth = v),
                  color: _p.primary,
                ),
                _sliderRow(
                  label: 'Parent Height',
                  value: _parentHeight,
                  min: 60,
                  max: 160,
                  onChanged: (v) => setState(() => _parentHeight = v),
                  color: _p.primary,
                ),
                _sliderRow(
                  label: 'Child Width',
                  value: _childWidth,
                  min: 120,
                  max: 320,
                  onChanged: (v) => setState(() => _childWidth = v),
                  color: _p.secondary,
                ),
                _sliderRow(
                  label: 'Child Height',
                  value: _childHeight,
                  min: 70,
                  max: 220,
                  onChanged: (v) => setState(() => _childHeight = v),
                  color: _p.secondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _comparisonPanel(
                  title: 'SizedBox',
                  note: 'Both parent and child are typically constrained to the same explicit size.',
                  color: _p.primary,
                  child: Container(
                    width: 320,
                    height: 220,
                    alignment: Alignment.center,
                    child: Container(
                      width: _parentWidth,
                      height: _parentHeight,
                      decoration: _frameDecoration(_p.primary),
                      child: SizedBox(
                        width: _parentWidth,
                        height: _parentHeight,
                        child: _demoChild(
                          width: _parentWidth,
                          height: _parentHeight,
                          title: 'Sized Child',
                          color: _p.primary.withValues(alpha: 0.25),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _comparisonPanel(
                  title: 'OverflowBox',
                  note: 'Parent size can remain fixed while child gets relaxed max constraints.',
                  color: _p.secondary,
                  child: Container(
                    width: 320,
                    height: 220,
                    alignment: Alignment.center,
                    child: Container(
                      width: _parentWidth,
                      height: _parentHeight,
                      decoration: _frameDecoration(_p.secondary),
                      child: OverflowBox(
                        minWidth: 0,
                        minHeight: 0,
                        maxWidth: 360,
                        maxHeight: 260,
                        alignment: Alignment.center,
                        child: _demoChild(
                          width: _childWidth,
                          height: _childHeight,
                          title: 'Overflow Child',
                          color: _p.secondary.withValues(alpha: 0.25),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _comparisonPanel(
                  title: 'SizedOverflowBox',
                  note: 'Render box uses explicit size while child keeps inherited constraints.',
                  color: _p.accent,
                  child: Container(
                    width: 320,
                    height: 220,
                    alignment: Alignment.center,
                    child: Container(
                      width: _parentWidth,
                      height: _parentHeight,
                      decoration: _frameDecoration(_p.accent),
                      child: SizedOverflowBox(
                        alignment: Alignment.center,
                        size: Size(_parentWidth, _parentHeight),
                        child: _demoChild(
                          width: _childWidth,
                          height: _childHeight,
                          title: 'SizedOverflow Child',
                          color: _p.accent.withValues(alpha: 0.28),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Takeaway',
            subtitle: 'Where SizedOverflowBox fits.',
            tint: _p.accent.withValues(alpha: 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('You want a predictable parent footprint.'),
                _bullet('You want child visuals to extend beyond that footprint.'),
                _bullet('You still want child to participate in inherited constraints.'),
                _bullet('You need alignment control over where overflow appears.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scenarioAlignmentPlayground() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Alignment Playground'),
          const SizedBox(height: 8),
          Text(
            'Alignment determines the reference point between the fixed-sized '
            'render box and an oversized child. This is often the difference '
            'between a clean decorative overflow and a broken layout.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Anchor Preset',
            subtitle: 'Switch alignment presets to move overflow direction.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final preset in _AnchorPreset.values)
                  ChoiceChip(
                    selected: _anchor == preset,
                    onSelected: (_) {
                      setState(() => _anchor = preset);
                      _log('anchor preset => ${_anchorLabel(preset)}');
                    },
                    label: Text(_anchorLabel(preset)),
                    labelStyle: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _anchor == preset ? Colors.white : _p.ink,
                    ),
                    selectedColor: _p.primary,
                    backgroundColor: Colors.white,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Live Alignment Stage',
            subtitle: 'Blue frame is SizedOverflowBox footprint, child may overflow.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Container(
              width: double.infinity,
              height: 360,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _p.primary.withValues(alpha: 0.28)),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _GridPainter(
                        color: _p.muted.withValues(alpha: 0.2),
                        spacing: 24,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: _parentWidth,
                      height: _parentHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _p.primary, width: 2),
                        color: _p.primary.withValues(alpha: 0.08),
                      ),
                      child: SizedOverflowBox(
                        size: Size(_parentWidth, _parentHeight),
                        alignment: _anchorToAlignment(_anchor),
                        child: _demoChild(
                          width: _childWidth,
                          height: _childHeight,
                          title: _anchorLabel(_anchor),
                          color: _p.secondary.withValues(alpha: 0.22),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: _metricChip('Anchor', _anchorLabel(_anchor), _p.primary),
                  ),
                  Positioned(
                    right: 12,
                    top: 46,
                    child: _metricChip('Parent',
                        '${_parentWidth.toInt()}×${_parentHeight.toInt()}', _p.primary),
                  ),
                  Positioned(
                    right: 12,
                    top: 80,
                    child: _metricChip('Child',
                        '${_childWidth.toInt()}×${_childHeight.toInt()}', _p.secondary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Anchor Matrix',
            subtitle: 'Nine miniature snapshots for quick visual intuition.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final preset in _AnchorPreset.values)
                  _miniAnchorPreview(preset),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'Tip: if overflow should visually emerge from one edge (for '
            'example a badge from top-right), match alignment accordingly. '
            'This avoids manual positional offsets in many cases.',
          ),
        ],
      ),
    );
  }

  Widget _miniAnchorPreview(_AnchorPreset preset) {
    return Container(
      width: 118,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _anchor == preset
              ? _p.primary.withValues(alpha: 0.6)
              : _p.muted.withValues(alpha: 0.2),
          width: _anchor == preset ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 90,
            height: 62,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 48,
                    height: 30,
                    decoration: BoxDecoration(
                      color: _p.primary.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: _p.primary.withValues(alpha: 0.4)),
                    ),
                    child: SizedOverflowBox(
                      size: const Size(48, 30),
                      alignment: _anchorToAlignment(preset),
                      child: Container(
                        width: 66,
                        height: 42,
                        decoration: BoxDecoration(
                          color: _p.secondary.withValues(alpha: 0.28),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _anchorLabel(preset),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: _p.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _scenarioConstraintLab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Constraint Lab'),
          const SizedBox(height: 8),
          Text(
            'The key behavior: SizedOverflowBox sets its own size, but its '
            'child still receives the incoming constraints from the parent. '
            'This section uses explicit sliders and overlays to visualize that '
            'relationship.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Lab Controls',
            subtitle: 'Tune container, render-box size, and child size independently.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'Outer Width',
                  value: _labOuterWidth,
                  min: 160,
                  max: 320,
                  onChanged: (v) => setState(() => _labOuterWidth = v),
                  color: _p.primary,
                ),
                _sliderRow(
                  label: 'Outer Height',
                  value: _labOuterHeight,
                  min: 90,
                  max: 200,
                  onChanged: (v) => setState(() => _labOuterHeight = v),
                  color: _p.primary,
                ),
                _sliderRow(
                  label: 'SizedOverflowBox Width',
                  value: _labSizedOverflowWidth,
                  min: 70,
                  max: 240,
                  onChanged: (v) => setState(() => _labSizedOverflowWidth = v),
                  color: _p.accent,
                ),
                _sliderRow(
                  label: 'SizedOverflowBox Height',
                  value: _labSizedOverflowHeight,
                  min: 40,
                  max: 160,
                  onChanged: (v) => setState(() => _labSizedOverflowHeight = v),
                  color: _p.accent,
                ),
                _sliderRow(
                  label: 'Child Width',
                  value: _labChildWidth,
                  min: 90,
                  max: 340,
                  onChanged: (v) => setState(() => _labChildWidth = v),
                  color: _p.secondary,
                ),
                _sliderRow(
                  label: 'Child Height',
                  value: _labChildHeight,
                  min: 60,
                  max: 220,
                  onChanged: (v) => setState(() => _labChildHeight = v),
                  color: _p.secondary,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _showConstraintGrid,
                            activeColor: _p.primary,
                            onChanged: (v) =>
                                setState(() => _showConstraintGrid = v ?? true),
                          ),
                          Text(
                            'Show Grid',
                            style: TextStyle(fontSize: 12, color: _p.ink),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _showRulers,
                            activeColor: _p.primary,
                            onChanged: (v) =>
                                setState(() => _showRulers = v ?? true),
                          ),
                          Text(
                            'Show Rulers',
                            style: TextStyle(fontSize: 12, color: _p.ink),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Constraint Stage',
            subtitle: 'Outer panel constraints are inherited by child, not replaced by size field.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 420,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _p.primary.withValues(alpha: 0.34)),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_showConstraintGrid)
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _GridPainter(
                                color: _p.muted.withValues(alpha: 0.2),
                                spacing: 20,
                              ),
                            ),
                          ),
                        if (_showRulers)
                          Positioned(
                            top: 10,
                            left: 20,
                            right: 20,
                            child: _horizontalRuler(_labOuterWidth),
                          ),
                        if (_showRulers)
                          Positioned(
                            left: 10,
                            top: 20,
                            bottom: 20,
                            child: _verticalRuler(_labOuterHeight),
                          ),
                        Container(
                          width: _labOuterWidth,
                          height: _labOuterHeight,
                          decoration: BoxDecoration(
                            color: _p.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _p.primary, width: 2),
                          ),
                          child: Center(
                            child: SizedOverflowBox(
                              size: Size(
                                _labSizedOverflowWidth,
                                _labSizedOverflowHeight,
                              ),
                              alignment: _anchorToAlignment(_anchor),
                              child: Container(
                                width: _labChildWidth,
                                height: _labChildHeight,
                                decoration: BoxDecoration(
                                  color: _p.secondary.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _p.secondary.withValues(alpha: 0.55),
                                    width: 1.6,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Child receives outer constraints\n'
                                  'while parent render box keeps fixed size',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: _p.ink,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _metricChip('Outer',
                                  '${_labOuterWidth.toInt()}×${_labOuterHeight.toInt()}', _p.primary),
                              const SizedBox(height: 6),
                              _metricChip('SizedOverflowBox',
                                  '${_labSizedOverflowWidth.toInt()}×${_labSizedOverflowHeight.toInt()}',
                                  _p.accent),
                              const SizedBox(height: 6),
                              _metricChip('Child',
                                  '${_labChildWidth.toInt()}×${_labChildHeight.toInt()}',
                                  _p.secondary),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _p.secondary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Observation: Changing the size property changes the '
                    'render box footprint used by SizedOverflowBox. The child '
                    'still participates in inherited constraints from above, '
                    'which is why it can visually exceed the render box.',
                    style: TextStyle(fontSize: 12, color: _p.ink, height: 1.35),
                  ),
                ),
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
          _sectionTitle('Pattern Gallery: Practical Uses'),
          const SizedBox(height: 8),
          Text(
            'This gallery shows realistic patterns where the parent must keep '
            'stable geometry while child visuals intentionally protrude. '
            'SizedOverflowBox gives you that controlled imbalance.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Pattern Toggles',
            subtitle: 'Enable or disable each example block.',
            child: Column(
              children: [
                _toggleRow(
                  value: _showBadgePattern,
                  text: 'Notification badge that sticks outside card edge',
                  onChanged: (v) => setState(() => _showBadgePattern = v),
                ),
                _toggleRow(
                  value: _showPeekingCardPattern,
                  text: 'Peeking media card in a compact list row',
                  onChanged: (v) => setState(() => _showPeekingCardPattern = v),
                ),
                _toggleRow(
                  value: _showCalloutPattern,
                  text: 'Callout panel handle protruding above body',
                  onChanged: (v) => setState(() => _showCalloutPattern = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_showBadgePattern) _badgePatternCard(),
          if (_showBadgePattern) const SizedBox(height: 12),
          if (_showPeekingCardPattern) _peekingCardPattern(),
          if (_showPeekingCardPattern) const SizedBox(height: 12),
          if (_showCalloutPattern) _calloutHandlePattern(),
          if (_showCalloutPattern) const SizedBox(height: 12),
          _card(
            title: 'Pattern Guidance',
            subtitle: 'How to decide between SizedOverflowBox and alternatives.',
            tint: _p.accent.withValues(alpha: 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Use Positioned/Stack for absolute layering logic.'),
                _bullet('Use OverflowBox when child constraints must change too.'),
                _bullet('Use SizedOverflowBox when parent footprint must remain explicit.'),
                _bullet('Add clipping intentionally if visual spill should be hidden.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badgePatternCard() {
    return _card(
      title: 'Pattern 1 · Outbound Badge',
      subtitle: 'Card layout remains stable while badge extends outward.',
      tint: _p.primary.withValues(alpha: 0.04),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _p.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 88,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _p.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.mail_outline, color: _p.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Inbox summary card with fixed footprint.',
                        style: TextStyle(fontSize: 12, color: _p.ink),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedOverflowBox(
              size: const Size(26, 26),
              alignment: Alignment.topRight,
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _p.secondary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.16),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  '9+',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _peekingCardPattern() {
    return _card(
      title: 'Pattern 2 · Peeking Thumbnail',
      subtitle: 'Compact row with artwork intentionally escaping row bounds.',
      tint: _p.secondary.withValues(alpha: 0.04),
      child: Container(
        width: double.infinity,
        height: 128,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _p.secondary.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Center(
                child: SizedOverflowBox(
                  size: const Size(72, 72),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 102,
                    height: 102,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _p.secondary.withValues(alpha: 0.7),
                          _p.primary.withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Icons.image, color: Colors.white, size: 38),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Peeking Media Card',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: _p.ink,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Row keeps predictable height while decorative media '
                      'extends past the local box.',
                      style: TextStyle(fontSize: 12, color: _p.muted, height: 1.3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _calloutHandlePattern() {
    return _card(
      title: 'Pattern 3 · Protruding Handle',
      subtitle: 'Panel handle extends out without changing panel layout slot.',
      tint: _p.accent.withValues(alpha: 0.05),
      child: Center(
        child: Container(
          width: 420,
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _p.accent.withValues(alpha: 0.35)),
          ),
          child: Column(
            children: [
              SizedOverflowBox(
                size: const Size(56, 10),
                alignment: Alignment.topCenter,
                child: Container(
                  width: 96,
                  height: 18,
                  decoration: BoxDecoration(
                    color: _p.muted.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.notes, color: _p.accent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Callout Panel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: _p.ink,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'The top handle protrudes but the panel still occupies a clean '
                'rectangular slot in parent layouts.',
                style: TextStyle(fontSize: 12, color: _p.muted, height: 1.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scenarioClippingAndHitRegion() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Clipping & Hit Region Visualization'),
          const SizedBox(height: 8),
          Text(
            'Overflow is visual by default when ancestors do not clip. '
            'This section helps reason about clipping and interaction areas '
            'when children extend beyond a render box.',
            style: TextStyle(fontSize: 12.5, color: _p.ink, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Clip Toggle',
            subtitle: 'Switch between Clip.none and Clip.hardEdge wrappers.',
            child: Row(
              children: [
                Text('Clip hard edge', style: TextStyle(fontSize: 12, color: _p.ink)),
                const SizedBox(width: 10),
                Switch(
                  value: _showClipHardEdge,
                  activeTrackColor: _p.accent,
                  onChanged: (v) => setState(() => _showClipHardEdge = v),
                ),
                const SizedBox(width: 10),
                _metricChip('Clip', _showClipHardEdge ? 'hardEdge' : 'none',
                    _showClipHardEdge ? _p.secondary : _p.primary),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Visual Spill Test',
            subtitle: 'Observe whether overflow remains visible outside frame.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Center(
              child: Container(
                width: 500,
                height: 290,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _p.primary.withValues(alpha: 0.3)),
                ),
                child: ClipRect(
                  clipBehavior:
                      _showClipHardEdge ? Clip.hardEdge : Clip.none,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _GridPainter(
                            color: _p.muted.withValues(alpha: 0.18),
                            spacing: 20,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 170,
                          height: 90,
                          decoration: BoxDecoration(
                            color: _p.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _p.primary, width: 2),
                          ),
                          child: SizedOverflowBox(
                            size: const Size(170, 90),
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                _log('overflow child tapped');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(milliseconds: 850),
                                    content: Text('Overflow child tapped'),
                                  ),
                                );
                              },
                              child: Container(
                                width: 260,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: _p.secondary.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _p.secondary.withValues(alpha: 0.6),
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Tap target\n(overflowing child)',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: _p.ink,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: _metricChip(
                          'Mode',
                          _showClipHardEdge ? 'Clipped' : 'Unclipped',
                          _showClipHardEdge ? _p.secondary : _p.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Interaction Notes',
            subtitle: 'Important behavior boundaries.',
            tint: _p.secondary.withValues(alpha: 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Visibility of overflow depends on ancestor clipping.'),
                _bullet('Use clip intentionally for clean boundaries in constrained UI.'),
                _bullet('Keep semantics and hit regions aligned with UX expectations.'),
                _bullet('Test gesture behavior when overflow extends beyond slots.'),
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
            title: 'API Essentials',
            subtitle: 'Main constructor parameters and render intent.',
            child: Column(
              children: [
                _apiRow(
                  prop: 'size',
                  type: 'Size',
                  meaning: 'The render box size of SizedOverflowBox itself.',
                ),
                _apiRow(
                  prop: 'alignment',
                  type: 'AlignmentGeometry',
                  meaning: 'How the child is positioned relative to the box.',
                ),
                _apiRow(
                  prop: 'child',
                  type: 'Widget?',
                  meaning: 'Can be larger than the box and visually overflow.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do / Don\'t Matrix',
            subtitle: 'Quick decisions for production usage.',
            child: Column(
              children: [
                _decisionRow(
                  use: 'Fixed row height + decorative protrusion',
                  decision: 'Do',
                  reason: 'Perfect for controlled overflow accents.',
                  good: true,
                ),
                _decisionRow(
                  use: 'Primary long list item sizing hack',
                  decision: 'Don\'t',
                  reason: 'Can hide constraint issues and complicate hit testing.',
                  good: false,
                ),
                _decisionRow(
                  use: 'Anchored status badge outside avatar frame',
                  decision: 'Do',
                  reason: 'Stable footprint with intentional visual spill.',
                  good: true,
                ),
                _decisionRow(
                  use: 'Avoiding layout bugs without understanding constraints',
                  decision: 'Don\'t',
                  reason: 'Solve root constraint mismatch first.',
                  good: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common confusion points.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _qa(
                  q: 'How is SizedOverflowBox different from OverflowBox?',
                  a: 'OverflowBox modifies child constraints; SizedOverflowBox '
                      'defines only its own render-box size while forwarding '
                      'incoming constraints to child.',
                ),
                _qa(
                  q: 'Why does my overflow disappear?',
                  a: 'An ancestor likely clips (ClipRect, physical model, etc.). '
                      'Overflow visibility requires unclipped ancestors.',
                ),
                _qa(
                  q: 'Does SizedOverflowBox help with badges and handles?',
                  a: 'Yes. It is a strong fit when layout slots must remain fixed '
                      'while decorative elements protrude.',
                ),
                _qa(
                  q: 'Should I use it for every overflow need?',
                  a: 'No. Use Stack/Positioned or OverflowBox when their '
                      'constraint model better matches the goal.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Checklist',
            subtitle: 'Deep demo completion criteria for this component.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Compared core alternatives with visual evidence.'),
                _check('Demonstrated all anchor alignments and overflow directions.'),
                _check('Explained constraint forwarding vs self-size behavior.'),
                _check('Included practical UI patterns with rationale.'),
                _check('Visualized clipping effects and interaction implications.'),
                _check('Provided do/don\'t guidance and FAQ for usage decisions.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _infoBox(
            'Summary: RenderSizedOverflowBox is best used when parent '
            'geometry must remain deterministic while child visuals intentionally '
            'exceed that geometry. Use it as a precision tool, not a blanket '
            'fix for constraint problems.',
          ),
        ],
      ),
    );
  }

  Widget _footer() {
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

  Widget _comparisonPanel({
    required String title,
    required String note,
    required Color color,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _p.ink,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            note,
            style: TextStyle(color: _p.muted, fontSize: 11.3, height: 1.3),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  BoxDecoration _frameDecoration(Color c) {
    return BoxDecoration(
      color: c.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c, width: 1.8),
    );
  }

  Widget _demoChild({
    required double width,
    required double height,
    required String title,
    required Color color,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.4)),
      ),
      alignment: Alignment.center,
      child: Text(
        '$title\n${width.toInt()}×${height.toInt()}',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _p.ink,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _sliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    required Color color,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 168,
          child: Text(
            '$label: ${value.toStringAsFixed(0)}',
            style: TextStyle(fontSize: 12, color: _p.ink),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
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

  Widget _horizontalRuler(double widthValue) {
    return Row(
      children: [
        const Icon(Icons.straighten, size: 14),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            height: 14,
            decoration: BoxDecoration(
              color: _p.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              'Outer width ${widthValue.toInt()} px',
              style: TextStyle(fontSize: 10, color: _p.ink),
            ),
          ),
        ),
      ],
    );
  }

  Widget _verticalRuler(double heightValue) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        width: 140,
        height: 14,
        decoration: BoxDecoration(
          color: _p.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          'Outer height ${heightValue.toInt()} px',
          style: TextStyle(fontSize: 10, color: _p.ink),
        ),
      ),
    );
  }

  Widget _toggleRow({
    required bool value,
    required String text,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Checkbox(
          value: value,
          activeColor: _p.primary,
          onChanged: (v) => onChanged(v ?? false),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: _p.ink),
          ),
        ),
      ],
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
            width: 120,
            child: Text(
              prop,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: _p.primary,
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              type,
              style: TextStyle(
                color: _p.ink,
                fontFamily: 'monospace',
                fontSize: 11.2,
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
                    fontSize: 12,
                    color: _p.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  decision,
                  style: TextStyle(
                    fontSize: 11.4,
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  reason,
                  style: TextStyle(fontSize: 11.4, color: _p.muted),
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
              fontSize: 12,
              color: _p.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'A: $a',
            style: TextStyle(fontSize: 11.5, color: _p.muted, height: 1.35),
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
              style: TextStyle(fontSize: 12, color: _p.ink),
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
              style: TextStyle(fontSize: 12, color: _p.ink, height: 1.35),
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
              color: _p.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: _p.ink, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  final double spacing;

  const _GridPainter({required this.color, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    double x = 0;
    while (x <= size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += spacing;
    }

    double y = 0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += spacing;
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.spacing != spacing;
  }
}
