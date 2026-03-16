import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ImageFilterEngineLayer - image filter in layer tree.
/// Demonstrates blur and matrix filters applied to layers.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ImageFilterEngineLayer Demo')),
    body: Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // Background pattern
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
                itemCount: 36,
                itemBuilder: (_, i) => Container(color: Colors.primaries[i % Colors.primaries.length]),
              ),
              // Blur filter demonstration
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      width: 220,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text('ImageFilter.blur', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Available Filters:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• ImageFilter.blur(sigmaX, sigmaY)'),
              Text('• ImageFilter.matrix(matrix4)'),
              Text('• ImageFilter.compose(outer, inner)'),
            ],
          ),
        ),
      ],
    ),
  );
}
