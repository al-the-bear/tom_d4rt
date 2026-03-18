import 'package:flutter/material.dart';

/// Deep visual demo for Size - 2D dimensions.
/// Demonstrates Size properties and operations.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Size Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Size',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: CustomPaint(
              painter: _SizePainter(),
              size: const Size(double.infinity, 180),
            ),
          ),
          const SizedBox(height: 24),
          _buildProp('Size(width, height)', 'Create from dimensions'),
          _buildProp('size.width', 'Horizontal extent'),
          _buildProp('size.height', 'Vertical extent'),
          _buildProp('size.aspectRatio', 'width / height'),
          _buildProp('size.isEmpty', 'Check if zero area'),
          _buildProp('size.flipped', 'Swap width and height'),
        ],
      ),
    ),
  );
}

Widget _buildProp(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          name,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

class _SizePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const demoSize = Size(180, 120);
    final rect = Rect.fromLTWH(20, 20, demoSize.width, demoSize.height);
    canvas.drawRect(rect, Paint()..color = Colors.blue.withValues(alpha: 0.3));
    canvas.drawRect(
      rect,
      Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    final tp1 = TextPainter(
      text: const TextSpan(text: 'width: 180', style: TextStyle(fontSize: 11)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp1.paint(canvas, Offset(60, demoSize.height + 25));

    final tp2 = TextPainter(
      text: const TextSpan(text: 'height: 120', style: TextStyle(fontSize: 11)),
      textDirection: TextDirection.ltr,
    )..layout();
    canvas.save();
    canvas.translate(demoSize.width + 30, 80);
    canvas.rotate(-1.57);
    tp2.paint(canvas, Offset.zero);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
