// D4rt test script: Tests ShapeBorderClipper from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShapeBorderClipper test executing');
  final results = <String>[];

  // ========== Section 1: Basic ShapeBorderClipper Creation ==========
  print('--- Section 1: Basic ShapeBorderClipper Creation ---');
  
  final roundedRect = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  );
  
  final clipper = ShapeBorderClipper(
    shape: roundedRect,
  );
  
  print('Created ShapeBorderClipper: ${clipper.runtimeType}');
  print('Shape: ${clipper.shape}');
  results.add('ShapeBorderClipper created');

  // ========== Section 2: Different Shapes ==========
  print('--- Section 2: Different Shapes ---');
  
  // Circle
  final circleClipper = ShapeBorderClipper(
    shape: CircleBorder(),
  );
  print('Circle clipper shape: ${circleClipper.shape}');
  results.add('CircleBorder clipper');
  
  // Stadium (pill shape)
  final stadiumClipper = ShapeBorderClipper(
    shape: StadiumBorder(),
  );
  print('Stadium clipper shape: ${stadiumClipper.shape}');
  results.add('StadiumBorder clipper');
  
  // Beveled rectangle
  final beveledClipper = ShapeBorderClipper(
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
  print('Beveled clipper shape: ${beveledClipper.shape}');
  results.add('BeveledRectangleBorder clipper');
  
  // Continuous rectangle
  final continuousClipper = ShapeBorderClipper(
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );
  print('Continuous clipper shape: ${continuousClipper.shape}');
  results.add('ContinuousRectangleBorder clipper');

  // ========== Section 3: Get Clip Path ==========
  print('--- Section 3: Get Clip Path ---');
  
  final size = Size(200, 100);
  final clip = clipper.getClip(size);
  
  print('Got clip for size $size');
  print('Clip path bounds: ${clip.getBounds()}');
  print('Clip path fillType: ${clip.fillType}');
  results.add('getClip returned path');

  // ========== Section 4: Different Sizes ==========
  print('--- Section 4: Different Sizes ---');
  
  final sizes = [
    Size(50, 50),
    Size(100, 200),
    Size(300, 150),
    Size(10, 10),
  ];
  
  for (final s in sizes) {
    final path = clipper.getClip(s);
    print('Size $s -> bounds: ${path.getBounds()}');
  }
  results.add('Tested ${sizes.length} different sizes');

  // ========== Section 5: Circle Clipper Details ==========
  print('--- Section 5: Circle Clipper Details ---');
  
  final circleSize = Size(100, 100);
  final circlePath = circleClipper.getClip(circleSize);
  print('Circle path bounds: ${circlePath.getBounds()}');
  
  // Test with non-square size
  final ovalSize = Size(200, 100);
  final ovalPath = circleClipper.getClip(ovalSize);
  print('Oval path bounds: ${ovalPath.getBounds()}');
  results.add('Circle/Oval paths tested');

  // ========== Section 6: Stadium Clipper Details ==========
  print('--- Section 6: Stadium Clipper Details ---');
  
  final stadiumPath1 = stadiumClipper.getClip(Size(200, 50));
  print('Wide stadium bounds: ${stadiumPath1.getBounds()}');
  
  final stadiumPath2 = stadiumClipper.getClip(Size(50, 200));
  print('Tall stadium bounds: ${stadiumPath2.getBounds()}');
  results.add('Stadium paths tested');

  // ========== Section 7: With TextDirection ==========
  print('--- Section 7: With TextDirection ---');
  
  final ltrClipper = ShapeBorderClipper(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(20),
        bottomEnd: Radius.circular(20),
      ),
    ),
    textDirection: TextDirection.ltr,
  );
  print('LTR clipper textDirection: ${ltrClipper.textDirection}');
  
  final rtlClipper = ShapeBorderClipper(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(20),
        bottomEnd: Radius.circular(20),
      ),
    ),
    textDirection: TextDirection.rtl,
  );
  print('RTL clipper textDirection: ${rtlClipper.textDirection}');
  results.add('TextDirection LTR and RTL tested');

  // ========== Section 8: CustomClipper Interface ==========
  print('--- Section 8: CustomClipper Interface ---');
  
  print('ShapeBorderClipper is CustomClipper<Path>: ${clipper is CustomClipper<Path>}');
  print('Clipper runtimeType: ${clipper.runtimeType}');
  results.add('CustomClipper<Path> interface verified');

  // ========== Section 9: Should Reclip ==========
  print('--- Section 9: Should Reclip ---');
  
  final sameShapeClipper = ShapeBorderClipper(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
  
  final differentShapeClipper = ShapeBorderClipper(
    shape: CircleBorder(),
  );
  
  final shouldReclipSame = clipper.shouldReclip(sameShapeClipper);
  final shouldReclipDifferent = clipper.shouldReclip(differentShapeClipper);
  
  print('Should reclip same shape: $shouldReclipSame');
  print('Should reclip different shape: $shouldReclipDifferent');
  results.add('shouldReclip tested');

  // ========== Section 10: Semantic Bounds ==========
  print('--- Section 10: Semantic Bounds ---');
  
  final semanticSize = Size(150, 100);
  final semanticBounds = clipper.getApproximateClipRect(semanticSize);
  print('Approximate clip rect for $semanticSize: $semanticBounds');
  results.add('getApproximateClipRect tested');

  print('ShapeBorderClipper test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ShapeBorderClipper Tests',
               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...results.map((r) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text('✓ $r', style: TextStyle(fontSize: 14)),
          )),
        ],
      ),
    ),
  );
}
