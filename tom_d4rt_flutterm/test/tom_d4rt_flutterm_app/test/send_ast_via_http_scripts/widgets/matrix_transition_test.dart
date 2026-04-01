import 'dart:math' as math;

import 'package:flutter/material.dart';

const _bg = Color(0xFFF3F7FB);
const _ink = Color(0xFF163247);
const _blue = Color(0xFF2C638D);
const _teal = Color(0xFF2A816E);
const _amber = Color(0xFFB48642);
const _rose = Color(0xFF9D5F75);
const _violet = Color(0xFF675DB2);

dynamic build(BuildContext context) {
  return const _MatrixTransitionDeepDemoApp();
}

class _MatrixTransitionDeepDemoApp extends StatelessWidget {
  const _MatrixTransitionDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _MatrixTransitionDeepDemoPage(),
    );
  }
}

class _MatrixTransitionDeepDemoPage extends StatefulWidget {
  const _MatrixTransitionDeepDemoPage();

  @override
  State<_MatrixTransitionDeepDemoPage> createState() => _MatrixTransitionDeepDemoPageState();
}

class _MatrixTransitionDeepDemoPageState extends State<_MatrixTransitionDeepDemoPage> {
  bool _compact = false;
  bool _guide = true;
  bool _notes = true;
  bool _rtl = false;
  double _globalScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 92,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('MatrixTransition Deep Demo'),
              Text(
                'transform callback choreography | alignment and quality tuning | multi-scene matrix animation systems',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.86), fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ControlDeck(
                compact: _compact,
                guide: _guide,
                notes: _notes,
                rtl: _rtl,
                globalScale: _globalScale,
                onCompactChanged: (v) => setState(() => _compact = v),
                onGuideChanged: (v) => setState(() => _guide = v),
                onNotesChanged: (v) => setState(() => _notes = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onScaleChanged: (v) => setState(() => _globalScale = v),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 1,
                tone: _blue,
                title: 'Transform Fundamentals Studio',
                subtitle:
                    'Single MatrixTransition with selectable transform modes, speed control, and matrix-parameter tuning.',
                child: _FundamentalsScene(compact: _compact, guide: _guide, notes: _notes, scale: _globalScale),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 2,
                tone: _teal,
                title: 'Callback Choreography Workshop',
                subtitle:
                    'Compare multiple onTransform callback strategies side by side using a synchronized animation timeline.',
                child: _WorkshopScene(compact: _compact, guide: _guide, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 3,
                tone: _amber,
                title: 'Alignment and Filter Gallery',
                subtitle:
                    'Visual differences when changing alignment pivot and filterQuality with equivalent transformation motion.',
                child: _AlignmentFilterScene(compact: _compact, guide: _guide, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 4,
                tone: _rose,
                title: 'Keyframe Matrix Desk',
                subtitle:
                    'Manual and automatic timeline playback with handcrafted keyframe matrix compositions.',
                child: _KeyframeScene(compact: _compact, guide: _guide, notes: _notes),
              ),
              const SizedBox(height: 12),
              _SceneShell(
                index: 5,
                tone: _violet,
                title: 'Practical Motion Console',
                subtitle:
                    'Three product-style modules using MatrixTransition for hover-like emphasis, focus routing, and command feedback.',
                child: _PracticalScene(compact: _compact, guide: _guide, notes: _notes),
              ),
              const SizedBox(height: 12),
              const _RecapPanel(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlDeck extends StatelessWidget {
  const _ControlDeck({
    required this.compact,
    required this.guide,
    required this.notes,
    required this.rtl,
    required this.globalScale,
    required this.onCompactChanged,
    required this.onGuideChanged,
    required this.onNotesChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool guide;
  final bool notes;
  final bool rtl;
  final double globalScale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuideChanged;
  final ValueChanged<bool> onNotesChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF193A52), Color(0xFF286183), Color(0xFF3A7D69), Color(0xFF615DB1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MatrixTransition Control Deck',
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'MatrixTransition converts an Animation<double> into Matrix4 transforms using onTransform. '
            'This makes it ideal for custom motion systems beyond prebuilt rotate/scale transitions.',
            style: TextStyle(color: Color(0xFFDDEBF7), height: 1.35),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact scenes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: guide,
                  onChanged: onGuideChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Guide overlays', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: notes,
                  onChanged: onNotesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Instruction notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          Text('Global scene scale: ${globalScale.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          Slider(
            value: globalScale,
            min: 0.8,
            max: 1.35,
            divisions: 11,
            onChanged: onScaleChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.30),
          ),
        ],
      ),
    );
  }
}

class _SceneShell extends StatelessWidget {
  const _SceneShell({
    required this.index,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color tone;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 15, offset: const Offset(0, 7)),
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
                  backgroundColor: tone,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 19)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF3A4F61), height: 1.34)),
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

