import 'dart:async';

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
    name: 'Atlantic Brick',
    primary: Color(0xFF1D4ED8),
    secondary: Color(0xFFEA580C),
    accent: Color(0xFF0F766E),
    background: Color(0xFFF3F8FF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF15233D),
    muted: Color(0xFF5F6F8A),
  ),
  _Palette(
    name: 'Forest Iron',
    primary: Color(0xFF0F766E),
    secondary: Color(0xFF7C3AED),
    accent: Color(0xFFB45309),
    background: Color(0xFFF3FBF8),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF14322F),
    muted: Color(0xFF60726D),
  ),
  _Palette(
    name: 'Slate Lime',
    primary: Color(0xFF111827),
    secondary: Color(0xFF65A30D),
    accent: Color(0xFF0284C7),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF111827),
    muted: Color(0xFF667085),
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
    label: 'Pocket',
    width: 340,
    height: 500,
    note: 'Compact shell for high contrast platform-view boundaries.',
  ),
  _ShellProfile(
    label: 'Tablet',
    width: 640,
    height: 560,
    note: 'Mid shell for balanced control overlays and view surface.',
  ),
  _ShellProfile(
    label: 'Desktop',
    width: 920,
    height: 620,
    note: 'Wide shell for split diagnostics and platform-surface gallery.',
  ),
];

enum _Stage {
  lifecycle,
  hitTest,
  recognizers,
  switchboard,
  theater,
  compendium,
}

enum _Density {
  relaxed,
  balanced,
  dense,
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
  return const _AndroidViewSurfaceDeepDemo();
}

class _AndroidViewSurfaceDeepDemo extends StatefulWidget {
  const _AndroidViewSurfaceDeepDemo();

  @override
  State<_AndroidViewSurfaceDeepDemo> createState() =>
      _AndroidViewSurfaceDeepDemoState();
}

class _AndroidViewSurfaceDeepDemoState extends State<_AndroidViewSurfaceDeepDemo> {
  _Stage _stage = _Stage.lifecycle;
  _Density _density = _Density.balanced;
  int _paletteIndex = 0;

  bool _attemptRealSurface = true;
  bool _useEagerRecognizer = true;
  bool _useVerticalDragRecognizer = false;
  bool _showGrid = true;
  bool _showMetrics = true;
  bool _verbose = false;

  PlatformViewHitTestBehavior _hitTestBehavior = PlatformViewHitTestBehavior.opaque;

  int _laneItemCount = 18;
  double _studioWidth = 860;
  double _studioHeight = 490;
  double _timelineHeight = 320;
  double _customShellWidth = 760;
  double _customShellHeight = 540;

  int _surfaceCreatedCount = 0;
  int _surfaceErrorCount = 0;
  int _surfaceDisposedCount = 0;

  final List<_TraceEntry> _trace = <_TraceEntry>[];

  static const _stageTitles = <String>[
    '1 Surface Lifecycle Studio',
    '2 Hit-Test Behavior Arena',
    '3 Gesture Recognizer Lab',
    '4 Runtime Switchboard',
    '5 Device Theater',
    '6 Verification Compendium',
  ];

  _Palette get _p => _palettes[_paletteIndex];

