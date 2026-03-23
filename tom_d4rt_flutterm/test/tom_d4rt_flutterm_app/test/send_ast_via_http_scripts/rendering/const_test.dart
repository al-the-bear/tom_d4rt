// ignore_for_file: avoid_print
// D4rt test script: Tests rendering constant values and factories
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Rendering constants test executing');

  // Test BoxConstraints constants and factories
  print('BoxConstraints constants:');
  
  final tight = BoxConstraints.tight(const Size(100, 200));
  print('tight(100x200): $tight');
  print('isTight: ${tight.isTight}');
  
  final loose = BoxConstraints.loose(const Size(300, 400));
  print('loose(300x400): $loose');
  print('isNormalized: ${loose.isNormalized}');
  
  final expand = BoxConstraints.expand();
  print('expand(): $expand');
  print('hasBoundedWidth: ${expand.hasBoundedWidth}');
  
  final tightFor = BoxConstraints.tightFor(width: 150);
  print('tightFor(width: 150): $tightFor');
  
  final tightForFinite = BoxConstraints.tightForFinite(height: 250);
  print('tightForFinite(height: 250): $tightForFinite');
  
  // SliverConstraints constants
  print('\nSliver-related constants:');
  print('SliverGeometry.zero: ${SliverGeometry.zero}');
  
  // EdgeInsets constants
  print('\nEdgeInsets constants:');
  print('EdgeInsets.zero: ${EdgeInsets.zero}');
  print('EdgeInsetsDirectional.zero: ${EdgeInsetsDirectional.zero}');
  
  // Alignment constants
  print('\nAlignment constants:');
  print('Alignment.center: ${Alignment.center}');
  print('Alignment.topLeft: ${Alignment.topLeft}');
  print('AlignmentDirectional.center: ${AlignmentDirectional.center}');
  
  // FractionalOffset constants
  print('\nFractionalOffset:');
  print('FractionalOffset.center: ${FractionalOffset.center}');
  
  // RelativeRect constants
  print('\nRelativeRect:');
  print('RelativeRect.fill: ${RelativeRect.fill}');

  print('\nRendering constants test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Rendering Constants Tests'),
      Text('BoxConstraints factories verified'),
      Text('SliverGeometry.zero available'),
      Text('EdgeInsets/Alignment constants'),
    ],
  );
}
