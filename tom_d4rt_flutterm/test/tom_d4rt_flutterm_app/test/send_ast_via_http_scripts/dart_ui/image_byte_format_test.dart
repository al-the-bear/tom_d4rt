// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for ImageByteFormat from dart:ui
// ImageByteFormat describes the format of bytes when converting images
import 'dart:ui';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// GLOBAL HELPER FUNCTIONS (declared before build)
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildHeader() {
  return Container(
    margin: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade700, Colors.teal.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        const Icon(Icons.image_outlined, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        const Text(
          'ImageByteFormat',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Image Byte Formats from dart:ui',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Controlling pixel data serialization',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
            letterSpacing: 1.0,
          ),
        ),
      ],
    ),
  );
}

Widget _buildOverviewCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.cyan.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.cyan, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'ImageByteFormat Overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulletPoint('Used with Image.toByteData() method'),
              _buildBulletPoint('Controls how pixel data is serialized'),
              _buildBulletPoint('Affects alpha channel handling'),
              _buildBulletPoint('Choose format based on use case'),
              _buildBulletPoint('PNG is compressed; raw formats are not'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Colors.cyan,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFormatCard(
  ImageByteFormat format,
  IconData icon,
  Color color,
  String description,
  List<String> traits,
  String? alphaNote,
) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ImageByteFormat.${format.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Index: ${format.index}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Content
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              if (alphaNote != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        size: 16,
                        color: Colors.amber.shade700,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          alphaNote,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.amber.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withValues(alpha: 0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 14,
                          color: color,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Characteristics',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...traits.map(
                      (t) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(color: color, fontSize: 12),
                            ),
                            Expanded(
                              child: Text(
                                t,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildQuickRefGrid() {
  final items = [
    (
      ImageByteFormat.rawRgba,
      Icons.grid_view,
      Colors.blue,
      'rawRgba',
      'Premultiplied',
    ),
    (
      ImageByteFormat.rawStraightRgba,
      Icons.view_module,
      Colors.green,
      'rawStraight',
      'Straight Alpha',
    ),
    (
      ImageByteFormat.rawUnmodified,
      Icons.raw_on,
      Colors.orange,
      'rawUnmod',
      'Original',
    ),
    (
      ImageByteFormat.png,
      Icons.photo_library,
      Colors.purple,
      'png',
      'Compressed',
    ),
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All Formats at a Glance',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${ImageByteFormat.values.length} image byte formats available',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: items
              .map(
                (item) => Container(
                  width: 80,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item.$3.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: item.$3.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(item.$2, color: item.$3, size: 28),
                      const SizedBox(height: 8),
                      Text(
                        item.$4,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: item.$3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.$5,
                        style: TextStyle(
                          fontSize: 8,
                          color: item.$3.withValues(alpha: 0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

Widget _buildAlphaExplanation() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Understanding Alpha Premultiplication',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'How transparency affects RGB values',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
        const SizedBox(height: 20),
        _buildAlphaRow(
          'Straight (Original)',
          'R=255, G=128, B=0, A=128',
          Colors.green,
        ),
        const SizedBox(height: 8),
        const Center(
          child: Icon(Icons.arrow_downward, color: Colors.white54, size: 20),
        ),
        const SizedBox(height: 8),
        _buildAlphaRow('Premultiplied', 'R=128, G=64, B=0, A=128', Colors.blue),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Premultiplication Formula:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade300,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'R′ = R × (A / 255)\nG′ = G × (A / 255)\nB′ = B × (A / 255)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.lightGreenAccent,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Premultiplied alpha is computationally efficient for compositing '
          'but loses precision. Straight alpha preserves original RGB values.',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
        ),
      ],
    ),
  );
}

Widget _buildAlphaRow(String label, String values, Color color) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Text(
                values,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSizeComparison() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size Comparison (100×100 image)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildSizeBar('rawRgba', 40000, 40000, Colors.blue, 'Uncompressed'),
        const SizedBox(height: 8),
        _buildSizeBar(
          'rawStraightRgba',
          40000,
          40000,
          Colors.green,
          'Uncompressed',
        ),
        const SizedBox(height: 8),
        _buildSizeBar(
          'rawUnmodified',
          40000,
          40000,
          Colors.orange,
          'Uncompressed',
        ),
        const SizedBox(height: 8),
        _buildSizeBar(
          'png',
          2000,
          40000,
          Colors.purple,
          'Compressed (~95% less)',
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.calculate, size: 16, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Raw formats: width × height × 4 bytes (RGBA)\nPNG: Varies based on image content',
                  style: TextStyle(fontSize: 11, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSizeBar(
  String format,
  int size,
  int maxSize,
  Color color,
  String note,
) {
  final percentage = (size / maxSize * 100).toInt();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              format,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '${(size / 1000).toStringAsFixed(1)} KB',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Row(
        children: [
          Expanded(
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$percentage%',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
          ),
        ],
      ),
      const SizedBox(height: 2),
      Text(note, style: TextStyle(fontSize: 9, color: Colors.grey.shade500)),
    ],
  );
}

Widget _buildCodeExamples() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Code Examples',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Get raw RGBA bytes',
          '''Future<Uint8List?> getRawBytes(Image image) async {
  final ByteData? data = await image.toByteData(
    format: ImageByteFormat.rawRgba,
  );
  return data?.buffer.asUint8List();
}''',
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Export as PNG',
          '''Future<Uint8List?> exportPng(Image image) async {
  final ByteData? data = await image.toByteData(
    format: ImageByteFormat.png,
  );
  return data?.buffer.asUint8List();
}''',
        ),
        const SizedBox(height: 16),
        _buildCodeBlock(
          'Choose format based on use',
          '''ImageByteFormat chooseFormat(bool needsCompression, bool editPixels) {
  if (needsCompression) {
    return ImageByteFormat.png;
  }
  if (editPixels) {
    // Straight alpha preserves RGB values
    return ImageByteFormat.rawStraightRgba;
  }
  // Default for display/compositing
  return ImageByteFormat.rawRgba;
}''',
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String title, String code) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: Colors.lightGreenAccent,
          ),
        ),
      ),
    ],
  );
}

Widget _buildUseCases() {
  final cases = [
    (
      Icons.save,
      Colors.blue,
      'File Export',
      'Use PNG for saving images to files with compression',
    ),
    (
      Icons.edit,
      Colors.green,
      'Pixel Editing',
      'Use rawStraightRgba to preserve original colors during editing',
    ),
    (
      Icons.share,
      Colors.purple,
      'Inter-process',
      'Use rawUnmodified when passing to other systems',
    ),
    (
      Icons.layers,
      Colors.orange,
      'Compositing',
      'Use rawRgba for efficient layer blending',
    ),
    (
      Icons.memory,
      Colors.teal,
      'Low Memory',
      'Use PNG to reduce memory usage for cached images',
    ),
    (
      Icons.speed,
      Colors.pink,
      'Fast Access',
      'Use raw formats when decoding speed matters',
    ),
  ];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Use Cases',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...cases.map(
          (c) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: c.$2.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(c.$1, color: c.$2, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.$3,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        c.$4,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonTable() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Format Comparison',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1.5),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          border: TableBorder.all(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Format',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Compressed',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Alpha',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Lossless',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  ),
                ),
              ],
            ),
            _buildCompareRow('rawRgba', 'No', 'Premultiplied', 'Yes'),
            _buildCompareRow('rawStraightRgba', 'No', 'Straight', 'Yes'),
            _buildCompareRow('rawUnmodified', 'No', 'Original', 'Yes'),
            _buildCompareRow('png', 'Yes', 'Straight', 'Yes'),
          ],
        ),
      ],
    ),
  );
}

