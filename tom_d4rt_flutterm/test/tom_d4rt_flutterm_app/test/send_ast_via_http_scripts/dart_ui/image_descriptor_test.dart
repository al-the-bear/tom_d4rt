// D4rt test script: Deep demo for ImageDescriptor from dart:ui.
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const _ImageDescriptorDeepDemo(),
  );
}

class _ImageDescriptorDeepDemo extends StatefulWidget {
  const _ImageDescriptorDeepDemo();

  @override
  State<_ImageDescriptorDeepDemo> createState() => _ImageDescriptorDeepDemoState();
}

class _ImageDescriptorDeepDemoState extends State<_ImageDescriptorDeepDemo>
    with SingleTickerProviderStateMixin {
  double _targetWidth = 64;
  double _targetHeight = 64;
  double _density = 1.0;
  bool _useEncodedPath = true;
  bool _autoDispose = true;
  bool _showGrid = true;
  int _paletteIndex = 0;

  bool _running = false;
  ui.Image? _decodedImage;
  String _decodedSummary = 'No decode run yet';
  String _descriptorInfo = 'Descriptor info will appear after probes';

  final List<String> _passed = <String>[];
  final List<String> _failed = <String>[];
  final List<String> _notes = <String>[];

  late final AnimationController _pulseController;

  final List<List<Color>> _palettes = <List<Color>>[
    <Color>[const Color(0xFF0B132B), const Color(0xFF1C2541), const Color(0xFF5BC0BE)],
    <Color>[const Color(0xFF14213D), const Color(0xFFFCA311), const Color(0xFFE5E5E5)],
    <Color>[const Color(0xFF1B4332), const Color(0xFF2D6A4F), const Color(0xFF95D5B2)],
  ];

  static const List<int> _tinyPngBytes = <int>[
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
    0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
    0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
    0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
    0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41,
    0x54, 0x78, 0x9C, 0x63, 0xF8, 0xCF, 0xC0, 0x00,
    0x00, 0x04, 0x00, 0x01, 0xFE, 0xA7, 0x56, 0xF5,
    0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44,
    0xAE, 0x42, 0x60, 0x82,
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _runProbes();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _decodedImage?.dispose();
    super.dispose();
  }

  void _recordProbe(String name, bool ok, {String? note}) {
    if (ok) {
      _passed.add(name);
    } else {
      _failed.add(name);
    }
    if (note != null && note.isNotEmpty) {
      _notes.add('$name: $note');
    }
  }

  Uint8List _buildRawRgbaPattern(int w, int h) {
    final Uint8List bytes = Uint8List(w * h * 4);
    int i = 0;
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        final int r = (255 * x / w).round();
        final int g = (255 * y / h).round();
        final int b = (255 * ((x + y) % w) / w).round();
        bytes[i++] = r;
        bytes[i++] = g;
        bytes[i++] = b;
        bytes[i++] = 255;
      }
    }
    return bytes;
  }

  Future<void> _runEncodedProbe() async {
    ui.ImmutableBuffer? buffer;
    ui.ImageDescriptor? descriptor;
    ui.Codec? codec;
    try {
      buffer = await ui.ImmutableBuffer.fromUint8List(Uint8List.fromList(_tinyPngBytes));
      _recordProbe('ImmutableBuffer.fromUint8List (encoded)', true);

      descriptor = await ui.ImageDescriptor.encoded(buffer);
      _recordProbe(
        'ImageDescriptor.encoded creation',
        true,
        note: 'w=${descriptor.width}, h=${descriptor.height}, bpp=${descriptor.bytesPerPixel}',
      );

      codec = await descriptor.instantiateCodec(
        targetWidth: (_targetWidth * _density).round(),
        targetHeight: (_targetHeight * _density).round(),
      );
      _recordProbe('instantiateCodec from encoded descriptor', true);

      final ui.FrameInfo frame = await codec.getNextFrame();
      _decodedImage?.dispose();
      _decodedImage = frame.image;
      _decodedSummary =
          'Decoded frame from encoded path: ${frame.image.width}x${frame.image.height}';
      _descriptorInfo =
          'Encoded descriptor => width=${descriptor.width}, height=${descriptor.height}, '
          'bytesPerPixel=${descriptor.bytesPerPixel}';
      _recordProbe('getNextFrame from encoded codec', true);
    } catch (e) {
      _recordProbe('Encoded descriptor pipeline', false, note: e.toString());
    } finally {
      codec?.dispose();
      if (_autoDispose) {
        descriptor?.dispose();
        buffer?.dispose();
      }
    }
  }

  Future<void> _runRawProbe() async {
    ui.ImmutableBuffer? buffer;
    ui.ImageDescriptor? descriptor;
    ui.Codec? codec;
    try {
      final Uint8List raw = _buildRawRgbaPattern(48, 48);
      buffer = await ui.ImmutableBuffer.fromUint8List(raw);
      _recordProbe('ImmutableBuffer.fromUint8List (raw)', true);

      descriptor = ui.ImageDescriptor.raw(
        buffer,
        width: 48,
        height: 48,
        pixelFormat: ui.PixelFormat.rgba8888,
      );
      _recordProbe(
        'ImageDescriptor.raw creation',
        true,
        note: 'w=${descriptor.width}, h=${descriptor.height}, bpp=${descriptor.bytesPerPixel}',
      );

      codec = await descriptor.instantiateCodec(
        targetWidth: (_targetWidth * _density).round(),
        targetHeight: (_targetHeight * _density).round(),
      );
      _recordProbe('instantiateCodec from raw descriptor', true);

      final ui.FrameInfo frame = await codec.getNextFrame();
      _decodedImage?.dispose();
      _decodedImage = frame.image;
      _decodedSummary =
          'Decoded frame from raw path: ${frame.image.width}x${frame.image.height}';
      _descriptorInfo =
          'Raw descriptor => width=${descriptor.width}, height=${descriptor.height}, '
          'bytesPerPixel=${descriptor.bytesPerPixel}';
      _recordProbe('getNextFrame from raw codec', true);
    } catch (e) {
      _recordProbe('Raw descriptor pipeline', false, note: e.toString());
    } finally {
      codec?.dispose();
      if (_autoDispose) {
        descriptor?.dispose();
        buffer?.dispose();
      }
    }
  }

  Future<void> _runProbes() async {
    if (_running) {
      return;
    }
    setState(() {
      _running = true;
      _passed.clear();
      _failed.clear();
      _notes.clear();
    });

    _recordProbe('ImageDescriptor concept loaded', true);
    _recordProbe('Target sizing available', _targetWidth > 0 && _targetHeight > 0);

    if (_useEncodedPath) {
      await _runEncodedProbe();
    } else {
      await _runRawProbe();
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _running = false;
    });
  }

  Widget _sectionTitle(String title, String subtitle, IconData icon, Color accent) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withAlpha(24),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withAlpha(90)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withAlpha(35),
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
    final List<Color> palette = _palettes[_paletteIndex];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: palette),
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: palette[1].withAlpha(100),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ImageDescriptor',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'ImageDescriptor describes image bytes and decoding parameters before creating a Codec. '
            'This demo visualizes encoded and raw pathways, target sizing, decode output, '
            'and interpreter-friendly probe results.',
            style: TextStyle(color: Colors.white, fontSize: 13.2, height: 1.35),
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycleCards() {
    Widget card(IconData icon, String title, String text, Color color) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withAlpha(90)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
              const SizedBox(height: 4),
              Text(text, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          card(Icons.dataset, '1) Bytes', 'Encoded PNG or raw RGBA data in ImmutableBuffer.',
              const Color(0xFF0EA5E9)),
          card(Icons.schema, '2) Descriptor', 'ImageDescriptor stores dimensions and pixel info.',
              const Color(0xFF10B981)),
          card(Icons.movie_filter, '3) Codec', 'instantiateCodec creates frame stream at target size.',
              const Color(0xFF8B5CF6)),
          card(Icons.image, '4) Frame', 'Use frame.image in RawImage/Canvas rendering.',
              const Color(0xFFF97316)),
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE4EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Decode controls', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('Target width: ${_targetWidth.toStringAsFixed(0)}'),
          Slider(
            value: _targetWidth,
            min: 16,
            max: 220,
            divisions: 204,
            onChanged: (double v) {
              setState(() {
                _targetWidth = v;
              });
            },
          ),
          Text('Target height: ${_targetHeight.toStringAsFixed(0)}'),
          Slider(
            value: _targetHeight,
            min: 16,
            max: 220,
            divisions: 204,
            onChanged: (double v) {
              setState(() {
                _targetHeight = v;
              });
            },
          ),
          Text('Pixel density multiplier: ${_density.toStringAsFixed(2)}'),
          Slider(
            value: _density,
            min: 0.5,
            max: 3.0,
            divisions: 25,
            onChanged: (double v) {
              setState(() {
                _density = v;
              });
            },
          ),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: <Widget>[
              ChoiceChip(
                label: const Text('Encoded path'),
                selected: _useEncodedPath,
                onSelected: (_) {
                  setState(() {
                    _useEncodedPath = true;
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Raw path'),
                selected: !_useEncodedPath,
                onSelected: (_) {
                  setState(() {
                    _useEncodedPath = false;
                  });
                },
              ),
              FilterChip(
                label: const Text('Auto dispose resources'),
                selected: _autoDispose,
                onSelected: (bool v) {
                  setState(() {
                    _autoDispose = v;
                  });
                },
              ),
              FilterChip(
                label: const Text('Grid overlay'),
                selected: _showGrid,
                onSelected: (bool v) {
                  setState(() {
                    _showGrid = v;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _running ? null : _runProbes,
                icon: const Icon(Icons.play_arrow, size: 18),
                label: Text(_running ? 'Running...' : 'Run decode probes'),
              ),
              const SizedBox(width: 10),
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

  Widget _buildDecodedPreview() {
    final List<Color> palette = _palettes[_paletteIndex];
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
          const Text('Decoded image output', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[palette[0], palette[1], palette[2]],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: <Widget>[
                if (_showGrid)
                  const Positioned.fill(child: CustomPaint(painter: _DescriptorGridPainter())),
                Center(
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (BuildContext context, Widget? child) {
                      final double scale = 0.95 + (_pulseController.value * 0.08);
                      return Transform.scale(scale: scale, child: child);
                    },
                    child: Container(
                      width: 180,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withAlpha(120), width: 1.4),
                      ),
                      child: _decodedImage == null
                          ? const Center(
                              child: Text(
                                'No decoded image yet',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: RawImage(image: _decodedImage, fit: BoxFit.cover),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(_decodedSummary, style: const TextStyle(fontSize: 12.4)),
          const SizedBox(height: 4),
          Text(_descriptorInfo, style: const TextStyle(fontSize: 12.4)),
        ],
      ),
    );
  }

  Widget _buildPixelFormatGallery() {
    Widget tile(String title, String details, Color color, IconData icon) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withAlpha(85)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: color),
              const SizedBox(height: 8),
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
              const SizedBox(height: 4),
              Text(details, style: const TextStyle(fontSize: 11.8)),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          tile(
            'rgba8888',
            'Common raw format: 4 bytes per pixel (R,G,B,A).',
            const Color(0xFF0EA5E9),
            Icons.palette,
          ),
          tile(
            'Encoded (PNG/JPEG)',
            'Compressed source bytes, descriptor resolves dimensions.',
            const Color(0xFF10B981),
            Icons.compress,
          ),
          tile(
            'Target sizing',
            'instantiateCodec can request decoded dimensions.',
            const Color(0xFFF97316),
            Icons.aspect_ratio,
          ),
        ],
      ),
    );
  }

  Widget _buildPracticalUseCases() {
    Widget card(
      String title,
      String detail,
      List<Color> colors,
      IconData icon,
    ) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(icon, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(detail, style: const TextStyle(color: Colors.white, fontSize: 12)),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          card(
            'Thumbnail pipeline',
            'Create descriptors for uploaded photos, decode to card-sized previews.',
            const <Color>[Color(0xFF2563EB), Color(0xFF60A5FA)],
            Icons.photo_size_select_large,
          ),
          card(
            'Sprite preparation',
            'Decode raw atlas bytes with explicit pixel format and target size.',
            const <Color>[Color(0xFF7C3AED), Color(0xFFA78BFA)],
            Icons.grid_view,
          ),
          card(
            'Adaptive memory strategy',
            'Tune target dimensions before frame decode to reduce memory pressure.',
            const <Color>[Color(0xFF0F766E), Color(0xFF2DD4BF)],
            Icons.memory,
          ),
        ],
      ),
    );
  }

  Widget _buildProbeDashboard() {
    Widget probeLine(String text, bool ok) {
      final Color c = ok ? const Color(0xFF15803D) : const Color(0xFFB91C1C);
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: c.withAlpha(18),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: c.withAlpha(90)),
        ),
        child: Row(
          children: <Widget>[
            Icon(ok ? Icons.check_circle : Icons.cancel, color: c, size: 18),
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
          const Text('Runtime probe dashboard', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Passed: ${_passed.length}   Failed: ${_failed.length}'),
          const SizedBox(height: 8),
          ..._passed.map((String p) => probeLine(p, true)),
          ..._failed.map((String f) => probeLine(f, false)),
          if (_notes.isNotEmpty) ...<Widget>[
            const SizedBox(height: 8),
            const Text('Notes', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            ..._notes.map(
              (String n) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('- $n', style: const TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummary() {
    final String mode = _useEncodedPath ? 'encoded bytes path' : 'raw pixel path';
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD4DEE9)),
      ),
      child: Text(
        'Summary: This deep demo validates ImageDescriptor behavior in interpreter execution by '
        'running real decode probes and showing visual decode output. Current focus mode is $mode. '
        'Use ImageDescriptor when you need structured control over decoding from bytes to codec frames.',
        style: const TextStyle(fontSize: 12.4, height: 1.35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('dart:ui - ImageDescriptor'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0.6,
      ),
      body: ListView(
        children: <Widget>[
          _buildHeader(),
          _sectionTitle(
            '1) Descriptor lifecycle',
            'From byte buffer to descriptor to codec frame.',
            Icons.timeline,
            const Color(0xFF2563EB),
          ),
          _buildLifecycleCards(),
          _sectionTitle(
            '2) Decode controls',
            'Adjust target dimensions and path type before probe execution.',
            Icons.tune,
            const Color(0xFF0F766E),
          ),
          _buildControls(),
          _sectionTitle(
            '3) Visual decode output',
            'Rendered frame preview produced from descriptor-based decoding.',
            Icons.image_search,
            const Color(0xFF7C3AED),
          ),
          _buildDecodedPreview(),
          _sectionTitle(
            '4) Pixel format concepts',
            'How raw and encoded inputs map to descriptor usage.',
            Icons.color_lens,
            const Color(0xFFF97316),
          ),
          _buildPixelFormatGallery(),
          _sectionTitle(
            '5) Practical applications',
            'Where ImageDescriptor provides control in real UI pipelines.',
            Icons.widgets,
            const Color(0xFF0EA5E9),
          ),
          _buildPracticalUseCases(),
          _sectionTitle(
            '6) Probe results',
            'Interpreter-oriented runtime checks with pass/fail reporting.',
            Icons.fact_check,
            const Color(0xFF166534),
          ),
          _buildProbeDashboard(),
          _sectionTitle(
            '7) Final notes',
            'When to choose encoded vs raw descriptor pathways.',
            Icons.info_outline,
            const Color(0xFF334155),
          ),
          _buildSummary(),
        ],
      ),
    );
  }
}

class _DescriptorGridPainter extends CustomPainter {
  const _DescriptorGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1;
    const double gap = 18;
    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant _DescriptorGridPainter oldDelegate) {
    return false;
  }
}
