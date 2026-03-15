import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ClipRectEngineLayer - rectangular clipping.
/// Demonstrates simple rectangular clip bounds.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ClipRectEngineLayer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Rectangular Clipping', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: Stack(
              children: [
                // Full image
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade200, Colors.purple.shade200, Colors.pink.shade200],
                    ),
                  ),
                  child: const Center(
                    child: Text('Original Content', style: TextStyle(fontSize: 24, color: Colors.white70)),
                  ),
                ),
                // Clipped overlay
                Center(
                  child: ClipRect(
                    child: Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: Container(
                        color: Colors.black54,
                        child: const Center(
                          child: Text('Clipped Region', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Row(
              children: [
                Icon(Icons.crop, color: Colors.blue),
                SizedBox(width: 12),
                Expanded(child: Text('ClipRectEngineLayer clips to a rectangular bounds')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
