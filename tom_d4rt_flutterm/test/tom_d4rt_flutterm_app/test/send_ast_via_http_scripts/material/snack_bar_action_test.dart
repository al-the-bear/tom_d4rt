import 'package:flutter/material.dart';

/// Deep visual demo for SnackBarAction widget.
/// Action button displayed in a SnackBar.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SnackBarAction', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            const Expanded(child: Text('Item deleted', style: TextStyle(color: Colors.white, fontSize: 12))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              child: const Text('UNDO', style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
        child: const Column(
          children: [
            Text('Properties:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('label: String', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
            Text('onPressed: VoidCallback', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
            Text('textColor: Color?', style: TextStyle(fontFamily: 'monospace', fontSize: 9)),
          ],
        ),
      ),
    ],
  );
}
