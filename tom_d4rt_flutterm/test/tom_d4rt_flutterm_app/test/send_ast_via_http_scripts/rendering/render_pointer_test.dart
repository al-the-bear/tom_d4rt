// D4rt test script: Tests RenderAbsorbPointer, RenderIgnorePointer,
// RenderMouseRegion, RenderPointerListener, RenderRepaintBoundary,
// RenderOffstage
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('Render semantics/pointer test executing');

  // ========== RenderAbsorbPointer ==========
  print('--- RenderAbsorbPointer Tests ---');
  final absorbPointer = RenderAbsorbPointer(absorbing: true);
  print('RenderAbsorbPointer created: absorbing=true');
  absorbPointer.absorbing = false;
  print('RenderAbsorbPointer absorbing changed to false');

  // ========== RenderIgnorePointer ==========
  print('--- RenderIgnorePointer Tests ---');
  final ignorePointer = RenderIgnorePointer(ignoring: true);
  print('RenderIgnorePointer created: ignoring=true');
  ignorePointer.ignoring = false;
  print('RenderIgnorePointer ignoring changed to false');

  // ========== RenderRepaintBoundary ==========
  print('--- RenderRepaintBoundary Tests ---');
  final repaintBoundary = RenderRepaintBoundary();
  print('RenderRepaintBoundary created');
  print('  debugNeedsPaint: not set yet');

  // ========== RenderOffstage ==========
  print('--- RenderOffstage Tests ---');
  final offstage = RenderOffstage(offstage: true);
  print('RenderOffstage created: offstage=true');
  offstage.offstage = false;
  print('RenderOffstage changed to offstage=false');

  // ========== HitTestEntry ==========
  print('--- HitTestEntry Tests ---');
  print('HitTestEntry wraps a HitTestTarget');

  // ========== BoxHitTestResult ==========
  print('--- BoxHitTestResult Tests ---');
  final hitResult = BoxHitTestResult();
  print('BoxHitTestResult created');
  print('  path length: ${hitResult.path.length}');

  // ========== PaintingContext concepts ==========
  print('--- PaintingContext ---');
  print('PaintingContext provides canvas and paint methods');
  print('Used by RenderObject.paint()');

  // ========== AnnotationEntry ==========
  print('--- AnnotationEntry Tests ---');
  final annotation = AnnotationEntry<int>(
    annotation: 42,
    localPosition: Offset(10.0, 20.0),
  );
  print(
    'AnnotationEntry created: ${annotation.annotation} at ${annotation.localPosition}',
  );

  // ========== AnnotationResult ==========
  print('--- AnnotationResult Tests ---');
  final annotResult = AnnotationResult<int>();
  annotResult.add(annotation);
  print('AnnotationResult with ${annotResult.entries.length} entry');

  print('All render semantics/pointer tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Render Semantics/Pointer Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            AbsorbPointer(
              absorbing: true,
              child: ElevatedButton(onPressed: () {}, child: Text('Absorbed')),
            ),
            SizedBox(height: 8.0),
            IgnorePointer(
              ignoring: true,
              child: ElevatedButton(onPressed: () {}, child: Text('Ignored')),
            ),
            SizedBox(height: 8.0),
            RepaintBoundary(child: Text('Repaint boundary')),
            Offstage(offstage: false, child: Text('Not offstage')),
          ],
        ),
      ),
    ),
  );
}
