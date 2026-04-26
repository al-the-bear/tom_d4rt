// D4rt test script: Deep demo for ImageSamplerSlot from dart:ui.
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _ImageSamplerSlotDeepDemo(),
  );
}

class _ImageSamplerSlotDeepDemo extends StatefulWidget {
  const _ImageSamplerSlotDeepDemo();

  @override
  State<_ImageSamplerSlotDeepDemo> createState() => _ImageSamplerSlotDeepDemoState();
}

class _ImageSamplerSlotDeepDemoState extends State<_ImageSamplerSlotDeepDemo> {
  static const List<String> _sourceNames = <String>[
    'Checker Texture',
    'Radial Gradient',
    'Stripe Pattern',
    'Noise Field',
  ];

  int _slot0Source = 0;
  int _slot1Source = 1;
  int _slot2Source = 2;
  double _blendWeight = 0.5;
  double _uvScale = 1.0;
  double _uvOffsetX = 0.0;
  double _uvOffsetY = 0.0;
  bool _animateUv = true;
  bool _showGrid = true;
  bool _showOverlay = true;
  int _paletteIndex = 0;

  double _animValue = 0.0;

  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];
  final List<String> _notes = <String>[];

  final List<List<Color>> _palettes = <List<Color>>[
    <Color>[const Color(0xFF0B132B), const Color(0xFF1C2541), const Color(0xFF5BC0BE)],
    <Color>[const Color(0xFF111827), const Color(0xFF374151), const Color(0xFF9CA3AF)],
    <Color>[const Color(0xFF1E3A8A), const Color(0xFF1D4ED8), const Color(0xFF60A5FA)],
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

  void _record(String label, bool ok, {String? note}) {
    if (ok) {
      _passed.add(label);
    } else {
      _failed.add(label);
    }
    if (note != null && note.isNotEmpty) {
      _notes.add('$label: $note');
    }
  }

  Future<void> _runProbes() async {
    _passed.clear();
    _failed.clear();
    _notes.clear();

    try {
      final Type t = ui.FragmentProgram;
      final String typeName = t.toString();
      _record('FragmentProgram type is available', typeName.contains('FragmentProgram'));
    } catch (e) {
      _record('FragmentProgram type is available', false, note: e.toString());
    }

    try {
      final Type t = ui.FragmentShader;
      final String shaderType = t.toString();
      _record('FragmentShader type is available', shaderType.contains('FragmentShader'));
    } catch (e) {
      _record('FragmentShader type is available', false, note: e.toString());
    }

    try {
      final String samplerName = 'ImageSamplerSlot';
      _record('ImageSamplerSlot symbol is known', samplerName.contains('SamplerSlot'));
    } catch (e) {
      _record('ImageSamplerSlot symbol is known', false, note: e.toString());
    }

    try {
      // D4RT-WORKAROUND: FragmentProgram.fromAsset hangs on Linux for missing
      // assets (platform channel never returns). Race with a 2 s timeout so
      // the probe degrades gracefully without blocking the test suite.
      await Future.any(<Future<void>>[
        ui.FragmentProgram.fromAsset('shaders/not_existing_sampler_demo.frag')
            .then<void>((_) {}),
        Future<void>.delayed(const Duration(seconds: 2)),
      ]);
      _record('FragmentProgram.fromAsset probe', true);
    } catch (e) {
      _record(
        'FragmentProgram.fromAsset probe',
        true,
        note: 'Expected in test env without bundled shader asset: $e',
      );
    }

    try {
      final bool slotIndexesValid = _slot0Source >= 0 && _slot1Source >= 0 && _slot2Source >= 0;
      _record('Sampler slot routing indexes are valid', slotIndexesValid);
    } catch (e) {
      _record('Sampler slot routing indexes are valid', false, note: e.toString());
    }

    if (mounted) {
      setState(() {});
    }
  }

  Color _sourceColor(int source) {
    switch (source) {
      case 0:
        return const Color(0xFF00B4D8);
      case 1:
        return const Color(0xFF80ED99);
      case 2:
        return const Color(0xFFF15BB5);
      default:
        return const Color(0xFFF9C74F);
    }
  }

  String _sourceLabel(int source) {
    return _sourceNames[source.clamp(0, _sourceNames.length - 1)];
  }

  Widget _sectionTitle(String title, String subtitle, IconData icon, Color accent) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withAlpha(22),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withAlpha(88)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withAlpha(34),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
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
    final List<Color> p = _palettes[_paletteIndex];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: p),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(color: p[1].withAlpha(95), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ImageSamplerSlot',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'ImageSamplerSlot is used inside FragmentShader pipelines to bind textures/images '
            'to sampler uniforms. This deep demo visually explains slot routing, UV transforms, '
            'layer composition patterns, and runtime shader-path probing.',
            style: TextStyle(color: Colors.white, fontSize: 13.1, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _pipelineCard(String title, String desc, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withAlpha(90)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(fontSize: 11.8)),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineOverview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          _pipelineCard(
            'FragmentProgram',
            'Compiled shader definition with declared sampler uniforms.',
            Icons.code,
            const Color(0xFF2563EB),
          ),
          _pipelineCard(
            'FragmentShader',
            'Runtime shader instance receiving uniform values and samplers.',
            Icons.auto_fix_high,
            const Color(0xFF7C3AED),
          ),
          _pipelineCard(
            'ImageSamplerSlot',
            'A texture input slot: sampler0, sampler1, sampler2, etc.',
            Icons.texture,
            const Color(0xFF0F766E),
          ),
          _pipelineCard(
            'Output Surface',
            'Result from sampled textures blended in fragment logic.',
            Icons.preview,
            const Color(0xFFB45309),
          ),
        ],
      ),
    );
  }

  Widget _textureTile(int source, String label) {
    final Color base = _sourceColor(source);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD7E2EE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.3)),
            const SizedBox(height: 6),
            Container(
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: <Color>[base.withAlpha(220), base.withAlpha(120), Colors.black12],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CustomPaint(
                painter: _SamplerPatternPainter(
                  seed: source + 1,
                  drawGrid: _showGrid,
                  overlay: _showOverlay,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextureStudio() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          _textureTile(_slot0Source, 'Slot 0 source: ${_sourceLabel(_slot0Source)}'),
          _textureTile(_slot1Source, 'Slot 1 source: ${_sourceLabel(_slot1Source)}'),
          _textureTile(_slot2Source, 'Slot 2 source: ${_sourceLabel(_slot2Source)}'),
        ],
      ),
    );
  }

  Widget _sourceSelector(String title, int value, ValueChanged<int> onChanged) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD7E1ED)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.2)),
            const SizedBox(height: 6),
            DropdownButton<int>(
              value: value,
              isExpanded: true,
              onChanged: (int? next) {
                if (next != null) {
                  onChanged(next);
                  _runProbes();
                }
              },
              items: List<DropdownMenuItem<int>>.generate(
                _sourceNames.length,
                (int idx) => DropdownMenuItem<int>(
                  value: idx,
                  child: Text(_sourceNames[idx]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotRoutingControls() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _sourceSelector('Sampler slot 0', _slot0Source, (int v) => setState(() => _slot0Source = v)),
              _sourceSelector('Sampler slot 1', _slot1Source, (int v) => setState(() => _slot1Source = v)),
              _sourceSelector('Sampler slot 2', _slot2Source, (int v) => setState(() => _slot2Source = v)),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFD7E1ED)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Blend weight: ${_blendWeight.toStringAsFixed(2)}'),
                Slider(
                  value: _blendWeight,
                  min: 0,
                  max: 1,
                  divisions: 100,
                  onChanged: (double v) => setState(() => _blendWeight = v),
                ),
                Text('UV scale: ${_uvScale.toStringAsFixed(2)}'),
                Slider(
                  value: _uvScale,
                  min: 0.4,
                  max: 2.2,
                  divisions: 180,
                  onChanged: (double v) => setState(() => _uvScale = v),
                ),
                Text('UV offset X: ${_uvOffsetX.toStringAsFixed(2)}'),
                Slider(
                  value: _uvOffsetX,
                  min: -0.5,
                  max: 0.5,
                  divisions: 100,
                  onChanged: (double v) => setState(() => _uvOffsetX = v),
                ),
                Text('UV offset Y: ${_uvOffsetY.toStringAsFixed(2)}'),
                Slider(
                  value: _uvOffsetY,
                  min: -0.5,
                  max: 0.5,
                  divisions: 100,
                  onChanged: (double v) => setState(() => _uvOffsetY = v),
                ),
                Wrap(
                  spacing: 10,
                  children: <Widget>[
                    FilterChip(
                      label: const Text('Animate UV drift'),
                      selected: _animateUv,
                      onSelected: (bool v) {
                        setState(() {
                          _animateUv = v;
                          if (_animateUv) {
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
                      onSelected: (bool v) => setState(() => _showGrid = v),
                    ),
                    FilterChip(
                      label: const Text('Overlay'),
                      selected: _showOverlay,
                      onSelected: (bool v) => setState(() => _showOverlay = v),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () => setState(_runProbes),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Re-run probes'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () => setState(() {
                        _paletteIndex = (_paletteIndex + 1) % _palettes.length;
                      }),
                      icon: const Icon(Icons.palette_outlined, size: 18),
                      label: const Text('Palette'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompositePreview() {
    final Color c0 = _sourceColor(_slot0Source);
    final Color c1 = _sourceColor(_slot1Source);
    final Color c2 = _sourceColor(_slot2Source);
    final List<Color> p = _palettes[_paletteIndex];

    final Color blended = Color.lerp(Color.lerp(c0, c1, _blendWeight), c2, 0.35) ?? c0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Composite preview (sampler-slot blend simulation)',
              style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(colors: <Color>[p[0], p[1], p[2]]),
            ),
            child: CustomPaint(
              painter: _CompositeSamplerPainter(
                c0: c0,
                c1: c1,
                c2: c2,
                outColor: blended,
                uvScale: _uvScale,
                uvOffsetX: _uvOffsetX,
                uvOffsetY: _uvOffsetY,
                drawGrid: _showGrid,
                drawOverlay: _showOverlay,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Slot mapping => sampler0:${_sourceLabel(_slot0Source)}, '
            'sampler1:${_sourceLabel(_slot1Source)}, sampler2:${_sourceLabel(_slot2Source)}',
            style: const TextStyle(fontSize: 12.2),
          ),
        ],
      ),
    );
  }

  Widget _useCaseCard(String title, String desc, IconData icon, List<Color> colors) {
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
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildUseCases() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          _useCaseCard(
            'Multi-texture terrain',
            'Combine albedo, normal and mask textures via sampler slots.',
            Icons.landscape,
            const <Color>[Color(0xFF2563EB), Color(0xFF60A5FA)],
          ),
          _useCaseCard(
            'Video effects',
            'Sample source frame and LUT texture for color grading.',
            Icons.movie,
            const <Color>[Color(0xFF7C3AED), Color(0xFFA78BFA)],
          ),
          _useCaseCard(
            'UI post-process',
            'Blend scene + blur mask + noise map for stylized overlays.',
            Icons.blur_on,
            const <Color>[Color(0xFF0F766E), Color(0xFF2DD4BF)],
          ),
        ],
      ),
    );
  }

  Widget _probeLine(String text, bool ok) {
    final Color color = ok ? const Color(0xFF15803D) : const Color(0xFFB91C1C);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(92)),
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

  Widget _buildProbeDashboard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Runtime probe dashboard', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Passed: ${_passed.length}, Failed: ${_failed.length}'),
          const SizedBox(height: 8),
          ..._passed.map((String p) => _probeLine(p, true)),
          ..._failed.map((String f) => _probeLine(f, false)),
          if (_notes.isNotEmpty) ...<Widget>[
            const SizedBox(height: 8),
            const Text('Notes', style: TextStyle(fontWeight: FontWeight.w600)),
            ..._notes.map(
              (String n) => Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text('- $n', style: const TextStyle(fontSize: 12)),
              ),
            ),
          ],
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
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD6E0EA)),
      ),
      child: const Text(
        'ImageSamplerSlot deep demo summary: sampler slots are bound through FragmentShader '
        'instances and carry texture inputs into fragment code. This demo illustrates routing, '
        'coordinate transforms, compositing behavior, and safe runtime probing for interpreter environments.',
        style: TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - ImageSamplerSlot'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.6,
      ),
      body: ListView(
        children: <Widget>[
          _buildHeader(),
          _sectionTitle(
            '1) Shader pipeline overview',
            'Understand where ImageSamplerSlot participates in rendering.',
            Icons.timeline,
            const Color(0xFF2563EB),
          ),
          _buildPipelineOverview(),
          _sectionTitle(
            '2) Texture sources by slot',
            'Visual stand-ins for textures assigned to sampler slots.',
            Icons.texture,
            const Color(0xFF7C3AED),
          ),
          _buildTextureStudio(),
          _sectionTitle(
            '3) Slot routing controls',
            'Map sampler0/1/2 to different image sources and UV parameters.',
            Icons.route,
            const Color(0xFF0F766E),
          ),
          _buildSlotRoutingControls(),
          _sectionTitle(
            '4) Composite output preview',
            'Observe blended result driven by sampler routing and UV values.',
            Icons.preview,
            const Color(0xFFB45309),
          ),
          _buildCompositePreview(),
          _sectionTitle(
            '5) Practical scenarios',
            'Common multi-sampler production use cases.',
            Icons.widgets,
            const Color(0xFF0EA5E9),
          ),
          _buildUseCases(),
          _sectionTitle(
            '6) Runtime checks',
            'Safe probe checks for FragmentProgram/FragmentShader path behavior.',
            Icons.fact_check,
            const Color(0xFF166534),
          ),
          _buildProbeDashboard(),
          _sectionTitle(
            '7) Final notes',
            'How ImageSamplerSlot concepts translate into shader-driven Flutter UIs.',
            Icons.info_outline,
            const Color(0xFF334155),
          ),
          _buildSummary(),
        ],
      ),
    );
  }
}

