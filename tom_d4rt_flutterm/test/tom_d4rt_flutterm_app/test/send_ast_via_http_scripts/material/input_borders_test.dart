import 'package:flutter/material.dart';

/// Deep visual demo for InputBorder types.
/// Shows OutlineInputBorder and UnderlineInputBorder.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('InputBorder Types', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      // Outline
      Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: Colors.white,
              child: const Text('Label', style: TextStyle(fontSize: 10, color: Colors.blue)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 4),
      const Text('OutlineInputBorder', style: TextStyle(fontSize: 10, color: Colors.grey)),
      const SizedBox(height: 16),
      // Underline
      Container(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Label', style: TextStyle(fontSize: 10, color: Colors.blue)),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Text('Input text', style: TextStyle(fontSize: 14)),
            ),
            Container(height: 2, color: Colors.blue),
          ],
        ),
      ),
      const SizedBox(height: 4),
      const Text('UnderlineInputBorder', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}
