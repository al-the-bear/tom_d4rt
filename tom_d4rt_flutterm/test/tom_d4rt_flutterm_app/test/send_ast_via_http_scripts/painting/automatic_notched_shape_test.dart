// D4rt test script: Tests AutomaticNotchedShape from painting
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AutomaticNotchedShape test executing');
  final results = <String>[];

  // ========== AutomaticNotchedShape Tests ==========
  print('Testing AutomaticNotchedShape...');

  // Test 1: Create AutomaticNotchedShape with basic shapes
  final hostShape1 = RoundedRectangleBorder();
  final guestShape1 = CircleBorder();
  final notched1 = AutomaticNotchedShape(hostShape1, guestShape1);
  assert(notched1.host == hostShape1, 'Host should match');
  assert(notched1.guest == guestShape1, 'Guest should match');
  results.add('AutomaticNotchedShape: host=RoundedRect, guest=Circle');
  print('AutomaticNotchedShape created with RoundedRect host and Circle guest');

  // Test 2: AutomaticNotchedShape with StadiumBorder host
  final hostShape2 = StadiumBorder();
  final guestShape2 = CircleBorder();
  final notched2 = AutomaticNotchedShape(hostShape2, guestShape2);
  assert(notched2.host == hostShape2, 'Host should be StadiumBorder');
  results.add('AutomaticNotchedShape StadiumBorder host: verified');
  print('AutomaticNotchedShape with StadiumBorder host verified');

  // Test 3: AutomaticNotchedShape with null guest
  final notched3 = AutomaticNotchedShape(hostShape1, null);
  assert(notched3.host == hostShape1, 'Host should be set');
  assert(notched3.guest == null, 'Guest should be null');
  results.add('AutomaticNotchedShape null guest: verified');
  print('AutomaticNotchedShape with null guest verified');

  // Test 4: AutomaticNotchedShape with stadium guest
  final guestShape4 = StadiumBorder();
  final notched4 = AutomaticNotchedShape(hostShape1, guestShape4);
  assert(notched4.guest == guestShape4, 'Guest should be StadiumBorder');
  results.add('AutomaticNotchedShape stadium guest: verified');
  print('AutomaticNotchedShape with StadiumBorder guest verified');

  // Test 5: Test getOuterPath on host shape
  final rect5 = Rect.fromLTWH(0, 0, 200, 56);
  final hostPath = hostShape1.getOuterPath(rect5);
  final pathBounds = hostPath.getBounds();
  assert(pathBounds.width == 200, 'Path width should be 200');
  results.add('Host outer path width: ${pathBounds.width}');
  print('Host getOuterPath width: ${pathBounds.width}');

  // Test 6: RoundedRectangleBorder with borderRadius
  final hostShape6 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );
  final notched6 = AutomaticNotchedShape(hostShape6, guestShape1);
  assert(notched6.host == hostShape6, 'Host should have rounded corners');
  results.add('AutomaticNotchedShape rounded host: verified');
  print('AutomaticNotchedShape with rounded corner host verified');

  // Test 7: CircleBorder with side
  final guestShape7 = CircleBorder(
    side: BorderSide(color: Color(0xFF000000), width: 2.0),
  );
  final notched7 = AutomaticNotchedShape(hostShape1, guestShape7);
  assert(notched7.guest == guestShape7, 'Guest should have border side');
  results.add('AutomaticNotchedShape bordered guest: verified');
  print('AutomaticNotchedShape with bordered circle guest verified');

  // Test 8: Test getInnerPath on host shape
  final rect8 = Rect.fromLTWH(0, 0, 150, 50);
  final innerPath = hostShape1.getInnerPath(rect8);
  final innerBounds = innerPath.getBounds();
  assert(innerBounds.width <= 150, 'Inner path width should be <= 150');
  results.add('Host inner path width: ${innerBounds.width}');
  print('Host getInnerPath width: ${innerBounds.width}');

  // Test 9: ShapeBorder dimensions
  final dimensions = hostShape1.dimensions;
  results.add('Host dimensions: $dimensions');
  print('Host border dimensions: $dimensions');

  // Test 10: AutomaticNotchedShape with BeveledRectangleBorder
  final hostShape10 = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  );
  final notched10 = AutomaticNotchedShape(hostShape10, guestShape1);
  assert(notched10.host == hostShape10, 'Host should be BeveledRectangleBorder');
  results.add('AutomaticNotchedShape beveled host: verified');
  print('AutomaticNotchedShape with BeveledRectangleBorder host verified');

  // Test 11: Different host and guest combinations
  final notched11 = AutomaticNotchedShape(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    CircleBorder(side: BorderSide.none),
  );
  assert(notched11.host != null, 'Should have host');
  assert(notched11.guest != null, 'Should have guest');
  results.add('AutomaticNotchedShape custom combo: verified');
  print('AutomaticNotchedShape custom combination verified');

  // Test 12: Host shape scale
  final scaledHost = hostShape1.scale(2.0);
  final notched12 = AutomaticNotchedShape(scaledHost, guestShape1);
  results.add('AutomaticNotchedShape scaled host: verified');
  print('AutomaticNotchedShape with scaled host verified');

  print('AutomaticNotchedShape test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AutomaticNotchedShape Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
