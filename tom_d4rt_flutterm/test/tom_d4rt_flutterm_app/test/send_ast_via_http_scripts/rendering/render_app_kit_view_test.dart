import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show PlatformViewHitTestBehavior;
import 'package:flutter/services.dart';

const List<_ThemePreset> _themes = <_ThemePreset>[
  _ThemePreset(
    id: 'harbor',
    name: 'Harbor Deck',
    seed: Color(0xFF0369A1),
    brightness: Brightness.light,
    description: 'Clear and bright profile for platform-view interaction study.',
  ),
  _ThemePreset(
    id: 'copper',
    name: 'Copper Bay',
    seed: Color(0xFFB45309),
    brightness: Brightness.light,
    description: 'Warm contrast profile for clipping and transform scenarios.',
  ),
  _ThemePreset(
    id: 'midnight',
    name: 'Midnight Console',
    seed: Color(0xFF1E293B),
    brightness: Brightness.dark,
    description: 'Night profile emphasizing overlays and lifecycle diagnostics.',
  ),
  _ThemePreset(
    id: 'meadow',
    name: 'Meadow Lab',
    seed: Color(0xFF15803D),
    brightness: Brightness.light,
    description: 'Balanced profile for long run sessions and educational walkthroughs.',
  ),
];

const List<_ScenarioPreset> _scenarios = <_ScenarioPreset>[
  _ScenarioPreset(
    id: 'host',
    title: 'Host Stage',
    subtitle: 'Live AppKitView lane on macOS and visual simulator lane elsewhere.',
  ),
  _ScenarioPreset(
    id: 'hit-test',
    title: 'Hit Test Gallery',
    subtitle: 'Compare PlatformViewHitTestBehavior modes under overlays.',
  ),
  _ScenarioPreset(
    id: 'clip-transform',
    title: 'Clip + Transform',
    subtitle: 'Study clipping, opacity, and transforms around embedded views.',
  ),
  _ScenarioPreset(
    id: 'lifecycle',
    title: 'Lifecycle Ops',
    subtitle: 'Creation params, revision resets, and timeline diagnostics.',
  ),
  _ScenarioPreset(
    id: 'guide',
    title: 'Guide',
    subtitle: 'Practical use patterns for AppKit embedding with Flutter.',
  ),
];

const List<_ClipPreset> _clipPresets = <_ClipPreset>[
  _ClipPreset(label: 'None', value: Clip.none, note: 'No clipping of host bounds.'),
  _ClipPreset(label: 'Hard Edge', value: Clip.hardEdge, note: 'Fast rectangular clipping.'),
  _ClipPreset(label: 'AntiAlias', value: Clip.antiAlias, note: 'Smoothed edges for rounded masks.'),
  _ClipPreset(
    label: 'SaveLayer',
    value: Clip.antiAliasWithSaveLayer,
    note: 'Highest visual fidelity, potentially most expensive.',
  ),
];

const List<_HitTestPreset> _hitTestPresets = <_HitTestPreset>[
  _HitTestPreset(
    label: 'Opaque',
    behavior: PlatformViewHitTestBehavior.opaque,
    note: 'Platform view consumes gestures in bounds.',
  ),
  _HitTestPreset(
    label: 'Translucent',
    behavior: PlatformViewHitTestBehavior.translucent,
    note: 'Events pass through while still reaching platform surface.',
  ),
  _HitTestPreset(
    label: 'Transparent',
    behavior: PlatformViewHitTestBehavior.transparent,
    note: 'Flutter widgets behind receive gestures first.',
  ),
];

const List<String> _guideBullets = <String>[
  'AppKitView is the widget-layer entry for embedding macOS native views in Flutter trees.',
  'RenderAppKitView behavior is exercised through sizing, transforms, hit testing, and clip wrappers.',
  'Always define a stable viewType contract and maintain matching native registration logic.',
  'Use creationParams to pass lightweight configuration values from Dart to native constructors.',
  'Design fallback visuals for non-macOS environments so demos remain instructive everywhere.',
  'Recreate embedded views intentionally using key/revision changes when native state must restart.',
  'Test gesture behavior with overlays to ensure expected interaction ownership around platform views.',
  'Avoid expensive clip or saveLayer combinations unless visual requirements justify overhead.',
  'Keep timeline instrumentation while integrating platform views to debug creation and gesture routing.',
  'When possible, provide educational side-by-side lanes for live host and simulated host behavior.',
];

