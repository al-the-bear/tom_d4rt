// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Overlay, OverlayEntry, OverlayPortal,
// OverlayPortalController, CompositedTransformTarget, CompositedTransformFollower
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Overlay/Portal test executing');

  // ========== OverlayEntry ==========
  print('--- OverlayEntry Tests ---');
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 100,
      left: 50,
      child: Material(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.yellow,
          child: Text('Overlay content'),
        ),
      ),
    ),
    maintainState: false,
    opaque: false,
  );
  print('OverlayEntry created');
  print('  opaque: ${overlayEntry.opaque}');
  print('  maintainState: ${overlayEntry.maintainState}');
  print('  mounted: ${overlayEntry.mounted}');

  // ========== OverlayPortalController ==========
  print('--- OverlayPortalController Tests ---');
  final portalController = OverlayPortalController();
  print('OverlayPortalController created');
  print('  isShowing: ${portalController.isShowing}');

  // ========== OverlayPortal ==========
  print('--- OverlayPortal Tests ---');
  final overlayPortal = OverlayPortal(
    controller: portalController,
    overlayChildBuilder: (context) =>
        Positioned(top: 0, left: 0, child: Text('Portal overlay')),
    child: Text('Portal child'),
  );
  print('OverlayPortal created: $overlayPortal');

  // ========== LayerLink for Composited widgets ==========
  print('--- LayerLink Tests ---');
  final layerLink = LayerLink();
  print('LayerLink created');

  // ========== CompositedTransformTarget ==========
  print('--- CompositedTransformTarget Tests ---');
  final target = CompositedTransformTarget(
    link: layerLink,
    child: Container(
      width: 100,
      height: 50,
      color: Colors.blue,
      child: Text('Target'),
    ),
  );
  print('CompositedTransformTarget created: $target');

  // ========== CompositedTransformFollower ==========
  print('--- CompositedTransformFollower Tests ---');
  final follower = CompositedTransformFollower(
    link: layerLink,
    offset: Offset(0, 55),
    showWhenUnlinked: false,
    targetAnchor: Alignment.bottomLeft,
    followerAnchor: Alignment.topLeft,
    child: Material(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(8),
        color: Colors.green,
        child: Text('Follower'),
      ),
    ),
  );
  print('CompositedTransformFollower created: $follower');
  print('  showWhenUnlinked: false');
  print('  targetAnchor: Alignment.bottomLeft');
  print('  followerAnchor: Alignment.topLeft');

  // ========== Overlay widget ==========
  print('--- Overlay Tests ---');
  final overlayWidget = Overlay(
    initialEntries: [OverlayEntry(builder: (context) => Text('Initial entry'))],
  );
  print('Overlay created with initial entries: $overlayWidget');

  print('All overlay/portal tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Stack(
        children: [
          Column(children: [target, follower]),
          overlayPortal,
        ],
      ),
    ),
  );
}
