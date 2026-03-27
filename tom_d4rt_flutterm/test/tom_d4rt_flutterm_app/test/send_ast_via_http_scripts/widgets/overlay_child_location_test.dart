// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OverlayChildLocation from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OverlayChildLocation test executing');
  print('=' * 50);

  // === Test OverlayChildLocation enum ===
  print('\nOverlayChildLocation specifies overlay target');

  // List all values
  print('\n--- Enum values ---');
  for (final location in OverlayChildLocation.values) {
    print('OverlayChildLocation.${location.name}');
  }

  // Test nearestOverlay value
  print('\n--- Testing nearestOverlay ---');
  final nearest = OverlayChildLocation.nearestOverlay;
  print('nearest.name: ${nearest.name}');
  print('nearest.index: ${nearest.index}');
  print('Places child in nearest enclosing Overlay');

  // Test rootOverlay value
  print('\n--- Testing rootOverlay ---');
  final root = OverlayChildLocation.rootOverlay;
  print('root.name: ${root.name}');
  print('root.index: ${root.index}');
  print('Places child in root Overlay');

  // Test comparison
  print('\n--- Testing comparison ---');
  print('nearest == root: ${nearest == root}');
  print('nearest == OverlayChildLocation.nearestOverlay: ${nearest == OverlayChildLocation.nearestOverlay}');

  // Test with OverlayPortal
  print('\n--- Testing with OverlayPortal ---');
  final controller = OverlayPortalController();
  final portal = OverlayPortal(
    controller: controller,
    overlayChildBuilder: (context) {
      return Positioned(
        right: 10,
        top: 10,
        child: Container(
          padding: EdgeInsets.all(8),
          color: Colors.red,
          child: Text('Root overlay'),
        ),
      );
    },
    child: Text('Anchor'),
  );
  print('Created OverlayPortal');
  print('OverlayChildLocation used by Overlay.wrap');

  // When to use each
  print('\n--- When to use each ---');
  print('nearestOverlay: local overlays, dialogs');
  print('rootOverlay: global overlays, tooltips');
  print('root escapes nested Navigators');

  // Overlay hierarchy
  print('\n--- Overlay hierarchy ---');
  print('MaterialApp creates root Overlay');
  print('Navigator may create nested Overlays');
  print('nearestOverlay finds closest ancestor');
  print('rootOverlay always uses top-level');

  print('\n' + '=' * 50);
  print('OverlayChildLocation test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'OverlayChildLocation Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('nearestOverlay.index: ${nearest.index}'),
      Text('rootOverlay.index: ${root.index}'),
      Text('Values: ${OverlayChildLocation.values.length}'),
      portal,
    ],
  );
}