TableRow _buildCompareRow(
  String format,
  String compressed,
  String alpha,
  String lossless,
) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          format,
          style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          compressed,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          alpha,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          lossless,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
      ),
    ],
  );
}

Widget _buildWarningNote() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.orange.shade700),
            const SizedBox(width: 8),
            Text(
              'Important Considerations',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildWarningItem(
          'toByteData() is asynchronous - always await the result',
        ),
        _buildWarningItem('Raw formats produce larger files but decode faster'),
        _buildWarningItem('PNG compression takes time for large images'),
        _buildWarningItem('rawUnmodified depends on backend implementation'),
      ],
    ),
  );
}

Widget _buildWarningItem(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('• ', style: TextStyle(color: Colors.orange.shade700)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.orange.shade800),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryStats() {
  return Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade400, Colors.teal.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Total', '${ImageByteFormat.values.length}'),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('Compressed', '1'),
        Container(width: 1, height: 40, color: Colors.white24),
        _buildStatItem('Raw', '3'),
      ],
    ),
  );
}

Widget _buildStatItem(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: Colors.white.withValues(alpha: 0.8),
        ),
      ),
    ],
  );
}

Widget _buildFooter() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'ImageByteFormat Deep Demo Complete',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Demonstrating ${ImageByteFormat.values.length} image byte formats',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== ImageByteFormat Deep Demo ===');

  // Log all values
  print('ImageByteFormat controls how images serialize to bytes');
  print('All values: ${ImageByteFormat.values}');
  print('Count: ${ImageByteFormat.values.length}');

  for (final f in ImageByteFormat.values) {
    print('${f.name}: index=${f.index}');
  }

  print('\n--- Format Details ---');
  print('rawRgba: Premultiplied alpha, 4 bytes/pixel');
  print('rawStraightRgba: Straight alpha, 4 bytes/pixel');
  print('rawUnmodified: Backend-dependent format');
  print('png: Compressed PNG format');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: 16),

              // Overview
              _buildOverviewCard(),
              const SizedBox(height: 16),

              // Quick reference
              _buildSectionHeader('QUICK REFERENCE'),
              _buildQuickRefGrid(),
              const SizedBox(height: 16),

              // Summary stats
              _buildSummaryStats(),
              const SizedBox(height: 16),

              // All formats
              _buildSectionHeader('FORMAT DETAILS'),

              _buildFormatCard(
                ImageByteFormat.rawRgba,
                Icons.grid_view,
                Colors.blue,
                'Raw RGBA data with premultiplied alpha. Each pixel is 4 bytes (R, G, B, A). RGB values are multiplied by alpha for efficient compositing.',
                [
                  '4 bytes per pixel (RGBA)',
                  'Premultiplied alpha for fast blending',
                  'Most common for display/rendering',
                  'Size = width × height × 4 bytes',
                ],
                'RGB values are scaled by alpha, so information is lost for semi-transparent pixels.',
              ),

              _buildFormatCard(
                ImageByteFormat.rawStraightRgba,
                Icons.view_module,
                Colors.green,
                'Raw RGBA data with straight (non-premultiplied) alpha. RGB values are preserved exactly as stored, independent of alpha value.',
                [
                  '4 bytes per pixel (RGBA)',
                  'Original RGB values preserved',
                  'Ideal for image editing',
                  'Requires more computation for blending',
                ],
                'Use when you need to preserve or modify original pixel colors.',
              ),

              _buildFormatCard(
                ImageByteFormat.rawUnmodified,
                Icons.raw_on,
                Colors.orange,
                'Raw pixel data in the original format used by the rendering backend. Format may vary between platforms and implementations.',
                [
                  'Backend-dependent format',
                  'No conversion overhead',
                  'May be different per platform',
                  'Use when interfacing with native code',
                ],
                'Platform-specific: verify format on each target platform.',
              ),

              _buildFormatCard(
                ImageByteFormat.png,
                Icons.photo_library,
                Colors.purple,
                'PNG encoded image data. Lossless compression that significantly reduces file size while maintaining quality.',
                [
                  'Lossless compression',
                  'Significant size reduction',
                  'Wide format compatibility',
                  'Higher encoding/decoding time',
                ],
                'Best for saving images to files or network transfer.',
              ),

              const SizedBox(height: 16),

              // Alpha explanation
              _buildSectionHeader('ALPHA PREMULTIPLICATION'),
              _buildAlphaExplanation(),
              const SizedBox(height: 16),

              // Size comparison
              _buildSectionHeader('SIZE COMPARISON'),
              _buildSizeComparison(),
              const SizedBox(height: 16),

              // Comparison table
              _buildSectionHeader('FORMAT COMPARISON'),
              _buildComparisonTable(),
              const SizedBox(height: 16),

              // Use cases
              _buildSectionHeader('USE CASES'),
              _buildUseCases(),
              const SizedBox(height: 16),

              // Code examples
              _buildSectionHeader('CODE EXAMPLES'),
              _buildCodeExamples(),
              const SizedBox(height: 16),

              // Warning note
              _buildSectionHeader('CONSIDERATIONS'),
              _buildWarningNote(),
              const SizedBox(height: 16),

              // Footer
              _buildFooter(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
