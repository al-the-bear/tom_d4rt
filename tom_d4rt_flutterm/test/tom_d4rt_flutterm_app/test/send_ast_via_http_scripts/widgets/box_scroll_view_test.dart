import 'dart:math' as math;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _BoxScrollViewDeepDemo();
}

enum _DemoStage {
  fundamentals,
  layoutGallery,
  paddingLens,
  axisReverseLab,
  inheritanceDeck,
  compendium,
}

enum _CanvasPattern {
  wave,
  grid,
  rings,
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
    name: 'Ocean Slate',
    shell: Color(0xFF132532),
    canvas: Color(0xFFF1F8FC),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF203744),
    muted: Color(0xFF6E8797),
    accentA: Color(0xFF1F88E5),
    accentB: Color(0xFF1A9A7B),
    accentC: Color(0xFFD18F1B),
  ),
  _Palette(
    name: 'Pine Ink',
    shell: Color(0xFF1A241E),
    canvas: Color(0xFFF3FAF5),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF29372E),
    muted: Color(0xFF748679),
    accentA: Color(0xFF2F8E3C),
    accentB: Color(0xFF1D8D96),
    accentC: Color(0xFFB88627),
  ),
  _Palette(
    name: 'Copper Night',
    shell: Color(0xFF2A211D),
    canvas: Color(0xFFFDF5EE),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF3B2F29),
    muted: Color(0xFF8B7C73),
    accentA: Color(0xFFB86335),
    accentB: Color(0xFF2F89A1),
    accentC: Color(0xFF9C8518),
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

class _BoxScrollViewDeepDemo extends StatefulWidget {
  const _BoxScrollViewDeepDemo();

  @override
  State<_BoxScrollViewDeepDemo> createState() => _BoxScrollViewDeepDemoState();
}

class _BoxScrollViewDeepDemoState extends State<_BoxScrollViewDeepDemo> {
  _DemoStage _stage = _DemoStage.fundamentals;
  final _CanvasPattern _pattern = _CanvasPattern.wave;
  int _paletteIndex = 0;

  bool _showTimeline = true;
  bool _showGuidance = true;
  bool _showMetrics = true;
  bool _verbose = false;

  int _fundamentalCount = 16;
  int _gridCount = 18;
  final int _deckCount = 12;

  int _fundamentalIndex = 0;
  int _galleryListIndex = 0;
  int _galleryGridIndex = 0;

  bool _useExplicitPadding = false;
  bool _reverseAxis = false;
  bool _horizontalAxis = false;
  bool _shrinkWrapAxis = false;
  bool _bouncingPhysics = true;

  double _itemExtent = 72;
  double _tileExtent = 116;
  double _paddingValue = 14;
  double _surfaceHeight = 380;
  int _crossAxisCount = 2;

  int _tapEvents = 0;
  int _controlChanges = 0;
  int _modeChanges = 0;

  final List<_LogEvent> _events = <_LogEvent>[];

  _Palette get _p => _palettes[_paletteIndex];

  ScrollPhysics get _physics => _bouncingPhysics ? const BouncingScrollPhysics() : const ClampingScrollPhysics();

  static const _stageTitles = <String>[
    '1 Fundamentals Studio',
    '2 Layout Gallery',
    '3 Padding Lens',
    '4 Axis and Reverse Lab',
    '5 Inheritance Deck',
    '6 Verification Compendium',
  ];

  @override
  void initState() {
    super.initState();
    _log('system', 'BoxScrollView deep demo initialized.', _p.accentA);
  }

  void _log(String lane, String message, Color tone) {
    final event = _LogEvent(at: DateTime.now(), lane: lane, message: message, tone: tone);
    setState(() {
      _events.insert(0, event);
      if (_events.length > 120) {
        _events.removeRange(120, _events.length);
      }
    });
    if (_verbose) {
      debugPrint('[BoxScrollView][$lane] $message');
    }
  }

