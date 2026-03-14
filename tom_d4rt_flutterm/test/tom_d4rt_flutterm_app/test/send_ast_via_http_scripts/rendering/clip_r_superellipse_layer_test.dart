// D4rt test script: Tests ClipRSuperellipseLayer from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipRSuperellipseLayer test executing');

  // ========== ClipRSuperellipseLayer Basic Creation ==========
  print('--- ClipRSuperellipseLayer Basic Creation ---');
  final superellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    10.0,
  );
  final clipLayer = ClipRSuperellipseLayer(clipRSuperellipse: superellipse);
  print('  created: ${clipLayer.runtimeType}');
  print('  clipRSuperellipse: ${clipLayer.clipRSuperellipse}');
  print('  clipBehavior: ${clipLayer.clipBehavior}');

  // ========== RSuperellipse Basics ==========
  print('--- RSuperellipse Basics ---');
  final basicSuperellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(10.0, 10.0, 200.0, 150.0),
    20.0,
  );
  print('  basic superellipse created');
  print('  outerRect: ${basicSuperellipse.outerRect}');

  // ========== RSuperellipse with Different Corner Radii ==========
  print('--- RSuperellipse with Different Corner Radii ---');
  final smallCorner = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    5.0,
  );
  print('  small corner radius (5.0): created');

  final mediumCorner = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    15.0,
  );
  print('  medium corner radius (15.0): created');

  final largeCorner = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    30.0,
  );
  print('  large corner radius (30.0): created');

  // ========== ClipRSuperellipseLayer with ClipBehavior ==========
  print('--- ClipRSuperellipseLayer with ClipBehavior ---');
  final hardEdgeClip = ClipRSuperellipseLayer(
    clipRSuperellipse: superellipse,
    clipBehavior: Clip.hardEdge,
  );
  print('  hardEdge: ${hardEdgeClip.clipBehavior}');

  final antiAliasClip = ClipRSuperellipseLayer(
    clipRSuperellipse: superellipse,
    clipBehavior: Clip.antiAlias,
  );
  print('  antiAlias: ${antiAliasClip.clipBehavior}');

  final saveLayerClip = ClipRSuperellipseLayer(
    clipRSuperellipse: superellipse,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  );
  print('  antiAliasWithSaveLayer: ${saveLayerClip.clipBehavior}');

  // ========== ClipRSuperellipseLayer Property Modification ==========
  print('--- ClipRSuperellipseLayer Property Modification ---');
  final mutableLayer = ClipRSuperellipseLayer(clipRSuperellipse: superellipse);
  print('  initial clipRSuperellipse set');

  final newSuperellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(20.0, 20.0, 150.0, 100.0),
    25.0,
  );
  mutableLayer.clipRSuperellipse = newSuperellipse;
  print('  modified clipRSuperellipse');

  mutableLayer.clipBehavior = Clip.antiAlias;
  print('  modified clipBehavior: ${mutableLayer.clipBehavior}');

  // ========== ClipRSuperellipseLayer Layer Hierarchy ==========
  print('--- ClipRSuperellipseLayer Layer Hierarchy ---');
  print('  parent: ${clipLayer.parent}');
  print('  firstChild: ${clipLayer.firstChild}');
  print('  lastChild: ${clipLayer.lastChild}');
  print('  nextSibling: ${clipLayer.nextSibling}');
  print('  previousSibling: ${clipLayer.previousSibling}');
  print('  hasChildren: ${clipLayer.hasChildren}');

  // ========== RSuperellipse Various Sizes ==========
  print('--- RSuperellipse Various Sizes ---');
  final sizes = [
    [50.0, 50.0],
    [100.0, 80.0],
    [200.0, 100.0],
    [300.0, 200.0],
  ];
  for (final size in sizes) {
    final se = RSuperellipse.fromRectAndCornerRadius(
      Rect.fromLTWH(0.0, 0.0, size[0], size[1]),
      12.0,
    );
    print('  superellipse ${size[0]}x${size[1]}: outerRect=${se.outerRect}');
  }

  // ========== RSuperellipse Edge Cases ==========
  print('--- RSuperellipse Edge Cases ---');
  final squareSuperellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    20.0,
  );
  print('  square superellipse: ${squareSuperellipse.outerRect}');

  final tallSuperellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 50.0, 200.0),
    15.0,
  );
  print('  tall superellipse: ${tallSuperellipse.outerRect}');

  final wideSuperellipse = RSuperellipse.fromRectAndCornerRadius(
    Rect.fromLTWH(0.0, 0.0, 250.0, 60.0),
    10.0,
  );
  print('  wide superellipse: ${wideSuperellipse.outerRect}');

  // ========== Comparing with RRect ==========
  print('--- Comparing with Traditional RRect ---');
  final rrect = RRect.fromRectAndRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    Radius.circular(10.0),
  );
  print('  RRect (for comparison): $rrect');
  print('  RSuperellipse has smoother corner curves than RRect');
  print('  Used for iOS-style "squircle" shapes');

  print('ClipRSuperellipseLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ClipRSuperellipseLayer Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('ClipRSuperellipseLayer: ${clipLayer.runtimeType}'),
          Text('RSuperellipse: smooth corner "squircle" shape'),
          Text('Corner radii: 5, 15, 30'),
          Text('ClipBehavior: hardEdge, antiAlias, saveLayer'),
          Text('Various sizes tested: 50x50 to 300x200'),
          Text('iOS-style smooth corners'),
        ],
      ),
    ),
  );
}
