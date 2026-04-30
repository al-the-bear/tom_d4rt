// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Comprehensive visual demonstration of TargetPixelFormat from dart_ui
// This enum specifies the target pixel format when decoding images, allowing control
// over precision and memory usage for decoded image data.
import 'dart:ui';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS - Must be declared before build() for D4rt compatibility
// ═══════════════════════════════════════════════════════════════════════════════

/// Builds the main header section explaining TargetPixelFormat
Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade700, Colors.deepOrange.shade500],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TargetPixelFormat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'dart:ui enum • 3 values',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Specifies the target pixel format for image decoding. Controls the '
            'precision and memory layout of decoded image data. Used with '
            'ImageDescriptor and instantiateCodec for advanced image processing.',
            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

/// Builds a card displaying information about a pixel format value
Widget _buildFormatCard(
  TargetPixelFormat format,
  Color color,
  String description,
  IconData icon,
  String bitsPerPixel,
  String components,
  String memoryImpact,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with icon and name
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TargetPixelFormat.${format.name}',
                      style: TextStyle(
                        color: color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Index: ${format.index}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Description and details
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              // Technical details
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem('Bits/Pixel', bitsPerPixel, color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDetailItem('Components', components, color),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildDetailItem('Memory', memoryImpact, color),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a detail item
Widget _buildDetailItem(String label, String value, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

/// Builds memory layout visualization
Widget _buildMemoryLayout() {
  return Container(
    padding: const EdgeInsets.all(16),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.memory, color: Colors.blue.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Memory Layout Comparison',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // rgbaFloat32 layout
        _buildLayoutRow('rgbaFloat32', Colors.purple, [
          'R',
          'G',
          'B',
          'A',
        ], '128 bits = 16 bytes per pixel'),
        const SizedBox(height: 16),

        // rFloat32 layout
        _buildLayoutRow('rFloat32', Colors.green, [
          'R',
        ], '32 bits = 4 bytes per pixel'),
        const SizedBox(height: 16),

        // Standard RGBA8 comparison
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Standard RGBA8 (comparison)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildByteBox('R', Colors.grey, '8'),
                  _buildByteBox('G', Colors.grey, '8'),
                  _buildByteBox('B', Colors.grey, '8'),
                  _buildByteBox('A', Colors.grey, '8'),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '32 bits = 4 bytes per pixel (8-bit per channel)',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a layout visualization row
Widget _buildLayoutRow(
  String format,
  Color color,
  List<String> channels,
  String description,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        format,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
          fontFamily: 'monospace',
          fontSize: 13,
        ),
      ),
      const SizedBox(height: 8),
      Row(
        children: channels.map((c) => _buildByteBox(c, color, '32')).toList(),
      ),
      const SizedBox(height: 4),
      Text(
        description,
        style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
      ),
    ],
  );
}

/// Builds a byte box visualization
Widget _buildByteBox(String label, Color color, String bits) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            '${bits}b',
            style: TextStyle(color: color.withValues(alpha: 0.7), fontSize: 10),
          ),
        ],
      ),
    ),
  );
}

/// Builds use case section
Widget _buildUseCases() {
  return Container(
    padding: const EdgeInsets.all(16),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'When to Use Each Format',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildUseCaseCard(
          'dontCare',
          'General purpose images, UI graphics, photos',
          'Let the engine choose the optimal format based on the source image',
          Icons.auto_mode,
          Colors.grey,
        ),
        const SizedBox(height: 10),
        _buildUseCaseCard(
          'rgbaFloat32',
          'HDR content, scientific imaging, color grading',
          'When you need full 32-bit float precision per color channel',
          Icons.hd,
          Colors.purple,
        ),
        const SizedBox(height: 10),
        _buildUseCaseCard(
          'rFloat32',
          'Height maps, depth buffers, single-channel data',
          'Grayscale or single-channel data requiring float precision',
          Icons.gradient,
          Colors.green,
        ),
      ],
    ),
  );
}

