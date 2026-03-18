// D4rt test script: Tests Border, BorderSide from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Painting border test executing');

  // ========== BORDERSIDE ==========
  print('--- BorderSide Tests ---');

  // Test BorderSide constructor
  final basicSide = BorderSide(
    color: Color(0xFF2196F3),
    width: 2.0,
    style: BorderStyle.solid,
  );
  print('BorderSide with color, width, style: $basicSide');
  print('  color: ${basicSide.color}');
  print('  width: ${basicSide.width}');
  print('  style: ${basicSide.style}');

  // Test BorderSide.none
  final noneSide = BorderSide.none;
  print('BorderSide.none: $noneSide');
  print('  style: ${noneSide.style}');

  // Test BorderSide with default values
  final defaultSide = BorderSide();
  print('BorderSide() default: $defaultSide');

  // Test BorderSide with only color
  final colorSide = BorderSide(color: Color(0xFFE53935));
  print('BorderSide(color: red): $colorSide');

  // Test BorderSide with only width
  final widthSide = BorderSide(width: 4.0);
  print('BorderSide(width: 4.0): $widthSide');

  // Test BorderSide with strokeAlign
  final insideSide = BorderSide(
    width: 2.0,
    strokeAlign: BorderSide.strokeAlignInside,
  );
  print('BorderSide with strokeAlignInside: $insideSide');

  final outsideSide = BorderSide(
    width: 2.0,
    strokeAlign: BorderSide.strokeAlignOutside,
  );
  print('BorderSide with strokeAlignOutside: $outsideSide');

  final centerSide = BorderSide(
    width: 2.0,
    strokeAlign: BorderSide.strokeAlignCenter,
  );
  print('BorderSide with strokeAlignCenter: $centerSide');

  // Test BorderSide copyWith
  final copiedSide = basicSide.copyWith(width: 5.0);
  print('BorderSide copyWith(width: 5.0): $copiedSide');

  final copiedColorSide = basicSide.copyWith(color: Color(0xFF4CAF50));
  print('BorderSide copyWith(color: green): $copiedColorSide');

  // Test BorderSide scale
  final scaledSide = basicSide.scale(2.0);
  print('BorderSide scale(2.0): $scaledSide');

  // Test BorderSide toPaint
  final paint = basicSide.toPaint();
  print(
    'BorderSide toPaint: color=${paint.color}, strokeWidth=${paint.strokeWidth}',
  );

  // Test BorderSide.merge (same color, different widths)
  final mergedSide = BorderSide.merge(basicSide, basicSide.copyWith(width: 3.0));
  print('BorderSide.merge: $mergedSide');

  // Test BorderSide.canMerge
  final canMerge = BorderSide.canMerge(
    basicSide,
    basicSide.copyWith(width: 3.0),
  );
  print('BorderSide.canMerge (same color different width): $canMerge');

  // Test BorderSide.lerp
  final lerpedSide = BorderSide.lerp(
    BorderSide(color: Color(0xFF2196F3), width: 1.0),
    BorderSide(color: Color(0xFFE53935), width: 5.0),
    0.5,
  );
  print('BorderSide.lerp at 0.5: $lerpedSide');

  // ========== BORDER ==========
  print('--- Border Tests ---');

  // Test Border.all
  final allBorder = Border.all(
    color: Color(0xFF2196F3),
    width: 2.0,
    style: BorderStyle.solid,
  );
  print('Border.all: $allBorder');

  // Test Border.all with defaults
  final defaultAllBorder = Border.all();
  print('Border.all() default: $defaultAllBorder');

  // Test Border constructor
  final customBorder = Border(
    top: BorderSide(color: Color(0xFFE53935), width: 2.0),
    right: BorderSide(color: Color(0xFF4CAF50), width: 3.0),
    bottom: BorderSide(color: Color(0xFF2196F3), width: 4.0),
    left: BorderSide(color: Color(0xFFFF9800), width: 5.0),
  );
  print('Border with different sides: $customBorder');

  // Test Border.symmetric
  final symmetricBorder = Border.symmetric(
    horizontal: BorderSide(color: Color(0xFF2196F3), width: 2.0),
    vertical: BorderSide(color: Color(0xFFE53935), width: 3.0),
  );
  print('Border.symmetric: $symmetricBorder');

  // Test Border.fromBorderSide
  final fromSideBorder = Border.fromBorderSide(basicSide);
  print('Border.fromBorderSide: $fromSideBorder');

  // Test Border properties
  print('Border.top: ${customBorder.top}');
  print('Border.right: ${customBorder.right}');
  print('Border.bottom: ${customBorder.bottom}');
  print('Border.left: ${customBorder.left}');
  print('Border.dimensions: ${customBorder.dimensions}');
  print('Border.isUniform: ${customBorder.isUniform}');
  print('Border.all isUniform: ${allBorder.isUniform}');

  // Test Border.scale
  final scaledBorder = allBorder.scale(2.0);
  print('Border.scale(2.0): $scaledBorder');

  // Test Border.add
  final addedBorder = allBorder.add(Border.all(width: 1.0));
  print('Border.add: $addedBorder');

  // Test Border.lerp
  final lerpedBorder = Border.lerp(
    Border.all(color: Color(0xFF2196F3), width: 1.0),
    Border.all(color: Color(0xFFE53935), width: 5.0),
    0.5,
  );
  print('Border.lerp at 0.5: $lerpedBorder');

  // Test Border with no sides
  final noBorder = Border();
  print('Border() empty: $noBorder');

  // Test Border with only some sides
  final topOnlyBorder = Border(
    top: BorderSide(color: Color(0xFF2196F3), width: 2.0),
  );
  print('Border with only top: $topOnlyBorder');

  final topBottomBorder = Border(
    top: BorderSide(color: Color(0xFF2196F3), width: 2.0),
    bottom: BorderSide(color: Color(0xFF2196F3), width: 2.0),
  );
  print('Border with top and bottom: $topBottomBorder');

  // Test Border.merge
  final mergedBorder = Border.merge(
    Border(top: BorderSide(width: 1.0)),
    Border(bottom: BorderSide(width: 1.0)),
  );
  print('Border.merge: $mergedBorder');

  print('Painting border test completed');

  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Border Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            // Border.all example
            Text(
              'Border.all(color: blue, width: 2):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF2196F3), width: 2.0),
              ),
              child: Center(child: Text('All')),
            ),
            SizedBox(height: 16.0),

            // Different sides example
            Text(
              'Border with different sides:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFE53935), width: 3.0),
                  right: BorderSide(color: Color(0xFF4CAF50), width: 3.0),
                  bottom: BorderSide(color: Color(0xFF2196F3), width: 3.0),
                  left: BorderSide(color: Color(0xFFFF9800), width: 3.0),
                ),
              ),
              child: Center(child: Text('TRLB')),
            ),
            SizedBox(height: 16.0),

            // Top only border
            Text(
              'Border (top only):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFF9C27B0), width: 4.0),
                ),
              ),
              child: Center(child: Text('Top')),
            ),
            SizedBox(height: 16.0),

            // Bottom divider style
            Text(
              'Border as divider:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 200.0,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFBDBDBD), width: 1.0),
                ),
              ),
              child: Text('Item with bottom border'),
            ),
            SizedBox(height: 16.0),

            // Thick border
            Text(
              'BorderSide widths:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF2196F3), width: 1.0),
                  ),
                  child: Center(
                    child: Text('1px', style: TextStyle(fontSize: 10.0)),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF2196F3), width: 2.0),
                  ),
                  child: Center(
                    child: Text('2px', style: TextStyle(fontSize: 10.0)),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF2196F3), width: 4.0),
                  ),
                  child: Center(
                    child: Text('4px', style: TextStyle(fontSize: 10.0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
