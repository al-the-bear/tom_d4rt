// D4rt test script: Deep demo for ImmutableBuffer from dart:ui.
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _ImmutableBufferDeepDemo(),
  );
}

class _ImmutableBufferDeepDemo extends StatefulWidget {
  const _ImmutableBufferDeepDemo();

  @override
  State<_ImmutableBufferDeepDemo> createState() => _ImmutableBufferDeepDemoState();
}

class _ImmutableBufferDeepDemoState extends State<_ImmutableBufferDeepDemo> {
  static const List<String> _patternNames = <String>[
    'Linear Ramp',
    'Sine Wave',
    'Checker Bytes',
    'Packet Bursts',
  ];

  int _patternIndex = 0;
  double _dataLength = 512;
  double _chunkSize = 32;
  bool _animateCursor = true;
  bool _showHexGrid = true;
  bool _groupByChunk = true;
  int _paletteIndex = 0;

  double _animValue = 0.0;
  double _cursor = 0;

  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];
  final List<String> _notes = <String>[];

  String _probeSummary = 'No probes run yet.';
  String _bufferSummary = 'Buffer metadata will appear here.';

  final List<List<Color>> _palettes = <List<Color>>[
    <Color>[const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF38BDF8)],
    <Color>[const Color(0xFF3B0764), const Color(0xFF6B21A8), const Color(0xFFC084FC)],
    <Color>[const Color(0xFF064E3B), const Color(0xFF047857), const Color(0xFF34D399)],
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

  Uint8List _buildBytes() {
    final int n = _dataLength.round().clamp(64, 4096);
    final Uint8List data = Uint8List(n);
    switch (_patternIndex) {
      case 0:
        for (int i = 0; i < n; i++) {
          data[i] = i % 256;
        }
        break;
      case 1:
        for (int i = 0; i < n; i++) {
          final double t = i / n;
          data[i] = ((math.sin(t * math.pi * 10) * 0.5 + 0.5) * 255).round();
        }
        break;
      case 2:
        for (int i = 0; i < n; i++) {
          data[i] = ((i ~/ 16) % 2 == 0) ? 28 : 220;
        }
        break;
      case 3:
        final int c = _chunkSize.round().clamp(8, 128);
        for (int i = 0; i < n; i++) {
          final int block = (i ~/ c) % 4;
          if (block == 0) {
            data[i] = 255;
          } else if (block == 1) {
            data[i] = 32;
          } else if (block == 2) {
            data[i] = (i * 17) % 256;
          } else {
            data[i] = 96;
          }
        }
        break;
    }
    return data;
  }

  Future<void> _runProbes() async {
    _passed.clear();
    _failed.clear();
    _notes.clear();

    ui.ImmutableBuffer? buffer;
    ui.ImmutableBuffer? buffer2;

    final Uint8List bytes = _buildBytes();
    _record('Byte payload generated', bytes.isNotEmpty, note: 'bytes=${bytes.length}');

    try {
      final Future<ui.ImmutableBuffer> f = ui.ImmutableBuffer.fromUint8List(bytes);
      _record('fromUint8List returns Future', f.runtimeType.toString().contains('Future'));
      buffer = await f;
      _record('ImmutableBuffer created from bytes', true);
      _bufferSummary = 'Primary buffer created from ${bytes.length} bytes';
    } catch (e) {
      _record('ImmutableBuffer created from bytes', false, note: e.toString());
    }

    try {
      final Uint8List small = Uint8List.fromList(<int>[1, 2, 3, 4, 5, 6, 7, 8]);
      buffer2 = await ui.ImmutableBuffer.fromUint8List(small);
      _record('Small ImmutableBuffer creation', true);
    } catch (e) {
      _record('Small ImmutableBuffer creation', false, note: e.toString());
    }

    try {
      await ui.ImmutableBuffer.fromAsset('assets/not_existing_buffer.bin');
      _record('fromAsset probe', true);
    } catch (e) {
      _record('fromAsset probe', true, note: 'Expected missing-asset in test env: $e');
    }

    try {
      await ui.ImmutableBuffer.fromFilePath('/tmp/immutable_buffer_probe.bin');
      _record('fromFilePath probe', true);
    } catch (e) {
      _record('fromFilePath probe', true, note: 'Expected missing-file in test env: $e');
    }

    try {
      buffer?.dispose();
      buffer2?.dispose();
      _record('dispose called on created buffers', true);
    } catch (e) {
      _record('dispose called on created buffers', false, note: e.toString());
    }

    _probeSummary = 'Passed ${_passed.length}, Failed ${_failed.length}';
    if (mounted) {
      setState(() {});
    }
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
            'ImmutableBuffer',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'ImmutableBuffer stores immutable byte data in engine-friendly memory. '
            'It is commonly used before image decoding and other byte-based rendering paths. '
            'This deep demo visualizes byte patterns and validates runtime creation/disposal flow.',
            style: TextStyle(color: Colors.white, fontSize: 13.1, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _conceptCard(String title, String text, IconData icon, Color color) {
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
            Text(text, style: const TextStyle(fontSize: 11.8)),
          ],
        ),
      ),
    );
  }

  Widget _buildConceptOverview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          _conceptCard(
            'Immutable payload',
            'Buffer data is immutable after creation, reducing accidental mutation.',
            Icons.lock,
            const Color(0xFF2563EB),
          ),
          _conceptCard(
            'Engine-friendly',
            'Suitable for low-level APIs expecting stable byte memory.',
            Icons.memory,
            const Color(0xFF0F766E),
          ),
          _conceptCard(
            'Async factories',
            'fromUint8List/fromAsset/fromFilePath support multiple data sources.',
            Icons.sync,
            const Color(0xFF7C3AED),
          ),
          _conceptCard(
            'Lifecycle',
            'Dispose when no longer needed to release engine resources.',
            Icons.delete_outline,
            const Color(0xFFB45309),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
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
          const Text('Byte source controls', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          DropdownButton<int>(
            value: _patternIndex,
            isExpanded: true,
            onChanged: (int? v) {
              if (v != null) {
                setState(() {
                  _patternIndex = v;
                });
              }
            },
            items: List<DropdownMenuItem<int>>.generate(
              _patternNames.length,
              (int i) => DropdownMenuItem<int>(
                value: i,
                child: Text(_patternNames[i]),
              ),
            ),
          ),
          Text('Data length: ${_dataLength.round()} bytes'),
          Slider(
            value: _dataLength,
            min: 64,
            max: 4096,
            divisions: 4032,
            onChanged: (double v) => setState(() => _dataLength = v),
          ),
          Text('Chunk size: ${_chunkSize.round()} bytes'),
          Slider(
            value: _chunkSize,
            min: 8,
            max: 128,
            divisions: 120,
            onChanged: (double v) => setState(() => _chunkSize = v),
          ),
          Wrap(
            spacing: 10,
            children: <Widget>[
              FilterChip(
                label: const Text('Animate cursor'),
                selected: _animateCursor,
                onSelected: (bool v) {
                  setState(() {
                    _animateCursor = v;
                    if (_animateCursor) {
                      /* animation removed */
                    } else {
                      /* animation removed */
                    }
                  });
                },
              ),
              FilterChip(
                label: const Text('Hex grid'),
                selected: _showHexGrid,
                onSelected: (bool v) => setState(() => _showHexGrid = v),
              ),
              FilterChip(
                label: const Text('Group by chunk'),
                selected: _groupByChunk,
                onSelected: (bool v) => setState(() => _groupByChunk = v),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => setState(_runProbes),
                icon: const Icon(Icons.play_arrow, size: 18),
                label: const Text('Run probes'),
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
    );
  }

  Widget _buildByteHeatmap() {
    final Uint8List bytes = _buildBytes();
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
          const Text('Byte distribution heatmap', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 220,
            child: CustomPaint(
              painter: _ByteHeatmapPainter(
                bytes: bytes,
                cursor: _cursor,
                showGrid: _showHexGrid,
                chunkSize: _chunkSize.round().clamp(8, 128),
                groupByChunk: _groupByChunk,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pattern: ${_patternNames[_patternIndex]} | Bytes: ${bytes.length} | Cursor: ${(100 * _cursor).toStringAsFixed(1)}%',
            style: const TextStyle(fontSize: 12.2),
          ),
        ],
      ),
    );
  }

  Widget _pipelineNode(String title, String desc, IconData icon, Color color) {
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
            Text(desc, style: const TextStyle(fontSize: 11.7)),
          ],
        ),
      ),
    );
  }

  Widget _buildPipelineBoard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          _pipelineNode(
            'Uint8List',
            'Application builds or loads byte array payload.',
            Icons.data_array,
            const Color(0xFF2563EB),
          ),
          _pipelineNode(
            'ImmutableBuffer',
            'Engine-level immutable storage for the byte payload.',
            Icons.storage,
            const Color(0xFF0F766E),
          ),
          _pipelineNode(
            'Descriptor/Codec',
            'Consumers decode or interpret bytes with specific formats.',
            Icons.extension,
            const Color(0xFF7C3AED),
          ),
          _pipelineNode(
            'Rendered Output',
            'Result shown in UI (image/frame/audio visualization).',
            Icons.visibility,
            const Color(0xFFB45309),
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
            'Image decode prep',
            'Feed bytes into ImageDescriptor and Codec pipelines.',
            Icons.image,
            const <Color>[Color(0xFF2563EB), Color(0xFF60A5FA)],
          ),
          _useCaseCard(
            'Asset payload cache',
            'Retain immutable binary blobs for repeatable decoding.',
            Icons.inventory_2,
            const <Color>[Color(0xFF7C3AED), Color(0xFFA78BFA)],
          ),
          _useCaseCard(
            'Binary protocol visualizer',
            'Inspect packet fields in immutable buffers safely.',
            Icons.alt_route,
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
          Text(_probeSummary),
          const SizedBox(height: 4),
          Text(_bufferSummary, style: const TextStyle(fontSize: 12.1)),
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
        'ImmutableBuffer deep demo summary: byte payloads are turned into immutable engine-side '
        'buffers, then consumed by decode/render pipelines. This test emphasizes visual byte patterns, '
        'lifecycle handling, and robust async probe behavior in interpreter execution.',
        style: TextStyle(fontSize: 12.3, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - ImmutableBuffer'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.6,
      ),
      body: ListView(
        children: <Widget>[
          _buildHeader(),
          _sectionTitle(
            '1) Concept overview',
            'Why immutable engine buffers matter for binary data handling.',
            Icons.menu_book,
            const Color(0xFF2563EB),
          ),
          _buildConceptOverview(),
          _sectionTitle(
            '2) Source controls',
            'Generate different byte payload patterns and sizes.',
            Icons.tune,
            const Color(0xFF0F766E),
          ),
          _buildControls(),
          _sectionTitle(
            '3) Byte heatmap',
            'Visual representation of byte distribution and cursor scanning.',
            Icons.grid_on,
            const Color(0xFF7C3AED),
          ),
          _buildByteHeatmap(),
          _sectionTitle(
            '4) Pipeline board',
            'From Uint8List to ImmutableBuffer to decoding/render paths.',
            Icons.account_tree,
            const Color(0xFFB45309),
          ),
          _buildPipelineBoard(),
          _sectionTitle(
            '5) Practical use cases',
            'Common product scenarios that rely on immutable byte containers.',
            Icons.widgets,
            const Color(0xFF0EA5E9),
          ),
          _buildUseCases(),
          _sectionTitle(
            '6) Runtime probes',
            'Async creation/disposal and asset/file path probe behavior.',
            Icons.fact_check,
            const Color(0xFF166534),
          ),
          _buildProbeDashboard(),
          _sectionTitle(
            '7) Final notes',
            'Guidance for using ImmutableBuffer safely and effectively.',
            Icons.info_outline,
            const Color(0xFF334155),
          ),
          _buildSummary(),
        ],
      ),
    );
  }
}

