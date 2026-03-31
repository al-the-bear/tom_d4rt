import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const _cNavy = Color(0xFF1E4E75);
const _cAmber = Color(0xFFC57B35);
const _cTeal = Color(0xFF277E71);
const _cRose = Color(0xFF92466A);
const _cIndigo = Color(0xFF5653A0);
const _cOlive = Color(0xFF6B682D);

dynamic build(BuildContext context) {
  return const _GestureDetectorAdvancedDeepDemoApp();
}

class _GestureDetectorAdvancedDeepDemoApp extends StatelessWidget {
  const _GestureDetectorAdvancedDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _cNavy),
      ),
      home: const _GestureDeepDemoPage(),
    );
  }
}

class _GestureDeepDemoPage extends StatefulWidget {
  const _GestureDeepDemoPage();

  @override
  State<_GestureDeepDemoPage> createState() => _GestureDeepDemoPageState();
}

class _GestureDeepDemoPageState extends State<_GestureDeepDemoPage> {
  bool _rtl = false;
  bool _compact = false;
  bool _showGrid = true;

  HitTestBehavior _behavior = HitTestBehavior.deferToChild;

  @override
  Widget build(BuildContext context) {
    final config = _GlobalGestureConfig(
      compact: _compact,
      showGrid: _showGrid,
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      behavior: _behavior,
    );

    return Directionality(
      textDirection: config.textDirection,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F5F8),
        appBar: AppBar(
          backgroundColor: _cNavy,
          foregroundColor: Colors.white,
          toolbarHeight: 78,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Gesture Detector Advanced Deep Demo'),
              const SizedBox(height: 2),
              Text(
                _rtl ? 'Ambient direction: RTL' : 'Ambient direction: LTR',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroDeck(
                rtl: _rtl,
                compact: _compact,
                showGrid: _showGrid,
                behavior: _behavior,
                onRtlChanged: (value) => setState(() => _rtl = value),
                onCompactChanged: (value) => setState(() => _compact = value),
                onShowGridChanged: (value) => setState(() => _showGrid = value),
                onBehaviorChanged: (value) => setState(() => _behavior = value),
              ),
              const SizedBox(height: 12),
              const _ScenePanel(
                index: 1,
                accent: _cNavy,
                title: 'Concepts: Arena, Recognizers, and Dispatch',
                subtitle:
                    'GestureDetector wires recognizers that compete in the gesture arena; Listener reports raw pointer streams beneath gesture abstraction.',
                child: _ConceptScene(),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 2,
                accent: _cAmber,
                title: 'Parent/Child Arena and HitTestBehavior',
                subtitle:
                    'Nested GestureDetector instances show arena competition and how behavior changes participation in hit testing.',
                child: _ArenaScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 3,
                accent: _cTeal,
                title: 'Pan vs Scale Recognizer Lab',
                subtitle:
                    'Demonstrates choosing pan-only or scale recognizers and visualizing resulting drag/zoom telemetry.',
                child: _PanScaleScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 4,
                accent: _cRose,
                title: 'Long Press Callback Timeline',
                subtitle:
                    'Shows onLongPressDown/start/moveUpdate/up/end/cancel sequencing with live path feedback.',
                child: _LongPressTimelineScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 5,
                accent: _cIndigo,
                title: 'RawGestureDetector Factory Wiring',
                subtitle:
                    'Custom gesture map with GestureRecognizerFactoryWithHandlers demonstrates low-level recognizer configuration.',
                child: _RawGestureFactoryScene(config: config),
              ),
              const SizedBox(height: 12),
              _ScenePanel(
                index: 6,
                accent: _cOlive,
                title: 'Pointer Events and Practical Board Pattern',
                subtitle:
                    'Combines Listener pointer streams with practical card interactions (tap, double-tap, long-press, pan) in one UI.',
                child: _PointerAndPracticalScene(config: config),
              ),
              const SizedBox(height: 12),
              const _RecapCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlobalGestureConfig {
  const _GlobalGestureConfig({
    required this.compact,
    required this.showGrid,
    required this.textDirection,
    required this.behavior,
  });

  final bool compact;
  final bool showGrid;
  final TextDirection textDirection;
  final HitTestBehavior behavior;
}

class _HeroDeck extends StatelessWidget {
  const _HeroDeck({
    required this.rtl,
    required this.compact,
    required this.showGrid,
    required this.behavior,
    required this.onRtlChanged,
    required this.onCompactChanged,
    required this.onShowGridChanged,
    required this.onBehaviorChanged,
  });

  final bool rtl;
  final bool compact;
  final bool showGrid;
  final HitTestBehavior behavior;

  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onShowGridChanged;
  final ValueChanged<HitTestBehavior> onBehaviorChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E4E75), Color(0xFF426A87), Color(0xFF724D67)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gesture Lab Control Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 27),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tune global layout and hit testing behavior, then interact with each scenario to inspect recognizer callbacks and pointer flow.',
            style: TextStyle(color: Color(0xFFF3F8FF), fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact cards', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SwitchListTile(
                  value: showGrid,
                  onChanged: onShowGridChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show guide grid', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _BehaviorSelector(value: behavior, onChanged: onBehaviorChanged),
          const SizedBox(height: 10),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _DeckTag(label: 'GestureDetector high-level callbacks'),
              _DeckTag(label: 'RawGestureDetector recognizer map'),
              _DeckTag(label: 'LongPress and pan/scale telemetry'),
              _DeckTag(label: 'Listener raw pointer stream'),
            ],
          ),
        ],
      ),
    );
  }
}

