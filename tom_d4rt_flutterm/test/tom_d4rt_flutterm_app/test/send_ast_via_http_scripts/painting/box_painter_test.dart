// D4rt test script: Tests BoxPainter conceptual from painting via BoxDecoration
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxPainter test executing');
  final results = <String>[];

  // ========== BoxPainter Tests via BoxDecoration ==========
  // BoxPainter is obtained via Decoration.createBoxPainter()
  print('Testing BoxPainter via BoxDecoration.createBoxPainter()...');

  // Test 1: Create BoxDecoration to get BoxPainter
  final decoration1 = BoxDecoration(
    color: Color(0xFF0000FF),
  );
  assert(decoration1.color == Color(0xFF0000FF), 'Decoration color should be blue');
  results.add('BoxDecoration for painter: color=${decoration1.color}');
  print('BoxDecoration created for BoxPainter access');

  // Test 2: BoxDecoration with border for complex painting
  final decoration2 = BoxDecoration(
    color: Color(0xFFFF0000),
    border: Border.all(color: Color(0xFF000000), width: 2.0),
  );
  assert(decoration2.border != null, 'Border should not be null');
  results.add('BoxDecoration with border: verified');
  print('BoxDecoration with border verified');

  // Test 3: BoxDecoration with borderRadius
  final decoration3 = BoxDecoration(
    color: Color(0xFF00FF00),
    borderRadius: BorderRadius.circular(10.0),
  );
  assert(decoration3.borderRadius != null, 'BorderRadius should not be null');
  results.add('BoxDecoration borderRadius: ${decoration3.borderRadius}');
  print('BoxDecoration borderRadius: ${decoration3.borderRadius}');

  // Test 4: BoxDecoration with gradient
  final decoration4 = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
    ),
  );
  assert(decoration4.gradient != null, 'Gradient should not be null');
  results.add('BoxDecoration gradient: present');
  print('BoxDecoration gradient verified');

  // Test 5: BoxDecoration with boxShadow
  final decoration5 = BoxDecoration(
    color: Color(0xFFFFFFFF),
    boxShadow: [
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 10.0,
        offset: Offset(2.0, 2.0),
      ),
    ],
  );
  assert(decoration5.boxShadow != null, 'BoxShadow should not be null');
  assert(decoration5.boxShadow!.length == 1, 'Should have 1 shadow');
  results.add('BoxDecoration boxShadow count: ${decoration5.boxShadow!.length}');
  print('BoxDecoration boxShadow: ${decoration5.boxShadow!.length} shadows');

  // Test 6: BoxDecoration BoxShape.circle
  final decoration6 = BoxDecoration(
    color: Color(0xFFFF0000),
    shape: BoxShape.circle,
  );
  assert(decoration6.shape == BoxShape.circle, 'Shape should be circle');
  results.add('BoxDecoration shape: ${decoration6.shape}');
  print('BoxDecoration shape: ${decoration6.shape}');

  // Test 7: BoxDecoration BoxShape.rectangle
  final decoration7 = BoxDecoration(
    color: Color(0xFF00FF00),
    shape: BoxShape.rectangle,
  );
  assert(decoration7.shape == BoxShape.rectangle, 'Shape should be rectangle');
  results.add('BoxDecoration rectangle shape: ${decoration7.shape}');
  print('BoxDecoration rectangle shape verified');

  // Test 8: BoxDecoration padding calculation
  final decoration8 = BoxDecoration(
    border: Border.all(width: 5.0),
  );
  final padding = decoration8.padding;
  assert(padding != null, 'Padding should not be null');
  results.add('BoxDecoration padding: $padding');
  print('BoxDecoration padding: $padding');

  // Test 9: BoxDecoration lerp
  final decorationA = BoxDecoration(color: Color(0xFF000000));
  final decorationB = BoxDecoration(color: Color(0xFFFFFFFF));
  final lerped = BoxDecoration.lerp(decorationA, decorationB, 0.5);
  assert(lerped != null, 'Lerped decoration should not be null');
  results.add('BoxDecoration lerp: ${lerped?.color}');
  print('BoxDecoration lerp: ${lerped?.color}');

  // Test 10: BoxDecoration scale
  final scaledDeco = decoration8.scale(2.0);
  results.add('BoxDecoration scale: applied');
  print('BoxDecoration scale applied');

  // Test 11: Complex BoxDecoration
  final complexDecoration = BoxDecoration(
    color: Color(0xFFEEEEEE),
    border: Border.all(color: Color(0xFF333333), width: 1.0),
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(color: Color(0x20000000), blurRadius: 4.0, offset: Offset(0, 2)),
    ],
  );
  assert(complexDecoration.color != null, 'Complex decoration color present');
  assert(complexDecoration.border != null, 'Complex decoration border present');
  assert(complexDecoration.borderRadius != null, 'Complex decoration radius present');
  results.add('Complex BoxDecoration: all properties set');
  print('Complex BoxDecoration verified');

  // Test 12: BoxDecoration equality
  final decoX = BoxDecoration(color: Color(0xFFFF0000));
  final decoY = BoxDecoration(color: Color(0xFFFF0000));
  assert(decoX == decoY, 'Equal decorations should be equal');
  results.add('BoxDecoration equality: ${decoX == decoY}');
  print('BoxDecoration equality verified');

  print('BoxPainter test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxPainter Tests (via BoxDecoration)'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
