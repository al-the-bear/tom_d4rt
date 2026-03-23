// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for TargetImageSize from dart:ui
// TargetImageSize specifies desired dimensions when decoding images
// It allows constraining the decoded size for memory efficiency
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS - Global scope for D4rt compatibility
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        const Icon(
          Icons.photo_size_select_large,
          size: 48,
          color: Colors.white,
        ),
        const SizedBox(height: 12),
        const Text(
          'TargetImageSize',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Image Decoding Size Control from dart:ui',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSizeVisualization(
  String label,
  ui.TargetImageSize size,
  Color color, {
  String? description,
}) {
  final hasWidth = size.width != null;
  final hasHeight = size.height != null;

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'width: ${hasWidth ? size.width : "null"}, height: ${hasHeight ? size.height : "null"}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
        if (description != null) ...[
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
        const SizedBox(height: 12),
        // Visual representation
        Center(
          child: Container(
            width: (hasWidth ? (size.width! / 10).clamp(40.0, 150.0) : 100),
            height: (hasHeight ? (size.height! / 10).clamp(30.0, 100.0) : 60),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.6),
                  color.withValues(alpha: 0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color, width: 2),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    hasWidth && hasHeight
                        ? Icons.check_box
                        : hasWidth
                        ? Icons.swap_horiz
                        : hasHeight
                        ? Icons.swap_vert
                        : Icons.crop_free,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasWidth && hasHeight
                        ? 'Fixed'
                        : hasWidth
                        ? 'W only'
                        : hasHeight
                        ? 'H only'
                        : 'Free',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildConstructorPatterns() {
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
            Icon(Icons.build_circle, color: Colors.blue.shade700),
            const SizedBox(width: 8),
            const Text(
              'Constructor Patterns',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        _buildCodeBlock('// Default - no constraints\nTargetImageSize()'),
        const SizedBox(height: 8),
        _buildCodeBlock(
          '// Fixed size\nTargetImageSize(width: 200, height: 300)',
        ),
        const SizedBox(height: 8),
        _buildCodeBlock(
          '// Width constrained, height scales\nTargetImageSize(width: 150)',
        ),
        const SizedBox(height: 8),
        _buildCodeBlock(
          '// Height constrained, width scales\nTargetImageSize(height: 200)',
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Colors.grey.shade800,
      ),
    ),
  );
}

Widget _buildUseCasesSection() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber.shade700),
            const SizedBox(width: 8),
            const Text(
              'Common Use Cases',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        _buildUseCase(
          Icons.photo_size_select_small,
          'Thumbnails',
          'TargetImageSize(width: 100, height: 100)',
          'Load small previews efficiently',
        ),
        const SizedBox(height: 12),
        _buildUseCase(
          Icons.photo_library,
          'Gallery View',
          'TargetImageSize(width: 300)',
          'Width-constrained for grid layouts',
        ),
        const SizedBox(height: 12),
        _buildUseCase(
          Icons.fullscreen,
          'Full Resolution',
          'TargetImageSize()',
          'No constraints - original size',
        ),
        const SizedBox(height: 12),
        _buildUseCase(
          Icons.smartphone,
          'Screen-Fitted',
          'TargetImageSize(width: screenWidth)',
          'Match device screen width',
        ),
      ],
    ),
  );
}