class _BehaviorSelector extends StatelessWidget {
  const _BehaviorSelector({required this.value, required this.onChanged});

  final HitTestBehavior value;
  final ValueChanged<HitTestBehavior> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Global HitTestBehavior', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<HitTestBehavior>(
              value: value,
              isExpanded: true,
              borderRadius: BorderRadius.circular(12),
              dropdownColor: const Color(0xFF3A5E79),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              items: HitTestBehavior.values
                  .map(
                    (entry) => DropdownMenuItem<HitTestBehavior>(
                      value: entry,
                      child: Text(entry.name, style: const TextStyle(color: Colors.white)),
                    ),
                  )
                  .toList(),
              onChanged: (selected) {
                if (selected != null) {
                  onChanged(selected);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _DeckTag extends StatelessWidget {
  const _DeckTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _ScenePanel extends StatelessWidget {
  const _ScenePanel({
    required this.index,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color accent;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 18)),
                      const SizedBox(height: 3),
                      Text(subtitle, style: const TextStyle(height: 1.4, color: Color(0xFF2F3B45))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _ConceptScene extends StatelessWidget {
  const _ConceptScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gesture dispatch model', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        const Text(
          'Raw pointer events are produced first. Recognizers then compete in a gesture arena to claim intent (tap, pan, scale, long press, and others). GestureDetector provides callback conveniences over this recognizer layer.',
          style: TextStyle(height: 1.45),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFD),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDDE5EE)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Bullet(text: 'GestureDetector behavior affects hit testing participation, not parent/child arena precedence.'),
              _Bullet(text: 'Pan and scale callbacks should not both be registered on one GestureDetector.'),
              _Bullet(text: 'RawGestureDetector allows direct map-based recognizer factories.'),
              _Bullet(text: 'Listener is useful when you need raw PointerEvent data regardless of recognizer decisions.'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Wrap(
          spacing: 14,
          runSpacing: 8,
          children: [
            _Legend(color: _cNavy, label: 'Arena resolves competing recognizers'),
            _Legend(color: _cTeal, label: 'Long-press timeline is multi-stage'),
            _Legend(color: _cRose, label: 'Raw + high-level APIs can coexist'),
          ],
        ),
      ],
    );
  }
}

class _ArenaScene extends StatefulWidget {
  const _ArenaScene({required this.config});

  final _GlobalGestureConfig config;

  @override
  State<_ArenaScene> createState() => _ArenaSceneState();
}

class _ArenaSceneState extends State<_ArenaScene> {
  final List<String> _events = <String>[];
  HitTestBehavior _childBehavior = HitTestBehavior.deferToChild;
  int _parentWins = 0;
  int _childWins = 0;

  void _log(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 12) {
        _events.removeRange(12, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _BehaviorSelector(
                value: _childBehavior,
                onChanged: (value) => setState(() => _childBehavior = value),
              ),
            ),
            const SizedBox(width: 8),
            _ActionButton(
              label: 'Clear log',
              color: _cAmber,
              onPressed: () => setState(() {
                _events.clear();
                _parentWins = 0;
                _childWins = 0;
              }),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Parent taps: $_parentWins | Child taps: $_childWins', style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 220 : 280,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Center(
                    child: GestureDetector(
                      behavior: config.behavior,
                      onTapDown: (_) => _log('Parent onTapDown'),
                      onTap: () {
                        _log('Parent onTap won arena');
                        setState(() => _parentWins += 1);
                      },
                      onLongPressStart: (_) => _log('Parent onLongPressStart'),
                      child: Container(
                        width: 320,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDEEAF7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF7890AA), width: 1.2),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Center(
                          child: GestureDetector(
                            behavior: _childBehavior,
                            onTapDown: (_) => _log('Child onTapDown'),
                            onTap: () {
                              _log('Child onTap won arena');
                              setState(() => _childWins += 1);
                            },
                            onLongPress: () => _log('Child onLongPress'),
                            child: Container(
                              width: 170,
                              height: 100,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4DDE7),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFF8C5E72), width: 1.2),
                              ),
                              alignment: Alignment.center,
                              child: const Text('Child target', style: TextStyle(fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(events: _events, title: 'Arena event log')),
            ],
          ),
        ),
      ],
    );
  }
}

