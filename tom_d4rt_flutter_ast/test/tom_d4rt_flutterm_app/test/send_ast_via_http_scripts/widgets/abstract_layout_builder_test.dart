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
    name: 'Atlantic Forge',
    primary: Color(0xFF1D4ED8),
    secondary: Color(0xFFEA580C),
    accent: Color(0xFF0D9488),
    background: Color(0xFFF4F8FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1F2937),
    muted: Color(0xFF64748B),
  ),
  _Palette(
    name: 'Forest Rose',
    primary: Color(0xFF0F766E),
    secondary: Color(0xFFBE123C),
    accent: Color(0xFF2563EB),
    background: Color(0xFFF2FBF8),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1A312D),
    muted: Color(0xFF5E7069),
  ),
  _Palette(
    name: 'Slate Lime',
    primary: Color(0xFF111827),
    secondary: Color(0xFF65A30D),
    accent: Color(0xFF0284C7),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF111827),
    muted: Color(0xFF6B7280),
  ),
];

enum _Stage {
  snapshot,
  breakpoints,
  sliverDeck,
  relay,
  theater,
  verification,
}

enum _DensityMode {
  relaxed,
  balanced,
  compact,
}

enum _RelayMode {
  stable,
  pulsing,
}

class _ShellProfile {
  final String label;
  final double width;
  final double height;
  final String note;

  const _ShellProfile({
    required this.label,
    required this.width,
    required this.height,
    required this.note,
  });
}

const _shellProfiles = <_ShellProfile>[
  _ShellProfile(
    label: 'Pocket',
    width: 320,
    height: 520,
    note: 'Small shell for strict width decisions.',
  ),
  _ShellProfile(
    label: 'Tablet',
    width: 640,
    height: 560,
    note: 'Mid shell shows transition breakpoints.',
  ),
  _ShellProfile(
    label: 'Desktop',
    width: 920,
    height: 620,
    note: 'Wide shell demonstrates multi-pane composition.',
  ),
];

dynamic build(BuildContext context) {
  return const _AbstractLayoutBuilderStudio();
}

class _AbstractLayoutBuilderStudio extends StatefulWidget {
  const _AbstractLayoutBuilderStudio();

  @override
  State<_AbstractLayoutBuilderStudio> createState() =>
      _AbstractLayoutBuilderStudioState();
}

