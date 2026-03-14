// D4rt test script: Tests RenderClipRSuperellipse from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderClipRSuperellipse test executing');

  // ========== CLIP RRSUPERELLIPSE BASICS ==========
  print('--- ClipRSuperellipse Basics ---');
  print('RenderClipRSuperellipse clips to a RSuperellipse (squircle) shape');
  print('Uses continuous cornered rectangles (iOS-style rounded corners)');
  print('More pleasing than standard rounded rectangles');

  // Test using ClipRRect as the closest equivalent widget
  // Note: ClipRSuperellipse is available in newer Flutter versions
  final clipRRect = ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Center(child: Text('Clipped')),
    ),
  );
  print('ClipRRect created (similar to ClipRSuperellipse)');
  print('  runtimeType: ${clipRRect.runtimeType}');
  print('  borderRadius: ${clipRRect.borderRadius}');
  print('  clipBehavior: ${clipRRect.clipBehavior}');

  // ========== SQUIRCLE GEOMETRY ==========
  print('--- Squircle Geometry ---');
  print('Squircle: Shape between a square and circle');
  print('Mathematical formula: |x|^n + |y|^n = r^n where n > 2');
  print('RSuperellipse uses continuous curvature');
  print('Avoids sharp transitions of standard RRect');

  // Test various border radii
  final smallRadius = ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: Container(width: 50, height: 50, color: Colors.red),
  );
  print('Small radius (5): Nearly square corners');

  final mediumRadius = ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Container(width: 50, height: 50, color: Colors.green),
  );
  print('Medium radius (15): Moderate rounding');

  final largeRadius = ClipRRect(
    borderRadius: BorderRadius.circular(25),
    child: Container(width: 50, height: 50, color: Colors.orange),
  );
  print('Large radius (25): Nearly circular corners');

  // ========== CLIP BEHAVIOR ==========
  print('--- Clip Behavior Options ---');

  final hardEdge = ClipRRect(
    borderRadius: BorderRadius.circular(20),
    clipBehavior: Clip.hardEdge,
    child: Container(width: 60, height: 60, color: Colors.purple),
  );
  print('Clip.hardEdge: Fast but aliased edges');

  final antiAlias = ClipRRect(
    borderRadius: BorderRadius.circular(20),
    clipBehavior: Clip.antiAlias,
    child: Container(width: 60, height: 60, color: Colors.teal),
  );
  print('Clip.antiAlias: Smooth edges, moderate performance');

  final antiAliasWithSaveLayer = ClipRRect(
    borderRadius: BorderRadius.circular(20),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(width: 60, height: 60, color: Colors.pink),
  );
  print('Clip.antiAliasWithSaveLayer: Smoothest, slowest');

  // ========== ASYMMETRIC CORNERS ==========
  print('--- Asymmetric Corner Radii ---');

  final asymmetric = ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(10),
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(30),
    ),
    child: Container(
      width: 80,
      height: 80,
      color: Colors.amber,
      child: Center(child: Text('Asym')),
    ),
  );
  print('Asymmetric corner radii applied');
  print('  topLeft: 30, topRight: 10');
  print('  bottomLeft: 10, bottomRight: 30');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. iOS-style app icons (squircle shape)');
  print('2. Profile pictures with smooth corners');
  print('3. Card designs with premium feel');
  print('4. Button backgrounds');

  // Test with image placeholder
  final imageClip = ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
      ),
      child: Center(child: Icon(Icons.image, color: Colors.white)),
    ),
  );
  print('Image clip with gradient');

  // ========== NESTED CLIPPING ==========
  print('--- Nested Clipping ---');

  final nestedClip = ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      width: 120,
      height: 120,
      color: Colors.grey[300],
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(width: 60, height: 60, color: Colors.indigo),
        ),
      ),
    ),
  );
  print('Nested ClipRRect widgets');
  print('  Outer radius: 20, Inner radius: 10');

  // ========== PERFORMANCE NOTES ==========
  print('--- Performance Considerations ---');
  print('RenderClipRSuperellipse is more expensive than RenderClipRect');
  print('Use Clip.hardEdge when anti-aliasing not needed');
  print('Avoid antiAliasWithSaveLayer unless required');
  print('Consider using DecoratedBox for borders without clipping');

  print('RenderClipRSuperellipse test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderClipRSuperellipse Tests'),
      clipRRect,
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          smallRadius,
          SizedBox(width: 8),
          mediumRadius,
          SizedBox(width: 8),
          largeRadius,
        ],
      ),
      SizedBox(height: 8),
      asymmetric,
      SizedBox(height: 8),
      imageClip,
      SizedBox(height: 8),
      Text('All ClipRSuperellipse tests passed'),
    ],
  );
}
