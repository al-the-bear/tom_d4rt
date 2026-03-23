// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for Image & Codec APIs from dart:ui
// Covers: Image, instantiateImageCodec, decodeImageFromPixels, ImageByteFormat
// Image is the core class for decoded raster images in the engine
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Image & Codec Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: IMAGE CLASS OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════
  // ui.Image is abstract — obtained from codec decoding
  // Cannot be directly constructed; must decode from bytes, pixels, or codec

  print('Image type: ${ui.Image}');
  print('Image is abstract — no public constructor');
  print(
    'Obtain via: instantiateImageCodec, decodeImageFromPixels, Codec.getNextFrame',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: CREATING AN IMAGE FROM PIXELS
  // ═══════════════════════════════════════════════════════════════════════════

  // Create a simple 4x4 RGBA image from raw pixel data
  final width = 4;
  final height = 4;
  final pixels = Uint8List(width * height * 4); // RGBA
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      final offset = (y * width + x) * 4;
      pixels[offset] = (x * 64).clamp(0, 255); // R
      pixels[offset + 1] = (y * 64).clamp(0, 255); // G
      pixels[offset + 2] = 128; // B
      pixels[offset + 3] = 255; // A
    }
  }
  print('Created ${width}x${height} RGBA pixel buffer: ${pixels.length} bytes');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ImageByteFormat ENUM
  // ═══════════════════════════════════════════════════════════════════════════

  final formats = ui.ImageByteFormat.values;
  for (final f in formats) {
    print('ImageByteFormat.${f.name} (index=${f.index})');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: IMAGE PROPERTIES (conceptual)
  // ═══════════════════════════════════════════════════════════════════════════

  print('Image properties:');
  print('  width → pixel width');
  print('  height → pixel height');
  print('  toByteData(format) → Future<ByteData?>');
  print('  dispose() → release native resources');
  print('  clone() → create a copy');
  print('  isCloneOf(other) → check if cloned from same source');
  print('  colorSpace → image color space');
  print('  debugDisposed → check if disposed (debug only)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: CODEC LIFECYCLE
  // ═══════════════════════════════════════════════════════════════════════════

  print('Codec lifecycle:');
  print('  1. Load bytes (network, file, asset)');
  print('  2. instantiateImageCodec(data) → Codec');
  print('  3. Codec.frameCount, Codec.repetitionCount');
  print('  4. Codec.getNextFrame() → FrameInfo');
  print('  5. FrameInfo.image → Image');
  print('  6. Image.dispose() when done');

  print('Image & Codec demo complete');

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
                    colors: [Color(0xFFBF360C), Color(0xFFFF8A65)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withValues(alpha: 0.3),
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
                      'Image & Codec APIs',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Raster image decoding pipeline',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 1: Image Class ──
              _sectionTitle('1. IMAGE CLASS OVERVIEW'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _propRow(
                      'Type',
                      'Abstract class (no public constructor)',
                      Color(0xFFBF360C),
                    ),
                    _propRow('Source', 'dart:ui', Color(0xFF1565C0)),
                    _propRow(
                      'Purpose',
                      'Represents a decoded raster image in GPU memory',
                      Color(0xFF2E7D32),
                    ),
                    _propRow(
                      'Creation',
                      'Via Codec, decodeImageFromPixels, or Picture',
                      Color(0xFF6A1B9A),
                    ),
                    SizedBox(height: 12),
                    _infoBox(
                      'Image objects hold native GPU resources. Always call dispose() '
                      'when no longer needed to avoid memory leaks.',
                      Color(0xFFBF360C),
                    ),
                  ],
                ),
              ),

              // ── Section 2: Image Properties ──
              _sectionTitle('2. IMAGE PROPERTIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _apiEntry(
                      'width',
                      'int',
                      'Pixel width of the image',
                      Icons.straighten,
                    ),
                    _apiEntry(
                      'height',
                      'int',
                      'Pixel height of the image',
                      Icons.height,
                    ),
                    _apiEntry(
                      'colorSpace',
                      'ColorSpace',
                      'Image color space',
                      Icons.palette,
                    ),
                    _apiEntry(
                      'toByteData(format)',
                      'Future<ByteData?>',
                      'Export pixel data',
                      Icons.data_array,
                    ),
                    _apiEntry(
                      'dispose()',
                      'void',
                      'Release GPU resources',
                      Icons.delete,
                    ),
                    _apiEntry(
                      'clone()',
                      'Image',
                      'Create image copy',
                      Icons.copy,
                    ),
                    _apiEntry(
                      'isCloneOf(other)',
                      'bool',
                      'Check clone relationship',
                      Icons.compare,
                    ),
                  ],
                ),
              ),

              // ── Section 3: Pixel Data Visualization ──
              _sectionTitle('3. RAW PIXEL DATA (${width}x${height} RGBA)'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    // Show the 4x4 pixel grid as colored squares
                    ...List.generate(height, (y) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(width, (x) {
                            final offset = (y * width + x) * 4;
                            final color = Color.fromARGB(
                              pixels[offset + 3],
                              pixels[offset],
                              pixels[offset + 1],
                              pixels[offset + 2],
                            );
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Center(
                                child: Text(
                                  '${x},${y}',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black54,
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                    SizedBox(height: 12),
                    Text(
                      'R=x*64, G=y*64, B=128, A=255',
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 4: ImageByteFormat ──
              _sectionTitle('4. IMAGE BYTE FORMAT'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _formatRow(
                      'rawRgba',
                      'Raw RGBA pixels (4 bytes/pixel)',
                      Color(0xFFBF360C),
                      1.0,
                    ),
                    _formatRow(
                      'rawStraightRgba',
                      'Straight (non-premultiplied) RGBA',
                      Color(0xFF1565C0),
                      0.9,
                    ),
                    _formatRow(
                      'rawUnmodified',
                      'Raw pixels in native format',
                      Color(0xFF2E7D32),
                      0.85,
                    ),
                    _formatRow(
                      'png',
                      'Compressed PNG encoding',
                      Color(0xFF6A1B9A),
                      0.3,
                    ),
                  ],
                ),
              ),

              // ── Section 5: Decode Pipeline ──
              _sectionTitle('5. DECODE PIPELINE'),
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
                      'Load Bytes',
                      'rootBundle / http / file',
                      Icons.cloud_download,
                      Color(0xFF1565C0),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      2,
                      'Create Codec',
                      'instantiateImageCodec(data)',
                      Icons.code,
                      Color(0xFF6A1B9A),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      3,
                      'Get Frame',
                      'codec.getNextFrame()',
                      Icons.filter_frames,
                      Color(0xFF2E7D32),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      4,
                      'Access Image',
                      'frameInfo.image',
                      Icons.image,
                      Color(0xFFBF360C),
                    ),
                    _pipelineArrow(),
                    _pipelineStep(
                      5,
                      'Use & Dispose',
                      'canvas.drawImage() → image.dispose()',
                      Icons.delete_sweep,
                      Color(0xFF455A64),
                    ),
                  ],
                ),
              ),

              // ── Section 6: Alternative Decoding Paths ──
              _sectionTitle('6. ALTERNATIVE DECODING PATHS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _pathRow(
                      'instantiateImageCodec',
                      'Decode encoded image bytes (PNG, JPEG, etc.)',
                      Color(0xFF1565C0),
                    ),
                    _pathRow(
                      'decodeImageFromPixels',
                      'Create Image from raw RGBA pixel data',
                      Color(0xFF2E7D32),
                    ),
                    _pathRow(
                      'Picture.toImage',
                      'Rasterize a Picture to an Image',
                      Color(0xFF6A1B9A),
                    ),
                    _pathRow(
                      'ImageDescriptor',
                      'Advanced: manual codec with target size',
                      Color(0xFFBF360C),
                    ),
                    _pathRow(
                      'ImmutableBuffer',
                      'Zero-copy byte transfer from assets',
                      Color(0xFFE65100),
                    ),
                  ],
                ),
              ),

              // ── Section 7: Memory Lifecycle ──
              _sectionTitle('7. MEMORY LIFECYCLE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _lifecyclePhase(
                      'Allocated',
                      'Image decoded in GPU texture memory',
                      Color(0xFF2E7D32),
                      1.0,
                    ),
                    _lifecyclePhase(
                      'In Use',
                      'Referenced by widgets/canvas ops',
                      Color(0xFF1565C0),
                      0.75,
                    ),
                    _lifecyclePhase(
                      'Cloned',
                      'clone() shares GPU texture, ref-counted',
                      Color(0xFF6A1B9A),
                      0.5,
                    ),
                    _lifecyclePhase(
                      'Disposed',
                      'dispose() decrements ref count',
                      Color(0xFFE65100),
                      0.25,
                    ),
                    _lifecyclePhase(
                      'Freed',
                      'Last ref disposed → GPU memory freed',
                      Color(0xFFC62828),
                      0.0,
                    ),
                    SizedBox(height: 12),
                    _infoBox(
                      'Always dispose images when done. Failing to dispose causes '
                      'GPU memory leaks that can crash large apps.',
                      Color(0xFFC62828),
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

Widget _propRow(String label, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(child: Text(value, style: TextStyle(fontSize: 12))),
      ],
    ),
  );
}

Widget _infoBox(String text, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(Icons.warning_amber, color: color, size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 11, color: color)),
        ),
      ],
    ),
  );
}

Widget _apiEntry(String name, String type, String desc, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFFBF360C), size: 18),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    '→ $type',
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),
                ],
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _formatRow(String name, String desc, Color color, double sizeRatio) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: color,
              ),
            ),
            Spacer(),
            Text(desc, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
          ],
        ),
        SizedBox(height: 4),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            widthFactor: sizeRatio,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
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
  String label,
  String desc,
  IconData icon,
  Color color,
) {
  return Row(
    children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
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
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Text(
              desc,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      Icon(icon, color: color, size: 20),
    ],
  );
}

Widget _pipelineArrow() {
  return Padding(
    padding: EdgeInsets.only(left: 12),
    child: Icon(Icons.arrow_downward, color: Colors.grey[400], size: 16),
  );
}

Widget _pathRow(String name, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _lifecyclePhase(String phase, String desc, Color color, double bar) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            phase,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 14,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(7),
            ),
            child: FractionallySizedBox(
              widthFactor: bar.clamp(0.05, 1.0),
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 140,
          child: Text(
            desc,
            style: TextStyle(fontSize: 9, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}
