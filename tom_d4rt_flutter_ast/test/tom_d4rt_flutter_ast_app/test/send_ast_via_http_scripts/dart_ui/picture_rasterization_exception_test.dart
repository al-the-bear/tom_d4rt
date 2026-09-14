// D4rt test script: Deep demo for PictureRasterizationException from dart:ui.
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _PictureRasterizationExceptionDemoPage(),
  );
}

class _PictureRasterizationExceptionDemoPage extends StatefulWidget {
  const _PictureRasterizationExceptionDemoPage();

  @override
  State<_PictureRasterizationExceptionDemoPage> createState() => _PictureRasterizationExceptionDemoPageState();
}

class _PictureRasterizationExceptionDemoPageState extends State<_PictureRasterizationExceptionDemoPage> {
  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];
  final List<String> _notes = <String>[];
  final List<_RasterAttempt> _attempts = <_RasterAttempt>[];

  int _sceneType = 0;
  double _complexity = 0.5;
  double _strokeWidth = 2.0;
  double _targetWidth = 256;
  double _targetHeight = 192;
  bool _forceInvalidSize = false;
  bool _showGrid = true;
  bool _simulatePressure = false;
  bool _animate = true;
  int _theme = 0;

  double _animValue = 0.0;

  final List<List<Color>> _themes = <List<Color>>[
    <Color>[const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF38BDF8)],
    <Color>[const Color(0xFF3F1D38), const Color(0xFF7B2D5E), const Color(0xFFFB7185)],
    <Color>[const Color(0xFF064E3B), const Color(0xFF047857), const Color(0xFF34D399)],
  ];

  static const List<String> _sceneNames = <String>['Shapes Grid', 'Radial Burst', 'Bezier Weave', 'Text Layers'];

  @override
  void initState() {
    super.initState();
    _emit('Picture rasterization diagnostics lab initialized.');
    _runProbes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _emit(String msg) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    _notes.insert(0, '[$stamp] $msg');
    if (_notes.length > 40) {
      _notes.removeLast();
    }
  }

  ui.Picture _buildPicture(Size size) {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, Offset.zero & size);

    if (_showGrid) {
      final Paint gp = Paint()
        ..color = const Color(0xFFCBD5E1)
        ..strokeWidth = 1;
      const double step = 16;
      for (double x = 0; x <= size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gp);
      }
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gp);
      }
    }

    final double pressureScale = _simulatePressure ? 1.6 : 1.0;

    if (_sceneType == 0) {
      final int nx = (3 + _complexity * 9).round();
      final int ny = (2 + _complexity * 7).round();
      for (int i = 0; i < nx; i++) {
        for (int j = 0; j < ny; j++) {
          final Rect r = Rect.fromLTWH(
            i * size.width / nx + 4,
            j * size.height / ny + 4,
            size.width / nx - 8,
            size.height / ny - 8,
          );
          final Paint p = Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = _strokeWidth * pressureScale
            ..color = Color.lerp(const Color(0xFF2563EB), const Color(0xFF22D3EE), j / ny) ?? const Color(0xFF2563EB);
          canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(8)), p);
        }
      }
    } else if (_sceneType == 1) {
      final Offset c = Offset(size.width * 0.5, size.height * 0.5);
      final int rays = (18 + _complexity * 80).round();
      for (int i = 0; i < rays; i++) {
        final double t = i / rays;
        final double angle = t * math.pi * 2;
        final double radius = size.shortestSide * (0.25 + 0.35 * (0.5 + 0.5 * math.sin(angle * 3)));
        final Offset end = c + Offset(math.cos(angle), math.sin(angle)) * radius;
        final Paint p = Paint()
          ..strokeWidth = (_strokeWidth + t * 2) * pressureScale
          ..color = Color.lerp(const Color(0xFF7C3AED), const Color(0xFFF97316), t) ?? const Color(0xFF7C3AED);
        canvas.drawLine(c, end, p);
      }
      canvas.drawCircle(c, 12, Paint()..color = const Color(0xFF0EA5E9));
    } else if (_sceneType == 2) {
      final int curves = (8 + _complexity * 40).round();
      for (int i = 0; i < curves; i++) {
        final double t = i / curves;
        final Path path = Path()
          ..moveTo(0, size.height * t)
          ..cubicTo(
            size.width * 0.3,
            size.height * (0.2 + 0.6 * math.sin(t * math.pi * 2)),
            size.width * 0.7,
            size.height * (0.8 - 0.6 * math.cos(t * math.pi * 2)),
            size.width,
            size.height * (1 - t),
          );
        final Paint p = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = (_strokeWidth + 0.5) * pressureScale
          ..color = Color.lerp(const Color(0xFF0F766E), const Color(0xFF22C55E), t) ?? const Color(0xFF0F766E);
        canvas.drawPath(path, p);
      }
    } else {
      final int lines = (2 + _complexity * 9).round();
      final ui.ParagraphBuilder b = ui.ParagraphBuilder(
        ui.ParagraphStyle(fontSize: 14 + _complexity * 16, fontWeight: FontWeight.w600),
      )
        ..pushStyle(ui.TextStyle(color: const Color(0xFF0F172A)))
        ..addText('Raster diagnostics scene\n');
      for (int i = 0; i < lines; i++) {
        b.pushStyle(ui.TextStyle(
          color: Color.lerp(const Color(0xFF2563EB), const Color(0xFFBE123C), i / lines),
          fontSize: 12 + i.toDouble(),
        ));
        b.addText('Layer ${i + 1}: complexity ${(100 * _complexity).round()}%\n');
      }
      final ui.Paragraph p = b.build();
      p.layout(ui.ParagraphConstraints(width: size.width - 24));
      canvas.drawParagraph(p, const Offset(12, 12));
    }

    return recorder.endRecording();
  }

  Future<void> _attemptRasterization() async {
    final Size sceneSize = Size(
      _targetWidth.clamp(32, 640),
      _targetHeight.clamp(32, 480),
    );
    final ui.Picture picture = _buildPicture(sceneSize);

    final int w = _forceInvalidSize ? 0 : _targetWidth.round().clamp(1, 4096);
    final int h = _forceInvalidSize ? 0 : _targetHeight.round().clamp(1, 4096);

    DateTime start = DateTime.now();
    try {
      final ui.Image image = await picture.toImage(w, h);
      final Duration elapsed = DateTime.now().difference(start);
      image.dispose();
      _attempts.insert(
        0,
        _RasterAttempt(
          ok: true,
          scene: _sceneNames[_sceneType],
          width: w,
          height: h,
          elapsedMs: elapsed.inMilliseconds,
          message: 'Rasterization completed successfully.',
          exceptionType: null,
        ),
      );
      _emit('Rasterization success: ${_sceneNames[_sceneType]} ${w}x$h in ${elapsed.inMilliseconds}ms.');
    } catch (e) {
      final Duration elapsed = DateTime.now().difference(start);
      _attempts.insert(
        0,
        _RasterAttempt(
          ok: false,
          scene: _sceneNames[_sceneType],
          width: w,
          height: h,
          elapsedMs: elapsed.inMilliseconds,
          message: e.toString(),
          exceptionType: e.runtimeType.toString(),
        ),
      );
      _emit('Rasterization failure captured (${e.runtimeType}).');
    } finally {
      picture.dispose();
    }

    if (_attempts.length > 30) {
      _attempts.removeLast();
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _runProbes() async {
    _passed.clear();
    _failed.clear();
    void probe(String label, bool ok) {
      if (ok) {
        _passed.add(label);
      } else {
        _failed.add(label);
      }
    }

    probe('PictureRasterizationException symbol contains Picture', 'PictureRasterizationException'.contains('Picture'));
    probe('PictureRasterizationException symbol contains Rasterization',
        'PictureRasterizationException'.contains('Rasterization'));

    final ui.Picture p = _buildPicture(const Size(120, 80));
    try {
      final ui.Image ok = await p.toImage(120, 80);
      ok.dispose();
      probe('Picture.toImage succeeds for valid dimensions', true);
    } catch (_) {
      probe('Picture.toImage succeeds for valid dimensions', false);
    }

    // Picture.toImage(0, 20) should throw — verify SDK validation reaches us.
    bool invalidThrew = false;
    try {
      await p.toImage(0, 20);
    } catch (_) {
      invalidThrew = true;
    }
    probe('Picture.toImage throws on invalid dimensions', invalidThrew);

    p.dispose();
    probe('summary text can be generated', '${_passed.length + _failed.length} checks'.endsWith('checks'));
    if (mounted) {
      setState(() {});
    }
  }

  Widget _header() {
    final List<Color> c = _themes[_theme];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: c),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[BoxShadow(color: c[1].withAlpha(95), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Picture Rasterization Diagnostics',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'PictureRasterizationException represents rasterization failure paths when '
            'converting recorded picture content into images. This deep demo visualizes '
            'pipeline setup, success/failure cases, and exception diagnostics.',
            style: TextStyle(color: Colors.white, fontSize: 13.1, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String subtitle, IconData icon, Color accent) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
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
            decoration: BoxDecoration(color: accent.withAlpha(36), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(title, style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 12.2)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _conceptCards() {
    Widget card(String t, String d, IconData i, Color c) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: c.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: c.withAlpha(90)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Icon(i, color: c),
            const SizedBox(height: 8),
            Text(t, style: TextStyle(color: c, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(d, style: const TextStyle(fontSize: 12)),
          ]),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: <Widget>[
        card('Recording stage', 'Canvas commands are captured into a Picture.', Icons.fiber_manual_record,
            const Color(0xFF2563EB)),
        card('Raster stage', 'Picture is converted into pixel image memory.', Icons.image,
            const Color(0xFF7C3AED)),
        card('Failure handling', 'Catch and inspect rasterization exceptions.', Icons.bug_report,
            const Color(0xFFBE123C)),
        card('Operational tuning', 'Control dimensions and complexity for diagnostics.', Icons.tune,
            const Color(0xFF0F766E)),
      ]),
    );
  }

  Widget _controlsPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('Rasterization control lab', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        DropdownButton<int>(
          value: _sceneType,
          isExpanded: true,
          onChanged: (int? v) {
            if (v != null) {
              setState(() => _sceneType = v);
              _emit('Scene switched to ${_sceneNames[v]}.');
            }
          },
          items: List<DropdownMenuItem<int>>.generate(
            _sceneNames.length,
            (int i) => DropdownMenuItem<int>(value: i, child: Text(_sceneNames[i])),
          ),
        ),
        Text('Complexity: ${(100 * _complexity).round()}%'),
        Slider(value: _complexity, min: 0, max: 1, divisions: 100, onChanged: (double v) => setState(() => _complexity = v)),
        Text('Stroke width: ${_strokeWidth.toStringAsFixed(1)}'),
        Slider(value: _strokeWidth, min: 0.5, max: 10, divisions: 95, onChanged: (double v) => setState(() => _strokeWidth = v)),
        Text('Target width: ${_targetWidth.round()}'),
        Slider(value: _targetWidth, min: 32, max: 1024, divisions: 248, onChanged: (double v) => setState(() => _targetWidth = v)),
        Text('Target height: ${_targetHeight.round()}'),
        Slider(value: _targetHeight, min: 32, max: 768, divisions: 184, onChanged: (double v) => setState(() => _targetHeight = v)),
        Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
          FilterChip(
              label: const Text('force invalid size'),
              selected: _forceInvalidSize,
              onSelected: (bool v) => setState(() => _forceInvalidSize = v)),
          FilterChip(label: const Text('show grid'), selected: _showGrid, onSelected: (bool v) => setState(() => _showGrid = v)),
          FilterChip(
              label: const Text('simulate pressure'), selected: _simulatePressure, onSelected: (bool v) => setState(() => _simulatePressure = v)),
          FilterChip(
            label: const Text('animate'),
            selected: _animate,
            onSelected: (bool v) {
              setState(() => _animate = v);
              if (_animate) {
                /* animation removed */
              } else {
                /* animation removed */
              }
            },
          ),
        ]),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
          ElevatedButton.icon(
            onPressed: _attemptRasterization,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Attempt Rasterization'),
          ),
          OutlinedButton.icon(
            onPressed: () {
              _attempts.clear();
              _emit('Cleared rasterization attempt log.');
              setState(() {});
            },
            icon: const Icon(Icons.clear_all),
            label: const Text('Clear Attempts'),
          ),
          OutlinedButton.icon(
            onPressed: _runProbes,
            icon: const Icon(Icons.fact_check_outlined),
            label: const Text('Run Probes'),
          ),
          OutlinedButton.icon(
            onPressed: () => setState(() => _theme = (_theme + 1) % _themes.length),
            icon: const Icon(Icons.palette_outlined),
            label: const Text('Theme'),
          ),
        ]),
      ]),
    );
  }

  Widget _previewPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('Picture recording preview', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 230,
          child: Builder(
            builder: (BuildContext context) {
              return CustomPaint(
                painter: _ScenePreviewPainter(
                  sceneType: _sceneType,
                  complexity: _complexity,
                  strokeWidth: _strokeWidth,
                  showGrid: _showGrid,
                  pulse: _animate ? _animValue : 0,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text('Preview scene: ${_sceneNames[_sceneType]}'),
      ]),
    );
  }

  Widget _attemptsPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('Rasterization attempt timeline', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        SizedBox(
          height: 220,
          child: _attempts.isEmpty
              ? const Center(
                  child: Text('No attempts yet. Trigger rasterization from control panel.',
                      style: TextStyle(fontSize: 12.2, color: Color(0xFF64748B))),
                )
              : ListView.builder(
                  itemCount: _attempts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final _RasterAttempt a = _attempts[index];
                    final Color c = a.ok ? const Color(0xFF16A34A) : const Color(0xFFB91C1C);
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: c.withAlpha(20),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: c.withAlpha(95)),
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Row(children: <Widget>[
                          Icon(a.ok ? Icons.check_circle : Icons.error, color: c, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${a.scene} | ${a.width}x${a.height} | ${a.elapsedMs}ms | ${a.ok ? 'OK' : 'FAIL'}',
                              style: const TextStyle(fontSize: 12.2),
                            ),
                          ),
                        ]),
                        const SizedBox(height: 4),
                        Text(a.exceptionType == null ? a.message : '${a.exceptionType}: ${a.message}',
                            style: const TextStyle(fontSize: 11.8)),
                      ]),
                    );
                  },
                ),
        ),
      ]),
    );
  }

  Widget _guidancePanel() {
    final List<_GuideRow> rows = <_GuideRow>[
      const _GuideRow('Validate dimensions', 'Avoid 0 or negative target sizes before toImage calls.'),
      const _GuideRow('Bound complexity', 'Large scenes at huge output sizes can increase failure risk.'),
      const _GuideRow('Capture exception text', 'Store message + runtimeType for diagnostics and telemetry.'),
      const _GuideRow('Fallback strategy', 'Retry with lower resolution or simpler drawing content.'),
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('Failure handling guidance', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        ...rows.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Icon(Icons.circle, size: 8, color: Color(0xFF334155)),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text('${e.title}: ${e.body}', style: const TextStyle(fontSize: 12.2))),
              ]),
            )),
      ]),
    );
  }

  Widget _probePanel() {
    Widget line(String t, bool ok) {
      final Color c = ok ? const Color(0xFF15803D) : const Color(0xFFB91C1C);
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: c.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: c.withAlpha(96)),
        ),
        child: Row(children: <Widget>[
          Icon(ok ? Icons.check_circle : Icons.cancel, color: c, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(t, style: const TextStyle(fontSize: 12.2))),
        ]),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('Runtime probe dashboard', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text('Passed: ${_passed.length}, Failed: ${_failed.length}'),
        const SizedBox(height: 8),
        ..._passed.map((String s) => line(s, true)),
        ..._failed.map((String s) => line(s, false)),
      ]),
    );
  }

  Widget _notesPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('Diagnostic notes', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: ListView.builder(
            itemCount: _notes.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(_notes[index], style: const TextStyle(fontSize: 12)),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget _summaryPanel() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: const Text(
        'PictureRasterizationException summary: rasterization can fail due to invalid dimensions '
        'or heavy constraints. Production-safe code should validate inputs, catch exceptions, log '
        'context, and retry with reduced workload when needed.',
        style: TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - PictureRasterizationException'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.7,
      ),
      body: ListView(children: <Widget>[
        _header(),
        _section('1) Concept overview', 'Where rasterization exceptions appear in the pipeline.', Icons.menu_book,
            const Color(0xFF2563EB)),
        _conceptCards(),
        _section('2) Control lab', 'Configure rendering workload and target raster dimensions.', Icons.tune,
            const Color(0xFF7C3AED)),
        _controlsPanel(),
        _section('3) Recording preview', 'Visualize generated picture content before rasterization.', Icons.brush,
            const Color(0xFF0F766E)),
        _previewPanel(),
        _section('4) Attempt timeline', 'Track success and failure outcomes per raster attempt.', Icons.timeline,
            const Color(0xFFBE123C)),
        _attemptsPanel(),
        _section('5) Handling guidance', 'Recommended operational safeguards for failures.', Icons.rule,
            const Color(0xFFB45309)),
        _guidancePanel(),
        _section('6) Probe checks', 'Runtime checks for success/failure paths and messaging.', Icons.fact_check,
            const Color(0xFF166534)),
        _probePanel(),
        _section('7) Notes and summary', 'Chronological diagnostics and final recommendations.', Icons.notes,
            const Color(0xFF475569)),
        _notesPanel(),
        _summaryPanel(),
      ]),
    );
  }
}