const List<_FaqEntry> _faq = <_FaqEntry>[
  _FaqEntry(
    q: 'Can this demo run outside macOS?',
    a: 'Yes. It shows a simulation lane for instructional visualization while live embedding activates on macOS.',
  ),
  _FaqEntry(
    q: 'Why include hit test behavior controls?',
    a: 'Platform surfaces and Flutter overlays can compete for gestures, so behavior tuning is essential.',
  ),
  _FaqEntry(
    q: 'How do creation params help?',
    a: 'They deliver initial native configuration such as profile, mode, or content selection at view creation.',
  ),
  _FaqEntry(
    q: 'When should a view be recreated?',
    a: 'Recreate when native state should reset fully, for example when switching major host configuration.',
  ),
];

class _ThemePreset {
  const _ThemePreset({
    required this.id,
    required this.name,
    required this.seed,
    required this.brightness,
    required this.description,
  });

  final String id;
  final String name;
  final Color seed;
  final Brightness brightness;
  final String description;
}

class _ScenarioPreset {
  const _ScenarioPreset({required this.id, required this.title, required this.subtitle});

  final String id;
  final String title;
  final String subtitle;
}

class _ClipPreset {
  const _ClipPreset({required this.label, required this.value, required this.note});

  final String label;
  final Clip value;
  final String note;
}

class _HitTestPreset {
  const _HitTestPreset({required this.label, required this.behavior, required this.note});

  final String label;
  final PlatformViewHitTestBehavior behavior;
  final String note;
}

class _FaqEntry {
  const _FaqEntry({required this.q, required this.a});

  final String q;
  final String a;
}

class _TimelineEvent {
  const _TimelineEvent({required this.time, required this.title, required this.message});

  final DateTime time;
  final String title;
  final String message;
}

class _MetricEntry {
  const _MetricEntry({required this.label, required this.value, required this.note, required this.icon});

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

class _HostCardSpec {
  const _HostCardSpec({
    required this.title,
    required this.behavior,
    required this.color,
    required this.note,
  });

  final String title;
  final PlatformViewHitTestBehavior behavior;
  final Color color;
  final String note;
}

dynamic build(BuildContext context) {
  return const _RenderAppKitViewLab();
}

class _RenderAppKitViewLab extends StatefulWidget {
  const _RenderAppKitViewLab();

  @override
  State<_RenderAppKitViewLab> createState() => _RenderAppKitViewLabState();
}

class _RenderAppKitViewLabState extends State<_RenderAppKitViewLab> {
  final ScrollController _scrollController = ScrollController();

  int _themeIndex = 0;
  int _scenarioIndex = 0;
  int _hitBehaviorIndex = 0;
  int _clipIndex = 1;

  bool _showGrid = true;
  bool _showGuide = true;
  bool _showTimeline = true;
  bool _showDiagnostics = true;
  bool _overlayBlocksGestures = true;
  bool _showTransform = true;
  bool _showOpacityWrap = true;
  bool _enableTapRecognizer = true;
  bool _enablePanRecognizer = false;
  bool _enableLongPressRecognizer = false;

  double _stageWidth = 470;
  double _stageHeight = 260;
  double _cornerRadius = 18;
  double _rotation = 0;
  double _scale = 1;
  double _opacity = 1;
  double _overlayStrength = 0.20;

  int _revision = 1;
  int _hostCreatedCount = 0;
  int _hostTapCount = 0;
  int _overlayTapCount = 0;
  int _profileSwitchCount = 0;
  int _behaviorSwitchCount = 0;
  int _clipSwitchCount = 0;
  int _recreateCount = 0;

  String _activeProfile = 'baseline';
  String _platformState = 'pending';

  List<_TimelineEvent> _timeline = const <_TimelineEvent>[];

  bool get _isMacOS => defaultTargetPlatform == TargetPlatform.macOS;

