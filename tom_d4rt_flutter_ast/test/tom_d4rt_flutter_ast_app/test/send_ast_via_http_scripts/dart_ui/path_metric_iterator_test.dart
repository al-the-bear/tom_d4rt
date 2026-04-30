// D4rt test script: Deep demo for PathMetricIterator from dart:ui.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _PathMetricIteratorDeepDemoPage(),
  );
}

class _PathMetricIteratorDeepDemoPage extends StatefulWidget {
  const _PathMetricIteratorDeepDemoPage();

  @override
  State<_PathMetricIteratorDeepDemoPage> createState() => _PathMetricIteratorDeepDemoPageState();
}

class _PathMetricIteratorDeepDemoPageState extends State<_PathMetricIteratorDeepDemoPage> {
  final List<_ContourSpec> _contours = <_ContourSpec>[];
  final List<String> _notes = <String>[];
  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];

  int _shapeIndex = 0;
  bool _forceClosed = false;
  bool _showGrid = true;
  bool _showTangents = true;
  bool _showExtract = true;
  bool _animate = true;
  double _size = 90;
  double _offsetX = 40;
  double _offsetY = 40;
  double _radius = 40;
  double _extractStart = 0.1;
  double _extractEnd = 0.6;
  int _palette = 0;

  int _iteratorIndex = -1;
  bool _iteratorStarted = false;
  bool _iteratorDone = false;
  List<ui.PathMetric> _metricCache = <ui.PathMetric>[];

  double _animValue = 0.0;

  final List<List<Color>> _palettes = <List<Color>>[
    <Color>[const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF38BDF8)],
    <Color>[const Color(0xFF3F1D38), const Color(0xFF7B2D5E), const Color(0xFFFB7185)],
    <Color>[const Color(0xFF064E3B), const Color(0xFF047857), const Color(0xFF34D399)],
  ];

  static const List<String> _shapeNames = <String>['Rectangle', 'Oval', 'Rounded Rect', 'Triangle', 'Arc'];

  @override
  void initState() {
    super.initState();
    _addContourByIndex(0);
    _addContourByIndex(1);
    _rebuildMetrics();
    _runProbes();
    _emit('PathMetricIterator deep demo initialized with two contours.');
  }

  @override
  void dispose() {
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

  void _addContourByIndex(int index) {
    final Color color = <Color>[
      const Color(0xFF2563EB),
      const Color(0xFF7C3AED),
      const Color(0xFF0F766E),
      const Color(0xFFEA580C),
      const Color(0xFFBE123C),
    ][_contours.length % 5];
    final _ContourSpec spec = _ContourSpec(
      type: index,
      x: _offsetX + (_contours.length * 22) % 110,
      y: _offsetY + (_contours.length * 26) % 90,
      size: _size,
      radius: _radius,
      color: color,
    );
    _contours.add(spec);
    _emit('Added contour ${_shapeNames[index]} (#${_contours.length}).');
    _rebuildMetrics();
  }

  void _rebuildMetrics() {
    final ui.Path path = _composePath();
    _metricCache = path.computeMetrics(forceClosed: _forceClosed).toList();
    _iteratorIndex = -1;
    _iteratorStarted = false;
    _iteratorDone = false;
    setState(() {});
  }

  ui.Path _composePath() {
    final ui.Path p = ui.Path();
    for (final _ContourSpec c in _contours) {
      final Rect rect = Rect.fromLTWH(c.x, c.y, c.size, c.size);
      if (c.type == 0) {
        p.addRect(rect);
      } else if (c.type == 1) {
        p.addOval(rect);
      } else if (c.type == 2) {
        p.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(c.radius.clamp(2, c.size / 2))));
      } else if (c.type == 3) {
        p.moveTo(c.x + c.size / 2, c.y);
        p.lineTo(c.x + c.size, c.y + c.size);
        p.lineTo(c.x, c.y + c.size);
        p.close();
      } else {
        p.addArc(rect, 0, 3.14159 * 1.65);
      }
    }
    return p;
  }

  void _iteratorReset() {
    _iteratorIndex = -1;
    _iteratorStarted = false;
    _iteratorDone = false;
    _emit('Iterator reset.');
    setState(() {});
  }

  void _iteratorMoveNext() {
    _iteratorStarted = true;
    if (_iteratorDone) {
      _emit('moveNext called after exhaustion -> false.');
      setState(() {});
      return;
    }
    if (_iteratorIndex + 1 < _metricCache.length) {
      _iteratorIndex += 1;
      final ui.PathMetric m = _metricCache[_iteratorIndex];
      _emit('moveNext -> true, current contourIndex=${m.contourIndex}, length=${m.length.toStringAsFixed(2)}');
    } else {
      _iteratorDone = true;
      _emit('moveNext -> false (iterator exhausted).');
    }
    setState(() {});
  }

  ui.PathMetric? _currentMetricOrNull() {
    if (!_iteratorStarted || _iteratorDone || _iteratorIndex < 0 || _iteratorIndex >= _metricCache.length) {
      return null;
    }
    return _metricCache[_iteratorIndex];
  }

  void _iteratorRunAll() {
    _iteratorReset();
    int steps = 0;
    while (true) {
      final int next = _iteratorIndex + 1;
      if (next < _metricCache.length) {
        _iteratorIndex = next;
        _iteratorStarted = true;
        steps++;
      } else {
        _iteratorDone = true;
        break;
      }
    }
    _emit('Iterator run-all completed in $steps successful moveNext steps.');
    setState(() {});
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

    final ui.Path single = ui.Path()..addRect(const Rect.fromLTWH(0, 0, 40, 40));
    final Iterator<ui.PathMetric> itSingle = single.computeMetrics().iterator;
    probe('iterator is obtainable from PathMetrics', itSingle.runtimeType.toString().contains('Iterator'));
    probe('iterator runtime includes PathMetricIterator token', itSingle.runtimeType.toString().contains('PathMetricIterator'));
    probe('moveNext true for one-contour path', itSingle.moveNext());
    probe('current is PathMetric after moveNext', itSingle.current.runtimeType == ui.PathMetric);
    probe('moveNext false after contour exhausted', itSingle.moveNext() == false);

    final ui.Path empty = ui.Path();
    final Iterator<ui.PathMetric> itEmpty = empty.computeMetrics().iterator;
    probe('empty path yields no moveNext success', itEmpty.moveNext() == false);

    final ui.Path multi = ui.Path()
      ..addRect(const Rect.fromLTWH(0, 0, 10, 10))
      ..addRect(const Rect.fromLTWH(20, 20, 10, 10))
      ..addOval(const Rect.fromLTWH(40, 40, 12, 12));
    final Iterator<ui.PathMetric> itMulti = multi.computeMetrics().iterator;
    int count = 0;
    while (itMulti.moveNext()) {
      count++;
    }
    probe('multi-contour path iterates all contours', count == 3);

    final ui.PathMetric metric = (multi.computeMetrics().toList())[0];
    final ui.Path extract = metric.extractPath(0, metric.length * 0.5);
    probe('extractPath from metric returns non-empty geometry', extract.computeMetrics().isNotEmpty);

    final ui.Tangent? tangent = metric.getTangentForOffset(metric.length * 0.3);
    probe('getTangentForOffset can produce tangent', tangent != null);

    probe('summary string can be formed', '${_passed.length + _failed.length} checks'.endsWith('checks'));
    setState(() {});
  }

  Widget _header() {
    final List<Color> c = _palettes[_palette];
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
            'PathMetricIterator Contour Observatory',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'PathMetricIterator sequentially traverses contour metrics computed from a Path. '
            'This deep demo visualizes contour construction, iteration semantics, metric details, '
            'and extraction workflows used in animation and path tooling.',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(i, color: c),
              const SizedBox(height: 8),
              Text(t, style: TextStyle(color: c, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(d, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          card('Contour iteration', 'Each moveNext advances to next contour metric.', Icons.skip_next,
              const Color(0xFF2563EB)),
          card('Current metric', 'Valid only after successful moveNext.', Icons.analytics,
              const Color(0xFF7C3AED)),
          card('Extraction', 'Use metric ranges for trimmed path effects.', Icons.content_cut,
              const Color(0xFF0F766E)),
          card('Tangents', 'Sample direction vectors along contour.', Icons.navigation,
              const Color(0xFFB45309)),
        ],
      ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Contour builder', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          DropdownButton<int>(
            value: _shapeIndex,
            isExpanded: true,
            onChanged: (int? v) {
              if (v != null) {
                setState(() {
                  _shapeIndex = v;
                });
              }
            },
            items: List<DropdownMenuItem<int>>.generate(
              _shapeNames.length,
              (int i) => DropdownMenuItem<int>(value: i, child: Text(_shapeNames[i])),
            ),
          ),
          const SizedBox(height: 8),
          Text('Base size: ${_size.toStringAsFixed(1)}'),
          Slider(value: _size, min: 20, max: 160, divisions: 140, onChanged: (double v) => setState(() => _size = v)),
          Text('Offset X: ${_offsetX.toStringAsFixed(1)}'),
          Slider(value: _offsetX, min: 0, max: 180, divisions: 180, onChanged: (double v) => setState(() => _offsetX = v)),
          Text('Offset Y: ${_offsetY.toStringAsFixed(1)}'),
          Slider(value: _offsetY, min: 0, max: 180, divisions: 180, onChanged: (double v) => setState(() => _offsetY = v)),
          Text('RRect radius: ${_radius.toStringAsFixed(1)}'),
          Slider(value: _radius, min: 2, max: 90, divisions: 88, onChanged: (double v) => setState(() => _radius = v)),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              FilterChip(
                label: const Text('forceClosed'),
                selected: _forceClosed,
                onSelected: (bool v) {
                  setState(() => _forceClosed = v);
                  _rebuildMetrics();
                },
              ),
              FilterChip(label: const Text('show grid'), selected: _showGrid, onSelected: (bool v) => setState(() => _showGrid = v)),
              FilterChip(
                  label: const Text('show tangents'), selected: _showTangents, onSelected: (bool v) => setState(() => _showTangents = v)),
              FilterChip(
                  label: const Text('show extract'), selected: _showExtract, onSelected: (bool v) => setState(() => _showExtract = v)),
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
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _addContourByIndex(_shapeIndex);
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Contour'),
              ),
              OutlinedButton.icon(
                onPressed: _contours.isEmpty
                    ? null
                    : () {
                        setState(() {
                          final _ContourSpec removed = _contours.removeLast();
                          _emit('Removed contour ${_shapeNames[removed.type]}.');
                          _rebuildMetrics();
                        });
                      },
                icon: const Icon(Icons.remove_circle_outline),
                label: const Text('Remove Last'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _contours.clear();
                    _emit('Cleared all contours.');
                    _rebuildMetrics();
                  });
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text('Clear All'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _palette = (_palette + 1) % _palettes.length;
                  });
                },
                icon: const Icon(Icons.palette_outlined),
                label: const Text('Palette'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _canvasPanel() {
    final ui.Path path = _composePath();
    final ui.PathMetric? current = _currentMetricOrNull();
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
          const Text('Path + contour metrics canvas', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 250,
            child: Builder(
              builder: (BuildContext context) {
                return CustomPaint(
                  painter: _PathMetricPainter(
                    path: path,
                    metrics: _metricCache,
                    currentContourIndex: current?.contourIndex,
                    showGrid: _showGrid,
                    showTangents: _showTangents,
                    showExtract: _showExtract,
                    extractStart: _extractStart,
                    extractEnd: _extractEnd,
                    pulse: _animate ? _animValue : 0,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text('Contours: ${_contours.length} | Metrics: ${_metricCache.length} | forceClosed: $_forceClosed'),
        ],
      ),
    );
  }

  Widget _iteratorPanel() {
    final ui.PathMetric? current = _currentMetricOrNull();
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
          const Text('Iterator stepper', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              ElevatedButton.icon(onPressed: _iteratorMoveNext, icon: const Icon(Icons.skip_next), label: const Text('moveNext()')),
              OutlinedButton.icon(onPressed: _iteratorRunAll, icon: const Icon(Icons.fast_forward), label: const Text('Run All')),
              OutlinedButton.icon(onPressed: _iteratorReset, icon: const Icon(Icons.restart_alt), label: const Text('Reset Iterator')),
            ],
          ),
          const SizedBox(height: 8),
          Text('Started: $_iteratorStarted | Done: $_iteratorDone | Index: $_iteratorIndex'),
          const SizedBox(height: 8),
          if (current == null)
            const Text('current: unavailable (call moveNext successfully first).', style: TextStyle(fontSize: 12.2))
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _pill('contourIndex', '${current.contourIndex}'),
                _pill('length', current.length.toStringAsFixed(2)),
                _pill('isClosed', '${current.isClosed}'),
              ],
            ),
        ],
      ),
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

  Widget _extractPanel() {
    final ui.PathMetric? current = _currentMetricOrNull();
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
          const Text('Extraction and tangent sampling', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Extract start: ${_extractStart.toStringAsFixed(2)}'),
          Slider(value: _extractStart, min: 0, max: 1, divisions: 100, onChanged: (double v) => setState(() => _extractStart = v)),
          Text('Extract end: ${_extractEnd.toStringAsFixed(2)}'),
          Slider(value: _extractEnd, min: 0, max: 1, divisions: 100, onChanged: (double v) => setState(() => _extractEnd = v)),
          if (current == null)
            const Text('Select a current metric via iterator to inspect extraction values.', style: TextStyle(fontSize: 12.2))
          else ...<Widget>[
            _pill('extract range',
                '${(current.length * _extractStart.clamp(0, 1)).toStringAsFixed(1)} -> ${(current.length * _extractEnd.clamp(0, 1)).toStringAsFixed(1)}'),
            const SizedBox(height: 6),
            Builder(
              builder: (BuildContext context) {
                final double offset = current.length * ((_extractStart + _extractEnd) / 2).clamp(0, 1);
                final ui.Tangent? tangent = current.getTangentForOffset(offset);
                if (tangent == null) {
                  return const Text('Tangent unavailable for selected offset.', style: TextStyle(fontSize: 12.2));
                }
                return Text(
                  'Tangent @mid: pos(${tangent.position.dx.toStringAsFixed(1)}, ${tangent.position.dy.toStringAsFixed(1)}) '
                  'vec(${tangent.vector.dx.toStringAsFixed(2)}, ${tangent.vector.dy.toStringAsFixed(2)})',
                  style: const TextStyle(fontSize: 12.2),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _contourListPanel() {
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
          const Text('Contour inventory', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: _contours.isEmpty
                ? const Center(child: Text('No contours in path.', style: TextStyle(fontSize: 12.2, color: Color(0xFF64748B))))
                : ListView.builder(
                    itemCount: _contours.length,
                    itemBuilder: (BuildContext context, int index) {
                      final _ContourSpec c = _contours[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: c.color.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: c.color.withAlpha(95)),
                        ),
                        child: Text(
                          '#${index + 1} ${_shapeNames[c.type]} | pos(${c.x.toStringAsFixed(1)}, ${c.y.toStringAsFixed(1)}) '
                          '| size ${c.size.toStringAsFixed(1)} | radius ${c.radius.toStringAsFixed(1)}',
                          style: const TextStyle(fontSize: 12.1),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
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
        child: Row(
          children: <Widget>[
            Icon(ok ? Icons.check_circle : Icons.cancel, color: c, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(t, style: const TextStyle(fontSize: 12.2))),
          ],
        ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Runtime probe dashboard', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Passed: ${_passed.length}, Failed: ${_failed.length}'),
          const SizedBox(height: 8),
          ..._passed.map((String s) => line(s, true)),
          ..._failed.map((String s) => line(s, false)),
        ],
      ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Iteration notes', style: TextStyle(fontWeight: FontWeight.w700)),
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
        ],
      ),
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
        'PathMetricIterator summary: construct contours in a Path, compute metrics, then iterate '
        'contours in order via moveNext/current. Use metric lengths, extraction ranges, and tangent '
        'sampling for stroke reveals, path-following animation, and geometry diagnostics.',
        style: TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - PathMetricIterator'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.7,
      ),
      body: ListView(
        children: <Widget>[
          _header(),
          _section(
            '1) Concept overview',
            'Understand contour iteration semantics and metric-driven workflows.',
            Icons.menu_book,
            const Color(0xFF2563EB),
          ),
          _conceptCards(),
          _section(
            '2) Contour builder',
            'Create multi-contour paths to stress iterator behavior.',
            Icons.architecture,
            const Color(0xFF7C3AED),
          ),
          _builderPanel(),
          _section(
            '3) Path canvas',
            'Visualize contours, current metric, extraction, and tangent markers.',
            Icons.brush,
            const Color(0xFF0F766E),
          ),
          _canvasPanel(),
          _section(
            '4) Iterator stepping',
            'Drive moveNext/current lifecycle manually and as a batch run.',
            Icons.skip_next,
            const Color(0xFFB45309),
          ),
          _iteratorPanel(),
          _section(
            '5) Extraction details',
            'Inspect extractPath ranges and tangent sampling for current metric.',
            Icons.content_cut,
            const Color(0xFFBE123C),
          ),
          _extractPanel(),
          _section(
            '6) Contour inventory',
            'Review generated contour metadata for path composition.',
            Icons.list_alt,
            const Color(0xFF0369A1),
          ),
          _contourListPanel(),
          _section(
            '7) Probe checks',
            'Validate PathMetricIterator semantics and edge behavior.',
            Icons.fact_check,
            const Color(0xFF166534),
          ),
          _probePanel(),
          _section(
            '8) Notes and summary',
            'Operational trace and practical implementation guidance.',
            Icons.notes,
            const Color(0xFF475569),
          ),
          _notesPanel(),
          _summaryPanel(),
        ],
      ),
    );
  }
}

class _ContourSpec {
  const _ContourSpec({
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

class _PathMetricPainter extends CustomPainter {
  const _PathMetricPainter({
    required this.path,
    required this.metrics,
    required this.currentContourIndex,
    required this.showGrid,
    required this.showTangents,
    required this.showExtract,
    required this.extractStart,
    required this.extractEnd,
    required this.pulse,
  });

  final ui.Path path;
  final List<ui.PathMetric> metrics;
  final int? currentContourIndex;
  final bool showGrid;
  final bool showTangents;
  final bool showExtract;
  final double extractStart;
  final double extractEnd;
  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFF0F172A).withAlpha(24);
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)), bg);

    if (showGrid) {
      final Paint grid = Paint()
        ..color = Colors.white24
        ..strokeWidth = 1;
      const double step = 16;
      for (double x = 0; x <= size.width; x += step) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
      }
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
      }
    }

    final Paint base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0xFF334155);
    canvas.drawPath(path, base);

    for (final ui.PathMetric m in metrics) {
      final bool isCurrent = currentContourIndex != null && currentContourIndex == m.contourIndex;
      final Paint p = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = isCurrent ? 4 : 2
        ..color = isCurrent ? const Color(0xFF0EA5E9) : const Color(0xFF64748B).withAlpha(120);

      canvas.drawPath(m.extractPath(0, m.length), p);

      if (showExtract) {
        final double s = (extractStart.clamp(0, 1) * m.length).clamp(0, m.length);
        final double e = (extractEnd.clamp(0, 1) * m.length).clamp(0, m.length);
        final Paint ep = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = isCurrent ? 5 : 3
          ..color = isCurrent ? const Color(0xFF22C55E) : const Color(0xFFA3E635).withAlpha(120);
        canvas.drawPath(m.extractPath(s < e ? s : e, s < e ? e : s), ep);
      }

      if (showTangents) {
        final double offset = (pulse * m.length).clamp(0, m.length);
        final ui.Tangent? t = m.getTangentForOffset(offset);
        if (t != null) {
          canvas.drawCircle(t.position, 4, Paint()..color = const Color(0xFFFB7185));
          final Offset end = t.position + t.vector * 12;
          canvas.drawLine(t.position, end, Paint()..color = const Color(0xFFFB7185)..strokeWidth = 2);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PathMetricPainter oldDelegate) {
    return oldDelegate.path != path ||
        oldDelegate.metrics != metrics ||
        oldDelegate.currentContourIndex != currentContourIndex ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.showTangents != showTangents ||
        oldDelegate.showExtract != showExtract ||
        oldDelegate.extractStart != extractStart ||
        oldDelegate.extractEnd != extractEnd ||
        oldDelegate.pulse != pulse;
  }
}
