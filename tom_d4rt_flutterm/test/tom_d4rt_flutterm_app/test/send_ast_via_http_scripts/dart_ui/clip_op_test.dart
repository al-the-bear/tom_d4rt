// D4rt test script: Deep Demo for ClipOp from dart:ui
// ClipOp defines operations for combining clip regions on Canvas
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ClipOp Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ClipOp Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('ClipOp controls how clip regions combine on Canvas');
  print('Values: ${ui.ClipOp.values}');
  print('Count: ${ui.ClipOp.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All ClipOp Values
  // ═══════════════════════════════════════════════════════════════════════════

  for (final op in ui.ClipOp.values) {
    print('${op.name}: index=${op.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ClipOp.intersect
  // ═══════════════════════════════════════════════════════════════════════════

  final intersect = ui.ClipOp.intersect;
  print('\nintersect: ${intersect.name}, index=${intersect.index}');
  print('Keeps only the area inside both the existing clip and new clip');
  print('This is the DEFAULT operation — most clipRect calls use this');
  print('Analogous to boolean AND — keeps what both regions share');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: ClipOp.difference
  // ═══════════════════════════════════════════════════════════════════════════

  final difference = ui.ClipOp.difference;
  print('\ndifference: ${difference.name}, index=${difference.index}');
  print('Removes the new clip region from the existing clip area');
  print('Creates a "hole" or cutout — everything EXCEPT the new region');
  print('Analogous to boolean NOT — subtracts from existing clip');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Canvas.clipRect with ClipOp
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Canvas.clipRect usage ---');
  print('canvas.clipRect(rect)  — uses ClipOp.intersect by default');
  print('canvas.clipRect(rect, clipOp: ClipOp.intersect)  — same as default');
  print('canvas.clipRect(rect, clipOp: ClipOp.difference) — creates cutout');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Canvas.clipPath with ClipOp
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Canvas.clipPath usage ---');
  print('canvas.clipPath(path)  — only supports intersect');
  print('clipPath does NOT support ClipOp.difference');
  print('For path difference, use Path.combine(PathOperation.difference, ...)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Canvas.clipRRect with ClipOp
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Canvas.clipRRect usage ---');
  print('canvas.clipRRect(rrect) — only supports intersect');
  print('For rounded cutouts, convert RRect to Path first');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Practical Use Cases ---');
  print('intersect: Viewport clipping, image cropping, nested clips');
  print('difference: Donut shapes, spotlight reveals, window cutouts');
  print('difference: Creating "peekthrough" effects in overlays');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Equality
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Equality ---');
  print('intersect == intersect: ${intersect == ui.ClipOp.intersect}');
  print('intersect == difference: ${intersect == difference}');
  print('difference == difference: ${difference == ui.ClipOp.difference}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Comparison with PathOperation
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- vs PathOperation ---');
  print('ClipOp: applied to Canvas clip state (temporary, save/restore)');
  print('PathOperation: combines Path objects to create new geometry');
  print('ClipOp has 2 values, PathOperation has 5');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget opCard(
    ui.ClipOp op,
    String desc,
    String formula,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: color),
          SizedBox(height: 8),
          Text(
            op.name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            formula,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 4),
          Text(
            desc,
            style: TextStyle(fontSize: 10, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget vennDiagram(
    String label,
    Color colorA,
    Color colorB,
    Color overlap,
    bool showOverlap,
    bool showHole,
  ) {
    return Container(
      width: 140,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Stack(
        children: [
          // Circle A
          Positioned(
            left: 20,
            top: 15,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorA.withValues(alpha: showHole ? 0.4 : 0.3),
                border: Border.all(color: colorA, width: 1.5),
              ),
            ),
          ),
          // Circle B
          Positioned(
            left: 55,
            top: 15,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: showHole
                    ? Colors.white.withValues(alpha: 0.9)
                    : colorB.withValues(alpha: 0.3),
                border: Border.all(
                  color: showHole ? Colors.red : colorB,
                  width: 1.5,
                ),
              ),
            ),
          ),
          if (showOverlap)
            Positioned(
              left: 55,
              top: 25,
              child: Container(
                width: 25,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: overlap.withValues(alpha: 0.5),
                ),
              ),
            ),
          // Label
          Positioned(
            left: 0,
            right: 0,
            bottom: 4,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget useCase(String title, String desc, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              desc,
              style: TextStyle(fontSize: 10, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget canvasApiRow(String method, String support, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              method,
              style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              support,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD LAYOUT
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title banner
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[700]!, Colors.cyan[600]!],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.crop, color: Colors.white, size: 36),
              SizedBox(height: 8),
              Text(
                'ClipOp Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Canvas clip region combination operations',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Operations overview
        Text(
          '1. ClipOp Operations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: opCard(
                intersect,
                'Keep intersection\n(default)',
                'A ∩ B',
                Icons.filter_center_focus,
                Colors.green,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: opCard(
                difference,
                'Create cutout\n(hole)',
                'A − B',
                Icons.content_cut,
                Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Venn diagrams
        Text(
          '2. Visual Set Operations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            vennDiagram(
              'intersect',
              Colors.green,
              Colors.green,
              Colors.green,
              true,
              false,
            ),
            vennDiagram(
              'difference',
              Colors.blue,
              Colors.red,
              Colors.transparent,
              false,
              true,
            ),
          ],
        ),
        SizedBox(height: 16),

        // Canvas API support
        Text(
          '3. Canvas API Support',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                canvasApiRow(
                  'clipRect(rect, clipOp)',
                  'intersect + difference',
                  Colors.green,
                ),
                canvasApiRow('clipPath(path)', 'intersect only', Colors.orange),
                canvasApiRow(
                  'clipRRect(rrect)',
                  'intersect only',
                  Colors.orange,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Use cases
        Text(
          '4. Practical Use Cases',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        useCase(
          'Viewport clip',
          'Restrict drawing to visible area',
          Icons.crop_square,
          Colors.green,
        ),
        useCase(
          'Image crop',
          'Show only part of an image',
          Icons.crop_original,
          Colors.green,
        ),
        useCase(
          'Nested clips',
          'Progressive restriction of draw area',
          Icons.layers,
          Colors.green,
        ),
        useCase(
          'Donut shape',
          'Outer circle minus inner circle',
          Icons.circle,
          Colors.orange,
        ),
        useCase(
          'Spotlight',
          'Dim overlay with bright cutout',
          Icons.highlight,
          Colors.orange,
        ),
        useCase(
          'Window cutout',
          'Frame with transparent center',
          Icons.window,
          Colors.orange,
        ),
        SizedBox(height: 16),

        // Save/Restore
        Text(
          '5. Save/Restore with Clips',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Clip regions are part of Canvas state:',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Text(
                'canvas.save()      — pushes current clip onto stack',
                style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
              ),
              Text(
                'canvas.clipRect()   — modifies current clip',
                style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
              ),
              Text(
                'canvas.restore()    — pops, restoring previous clip',
                style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
              ),
              SizedBox(height: 8),
              Text(
                'Clips can only get smaller within a save/restore scope.',
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // vs PathOperation
        Text(
          '6. ClipOp vs PathOperation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            children: [
              for (final pair in [
                MapEntry(
                  'Scope',
                  'ClipOp: Canvas state | PathOp: Path geometry',
                ),
                MapEntry('Values', 'ClipOp: 2 | PathOp: 5'),
                MapEntry(
                  'Reversible',
                  'ClipOp: via save/restore | PathOp: creates new Path',
                ),
                MapEntry(
                  'Use case',
                  'ClipOp: restrict drawing | PathOp: combine shapes',
                ),
              ])
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 70,
                        child: Text(
                          pair.key,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          pair.value,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${ui.ClipOp.values.length} operations • Intersect (default) keeps overlap • Difference creates cutouts • clipRect supports both, clipPath/clipRRect only intersect',
                  style: TextStyle(fontSize: 11, color: Colors.blue[700]),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}
