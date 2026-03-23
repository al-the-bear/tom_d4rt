// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for PixelFormat from dart:ui
// PixelFormat defines the byte layout of pixel data in images
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== PixelFormat Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: PixelFormat Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('PixelFormat defines pixel byte layout in images');
  print('All values: ${PixelFormat.values}');
  print('Count: ${PixelFormat.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Values
  // ═══════════════════════════════════════════════════════════════════════════

  for (final fmt in PixelFormat.values) {
    print('${fmt.name}: index=${fmt.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Understanding Formats
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Pixel Formats ---');
  print('rgba8888: 8 bits per channel, RGBA order');
  print('bgra8888: 8 bits per channel, BGRA order');

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
              // Header
              _buildHeader(),
              SizedBox(height: 16),

              // Section 1: Overview
              _buildSectionCard(
                'PixelFormat Overview',
                Icons.image,
                Colors.deepPurple,
                [
                  'Defines byte order of pixel color channels',
                  'Used when decoding/encoding raw image data',
                  '8 bits (1 byte) per color channel = 32 bits per pixel',
                  'Values: ${PixelFormat.values.length} supported formats',
                ],
              ),
              SizedBox(height: 16),

              // Section 2: All Formats
              _buildSectionHeader('PIXEL FORMAT VALUES'),
              _buildAllFormatsDemo(),
              SizedBox(height: 16),

              // Section 3: Byte Order
              _buildSectionHeader('BYTE ORDER VISUALIZATION'),
              _buildByteOrderDemo(),
              SizedBox(height: 16),

              // Section 4: RGBA8888 Details
              _buildSectionHeader('RGBA8888 FORMAT'),
              _buildRgbaDemo(),
              SizedBox(height: 16),

              // Section 5: BGRA8888 Details
              _buildSectionHeader('BGRA8888 FORMAT'),
              _buildBgraDemo(),
              SizedBox(height: 16),

              // Section 6: Color Decomposition
              _buildSectionHeader('COLOR DECOMPOSITION'),
              _buildColorDecompositionDemo(),
              SizedBox(height: 16),

              // Section 7: Platform Usage
              _buildSectionHeader('PLATFORM CONSIDERATIONS'),
              _buildPlatformDemo(),
              SizedBox(height: 16),

              // Section 8: Image.memory Usage
              _buildSectionHeader('IMAGE.MEMORY USAGE'),
              _buildImageMemoryDemo(),
              SizedBox(height: 16),

              // Section 9: Common Use Cases
              _buildSectionHeader('COMMON USE CASES'),
              _buildUseCasesDemo(),
              SizedBox(height: 16),

              // Section 10: Format Comparison
              _buildSectionHeader('FORMAT COMPARISON'),
              _buildComparisonTable(),
              SizedBox(height: 32),

              // Footer
              _buildFooter(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildHeader() {
  return Container(
    margin: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF673AB7), Color(0xFF9575CD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF673AB7).withValues(alpha: 0.3),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: EdgeInsets.all(24),
    child: Column(
      children: [
        Icon(Icons.image, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          'PixelFormat',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Image Pixel Data Layout',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'dart:ui Enum • ${PixelFormat.values.length} Formats',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
        letterSpacing: 1.2,
      ),
    ),
  );
}

Widget _buildSectionCard(
  String title,
  IconData icon,
  Color color,
  List<String> points,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: points
                .map(
                  (point) => Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            point,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAllFormatsDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        for (final fmt in PixelFormat.values) ...[
          _buildFormatRow(fmt),
          if (fmt != PixelFormat.values.last) SizedBox(height: 12),
        ],
      ],
    ),
  );
}

Widget _buildFormatRow(PixelFormat format) {
  final colors = {
    PixelFormat.rgba8888: Colors.blue,
    PixelFormat.bgra8888: Colors.orange,
  };
  final color = colors[format] ?? Colors.grey;

  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Container(
          width: 100,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            format.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text('32-bit ARGB format', style: TextStyle(fontSize: 14)),
        ),
        Text(
          'idx: ${format.index}',
          style: TextStyle(fontSize: 10, color: Colors.grey[500]),
        ),
      ],
    ),
  );
}

Widget _buildByteOrderDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Byte order in memory for one pixel:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        _buildByteOrderRow(
          'RGBA8888',
          ['R', 'G', 'B', 'A'],
          [Colors.red, Colors.green, Colors.blue, Colors.grey],
        ),
        SizedBox(height: 16),
        _buildByteOrderRow(
          'BGRA8888',
          ['B', 'G', 'R', 'A'],
          [Colors.blue, Colors.green, Colors.red, Colors.grey],
        ),
      ],
    ),
  );
}

