// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OverlayPortalController from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OverlayPortalController test executing');
  print('=' * 50);

  // === Test OverlayPortalController class ===
  print('\nOverlayPortalController controls OverlayPortal visibility');

  // Create OverlayPortalController
  print('\n--- Testing creation ---');
  final controller = OverlayPortalController();
  print('Created OverlayPortalController');
  print('controller.runtimeType: ${controller.runtimeType}');

  // Create with debugLabel
  print('\n--- Testing debugLabel ---');
  final labeledController = OverlayPortalController(debugLabel: 'myOverlay');
  print('Created with debugLabel: "myOverlay"');
  print('labeledController.runtimeType: ${labeledController.runtimeType}');

  // Test isShowing property
  print('\n--- Testing isShowing ---');
  print('controller.isShowing: ${controller.isShowing}');
  print('Default is false until attached and shown');

  // Test show method
  print('\n--- Testing show method ---');
  print('controller.show() displays overlay child');
  print('Brings overlay to top if multiple portals');

  // Test hide method
  print('\n--- Testing hide method ---');
  print('controller.hide() removes overlay child');
  print('Stateful widgets may lose state');

  // Test toggle pattern
  print('\n--- Testing toggle pattern ---');
  print('if (controller.isShowing) controller.hide();');
  print('else controller.show();');

  // Test with OverlayPortal
  print('\n--- Testing with OverlayPortal ---');
  final portal = OverlayPortal(
    controller: controller,
    overlayChildBuilder: (context) {
      return Positioned(
        left: 100,
        top: 100,
        child: Container(
          width: 200,
          height: 100,
          color: Colors.blue,
          child: Center(child: Text('Overlay content')),
        ),
      );
    },
    child: ElevatedButton(
      onPressed: () => controller.show(),
      child: Text('Show overlay'),
    ),
  );
  print('Created OverlayPortal with controller');

  // Lifecycle considerations
  print('\n--- Lifecycle considerations ---');
  print('Controller must be attached to OverlayPortal');
  print('Cannot be attached to multiple portals');

  print('\n' + '=' * 50);
  print('OverlayPortalController test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'OverlayPortalController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('isShowing: ${controller.isShowing}'),
      Text('Methods: show(), hide()'),
      portal,
    ],
  );
}
