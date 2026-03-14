// D4rt test script: Tests RenderCustomPaint from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderCustomPaint test executing');
  print('=' * 50);

  // RenderCustomPaint for custom painting
  print('\nRenderCustomPaint:');
  print('RenderObject for CustomPaint widget');
  print('Delegates painting to CustomPainter');

  // Simple CustomPainter
  print('\nCustomPainter example:');
  print('class MyPainter extends CustomPainter {');
  print('  @override');
  print('  void paint(Canvas canvas, Size size) {');
  print('    final paint = Paint()..color = Colors.blue;');
  print('    canvas.drawCircle(');
  print('      Offset(size.width/2, size.height/2),');
  print('      50.0,');
  print('      paint,');
  print('    );');
  print('  }');
  print('');
  print('  @override');
  print('  bool shouldRepaint(MyPainter old) => false;');
  print('}');

  // Properties
  print('\nRenderCustomPaint properties:');
  print('- painter: CustomPainter (background)');
  print('- foregroundPainter: CustomPainter');
  print('- preferredSize: Size');
  print('- isComplex: bool');
  print('- willChange: bool');

  // Painting order
  print('\nPainting order:');
  print('1. painter (background)');
  print('2. child');
  print('3. foregroundPainter (foreground)');

  // Size handling
  print('\nSize handling:');
  print('- Uses preferredSize if no child');
  print('- Expands to fit child otherwise');
  print('- Size passed to paint()');

  // shouldRepaint
  print('\nshouldRepaint importance:');
  print('- Return true to repaint');
  print('- Called when painter changes');
  print('- Performance optimization');

  // Widget equivalent
  print('\nWidget equivalent:');
  print('CustomPaint(');
  print('  painter: MyPainter(),');
  print('  child: Container(),');
  print(');');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RenderObject');
  print('  \u2514\u2500 RenderBox');
  print('       \u2514\u2500 RenderProxyBox');
  print('            \u2514\u2500 RenderCustomPaint');

  // Explain purpose
  print('\nRenderCustomPaint purpose:');
  print('- Custom painting support');
  print('- Delegates to CustomPainter');
  print('- painter and foregroundPainter');
  print('- shouldRepaint optimization');
  print('- Canvas access for drawing');

  print('\n' + '=' * 50);
  print('RenderCustomPaint test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderCustomPaint Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Painter: CustomPainter'),
      Text('Method: paint(Canvas, Size)'),
      Text('Widget: CustomPaint'),
      Text('Purpose: Custom drawing'),
    ],
  );
}
