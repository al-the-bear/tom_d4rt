// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// Deep visual demo for fade forward page transition.
/// Shows the fade + slide up animation style.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Fade Forwards Transition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Before state
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.article, size: 24, color: Colors.blue),
                const SizedBox(height: 4),
                const Text('Page A', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          // Arrow
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Icon(Icons.arrow_forward, color: Colors.grey),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(4)),
                  child: const Text('Fade\nUp', textAlign: TextAlign.center, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          // After state
          Stack(
            children: [
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.settings, size: 24, color: Colors.green),
                    const SizedBox(height: 4),
                    const Text('Page B', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text('Android/Linux default transition', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}
