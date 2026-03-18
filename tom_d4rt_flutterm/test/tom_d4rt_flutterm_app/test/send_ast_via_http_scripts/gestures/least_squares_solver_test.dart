import 'package:flutter/material.dart';

/// Deep visual demo for LeastSquaresSolver.
/// Shows polynomial fitting for velocity estimation.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('LeastSquaresSolver')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Least Squares Fitting',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 180,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
            child: CustomPaint(
              size: const Size(double.infinity, 150),
              painter: _FittingPainter(),
            ),
          ),
          const SizedBox(height: 16),
          _InfoRow(label: 'Input', value: 'Time-position samples'),
          _InfoRow(label: 'Output', value: 'Polynomial coefficients'),
          _InfoRow(label: 'Use', value: 'Velocity estimation'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Fits a polynomial to touch samples to estimate velocity for fling physics.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _FittingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()..color = Colors.indigo..style = PaintingStyle.fill;
    final linePaint = Paint()..color = Colors.indigo..strokeWidth = 2..style = PaintingStyle.stroke;
    
    // Sample points
    final points = [
      Offset(20, size.height - 30),
      Offset(60, size.height - 50),
      Offset(100, size.height - 80),
      Offset(140, size.height - 100),
      Offset(180, size.height - 110),
    ];
    
    // Draw points
    for (final p in points) {
      canvas.drawCircle(p, 6, dotPaint);
    }
    
    // Draw fitted curve
    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, linePaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        SizedBox(width: 80, child: Text('\$label:', style: const TextStyle(color: Colors.grey))),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ]),
    );
  }
}
