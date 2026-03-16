import 'package:flutter/material.dart';

/// Deep visual demo for showDialog function.
/// Shows a Material dialog.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('showDialog()', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 180,
            height: 100,
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
            child: const Center(child: Text('App Content', style: TextStyle(color: Colors.grey, fontSize: 10))),
          ),
          Container(
            width: 150,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 12)]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Dialog Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 8),
                const Text('Dialog content goes here.', style: TextStyle(fontSize: 10)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('CANCEL', style: TextStyle(color: Colors.grey.shade600, fontSize: 10)),
                    const SizedBox(width: 12),
                    const Text('OK', style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('barrierDismissible, barrierColor', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
