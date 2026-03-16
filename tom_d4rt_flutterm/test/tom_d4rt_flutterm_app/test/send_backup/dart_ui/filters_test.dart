import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ColorFilter - color transformation filters.
/// Demonstrates mode, matrix, linearToSrgbGamma, and srgbToLinearGamma.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ColorFilter Demo')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Color Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildFilterDemo('Original', null),
        _buildFilterDemo('mode(blue, multiply)', ColorFilter.mode(Colors.blue.withValues(alpha: 0.5), BlendMode.multiply)),
        _buildFilterDemo('mode(red, colorBurn)', ColorFilter.mode(Colors.red.withValues(alpha: 0.5), BlendMode.colorBurn)),
        _buildFilterDemo('Grayscale matrix', const ColorFilter.matrix([
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 1, 0,
        ])),
        _buildFilterDemo('Invert matrix', const ColorFilter.matrix([
          -1, 0, 0, 0, 255,
          0, -1, 0, 0, 255,
          0, 0, -1, 0, 255,
          0, 0, 0, 1, 0,
        ])),
        _buildFilterDemo('linearToSrgbGamma', const ColorFilter.linearToSrgbGamma()),
        _buildFilterDemo('srgbToLinearGamma', const ColorFilter.srgbToLinearGamma()),
      ],
    ),
  );
}

Widget _buildFilterDemo(String label, ColorFilter? filter) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        ColorFiltered(
          colorFilter: filter ?? const ColorFilter.mode(Colors.transparent, BlendMode.dst),
          child: Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.yellow, Colors.green, Colors.blue],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
      ],
    ),
  );
}
