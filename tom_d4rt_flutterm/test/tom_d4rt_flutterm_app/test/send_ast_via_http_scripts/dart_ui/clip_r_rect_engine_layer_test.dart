// D4rt test script: Tests ClipRRectEngineLayer via SceneBuilder
// ClipRRectEngineLayer clips child layers using rounded rectangles
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                ClipRRectEngineLayer - Deep Demo                    ║');
  print('║          SceneBuilder pushClipRRect for Rounded Rect Clipping      ║');
  print('╚════════════════════════════════════════════════════════════════════╝');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ClipRRectEngineLayer Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: ClipRRectEngineLayer Fundamentals                      │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipRRectEngineLayer is returned by SceneBuilder.pushClipRRect().');
  print('');
  print('Purpose:');
  print('  - Clips all children within a rounded rectangle');
  print('  - Optimized for rounded corner clipping');
  print('  - Part of Flutter\'s compositing layer system');
  print('  - Used by ClipRRect widget at the rendering level');
  print('');
  print('RRect = Rounded Rectangle:');
  print('  - Rectangle with corner radii');
  print('  - Each corner can have different radius');
  print('  - More efficient than general Path clipping');
  print('');
  print('Package: dart:ui');
  print('Related: ClipRRect widget, RRect class');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: SceneBuilder.pushClipRRect Signature
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: SceneBuilder.pushClipRRect Signature                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Method signature:');
  print('');
  print('  ClipRRectEngineLayer pushClipRRect(');
  print('    RRect rrect, {');
  print('    Clip clipBehavior = Clip.antiAlias,');
  print('    ClipRRectEngineLayer? oldLayer,');
  print('  })');
  print('');
  print('Parameters:');
  print('  rrect: The rounded rectangle clip region');
  print('  clipBehavior: Anti-aliasing mode');
  print('  oldLayer: Existing layer for reuse (performance)');
  print('');
  print('Returns: ClipRRectEngineLayer handle');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: RRect Construction Methods
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: RRect Construction Methods                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // Uniform corners
  final uniformRRect = RRect.fromRectXY(
    const Rect.fromLTWH(0, 0, 200, 150),
    16,
    16,
  );
  print('RRect.fromRectXY (uniform corners):');
  print('  RRect.fromRectXY(rect, radiusX, radiusY)');
  print('  Result: ${uniformRRect}');
  print('');

  // Uniform radius
  final circularRRect = RRect.fromRectAndRadius(
    const Rect.fromLTWH(0, 0, 200, 150),
    const Radius.circular(20),
  );
  print('RRect.fromRectAndRadius:');
  print('  RRect.fromRectAndRadius(rect, Radius.circular(20))');
  print('  Result: ${circularRRect}');
  print('');

  // Per-corner radii
  final asymmetricRRect = RRect.fromRectAndCorners(
    const Rect.fromLTWH(0, 0, 100, 80),
    topLeft: const Radius.circular(4),
    topRight: const Radius.circular(20),
    bottomLeft: const Radius.circular(12),
    bottomRight: const Radius.circular(8),
  );
  print('RRect.fromRectAndCorners (asymmetric):');
  print('  topLeft: 4, topRight: 20');
  print('  bottomLeft: 12, bottomRight: 8');
  print('  Result: ${asymmetricRRect}');
  print('');

  // From LTRB
  final ltrbRRect = RRect.fromLTRBXY(10, 10, 110, 90, 8, 8);
  print('RRect.fromLTRBXY:');
  print('  RRect.fromLTRBXY(left, top, right, bottom, radiusX, radiusY)');
  print('  Result: ${ltrbRRect}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Basic Usage
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: Basic Usage                                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final builder = ui.SceneBuilder();

  final layer1 = builder.pushClipRRect(uniformRRect);
  print('Basic pushClipRRect:');
  print('  Returned type: ${layer1.runtimeType}');
  print('  Is EngineLayer: ${layer1 is ui.EngineLayer}');
  builder.pop();
  print('  Layer popped');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Clip Behaviors
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: Clip Behaviors                                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Available clipBehavior values:');
  print('');

  // Clip.none
  print('Clip.none:');
  print('  - No clipping applied');
  print('  - Content may overflow bounds');
  print('  - Use for debugging or when overflow is acceptable');
  print('');

  // Clip.hardEdge
  final layer2 = builder.pushClipRRect(uniformRRect, clipBehavior: Clip.hardEdge);
  print('Clip.hardEdge:');
  print('  Layer: ${layer2.runtimeType}');
  print('  - Fastest clipping');
  print('  - Jagged edges on curves');
  print('  - Good for small radii or solid backgrounds');
  builder.pop();
  print('');

  // Clip.antiAlias (default)
  final layer3 = builder.pushClipRRect(uniformRRect, clipBehavior: Clip.antiAlias);
  print('Clip.antiAlias (default):');
  print('  Layer: ${layer3.runtimeType}');
  print('  - Smooth rounded corners');
  print('  - Good performance');
  print('  - Recommended for most cases');
  builder.pop();
  print('');

  // Clip.antiAliasWithSaveLayer
  final layer4 = builder.pushClipRRect(uniformRRect, clipBehavior: Clip.antiAliasWithSaveLayer);
  print('Clip.antiAliasWithSaveLayer:');
  print('  Layer: ${layer4.runtimeType}');
  print('  - Best quality anti-aliasing');
  print('  - Creates offscreen buffer');
  print('  - Required for semi-transparent content');
  print('  - Slowest option');
  builder.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Asymmetric Corner Radii
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: Asymmetric Corner Radii                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final layer5 = builder.pushClipRRect(asymmetricRRect);
  print('Asymmetric corners example:');
  print('  Layer: ${layer5.runtimeType}');
  builder.pop();
  print('');
  print('Visual representation:');
  print('  ╭──────────────────────╮');
  print('  │tL=4            tR=20 │');
  print('  │                      │');
  print('  │bL=12          bR=8   │');
  print('  ╰──────────────────────╯');
  print('');
  print('Use cases:');
  print('  - Card designs with varied corners');
  print('  - Bottom sheets (only top corners rounded)');
  print('  - Tabs (only top corners rounded)');
  print('  - Chat bubbles (one corner sharp)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Common UI Patterns
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: Common UI Patterns                                     │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // Top rounded only (bottom sheet)
  final bottomSheetRRect = RRect.fromRectAndCorners(
    const Rect.fromLTWH(0, 0, 200, 300),
    topLeft: const Radius.circular(20),
    topRight: const Radius.circular(20),
  );
  print('Bottom Sheet style (top corners only):');
  print('  topLeft: 20, topRight: 20');
  print('  bottomLeft: 0, bottomRight: 0');
  print('');

  // Chat bubble (one corner sharp)
  final chatBubbleRRect = RRect.fromRectAndCorners(
    const Rect.fromLTWH(0, 0, 200, 80),
    topLeft: const Radius.circular(16),
    topRight: const Radius.circular(16),
    bottomLeft: const Radius.circular(16),
    bottomRight: Radius.zero, // Sharp corner for "tail"
  );
  print('Chat Bubble style (one sharp corner):');
  print('  topLeft: 16, topRight: 16');
  print('  bottomLeft: 16, bottomRight: 0');
  print('');

  // Pill shape
  final pillRRect = RRect.fromRectAndRadius(
    const Rect.fromLTWH(0, 0, 100, 40),
    const Radius.circular(20), // Half of height
  );
  print('Pill/Stadium shape:');
  print('  radius = height / 2');
  print('  Creates fully rounded ends');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: EngineLayer Hierarchy
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: EngineLayer Hierarchy                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipRRectEngineLayer inheritance:');
  print('');
  print('  EngineLayer (abstract base)');
  print('    ├── ClipRectEngineLayer (axis-aligned rect)');
  print('    ├── ClipRRectEngineLayer (rounded rect) ← this one');
  print('    ├── ClipPathEngineLayer (arbitrary path)');
  print('    ├── OpacityEngineLayer');
  print('    ├── TransformEngineLayer');
  print('    └── ...');
  print('');
  print('Performance comparison:');
  print('  ClipRect < ClipRRect < ClipPath');
  print('  (faster)              (slower)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Layer Reuse (oldLayer parameter)
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: Layer Reuse (oldLayer parameter)                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Optimizing with oldLayer:');
  print('');
  print('  ClipRRectEngineLayer? _clipLayer;');
  print('');
  print('  void buildScene(SceneBuilder builder, RRect rrect) {');
  print('    _clipLayer = builder.pushClipRRect(');
  print('      rrect,');
  print('      oldLayer: _clipLayer, // Reuse existing');
  print('    );');
  print('    // Add child layers...');
  print('    builder.pop();');
  print('  }');
  print('');
  print('Benefits:');
  print('  - Avoids allocating new layer objects');
  print('  - Compositor can diff and optimize');
  print('  - Especially helpful in animations');
  print('');
  print('When not to reuse:');
  print('  - RRect changed significantly');
  print('  - clipBehavior changed');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: ClipRRect Widget Integration
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: ClipRRect Widget Integration                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipRRect widget uses ClipRRectEngineLayer:');
  print('');
  print('  ClipRRect(');
  print('    borderRadius: BorderRadius.circular(16),');
  print('    clipBehavior: Clip.antiAlias,');
  print('    child: Image.asset("photo.jpg"),');
  print('  )');
  print('');
  print('Under the hood:');
  print('  1. RenderClipRRect converts BorderRadius to RRect');
  print('  2. In paint(), calls context.pushClipRRect()');
  print('  3. PaintingContext delegates to SceneBuilder');
  print('  4. ClipRRectEngineLayer is created');
  print('');
  print('Asymmetric BorderRadius:');
  print('  ClipRRect(');
  print('    borderRadius: BorderRadius.only(');
  print('      topLeft: Radius.circular(20),');
  print('      topRight: Radius.circular(20),');
  print('    ),');
  print('    child: child,');
  print('  )');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: RRect Properties
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 11: RRect Properties                                      │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  final rrect = uniformRRect;
  print('RRect properties:');
  print('  outerRect: ${rrect.outerRect}');
  print('  left: ${rrect.left}, top: ${rrect.top}');
  print('  right: ${rrect.right}, bottom: ${rrect.bottom}');
  print('  width: ${rrect.width}, height: ${rrect.height}');
  print('  center: ${rrect.center}');
  print('');
  print('Corner radii:');
  print('  tlRadius: ${rrect.tlRadius}');
  print('  trRadius: ${rrect.trRadius}');
  print('  blRadius: ${rrect.blRadius}');
  print('  brRadius: ${rrect.brRadius}');
  print('');
  print('Type checks:');
  print('  isRect: ${rrect.isRect}');
  print('  isStadium: ${rrect.isStadium}');
  print('  isEllipse: ${rrect.isEllipse}');
  print('  isCircle: ${rrect.isCircle}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Nested RRect Clipping
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 12: Nested RRect Clipping                                 │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final builder2 = ui.SceneBuilder();
  final outer = RRect.fromRectXY(const Rect.fromLTWH(0, 0, 200, 200), 20, 20);
  final inner = RRect.fromRectXY(const Rect.fromLTWH(20, 20, 160, 160), 40, 40);

  builder2.pushClipRRect(outer);
  print('Pushed outer RRect (radius: 20)');
  builder2.pushClipRRect(inner);
  print('Pushed inner RRect (radius: 40)');
  print('→ Visible region is intersection');
  builder2.pop();
  print('Popped inner');
  builder2.pop();
  print('Popped outer');
  print('');
  print('Result: Rounded rect clipped to smaller rounded rect');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Performance Best Practices
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 13: Performance Best Practices                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Performance tips:');
  print('');
  print('1. Choose appropriate clip type:');
  print('   - No corners? Use ClipRect (fastest)');
  print('   - Rounded corners? Use ClipRRect');
  print('   - Complex shape? Use ClipPath (slowest)');
  print('');
  print('2. Choose appropriate clipBehavior:');
  print('   - Clip.hardEdge: Small radii, solid backgrounds');
  print('   - Clip.antiAlias: Most cases (default)');
  print('   - Clip.antiAliasWithSaveLayer: Semi-transparent');
  print('');
  print('3. Avoid unnecessary clipping:');
  print('   - If content naturally fits, skip clipping');
  print('   - Use Container decoration.borderRadius instead');
  print('');
  print('4. Cache RRect objects:');
  print('   - Create once, reuse in subsequent frames');
  print('   - Especially in build() methods');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: ClipRRect vs Container
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 14: ClipRRect vs Container                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('When to use ClipRRect:');
  print('  - Child content extends beyond bounds');
  print('  - Need to clip Image, video, or complex widgets');
  print('  - Child has no natural rounded corners');
  print('');
  print('When to use Container decoration:');
  print('  - Just want visual rounded appearance');
  print('  - Content respects bounds');
  print('  - No actual clipping needed');
  print('');
  print('Example (over-engineering):');
  print('  // Unnecessary clipping:');
  print('  ClipRRect(');
  print('    borderRadius: BorderRadius.circular(8),');
  print('    child: Container(color: Colors.blue),');
  print('  )');
  print('');
  print('  // Better:');
  print('  Container(');
  print('    decoration: BoxDecoration(');
  print('      color: Colors.blue,');
  print('      borderRadius: BorderRadius.circular(8),');
  print('    ),');
  print('  )');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 15: Summary                                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('ClipRRectEngineLayer summary:');
  print('');
  print('┌────────────────────────┬───────────────────────────────────────────┐');
  print('│ Aspect                 │ Details                                   │');
  print('├────────────────────────┼───────────────────────────────────────────┤');
  print('│ Created by             │ SceneBuilder.pushClipRRect()              │');
  print('│ Clip shape             │ RRect (rounded rectangle)                 │');
  print('│ Default behavior       │ Clip.antiAlias                            │');
  print('│ Widget equivalent      │ ClipRRect                                 │');
  print('│ Performance            │ Faster than ClipPath, slower than ClipRect│');
  print('└────────────────────────┴───────────────────────────────────────────┘');
  print('');
  print('Key points:');
  print('  1. Optimized for rounded corners');
  print('  2. Supports symmetric and asymmetric radii');
  print('  3. Part of EngineLayer hierarchy');
  print('  4. Use oldLayer for frame-to-frame optimization');
  print('  5. Multiple construction methods for RRect');
  print('');
  print('Common patterns:');
  print('  - Cards and containers');
  print('  - Bottom sheets (top corners only)');
  print('  - Chat bubbles (one sharp corner)');
  print('  - Pills/stadiums (radius = height/2)');
  print('  - Image/avatar clipping');
  print('');
  print('═══════════════════════════════════════════════════════════════════════');
  print('ClipRRectEngineLayer deep demo completed');

  // Clean up
  builder.build().dispose();
  builder2.build().dispose();

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
  final Color color;

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