/// Builds a use case card
Widget _buildUseCaseCard(
  String format,
  String useCase,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                format,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                useCase,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds precision comparison section
Widget _buildPrecisionComparison() {
  return Container(
    padding: const EdgeInsets.all(16),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.precision_manufacturing,
              color: Colors.cyan.shade700,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Precision & Range',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Table
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyan.shade200),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade700,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(7),
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(flex: 2, child: _HeaderCell('Format')),
                    Expanded(flex: 2, child: _HeaderCell('Value Range')),
                    Expanded(flex: 3, child: _HeaderCell('Advantages')),
                  ],
                ),
              ),
              _buildPrecisionRow(
                '8-bit (std)',
                '0 - 255',
                '256 levels, compact',
                0,
              ),
              _buildPrecisionRow('Float32', '±3.4×10³⁸', 'HDR, no banding', 1),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.cyan.shade700, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Float32 provides ~7 digits of precision, enabling smooth '
                  'gradients and HDR without color banding.',
                  style: TextStyle(color: Colors.cyan.shade800, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a precision comparison row
Widget _buildPrecisionRow(
  String format,
  String range,
  String advantages,
  int index,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: index % 2 == 0 ? Colors.cyan.shade50 : Colors.white,
      border: Border(bottom: BorderSide(color: Colors.cyan.shade100)),
      borderRadius: index == 1
          ? const BorderRadius.vertical(bottom: Radius.circular(7))
          : null,
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            format,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade700,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            range,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            advantages,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

/// Builds memory usage comparison
Widget _buildMemoryComparison() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.memory, color: Colors.red.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'Memory Usage (1920×1080 Image)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildMemoryBar('RGBA8 (standard)', 8.3, Colors.grey, '~8.3 MB'),
        const SizedBox(height: 10),
        _buildMemoryBar('rgbaFloat32', 33.2, Colors.purple, '~33.2 MB'),
        const SizedBox(height: 10),
        _buildMemoryBar('rFloat32', 8.3, Colors.green, '~8.3 MB'),
        const SizedBox(height: 12),
        Text(
          '⚠️ Float32 formats use 4× more memory per channel than standard 8-bit.',
          style: TextStyle(
            color: Colors.red.shade700,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

/// Builds a memory bar
Widget _buildMemoryBar(String label, double mb, Color color, String size) {
  final maxMb = 35.0;
  final width = (mb / maxMb).clamp(0.0, 1.0);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            size,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: FractionallySizedBox(
          widthFactor: width,
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    ],
  );
}

/// Builds API documentation section
Widget _buildApiSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.blueGrey.shade700, size: 20),
            const SizedBox(width: 8),
            Text(
              'API Reference',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildApiRow('Library', 'dart:ui'),
        _buildApiRow('Type', 'enum'),
        _buildApiRow('Values', 'dontCare, rgbaFloat32, rFloat32'),
        _buildApiRow('Properties', '.name, .index'),
        _buildApiRow('Usage', 'ImageDescriptor, instantiateCodec'),
      ],
    ),
  );
}

/// Builds an API documentation row
Widget _buildApiRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.blueGrey.shade600,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.blueGrey.shade800,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

/// Table header cell widget
class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== TargetPixelFormat Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ENUMERATE ALL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final values = TargetPixelFormat.values;
  print('Total values: ${values.length}');

  for (final v in values) {
    print('TargetPixelFormat.${v.name}: index=${v.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: INDIVIDUAL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final dontCare = TargetPixelFormat.dontCare;
  final rgbaFloat32 = TargetPixelFormat.rgbaFloat32;
  final rFloat32 = TargetPixelFormat.rFloat32;

  print('dontCare: $dontCare, index=${dontCare.index}');
  print('rgbaFloat32: $rgbaFloat32, index=${rgbaFloat32.index}');
  print('rFloat32: $rFloat32, index=${rFloat32.index}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: COMPARISONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('dontCare == dontCare: ${dontCare == TargetPixelFormat.dontCare}');
  print('dontCare == rgbaFloat32: ${dontCare == rgbaFloat32}');
  print(
    'dontCare.hashCode == dontCare.hashCode: ${dontCare.hashCode == TargetPixelFormat.dontCare.hashCode}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: INDEX-BASED ACCESS
  // ═══════════════════════════════════════════════════════════════════════════

  for (var i = 0; i < values.length; i++) {
    print('values[$i]: ${values[i].name}');
  }

  print('First: ${values.first}');
  print('Last: ${values.last}');

  print('=== TargetPixelFormat Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepOrange, fontFamily: 'Roboto'),
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('TargetPixelFormat'),
        backgroundColor: Colors.deepOrange.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),

            // Value cards
            const Text(
              'Pixel Format Values',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFormatCard(
              dontCare,
              Colors.grey,
              'Let the engine decide the best pixel format based on the source image. '
                  'This is the default and most flexible option for general use cases.',
              Icons.auto_mode,
              'Varies',
              'Auto-detected',
              'Optimized by engine',
            ),
            _buildFormatCard(
              rgbaFloat32,
              Colors.purple,
              'Each pixel uses 128 bits total, with 32-bit floats for each RGBA channel. '
                  'Provides maximum precision for HDR content and advanced image processing.',
              Icons.hd,
              '128 bits',
              'R, G, B, A (32-bit each)',
              '4× standard RGBA8',
            ),
            _buildFormatCard(
              rFloat32,
              Colors.green,
              'Each pixel is a single 32-bit float representing the red channel only. '
                  'Ideal for grayscale data, height maps, and single-channel processing.',
              Icons.gradient,
              '32 bits',
              'R only (32-bit float)',
              '1× per pixel (grayscale)',
            ),
            const SizedBox(height: 16),

            _buildMemoryLayout(),
            const SizedBox(height: 16),

            _buildUseCases(),
            const SizedBox(height: 16),

            _buildPrecisionComparison(),
            const SizedBox(height: 16),

            _buildMemoryComparison(),
            const SizedBox(height: 16),

            _buildApiSection(),
            const SizedBox(height: 20),

            // Summary footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepOrange.shade200),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.image,
                    color: Colors.deepOrange.shade700,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'TargetPixelFormat controls image decoding precision. Use dontCare '
                    'for most cases, rgbaFloat32 for HDR/scientific imaging, and '
                    'rFloat32 for grayscale/single-channel data.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepOrange.shade700,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
