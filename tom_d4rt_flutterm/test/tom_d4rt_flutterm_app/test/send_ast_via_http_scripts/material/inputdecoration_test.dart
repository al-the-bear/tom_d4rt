import 'package:flutter/material.dart';

/// Deep visual demo for InputDecoration.
/// Shows how to customize TextField appearance with labels, icons, borders.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('InputDecoration Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      // With label and border
      Container(
        width: 220,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email', style: TextStyle(fontSize: 10, color: Colors.blue.shade700)),
            const SizedBox(height: 4),
            Row(
              children: const [
                Expanded(child: Text('user@example.com', style: TextStyle(fontSize: 14))),
                Icon(Icons.email, color: Colors.grey, size: 20),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      // With prefix and suffix
      Container(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: const [
            Icon(Icons.attach_money, color: Colors.green, size: 18),
            Expanded(child: Text('100.00', style: TextStyle(fontSize: 14))),
            Text('USD', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('label, hint, prefix, suffix, icon, border', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}
