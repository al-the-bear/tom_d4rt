// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RawMenuOverlayInfo from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('RawMenuOverlayInfo test executing');
  print('=' * 50);

  // === Test RawMenuOverlayInfo ===
  print('\nRawMenuOverlayInfo provides menu positioning data');

  // Create RawMenuOverlayInfo
  print('\n--- Creating RawMenuOverlayInfo ---');
  final info = RawMenuOverlayInfo(
    anchorRect: const ui.Rect.fromLTWH(100, 100, 50, 30),
    overlaySize: const ui.Size(800, 600),
    tapRegionGroupId: Object(),
  );
  print('Created RawMenuOverlayInfo');
  print('anchorRect: ${info.anchorRect}');
  print('overlaySize: ${info.overlaySize}');

  // Properties
  print('\n--- Properties ---');
  print('anchorRect: ui.Rect - anchor position');
  print('overlaySize: ui.Size - overlay dimensions');
  print('position: Offset? - offset from anchor');
  print('tapRegionGroupId: Object - tap region group');

  // With position
  print('\n--- With position ---');
  final infoWithPos = RawMenuOverlayInfo(
    anchorRect: const ui.Rect.fromLTWH(100, 100, 50, 30),
    overlaySize: const ui.Size(800, 600),
    tapRegionGroupId: Object(),
    position: const Offset(10, 5),
  );
  print('position: ${infoWithPos.position}');
  print('Used to offset menu from anchor');

  // Equality
  print('\n--- Equality ---');
  print('Compares all four properties');
  print('Same values = equal objects');
  print('hashCode: Object.hash of all');

  // Usage in RawMenuAnchor
  print('\n--- Usage in RawMenuAnchor ---');
  print('overlayBuilder receives RawMenuOverlayInfo');
  print('Use anchorRect for positioning');
  print('Use overlaySize for constraints');

  // TapRegion integration
  print('\n--- TapRegion integration ---');
  print('tapRegionGroupId groups menu items');
  print('Taps outside group close menu');


  // Menu positioning
  print('\n--- Menu positioning ---');
  print('anchorRect: where to attach');
  print('overlaySize: available space');
  print('Build menu to fit within overlay');

  // RawMenuAnchor builder
  print('\n--- RawMenuAnchor.overlayBuilder ---');
  print('Widget Function(BuildContext, RawMenuOverlayInfo)');
  print('Position menu based on info');
  print('Use Positioned or Align');

  print('\n' + '=' * 50);
  print('RawMenuOverlayInfo test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawMenuOverlayInfo Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('anchorRect: ${info.anchorRect}'),
      Text('overlaySize: ${info.overlaySize}'),
      Text('tapRegionGroupId: present'),
    ],
  );
}