class _PanScaleScene extends StatefulWidget {
  const _PanScaleScene({required this.config});

  final _GlobalGestureConfig config;

  @override
  State<_PanScaleScene> createState() => _PanScaleSceneState();
}

class _PanScaleSceneState extends State<_PanScaleScene> {
  bool _scaleMode = false;
  Offset _position = Offset.zero;
  double _zoom = 1;
  final List<String> _events = <String>[];

  void _log(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 12) {
        _events.removeRange(12, _events.length);
      }
    });
  }

  void _reset() {
    setState(() {
      _position = Offset.zero;
      _zoom = 1;
      _events.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: _scaleMode ? 'Mode: Scale' : 'Mode: Pan',
              color: _cTeal,
              onPressed: () {
                setState(() {
                  _scaleMode = !_scaleMode;
                  _position = Offset.zero;
                  _zoom = 1;
                  _events.clear();
                });
              },
            ),
            _ActionButton(label: 'Reset', color: _cAmber, onPressed: _reset),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Offset: (${_position.dx.toStringAsFixed(1)}, ${_position.dy.toStringAsFixed(1)}) | Zoom: ${_zoom.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 220 : 280,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Center(
                    child: GestureDetector(
                      behavior: config.behavior,
                      onPanStart: _scaleMode
                          ? null
                          : (details) => _log('onPanStart at ${details.localPosition.dx.toStringAsFixed(1)}, ${details.localPosition.dy.toStringAsFixed(1)}'),
                      onPanUpdate: _scaleMode
                          ? null
                          : (details) {
                              setState(() => _position += details.delta);
                              _log('onPanUpdate delta ${details.delta.dx.toStringAsFixed(1)}, ${details.delta.dy.toStringAsFixed(1)}');
                            },
                      onPanEnd: _scaleMode ? null : (details) => _log('onPanEnd velocity ${details.velocity.pixelsPerSecond.distance.toStringAsFixed(1)}'),
                      onScaleStart: _scaleMode ? (_) => _log('onScaleStart') : null,
                      onScaleUpdate: _scaleMode
                          ? (details) {
                              setState(() {
                                _zoom = (_zoom * details.scale).clamp(0.5, 2.5);
                                _position += details.focalPointDelta;
                              });
                              _log('onScaleUpdate scale ${details.scale.toStringAsFixed(3)}');
                            }
                          : null,
                      onScaleEnd: _scaleMode ? (_) => _log('onScaleEnd') : null,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 280,
                            height: 180,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7FBFF),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFD8E3EE)),
                            ),
                          ),
                          Transform.translate(
                            offset: _position,
                            child: Transform.scale(
                              scale: _zoom,
                              child: Container(
                                width: 160,
                                height: 96,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD8ECC8),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFF5F7A67), width: 1.2),
                                ),
                                alignment: Alignment.center,
                                child: Text(_scaleMode ? 'Scale target' : 'Pan target', style: const TextStyle(fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(events: _events, title: 'Pan/Scale log')),
            ],
          ),
        ),
      ],
    );
  }
}

