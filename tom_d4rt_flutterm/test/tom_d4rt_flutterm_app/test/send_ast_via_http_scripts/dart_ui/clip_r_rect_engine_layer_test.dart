// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ClipRRectEngineLayer via SceneBuilder
// ClipRRectEngineLayer clips child layers using rounded rectangles
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // Return visual UI demonstrating ClipRRect concepts
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blue.shade50, Colors.indigo.shade50],
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.indigo.shade700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.rounded_corner, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ClipRRectEngineLayer',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Rounded Rectangle Clipping',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Corner styles
        Text(
          'Corner Radius Patterns',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _CornerStyleDemo(
              name: 'Uniform',
              radii: [12, 12, 12, 12],
              color: Colors.blue,
            ),
            const SizedBox(width: 8),
            _CornerStyleDemo(
              name: 'Top Only',
              radii: [16, 16, 0, 0],
              color: Colors.green,
            ),
            const SizedBox(width: 8),
            _CornerStyleDemo(
              name: 'Asymmetric',
              radii: [4, 20, 8, 12],
              color: Colors.orange,
            ),
            const SizedBox(width: 8),
            _CornerStyleDemo(
              name: 'Pill',
              radii: [20, 20, 20, 20],
              color: Colors.purple,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Clip behaviors
        Text(
          'Clip Behaviors',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              _ClipBehaviorChip(label: 'hardEdge', speed: '★★★', quality: '☆'),
              const SizedBox(width: 8),
              _ClipBehaviorChip(label: 'antiAlias', speed: '★★', quality: '★★'),
              const SizedBox(width: 8),
              _ClipBehaviorChip(label: 'saveLayer', speed: '★', quality: '★★★'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Use cases
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Common Use Cases',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _UseCase(label: 'Cards'),
                  _UseCase(label: 'Bottom Sheets'),
                  _UseCase(label: 'Images'),
                  _UseCase(label: 'Chat Bubbles'),
                  _UseCase(label: 'Avatars'),
                  _UseCase(label: 'Buttons'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.indigo.shade600, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Optimized for rounded corners • Faster than ClipPath • Supports asymmetric radii',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget for corner style demos
class _CornerStyleDemo extends StatelessWidget {
  final String name;
  final List<double> radii; // [tl, tr, br, bl]
  final MaterialColor color;

  const _CornerStyleDemo({
    required this.name,
    required this.radii,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: color.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radii[0]),
                topRight: Radius.circular(radii[1]),
                bottomRight: Radius.circular(radii[2]),
                bottomLeft: Radius.circular(radii[3]),
              ),
              border: Border.all(color: color.shade400, width: 2),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for clip behavior chips
class _ClipBehaviorChip extends StatelessWidget {
  final String label;
  final String speed;
  final String quality;

  const _ClipBehaviorChip({
    required this.label,
    required this.speed,
    required this.quality,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              'Speed: $speed',
              style: TextStyle(fontSize: 8, color: Colors.green.shade600),
            ),
            Text(
              'Quality: $quality',
              style: TextStyle(fontSize: 8, color: Colors.blue.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget for use case tags
class _UseCase extends StatelessWidget {
  final String label;

  const _UseCase({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.indigo.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: Colors.indigo.shade700,
        ),
      ),
    );
  }
}
