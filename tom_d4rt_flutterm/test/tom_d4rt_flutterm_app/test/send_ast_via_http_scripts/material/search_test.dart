import 'package:flutter/material.dart';

/// Deep visual demo for showSearch function.
/// Shows a full screen search page.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('showSearch()', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 15,
                  color: Colors.blue,
                  child: const Row(mainAxisAlignment: MainAxisAlignment.end, children: [Icon(Icons.search, color: Colors.white, size: 10)]),
                ),
                const Expanded(child: Center(child: Text('App', style: TextStyle(fontSize: 8)))),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.arrow_forward, color: Colors.grey, size: 16),
          const SizedBox(width: 12),
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Container(
                  height: 18,
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white, size: 8),
                      SizedBox(width: 4),
                      Expanded(child: Text('Query', style: TextStyle(color: Colors.white70, fontSize: 6))),
                    ],
                  ),
                ),
                const Expanded(child: Center(child: Text('Results', style: TextStyle(fontSize: 7, color: Colors.grey)))),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('delegate: SearchDelegate<T>', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
