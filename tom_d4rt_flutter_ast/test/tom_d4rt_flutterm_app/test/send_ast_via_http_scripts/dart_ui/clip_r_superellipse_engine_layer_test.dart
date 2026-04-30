// D4rt test script: Deep demo for ClipRSuperellipseEngineLayer from dart_ui.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _ClipRSuperellipseEngineLayerDemo(),
  );
}

class _ClipRSuperellipseEngineLayerDemo extends StatefulWidget {
  const _ClipRSuperellipseEngineLayerDemo();

  @override
  State<_ClipRSuperellipseEngineLayerDemo> createState() =>
      _ClipRSuperellipseEngineLayerDemoState();
}

class _ClipRSuperellipseEngineLayerDemoState
    extends State<_ClipRSuperellipseEngineLayerDemo> {
  double _radius = 30;
  double _padding = 14;
  double _stroke = 3;
  bool _animate = true;
  bool _showGrid = true;
  bool _showGlow = true;
  Clip _clipBehavior = Clip.antiAlias;
  int _paletteIndex = 0;

  final List<String> _probePassed = <String>[];
  final List<String> _probeFailed = <String>[];

  final List<List<Color>> _palettes = <List<Color>>[
    <Color>[const Color(0xFF0B132B), const Color(0xFF1C2541), const Color(0xFF5BC0BE)],
    <Color>[const Color(0xFF0D1B2A), const Color(0xFF1B263B), const Color(0xFF415A77)],
    <Color>[const Color(0xFF14213D), const Color(0xFFFCA311), const Color(0xFFE5E5E5)],
  ];

  @override
  void initState() {
    super.initState();
    _runSceneBuilderProbes();
  }

  void _runProbe(String label, bool Function() body) {
    try {
      final bool result = body();
      if (result) {
        _probePassed.add(label);
      } else {
        _probeFailed.add(label);
      }
    } catch (_) {
      _probeFailed.add('$label threw');
    }
  }

  void _runSceneBuilderProbes() {
    _probePassed.clear();
    _probeFailed.clear();

    _runProbe('RSuperellipse object creation', () {
      final ui.RSuperellipse shape = ui.RSuperellipse.fromRectAndCorners(
        const Rect.fromLTWH(0, 0, 220, 140),
        topLeft: const Radius.circular(24),
        topRight: const Radius.circular(24),
        bottomLeft: const Radius.circular(24),
        bottomRight: const Radius.circular(24),
      );
      return shape.width == 220;
    });

    _runProbe('pushClipRSuperellipse returns engine layer', () {
      final ui.SceneBuilder builder = ui.SceneBuilder();
      final ui.RSuperellipse shape = ui.RSuperellipse.fromRectAndCorners(
        const Rect.fromLTWH(0, 0, 200, 120),
        topLeft: Radius.circular(_radius),
        topRight: Radius.circular(_radius),
        bottomLeft: Radius.circular(_radius),
        bottomRight: Radius.circular(_radius),
      );
      final ui.ClipRSuperellipseEngineLayer layer = builder.pushClipRSuperellipse(
        shape,
        clipBehavior: _clipBehavior,
      );
      builder.pop();
      return layer.runtimeType == ui.ClipRSuperellipseEngineLayer;
    });

    _runProbe('layer reuse via oldLayer parameter', () {
      final ui.SceneBuilder first = ui.SceneBuilder();
      final ui.RSuperellipse shape = ui.RSuperellipse.fromRectAndCorners(
        const Rect.fromLTWH(0, 0, 200, 120),
        topLeft: Radius.circular(_radius),
        topRight: Radius.circular(_radius),
        bottomLeft: Radius.circular(_radius),
        bottomRight: Radius.circular(_radius),
      );
      final ui.ClipRSuperellipseEngineLayer initial = first.pushClipRSuperellipse(shape);
      first.pop();

      final ui.SceneBuilder second = ui.SceneBuilder();
      final ui.ClipRSuperellipseEngineLayer reused = second.pushClipRSuperellipse(
        shape,
        oldLayer: initial,
      );
      second.pop();

      return reused.runtimeType.toString().contains('ClipRSuperellipseEngineLayer');
    });

    _runProbe('nested push/pop works for superellipse clips', () {
      final ui.SceneBuilder builder = ui.SceneBuilder();
      final ui.RSuperellipse outer = ui.RSuperellipse.fromRectAndCorners(
        const Rect.fromLTWH(0, 0, 240, 160),
        topLeft: const Radius.circular(36),
        topRight: const Radius.circular(36),
        bottomLeft: const Radius.circular(36),
        bottomRight: const Radius.circular(36),
      );
      final ui.RSuperellipse inner = ui.RSuperellipse.fromRectAndCorners(
        const Rect.fromLTWH(24, 16, 190, 120),
        topLeft: const Radius.circular(20),
        topRight: const Radius.circular(20),
        bottomLeft: const Radius.circular(20),
        bottomRight: const Radius.circular(20),
      );
      builder.pushClipRSuperellipse(outer, clipBehavior: _clipBehavior);
      builder.pushClipRSuperellipse(inner, clipBehavior: _clipBehavior);
      builder.pop();
      builder.pop();
      return true;
    });

    _runProbe('clip behavior can switch without throwing', () {
      final ui.SceneBuilder builder = ui.SceneBuilder();
      final ui.RSuperellipse shape = ui.RSuperellipse.fromRectAndCorners(
        const Rect.fromLTWH(0, 0, 220, 140),
        topLeft: Radius.circular(_radius),
        topRight: Radius.circular(_radius),
        bottomLeft: Radius.circular(_radius),
        bottomRight: Radius.circular(_radius),
      );
      builder.pushClipRSuperellipse(shape, clipBehavior: Clip.hardEdge);
      builder.pop();
      builder.pushClipRSuperellipse(shape, clipBehavior: Clip.antiAlias);
      builder.pop();
      return true;
    });
  }

  ui.RSuperellipse _currentShape({double inset = 0}) {
    return ui.RSuperellipse.fromRectAndCorners(
      Rect.fromLTWH(inset, inset, 280 - inset * 2, 180 - inset * 2),
      topLeft: Radius.circular(_radius),
      topRight: Radius.circular(_radius),
      bottomLeft: Radius.circular(_radius),
      bottomRight: Radius.circular(_radius),
    );
  }

  Widget _sectionTitle(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.4),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12.5, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _demoArtCard({
    required String title,
    required String caption,
    required Clip clip,
    required List<Color> colors,
    required double localRadius,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(caption, style: const TextStyle(fontSize: 11.5)),
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 1.15,
              child: ClipRSuperellipse(
                clipBehavior: clip,
                borderRadius: BorderRadius.circular(localRadius),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      if (_showGrid)
                        Positioned.fill(
                          child: CustomPaint(painter: _GridPainter(lineColor: Colors.white24)),
                        ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.27),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          width: 110,
                          height: 62,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white60, width: 1.1),
                          ),
                        ),
                      ),
                      if (_showGlow)
                        Positioned(
                          top: -20,
                          left: 40,
                          child: Container(
                            width: 170,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(100),
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
      ),
    );
  }

  Widget _buildHeader() {
    final List<Color> palette = _palettes[_paletteIndex];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: palette),
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: palette[1].withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ClipRSuperellipseEngineLayer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'A compositing engine layer produced by SceneBuilder.pushClipRSuperellipse. '
            'Use it when content should be clipped to smooth superellipse corners, '
            'especially for iOS-style cards and advanced compositor pipelines.',
            style: TextStyle(color: Colors.white, fontSize: 13.5, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _buildClipBehaviorShowcase() {
    final List<Color> palette = _palettes[_paletteIndex];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDBE2EF)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _demoArtCard(
                title: 'Clip.none',
                caption: 'No clipping. Fastest but content can overflow.',
                clip: Clip.none,
                colors: <Color>[palette[0], palette[1], Colors.indigo],
                localRadius: _radius,
              ),
              _demoArtCard(
                title: 'Clip.hardEdge',
                caption: 'Hard edge clip, no anti-alias smoothing.',
                clip: Clip.hardEdge,
                colors: <Color>[palette[1], palette[2], Colors.teal],
                localRadius: _radius,
              ),
              _demoArtCard(
                title: 'Clip.antiAlias',
                caption: 'Smooth clipped edge. Typical choice for UI.',
                clip: Clip.antiAlias,
                colors: <Color>[palette[2], palette[1], Colors.blueGrey],
                localRadius: _radius,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInteractivePanel() {
    final List<Color> palette = _palettes[_paletteIndex];
    final ui.RSuperellipse shape = _currentShape();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDE6ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Interactive Superellipse Playground',
            style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text('Corner radius: ${_radius.toStringAsFixed(1)}'),
          Slider(
            value: _radius,
            min: 4,
            max: 90,
            divisions: 86,
            label: _radius.toStringAsFixed(1),
            onChanged: (double value) {
              setState(() {
                _radius = value;
                _runSceneBuilderProbes();
              });
            },
          ),
          Text('Inner padding: ${_padding.toStringAsFixed(1)}'),
          Slider(
            value: _padding,
            min: 2,
            max: 28,
            divisions: 52,
            onChanged: (double value) {
              setState(() {
                _padding = value;
                _runSceneBuilderProbes();
              });
            },
          ),
          Text('Highlight stroke: ${_stroke.toStringAsFixed(1)}'),
          Slider(
            value: _stroke,
            min: 1,
            max: 8,
            divisions: 28,
            onChanged: (double value) {
              setState(() {
                _stroke = value;
              });
            },
          ),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: <Widget>[
              ChoiceChip(
                label: const Text('hardEdge'),
                selected: _clipBehavior == Clip.hardEdge,
                onSelected: (_) {
                  setState(() {
                    _clipBehavior = Clip.hardEdge;
                    _runSceneBuilderProbes();
                  });
                },
              ),
              ChoiceChip(
                label: const Text('antiAlias'),
                selected: _clipBehavior == Clip.antiAlias,
                onSelected: (_) {
                  setState(() {
                    _clipBehavior = Clip.antiAlias;
                    _runSceneBuilderProbes();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Switch(
                value: _showGrid,
                onChanged: (bool value) {
                  setState(() {
                    _showGrid = value;
                  });
                },
              ),
              const Text('Grid'),
              const SizedBox(width: 10),
              Switch(
                value: _showGlow,
                onChanged: (bool value) {
                  setState(() {
                    _showGlow = value;
                  });
                },
              ),
              const Text('Glow'),
              const SizedBox(width: 10),
              Switch(
                value: _animate,
                onChanged: (bool value) {
                  setState(() {
                    _animate = value;
                  });
                },
              ),
              const Text('Animate'),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: _animate ? 420 : 0),
              curve: Curves.easeOutCubic,
              width: 300,
              height: 200,
              padding: EdgeInsets.all(_padding),
              child: ClipRSuperellipse(
                clipBehavior: _clipBehavior,
                borderRadius: BorderRadius.circular(_radius),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[palette[0], palette[1], palette[2]],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CustomPaint(
                    painter: _OverlayPainter(stroke: _stroke, showGrid: _showGrid),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Current RSuperellipse bounds: '
            '${shape.width.toStringAsFixed(0)} x ${shape.height.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 12.3),
          ),
        ],
      ),
    );
  }

  Widget _buildNestedClipStacks() {
    final List<Color> palette = _palettes[_paletteIndex];
    Widget card(double radius, List<Color> colors, String label) {
      return ClipRSuperellipse(
        clipBehavior: _clipBehavior,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          width: 270,
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD8E2F0)),
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Nested clipping stack (outer and inner superellipse clips)',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 300,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 10,
                  child: card(_radius + 20, <Color>[palette[1], palette[0]], 'Outer Clip'),
                ),
                Positioned(
                  top: 35,
                  child: card(_radius * 0.8, <Color>[palette[2], palette[1]], 'Inner Clip'),
                ),
                Positioned(
                  top: 62,
                  child: card(
                    (_radius * 0.55).clamp(6, 60),
                    <Color>[Colors.black.withValues(alpha: 0.5), palette[2]],
                    'Content Layer',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'In composited rendering, each nested clip can create a dedicated '
            'engine layer. This allows independent invalidation and potential reuse.',
            style: TextStyle(fontSize: 12.2, height: 1.35),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProbeDashboard() {
    Widget tile(String label, bool success) {
      final Color color = success ? const Color(0xFF1B8A5A) : const Color(0xFFB92B27);
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.11),
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Row(
          children: <Widget>[
            Icon(success ? Icons.check_circle : Icons.cancel, color: color, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 12.5))),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'SceneBuilder Probe Dashboard',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Passed: ${_probePassed.length}   Failed: ${_probeFailed.length}',
            style: const TextStyle(fontSize: 12.5),
          ),
          const SizedBox(height: 8),
          ..._probePassed.map((String value) => tile(value, true)),
          ..._probeFailed.map((String value) => tile(value, false)),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  setState(_runSceneBuilderProbes);
                },
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Re-run Probes'),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _paletteIndex = (_paletteIndex + 1) % _palettes.length;
                  });
                },
                icon: const Icon(Icons.palette_outlined, size: 18),
                label: const Text('Change Palette'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPracticalUseCases() {
    Widget useCase({
      required IconData icon,
      required String title,
      required String text,
      required List<Color> colors,
    }) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          child: ClipRSuperellipse(
            borderRadius: BorderRadius.circular(28),
            clipBehavior: _clipBehavior,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(icon, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(text, style: const TextStyle(color: Colors.white, fontSize: 12.2)),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0E6EF)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              useCase(
                icon: Icons.phone_iphone,
                title: 'iOS-style card chrome',
                text: 'Smooth corners keep transitions premium-looking on cards and sheets.',
                colors: const <Color>[Color(0xFF4568DC), Color(0xFFB06AB3)],
              ),
              useCase(
                icon: Icons.image,
                title: 'Media clipping masks',
                text: 'Clip posters and thumbnails with non-circular soft geometry.',
                colors: const <Color>[Color(0xFF134E5E), Color(0xFF71B280)],
              ),
              useCase(
                icon: Icons.auto_awesome,
                title: 'Glass morphic surfaces',
                text: 'Combine blur and superellipse clips for polished floating panels.',
                colors: const <Color>[Color(0xFF614385), Color(0xFF516395)],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSummary() {
    final String quality = _clipBehavior == Clip.antiAlias
        ? 'Smooth edge quality prioritized'
        : 'Performance-first hard edge clipping';
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD5DEE9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Interpreter-focused testing summary',
              style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            '- Engine-layer probes run through SceneBuilder.pushClipRSuperellipse\n'
            '- Visual cards demonstrate practical clipping outcomes\n'
            '- Interactive controls validate dynamic parameter changes\n'
            '- Current mode: $quality',
            style: const TextStyle(fontSize: 12.4, height: 1.35),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FB),
      appBar: AppBar(
        title: const Text('dart:ui - ClipRSuperellipseEngineLayer'),
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1C2541),
      ),
      body: ListView(
        children: <Widget>[
          _buildHeader(),
          _sectionTitle(
            '1) Clip behavior comparison',
            'Visual differences between none, hardEdge and antiAlias clipping.',
            Icons.compare,
            const Color(0xFF37517E),
          ),
          _buildClipBehaviorShowcase(),
          _sectionTitle(
            '2) Interactive parameter lab',
            'Tune radius, padding and clip behavior while observing live rendering.',
            Icons.tune,
            const Color(0xFF0A7E8C),
          ),
          _buildInteractivePanel(),
          _sectionTitle(
            '3) Nested compositor intuition',
            'Understand how nested superellipse clips stack in layered content.',
            Icons.layers,
            const Color(0xFF6A4C93),
          ),
          _buildNestedClipStacks(),
          _sectionTitle(
            '4) Runtime probes and diagnostics',
            'Direct SceneBuilder checks for creation, reuse and pop behavior.',
            Icons.fact_check,
            const Color(0xFF2B6A3F),
          ),
          _buildProbeDashboard(),
          _sectionTitle(
            '5) Practical UI applications',
            'Where ClipRSuperellipseEngineLayer-backed clipping improves UX polish.',
            Icons.widgets,
            const Color(0xFF7B1E7A),
          ),
          _buildPracticalUseCases(),
          _sectionTitle(
            '6) Final notes',
            'Use antiAlias for quality and oldLayer reuse for efficient updates.',
            Icons.info_outline,
            const Color(0xFF2C3E50),
          ),
          _buildFooterSummary(),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.lineColor});

  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    const double gap = 18;
    final Paint paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.lineColor != lineColor;
  }
}

class _OverlayPainter extends CustomPainter {
  _OverlayPainter({required this.stroke, required this.showGrid});

  final double stroke;
  final bool showGrid;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint border = Paint()
      ..color = Colors.white.withValues(alpha: 0.74)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    final RRect frame = RRect.fromRectAndRadius(
      Rect.fromLTWH(16, 16, size.width - 32, size.height - 32),
      const Radius.circular(18),
    );
    canvas.drawRRect(frame, border);

    final Paint circle = Paint()..color = Colors.white.withValues(alpha: 0.22);
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.34), 24, circle);
    canvas.drawCircle(Offset(size.width * 0.72, size.height * 0.64), 34, circle);

    if (showGrid) {
      final Paint marker = Paint()
        ..color = Colors.white.withValues(alpha: 0.36)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      final Rect guide = Rect.fromLTWH(26, 26, size.width - 52, size.height - 52);
      canvas.drawRect(guide, marker);
      canvas.drawLine(
        Offset(size.width / 2, 26),
        Offset(size.width / 2, size.height - 26),
        marker,
      );
      canvas.drawLine(
        Offset(26, size.height / 2),
        Offset(size.width - 26, size.height / 2),
        marker,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _OverlayPainter oldDelegate) {
    return oldDelegate.stroke != stroke || oldDelegate.showGrid != showGrid;
  }
}