  @override
  void initState() {
    super.initState();
    _platformState = _isMacOS ? 'macOS host available' : 'non-macOS fallback mode';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pushTimeline('Init', 'RenderAppKitView visual lab initialized.');
      _pushTimeline('Platform', _platformState);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _pushTimeline(String title, String message) {
    setState(() {
      _timeline = <_TimelineEvent>[
        _TimelineEvent(time: DateTime.now(), title: title, message: message),
        ..._timeline,
      ].take(60).toList(growable: false);
    });
  }

  Map<String, Object> _creationParams() {
    return <String, Object>{
      'profile': _activeProfile,
      'revision': _revision,
      'hitTest': _hitTestPresets[_hitBehaviorIndex].label,
      'clip': _clipPresets[_clipIndex].label,
      'rotationDeg': (_rotation * 180 / math.pi).toStringAsFixed(1),
      'opacity': _opacity.toStringAsFixed(2),
      'scale': _scale.toStringAsFixed(2),
    };
  }

  Set<Factory<OneSequenceGestureRecognizer>> _gestureRecognizers() {
    final Set<Factory<OneSequenceGestureRecognizer>> result = <Factory<OneSequenceGestureRecognizer>>{};
    if (_enableTapRecognizer) {
      result.add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()));
    }
    if (_enablePanRecognizer) {
      result.add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()));
    }
    if (_enableLongPressRecognizer) {
      result.add(Factory<LongPressGestureRecognizer>(() => LongPressGestureRecognizer()));
    }
    return result;
  }

  List<_MetricEntry> _metrics() {
    return <_MetricEntry>[
      _MetricEntry(label: 'Platform', value: _platformState, note: 'Current host platform lane state.', icon: Icons.desktop_mac_outlined),
      _MetricEntry(label: 'Scenario', value: _scenarios[_scenarioIndex].title, note: 'Active exploration lane.', icon: Icons.grid_view_outlined),
      _MetricEntry(label: 'Revision', value: '$_revision', note: 'View revision used for recreation.', icon: Icons.refresh),
      _MetricEntry(label: 'Host Created', value: '$_hostCreatedCount', note: 'onPlatformViewCreated callback count.', icon: Icons.rocket_launch_outlined),
      _MetricEntry(label: 'Host Taps', value: '$_hostTapCount', note: 'Tap count inside host lane wrapper.', icon: Icons.touch_app_outlined),
      _MetricEntry(label: 'Overlay Taps', value: '$_overlayTapCount', note: 'Overlay interception count.', icon: Icons.layers_clear_outlined),
      _MetricEntry(label: 'Behavior', value: _hitTestPresets[_hitBehaviorIndex].label, note: _hitTestPresets[_hitBehaviorIndex].note, icon: Icons.ads_click_outlined),
      _MetricEntry(label: 'Clip', value: _clipPresets[_clipIndex].label, note: _clipPresets[_clipIndex].note, icon: Icons.crop_outlined),
      _MetricEntry(label: 'Rotation', value: '${(_rotation * 180 / math.pi).toStringAsFixed(1)} deg', note: 'Rotation wrapper around host surface.', icon: Icons.threed_rotation),
      _MetricEntry(label: 'Scale', value: _scale.toStringAsFixed(2), note: 'Transform scale around host.', icon: Icons.zoom_in_map_outlined),
      _MetricEntry(label: 'Opacity', value: _opacity.toStringAsFixed(2), note: 'Opacity wrapper value.', icon: Icons.opacity_outlined),
      _MetricEntry(label: 'Profiles', value: '$_profileSwitchCount', note: 'Host profile switches.', icon: Icons.tune_outlined),
      _MetricEntry(label: 'Behavior Switches', value: '$_behaviorSwitchCount', note: 'Hit test behavior switch count.', icon: Icons.swap_horiz_outlined),
      _MetricEntry(label: 'Clip Switches', value: '$_clipSwitchCount', note: 'Clip preset switch count.', icon: Icons.change_circle_outlined),
      _MetricEntry(label: 'Recreates', value: '$_recreateCount', note: 'Manual host recreation count.', icon: Icons.restart_alt_outlined),
      _MetricEntry(label: 'Gesture Count', value: '${_gestureRecognizers().length}', note: 'Enabled gesture recognizers passed to host.', icon: Icons.gesture_outlined),
    ];
  }

  void _resetControls() {
    setState(() {
      _scenarioIndex = 0;
      _hitBehaviorIndex = 0;
      _clipIndex = 1;
      _showGrid = true;
      _showGuide = true;
      _showTimeline = true;
      _showDiagnostics = true;
      _overlayBlocksGestures = true;
      _showTransform = true;
      _showOpacityWrap = true;
      _enableTapRecognizer = true;
      _enablePanRecognizer = false;
      _enableLongPressRecognizer = false;
      _stageWidth = 470;
      _stageHeight = 260;
      _cornerRadius = 18;
      _rotation = 0;
      _scale = 1;
      _opacity = 1;
      _overlayStrength = 0.20;
      _activeProfile = 'baseline';
      _hostTapCount = 0;
      _overlayTapCount = 0;
    });
    _pushTimeline('Reset', 'Visual controls reset to baseline profile.');
  }

  @override
  Widget build(BuildContext context) {
    final _ThemePreset theme = _themes[_themeIndex];
    final ColorScheme scheme = ColorScheme.fromSeed(seedColor: theme.seed, brightness: theme.brightness);

    return Theme(
      data: ThemeData(useMaterial3: true, colorScheme: scheme, brightness: theme.brightness),
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[scheme.surface, scheme.surfaceContainerLowest, scheme.surfaceContainerLow],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1330),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _buildHeader(scheme),
                        const SizedBox(height: 16),
                        _buildThemeScenarioBoard(scheme),
                        const SizedBox(height: 16),
                        _buildHostStageBoard(scheme),
                        const SizedBox(height: 16),
                        _buildHitTestGallery(scheme),
                        const SizedBox(height: 16),
                        _buildClipTransformBoard(scheme),
                        const SizedBox(height: 16),
                        _buildLifecycleOpsBoard(scheme),
                        const SizedBox(height: 16),
                        _buildMetricsBoard(scheme),
                        if (_showGuide) const SizedBox(height: 16),
                        if (_showGuide) _buildGuideBoard(scheme),
                        if (_showTimeline) const SizedBox(height: 16),
                        if (_showTimeline) _buildTimelineBoard(scheme),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Icon(Icons.desktop_windows_outlined, color: scheme.primary, size: 26),
                Text(
                  'RenderAppKitView Visual Lab',
                  style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 26),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: scheme.primaryContainer, borderRadius: BorderRadius.circular(999)),
                  child: Text(_scenarios[_scenarioIndex].title, style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Manual deep demo for AppKit platform view embedding in Flutter: host stage, gesture routing, clipping/transforms, lifecycle controls, and operational diagnostics.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeScenarioBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Theme Profiles', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_themes.length, (int i) {
                final _ThemePreset p = _themes[i];
                return ChoiceChip(
                  selected: i == _themeIndex,
                  label: Text(p.name),
                  onSelected: (_) {
                    setState(() => _themeIndex = i);
                    _pushTimeline('Theme', 'Switched to ${p.name}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_themes[_themeIndex].description, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Text('Scenario Lanes', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_scenarios.length, (int i) {
                final _ScenarioPreset s = _scenarios[i];
                return FilterChip(
                  selected: i == _scenarioIndex,
                  label: Text(s.title),
                  onSelected: (_) {
                    setState(() => _scenarioIndex = i);
                    _pushTimeline('Scenario', s.subtitle);
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_scenarios[_scenarioIndex].subtitle, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                CheckboxMenuButton(
                  value: _showGrid,
                  onChanged: (bool? v) => setState(() => _showGrid = v ?? true),
                  child: const Text('Show host grid'),
                ),
                CheckboxMenuButton(
                  value: _showDiagnostics,
                  onChanged: (bool? v) => setState(() => _showDiagnostics = v ?? true),
                  child: const Text('Show diagnostics'),
                ),
                CheckboxMenuButton(
                  value: _showGuide,
                  onChanged: (bool? v) => setState(() => _showGuide = v ?? true),
                  child: const Text('Show guide board'),
                ),
                CheckboxMenuButton(
                  value: _showTimeline,
                  onChanged: (bool? v) => setState(() => _showTimeline = v ?? true),
                  child: const Text('Show timeline board'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHostStageBoard(ColorScheme scheme) {
    final PlatformViewHitTestBehavior behavior = _hitTestPresets[_hitBehaviorIndex].behavior;
    final Clip clip = _clipPresets[_clipIndex].value;

    Widget host = _isMacOS
        ? AppKitView(
            key: ValueKey<String>('appkit_revision_$_revision'),
            viewType: 'tom.demo.appkit.visual',
            hitTestBehavior: behavior,
            creationParams: _creationParams(),
            creationParamsCodec: const StandardMessageCodec(),
            gestureRecognizers: _gestureRecognizers(),
            onPlatformViewCreated: (int id) {
              setState(() {
                _hostCreatedCount += 1;
              });
              _pushTimeline('Platform View', 'AppKitView created with id $id at revision $_revision.');
            },
          )
        : _buildFallbackHostSurface(scheme, behavior);

    if (_showOpacityWrap) {
      host = Opacity(opacity: _opacity, child: host);
    }
    if (_showTransform) {
      host = Transform.rotate(angle: _rotation, child: Transform.scale(scale: _scale, child: host));
    }

    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Host Stage', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                OutlinedButton.icon(onPressed: _resetControls, icon: const Icon(Icons.restart_alt), label: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Main lane for embedding and interacting with AppKitView configuration. Non-macOS mode shows a structured simulator card.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_cornerRadius),
                clipBehavior: clip,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _hostTapCount += 1);
                    _pushTimeline('Host Tap', 'Host surface tapped in ${_isMacOS ? 'live' : 'simulator'} mode.');
                  },
                  child: Container(
                    width: _stageWidth,
                    height: _stageHeight,
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(_cornerRadius),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: Stack(
                      children: <Widget>[
                        if (_showGrid)
                          Positioned.fill(child: CustomPaint(painter: _GridPainter(color: scheme.outlineVariant.withValues(alpha: 0.22), step: 22))),
                        Positioned.fill(child: host),
                        Positioned(top: 10, left: 10, child: _chip(scheme, _isMacOS ? 'macOS live' : 'simulator', Icons.computer_outlined)),
                        Positioned(top: 10, right: 10, child: _chip(scheme, _hitTestPresets[_hitBehaviorIndex].label, Icons.ads_click_outlined)),
                        Positioned(bottom: 10, right: 10, child: _chip(scheme, _clipPresets[_clipIndex].label, Icons.crop_outlined)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackHostSurface(ColorScheme scheme, PlatformViewHitTestBehavior behavior) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[scheme.primaryContainer.withValues(alpha: 0.46), scheme.secondaryContainer.withValues(alpha: 0.38)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.settings_ethernet, color: scheme.primary),
                const SizedBox(width: 8),
                Text('AppKitView Simulator', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Platform is not macOS. This lane visualizes config passed to live host creation.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _creationParams().entries.map((MapEntry<String, Object> e) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: Text('${e.key}: ${e.value}', style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                );
              }).toList(),
            ),
            const Spacer(),
            Text('hitTest=${behavior.name}  recognizers=${_gestureRecognizers().length}', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _chip(ColorScheme scheme, String label, IconData icon) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: scheme.primary),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w600, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildHitTestGallery(ColorScheme scheme) {
    final List<_HostCardSpec> cards = <_HostCardSpec>[
      _HostCardSpec(
        title: 'Opaque Lane',
        behavior: PlatformViewHitTestBehavior.opaque,
        color: const Color(0xFF0284C7),
        note: 'Surface owns gestures in its rectangle.',
      ),
      _HostCardSpec(
        title: 'Translucent Lane',
        behavior: PlatformViewHitTestBehavior.translucent,
        color: const Color(0xFF7C3AED),
        note: 'Allows mixed routing between overlay and host.',
      ),
      _HostCardSpec(
        title: 'Transparent Lane',
        behavior: PlatformViewHitTestBehavior.transparent,
        color: const Color(0xFF059669),
        note: 'Flutter content beneath can remain gesture-primary.',
      ),
    ];

    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hit Test Gallery', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Three visual lanes compare gesture routing behavior with an optional overlay interception layer.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: SwitchListTile(
                    value: _overlayBlocksGestures,
                    title: const Text('Overlay Captures Gestures'),
                    subtitle: const Text('Tap overlay layer to test interception.'),
                    onChanged: (bool value) {
                      setState(() => _overlayBlocksGestures = value);
                      _pushTimeline('Overlay', value ? 'Overlay interception enabled.' : 'Overlay interception disabled.');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: cards.map(( _HostCardSpec card) {
                return SizedBox(
                  width: 405,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _hitTestPresets[_hitBehaviorIndex].behavior == card.behavior ? scheme.primary : scheme.outlineVariant,
                        width: _hitTestPresets[_hitBehaviorIndex].behavior == card.behavior ? 2 : 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(card.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _hitBehaviorIndex = _hitTestPresets.indexWhere(( _HitTestPreset p) => p.behavior == card.behavior);
                                    _behaviorSwitchCount += 1;
                                  });
                                  _pushTimeline('Hit Test', 'Selected ${card.behavior.name} behavior.');
                                },
                                child: const Text('Use'),
                              ),
                            ],
                          ),
                          Text(card.note, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 140,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: <Color>[card.color.withValues(alpha: 0.86), card.color.withValues(alpha: 0.45)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text('Host lane', style: TextStyle(color: Colors.white.withValues(alpha: 0.92), fontWeight: FontWeight.w800)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 12,
                                  top: 12,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() => _hostTapCount += 1);
                                      _pushTimeline('Gallery Host Tap', 'Tapped host lane in ${card.title}.');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.85),
                                        borderRadius: BorderRadius.circular(999),
                                      ),
                                      child: Text(card.behavior.name),
                                    ),
                                  ),
                                ),
                                if (_overlayBlocksGestures)
                                  Positioned.fill(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() => _overlayTapCount += 1);
                                        _pushTimeline('Overlay Tap', 'Overlay tapped in ${card.title}.');
                                      },
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: _overlayStrength),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Center(
                                          child: Icon(Icons.touch_app_outlined, color: Colors.white),
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
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClipTransformBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Clip + Transform Board', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Tune host geometry and visual wrappers to examine embed behavior under transformed composition.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 1020;
                final Widget controls = _clipTransformControls(scheme);
                final Widget preview = _miniPreviewStage(scheme);
                if (narrow) {
                  return Column(
                    children: <Widget>[preview, const SizedBox(height: 12), controls],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 6, child: preview),
                    const SizedBox(width: 12),
                    Expanded(flex: 5, child: controls),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniPreviewStage(ColorScheme scheme) {
    final Color colorA = scheme.primaryContainer.withValues(alpha: 0.72);
    final Color colorB = scheme.tertiaryContainer.withValues(alpha: 0.72);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Preview Geometry', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            SizedBox(
              height: 250,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: CustomPaint(painter: _GridPainter(color: scheme.outlineVariant.withValues(alpha: 0.18), step: 24))),
                  Positioned(
                    left: 32,
                    top: 28,
                    child: Transform.rotate(
                      angle: _rotation,
                      child: Transform.scale(
                        scale: _scale,
                        child: Opacity(
                          opacity: _opacity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(_cornerRadius),
                            clipBehavior: _clipPresets[_clipIndex].value,
                            child: Container(
                              width: 300,
                              height: 170,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: <Color>[colorA, colorB]),
                              ),
                              child: Center(
                                child: Text(
                                  _isMacOS ? 'AppKit host envelope' : 'Simulator envelope',
                                  style: TextStyle(color: scheme.onPrimaryContainer, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
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

  Widget _clipTransformControls(ColorScheme scheme) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Transform Controls', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            _slider(
              scheme: scheme,
              label: 'Stage Width',
              value: _stageWidth,
              min: 320,
              max: 760,
              divisions: 88,
              onChanged: (double v) => setState(() => _stageWidth = v),
              onChangeEnd: (double v) => _pushTimeline('Geometry', 'Stage width set to ${v.toStringAsFixed(0)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Stage Height',
              value: _stageHeight,
              min: 190,
              max: 440,
              divisions: 50,
              onChanged: (double v) => setState(() => _stageHeight = v),
              onChangeEnd: (double v) => _pushTimeline('Geometry', 'Stage height set to ${v.toStringAsFixed(0)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Corner Radius',
              value: _cornerRadius,
              min: 0,
              max: 42,
              divisions: 42,
              onChanged: (double v) => setState(() => _cornerRadius = v),
              onChangeEnd: (double v) => _pushTimeline('Clip', 'Corner radius set to ${v.toStringAsFixed(0)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Rotation (rad)',
              value: _rotation,
              min: -0.45,
              max: 0.45,
              divisions: 90,
              onChanged: (double v) => setState(() => _rotation = v),
              onChangeEnd: (double v) => _pushTimeline('Transform', 'Rotation set to ${v.toStringAsFixed(2)} rad.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Scale',
              value: _scale,
              min: 0.72,
              max: 1.35,
              divisions: 63,
              onChanged: (double v) => setState(() => _scale = v),
              onChangeEnd: (double v) => _pushTimeline('Transform', 'Scale set to ${v.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Opacity',
              value: _opacity,
              min: 0.2,
              max: 1,
              divisions: 40,
              onChanged: (double v) => setState(() => _opacity = v),
              onChangeEnd: (double v) => _pushTimeline('Opacity', 'Opacity set to ${v.toStringAsFixed(2)}.'),
            ),
            _slider(
              scheme: scheme,
              label: 'Overlay Strength',
              value: _overlayStrength,
              min: 0,
              max: 0.7,
              divisions: 35,
              onChanged: (double v) => setState(() => _overlayStrength = v),
              onChangeEnd: (double v) => _pushTimeline('Overlay', 'Overlay strength set to ${v.toStringAsFixed(2)}.'),
            ),
            const Divider(height: 22),
            Text('Clip Presets', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Widget>.generate(_clipPresets.length, (int i) {
                final _ClipPreset p = _clipPresets[i];
                return ChoiceChip(
                  selected: i == _clipIndex,
                  label: Text(p.label),
                  onSelected: (_) {
                    setState(() {
                      _clipIndex = i;
                      _clipSwitchCount += 1;
                    });
                    _pushTimeline('Clip', 'Switched to ${p.label}.');
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(_clipPresets[_clipIndex].note, style: TextStyle(color: scheme.onSurfaceVariant)),
            const Divider(height: 22),
            SwitchListTile(
              value: _showTransform,
              title: const Text('Enable Transform Wrappers'),
              onChanged: (bool v) => setState(() => _showTransform = v),
            ),
            SwitchListTile(
              value: _showOpacityWrap,
              title: const Text('Enable Opacity Wrapper'),
              onChanged: (bool v) => setState(() => _showOpacityWrap = v),
            ),
          ],
        ),
      ),
    );
  }

  Widget _slider({
    required ColorScheme scheme,
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    required ValueChanged<double> onChangeEnd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text(label, style: TextStyle(color: scheme.onSurface))),
            Text(value.toStringAsFixed(2), style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
        Slider(value: value, min: min, max: max, divisions: divisions, onChanged: onChanged, onChangeEnd: onChangeEnd),
      ],
    );
  }

  Widget _buildLifecycleOpsBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Lifecycle Ops', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Tune profile and recognizers, then recreate the host to observe lifecycle and creation-param propagation.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool narrow = constraints.maxWidth < 980;
                final Widget left = _lifecycleControls(scheme);
                final Widget right = _creationParamsPanel(scheme);
                if (narrow) {
                  return Column(children: <Widget>[left, const SizedBox(height: 10), right]);
                }
                return Row(children: <Widget>[Expanded(child: left), const SizedBox(width: 10), Expanded(child: right)]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _lifecycleControls(ColorScheme scheme) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Host Profiles', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <String>['baseline', 'analytics', 'immersive', 'editor', 'monitor'].map((String p) {
                return ChoiceChip(
                  selected: p == _activeProfile,
                  label: Text(p),
                  onSelected: (_) {
                    setState(() {
                      _activeProfile = p;
                      _profileSwitchCount += 1;
                    });
                    _pushTimeline('Profile', 'Active host profile changed to $p.');
                  },
                );
              }).toList(),
            ),
            const Divider(height: 22),
            Text('Gesture Recognizers', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _enableTapRecognizer,
              title: const Text('Tap Recognizer'),
              onChanged: (bool? v) => setState(() => _enableTapRecognizer = v ?? true),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _enablePanRecognizer,
              title: const Text('Pan Recognizer'),
              onChanged: (bool? v) => setState(() => _enablePanRecognizer = v ?? false),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _enableLongPressRecognizer,
              title: const Text('Long Press Recognizer'),
              onChanged: (bool? v) => setState(() => _enableLongPressRecognizer = v ?? false),
            ),
            const Divider(height: 22),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _revision += 1;
                        _recreateCount += 1;
                      });
                      _pushTimeline('Recreate', 'Requested host recreation at revision $_revision.');
                    },
                    icon: const Icon(Icons.restart_alt_outlined),
                    label: const Text('Recreate Host'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _creationParamsPanel(ColorScheme scheme) {
    final Map<String, Object> params = _creationParams();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Creation Params Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ...params.entries.map((MapEntry<String, Object> e) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: ListTile(
                  dense: true,
                  title: Text(e.key, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                  subtitle: Text('${e.value}', style: TextStyle(color: scheme.onSurfaceVariant)),
                ),
              );
            }),
            const SizedBox(height: 8),
            Text(
              'This map is passed with StandardMessageCodec when the AppKitView is created or recreated.',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsBoard(ColorScheme scheme) {
    final List<_MetricEntry> metrics = _metrics();
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Metrics and Diagnostics', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int columns = constraints.maxWidth > 1180
                    ? 4
                    : constraints.maxWidth > 860
                        ? 3
                        : constraints.maxWidth > 560
                            ? 2
                            : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: metrics.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 2.7 : 1.92,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final _MetricEntry m = metrics[index];
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: scheme.outlineVariant),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(m.icon, size: 18, color: scheme.primary),
                                const SizedBox(width: 8),
                                Expanded(child: Text(m.label, style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700))),
                              ],
                            ),
                            const Spacer(),
                            Text(m.value, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800, fontSize: 15)),
                            const SizedBox(height: 4),
                            Text(m.note, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            if (_showDiagnostics) const SizedBox(height: 12),
            if (_showDiagnostics) _buildDiagnosticsPanel(scheme),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosticsPanel(ColorScheme scheme) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.terminal, color: scheme.primary),
                const SizedBox(width: 8),
                Text('Snapshot', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 8),
            Text('platform=$_platformState scenario=${_scenarios[_scenarioIndex].id} theme=${_themes[_themeIndex].id}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('revision=$_revision profile=$_activeProfile created=$_hostCreatedCount recreates=$_recreateCount', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('hitTest=${_hitTestPresets[_hitBehaviorIndex].behavior.name} clip=${_clipPresets[_clipIndex].value.name}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('rotation=${_rotation.toStringAsFixed(2)} scale=${_scale.toStringAsFixed(2)} opacity=${_opacity.toStringAsFixed(2)}', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('recognizers tap=$_enableTapRecognizer pan=$_enablePanRecognizer long=$_enableLongPressRecognizer', style: TextStyle(color: scheme.onSurfaceVariant)),
            Text('hostTaps=$_hostTapCount overlayTaps=$_overlayTapCount overlayBlocks=$_overlayBlocksGestures', style: TextStyle(color: scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Guide and FAQ', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            ..._guideBullets.map((String line) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Icon(Icons.circle, size: 8, color: scheme.primary),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: TextStyle(color: scheme.onSurfaceVariant))),
                  ],
                ),
              );
            }),
            const Divider(height: 22),
            ..._faq.map(( _FaqEntry f) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(f.q, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(f.a, style: TextStyle(color: scheme.onSurfaceVariant)),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineBoard(ColorScheme scheme) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Timeline', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700, fontSize: 18)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => setState(() => _timeline = const <_TimelineEvent>[]),
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Chronological event stream for host creation, control changes, and gesture interactions.', style: TextStyle(color: scheme.onSurfaceVariant)),
            const SizedBox(height: 10),
            if (_timeline.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Text('Timeline is empty. Interact with controls to populate operations.', style: TextStyle(color: scheme.onSurfaceVariant)),
              )
            else
              Column(
                children: _timeline.map(( _TimelineEvent e) {
                  final String stamp = '${e.time.hour.toString().padLeft(2, '0')}:${e.time.minute.toString().padLeft(2, '0')}:${e.time.second.toString().padLeft(2, '0')}';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: scheme.outlineVariant),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: scheme.primaryContainer,
                        child: Text(stamp.substring(stamp.length - 2), style: TextStyle(color: scheme.onPrimaryContainer)),
                      ),
                      title: Text(e.title, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
                      subtitle: Text('$stamp  |  ${e.message}', style: TextStyle(color: scheme.onSurfaceVariant)),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.color, required this.step});

  final Color color;
  final double step;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.step != step;
  }
}
