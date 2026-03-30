import 'dart:ui' as ui;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _BackdropGroupDeepDemo();
}

enum _DemoStage {
  fundamentals,
  gallery,
  manualKeys,
  overlapTheater,
  scrollDeck,
  compendium,
}

enum _NoisePattern {
  diagonal,
  circles,
  stripes,
}

class _Palette {
  final String name;
  final Color shell;
  final Color canvas;
  final Color card;
  final Color ink;
  final Color muted;
  final Color accentA;
  final Color accentB;
  final Color accentC;

  const _Palette({
    required this.name,
    required this.shell,
    required this.canvas,
    required this.card,
    required this.ink,
    required this.muted,
    required this.accentA,
    required this.accentB,
    required this.accentC,
  });
}

const _palettes = <_Palette>[
  _Palette(
    name: 'Aqua Slate',
    shell: Color(0xFF14262E),
    canvas: Color(0xFFF1F8FC),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF1F3541),
    muted: Color(0xFF6C8492),
    accentA: Color(0xFF1D8AE3),
    accentB: Color(0xFF1CA179),
    accentC: Color(0xFFD5901B),
  ),
  _Palette(
    name: 'Moss Steel',
    shell: Color(0xFF1A241E),
    canvas: Color(0xFFF3FAF5),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF2A372E),
    muted: Color(0xFF738577),
    accentA: Color(0xFF2F8E3C),
    accentB: Color(0xFF178B8F),
    accentC: Color(0xFFB88626),
  ),
  _Palette(
    name: 'Copper Wave',
    shell: Color(0xFF2A201C),
    canvas: Color(0xFFFCF5EE),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF392E29),
    muted: Color(0xFF8A7B72),
    accentA: Color(0xFFB86435),
    accentB: Color(0xFF2E8AA3),
    accentC: Color(0xFF968414),
  ),
];

class _LogEvent {
  final DateTime at;
  final String lane;
  final String message;
  final Color tone;

  const _LogEvent({
    required this.at,
    required this.lane,
    required this.message,
    required this.tone,
  });
}

class _BackdropGroupDeepDemo extends StatefulWidget {
  const _BackdropGroupDeepDemo();

  @override
  State<_BackdropGroupDeepDemo> createState() => _BackdropGroupDeepDemoState();
}

class _BackdropGroupDeepDemoState extends State<_BackdropGroupDeepDemo> {
  _DemoStage _stage = _DemoStage.fundamentals;
  _NoisePattern _pattern = _NoisePattern.diagonal;
  int _paletteIndex = 0;

  bool _showTimeline = true;
  bool _showGuidance = true;
  bool _showCounters = true;
  bool _verboseLog = false;

  double _sigmaMain = 12;
  double _sigmaSecondary = 20;
  double _glassOpacity = 0.26;
  double _deckCardHeight = 145;
  int _deckItemCount = 9;

  bool _filtersEnabled = true;
  bool _useBlendSrc = false;
  bool _useSharedKeyInOverlap = true;
  bool _manualKeyMirror = false;

  int _manualBlurRequests = 0;
  int _groupedWidgetCount = 0;
  int _manualKeySwitches = 0;

  final BackdropKey _manualKeyA = BackdropKey();
  final BackdropKey _manualKeyB = BackdropKey();

  final List<_LogEvent> _events = <_LogEvent>[];

  _Palette get _p => _palettes[_paletteIndex];

  static const _stageTitles = <String>[
    '1 Group Fundamentals Split View',
    '2 Grouped Gallery Surfaces',
    '3 Manual BackdropKey Lab',
    '4 Overlap Theater',
    '5 Scrolling Deck',
    '6 Verification Compendium',
  ];

  BlendMode get _blendMode => _useBlendSrc ? BlendMode.src : BlendMode.srcOver;

  @override
  void initState() {
    super.initState();
    _log('system', 'BackdropGroup deep demo initialized.', _p.accentA);
  }

  void _log(String lane, String message, Color tone) {
    final event = _LogEvent(at: DateTime.now(), lane: lane, message: message, tone: tone);
    setState(() {
      _events.insert(0, event);
      if (_events.length > 120) {
        _events.removeRange(120, _events.length);
      }
    });
    if (_verboseLog) {
      debugPrint('[BackdropGroup][$lane] $message');
    }
  }