Widget _buildUseCase(IconData icon, String title, String code, String desc) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 20, color: Colors.amber.shade700),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildAspectRatioScenarios() {
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
            Icon(Icons.aspect_ratio, color: Colors.green.shade700),
            const SizedBox(width: 8),
            const Text(
              'Aspect Ratio Behavior',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        Row(
          children: [
            Expanded(child: _buildAspectRatioBox('16:9', 160, 90, Colors.blue)),
            const SizedBox(width: 8),
            Expanded(child: _buildAspectRatioBox('4:3', 120, 90, Colors.green)),
            const SizedBox(width: 8),
            Expanded(child: _buildAspectRatioBox('1:1', 90, 90, Colors.orange)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'When only width or height is set, the decoder maintains the original aspect ratio. '
            'Setting both dimensions may result in scaling to fit within bounds.',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAspectRatioBox(String ratio, double w, double h, Color color) {
  return Column(
    children: [
      Container(
        width: w / 2,
        height: h / 2,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            ratio,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text('${w.toInt()}×${h.toInt()}', style: const TextStyle(fontSize: 10)),
    ],
  );
}

Widget _buildMemoryConsiderations() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.memory, color: Colors.red.shade700),
            const SizedBox(width: 8),
            const Text(
              'Memory Optimization',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        _buildMemoryComparison('4K Image', '3840×2160', '~33 MB', Colors.red),
        const SizedBox(height: 8),
        _buildMemoryComparison(
          'HD Scaled',
          '1920×1080',
          '~8 MB',
          Colors.orange,
        ),
        const SizedBox(height: 8),
        _buildMemoryComparison(
          'Thumbnail',
          '256×144',
          '~0.15 MB',
          Colors.green,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.tips_and_updates,
                color: Colors.amber.shade700,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Use TargetImageSize to decode images at the size needed, '
                  'not at full resolution. This dramatically reduces memory usage.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMemoryComparison(
  String label,
  String dims,
  String memory,
  Color color,
) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 12),
      Expanded(
        flex: 2,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
      Expanded(
        flex: 2,
        child: Text(
          dims,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          memory,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    ],
  );
}

Widget _buildCommonSizes() {
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
            Icon(Icons.grid_on, color: Colors.indigo.shade700),
            const SizedBox(width: 8),
            const Text(
              'Common Target Sizes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1.5),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Purpose',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Size',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Code',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            _buildSizeRow(
              'Icon',
              '32×32',
              'TargetImageSize(width: 32, height: 32)',
            ),
            _buildSizeRow(
              'Avatar',
              '64×64',
              'TargetImageSize(width: 64, height: 64)',
            ),
            _buildSizeRow(
              'Thumbnail',
              '128×128',
              'TargetImageSize(width: 128)',
            ),
            _buildSizeRow('Preview', '256×256', 'TargetImageSize(width: 256)'),
            _buildSizeRow('Card', '512×384', 'TargetImageSize(width: 512)'),
            _buildSizeRow('HD', '1280×720', 'TargetImageSize(width: 1280)'),
            _buildSizeRow(
              'Full HD',
              '1920×1080',
              'TargetImageSize(width: 1920)',
            ),
          ],
        ),
      ],
    ),
  );
}

TableRow _buildSizeRow(String purpose, String size, String code) {
  return TableRow(
    children: [
      Padding(padding: const EdgeInsets.all(8), child: Text(purpose)),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          size,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    ],
  );
}

Widget _buildApiReference() {
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
            Icon(Icons.api, color: Colors.blueGrey.shade700),
            const SizedBox(width: 8),
            const Text(
              'API Reference',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Divider(height: 24),
        _buildApiItem(
          'Constructor',
          'TargetImageSize({int? width, int? height})',
        ),
        const SizedBox(height: 8),
        _buildApiItem(
          'width',
          'int? — target width in pixels, null means unconstrained',
        ),
        const SizedBox(height: 8),
        _buildApiItem(
          'height',
          'int? — target height in pixels, null means unconstrained',
        ),
        const SizedBox(height: 8),
        _buildApiItem(
          'Usage',
          'Pass to instantiateImageCodec() or ImageDescriptor',
        ),
      ],
    ),
  );
}

