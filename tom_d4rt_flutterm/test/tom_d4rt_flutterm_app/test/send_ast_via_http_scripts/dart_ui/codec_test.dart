// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for Codec & TargetImageSize from dart:ui
// Codec represents an encoded image with frame access (no public constructor).
// TargetImageSize specifies desired decode dimensions.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Codec & TargetImageSize Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Codec Type Reference
  // ═══════════════════════════════════════════════════════════════════════════
  // Codec has no public constructor — it's obtained from:
  //   - ImageDescriptor.instantiateCodec()
  //   - ui.instantiateImageCodec()
  // Codec API surface:
  //   - frameCount: int (number of frames)
  //   - repetitionCount: int (-1 = infinite loop, 0 = play once)
  //   - getNextFrame() -> Future<FrameInfo>
  //   - dispose()

  print('Codec type: ${ui.Codec}');
  print('FrameInfo type: ${ui.FrameInfo}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: TargetImageSize Constructors
  // ═══════════════════════════════════════════════════════════════════════════

  final ts1 = ui.TargetImageSize();
  print('TargetImageSize(): w=${ts1.width}, h=${ts1.height}');

  final ts2 = ui.TargetImageSize(width: 200, height: 300);
  print('TargetImageSize(200,300): w=${ts2.width}, h=${ts2.height}');

  final ts3 = ui.TargetImageSize(width: 150);
  print('TargetImageSize(w:150): w=${ts3.width}, h=${ts3.height}');

  final ts4 = ui.TargetImageSize(height: 250);
  print('TargetImageSize(h:250): w=${ts4.width}, h=${ts4.height}');

  // Various aspect ratio scenarios
  final ts5 = ui.TargetImageSize(width: 1920, height: 1080);
  print('1080p: w=${ts5.width}, h=${ts5.height}');

  final ts6 = ui.TargetImageSize(width: 3840, height: 2160);
  print('4K: w=${ts6.width}, h=${ts6.height}');

  final ts7 = ui.TargetImageSize(width: 64, height: 64);
  print('Icon 64x64: w=${ts7.width}, h=${ts7.height}');

  final ts8 = ui.TargetImageSize(width: 1, height: 1);
  print('Pixel: w=${ts8.width}, h=${ts8.height}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: TargetImageSize Equality & Hashing
  // ═══════════════════════════════════════════════════════════════════════════

  final eqA = ui.TargetImageSize(width: 100, height: 100);
  final eqB = ui.TargetImageSize(width: 100, height: 100);
  final eqC = ui.TargetImageSize(width: 100, height: 200);
  print('eqA == eqB: ${eqA == eqB}');
  print('eqA == eqC: ${eqA == eqC}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Common Image Size Presets
  // ═══════════════════════════════════════════════════════════════════════════

  final presets = <String, ui.TargetImageSize>{
    'Thumbnail': ui.TargetImageSize(width: 128, height: 128),
    'Avatar': ui.TargetImageSize(width: 256, height: 256),
    'SD 480p': ui.TargetImageSize(width: 854, height: 480),
    'HD 720p': ui.TargetImageSize(width: 1280, height: 720),
    'FHD 1080p': ui.TargetImageSize(width: 1920, height: 1080),
    '4K UHD': ui.TargetImageSize(width: 3840, height: 2160),
    'Square 1:1': ui.TargetImageSize(width: 500, height: 500),
    'Portrait': ui.TargetImageSize(width: 1080, height: 1920),
  };
  for (final entry in presets.entries) {
    print('${entry.key}: ${entry.value.width}x${entry.value.height}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Aspect Ratio Calculations
  // ═══════════════════════════════════════════════════════════════════════════

  final ratios = <String, List<int>>{
    '16:9': [1920, 1080],
    '4:3': [1600, 1200],
    '1:1': [500, 500],
    '21:9': [2520, 1080],
    '9:16': [1080, 1920],
  };
  for (final entry in ratios.entries) {
    final ts = ui.TargetImageSize(
      width: entry.value[0],
      height: entry.value[1],
    );
    final ratio = ts.width! / ts.height!;
    print(
      '${entry.key}: ${ts.width}x${ts.height} = ${ratio.toStringAsFixed(3)}',
    );
  }

  print('Codec and TargetImageSize demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
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
                    colors: [Color(0xFF4A148C), Color(0xFFAB47BC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.image, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Codec & TargetImageSize',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Image decoding & dimension targeting',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 1: Codec API Overview ──
              _sectionTitle('1. CODEC API OVERVIEW'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _apiItem(
                      Icons.layers,
                      'frameCount',
                      'Number of frames in image',
                      Color(0xFF4A148C),
                    ),
                    Divider(height: 16),
                    _apiItem(
                      Icons.repeat,
                      'repetitionCount',
                      '-1 = infinite loop, 0 = play once',
                      Color(0xFF6A1B9A),
                    ),
                    Divider(height: 16),
                    _apiItem(
                      Icons.skip_next,
                      'getNextFrame()',
                      'Returns Future<FrameInfo> with image + duration',
                      Color(0xFF7B1FA2),
                    ),
                    Divider(height: 16),
                    _apiItem(
                      Icons.delete_outline,
                      'dispose()',
                      'Release native resources',
                      Color(0xFF8E24AA),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3E5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Note: Codec has no public constructor. '
                        'Obtained via ImageDescriptor.instantiateCodec() '
                        'or ui.instantiateImageCodec().',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF4A148C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 2: FrameInfo ──
              _sectionTitle('2. FRAMEINFO STRUCTURE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _frameInfoCard(
                        'image',
                        'ui.Image',
                        'Decoded pixel data',
                        Icons.photo,
                        Color(0xFF1565C0),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _frameInfoCard(
                        'duration',
                        'Duration',
                        'Frame display time',
                        Icons.timer,
                        Color(0xFF00695C),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 3: TargetImageSize Constructor Variants ──
              _sectionTitle('3. TARGETIMAGESIZE CONSTRUCTORS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _targetSizeRow(
                      'No args',
                      ts1.width,
                      ts1.height,
                      Color(0xFF616161),
                    ),
                    _targetSizeRow(
                      '200 x 300',
                      ts2.width,
                      ts2.height,
                      Color(0xFF1565C0),
                    ),
                    _targetSizeRow(
                      'w:150 only',
                      ts3.width,
                      ts3.height,
                      Color(0xFF00695C),
                    ),
                    _targetSizeRow(
                      'h:250 only',
                      ts4.width,
                      ts4.height,
                      Color(0xFF6A1B9A),
                    ),
                    _targetSizeRow(
                      '1080p',
                      ts5.width,
                      ts5.height,
                      Color(0xFFE65100),
                    ),
                    _targetSizeRow(
                      '4K',
                      ts6.width,
                      ts6.height,
                      Color(0xFFC62828),
                    ),
                    _targetSizeRow(
                      '64x64 icon',
                      ts7.width,
                      ts7.height,
                      Color(0xFF2E7D32),
                    ),
                    _targetSizeRow(
                      '1x1 pixel',
                      ts8.width,
                      ts8.height,
                      Color(0xFF00838F),
                    ),
                  ],
                ),
              ),

              // ── Demo 4: Visual Size Comparison ──
              _sectionTitle('4. VISUAL SIZE COMPARISON'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 240,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Stack(
                  children: [
                    // 4K (scaled to fit)
                    Positioned(
                      left: 10,
                      top: 10,
                      child: _sizeRect(
                        280,
                        157,
                        '4K (3840x2160)',
                        Color(0xFFC62828).withValues(alpha: 0.15),
                        Color(0xFFC62828),
                      ),
                    ),
                    // 1080p
                    Positioned(
                      left: 10,
                      top: 10,
                      child: _sizeRect(
                        140,
                        79,
                        '1080p',
                        Color(0xFF1565C0).withValues(alpha: 0.2),
                        Color(0xFF1565C0),
                      ),
                    ),
                    // 720p
                    Positioned(
                      left: 10,
                      top: 10,
                      child: _sizeRect(
                        93,
                        52,
                        '720p',
                        Color(0xFF2E7D32).withValues(alpha: 0.25),
                        Color(0xFF2E7D32),
                      ),
                    ),
                    // 480p
                    Positioned(
                      left: 10,
                      top: 10,
                      child: _sizeRect(
                        62,
                        35,
                        '480p',
                        Color(0xFFE65100).withValues(alpha: 0.3),
                        Color(0xFFE65100),
                      ),
                    ),
                    // Thumbnail
                    Positioned(
                      left: 10,
                      top: 10,
                      child: _sizeRect(
                        10,
                        10,
                        '',
                        Color(0xFF6A1B9A).withValues(alpha: 0.5),
                        Color(0xFF6A1B9A),
                      ),
                    ),
                    // Legend
                    Positioned(
                      left: 10,
                      top: 180,
                      child: Row(
                        children: [
                          _legendDot(Color(0xFFC62828), '4K'),
                          SizedBox(width: 12),
                          _legendDot(Color(0xFF1565C0), '1080p'),
                          SizedBox(width: 12),
                          _legendDot(Color(0xFF2E7D32), '720p'),
                          SizedBox(width: 12),
                          _legendDot(Color(0xFFE65100), '480p'),
                          SizedBox(width: 12),
                          _legendDot(Color(0xFF6A1B9A), 'Thumb'),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 210,
                      child: Text(
                        'Nested rectangles show proportional size differences',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 5: Aspect Ratios ──
              _sectionTitle('5. IMAGE ASPECT RATIOS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: ratios.entries.map((entry) {
                    final w = entry.value[0];
                    final h = entry.value[1];
                    final ratio = w / h;
                    return _aspectRatioRow(entry.key, w, h, ratio);
                  }).toList(),
                ),
              ),

              // ── Demo 6: Decode Pipeline ──
              _sectionTitle('6. IMAGE DECODE PIPELINE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _pipelineStep(
                      1,
                      'Load bytes',
                      'Read image data from asset/network',
                      Icons.download,
                      Color(0xFF1565C0),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      2,
                      'instantiateCodec',
                      'Create Codec from bytes + TargetImageSize',
                      Icons.build,
                      Color(0xFF6A1B9A),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      3,
                      'getNextFrame()',
                      'Decode frame → FrameInfo',
                      Icons.image,
                      Color(0xFF00695C),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      4,
                      'FrameInfo.image',
                      'Access decoded ui.Image',
                      Icons.photo,
                      Color(0xFFE65100),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      5,
                      'dispose()',
                      'Release Codec & Image resources',
                      Icons.delete_sweep,
                      Color(0xFFC62828),
                    ),
                  ],
                ),
              ),

              // ── Demo 7: Equality ──
              _sectionTitle('7. TARGETIMAGESIZE EQUALITY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _equalityRow('(100,100) == (100,100)', eqA == eqB, true),
                    SizedBox(height: 8),
                    _equalityRow('(100,100) == (100,200)', eqA == eqC, false),
                  ],
                ),
              ),

              // ── Demo 8: Common Presets ──
              _sectionTitle('8. COMMON IMAGE SIZE PRESETS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: presets.entries.map((entry) {
                    return _presetChip(
                      entry.key,
                      '${entry.value.width}x${entry.value.height}',
                    );
                  }).toList(),
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

Widget _apiItem(IconData icon, String name, String description, Color color) {
  return Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _frameInfoCard(
  String prop,
  String type,
  String desc,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Icon(icon, size: 32, color: color),
        SizedBox(height: 8),
        Text(
          prop,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: color,
          ),
        ),
        Text(type, style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
        SizedBox(height: 4),
        Text(
          desc,
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _targetSizeRow(String label, int? width, int? height, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 100,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text(
          'w=${width ?? "null"}, h=${height ?? "null"}',
          style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
        ),
        Spacer(),
        if (width != null && height != null)
          Container(
            width: (width / 30.0).clamp(4.0, 80.0),
            height: (height / 30.0).clamp(4.0, 40.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: color, width: 1),
            ),
          ),
      ],
    ),
  );
}

Widget _sizeRect(double w, double h, String label, Color fill, Color border) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      color: fill,
      border: Border.all(color: border, width: 1),
    ),
    child: label.isNotEmpty
        ? Padding(
            padding: EdgeInsets.all(2),
            child: Text(label, style: TextStyle(fontSize: 8, color: border)),
          )
        : null,
  );
}

Widget _legendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 10)),
    ],
  );
}