Widget _buildByteOrderRow(
  String label,
  List<String> channels,
  List<Color> colors,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      SizedBox(height: 8),
      Row(
        children: [
          for (int i = 0; i < channels.length; i++) ...[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors[i].withValues(alpha: 0.2),
                  border: Border.all(color: colors[i]),
                  borderRadius: i == 0
                      ? BorderRadius.horizontal(left: Radius.circular(8))
                      : i == 3
                      ? BorderRadius.horizontal(right: Radius.circular(8))
                      : null,
                ),
                child: Column(
                  children: [
                    Text(
                      channels[i],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colors[i],
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'byte $i',
                      style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    ],
  );
}

Widget _buildRgbaDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'RGBA8888',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'PixelFormat.rgba8888',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Memory layout:',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              SizedBox(height: 8),
              Text(
                '[Red][Green][Blue][Alpha]',
                style: TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                ' 0xFF  0x00   0x00  0xFF  = Opaque Red',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          '• Standard format for most image APIs',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          '• Direct mapping to Color.value in most cases',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          '• Used by PNG, WebGL, and most web formats',
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}

Widget _buildBgraDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'BGRA8888',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'PixelFormat.bgra8888',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Memory layout:',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              SizedBox(height: 8),
              Text(
                '[Blue][Green][Red][Alpha]',
                style: TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                ' 0x00  0x00   0xFF  0xFF  = Opaque Red',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          '• Used on Windows (GDI+, Direct2D)',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          '• Native format for macOS/iOS (Core Graphics)',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          '• Common in video processing pipelines',
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}

Widget _buildColorDecompositionDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        _buildColorDecompRow('Red', Color(0xFFFF0000), 0xFF, 0x00, 0x00, 0xFF),
        SizedBox(height: 12),
        _buildColorDecompRow(
          'Green',
          Color(0xFF00FF00),
          0x00,
          0xFF,
          0x00,
          0xFF,
        ),
        SizedBox(height: 12),
        _buildColorDecompRow('Blue', Color(0xFF0000FF), 0x00, 0x00, 0xFF, 0xFF),
        SizedBox(height: 12),
        _buildColorDecompRow(
          'Yellow',
          Color(0xFFFFFF00),
          0xFF,
          0xFF,
          0x00,
          0xFF,
        ),
      ],
    ),
  );
}

Widget _buildColorDecompRow(
  String name,
  Color color,
  int r,
  int g,
  int b,
  int a,
) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
      ),
      SizedBox(width: 12),
      SizedBox(
        width: 60,
        child: Text(name, style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      Expanded(
        child: Text(
          'R:${r.toRadixString(16).padLeft(2, '0').toUpperCase()} '
          'G:${g.toRadixString(16).padLeft(2, '0').toUpperCase()} '
          'B:${b.toRadixString(16).padLeft(2, '0').toUpperCase()} '
          'A:${a.toRadixString(16).padLeft(2, '0').toUpperCase()}',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
      ),
    ],
  );
}

Widget _buildPlatformDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        _buildPlatformRow('Windows', 'BGRA8888', Colors.blue),
        SizedBox(height: 8),
        _buildPlatformRow('macOS/iOS', 'BGRA8888', Colors.grey),
        SizedBox(height: 8),
        _buildPlatformRow('Linux', 'RGBA8888', Colors.orange),
        SizedBox(height: 8),
        _buildPlatformRow('Web/WebGL', 'RGBA8888', Colors.blue),
        SizedBox(height: 8),
        _buildPlatformRow('Android', 'RGBA8888', Colors.green),
      ],
    ),
  );
}

Widget _buildPlatformRow(String platform, String format, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(platform, style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: format == 'RGBA8888' ? Colors.blue : Colors.orange,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            format,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildImageMemoryDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Creating images from raw pixel data:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'ui.decodeImageFromPixels(\n'
            '  pixels,          // Uint8List\n'
            '  width, height,   // dimensions\n'
            '  PixelFormat.rgba8888,  // format\n'
            '  callback,        // image callback\n'
            ');',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Specify the correct format matching your pixel data byte order.',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCasesDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        _buildUseCaseCard(
          'Raw Image Processing',
          'Manual pixel manipulation with correct byte order',
          Icons.edit,
          Colors.purple,
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'Platform Interop',
          'Converting between native graphics formats',
          Icons.swap_horiz,
          Colors.teal,
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'Video Frame Processing',
          'Handling video frame data from codecs',
          Icons.videocam,
          Colors.red,
        ),
      ],
    ),
  );
}

Widget _buildUseCaseCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
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
    ),
  );
}

Widget _buildComparisonTable() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Format',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Byte Order',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Bits/Pixel',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
        _buildTableRow('rgba8888', 'R-G-B-A', '32'),
        _buildTableRow('bgra8888', 'B-G-R-A', '32'),
      ],
    ),
  );
}

Widget _buildTableRow(String format, String order, String bits) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            format,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            order,
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ),
        Expanded(flex: 2, child: Text(bits, style: TextStyle(fontSize: 11))),
      ],
    ),
  );
}

Widget _buildFooter() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'PixelFormat Summary',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          '${PixelFormat.values.length} formats for raw pixel data. rgba8888 is standard for most platforms, '
          'bgra8888 for Windows/macOS. Always specify the correct format when decoding pixel data.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ],
    ),
  );
}
