// D4rt test script: Tests NotchedShape abstract via concrete implementations from painting
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NotchedShape test executing');
  final results = <String>[];

  // ========== NotchedShape Tests via CircularNotchedRectangle ==========
  // NotchedShape is abstract, CircularNotchedRectangle is a concrete implementation
  print('Testing NotchedShape via CircularNotchedRectangle...');

  // Test 1: Create CircularNotchedRectangle
  final notchedRect1 = CircularNotchedRectangle();
  assert(notchedRect1 != null, 'Should create notched rectangle');
  results.add('CircularNotchedRectangle: created');
  print('CircularNotchedRectangle created');

  // Test 2: Get outer path without notch
  final hostRect = Rect.fromLTWH(0, 0, 300, 56);
  final pathNoNotch = notchedRect1.getOuterPath(hostRect, null);
  final boundsNoNotch = pathNoNotch.getBounds();
  assert(boundsNoNotch.width == 300, 'Width should be 300');
  results.add(
    'OuterPath no notch: ${boundsNoNotch.width}x${boundsNoNotch.height}',
  );
  print('OuterPath without notch: $boundsNoNotch');

  // Test 3: Get outer path with circular notch
  final guestRect = Rect.fromCircle(center: Offset(150, 0), radius: 28);
  final pathWithNotch = notchedRect1.getOuterPath(hostRect, guestRect);
  final boundsWithNotch = pathWithNotch.getBounds();
  assert(boundsWithNotch.width >= 300, 'Width should include notch');
  results.add(
    'OuterPath with notch: ${boundsWithNotch.width}x${boundsWithNotch.height}',
  );
  print('OuterPath with notch: $boundsWithNotch');

  // Test 4: Different notch positions - left
  final leftNotch = Rect.fromCircle(center: Offset(50, 0), radius: 28);
  final pathLeftNotch = notchedRect1.getOuterPath(hostRect, leftNotch);
  results.add('Left notch path: created');
  print('Left notch position path created');

  // Test 5: Different notch positions - right
  final rightNotch = Rect.fromCircle(center: Offset(250, 0), radius: 28);
  final pathRightNotch = notchedRect1.getOuterPath(hostRect, rightNotch);
  results.add('Right notch path: created');
  print('Right notch position path created');

  // Test 6: Small notch radius
  final smallNotch = Rect.fromCircle(center: Offset(150, 0), radius: 14);
  final pathSmallNotch = notchedRect1.getOuterPath(hostRect, smallNotch);
  results.add('Small notch (r=14): created');
  print('Small notch path created');

  // Test 7: Large notch radius
  final largeNotch = Rect.fromCircle(center: Offset(150, 0), radius: 40);
  final pathLargeNotch = notchedRect1.getOuterPath(hostRect, largeNotch);
  results.add('Large notch (r=40): created');
  print('Large notch path created');

  // Test 8: AutomaticNotchedShape integration
  final hostShape = RoundedRectangleBorder();
  final guestShape = CircleBorder();
  final autoNotched = AutomaticNotchedShape(hostShape, guestShape);
  assert(autoNotched.host == hostShape, 'Host should match');
  results.add('AutomaticNotchedShape: host=RoundedRect');
  print('AutomaticNotchedShape created');

  // Test 9: AutomaticNotchedShape with null guest
  final autoNotchedNoGuest = AutomaticNotchedShape(hostShape, null);
  assert(autoNotchedNoGuest.guest == null, 'Guest should be null');
  results.add('AutomaticNotchedShape null guest: verified');
  print('AutomaticNotchedShape null guest verified');

  // Test 10: Path operations for notch
  final rect10 = Rect.fromLTWH(0, 0, 200, 50);
  final centerNotch = Rect.fromCircle(center: Offset(100, 0), radius: 20);
  final notchPath = notchedRect1.getOuterPath(rect10, centerNotch);
  final notchBounds = notchPath.getBounds();
  results.add('Center notch bounds: ${notchBounds.height}');
  print('Center notch path bounds: $notchBounds');

  // Test 11: Verify path contains points
  final testPath = notchedRect1.getOuterPath(hostRect, null);
  final containsCenter = testPath.contains(Offset(150, 28));
  results.add('Path contains center: $containsCenter');
  print('Path contains center point: $containsCenter');

  // Test 12: NotchedShape concept with StadiumBorder
  final stadiumHost = StadiumBorder();
  final autoStadium = AutomaticNotchedShape(stadiumHost, guestShape);
  assert(autoStadium.host == stadiumHost, 'Stadium host should match');
  results.add('StadiumBorder host: verified');
  print('AutomaticNotchedShape with StadiumBorder host verified');

  // Test 13: NotchedShape path metrics
  final metricsPath = notchedRect1.getOuterPath(hostRect, guestRect);
  final pathMetrics = metricsPath.computeMetrics();
  for (final metric in pathMetrics) {
    results.add('Path length: ${metric.length.toStringAsFixed(1)}');
    print('Notched path length: ${metric.length}');
    break;
  }

  print('NotchedShape test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NotchedShape Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
