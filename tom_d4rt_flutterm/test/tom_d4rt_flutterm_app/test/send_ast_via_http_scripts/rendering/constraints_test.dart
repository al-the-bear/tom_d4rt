// D4rt test script: Tests Constraints from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Constraints test executing');
  final results = <String>[];

  // ========== Section 1: BoxConstraints Creation ==========
  print('--- Section 1: BoxConstraints Creation ---');
  
  // BoxConstraints is the most common Constraints subclass
  final basic = BoxConstraints();
  print('Default BoxConstraints: $basic');
  print('isTight: ${basic.isTight}');
  print('isNormalized: ${basic.isNormalized}');
  results.add('Default constraints: minW=${basic.minWidth}, maxW=${basic.maxWidth}');
  
  // ========== Section 2: Tight Constraints ==========
  print('--- Section 2: Tight Constraints ---');
  
  final tight = BoxConstraints.tight(Size(100, 50));
  print('Tight constraints: $tight');
  print('isTight: ${tight.isTight}');
  print('biggest: ${tight.biggest}');
  print('smallest: ${tight.smallest}');
  results.add('Tight: isTight=${tight.isTight}, size=${tight.biggest}');
  
  // ========== Section 3: Loose Constraints ==========
  print('--- Section 3: Loose Constraints ---');
  
  final loose = BoxConstraints.loose(Size(200, 150));
  print('Loose constraints: $loose');
  print('isTight: ${loose.isTight}');
  print('hasBoundedWidth: ${loose.hasBoundedWidth}');
  print('hasBoundedHeight: ${loose.hasBoundedHeight}');
  results.add('Loose: bounded=${loose.hasBoundedWidth && loose.hasBoundedHeight}');
  
  // ========== Section 4: Expand Constraints ==========
  print('--- Section 4: Expand Constraints ---');
  
  final expand = BoxConstraints.expand(width: 300, height: 200);
  print('Expand constraints: $expand');
  print('isTight: ${expand.isTight}');
  print('constrainWidth(400): ${expand.constrainWidth(400)}');
  print('constrainHeight(300): ${expand.constrainHeight(300)}');
  results.add('Expand: isTight=${expand.isTight}');
  
  // ========== Section 5: Min/Max Constraints ==========
  print('--- Section 5: Min/Max Constraints ---');
  
  final minMax = BoxConstraints(
    minWidth: 50,
    maxWidth: 150,
    minHeight: 40,
    maxHeight: 120,
  );
  print('Min/Max constraints: $minMax');
  print('constrainWidth(30): ${minMax.constrainWidth(30)}'); // Should be 50
  print('constrainWidth(200): ${minMax.constrainWidth(200)}'); // Should be 150
  print('constrainHeight(20): ${minMax.constrainHeight(20)}'); // Should be 40
  results.add('Constrain 30→${minMax.constrainWidth(30)}, 200→${minMax.constrainWidth(200)}');
  
  // ========== Section 6: Constrain Methods ==========
  print('--- Section 6: Constrain Methods ---');
  
  final constrainer = BoxConstraints(
    minWidth: 100,
    maxWidth: 300,
    minHeight: 80,
    maxHeight: 200,
  );
  
  // Test constrain method
  final size1 = constrainer.constrain(Size(50, 50));
  final size2 = constrainer.constrain(Size(500, 500));
  final size3 = constrainer.constrain(Size(200, 150));
  
  print('constrain(50x50): $size1');
  print('constrain(500x500): $size2');
  print('constrain(200x150): $size3');
  results.add('Constrain: 50x50→$size1, 500x500→$size2');
  
  // ========== Section 7: Normalized and Satisfied ==========
  print('--- Section 7: Normalized Constraints ---');
  
  // Test normalize
  final unnormalized = BoxConstraints(
    minWidth: 200,
    maxWidth: 100, // min > max (invalid)
    minHeight: 150,
    maxHeight: 80, // min > max (invalid)
  );
  print('Unnormalized: $unnormalized');
  print('isNormalized: ${unnormalized.isNormalized}');
  
  final normalized = unnormalized.normalize();
  print('After normalize: $normalized');
  print('isNormalized after: ${normalized.isNormalized}');
  results.add('Normalize: before=${unnormalized.isNormalized}, after=${normalized.isNormalized}');
  
  // ========== Section 8: Width/Height Specific ==========
  print('--- Section 8: Width/Height Specific ---');
  
  final widthOnly = BoxConstraints.tightFor(width: 100);
  final heightOnly = BoxConstraints.tightFor(height: 80);
  
  print('Width only: $widthOnly');
  print('Height only: $heightOnly');
  print('widthOnly.hasTightWidth: ${widthOnly.hasTightWidth}');
  print('heightOnly.hasTightHeight: ${heightOnly.hasTightHeight}');
  results.add('TightFor: width=${widthOnly.hasTightWidth}, height=${heightOnly.hasTightHeight}');
  
  // ========== Section 9: Infinite Constraints ==========
  print('--- Section 9: Infinite Constraints ---');
  
  final infinite = BoxConstraints(
    maxWidth: double.infinity,
    maxHeight: double.infinity,
  );
  print('Infinite constraints: $infinite');
  print('hasBoundedWidth: ${infinite.hasBoundedWidth}');
  print('hasBoundedHeight: ${infinite.hasBoundedHeight}');
  print('hasInfiniteWidth: ${infinite.hasInfiniteWidth}');
  print('hasInfiniteHeight: ${infinite.hasInfiniteHeight}');
  results.add('Infinite: unboundedW=${!infinite.hasBoundedWidth}, unboundedH=${!infinite.hasBoundedHeight}');
  
  // ========== Section 10: Deflate/Enforce ==========
  print('--- Section 10: Deflate/Enforce ---');
  
  final original = BoxConstraints.tight(Size(200, 150));
  final deflated = original.deflate(EdgeInsets.all(20));
  
  print('Original: $original');
  print('Deflated by 20: $deflated');
  print('Deflated biggest: ${deflated.biggest}');
  results.add('Deflate: ${original.biggest}→${deflated.biggest}');
  
  // Enforce
  final enforced = original.enforce(BoxConstraints(maxWidth: 100));
  print('Enforced maxWidth=100: $enforced');
  results.add('Enforce: ${enforced.maxWidth}');

  print('Constraints test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Constraints Tests',
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
