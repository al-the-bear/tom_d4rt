import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// CompositedTransformFollower Deep Demo
//
// CompositedTransformFollower is a render-object widget that positions itself
// relative to a CompositedTransformTarget via a shared LayerLink.  Together
// they form the foundation for tooltips, dropdown menus, context menus,
// coach-marks, and any UI that must "follow" another widget across frames
// without requiring manual Offset bookkeeping.
//
// Key properties:
//  • link           – The LayerLink shared with a CompositedTransformTarget
//  • targetAnchor   – The alignment point on the target (default topLeft)
//  • followerAnchor – The alignment point on the follower (default topLeft)
//  • offset         – Additional pixel offset applied after anchor resolution
//  • showWhenUnlinked – Whether the follower paints when the target is absent
//
// This demo explores all of these through six interactive scenes.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const _CompositedTransformFollowerDeepDemo();
}

// ============================  Scene enum  =================================

enum _Scene {
  linkPrimer,
  anchorWorkshop,
  floatingInspector,
  scrollLab,
  practicalPatterns,
  compendium,
}

// ============================  Skin palette  ================================

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
    name: 'Cobalt Studio',
    shell: Color(0xFF0D1F30),
    paper: Color(0xFFF0F6FC),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF1B3044),
    muted: Color(0xFF728C9E),
    primary: Color(0xFF1778C8),
    secondary: Color(0xFF22876A),
    tertiary: Color(0xFFCB8520),
  ),
  _Skin(
    name: 'Sage Workshop',
    shell: Color(0xFF162318),
    paper: Color(0xFFF1F8F3),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF263830),
    muted: Color(0xFF6E8E78),
    primary: Color(0xFF2E865A),
    secondary: Color(0xFF3A7CC0),
    tertiary: Color(0xFFB8862E),
  ),
  _Skin(
    name: 'Berry Dusk',
    shell: Color(0xFF2A1228),
    paper: Color(0xFFFAF0F8),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF3C1E3A),
    muted: Color(0xFF9A7098),
    primary: Color(0xFFA83890),
    secondary: Color(0xFF6840B0),
    tertiary: Color(0xFFD06828),
  ),
];

// ============================  Root widget  =================================

class _CompositedTransformFollowerDeepDemo extends StatefulWidget {
  const _CompositedTransformFollowerDeepDemo();

  @override
  State<_CompositedTransformFollowerDeepDemo> createState() =>
      _CompositedTransformFollowerDeepDemoState();
}

