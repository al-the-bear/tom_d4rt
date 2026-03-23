// ignore_for_file: avoid_print
// D4rt Deep Demo: BlendMode - Advanced Color Compositing Operations
// This demo comprehensively explores BlendMode enum which defines how colors
// are combined when drawing one element over another.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 1: BlendMode Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 2: Basic Blending Modes (Porter-Duff)
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 3: Mathematical Blend Modes
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 4: Screen and Overlay Family
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 5: Darken and Lighten Modes
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 6: Difference Modes
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 7: HSL Component Modes
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 8: BlendMode with Paint
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 9: BlendMode with ColorFilter
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 10: Performance Considerations
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 11: Common Patterns
  // ═══════════════════════════════════════════════════════════════════════════════

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
                  color: Colors.pink.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.gradient, size: 48, color: Colors.white),
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
                  '${BlendMode.values.length} Color Compositing Operations',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
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

          _buildCategoryCard('Porter-Duff', 'Classic compositing', [
            'clear',
            'src',
            'dst',
            'srcOver',
            'dstOver',
            'srcIn',
            'dstIn',
            'srcOut',
            'dstOut',
            'srcATop',
            'dstATop',
            'xor',
          ], Colors.blue),
          SizedBox(height: 12),

          _buildCategoryCard('Mathematical', 'Color math operations', [
            'plus',
            'modulate',
          ], Colors.green),
          SizedBox(height: 12),

          _buildCategoryCard('Screen & Overlay', 'Contrast effects', [
            'screen',
            'overlay',
            'softLight',
            'hardLight',
          ], Colors.orange),
          SizedBox(height: 12),

          _buildCategoryCard('Darken & Lighten', 'Brightness comparison', [
            'darken',
            'lighten',
            'colorDodge',
            'colorBurn',
          ], Colors.teal),
          SizedBox(height: 12),

          _buildCategoryCard('Difference', 'Color difference', [
            'difference',
            'exclusion',
          ], Colors.red),
          SizedBox(height: 12),

          _buildCategoryCard('HSL Component', 'Hue/Saturation/Luminosity', [
            'hue',
            'saturation',
            'color',
            'luminosity',
          ], Colors.purple),

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
                Text(
                  'Source (Red) + Destination (Blue)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
                _buildPerfIndicator(
                  'Screen/Overlay',
                  '🟡 Medium',
                  Colors.orange,
                ),
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

Widget _buildCategoryCard(
  String title,
  String subtitle,
  List<String> modes,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3)),
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
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: modes
              .map(
                (m) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(m, style: TextStyle(fontSize: 10, color: color)),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

Widget _buildBlendPreview(String name, BlendMode mode) {
  return SizedBox(
    width: 70,
    child: Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: CustomPaint(painter: _BlendDemoPainter(mode)),
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
    canvas.drawRect(Rect.fromLTWH(0, 10, 35, 35), Paint()..color = Colors.blue);

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
          child: Text(
            mode,
            style: TextStyle(fontSize: 11, color: Colors.purple.shade700),
          ),
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
