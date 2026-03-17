// D4rt Deep Demo: BlendMode - Advanced Color Compositing Operations
// This demo comprehensively explores BlendMode enum which defines how colors
// are combined when drawing one element over another.
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════════════════════════');
  print('                         BLENDMODE DEEP DEMO                               ');
  print('═══════════════════════════════════════════════════════════════════════════');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 1: BlendMode Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 1: BlendMode Fundamentals');
  print('─────────────────────────────────────────────────────────────────────────');
  print('BlendMode defines how pixels are combined during drawing operations:');
  print('- Source (src): The color being drawn');
  print('- Destination (dst): The existing color on canvas');
  print('- Result: The computed output color');
  print('');
  print('All ${ BlendMode.values.length} blend modes:');
  for (final mode in BlendMode.values) {
    print('  [${ mode.index.toString().padLeft(2)}] ${ mode.name}');
  }

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 2: Basic Blending Modes (Porter-Duff)
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 2: Porter-Duff Modes');
  print('─────────────────────────────────────────────────────────────────────────');
  print('Classic compositing operations:');
  print('');
  
  final porterDuff = [
    ('clear', BlendMode.clear, 'Result = 0 (transparent)'),
    ('src', BlendMode.src, 'Result = Source'),
    ('dst', BlendMode.dst, 'Result = Destination'),
    ('srcOver', BlendMode.srcOver, 'Source over destination (default)'),
    ('dstOver', BlendMode.dstOver, 'Destination over source'),
    ('srcIn', BlendMode.srcIn, 'Source where both overlap'),
    ('dstIn', BlendMode.dstIn, 'Destination where both overlap'),
    ('srcOut', BlendMode.srcOut, 'Source where dest is transparent'),
    ('dstOut', BlendMode.dstOut, 'Destination where src is transparent'),
    ('srcATop', BlendMode.srcATop, 'Source atop destination'),
    ('dstATop', BlendMode.dstATop, 'Destination atop source'),
    ('xor', BlendMode.xor, 'XOR - non-overlapping parts'),
  ];
  
  for (final (name, mode, desc) in porterDuff) {
    print('${ mode.name.padRight(10)} (index ${ mode.index}): $desc');
  }

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 3: Mathematical Blend Modes
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 3: Mathematical Modes');
  print('─────────────────────────────────────────────────────────────────────────');
  print('Modes that perform mathematical operations on colors:');
  print('');
  
  final mathematical = [
    ('plus', BlendMode.plus, 'Add colors (src + dst)'),
    ('modulate', BlendMode.modulate, 'Multiply colors (src × dst)'),
  ];
  
  for (final (name, mode, desc) in mathematical) {
    print('${ mode.name.padRight(10)} (index ${ mode.index}): $desc');
  }
  
  print('');
  print('Color addition example (plus):');
  print('  Red (255,0,0) + Blue (0,0,255) = Magenta (255,0,255)');
  print('');
  print('Color multiplication example (modulate):');
  print('  White (1,1,1) × Red (1,0,0) = Red (1,0,0)');
  print('  Gray (0.5,0.5,0.5) × Red (1,0,0) = Dark Red (0.5,0,0)');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 4: Screen and Overlay Family
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 4: Screen and Overlay');
  print('─────────────────────────────────────────────────────────────────────────');
  
  final screenOverlay = [
    ('screen', BlendMode.screen, 'Lightens: 1 - (1-src)×(1-dst)'),
    ('overlay', BlendMode.overlay, 'Multiply or screen based on dest'),
    ('softLight', BlendMode.softLight, 'Softer version of overlay'),
    ('hardLight', BlendMode.hardLight, 'Multiply or screen based on src'),
  ];
  
  for (final (name, mode, desc) in screenOverlay) {
    print('${ mode.name.padRight(10)} (index ${ mode.index}): $desc');
  }
  
  print('');
  print('Screen is like projecting two slides onto a screen');
  print('Overlay combines multiply and screen for contrast');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 5: Darken and Lighten Modes
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 5: Darken/Lighten Modes');
  print('─────────────────────────────────────────────────────────────────────────');
  
  final darkenLighten = [
    ('darken', BlendMode.darken, 'Keep darker of src/dst per channel'),
    ('lighten', BlendMode.lighten, 'Keep lighter of src/dst per channel'),
    ('colorDodge', BlendMode.colorDodge, 'Brighten dest based on src'),
    ('colorBurn', BlendMode.colorBurn, 'Darken dest based on src'),
  ];
  
  for (final (name, mode, desc) in darkenLighten) {
    print('${ mode.name.padRight(12)} (index ${ mode.index}): $desc');
  }

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 6: Difference Modes
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 6: Difference Modes');
  print('─────────────────────────────────────────────────────────────────────────');
  
  final difference = [
    ('difference', BlendMode.difference, 'Absolute difference |src - dst|'),
    ('exclusion', BlendMode.exclusion, 'Softer difference'),
  ];
  
  for (final (name, mode, desc) in difference) {
    print('${ mode.name.padRight(10)} (index ${ mode.index}): $desc');
  }
  
  print('');
  print('Difference mode:');
  print('  Same colors → Black (difference is zero)');
  print('  Inverse colors → White (maximum difference)');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 7: HSL Component Modes
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 7: HSL Component Modes');
  print('─────────────────────────────────────────────────────────────────────────');
  print('Modes that work with Hue, Saturation, Luminosity:');
  print('');
  
  final hsl = [
    ('hue', BlendMode.hue, 'Use src hue, dst saturation/luminosity'),
    ('saturation', BlendMode.saturation, 'Use src saturation, dst hue/luminosity'),
    ('color', BlendMode.color, 'Use src hue+saturation, dst luminosity'),
    ('luminosity', BlendMode.luminosity, 'Use src luminosity, dst hue+saturation'),
  ];
  
  for (final (name, mode, desc) in hsl) {
    print('${ mode.name.padRight(12)} (index ${ mode.index}): $desc');
  }
  
  print('');
  print('Use cases:');
  print('  hue: Colorize grayscale images');
  print('  saturation: Adjust color intensity');
  print('  color: Apply color tint');
  print('  luminosity: Match brightness only');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 8: BlendMode with Paint
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 8: Using with Paint');
  print('─────────────────────────────────────────────────────────────────────────');
  print('Setting blendMode on Paint object:');
  print('');
  
  final paint1 = Paint()..blendMode = BlendMode.srcOver;
  print('paint.blendMode = BlendMode.srcOver (default)');
  print('  paint.blendMode: ${ paint1.blendMode}');
  
  final paint2 = Paint()..blendMode = BlendMode.multiply;
  print('');
  print('paint.blendMode = BlendMode.multiply');
  print('  paint.blendMode: ${ paint2.blendMode}');
  
  print('');
  print('Code example:');
  print('''
  final paint = Paint()
    ..color = Colors.red
    ..blendMode = BlendMode.multiply;
  
  canvas.drawRect(rect, paint);
  ''');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 9: BlendMode with ColorFilter
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 9: ColorFilter Usage');
  print('─────────────────────────────────────────────────────────────────────────');
  print('Creating ColorFilter with BlendMode:');
  print('');
  
  final filter1 = ColorFilter.mode(Colors.red, BlendMode.multiply);
  print('ColorFilter.mode(Colors.red, BlendMode.multiply)');
  print('  → Tints image with red using multiply');
  
  final filter2 = ColorFilter.mode(Colors.blue.withOpacity(0.5), BlendMode.srcATop);
  print('');
  print('ColorFilter.mode(Colors.blue.withOpacity(0.5), BlendMode.srcATop)');
  print('  → Semi-transparent blue overlay');
  
  print('');
  print('Common ColorFilter patterns:');
  print('  Grayscale: ColorFilter.matrix([...grayscale matrix...])');
  print('  Sepia: Apply warm color overlay with multiply');
  print('  Tint: Use srcATop with semi-transparent color');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 10: Performance Considerations
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 10: Performance');
  print('─────────────────────────────────────────────────────────────────────────');
  print('BlendMode performance tiers:');
  print('');
  print('┌──────────────────┬─────────────┬────────────────────────┐');
  print('│     Category     │    Cost     │       Examples         │');
  print('├──────────────────┼─────────────┼────────────────────────┤');
  print('│ Porter-Duff      │    Low      │ srcOver, src, dst      │');
  print('│ Mathematical     │    Low      │ plus, modulate         │');
  print('│ Darken/Lighten   │   Medium    │ darken, lighten        │');
  print('│ Dodge/Burn       │   Medium    │ colorDodge, colorBurn  │');
  print('│ Overlay Family   │   Medium    │ overlay, hardLight     │');
  print('│ HSL Component    │    High     │ hue, saturation, color │');
  print('└──────────────────┴─────────────┴────────────────────────┘');
  print('');
  print('Note: HSL modes require color space conversion');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 11: Common Patterns
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 11: Common Patterns');
  print('─────────────────────────────────────────────────────────────────────────');
  print('Recommended modes for common effects:');
  print('');
  print('Photo Effects:');
  print('  • Vintage: screen + sepia color');
  print('  • High contrast: overlay');
  print('  • Desaturate: saturation with gray');
  print('');
  print('UI Effects:');
  print('  • Tinted glass: multiply with semi-transparent');
  print('  • Highlight: screen or colorDodge');
  print('  • Shadow overlay: multiply with dark color');
  print('');
  print('Mask Operations:');
  print('  • Shape mask: dstIn or srcIn');
  print('  • Knockout: dstOut or srcOut');
  print('  • Intersection: srcIn');

  print('\n═══════════════════════════════════════════════════════════════════════════');
  print('                      BLENDMODE DEEP DEMO COMPLETE                         ');
  print('═══════════════════════════════════════════════════════════════════════════');

  // ═══════════════════════════════════════════════════════════════════════════════
  // VISUAL DEMONSTRATION UI
  // ═══════════════════════════════════════════════════════════════════════════════
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.pink.shade50, Colors.purple.shade50],
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade600, Colors.purple.shade600],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.blend, size: 48, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  'BlendMode',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${ BlendMode.values.length} Color Compositing Operations',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Blend Mode Categories
          Text(
            'Blend Mode Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade800,
            ),
          ),
          SizedBox(height: 12),
          
          _buildCategoryCard(
            'Porter-Duff',
            'Classic compositing',
            ['clear', 'src', 'dst', 'srcOver', 'dstOver', 'srcIn', 'dstIn', 'srcOut', 'dstOut', 'srcATop', 'dstATop', 'xor'],
            Colors.blue,
          ),
          SizedBox(height: 12),
          
          _buildCategoryCard(
            'Mathematical',
            'Color math operations',
            ['plus', 'modulate'],
            Colors.green,
          ),
          SizedBox(height: 12),
          
          _buildCategoryCard(
            'Screen & Overlay',
            'Contrast effects',
            ['screen', 'overlay', 'softLight', 'hardLight'],
            Colors.orange,
          ),
          SizedBox(height: 12),
          
          _buildCategoryCard(
            'Darken & Lighten',
            'Brightness comparison',
            ['darken', 'lighten', 'colorDodge', 'colorBurn'],
            Colors.teal,
          ),
          SizedBox(height: 12),
          
          _buildCategoryCard(
            'Difference',
            'Color difference',
            ['difference', 'exclusion'],
            Colors.red,
          ),
          SizedBox(height: 12),
          
          _buildCategoryCard(
            'HSL Component',
            'Hue/Saturation/Luminosity',
            ['hue', 'saturation', 'color', 'luminosity'],
            Colors.purple,
          ),
          
          SizedBox(height: 24),
          
          // Visual Blend Mode Demo
          Text(
            'Visual Blend Demo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade800,
            ),
          ),
          SizedBox(height: 12),
          
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('Source (Red) + Destination (Blue)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildBlendPreview('srcOver', BlendMode.srcOver),
                    _buildBlendPreview('multiply', BlendMode.multiply),
                    _buildBlendPreview('screen', BlendMode.screen),
                    _buildBlendPreview('overlay', BlendMode.overlay),
                    _buildBlendPreview('darken', BlendMode.darken),
                    _buildBlendPreview('lighten', BlendMode.lighten),
                    _buildBlendPreview('difference', BlendMode.difference),
                    _buildBlendPreview('plus', BlendMode.plus),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Use Cases
          Text(
            'Common Use Cases',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade800,
            ),
          ),
          SizedBox(height: 12),
          
          _buildUseCaseRow('Photo tinting', 'multiply', Icons.photo_filter),
          _buildUseCaseRow('Highlight glow', 'screen', Icons.wb_sunny),
          _buildUseCaseRow('Shape mask', 'srcIn/dstIn', Icons.crop_free),
          _buildUseCaseRow('High contrast', 'overlay', Icons.contrast),
          _buildUseCaseRow('Colorize B&W', 'color', Icons.palette),
          _buildUseCaseRow('Shadow overlay', 'multiply', Icons.wb_shade),
          
          SizedBox(height: 24),
          
          // Performance Guide
          Text(
            'Performance Guide',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade800,
            ),
          ),
          SizedBox(height: 12),
          
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildPerfIndicator('Porter-Duff', '🟢 Fast', Colors.green),
                _buildPerfIndicator('Mathematical', '🟢 Fast', Colors.green),
                _buildPerfIndicator('Screen/Overlay', '🟡 Medium', Colors.orange),
                _buildPerfIndicator('HSL Component', '🔴 Slower', Colors.red),
              ],
            ),
          ),
          
          SizedBox(height: 32),
          
          // Footer
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '🎨 BlendMode Deep Demo',
                style: TextStyle(
                  color: Colors.pink.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCategoryCard(String title, String subtitle, List<String> modes, Color color) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: modes.map((m) => Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(m, style: TextStyle(fontSize: 10, color: color)),
          )).toList(),
        ),
      ],
    ),
  );
}

