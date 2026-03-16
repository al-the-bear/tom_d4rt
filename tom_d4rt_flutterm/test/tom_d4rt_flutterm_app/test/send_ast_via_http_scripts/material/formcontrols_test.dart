import 'package:flutter/material.dart';

/// Deep visual demo for Form controls in Material.
/// Shows various form input widgets.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Form Controls', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          children: [
            // TextField
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
              child: Row(children: const [Expanded(child: Text('Username', style: TextStyle(color: Colors.grey))), Icon(Icons.person, size: 18, color: Colors.grey)]),
            ),
            const SizedBox(height: 12),
            // Checkbox
            Row(children: [
              Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.check, size: 14, color: Colors.white)),
              const SizedBox(width: 8),
              const Text('Remember me', style: TextStyle(fontSize: 12)),
            ]),
            const SizedBox(height: 12),
            // Radio
            Row(children: [
              Container(width: 20, height: 20, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.blue, width: 2)),
                child: Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)))),
              const SizedBox(width: 8),
              const Text('Option A', style: TextStyle(fontSize: 12)),
            ]),
          ],
        ),
      ),
    ],
  );
}
