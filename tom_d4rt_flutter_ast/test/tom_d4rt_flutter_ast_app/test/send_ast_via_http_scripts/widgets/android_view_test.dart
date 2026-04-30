import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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
    name: 'Ocean Coral',
    primary: Color(0xFF0077B6),
    secondary: Color(0xFFFF6B6B),
    accent: Color(0xFF4ECDC4),
    background: Color(0xFFF0F8FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1A2E3B),
    muted: Color(0xFF6B8A9E),
  ),
  _Palette(
    name: 'Sage Ember',
    primary: Color(0xFF2D5A27),
    secondary: Color(0xFFD4A03C),
    accent: Color(0xFF6B4423),
    background: Color(0xFFF5F7F2),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF1E2D1A),
    muted: Color(0xFF6D7A68),
  ),
  _Palette(
    name: 'Indigo Rose',
    primary: Color(0xFF4C3F91),
    secondary: Color(0xFFE45B84),
    accent: Color(0xFF00C9A7),
    background: Color(0xFFF8F6FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF20183D),
    muted: Color(0xFF7B6FA3),
  ),
];

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
    label: 'Compact',
    width: 320,
    height: 480,
    note: 'Small form factor for tight layout boundary tests.',
  ),
  _ShellProfile(
    label: 'Medium',
    width: 580,
    height: 520,
    note: 'Balanced shell for multi-lane comparisons.',
  ),
  _ShellProfile(
    label: 'Wide',
    width: 880,
    height: 600,
    note: 'Full width shell for gallery and diagnostic overlays.',
  ),
];

enum _Stage {
  viewType,
  clipBehavior,
  hitTest,
  gestures,
  layoutDirection,
  compendium,
}

enum _Density {
  sparse,
  normal,
  compact,
}

class _TraceEntry {
  final DateTime time;
  final String source;
  final String message;
  final Color color;

  const _TraceEntry({
    required this.time,
    required this.source,
    required this.message,
    required this.color,
  });
}

dynamic build(BuildContext context) {
  return const _AndroidViewDeepDemo();
}

class _AndroidViewDeepDemo extends StatefulWidget {
  const _AndroidViewDeepDemo();

  @override
  State<_AndroidViewDeepDemo> createState() => _AndroidViewDeepDemoState();
}

class _AndroidViewDeepDemoState extends State<_AndroidViewDeepDemo> {
  _Stage _stage = _Stage.viewType;
  _Density _density = _Density.normal;
  int _paletteIndex = 0;

  bool _attemptRealView = true;
  bool _useEagerRecognizer = true;
  bool _useVerticalDragRecognizer = false;
  bool _showGrid = true;
  bool _showMetrics = true;
  bool _verbose = false;

  Clip _clipBehavior = Clip.hardEdge;
  PlatformViewHitTestBehavior _hitTestBehavior = PlatformViewHitTestBehavior.opaque;
  TextDirection _layoutDirection = TextDirection.ltr;

  int _laneItemCount = 14;
  double _studioWidth = 820;
  double _studioHeight = 460;
  double _timelineHeight = 300;
  double _customShellWidth = 720;
  double _customShellHeight = 510;

  int _viewCreatedCount = 0;
  int _viewErrorCount = 0;

  final List<_TraceEntry> _trace = <_TraceEntry>[];

  static const _stageTitles = <String>[
    '1 View Type Registry Studio',
    '2 Clip Behavior Lab',
    '3 Hit-Test Arena',
    '4 Gesture Recognizer Workshop',
    '5 Layout Direction Theater',
    '6 Verification Compendium',
  ];

  _Palette get _p => _palettes[_paletteIndex];

  bool get _supportsAndroidView {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.fuchsia;
  }

  Set<Factory<OneSequenceGestureRecognizer>> _gestureRecognizers() {
    final set = <Factory<OneSequenceGestureRecognizer>>{};
    if (_useEagerRecognizer) {
      set.add(Factory<OneSequenceGestureRecognizer>(EagerGestureRecognizer.new));
    }
    if (_useVerticalDragRecognizer) {
      set.add(
        Factory<OneSequenceGestureRecognizer>(VerticalDragGestureRecognizer.new),
      );
    }
    return set;
  }

  int get _effectiveItemCount {
    switch (_density) {
      case _Density.sparse:
        return (_laneItemCount * 0.6).round();
      case _Density.normal:
        return _laneItemCount;
      case _Density.compact:
        return (_laneItemCount * 1.5).round();
    }
  }

