// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for FrameInfo from dart:ui
// FrameInfo provides decoded image frame data including duration for animations
// Used with Codec.getNextFrame() to iterate through animated image frames
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FrameInfo Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ABOUT FRAME INFO
  // ═══════════════════════════════════════════════════════════════════════════

  print('FrameInfo represents a single decoded frame from an animated image');
  print('Properties:');
  print('  .image → ui.Image: the decoded pixel data for this frame');
  print('  .duration → Duration: how long to display this frame');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: IMAGE CODEC FLOW
  // ═══════════════════════════════════════════════════════════════════════════

  print('Flow: bytes → Codec → FrameInfo → Image');
  print('  1. Load image bytes');
  print('  2. Instantiate Codec via instantiateImageCodec()');
  print('  3. Get frame count via codec.frameCount');
  print('  4. Get each frame via codec.getNextFrame()');
  print('  5. Each FrameInfo has .image and .duration');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ANIMATED VS STILL
  // ═══════════════════════════════════════════════════════════════════════════

  print('Still images: codec.frameCount == 1, duration == Duration.zero');
  print('Animated GIF: codec.frameCount > 1, each with unique duration');
  print('Animated WebP: same as GIF, codec.frameCount > 1');
  print('APNG: codec.frameCount > 1 for animated PNG');

  // Simulated animated GIF frames for visualization
  final gifFrames = <_SimFrame>[
    _SimFrame(0, Duration(milliseconds: 100), 64, 64, '🟥'),
    _SimFrame(1, Duration(milliseconds: 100), 64, 64, '🟧'),
    _SimFrame(2, Duration(milliseconds: 150), 64, 64, '🟨'),
    _SimFrame(3, Duration(milliseconds: 100), 64, 64, '🟩'),
    _SimFrame(4, Duration(milliseconds: 200), 64, 64, '🟦'),
    _SimFrame(5, Duration(milliseconds: 100), 64, 64, '🟪'),
    _SimFrame(6, Duration(milliseconds: 150), 64, 64, '⬜'),
    _SimFrame(7, Duration(milliseconds: 100), 64, 64, '🟥'),
  ];

  final totalDuration = gifFrames.fold<int>(
    0,
    (sum, f) => sum + f.duration.inMilliseconds,
  );
  final avgDuration = totalDuration ~/ gifFrames.length;

  // Simulated still image
  final stillFrame = _SimFrame(0, Duration.zero, 1920, 1080, '📷');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: REPETITION
  // ═══════════════════════════════════════════════════════════════════════════

  print('codec.repetitionCount:');
  print('  -1 = loop forever');
  print('   0 = play once');
  print('  >0 = play N+1 times');
  print('After the last frame, getNextFrame() wraps to the first');

  print('FrameInfo demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00695C), Color(0xFF4DB6AC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.burst_mode, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'FrameInfo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Decoded image frame with pixel data and display duration',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _headerChip('.image'),
                        SizedBox(width: 6),
                        _headerChip('.duration'),
                        SizedBox(width: 6),
                        _headerChip('Codec'),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 1: Properties ──
              _sectionTitle('1. FRAMEINFO PROPERTIES'),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _propRow(
                        'image',
                        'ui.Image',
                        'Decoded pixel data for this frame',
                        Color(0xFF00695C),
                      ),
                      _propRow(
                        'duration',
                        'Duration',
                        'How long to display before advancing',
                        Color(0xFF1565C0),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFFE0F2F1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'For still images (PNG, JPEG), duration is Duration.zero '
                          'and there is only one frame. For animated images (GIF, WebP, APNG), '
                          'each frame has its own duration.',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF00695C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Section 2: Codec Pipeline ──
              _sectionTitle('2. IMAGE DECODING PIPELINE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _pipeStep(
                      1,
                      'Load bytes',
                      'rootBundle.load / http.get / File.readAsBytes',
                      Icons.file_download,
                      Color(0xFF455A64),
                    ),
                    _pipeArrow(),
                    _pipeStep(
                      2,
                      'Create Codec',
                      'ui.instantiateImageCodec(bytes)',
                      Icons.settings,
                      Color(0xFF00695C),
                    ),
                    _pipeArrow(),
                    _pipeStep(
                      3,
                      'Check frame count',
                      'codec.frameCount → N frames',
                      Icons.format_list_numbered,
                      Color(0xFF1565C0),
                    ),
                    _pipeArrow(),
                    _pipeStep(
                      4,
                      'Get FrameInfo',
                      'codec.getNextFrame() → FrameInfo',
                      Icons.burst_mode,
                      Color(0xFFE65100),
                    ),
                    _pipeArrow(),
                    _pipeStep(
                      5,
                      'Use Image',
                      'frameInfo.image → paint on Canvas',
                      Icons.image,
                      Color(0xFF2E7D32),
                    ),
                    _pipeArrow(),
                    _pipeStep(
                      6,
                      'Dispose',
                      'frameInfo.image.dispose()',
                      Icons.delete_outline,
                      Color(0xFFC62828),
                    ),
                  ],
                ),
              ),

              // ── Section 3: Animated GIF Frame Strip ──
              _sectionTitle('3. ANIMATED GIF FRAMES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _statBadge(
                          '${gifFrames.length}',
                          'frames',
                          Color(0xFF00695C),
                        ),
                        SizedBox(width: 8),
                        _statBadge(
                          '${totalDuration}ms',
                          'total',
                          Color(0xFF1565C0),
                        ),
                        SizedBox(width: 8),
                        _statBadge(
                          '${avgDuration}ms',
                          'avg',
                          Color(0xFFE65100),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    // Frame strip visualization
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: gifFrames
                            .map(
                              (f) => Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 1),
                                  decoration: BoxDecoration(
                                    color: _frameColor(f.index),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      f.emoji,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Duration bars
                    ...gifFrames.map((f) => _frameDurationRow(f, 200)),
                  ],
                ),
              ),

              // ── Section 4: Still vs Animated ──
              _sectionTitle('4. STILL IMAGE VS ANIMATED'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _typeCard('Still Image', stillFrame, [
                        '1 frame only',
                        'Duration.zero',
                        'PNG, JPEG, BMP',
                        'No animation',
                      ], Color(0xFF455A64)),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _typeCard('Animated Image', gifFrames.first, [
                        'N frames',
                        'Each has duration',
                        'GIF, WebP, APNG',
                        'Loop control',
                      ], Color(0xFF00695C)),
                    ),
                  ],
                ),
              ),

              // ── Section 5: Repetition Count ──
              _sectionTitle('5. REPETITION COUNT'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _repRow(-1, 'Loop forever', '∞', Color(0xFF00695C)),
                    _repRow(0, 'Play once', '1×', Color(0xFF1565C0)),
                    _repRow(1, 'Play twice', '2×', Color(0xFFE65100)),
                    _repRow(5, 'Play six times', '6×', Color(0xFF4A148C)),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'codec.repetitionCount returns the value from the GIF '
                        'Netscape Extension block. -1 means infinite loop. '
                        'After all repetitions, stop at the last frame.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 6: Usage Code ──
              _sectionTitle('6. FRAME EXTRACTION CODE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: _codeBlock([
                  'Future<List<FrameInfo>> decodeAllFrames(',
                  '    Uint8List bytes) async {',
                  '  final codec = await ui.instantiateImageCodec(bytes);',
                  '  final frames = <FrameInfo>[];',
                  '',
                  '  for (int i = 0; i < codec.frameCount; i++) {',
                  '    final frame = await codec.getNextFrame();',
                  '    frames.add(frame);',
                  '    // frame.image is a ui.Image',
                  '    // frame.duration tells display time',
                  '  }',
                  '',
                  '  codec.dispose();',
                  '  return frames;',
                  '}',
                ]),
              ),

              // ── Section 7: Image Format Support ──
              _sectionTitle('7. FORMAT SUPPORT'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _formatRow('PNG', true, false, Color(0xFF2E7D32)),
                    _formatRow('JPEG', true, false, Color(0xFF1565C0)),
                    _formatRow('BMP', true, false, Color(0xFF455A64)),
                    _formatRow('GIF', true, true, Color(0xFFE65100)),
                    _formatRow('WebP', true, true, Color(0xFF4A148C)),
                    _formatRow('APNG', true, true, Color(0xFF00695C)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _legendDot('Still', Color(0xFF1565C0)),
                        SizedBox(width: 12),
                        _legendDot('Animated', Color(0xFFE65100)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── DATA CLASS ────────────────────────────────────────────────────────────

class _SimFrame {
  final int index;
  final Duration duration;
  final int width;
  final int height;
  final String emoji;
  _SimFrame(this.index, this.duration, this.width, this.height, this.emoji);
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF455A64),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _headerChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(label, style: TextStyle(fontSize: 10, color: Colors.white)),
  );
}

Widget _propRow(String name, String type, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 60,
          child: Text(
            '.$name',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(type, style: TextStyle(fontSize: 9, color: color)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _pipeStep(int n, String label, String desc, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, size: 14, color: Colors.white),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
            Text(
              desc,
              style: TextStyle(
                fontSize: 9,
                fontFamily: 'monospace',
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _pipeArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 12),
    child: Icon(Icons.arrow_downward, size: 12, color: Colors.grey[300]),
  );
}

Widget _statBadge(String value, String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 9, color: color)),
      ],
    ),
  );
}

