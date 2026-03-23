// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ClipRRect, ClipRect, ClipOval widgets from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClipRRect test executing');

  // Test basic ClipRRect
  final basicClipRRect = ClipRRect(
    borderRadius: BorderRadius.circular(16.0),
    child: Container(
      height: 100.0,
      width: 200.0,
      color: Colors.blue,
      child: Center(
        child: Text('ClipRRect 16px', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipRRect with borderRadius=16 created');

  // Test ClipRRect with different radii
  final asymmetricClip = ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(10.0),
      bottomLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(30.0),
    ),
    child: Container(
      height: 100.0,
      width: 200.0,
      color: Colors.green,
      child: Center(
        child: Text('Asymmetric', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipRRect with asymmetric border radius created');

  // Test ClipRRect with clipBehavior
  final hardEdgeClip = ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    clipBehavior: Clip.hardEdge,
    child: Container(
      height: 80.0,
      color: Colors.red,
      child: Center(
        child: Text('Clip.hardEdge', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipRRect with Clip.hardEdge created');

  final antiAliasClip = ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    clipBehavior: Clip.antiAlias,
    child: Container(
      height: 80.0,
      color: Colors.purple,
      child: Center(
        child: Text('Clip.antiAlias', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipRRect with Clip.antiAlias created');

  final antiAliasWithSaveLayer = ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(
      height: 80.0,
      color: Colors.orange,
      child: Center(
        child: Text(
          'antiAliasWithSaveLayer',
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    ),
  );
  print('ClipRRect with Clip.antiAliasWithSaveLayer created');

  // Test ClipRRect with images
  final imageClip = ClipRRect(
    borderRadius: BorderRadius.circular(50.0),
    child: Container(
      height: 100.0,
      width: 100.0,
      color: Colors.grey,
      child: Icon(Icons.person, size: 60.0, color: Colors.white),
    ),
  );
  print('ClipRRect for avatar-like circular clip created');

  // Test ClipRect
  final clipRect = ClipRect(
    child: Container(
      height: 100.0,
      color: Colors.teal,
      child: Center(
        child: Text('ClipRect', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipRect created');

  // Test ClipRect with clipBehavior
  final clipRectAntiAlias = ClipRect(
    clipBehavior: Clip.antiAlias,
    child: Container(
      height: 80.0,
      color: Colors.pink,
      child: Center(
        child: Text(
          'ClipRect antiAlias',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('ClipRect with Clip.antiAlias created');

  // Test ClipOval
  final clipOval = ClipOval(
    child: Container(
      height: 100.0,
      width: 150.0,
      color: Colors.amber,
      child: Center(
        child: Text('ClipOval', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipOval created');

  // Test ClipOval for circular avatar
  final circularAvatar = ClipOval(
    child: Container(
      height: 80.0,
      width: 80.0,
      color: Colors.indigo,
      child: Icon(Icons.person, size: 50.0, color: Colors.white),
    ),
  );
  print('ClipOval for circular avatar created');

  // Test ClipOval with clipBehavior
  final clipOvalAntiAlias = ClipOval(
    clipBehavior: Clip.antiAlias,
    child: Container(
      height: 80.0,
      width: 120.0,
      color: Colors.brown,
      child: Center(
        child: Text('AntiAlias', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipOval with Clip.antiAlias created');

  // Test ClipPath
  final clipPath = ClipPath(
    clipper: _DiagonalClipper(),
    child: Container(
      height: 100.0,
      color: Colors.cyan,
      child: Center(
        child: Text('ClipPath', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('ClipPath with custom clipper created');

  // Test Clip enum values
  print('Clip.none - no clipping');
  print('Clip.hardEdge - fast, aliased edges');
  print('Clip.antiAlias - smooth edges');
  print('Clip.antiAliasWithSaveLayer - smooth + save layer (slowest)');

  // Test nested clips
  final nestedClips = ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: ClipRect(
      child: Container(
        height: 100.0,
        color: Colors.lime,
        child: Center(
          child: Text('Nested Clips', style: TextStyle(color: Colors.black)),
        ),
      ),
    ),
  );
  print('Nested clipping widgets created');

  // Test PhysicalModel with rounded corners (alternative)
  final physicalModel = PhysicalModel(
    color: Colors.white,
    elevation: 4.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(12.0),
    child: Container(
      height: 80.0,
      width: 200.0,
      child: Center(child: Text('PhysicalModel')),
    ),
  );
  print('PhysicalModel as clipping alternative created');

  // Test PhysicalShape
  final physicalShape = PhysicalShape(
    color: Colors.white,
    elevation: 4.0,
    shadowColor: Colors.black,
    clipper: ShapeBorderClipper(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    child: Container(
      height: 80.0,
      width: 200.0,
      child: Center(child: Text('PhysicalShape')),
    ),
  );
  print('PhysicalShape with ShapeBorderClipper created');

  print('ClipRRect test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Clipping Widgets Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('ClipRRect:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: basicClipRRect),
        SizedBox(height: 8.0),
        Center(child: asymmetricClip),
        SizedBox(height: 16.0),

        Text(
          'ClipBehavior Options:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        hardEdgeClip,
        SizedBox(height: 4.0),
        antiAliasClip,
        SizedBox(height: 4.0),
        antiAliasWithSaveLayer,
        SizedBox(height: 16.0),

        Text('ClipOval:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [clipOval, circularAvatar],
        ),
        SizedBox(height: 16.0),

        Text('ClipRect:', style: TextStyle(fontWeight: FontWeight.bold)),
        clipRect,
        SizedBox(height: 16.0),

        Text('ClipPath:', style: TextStyle(fontWeight: FontWeight.bold)),
        clipPath,
        SizedBox(height: 16.0),

        Text('Physical Models:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: physicalModel),
        SizedBox(height: 8.0),
        Center(child: physicalShape),
      ],
    ),
  );
}

// Custom clipper for ClipPath
class _DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