  @override
  void initState() {
    super.initState();
    _pushTrace('boot', 'AndroidView studio initialized', _p.primary);
  }

  void _pushTrace(String source, String message, Color color) {
    final row = _TraceEntry(
      time: DateTime.now(),
      source: source,
      message: message,
      color: color,
    );
    setState(() {
      _trace.insert(0, row);
      if (_trace.length > 38) {
        _trace.removeRange(38, _trace.length);
      }
    });
    if (_verbose) {
      debugPrint('[AndroidView][$source] $message');
    }
  }

  void _onViewCreated(String label, int viewId) {
    setState(() => _viewCreatedCount += 1);
    _pushTrace('view', '$label created viewId=$viewId', _p.primary);
  }

  void _onViewError(String label, Object error) {
    setState(() => _viewErrorCount += 1);
    _pushTrace('view', '$label error: $error', _p.secondary);
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
            Expanded(child: _body()),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 13),
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
              const Icon(Icons.android_rounded, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'AndroidView Deep Demo',
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
                  'Platform View Embedding',
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
            'AndroidView embeds Android platform views directly into the Flutter '
            'widget tree using virtual display technology. This demo explores '
            'viewType registration, clip behavior, hit testing, and gesture '
            'forwarding patterns.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.93),
              fontSize: 12.3,
              height: 1.33,
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
          _densityChip('Sparse', _Density.sparse),
          _densityChip('Normal', _Density.normal),
          _densityChip('Compact', _Density.compact),
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

  Widget _densityChip(String label, _Density mode) {
    return ChoiceChip(
      selected: _density == mode,
      selectedColor: _p.secondary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _density == mode ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11,
      ),
      onSelected: (_) => setState(() => _density = mode),
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

  Widget _body() {
    switch (_stage) {
      case _Stage.viewType:
        return _viewTypeStage();
      case _Stage.clipBehavior:
        return _clipBehaviorStage();
      case _Stage.hitTest:
        return _hitTestStage();
      case _Stage.gestures:
        return _gesturesStage();
      case _Stage.layoutDirection:
        return _layoutDirectionStage();
      case _Stage.compendium:
        return _compendiumStage();
    }
  }

  Widget _viewTypeStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('View Type Registry Studio'),
          const SizedBox(height: 8),
          Text(
            'AndroidView requires a registered viewType that maps to a native '
            'Android view factory. This stage demonstrates basic AndroidView '
            'creation, layout constraints, and onPlatformViewCreated callbacks.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Registry Controls',
            subtitle: 'Tune studio dimensions and lane item density.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'studio width',
                  value: _studioWidth,
                  min: 360,
                  max: 1100,
                  divisions: 37,
                  display: _studioWidth.toStringAsFixed(0),
                  color: _p.primary,
                  onChanged: (v) => setState(() => _studioWidth = v),
                ),
                _sliderRow(
                  label: 'studio height',
                  value: _studioHeight,
                  min: 280,
                  max: 700,
                  divisions: 42,
                  display: _studioHeight.toStringAsFixed(0),
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _studioHeight = v),
                ),
                _sliderRow(
                  label: 'lane item count',
                  value: _laneItemCount.toDouble(),
                  min: 6,
                  max: 36,
                  divisions: 30,
                  display: '$_laneItemCount',
                  color: _p.accent,
                  onChanged: (v) => setState(() => _laneItemCount = v.round()),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _attemptRealView,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _attemptRealView = v ?? true),
                    ),
                    Text('attempt real AndroidView',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _showGrid,
                      activeColor: _p.secondary,
                      onChanged: (v) => setState(() => _showGrid = v ?? true),
                    ),
                    Text('overlay grid', style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _showMetrics,
                      activeColor: _p.accent,
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
            title: 'Registry Preview',
            subtitle: 'Live AndroidView lane plus registration checklist.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: Center(
              child: SizedBox(
                width: _studioWidth,
                height: _studioHeight,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _AndroidViewLane(
                              key: ValueKey(
                                'registry-$_attemptRealView-$_clipBehavior-$_hitTestBehavior-$_gestureRecognizers().length',
                              ),
                              label: 'Registry Lane',
                              viewId: 5101,
                              viewType: 'demo.android.view.registry',
                              palette: _p,
                              canCreateReal: _supportsAndroidView,
                              attemptReal: _attemptRealView,
                              clipBehavior: _clipBehavior,
                              hitTestBehavior: _hitTestBehavior,
                              gestureRecognizers: _gestureRecognizers(),
                              layoutDirection: _layoutDirection,
                              height: _studioHeight,
                              itemCount: _effectiveItemCount,
                              onTrace: _pushTrace,
                              onCreated: _onViewCreated,
                              onError: _onViewError,
                              showMetrics: _showMetrics,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _registryChecklist(),
                          ),
                        ],
                      ),
                    ),
                    if (_showGrid)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _GuidePainter(
                              color: _p.primary.withValues(alpha: 0.1),
                              spacing: 40,
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

  Widget _registryChecklist() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _p.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Registry Checklist',
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13),
          ),
          const SizedBox(height: 8),
          _bullet('Register viewType in native platform factory.'),
          _bullet('Create AndroidView with matching viewType string.'),
          _bullet('Handle onPlatformViewCreated callback for lifecycle.'),
          _bullet('Pass creationParams via codec for initialization.'),
          _bullet('Respect layoutDirection for LTR/RTL content.'),
          const SizedBox(height: 8),
          if (_showMetrics)
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _chip('created', '$_viewCreatedCount', _p.primary),
                _chip('errors', '$_viewErrorCount', _p.secondary),
              ],
            ),
          const SizedBox(height: 8),
          Text(
            _supportsAndroidView
                ? 'Host platform allows AndroidView creation.'
                : 'Host platform does not support AndroidView; simulated lane shown.',
            style: TextStyle(color: _p.muted, fontSize: 11.3, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _clipBehaviorStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Clip Behavior Lab'),
          const SizedBox(height: 8),
          Text(
            'AndroidView clipBehavior controls how content is clipped at the '
            'widget boundary. Compare Clip.none, hardEdge, antiAlias, and '
            'antiAliasWithSaveLayer side-by-side.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Clip Controls',
            subtitle: 'Select active clip behavior and compare all modes.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _clipChip('None', Clip.none),
                _clipChip('Hard Edge', Clip.hardEdge),
                _clipChip('Anti Alias', Clip.antiAlias),
                _clipChip('AA Save Layer', Clip.antiAliasWithSaveLayer),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _clipCard('Clip.none Lane', Clip.none, 5201),
              _clipCard('Clip.hardEdge Lane', Clip.hardEdge, 5202),
              _clipCard('Clip.antiAlias Lane', Clip.antiAlias, 5203),
              _clipCard('Clip.aaWithSaveLayer Lane', Clip.antiAliasWithSaveLayer, 5204),
            ],
          ),
        ],
      ),
    );
  }

  Widget _clipChip(String label, Clip clip) {
    return ChoiceChip(
      selected: _clipBehavior == clip,
      selectedColor: _p.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _clipBehavior == clip ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11.5,
      ),
      onSelected: (_) {
        setState(() => _clipBehavior = clip);
        _pushTrace('policy', 'clipBehavior -> $clip.name', _p.primary);
      },
    );
  }

  Widget _clipCard(String title, Clip clip, int viewId) {
    return SizedBox(
      width: 480,
      child: _card(
        title: title,
        subtitle: 'Clip.$clip.name',
        tint: _p.primary.withValues(alpha: 0.05),
        child: SizedBox(
          height: 340,
          child: _AndroidViewLane(
            key: ValueKey('clip-$viewId-$_attemptRealView-$_gestureRecognizers().length'),
            label: title,
            viewId: viewId,
            viewType: 'demo.android.view.clip.$viewId',
            palette: _p,
            canCreateReal: _supportsAndroidView,
            attemptReal: _attemptRealView,
            clipBehavior: clip,
            hitTestBehavior: _hitTestBehavior,
            gestureRecognizers: _gestureRecognizers(),
            layoutDirection: _layoutDirection,
            height: 340,
            itemCount: _effectiveItemCount,
            onTrace: _pushTrace,
            onCreated: _onViewCreated,
            onError: _onViewError,
            showMetrics: _showMetrics,
          ),
        ),
      ),
    );
  }

  Widget _hitTestStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Hit-Test Arena'),
          const SizedBox(height: 8),
          Text(
            'AndroidView hitTestBehavior determines how pointer events are '
            'handled between the platform view and overlapping Flutter widgets.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Hit-Test Controls',
            subtitle: 'Select active behavior and compare all modes.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _htChip('Opaque', PlatformViewHitTestBehavior.opaque),
                _htChip('Translucent', PlatformViewHitTestBehavior.translucent),
                _htChip('Transparent', PlatformViewHitTestBehavior.transparent),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _htCard('Opaque Lane', PlatformViewHitTestBehavior.opaque, 5301),
              _htCard('Translucent Lane', PlatformViewHitTestBehavior.translucent, 5302),
              _htCard('Transparent Lane', PlatformViewHitTestBehavior.transparent, 5303),
            ],
          ),
        ],
      ),
    );
  }

  Widget _htChip(String label, PlatformViewHitTestBehavior behavior) {
    return ChoiceChip(
      selected: _hitTestBehavior == behavior,
      selectedColor: _p.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _hitTestBehavior == behavior ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11.5,
      ),
      onSelected: (_) {
        setState(() => _hitTestBehavior = behavior);
        _pushTrace('policy', 'hitTestBehavior -> $behavior.name', _p.primary);
      },
    );
  }

  Widget _htCard(String title, PlatformViewHitTestBehavior behavior, int viewId) {
    return SizedBox(
      width: 500,
      child: _card(
        title: title,
        subtitle: 'PlatformViewHitTestBehavior.$behavior.name',
        tint: _p.primary.withValues(alpha: 0.05),
        child: SizedBox(
          height: 340,
          child: _AndroidViewLane(
            key: ValueKey('ht-$viewId-$_attemptRealView-$_clipBehavior-$_gestureRecognizers().length'),
            label: title,
            viewId: viewId,
            viewType: 'demo.android.view.hittest.$viewId',
            palette: _p,
            canCreateReal: _supportsAndroidView,
            attemptReal: _attemptRealView,
            clipBehavior: _clipBehavior,
            hitTestBehavior: behavior,
            gestureRecognizers: _gestureRecognizers(),
            layoutDirection: _layoutDirection,
            height: 340,
            itemCount: _effectiveItemCount,
            onTrace: _pushTrace,
            onCreated: _onViewCreated,
            onError: _onViewError,
            showMetrics: _showMetrics,
          ),
        ),
      ),
    );
  }

  Widget _gesturesStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Gesture Recognizer Workshop'),
          const SizedBox(height: 8),
          Text(
            'gestureRecognizers defines which gestures are forwarded to the '
            'embedded platform view. Toggle recognizer factories and observe '
            'policy chip updates.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Recognizer Controls',
            subtitle: 'Toggle gesture recognizer factories.',
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _useEagerRecognizer,
                      activeColor: _p.primary,
                      onChanged: (v) {
                        setState(() => _useEagerRecognizer = v ?? false);
                        _pushTrace('gesture', 'eager recognizer: $_useEagerRecognizer', _p.primary);
                      },
                    ),
                    Text('EagerGestureRecognizer',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _useVerticalDragRecognizer,
                      activeColor: _p.secondary,
                      onChanged: (v) {
                        setState(() => _useVerticalDragRecognizer = v ?? false);
                        _pushTrace(
                          'gesture',
                          'vertical drag recognizer: $_useVerticalDragRecognizer',
                          _p.secondary,
                        );
                      },
                    ),
                    Text('VerticalDragGestureRecognizer',
                        style: TextStyle(color: _p.ink, fontSize: 12)),
                  ],
                ),
                if (_showMetrics)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _chip('recognizers', '$_gestureRecognizers().length', _p.accent),
                      _chip('attempt real', _attemptRealView ? 'yes' : 'no', _p.primary),
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
              SizedBox(
                width: 500,
                child: _card(
                  title: 'Active Recognizer Lane',
                  subtitle: 'Uses current recognizer policy.',
                  tint: _p.primary.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 340,
                    child: _AndroidViewLane(
                      key: ValueKey(
                        'gesture-active-$_attemptRealView-$_useEagerRecognizer-$_useVerticalDragRecognizer',
                      ),
                      label: 'Active recognizers',
                      viewId: 5401,
                      viewType: 'demo.android.view.gesture.active',
                      palette: _p,
                      canCreateReal: _supportsAndroidView,
                      attemptReal: _attemptRealView,
                      clipBehavior: _clipBehavior,
                      hitTestBehavior: _hitTestBehavior,
                      gestureRecognizers: _gestureRecognizers(),
                      layoutDirection: _layoutDirection,
                      height: 340,
                      itemCount: _effectiveItemCount,
                      onTrace: _pushTrace,
                      onCreated: _onViewCreated,
                      onError: _onViewError,
                      showMetrics: _showMetrics,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 500,
                child: _card(
                  title: 'No Recognizer Lane',
                  subtitle: 'Empty recognizer set baseline.',
                  tint: _p.secondary.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 340,
                    child: _AndroidViewLane(
                      key: ValueKey('gesture-empty-$_attemptRealView-$_clipBehavior-$_hitTestBehavior'),
                      label: 'No recognizers',
                      viewId: 5402,
                      viewType: 'demo.android.view.gesture.empty',
                      palette: _p,
                      canCreateReal: _supportsAndroidView,
                      attemptReal: _attemptRealView,
                      clipBehavior: _clipBehavior,
                      hitTestBehavior: _hitTestBehavior,
                      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                      layoutDirection: _layoutDirection,
                      height: 340,
                      itemCount: _effectiveItemCount,
                      onTrace: _pushTrace,
                      onCreated: _onViewCreated,
                      onError: _onViewError,
                      showMetrics: _showMetrics,
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

  Widget _layoutDirectionStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Layout Direction Theater'),
          const SizedBox(height: 8),
          Text(
            'layoutDirection passes text direction context to the platform view. '
            'Shell profile testing validates responsive behavior across device sizes.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Direction Controls',
            subtitle: 'Toggle layout direction and tune custom shell dimensions.',
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _dirChip('LTR', TextDirection.ltr),
                    _dirChip('RTL', TextDirection.rtl),
                  ],
                ),
                const SizedBox(height: 10),
                _sliderRow(
                  label: 'custom width',
                  value: _customShellWidth,
                  min: 320,
                  max: 1080,
                  divisions: 38,
                  display: _customShellWidth.toStringAsFixed(0),
                  color: _p.primary,
                  onChanged: (v) => setState(() => _customShellWidth = v),
                ),
                _sliderRow(
                  label: 'custom height',
                  value: _customShellHeight,
                  min: 280,
                  max: 720,
                  divisions: 22,
                  display: _customShellHeight.toStringAsFixed(0),
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _customShellHeight = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Timeline Controls',
            subtitle: 'Runtime trace and policy diagnostics.',
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () => setState(_trace.clear),
                      icon: const Icon(Icons.delete_sweep_rounded),
                      label: const Text('Clear trace'),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () {
                        _pushTrace('note', 'Manual checkpoint marker', _p.accent);
                      },
                      icon: const Icon(Icons.bookmark_add_outlined),
                      label: const Text('Add marker'),
                    ),
                    const Spacer(),
                    if (_showMetrics)
                      _chip('trace rows', '$_trace.length', _p.accent),
                  ],
                ),
                _sliderRow(
                  label: 'timeline height',
                  value: _timelineHeight,
                  min: 180,
                  max: 500,
                  divisions: 32,
                  display: _timelineHeight.toStringAsFixed(0),
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _timelineHeight = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Trace Timeline',
            subtitle: 'Lifecycle and policy events from all demo stages.',
            tint: _p.primary.withValues(alpha: 0.04),
            child: SizedBox(
              height: _timelineHeight,
              child: _trace.isEmpty
                  ? Center(
                      child: Text(
                        'No trace rows yet. Interact with lanes and controls.',
                        style: TextStyle(color: _p.muted, fontSize: 12),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _trace.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final row = _trace[index];
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: row.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: row.color.withValues(alpha: 0.31)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _chip('src', row.source, row.color),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  row.message,
                                  style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.33),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _formatTime(row.time),
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
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (var i = 0; i < _shellProfiles.length; i++)
                _shellCard(_shellProfiles[i], 5500 + i),
              _shellCard(
                _ShellProfile(
                  label: 'Custom',
                  width: _customShellWidth,
                  height: _customShellHeight,
                  note: 'User-tuned shell for edge-case layout checks.',
                ),
                5601,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dirChip(String label, TextDirection dir) {
    return ChoiceChip(
      selected: _layoutDirection == dir,
      selectedColor: _p.primary,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _layoutDirection == dir ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11.5,
      ),
      onSelected: (_) {
        setState(() => _layoutDirection = dir);
        _pushTrace('policy', 'layoutDirection -> $dir', _p.primary);
      },
    );
  }

  Widget _shellCard(_ShellProfile shell, int viewId) {
    return SizedBox(
      width: shell.width > 600 ? 520 : 380,
      child: _card(
        title: '${shell.label} Shell',
        subtitle:
            'w ${shell.width.toStringAsFixed(0)} | h ${shell.height.toStringAsFixed(0)} | ${shell.note}',
        tint: _p.primary.withValues(alpha: 0.04),
        child: SizedBox(
          width: shell.width,
          height: shell.height,
          child: _AndroidViewLane(
            key: ValueKey('shell-$viewId-$_attemptRealView-$_layoutDirection-$_gestureRecognizers().length'),
            label: '${shell.label} lane',
            viewId: viewId,
            viewType: 'demo.android.view.shell.$viewId',
            palette: _p,
            canCreateReal: _supportsAndroidView,
            attemptReal: _attemptRealView,
            clipBehavior: _clipBehavior,
            hitTestBehavior: _hitTestBehavior,
            gestureRecognizers: _gestureRecognizers(),
            layoutDirection: _layoutDirection,
            height: shell.height,
            itemCount: _effectiveItemCount,
            onTrace: _pushTrace,
            onCreated: _onViewCreated,
            onError: _onViewError,
            showMetrics: _showMetrics,
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    final s = time.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
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
            title: 'AndroidView Matrix',
            subtitle: 'Core definition, inputs, and runtime behavior.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Widget role',
                  value: 'Embed Android platform views in Flutter using virtual display.',
                ),
                _matrixRow(
                  keyText: 'viewType',
                  value: 'String identifying the registered native view factory.',
                ),
                _matrixRow(
                  keyText: 'clipBehavior',
                  value: 'Controls content clipping at widget boundary.',
                ),
                _matrixRow(
                  keyText: 'hitTestBehavior',
                  value: 'Determines pointer event routing to platform view.',
                ),
                _matrixRow(
                  keyText: 'gestureRecognizers',
                  value: 'Defines gesture recognizers forwarded to platform view.',
                ),
                _matrixRow(
                  keyText: 'layoutDirection',
                  value: 'Provides text direction to platform view content.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Do and Dont',
            subtitle: 'Practical integration guidance.',
            child: Column(
              children: [
                _doDont(
                  good: true,
                  title: 'Register viewType before use',
                  detail: 'Native factory must be registered before AndroidView creation.',
                ),
                _doDont(
                  good: false,
                  title: 'Ignore clip behavior implications',
                  detail: 'Clip mode affects visual fidelity and rendering cost.',
                ),
                _doDont(
                  good: true,
                  title: 'Design gesture policy intentionally',
                  detail: 'Recognizer set should match platform view interaction model.',
                ),
                _doDont(
                  good: false,
                  title: 'Neglect layoutDirection on localized apps',
                  detail: 'RTL content needs correct direction for proper rendering.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common AndroidView integration questions.',
            child: Column(
              children: [
                _qa(
                  q: 'What is the difference between AndroidView and AndroidViewSurface?',
                  a: 'AndroidView uses virtual display; AndroidViewSurface uses surface composition.',
                ),
                _qa(
                  q: 'When is onPlatformViewCreated called?',
                  a: 'After the native platform view is instantiated and ready.',
                ),
                _qa(
                  q: 'How do I pass initialization data?',
                  a: 'Use creationParams with a creationParamsCodec like StandardMessageCodec.',
                ),
                _qa(
                  q: 'Can AndroidView run on non-Android hosts?',
                  a: 'No, real creation requires Android; use simulation fallback on other platforms.',
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
                _check('View Type Registry stage demonstrates basic creation and callbacks.'),
                _check('Clip Behavior Lab compares all Clip modes side-by-side.'),
                _check('Hit-Test Arena visualizes all hit test behavior modes.'),
                _check('Gesture Workshop allows recognizer policy toggling.'),
                _check('Layout Direction Theater demonstrates LTR/RTL and responsive shells.'),
                _check('Compendium provides matrix, do/dont, FAQ, and checklist guidance.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'AndroidView integrates native Android views using virtual display '
            'rendering. Design viewType mapping carefully, choose gesture policy '
            'intentionally, and provide safe fallback on non-Android platforms.',
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
          width: 200,
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
            width: 180,
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

class _AndroidViewLane extends StatefulWidget {
  const _AndroidViewLane({
    super.key,
    required this.label,
    required this.viewId,
    required this.viewType,
    required this.palette,
    required this.canCreateReal,
    required this.attemptReal,
    required this.clipBehavior,
    required this.hitTestBehavior,
    required this.gestureRecognizers,
    required this.layoutDirection,
    required this.height,
    required this.itemCount,
    required this.onTrace,
    required this.onCreated,
    required this.onError,
    required this.showMetrics,
  });

  final String label;
  final int viewId;
  final String viewType;
  final _Palette palette;
  final bool canCreateReal;
  final bool attemptReal;
  final Clip clipBehavior;
  final PlatformViewHitTestBehavior hitTestBehavior;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final TextDirection layoutDirection;
  final double height;
  final int itemCount;
  final void Function(String source, String message, Color color) onTrace;
  final void Function(String label, int viewId) onCreated;
  final void Function(String label, Object error) onError;
  final bool showMetrics;

  @override
  State<_AndroidViewLane> createState() => _AndroidViewLaneState();
}

class _AndroidViewLaneState extends State<_AndroidViewLane> {
  String _status = 'idle';
  int? _createdViewId;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _initView();
  }

  void _initView() {
    if (!widget.attemptReal) {
      setState(() => _status = 'simulated');
      return;
    }

    if (!widget.canCreateReal) {
      setState(() => _status = 'unsupported');
      return;
    }

    setState(() => _status = 'ready');
    widget.onTrace(
      'view',
      '${widget.label} ready for AndroidView creation',
      widget.palette.primary,
    );
  }

  void _handleViewCreated(int id) {
    setState(() {
      _status = 'created';
      _createdViewId = id;
    });
    widget.onCreated(widget.label, id);
  }

  @override
  Widget build(BuildContext context) {
    if (_status == 'simulated') {
      return _simulationCard('Real view disabled by policy toggle.');
    }
    if (_status == 'unsupported') {
      return _simulationCard('Host platform does not support AndroidView creation.');
    }
    if (_status == 'error') {
      return _simulationCard('View creation error: $_error');
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.palette.muted.withValues(alpha: 0.24)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
            decoration: BoxDecoration(
              color: widget.palette.secondary.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    color: widget.palette.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 11.8,
                  ),
                ),
                if (widget.showMetrics) ...[
                  _laneChip('viewId', '${widget.viewId}', widget.palette.primary),
                  _laneChip('clip', widget.clipBehavior.name, widget.palette.secondary),
                  _laneChip('hitTest', widget.hitTestBehavior.name, widget.palette.accent),
                ],
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: AndroidView(
                    viewType: widget.viewType,
                    layoutDirection: widget.layoutDirection,
                    creationParams: <String, dynamic>{
                      'lane': widget.label,
                      'viewId': widget.viewId,
                    },
                    creationParamsCodec: const StandardMessageCodec(),
                    clipBehavior: widget.clipBehavior,
                    hitTestBehavior: widget.hitTestBehavior,
                    gestureRecognizers: widget.gestureRecognizers,
                    onPlatformViewCreated: _handleViewCreated,
                  ),
                ),
                Positioned(
                  left: 8,
                  right: 8,
                  bottom: 8,
                  child: _floatingOverlay(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingOverlay() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: widget.palette.muted.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _createdViewId != null
                  ? 'AndroidView active. viewId=$_createdViewId'
                  : 'AndroidView rendering. Interact to trigger gesture forwarding.',
              style: TextStyle(color: widget.palette.ink, fontSize: 10.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _simulationCard(String reason) {
    return Container(
      decoration: BoxDecoration(
        color: widget.palette.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.palette.primary.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: widget.palette.primary, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Simulation Lane',
                    style: TextStyle(
                      color: widget.palette.ink,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(reason, style: TextStyle(color: widget.palette.muted, fontSize: 11.3)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.itemCount,
                itemBuilder: (context, index) {
                  final color = index.isEven ? widget.palette.primary : widget.palette.secondary;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.android_rounded, color: color, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Simulated view tile ${index + 1}',
                            style: TextStyle(
                              color: widget.palette.ink,
                              fontWeight: FontWeight.w700,
                              fontSize: 11.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _laneChip(String label, String value, Color color) {
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
          color: widget.palette.ink,
          fontFamily: 'monospace',
          fontSize: 10.2,
          fontWeight: FontWeight.w700,
        ),
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
