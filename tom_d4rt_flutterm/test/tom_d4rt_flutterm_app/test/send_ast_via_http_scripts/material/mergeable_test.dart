import 'package:flutter/material.dart';

/// Deep visual demo for MergeableMaterial widget.
/// Displays list of items that merge and separate.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('MergeableMaterial', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Container(color: Colors.white, padding: const EdgeInsets.all(12), child: const Text('Item 1', style: TextStyle(fontSize: 12))),
              Container(color: Colors.white, padding: const EdgeInsets.all(12), child: const Text('Item 2', style: TextStyle(fontSize: 12))),
              Container(height: 8, color: Colors.grey.shade200),
              Container(color: Colors.white, padding: const EdgeInsets.all(12), child: const Text('Item 3 (separated)', style: TextStyle(fontSize: 12))),
            ],
          ),
        ),
      ),
      const SizedBox(height: 12),
      const Text('Slices merge, gaps separate', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
