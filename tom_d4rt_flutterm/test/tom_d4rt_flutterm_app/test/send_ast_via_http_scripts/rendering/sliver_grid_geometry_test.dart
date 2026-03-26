// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverGridGeometry from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverGridGeometry test executing');
  print('=' * 50);

  // SliverGridGeometry describes a tile's position in a grid
  print('\nSliverGridGeometry:');
  print('Type: Immutable class');
  print('Purpose: Describes the placement of a single tile in a SliverGrid');
  print('Returned by SliverGridLayout.getGeometryForChildIndex()');

  // Create an instance
  const geo = SliverGridGeometry(
    scrollOffset: 0.0,
    crossAxisOffset: 0.0,
    mainAxisExtent: 100.0,
    crossAxisExtent: 150.0,
  );
  print('\nCreated SliverGridGeometry:');
  print('  runtimeType: ${geo.runtimeType}');
  print('  scrollOffset: ${geo.scrollOffset}');
  print('  crossAxisOffset: ${geo.crossAxisOffset}');
  print('  mainAxisExtent: ${geo.mainAxisExtent}');
  print('  crossAxisExtent: ${geo.crossAxisExtent}');
  print('  trailingScrollOffset: ${geo.trailingScrollOffset}');

  // Second tile in grid
  const geo2 = SliverGridGeometry(
    scrollOffset: 0.0,
    crossAxisOffset: 155.0,
    mainAxisExtent: 100.0,
    crossAxisExtent: 150.0,
  );
  print('\nSecond tile (same row):');
  print('  scrollOffset: ${geo2.scrollOffset}');
  print('  crossAxisOffset: ${geo2.crossAxisOffset}');
  print('  trailingScrollOffset: ${geo2.trailingScrollOffset}');

  // Tile on second row
  const geo3 = SliverGridGeometry(
    scrollOffset: 105.0,
    crossAxisOffset: 0.0,
    mainAxisExtent: 100.0,
    crossAxisExtent: 150.0,
  );
  print('\nTile on second row:');
  print('  scrollOffset: ${geo3.scrollOffset}');
  print('  trailingScrollOffset: ${geo3.trailingScrollOffset}');

  // trailingScrollOffset = scrollOffset + mainAxisExtent
  print('\ntrailingScrollOffset calculation:');
  print('  scrollOffset + mainAxisExtent = ${geo.scrollOffset} + ${geo.mainAxisExtent} = ${geo.trailingScrollOffset}');

  // getBoxConstraints
  print('\ngetBoxConstraints method:');
  print('  Converts SliverGridGeometry to BoxConstraints');
  print('  Uses crossAxisExtent for the cross-axis constraint');
  print('  Uses mainAxisExtent for the main-axis constraint');

  // toString
  print('\ntoString: $geo');

  // Coordinate system
  print('\nCoordinate system:');
  print('  scrollOffset: position along scroll axis');
  print('  crossAxisOffset: position perpendicular to scroll');
  print('  mainAxisExtent: size along scroll axis');
  print('  crossAxisExtent: size perpendicular to scroll');

  print('\n==================================================');
  print('SliverGridGeometry test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SliverGridGeometry Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Immutable value class'),
      Text('scrollOffset: ${geo.scrollOffset}'),
      Text('mainAxisExtent: ${geo.mainAxisExtent}'),
      Text('trailing: ${geo.trailingScrollOffset}'),
    ],
  );
}
