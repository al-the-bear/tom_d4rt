import 'dart:math' as math;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _CenterGeometryAtlasDemo();
}

enum _Stage {
  primer,
  alignContrast,
  factorLab,
  constraints,
  nesting,
  compendium,
}

enum _Backdrop {
  aurora,
  grid,
  orbit,
}

class _Palette {
  final String name;
  final Color shell;
  final Color paper;
  final Color panel;
  final Color ink;
  final Color muted;
  final Color accentA;
  final Color accentB;
  final Color accentC;

  const _Palette({
    required this.name,
    required this.shell,
    required this.paper,
    required this.panel,
    required this.ink,
    required this.muted,
    required this.accentA,
    required this.accentB,
    required this.accentC,
  });
}

const _palettes = <_Palette>[
  _Palette(
    name: 'Harbor Draft',
    shell: Color(0xFF132733),
    paper: Color(0xFFF2F8FC),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF1F3745),
    muted: Color(0xFF6E8797),
    accentA: Color(0xFF1E85DE),
    accentB: Color(0xFF1B9A78),
    accentC: Color(0xFFD08F20),
  ),
  _Palette(
    name: 'Meadow Draft',
    shell: Color(0xFF1A241E),
    paper: Color(0xFFF4FAF5),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF2A372F),
    muted: Color(0xFF748679),
    accentA: Color(0xFF2F8E3D),
    accentB: Color(0xFF1F8F97),
    accentC: Color(0xFFB88627),
  ),
  _Palette(
    name: 'Copper Draft',
    shell: Color(0xFF2B221D),
    paper: Color(0xFFFDF5ED),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF3A2F28),
    muted: Color(0xFF8B7C73),
    accentA: Color(0xFFB86433),
    accentB: Color(0xFF2E89A3),
    accentC: Color(0xFF998416),
  ),
];

class _AxisPreset {
  final String name;
  final Alignment alignment;
  final IconData icon;

  const _AxisPreset({
    required this.name,
    required this.alignment,
    required this.icon,
  });
}

class _ScenarioCard {
  final String id;
  final String title;
  final String detail;
  final IconData icon;
  final Color tone;

  const _ScenarioCard({
    required this.id,
    required this.title,
    required this.detail,
    required this.icon,
    required this.tone,
  });
}

class _Event {
  final DateTime at;
  final String lane;
  final String message;
  final Color tone;

  const _Event({
    required this.at,
    required this.lane,
    required this.message,
    required this.tone,
  });
}

const _stageNames = <String>[
  '1 Primer Studio',
  '2 Center vs Align',
  '3 Factor Lab',
  '4 Constraint Theater',
  '5 Nesting Observatory',
  '6 Verification Compendium',
];

const _alignmentPresets = <_AxisPreset>[
  _AxisPreset(name: 'Center', alignment: Alignment.center, icon: Icons.filter_center_focus),
  _AxisPreset(name: 'Top Left', alignment: Alignment.topLeft, icon: Icons.north_west),
  _AxisPreset(name: 'Top', alignment: Alignment.topCenter, icon: Icons.arrow_upward),
  _AxisPreset(name: 'Top Right', alignment: Alignment.topRight, icon: Icons.north_east),
  _AxisPreset(name: 'Left', alignment: Alignment.centerLeft, icon: Icons.keyboard_arrow_left),
  _AxisPreset(name: 'Right', alignment: Alignment.centerRight, icon: Icons.keyboard_arrow_right),
  _AxisPreset(name: 'Bottom Left', alignment: Alignment.bottomLeft, icon: Icons.south_west),
  _AxisPreset(name: 'Bottom', alignment: Alignment.bottomCenter, icon: Icons.arrow_downward),
  _AxisPreset(name: 'Bottom Right', alignment: Alignment.bottomRight, icon: Icons.south_east),
];

class _CenterGeometryAtlasDemo extends StatefulWidget {
  const _CenterGeometryAtlasDemo();

  @override
  State<_CenterGeometryAtlasDemo> createState() => _CenterGeometryAtlasDemoState();
}

class _CenterGeometryAtlasDemoState extends State<_CenterGeometryAtlasDemo> {
  _Stage _stage = _Stage.primer;
  int _paletteIndex = 0;
  _Backdrop _backdrop = _Backdrop.aurora;

  bool _showTimeline = true;
  bool _showGuidance = true;
  bool _showMetrics = true;
  bool _verbose = false;
  bool _showAxisCrosshair = true;

  double _parentWidth = 420;
  double _parentHeight = 280;
  double _childSize = 96;

