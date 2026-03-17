// D4rt Deep Demo: BlurStyle - Shadow Blur Rendering Styles
// This demo comprehensively explores BlurStyle enum which controls
// how blur is applied to MaskFilter for shadow and blur effects.
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════════════════════════');
  print('                         BLURSTYLE DEEP DEMO                               ');
  print('═══════════════════════════════════════════════════════════════════════════');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 1: BlurStyle Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 1: BlurStyle Fundamentals');
  print('─────────────────────────────────────────────────────────────────────────');
  print('BlurStyle controls how blur is rendered for MaskFilter:');
  print('- Affects shadow and glow appearance');
  print('- Used with MaskFilter.blur()');
  print('- Different styles for different visual effects');
  print('');
  print('All blur styles:');
  for (final style in BlurStyle.values) {
    print('  [${ style.index}] ${ style.name}');
  }
  print('Total: ${ BlurStyle.values.length} styles');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 2: Normal Blur Style
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 2: Normal Blur');
  print('─────────────────────────────────────────────────────────────────────────');
  final normal = BlurStyle.normal;
  print('Style: $normal');
  print('Name: ${ normal.name}');
  print('Index: ${ normal.index}');
  print('');
  print('Characteristics:');
  print('  • Blur extends in all directions');
  print('  • Affects both inside and outside shape edge');
  print('  • Standard Gaussian blur');
  print('  • Most common blur style');
  print('');
  print('Use cases:');
  print('  • General shadows');
  print('  • Soft glow effects');
  print('  • Background blur');
  print('  • Text shadows');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 3: Solid Blur Style
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 3: Solid Blur');
  print('─────────────────────────────────────────────────────────────────────────');
  final solid = BlurStyle.solid;
  print('Style: $solid');
  print('Name: ${ solid.name}');
  print('Index: ${ solid.index}');
  print('');
  print('Characteristics:');
  print('  • Shape interior remains solid/opaque');
  print('  • Only outer edge is blurred');
  print('  • Preserves crisp center');
  print('  • Blur fades outward only');
  print('');
  print('Use cases:');
  print('  • Soft-edge shapes with solid fill');
  print('  • Buttons with soft borders');
  print('  • Cards with feathered edges');
  print('  • Vignette effects');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 4: Outer Blur Style
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 4: Outer Blur');
  print('─────────────────────────────────────────────────────────────────────────');
  final outer = BlurStyle.outer;
  print('Style: $outer');
  print('Name: ${ outer.name}');
  print('Index: ${ outer.index}');
  print('');
  print('Characteristics:');
  print('  • Blur only OUTSIDE the shape');
  print('  • Interior is completely empty/transparent');
  print('  • Creates halo/glow around shapes');
  print('  • No fill, only shadow');
  print('');
  print('Use cases:');
  print('  • Glow effects behind elements');
  print('  • Drop shadows (classic shadow)');
  print('  • Neon glow effects');
  print('  • Light halos');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 5: Inner Blur Style
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 5: Inner Blur');
  print('─────────────────────────────────────────────────────────────────────────');
  final inner = BlurStyle.inner;
  print('Style: $inner');
  print('Name: ${ inner.name}');
  print('Index: ${ inner.index}');
  print('');
  print('Characteristics:');
  print('  • Blur only INSIDE the shape');
  print('  • Exterior is empty/transparent');
  print('  • Creates inset shadow effect');
  print('  • Blur fades inward from edge');
  print('');
  print('Use cases:');
  print('  • Inset shadows (pressed buttons)');
  print('  • Inner glow effects');
  print('  • Embossed/debossed look');
  print('  • Cut-out effects');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 6: BlurStyle Comparison
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 6: Style Comparison');
  print('─────────────────────────────────────────────────────────────────────────');
  print('Visual comparison of blur styles:');
  print('');
  print('┌─────────────┬───────────┬───────────┬──────────────┐');
  print('│   Style     │  Inside   │  Outside  │   Fill       │');
  print('├─────────────┼───────────┼───────────┼──────────────┤');
  print('│   normal    │   Blur    │   Blur    │   Blurred    │');
  print('│   solid     │   Solid   │   Blur    │   Yes        │');
  print('│   outer     │   Empty   │   Blur    │   No         │');
  print('│   inner     │   Blur    │   Empty   │   Blurred    │');
  print('└─────────────┴───────────┴───────────┴──────────────┘');
  print('');
  print('Equality checks:');
  print('normal == solid: ${ normal == solid}');
  print('outer == inner: ${ outer == inner}');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 7: Creating MaskFilter with BlurStyle
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 7: MaskFilter Usage');
  print('─────────────────────────────────────────────────────────────────────────');
  print('Creating MaskFilter with different blur styles:');
  print('');
  
  final sigma = 10.0;
  
  final normalFilter = MaskFilter.blur(BlurStyle.normal, sigma);
  print('MaskFilter.blur(BlurStyle.normal, $sigma)');
  print('  → $normalFilter');
  
  final solidFilter = MaskFilter.blur(BlurStyle.solid, sigma);
  print('');
  print('MaskFilter.blur(BlurStyle.solid, $sigma)');
  print('  → $solidFilter');
  
  final outerFilter = MaskFilter.blur(BlurStyle.outer, sigma);
  print('');
  print('MaskFilter.blur(BlurStyle.outer, $sigma)');
  print('  → $outerFilter');
  
  final innerFilter = MaskFilter.blur(BlurStyle.inner, sigma);
  print('');
  print('MaskFilter.blur(BlurStyle.inner, $sigma)');
  print('  → $innerFilter');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 8: Paint Integration
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 8: Paint Integration');
  print('─────────────────────────────────────────────────────────────────────────');
  print('Applying MaskFilter to Paint:');
  print('');
  
  final paint = Paint()
    ..color = Colors.black
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8.0);
  
  print('''
  final paint = Paint()
    ..color = Colors.black
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8.0);
  
  canvas.drawRect(rect, paint);
  ''');
  
  print('');
  print('Paint.maskFilter: ${ paint.maskFilter}');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 9: BoxShadow Widget Equivalent
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 9: Widget Level Usage');
  print('─────────────────────────────────────────────────────────────────────────');
  print('BlurStyle equivalents at widget level:');
  print('');
  print('BoxShadow (uses similar blur concept):');
  print('''
  Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10.0,  // Similar to sigma
          spreadRadius: 2.0, // Expands/contracts shadow
          offset: Offset(4, 4),
        ),
      ],
    ),
  )
  ''');
  print('');
  print('Note: BoxShadow doesn\'t expose BlurStyle directly');
  print('For custom blur styles, use CustomPainter with MaskFilter');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 10: Sigma Value Impact
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 10: Sigma Values');
  print('─────────────────────────────────────────────────────────────────────────');
  print('Sigma controls blur intensity for all styles:');
  print('');
  print('┌────────────┬─────────────────┬─────────────────────┐');
  print('│   Sigma    │   Appearance    │   Pixel Spread      │');
  print('├────────────┼─────────────────┼─────────────────────┤');
  print('│   0.5-2    │   Very subtle   │   ~2-6 pixels       │');
  print('│   3-5      │   Light blur    │   ~9-15 pixels      │');
  print('│   6-10     │   Medium blur   │   ~18-30 pixels     │');
  print('│   11-20    │   Heavy blur    │   ~33-60 pixels     │');
  print('│   20+      │   Very heavy    │   60+ pixels        │');
  print('└────────────┴─────────────────┴─────────────────────┘');
  print('');
  print('Approximate rule: Blur spread ≈ 3 × sigma');

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 11: Practical Examples
  // ═══════════════════════════════════════════════════════════════════════════════
  print('\n📌 SECTION 11: Practical Examples');
  print('─────────────────────────────────────────────────────────────────────────');
  print('Common blur style applications:');
  print('');
  print('Drop Shadow (outer):');
  print('  MaskFilter.blur(BlurStyle.outer, 8.0)');
  print('  + Offset for direction');
  print('  + Semi-transparent black');
  print('');
  print('Text Glow (normal):');
  print('  MaskFilter.blur(BlurStyle.normal, 4.0)');
  print('  + Bright color');
  print('  + Draw text twice (glow + crisp)');
  print('');
  print('Button Press (inner):');
  print('  MaskFilter.blur(BlurStyle.inner, 6.0)');
  print('  + Dark color');
  print('  + Creates inset appearance');
  print('');
  print('Soft Button (solid):');
  print('  MaskFilter.blur(BlurStyle.solid, 3.0)');
  print('  + Solid interior');
  print('  + Soft edge transition');

  print('\n═══════════════════════════════════════════════════════════════════════════');
  print('                      BLURSTYLE DEEP DEMO COMPLETE                         ');
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
        colors: [Colors.grey.shade100, Colors.blueGrey.shade100],
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
                colors: [Colors.blueGrey.shade600, Colors.grey.shade700],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.4),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.blur_linear, size: 48, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  'BlurStyle',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Shadow & Blur Rendering Modes',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Blur Style Visual Comparison
          Text(
            'Blur Style Comparison',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade800,
            ),
          ),
          SizedBox(height: 12),
          
          Row(
            children: [
              _buildBlurDemo('normal', BlurStyle.normal, Colors.blue),
              SizedBox(width: 12),
              _buildBlurDemo('solid', BlurStyle.solid, Colors.green),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildBlurDemo('outer', BlurStyle.outer, Colors.orange),
              SizedBox(width: 12),
              _buildBlurDemo('inner', BlurStyle.inner, Colors.purple),
            ],
          ),
          
          SizedBox(height: 24),
          
          // Characteristics Table
          Text(
            'Style Characteristics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade800,
            ),
          ),
          SizedBox(height: 12),
          
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              children: [
                _buildCharRow('Style', 'Inside', 'Outside', 'Fill', true),
                Divider(),
                _buildCharRow('normal', '🌫️ Blur', '🌫️ Blur', 'Blurred', false),
                _buildCharRow('solid', '⬛ Solid', '🌫️ Blur', 'Yes', false),
                _buildCharRow('outer', '⬜ Empty', '🌫️ Blur', 'No', false),
                _buildCharRow('inner', '🌫️ Blur', '⬜ Empty', 'Blurred', false),
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
              color: Colors.blueGrey.shade800,
            ),
          ),
          SizedBox(height: 12),
          
          _buildUseCaseCard(
            'Drop Shadow',
            'BlurStyle.outer',
            'Classic shadow behind elements',
            Icons.wb_shade,
            Colors.grey,
          ),
          SizedBox(height: 8),
          _buildUseCaseCard(
            'Glow Effect',
            'BlurStyle.normal',
            'Soft glow around elements',
            Icons.wb_sunny,
            Colors.amber,
          ),
          SizedBox(height: 8),
          _buildUseCaseCard(
            'Inset Shadow',
            'BlurStyle.inner',
            'Pressed button appearance',
            Icons.smart_button,
            Colors.brown,
          ),
          SizedBox(height: 8),
          _buildUseCaseCard(
            'Soft Edge',
            'BlurStyle.solid',
            'Filled shape with feathered edge',
            Icons.crop_square,
            Colors.teal,
          ),
          
          SizedBox(height: 24),
          
          // Sigma Guide
          Text(
            'Sigma Values',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade800,
            ),
          ),
          SizedBox(height: 12),
          
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                _buildSigmaPreview(2, 'Subtle'),
                _buildSigmaPreview(6, 'Light'),
                _buildSigmaPreview(12, 'Medium'),
                _buildSigmaPreview(20, 'Heavy'),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Code Example
          Text(
            'Code Example',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade800,
            ),
          ),
          SizedBox(height: 12),
          
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'final paint = Paint()',
                  style: TextStyle(color: Colors.lightBlue.shade200, fontFamily: 'monospace'),
                ),
                Text(
                  '  ..color = Colors.black54',
                  style: TextStyle(color: Colors.lightBlue.shade200, fontFamily: 'monospace'),
                ),
                Text(
                  '  ..maskFilter = MaskFilter.blur(',
                  style: TextStyle(color: Colors.lightBlue.shade200, fontFamily: 'monospace'),
                ),
                Text(
                  '    BlurStyle.outer, // Style',
                  style: TextStyle(color: Colors.green.shade300, fontFamily: 'monospace'),
                ),
                Text(
                  '    8.0,            // Sigma',
                  style: TextStyle(color: Colors.orange.shade300, fontFamily: 'monospace'),
                ),
                Text(
                  '  );',
                  style: TextStyle(color: Colors.lightBlue.shade200, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 32),
          
          // Footer
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '🌫️ BlurStyle Deep Demo',
                style: TextStyle(
                  color: Colors.blueGrey.shade800,
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

Widget _buildBlurDemo(String name, BlurStyle style, Color color) {
  return Expanded(
    child: Container(
      height: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            size: Size(50, 50),
            painter: _BlurStylePainter(style, color),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

class _BlurStylePainter extends CustomPainter {
  final BlurStyle style;
  final Color color;
  _BlurStylePainter(this.style, this.color);
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(style, 6.0);
    
    canvas.drawCircle(center, 18, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildCharRow(String style, String inside, String outside, String fill, bool isHeader) {
  final textStyle = TextStyle(
    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
    fontSize: 12,
  );
  
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(flex: 2, child: Text(style, style: textStyle)),
        Expanded(flex: 2, child: Text(inside, style: textStyle, textAlign: TextAlign.center)),
        Expanded(flex: 2, child: Text(outside, style: textStyle, textAlign: TextAlign.center)),
        Expanded(flex: 2, child: Text(fill, style: textStyle, textAlign: TextAlign.center)),
      ],
    ),
  );
}

Widget _buildUseCaseCard(String title, String style, String desc, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(style, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

Widget _buildSigmaPreview(double sigma, String label) {
  return Expanded(
    child: Column(
      children: [
        CustomPaint(
          size: Size(40, 40),
          painter: _SigmaDemoPainter(sigma),
        ),
        SizedBox(height: 4),
        Text('σ=${ sigma.toInt()}', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    ),
  );
}

class _SigmaDemoPainter extends CustomPainter {
  final double sigma;
  _SigmaDemoPainter(this.sigma);
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.blueGrey
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, sigma);
    
    canvas.drawCircle(center, 12, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
