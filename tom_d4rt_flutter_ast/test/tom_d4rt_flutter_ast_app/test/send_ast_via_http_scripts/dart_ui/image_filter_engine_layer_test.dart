// D4rt test script: Deep demo for ImageFilterEngineLayer from dart:ui.
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _ImageFilterEngineLayerDemo(),
  );
}

class _ImageFilterEngineLayerDemo extends StatefulWidget {
  const _ImageFilterEngineLayerDemo();

  @override
  State<_ImageFilterEngineLayerDemo> createState() => _ImageFilterEngineLayerDemoState();
}

class _ImageFilterEngineLayerDemoState extends State<_ImageFilterEngineLayerDemo> {
  double _sigmaX = 6;
  double _sigmaY = 6;
  double _matrixStrength = 0.25;
  bool _animate = true;
  bool _showGrid = true;
  bool _showOverlay = true;
  int _paletteIndex = 0;

  double _animValue = 0.0;

  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];

  final List<List<Color>> _palettes = <List<Color>>[
    <Color>[const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF38BDF8)],
    <Color>[const Color(0xFF4C1D95), const Color(0xFF6D28D9), const Color(0xFFC4B5FD)],
    <Color>[const Color(0xFF0B3D2E), const Color(0xFF166534), const Color(0xFF86EFAC)],
  ];

  @override
  void initState() {
    super.initState();
    _runProbes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ui.ImageFilter _blurFilter() {
    return ui.ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY);
  }

  ui.ImageFilter _dilateFilter() {
    return ui.ImageFilter.dilate(radiusX: (_sigmaX / 3).clamp(0.1, 6), radiusY: (_sigmaY / 3).clamp(0.1, 6));
  }

  ui.ImageFilter _erodeFilter() {
    return ui.ImageFilter.erode(radiusX: (_sigmaX / 4).clamp(0.1, 4), radiusY: (_sigmaY / 4).clamp(0.1, 4));
  }

  ui.ImageFilter _matrixFilter() {
    final double s = _matrixStrength;
    return ui.ImageFilter.matrix(Float64List.fromList(<double>[
      1, s, 0, 0,
      0, 1, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    ]));
  }

  void _record(String label, bool value) {
    if (value) {
      _passed.add(label);
    } else {
      _failed.add(label);
    }
  }

  void _runProbes() {
    _passed.clear();
    _failed.clear();

    try {
      final ui.ImageFilter blur = _blurFilter();
      _record('ImageFilter.blur creation', blur.runtimeType.toString().contains('ImageFilter'));
    } catch (_) {
      _record('ImageFilter.blur creation', false);
    }

    try {
      final ui.SceneBuilder b = ui.SceneBuilder();
      final ui.ImageFilterEngineLayer layer = b.pushImageFilter(_blurFilter());
      b.pop();
      _record('SceneBuilder.pushImageFilter returns engine layer',
          layer.runtimeType == ui.ImageFilterEngineLayer);
    } catch (_) {
      _record('SceneBuilder.pushImageFilter returns engine layer', false);
    }

    try {
      final ui.SceneBuilder one = ui.SceneBuilder();
      final ui.ImageFilterEngineLayer oldLayer = one.pushImageFilter(_blurFilter());
      one.pop();

      final ui.SceneBuilder two = ui.SceneBuilder();
      final ui.ImageFilterEngineLayer reused =
          two.pushImageFilter(_dilateFilter(), oldLayer: oldLayer);
      two.pop();
      _record('oldLayer reuse path works', reused.runtimeType.toString().contains('ImageFilterEngineLayer'));
    } catch (_) {
      _record('oldLayer reuse path works', false);
    }

    try {
      final ui.SceneBuilder b = ui.SceneBuilder();
      b.pushImageFilter(_blurFilter());
      b.pushImageFilter(_erodeFilter());
      b.pop();
      b.pop();
      _record('Nested push/pop filter layers', true);
    } catch (_) {
      _record('Nested push/pop filter layers', false);
    }

    try {
      final ui.SceneBuilder b = ui.SceneBuilder();
      final ui.ImageFilterEngineLayer layer = b.pushImageFilter(_matrixFilter());
      b.pop();
      _record('Matrix filter pushes engine layer', layer.runtimeType.toString().contains('ImageFilterEngineLayer'));
    } catch (_) {
      _record('Matrix filter pushes engine layer', false);
    }
  }

  Widget _sectionTitle(String title, String subtitle, IconData icon, Color accent) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withAlpha(22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withAlpha(90)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withAlpha(36),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: accent)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12.2)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final List<Color> palette = _palettes[_paletteIndex];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: palette),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: palette[1].withAlpha(95),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ImageFilterEngineLayer',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'Produced by SceneBuilder.pushImageFilter. '
            'This layer applies image filters in compositor space and is ideal for blur/glass '
            'effects, stylized transitions, and layered post-processing in Flutter rendering.',
            style: TextStyle(color: Colors.white, fontSize: 13.2, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _baseVisual() {
    final List<Color> palette = _palettes[_paletteIndex];
    return SizedBox(
      width: 280,
      height: 170,
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
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          if (_showGrid)
            const Positioned.fill(child: CustomPaint(painter: _FilterGridPainter())),
          Positioned(
            left: 18,
            top: 16,
            child: Container(
              width: 110,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(70),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            right: 22,
            bottom: 20,
            child: Transform.rotate(
              angle: -0.16,
              child: Container(
                width: 110,
                height: 62,
                decoration: BoxDecoration(
                  color: Colors.orange.withAlpha(120),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          if (_showOverlay)
            Positioned(
              top: 8,
              right: 10,
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(70),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _filterCard(String title, String details, ui.ImageFilter filter) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD9E2EC)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 3),
            Text(details, style: const TextStyle(fontSize: 11.8)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageFiltered(
                imageFilter: filter,
                child: _baseVisual(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterGallery() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _filterCard(
                'Blur',
                'Softens the full layer; great for depth and glass effects.',
                _blurFilter(),
              ),
              _filterCard(
                'Dilate',
                'Expands bright regions and thickens edges.',
                _dilateFilter(),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              _filterCard(
                'Erode',
                'Shrinks bright regions and sharpens silhouettes.',
                _erodeFilter(),
              ),
              _filterCard(
                'Matrix',
                'Applies transform matrix; useful for subtle shear and stylization.',
                _matrixFilter(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlLab() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE4EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Interactive filter lab', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Sigma X: ${_sigmaX.toStringAsFixed(1)}'),
          Slider(
            value: _sigmaX,
            min: 0.1,
            max: 24,
            divisions: 239,
            onChanged: (double value) {
              setState(() {
                _sigmaX = value;
                _runProbes();
              });
            },
          ),
          Text('Sigma Y: ${_sigmaY.toStringAsFixed(1)}'),
          Slider(
            value: _sigmaY,
            min: 0.1,
            max: 24,
            divisions: 239,
            onChanged: (double value) {
              setState(() {
                _sigmaY = value;
                _runProbes();
              });
            },
          ),
          Text('Matrix strength: ${_matrixStrength.toStringAsFixed(2)}'),
          Slider(
            value: _matrixStrength,
            min: 0,
            max: 0.8,
            divisions: 80,
            onChanged: (double value) {
              setState(() {
                _matrixStrength = value;
                _runProbes();
              });
            },
          ),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: <Widget>[
              FilterChip(
                label: const Text('Animate source'),
                selected: _animate,
                onSelected: (bool v) {
                  setState(() {
                    _animate = v;
                    if (_animate) {
                      /* animation removed */
                    } else {
                      /* animation removed */
                    }
                  });
                },
              ),
              FilterChip(
                label: const Text('Grid'),
                selected: _showGrid,
                onSelected: (bool v) {
                  setState(() {
                    _showGrid = v;
                  });
                },
              ),
              FilterChip(
                label: const Text('Overlay'),
                selected: _showOverlay,
                onSelected: (bool v) {
                  setState(() {
                    _showOverlay = v;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  setState(_runProbes);
                },
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Re-run probes'),
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
        ],
      ),
    );
  }

  Widget _buildAnimatedView() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE4EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Animated filtered viewport', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Center(
            child: Transform.translate(
              offset: Offset(_animate ? (_animValue * 26) : 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ImageFiltered(
                  imageFilter: _blurFilter(),
                  child: _baseVisual(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This demonstrates filter output on moving content, which mirrors real transition scenes.',
            style: TextStyle(fontSize: 12.2),
          ),
        ],
      ),
    );
  }

  Widget _buildLayerStack() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE4EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Layered filter composition', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          SizedBox(
            width: 310,
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 18,
                  top: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ImageFiltered(imageFilter: _dilateFilter(), child: _baseVisual()),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 32,
                  child: Opacity(
                    opacity: 0.86,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ImageFiltered(imageFilter: _blurFilter(), child: _baseVisual()),
                    ),
                  ),
                ),
                Positioned(
                  left: 42,
                  top: 44,
                  child: Opacity(
                    opacity: 0.78,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ImageFiltered(imageFilter: _matrixFilter(), child: _baseVisual()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Each filtered layer can map to compositor-managed engine layers for incremental updates.',
            style: TextStyle(fontSize: 12.2),
          ),
        ],
      ),
    );
  }

  Widget _buildUseCases() {
    Widget card(String title, String desc, List<Color> colors, IconData icon) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: Colors.white),
              const SizedBox(height: 8),
              Text(title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          card(
            'Frosted overlays',
            'Blur app content behind dialogs and floating panels.',
            const <Color>[Color(0xFF2563EB), Color(0xFF60A5FA)],
            Icons.ac_unit,
          ),
          card(
            'Focus transitions',
            'Use filtered background layers to guide eye focus in route transitions.',
            const <Color>[Color(0xFF7C3AED), Color(0xFFA78BFA)],
            Icons.center_focus_strong,
          ),
          card(
            'Stylized media',
            'Apply matrix and morphology filters for editorial effects.',
            const <Color>[Color(0xFF0F766E), Color(0xFF2DD4BF)],
            Icons.auto_fix_high,
          ),
        ],
      ),
    );
  }

  Widget _buildProbeDashboard() {
    Widget line(String text, bool ok) {
      final Color color = ok ? const Color(0xFF15803D) : const Color(0xFFB91C1C);
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(90)),
        ),
        child: Row(
          children: <Widget>[
            Icon(ok ? Icons.check_circle : Icons.cancel, color: color, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(text, style: const TextStyle(fontSize: 12.2))),
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
        border: Border.all(color: const Color(0xFFDCE4EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('SceneBuilder probe dashboard', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Passed: ${_passed.length}, Failed: ${_failed.length}'),
          const SizedBox(height: 8),
          ..._passed.map((String p) => line(p, true)),
          ..._failed.map((String f) => line(f, false)),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD6E0EA)),
      ),
      child: Text(
        'This deep demo validates ImageFilterEngineLayer behavior by combining rich visual sections '
        'with direct pushImageFilter runtime probes. Adjusting sigma and matrix controls demonstrates '
        'how filter parameters affect both visual output and layer creation behavior in interpreter execution.',
        style: const TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - ImageFilterEngineLayer'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.6,
      ),
      body: ListView(
        children: <Widget>[
          _buildHeader(),
          _sectionTitle(
            '1) Filter gallery',
            'Compare blur, dilate, erode and matrix filters side by side.',
            Icons.grid_view,
            const Color(0xFF2563EB),
          ),
          _buildFilterGallery(),
          _sectionTitle(
            '2) Interactive lab',
            'Tune filter parameters and observe output changes in real time.',
            Icons.tune,
            const Color(0xFF0F766E),
          ),
          _buildControlLab(),
          _sectionTitle(
            '3) Animated viewport',
            'Inspect filtered results while source content moves.',
            Icons.animation,
            const Color(0xFF7C3AED),
          ),
          _buildAnimatedView(),
          _sectionTitle(
            '4) Layer stacking',
            'Visualize composited stacking of multiple filtered layers.',
            Icons.layers,
            const Color(0xFFB45309),
          ),
          _buildLayerStack(),
          _sectionTitle(
            '5) Practical uses',
            'Typical product patterns where engine-level image filtering helps.',
            Icons.widgets,
            const Color(0xFF0EA5E9),
          ),
          _buildUseCases(),
          _sectionTitle(
            '6) Runtime checks',
            'Direct SceneBuilder probes for engine-layer creation and reuse.',
            Icons.fact_check,
            const Color(0xFF166534),
          ),
          _buildProbeDashboard(),
          _sectionTitle(
            '7) Summary',
            'When to use ImageFilterEngineLayer-based rendering paths.',
            Icons.info_outline,
            const Color(0xFF334155),
          ),
          _buildSummary(),
        ],
      ),
    );
  }
}

class _FilterGridPainter extends CustomPainter {
  const _FilterGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1;
    const double gap = 18;
    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _FilterGridPainter oldDelegate) {
    return false;
  }
}