  void _recordGroupWidgets(String lane, int value) {
    setState(() => _groupedWidgetCount = value);
    _log(lane, 'grouped widgets visible: $value', _p.accentB);
  }

  void _recordManualKeyMode(bool mirror) {
    setState(() {
      _manualKeyMirror = mirror;
      _manualKeySwitches += 1;
    });
    _log('manual-key', 'mirror mode -> $mirror', _p.accentC);
  }

  void _recordManualRequest(String lane) {
    setState(() => _manualBlurRequests += 1);
    _log(lane, 'manual refresh request', _p.accentA);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _p.canvas,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _header(),
            _toolbar(),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: _stageBody()),
                  if (_showTimeline)
                    SizedBox(
                      width: 360,
                      child: _timelinePanel(),
                    ),
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
          colors: <Color>[_p.shell, _p.accentA.withValues(alpha: 0.88)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.blur_on_outlined, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'BackdropGroup Deep Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Shared Backdrop Layer Model',
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
            'BackdropGroup establishes a shared backdrop key for multiple BackdropFilter.grouped '
            'widgets. This demo contrasts grouped and ungrouped composition, manual key wiring, '
            'overlap caveats, and practical frosted UI layouts for interpreter interaction checks.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontSize: 12.2,
              height: 1.35,
            ),
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
          for (var i = 0; i < _stageTitles.length; i++) _stageChip(i),
          const SizedBox(width: 10),
          Text('Palette', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
          const SizedBox(width: 10),
          _toggleChip('timeline', _showTimeline, (v) => _showTimeline = v),
          _toggleChip('guidance', _showGuidance, (v) => _showGuidance = v),
          _toggleChip('counters', _showCounters, (v) => _showCounters = v),
          _toggleChip('verbose', _verboseLog, (v) => _verboseLog = v),
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
      labelStyle: TextStyle(
        color: active ? Colors.white : _p.ink,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
      onSelected: (_) {
        setState(() => _stage = _DemoStage.values[index]);
        _log('stage', 'switched to ${_stageTitles[index]}', _p.accentB);
      },
    );
  }

