// D4rt test script: Tests Material, Ink, InkWell, InkResponse from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Material/Ink/InkWell/InkResponse test executing');

  // ========== MATERIAL ==========
  print('--- Material Tests ---');

  // Variation 1: Basic Material
  final widget1 = Material(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Basic Material'),
    ),
  );
  print('Material(basic) created');

  // Variation 2: Material with elevation
  final widget2 = Material(
    elevation: 8.0,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Elevated Material'),
    ),
  );
  print('Material(elevation: 8.0) created');

  // Variation 3: Material with color
  final widget3 = Material(
    color: Colors.blue.shade100,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Colored Material'),
    ),
  );
  print('Material(color: blue.shade100) created');

  // Variation 4: Material with shadowColor
  final widget4 = Material(
    elevation: 6.0,
    shadowColor: Colors.red,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Red Shadow Material'),
    ),
  );
  print('Material(shadowColor: red) created');

  // Variation 5: Material with surfaceTintColor
  final widget5 = Material(
    elevation: 4.0,
    surfaceTintColor: Colors.purple,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Tinted Material'),
    ),
  );
  print('Material(surfaceTintColor: purple) created');

  // Variation 6: Material with borderRadius
  final widget6 = Material(
    elevation: 4.0,
    borderRadius: BorderRadius.circular(16.0),
    color: Colors.green.shade100,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Rounded Material'),
    ),
  );
  print('Material(borderRadius: 16) created');

  // Variation 7: Material with shape
  final widget7 = Material(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(color: Colors.blue, width: 2.0),
    ),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Shaped Material'),
    ),
  );
  print('Material(shape: RoundedRectangleBorder) created');

  // Variation 8: Material with type
  final widget8 = Material(
    type: MaterialType.card,
    elevation: 4.0,
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Card Type Material'),
    ),
  );
  print('Material(type: card) created');

  // Variation 9: Material with type circle
  final widget9 = Material(
    type: MaterialType.circle,
    elevation: 4.0,
    color: Colors.amber,
    child: SizedBox(
      width: 80,
      height: 80,
      child: Center(child: Text('Circle')),
    ),
  );
  print('Material(type: circle) created');

  // Variation 10: Material with clipBehavior
  final widget10 = Material(
    elevation: 4.0,
    clipBehavior: Clip.antiAlias,
    borderRadius: BorderRadius.circular(20.0),
    child: Container(
      width: 120,
      height: 60,
      color: Colors.teal,
      child: Center(
        child: Text('Clipped', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Material(clipBehavior: antiAlias) created');

  // ========== INK ==========
  print('--- Ink Tests ---');

  // Variation 11: Ink with decoration
  final widget11 = Material(
    child: Ink(
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Text('Ink with decoration'),
    ),
  );
  print('Ink(decoration: BoxDecoration) created');

  // Variation 12: Ink with width and height
  final widget12 = Material(
    child: Ink(
      width: 100.0,
      height: 50.0,
      color: Colors.purple.shade100,
      child: Center(child: Text('Sized Ink')),
    ),
  );
  print('Ink(width, height, color) created');

  // Variation 13: Ink with gradient decoration
  final widget13 = Material(
    child: Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Text('Gradient Ink', style: TextStyle(color: Colors.white)),
    ),
  );
  print('Ink(gradient decoration) created');

  // ========== INKWELL ==========
  print('--- InkWell Tests ---');

  // Variation 14: Basic InkWell
  final widget14 = Material(
    child: InkWell(
      onTap: () {
        print('InkWell tapped');
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Tap Me (InkWell)'),
      ),
    ),
  );
  print('InkWell(onTap) created');

  // Variation 15: InkWell with splashColor and highlightColor
  final widget15 = Material(
    child: InkWell(
      onTap: () {},
      splashColor: Colors.red.withAlpha(76),
      highlightColor: Colors.blue.withAlpha(76),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Custom Splash InkWell'),
      ),
    ),
  );
  print('InkWell(splashColor, highlightColor) created');

  // Variation 16: InkWell with borderRadius
  final widget16 = Material(
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Rounded InkWell'),
      ),
    ),
  );
  print('InkWell(borderRadius) created');

  // Variation 17: InkWell with onDoubleTap and onLongPress
  final widget17 = Material(
    child: InkWell(
      onTap: () {
        print('tap');
      },
      onDoubleTap: () {
        print('double tap');
      },
      onLongPress: () {
        print('long press');
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Multi-gesture InkWell'),
      ),
    ),
  );
  print('InkWell(onTap, onDoubleTap, onLongPress) created');

  // Variation 18: InkWell with customBorder
  final widget18 = Material(
    child: InkWell(
      onTap: () {},
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Custom Border InkWell'),
      ),
    ),
  );
  print('InkWell(customBorder) created');

  // Variation 19: InkWell with hoverColor and focusColor
  final widget19 = Material(
    child: InkWell(
      onTap: () {},
      hoverColor: Colors.green.withAlpha(50),
      focusColor: Colors.orange.withAlpha(50),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Hover/Focus InkWell'),
      ),
    ),
  );
  print('InkWell(hoverColor, focusColor) created');

  // ========== INKRESPONSE ==========
  print('--- InkResponse Tests ---');

  // Variation 20: Basic InkResponse
  final widget20 = Material(
    child: InkResponse(
      onTap: () {
        print('InkResponse tapped');
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('InkResponse'),
      ),
    ),
  );
  print('InkResponse(onTap) created');

  // Variation 21: InkResponse with containedInkWell
  final widget21 = Material(
    child: InkResponse(
      onTap: () {},
      containedInkWell: true,
      highlightShape: BoxShape.rectangle,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Contained InkResponse'),
      ),
    ),
  );
  print('InkResponse(containedInkWell: true) created');

  // Variation 22: InkResponse with radius
  final widget22 = Material(
    child: InkResponse(
      onTap: () {},
      radius: 40.0,
      splashColor: Colors.purple,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Radial InkResponse'),
      ),
    ),
  );
  print('InkResponse(radius: 40, splashColor) created');

  // Variation 23: InkResponse with highlightColor
  final widget23 = Material(
    child: InkResponse(
      onTap: () {},
      highlightColor: Colors.amber.withAlpha(100),
      splashColor: Colors.red.withAlpha(100),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Highlighted InkResponse'),
      ),
    ),
  );
  print('InkResponse(highlightColor, splashColor) created');

  print('Material/Ink/InkWell/InkResponse test completed');
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget1, SizedBox(height: 8),
        widget2, SizedBox(height: 8),
        widget3, SizedBox(height: 8),
        widget6, SizedBox(height: 8),
        widget7, SizedBox(height: 8),
        widget9, SizedBox(height: 8),
        widget10, SizedBox(height: 8),
        widget11, SizedBox(height: 8),
        widget12, SizedBox(height: 8),
        widget13, SizedBox(height: 8),
        widget14, SizedBox(height: 8),
        widget15, SizedBox(height: 8),
        widget16, SizedBox(height: 8),
        widget17, SizedBox(height: 8),
        widget20, SizedBox(height: 8),
        widget21, SizedBox(height: 8),
        widget22, SizedBox(height: 8),
        widget23,
      ],
    ),
  );
}
