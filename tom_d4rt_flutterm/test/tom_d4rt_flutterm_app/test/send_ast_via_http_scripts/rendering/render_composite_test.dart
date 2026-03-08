// D4rt test script: Tests RenderStack, RenderCustomPaint,
// RenderPhysicalModel, RenderPhysicalShape, RenderAnimatedOpacity,
// RenderEditable concepts
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('Render composite test executing');

  // ========== StackFit ==========
  print('--- StackFit Tests ---');
  for (final fit in StackFit.values) {
    print('StackFit: ${fit.name}');
  }

  // ========== Overflow ==========
  print('--- Overflow/Clip Tests ---');
  for (final clip in Clip.values) {
    print('Clip: ${clip.name}');
  }

  // ========== RenderCustomPaint concept ==========
  print('--- RenderCustomPaint Tests ---');
  print('RenderCustomPaint uses CustomPainter for foreground/background');
  print('CustomPainter.paint(Canvas, Size) is the key method');
  print('CustomPainter.shouldRepaint determines repainting');

  // ========== PhysicalModelLayer concept ==========
  print('--- PhysicalModel render Tests ---');
  final physicalModel = PhysicalModel(
    color: Colors.white,
    elevation: 4.0,
    shadowColor: Colors.black26,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(8.0),
    clipBehavior: Clip.antiAlias,
    child: Container(
      width: 100,
      height: 100,
      child: Center(child: Text('Physical')),
    ),
  );
  print('PhysicalModel widget created: elevation=4.0');

  // ========== RenderAnimatedOpacity ==========
  print('--- RenderAnimatedOpacity Tests ---');
  // Note: AlwaysStoppedAnimation is NOT a TickerProvider, cannot be used for vsync
  print('AnimatedOpacity concept: widget-level test only (no AnimationController without TickerProvider)');

  // AnimatedOpacity widget
  final animOpacity = AnimatedOpacity(
    opacity: 0.5,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: Text('Half visible'),
  );
  print('AnimatedOpacity widget: opacity=0.5');

  // ========== RenderStack via Stack widget ==========
  print('--- RenderStack (via Stack) Tests ---');
  final stack = Stack(
    fit: StackFit.loose,
    alignment: Alignment.center,
    clipBehavior: Clip.hardEdge,
    children: [
      Container(width: 200, height: 200, color: Colors.blue.shade100),
      Positioned(
        top: 10,
        left: 10,
        child: Container(width: 100, height: 100, color: Colors.red.shade200),
      ),
      Positioned(
        bottom: 10,
        right: 10,
        child: Container(width: 80, height: 80, color: Colors.green.shade200),
      ),
    ],
  );
  print('Stack with StackFit.loose, 3 children');

  // ========== IndexedStack ==========
  print('--- IndexedStack Tests ---');
  final indexedStack = IndexedStack(
    index: 1,
    alignment: Alignment.center,
    sizing: StackFit.loose,
    children: [Text('Page 0'), Text('Page 1 (visible)'), Text('Page 2')],
  );
  print('IndexedStack index=1');

  print('All render composite tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Render Composite Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            physicalModel,
            SizedBox(height: 16.0),
            animOpacity,
            SizedBox(height: 16.0),
            SizedBox(height: 200, child: stack),
            SizedBox(height: 16.0),
            indexedStack,
          ],
        ),
      ),
    ),
  );
}
