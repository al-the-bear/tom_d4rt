// D4rt Deep Demo: BlurStyle - Shadow Blur Rendering Styles
// This demo comprehensively explores BlurStyle enum which controls
// how blur is applied to MaskFilter for shadow and blur effects.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 1: BlurStyle Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════════
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 7: Creating MaskFilter with BlurStyle
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 8: Paint Integration
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 9: BoxShadow Widget Equivalent
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 10: Sigma Value Impact
  // ═══════════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════════
  // SECTION 11: Practical Examples
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
                  color: Colors.blueGrey.withValues(alpha: 0.4),
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
                    color: Colors.white.withValues(alpha: 0.9),
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
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              children: [
                _buildCharRow('Style', 'Inside', 'Outside', 'Fill', true),
                Divider(),
                _buildCharRow(
                  'normal',
                  '🌫️ Blur',
                  '🌫️ Blur',
                  'Blurred',
                  false,
                ),
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
                  style: TextStyle(
                    color: Colors.lightBlue.shade200,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  '  ..color = Colors.black54',
                  style: TextStyle(
                    color: Colors.lightBlue.shade200,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  '  ..maskFilter = MaskFilter.blur(',
                  style: TextStyle(
                    color: Colors.lightBlue.shade200,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  '    BlurStyle.outer, // Style',
                  style: TextStyle(
                    color: Colors.green.shade300,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  '    8.0,            // Sigma',
                  style: TextStyle(
                    color: Colors.orange.shade300,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  '  );',
                  style: TextStyle(
                    color: Colors.lightBlue.shade200,
                    fontFamily: 'monospace',
                  ),
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

Widget _buildBlurDemo(String name, BlurStyle style, MaterialColor color) {
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
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    ),
  );
}

class _BlurStylePainter extends CustomPainter {
  final BlurStyle style;
  final MaterialColor color;
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

Widget _buildCharRow(
  String style,
  String inside,
  String outside,
  String fill,
  bool isHeader,
) {
  final textStyle = TextStyle(
    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
    fontSize: 12,
  );

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Expanded(flex: 2, child: Text(style, style: textStyle)),
        Expanded(
          flex: 2,
          child: Text(inside, style: textStyle, textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 2,
          child: Text(outside, style: textStyle, textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 2,
          child: Text(fill, style: textStyle, textAlign: TextAlign.center),
        ),
      ],
    ),
  );
}

Widget _buildUseCaseCard(
  String title,
  String style,
  String desc,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
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
              Text(
                desc,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            style,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSigmaPreview(double sigma, String label) {
  return Expanded(
    child: Column(
      children: [
        CustomPaint(size: Size(40, 40), painter: _SigmaDemoPainter(sigma)),
        SizedBox(height: 4),
        Text(
          'σ=${sigma.toInt()}',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
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