Color _frameColor(int index) {
  final colors = [
    Color(0xFFE53935),
    Color(0xFFFB8C00),
    Color(0xFFFDD835),
    Color(0xFF43A047),
    Color(0xFF1E88E5),
    Color(0xFF8E24AA),
    Color(0xFFBDBDBD),
    Color(0xFFE53935),
  ];
  return colors[index % colors.length].withValues(alpha: 0.2);
}

Widget _frameDurationRow(_SimFrame f, int maxMs) {
  final fraction = f.duration.inMilliseconds / maxMs;
  final colors = [
    Color(0xFFE53935),
    Color(0xFFFB8C00),
    Color(0xFFFDD835),
    Color(0xFF43A047),
    Color(0xFF1E88E5),
    Color(0xFF8E24AA),
    Color(0xFFBDBDBD),
    Color(0xFFE53935),
  ];
  final color = colors[f.index % colors.length];
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1),
    child: Row(
      children: [
        SizedBox(
          width: 28,
          child: Text(
            '#${f.index}',
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0, 1),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 6),
        Text(
          '${f.duration.inMilliseconds}ms',
          style: TextStyle(
            fontSize: 9,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _typeCard(
  String title,
  _SimFrame sample,
  List<String> points,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: color,
          ),
        ),
        Text(sample.emoji, style: TextStyle(fontSize: 28)),
        Text(
          '${sample.width}×${sample.height}',
          style: TextStyle(fontSize: 9, color: Colors.grey[600]),
        ),
        SizedBox(height: 6),
        ...points.map(
          (p) => Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Row(
              children: [
                Icon(Icons.check, size: 10, color: color),
                SizedBox(width: 4),
                Flexible(child: Text(p, style: TextStyle(fontSize: 9))),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _repRow(int count, String desc, String symbol, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 24,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              '$count',
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 24,
          child: Text(symbol, style: TextStyle(fontSize: 14)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 10, color: Colors.grey[700]),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      lines.join('\n'),
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        color: Color(0xFF80CBC4),
        height: 1.4,
      ),
    ),
  );
}

Widget _formatRow(String format, bool still, bool animated, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            format,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 50,
          height: 18,
          decoration: BoxDecoration(
            color: still
                ? Color(0xFF1565C0).withValues(alpha: 0.1)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              still ? 'Still' : '—',
              style: TextStyle(
                fontSize: 9,
                color: still ? Color(0xFF1565C0) : Colors.grey[400],
              ),
            ),
          ),
        ),
        SizedBox(width: 6),
        Container(
          width: 60,
          height: 18,
          decoration: BoxDecoration(
            color: animated
                ? Color(0xFFE65100).withValues(alpha: 0.1)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              animated ? 'Animated' : '—',
              style: TextStyle(
                fontSize: 9,
                color: animated ? Color(0xFFE65100) : Colors.grey[400],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _legendDot(String label, Color color) {
  return Row(
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 9, color: color)),
    ],
  );
}
