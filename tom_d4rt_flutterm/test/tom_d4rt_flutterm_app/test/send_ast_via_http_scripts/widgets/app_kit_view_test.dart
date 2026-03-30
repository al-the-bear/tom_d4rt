import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class _DemoPalette {
  final String name;
  final Color shell;
  final Color canvas;
  final Color card;
  final Color ink;
  final Color muted;
  final Color accentA;
  final Color accentB;
  final Color accentC;

  const _DemoPalette({
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

const _palettes = <_DemoPalette>[
  _DemoPalette(
    name: 'Graphite Coast',
    shell: Color(0xFF11161B),
    canvas: Color(0xFFF4F7FB),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF1A2430),
    muted: Color(0xFF6B7A8B),
    accentA: Color(0xFF2F80ED),
    accentB: Color(0xFF27AE60),
    accentC: Color(0xFFF2994A),
  ),
  _DemoPalette(
    name: 'Cedar Mint',
    shell: Color(0xFF17211A),
    canvas: Color(0xFFF4F9F4),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF203124),
    muted: Color(0xFF6F8574),
    accentA: Color(0xFF2D7D46),
    accentB: Color(0xFF1E9C83),
    accentC: Color(0xFFB07D34),
  ),
  _DemoPalette(
    name: 'Slate Berry',
    shell: Color(0xFF1B1725),
    canvas: Color(0xFFF7F5FC),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF261F38),
    muted: Color(0xFF7A6F96),
    accentA: Color(0xFF5B5BD6),
    accentB: Color(0xFFB53F85),
    accentC: Color(0xFF3CAEA3),
  ),
];

class _WindowProfile {
  final String name;
  final double width;
  final double height;
  final String intent;

  const _WindowProfile({
    required this.name,
    required this.width,
    required this.height,
    required this.intent,
  });
}

const _windowProfiles = <_WindowProfile>[
  _WindowProfile(
    name: 'Compact Utility',
    width: 360,
    height: 310,
    intent: 'Small inspector utility surface for plugin controls.',
  ),
  _WindowProfile(
    name: 'Balanced Editor',
    width: 560,
    height: 390,
    intent: 'General-purpose content area for mixed AppKit widgets.',
  ),
  _WindowProfile(
    name: 'Wide Dashboard',
    width: 860,
    height: 430,
    intent: 'Analytics layout for side-by-side system panes.',
  ),
];

class _CreationPreset {
  final String id;
  final String title;
  final String explanation;
  final Map<String, dynamic> payload;

  const _CreationPreset({
    required this.id,
    required this.title,
    required this.explanation,
    required this.payload,
  });
}

const _creationPresets = <_CreationPreset>[
  _CreationPreset(
    id: 'editor-glass',
    title: 'Editor Glass',
    explanation: 'Semi-transparent editor shell with compact toolbar.',
    payload: <String, dynamic>{
      'theme': 'graphite',
      'glass': true,
      'sidebar': true,
      'toolbarDensity': 'compact',
    },
  ),
  _CreationPreset(
    id: 'console-heavy',
    title: 'Console Heavy',
    explanation: 'Dense console profile for monitoring workflows.',
    payload: <String, dynamic>{
      'theme': 'terminal',
      'glass': false,
      'sidebar': false,
      'toolbarDensity': 'dense',
    },
  ),
  _CreationPreset(
    id: 'studio-split',
    title: 'Studio Split',
    explanation: 'Two-pane studio with inspector and detail panel.',
    payload: <String, dynamic>{
      'theme': 'studio',
      'glass': true,
      'sidebar': true,
      'toolbarDensity': 'regular',
    },
  ),
];

enum _Stage {
  hostDock,
  interactionGallery,
  paramsWorkbench,
  gestureLab,
  windowTheater,
  compendium,
}

enum _Density {
  light,
  normal,
  dense,
}

class _TraceLine {
  final DateTime at;
  final String source;
  final String note;
  final Color tone;

  const _TraceLine({
    required this.at,
    required this.source,
    required this.note,
    required this.tone,
  });
}

dynamic build(BuildContext context) {
  return const _AppKitViewDeepDemo();
}

class _AppKitViewDeepDemo extends StatefulWidget {
  const _AppKitViewDeepDemo();

  @override
  State<_AppKitViewDeepDemo> createState() => _AppKitViewDeepDemoState();
}

class _AppKitViewDeepDemoState extends State<_AppKitViewDeepDemo> {
  _Stage _stage = _Stage.hostDock;
  _Density _density = _Density.normal;

  int _paletteIndex = 0;
  int _presetIndex = 0;

  bool _attemptLiveView = true;
  bool _showGrid = true;
  bool _showInspectorRail = true;
  bool _showTelemetry = true;
  bool _showBackdropPattern = true;
  bool _verboseLog = false;

  bool _useEager = true;
  bool _usePan = false;
  bool _useScale = false;

  Clip _clipMode = Clip.hardEdge;
  PlatformViewHitTestBehavior _hitBehavior = PlatformViewHitTestBehavior.opaque;

  double _dockWidth = 860;
  double _dockHeight = 380;
  double _cornerRadius = 18;
  double _timelineHeight = 250;
  double _customWindowWidth = 700;
  double _customWindowHeight = 360;
  int _simRowCount = 14;