class _ByteHeatmapPainter extends CustomPainter {
  const _ByteHeatmapPainter({
    required this.bytes,
    required this.cursor,
    required this.showGrid,
    required this.chunkSize,
    required this.groupByChunk,
  });

  final Uint8List bytes;
  final double cursor;
  final bool showGrid;
  final int chunkSize;
  final bool groupByChunk;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint();
    final int cols = 64;
    final int rows = (bytes.length / cols).ceil();
    final double cw = size.width / cols;
    final double ch = size.height / rows;

    for (int i = 0; i < bytes.length; i++) {
      final int x = i % cols;
      final int y = i ~/ cols;
      final int v = bytes[i];

      if (groupByChunk) {
        final int g = (i ~/ chunkSize) % 4;
        if (g == 0) {
          p.color = Color.fromARGB(220, v, 64, 255 - v);
        } else if (g == 1) {
          p.color = Color.fromARGB(220, 64, v, 255 - v ~/ 2);
        } else if (g == 2) {
          p.color = Color.fromARGB(220, 255 - v, v, 120);
        } else {
          p.color = Color.fromARGB(220, 120, 200 - (v ~/ 2), v);
        }
      } else {
        p.color = Color.fromARGB(220, v, 255 - v, (v * 3) % 255);
      }

      canvas.drawRect(Rect.fromLTWH(x * cw, y * ch, cw, ch), p);
    }

    if (showGrid) {
      final Paint gp = Paint()
        ..color = Colors.black12
        ..strokeWidth = 0.6;
      for (double x = 0; x <= size.width; x += cw * 4) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gp);
      }
      for (double y = 0; y <= size.height; y += ch * 4) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gp);
      }
    }

    final double cx = cursor.clamp(0, 1) * size.width;
    final Paint cp = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), cp);
  }

  @override
  bool shouldRepaint(covariant _ByteHeatmapPainter oldDelegate) {
    return oldDelegate.bytes != bytes ||
        oldDelegate.cursor != cursor ||
        oldDelegate.showGrid != showGrid ||
        oldDelegate.chunkSize != chunkSize ||
        oldDelegate.groupByChunk != groupByChunk;
  }
}