  void _recordControl(String lane, String message) {
    setState(() => _controlChanges += 1);
    _log(lane, message, _p.accentB);
  }

  void _recordTap(String lane, int index, String label) {
    setState(() => _tapEvents += 1);
    _log(lane, 'selected item $index ($label)', _p.accentA);
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
              const Icon(Icons.view_stream_outlined, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'BoxScrollView Deep Demo',
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
                  'Single Child Layout Model',
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
            'BoxScrollView is the base scroll-view model used by ListView and GridView, with one child layout model '
            'converted into one sliver list. This demo visualizes subclass behavior, padding semantics, axis controls, '
            'and inheritance relationships with practical interactive examples.',
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
          _toggleChip('metrics', _showMetrics, (v) => _showMetrics = v),
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
      case _DemoStage.layoutGallery:
        return _layoutGalleryStage();
      case _DemoStage.paddingLens:
        return _paddingLensStage();
      case _DemoStage.axisReverseLab:
        return _axisReverseStage();
      case _DemoStage.inheritanceDeck:
        return _inheritanceDeckStage();
      case _DemoStage.compendium:
        return _compendiumStage();
    }
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: _p.ink,
        fontSize: 19,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
      ),
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
      decoration: BoxDecoration(
        color: tint ?? _p.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _p.muted.withValues(alpha: 0.22)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _p.shell.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
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

  Widget _fundamentalsStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Fundamentals Studio'),
          const SizedBox(height: 8),
          Text(
            'A custom BoxScrollView subclass uses buildChildLayout to return a sliver-based layout model. '
            'This stage shows a handcrafted list scroll view powered directly by BoxScrollView.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Fundamental Controls',
            subtitle: 'Change list count, item extent, and base padding.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'item count',
                  value: _fundamentalCount.toDouble(),
                  min: 6,
                  max: 28,
                  divisions: 22,
                  color: _p.accentA,
                  onChanged: (v) {
                    setState(() => _fundamentalCount = v.round());
                    _recordControl('fundamentals', 'item count -> ${v.round()}');
                  },
                ),
                _slider(
                  label: 'item extent',
                  value: _itemExtent,
                  min: 52,
                  max: 116,
                  divisions: 16,
                  color: _p.accentB,
                  onChanged: (v) {
                    setState(() => _itemExtent = v);
                    _recordControl('fundamentals', 'item extent -> ${v.toStringAsFixed(1)}');
                  },
                ),
                _slider(
                  label: 'surface height',
                  value: _surfaceHeight,
                  min: 300,
                  max: 500,
                  divisions: 20,
                  color: _p.accentC,
                  onChanged: (v) => setState(() => _surfaceHeight = v),
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
                  title: 'Custom BoxScrollView Preview',
                  subtitle: 'Subclass: _PaletteStripBoxScrollView with SliverFixedExtentList layout.',
                  tint: _p.accentA.withValues(alpha: 0.04),
                  child: _deviceShell(
                    title: 'Custom list model',
                    selectedLabel: 'focus row ${_fundamentalIndex + 1}',
                    body: SizedBox(
                      height: _surfaceHeight,
                      child: _PaletteStripBoxScrollView(
                        itemCount: _fundamentalCount,
                        itemExtent: _itemExtent,
                        padding: EdgeInsets.all(_paddingValue),
                        physics: _physics,
                        itemBuilder: (context, index) {
                          final selected = _fundamentalIndex == index;
                          final tone = selected ? _p.accentA : _p.accentB;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _fundamentalIndex = index);
                              _recordTap('fundamentals', index, 'row ${index + 1}');
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: tone.withValues(alpha: selected ? 0.16 : 0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: tone.withValues(alpha: 0.28)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 10),
                                  CircleAvatar(
                                    radius: 13,
                                    backgroundColor: tone.withValues(alpha: 0.3),
                                    child: Text('${index + 1}', style: TextStyle(color: _p.ink, fontSize: 10)),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'BoxScroll row ${index + 1}',
                                      style: TextStyle(color: _p.ink, fontSize: 12.2, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Text(
                                    'extent ${_itemExtent.toStringAsFixed(0)}',
                                    style: TextStyle(color: _p.muted, fontSize: 9.8, fontFamily: 'monospace'),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ),
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
                  width: 330,
                  child: _panel(
                    title: 'What This Shows',
                    subtitle: 'Fundamental BoxScrollView subclass behavior.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('BoxScrollView maps one layout model to one sliver list in buildSlivers.'),
                        _bullet('Subclasses implement buildChildLayout for list/grid style layouts.'),
                        _bullet('padding is handled by BoxScrollView and wrapped into SliverPadding.'),
                        _bullet('ScrollView-level properties like physics and reverse are inherited.'),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (_showMetrics) ...<Widget>[
            const SizedBox(height: 12),
            _metricPanel(),
          ],
        ],
      ),
    );
  }

  Widget _layoutGalleryStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Layout Gallery'),
          const SizedBox(height: 8),
          Text(
            'Two different subclasses demonstrate how BoxScrollView can power linear and grid-like child layout models.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Gallery Controls',
            subtitle: 'Tune grid count and cross-axis configuration.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'grid count',
                  value: _gridCount.toDouble(),
                  min: 8,
                  max: 36,
                  divisions: 28,
                  color: _p.accentA,
                  onChanged: (v) {
                    setState(() => _gridCount = v.round());
                    _recordControl('gallery', 'grid count -> ${v.round()}');
                  },
                ),
                _slider(
                  label: 'cross axis',
                  value: _crossAxisCount.toDouble(),
                  min: 2,
                  max: 4,
                  divisions: 2,
                  color: _p.accentB,
                  onChanged: (v) {
                    setState(() => _crossAxisCount = v.round());
                    _recordControl('gallery', 'cross axis count -> ${v.round()}');
                  },
                ),
                _slider(
                  label: 'tile extent',
                  value: _tileExtent,
                  min: 88,
                  max: 170,
                  divisions: 16,
                  color: _p.accentC,
                  onChanged: (v) {
                    setState(() => _tileExtent = v);
                    _recordControl('gallery', 'tile extent -> ${v.toStringAsFixed(1)}');
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
                  title: 'Linear Layout Subclass',
                  subtitle: 'BoxScrollView + SliverList child layout.',
                  tint: _p.accentA.withValues(alpha: 0.04),
                  child: _deviceShell(
                    title: 'Linear box layout',
                    selectedLabel: 'row ${_galleryListIndex + 1}',
                    body: SizedBox(
                      height: _surfaceHeight,
                      child: _PaletteListBoxScrollView(
                        itemCount: _fundamentalCount,
                        padding: EdgeInsets.symmetric(horizontal: _paddingValue, vertical: 12),
                        physics: _physics,
                        itemBuilder: (context, index) {
                          final selected = index == _galleryListIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _galleryListIndex = index);
                              _recordTap('gallery-linear', index, 'line ${index + 1}');
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: (selected ? _p.accentA : _p.accentB).withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
                              ),
                              child: Text(
                                'Linear tile ${index + 1}',
                                style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.8),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _panel(
                  title: 'Grid Layout Subclass',
                  subtitle: 'BoxScrollView + SliverGrid child layout.',
                  tint: _p.accentB.withValues(alpha: 0.04),
                  child: _deviceShell(
                    title: 'Grid box layout',
                    selectedLabel: 'tile ${_galleryGridIndex + 1}',
                    body: SizedBox(
                      height: _surfaceHeight,
                      child: _PaletteGridBoxScrollView(
                        itemCount: _gridCount,
                        crossAxisCount: _crossAxisCount,
                        tileExtent: _tileExtent,
                        padding: EdgeInsets.all(_paddingValue),
                        physics: _physics,
                        itemBuilder: (context, index) {
                          final selected = index == _galleryGridIndex;
                          final tone = selected ? _p.accentC : _p.accentA;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _galleryGridIndex = index);
                              _recordTap('gallery-grid', index, 'tile ${index + 1}');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: tone.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: tone.withValues(alpha: 0.28)),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 17),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
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

  Widget _paddingLensStage() {
    final simulatedMedia = MediaQueryData.fromView(View.of(context)).copyWith(
      padding: const EdgeInsets.fromLTRB(18, 26, 14, 18),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Padding Lens'),
          const SizedBox(height: 8),
          Text(
            'When padding is null, BoxScrollView can consume MediaQuery main-axis padding and apply SliverPadding automatically.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Padding Controls',
            subtitle: 'Switch explicit padding and compare with automatic MediaQuery padding behavior.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _toggleChip('explicit padding', _useExplicitPadding, (v) {
                  _useExplicitPadding = v;
                  _recordControl('padding-lens', 'explicit padding -> $v');
                }),
                _sliderInline(
                  label: 'padding',
                  value: _paddingValue,
                  min: 0,
                  max: 30,
                  divisions: 30,
                  color: _p.accentA,
                  onChanged: (v) {
                    setState(() => _paddingValue = v);
                    _recordControl('padding-lens', 'padding value -> ${v.toStringAsFixed(1)}');
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
                  title: 'Auto MediaQuery Padding',
                  subtitle: 'padding=null allows BoxScrollView to consume main-axis safe padding.',
                  tint: _p.accentA.withValues(alpha: 0.04),
                  child: MediaQuery(
                    data: simulatedMedia,
                    child: _deviceShell(
                      title: 'Auto padding shell',
                      selectedLabel: 'media query aware',
                      body: SizedBox(
                        height: _surfaceHeight,
                        child: _PaletteListBoxScrollView(
                          itemCount: 12,
                          padding: null,
                          physics: _physics,
                          itemBuilder: (context, index) => _paddingTile(
                            title: 'Auto tile ${index + 1}',
                            subtitle: 'Padding from MediaQuery main-axis',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _panel(
                  title: 'Explicit Padding',
                  subtitle: 'padding=EdgeInsets overrides default auto main-axis behavior.',
                  tint: _p.accentB.withValues(alpha: 0.04),
                  child: MediaQuery(
                    data: simulatedMedia,
                    child: _deviceShell(
                      title: 'Explicit padding shell',
                      selectedLabel: 'padding $_paddingValue',
                      body: SizedBox(
                        height: _surfaceHeight,
                        child: _PaletteListBoxScrollView(
                          itemCount: 12,
                          padding: EdgeInsets.all(_paddingValue),
                          physics: _physics,
                          itemBuilder: (context, index) => _paddingTile(
                            title: 'Explicit tile ${index + 1}',
                            subtitle: 'Manual EdgeInsets padding',
                          ),
                        ),
                      ),
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

  Widget _paddingTile({required String title, required String subtitle}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _p.accentB.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.8)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 10.2)),
        ],
      ),
    );
  }

  Widget _axisReverseStage() {
    final axis = _horizontalAxis ? Axis.horizontal : Axis.vertical;
    final itemExtent = _horizontalAxis ? 160.0 : _itemExtent;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Axis and Reverse Lab'),
          const SizedBox(height: 8),
          Text(
            'BoxScrollView inherits ScrollView controls like scrollDirection, reverse, shrinkWrap, and physics.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Axis Controls',
            subtitle: 'Switch direction and behavior flags in a custom BoxScrollView subclass.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _toggleChip('horizontal axis', _horizontalAxis, (v) {
                  _horizontalAxis = v;
                  _modeChanges += 1;
                  _recordControl('axis-lab', 'horizontal axis -> $v');
                }),
                _toggleChip('reverse', _reverseAxis, (v) {
                  _reverseAxis = v;
                  _modeChanges += 1;
                  _recordControl('axis-lab', 'reverse -> $v');
                }),
                _toggleChip('shrinkWrap', _shrinkWrapAxis, (v) {
                  _shrinkWrapAxis = v;
                  _modeChanges += 1;
                  _recordControl('axis-lab', 'shrinkWrap -> $v');
                }),
                _toggleChip('bouncing physics', _bouncingPhysics, (v) {
                  _bouncingPhysics = v;
                  _modeChanges += 1;
                  _recordControl('axis-lab', 'bouncing physics -> $v');
                }),
                _miniMetric('mode changes', '$_modeChanges', _p.accentC),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Axis Preview Surface',
            subtitle: 'Tap cards to track flow under different axis and reverse settings.',
            tint: _p.accentC.withValues(alpha: 0.05),
            child: SizedBox(
              height: 470,
              child: _deviceShell(
                title: 'Axis lab',
                selectedLabel: _horizontalAxis ? 'horizontal' : 'vertical',
                body: SizedBox(
                  height: 390,
                  child: _PaletteStripBoxScrollView(
                    scrollDirection: axis,
                    reverse: _reverseAxis,
                    shrinkWrap: _shrinkWrapAxis,
                    physics: _physics,
                    padding: EdgeInsets.all(_paddingValue),
                    itemCount: _deckCount,
                    itemExtent: itemExtent,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _recordTap('axis-lab', index, 'card ${index + 1}'),
                        child: Container(
                          width: _horizontalAxis ? 150 : null,
                          margin: const EdgeInsets.only(bottom: 8, right: 8),
                          decoration: BoxDecoration(
                            color: _p.accentA.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _p.accentA.withValues(alpha: 0.3)),
                          ),
                          child: Center(
                            child: Text(
                              'Card ${index + 1}',
                              style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12),
                            ),
                          ),
                        ),
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

  Widget _inheritanceDeckStage() {
    final Widget listViewSample = ListView(
      shrinkWrap: true,
      children: const <Widget>[SizedBox(height: 1)],
    );
    final Widget gridViewSample = GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      children: const <Widget>[SizedBox(height: 1)],
    );
    final Widget customSample = _PaletteListBoxScrollView(
      itemCount: 1,
      itemBuilder: (context, index) => const SizedBox(height: 1),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _sectionTitle('Inheritance Deck'),
          const SizedBox(height: 8),
          Text(
            'BoxScrollView is abstract and underpins built-in views like ListView and GridView.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Type Relationship Cards',
            subtitle: 'Runtime checks and inheritance context.',
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: <Widget>[
                _typeCard(
                  title: 'ListView',
                  runtimeType: listViewSample.runtimeType.toString(),
                  isBox: listViewSample is BoxScrollView,
                  note: 'Linear child layout model',
                  tone: _p.accentA,
                ),
                _typeCard(
                  title: 'GridView',
                  runtimeType: gridViewSample.runtimeType.toString(),
                  isBox: gridViewSample is BoxScrollView,
                  note: '2D child layout model',
                  tone: _p.accentB,
                ),
                _typeCard(
                  title: 'Custom Subclass',
                  runtimeType: customSample.runtimeType.toString(),
                  isBox: customSample is BoxScrollView,
                  note: 'Manual buildChildLayout implementation',
                  tone: _p.accentC,
                ),
              ],
            ),
          ),
          if (_showGuidance) ...<Widget>[
            const SizedBox(height: 12),
            _panel(
              title: 'Architectural Notes',
              subtitle: 'When to use BoxScrollView subclassing.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _bullet('Subclass BoxScrollView when one child layout model is sufficient.'),
                  _bullet('Use CustomScrollView when combining multiple sliver families.'),
                  _bullet('Expose high-level parameters while preserving ScrollView behavior options.'),
                  _bullet('Keep buildChildLayout focused on sliver model composition only.'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _typeCard({
    required String title,
    required String runtimeType,
    required bool isBox,
    required String note,
    required Color tone,
  }) {
    return Container(
      width: 330,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 12.2)),
          const SizedBox(height: 6),
          _codeLine('runtimeType', runtimeType),
          _codeLine('is BoxScrollView', '$isBox'),
          const SizedBox(height: 6),
          Text(note, style: TextStyle(color: _p.muted, fontSize: 10.8)),
        ],
      ),
    );
  }

  Widget _codeLine(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              key,
              style: TextStyle(
                color: _p.accentA,
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: _p.ink, fontSize: 10.8))),
        ],
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
            title: 'BoxScrollView Matrix',
            subtitle: 'Concept and API coverage summary.',
            child: Column(
              children: <Widget>[
                _matrix('Core role', 'Abstract ScrollView with a single child layout model.'),
                _matrix('Subclass contract', 'Implement buildChildLayout(BuildContext) and return one sliver model widget.'),
                _matrix('Padding behavior', 'padding null can consume MediaQuery main-axis safe padding; explicit padding uses SliverPadding.'),
                _matrix('Inherited controls', 'scrollDirection, reverse, physics, shrinkWrap, and more are inherited from ScrollView.'),
                _matrix('Typical subclasses', 'ListView, GridView, and app-specific one-model scroll views.'),
                _matrix('When not enough', 'Use CustomScrollView for multi-model sliver composition.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Guidance for robust custom BoxScrollView classes.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do keep buildChildLayout focused on one sliver model',
                  detail: 'This preserves BoxScrollView intent and reduces complexity.',
                ),
                _doDont(
                  good: true,
                  title: 'Do expose key ScrollView options in subclass constructors',
                  detail: 'Forward common parameters like reverse, physics, and padding.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont stack unrelated sliver families in one BoxScrollView subclass',
                  detail: 'Use CustomScrollView when composition exceeds one layout model.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont ignore padding semantics with MediaQuery',
                  detail: 'Understand auto padding behavior when padding is null.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common questions for BoxScrollView usage.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'Why subclass BoxScrollView instead of ScrollView directly?',
                  a: 'BoxScrollView already provides single-model sliver wrapping and padding integration.',
                ),
                _qa(
                  q: 'Can I create horizontal custom box scroll views?',
                  a: 'Yes. Forward scrollDirection and build a compatible sliver child layout.',
                ),
                _qa(
                  q: 'What does shrinkWrap change here?',
                  a: 'It affects viewport sizing behavior inherited from ScrollView, useful in nested contexts.',
                ),
                _qa(
                  q: 'Is ListView just a BoxScrollView?',
                  a: 'Yes. ListView and GridView are concrete BoxScrollView subclasses with specific child models.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Coverage Checklist',
            subtitle: 'Deep-demo outcomes for this file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Fundamentals stage demonstrates a manual BoxScrollView subclass using SliverFixedExtentList.'),
                _check('Layout gallery demonstrates distinct child layout models via different subclasses.'),
                _check('Padding lens visualizes automatic and explicit padding semantics.'),
                _check('Axis lab demonstrates reverse, direction, shrinkWrap, and physics behavior controls.'),
                _check('Inheritance deck confirms built-in and custom types as BoxScrollView derivatives.'),
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
              'BoxScrollView is a structural base class that balances convenience and flexibility. '
              'A clear one-model layout strategy plus explicit visual demos makes interpreter behavior '
              'easy to verify while keeping custom scroll components maintainable.',
              style: TextStyle(color: _p.ink, fontSize: 11.8, height: 1.36),
            ),
          ),
        ],
      ),
    );
  }

  Widget _deviceShell({
    required String title,
    required String selectedLabel,
    required Widget body,
  }) {
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
              color: _p.canvas,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              border: Border(bottom: BorderSide(color: _p.muted.withValues(alpha: 0.24))),
            ),
            child: Row(
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.muted, fontSize: 10.8)),
                const Spacer(),
                Text(
                  selectedLabel,
                  style: TextStyle(color: _p.muted, fontSize: 10.3, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: _background(_pattern)),
                Positioned.fill(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _background(_CanvasPattern pattern) {
    switch (pattern) {
      case _CanvasPattern.wave:
        return _waveBackground();
      case _CanvasPattern.grid:
        return _gridBackground();
      case _CanvasPattern.rings:
        return _ringBackground();
    }
  }

  Widget _waveBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentA.withValues(alpha: 0.24), _p.accentB.withValues(alpha: 0.24)],
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
          colors: <Color>[_p.accentB.withValues(alpha: 0.24), _p.accentC.withValues(alpha: 0.24)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CustomPaint(painter: _GridPainter(color: Colors.white.withValues(alpha: 0.22))),
    );
  }

  Widget _ringBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentC.withValues(alpha: 0.24), _p.accentA.withValues(alpha: 0.24)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(left: 24, top: 24, child: _ring(88, Colors.white.withValues(alpha: 0.16))),
          Positioned(right: 30, top: 40, child: _ring(68, Colors.white.withValues(alpha: 0.15))),
          Positioned(left: 110, bottom: 28, child: _ring(110, Colors.white.withValues(alpha: 0.13))),
        ],
      ),
    );
  }

  Widget _ring(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 6),
      ),
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

  Widget _sliderInline({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return SizedBox(
      width: 320,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 90,
            child: Text(label, style: TextStyle(color: _p.ink, fontSize: 11.3, fontWeight: FontWeight.w700)),
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
      ),
    );
  }

  Widget _metricPanel() {
    return _panel(
      title: 'Global Metrics',
      subtitle: 'Interaction counters from controls and tap events.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _miniMetric('tap events', '$_tapEvents', _p.accentA),
          _miniMetric('control changes', '$_controlChanges', _p.accentB),
          _miniMetric('mode changes', '$_modeChanges', _p.accentC),
          _miniMetric('timeline events', '${_events.length}', _p.accentA),
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
        style: TextStyle(color: _p.ink, fontSize: 10.2, fontWeight: FontWeight.w700),
      ),
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
              style: TextStyle(
                color: _p.accentA,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 10.8,
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
          Text('A: $a', style: TextStyle(color: _p.muted, fontSize: 11.1, height: 1.33)),
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
                Text('Scroll Timeline', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13.2)),
                const SizedBox(height: 4),
                Text(
                  'Logs for BoxScrollView control changes and item interactions.',
                  style: TextStyle(color: _p.muted, fontSize: 10.7),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _miniMetric('events', '${_events.length}', _p.accentA),
                    _miniMetric('taps', '$_tapEvents', _p.accentB),
                    _miniMetric('controls', '$_controlChanges', _p.accentC),
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

class _PaletteListBoxScrollView extends BoxScrollView {
  const _PaletteListBoxScrollView({
    required this.itemCount,
    required this.itemBuilder,
    super.physics,
    super.padding,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget buildChildLayout(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
    );
  }
}

class _PaletteGridBoxScrollView extends BoxScrollView {
  const _PaletteGridBoxScrollView({
    required this.itemCount,
    required this.crossAxisCount,
    required this.tileExtent,
    required this.itemBuilder,
    super.physics,
    super.padding,
  });

  final int itemCount;
  final int crossAxisCount;
  final double tileExtent;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget buildChildLayout(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: tileExtent,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
    );
  }
}

class _PaletteStripBoxScrollView extends BoxScrollView {
  const _PaletteStripBoxScrollView({
    required this.itemCount,
    required this.itemExtent,
    required this.itemBuilder,
    super.scrollDirection = Axis.vertical,
    super.reverse = false,
    super.physics,
    super.shrinkWrap = false,
    super.padding,
  });

  final int itemCount;
  final double itemExtent;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget buildChildLayout(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: itemExtent,
      delegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
      ),
    );
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