  int _createdCount = 0;
  int _errorCount = 0;

  final List<_TraceLine> _timeline = <_TraceLine>[];

  static const _stageLabels = <String>[
    '1 Host Dock Studio',
    '2 Interaction Policy Gallery',
    '3 Creation Params Workbench',
    '4 Gesture Routing Lab',
    '5 Window Theater',
    '6 Verification Compendium',
  ];

  _DemoPalette get _p => _palettes[_paletteIndex];

  bool get _supportsAppKit {
    return defaultTargetPlatform == TargetPlatform.macOS;
  }

  int get _effectiveSimRows {
    switch (_density) {
      case _Density.light:
        return (_simRowCount * 0.7).round();
      case _Density.normal:
        return _simRowCount;
      case _Density.dense:
        return (_simRowCount * 1.5).round();
    }
  }

  Set<Factory<OneSequenceGestureRecognizer>> _recognizers() {
    final set = <Factory<OneSequenceGestureRecognizer>>{};
    if (_useEager) {
      set.add(Factory<OneSequenceGestureRecognizer>(EagerGestureRecognizer.new));
    }
    if (_usePan) {
      set.add(Factory<OneSequenceGestureRecognizer>(PanGestureRecognizer.new));
    }
    if (_useScale) {
      set.add(Factory<OneSequenceGestureRecognizer>(ScaleGestureRecognizer.new));
    }
    return set;
  }

  Map<String, dynamic> _payload() {
    final preset = _creationPresets[_presetIndex];
    return <String, dynamic>{
      ...preset.payload,
      'revision': _createdCount + _errorCount + 1,
      'density': _density.name,
      'clip': _clipMode.name,
      'hit': _hitBehavior.name,
      'inspector': _showInspectorRail,
    };
  }

  @override
  void initState() {
    super.initState();
    _pushTrace('boot', 'AppKitView observatory initialized', _p.accentA);
  }

  void _pushTrace(String source, String note, Color tone) {
    final row = _TraceLine(at: DateTime.now(), source: source, note: note, tone: tone);
    setState(() {
      _timeline.insert(0, row);
      if (_timeline.length > 40) {
        _timeline.removeRange(40, _timeline.length);
      }
    });
    if (_verboseLog) {
      debugPrint('[AppKitView][$source] $note');
    }
  }

  void _onCreated(String lane, int id) {
    setState(() => _createdCount += 1);
    _pushTrace('view', '$lane created id=$id', _p.accentB);
  }

