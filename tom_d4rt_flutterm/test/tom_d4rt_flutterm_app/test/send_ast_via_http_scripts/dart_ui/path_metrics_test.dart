// D4rt test script: Deep demo for PathMetrics from dart:ui.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _PathMetricsDeepDemoPage(),
  );
}

class _PathMetricsDeepDemoPage extends StatefulWidget {
  const _PathMetricsDeepDemoPage();

  @override
  State<_PathMetricsDeepDemoPage> createState() => _PathMetricsDeepDemoPageState();
}

class _PathMetricsDeepDemoPageState extends State<_PathMetricsDeepDemoPage>
    with SingleTickerProviderStateMixin {
  final List<_ShapeSpec> _shapes = <_ShapeSpec>[];
  final List<String> _notes = <String>[];
  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];

  bool _forceClosed = false;
  bool _showGrid = true;
  bool _showExtract = true;
  bool _showTangents = true;
  bool _animate = true;
  int _shapeType = 0;
  int _theme = 0;
  double _size = 90;
  double _x = 25;
  double _y = 35;
  double _radius = 32;
  double _extractStart = 0.12;
  double _extractEnd = 0.62;

  late final AnimationController _anim;
  List<ui.PathMetric> _metrics = <ui.PathMetric>[];
  int _selectedMetric = 0;

  static const List<String> _shapeNames = <String>['Rect', 'Oval', 'RRect', 'Triangle', 'Arc'];
  final List<List<Color>> _themes = <List<Color>>[
    <Color>[const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF38BDF8)],
    <Color>[const Color(0xFF3F1D38), const Color(0xFF7B2D5E), const Color(0xFFFB7185)],
    <Color>[const Color(0xFF064E3B), const Color(0xFF047857), const Color(0xFF34D399)],
  ];

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 2300))..repeat();
    _addShape(0);
    _addShape(2);
    _recompute();
    _runProbes();
    _emit('PathMetrics analytics studio initialized.');
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _emit(String message) {
    final DateTime now = DateTime.now();
    final String stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    _notes.insert(0, '[$stamp] $message');
    if (_notes.length > 40) {
      _notes.removeLast();
    }
  }

  ui.Path _buildPath() {
    final ui.Path p = ui.Path();
    for (final _ShapeSpec s in _shapes) {
      final Rect r = Rect.fromLTWH(s.x, s.y, s.size, s.size);
      if (s.type == 0) {
        p.addRect(r);
      } else if (s.type == 1) {
        p.addOval(r);
      } else if (s.type == 2) {
        p.addRRect(RRect.fromRectAndRadius(r, Radius.circular(s.radius.clamp(2, s.size / 2))));
      } else if (s.type == 3) {
        p.moveTo(s.x + s.size / 2, s.y);
        p.lineTo(s.x + s.size, s.y + s.size);
        p.lineTo(s.x, s.y + s.size);
        p.close();
      } else {
        p.addArc(r, 0, 3.14159 * 1.5);
      }
    }
    return p;
  }

  void _recompute() {
    _metrics = _buildPath().computeMetrics(forceClosed: _forceClosed).toList();
    if (_metrics.isEmpty) {
      _selectedMetric = 0;
    } else {
      _selectedMetric = _selectedMetric.clamp(0, _metrics.length - 1);
    }
    setState(() {});
  }

  void _addShape(int type) {
    final List<Color> colors = <Color>[
      const Color(0xFF2563EB),
      const Color(0xFF7C3AED),
      const Color(0xFF0F766E),
      const Color(0xFFEA580C),
      const Color(0xFFBE123C),
    ];
    _shapes.add(
      _ShapeSpec(
        type: type,
        x: _x + ((_shapes.length * 31) % 110),
        y: _y + ((_shapes.length * 23) % 95),
        size: _size,
        radius: _radius,
        color: colors[_shapes.length % colors.length],
      ),
    );
    _emit('Added shape ${_shapeNames[type]} (#${_shapes.length}).');
    _recompute();
  }

  void _runProbes() {
    _passed.clear();
    _failed.clear();
    void probe(String label, bool ok) {
      if (ok) {
        _passed.add(label);
      } else {
        _failed.add(label);
      }
    }

    final ui.Path p = ui.Path()..addRect(const Rect.fromLTWH(0, 0, 100, 100));
    final ui.PathMetrics m = p.computeMetrics();
    probe('PathMetrics can be obtained from Path', m.runtimeType.toString().contains('PathMetrics'));
    probe('iterator is available', m.iterator.runtimeType.toString().contains('Iterator'));

    int count = 0;
    for (final ui.PathMetric _ in m) {
      count++;
    }
    probe('for-in iteration works', count == 1);
    probe('toList returns list', m.toList().length == 1);

    final ui.Path open = ui.Path()
      ..moveTo(0, 0)
      ..lineTo(50, 0)
      ..lineTo(50, 50);
    final ui.PathMetric fm = open.computeMetrics(forceClosed: true).first;
    probe('forceClosed can close open contours', fm.isClosed);

    final ui.Path empty = ui.Path();
    probe('empty path yields empty metrics', empty.computeMetrics().isEmpty);

    final ui.PathMetric rm = p.computeMetrics().first;
    probe('rect metric perimeter near 400', (rm.length - 400.0).abs() < 0.01);
    probe('summary text can be created', '${_passed.length + _failed.length} checks'.endsWith('checks'));
    setState(() {});
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
          Text('PathMetrics Contour Analytics Studio',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
          SizedBox(height: 8),
          Text(
            'PathMetrics exposes an iterable sequence of contour metrics computed from a Path. '
            'This demo shows iterable workflows, forceClosed behavior, and metric-driven extraction '
            'and tangent analysis in visual form.',
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
        card('Iterable API', 'Use for-in, iterator, first, and toList workflows.', Icons.list,
            const Color(0xFF2563EB)),
        card('Contour lengths', 'Each contour has independent length and closure state.', Icons.straighten,
            const Color(0xFF7C3AED)),
        card('Extraction', 'Extract contour segments for stroke animations.', Icons.content_cut,
            const Color(0xFF0F766E)),
        card('Tangents', 'Sample positions and vectors along offsets.', Icons.explore,
            const Color(0xFFB45309)),
      ]),
    );
  }

  Widget _builderPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('Path constructor lab', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        DropdownButton<int>(
          value: _shapeType,
          isExpanded: true,
          onChanged: (int? v) {
            if (v != null) {
              setState(() => _shapeType = v);
            }
          },
          items: List<DropdownMenuItem<int>>.generate(
            _shapeNames.length,
            (int i) => DropdownMenuItem<int>(value: i, child: Text(_shapeNames[i])),
          ),
        ),
        Text('size: ${_size.toStringAsFixed(1)}'),
        Slider(value: _size, min: 20, max: 170, divisions: 150, onChanged: (double v) => setState(() => _size = v)),
        Text('offset x: ${_x.toStringAsFixed(1)}'),
        Slider(value: _x, min: 0, max: 190, divisions: 190, onChanged: (double v) => setState(() => _x = v)),
        Text('offset y: ${_y.toStringAsFixed(1)}'),
        Slider(value: _y, min: 0, max: 190, divisions: 190, onChanged: (double v) => setState(() => _y = v)),
        Text('rrect radius: ${_radius.toStringAsFixed(1)}'),
        Slider(value: _radius, min: 2, max: 80, divisions: 78, onChanged: (double v) => setState(() => _radius = v)),
        Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
          FilterChip(
            label: const Text('forceClosed'),
            selected: _forceClosed,
            onSelected: (bool v) {
              setState(() => _forceClosed = v);
              _recompute();
            },
          ),
          FilterChip(label: const Text('show grid'), selected: _showGrid, onSelected: (bool v) => setState(() => _showGrid = v)),
          FilterChip(
              label: const Text('show extract'), selected: _showExtract, onSelected: (bool v) => setState(() => _showExtract = v)),
          FilterChip(
              label: const Text('show tangents'), selected: _showTangents, onSelected: (bool v) => setState(() => _showTangents = v)),
          FilterChip(
            label: const Text('animate'),
            selected: _animate,
            onSelected: (bool v) {
              setState(() => _animate = v);
              if (_animate) {
                _anim.repeat();
              } else {
                _anim.stop();
              }
            },
          ),
        ]),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _addShape(_shapeType);
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Shape'),
          ),
          OutlinedButton.icon(
            onPressed: _shapes.isEmpty
                ? null
                : () {
                    setState(() {
                      _shapes.removeLast();
                      _emit('Removed last shape.');
                      _recompute();
                    });
                  },
            icon: const Icon(Icons.remove_circle_outline),
            label: const Text('Remove Last'),
          ),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _shapes.clear();
                _emit('Cleared path content.');
                _recompute();
              });
            },
            icon: const Icon(Icons.delete_outline),
            label: const Text('Clear Path'),
          ),
          OutlinedButton.icon(
            onPressed: () {
              setState(() => _theme = (_theme + 1) % _themes.length);
            },
            icon: const Icon(Icons.palette_outlined),
            label: const Text('Theme'),
          ),
        ]),
      ]),
    );
  }

  Widget _canvasPanel() {
    final ui.Path path = _buildPath();
    final ui.PathMetric? selected = _metrics.isEmpty ? null : _metrics[_selectedMetric];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('Path and metric visualization', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 250,
          child: AnimatedBuilder(
            animation: _anim,
            builder: (BuildContext context, Widget? child) {
              return CustomPaint(
                painter: _PathMetricsPainter(
                  path: path,
                  metrics: _metrics,
                  selectedMetricIndex: _selectedMetric,
                  showGrid: _showGrid,
                  showExtract: _showExtract,
                  showTangents: _showTangents,
                  extractStart: _extractStart,
                  extractEnd: _extractEnd,
                  pulse: _animate ? _anim.value : 0,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text('Shapes: ${_shapes.length} | Metrics: ${_metrics.length} | forceClosed: $_forceClosed'),
        const SizedBox(height: 8),
        if (selected == null)
          const Text('No selected metric.', style: TextStyle(fontSize: 12.2))
        else
          Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
            _pill('contour', '${selected.contourIndex}'),
            _pill('length', selected.length.toStringAsFixed(2)),
            _pill('isClosed', '${selected.isClosed}'),
          ]),
      ]),
    );
  }

  Widget _pill(String k, String v) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('$k: $v', style: const TextStyle(fontSize: 12.1)),
    );
  }

  Widget _metricsPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('Iterable workflow demo', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
          _pill('isEmpty', '${_buildPath().computeMetrics(forceClosed: _forceClosed).isEmpty}'),
          _pill('iterator type', _buildPath().computeMetrics().iterator.runtimeType.toString()),
          _pill('toList length', '${_metrics.length}'),
          _pill('for-in counted', '${_countViaForIn()}'),
        ]),
        const SizedBox(height: 8),
        if (_metrics.isNotEmpty)
          Slider(
            value: _selectedMetric.toDouble(),
            min: 0,
            max: (_metrics.length - 1).toDouble(),
            divisions: _metrics.length - 1,
            label: 'metric $_selectedMetric',
            onChanged: (double v) => setState(() => _selectedMetric = v.round()),
          ),
        Text('Extract start: ${_extractStart.toStringAsFixed(2)}'),
        Slider(value: _extractStart, min: 0, max: 1, divisions: 100, onChanged: (double v) => setState(() => _extractStart = v)),
        Text('Extract end: ${_extractEnd.toStringAsFixed(2)}'),
        Slider(value: _extractEnd, min: 0, max: 1, divisions: 100, onChanged: (double v) => setState(() => _extractEnd = v)),
      ]),
    );
  }

  int _countViaForIn() {
    int count = 0;
    for (final ui.PathMetric _ in _buildPath().computeMetrics(forceClosed: _forceClosed)) {
      count++;
    }
    return count;
  }

  Widget _histogramPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD7E1ED)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const Text('Metric length histogram', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          height: 180,
          child: CustomPaint(
            painter: _LengthHistogramPainter(metrics: _metrics),
          ),
        ),
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
        const Text('Session notes', style: TextStyle(fontWeight: FontWeight.w700)),
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
        'PathMetrics summary: treat PathMetrics as an iterable contour dataset. Use forceClosed '
        'intentionally, inspect each PathMetric for length/closure/contour index, and derive '
        'extract/tangent geometry for animation and diagnostics.',
        style: TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - PathMetrics'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.7,
      ),
      body: ListView(children: <Widget>[
        _header(),
        _section('1) Concept overview', 'What PathMetrics provides as an iterable contour API.', Icons.menu_book,
            const Color(0xFF2563EB)),
        _conceptCards(),
        _section('2) Constructor lab', 'Build multi-contour paths and recompute metrics.', Icons.architecture,
            const Color(0xFF7C3AED)),
        _builderPanel(),
        _section('3) Visual metrics canvas', 'Inspect contours, selected metric, extraction, and tangents.', Icons.brush,
            const Color(0xFF0F766E)),
        _canvasPanel(),
        _section('4) Iterable operations', 'Use iterator, for-in, toList, and empty checks.', Icons.list,
            const Color(0xFFB45309)),
        _metricsPanel(),
        _section('5) Length distribution', 'Compare contour lengths via chart.', Icons.bar_chart,
            const Color(0xFFBE123C)),
        _histogramPanel(),
        _section('6) Probe checks', 'Validate PathMetrics behavior in runtime.', Icons.fact_check,
            const Color(0xFF166534)),
        _probePanel(),
        _section('7) Notes and summary', 'Operational trace and final guidance.', Icons.notes,
            const Color(0xFF475569)),
        _notesPanel(),
        _summaryPanel(),
      ]),
    );
  }
}