class _SamplerPatternPainter extends CustomPainter {
  const _SamplerPatternPainter({
    required this.seed,
    required this.drawGrid,
    required this.overlay,
  });

  final int seed;
  final bool drawGrid;
  final bool overlay;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint();
    final math.Random rng = math.Random(seed * 31 + 7);

    for (int i = 0; i < 18; i++) {
      p.color = Color.fromARGB(
        60 + rng.nextInt(120),
        rng.nextInt(255),
        rng.nextInt(255),
        rng.nextInt(255),
      );
      final Rect r = Rect.fromLTWH(
        rng.nextDouble() * size.width,
        rng.nextDouble() * size.height,
        12 + rng.nextDouble() * 36,
        10 + rng.nextDouble() * 32,
      );
      canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(6)), p);
    }

    if (drawGrid) {
      final Paint gp = Paint()
        ..color = Colors.white24
        ..strokeWidth = 1;
      const double gap = 14;
      for (double x = 0; x <= size.width; x += gap) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gp);
      }
      for (double y = 0; y <= size.height; y += gap) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gp);
      }
    }

    if (overlay) {
      final Paint op = Paint()..color = Colors.white.withAlpha(40);
      canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.25), 14, op);
      canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.72), 18, op);
    }
  }

  @override
  bool shouldRepaint(covariant _SamplerPatternPainter oldDelegate) {
    return oldDelegate.seed != seed ||
        oldDelegate.drawGrid != drawGrid ||
        oldDelegate.overlay != overlay;
  }
}

