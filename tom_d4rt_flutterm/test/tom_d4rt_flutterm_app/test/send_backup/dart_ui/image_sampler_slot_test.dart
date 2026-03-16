import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for ImageSamplerSlot - shader texture sampling slot.
/// Demonstrates binding images to shader uniform slots.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ImageSamplerSlot Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Image Sampler Slots', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Bind textures to shader programs', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildSlotDiagram(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Usage in Shader:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('shader.setImageSampler(0, image);', style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
                SizedBox(height: 4),
                Text('// Texture now available at slot 0', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildSlotDiagram() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSlot(0, 'Texture A', true),
        _buildSlot(1, 'Texture B', true),
        _buildSlot(2, 'Empty', false),
        _buildSlot(3, 'Texture C', true),
      ],
    ),
  );
}

Widget _buildSlot(int index, String label, bool filled) {
  return Column(
    children: [
      Container(
        width: 60, height: 60,
        decoration: BoxDecoration(
          color: filled ? Colors.purple.withValues(alpha: 0.2) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: filled ? Colors.purple : Colors.grey.shade400),
        ),
        child: Center(child: Icon(filled ? Icons.image : Icons.add_photo_alternate, color: filled ? Colors.purple : Colors.grey)),
      ),
      const SizedBox(height: 8),
      Text('Slot $index', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
    ],
  );
}
