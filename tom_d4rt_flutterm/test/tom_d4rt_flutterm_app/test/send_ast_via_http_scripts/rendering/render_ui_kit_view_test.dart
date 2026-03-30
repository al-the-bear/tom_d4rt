import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show PlatformViewHitTestBehavior;

// -----------------------------------------------------------------------------
// RenderUiKitView Deep Demo
//
// RenderUiKitView is the RenderBox used by UiKitView (iOS platform view host).
// We exercise the widget-level entry points that instantiate and configure the
// underlying render object:
// - UiKitView(viewType, hitTestBehavior, gestureRecognizers, ...)
//
// Because this workspace is not guaranteed to run on iOS with a registered
// native platform-view type, each scene offers a visual simulator path while
// still using real UiKitView wiring in a guarded branch.
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const _RenderUiKitViewDeepDemo();
}

enum _Scene {
  primer,
  hitTest,
  gestures,
  composition,
  practical,
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
    name: 'Marina Signal',
    shell: Color(0xFF0F2435),
    paper: Color(0xFFF2F8FC),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF21394A),
    muted: Color(0xFF6D879A),
    primary: Color(0xFF1C86D5),
    secondary: Color(0xFF1E9A79),
    tertiary: Color(0xFFD08B2D),
  ),
  _Skin(
    name: 'Olive Instrument',
    shell: Color(0xFF17251E),
    paper: Color(0xFFF2F9F3),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF2B3E33),
    muted: Color(0xFF708B79),
    primary: Color(0xFF2E8F4A),
    secondary: Color(0xFF2C7FC1),
    tertiary: Color(0xFFB8902E),
  ),
  _Skin(
    name: 'Copper Console',
    shell: Color(0xFF2A1F1A),
    paper: Color(0xFFFCF3EA),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF43352E),
    muted: Color(0xFF8C7A6D),
    primary: Color(0xFFC66D37),
    secondary: Color(0xFF2E88A9),
    tertiary: Color(0xFFA18920),
  ),
];

class _DemoEvent {
  const _DemoEvent({required this.time, required this.label});

  final String time;
  final String label;
}

class _RenderUiKitViewDeepDemo extends StatefulWidget {
  const _RenderUiKitViewDeepDemo();

  @override
  State<_RenderUiKitViewDeepDemo> createState() =>
      _RenderUiKitViewDeepDemoState();
}

class _RenderUiKitViewDeepDemoState extends State<_RenderUiKitViewDeepDemo> {
  _Scene _scene = _Scene.primer;
  int _skinIndex = 0;
  final List<_DemoEvent> _timeline = <_DemoEvent>[];

  _Skin get _skin => _skins[_skinIndex % _skins.length];

  void _log(String label) {
    final now = DateTime.now();
    final stamp =
        '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
    setState(() {
      _timeline.insert(0, _DemoEvent(time: stamp, label: label));
      if (_timeline.length > 140) {
        _timeline.removeLast();
      }
    });
  }

  String _sceneTitle(_Scene scene) {
    switch (scene) {
      case _Scene.primer:
        return 'Primer';
      case _Scene.hitTest:
        return 'Hit Test';
      case _Scene.gestures:
        return 'Gestures';
      case _Scene.composition:
        return 'Composition';
      case _Scene.practical:
        return 'Practical';
      case _Scene.compendium:
        return 'Compendium';
    }
  }

  IconData _sceneIcon(_Scene scene) {
    switch (scene) {
      case _Scene.primer:
        return Icons.menu_book_outlined;
      case _Scene.hitTest:
        return Icons.touch_app_outlined;
      case _Scene.gestures:
        return Icons.gesture_outlined;
      case _Scene.composition:
        return Icons.layers_outlined;
      case _Scene.practical:
        return Icons.widgets_outlined;
      case _Scene.compendium:
        return Icons.verified_outlined;
    }
  }

  Widget _buildScene() {
    switch (_scene) {
      case _Scene.primer:
        return _PrimerScene(skin: _skin, onLog: _log);
      case _Scene.hitTest:
        return _HitTestScene(skin: _skin, onLog: _log);
      case _Scene.gestures:
        return _GestureScene(skin: _skin, onLog: _log);
      case _Scene.composition:
        return _CompositionScene(skin: _skin, onLog: _log);
      case _Scene.practical:
        return _PracticalScene(skin: _skin, onLog: _log);
      case _Scene.compendium:
        return _CompendiumScene(skin: _skin, timeline: _timeline);
    }
  }

  @override
  void initState() {
    super.initState();
    _log('RenderUiKitView demo initialized');
  }

