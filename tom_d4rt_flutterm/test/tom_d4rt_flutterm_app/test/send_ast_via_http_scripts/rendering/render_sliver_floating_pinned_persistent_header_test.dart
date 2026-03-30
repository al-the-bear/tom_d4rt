import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// RenderSliverFloatingPinnedPersistentHeader Deep Demo
//
// This demo is intentionally visual and interaction-heavy.  It demonstrates
// the behavior surfaced at widget level by SliverPersistentHeader(pinned: true,
// floating: true), which is backed by RenderSliverFloatingPinnedPersistentHeader.
//
// The core idea:
// - pinned keeps the header anchored at the leading edge when collapsed
// - floating lets it re-enter quickly on reverse scroll
// - together they produce responsive, always-reachable section controls
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const _RenderSliverFloatingPinnedPersistentHeaderDeepDemo();
}

enum _Scene {
  primer,
  comparator,
  dynamics,
  layered,
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
    name: 'Harbor Blue',
    shell: Color(0xFF102234),
    paper: Color(0xFFF2F7FB),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF203548),
    muted: Color(0xFF6E8698),
    primary: Color(0xFF1A84D2),
    secondary: Color(0xFF1B9A7A),
    tertiary: Color(0xFFCC8A2A),
  ),
  _Skin(
    name: 'Olive Draft',
    shell: Color(0xFF15261F),
    paper: Color(0xFFF3F9F5),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF2B3D34),
    muted: Color(0xFF70897A),
    primary: Color(0xFF2D8F4B),
    secondary: Color(0xFF2A7EC7),
    tertiary: Color(0xFFB9902F),
  ),
  _Skin(
    name: 'Copper Stage',
    shell: Color(0xFF2A1E1A),
    paper: Color(0xFFFCF3EA),
    panel: Color(0xFFFFFFFF),
    ink: Color(0xFF43342D),
    muted: Color(0xFF8D7A6E),
    primary: Color(0xFFC36A33),
    secondary: Color(0xFF2F87A8),
    tertiary: Color(0xFFA38A1E),
  ),
];

class _DemoEvent {
  const _DemoEvent({required this.time, required this.message});

  final String time;
  final String message;
}

class _RenderSliverFloatingPinnedPersistentHeaderDeepDemo extends StatefulWidget {
  const _RenderSliverFloatingPinnedPersistentHeaderDeepDemo();

  @override
  State<_RenderSliverFloatingPinnedPersistentHeaderDeepDemo> createState() =>
      _RenderSliverFloatingPinnedPersistentHeaderDeepDemoState();
}

class _RenderSliverFloatingPinnedPersistentHeaderDeepDemoState
    extends State<_RenderSliverFloatingPinnedPersistentHeaderDeepDemo> {
  _Scene _scene = _Scene.primer;
  int _skinIndex = 0;
  final List<_DemoEvent> _events = <_DemoEvent>[];

  _Skin get _skin => _skins[_skinIndex % _skins.length];

  void _log(String message) {
    final now = DateTime.now();
    final stamp =
        '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
    setState(() {
      _events.insert(0, _DemoEvent(time: stamp, message: message));
      if (_events.length > 120) {
        _events.removeLast();
      }
    });
  }

  String _sceneTitle(_Scene scene) {
    switch (scene) {
      case _Scene.primer:
        return 'Primer';
      case _Scene.comparator:
        return 'Comparator';
      case _Scene.dynamics:
        return 'Dynamics';
      case _Scene.layered:
        return 'Layered';
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
      case _Scene.comparator:
        return Icons.compare_arrows;
      case _Scene.dynamics:
        return Icons.speed;
      case _Scene.layered:
        return Icons.layers_outlined;
      case _Scene.practical:
        return Icons.widgets_outlined;
      case _Scene.compendium:
        return Icons.verified_outlined;
    }
  }

  Widget _buildSceneBody() {
    switch (_scene) {
      case _Scene.primer:
        return _PrimerScene(skin: _skin, log: _log);
      case _Scene.comparator:
        return _ComparatorScene(skin: _skin, log: _log);
      case _Scene.dynamics:
        return _DynamicsScene(skin: _skin, log: _log);
      case _Scene.layered:
        return _LayeredScene(skin: _skin, log: _log);
      case _Scene.practical:
        return _PracticalScene(skin: _skin, log: _log);
      case _Scene.compendium:
        return _CompendiumScene(skin: _skin, events: _events);
    }
  }

  @override
  void initState() {
    super.initState();
    _log('Demo initialized');
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
            'RenderSliverFloatingPinnedPersistentHeader - ${_sceneTitle(_scene)}',
            style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              tooltip: 'Cycle skin',
              onPressed: () {
                setState(() {
                  _skinIndex = (_skinIndex + 1) % _skins.length;
                });
                _log('Skin -> ${_skins[_skinIndex].name}');
              },
              icon: const Icon(Icons.palette_outlined),
            ),
          ],
        ),
        body: _buildSceneBody(),
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
  const _PrimerScene({required this.skin, required this.log});

  final _Skin skin;
  final void Function(String) log;

  @override
  State<_PrimerScene> createState() => _PrimerSceneState();
}

