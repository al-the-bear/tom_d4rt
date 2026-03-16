import 'package:flutter/material.dart';

/// Deep visual demo for Icon widget.
/// Shows icons with different sizes and colors.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Icon Widget', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.star, size: 18, color: Colors.grey),
          SizedBox(width: 8),
          Icon(Icons.star, size: 24, color: Colors.blue),
          SizedBox(width: 8),
          Icon(Icons.star, size: 32, color: Colors.amber),
          SizedBox(width: 8),
          Icon(Icons.star, size: 40, color: Colors.orange),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('18', style: TextStyle(fontSize: 9)),
          SizedBox(width: 20),
          Text('24', style: TextStyle(fontSize: 9)),
          SizedBox(width: 20),
          Text('32', style: TextStyle(fontSize: 9)),
          SizedBox(width: 20),
          Text('40', style: TextStyle(fontSize: 9)),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
        child: const Text('Icon(Icons.star, size: 24, color: ...)', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
      ),
    ],
  );
}
