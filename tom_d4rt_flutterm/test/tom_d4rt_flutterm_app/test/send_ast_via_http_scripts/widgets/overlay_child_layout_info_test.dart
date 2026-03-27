// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OverlayChildLayoutInfo from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show Offset;

dynamic build(BuildContext context) {
  print('OverlayChildLayoutInfo test executing');
  print('=' * 50);

  // === Test OverlayChildLayoutInfo extension type ===
  print('\nOverlayChildLayoutInfo provides overlay child info');

  // Describe OverlayChildLayoutInfo
  print('\n--- Understanding OverlayChildLayoutInfo ---');
  print('Extension type wrapping Size information');
  print('Provides layout info for overlay children');
  print('Used by OverlayLayoutCallback');

  // Key properties
  print('\n--- Key properties ---');
  print('childSize: Size of the overlay child');
  print('overlaySize: Size of the overlay');
  print('childPaintTransform: Transform from overlay to child');

  // Test via OverlayPortal
  print('\n--- Testing via OverlayPortal ---');
  final controller = OverlayPortalController();
  final portal = OverlayPortal(
    controller: controller,
    overlayChildBuilder: (context) {
      return Positioned(
        left: 0,
        top: 0,
        child: Container(
          width: 100,
          height: 50,
          color: Colors.blue,
          child: Text('Overlay'),
        ),
      );
    },
    child: Text('Anchor'),
  );
  print('Created OverlayPortal');
  print('portal.runtimeType: ${portal.runtimeType}');

  // OverlayLayoutCallback usage
  print('\n--- OverlayLayoutCallback usage ---');
  print('void onLayout(OverlayChildLayoutInfo info) {');
  print('  info.childSize; // Size');
  print('  info.overlaySize; // Size');
  print('  info.childPaintTransform; // Matrix4?');
  print('}');

  // When used
  print('\n--- When used ---');
  print('During overlay child layout');
  print('Helps position relative elements');
  print('Calculates transforms for painting');

  // Extension type
  print('\n--- Extension type ---');
  print('New Dart feature: extension types');
  print('Zero-cost abstraction over Size');
  print('Compile-time type safety');

  // Related types
  print('\n--- Related types ---');
  print('OverlayLayoutCallback: callback signature');
  print('OverlayPortal: widget that uses this');
  print('OverlayChildLocation: where in overlay');

  print('\n' + '=' * 50);
  print('OverlayChildLayoutInfo test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'OverlayChildLayoutInfo Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extension type over Size'),
      Text('Properties: childSize, overlaySize'),
      Text('Used in: OverlayLayoutCallback'),
      portal,
    ],
  );
}
