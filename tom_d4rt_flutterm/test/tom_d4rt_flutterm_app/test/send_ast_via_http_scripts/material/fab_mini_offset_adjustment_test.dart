import 'package:flutter/material.dart';

/// Deep visual demo for FAB mini offset adjustment.
/// Shows size difference between regular and mini FAB.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Mini FAB Offset', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(color: Colors.pink, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)]),
                child: const Icon(Icons.add, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text('Regular (56)', style: TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(width: 32),
          Column(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: Colors.pink, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)]),
                child: const Icon(Icons.add, color: Colors.white, size: 18),
              ),
              const SizedBox(height: 8),
              const Text('Mini (40)', style: TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
        child: const Text('Offset adjusted by -8dp for mini', style: TextStyle(fontSize: 10)),
      ),
    ],
  );
}