class _LongPressTimelineScene extends StatefulWidget {
  const _LongPressTimelineScene({required this.config});

  final _GlobalGestureConfig config;

  @override
  State<_LongPressTimelineScene> createState() => _LongPressTimelineSceneState();
}

class _LongPressTimelineSceneState extends State<_LongPressTimelineScene> {
  final List<String> _events = <String>[];
  final List<Offset> _trail = <Offset>[];

  void _push(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 16) {
        _events.removeRange(16, _events.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ActionButton(
          label: 'Clear timeline',
          color: _cRose,
          onPressed: () => setState(() {
            _events.clear();
            _trail.clear();
          }),
        ),
        const SizedBox(height: 8),
        const Text(
          'Press and hold inside the target, then drag slightly while holding to trigger move updates.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 220 : 290,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Center(
                    child: GestureDetector(
                      behavior: config.behavior,
                      onLongPressDown: (details) => _push('onLongPressDown (${details.localPosition.dx.toStringAsFixed(1)}, ${details.localPosition.dy.toStringAsFixed(1)})'),
                      onLongPressCancel: () => _push('onLongPressCancel'),
                      onLongPressStart: (details) {
                        _push('onLongPressStart');
                        setState(() => _trail.clear());
                        _trail.add(details.localPosition);
                      },
                      onLongPressMoveUpdate: (details) {
                        _push('onLongPressMoveUpdate offset ${details.offsetFromOrigin.distance.toStringAsFixed(1)}');
                        setState(() {
                          _trail.add(details.localPosition);
                          if (_trail.length > 120) {
                            _trail.removeAt(0);
                          }
                        });
                      },
                      onLongPressUp: () => _push('onLongPressUp'),
                      onLongPressEnd: (_) => _push('onLongPressEnd'),
                      child: Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCEFF4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFC689A6), width: 1.2),
                        ),
                        child: CustomPaint(
                          painter: _TrailPainter(points: _trail),
                          child: const Center(
                            child: Text('Long-press and move here', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(events: _events, title: 'Long-press timeline')),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrailPainter extends CustomPainter {
  const _TrailPainter({required this.points});

  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) {
      return;
    }
    final paint = Paint()
      ..color = const Color(0xAA8A325D)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrailPainter oldDelegate) => oldDelegate.points != points;
}

class _RawGestureFactoryScene extends StatefulWidget {
  const _RawGestureFactoryScene({required this.config});

  final _GlobalGestureConfig config;

  @override
  State<_RawGestureFactoryScene> createState() => _RawGestureFactorySceneState();
}

class _RawGestureFactorySceneState extends State<_RawGestureFactoryScene> {
  int _tapCount = 0;
  int _longPressCount = 0;
  int _tapDownCount = 0;
  final List<String> _events = <String>[];

  void _log(String message) {
    setState(() {
      _events.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_events.length > 12) {
        _events.removeRange(12, _events.length);
      }
    });
  }

  Map<Type, GestureRecognizerFactory> _factories() {
    return <Type, GestureRecognizerFactory>{
      TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
        () => TapGestureRecognizer(debugOwner: this),
        (TapGestureRecognizer instance) {
          instance
            ..onTapDown = (_) {
              _log('Raw Tap onTapDown');
              setState(() => _tapDownCount += 1);
            }
            ..onTap = () {
              _log('Raw Tap onTap');
              setState(() => _tapCount += 1);
            };
        },
      ),
      LongPressGestureRecognizer: GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
        () => LongPressGestureRecognizer(debugOwner: this),
        (LongPressGestureRecognizer instance) {
          instance
            ..onLongPressStart = (_) {
              _log('Raw LongPress onLongPressStart');
              setState(() => _longPressCount += 1);
            }
            ..onLongPressEnd = (_) => _log('Raw LongPress onLongPressEnd');
        },
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _ActionButton(
              label: 'Clear counters',
              color: _cIndigo,
              onPressed: () => setState(() {
                _tapCount = 0;
                _longPressCount = 0;
                _tapDownCount = 0;
                _events.clear();
              }),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('TapDown $_tapDownCount | Tap $_tapCount | LongPress $_longPressCount', style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 220 : 280,
          child: Row(
            children: [
              Expanded(
                child: _GuideStage(
                  showGrid: config.showGrid,
                  child: Center(
                    child: RawGestureDetector(
                      behavior: config.behavior,
                      gestures: _factories(),
                      child: Container(
                        width: 300,
                        height: 180,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6E3F8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF7D77A8), width: 1.2),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'RawGestureDetector target\n(tap + long press)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _EventLog(events: _events, title: 'RawGesture event log')),
            ],
          ),
        ),
      ],
    );
  }
}

class _PointerAndPracticalScene extends StatefulWidget {
  const _PointerAndPracticalScene({required this.config});

  final _GlobalGestureConfig config;

  @override
  State<_PointerAndPracticalScene> createState() => _PointerAndPracticalSceneState();
}

class _PointerAndPracticalSceneState extends State<_PointerAndPracticalScene> {
  final List<String> _pointerEvents = <String>[];
  final List<Offset> _points = <Offset>[];

  final List<_BoardCard> _cards = const [
    _BoardCard('Plan', 'Define interaction goals and edge cases.'),
    _BoardCard('Probe', 'Verify arena behavior with nested targets.'),
    _BoardCard('Tune', 'Adjust recognizer callbacks and telemetry.'),
    _BoardCard('Ship', 'Finalize polished interactions and guidance.'),
  ];

  int _selected = 0;
  Offset _cardOffset = Offset.zero;
  bool _locked = false;

  void _logPointer(String message) {
    setState(() {
      _pointerEvents.insert(0, '${DateTime.now().toIso8601String().substring(11, 19)} | $message');
      if (_pointerEvents.length > 14) {
        _pointerEvents.removeRange(14, _pointerEvents.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top pane streams raw PointerEvent data via Listener. Bottom pane is a practical card interaction panel using GestureDetector callbacks.',
          style: TextStyle(height: 1.35),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: config.compact ? 420 : 520,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: _GuideStage(
                        showGrid: config.showGrid,
                        child: Listener(
                          behavior: config.behavior,
                          onPointerDown: (event) {
                            _logPointer('PointerDown ${event.localPosition.dx.toStringAsFixed(1)}, ${event.localPosition.dy.toStringAsFixed(1)}');
                            setState(() => _points.add(event.localPosition));
                          },
                          onPointerMove: (event) {
                            _logPointer('PointerMove Δ${event.delta.dx.toStringAsFixed(1)}, ${event.delta.dy.toStringAsFixed(1)}');
                            setState(() {
                              _points.add(event.localPosition);
                              if (_points.length > 220) {
                                _points.removeAt(0);
                              }
                            });
                          },
                          onPointerUp: (event) => _logPointer('PointerUp ${event.localPosition.dx.toStringAsFixed(1)}, ${event.localPosition.dy.toStringAsFixed(1)}'),
                          onPointerCancel: (_) => _logPointer('PointerCancel'),
                          child: CustomPaint(
                            painter: _PointerTrailPainter(points: _points),
                            child: const Center(
                              child: Text('Pointer stream pad', style: TextStyle(fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: _GuideStage(
                        showGrid: config.showGrid,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFD3DEEA)),
                                ),
                                child: Text(
                                  'Practical board: ${_cards[_selected].title}',
                                  style: const TextStyle(fontWeight: FontWeight.w800),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: Stack(
                                  children: [
                                    ListView.separated(
                                      itemCount: _cards.length,
                                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                                      itemBuilder: (context, index) {
                                        final card = _cards[index];
                                        final selected = index == _selected;
                                        return InkWell(
                                          borderRadius: BorderRadius.circular(10),
                                          onTap: () => setState(() => _selected = index),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: selected ? const Color(0xFFEAF3FD) : Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: const Color(0xFFD6E1ED)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(card.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                                                const SizedBox(height: 4),
                                                Text(card.detail, style: const TextStyle(height: 1.3, color: Color(0xFF55697A))),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Positioned.fill(
                                      child: IgnorePointer(
                                        ignoring: false,
                                        child: Center(
                                          child: Transform.translate(
                                            offset: _cardOffset,
                                            child: GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () => _logPointer('Card onTap'),
                                              onDoubleTap: () {
                                                _logPointer('Card onDoubleTap -> reset offset');
                                                setState(() => _cardOffset = Offset.zero);
                                              },
                                              onLongPress: () {
                                                _logPointer('Card onLongPress -> toggle lock');
                                                setState(() => _locked = !_locked);
                                              },
                                              onPanUpdate: (details) {
                                                if (_locked) {
                                                  return;
                                                }
                                                setState(() => _cardOffset += details.delta);
                                              },
                                              child: Container(
                                                width: 180,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  color: _locked ? const Color(0xFF9AA7B1) : const Color(0xFFD8ECC8),
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: const Color(0xFF5E7A63), width: 1.2),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  _locked ? 'Card locked\n(long press to unlock)' : 'Gesture card\n(drag, tap, double tap, long press)',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _EventLog(events: _pointerEvents, title: 'Pointer + practical event log'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BoardCard {
  const _BoardCard(this.title, this.detail);

  final String title;
  final String detail;
}

class _PointerTrailPainter extends CustomPainter {
  const _PointerTrailPainter({required this.points});

  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) {
      return;
    }

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }

    final stroke = Paint()
      ..color = const Color(0xAA2C5F8D)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, stroke);

    final pulse = Paint()..color = const Color(0x55346D9A);
    for (int i = 0; i < points.length; i += 8) {
      canvas.drawCircle(points[i], 3, pulse);
    }
  }

  @override
  bool shouldRepaint(covariant _PointerTrailPainter oldDelegate) => oldDelegate.points != points;
}

class _GuideStage extends StatelessWidget {
  const _GuideStage({required this.showGrid, required this.child});

  final bool showGrid;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFFF7FBFF), Color(0xFFEAF2F8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0xFFD4E0EB)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGrid)
            CustomPaint(
              painter: _GridPainter(),
            ),
          child,
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const step = 22.0;
    final paint = Paint()..color = const Color(0x11000000);

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.color, required this.onPressed});

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 9, height: 9, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, size: 7, color: Color(0xFF36536D)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
        ],
      ),
    );
  }
}

class _EventLog extends StatelessWidget {
  const _EventLog({required this.events, required this.title});

  final List<String> events;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFCFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDCE6F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          if (events.isEmpty)
            const Text('No events yet.', style: TextStyle(color: Color(0xFF617386)))
          else
            ...events.map(
              (event) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(event, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
              ),
            ),
        ],
      ),
    );
  }
}

class _RecapCard extends StatelessWidget {
  const _RecapCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF10273C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recap: GestureDetector Advanced',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Use GestureDetector for high-level interaction intents and RawGestureDetector when explicit recognizer wiring is needed. Pair with Listener for raw PointerEvent diagnostics and edge-case tooling.',
            style: TextStyle(color: Color(0xFFD9E5F1), height: 1.4),
          ),
        ],
      ),
    );
  }
}