  bool _factorWidthEnabled = false;
  bool _factorHeightEnabled = false;
  double _factorWidth = 1.6;
  double _factorHeight = 1.4;

  int _alignPresetIndex = 0;
  int _constraintScenario = 0;
  int _nestDepth = 4;
  bool _animatePulse = true;

  int _tapEvents = 0;
  int _controlChanges = 0;
  int _modeChanges = 0;

  final List<_Event> _events = <_Event>[];

  _Palette get _p => _palettes[_paletteIndex];

  List<_ScenarioCard> get _scenarios => <_ScenarioCard>[
        _ScenarioCard(
          id: 'tight',
          title: 'Tight Box Parent',
          detail: 'Center receives tight constraints and positions child at midpoint.',
          icon: Icons.crop_square,
          tone: _p.accentA,
        ),
        _ScenarioCard(
          id: 'stack',
          title: 'Stack Overlay Parent',
          detail: 'Center overlays a single focal child above decorative layers.',
          icon: Icons.layers_outlined,
          tone: _p.accentB,
        ),
        _ScenarioCard(
          id: 'column',
          title: 'Column + Expanded',
          detail: 'Center fills expanded area and centers child in remaining space.',
          icon: Icons.view_column,
          tone: _p.accentC,
        ),
        _ScenarioCard(
          id: 'scroll',
          title: 'Scrollable Deck',
          detail: 'Center in cards to isolate focal points in long vertical compositions.',
          icon: Icons.unfold_more,
          tone: _p.accentA,
        ),
      ];

  @override
  void initState() {
    super.initState();
    _log('system', 'Center geometry atlas initialized.', _p.accentA);
  }

  void _log(String lane, String message, Color tone) {
    final event = _Event(at: DateTime.now(), lane: lane, message: message, tone: tone);
    setState(() {
      _events.insert(0, event);
      if (_events.length > 160) {
        _events.removeRange(160, _events.length);
      }
    });
    if (_verbose) {
      debugPrint('[Center][$lane] $message');
    }
  }

  void _recordControl(String lane, String message) {
    setState(() => _controlChanges += 1);
    _log(lane, message, _p.accentB);
  }