class _CompositedTransformFollowerDeepDemoState
    extends State<_CompositedTransformFollowerDeepDemo> {
  _Scene _scene = _Scene.linkPrimer;
  int _skinIndex = 0;
  final List<String> _timeline = [];

  _Skin get _skin => _skins[_skinIndex];

  void _log(String msg) {
    setState(() => _timeline.insert(0, msg));
  }

  // ----- build -----
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: _skin.paper,
        appBar: AppBar(
          backgroundColor: _skin.shell,
          foregroundColor: _skin.paper,
          title: const Text('CompositedTransformFollower Deep Demo'),
          actions: [
            IconButton(
              icon: const Icon(Icons.palette_outlined),
              tooltip: 'Cycle skin',
              onPressed: () {
                setState(() => _skinIndex = (_skinIndex + 1) % _skins.length);
                _log('Skin → ${_skins[_skinIndex].name}');
              },
            ),
          ],
        ),
        body: Column(
          children: [
            _buildSceneBar(),
            Expanded(child: _buildScene()),
          ],
        ),
      ),
    );
  }

  // ----- scene bar -----
  Widget _buildSceneBar() {
    return Container(
      color: _skin.shell.withAlpha(18),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _Scene.values.map((s) {
            final bool active = s == _scene;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: ChoiceChip(
                label: Text(_sceneLabel(s)),
                selected: active,
                selectedColor: _skin.primary.withAlpha(50),
                labelStyle: TextStyle(
                  color: active ? _skin.primary : _skin.ink,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
                onSelected: (_) {
                  setState(() => _scene = s);
                  _log('Scene → ${_sceneLabel(s)}');
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _sceneLabel(_Scene s) {
    switch (s) {
      case _Scene.linkPrimer:
        return '1 · Link Primer';
      case _Scene.anchorWorkshop:
        return '2 · Anchor Workshop';
      case _Scene.floatingInspector:
        return '3 · Floating Inspector';
      case _Scene.scrollLab:
        return '4 · Scroll Lab';
      case _Scene.practicalPatterns:
        return '5 · Practical Patterns';
      case _Scene.compendium:
        return '6 · Compendium';
    }
  }

  Widget _buildScene() {
    switch (_scene) {
      case _Scene.linkPrimer:
        return _LinkPrimer(skin: _skin, log: _log);
      case _Scene.anchorWorkshop:
        return _AnchorWorkshop(skin: _skin, log: _log);
      case _Scene.floatingInspector:
        return _FloatingInspector(skin: _skin, log: _log);
      case _Scene.scrollLab:
        return _ScrollLab(skin: _skin, log: _log);
      case _Scene.practicalPatterns:
        return _PracticalPatterns(skin: _skin, log: _log);
      case _Scene.compendium:
        return _Compendium(skin: _skin, timeline: _timeline);
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SCENE 1 – Link Primer
//
// Shows the minimal setup: a LayerLink connecting a
// CompositedTransformTarget to a CompositedTransformFollower inside a
// Stack.  Includes a toggle to link / unlink and demonstrate
// showWhenUnlinked.
// ═══════════════════════════════════════════════════════════════════════════

class _LinkPrimer extends StatefulWidget {
  const _LinkPrimer({required this.skin, required this.log});
  final _Skin skin;
  final void Function(String) log;

  @override
  State<_LinkPrimer> createState() => _LinkPrimerState();
}

class _LinkPrimerState extends State<_LinkPrimer> {
  final LayerLink _link = LayerLink();
  bool _linked = true;
  bool _showWhenUnlinked = true;

  @override
  Widget build(BuildContext context) {
    final s = widget.skin;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- explanation card ---
          _infoCard(
            s,
            'Link Primer',
            'A LayerLink is the invisible thread connecting a '
                'CompositedTransformTarget (the anchor) to one or more '
                'CompositedTransformFollower widgets.  The follower '
                'positions itself relative to the target every frame.\n\n'
                'Toggle the link below to see what happens when the '
                'follower loses its target.  The "showWhenUnlinked" '
                'switch controls visibility when the link is broken.',
          ),
          const SizedBox(height: 16),

          // --- toggles ---
          Row(
            children: [
              _chip(s, 'Linked', _linked, (v) {
                setState(() => _linked = v);
                widget.log('Linked → $v');
              }),
              const SizedBox(width: 12),
              _chip(s, 'showWhenUnlinked', _showWhenUnlinked, (v) {
                setState(() => _showWhenUnlinked = v);
                widget.log('showWhenUnlinked → $v');
              }),
            ],
          ),
          const SizedBox(height: 24),

          // --- demo area ---
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: s.panel,
              border: Border.all(color: s.muted.withAlpha(60)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                // Dashed-grid background
                Positioned.fill(child: _DashedGrid(color: s.muted)),

                // TARGET
                Positioned(
                  left: 60,
                  top: 80,
                  child: _linked
                      ? CompositedTransformTarget(
                          link: _link,
                          child: _targetBox(s, 'TARGET'),
                        )
                      : _targetBox(s, 'TARGET (unlinked)'),
                ),

                // FOLLOWER
                if (_linked)
                  CompositedTransformFollower(
                    link: _link,
                    showWhenUnlinked: _showWhenUnlinked,
                    offset: const Offset(130, 0),
                    child: _followerBox(s, 'FOLLOWER'),
                  ),
                if (!_linked)
                  CompositedTransformFollower(
                    link: _link,
                    showWhenUnlinked: _showWhenUnlinked,
                    offset: const Offset(130, 0),
                    child: _followerBox(s, 'FOLLOWER'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // --- code snippet ---
          _codeCard(
            s,
            'final link = LayerLink();\n\n'
            '// Wrap the anchor:\n'
            'CompositedTransformTarget(\n'
            '  link: link,\n'
            '  child: anchorWidget,\n'
            ');\n\n'
            '// The follower positions itself relative to that anchor:\n'
            'CompositedTransformFollower(\n'
            '  link: link,\n'
            '  targetAnchor: Alignment.bottomLeft,\n'
            '  followerAnchor: Alignment.topLeft,\n'
            '  offset: Offset(0, 4),\n'
            '  showWhenUnlinked: false,\n'
            '  child: followerWidget,\n'
            ');',
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SCENE 2 – Anchor Workshop
//
// Interactive controls for targetAnchor, followerAnchor, and offset so
// the user can see exactly how each parameter moves the follower.
// ═══════════════════════════════════════════════════════════════════════════

class _AnchorWorkshop extends StatefulWidget {
  const _AnchorWorkshop({required this.skin, required this.log});
  final _Skin skin;
  final void Function(String) log;

  @override
  State<_AnchorWorkshop> createState() => _AnchorWorkshopState();
}

class _AnchorWorkshopState extends State<_AnchorWorkshop> {
  final LayerLink _link = LayerLink();

  static const _alignments = <String, Alignment>{
    'topLeft': Alignment.topLeft,
    'topCenter': Alignment.topCenter,
    'topRight': Alignment.topRight,
    'centerLeft': Alignment.centerLeft,
    'center': Alignment.center,
    'centerRight': Alignment.centerRight,
    'bottomLeft': Alignment.bottomLeft,
    'bottomCenter': Alignment.bottomCenter,
    'bottomRight': Alignment.bottomRight,
  };

  String _targetAnchorKey = 'bottomLeft';
  String _followerAnchorKey = 'topLeft';
  double _dx = 0;
  double _dy = 4;

  Alignment get _targetAnchor => _alignments[_targetAnchorKey]!;
  Alignment get _followerAnchor => _alignments[_followerAnchorKey]!;

  @override
  Widget build(BuildContext context) {
    final s = widget.skin;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoCard(
            s,
            'Anchor Workshop',
            'Choose targetAnchor, followerAnchor, and offset to observe '
                'how the follower repositions itself.  The dashed line '
                'connects the two anchor points.',
          ),
          const SizedBox(height: 12),

          // --- anchor pickers ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _anchorPicker(
                  s,
                  'targetAnchor',
                  _targetAnchorKey,
                  (k) {
                    setState(() => _targetAnchorKey = k);
                    widget.log('targetAnchor → $k');
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _anchorPicker(
                  s,
                  'followerAnchor',
                  _followerAnchorKey,
                  (k) {
                    setState(() => _followerAnchorKey = k);
                    widget.log('followerAnchor → $k');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // --- offset sliders ---
          _sliderRow(s, 'dx', _dx, -100, 100, (v) {
            setState(() => _dx = v);
          }),
          _sliderRow(s, 'dy', _dy, -100, 100, (v) {
            setState(() => _dy = v);
          }),
          const SizedBox(height: 16),

          // --- demo area ---
          Container(
            height: 320,
            decoration: BoxDecoration(
              color: s.panel,
              border: Border.all(color: s.muted.withAlpha(60)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned.fill(child: _DashedGrid(color: s.muted)),

                // Target centred horizontally, a bit above centre
                Align(
                  alignment: const Alignment(0, -0.3),
                  child: CompositedTransformTarget(
                    link: _link,
                    child: _targetBox(s, 'TARGET'),
                  ),
                ),

                // Follower
                CompositedTransformFollower(
                  link: _link,
                  targetAnchor: _targetAnchor,
                  followerAnchor: _followerAnchor,
                  offset: Offset(_dx, _dy),
                  child: _followerBox(s, 'FOLLOWER'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // --- status readout ---
          _readoutCard(s, [
            'targetAnchor: $_targetAnchorKey',
            'followerAnchor: $_followerAnchorKey',
            'offset: Offset(${_dx.toStringAsFixed(0)}, ${_dy.toStringAsFixed(0)})',
          ]),
        ],
      ),
    );
  }

  Widget _anchorPicker(
    _Skin s,
    String label,
    String current,
    ValueChanged<String> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: s.ink)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: _alignments.keys.map((k) {
            final bool sel = k == current;
            return GestureDetector(
              onTap: () => onChanged(k),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: sel ? s.primary.withAlpha(40) : s.panel,
                  border: Border.all(
                    color: sel ? s.primary : s.muted.withAlpha(50),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  k,
                  style: TextStyle(
                    fontSize: 10,
                    color: sel ? s.primary : s.muted,
                    fontWeight: sel ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _sliderRow(
    _Skin s,
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          child: Text(label,
              style: TextStyle(fontSize: 12, color: s.ink)),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: ((max - min) / 1).round(),
            activeColor: s.primary,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            value.toStringAsFixed(0),
            style: TextStyle(fontSize: 11, color: s.muted),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SCENE 3 – Floating Inspector HUD
//
// A draggable target box with a tethered follower panel that shows
// real-time position information.  Demonstrates that the follower
// tracks across frames automatically.
// ═══════════════════════════════════════════════════════════════════════════

class _FloatingInspector extends StatefulWidget {
  const _FloatingInspector({required this.skin, required this.log});
  final _Skin skin;
  final void Function(String) log;

  @override
  State<_FloatingInspector> createState() => _FloatingInspectorState();
}

class _FloatingInspectorState extends State<_FloatingInspector> {
  final LayerLink _link = LayerLink();
  Offset _position = const Offset(100, 100);
  int _moveCount = 0;

  @override
  Widget build(BuildContext context) {
    final s = widget.skin;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoCard(
            s,
            'Floating Inspector HUD',
            'Drag the target box around.  The follower panel tracks its '
                'position automatically — no manual Offset arithmetic needed.',
          ),
          const SizedBox(height: 16),

          Container(
            height: 360,
            decoration: BoxDecoration(
              color: s.panel,
              border: Border.all(color: s.muted.withAlpha(60)),
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Positioned.fill(child: _DashedGrid(color: s.muted)),

                // Draggable target
                Positioned(
                  left: _position.dx,
                  top: _position.dy,
                  child: GestureDetector(
                    onPanUpdate: (d) {
                      setState(() {
                        _position += d.delta;
                        _moveCount++;
                      });
                    },
                    onPanEnd: (_) {
                      widget.log('Inspector drag #$_moveCount '
                          '→ (${_position.dx.toStringAsFixed(0)}, '
                          '${_position.dy.toStringAsFixed(0)})');
                    },
                    child: CompositedTransformTarget(
                      link: _link,
                      child: Container(
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                          color: s.primary,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: s.primary.withAlpha(60),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.open_with,
                                size: 20, color: s.paper),
                            Text('DRAG ME',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: s.paper)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Follower HUD
                CompositedTransformFollower(
                  link: _link,
                  targetAnchor: Alignment.bottomCenter,
                  followerAnchor: Alignment.topCenter,
                  offset: const Offset(0, 8),
                  child: Container(
                    width: 180,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: s.shell.withAlpha(230),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: s.primary.withAlpha(80)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Inspector HUD',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: s.paper)),
                        const SizedBox(height: 4),
                        Text(
                          'x: ${_position.dx.toStringAsFixed(1)}\n'
                          'y: ${_position.dy.toStringAsFixed(1)}\n'
                          'moves: $_moveCount',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: s.paper.withAlpha(200)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _readoutCard(s, [
            'position: (${_position.dx.toStringAsFixed(1)}, ${_position.dy.toStringAsFixed(1)})',
            'move count: $_moveCount',
          ]),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SCENE 4 – Scroll Lab
//
// Target inside a scrollable area; follower in the overlay.
// Demonstrates that CompositedTransformFollower correctly tracks a
// CompositedTransformTarget that scrolls.
// ═══════════════════════════════════════════════════════════════════════════

class _ScrollLab extends StatefulWidget {
  const _ScrollLab({required this.skin, required this.log});
  final _Skin skin;
  final void Function(String) log;

  @override
  State<_ScrollLab> createState() => _ScrollLabState();
}

class _ScrollLabState extends State<_ScrollLab> {
  final LayerLink _link = LayerLink();
  final ScrollController _scrollCtrl = ScrollController();
  bool _showFollower = true;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      setState(() => _scrollOffset = _scrollCtrl.offset);
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.skin;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoCard(
            s,
            'Scroll & Reparent Lab',
            'The target (green box) sits inside a vertically scrollable '
                'list.  The follower (blue panel) stays in the outer Stack.  '
                'Scroll the list and watch the follower track the target '
                'through the scroll transform.',
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              _chip(s, 'Show follower', _showFollower, (v) {
                setState(() => _showFollower = v);
                widget.log('Follower visible → $v');
              }),
              const SizedBox(width: 16),
              Text(
                'scroll: ${_scrollOffset.toStringAsFixed(0)}px',
                style: TextStyle(fontSize: 11, color: s.muted),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            height: 340,
            decoration: BoxDecoration(
              color: s.panel,
              border: Border.all(color: s.muted.withAlpha(60)),
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                // Scrollable list containing the target
                ListView.separated(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.all(12),
                  itemCount: 30,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    if (i == 8) {
                      // The target item
                      return CompositedTransformTarget(
                        link: _link,
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: s.secondary.withAlpha(40),
                            border: Border.all(color: s.secondary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.gps_fixed,
                                  size: 16, color: s.secondary),
                              const SizedBox(width: 6),
                              Text(
                                'TARGET (item #$i)',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: s.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: s.muted.withAlpha(15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Item #$i',
                          style: TextStyle(fontSize: 12, color: s.muted)),
                    );
                  },
                ),

                // Follower tracks through scrolling
                if (_showFollower)
                  CompositedTransformFollower(
                    link: _link,
                    targetAnchor: Alignment.centerRight,
                    followerAnchor: Alignment.centerLeft,
                    offset: const Offset(8, 0),
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: s.primary.withAlpha(220),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: s.primary.withAlpha(40),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Follower',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: s.paper)),
                          const SizedBox(height: 4),
                          Text(
                            'scroll: ${_scrollOffset.toStringAsFixed(0)}\n'
                            'Tracks via\nLayerLink',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9, color: s.paper.withAlpha(190)),
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
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SCENE 5 – Practical Patterns
//
// Four mini-demos showing real-world uses:
//  • Custom dropdown-like menu
//  • Tooltip bubble
//  • Coach-mark spotlight
//  • Context palette (colour picker)
// ═══════════════════════════════════════════════════════════════════════════

class _PracticalPatterns extends StatefulWidget {
  const _PracticalPatterns({required this.skin, required this.log});
  final _Skin skin;
  final void Function(String) log;

  @override
  State<_PracticalPatterns> createState() => _PracticalPatternsState();
}

class _PracticalPatternsState extends State<_PracticalPatterns> {
  // --- Dropdown state ---
  final LayerLink _dropdownLink = LayerLink();
  bool _dropdownOpen = false;
  String _dropdownValue = 'Option A';
  static const _dropdownOptions = ['Option A', 'Option B', 'Option C', 'Option D'];

  // --- Tooltip state ---
  final LayerLink _tooltipLink = LayerLink();
  bool _tooltipVisible = false;

  // --- Coach-mark state ---
  final LayerLink _coachLink = LayerLink();
  bool _coachActive = false;
  int _coachStep = 0;
  static const _coachMessages = [
    'Welcome!  This is the first step of the coach-mark tour.',
    'The follower arrow always points at the target — even if scrolled.',
    'Coach-marks use showWhenUnlinked: false to hide gracefully.',
  ];

  // --- Colour palette state ---
  final LayerLink _paletteLink = LayerLink();
  bool _paletteOpen = false;
  Color _selectedColour = const Color(0xFF1778C8);
  static const _paletteColours = [
    Color(0xFF1778C8), Color(0xFF22876A), Color(0xFFCB8520),
    Color(0xFFA83890), Color(0xFF6840B0), Color(0xFFD06828),
    Color(0xFF333333), Color(0xFF888888), Color(0xFFCC2244),
  ];

  @override
  Widget build(BuildContext context) {
    final s = widget.skin;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoCard(
            s,
            'Practical Patterns',
            'Four real-world patterns built on CompositedTransformFollower.',
          ),
          const SizedBox(height: 20),

          // ---- Pattern 1: Dropdown ----
          _patternHeader(s, '① Custom Dropdown Menu'),
          const SizedBox(height: 8),
          SizedBox(
            height: 170,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 16,
                  top: 12,
                  child: CompositedTransformTarget(
                    link: _dropdownLink,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _dropdownOpen = !_dropdownOpen);
                        widget.log('Dropdown ${_dropdownOpen ? "opened" : "closed"}');
                      },
                      child: Container(
                        width: 160,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: s.panel,
                          border: Border.all(color: s.primary),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(_dropdownValue,
                                  style: TextStyle(
                                      fontSize: 13, color: s.ink)),
                            ),
                            Icon(
                              _dropdownOpen
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: s.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (_dropdownOpen)
                  CompositedTransformFollower(
                    link: _dropdownLink,
                    targetAnchor: Alignment.bottomLeft,
                    followerAnchor: Alignment.topLeft,
                    offset: const Offset(0, 2),
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        color: s.panel,
                        border: Border.all(color: s.primary.withAlpha(80)),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: s.ink.withAlpha(20),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _dropdownOptions.map((opt) {
                          final selected = opt == _dropdownValue;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _dropdownValue = opt;
                                _dropdownOpen = false;
                              });
                              widget.log('Selected: $opt');
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              color: selected
                                  ? s.primary.withAlpha(20)
                                  : Colors.transparent,
                              child: Text(
                                opt,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: selected ? s.primary : s.ink,
                                  fontWeight: selected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ---- Pattern 2: Tooltip ----
          _patternHeader(s, '② Tooltip Bubble'),
          const SizedBox(height: 8),
          SizedBox(
            height: 110,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: CompositedTransformTarget(
                    link: _tooltipLink,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _tooltipVisible = !_tooltipVisible);
                        widget.log('Tooltip ${_tooltipVisible ? "shown" : "hidden"}');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: s.secondary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('Tap for tooltip',
                            style: TextStyle(
                                fontSize: 12,
                                color: s.paper,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                if (_tooltipVisible)
                  CompositedTransformFollower(
                    link: _tooltipLink,
                    targetAnchor: Alignment.topCenter,
                    followerAnchor: Alignment.bottomCenter,
                    offset: const Offset(0, -8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: s.shell,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: s.ink.withAlpha(30),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Text(
                        'This tooltip follows the button!',
                        style: TextStyle(fontSize: 11, color: s.paper),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ---- Pattern 3: Coach-mark ----
          _patternHeader(s, '③ Coach-mark Spotlight'),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(-0.3, 0.0),
                  child: CompositedTransformTarget(
                    link: _coachLink,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: s.tertiary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.star, color: s.paper, size: 22),
                    ),
                  ),
                ),
                if (_coachActive)
                  CompositedTransformFollower(
                    link: _coachLink,
                    targetAnchor: Alignment.centerRight,
                    followerAnchor: Alignment.centerLeft,
                    offset: const Offset(12, 0),
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: s.shell.withAlpha(230),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: s.tertiary.withAlpha(100)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Step ${_coachStep + 1} / ${_coachMessages.length}',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: s.tertiary),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _coachMessages[_coachStep],
                            style: TextStyle(fontSize: 11, color: s.paper),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_coachStep <
                                      _coachMessages.length - 1) {
                                    setState(() => _coachStep++);
                                    widget.log(
                                        'Coach step → ${_coachStep + 1}');
                                  } else {
                                    setState(() {
                                      _coachActive = false;
                                      _coachStep = 0;
                                    });
                                    widget.log('Coach tour ended');
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: s.tertiary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    _coachStep <
                                            _coachMessages.length - 1
                                        ? 'Next'
                                        : 'Done',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: s.paper),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _coachActive = !_coachActive;
                        _coachStep = 0;
                      });
                      widget.log(
                          'Coach tour ${_coachActive ? "started" : "stopped"}');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: s.tertiary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _coachActive ? 'Stop tour' : 'Start tour',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: s.paper),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ---- Pattern 4: Colour palette ----
          _patternHeader(s, '④ Context Palette'),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: CompositedTransformTarget(
                    link: _paletteLink,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _paletteOpen = !_paletteOpen);
                        widget.log(
                            'Palette ${_paletteOpen ? "opened" : "closed"}');
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _selectedColour,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: s.ink.withAlpha(40), width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
                if (_paletteOpen)
                  CompositedTransformFollower(
                    link: _paletteLink,
                    targetAnchor: Alignment.bottomCenter,
                    followerAnchor: Alignment.topCenter,
                    offset: const Offset(0, 6),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: s.panel,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: s.muted.withAlpha(50)),
                        boxShadow: [
                          BoxShadow(
                            color: s.ink.withAlpha(15),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: _paletteColours.map((c) {
                          final selected = c == _selectedColour;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColour = c;
                                _paletteOpen = false;
                              });
                              widget.log(
                                  'Colour → #${c.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}');
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: c,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selected
                                      ? s.ink
                                      : Colors.transparent,
                                  width: selected ? 2 : 0,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _patternHeader(_Skin s, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: s.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: s.primary),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SCENE 6 – Verification Compendium
//
// Summary of tested features, API reference, and session timeline.
// ═══════════════════════════════════════════════════════════════════════════

class _Compendium extends StatelessWidget {
  const _Compendium({required this.skin, required this.timeline});
  final _Skin skin;
  final List<String> timeline;

  @override
  Widget build(BuildContext context) {
    final s = skin;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(s, 'Verification Compendium'),
          const SizedBox(height: 12),

          // --- Feature checklist ---
          _groupTitle(s, 'Feature Checklist'),
          const SizedBox(height: 6),
          ..._featureChecks.map((f) => _checkRow(s, f)),
          const SizedBox(height: 20),

          // --- API reference ---
          _groupTitle(s, 'API Quick Reference'),
          const SizedBox(height: 6),
          _apiTable(s),
          const SizedBox(height: 20),

          // --- Key concepts ---
          _groupTitle(s, 'Key Concepts'),
          const SizedBox(height: 6),
          _conceptCard(
            s,
            'LayerLink',
            'An opaque handle created by the user and shared between a '
                'CompositedTransformTarget and its follower(s).  It carries '
                'the target\'s transform matrix through the compositing layer '
                'tree so the follower can position itself.',
          ),
          const SizedBox(height: 8),
          _conceptCard(
            s,
            'Compositing vs Layout',
            'CompositedTransformFollower positions itself during the '
                'compositing phase — *after* layout.  This means the '
                'follower receives its full size from layout normally but '
                'shifts its painting origin to match the target.  It does '
                'not influence layout of siblings.',
          ),
          const SizedBox(height: 8),
          _conceptCard(
            s,
            'Overlay Integration',
            'The common pattern is to put the Target in the widget tree '
                'and the Follower inside an OverlayEntry.  Since overlays '
                'paint above normal content, the follower appears as a '
                'floating panel (tooltip, dropdown, etc.) without needing '
                'to calculate global coordinates.',
          ),
          const SizedBox(height: 20),

          // --- Performance notes ---
          _groupTitle(s, 'Performance Notes'),
          const SizedBox(height: 6),
          _bulletList(s, const [
            'LayerLink + FollowerLayer are handled at the compositing '
                'level — no extra layout pass is needed each frame.',
            'Multiple followers can share the same LayerLink without '
                'additional overhead besides their own paint cost.',
            'offstage followers (showWhenUnlinked: false with no target) '
                'are skipped during painting entirely.',
            'Avoid placing hundreds of followers in a single frame — '
                'each adds a compositing layer.',
          ]),
          const SizedBox(height: 20),

          // --- Common pitfalls ---
          _groupTitle(s, 'Common Pitfalls'),
          const SizedBox(height: 6),
          _bulletList(s, const [
            'Using the same LayerLink for two targets leads to '
                'undefined behaviour — one link, one target.',
            'Forgetting to set showWhenUnlinked: false causes the '
                'follower to paint at (0,0) when the target is removed.',
            'Stack.clipBehavior must be Clip.none if the follower '
                'needs to overflow the parent Stack bounds.',
            'Combining with a Transform widget on an ancestor may '
                'produce unexpected offsets — LayerLink captures the '
                'raw compositing transform, not the paint transform.',
          ]),
          const SizedBox(height: 20),

          // --- Timeline ---
          _groupTitle(s, 'Session Timeline'),
          const SizedBox(height: 6),
          if (timeline.isEmpty)
            Text('No events recorded yet.',
                style: TextStyle(fontSize: 12, color: s.muted))
          else
            ...timeline.take(40).map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ',
                          style: TextStyle(
                              fontSize: 12, color: s.primary)),
                      Expanded(
                        child: Text(e,
                            style: TextStyle(
                                fontSize: 11, color: s.ink)),
                      ),
                    ],
                  ),
                )),
        ],
      ),
    );
  }

  // --- data ---
  static const _featureChecks = <String>[
    'LayerLink creation and sharing',
    'CompositedTransformTarget wrapping an anchor',
    'CompositedTransformFollower basic positioning',
    'targetAnchor control (9 alignments)',
    'followerAnchor control (9 alignments)',
    'offset (dx, dy) fine-tuning',
    'showWhenUnlinked toggling',
    'Linked / unlinked state transitions',
    'Draggable target with real-time tracking',
    'Scrollable target with follower in overlay',
    'Dropdown menu pattern',
    'Tooltip bubble pattern',
    'Coach-mark spotlight pattern',
    'Context colour-palette pattern',
    'Multiple LayerLinks in the same tree',
    'Skin palette for visual variety',
  ];

  Widget _checkRow(_Skin s, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 14, color: s.secondary),
          const SizedBox(width: 6),
          Expanded(
            child: Text(label,
                style: TextStyle(fontSize: 12, color: s.ink)),
          ),
        ],
      ),
    );
  }

  Widget _apiTable(_Skin s) {
    const rows = <List<String>>[
      ['Property', 'Type', 'Default'],
      ['link', 'LayerLink', '(required)'],
      ['showWhenUnlinked', 'bool', 'true'],
      ['targetAnchor', 'Alignment', 'topLeft'],
      ['followerAnchor', 'Alignment', 'topLeft'],
      ['offset', 'Offset', 'Offset.zero'],
      ['child', 'Widget?', 'null'],
    ];
    return Table(
      border: TableBorder.all(color: s.muted.withAlpha(40)),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
      },
      children: rows.asMap().entries.map((e) {
        final isHeader = e.key == 0;
        return TableRow(
          decoration: BoxDecoration(
            color: isHeader ? s.primary.withAlpha(15) : null,
          ),
          children: e.value
              .map((cell) => Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      cell,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            isHeader ? FontWeight.bold : FontWeight.normal,
                        color: isHeader ? s.primary : s.ink,
                      ),
                    ),
                  ))
              .toList(),
        );
      }).toList(),
    );
  }

  Widget _conceptCard(_Skin s, String title, String body) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: s.panel,
        border: Border.all(color: s.muted.withAlpha(50)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: s.primary)),
          const SizedBox(height: 4),
          Text(body, style: TextStyle(fontSize: 11, color: s.ink)),
        ],
      ),
    );
  }

  Widget _bulletList(_Skin s, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((t) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ',
                        style: TextStyle(fontSize: 12, color: s.muted)),
                    Expanded(
                      child: Text(t,
                          style: TextStyle(fontSize: 11, color: s.ink)),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SHARED HELPERS
// ═══════════════════════════════════════════════════════════════════════════

Widget _targetBox(_Skin s, String label) {
  return Container(
    width: 100,
    height: 50,
    decoration: BoxDecoration(
      color: s.secondary.withAlpha(30),
      border: Border.all(color: s.secondary, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: s.secondary,
      ),
    ),
  );
}

Widget _followerBox(_Skin s, String label) {
  return Container(
    width: 100,
    height: 44,
    decoration: BoxDecoration(
      color: s.primary.withAlpha(30),
      border: Border.all(color: s.primary, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: s.primary,
      ),
    ),
  );
}

Widget _infoCard(_Skin s, String title, String body) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: s.primary.withAlpha(10),
      border: Border.all(color: s.primary.withAlpha(40)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: s.primary)),
        const SizedBox(height: 6),
        Text(body, style: TextStyle(fontSize: 12, color: s.ink)),
      ],
    ),
  );
}

Widget _codeCard(_Skin s, String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: s.shell.withAlpha(20),
      border: Border.all(color: s.muted.withAlpha(50)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: s.ink,
        height: 1.4,
      ),
    ),
  );
}

Widget _readoutCard(_Skin s, List<String> lines) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: s.shell.withAlpha(14),
      border: Border.all(color: s.muted.withAlpha(40)),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines
          .map((l) => Text(l,
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: s.ink)))
          .toList(),
    ),
  );
}

Widget _chip(
    _Skin s, String label, bool value, ValueChanged<bool> onChanged) {
  return FilterChip(
    label: Text(label),
    selected: value,
    selectedColor: s.primary.withAlpha(40),
    labelStyle: TextStyle(
      fontSize: 11,
      color: value ? s.primary : s.ink,
    ),
    onSelected: onChanged,
  );
}

Widget _sectionTitle(_Skin s, String title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: s.primary,
    ),
  );
}

Widget _groupTitle(_Skin s, String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: s.secondary,
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// Dashed Grid – lightweight visual background for demo containers
// ═══════════════════════════════════════════════════════════════════════════

class _DashedGrid extends StatelessWidget {
  const _DashedGrid({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _DashedGridPainter(color: color));
  }
}

class _DashedGridPainter extends CustomPainter {
  _DashedGridPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withAlpha(18)
      ..strokeWidth = 0.5;
    const step = 24.0;
    for (double x = 0; x < size.width; x += step) {
      _drawDashedLine(
          canvas, Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      _drawDashedLine(
          canvas, Offset(0, y), Offset(size.width, y), paint);
    }
  }

  void _drawDashedLine(
      Canvas canvas, Offset from, Offset to, Paint paint) {
    const dashLen = 4.0;
    const gapLen = 4.0;
    final dx = to.dx - from.dx;
    final dy = to.dy - from.dy;
    final len = math.sqrt(dx * dx + dy * dy);
    if (len == 0) return;
    final ux = dx / len;
    final uy = dy / len;
    double d = 0;
    while (d < len) {
      final end = math.min(d + dashLen, len);
      canvas.drawLine(
        Offset(from.dx + ux * d, from.dy + uy * d),
        Offset(from.dx + ux * end, from.dy + uy * end),
        paint,
      );
      d += dashLen + gapLen;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedGridPainter oldDelegate) =>
      color != oldDelegate.color;
}
