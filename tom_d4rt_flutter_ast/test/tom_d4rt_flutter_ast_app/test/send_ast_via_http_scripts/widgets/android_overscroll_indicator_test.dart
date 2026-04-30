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
    name: 'Copper Coast',
    primary: Color(0xFF0F766E),
    secondary: Color(0xFFEA580C),
    accent: Color(0xFF1D4ED8),
    background: Color(0xFFF3FBF9),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF163431),
    muted: Color(0xFF60736E),
  ),
  _Palette(
    name: 'Slate Sun',
    primary: Color(0xFF111827),
    secondary: Color(0xFFCA8A04),
    accent: Color(0xFF0284C7),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF111827),
    muted: Color(0xFF6B7280),
  ),
  _Palette(
    name: 'Deep Orchard',
    primary: Color(0xFF7C2D12),
    secondary: Color(0xFF7C3AED),
    accent: Color(0xFF0F766E),
    background: Color(0xFFFFF8F5),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF3E2D29),
    muted: Color(0xFF7F645E),
  ),
];

enum _Stage {
  studio,
  gallery,
  switchboard,
  nested,
  theater,
  compendium,
}

enum _Density {
  relaxed,
  balanced,
  dense,
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
    height: 500,
    note: 'Compact shell to amplify overscroll edge effects.',
  ),
  _ShellProfile(
    label: 'Tablet',
    width: 620,
    height: 540,
    note: 'Mid shell for balanced gesture and elasticity behavior.',
  ),
  _ShellProfile(
    label: 'Desktop',
    width: 920,
    height: 620,
    note: 'Wide shell where indicator subtlety matters for UX polish.',
  ),
];

class _OverscrollEvent {
  final DateTime time;
  final String source;
  final String message;
  final Color color;

  const _OverscrollEvent({
    required this.time,
    required this.source,
    required this.message,
    required this.color,
  });
}

class _DemoScrollBehavior extends MaterialScrollBehavior {
  const _DemoScrollBehavior({
    required this.indicator,
    required this.enableIndicator,
    required this.platform,
    required this.physics,
    required this.glowColor,
  });

  final AndroidOverscrollIndicator indicator;
  final bool enableIndicator;
  final TargetPlatform platform;
  final ScrollPhysics physics;
  final Color glowColor;

  @override
  TargetPlatform getPlatform(BuildContext context) {
    return platform;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return physics;
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    if (!enableIndicator) {
      return child;
    }

    final supportsAndroidOverscroll =
        platform == TargetPlatform.android || platform == TargetPlatform.fuchsia;

    if (!supportsAndroidOverscroll) {
      return child;
    }

    if (indicator == AndroidOverscrollIndicator.stretch) {
      return StretchingOverscrollIndicator(
        axisDirection: details.direction,
        child: child,
      );
    }

    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: glowColor,
      child: child,
    );
  }
}

dynamic build(BuildContext context) {
  return const _AndroidOverscrollIndicatorDemo();
}

class _AndroidOverscrollIndicatorDemo extends StatefulWidget {
  const _AndroidOverscrollIndicatorDemo();

  @override
  State<_AndroidOverscrollIndicatorDemo> createState() =>
      _AndroidOverscrollIndicatorDemoState();
}