class _ShapeSpec {
  const _ShapeSpec({
    required this.type,
    required this.x,
    required this.y,
    required this.size,
    required this.radius,
    required this.color,
  });

  final int type;
  final double x;
  final double y;
  final double size;
  final double radius;
  final Color color;
}

class _PathMetricsPainter extends CustomPainter {
  const _PathMetricsPainter({
    required this.path,
    required this.metrics,
    required this.selectedMetricIndex,
    required this.showGrid,
    required this.showExtract,
    required this.showTangents,
    required this.extractStart,
    required this.extractEnd,
    required this.pulse,
  });

  final ui.Path path;
  final List<ui.PathMetric> metrics;
  final int selectedMetricIndex;
  final bool showGrid;
  final bool showExtract;
  final bool showTangents;
  final double extractStart;
  final double extractEnd;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF0F172A).withAlpha(24);
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)), bg);

    if (showGrid) {
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

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = const Color(0xFF334155),
    );

    for (int i = 0; i < metrics.length; i++) {
      final ui.PathMetric m = metrics[i];
      final bool selected = i == selectedMetricIndex;
      canvas.drawPath(
        m.extractPath(0, m.length),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = selected ? 4 : 2
          ..color = selected ? const Color(0xFF0EA5E9) : const Color(0xFF64748B).withAlpha(120),
      );

      if (showExtract) {
        final double s = (extractStart.clamp(0, 1) * m.length).clamp(0, m.length);
        final double e = (extractEnd.clamp(0, 1) * m.length).clamp(0, m.length);
        canvas.drawPath(
          m.extractPath(s < e ? s : e, s < e ? e : s),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = selected ? 5 : 3
            ..color = selected ? const Color(0xFF22C55E) : const Color(0xFFA3E635).withAlpha(120),
        );
      }

      if (showTangents) {
        final ui.Tangent? t = m.getTangentForOffset((pulse * m.length).clamp(0, m.length));
        if (t != null) {
          canvas.drawCircle(t.position, 4, Paint()..color = const Color(0xFFFB7185));
          final Offset end = t.position + t.vector * 12;
          canvas.drawLine(t.position, end, Paint()..color = const Color(0xFFFB7185)..strokeWidth = 2);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PathMetricsPainter oldDelegate) {
    return oldDelegate.path != path ||
        oldDelegate.metrics != metrics ||
        oldDelegate.selectedMetricIndex != selectedMetricIndex ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.showExtract != showExtract ||
        oldDelegate.showTangents != showTangents ||
        oldDelegate.extractStart != extractStart ||
        oldDelegate.extractEnd != extractEnd ||
        oldDelegate.pulse != pulse;
  }
}

class _LengthHistogramPainter extends CustomPainter {
  const _LengthHistogramPainter({required this.metrics});

  final List<ui.PathMetric> metrics;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF0F172A).withAlpha(20);
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)), bg);

    if (metrics.isEmpty) {
      final TextPainter t = TextPainter(
        text: const TextSpan(text: 'No metrics', style: TextStyle(color: Color(0xFF64748B), fontSize: 12.5)),
        textDirection: TextDirection.ltr,
      )..layout();
      t.paint(canvas, Offset(size.width / 2 - t.width / 2, size.height / 2 - t.height / 2));
      return;
    }

    double maxLen = 1;
    for (final ui.PathMetric m in metrics) {
      if (m.length > maxLen) {
        maxLen = m.length;
      }
    }

    final double barW = (size.width - 20) / metrics.length;
    for (int i = 0; i < metrics.length; i++) {
      final ui.PathMetric m = metrics[i];
      final double h = ((m.length / maxLen) * (size.height - 36)).clamp(2, size.height - 36);
      final Rect r = Rect.fromLTWH(10 + i * barW + 3, size.height - 12 - h, barW - 6, h);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        Paint()..color = const Color(0xFF38BDF8).withAlpha(180),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LengthHistogramPainter oldDelegate) {
    return oldDelegate.metrics != metrics;
  }
}
