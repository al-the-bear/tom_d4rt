import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for BackdropFilterEngineLayer - blur effects on content behind.
/// Demonstrates backdrop blur filter applied to underlying layers.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('BackdropFilterEngineLayer Demo')),
    body: Stack(
      children: [
        // Background with colorful pattern
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
          itemCount: 50,
          itemBuilder: (context, i) => Container(
            color: Colors.primaries[i % Colors.primaries.length].withValues(alpha: 0.7),
            child: Center(child: Text('$i', style: const TextStyle(color: Colors.white))),
          ),
        ),
        // Backdrop filter overlay
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 280,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.blur_on, size: 48, color: Colors.white),
                    const SizedBox(height: 16),
                    const Text(
                      'BackdropFilterEngineLayer',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Applies blur filter to content behind this layer',
                      style: TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('sigmaX: 10, sigmaY: 10', style: TextStyle(fontFamily: 'monospace', color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