class _PrimerSceneState extends State<_PrimerScene> {
  double _minExtent = 64;
  double _maxExtent = 172;
  bool _pinned = true;
  bool _floating = true;
  bool _showMeter = true;

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    return Column(
      children: [
        _TopInfoPanel(
          skin: skin,
          title: 'Primer Stage',
          subtitle:
              'Use the controls to adjust extents and flags. Scroll the lab below to feel how pinned+floating behaves.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _SwitchTile(
                      skin: skin,
                      label: 'pinned',
                      value: _pinned,
                      onChanged: (value) {
                        setState(() => _pinned = value);
                        widget.log('Primer pinned -> $value');
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SwitchTile(
                      skin: skin,
                      label: 'floating',
                      value: _floating,
                      onChanged: (value) {
                        setState(() => _floating = value);
                        widget.log('Primer floating -> $value');
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SwitchTile(
                      skin: skin,
                      label: 'show meter',
                      value: _showMeter,
                      onChanged: (value) {
                        setState(() => _showMeter = value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              _LabeledSlider(
                skin: skin,
                label: 'minExtent',
                value: _minExtent,
                min: 48,
                max: 110,
                onChanged: (value) {
                  setState(() {
                    _minExtent = value;
                    if (_maxExtent < _minExtent + 20) {
                      _maxExtent = _minExtent + 20;
                    }
                  });
                },
              ),
              _LabeledSlider(
                skin: skin,
                label: 'maxExtent',
                value: _maxExtent,
                min: 120,
                max: 260,
                onChanged: (value) {
                  setState(() {
                    _maxExtent = value;
                    if (_minExtent > _maxExtent - 20) {
                      _minExtent = _maxExtent - 20;
                    }
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: _FramedSurface(
            skin: skin,
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                    child: Text(
                      'Scroll downward to collapse the header. Reverse direction to test floating behavior. '
                      'When both pinned and floating are enabled, the header remains anchored when collapsed and '
                      'also responds rapidly on reverse scroll.',
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.45,
                        color: skin.ink,
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: _pinned,
                  floating: _floating,
                  delegate: _PrimerHeaderDelegate(
                    minExtentValue: _minExtent,
                    maxExtentValue: _maxExtent,
                    skin: skin,
                    showMeter: _showMeter,
                  ),
                ),
                SliverList.builder(
                  itemCount: 24,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: skin.panel,
                        border: Border.all(color: skin.muted.withAlpha(45)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: skin.primary.withAlpha(35),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: skin.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Primer item ${index + 1} - good place for section content beneath a floating+pinned header.',
                              style: TextStyle(fontSize: 12, color: skin.ink),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 18)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PrimerHeaderDelegate extends SliverPersistentHeaderDelegate {
  _PrimerHeaderDelegate({
    required this.minExtentValue,
    required this.maxExtentValue,
    required this.skin,
    required this.showMeter,
  });

  final double minExtentValue;
  final double maxExtentValue;
  final _Skin skin;
  final bool showMeter;

  @override
  double get minExtent => minExtentValue;

  @override
  double get maxExtent => maxExtentValue;

  @override
  bool shouldRebuild(covariant _PrimerHeaderDelegate oldDelegate) {
    return oldDelegate.minExtentValue != minExtentValue ||
        oldDelegate.maxExtentValue != maxExtentValue ||
        oldDelegate.skin != skin ||
        oldDelegate.showMeter != showMeter;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final range = (maxExtent - minExtent).clamp(1, 2000);
    final t = (shrinkOffset / range).clamp(0.0, 1.0);
    final bg = Color.lerp(skin.primary.withAlpha(210), skin.secondary.withAlpha(220), t)!;
    final titleSize = lerpDouble(18, 14, t)!;
    final subtitleOpacity = lerpDouble(1, 0.35, t)!;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: skin.primary.withAlpha(40),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: lerpDouble(44, 34, t),
            height: lerpDouble(44, 34, t),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(45),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(Icons.push_pin_outlined, color: Colors.white, size: lerpDouble(22, 18, t)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Floating + Pinned Header',
                  style: TextStyle(
                    fontSize: titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Opacity(
                  opacity: subtitleOpacity,
                  child: Text(
                    'collapse ${(t * 100).toStringAsFixed(0)}%  ·  overlaps=$overlapsContent',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showMeter)
            SizedBox(
              width: 48,
              child: Column(
                children: [
                  SizedBox(
                    width: 38,
                    height: 38,
                    child: CircularProgressIndicator(
                      value: t,
                      strokeWidth: 4,
                      backgroundColor: Colors.white.withAlpha(40),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${(t * 100).round()}%',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Scene 2: Comparator
// -----------------------------------------------------------------------------

class _ComparatorScene extends StatelessWidget {
  const _ComparatorScene({required this.skin, required this.log});

  final _Skin skin;
  final void Function(String) log;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _TopInfoPanel(
          skin: skin,
          title: 'Behavior Comparator',
          subtitle:
              'These three labs use the same content but different pinned/floating flags. Scroll each independently.',
        ),
        const SizedBox(height: 10),
        _ComparatorCard(
          skin: skin,
          title: 'Pinned Only',
          pinned: true,
          floating: false,
          color: skin.secondary,
          onLog: (msg) => log('Pinned only - $msg'),
        ),
        const SizedBox(height: 12),
        _ComparatorCard(
          skin: skin,
          title: 'Floating Only',
          pinned: false,
          floating: true,
          color: skin.tertiary,
          onLog: (msg) => log('Floating only - $msg'),
        ),
        const SizedBox(height: 12),
        _ComparatorCard(
          skin: skin,
          title: 'Floating + Pinned',
          pinned: true,
          floating: true,
          color: skin.primary,
          onLog: (msg) => log('Floating+pinned - $msg'),
        ),
        const SizedBox(height: 16),
        _ChecklistPanel(
          skin: skin,
          title: 'What to Observe',
          points: const [
            'Pinned only: header stays visible but does not glide back early.',
            'Floating only: header can disappear fully, then re-enter quickly on reverse.',
            'Floating+pinned: always reachable when collapsed and still quick on reverse.',
            'All three use SliverPersistentHeader; behavior changes only by flags.',
          ],
        ),
      ],
    );
  }
}

class _ComparatorCard extends StatefulWidget {
  const _ComparatorCard({
    required this.skin,
    required this.title,
    required this.pinned,
    required this.floating,
    required this.color,
    required this.onLog,
  });

  final _Skin skin;
  final String title;
  final bool pinned;
  final bool floating;
  final Color color;
  final void Function(String) onLog;

  @override
  State<_ComparatorCard> createState() => _ComparatorCardState();
}

class _ComparatorCardState extends State<_ComparatorCard> {
  final ScrollController _controller = ScrollController();
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final current = _controller.offset;
      if (current < _lastOffset && current > 30) {
        widget.onLog('reverse scroll at ${_controller.offset.toStringAsFixed(0)}px');
      }
      _lastOffset = current;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    return Container(
      decoration: BoxDecoration(
        color: skin.panel,
        border: Border.all(color: skin.muted.withAlpha(45)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: skin.ink,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.color.withAlpha(28),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'pinned=${widget.pinned}  floating=${widget.floating}',
                    style: TextStyle(fontSize: 10.5, color: widget.color, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 240,
            child: CustomScrollView(
              controller: _controller,
              slivers: [
                SliverPersistentHeader(
                  pinned: widget.pinned,
                  floating: widget.floating,
                  delegate: _CompactHeaderDelegate(
                    skin: skin,
                    color: widget.color,
                    title: widget.title,
                  ),
                ),
                SliverList.builder(
                  itemCount: 18,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(10, 6, 10, 0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: skin.paper,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: skin.muted.withAlpha(30)),
                      ),
                      child: Text(
                        'Row ${index + 1} in ${widget.title}',
                        style: TextStyle(fontSize: 11.5, color: skin.ink),
                      ),
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _controller.animateTo(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                      );
                    },
                    child: const Text('Jump Top'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _controller.animateTo(
                        _controller.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 550),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Jump Bottom'),
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

class _CompactHeaderDelegate extends SliverPersistentHeaderDelegate {
  _CompactHeaderDelegate({
    required this.skin,
    required this.color,
    required this.title,
  });

  final _Skin skin;
  final Color color;
  final String title;

  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 110;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final bg = Color.lerp(color.withAlpha(215), color.withAlpha(245), t)!;

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 6, 10, 0),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Container(
            width: lerpDouble(34, 28, t),
            height: lerpDouble(34, 28, t),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(42),
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: lerpDouble(13.5, 11.5, t),
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            'collapse ${(t * 100).round()}%',
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _CompactHeaderDelegate oldDelegate) {
    return oldDelegate.skin != skin || oldDelegate.color != color || oldDelegate.title != title;
  }
}

// -----------------------------------------------------------------------------
// Scene 3: Dynamics
// -----------------------------------------------------------------------------

class _DynamicsScene extends StatefulWidget {
  const _DynamicsScene({required this.skin, required this.log});

  final _Skin skin;
  final void Function(String) log;

  @override
  State<_DynamicsScene> createState() => _DynamicsSceneState();
}

class _DynamicsSceneState extends State<_DynamicsScene> {
  final ScrollController _controller = ScrollController();

  bool _useAppBarMode = false;
  bool _snap = true;
  double _expandedHeight = 200;
  double _minHeight = 72;
  double _speedFactor = 1.0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    return Column(
      children: [
        _TopInfoPanel(
          skin: skin,
          title: 'Dynamics Studio',
          subtitle:
              'Switch between delegate mode and SliverAppBar mode. Trigger scroll macros to observe rapid re-entry behavior.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _SwitchTile(
                      skin: skin,
                      label: 'Use SliverAppBar mode',
                      value: _useAppBarMode,
                      onChanged: (value) {
                        setState(() => _useAppBarMode = value);
                        widget.log('Dynamics mode -> ${value ? 'appbar' : 'delegate'}');
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _SwitchTile(
                      skin: skin,
                      label: 'snap',
                      value: _snap,
                      onChanged: (value) {
                        setState(() => _snap = value);
                        widget.log('Dynamics snap -> $value');
                      },
                    ),
                  ),
                ],
              ),
              _LabeledSlider(
                skin: skin,
                label: 'expandedHeight',
                value: _expandedHeight,
                min: 130,
                max: 280,
                onChanged: (value) {
                  setState(() => _expandedHeight = value);
                },
              ),
              _LabeledSlider(
                skin: skin,
                label: 'minHeight',
                value: _minHeight,
                min: 56,
                max: 110,
                onChanged: (value) {
                  setState(() => _minHeight = value);
                },
              ),
              _LabeledSlider(
                skin: skin,
                label: 'macro speed',
                value: _speedFactor,
                min: 0.4,
                max: 2.0,
                onChanged: (value) {
                  setState(() => _speedFactor = value);
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: _macroCollapseThenPeek,
                      child: const Text('Macro: collapse then peek'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: _macroBounce,
                      child: const Text('Macro: bounce'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: _FramedSurface(
            skin: skin,
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: CustomScrollView(
              controller: _controller,
              slivers: [
                if (_useAppBarMode)
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: _snap,
                    expandedHeight: _expandedHeight,
                    collapsedHeight: _minHeight,
                    backgroundColor: skin.primary,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 14),
                      title: const Text('SliverAppBar mode', style: TextStyle(fontSize: 13)),
                      background: _GradientBackdrop(
                        primary: skin.primary,
                        secondary: skin.secondary,
                      ),
                    ),
                  )
                else
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _DynamicsHeaderDelegate(
                      skin: skin,
                      minExtentValue: _minHeight,
                      maxExtentValue: _expandedHeight,
                      snapHint: _snap,
                    ),
                  ),
                SliverList.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: skin.panel,
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: skin.muted.withAlpha(40)),
                      ),
                      child: Text(
                        'Dynamics item ${index + 1} - scroll rhythm sample',
                        style: TextStyle(fontSize: 12, color: skin.ink),
                      ),
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 18)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _macroCollapseThenPeek() async {
    if (!_controller.hasClients) return;
    widget.log('Macro collapse+peek started');
    await _controller.animateTo(
      math.min(_controller.position.maxScrollExtent, 560),
      duration: Duration(milliseconds: (600 / _speedFactor).round()),
      curve: Curves.easeInOut,
    );
    await _controller.animateTo(
      math.max(0, _controller.offset - 90),
      duration: Duration(milliseconds: (260 / _speedFactor).round()),
      curve: Curves.easeOutCubic,
    );
    widget.log('Macro collapse+peek completed');
  }

  Future<void> _macroBounce() async {
    if (!_controller.hasClients) return;
    widget.log('Macro bounce started');
    await _controller.animateTo(
      math.min(_controller.position.maxScrollExtent, 420),
      duration: Duration(milliseconds: (360 / _speedFactor).round()),
      curve: Curves.easeIn,
    );
    await _controller.animateTo(
      math.min(_controller.position.maxScrollExtent, 700),
      duration: Duration(milliseconds: (260 / _speedFactor).round()),
      curve: Curves.linear,
    );
    await _controller.animateTo(
      math.max(0, _controller.offset - 240),
      duration: Duration(milliseconds: (330 / _speedFactor).round()),
      curve: Curves.easeOut,
    );
    widget.log('Macro bounce completed');
  }
}

class _DynamicsHeaderDelegate extends SliverPersistentHeaderDelegate {
  _DynamicsHeaderDelegate({
    required this.skin,
    required this.minExtentValue,
    required this.maxExtentValue,
    required this.snapHint,
  });

  final _Skin skin;
  final double minExtentValue;
  final double maxExtentValue;
  final bool snapHint;

  @override
  double get minExtent => minExtentValue;

  @override
  double get maxExtent => maxExtentValue;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final ratio = (shrinkOffset / (maxExtent - minExtent).clamp(1, 2000)).clamp(0.0, 1.0);
    final titleSize = lerpDouble(19, 13.5, ratio)!;
    final round = lerpDouble(16, 10, ratio)!;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [skin.primary, skin.secondary],
        ),
        borderRadius: BorderRadius.circular(round),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(Icons.animation_outlined, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Dynamic Header Lab',
                  style: TextStyle(
                    fontSize: titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                'snapHint=$snapHint',
                style: const TextStyle(fontSize: 11, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Opacity(
            opacity: lerpDouble(1, 0.4, ratio)!,
            child: Text(
              'collapse ${(ratio * 100).toStringAsFixed(0)}%   overlaps=$overlapsContent',
              style: const TextStyle(fontSize: 11, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _DynamicsHeaderDelegate oldDelegate) {
    return oldDelegate.skin != skin ||
        oldDelegate.minExtentValue != minExtentValue ||
        oldDelegate.maxExtentValue != maxExtentValue ||
        oldDelegate.snapHint != snapHint;
  }
}

class _GradientBackdrop extends StatelessWidget {
  const _GradientBackdrop({required this.primary, required this.secondary});

  final Color primary;
  final Color secondary;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MeshPainter(primary: primary, secondary: secondary),
      child: const SizedBox.expand(),
    );
  }
}

class _MeshPainter extends CustomPainter {
  _MeshPainter({required this.primary, required this.secondary});

  final Color primary;
  final Color secondary;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [primary.withAlpha(210), secondary.withAlpha(210)],
      ).createShader(rect);
    canvas.drawRect(rect, paint);

    final overlay = Paint()..color = Colors.white.withAlpha(24);
    for (double x = -size.height; x < size.width + size.height; x += 22) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), overlay);
    }
  }

  @override
  bool shouldRepaint(covariant _MeshPainter oldDelegate) {
    return oldDelegate.primary != primary || oldDelegate.secondary != secondary;
  }
}

// -----------------------------------------------------------------------------
// Scene 4: Layered
// -----------------------------------------------------------------------------

class _LayeredScene extends StatefulWidget {
  const _LayeredScene({required this.skin, required this.log});

  final _Skin skin;
  final void Function(String) log;

  @override
  State<_LayeredScene> createState() => _LayeredSceneState();
}

class _LayeredSceneState extends State<_LayeredScene> {
  bool _showA = true;
  bool _showB = true;
  bool _showC = true;

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    return Column(
      children: [
        _TopInfoPanel(
          skin: skin,
          title: 'Layered Headers Theater',
          subtitle:
              'Multiple floating+pinned headers can coexist. Toggle layers and observe stack transitions while scrolling.',
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Row(
            children: [
              Expanded(
                child: _SwitchTile(
                  skin: skin,
                  label: 'Header A',
                  value: _showA,
                  onChanged: (value) {
                    setState(() => _showA = value);
                    widget.log('Layer A -> $value');
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _SwitchTile(
                  skin: skin,
                  label: 'Header B',
                  value: _showB,
                  onChanged: (value) {
                    setState(() => _showB = value);
                    widget.log('Layer B -> $value');
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _SwitchTile(
                  skin: skin,
                  label: 'Header C',
                  value: _showC,
                  onChanged: (value) {
                    setState(() => _showC = value);
                    widget.log('Layer C -> $value');
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _FramedSurface(
            skin: skin,
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: skin.paper,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: skin.muted.withAlpha(35)),
                    ),
                    child: Text(
                      'This section intentionally stacks three independent delegates. '
                      'Each is configured with pinned=true, floating=true and unique extents.',
                      style: TextStyle(fontSize: 12.3, color: skin.ink),
                    ),
                  ),
                ),
                if (_showA)
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _LayerHeaderDelegate(
                      skin: skin,
                      color: skin.primary,
                      title: 'Layer A - Global Actions',
                      min: 54,
                      max: 118,
                      icon: Icons.dashboard_outlined,
                    ),
                  ),
                if (_showB)
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _LayerHeaderDelegate(
                      skin: skin,
                      color: skin.secondary,
                      title: 'Layer B - Section Filters',
                      min: 50,
                      max: 102,
                      icon: Icons.filter_alt_outlined,
                    ),
                  ),
                if (_showC)
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _LayerHeaderDelegate(
                      skin: skin,
                      color: skin.tertiary,
                      title: 'Layer C - Metrics Strip',
                      min: 46,
                      max: 96,
                      icon: Icons.query_stats_outlined,
                    ),
                  ),
                SliverList.builder(
                  itemCount: 34,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: skin.panel,
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(color: skin.muted.withAlpha(32)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: skin.primary.withAlpha(22),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: skin.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Layered content row ${index + 1}',
                              style: TextStyle(fontSize: 12, color: skin.ink),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LayerHeaderDelegate extends SliverPersistentHeaderDelegate {
  _LayerHeaderDelegate({
    required this.skin,
    required this.color,
    required this.title,
    required this.min,
    required this.max,
    required this.icon,
  });

  final _Skin skin;
  final Color color;
  final String title;
  final double min;
  final double max;
  final IconData icon;

  @override
  double get minExtent => min;

  @override
  double get maxExtent => max;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final t = (shrinkOffset / (maxExtent - minExtent).clamp(1, 2000)).clamp(0.0, 1.0);
    final radius = lerpDouble(10, 7, t)!;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      decoration: BoxDecoration(
        color: color.withAlpha(220),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        children: [
          Icon(icon, size: lerpDouble(18, 15, t), color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: lerpDouble(13, 11.2, t),
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            overlapsContent ? 'overlap' : 'clear',
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _LayerHeaderDelegate oldDelegate) {
    return oldDelegate.skin != skin ||
        oldDelegate.color != color ||
        oldDelegate.title != title ||
        oldDelegate.min != min ||
        oldDelegate.max != max ||
        oldDelegate.icon != icon;
  }
}

// -----------------------------------------------------------------------------
// Scene 5: Practical
// -----------------------------------------------------------------------------

class _PracticalScene extends StatefulWidget {
  const _PracticalScene({required this.skin, required this.log});

  final _Skin skin;
  final void Function(String) log;

  @override
  State<_PracticalScene> createState() => _PracticalSceneState();
}

class _PracticalSceneState extends State<_PracticalScene> {
  final Set<String> _activeTags = <String>{'alpha'};
  int _segment = 0;

  static const _tags = <String>['alpha', 'beta', 'gamma', 'delta'];

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _TopInfoPanel(
          skin: skin,
          title: 'Practical Patterns',
          subtitle:
              'Three realistic uses: feed filters, timeline day markers, and status strip controls.',
        ),
        const SizedBox(height: 12),

        _SceneCard(
          skin: skin,
          title: 'A) Feed with Sticky+Floating Filter Bar',
          child: SizedBox(
            height: 360,
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _FilterHeaderDelegate(
                    skin: skin,
                    segment: _segment,
                    activeTags: _activeTags,
                    onSegmentChanged: (value) {
                      setState(() => _segment = value);
                      widget.log('Feed segment -> $value');
                    },
                    onTagToggle: (tag) {
                      setState(() {
                        if (_activeTags.contains(tag)) {
                          _activeTags.remove(tag);
                        } else {
                          _activeTags.add(tag);
                        }
                      });
                      widget.log('Tag toggle -> $tag');
                    },
                  ),
                ),
                SliverList.builder(
                  itemCount: 22,
                  itemBuilder: (context, index) {
                    final tag = _tags[index % _tags.length];
                    final visible = _activeTags.isEmpty || _activeTags.contains(tag);
                    if (!visible) {
                      return const SizedBox.shrink();
                    }
                    return Container(
                      margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: skin.panel,
                        border: Border.all(color: skin.muted.withAlpha(32)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: skin.secondary.withAlpha(24),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tag,
                              style: TextStyle(fontSize: 10.5, color: skin.secondary, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Feed card ${index + 1} in segment $_segment',
                              style: TextStyle(fontSize: 11.8, color: skin.ink),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        _SceneCard(
          skin: skin,
          title: 'B) Timeline with Day Headers',
          child: SizedBox(
            height: 320,
            child: CustomScrollView(
              slivers: [
                for (int day = 0; day < 4; day++) ...[
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _DayHeaderDelegate(
                      skin: skin,
                      dayLabel: 'Day ${day + 1}',
                      accent: Color.lerp(skin.primary, skin.secondary, day / 3)!,
                    ),
                  ),
                  SliverList.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: skin.panel,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: skin.muted.withAlpha(30)),
                        ),
                        child: Text(
                          'Timeline event ${(day * 5) + index + 1}',
                          style: TextStyle(fontSize: 11.8, color: skin.ink),
                        ),
                      );
                    },
                  ),
                ],
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        _SceneCard(
          skin: skin,
          title: 'C) Status Strip + Operations',
          child: SizedBox(
            height: 300,
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _StatusStripDelegate(skin: skin),
                ),
                SliverList.builder(
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: skin.panel,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: skin.muted.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.task_alt, size: 14, color: skin.secondary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Operation log item ${index + 1}',
                              style: TextStyle(fontSize: 11.8, color: skin.ink),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  _FilterHeaderDelegate({
    required this.skin,
    required this.segment,
    required this.activeTags,
    required this.onSegmentChanged,
    required this.onTagToggle,
  });

  final _Skin skin;
  final int segment;
  final Set<String> activeTags;
  final void Function(int) onSegmentChanged;
  final void Function(String) onTagToggle;

  static const _tags = <String>['alpha', 'beta', 'gamma', 'delta'];

  @override
  double get minExtent => 74;

  @override
  double get maxExtent => 128;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final bg = Color.lerp(skin.primary, skin.secondary, t)!;
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 6, 10, 0),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Feed Filters',
                  style: TextStyle(
                    fontSize: lerpDouble(13.5, 12, t),
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SegmentedButton<int>(
                showSelectedIcon: false,
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
                  backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.white.withAlpha(55);
                    }
                    return Colors.white.withAlpha(20);
                  }),
                ),
                segments: const [
                  ButtonSegment<int>(value: 0, label: Text('All')),
                  ButtonSegment<int>(value: 1, label: Text('Live')),
                  ButtonSegment<int>(value: 2, label: Text('Saved')),
                ],
                selected: {segment},
                onSelectionChanged: (set) => onSegmentChanged(set.first),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _tags.map((tag) {
              final selected = activeTags.contains(tag);
              return GestureDetector(
                onTap: () => onTagToggle(tag),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: selected ? Colors.white.withAlpha(60) : Colors.white.withAlpha(24),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(fontSize: 10.5, color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _FilterHeaderDelegate oldDelegate) {
    return oldDelegate.skin != skin ||
        oldDelegate.segment != segment ||
        oldDelegate.activeTags != activeTags;
  }
}

class _DayHeaderDelegate extends SliverPersistentHeaderDelegate {
  _DayHeaderDelegate({
    required this.skin,
    required this.dayLabel,
    required this.accent,
  });

  final _Skin skin;
  final String dayLabel;
  final Color accent;

  @override
  double get minExtent => 44;

  @override
  double get maxExtent => 76;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 6, 10, 0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: accent.withAlpha(220),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today_outlined, size: lerpDouble(15, 13, t), color: Colors.white),
          const SizedBox(width: 8),
          Text(
            dayLabel,
            style: TextStyle(
              fontSize: lerpDouble(12.5, 11, t),
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            overlapsContent ? 'active' : 'rest',
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _DayHeaderDelegate oldDelegate) {
    return oldDelegate.skin != skin || oldDelegate.dayLabel != dayLabel || oldDelegate.accent != accent;
  }
}

class _StatusStripDelegate extends SliverPersistentHeaderDelegate {
  _StatusStripDelegate({required this.skin});

  final _Skin skin;

  @override
  double get minExtent => 52;

  @override
  double get maxExtent => 92;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 6, 10, 0),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [skin.secondary, skin.primary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Status Strip',
              style: TextStyle(
                fontSize: lerpDouble(14, 12, t),
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          _Badge(label: 'OK', color: Colors.white.withAlpha(50)),
          const SizedBox(width: 6),
          _Badge(label: '14 Tasks', color: Colors.white.withAlpha(50)),
          const SizedBox(width: 6),
          _Badge(label: '3 Alerts', color: Colors.white.withAlpha(50)),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _StatusStripDelegate oldDelegate) {
    return oldDelegate.skin != skin;
  }
}

// -----------------------------------------------------------------------------
// Scene 6: Compendium
// -----------------------------------------------------------------------------

class _CompendiumScene extends StatelessWidget {
  const _CompendiumScene({required this.skin, required this.events});

  final _Skin skin;
  final List<_DemoEvent> events;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _TopInfoPanel(
          skin: skin,
          title: 'Verification Compendium',
          subtitle:
              'Summary of all scenarios covered for RenderSliverFloatingPinnedPersistentHeader behavior.',
        ),
        const SizedBox(height: 10),
        _ChecklistPanel(
          skin: skin,
          title: 'Behavior Coverage',
          points: const [
            'Pinned and floating toggles with live preview',
            'Header collapse interpolation with extent controls',
            'Three-way comparator: pinned, floating, and combined',
            'Reverse-scroll quick re-entry observation',
            'SliverAppBar floating+pinned mode comparison',
            'Layered multi-header stack behavior',
            'Feed filter bar practical pattern',
            'Timeline day headers practical pattern',
            'Status strip operations pattern',
            'Runtime timeline log of interactions',
          ],
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'API Mapping Notes',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ApiRow(skin: skin, left: 'Widget', right: 'SliverPersistentHeader'),
              _ApiRow(skin: skin, left: 'Flags', right: 'pinned: true, floating: true'),
              _ApiRow(skin: skin, left: 'Delegate', right: 'SliverPersistentHeaderDelegate'),
              _ApiRow(skin: skin, left: 'Render class', right: 'RenderSliverFloatingPinnedPersistentHeader'),
              _ApiRow(skin: skin, left: 'Behavior', right: 'stays anchored and re-enters quickly'),
              _ApiRow(skin: skin, left: 'Typical uses', right: 'filters, section controls, quick actions'),
              const SizedBox(height: 8),
              Text(
                'Note: This render class is not instantiated directly in app code. '
                'You exercise it through sliver widgets that configure pinned+floating semantics.',
                style: TextStyle(fontSize: 12, height: 1.45, color: skin.ink),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _SceneCard(
          skin: skin,
          title: 'Event Timeline',
          child: events.isEmpty
              ? Text('No events yet', style: TextStyle(fontSize: 12, color: skin.muted))
              : Column(
                  children: events
                      .take(60)
                      .map(
                        (event) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 62,
                                child: Text(
                                  event.time,
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 10.5,
                                    color: skin.muted,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  event.message,
                                  style: TextStyle(fontSize: 11.5, color: skin.ink),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Shared mini-widgets
// -----------------------------------------------------------------------------

class _TopInfoPanel extends StatelessWidget {
  const _TopInfoPanel({
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
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: skin.panel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: skin.muted.withAlpha(42)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: skin.ink),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12.3, height: 1.45, color: skin.muted),
          ),
        ],
      ),
    );
  }
}

class _FramedSurface extends StatelessWidget {
  const _FramedSurface({
    required this.skin,
    required this.child,
    required this.margin,
  });

  final _Skin skin;
  final Widget child;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: skin.panel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: skin.muted.withAlpha(45)),
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
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
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 8, 6),
      decoration: BoxDecoration(
        color: skin.panel,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: skin.muted.withAlpha(45)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 11.5, color: skin.ink, fontWeight: FontWeight.w600),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: skin.primary,
          ),
        ],
      ),
    );
  }
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
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
          width: 96,
          child: Text(
            label,
            style: TextStyle(fontSize: 11.5, color: skin.ink),
          ),
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
          width: 54,
          child: Text(
            value.toStringAsFixed(0),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: skin.muted,
            ),
          ),
        ),
      ],
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
      padding: const EdgeInsets.all(12),
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
            style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: skin.ink),
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
                    child: Text(
                      point,
                      style: TextStyle(fontSize: 11.7, color: skin.ink),
                    ),
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

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({
    required this.skin,
    required this.left,
    required this.right,
  });

  final _Skin skin;
  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              left,
              style: TextStyle(fontSize: 11.5, color: skin.muted, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              right,
              style: TextStyle(fontSize: 11.8, color: skin.ink),
            ),
          ),
        ],
      ),
    );
  }
}