  void _onError(String lane, Object error) {
    setState(() => _errorCount += 1);
    _pushTrace('view', '$lane failed: $error', _p.accentC);
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
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.desktop_mac_rounded, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'AppKitView Deep Demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'macOS Platform View',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'AppKitView embeds native macOS NSView content into Flutter widgets. '
            'This observatory demonstrates lifecycle, creation parameters, '
            'hit-test policy, gesture routing, and practical multi-window compositions.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.93),
              fontSize: 12.4,
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
      color: _p.accentA.withValues(alpha: 0.07),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text('Stage', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _stageLabels.length; i++) _stageChip(i),
          const SizedBox(width: 10),
          Text('Density', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          _densityChip('Light', _Density.light),
          _densityChip('Normal', _Density.normal),
          _densityChip('Dense', _Density.dense),
          const SizedBox(width: 10),
          Text('Palette', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          for (var i = 0; i < _palettes.length; i++) _paletteDot(i),
          const SizedBox(width: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('verbose', style: TextStyle(color: _p.ink, fontSize: 12)),
              Switch(
                value: _verboseLog,
                onChanged: (value) => setState(() => _verboseLog = value),
                activeThumbColor: _p.accentB,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stageChip(int index) {
    return ChoiceChip(
      selected: _stage.index == index,
      selectedColor: _p.accentA,
      backgroundColor: Colors.white,
      label: Text('${index + 1}'),
      labelStyle: TextStyle(
        color: _stage.index == index ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11,
      ),
      onSelected: (_) => setState(() => _stage = _Stage.values[index]),
    );
  }

  Widget _densityChip(String label, _Density density) {
    return ChoiceChip(
      selected: _density == density,
      selectedColor: _p.accentB,
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

  Widget _stageBody() {
    switch (_stage) {
      case _Stage.hostDock:
        return _hostDockStudio();
      case _Stage.interactionGallery:
        return _interactionGallery();
      case _Stage.paramsWorkbench:
        return _paramsWorkbench();
      case _Stage.gestureLab:
        return _gestureRoutingLab();
      case _Stage.windowTheater:
        return _windowTheater();
      case _Stage.compendium:
        return _compendium();
    }
  }

  Widget _hostDockStudio() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Host Dock Studio'),
          const SizedBox(height: 8),
          Text(
            'This stage demonstrates foundational AppKitView embedding. '
            'Adjust host dimensions, clipping wrapper, and view policy while '
            'observing lifecycle telemetry and platform fallback behavior.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Dock Controls',
            subtitle: 'Shape the host container and display diagnostics.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'dock width',
                  value: _dockWidth,
                  min: 360,
                  max: 1100,
                  divisions: 37,
                  tone: _p.accentA,
                  onChanged: (v) => setState(() => _dockWidth = v),
                ),
                _slider(
                  label: 'dock height',
                  value: _dockHeight,
                  min: 240,
                  max: 600,
                  divisions: 36,
                  tone: _p.accentB,
                  onChanged: (v) => setState(() => _dockHeight = v),
                ),
                _slider(
                  label: 'corner radius',
                  value: _cornerRadius,
                  min: 0,
                  max: 34,
                  divisions: 34,
                  tone: _p.accentC,
                  onChanged: (v) => setState(() => _cornerRadius = v),
                ),
                _slider(
                  label: 'sim rows',
                  value: _simRowCount.toDouble(),
                  min: 8,
                  max: 40,
                  divisions: 32,
                  tone: _p.accentA,
                  onChanged: (v) => setState(() => _simRowCount = v.round()),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _checkTile('attempt live view', _attemptLiveView, (v) => _attemptLiveView = v),
                    _checkTile('grid overlay', _showGrid, (v) => _showGrid = v),
                    _checkTile('inspector rail', _showInspectorRail, (v) => _showInspectorRail = v),
                    _checkTile('telemetry chips', _showTelemetry, (v) => _showTelemetry = v),
                    _checkTile('pattern backdrop', _showBackdropPattern, (v) => _showBackdropPattern = v),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Dock Preview',
            subtitle: 'AppKit lane plus setup checklist and runtime counters.',
            tint: _p.accentA.withValues(alpha: 0.04),
            child: Center(
              child: SizedBox(
                width: _dockWidth,
                height: _dockHeight,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(_cornerRadius),
                              clipBehavior: _clipMode,
                              child: _AppKitLane(
                                key: ValueKey(
                                  'dock-$_attemptLiveView-$_hitBehavior-$_clipMode-$_recognizers().length',
                                ),
                                label: 'Host Dock Lane',
                                viewType: 'tom.demo.appkit.hostdock',
                                viewId: 6101,
                                canCreateReal: _supportsAppKit,
                                attemptReal: _attemptLiveView,
                                hitTestBehavior: _hitBehavior,
                                gestureRecognizers: _recognizers(),
                                creationParams: _payload(),
                                palette: _p,
                                itemCount: _effectiveSimRows,
                                showInspector: _showInspectorRail,
                                showTelemetry: _showTelemetry,
                                showBackdropPattern: _showBackdropPattern,
                                onTrace: _pushTrace,
                                onCreated: _onCreated,
                                onError: _onError,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: _setupChecklist()),
                        ],
                      ),
                    ),
                    if (_showGrid)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _BackdropGridPainter(
                              step: 34,
                              tone: _p.accentA.withValues(alpha: 0.12),
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

  Widget _setupChecklist() {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: _p.accentB.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.accentB.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Embedding Checklist',
            style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 13),
          ),
          const SizedBox(height: 8),
          _bullet('Register native AppKit view type on macOS host side.'),
          _bullet('Create AppKitView with matching viewType string.'),
          _bullet('Provide creationParams and StandardMessageCodec.'),
          _bullet('Choose hit-test behavior for interaction layering.'),
          _bullet('Set gesture recognizers intentionally per use case.'),
          _bullet('Observe onPlatformViewCreated callback for lifecycle trace.'),
          const SizedBox(height: 8),
          if (_showTelemetry)
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                _chip('created', '$_createdCount', _p.accentA),
                _chip('errors', '$_errorCount', _p.accentC),
                _chip('preset', _creationPresets[_presetIndex].id, _p.accentB),
              ],
            ),
          const SizedBox(height: 8),
          Text(
            _supportsAppKit
                ? 'Host platform supports AppKitView and can render live NSView content.'
                : 'Host platform is not macOS. Demo shows visual simulation with policy diagnostics.',
            style: TextStyle(color: _p.muted, fontSize: 11.1, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _interactionGallery() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Interaction Policy Gallery'),
          const SizedBox(height: 8),
          Text(
            'Compare hit-test policies and clipping wrappers. '
            'AppKitView does not expose clipBehavior directly, so wrappers define clipping edges.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Policy Controls',
            subtitle: 'Adjust active hit-test mode and clipping wrapper.',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _hitChip('Opaque', PlatformViewHitTestBehavior.opaque),
                _hitChip('Translucent', PlatformViewHitTestBehavior.translucent),
                _hitChip('Transparent', PlatformViewHitTestBehavior.transparent),
                const SizedBox(width: 14),
                _clipChip('Clip.none', Clip.none),
                _clipChip('Clip.hardEdge', Clip.hardEdge),
                _clipChip('Clip.antiAlias', Clip.antiAlias),
                _clipChip('Clip.saveLayer', Clip.antiAliasWithSaveLayer),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              _policyCard('Opaque Lane', PlatformViewHitTestBehavior.opaque, Clip.hardEdge, 6201),
              _policyCard('Translucent Lane', PlatformViewHitTestBehavior.translucent, Clip.antiAlias, 6202),
              _policyCard('Transparent Lane', PlatformViewHitTestBehavior.transparent, Clip.none, 6203),
              _policyCard('SaveLayer Wrapper Lane', PlatformViewHitTestBehavior.opaque, Clip.antiAliasWithSaveLayer, 6204),
            ],
          ),
        ],
      ),
    );
  }

  Widget _policyCard(
    String title,
    PlatformViewHitTestBehavior hit,
    Clip clip,
    int viewId,
  ) {
    return SizedBox(
      width: 510,
      child: _panel(
        title: title,
        subtitle: 'hit=$hit.name, wrapper=$clip.name',
        tint: _p.accentA.withValues(alpha: 0.04),
        child: SizedBox(
          height: 315,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            clipBehavior: clip,
            child: _AppKitLane(
              key: ValueKey('policy-$viewId-$_attemptLiveView-$_recognizers().length'),
              label: title,
              viewType: 'tom.demo.appkit.policy.$viewId',
              viewId: viewId,
              canCreateReal: _supportsAppKit,
              attemptReal: _attemptLiveView,
              hitTestBehavior: hit,
              gestureRecognizers: _recognizers(),
              creationParams: _payload(),
              palette: _p,
              itemCount: _effectiveSimRows,
              showInspector: _showInspectorRail,
              showTelemetry: _showTelemetry,
              showBackdropPattern: _showBackdropPattern,
              onTrace: _pushTrace,
              onCreated: _onCreated,
              onError: _onError,
            ),
          ),
        ),
      ),
    );
  }

  Widget _hitChip(String label, PlatformViewHitTestBehavior behavior) {
    return ChoiceChip(
      selected: _hitBehavior == behavior,
      selectedColor: _p.accentA,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _hitBehavior == behavior ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11,
      ),
      onSelected: (_) {
        setState(() => _hitBehavior = behavior);
        _pushTrace('policy', 'hitTestBehavior -> $behavior.name', _p.accentA);
      },
    );
  }