class _AndroidOverscrollIndicatorDemoState
    extends State<_AndroidOverscrollIndicatorDemo> {
  _Stage _stage = _Stage.studio;
  _Density _density = _Density.balanced;
  int _paletteIndex = 0;

  AndroidOverscrollIndicator _indicator = AndroidOverscrollIndicator.glow;
  TargetPlatform _platform = TargetPlatform.android;
  bool _enableIndicator = true;
  bool _useBounce = false;
  bool _showOverlayGrid = true;
  bool _showMetrics = true;
  bool _verbose = false;

  int _itemCount = 24;
  double _studioWidth = 840;
  double _studioHeight = 480;
  double _galleryHeight = 420;
  double _timelineHeight = 320;
  double _customShellWidth = 760;
  double _customShellHeight = 560;
  double _glowAlpha = 0.55;

  final List<_OverscrollEvent> _events = <_OverscrollEvent>[];

  static const _stageTitles = <String>[
    '1 Overscroll Mode Studio',
    '2 Glow vs Stretch Gallery',
    '3 Runtime Policy Switchboard',
    '4 Nested Scroll Arena',
    '5 Device Theater',
    '6 Verification Compendium',
  ];

  _Palette get _p => _palettes[_paletteIndex];

  ScrollPhysics get _physics {
    if (_useBounce) {
      return const BouncingScrollPhysics();
    }
    return const ClampingScrollPhysics();
  }

  Color get _glowColor {
    return _p.primary.withValues(alpha: _glowAlpha);
  }

  int get _laneCount {
    switch (_density) {
      case _Density.relaxed:
        return 12;
      case _Density.balanced:
        return _itemCount;
      case _Density.dense:
        return (_itemCount * 1.6).round();
    }
  }

  @override
  void initState() {
    super.initState();
    _log('boot', 'AndroidOverscrollIndicator demo initialized.', _p.primary);
  }

  void _log(String source, String message, Color color) {
    final row = _OverscrollEvent(
      time: DateTime.now(),
      source: source,
      message: message,
      color: color,
    );
    setState(() {
      _events.insert(0, row);
      if (_events.length > 40) {
        _events.removeRange(40, _events.length);
      }
    });
    if (_verbose) {
      debugPrint('[AndroidOverscrollIndicator][$source] $message');
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
              const Icon(Icons.sensors_rounded, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'AndroidOverscrollIndicator Deep Demo',
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
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Glow or Stretch Policy',
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
            'AndroidOverscrollIndicator controls the visual overscroll style '
            'for Android-like platforms. This studio demonstrates when to use '
            'glow or stretch and how policy choices affect scroll UX.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.93),
              fontSize: 12.4,
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
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          for (var i = 0; i < _stageTitles.length; i++)
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
              onSelected: (_) => setState(() => _stage = _Stage.values[i]),
            ),
          const SizedBox(width: 10),
          Text(
            'Density',
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          _densityChip('Relaxed', _Density.relaxed),
          _densityChip('Balanced', _Density.balanced),
          _densityChip('Dense', _Density.dense),
          const SizedBox(width: 10),
          Text(
            'Palette',
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
          const SizedBox(width: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('verbose', style: TextStyle(color: _p.ink, fontSize: 12)),
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

  Widget _densityChip(String label, _Density density) {
    return ChoiceChip(
      selected: _density == density,
      selectedColor: _p.secondary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _density == density ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11,
      ),
      onSelected: (_) => setState(() => _density = density),
    );
  }

  Widget _paletteDot(int index) {
    return GestureDetector(
      onTap: () => setState(() => _paletteIndex = index),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _palettes[index].primary,
          border: Border.all(
            color: _paletteIndex == index ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _stageBody() {
    switch (_stage) {
      case _Stage.studio:
        return _studioStage();
      case _Stage.gallery:
        return _galleryStage();
      case _Stage.switchboard:
        return _switchboardStage();
      case _Stage.nested:
        return _nestedStage();
      case _Stage.theater:
        return _theaterStage();
      case _Stage.compendium:
        return _compendiumStage();
    }
  }

  Widget _studioStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Overscroll Mode Studio'),
          const SizedBox(height: 8),
          Text(
            'Switch between glow and stretch in a single interactive board. '
            'This stage focuses on the immediate visual distinction while scrolling.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Studio Controls',
            subtitle: 'Indicator mode, platform, and shell size controls.',
            child: Column(
              children: [
                _indicatorModeRow(),
                const SizedBox(height: 8),
                _platformRow(),
                const SizedBox(height: 8),
                _sliderRow(
                  label: 'item count',
                  value: _itemCount.toDouble(),
                  min: 8,
                  max: 64,
                  divisions: 28,
                  display: '$_itemCount',
                  color: _p.primary,
                  onChanged: (v) => setState(() => _itemCount = v.round()),
                ),
                _sliderRow(
                  label: 'studio width',
                  value: _studioWidth,
                  min: 340,
                  max: 1100,
                  divisions: 38,
                  display: _studioWidth.toStringAsFixed(0),
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _studioWidth = v),
                ),
                _sliderRow(
                  label: 'studio height',
                  value: _studioHeight,
                  min: 260,
                  max: 700,
                  divisions: 44,
                  display: _studioHeight.toStringAsFixed(0),
                  color: _p.accent,
                  onChanged: (v) => setState(() => _studioHeight = v),
                ),
                _sliderRow(
                  label: 'glow alpha',
                  value: _glowAlpha,
                  min: 0.2,
                  max: 1.0,
                  divisions: 16,
                  display: _glowAlpha.toStringAsFixed(2),
                  color: _p.primary,
                  onChanged: (v) => setState(() => _glowAlpha = v),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _enableIndicator,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _enableIndicator = v ?? true),
                    ),
                    Text('indicator enabled',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _useBounce,
                      activeColor: _p.secondary,
                      onChanged: (v) => setState(() => _useBounce = v ?? false),
                    ),
                    Text('bouncing physics',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _showOverlayGrid,
                      activeColor: _p.accent,
                      onChanged: (v) => setState(() => _showOverlayGrid = v ?? true),
                    ),
                    Text('overlay grid', style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _showMetrics,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _showMetrics = v ?? true),
                    ),
                    Text('show metrics', style: TextStyle(color: _p.ink, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Primary Studio Preview',
            subtitle: 'Live overscroll rendering under current policy.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Center(
              child: SizedBox(
                width: _studioWidth,
                height: _studioHeight,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _overscrollShell(
                        title: 'Main feed',
                        indicator: _indicator,
                        platform: _platform,
                        enableIndicator: _enableIndicator,
                        child: _verticalFeed(_laneCount, 'Studio lane'),
                      ),
                    ),
                    if (_showOverlayGrid)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _GuidePainter(
                              color: _p.primary.withValues(alpha: 0.1),
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

  Widget _indicatorModeRow() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _modeChip('Glow', AndroidOverscrollIndicator.glow),
        _modeChip('Stretch', AndroidOverscrollIndicator.stretch),
      ],
    );
  }

  Widget _modeChip(String label, AndroidOverscrollIndicator mode) {
    return ChoiceChip(
      selected: _indicator == mode,
      selectedColor: _p.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _indicator == mode ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11.5,
      ),
      onSelected: (_) {
        setState(() => _indicator = mode);
        _log('policy', 'indicator -> ${mode.name}', _p.primary);
      },
    );
  }

  Widget _platformRow() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _platformChip('Android', TargetPlatform.android),
        _platformChip('Fuchsia', TargetPlatform.fuchsia),
        _platformChip('iOS', TargetPlatform.iOS),
        _platformChip('macOS', TargetPlatform.macOS),
      ],
    );
  }

  Widget _platformChip(String label, TargetPlatform value) {
    return ChoiceChip(
      selected: _platform == value,
      selectedColor: _p.secondary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _platform == value ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11.5,
      ),
      onSelected: (_) {
        setState(() => _platform = value);
        _log('policy', 'platform -> $label', _p.secondary);
      },
    );
  }

  Widget _overscrollShell({
    required String title,
    required AndroidOverscrollIndicator indicator,
    required TargetPlatform platform,
    required bool enableIndicator,
    required Widget child,
  }) {
    final behavior = _DemoScrollBehavior(
      indicator: indicator,
      enableIndicator: enableIndicator,
      platform: platform,
      physics: _physics,
      glowColor: _glowColor,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
            decoration: BoxDecoration(
              color: _p.secondary.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _p.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.8,
                  ),
                ),
                if (_showMetrics) ...[
                  _chip('mode', indicator.name, _p.primary),
                  _chip('platform', platform.name, _p.secondary),
                  _chip('enabled', enableIndicator ? 'yes' : 'no', _p.accent),
                  _chip('physics', _useBounce ? 'bounce' : 'clamp', _p.primary),
                ],
              ],
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: behavior,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalFeed(int count, String prefix) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        _log('scroll', '$prefix scroll end @${notification.metrics.pixels.toStringAsFixed(1)}',
            _p.accent);
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: count,
        itemBuilder: (context, index) {
          final color = index.isEven ? _p.primary : _p.secondary;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                Icon(Icons.drag_indicator_rounded, color: color, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '$prefix item ${index + 1}',
                    style: TextStyle(
                      color: _p.ink,
                      fontWeight: FontWeight.w700,
                      fontSize: 11.6,
                    ),
                  ),
                ),
                Text(
                  '${(index * 7) % 100}%',
                  style: TextStyle(
                    color: _p.muted,
                    fontFamily: 'monospace',
                    fontSize: 10.2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _galleryStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Glow vs Stretch Gallery'),
          const SizedBox(height: 8),
          Text(
            'This side-by-side gallery applies both Android overscroll modes '
            'to identical content so the visual behavior difference is obvious.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Gallery Height',
            subtitle: 'Adjust both galleries together.',
            child: _sliderRow(
              label: 'gallery height',
              value: _galleryHeight,
              min: 260,
              max: 640,
              divisions: 38,
              display: _galleryHeight.toStringAsFixed(0),
              color: _p.secondary,
              onChanged: (v) => setState(() => _galleryHeight = v),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: 520,
                child: _card(
                  title: 'Glow Mode',
                  subtitle: 'AndroidOverscrollIndicator.glow',
                  tint: _p.primary.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: _galleryHeight,
                    child: _overscrollShell(
                      title: 'Glow board',
                      indicator: AndroidOverscrollIndicator.glow,
                      platform: TargetPlatform.android,
                      enableIndicator: true,
                      child: _verticalFeed(_laneCount, 'Glow lane'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 520,
                child: _card(
                  title: 'Stretch Mode',
                  subtitle: 'AndroidOverscrollIndicator.stretch',
                  tint: _p.secondary.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: _galleryHeight,
                    child: _overscrollShell(
                      title: 'Stretch board',
                      indicator: AndroidOverscrollIndicator.stretch,
                      platform: TargetPlatform.android,
                      enableIndicator: true,
                      child: _verticalFeed(_laneCount, 'Stretch lane'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Gallery Reading Guide',
            subtitle: 'When to choose glow or stretch.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Use glow for strong edge feedback in data-heavy utilities.'),
                _bullet('Use stretch for softer, modern motion-driven surfaces.'),
                _bullet('Keep platform conventions in mind for user expectations.'),
                _bullet('Indicator style should align with your motion language.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _switchboardStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Runtime Policy Switchboard'),
          const SizedBox(height: 8),
          Text(
            'This switchboard combines policy controls with event traces. '
            'Adjust runtime choices and inspect their effect on scroll behavior.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Policy Controls',
            subtitle: 'Indicator and platform controls shared across preview lanes.',
            child: Column(
              children: [
                _indicatorModeRow(),
                const SizedBox(height: 8),
                _platformRow(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: _enableIndicator,
                      activeColor: _p.primary,
                      onChanged: (v) {
                        setState(() => _enableIndicator = v ?? true);
                        _log('policy', 'indicator enabled: $_enableIndicator', _p.primary);
                      },
                    ),
                    Text('enable overscroll indicator',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _useBounce,
                      activeColor: _p.secondary,
                      onChanged: (v) {
                        setState(() => _useBounce = v ?? false);
                        _log('policy', 'physics: ${_useBounce ? 'bounce' : 'clamp'}',
                            _p.secondary);
                      },
                    ),
                    Text('bouncing physics',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _showMetrics,
                      activeColor: _p.accent,
                      onChanged: (v) => setState(() => _showMetrics = v ?? true),
                    ),
                    Text('show metrics', style: TextStyle(color: _p.ink, fontSize: 12)),
                    const Spacer(),
                    if (_showMetrics) _chip('events', '${_events.length}', _p.accent),
                  ],
                ),
                _sliderRow(
                  label: 'timeline height',
                  value: _timelineHeight,
                  min: 220,
                  max: 560,
                  divisions: 34,
                  display: _timelineHeight.toStringAsFixed(0),
                  color: _p.accent,
                  onChanged: (v) => setState(() => _timelineHeight = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: 520,
                child: _card(
                  title: 'Vertical Policy Preview',
                  subtitle: 'Current runtime policy applied.',
                  tint: _p.primary.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 360,
                    child: _overscrollShell(
                      title: 'Policy vertical',
                      indicator: _indicator,
                      platform: _platform,
                      enableIndicator: _enableIndicator,
                      child: _verticalFeed(_laneCount, 'Policy lane'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 520,
                child: _card(
                  title: 'Horizontal Policy Preview',
                  subtitle: 'Same policy applied to horizontal scroll.',
                  tint: _p.secondary.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 360,
                    child: _overscrollShell(
                      title: 'Policy horizontal',
                      indicator: _indicator,
                      platform: _platform,
                      enableIndicator: _enableIndicator,
                      child: _horizontalCards(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Event Timeline',
            subtitle: 'Policy and scroll traces for debugging.',
            child: SizedBox(
              height: _timelineHeight,
              child: _events.isEmpty
                  ? Center(
                      child: Text(
                        'No events yet. Interact with controls and scroll lanes.',
                        style: TextStyle(color: _p.muted, fontSize: 12),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _events.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final row = _events[index];
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: row.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: row.color.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _chip('src', row.source, row.color),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  row.message,
                                  style: TextStyle(
                                    color: _p.ink,
                                    fontSize: 11.4,
                                    height: 1.33,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _formatTime(row.time),
                                style: TextStyle(
                                  color: _p.muted,
                                  fontFamily: 'monospace',
                                  fontSize: 10.3,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _horizontalCards() {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        _log(
          'scroll',
          'horizontal end @${notification.metrics.pixels.toStringAsFixed(1)}',
          _p.accent,
        );
        return false;
      },
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(10),
        itemCount: _laneCount,
        itemBuilder: (context, index) {
          final color = index.isEven ? _p.primary : _p.secondary;
          return Container(
            width: 180,
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card ${index + 1}',
                  style: TextStyle(
                    color: _p.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Horizontal drag this lane to inspect glow/stretch behavior.',
                  style: TextStyle(color: _p.muted, fontSize: 10.6, height: 1.3),
                ),
                const Spacer(),
                _chip('idx', '${index + 1}', color),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    final s = time.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _nestedStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Nested Scroll Arena'),
          const SizedBox(height: 8),
          Text(
            'Nested scrollables can use different overscroll policies. This '
            'arena demonstrates parent and child policy combinations.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Nested Arena',
            subtitle: 'Outer uses active policy. Inner lanes alternate mode.',
            tint: _p.primary.withValues(alpha: 0.05),
            child: SizedBox(
              height: 520,
              child: _overscrollShell(
                title: 'Outer arena',
                indicator: _indicator,
                platform: _platform,
                enableIndicator: _enableIndicator,
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    if (index % 3 == 1) {
                      return Container(
                        height: 170,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: _overscrollShell(
                          title: 'Inner lane ${index + 1}',
                          indicator: index.isEven
                              ? AndroidOverscrollIndicator.stretch
                              : AndroidOverscrollIndicator.glow,
                          platform: TargetPlatform.android,
                          enableIndicator: true,
                          child: _horizontalCards(),
                        ),
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (index.isEven ? _p.primary : _p.secondary)
                            .withValues(alpha: 0.13),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        'Outer block ${index + 1}: nested policy marker',
                        style: TextStyle(
                          color: _p.ink,
                          fontSize: 11.8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Nested Strategy Notes',
            subtitle: 'Guidance for mixed policy scroll trees.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bullet('Keep outer policy consistent with global app behavior.'),
                _bullet('Inner exceptions should be intentional and documented.'),
                _bullet('Avoid abrupt visual language changes between parent and child lanes.'),
                _bullet('Log nested interactions when debugging gesture conflicts.'),
              ],
            ),
          ),
        ],
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
            'Apply overscroll policies across shell sizes to validate visual '
            'coherence and interaction quality on varying layouts.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Custom Shell Controls',
            subtitle: 'Tune custom shell for final comparison lane.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'custom width',
                  value: _customShellWidth,
                  min: 340,
                  max: 1120,
                  divisions: 39,
                  display: _customShellWidth.toStringAsFixed(0),
                  color: _p.primary,
                  onChanged: (v) => setState(() => _customShellWidth = v),
                ),
                _sliderRow(
                  label: 'custom height',
                  value: _customShellHeight,
                  min: 280,
                  max: 760,
                  divisions: 24,
                  display: _customShellHeight.toStringAsFixed(0),
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _customShellHeight = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final shell in _shellProfiles) _shellCard(shell),
              _shellCard(
                _ShellProfile(
                  label: 'Custom',
                  width: _customShellWidth,
                  height: _customShellHeight,
                  note: 'User-tuned runtime shell profile.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shellCard(_ShellProfile shell) {
    return SizedBox(
      width: shell.width > 640 ? 540 : 390,
      child: _card(
        title: '${shell.label} Shell',
        subtitle:
            'w ${shell.width.toStringAsFixed(0)} | h ${shell.height.toStringAsFixed(0)} | ${shell.note}',
        tint: _p.primary.withValues(alpha: 0.04),
        child: SizedBox(
          width: shell.width,
          height: shell.height,
          child: _overscrollShell(
            title: '${shell.label} preview',
            indicator: _indicator,
            platform: _platform,
            enableIndicator: _enableIndicator,
            child: _verticalFeed(_laneCount, '${shell.label} lane'),
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
        children: [
          _sectionTitle('Verification Compendium'),
          const SizedBox(height: 12),
          _card(
            title: 'AndroidOverscrollIndicator Matrix',
            subtitle: 'Definition and practical use guidance.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Type',
                  value: 'Enum controlling Android overscroll visual style.',
                ),
                _matrixRow(
                  keyText: 'Values',
                  value: 'glow and stretch.',
                ),
                _matrixRow(
                  keyText: 'Primary context',
                  value:
                      'ScrollBehavior policy on Android-like platforms (Android and Fuchsia).',
                ),
                _matrixRow(
                  keyText: 'Glow behavior',
                  value: 'Draws edge glow when scroll exceeds bounds.',
                ),
                _matrixRow(
                  keyText: 'Stretch behavior',
                  value: 'Applies elastic stretch effect to content near boundaries.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do and Dont',
            subtitle: 'Overscroll policy design advice.',
            child: Column(
              children: [
                _doDont(
                  good: true,
                  title: 'Pick one policy per product motion language',
                  detail:
                      'Consistent glow or stretch behavior improves interaction predictability.',
                ),
                _doDont(
                  good: false,
                  title: 'Mix random indicator styles across sibling screens',
                  detail:
                      'Inconsistent feedback weakens platform familiarity and polish.',
                ),
                _doDont(
                  good: true,
                  title: 'Test nested scrollables with explicit policy decisions',
                  detail:
                      'Nested interactions can amplify visual and gesture surprises.',
                ),
                _doDont(
                  good: false,
                  title: 'Assume non-Android platforms show same indicator behavior',
                  detail:
                      'Platform-aware behavior is part of the policy contract.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common policy and usage questions.',
            child: Column(
              children: [
                _qa(
                  q: 'Should I always use stretch because it looks modern?',
                  a: 'Not always. Choose the mode that fits your product style and platform expectations.',
                ),
                _qa(
                  q: 'Where do I apply AndroidOverscrollIndicator policy?',
                  a: 'In a ScrollBehavior implementation applied through ScrollConfiguration.',
                ),
                _qa(
                  q: 'Can I disable overscroll effects entirely?',
                  a: 'Yes, by returning child directly in buildOverscrollIndicator policy logic.',
                ),
                _qa(
                  q: 'How do I validate behavior quickly?',
                  a: 'Use side-by-side boards and platform toggles with the same content.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo completion criteria for this component.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _check('Glow and stretch are both demonstrated visually.'),
                _check('Runtime policy switching for mode and platform is demonstrated.'),
                _check('Vertical and horizontal overscroll displays are included.'),
                _check('Nested scroll behavior with mixed policies is shown.'),
                _check('Responsive shell comparisons are included.'),
                _check('Compendium provides practical guidance and verification notes.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'AndroidOverscrollIndicator is a policy choice, not a decorative afterthought: '
            'select glow or stretch intentionally, validate nested and responsive contexts, '
            'and keep interaction feedback consistent across your app.',
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
    required String display,
    required Color color,
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
          fontSize: 10.3,
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
            width: 200,
            child: Text(
              keyText,
              style: TextStyle(
                color: _p.primary,
                fontFamily: 'monospace',
                fontSize: 11.2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.33),
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
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(good ? Icons.check_circle : Icons.cancel, color: tone, size: 18),
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
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _p.muted, fontSize: 11.3)),
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
              fontWeight: FontWeight.w700,
              fontSize: 12,
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
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12)),
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
            decoration: BoxDecoration(shape: BoxShape.circle, color: _p.primary),
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
            child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12, height: 1.34)),
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
          style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 18),
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
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 14),
          ),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 11.4)),
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
            _stageTitles[_stage.index],
            style: TextStyle(
              color: _p.muted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11)),
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