class _AbstractLayoutBuilderStudioState
    extends State<_AbstractLayoutBuilderStudio> {
  _Stage _stage = _Stage.snapshot;
  int _paletteIndex = 0;
  bool _verbose = false;

  double _snapshotWidth = 520;
  double _snapshotHeight = 360;
  _DensityMode _snapshotDensity = _DensityMode.balanced;
  bool _snapshotGuides = true;
  bool _snapshotBadge = true;

  double _breakpointWidth = 780;
  double _breakpointItems = 12;
  bool _breakpointRail = true;
  bool _breakpointLabel = true;

  double _sliverViewportWidth = 700;
  double _sliverHeaderHeight = 120;
  double _sliverItems = 20;
  bool _sliverOverlay = true;
  bool _sliverPinned = true;

  double _relayOuterWidth = 740;
  double _relayOuterHeight = 420;
  bool _relayNotes = true;
  _RelayMode _relayMode = _RelayMode.stable;

  bool _theaterTrio = true;
  double _theaterCustomWidth = 700;
  double _theaterCustomHeight = 520;
  bool _theaterMetrics = true;

  static const _stageNames = <String>[
    '1 Constraint Snapshot Studio',
    '2 Breakpoint Composer',
    '3 Sliver Constraint Deck',
    '4 Nested Relay Lab',
    '5 Device Theater',
    '6 Verification Compendium',
  ];

  _Palette get _p => _palettes[_paletteIndex];

  void _trace(String message) {
    if (_verbose) {
      debugPrint('[AbstractLayoutBuilderDemo] $message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.background,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _toolbar(),
            Expanded(child: _stageBody()),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
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
              const Icon(Icons.space_dashboard_rounded,
                  color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'AbstractLayoutBuilder Constraint Studio',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
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
                  'LayoutBuilder and SliverLayoutBuilder',
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
            'AbstractLayoutBuilder is the base pattern for constraint-aware '
            'builders. This demo teaches box and sliver constraint decisions '
            'through visual scenes and adaptive interactions.',
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

  Widget _toolbar() {
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
          for (var i = 0; i < _stageNames.length; i++)
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
                setState(() => _stage = _Stage.values[i]);
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

  Widget _stageBody() {
    switch (_stage) {
      case _Stage.snapshot:
        return _snapshotStage();
      case _Stage.breakpoints:
        return _breakpointStage();
      case _Stage.sliverDeck:
        return _sliverStage();
      case _Stage.relay:
        return _relayStage();
      case _Stage.theater:
        return _theaterStage();
      case _Stage.verification:
        return _verificationStage();
    }
  }

  Widget _snapshotStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Constraint Snapshot Studio'),
          const SizedBox(height: 8),
          Text(
            'LayoutBuilder reacts to incoming BoxConstraints. Resize the '
            'parent shell and observe how the builder changes structure and '
            'content density.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Snapshot Controls',
            subtitle: 'Parent dimensions and density mode.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'parent width',
                  value: _snapshotWidth,
                  min: 300,
                  max: 960,
                  divisions: 22,
                  color: _p.primary,
                  display: _snapshotWidth.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _snapshotWidth = v),
                ),
                _sliderRow(
                  label: 'parent height',
                  value: _snapshotHeight,
                  min: 220,
                  max: 560,
                  divisions: 17,
                  color: _p.secondary,
                  display: _snapshotHeight.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _snapshotHeight = v),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _densityChip('Relaxed', _DensityMode.relaxed),
                    _densityChip('Balanced', _DensityMode.balanced),
                    _densityChip('Compact', _DensityMode.compact),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _snapshotGuides,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _snapshotGuides = v ?? true),
                    ),
                    Text('show guides',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _snapshotBadge,
                      activeColor: _p.secondary,
                      onChanged: (v) =>
                          setState(() => _snapshotBadge = v ?? true),
                    ),
                    Text('show decision badge',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const Spacer(),
                    _chip('w', _snapshotWidth.toStringAsFixed(0), _p.primary),
                    const SizedBox(width: 6),
                    _chip('h', _snapshotHeight.toStringAsFixed(0), _p.secondary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Snapshot View',
            subtitle: 'Live LayoutBuilder decision panel.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Center(
              child: SizedBox(
                width: _snapshotWidth,
                height: _snapshotHeight,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: _p.muted.withValues(alpha: 0.24)),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return _snapshotDecisionBoard(constraints);
                        },
                      ),
                    ),
                    if (_snapshotGuides)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _GuidePainter(
                              color: _p.primary.withValues(alpha: 0.11),
                              spacing: 44,
                            ),
                          ),
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

  Widget _snapshotDecisionBoard(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final decision = _classifyWidth(width);
    final cards = _densityCount();

    Widget body;
    if (decision == 'single') {
      body = Column(
        children: [
          _decisionHeadline('Single Column', Icons.view_agenda_rounded),
          const SizedBox(height: 8),
          for (var i = 0; i < cards; i++) Expanded(child: _snapTile(i, decision)),
        ],
      );
    } else if (decision == 'dual') {
      body = Column(
        children: [
          _decisionHeadline('Dual Region', Icons.view_week_rounded),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      for (var i = 0; i < cards; i++)
                        Expanded(child: _snapTile(i, decision)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _aside(
                    title: 'Constraint Note',
                    detail:
                        'Mid width supports main feed + side context without crowding.',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      body = Column(
        children: [
          _decisionHeadline('Tri Region', Icons.dashboard_rounded),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      for (var i = 0; i < cards; i++)
                        Expanded(child: _snapTile(i, decision)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _aside(
                    title: 'Rail',
                    detail: 'Persistent navigation lane in wide mode.',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _aside(
                    title: 'Insights',
                    detail: 'Additional analytics remains visible.',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _chip('maxW', width.toStringAsFixed(0), _p.primary),
              const SizedBox(width: 6),
              _chip('maxH', constraints.maxHeight.toStringAsFixed(0), _p.secondary),
              const SizedBox(width: 6),
              _chip('density', _snapshotDensity.name, _p.accent),
              const Spacer(),
              if (_snapshotBadge) _chip('decision', decision, _p.secondary),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(child: body),
        ],
      ),
    );
  }

  String _classifyWidth(double width) {
    if (width < 420) {
      return 'single';
    }
    if (width < 760) {
      return 'dual';
    }
    return 'tri';
  }

  int _densityCount() {
    switch (_snapshotDensity) {
      case _DensityMode.relaxed:
        return 3;
      case _DensityMode.balanced:
        return 4;
      case _DensityMode.compact:
        return 6;
    }
  }

  Widget _densityChip(String label, _DensityMode mode) {
    return ChoiceChip(
      selected: _snapshotDensity == mode,
      selectedColor: _p.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _snapshotDensity == mode ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11.4,
      ),
      onSelected: (_) => setState(() => _snapshotDensity = mode),
    );
  }

  Widget _decisionHeadline(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: _p.primary, size: 18),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: _p.ink,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _snapTile(int index, String decision) {
    final tone = index.isEven ? _p.primary : _p.secondary;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.view_carousel_rounded, color: tone, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Adaptive tile ${index + 1} ($decision)',
              style: TextStyle(
                color: _p.ink,
                fontSize: 11.4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _breakpointStage() {
    final count = _breakpointItems.round();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Breakpoint Composer'),
          const SizedBox(height: 8),
          Text(
            'This stage demonstrates common breakpoint bands with '
            'LayoutBuilder-driven structure changes.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Composer Controls',
            subtitle: 'Width and content volume.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'composer width',
                  value: _breakpointWidth,
                  min: 320,
                  max: 1080,
                  divisions: 19,
                  color: _p.primary,
                  display: _breakpointWidth.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _breakpointWidth = v),
                ),
                _sliderRow(
                  label: 'content cards',
                  value: _breakpointItems,
                  min: 6,
                  max: 24,
                  divisions: 18,
                  color: _p.secondary,
                  display: '$count',
                  onChanged: (v) => setState(() => _breakpointItems = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _breakpointRail,
                      activeColor: _p.primary,
                      onChanged: (v) =>
                          setState(() => _breakpointRail = v ?? true),
                    ),
                    Text('show breakpoint rail',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _breakpointLabel,
                      activeColor: _p.secondary,
                      onChanged: (v) =>
                          setState(() => _breakpointLabel = v ?? true),
                    ),
                    Text('show zone label',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Composer View',
            subtitle: 'Single, split, and tri-zone variants.',
            tint: _p.secondary.withValues(alpha: 0.04),
            child: Center(
              child: SizedBox(
                width: _breakpointWidth,
                height: 560,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: _p.muted.withValues(alpha: 0.24)),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final w = constraints.maxWidth;
                      final zone = w < 500
                          ? 'narrow'
                          : w < 900
                              ? 'medium'
                              : 'wide';
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: _breakpointBody(constraints, count),
                          ),
                          if (_breakpointLabel)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: _chip('zone', zone, _p.secondary),
                            ),
                          if (_breakpointRail)
                            Positioned(
                              left: 8,
                              top: 8,
                              child: _breakpointRailWidget(w),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _breakpointBody(BoxConstraints constraints, int count) {
    final width = constraints.maxWidth;
    if (width < 500) {
      return ListView.builder(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        itemCount: count,
        itemBuilder: (context, index) => _composerCard(index, 'single'),
      );
    }
    if (width < 900) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
              itemCount: count,
              itemBuilder: (context, index) => _composerCard(index, 'split'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 12, 12, 12),
              child: _aside(
                title: 'Side Guide',
                detail: 'Medium width keeps a contextual panel visible.',
              ),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
            child: _aside(
              title: 'Nav',
              detail: 'Persistent nav in wide mode.',
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(6, 12, 6, 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2.0,
            ),
            itemCount: count,
            itemBuilder: (context, index) => _composerCard(index, 'grid'),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 12, 12, 12),
            child: _aside(
              title: 'Insights',
              detail: 'Supplemental analytics remains visible.',
            ),
          ),
        ),
      ],
    );
  }

  Widget _composerCard(int index, String mode) {
    final tone = index.isEven ? _p.primary : _p.secondary;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Icon(Icons.widgets_rounded, color: tone, size: 17),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Composer card ${index + 1} ($mode)',
              style: TextStyle(
                color: _p.ink,
                fontWeight: FontWeight.w700,
                fontSize: 11.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _breakpointRailWidget(double width) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Breakpoints',
            style: TextStyle(
              color: _p.ink,
              fontWeight: FontWeight.w700,
              fontSize: 11.5,
            ),
          ),
          const SizedBox(height: 4),
          Text('narrow < 500', style: TextStyle(color: _p.muted, fontSize: 10.5)),
          Text('medium 500-899', style: TextStyle(color: _p.muted, fontSize: 10.5)),
          Text('wide >= 900', style: TextStyle(color: _p.muted, fontSize: 10.5)),
          const SizedBox(height: 4),
          Text(
            'now: ${width.toStringAsFixed(0)}',
            style: TextStyle(
              color: _p.ink,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 10.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sliverStage() {
    final count = _sliverItems.round();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Sliver Constraint Deck'),
          const SizedBox(height: 8),
          Text(
            'SliverLayoutBuilder uses sliver constraints. This deck branches '
            'between fixed list and multi-column grids using crossAxisExtent.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Sliver Controls',
            subtitle: 'Viewport width, header, and item count.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'sliver width',
                  value: _sliverViewportWidth,
                  min: 320,
                  max: 980,
                  divisions: 22,
                  color: _p.primary,
                  display: _sliverViewportWidth.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _sliverViewportWidth = v),
                ),
                _sliderRow(
                  label: 'header height',
                  value: _sliverHeaderHeight,
                  min: 70,
                  max: 180,
                  divisions: 11,
                  color: _p.secondary,
                  display: _sliverHeaderHeight.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _sliverHeaderHeight = v),
                ),
                _sliderRow(
                  label: 'items',
                  value: _sliverItems,
                  min: 8,
                  max: 36,
                  divisions: 14,
                  color: _p.accent,
                  display: '$count',
                  onChanged: (v) => setState(() => _sliverItems = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _sliverOverlay,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _sliverOverlay = v ?? true),
                    ),
                    Text('show mode labels',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 12),
                    Checkbox(
                      value: _sliverPinned,
                      activeColor: _p.secondary,
                      onChanged: (v) => setState(() => _sliverPinned = v ?? true),
                    ),
                    Text('pinned app bar',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Sliver View',
            subtitle: 'SliverLayoutBuilder decision region.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Center(
              child: SizedBox(
                width: _sliverViewportWidth,
                height: 620,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: _p.muted.withValues(alpha: 0.24)),
                  ),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        pinned: _sliverPinned,
                        expandedHeight: _sliverHeaderHeight,
                        backgroundColor: _p.primary,
                        flexibleSpace: FlexibleSpaceBar(
                          title: const Text('Sliver Deck',
                              style: TextStyle(fontSize: 13)),
                          background: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [_p.primary, _p.secondary],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: _banner(
                          icon: Icons.splitscreen_rounded,
                          text: 'SliverLayoutBuilder branches by cross-axis extent',
                        ),
                      ),
                      SliverLayoutBuilder(
                        builder: (context, constraints) {
                          final cross = constraints.crossAxisExtent;
                          if (cross < 460) {
                            return SliverFixedExtentList.builder(
                              itemExtent: 86,
                              itemCount: count,
                              itemBuilder: (context, index) =>
                                  _sliverListTile(index, 'single', cross),
                            );
                          }
                          if (cross < 780) {
                            return SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) =>
                                    _sliverGridTile(index, 'dual', cross),
                                childCount: count,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 2.2,
                              ),
                            );
                          }
                          return SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  _sliverGridTile(index, 'tri', cross),
                              childCount: count,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 2.3,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sliverListTile(int index, String mode, double cross) {
    final tone = index.isEven ? _p.primary : _p.secondary;
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 3, 10, 3),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(Icons.view_headline_rounded, color: tone, size: 17),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Sliver item ${index + 1} ($mode, ${cross.toStringAsFixed(0)})',
              style: TextStyle(
                color: _p.ink,
                fontWeight: FontWeight.w700,
                fontSize: 11.5,
              ),
            ),
          ),
          if (_sliverOverlay)
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.77),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                mode,
                style: TextStyle(
                  color: _p.ink,
                  fontFamily: 'monospace',
                  fontSize: 10.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _sliverGridTile(int index, String mode, double cross) {
    final tone = index.isEven ? _p.primary : _p.secondary;
    return Container(
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.grid_view_rounded, color: tone, size: 15),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Grid ${index + 1}',
                    style: TextStyle(
                      color: _p.ink,
                      fontSize: 11.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              '$mode | ${cross.toStringAsFixed(0)}',
              style: TextStyle(color: _p.muted, fontSize: 10.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _relayStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Nested Relay Lab'),
          const SizedBox(height: 8),
          Text(
            'Nested LayoutBuilder layers reveal how constraints relay from '
            'outer shells into inner regions with local transforms.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Relay Controls',
            subtitle: 'Outer shell size and relay behavior.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'outer width',
                  value: _relayOuterWidth,
                  min: 340,
                  max: 980,
                  divisions: 16,
                  color: _p.primary,
                  display: _relayOuterWidth.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _relayOuterWidth = v),
                ),
                _sliderRow(
                  label: 'outer height',
                  value: _relayOuterHeight,
                  min: 260,
                  max: 620,
                  divisions: 18,
                  color: _p.secondary,
                  display: _relayOuterHeight.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _relayOuterHeight = v),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _relayChip('Stable', _RelayMode.stable),
                    _relayChip('Pulsing', _RelayMode.pulsing),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _relayNotes,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _relayNotes = v ?? true),
                    ),
                    Text('show relay notes',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Relay View',
            subtitle: 'Outer, middle, and inner constraints.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Center(
              child: SizedBox(
                width: _relayOuterWidth,
                height: _relayOuterHeight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: _p.muted.withValues(alpha: 0.24)),
                  ),
                  child: LayoutBuilder(
                    builder: (context, outer) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _chip('outerW', outer.maxWidth.toStringAsFixed(0), _p.primary),
                                const SizedBox(width: 6),
                                _chip('outerH', outer.maxHeight.toStringAsFixed(0), _p.secondary),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, mid) {
                                  final scale = _relayMode == _RelayMode.pulsing ? 0.82 : 0.92;
                                  return Center(
                                    child: SizedBox(
                                      width: mid.maxWidth * scale,
                                      height: mid.maxHeight * scale,
                                      child: LayoutBuilder(
                                        builder: (context, inner) {
                                          return _relayInnerScene(inner);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          if (_relayNotes) ...[
            const SizedBox(height: 12),
            _card(
              title: 'Relay Notes',
              subtitle: 'Constraint propagation reminders.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bullet('Each nested builder receives transformed constraints.'),
                  _bullet('Branch labels help debug transitions quickly.'),
                  _bullet('Keep relay layers small and purpose-specific.'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _relayChip(String label, _RelayMode mode) {
    return ChoiceChip(
      selected: _relayMode == mode,
      selectedColor: _p.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _relayMode == mode ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11.4,
      ),
      onSelected: (_) => setState(() => _relayMode = mode),
    );
  }

  Widget _relayInnerScene(BoxConstraints inner) {
    final decision = _classifyWidth(inner.maxWidth);
    return Container(
      decoration: BoxDecoration(
        color: _p.secondary.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(9),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _chip('innerW', inner.maxWidth.toStringAsFixed(0), _p.primary),
              const SizedBox(width: 6),
              _chip('decision', decision, _p.secondary),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(child: _relayDecisionBody(decision)),
        ],
      ),
    );
  }

  Widget _relayDecisionBody(String decision) {
    if (decision == 'single') {
      return Column(
        children: [
          for (var i = 0; i < 5; i++) Expanded(child: _relayTile(i, decision)),
        ],
      );
    }
    if (decision == 'dual') {
      return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                for (var i = 0; i < 4; i++) Expanded(child: _relayTile(i, decision)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                for (var i = 4; i < 8; i++) Expanded(child: _relayTile(i, decision)),
              ],
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        for (var lane = 0; lane < 3; lane++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: lane == 2 ? 0 : 8),
              child: Column(
                children: [
                  for (var i = 0; i < 3; i++)
                    Expanded(child: _relayTile(lane * 3 + i, decision)),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _relayTile(int index, String decision) {
    final tone = index.isEven ? _p.primary : _p.secondary;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Node ${index + 1} ($decision)',
          style: TextStyle(
            color: _p.ink,
            fontWeight: FontWeight.w700,
            fontSize: 10.8,
          ),
        ),
      ),
    );
  }

  Widget _theaterStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Device Theater'),
          const SizedBox(height: 8),
          Text(
            'Apply the same constraint logic across device shell sizes to '
            'validate consistency and transition quality.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.35),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Theater Controls',
            subtitle: 'Preset trio or custom shell.',
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _theaterTrio,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _theaterTrio = v ?? true),
                    ),
                    Text('show preset trio',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                  ],
                ),
                _sliderRow(
                  label: 'custom width',
                  value: _theaterCustomWidth,
                  min: 320,
                  max: 1080,
                  divisions: 19,
                  color: _p.primary,
                  display: _theaterCustomWidth.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _theaterCustomWidth = v),
                ),
                _sliderRow(
                  label: 'custom height',
                  value: _theaterCustomHeight,
                  min: 340,
                  max: 760,
                  divisions: 21,
                  color: _p.secondary,
                  display: _theaterCustomHeight.toStringAsFixed(0),
                  onChanged: (v) => setState(() => _theaterCustomHeight = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _theaterMetrics,
                      activeColor: _p.secondary,
                      onChanged: (v) => setState(() => _theaterMetrics = v ?? true),
                    ),
                    Text('show metrics',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_theaterTrio)
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final shell in _shellProfiles) _shellCard(shell),
              ],
            )
          else
            _shellCard(
              _ShellProfile(
                label: 'Custom',
                width: _theaterCustomWidth,
                height: _theaterCustomHeight,
                note: 'User-defined shell profile.',
              ),
            ),
        ],
      ),
    );
  }

  Widget _shellCard(_ShellProfile shell) {
    return SizedBox(
      width: shell.width > 500 ? 440 : 360,
      child: _card(
        title: '${shell.label} shell',
        subtitle:
            'w ${shell.width.toStringAsFixed(0)} | h ${shell.height.toStringAsFixed(0)} | ${shell.note}',
        tint: _p.primary.withValues(alpha: 0.04),
        child: SizedBox(
          width: shell.width,
          height: shell.height,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final decision = _classifyWidth(constraints.maxWidth);
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: _relayDecisionBody(decision),
                      ),
                    ),
                    if (_theaterMetrics)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: _chip('decision', decision, _p.secondary),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _verificationStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Verification Compendium'),
          const SizedBox(height: 12),
          _card(
            title: 'AbstractLayoutBuilder Matrix',
            subtitle: 'Concept and usage summary.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'What it is',
                  value:
                      'Abstract base pattern for widgets that build based on incoming constraints.',
                ),
                _matrixRow(
                  keyText: 'Concrete examples',
                  value:
                      'LayoutBuilder (box constraints) and SliverLayoutBuilder (sliver constraints).',
                ),
                _matrixRow(
                  keyText: 'Core input',
                  value: 'Parent-provided constraints during layout.',
                ),
                _matrixRow(
                  keyText: 'Primary benefit',
                  value: 'Deterministic adaptive structure based on real available space.',
                ),
                _matrixRow(
                  keyText: 'Best practice',
                  value: 'Keep breakpoints explicit and branch behavior coherent.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do and Dont',
            subtitle: 'Constraint-driven architecture guidance.',
            child: Column(
              children: [
                _doDont(
                  good: true,
                  title: 'Drive structural choices from constraints',
                  detail:
                      'Adapt layout branches to width and height bands consistently.',
                ),
                _doDont(
                  good: false,
                  title: 'Scatter random breakpoints everywhere',
                  detail:
                      'Centralize thresholds to avoid conflicting adaptive behavior.',
                ),
                _doDont(
                  good: true,
                  title: 'Expose metrics while developing',
                  detail:
                      'Constraint chips and labels speed up debugging.',
                ),
                _doDont(
                  good: false,
                  title: 'Place side effects in builder callbacks',
                  detail: 'Builder closures should focus on pure UI decisions.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common constraint-builder questions.',
            child: Column(
              children: [
                _qa(
                  q: 'Can I instantiate AbstractLayoutBuilder directly?',
                  a: 'No. It is abstract; use concrete widgets such as LayoutBuilder.',
                ),
                _qa(
                  q: 'When should I use SliverLayoutBuilder?',
                  a: 'When decisions depend on sliver constraints in CustomScrollView.',
                ),
                _qa(
                  q: 'Should I nest multiple LayoutBuilders?',
                  a: 'Yes, when each layer has a clear adaptive responsibility.',
                ),
                _qa(
                  q: 'How do I debug wrong branch selection?',
                  a: 'Display incoming constraint values and compare them to breakpoint rules.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo completion criteria.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Snapshot stage demonstrates direct BoxConstraints decisions.'),
                _check('Breakpoint stage demonstrates width-band structure switching.'),
                _check('Sliver stage demonstrates SliverLayoutBuilder branching.'),
                _check('Relay stage demonstrates nested constraint propagation.'),
                _check('Theater stage validates behavior across shell profiles.'),
                _check('Compendium includes matrix, do and dont, FAQ, and checklist.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'AbstractLayoutBuilder is the adaptive architecture pattern: '
            'observe constraints, branch intentionally, and keep outcomes clear.',
          ),
        ],
      ),
    );
  }

  Widget _aside({required String title, required String detail}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _p.accent.withValues(alpha: 0.13),
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
          const SizedBox(height: 6),
          Text(
            detail,
            style: TextStyle(
              color: _p.muted,
              fontSize: 11.2,
              height: 1.32,
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
        border: Border.all(color: color.withValues(alpha: 0.34)),
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
                fontFamily: 'monospace',
                fontSize: 11.3,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.32),
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
        border: Border.all(color: tone.withValues(alpha: 0.27)),
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
            fontWeight: FontWeight.w800,
            fontSize: 18,
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
              fontWeight: FontWeight.w800,
              fontSize: 14,
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

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _p.ink.withValues(alpha: 0.05),
      child: Row(
        children: [
          Text(
            _stageNames[_stage.index],
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

class _GuidePainter extends CustomPainter {
  final Color color;
  final double spacing;

  const _GuidePainter({required this.color, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var x = 0.0;
    while (x <= size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += spacing;
    }

    var y = 0.0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += spacing;
    }
  }

  @override
  bool shouldRepaint(covariant _GuidePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.spacing != spacing;
  }
}
