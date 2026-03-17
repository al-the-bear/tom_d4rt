// D4rt test script: Tests ClipOp from dart_ui
// ClipOp defines operations for combining clip regions on Canvas
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                      ClipOp - Deep Demo                            ║');
  print('║           Canvas Clip Region Combination Operations                ║');
  print('╚════════════════════════════════════════════════════════════════════╝');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ClipOp Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: ClipOp Fundamentals                                    │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipOp is an enum defining how to combine clip regions.');
  print('');
  print('Purpose:');
  print('  - Specify how a new clip combines with existing clip');
  print('  - Used in Canvas.clipRect, clipPath methods');
  print('  - Controls which parts remain visible after clipping');
  print('');
  print('Concept:');
  print('  When you clip, you define a region where drawing is allowed.');
  print('  ClipOp determines whether to:');
  print('    - Keep only the intersection (intersect)');
  print('    - Keep everything except the new clip (difference)');
  print('');
  print('Package: dart:ui');
  print('Used by: Canvas (clipRect, clipPath, clipRRect)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All ClipOp Values
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: All ClipOp Values                                      │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipOp enum values:');
  for (final op in ui.ClipOp.values) {
    print('  [${op.index}] ${op.name}: $op');
  }
  print('');
  print('Total values: ${ui.ClipOp.values.length}');
  print('');
  final first = ui.ClipOp.values.first;
  final last = ui.ClipOp.values.last;
  print('First value: $first (index: ${first.index})');
  print('Last value: $last (index: ${last.index})');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ClipOp.intersect
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: ClipOp.intersect                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const intersect = ui.ClipOp.intersect;
  print('ClipOp.intersect:');
  print('  - Name: ${intersect.name}');
  print('  - Index: ${intersect.index}');
  print('');
  print('Behavior:');
  print('  New clip region = intersection of existing and new clip');
  print('  Only areas inside BOTH clips remain visible');
  print('');
  print('Visual example:');
  print('  ┌──────────┐       ┌──────────┐');
  print('  │ Existing │       │          │');
  print('  │   clip   │  ∩    │ New clip │  =  ▓▓▓▓ (intersection)');
  print('  │          │       │          │');
  print('  └──────────┘       └──────────┘');
  print('');
  print('Result: Smaller visible area (most restrictive)');
  print('');
  print('This is the DEFAULT operation when not specified.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: ClipOp.difference
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: ClipOp.difference                                      │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const difference = ui.ClipOp.difference;
  print('ClipOp.difference:');
  print('  - Name: ${difference.name}');
  print('  - Index: ${difference.index}');
  print('');
  print('Behavior:');
  print('  New clip region = existing clip MINUS new clip');
  print('  Creates a "hole" where the new clip is');
  print('');
  print('Visual example:');
  print('  ┌──────────┐       ┌────┐');
  print('  │▓▓▓▓▓▓▓▓▓▓│       │    │         ┌──────────┐');
  print('  │▓▓Existing▓▓│  -  │New │   =     │▓▓▓▓▓▓▓▓▓▓│');
  print('  │▓▓▓▓▓▓▓▓▓▓│       │clip│         │▓▓    ▓▓▓▓│');
  print('  └──────────┘       └────┘         └──────────┘');
  print('');
  print('Result: Creates cutout/hole in visible area');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Canvas.clipRect with ClipOp
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: Canvas.clipRect with ClipOp                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Canvas.clipRect signature:');
  print('  void clipRect(');
  print('    Rect rect, {');
  print('    ClipOp clipOp = ClipOp.intersect, // Default');
  print('    bool doAntiAlias = true,');
  print('  })');
  print('');
  print('Example - intersect (restrict):');
  print('  canvas.clipRect(Rect.fromLTWH(0, 0, 100, 100));');
  print('  canvas.clipRect(');
  print('    Rect.fromLTWH(50, 50, 100, 100),');
  print('    clipOp: ClipOp.intersect, // Default');
  print('  );');
  print('  // Now only 50x50 area (intersection) is visible');
  print('');
  print('Example - difference (cutout):');
  print('  canvas.clipRect(Rect.fromLTWH(0, 0, 200, 200));');
  print('  canvas.clipRect(');
  print('    Rect.fromLTWH(50, 50, 100, 100),');
  print('    clipOp: ClipOp.difference,');
  print('  );');
  print('  // Now drawing in center is invisible (hole)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Canvas.clipPath with ClipOp
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: Canvas.clipPath with ClipOp                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Canvas.clipPath signature:');
  print('  void clipPath(');
  print('    Path path, {');
  print('    bool doAntiAlias = true,');
  print('  })');
  print('');
  print('Note: clipPath does NOT have a clipOp parameter!');
  print('It always uses ClipOp.intersect behavior.');
  print('');
  print('To achieve difference with paths:');
  print('  - Use PathOperation.difference to create cutout path');
  print('  - Then clipPath with the result');
  print('');
  print('Example:');
  print('  final outer = Path()..addRect(Rect.fromLTWH(0, 0, 200, 200));');
  print('  final inner = Path()..addOval(Rect.fromCircle(...));');
  print('  final cutout = Path.combine(');
  print('    PathOperation.difference,');
  print('    outer,');
  print('    inner,');
  print('  );');
  print('  canvas.clipPath(cutout);');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Canvas.clipRRect with ClipOp
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: Canvas.clipRRect with ClipOp                           │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Canvas.clipRRect signature:');
  print('  void clipRRect(');
  print('    RRect rrect, {');
  print('    bool doAntiAlias = true,');
  print('  })');
  print('');
  print('Note: Like clipPath, clipRRect does NOT have clipOp parameter.');
  print('Always intersects with existing clip region.');
  print('');
  print('For rounded rectangle cutouts:');
  print('  Use clipRect with difference, then clipRRect');
  print('  Or use Path with RRect and PathOperation.difference');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: Practical Use Cases                                    │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipOp.intersect use cases:');
  print('  - Viewport clipping (show only part of content)');
  print('  - Image cropping');
  print('  - Nested clip regions');
  print('  - Scroll view content clipping');
  print('');
  print('ClipOp.difference use cases:');
  print('  - Donut shapes (ring)');
  print('  - Window cutouts');
  print('  - Reveal animations (spotlight)');
  print('  - Custom shaped holes');
  print('  - Notification badges with cutouts');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: CustomPainter Example - Intersect
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: CustomPainter Example - Intersect                      │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('class IntersectClipPainter extends CustomPainter {');
  print('  @override');
  print('  void paint(Canvas canvas, Size size) {');
  print('    // First clip: left half');
  print('    canvas.clipRect(');
  print('      Rect.fromLTWH(0, 0, size.width / 2, size.height),');
  print('    );');
  print('');
  print('    // Second clip: top half (intersect is default)');
  print('    canvas.clipRect(');
  print('      Rect.fromLTWH(0, 0, size.width, size.height / 2),');
  print('      clipOp: ClipOp.intersect,');
  print('    );');
  print('');
  print('    // Only top-left quarter is now visible');
  print('    canvas.drawPaint(Paint()..color = Colors.blue);');
  print('  }');
  print('}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: CustomPainter Example - Difference
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: CustomPainter Example - Difference                    │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('class DonutPainter extends CustomPainter {');
  print('  @override');
  print('  void paint(Canvas canvas, Size size) {');
  print('    final outerRect = Rect.fromLTWH(10, 10, 180, 180);');
  print('    final innerRect = Rect.fromLTWH(50, 50, 100, 100);');
  print('');
  print('    // Clip to outer rect');
  print('    canvas.clipRect(outerRect);');
  print('');
  print('    // Cut out inner rect');
  print('    canvas.clipRect(innerRect, clipOp: ClipOp.difference);');
  print('');
  print('    // Drawing now shows a frame/donut shape');
  print('    canvas.drawPaint(Paint()..color = Colors.red);');
  print('  }');
  print('}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Spotlight/Reveal Effect
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 11: Spotlight/Reveal Effect                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Creating spotlight reveal animation:');
  print('');
  print('class SpotlightPainter extends CustomPainter {');
  print('  final Offset center;');
  print('  final double radius;');
  print('');
  print('  @override');
  print('  void paint(Canvas canvas, Size size) {');
  print('    // Draw overlay');
  print('    final fullRect = Offset.zero & size;');
  print('    final spotRect = Rect.fromCircle(');
  print('      center: center,');
  print('      radius: radius,');
  print('    );');
  print('');
  print('    // Clip full canvas');
  print('    canvas.clipRect(fullRect);');
  print('');
  print('    // Cut out spotlight (difference)');
  print('    canvas.clipRect(spotRect, clipOp: ClipOp.difference);');
  print('');
  print('    // Draw dark overlay (spotlight area excluded)');
  print('    canvas.drawPaint(');
  print('      Paint()..color = Colors.black.withOpacity(0.7),');
  print('    );');
  print('  }');
  print('}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Save/Restore with Clips
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 12: Save/Restore with Clips                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Clip operations accumulate. Use save/restore:');
  print('');
  print('void paint(Canvas canvas, Size size) {');
  print('  // Save current clip state');
  print('  canvas.save();');
  print('');
  print('  // Apply first clip');
  print('  canvas.clipRect(rect1);');
  print('  canvas.drawRect(rect1, paint1);');
  print('');
  print('  // Restore original clip');
  print('  canvas.restore();');
  print('');
  print('  // Now no clip is active');
  print('  canvas.save();');
  print('  canvas.clipRect(rect2);');
  print('  canvas.drawRect(rect2, paint2);');
  print('  canvas.restore();');
  print('}');
  print('');
  print('Without save/restore:');
  print('  - Clips stack (intersect compounds)');
  print('  - Visible area shrinks with each clip');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Performance Considerations
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 13: Performance Considerations                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Clipping performance tips:');
  print('');
  print('1. Clip complexity matters:');
  print('   - clipRect: Fast (axis-aligned)');
  print('   - clipRRect: Moderate');
  print('   - clipPath: Slower (arbitrary shapes)');
  print('');
  print('2. Anti-aliasing:');
  print('   - doAntiAlias: true → smoother edges, slower');
  print('   - doAntiAlias: false → faster, jagged edges');
  print('');
  print('3. Difference is more expensive:');
  print('   - Requires inverse rendering');
  print('   - Consider using PathOperation instead');
  print('');
  print('4. Avoid excessive nesting:');
  print('   - Combine clips when possible');
  print('   - Use Path.combine for complex shapes');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Comparison with PathOperation
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 14: Comparison with PathOperation                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipOp vs PathOperation:');
  print('');
  print('ClipOp (Canvas clipping):');
  print('  - Applied to Canvas');
  print('  - Affects all subsequent drawing');
  print('  - Only difference and intersect');
  print('  - Runtime operation');
  print('');
  print('PathOperation (Path combining):');
  print('  - Combines Path objects');
  print('  - Creates new Path');
  print('  - More operations: union, xor, reverseDifference');
  print('  - Can be cached');
  print('');
  print('PathOperation values:');
  print('  - difference');
  print('  - intersect');
  print('  - union');
  print('  - xor');
  print('  - reverseDifference');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 15: Summary                                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipOp summary:');
  print('');
  print('┌───────────────┬──────────────────────────────────────────────────────┐');
  print('│ Value         │ Description                                          │');
  print('├───────────────┼──────────────────────────────────────────────────────┤');
  print('│ intersect     │ Keep only intersection of clips (default)            │');
  print('│ difference    │ Subtract new clip from existing (create hole)        │');
  print('└───────────────┴──────────────────────────────────────────────────────┘');
  print('');
  print('Key points:');
  print('  1. Only 2 values: intersect and difference');
  print('  2. Used with Canvas.clipRect');
  print('  3. clipPath and clipRRect always intersect');
  print('  4. intersect is default (restrictive)');
  print('  5. difference creates cutouts/holes');
  print('');
  print('Common patterns:');
  print('  - viewport clipping (intersect)');
  print('  - donut/ring shapes (difference)');
  print('  - spotlight/reveal effects (difference)');
  print('  - save/restore for temporary clips');
  print('');
  print('═══════════════════════════════════════════════════════════════════════');
  print('ClipOp deep demo completed');

  // Return visual UI demonstrating ClipOp operations
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
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
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.crop, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ClipOp',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Canvas Clip Region Operations',
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

        // Values display
        Text(
          'All ClipOp Values',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: ui.ClipOp.values.map((op) {
            final isIntersect = op == ui.ClipOp.intersect;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: isIntersect ? 12 : 0),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isIntersect ? Colors.green.shade50 : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isIntersect ? Colors.green.shade400 : Colors.orange.shade400,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      isIntersect ? Icons.filter_center_focus : Icons.content_cut,
                      size: 40,
                      color: isIntersect ? Colors.green.shade700 : Colors.orange.shade700,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      op.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isIntersect ? Colors.green.shade700 : Colors.orange.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isIntersect ? 'Keep intersection\n(default)' : 'Create hole\n(cutout)',
                      style: TextStyle(
                        fontSize: 11,
                        color: isIntersect ? Colors.green.shade600 : Colors.orange.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Visual demonstration
        Text(
          'Visual Demonstration',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ClipOpDemo(
                title: 'intersect',
                subtitle: 'A ∩ B',
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ClipOpDemo(
                title: 'difference',
                subtitle: 'A - B',
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Use cases
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Common Use Cases:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('intersect:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
                        Text('• Viewport clipping', style: TextStyle(fontSize: 10)),
                        Text('• Image cropping', style: TextStyle(fontSize: 10)),
                        Text('• Nested clips', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('difference:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange.shade700)),
                        Text('• Donut shapes', style: TextStyle(fontSize: 10)),
                        Text('• Spotlight reveals', style: TextStyle(fontSize: 10)),
                        Text('• Window cutouts', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade600, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${ui.ClipOp.values.length} operations • Used with Canvas.clipRect • clipPath/clipRRect always intersect',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade700,
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

// Helper widget for ClipOp visual demonstration
class _ClipOpDemo extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const _ClipOpDemo({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade300),
      ),
      child: Stack(
        children: [
          // First rect
          Positioned(
            left: 10,
            top: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.shade200.withAlpha(150),
                border: Border.all(color: color.shade400),
              ),
            ),
          ),
          // Second rect
          Positioned(
            left: 35,
            top: 35,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.shade300.withAlpha(150),
                border: Border.all(color: color.shade500),
              ),
            ),
          ),
          // Label
          Positioned(
            right: 8,
            bottom: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color.shade700,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    color: color.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