  bool get _supportsAndroidSurface {
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
      case _Density.relaxed:
        return (_laneItemCount * 0.7).round();
      case _Density.balanced:
        return _laneItemCount;
      case _Density.dense:
        return (_laneItemCount * 1.6).round();
    }
  }

  @override
  void initState() {
    super.initState();
    _pushTrace('boot', 'AndroidViewSurface studio initialized', _p.primary);
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
      if (_trace.length > 42) {
        _trace.removeRange(42, _trace.length);
      }
    });
    if (_verbose) {
      debugPrint('[AndroidViewSurface][$source] $message');
    }
  }

  void _onSurfaceCreated(String label) {
    setState(() => _surfaceCreatedCount += 1);
    _pushTrace('surface', '$label created', _p.primary);
  }

  void _onSurfaceError(String label, Object error) {
    setState(() => _surfaceErrorCount += 1);
    _pushTrace('surface', '$label error: $error', _p.secondary);
  }

  void _onSurfaceDisposed(String label) {
    setState(() => _surfaceDisposedCount += 1);
    _pushTrace('surface', '$label disposed', _p.accent);
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
              const Icon(Icons.view_quilt_rounded, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'AndroidViewSurface Deep Demo',
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
                  'Platform Surface Embedding',
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
            'AndroidViewSurface renders Android platform views in Flutter layer '
            'composition using an AndroidViewController. This demo explores '
            'lifecycle, hit testing, gesture recognizers, and runtime policy.',
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
      case _Stage.lifecycle:
        return _lifecycleStage();
      case _Stage.hitTest:
        return _hitTestStage();
      case _Stage.recognizers:
        return _recognizerStage();
      case _Stage.switchboard:
        return _switchboardStage();
      case _Stage.theater:
        return _theaterStage();
      case _Stage.compendium:
        return _compendiumStage();
    }
  }

  Widget _lifecycleStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Surface Lifecycle Studio'),
          const SizedBox(height: 8),
          Text(
            'This stage introduces AndroidViewSurface lifecycle: initialize '
            'controller, create platform view, render in surface, dispose safely.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Lifecycle Controls',
            subtitle: 'Runtime knobs for platform-surface behavior.',
            child: Column(
              children: [
                _sliderRow(
                  label: 'studio width',
                  value: _studioWidth,
                  min: 360,
                  max: 1120,
                  divisions: 38,
                  display: _studioWidth.toStringAsFixed(0),
                  color: _p.primary,
                  onChanged: (v) => setState(() => _studioWidth = v),
                ),
                _sliderRow(
                  label: 'studio height',
                  value: _studioHeight,
                  min: 280,
                  max: 720,
                  divisions: 44,
                  display: _studioHeight.toStringAsFixed(0),
                  color: _p.secondary,
                  onChanged: (v) => setState(() => _studioHeight = v),
                ),
                _sliderRow(
                  label: 'feed item count',
                  value: _laneItemCount.toDouble(),
                  min: 8,
                  max: 42,
                  divisions: 34,
                  display: '$_laneItemCount',
                  color: _p.accent,
                  onChanged: (v) => setState(() => _laneItemCount = v.round()),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _attemptRealSurface,
                      activeColor: _p.primary,
                      onChanged: (v) => setState(() => _attemptRealSurface = v ?? true),
                    ),
                    Text('attempt real AndroidViewSurface',
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
            title: 'Lifecycle Preview',
            subtitle: 'Live AndroidViewSurface lane plus lifecycle checklist.',
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
                            child: _AndroidViewSurfaceLane(
                              key: ValueKey(
                                  'lifecycle-$_attemptRealSurface-$_hitTestBehavior.name-$_gestureRecognizers().length'),
                              label: 'Lifecycle Lane',
                              viewId: 4101,
                              viewType: 'demo.android.surface.lifecycle',
                              palette: _p,
                              canCreateReal: _supportsAndroidSurface,
                              attemptReal: _attemptRealSurface,
                              hitTestBehavior: _hitTestBehavior,
                              gestureRecognizers: _gestureRecognizers(),
                              height: _studioHeight,
                              itemCount: _effectiveItemCount,
                              onTrace: _pushTrace,
                              onCreated: _onSurfaceCreated,
                              onError: _onSurfaceError,
                              onDisposed: _onSurfaceDisposed,
                              showMetrics: _showMetrics,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _lifecycleChecklist(),
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

  Widget _lifecycleChecklist() {
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
            'Lifecycle Checklist',
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13),
          ),
          const SizedBox(height: 8),
          _bullet('Create AndroidViewController via PlatformViewsService.'),
          _bullet('Call create() and await platform view creation.'),
          _bullet('Render with AndroidViewSurface using controller + hit test behavior.'),
          _bullet('Provide gestureRecognizers policy for gesture routing.'),
          _bullet('Dispose controller when lane is removed.'),
          const SizedBox(height: 8),
          if (_showMetrics)
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _chip('created', '$_surfaceCreatedCount', _p.primary),
                _chip('errors', '$_surfaceErrorCount', _p.secondary),
                _chip('disposed', '$_surfaceDisposedCount', _p.accent),
              ],
            ),
          const SizedBox(height: 8),
          Text(
            _supportsAndroidSurface
                ? 'Host platform allows Android surface attempt.'
                : 'Host platform does not support Android surface; simulated lane shown.',
            style: TextStyle(color: _p.muted, fontSize: 11.3, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _hitTestStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Hit-Test Behavior Arena'),
          const SizedBox(height: 8),
          Text(
            'AndroidViewSurface exposes hitTestBehavior to control how pointer '
            'events interact with overlapping Flutter widgets.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Behavior Controls',
            subtitle: 'Select default behavior and compare all three side-by-side.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _behaviorChip('Opaque', PlatformViewHitTestBehavior.opaque),
                _behaviorChip('Translucent', PlatformViewHitTestBehavior.translucent),
                _behaviorChip('Transparent', PlatformViewHitTestBehavior.transparent),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _behaviorCard('Opaque Lane', PlatformViewHitTestBehavior.opaque, 4201),
              _behaviorCard('Translucent Lane', PlatformViewHitTestBehavior.translucent, 4202),
              _behaviorCard('Transparent Lane', PlatformViewHitTestBehavior.transparent, 4203),
            ],
          ),
        ],
      ),
    );
  }

  Widget _behaviorChip(String label, PlatformViewHitTestBehavior behavior) {
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

  Widget _behaviorCard(String title, PlatformViewHitTestBehavior behavior, int viewId) {
    return SizedBox(
      width: 520,
      child: _card(
        title: title,
        subtitle: 'PlatformViewHitTestBehavior.$behavior.name',
        tint: _p.primary.withValues(alpha: 0.05),
        child: SizedBox(
          height: 360,
          child: _AndroidViewSurfaceLane(
            key: ValueKey('hit-$viewId-$_attemptRealSurface-$_gestureRecognizers().length'),
            label: title,
            viewId: viewId,
            viewType: 'demo.android.surface.hittest.$viewId',
            palette: _p,
            canCreateReal: _supportsAndroidSurface,
            attemptReal: _attemptRealSurface,
            hitTestBehavior: behavior,
            gestureRecognizers: _gestureRecognizers(),
            height: 360,
            itemCount: _effectiveItemCount,
            onTrace: _pushTrace,
            onCreated: _onSurfaceCreated,
            onError: _onSurfaceError,
            onDisposed: _onSurfaceDisposed,
            showMetrics: _showMetrics,
          ),
        ),
      ),
    );
  }

  Widget _recognizerStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Gesture Recognizer Lab'),
          const SizedBox(height: 8),
          Text(
            'gestureRecognizers controls which gesture recognizers are forwarded '
            'to the embedded platform view in AndroidViewSurface.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Recognizer Controls',
            subtitle: 'Toggle recognizer factories and watch policy chips update.',
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
                      _chip('attempt real', _attemptRealSurface ? 'yes' : 'no', _p.primary),
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
                width: 520,
                child: _card(
                  title: 'Current Policy Lane',
                  subtitle: 'Uses active recognizer set.',
                  tint: _p.primary.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 360,
                    child: _AndroidViewSurfaceLane(
                      key: ValueKey(
                          'gesture-current-$_attemptRealSurface-$_useEagerRecognizer-$_useVerticalDragRecognizer'),
                      label: 'Current recognizers',
                      viewId: 4301,
                      viewType: 'demo.android.surface.gesture.current',
                      palette: _p,
                      canCreateReal: _supportsAndroidSurface,
                      attemptReal: _attemptRealSurface,
                      hitTestBehavior: _hitTestBehavior,
                      gestureRecognizers: _gestureRecognizers(),
                      height: 360,
                      itemCount: _effectiveItemCount,
                      onTrace: _pushTrace,
                      onCreated: _onSurfaceCreated,
                      onError: _onSurfaceError,
                      onDisposed: _onSurfaceDisposed,
                      showMetrics: _showMetrics,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 520,
                child: _card(
                  title: 'Reference Lane (No Recognizers)',
                  subtitle: 'Empty recognizer set baseline.',
                  tint: _p.secondary.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 360,
                    child: _AndroidViewSurfaceLane(
                      key: ValueKey(
                        'gesture-empty-$_attemptRealSurface-$_hitTestBehavior.name',
                      ),
                      label: 'No recognizers',
                      viewId: 4302,
                      viewType: 'demo.android.surface.gesture.empty',
                      palette: _p,
                      canCreateReal: _supportsAndroidSurface,
                      attemptReal: _attemptRealSurface,
                      hitTestBehavior: _hitTestBehavior,
                      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                      height: 360,
                      itemCount: _effectiveItemCount,
                      onTrace: _pushTrace,
                      onCreated: _onSurfaceCreated,
                      onError: _onSurfaceError,
                      onDisposed: _onSurfaceDisposed,
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

  Widget _switchboardStage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Runtime Switchboard'),
          const SizedBox(height: 8),
          Text(
            'Centralized policy controls and timeline traces help debug '
            'AndroidViewSurface behavior during iterative script development.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Switchboard Controls',
            subtitle: 'Policy toggles and trace controls.',
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
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _attemptRealSurface = !_attemptRealSurface;
                        });
                        _pushTrace('policy', 'attempt real -> $_attemptRealSurface', _p.primary);
                      },
                      icon: const Icon(Icons.toggle_on_outlined),
                      label: Text(_attemptRealSurface ? 'Disable Real Attempt' : 'Enable Real Attempt'),
                    ),
                    const Spacer(),
                    if (_showMetrics)
                      _chip('trace rows', _trace.length.toString(), _p.accent),
                  ],
                ),
                _sliderRow(
                  label: 'timeline height',
                  value: _timelineHeight,
                  min: 220,
                  max: 560,
                  divisions: 34,
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
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    final s = time.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
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
            'Shell profile testing validates AndroidViewSurface layout and '
            'diagnostic overlays across compact, medium, and wide displays.',
            style: TextStyle(color: _p.ink, fontSize: 12.5, height: 1.34),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'Custom Shell Controls',
            subtitle: 'Tune dimensions for custom profile card.',
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
              for (var i = 0; i < _shellProfiles.length; i++)
                _shellCard(_shellProfiles[i], 4500 + i),
              _shellCard(
                _ShellProfile(
                  label: 'Custom',
                  width: _customShellWidth,
                  height: _customShellHeight,
                  note: 'User tuned shell profile for edge-case layout checks.',
                ),
                4601,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shellCard(_ShellProfile shell, int viewId) {
    return SizedBox(
      width: shell.width > 640 ? 540 : 390,
      child: _card(
        title: '$shell.label Shell',
        subtitle: 'w $shell.width.toStringAsFixed(0) | h $shell.height.toStringAsFixed(0) | $shell.note',
        tint: _p.primary.withValues(alpha: 0.04),
        child: SizedBox(
          width: shell.width,
          height: shell.height,
          child: _AndroidViewSurfaceLane(
            key: ValueKey('shell-$viewId-$_attemptRealSurface-$_gestureRecognizers().length'),
            label: '$shell.label lane',
            viewId: viewId,
            viewType: 'demo.android.surface.shell.$viewId',
            palette: _p,
            canCreateReal: _supportsAndroidSurface,
            attemptReal: _attemptRealSurface,
            hitTestBehavior: _hitTestBehavior,
            gestureRecognizers: _gestureRecognizers(),
            height: shell.height,
            itemCount: _effectiveItemCount,
            onTrace: _pushTrace,
            onCreated: _onSurfaceCreated,
            onError: _onSurfaceError,
            onDisposed: _onSurfaceDisposed,
            showMetrics: _showMetrics,
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
            title: 'AndroidViewSurface Matrix',
            subtitle: 'Core definition, inputs, and runtime behavior.',
            child: Column(
              children: [
                _matrixRow(
                  keyText: 'Widget role',
                  value: 'Render Android platform views in a Flutter surface-composited layer.',
                ),
                _matrixRow(
                  keyText: 'Core dependency',
                  value: 'Requires AndroidViewController from PlatformViewsService.',
                ),
                _matrixRow(
                  keyText: 'Hit test input',
                  value: 'PlatformViewHitTestBehavior controls pointer routing behavior.',
                ),
                _matrixRow(
                  keyText: 'Gesture policy',
                  value: 'gestureRecognizers defines forwarded gesture recognizer set.',
                ),
                _matrixRow(
                  keyText: 'Lifecycle',
                  value: 'init controller -> create view -> render surface -> dispose controller.',
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
                  title: 'Dispose controllers predictably',
                  detail: 'Treat platform view lifecycle explicitly to prevent leaks.',
                ),
                _doDont(
                  good: false,
                  title: 'Ignore hit test behavior defaults',
                  detail:
                      'Hit test policy should be intentional, especially with overlay controls.',
                ),
                _doDont(
                  good: true,
                  title: 'Design recognizer policy per lane',
                  detail:
                      'Gesture forwarding should align with the lane interaction model.',
                ),
                _doDont(
                  good: false,
                  title: 'Assume host platform always supports Android views',
                  detail:
                      'Provide safe fallback rendering when Android surface creation is unavailable.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            title: 'FAQ',
            subtitle: 'Common AndroidViewSurface integration questions.',
            child: Column(
              children: [
                _qa(
                  q: 'Why use AndroidViewSurface instead of AndroidView?',
                  a: 'It supports surface composition scenarios and explicit controller wiring.',
                ),
                _qa(
                  q: 'What if create() fails?',
                  a: 'Capture and surface the error state while providing a stable fallback UI.',
                ),
                _qa(
                  q: 'How do I tune pointer behavior?',
                  a: 'Adjust PlatformViewHitTestBehavior and gestureRecognizers together.',
                ),
                _qa(
                  q: 'Can this run on non-Android hosts?',
                  a: 'Real Android surface creation may not be available; use simulation fallback lanes.',
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
                _check('Lifecycle stage demonstrates controller create/render/dispose flow.'),
                _check('All hit test behavior modes are compared visually.'),
                _check('Gesture recognizer policy toggles are demonstrated.'),
                _check('Runtime switchboard includes actionable trace timeline.'),
                _check('Device theater validates responsive shell behavior.'),
                _check('Compendium includes matrix, do/dont, FAQ, and checklist guidance.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _note(
            'AndroidViewSurface is a deliberate integration primitive: route '
            'controller lifecycle clearly, define pointer policy intentionally, '
            'and always provide safe diagnostics for host/platform constraints.',
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
            width: 210,
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
          Text('Palette: $_p.name', style: TextStyle(color: _p.muted, fontSize: 11)),
        ],
      ),
    );
  }
}

class _AndroidViewSurfaceLane extends StatefulWidget {
  const _AndroidViewSurfaceLane({
    super.key,
    required this.label,
    required this.viewId,
    required this.viewType,
    required this.palette,
    required this.canCreateReal,
    required this.attemptReal,
    required this.hitTestBehavior,
    required this.gestureRecognizers,
    required this.height,
    required this.itemCount,
    required this.onTrace,
    required this.onCreated,
    required this.onError,
    required this.onDisposed,
    required this.showMetrics,
  });

  final String label;
  final int viewId;
  final String viewType;
  final _Palette palette;
  final bool canCreateReal;
  final bool attemptReal;
  final PlatformViewHitTestBehavior hitTestBehavior;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final double height;
  final int itemCount;
  final void Function(String source, String message, Color color) onTrace;
  final void Function(String label) onCreated;
  final void Function(String label, Object error) onError;
  final void Function(String label) onDisposed;
  final bool showMetrics;

  @override
  State<_AndroidViewSurfaceLane> createState() => _AndroidViewSurfaceLaneState();
}

class _AndroidViewSurfaceLaneState extends State<_AndroidViewSurfaceLane> {
  AndroidViewController? _controller;
  String _status = 'idle';
  Object? _error;

  @override
  void initState() {
    super.initState();
    _initSurface();
  }

  Future<void> _initSurface() async {
    if (!widget.attemptReal) {
      setState(() => _status = 'simulated');
      return;
    }

    if (!widget.canCreateReal) {
      setState(() => _status = 'unsupported');
      return;
    }

    try {
      widget.onTrace(
        'surface',
        '$widget.label initSurfaceAndroidView(viewId: $widget.viewId)',
        widget.palette.primary,
      );
      final controller = PlatformViewsService.initSurfaceAndroidView(
        id: widget.viewId,
        viewType: widget.viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: <String, dynamic>{
          'lane': widget.label,
          'viewId': widget.viewId,
        },
        creationParamsCodec: const StandardMessageCodec(),
        onFocus: () {
          widget.onTrace('surface', '$widget.label onFocus callback', widget.palette.accent);
        },
      );

      setState(() {
        _controller = controller;
        _status = 'creating';
      });

      controller.addOnPlatformViewCreatedListener((id) {
        widget.onTrace(
          'surface',
          '$widget.label platform view created id=$id',
          widget.palette.primary,
        );
      });

      await controller.create();
      if (!mounted) {
        return;
      }
      setState(() {
        _status = 'created';
      });
      widget.onCreated(widget.label);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _status = 'error';
        _error = error;
      });
      widget.onError(widget.label, error);
    }
  }

  @override
  void dispose() {
    final controller = _controller;
    if (controller != null) {
      widget.onDisposed(widget.label);
      unawaited(controller.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_status == 'simulated') {
      return _simulationCard('Real surface disabled by policy toggle.');
    }
    if (_status == 'unsupported') {
      return _simulationCard('Host platform does not support Android surface creation.');
    }
    if (_status == 'error') {
      return _simulationCard('Surface creation error: $_error');
    }
    if (_controller == null || _status == 'creating') {
      return _loadingCard();
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
                  _laneChip('viewId', widget.viewId.toString(), widget.palette.primary),
                  _laneChip('hitTest', widget.hitTestBehavior.name, widget.palette.secondary),
                  _laneChip(
                    'recognizers',
                    widget.gestureRecognizers.length.toString(),
                    widget.palette.accent,
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: AndroidViewSurface(
                    controller: _controller!,
                    hitTestBehavior: widget.hitTestBehavior,
                    gestureRecognizers: widget.gestureRecognizers,
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
              'Surface active. Drag area to interact with embedded platform lane.',
              style: TextStyle(color: widget.palette.ink, fontSize: 10.8),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {
              _controller?.clearFocus();
              widget.onTrace('surface', '$widget.label clearFocus()', widget.palette.accent);
            },
            child: const Text('Clear focus'),
          ),
        ],
      ),
    );
  }

  Widget _loadingCard() {
    return Container(
      decoration: BoxDecoration(
        color: widget.palette.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.palette.primary.withValues(alpha: 0.28)),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(height: 8),
            Text('Creating AndroidViewController...'),
          ],
        ),
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
                        Icon(Icons.view_stream_rounded, color: color, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Simulated platform tile ${index + 1}',
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
