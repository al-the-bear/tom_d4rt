// D4rt test script: Tests ClipPathEngineLayer via SceneBuilder
// ClipPathEngineLayer clips child layers using arbitrary Path shapes
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                ClipPathEngineLayer - Deep Demo                     ║');
  print('║        SceneBuilder pushClipPath for Arbitrary Shape Clipping      ║');
  print('╚════════════════════════════════════════════════════════════════════╝');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ClipPathEngineLayer Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: ClipPathEngineLayer Fundamentals                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipPathEngineLayer is returned by SceneBuilder.pushClipPath().');
  print('');
  print('Purpose:');
  print('  - Clips all children within an arbitrary Path');
  print('  - Part of Flutter\'s compositing layer system');
  print('  - Used by ClipPath widget at the rendering level');
  print('');
  print('Key concepts:');
  print('  - SceneBuilder creates render tree for compositor');
  print('  - pushClipPath adds clipping layer');
  print('  - Child layers are masked by Path shape');
  print('  - pop() closes the clip layer');
  print('');
  print('Package: dart:ui');
  print('Related: ClipPath widget, CustomClipper<Path>');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: SceneBuilder.pushClipPath Signature
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: SceneBuilder.pushClipPath Signature                    │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Method signature:');
  print('');
  print('  ClipPathEngineLayer pushClipPath(');
  print('    Path path, {');
  print('    Clip clipBehavior = Clip.antiAlias,');
  print('    ClipPathEngineLayer? oldLayer,');
  print('  })');
  print('');
  print('Parameters:');
  print('  path: Path that defines the clip region');
  print('  clipBehavior: How to handle anti-aliasing');
  print('  oldLayer: Existing layer for reuse (performance)');
  print('');
  print('Returns: ClipPathEngineLayer handle');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Basic Usage
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: Basic Usage                                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final builder = ui.SceneBuilder();

  // Create a simple triangle path
  final trianglePath = Path()
    ..moveTo(50, 0)
    ..lineTo(100, 100)
    ..lineTo(0, 100)
    ..close();

  final layer1 = builder.pushClipPath(trianglePath);
  print('Basic pushClipPath:');
  print('  Returned type: ${layer1.runtimeType}');
  print('  Is EngineLayer: ${layer1 is ui.EngineLayer}');
  builder.pop();
  print('  Layer popped');
  print('');
  print('Triangle path:');
  print('  moveTo(50, 0)    // Top vertex');
  print('  lineTo(100, 100) // Bottom right');
  print('  lineTo(0, 100)   // Bottom left');
  print('  close()          // Close path');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Clip Behaviors
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: Clip Behaviors                                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Available clipBehavior values:');
  print('');

  // Clip.none
  print('Clip.none:');
  print('  - No clipping applied (fastest)');
  print('  - Content may extend beyond bounds');
  print('  - Use when overflow is acceptable');
  print('');

  // Clip.hardEdge
  final layer2 = builder.pushClipPath(trianglePath, clipBehavior: Clip.hardEdge);
  print('Clip.hardEdge:');
  print('  Layer: ${layer2.runtimeType}');
  print('  - Fastest clipping mode');
  print('  - Jagged/aliased edges');
  print('  - Good for solid color backgrounds');
  builder.pop();
  print('');

  // Clip.antiAlias (default)
  final layer3 = builder.pushClipPath(trianglePath, clipBehavior: Clip.antiAlias);
  print('Clip.antiAlias (default):');
  print('  Layer: ${layer3.runtimeType}');
  print('  - Smooth edges');
  print('  - Moderate performance');
  print('  - Good balance for most cases');
  builder.pop();
  print('');

  // Clip.antiAliasWithSaveLayer
  final layer4 = builder.pushClipPath(trianglePath, clipBehavior: Clip.antiAliasWithSaveLayer);
  print('Clip.antiAliasWithSaveLayer:');
  print('  Layer: ${layer4.runtimeType}');
  print('  - Best quality anti-aliasing');
  print('  - Slowest (creates offscreen buffer)');
  print('  - Required for semi-transparent content');
  builder.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Complex Path Shapes
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: Complex Path Shapes                                    │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // Circle
  final circlePath = Path()
    ..addOval(Rect.fromCircle(center: const Offset(50, 50), radius: 40));
  final circleLayer = builder.pushClipPath(circlePath);
  print('Circle clip:');
  print('  Path: addOval(Rect.fromCircle(center, radius))');
  print('  Layer: ${circleLayer.runtimeType}');
  builder.pop();
  print('');

  // Star shape
  final starPath = _createStarPath(5, 50, 25, const Offset(50, 50));
  final starLayer = builder.pushClipPath(starPath);
  print('Star clip (5 points):');
  print('  Custom path with outer/inner radius');
  print('  Layer: ${starLayer.runtimeType}');
  builder.pop();
  print('');

  // Combined shapes
  final combinedPath = Path()
    ..addOval(Rect.fromCircle(center: const Offset(50, 50), radius: 40))
    ..addRect(const Rect.fromLTWH(70, 10, 60, 80));
  final combinedLayer = builder.pushClipPath(combinedPath);
  print('Combined shapes:');
  print('  addOval(...) + addRect(...)');
  print('  Layer: ${combinedLayer.runtimeType}');
  print('  Note: Uses path fill type for overlap handling');
  builder.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Path Fill Types
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: Path Fill Types                                        │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Path fill type affects clipping of overlapping shapes:');
  print('');
  print('PathFillType.nonZero (default):');
  print('  - All enclosed areas are filled');
  print('  - Path direction matters');
  print('  - Good for most non-overlapping shapes');
  print('');
  print('PathFillType.evenOdd:');
  print('  - Alternating fill on overlaps');
  print('  - Creates holes in overlapping regions');
  print('  - Good for donut/ring shapes');
  print('');

  final ringPath = Path()
    ..fillType = PathFillType.evenOdd
    ..addOval(Rect.fromCircle(center: const Offset(50, 50), radius: 50))
    ..addOval(Rect.fromCircle(center: const Offset(50, 50), radius: 25));
  final ringLayer = builder.pushClipPath(ringPath);
  print('Ring/donut clip (evenOdd):');
  print('  Outer circle minus inner circle');
  print('  Layer: ${ringLayer.runtimeType}');
  builder.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: EngineLayer Hierarchy
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: EngineLayer Hierarchy                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipPathEngineLayer inheritance:');
  print('');
  print('  EngineLayer (abstract base)');
  print('    ├── ClipPathEngineLayer (arbitrary path)');
  print('    ├── ClipRRectEngineLayer (rounded rect)');
  print('    ├── ClipRectEngineLayer (axis-aligned rect)');
  print('    ├── OpacityEngineLayer');
  print('    ├── TransformEngineLayer');
  print('    ├── BackdropFilterEngineLayer');
  print('    ├── ColorFilterEngineLayer');
  print('    ├── ImageFilterEngineLayer');
  print('    └── ShaderMaskEngineLayer');
  print('');
  print('All implement dispose() from EngineLayer');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Layer Reuse (oldLayer parameter)
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: Layer Reuse (oldLayer parameter)                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Layer reuse optimization:');
  print('');
  print('  // First frame');
  print('  ClipPathEngineLayer? clipLayer;');
  print('');
  print('  void buildScene(SceneBuilder builder) {');
  print('    clipLayer = builder.pushClipPath(');
  print('      path,');
  print('      oldLayer: clipLayer, // Reuse if unchanged');
  print('    );');
  print('    builder.pop();');
  print('  }');
  print('');
  print('Benefits:');
  print('  - Avoids recreating layer objects');
  print('  - Reduces GC pressure');
  print('  - Compositor can optimize unchanged layers');
  print('');
  print('When to pass null:');
  print('  - First frame (no previous layer)');
  print('  - Path changed significantly');
  print('  - Clip behavior changed');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Integration with Flutter Widgets
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: Integration with Flutter Widgets                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipPath widget uses ClipPathEngineLayer internally:');
  print('');
  print('  ClipPath(');
  print('    clipper: MyCustomClipper(), // CustomClipper<Path>');
  print('    clipBehavior: Clip.antiAlias,');
  print('    child: Container(...),');
  print('  )');
  print('');
  print('Under the hood:');
  print('  1. RenderClipPath gets the path from clipper');
  print('  2. In paint(), it calls pushClipPath on PaintingContext');
  print('  3. PaintingContext delegates to SceneBuilder');
  print('  4. ClipPathEngineLayer is created');
  print('');
  print('Custom clipper example:');
  print('  class TriangleClipper extends CustomClipper<Path> {');
  print('    @override');
  print('    Path getClip(Size size) {');
  print('      return Path()');
  print('        ..moveTo(size.width / 2, 0)');
  print('        ..lineTo(size.width, size.height)');
  print('        ..lineTo(0, size.height)');
  print('        ..close();');
  print('    }');
  print('  }');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: ShapeBorder Clipping
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: ShapeBorder Clipping                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipPath with ShapeBorderClipper:');
  print('');
  print('  ClipPath.shape(');
  print('    shape: BeveledRectangleBorder(');
  print('      borderRadius: BorderRadius.circular(20),');
  print('    ),');
  print('    child: Image.asset("photo.jpg"),');
  print('  )');
  print('');
  print('Supported shapes:');
  print('  - CircleBorder');
  print('  - RoundedRectangleBorder');
  print('  - BeveledRectangleBorder');
  print('  - ContinuousRectangleBorder');
  print('  - StadiumBorder');
  print('  - StarBorder');
  print('  - Custom OutlinedBorder');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Performance Considerations
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 11: Performance Considerations                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Performance ranking (fastest to slowest):');
  print('  1. ClipRectEngineLayer (axis-aligned rect)');
  print('  2. ClipRRectEngineLayer (rounded rect)');
  print('  3. ClipPathEngineLayer (arbitrary path)');
  print('');
  print('Within ClipPath, by clipBehavior:');
  print('  1. Clip.none (no clipping)');
  print('  2. Clip.hardEdge (aliased)');
  print('  3. Clip.antiAlias (smooth)');
  print('  4. Clip.antiAliasWithSaveLayer (offscreen buffer)');
  print('');
  print('Tips:');
  print('  - Use ClipRect when axis-aligned is sufficient');
  print('  - Use ClipRRect for rounded rectangles');
  print('  - Reserve ClipPath for truly complex shapes');
  print('  - Cache Path objects when possible');
  print('  - Use Clip.hardEdge on solid backgrounds');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Nested Clipping
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 12: Nested Clipping                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('SceneBuilder supports nested clip layers:');
  print('');

  final builder2 = ui.SceneBuilder();
  final outerPath = Path()..addRect(const Rect.fromLTWH(0, 0, 200, 200));
  final innerPath = Path()..addOval(const Rect.fromLTWH(50, 50, 100, 100));

  builder2.pushClipPath(outerPath);
  print('  Pushed outer path (rect)');
  builder2.pushClipPath(innerPath);
  print('  Pushed inner path (oval)');
  print('  → Visible region is intersection');
  builder2.pop();
  print('  Popped inner');
  builder2.pop();
  print('  Popped outer');
  print('');
  print('Effective clip = intersection of all layers');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Animated Clip Paths
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 13: Animated Clip Paths                                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Animating clip paths:');
  print('');
  print('class AnimatedClipPath extends StatefulWidget {');
  print('  @override');
  print('  State createState() => _AnimatedClipPathState();');
  print('}');
  print('');
  print('class _AnimatedClipPathState extends State<AnimatedClipPath>');
  print('    with SingleTickerProviderStateMixin {');
  print('  late AnimationController _controller;');
  print('');
  print('  @override');
  print('  Widget build(BuildContext context) {');
  print('    return AnimatedBuilder(');
  print('      animation: _controller,');
  print('      builder: (context, child) {');
  print('        return ClipPath(');
  print('          clipper: _AnimatedClipper(_controller.value),');
  print('          child: child,');
  print('        );');
  print('      },');
  print('      child: const MyContent(),');
  print('    );');
  print('  }');
  print('}');
  print('');
  print('Note: Ensure shouldReclip returns true when animating');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Common Patterns
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 14: Common Patterns                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Wave clip (for app bars):');
  print('  Path()');
  print('    ..lineTo(0, height - curve)');
  print('    ..quadraticBezierTo(width / 2, height + curve, width, height - curve)');
  print('    ..lineTo(width, 0)');
  print('    ..close()');
  print('');
  print('Diagonal clip:');
  print('  Path()');
  print('    ..lineTo(0, height)');
  print('    ..lineTo(width, height - diagonal)');
  print('    ..lineTo(width, 0)');
  print('    ..close()');
  print('');
  print('Rounded corners (asymmetric):');
  print('  Path()');
  print('    ..addRRect(RRect.fromRectAndCorners(');
  print('      rect,');
  print('      topLeft: Radius.circular(20),');
  print('      bottomRight: Radius.circular(50),');
  print('    ))');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 15: Summary                                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipPathEngineLayer summary:');
  print('');
  print('┌────────────────────────┬───────────────────────────────────────────┐');
  print('│ Aspect                 │ Details                                   │');
  print('├────────────────────────┼───────────────────────────────────────────┤');
  print('│ Created by             │ SceneBuilder.pushClipPath()               │');
  print('│ Clip shape             │ Arbitrary Path                            │');
  print('│ Default behavior       │ Clip.antiAlias                            │');
  print('│ Widget equivalent      │ ClipPath                                  │');
  print('│ Performance            │ Slower than ClipRect/ClipRRect            │');
  print('└────────────────────────┴───────────────────────────────────────────┘');
  print('');
  print('Key points:');
  print('  1. Most flexible clip type (any Path shape)');
  print('  2. Part of EngineLayer hierarchy');
  print('  3. clipBehavior controls quality/performance');
  print('  4. Use oldLayer for frame-to-frame reuse');
  print('  5. Clips intersect when nested');
  print('');
  print('Choose appropriate clip type:');
  print('  - Rect → ClipRectEngineLayer (fastest)');
  print('  - RRect → ClipRRectEngineLayer');
  print('  - Complex shape → ClipPathEngineLayer');
  print('');
  print('═══════════════════════════════════════════════════════════════════════');
  print('ClipPathEngineLayer deep demo completed');

  // Clean up
  builder.build().dispose();
  builder2.build().dispose();

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
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange.shade700,
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

// Helper to create star path
Path _createStarPath(int points, double outerRadius, double innerRadius, Offset center) {
  final path = Path();
  final step = (2 * 3.14159) / points;
  final halfStep = step / 2;

  path.moveTo(center.dx, center.dy - outerRadius);

  for (int i = 0; i < points; i++) {
    final angle = -3.14159 / 2 + step * i;
    path.lineTo(
      center.dx + innerRadius * (angle + halfStep < 0 ? -1 : 1) * 0.7,
      center.dy + innerRadius * (angle + halfStep < 0 ? -0.7 : 0.7),
    );
    path.lineTo(
      center.dx + outerRadius * 0.8,
      center.dy + outerRadius * 0.2 * (i + 1),
    );
  }
  path.close();
  return path;
}

// Helper widget for clip behavior cards
class _ClipBehaviorCard extends StatelessWidget {
  final String name;
  final String description;
  final String speed;
  final Color color;

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

  const _ShapeDemo({
    required this.icon,
    required this.name,
  });

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