  @override
  Widget build(BuildContext context) {
    final skin = _skin;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: skin.paper,
        appBar: AppBar(
          backgroundColor: skin.shell,
          foregroundColor: skin.paper,
          title: Text(
            'RenderUiKitView - ${_sceneTitle(_scene)}',
            style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              tooltip: 'Cycle skin',
              onPressed: () {
                setState(() => _skinIndex = (_skinIndex + 1) % _skins.length);
                _log('Skin -> ${_skins[_skinIndex].name}');
              },
              icon: const Icon(Icons.palette_outlined),
            ),
          ],
        ),
        body: _buildScene(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: skin.panel,
          selectedItemColor: skin.primary,
          unselectedItemColor: skin.muted,
          selectedFontSize: 11,
          unselectedFontSize: 10,
          currentIndex: _scene.index,
          onTap: (index) {
            final next = _Scene.values[index];
            setState(() => _scene = next);
            _log('Scene -> ${_sceneTitle(next)}');
          },
          items: _Scene.values
              .map(
                (scene) => BottomNavigationBarItem(
                  icon: Icon(_sceneIcon(scene)),
                  label: _sceneTitle(scene),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Scene 1: Primer
// -----------------------------------------------------------------------------

class _PrimerScene extends StatefulWidget {
  const _PrimerScene({required this.skin, required this.onLog});

  final _Skin skin;
  final void Function(String) onLog;

  @override
  State<_PrimerScene> createState() => _PrimerSceneState();
}

class _PrimerSceneState extends State<_PrimerScene> {
  bool _attemptNative = false;
  int _viewTypeIndex = 0;
  PlatformViewHitTestBehavior _behavior = PlatformViewHitTestBehavior.opaque;

  static const _viewTypes = <String>[
    'demo.map.surface',
    'demo.media.surface',
    'demo.payments.surface',
    'demo.camera.surface',
  ];

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    final viewType = _viewTypes[_viewTypeIndex];

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _InfoPanel(
          skin: skin,
          title: 'Primer Stage',
          subtitle:
              'RenderUiKitView powers iOS platform-view embedding under UiKitView. This stage maps widget inputs to render behavior.',
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Configuration',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _SwitchLine(
                      skin: skin,
                      label: 'Attempt native UiKitView on iOS',
                      value: _attemptNative,
                      onChanged: (value) {
                        setState(() => _attemptNative = value);
                        widget.onLog('Primer attemptNative -> $value');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 76,
                    child: Text(
                      'viewType',
                      style: TextStyle(fontSize: 11.5, color: skin.muted),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: skin.muted.withAlpha(80)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<int>(
                        value: _viewTypeIndex,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        items: List.generate(
                          _viewTypes.length,
                          (index) => DropdownMenuItem<int>(
                            value: index,
                            child: Text(_viewTypes[index], style: const TextStyle(fontSize: 12)),
                          ),
                        ),
                        onChanged: (index) {
                          if (index == null) return;
                          setState(() => _viewTypeIndex = index);
                          widget.onLog('Primer viewType -> ${_viewTypes[index]}');
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 76,
                    child: Text(
                      'hit test',
                      style: TextStyle(fontSize: 11.5, color: skin.muted),
                    ),
                  ),
                  Expanded(
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: PlatformViewHitTestBehavior.values.map((behavior) {
                        final selected = behavior == _behavior;
                        return GestureDetector(
                          onTap: () {
                            setState(() => _behavior = behavior);
                            widget.onLog('Primer behavior -> ${behavior.name}');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: selected ? skin.primary.withAlpha(28) : skin.panel,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: selected ? skin.primary : skin.muted.withAlpha(42),
                              ),
                            ),
                            child: Text(
                              behavior.name,
                              style: TextStyle(
                                fontSize: 11,
                                color: selected ? skin.primary : skin.ink,
                                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Visual Pair: Flutter Layer vs UiKitView Host',
          child: Row(
            children: [
              Expanded(
                child: _LabelledBox(
                  skin: skin,
                  label: 'Pure Flutter panel',
                  child: _FlutterOnlySurface(skin: skin),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _LabelledBox(
                  skin: skin,
                  label: 'UiKitView host panel',
                  child: _UiKitSurface(
                    skin: skin,
                    viewType: viewType,
                    hitBehavior: _behavior,
                    attemptNativeOnIOS: _attemptNative,
                    gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                    onPlatformCreated: (id) => widget.onLog('UiKitView created id=$id'),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Render Chain Mapping',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ChainRow(skin: skin, index: 1, label: 'UiKitView widget config'),
              _ChainRow(skin: skin, index: 2, label: 'RenderObjectWidget creates RenderUiKitView'),
              _ChainRow(skin: skin, index: 3, label: 'RenderUiKitView attaches platform view controller'),
              _ChainRow(skin: skin, index: 4, label: 'Compositor hosts native UIKit layer'),
              _ChainRow(skin: skin, index: 5, label: 'hitTestBehavior + gestureRecognizers guide routing'),
              const SizedBox(height: 8),
              _CodeBlock(
                skin: skin,
                code:
                    'UiKitView(\n'
                    '  viewType: "$viewType",\n'
                    '  hitTestBehavior: PlatformViewHitTestBehavior.${_behavior.name},\n'
                    '  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{},\n'
                    '  onPlatformViewCreated: (id) { /* hook lifecycle */ },\n'
                    ')',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Scene 2: Hit Test Lab
// -----------------------------------------------------------------------------

class _HitTestScene extends StatefulWidget {
  const _HitTestScene({required this.skin, required this.onLog});

  final _Skin skin;
  final void Function(String) onLog;

  @override
  State<_HitTestScene> createState() => _HitTestSceneState();
}

class _HitTestSceneState extends State<_HitTestScene> {
  PlatformViewHitTestBehavior _behavior = PlatformViewHitTestBehavior.opaque;
  int _flutterLayerHits = 0;
  int _platformHits = 0;
  int _outsideHits = 0;

  void _tapPlatform() {
    setState(() {
      switch (_behavior) {
        case PlatformViewHitTestBehavior.opaque:
          _platformHits++;
          break;
        case PlatformViewHitTestBehavior.translucent:
          _platformHits++;
          _flutterLayerHits++;
          break;
        case PlatformViewHitTestBehavior.transparent:
          _flutterLayerHits++;
          break;
      }
    });
    widget.onLog('Hit test platform tap -> ${_behavior.name}');
  }

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _InfoPanel(
          skin: skin,
          title: 'Hit-Test Lab',
          subtitle:
              'Switch behavior and tap in/around the platform host to see intended routing semantics between Flutter and native layers.',
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Behavior Selector',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: PlatformViewHitTestBehavior.values.map((behavior) {
              final selected = behavior == _behavior;
              return GestureDetector(
                onTap: () {
                  setState(() => _behavior = behavior);
                  widget.onLog('Hit test behavior -> ${behavior.name}');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: selected ? skin.secondary.withAlpha(28) : skin.panel,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: selected ? skin.secondary : skin.muted.withAlpha(42),
                    ),
                  ),
                  child: Text(
                    behavior.name,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: selected ? skin.secondary : skin.ink,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Interactive Routing Surface',
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() => _outsideHits++);
                  widget.onLog('Hit test outside tap');
                },
                child: Container(
                  height: 290,
                  decoration: BoxDecoration(
                    color: skin.paper,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: skin.muted.withAlpha(45)),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: _DottedPainterBackdrop(
                          color: skin.muted.withAlpha(30),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        top: 12,
                        child: _HintBubble(
                          skin: skin,
                          text: 'Tap gray area: outside hit',
                        ),
                      ),
                      Positioned(
                        right: 14,
                        top: 12,
                        child: _HintBubble(
                          skin: skin,
                          text: 'Tap center host: platform-zone hit',
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: _tapPlatform,
                          child: SizedBox(
                            width: 250,
                            height: 160,
                            child: _UiKitSurface(
                              skin: skin,
                              viewType: 'lab.hit-test.surface',
                              hitBehavior: _behavior,
                              attemptNativeOnIOS: false,
                              gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                              onPlatformCreated: (_) {},
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        bottom: 12,
                        child: _CounterBadge(
                          skin: skin,
                          label: 'Flutter layer hits',
                          value: _flutterLayerHits,
                          accent: skin.primary,
                        ),
                      ),
                      Positioned(
                        right: 14,
                        bottom: 12,
                        child: _CounterBadge(
                          skin: skin,
                          label: 'Platform hits',
                          value: _platformHits,
                          accent: skin.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _CounterBadge(
                      skin: skin,
                      label: 'Outside hits',
                      value: _outsideHits,
                      accent: skin.tertiary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _flutterLayerHits = 0;
                          _platformHits = 0;
                          _outsideHits = 0;
                        });
                        widget.onLog('Hit test counters reset');
                      },
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('Reset counters'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _ChecklistPanel(
          skin: skin,
          title: 'Expected Semantics',
          points: const [
            'opaque: platform host absorbs touch, Flutter behind does not receive it.',
            'translucent: platform host and Flutter can both participate.',
            'transparent: host passes interactions through to Flutter.',
            'Use behavior according to desired gesture sharing model.',
          ],
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Scene 3: Gesture Arena
// -----------------------------------------------------------------------------

class _GestureScene extends StatefulWidget {
  const _GestureScene({required this.skin, required this.onLog});

  final _Skin skin;
  final void Function(String) onLog;

  @override
  State<_GestureScene> createState() => _GestureSceneState();
}

class _GestureSceneState extends State<_GestureScene> {
  bool _eager = true;
  bool _tap = true;
  bool _verticalDrag = true;
  bool _horizontalDrag = false;
  bool _longPress = false;

  final List<String> _gestureFeed = <String>[];

  Set<Factory<OneSequenceGestureRecognizer>> _activeRecognizers() {
    final set = <Factory<OneSequenceGestureRecognizer>>{};
    if (_eager) {
      set.add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()));
    }
    if (_tap) {
      set.add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()));
    }
    if (_verticalDrag) {
      set.add(
        Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer()),
      );
    }
    if (_horizontalDrag) {
      set.add(
        Factory<HorizontalDragGestureRecognizer>(() => HorizontalDragGestureRecognizer()),
      );
    }
    if (_longPress) {
      set.add(Factory<LongPressGestureRecognizer>(() => LongPressGestureRecognizer()));
    }
    return set;
  }

  void _pushFeed(String message) {
    setState(() {
      _gestureFeed.insert(0, message);
      if (_gestureFeed.length > 40) {
        _gestureFeed.removeLast();
      }
    });
    widget.onLog('Gesture feed -> $message');
  }

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    final recognizers = _activeRecognizers();
    final recognizerNames = <String>[
      if (_eager) 'EagerGestureRecognizer',
      if (_tap) 'TapGestureRecognizer',
      if (_verticalDrag) 'VerticalDragGestureRecognizer',
      if (_horizontalDrag) 'HorizontalDragGestureRecognizer',
      if (_longPress) 'LongPressGestureRecognizer',
    ];

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _InfoPanel(
          skin: skin,
          title: 'Gesture Arena Studio',
          subtitle:
              'Toggle recognizers to emulate different ownership strategies for platform views in the Flutter gesture arena.',
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Recognizer Set',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ToggleChip(
                skin: skin,
                label: 'Eager',
                value: _eager,
                onChanged: (value) {
                  setState(() => _eager = value);
                  widget.onLog('Gesture eager -> $value');
                },
              ),
              _ToggleChip(
                skin: skin,
                label: 'Tap',
                value: _tap,
                onChanged: (value) {
                  setState(() => _tap = value);
                  widget.onLog('Gesture tap -> $value');
                },
              ),
              _ToggleChip(
                skin: skin,
                label: 'Vertical Drag',
                value: _verticalDrag,
                onChanged: (value) {
                  setState(() => _verticalDrag = value);
                  widget.onLog('Gesture vertical -> $value');
                },
              ),
              _ToggleChip(
                skin: skin,
                label: 'Horizontal Drag',
                value: _horizontalDrag,
                onChanged: (value) {
                  setState(() => _horizontalDrag = value);
                  widget.onLog('Gesture horizontal -> $value');
                },
              ),
              _ToggleChip(
                skin: skin,
                label: 'Long Press',
                value: _longPress,
                onChanged: (value) {
                  setState(() => _longPress = value);
                  widget.onLog('Gesture longPress -> $value');
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Interactive Gesture Pad',
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _pushFeed('tap'),
                onLongPress: () => _pushFeed('longPress'),
                onVerticalDragUpdate: (details) => _pushFeed('vDrag ${details.delta.dy.toStringAsFixed(1)}'),
                onHorizontalDragUpdate: (details) => _pushFeed('hDrag ${details.delta.dx.toStringAsFixed(1)}'),
                child: SizedBox(
                  height: 220,
                  child: _UiKitSurface(
                    skin: skin,
                    viewType: 'lab.gesture.surface',
                    hitBehavior: PlatformViewHitTestBehavior.opaque,
                    attemptNativeOnIOS: false,
                    gestureRecognizers: recognizers,
                    onPlatformCreated: (_) {},
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: skin.paper,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: skin.muted.withAlpha(35)),
                ),
                child: Text(
                  recognizerNames.isEmpty
                      ? 'No recognizers selected. Platform view will not actively claim gestures in this simulation.'
                      : 'Active recognizers: ${recognizerNames.join(', ')}',
                  style: TextStyle(fontSize: 11.8, color: skin.ink),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Gesture Feed',
          child: _gestureFeed.isEmpty
              ? Text('Perform gestures on the pad above.', style: TextStyle(fontSize: 11.8, color: skin.muted))
              : Column(
                  children: _gestureFeed
                      .take(18)
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Icon(Icons.chevron_right, size: 14, color: skin.primary),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(entry, style: TextStyle(fontSize: 11.8, color: skin.ink)),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        _CodeBlock(
          skin: skin,
          code:
              'UiKitView(\n'
              '  viewType: "lab.gesture.surface",\n'
              '  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{\n'
              '${recognizerNames.map((name) => '    Factory<$name>(() => $name()),').join('\n')}\n'
              '  },\n'
              ')',
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Scene 4: Composition Theater
// -----------------------------------------------------------------------------

class _CompositionScene extends StatefulWidget {
  const _CompositionScene({required this.skin, required this.onLog});

  final _Skin skin;
  final void Function(String) onLog;

  @override
  State<_CompositionScene> createState() => _CompositionSceneState();
}

class _CompositionSceneState extends State<_CompositionScene> {
  double _rotation = 0;
  double _overlayOpacity = 0.32;
  bool _roundedClip = true;

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _InfoPanel(
          skin: skin,
          title: 'Composition Theater',
          subtitle:
              'Experiment with transforms, clipping, overlays, and list embedding around a UiKitView host region.',
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Stage Controls',
          child: Column(
            children: [
              _SliderLine(
                skin: skin,
                label: 'rotation',
                value: _rotation,
                min: -0.14,
                max: 0.14,
                onChanged: (value) {
                  setState(() => _rotation = value);
                },
              ),
              _SliderLine(
                skin: skin,
                label: 'overlay alpha',
                value: _overlayOpacity,
                min: 0,
                max: 0.7,
                onChanged: (value) {
                  setState(() => _overlayOpacity = value);
                },
              ),
              _SwitchLine(
                skin: skin,
                label: 'rounded clipping',
                value: _roundedClip,
                onChanged: (value) => setState(() => _roundedClip = value),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'A) Card Overlay Composition',
          child: SizedBox(
            height: 250,
            child: Transform.rotate(
              angle: _rotation,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_roundedClip ? 14 : 0),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _UiKitSurface(
                        skin: skin,
                        viewType: 'compose.card.preview',
                        hitBehavior: PlatformViewHitTestBehavior.opaque,
                        attemptNativeOnIOS: false,
                        gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                        onPlatformCreated: (_) {},
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withAlpha((_overlayOpacity * 255).round()),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Native feed card',
                              style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ),
                          FilledButton.tonal(
                            onPressed: () => widget.onLog('Composition CTA tapped'),
                            child: const Text('Inspect'),
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
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'B) Side-by-Side Host Variants',
          child: Row(
            children: [
              Expanded(
                child: _LabelledBox(
                  skin: skin,
                  label: 'Host in clip',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _UiKitSurface(
                      skin: skin,
                      viewType: 'compose.clip.host',
                      hitBehavior: PlatformViewHitTestBehavior.translucent,
                      attemptNativeOnIOS: false,
                      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                      onPlatformCreated: (_) {},
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _LabelledBox(
                  skin: skin,
                  label: 'Host with border shell',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: skin.secondary.withAlpha(140), width: 2),
                    ),
                    child: _UiKitSurface(
                      skin: skin,
                      viewType: 'compose.border.host',
                      hitBehavior: PlatformViewHitTestBehavior.transparent,
                      attemptNativeOnIOS: false,
                      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                      onPlatformCreated: (_) {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'C) Embedded in Scrolling Feed',
          child: SizedBox(
            height: 260,
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                if (index == 3) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    height: 130,
                    child: _UiKitSurface(
                      skin: skin,
                      viewType: 'compose.feed.embed',
                      hitBehavior: PlatformViewHitTestBehavior.opaque,
                      attemptNativeOnIOS: false,
                      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
                      onPlatformCreated: (_) {},
                    ),
                  );
                }
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: skin.paper,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: skin.muted.withAlpha(35)),
                  ),
                  child: Text(
                    'Flutter row ${index + 1}',
                    style: TextStyle(fontSize: 11.8, color: skin.ink),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Scene 5: Practical Patterns
// -----------------------------------------------------------------------------

class _PracticalScene extends StatefulWidget {
  const _PracticalScene({required this.skin, required this.onLog});

  final _Skin skin;
  final void Function(String) onLog;

  @override
  State<_PracticalScene> createState() => _PracticalSceneState();
}

class _PracticalSceneState extends State<_PracticalScene> {
  int _preset = 0;
  bool _allowNativeAttempt = false;

  static const _presetNames = <String>[
    'Map Preview',
    'Video Tile',
    'Payment Sheet',
    'AR Panel',
    'Document Scanner',
  ];

  static const _presetViewTypes = <String>[
    'practical.map.preview',
    'practical.video.tile',
    'practical.payment.sheet',
    'practical.ar.panel',
    'practical.doc.scanner',
  ];

  static const _presetDescriptions = <String>[
    'Embed native iOS map controls while keeping Flutter overlays and route chips above the host region.',
    'Host a native media surface with Flutter playback chrome and recommendation ribbons.',
    'Display a native payment sheet area while preserving Flutter checkout scaffolding and validation labels.',
    'Present an AR-capable native viewport in a Flutter flow, with guidance overlays and action controls.',
    'Bridge a native scanner preview while Flutter manages workflow state and capture instructions.',
  ];

  PlatformViewHitTestBehavior _presetBehavior(int index) {
    switch (index) {
      case 0:
        return PlatformViewHitTestBehavior.opaque;
      case 1:
        return PlatformViewHitTestBehavior.translucent;
      case 2:
        return PlatformViewHitTestBehavior.opaque;
      case 3:
        return PlatformViewHitTestBehavior.translucent;
      case 4:
        return PlatformViewHitTestBehavior.transparent;
      default:
        return PlatformViewHitTestBehavior.opaque;
    }
  }

  Set<Factory<OneSequenceGestureRecognizer>> _presetRecognizers(int index) {
    switch (index) {
      case 0:
        return {
          Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
          Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer()),
        };
      case 1:
        return {
          Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
          Factory<HorizontalDragGestureRecognizer>(() => HorizontalDragGestureRecognizer()),
        };
      case 2:
        return {
          Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
          Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
        };
      case 3:
        return {
          Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),
          Factory<LongPressGestureRecognizer>(() => LongPressGestureRecognizer()),
        };
      case 4:
        return {
          Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
        };
      default:
        return const <Factory<OneSequenceGestureRecognizer>>{};
    }
  }

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    final name = _presetNames[_preset];
    final viewType = _presetViewTypes[_preset];
    final description = _presetDescriptions[_preset];
    final behavior = _presetBehavior(_preset);
    final recognizers = _presetRecognizers(_preset);

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _InfoPanel(
          skin: skin,
          title: 'Practical Patterns',
          subtitle:
              'Preset-based scenarios showing how UiKitView/RenderUiKitView appears in product flows.',
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Preset Selector',
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(_presetNames.length, (index) {
                  final selected = index == _preset;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _preset = index);
                      widget.onLog('Practical preset -> ${_presetNames[index]}');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: selected ? skin.primary.withAlpha(26) : skin.panel,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: selected ? skin.primary : skin.muted.withAlpha(40),
                        ),
                      ),
                      child: Text(
                        _presetNames[index],
                        style: TextStyle(
                          fontSize: 11.5,
                          color: selected ? skin.primary : skin.ink,
                          fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              _SwitchLine(
                skin: skin,
                label: 'Attempt native host on iOS for selected preset',
                value: _allowNativeAttempt,
                onChanged: (value) {
                  setState(() => _allowNativeAttempt = value);
                  widget.onLog('Practical allowNative -> $value');
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Scenario: $name',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(fontSize: 12.3, color: skin.ink, height: 1.45),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _UiKitSurface(
                        skin: skin,
                        viewType: viewType,
                        hitBehavior: behavior,
                        attemptNativeOnIOS: _allowNativeAttempt,
                        gestureRecognizers: recognizers,
                        onPlatformCreated: (id) => widget.onLog('Practical native id=$id'),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: _OverlayPill(
                        label: 'viewType: $viewType',
                        color: skin.shell.withAlpha(190),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: _OverlayPill(
                        label: 'behavior: ${behavior.name}',
                        color: skin.primary.withAlpha(220),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: Row(
                        children: [
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () => widget.onLog('Practical action A on $name'),
                              child: const Text('Action A'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FilledButton.tonal(
                              onPressed: () => widget.onLog('Practical action B on $name'),
                              child: const Text('Action B'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _ChecklistPanel(
          skin: skin,
          title: 'Preset Notes',
          points: [
            'Current preset: $name',
            'Current behavior: ${behavior.name}',
            'Gesture recognizer factories: ${recognizers.length}',
            'Non-iOS or unregistered platform types use simulator mode safely.',
            'In production, register each viewType in iOS platform-view factory.',
          ],
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Scene 6: Compendium
// -----------------------------------------------------------------------------

class _CompendiumScene extends StatelessWidget {
  const _CompendiumScene({required this.skin, required this.timeline});

  final _Skin skin;
  final List<_DemoEvent> timeline;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _InfoPanel(
          skin: skin,
          title: 'Verification Compendium',
          subtitle:
              'Collected checks and lifecycle notes for RenderUiKitView-related workflows.',
        ),
        const SizedBox(height: 10),
        _ChecklistPanel(
          skin: skin,
          title: 'Coverage Checklist',
          points: const [
            'Primer with real UiKitView wiring and guarded native attempt path',
            'PlatformViewHitTestBehavior simulation and counters',
            'Gesture recognizer-set construction using Factory<T>',
            'Composition scenarios: card overlay, side-by-side hosts, list embedding',
            'Practical presets for map/media/payment/AR/scanner patterns',
            'Fallback-safe visuals on non-iOS or unregistered viewType',
            'Timeline logging of interactions and scene transitions',
            'No analyzer ignores, warnings, or info messages expected',
          ],
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'API Quick Table',
          child: Column(
            children: const [
              _ApiLine(left: 'Widget', right: 'UiKitView'),
              _ApiLine(left: 'Render object', right: 'RenderUiKitView'),
              _ApiLine(left: 'viewType', right: 'Native iOS factory identifier'),
              _ApiLine(left: 'hitTestBehavior', right: 'opaque / translucent / transparent'),
              _ApiLine(left: 'gestureRecognizers', right: 'Set<Factory<OneSequenceGestureRecognizer>>'),
              _ApiLine(left: 'onPlatformViewCreated', right: 'Lifecycle callback with platform id'),
              _ApiLine(left: 'Platform scope', right: 'iOS only for actual UIKit surface'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Timeline',
          child: timeline.isEmpty
              ? Text('No events logged yet.', style: TextStyle(fontSize: 12, color: skin.muted))
              : Column(
                  children: timeline
                      .take(80)
                      .map(
                        (event) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 64,
                                child: Text(
                                  event.time,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontFamily: 'monospace',
                                    color: skin.muted,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  event.label,
                                  style: TextStyle(fontSize: 11.6, color: skin.ink),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 10),
        _CodeBlock(
          skin: skin,
          code:
              'if (defaultTargetPlatform == TargetPlatform.iOS) {\n'
              '  return UiKitView(\n'
              '    viewType: "my.native.surface",\n'
              '    hitTestBehavior: PlatformViewHitTestBehavior.opaque,\n'
              '    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{\n'
              '      Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()),\n'
              '    },\n'
              '  );\n'
              '}\n'
              'return fallbackSimulator();',
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Shared helper widgets
// -----------------------------------------------------------------------------

class _UiKitSurface extends StatelessWidget {
  const _UiKitSurface({
    required this.skin,
    required this.viewType,
    required this.hitBehavior,
    required this.attemptNativeOnIOS,
    required this.gestureRecognizers,
    required this.onPlatformCreated,
  });

  final _Skin skin;
  final String viewType;
  final PlatformViewHitTestBehavior hitBehavior;
  final bool attemptNativeOnIOS;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final void Function(int) onPlatformCreated;

  @override
  Widget build(BuildContext context) {
    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    final canAttemptNative = isIOS && attemptNativeOnIOS;

    if (canAttemptNative) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Positioned.fill(
              child: UiKitView(
                viewType: viewType,
                hitTestBehavior: hitBehavior,
                gestureRecognizers: gestureRecognizers,
                onPlatformViewCreated: onPlatformCreated,
              ),
            ),
            Positioned(
              left: 8,
              top: 8,
              child: _OverlayPill(
                label: 'Native attempt (iOS)',
                color: Colors.black.withAlpha(150),
              ),
            ),
          ],
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            skin.primary.withAlpha(95),
            skin.secondary.withAlpha(90),
            skin.tertiary.withAlpha(90),
          ],
        ),
        border: Border.all(color: skin.muted.withAlpha(65)),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: _SimulatorPattern()),
          Positioned(
            left: 10,
            top: 10,
            child: _OverlayPill(
              label: isIOS
                  ? 'Simulator mode (native disabled)'
                  : 'Simulator mode (non-iOS)',
              color: Colors.black.withAlpha(140),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: _OverlayPill(
              label: hitBehavior.name,
              color: skin.primary.withAlpha(200),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(180),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    viewType,
                    style: TextStyle(fontSize: 11.5, color: skin.ink, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'gesture factories: ${gestureRecognizers.length}',
                    style: TextStyle(fontSize: 10.8, color: skin.muted),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SimulatorPattern extends StatelessWidget {
  const _SimulatorPattern();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WavePainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha(38)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (int i = 0; i < 10; i++) {
      final y = (size.height / 10) * i + 6;
      final path = Path()..moveTo(0, y);
      for (double x = 0; x <= size.width; x += 14) {
        final wave = math.sin((x / size.width) * math.pi * 2 + i) * 4;
        path.lineTo(x, y + wave);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FlutterOnlySurface extends StatelessWidget {
  const _FlutterOnlySurface({required this.skin});

  final _Skin skin;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [skin.paper, skin.panel],
        ),
        border: Border.all(color: skin.muted.withAlpha(45)),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flutter_dash, size: 32, color: skin.primary),
            const SizedBox(height: 8),
            Text(
              'Flutter-rendered surface',
              style: TextStyle(fontSize: 12, color: skin.ink, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              'No platform view involved',
              style: TextStyle(fontSize: 11, color: skin.muted),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel({
    required this.skin,
    required this.title,
    required this.subtitle,
  });

  final _Skin skin;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: skin.panel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: skin.muted.withAlpha(45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15, color: skin.ink, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12.2, color: skin.muted, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({
    required this.skin,
    required this.title,
    required this.child,
  });

  final _Skin skin;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: skin.panel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: skin.muted.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: skin.ink),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _SwitchLine extends StatelessWidget {
  const _SwitchLine({
    required this.skin,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final _Skin skin;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 11.8, color: skin.ink),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: skin.primary,
        ),
      ],
    );
  }
}

class _SliderLine extends StatelessWidget {
  const _SliderLine({
    required this.skin,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final _Skin skin;
  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 92,
          child: Text(label, style: TextStyle(fontSize: 11.5, color: skin.muted)),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
            activeColor: skin.primary,
          ),
        ),
        SizedBox(
          width: 52,
          child: Text(
            value.toStringAsFixed(2),
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 11, color: skin.muted, fontFamily: 'monospace'),
          ),
        ),
      ],
    );
  }
}

class _ToggleChip extends StatelessWidget {
  const _ToggleChip({
    required this.skin,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final _Skin skin;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: value,
      selectedColor: skin.secondary.withAlpha(28),
      onSelected: onChanged,
      labelStyle: TextStyle(
        fontSize: 11.2,
        fontWeight: value ? FontWeight.w700 : FontWeight.w600,
        color: value ? skin.secondary : skin.ink,
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.skin, required this.code});

  final _Skin skin;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: skin.shell.withAlpha(18),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: skin.muted.withAlpha(35)),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontSize: 11,
          height: 1.4,
          color: skin.ink,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _LabelledBox extends StatelessWidget {
  const _LabelledBox({
    required this.skin,
    required this.label,
    required this.child,
  });

  final _Skin skin;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 170, child: child),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: skin.muted, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _ChainRow extends StatelessWidget {
  const _ChainRow({
    required this.skin,
    required this.index,
    required this.label,
  });

  final _Skin skin;
  final int index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: skin.primary.withAlpha(30),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$index',
              style: TextStyle(fontSize: 11, color: skin.primary, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label, style: TextStyle(fontSize: 11.8, color: skin.ink)),
          ),
        ],
      ),
    );
  }
}

class _ChecklistPanel extends StatelessWidget {
  const _ChecklistPanel({
    required this.skin,
    required this.title,
    required this.points,
  });

  final _Skin skin;
  final String title;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: skin.panel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: skin.muted.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 13, color: skin.ink, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          ...points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, size: 14, color: skin.secondary),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(point, style: TextStyle(fontSize: 11.7, color: skin.ink)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiLine extends StatelessWidget {
  const _ApiLine({required this.left, required this.right});

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              left,
              style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(right, style: const TextStyle(fontSize: 11.8)),
          ),
        ],
      ),
    );
  }
}

class _OverlayPill extends StatelessWidget {
  const _OverlayPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10.5, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _HintBubble extends StatelessWidget {
  const _HintBubble({required this.skin, required this.text});

  final _Skin skin;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: skin.panel.withAlpha(200),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: skin.muted.withAlpha(50)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10.2, color: skin.ink),
      ),
    );
  }
}

class _CounterBadge extends StatelessWidget {
  const _CounterBadge({
    required this.skin,
    required this.label,
    required this.value,
    required this.accent,
  });

  final _Skin skin;
  final String label;
  final int value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withAlpha(22),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: accent.withAlpha(90)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 10.5, color: accent, fontWeight: FontWeight.w700)),
          Text('$value', style: TextStyle(fontSize: 14, color: accent, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _DottedPainterBackdrop extends StatelessWidget {
  const _DottedPainterBackdrop({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _DotPainter(color: color));
  }
}

class _DotPainter extends CustomPainter {
  _DotPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (double y = 8; y < size.height; y += 14) {
      for (double x = 8; x < size.width; x += 14) {
        canvas.drawCircle(Offset(x, y), 1.1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
