import 'dart:math' as math;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const _CheckedModeBannerDeepDemo();
}

enum _DemoSection {
  primer,
  gallery,
  runtime,
  internals,
  integration,
  compendium,
}

enum _BackdropStyle {
  nebula,
  draftingGrid,
  ringField,
}

class _Palette {
  final String name;
  final Color frame;
  final Color paper;
  final Color panel;
  final Color ink;
  final Color muted;
  final Color accentA;
  final Color accentB;
  final Color accentC;

  const _Palette({
    required this.name,
    required this.frame,
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
    name: 'Lighthouse',
    frame: Color(0xFF142633),
    paper: Color(0xFFF2F8FC),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF213846),
    muted: Color(0xFF6F8797),
    accentA: Color(0xFF1E86DE),
    accentB: Color(0xFF199A77),
    accentC: Color(0xFFD2901D),
  ),
  _Palette(
    name: 'Forest Ops',
    frame: Color(0xFF1A241E),
    paper: Color(0xFFF4FAF5),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF29372E),
    muted: Color(0xFF748679),
    accentA: Color(0xFF2E8D3B),
    accentB: Color(0xFF1F8F98),
    accentC: Color(0xFFB88727),
  ),
  _Palette(
    name: 'Copper Deck',
    frame: Color(0xFF2B221D),
    paper: Color(0xFFFDF5ED),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF3B2F29),
    muted: Color(0xFF8C7C72),
    accentA: Color(0xFFB96533),
    accentB: Color(0xFF2F89A2),
    accentC: Color(0xFF9C8518),
  ),
];

class _SampleScenario {
  final String id;
  final String title;
  final String purpose;
  final IconData icon;
  final Color tone;

  const _SampleScenario({
    required this.id,
    required this.title,
    required this.purpose,
    required this.icon,
    required this.tone,
  });
}

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

const _sectionLabels = <String>[
  '1 Primer Studio',
  '2 Banner Gallery',
  '3 Runtime Toggle Lab',
  '4 Internals Comparison',
  '5 Integration Deck',
  '6 Verification Compendium',
];

class _CheckedModeBannerDeepDemo extends StatefulWidget {
  const _CheckedModeBannerDeepDemo();

  @override
  State<_CheckedModeBannerDeepDemo> createState() => _CheckedModeBannerDeepDemoState();
}

class _CheckedModeBannerDeepDemoState extends State<_CheckedModeBannerDeepDemo> {
  _DemoSection _section = _DemoSection.primer;
  int _paletteIndex = 0;
  _BackdropStyle _backdropStyle = _BackdropStyle.nebula;

  bool _showTimeline = true;
  bool _showGuidance = true;
  bool _showMetrics = true;
  bool _verbose = false;
  bool _showCrosshair = true;

  bool _debugWrapperEnabled = true;
  bool _showInnerBannerInCards = true;
  bool _simulateRelease = false;
  bool _showRawBannerCounterpart = true;

  double _viewportWidth = 440;
  double _viewportHeight = 280;
  double _cardSpacing = 10;
  double _previewScale = 1.0;

  int _tapCount = 0;
  int _controlChanges = 0;
  int _modeChanges = 0;
  int _bannerToggleCount = 0;

  final List<_LogEvent> _events = <_LogEvent>[];
  final Map<String, int> _scenarioHits = <String, int>{};

  _Palette get _p => _palettes[_paletteIndex];

  List<_SampleScenario> get _scenarios => <_SampleScenario>[
        _SampleScenario(
          id: 'dashboard',
          title: 'Dashboard Hero',
          purpose: 'Show debug ribbon over data-rich UI shell.',
          icon: Icons.dashboard_customize_outlined,
          tone: _p.accentA,
        ),
        _SampleScenario(
          id: 'media',
          title: 'Media Preview',
          purpose: 'Ensure overlay remains visible over visual-heavy content.',
          icon: Icons.perm_media_outlined,
          tone: _p.accentB,
        ),
        _SampleScenario(
          id: 'settings',
          title: 'Settings Stack',
          purpose: 'Observe ribbon in form-like and list-driven screens.',
          icon: Icons.settings_suggest,
          tone: _p.accentC,
        ),
        _SampleScenario(
          id: 'map',
          title: 'Map Overlay',
          purpose: 'Ribbon above layered overlays and markers.',
          icon: Icons.map_outlined,
          tone: _p.accentA,
        ),
      ];