  Widget _clipChip(String label, Clip clip) {
    return ChoiceChip(
      selected: _clipMode == clip,
      selectedColor: _p.accentB,
      backgroundColor: Colors.white,
      label: Text(label),
      labelStyle: TextStyle(
        color: _clipMode == clip ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11,
      ),
      onSelected: (_) {
        setState(() => _clipMode = clip);
        _pushTrace('policy', 'wrapper clip -> $clip.name', _p.accentB);
      },
    );
  }

  Widget _paramsWorkbench() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Creation Params Workbench'),
          const SizedBox(height: 8),
          Text(
            'Creation params let Flutter pass initialization payloads to native '
            'AppKit view factories. This workbench explores presets and payload diagnostics.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Preset Picker',
            subtitle: 'Select payload profile and inspect generated map.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (var i = 0; i < _creationPresets.length; i++) _presetChip(i),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _creationPresets[_presetIndex].explanation,
                  style: TextStyle(color: _p.muted, fontSize: 11.5, height: 1.35),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _p.shell.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SelectableText(
                    _prettyPayload(_payload()),
                    style: const TextStyle(
                      color: Color(0xFFE3EAF3),
                      fontFamily: 'monospace',
                      fontSize: 11.2,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              SizedBox(
                width: 560,
                child: _panel(
                  title: 'Preset Lane',
                  subtitle: 'Runs with selected payload profile.',
                  tint: _p.accentA.withValues(alpha: 0.04),
                  child: SizedBox(
                    height: 320,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      clipBehavior: _clipMode,
                      child: _AppKitLane(
                        key: ValueKey('params-preset-$_presetIndex-$_attemptLiveView-$_recognizers().length'),
                        label: 'Preset payload lane',
                        viewType: 'tom.demo.appkit.params.preset',
                        viewId: 6301,
                        canCreateReal: _supportsAppKit,
                        attemptReal: _attemptLiveView,
                        hitTestBehavior: _hitBehavior,
                        gestureRecognizers: _recognizers(),
                        creationParams: _payload(),
                        palette: _p,
                        itemCount: _effectiveSimRows,
                        showInspector: _showInspectorRail,
                        showTelemetry: _showTelemetry,
                        showBackdropPattern: _showBackdropPattern,
                        onTrace: _pushTrace,
                        onCreated: _onCreated,
                        onError: _onError,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 460,
                child: _panel(
                  title: 'Payload Notes',
                  subtitle: 'How native side should consume params.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _bullet('Use stable keys and version payload when evolving schema.'),
                      _bullet('Decode with StandardMessageCodec-compatible types only.'),
                      _bullet('Avoid large binary payloads in creation params.'),
                      _bullet('Treat params as initialization snapshot, not live stream.'),
                      _bullet('Emit native-side logs when params mismatch expected contract.'),
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

  Widget _presetChip(int index) {
    final preset = _creationPresets[index];
    return ChoiceChip(
      selected: _presetIndex == index,
      selectedColor: _p.accentC,
      backgroundColor: Colors.white,
      label: Text(preset.title),
      labelStyle: TextStyle(
        color: _presetIndex == index ? Colors.white : _p.ink,
        fontWeight: FontWeight.w700,
        fontSize: 11.2,
      ),
      onSelected: (_) {
        setState(() => _presetIndex = index);
        _pushTrace('params', 'preset -> ${preset.id}', _p.accentC);
      },
    );
  }

  String _prettyPayload(Map<String, dynamic> payload) {
    final rows = <String>[];
    for (final entry in payload.entries) {
      rows.add('${entry.key}: ${entry.value}');
    }
    return rows.join('\n');
  }

  Widget _gestureRoutingLab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Gesture Routing Lab'),
          const SizedBox(height: 8),
          Text(
            'Gesture recognizer factories define which interactions are '
            'forwarded to native AppKit views. Toggle recognizers and compare active vs empty lanes.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Recognizer Policy',
            subtitle: 'Compose recognizer set and inspect resulting count.',
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _checkTile('Eager', _useEager, (v) => _useEager = v),
                    _checkTile('Pan', _usePan, (v) => _usePan = v),
                    _checkTile('Scale', _useScale, (v) => _useScale = v),
                  ],
                ),
                const SizedBox(height: 10),
                if (_showTelemetry)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: <Widget>[
                      _chip('recognizers', '${_recognizers().length}', _p.accentB),
                      _chip('active hit', _hitBehavior.name, _p.accentA),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              SizedBox(
                width: 510,
                child: _panel(
                  title: 'Active Recognizer Lane',
                  subtitle: 'Uses configured recognizer set.',
                  tint: _p.accentA.withValues(alpha: 0.05),
                  child: SizedBox(
                    height: 320,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      clipBehavior: _clipMode,
                      child: _AppKitLane(
                        key: ValueKey(
                          'gesture-active-$_attemptLiveView-$_useEager-$_usePan-$_useScale',
                        ),
                        label: 'Active recognizers',
                        viewType: 'tom.demo.appkit.gesture.active',
                        viewId: 6401,
                        canCreateReal: _supportsAppKit,
                        attemptReal: _attemptLiveView,
                        hitTestBehavior: _hitBehavior,
                        gestureRecognizers: _recognizers(),
                        creationParams: _payload(),
                        palette: _p,
                        itemCount: _effectiveSimRows,
                        showInspector: _showInspectorRail,
                        showTelemetry: _showTelemetry,
                        showBackdropPattern: _showBackdropPattern,
                        onTrace: _pushTrace,
                        onCreated: _onCreated,
                        onError: _onError,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 510,
                child: _panel(
                  title: 'No Recognizer Baseline',
                  subtitle: 'Empty recognizer set for interaction baseline.',
                  tint: _p.accentC.withValues(alpha: 0.07),
                  child: SizedBox(
                    height: 320,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      clipBehavior: _clipMode,
                      child: _AppKitLane(
                        key: ValueKey('gesture-empty-$_attemptLiveView-$_hitBehavior'),
                        label: 'No recognizers',
                        viewType: 'tom.demo.appkit.gesture.empty',
                        viewId: 6402,
                        canCreateReal: _supportsAppKit,
                        attemptReal: _attemptLiveView,
                        hitTestBehavior: _hitBehavior,
                        gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                        creationParams: _payload(),
                        palette: _p,
                        itemCount: _effectiveSimRows,
                        showInspector: _showInspectorRail,
                        showTelemetry: _showTelemetry,
                        showBackdropPattern: _showBackdropPattern,
                        onTrace: _pushTrace,
                        onCreated: _onCreated,
                        onError: _onError,
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

  Widget _windowTheater() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Window Theater'),
          const SizedBox(height: 8),
          Text(
            'Practical AppKit integration often appears in multi-window macOS workflows. '
            'Theater cards model utility, editor, and dashboard compositions.',
            style: TextStyle(color: _p.ink, fontSize: 12.4, height: 1.34),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Theater Controls',
            subtitle: 'Tune custom window profile and inspect event timeline.',
            child: Column(
              children: <Widget>[
                _slider(
                  label: 'custom width',
                  value: _customWindowWidth,
                  min: 340,
                  max: 1120,
                  divisions: 39,
                  tone: _p.accentA,
                  onChanged: (v) => setState(() => _customWindowWidth = v),
                ),
                _slider(
                  label: 'custom height',
                  value: _customWindowHeight,
                  min: 250,
                  max: 560,
                  divisions: 31,
                  tone: _p.accentB,
                  onChanged: (v) => setState(() => _customWindowHeight = v),
                ),
                _slider(
                  label: 'timeline height',
                  value: _timelineHeight,
                  min: 180,
                  max: 430,
                  divisions: 25,
                  tone: _p.accentC,
                  onChanged: (v) => setState(() => _timelineHeight = v),
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    TextButton.icon(
                      onPressed: () => setState(_timeline.clear),
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Clear timeline'),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () => _pushTrace('marker', 'Manual timeline marker', _p.accentC),
                      icon: const Icon(Icons.bookmark_add_outlined),
                      label: const Text('Add marker'),
                    ),
                    const Spacer(),
                    if (_showTelemetry) _chip('rows', '${_timeline.length}', _p.accentB),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Event Timeline',
            subtitle: 'Lifecycle and policy events from all lanes.',
            tint: _p.accentA.withValues(alpha: 0.04),
            child: SizedBox(
              height: _timelineHeight,
              child: _timeline.isEmpty
                  ? Center(
                      child: Text(
                        'No timeline events yet. Interact with controls and lanes.',
                        style: TextStyle(color: _p.muted, fontSize: 11.8),
                      ),
                    )
                    : ListView.separated(
                      itemCount: _timeline.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final row = _timeline[index];
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: row.tone.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: row.tone.withValues(alpha: 0.35)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _chip('src', row.source, row.tone),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  row.note,
                                  style: TextStyle(color: _p.ink, fontSize: 11.3, height: 1.34),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _clock(row.at),
                                style: TextStyle(
                                  color: _p.muted,
                                  fontFamily: 'monospace',
                                  fontSize: 10.1,
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
            children: <Widget>[
              for (var i = 0; i < _windowProfiles.length; i++) _windowCard(_windowProfiles[i], 6500 + i),
              _windowCard(
                _WindowProfile(
                  name: 'Custom Profile',
                  width: _customWindowWidth,
                  height: _customWindowHeight,
                  intent: 'User-defined profile for exploratory integration checks.',
                ),
                6601,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _windowCard(_WindowProfile profile, int viewId) {
    final cardWidth = profile.width > 650 ? 550.0 : 430.0;
    return SizedBox(
      width: cardWidth,
      child: _panel(
        title: profile.name,
        subtitle: profile.intent,
        tint: _p.accentA.withValues(alpha: 0.04),
        child: SizedBox(
          width: profile.width,
          height: profile.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            clipBehavior: _clipMode,
            child: _AppKitLane(
              key: ValueKey(
                'window-$viewId-$_attemptLiveView-$_hitBehavior-$_recognizers().length-$_presetIndex',
              ),
              label: profile.name,
              viewType: 'tom.demo.appkit.window.$viewId',
              viewId: viewId,
              canCreateReal: _supportsAppKit,
              attemptReal: _attemptLiveView,
              hitTestBehavior: _hitBehavior,
              gestureRecognizers: _recognizers(),
              creationParams: _payload(),
              palette: _p,
              itemCount: _effectiveSimRows,
              showInspector: _showInspectorRail,
              showTelemetry: _showTelemetry,
              showBackdropPattern: _showBackdropPattern,
              onTrace: _pushTrace,
              onCreated: _onCreated,
              onError: _onError,
            ),
          ),
        ),
      ),
    );
  }

  Widget _compendium() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title('Verification Compendium'),
          const SizedBox(height: 12),
          _panel(
            title: 'AppKitView Matrix',
            subtitle: 'What it is, why it exists, and how to integrate it.',
            child: Column(
              children: <Widget>[
                _matrix('Widget role', 'Embed native AppKit NSView into Flutter on macOS.'),
                _matrix('Platform', 'macOS only for live rendering; fallback recommended elsewhere.'),
                _matrix('viewType', 'String key matching native AppKit factory registration.'),
                _matrix('creationParams', 'Initialization payload decoded by native factory.'),
                _matrix('creationParamsCodec', 'Codec for payload, usually StandardMessageCodec.'),
                _matrix('hitTestBehavior', 'Pointer event routing between Flutter and native view.'),
                _matrix('gestureRecognizers', 'Explicit set of recognizers forwarded to platform view.'),
                _matrix('onPlatformViewCreated', 'Lifecycle callback to capture view ID and trace state.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Do and Dont',
            subtitle: 'Practical integration advice.',
            child: Column(
              children: <Widget>[
                _doDont(
                  good: true,
                  title: 'Do keep viewType stable',
                  detail: 'Changing viewType without host updates breaks native factory resolution.',
                ),
                _doDont(
                  good: true,
                  title: 'Do version creation payload',
                  detail: 'Evolving payload contracts safely avoids decode mismatch and runtime surprises.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont assume live rendering off macOS',
                  detail: 'Use robust fallback cards for Linux, Windows, and web execution paths.',
                ),
                _doDont(
                  good: false,
                  title: 'Dont over-forward gestures blindly',
                  detail: 'Recognizer policy should align with native view interaction goals.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'FAQ',
            subtitle: 'Common AppKitView implementation questions.',
            child: Column(
              children: <Widget>[
                _qa(
                  q: 'How is AppKitView different from AndroidView or UiKitView?',
                  a: 'It targets macOS NSView embedding while AndroidView and UiKitView target Android and iOS.',
                ),
                _qa(
                  q: 'Can I pass complex startup configuration?',
                  a: 'Yes, as long as values are StandardMessageCodec-compatible scalar/map/list types.',
                ),
                _qa(
                  q: 'What should I do on unsupported platforms?',
                  a: 'Show a visual simulation lane with clear diagnostics and preserve control behavior.',
                ),
                _qa(
                  q: 'When should hitTestBehavior be transparent?',
                  a: 'When overlay Flutter widgets should capture interactions while native view remains visible.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _panel(
            title: 'Coverage Checklist',
            subtitle: 'Deep demo completion criteria for this file.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _check('Host Dock Studio with lifecycle and setup checklist.'),
                _check('Interaction gallery comparing hit-test and clip wrappers.'),
                _check('Creation params workbench with payload presets and inspector text.'),
                _check('Gesture routing lab comparing active and empty recognizer sets.'),
                _check('Window theater with multiple profile lanes and event timeline.'),
                _check('Compendium matrix, FAQ, do/dont, and integration checklist.'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _notice(
            'AppKitView is the macOS bridge for native NSView surfaces in Flutter. '
            'This deep demo prioritizes visual comparisons, policy controls, and '
            'runtime observability to validate interpreter integration paths.',
          ),
        ],
      ),
    );
  }

  Widget _checkTile(String label, bool value, void Function(bool value) assign) {
    return FilterChip(
      selected: value,
      onSelected: (selected) {
        setState(() => assign(selected));
      },
      label: Text(label),
      selectedColor: _p.accentA.withValues(alpha: 0.18),
      backgroundColor: Colors.white,
      checkmarkColor: _p.accentA,
      labelStyle: TextStyle(
        color: _p.ink,
        fontWeight: FontWeight.w600,
        fontSize: 11,
      ),
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
          width: 190,
          child: Text(
            '$label: ${value.toStringAsFixed(0)}',
            style: TextStyle(color: _p.ink, fontSize: 12),
          ),
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

  Widget _chip(String label, String value, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tone.withValues(alpha: 0.34)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(
          color: _p.ink,
          fontFamily: 'monospace',
          fontSize: 10.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Row(
      children: <Widget>[
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: _p.accentA,
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

  Widget _panel({
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
        border: Border.all(color: _p.muted.withValues(alpha: 0.24)),
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
          Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w800, fontSize: 14)),
          const SizedBox(height: 3),
          Text(subtitle, style: TextStyle(color: _p.muted, fontSize: 11.4)),
          const SizedBox(height: 10),
          child,
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
            width: 180,
            child: Text(
              key,
              style: TextStyle(
                color: _p.accentA,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 11.1,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: _p.ink, fontSize: 11.4, height: 1.35),
            ),
          ),
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
          Icon(good ? Icons.check_circle : Icons.cancel, color: tone, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 4),
                Text(detail, style: TextStyle(color: _p.muted, fontSize: 11.3, height: 1.34)),
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
          Text('Q: $q', style: TextStyle(color: _p.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 4),
          Text('A: $a', style: TextStyle(color: _p.muted, fontSize: 11.4, height: 1.34)),
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
          const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: _p.accentA),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(color: _p.ink, fontSize: 11.9, height: 1.32)),
          ),
        ],
      ),
    );
  }

  Widget _notice(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _p.accentC.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _p.accentC.withValues(alpha: 0.32)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.info_outline, color: _p.accentC, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: _p.ink, fontSize: 12, height: 1.35))),
        ],
      ),
    );
  }

  String _clock(DateTime value) {
    final h = value.hour.toString().padLeft(2, '0');
    final m = value.minute.toString().padLeft(2, '0');
    final s = value.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      color: _p.shell.withValues(alpha: 0.06),
      child: Row(
        children: <Widget>[
          Text(
            _stageLabels[_stage.index],
            style: TextStyle(color: _p.muted, fontSize: 11, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          Text('Palette: ${_p.name}', style: TextStyle(color: _p.muted, fontSize: 11)),
        ],
      ),
    );
  }
}

class _AppKitLane extends StatefulWidget {
  const _AppKitLane({
    super.key,
    required this.label,
    required this.viewType,
    required this.viewId,
    required this.canCreateReal,
    required this.attemptReal,
    required this.hitTestBehavior,
    required this.gestureRecognizers,
    required this.creationParams,
    required this.palette,
    required this.itemCount,
    required this.showInspector,
    required this.showTelemetry,
    required this.showBackdropPattern,
    required this.onTrace,
    required this.onCreated,
    required this.onError,
  });

  final String label;
  final String viewType;
  final int viewId;
  final bool canCreateReal;
  final bool attemptReal;
  final PlatformViewHitTestBehavior hitTestBehavior;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final Map<String, dynamic> creationParams;
  final _DemoPalette palette;
  final int itemCount;
  final bool showInspector;
  final bool showTelemetry;
  final bool showBackdropPattern;
  final void Function(String source, String note, Color tone) onTrace;
  final void Function(String lane, int id) onCreated;
  final void Function(String lane, Object error) onError;

  @override
  State<_AppKitLane> createState() => _AppKitLaneState();
}

class _AppKitLaneState extends State<_AppKitLane> {
  String _status = 'boot';
  int? _createdId;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _boot();
  }

  void _boot() {
    if (!widget.attemptReal) {
      setState(() => _status = 'simulated');
      widget.onTrace('lane', '${widget.label}: simulation forced by policy', widget.palette.accentC);
      return;
    }
    if (!widget.canCreateReal) {
      setState(() => _status = 'unsupported');
      widget.onTrace('lane', '${widget.label}: host does not support AppKitView', widget.palette.accentC);
      return;
    }
    setState(() => _status = 'live');
    widget.onTrace('lane', '${widget.label}: preparing live AppKitView', widget.palette.accentA);
  }

  void _onPlatformViewCreated(int id) {
    setState(() {
      _status = 'created';
      _createdId = id;
    });
    widget.onCreated(widget.label, id);
  }

  @override
  Widget build(BuildContext context) {
    if (_status == 'simulated') {
      return _simulatedSurface('Live view disabled for controlled comparison.');
    }
    if (_status == 'unsupported') {
      return _simulatedSurface('Live AppKitView unavailable on this host platform.');
    }
    if (_status == 'error') {
      return _simulatedSurface('Lane failed to initialize: $_error');
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: widget.palette.muted.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          _windowChrome(),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: _liveSurface()),
                if (widget.showInspector) _inspectorRail(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _windowChrome() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: widget.palette.shell.withValues(alpha: 0.07),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
      ),
      child: Row(
        children: <Widget>[
          _trafficDot(const Color(0xFFFF5F57)),
          const SizedBox(width: 4),
          _trafficDot(const Color(0xFFFEBC2E)),
          const SizedBox(width: 4),
          _trafficDot(const Color(0xFF28C840)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.label,
              style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 11.8),
            ),
          ),
          if (widget.showTelemetry)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: widget.palette.accentA.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'hit: ${widget.hitTestBehavior.name}',
                style: TextStyle(
                  color: widget.palette.ink,
                  fontSize: 10.1,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _trafficDot(Color tone) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(shape: BoxShape.circle, color: tone),
    );
  }

  Widget _liveSurface() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: AppKitView(
            viewType: widget.viewType,
            hitTestBehavior: widget.hitTestBehavior,
            creationParams: widget.creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            gestureRecognizers: widget.gestureRecognizers,
            onPlatformViewCreated: _onPlatformViewCreated,
          ),
        ),
        if (widget.showBackdropPattern)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _DiagonalPatternPainter(
                  tone: widget.palette.accentA.withValues(alpha: 0.08),
                  step: 26,
                ),
              ),
            ),
          ),
        Positioned(
          left: 8,
          right: 8,
          bottom: 8,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: widget.palette.muted.withValues(alpha: 0.25)),
            ),
            child: Text(
              _createdId != null
                  ? 'Live AppKitView running with id=$_createdId.'
                  : 'Awaiting platform view creation callback.',
              style: TextStyle(color: widget.palette.ink, fontSize: 10.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _inspectorRail() {
    return Container(
      width: 168,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.palette.accentB.withValues(alpha: 0.09),
        border: Border(left: BorderSide(color: widget.palette.accentB.withValues(alpha: 0.25))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Inspector', style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 12)),
          const SizedBox(height: 8),
          _railLine('viewType', widget.viewType),
          _railLine('viewId', '${widget.viewId}'),
          _railLine('hit', widget.hitTestBehavior.name),
          _railLine('gestures', '${widget.gestureRecognizers.length}'),
          _railLine('status', _status),
          const SizedBox(height: 8),
          Text(
            'creation params',
            style: TextStyle(color: widget.palette.muted, fontSize: 10.2, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView(
              children: widget.creationParams.entries
                  .map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        '${entry.key}: ${entry.value}',
                        style: TextStyle(
                          color: widget.palette.ink,
                          fontSize: 10,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _railLine(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 58,
            child: Text(
              key,
              style: TextStyle(
                color: widget.palette.muted,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: widget.palette.ink, fontSize: 10.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _simulatedSurface(String reason) {
    return Container(
      decoration: BoxDecoration(
        color: widget.palette.accentA.withValues(alpha: 0.08),
        border: Border.all(color: widget.palette.accentA.withValues(alpha: 0.28)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.precision_manufacturing_outlined, color: widget.palette.accentA, size: 18),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    'Simulation Surface',
                    style: TextStyle(color: widget.palette.ink, fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(reason, style: TextStyle(color: widget.palette.muted, fontSize: 11.2)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.itemCount,
                itemBuilder: (context, index) {
                  final tone = index.isEven ? widget.palette.accentA : widget.palette.accentB;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: tone.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.window_outlined, color: tone, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Simulated AppKit panel ${index + 1}',
                            style: TextStyle(
                              color: widget.palette.ink,
                              fontWeight: FontWeight.w700,
                              fontSize: 11.1,
                            ),
                          ),
                        ),
                        Text(
                          'row ${index + 1}',
                          style: TextStyle(
                            color: widget.palette.muted,
                            fontSize: 10,
                            fontFamily: 'monospace',
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
}

class _BackdropGridPainter extends CustomPainter {
  final double step;
  final Color tone;

  const _BackdropGridPainter({required this.step, required this.tone});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = tone
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    var x = 0.0;
    while (x <= size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += step;
    }
    var y = 0.0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += step;
    }
  }

  @override
  bool shouldRepaint(covariant _BackdropGridPainter oldDelegate) {
    return oldDelegate.step != step || oldDelegate.tone != tone;
  }
}

class _DiagonalPatternPainter extends CustomPainter {
  final Color tone;
  final double step;

  const _DiagonalPatternPainter({required this.tone, required this.step});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = tone
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke;

    var start = -size.height;
    while (start < size.width) {
      canvas.drawLine(
        Offset(start, 0),
        Offset(start + size.height, size.height),
        paint,
      );
      start += step;
    }
  }

  @override
  bool shouldRepaint(covariant _DiagonalPatternPainter oldDelegate) {
    return oldDelegate.tone != tone || oldDelegate.step != step;
  }
}