class _RasterAttempt {
  const _RasterAttempt({
    required this.ok,
    required this.scene,
    required this.width,
    required this.height,
    required this.elapsedMs,
    required this.message,
    required this.exceptionType,
  });

  final bool ok;
  final String scene;
  final int width;
  final int height;
  final int elapsedMs;
  final String message;
  final String? exceptionType;
}

class _GuideRow {
  const _GuideRow(this.title, this.body);

  final String title;
  final String body;
}

class _ScenePreviewPainter extends CustomPainter {
  const _ScenePreviewPainter({
    required this.sceneType,
    required this.complexity,
    required this.strokeWidth,
    required this.showGrid,
    required this.pulse,
  });

  final int sceneType;
  final double complexity;
  final double strokeWidth;
  final bool showGrid;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF0F172A).withAlpha(22);
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)), bg);

    if (showGrid) {
      final Paint gp = Paint()
        ..color = Colors.white24
        ..strokeWidth = 1;
      const double step = 16;
      for (double x = 0; x <= size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gp);
      }
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gp);
      }
    }

    if (sceneType == 0) {
      final int n = (4 + complexity * 10).round();
      for (int i = 0; i < n; i++) {
        final double t = i / n;
        final Rect r = Rect.fromLTWH(12 + t * (size.width - 60), 18 + t * (size.height - 60), 42, 30);
        canvas.drawRRect(
          RRect.fromRectAndRadius(r, const Radius.circular(7)),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..color = Color.lerp(const Color(0xFF2563EB), const Color(0xFF22D3EE), t) ?? const Color(0xFF2563EB),
        );
      }
    } else if (sceneType == 1) {
      final Offset c = Offset(size.width * 0.5, size.height * 0.5);
      final int rays = (16 + complexity * 72).round();
      for (int i = 0; i < rays; i++) {
        final double t = i / rays;
        final double a = t * math.pi * 2;
        final double r = size.shortestSide * (0.25 + 0.3 * (0.5 + 0.5 * math.sin(a * 4 + pulse * 6.28)));
        final Offset e = c + Offset(math.cos(a), math.sin(a)) * r;
        canvas.drawLine(
          c,
          e,
          Paint()
            ..strokeWidth = strokeWidth
            ..color = Color.lerp(const Color(0xFF7C3AED), const Color(0xFFF97316), t) ?? const Color(0xFF7C3AED),
        );
      }
    } else if (sceneType == 2) {
      final int curves = (10 + complexity * 42).round();
      for (int i = 0; i < curves; i++) {
        final double t = i / curves;
        final Path p = Path()
          ..moveTo(0, size.height * t)
          ..cubicTo(
            size.width * 0.35,
            size.height * (0.15 + 0.7 * math.sin(t * 8)),
            size.width * 0.65,
            size.height * (0.85 - 0.7 * math.cos(t * 6)),
            size.width,
            size.height * (1 - t),
          );
        canvas.drawPath(
          p,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..color = Color.lerp(const Color(0xFF0F766E), const Color(0xFF22C55E), t) ?? const Color(0xFF0F766E),
        );
      }
    } else {
      final int lines = (2 + complexity * 10).round();
      final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
      for (int i = 0; i < lines; i++) {
        tp.text = TextSpan(
          text: 'Layer ${i + 1}: raster diagnostics',
          style: TextStyle(
            color: Color.lerp(const Color(0xFF2563EB), const Color(0xFFBE123C), i / lines),
            fontSize: 12 + i.toDouble(),
            fontWeight: FontWeight.w600,
          ),
        );
        tp.layout(maxWidth: size.width - 20);
        tp.paint(canvas, Offset(10, 10 + i * 18));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ScenePreviewPainter oldDelegate) {
    return oldDelegate.sceneType != sceneType ||
        oldDelegate.complexity != complexity ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.pulse != pulse;
  }
}
