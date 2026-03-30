import 'dart:math' as math;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _ClipRSuperellipseDeepDemo();
}

enum _Scene {
  primer,
  radiusStudio,
  behaviorLab,
  gallery,
  comparison,
  compendium,
}

class _Skin {
  const _Skin({
    required this.name,
    required this.shell,
    required this.paper,
    required this.panel,
    required this.ink,
    required this.muted,
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });

  final String name;
  final Color shell;
  final Color paper;
  final Color panel;
  final Color ink;
  final Color muted;
  final Color primary;
  final Color secondary;
  final Color tertiary;
}

const _skins = <_Skin>[
  _Skin(
    name: 'Studio Harbor',
    shell: Color(0xFF102633),
    paper: Color(0xFFF2F8FC),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF203A48),
    muted: Color(0xFF6D8595),
    primary: Color(0xFF1D84D7),
    secondary: Color(0xFF179071),
    tertiary: Color(0xFFD0891C),
  ),
  _Skin(
    name: 'Olive Workshop',
    shell: Color(0xFF1A261F),
    paper: Color(0xFFF3FAF4),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF2A3A31),
    muted: Color(0xFF74877A),
    primary: Color(0xFF2C8F3E),
    secondary: Color(0xFF1C8EA0),
    tertiary: Color(0xFFB78A2A),
  ),
  _Skin(
    name: 'Copper Theater',
    shell: Color(0xFF2A211C),
    paper: Color(0xFFFCF3EA),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF3E322C),
    muted: Color(0xFF8B7B70),
    primary: Color(0xFFBA6630),
    secondary: Color(0xFF2C86A3),
    tertiary: Color(0xFF9E8115),
  ),
];

class _DemoEvent {
  const _DemoEvent({
    required this.at,
    required this.channel,
    required this.message,
    required this.tone,
  });

  final DateTime at;
  final String channel;
  final String message;
  final Color tone;
}

class _ClipRSuperellipseDeepDemo extends StatefulWidget {
  const _ClipRSuperellipseDeepDemo();

  @override
  State<_ClipRSuperellipseDeepDemo> createState() => _ClipRSuperellipseDeepDemoState();
}

