import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PolynomialFit.
/// Shows result of polynomial regression for velocity estimation.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PolynomialFit')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Polynomial Fit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Used internally by:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• VelocityTracker'),
                Text('• LeastSquaresSolver'),
                Text('• Fling gesture detection'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• coefficients: List<double>'),
                Text('  Polynomial coefficients [c0, c1, c2...]'),
                SizedBox(height: 8),
                Text('• confidence: double'),
                Text('  R² value (0.0 to 1.0)'),
                Text('  Higher = better fit'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomPaint(painter: _CurvePainter()),
          ),
          const Center(child: Text('Fitted curve through velocity samples', style: TextStyle(fontSize: 11))),
        ],
      ),
    ),
  );
}

class _CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.purple..strokeWidth = 2..style = PaintingStyle.stroke;
    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.2, size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.7, size.height * 0.8, size.width, size.height * 0.3);
    canvas.drawPath(path, paint);
    // Points
    final dotPaint = Paint()..color = Colors.red;
    for (final x in [0.1, 0.25, 0.4, 0.55, 0.7, 0.85]) {
      canvas.drawCircle(Offset(size.width * x, size.height * (0.4 + 0.3 * (x - 0.5).abs())), 4, dotPaint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