Widget _aspectRatioRow(String label, int w, int h, double ratio) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 60,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        Text(
          '${w}x$h',
          style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
        ),
        Spacer(),
        Container(
          width: (ratio * 30).clamp(20.0, 100.0),
          height: 30,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A148C), Color(0xFFAB47BC)],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              ratio.toStringAsFixed(2),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _pipelineStep(
  int step,
  String title,
  String desc,
  IconData icon,
  Color color,
) {
  return Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
      Icon(icon, color: color, size: 24),
    ],
  );
}

Widget _pipelineArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 16),
    child: Icon(Icons.arrow_downward, color: Colors.grey[400], size: 20),
  );
}

Widget _equalityRow(String label, bool result, bool expected) {
  return Row(
    children: [
      Icon(
        result == expected ? Icons.check_circle : Icons.cancel,
        color: result == expected ? Colors.green : Colors.red,
        size: 20,
      ),
      SizedBox(width: 8),
      Text(label, style: TextStyle(fontSize: 13, fontFamily: 'monospace')),
      Spacer(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: result ? Color(0xFFE8F5E9) : Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '$result',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: result ? Color(0xFF2E7D32) : Color(0xFFC62828),
          ),
        ),
      ),
    ],
  );
}

Widget _presetChip(String name, String size) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Color(0xFFE0E0E0)),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Text(
          size,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}