class _ClipRSuperellipseDeepDemoState extends State<_ClipRSuperellipseDeepDemo>
    with SingleTickerProviderStateMixin {
  _Scene _scene = _Scene.primer;
  int _skinIndex = 0;

  bool _showTimeline = true;
  bool _showGuides = true;
  bool _showMetrics = true;
  bool _showGrid = true;
  bool _showGlow = true;
  bool _showBorder = true;
  bool _showScrim = false;

  bool _linkCorners = true;
  bool _animatePatterns = true;

  Clip _clipBehavior = Clip.antiAlias;

  double _sizeWidth = 250;
  double _sizeHeight = 170;
  double _allCorners = 34;
  double _tl = 34;
  double _tr = 34;
  double _br = 34;
  double _bl = 34;

  int _tapCount = 0;
  int _controlChanges = 0;
  int _sceneChanges = 0;
  int _behaviorChanges = 0;

  late final AnimationController _pulse;
  final List<_DemoEvent> _events = <_DemoEvent>[];

  _Skin get _s => _skins[_skinIndex];

  BorderRadius get _radius {
    if (_linkCorners) {
      return BorderRadius.circular(_allCorners);
    }
    return BorderRadius.only(
      topLeft: Radius.circular(_tl),
      topRight: Radius.circular(_tr),
      bottomRight: Radius.circular(_br),
      bottomLeft: Radius.circular(_bl),
    );
  }

  static const _sceneTitles = <String>[
    '1 Primer Stage',
    '2 Radius Studio',
    '3 Clip Behavior Lab',
    '4 Pattern Gallery',
    '5 Comparison Observatory',
    '6 Verification Compendium',
  ];

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _pulse.repeat();
    _event('system', 'ClipRSuperellipse deep demo initialized.', _s.primary);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _event(String channel, String message, Color tone) {
    final e = _DemoEvent(at: DateTime.now(), channel: channel, message: message, tone: tone);
    setState(() {
      _events.insert(0, e);
      if (_events.length > 240) {
        _events.removeRange(240, _events.length);
      }
    });
  }

  void _markTap(String message) {
    setState(() => _tapCount += 1);
    _event('tap', message, _s.primary);
  }

  void _markControl(String message) {
    setState(() => _controlChanges += 1);
    _event('control', message, _s.secondary);
  }

  void _setLinkedCorners(double value) {
    setState(() {
      _allCorners = value;
      _tl = value;
      _tr = value;
      _br = value;
      _bl = value;
    });
    _markControl('Linked corner radius -> ${value.toStringAsFixed(1)}');
  }

  void _setCorner(String key, double value) {
    setState(() {
      if (_linkCorners) {
        _allCorners = value;
        _tl = value;
        _tr = value;
        _br = value;
        _bl = value;
      } else {
        if (key == 'tl') _tl = value;
        if (key == 'tr') _tr = value;
        if (key == 'br') _br = value;
        if (key == 'bl') _bl = value;
      }
    });
    _markControl('Corner $key -> ${value.toStringAsFixed(1)}');
  }

  void _setPreset(String preset) {
    if (preset == 'pill') {
      _setLinkedCorners(78);
    } else if (preset == 'ticket') {
      setState(() {
        _linkCorners = false;
        _tl = 64;
        _tr = 12;
        _br = 64;
        _bl = 12;
      });
      _markControl('Preset ticket applied');
    } else if (preset == 'dialog') {
      _setLinkedCorners(24);
    } else if (preset == 'micro') {
      _setLinkedCorners(8);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _s.paper,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _header(),
            _toolbar(),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(child: _sceneBody()),
                  if (_showTimeline)
                    SizedBox(
                      width: 390,
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
          colors: <Color>[_s.shell, _s.primary.withValues(alpha: 0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.rounded_corner_outlined, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'ClipRSuperellipse Deep Demo',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Smooth Corner Clipping',
                  style: TextStyle(color: Colors.white, fontSize: 10.3, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'ClipRSuperellipse clips child content with continuous superellipse-like corner transitions. '
            'This demo explores practical use in cards, media shells, dashboards, and route-style surfaces, '
            'with live controls for radius architecture and clip behavior.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.95), fontSize: 12.2, height: 1.34),
          ),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      color: _s.primary.withValues(alpha: 0.08),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text('Scene', style: TextStyle(color: _s.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _sceneTitles.length; i++) _sceneChip(i),
          const SizedBox(width: 10),
          Text('Skin', style: TextStyle(color: _s.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _skins.length; i++) _skinDot(i),
          const SizedBox(width: 10),
          _toggleChip('timeline', _showTimeline, (v) => _showTimeline = v),
          _toggleChip('guides', _showGuides, (v) => _showGuides = v),
          _toggleChip('metrics', _showMetrics, (v) => _showMetrics = v),
          _toggleChip('grid', _showGrid, (v) => _showGrid = v),
          _toggleChip('glow', _showGlow, (v) => _showGlow = v),
        ],
      ),
    );
  }

  Widget _sceneChip(int index) {
    final active = _scene.index == index;
    return ChoiceChip(
      selected: active,
      label: Text('${index + 1}'),
      selectedColor: _s.primary,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: active ? Colors.white : _s.ink, fontSize: 11, fontWeight: FontWeight.w700),
      onSelected: (_) {
        setState(() => _scene = _Scene.values[index]);
        setState(() => _sceneChanges += 1);
        _event('scene', 'Switched to ${_sceneTitles[index]}', _s.secondary);
      },
    );
  }

  Widget _skinDot(int index) {
    return GestureDetector(
      onTap: () {
        setState(() => _skinIndex = index);
        _event('skin', 'Skin changed to ${_skins[index].name}', _skins[index].primary);
      },
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _skins[index].primary,
          border: Border.all(
            color: _skinIndex == index ? _skins[index].tertiary : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _toggleChip(String label, bool value, void Function(bool value) assign) {
    return FilterChip(
      selected: value,
      selectedColor: _s.primary.withValues(alpha: 0.18),
      backgroundColor: Colors.white,
      checkmarkColor: _s.primary,
      label: Text(label),
      labelStyle: TextStyle(color: _s.ink, fontWeight: FontWeight.w700, fontSize: 11),
      onSelected: (selected) {
        setState(() => assign(selected));
      },
    );
  }

  Widget _sceneBody() {
    switch (_scene) {
      case _Scene.primer:
        return _primerScene();
      case _Scene.radiusStudio:
        return _radiusStudioScene();
      case _Scene.behaviorLab:
        return _behaviorLabScene();
      case _Scene.gallery:
        return _galleryScene();
      case _Scene.comparison:
        return _comparisonScene();
      case _Scene.compendium:
        return _compendiumScene();
    }
  }

  Widget _title(String text) {
    return Text(
      text,
      style: TextStyle(color: _s.ink, fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.2),
    );
  }

  Widget _panel({required String title, required String subtitle, required Widget child, Color? tint}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tint ?? _s.panel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _s.muted.withValues(alpha: 0.22)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: _s.shell.withValues(alpha: 0.05), blurRadius: 9, offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(color: _s.ink, fontWeight: FontWeight.w800, fontSize: 12.9)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: _s.muted, fontSize: 10.8, height: 1.34)),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _primerScene() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Primer Stage'),
          const SizedBox(height: 8),
          Text(
            'ClipRSuperellipse is ideal for modern cards and media surfaces where corners should feel smoother '
            'than a strict circular arc. This stage introduces the shape with practical, highly visible panels.',
            style: TextStyle(color: _s.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Live Primary Surface',
            subtitle: 'Interactive card shell clipped by ClipRSuperellipse.',
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    FilledButton.tonal(
                      onPressed: () {
                        _setPreset('dialog');
                      },
                      child: const Text('Dialog Radius'),
                    ),
                    FilledButton.tonal(
                      onPressed: () {
                        _setPreset('pill');
                      },
                      child: const Text('Pill Radius'),
                    ),
                    FilledButton.tonal(
                      onPressed: () {
                        _setPreset('ticket');
                      },
                      child: const Text('Ticket Radius'),
                    ),
                    FilledButton.tonal(
                      onPressed: () {
                        _setPreset('micro');
                      },
                      child: const Text('Micro Radius'),
                    ),
                    _toggleChip('scrim', _showScrim, (v) {
                      _showScrim = v;
                      _markControl('Scrim -> $v');
                    }),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 390,
                  child: _previewShell(
                    caption: 'ClipRSuperellipse preview',
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(child: _canvasBackground()),
                        if (_showGrid)
                          Positioned.fill(
                            child: IgnorePointer(
                              child: CustomPaint(painter: _GridOverlayPainter(color: _s.ink.withValues(alpha: 0.14))),
                            ),
                          ),
                        Center(
                          child: GestureDetector(
                            onTap: () => _markTap('Tapped primary preview surface'),
                            child: _superellipseCard(
                              width: _sizeWidth,
                              height: _sizeHeight,
                              child: _gradientContent(
                                title: 'Live Surface',
                                subtitle:
                                    'radius ${_allCorners.toStringAsFixed(1)} | ${_clipBehavior.name}',
                              ),
                            ),
                          ),
                        ),
                        if (_showGuides)
                          Positioned(
                            left: 20,
                            right: 20,
                            bottom: 14,
                            child: _guideStrip(
                              'Use linked corner mode for uniform shells; unlink to shape asymmetric tickets and side panels.',
                            ),
                          ),
                      ],
                    ),
                  ),
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
                  title: 'Three Common Uses',
                  subtitle: 'Card shell, avatar shell, and media tile.',
                  tint: _s.primary.withValues(alpha: 0.06),
                  child: Column(
                    children: <Widget>[
                      _scenarioTile(
                        title: 'Dashboard card shell',
                        detail: 'Continuous corners make dense data cards feel lighter.',
                        child: _superellipseCard(
                          width: 220,
                          height: 120,
                          child: _miniDataCard(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _scenarioTile(
                        title: 'Avatar and status shell',
                        detail: 'Soft clipping prevents jagged transitions on colorful avatars.',
                        child: _superellipseCard(
                          width: 220,
                          height: 120,
                          child: _avatarShell(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _scenarioTile(
                        title: 'Media tile',
                        detail: 'Photo/video thumbs look more refined than strict rounded rects.',
                        child: _superellipseCard(
                          width: 220,
                          height: 120,
                          child: _mediaShell(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_showGuides) ...<Widget>[
                const SizedBox(width: 12),
                SizedBox(
                  width: 330,
                  child: _panel(
                    title: 'Primer Notes',
                    subtitle: 'How to think about this widget in production UI.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('Wrap any visual child where smooth clipping is required.'),
                        _bullet('Use borderRadius to encode shape language for your design system.'),
                        _bullet('Pick clipBehavior intentionally; antiAlias is a strong default.'),
                        _bullet('Combine with border/glow overlays for premium shell components.'),
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

  Widget _radiusStudioScene() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Radius Studio'),
          const SizedBox(height: 8),
          Text(
            'This lab tunes corner radii interactively. Use linked mode for uniform corners or unlink for per-corner architecture.',
            style: TextStyle(color: _s.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Radius Controls',
            subtitle: 'Shape the superellipse profile with live sliders.',
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _toggleChip('link corners', _linkCorners, (v) {
                      _linkCorners = v;
                      if (v) {
                        _setLinkedCorners(_allCorners);
                      }
                      _markControl('Link corners -> $v');
                    }),
                    _toggleChip('border', _showBorder, (v) {
                      _showBorder = v;
                      _markControl('Border overlay -> $v');
                    }),
                    _toggleChip('glow', _showGlow, (v) {
                      _showGlow = v;
                      _markControl('Glow overlay -> $v');
                    }),
                  ],
                ),
                const SizedBox(height: 8),
                _sliderRow(
                  label: _linkCorners ? 'All corners' : 'Top left',
                  value: _linkCorners ? _allCorners : _tl,
                  onChanged: (v) => _setCorner(_linkCorners ? 'all' : 'tl', v),
                ),
                if (!_linkCorners) ...<Widget>[
                  _sliderRow(label: 'Top right', value: _tr, onChanged: (v) => _setCorner('tr', v)),
                  _sliderRow(label: 'Bottom right', value: _br, onChanged: (v) => _setCorner('br', v)),
                  _sliderRow(label: 'Bottom left', value: _bl, onChanged: (v) => _setCorner('bl', v)),
                ],
                const SizedBox(height: 6),
                _sliderRow(
                  label: 'Preview width',
                  min: 180,
                  max: 360,
                  value: _sizeWidth,
                  onChanged: (v) {
                    setState(() => _sizeWidth = v);
                    _markControl('Preview width -> ${v.toStringAsFixed(1)}');
                  },
                ),
                _sliderRow(
                  label: 'Preview height',
                  min: 110,
                  max: 260,
                  value: _sizeHeight,
                  onChanged: (v) {
                    setState(() => _sizeHeight = v);
                    _markControl('Preview height -> ${v.toStringAsFixed(1)}');
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
                  title: 'Radius Playground',
                  subtitle: 'Same content, different size and corner architecture.',
                  tint: _s.secondary.withValues(alpha: 0.06),
                  child: SizedBox(
                    height: 500,
                    child: _previewShell(
                      caption: 'radius architecture board',
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(child: _canvasBackground()),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                _superellipseCard(
                                  width: _sizeWidth,
                                  height: _sizeHeight,
                                  child: _radiusGrid(),
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: <Widget>[
                                    _radiusBadge('TL', _tl),
                                    _radiusBadge('TR', _tr),
                                    _radiusBadge('BR', _br),
                                    _radiusBadge('BL', _bl),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _panel(
                  title: 'Preset Deck',
                  subtitle: 'Reusable profiles for dialogs, tickets, and chips.',
                  child: Column(
                    children: <Widget>[
                      _presetRow('Dialog Surface', 'Balanced corners for app dialogs.', 'dialog'),
                      _presetRow('Pill Capsule', 'Large radius for floating controls.', 'pill'),
                      _presetRow('Ticket Stub', 'Asymmetric profile for promo cards.', 'ticket'),
                      _presetRow('Micro Radius', 'Subtle rounding for dense utility blocks.', 'micro'),
                      const SizedBox(height: 8),
                      Text(
                        'Tip: Use linked mode for system tokens and unlink only for bespoke layouts.',
                        style: TextStyle(color: _s.muted, fontSize: 11.1, height: 1.33),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _behaviorLabScene() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Clip Behavior Lab'),
          const SizedBox(height: 8),
          Text(
            'Clip behavior affects edge quality and composition details. This section compares none, hardEdge, antiAlias, and antiAliasWithSaveLayer.',
            style: TextStyle(color: _s.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Behavior Selector',
            subtitle: 'Switch the active clip behavior and inspect the visual result.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                for (final behavior in Clip.values)
                  ChoiceChip(
                    selected: _clipBehavior == behavior,
                    label: Text(behavior.name),
                    onSelected: (_) {
                      setState(() => _clipBehavior = behavior);
                      setState(() => _behaviorChanges += 1);
                      _event('behavior', 'clipBehavior -> ${behavior.name}', _s.tertiary);
                    },
                  ),
                _toggleChip('scrim', _showScrim, (v) {
                  _showScrim = v;
                  _markControl('Scrim -> $v');
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Behavior Grid',
            subtitle: 'Each card receives intentionally overflow-heavy content to expose clipping differences.',
            tint: _s.tertiary.withValues(alpha: 0.06),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: _behaviorCard(Clip.none)),
                    const SizedBox(width: 10),
                    Expanded(child: _behaviorCard(Clip.hardEdge)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(child: _behaviorCard(Clip.antiAlias)),
                    const SizedBox(width: 10),
                    Expanded(child: _behaviorCard(Clip.antiAliasWithSaveLayer)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_showGuides)
            _panel(
              title: 'Behavior Guidance',
              subtitle: 'Recommended defaults and caveats.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _bullet('Use antiAlias as default for user-facing clipped cards and media.'),
                  _bullet('hardEdge can work for strict pixel grids and lower-cost clipping.'),
                  _bullet('none is useful for debugging overflow but usually not production-ready.'),
                  _bullet('antiAliasWithSaveLayer is situational when compositing artifacts appear.'),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _galleryScene() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Pattern Gallery'),
          const SizedBox(height: 8),
          Text(
            'Aesthetic gallery of surfaces clipped with ClipRSuperellipse: abstract gradients, animated orbits, dashboards, and route cards.',
            style: TextStyle(color: _s.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Gallery Controls',
            subtitle: 'Animate pattern layers and inspect shell framing options.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _toggleChip('animate patterns', _animatePatterns, (v) {
                  _animatePatterns = v;
                  if (v) {
                    _pulse.repeat();
                  } else {
                    _pulse.stop();
                  }
                  _markControl('Animate patterns -> $v');
                }),
                _toggleChip('border', _showBorder, (v) {
                  _showBorder = v;
                  _markControl('Border overlay -> $v');
                }),
                _toggleChip('glow', _showGlow, (v) {
                  _showGlow = v;
                  _markControl('Glow overlay -> $v');
                }),
                _toggleChip('scrim', _showScrim, (v) {
                  _showScrim = v;
                  _markControl('Scrim -> $v');
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Visual Deck',
            subtitle: 'Different content classes clipped by one superellipse radius profile.',
            tint: _s.primary.withValues(alpha: 0.05),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _galleryTile(
                        title: 'Orbit Scene',
                        caption: 'Animated painter + overlays',
                        child: _animatedOrbit(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _galleryTile(
                        title: 'Gradient Mesh',
                        caption: 'Layered gradients for hero cards',
                        child: _meshPanel(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _galleryTile(
                        title: 'Control Console',
                        caption: 'Dense UI still benefits from smooth corners',
                        child: _consolePanel(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _galleryTile(
                        title: 'Route Ticket',
                        caption: 'Asymmetric ticket profile for travel style cards',
                        child: _ticketPanel(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _comparisonScene() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Comparison Observatory'),
          const SizedBox(height: 8),
          Text(
            'Compare the same content under ClipRSuperellipse, ClipRRect, and ClipPath(ContinuousRectangleBorder) to understand shape character differences.',
            style: TextStyle(color: _s.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Comparison Deck',
            subtitle: 'One content source, three clipping strategies.',
            tint: _s.secondary.withValues(alpha: 0.06),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _compareCard(
                        title: 'ClipRSuperellipse',
                        detail: 'Continuous smooth transition, less geometric tension at corners.',
                        child: ClipRSuperellipse(
                          borderRadius: _radius,
                          clipBehavior: _clipBehavior,
                          child: _comparisonContent(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _compareCard(
                        title: 'ClipRRect',
                        detail: 'Standard rounded rectangle, more circular arc feeling.',
                        child: ClipRRect(
                          borderRadius: _radius,
                          clipBehavior: _clipBehavior,
                          child: _comparisonContent(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _compareCard(
                        title: 'ClipPath + Continuous',
                        detail: 'ShapeBorder clip path for continuous corners.',
                        child: ClipPath(
                          clipBehavior: _clipBehavior,
                          clipper: ShapeBorderClipper(shape: ContinuousRectangleBorder(borderRadius: _radius)),
                          child: _comparisonContent(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _panel(
                  title: 'Interpretation Notes',
                  subtitle: 'When to choose each clipping strategy.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _bullet('ClipRSuperellipse gives modern smooth corners with direct widget ergonomics.'),
                      _bullet('ClipRRect is fast and familiar for classic rounded cards.'),
                      _bullet('ShapeBorder clip paths help when you need custom border logic alongside clipping.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _compendiumScene() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Verification Compendium'),
          const SizedBox(height: 12),
          _panel(
            title: 'Feature Matrix',
            subtitle: 'Coverage of ClipRSuperellipse behavior shown in this deep demo.',
            child: Column(
              children: <Widget>[
                _matrix('Constructor usage', 'ClipRSuperellipse(borderRadius, clipBehavior, child) across multiple scenes.'),
                _matrix('Radius strategy', 'Linked and per-corner radius control, presets, and asymmetric ticket profiles.'),
                _matrix('Clip behavior', 'Visual comparison for none/hardEdge/antiAlias/antiAliasWithSaveLayer.'),
                _matrix('Content diversity', 'Data cards, avatars, media, animated painters, route-like tickets.'),
                _matrix('Design guidance', 'Practical recommendations and anti-pattern warnings included.'),
                _matrix('Interaction emphasis', 'Tap events and controls modify visuals directly without assert-heavy style.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Operational quality guidance for ClipRSuperellipse.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do align radius tokens with your design system',
                  detail: 'Consistent radius language keeps cards and dialogs visually coherent.',
                ),
                _doDont(
                  good: true,
                  title: 'Do test clipBehavior where translucent overlays exist',
                  detail: 'Edge quality depends on compositing and anti-aliasing choices.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont use Clip.none for user-facing polished cards',
                  detail: 'Overflow at corners undermines the shape intent.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont treat all corners as equal in expressive layouts',
                  detail: 'Asymmetric radii can convey hierarchy and motion direction.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Quick practical answers.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'When should I choose ClipRSuperellipse over ClipRRect?',
                  a: 'When you want smoother corner transitions and a more contemporary shell shape.',
                ),
                _qa(
                  q: 'Is per-corner editing useful?',
                  a: 'Yes for ticket layouts, side sheets, and directional cards that need shape asymmetry.',
                ),
                _qa(
                  q: 'Does this replace custom clipping?',
                  a: 'No. It covers a common smooth-corner case with simple widget composition.',
                ),
                _qa(
                  q: 'What should I inspect in interpreter testing?',
                  a: 'Radius propagation, clipBehavior changes, and visual stability under animation/interaction.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Completion Checklist',
            subtitle: 'Deep-demo quality gates for this file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Multiple visual displays show ClipRSuperellipse in distinct UI contexts.'),
                _check('Radius and clip behavior controls are interactive and directly visible.'),
                _check('Comparison section clarifies superellipse vs common alternatives.'),
                _check('Documentation within demo explains what and why, not only API calls.'),
                _check('Demo is interaction-focused for interpreter integration validation.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _s.tertiary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _s.tertiary.withValues(alpha: 0.32)),
            ),
            child: Text(
              'ClipRSuperellipse is a practical tool for premium surface clipping. '
              'With intentional radius tokens and behavior selection, it supports expressive shells '
              'across cards, media, and motion-rich interfaces.',
              style: TextStyle(color: _s.ink, fontSize: 11.9, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewShell({required String caption, required Widget child}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _s.muted.withValues(alpha: 0.24)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _s.paper,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(bottom: BorderSide(color: _s.muted.withValues(alpha: 0.24))),
            ),
            child: Row(
              children: <Widget>[
                Text(caption, style: TextStyle(color: _s.muted, fontSize: 10.8)),
                const Spacer(),
                Text(
                  'clip: ${_clipBehavior.name}',
                  style: TextStyle(color: _s.muted, fontFamily: 'monospace', fontSize: 10.3),
                ),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _canvasBackground() {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) {
        final t = _animatePatterns ? _pulse.value : 0.0;
        final start = Alignment(-1 + 2 * t, -1 + t * 0.2);
        final end = Alignment(1 - 1.3 * t, 1);
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                _s.primary.withValues(alpha: 0.23),
                _s.secondary.withValues(alpha: 0.22),
                _s.tertiary.withValues(alpha: 0.2),
              ],
              begin: start,
              end: end,
            ),
          ),
          child: CustomPaint(
            painter: _NoisePainter(color: Colors.white.withValues(alpha: 0.18)),
          ),
        );
      },
    );
  }

  Widget _superellipseCard({required double width, required double height, required Widget child}) {
    final radius = _radius;

    Widget card = SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ClipRSuperellipse(
              borderRadius: radius,
              clipBehavior: _clipBehavior,
              child: child,
            ),
          ),
          if (_showScrim)
            Positioned.fill(
              child: IgnorePointer(
                child: ClipRSuperellipse(
                  borderRadius: radius,
                  clipBehavior: _clipBehavior,
                  child: Container(color: Colors.black.withValues(alpha: 0.14)),
                ),
              ),
            ),
          if (_showBorder)
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    shape: ContinuousRectangleBorder(
                      borderRadius: radius,
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.85), width: 1.2),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    if (_showGlow) {
      card = DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _s.shell.withValues(alpha: 0.18),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: card,
      );
    }

    return card;
  }

  Widget _gradientContent({required String title, required String subtitle}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_s.primary.withValues(alpha: 0.82), _s.secondary.withValues(alpha: 0.85), _s.tertiary.withValues(alpha: 0.82)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _CheckerPainter(color: Colors.white.withValues(alpha: 0.16))),
            ),
          ),
          Positioned(
            left: 14,
            top: 12,
            right: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 11.2)),
              ],
            ),
          ),
          Positioned(
            left: 14,
            right: 14,
            bottom: 12,
            child: Row(
              children: <Widget>[
                _chip('radius ${_allCorners.toStringAsFixed(0)}'),
                const SizedBox(width: 6),
                _chip(_clipBehavior.name),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10.2, fontWeight: FontWeight.w700)),
    );
  }

  Widget _miniDataCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_s.primary.withValues(alpha: 0.9), _s.secondary.withValues(alpha: 0.78)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Monthly Active Users', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11.4)),
          const Spacer(),
          Row(
            children: <Widget>[
              const Text('128k', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 21)),
              const SizedBox(width: 8),
              Icon(Icons.trending_up, color: Colors.white.withValues(alpha: 0.9), size: 18),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: 0.72,
            minHeight: 6,
            backgroundColor: Colors.white.withValues(alpha: 0.25),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.88)),
          ),
        ],
      ),
    );
  }

  Widget _avatarShell() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_s.secondary.withValues(alpha: 0.88), _s.primary.withValues(alpha: 0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white.withValues(alpha: 0.85),
            child: Icon(Icons.person, color: _s.secondary, size: 26),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text('Nora Mendez', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.8)),
                SizedBox(height: 4),
                Text('Online now - route editor', style: TextStyle(color: Colors.white70, fontSize: 10.7)),
              ],
            ),
          ),
          Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF8CFF94), shape: BoxShape.circle)),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _mediaShell() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[_s.tertiary.withValues(alpha: 0.82), _s.primary.withValues(alpha: 0.78)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(painter: _OrbitPainter(color: Colors.white.withValues(alpha: 0.2), progress: _pulse.value)),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.28), borderRadius: BorderRadius.circular(999)),
            child: const Text('04:32', style: TextStyle(color: Colors.white, fontSize: 10.4, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }

  Widget _scenarioTile({required String title, required String detail, required Widget child}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        child,
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: TextStyle(color: _s.ink, fontWeight: FontWeight.w800, fontSize: 11.8)),
              const SizedBox(height: 4),
              Text(detail, style: TextStyle(color: _s.muted, fontSize: 10.9, height: 1.32)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _guideStrip(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10.8, height: 1.32)),
    );
  }

  Widget _sliderRow({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    double min = 0,
    double max = 120,
  }) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 120,
          child: Text(label, style: TextStyle(color: _s.ink, fontWeight: FontWeight.w700, fontSize: 11.1)),
        ),
        Expanded(
          child: Slider(
            min: min,
            max: max,
            value: value.clamp(min, max),
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 44,
          child: Text(value.toStringAsFixed(0), textAlign: TextAlign.right, style: TextStyle(color: _s.muted, fontFamily: 'monospace')),
        ),
      ],
    );
  }

  Widget _radiusGrid() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_s.primary.withValues(alpha: 0.84), _s.secondary.withValues(alpha: 0.82)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _CheckerPainter(color: Colors.white.withValues(alpha: 0.16))),
            ),
          ),
          Positioned(
            left: 12,
            top: 12,
            child: _chip('TL ${_tl.toStringAsFixed(0)}'),
          ),
          Positioned(
            right: 12,
            top: 12,
            child: _chip('TR ${_tr.toStringAsFixed(0)}'),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: _chip('BR ${_br.toStringAsFixed(0)}'),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: _chip('BL ${_bl.toStringAsFixed(0)}'),
          ),
          Center(
            child: Text(
              'Linked: $_linkCorners',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.95), fontSize: 14.2, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _radiusBadge(String key, double value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: _s.secondary.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _s.secondary.withValues(alpha: 0.3)),
      ),
      child: Text('$key: ${value.toStringAsFixed(0)}', style: TextStyle(color: _s.ink, fontSize: 10.5, fontWeight: FontWeight.w700)),
    );
  }

  Widget _presetRow(String title, String detail, String key) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _s.paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _s.muted.withValues(alpha: 0.24)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: _s.ink, fontWeight: FontWeight.w700, fontSize: 11.4)),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _s.muted, fontSize: 10.6, height: 1.3)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: () {
              _setPreset(key);
            },
            child: const Text('apply'),
          ),
        ],
      ),
    );
  }

  Widget _behaviorCard(Clip behavior) {
    final active = _clipBehavior == behavior;
    final radius = BorderRadius.only(
      topLeft: Radius.circular(_tl),
      topRight: Radius.circular(_tr),
      bottomLeft: Radius.circular(_bl),
      bottomRight: Radius.circular(_br),
    );

    return GestureDetector(
      onTap: () {
        setState(() => _clipBehavior = behavior);
        _event('behavior', 'Selected ${behavior.name} from behavior grid', _s.tertiary);
      },
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: active ? _s.primary.withValues(alpha: 0.08) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: active ? _s.primary : _s.muted.withValues(alpha: 0.26), width: active ? 1.4 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(behavior.name, style: TextStyle(color: _s.ink, fontWeight: FontWeight.w800, fontSize: 11.6)),
            const SizedBox(height: 6),
            SizedBox(
              height: 170,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[_s.primary.withValues(alpha: 0.85), _s.secondary.withValues(alpha: 0.82)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ClipRSuperellipse(
                      borderRadius: radius,
                      clipBehavior: behavior,
                      child: Container(
                        width: 190,
                        height: 116,
                        color: Colors.white.withValues(alpha: 0.9),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              left: -18,
                              top: -22,
                              child: Container(width: 78, height: 78, decoration: BoxDecoration(color: _s.tertiary.withValues(alpha: 0.8), shape: BoxShape.circle)),
                            ),
                            Positioned(
                              right: -26,
                              bottom: -22,
                              child: Container(width: 84, height: 84, decoration: BoxDecoration(color: _s.primary.withValues(alpha: 0.72), shape: BoxShape.circle)),
                            ),
                            Center(
                              child: Text(
                                behavior.name,
                                style: TextStyle(color: _s.ink, fontWeight: FontWeight.w700, fontSize: 11.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _galleryTile({required String title, required String caption, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(color: _s.ink, fontWeight: FontWeight.w800, fontSize: 11.6)),
        const SizedBox(height: 2),
        Text(caption, style: TextStyle(color: _s.muted, fontSize: 10.5)),
        const SizedBox(height: 6),
        _superellipseCard(width: 320, height: 180, child: child),
      ],
    );
  }

  Widget _animatedOrbit() {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) {
        final t = _animatePatterns ? _pulse.value : 0.0;
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: <Color>[_s.primary.withValues(alpha: 0.78), _s.secondary.withValues(alpha: 0.74), _s.tertiary.withValues(alpha: 0.7)],
                  center: Alignment(0.3 - 0.4 * t, -0.2 + 0.2 * t),
                  radius: 1.1,
                ),
              ),
            ),
            CustomPaint(painter: _OrbitPainter(color: Colors.white.withValues(alpha: 0.3), progress: t)),
          ],
        );
      },
    );
  }

  Widget _meshPanel() {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) {
        final t = _animatePatterns ? _pulse.value : 0.0;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color.lerp(_s.primary, _s.secondary, 0.35 + 0.25 * math.sin(t * math.pi * 2))!,
                Color.lerp(_s.secondary, _s.tertiary, 0.4 + 0.2 * math.cos(t * math.pi * 2))!,
                Color.lerp(_s.primary, _s.tertiary, 0.6)!,
              ],
              begin: Alignment(-1 + 2 * t, -1),
              end: Alignment(1 - t, 1),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(child: CustomPaint(painter: _NoisePainter(color: Colors.white.withValues(alpha: 0.18)))),
              Positioned(
                left: 12,
                top: 12,
                child: _chip('mesh phase ${(t * 100).toStringAsFixed(0)}%'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _consolePanel() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_s.secondary.withValues(alpha: 0.86), _s.primary.withValues(alpha: 0.83)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.tune, color: Colors.white, size: 16),
                const SizedBox(width: 6),
                const Text('Operations Console', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11.6)),
                const Spacer(),
                _chip('stable'),
              ],
            ),
            const SizedBox(height: 10),
            _consoleBar('render', 0.78),
            const SizedBox(height: 6),
            _consoleBar('bridge', 0.66),
            const SizedBox(height: 6),
            _consoleBar('script', 0.91),
          ],
        ),
      ),
    );
  }

  Widget _consoleBar(String name, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(name, style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 10.5)),
        const SizedBox(height: 3),
        LinearProgressIndicator(
          value: value,
          minHeight: 6,
          backgroundColor: Colors.white.withValues(alpha: 0.22),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.9)),
        ),
      ],
    );
  }

  Widget _ticketPanel() {
    final ticketRadius = BorderRadius.only(
      topLeft: Radius.circular(54),
      topRight: Radius.circular(14),
      bottomRight: Radius.circular(54),
      bottomLeft: Radius.circular(14),
    );
    return ClipRSuperellipse(
      borderRadius: ticketRadius,
      clipBehavior: _clipBehavior,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[_s.tertiary.withValues(alpha: 0.86), _s.primary.withValues(alpha: 0.83)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: CustomPaint(painter: _CheckerPainter(color: Colors.white.withValues(alpha: 0.15)))),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text('RTE-4482', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  SizedBox(height: 4),
                  Text('Cityline Transfer', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  Spacer(),
                  Text('Gate C4 - Boarding in 08m', style: TextStyle(color: Colors.white, fontSize: 10.8)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _compareCard({required String title, required String detail, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _s.muted.withValues(alpha: 0.24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: _s.ink, fontWeight: FontWeight.w800, fontSize: 11.3)),
          const SizedBox(height: 4),
          Text(detail, style: TextStyle(color: _s.muted, fontSize: 10.4, height: 1.31)),
          const SizedBox(height: 8),
          SizedBox(height: 180, child: child),
        ],
      ),
    );
  }

  Widget _comparisonContent() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_s.primary.withValues(alpha: 0.8), _s.secondary.withValues(alpha: 0.82)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: CustomPaint(painter: _CheckerPainter(color: Colors.white.withValues(alpha: 0.15)))),
          Positioned(
            left: 10,
            top: 10,
            child: _chip('comparison'),
          ),
          Positioned(
            right: -18,
            top: -18,
            child: Container(width: 74, height: 74, decoration: BoxDecoration(color: _s.tertiary.withValues(alpha: 0.8), shape: BoxShape.circle)),
          ),
          Positioned(
            left: -24,
            bottom: -18,
            child: Container(width: 84, height: 84, decoration: BoxDecoration(color: _s.primary.withValues(alpha: 0.72), shape: BoxShape.circle)),
          ),
        ],
      ),
    );
  }

  Widget _metricsPanel() {
    return _panel(
      title: 'Global Metrics',
      subtitle: 'Session-level interaction counters.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _metric('tap events', '$_tapCount', _s.primary),
          _metric('controls', '$_controlChanges', _s.secondary),
          _metric('scene changes', '$_sceneChanges', _s.tertiary),
          _metric('behavior changes', '$_behaviorChanges', _s.primary),
          _metric('timeline events', '${_events.length}', _s.secondary),
        ],
      ),
    );
  }

  Widget _metric(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
      child: Text('$label: $value', style: TextStyle(color: _s.ink, fontSize: 10.2, fontWeight: FontWeight.w700)),
    );
  }

  Widget _matrix(String key, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _s.muted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 154,
            child: Text(key, style: TextStyle(color: _s.primary, fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 10.8)),
          ),
          Expanded(child: Text(value, style: TextStyle(color: _s.ink, fontSize: 11.2, height: 1.33))),
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
        border: Border.all(color: tone.withValues(alpha: 0.28)),
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
                Text(title, style: TextStyle(color: _s.ink, fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _s.muted, fontSize: 11.1, height: 1.33)),
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
        border: Border.all(color: _s.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Q: $q', style: TextStyle(color: _s.ink, fontWeight: FontWeight.w700, fontSize: 11.9)),
          const SizedBox(height: 4),
          Text('A: $a', style: TextStyle(color: _s.muted, fontSize: 11.1, height: 1.33)),
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
          Expanded(child: Text(text, style: TextStyle(color: _s.ink, fontSize: 11.3))),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.chevron_right, size: 16, color: _s.primary),
          const SizedBox(width: 4),
          Expanded(child: Text(text, style: TextStyle(color: _s.ink, fontSize: 11.1))),
        ],
      ),
    );
  }

  Widget _timelinePanel() {
    return Container(
      decoration: BoxDecoration(color: _s.panel, border: Border(left: BorderSide(color: _s.muted.withValues(alpha: 0.25)))),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: _s.primary.withValues(alpha: 0.08),
              border: Border(bottom: BorderSide(color: _s.muted.withValues(alpha: 0.24))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Demo Timeline', style: TextStyle(color: _s.ink, fontWeight: FontWeight.w800, fontSize: 13.2)),
                const SizedBox(height: 4),
                Text('Radius edits, behavior flips, and scene changes are logged here.', style: TextStyle(color: _s.muted, fontSize: 10.6)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _metric('events', '${_events.length}', _s.primary),
                    _metric('clip', _clipBehavior.name, _s.secondary),
                    _metric('scene', '${_scene.index + 1}', _s.tertiary),
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
                final e = _events[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: e.tone.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: e.tone.withValues(alpha: 0.25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              e.channel,
                              style: TextStyle(color: _s.ink, fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 10.4),
                            ),
                          ),
                          Text(
                            _clock(e.at),
                            style: TextStyle(color: _s.muted, fontFamily: 'monospace', fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(e.message, style: TextStyle(color: _s.ink, fontSize: 11.1, height: 1.31)),
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

  String _clock(DateTime at) {
    final h = at.hour.toString().padLeft(2, '0');
    final m = at.minute.toString().padLeft(2, '0');
    final s = at.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: _s.shell.withValues(alpha: 0.07),
      child: Row(
        children: <Widget>[
          Text(_sceneTitles[_scene.index], style: TextStyle(color: _s.muted, fontWeight: FontWeight.w700, fontSize: 11)),
          const Spacer(),
          Text(
            'Radius ${_allCorners.toStringAsFixed(1)} | ${_clipBehavior.name} | ${_s.name}',
            style: TextStyle(color: _s.muted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _GridOverlayPainter extends CustomPainter {
  const _GridOverlayPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..strokeWidth = 1;

    var x = 0.0;
    while (x <= size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
      x += 24;
    }

    var y = 0.0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
      y += 24;
    }
  }

  @override
  bool shouldRepaint(covariant _GridOverlayPainter oldDelegate) => oldDelegate.color != color;
}

class _CheckerPainter extends CustomPainter {
  const _CheckerPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const step = 20.0;
    var row = 0;
    for (double y = 0; y < size.height + step; y += step) {
      var col = 0;
      for (double x = 0; x < size.width + step; x += step) {
        if ((row + col).isEven) {
          canvas.drawRect(Rect.fromLTWH(x, y, step, step), paint);
        }
        col++;
      }
      row++;
    }
  }

  @override
  bool shouldRepaint(covariant _CheckerPainter oldDelegate) => oldDelegate.color != color;
}

class _NoisePainter extends CustomPainter {
  const _NoisePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (var i = 0; i < 160; i++) {
      final dx = ((i * 47) % 1000) / 1000 * size.width;
      final dy = ((i * 89) % 1000) / 1000 * size.height;
      final r = 0.6 + ((i * 13) % 10) / 10;
      canvas.drawCircle(Offset(dx, dy), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _NoisePainter oldDelegate) => oldDelegate.color != color;
}

class _OrbitPainter extends CustomPainter {
  const _OrbitPainter({required this.color, required this.progress});

  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final center = Offset(size.width / 2, size.height / 2);
    for (var i = 0; i < 5; i++) {
      final rx = 26 + i * 22.0;
      final ry = 16 + i * 14.0;
      final rect = Rect.fromCenter(center: center, width: rx * 2, height: ry * 2);
      canvas.drawOval(rect, p);

      final angle = progress * math.pi * 2 + i * 0.7;
      final dot = Offset(center.dx + rx * math.cos(angle), center.dy + ry * math.sin(angle));
      canvas.drawCircle(dot, 2.2, Paint()..color = color.withValues(alpha: 0.85));
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.progress != progress;
  }
}