Widget _buildBlendPreview(String name, BlendMode mode) {
  return Container(
    width: 70,
    child: Column(
      children: [
        Container(
          width: 50,
          height: 50,
          child: CustomPaint(
            painter: _BlendDemoPainter(mode),
          ),
        ),
        SizedBox(height: 4),
        Text(name, style: TextStyle(fontSize: 9), textAlign: TextAlign.center),
      ],
    ),
  );
}

class _BlendDemoPainter extends CustomPainter {
  final BlendMode mode;
  _BlendDemoPainter(this.mode);
  
  @override
  void paint(Canvas canvas, Size size) {
    // Draw blue destination
    canvas.drawRect(
      Rect.fromLTWH(0, 10, 35, 35),
      Paint()..color = Colors.blue,
    );
    
    // Draw red source with blend mode
    canvas.drawRect(
      Rect.fromLTWH(15, 5, 35, 35),
      Paint()
        ..color = Colors.red
        ..blendMode = mode,
    );
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildUseCaseRow(String useCase, String mode, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: Colors.pink.shade600),
        ),
        SizedBox(width: 12),
        Expanded(child: Text(useCase)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(mode, style: TextStyle(fontSize: 11, color: Colors.purple.shade700)),
        ),
      ],
    ),
  );
}

Widget _buildPerfIndicator(String category, String rating, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(child: Text(category)),
        Text(rating, style: TextStyle(color: color)),
      ],
    ),
  );
}
