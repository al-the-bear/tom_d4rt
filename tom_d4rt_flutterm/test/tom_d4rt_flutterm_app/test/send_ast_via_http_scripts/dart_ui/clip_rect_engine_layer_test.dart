// D4rt test script: Deep demo for ClipRectEngineLayer from dart_ui.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _ClipRectEngineLayerDemo(),
  );
}

class _ClipRectEngineLayerDemo extends StatefulWidget {
  const _ClipRectEngineLayerDemo();

  @override
  State<_ClipRectEngineLayerDemo> createState() => _ClipRectEngineLayerDemoState();
}

class _ClipRectEngineLayerDemoState extends State<_ClipRectEngineLayerDemo>
    with SingleTickerProviderStateMixin {
  double _left = 16;
  double _top = 10;
  double _width = 190;
  double _height = 120;
  Clip _clipBehavior = Clip.hardEdge;
  bool _animateWindow = false;
  bool _showGrid = true;
  bool _showGuides = true;
  int _paletteIndex = 0;

  late final AnimationController _controller;

  final List<String> _probePassed = <String>[];
  final List<String> _probeFailed = <String>[];

  final List<List<Color>> _palettes = <List<Color>>[
    <Color>[const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF38BDF8)],
    <Color>[const Color(0xFF311B92), const Color(0xFF512DA8), const Color(0xFFB39DDB)],
    <Color>[const Color(0xFF0B3D2E), const Color(0xFF1E5B46), const Color(0xFF7CCBA2)],
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..addListener(() {
        if (_animateWindow) {
          setState(() {
            _left = 16 + (90 * _controller.value);
            _top = 10 + (45 * (1 - (_controller.value - 0.5).abs() * 2));
          });
        }
      });
    _runSceneBuilderProbes();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Rect _clipRect() {
    final double safeWidth = _width.clamp(60, 260);
    final double safeHeight = _height.clamp(60, 180);
    final double safeLeft = _left.clamp(0, 280 - safeWidth);
    final double safeTop = _top.clamp(0, 180 - safeHeight);
    return Rect.fromLTWH(safeLeft, safeTop, safeWidth, safeHeight);
  }

  void _runProbe(String label, bool Function() body) {
    try {
      if (body()) {
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

    _runProbe('Rect creation for clip bounds', () {
      final Rect rect = _clipRect();
      return rect.width > 0 && rect.height > 0;
    });

    _runProbe('pushClipRect creates ClipRectEngineLayer', () {
      final ui.SceneBuilder builder = ui.SceneBuilder();
      final ui.ClipRectEngineLayer layer = builder.pushClipRect(
        _clipRect(),
        clipBehavior: _clipBehavior,
      );
      builder.pop();
      return layer.runtimeType == ui.ClipRectEngineLayer;
    });

    _runProbe('oldLayer reuse path stays valid', () {
      final ui.SceneBuilder one = ui.SceneBuilder();
      final ui.ClipRectEngineLayer previous = one.pushClipRect(_clipRect());
      one.pop();

      final ui.SceneBuilder two = ui.SceneBuilder();
      final ui.ClipRectEngineLayer reused = two.pushClipRect(
        _clipRect().shift(const Offset(4, 2)),
        oldLayer: previous,
      );
      two.pop();

      return reused.runtimeType.toString().contains('ClipRectEngineLayer');
    });

    _runProbe('nested clip rect push/pop sequence', () {
      final ui.SceneBuilder builder = ui.SceneBuilder();
      builder.pushClipRect(const Rect.fromLTWH(0, 0, 260, 170));
      builder.pushClipRect(const Rect.fromLTWH(18, 16, 200, 120));
      builder.pop();
      builder.pop();
      return true;
    });

    _runProbe('clip behavior switching is accepted', () {
      final ui.SceneBuilder builder = ui.SceneBuilder();
      builder.pushClipRect(_clipRect(), clipBehavior: Clip.hardEdge);
      builder.pop();
      builder.pushClipRect(_clipRect(), clipBehavior: Clip.antiAlias);
      builder.pop();
      return true;
    });
  }

  Widget _sectionTitle(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroHeader() {
    final List<Color> palette = _palettes[_paletteIndex];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: palette),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: palette[1].withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ClipRectEngineLayer',
            style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'Created by SceneBuilder.pushClipRect. '
            'Use it for strict rectangular clipping in compositor-backed scenes: '
            'image crops, viewport masks, and layer-local reveal effects.',
            style: TextStyle(color: Colors.white, fontSize: 13.2, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _overflowCanvas() {
    final List<Color> palette = _palettes[_paletteIndex];
    return SizedBox(
      width: 300,
      height: 200,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[palette[0], palette[1], palette[2]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          if (_showGrid)
            const Positioned.fill(child: CustomPaint(painter: _RectGridPainter())),
          Positioned(
            left: 8,
            top: 20,
            child: Container(
              width: 130,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          Positioned(
            right: -22,
            top: 60,
            child: Container(
              width: 130,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Positioned(
            left: 70,
            bottom: -18,
            child: Transform.rotate(
              angle: 0.2,
              child: Container(
                width: 160,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.24),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _clipBehaviorComparison() {
    Widget card(String title, String note, Clip clip) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD6DEE8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
              const SizedBox(height: 2),
              Text(note, style: const TextStyle(fontSize: 11.3)),
              const SizedBox(height: 8),
              ClipRect(
                clipBehavior: clip,
                child: Align(
                  alignment: Alignment.center,
                  widthFactor: 0.72,
                  heightFactor: 0.68,
                  child: _overflowCanvas(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          card('Clip.none', 'No clipping. Overflow remains visible.', Clip.none),
          card('Clip.hardEdge', 'Fast, hard clipping border.', Clip.hardEdge),
          card('Clip.antiAlias', 'Smoother clipped rectangle edge.', Clip.antiAlias),
        ],
      ),
    );
  }

  Widget _interactiveRectLab() {
    final Rect rect = _clipRect();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDEE5EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Interactive clip rectangle controls',
              style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Left: ${_left.toStringAsFixed(1)}'),
          Slider(
            value: _left,
            min: 0,
            max: 220,
            divisions: 220,
            onChanged: (double value) {
              setState(() {
                _left = value;
                _runSceneBuilderProbes();
              });
            },
          ),
          Text('Top: ${_top.toStringAsFixed(1)}'),
          Slider(
            value: _top,
            min: 0,
            max: 120,
            divisions: 120,
            onChanged: (double value) {
              setState(() {
                _top = value;
                _runSceneBuilderProbes();
              });
            },
          ),
          Text('Width: ${_width.toStringAsFixed(1)}'),
          Slider(
            value: _width,
            min: 60,
            max: 280,
            divisions: 220,
            onChanged: (double value) {
              setState(() {
                _width = value;
                _runSceneBuilderProbes();
              });
            },
          ),
          Text('Height: ${_height.toStringAsFixed(1)}'),
          Slider(
            value: _height,
            min: 60,
            max: 180,
            divisions: 120,
            onChanged: (double value) {
              setState(() {
                _height = value;
                _runSceneBuilderProbes();
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
              FilterChip(
                label: const Text('Show guides'),
                selected: _showGuides,
                onSelected: (bool value) {
                  setState(() {
                    _showGuides = value;
                  });
                },
              ),
              FilterChip(
                label: const Text('Show grid'),
                selected: _showGrid,
                onSelected: (bool value) {
                  setState(() {
                    _showGrid = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 300,
              height: 200,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: _overflowCanvas()),
                  Positioned.fill(
                    child: ClipRect(
                      clipBehavior: _clipBehavior,
                      child: Align(
                        alignment: Alignment.topLeft,
                        widthFactor: rect.width / 300,
                        heightFactor: rect.height / 200,
                        child: Transform.translate(
                          offset: Offset(-rect.left, -rect.top),
                          child: _overflowCanvas(),
                        ),
                      ),
                    ),
                  ),
                  if (_showGuides)
                    Positioned.fromRect(
                      rect: rect,
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Rect.fromLTWH(${rect.left.toStringAsFixed(1)}, '
            '${rect.top.toStringAsFixed(1)}, ${rect.width.toStringAsFixed(1)}, '
            '${rect.height.toStringAsFixed(1)})',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _animatedRevealSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE5EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Animated clip window (reveal/crop behavior)',
              style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _animateWindow = !_animateWindow;
                    if (_animateWindow) {
                      _controller.repeat(reverse: true);
                    } else {
                      _controller.stop();
                    }
                  });
                },
                icon: Icon(_animateWindow ? Icons.pause : Icons.play_arrow, size: 18),
                label: Text(_animateWindow ? 'Pause' : 'Play animation'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _paletteIndex = (_paletteIndex + 1) % _palettes.length;
                  });
                },
                icon: const Icon(Icons.palette_outlined, size: 18),
                label: const Text('Palette'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: ClipRect(
              clipBehavior: _clipBehavior,
              child: SizedBox(width: 300, height: 200, child: _overflowCanvas()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nestedClipSection() {
    Widget layerCard({required String title, required Color color, required double inset}) {
      return Positioned(
        left: inset,
        top: inset,
        child: ClipRect(
          clipBehavior: _clipBehavior,
          child: SizedBox(
            width: 260 - (inset * 1.2),
            height: 160 - inset,
            child: Container(
              color: color,
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDDE4EE)),
      ),
      child: Column(
        children: <Widget>[
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Nested rectangular clips', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 280,
            height: 180,
            child: Stack(
              children: <Widget>[
                layerCard(title: 'Layer 1', color: const Color(0xFF334155), inset: 0),
                layerCard(title: 'Layer 2', color: const Color(0xFF0EA5E9), inset: 18),
                layerCard(title: 'Layer 3', color: const Color(0xFF14B8A6), inset: 34),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Each nested clip can become a separate engine layer in a composited frame.',
            style: TextStyle(fontSize: 12.2),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _practicalUseCases() {
    Widget tile(
      IconData icon,
      String title,
      String text,
      List<Color> colors,
    ) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          child: ClipRect(
            clipBehavior: _clipBehavior,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
                borderRadius: BorderRadius.circular(8),
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
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          tile(
            Icons.crop,
            'Thumbnail crop',
            'Keep image previews bounded to strict viewports.',
            const <Color>[Color(0xFF7C3AED), Color(0xFFA78BFA)],
          ),
          tile(
            Icons.view_in_ar,
            'Viewport masking',
            'Reveal only visible region while keeping overflow off-screen.',
            const <Color>[Color(0xFF0369A1), Color(0xFF38BDF8)],
          ),
          tile(
            Icons.dashboard_customize,
            'HUD panels',
            'Clip moving overlays inside rectangular cockpit windows.',
            const <Color>[Color(0xFF0F766E), Color(0xFF2DD4BF)],
          ),
        ],
      ),
    );
  }

  Widget _probeDashboard() {
    Widget entry(String label, bool success) {
      final Color color = success ? const Color(0xFF1D8348) : const Color(0xFFB03A2E);
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Row(
          children: <Widget>[
            Icon(success ? Icons.check_circle : Icons.error, color: color, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 12.4))),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE5EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('SceneBuilder probes', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Passed: ${_probePassed.length}, Failed: ${_probeFailed.length}'),
          const SizedBox(height: 6),
          ..._probePassed.map((String label) => entry(label, true)),
          ..._probeFailed.map((String label) => entry(label, false)),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              setState(_runSceneBuilderProbes);
            },
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Run probes again'),
          ),
        ],
      ),
    );
  }

  Widget _finalSummary() {
    final String mode =
        _clipBehavior == Clip.hardEdge ? 'performance-first' : 'quality-first';
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD8E2EF)),
      ),
      child: Text(
        'ClipRectEngineLayer deep demo complete.\n'
        'Current clip strategy: $mode.\n'
        'Use ClipRect-based layer clipping when a strict rectangular viewport '
        'is needed in a composited rendering pipeline.',
        style: const TextStyle(fontSize: 12.5, height: 1.4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - ClipRectEngineLayer'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.6,
      ),
      body: ListView(
        children: <Widget>[
          _heroHeader(),
          _sectionTitle(
            '1) Clip mode comparison',
            'Visualize rectangle clipping behavior across clip modes.',
            Icons.compare_arrows,
            const Color(0xFF1D4ED8),
          ),
          _clipBehaviorComparison(),
          _sectionTitle(
            '2) Interactive clip rectangle lab',
            'Adjust left/top/width/height and inspect clip window behavior.',
            Icons.tune,
            const Color(0xFF0F766E),
          ),
          _interactiveRectLab(),
          _sectionTitle(
            '3) Animated reveal viewport',
            'Simulate moving crop windows used in transitions and carousels.',
            Icons.animation,
            const Color(0xFF7C3AED),
          ),
          _animatedRevealSection(),
          _sectionTitle(
            '4) Layer composition',
            'Nested rectangular clips and their compositor mental model.',
            Icons.layers,
            const Color(0xFFB45309),
          ),
          _nestedClipSection(),
          _sectionTitle(
            '5) Real-world use cases',
            'Thumbnail crops, viewport masks, and constrained overlays.',
            Icons.widgets,
            const Color(0xFF4F46E5),
          ),
          _practicalUseCases(),
          _sectionTitle(
            '6) Runtime diagnostics',
            'Direct SceneBuilder.pushClipRect checks for engine-layer workflow.',
            Icons.fact_check,
            const Color(0xFF166534),
          ),
          _probeDashboard(),
          _sectionTitle(
            '7) Summary',
            'Guidance on when and why to use ClipRectEngineLayer-backed clipping.',
            Icons.info_outline,
            const Color(0xFF334155),
          ),
          _finalSummary(),
        ],
      ),
    );
  }
}

class _RectGridPainter extends CustomPainter {
  const _RectGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1;
    const double gap = 20;
    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RectGridPainter oldDelegate) {
    return false;
  }
}