Widget _buildApiItem(String name, String desc) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          name,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          desc,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('=== TargetImageSize Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Construction Patterns
  // ═══════════════════════════════════════════════════════════════════════════

  final defaultSize = ui.TargetImageSize();
  print('Default: width=${defaultSize.width}, height=${defaultSize.height}');

  final fixedSize = ui.TargetImageSize(width: 200, height: 300);
  print('Fixed 200×300: width=${fixedSize.width}, height=${fixedSize.height}');

  final widthOnly = ui.TargetImageSize(width: 150);
  print('Width only 150: width=${widthOnly.width}, height=${widthOnly.height}');

  final heightOnly = ui.TargetImageSize(height: 200);
  print(
    'Height only 200: width=${heightOnly.width}, height=${heightOnly.height}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Common Sizes
  // ═══════════════════════════════════════════════════════════════════════════

  final thumbnail = ui.TargetImageSize(width: 100, height: 100);
  print(
    'Thumbnail 100×100: width=${thumbnail.width}, height=${thumbnail.height}',
  );

  final preview = ui.TargetImageSize(width: 256);
  print('Preview 256: width=${preview.width}, height=${preview.height}');

  final hdSize = ui.TargetImageSize(width: 1280, height: 720);
  print('HD 1280×720: width=${hdSize.width}, height=${hdSize.height}');

  final fullHd = ui.TargetImageSize(width: 1920, height: 1080);
  print('Full HD 1920×1080: width=${fullHd.width}, height=${fullHd.height}');

  final ultraHd = ui.TargetImageSize(width: 3840, height: 2160);
  print('4K 3840×2160: width=${ultraHd.width}, height=${ultraHd.height}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Null handling
  // ═══════════════════════════════════════════════════════════════════════════

  print('Checking nullability:');
  print('default.width is null: ${defaultSize.width == null}');
  print('default.height is null: ${defaultSize.height == null}');
  print('fixedSize.width is null: ${fixedSize.width == null}');
  print('widthOnly.height is null: ${widthOnly.height == null}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Various sizes for testing
  // ═══════════════════════════════════════════════════════════════════════════

  final sizes = <ui.TargetImageSize>[
    ui.TargetImageSize(),
    ui.TargetImageSize(width: 32, height: 32),
    ui.TargetImageSize(width: 64, height: 64),
    ui.TargetImageSize(width: 128),
    ui.TargetImageSize(height: 128),
    ui.TargetImageSize(width: 256, height: 192),
    ui.TargetImageSize(width: 512, height: 384),
    ui.TargetImageSize(width: 1024, height: 768),
  ];

  for (var i = 0; i < sizes.length; i++) {
    final s = sizes[i];
    print('Size $i: width=${s.width}, height=${s.height}');
  }

  print('=== TargetImageSize Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Roboto'),
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('TargetImageSize Demo'),
        backgroundColor: Colors.deepPurple.shade700,
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

            // Size visualizations
            const Text(
              'Size Specifications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildSizeVisualization(
              'Default',
              defaultSize,
              Colors.grey,
              description: 'No constraints - decodes at original size',
            ),
            const SizedBox(height: 12),
            _buildSizeVisualization(
              'Fixed',
              fixedSize,
              Colors.blue,
              description: 'Both dimensions specified: 200×300',
            ),
            const SizedBox(height: 12),
            _buildSizeVisualization(
              'Width Only',
              widthOnly,
              Colors.teal,
              description: 'Width=150, height scales proportionally',
            ),
            const SizedBox(height: 12),
            _buildSizeVisualization(
              'Height Only',
              heightOnly,
              Colors.orange,
              description: 'Height=200, width scales proportionally',
            ),
            const SizedBox(height: 24),

            _buildConstructorPatterns(),
            const SizedBox(height: 20),

            _buildUseCasesSection(),
            const SizedBox(height: 20),

            _buildAspectRatioScenarios(),
            const SizedBox(height: 20),

            _buildMemoryConsiderations(),
            const SizedBox(height: 20),

            _buildCommonSizes(),
            const SizedBox(height: 20),

            _buildApiReference(),
            const SizedBox(height: 32),

            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.deepPurple.shade700),
                  const SizedBox(width: 8),
                  const Text(
                    'TargetImageSize Demo Complete',
                    style: TextStyle(fontWeight: FontWeight.w500),
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