  @override
  void initState() {
    super.initState();
    _log('system', 'CheckedModeBanner deep demo initialized.', _p.accentA);
  }

  void _log(String lane, String message, Color tone) {
    final event = _LogEvent(at: DateTime.now(), lane: lane, message: message, tone: tone);
    setState(() {
      _events.insert(0, event);
      if (_events.length > 160) {
        _events.removeRange(160, _events.length);
      }
    });
    if (_verbose) {
      debugPrint('[CheckedModeBanner][$lane] $message');
    }
  }

  void _recordTap(String lane, String message) {
    setState(() => _tapCount += 1);
    _log(lane, message, _p.accentA);
  }

  void _recordControl(String lane, String message) {
    setState(() => _controlChanges += 1);
    _log(lane, message, _p.accentB);
  }

  void _recordMode(String lane, String message) {
    setState(() => _modeChanges += 1);
    _log(lane, message, _p.accentC);
  }

  void _recordScenarioHit(_SampleScenario scenario, String source) {
    setState(() {
      _scenarioHits[scenario.id] = (_scenarioHits[scenario.id] ?? 0) + 1;
    });
    _log('scenario', '${scenario.title} activated via $source', scenario.tone);
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
                  Expanded(child: _sectionBody()),
                  if (_showTimeline)
                    SizedBox(
                      width: 380,
                      child: _timelinePane(),
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
          colors: <Color>[_p.frame, _p.accentA.withValues(alpha: 0.88)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.verified_outlined, color: Colors.white, size: 27),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'CheckedModeBanner Deep Demo',
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
                  'Debug Ribbon Wrapper',
                  style: TextStyle(color: Colors.white, fontSize: 10.2, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'CheckedModeBanner wraps a child and shows a DEBUG banner in debug mode. '
            'This demo explores wrapper behavior, runtime toggles, explicit Banner comparisons, and integration patterns '
            'for interpreter-side visual validation.',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.95), fontSize: 12.2, height: 1.35),
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
          Text('Section', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _sectionLabels.length; i++) _sectionChip(i),
          const SizedBox(width: 10),
          Text('Palette', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
          const SizedBox(width: 10),
          _toggleChip('timeline', _showTimeline, (v) => _showTimeline = v),
          _toggleChip('guidance', _showGuidance, (v) => _showGuidance = v),
          _toggleChip('metrics', _showMetrics, (v) => _showMetrics = v),
          _toggleChip('crosshair', _showCrosshair, (v) => _showCrosshair = v),
          _toggleChip('verbose', _verbose, (v) => _verbose = v),
        ],
      ),
    );
  }

  Widget _sectionChip(int index) {
    final selected = _section.index == index;
    return ChoiceChip(
      selected: selected,
      selectedColor: _p.accentA,
      backgroundColor: Colors.white,
      label: Text('${index + 1}'),
      labelStyle: TextStyle(color: selected ? Colors.white : _p.ink, fontSize: 11, fontWeight: FontWeight.w700),
      onSelected: (_) {
        setState(() => _section = _DemoSection.values[index]);
        _log('section', 'Switched to ${_sectionLabels[index]}', _p.accentB);
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
          border: Border.all(
            color: _paletteIndex == index ? _palettes[index].accentC : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _toggleChip(String label, bool value, void Function(bool) assign) {
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

  Widget _sectionBody() {
    switch (_section) {
      case _DemoSection.primer:
        return _primerSection();
      case _DemoSection.gallery:
        return _gallerySection();
      case _DemoSection.runtime:
        return _runtimeSection();
      case _DemoSection.internals:
        return _internalsSection();
      case _DemoSection.integration:
        return _integrationSection();
      case _DemoSection.compendium:
        return _compendiumSection();
    }
  }

  Widget _title(String text) {
    return Text(
      text,
      style: TextStyle(color: _p.ink, fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.2),
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
        color: tint ?? _p.panel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _p.muted.withValues(alpha: 0.22)),
        boxShadow: <BoxShadow>[
          BoxShadow(color: _p.frame.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 4)),
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

  Widget _primerSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Primer Studio'),
          const SizedBox(height: 8),
          Text(
            'CheckedModeBanner has one job: wrap a child and add a DEBUG ribbon in debug mode. '
            'This primer toggles the wrapper and compares visual output immediately.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Primer Controls',
            subtitle: 'Toggle wrapper and preview dimensions.',
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _toggleChip('debug wrapper enabled', _debugWrapperEnabled, (v) {
                      _debugWrapperEnabled = v;
                      _bannerToggleCount += 1;
                      _recordMode('primer', 'debug wrapper enabled -> $v');
                    }),
                    _toggleChip('simulate release bypass', _simulateRelease, (v) {
                      _simulateRelease = v;
                      _bannerToggleCount += 1;
                      _recordMode('primer', 'simulate release bypass -> $v');
                    }),
                  ],
                ),
                _slider(
                  label: 'viewport width',
                  value: _viewportWidth,
                  min: 280,
                  max: 620,
                  divisions: 34,
                  color: _p.accentA,
                  onChanged: (v) {
                    setState(() => _viewportWidth = v);
                    _recordControl('primer', 'viewport width -> ${v.toStringAsFixed(0)}');
                  },
                ),
                _slider(
                  label: 'viewport height',
                  value: _viewportHeight,
                  min: 180,
                  max: 420,
                  divisions: 24,
                  color: _p.accentB,
                  onChanged: (v) {
                    setState(() => _viewportHeight = v);
                    _recordControl('primer', 'viewport height -> ${v.toStringAsFixed(0)}');
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
                  title: 'Baseline Preview Surface',
                  subtitle: 'Tap inside the viewport to log interactions.',
                  tint: _p.accentA.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 470,
                    child: _deviceShell(
                      title: 'CheckedModeBanner wrapper',
                      badge: _debugWrapperEnabled ? 'enabled' : 'disabled',
                      child: Center(
                        child: SizedBox(
                          width: _viewportWidth,
                          height: _viewportHeight,
                          child: _wrapWithDebug(
                            child: GestureDetector(
                              onTap: () => _recordTap('primer', 'Tapped baseline preview'),
                              child: _surfaceCard(
                                title: 'Preview App Surface',
                                subtitle: 'Baseline child wrapped by CheckedModeBanner',
                                icon: Icons.phone_iphone,
                                tone: _p.accentA,
                              ),
                            ),
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
                  width: 350,
                  child: _panel(
                    title: 'Primer Guidance',
                    subtitle: 'Key facts about CheckedModeBanner.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _bullet('CheckedModeBanner only accepts child and wraps it.'),
                        _bullet('In debug mode it inserts a DEBUG Banner at topEnd.'),
                        _bullet('In release mode it renders only child.'),
                        _bullet('Use it for unmistakable debug visual state in app shells.'),
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

  Widget _gallerySection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Banner Gallery'),
          const SizedBox(height: 8),
          Text(
            'A single wrapper can be applied to many kinds of child content. '
            'This gallery shows CheckedModeBanner above diverse UI surfaces.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Gallery Controls',
            subtitle: 'Enable or disable wrappers for all scenario cards.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _toggleChip('banner on cards', _showInnerBannerInCards, (v) {
                  _showInnerBannerInCards = v;
                  _bannerToggleCount += 1;
                  _recordMode('gallery', 'banner on cards -> $v');
                }),
                SizedBox(
                  width: 280,
                  child: _sliderInline(
                    label: 'card spacing',
                    value: _cardSpacing,
                    min: 4,
                    max: 22,
                    divisions: 18,
                    color: _p.accentB,
                    onChanged: (v) {
                      setState(() => _cardSpacing = v);
                      _recordControl('gallery', 'card spacing -> ${v.toStringAsFixed(1)}');
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 1050 ? 2 : 1;
              final cardWidth = columns == 2 ? (constraints.maxWidth - _cardSpacing) / 2 : constraints.maxWidth;
              return Wrap(
                spacing: _cardSpacing,
                runSpacing: _cardSpacing,
                children: _scenarios
                    .map(
                      (scenario) => SizedBox(
                        width: cardWidth,
                        child: _panel(
                          title: scenario.title,
                          subtitle: scenario.purpose,
                          tint: scenario.tone.withValues(alpha: 0.05),
                          child: SizedBox(
                            height: 280,
                            child: _wrapMaybeBanner(
                              enabled: _showInnerBannerInCards,
                              child: GestureDetector(
                                onTap: () => _recordScenarioHit(scenario, 'tap'),
                                child: _scenarioSurface(scenario),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _runtimeSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Runtime Toggle Lab'),
          const SizedBox(height: 8),
          Text(
            'Switch debug wrapper state at runtime and inspect how preview shells update. '
            'This focuses on interpreter interaction, not framework API assertions.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Runtime Controls',
            subtitle: 'Live toggles for banner visibility and preview scale.',
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _toggleChip('debug wrapper enabled', _debugWrapperEnabled, (v) {
                      _debugWrapperEnabled = v;
                      _bannerToggleCount += 1;
                      _recordMode('runtime', 'debug wrapper enabled -> $v');
                    }),
                    _toggleChip('raw banner counterpart', _showRawBannerCounterpart, (v) {
                      _showRawBannerCounterpart = v;
                      _recordMode('runtime', 'raw counterpart -> $v');
                    }),
                  ],
                ),
                _slider(
                  label: 'preview scale',
                  value: _previewScale,
                  min: 0.7,
                  max: 1.3,
                  divisions: 12,
                  color: _p.accentC,
                  onChanged: (v) {
                    setState(() => _previewScale = v);
                    _recordControl('runtime', 'preview scale -> ${v.toStringAsFixed(2)}');
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
                  title: 'CheckedModeBanner Preview',
                  subtitle: 'Primary runtime controlled wrapper.',
                  tint: _p.accentA.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 460,
                    child: _deviceShell(
                      title: 'runtime primary',
                      badge: _debugWrapperEnabled ? 'debug on' : 'debug off',
                      child: Center(
                        child: Transform.scale(
                          scale: _previewScale,
                          child: SizedBox(
                            width: 440,
                            height: 270,
                            child: _wrapWithDebug(
                              child: GestureDetector(
                                onTap: () => _recordTap('runtime', 'Tapped runtime primary preview'),
                                child: _surfaceCard(
                                  title: 'Operational Console',
                                  subtitle: 'Runtime wrapper toggle target',
                                  icon: Icons.developer_mode,
                                  tone: _p.accentA,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showRawBannerCounterpart) ...<Widget>[
                const SizedBox(width: 12),
                Expanded(
                  child: _panel(
                    title: 'Raw Banner Counterpart',
                    subtitle: 'Manual Banner(message: DEBUG) for comparison.',
                    tint: _p.accentB.withValues(alpha: 0.05),
                    child: SizedBox(
                      height: 460,
                      child: _deviceShell(
                        title: 'runtime counterpart',
                        badge: 'manual Banner',
                        child: Center(
                          child: Transform.scale(
                            scale: _previewScale,
                            child: SizedBox(
                              width: 440,
                              height: 270,
                              child: Banner(
                                message: 'DEBUG',
                                location: BannerLocation.topEnd,
                                textDirection: TextDirection.ltr,
                                child: GestureDetector(
                                  onTap: () => _recordTap('runtime', 'Tapped runtime counterpart preview'),
                                  child: _surfaceCard(
                                    title: 'Manual Banner Replica',
                                    subtitle: 'Direct Banner for side-by-side behavior visibility',
                                    icon: Icons.flag_circle_outlined,
                                    tone: _p.accentB,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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

  Widget _internalsSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Internals Comparison'),
          const SizedBox(height: 8),
          Text(
            'CheckedModeBanner internally inserts Banner(message: DEBUG, location: topEnd) inside an assert block. '
            'These visual decks explain that behavior and when to use each approach.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _panel(
                  title: 'Behavior Matrix',
                  subtitle: 'CheckedModeBanner and explicit Banner trait comparison.',
                  child: Column(
                    children: <Widget>[
                      _matrixRow('API surface', 'CheckedModeBanner: child only', 'Banner: message/location/style configuration'),
                      _matrixRow('Debug semantics', 'Built for debug-mode marker', 'Usable in any mode when rendered'),
                      _matrixRow('Intent clarity', 'Strong signal: app is debug shell', 'General ribbon/badge presentation'),
                      _matrixRow('Custom text', 'Not configurable', 'Fully customizable message and style'),
                      _matrixRow('Use case', 'Top-level app debug marker', 'Product-level labels, QA tags, custom overlays'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _panel(
                  title: 'Practical Notes',
                  subtitle: 'Implementation recommendations and caveats.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _bullet('Prefer CheckedModeBanner for app-level debug marker consistency.'),
                      _bullet('Use explicit Banner when message or position must be customized.'),
                      _bullet('Avoid stacking many banners; visual noise quickly reduces clarity.'),
                      _bullet('When simulating release visuals, bypass wrapper with dedicated switch.'),
                      _bullet('Record runtime toggles in timeline for easy interpreter verification.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Code-Like Visual Deck',
            subtitle: 'Equivalent structure shown as readable snippets.',
            tint: _p.accentC.withValues(alpha: 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _codeTile(
                  title: 'CheckedModeBanner wrapper',
                  lines: const <String>[
                    'CheckedModeBanner(',
                    '  child: AppShell(),',
                    ')',
                  ],
                ),
                const SizedBox(height: 8),
                _codeTile(
                  title: 'Equivalent explicit Banner',
                  lines: const <String>[
                    'Banner(',
                    "  message: 'DEBUG',",
                    '  location: BannerLocation.topEnd,',
                    '  textDirection: TextDirection.ltr,',
                    '  child: AppShell(),',
                    ')',
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'CheckedModeBanner applies the Banner internally only in debug assertions.',
                  style: TextStyle(color: _p.muted, fontSize: 10.7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _integrationSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Integration Deck'),
          const SizedBox(height: 8),
          Text(
            'This section simulates how debug wrappers appear in app-level shell compositions with nav bars, '
            'content panes, and overlays.',
            style: TextStyle(color: _p.ink, fontSize: 12.3, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Integration Controls',
            subtitle: 'App shell toggles and diagnostic overlays.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _toggleChip('debug wrapper enabled', _debugWrapperEnabled, (v) {
                  _debugWrapperEnabled = v;
                  _bannerToggleCount += 1;
                  _recordMode('integration', 'debug wrapper enabled -> $v');
                }),
                _toggleChip('simulate release bypass', _simulateRelease, (v) {
                  _simulateRelease = v;
                  _bannerToggleCount += 1;
                  _recordMode('integration', 'simulate release bypass -> $v');
                }),
                _toggleChip('crosshair overlay', _showCrosshair, (v) {
                  _showCrosshair = v;
                  _recordControl('integration', 'crosshair overlay -> $v');
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'App Shell Integration Preview',
            subtitle: 'Representative shell with navigation rail, main pane, and status cards.',
            tint: _p.accentA.withValues(alpha: 0.05),
            child: SizedBox(
              height: 560,
              child: _deviceShell(
                title: 'integrated shell',
                badge: _debugWrapperEnabled ? 'debug ribbon active' : 'debug ribbon inactive',
                child: _wrapWithDebug(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(child: _background(_backdropStyle)),
                      if (_showCrosshair)
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _CrosshairPainter(color: _p.ink.withValues(alpha: 0.18)),
                          ),
                        ),
                      Positioned.fill(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 104,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.88),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(height: 10),
                                  Icon(Icons.memory_outlined, color: _p.accentA),
                                  const SizedBox(height: 8),
                                  _railItem('Overview', true),
                                  _railItem('Build', false),
                                  _railItem('Deploy', false),
                                  _railItem('Logs', false),
                                  const Spacer(),
                                  _railItem('Settings', false),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 78,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.88),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          const SizedBox(width: 12),
                                          Icon(Icons.analytics_outlined, color: _p.accentB),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              'Debug Integration Dashboard',
                                              style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13),
                                            ),
                                          ),
                                          FilledButton.tonal(
                                            onPressed: () => _recordTap('integration', 'Tapped refresh action'),
                                            child: const Text('Refresh'),
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: _infoCard('Pipelines', '4 active', Icons.alt_route, _p.accentA),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: _infoCard('Warnings', '2 pending', Icons.warning_amber_rounded, _p.accentC),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: _infoCard('Latency', '92 ms', Icons.speed_outlined, _p.accentB),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 180,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.88),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
                                      ),
                                      child: ListView(
                                        padding: const EdgeInsets.all(10),
                                        children: <Widget>[
                                          _logRow('Worker-1', 'Compile cycle complete', _p.accentA),
                                          _logRow('Worker-2', 'Cache restored', _p.accentB),
                                          _logRow('Worker-3', 'Warning budget exceeded', _p.accentC),
                                          _logRow('Worker-1', 'Publish artifact prepared', _p.accentA),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
        ],
      ),
    );
  }

  Widget _compendiumSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Verification Compendium'),
          const SizedBox(height: 12),
          _panel(
            title: 'CheckedModeBanner Matrix',
            subtitle: 'Coverage summary from this demo.',
            child: Column(
              children: <Widget>[
                _matrix('Core behavior', 'Wraps child and injects DEBUG Banner in debug mode.'),
                _matrix('Constructor scope', 'Single child parameter; no custom message or location configuration.'),
                _matrix('Release behavior', 'Renders child only when debug assertions are absent.'),
                _matrix('Visual use cases', 'Dashboard, media, settings, map overlays, integrated shell layouts.'),
                _matrix('Runtime toggles', 'Wrapper switching, release simulation, preview scaling, timeline logs.'),
                _matrix('Bridge understanding', 'Side-by-side with explicit Banner clarifies internal implementation.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Practical usage patterns.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do keep CheckedModeBanner for global debug shell visibility',
                  detail: 'It quickly communicates environment state to engineers and testers.',
                ),
                _doDont(
                  good: true,
                  title: 'Do compare debug and release-like views during QA walkthroughs',
                  detail: 'A simple bypass toggle helps validate screenshot and visual acceptance flows.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont rely on CheckedModeBanner for custom labels',
                  detail: 'Use explicit Banner when text or placement must be customized.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont stack multiple debug ribbons without intent',
                  detail: 'Overlapping ribbons reduce readability and confuse triage sessions.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common questions for CheckedModeBanner.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'Can I customize DEBUG text in CheckedModeBanner?',
                  a: 'No. CheckedModeBanner does not expose message customization.',
                ),
                _qa(
                  q: 'How do I hide the debug ribbon temporarily?',
                  a: 'Bypass the wrapper in your shell composition or disable app-level debug banner wiring.',
                ),
                _qa(
                  q: 'Is Banner equivalent to CheckedModeBanner?',
                  a: 'Banner is more general; CheckedModeBanner is a focused debug wrapper around Banner behavior.',
                ),
                _qa(
                  q: 'Why include this in interpreter demos?',
                  a: 'It verifies overlay layering and debug-environment signals under interpreted execution.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Completion Checklist',
            subtitle: 'Delivery gates for this deep demo file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Multiple visual sections demonstrate CheckedModeBanner usage across varied content.'),
                _check('Runtime toggles expose wrapper on/off and release-like behavior paths.'),
                _check('Internals section explains implementation via explicit Banner comparison.'),
                _check('Integration stage demonstrates app-shell-level composition behavior.'),
                _check('Instructional content explains when to use CheckedModeBanner vs Banner.'),
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
              'CheckedModeBanner is intentionally narrow but highly practical. '
              'This deep demo validates visual layering and runtime behavior of debug ribbons in realistic shells, '
              'providing clear guidance for interpreter-focused UI verification.',
              style: TextStyle(color: _p.ink, fontSize: 11.8, height: 1.36),
            ),
          ),
        ],
      ),
    );
  }

  Widget _wrapWithDebug({required Widget child}) {
    if (!_debugWrapperEnabled || _simulateRelease) {
      return child;
    }
    return CheckedModeBanner(child: child);
  }

  Widget _wrapMaybeBanner({required bool enabled, required Widget child}) {
    if (!enabled) {
      return child;
    }
    return CheckedModeBanner(child: child);
  }

  Widget _scenarioSurface(_SampleScenario scenario) {
    switch (scenario.id) {
      case 'dashboard':
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scenario.tone.withValues(alpha: 0.34)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: scenario.tone.withValues(alpha: 0.13),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 10),
                    Icon(scenario.icon, color: scenario.tone),
                    const SizedBox(width: 8),
                    Text('Dashboard Hero', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: _miniStat('Builds', '42', scenario.tone)),
                      const SizedBox(width: 8),
                      Expanded(child: _miniStat('Failed', '2', _p.accentC)),
                      const SizedBox(width: 8),
                      Expanded(child: _miniStat('Queued', '7', _p.accentB)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case 'media':
        return Stack(
          children: <Widget>[
            Positioned.fill(child: _background(_backdropStyle)),
            Positioned(
              left: 14,
              top: 14,
              child: _captionPill('Media stream', scenario.tone),
            ),
            Center(
              child: Container(
                width: 180,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scenario.tone.withValues(alpha: 0.34)),
                ),
                child: Icon(Icons.play_circle_fill_rounded, color: scenario.tone, size: 44),
              ),
            ),
          ],
        );
      case 'settings':
        return ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            _settingRow('Enable diagnostics', true, scenario.tone),
            _settingRow('Verbose logging', false, _p.accentB),
            _settingRow('Warn on stale cache', true, _p.accentC),
            _settingRow('Auto refresh views', true, scenario.tone),
          ],
        );
      case 'map':
        return Stack(
          children: <Widget>[
            Positioned.fill(child: _background(_BackdropStyle.draftingGrid)),
            Positioned.fill(child: CustomPaint(painter: _RoutePainter(color: scenario.tone.withValues(alpha: 0.68)))),
            Positioned(left: 24, top: 32, child: _mapPin(scenario.tone)),
            Positioned(right: 38, top: 70, child: _mapPin(_p.accentB)),
            Positioned(left: 90, bottom: 48, child: _mapPin(_p.accentC)),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _mapPin(Color tone) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.8), shape: BoxShape.circle),
    );
  }

  Widget _captionPill(String text, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tone.withValues(alpha: 0.35)),
      ),
      child: Text(text, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 10.4)),
    );
  }

  Widget _miniStat(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: TextStyle(color: _p.muted, fontSize: 10.2)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _settingRow(String text, bool enabled, Color tone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.24)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.2))),
          Icon(enabled ? Icons.toggle_on : Icons.toggle_off, color: enabled ? tone : _p.muted),
        ],
      ),
    );
  }

  Widget _surfaceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color tone,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tone.withValues(alpha: 0.3), width: 2),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: _background(_backdropStyle)),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(icon, color: tone),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 12.8)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 11.2, height: 1.3)),
                  const Spacer(),
                  Row(
                    children: <Widget>[
                      _tinyTag('debug ribbon', tone),
                      const SizedBox(width: 6),
                      _tinyTag('overlay', _p.accentC),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tinyTag(String text, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: TextStyle(color: _p.ink, fontSize: 9.7, fontWeight: FontWeight.w700)),
    );
  }

  Widget _deviceShell({required String title, required String badge, required Widget child}) {
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
                Text(badge, style: TextStyle(color: _p.muted, fontSize: 10.2, fontFamily: 'monospace')),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _railItem(String label, bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: active ? _p.accentA.withValues(alpha: 0.16) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Icon(active ? Icons.radio_button_checked : Icons.radio_button_unchecked, size: 12, color: active ? _p.accentA : _p.muted),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: active ? _p.ink : _p.muted, fontSize: 10.4, fontWeight: active ? FontWeight.w700 : FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String value, IconData icon, Color tone) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: tone, size: 18),
          const Spacer(),
          Text(title, style: TextStyle(color: _p.muted, fontSize: 10.6)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _logRow(String lane, String text, Color tone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.24)),
      ),
      child: Row(
        children: <Widget>[
          Text(lane, style: TextStyle(color: _p.ink, fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 10.2)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 10.8))),
        ],
      ),
    );
  }

  Widget _matrixRow(String topic, String checkedMode, String banner) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(topic, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 11.4)),
          const SizedBox(height: 4),
          Text('CheckedModeBanner: $checkedMode', style: TextStyle(color: _p.muted, fontSize: 10.7)),
          const SizedBox(height: 2),
          Text('Banner: $banner', style: TextStyle(color: _p.muted, fontSize: 10.7)),
        ],
      ),
    );
  }

  Widget _codeTile({required String title, required List<String> lines}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _p.muted.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 11.3)),
          const SizedBox(height: 6),
          for (final line in lines)
            Text(
              line,
              style: TextStyle(color: _p.accentA, fontFamily: 'monospace', fontSize: 10.4, fontWeight: FontWeight.w700),
            ),
        ],
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
        SizedBox(width: 170, child: Text('$label: ${value.toStringAsFixed(1)}', style: TextStyle(color: _p.ink, fontSize: 12))),
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
    return Row(
      children: <Widget>[
        SizedBox(width: 86, child: Text(label, style: TextStyle(color: _p.ink, fontSize: 11.2, fontWeight: FontWeight.w700))),
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

  Widget _metricsPanel() {
    return _panel(
      title: 'Global Metrics',
      subtitle: 'Runtime counters for this session.',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _metric('tap events', '$_tapCount', _p.accentA),
          _metric('control changes', '$_controlChanges', _p.accentB),
          _metric('mode changes', '$_modeChanges', _p.accentC),
          _metric('banner toggles', '$_bannerToggleCount', _p.accentA),
          _metric('timeline events', '${_events.length}', _p.accentB),
        ],
      ),
    );
  }

  Widget _metric(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(999)),
      child: Text('$label: $value', style: TextStyle(color: _p.ink, fontSize: 10.2, fontWeight: FontWeight.w700)),
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

  Widget _timelinePane() {
    return Container(
      decoration: BoxDecoration(color: _p.panel, border: Border(left: BorderSide(color: _p.muted.withValues(alpha: 0.24)))),
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
                Text('Ribbon Timeline', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13.2)),
                const SizedBox(height: 4),
                Text('Wrapper toggles, scenario interactions, and section transitions.', style: TextStyle(color: _p.muted, fontSize: 10.7)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: <Widget>[
                    _metric('events', '${_events.length}', _p.accentA),
                    _metric('taps', '$_tapCount', _p.accentB),
                    _metric('toggles', '$_bannerToggleCount', _p.accentC),
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
                    border: Border.all(color: event.tone.withValues(alpha: 0.25)),
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
      color: _p.frame.withValues(alpha: 0.07),
      child: Row(
        children: <Widget>[
          Text(_sectionLabels[_section.index], style: TextStyle(color: _p.muted, fontSize: 11, fontWeight: FontWeight.w700)),
          const Spacer(),
          DropdownButton<_BackdropStyle>(
            value: _backdropStyle,
            borderRadius: BorderRadius.circular(10),
            items: const <DropdownMenuItem<_BackdropStyle>>[
              DropdownMenuItem(value: _BackdropStyle.nebula, child: Text('Nebula')),
              DropdownMenuItem(value: _BackdropStyle.draftingGrid, child: Text('Grid')),
              DropdownMenuItem(value: _BackdropStyle.ringField, child: Text('Ring field')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _backdropStyle = value);
                _recordControl('backdrop', 'Backdrop style -> $value');
              }
            },
          ),
          const SizedBox(width: 10),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11.1)),
        ],
      ),
    );
  }

  Widget _background(_BackdropStyle style) {
    switch (style) {
      case _BackdropStyle.nebula:
        return _nebulaBackground();
      case _BackdropStyle.draftingGrid:
        return _draftingGridBackground();
      case _BackdropStyle.ringField:
        return _ringFieldBackground();
    }
  }

  Widget _nebulaBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[_p.accentA.withValues(alpha: 0.22), _p.accentB.withValues(alpha: 0.22)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: CustomPaint(painter: _WavePainter(color: Colors.white.withValues(alpha: 0.2))),
    );
  }

  Widget _draftingGridBackground() {
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

  Widget _ringFieldBackground() {
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
          Positioned.fill(child: CustomPaint(painter: _StarPainter(color: Colors.white.withValues(alpha: 0.2)))),
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
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: color, width: 6)),
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
      ..strokeWidth = 1.0;
    final cx = size.width / 2;
    final cy = size.height / 2;
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), paint);
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), paint);
    canvas.drawCircle(Offset(cx, cy), 4, paint..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant _CrosshairPainter oldDelegate) => oldDelegate.color != color;
}

class _RoutePainter extends CustomPainter {
  const _RoutePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.75);
    path.cubicTo(
      size.width * 0.2,
      size.height * 0.4,
      size.width * 0.45,
      size.height * 0.95,
      size.width * 0.62,
      size.height * 0.45,
    );
    path.cubicTo(
      size.width * 0.7,
      size.height * 0.26,
      size.width * 0.84,
      size.height * 0.42,
      size.width * 0.9,
      size.height * 0.22,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) => oldDelegate.color != color;
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
  bool shouldRepaint(covariant _WavePainter oldDelegate) => oldDelegate.color != color;
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
  bool shouldRepaint(covariant _GridPainter oldDelegate) => oldDelegate.color != color;
}

class _StarPainter extends CustomPainter {
  const _StarPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (var i = 0; i < 70; i++) {
      final dx = (i * 37 % 1000) / 1000 * size.width;
      final dy = (i * 59 % 1000) / 1000 * size.height;
      final radius = 0.7 + ((i * 13 % 10) / 10) * 1.6;
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarPainter oldDelegate) => oldDelegate.color != color;
}
