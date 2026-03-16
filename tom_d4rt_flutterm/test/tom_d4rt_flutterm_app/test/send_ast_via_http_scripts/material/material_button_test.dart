import 'package:flutter/material.dart';

/// Deep visual demo for MaterialButton widget (deprecated).
/// Shows basic Material button. Use TextButton, ElevatedButton, etc. instead.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MaterialButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(4)),
        child: const Text('⚠️ Deprecated', style: TextStyle(fontSize: 10, color: Colors.orange)),
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Basic MaterialButton
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
            child: const Text('BUTTON', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          const SizedBox(width: 16),
          // Colored
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)),
            child: const Text('COLORED', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
      const SizedBox(height: 16),
      const Text('Use ElevatedButton, TextButton instead', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