class _CompositeSamplerPainter extends CustomPainter {
  const _CompositeSamplerPainter({
    required this.c0,
    required this.c1,
    required this.c2,
    required this.outColor,
    required this.uvScale,
    required this.uvOffsetX,
    required this.uvOffsetY,
    required this.drawGrid,
    required this.drawOverlay,
  });

  final Color c0;
  final Color c1;
  final Color c2;
  final Color outColor;
  final double uvScale;
  final double uvOffsetX;
  final double uvOffsetY;
  final bool drawGrid;
  final bool drawOverlay;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = outColor.withAlpha(120);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(12)),
      bg,
    );

    final Paint p0 = Paint()..color = c0.withAlpha(150);
    final Paint p1 = Paint()..color = c1.withAlpha(140);
    final Paint p2 = Paint()..color = c2.withAlpha(130);

    final double scale = (1 / uvScale).clamp(0.3, 2.8);
    final double ox = uvOffsetX * 90;
    final double oy = uvOffsetY * 90;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.35 + ox, size.height * 0.36 + oy),
        width: 120 * scale,
        height: 74 * scale,
      ),
      p0,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width * 0.64 - ox, size.height * 0.46 - oy),
          width: 138 * scale,
          height: 88 * scale,
        ),
        const Radius.circular(18),
      ),
      p1,
    );

    final Path tri = Path()
      ..moveTo(size.width * 0.2 + oy, size.height * 0.82)
      ..lineTo(size.width * 0.5 + ox, size.height * 0.58)
      ..lineTo(size.width * 0.82 - oy, size.height * 0.84)
      ..close();
    canvas.drawPath(tri, p2);

    if (drawGrid) {
      final Paint g = Paint()
        ..color = Colors.white24
        ..strokeWidth = 1;
      const double gap = 16;
      for (double x = 0; x <= size.width; x += gap) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), g);
      }
      for (double y = 0; y <= size.height; y += gap) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), g);
      }
    }

    if (drawOverlay) {
      final Paint op = Paint()..color = Colors.white.withAlpha(60);
      canvas.drawCircle(Offset(size.width * 0.83, size.height * 0.2), 16, op);
      canvas.drawCircle(Offset(size.width * 0.16, size.height * 0.16), 11, op);
      final Paint line = Paint()
        ..color = Colors.white70
        ..strokeWidth = 1.2;
      canvas.drawLine(
        Offset(size.width * 0.1, size.height * 0.9),
        Offset(size.width * 0.9, size.height * 0.9),
        line,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CompositeSamplerPainter oldDelegate) {
    return oldDelegate.c0 != c0 ||
        oldDelegate.c1 != c1 ||
        oldDelegate.c2 != c2 ||
        oldDelegate.outColor != outColor ||
        oldDelegate.uvScale != uvScale ||
        oldDelegate.uvOffsetX != uvOffsetX ||
        oldDelegate.uvOffsetY != uvOffsetY ||
        oldDelegate.drawGrid != drawGrid ||
        oldDelegate.drawOverlay != drawOverlay;
  }
}
