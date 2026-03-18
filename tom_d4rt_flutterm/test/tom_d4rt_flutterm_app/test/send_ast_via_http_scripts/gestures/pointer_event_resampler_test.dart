import 'package:flutter/material.dart';

/// Deep visual demo for PointerEventResampler.
/// Shows event timing adjustment for touch prediction.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerEventResampler')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Event Resampling',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
            child: CustomPaint(
              size: const Size(double.infinity, 120),
              painter: _ResamplingPainter(),
            ),
          ),
          const SizedBox(height: 16),
          _FeatureRow(icon: Icons.access_time, text: 'Adjusts event timestamps'),
          _FeatureRow(icon: Icons.timeline, text: 'Interpolates between samples'),
          _FeatureRow(icon: Icons.speed, text: 'Reduces perceived latency'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Resamples touch events to align with display refresh, reducing input lag perception.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _ResamplingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final originalPaint = Paint()..color = Colors.grey..strokeWidth = 2;
    final resampledPaint = Paint()..color = Colors.indigo..strokeWidth = 2;
    
    // Original samples (dots)
    for (int i = 0; i < 5; i++) {
      canvas.drawCircle(Offset(40 + i * 50.0, 30), 5, originalPaint);
    }
    
    // Resampled (smooth line)
    final path = Path()..moveTo(40, 80);
    for (int i = 1; i < 5; i++) {
      path.lineTo(40 + i * 50.0, 80);
    }
    canvas.drawPath(path, resampledPaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FeatureRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Icon(icon, color: Colors.indigo, size: 18),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
      ]),
    );
  }
}