enum _TransformMode {
  translate,
  scale,
  rotate,
  skew,
  perspective,
  combo,
}

class _FundamentalsScene extends StatefulWidget {
  const _FundamentalsScene({required this.compact, required this.guide, required this.notes, required this.scale});

  final bool compact;
  final bool guide;
  final bool notes;
  final double scale;

  @override
  State<_FundamentalsScene> createState() => _FundamentalsSceneState();
}

class _FundamentalsSceneState extends State<_FundamentalsScene> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  _TransformMode _mode = _TransformMode.combo;
  double _translate = 42;
  double _scaleAmp = 0.35;
  double _rotateRad = 0.9;
  double _skewAmp = 0.28;
  double _perspective = 0.0014;
  double _speed = 1.0;
  bool _reverse = true;
  bool _overlay = true;
  Alignment _alignment = Alignment.center;
  FilterQuality? _quality = FilterQuality.high;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600));
    _startTicker();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 940.0 : 1120.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Animation and matrix controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<_TransformMode>(
                        initialValue: _mode,
                        decoration: const InputDecoration(labelText: 'Transform mode', border: OutlineInputBorder()),
                        items: _TransformMode.values.map((m) => DropdownMenuItem(value: m, child: Text(m.name))).toList(),
                        onChanged: (v) => setState(() => _mode = v ?? _mode),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<Alignment>(
                        initialValue: _alignment,
                        decoration: const InputDecoration(labelText: 'Alignment pivot', border: OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem(value: Alignment.center, child: Text('center')),
                          DropdownMenuItem(value: Alignment.topLeft, child: Text('topLeft')),
                          DropdownMenuItem(value: Alignment.topCenter, child: Text('topCenter')),
                          DropdownMenuItem(value: Alignment.centerRight, child: Text('centerRight')),
                          DropdownMenuItem(value: Alignment.bottomCenter, child: Text('bottomCenter')),
                        ],
                        onChanged: (v) => setState(() => _alignment = v ?? _alignment),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<FilterQuality?>(
                        initialValue: _quality,
                        decoration: const InputDecoration(labelText: 'Filter quality', border: OutlineInputBorder()),
                        items: const [
                          DropdownMenuItem<FilterQuality?>(value: null, child: Text('null')),
                          DropdownMenuItem<FilterQuality?>(value: FilterQuality.low, child: Text('low')),
                          DropdownMenuItem<FilterQuality?>(value: FilterQuality.medium, child: Text('medium')),
                          DropdownMenuItem<FilterQuality?>(value: FilterQuality.high, child: Text('high')),
                        ],
                        onChanged: (v) => setState(() => _quality = v),
                      ),
                      const SizedBox(height: 8),
                      _SliderRow(label: 'Translate amplitude', value: _translate, min: 0, max: 120, onChanged: (v) => setState(() => _translate = v)),
                      _SliderRow(label: 'Scale amplitude', value: _scaleAmp, min: 0, max: 0.9, onChanged: (v) => setState(() => _scaleAmp = v)),
                      _SliderRow(label: 'Rotation amplitude', value: _rotateRad, min: 0, max: 3.2, onChanged: (v) => setState(() => _rotateRad = v)),
                      _SliderRow(label: 'Skew amplitude', value: _skewAmp, min: 0, max: 0.9, onChanged: (v) => setState(() => _skewAmp = v)),
                      _SliderRow(label: 'Perspective depth', value: _perspective, min: 0.0002, max: 0.0034, onChanged: (v) => setState(() => _perspective = v)),
                      _SliderRow(
                        label: 'Speed multiplier',
                        value: _speed,
                        min: 0.3,
                        max: 2.2,
                        onChanged: (v) {
                          setState(() => _speed = v);
                          _startTicker();
                        },
                      ),
                      SwitchListTile(
                        value: _reverse,
                        onChanged: (v) {
                          setState(() => _reverse = v);
                          _startTicker();
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Repeat reverse'),
                      ),
                      SwitchListTile(
                        value: _overlay,
                        onChanged: (v) => setState(() => _overlay = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show center overlay'),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () => _controller.isAnimating ? _controller.stop() : _startTicker(),
                            child: Text(_controller.isAnimating ? 'Pause' : 'Play'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => _controller.forward(from: 0),
                            child: const Text('Restart'),
                          ),
                          FilledButton.tonal(
                            onPressed: () => setState(() => _controller.value = 0.5),
                            child: const Text('Set t=0.5'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('mode', _mode.name),
                          _DataRowItem('animation value', _controller.value.toStringAsFixed(3)),
                          _DataRowItem('phase sin', math.sin(_controller.value * math.pi * 2).toStringAsFixed(3)),
                          _DataRowItem('alignment', _alignment.toString()),
                          _DataRowItem('filterQuality', _quality?.name ?? 'null'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _blue,
                          lines: const [
                            'MatrixTransition evaluates onTransform for each animation tick and applies the resulting Matrix4.',
                            'Unlike fixed transitions, this allows compound transforms and nonlinear motion from one animation timeline.',
                            'Keep matrix complexity understandable by exposing clear controls for translation, scale, rotation, skew, and perspective.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Transform.scale(
                  scale: widget.scale,
                  alignment: Alignment.topCenter,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Stack(
                        children: [
                          Positioned.fill(child: _MatrixBackdrop(tone: _blue, label: 'Fundamentals Grid', t: _controller.value)),
                          Center(
                            child: MatrixTransition(
                              animation: _controller,
                              alignment: _alignment,
                              filterQuality: _quality,
                              onTransform: (value) => _matrixByMode(
                                mode: _mode,
                                t: value,
                                translateAmp: _translate,
                                scaleAmp: _scaleAmp,
                                rotateAmp: _rotateRad,
                                skewAmp: _skewAmp,
                                perspectiveDepth: _perspective,
                              ),
                              child: _FeatureCard(
                                tone: _blue,
                                title: 'MatrixTransition Core',
                                subtitle: 'onTransform(t) -> Matrix4',
                                chips: const ['translate', 'scale', 'rotate', 'skew', 'perspective'],
                              ),
                            ),
                          ),
                          if (_overlay)
                            IgnorePointer(
                              child: Center(
                                child: Container(
                                  width: 280,
                                  height: 190,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: _blue.withValues(alpha: 0.32), width: 2),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startTicker() {
    final base = 2600 / _speed;
    _controller.duration = Duration(milliseconds: base.round());
    _controller.repeat(reverse: _reverse);
  }
}

class _WorkshopScene extends StatefulWidget {
  const _WorkshopScene({required this.compact, required this.guide, required this.notes});

  final bool compact;
  final bool guide;
  final bool notes;

  @override
  State<_WorkshopScene> createState() => _WorkshopSceneState();
}

class _WorkshopSceneState extends State<_WorkshopScene> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _reverse = true;
  double _speed = 1.0;
  double _phaseShift = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
    _restart();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 920.0 : 1080.0;
    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Callback choreography controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _SliderRow(
                        label: 'Speed multiplier',
                        value: _speed,
                        min: 0.4,
                        max: 2.4,
                        onChanged: (v) {
                          setState(() => _speed = v);
                          _restart();
                        },
                      ),
                      _SliderRow(
                        label: 'Phase shift',
                        value: _phaseShift,
                        min: -1,
                        max: 1,
                        onChanged: (v) => setState(() => _phaseShift = v),
                      ),
                      SwitchListTile(
                        value: _reverse,
                        onChanged: (v) {
                          setState(() => _reverse = v);
                          _restart();
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Repeat reverse'),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(
                            onPressed: () => _controller.isAnimating ? _controller.stop() : _restart(),
                            child: Text(_controller.isAnimating ? 'Pause' : 'Play'),
                          ),
                          FilledButton.tonal(onPressed: () => _controller.forward(from: 0), child: const Text('Restart')),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('value', _controller.value.toStringAsFixed(3)),
                          _DataRowItem('sin', math.sin((_controller.value + _phaseShift) * math.pi * 2).toStringAsFixed(3)),
                          _DataRowItem('cos', math.cos((_controller.value + _phaseShift) * math.pi * 2).toStringAsFixed(3)),
                          _DataRowItem('speed', _speed.toStringAsFixed(2)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _teal,
                          lines: const [
                            'The same animation value can produce very different motion by changing matrix math in onTransform.',
                            'Sine/cosine phase offsets are useful for orchestrating multiple animated targets on one timeline.',
                            'Combining 2D and mild 3D terms can produce richer motion without introducing a separate scene graph engine.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(child: _workCard('Orbit', _blue, _orbitMatrix(_controller.value, _phaseShift))),
                              const SizedBox(width: 8),
                              Expanded(child: _workCard('Pulse Tilt', _teal, _pulseTiltMatrix(_controller.value, _phaseShift))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(child: _workCard('Skew Slide', _amber, _skewSlideMatrix(_controller.value, _phaseShift))),
                              const SizedBox(width: 8),
                              Expanded(child: _workCard('Depth Pivot', _violet, _depthPivotMatrix(_controller.value, _phaseShift))),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _workCard(String title, Color tone, Matrix4 Function(double) callback) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.35)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(child: _MatrixBackdrop(tone: tone, label: '$title backdrop', t: _controller.value)),
                Center(
                  child: MatrixTransition(
                    animation: _controller,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.medium,
                    onTransform: callback,
                    child: _FeatureCard(
                      tone: tone,
                      title: title,
                      subtitle: 'custom callback',
                      chips: const ['MatrixTransition', 'onTransform'],
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

  void _restart() {
    _controller.duration = Duration(milliseconds: (3000 / _speed).round());
    _controller.repeat(reverse: _reverse);
  }
}

class _AlignmentFilterScene extends StatefulWidget {
  const _AlignmentFilterScene({required this.compact, required this.guide, required this.notes});

  final bool compact;
  final bool guide;
  final bool notes;

  @override
  State<_AlignmentFilterScene> createState() => _AlignmentFilterSceneState();
}

class _AlignmentFilterSceneState extends State<_AlignmentFilterScene> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _reverse = true;
  double _speed = 1.0;
  bool _overlay = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2600));
    _start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 940.0 : 1120.0;

    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Alignment and quality controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      _SliderRow(
                        label: 'Speed multiplier',
                        value: _speed,
                        min: 0.3,
                        max: 2.2,
                        onChanged: (v) {
                          setState(() => _speed = v);
                          _start();
                        },
                      ),
                      SwitchListTile(
                        value: _reverse,
                        onChanged: (v) {
                          setState(() => _reverse = v);
                          _start();
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Repeat reverse'),
                      ),
                      SwitchListTile(
                        value: _overlay,
                        onChanged: (v) => setState(() => _overlay = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show pivot overlays'),
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('value', _controller.value.toStringAsFixed(3)),
                          _DataRowItem('speed', _speed.toStringAsFixed(2)),
                          _DataRowItem('reverse', _reverse ? 'true' : 'false'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _amber,
                          lines: const [
                            'Alignment controls the pivot point where matrix transforms originate.',
                            'For rotation-heavy transforms, changing pivot can dramatically alter perceived motion path.',
                            'FilterQuality is relevant when transformed content scales and rotates, especially on text or sharp edges.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.14,
                      children: [
                        _pivotCard('Top Left + low', _amber, Alignment.topLeft, FilterQuality.low, _overlay),
                        _pivotCard('Center + medium', _blue, Alignment.center, FilterQuality.medium, _overlay),
                        _pivotCard('Bottom Center + high', _teal, Alignment.bottomCenter, FilterQuality.high, _overlay),
                        _pivotCard('Center Right + null', _rose, Alignment.centerRight, null, _overlay),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pivotCard(String title, Color tone, Alignment alignment, FilterQuality? quality, bool overlay) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.35)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800, fontSize: 12)),
          const SizedBox(height: 6),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(child: _MatrixBackdrop(tone: tone, label: title, t: _controller.value)),
                Center(
                  child: MatrixTransition(
                    animation: _controller,
                    alignment: alignment,
                    filterQuality: quality,
                    onTransform: (value) => _comboMatrix(value, translate: 24, rotate: 0.8, scaleAmp: 0.24, skew: 0.12),
                    child: _FeatureCard(
                      tone: tone,
                      title: 'Pivot',
                      subtitle: alignment.toString(),
                      chips: [quality?.name ?? 'null'],
                    ),
                  ),
                ),
                if (overlay)
                  IgnorePointer(
                    child: Align(
                      alignment: alignment,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(color: tone.withValues(alpha: 0.75), shape: BoxShape.circle),
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

  void _start() {
    _controller.duration = Duration(milliseconds: (2600 / _speed).round());
    _controller.repeat(reverse: _reverse);
  }
}

class _KeyframeScene extends StatefulWidget {
  const _KeyframeScene({required this.compact, required this.guide, required this.notes});

  final bool compact;
  final bool guide;
  final bool notes;

  @override
  State<_KeyframeScene> createState() => _KeyframeSceneState();
}

class _KeyframeSceneState extends State<_KeyframeScene> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _manual = false;
  double _manualT = 0;
  bool _overlay = true;
  bool _reverse = true;
  double _speed = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 3200));
    _play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 980.0 : 1160.0;

    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Keyframe controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _manual,
                        onChanged: (v) {
                          setState(() => _manual = v);
                          if (!_manual) {
                            _play();
                          } else {
                            _controller.stop();
                          }
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Manual scrub mode'),
                      ),
                      _SliderRow(
                        label: 'Manual t',
                        value: _manualT,
                        min: 0,
                        max: 1,
                        onChanged: _manual
                            ? (v) => setState(() {
                                  _manualT = v;
                                  _controller.value = v;
                                })
                            : null,
                      ),
                      _SliderRow(
                        label: 'Speed multiplier',
                        value: _speed,
                        min: 0.4,
                        max: 2.2,
                        onChanged: (v) {
                          setState(() => _speed = v);
                          if (!_manual) {
                            _play();
                          }
                        },
                      ),
                      SwitchListTile(
                        value: _reverse,
                        onChanged: (v) {
                          setState(() => _reverse = v);
                          if (!_manual) {
                            _play();
                          }
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Reverse playback'),
                      ),
                      SwitchListTile(
                        value: _overlay,
                        onChanged: (v) => setState(() => _overlay = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show keyframe overlay'),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.tonal(onPressed: _manual ? null : () => _play(), child: const Text('Re-run')),
                          FilledButton.tonal(onPressed: () => _controller.stop(), child: const Text('Pause')),
                          FilledButton.tonal(onPressed: () => setState(() => _controller.value = 0), child: const Text('Set t=0')),
                          FilledButton.tonal(onPressed: () => setState(() => _controller.value = 1), child: const Text('Set t=1')),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _DataTableCard(
                        rows: [
                          _DataRowItem('value', _controller.value.toStringAsFixed(3)),
                          _DataRowItem('manual mode', _manual ? 'yes' : 'no'),
                          _DataRowItem('speed', _speed.toStringAsFixed(2)),
                          _DataRowItem('reverse', _reverse ? 'true' : 'false'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.notes)
                        _InstructionCard(
                          tone: _rose,
                          lines: const [
                            'Manual scrub helps validate matrix keyframes without timing noise.',
                            'A keyframe matrix sequence can be simpler to reason about than one large procedural callback.',
                            'For production animations, define keyframe intent first, then smooth timing curves around it.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final t = _manual ? _manualT : _controller.value;
                    return Stack(
                      children: [
                        Positioned.fill(child: _MatrixBackdrop(tone: _rose, label: 'Keyframe board', t: t)),
                        Center(
                          child: MatrixTransition(
                            animation: _controller,
                            alignment: Alignment.center,
                            filterQuality: FilterQuality.high,
                            onTransform: (value) => _keyframeMatrix(_manual ? _manualT : value),
                            child: _FeatureCard(
                              tone: _rose,
                              title: 'Keyframe Matrix',
                              subtitle: 'segment blended transform',
                              chips: const ['t0-t1 segments', 'lerp'],
                            ),
                          ),
                        ),
                        if (_overlay)
                          IgnorePointer(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                  width: 360,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(color: _rose.withValues(alpha: 0.35)),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FractionallySizedBox(
                                    widthFactor: t,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _rose,
                                        borderRadius: BorderRadius.circular(999),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _play() {
    _controller.duration = Duration(milliseconds: (3200 / _speed).round());
    _controller.repeat(reverse: _reverse);
  }
}

class _PracticalScene extends StatefulWidget {
  const _PracticalScene({required this.compact, required this.guide, required this.notes});

  final bool compact;
  final bool guide;
  final bool notes;

  @override
  State<_PracticalScene> createState() => _PracticalSceneState();
}

class _PracticalSceneState extends State<_PracticalScene> {
  bool _overlay = true;
  int _revision = 1;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final h = widget.compact ? 1140.0 : 1340.0;

    return SizedBox(
      height: h,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(
                          selected: _overlay,
                          label: const Text('Overlay guides'),
                          onSelected: (v) => setState(() => _overlay = v),
                        ),
                        FilledButton.tonal(
                          onPressed: () => setState(() => _revision += 1),
                          child: Text('Refresh modules ($_revision)'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() {
                              _events.insert(0, '${_clock()} | snapshot captured');
                              if (_events.length > 30) {
                                _events.removeRange(30, _events.length);
                              }
                            });
                          },
                          child: const Text('Capture snapshot'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _PracticalModule(
                              title: 'Command Router',
                              tone: _blue,
                              chips: const ['focus route', 'node select'],
                              mode: _TransformMode.rotate,
                              overlay: _overlay,
                              revision: _revision,
                              onEvent: (e) => _push('router: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              title: 'Metric Tiles',
                              tone: _teal,
                              chips: const ['hover boost', 'depth cue'],
                              mode: _TransformMode.scale,
                              overlay: _overlay,
                              revision: _revision,
                              onEvent: (e) => _push('metrics: $e'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _PracticalModule(
                              title: 'Workflow Radar',
                              tone: _violet,
                              chips: const ['orbit', 'phase sync'],
                              mode: _TransformMode.combo,
                              overlay: _overlay,
                              revision: _revision,
                              onEvent: (e) => _push('radar: $e'),
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
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _PanelSurface(
              guide: widget.guide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Practical notes', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _DataTableCard(
                      rows: [
                        _DataRowItem('revision', '$_revision'),
                        _DataRowItem('overlay', _overlay ? 'visible' : 'hidden'),
                        _DataRowItem('module count', '3'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (widget.notes)
                      _InstructionCard(
                        tone: _violet,
                        lines: const [
                          'MatrixTransition is effective for subtle emphasis motion in data-dense panels.',
                          'Keep transformation intensity moderate for production readability and accessibility.',
                          'Shared animation controllers can synchronize modules, while per-module callbacks preserve visual identity.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Event log', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _LogCard(lines: _events)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _push(String msg) {
    setState(() {
      _events.insert(0, '${_clock()} | $msg');
      if (_events.length > 30) {
        _events.removeRange(30, _events.length);
      }
    });
  }
}

class _PracticalModule extends StatefulWidget {
  const _PracticalModule({
    required this.title,
    required this.tone,
    required this.chips,
    required this.mode,
    required this.overlay,
    required this.revision,
    required this.onEvent,
  });

  final String title;
  final Color tone;
  final List<String> chips;
  final _TransformMode mode;
  final bool overlay;
  final int revision;
  final ValueChanged<String> onEvent;

  @override
  State<_PracticalModule> createState() => _PracticalModuleState();
}

class _PracticalModuleState extends State<_PracticalModule> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _intensity = 1.0;
  bool _reverse = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400));
    _controller.repeat(reverse: _reverse);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.tone.withValues(alpha: 0.35)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.title, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800))),
              Switch(
                value: _reverse,
                onChanged: (v) {
                  setState(() => _reverse = v);
                  _controller.repeat(reverse: _reverse);
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
          _MiniSlider(label: 'Intensity', value: _intensity, min: 0.4, max: 1.8, onChanged: (v) => setState(() => _intensity = v)),
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: widget.chips.map((c) => Chip(label: Text(c), visualDensity: VisualDensity.compact)).toList(),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(child: _MatrixBackdrop(tone: widget.tone, label: widget.title, t: _controller.value + widget.revision * 0.01)),
                Center(
                  child: MatrixTransition(
                    animation: _controller,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.medium,
                    onTransform: (value) => _matrixByMode(
                      mode: widget.mode,
                      t: value,
                      translateAmp: 26 * _intensity,
                      scaleAmp: 0.25 * _intensity,
                      rotateAmp: 0.9 * _intensity,
                      skewAmp: 0.14 * _intensity,
                      perspectiveDepth: 0.0012,
                    ),
                    child: _FeatureCard(
                      tone: widget.tone,
                      title: widget.title,
                      subtitle: widget.mode.name,
                      chips: const ['MatrixTransition'],
                    ),
                  ),
                ),
                if (widget.overlay)
                  IgnorePointer(
                    child: Center(
                      child: Container(
                        width: 260,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: widget.tone.withValues(alpha: 0.24), width: 2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          FilledButton.tonal(
            onPressed: () => widget.onEvent('intensity=${_intensity.toStringAsFixed(2)}, reverse=$_reverse'),
            child: const Text('Record module state'),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.tone, required this.title, required this.subtitle, required this.chips});

  final Color tone;
  final String title;
  final String subtitle;
  final List<String> chips;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.45), width: 1.6),
        boxShadow: [
          BoxShadow(color: tone.withValues(alpha: 0.16), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Color(0xFF41576A), fontSize: 12)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: chips.map((c) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(c, style: TextStyle(color: tone, fontSize: 11, fontWeight: FontWeight.w700)),
            )).toList(),
          ),
          const Spacer(),
          Row(
            children: [
              _tinyMetric('lat', '${88 + title.length}ms', tone),
              const SizedBox(width: 6),
              _tinyMetric('load', '${42 + subtitle.length}%', tone),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tinyMetric(String label, String value, Color tone) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: tone.withValues(alpha: 0.30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: tone, fontSize: 10, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(color: _ink, fontWeight: FontWeight.w800, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _MatrixBackdrop extends StatelessWidget {
  const _MatrixBackdrop({required this.tone, required this.label, required this.t});

  final Color tone;
  final String label;
  final double t;

  @override
  Widget build(BuildContext context) {
    final wave = math.sin(t * math.pi * 2);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tone.withValues(alpha: 0.14), Colors.white, tone.withValues(alpha: 0.10)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _WaveGridPainter(tone: tone, wave: wave),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(label, style: TextStyle(color: tone, fontSize: 11, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _WaveGridPainter extends CustomPainter {
  const _WaveGridPainter({required this.tone, required this.wave});

  final Color tone;
  final double wave;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = tone.withValues(alpha: 0.14);
    const step = 20.0;
    for (double x = 0; x <= size.width; x += step) {
      final dx = x + wave * 2.2;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      final dy = y + wave * 1.4;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), p);
    }
  }

  @override
  bool shouldRepaint(covariant _WaveGridPainter oldDelegate) {
    return oldDelegate.wave != wave || oldDelegate.tone != tone;
  }
}

class _PanelSurface extends StatelessWidget {
  const _PanelSurface({required this.guide, required this.child});

  final bool guide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC6D7E8)),
        gradient: const LinearGradient(
          colors: [Color(0xFFFAFCFF), Color(0xFFEFF5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (guide) const CustomPaint(painter: _GuidePainter()),
          child,
        ],
      ),
    );
  }
}

class _GuidePainter extends CustomPainter {
  const _GuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x0F000000);
    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DataRowItem {
  const _DataRowItem(this.label, this.value);

  final String label;
  final String value;
}

class _DataTableCard extends StatelessWidget {
  const _DataTableCard({required this.rows});

  final List<_DataRowItem> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD2E1EF)),
      ),
      child: Column(
        children: rows
            .map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(width: 138, child: Text(r.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
                    Expanded(child: Text(r.value, style: const TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(3)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }
}

class _MiniSlider extends StatelessWidget {
  const _MiniSlider({required this.label, required this.value, required this.min, required this.max, required this.onChanged});

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 54, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
        Expanded(child: Slider(value: value, min: min, max: max, onChanged: onChanged)),
      ],
    );
  }
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({required this.tone, required this.lines});

  final Color tone;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.circle, size: 7, color: Color(0xFFBFE3FF)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: const TextStyle(color: Color(0xFFE8F6FF), height: 1.35))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  const _LogCard({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCFDEEC)),
      ),
      child: lines.isEmpty
          ? const Text('No events yet.', style: TextStyle(color: Color(0xFF62798D)))
          : ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(lines[index], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                );
              },
            ),
    );
  }
}

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF14374E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: MatrixTransition', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'MatrixTransition provides matrix-driven animation power from a single scalar timeline. '
            'When onTransform is designed carefully, you can create expressive custom motion while maintaining readable, controlled behavior for production interfaces.',
            style: TextStyle(color: Color(0xFFD7E8F6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

Matrix4 _matrixByMode({
  required _TransformMode mode,
  required double t,
  required double translateAmp,
  required double scaleAmp,
  required double rotateAmp,
  required double skewAmp,
  required double perspectiveDepth,
}) {
  switch (mode) {
    case _TransformMode.translate:
      return _translateMatrix(t, amp: translateAmp);
    case _TransformMode.scale:
      return _scaleMatrix(t, amp: scaleAmp);
    case _TransformMode.rotate:
      return _rotateMatrix(t, amp: rotateAmp);
    case _TransformMode.skew:
      return _skewMatrix(t, amp: skewAmp);
    case _TransformMode.perspective:
      return _perspectiveMatrix(t, depth: perspectiveDepth, rotateAmp: rotateAmp, translateAmp: translateAmp * 0.4);
    case _TransformMode.combo:
      return _comboMatrix(t, translate: translateAmp, rotate: rotateAmp, scaleAmp: scaleAmp, skew: skewAmp, depth: perspectiveDepth);
  }
}

Matrix4 _translateMatrix(double t, {double amp = 30}) {
  final sx = math.sin(t * math.pi * 2);
  final cy = math.cos(t * math.pi * 2);
  return Matrix4.identity()..translateByDouble(sx * amp, cy * amp * 0.6, 0, 1);
}

Matrix4 _scaleMatrix(double t, {double amp = 0.25}) {
  final w = 1 + (math.sin(t * math.pi * 2) * amp);
  final h = 1 + (math.cos(t * math.pi * 2) * amp * 0.8);
  return Matrix4.identity()..scaleByDouble(w, h, 1, 1);
}

Matrix4 _rotateMatrix(double t, {double amp = 1.0}) {
  final a = math.sin(t * math.pi * 2) * amp;
  return Matrix4.identity()..rotateZ(a);
}

Matrix4 _skewMatrix(double t, {double amp = 0.2}) {
  final sx = math.sin(t * math.pi * 2) * amp;
  final sy = math.cos(t * math.pi * 2) * amp * 0.7;
  return Matrix4.identity()
    ..setEntry(0, 1, sx)
    ..setEntry(1, 0, sy);
}

Matrix4 _perspectiveMatrix(double t, {double depth = 0.0012, double rotateAmp = 0.8, double translateAmp = 18}) {
  final s = math.sin(t * math.pi * 2);
  final c = math.cos(t * math.pi * 2);
  return Matrix4.identity()
    ..setEntry(3, 2, -depth)
    ..rotateX(s * rotateAmp * 0.4)
    ..rotateY(c * rotateAmp * 0.6)
    ..translateByDouble(s * translateAmp, c * translateAmp * 0.4, 0, 1);
}

Matrix4 _comboMatrix(
  double t, {
  double translate = 30,
  double rotate = 0.9,
  double scaleAmp = 0.25,
  double skew = 0.12,
  double depth = 0.0012,
}) {
  final s = math.sin(t * math.pi * 2);
  final c = math.cos(t * math.pi * 2);
  return Matrix4.identity()
    ..setEntry(3, 2, -depth)
    ..translateByDouble(s * translate, c * translate * 0.5, 0, 1)
    ..rotateZ(s * rotate)
    ..scaleByDouble(1 + s * scaleAmp, 1 + c * scaleAmp * 0.8, 1, 1)
    ..setEntry(0, 1, s * skew)
    ..setEntry(1, 0, c * skew * 0.7);
}

Matrix4 Function(double) _orbitMatrix(double baseT, double shift) {
  return (t) {
    final p = (t + baseT * 0.3 + shift) % 1.0;
    final angle = p * math.pi * 2;
    return Matrix4.identity()
      ..setEntry(3, 2, -0.0012)
      ..translateByDouble(math.cos(angle) * 34, math.sin(angle) * 26, 0, 1)
      ..rotateZ(angle * 0.8);
  };
}

Matrix4 Function(double) _pulseTiltMatrix(double baseT, double shift) {
  return (t) {
    final p = (t + shift * 0.5 + baseT * 0.2) % 1.0;
    final s = math.sin(p * math.pi * 2);
    return Matrix4.identity()
      ..setEntry(3, 2, -0.0014)
      ..rotateX(s * 0.35)
      ..rotateY(s * 0.25)
      ..scaleByDouble(1 + s * 0.24, 1 + s * 0.20, 1, 1);
  };
}

Matrix4 Function(double) _skewSlideMatrix(double baseT, double shift) {
  return (t) {
    final p = (t + shift + baseT * 0.1) % 1.0;
    final s = math.sin(p * math.pi * 2);
    final c = math.cos(p * math.pi * 2);
    return Matrix4.identity()
      ..translateByDouble(s * 28, c * 16, 0, 1)
      ..setEntry(0, 1, s * 0.18)
      ..setEntry(1, 0, c * 0.12);
  };
}

Matrix4 Function(double) _depthPivotMatrix(double baseT, double shift) {
  return (t) {
    final p = (t + baseT * 0.12 + shift * 0.4) % 1.0;
    final s = math.sin(p * math.pi * 2);
    final c = math.cos(p * math.pi * 2);
    return Matrix4.identity()
      ..setEntry(3, 2, -0.0018)
      ..rotateY(s * 0.65)
      ..rotateX(c * 0.25)
      ..translateByDouble(s * 22, c * 12, s * 12, 1);
  };
}

Matrix4 _keyframeMatrix(double t) {
  if (t < 0.2) {
    final x = t / 0.2;
    return Matrix4.identity()..translateByDouble(_lerp(0, 34, x), _lerp(0, -18, x), 0, 1);
  }
  if (t < 0.42) {
    final x = (t - 0.2) / 0.22;
    return Matrix4.identity()
      ..translateByDouble(_lerp(34, -20, x), _lerp(-18, 16, x), 0, 1)
      ..rotateZ(_lerp(0, 0.85, x));
  }
  if (t < 0.64) {
    final x = (t - 0.42) / 0.22;
    return Matrix4.identity()
      ..setEntry(3, 2, -0.0014)
      ..rotateY(_lerp(0.0, 0.6, x))
      ..scaleByDouble(_lerp(1.0, 1.22, x), _lerp(1.0, 0.86, x), 1, 1);
  }
  if (t < 0.84) {
    final x = (t - 0.64) / 0.20;
    return Matrix4.identity()
      ..translateByDouble(_lerp(-20, 12, x), _lerp(16, 8, x), 0, 1)
      ..setEntry(0, 1, _lerp(0.0, 0.22, x))
      ..setEntry(1, 0, _lerp(0.0, -0.18, x));
  }
  final x = (t - 0.84) / 0.16;
  return Matrix4.identity()
    ..translateByDouble(_lerp(12, 0, x), _lerp(8, 0, x), 0, 1)
    ..rotateZ(_lerp(0.2, 0, x))
    ..scaleByDouble(_lerp(1.06, 1.0, x), _lerp(1.06, 1.0, x), 1, 1);
}

double _lerp(double a, double b, double t) => a + (b - a) * t;

String _clock() => DateTime.now().toIso8601String().substring(11, 19);