  void _recordTap(String lane, String message) {
    setState(() => _tapEvents += 1);
    _log(lane, message, _p.accentA);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.paper,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _header(),
            _toolbar(),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: _stageBody()),
                  if (_showTimeline) SizedBox(width: 370, child: _timelinePanel()),
                ],
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.shell, _p.accentA.withValues(alpha: 0.86)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.center_focus_strong, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Center Geometry Atlas',
                  style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Single Child Positioning Widget',
                  style: TextStyle(color: Colors.white, fontSize: 10.2, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Center positions one child at the middle of itself. This deep demo explores geometry behavior, '
            'constraint interactions, widthFactor and heightFactor scaling, and composition patterns in practical UI scenes.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.95), fontSize: 12.2, height: 1.34),
          ),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      width: double.infinity,
      color: _p.accentA.withValues(alpha: 0.08),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text('Stage', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _stageNames.length; i++) _stageChip(i),
          const SizedBox(width: 10),
          Text('Palette', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
          const SizedBox(width: 10),
          _toggleChip('timeline', _showTimeline, (v) => _showTimeline = v),
          _toggleChip('guidance', _showGuidance, (v) => _showGuidance = v),
          _toggleChip('metrics', _showMetrics, (v) => _showMetrics = v),
          _toggleChip('crosshair', _showAxisCrosshair, (v) => _showAxisCrosshair = v),
          _toggleChip('verbose', _verbose, (v) => _verbose = v),
        ],
      ),
    );
  }

  Widget _stageChip(int index) {
    final active = _stage.index == index;
    return ChoiceChip(
      selected: active,
      selectedColor: _p.accentA,
      backgroundColor: Colors.white,
      label: Text('${index + 1}'),
      labelStyle: TextStyle(color: active ? Colors.white : _p.ink, fontSize: 11, fontWeight: FontWeight.w700),
      onSelected: (_) {
        setState(() => _stage = _Stage.values[index]);
        _log('stage', 'Switched to ${_stageNames[index]}', _p.accentB);
      },
    );
  }

  Widget _paletteDot(int index) {
    return GestureDetector(
      onTap: () {
        setState(() => _paletteIndex = index);
        _log('palette', 'Palette changed to ${_palettes[index].name}', _palettes[index].accentA);
      },
      child: Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _palettes[index].accentA,
          border: Border.all(color: _paletteIndex == index ? _palettes[index].accentC : Colors.transparent, width: 2),
        ),
      ),
    );
  }

  Widget _toggleChip(String label, bool value, void Function(bool v) assign) {
    return FilterChip(
      selected: value,
      label: Text(label),
      backgroundColor: Colors.white,
      selectedColor: _p.accentA.withValues(alpha: 0.19),
      checkmarkColor: _p.accentA,
      labelStyle: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11),
      onSelected: (selected) => setState(() => assign(selected)),
    );
  }

  Widget _stageBody() {
    switch (_stage) {
      case _Stage.primer:
        return _primerStage();
      case _Stage.alignContrast:
        return _alignContrastStage();
      case _Stage.factorLab:
        return _factorLabStage();
      case _Stage.constraints:
        return _constraintStage();
      case _Stage.nesting:
        return _nestingStage();
      case _Stage.compendium:
        return _compendiumStage();
    }
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(color: _p.ink, fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.2),
    );
  }

  Widget _panel({required String title, required String subtitle, required Widget child, Color? tint}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tint ?? _p.panel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _p.muted.withValues(alpha: 0.22)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: _p.shell.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 12.8)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 10.8, height: 1.33)),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _primerStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Primer Studio'),
          const SizedBox(height: 8),
          Text(
            'Center places one child in the middle of available space. This primer exposes parent dimensions '
            'and child size so you can see geometric centering behavior directly.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Geometry Controls',
            subtitle: 'Tune parent width/height and child size.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'parent width',
                  value: _parentWidth,
                  min: 260,
                  max: 560,
                  divisions: 30,
                  tone: _p.accentA,
                  onChanged: (v) {
                    setState(() => _parentWidth = v);
                    _recordControl('primer', 'Parent width -> ${v.toStringAsFixed(0)}');
                  },
                ),
                _slider(
                  label: 'parent height',
                  value: _parentHeight,
                  min: 180,
                  max: 430,
                  divisions: 25,
                  tone: _p.accentB,
                  onChanged: (v) {
                    setState(() => _parentHeight = v);
                    _recordControl('primer', 'Parent height -> ${v.toStringAsFixed(0)}');
                  },
                ),
                _slider(
                  label: 'child size',
                  value: _childSize,
                  min: 48,
                  max: 180,
                  divisions: 22,
                  tone: _p.accentC,
                  onChanged: (v) {
                    setState(() => _childSize = v);
                    _recordControl('primer', 'Child size -> ${v.toStringAsFixed(1)}');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Center Geometry Surface',
                  subtitle: 'Tap child to log geometry interactions.',
                  tint: _p.accentA.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 460,
                    child: _deviceFrame(
                      title: 'Center baseline',
                      caption: '${_parentWidth.toStringAsFixed(0)} x ${_parentHeight.toStringAsFixed(0)}',
                      child: Center(
                        child: Container(
                          width: _parentWidth,
                          height: _parentHeight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: _p.muted.withValues(alpha: 0.35), width: 2),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(child: _background(_backdrop)),
                              if (_showAxisCrosshair) Positioned.fill(child: CustomPaint(painter: _CrosshairPainter(color: _p.ink.withValues(alpha: 0.24)))),
                              Center(
                                child: GestureDetector(
                                  onTap: () => _recordTap('primer', 'Tapped centered child'),
                                  child: Container(
                                    width: _childSize,
                                    height: _childSize,
                                    decoration: BoxDecoration(
                                      color: _p.accentA.withValues(alpha: 0.25),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: _p.accentA.withValues(alpha: 0.55), width: 2),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(color: _p.accentA.withValues(alpha: 0.18), blurRadius: 12, spreadRadius: 2),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.center_focus_strong, color: _p.ink, size: 20),
                                        const SizedBox(height: 3),
                                        Text('center', style: TextStyle(color: _p.ink, fontSize: 10.7, fontWeight: FontWeight.w800)),
                                      ],
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
              ),
              if (_showGuidance) ...<Widget>[
                const SizedBox(width: 12),
                SizedBox(
                  width: 340,
                  child: _panel(
                    title: 'Primer Notes',
                    subtitle: 'What this baseline demonstrates.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('Center always aligns its child to the exact midpoint of its own box.'),
                        _bullet('Unlike layout collections, Center handles exactly one child.'),
                        _bullet('Crosshair overlay reveals geometric midpoint regardless of parent size.'),
                        _bullet('The child can be any widget; Center only controls position and optional factors.'),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (_showMetrics) ...<Widget>[
            const SizedBox(height: 12),
            _metricsPanel(),
          ],
        ],
      ),
    );
  }

  Widget _alignContrastStage() {
    final preset = _alignmentPresets[_alignPresetIndex];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Center vs Align Contrast'),
          const SizedBox(height: 8),
          Text(
            'Center is a specialized Align for the centered case. This comparison clarifies where Center is concise '
            'and where Align is needed for custom alignment.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Alignment Presets (for Align side)',
            subtitle: 'Center side stays centered; Align side follows selected preset.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (var i = 0; i < _alignmentPresets.length; i++)
                  ChoiceChip(
                    selected: _alignPresetIndex == i,
                    label: Text(_alignmentPresets[i].name),
                    avatar: Icon(_alignmentPresets[i].icon, size: 16),
                    onSelected: (_) {
                      setState(() => _alignPresetIndex = i);
                      _recordControl('align', 'Align preset -> ${_alignmentPresets[i].name}');
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Center Widget',
                  subtitle: 'Always midpoint, no alignment parameter.',
                  tint: _p.accentA.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 440,
                    child: _deviceFrame(
                      title: 'Center side',
                      caption: 'fixed midpoint',
                      child: Center(
                        child: _alignmentBoard(
                          label: 'Center',
                          body: Center(child: _tokenBox('CENTER', _p.accentA)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _panel(
                  title: 'Align Widget',
                  subtitle: 'Uses selected alignment preset: ${preset.name}.',
                  tint: _p.accentB.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 440,
                    child: _deviceFrame(
                      title: 'Align side',
                      caption: preset.name,
                      child: Center(
                        child: _alignmentBoard(
                          label: 'Align(${preset.name})',
                          body: Align(alignment: preset.alignment, child: _tokenBox('ALIGN', _p.accentB)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showGuidance) ...<Widget>[
            const SizedBox(height: 12),
            _panel(
              title: 'Takeaway',
              subtitle: 'Center simplicity vs Align flexibility.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _bullet('Use Center when your intent is always midpoint placement.'),
                  _bullet('Use Align when alignment must vary across edges/corners.'),
                  _bullet('Center communicates layout intent clearly in UI code and demos.'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _alignmentBoard({required String label, required Widget body}) {
    return Container(
      width: 370,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.muted.withValues(alpha: 0.32), width: 2),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: _background(_backdrop)),
          if (_showAxisCrosshair) Positioned.fill(child: CustomPaint(painter: _CrosshairPainter(color: _p.ink.withValues(alpha: 0.22)))),
          Positioned(
            left: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.85), borderRadius: BorderRadius.circular(999)),
              child: Text(label, style: TextStyle(color: _p.ink, fontSize: 10.3, fontWeight: FontWeight.w700)),
            ),
          ),
          Positioned.fill(child: body),
        ],
      ),
    );
  }

  Widget _tokenBox(String text, Color tone) {
    return GestureDetector(
      onTap: () => _recordTap('align', 'Tapped $text token'),
      child: Container(
        width: _childSize,
        height: _childSize,
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: tone.withValues(alpha: 0.6), width: 2),
        ),
        child: Center(child: Text(text, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 11))),
      ),
    );
  }

  Widget _factorLabStage() {
    final widthFactor = _factorWidthEnabled ? _factorWidth : null;
    final heightFactor = _factorHeightEnabled ? _factorHeight : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Factor Lab'),
          const SizedBox(height: 8),
          Text(
            'Center can optionally scale its own dimensions by widthFactor and heightFactor relative to child size.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Factor Controls',
            subtitle: 'Enable factors and adjust multipliers.',
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _toggleChip('widthFactor enabled', _factorWidthEnabled, (v) {
                      _factorWidthEnabled = v;
                      _recordControl('factor', 'widthFactor enabled -> $v');
                    }),
                    _toggleChip('heightFactor enabled', _factorHeightEnabled, (v) {
                      _factorHeightEnabled = v;
                      _recordControl('factor', 'heightFactor enabled -> $v');
                    }),
                  ],
                ),
                _slider(
                  label: 'widthFactor',
                  value: _factorWidth,
                  min: 0.8,
                  max: 3.0,
                  divisions: 22,
                  tone: _p.accentA,
                  onChanged: (v) {
                    setState(() => _factorWidth = v);
                    _recordControl('factor', 'widthFactor -> ${v.toStringAsFixed(2)}');
                  },
                ),
                _slider(
                  label: 'heightFactor',
                  value: _factorHeight,
                  min: 0.8,
                  max: 3.0,
                  divisions: 22,
                  tone: _p.accentB,
                  onChanged: (v) {
                    setState(() => _factorHeight = v);
                    _recordControl('factor', 'heightFactor -> ${v.toStringAsFixed(2)}');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Width/Height Factor Surface',
                  subtitle: 'Visualized with an explicit debug frame around Center itself.',
                  tint: _p.accentC.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 460,
                    child: _deviceFrame(
                      title: 'Factor geometry',
                      caption: 'w=${widthFactor?.toStringAsFixed(2) ?? 'null'} h=${heightFactor?.toStringAsFixed(2) ?? 'null'}',
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            children: <Widget>[
                              Positioned.fill(child: _background(_backdrop)),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: _p.accentC.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: _p.accentC.withValues(alpha: 0.4), width: 2),
                                  ),
                                  child: Center(
                                    widthFactor: widthFactor,
                                    heightFactor: heightFactor,
                                    child: GestureDetector(
                                      onTap: () => _recordTap('factor', 'Tapped factor child'),
                                      child: Container(
                                        width: _childSize,
                                        height: _childSize,
                                        decoration: BoxDecoration(
                                          color: _p.accentA.withValues(alpha: 0.26),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: _p.accentA.withValues(alpha: 0.58), width: 2),
                                        ),
                                        child: const Center(child: Icon(Icons.crop_free, size: 22)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 12,
                                bottom: 12,
                                child: _measureBadge(
                                  'viewport: ${constraints.maxWidth.toStringAsFixed(0)} x ${constraints.maxHeight.toStringAsFixed(0)}',
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              if (_showGuidance) ...<Widget>[
                const SizedBox(width: 12),
                SizedBox(
                  width: 350,
                  child: _panel(
                    title: 'Factor Interpretation',
                    subtitle: 'How factors affect Center dimensions.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('When null, factor is ignored and Center expands as allowed by parent.'),
                        _bullet('When set, Center size on that axis becomes childSize × factor.'),
                        _bullet('Factor is useful for controlled centering boxes around compact children.'),
                        _bullet('In tight constraints, factors may be limited by parent bounds.'),
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

  Widget _constraintStage() {
    final scenario = _scenarios[_constraintScenario];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Constraint Theater'),
          const SizedBox(height: 8),
          Text(
            'Center behavior depends on parent constraints. This stage cycles through parent architectures to '
            'show how centering behaves in real composition patterns.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Scenario Selector',
            subtitle: 'Each card renders Center inside a different parent layout model.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (var i = 0; i < _scenarios.length; i++)
                  ChoiceChip(
                    selected: _constraintScenario == i,
                    label: Text(_scenarios[i].title),
                    avatar: Icon(_scenarios[i].icon, size: 16),
                    onSelected: (_) {
                      setState(() => _constraintScenario = i);
                      _modeChanges += 1;
                      _log('constraint', 'Scenario -> ${_scenarios[i].title}', _scenarios[i].tone);
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: scenario.title,
                  subtitle: scenario.detail,
                  tint: scenario.tone.withValues(alpha: 0.06),
                  child: SizedBox(
                    height: 500,
                    child: _deviceFrame(
                      title: 'Constraint stage',
                      caption: scenario.id,
                      child: _constraintScene(scenario.id),
                    ),
                  ),
                ),
              ),
              if (_showGuidance) ...<Widget>[
                const SizedBox(width: 12),
                SizedBox(
                  width: 350,
                  child: _panel(
                    title: 'Constraint Notes',
                    subtitle: 'Scenario-specific insight for Center usage.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('Tight constraints: Center fills parent then centers child inside.'),
                        _bullet('Stack overlays: Center is ideal for focal overlays above layers.'),
                        _bullet('Expanded columns: Center occupies flexed area and centers once constraints resolve.'),
                        _bullet('Scrollable cards: Center keeps each card focal content balanced.'),
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

  Widget _constraintScene(String id) {
    switch (id) {
      case 'tight':
        return Container(
          color: Colors.white,
          child: Center(
            child: GestureDetector(
              onTap: () => _recordTap('constraint-tight', 'Tapped tight scenario child'),
              child: _featureTile('Tight Parent', _p.accentA),
            ),
          ),
        );
      case 'stack':
        return Stack(
          children: <Widget>[
            Positioned.fill(child: _background(_backdrop)),
            Positioned(left: 20, top: 20, child: _badgeBubble('Layer A', _p.accentA)),
            Positioned(right: 24, bottom: 26, child: _badgeBubble('Layer B', _p.accentB)),
            Center(
              child: GestureDetector(
                onTap: () => _recordTap('constraint-stack', 'Tapped stack center tile'),
                child: _featureTile('Stack Focus', _p.accentC),
              ),
            ),
          ],
        );
      case 'column':
        return Column(
          children: <Widget>[
            Container(
              height: 80,
              color: _p.accentA.withValues(alpha: 0.16),
              alignment: Alignment.center,
              child: Text('Header Region', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700)),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: GestureDetector(
                    onTap: () => _recordTap('constraint-column', 'Tapped column center tile'),
                    child: _featureTile('Expanded Center', _p.accentB),
                  ),
                ),
              ),
            ),
            Container(
              height: 66,
              color: _p.accentC.withValues(alpha: 0.16),
              alignment: Alignment.center,
              child: Text('Footer Region', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700)),
            ),
          ],
        );
      case 'scroll':
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              height: 120,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: index.isEven ? _p.accentA.withValues(alpha: 0.1) : _p.accentB.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () => _recordTap('constraint-scroll', 'Tapped card ${index + 1} center'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: _p.muted.withValues(alpha: 0.28)),
                    ),
                    child: Text('Card ${index + 1} center', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _nestingStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Nesting Observatory'),
          const SizedBox(height: 8),
          Text(
            'Nested Center widgets can create deliberate concentric compositions for dashboards, medals, and focus targets.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Nesting Controls',
            subtitle: 'Adjust depth and pulse mode.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                SizedBox(
                  width: 260,
                  child: _sliderInline(
                    label: 'depth',
                    value: _nestDepth.toDouble(),
                    min: 2,
                    max: 8,
                    divisions: 6,
                    tone: _p.accentA,
                    onChanged: (v) {
                      setState(() => _nestDepth = v.round());
                      _recordControl('nesting', 'Depth -> ${v.round()}');
                    },
                  ),
                ),
                _toggleChip('pulse animation', _animatePulse, (v) {
                  _animatePulse = v;
                  _recordControl('nesting', 'Pulse animation -> $v');
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Concentric Center Composition',
            subtitle: 'Each ring is a Center containing the next ring.',
            tint: _p.accentB.withValues(alpha: 0.05),
            child: SizedBox(
              height: 520,
              child: _deviceFrame(
                title: 'Center nesting',
                caption: 'depth $_nestDepth',
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(child: _background(_backdrop)),
                    Positioned.fill(
                      child: _buildNestedCenters(_nestDepth, 320),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: _measureBadge('tap central node'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_showGuidance) ...<Widget>[
            const SizedBox(height: 12),
            _panel(
              title: 'Nesting Guidance',
              subtitle: 'Where nested Center is useful.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _bullet('Use nested Center for concentric motifs like badges and radial dashboards.'),
                  _bullet('Prefer simple composition depth; very deep trees can be harder to read.'),
                  _bullet('Mix colors and subtle scale differences to explain spatial hierarchy.'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNestedCenters(int depth, double size) {
    if (depth <= 1) {
      return Center(
        child: GestureDetector(
          onTap: () => _recordTap('nesting', 'Tapped core center node'),
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _p.accentC.withValues(alpha: 0.36),
              shape: BoxShape.circle,
              border: Border.all(color: _p.accentC.withValues(alpha: 0.7), width: 2),
            ),
            child: const Center(child: Icon(Icons.radio_button_checked, size: 18)),
          ),
        ),
      );
    }

    final ratio = depth / _nestDepth;
    final tone = Color.lerp(_p.accentA, _p.accentC, 1 - ratio) ?? _p.accentA;
    final boxSize = size.clamp(80.0, 520.0);
    final innerSize = boxSize * 0.78;

    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: _animatePulse ? 380 + depth * 40 : 0),
        curve: Curves.easeInOut,
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.08 + (1 - ratio) * 0.06),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: tone.withValues(alpha: 0.42), width: 2),
        ),
        child: _buildNestedCenters(depth - 1, innerSize),
      ),
    );
  }

  Widget _compendiumStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Verification Compendium'),
          const SizedBox(height: 12),
          _panel(
            title: 'Center Coverage Matrix',
            subtitle: 'What this deep demo verified visually and interactively.',
            child: Column(
              children: <Widget>[
                _matrix('Core purpose', 'Center one child inside available parent area.'),
                _matrix('Comparison', 'Center equals Align at midpoint but without variable alignment.'),
                _matrix('Factors', 'widthFactor and heightFactor scale Center size relative to child size.'),
                _matrix('Constraints', 'Parent constraints shape Center box before child positioning occurs.'),
                _matrix('Composition', 'Center works in Stack, Column, ListView cards, and concentric nesting.'),
                _matrix('Debug strategy', 'Crosshair overlays and timeline logs make geometric behavior visible.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Production guidance for Center usage.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do use Center when midpoint placement is the intent',
                  detail: 'This keeps layout declarations explicit and readable.',
                ),
                _doDont(
                  good: true,
                  title: 'Do use widthFactor and heightFactor intentionally',
                  detail: 'Factors are useful for controlled box sizing around compact widgets.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont use Center when you need non-midpoint alignment',
                  detail: 'Switch to Align for top/left/right/corner placement.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont assume unconstrained parents in all contexts',
                  detail: 'Always inspect parent constraints when center behavior looks unexpected.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common Center questions answered.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'When should I choose Center over Align?',
                  a: 'Choose Center when alignment is always midpoint and no parameterized alignment is needed.',
                ),
                _qa(
                  q: 'Do factors resize the child?',
                  a: 'No. Factors resize the Center box relative to child dimensions; the child keeps its own size.',
                ),
                _qa(
                  q: 'Why can centered content still look off?',
                  a: 'Parent constraints, padding, and visual asymmetry can make midpoint placement appear unbalanced.',
                ),
                _qa(
                  q: 'Can I nest Center many times?',
                  a: 'Yes, though moderate depth is better for maintainability and rendering clarity.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Completion Checklist',
            subtitle: 'Deep demo delivery checks for this file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Multiple visual stages demonstrate Center in distinct contexts.'),
                _check('Interactive controls explain geometry and factor behavior.'),
                _check('Center vs Align comparison clarifies class purpose boundaries.'),
                _check('Constraint-driven examples show realistic composition usage.'),
                _check('Instructional compendium provides practical usage guidance.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _p.accentC.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _p.accentC.withValues(alpha: 0.3)),
            ),
            child: Text(
              'Center is deceptively simple but fundamental to balanced visual composition. '
              'This atlas demonstrates how centering logic behaves across sizing factors, constraints, and nesting patterns, '
              'providing a practical interpreter-focused reference for layout behavior validation.',
              style: TextStyle(color: _p.ink, fontSize: 11.8, height: 1.36),
            ),
          ),
        ],
      ),
    );
  }

  Widget _deviceFrame({required String title, required String caption, required Widget child}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _p.muted.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _p.paper,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              border: Border(bottom: BorderSide(color: _p.muted.withValues(alpha: 0.24))),
            ),
            child: Row(
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.muted, fontSize: 10.8)),
                const Spacer(),
                Text(caption, style: TextStyle(color: _p.muted, fontSize: 10.3, fontFamily: 'monospace')),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _background(_Backdrop backdrop) {
    switch (backdrop) {
      case _Backdrop.aurora:
        return _auroraBackground();
      case _Backdrop.grid:
        return _gridBackground();
      case _Backdrop.orbit:
        return _orbitBackground();
    }
  }

  Widget _auroraBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentA.withValues(alpha: 0.24), _p.accentB.withValues(alpha: 0.22)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomPaint(painter: _WavePainter(color: Colors.white.withValues(alpha: 0.2))),
    );
  }

  Widget _gridBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentB.withValues(alpha: 0.22), _p.accentC.withValues(alpha: 0.22)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CustomPaint(painter: _GridPainter(color: Colors.white.withValues(alpha: 0.24))),
    );
  }

  Widget _orbitBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentC.withValues(alpha: 0.23), _p.accentA.withValues(alpha: 0.23)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: CustomPaint(painter: _StarPainter(color: Colors.white.withValues(alpha: 0.18)))),
          Positioned(left: 30, top: 40, child: _orbitRing(94)),
          Positioned(right: 34, top: 70, child: _orbitRing(70)),
          Positioned(left: 120, bottom: 28, child: _orbitRing(118)),
        ],
      ),
    );
  }

  Widget _orbitRing(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withValues(alpha: 0.14), width: 6)),
    );
  }

  Widget _featureTile(String label, Color tone) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tone.withValues(alpha: 0.6), width: 2),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 12),
        ),
      ),
    );
  }

  Widget _badgeBubble(String text, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tone.withValues(alpha: 0.45)),
      ),
      child: Text(text, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 10.7)),
    );
  }

  Widget _measureBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: TextStyle(color: _p.ink, fontSize: 10.1, fontFamily: 'monospace')),
    );
  }

  Widget _slider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color tone,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 160,
          child: Text('$label: ${value.toStringAsFixed(1)}', style: TextStyle(color: _p.ink, fontSize: 12)),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: tone,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _sliderInline({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color tone,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: <Widget>[
        SizedBox(width: 64, child: Text(label, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.3))),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: tone,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _metricsPanel() {
    return _panel(
      title: 'Global Metrics',
      subtitle: 'Interaction counters for this deep demo session.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _metric('tap events', '$_tapEvents', _p.accentA),
          _metric('control changes', '$_controlChanges', _p.accentB),
          _metric('mode changes', '$_modeChanges', _p.accentC),
          _metric('timeline events', '${_events.length}', _p.accentA),
        ],
      ),
    );
  }

  Widget _metric(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(999)),
      child: Text('$label: $value', style: TextStyle(color: _p.ink, fontSize: 10.2, fontWeight: FontWeight.w700)),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.chevron_right, size: 16, color: _p.accentA),
          const SizedBox(width: 4),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 11.1))),
        ],
      ),
    );
  }

  Widget _matrix(String key, String value) {
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
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              key,
              style: TextStyle(color: _p.accentA, fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 10.8),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: _p.ink, fontSize: 11.2, height: 1.33))),
        ],
      ),
    );
  }

  Widget _doDont({required bool good, required String title, required String detail}) {
    final tone = good ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.24)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(good ? Icons.check_circle : Icons.cancel, color: tone, size: 17),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.ink, fontSize: 12, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _p.muted, fontSize: 11.1, height: 1.32)),
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
        children: <Widget>[
          Text('Q: $q', style: TextStyle(color: _p.ink, fontSize: 11.9, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('A: $a', style: TextStyle(color: _p.muted, fontSize: 11.1, height: 1.32)),
        ],
      ),
    );
  }

  Widget _check(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 17),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 11.3))),
        ],
      ),
    );
  }

  Widget _timelinePanel() {
    return Container(
      decoration: BoxDecoration(color: _p.panel, border: Border(left: BorderSide(color: _p.muted.withValues(alpha: 0.25)))),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: _p.accentA.withValues(alpha: 0.08),
              border: Border(bottom: BorderSide(color: _p.muted.withValues(alpha: 0.24))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Center Timeline', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13.2)),
                const SizedBox(height: 4),
                Text('Geometry controls, taps, and mode transitions.', style: TextStyle(color: _p.muted, fontSize: 10.7)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _metric('events', '${_events.length}', _p.accentA),
                    _metric('taps', '$_tapEvents', _p.accentB),
                    _metric('controls', '$_controlChanges', _p.accentC),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: event.tone.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: event.tone.withValues(alpha: 0.24)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              event.lane,
                              style: TextStyle(color: _p.ink, fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 10.3),
                            ),
                          ),
                          Text(
                            _clock(event.at),
                            style: TextStyle(color: _p.muted, fontFamily: 'monospace', fontSize: 10.1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(event.message, style: TextStyle(color: _p.ink, fontSize: 11.1, height: 1.31)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _clock(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    final s = t.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: _p.shell.withValues(alpha: 0.07),
      child: Row(
        children: <Widget>[
          Text(_stageNames[_stage.index], style: TextStyle(color: _p.muted, fontSize: 11, fontWeight: FontWeight.w700)),
          const Spacer(),
          DropdownButton<_Backdrop>(
            value: _backdrop,
            borderRadius: BorderRadius.circular(10),
            items: const <DropdownMenuItem<_Backdrop>>[
              DropdownMenuItem(value: _Backdrop.aurora, child: Text('Aurora')),
              DropdownMenuItem(value: _Backdrop.grid, child: Text('Grid')),
              DropdownMenuItem(value: _Backdrop.orbit, child: Text('Orbit')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _backdrop = value);
                _recordControl('backdrop', 'Backdrop -> $value');
              }
            },
          ),
          const SizedBox(width: 10),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11.1)),
        ],
      ),
    );
  }
}

class _CrosshairPainter extends CustomPainter {
  const _CrosshairPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2;

    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), paint);
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), paint);
    canvas.drawCircle(Offset(cx, cy), 4.2, paint..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant _CrosshairPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _WavePainter extends CustomPainter {
  const _WavePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < 7; i++) {
      final path = Path();
      final baseY = 22.0 + i * 28;
      path.moveTo(0, baseY);
      for (var x = 0.0; x <= size.width; x += 20) {
        final y = baseY + 8 * (i.isEven ? 1 : -1) * math.sin(x / 40);
        path.lineTo(x, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    var x = 0.0;
    while (x <= size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += 24;
    }

    var y = 0.0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += 24;
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _StarPainter extends CustomPainter {
  const _StarPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (var i = 0; i < 72; i++) {
      final dx = (i * 37 % 1000) / 1000 * size.width;
      final dy = (i * 59 % 1000) / 1000 * size.height;
      final radius = 0.7 + ((i * 13 % 10) / 10) * 1.6;
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