  Widget _paletteDot(int index) {
    return GestureDetector(
      onTap: () {
        setState(() => _paletteIndex = index);
        _log('palette', 'palette changed to ${_palettes[index].name}', _palettes[index].accentA);
      },
      child: Container(
        width: 21,
        height: 21,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _palettes[index].accentA,
          border: Border.all(
            color: _paletteIndex == index ? _palettes[index].accentC : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _toggleChip(String label, bool value, void Function(bool value) assign) {
    return FilterChip(
      selected: value,
      selectedColor: _p.accentA.withValues(alpha: 0.19),
      backgroundColor: Colors.white,
      checkmarkColor: _p.accentA,
      label: Text(label),
      labelStyle: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11),
      onSelected: (selected) => setState(() => assign(selected)),
    );
  }

  Widget _stageBody() {
    switch (_stage) {
      case _DemoStage.fundamentals:
        return _fundamentalsStage();
      case _DemoStage.gallery:
        return _galleryStage();
      case _DemoStage.manualKeys:
        return _manualKeyStage();
      case _DemoStage.overlapTheater:
        return _overlapTheaterStage();
      case _DemoStage.scrollDeck:
        return _scrollDeckStage();
      case _DemoStage.compendium:
        return _compendiumStage();
    }
  }

  Widget _fundamentalsStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Group Fundamentals Split View'),
          const SizedBox(height: 8),
          Text(
            'Left panel uses standalone BackdropFilter instances. Right panel wraps multiple '
            'BackdropFilter.grouped widgets inside BackdropGroup to share the backdrop layer key.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _controlPanel(
            title: 'Shared Controls',
            subtitle: 'Tune blur, blend, and opacity to compare visual responses.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'sigma main',
                  value: _sigmaMain,
                  min: 0,
                  max: 38,
                  divisions: 38,
                  color: _p.accentA,
                  onChanged: (v) {
                    setState(() => _sigmaMain = v);
                    _log('controls', 'sigma main -> ${v.toStringAsFixed(1)}', _p.accentA);
                  },
                ),
                _slider(
                  label: 'glass opacity',
                  value: _glassOpacity,
                  min: 0.08,
                  max: 0.6,
                  divisions: 52,
                  color: _p.accentB,
                  onChanged: (v) {
                    setState(() => _glassOpacity = v);
                    _log('controls', 'glass opacity -> ${v.toStringAsFixed(2)}', _p.accentB);
                  },
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _toggleChip('filters enabled', _filtersEnabled, (v) => _filtersEnabled = v),
                    _toggleChip('blend src', _useBlendSrc, (v) => _useBlendSrc = v),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _controlPanel(
                  title: 'Ungrouped Filters',
                  subtitle: 'Each filter computes independently without shared BackdropGroup.',
                  tint: _p.accentC.withValues(alpha: 0.05),
                  child: _ungroupedShowcase(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _controlPanel(
                  title: 'Grouped Filters',
                  subtitle: 'BackdropGroup + BackdropFilter.grouped share backdrop input key.',
                  tint: _p.accentA.withValues(alpha: 0.05),
                  child: _groupedShowcase(),
                ),
              ),
            ],
          ),
          if (_showCounters) ...<Widget>[
            const SizedBox(height: 12),
            _metricPanel(),
          ],
        ],
      ),
    );
  }

  Widget _ungroupedShowcase() {
    _recordGroupWidgets('fundamentals-ungrouped', 3);
    return SizedBox(
      height: 420,
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: _patternBackground(pattern: _pattern, palette: _p, label: 'Ungrouped base')),
          Positioned(
            left: 20,
            top: 20,
            child: _glassTile(
              title: 'Tile A',
              note: 'Standalone filter',
              sigma: _sigmaMain,
              width: 180,
              height: 100,
            ),
          ),
          Positioned(
            right: 20,
            top: 130,
            child: _glassTile(
              title: 'Tile B',
              note: 'No shared key',
              sigma: _sigmaMain,
              width: 180,
              height: 110,
            ),
          ),
          Positioned(
            left: 44,
            bottom: 26,
            child: _glassTile(
              title: 'Tile C',
              note: 'Independent blur',
              sigma: _sigmaMain,
              width: 210,
              height: 114,
            ),
          ),
        ],
      ),
    );
  }

  Widget _groupedShowcase() {
    _recordGroupWidgets('fundamentals-grouped', 3);
    return SizedBox(
      height: 420,
      child: BackdropGroup(
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: _patternBackground(pattern: _pattern, palette: _p, label: 'Grouped base')),
            Positioned(
              left: 20,
              top: 20,
              child: _groupedTile(
                title: 'Tile A',
                note: 'BackdropFilter.grouped',
                sigma: _sigmaMain,
                width: 180,
                height: 100,
              ),
            ),
            Positioned(
              right: 20,
              top: 130,
              child: _groupedTile(
                title: 'Tile B',
                note: 'Same group key',
                sigma: _sigmaMain,
                width: 180,
                height: 110,
              ),
            ),
            Positioned(
              left: 44,
              bottom: 26,
              child: _groupedTile(
                title: 'Tile C',
                note: 'Shared backdrop input',
                sigma: _sigmaMain,
                width: 210,
                height: 114,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassTile({
    required String title,
    required String note,
    required double sigma,
    required double width,
    required double height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        enabled: _filtersEnabled,
        filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        blendMode: _blendMode,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _glassOpacity),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
          child: _tileContent(title: title, note: note),
        ),
      ),
    );
  }

  Widget _groupedTile({
    required String title,
    required String note,
    required double sigma,
    required double width,
    required double height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter.grouped(
        enabled: _filtersEnabled,
        filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        blendMode: _blendMode,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _glassOpacity),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
          child: _tileContent(title: title, note: note),
        ),
      ),
    );
  }

  Widget _tileContent({required String title, required String note}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 4),
          Text(note, style: TextStyle(color: _p.muted, fontSize: 10.4)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: _p.accentA.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'sigma ${_sigmaMain.toStringAsFixed(1)}',
              style: TextStyle(
                color: _p.ink,
                fontSize: 9.8,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _galleryStage() {
    _recordGroupWidgets('gallery', 6);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Grouped Gallery Surfaces'),
          const SizedBox(height: 8),
          Text(
            'Single BackdropGroup drives varied clip shapes and placements with BackdropFilter.grouped.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _controlPanel(
            title: 'Gallery Controls',
            subtitle: 'Tune secondary sigma and choose background pattern.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'sigma secondary',
                  value: _sigmaSecondary,
                  min: 0,
                  max: 42,
                  divisions: 42,
                  color: _p.accentB,
                  onChanged: (v) {
                    setState(() => _sigmaSecondary = v);
                    _log('gallery', 'sigma secondary -> ${v.toStringAsFixed(1)}', _p.accentB);
                  },
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    ChoiceChip(
                      selected: _pattern == _NoisePattern.diagonal,
                      label: const Text('diagonal'),
                      onSelected: (_) => setState(() => _pattern = _NoisePattern.diagonal),
                    ),
                    ChoiceChip(
                      selected: _pattern == _NoisePattern.circles,
                      label: const Text('circles'),
                      onSelected: (_) => setState(() => _pattern = _NoisePattern.circles),
                    ),
                    ChoiceChip(
                      selected: _pattern == _NoisePattern.stripes,
                      label: const Text('stripes'),
                      onSelected: (_) => setState(() => _pattern = _NoisePattern.stripes),
                    ),
                    FilledButton.icon(
                      onPressed: () => _recordManualRequest('gallery'),
                      icon: const Icon(Icons.refresh, size: 15),
                      label: const Text('Log Refresh'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _controlPanel(
            title: 'Grouped Surface Board',
            subtitle: 'All six glass widgets resolve shared backdrop key through BackdropGroup.',
            tint: _p.accentA.withValues(alpha: 0.04),
            child: SizedBox(
              height: 520,
              child: BackdropGroup(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(child: _patternBackground(pattern: _pattern, palette: _p, label: 'Gallery board')),
                    Positioned(
                      left: 20,
                      top: 18,
                      child: _groupedTile(
                        title: 'Card Glass',
                        note: 'Rect clip',
                        sigma: _sigmaSecondary,
                        width: 210,
                        height: 110,
                      ),
                    ),
                    Positioned(
                      left: 252,
                      top: 24,
                      child: ClipOval(
                        child: BackdropFilter.grouped(
                          filter: ui.ImageFilter.blur(sigmaX: _sigmaSecondary, sigmaY: _sigmaSecondary),
                          enabled: _filtersEnabled,
                          blendMode: _blendMode,
                          child: Container(
                            width: 120,
                            height: 120,
                            color: Colors.white.withValues(alpha: _glassOpacity),
                            child: Center(
                              child: Text('Circle', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 26,
                      child: _ribbonTile('Ribbon', 'ClipPath-like shape via skewed container'),
                    ),
                    Positioned(
                      left: 26,
                      bottom: 22,
                      child: _chipRow(),
                    ),
                    Positioned(
                      right: 30,
                      bottom: 20,
                      child: _groupedTile(
                        title: 'Info Panel',
                        note: 'Rounded panel',
                        sigma: _sigmaSecondary,
                        width: 230,
                        height: 142,
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

  Widget _ribbonTile(String title, String note) {
    return Transform.rotate(
      angle: -0.06,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter.grouped(
          filter: ui.ImageFilter.blur(sigmaX: _sigmaSecondary, sigmaY: _sigmaSecondary),
          blendMode: _blendMode,
          enabled: _filtersEnabled,
          child: Container(
            width: 200,
            height: 92,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: _glassOpacity),
              border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  Text(note, style: TextStyle(color: _p.muted, fontSize: 10.2)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chipRow() {
    return Row(
      children: <Widget>[
        _chipGlass('A'),
        const SizedBox(width: 10),
        _chipGlass('B'),
        const SizedBox(width: 10),
        _chipGlass('C'),
      ],
    );
  }

  Widget _chipGlass(String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter.grouped(
        filter: ui.ImageFilter.blur(sigmaX: _sigmaSecondary, sigmaY: _sigmaSecondary),
        blendMode: _blendMode,
        enabled: _filtersEnabled,
        child: Container(
          width: 58,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _glassOpacity),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.38)),
          ),
          child: Text(
            label,
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget _manualKeyStage() {
    _recordGroupWidgets('manual-key', 4);
    final firstKey = _manualKeyMirror ? _manualKeyA : _manualKeyA;
    final secondKey = _manualKeyMirror ? _manualKeyA : _manualKeyB;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Manual BackdropKey Lab'),
          const SizedBox(height: 8),
          Text(
            'BackdropFilter can receive explicit backdropGroupKey without BackdropGroup. '
            'This lab compares mirrored key mode versus split key mode.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _controlPanel(
            title: 'Key Wiring Controls',
            subtitle: 'Switch between key mirror and split key configurations.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilterChip(
                  selected: _manualKeyMirror,
                  label: const Text('mirror keys (A/A)'),
                  onSelected: _recordManualKeyMode,
                ),
                FilledButton.icon(
                  onPressed: () => _recordManualRequest('manual-key-stage'),
                  icon: const Icon(Icons.refresh, size: 15),
                  label: const Text('Log Request'),
                ),
                _miniMetric('key switches', '$_manualKeySwitches', _p.accentC),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _controlPanel(
                  title: 'Manual Key Surface A',
                  subtitle: 'Filters explicitly wired to key A.',
                  tint: _p.accentA.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 420,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(child: _patternBackground(pattern: _NoisePattern.circles, palette: _p, label: 'Manual A')),
                        Positioned(
                          left: 26,
                          top: 24,
                          child: _manualKeyTile(
                            title: 'A1',
                            note: 'backdropGroupKey: key A',
                            keyRef: firstKey,
                            sigma: _sigmaMain,
                            width: 210,
                            height: 120,
                          ),
                        ),
                        Positioned(
                          right: 22,
                          bottom: 28,
                          child: _manualKeyTile(
                            title: 'A2',
                            note: 'same explicit key',
                            keyRef: firstKey,
                            sigma: _sigmaMain,
                            width: 210,
                            height: 120,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _controlPanel(
                  title: 'Manual Key Surface B',
                  subtitle: _manualKeyMirror
                      ? 'Mirror mode uses key A here too.'
                      : 'Split mode uses key B on this side.',
                  tint: _p.accentB.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 420,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(child: _patternBackground(pattern: _NoisePattern.stripes, palette: _p, label: 'Manual B')),
                        Positioned(
                          left: 30,
                          top: 34,
                          child: _manualKeyTile(
                            title: 'B1',
                            note: _manualKeyMirror ? 'key A mirrored' : 'key B isolated',
                            keyRef: secondKey,
                            sigma: _sigmaSecondary,
                            width: 220,
                            height: 118,
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 20,
                          child: _manualKeyTile(
                            title: 'B2',
                            note: _manualKeyMirror ? 'shares A' : 'shares B',
                            keyRef: secondKey,
                            sigma: _sigmaSecondary,
                            width: 200,
                            height: 120,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _manualKeyTile({
    required String title,
    required String note,
    required BackdropKey keyRef,
    required double sigma,
    required double width,
    required double height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        backdropGroupKey: keyRef,
        filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        enabled: _filtersEnabled,
        blendMode: _blendMode,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _glassOpacity),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 12.2)),
                const SizedBox(height: 4),
                Text(note, style: TextStyle(color: _p.muted, fontSize: 10.4)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: _p.accentB.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'explicit key',
                    style: TextStyle(color: _p.ink, fontSize: 9.8, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _overlapTheaterStage() {
    _recordGroupWidgets('overlap', 3);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Overlap Theater'),
          const SizedBox(height: 8),
          Text(
            'Overlapping backdrop filters should not share one key in many cases. '
            'Toggle key-sharing to observe visual differences in the overlap zone.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _controlPanel(
            title: 'Overlap Controls',
            subtitle: 'Enable/disable shared key reuse for overlapping filters.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilterChip(
                  selected: _useSharedKeyInOverlap,
                  label: const Text('reuse one key for overlap'),
                  onSelected: (v) {
                    setState(() => _useSharedKeyInOverlap = v);
                    _log('overlap', 'shared key mode -> $v', _p.accentC);
                  },
                ),
                FilledButton.icon(
                  onPressed: () => _recordManualRequest('overlap-stage'),
                  icon: const Icon(Icons.refresh, size: 15),
                  label: const Text('Log Request'),
                ),
                _miniMetric('manual requests', '$_manualBlurRequests', _p.accentA),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _controlPanel(
            title: 'Overlap Board',
            subtitle: _useSharedKeyInOverlap
                ? 'Both overlays use same key (warning scenario for overlap).'
                : 'Overlays use separate keys (recommended for overlap regions).',
            tint: _p.accentC.withValues(alpha: 0.06),
            child: SizedBox(
              height: 460,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: _patternBackground(pattern: _NoisePattern.diagonal, palette: _p, label: 'Overlap board')),
                  Positioned(
                    left: 78,
                    top: 70,
                    child: _manualKeyTile(
                      title: 'Left Overlay',
                      note: _useSharedKeyInOverlap ? 'key A' : 'key A (isolated)',
                      keyRef: _manualKeyA,
                      sigma: _sigmaMain,
                      width: 270,
                      height: 170,
                    ),
                  ),
                  Positioned(
                    left: 210,
                    top: 160,
                    child: _manualKeyTile(
                      title: 'Right Overlay',
                      note: _useSharedKeyInOverlap ? 'key A reused' : 'key B separate',
                      keyRef: _useSharedKeyInOverlap ? _manualKeyA : _manualKeyB,
                      sigma: _sigmaSecondary,
                      width: 270,
                      height: 170,
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 18,
                    child: Container(
                      width: 270,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _p.muted.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        _useSharedKeyInOverlap
                            ? 'Shared key overlap mode can look like only one filter dominates in overlap region.'
                            : 'Separate keys preserve independent overlap composition behavior.',
                        style: TextStyle(color: _p.ink, fontSize: 11.1, height: 1.33),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollDeckStage() {
    _recordGroupWidgets('scroll-deck', _deckItemCount);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Scrolling Deck'),
          const SizedBox(height: 8),
          Text(
            'Practical list layout: one BackdropGroup wraps multiple frosted cards in scrolling content.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _controlPanel(
            title: 'Deck Controls',
            subtitle: 'Adjust list card count and card height for stress-style interaction tests.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'item count',
                  value: _deckItemCount.toDouble(),
                  min: 4,
                  max: 18,
                  divisions: 14,
                  color: _p.accentA,
                  onChanged: (v) => setState(() => _deckItemCount = v.round()),
                ),
                _slider(
                  label: 'card height',
                  value: _deckCardHeight,
                  min: 110,
                  max: 220,
                  divisions: 22,
                  color: _p.accentB,
                  onChanged: (v) => setState(() => _deckCardHeight = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _controlPanel(
              title: 'Grouped Frosted List',
              subtitle: 'BackdropFilter.grouped in repeated list cards under one BackdropGroup.',
              tint: _p.accentA.withValues(alpha: 0.03),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(child: _patternBackground(pattern: _pattern, palette: _p, label: 'Deck base')),
                    Positioned.fill(
                      child: BackdropGroup(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: _deckItemCount,
                          itemBuilder: (context, index) {
                            final sigma = _sigmaMain + (index % 3) * 3;
                            return Container(
                              height: _deckCardHeight,
                              margin: const EdgeInsets.only(bottom: 12),
                              child: _deckCard(index: index, sigma: sigma),
                            );
                          },
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

  Widget _deckCard({required int index, required double sigma}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter.grouped(
        filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        blendMode: _blendMode,
        enabled: _filtersEnabled,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _glassOpacity),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _p.accentA.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Card ${index + 1}',
                        style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 10.2),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'sigma ${sigma.toStringAsFixed(1)}',
                      style: TextStyle(color: _p.muted, fontSize: 10.4, fontFamily: 'monospace'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Grouped list card demonstrating shared backdrop input under BackdropGroup.',
                  style: TextStyle(color: _p.ink, fontSize: 11.2, height: 1.32),
                ),
                const Spacer(),
                Row(
                  children: <Widget>[
                    _miniMetric('grouped', 'yes', _p.accentB),
                    const SizedBox(width: 8),
                    _miniMetric('enabled', '$_filtersEnabled', _p.accentC),
                  ],
                ),
              ],
            ),
          ),
        ),
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
          _controlPanel(
            title: 'BackdropGroup Matrix',
            subtitle: 'Purpose and API interpretation summary.',
            child: Column(
              children: <Widget>[
                _matrix('Primary role', 'Provide shared BackdropKey scope for grouped backdrop filters.'),
                _matrix('How to opt in', 'Use BackdropFilter.grouped inside a BackdropGroup subtree.'),
                _matrix('Manual alternative', 'Use BackdropFilter(backdropGroupKey: someKey) directly.'),
                _matrix('Overlap caveat', 'Overlapping filters should usually not share one key.'),
                _matrix('Clip guidance', 'Clip each filtered region to constrain expensive blur work.'),
                _matrix('Blend mode notes', 'srcOver is default; src can be useful with layered compositions.'),
                _matrix('Enable switch', 'Use enabled=false for temporarily disabling effect without changing tree shape.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _controlPanel(
            title: 'Do and Dont',
            subtitle: 'Practical quality guidance for grouped backdrop scenes.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do group sibling frosted surfaces under one BackdropGroup',
                  detail: 'This clarifies shared-layer intent and keeps composition organized.',
                ),
                _doDont(
                  good: true,
                  title: 'Do clip each filter region',
                  detail: 'Clipping keeps filtering bounds tight and easier to reason about visually.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont reuse a single key for heavy overlap zones blindly',
                  detail: 'Visual results can be surprising in overlaps and may look like one dominant filter.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont use BackdropFilter when ImageFiltered would suffice',
                  detail: 'BackdropFilter is for content behind a child, not just filtering the child itself.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _controlPanel(
            title: 'FAQ',
            subtitle: 'Frequently asked implementation questions.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'When should I choose BackdropGroup instead of explicit keys?',
                  a: 'Use BackdropGroup for local subtree ergonomics and BackdropFilter.grouped convenience.',
                ),
                _qa(
                  q: 'Can I mix grouped and explicit-key filters together?',
                  a: 'Yes, but keep ownership clear so overlap behavior remains predictable.',
                ),
                _qa(
                  q: 'What if blur is too expensive in a long list?',
                  a: 'Use tighter clips, lower sigma, fewer active filters, and grouped shared-key strategy.',
                ),
                _qa(
                  q: 'Why include enabled toggle?',
                  a: 'It lets tests compare behavior with and without filtering while preserving layout and tree shape.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _controlPanel(
            title: 'Coverage Checklist',
            subtitle: 'Deep-demo acceptance criteria met in this file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Fundamentals split view contrasts ungrouped and grouped BackdropFilter usage.'),
                _check('Gallery stage demonstrates multiple grouped shapes and clipping patterns.'),
                _check('Manual key stage shows explicit backdropGroupKey strategies.'),
                _check('Overlap theater explains and visualizes shared-key overlap caveat.'),
                _check('Scrolling deck shows practical grouped list composition under one BackdropGroup.'),
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
              border: Border.all(color: _p.accentC.withValues(alpha: 0.32)),
            ),
            child: Text(
              'BackdropGroup is a coordination widget for shared backdrop computation, not just a stylistic wrapper. '
              'In interpreter scenarios, visual multi-stage demos help validate that grouped filters, explicit keys, '
              'and overlap policies behave as intended across dynamic UI arrangements.',
              style: TextStyle(color: _p.ink, fontSize: 11.8, height: 1.36),
            ),
          ),
        ],
      ),
    );
  }

  Widget _patternBackground({
    required _NoisePattern pattern,
    required _Palette palette,
    required String label,
  }) {
    switch (pattern) {
      case _NoisePattern.diagonal:
        return _diagonalBackground(palette: palette, label: label);
      case _NoisePattern.circles:
        return _circleBackground(palette: palette, label: label);
      case _NoisePattern.stripes:
        return _stripeBackground(palette: palette, label: label);
    }
  }

  Widget _diagonalBackground({required _Palette palette, required String label}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[palette.accentA, palette.accentB, palette.accentC],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(
              painter: _DiagonalLinesPainter(color: Colors.white.withValues(alpha: 0.24)),
            ),
          ),
          Positioned(
            left: 12,
            top: 12,
            child: _backgroundTag(label),
          ),
        ],
      ),
    );
  }

  Widget _circleBackground({required _Palette palette, required String label}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[palette.accentB, palette.accentA],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(left: 20, top: 26, child: _softCircle(80, Colors.white.withValues(alpha: 0.16))),
          Positioned(right: 40, top: 44, child: _softCircle(110, Colors.white.withValues(alpha: 0.14))),
          Positioned(left: 130, bottom: 30, child: _softCircle(130, Colors.white.withValues(alpha: 0.13))),
          Positioned(right: 120, bottom: 56, child: _softCircle(92, Colors.white.withValues(alpha: 0.13))),
          Positioned(
            left: 12,
            top: 12,
            child: _backgroundTag(label),
          ),
        ],
      ),
    );
  }

  Widget _stripeBackground({required _Palette palette, required String label}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[palette.accentC, palette.accentA],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(
              painter: _StripePainter(color: Colors.white.withValues(alpha: 0.23)),
            ),
          ),
          Positioned(
            left: 12,
            top: 12,
            child: _backgroundTag(label),
          ),
        ],
      ),
    );
  }

  Widget _backgroundTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 9.8, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _softCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _controlPanel({
    required String title,
    required String subtitle,
    required Widget child,
    Color? tint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tint ?? _p.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.muted.withValues(alpha: 0.23)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13.8)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 11.1)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Row(
      children: <Widget>[
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(color: _p.accentA, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: _p.ink, fontSize: 18, fontWeight: FontWeight.w800)),
      ],
    );
  }

  Widget _slider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 168,
          child: Text('$label: ${value.toStringAsFixed(1)}', style: TextStyle(color: _p.ink, fontSize: 12)),
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

  Widget _metricPanel() {
    return _controlPanel(
      title: 'Global Metrics',
      subtitle: 'Current interaction counters for this deep demo.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _miniMetric('grouped widgets', '$_groupedWidgetCount', _p.accentA),
          _miniMetric('manual requests', '$_manualBlurRequests', _p.accentB),
          _miniMetric('key switches', '$_manualKeySwitches', _p.accentC),
          _miniMetric('events', '${_events.length}', _p.accentA),
        ],
      ),
    );
  }

  Widget _miniMetric(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(color: _p.ink, fontSize: 10.3, fontWeight: FontWeight.w700),
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
            width: 170,
            child: Text(
              key,
              style: TextStyle(
                color: _p.accentA,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 10.9,
              ),
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
        border: Border.all(color: tone.withValues(alpha: 0.26)),
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
                Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
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
          Text('Q: $q', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.9)),
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
      decoration: BoxDecoration(
        color: _p.card,
        border: Border(left: BorderSide(color: _p.muted.withValues(alpha: 0.25))),
      ),
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
                Text('Backdrop Timeline', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13.2)),
                const SizedBox(height: 4),
                Text(
                  'Logs for group configuration changes and manual interaction notes.',
                  style: TextStyle(color: _p.muted, fontSize: 10.7),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _miniMetric('events', '${_events.length}', _p.accentA),
                    _miniMetric('grouped', '$_groupedWidgetCount', _p.accentB),
                    _miniMetric('requests', '$_manualBlurRequests', _p.accentC),
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
                    border: Border.all(color: event.tone.withValues(alpha: 0.26)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              event.lane,
                              style: TextStyle(
                                color: _p.ink,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w700,
                                fontSize: 10.4,
                              ),
                            ),
                          ),
                          Text(
                            _clock(event.at),
                            style: TextStyle(
                              color: _p.muted,
                              fontFamily: 'monospace',
                              fontSize: 10.1,
                            ),
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
          Text(_stageTitles[_stage.index], style: TextStyle(color: _p.muted, fontSize: 11, fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11.1)),
        ],
      ),
    );
  }
}

class _DiagonalLinesPainter extends CustomPainter {
  const _DiagonalLinesPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    var x = -size.height;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), paint);
      x += 24;
    }
  }

  @override
  bool shouldRepaint(covariant _DiagonalLinesPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _StripePainter extends CustomPainter {
  const _StripePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    var y = 0.0;
    while (y < size.height) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, 10), paint);
      y += 24;
    }
  }

  @override
  bool shouldRepaint(covariant _StripePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
