// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ClipPathEngineLayer via SceneBuilder
// ClipPathEngineLayer clips child layers using arbitrary Path shapes
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // Return visual UI demonstrating clip path concepts
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.amber.shade50, Colors.orange.shade50],
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
            color: Colors.orange.shade700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.pentagon_outlined, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ClipPathEngineLayer',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Arbitrary Path Clipping',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Clip behaviors
        Text(
          'Clip Behaviors',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _ClipBehaviorCard(
              name: 'none',
              description: 'No clip',
              speed: '★★★★',
              color: Colors.grey,
            ),
            const SizedBox(width: 6),
            _ClipBehaviorCard(
              name: 'hardEdge',
              description: 'Aliased',
              speed: '★★★☆',
              color: Colors.blue,
            ),
            const SizedBox(width: 6),
            _ClipBehaviorCard(
              name: 'antiAlias',
              description: 'Smooth',
              speed: '★★☆☆',
              color: Colors.green,
            ),
            const SizedBox(width: 6),
            _ClipBehaviorCard(
              name: 'saveLayer',
              description: 'Best',
              speed: '★☆☆☆',
              color: Colors.purple,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Example shapes
        Text(
          'Example Path Shapes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _ShapeDemo(icon: Icons.change_history, name: 'Triangle'),
            const SizedBox(width: 8),
            _ShapeDemo(icon: Icons.circle_outlined, name: 'Circle'),
            const SizedBox(width: 8),
            _ShapeDemo(icon: Icons.star_outline, name: 'Star'),
            const SizedBox(width: 8),
            _ShapeDemo(icon: Icons.waves, name: 'Wave'),
          ],
        ),
        const SizedBox(height: 16),

        // Widget integration
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flutter Widget Integration',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'ClipPath widget → RenderClipPath → SceneBuilder.pushClipPath() → ClipPathEngineLayer',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange.shade600, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Most flexible clip type • Any Path shape • Use for complex custom shapes',
                  style: TextStyle(fontSize: 12, color: Colors.orange.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget for clip behavior cards
class _ClipBehaviorCard extends StatelessWidget {
  final String name;
  final String description;
  final String speed;
  final MaterialColor color;

  const _ClipBehaviorCard({
    required this.name,
    required this.description,
    required this.speed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.shade300),
        ),
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color.shade700,
              ),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 8, color: color.shade600),
            ),
            const SizedBox(height: 2),
            Text(
              speed,
              style: TextStyle(fontSize: 9, color: Colors.amber.shade700),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget for shape demos
class _ShapeDemo extends StatelessWidget {
  final IconData icon;
  final String name;

  const _ShapeDemo({required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Colors.orange.shade600),
            const SizedBox(height: 4),
            Text(
              name,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
